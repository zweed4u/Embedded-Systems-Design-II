/*
 * pwm.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "pwm".
 *
 * Model version              : 1.16
 * Simulink Coder version : 8.12 (R2017a) 16-Feb-2017
 * C source code generated on : Tue Feb 27 17:37:34 2018
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "pwm.h"
#include "pwm_private.h"

/* Block states (auto storage) */
DW_pwm_T pwm_DW;

/* Real-time model */
RT_MODEL_pwm_T pwm_M_;
RT_MODEL_pwm_T *const pwm_M = &pwm_M_;

/* Model step function */
void pwm_step(void)
{
  /* local block i/o variables */
  uint32_T rtb_Sum;
  boolean_T rtb_RelationalOperator1;
  uint32_T tmp;

  /* Sum: '<S1>/Sum' incorporates:
   *  Constant: '<S1>/slope'
   *  UnitDelay: '<S1>/Unit Delay'
   */
  tmp = pwm_DW.UnitDelay_DSTATE + pwm_P.slope_Value;
  if (tmp > 134217727U) {
    tmp = 134217727U;
  }

  rtb_Sum = tmp;

  /* End of Sum: '<S1>/Sum' */

  /* RelationalOperator: '<S1>/Relational Operator1' incorporates:
   *  Constant: '<Root>/duty '
   */
  rtb_RelationalOperator1 = (rtb_Sum <= pwm_P.duty_Value);

  /* Switch: '<S1>/Switch' incorporates:
   *  Constant: '<Root>/period'
   *  RelationalOperator: '<S1>/Relational Operator'
   */
  if (rtb_Sum != pwm_P.period_Value) {
    /* Update for UnitDelay: '<S1>/Unit Delay' */
    pwm_DW.UnitDelay_DSTATE = rtb_Sum;
  } else {
    /* Update for UnitDelay: '<S1>/Unit Delay' incorporates:
     *  Constant: '<S1>/slope1'
     */
    pwm_DW.UnitDelay_DSTATE = pwm_P.slope1_Value;
  }

  /* End of Switch: '<S1>/Switch' */

  /* Matfile logging */
  rt_UpdateTXYLogVars(pwm_M->rtwLogInfo, (&pwm_M->Timing.taskTime0));

  /* signal main to stop simulation */
  {                                    /* Sample time: [1.0E-8s, 0.0s] */
    if ((rtmGetTFinal(pwm_M)!=-1) &&
        !((rtmGetTFinal(pwm_M)-pwm_M->Timing.taskTime0) >
          pwm_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(pwm_M, "Simulation finished");
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
  if (!(++pwm_M->Timing.clockTick0)) {
    ++pwm_M->Timing.clockTickH0;
  }

  pwm_M->Timing.taskTime0 = pwm_M->Timing.clockTick0 * pwm_M->Timing.stepSize0 +
    pwm_M->Timing.clockTickH0 * pwm_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void pwm_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)pwm_M, 0,
                sizeof(RT_MODEL_pwm_T));
  rtmSetTFinal(pwm_M, 1.0E-5);
  pwm_M->Timing.stepSize0 = 1.0E-8;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = NULL;
    pwm_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(pwm_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(pwm_M->rtwLogInfo, (NULL));
    rtliSetLogT(pwm_M->rtwLogInfo, "tout");
    rtliSetLogX(pwm_M->rtwLogInfo, "");
    rtliSetLogXFinal(pwm_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(pwm_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(pwm_M->rtwLogInfo, 4);
    rtliSetLogMaxRows(pwm_M->rtwLogInfo, 0);
    rtliSetLogDecimation(pwm_M->rtwLogInfo, 1);
    rtliSetLogY(pwm_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(pwm_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(pwm_M->rtwLogInfo, (NULL));
  }

  /* states (dwork) */
  (void) memset((void *)&pwm_DW, 0,
                sizeof(DW_pwm_T));

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(pwm_M->rtwLogInfo, 0.0, rtmGetTFinal(pwm_M),
    pwm_M->Timing.stepSize0, (&rtmGetErrorStatus(pwm_M)));

  /* InitializeConditions for UnitDelay: '<S1>/Unit Delay' */
  pwm_DW.UnitDelay_DSTATE = pwm_P.UnitDelay_InitialCondition;
}

/* Model terminate function */
void pwm_terminate(void)
{
  /* (no terminate code required) */
}
