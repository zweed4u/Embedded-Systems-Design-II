-------------------------------------------------------------------------------
-- Bach Nguyen
-- PWM Generator
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pwm_generator is
  port (
    clk             : in std_logic;
    reset           : in std_logic;
    enable          : in std_logic;
    duty            : in std_logic_vector(26 downto 0);
    period          : in std_logic_vector(26 downto 0);
    output          : out std_logic
  );
end pwm_generator;

architecture beh of pwm_generator is

  -- 27-bit signal to reach 1 sec period with 100 Mhz clock
  signal count_sig    : std_logic_vector(26 downto 0) := (others => '0');
  signal output_sig   : std_logic;

begin
  process(clk, reset)
    begin
      if (reset = '1') then
        count_sig <= (others => '0');
        output_sig <= '0';
      elsif (clk'event and clk = '1') then
        -- output goes to HIGH when clock hits period
        if (count_sig = period) then
          count_sig <= (others => '0');
          output_sig <= '1';
        -- output goes to LOW when clock hits duty
        elsif (count_sig = duty) then
          count_sig <= count_sig + 1;
          output_sig <= '0';
        else
          count_sig <= count_sig + 1;
          output_sig <= output_sig;
        end if;
      end if;
    end process;
  
  -- output is active only when enable is HIGH
  output <= output_sig and enable;
  
end beh;