-------------------------------------------------------------------------------
-- Zachary Weeden
-- Lab2
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity lab2 is
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

signal count_sig    : integer range 0 to clk_freq := 0;  --up to one second (clk_freq/1sec = clk_freq)
signal output_sig   : std_logic;
signal enable_sig   : std_logic;

begin
process(clk,reset)
  variable period     : std_logic_vector(26 DOWNTO 0) := "000000000000000001111101000";  -- 1000 (1KHz)
  --variable duty       : std_logic_vector(26 DOWNTO 0) := "000000000000000000111110100";  -- must be less than, equal to period (500 HZ) 50%
  --variable duty       : std_logic_vector(26 DOWNTO 0) := "000000000000000001111101000";  -- 1KHz 100%
  --variable duty       : std_logic_vector(26 DOWNTO 0) := (others => '0');  -- 0Hz 0%
  variable duty       : std_logic_vector(26 DOWNTO 0) := "000000000000000000001100100"; -- 100Hz 10%

  variable period_ticks      : integer := clk_freq/to_integer(unsigned(period));  -- how many tick counts needed at clock frequency to yield the desired period

  variable duty_ticks : integer := period_ticks/(to_integer(unsigned(period))/to_integer(unsigned(duty)));  -- how many counts needed at the clock frequency to yield the desired duty

  begin
    if (reset = '1') then 
      count_sig <= 0;
      output_sig <= '0';

    elsif (clk'event and clk = '1') then
      if (enable_sig = '1') then

        -- Set output high while within the duty
        if (count_sig <= duty_ticks) then  -- ticks are within the duty
          output_sig <= '1';
        else
          output_sig <= '0';
        end if;

        -- Period ticks have been hit - flip and restart pulse
        if (count_sig = period_ticks) then
          count_sig <= 0;
          output_sig <= not output_sig;
        else
          count_sig <= count_sig + 1;
        end if;

      end if;
    end if;
  end process;
  enable_sig <= enable;
  output <= output_sig; -- & enable
end beh;