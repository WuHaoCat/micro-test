#pragma OPENCL EXTENSION cl_amd_printf : enable

__kernel __attribute__((reqd_work_group_size (1,1,1))) void kernel_tst(
	__global uint* input,
	__global uint* r_tvalue,
    __global uint* r_index,
    uint iterations,
    __local uint* s_tvalue,
    __local uint* s_index
	)	
{
	int it;
    unsigned int start_time, end_time;
    unsigned int j = 0;
    for (it = 0; it < iterations; it++){
        s_index[it] = 0;
        s_tvalue[it] = 0;
    }
    for (it=0; it< iterations; it++){
        asm("mov.u32 %0, %%clock;" :"=r"(start_time));
        j=input[j];
        s_index[it]=j;
        asm("mov.u32 %0, %%clock;" :"=r"(end_time));
        s_tvalue[it]=end_time-start_time;
    }
    for (it = 0; it<iterations; it++){
        r_tvalue[it] = s_tvalue[it];
        r_index[it] = s_index[it];
    }
}

