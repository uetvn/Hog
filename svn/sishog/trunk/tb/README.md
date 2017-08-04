<!---
/*******************************************************************************
// Project name   :
// File name      : README.md
// Created date   : Fri 14 Jul 2017 11:13:50 AM +07
// Author         : Ngoc-Sinh Nguyen
// Last modified  : Fri 14 Jul 2017 11:13:50 AM +07
// Desc           :
*******************************************************************************/
-->
# File/Folder structures

    - inf.txt            Input file of testbench
    - ouf.txt            Result of testbench
    - compile.do         Complie source

# Output format:
    x_plus_1 x_minus_1 y_plus_1 y_minus_1 angle_1 angle_2 mag_1 mag_2 dx_from_mag dy_from_mag dx_diff dy_diff

	dx_from_mag         Recomputing dx: dx = f(angle_1, angle_2, mag_1, mag_2)
	dy_from_mag         Recomputing dy: dy = f(angle_1, angle_2, mag_1, mag_2)
    dx_diff             Difference between: dx_from_mag and abs(x_plus_1 - x_minus_1)
    dy_diff             Difference between: dy_from_mag and abs(y_plus_1 - y_minus_1)


*Notes:*  Whenever, dx_diff/(abs(x_plus_1 - x_minus_1)) > 2 % (vhdl warning about this one), it mean *ERROR*,
recheck your code.

# Convert decimal format to binary format

If in linux env, the ../scripts/*.sh  are usabale. But need to delete the part
of angle and magniture in ref_testcases/test_cases.txt
