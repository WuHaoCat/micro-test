float funfun(float v) {
	for(int i=0; i<100000; ++i) {
		v = (v*(v+2.0f))/(v+1.9f);
	}
	return v;
}

__kernel void regTest(__global float* input, __global float* output)
{
	int id = get_global_id(0);
    __private float p_array[50];
    for (int i = 0; i < 50; i++){
        p_array[i]=funfun(input[i])+id;
    }
    output[id]=p_array[id%50]+1;
}
