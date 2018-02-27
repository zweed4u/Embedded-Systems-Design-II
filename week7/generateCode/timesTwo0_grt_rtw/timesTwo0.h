/*
 * timesTwo0.h
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

#ifndef RTW_HEADER_timesTwo0_h_
#define RTW_HEADER_timesTwo0_h_
#include <float.h>
#include <string.h>
#include <stddef.h>
#ifndef timesTwo0_COMMON_INCLUDES_
# define timesTwo0_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "rt_logging.h"
#endif                                 /* timesTwo0_COMMON_INCLUDES_ */

#include "timesTwo0_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_nonfinite.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetFinalTime
# define rtmGetFinalTime(rtm)          ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWLogInfo
# define rtmGetRTWLogInfo(rtm)         ((rtm)->rtwLogInfo)
#endif

#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  ((rtm)->Timing.taskTime0)
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             ((rtm)->Timing.tFinal)
#endif

/* External outputs (root outports fed by signals with auto storage) */
typedef struct {
  real_T out;                          /* '<Root>/out' */
} ExtY_timesTwo0_T;

/* Real-time Model Data Structure */
struct tag_RTM_timesTwo0_T {
  const char_T *errorStatus;
  RTWLogInfo *rtwLogInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

/* External outputs (root outports fed by signals with auto storage) */
extern ExtY_timesTwo0_T timesTwo0_Y;

/*
 * Exported Global Signals
 *
 * Note: Exported global signals are block signals with an exported global
 * storage class designation.  Code generation will declare the memory for
 * these signals and export their symbols.
 *
 */
extern real_T dataOut;                 /* '<S1>/Gain' */

/* Model entry point functions */
extern void timesTwo0_initialize(void);
extern void timesTwo0_step(void);
extern void timesTwo0_terminate(void);

/* Real-time Model object */
extern RT_MODEL_timesTwo0_T *const timesTwo0_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Note that this particular code originates from a subsystem build,
 * and has its own system numbers different from the parent model.
 * Refer to the system hierarchy for this subsystem below, and use the
 * MATLAB hilite_system command to trace the generated code back
 * to the parent model.  For example,
 *
 * hilite_system('pwm/timesTwo')    - opens subsystem pwm/timesTwo
 * hilite_system('pwm/timesTwo/Kp') - opens and selects block Kp
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'pwm'
 * '<S1>'   : 'pwm/timesTwo'
 */
#endif                                 /* RTW_HEADER_timesTwo0_h_ */
