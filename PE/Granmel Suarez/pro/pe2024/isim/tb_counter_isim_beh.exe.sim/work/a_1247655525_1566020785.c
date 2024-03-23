/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/ise/Proyectos/PE/tb_counter.vhd";



static void work_a_1247655525_1566020785_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 3224U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(64, ng0);
    t2 = (t0 + 3856);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(65, ng0);
    t2 = (t0 + 2248U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 3032);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(66, ng0);
    t2 = (t0 + 3856);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(67, ng0);
    t2 = (t0 + 2248U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 3032);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_1247655525_1566020785_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    unsigned int t13;
    unsigned char t14;
    unsigned char t15;

LAB0:    t1 = (t0 + 3472U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(75, ng0);
    t2 = (t0 + 3920);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(76, ng0);
    t2 = (t0 + 2248U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (3 * t7);
    t2 = (t0 + 3280);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(77, ng0);
    t2 = (t0 + 3984);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(78, ng0);
    t2 = (t0 + 6164);
    t4 = (t0 + 4048);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(79, ng0);
    t2 = (t0 + 2248U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (1 * t7);
    t2 = (t0 + 3280);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(80, ng0);
    t2 = (t0 + 3920);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(82, ng0);
    t2 = (t0 + 2248U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (3 * t7);
    t2 = (t0 + 3280);
    xsi_process_wait(t2, t8);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(83, ng0);
    t2 = (t0 + 1672U);
    t3 = *((char **)t2);
    t2 = (t0 + 6172);
    t12 = 1;
    if (8U == 8U)
        goto LAB22;

LAB23:    t12 = 0;

LAB24:    if ((!(t12)) == 1)
        goto LAB19;

LAB20:    t11 = (unsigned char)0;

LAB21:    if (t11 != 0)
        goto LAB16;

LAB18:    xsi_set_current_line(86, ng0);
    t2 = (t0 + 6195);
    xsi_report(t2, 14U, 0);

LAB17:    xsi_set_current_line(89, ng0);
    t2 = (t0 + 3920);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(90, ng0);
    t2 = (t0 + 3984);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(91, ng0);
    t2 = (t0 + 2248U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (1 * t7);
    t2 = (t0 + 3280);
    xsi_process_wait(t2, t8);

LAB30:    *((char **)t1) = &&LAB31;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB16:    xsi_set_current_line(84, ng0);
    t9 = (t0 + 6180);
    xsi_report(t9, 15U, 0);
    goto LAB17;

LAB19:    t9 = (t0 + 1832U);
    t10 = *((char **)t9);
    t14 = *((unsigned char *)t10);
    t15 = (t14 != (unsigned char)3);
    t11 = t15;
    goto LAB21;

LAB22:    t13 = 0;

LAB25:    if (t13 < 8U)
        goto LAB26;
    else
        goto LAB24;

LAB26:    t5 = (t3 + t13);
    t6 = (t2 + t13);
    if (*((unsigned char *)t5) != *((unsigned char *)t6))
        goto LAB23;

LAB27:    t13 = (t13 + 1);
    goto LAB25;

LAB28:    xsi_set_current_line(92, ng0);
    t2 = (t0 + 6209);
    t4 = (t0 + 4048);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t9 = (t6 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(93, ng0);
    t2 = (t0 + 3984);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(94, ng0);
    t2 = (t0 + 2248U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (1 * t7);
    t2 = (t0 + 3280);
    xsi_process_wait(t2, t8);

LAB34:    *((char **)t1) = &&LAB35;
    goto LAB1;

LAB29:    goto LAB28;

LAB31:    goto LAB29;

LAB32:    xsi_set_current_line(95, ng0);
    t2 = (t0 + 3920);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(97, ng0);
    t2 = (t0 + 2248U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (11 * t7);
    t2 = (t0 + 3280);
    xsi_process_wait(t2, t8);

LAB38:    *((char **)t1) = &&LAB39;
    goto LAB1;

LAB33:    goto LAB32;

LAB35:    goto LAB33;

LAB36:    xsi_set_current_line(98, ng0);
    t2 = (t0 + 1672U);
    t3 = *((char **)t2);
    t2 = (t0 + 6217);
    t12 = 1;
    if (8U == 8U)
        goto LAB46;

LAB47:    t12 = 0;

LAB48:    if ((!(t12)) == 1)
        goto LAB43;

LAB44:    t11 = (unsigned char)0;

LAB45:    if (t11 != 0)
        goto LAB40;

LAB42:    xsi_set_current_line(101, ng0);
    t2 = (t0 + 6241);
    xsi_report(t2, 15U, 0);

LAB41:    xsi_set_current_line(104, ng0);
    t2 = (t0 + 2248U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (11 * t7);
    t2 = (t0 + 3280);
    xsi_process_wait(t2, t8);

LAB54:    *((char **)t1) = &&LAB55;
    goto LAB1;

LAB37:    goto LAB36;

LAB39:    goto LAB37;

LAB40:    xsi_set_current_line(99, ng0);
    t9 = (t0 + 6225);
    xsi_report(t9, 16U, 0);
    goto LAB41;

LAB43:    t9 = (t0 + 1832U);
    t10 = *((char **)t9);
    t14 = *((unsigned char *)t10);
    t15 = (t14 != (unsigned char)3);
    t11 = t15;
    goto LAB45;

LAB46:    t13 = 0;

LAB49:    if (t13 < 8U)
        goto LAB50;
    else
        goto LAB48;

LAB50:    t5 = (t3 + t13);
    t6 = (t2 + t13);
    if (*((unsigned char *)t5) != *((unsigned char *)t6))
        goto LAB47;

LAB51:    t13 = (t13 + 1);
    goto LAB49;

LAB52:    xsi_set_current_line(105, ng0);
    t2 = (t0 + 1672U);
    t3 = *((char **)t2);
    t2 = (t0 + 6256);
    t12 = 1;
    if (8U == 8U)
        goto LAB62;

LAB63:    t12 = 0;

LAB64:    if ((!(t12)) == 1)
        goto LAB59;

LAB60:    t11 = (unsigned char)0;

LAB61:    if (t11 != 0)
        goto LAB56;

LAB58:    xsi_set_current_line(108, ng0);
    t2 = (t0 + 6282);
    xsi_report(t2, 17U, 0);

LAB57:    xsi_set_current_line(111, ng0);
    t2 = (t0 + 6299);
    xsi_report(t2, 8U, 0);
    xsi_set_current_line(113, ng0);

LAB70:    *((char **)t1) = &&LAB71;
    goto LAB1;

LAB53:    goto LAB52;

LAB55:    goto LAB53;

LAB56:    xsi_set_current_line(106, ng0);
    t9 = (t0 + 6264);
    xsi_report(t9, 18U, 0);
    goto LAB57;

LAB59:    t9 = (t0 + 1832U);
    t10 = *((char **)t9);
    t14 = *((unsigned char *)t10);
    t15 = (t14 != (unsigned char)3);
    t11 = t15;
    goto LAB61;

LAB62:    t13 = 0;

LAB65:    if (t13 < 8U)
        goto LAB66;
    else
        goto LAB64;

LAB66:    t5 = (t3 + t13);
    t6 = (t2 + t13);
    if (*((unsigned char *)t5) != *((unsigned char *)t6))
        goto LAB63;

LAB67:    t13 = (t13 + 1);
    goto LAB65;

LAB68:    goto LAB2;

LAB69:    goto LAB68;

LAB71:    goto LAB69;

}


extern void work_a_1247655525_1566020785_init()
{
	static char *pe[] = {(void *)work_a_1247655525_1566020785_p_0,(void *)work_a_1247655525_1566020785_p_1};
	xsi_register_didat("work_a_1247655525_1566020785", "isim/tb_counter_isim_beh.exe.sim/work/a_1247655525_1566020785.didat");
	xsi_register_executes(pe);
}
