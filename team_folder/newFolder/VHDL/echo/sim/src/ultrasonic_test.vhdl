library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ultrasonic_test is
port
(
  reset_n_i : in std_logic;
  clock_i : in std_logic;
  ticks_i : in integer;
  trigger_i : in std_logic;
  echo_o : out std_logic
);
end ultrasonic_test;

architecture behavioral of ultrasonic_test is

type sensor_state is (IDLE, TRIGGERED, ECHO);

signal present_state : sensor_state := IDLE;
signal next_state : sensor_state := IDLE;

signal ticks : integer := 0;
signal wait_time: integer := 0;

signal echo_on : std_logic := '0';

begin

machine : process(reset_n_i, clock_i)
begin
  if(reset_n_i = '0') then
    present_state <= IDLE;
    next_state <= IDLE;
  elsif(rising_edge(clock_i)) then
    if(trigger_i = '1' and present_state = IDLE) then
      next_state <= TRIGGERED;
    elsif(present_state = TRIGGERED and wait_time = 0) then
      next_state <= ECHO;
    elsif(present_state = ECHO and ticks = 0) then
      next_state <= IDLE;
    end if;
    present_state <= next_state;
  end if;
end process;

output_driver : process(reset_n_i, clock_i)
begin
  if(reset_n_i = '0') then
    ticks <= 0;
    wait_time <= 1;
    echo_on <= '0';
  elsif(rising_edge(clock_i)) then
    if(present_state = IDLE) then
      echo_on <= '0';
      ticks <= ticks_i;
      wait_time <= 6000000 - ticks_i;
    elsif(present_state = TRIGGERED) then
      wait_time <= wait_time - 1;
      ticks <= ticks;
      echo_on <= '0';
    elsif(present_state = ECHO) then
      echo_on <= '1';
      ticks <= ticks - 1;
      wait_time <= 1;
	end if;
  end if;
end process;

echo_o <= echo_on;

end behavioral;