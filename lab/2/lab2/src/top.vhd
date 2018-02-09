-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic counter top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk              : in  std_logic; 
    reset            : in  std_logic;
    output           : out std_logic
  );
end top;

architecture beh of top is

component lab2 is
  generic (
    max_count        : integer range 0 to 100 := 3
  );
  port (
    clk              : in  std_logic; 
    reset            : in  std_logic;
    enable           : in  std_logic;
    pulse            : in  std_logic_vector(26 DOWNTO 0);
    duty             : in  std_logic_vector(26 DOWNTO 0);
    output           : out std_logic
  );  
end component;  

begin

uut: lab2  
  generic map (
    max_count => 10
  )
  port map(
    clk       => clk,
    reset     => reset,
    enable    => enable,
    pulse     => pulse,
    duty      => duty,
    output    => output
  );
end beh;