library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity uut is
  port (
    len : out std_logic_vector(21 downto 0);
	rdy : out std_logic
  );
end uut;

architecture test of uut is

component sensor_reader_top is
  port (
    reset_n_i                 : in  std_logic;
    clock_i                   : in  std_logic;
    enable_i                  : in  std_logic;
    calc_finished_i           : in  std_logic;
    echo_pulse_i              : in  std_logic;
    trigger_pulse_o           : out std_logic;
    echo_pulse_length_o       : out std_logic_vector(21 downto 0);
    echo_pulse_length_ready_o : out std_logic
  );
end component;

component ultrasonic_test is
  port (
    reset_n_i : in std_logic;
    clock_i : in std_logic;
    ticks_i : in integer;
    trigger_i : in std_logic;
    echo_o : out std_logic
  );
end component;

signal reset_n : std_logic := '0';
signal clock : std_logic := '0';

signal sig_enable : std_logic := '0';
signal sig_calc_finished : std_logic := '0';
signal sig_echo : std_logic := '0';
signal sig_trigger : std_logic := '0';

signal sig_len : std_logic_vector(21 downto 0) := "0000000000000000000000";
signal sig_rdy : std_logic := '0';

signal sig_ticks : integer := 0;

constant half_period : time := 5 ns;

begin

  sensor_reader : sensor_reader_top
  port map (
    reset_n_i => reset_n,
	clock_i => clock,
	enable_i => sig_enable,
	calc_finished_i => sig_calc_finished,
	echo_pulse_i => sig_echo,
	trigger_pulse_o => sig_trigger,
	echo_pulse_length_o => sig_len,
	echo_pulse_length_ready_o => sig_rdy
  );
  
  ultrasonic : ultrasonic_test
  port map (
    reset_n_i => reset_n,
	clock_i => clock,
	ticks_i => sig_ticks,
	trigger_i => sig_trigger,
	echo_o => sig_echo
  );

  clk_proc : process 
  begin
    clock <= not clock;
	wait for half_period;
  end process;
  
end test;