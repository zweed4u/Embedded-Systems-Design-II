-------------------------------------------------------------------------------
-- Zachary Weeden
-- Lab2
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity lab2_2 is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    enable          : in  std_logic;
    period          : in  std_logic_vector(26 DOWNTO 0);
    duty            : in  std_logic_vector(26 DOWNTO 0);
    output          : out std_logic  -- pulse train
  );
end lab2_2;

architecture beh of lab2_2  is

constant clk_freq   : integer := 100000000;  -- 100MHz
constant clk_period : time := 10 ns;

signal count_sig    : integer range 0 to clk_freq := 0;  --up to one second (clk_freq/1sec = clk_freq)
signal output_sig   : std_logic;
signal enable_sig   : std_logic;

begin
process(clk,reset)
  constant zero_duty    : std_logic_vector(duty'range) := (others => '0');
  variable period_ticks : integer := clk_freq/to_integer(unsigned(period));  -- how many tick counts needed at clock frequency to yield the desired period
  begin
    if (reset = '1') then 
      count_sig <= 0;
      output_sig <= '0';
    elsif (clk'event and clk = '1') then
      if (enable_sig = '1') then
        if (period = duty) then
          output_sig <= '1';
        elsif (duty = zero_duty) then
          output_sig <= '0';
        else
          -- Set output high while within the duty
          if (count_sig <= (period_ticks/(to_integer(unsigned(period))/to_integer(unsigned(duty))))) then  -- ticks are within the number of ticks for the duty (duty_ticks)
            output_sig <= '1';
          else
            output_sig <= '0';
          end if;
          -- Period ticks have been hit - flip and restart pulse
          if (count_sig = period_ticks) then
            count_sig <= 0;
            -- Need conditional for 0% and 100% edge cases
            output_sig <= not output_sig;
          else
            count_sig <= count_sig + 1;
          end if;
        end if;
      end if;
    end if;
  end process;
  enable_sig <= enable;
  output <= output_sig; -- & enable
end beh;