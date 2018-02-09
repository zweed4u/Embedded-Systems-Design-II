-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic counter demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity lab2 is
  generic (
    max_count       : integer range 0 to 100000000 := 3
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    enable           : in  std_logic;
    pulse            : in  std_logic_vector(26 DOWNTO 0);
    duty             : in  std_logic_vector(26 DOWNTO 0);
    output          : out std_logic
  );  
end lab2;  

architecture beh of lab2  is

signal count_sig    : integer range 0 to max_count := 0;
signal output_sig   : std_logic;
signal pulse_sig    : std_logic_vector;
signal duty_sig     : std_logic_vector;
signal enable_sig   : std_logic;

begin
process(clk,reset)
  begin
    if (reset = '1') then 
      count_sig <= 0;
      output_sig <= '0';
    elsif (clk'event and clk = '1') then
      if (count_sig = max_count) then
        count_sig <= 0;
        output_sig <= not output_sig;
      else
        count_sig <= count_sig + 1;
      end if; 
    end if;
  end process;
  output <= output_sig; -- & enable
end beh;