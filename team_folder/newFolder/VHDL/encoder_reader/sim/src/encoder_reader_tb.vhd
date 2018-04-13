-- Peter Lodato
-- CPET 563-01: Embedded Systems Design II
-- Dr. Kaputa
-- Maze Rover Project
-- encoder_reader_tb.vhd
-- Created Tues 10 Apr 2018
-- Last modified Thurs 12 Apr 2018

-- Test bench for encoder_reader_top.vhd.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity encoder_reader_tb is
end encoder_reader_tb;

architecture arch of encoder_reader_tb is

component encoder_reader_top is
  port (
    reset_n_i             : in  std_logic;
    clock_i               : in  std_logic;
    enable_i              : in  std_logic;
    reset_pulse_count_i   : in  std_logic;
    encoder_i             : in  std_logic;
    encoder_pulse_count_o : out std_logic_vector(30 downto 0)
  );
end component;

-- Designed for 100 MHz clock (clock period = 10 ns).
constant CLOCK_PERIOD      : time := 10ns;

constant NUM_OF_ENCODER_PERIODS : integer := 8;
type period_array is array (0 to (NUM_OF_ENCODER_PERIODS - 1)) of time;
constant ENCODER_PERIODS : period_array := (250ns, 830ns, 1us, 4us, 10us, 36us, 50us, 80us);

constant ENCODER_PERIOD_SWITCH_TIME : time := 500us;

signal reset_n             : std_logic := '0';
signal clock               : std_logic := '0';
signal enable              : std_logic := '1';
signal reset_pulse_count   : std_logic := '0';
signal encoder             : std_logic := '0';

signal encoder_pulse_count : std_logic_vector(30 downto 0) := (others => '0');

begin

  -- Generate clock signal.
  generate_clock : process
  begin
    clock <= not clock;
    wait for CLOCK_PERIOD/2;
  end process; 
 
  -- Generate reset_n signal.
  generate_reset_n : process
  begin
    wait for 2 * CLOCK_PERIOD;
    reset_n <= '1';
    wait;
  end process;
  
  -- Generate reset_pulse_count signal.
  generate_reset_pulse_count : process
  begin
    -- Reset 4 times per encoder period value.
    wait for ((ENCODER_PERIOD_SWITCH_TIME / 4) - (CLOCK_PERIOD * 4));
    reset_pulse_count <= '1';
    wait for (CLOCK_PERIOD * 4);
    reset_pulse_count <= '0';
  end process;
  
  -- Generate enable signal.
  generate_enable : process
  begin
    -- Disable during third encoder period value approx. halfway between third
    -- and fourth pulse count resets.
    wait for ((ENCODER_PERIOD_SWITCH_TIME * (2 + 0.625)) - (CLOCK_PERIOD * 4));
    enable <= '0';
    wait for (CLOCK_PERIOD * 4);
    enable <= '1';
    wait for (ENCODER_PERIOD_SWITCH_TIME * 0.375);
    
    -- Disable during seventh encoder period value approx. halfway between
    -- first and second pulse count resets.
    wait for ((ENCODER_PERIOD_SWITCH_TIME * (3 + 0.625)) - (CLOCK_PERIOD * 4));
    enable <= '0';
    wait for (CLOCK_PERIOD * 4);
    enable <= '1';
    wait;
    
  end process;
  
  -- Generate encoder signal while setting the period of the encoder signal to
  -- different values over time by iterating through an array of constant
  -- periods.
  generate_encoder : process
  
  variable now_snapshot : time := now;
  
  begin
    for i in 0 to (NUM_OF_ENCODER_PERIODS - 1) loop
      now_snapshot := now;
      while now < (now_snapshot + ENCODER_PERIOD_SWITCH_TIME) loop
        encoder <= not encoder;
        wait for ENCODER_PERIODS(i)/2;
      end loop;
    end loop;
    wait;
  end process;
  
  -- Port map the design.
  uut : encoder_reader_top
  port map (
    reset_n_i             => reset_n,
    clock_i               => clock,
    enable_i              => enable,
    reset_pulse_count_i   => reset_pulse_count,
    encoder_i             => encoder,
    encoder_pulse_count_o => encoder_pulse_count
  );

end arch;