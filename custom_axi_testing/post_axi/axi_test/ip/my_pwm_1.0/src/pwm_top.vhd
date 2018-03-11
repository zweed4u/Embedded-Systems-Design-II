-------------------------------------------------------------------------------
-- Zachary Weeden
-- Lab2
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity pwm_top is
  port (
    clk              : in  std_logic; 
    reset            : in  std_logic;
    enable           : in  std_logic;
    period           : in  std_logic_vector(26 DOWNTO 0);
    duty             : in  std_logic_vector(26 DOWNTO 0);
    pwm_output           : out std_logic
  );
end pwm_top;

architecture beh of pwm_top is

component pwm is
  port (
    clk              : in  std_logic; 
    reset            : in  std_logic;
    enable           : in  std_logic;
    period           : in  std_logic_vector(26 DOWNTO 0);
    duty             : in  std_logic_vector(26 DOWNTO 0);
    pwm_output           : out std_logic
  );  
end component;  

begin

uut: pwm
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable,
    period    => period,
    duty      => duty,
    pwm_output    => pwm_output
  );
end beh;