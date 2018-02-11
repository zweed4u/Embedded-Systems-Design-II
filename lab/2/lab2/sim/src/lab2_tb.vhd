-------------------------------------------------------------------------------
-- Zachary Weeden
-- Lab2
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity lab2_tb is
end lab2_tb;

architecture arch of lab2_tb is

component lab2 is
  port (
    clk             : in  std_logic;
    reset           : in  std_logic;
    enable          : in  std_logic;
    output          : out std_logic
  );  
end component;  

constant tb_period  : time := 10ns;  -- 100MHz clock

signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal enable_sig   : std_logic := '0';
signal sync         : std_logic;

begin

-- clock process
clock: process
  begin
    clk <= not clk;
    wait for tb_period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * tb_period;
    reset <= '0';
    wait;
end process; 

-- enable process
enable: process
  begin
    wait for tb_period/2;
    enable_sig <= '1';
end process; 

-- Adjust duty cycle and period (PWM testing)
uut1: lab2  
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable_sig,
    output    => sync
  );
end arch;