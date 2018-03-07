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

component blink is
  generic (
    max_count        : integer range 0 to 100 := 3
  );
  port (
    clk              : in  std_logic; 
    reset            : in  std_logic;
    output           : out std_logic
  );  
end component;  

begin

uut: blink  
  generic map (
    max_count => 10
  )
  port map(
    clk       => clk,
    reset     => reset,
    output    => output
  );
end beh;