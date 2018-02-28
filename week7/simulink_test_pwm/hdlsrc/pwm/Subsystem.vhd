-- -------------------------------------------------------------
-- 
-- File Name: hdlsrc\pwm\Subsystem.vhd
-- Created: 2018-02-27 17:40:43
-- 
-- Generated by MATLAB 9.2 and HDL Coder 3.10
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Subsystem
-- Source Path: pwm/Subsystem
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Subsystem IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        period                            :   IN    std_logic_vector(26 DOWNTO 0);  -- ufix27
        duty                              :   IN    std_logic_vector(26 DOWNTO 0);  -- ufix27
        pwm_output                        :   OUT   std_logic
        );
END Subsystem;


ARCHITECTURE rtl OF Subsystem IS

  -- Signals
  SIGNAL period_unsigned                  : unsigned(26 DOWNTO 0);  -- ufix27
  SIGNAL slope1_out1                      : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL slope1_out1_dtc                  : unsigned(26 DOWNTO 0);  -- ufix27
  SIGNAL slope_out1                       : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL Sum_out1                         : unsigned(26 DOWNTO 0);  -- ufix27
  SIGNAL Relational_Operator_relop1       : std_logic;
  SIGNAL Switch_out1                      : unsigned(26 DOWNTO 0);  -- ufix27
  SIGNAL Unit_Delay_out1                  : unsigned(26 DOWNTO 0);  -- ufix27
  SIGNAL Sum_add_temp                     : unsigned(27 DOWNTO 0);  -- ufix28
  SIGNAL duty_unsigned                    : unsigned(26 DOWNTO 0);  -- ufix27
  SIGNAL Relational_Operator1_relop1      : std_logic;

BEGIN
  period_unsigned <= unsigned(period);

  slope1_out1 <= to_unsigned(16#000#, 10);

  slope1_out1_dtc <= resize(slope1_out1, 27);

  slope_out1 <= to_unsigned(16#001#, 10);

  
  Relational_Operator_relop1 <= '1' WHEN Sum_out1 /= period_unsigned ELSE
      '0';

  
  Switch_out1 <= slope1_out1_dtc WHEN Relational_Operator_relop1 = '0' ELSE
      Sum_out1;

  Unit_Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_out1 <= to_unsigned(16#0000000#, 27);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Unit_Delay_out1 <= Switch_out1;
      END IF;
    END IF;
  END PROCESS Unit_Delay_process;


  Sum_add_temp <= resize(Unit_Delay_out1, 28) + resize(slope_out1, 28);
  
  Sum_out1 <= "111111111111111111111111111" WHEN Sum_add_temp(27) /= '0' ELSE
      Sum_add_temp(26 DOWNTO 0);

  duty_unsigned <= unsigned(duty);

  
  Relational_Operator1_relop1 <= '1' WHEN Sum_out1 <= duty_unsigned ELSE
      '0';


  pwm_output <= Relational_Operator1_relop1;

END rtl;

