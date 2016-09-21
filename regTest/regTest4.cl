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
    __private float p3;
    p3=funfun(input[3])+p2;
    __private float p4;
    p4=funfun(input[4])+p3;
    output[id]=(p1+p2+p3+p4)/10.0;
}
