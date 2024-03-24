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
static const char *ng0 = "/home/ise/Proyectos/PE2/Buffer_32Bytes/buff_32x8bits.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );
int ieee_p_3620187407_sub_5109402382352621412_3965413181(char *, char *, char *);


static void work_a_0635801967_3212880686_p_0(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    int t8;
    int t9;
    char *t10;
    char *t11;
    char *t12;
    int t13;
    int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    unsigned char t23;

LAB0:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3744);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(55, ng0);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 1352U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = (t2 == (unsigned char)3);
    if (t5 != 0)
        goto LAB13;

LAB14:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(56, ng0);
    t3 = (t0 + 6608);
    *((int *)t3) = 0;
    t7 = (t0 + 6612);
    *((int *)t7) = 31;
    t8 = 0;
    t9 = 31;

LAB8:    if (t8 <= t9)
        goto LAB9;

LAB11:    goto LAB6;

LAB9:    xsi_set_current_line(57, ng0);
    t10 = xsi_get_transient_memory(8U);
    memset(t10, 0, 8U);
    t11 = t10;
    memset(t11, (unsigned char)2, 8U);
    t12 = (t0 + 6608);
    t13 = *((int *)t12);
    t14 = (t13 - 31);
    t15 = (t14 * -1);
    t16 = (8U * t15);
    t17 = (0U + t16);
    t18 = (t0 + 3824);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t10, 8U);
    xsi_driver_first_trans_delta(t18, t17, 8U, 0LL);

LAB10:    t1 = (t0 + 6608);
    t8 = *((int *)t1);
    t3 = (t0 + 6612);
    t9 = *((int *)t3);
    if (t8 == t9)
        goto LAB11;

LAB12:    t13 = (t8 + 1);
    t8 = t13;
    t4 = (t0 + 6608);
    *((int *)t4) = t8;
    goto LAB8;

LAB13:    xsi_set_current_line(60, ng0);
    t1 = (t0 + 1512U);
    t4 = *((char **)t1);
    t6 = *((unsigned char *)t4);
    t23 = (t6 == (unsigned char)3);
    if (t23 != 0)
        goto LAB15;

LAB17:    xsi_set_current_line(63, ng0);
    t1 = (t0 + 2152U);
    t3 = *((char **)t1);
    t1 = (t0 + 1832U);
    t4 = *((char **)t1);
    t1 = (t0 + 6256U);
    t8 = ieee_p_3620187407_sub_5109402382352621412_3965413181(IEEE_P_3620187407, t4, t1);
    t9 = (t8 - 31);
    t15 = (t9 * -1);
    xsi_vhdl_check_range_of_index(31, 0, -1, t8);
    t16 = (8U * t15);
    t17 = (0 + t16);
    t7 = (t3 + t17);
    t10 = (t0 + 3888);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t18 = (t12 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t7, 8U);
    xsi_driver_first_trans_fast_port(t10);

LAB16:    goto LAB6;

LAB15:    xsi_set_current_line(61, ng0);
    t1 = (t0 + 1672U);
    t7 = *((char **)t1);
    t1 = (t0 + 1832U);
    t10 = *((char **)t1);
    t1 = (t0 + 6256U);
    t8 = ieee_p_3620187407_sub_5109402382352621412_3965413181(IEEE_P_3620187407, t10, t1);
    t9 = (t8 - 31);
    t15 = (t9 * -1);
    t16 = (8U * t15);
    t17 = (0U + t16);
    t11 = (t0 + 3824);
    t12 = (t11 + 56U);
    t18 = *((char **)t12);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t7, 8U);
    xsi_driver_first_trans_delta(t11, t17, 8U, 0LL);
    goto LAB16;

}


extern void work_a_0635801967_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0635801967_3212880686_p_0};
	xsi_register_didat("work_a_0635801967_3212880686", "isim/buff_sim_isim_beh.exe.sim/work/a_0635801967_3212880686.didat");
	xsi_register_executes(pe);
}
