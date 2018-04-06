-- Peter Lodato
-- CPET 563-01: Embedded Systems Design II
-- Dr. Kaputa
-- Maze Rover Project
-- distance_calculator.vhd
-- Created Mon 19 Mar 2018
-- Last modified Mon 19 Mar 2018

-- Calculates the distance a sensor is from a wall based on the length in clock
-- cycles of the echo pulse received by the sensor and formulas provided by the
-- sensor's data sheet. Data will be output as m, mm, cm, or in.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity distance_calculator is
  port (
    reset_n_i           : in  std_logic;
    clock_i             : in  std_logic;
    enable_i            : in  std_logic;
    echo_pulse_length_i : in  std_logic_vector(9 downto 0);
    calc_finished_o     : out std_logic;
    distance_o          : out std_logic_vector(9 downto 0)
  );
end distance_calculator;

-- In