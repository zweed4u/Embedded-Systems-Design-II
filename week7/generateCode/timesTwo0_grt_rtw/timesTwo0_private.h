/*
 * timesTwo0_private.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "timesTwo0".
 *
 * Model version              : 1.10
 * Simulink Coder version : 8.10 (R2016a) 10-Feb-2016
 * C source code generated on : Tue Feb 28 08:31:11 2017
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Atmel->AVR
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_timesTwo0_private_h_
#define RTW_HEADER_timesTwo0_private_h_
#include "rtwtypes.h"
#include "builtin_typeid_types.h"
#include "multiword_types.h"

/* Private macros used by the generated code to access rtModel */
#ifndef rtmSetTFinal
# define rtmSetTFinal(rtm, val)        ((rtm)->Timing.tFinal = (val))
#endif

#ifndef rtmGetTPtr
# define rtmGetTPtr(rtm)               (&(rtm)->Timing.taskTime0)
#endif

/* Imported (extern) block signals */
extern real_T dataIn;                  /* '<Root>/In' */

/* Imported (extern) block parameters */
extern real_T multiplier;              /* Variable: multiplier
                                        * Referenced by: '<S1>/Gain'
                                        */

#endif                                 /* RTW_HEADER_timesTwo0_private_h_ */
