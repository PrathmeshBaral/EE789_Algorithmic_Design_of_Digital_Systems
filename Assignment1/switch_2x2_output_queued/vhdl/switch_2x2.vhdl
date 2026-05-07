--Queue
library ieee;
use ieee.std_logic_1164.all;

entity QueueBase is
	generic(queue_depth: integer := 256; data_width: integer := 32;
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


--Flag registers
--monitors the no of packets in queue
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

architecture rtl of flag_register is
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

end architecture rtl;


-- output mux
--Connect two output ques with output ports
--Whichever queue has data will be sent out to port
--Designed FSM to communicate 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Output_mux_2x1 is
	generic(
		 data_width : integer := 32
	);
	port(

		 clk   : in std_logic;
		 reset : in std_logic;

		 -- queue1
		 q1_data     : in std_logic_vector(data_width-1 downto 0);
		 q1_pop_req  : out std_logic;
		 q1_pop_ack  : in  std_logic;
		 q1_pkt_flag : in  std_logic;
		 q1_clear    : out std_logic;

		 -- queue2
		 q2_data     : in std_logic_vector(data_width-1 downto 0);
		 q2_pop_req  : out std_logic;
		 q2_pop_ack  : in  std_logic;
		 q2_pkt_flag : in  std_logic;
		 q2_clear    : out std_logic;

		 -- output pipe
		 out_data : out std_logic_vector(data_width-1 downto 0);
		 out_req  : in  std_logic;
		 out_ack  : out std_logic
	);
end Output_mux_2x1;

architecture rtl2 of Output_mux_2x1 is

type state_type is (IDLE, SERVE_Q1, SERVE_Q2, WAIT_BUFFER);

signal state : state_type;
signal pkt_count : unsigned(15 downto 0);

begin

process(clk,reset)
begin

if reset='1' then

    state <= IDLE;
    pkt_count <= (others=>'0');

    q1_pop_req <= '0';
    q2_pop_req <= '0';
    q1_clear <= '0';
    q2_clear <= '0';
    out_ack <= '0';

elsif rising_edge(clk) then

    case state is

		when IDLE =>
	 
			if out_req = '1' then
				  if q1_pkt_flag='1' then
						state <= SERVE_Q1;
						pkt_count <= unsigned(q1_data(23 downto 8));
						out_data <= q1_data;
						q1_pop_req <= out_req;
						q1_clear <= '1';
				  elsif q2_pkt_flag='1' then
						state <= SERVE_Q2;
						pkt_count <= unsigned(q2_data(23 downto 8));
						out_data <= q2_data;
						q2_pop_req <= out_req;
						q2_clear <= '1';

				  end if;
			else
				 q1_pop_req <= '0';
				 q2_pop_req <= '0';
				 q1_clear <= '0';
				 q2_clear <= '0';
				 out_ack <= '0';

			end if;
		

		when SERVE_Q1 =>
			out_data <= q1_data;
			out_ack <= q1_pop_ack;
			q1_clear <= '0';

			if out_req='1' then
				if q1_pop_ack='1' then
					pkt_count <= pkt_count - 1;
					q1_pop_req <= out_req;
					if pkt_count=1 then
						state <= WAIT_BUFFER;
						q1_pop_req <= '0';
					end if;
				end if;
			end if;
			
		when SERVE_Q2 =>
			out_data <= q2_data;
			out_ack <= q2_pop_ack;
			q2_clear <= '0';

			if out_req='1' then
				if q2_pop_ack='1' then
					pkt_count <= pkt_count - 1;
					q2_pop_req <= out_req;
					if pkt_count=1 then
						state <= WAIT_BUFFER;
						q2_pop_req <= '0';
					end if;
				end if;
			end if;
		
		when WAIT_BUFFER =>
			out_data <= (others => '0');
			out_ack <= '0';
			q1_pop_req <= '0';
			q2_pop_req <= '0';
			state <= IDLE;
		
		when others => null;

    end case;

end if;

end process;

end rtl2;


--input demux
--Communicate with input ports and ouput queues
--the data from input port will be loaded to respective destination queues
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Input_demux_1x2 is
generic(
    data_width : integer := 32
);
port(

    clk   : in std_logic;
    reset : in std_logic;

    -- input pipe
    in_data : in std_logic_vector(data_width-1 downto 0);
    in_req  : in std_logic;
    in_ack  : out std_logic;

    -- queue A
    qA_data     : out std_logic_vector(data_width-1 downto 0);
    qA_push_req : out std_logic;
    qA_push_ack : in  std_logic;
    qA_pkt_flag : out std_logic;

    -- queue B
    qB_data     : out std_logic_vector(data_width-1 downto 0);
    qB_push_req : out std_logic;
    qB_push_ack : in  std_logic;
    qB_pkt_flag : out std_logic
);
end Input_demux_1x2;

architecture rtl3 of Input_demux_1x2 is

type state_type is (WAIT_HEADER, SEND_PACKET_TOA, SEND_PACKET_TOB,WAIT_BUFFER);

signal state : state_type;

signal dest       : std_logic;
signal pkt_count  : unsigned(15 downto 0);

begin

process(clk, reset, in_req)
begin

if reset='1' then

    state <= WAIT_HEADER;
    pkt_count <= (others=>'0');

    qA_push_req <= '0';
    qB_push_req <= '0';
    qA_pkt_flag <= '0';
    qB_pkt_flag <= '0';
    in_ack <= '0';

elsif rising_edge(clk) then

    qA_push_req <= '0';
    qB_push_req <= '0';
    in_ack <= '0';

    case state is

    when WAIT_HEADER =>
	 
		qA_push_req <= '0';
		qA_data <= (others => '0');
		qA_pkt_flag <= '0';
		qB_push_req <= '0';
		qB_data <= (others => '0');
		qB_pkt_flag <= '0';
		in_ack <= '0';

        if in_req='1' then

            dest <= in_data(24);
            pkt_count <= unsigned(in_data(23 downto 8));
				in_ack <= '1';
				

            if in_data(25 downto 24) = "01" then
					dest <= '0';
                --qA_data <= in_data;
                --qA_push_req <= in_req;
					 qA_pkt_flag <= '1';
					 state <= SEND_PACKET_TOA;
            elsif in_data(25 downto 24)="10" then
                dest <= '1';
					 --qB_data <= in_data;
                --qB_push_req <= in_req;
					 qB_pkt_flag <= '1';
					 state <= SEND_PACKET_TOB;
            end if;
			else
				state<=WAIT_HEADER;
			end if;


    when SEND_PACKET_TOA =>
		
			qA_push_req <= in_req;
			qA_data <= in_data;
			qA_pkt_flag <= '0';

			if in_req='1' then
				if qA_push_ack='1' then
					pkt_count <= pkt_count - 1;
					in_ack <= qA_push_ack;
					if pkt_count = 1 then
						state <= WAIT_BUFFER;
						in_ack <= '0';
					end if;
				end if;
			else 
				state <= WAIT_BUFFER;
				qA_push_req <= '0';
			end if;

    when SEND_PACKET_TOB =>
		
			qB_push_req <= in_req;
			qB_data <= in_data;
			qB_pkt_flag <= '0';

			if in_req='1' then
				if qB_push_ack='1' then
					pkt_count <= pkt_count - 1;
					in_ack <= qB_push_ack;
					if pkt_count = 1 then
						state <= WAIT_BUFFER;
						in_ack <= '0';
					end if;
				end if;
			else 
				state <= WAIT_BUFFER;
				qB_push_req <= '0';
			end if;
		
	 when WAIT_BUFFER =>
			    qA_push_req <= '0';
				 qA_pkt_flag <= '0';
				 qB_push_req <= '0';
				 qB_pkt_flag <= '0';
				 in_ack <= '0';
				 state <= WAIT_HEADER;
			
	 when others => null;
	 
    end case;

end if;

end process;

end architecture rtl3;


--Top Level entity
library ieee;
use ieee.std_logic_1164.all;

entity switch_2x2 is
	generic(queue_depth: integer := 1; data_width: integer := 32);
    port (-- 
      clk                      : in  std_logic;
      reset                    : in  std_logic;
      in_data_1_pipe_write_data: in  std_logic_vector(31 downto 0);
      in_data_1_pipe_write_req : in  std_logic_vector(0  downto 0);
      in_data_1_pipe_write_ack : out std_logic_vector(0  downto 0);
      in_data_2_pipe_write_data: in  std_logic_vector(31 downto 0);
      in_data_2_pipe_write_req : in  std_logic_vector(0  downto 0);
      in_data_2_pipe_write_ack : out std_logic_vector(0  downto 0);
      out_data_1_pipe_read_data: out std_logic_vector(31 downto 0);
      out_data_1_pipe_read_req : in  std_logic_vector(0  downto 0);
      out_data_1_pipe_read_ack : out std_logic_vector(0  downto 0);
      out_data_2_pipe_read_data: out std_logic_vector(31 downto 0);
      out_data_2_pipe_read_req : in  std_logic_vector(0  downto 0);
      out_data_2_pipe_read_ack : out std_logic_vector(0  downto 0)); -- 
    -- 
end entity switch_2x2;

architecture struct of switch_2x2 is

	component QueueBase is
		port(clk     : in  std_logic;
			  reset   : in  std_logic;
			  data_in : in  std_logic_vector(data_width-1 downto 0);
			  push_req: in  std_logic;
			  push_ack: out std_logic;
			  data_out: out std_logic_vector(data_width-1 downto 0);
			  pop_ack : out std_logic;
			  pop_req : in  std_logic);
	end component;
	
	component Input_demux_1x2 is
		port(clk   : in std_logic;
			reset : in std_logic;
			-- input pipe
			in_data : in std_logic_vector(data_width-1 downto 0);
			in_req  : in std_logic;
			in_ack  : out std_logic;

			-- queue A
			qA_data     : out std_logic_vector(data_width-1 downto 0);
			qA_push_req : out std_logic;
			qA_push_ack : in  std_logic;
			qA_pkt_flag : out std_logic;

			-- queue B
			qB_data     : out std_logic_vector(data_width-1 downto 0);
			qB_push_req : out std_logic;
			qB_push_ack : in  std_logic;
			qB_pkt_flag : out std_logic
			);
	end component Input_demux_1x2;
	
	component Output_mux_2x1 is
		generic(
			 data_width : integer := 32
		);
		port(
			 clk   : in std_logic;
			 reset : in std_logic;

			 -- queue1
			 q1_data     : in std_logic_vector(data_width-1 downto 0);
			 q1_pop_req  : out std_logic;
			 q1_pop_ack  : in  std_logic;
			 q1_pkt_flag : in  std_logic;
			 q1_clear    : out std_logic;

			 -- queue2
			 q2_data     : in std_logic_vector(data_width-1 downto 0);
			 q2_pop_req  : out std_logic;
			 q2_pop_ack  : in  std_logic;
			 q2_pkt_flag : in  std_logic;
			 q2_clear    : out std_logic;

			 -- output pipe
			 out_data : out std_logic_vector(data_width-1 downto 0);
			 out_req  : in  std_logic;
			 out_ack  : out std_logic
		);
	end component Output_mux_2x1;
	
	component flag_register is
		port(
			clk       : in  std_logic;
			reset     : in  std_logic;
			add_flag  : in  std_logic;
			sub_flag  : in  std_logic;
			pkt_valid : out std_logic
		);
	end component flag_register;
	
	--Q1 signals
	signal Q1_push_req, Q1_push_ack, Q1_pop_ack, Q1_pop_req, Q1_pkt_flag, Q1_add_flag_out, Q1_add_flag_in, Q1_sub_flag : std_logic;
	signal Q1_in_data, Q1_out_data : std_logic_vector(data_width-1 downto 0);
	
	--Q2 signals
	signal Q2_push_req, Q2_push_ack, Q2_pop_ack, Q2_pop_req, Q2_pkt_flag, Q2_add_flag_out, Q2_add_flag_in, Q2_sub_flag : std_logic;
	signal Q2_in_data, Q2_out_data : std_logic_vector(data_width-1 downto 0);
	
	--Q3 signals
	signal Q3_push_req, Q3_push_ack, Q3_pop_ack, Q3_pop_req, Q3_pkt_flag, Q3_add_flag_out, Q3_add_flag_in, Q3_sub_flag : std_logic;
	signal Q3_in_data, Q3_out_data : std_logic_vector(data_width-1 downto 0);
	
	--Q4 signals
	signal Q4_push_req, Q4_push_ack, Q4_pop_ack, Q4_pop_req, Q4_pkt_flag, Q4_add_flag_out, Q4_add_flag_in, Q4_sub_flag : std_logic;
	signal Q4_in_data, Q4_out_data : std_logic_vector(data_width-1 downto 0);
	
	
	
	begin
	
	process(clk)
	begin
		if rising_edge(clk) then
			Q1_add_flag_in <= Q1_add_flag_out;
			Q2_add_flag_in <= Q2_add_flag_out;
			Q3_add_flag_in <= Q3_add_flag_out;
			Q4_add_flag_in <= Q4_add_flag_out;
		end if;
	end process;
	
	D1 : Input_demux_1x2 port map(clk=>clk, reset=>reset,
									in_data=>in_data_1_pipe_write_data, in_req=>in_data_1_pipe_write_req(0), in_ack=>in_data_1_pipe_write_ack(0),
									qA_data=>Q1_in_data, qA_push_req=>Q1_push_req, qA_push_ack=>Q1_push_ack, qA_pkt_flag=>Q1_add_flag_out,
									qB_data=>Q3_in_data, qB_push_req=>Q3_push_req, qB_push_ack=>Q3_push_ack, qB_pkt_flag=>Q3_add_flag_out);
									
	D2 : Input_demux_1x2 port map(clk=>clk, reset=>reset,
									in_data=>in_data_2_pipe_write_data, in_req=>in_data_2_pipe_write_req(0), in_ack=>in_data_2_pipe_write_ack(0),
									qA_data=>Q2_in_data, qA_push_req=>Q2_push_req, qA_push_ack=>Q2_push_ack, qA_pkt_flag=>Q2_add_flag_out,
									qB_data=>Q4_in_data, qB_push_req=>Q4_push_req, qB_push_ack=>Q4_push_ack, qB_pkt_flag=>Q4_add_flag_out);
	
	Q1 : QueueBase port map(clk=>clk, reset=>reset, 
									data_in=>Q1_in_data, push_req=>Q1_push_req, push_ack=>Q1_push_ack,
									data_out=>Q1_out_data, pop_ack=>Q1_pop_ack , pop_req=>Q1_pop_req);

	Q2 : QueueBase port map(clk=>clk, reset=>reset, 
									data_in=>Q2_in_data, push_req=>Q2_push_req, push_ack=>Q2_push_ack,
									data_out=>Q2_out_data, pop_ack=>Q2_pop_ack , pop_req=>Q2_pop_req);
									
	Q3 : QueueBase port map(clk=>clk, reset=>reset, 
									data_in=>Q3_in_data, push_req=>Q3_push_req, push_ack=>Q3_push_ack,
									data_out=>Q3_out_data, pop_ack=>Q3_pop_ack , pop_req=>Q3_pop_req);

	Q4 : QueueBase port map(clk=>clk, reset=>reset, 
									data_in=>Q4_in_data, push_req=>Q4_push_req, push_ack=>Q4_push_ack,
									data_out=>Q4_out_data, pop_ack=>Q4_pop_ack, pop_req=>Q4_pop_req);
									
	Q1_f : flag_register port map(clk=>clk, reset=>reset, add_flag=>Q1_add_flag_in, sub_flag=>Q1_sub_flag, pkt_valid=>Q1_pkt_flag);
	Q2_f : flag_register port map(clk=>clk, reset=>reset, add_flag=>Q2_add_flag_in, sub_flag=>Q2_sub_flag, pkt_valid=>Q2_pkt_flag);
	Q3_f : flag_register port map(clk=>clk, reset=>reset, add_flag=>Q3_add_flag_in, sub_flag=>Q3_sub_flag, pkt_valid=>Q3_pkt_flag);
	Q4_f : flag_register port map(clk=>clk, reset=>reset, add_flag=>Q4_add_flag_in, sub_flag=>Q4_sub_flag, pkt_valid=>Q4_pkt_flag);
									
	A1 : Output_mux_2x1 port map(clk=>clk, reset=>reset,
										q1_data=>Q1_out_data, q1_pop_req=>Q1_pop_req, q1_pop_ack=>Q1_pop_ack, q1_pkt_flag=>Q1_pkt_flag, q1_clear=>Q1_sub_flag,
										q2_data=>Q2_out_data, q2_pop_req=>Q2_pop_req, q2_pop_ack=>Q2_pop_ack, q2_pkt_flag=>Q2_pkt_flag, q2_clear=>Q2_sub_flag,
										out_data=>out_data_1_pipe_read_data, out_req=>out_data_1_pipe_read_req(0), out_ack=>out_data_1_pipe_read_ack(0));
									
	A2 : Output_mux_2x1 port map(clk=>clk, reset=>reset,
										q1_data=>Q3_out_data, q1_pop_req=>Q3_pop_req, q1_pop_ack=>Q3_pop_ack, q1_pkt_flag=>Q3_pkt_flag, q1_clear=>Q3_sub_flag,
										q2_data=>Q4_out_data, q2_pop_req=>Q4_pop_req, q2_pop_ack=>Q4_pop_ack, q2_pkt_flag=>Q4_pkt_flag, q2_clear=>Q4_sub_flag,
										out_data=>out_data_2_pipe_read_data, out_req=>out_data_2_pipe_read_req(0), out_ack=>out_data_2_pipe_read_ack(0));

end architecture struct;
