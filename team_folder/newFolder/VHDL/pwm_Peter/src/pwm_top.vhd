-- Peter Lodato
-- CPET 563-01: Embedded Systems Design II
-- Dr. Kaputa
-- Lab 2
-- pwm_top.vhd
-- Created Tues 13 Feb 2018
-- Last modified Tues 27 Feb 2018

-- Accepts a period and duty cycle and outputs an according PWM pulse train.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity pwm_top is
  port (
    reset_n_i    : in std_logic;
    clock_i      : in std_logic;
    enable_i     : in std_logic;
    period_i     : in std_logic_vector(6 downto 0);
    duty_cycle_i : in std_logic_vector(9 downto 0);
    pwm_o        : out std_logic
  );
end pwm_top;

architecture arch of pwm_top is

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

signal period_z         : std_logic_vector(6 downto 0);
signal duty_cycle_z     : std_logic_vector(9 downto 0);
signal reg_trigger      : std_logic;
signal valid_period     : std_logic;
signal valid_duty_cycle : std_logic;
signal enable           : std_logic;

begin
  
  -- Register the period_i signal.
  reg_period : process (clock_i, reg_trigger, reset_n_i)
  begin
    if (reset_n_i = '0') then
      period_z     <= (others => '0');
      valid_period <= '0';
      
    elsif (rising_edge(clock_i)) then
      if ((to_integer(unsigned(period_i)) >= MIN_PERIOD) and
          (to_integer(unsigned(period_i)) <= MAX_PERIOD)) then
        period_z     <= period_i;
        valid_period <= '1';
      
      else
        period_z     <= (others => '0');
        valid_period <= '0';
        
      end if;
      
    end if;
  end process;
  
  -- Register the duty_cycle_i signal.
  reg_duty_cycle : process (clock_i, reg_trigger, reset_n_i)
  begin
    if (reset_n_i = '0') then
      duty_cycle_z     <= (others => '0');
      valid_duty_cycle <= '0';
      
    elsif (rising_edge(clock_i)) then
      if ((to_integer(unsigned(duty_cycle_i)) >= MIN_DUTY_CYCLE) and
          (to_integer(unsigned(duty_cycle_i)) <= MAX_DUTY_CYCLE)) then
        duty_cycle_z     <= duty_cycle_i;
        valid_duty_cycle <= '1';
      
      else
        duty_cycle_z     <= (others => '0');
        valid_duty_cycle <= '0';
        
      end if;
      
    end if;
  end process;
  
  -- AND all three enables together synchronously.
  generate_enable : process (clock_i, reset_n_i)
  begin
    if (reset_n_i = '0') then
      enable <= '0';
      
    elsif (rising_edge(clock_i)) then
      enable <= enable_i         and
                valid_period     and
                valid_duty_cycle;
              
    end if;
  end process;
  
  -- Generate PWM wave form based on registered period and duty cycle.
  generate_pwm : process (clock_i, reset_n_i)
  
  variable current_clock_count : integer := 0;
  variable max_clock_count     : integer := 0;
  variable max_on_clock_count  : integer := 0;
  
  begin
    if (reset_n_i = '0') then
      pwm_o <= '0';
	  current_clock_count := 0;
    
    elsif (rising_edge(clock_i)) then
      if (enable = '1') then
        max_clock_count    := to_integer(unsigned(period_z)) *
                              CLOCKS_PER_MIN_PERIOD;
        
        max_on_clock_count := (max_clock_count *
                               to_integer(unsigned(duty_cycle_z))) / 1000;
        
        if (current_clock_count < max_clock_count) then
          if (current_clock_count < max_on_clock_count) then
            pwm_o <= '1';
          else
            pwm_o <= '0';
          end if;
          
          current_clock_count := current_clock_count + 1;
          
        else
          if (to_integer(unsigned(duty_cycle_z)) > 0) then
            pwm_o <= '1';
          else
            pwm_o <= '0';
          end if;
          current_clock_count := 1;
          
        end if;
      
      else
        pwm_o <= '0';
        current_clock_count := 0;
        
      end if;
    end if;
    
  end process;
  
end arch;
