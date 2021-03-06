-- -------------------------------------------------------------
-- 
-- File Name: hdlsrc\pwm\timesTwo.vhd
-- Created: 2017-02-28 13:54:21
-- 
-- Generated by MATLAB 9.0 and HDL Coder 3.8
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 0.1
-- Target subsystem base rate: 0.1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: timesTwo
-- Source Path: pwm/timesTwo
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY timesTwo IS
  PORT( In_rsvd                           :   IN    real;  -- double
        out_rsvd                          :   OUT   real  -- double
        );
END timesTwo;


ARCHITECTURE rtl OF timesTwo IS

  -- Signals
  SIGNAL dataOut                          : real := 0.0;  -- double

BEGIN
  dataOut <= 2.0 * In_rsvd;

  out_rsvd <= dataOut;

END rtl;

