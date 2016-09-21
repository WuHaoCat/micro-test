#pragma OPENCL EXTENSION cl_amd_printf : enable

__kernel __attribute__((reqd_work_group_size (1,1,1))) void kernel_cacheSize(
    __global uint* input,
    __global uint* r_tvalue,
    uint iterations,
    uint arraySize,
    __local uint* s_tvalue
    )   
{
    int it;
    unsigned int start_time, end_time;
    unsigned int j = 0;
    for (it = 0; it < iterations; it++){
        s_tvalue[it] = 0;
    }
    for (it=0; it< iterations; it++){
        asm("mov.u32 %0, %%clock;" :"=r"(start_time));
        for(int t=0;t<10086;t++){
            j=input[j]/t+t+110;
            j=j%arraySize;
        }
        asm("mov.u32 %0, %%clock;" :"=r"(end_time));
        s_tvalue[it]=end_time-start_time;
    }
    r_tvalue = s_tvalue[it];
}
