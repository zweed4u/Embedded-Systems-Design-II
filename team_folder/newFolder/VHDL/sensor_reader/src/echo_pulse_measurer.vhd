-- Peter Lodato
-- CPET 563-01: Embedded Systems Design II
-- Dr. Kaputa
-- Maze Rover Project
-- echo_pulse_measurer.vhd
-- Created Thurs 15 Mar 2018
-- Last modified Fri 16 Mar 2018

-- Reads the incoming echo pulse and measures its on length in clock cycles.
-- The number of clock cycles is then output to a math module to be converted
-- into millimeters.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity echo_pulse_measurer is
  port (
    reset_n_i           : in  std_logic;
    clock_i             : in  std_logic;
    enable_i            : in  std_logic;
    echo_pulse_i        : in  std_logic;
    echo_pulse_length_o : out std_logic_vector(21 downto 0)
  );
end echo_pulse_measurer;

architecture arch of echo_pulse_measurer is

signal enable        : std_logic;

signal echo_pulse_z  : std_logic;
signal echo_pulse_zz : std_logic;

signal rising_edge_  : std_logic;
signal falling_edge_ : std_logic;

begin
  
  -- Synchronize enable input signal to clock.
  register_enable : process (clock_i, reset_n_i)
  begin
    if (reset_n_i = '0') then
      enable <= '0';
      
    elsif (rising_edge(clock_i)) then
      enable <= enable_i;
    
    end if;
  end process;
  
  -- Detect rising and falling edges of incoming echo pulse signal.
  detect_edges : process (clock_i, reset_n_i)
  begin
    if (reset_n_i = '0') then
      echo_pulse_z  <= '0';
      echo_pulse_zz <= '0';
      
      rising_edge_  <= '0';
      falling_edge_ <= '0';
      
    elsif (rising_edge(clock_i)) then
      if (enable <= '1') then
        echo_pulse_z  <= echo_pulse_i;
        echo_pulse_zz <= echo_pulse_z;
        
        rising_edge_  <= echo_pulse_z and (not echo_pulse_zz);
        falling_edge_ <= (not echo_pulse_z) and echo_pulse_zz;
      
      else
        echo_pulse_z  <= '0';
        echo_pulse_zz <= '0';
        
        rising_edge_  <= '0';
        falling_edge_ <= '0';
      
      end if;
      
    end if;
  end process;
  
  count_pulse_length_state_machine : process (clock_i, reset_n_i)
  begin
  end process;
  
  -- Count the number of clock cycles the incoming echo pulse is on for.
  count_pulse_length : process (clock_i, reset_n_i)
  
  variable current_clock_count : integer := 0;
  
  begin
    if (reset_n_i = '0') then
      echo_pulse_length_o <= (sothers => '0');
      current_clock_count := 0;
    
    elsif (rising_edge(clock_i)) then
      if (enable = '1') then
        current_clock_count := current_clock_count + 1;
          
        else
          if (to_integer(unsigned(duty_cycle_z)) > 0) then
            trigger_pulse_o <= '1';
          else
            trigger_pulse_o <= '0';
          end if;
          current_clock_count := 1;
          
        end if;
      
      else
        trigger_pulse_o <= '0';
        current_clock_count := 0;
        
      end if;
    end if;
  end process;

  
end arch;