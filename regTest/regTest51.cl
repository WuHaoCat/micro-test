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
    __private float p12;
    p12=funfun(input[12])+p11;
    __private float p13;
    p13=funfun(input[13])+p12;
    __private float p14;
    p14=funfun(input[14])+p13;
    __private float p15;
    p15=funfun(input[15])+p14;
    __private float p16;
    p16=funfun(input[16])+p15;
    __private float p17;
    p17=funfun(input[17])+p16;
    __private float p18;
    p18=funfun(input[18])+p17;
    __private float p19;
    p19=funfun(input[19])+p18;
    __private float p20;
    p20=funfun(input[20])+p19;
    __private float p21;
    p21=funfun(input[21])+p20;
    __private float p22;
    p22=funfun(input[22])+p21;
    __private float p23;
    p23=funfun(input[23])+p22;
    __private float p24;
    p24=funfun(input[24])+p23;
    __private float p25;
    p25=funfun(input[25])+p24;
    __private float p26;
    p26=funfun(input[26])+p25;
    __private float p27;
    p27=funfun(input[27])+p26;
    __private float p28;
    p28=funfun(input[28])+p27;
    __private float p29;
    p29=funfun(input[29])+p28;
    __private float p30;
    p30=funfun(input[30])+p29;
    __private float p31;
    p31=funfun(input[31])+p30;
    __private float p32;
    p32=funfun(input[32])+p31;
    __private float p33;
    p33=funfun(input[33])+p32;
    __private float p34;
    p34=funfun(input[34])+p33;
    __private float p35;
    p35=funfun(input[35])+p34;
    __private float p36;
    p36=funfun(input[36])+p35;
    __private float p37;
    p37=funfun(input[37])+p36;
    __private float p38;
    p38=funfun(input[38])+p37;
    __private float p39;
    p39=funfun(input[39])+p38;
    __private float p40;
    p40=funfun(input[40])+p39;
    __private float p41;
    p41=funfun(input[41])+p40;
    __private float p42;
    p42=funfun(input[42])+p41;
    __private float p43;
    p43=funfun(input[43])+p42;
    __private float p44;
    p44=funfun(input[44])+p43;
    __private float p45;
    p45=funfun(input[45])+p44;
    __private float p46;
    p46=funfun(input[46])+p45;
    __private float p47;
    p47=funfun(input[47])+p46;
    __private float p48;
    p48=funfun(input[48])+p47;
    __private float p49;
    p49=funfun(input[49])+p48;
    __private float p50;
    p50=funfun(input[50])+p49;
    __private float p51;
    p51=funfun(input[51])+p50;
    output[id]=(p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11+p12+p13+p14+p15+p16+p17+p18+p19+p20+p21+p22+p23+p24+p25+p26+p27+p28+p29+p30+p31+p32+p33+p34+p35+p36+p37+p38+p39+p40+p41+p42+p43+p44+p45+p46+p47+p48+p49+p50+p51)/10.0;
}
