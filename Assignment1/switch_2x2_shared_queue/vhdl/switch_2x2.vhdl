--quebase of 1024 word storage
library ieee;
use ieee.std_logic_1164.all;

entity QueueBase is
	generic(queue_depth: integer := 1024; data_width: integer := 33;
		save_one_slot: boolean := false);
	port(clk: in std_logic;
	     reset: in std_logic;
	     data_in: in std_logic_vector(data_width-1 downto 0);
	     push_req: in std_logic;
	     push_ack: out std_logic;
	     data_out: out std_logic_vector(data_width-1 downto 0);
	     pop_ack : out std_logic;
	     pop_req: in std_logic);
end entity QueueBase;

architecture behave of QueueBase is

	type QueueArray is array(natural range <>) of std_logic_vector(data_width-1 downto 0);

	-- data memory for queue entries.
	signal queue_array : QueueArray(queue_depth-1 downto 0);

	-- read/write pointers (registers)
	signal read_pointer, write_pointer: integer range 0 to queue_depth - 1;

	-- queue size register (it is possible to implement the queue without using queue_size also).
	signal queue_size: integer range 0 to queue_depth;
begin  -- SimModel

	process(clk, reset, push_req, pop_req, read_pointer, write_pointer, queue_size, data_in, queue_array)
		variable next_queue_size_var: integer range 0 to queue_depth;
		variable next_read_pointer_var, next_write_pointer_var: integer range 0 to queue_depth-1;
		variable data_out_var : std_logic_vector(data_width-1 downto 0);
		variable push_ack_var, pop_ack_var : std_logic;
	begin
		-------------------------------------------------------------------------
		-- Defaults
		-------------------------------------------------------------------------
		next_queue_size_var := queue_size;
		next_read_pointer_var := read_pointer;
		next_write_pointer_var := write_pointer;
		push_ack_var := '0';
		pop_ack_var  := '0';

		-------------------------------------------------------------------------
		-- accept push if queue has room
		-------------------------------------------------------------------------
		if(queue_size < queue_depth) then
			push_ack_var := '1';
		end if;

		-------------------------------------------------------------------------
		-- accept pop if queue has data
		-------------------------------------------------------------------------
		if(queue_size > 0) then
			pop_ack_var := '1';
		end if;

		-------------------------------------------------------------------------
		-- calculate next write pointer
		-------------------------------------------------------------------------
		if(push_req = '1') then
			if(push_ack_var = '1') then
				if(write_pointer = queue_depth-1) then
					next_write_pointer_var := 0;
				else 
					next_write_pointer_var := write_pointer + 1;
				end if;
			end if;
		end if;

		-------------------------------------------------------------------------
		-- calculate next read pointer
		-------------------------------------------------------------------------
		if(pop_req = '1') then
			if(pop_ack_var = '1') then
				if(read_pointer = queue_depth-1) then
					next_read_pointer_var := 0;
				else 
					next_read_pointer_var := read_pointer + 1;
				end if;
			end if;
		end if;

		-------------------------------------------------------------------------
		-- calculate next queue size
		-------------------------------------------------------------------------
		if((push_ack_var = '1')  and (pop_ack_var = '0')) then
			next_queue_size_var := queue_size + 1;
		elsif ((push_ack_var = '0') and (pop_ack_var = '1')) then
			next_queue_size_var := queue_size - 1;
		end if;

		-------------------------------------------------------------------------
		-- combinational outputs..
		-------------------------------------------------------------------------
		push_ack <= push_ack_var;
		pop_ack  <= pop_ack_var;


		-------------------------------------------------------------------------
		-- top of queue.
		-------------------------------------------------------------------------
		data_out <= queue_array (read_pointer);

		-------------------------------------------------------------------------
		-- update registers
		-------------------------------------------------------------------------
		if (clk'event and  (clk = '1')) then
			if(reset = '1') then
				read_pointer <= 0;
				write_pointer <= 0;
				queue_size   <= 0;
			else
				read_pointer <= next_read_pointer_var;
				write_pointer <= next_write_pointer_var;
				queue_size <= next_queue_size_var;

				----------------------------------------------------------
				-- update memory entry.
				----------------------------------------------------------
				if (push_req = '1') and (push_ack_var = '1') then
					queue_array (write_pointer) <= data_in;
				end if;
			end if;
		end if;

	end process;

end behave;

--flag registers to monitor validation of data in quebase
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flag_register is
	port(
		clk       : in  std_logic;
		reset     : in  std_logic;
		add_flag  : in  std_logic;
		sub_flag  : in  std_logic;
		pkt_valid : out std_logic
	);
end entity flag_register;

architecture rtl4 of flag_register is
	signal count : unsigned(7 downto 0) := (others => '0');
begin

	process(clk, reset)
	begin
	if reset = '1' then
		count <= (others => '0');
	elsif rising_edge(clk) then
		if add_flag = '1' then
			count <= count + 1;
		end if;		
		if sub_flag = '1' then
			if count > 0 then
				count <= count - 1;
			end if;
		end if;
	end if;
	end process;
	pkt_valid <= '1' when count > 0 else '0';

end architecture rtl4;

--Input Arbiter
--Designed to take input from both the ports
--as soon as data arrived at any port it loads all the data from that port
--Designed FSM for the process
--As soon as data arrives connection between port and queue locks for that much of packet length
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input_arbiter is
port(
    clk   : in std_logic;
    reset : in std_logic;
	 
    in1_data : in std_logic_vector(31 downto 0);
    in1_req  : in std_logic;
    in1_ack  : out std_logic;

    in2_data : in std_logic_vector(31 downto 0);
    in2_req  : in std_logic;
    in2_ack  : out std_logic;

    q_data : out std_logic_vector(32 downto 0);
    q_push_req : out std_logic;
    q_push_ack : in std_logic;
	 q_add_flag : out std_logic
);
end entity;

architecture rtl of input_arbiter is

	type state_type is (WAIT_HEADER, SEND_PACKET_From1, SEND_PACKET_From2, WAIT_BUFFER);
	signal state : state_type;

	signal dest       : std_logic;
	signal pkt_count  : unsigned(15 downto 0);
	
begin
	
	process(clk, reset, in1_req, in2_req)
	begin
		
		if reset ='1' then 
			
			state <= WAIT_HEADER;
			pkt_count <= (others=>'0');
			
			q_push_req <= '0';
			in1_ack <= '0';
			in2_ack <= '0';
			q_add_flag <= '0';
			
		elsif rising_edge(clk) then
		
			q_push_req <= '0';
			in1_ack <= '0';
			in2_ack <= '0';
			q_data <= (others => '0');
			q_add_flag <= '0';
			
			case state is
			
			when WAIT_HEADER =>
			
			
				if in1_req='1' then
				
					--dest <= in1_data(24);
					if in1_data(25 downto 24) = "01" then
						dest <= '0';
					elsif in1_data(25 downto 24) = "10" then
						dest <= '1';
					end if;
					--q_push_req <= in1_req;
					in1_ack <= '1';
					pkt_count <= unsigned(in1_data(23 downto 8));
					--q_data <= in1_data(24) & in1_data;
					state <= SEND_PACKET_From1;
					q_add_flag <= '1';
					
				elsif in2_req='1' then
				
					--dest <= in2_data(24);
					if in2_data(25 downto 24) = "01" then
						dest <= '0';
					elsif in2_data(25 downto 24) = "10" then
						dest <= '1';
					end if;
					--q_push_req <= in2_req;
					in2_ack <= '1';
					pkt_count <= unsigned(in2_data(23 downto 8));
					--q_data <= in1_data(24) & in2_data;
					state <= SEND_PACKET_From2;
					q_add_flag <= '1';
					
				else
					state <= WAIT_HEADER;
				end if;
				
			when SEND_PACKET_From1 =>
			
				q_push_req <= in1_req;
				q_data <= dest & in1_data;
				in1_ack <= q_push_ack;
				q_add_flag <= '0';
			
				if in1_req='1' then					
					if q_push_ack = '1' then
						pkt_count <= pkt_count - 1;
						if pkt_count = 1 then
                       state <= WAIT_BUFFER;
							  in1_ack <= '0';
                  end if;
					end if;
				else
					state <= WAIT_BUFFER;
				end if;
				
			when SEND_PACKET_From2 =>
			
				q_push_req <= in2_req;
				q_data <= dest & in2_data;
				in2_ack <= q_push_ack;
				q_add_flag <= '0';
			
				if in2_req='1' then					
					if q_push_ack = '1' then
						pkt_count <= pkt_count - 1;
						if pkt_count = 1 then
                       state <= WAIT_BUFFER;
							  in2_ack <= '0';
                  end if;
					end if;
				else
					state <= WAIT_BUFFER;
				end if;
				
			when WAIT_BUFFER =>
				q_push_req <= '0';
				in1_ack <= '0';
				in2_ack <= '0';
				q_data <= (others => '0');
				state <= WAIT_HEADER;
				q_add_flag <= '0';
				
			when others => null;
			
			end case;
		end if;
	end process;
end architecture;




--output demux
--Designed to take data out from queue and throw the data at output ports
--Observe the ouput of queue and valid signal then throw the data at output ports
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity output_demux is
port(
    clk   : in std_logic;
    reset : in std_logic;

    q_data : in std_logic_vector(32 downto 0);
    q_pop_req : out std_logic;
    q_pop_ack : in std_logic;
	 q_subb_flag : out std_logic;
	 q_valid_flag : in std_logic;

    out1_data : out std_logic_vector(31 downto 0);
    out1_req  : in std_logic;
    out1_ack  : out std_logic;

    out2_data : out std_logic_vector(31 downto 0);
    out2_req  : in std_logic;
    out2_ack  : out std_logic
);
end entity;

architecture simple of output_demux is

	type state_type is (WAIT_OUT, SEND_PACKET_TO1, SEND_PACKET_TO2, WAIT_BUFFER);
	signal state : state_type;

	signal dst : integer range 0 to 2 := 0;
	signal pkt_count : unsigned(15 downto 0);

begin

process(clk,reset)
begin

	if reset='1' then

		 dst <= 0;
		 q_pop_req <= '0';
		 out1_ack <= '0';
		 out2_ack <= '0';
		 state <= WAIT_OUT;
		 q_subb_flag <= '0';

	elsif rising_edge(clk) then

		 q_pop_req <= '0';
		 out1_ack <= '0';
		 out2_ack <= '0';
		 q_subb_flag <= '0';

		 --------------------------------
		 -- select output
		 --------------------------------
		 case state is
		 
		 when WAIT_OUT =>

				  if q_valid_flag = '1' then
					  if q_data(32)='0' and out1_req='1' then
							dst <= 1;
							pkt_count <= unsigned(q_data(23 downto 8)) + 1;
							state <= SEND_PACKET_TO1;
							q_pop_req <= out1_req;
							q_subb_flag <= '1';
							--out1_data <= q_data(31 downto 0);
					  elsif q_data(32)='1' and out2_req='1' then
							dst <= 2;
							pkt_count <= unsigned(q_data(23 downto 8)) + 1;
							state <= SEND_PACKET_TO2;
							q_pop_req <= out2_req;
							q_subb_flag <= '1';
							--out2_data <= q_data(31 downto 0);
						else
							state <= WAIT_OUT;
					  end if;
					end if;
			 
		when SEND_PACKET_TO1 =>
		 
			  q_pop_req <= out1_req;
			  out1_ack <= q_pop_ack;
			  out1_data <= q_data(31 downto 0);
			  q_subb_flag <= '0';
			  
			  if out1_req = '1' then
					if q_pop_ack='1' then
						pkt_count <= pkt_count - 1;
						if pkt_count = 2 then
								state <= WAIT_BUFFER;
								q_pop_req <= '0';
						end if;
					end if;
				--else
					--state <= WAIT_BUFFER;
				end if;

		 when SEND_PACKET_TO2 =>
		 
			  q_pop_req <= out2_req;
			  out2_ack <= q_pop_ack;
			  out2_data <= q_data(31 downto 0);
			  q_subb_flag <= '0';

			  if out2_req = '1' then
					if q_pop_ack='1' then
						pkt_count <= pkt_count - 1;
						if pkt_count = 2 then
								state <= WAIT_BUFFER;
								q_pop_req <= '0';
						end if;
					end if;
				--else
					--state <= WAIT_BUFFER;
				end if;
			
			when WAIT_BUFFER =>
				q_pop_req <= '0';
				out1_ack <= '0';
				out2_ack <= '0';
				out1_data <= (others => '0');
				out2_data <= (others => '0');
				state <= WAIT_OUT;
				q_subb_flag <= '0';
				
			when others => null;
			
			end case;
		
	end if;

end process;

end architecture;


--top level
library ieee;
use ieee.std_logic_1164.all;

entity switch_2x2 is
	generic(queue_depth: integer := 1; data_width: integer := 32);
    port (
      clk                      : in  std_logic;
      reset                    : in  std_logic;

      in_data_1_pipe_write_data: in  std_logic_vector(31 downto 0);
      in_data_1_pipe_write_req : in  std_logic_vector(0 downto 0);
      in_data_1_pipe_write_ack : out std_logic_vector(0 downto 0);

      in_data_2_pipe_write_data: in  std_logic_vector(31 downto 0);
      in_data_2_pipe_write_req : in  std_logic_vector(0 downto 0);
      in_data_2_pipe_write_ack : out std_logic_vector(0 downto 0);

      out_data_1_pipe_read_data: out std_logic_vector(31 downto 0);
      out_data_1_pipe_read_req : in  std_logic_vector(0 downto 0);
      out_data_1_pipe_read_ack : out std_logic_vector(0 downto 0);

      out_data_2_pipe_read_data: out std_logic_vector(31 downto 0);
      out_data_2_pipe_read_req : in  std_logic_vector(0 downto 0);
      out_data_2_pipe_read_ack : out std_logic_vector(0 downto 0)
    );
end entity switch_2x2;

architecture struct of switch_2x2 is

	component QueueBase is
		port(
			clk     : in  std_logic;
			reset   : in  std_logic;
			data_in : in  std_logic_vector(32 downto 0);
			push_req: in  std_logic;
			push_ack: out std_logic;
			data_out: out std_logic_vector(32 downto 0);
			pop_ack : out std_logic;
			pop_req : in  std_logic
		);
	end component;

	component input_arbiter is
		port(
			clk   : in std_logic;
			reset : in std_logic;

			in1_data : in std_logic_vector(31 downto 0);
			in1_req  : in std_logic;
			in1_ack  : out std_logic;

			in2_data : in std_logic_vector(31 downto 0);
			in2_req  : in std_logic;
			in2_ack  : out std_logic;

			q_data : out std_logic_vector(32 downto 0);
			q_push_req : out std_logic;
			q_push_ack : in std_logic;
			q_add_flag : out std_logic
		);
	end component;

	component output_demux is
		port(
			clk   : in std_logic;
			reset : in std_logic;

			q_data : in std_logic_vector(32 downto 0);
			q_pop_req : out std_logic;
			q_pop_ack : in std_logic;
			q_subb_flag : out std_logic;
			q_valid_flag : in std_logic;

			out1_data : out std_logic_vector(31 downto 0);
			out1_req  : in std_logic;
			out1_ack  : out std_logic;

			out2_data : out std_logic_vector(31 downto 0);
			out2_req  : in std_logic;
			out2_ack  : out std_logic
		);
	end component;
	
	component flag_register is
		port(
			clk       : in  std_logic;
			reset     : in  std_logic;
			add_flag  : in  std_logic;
			sub_flag  : in  std_logic;
			pkt_valid : out std_logic
		);
	end component flag_register;

	-- Internal signals
	signal q_data_in  : std_logic_vector(32 downto 0);
	signal q_data_out : std_logic_vector(32 downto 0);

	signal q_push_req : std_logic;
	signal q_push_ack : std_logic;

	signal q_pop_req  : std_logic;
	signal q_pop_ack  : std_logic;

	signal in1_ack_s : std_logic;
	signal in2_ack_s : std_logic;

	signal out1_ack_s : std_logic;
	signal out2_ack_s : std_logic;
	
	signal q_add_flag_out, q_add_flag_in, q_valid_flag, q_subb_flag : std_logic;

begin

	-- Convert single bit signals
	in_data_1_pipe_write_ack(0) <= in1_ack_s;
	in_data_2_pipe_write_ack(0) <= in2_ack_s;

	out_data_1_pipe_read_ack(0) <= out1_ack_s;
	out_data_2_pipe_read_ack(0) <= out2_ack_s;
	
	process(clk)
	begin
		if rising_edge(clk) then
			q_add_flag_in <= q_add_flag_out;
		end if;
	end process;

	-------------------------------------------------
	-- Queue
	-------------------------------------------------
	Que : QueueBase
	port map(
		clk      => clk,
		reset    => reset,
		data_in  => q_data_in,
		push_req => q_push_req,
		push_ack => q_push_ack,
		data_out => q_data_out,
		pop_req  => q_pop_req,
		pop_ack  => q_pop_ack
	);
	
	--
	--flags
	----------------------
	flag : flag_register
	port map(
		clk       => clk,
		reset     => reset,
		add_flag  => q_add_flag_in,
		sub_flag  => q_subb_flag,
		pkt_valid => q_valid_flag
	);

	-------------------------------------------------
	-- Input Arbiter
	-------------------------------------------------
	inputA : input_arbiter
	port map(
		clk      => clk,
		reset    => reset,
		in1_data => in_data_1_pipe_write_data,
		in1_req  => in_data_1_pipe_write_req(0),
		in1_ack  => in1_ack_s,

		in2_data => in_data_2_pipe_write_data,
		in2_req  => in_data_2_pipe_write_req(0),
		in2_ack  => in2_ack_s,

		q_data     => q_data_in,
		q_push_req => q_push_req,
		q_push_ack => q_push_ack,
		q_add_flag => q_add_flag_out
	);

	-------------------------------------------------
	-- Output Demux
	-------------------------------------------------
	outputA : output_demux
	port map(
		clk => clk,
		reset => reset,

		q_data => q_data_out,
		q_pop_req => q_pop_req,
		q_pop_ack => q_pop_ack,
		q_subb_flag => q_subb_flag,
		q_valid_flag => q_valid_flag,

		out1_data => out_data_1_pipe_read_data,
		out1_req  => out_data_1_pipe_read_req(0),
		out1_ack  => out1_ack_s,

		out2_data => out_data_2_pipe_read_data,
		out2_req  => out_data_2_pipe_read_req(0),
		out2_ack  => out2_ack_s
	);

end architecture struct;
