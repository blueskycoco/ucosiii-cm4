
#include  <cpu.h>

void        BSP_IntEnAll   (void);

void        BSP_IntDisAll  (void);

void        BSP_IntEn      (CPU_DATA       int_id);

void        BSP_IntHandler (CPU_DATA       int_id);

void        BSP_IntInit    (void);

void        BSP_IntEn      (CPU_DATA       int_id);

void        BSP_IntDis     (CPU_DATA       int_id);

void        BSP_IntClr     (CPU_DATA       int_id);

void        BSP_IntVectSet (CPU_DATA       int_id,
                            CPU_FNCT_VOID  isr);

void        BSP_IntPrioSet (CPU_DATA       int_id,
                            CPU_INT08U     prio);
