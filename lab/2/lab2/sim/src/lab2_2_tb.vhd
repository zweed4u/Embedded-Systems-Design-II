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

signal clk            : std_logic := '0';
signal reset          : std_logic := '1';
signal enable_sig     : std_logic := '0';

signal zero_per        : std_logic;
signal one_per         : std_logic;
signal ten_per         : std_logic;
signal twentyfive_per  : std_logic;
signal fifty_per       : std_logic;
signal seventyfive_per : std_logic;
signal ninetynine_per  : std_logic;
signal hundred_per     : std_logic;

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
uut0: lab2_2  
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable_sig,
    period    => "000000000000000001111101000",  --1000
    duty      => "000000000000000000000000000",  --0
    output    => zero_per
  );

uut1: lab2_2  
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable_sig,
    period    => "000000000000000001111101000",  --1000
    duty      => "000000000000000000000001010",  --1
    output    => one_per
  );

uut2: lab2_2  
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable_sig,
    period    => "000000000000000001111101000",  --1000
    duty      => "000000000000000000001100100",  --100
    output    => ten_per
  );

uut3: lab2_2  
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable_sig,
    period    => "000000000000000001111101000",  --1000
    duty      => "000000000000000000011111010",  --250
    output    => twentyfive_per
  );

uut4: lab2_2  
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable_sig,
    period    => "000000000000000001111101000",  --1000
    duty      => "000000000000000000111110100",  --500
    output    => fifty_per
  ); 

  uut5: lab2_2  
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable_sig,
    period    => "000000000000000001111101000",  --1000
    duty      => "000000000000000001011101110",  --750
    output    => seventyfive_per
  );
  uut6: lab2_2  
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable_sig,
    period    => "000000000000000001111101000",  --1000
    duty      => "000000000000000001111011110",  --990
    output    => ninetynine_per
  );
  uut7: lab2_2  
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable_sig,
    period    => "000000000000000001111101000",  --1000
    duty      => "000000000000000001111101000",  --1000
    output    => hundred_per
  );
end arch;