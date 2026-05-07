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

--Input taker module for queue
--As soon as data arrives it loads all the data with destination in queue
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Input_taker is
port(

    clk   : in std_logic;
    reset : in std_logic;
    -- input pipe
    in_data : in std_logic_vector(31 downto 0);
    in_req  : in std_logic;
    in_ack  : out std_logic;
    -- output pipe
    q_data     : out std_logic_vector(32 downto 0);
    q_push_req : out std_logic;
    q_push_ack : in  std_logic;
	 q_add      : out std_logic

);
end Input_taker;

architecture rtl3 of Input_taker is

	type state_type is (WAIT_HEADER, SEND_PACKET, WAIT_BUFFER);

	signal state : state_type;

	signal dest       : std_logic;
	signal pkt_count  : unsigned(15 downto 0);

begin

process(clk, reset, in_req)
begin

if reset='1' then

    state <= WAIT_HEADER;
    pkt_count <= (others=>'0');

    q_push_req <= '0';
    in_ack <= '0';

elsif rising_edge(clk) then

    q_push_req <= '0';
    in_ack <= '0';
	 q_add <= '0';

    case state is

    when WAIT_HEADER =>
	 
		q_push_req <= '0';
		q_data <= (others => '0');
		in_ack <= '0';

        if in_req='1' then
            dest <= in_data(24);
            pkt_count <= unsigned(in_data(23 downto 8));
				--dest <= in_data(24);
				if in_data(25 downto 24) = "01" then
					dest <= '0';
				elsif in_data( 25 downto 24) = "10" then
					dest <= '1';
				end if;
				in_ack <= '1';
                --q_data <= dest & in_data;
                --q_push_req <= in_req;
				state <= SEND_PACKET;
				q_add <= '1';
			else
				state<=WAIT_HEADER;
			end if;


    when SEND_PACKET =>
		
			q_push_req <= in_req;
			q_data <= dest & in_data;
			in_ack <= q_push_ack;
			q_add <= '0';

			if in_req='1' then
				if q_push_ack='1' then
					pkt_count <= pkt_count - 1;
					if pkt_count = 1 then
						state <= WAIT_BUFFER;
					end if;
				end if;
			end if;
			
	 when WAIT_BUFFER =>
			state <= WAIT_HEADER;
			in_ack <= '0';
			q_push_req <= '0';
			q_add <= '0';
			
	 when others => null;
	 
    end case;

end if;

end process;

end architecture rtl3;

--output demux designed to give path for data to various ports
--Designed fsm will observe valid signal in and route the data to ouput paths
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity output_demux is
	port(
			clk : in std_logic;
			reset : in std_logic;
			
			in_req : out std_logic;
			in_ack : in std_logic;
			in_data : in std_logic_vector(32 downto 0);
			in_valid : in std_logic;
			q_subb   : out std_logic;
			
			q1_req : in std_logic;
			q1_ack : out std_logic;
			q1_data : out std_logic_vector(31 downto 0);
			q1_ready : out std_logic;
			q1_done : out std_logic;
			
			q2_req : in std_logic;
			q2_ack : out std_logic;
			q2_data : out std_logic_vector(31 downto 0);
			q2_ready : out std_logic;
			q2_done : out std_logic);
			
end entity output_demux;

architecture bhv1 of output_demux is

	type state_type is (WAIT_REQ, SEND_PACKET_TO1, SEND_PACKET_TO2, WAIT_BUFFER);

	signal state : state_type;

	signal dest       : std_logic;
	signal pkt_count  : unsigned(15 downto 0);
	
