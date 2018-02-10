-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic counter demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity lab2 is
  generic (
    max_count       : integer range 0 to 100000000 := 3
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    enable          : in  std_logic;
    output          : out std_logic  -- pulse train
  );  
end lab2;  

architecture beh of lab2  is

constant clk_freq   : integer := 100000000;  -- 100MHz
constant clk_period : time := 10 ns;

variable period     : std_logic_vector(26 DOWNTO 0) := x"3E8";  -- 1000 (1KHz)
variable duty       : std_logic_vector(26 DOWNTO 0) := x"1F4";  -- must be less than, equal to period (500 HZ) 50%
variable duty_cycle : integer := to_integer(unsigned(duty))/to_integer(unsigned(period));  -- duty cycle of user given inputs

-- 100,000
variable ticks      : integer := clk_freq/to_integer(unsigned(period));  -- how many counts needed at clock frequency to yield the desired period

-- 50,000
variable duty_ticks : integer := ticks*duty_cycle;  -- how many counts needed at the clock frequency to yield the desired duty



signal count_sig    : integer range 0 to max_count := 0;
signal output_sig   : std_logic;
signal enable_sig   : std_logic;

begin
process(clk,reset)
  begin
    if (reset = '1') then 
      count_sig <= 0;
      output_sig <= '0';
    elsif (clk'event and clk = '1') then
      if (enable_sig = '1') then

        -- Set output high while within the duty
        if (count_sig <= duty_ticks) then  -- clock counts are within the number of duty
          output_sig <= 1;
        else
          output_sig <= 0;
        end if;

        -- Flip when period hit
        if (count_sig = ticks) then  -- clock has counted the number of ticks to yield the user specified period
          count_sig <= 0;
          --output_sig <= not output_sig;
        else
          count_sig <= count_sig + 1;
        end if; 

      end if;
    end if;
  end process;
  enable_sig <= enable;
  output <= output_sig; -- & enable
end beh;