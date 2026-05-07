-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.switch_2x2_global_package.all;
entity inputPort_1_Daemon is -- 
  generic (tag_length : integer); 
  port ( -- 
    in_data_1_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_1_pipe_read_data : in   std_logic_vector(31 downto 0);
    noblock_obuf_1_1_pipe_write_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_1_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_1_1_pipe_write_data : out  std_logic_vector(32 downto 0);
    noblock_obuf_1_2_pipe_write_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_1_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_1_2_pipe_write_data : out  std_logic_vector(32 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) ;
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic-- 
  );
  -- 
end entity inputPort_1_Daemon;
architecture inputPort_1_Daemon_arch of inputPort_1_Daemon is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal inputPort_1_Daemon_CP_3_start: Boolean;
  signal inputPort_1_Daemon_CP_3_symbol: Boolean;
  -- volatile/operator module components. 
  -- links between control-path and data-path
  signal do_while_stmt_42_branch_req_0 : boolean;
  signal phi_stmt_44_req_1 : boolean;
  signal phi_stmt_44_req_0 : boolean;
  signal phi_stmt_44_ack_0 : boolean;
  signal next_last_dest_id_97_56_buf_req_0 : boolean;
  signal next_last_dest_id_97_56_buf_ack_0 : boolean;
  signal next_count_down_91_49_buf_req_0 : boolean;
  signal next_count_down_91_49_buf_ack_0 : boolean;
  signal next_count_down_91_49_buf_req_1 : boolean;
  signal next_count_down_91_49_buf_ack_1 : boolean;
  signal RPIPE_in_data_1_52_inst_req_0 : boolean;
  signal RPIPE_in_data_1_52_inst_ack_0 : boolean;
  signal RPIPE_in_data_1_52_inst_req_1 : boolean;
  signal RPIPE_in_data_1_52_inst_ack_1 : boolean;
  signal phi_stmt_53_req_1 : boolean;
  signal phi_stmt_53_req_0 : boolean;
  signal phi_stmt_53_ack_0 : boolean;
  signal next_last_dest_id_97_56_buf_req_1 : boolean;
  signal next_last_dest_id_97_56_buf_ack_1 : boolean;
  signal WPIPE_noblock_obuf_1_1_109_inst_req_0 : boolean;
  signal WPIPE_noblock_obuf_1_1_109_inst_ack_0 : boolean;
  signal WPIPE_noblock_obuf_1_1_109_inst_req_1 : boolean;
  signal WPIPE_noblock_obuf_1_1_109_inst_ack_1 : boolean;
  signal WPIPE_noblock_obuf_1_2_118_inst_req_0 : boolean;
  signal WPIPE_noblock_obuf_1_2_118_inst_ack_0 : boolean;
  signal WPIPE_noblock_obuf_1_2_118_inst_req_1 : boolean;
  signal WPIPE_noblock_obuf_1_2_118_inst_ack_1 : boolean;
  signal do_while_stmt_42_branch_ack_0 : boolean;
  signal do_while_stmt_42_branch_ack_1 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "inputPort_1_Daemon_input_buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj_in_buffer_unload_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  inputPort_1_Daemon_CP_3_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "inputPort_1_Daemon_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 0) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= inputPort_1_Daemon_CP_3_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj_out_buffer_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= inputPort_1_Daemon_CP_3_start & tag_ilock_write_ack_symbol;
    gj_tag_ilock_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= inputPort_1_Daemon_CP_3_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  inputPort_1_Daemon_CP_3: Block -- control-path 
    signal inputPort_1_Daemon_CP_3_elements: BooleanArray(67 downto 0);
    -- 
  begin -- 
    inputPort_1_Daemon_CP_3_elements(0) <= inputPort_1_Daemon_CP_3_start;
    inputPort_1_Daemon_CP_3_symbol <= inputPort_1_Daemon_CP_3_elements(1);
    -- CP-element group 0:  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	2 
    -- CP-element group 0:  members (4) 
      -- CP-element group 0: 	 $entry
      -- CP-element group 0: 	 branch_block_stmt_41/$entry
      -- CP-element group 0: 	 branch_block_stmt_41/branch_block_stmt_41__entry__
      -- CP-element group 0: 	 branch_block_stmt_41/do_while_stmt_42__entry__
      -- 
    -- CP-element group 1:  transition  place  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	67 
    -- CP-element group 1: successors 
    -- CP-element group 1:  members (4) 
      -- CP-element group 1: 	 $exit
      -- CP-element group 1: 	 branch_block_stmt_41/$exit
      -- CP-element group 1: 	 branch_block_stmt_41/branch_block_stmt_41__exit__
      -- CP-element group 1: 	 branch_block_stmt_41/do_while_stmt_42__exit__
      -- 
    inputPort_1_Daemon_CP_3_elements(1) <= inputPort_1_Daemon_CP_3_elements(67);
    -- CP-element group 2:  transition  place  bypass  pipeline-parent 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	0 
    -- CP-element group 2: successors 
    -- CP-element group 2: 	8 
    -- CP-element group 2:  members (2) 
      -- CP-element group 2: 	 branch_block_stmt_41/do_while_stmt_42/$entry
      -- CP-element group 2: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42__entry__
      -- 
    inputPort_1_Daemon_CP_3_elements(2) <= inputPort_1_Daemon_CP_3_elements(0);
    -- CP-element group 3:  merge  place  bypass  pipeline-parent 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	67 
    -- CP-element group 3:  members (1) 
      -- CP-element group 3: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42__exit__
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(3) is bound as output of CP function.
    -- CP-element group 4:  merge  place  bypass  pipeline-parent 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: successors 
    -- CP-element group 4: 	7 
    -- CP-element group 4:  members (1) 
      -- CP-element group 4: 	 branch_block_stmt_41/do_while_stmt_42/loop_back
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(4) is bound as output of CP function.
    -- CP-element group 5:  branch  transition  place  bypass  pipeline-parent 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	10 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	65 
    -- CP-element group 5: 	66 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_41/do_while_stmt_42/condition_done
      -- CP-element group 5: 	 branch_block_stmt_41/do_while_stmt_42/loop_exit/$entry
      -- CP-element group 5: 	 branch_block_stmt_41/do_while_stmt_42/loop_taken/$entry
      -- 
    inputPort_1_Daemon_CP_3_elements(5) <= inputPort_1_Daemon_CP_3_elements(10);
    -- CP-element group 6:  branch  place  bypass  pipeline-parent 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	64 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (1) 
      -- CP-element group 6: 	 branch_block_stmt_41/do_while_stmt_42/loop_body_done
      -- 
    inputPort_1_Daemon_CP_3_elements(6) <= inputPort_1_Daemon_CP_3_elements(64);
    -- CP-element group 7:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	4 
    -- CP-element group 7: successors 
    -- CP-element group 7: 	20 
    -- CP-element group 7: 	44 
    -- CP-element group 7:  members (1) 
      -- CP-element group 7: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/back_edge_to_loop_body
      -- 
    inputPort_1_Daemon_CP_3_elements(7) <= inputPort_1_Daemon_CP_3_elements(4);
    -- CP-element group 8:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	2 
    -- CP-element group 8: successors 
    -- CP-element group 8: 	22 
    -- CP-element group 8: 	46 
    -- CP-element group 8:  members (1) 
      -- CP-element group 8: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/first_time_through_loop_body
      -- 
    inputPort_1_Daemon_CP_3_elements(8) <= inputPort_1_Daemon_CP_3_elements(2);
    -- CP-element group 9:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	11 
    -- CP-element group 9: 	16 
    -- CP-element group 9: 	17 
    -- CP-element group 9: 	33 
    -- CP-element group 9: 	38 
    -- CP-element group 9: 	39 
    -- CP-element group 9: 	63 
    -- CP-element group 9:  members (3) 
      -- CP-element group 9: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/$entry
      -- CP-element group 9: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/loop_body_start
      -- CP-element group 9: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_50_sample_start_
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(9) is bound as output of CP function.
    -- CP-element group 10:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	13 
    -- CP-element group 10: 	15 
    -- CP-element group 10: 	63 
    -- CP-element group 10: successors 
    -- CP-element group 10: 	5 
    -- CP-element group 10:  members (1) 
      -- CP-element group 10: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/condition_evaluated
      -- 
    condition_evaluated_27_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " condition_evaluated_27_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(10), ack => do_while_stmt_42_branch_req_0); -- 
    inputPort_1_Daemon_cp_element_group_10: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_10"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(13) & inputPort_1_Daemon_CP_3_elements(15) & inputPort_1_Daemon_CP_3_elements(63);
      gj_inputPort_1_Daemon_cp_element_group_10 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(10), clk => clk, reset => reset); --
    end block;
    -- CP-element group 11:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	9 
    -- CP-element group 11: 	16 
    -- CP-element group 11: 	38 
    -- CP-element group 11: marked-predecessors 
    -- CP-element group 11: 	15 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	34 
    -- CP-element group 11: 	40 
    -- CP-element group 11:  members (2) 
      -- CP-element group 11: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_sample_start__ps
      -- CP-element group 11: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/aggregated_phi_sample_req
      -- 
    inputPort_1_Daemon_cp_element_group_11: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 7,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_11"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(9) & inputPort_1_Daemon_CP_3_elements(16) & inputPort_1_Daemon_CP_3_elements(38) & inputPort_1_Daemon_CP_3_elements(15);
      gj_inputPort_1_Daemon_cp_element_group_11 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(11), clk => clk, reset => reset); --
    end block;
    -- CP-element group 12:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	18 
    -- CP-element group 12: 	36 
    -- CP-element group 12: 	41 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	13 
    -- CP-element group 12: 	64 
    -- CP-element group 12: marked-successors 
    -- CP-element group 12: 	16 
    -- CP-element group 12: 	38 
    -- CP-element group 12:  members (4) 
      -- CP-element group 12: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/aggregated_phi_sample_ack
      -- CP-element group 12: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_50_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_sample_completed_
      -- 
    inputPort_1_Daemon_cp_element_group_12: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_12"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(18) & inputPort_1_Daemon_CP_3_elements(36) & inputPort_1_Daemon_CP_3_elements(41);
      gj_inputPort_1_Daemon_cp_element_group_12 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(12), clk => clk, reset => reset); --
    end block;
    -- CP-element group 13:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	12 
    -- CP-element group 13: successors 
    -- CP-element group 13: 	10 
    -- CP-element group 13:  members (1) 
      -- CP-element group 13: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/aggregated_phi_sample_ack_d
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(13) is a control-delay.
    cp_element_13_delay: control_delay_element  generic map(name => " 13_delay", delay_value => 1)  port map(req => inputPort_1_Daemon_CP_3_elements(12), ack => inputPort_1_Daemon_CP_3_elements(13), clk => clk, reset =>reset);
    -- CP-element group 14:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	17 
    -- CP-element group 14: 	33 
    -- CP-element group 14: 	39 
    -- CP-element group 14: successors 
    -- CP-element group 14: 	35 
    -- CP-element group 14: 	42 
    -- CP-element group 14:  members (2) 
      -- CP-element group 14: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_update_start__ps
      -- CP-element group 14: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/aggregated_phi_update_req
      -- 
    inputPort_1_Daemon_cp_element_group_14: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_14"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(17) & inputPort_1_Daemon_CP_3_elements(33) & inputPort_1_Daemon_CP_3_elements(39);
      gj_inputPort_1_Daemon_cp_element_group_14 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(14), clk => clk, reset => reset); --
    end block;
    -- CP-element group 15:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	19 
    -- CP-element group 15: 	37 
    -- CP-element group 15: 	43 
    -- CP-element group 15: successors 
    -- CP-element group 15: 	10 
    -- CP-element group 15: marked-successors 
    -- CP-element group 15: 	11 
    -- CP-element group 15:  members (1) 
      -- CP-element group 15: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/aggregated_phi_update_ack
      -- 
    inputPort_1_Daemon_cp_element_group_15: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_15"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(19) & inputPort_1_Daemon_CP_3_elements(37) & inputPort_1_Daemon_CP_3_elements(43);
      gj_inputPort_1_Daemon_cp_element_group_15 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(15), clk => clk, reset => reset); --
    end block;
    -- CP-element group 16:  join  transition  bypass  pipeline-parent 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	9 
    -- CP-element group 16: marked-predecessors 
    -- CP-element group 16: 	12 
    -- CP-element group 16: successors 
    -- CP-element group 16: 	11 
    -- CP-element group 16:  members (1) 
      -- CP-element group 16: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_sample_start_
      -- 
    inputPort_1_Daemon_cp_element_group_16: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_16"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(9) & inputPort_1_Daemon_CP_3_elements(12);
      gj_inputPort_1_Daemon_cp_element_group_16 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(16), clk => clk, reset => reset); --
    end block;
    -- CP-element group 17:  join  transition  bypass  pipeline-parent 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	9 
    -- CP-element group 17: marked-predecessors 
    -- CP-element group 17: 	58 
    -- CP-element group 17: 	61 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	14 
    -- CP-element group 17:  members (1) 
      -- CP-element group 17: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_update_start_
      -- 
    inputPort_1_Daemon_cp_element_group_17: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_17"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(9) & inputPort_1_Daemon_CP_3_elements(58) & inputPort_1_Daemon_CP_3_elements(61);
      gj_inputPort_1_Daemon_cp_element_group_17 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(17), clk => clk, reset => reset); --
    end block;
    -- CP-element group 18:  join  transition  bypass  pipeline-parent 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: successors 
    -- CP-element group 18: 	12 
    -- CP-element group 18:  members (1) 
      -- CP-element group 18: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_sample_completed__ps
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(18) is bound as output of CP function.
    -- CP-element group 19:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	15 
    -- CP-element group 19: 	57 
    -- CP-element group 19: 	60 
    -- CP-element group 19:  members (2) 
      -- CP-element group 19: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_update_completed_
      -- CP-element group 19: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_update_completed__ps
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(19) is bound as output of CP function.
    -- CP-element group 20:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	7 
    -- CP-element group 20: successors 
    -- CP-element group 20:  members (1) 
      -- CP-element group 20: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_loopback_trigger
      -- 
    inputPort_1_Daemon_CP_3_elements(20) <= inputPort_1_Daemon_CP_3_elements(7);
    -- CP-element group 21:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: successors 
    -- CP-element group 21:  members (2) 
      -- CP-element group 21: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_loopback_sample_req
      -- CP-element group 21: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_loopback_sample_req_ps
      -- 
    phi_stmt_44_loopback_sample_req_43_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_44_loopback_sample_req_43_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(21), ack => phi_stmt_44_req_1); -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(21) is bound as output of CP function.
    -- CP-element group 22:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	8 
    -- CP-element group 22: successors 
    -- CP-element group 22:  members (1) 
      -- CP-element group 22: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_entry_trigger
      -- 
    inputPort_1_Daemon_CP_3_elements(22) <= inputPort_1_Daemon_CP_3_elements(8);
    -- CP-element group 23:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: successors 
    -- CP-element group 23:  members (2) 
      -- CP-element group 23: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_entry_sample_req
      -- CP-element group 23: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_entry_sample_req_ps
      -- 
    phi_stmt_44_entry_sample_req_46_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_44_entry_sample_req_46_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(23), ack => phi_stmt_44_req_0); -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(23) is bound as output of CP function.
    -- CP-element group 24:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: successors 
    -- CP-element group 24:  members (2) 
      -- CP-element group 24: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_phi_mux_ack
      -- CP-element group 24: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_44_phi_mux_ack_ps
      -- 
    phi_stmt_44_phi_mux_ack_49_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 24_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_44_ack_0, ack => inputPort_1_Daemon_CP_3_elements(24)); -- 
    -- CP-element group 25:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: successors 
    -- CP-element group 25:  members (4) 
      -- CP-element group 25: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/type_cast_48_sample_start__ps
      -- CP-element group 25: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/type_cast_48_sample_completed__ps
      -- CP-element group 25: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/type_cast_48_sample_start_
      -- CP-element group 25: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/type_cast_48_sample_completed_
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(25) is bound as output of CP function.
    -- CP-element group 26:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 26: predecessors 
    -- CP-element group 26: successors 
    -- CP-element group 26: 	28 
    -- CP-element group 26:  members (2) 
      -- CP-element group 26: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/type_cast_48_update_start__ps
      -- CP-element group 26: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/type_cast_48_update_start_
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(26) is bound as output of CP function.
    -- CP-element group 27:  join  transition  bypass  pipeline-parent 
    -- CP-element group 27: predecessors 
    -- CP-element group 27: 	28 
    -- CP-element group 27: successors 
    -- CP-element group 27:  members (1) 
      -- CP-element group 27: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/type_cast_48_update_completed__ps
      -- 
    inputPort_1_Daemon_CP_3_elements(27) <= inputPort_1_Daemon_CP_3_elements(28);
    -- CP-element group 28:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 28: predecessors 
    -- CP-element group 28: 	26 
    -- CP-element group 28: successors 
    -- CP-element group 28: 	27 
    -- CP-element group 28:  members (1) 
      -- CP-element group 28: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/type_cast_48_update_completed_
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(28) is a control-delay.
    cp_element_28_delay: control_delay_element  generic map(name => " 28_delay", delay_value => 1)  port map(req => inputPort_1_Daemon_CP_3_elements(26), ack => inputPort_1_Daemon_CP_3_elements(28), clk => clk, reset =>reset);
    -- CP-element group 29:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 29: predecessors 
    -- CP-element group 29: successors 
    -- CP-element group 29: 	31 
    -- CP-element group 29:  members (4) 
      -- CP-element group 29: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_sample_start__ps
      -- CP-element group 29: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_sample_start_
      -- CP-element group 29: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_Sample/$entry
      -- CP-element group 29: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_Sample/req
      -- 
    req_70_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_70_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(29), ack => next_count_down_91_49_buf_req_0); -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(29) is bound as output of CP function.
    -- CP-element group 30:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 30: predecessors 
    -- CP-element group 30: successors 
    -- CP-element group 30: 	32 
    -- CP-element group 30:  members (4) 
      -- CP-element group 30: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_update_start__ps
      -- CP-element group 30: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_update_start_
      -- CP-element group 30: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_Update/$entry
      -- CP-element group 30: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_Update/req
      -- 
    req_75_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_75_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(30), ack => next_count_down_91_49_buf_req_1); -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(30) is bound as output of CP function.
    -- CP-element group 31:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 31: predecessors 
    -- CP-element group 31: 	29 
    -- CP-element group 31: successors 
    -- CP-element group 31:  members (4) 
      -- CP-element group 31: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_sample_completed__ps
      -- CP-element group 31: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_sample_completed_
      -- CP-element group 31: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_Sample/$exit
      -- CP-element group 31: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_Sample/ack
      -- 
    ack_71_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 31_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_down_91_49_buf_ack_0, ack => inputPort_1_Daemon_CP_3_elements(31)); -- 
    -- CP-element group 32:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 32: predecessors 
    -- CP-element group 32: 	30 
    -- CP-element group 32: successors 
    -- CP-element group 32:  members (4) 
      -- CP-element group 32: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_update_completed__ps
      -- CP-element group 32: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_update_completed_
      -- CP-element group 32: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_Update/$exit
      -- CP-element group 32: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_count_down_49_Update/ack
      -- 
    ack_76_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 32_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_down_91_49_buf_ack_1, ack => inputPort_1_Daemon_CP_3_elements(32)); -- 
    -- CP-element group 33:  join  transition  bypass  pipeline-parent 
    -- CP-element group 33: predecessors 
    -- CP-element group 33: 	9 
    -- CP-element group 33: marked-predecessors 
    -- CP-element group 33: 	58 
    -- CP-element group 33: 	61 
    -- CP-element group 33: successors 
    -- CP-element group 33: 	14 
    -- CP-element group 33:  members (1) 
      -- CP-element group 33: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_50_update_start_
      -- 
    inputPort_1_Daemon_cp_element_group_33: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_33"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(9) & inputPort_1_Daemon_CP_3_elements(58) & inputPort_1_Daemon_CP_3_elements(61);
      gj_inputPort_1_Daemon_cp_element_group_33 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(33), clk => clk, reset => reset); --
    end block;
    -- CP-element group 34:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 34: predecessors 
    -- CP-element group 34: 	11 
    -- CP-element group 34: marked-predecessors 
    -- CP-element group 34: 	37 
    -- CP-element group 34: successors 
    -- CP-element group 34: 	36 
    -- CP-element group 34:  members (3) 
      -- CP-element group 34: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_sample_start_
      -- CP-element group 34: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_Sample/$entry
      -- CP-element group 34: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_Sample/rr
      -- 
    rr_89_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_89_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(34), ack => RPIPE_in_data_1_52_inst_req_0); -- 
    inputPort_1_Daemon_cp_element_group_34: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_34"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(11) & inputPort_1_Daemon_CP_3_elements(37);
      gj_inputPort_1_Daemon_cp_element_group_34 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(34), clk => clk, reset => reset); --
    end block;
    -- CP-element group 35:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 35: predecessors 
    -- CP-element group 35: 	14 
    -- CP-element group 35: 	36 
    -- CP-element group 35: successors 
    -- CP-element group 35: 	37 
    -- CP-element group 35:  members (3) 
      -- CP-element group 35: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_update_start_
      -- CP-element group 35: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_Update/$entry
      -- CP-element group 35: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_Update/cr
      -- 
    cr_94_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_94_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(35), ack => RPIPE_in_data_1_52_inst_req_1); -- 
    inputPort_1_Daemon_cp_element_group_35: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_35"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(14) & inputPort_1_Daemon_CP_3_elements(36);
      gj_inputPort_1_Daemon_cp_element_group_35 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(35), clk => clk, reset => reset); --
    end block;
    -- CP-element group 36:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 36: predecessors 
    -- CP-element group 36: 	34 
    -- CP-element group 36: successors 
    -- CP-element group 36: 	12 
    -- CP-element group 36: 	35 
    -- CP-element group 36:  members (3) 
      -- CP-element group 36: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_sample_completed_
      -- CP-element group 36: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_Sample/$exit
      -- CP-element group 36: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_Sample/ra
      -- 
    ra_90_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 36_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_1_52_inst_ack_0, ack => inputPort_1_Daemon_CP_3_elements(36)); -- 
    -- CP-element group 37:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 37: predecessors 
    -- CP-element group 37: 	35 
    -- CP-element group 37: successors 
    -- CP-element group 37: 	15 
    -- CP-element group 37: 	57 
    -- CP-element group 37: 	60 
    -- CP-element group 37: marked-successors 
    -- CP-element group 37: 	34 
    -- CP-element group 37:  members (4) 
      -- CP-element group 37: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_50_update_completed_
      -- CP-element group 37: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_update_completed_
      -- CP-element group 37: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_Update/$exit
      -- CP-element group 37: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/RPIPE_in_data_1_52_Update/ca
      -- 
    ca_95_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 37_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_1_52_inst_ack_1, ack => inputPort_1_Daemon_CP_3_elements(37)); -- 
    -- CP-element group 38:  join  transition  bypass  pipeline-parent 
    -- CP-element group 38: predecessors 
    -- CP-element group 38: 	9 
    -- CP-element group 38: marked-predecessors 
    -- CP-element group 38: 	12 
    -- CP-element group 38: successors 
    -- CP-element group 38: 	11 
    -- CP-element group 38:  members (1) 
      -- CP-element group 38: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_sample_start_
      -- 
    inputPort_1_Daemon_cp_element_group_38: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_38"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(9) & inputPort_1_Daemon_CP_3_elements(12);
      gj_inputPort_1_Daemon_cp_element_group_38 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(38), clk => clk, reset => reset); --
    end block;
    -- CP-element group 39:  join  transition  bypass  pipeline-parent 
    -- CP-element group 39: predecessors 
    -- CP-element group 39: 	9 
    -- CP-element group 39: marked-predecessors 
    -- CP-element group 39: 	58 
    -- CP-element group 39: 	61 
    -- CP-element group 39: successors 
    -- CP-element group 39: 	14 
    -- CP-element group 39:  members (1) 
      -- CP-element group 39: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_update_start_
      -- 
    inputPort_1_Daemon_cp_element_group_39: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_39"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(9) & inputPort_1_Daemon_CP_3_elements(58) & inputPort_1_Daemon_CP_3_elements(61);
      gj_inputPort_1_Daemon_cp_element_group_39 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(39), clk => clk, reset => reset); --
    end block;
    -- CP-element group 40:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 40: predecessors 
    -- CP-element group 40: 	11 
    -- CP-element group 40: successors 
    -- CP-element group 40:  members (1) 
      -- CP-element group 40: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_sample_start__ps
      -- 
    inputPort_1_Daemon_CP_3_elements(40) <= inputPort_1_Daemon_CP_3_elements(11);
    -- CP-element group 41:  join  transition  bypass  pipeline-parent 
    -- CP-element group 41: predecessors 
    -- CP-element group 41: successors 
    -- CP-element group 41: 	12 
    -- CP-element group 41:  members (1) 
      -- CP-element group 41: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_sample_completed__ps
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(41) is bound as output of CP function.
    -- CP-element group 42:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 42: predecessors 
    -- CP-element group 42: 	14 
    -- CP-element group 42: successors 
    -- CP-element group 42:  members (1) 
      -- CP-element group 42: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_update_start__ps
      -- 
    inputPort_1_Daemon_CP_3_elements(42) <= inputPort_1_Daemon_CP_3_elements(14);
    -- CP-element group 43:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 43: predecessors 
    -- CP-element group 43: successors 
    -- CP-element group 43: 	15 
    -- CP-element group 43: 	57 
    -- CP-element group 43: 	60 
    -- CP-element group 43:  members (2) 
      -- CP-element group 43: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_update_completed_
      -- CP-element group 43: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_update_completed__ps
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(43) is bound as output of CP function.
    -- CP-element group 44:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 44: predecessors 
    -- CP-element group 44: 	7 
    -- CP-element group 44: successors 
    -- CP-element group 44:  members (1) 
      -- CP-element group 44: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_loopback_trigger
      -- 
    inputPort_1_Daemon_CP_3_elements(44) <= inputPort_1_Daemon_CP_3_elements(7);
    -- CP-element group 45:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 45: predecessors 
    -- CP-element group 45: successors 
    -- CP-element group 45:  members (2) 
      -- CP-element group 45: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_loopback_sample_req
      -- CP-element group 45: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_loopback_sample_req_ps
      -- 
    phi_stmt_53_loopback_sample_req_105_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_53_loopback_sample_req_105_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(45), ack => phi_stmt_53_req_1); -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(45) is bound as output of CP function.
    -- CP-element group 46:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 46: predecessors 
    -- CP-element group 46: 	8 
    -- CP-element group 46: successors 
    -- CP-element group 46:  members (1) 
      -- CP-element group 46: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_entry_trigger
      -- 
    inputPort_1_Daemon_CP_3_elements(46) <= inputPort_1_Daemon_CP_3_elements(8);
    -- CP-element group 47:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 47: predecessors 
    -- CP-element group 47: successors 
    -- CP-element group 47:  members (2) 
      -- CP-element group 47: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_entry_sample_req
      -- CP-element group 47: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_entry_sample_req_ps
      -- 
    phi_stmt_53_entry_sample_req_108_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_53_entry_sample_req_108_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(47), ack => phi_stmt_53_req_0); -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(47) is bound as output of CP function.
    -- CP-element group 48:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 48: predecessors 
    -- CP-element group 48: successors 
    -- CP-element group 48:  members (2) 
      -- CP-element group 48: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_phi_mux_ack
      -- CP-element group 48: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/phi_stmt_53_phi_mux_ack_ps
      -- 
    phi_stmt_53_phi_mux_ack_111_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 48_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_53_ack_0, ack => inputPort_1_Daemon_CP_3_elements(48)); -- 
    -- CP-element group 49:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 49: predecessors 
    -- CP-element group 49: successors 
    -- CP-element group 49:  members (4) 
      -- CP-element group 49: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/konst_55_sample_start__ps
      -- CP-element group 49: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/konst_55_sample_completed__ps
      -- CP-element group 49: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/konst_55_sample_start_
      -- CP-element group 49: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/konst_55_sample_completed_
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(49) is bound as output of CP function.
    -- CP-element group 50:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 50: predecessors 
    -- CP-element group 50: successors 
    -- CP-element group 50: 	52 
    -- CP-element group 50:  members (2) 
      -- CP-element group 50: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/konst_55_update_start__ps
      -- CP-element group 50: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/konst_55_update_start_
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(50) is bound as output of CP function.
    -- CP-element group 51:  join  transition  bypass  pipeline-parent 
    -- CP-element group 51: predecessors 
    -- CP-element group 51: 	52 
    -- CP-element group 51: successors 
    -- CP-element group 51:  members (1) 
      -- CP-element group 51: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/konst_55_update_completed__ps
      -- 
    inputPort_1_Daemon_CP_3_elements(51) <= inputPort_1_Daemon_CP_3_elements(52);
    -- CP-element group 52:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 52: predecessors 
    -- CP-element group 52: 	50 
    -- CP-element group 52: successors 
    -- CP-element group 52: 	51 
    -- CP-element group 52:  members (1) 
      -- CP-element group 52: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/konst_55_update_completed_
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(52) is a control-delay.
    cp_element_52_delay: control_delay_element  generic map(name => " 52_delay", delay_value => 1)  port map(req => inputPort_1_Daemon_CP_3_elements(50), ack => inputPort_1_Daemon_CP_3_elements(52), clk => clk, reset =>reset);
    -- CP-element group 53:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 53: predecessors 
    -- CP-element group 53: successors 
    -- CP-element group 53: 	55 
    -- CP-element group 53:  members (4) 
      -- CP-element group 53: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_sample_start_
      -- CP-element group 53: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_Sample/$entry
      -- CP-element group 53: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_Sample/req
      -- CP-element group 53: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_sample_start__ps
      -- 
    req_132_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_132_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(53), ack => next_last_dest_id_97_56_buf_req_0); -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(53) is bound as output of CP function.
    -- CP-element group 54:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 54: predecessors 
    -- CP-element group 54: successors 
    -- CP-element group 54: 	56 
    -- CP-element group 54:  members (4) 
      -- CP-element group 54: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_update_start_
      -- CP-element group 54: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_update_start__ps
      -- CP-element group 54: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_Update/$entry
      -- CP-element group 54: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_Update/req
      -- 
    req_137_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_137_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(54), ack => next_last_dest_id_97_56_buf_req_1); -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(54) is bound as output of CP function.
    -- CP-element group 55:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 55: predecessors 
    -- CP-element group 55: 	53 
    -- CP-element group 55: successors 
    -- CP-element group 55:  members (4) 
      -- CP-element group 55: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_sample_completed_
      -- CP-element group 55: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_Sample/$exit
      -- CP-element group 55: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_Sample/ack
      -- CP-element group 55: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_sample_completed__ps
      -- 
    ack_133_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 55_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_last_dest_id_97_56_buf_ack_0, ack => inputPort_1_Daemon_CP_3_elements(55)); -- 
    -- CP-element group 56:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 56: predecessors 
    -- CP-element group 56: 	54 
    -- CP-element group 56: successors 
    -- CP-element group 56:  members (4) 
      -- CP-element group 56: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_update_completed_
      -- CP-element group 56: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_update_completed__ps
      -- CP-element group 56: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_Update/$exit
      -- CP-element group 56: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/R_next_last_dest_id_56_Update/ack
      -- 
    ack_138_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 56_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_last_dest_id_97_56_buf_ack_1, ack => inputPort_1_Daemon_CP_3_elements(56)); -- 
    -- CP-element group 57:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 57: predecessors 
    -- CP-element group 57: 	19 
    -- CP-element group 57: 	37 
    -- CP-element group 57: 	43 
    -- CP-element group 57: marked-predecessors 
    -- CP-element group 57: 	59 
    -- CP-element group 57: successors 
    -- CP-element group 57: 	58 
    -- CP-element group 57:  members (3) 
      -- CP-element group 57: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_sample_start_
      -- CP-element group 57: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_Sample/$entry
      -- CP-element group 57: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_Sample/req
      -- 
    req_147_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_147_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(57), ack => WPIPE_noblock_obuf_1_1_109_inst_req_0); -- 
    inputPort_1_Daemon_cp_element_group_57: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_57"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(19) & inputPort_1_Daemon_CP_3_elements(37) & inputPort_1_Daemon_CP_3_elements(43) & inputPort_1_Daemon_CP_3_elements(59);
      gj_inputPort_1_Daemon_cp_element_group_57 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(57), clk => clk, reset => reset); --
    end block;
    -- CP-element group 58:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 58: predecessors 
    -- CP-element group 58: 	57 
    -- CP-element group 58: successors 
    -- CP-element group 58: 	59 
    -- CP-element group 58: marked-successors 
    -- CP-element group 58: 	17 
    -- CP-element group 58: 	33 
    -- CP-element group 58: 	39 
    -- CP-element group 58:  members (6) 
      -- CP-element group 58: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_sample_completed_
      -- CP-element group 58: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_update_start_
      -- CP-element group 58: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_Sample/$exit
      -- CP-element group 58: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_Sample/ack
      -- CP-element group 58: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_Update/$entry
      -- CP-element group 58: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_Update/req
      -- 
    ack_148_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 58_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_1_1_109_inst_ack_0, ack => inputPort_1_Daemon_CP_3_elements(58)); -- 
    req_152_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_152_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(58), ack => WPIPE_noblock_obuf_1_1_109_inst_req_1); -- 
    -- CP-element group 59:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 59: predecessors 
    -- CP-element group 59: 	58 
    -- CP-element group 59: successors 
    -- CP-element group 59: 	64 
    -- CP-element group 59: marked-successors 
    -- CP-element group 59: 	57 
    -- CP-element group 59:  members (3) 
      -- CP-element group 59: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_update_completed_
      -- CP-element group 59: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_Update/$exit
      -- CP-element group 59: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_1_109_Update/ack
      -- 
    ack_153_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 59_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_1_1_109_inst_ack_1, ack => inputPort_1_Daemon_CP_3_elements(59)); -- 
    -- CP-element group 60:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 60: predecessors 
    -- CP-element group 60: 	19 
    -- CP-element group 60: 	37 
    -- CP-element group 60: 	43 
    -- CP-element group 60: marked-predecessors 
    -- CP-element group 60: 	62 
    -- CP-element group 60: successors 
    -- CP-element group 60: 	61 
    -- CP-element group 60:  members (3) 
      -- CP-element group 60: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_sample_start_
      -- CP-element group 60: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_Sample/$entry
      -- CP-element group 60: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_Sample/req
      -- 
    req_161_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_161_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(60), ack => WPIPE_noblock_obuf_1_2_118_inst_req_0); -- 
    inputPort_1_Daemon_cp_element_group_60: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_60"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(19) & inputPort_1_Daemon_CP_3_elements(37) & inputPort_1_Daemon_CP_3_elements(43) & inputPort_1_Daemon_CP_3_elements(62);
      gj_inputPort_1_Daemon_cp_element_group_60 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(60), clk => clk, reset => reset); --
    end block;
    -- CP-element group 61:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 61: predecessors 
    -- CP-element group 61: 	60 
    -- CP-element group 61: successors 
    -- CP-element group 61: 	62 
    -- CP-element group 61: marked-successors 
    -- CP-element group 61: 	17 
    -- CP-element group 61: 	33 
    -- CP-element group 61: 	39 
    -- CP-element group 61:  members (6) 
      -- CP-element group 61: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_sample_completed_
      -- CP-element group 61: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_update_start_
      -- CP-element group 61: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_Sample/$exit
      -- CP-element group 61: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_Sample/ack
      -- CP-element group 61: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_Update/$entry
      -- CP-element group 61: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_Update/req
      -- 
    ack_162_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 61_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_1_2_118_inst_ack_0, ack => inputPort_1_Daemon_CP_3_elements(61)); -- 
    req_166_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_166_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_1_Daemon_CP_3_elements(61), ack => WPIPE_noblock_obuf_1_2_118_inst_req_1); -- 
    -- CP-element group 62:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 62: predecessors 
    -- CP-element group 62: 	61 
    -- CP-element group 62: successors 
    -- CP-element group 62: 	64 
    -- CP-element group 62: marked-successors 
    -- CP-element group 62: 	60 
    -- CP-element group 62:  members (3) 
      -- CP-element group 62: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_update_completed_
      -- CP-element group 62: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_Update/$exit
      -- CP-element group 62: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/WPIPE_noblock_obuf_1_2_118_Update/ack
      -- 
    ack_167_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 62_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_1_2_118_inst_ack_1, ack => inputPort_1_Daemon_CP_3_elements(62)); -- 
    -- CP-element group 63:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 63: predecessors 
    -- CP-element group 63: 	9 
    -- CP-element group 63: successors 
    -- CP-element group 63: 	10 
    -- CP-element group 63:  members (1) 
      -- CP-element group 63: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/loop_body_delay_to_condition_start
      -- 
    -- Element group inputPort_1_Daemon_CP_3_elements(63) is a control-delay.
    cp_element_63_delay: control_delay_element  generic map(name => " 63_delay", delay_value => 1)  port map(req => inputPort_1_Daemon_CP_3_elements(9), ack => inputPort_1_Daemon_CP_3_elements(63), clk => clk, reset =>reset);
    -- CP-element group 64:  join  transition  bypass  pipeline-parent 
    -- CP-element group 64: predecessors 
    -- CP-element group 64: 	12 
    -- CP-element group 64: 	59 
    -- CP-element group 64: 	62 
    -- CP-element group 64: successors 
    -- CP-element group 64: 	6 
    -- CP-element group 64:  members (1) 
      -- CP-element group 64: 	 branch_block_stmt_41/do_while_stmt_42/do_while_stmt_42_loop_body/$exit
      -- 
    inputPort_1_Daemon_cp_element_group_64: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_1_Daemon_cp_element_group_64"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_1_Daemon_CP_3_elements(12) & inputPort_1_Daemon_CP_3_elements(59) & inputPort_1_Daemon_CP_3_elements(62);
      gj_inputPort_1_Daemon_cp_element_group_64 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(64), clk => clk, reset => reset); --
    end block;
    -- CP-element group 65:  transition  input  bypass  pipeline-parent 
    -- CP-element group 65: predecessors 
    -- CP-element group 65: 	5 
    -- CP-element group 65: successors 
    -- CP-element group 65:  members (2) 
      -- CP-element group 65: 	 branch_block_stmt_41/do_while_stmt_42/loop_exit/$exit
      -- CP-element group 65: 	 branch_block_stmt_41/do_while_stmt_42/loop_exit/ack
      -- 
    ack_172_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 65_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_42_branch_ack_0, ack => inputPort_1_Daemon_CP_3_elements(65)); -- 
    -- CP-element group 66:  transition  input  bypass  pipeline-parent 
    -- CP-element group 66: predecessors 
    -- CP-element group 66: 	5 
    -- CP-element group 66: successors 
    -- CP-element group 66:  members (2) 
      -- CP-element group 66: 	 branch_block_stmt_41/do_while_stmt_42/loop_taken/$exit
      -- CP-element group 66: 	 branch_block_stmt_41/do_while_stmt_42/loop_taken/ack
      -- 
    ack_176_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 66_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_42_branch_ack_1, ack => inputPort_1_Daemon_CP_3_elements(66)); -- 
    -- CP-element group 67:  transition  bypass  pipeline-parent 
    -- CP-element group 67: predecessors 
    -- CP-element group 67: 	3 
    -- CP-element group 67: successors 
    -- CP-element group 67: 	1 
    -- CP-element group 67:  members (1) 
      -- CP-element group 67: 	 branch_block_stmt_41/do_while_stmt_42/$exit
      -- 
    inputPort_1_Daemon_CP_3_elements(67) <= inputPort_1_Daemon_CP_3_elements(3);
    inputPort_1_Daemon_do_while_stmt_42_terminator_177: loop_terminator -- 
      generic map (name => " inputPort_1_Daemon_do_while_stmt_42_terminator_177", max_iterations_in_flight =>7) 
      port map(loop_body_exit => inputPort_1_Daemon_CP_3_elements(6),loop_continue => inputPort_1_Daemon_CP_3_elements(66),loop_terminate => inputPort_1_Daemon_CP_3_elements(65),loop_back => inputPort_1_Daemon_CP_3_elements(4),loop_exit => inputPort_1_Daemon_CP_3_elements(3),clk => clk, reset => reset); -- 
    phi_stmt_44_phi_seq_77_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= inputPort_1_Daemon_CP_3_elements(22);
      inputPort_1_Daemon_CP_3_elements(25)<= src_sample_reqs(0);
      src_sample_acks(0)  <= inputPort_1_Daemon_CP_3_elements(25);
      inputPort_1_Daemon_CP_3_elements(26)<= src_update_reqs(0);
      src_update_acks(0)  <= inputPort_1_Daemon_CP_3_elements(27);
      inputPort_1_Daemon_CP_3_elements(23) <= phi_mux_reqs(0);
      triggers(1)  <= inputPort_1_Daemon_CP_3_elements(20);
      inputPort_1_Daemon_CP_3_elements(29)<= src_sample_reqs(1);
      src_sample_acks(1)  <= inputPort_1_Daemon_CP_3_elements(31);
      inputPort_1_Daemon_CP_3_elements(30)<= src_update_reqs(1);
      src_update_acks(1)  <= inputPort_1_Daemon_CP_3_elements(32);
      inputPort_1_Daemon_CP_3_elements(21) <= phi_mux_reqs(1);
      phi_stmt_44_phi_seq_77 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_44_phi_seq_77") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => inputPort_1_Daemon_CP_3_elements(11), 
          phi_sample_ack => inputPort_1_Daemon_CP_3_elements(18), 
          phi_update_req => inputPort_1_Daemon_CP_3_elements(14), 
          phi_update_ack => inputPort_1_Daemon_CP_3_elements(19), 
          phi_mux_ack => inputPort_1_Daemon_CP_3_elements(24), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_53_phi_seq_139_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= inputPort_1_Daemon_CP_3_elements(46);
      inputPort_1_Daemon_CP_3_elements(49)<= src_sample_reqs(0);
      src_sample_acks(0)  <= inputPort_1_Daemon_CP_3_elements(49);
      inputPort_1_Daemon_CP_3_elements(50)<= src_update_reqs(0);
      src_update_acks(0)  <= inputPort_1_Daemon_CP_3_elements(51);
      inputPort_1_Daemon_CP_3_elements(47) <= phi_mux_reqs(0);
      triggers(1)  <= inputPort_1_Daemon_CP_3_elements(44);
      inputPort_1_Daemon_CP_3_elements(53)<= src_sample_reqs(1);
      src_sample_acks(1)  <= inputPort_1_Daemon_CP_3_elements(55);
      inputPort_1_Daemon_CP_3_elements(54)<= src_update_reqs(1);
      src_update_acks(1)  <= inputPort_1_Daemon_CP_3_elements(56);
      inputPort_1_Daemon_CP_3_elements(45) <= phi_mux_reqs(1);
      phi_stmt_53_phi_seq_139 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_53_phi_seq_139") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => inputPort_1_Daemon_CP_3_elements(40), 
          phi_sample_ack => inputPort_1_Daemon_CP_3_elements(41), 
          phi_update_req => inputPort_1_Daemon_CP_3_elements(42), 
          phi_update_ack => inputPort_1_Daemon_CP_3_elements(43), 
          phi_mux_ack => inputPort_1_Daemon_CP_3_elements(48), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    entry_tmerge_28_block : block -- 
      signal preds : BooleanArray(0 to 1);
      begin -- 
        preds(0)  <= inputPort_1_Daemon_CP_3_elements(7);
        preds(1)  <= inputPort_1_Daemon_CP_3_elements(8);
        entry_tmerge_28 : transition_merge -- 
          generic map(name => " entry_tmerge_28")
          port map (preds => preds, symbol_out => inputPort_1_Daemon_CP_3_elements(9));
          -- 
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal RPIPE_in_data_1_52_wire : std_logic_vector(31 downto 0);
    signal R_ONE_1_99_wire_constant : std_logic_vector(0 downto 0);
    signal SUB_u16_u16_86_wire : std_logic_vector(15 downto 0);
    signal SUB_u16_u16_89_wire : std_logic_vector(15 downto 0);
    signal count_down_44 : std_logic_vector(15 downto 0);
    signal data_to_outport_102 : std_logic_vector(32 downto 0);
    signal dest_id_68 : std_logic_vector(7 downto 0);
    signal input_word_50 : std_logic_vector(31 downto 0);
    signal konst_105_wire_constant : std_logic_vector(7 downto 0);
    signal konst_114_wire_constant : std_logic_vector(7 downto 0);
    signal konst_130_wire_constant : std_logic_vector(0 downto 0);
    signal konst_55_wire_constant : std_logic_vector(7 downto 0);
    signal konst_62_wire_constant : std_logic_vector(15 downto 0);
    signal konst_85_wire_constant : std_logic_vector(15 downto 0);
    signal konst_88_wire_constant : std_logic_vector(15 downto 0);
    signal last_dest_id_53 : std_logic_vector(7 downto 0);
    signal new_packet_64 : std_logic_vector(0 downto 0);
    signal next_count_down_91 : std_logic_vector(15 downto 0);
    signal next_count_down_91_49_buffered : std_logic_vector(15 downto 0);
    signal next_last_dest_id_97 : std_logic_vector(7 downto 0);
    signal next_last_dest_id_97_56_buffered : std_logic_vector(7 downto 0);
    signal pkt_length_72 : std_logic_vector(15 downto 0);
    signal send_to_1_107 : std_logic_vector(0 downto 0);
    signal send_to_2_116 : std_logic_vector(0 downto 0);
    signal seq_id_76 : std_logic_vector(7 downto 0);
    signal type_cast_48_wire_constant : std_logic_vector(15 downto 0);
    -- 
  begin -- 
    R_ONE_1_99_wire_constant <= "1";
    konst_105_wire_constant <= "00000001";
    konst_114_wire_constant <= "00000010";
    konst_130_wire_constant <= "1";
    konst_55_wire_constant <= "00000000";
    konst_62_wire_constant <= "0000000000000000";
    konst_85_wire_constant <= "0000000000000001";
    konst_88_wire_constant <= "0000000000000001";
    type_cast_48_wire_constant <= "0000000000000000";
    phi_stmt_44: Block -- phi operator 
      signal idata: std_logic_vector(31 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_48_wire_constant & next_count_down_91_49_buffered;
      req <= phi_stmt_44_req_0 & phi_stmt_44_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_44",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 16) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_44_ack_0,
          idata => idata,
          odata => count_down_44,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_44
    phi_stmt_53: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= konst_55_wire_constant & next_last_dest_id_97_56_buffered;
      req <= phi_stmt_53_req_0 & phi_stmt_53_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_53",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_53_ack_0,
          idata => idata,
          odata => last_dest_id_53,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_53
    -- flow-through select operator MUX_90_inst
    next_count_down_91 <= SUB_u16_u16_86_wire when (new_packet_64(0) /=  '0') else SUB_u16_u16_89_wire;
    -- flow-through select operator MUX_96_inst
    next_last_dest_id_97 <= dest_id_68 when (new_packet_64(0) /=  '0') else last_dest_id_53;
    -- flow-through slice operator slice_67_inst
    dest_id_68 <= input_word_50(31 downto 24);
    -- flow-through slice operator slice_71_inst
    pkt_length_72 <= input_word_50(23 downto 8);
    -- flow-through slice operator slice_75_inst
    seq_id_76 <= input_word_50(7 downto 0);
    next_count_down_91_49_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_count_down_91_49_buf_req_0;
      next_count_down_91_49_buf_ack_0<= wack(0);
      rreq(0) <= next_count_down_91_49_buf_req_1;
      next_count_down_91_49_buf_ack_1<= rack(0);
      next_count_down_91_49_buf : InterlockBuffer generic map ( -- 
        name => "next_count_down_91_49_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 16,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_count_down_91,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_count_down_91_49_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_last_dest_id_97_56_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_last_dest_id_97_56_buf_req_0;
      next_last_dest_id_97_56_buf_ack_0<= wack(0);
      rreq(0) <= next_last_dest_id_97_56_buf_req_1;
      next_last_dest_id_97_56_buf_ack_1<= rack(0);
      next_last_dest_id_97_56_buf : InterlockBuffer generic map ( -- 
        name => "next_last_dest_id_97_56_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_last_dest_id_97,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_last_dest_id_97_56_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    -- interlock ssrc_phi_stmt_50
    process(RPIPE_in_data_1_52_wire) -- 
      variable tmp_var : std_logic_vector(31 downto 0); -- 
    begin -- 
      tmp_var := (others => '0'); 
      tmp_var( 31 downto 0) := RPIPE_in_data_1_52_wire(31 downto 0);
      input_word_50 <= tmp_var; -- 
    end process;
    do_while_stmt_42_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= konst_130_wire_constant;
      branch_instance: BranchBase -- 
        generic map( name => "do_while_stmt_42_branch", condition_width => 1,  bypass_flag => true)
        port map( -- 
          condition => condition_sig,
          req => do_while_stmt_42_branch_req_0,
          ack0 => do_while_stmt_42_branch_ack_0,
          ack1 => do_while_stmt_42_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- flow through binary operator CONCAT_u1_u33_101_inst
    process(R_ONE_1_99_wire_constant, input_word_50) -- 
      variable tmp_var : std_logic_vector(32 downto 0); -- 
    begin -- 
      ApConcat_proc(R_ONE_1_99_wire_constant, input_word_50, tmp_var);
      data_to_outport_102 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u16_u1_63_inst
    process(count_down_44) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(count_down_44, konst_62_wire_constant, tmp_var);
      new_packet_64 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_106_inst
    process(next_last_dest_id_97) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_last_dest_id_97, konst_105_wire_constant, tmp_var);
      send_to_1_107 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_115_inst
    process(next_last_dest_id_97) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_last_dest_id_97, konst_114_wire_constant, tmp_var);
      send_to_2_116 <= tmp_var; --
    end process;
    -- flow through binary operator SUB_u16_u16_86_inst
    SUB_u16_u16_86_wire <= std_logic_vector(unsigned(pkt_length_72) - unsigned(konst_85_wire_constant));
    -- flow through binary operator SUB_u16_u16_89_inst
    SUB_u16_u16_89_wire <= std_logic_vector(unsigned(count_down_44) - unsigned(konst_88_wire_constant));
    -- shared inport operator group (0) : RPIPE_in_data_1_52_inst 
    InportGroup_0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_in_data_1_52_inst_req_0;
      RPIPE_in_data_1_52_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_in_data_1_52_inst_req_1;
      RPIPE_in_data_1_52_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      RPIPE_in_data_1_52_wire <= data_out(31 downto 0);
      in_data_1_read_0_gI: SplitGuardInterface generic map(name => "in_data_1_read_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      in_data_1_read_0: InputPortRevised -- 
        generic map ( name => "in_data_1_read_0", data_width => 32,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => False,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => in_data_1_pipe_read_req(0),
          oack => in_data_1_pipe_read_ack(0),
          odata => in_data_1_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : WPIPE_noblock_obuf_1_1_109_inst 
    OutportGroup_0: Block -- 
      signal data_in: std_logic_vector(32 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_noblock_obuf_1_1_109_inst_req_0;
      WPIPE_noblock_obuf_1_1_109_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_noblock_obuf_1_1_109_inst_req_1;
      WPIPE_noblock_obuf_1_1_109_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_to_1_107(0);
      data_in <= data_to_outport_102;
      noblock_obuf_1_1_write_0_gI: SplitGuardInterface generic map(name => "noblock_obuf_1_1_write_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_1_1_write_0: OutputPortRevised -- 
        generic map ( name => "noblock_obuf_1_1", data_width => 33, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => noblock_obuf_1_1_pipe_write_req(0),
          oack => noblock_obuf_1_1_pipe_write_ack(0),
          odata => noblock_obuf_1_1_pipe_write_data(32 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- shared outport operator group (1) : WPIPE_noblock_obuf_1_2_118_inst 
    OutportGroup_1: Block -- 
      signal data_in: std_logic_vector(32 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_noblock_obuf_1_2_118_inst_req_0;
      WPIPE_noblock_obuf_1_2_118_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_noblock_obuf_1_2_118_inst_req_1;
      WPIPE_noblock_obuf_1_2_118_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_to_2_116(0);
      data_in <= data_to_outport_102;
      noblock_obuf_1_2_write_1_gI: SplitGuardInterface generic map(name => "noblock_obuf_1_2_write_1_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_1_2_write_1: OutputPortRevised -- 
        generic map ( name => "noblock_obuf_1_2", data_width => 33, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => noblock_obuf_1_2_pipe_write_req(0),
          oack => noblock_obuf_1_2_pipe_write_ack(0),
          odata => noblock_obuf_1_2_pipe_write_data(32 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 1
    -- 
  end Block; -- data_path
  -- 
end inputPort_1_Daemon_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.switch_2x2_global_package.all;
entity inputPort_2_Daemon is -- 
  generic (tag_length : integer); 
  port ( -- 
    in_data_2_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_2_pipe_read_data : in   std_logic_vector(31 downto 0);
    noblock_obuf_2_1_pipe_write_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_2_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_2_1_pipe_write_data : out  std_logic_vector(32 downto 0);
    noblock_obuf_2_2_pipe_write_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_2_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_2_2_pipe_write_data : out  std_logic_vector(32 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) ;
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic-- 
  );
  -- 
end entity inputPort_2_Daemon;
architecture inputPort_2_Daemon_arch of inputPort_2_Daemon is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal inputPort_2_Daemon_CP_178_start: Boolean;
  signal inputPort_2_Daemon_CP_178_symbol: Boolean;
  -- volatile/operator module components. 
  -- links between control-path and data-path
  signal do_while_stmt_135_branch_req_0 : boolean;
  signal phi_stmt_137_req_1 : boolean;
  signal phi_stmt_137_req_0 : boolean;
  signal phi_stmt_137_ack_0 : boolean;
  signal next_count_down_183_141_buf_req_0 : boolean;
  signal next_count_down_183_141_buf_ack_0 : boolean;
  signal next_count_down_183_141_buf_req_1 : boolean;
  signal next_count_down_183_141_buf_ack_1 : boolean;
  signal RPIPE_in_data_2_144_inst_req_0 : boolean;
  signal RPIPE_in_data_2_144_inst_ack_0 : boolean;
  signal RPIPE_in_data_2_144_inst_req_1 : boolean;
  signal RPIPE_in_data_2_144_inst_ack_1 : boolean;
  signal phi_stmt_145_req_1 : boolean;
  signal phi_stmt_145_req_0 : boolean;
  signal phi_stmt_145_ack_0 : boolean;
  signal next_last_dest_id_189_148_buf_req_0 : boolean;
  signal next_last_dest_id_189_148_buf_ack_0 : boolean;
  signal next_last_dest_id_189_148_buf_req_1 : boolean;
  signal next_last_dest_id_189_148_buf_ack_1 : boolean;
  signal WPIPE_noblock_obuf_2_1_201_inst_req_0 : boolean;
  signal WPIPE_noblock_obuf_2_1_201_inst_ack_0 : boolean;
  signal WPIPE_noblock_obuf_2_1_201_inst_req_1 : boolean;
  signal WPIPE_noblock_obuf_2_1_201_inst_ack_1 : boolean;
  signal WPIPE_noblock_obuf_2_2_210_inst_req_0 : boolean;
  signal WPIPE_noblock_obuf_2_2_210_inst_ack_0 : boolean;
  signal WPIPE_noblock_obuf_2_2_210_inst_req_1 : boolean;
  signal WPIPE_noblock_obuf_2_2_210_inst_ack_1 : boolean;
  signal do_while_stmt_135_branch_ack_0 : boolean;
  signal do_while_stmt_135_branch_ack_1 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "inputPort_2_Daemon_input_buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj_in_buffer_unload_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  inputPort_2_Daemon_CP_178_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "inputPort_2_Daemon_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 0) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= inputPort_2_Daemon_CP_178_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj_out_buffer_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= inputPort_2_Daemon_CP_178_start & tag_ilock_write_ack_symbol;
    gj_tag_ilock_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= inputPort_2_Daemon_CP_178_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  inputPort_2_Daemon_CP_178: Block -- control-path 
    signal inputPort_2_Daemon_CP_178_elements: BooleanArray(67 downto 0);
    -- 
  begin -- 
    inputPort_2_Daemon_CP_178_elements(0) <= inputPort_2_Daemon_CP_178_start;
    inputPort_2_Daemon_CP_178_symbol <= inputPort_2_Daemon_CP_178_elements(1);
    -- CP-element group 0:  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	2 
    -- CP-element group 0:  members (4) 
      -- CP-element group 0: 	 $entry
      -- CP-element group 0: 	 branch_block_stmt_134/$entry
      -- CP-element group 0: 	 branch_block_stmt_134/branch_block_stmt_134__entry__
      -- CP-element group 0: 	 branch_block_stmt_134/do_while_stmt_135__entry__
      -- 
    -- CP-element group 1:  transition  place  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	67 
    -- CP-element group 1: successors 
    -- CP-element group 1:  members (4) 
      -- CP-element group 1: 	 $exit
      -- CP-element group 1: 	 branch_block_stmt_134/$exit
      -- CP-element group 1: 	 branch_block_stmt_134/branch_block_stmt_134__exit__
      -- CP-element group 1: 	 branch_block_stmt_134/do_while_stmt_135__exit__
      -- 
    inputPort_2_Daemon_CP_178_elements(1) <= inputPort_2_Daemon_CP_178_elements(67);
    -- CP-element group 2:  transition  place  bypass  pipeline-parent 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	0 
    -- CP-element group 2: successors 
    -- CP-element group 2: 	8 
    -- CP-element group 2:  members (2) 
      -- CP-element group 2: 	 branch_block_stmt_134/do_while_stmt_135/$entry
      -- CP-element group 2: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135__entry__
      -- 
    inputPort_2_Daemon_CP_178_elements(2) <= inputPort_2_Daemon_CP_178_elements(0);
    -- CP-element group 3:  merge  place  bypass  pipeline-parent 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	67 
    -- CP-element group 3:  members (1) 
      -- CP-element group 3: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135__exit__
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(3) is bound as output of CP function.
    -- CP-element group 4:  merge  place  bypass  pipeline-parent 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: successors 
    -- CP-element group 4: 	7 
    -- CP-element group 4:  members (1) 
      -- CP-element group 4: 	 branch_block_stmt_134/do_while_stmt_135/loop_back
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(4) is bound as output of CP function.
    -- CP-element group 5:  branch  transition  place  bypass  pipeline-parent 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	10 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	65 
    -- CP-element group 5: 	66 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_134/do_while_stmt_135/condition_done
      -- CP-element group 5: 	 branch_block_stmt_134/do_while_stmt_135/loop_exit/$entry
      -- CP-element group 5: 	 branch_block_stmt_134/do_while_stmt_135/loop_taken/$entry
      -- 
    inputPort_2_Daemon_CP_178_elements(5) <= inputPort_2_Daemon_CP_178_elements(10);
    -- CP-element group 6:  branch  place  bypass  pipeline-parent 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	64 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (1) 
      -- CP-element group 6: 	 branch_block_stmt_134/do_while_stmt_135/loop_body_done
      -- 
    inputPort_2_Daemon_CP_178_elements(6) <= inputPort_2_Daemon_CP_178_elements(64);
    -- CP-element group 7:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	4 
    -- CP-element group 7: successors 
    -- CP-element group 7: 	20 
    -- CP-element group 7: 	44 
    -- CP-element group 7:  members (1) 
      -- CP-element group 7: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/back_edge_to_loop_body
      -- 
    inputPort_2_Daemon_CP_178_elements(7) <= inputPort_2_Daemon_CP_178_elements(4);
    -- CP-element group 8:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	2 
    -- CP-element group 8: successors 
    -- CP-element group 8: 	22 
    -- CP-element group 8: 	46 
    -- CP-element group 8:  members (1) 
      -- CP-element group 8: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/first_time_through_loop_body
      -- 
    inputPort_2_Daemon_CP_178_elements(8) <= inputPort_2_Daemon_CP_178_elements(2);
    -- CP-element group 9:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	11 
    -- CP-element group 9: 	16 
    -- CP-element group 9: 	17 
    -- CP-element group 9: 	33 
    -- CP-element group 9: 	38 
    -- CP-element group 9: 	39 
    -- CP-element group 9: 	63 
    -- CP-element group 9:  members (3) 
      -- CP-element group 9: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/$entry
      -- CP-element group 9: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/loop_body_start
      -- CP-element group 9: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_142_sample_start_
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(9) is bound as output of CP function.
    -- CP-element group 10:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	13 
    -- CP-element group 10: 	15 
    -- CP-element group 10: 	63 
    -- CP-element group 10: successors 
    -- CP-element group 10: 	5 
    -- CP-element group 10:  members (1) 
      -- CP-element group 10: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/condition_evaluated
      -- 
    condition_evaluated_202_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " condition_evaluated_202_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(10), ack => do_while_stmt_135_branch_req_0); -- 
    inputPort_2_Daemon_cp_element_group_10: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_10"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(13) & inputPort_2_Daemon_CP_178_elements(15) & inputPort_2_Daemon_CP_178_elements(63);
      gj_inputPort_2_Daemon_cp_element_group_10 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(10), clk => clk, reset => reset); --
    end block;
    -- CP-element group 11:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	9 
    -- CP-element group 11: 	16 
    -- CP-element group 11: 	38 
    -- CP-element group 11: marked-predecessors 
    -- CP-element group 11: 	15 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	34 
    -- CP-element group 11: 	40 
    -- CP-element group 11:  members (2) 
      -- CP-element group 11: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/aggregated_phi_sample_req
      -- CP-element group 11: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_sample_start__ps
      -- 
    inputPort_2_Daemon_cp_element_group_11: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 7,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_11"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(9) & inputPort_2_Daemon_CP_178_elements(16) & inputPort_2_Daemon_CP_178_elements(38) & inputPort_2_Daemon_CP_178_elements(15);
      gj_inputPort_2_Daemon_cp_element_group_11 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(11), clk => clk, reset => reset); --
    end block;
    -- CP-element group 12:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	18 
    -- CP-element group 12: 	36 
    -- CP-element group 12: 	41 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	13 
    -- CP-element group 12: 	64 
    -- CP-element group 12: marked-successors 
    -- CP-element group 12: 	16 
    -- CP-element group 12: 	38 
    -- CP-element group 12:  members (4) 
      -- CP-element group 12: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/aggregated_phi_sample_ack
      -- CP-element group 12: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_142_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_sample_completed_
      -- 
    inputPort_2_Daemon_cp_element_group_12: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_12"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(18) & inputPort_2_Daemon_CP_178_elements(36) & inputPort_2_Daemon_CP_178_elements(41);
      gj_inputPort_2_Daemon_cp_element_group_12 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(12), clk => clk, reset => reset); --
    end block;
    -- CP-element group 13:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	12 
    -- CP-element group 13: successors 
    -- CP-element group 13: 	10 
    -- CP-element group 13:  members (1) 
      -- CP-element group 13: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/aggregated_phi_sample_ack_d
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(13) is a control-delay.
    cp_element_13_delay: control_delay_element  generic map(name => " 13_delay", delay_value => 1)  port map(req => inputPort_2_Daemon_CP_178_elements(12), ack => inputPort_2_Daemon_CP_178_elements(13), clk => clk, reset =>reset);
    -- CP-element group 14:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	17 
    -- CP-element group 14: 	33 
    -- CP-element group 14: 	39 
    -- CP-element group 14: successors 
    -- CP-element group 14: 	35 
    -- CP-element group 14: 	42 
    -- CP-element group 14:  members (2) 
      -- CP-element group 14: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/aggregated_phi_update_req
      -- CP-element group 14: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_update_start__ps
      -- 
    inputPort_2_Daemon_cp_element_group_14: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_14"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(17) & inputPort_2_Daemon_CP_178_elements(33) & inputPort_2_Daemon_CP_178_elements(39);
      gj_inputPort_2_Daemon_cp_element_group_14 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(14), clk => clk, reset => reset); --
    end block;
    -- CP-element group 15:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	19 
    -- CP-element group 15: 	37 
    -- CP-element group 15: 	43 
    -- CP-element group 15: successors 
    -- CP-element group 15: 	10 
    -- CP-element group 15: marked-successors 
    -- CP-element group 15: 	11 
    -- CP-element group 15:  members (1) 
      -- CP-element group 15: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/aggregated_phi_update_ack
      -- 
    inputPort_2_Daemon_cp_element_group_15: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_15"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(19) & inputPort_2_Daemon_CP_178_elements(37) & inputPort_2_Daemon_CP_178_elements(43);
      gj_inputPort_2_Daemon_cp_element_group_15 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(15), clk => clk, reset => reset); --
    end block;
    -- CP-element group 16:  join  transition  bypass  pipeline-parent 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	9 
    -- CP-element group 16: marked-predecessors 
    -- CP-element group 16: 	12 
    -- CP-element group 16: successors 
    -- CP-element group 16: 	11 
    -- CP-element group 16:  members (1) 
      -- CP-element group 16: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_sample_start_
      -- 
    inputPort_2_Daemon_cp_element_group_16: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_16"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(9) & inputPort_2_Daemon_CP_178_elements(12);
      gj_inputPort_2_Daemon_cp_element_group_16 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(16), clk => clk, reset => reset); --
    end block;
    -- CP-element group 17:  join  transition  bypass  pipeline-parent 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	9 
    -- CP-element group 17: marked-predecessors 
    -- CP-element group 17: 	58 
    -- CP-element group 17: 	61 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	14 
    -- CP-element group 17:  members (1) 
      -- CP-element group 17: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_update_start_
      -- 
    inputPort_2_Daemon_cp_element_group_17: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_17"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(9) & inputPort_2_Daemon_CP_178_elements(58) & inputPort_2_Daemon_CP_178_elements(61);
      gj_inputPort_2_Daemon_cp_element_group_17 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(17), clk => clk, reset => reset); --
    end block;
    -- CP-element group 18:  join  transition  bypass  pipeline-parent 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: successors 
    -- CP-element group 18: 	12 
    -- CP-element group 18:  members (1) 
      -- CP-element group 18: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_sample_completed__ps
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(18) is bound as output of CP function.
    -- CP-element group 19:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	15 
    -- CP-element group 19: 	57 
    -- CP-element group 19: 	60 
    -- CP-element group 19:  members (2) 
      -- CP-element group 19: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_update_completed_
      -- CP-element group 19: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_update_completed__ps
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(19) is bound as output of CP function.
    -- CP-element group 20:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	7 
    -- CP-element group 20: successors 
    -- CP-element group 20:  members (1) 
      -- CP-element group 20: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_loopback_trigger
      -- 
    inputPort_2_Daemon_CP_178_elements(20) <= inputPort_2_Daemon_CP_178_elements(7);
    -- CP-element group 21:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: successors 
    -- CP-element group 21:  members (2) 
      -- CP-element group 21: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_loopback_sample_req
      -- CP-element group 21: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_loopback_sample_req_ps
      -- 
    phi_stmt_137_loopback_sample_req_218_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_137_loopback_sample_req_218_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(21), ack => phi_stmt_137_req_1); -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(21) is bound as output of CP function.
    -- CP-element group 22:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	8 
    -- CP-element group 22: successors 
    -- CP-element group 22:  members (1) 
      -- CP-element group 22: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_entry_trigger
      -- 
    inputPort_2_Daemon_CP_178_elements(22) <= inputPort_2_Daemon_CP_178_elements(8);
    -- CP-element group 23:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: successors 
    -- CP-element group 23:  members (2) 
      -- CP-element group 23: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_entry_sample_req
      -- CP-element group 23: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_entry_sample_req_ps
      -- 
    phi_stmt_137_entry_sample_req_221_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_137_entry_sample_req_221_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(23), ack => phi_stmt_137_req_0); -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(23) is bound as output of CP function.
    -- CP-element group 24:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: successors 
    -- CP-element group 24:  members (2) 
      -- CP-element group 24: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_phi_mux_ack
      -- CP-element group 24: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_137_phi_mux_ack_ps
      -- 
    phi_stmt_137_phi_mux_ack_224_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 24_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_137_ack_0, ack => inputPort_2_Daemon_CP_178_elements(24)); -- 
    -- CP-element group 25:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: successors 
    -- CP-element group 25:  members (4) 
      -- CP-element group 25: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/type_cast_140_sample_start__ps
      -- CP-element group 25: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/type_cast_140_sample_completed__ps
      -- CP-element group 25: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/type_cast_140_sample_start_
      -- CP-element group 25: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/type_cast_140_sample_completed_
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(25) is bound as output of CP function.
    -- CP-element group 26:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 26: predecessors 
    -- CP-element group 26: successors 
    -- CP-element group 26: 	28 
    -- CP-element group 26:  members (2) 
      -- CP-element group 26: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/type_cast_140_update_start__ps
      -- CP-element group 26: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/type_cast_140_update_start_
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(26) is bound as output of CP function.
    -- CP-element group 27:  join  transition  bypass  pipeline-parent 
    -- CP-element group 27: predecessors 
    -- CP-element group 27: 	28 
    -- CP-element group 27: successors 
    -- CP-element group 27:  members (1) 
      -- CP-element group 27: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/type_cast_140_update_completed__ps
      -- 
    inputPort_2_Daemon_CP_178_elements(27) <= inputPort_2_Daemon_CP_178_elements(28);
    -- CP-element group 28:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 28: predecessors 
    -- CP-element group 28: 	26 
    -- CP-element group 28: successors 
    -- CP-element group 28: 	27 
    -- CP-element group 28:  members (1) 
      -- CP-element group 28: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/type_cast_140_update_completed_
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(28) is a control-delay.
    cp_element_28_delay: control_delay_element  generic map(name => " 28_delay", delay_value => 1)  port map(req => inputPort_2_Daemon_CP_178_elements(26), ack => inputPort_2_Daemon_CP_178_elements(28), clk => clk, reset =>reset);
    -- CP-element group 29:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 29: predecessors 
    -- CP-element group 29: successors 
    -- CP-element group 29: 	31 
    -- CP-element group 29:  members (4) 
      -- CP-element group 29: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_sample_start__ps
      -- CP-element group 29: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_sample_start_
      -- CP-element group 29: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_Sample/$entry
      -- CP-element group 29: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_Sample/req
      -- 
    req_245_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_245_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(29), ack => next_count_down_183_141_buf_req_0); -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(29) is bound as output of CP function.
    -- CP-element group 30:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 30: predecessors 
    -- CP-element group 30: successors 
    -- CP-element group 30: 	32 
    -- CP-element group 30:  members (4) 
      -- CP-element group 30: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_update_start__ps
      -- CP-element group 30: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_update_start_
      -- CP-element group 30: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_Update/$entry
      -- CP-element group 30: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_Update/req
      -- 
    req_250_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_250_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(30), ack => next_count_down_183_141_buf_req_1); -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(30) is bound as output of CP function.
    -- CP-element group 31:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 31: predecessors 
    -- CP-element group 31: 	29 
    -- CP-element group 31: successors 
    -- CP-element group 31:  members (4) 
      -- CP-element group 31: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_sample_completed__ps
      -- CP-element group 31: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_sample_completed_
      -- CP-element group 31: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_Sample/$exit
      -- CP-element group 31: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_Sample/ack
      -- 
    ack_246_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 31_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_down_183_141_buf_ack_0, ack => inputPort_2_Daemon_CP_178_elements(31)); -- 
    -- CP-element group 32:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 32: predecessors 
    -- CP-element group 32: 	30 
    -- CP-element group 32: successors 
    -- CP-element group 32:  members (4) 
      -- CP-element group 32: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_update_completed__ps
      -- CP-element group 32: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_update_completed_
      -- CP-element group 32: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_Update/$exit
      -- CP-element group 32: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_count_down_141_Update/ack
      -- 
    ack_251_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 32_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_count_down_183_141_buf_ack_1, ack => inputPort_2_Daemon_CP_178_elements(32)); -- 
    -- CP-element group 33:  join  transition  bypass  pipeline-parent 
    -- CP-element group 33: predecessors 
    -- CP-element group 33: 	9 
    -- CP-element group 33: marked-predecessors 
    -- CP-element group 33: 	58 
    -- CP-element group 33: 	61 
    -- CP-element group 33: successors 
    -- CP-element group 33: 	14 
    -- CP-element group 33:  members (1) 
      -- CP-element group 33: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_142_update_start_
      -- 
    inputPort_2_Daemon_cp_element_group_33: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_33"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(9) & inputPort_2_Daemon_CP_178_elements(58) & inputPort_2_Daemon_CP_178_elements(61);
      gj_inputPort_2_Daemon_cp_element_group_33 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(33), clk => clk, reset => reset); --
    end block;
    -- CP-element group 34:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 34: predecessors 
    -- CP-element group 34: 	11 
    -- CP-element group 34: marked-predecessors 
    -- CP-element group 34: 	37 
    -- CP-element group 34: successors 
    -- CP-element group 34: 	36 
    -- CP-element group 34:  members (3) 
      -- CP-element group 34: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_sample_start_
      -- CP-element group 34: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_Sample/$entry
      -- CP-element group 34: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_Sample/rr
      -- 
    rr_264_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_264_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(34), ack => RPIPE_in_data_2_144_inst_req_0); -- 
    inputPort_2_Daemon_cp_element_group_34: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_34"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(11) & inputPort_2_Daemon_CP_178_elements(37);
      gj_inputPort_2_Daemon_cp_element_group_34 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(34), clk => clk, reset => reset); --
    end block;
    -- CP-element group 35:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 35: predecessors 
    -- CP-element group 35: 	14 
    -- CP-element group 35: 	36 
    -- CP-element group 35: successors 
    -- CP-element group 35: 	37 
    -- CP-element group 35:  members (3) 
      -- CP-element group 35: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_update_start_
      -- CP-element group 35: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_Update/$entry
      -- CP-element group 35: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_Update/cr
      -- 
    cr_269_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_269_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(35), ack => RPIPE_in_data_2_144_inst_req_1); -- 
    inputPort_2_Daemon_cp_element_group_35: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_35"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(14) & inputPort_2_Daemon_CP_178_elements(36);
      gj_inputPort_2_Daemon_cp_element_group_35 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(35), clk => clk, reset => reset); --
    end block;
    -- CP-element group 36:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 36: predecessors 
    -- CP-element group 36: 	34 
    -- CP-element group 36: successors 
    -- CP-element group 36: 	12 
    -- CP-element group 36: 	35 
    -- CP-element group 36:  members (3) 
      -- CP-element group 36: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_sample_completed_
      -- CP-element group 36: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_Sample/$exit
      -- CP-element group 36: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_Sample/ra
      -- 
    ra_265_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 36_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_2_144_inst_ack_0, ack => inputPort_2_Daemon_CP_178_elements(36)); -- 
    -- CP-element group 37:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 37: predecessors 
    -- CP-element group 37: 	35 
    -- CP-element group 37: successors 
    -- CP-element group 37: 	15 
    -- CP-element group 37: 	57 
    -- CP-element group 37: 	60 
    -- CP-element group 37: marked-successors 
    -- CP-element group 37: 	34 
    -- CP-element group 37:  members (4) 
      -- CP-element group 37: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_142_update_completed_
      -- CP-element group 37: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_update_completed_
      -- CP-element group 37: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_Update/$exit
      -- CP-element group 37: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/RPIPE_in_data_2_144_Update/ca
      -- 
    ca_270_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 37_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_in_data_2_144_inst_ack_1, ack => inputPort_2_Daemon_CP_178_elements(37)); -- 
    -- CP-element group 38:  join  transition  bypass  pipeline-parent 
    -- CP-element group 38: predecessors 
    -- CP-element group 38: 	9 
    -- CP-element group 38: marked-predecessors 
    -- CP-element group 38: 	12 
    -- CP-element group 38: successors 
    -- CP-element group 38: 	11 
    -- CP-element group 38:  members (1) 
      -- CP-element group 38: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_sample_start_
      -- 
    inputPort_2_Daemon_cp_element_group_38: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_38"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(9) & inputPort_2_Daemon_CP_178_elements(12);
      gj_inputPort_2_Daemon_cp_element_group_38 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(38), clk => clk, reset => reset); --
    end block;
    -- CP-element group 39:  join  transition  bypass  pipeline-parent 
    -- CP-element group 39: predecessors 
    -- CP-element group 39: 	9 
    -- CP-element group 39: marked-predecessors 
    -- CP-element group 39: 	58 
    -- CP-element group 39: 	61 
    -- CP-element group 39: successors 
    -- CP-element group 39: 	14 
    -- CP-element group 39:  members (1) 
      -- CP-element group 39: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_update_start_
      -- 
    inputPort_2_Daemon_cp_element_group_39: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 1,2 => 1);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_39"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(9) & inputPort_2_Daemon_CP_178_elements(58) & inputPort_2_Daemon_CP_178_elements(61);
      gj_inputPort_2_Daemon_cp_element_group_39 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(39), clk => clk, reset => reset); --
    end block;
    -- CP-element group 40:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 40: predecessors 
    -- CP-element group 40: 	11 
    -- CP-element group 40: successors 
    -- CP-element group 40:  members (1) 
      -- CP-element group 40: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_sample_start__ps
      -- 
    inputPort_2_Daemon_CP_178_elements(40) <= inputPort_2_Daemon_CP_178_elements(11);
    -- CP-element group 41:  join  transition  bypass  pipeline-parent 
    -- CP-element group 41: predecessors 
    -- CP-element group 41: successors 
    -- CP-element group 41: 	12 
    -- CP-element group 41:  members (1) 
      -- CP-element group 41: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_sample_completed__ps
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(41) is bound as output of CP function.
    -- CP-element group 42:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 42: predecessors 
    -- CP-element group 42: 	14 
    -- CP-element group 42: successors 
    -- CP-element group 42:  members (1) 
      -- CP-element group 42: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_update_start__ps
      -- 
    inputPort_2_Daemon_CP_178_elements(42) <= inputPort_2_Daemon_CP_178_elements(14);
    -- CP-element group 43:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 43: predecessors 
    -- CP-element group 43: successors 
    -- CP-element group 43: 	15 
    -- CP-element group 43: 	57 
    -- CP-element group 43: 	60 
    -- CP-element group 43:  members (2) 
      -- CP-element group 43: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_update_completed_
      -- CP-element group 43: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_update_completed__ps
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(43) is bound as output of CP function.
    -- CP-element group 44:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 44: predecessors 
    -- CP-element group 44: 	7 
    -- CP-element group 44: successors 
    -- CP-element group 44:  members (1) 
      -- CP-element group 44: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_loopback_trigger
      -- 
    inputPort_2_Daemon_CP_178_elements(44) <= inputPort_2_Daemon_CP_178_elements(7);
    -- CP-element group 45:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 45: predecessors 
    -- CP-element group 45: successors 
    -- CP-element group 45:  members (2) 
      -- CP-element group 45: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_loopback_sample_req
      -- CP-element group 45: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_loopback_sample_req_ps
      -- 
    phi_stmt_145_loopback_sample_req_280_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_145_loopback_sample_req_280_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(45), ack => phi_stmt_145_req_1); -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(45) is bound as output of CP function.
    -- CP-element group 46:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 46: predecessors 
    -- CP-element group 46: 	8 
    -- CP-element group 46: successors 
    -- CP-element group 46:  members (1) 
      -- CP-element group 46: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_entry_trigger
      -- 
    inputPort_2_Daemon_CP_178_elements(46) <= inputPort_2_Daemon_CP_178_elements(8);
    -- CP-element group 47:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 47: predecessors 
    -- CP-element group 47: successors 
    -- CP-element group 47:  members (2) 
      -- CP-element group 47: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_entry_sample_req
      -- CP-element group 47: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_entry_sample_req_ps
      -- 
    phi_stmt_145_entry_sample_req_283_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_145_entry_sample_req_283_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(47), ack => phi_stmt_145_req_0); -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(47) is bound as output of CP function.
    -- CP-element group 48:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 48: predecessors 
    -- CP-element group 48: successors 
    -- CP-element group 48:  members (2) 
      -- CP-element group 48: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_phi_mux_ack
      -- CP-element group 48: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/phi_stmt_145_phi_mux_ack_ps
      -- 
    phi_stmt_145_phi_mux_ack_286_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 48_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_145_ack_0, ack => inputPort_2_Daemon_CP_178_elements(48)); -- 
    -- CP-element group 49:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 49: predecessors 
    -- CP-element group 49: successors 
    -- CP-element group 49:  members (4) 
      -- CP-element group 49: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/konst_147_sample_start__ps
      -- CP-element group 49: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/konst_147_sample_completed__ps
      -- CP-element group 49: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/konst_147_sample_start_
      -- CP-element group 49: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/konst_147_sample_completed_
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(49) is bound as output of CP function.
    -- CP-element group 50:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 50: predecessors 
    -- CP-element group 50: successors 
    -- CP-element group 50: 	52 
    -- CP-element group 50:  members (2) 
      -- CP-element group 50: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/konst_147_update_start__ps
      -- CP-element group 50: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/konst_147_update_start_
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(50) is bound as output of CP function.
    -- CP-element group 51:  join  transition  bypass  pipeline-parent 
    -- CP-element group 51: predecessors 
    -- CP-element group 51: 	52 
    -- CP-element group 51: successors 
    -- CP-element group 51:  members (1) 
      -- CP-element group 51: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/konst_147_update_completed__ps
      -- 
    inputPort_2_Daemon_CP_178_elements(51) <= inputPort_2_Daemon_CP_178_elements(52);
    -- CP-element group 52:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 52: predecessors 
    -- CP-element group 52: 	50 
    -- CP-element group 52: successors 
    -- CP-element group 52: 	51 
    -- CP-element group 52:  members (1) 
      -- CP-element group 52: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/konst_147_update_completed_
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(52) is a control-delay.
    cp_element_52_delay: control_delay_element  generic map(name => " 52_delay", delay_value => 1)  port map(req => inputPort_2_Daemon_CP_178_elements(50), ack => inputPort_2_Daemon_CP_178_elements(52), clk => clk, reset =>reset);
    -- CP-element group 53:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 53: predecessors 
    -- CP-element group 53: successors 
    -- CP-element group 53: 	55 
    -- CP-element group 53:  members (4) 
      -- CP-element group 53: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_sample_start__ps
      -- CP-element group 53: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_sample_start_
      -- CP-element group 53: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_Sample/$entry
      -- CP-element group 53: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_Sample/req
      -- 
    req_307_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_307_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(53), ack => next_last_dest_id_189_148_buf_req_0); -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(53) is bound as output of CP function.
    -- CP-element group 54:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 54: predecessors 
    -- CP-element group 54: successors 
    -- CP-element group 54: 	56 
    -- CP-element group 54:  members (4) 
      -- CP-element group 54: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_update_start__ps
      -- CP-element group 54: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_update_start_
      -- CP-element group 54: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_Update/$entry
      -- CP-element group 54: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_Update/req
      -- 
    req_312_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_312_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(54), ack => next_last_dest_id_189_148_buf_req_1); -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(54) is bound as output of CP function.
    -- CP-element group 55:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 55: predecessors 
    -- CP-element group 55: 	53 
    -- CP-element group 55: successors 
    -- CP-element group 55:  members (4) 
      -- CP-element group 55: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_sample_completed__ps
      -- CP-element group 55: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_sample_completed_
      -- CP-element group 55: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_Sample/$exit
      -- CP-element group 55: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_Sample/ack
      -- 
    ack_308_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 55_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_last_dest_id_189_148_buf_ack_0, ack => inputPort_2_Daemon_CP_178_elements(55)); -- 
    -- CP-element group 56:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 56: predecessors 
    -- CP-element group 56: 	54 
    -- CP-element group 56: successors 
    -- CP-element group 56:  members (4) 
      -- CP-element group 56: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_update_completed__ps
      -- CP-element group 56: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_update_completed_
      -- CP-element group 56: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_Update/$exit
      -- CP-element group 56: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/R_next_last_dest_id_148_Update/ack
      -- 
    ack_313_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 56_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_last_dest_id_189_148_buf_ack_1, ack => inputPort_2_Daemon_CP_178_elements(56)); -- 
    -- CP-element group 57:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 57: predecessors 
    -- CP-element group 57: 	19 
    -- CP-element group 57: 	37 
    -- CP-element group 57: 	43 
    -- CP-element group 57: marked-predecessors 
    -- CP-element group 57: 	59 
    -- CP-element group 57: successors 
    -- CP-element group 57: 	58 
    -- CP-element group 57:  members (3) 
      -- CP-element group 57: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_sample_start_
      -- CP-element group 57: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_Sample/$entry
      -- CP-element group 57: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_Sample/req
      -- 
    req_322_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_322_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(57), ack => WPIPE_noblock_obuf_2_1_201_inst_req_0); -- 
    inputPort_2_Daemon_cp_element_group_57: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_57"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(19) & inputPort_2_Daemon_CP_178_elements(37) & inputPort_2_Daemon_CP_178_elements(43) & inputPort_2_Daemon_CP_178_elements(59);
      gj_inputPort_2_Daemon_cp_element_group_57 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(57), clk => clk, reset => reset); --
    end block;
    -- CP-element group 58:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 58: predecessors 
    -- CP-element group 58: 	57 
    -- CP-element group 58: successors 
    -- CP-element group 58: 	59 
    -- CP-element group 58: marked-successors 
    -- CP-element group 58: 	17 
    -- CP-element group 58: 	33 
    -- CP-element group 58: 	39 
    -- CP-element group 58:  members (6) 
      -- CP-element group 58: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_sample_completed_
      -- CP-element group 58: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_update_start_
      -- CP-element group 58: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_Sample/$exit
      -- CP-element group 58: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_Sample/ack
      -- CP-element group 58: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_Update/$entry
      -- CP-element group 58: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_Update/req
      -- 
    ack_323_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 58_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_2_1_201_inst_ack_0, ack => inputPort_2_Daemon_CP_178_elements(58)); -- 
    req_327_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_327_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(58), ack => WPIPE_noblock_obuf_2_1_201_inst_req_1); -- 
    -- CP-element group 59:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 59: predecessors 
    -- CP-element group 59: 	58 
    -- CP-element group 59: successors 
    -- CP-element group 59: 	64 
    -- CP-element group 59: marked-successors 
    -- CP-element group 59: 	57 
    -- CP-element group 59:  members (3) 
      -- CP-element group 59: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_update_completed_
      -- CP-element group 59: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_Update/$exit
      -- CP-element group 59: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_1_201_Update/ack
      -- 
    ack_328_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 59_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_2_1_201_inst_ack_1, ack => inputPort_2_Daemon_CP_178_elements(59)); -- 
    -- CP-element group 60:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 60: predecessors 
    -- CP-element group 60: 	19 
    -- CP-element group 60: 	37 
    -- CP-element group 60: 	43 
    -- CP-element group 60: marked-predecessors 
    -- CP-element group 60: 	62 
    -- CP-element group 60: successors 
    -- CP-element group 60: 	61 
    -- CP-element group 60:  members (3) 
      -- CP-element group 60: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_sample_start_
      -- CP-element group 60: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_Sample/$entry
      -- CP-element group 60: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_Sample/req
      -- 
    req_336_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_336_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(60), ack => WPIPE_noblock_obuf_2_2_210_inst_req_0); -- 
    inputPort_2_Daemon_cp_element_group_60: block -- 
      constant place_capacities: IntegerArray(0 to 3) := (0 => 1,1 => 1,2 => 1,3 => 1);
      constant place_markings: IntegerArray(0 to 3)  := (0 => 0,1 => 0,2 => 0,3 => 1);
      constant place_delays: IntegerArray(0 to 3) := (0 => 0,1 => 0,2 => 0,3 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_60"; 
      signal preds: BooleanArray(1 to 4); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(19) & inputPort_2_Daemon_CP_178_elements(37) & inputPort_2_Daemon_CP_178_elements(43) & inputPort_2_Daemon_CP_178_elements(62);
      gj_inputPort_2_Daemon_cp_element_group_60 : generic_join generic map(name => joinName, number_of_predecessors => 4, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(60), clk => clk, reset => reset); --
    end block;
    -- CP-element group 61:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 61: predecessors 
    -- CP-element group 61: 	60 
    -- CP-element group 61: successors 
    -- CP-element group 61: 	62 
    -- CP-element group 61: marked-successors 
    -- CP-element group 61: 	17 
    -- CP-element group 61: 	33 
    -- CP-element group 61: 	39 
    -- CP-element group 61:  members (6) 
      -- CP-element group 61: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_sample_completed_
      -- CP-element group 61: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_update_start_
      -- CP-element group 61: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_Sample/$exit
      -- CP-element group 61: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_Sample/ack
      -- CP-element group 61: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_Update/$entry
      -- CP-element group 61: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_Update/req
      -- 
    ack_337_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 61_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_2_2_210_inst_ack_0, ack => inputPort_2_Daemon_CP_178_elements(61)); -- 
    req_341_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_341_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => inputPort_2_Daemon_CP_178_elements(61), ack => WPIPE_noblock_obuf_2_2_210_inst_req_1); -- 
    -- CP-element group 62:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 62: predecessors 
    -- CP-element group 62: 	61 
    -- CP-element group 62: successors 
    -- CP-element group 62: 	64 
    -- CP-element group 62: marked-successors 
    -- CP-element group 62: 	60 
    -- CP-element group 62:  members (3) 
      -- CP-element group 62: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_update_completed_
      -- CP-element group 62: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_Update/$exit
      -- CP-element group 62: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/WPIPE_noblock_obuf_2_2_210_Update/ack
      -- 
    ack_342_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 62_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_noblock_obuf_2_2_210_inst_ack_1, ack => inputPort_2_Daemon_CP_178_elements(62)); -- 
    -- CP-element group 63:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 63: predecessors 
    -- CP-element group 63: 	9 
    -- CP-element group 63: successors 
    -- CP-element group 63: 	10 
    -- CP-element group 63:  members (1) 
      -- CP-element group 63: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/loop_body_delay_to_condition_start
      -- 
    -- Element group inputPort_2_Daemon_CP_178_elements(63) is a control-delay.
    cp_element_63_delay: control_delay_element  generic map(name => " 63_delay", delay_value => 1)  port map(req => inputPort_2_Daemon_CP_178_elements(9), ack => inputPort_2_Daemon_CP_178_elements(63), clk => clk, reset =>reset);
    -- CP-element group 64:  join  transition  bypass  pipeline-parent 
    -- CP-element group 64: predecessors 
    -- CP-element group 64: 	12 
    -- CP-element group 64: 	59 
    -- CP-element group 64: 	62 
    -- CP-element group 64: successors 
    -- CP-element group 64: 	6 
    -- CP-element group 64:  members (1) 
      -- CP-element group 64: 	 branch_block_stmt_134/do_while_stmt_135/do_while_stmt_135_loop_body/$exit
      -- 
    inputPort_2_Daemon_cp_element_group_64: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 38) := "inputPort_2_Daemon_cp_element_group_64"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= inputPort_2_Daemon_CP_178_elements(12) & inputPort_2_Daemon_CP_178_elements(59) & inputPort_2_Daemon_CP_178_elements(62);
      gj_inputPort_2_Daemon_cp_element_group_64 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(64), clk => clk, reset => reset); --
    end block;
    -- CP-element group 65:  transition  input  bypass  pipeline-parent 
    -- CP-element group 65: predecessors 
    -- CP-element group 65: 	5 
    -- CP-element group 65: successors 
    -- CP-element group 65:  members (2) 
      -- CP-element group 65: 	 branch_block_stmt_134/do_while_stmt_135/loop_exit/$exit
      -- CP-element group 65: 	 branch_block_stmt_134/do_while_stmt_135/loop_exit/ack
      -- 
    ack_347_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 65_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_135_branch_ack_0, ack => inputPort_2_Daemon_CP_178_elements(65)); -- 
    -- CP-element group 66:  transition  input  bypass  pipeline-parent 
    -- CP-element group 66: predecessors 
    -- CP-element group 66: 	5 
    -- CP-element group 66: successors 
    -- CP-element group 66:  members (2) 
      -- CP-element group 66: 	 branch_block_stmt_134/do_while_stmt_135/loop_taken/$exit
      -- CP-element group 66: 	 branch_block_stmt_134/do_while_stmt_135/loop_taken/ack
      -- 
    ack_351_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 66_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_135_branch_ack_1, ack => inputPort_2_Daemon_CP_178_elements(66)); -- 
    -- CP-element group 67:  transition  bypass  pipeline-parent 
    -- CP-element group 67: predecessors 
    -- CP-element group 67: 	3 
    -- CP-element group 67: successors 
    -- CP-element group 67: 	1 
    -- CP-element group 67:  members (1) 
      -- CP-element group 67: 	 branch_block_stmt_134/do_while_stmt_135/$exit
      -- 
    inputPort_2_Daemon_CP_178_elements(67) <= inputPort_2_Daemon_CP_178_elements(3);
    inputPort_2_Daemon_do_while_stmt_135_terminator_352: loop_terminator -- 
      generic map (name => " inputPort_2_Daemon_do_while_stmt_135_terminator_352", max_iterations_in_flight =>7) 
      port map(loop_body_exit => inputPort_2_Daemon_CP_178_elements(6),loop_continue => inputPort_2_Daemon_CP_178_elements(66),loop_terminate => inputPort_2_Daemon_CP_178_elements(65),loop_back => inputPort_2_Daemon_CP_178_elements(4),loop_exit => inputPort_2_Daemon_CP_178_elements(3),clk => clk, reset => reset); -- 
    phi_stmt_137_phi_seq_252_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= inputPort_2_Daemon_CP_178_elements(22);
      inputPort_2_Daemon_CP_178_elements(25)<= src_sample_reqs(0);
      src_sample_acks(0)  <= inputPort_2_Daemon_CP_178_elements(25);
      inputPort_2_Daemon_CP_178_elements(26)<= src_update_reqs(0);
      src_update_acks(0)  <= inputPort_2_Daemon_CP_178_elements(27);
      inputPort_2_Daemon_CP_178_elements(23) <= phi_mux_reqs(0);
      triggers(1)  <= inputPort_2_Daemon_CP_178_elements(20);
      inputPort_2_Daemon_CP_178_elements(29)<= src_sample_reqs(1);
      src_sample_acks(1)  <= inputPort_2_Daemon_CP_178_elements(31);
      inputPort_2_Daemon_CP_178_elements(30)<= src_update_reqs(1);
      src_update_acks(1)  <= inputPort_2_Daemon_CP_178_elements(32);
      inputPort_2_Daemon_CP_178_elements(21) <= phi_mux_reqs(1);
      phi_stmt_137_phi_seq_252 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_137_phi_seq_252") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => inputPort_2_Daemon_CP_178_elements(11), 
          phi_sample_ack => inputPort_2_Daemon_CP_178_elements(18), 
          phi_update_req => inputPort_2_Daemon_CP_178_elements(14), 
          phi_update_ack => inputPort_2_Daemon_CP_178_elements(19), 
          phi_mux_ack => inputPort_2_Daemon_CP_178_elements(24), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_145_phi_seq_314_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= inputPort_2_Daemon_CP_178_elements(46);
      inputPort_2_Daemon_CP_178_elements(49)<= src_sample_reqs(0);
      src_sample_acks(0)  <= inputPort_2_Daemon_CP_178_elements(49);
      inputPort_2_Daemon_CP_178_elements(50)<= src_update_reqs(0);
      src_update_acks(0)  <= inputPort_2_Daemon_CP_178_elements(51);
      inputPort_2_Daemon_CP_178_elements(47) <= phi_mux_reqs(0);
      triggers(1)  <= inputPort_2_Daemon_CP_178_elements(44);
      inputPort_2_Daemon_CP_178_elements(53)<= src_sample_reqs(1);
      src_sample_acks(1)  <= inputPort_2_Daemon_CP_178_elements(55);
      inputPort_2_Daemon_CP_178_elements(54)<= src_update_reqs(1);
      src_update_acks(1)  <= inputPort_2_Daemon_CP_178_elements(56);
      inputPort_2_Daemon_CP_178_elements(45) <= phi_mux_reqs(1);
      phi_stmt_145_phi_seq_314 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_145_phi_seq_314") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => inputPort_2_Daemon_CP_178_elements(40), 
          phi_sample_ack => inputPort_2_Daemon_CP_178_elements(41), 
          phi_update_req => inputPort_2_Daemon_CP_178_elements(42), 
          phi_update_ack => inputPort_2_Daemon_CP_178_elements(43), 
          phi_mux_ack => inputPort_2_Daemon_CP_178_elements(48), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    entry_tmerge_203_block : block -- 
      signal preds : BooleanArray(0 to 1);
      begin -- 
        preds(0)  <= inputPort_2_Daemon_CP_178_elements(7);
        preds(1)  <= inputPort_2_Daemon_CP_178_elements(8);
        entry_tmerge_203 : transition_merge -- 
          generic map(name => " entry_tmerge_203")
          port map (preds => preds, symbol_out => inputPort_2_Daemon_CP_178_elements(9));
          -- 
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal RPIPE_in_data_2_144_wire : std_logic_vector(31 downto 0);
    signal R_ONE_1_191_wire_constant : std_logic_vector(0 downto 0);
    signal SUB_u16_u16_178_wire : std_logic_vector(15 downto 0);
    signal SUB_u16_u16_181_wire : std_logic_vector(15 downto 0);
    signal count_down_137 : std_logic_vector(15 downto 0);
    signal data_to_outport_194 : std_logic_vector(32 downto 0);
    signal dest_id_160 : std_logic_vector(7 downto 0);
    signal input_word_142 : std_logic_vector(31 downto 0);
    signal konst_147_wire_constant : std_logic_vector(7 downto 0);
    signal konst_154_wire_constant : std_logic_vector(15 downto 0);
    signal konst_177_wire_constant : std_logic_vector(15 downto 0);
    signal konst_180_wire_constant : std_logic_vector(15 downto 0);
    signal konst_197_wire_constant : std_logic_vector(7 downto 0);
    signal konst_206_wire_constant : std_logic_vector(7 downto 0);
    signal konst_222_wire_constant : std_logic_vector(0 downto 0);
    signal last_dest_id_145 : std_logic_vector(7 downto 0);
    signal new_packet_156 : std_logic_vector(0 downto 0);
    signal next_count_down_183 : std_logic_vector(15 downto 0);
    signal next_count_down_183_141_buffered : std_logic_vector(15 downto 0);
    signal next_last_dest_id_189 : std_logic_vector(7 downto 0);
    signal next_last_dest_id_189_148_buffered : std_logic_vector(7 downto 0);
    signal pkt_length_164 : std_logic_vector(15 downto 0);
    signal send_to_1_199 : std_logic_vector(0 downto 0);
    signal send_to_2_208 : std_logic_vector(0 downto 0);
    signal seq_id_168 : std_logic_vector(7 downto 0);
    signal type_cast_140_wire_constant : std_logic_vector(15 downto 0);
    -- 
  begin -- 
    R_ONE_1_191_wire_constant <= "1";
    konst_147_wire_constant <= "00000000";
    konst_154_wire_constant <= "0000000000000000";
    konst_177_wire_constant <= "0000000000000001";
    konst_180_wire_constant <= "0000000000000001";
    konst_197_wire_constant <= "00000001";
    konst_206_wire_constant <= "00000010";
    konst_222_wire_constant <= "1";
    type_cast_140_wire_constant <= "0000000000000000";
    phi_stmt_137: Block -- phi operator 
      signal idata: std_logic_vector(31 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_140_wire_constant & next_count_down_183_141_buffered;
      req <= phi_stmt_137_req_0 & phi_stmt_137_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_137",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 16) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_137_ack_0,
          idata => idata,
          odata => count_down_137,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_137
    phi_stmt_145: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= konst_147_wire_constant & next_last_dest_id_189_148_buffered;
      req <= phi_stmt_145_req_0 & phi_stmt_145_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_145",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_145_ack_0,
          idata => idata,
          odata => last_dest_id_145,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_145
    -- flow-through select operator MUX_182_inst
    next_count_down_183 <= SUB_u16_u16_178_wire when (new_packet_156(0) /=  '0') else SUB_u16_u16_181_wire;
    -- flow-through select operator MUX_188_inst
    next_last_dest_id_189 <= dest_id_160 when (new_packet_156(0) /=  '0') else last_dest_id_145;
    -- flow-through slice operator slice_159_inst
    dest_id_160 <= input_word_142(31 downto 24);
    -- flow-through slice operator slice_163_inst
    pkt_length_164 <= input_word_142(23 downto 8);
    -- flow-through slice operator slice_167_inst
    seq_id_168 <= input_word_142(7 downto 0);
    next_count_down_183_141_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_count_down_183_141_buf_req_0;
      next_count_down_183_141_buf_ack_0<= wack(0);
      rreq(0) <= next_count_down_183_141_buf_req_1;
      next_count_down_183_141_buf_ack_1<= rack(0);
      next_count_down_183_141_buf : InterlockBuffer generic map ( -- 
        name => "next_count_down_183_141_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 16,
        out_data_width => 16,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_count_down_183,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_count_down_183_141_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_last_dest_id_189_148_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_last_dest_id_189_148_buf_req_0;
      next_last_dest_id_189_148_buf_ack_0<= wack(0);
      rreq(0) <= next_last_dest_id_189_148_buf_req_1;
      next_last_dest_id_189_148_buf_ack_1<= rack(0);
      next_last_dest_id_189_148_buf : InterlockBuffer generic map ( -- 
        name => "next_last_dest_id_189_148_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_last_dest_id_189,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_last_dest_id_189_148_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    -- interlock ssrc_phi_stmt_142
    process(RPIPE_in_data_2_144_wire) -- 
      variable tmp_var : std_logic_vector(31 downto 0); -- 
    begin -- 
      tmp_var := (others => '0'); 
      tmp_var( 31 downto 0) := RPIPE_in_data_2_144_wire(31 downto 0);
      input_word_142 <= tmp_var; -- 
    end process;
    do_while_stmt_135_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= konst_222_wire_constant;
      branch_instance: BranchBase -- 
        generic map( name => "do_while_stmt_135_branch", condition_width => 1,  bypass_flag => true)
        port map( -- 
          condition => condition_sig,
          req => do_while_stmt_135_branch_req_0,
          ack0 => do_while_stmt_135_branch_ack_0,
          ack1 => do_while_stmt_135_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- flow through binary operator CONCAT_u1_u33_193_inst
    process(R_ONE_1_191_wire_constant, input_word_142) -- 
      variable tmp_var : std_logic_vector(32 downto 0); -- 
    begin -- 
      ApConcat_proc(R_ONE_1_191_wire_constant, input_word_142, tmp_var);
      data_to_outport_194 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u16_u1_155_inst
    process(count_down_137) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(count_down_137, konst_154_wire_constant, tmp_var);
      new_packet_156 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_198_inst
    process(next_last_dest_id_189) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_last_dest_id_189, konst_197_wire_constant, tmp_var);
      send_to_1_199 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_207_inst
    process(next_last_dest_id_189) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_last_dest_id_189, konst_206_wire_constant, tmp_var);
      send_to_2_208 <= tmp_var; --
    end process;
    -- flow through binary operator SUB_u16_u16_178_inst
    SUB_u16_u16_178_wire <= std_logic_vector(unsigned(pkt_length_164) - unsigned(konst_177_wire_constant));
    -- flow through binary operator SUB_u16_u16_181_inst
    SUB_u16_u16_181_wire <= std_logic_vector(unsigned(count_down_137) - unsigned(konst_180_wire_constant));
    -- shared inport operator group (0) : RPIPE_in_data_2_144_inst 
    InportGroup_0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => false);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_in_data_2_144_inst_req_0;
      RPIPE_in_data_2_144_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_in_data_2_144_inst_req_1;
      RPIPE_in_data_2_144_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <=  '1';
      RPIPE_in_data_2_144_wire <= data_out(31 downto 0);
      in_data_2_read_0_gI: SplitGuardInterface generic map(name => "in_data_2_read_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      in_data_2_read_0: InputPortRevised -- 
        generic map ( name => "in_data_2_read_0", data_width => 32,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => False,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => in_data_2_pipe_read_req(0),
          oack => in_data_2_pipe_read_ack(0),
          odata => in_data_2_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : WPIPE_noblock_obuf_2_1_201_inst 
    OutportGroup_0: Block -- 
      signal data_in: std_logic_vector(32 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_noblock_obuf_2_1_201_inst_req_0;
      WPIPE_noblock_obuf_2_1_201_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_noblock_obuf_2_1_201_inst_req_1;
      WPIPE_noblock_obuf_2_1_201_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_to_1_199(0);
      data_in <= data_to_outport_194;
      noblock_obuf_2_1_write_0_gI: SplitGuardInterface generic map(name => "noblock_obuf_2_1_write_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_2_1_write_0: OutputPortRevised -- 
        generic map ( name => "noblock_obuf_2_1", data_width => 33, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => noblock_obuf_2_1_pipe_write_req(0),
          oack => noblock_obuf_2_1_pipe_write_ack(0),
          odata => noblock_obuf_2_1_pipe_write_data(32 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- shared outport operator group (1) : WPIPE_noblock_obuf_2_2_210_inst 
    OutportGroup_1: Block -- 
      signal data_in: std_logic_vector(32 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_noblock_obuf_2_2_210_inst_req_0;
      WPIPE_noblock_obuf_2_2_210_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_noblock_obuf_2_2_210_inst_req_1;
      WPIPE_noblock_obuf_2_2_210_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_to_2_208(0);
      data_in <= data_to_outport_194;
      noblock_obuf_2_2_write_1_gI: SplitGuardInterface generic map(name => "noblock_obuf_2_2_write_1_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_2_2_write_1: OutputPortRevised -- 
        generic map ( name => "noblock_obuf_2_2", data_width => 33, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => noblock_obuf_2_2_pipe_write_req(0),
          oack => noblock_obuf_2_2_pipe_write_ack(0),
          odata => noblock_obuf_2_2_pipe_write_data(32 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 1
    -- 
  end Block; -- data_path
  -- 
end inputPort_2_Daemon_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.switch_2x2_global_package.all;
entity outputPort_1_Daemon is -- 
  generic (tag_length : integer); 
  port ( -- 
    noblock_obuf_1_1_pipe_read_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_1_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_1_1_pipe_read_data : in   std_logic_vector(32 downto 0);
    noblock_obuf_2_1_pipe_read_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_2_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_2_1_pipe_read_data : in   std_logic_vector(32 downto 0);
    out_data_1_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_data_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_data_1_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) ;
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic-- 
  );
  -- 
end entity outputPort_1_Daemon;
architecture outputPort_1_Daemon_arch of outputPort_1_Daemon is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal outputPort_1_Daemon_CP_356_start: Boolean;
  signal outputPort_1_Daemon_CP_356_symbol: Boolean;
  -- volatile/operator module components. 
  component prioritySelect_Volatile is -- 
    port ( -- 
      down_counter : in  std_logic_vector(7 downto 0);
      active_packet : in  std_logic_vector(1 downto 0);
      pkt_1_has_priority : in  std_logic_vector(0 downto 0);
      p1_valid : in  std_logic_vector(0 downto 0);
      p2_valid : in  std_logic_vector(0 downto 0);
      next_active_packet : out  std_logic_vector(1 downto 0);
      next_pkt_1_has_priority : out  std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component; 
  -- links between control-path and data-path
  signal phi_stmt_290_ack_0 : boolean;
  signal phi_stmt_299_req_1 : boolean;
  signal next_down_counter_392_293_buf_ack_1 : boolean;
  signal next_down_counter_392_293_buf_req_1 : boolean;
  signal RPIPE_noblock_obuf_1_1_298_inst_ack_1 : boolean;
  signal phi_stmt_304_req_1 : boolean;
  signal next_active_packet_357_307_buf_ack_1 : boolean;
  signal RPIPE_noblock_obuf_1_1_298_inst_req_1 : boolean;
  signal next_active_packet_357_307_buf_req_1 : boolean;
  signal RPIPE_noblock_obuf_2_1_303_inst_ack_1 : boolean;
  signal RPIPE_noblock_obuf_1_1_298_inst_ack_0 : boolean;
  signal next_pkt_1_has_priority_357_315_buf_ack_1 : boolean;
  signal RPIPE_noblock_obuf_2_1_303_inst_req_1 : boolean;
  signal RPIPE_noblock_obuf_1_1_298_inst_req_0 : boolean;
  signal do_while_stmt_288_branch_ack_0 : boolean;
  signal phi_stmt_294_req_1 : boolean;
  signal phi_stmt_308_req_0 : boolean;
  signal phi_stmt_294_req_0 : boolean;
  signal next_down_counter_392_293_buf_ack_0 : boolean;
  signal next_active_packet_357_307_buf_ack_0 : boolean;
  signal phi_stmt_304_ack_0 : boolean;
  signal next_down_counter_392_293_buf_req_0 : boolean;
  signal next_active_packet_357_307_buf_req_0 : boolean;
  signal RPIPE_noblock_obuf_2_1_303_inst_ack_0 : boolean;
  signal WPIPE_out_data_1_435_inst_req_0 : boolean;
  signal WPIPE_out_data_1_435_inst_ack_0 : boolean;
  signal phi_stmt_290_req_0 : boolean;
  signal next_active_packet_length_379_311_buf_ack_1 : boolean;
  signal next_active_packet_length_379_311_buf_ack_0 : boolean;
  signal phi_stmt_312_req_1 : boolean;
  signal WPIPE_out_data_1_435_inst_ack_1 : boolean;
  signal next_active_packet_length_379_311_buf_req_0 : boolean;
  signal RPIPE_noblock_obuf_2_1_303_inst_req_0 : boolean;
  signal WPIPE_out_data_1_435_inst_req_1 : boolean;
  signal do_while_stmt_288_branch_ack_1 : boolean;
  signal phi_stmt_308_ack_0 : boolean;
  signal next_pkt_1_has_priority_357_315_buf_req_1 : boolean;
  signal phi_stmt_299_ack_0 : boolean;
  signal phi_stmt_294_ack_0 : boolean;
  signal phi_stmt_299_req_0 : boolean;
  signal phi_stmt_304_req_0 : boolean;
  signal phi_stmt_308_req_1 : boolean;
  signal next_active_packet_length_379_311_buf_req_1 : boolean;
  signal next_pkt_1_has_priority_357_315_buf_req_0 : boolean;
  signal phi_stmt_312_ack_0 : boolean;
  signal next_pkt_1_has_priority_357_315_buf_ack_0 : boolean;
  signal phi_stmt_312_req_0 : boolean;
  signal phi_stmt_290_req_1 : boolean;
  signal do_while_stmt_288_branch_req_0 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "outputPort_1_Daemon_input_buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj_in_buffer_unload_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  outputPort_1_Daemon_CP_356_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "outputPort_1_Daemon_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 0) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= outputPort_1_Daemon_CP_356_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj_out_buffer_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= outputPort_1_Daemon_CP_356_start & tag_ilock_write_ack_symbol;
    gj_tag_ilock_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= outputPort_1_Daemon_CP_356_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  outputPort_1_Daemon_CP_356: Block -- control-path 
    signal outputPort_1_Daemon_CP_356_elements: BooleanArray(139 downto 0);
    -- 
  begin -- 
    outputPort_1_Daemon_CP_356_elements(0) <= outputPort_1_Daemon_CP_356_start;
    outputPort_1_Daemon_CP_356_symbol <= outputPort_1_Daemon_CP_356_elements(1);
    -- CP-element group 0:  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	2 
    -- CP-element group 0:  members (4) 
      -- CP-element group 0: 	 $entry
      -- CP-element group 0: 	 branch_block_stmt_287/$entry
      -- CP-element group 0: 	 branch_block_stmt_287/branch_block_stmt_287__entry__
      -- CP-element group 0: 	 branch_block_stmt_287/do_while_stmt_288__entry__
      -- 
    -- CP-element group 1:  transition  place  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	139 
    -- CP-element group 1: successors 
    -- CP-element group 1:  members (4) 
      -- CP-element group 1: 	 $exit
      -- CP-element group 1: 	 branch_block_stmt_287/$exit
      -- CP-element group 1: 	 branch_block_stmt_287/branch_block_stmt_287__exit__
      -- CP-element group 1: 	 branch_block_stmt_287/do_while_stmt_288__exit__
      -- 
    outputPort_1_Daemon_CP_356_elements(1) <= outputPort_1_Daemon_CP_356_elements(139);
    -- CP-element group 2:  transition  place  bypass  pipeline-parent 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	0 
    -- CP-element group 2: successors 
    -- CP-element group 2: 	8 
    -- CP-element group 2:  members (2) 
      -- CP-element group 2: 	 branch_block_stmt_287/do_while_stmt_288/$entry
      -- CP-element group 2: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288__entry__
      -- 
    outputPort_1_Daemon_CP_356_elements(2) <= outputPort_1_Daemon_CP_356_elements(0);
    -- CP-element group 3:  merge  place  bypass  pipeline-parent 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	139 
    -- CP-element group 3:  members (1) 
      -- CP-element group 3: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288__exit__
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(3) is bound as output of CP function.
    -- CP-element group 4:  merge  place  bypass  pipeline-parent 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: successors 
    -- CP-element group 4: 	7 
    -- CP-element group 4:  members (1) 
      -- CP-element group 4: 	 branch_block_stmt_287/do_while_stmt_288/loop_back
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(4) is bound as output of CP function.
    -- CP-element group 5:  branch  transition  place  bypass  pipeline-parent 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	10 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	137 
    -- CP-element group 5: 	138 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_287/do_while_stmt_288/loop_taken/$entry
      -- CP-element group 5: 	 branch_block_stmt_287/do_while_stmt_288/loop_exit/$entry
      -- CP-element group 5: 	 branch_block_stmt_287/do_while_stmt_288/condition_done
      -- 
    outputPort_1_Daemon_CP_356_elements(5) <= outputPort_1_Daemon_CP_356_elements(10);
    -- CP-element group 6:  branch  place  bypass  pipeline-parent 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	136 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (1) 
      -- CP-element group 6: 	 branch_block_stmt_287/do_while_stmt_288/loop_body_done
      -- 
    outputPort_1_Daemon_CP_356_elements(6) <= outputPort_1_Daemon_CP_356_elements(136);
    -- CP-element group 7:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	4 
    -- CP-element group 7: successors 
    -- CP-element group 7: 	100 
    -- CP-element group 7: 	119 
    -- CP-element group 7: 	22 
    -- CP-element group 7: 	41 
    -- CP-element group 7: 	62 
    -- CP-element group 7: 	83 
    -- CP-element group 7:  members (1) 
      -- CP-element group 7: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/back_edge_to_loop_body
      -- 
    outputPort_1_Daemon_CP_356_elements(7) <= outputPort_1_Daemon_CP_356_elements(4);
    -- CP-element group 8:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	2 
    -- CP-element group 8: successors 
    -- CP-element group 8: 	121 
    -- CP-element group 8: 	24 
    -- CP-element group 8: 	102 
    -- CP-element group 8: 	43 
    -- CP-element group 8: 	64 
    -- CP-element group 8: 	85 
    -- CP-element group 8:  members (1) 
      -- CP-element group 8: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/first_time_through_loop_body
      -- 
    outputPort_1_Daemon_CP_356_elements(8) <= outputPort_1_Daemon_CP_356_elements(2);
    -- CP-element group 9:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	97 
    -- CP-element group 9: 	135 
    -- CP-element group 9: 	114 
    -- CP-element group 9: 	96 
    -- CP-element group 9: 	113 
    -- CP-element group 9: 	16 
    -- CP-element group 9: 	17 
    -- CP-element group 9: 	35 
    -- CP-element group 9: 	36 
    -- CP-element group 9: 	56 
    -- CP-element group 9: 	57 
    -- CP-element group 9: 	77 
    -- CP-element group 9: 	78 
    -- CP-element group 9:  members (2) 
      -- CP-element group 9: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/$entry
      -- CP-element group 9: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/loop_body_start
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(9) is bound as output of CP function.
    -- CP-element group 10:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	135 
    -- CP-element group 10: 	13 
    -- CP-element group 10: 	15 
    -- CP-element group 10: successors 
    -- CP-element group 10: 	5 
    -- CP-element group 10:  members (1) 
      -- CP-element group 10: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/condition_evaluated
      -- 
    condition_evaluated_380_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " condition_evaluated_380_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(10), ack => do_while_stmt_288_branch_req_0); -- 
    outputPort_1_Daemon_cp_element_group_10: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_10"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(135) & outputPort_1_Daemon_CP_356_elements(13) & outputPort_1_Daemon_CP_356_elements(15);
      gj_outputPort_1_Daemon_cp_element_group_10 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(10), clk => clk, reset => reset); --
    end block;
    -- CP-element group 11:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	96 
    -- CP-element group 11: 	113 
    -- CP-element group 11: 	16 
    -- CP-element group 11: 	35 
    -- CP-element group 11: 	56 
    -- CP-element group 11: 	77 
    -- CP-element group 11: marked-predecessors 
    -- CP-element group 11: 	15 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	18 
    -- CP-element group 11: 	115 
    -- CP-element group 11: 	37 
    -- CP-element group 11: 	58 
    -- CP-element group 11: 	79 
    -- CP-element group 11:  members (2) 
      -- CP-element group 11: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_sample_start__ps
      -- CP-element group 11: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/aggregated_phi_sample_req
      -- 
    outputPort_1_Daemon_cp_element_group_11: block -- 
      constant place_capacities: IntegerArray(0 to 6) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1,6 => 1);
      constant place_markings: IntegerArray(0 to 6)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0,6 => 1);
      constant place_delays: IntegerArray(0 to 6) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0,6 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_11"; 
      signal preds: BooleanArray(1 to 7); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(96) & outputPort_1_Daemon_CP_356_elements(113) & outputPort_1_Daemon_CP_356_elements(16) & outputPort_1_Daemon_CP_356_elements(35) & outputPort_1_Daemon_CP_356_elements(56) & outputPort_1_Daemon_CP_356_elements(77) & outputPort_1_Daemon_CP_356_elements(15);
      gj_outputPort_1_Daemon_cp_element_group_11 : generic_join generic map(name => joinName, number_of_predecessors => 7, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(11), clk => clk, reset => reset); --
    end block;
    -- CP-element group 12:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	98 
    -- CP-element group 12: 	116 
    -- CP-element group 12: 	19 
    -- CP-element group 12: 	38 
    -- CP-element group 12: 	59 
    -- CP-element group 12: 	80 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	136 
    -- CP-element group 12: 	13 
    -- CP-element group 12: marked-successors 
    -- CP-element group 12: 	96 
    -- CP-element group 12: 	113 
    -- CP-element group 12: 	16 
    -- CP-element group 12: 	35 
    -- CP-element group 12: 	56 
    -- CP-element group 12: 	77 
    -- CP-element group 12:  members (7) 
      -- CP-element group 12: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/aggregated_phi_sample_ack
      -- CP-element group 12: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_sample_completed_
      -- 
    outputPort_1_Daemon_cp_element_group_12: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_12"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(98) & outputPort_1_Daemon_CP_356_elements(116) & outputPort_1_Daemon_CP_356_elements(19) & outputPort_1_Daemon_CP_356_elements(38) & outputPort_1_Daemon_CP_356_elements(59) & outputPort_1_Daemon_CP_356_elements(80);
      gj_outputPort_1_Daemon_cp_element_group_12 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(12), clk => clk, reset => reset); --
    end block;
    -- CP-element group 13:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	12 
    -- CP-element group 13: successors 
    -- CP-element group 13: 	10 
    -- CP-element group 13:  members (1) 
      -- CP-element group 13: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/aggregated_phi_sample_ack_d
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(13) is a control-delay.
    cp_element_13_delay: control_delay_element  generic map(name => " 13_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_356_elements(12), ack => outputPort_1_Daemon_CP_356_elements(13), clk => clk, reset =>reset);
    -- CP-element group 14:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	97 
    -- CP-element group 14: 	114 
    -- CP-element group 14: 	17 
    -- CP-element group 14: 	36 
    -- CP-element group 14: 	57 
    -- CP-element group 14: 	78 
    -- CP-element group 14: successors 
    -- CP-element group 14: 	117 
    -- CP-element group 14: 	20 
    -- CP-element group 14: 	39 
    -- CP-element group 14: 	60 
    -- CP-element group 14: 	81 
    -- CP-element group 14:  members (2) 
      -- CP-element group 14: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_update_start__ps
      -- CP-element group 14: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/aggregated_phi_update_req
      -- 
    outputPort_1_Daemon_cp_element_group_14: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_14"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(97) & outputPort_1_Daemon_CP_356_elements(114) & outputPort_1_Daemon_CP_356_elements(17) & outputPort_1_Daemon_CP_356_elements(36) & outputPort_1_Daemon_CP_356_elements(57) & outputPort_1_Daemon_CP_356_elements(78);
      gj_outputPort_1_Daemon_cp_element_group_14 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(14), clk => clk, reset => reset); --
    end block;
    -- CP-element group 15:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	118 
    -- CP-element group 15: 	99 
    -- CP-element group 15: 	21 
    -- CP-element group 15: 	40 
    -- CP-element group 15: 	61 
    -- CP-element group 15: 	82 
    -- CP-element group 15: successors 
    -- CP-element group 15: 	10 
    -- CP-element group 15: marked-successors 
    -- CP-element group 15: 	11 
    -- CP-element group 15:  members (1) 
      -- CP-element group 15: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/aggregated_phi_update_ack
      -- 
    outputPort_1_Daemon_cp_element_group_15: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 7,1 => 7,2 => 7,3 => 7,4 => 7,5 => 7);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_15"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(118) & outputPort_1_Daemon_CP_356_elements(99) & outputPort_1_Daemon_CP_356_elements(21) & outputPort_1_Daemon_CP_356_elements(40) & outputPort_1_Daemon_CP_356_elements(61) & outputPort_1_Daemon_CP_356_elements(82);
      gj_outputPort_1_Daemon_cp_element_group_15 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(15), clk => clk, reset => reset); --
    end block;
    -- CP-element group 16:  join  transition  bypass  pipeline-parent 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	9 
    -- CP-element group 16: marked-predecessors 
    -- CP-element group 16: 	12 
    -- CP-element group 16: successors 
    -- CP-element group 16: 	11 
    -- CP-element group 16:  members (1) 
      -- CP-element group 16: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_16: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_16"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_16 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(16), clk => clk, reset => reset); --
    end block;
    -- CP-element group 17:  join  transition  bypass  pipeline-parent 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	9 
    -- CP-element group 17: marked-predecessors 
    -- CP-element group 17: 	133 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	14 
    -- CP-element group 17:  members (1) 
      -- CP-element group 17: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_17: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_17"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(133);
      gj_outputPort_1_Daemon_cp_element_group_17 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(17), clk => clk, reset => reset); --
    end block;
    -- CP-element group 18:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: 	11 
    -- CP-element group 18: successors 
    -- CP-element group 18:  members (1) 
      -- CP-element group 18: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_sample_start__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(18) <= outputPort_1_Daemon_CP_356_elements(11);
    -- CP-element group 19:  join  transition  bypass  pipeline-parent 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	12 
    -- CP-element group 19:  members (1) 
      -- CP-element group 19: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(19) is bound as output of CP function.
    -- CP-element group 20:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	14 
    -- CP-element group 20: successors 
    -- CP-element group 20:  members (1) 
      -- CP-element group 20: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_update_start__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(20) <= outputPort_1_Daemon_CP_356_elements(14);
    -- CP-element group 21:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: successors 
    -- CP-element group 21: 	132 
    -- CP-element group 21: 	15 
    -- CP-element group 21:  members (2) 
      -- CP-element group 21: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_update_completed__ps
      -- CP-element group 21: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(21) is bound as output of CP function.
    -- CP-element group 22:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	7 
    -- CP-element group 22: successors 
    -- CP-element group 22:  members (1) 
      -- CP-element group 22: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(22) <= outputPort_1_Daemon_CP_356_elements(7);
    -- CP-element group 23:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: successors 
    -- CP-element group 23:  members (2) 
      -- CP-element group 23: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_loopback_sample_req_ps
      -- CP-element group 23: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_loopback_sample_req
      -- 
    phi_stmt_290_loopback_sample_req_396_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_290_loopback_sample_req_396_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(23), ack => phi_stmt_290_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(23) is bound as output of CP function.
    -- CP-element group 24:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: 	8 
    -- CP-element group 24: successors 
    -- CP-element group 24:  members (1) 
      -- CP-element group 24: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_entry_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(24) <= outputPort_1_Daemon_CP_356_elements(8);
    -- CP-element group 25:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: successors 
    -- CP-element group 25:  members (2) 
      -- CP-element group 25: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_entry_sample_req_ps
      -- CP-element group 25: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_entry_sample_req
      -- 
    phi_stmt_290_entry_sample_req_399_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_290_entry_sample_req_399_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(25), ack => phi_stmt_290_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(25) is bound as output of CP function.
    -- CP-element group 26:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 26: predecessors 
    -- CP-element group 26: successors 
    -- CP-element group 26:  members (2) 
      -- CP-element group 26: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_phi_mux_ack
      -- CP-element group 26: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_290_phi_mux_ack_ps
      -- 
    phi_stmt_290_phi_mux_ack_402_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 26_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_290_ack_0, ack => outputPort_1_Daemon_CP_356_elements(26)); -- 
    -- CP-element group 27:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 27: predecessors 
    -- CP-element group 27: successors 
    -- CP-element group 27:  members (4) 
      -- CP-element group 27: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_292_sample_completed__ps
      -- CP-element group 27: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_292_sample_start__ps
      -- CP-element group 27: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_292_sample_completed_
      -- CP-element group 27: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_292_sample_start_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(27) is bound as output of CP function.
    -- CP-element group 28:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 28: predecessors 
    -- CP-element group 28: successors 
    -- CP-element group 28: 	30 
    -- CP-element group 28:  members (2) 
      -- CP-element group 28: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_292_update_start__ps
      -- CP-element group 28: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_292_update_start_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(28) is bound as output of CP function.
    -- CP-element group 29:  join  transition  bypass  pipeline-parent 
    -- CP-element group 29: predecessors 
    -- CP-element group 29: 	30 
    -- CP-element group 29: successors 
    -- CP-element group 29:  members (1) 
      -- CP-element group 29: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_292_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(29) <= outputPort_1_Daemon_CP_356_elements(30);
    -- CP-element group 30:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 30: predecessors 
    -- CP-element group 30: 	28 
    -- CP-element group 30: successors 
    -- CP-element group 30: 	29 
    -- CP-element group 30:  members (1) 
      -- CP-element group 30: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_292_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(30) is a control-delay.
    cp_element_30_delay: control_delay_element  generic map(name => " 30_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_356_elements(28), ack => outputPort_1_Daemon_CP_356_elements(30), clk => clk, reset =>reset);
    -- CP-element group 31:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 31: predecessors 
    -- CP-element group 31: successors 
    -- CP-element group 31: 	33 
    -- CP-element group 31:  members (4) 
      -- CP-element group 31: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_Sample/req
      -- CP-element group 31: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_Sample/$entry
      -- CP-element group 31: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_sample_start_
      -- CP-element group 31: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_sample_start__ps
      -- 
    req_423_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_423_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(31), ack => next_down_counter_392_293_buf_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(31) is bound as output of CP function.
    -- CP-element group 32:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 32: predecessors 
    -- CP-element group 32: successors 
    -- CP-element group 32: 	34 
    -- CP-element group 32:  members (4) 
      -- CP-element group 32: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_Update/req
      -- CP-element group 32: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_Update/$entry
      -- CP-element group 32: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_update_start_
      -- CP-element group 32: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_update_start__ps
      -- 
    req_428_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_428_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(32), ack => next_down_counter_392_293_buf_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(32) is bound as output of CP function.
    -- CP-element group 33:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 33: predecessors 
    -- CP-element group 33: 	31 
    -- CP-element group 33: successors 
    -- CP-element group 33:  members (4) 
      -- CP-element group 33: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_Sample/ack
      -- CP-element group 33: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_Sample/$exit
      -- CP-element group 33: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_sample_completed_
      -- CP-element group 33: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_sample_completed__ps
      -- 
    ack_424_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 33_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_down_counter_392_293_buf_ack_0, ack => outputPort_1_Daemon_CP_356_elements(33)); -- 
    -- CP-element group 34:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 34: predecessors 
    -- CP-element group 34: 	32 
    -- CP-element group 34: successors 
    -- CP-element group 34:  members (4) 
      -- CP-element group 34: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_Update/ack
      -- CP-element group 34: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_Update/$exit
      -- CP-element group 34: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_update_completed_
      -- CP-element group 34: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_down_counter_293_update_completed__ps
      -- 
    ack_429_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 34_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_down_counter_392_293_buf_ack_1, ack => outputPort_1_Daemon_CP_356_elements(34)); -- 
    -- CP-element group 35:  join  transition  bypass  pipeline-parent 
    -- CP-element group 35: predecessors 
    -- CP-element group 35: 	9 
    -- CP-element group 35: marked-predecessors 
    -- CP-element group 35: 	12 
    -- CP-element group 35: successors 
    -- CP-element group 35: 	11 
    -- CP-element group 35:  members (1) 
      -- CP-element group 35: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_35: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_35"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_35 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(35), clk => clk, reset => reset); --
    end block;
    -- CP-element group 36:  join  transition  bypass  pipeline-parent 
    -- CP-element group 36: predecessors 
    -- CP-element group 36: 	9 
    -- CP-element group 36: marked-predecessors 
    -- CP-element group 36: 	133 
    -- CP-element group 36: successors 
    -- CP-element group 36: 	14 
    -- CP-element group 36:  members (1) 
      -- CP-element group 36: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_36: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_36"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(133);
      gj_outputPort_1_Daemon_cp_element_group_36 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(36), clk => clk, reset => reset); --
    end block;
    -- CP-element group 37:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 37: predecessors 
    -- CP-element group 37: 	11 
    -- CP-element group 37: successors 
    -- CP-element group 37:  members (1) 
      -- CP-element group 37: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_sample_start__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(37) <= outputPort_1_Daemon_CP_356_elements(11);
    -- CP-element group 38:  join  transition  bypass  pipeline-parent 
    -- CP-element group 38: predecessors 
    -- CP-element group 38: successors 
    -- CP-element group 38: 	12 
    -- CP-element group 38:  members (1) 
      -- CP-element group 38: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(38) is bound as output of CP function.
    -- CP-element group 39:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 39: predecessors 
    -- CP-element group 39: 	14 
    -- CP-element group 39: successors 
    -- CP-element group 39:  members (1) 
      -- CP-element group 39: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_update_start__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(39) <= outputPort_1_Daemon_CP_356_elements(14);
    -- CP-element group 40:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 40: predecessors 
    -- CP-element group 40: successors 
    -- CP-element group 40: 	132 
    -- CP-element group 40: 	15 
    -- CP-element group 40:  members (2) 
      -- CP-element group 40: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_update_completed__ps
      -- CP-element group 40: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(40) is bound as output of CP function.
    -- CP-element group 41:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 41: predecessors 
    -- CP-element group 41: 	7 
    -- CP-element group 41: successors 
    -- CP-element group 41:  members (1) 
      -- CP-element group 41: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(41) <= outputPort_1_Daemon_CP_356_elements(7);
    -- CP-element group 42:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 42: predecessors 
    -- CP-element group 42: successors 
    -- CP-element group 42:  members (2) 
      -- CP-element group 42: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_loopback_sample_req_ps
      -- CP-element group 42: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_loopback_sample_req
      -- 
    phi_stmt_294_loopback_sample_req_440_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_294_loopback_sample_req_440_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(42), ack => phi_stmt_294_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(42) is bound as output of CP function.
    -- CP-element group 43:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 43: predecessors 
    -- CP-element group 43: 	8 
    -- CP-element group 43: successors 
    -- CP-element group 43:  members (1) 
      -- CP-element group 43: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_entry_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(43) <= outputPort_1_Daemon_CP_356_elements(8);
    -- CP-element group 44:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 44: predecessors 
    -- CP-element group 44: successors 
    -- CP-element group 44:  members (2) 
      -- CP-element group 44: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_entry_sample_req_ps
      -- CP-element group 44: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_entry_sample_req
      -- 
    phi_stmt_294_entry_sample_req_443_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_294_entry_sample_req_443_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(44), ack => phi_stmt_294_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(44) is bound as output of CP function.
    -- CP-element group 45:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 45: predecessors 
    -- CP-element group 45: successors 
    -- CP-element group 45:  members (2) 
      -- CP-element group 45: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_phi_mux_ack_ps
      -- CP-element group 45: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_294_phi_mux_ack
      -- 
    phi_stmt_294_phi_mux_ack_446_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 45_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_294_ack_0, ack => outputPort_1_Daemon_CP_356_elements(45)); -- 
    -- CP-element group 46:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 46: predecessors 
    -- CP-element group 46: successors 
    -- CP-element group 46:  members (4) 
      -- CP-element group 46: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_296_sample_start_
      -- CP-element group 46: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_296_sample_completed__ps
      -- CP-element group 46: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_296_sample_start__ps
      -- CP-element group 46: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_296_sample_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(46) is bound as output of CP function.
    -- CP-element group 47:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 47: predecessors 
    -- CP-element group 47: successors 
    -- CP-element group 47: 	49 
    -- CP-element group 47:  members (2) 
      -- CP-element group 47: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_296_update_start__ps
      -- CP-element group 47: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_296_update_start_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(47) is bound as output of CP function.
    -- CP-element group 48:  join  transition  bypass  pipeline-parent 
    -- CP-element group 48: predecessors 
    -- CP-element group 48: 	49 
    -- CP-element group 48: successors 
    -- CP-element group 48:  members (1) 
      -- CP-element group 48: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_296_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(48) <= outputPort_1_Daemon_CP_356_elements(49);
    -- CP-element group 49:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 49: predecessors 
    -- CP-element group 49: 	47 
    -- CP-element group 49: successors 
    -- CP-element group 49: 	48 
    -- CP-element group 49:  members (1) 
      -- CP-element group 49: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_296_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(49) is a control-delay.
    cp_element_49_delay: control_delay_element  generic map(name => " 49_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_356_elements(47), ack => outputPort_1_Daemon_CP_356_elements(49), clk => clk, reset =>reset);
    -- CP-element group 50:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 50: predecessors 
    -- CP-element group 50: successors 
    -- CP-element group 50: 	52 
    -- CP-element group 50:  members (1) 
      -- CP-element group 50: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_sample_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(50) is bound as output of CP function.
    -- CP-element group 51:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 51: predecessors 
    -- CP-element group 51: successors 
    -- CP-element group 51: 	53 
    -- CP-element group 51:  members (1) 
      -- CP-element group 51: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_update_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(51) is bound as output of CP function.
    -- CP-element group 52:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 52: predecessors 
    -- CP-element group 52: 	50 
    -- CP-element group 52: marked-predecessors 
    -- CP-element group 52: 	55 
    -- CP-element group 52: successors 
    -- CP-element group 52: 	54 
    -- CP-element group 52:  members (3) 
      -- CP-element group 52: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_Sample/rr
      -- CP-element group 52: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_Sample/$entry
      -- CP-element group 52: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_sample_start_
      -- 
    rr_467_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_467_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(52), ack => RPIPE_noblock_obuf_1_1_298_inst_req_0); -- 
    outputPort_1_Daemon_cp_element_group_52: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_52"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(50) & outputPort_1_Daemon_CP_356_elements(55);
      gj_outputPort_1_Daemon_cp_element_group_52 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(52), clk => clk, reset => reset); --
    end block;
    -- CP-element group 53:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 53: predecessors 
    -- CP-element group 53: 	51 
    -- CP-element group 53: 	54 
    -- CP-element group 53: successors 
    -- CP-element group 53: 	55 
    -- CP-element group 53:  members (3) 
      -- CP-element group 53: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_Update/cr
      -- CP-element group 53: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_Update/$entry
      -- CP-element group 53: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_update_start_
      -- 
    cr_472_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_472_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(53), ack => RPIPE_noblock_obuf_1_1_298_inst_req_1); -- 
    outputPort_1_Daemon_cp_element_group_53: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_53"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(51) & outputPort_1_Daemon_CP_356_elements(54);
      gj_outputPort_1_Daemon_cp_element_group_53 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(53), clk => clk, reset => reset); --
    end block;
    -- CP-element group 54:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 54: predecessors 
    -- CP-element group 54: 	52 
    -- CP-element group 54: successors 
    -- CP-element group 54: 	53 
    -- CP-element group 54:  members (4) 
      -- CP-element group 54: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_Sample/$exit
      -- CP-element group 54: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_Sample/ra
      -- CP-element group 54: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_sample_completed_
      -- CP-element group 54: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_sample_completed__ps
      -- 
    ra_468_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 54_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_1_1_298_inst_ack_0, ack => outputPort_1_Daemon_CP_356_elements(54)); -- 
    -- CP-element group 55:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 55: predecessors 
    -- CP-element group 55: 	53 
    -- CP-element group 55: successors 
    -- CP-element group 55: marked-successors 
    -- CP-element group 55: 	52 
    -- CP-element group 55:  members (4) 
      -- CP-element group 55: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_Update/ca
      -- CP-element group 55: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_Update/$exit
      -- CP-element group 55: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_update_completed_
      -- CP-element group 55: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_1_1_298_update_completed__ps
      -- 
    ca_473_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 55_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_1_1_298_inst_ack_1, ack => outputPort_1_Daemon_CP_356_elements(55)); -- 
    -- CP-element group 56:  join  transition  bypass  pipeline-parent 
    -- CP-element group 56: predecessors 
    -- CP-element group 56: 	9 
    -- CP-element group 56: marked-predecessors 
    -- CP-element group 56: 	12 
    -- CP-element group 56: successors 
    -- CP-element group 56: 	11 
    -- CP-element group 56:  members (1) 
      -- CP-element group 56: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_56: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_56"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_56 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(56), clk => clk, reset => reset); --
    end block;
    -- CP-element group 57:  join  transition  bypass  pipeline-parent 
    -- CP-element group 57: predecessors 
    -- CP-element group 57: 	9 
    -- CP-element group 57: marked-predecessors 
    -- CP-element group 57: 	133 
    -- CP-element group 57: successors 
    -- CP-element group 57: 	14 
    -- CP-element group 57:  members (1) 
      -- CP-element group 57: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_57: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_57"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(133);
      gj_outputPort_1_Daemon_cp_element_group_57 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(57), clk => clk, reset => reset); --
    end block;
    -- CP-element group 58:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 58: predecessors 
    -- CP-element group 58: 	11 
    -- CP-element group 58: successors 
    -- CP-element group 58:  members (1) 
      -- CP-element group 58: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_sample_start__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(58) <= outputPort_1_Daemon_CP_356_elements(11);
    -- CP-element group 59:  join  transition  bypass  pipeline-parent 
    -- CP-element group 59: predecessors 
    -- CP-element group 59: successors 
    -- CP-element group 59: 	12 
    -- CP-element group 59:  members (1) 
      -- CP-element group 59: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(59) is bound as output of CP function.
    -- CP-element group 60:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 60: predecessors 
    -- CP-element group 60: 	14 
    -- CP-element group 60: successors 
    -- CP-element group 60:  members (1) 
      -- CP-element group 60: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_update_start__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(60) <= outputPort_1_Daemon_CP_356_elements(14);
    -- CP-element group 61:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 61: predecessors 
    -- CP-element group 61: successors 
    -- CP-element group 61: 	132 
    -- CP-element group 61: 	15 
    -- CP-element group 61:  members (2) 
      -- CP-element group 61: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_update_completed_
      -- CP-element group 61: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_update_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(61) is bound as output of CP function.
    -- CP-element group 62:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 62: predecessors 
    -- CP-element group 62: 	7 
    -- CP-element group 62: successors 
    -- CP-element group 62:  members (1) 
      -- CP-element group 62: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(62) <= outputPort_1_Daemon_CP_356_elements(7);
    -- CP-element group 63:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 63: predecessors 
    -- CP-element group 63: successors 
    -- CP-element group 63:  members (2) 
      -- CP-element group 63: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_loopback_sample_req_ps
      -- CP-element group 63: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_loopback_sample_req
      -- 
    phi_stmt_299_loopback_sample_req_484_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_299_loopback_sample_req_484_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(63), ack => phi_stmt_299_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(63) is bound as output of CP function.
    -- CP-element group 64:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 64: predecessors 
    -- CP-element group 64: 	8 
    -- CP-element group 64: successors 
    -- CP-element group 64:  members (1) 
      -- CP-element group 64: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_entry_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(64) <= outputPort_1_Daemon_CP_356_elements(8);
    -- CP-element group 65:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 65: predecessors 
    -- CP-element group 65: successors 
    -- CP-element group 65:  members (2) 
      -- CP-element group 65: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_entry_sample_req_ps
      -- CP-element group 65: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_entry_sample_req
      -- 
    phi_stmt_299_entry_sample_req_487_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_299_entry_sample_req_487_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(65), ack => phi_stmt_299_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(65) is bound as output of CP function.
    -- CP-element group 66:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 66: predecessors 
    -- CP-element group 66: successors 
    -- CP-element group 66:  members (2) 
      -- CP-element group 66: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_phi_mux_ack_ps
      -- CP-element group 66: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_299_phi_mux_ack
      -- 
    phi_stmt_299_phi_mux_ack_490_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 66_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_299_ack_0, ack => outputPort_1_Daemon_CP_356_elements(66)); -- 
    -- CP-element group 67:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 67: predecessors 
    -- CP-element group 67: successors 
    -- CP-element group 67:  members (4) 
      -- CP-element group 67: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_301_sample_completed_
      -- CP-element group 67: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_301_sample_start_
      -- CP-element group 67: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_301_sample_completed__ps
      -- CP-element group 67: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_301_sample_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(67) is bound as output of CP function.
    -- CP-element group 68:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 68: predecessors 
    -- CP-element group 68: successors 
    -- CP-element group 68: 	70 
    -- CP-element group 68:  members (2) 
      -- CP-element group 68: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_301_update_start_
      -- CP-element group 68: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_301_update_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(68) is bound as output of CP function.
    -- CP-element group 69:  join  transition  bypass  pipeline-parent 
    -- CP-element group 69: predecessors 
    -- CP-element group 69: 	70 
    -- CP-element group 69: successors 
    -- CP-element group 69:  members (1) 
      -- CP-element group 69: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_301_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(69) <= outputPort_1_Daemon_CP_356_elements(70);
    -- CP-element group 70:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 70: predecessors 
    -- CP-element group 70: 	68 
    -- CP-element group 70: successors 
    -- CP-element group 70: 	69 
    -- CP-element group 70:  members (1) 
      -- CP-element group 70: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_33_301_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(70) is a control-delay.
    cp_element_70_delay: control_delay_element  generic map(name => " 70_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_356_elements(68), ack => outputPort_1_Daemon_CP_356_elements(70), clk => clk, reset =>reset);
    -- CP-element group 71:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 71: predecessors 
    -- CP-element group 71: successors 
    -- CP-element group 71: 	73 
    -- CP-element group 71:  members (1) 
      -- CP-element group 71: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_sample_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(71) is bound as output of CP function.
    -- CP-element group 72:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 72: predecessors 
    -- CP-element group 72: successors 
    -- CP-element group 72: 	74 
    -- CP-element group 72:  members (1) 
      -- CP-element group 72: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_update_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(72) is bound as output of CP function.
    -- CP-element group 73:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 73: predecessors 
    -- CP-element group 73: 	71 
    -- CP-element group 73: marked-predecessors 
    -- CP-element group 73: 	76 
    -- CP-element group 73: successors 
    -- CP-element group 73: 	75 
    -- CP-element group 73:  members (3) 
      -- CP-element group 73: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_Sample/rr
      -- CP-element group 73: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_Sample/$entry
      -- CP-element group 73: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_sample_start_
      -- 
    rr_511_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_511_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(73), ack => RPIPE_noblock_obuf_2_1_303_inst_req_0); -- 
    outputPort_1_Daemon_cp_element_group_73: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_73"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(71) & outputPort_1_Daemon_CP_356_elements(76);
      gj_outputPort_1_Daemon_cp_element_group_73 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(73), clk => clk, reset => reset); --
    end block;
    -- CP-element group 74:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 74: predecessors 
    -- CP-element group 74: 	72 
    -- CP-element group 74: 	75 
    -- CP-element group 74: successors 
    -- CP-element group 74: 	76 
    -- CP-element group 74:  members (3) 
      -- CP-element group 74: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_Update/cr
      -- CP-element group 74: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_Update/$entry
      -- CP-element group 74: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_update_start_
      -- 
    cr_516_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_516_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(74), ack => RPIPE_noblock_obuf_2_1_303_inst_req_1); -- 
    outputPort_1_Daemon_cp_element_group_74: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_74"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(72) & outputPort_1_Daemon_CP_356_elements(75);
      gj_outputPort_1_Daemon_cp_element_group_74 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(74), clk => clk, reset => reset); --
    end block;
    -- CP-element group 75:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 75: predecessors 
    -- CP-element group 75: 	73 
    -- CP-element group 75: successors 
    -- CP-element group 75: 	74 
    -- CP-element group 75:  members (4) 
      -- CP-element group 75: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_sample_completed__ps
      -- CP-element group 75: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_Sample/ra
      -- CP-element group 75: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_Sample/$exit
      -- CP-element group 75: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_sample_completed_
      -- 
    ra_512_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 75_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_2_1_303_inst_ack_0, ack => outputPort_1_Daemon_CP_356_elements(75)); -- 
    -- CP-element group 76:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 76: predecessors 
    -- CP-element group 76: 	74 
    -- CP-element group 76: successors 
    -- CP-element group 76: marked-successors 
    -- CP-element group 76: 	73 
    -- CP-element group 76:  members (4) 
      -- CP-element group 76: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_update_completed__ps
      -- CP-element group 76: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_Update/ca
      -- CP-element group 76: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_Update/$exit
      -- CP-element group 76: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/RPIPE_noblock_obuf_2_1_303_update_completed_
      -- 
    ca_517_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 76_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_2_1_303_inst_ack_1, ack => outputPort_1_Daemon_CP_356_elements(76)); -- 
    -- CP-element group 77:  join  transition  bypass  pipeline-parent 
    -- CP-element group 77: predecessors 
    -- CP-element group 77: 	9 
    -- CP-element group 77: marked-predecessors 
    -- CP-element group 77: 	12 
    -- CP-element group 77: successors 
    -- CP-element group 77: 	11 
    -- CP-element group 77:  members (1) 
      -- CP-element group 77: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_77: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_77"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_77 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(77), clk => clk, reset => reset); --
    end block;
    -- CP-element group 78:  join  transition  bypass  pipeline-parent 
    -- CP-element group 78: predecessors 
    -- CP-element group 78: 	9 
    -- CP-element group 78: marked-predecessors 
    -- CP-element group 78: 	133 
    -- CP-element group 78: successors 
    -- CP-element group 78: 	14 
    -- CP-element group 78:  members (1) 
      -- CP-element group 78: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_78: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_78"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(133);
      gj_outputPort_1_Daemon_cp_element_group_78 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(78), clk => clk, reset => reset); --
    end block;
    -- CP-element group 79:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 79: predecessors 
    -- CP-element group 79: 	11 
    -- CP-element group 79: successors 
    -- CP-element group 79:  members (1) 
      -- CP-element group 79: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_sample_start__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(79) <= outputPort_1_Daemon_CP_356_elements(11);
    -- CP-element group 80:  join  transition  bypass  pipeline-parent 
    -- CP-element group 80: predecessors 
    -- CP-element group 80: successors 
    -- CP-element group 80: 	12 
    -- CP-element group 80:  members (1) 
      -- CP-element group 80: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(80) is bound as output of CP function.
    -- CP-element group 81:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 81: predecessors 
    -- CP-element group 81: 	14 
    -- CP-element group 81: successors 
    -- CP-element group 81:  members (1) 
      -- CP-element group 81: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_update_start__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(81) <= outputPort_1_Daemon_CP_356_elements(14);
    -- CP-element group 82:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 82: predecessors 
    -- CP-element group 82: successors 
    -- CP-element group 82: 	132 
    -- CP-element group 82: 	15 
    -- CP-element group 82:  members (2) 
      -- CP-element group 82: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_update_completed__ps
      -- CP-element group 82: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(82) is bound as output of CP function.
    -- CP-element group 83:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 83: predecessors 
    -- CP-element group 83: 	7 
    -- CP-element group 83: successors 
    -- CP-element group 83:  members (1) 
      -- CP-element group 83: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(83) <= outputPort_1_Daemon_CP_356_elements(7);
    -- CP-element group 84:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 84: predecessors 
    -- CP-element group 84: successors 
    -- CP-element group 84:  members (2) 
      -- CP-element group 84: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_loopback_sample_req_ps
      -- CP-element group 84: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_loopback_sample_req
      -- 
    phi_stmt_304_loopback_sample_req_528_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_304_loopback_sample_req_528_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(84), ack => phi_stmt_304_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(84) is bound as output of CP function.
    -- CP-element group 85:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 85: predecessors 
    -- CP-element group 85: 	8 
    -- CP-element group 85: successors 
    -- CP-element group 85:  members (1) 
      -- CP-element group 85: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_entry_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(85) <= outputPort_1_Daemon_CP_356_elements(8);
    -- CP-element group 86:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 86: predecessors 
    -- CP-element group 86: successors 
    -- CP-element group 86:  members (2) 
      -- CP-element group 86: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_entry_sample_req_ps
      -- CP-element group 86: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_entry_sample_req
      -- 
    phi_stmt_304_entry_sample_req_531_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_304_entry_sample_req_531_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(86), ack => phi_stmt_304_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(86) is bound as output of CP function.
    -- CP-element group 87:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 87: predecessors 
    -- CP-element group 87: successors 
    -- CP-element group 87:  members (2) 
      -- CP-element group 87: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_phi_mux_ack_ps
      -- CP-element group 87: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_304_phi_mux_ack
      -- 
    phi_stmt_304_phi_mux_ack_534_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 87_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_304_ack_0, ack => outputPort_1_Daemon_CP_356_elements(87)); -- 
    -- CP-element group 88:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 88: predecessors 
    -- CP-element group 88: successors 
    -- CP-element group 88:  members (4) 
      -- CP-element group 88: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_2_306_sample_start__ps
      -- CP-element group 88: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_2_306_sample_completed_
      -- CP-element group 88: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_2_306_sample_start_
      -- CP-element group 88: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_2_306_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(88) is bound as output of CP function.
    -- CP-element group 89:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 89: predecessors 
    -- CP-element group 89: successors 
    -- CP-element group 89: 	91 
    -- CP-element group 89:  members (2) 
      -- CP-element group 89: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_2_306_update_start_
      -- CP-element group 89: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_2_306_update_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(89) is bound as output of CP function.
    -- CP-element group 90:  join  transition  bypass  pipeline-parent 
    -- CP-element group 90: predecessors 
    -- CP-element group 90: 	91 
    -- CP-element group 90: successors 
    -- CP-element group 90:  members (1) 
      -- CP-element group 90: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_2_306_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(90) <= outputPort_1_Daemon_CP_356_elements(91);
    -- CP-element group 91:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 91: predecessors 
    -- CP-element group 91: 	89 
    -- CP-element group 91: successors 
    -- CP-element group 91: 	90 
    -- CP-element group 91:  members (1) 
      -- CP-element group 91: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_2_306_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(91) is a control-delay.
    cp_element_91_delay: control_delay_element  generic map(name => " 91_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_356_elements(89), ack => outputPort_1_Daemon_CP_356_elements(91), clk => clk, reset =>reset);
    -- CP-element group 92:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 92: predecessors 
    -- CP-element group 92: successors 
    -- CP-element group 92: 	94 
    -- CP-element group 92:  members (4) 
      -- CP-element group 92: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_Sample/req
      -- CP-element group 92: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_Sample/$entry
      -- CP-element group 92: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_sample_start_
      -- CP-element group 92: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_sample_start__ps
      -- 
    req_555_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_555_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(92), ack => next_active_packet_357_307_buf_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(92) is bound as output of CP function.
    -- CP-element group 93:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 93: predecessors 
    -- CP-element group 93: successors 
    -- CP-element group 93: 	95 
    -- CP-element group 93:  members (4) 
      -- CP-element group 93: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_Update/req
      -- CP-element group 93: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_Update/$entry
      -- CP-element group 93: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_update_start_
      -- CP-element group 93: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_update_start__ps
      -- 
    req_560_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_560_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(93), ack => next_active_packet_357_307_buf_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(93) is bound as output of CP function.
    -- CP-element group 94:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 94: predecessors 
    -- CP-element group 94: 	92 
    -- CP-element group 94: successors 
    -- CP-element group 94:  members (4) 
      -- CP-element group 94: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_Sample/ack
      -- CP-element group 94: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_Sample/$exit
      -- CP-element group 94: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_sample_completed_
      -- CP-element group 94: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_sample_completed__ps
      -- 
    ack_556_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 94_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_357_307_buf_ack_0, ack => outputPort_1_Daemon_CP_356_elements(94)); -- 
    -- CP-element group 95:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 95: predecessors 
    -- CP-element group 95: 	93 
    -- CP-element group 95: successors 
    -- CP-element group 95:  members (4) 
      -- CP-element group 95: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_Update/ack
      -- CP-element group 95: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_Update/$exit
      -- CP-element group 95: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_update_completed_
      -- CP-element group 95: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_307_update_completed__ps
      -- 
    ack_561_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 95_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_357_307_buf_ack_1, ack => outputPort_1_Daemon_CP_356_elements(95)); -- 
    -- CP-element group 96:  join  transition  bypass  pipeline-parent 
    -- CP-element group 96: predecessors 
    -- CP-element group 96: 	9 
    -- CP-element group 96: marked-predecessors 
    -- CP-element group 96: 	12 
    -- CP-element group 96: successors 
    -- CP-element group 96: 	11 
    -- CP-element group 96:  members (1) 
      -- CP-element group 96: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_96: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_96"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_96 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(96), clk => clk, reset => reset); --
    end block;
    -- CP-element group 97:  join  transition  bypass  pipeline-parent 
    -- CP-element group 97: predecessors 
    -- CP-element group 97: 	9 
    -- CP-element group 97: marked-predecessors 
    -- CP-element group 97: 	99 
    -- CP-element group 97: successors 
    -- CP-element group 97: 	14 
    -- CP-element group 97:  members (1) 
      -- CP-element group 97: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_97: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_1_Daemon_cp_element_group_97"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(99);
      gj_outputPort_1_Daemon_cp_element_group_97 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(97), clk => clk, reset => reset); --
    end block;
    -- CP-element group 98:  join  transition  bypass  pipeline-parent 
    -- CP-element group 98: predecessors 
    -- CP-element group 98: successors 
    -- CP-element group 98: 	12 
    -- CP-element group 98:  members (1) 
      -- CP-element group 98: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(98) is bound as output of CP function.
    -- CP-element group 99:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 99: predecessors 
    -- CP-element group 99: successors 
    -- CP-element group 99: 	15 
    -- CP-element group 99: marked-successors 
    -- CP-element group 99: 	97 
    -- CP-element group 99:  members (2) 
      -- CP-element group 99: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_update_completed__ps
      -- CP-element group 99: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(99) is bound as output of CP function.
    -- CP-element group 100:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 100: predecessors 
    -- CP-element group 100: 	7 
    -- CP-element group 100: successors 
    -- CP-element group 100:  members (1) 
      -- CP-element group 100: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(100) <= outputPort_1_Daemon_CP_356_elements(7);
    -- CP-element group 101:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 101: predecessors 
    -- CP-element group 101: successors 
    -- CP-element group 101:  members (2) 
      -- CP-element group 101: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_loopback_sample_req_ps
      -- CP-element group 101: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_loopback_sample_req
      -- 
    phi_stmt_308_loopback_sample_req_572_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_308_loopback_sample_req_572_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(101), ack => phi_stmt_308_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(101) is bound as output of CP function.
    -- CP-element group 102:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 102: predecessors 
    -- CP-element group 102: 	8 
    -- CP-element group 102: successors 
    -- CP-element group 102:  members (1) 
      -- CP-element group 102: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_entry_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(102) <= outputPort_1_Daemon_CP_356_elements(8);
    -- CP-element group 103:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 103: predecessors 
    -- CP-element group 103: successors 
    -- CP-element group 103:  members (2) 
      -- CP-element group 103: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_entry_sample_req_ps
      -- CP-element group 103: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_entry_sample_req
      -- 
    phi_stmt_308_entry_sample_req_575_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_308_entry_sample_req_575_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(103), ack => phi_stmt_308_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(103) is bound as output of CP function.
    -- CP-element group 104:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 104: predecessors 
    -- CP-element group 104: successors 
    -- CP-element group 104:  members (2) 
      -- CP-element group 104: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_phi_mux_ack_ps
      -- CP-element group 104: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_308_phi_mux_ack
      -- 
    phi_stmt_308_phi_mux_ack_578_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 104_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_308_ack_0, ack => outputPort_1_Daemon_CP_356_elements(104)); -- 
    -- CP-element group 105:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 105: predecessors 
    -- CP-element group 105: successors 
    -- CP-element group 105:  members (4) 
      -- CP-element group 105: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_310_sample_start__ps
      -- CP-element group 105: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_310_sample_completed__ps
      -- CP-element group 105: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_310_sample_completed_
      -- CP-element group 105: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_310_sample_start_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(105) is bound as output of CP function.
    -- CP-element group 106:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 106: predecessors 
    -- CP-element group 106: successors 
    -- CP-element group 106: 	108 
    -- CP-element group 106:  members (2) 
      -- CP-element group 106: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_310_update_start_
      -- CP-element group 106: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_310_update_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(106) is bound as output of CP function.
    -- CP-element group 107:  join  transition  bypass  pipeline-parent 
    -- CP-element group 107: predecessors 
    -- CP-element group 107: 	108 
    -- CP-element group 107: successors 
    -- CP-element group 107:  members (1) 
      -- CP-element group 107: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_310_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(107) <= outputPort_1_Daemon_CP_356_elements(108);
    -- CP-element group 108:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 108: predecessors 
    -- CP-element group 108: 	106 
    -- CP-element group 108: successors 
    -- CP-element group 108: 	107 
    -- CP-element group 108:  members (1) 
      -- CP-element group 108: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_8_310_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(108) is a control-delay.
    cp_element_108_delay: control_delay_element  generic map(name => " 108_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_356_elements(106), ack => outputPort_1_Daemon_CP_356_elements(108), clk => clk, reset =>reset);
    -- CP-element group 109:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 109: predecessors 
    -- CP-element group 109: successors 
    -- CP-element group 109: 	111 
    -- CP-element group 109:  members (4) 
      -- CP-element group 109: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_Sample/req
      -- CP-element group 109: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_sample_start__ps
      -- CP-element group 109: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_Sample/$entry
      -- CP-element group 109: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_sample_start_
      -- 
    req_599_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_599_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(109), ack => next_active_packet_length_379_311_buf_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(109) is bound as output of CP function.
    -- CP-element group 110:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 110: predecessors 
    -- CP-element group 110: successors 
    -- CP-element group 110: 	112 
    -- CP-element group 110:  members (4) 
      -- CP-element group 110: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_Update/$entry
      -- CP-element group 110: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_update_start__ps
      -- CP-element group 110: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_Update/req
      -- CP-element group 110: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_update_start_
      -- 
    req_604_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_604_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(110), ack => next_active_packet_length_379_311_buf_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(110) is bound as output of CP function.
    -- CP-element group 111:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 111: predecessors 
    -- CP-element group 111: 	109 
    -- CP-element group 111: successors 
    -- CP-element group 111:  members (4) 
      -- CP-element group 111: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_sample_completed__ps
      -- CP-element group 111: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_Sample/ack
      -- CP-element group 111: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_Sample/$exit
      -- CP-element group 111: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_sample_completed_
      -- 
    ack_600_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 111_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_length_379_311_buf_ack_0, ack => outputPort_1_Daemon_CP_356_elements(111)); -- 
    -- CP-element group 112:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 112: predecessors 
    -- CP-element group 112: 	110 
    -- CP-element group 112: successors 
    -- CP-element group 112:  members (4) 
      -- CP-element group 112: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_Update/$exit
      -- CP-element group 112: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_update_completed__ps
      -- CP-element group 112: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_Update/ack
      -- CP-element group 112: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_active_packet_length_311_update_completed_
      -- 
    ack_605_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 112_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_length_379_311_buf_ack_1, ack => outputPort_1_Daemon_CP_356_elements(112)); -- 
    -- CP-element group 113:  join  transition  bypass  pipeline-parent 
    -- CP-element group 113: predecessors 
    -- CP-element group 113: 	9 
    -- CP-element group 113: marked-predecessors 
    -- CP-element group 113: 	12 
    -- CP-element group 113: successors 
    -- CP-element group 113: 	11 
    -- CP-element group 113:  members (1) 
      -- CP-element group 113: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_sample_start_
      -- 
    outputPort_1_Daemon_cp_element_group_113: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 40) := "outputPort_1_Daemon_cp_element_group_113"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_113 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(113), clk => clk, reset => reset); --
    end block;
    -- CP-element group 114:  join  transition  bypass  pipeline-parent 
    -- CP-element group 114: predecessors 
    -- CP-element group 114: 	9 
    -- CP-element group 114: marked-predecessors 
    -- CP-element group 114: 	133 
    -- CP-element group 114: successors 
    -- CP-element group 114: 	14 
    -- CP-element group 114:  members (1) 
      -- CP-element group 114: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_update_start_
      -- 
    outputPort_1_Daemon_cp_element_group_114: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 40) := "outputPort_1_Daemon_cp_element_group_114"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(9) & outputPort_1_Daemon_CP_356_elements(133);
      gj_outputPort_1_Daemon_cp_element_group_114 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(114), clk => clk, reset => reset); --
    end block;
    -- CP-element group 115:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 115: predecessors 
    -- CP-element group 115: 	11 
    -- CP-element group 115: successors 
    -- CP-element group 115:  members (1) 
      -- CP-element group 115: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_sample_start__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(115) <= outputPort_1_Daemon_CP_356_elements(11);
    -- CP-element group 116:  join  transition  bypass  pipeline-parent 
    -- CP-element group 116: predecessors 
    -- CP-element group 116: successors 
    -- CP-element group 116: 	12 
    -- CP-element group 116:  members (1) 
      -- CP-element group 116: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_sample_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(116) is bound as output of CP function.
    -- CP-element group 117:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 117: predecessors 
    -- CP-element group 117: 	14 
    -- CP-element group 117: successors 
    -- CP-element group 117:  members (1) 
      -- CP-element group 117: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_update_start__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(117) <= outputPort_1_Daemon_CP_356_elements(14);
    -- CP-element group 118:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 118: predecessors 
    -- CP-element group 118: successors 
    -- CP-element group 118: 	132 
    -- CP-element group 118: 	15 
    -- CP-element group 118:  members (2) 
      -- CP-element group 118: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_update_completed_
      -- CP-element group 118: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_update_completed__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(118) is bound as output of CP function.
    -- CP-element group 119:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 119: predecessors 
    -- CP-element group 119: 	7 
    -- CP-element group 119: successors 
    -- CP-element group 119:  members (1) 
      -- CP-element group 119: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_loopback_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(119) <= outputPort_1_Daemon_CP_356_elements(7);
    -- CP-element group 120:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 120: predecessors 
    -- CP-element group 120: successors 
    -- CP-element group 120:  members (2) 
      -- CP-element group 120: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_loopback_sample_req
      -- CP-element group 120: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_loopback_sample_req_ps
      -- 
    phi_stmt_312_loopback_sample_req_616_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_312_loopback_sample_req_616_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(120), ack => phi_stmt_312_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(120) is bound as output of CP function.
    -- CP-element group 121:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 121: predecessors 
    -- CP-element group 121: 	8 
    -- CP-element group 121: successors 
    -- CP-element group 121:  members (1) 
      -- CP-element group 121: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_entry_trigger
      -- 
    outputPort_1_Daemon_CP_356_elements(121) <= outputPort_1_Daemon_CP_356_elements(8);
    -- CP-element group 122:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 122: predecessors 
    -- CP-element group 122: successors 
    -- CP-element group 122:  members (2) 
      -- CP-element group 122: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_entry_sample_req_ps
      -- CP-element group 122: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_entry_sample_req
      -- 
    phi_stmt_312_entry_sample_req_619_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_312_entry_sample_req_619_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(122), ack => phi_stmt_312_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(122) is bound as output of CP function.
    -- CP-element group 123:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 123: predecessors 
    -- CP-element group 123: successors 
    -- CP-element group 123:  members (2) 
      -- CP-element group 123: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_phi_mux_ack_ps
      -- CP-element group 123: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/phi_stmt_312_phi_mux_ack
      -- 
    phi_stmt_312_phi_mux_ack_622_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 123_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_312_ack_0, ack => outputPort_1_Daemon_CP_356_elements(123)); -- 
    -- CP-element group 124:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 124: predecessors 
    -- CP-element group 124: successors 
    -- CP-element group 124:  members (4) 
      -- CP-element group 124: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_1_314_sample_completed__ps
      -- CP-element group 124: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_1_314_sample_completed_
      -- CP-element group 124: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_1_314_sample_start_
      -- CP-element group 124: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_1_314_sample_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(124) is bound as output of CP function.
    -- CP-element group 125:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 125: predecessors 
    -- CP-element group 125: successors 
    -- CP-element group 125: 	127 
    -- CP-element group 125:  members (2) 
      -- CP-element group 125: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_1_314_update_start_
      -- CP-element group 125: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_1_314_update_start__ps
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(125) is bound as output of CP function.
    -- CP-element group 126:  join  transition  bypass  pipeline-parent 
    -- CP-element group 126: predecessors 
    -- CP-element group 126: 	127 
    -- CP-element group 126: successors 
    -- CP-element group 126:  members (1) 
      -- CP-element group 126: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_1_314_update_completed__ps
      -- 
    outputPort_1_Daemon_CP_356_elements(126) <= outputPort_1_Daemon_CP_356_elements(127);
    -- CP-element group 127:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 127: predecessors 
    -- CP-element group 127: 	125 
    -- CP-element group 127: successors 
    -- CP-element group 127: 	126 
    -- CP-element group 127:  members (1) 
      -- CP-element group 127: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_ZERO_1_314_update_completed_
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(127) is a control-delay.
    cp_element_127_delay: control_delay_element  generic map(name => " 127_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_356_elements(125), ack => outputPort_1_Daemon_CP_356_elements(127), clk => clk, reset =>reset);
    -- CP-element group 128:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 128: predecessors 
    -- CP-element group 128: successors 
    -- CP-element group 128: 	130 
    -- CP-element group 128:  members (4) 
      -- CP-element group 128: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_Sample/$entry
      -- CP-element group 128: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_Sample/req
      -- CP-element group 128: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_sample_start__ps
      -- CP-element group 128: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_sample_start_
      -- 
    req_643_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_643_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(128), ack => next_pkt_1_has_priority_357_315_buf_req_0); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(128) is bound as output of CP function.
    -- CP-element group 129:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 129: predecessors 
    -- CP-element group 129: successors 
    -- CP-element group 129: 	131 
    -- CP-element group 129:  members (4) 
      -- CP-element group 129: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_update_start_
      -- CP-element group 129: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_Update/$entry
      -- CP-element group 129: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_update_start__ps
      -- CP-element group 129: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_Update/req
      -- 
    req_648_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_648_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(129), ack => next_pkt_1_has_priority_357_315_buf_req_1); -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(129) is bound as output of CP function.
    -- CP-element group 130:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 130: predecessors 
    -- CP-element group 130: 	128 
    -- CP-element group 130: successors 
    -- CP-element group 130:  members (4) 
      -- CP-element group 130: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_sample_completed_
      -- CP-element group 130: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_sample_completed__ps
      -- CP-element group 130: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_Sample/$exit
      -- CP-element group 130: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_Sample/ack
      -- 
    ack_644_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 130_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_pkt_1_has_priority_357_315_buf_ack_0, ack => outputPort_1_Daemon_CP_356_elements(130)); -- 
    -- CP-element group 131:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 131: predecessors 
    -- CP-element group 131: 	129 
    -- CP-element group 131: successors 
    -- CP-element group 131:  members (4) 
      -- CP-element group 131: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_update_completed_
      -- CP-element group 131: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_Update/$exit
      -- CP-element group 131: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_Update/ack
      -- CP-element group 131: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/R_next_pkt_1_has_priority_315_update_completed__ps
      -- 
    ack_649_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 131_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_pkt_1_has_priority_357_315_buf_ack_1, ack => outputPort_1_Daemon_CP_356_elements(131)); -- 
    -- CP-element group 132:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 132: predecessors 
    -- CP-element group 132: 	118 
    -- CP-element group 132: 	21 
    -- CP-element group 132: 	40 
    -- CP-element group 132: 	61 
    -- CP-element group 132: 	82 
    -- CP-element group 132: marked-predecessors 
    -- CP-element group 132: 	134 
    -- CP-element group 132: successors 
    -- CP-element group 132: 	133 
    -- CP-element group 132:  members (3) 
      -- CP-element group 132: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_Sample/req
      -- CP-element group 132: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_sample_start_
      -- CP-element group 132: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_Sample/$entry
      -- 
    req_658_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_658_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(132), ack => WPIPE_out_data_1_435_inst_req_0); -- 
    outputPort_1_Daemon_cp_element_group_132: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 1);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 40) := "outputPort_1_Daemon_cp_element_group_132"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(118) & outputPort_1_Daemon_CP_356_elements(21) & outputPort_1_Daemon_CP_356_elements(40) & outputPort_1_Daemon_CP_356_elements(61) & outputPort_1_Daemon_CP_356_elements(82) & outputPort_1_Daemon_CP_356_elements(134);
      gj_outputPort_1_Daemon_cp_element_group_132 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(132), clk => clk, reset => reset); --
    end block;
    -- CP-element group 133:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 133: predecessors 
    -- CP-element group 133: 	132 
    -- CP-element group 133: successors 
    -- CP-element group 133: 	134 
    -- CP-element group 133: marked-successors 
    -- CP-element group 133: 	114 
    -- CP-element group 133: 	17 
    -- CP-element group 133: 	36 
    -- CP-element group 133: 	57 
    -- CP-element group 133: 	78 
    -- CP-element group 133:  members (6) 
      -- CP-element group 133: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_sample_completed_
      -- CP-element group 133: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_Sample/ack
      -- CP-element group 133: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_Update/req
      -- CP-element group 133: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_update_start_
      -- CP-element group 133: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_Sample/$exit
      -- CP-element group 133: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_Update/$entry
      -- 
    ack_659_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 133_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_data_1_435_inst_ack_0, ack => outputPort_1_Daemon_CP_356_elements(133)); -- 
    req_663_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_663_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_1_Daemon_CP_356_elements(133), ack => WPIPE_out_data_1_435_inst_req_1); -- 
    -- CP-element group 134:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 134: predecessors 
    -- CP-element group 134: 	133 
    -- CP-element group 134: successors 
    -- CP-element group 134: 	136 
    -- CP-element group 134: marked-successors 
    -- CP-element group 134: 	132 
    -- CP-element group 134:  members (3) 
      -- CP-element group 134: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_update_completed_
      -- CP-element group 134: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_Update/ack
      -- CP-element group 134: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/WPIPE_out_data_1_435_Update/$exit
      -- 
    ack_664_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 134_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_data_1_435_inst_ack_1, ack => outputPort_1_Daemon_CP_356_elements(134)); -- 
    -- CP-element group 135:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 135: predecessors 
    -- CP-element group 135: 	9 
    -- CP-element group 135: successors 
    -- CP-element group 135: 	10 
    -- CP-element group 135:  members (1) 
      -- CP-element group 135: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/loop_body_delay_to_condition_start
      -- 
    -- Element group outputPort_1_Daemon_CP_356_elements(135) is a control-delay.
    cp_element_135_delay: control_delay_element  generic map(name => " 135_delay", delay_value => 1)  port map(req => outputPort_1_Daemon_CP_356_elements(9), ack => outputPort_1_Daemon_CP_356_elements(135), clk => clk, reset =>reset);
    -- CP-element group 136:  join  transition  bypass  pipeline-parent 
    -- CP-element group 136: predecessors 
    -- CP-element group 136: 	134 
    -- CP-element group 136: 	12 
    -- CP-element group 136: successors 
    -- CP-element group 136: 	6 
    -- CP-element group 136:  members (1) 
      -- CP-element group 136: 	 branch_block_stmt_287/do_while_stmt_288/do_while_stmt_288_loop_body/$exit
      -- 
    outputPort_1_Daemon_cp_element_group_136: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 7);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 40) := "outputPort_1_Daemon_cp_element_group_136"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_1_Daemon_CP_356_elements(134) & outputPort_1_Daemon_CP_356_elements(12);
      gj_outputPort_1_Daemon_cp_element_group_136 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(136), clk => clk, reset => reset); --
    end block;
    -- CP-element group 137:  transition  input  bypass  pipeline-parent 
    -- CP-element group 137: predecessors 
    -- CP-element group 137: 	5 
    -- CP-element group 137: successors 
    -- CP-element group 137:  members (2) 
      -- CP-element group 137: 	 branch_block_stmt_287/do_while_stmt_288/loop_exit/ack
      -- CP-element group 137: 	 branch_block_stmt_287/do_while_stmt_288/loop_exit/$exit
      -- 
    ack_669_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 137_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_288_branch_ack_0, ack => outputPort_1_Daemon_CP_356_elements(137)); -- 
    -- CP-element group 138:  transition  input  bypass  pipeline-parent 
    -- CP-element group 138: predecessors 
    -- CP-element group 138: 	5 
    -- CP-element group 138: successors 
    -- CP-element group 138:  members (2) 
      -- CP-element group 138: 	 branch_block_stmt_287/do_while_stmt_288/loop_taken/$exit
      -- CP-element group 138: 	 branch_block_stmt_287/do_while_stmt_288/loop_taken/ack
      -- 
    ack_673_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 138_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_288_branch_ack_1, ack => outputPort_1_Daemon_CP_356_elements(138)); -- 
    -- CP-element group 139:  transition  bypass  pipeline-parent 
    -- CP-element group 139: predecessors 
    -- CP-element group 139: 	3 
    -- CP-element group 139: successors 
    -- CP-element group 139: 	1 
    -- CP-element group 139:  members (1) 
      -- CP-element group 139: 	 branch_block_stmt_287/do_while_stmt_288/$exit
      -- 
    outputPort_1_Daemon_CP_356_elements(139) <= outputPort_1_Daemon_CP_356_elements(3);
    outputPort_1_Daemon_do_while_stmt_288_terminator_674: loop_terminator -- 
      generic map (name => " outputPort_1_Daemon_do_while_stmt_288_terminator_674", max_iterations_in_flight =>7) 
      port map(loop_body_exit => outputPort_1_Daemon_CP_356_elements(6),loop_continue => outputPort_1_Daemon_CP_356_elements(138),loop_terminate => outputPort_1_Daemon_CP_356_elements(137),loop_back => outputPort_1_Daemon_CP_356_elements(4),loop_exit => outputPort_1_Daemon_CP_356_elements(3),clk => clk, reset => reset); -- 
    phi_stmt_290_phi_seq_430_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_356_elements(24);
      outputPort_1_Daemon_CP_356_elements(27)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_356_elements(27);
      outputPort_1_Daemon_CP_356_elements(28)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_356_elements(29);
      outputPort_1_Daemon_CP_356_elements(25) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_356_elements(22);
      outputPort_1_Daemon_CP_356_elements(31)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_356_elements(33);
      outputPort_1_Daemon_CP_356_elements(32)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_356_elements(34);
      outputPort_1_Daemon_CP_356_elements(23) <= phi_mux_reqs(1);
      phi_stmt_290_phi_seq_430 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_290_phi_seq_430") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_356_elements(18), 
          phi_sample_ack => outputPort_1_Daemon_CP_356_elements(19), 
          phi_update_req => outputPort_1_Daemon_CP_356_elements(20), 
          phi_update_ack => outputPort_1_Daemon_CP_356_elements(21), 
          phi_mux_ack => outputPort_1_Daemon_CP_356_elements(26), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_294_phi_seq_474_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_356_elements(43);
      outputPort_1_Daemon_CP_356_elements(46)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_356_elements(46);
      outputPort_1_Daemon_CP_356_elements(47)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_356_elements(48);
      outputPort_1_Daemon_CP_356_elements(44) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_356_elements(41);
      outputPort_1_Daemon_CP_356_elements(50)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_356_elements(54);
      outputPort_1_Daemon_CP_356_elements(51)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_356_elements(55);
      outputPort_1_Daemon_CP_356_elements(42) <= phi_mux_reqs(1);
      phi_stmt_294_phi_seq_474 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_294_phi_seq_474") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_356_elements(37), 
          phi_sample_ack => outputPort_1_Daemon_CP_356_elements(38), 
          phi_update_req => outputPort_1_Daemon_CP_356_elements(39), 
          phi_update_ack => outputPort_1_Daemon_CP_356_elements(40), 
          phi_mux_ack => outputPort_1_Daemon_CP_356_elements(45), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_299_phi_seq_518_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_356_elements(64);
      outputPort_1_Daemon_CP_356_elements(67)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_356_elements(67);
      outputPort_1_Daemon_CP_356_elements(68)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_356_elements(69);
      outputPort_1_Daemon_CP_356_elements(65) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_356_elements(62);
      outputPort_1_Daemon_CP_356_elements(71)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_356_elements(75);
      outputPort_1_Daemon_CP_356_elements(72)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_356_elements(76);
      outputPort_1_Daemon_CP_356_elements(63) <= phi_mux_reqs(1);
      phi_stmt_299_phi_seq_518 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_299_phi_seq_518") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_356_elements(58), 
          phi_sample_ack => outputPort_1_Daemon_CP_356_elements(59), 
          phi_update_req => outputPort_1_Daemon_CP_356_elements(60), 
          phi_update_ack => outputPort_1_Daemon_CP_356_elements(61), 
          phi_mux_ack => outputPort_1_Daemon_CP_356_elements(66), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_304_phi_seq_562_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_356_elements(85);
      outputPort_1_Daemon_CP_356_elements(88)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_356_elements(88);
      outputPort_1_Daemon_CP_356_elements(89)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_356_elements(90);
      outputPort_1_Daemon_CP_356_elements(86) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_356_elements(83);
      outputPort_1_Daemon_CP_356_elements(92)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_356_elements(94);
      outputPort_1_Daemon_CP_356_elements(93)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_356_elements(95);
      outputPort_1_Daemon_CP_356_elements(84) <= phi_mux_reqs(1);
      phi_stmt_304_phi_seq_562 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_304_phi_seq_562") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_356_elements(79), 
          phi_sample_ack => outputPort_1_Daemon_CP_356_elements(80), 
          phi_update_req => outputPort_1_Daemon_CP_356_elements(81), 
          phi_update_ack => outputPort_1_Daemon_CP_356_elements(82), 
          phi_mux_ack => outputPort_1_Daemon_CP_356_elements(87), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_308_phi_seq_606_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_356_elements(102);
      outputPort_1_Daemon_CP_356_elements(105)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_356_elements(105);
      outputPort_1_Daemon_CP_356_elements(106)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_356_elements(107);
      outputPort_1_Daemon_CP_356_elements(103) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_356_elements(100);
      outputPort_1_Daemon_CP_356_elements(109)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_356_elements(111);
      outputPort_1_Daemon_CP_356_elements(110)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_356_elements(112);
      outputPort_1_Daemon_CP_356_elements(101) <= phi_mux_reqs(1);
      phi_stmt_308_phi_seq_606 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_308_phi_seq_606") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_356_elements(11), 
          phi_sample_ack => outputPort_1_Daemon_CP_356_elements(98), 
          phi_update_req => outputPort_1_Daemon_CP_356_elements(14), 
          phi_update_ack => outputPort_1_Daemon_CP_356_elements(99), 
          phi_mux_ack => outputPort_1_Daemon_CP_356_elements(104), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_312_phi_seq_650_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_1_Daemon_CP_356_elements(121);
      outputPort_1_Daemon_CP_356_elements(124)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_1_Daemon_CP_356_elements(124);
      outputPort_1_Daemon_CP_356_elements(125)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_1_Daemon_CP_356_elements(126);
      outputPort_1_Daemon_CP_356_elements(122) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_1_Daemon_CP_356_elements(119);
      outputPort_1_Daemon_CP_356_elements(128)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_1_Daemon_CP_356_elements(130);
      outputPort_1_Daemon_CP_356_elements(129)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_1_Daemon_CP_356_elements(131);
      outputPort_1_Daemon_CP_356_elements(120) <= phi_mux_reqs(1);
      phi_stmt_312_phi_seq_650 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_312_phi_seq_650") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_1_Daemon_CP_356_elements(115), 
          phi_sample_ack => outputPort_1_Daemon_CP_356_elements(116), 
          phi_update_req => outputPort_1_Daemon_CP_356_elements(117), 
          phi_update_ack => outputPort_1_Daemon_CP_356_elements(118), 
          phi_mux_ack => outputPort_1_Daemon_CP_356_elements(123), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    entry_tmerge_381_block : block -- 
      signal preds : BooleanArray(0 to 1);
      begin -- 
        preds(0)  <= outputPort_1_Daemon_CP_356_elements(7);
        preds(1)  <= outputPort_1_Daemon_CP_356_elements(8);
        entry_tmerge_381 : transition_merge -- 
          generic map(name => " entry_tmerge_381")
          port map (preds => preds, symbol_out => outputPort_1_Daemon_CP_356_elements(9));
          -- 
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal EQ_u2_u1_338_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_344_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_371_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_398_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_406_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_412_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_422_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_428_wire : std_logic_vector(0 downto 0);
    signal EQ_u8_u1_364_wire : std_logic_vector(0 downto 0);
    signal MUX_341_wire : std_logic_vector(0 downto 0);
    signal MUX_347_wire : std_logic_vector(0 downto 0);
    signal MUX_376_wire : std_logic_vector(7 downto 0);
    signal MUX_390_wire : std_logic_vector(7 downto 0);
    signal MUX_425_wire : std_logic_vector(0 downto 0);
    signal MUX_431_wire : std_logic_vector(0 downto 0);
    signal NEQ_u2_u1_361_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_395_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_403_wire : std_logic_vector(0 downto 0);
    signal RPIPE_noblock_obuf_1_1_298_wire : std_logic_vector(32 downto 0);
    signal RPIPE_noblock_obuf_2_1_303_wire : std_logic_vector(32 downto 0);
    signal R_ZERO_1_314_wire_constant : std_logic_vector(0 downto 0);
    signal R_ZERO_2_306_wire_constant : std_logic_vector(1 downto 0);
    signal R_ZERO_33_296_wire_constant : std_logic_vector(32 downto 0);
    signal R_ZERO_33_301_wire_constant : std_logic_vector(32 downto 0);
    signal R_ZERO_8_292_wire_constant : std_logic_vector(7 downto 0);
    signal R_ZERO_8_310_wire_constant : std_logic_vector(7 downto 0);
    signal SUB_u8_u8_384_wire : std_logic_vector(7 downto 0);
    signal SUB_u8_u8_388_wire : std_logic_vector(7 downto 0);
    signal active_packet_304 : std_logic_vector(1 downto 0);
    signal active_packet_length_308 : std_logic_vector(7 downto 0);
    signal data_to_out_418 : std_logic_vector(31 downto 0);
    signal down_counter_290 : std_logic_vector(7 downto 0);
    signal konst_319_wire_constant : std_logic_vector(32 downto 0);
    signal konst_324_wire_constant : std_logic_vector(32 downto 0);
    signal konst_337_wire_constant : std_logic_vector(1 downto 0);
    signal konst_340_wire_constant : std_logic_vector(0 downto 0);
    signal konst_343_wire_constant : std_logic_vector(1 downto 0);
    signal konst_346_wire_constant : std_logic_vector(0 downto 0);
    signal konst_360_wire_constant : std_logic_vector(1 downto 0);
    signal konst_363_wire_constant : std_logic_vector(7 downto 0);
    signal konst_370_wire_constant : std_logic_vector(1 downto 0);
    signal konst_383_wire_constant : std_logic_vector(7 downto 0);
    signal konst_387_wire_constant : std_logic_vector(7 downto 0);
    signal konst_397_wire_constant : std_logic_vector(1 downto 0);
    signal konst_405_wire_constant : std_logic_vector(1 downto 0);
    signal konst_411_wire_constant : std_logic_vector(1 downto 0);
    signal konst_421_wire_constant : std_logic_vector(1 downto 0);
    signal konst_424_wire_constant : std_logic_vector(0 downto 0);
    signal konst_427_wire_constant : std_logic_vector(1 downto 0);
    signal konst_430_wire_constant : std_logic_vector(0 downto 0);
    signal konst_446_wire_constant : std_logic_vector(0 downto 0);
    signal next_active_packet_357 : std_logic_vector(1 downto 0);
    signal next_active_packet_357_307_buffered : std_logic_vector(1 downto 0);
    signal next_active_packet_length_379 : std_logic_vector(7 downto 0);
    signal next_active_packet_length_379_311_buffered : std_logic_vector(7 downto 0);
    signal next_down_counter_392 : std_logic_vector(7 downto 0);
    signal next_down_counter_392_293_buffered : std_logic_vector(7 downto 0);
    signal next_pkt_1_has_priority_357 : std_logic_vector(0 downto 0);
    signal next_pkt_1_has_priority_357_315_buffered : std_logic_vector(0 downto 0);
    signal p1_valid_321 : std_logic_vector(0 downto 0);
    signal p2_valid_326 : std_logic_vector(0 downto 0);
    signal pkt_1_e_word_294 : std_logic_vector(32 downto 0);
    signal pkt_1_has_priority_312 : std_logic_vector(0 downto 0);
    signal pkt_2_e_word_299 : std_logic_vector(32 downto 0);
    signal read_from_1_400 : std_logic_vector(0 downto 0);
    signal read_from_2_408 : std_logic_vector(0 downto 0);
    signal send_flag_433 : std_logic_vector(0 downto 0);
    signal slice_373_wire : std_logic_vector(7 downto 0);
    signal slice_375_wire : std_logic_vector(7 downto 0);
    signal slice_414_wire : std_logic_vector(31 downto 0);
    signal slice_416_wire : std_logic_vector(31 downto 0);
    signal started_new_packet_366 : std_logic_vector(0 downto 0);
    signal valid_active_pkt_word_read_349 : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    R_ZERO_1_314_wire_constant <= "0";
    R_ZERO_2_306_wire_constant <= "00";
    R_ZERO_33_296_wire_constant <= "000000000000000000000000000000000";
    R_ZERO_33_301_wire_constant <= "000000000000000000000000000000000";
    R_ZERO_8_292_wire_constant <= "00000000";
    R_ZERO_8_310_wire_constant <= "00000000";
    konst_319_wire_constant <= "000000000000000000000000000100000";
    konst_324_wire_constant <= "000000000000000000000000000100000";
    konst_337_wire_constant <= "01";
    konst_340_wire_constant <= "0";
    konst_343_wire_constant <= "10";
    konst_346_wire_constant <= "0";
    konst_360_wire_constant <= "00";
    konst_363_wire_constant <= "00000000";
    konst_370_wire_constant <= "01";
    konst_383_wire_constant <= "00000001";
    konst_387_wire_constant <= "00000001";
    konst_397_wire_constant <= "01";
    konst_405_wire_constant <= "10";
    konst_411_wire_constant <= "01";
    konst_421_wire_constant <= "01";
    konst_424_wire_constant <= "0";
    konst_427_wire_constant <= "10";
    konst_430_wire_constant <= "0";
    konst_446_wire_constant <= "1";
    phi_stmt_290: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_8_292_wire_constant & next_down_counter_392_293_buffered;
      req <= phi_stmt_290_req_0 & phi_stmt_290_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_290",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_290_ack_0,
          idata => idata,
          odata => down_counter_290,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_290
    phi_stmt_294: Block -- phi operator 
      signal idata: std_logic_vector(65 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_33_296_wire_constant & RPIPE_noblock_obuf_1_1_298_wire;
      req <= phi_stmt_294_req_0 & phi_stmt_294_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_294",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 33) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_294_ack_0,
          idata => idata,
          odata => pkt_1_e_word_294,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_294
    phi_stmt_299: Block -- phi operator 
      signal idata: std_logic_vector(65 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_33_301_wire_constant & RPIPE_noblock_obuf_2_1_303_wire;
      req <= phi_stmt_299_req_0 & phi_stmt_299_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_299",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 33) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_299_ack_0,
          idata => idata,
          odata => pkt_2_e_word_299,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_299
    phi_stmt_304: Block -- phi operator 
      signal idata: std_logic_vector(3 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_2_306_wire_constant & next_active_packet_357_307_buffered;
      req <= phi_stmt_304_req_0 & phi_stmt_304_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_304",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 2) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_304_ack_0,
          idata => idata,
          odata => active_packet_304,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_304
    phi_stmt_308: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_8_310_wire_constant & next_active_packet_length_379_311_buffered;
      req <= phi_stmt_308_req_0 & phi_stmt_308_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_308",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_308_ack_0,
          idata => idata,
          odata => active_packet_length_308,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_308
    phi_stmt_312: Block -- phi operator 
      signal idata: std_logic_vector(1 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_1_314_wire_constant & next_pkt_1_has_priority_357_315_buffered;
      req <= phi_stmt_312_req_0 & phi_stmt_312_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_312",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 1) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_312_ack_0,
          idata => idata,
          odata => pkt_1_has_priority_312,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_312
    -- flow-through select operator MUX_341_inst
    MUX_341_wire <= p1_valid_321 when (EQ_u2_u1_338_wire(0) /=  '0') else konst_340_wire_constant;
    -- flow-through select operator MUX_347_inst
    MUX_347_wire <= p2_valid_326 when (EQ_u2_u1_344_wire(0) /=  '0') else konst_346_wire_constant;
    -- flow-through select operator MUX_376_inst
    MUX_376_wire <= slice_373_wire when (EQ_u2_u1_371_wire(0) /=  '0') else slice_375_wire;
    -- flow-through select operator MUX_378_inst
    next_active_packet_length_379 <= MUX_376_wire when (started_new_packet_366(0) /=  '0') else active_packet_length_308;
    -- flow-through select operator MUX_390_inst
    MUX_390_wire <= SUB_u8_u8_388_wire when (valid_active_pkt_word_read_349(0) /=  '0') else down_counter_290;
    -- flow-through select operator MUX_391_inst
    next_down_counter_392 <= SUB_u8_u8_384_wire when (started_new_packet_366(0) /=  '0') else MUX_390_wire;
    -- flow-through select operator MUX_417_inst
    data_to_out_418 <= slice_414_wire when (EQ_u2_u1_412_wire(0) /=  '0') else slice_416_wire;
    -- flow-through select operator MUX_425_inst
    MUX_425_wire <= p1_valid_321 when (EQ_u2_u1_422_wire(0) /=  '0') else konst_424_wire_constant;
    -- flow-through select operator MUX_431_inst
    MUX_431_wire <= p2_valid_326 when (EQ_u2_u1_428_wire(0) /=  '0') else konst_430_wire_constant;
    -- flow-through slice operator slice_373_inst
    slice_373_wire <= pkt_1_e_word_294(15 downto 8);
    -- flow-through slice operator slice_375_inst
    slice_375_wire <= pkt_2_e_word_299(15 downto 8);
    -- flow-through slice operator slice_414_inst
    slice_414_wire <= pkt_1_e_word_294(31 downto 0);
    -- flow-through slice operator slice_416_inst
    slice_416_wire <= pkt_2_e_word_299(31 downto 0);
    next_active_packet_357_307_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_active_packet_357_307_buf_req_0;
      next_active_packet_357_307_buf_ack_0<= wack(0);
      rreq(0) <= next_active_packet_357_307_buf_req_1;
      next_active_packet_357_307_buf_ack_1<= rack(0);
      next_active_packet_357_307_buf : InterlockBuffer generic map ( -- 
        name => "next_active_packet_357_307_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 2,
        out_data_width => 2,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_active_packet_357,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_active_packet_357_307_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_active_packet_length_379_311_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_active_packet_length_379_311_buf_req_0;
      next_active_packet_length_379_311_buf_ack_0<= wack(0);
      rreq(0) <= next_active_packet_length_379_311_buf_req_1;
      next_active_packet_length_379_311_buf_ack_1<= rack(0);
      next_active_packet_length_379_311_buf : InterlockBuffer generic map ( -- 
        name => "next_active_packet_length_379_311_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_active_packet_length_379,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_active_packet_length_379_311_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_down_counter_392_293_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_down_counter_392_293_buf_req_0;
      next_down_counter_392_293_buf_ack_0<= wack(0);
      rreq(0) <= next_down_counter_392_293_buf_req_1;
      next_down_counter_392_293_buf_ack_1<= rack(0);
      next_down_counter_392_293_buf : InterlockBuffer generic map ( -- 
        name => "next_down_counter_392_293_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_down_counter_392,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_down_counter_392_293_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_pkt_1_has_priority_357_315_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_pkt_1_has_priority_357_315_buf_req_0;
      next_pkt_1_has_priority_357_315_buf_ack_0<= wack(0);
      rreq(0) <= next_pkt_1_has_priority_357_315_buf_req_1;
      next_pkt_1_has_priority_357_315_buf_ack_1<= rack(0);
      next_pkt_1_has_priority_357_315_buf : InterlockBuffer generic map ( -- 
        name => "next_pkt_1_has_priority_357_315_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 1,
        out_data_width => 1,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_pkt_1_has_priority_357,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_pkt_1_has_priority_357_315_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    do_while_stmt_288_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= konst_446_wire_constant;
      branch_instance: BranchBase -- 
        generic map( name => "do_while_stmt_288_branch", condition_width => 1,  bypass_flag => true)
        port map( -- 
          condition => condition_sig,
          req => do_while_stmt_288_branch_req_0,
          ack0 => do_while_stmt_288_branch_ack_0,
          ack1 => do_while_stmt_288_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- flow through binary operator AND_u1_u1_365_inst
    started_new_packet_366 <= (NEQ_u2_u1_361_wire and EQ_u8_u1_364_wire);
    -- flow through binary operator BITSEL_u33_u1_320_inst
    process(pkt_1_e_word_294) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApBitsel_proc(pkt_1_e_word_294, konst_319_wire_constant, tmp_var);
      p1_valid_321 <= tmp_var; --
    end process;
    -- flow through binary operator BITSEL_u33_u1_325_inst
    process(pkt_2_e_word_299) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApBitsel_proc(pkt_2_e_word_299, konst_324_wire_constant, tmp_var);
      p2_valid_326 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_338_inst
    process(active_packet_304) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(active_packet_304, konst_337_wire_constant, tmp_var);
      EQ_u2_u1_338_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_344_inst
    process(active_packet_304) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(active_packet_304, konst_343_wire_constant, tmp_var);
      EQ_u2_u1_344_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_371_inst
    process(next_active_packet_357) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_357, konst_370_wire_constant, tmp_var);
      EQ_u2_u1_371_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_398_inst
    process(next_active_packet_357) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_357, konst_397_wire_constant, tmp_var);
      EQ_u2_u1_398_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_406_inst
    process(next_active_packet_357) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_357, konst_405_wire_constant, tmp_var);
      EQ_u2_u1_406_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_412_inst
    process(next_active_packet_357) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_357, konst_411_wire_constant, tmp_var);
      EQ_u2_u1_412_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_422_inst
    process(next_active_packet_357) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_357, konst_421_wire_constant, tmp_var);
      EQ_u2_u1_422_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_428_inst
    process(next_active_packet_357) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_357, konst_427_wire_constant, tmp_var);
      EQ_u2_u1_428_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_364_inst
    process(down_counter_290) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(down_counter_290, konst_363_wire_constant, tmp_var);
      EQ_u8_u1_364_wire <= tmp_var; --
    end process;
    -- flow through binary operator NEQ_u2_u1_361_inst
    process(next_active_packet_357) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntNe_proc(next_active_packet_357, konst_360_wire_constant, tmp_var);
      NEQ_u2_u1_361_wire <= tmp_var; --
    end process;
    -- unary operator NOT_u1_u1_395_inst
    process(p1_valid_321) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p1_valid_321, tmp_var);
      NOT_u1_u1_395_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_403_inst
    process(p2_valid_326) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p2_valid_326, tmp_var);
      NOT_u1_u1_403_wire <= tmp_var; -- 
    end process;
    -- flow through binary operator OR_u1_u1_348_inst
    valid_active_pkt_word_read_349 <= (MUX_341_wire or MUX_347_wire);
    -- flow through binary operator OR_u1_u1_399_inst
    read_from_1_400 <= (NOT_u1_u1_395_wire or EQ_u2_u1_398_wire);
    -- flow through binary operator OR_u1_u1_407_inst
    read_from_2_408 <= (NOT_u1_u1_403_wire or EQ_u2_u1_406_wire);
    -- flow through binary operator OR_u1_u1_432_inst
    send_flag_433 <= (MUX_425_wire or MUX_431_wire);
    -- flow through binary operator SUB_u8_u8_384_inst
    SUB_u8_u8_384_wire <= std_logic_vector(unsigned(next_active_packet_length_379) - unsigned(konst_383_wire_constant));
    -- flow through binary operator SUB_u8_u8_388_inst
    SUB_u8_u8_388_wire <= std_logic_vector(unsigned(down_counter_290) - unsigned(konst_387_wire_constant));
    -- shared inport operator group (0) : RPIPE_noblock_obuf_1_1_298_inst 
    InportGroup_0: Block -- 
      signal data_out: std_logic_vector(32 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_noblock_obuf_1_1_298_inst_req_0;
      RPIPE_noblock_obuf_1_1_298_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_noblock_obuf_1_1_298_inst_req_1;
      RPIPE_noblock_obuf_1_1_298_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <= read_from_1_400(0);
      RPIPE_noblock_obuf_1_1_298_wire <= data_out(32 downto 0);
      noblock_obuf_1_1_read_0_gI: SplitGuardInterface generic map(name => "noblock_obuf_1_1_read_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_1_1_read_0: InputPortRevised -- 
        generic map ( name => "noblock_obuf_1_1_read_0", data_width => 33,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => true,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => noblock_obuf_1_1_pipe_read_req(0),
          oack => noblock_obuf_1_1_pipe_read_ack(0),
          odata => noblock_obuf_1_1_pipe_read_data(32 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared inport operator group (1) : RPIPE_noblock_obuf_2_1_303_inst 
    InportGroup_1: Block -- 
      signal data_out: std_logic_vector(32 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_noblock_obuf_2_1_303_inst_req_0;
      RPIPE_noblock_obuf_2_1_303_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_noblock_obuf_2_1_303_inst_req_1;
      RPIPE_noblock_obuf_2_1_303_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <= read_from_2_408(0);
      RPIPE_noblock_obuf_2_1_303_wire <= data_out(32 downto 0);
      noblock_obuf_2_1_read_1_gI: SplitGuardInterface generic map(name => "noblock_obuf_2_1_read_1_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_2_1_read_1: InputPortRevised -- 
        generic map ( name => "noblock_obuf_2_1_read_1", data_width => 33,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => true,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => noblock_obuf_2_1_pipe_read_req(0),
          oack => noblock_obuf_2_1_pipe_read_ack(0),
          odata => noblock_obuf_2_1_pipe_read_data(32 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 1
    -- shared outport operator group (0) : WPIPE_out_data_1_435_inst 
    OutportGroup_0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_out_data_1_435_inst_req_0;
      WPIPE_out_data_1_435_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_out_data_1_435_inst_req_1;
      WPIPE_out_data_1_435_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_flag_433(0);
      data_in <= data_to_out_418;
      out_data_1_write_0_gI: SplitGuardInterface generic map(name => "out_data_1_write_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      out_data_1_write_0: OutputPortRevised -- 
        generic map ( name => "out_data_1", data_width => 32, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => out_data_1_pipe_write_req(0),
          oack => out_data_1_pipe_write_ack(0),
          odata => out_data_1_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    volatile_operator_prioritySelect_999: prioritySelect_Volatile port map(down_counter => down_counter_290, active_packet => active_packet_304, pkt_1_has_priority => pkt_1_has_priority_312, p1_valid => p1_valid_321, p2_valid => p2_valid_326, next_active_packet => next_active_packet_357, next_pkt_1_has_priority => next_pkt_1_has_priority_357); 
    -- 
  end Block; -- data_path
  -- 
end outputPort_1_Daemon_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.switch_2x2_global_package.all;
entity outputPort_2_Daemon is -- 
  generic (tag_length : integer); 
  port ( -- 
    noblock_obuf_1_2_pipe_read_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_1_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_1_2_pipe_read_data : in   std_logic_vector(32 downto 0);
    noblock_obuf_2_2_pipe_read_req : out  std_logic_vector(0 downto 0);
    noblock_obuf_2_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
    noblock_obuf_2_2_pipe_read_data : in   std_logic_vector(32 downto 0);
    out_data_2_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_data_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_data_2_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) ;
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic-- 
  );
  -- 
end entity outputPort_2_Daemon;
architecture outputPort_2_Daemon_arch of outputPort_2_Daemon is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal default_zero_sig: std_logic;
  signal in_buffer_write_req: std_logic;
  signal in_buffer_write_ack: std_logic;
  signal in_buffer_unload_req_symbol: Boolean;
  signal in_buffer_unload_ack_symbol: Boolean;
  signal out_buffer_data_in, out_buffer_data_out: std_logic_vector((tag_length + 0)-1 downto 0);
  signal out_buffer_read_req: std_logic;
  signal out_buffer_read_ack: std_logic;
  signal out_buffer_write_req_symbol: Boolean;
  signal out_buffer_write_ack_symbol: Boolean;
  signal tag_ub_out, tag_ilock_out: std_logic_vector(tag_length-1 downto 0);
  signal tag_push_req, tag_push_ack, tag_pop_req, tag_pop_ack: std_logic;
  signal tag_unload_req_symbol, tag_unload_ack_symbol, tag_write_req_symbol, tag_write_ack_symbol: Boolean;
  signal tag_ilock_write_req_symbol, tag_ilock_write_ack_symbol, tag_ilock_read_req_symbol, tag_ilock_read_ack_symbol: Boolean;
  signal start_req_sig, fin_req_sig, start_ack_sig, fin_ack_sig: std_logic; 
  signal input_sample_reenable_symbol: Boolean;
  -- input port buffer signals
  -- output port buffer signals
  signal outputPort_2_Daemon_CP_675_start: Boolean;
  signal outputPort_2_Daemon_CP_675_symbol: Boolean;
  -- volatile/operator module components. 
  component prioritySelect_Volatile is -- 
    port ( -- 
      down_counter : in  std_logic_vector(7 downto 0);
      active_packet : in  std_logic_vector(1 downto 0);
      pkt_1_has_priority : in  std_logic_vector(0 downto 0);
      p1_valid : in  std_logic_vector(0 downto 0);
      p2_valid : in  std_logic_vector(0 downto 0);
      next_active_packet : out  std_logic_vector(1 downto 0);
      next_pkt_1_has_priority : out  std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component; 
  -- links between control-path and data-path
  signal next_pkt_1_has_priority_520_478_buf_ack_0 : boolean;
  signal RPIPE_noblock_obuf_1_2_461_inst_ack_0 : boolean;
  signal next_active_packet_520_470_buf_req_0 : boolean;
  signal phi_stmt_471_req_0 : boolean;
  signal RPIPE_noblock_obuf_1_2_461_inst_ack_1 : boolean;
  signal RPIPE_noblock_obuf_1_2_461_inst_req_0 : boolean;
  signal next_pkt_1_has_priority_520_478_buf_req_0 : boolean;
  signal next_active_packet_520_470_buf_ack_0 : boolean;
  signal RPIPE_noblock_obuf_2_2_466_inst_ack_1 : boolean;
  signal next_pkt_1_has_priority_520_478_buf_ack_1 : boolean;
  signal phi_stmt_471_req_1 : boolean;
  signal next_active_packet_length_542_474_buf_ack_0 : boolean;
  signal next_active_packet_length_542_474_buf_req_0 : boolean;
  signal next_active_packet_520_470_buf_ack_1 : boolean;
  signal RPIPE_noblock_obuf_2_2_466_inst_req_1 : boolean;
  signal phi_stmt_475_req_1 : boolean;
  signal next_active_packet_length_542_474_buf_req_1 : boolean;
  signal WPIPE_out_data_2_598_inst_req_0 : boolean;
  signal RPIPE_noblock_obuf_2_2_466_inst_ack_0 : boolean;
  signal RPIPE_noblock_obuf_2_2_466_inst_req_0 : boolean;
  signal next_pkt_1_has_priority_520_478_buf_req_1 : boolean;
  signal phi_stmt_467_req_1 : boolean;
  signal phi_stmt_467_req_0 : boolean;
  signal phi_stmt_475_req_0 : boolean;
  signal RPIPE_noblock_obuf_1_2_461_inst_req_1 : boolean;
  signal phi_stmt_462_req_0 : boolean;
  signal phi_stmt_462_ack_0 : boolean;
  signal next_active_packet_length_542_474_buf_ack_1 : boolean;
  signal phi_stmt_471_ack_0 : boolean;
  signal WPIPE_out_data_2_598_inst_req_1 : boolean;
  signal WPIPE_out_data_2_598_inst_ack_1 : boolean;
  signal phi_stmt_462_req_1 : boolean;
  signal next_active_packet_520_470_buf_req_1 : boolean;
  signal phi_stmt_467_ack_0 : boolean;
  signal phi_stmt_475_ack_0 : boolean;
  signal do_while_stmt_451_branch_ack_0 : boolean;
  signal do_while_stmt_451_branch_ack_1 : boolean;
  signal WPIPE_out_data_2_598_inst_ack_0 : boolean;
  signal do_while_stmt_451_branch_req_0 : boolean;
  signal phi_stmt_453_req_1 : boolean;
  signal phi_stmt_453_req_0 : boolean;
  signal phi_stmt_453_ack_0 : boolean;
  signal next_down_counter_555_456_buf_req_0 : boolean;
  signal next_down_counter_555_456_buf_ack_0 : boolean;
  signal next_down_counter_555_456_buf_req_1 : boolean;
  signal next_down_counter_555_456_buf_ack_1 : boolean;
  signal phi_stmt_457_req_1 : boolean;
  signal phi_stmt_457_req_0 : boolean;
  signal phi_stmt_457_ack_0 : boolean;
  -- 
begin --  
  -- input handling ------------------------------------------------
  in_buffer: UnloadBuffer -- 
    generic map(name => "outputPort_2_Daemon_input_buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      data_width => tag_length + 0) -- 
    port map(write_req => in_buffer_write_req, -- 
      write_ack => in_buffer_write_ack, 
      write_data => in_buffer_data_in,
      unload_req => in_buffer_unload_req_symbol, 
      unload_ack => in_buffer_unload_ack_symbol, 
      read_data => in_buffer_data_out,
      clk => clk, reset => reset); -- 
  in_buffer_data_in(tag_length-1 downto 0) <= tag_in;
  tag_ub_out <= in_buffer_data_out(tag_length-1 downto 0);
  in_buffer_write_req <= start_req;
  start_ack <= in_buffer_write_ack;
  in_buffer_unload_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 1,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 32) := "in_buffer_unload_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= in_buffer_unload_ack_symbol & input_sample_reenable_symbol;
    gj_in_buffer_unload_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => in_buffer_unload_req_symbol, clk => clk, reset => reset); --
  end block;
  -- join of all unload_ack_symbols.. used to trigger CP.
  outputPort_2_Daemon_CP_675_start <= in_buffer_unload_ack_symbol;
  -- output handling  -------------------------------------------------------
  out_buffer: ReceiveBuffer -- 
    generic map(name => "outputPort_2_Daemon_out_buffer", -- 
      buffer_size => 1,
      full_rate => false,
      data_width => tag_length + 0) --
    port map(write_req => out_buffer_write_req_symbol, -- 
      write_ack => out_buffer_write_ack_symbol, 
      write_data => out_buffer_data_in,
      read_req => out_buffer_read_req, 
      read_ack => out_buffer_read_ack, 
      read_data => out_buffer_data_out,
      clk => clk, reset => reset); -- 
  out_buffer_data_in(tag_length-1 downto 0) <= tag_ilock_out;
  tag_out <= out_buffer_data_out(tag_length-1 downto 0);
  out_buffer_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 0);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 1,2 => 0);
    constant joinName: string(1 to 32) := "out_buffer_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= outputPort_2_Daemon_CP_675_symbol & out_buffer_write_ack_symbol & tag_ilock_read_ack_symbol;
    gj_out_buffer_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => out_buffer_write_req_symbol, clk => clk, reset => reset); --
  end block;
  -- write-to output-buffer produces  reenable input sampling
  input_sample_reenable_symbol <= out_buffer_write_ack_symbol;
  -- fin-req/ack level protocol..
  out_buffer_read_req <= fin_req;
  fin_ack <= out_buffer_read_ack;
  ----- tag-queue --------------------------------------------------
  -- interlock buffer for TAG.. to provide required buffering.
  tagIlock: InterlockBuffer -- 
    generic map(name => "tag-interlock-buffer", -- 
      buffer_size => 1,
      bypass_flag => false,
      in_data_width => tag_length,
      out_data_width => tag_length) -- 
    port map(write_req => tag_ilock_write_req_symbol, -- 
      write_ack => tag_ilock_write_ack_symbol, 
      write_data => tag_ub_out,
      read_req => tag_ilock_read_req_symbol, 
      read_ack => tag_ilock_read_ack_symbol, 
      read_data => tag_ilock_out, 
      clk => clk, reset => reset); -- 
  -- tag ilock-buffer control logic. 
  tag_ilock_write_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 1) := (0 => 1,1 => 1);
    constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
    constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
    constant joinName: string(1 to 31) := "tag_ilock_write_req_symbol_join"; 
    signal preds: BooleanArray(1 to 2); -- 
  begin -- 
    preds <= outputPort_2_Daemon_CP_675_start & tag_ilock_write_ack_symbol;
    gj_tag_ilock_write_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_write_req_symbol, clk => clk, reset => reset); --
  end block;
  tag_ilock_read_req_symbol_join: block -- 
    constant place_capacities: IntegerArray(0 to 2) := (0 => 1,1 => 1,2 => 1);
    constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 1,2 => 1);
    constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
    constant joinName: string(1 to 30) := "tag_ilock_read_req_symbol_join"; 
    signal preds: BooleanArray(1 to 3); -- 
  begin -- 
    preds <= outputPort_2_Daemon_CP_675_start & tag_ilock_read_ack_symbol & out_buffer_write_ack_symbol;
    gj_tag_ilock_read_req_symbol_join : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
      port map(preds => preds, symbol_out => tag_ilock_read_req_symbol, clk => clk, reset => reset); --
  end block;
  -- the control path --------------------------------------------------
  always_true_symbol <= true; 
  default_zero_sig <= '0';
  outputPort_2_Daemon_CP_675: Block -- control-path 
    signal outputPort_2_Daemon_CP_675_elements: BooleanArray(139 downto 0);
    -- 
  begin -- 
    outputPort_2_Daemon_CP_675_elements(0) <= outputPort_2_Daemon_CP_675_start;
    outputPort_2_Daemon_CP_675_symbol <= outputPort_2_Daemon_CP_675_elements(1);
    -- CP-element group 0:  transition  place  bypass 
    -- CP-element group 0: predecessors 
    -- CP-element group 0: successors 
    -- CP-element group 0: 	2 
    -- CP-element group 0:  members (4) 
      -- CP-element group 0: 	 $entry
      -- CP-element group 0: 	 branch_block_stmt_450/$entry
      -- CP-element group 0: 	 branch_block_stmt_450/branch_block_stmt_450__entry__
      -- CP-element group 0: 	 branch_block_stmt_450/do_while_stmt_451__entry__
      -- 
    -- CP-element group 1:  transition  place  bypass 
    -- CP-element group 1: predecessors 
    -- CP-element group 1: 	139 
    -- CP-element group 1: successors 
    -- CP-element group 1:  members (4) 
      -- CP-element group 1: 	 $exit
      -- CP-element group 1: 	 branch_block_stmt_450/$exit
      -- CP-element group 1: 	 branch_block_stmt_450/branch_block_stmt_450__exit__
      -- CP-element group 1: 	 branch_block_stmt_450/do_while_stmt_451__exit__
      -- 
    outputPort_2_Daemon_CP_675_elements(1) <= outputPort_2_Daemon_CP_675_elements(139);
    -- CP-element group 2:  transition  place  bypass  pipeline-parent 
    -- CP-element group 2: predecessors 
    -- CP-element group 2: 	0 
    -- CP-element group 2: successors 
    -- CP-element group 2: 	8 
    -- CP-element group 2:  members (2) 
      -- CP-element group 2: 	 branch_block_stmt_450/do_while_stmt_451/$entry
      -- CP-element group 2: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451__entry__
      -- 
    outputPort_2_Daemon_CP_675_elements(2) <= outputPort_2_Daemon_CP_675_elements(0);
    -- CP-element group 3:  merge  place  bypass  pipeline-parent 
    -- CP-element group 3: predecessors 
    -- CP-element group 3: successors 
    -- CP-element group 3: 	139 
    -- CP-element group 3:  members (1) 
      -- CP-element group 3: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451__exit__
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(3) is bound as output of CP function.
    -- CP-element group 4:  merge  place  bypass  pipeline-parent 
    -- CP-element group 4: predecessors 
    -- CP-element group 4: successors 
    -- CP-element group 4: 	7 
    -- CP-element group 4:  members (1) 
      -- CP-element group 4: 	 branch_block_stmt_450/do_while_stmt_451/loop_back
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(4) is bound as output of CP function.
    -- CP-element group 5:  branch  transition  place  bypass  pipeline-parent 
    -- CP-element group 5: predecessors 
    -- CP-element group 5: 	10 
    -- CP-element group 5: successors 
    -- CP-element group 5: 	138 
    -- CP-element group 5: 	137 
    -- CP-element group 5:  members (3) 
      -- CP-element group 5: 	 branch_block_stmt_450/do_while_stmt_451/loop_taken/$entry
      -- CP-element group 5: 	 branch_block_stmt_450/do_while_stmt_451/loop_exit/$entry
      -- CP-element group 5: 	 branch_block_stmt_450/do_while_stmt_451/condition_done
      -- 
    outputPort_2_Daemon_CP_675_elements(5) <= outputPort_2_Daemon_CP_675_elements(10);
    -- CP-element group 6:  branch  place  bypass  pipeline-parent 
    -- CP-element group 6: predecessors 
    -- CP-element group 6: 	136 
    -- CP-element group 6: successors 
    -- CP-element group 6:  members (1) 
      -- CP-element group 6: 	 branch_block_stmt_450/do_while_stmt_451/loop_body_done
      -- 
    outputPort_2_Daemon_CP_675_elements(6) <= outputPort_2_Daemon_CP_675_elements(136);
    -- CP-element group 7:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 7: predecessors 
    -- CP-element group 7: 	4 
    -- CP-element group 7: successors 
    -- CP-element group 7: 	101 
    -- CP-element group 7: 	119 
    -- CP-element group 7: 	22 
    -- CP-element group 7: 	41 
    -- CP-element group 7: 	62 
    -- CP-element group 7: 	83 
    -- CP-element group 7:  members (1) 
      -- CP-element group 7: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/back_edge_to_loop_body
      -- 
    outputPort_2_Daemon_CP_675_elements(7) <= outputPort_2_Daemon_CP_675_elements(4);
    -- CP-element group 8:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 8: predecessors 
    -- CP-element group 8: 	2 
    -- CP-element group 8: successors 
    -- CP-element group 8: 	103 
    -- CP-element group 8: 	121 
    -- CP-element group 8: 	24 
    -- CP-element group 8: 	43 
    -- CP-element group 8: 	64 
    -- CP-element group 8: 	85 
    -- CP-element group 8:  members (1) 
      -- CP-element group 8: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/first_time_through_loop_body
      -- 
    outputPort_2_Daemon_CP_675_elements(8) <= outputPort_2_Daemon_CP_675_elements(2);
    -- CP-element group 9:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 9: predecessors 
    -- CP-element group 9: successors 
    -- CP-element group 9: 	115 
    -- CP-element group 9: 	114 
    -- CP-element group 9: 	135 
    -- CP-element group 9: 	16 
    -- CP-element group 9: 	17 
    -- CP-element group 9: 	96 
    -- CP-element group 9: 	97 
    -- CP-element group 9: 	35 
    -- CP-element group 9: 	36 
    -- CP-element group 9: 	56 
    -- CP-element group 9: 	57 
    -- CP-element group 9: 	77 
    -- CP-element group 9: 	78 
    -- CP-element group 9:  members (2) 
      -- CP-element group 9: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/$entry
      -- CP-element group 9: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/loop_body_start
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(9) is bound as output of CP function.
    -- CP-element group 10:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 10: predecessors 
    -- CP-element group 10: 	135 
    -- CP-element group 10: 	13 
    -- CP-element group 10: 	15 
    -- CP-element group 10: successors 
    -- CP-element group 10: 	5 
    -- CP-element group 10:  members (1) 
      -- CP-element group 10: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/condition_evaluated
      -- 
    condition_evaluated_699_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " condition_evaluated_699_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(10), ack => do_while_stmt_451_branch_req_0); -- 
    outputPort_2_Daemon_cp_element_group_10: block -- 
      constant place_capacities: IntegerArray(0 to 2) := (0 => 7,1 => 7,2 => 7);
      constant place_markings: IntegerArray(0 to 2)  := (0 => 0,1 => 0,2 => 0);
      constant place_delays: IntegerArray(0 to 2) := (0 => 0,1 => 0,2 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_10"; 
      signal preds: BooleanArray(1 to 3); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(135) & outputPort_2_Daemon_CP_675_elements(13) & outputPort_2_Daemon_CP_675_elements(15);
      gj_outputPort_2_Daemon_cp_element_group_10 : generic_join generic map(name => joinName, number_of_predecessors => 3, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(10), clk => clk, reset => reset); --
    end block;
    -- CP-element group 11:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 11: predecessors 
    -- CP-element group 11: 	114 
    -- CP-element group 11: 	16 
    -- CP-element group 11: 	96 
    -- CP-element group 11: 	35 
    -- CP-element group 11: 	56 
    -- CP-element group 11: 	77 
    -- CP-element group 11: marked-predecessors 
    -- CP-element group 11: 	15 
    -- CP-element group 11: successors 
    -- CP-element group 11: 	18 
    -- CP-element group 11: 	98 
    -- CP-element group 11: 	37 
    -- CP-element group 11: 	58 
    -- CP-element group 11: 	79 
    -- CP-element group 11:  members (2) 
      -- CP-element group 11: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_sample_start__ps
      -- CP-element group 11: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/aggregated_phi_sample_req
      -- 
    outputPort_2_Daemon_cp_element_group_11: block -- 
      constant place_capacities: IntegerArray(0 to 6) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1,6 => 1);
      constant place_markings: IntegerArray(0 to 6)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0,6 => 1);
      constant place_delays: IntegerArray(0 to 6) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0,6 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_11"; 
      signal preds: BooleanArray(1 to 7); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(114) & outputPort_2_Daemon_CP_675_elements(16) & outputPort_2_Daemon_CP_675_elements(96) & outputPort_2_Daemon_CP_675_elements(35) & outputPort_2_Daemon_CP_675_elements(56) & outputPort_2_Daemon_CP_675_elements(77) & outputPort_2_Daemon_CP_675_elements(15);
      gj_outputPort_2_Daemon_cp_element_group_11 : generic_join generic map(name => joinName, number_of_predecessors => 7, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(11), clk => clk, reset => reset); --
    end block;
    -- CP-element group 12:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 12: predecessors 
    -- CP-element group 12: 	116 
    -- CP-element group 12: 	99 
    -- CP-element group 12: 	19 
    -- CP-element group 12: 	38 
    -- CP-element group 12: 	59 
    -- CP-element group 12: 	80 
    -- CP-element group 12: successors 
    -- CP-element group 12: 	136 
    -- CP-element group 12: 	13 
    -- CP-element group 12: marked-successors 
    -- CP-element group 12: 	114 
    -- CP-element group 12: 	16 
    -- CP-element group 12: 	96 
    -- CP-element group 12: 	35 
    -- CP-element group 12: 	56 
    -- CP-element group 12: 	77 
    -- CP-element group 12:  members (7) 
      -- CP-element group 12: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/aggregated_phi_sample_ack
      -- CP-element group 12: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_sample_completed_
      -- CP-element group 12: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_sample_completed_
      -- 
    outputPort_2_Daemon_cp_element_group_12: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_12"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(116) & outputPort_2_Daemon_CP_675_elements(99) & outputPort_2_Daemon_CP_675_elements(19) & outputPort_2_Daemon_CP_675_elements(38) & outputPort_2_Daemon_CP_675_elements(59) & outputPort_2_Daemon_CP_675_elements(80);
      gj_outputPort_2_Daemon_cp_element_group_12 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(12), clk => clk, reset => reset); --
    end block;
    -- CP-element group 13:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 13: predecessors 
    -- CP-element group 13: 	12 
    -- CP-element group 13: successors 
    -- CP-element group 13: 	10 
    -- CP-element group 13:  members (1) 
      -- CP-element group 13: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/aggregated_phi_sample_ack_d
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(13) is a control-delay.
    cp_element_13_delay: control_delay_element  generic map(name => " 13_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_675_elements(12), ack => outputPort_2_Daemon_CP_675_elements(13), clk => clk, reset =>reset);
    -- CP-element group 14:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 14: predecessors 
    -- CP-element group 14: 	115 
    -- CP-element group 14: 	17 
    -- CP-element group 14: 	97 
    -- CP-element group 14: 	36 
    -- CP-element group 14: 	57 
    -- CP-element group 14: 	78 
    -- CP-element group 14: successors 
    -- CP-element group 14: 	117 
    -- CP-element group 14: 	20 
    -- CP-element group 14: 	39 
    -- CP-element group 14: 	60 
    -- CP-element group 14: 	81 
    -- CP-element group 14:  members (2) 
      -- CP-element group 14: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_update_start__ps
      -- CP-element group 14: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/aggregated_phi_update_req
      -- 
    outputPort_2_Daemon_cp_element_group_14: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_14"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(115) & outputPort_2_Daemon_CP_675_elements(17) & outputPort_2_Daemon_CP_675_elements(97) & outputPort_2_Daemon_CP_675_elements(36) & outputPort_2_Daemon_CP_675_elements(57) & outputPort_2_Daemon_CP_675_elements(78);
      gj_outputPort_2_Daemon_cp_element_group_14 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(14), clk => clk, reset => reset); --
    end block;
    -- CP-element group 15:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 15: predecessors 
    -- CP-element group 15: 	100 
    -- CP-element group 15: 	21 
    -- CP-element group 15: 	118 
    -- CP-element group 15: 	40 
    -- CP-element group 15: 	61 
    -- CP-element group 15: 	82 
    -- CP-element group 15: successors 
    -- CP-element group 15: 	10 
    -- CP-element group 15: marked-successors 
    -- CP-element group 15: 	11 
    -- CP-element group 15:  members (1) 
      -- CP-element group 15: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/aggregated_phi_update_ack
      -- 
    outputPort_2_Daemon_cp_element_group_15: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 7,1 => 7,2 => 7,3 => 7,4 => 7,5 => 7);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_15"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(100) & outputPort_2_Daemon_CP_675_elements(21) & outputPort_2_Daemon_CP_675_elements(118) & outputPort_2_Daemon_CP_675_elements(40) & outputPort_2_Daemon_CP_675_elements(61) & outputPort_2_Daemon_CP_675_elements(82);
      gj_outputPort_2_Daemon_cp_element_group_15 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(15), clk => clk, reset => reset); --
    end block;
    -- CP-element group 16:  join  transition  bypass  pipeline-parent 
    -- CP-element group 16: predecessors 
    -- CP-element group 16: 	9 
    -- CP-element group 16: marked-predecessors 
    -- CP-element group 16: 	12 
    -- CP-element group 16: successors 
    -- CP-element group 16: 	11 
    -- CP-element group 16:  members (1) 
      -- CP-element group 16: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_16: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_16"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_16 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(16), clk => clk, reset => reset); --
    end block;
    -- CP-element group 17:  join  transition  bypass  pipeline-parent 
    -- CP-element group 17: predecessors 
    -- CP-element group 17: 	9 
    -- CP-element group 17: marked-predecessors 
    -- CP-element group 17: 	133 
    -- CP-element group 17: successors 
    -- CP-element group 17: 	14 
    -- CP-element group 17:  members (1) 
      -- CP-element group 17: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_17: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_17"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(133);
      gj_outputPort_2_Daemon_cp_element_group_17 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(17), clk => clk, reset => reset); --
    end block;
    -- CP-element group 18:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 18: predecessors 
    -- CP-element group 18: 	11 
    -- CP-element group 18: successors 
    -- CP-element group 18:  members (1) 
      -- CP-element group 18: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_sample_start__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(18) <= outputPort_2_Daemon_CP_675_elements(11);
    -- CP-element group 19:  join  transition  bypass  pipeline-parent 
    -- CP-element group 19: predecessors 
    -- CP-element group 19: successors 
    -- CP-element group 19: 	12 
    -- CP-element group 19:  members (1) 
      -- CP-element group 19: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(19) is bound as output of CP function.
    -- CP-element group 20:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 20: predecessors 
    -- CP-element group 20: 	14 
    -- CP-element group 20: successors 
    -- CP-element group 20:  members (1) 
      -- CP-element group 20: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_update_start__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(20) <= outputPort_2_Daemon_CP_675_elements(14);
    -- CP-element group 21:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 21: predecessors 
    -- CP-element group 21: successors 
    -- CP-element group 21: 	132 
    -- CP-element group 21: 	15 
    -- CP-element group 21:  members (2) 
      -- CP-element group 21: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_update_completed_
      -- CP-element group 21: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_update_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(21) is bound as output of CP function.
    -- CP-element group 22:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 22: predecessors 
    -- CP-element group 22: 	7 
    -- CP-element group 22: successors 
    -- CP-element group 22:  members (1) 
      -- CP-element group 22: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(22) <= outputPort_2_Daemon_CP_675_elements(7);
    -- CP-element group 23:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 23: predecessors 
    -- CP-element group 23: successors 
    -- CP-element group 23:  members (2) 
      -- CP-element group 23: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_loopback_sample_req
      -- CP-element group 23: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_loopback_sample_req_ps
      -- 
    phi_stmt_453_loopback_sample_req_715_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_453_loopback_sample_req_715_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(23), ack => phi_stmt_453_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(23) is bound as output of CP function.
    -- CP-element group 24:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 24: predecessors 
    -- CP-element group 24: 	8 
    -- CP-element group 24: successors 
    -- CP-element group 24:  members (1) 
      -- CP-element group 24: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_entry_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(24) <= outputPort_2_Daemon_CP_675_elements(8);
    -- CP-element group 25:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 25: predecessors 
    -- CP-element group 25: successors 
    -- CP-element group 25:  members (2) 
      -- CP-element group 25: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_entry_sample_req
      -- CP-element group 25: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_entry_sample_req_ps
      -- 
    phi_stmt_453_entry_sample_req_718_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_453_entry_sample_req_718_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(25), ack => phi_stmt_453_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(25) is bound as output of CP function.
    -- CP-element group 26:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 26: predecessors 
    -- CP-element group 26: successors 
    -- CP-element group 26:  members (2) 
      -- CP-element group 26: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_phi_mux_ack
      -- CP-element group 26: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_453_phi_mux_ack_ps
      -- 
    phi_stmt_453_phi_mux_ack_721_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 26_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_453_ack_0, ack => outputPort_2_Daemon_CP_675_elements(26)); -- 
    -- CP-element group 27:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 27: predecessors 
    -- CP-element group 27: successors 
    -- CP-element group 27:  members (4) 
      -- CP-element group 27: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_455_sample_start__ps
      -- CP-element group 27: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_455_sample_completed__ps
      -- CP-element group 27: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_455_sample_start_
      -- CP-element group 27: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_455_sample_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(27) is bound as output of CP function.
    -- CP-element group 28:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 28: predecessors 
    -- CP-element group 28: successors 
    -- CP-element group 28: 	30 
    -- CP-element group 28:  members (2) 
      -- CP-element group 28: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_455_update_start__ps
      -- CP-element group 28: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_455_update_start_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(28) is bound as output of CP function.
    -- CP-element group 29:  join  transition  bypass  pipeline-parent 
    -- CP-element group 29: predecessors 
    -- CP-element group 29: 	30 
    -- CP-element group 29: successors 
    -- CP-element group 29:  members (1) 
      -- CP-element group 29: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_455_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(29) <= outputPort_2_Daemon_CP_675_elements(30);
    -- CP-element group 30:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 30: predecessors 
    -- CP-element group 30: 	28 
    -- CP-element group 30: successors 
    -- CP-element group 30: 	29 
    -- CP-element group 30:  members (1) 
      -- CP-element group 30: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_455_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(30) is a control-delay.
    cp_element_30_delay: control_delay_element  generic map(name => " 30_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_675_elements(28), ack => outputPort_2_Daemon_CP_675_elements(30), clk => clk, reset =>reset);
    -- CP-element group 31:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 31: predecessors 
    -- CP-element group 31: successors 
    -- CP-element group 31: 	33 
    -- CP-element group 31:  members (4) 
      -- CP-element group 31: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_sample_start__ps
      -- CP-element group 31: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_sample_start_
      -- CP-element group 31: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_Sample/$entry
      -- CP-element group 31: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_Sample/req
      -- 
    req_742_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_742_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(31), ack => next_down_counter_555_456_buf_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(31) is bound as output of CP function.
    -- CP-element group 32:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 32: predecessors 
    -- CP-element group 32: successors 
    -- CP-element group 32: 	34 
    -- CP-element group 32:  members (4) 
      -- CP-element group 32: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_update_start__ps
      -- CP-element group 32: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_update_start_
      -- CP-element group 32: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_Update/$entry
      -- CP-element group 32: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_Update/req
      -- 
    req_747_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_747_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(32), ack => next_down_counter_555_456_buf_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(32) is bound as output of CP function.
    -- CP-element group 33:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 33: predecessors 
    -- CP-element group 33: 	31 
    -- CP-element group 33: successors 
    -- CP-element group 33:  members (4) 
      -- CP-element group 33: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_sample_completed__ps
      -- CP-element group 33: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_sample_completed_
      -- CP-element group 33: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_Sample/$exit
      -- CP-element group 33: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_Sample/ack
      -- 
    ack_743_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 33_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_down_counter_555_456_buf_ack_0, ack => outputPort_2_Daemon_CP_675_elements(33)); -- 
    -- CP-element group 34:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 34: predecessors 
    -- CP-element group 34: 	32 
    -- CP-element group 34: successors 
    -- CP-element group 34:  members (4) 
      -- CP-element group 34: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_update_completed__ps
      -- CP-element group 34: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_update_completed_
      -- CP-element group 34: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_Update/$exit
      -- CP-element group 34: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_down_counter_456_Update/ack
      -- 
    ack_748_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 34_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_down_counter_555_456_buf_ack_1, ack => outputPort_2_Daemon_CP_675_elements(34)); -- 
    -- CP-element group 35:  join  transition  bypass  pipeline-parent 
    -- CP-element group 35: predecessors 
    -- CP-element group 35: 	9 
    -- CP-element group 35: marked-predecessors 
    -- CP-element group 35: 	12 
    -- CP-element group 35: successors 
    -- CP-element group 35: 	11 
    -- CP-element group 35:  members (1) 
      -- CP-element group 35: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_35: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_35"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_35 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(35), clk => clk, reset => reset); --
    end block;
    -- CP-element group 36:  join  transition  bypass  pipeline-parent 
    -- CP-element group 36: predecessors 
    -- CP-element group 36: 	9 
    -- CP-element group 36: marked-predecessors 
    -- CP-element group 36: 	133 
    -- CP-element group 36: successors 
    -- CP-element group 36: 	14 
    -- CP-element group 36:  members (1) 
      -- CP-element group 36: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_36: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_36"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(133);
      gj_outputPort_2_Daemon_cp_element_group_36 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(36), clk => clk, reset => reset); --
    end block;
    -- CP-element group 37:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 37: predecessors 
    -- CP-element group 37: 	11 
    -- CP-element group 37: successors 
    -- CP-element group 37:  members (1) 
      -- CP-element group 37: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_sample_start__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(37) <= outputPort_2_Daemon_CP_675_elements(11);
    -- CP-element group 38:  join  transition  bypass  pipeline-parent 
    -- CP-element group 38: predecessors 
    -- CP-element group 38: successors 
    -- CP-element group 38: 	12 
    -- CP-element group 38:  members (1) 
      -- CP-element group 38: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(38) is bound as output of CP function.
    -- CP-element group 39:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 39: predecessors 
    -- CP-element group 39: 	14 
    -- CP-element group 39: successors 
    -- CP-element group 39:  members (1) 
      -- CP-element group 39: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_update_start__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(39) <= outputPort_2_Daemon_CP_675_elements(14);
    -- CP-element group 40:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 40: predecessors 
    -- CP-element group 40: successors 
    -- CP-element group 40: 	132 
    -- CP-element group 40: 	15 
    -- CP-element group 40:  members (2) 
      -- CP-element group 40: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_update_completed_
      -- CP-element group 40: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_update_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(40) is bound as output of CP function.
    -- CP-element group 41:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 41: predecessors 
    -- CP-element group 41: 	7 
    -- CP-element group 41: successors 
    -- CP-element group 41:  members (1) 
      -- CP-element group 41: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(41) <= outputPort_2_Daemon_CP_675_elements(7);
    -- CP-element group 42:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 42: predecessors 
    -- CP-element group 42: successors 
    -- CP-element group 42:  members (2) 
      -- CP-element group 42: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_loopback_sample_req
      -- CP-element group 42: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_loopback_sample_req_ps
      -- 
    phi_stmt_457_loopback_sample_req_759_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_457_loopback_sample_req_759_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(42), ack => phi_stmt_457_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(42) is bound as output of CP function.
    -- CP-element group 43:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 43: predecessors 
    -- CP-element group 43: 	8 
    -- CP-element group 43: successors 
    -- CP-element group 43:  members (1) 
      -- CP-element group 43: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_entry_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(43) <= outputPort_2_Daemon_CP_675_elements(8);
    -- CP-element group 44:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 44: predecessors 
    -- CP-element group 44: successors 
    -- CP-element group 44:  members (2) 
      -- CP-element group 44: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_entry_sample_req
      -- CP-element group 44: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_entry_sample_req_ps
      -- 
    phi_stmt_457_entry_sample_req_762_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_457_entry_sample_req_762_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(44), ack => phi_stmt_457_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(44) is bound as output of CP function.
    -- CP-element group 45:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 45: predecessors 
    -- CP-element group 45: successors 
    -- CP-element group 45:  members (2) 
      -- CP-element group 45: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_phi_mux_ack
      -- CP-element group 45: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_457_phi_mux_ack_ps
      -- 
    phi_stmt_457_phi_mux_ack_765_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 45_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_457_ack_0, ack => outputPort_2_Daemon_CP_675_elements(45)); -- 
    -- CP-element group 46:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 46: predecessors 
    -- CP-element group 46: successors 
    -- CP-element group 46:  members (4) 
      -- CP-element group 46: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_459_sample_completed_
      -- CP-element group 46: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_459_sample_start_
      -- CP-element group 46: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_459_sample_start__ps
      -- CP-element group 46: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_459_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(46) is bound as output of CP function.
    -- CP-element group 47:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 47: predecessors 
    -- CP-element group 47: successors 
    -- CP-element group 47: 	49 
    -- CP-element group 47:  members (2) 
      -- CP-element group 47: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_459_update_start_
      -- CP-element group 47: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_459_update_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(47) is bound as output of CP function.
    -- CP-element group 48:  join  transition  bypass  pipeline-parent 
    -- CP-element group 48: predecessors 
    -- CP-element group 48: 	49 
    -- CP-element group 48: successors 
    -- CP-element group 48:  members (1) 
      -- CP-element group 48: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_459_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(48) <= outputPort_2_Daemon_CP_675_elements(49);
    -- CP-element group 49:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 49: predecessors 
    -- CP-element group 49: 	47 
    -- CP-element group 49: successors 
    -- CP-element group 49: 	48 
    -- CP-element group 49:  members (1) 
      -- CP-element group 49: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_459_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(49) is a control-delay.
    cp_element_49_delay: control_delay_element  generic map(name => " 49_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_675_elements(47), ack => outputPort_2_Daemon_CP_675_elements(49), clk => clk, reset =>reset);
    -- CP-element group 50:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 50: predecessors 
    -- CP-element group 50: successors 
    -- CP-element group 50: 	52 
    -- CP-element group 50:  members (1) 
      -- CP-element group 50: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_sample_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(50) is bound as output of CP function.
    -- CP-element group 51:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 51: predecessors 
    -- CP-element group 51: successors 
    -- CP-element group 51: 	53 
    -- CP-element group 51:  members (1) 
      -- CP-element group 51: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_update_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(51) is bound as output of CP function.
    -- CP-element group 52:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 52: predecessors 
    -- CP-element group 52: 	50 
    -- CP-element group 52: marked-predecessors 
    -- CP-element group 52: 	55 
    -- CP-element group 52: successors 
    -- CP-element group 52: 	54 
    -- CP-element group 52:  members (3) 
      -- CP-element group 52: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_Sample/rr
      -- CP-element group 52: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_Sample/$entry
      -- CP-element group 52: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_sample_start_
      -- 
    rr_786_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_786_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(52), ack => RPIPE_noblock_obuf_1_2_461_inst_req_0); -- 
    outputPort_2_Daemon_cp_element_group_52: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_52"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(50) & outputPort_2_Daemon_CP_675_elements(55);
      gj_outputPort_2_Daemon_cp_element_group_52 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(52), clk => clk, reset => reset); --
    end block;
    -- CP-element group 53:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 53: predecessors 
    -- CP-element group 53: 	51 
    -- CP-element group 53: 	54 
    -- CP-element group 53: successors 
    -- CP-element group 53: 	55 
    -- CP-element group 53:  members (3) 
      -- CP-element group 53: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_Update/$entry
      -- CP-element group 53: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_Update/cr
      -- CP-element group 53: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_update_start_
      -- 
    cr_791_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_791_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(53), ack => RPIPE_noblock_obuf_1_2_461_inst_req_1); -- 
    outputPort_2_Daemon_cp_element_group_53: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_53"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(51) & outputPort_2_Daemon_CP_675_elements(54);
      gj_outputPort_2_Daemon_cp_element_group_53 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(53), clk => clk, reset => reset); --
    end block;
    -- CP-element group 54:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 54: predecessors 
    -- CP-element group 54: 	52 
    -- CP-element group 54: successors 
    -- CP-element group 54: 	53 
    -- CP-element group 54:  members (4) 
      -- CP-element group 54: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_Sample/ra
      -- CP-element group 54: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_sample_completed_
      -- CP-element group 54: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_sample_completed__ps
      -- CP-element group 54: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_Sample/$exit
      -- 
    ra_787_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 54_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_1_2_461_inst_ack_0, ack => outputPort_2_Daemon_CP_675_elements(54)); -- 
    -- CP-element group 55:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 55: predecessors 
    -- CP-element group 55: 	53 
    -- CP-element group 55: successors 
    -- CP-element group 55: marked-successors 
    -- CP-element group 55: 	52 
    -- CP-element group 55:  members (4) 
      -- CP-element group 55: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_Update/ca
      -- CP-element group 55: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_update_completed_
      -- CP-element group 55: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_update_completed__ps
      -- CP-element group 55: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_1_2_461_Update/$exit
      -- 
    ca_792_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 55_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_1_2_461_inst_ack_1, ack => outputPort_2_Daemon_CP_675_elements(55)); -- 
    -- CP-element group 56:  join  transition  bypass  pipeline-parent 
    -- CP-element group 56: predecessors 
    -- CP-element group 56: 	9 
    -- CP-element group 56: marked-predecessors 
    -- CP-element group 56: 	12 
    -- CP-element group 56: successors 
    -- CP-element group 56: 	11 
    -- CP-element group 56:  members (1) 
      -- CP-element group 56: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_56: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_56"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_56 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(56), clk => clk, reset => reset); --
    end block;
    -- CP-element group 57:  join  transition  bypass  pipeline-parent 
    -- CP-element group 57: predecessors 
    -- CP-element group 57: 	9 
    -- CP-element group 57: marked-predecessors 
    -- CP-element group 57: 	133 
    -- CP-element group 57: successors 
    -- CP-element group 57: 	14 
    -- CP-element group 57:  members (1) 
      -- CP-element group 57: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_57: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_57"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(133);
      gj_outputPort_2_Daemon_cp_element_group_57 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(57), clk => clk, reset => reset); --
    end block;
    -- CP-element group 58:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 58: predecessors 
    -- CP-element group 58: 	11 
    -- CP-element group 58: successors 
    -- CP-element group 58:  members (1) 
      -- CP-element group 58: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_sample_start__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(58) <= outputPort_2_Daemon_CP_675_elements(11);
    -- CP-element group 59:  join  transition  bypass  pipeline-parent 
    -- CP-element group 59: predecessors 
    -- CP-element group 59: successors 
    -- CP-element group 59: 	12 
    -- CP-element group 59:  members (1) 
      -- CP-element group 59: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(59) is bound as output of CP function.
    -- CP-element group 60:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 60: predecessors 
    -- CP-element group 60: 	14 
    -- CP-element group 60: successors 
    -- CP-element group 60:  members (1) 
      -- CP-element group 60: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_update_start__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(60) <= outputPort_2_Daemon_CP_675_elements(14);
    -- CP-element group 61:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 61: predecessors 
    -- CP-element group 61: successors 
    -- CP-element group 61: 	132 
    -- CP-element group 61: 	15 
    -- CP-element group 61:  members (2) 
      -- CP-element group 61: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_update_completed_
      -- CP-element group 61: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_update_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(61) is bound as output of CP function.
    -- CP-element group 62:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 62: predecessors 
    -- CP-element group 62: 	7 
    -- CP-element group 62: successors 
    -- CP-element group 62:  members (1) 
      -- CP-element group 62: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(62) <= outputPort_2_Daemon_CP_675_elements(7);
    -- CP-element group 63:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 63: predecessors 
    -- CP-element group 63: successors 
    -- CP-element group 63:  members (2) 
      -- CP-element group 63: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_loopback_sample_req_ps
      -- CP-element group 63: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_loopback_sample_req
      -- 
    phi_stmt_462_loopback_sample_req_803_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_462_loopback_sample_req_803_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(63), ack => phi_stmt_462_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(63) is bound as output of CP function.
    -- CP-element group 64:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 64: predecessors 
    -- CP-element group 64: 	8 
    -- CP-element group 64: successors 
    -- CP-element group 64:  members (1) 
      -- CP-element group 64: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_entry_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(64) <= outputPort_2_Daemon_CP_675_elements(8);
    -- CP-element group 65:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 65: predecessors 
    -- CP-element group 65: successors 
    -- CP-element group 65:  members (2) 
      -- CP-element group 65: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_entry_sample_req_ps
      -- CP-element group 65: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_entry_sample_req
      -- 
    phi_stmt_462_entry_sample_req_806_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_462_entry_sample_req_806_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(65), ack => phi_stmt_462_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(65) is bound as output of CP function.
    -- CP-element group 66:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 66: predecessors 
    -- CP-element group 66: successors 
    -- CP-element group 66:  members (2) 
      -- CP-element group 66: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_phi_mux_ack_ps
      -- CP-element group 66: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_462_phi_mux_ack
      -- 
    phi_stmt_462_phi_mux_ack_809_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 66_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_462_ack_0, ack => outputPort_2_Daemon_CP_675_elements(66)); -- 
    -- CP-element group 67:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 67: predecessors 
    -- CP-element group 67: successors 
    -- CP-element group 67:  members (4) 
      -- CP-element group 67: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_464_sample_start__ps
      -- CP-element group 67: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_464_sample_completed__ps
      -- CP-element group 67: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_464_sample_completed_
      -- CP-element group 67: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_464_sample_start_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(67) is bound as output of CP function.
    -- CP-element group 68:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 68: predecessors 
    -- CP-element group 68: successors 
    -- CP-element group 68: 	70 
    -- CP-element group 68:  members (2) 
      -- CP-element group 68: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_464_update_start__ps
      -- CP-element group 68: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_464_update_start_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(68) is bound as output of CP function.
    -- CP-element group 69:  join  transition  bypass  pipeline-parent 
    -- CP-element group 69: predecessors 
    -- CP-element group 69: 	70 
    -- CP-element group 69: successors 
    -- CP-element group 69:  members (1) 
      -- CP-element group 69: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_464_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(69) <= outputPort_2_Daemon_CP_675_elements(70);
    -- CP-element group 70:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 70: predecessors 
    -- CP-element group 70: 	68 
    -- CP-element group 70: successors 
    -- CP-element group 70: 	69 
    -- CP-element group 70:  members (1) 
      -- CP-element group 70: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_33_464_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(70) is a control-delay.
    cp_element_70_delay: control_delay_element  generic map(name => " 70_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_675_elements(68), ack => outputPort_2_Daemon_CP_675_elements(70), clk => clk, reset =>reset);
    -- CP-element group 71:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 71: predecessors 
    -- CP-element group 71: successors 
    -- CP-element group 71: 	73 
    -- CP-element group 71:  members (1) 
      -- CP-element group 71: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_sample_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(71) is bound as output of CP function.
    -- CP-element group 72:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 72: predecessors 
    -- CP-element group 72: successors 
    -- CP-element group 72: 	74 
    -- CP-element group 72:  members (1) 
      -- CP-element group 72: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_update_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(72) is bound as output of CP function.
    -- CP-element group 73:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 73: predecessors 
    -- CP-element group 73: 	71 
    -- CP-element group 73: marked-predecessors 
    -- CP-element group 73: 	76 
    -- CP-element group 73: successors 
    -- CP-element group 73: 	75 
    -- CP-element group 73:  members (3) 
      -- CP-element group 73: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_sample_start_
      -- CP-element group 73: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_Sample/rr
      -- CP-element group 73: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_Sample/$entry
      -- 
    rr_830_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " rr_830_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(73), ack => RPIPE_noblock_obuf_2_2_466_inst_req_0); -- 
    outputPort_2_Daemon_cp_element_group_73: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_73"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(71) & outputPort_2_Daemon_CP_675_elements(76);
      gj_outputPort_2_Daemon_cp_element_group_73 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(73), clk => clk, reset => reset); --
    end block;
    -- CP-element group 74:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 74: predecessors 
    -- CP-element group 74: 	72 
    -- CP-element group 74: 	75 
    -- CP-element group 74: successors 
    -- CP-element group 74: 	76 
    -- CP-element group 74:  members (3) 
      -- CP-element group 74: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_Update/$entry
      -- CP-element group 74: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_Update/cr
      -- CP-element group 74: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_update_start_
      -- 
    cr_835_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " cr_835_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(74), ack => RPIPE_noblock_obuf_2_2_466_inst_req_1); -- 
    outputPort_2_Daemon_cp_element_group_74: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_74"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(72) & outputPort_2_Daemon_CP_675_elements(75);
      gj_outputPort_2_Daemon_cp_element_group_74 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(74), clk => clk, reset => reset); --
    end block;
    -- CP-element group 75:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 75: predecessors 
    -- CP-element group 75: 	73 
    -- CP-element group 75: successors 
    -- CP-element group 75: 	74 
    -- CP-element group 75:  members (4) 
      -- CP-element group 75: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_sample_completed_
      -- CP-element group 75: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_Sample/ra
      -- CP-element group 75: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_Sample/$exit
      -- CP-element group 75: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_sample_completed__ps
      -- 
    ra_831_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 75_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_2_2_466_inst_ack_0, ack => outputPort_2_Daemon_CP_675_elements(75)); -- 
    -- CP-element group 76:  join  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 76: predecessors 
    -- CP-element group 76: 	74 
    -- CP-element group 76: successors 
    -- CP-element group 76: marked-successors 
    -- CP-element group 76: 	73 
    -- CP-element group 76:  members (4) 
      -- CP-element group 76: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_Update/ca
      -- CP-element group 76: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_update_completed_
      -- CP-element group 76: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_Update/$exit
      -- CP-element group 76: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/RPIPE_noblock_obuf_2_2_466_update_completed__ps
      -- 
    ca_836_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 76_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => RPIPE_noblock_obuf_2_2_466_inst_ack_1, ack => outputPort_2_Daemon_CP_675_elements(76)); -- 
    -- CP-element group 77:  join  transition  bypass  pipeline-parent 
    -- CP-element group 77: predecessors 
    -- CP-element group 77: 	9 
    -- CP-element group 77: marked-predecessors 
    -- CP-element group 77: 	12 
    -- CP-element group 77: successors 
    -- CP-element group 77: 	11 
    -- CP-element group 77:  members (1) 
      -- CP-element group 77: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_77: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_77"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_77 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(77), clk => clk, reset => reset); --
    end block;
    -- CP-element group 78:  join  transition  bypass  pipeline-parent 
    -- CP-element group 78: predecessors 
    -- CP-element group 78: 	9 
    -- CP-element group 78: marked-predecessors 
    -- CP-element group 78: 	133 
    -- CP-element group 78: successors 
    -- CP-element group 78: 	14 
    -- CP-element group 78:  members (1) 
      -- CP-element group 78: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_78: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_78"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(133);
      gj_outputPort_2_Daemon_cp_element_group_78 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(78), clk => clk, reset => reset); --
    end block;
    -- CP-element group 79:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 79: predecessors 
    -- CP-element group 79: 	11 
    -- CP-element group 79: successors 
    -- CP-element group 79:  members (1) 
      -- CP-element group 79: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_sample_start__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(79) <= outputPort_2_Daemon_CP_675_elements(11);
    -- CP-element group 80:  join  transition  bypass  pipeline-parent 
    -- CP-element group 80: predecessors 
    -- CP-element group 80: successors 
    -- CP-element group 80: 	12 
    -- CP-element group 80:  members (1) 
      -- CP-element group 80: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(80) is bound as output of CP function.
    -- CP-element group 81:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 81: predecessors 
    -- CP-element group 81: 	14 
    -- CP-element group 81: successors 
    -- CP-element group 81:  members (1) 
      -- CP-element group 81: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_update_start__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(81) <= outputPort_2_Daemon_CP_675_elements(14);
    -- CP-element group 82:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 82: predecessors 
    -- CP-element group 82: successors 
    -- CP-element group 82: 	132 
    -- CP-element group 82: 	15 
    -- CP-element group 82:  members (2) 
      -- CP-element group 82: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_update_completed__ps
      -- CP-element group 82: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(82) is bound as output of CP function.
    -- CP-element group 83:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 83: predecessors 
    -- CP-element group 83: 	7 
    -- CP-element group 83: successors 
    -- CP-element group 83:  members (1) 
      -- CP-element group 83: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(83) <= outputPort_2_Daemon_CP_675_elements(7);
    -- CP-element group 84:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 84: predecessors 
    -- CP-element group 84: successors 
    -- CP-element group 84:  members (2) 
      -- CP-element group 84: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_loopback_sample_req_ps
      -- CP-element group 84: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_loopback_sample_req
      -- 
    phi_stmt_467_loopback_sample_req_847_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_467_loopback_sample_req_847_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(84), ack => phi_stmt_467_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(84) is bound as output of CP function.
    -- CP-element group 85:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 85: predecessors 
    -- CP-element group 85: 	8 
    -- CP-element group 85: successors 
    -- CP-element group 85:  members (1) 
      -- CP-element group 85: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_entry_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(85) <= outputPort_2_Daemon_CP_675_elements(8);
    -- CP-element group 86:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 86: predecessors 
    -- CP-element group 86: successors 
    -- CP-element group 86:  members (2) 
      -- CP-element group 86: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_entry_sample_req
      -- CP-element group 86: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_entry_sample_req_ps
      -- 
    phi_stmt_467_entry_sample_req_850_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_467_entry_sample_req_850_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(86), ack => phi_stmt_467_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(86) is bound as output of CP function.
    -- CP-element group 87:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 87: predecessors 
    -- CP-element group 87: successors 
    -- CP-element group 87:  members (2) 
      -- CP-element group 87: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_phi_mux_ack
      -- CP-element group 87: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_467_phi_mux_ack_ps
      -- 
    phi_stmt_467_phi_mux_ack_853_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 87_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_467_ack_0, ack => outputPort_2_Daemon_CP_675_elements(87)); -- 
    -- CP-element group 88:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 88: predecessors 
    -- CP-element group 88: successors 
    -- CP-element group 88:  members (4) 
      -- CP-element group 88: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_2_469_sample_start__ps
      -- CP-element group 88: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_2_469_sample_completed_
      -- CP-element group 88: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_2_469_sample_start_
      -- CP-element group 88: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_2_469_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(88) is bound as output of CP function.
    -- CP-element group 89:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 89: predecessors 
    -- CP-element group 89: successors 
    -- CP-element group 89: 	91 
    -- CP-element group 89:  members (2) 
      -- CP-element group 89: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_2_469_update_start_
      -- CP-element group 89: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_2_469_update_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(89) is bound as output of CP function.
    -- CP-element group 90:  join  transition  bypass  pipeline-parent 
    -- CP-element group 90: predecessors 
    -- CP-element group 90: 	91 
    -- CP-element group 90: successors 
    -- CP-element group 90:  members (1) 
      -- CP-element group 90: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_2_469_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(90) <= outputPort_2_Daemon_CP_675_elements(91);
    -- CP-element group 91:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 91: predecessors 
    -- CP-element group 91: 	89 
    -- CP-element group 91: successors 
    -- CP-element group 91: 	90 
    -- CP-element group 91:  members (1) 
      -- CP-element group 91: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_2_469_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(91) is a control-delay.
    cp_element_91_delay: control_delay_element  generic map(name => " 91_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_675_elements(89), ack => outputPort_2_Daemon_CP_675_elements(91), clk => clk, reset =>reset);
    -- CP-element group 92:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 92: predecessors 
    -- CP-element group 92: successors 
    -- CP-element group 92: 	94 
    -- CP-element group 92:  members (4) 
      -- CP-element group 92: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_Sample/req
      -- CP-element group 92: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_sample_start_
      -- CP-element group 92: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_Sample/$entry
      -- CP-element group 92: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_sample_start__ps
      -- 
    req_874_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_874_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(92), ack => next_active_packet_520_470_buf_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(92) is bound as output of CP function.
    -- CP-element group 93:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 93: predecessors 
    -- CP-element group 93: successors 
    -- CP-element group 93: 	95 
    -- CP-element group 93:  members (4) 
      -- CP-element group 93: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_Update/$entry
      -- CP-element group 93: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_update_start_
      -- CP-element group 93: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_update_start__ps
      -- CP-element group 93: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_Update/req
      -- 
    req_879_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_879_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(93), ack => next_active_packet_520_470_buf_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(93) is bound as output of CP function.
    -- CP-element group 94:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 94: predecessors 
    -- CP-element group 94: 	92 
    -- CP-element group 94: successors 
    -- CP-element group 94:  members (4) 
      -- CP-element group 94: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_Sample/$exit
      -- CP-element group 94: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_Sample/ack
      -- CP-element group 94: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_sample_completed_
      -- CP-element group 94: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_sample_completed__ps
      -- 
    ack_875_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 94_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_520_470_buf_ack_0, ack => outputPort_2_Daemon_CP_675_elements(94)); -- 
    -- CP-element group 95:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 95: predecessors 
    -- CP-element group 95: 	93 
    -- CP-element group 95: successors 
    -- CP-element group 95:  members (4) 
      -- CP-element group 95: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_update_completed__ps
      -- CP-element group 95: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_update_completed_
      -- CP-element group 95: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_Update/ack
      -- CP-element group 95: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_470_Update/$exit
      -- 
    ack_880_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 95_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_520_470_buf_ack_1, ack => outputPort_2_Daemon_CP_675_elements(95)); -- 
    -- CP-element group 96:  join  transition  bypass  pipeline-parent 
    -- CP-element group 96: predecessors 
    -- CP-element group 96: 	9 
    -- CP-element group 96: marked-predecessors 
    -- CP-element group 96: 	12 
    -- CP-element group 96: successors 
    -- CP-element group 96: 	11 
    -- CP-element group 96:  members (1) 
      -- CP-element group 96: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_96: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_96"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_96 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(96), clk => clk, reset => reset); --
    end block;
    -- CP-element group 97:  join  transition  bypass  pipeline-parent 
    -- CP-element group 97: predecessors 
    -- CP-element group 97: 	9 
    -- CP-element group 97: marked-predecessors 
    -- CP-element group 97: 	100 
    -- CP-element group 97: successors 
    -- CP-element group 97: 	14 
    -- CP-element group 97:  members (1) 
      -- CP-element group 97: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_97: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 39) := "outputPort_2_Daemon_cp_element_group_97"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(100);
      gj_outputPort_2_Daemon_cp_element_group_97 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(97), clk => clk, reset => reset); --
    end block;
    -- CP-element group 98:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 98: predecessors 
    -- CP-element group 98: 	11 
    -- CP-element group 98: successors 
    -- CP-element group 98:  members (1) 
      -- CP-element group 98: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_sample_start__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(98) <= outputPort_2_Daemon_CP_675_elements(11);
    -- CP-element group 99:  join  transition  bypass  pipeline-parent 
    -- CP-element group 99: predecessors 
    -- CP-element group 99: successors 
    -- CP-element group 99: 	12 
    -- CP-element group 99:  members (1) 
      -- CP-element group 99: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(99) is bound as output of CP function.
    -- CP-element group 100:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 100: predecessors 
    -- CP-element group 100: successors 
    -- CP-element group 100: 	15 
    -- CP-element group 100: marked-successors 
    -- CP-element group 100: 	97 
    -- CP-element group 100:  members (2) 
      -- CP-element group 100: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_update_completed__ps
      -- CP-element group 100: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(100) is bound as output of CP function.
    -- CP-element group 101:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 101: predecessors 
    -- CP-element group 101: 	7 
    -- CP-element group 101: successors 
    -- CP-element group 101:  members (1) 
      -- CP-element group 101: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(101) <= outputPort_2_Daemon_CP_675_elements(7);
    -- CP-element group 102:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 102: predecessors 
    -- CP-element group 102: successors 
    -- CP-element group 102:  members (2) 
      -- CP-element group 102: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_loopback_sample_req_ps
      -- CP-element group 102: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_loopback_sample_req
      -- 
    phi_stmt_471_loopback_sample_req_891_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_471_loopback_sample_req_891_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(102), ack => phi_stmt_471_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(102) is bound as output of CP function.
    -- CP-element group 103:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 103: predecessors 
    -- CP-element group 103: 	8 
    -- CP-element group 103: successors 
    -- CP-element group 103:  members (1) 
      -- CP-element group 103: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_entry_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(103) <= outputPort_2_Daemon_CP_675_elements(8);
    -- CP-element group 104:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 104: predecessors 
    -- CP-element group 104: successors 
    -- CP-element group 104:  members (2) 
      -- CP-element group 104: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_entry_sample_req
      -- CP-element group 104: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_entry_sample_req_ps
      -- 
    phi_stmt_471_entry_sample_req_894_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_471_entry_sample_req_894_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(104), ack => phi_stmt_471_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(104) is bound as output of CP function.
    -- CP-element group 105:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 105: predecessors 
    -- CP-element group 105: successors 
    -- CP-element group 105:  members (2) 
      -- CP-element group 105: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_phi_mux_ack_ps
      -- CP-element group 105: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_471_phi_mux_ack
      -- 
    phi_stmt_471_phi_mux_ack_897_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 105_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_471_ack_0, ack => outputPort_2_Daemon_CP_675_elements(105)); -- 
    -- CP-element group 106:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 106: predecessors 
    -- CP-element group 106: successors 
    -- CP-element group 106:  members (4) 
      -- CP-element group 106: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_473_sample_start__ps
      -- CP-element group 106: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_473_sample_completed__ps
      -- CP-element group 106: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_473_sample_start_
      -- CP-element group 106: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_473_sample_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(106) is bound as output of CP function.
    -- CP-element group 107:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 107: predecessors 
    -- CP-element group 107: successors 
    -- CP-element group 107: 	109 
    -- CP-element group 107:  members (2) 
      -- CP-element group 107: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_473_update_start_
      -- CP-element group 107: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_473_update_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(107) is bound as output of CP function.
    -- CP-element group 108:  join  transition  bypass  pipeline-parent 
    -- CP-element group 108: predecessors 
    -- CP-element group 108: 	109 
    -- CP-element group 108: successors 
    -- CP-element group 108:  members (1) 
      -- CP-element group 108: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_473_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(108) <= outputPort_2_Daemon_CP_675_elements(109);
    -- CP-element group 109:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 109: predecessors 
    -- CP-element group 109: 	107 
    -- CP-element group 109: successors 
    -- CP-element group 109: 	108 
    -- CP-element group 109:  members (1) 
      -- CP-element group 109: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_8_473_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(109) is a control-delay.
    cp_element_109_delay: control_delay_element  generic map(name => " 109_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_675_elements(107), ack => outputPort_2_Daemon_CP_675_elements(109), clk => clk, reset =>reset);
    -- CP-element group 110:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 110: predecessors 
    -- CP-element group 110: successors 
    -- CP-element group 110: 	112 
    -- CP-element group 110:  members (4) 
      -- CP-element group 110: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_sample_start__ps
      -- CP-element group 110: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_Sample/req
      -- CP-element group 110: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_sample_start_
      -- CP-element group 110: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_Sample/$entry
      -- 
    req_918_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_918_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(110), ack => next_active_packet_length_542_474_buf_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(110) is bound as output of CP function.
    -- CP-element group 111:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 111: predecessors 
    -- CP-element group 111: successors 
    -- CP-element group 111: 	113 
    -- CP-element group 111:  members (4) 
      -- CP-element group 111: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_Update/req
      -- CP-element group 111: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_update_start__ps
      -- CP-element group 111: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_Update/$entry
      -- CP-element group 111: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_update_start_
      -- 
    req_923_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_923_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(111), ack => next_active_packet_length_542_474_buf_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(111) is bound as output of CP function.
    -- CP-element group 112:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 112: predecessors 
    -- CP-element group 112: 	110 
    -- CP-element group 112: successors 
    -- CP-element group 112:  members (4) 
      -- CP-element group 112: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_Sample/ack
      -- CP-element group 112: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_sample_completed__ps
      -- CP-element group 112: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_sample_completed_
      -- CP-element group 112: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_Sample/$exit
      -- 
    ack_919_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 112_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_length_542_474_buf_ack_0, ack => outputPort_2_Daemon_CP_675_elements(112)); -- 
    -- CP-element group 113:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 113: predecessors 
    -- CP-element group 113: 	111 
    -- CP-element group 113: successors 
    -- CP-element group 113:  members (4) 
      -- CP-element group 113: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_Update/$exit
      -- CP-element group 113: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_update_completed__ps
      -- CP-element group 113: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_Update/ack
      -- CP-element group 113: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_active_packet_length_474_update_completed_
      -- 
    ack_924_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 113_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_active_packet_length_542_474_buf_ack_1, ack => outputPort_2_Daemon_CP_675_elements(113)); -- 
    -- CP-element group 114:  join  transition  bypass  pipeline-parent 
    -- CP-element group 114: predecessors 
    -- CP-element group 114: 	9 
    -- CP-element group 114: marked-predecessors 
    -- CP-element group 114: 	12 
    -- CP-element group 114: successors 
    -- CP-element group 114: 	11 
    -- CP-element group 114:  members (1) 
      -- CP-element group 114: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_sample_start_
      -- 
    outputPort_2_Daemon_cp_element_group_114: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 1);
      constant joinName: string(1 to 40) := "outputPort_2_Daemon_cp_element_group_114"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_114 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(114), clk => clk, reset => reset); --
    end block;
    -- CP-element group 115:  join  transition  bypass  pipeline-parent 
    -- CP-element group 115: predecessors 
    -- CP-element group 115: 	9 
    -- CP-element group 115: marked-predecessors 
    -- CP-element group 115: 	133 
    -- CP-element group 115: successors 
    -- CP-element group 115: 	14 
    -- CP-element group 115:  members (1) 
      -- CP-element group 115: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_update_start_
      -- 
    outputPort_2_Daemon_cp_element_group_115: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 1);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 1);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 40) := "outputPort_2_Daemon_cp_element_group_115"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(9) & outputPort_2_Daemon_CP_675_elements(133);
      gj_outputPort_2_Daemon_cp_element_group_115 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(115), clk => clk, reset => reset); --
    end block;
    -- CP-element group 116:  join  transition  bypass  pipeline-parent 
    -- CP-element group 116: predecessors 
    -- CP-element group 116: successors 
    -- CP-element group 116: 	12 
    -- CP-element group 116:  members (1) 
      -- CP-element group 116: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_sample_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(116) is bound as output of CP function.
    -- CP-element group 117:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 117: predecessors 
    -- CP-element group 117: 	14 
    -- CP-element group 117: successors 
    -- CP-element group 117:  members (1) 
      -- CP-element group 117: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_update_start__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(117) <= outputPort_2_Daemon_CP_675_elements(14);
    -- CP-element group 118:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 118: predecessors 
    -- CP-element group 118: successors 
    -- CP-element group 118: 	132 
    -- CP-element group 118: 	15 
    -- CP-element group 118:  members (2) 
      -- CP-element group 118: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_update_completed_
      -- CP-element group 118: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_update_completed__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(118) is bound as output of CP function.
    -- CP-element group 119:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 119: predecessors 
    -- CP-element group 119: 	7 
    -- CP-element group 119: successors 
    -- CP-element group 119:  members (1) 
      -- CP-element group 119: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_loopback_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(119) <= outputPort_2_Daemon_CP_675_elements(7);
    -- CP-element group 120:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 120: predecessors 
    -- CP-element group 120: successors 
    -- CP-element group 120:  members (2) 
      -- CP-element group 120: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_loopback_sample_req
      -- CP-element group 120: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_loopback_sample_req_ps
      -- 
    phi_stmt_475_loopback_sample_req_935_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_475_loopback_sample_req_935_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(120), ack => phi_stmt_475_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(120) is bound as output of CP function.
    -- CP-element group 121:  fork  transition  bypass  pipeline-parent 
    -- CP-element group 121: predecessors 
    -- CP-element group 121: 	8 
    -- CP-element group 121: successors 
    -- CP-element group 121:  members (1) 
      -- CP-element group 121: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_entry_trigger
      -- 
    outputPort_2_Daemon_CP_675_elements(121) <= outputPort_2_Daemon_CP_675_elements(8);
    -- CP-element group 122:  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 122: predecessors 
    -- CP-element group 122: successors 
    -- CP-element group 122:  members (2) 
      -- CP-element group 122: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_entry_sample_req_ps
      -- CP-element group 122: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_entry_sample_req
      -- 
    phi_stmt_475_entry_sample_req_938_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " phi_stmt_475_entry_sample_req_938_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(122), ack => phi_stmt_475_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(122) is bound as output of CP function.
    -- CP-element group 123:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 123: predecessors 
    -- CP-element group 123: successors 
    -- CP-element group 123:  members (2) 
      -- CP-element group 123: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_phi_mux_ack_ps
      -- CP-element group 123: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/phi_stmt_475_phi_mux_ack
      -- 
    phi_stmt_475_phi_mux_ack_941_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 123_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => phi_stmt_475_ack_0, ack => outputPort_2_Daemon_CP_675_elements(123)); -- 
    -- CP-element group 124:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 124: predecessors 
    -- CP-element group 124: successors 
    -- CP-element group 124:  members (4) 
      -- CP-element group 124: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_1_477_sample_completed__ps
      -- CP-element group 124: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_1_477_sample_completed_
      -- CP-element group 124: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_1_477_sample_start__ps
      -- CP-element group 124: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_1_477_sample_start_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(124) is bound as output of CP function.
    -- CP-element group 125:  join  fork  transition  bypass  pipeline-parent 
    -- CP-element group 125: predecessors 
    -- CP-element group 125: successors 
    -- CP-element group 125: 	127 
    -- CP-element group 125:  members (2) 
      -- CP-element group 125: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_1_477_update_start_
      -- CP-element group 125: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_1_477_update_start__ps
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(125) is bound as output of CP function.
    -- CP-element group 126:  join  transition  bypass  pipeline-parent 
    -- CP-element group 126: predecessors 
    -- CP-element group 126: 	127 
    -- CP-element group 126: successors 
    -- CP-element group 126:  members (1) 
      -- CP-element group 126: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_1_477_update_completed__ps
      -- 
    outputPort_2_Daemon_CP_675_elements(126) <= outputPort_2_Daemon_CP_675_elements(127);
    -- CP-element group 127:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 127: predecessors 
    -- CP-element group 127: 	125 
    -- CP-element group 127: successors 
    -- CP-element group 127: 	126 
    -- CP-element group 127:  members (1) 
      -- CP-element group 127: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_ZERO_1_477_update_completed_
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(127) is a control-delay.
    cp_element_127_delay: control_delay_element  generic map(name => " 127_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_675_elements(125), ack => outputPort_2_Daemon_CP_675_elements(127), clk => clk, reset =>reset);
    -- CP-element group 128:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 128: predecessors 
    -- CP-element group 128: successors 
    -- CP-element group 128: 	130 
    -- CP-element group 128:  members (4) 
      -- CP-element group 128: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_Sample/req
      -- CP-element group 128: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_sample_start__ps
      -- CP-element group 128: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_Sample/$entry
      -- CP-element group 128: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_sample_start_
      -- 
    req_962_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_962_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(128), ack => next_pkt_1_has_priority_520_478_buf_req_0); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(128) is bound as output of CP function.
    -- CP-element group 129:  join  fork  transition  output  bypass  pipeline-parent 
    -- CP-element group 129: predecessors 
    -- CP-element group 129: successors 
    -- CP-element group 129: 	131 
    -- CP-element group 129:  members (4) 
      -- CP-element group 129: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_update_start__ps
      -- CP-element group 129: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_update_start_
      -- CP-element group 129: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_Update/req
      -- CP-element group 129: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_Update/$entry
      -- 
    req_967_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_967_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(129), ack => next_pkt_1_has_priority_520_478_buf_req_1); -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(129) is bound as output of CP function.
    -- CP-element group 130:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 130: predecessors 
    -- CP-element group 130: 	128 
    -- CP-element group 130: successors 
    -- CP-element group 130:  members (4) 
      -- CP-element group 130: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_Sample/ack
      -- CP-element group 130: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_sample_completed__ps
      -- CP-element group 130: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_Sample/$exit
      -- CP-element group 130: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_sample_completed_
      -- 
    ack_963_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 130_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_pkt_1_has_priority_520_478_buf_ack_0, ack => outputPort_2_Daemon_CP_675_elements(130)); -- 
    -- CP-element group 131:  join  transition  input  bypass  pipeline-parent 
    -- CP-element group 131: predecessors 
    -- CP-element group 131: 	129 
    -- CP-element group 131: successors 
    -- CP-element group 131:  members (4) 
      -- CP-element group 131: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_update_completed__ps
      -- CP-element group 131: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_Update/ack
      -- CP-element group 131: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_Update/$exit
      -- CP-element group 131: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/R_next_pkt_1_has_priority_478_update_completed_
      -- 
    ack_968_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 131_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => next_pkt_1_has_priority_520_478_buf_ack_1, ack => outputPort_2_Daemon_CP_675_elements(131)); -- 
    -- CP-element group 132:  join  transition  output  bypass  pipeline-parent 
    -- CP-element group 132: predecessors 
    -- CP-element group 132: 	21 
    -- CP-element group 132: 	118 
    -- CP-element group 132: 	40 
    -- CP-element group 132: 	61 
    -- CP-element group 132: 	82 
    -- CP-element group 132: marked-predecessors 
    -- CP-element group 132: 	134 
    -- CP-element group 132: successors 
    -- CP-element group 132: 	133 
    -- CP-element group 132:  members (3) 
      -- CP-element group 132: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_sample_start_
      -- CP-element group 132: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_Sample/$entry
      -- CP-element group 132: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_Sample/req
      -- 
    req_977_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_977_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(132), ack => WPIPE_out_data_2_598_inst_req_0); -- 
    outputPort_2_Daemon_cp_element_group_132: block -- 
      constant place_capacities: IntegerArray(0 to 5) := (0 => 1,1 => 1,2 => 1,3 => 1,4 => 1,5 => 1);
      constant place_markings: IntegerArray(0 to 5)  := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 1);
      constant place_delays: IntegerArray(0 to 5) := (0 => 0,1 => 0,2 => 0,3 => 0,4 => 0,5 => 0);
      constant joinName: string(1 to 40) := "outputPort_2_Daemon_cp_element_group_132"; 
      signal preds: BooleanArray(1 to 6); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(21) & outputPort_2_Daemon_CP_675_elements(118) & outputPort_2_Daemon_CP_675_elements(40) & outputPort_2_Daemon_CP_675_elements(61) & outputPort_2_Daemon_CP_675_elements(82) & outputPort_2_Daemon_CP_675_elements(134);
      gj_outputPort_2_Daemon_cp_element_group_132 : generic_join generic map(name => joinName, number_of_predecessors => 6, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(132), clk => clk, reset => reset); --
    end block;
    -- CP-element group 133:  fork  transition  input  output  bypass  pipeline-parent 
    -- CP-element group 133: predecessors 
    -- CP-element group 133: 	132 
    -- CP-element group 133: successors 
    -- CP-element group 133: 	134 
    -- CP-element group 133: marked-successors 
    -- CP-element group 133: 	115 
    -- CP-element group 133: 	17 
    -- CP-element group 133: 	36 
    -- CP-element group 133: 	57 
    -- CP-element group 133: 	78 
    -- CP-element group 133:  members (6) 
      -- CP-element group 133: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_sample_completed_
      -- CP-element group 133: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_Sample/$exit
      -- CP-element group 133: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_Update/req
      -- CP-element group 133: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_update_start_
      -- CP-element group 133: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_Update/$entry
      -- CP-element group 133: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_Sample/ack
      -- 
    ack_978_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 133_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_data_2_598_inst_ack_0, ack => outputPort_2_Daemon_CP_675_elements(133)); -- 
    req_982_symbol_link_to_dp: control_delay_element -- 
      generic map(name => " req_982_symbol_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => outputPort_2_Daemon_CP_675_elements(133), ack => WPIPE_out_data_2_598_inst_req_1); -- 
    -- CP-element group 134:  fork  transition  input  bypass  pipeline-parent 
    -- CP-element group 134: predecessors 
    -- CP-element group 134: 	133 
    -- CP-element group 134: successors 
    -- CP-element group 134: 	136 
    -- CP-element group 134: marked-successors 
    -- CP-element group 134: 	132 
    -- CP-element group 134:  members (3) 
      -- CP-element group 134: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_Update/ack
      -- CP-element group 134: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_update_completed_
      -- CP-element group 134: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/WPIPE_out_data_2_598_Update/$exit
      -- 
    ack_983_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 134_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => WPIPE_out_data_2_598_inst_ack_1, ack => outputPort_2_Daemon_CP_675_elements(134)); -- 
    -- CP-element group 135:  transition  delay-element  bypass  pipeline-parent 
    -- CP-element group 135: predecessors 
    -- CP-element group 135: 	9 
    -- CP-element group 135: successors 
    -- CP-element group 135: 	10 
    -- CP-element group 135:  members (1) 
      -- CP-element group 135: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/loop_body_delay_to_condition_start
      -- 
    -- Element group outputPort_2_Daemon_CP_675_elements(135) is a control-delay.
    cp_element_135_delay: control_delay_element  generic map(name => " 135_delay", delay_value => 1)  port map(req => outputPort_2_Daemon_CP_675_elements(9), ack => outputPort_2_Daemon_CP_675_elements(135), clk => clk, reset =>reset);
    -- CP-element group 136:  join  transition  bypass  pipeline-parent 
    -- CP-element group 136: predecessors 
    -- CP-element group 136: 	134 
    -- CP-element group 136: 	12 
    -- CP-element group 136: successors 
    -- CP-element group 136: 	6 
    -- CP-element group 136:  members (1) 
      -- CP-element group 136: 	 branch_block_stmt_450/do_while_stmt_451/do_while_stmt_451_loop_body/$exit
      -- 
    outputPort_2_Daemon_cp_element_group_136: block -- 
      constant place_capacities: IntegerArray(0 to 1) := (0 => 7,1 => 7);
      constant place_markings: IntegerArray(0 to 1)  := (0 => 0,1 => 0);
      constant place_delays: IntegerArray(0 to 1) := (0 => 0,1 => 0);
      constant joinName: string(1 to 40) := "outputPort_2_Daemon_cp_element_group_136"; 
      signal preds: BooleanArray(1 to 2); -- 
    begin -- 
      preds <= outputPort_2_Daemon_CP_675_elements(134) & outputPort_2_Daemon_CP_675_elements(12);
      gj_outputPort_2_Daemon_cp_element_group_136 : generic_join generic map(name => joinName, number_of_predecessors => 2, place_capacities => place_capacities, place_markings => place_markings, place_delays => place_delays) -- 
        port map(preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(136), clk => clk, reset => reset); --
    end block;
    -- CP-element group 137:  transition  input  bypass  pipeline-parent 
    -- CP-element group 137: predecessors 
    -- CP-element group 137: 	5 
    -- CP-element group 137: successors 
    -- CP-element group 137:  members (2) 
      -- CP-element group 137: 	 branch_block_stmt_450/do_while_stmt_451/loop_exit/ack
      -- CP-element group 137: 	 branch_block_stmt_450/do_while_stmt_451/loop_exit/$exit
      -- 
    ack_988_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 137_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_451_branch_ack_0, ack => outputPort_2_Daemon_CP_675_elements(137)); -- 
    -- CP-element group 138:  transition  input  bypass  pipeline-parent 
    -- CP-element group 138: predecessors 
    -- CP-element group 138: 	5 
    -- CP-element group 138: successors 
    -- CP-element group 138:  members (2) 
      -- CP-element group 138: 	 branch_block_stmt_450/do_while_stmt_451/loop_taken/$exit
      -- CP-element group 138: 	 branch_block_stmt_450/do_while_stmt_451/loop_taken/ack
      -- 
    ack_992_symbol_link_from_dp: control_delay_element -- 
      generic map(name => " 138_delay",delay_value => 0)
      port map(clk => clk, reset => reset, req => do_while_stmt_451_branch_ack_1, ack => outputPort_2_Daemon_CP_675_elements(138)); -- 
    -- CP-element group 139:  transition  bypass  pipeline-parent 
    -- CP-element group 139: predecessors 
    -- CP-element group 139: 	3 
    -- CP-element group 139: successors 
    -- CP-element group 139: 	1 
    -- CP-element group 139:  members (1) 
      -- CP-element group 139: 	 branch_block_stmt_450/do_while_stmt_451/$exit
      -- 
    outputPort_2_Daemon_CP_675_elements(139) <= outputPort_2_Daemon_CP_675_elements(3);
    outputPort_2_Daemon_do_while_stmt_451_terminator_993: loop_terminator -- 
      generic map (name => " outputPort_2_Daemon_do_while_stmt_451_terminator_993", max_iterations_in_flight =>7) 
      port map(loop_body_exit => outputPort_2_Daemon_CP_675_elements(6),loop_continue => outputPort_2_Daemon_CP_675_elements(138),loop_terminate => outputPort_2_Daemon_CP_675_elements(137),loop_back => outputPort_2_Daemon_CP_675_elements(4),loop_exit => outputPort_2_Daemon_CP_675_elements(3),clk => clk, reset => reset); -- 
    phi_stmt_453_phi_seq_749_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_675_elements(24);
      outputPort_2_Daemon_CP_675_elements(27)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_675_elements(27);
      outputPort_2_Daemon_CP_675_elements(28)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_675_elements(29);
      outputPort_2_Daemon_CP_675_elements(25) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_675_elements(22);
      outputPort_2_Daemon_CP_675_elements(31)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_675_elements(33);
      outputPort_2_Daemon_CP_675_elements(32)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_675_elements(34);
      outputPort_2_Daemon_CP_675_elements(23) <= phi_mux_reqs(1);
      phi_stmt_453_phi_seq_749 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_453_phi_seq_749") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_675_elements(18), 
          phi_sample_ack => outputPort_2_Daemon_CP_675_elements(19), 
          phi_update_req => outputPort_2_Daemon_CP_675_elements(20), 
          phi_update_ack => outputPort_2_Daemon_CP_675_elements(21), 
          phi_mux_ack => outputPort_2_Daemon_CP_675_elements(26), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_457_phi_seq_793_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_675_elements(43);
      outputPort_2_Daemon_CP_675_elements(46)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_675_elements(46);
      outputPort_2_Daemon_CP_675_elements(47)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_675_elements(48);
      outputPort_2_Daemon_CP_675_elements(44) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_675_elements(41);
      outputPort_2_Daemon_CP_675_elements(50)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_675_elements(54);
      outputPort_2_Daemon_CP_675_elements(51)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_675_elements(55);
      outputPort_2_Daemon_CP_675_elements(42) <= phi_mux_reqs(1);
      phi_stmt_457_phi_seq_793 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_457_phi_seq_793") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_675_elements(37), 
          phi_sample_ack => outputPort_2_Daemon_CP_675_elements(38), 
          phi_update_req => outputPort_2_Daemon_CP_675_elements(39), 
          phi_update_ack => outputPort_2_Daemon_CP_675_elements(40), 
          phi_mux_ack => outputPort_2_Daemon_CP_675_elements(45), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_462_phi_seq_837_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_675_elements(64);
      outputPort_2_Daemon_CP_675_elements(67)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_675_elements(67);
      outputPort_2_Daemon_CP_675_elements(68)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_675_elements(69);
      outputPort_2_Daemon_CP_675_elements(65) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_675_elements(62);
      outputPort_2_Daemon_CP_675_elements(71)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_675_elements(75);
      outputPort_2_Daemon_CP_675_elements(72)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_675_elements(76);
      outputPort_2_Daemon_CP_675_elements(63) <= phi_mux_reqs(1);
      phi_stmt_462_phi_seq_837 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_462_phi_seq_837") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_675_elements(58), 
          phi_sample_ack => outputPort_2_Daemon_CP_675_elements(59), 
          phi_update_req => outputPort_2_Daemon_CP_675_elements(60), 
          phi_update_ack => outputPort_2_Daemon_CP_675_elements(61), 
          phi_mux_ack => outputPort_2_Daemon_CP_675_elements(66), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_467_phi_seq_881_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_675_elements(85);
      outputPort_2_Daemon_CP_675_elements(88)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_675_elements(88);
      outputPort_2_Daemon_CP_675_elements(89)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_675_elements(90);
      outputPort_2_Daemon_CP_675_elements(86) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_675_elements(83);
      outputPort_2_Daemon_CP_675_elements(92)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_675_elements(94);
      outputPort_2_Daemon_CP_675_elements(93)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_675_elements(95);
      outputPort_2_Daemon_CP_675_elements(84) <= phi_mux_reqs(1);
      phi_stmt_467_phi_seq_881 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_467_phi_seq_881") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_675_elements(79), 
          phi_sample_ack => outputPort_2_Daemon_CP_675_elements(80), 
          phi_update_req => outputPort_2_Daemon_CP_675_elements(81), 
          phi_update_ack => outputPort_2_Daemon_CP_675_elements(82), 
          phi_mux_ack => outputPort_2_Daemon_CP_675_elements(87), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_471_phi_seq_925_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_675_elements(103);
      outputPort_2_Daemon_CP_675_elements(106)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_675_elements(106);
      outputPort_2_Daemon_CP_675_elements(107)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_675_elements(108);
      outputPort_2_Daemon_CP_675_elements(104) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_675_elements(101);
      outputPort_2_Daemon_CP_675_elements(110)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_675_elements(112);
      outputPort_2_Daemon_CP_675_elements(111)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_675_elements(113);
      outputPort_2_Daemon_CP_675_elements(102) <= phi_mux_reqs(1);
      phi_stmt_471_phi_seq_925 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_471_phi_seq_925") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_675_elements(98), 
          phi_sample_ack => outputPort_2_Daemon_CP_675_elements(99), 
          phi_update_req => outputPort_2_Daemon_CP_675_elements(14), 
          phi_update_ack => outputPort_2_Daemon_CP_675_elements(100), 
          phi_mux_ack => outputPort_2_Daemon_CP_675_elements(105), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    phi_stmt_475_phi_seq_969_block : block -- 
      signal triggers, src_sample_reqs, src_sample_acks, src_update_reqs, src_update_acks : BooleanArray(0 to 1);
      signal phi_mux_reqs : BooleanArray(0 to 1); -- 
    begin -- 
      triggers(0)  <= outputPort_2_Daemon_CP_675_elements(121);
      outputPort_2_Daemon_CP_675_elements(124)<= src_sample_reqs(0);
      src_sample_acks(0)  <= outputPort_2_Daemon_CP_675_elements(124);
      outputPort_2_Daemon_CP_675_elements(125)<= src_update_reqs(0);
      src_update_acks(0)  <= outputPort_2_Daemon_CP_675_elements(126);
      outputPort_2_Daemon_CP_675_elements(122) <= phi_mux_reqs(0);
      triggers(1)  <= outputPort_2_Daemon_CP_675_elements(119);
      outputPort_2_Daemon_CP_675_elements(128)<= src_sample_reqs(1);
      src_sample_acks(1)  <= outputPort_2_Daemon_CP_675_elements(130);
      outputPort_2_Daemon_CP_675_elements(129)<= src_update_reqs(1);
      src_update_acks(1)  <= outputPort_2_Daemon_CP_675_elements(131);
      outputPort_2_Daemon_CP_675_elements(120) <= phi_mux_reqs(1);
      phi_stmt_475_phi_seq_969 : phi_sequencer_v2-- 
        generic map (place_capacity => 7, ntriggers => 2, name => "phi_stmt_475_phi_seq_969") 
        port map ( -- 
          triggers => triggers, src_sample_starts => src_sample_reqs, 
          src_sample_completes => src_sample_acks, src_update_starts => src_update_reqs, 
          src_update_completes => src_update_acks,
          phi_mux_select_reqs => phi_mux_reqs, 
          phi_sample_req => outputPort_2_Daemon_CP_675_elements(11), 
          phi_sample_ack => outputPort_2_Daemon_CP_675_elements(116), 
          phi_update_req => outputPort_2_Daemon_CP_675_elements(117), 
          phi_update_ack => outputPort_2_Daemon_CP_675_elements(118), 
          phi_mux_ack => outputPort_2_Daemon_CP_675_elements(123), 
          clk => clk, reset => reset -- 
        );
        -- 
    end block;
    entry_tmerge_700_block : block -- 
      signal preds : BooleanArray(0 to 1);
      begin -- 
        preds(0)  <= outputPort_2_Daemon_CP_675_elements(7);
        preds(1)  <= outputPort_2_Daemon_CP_675_elements(8);
        entry_tmerge_700 : transition_merge -- 
          generic map(name => " entry_tmerge_700")
          port map (preds => preds, symbol_out => outputPort_2_Daemon_CP_675_elements(9));
          -- 
    end block;
    --  hookup: inputs to control-path 
    -- hookup: output from control-path 
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal EQ_u2_u1_501_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_507_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_534_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_561_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_569_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_575_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_585_wire : std_logic_vector(0 downto 0);
    signal EQ_u2_u1_591_wire : std_logic_vector(0 downto 0);
    signal EQ_u8_u1_527_wire : std_logic_vector(0 downto 0);
    signal MUX_504_wire : std_logic_vector(0 downto 0);
    signal MUX_510_wire : std_logic_vector(0 downto 0);
    signal MUX_539_wire : std_logic_vector(7 downto 0);
    signal MUX_553_wire : std_logic_vector(7 downto 0);
    signal MUX_588_wire : std_logic_vector(0 downto 0);
    signal MUX_594_wire : std_logic_vector(0 downto 0);
    signal NEQ_u2_u1_524_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_558_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_566_wire : std_logic_vector(0 downto 0);
    signal RPIPE_noblock_obuf_1_2_461_wire : std_logic_vector(32 downto 0);
    signal RPIPE_noblock_obuf_2_2_466_wire : std_logic_vector(32 downto 0);
    signal R_ZERO_1_477_wire_constant : std_logic_vector(0 downto 0);
    signal R_ZERO_2_469_wire_constant : std_logic_vector(1 downto 0);
    signal R_ZERO_33_459_wire_constant : std_logic_vector(32 downto 0);
    signal R_ZERO_33_464_wire_constant : std_logic_vector(32 downto 0);
    signal R_ZERO_8_455_wire_constant : std_logic_vector(7 downto 0);
    signal R_ZERO_8_473_wire_constant : std_logic_vector(7 downto 0);
    signal SUB_u8_u8_547_wire : std_logic_vector(7 downto 0);
    signal SUB_u8_u8_551_wire : std_logic_vector(7 downto 0);
    signal active_packet_467 : std_logic_vector(1 downto 0);
    signal active_packet_length_471 : std_logic_vector(7 downto 0);
    signal data_to_out_581 : std_logic_vector(31 downto 0);
    signal down_counter_453 : std_logic_vector(7 downto 0);
    signal konst_482_wire_constant : std_logic_vector(32 downto 0);
    signal konst_487_wire_constant : std_logic_vector(32 downto 0);
    signal konst_500_wire_constant : std_logic_vector(1 downto 0);
    signal konst_503_wire_constant : std_logic_vector(0 downto 0);
    signal konst_506_wire_constant : std_logic_vector(1 downto 0);
    signal konst_509_wire_constant : std_logic_vector(0 downto 0);
    signal konst_523_wire_constant : std_logic_vector(1 downto 0);
    signal konst_526_wire_constant : std_logic_vector(7 downto 0);
    signal konst_533_wire_constant : std_logic_vector(1 downto 0);
    signal konst_546_wire_constant : std_logic_vector(7 downto 0);
    signal konst_550_wire_constant : std_logic_vector(7 downto 0);
    signal konst_560_wire_constant : std_logic_vector(1 downto 0);
    signal konst_568_wire_constant : std_logic_vector(1 downto 0);
    signal konst_574_wire_constant : std_logic_vector(1 downto 0);
    signal konst_584_wire_constant : std_logic_vector(1 downto 0);
    signal konst_587_wire_constant : std_logic_vector(0 downto 0);
    signal konst_590_wire_constant : std_logic_vector(1 downto 0);
    signal konst_593_wire_constant : std_logic_vector(0 downto 0);
    signal konst_609_wire_constant : std_logic_vector(0 downto 0);
    signal next_active_packet_520 : std_logic_vector(1 downto 0);
    signal next_active_packet_520_470_buffered : std_logic_vector(1 downto 0);
    signal next_active_packet_length_542 : std_logic_vector(7 downto 0);
    signal next_active_packet_length_542_474_buffered : std_logic_vector(7 downto 0);
    signal next_down_counter_555 : std_logic_vector(7 downto 0);
    signal next_down_counter_555_456_buffered : std_logic_vector(7 downto 0);
    signal next_pkt_1_has_priority_520 : std_logic_vector(0 downto 0);
    signal next_pkt_1_has_priority_520_478_buffered : std_logic_vector(0 downto 0);
    signal p1_valid_484 : std_logic_vector(0 downto 0);
    signal p2_valid_489 : std_logic_vector(0 downto 0);
    signal pkt_1_e_word_457 : std_logic_vector(32 downto 0);
    signal pkt_1_has_priority_475 : std_logic_vector(0 downto 0);
    signal pkt_2_e_word_462 : std_logic_vector(32 downto 0);
    signal read_from_1_563 : std_logic_vector(0 downto 0);
    signal read_from_2_571 : std_logic_vector(0 downto 0);
    signal send_flag_596 : std_logic_vector(0 downto 0);
    signal slice_536_wire : std_logic_vector(7 downto 0);
    signal slice_538_wire : std_logic_vector(7 downto 0);
    signal slice_577_wire : std_logic_vector(31 downto 0);
    signal slice_579_wire : std_logic_vector(31 downto 0);
    signal started_new_packet_529 : std_logic_vector(0 downto 0);
    signal valid_active_pkt_word_read_512 : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    R_ZERO_1_477_wire_constant <= "0";
    R_ZERO_2_469_wire_constant <= "00";
    R_ZERO_33_459_wire_constant <= "000000000000000000000000000000000";
    R_ZERO_33_464_wire_constant <= "000000000000000000000000000000000";
    R_ZERO_8_455_wire_constant <= "00000000";
    R_ZERO_8_473_wire_constant <= "00000000";
    konst_482_wire_constant <= "000000000000000000000000000100000";
    konst_487_wire_constant <= "000000000000000000000000000100000";
    konst_500_wire_constant <= "01";
    konst_503_wire_constant <= "0";
    konst_506_wire_constant <= "10";
    konst_509_wire_constant <= "0";
    konst_523_wire_constant <= "00";
    konst_526_wire_constant <= "00000000";
    konst_533_wire_constant <= "01";
    konst_546_wire_constant <= "00000001";
    konst_550_wire_constant <= "00000001";
    konst_560_wire_constant <= "01";
    konst_568_wire_constant <= "10";
    konst_574_wire_constant <= "01";
    konst_584_wire_constant <= "01";
    konst_587_wire_constant <= "0";
    konst_590_wire_constant <= "10";
    konst_593_wire_constant <= "0";
    konst_609_wire_constant <= "1";
    phi_stmt_453: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_8_455_wire_constant & next_down_counter_555_456_buffered;
      req <= phi_stmt_453_req_0 & phi_stmt_453_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_453",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_453_ack_0,
          idata => idata,
          odata => down_counter_453,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_453
    phi_stmt_457: Block -- phi operator 
      signal idata: std_logic_vector(65 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_33_459_wire_constant & RPIPE_noblock_obuf_1_2_461_wire;
      req <= phi_stmt_457_req_0 & phi_stmt_457_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_457",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 33) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_457_ack_0,
          idata => idata,
          odata => pkt_1_e_word_457,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_457
    phi_stmt_462: Block -- phi operator 
      signal idata: std_logic_vector(65 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_33_464_wire_constant & RPIPE_noblock_obuf_2_2_466_wire;
      req <= phi_stmt_462_req_0 & phi_stmt_462_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_462",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 33) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_462_ack_0,
          idata => idata,
          odata => pkt_2_e_word_462,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_462
    phi_stmt_467: Block -- phi operator 
      signal idata: std_logic_vector(3 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_2_469_wire_constant & next_active_packet_520_470_buffered;
      req <= phi_stmt_467_req_0 & phi_stmt_467_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_467",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 2) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_467_ack_0,
          idata => idata,
          odata => active_packet_467,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_467
    phi_stmt_471: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_8_473_wire_constant & next_active_packet_length_542_474_buffered;
      req <= phi_stmt_471_req_0 & phi_stmt_471_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_471",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_471_ack_0,
          idata => idata,
          odata => active_packet_length_471,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_471
    phi_stmt_475: Block -- phi operator 
      signal idata: std_logic_vector(1 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= R_ZERO_1_477_wire_constant & next_pkt_1_has_priority_520_478_buffered;
      req <= phi_stmt_475_req_0 & phi_stmt_475_req_1;
      phi: PhiBase -- 
        generic map( -- 
          name => "phi_stmt_475",
          num_reqs => 2,
          bypass_flag => true,
          data_width => 1) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_475_ack_0,
          idata => idata,
          odata => pkt_1_has_priority_475,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_475
    -- flow-through select operator MUX_504_inst
    MUX_504_wire <= p1_valid_484 when (EQ_u2_u1_501_wire(0) /=  '0') else konst_503_wire_constant;
    -- flow-through select operator MUX_510_inst
    MUX_510_wire <= p2_valid_489 when (EQ_u2_u1_507_wire(0) /=  '0') else konst_509_wire_constant;
    -- flow-through select operator MUX_539_inst
    MUX_539_wire <= slice_536_wire when (EQ_u2_u1_534_wire(0) /=  '0') else slice_538_wire;
    -- flow-through select operator MUX_541_inst
    next_active_packet_length_542 <= MUX_539_wire when (started_new_packet_529(0) /=  '0') else active_packet_length_471;
    -- flow-through select operator MUX_553_inst
    MUX_553_wire <= SUB_u8_u8_551_wire when (valid_active_pkt_word_read_512(0) /=  '0') else down_counter_453;
    -- flow-through select operator MUX_554_inst
    next_down_counter_555 <= SUB_u8_u8_547_wire when (started_new_packet_529(0) /=  '0') else MUX_553_wire;
    -- flow-through select operator MUX_580_inst
    data_to_out_581 <= slice_577_wire when (EQ_u2_u1_575_wire(0) /=  '0') else slice_579_wire;
    -- flow-through select operator MUX_588_inst
    MUX_588_wire <= p1_valid_484 when (EQ_u2_u1_585_wire(0) /=  '0') else konst_587_wire_constant;
    -- flow-through select operator MUX_594_inst
    MUX_594_wire <= p2_valid_489 when (EQ_u2_u1_591_wire(0) /=  '0') else konst_593_wire_constant;
    -- flow-through slice operator slice_536_inst
    slice_536_wire <= pkt_1_e_word_457(15 downto 8);
    -- flow-through slice operator slice_538_inst
    slice_538_wire <= pkt_2_e_word_462(15 downto 8);
    -- flow-through slice operator slice_577_inst
    slice_577_wire <= pkt_1_e_word_457(31 downto 0);
    -- flow-through slice operator slice_579_inst
    slice_579_wire <= pkt_2_e_word_462(31 downto 0);
    next_active_packet_520_470_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_active_packet_520_470_buf_req_0;
      next_active_packet_520_470_buf_ack_0<= wack(0);
      rreq(0) <= next_active_packet_520_470_buf_req_1;
      next_active_packet_520_470_buf_ack_1<= rack(0);
      next_active_packet_520_470_buf : InterlockBuffer generic map ( -- 
        name => "next_active_packet_520_470_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 2,
        out_data_width => 2,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_active_packet_520,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_active_packet_520_470_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_active_packet_length_542_474_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_active_packet_length_542_474_buf_req_0;
      next_active_packet_length_542_474_buf_ack_0<= wack(0);
      rreq(0) <= next_active_packet_length_542_474_buf_req_1;
      next_active_packet_length_542_474_buf_ack_1<= rack(0);
      next_active_packet_length_542_474_buf : InterlockBuffer generic map ( -- 
        name => "next_active_packet_length_542_474_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_active_packet_length_542,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_active_packet_length_542_474_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_down_counter_555_456_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_down_counter_555_456_buf_req_0;
      next_down_counter_555_456_buf_ack_0<= wack(0);
      rreq(0) <= next_down_counter_555_456_buf_req_1;
      next_down_counter_555_456_buf_ack_1<= rack(0);
      next_down_counter_555_456_buf : InterlockBuffer generic map ( -- 
        name => "next_down_counter_555_456_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 8,
        out_data_width => 8,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_down_counter_555,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_down_counter_555_456_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    next_pkt_1_has_priority_520_478_buf_block: block -- 
      signal wreq, wack, rreq, rack: BooleanArray(0 downto 0); 
      -- 
    begin -- 
      wreq(0) <= next_pkt_1_has_priority_520_478_buf_req_0;
      next_pkt_1_has_priority_520_478_buf_ack_0<= wack(0);
      rreq(0) <= next_pkt_1_has_priority_520_478_buf_req_1;
      next_pkt_1_has_priority_520_478_buf_ack_1<= rack(0);
      next_pkt_1_has_priority_520_478_buf : InterlockBuffer generic map ( -- 
        name => "next_pkt_1_has_priority_520_478_buf",
        buffer_size => 1,
        flow_through =>  false ,
        cut_through =>  false ,
        in_data_width => 1,
        out_data_width => 1,
        bypass_flag =>  false 
        -- 
      )port map ( -- 
        write_req => wreq(0), 
        write_ack => wack(0), 
        write_data => next_pkt_1_has_priority_520,
        read_req => rreq(0),  
        read_ack => rack(0), 
        read_data => next_pkt_1_has_priority_520_478_buffered,
        clk => clk, reset => reset
        -- 
      );
      end block; -- 
    do_while_stmt_451_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= konst_609_wire_constant;
      branch_instance: BranchBase -- 
        generic map( name => "do_while_stmt_451_branch", condition_width => 1,  bypass_flag => true)
        port map( -- 
          condition => condition_sig,
          req => do_while_stmt_451_branch_req_0,
          ack0 => do_while_stmt_451_branch_ack_0,
          ack1 => do_while_stmt_451_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- flow through binary operator AND_u1_u1_528_inst
    started_new_packet_529 <= (NEQ_u2_u1_524_wire and EQ_u8_u1_527_wire);
    -- flow through binary operator BITSEL_u33_u1_483_inst
    process(pkt_1_e_word_457) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApBitsel_proc(pkt_1_e_word_457, konst_482_wire_constant, tmp_var);
      p1_valid_484 <= tmp_var; --
    end process;
    -- flow through binary operator BITSEL_u33_u1_488_inst
    process(pkt_2_e_word_462) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApBitsel_proc(pkt_2_e_word_462, konst_487_wire_constant, tmp_var);
      p2_valid_489 <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_501_inst
    process(active_packet_467) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(active_packet_467, konst_500_wire_constant, tmp_var);
      EQ_u2_u1_501_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_507_inst
    process(active_packet_467) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(active_packet_467, konst_506_wire_constant, tmp_var);
      EQ_u2_u1_507_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_534_inst
    process(next_active_packet_520) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_520, konst_533_wire_constant, tmp_var);
      EQ_u2_u1_534_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_561_inst
    process(next_active_packet_520) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_520, konst_560_wire_constant, tmp_var);
      EQ_u2_u1_561_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_569_inst
    process(next_active_packet_520) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_520, konst_568_wire_constant, tmp_var);
      EQ_u2_u1_569_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_575_inst
    process(next_active_packet_520) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_520, konst_574_wire_constant, tmp_var);
      EQ_u2_u1_575_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_585_inst
    process(next_active_packet_520) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_520, konst_584_wire_constant, tmp_var);
      EQ_u2_u1_585_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u2_u1_591_inst
    process(next_active_packet_520) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(next_active_packet_520, konst_590_wire_constant, tmp_var);
      EQ_u2_u1_591_wire <= tmp_var; --
    end process;
    -- flow through binary operator EQ_u8_u1_527_inst
    process(down_counter_453) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(down_counter_453, konst_526_wire_constant, tmp_var);
      EQ_u8_u1_527_wire <= tmp_var; --
    end process;
    -- flow through binary operator NEQ_u2_u1_524_inst
    process(next_active_packet_520) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntNe_proc(next_active_packet_520, konst_523_wire_constant, tmp_var);
      NEQ_u2_u1_524_wire <= tmp_var; --
    end process;
    -- unary operator NOT_u1_u1_558_inst
    process(p1_valid_484) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p1_valid_484, tmp_var);
      NOT_u1_u1_558_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_566_inst
    process(p2_valid_489) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p2_valid_489, tmp_var);
      NOT_u1_u1_566_wire <= tmp_var; -- 
    end process;
    -- flow through binary operator OR_u1_u1_511_inst
    valid_active_pkt_word_read_512 <= (MUX_504_wire or MUX_510_wire);
    -- flow through binary operator OR_u1_u1_562_inst
    read_from_1_563 <= (NOT_u1_u1_558_wire or EQ_u2_u1_561_wire);
    -- flow through binary operator OR_u1_u1_570_inst
    read_from_2_571 <= (NOT_u1_u1_566_wire or EQ_u2_u1_569_wire);
    -- flow through binary operator OR_u1_u1_595_inst
    send_flag_596 <= (MUX_588_wire or MUX_594_wire);
    -- flow through binary operator SUB_u8_u8_547_inst
    SUB_u8_u8_547_wire <= std_logic_vector(unsigned(next_active_packet_length_542) - unsigned(konst_546_wire_constant));
    -- flow through binary operator SUB_u8_u8_551_inst
    SUB_u8_u8_551_wire <= std_logic_vector(unsigned(down_counter_453) - unsigned(konst_550_wire_constant));
    -- shared inport operator group (0) : RPIPE_noblock_obuf_1_2_461_inst 
    InportGroup_0: Block -- 
      signal data_out: std_logic_vector(32 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_noblock_obuf_1_2_461_inst_req_0;
      RPIPE_noblock_obuf_1_2_461_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_noblock_obuf_1_2_461_inst_req_1;
      RPIPE_noblock_obuf_1_2_461_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <= read_from_1_563(0);
      RPIPE_noblock_obuf_1_2_461_wire <= data_out(32 downto 0);
      noblock_obuf_1_2_read_0_gI: SplitGuardInterface generic map(name => "noblock_obuf_1_2_read_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_1_2_read_0: InputPortRevised -- 
        generic map ( name => "noblock_obuf_1_2_read_0", data_width => 33,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => true,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => noblock_obuf_1_2_pipe_read_req(0),
          oack => noblock_obuf_1_2_pipe_read_ack(0),
          odata => noblock_obuf_1_2_pipe_read_data(32 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared inport operator group (1) : RPIPE_noblock_obuf_2_2_466_inst 
    InportGroup_1: Block -- 
      signal data_out: std_logic_vector(32 downto 0);
      signal reqL, ackL, reqR, ackR : BooleanArray( 0 downto 0);
      signal reqL_unguarded, ackL_unguarded : BooleanArray( 0 downto 0);
      signal reqR_unguarded, ackR_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant outBUFs : IntegerArray(0 downto 0) := (0 => 1);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      reqL_unguarded(0) <= RPIPE_noblock_obuf_2_2_466_inst_req_0;
      RPIPE_noblock_obuf_2_2_466_inst_ack_0 <= ackL_unguarded(0);
      reqR_unguarded(0) <= RPIPE_noblock_obuf_2_2_466_inst_req_1;
      RPIPE_noblock_obuf_2_2_466_inst_ack_1 <= ackR_unguarded(0);
      guard_vector(0)  <= read_from_2_571(0);
      RPIPE_noblock_obuf_2_2_466_wire <= data_out(32 downto 0);
      noblock_obuf_2_2_read_1_gI: SplitGuardInterface generic map(name => "noblock_obuf_2_2_read_1_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => false,  update_only => true) -- 
        port map(clk => clk, reset => reset,
        sr_in => reqL_unguarded,
        sr_out => reqL,
        sa_in => ackL,
        sa_out => ackL_unguarded,
        cr_in => reqR_unguarded,
        cr_out => reqR,
        ca_in => ackR,
        ca_out => ackR_unguarded,
        guards => guard_vector); -- 
      noblock_obuf_2_2_read_1: InputPortRevised -- 
        generic map ( name => "noblock_obuf_2_2_read_1", data_width => 33,  num_reqs => 1,  output_buffering => outBUFs,   nonblocking_read_flag => true,  no_arbitration => false)
        port map (-- 
          sample_req => reqL , 
          sample_ack => ackL, 
          update_req => reqR, 
          update_ack => ackR, 
          data => data_out, 
          oreq => noblock_obuf_2_2_pipe_read_req(0),
          oack => noblock_obuf_2_2_pipe_read_ack(0),
          odata => noblock_obuf_2_2_pipe_read_data(32 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 1
    -- shared outport operator group (0) : WPIPE_out_data_2_598_inst 
    OutportGroup_0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal sample_req, sample_ack : BooleanArray( 0 downto 0);
      signal update_req, update_ack : BooleanArray( 0 downto 0);
      signal sample_req_unguarded, sample_ack_unguarded : BooleanArray( 0 downto 0);
      signal update_req_unguarded, update_ack_unguarded : BooleanArray( 0 downto 0);
      signal guard_vector : std_logic_vector( 0 downto 0);
      constant inBUFs : IntegerArray(0 downto 0) := (0 => 0);
      constant guardFlags : BooleanArray(0 downto 0) := (0 => true);
      constant guardBuffering: IntegerArray(0 downto 0)  := (0 => 2);
      -- 
    begin -- 
      sample_req_unguarded(0) <= WPIPE_out_data_2_598_inst_req_0;
      WPIPE_out_data_2_598_inst_ack_0 <= sample_ack_unguarded(0);
      update_req_unguarded(0) <= WPIPE_out_data_2_598_inst_req_1;
      WPIPE_out_data_2_598_inst_ack_1 <= update_ack_unguarded(0);
      guard_vector(0)  <= send_flag_596(0);
      data_in <= data_to_out_581;
      out_data_2_write_0_gI: SplitGuardInterface generic map(name => "out_data_2_write_0_gI", nreqs => 1, buffering => guardBuffering, use_guards => guardFlags,  sample_only => true,  update_only => false) -- 
        port map(clk => clk, reset => reset,
        sr_in => sample_req_unguarded,
        sr_out => sample_req,
        sa_in => sample_ack,
        sa_out => sample_ack_unguarded,
        cr_in => update_req_unguarded,
        cr_out => update_req,
        ca_in => update_ack,
        ca_out => update_ack_unguarded,
        guards => guard_vector); -- 
      out_data_2_write_0: OutputPortRevised -- 
        generic map ( name => "out_data_2", data_width => 32, num_reqs => 1, input_buffering => inBUFs, full_rate => true,
        no_arbitration => false)
        port map (--
          sample_req => sample_req , 
          sample_ack => sample_ack , 
          update_req => update_req , 
          update_ack => update_ack , 
          data => data_in, 
          oreq => out_data_2_pipe_write_req(0),
          oack => out_data_2_pipe_write_ack(0),
          odata => out_data_2_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    volatile_operator_prioritySelect_1467: prioritySelect_Volatile port map(down_counter => down_counter_453, active_packet => active_packet_467, pkt_1_has_priority => pkt_1_has_priority_475, p1_valid => p1_valid_484, p2_valid => p2_valid_489, next_active_packet => next_active_packet_520, next_pkt_1_has_priority => next_pkt_1_has_priority_520); 
    -- 
  end Block; -- data_path
  -- 
end outputPort_2_Daemon_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.switch_2x2_global_package.all;
entity prioritySelect_Volatile is -- 
  port ( -- 
    down_counter : in  std_logic_vector(7 downto 0);
    active_packet : in  std_logic_vector(1 downto 0);
    pkt_1_has_priority : in  std_logic_vector(0 downto 0);
    p1_valid : in  std_logic_vector(0 downto 0);
    p2_valid : in  std_logic_vector(0 downto 0);
    next_active_packet : out  std_logic_vector(1 downto 0);
    next_pkt_1_has_priority : out  std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity prioritySelect_Volatile;
architecture prioritySelect_Volatile_arch of prioritySelect_Volatile is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal in_buffer_data_in, in_buffer_data_out: std_logic_vector(13-1 downto 0);
  signal default_zero_sig: std_logic;
  -- input port buffer signals
  signal down_counter_buffer :  std_logic_vector(7 downto 0);
  signal active_packet_buffer :  std_logic_vector(1 downto 0);
  signal pkt_1_has_priority_buffer :  std_logic_vector(0 downto 0);
  signal p1_valid_buffer :  std_logic_vector(0 downto 0);
  signal p2_valid_buffer :  std_logic_vector(0 downto 0);
  -- output port buffer signals
  signal next_active_packet_buffer :  std_logic_vector(1 downto 0);
  signal next_pkt_1_has_priority_buffer :  std_logic_vector(0 downto 0);
  -- volatile/operator module components. 
  -- 
begin --  
  -- input handling ------------------------------------------------
  down_counter_buffer <= down_counter;
  active_packet_buffer <= active_packet;
  pkt_1_has_priority_buffer <= pkt_1_has_priority;
  p1_valid_buffer <= p1_valid;
  p2_valid_buffer <= p2_valid;
  -- output handling  -------------------------------------------------------
  next_active_packet <= next_active_packet_buffer;
  next_pkt_1_has_priority <= next_pkt_1_has_priority_buffer;
  -- the control path --------------------------------------------------
  default_zero_sig <= '0';
  -- volatile module, no control path
  -- the data path
  data_path: Block -- 
    signal AND_u1_u1_241_wire : std_logic_vector(0 downto 0);
    signal AND_u1_u1_251_wire : std_logic_vector(0 downto 0);
    signal MUX_264_wire : std_logic_vector(1 downto 0);
    signal MUX_268_wire : std_logic_vector(1 downto 0);
    signal MUX_273_wire : std_logic_vector(1 downto 0);
    signal NOT_u1_u1_244_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_253_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_255_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_261_wire : std_logic_vector(0 downto 0);
    signal NOT_u1_u1_281_wire : std_logic_vector(0 downto 0);
    signal OR_u1_u1_245_wire : std_logic_vector(0 downto 0);
    signal OR_u1_u1_256_wire : std_logic_vector(0 downto 0);
    signal OR_u1_u1_279_wire : std_logic_vector(0 downto 0);
    signal OR_u2_u2_269_wire : std_logic_vector(1 downto 0);
    signal d0_237 : std_logic_vector(0 downto 0);
    signal konst_235_wire_constant : std_logic_vector(7 downto 0);
    signal konst_263_wire_constant : std_logic_vector(1 downto 0);
    signal konst_266_wire_constant : std_logic_vector(1 downto 0);
    signal konst_267_wire_constant : std_logic_vector(1 downto 0);
    signal konst_271_wire_constant : std_logic_vector(1 downto 0);
    signal konst_272_wire_constant : std_logic_vector(1 downto 0);
    signal select_1_247 : std_logic_vector(0 downto 0);
    signal select_2_258 : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    konst_235_wire_constant <= "00000000";
    konst_263_wire_constant <= "00";
    konst_266_wire_constant <= "01";
    konst_267_wire_constant <= "00";
    konst_271_wire_constant <= "10";
    konst_272_wire_constant <= "00";
    -- flow-through select operator MUX_264_inst
    MUX_264_wire <= active_packet_buffer when (NOT_u1_u1_261_wire(0) /=  '0') else konst_263_wire_constant;
    -- flow-through select operator MUX_268_inst
    MUX_268_wire <= konst_266_wire_constant when (select_1_247(0) /=  '0') else konst_267_wire_constant;
    -- flow-through select operator MUX_273_inst
    MUX_273_wire <= konst_271_wire_constant when (select_2_258(0) /=  '0') else konst_272_wire_constant;
    -- flow-through select operator MUX_283_inst
    next_pkt_1_has_priority_buffer <= NOT_u1_u1_281_wire when (OR_u1_u1_279_wire(0) /=  '0') else pkt_1_has_priority_buffer;
    -- flow through binary operator AND_u1_u1_241_inst
    AND_u1_u1_241_wire <= (d0_237 and p1_valid_buffer);
    -- flow through binary operator AND_u1_u1_246_inst
    select_1_247 <= (AND_u1_u1_241_wire and OR_u1_u1_245_wire);
    -- flow through binary operator AND_u1_u1_251_inst
    AND_u1_u1_251_wire <= (d0_237 and p2_valid_buffer);
    -- flow through binary operator AND_u1_u1_257_inst
    select_2_258 <= (AND_u1_u1_251_wire and OR_u1_u1_256_wire);
    -- flow through binary operator EQ_u8_u1_236_inst
    process(down_counter_buffer) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      ApIntEq_proc(down_counter_buffer, konst_235_wire_constant, tmp_var);
      d0_237 <= tmp_var; --
    end process;
    -- unary operator NOT_u1_u1_244_inst
    process(p2_valid_buffer) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p2_valid_buffer, tmp_var);
      NOT_u1_u1_244_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_253_inst
    process(pkt_1_has_priority_buffer) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", pkt_1_has_priority_buffer, tmp_var);
      NOT_u1_u1_253_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_255_inst
    process(p1_valid_buffer) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", p1_valid_buffer, tmp_var);
      NOT_u1_u1_255_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_261_inst
    process(d0_237) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", d0_237, tmp_var);
      NOT_u1_u1_261_wire <= tmp_var; -- 
    end process;
    -- unary operator NOT_u1_u1_281_inst
    process(pkt_1_has_priority_buffer) -- 
      variable tmp_var : std_logic_vector(0 downto 0); -- 
    begin -- 
      SingleInputOperation("ApIntNot", pkt_1_has_priority_buffer, tmp_var);
      NOT_u1_u1_281_wire <= tmp_var; -- 
    end process;
    -- flow through binary operator OR_u1_u1_245_inst
    OR_u1_u1_245_wire <= (pkt_1_has_priority_buffer or NOT_u1_u1_244_wire);
    -- flow through binary operator OR_u1_u1_256_inst
    OR_u1_u1_256_wire <= (NOT_u1_u1_253_wire or NOT_u1_u1_255_wire);
    -- flow through binary operator OR_u1_u1_279_inst
    OR_u1_u1_279_wire <= (select_1_247 or select_2_258);
    -- flow through binary operator OR_u2_u2_269_inst
    OR_u2_u2_269_wire <= (MUX_264_wire or MUX_268_wire);
    -- flow through binary operator OR_u2_u2_274_inst
    next_active_packet_buffer <= (OR_u2_u2_269_wire or MUX_273_wire);
    -- 
  end Block; -- data_path
  -- 
end prioritySelect_Volatile_arch;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library aHiR_ieee_proposed;
use aHiR_ieee_proposed.math_utility_pkg.all;
use aHiR_ieee_proposed.fixed_pkg.all;
use aHiR_ieee_proposed.float_pkg.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.floatoperatorpackage.all;
use ahir.utilities.all;
library work;
use work.switch_2x2_global_package.all;
entity switch_2x2 is  -- system 
  port (-- 
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
    out_data_2_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
  -- 
end entity; 
architecture switch_2x2_arch  of switch_2x2 is -- system-architecture 
  -- declarations related to module inputPort_1_Daemon
  component inputPort_1_Daemon is -- 
    generic (tag_length : integer); 
    port ( -- 
      in_data_1_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_1_pipe_read_data : in   std_logic_vector(31 downto 0);
      noblock_obuf_1_1_pipe_write_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_1_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_1_1_pipe_write_data : out  std_logic_vector(32 downto 0);
      noblock_obuf_1_2_pipe_write_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_1_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_1_2_pipe_write_data : out  std_logic_vector(32 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) ;
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic-- 
    );
    -- 
  end component;
  -- argument signals for module inputPort_1_Daemon
  signal inputPort_1_Daemon_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal inputPort_1_Daemon_tag_out   : std_logic_vector(1 downto 0);
  signal inputPort_1_Daemon_start_req : std_logic;
  signal inputPort_1_Daemon_start_ack : std_logic;
  signal inputPort_1_Daemon_fin_req   : std_logic;
  signal inputPort_1_Daemon_fin_ack : std_logic;
  -- declarations related to module inputPort_2_Daemon
  component inputPort_2_Daemon is -- 
    generic (tag_length : integer); 
    port ( -- 
      in_data_2_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_2_pipe_read_data : in   std_logic_vector(31 downto 0);
      noblock_obuf_2_1_pipe_write_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_2_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_2_1_pipe_write_data : out  std_logic_vector(32 downto 0);
      noblock_obuf_2_2_pipe_write_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_2_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_2_2_pipe_write_data : out  std_logic_vector(32 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) ;
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic-- 
    );
    -- 
  end component;
  -- argument signals for module inputPort_2_Daemon
  signal inputPort_2_Daemon_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal inputPort_2_Daemon_tag_out   : std_logic_vector(1 downto 0);
  signal inputPort_2_Daemon_start_req : std_logic;
  signal inputPort_2_Daemon_start_ack : std_logic;
  signal inputPort_2_Daemon_fin_req   : std_logic;
  signal inputPort_2_Daemon_fin_ack : std_logic;
  -- declarations related to module outputPort_1_Daemon
  component outputPort_1_Daemon is -- 
    generic (tag_length : integer); 
    port ( -- 
      noblock_obuf_1_1_pipe_read_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_1_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_1_1_pipe_read_data : in   std_logic_vector(32 downto 0);
      noblock_obuf_2_1_pipe_read_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_2_1_pipe_read_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_2_1_pipe_read_data : in   std_logic_vector(32 downto 0);
      out_data_1_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_data_1_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_data_1_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) ;
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic-- 
    );
    -- 
  end component;
  -- argument signals for module outputPort_1_Daemon
  signal outputPort_1_Daemon_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal outputPort_1_Daemon_tag_out   : std_logic_vector(1 downto 0);
  signal outputPort_1_Daemon_start_req : std_logic;
  signal outputPort_1_Daemon_start_ack : std_logic;
  signal outputPort_1_Daemon_fin_req   : std_logic;
  signal outputPort_1_Daemon_fin_ack : std_logic;
  -- declarations related to module outputPort_2_Daemon
  component outputPort_2_Daemon is -- 
    generic (tag_length : integer); 
    port ( -- 
      noblock_obuf_1_2_pipe_read_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_1_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_1_2_pipe_read_data : in   std_logic_vector(32 downto 0);
      noblock_obuf_2_2_pipe_read_req : out  std_logic_vector(0 downto 0);
      noblock_obuf_2_2_pipe_read_ack : in   std_logic_vector(0 downto 0);
      noblock_obuf_2_2_pipe_read_data : in   std_logic_vector(32 downto 0);
      out_data_2_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_data_2_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_data_2_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) ;
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic-- 
    );
    -- 
  end component;
  -- argument signals for module outputPort_2_Daemon
  signal outputPort_2_Daemon_tag_in    : std_logic_vector(1 downto 0) := (others => '0');
  signal outputPort_2_Daemon_tag_out   : std_logic_vector(1 downto 0);
  signal outputPort_2_Daemon_start_req : std_logic;
  signal outputPort_2_Daemon_start_ack : std_logic;
  signal outputPort_2_Daemon_fin_req   : std_logic;
  signal outputPort_2_Daemon_fin_ack : std_logic;
  -- declarations related to module prioritySelect
  -- aggregate signals for read from pipe in_data_1
  signal in_data_1_pipe_read_data: std_logic_vector(31 downto 0);
  signal in_data_1_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_data_1_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe in_data_2
  signal in_data_2_pipe_read_data: std_logic_vector(31 downto 0);
  signal in_data_2_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_data_2_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe noblock_obuf_1_1
  signal noblock_obuf_1_1_pipe_write_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_1_1_pipe_write_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_1_1_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe noblock_obuf_1_1
  signal noblock_obuf_1_1_pipe_read_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_1_1_pipe_read_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_1_1_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe noblock_obuf_1_2
  signal noblock_obuf_1_2_pipe_write_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_1_2_pipe_write_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_1_2_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe noblock_obuf_1_2
  signal noblock_obuf_1_2_pipe_read_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_1_2_pipe_read_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_1_2_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe noblock_obuf_2_1
  signal noblock_obuf_2_1_pipe_write_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_2_1_pipe_write_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_2_1_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe noblock_obuf_2_1
  signal noblock_obuf_2_1_pipe_read_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_2_1_pipe_read_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_2_1_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe noblock_obuf_2_2
  signal noblock_obuf_2_2_pipe_write_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_2_2_pipe_write_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_2_2_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe noblock_obuf_2_2
  signal noblock_obuf_2_2_pipe_read_data: std_logic_vector(32 downto 0);
  signal noblock_obuf_2_2_pipe_read_req: std_logic_vector(0 downto 0);
  signal noblock_obuf_2_2_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe out_data_1
  signal out_data_1_pipe_write_data: std_logic_vector(31 downto 0);
  signal out_data_1_pipe_write_req: std_logic_vector(0 downto 0);
  signal out_data_1_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe out_data_2
  signal out_data_2_pipe_write_data: std_logic_vector(31 downto 0);
  signal out_data_2_pipe_write_req: std_logic_vector(0 downto 0);
  signal out_data_2_pipe_write_ack: std_logic_vector(0 downto 0);
  -- gated clock signal declarations.
  -- 
begin -- 
  -- module inputPort_1_Daemon
  inputPort_1_Daemon_instance:inputPort_1_Daemon-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => inputPort_1_Daemon_start_req,
      start_ack => inputPort_1_Daemon_start_ack,
      fin_req => inputPort_1_Daemon_fin_req,
      fin_ack => inputPort_1_Daemon_fin_ack,
      clk => clk,
      reset => reset,
      in_data_1_pipe_read_req => in_data_1_pipe_read_req(0 downto 0),
      in_data_1_pipe_read_ack => in_data_1_pipe_read_ack(0 downto 0),
      in_data_1_pipe_read_data => in_data_1_pipe_read_data(31 downto 0),
      noblock_obuf_1_1_pipe_write_req => noblock_obuf_1_1_pipe_write_req(0 downto 0),
      noblock_obuf_1_1_pipe_write_ack => noblock_obuf_1_1_pipe_write_ack(0 downto 0),
      noblock_obuf_1_1_pipe_write_data => noblock_obuf_1_1_pipe_write_data(32 downto 0),
      noblock_obuf_1_2_pipe_write_req => noblock_obuf_1_2_pipe_write_req(0 downto 0),
      noblock_obuf_1_2_pipe_write_ack => noblock_obuf_1_2_pipe_write_ack(0 downto 0),
      noblock_obuf_1_2_pipe_write_data => noblock_obuf_1_2_pipe_write_data(32 downto 0),
      tag_in => inputPort_1_Daemon_tag_in,
      tag_out => inputPort_1_Daemon_tag_out-- 
    ); -- 
  -- module will be run forever 
  inputPort_1_Daemon_tag_in <= (others => '0');
  inputPort_1_Daemon_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => inputPort_1_Daemon_start_req, start_ack => inputPort_1_Daemon_start_ack,  fin_req => inputPort_1_Daemon_fin_req,  fin_ack => inputPort_1_Daemon_fin_ack);
  -- module inputPort_2_Daemon
  inputPort_2_Daemon_instance:inputPort_2_Daemon-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => inputPort_2_Daemon_start_req,
      start_ack => inputPort_2_Daemon_start_ack,
      fin_req => inputPort_2_Daemon_fin_req,
      fin_ack => inputPort_2_Daemon_fin_ack,
      clk => clk,
      reset => reset,
      in_data_2_pipe_read_req => in_data_2_pipe_read_req(0 downto 0),
      in_data_2_pipe_read_ack => in_data_2_pipe_read_ack(0 downto 0),
      in_data_2_pipe_read_data => in_data_2_pipe_read_data(31 downto 0),
      noblock_obuf_2_1_pipe_write_req => noblock_obuf_2_1_pipe_write_req(0 downto 0),
      noblock_obuf_2_1_pipe_write_ack => noblock_obuf_2_1_pipe_write_ack(0 downto 0),
      noblock_obuf_2_1_pipe_write_data => noblock_obuf_2_1_pipe_write_data(32 downto 0),
      noblock_obuf_2_2_pipe_write_req => noblock_obuf_2_2_pipe_write_req(0 downto 0),
      noblock_obuf_2_2_pipe_write_ack => noblock_obuf_2_2_pipe_write_ack(0 downto 0),
      noblock_obuf_2_2_pipe_write_data => noblock_obuf_2_2_pipe_write_data(32 downto 0),
      tag_in => inputPort_2_Daemon_tag_in,
      tag_out => inputPort_2_Daemon_tag_out-- 
    ); -- 
  -- module will be run forever 
  inputPort_2_Daemon_tag_in <= (others => '0');
  inputPort_2_Daemon_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => inputPort_2_Daemon_start_req, start_ack => inputPort_2_Daemon_start_ack,  fin_req => inputPort_2_Daemon_fin_req,  fin_ack => inputPort_2_Daemon_fin_ack);
  -- module outputPort_1_Daemon
  outputPort_1_Daemon_instance:outputPort_1_Daemon-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => outputPort_1_Daemon_start_req,
      start_ack => outputPort_1_Daemon_start_ack,
      fin_req => outputPort_1_Daemon_fin_req,
      fin_ack => outputPort_1_Daemon_fin_ack,
      clk => clk,
      reset => reset,
      noblock_obuf_1_1_pipe_read_req => noblock_obuf_1_1_pipe_read_req(0 downto 0),
      noblock_obuf_1_1_pipe_read_ack => noblock_obuf_1_1_pipe_read_ack(0 downto 0),
      noblock_obuf_1_1_pipe_read_data => noblock_obuf_1_1_pipe_read_data(32 downto 0),
      noblock_obuf_2_1_pipe_read_req => noblock_obuf_2_1_pipe_read_req(0 downto 0),
      noblock_obuf_2_1_pipe_read_ack => noblock_obuf_2_1_pipe_read_ack(0 downto 0),
      noblock_obuf_2_1_pipe_read_data => noblock_obuf_2_1_pipe_read_data(32 downto 0),
      out_data_1_pipe_write_req => out_data_1_pipe_write_req(0 downto 0),
      out_data_1_pipe_write_ack => out_data_1_pipe_write_ack(0 downto 0),
      out_data_1_pipe_write_data => out_data_1_pipe_write_data(31 downto 0),
      tag_in => outputPort_1_Daemon_tag_in,
      tag_out => outputPort_1_Daemon_tag_out-- 
    ); -- 
  -- module will be run forever 
  outputPort_1_Daemon_tag_in <= (others => '0');
  outputPort_1_Daemon_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => outputPort_1_Daemon_start_req, start_ack => outputPort_1_Daemon_start_ack,  fin_req => outputPort_1_Daemon_fin_req,  fin_ack => outputPort_1_Daemon_fin_ack);
  -- module outputPort_2_Daemon
  outputPort_2_Daemon_instance:outputPort_2_Daemon-- 
    generic map(tag_length => 2)
    port map(-- 
      start_req => outputPort_2_Daemon_start_req,
      start_ack => outputPort_2_Daemon_start_ack,
      fin_req => outputPort_2_Daemon_fin_req,
      fin_ack => outputPort_2_Daemon_fin_ack,
      clk => clk,
      reset => reset,
      noblock_obuf_1_2_pipe_read_req => noblock_obuf_1_2_pipe_read_req(0 downto 0),
      noblock_obuf_1_2_pipe_read_ack => noblock_obuf_1_2_pipe_read_ack(0 downto 0),
      noblock_obuf_1_2_pipe_read_data => noblock_obuf_1_2_pipe_read_data(32 downto 0),
      noblock_obuf_2_2_pipe_read_req => noblock_obuf_2_2_pipe_read_req(0 downto 0),
      noblock_obuf_2_2_pipe_read_ack => noblock_obuf_2_2_pipe_read_ack(0 downto 0),
      noblock_obuf_2_2_pipe_read_data => noblock_obuf_2_2_pipe_read_data(32 downto 0),
      out_data_2_pipe_write_req => out_data_2_pipe_write_req(0 downto 0),
      out_data_2_pipe_write_ack => out_data_2_pipe_write_ack(0 downto 0),
      out_data_2_pipe_write_data => out_data_2_pipe_write_data(31 downto 0),
      tag_in => outputPort_2_Daemon_tag_in,
      tag_out => outputPort_2_Daemon_tag_out-- 
    ); -- 
  -- module will be run forever 
  outputPort_2_Daemon_tag_in <= (others => '0');
  outputPort_2_Daemon_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => outputPort_2_Daemon_start_req, start_ack => outputPort_2_Daemon_start_ack,  fin_req => outputPort_2_Daemon_fin_req,  fin_ack => outputPort_2_Daemon_fin_ack);
  in_data_1_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe in_data_1",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 0 --
    )
    port map( -- 
      read_req => in_data_1_pipe_read_req,
      read_ack => in_data_1_pipe_read_ack,
      read_data => in_data_1_pipe_read_data,
      write_req => in_data_1_pipe_write_req,
      write_ack => in_data_1_pipe_write_ack,
      write_data => in_data_1_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  in_data_2_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe in_data_2",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 0 --
    )
    port map( -- 
      read_req => in_data_2_pipe_read_req,
      read_ack => in_data_2_pipe_read_ack,
      read_data => in_data_2_pipe_read_data,
      write_req => in_data_2_pipe_write_req,
      write_ack => in_data_2_pipe_write_ack,
      write_data => in_data_2_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- non-blocking pipe... Input-ports must have non-blocking-flag => true
  noblock_obuf_1_1_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe noblock_obuf_1_1",
      num_reads => 1,
      num_writes => 1,
      data_width => 33,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 128 --
    )
    port map( -- 
      read_req => noblock_obuf_1_1_pipe_read_req,
      read_ack => noblock_obuf_1_1_pipe_read_ack,
      read_data => noblock_obuf_1_1_pipe_read_data,
      write_req => noblock_obuf_1_1_pipe_write_req,
      write_ack => noblock_obuf_1_1_pipe_write_ack,
      write_data => noblock_obuf_1_1_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- non-blocking pipe... Input-ports must have non-blocking-flag => true
  noblock_obuf_1_2_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe noblock_obuf_1_2",
      num_reads => 1,
      num_writes => 1,
      data_width => 33,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 128 --
    )
    port map( -- 
      read_req => noblock_obuf_1_2_pipe_read_req,
      read_ack => noblock_obuf_1_2_pipe_read_ack,
      read_data => noblock_obuf_1_2_pipe_read_data,
      write_req => noblock_obuf_1_2_pipe_write_req,
      write_ack => noblock_obuf_1_2_pipe_write_ack,
      write_data => noblock_obuf_1_2_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- non-blocking pipe... Input-ports must have non-blocking-flag => true
  noblock_obuf_2_1_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe noblock_obuf_2_1",
      num_reads => 1,
      num_writes => 1,
      data_width => 33,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 128 --
    )
    port map( -- 
      read_req => noblock_obuf_2_1_pipe_read_req,
      read_ack => noblock_obuf_2_1_pipe_read_ack,
      read_data => noblock_obuf_2_1_pipe_read_data,
      write_req => noblock_obuf_2_1_pipe_write_req,
      write_ack => noblock_obuf_2_1_pipe_write_ack,
      write_data => noblock_obuf_2_1_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- non-blocking pipe... Input-ports must have non-blocking-flag => true
  noblock_obuf_2_2_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe noblock_obuf_2_2",
      num_reads => 1,
      num_writes => 1,
      data_width => 33,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 128 --
    )
    port map( -- 
      read_req => noblock_obuf_2_2_pipe_read_req,
      read_ack => noblock_obuf_2_2_pipe_read_ack,
      read_data => noblock_obuf_2_2_pipe_read_data,
      write_req => noblock_obuf_2_2_pipe_write_req,
      write_ack => noblock_obuf_2_2_pipe_write_ack,
      write_data => noblock_obuf_2_2_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  out_data_1_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe out_data_1",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 0 --
    )
    port map( -- 
      read_req => out_data_1_pipe_read_req,
      read_ack => out_data_1_pipe_read_ack,
      read_data => out_data_1_pipe_read_data,
      write_req => out_data_1_pipe_write_req,
      write_ack => out_data_1_pipe_write_ack,
      write_data => out_data_1_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  out_data_2_Pipe: PipeBase -- 
    generic map( -- 
      name => "pipe out_data_2",
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      lifo_mode => false,
      full_rate => false,
      shift_register_mode => false,
      bypass => false,
      depth => 0 --
    )
    port map( -- 
      read_req => out_data_2_pipe_read_req,
      read_ack => out_data_2_pipe_read_ack,
      read_data => out_data_2_pipe_read_data,
      write_req => out_data_2_pipe_write_req,
      write_ack => out_data_2_pipe_write_ack,
      write_data => out_data_2_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- gated clock generators 
  -- 
end switch_2x2_arch;