begin

	process(clk, reset)
	begin
		
		if reset = '1' then
		
			state <= WAIT_REQ;
			pkt_count <= (others => '0');
			
			in_req <= '0';
			q_subb <= '0';
			
			q1_ack <= '0';
			q1_ready <= '0';
			q1_done <= '0';
			q1_data <= (others => '0');
			
			q2_ack <= '0';
			q2_ready <= '0';
			q2_done <= '0';
			q2_data <= (others => '0');
		
		elsif rising_edge(clk) then
		
			in_req <= '0';
			
			q1_ack <= '0';
			q1_ready <= '0';
			q1_done <= '0';
			q1_data <= (others => '0');
			
			q2_ack <= '0';
			q2_ready <= '0';
			q2_done <= '0';
			q2_data <= (others => '0');
			
			case state is
			
				when WAIT_REQ =>
					
					if in_valid = '1' then
						dest <= in_data(32);
						
						if in_data(32) = '0' then
							q1_ready <= '1';
						elsif in_data(32) = '1' then
							q2_ready <= '1';
						end if;
						
						if q1_req = '1' then
							if in_data(32) = '0' then		
								dest <= in_data(32);
								pkt_count <= unsigned(in_data(23 downto 8));
								state <= SEND_PACKET_TO1;
								q_subb<='1';
								in_req <= q1_req;
								q1_data <= in_data(31 downto 0);
							end if;
						end if;

						if q2_req = '1' then
							if in_data(32) = '1' then		
								dest <= in_data(32);
								pkt_count <= unsigned(in_data(23 downto 8));
								state <= SEND_PACKET_TO2;
								q_subb<='1';
								in_req <= q2_req;
								q2_data <= in_data(31 downto 0);
							end if;
						end if;
					end if;
				
				when SEND_PACKET_TO1 =>
				
					q1_data <= in_data(31 downto 0);
					q1_ack <= in_ack;
					in_req <= q1_req;
					q_subb<='0';
					
					if q1_req = '1' then
						if in_ack = '1' then
							pkt_count <= pkt_count-1;
							if pkt_count=1 then
								state <= WAIT_BUFFER;
								in_req <= '0';
							end if;
						end if;
					else
						state <= WAIT_BUFFER;
					end if;
				
				when SEND_PACKET_TO2 =>

					q2_data <= in_data(31 downto 0);
					q2_ack <= in_ack;
					in_req <= q2_req;
					q_subb<='0';
					
					if q2_req = '1' then
						if in_ack = '1' then
							pkt_count <= pkt_count-1;
							if pkt_count=1 then
								state <= WAIT_BUFFER;
								in_req <= '0';
							end if;
						end if;
					else
						state <= WAIT_BUFFER;
					end if;
				
				when WAIT_BUFFER =>
				
					in_req<='0';
					q_subb<='0';			
					if dest = '0' then
						q1_done <= '1';
						q1_ack <= '0';
						q1_ready <= '0';
						q1_data <= (others => '0');
					end if;
					if dest = '1' then
						q2_done <= '1';
						q2_ack <= '0';
						q2_ready <= '0';
						q2_data <= (others => '0');
					end if;
					
					if pkt_count = 0 then
						pkt_count <= pkt_count-1;
					else
						state <= WAIT_REQ;
					end if;
				
				when others => null;
			
			end case;
		
		end if;
	
	end process;
end architecture bhv1;

--Output mux
--Observe which queue has the data and map that to output ports
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity output_mux is
	port(
			clk : in std_logic;
			reset : in std_logic;
			
			q1_req : out std_logic;
			q1_ack : in std_logic;
			q1_data : in std_logic_vector(31 downto 0);
			q1_ready : in std_logic;
			q1_done : in std_logic;
			
			q2_req : out std_logic;
			q2_ack : in std_logic;
			q2_data : in std_logic_vector(31 downto 0);
			q2_ready : in std_logic;
			q2_done : in std_logic;
			
			out_req : in std_logic;
			out_ack : out std_logic;
			out_data : out std_logic_vector(31 downto 0));
			
end entity output_mux;

architecture bhv2 of output_mux is
	
	type state_type is (WAIT_REQ, SEND_PACKET_From1, SEND_PACKET_From2, WAIT_BUFFER);
	signal state : state_type;
	
begin
	process(clk, reset)
	begin
		
		if reset = '1' then
		
			out_ack <='0';
			out_data <= (others => '0');
			q1_req <= '0';
			q2_req <= '0';
			state <= WAIT_REQ;
			
		elsif rising_edge(clk) then
		
			out_ack <='0';
			out_data <= (others => '0');
			q1_req <= '0';
			q2_req <= '0';	
				
			case state is 
				
				when WAIT_REQ =>
				
					if out_req = '1' then
						if q1_ready = '1' then
							q1_req <= out_req;
							out_data <= q1_data;
							out_ack <= q1_ack;
							state <= SEND_PACKET_From1;
						elsif q2_ready = '1' then
							q2_req <= out_req;
							out_data <= q2_data;
							out_ack <= q2_ack;
							state <= SEND_PACKET_From2;
						else
							state <= WAIT_REQ;
						end if;
					end if;
				
				when SEND_PACKET_From1 =>
				
					q1_req <= out_req;
					out_data <= q1_data;
					out_ack <= q1_ack;
					
					if q1_done = '1' then
						state <= WAIT_BUFFER;
						q1_req <= '0';
						out_ack <= '0';
					end if;

				when SEND_PACKET_From2 =>
				
					q2_req <= out_req;
					out_data <= q2_data;
					out_ack <= q2_ack;
					
					if q2_done = '1' then
						state <= WAIT_BUFFER;
						q2_req <= '0';
						out_ack <= '0';
					end if;
				
			when WAIT_BUFFER =>
				out_ack <= '0';
				q1_req <= '0';
				q2_req <= '0';
				state <= WAIT_REQ;
			when others => null;	
			
			end case;
		
		end if;
	
	end process;

