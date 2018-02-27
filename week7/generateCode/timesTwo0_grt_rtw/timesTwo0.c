/*
 * timesTwo0.c
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

#include "timesTwo0.h"
#include "timesTwo0_private.h"

/* Exported block signals */
real_T dataOut;                        /* '<S1>/Gain' */

/* External outputs (root outports fed by signals with auto storage) */
ExtY_timesTwo0_T timesTwo0_Y;

/* Real-time model */
RT_MODEL_timesTwo0_T timesTwo0_M_;
RT_MODEL_timesTwo0_T *const timesTwo0_M = &timesTwo0_M_;

/* Model step function */
void timesTwo0_step(void)
{
  /* Gain: '<S1>/Gain' incorporates:
   *  Inport: '<Root>/In'
   */
  dataOut = multiplier * dataIn;

  /* Outport: '<Root>/out' */
  timesTwo0_Y.out = dataOut;

  /* Matfile logging */
  rt_UpdateTXYLogVars(timesTwo0_M->rtwLogInfo, (&timesTwo0_M->Timing.taskTime0));

  /* signal main to stop simulation */
  {                                    /* Sample time: [0.1s, 0.0s] */
    if ((rtmGetTFinal(timesTwo0_M)!=-1) &&
        !((rtmGetTFinal(timesTwo0_M)-timesTwo0_M->Timing.taskTime0) >
          timesTwo0_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(timesTwo0_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++timesTwo0_M->Timing.clockTick0)) {
    ++timesTwo0_M->Timing.clockTickH0;
  }

  timesTwo0_M->Timing.taskTime0 = timesTwo0_M->Timing.clockTick0 *
    timesTwo0_M->Timing.stepSize0 + timesTwo0_M->Timing.clockTickH0 *
    timesTwo0_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void timesTwo0_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)timesTwo0_M, 0,
                sizeof(RT_MODEL_timesTwo0_T));
  rtmSetTFinal(timesTwo0_M, -1);
  timesTwo0_M->Timing.stepSize0 = 0.1;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = NULL;
    timesTwo0_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(timesTwo0_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(timesTwo0_M->rtwLogInfo, (NULL));
    rtliSetLogT(timesTwo0_M->rtwLogInfo, "tout");
    rtliSetLogX(timesTwo0_M->rtwLogInfo, "");
    rtliSetLogXFinal(timesTwo0_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(timesTwo0_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(timesTwo0_M->rtwLogInfo, 4);
    rtliSetLogMaxRows(timesTwo0_M->rtwLogInfo, 0);
    rtliSetLogDecimation(timesTwo0_M->rtwLogInfo, 1);
    rtliSetLogY(timesTwo0_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(timesTwo0_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(timesTwo0_M->rtwLogInfo, (NULL));
  }

  /* block I/O */

  /* exported global signals */
  dataOut = 0.0;

  /* external outputs */
  timesTwo0_Y.out = 0.0;

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(timesTwo0_M->rtwLogInfo, 0.0, rtmGetTFinal
    (timesTwo0_M), timesTwo0_M->Timing.stepSize0, (&rtmGetErrorStatus
    (timesTwo0_M)));
}

/* Model terminate function */
void timesTwo0_terminate(void)
{
  /* (no terminate code required) */
}
