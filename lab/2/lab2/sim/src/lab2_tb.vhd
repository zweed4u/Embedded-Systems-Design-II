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
    enable          : in  std_logic;
    output          : out std_logic
  );  
end component;  

constant tb_period  : time := 20ns;

signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal enable       : std_logic := '0';
signal period       : std_logic_vector(26 DOWNTO 0) := (OTHERS => '0');  -- zeroed out
signal duty         : std_logic_vector(26 DOWNTO 0) := (OTHERS => '0');  -- zeroed out
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
    enable <= not enable;
end process; 

-- Adjust duty cycle and period (PWM testing)
uut1: lab2  
  generic map (
    max_count => 19 -- 1=40, 2=60, .., 4=100 ((n+1)*20) 50% with this as ns high
  )
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable,
    output    => sync
  );
end arch;