end architecture bhv2;

--Top Level
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity switch_2x2 is
		port (
			     clk : in std_logic;
			     reset : in std_logic;
			     in_data_1_pipe_write_data: in std_logic_vector(31 downto 0);
			     in_data_1_pipe_write_req : in std_logic_vector(0 downto 0);
			     in_data_1_pipe_write_ack : out std_logic_vector(0 downto 0);
			     in_data_2_pipe_write_data: in std_logic_vector(31 downto 0);
			     in_data_2_pipe_write_req : in std_logic_vector(0 downto 0);
			     in_data_2_pipe_write_ack : out std_logic_vector(0 downto 0);
			     out_data_1_pipe_read_data: out std_logic_vector(31 downto 0);
			     out_data_1_pipe_read_req : in std_logic_vector(0 downto 0);
			     out_data_1_pipe_read_ack : out std_logic_vector(0 downto 0);
			     out_data_2_pipe_read_data: out std_logic_vector(31 downto 0);
			     out_data_2_pipe_read_req : in std_logic_vector(0 downto 0);
			     out_data_2_pipe_read_ack : out std_logic_vector(0 downto 0)); 
											   -- 
end entity switch_2x2; 

architecture struct of switch_2x2 is
		
	component Input_taker is
	port(

		 clk   : in std_logic;
		 reset : in std_logic;
		 -- input pipe
		 in_data : in std_logic_vector(31 downto 0);
		 in_req  : in std_logic;
		 in_ack  : out std_logic;
		 -- output pipe
		 q_data     : out std_logic_vector(32 downto 0);
		 q_push_req : out std_logic;
		 q_push_ack : in  std_logic;
		 q_add      : out std_logic

	);
	end component Input_taker;

	component QueueBase is
		port(clk: in std_logic;
			  reset: in std_logic;
			  data_in: in std_logic_vector(32 downto 0);
			  push_req: in std_logic;
			  push_ack: out std_logic;
			  data_out: out std_logic_vector(32 downto 0);
			  pop_ack : out std_logic;
			  pop_req: in std_logic);
	end component QueueBase;
	
	component flag_register is
		port(
			clk       : in  std_logic;
			reset     : in  std_logic;
			add_flag  : in  std_logic;
			sub_flag  : in  std_logic;
			pkt_valid : out std_logic
		);
	end component flag_register;
	
	component output_demux is
		port(
				clk : in std_logic;
				reset : in std_logic;
				
				in_req : out std_logic;
				in_ack : in std_logic;
				in_data : in std_logic_vector(32 downto 0);
				in_valid : in std_logic;
				q_subb   : out std_logic;
				
				q1_req : in std_logic;
				q1_ack : out std_logic;
				q1_data : out std_logic_vector(31 downto 0);
				q1_ready : out std_logic;
				q1_done : out std_logic;
				
				q2_req : in std_logic;
				q2_ack : out std_logic;
				q2_data : out std_logic_vector(31 downto 0);
				q2_ready : out std_logic;
				q2_done : out std_logic);
				
	end component output_demux;
	
	component output_mux is
		port(
				clk : in std_logic;
				reset : in std_logic;
				
				q1_req : out std_logic;
				q1_ack : in std_logic;
				q1_data : in std_logic_vector(31 downto 0);
				q1_ready : in std_logic;
				q1_done : in std_logic;
				
				q2_req : out std_logic;
				q2_ack : in std_logic;
				q2_data : in std_logic_vector(31 downto 0);
				q2_ready : in std_logic;
				q2_done : in std_logic;
				
				out_req : in std_logic;
				out_ack : out std_logic;
				out_data : out std_logic_vector(31 downto 0));
				
	end component output_mux;
	
	--Q1 signals
	signal q1_data_in, q1_data_out : std_logic_vector(32 downto 0);
	signal q1_push_req, q1_push_ack, q1_pop_ack, q1_pop_req : std_logic;
	
	--Q2 signals
	signal q2_data_in, q2_data_out : std_logic_vector(32 downto 0);
	signal q2_push_req, q2_push_ack, q2_pop_ack, q2_pop_req : std_logic;
	
	--demux out signals
	signal Data_1To1, Data_1To2, Data_2To1, Data_2To2 : std_logic_vector(31 downto 0);
	signal req_1To1, req_1To2, req_2To1, req_2To2 : std_logic;
	signal ack_1To1, ack_1To2, ack_2To1, ack_2To2 : std_logic;
	signal ready_1To1, ready_1To2, ready_2To1, ready_2To2 : std_logic;
	signal done_1To1, done_1To2, done_2To1, done_2To2 : std_logic;
	signal q1_add_flag_in, q1_add_flag_out, q1_subb_flag, q1_valid_flag : std_logic;
	signal q2_add_flag_in, q2_add_flag_out, q2_subb_flag, q2_valid_flag : std_logic;
	
