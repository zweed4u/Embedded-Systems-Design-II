-------------------------------------------------------------------------------
-- Bach Nguyen
-- PWM Generator Test Bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity pwm_generator_tb is
end pwm_generator_tb;

architecture arch of pwm_generator_tb is

  component pwm_generator is
    port (
      clk             : in std_logic;
      reset           : in std_logic;
      enable          : in std_logic;
      duty            : in std_logic_vector(26 downto 0);
      period          : in std_logic_vector(26 downto 0);
      output          : out std_logic
    );
  end component;

  constant clk_period   : time := 10 ns;
  signal clk            : std_logic := '0';
  signal reset          : std_logic := '1';
  
  -- time to change duty cycle in simulation, match the period going into UUT
  signal period_time    : time := 100 us;
  
  -- start with 0% duty
  signal duty           : std_logic_vector(26 downto 0) := (others => '0');
  signal period         : std_logic_vector(26 downto 0) := "000" & x"002710";
  signal enable         : std_logic := '1';
  signal output         : std_logic;

begin
  -- clock process
  clock: process
    begin
      clk <= not clk;
      wait for clk_period/2;
    end process;
  
  -- reset process
  async_reset: process
    begin
      wait for 2 * clk_period;
      reset <= '0';
      wait;
    end process;
  
  -- duty change process
  duty_change_percent: process
    begin
      -- wait for reset signal
      wait for 2 * clk_period;
      -- change duty after one period
      wait for period_time;
      -- 1% duty
      duty <= "000" & x"000064";
      wait for period_time;
      -- 10% duty
      duty <= "000" & x"0003E8";
      wait for period_time;
      -- 25% duty
      duty <= "000" & x"0009C4";
      wait for period_time;
      -- 50% duty
      duty <= "000" & x"001388";
      wait for period_time;
      -- 75% duty
      duty <= "000" & x"001D4C";
      wait for period_time;
      -- 90% duty
      duty <= "000" & x"002328";
      wait for period_time;
      -- 99% duty
      duty <= "000" & x"0026AC";
      wait for period_time;
      -- 100% duty
      duty <= "000" & x"002710";
      wait for period_time;
      -- set enable bit to LOW
      enable <= '0';
      wait;
    end process;
  
  -- UUT
  uut: pwm_generator
    port map(
      clk       => clk,
      reset     => reset,
      enable    => enable,
      duty      => duty,
      period    => period,
      output    => output
    );
    
end arch;