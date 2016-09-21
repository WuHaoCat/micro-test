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
    __private float p5;
    p5=funfun(input[5])+p4;
    __private float p6;
    p6=funfun(input[6])+p5;
    __private float p7;
    p7=funfun(input[7])+p6;
    __private float p8;
    p8=funfun(input[8])+p7;
    __private float p9;
    p9=funfun(input[9])+p8;
    __private float p10;
    p10=funfun(input[10])+p9;
    __private float p11;
    p11=funfun(input[11])+p10;
    output[id]=(p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11)/10.0;
}