begin

	process(clk)
	begin
		if rising_edge(clk) then
			q1_add_flag_in<=q1_add_flag_out;
			q2_add_flag_in<=q2_add_flag_out;
		end if;
	end process;

	I1 : Input_taker port map(clk=>clk, reset=>reset,
										in_data=>in_data_1_pipe_write_data, in_req=>in_data_1_pipe_write_req(0), in_ack=>in_data_1_pipe_write_ack(0),
										q_data=>q1_data_in, q_push_req=>q1_push_req, q_push_ack=>q1_push_ack, q_add=>q1_add_flag_out);
							
	I2 : Input_taker port map(clk=>clk, reset=>reset,
										in_data=>in_data_2_pipe_write_data, in_req=>in_data_2_pipe_write_req(0), in_ack=>in_data_2_pipe_write_ack(0),
										q_data=>q2_data_in, q_push_req=>q2_push_req, q_push_ack=>q2_push_ack, q_add=>q2_add_flag_out);
										
	Q1 : QueueBase port map(clk=>clk, reset=>reset,
									data_in=>q1_data_in, push_req=>q1_push_req, push_ack=>q1_push_ack,
									data_out=>q1_data_out, pop_ack=>q1_pop_ack, pop_req=>q1_pop_req);
									
	Q2 : QueueBase port map(clk=>clk, reset=>reset,
									data_in=>q2_data_in, push_req=>q2_push_req, push_ack=>q2_push_ack,
									data_out=>q2_data_out, pop_ack=>q2_pop_ack, pop_req=>q2_pop_req);
		
	flag1 : flag_register
	port map(
		clk       => clk,
		reset     => reset,
		add_flag  => q1_add_flag_in,
		sub_flag  => q1_subb_flag,
		pkt_valid => q1_valid_flag
	);
	flag2 : flag_register
	port map(
		clk       => clk,
		reset     => reset,
		add_flag  => q2_add_flag_in,
		sub_flag  => q2_subb_flag,
		pkt_valid => q2_valid_flag
	);
									
	D1 : output_demux port map(clk=>clk, reset=>reset,
										in_req=>q1_pop_req, in_ack=>q1_pop_ack, in_data=>q1_data_out, in_valid=>q1_valid_flag, q_subb=>q1_subb_flag,
										q1_req=>req_1To1, q1_ack=>ack_1To1, q1_data=>Data_1To1, q1_ready=>ready_1To1, q1_done=>done_1To1,
										q2_req=>req_1To2, q2_ack=>ack_1To2, q2_data=>Data_1To2, q2_ready=>ready_1To2, q2_done=>done_1To2);
										
	D2 : output_demux port map(clk=>clk, reset=>reset,
										in_req=>q2_pop_req, in_ack=>q2_pop_ack, in_data=>q2_data_out, in_valid=>q2_valid_flag, q_subb=>q2_subb_flag,
										q1_req=>req_2To1, q1_ack=>ack_2To1, q1_data=>Data_2To1, q1_ready=>ready_2To1, q1_done=>done_2To1,
										q2_req=>req_2To2, q2_ack=>ack_2To2, q2_data=>Data_2To2, q2_ready=>ready_2To2, q2_done=>done_2To2);
										
	M1 : output_mux port map(clk=>clk, reset=>reset,
										q1_req=>req_1To1, q1_ack=>ack_1To1, q1_data=>Data_1To1, q1_ready=>ready_1To1, q1_done=>done_1To1,
										q2_req=>req_2To1, q2_ack=>ack_2To1, q2_data=>Data_2To1, q2_ready=>ready_2To1, q2_done=>done_2To1,
										out_req=>out_data_1_pipe_read_req(0), out_data=>out_data_1_pipe_read_data, out_ack=>out_data_1_pipe_read_ack(0));
	
	M2 : output_mux port map(clk=>clk, reset=>reset,
										q1_req=>req_1To2, q1_ack=>ack_1To2, q1_data=>Data_1To2, q1_ready=>ready_1To2, q1_done=>done_1To2,
										q2_req=>req_2To2, q2_ack=>ack_2To2, q2_data=>Data_2To2, q2_ready=>ready_2To2, q2_done=>done_2To2,
										out_req=>out_data_2_pipe_read_req(0), out_data=>out_data_2_pipe_read_data, out_ack=>out_data_2_pipe_read_ack(0));
									
end architecture struct;