float funfun(float v) {
	for(int i=0; i<100000; ++i) {
		v = (v*(v+2.0f))/(v+1.9f);
	}
	return v;
}

__kernel void compIntensive(__global float* input, __global float* output)
{
	int id = get_global_id(0);
    for (int i = 0; i < 100; i++){
    	output[id] = funfun(input[id]);
    }
}

__kernel void memIntensive(__global float* input, __global float* output)
{
	int id = get_global_id(0);
	output[id] = 0;
    for (int i = 0; i < 400000; i++){
    	output[id] += input[i+id];
    	output[id] += input[i+id/2];
    	output[id] -= input[39999-i+id];
    	output[id] -= input[39999-i+id/2];
    }
}
