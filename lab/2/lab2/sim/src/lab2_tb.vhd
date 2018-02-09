-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic counter test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity lab2_tb is
end lab2_tb;

architecture arch of lab2_tb is

component lab2 is
  generic (
    max_count       : integer range 0 to 100000000 := 3
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
end component;  

signal sync1        : std_logic;
signal sync2        : std_logic;
constant period     : time := 20ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';

begin

-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
end process; 

uut1: lab2  
  generic map (
    max_count => 25000000
  )
  port map(
    clk       => clk,
    reset     => reset,
    output    => sync1
  );
  
uut2: lab2  
  generic map (
    max_count => 19 -- 1=40, 2=60, .., 4=100 ((n+1)*20) 50% with this as ns high
  )
  port map(
    clk       => clk,
    reset     => reset,
    output    => sync2
  );
end arch;