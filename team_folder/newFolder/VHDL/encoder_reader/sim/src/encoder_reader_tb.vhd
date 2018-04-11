-- Peter Lodato
-- CPET 563-01: Embedded Systems Design II
-- Dr. Kaputa
-- Maze Rover Project
-- encoder_reader_tb.vhd
-- Created Tues 10 Apr 2018
-- Last modified Tues 10 Apr 2018

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

-- Designed for 100 MHz clock (period = 10 ns).
constant period     : time := 10ns;

-- Period goes from 10 us to 1,000 us (1 ms) in 10 us increments and decrements.
-- The unsigned value in period_i goes from 1 to 100.
-- Period in us = period_i * 10.
-- Period in seconds = period_i / 100,000.
-- Clocks per min period = 10 us / 10 ns = 1,000 (designed for 100 MHz clock).
-- Duty cycle goes from 0% - 100.0% with 0.1% increments and decrements.
-- The unsigned value in duty_cycle_i goes from 0 to 1,000.
-- Duty cycle in percent = duty_cycle_i / 10.
-- Duty cycle as decimal = duty_cycle_i / 1,000.
constant MAX_PERIOD            : integer := 100;
constant MIN_PERIOD            : integer := 1;
constant CLOCKS_PER_MIN_PERIOD : integer := 1000;
constant MIN_DUTY_CYCLE        : integer := 0;
constant MAX_DUTY_CYCLE        : integer := 1000;

signal pwm_period     : std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(25, 7));
signal pwm_duty_cycle : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(327, 10));

signal reset_n      : std_logic := '0';
signal clock        : std_logic := '0';
signal enable       : std_logic := '1';                                            

signal pwm : std_logic;

begin

  -- Clock generation process.
  generate_clock : process
  begin
    clock <= not clock;
    wait for period/2;
  end process; 
 
  -- Reset generation process.
  generate_async_reset_n : process
  begin
    wait for 2 * period;
    reset_n <= '1';
    wait;
  end process;

  -- Period value generation process.
  generate_pwm_period : process
  begin
  
    -- Period = 250 us, duty cycle = 32.7%.
    wait for (((CLOCKS_PER_MIN_PERIOD * 25) * 4) + 4) * period;

    -- Period = 860 us, duty cycle = 94.5%.
    pwm_period <= std_logic_vector(to_unsigned(86, pwm_period'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 86) * 4) * period;
    
    -- Period = 10 us, duty cycle = 50.0%.
    pwm_period <= std_logic_vector(to_unsigned(1, pwm_period'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 1) * 4) * period;
    
    -- Period = 1,000 us (1 ms), duty cycle = 50.0%.
    pwm_period <= std_logic_vector(to_unsigned(100, pwm_period'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 100) * 4) * period;
    
    -- Period = 50 us, duty cycle = 0%.
    -- Period = 50 us, duty cycle = 0.1%.
    -- Period = 50 us, duty cycle = 99.9%.
    -- Period = 50 us, duty cycle = 100.0%.
    pwm_period <= std_logic_vector(to_unsigned(5, pwm_period'length));
    wait for (((CLOCKS_PER_MIN_PERIOD * 50) * 4) * 4) * period;
    
    -- Period = 1,200 us (1.2 ms) (INVALID PERIOD), duty cycle = 50.0%.
    pwm_period <= std_logic_vector(to_unsigned(120, pwm_period'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 1200) * 4) * period;
    
    -- Period = 0 us (INVALID PERIOD), duty cycle = 50.0%.
    pwm_period <= std_logic_vector(to_unsigned(0, pwm_period'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 10) * 4) * period;
    
    -- Period = 50 us, duty cycle = 102.1% (INVALID DUTY CYCLE).
    pwm_period <= std_logic_vector(to_unsigned(5, pwm_period'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 50) * 4) * period;
    
    -- Period = 140 us, duty cycle = 22.1%.
    pwm_period <= std_logic_vector(to_unsigned(14, pwm_period'length));
    wait;
    
  end process;

  -- Duty cycle value generation process.
  generate_pwm_duty_cycle : process
  begin
  
    -- Period = 250 us, duty cycle = 32.7%.
    wait for (((CLOCKS_PER_MIN_PERIOD * 25) * 4) + 4) * period;
    
    -- Period = 860 us, duty cycle = 94.5%.
    pwm_duty_cycle <= std_logic_vector(to_unsigned(945, pwm_duty_cycle'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 86) * 4) * period;
    
    -- Period = 10 us, duty cycle = 50.0%.
    -- Period = 1,000 us (1 ms), duty cycle = 50.0%.
    pwm_duty_cycle <= std_logic_vector(to_unsigned(500, pwm_duty_cycle'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * (1 + 100)) * 4) * period;
    
    -- Period = 50 us, duty cycle = 0%.
    pwm_duty_cycle <= std_logic_vector(to_unsigned(0, pwm_duty_cycle'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 50) * 4) * period;
    
    -- Period = 50 us, duty cycle = 0.1%.
    pwm_duty_cycle <= std_logic_vector(to_unsigned(1, pwm_duty_cycle'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 50) * 4) * period;
    
    -- Period = 50 us, duty cycle = 99.9%.
    pwm_duty_cycle <= std_logic_vector(to_unsigned(999, pwm_duty_cycle'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 50) * 4) * period;
    
    -- Period = 50 us, duty cycle = 100.0%.
    pwm_duty_cycle <= std_logic_vector(to_unsigned(1000, pwm_duty_cycle'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 50) * 4) * period;
    
    -- Period = 1,200 us (1.2 ms) (INVALID PERIOD), duty cycle = 50.0%.
    -- Period = 0 us (INVALID PERIOD), duty cycle = 50.0%.
    pwm_duty_cycle <= std_logic_vector(to_unsigned(500, pwm_duty_cycle'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * (1200 + 10)) * 4) * period;
    
    -- Period = 50 us, duty cycle = 102.1% (INVALID DUTY CYCLE).
    pwm_duty_cycle <= std_logic_vector(to_unsigned(1021, pwm_duty_cycle'length));
    wait for ((CLOCKS_PER_MIN_PERIOD * 50) * 4) * period;
    
    -- Period = 140 us, duty cycle = 22.1%.
    pwm_duty_cycle <= std_logic_vector(to_unsigned(221, pwm_duty_cycle'length));
    wait;
    
  end process;
  
  -- Generate enable signal (always on until last test)
  generate_enable : process
  begin
    wait for (((CLOCKS_PER_MIN_PERIOD * 25) * 4) + 2) * period;
    wait for ((CLOCKS_PER_MIN_PERIOD * 86) * 4) * period;
    wait for ((CLOCKS_PER_MIN_PERIOD * (1 + 100)) * 4) * period;
    wait for (((CLOCKS_PER_MIN_PERIOD * 50) * 4) * 4) * period;
    wait for ((CLOCKS_PER_MIN_PERIOD * (1200 + 10)) * 4) * period;
    wait for ((CLOCKS_PER_MIN_PERIOD * 50) * 4) * period;
    wait for ((CLOCKS_PER_MIN_PERIOD * 140) * 3) * period;
    enable <= '0';
    wait for (CLOCKS_PER_MIN_PERIOD * 140) * period;
    enable <= '1';
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