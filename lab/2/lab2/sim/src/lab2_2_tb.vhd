-------------------------------------------------------------------------------
-- Zachary Weeden
-- Lab2
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity lab2_2_tb is
end lab2_2_tb;

architecture arch of lab2_2_tb is

component lab2_2 is
  port (
    clk             : in  std_logic;
    reset           : in  std_logic;
    enable          : in  std_logic;
    period          : in  std_logic_vector(26 DOWNTO 0);
    duty            : in  std_logic_vector(26 DOWNTO 0);
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

-- port map the unit under test
uut1: lab2_2  
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable_sig,
    period    => "000000000000000001111101000",  --1000
    duty      => "000000000000000000000001010",  --100
    output    => sync
  );
end arch;