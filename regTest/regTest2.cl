float funfun(float v) {
	for(int i=0; i<100000; ++i) {
		v = (v*(v+2.0f))/(v+1.9f);
	}
	return v;
}

__kernel void regTest(__global float* input, __global float* output)
{
	int id = get_global_id(0);
    __private float p1;
    p1=funfun(input[1])+id;
    __private float p2;
    p2=funfun(input[2])+p1;
    output[id]=(p1+p2)/10.0;
}
