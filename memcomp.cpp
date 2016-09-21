#include <CL/cl.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <time.h>
#include <string>
#include <fstream>
#include <sstream>
#include <cstring>
#include <math.h>
#include <sys/time.h>

#pragma cl_nv_compiler_options

using namespace std;
int platId = 1;
cl_platform_id platF;
int devId = 0;
cl_device_id device;
cl_context context;

int getProgramBuildInfo(cl_program program){
    size_t log_size;
    cl_int ret;
    char *program_log;
     /* Find size of log and print to std output */
    //cout<<"*****Print the Build Log Start*****"<<endl;
    ret = clGetProgramBuildInfo(program, device, CL_PROGRAM_BUILD_LOG,
            0, NULL, &log_size);
    if (ret != CL_SUCCESS) cout<<"Get Log Len Faild"<<endl;
    else cout<<"Log Len = "<<log_size<<endl;
    program_log = (char*) malloc(log_size+1);
    program_log[log_size] = '\0';
    ret = clGetProgramBuildInfo(program, device, CL_PROGRAM_BUILD_LOG,
            log_size, program_log, NULL);
    if (ret != CL_SUCCESS) cout<<"Get Log Info Faild"<<endl;
    else cout<<"Log file:"<<endl;
    printf("%s\n", program_log);
    free(program_log);
     //cout<<"*****Print the Build Log End*****"<<endl;
    //Query binary PTX file size
    /*ret = clGetProgramInfo(program, CL_PROGRAM_BINARY_SIZES, sizeof(size_t), &log_size, NULL);
    if (ret != CL_SUCCESS) cout<<"Get PTX Code Size Faild"<<endl;
    else cout<<"PTX Code Len = "<<log_size<<endl;
    program_log = (char*) malloc(log_size+1);
    ret = clGetProgramInfo(program, CL_PROGRAM_BINARIES, sizeof(unsigned char *), &program_log, NULL);
    if (ret != CL_SUCCESS) cout<<"Get PTX Code Faild"<<endl;
    printf("The PTX CODE:\n%s\n", program_log);
    free(program_log);*/
    return 0;
}
int convertToString(const char *filename, std::string& s){
	size_t size;
	char*  str;
	std::fstream f(filename, (std::fstream::in | std::fstream::binary));

	if(f.is_open())
	{
		size_t fileSize;
		f.seekg(0, std::fstream::end);
		size = fileSize = (size_t)f.tellg();
		f.seekg(0, std::fstream::beg);
		str = new char[size+1];
		if(!str)
		{
			f.close();
			return 0;
		}

		f.read(str, fileSize);
		f.close();
		str[size] = '\0';
		s = str;
		delete[] str;
		return 0;
	}
	cout<<"Error: failed to open file\n:"<<filename<<endl;
	return -1;
}

void CL_CALLBACK cbkfunction(cl_event event,cl_int cmd_exec_status,void* userdata){
	int *t=(int *)userdata;
	cout<<"User Data"<<*t<<endl;
}

void ckEr(int status, int line){
    if(status!=0){
        printf("error = %d in line %d",status,line);
        exit(2);
    }
}
int ckSEr(int status, int line){
    if(status!=0){
        printf("error = %d in line %d!!!\n",status,line);
        return 1;
    }
    return 0;
}
void printPlatInfo(cl_platform_id platformid, int i){
	cl_int status;
	printf("Platform:%d\n", i);
    char str_tmp_name[1024];
    char str_tmp_version[1024];
    status=clGetPlatformInfo(platformid, CL_PLATFORM_NAME, sizeof(str_tmp_name), str_tmp_name, NULL);
    ckEr(status,__LINE__);
    status=clGetPlatformInfo(platformid, CL_PLATFORM_VERSION, sizeof(str_tmp_version), str_tmp_version, NULL);
    ckEr(status,__LINE__);
    printf("\tName: %s, \n\tVersion: %s \n",str_tmp_name,str_tmp_version);
}
void choosePlatform(){
	cl_int status;
    //Platform Set Up
	cl_uint numPlatforms=0;
	status=clGetPlatformIDs(0,NULL,&numPlatforms);
	ckEr(status, __LINE__);
		//Get the list of the platform ids
	cl_platform_id* platforms=NULL;
	platforms=(cl_platform_id*)malloc(numPlatforms* sizeof(cl_platform_id));
	status=clGetPlatformIDs(numPlatforms,platforms,NULL);
	ckEr(status, __LINE__);

	if (platId >= numPlatforms) platId = -1;
	if (platId < 0) {
		cout<<"Num of Platforms:"<<numPlatforms<<endl;
		for (int i = 0; i < numPlatforms; i++){
			printPlatInfo(platforms[i], i);
		}
		while (platId < 0){
			cout<<"Please enter the platform your choices[0~"<<numPlatforms-1<<"]:";
			cin>>platId;
			if (platId >= numPlatforms)
				platId = -1;
		}
	}
	platF = platforms[platId];
	cout<<"------Platform Choosed------"<<endl;
	printPlatInfo(platF, platId);
	delete platforms;
}
void printDevInfo(cl_device_id deviceid, int i){
	cl_int status;
	char str_tmp_device_name[1024];
    cl_uint fre=0;
    size_t max_work_group_size=0;
    size_t max_mem_alloc_size=0;
    printf("Device:%d\n",i);
    status= clGetDeviceInfo(deviceid, CL_DEVICE_NAME, sizeof(str_tmp_device_name), str_tmp_device_name, NULL);
    ckEr(status,__LINE__);
    status=clGetDeviceInfo(deviceid, CL_DEVICE_MAX_CLOCK_FREQUENCY, sizeof(cl_uint), &fre, NULL);
    ckEr(status,__LINE__);
    status=clGetDeviceInfo(deviceid, CL_DEVICE_MAX_WORK_GROUP_SIZE, sizeof(size_t), &max_work_group_size, NULL);
    ckEr(status,__LINE__);
    status=clGetDeviceInfo(deviceid, CL_DEVICE_MAX_MEM_ALLOC_SIZE, sizeof(size_t), &max_mem_alloc_size, NULL);
    ckEr(status,__LINE__);
    printf("\tDevice name: %s\n\tDevice max frequency %d\n\tmax work-group size %d\n\tmax memory allocate size %d(Byte)\n", str_tmp_device_name,fre,(int)max_work_group_size,(int)max_mem_alloc_size);
}

void chooseDevice(){
	cl_int status;
	cl_uint numDevices=0;
	cl_device_id* devices=NULL;
    status=clGetDeviceIDs(platF, CL_DEVICE_TYPE_ALL, 0, NULL, &numDevices);
    ckEr(status,__LINE__);
    devices=(cl_device_id*)malloc(sizeof(cl_device_id)*numDevices);
    status=clGetDeviceIDs(platF, CL_DEVICE_TYPE_ALL, numDevices, devices, NULL);
    ckEr(status,__LINE__);
    if (devId >= numDevices) devId = -1;
    if (devId < 0){
    	cout<<"Num of devices in select platform:"<<numDevices<<endl;
		for (int i = 0; i < numDevices; i++){
			printDevInfo(devices[i], i);
		}
		while (devId < 0){
			cout<<"Please enter the device your choices[0~"<<numDevices-1<<"]:";
			cin>>devId;
			if (devId >= numDevices)
				devId = -1;
		}
    }

    device=devices[devId];
    cout<<"------Device Choosed------"<<endl;
	printDevInfo(device, devId);
    
    //context
    context=clCreateContext(NULL, numDevices, devices, NULL, NULL, &status);
    ckEr(status, __LINE__);
    delete devices;
}

cl_program buildProgram(const char* filename){
	cl_int status;
	string sourceStr;
	status = convertToString(filename, sourceStr);
	const char *source = sourceStr.c_str();
	size_t sourceSize[] = {strlen(source)};
	cl_program program = clCreateProgramWithSource(context, 1, &source, sourceSize, NULL);
	status=clBuildProgram(program,1,&device,"-cl-nv-verbose",NULL,NULL);
	ckEr(status, __LINE__);
	getProgramBuildInfo(program);
	return program;
}

int main(int argc,char *argv[]){

	cout<<"-------------------------------------------------------------"<<endl;
	cout<<"--------------------Memory Architecture Test-----------------------"<<endl;
	cout<<"-------------------------------------------------------------"<<endl;
    
    int progTest = atoi(argv[1]);

    int msize = 512;
    int arraySize = msize*64;

    int* arr = new int[arraySize];
    unsigned int* re_arr = new unsigned int[arraySize];
    for (int i = 0; i < arraySize; i++){
    	arr[i] = i/100;
    }

    choosePlatform();
    chooseDevice();
    cl_program program = buildProgram("regTest.cl");
    
    cl_int status;
    cl_command_queue cmdQueue;
	cmdQueue = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE,&status);
	ckEr(status, __LINE__);
	cl_kernel kernel;
	kernel=clCreateKernel(program,"regTest",&status);
	ckEr(status, __LINE__);

	//Data Allocate
    cl_mem input = clCreateBuffer(context,  CL_MEM_READ_ONLY, arraySize*sizeof(cl_int), NULL, &status);
    ckEr(status, __LINE__);
    cl_mem output = clCreateBuffer(context, CL_MEM_WRITE_ONLY, arraySize*sizeof(cl_uint), NULL, &status);
    ckEr(status, __LINE__);
    //Data Transfer
    status = clEnqueueWriteBuffer(cmdQueue, input, CL_TRUE, 0, arraySize*sizeof(cl_int), arr, 0, NULL, NULL);
    ckEr(status, __LINE__);

	size_t global = {arraySize};
	size_t local = {msize};

    // Set the arguments to our compute kernel
    status = clSetKernelArg(kernel, 0, sizeof(cl_mem), &input);
    ckEr(status, __LINE__);
	status = clSetKernelArg(kernel, 1, sizeof(cl_mem), &output);
	ckEr(status, __LINE__); 
    cl_event event;
    
    // Enqueue kernels
	status = clEnqueueNDRangeKernel(cmdQueue, kernel, 1, NULL, &global, &local, 0, NULL, &event);
	ckEr(status, __LINE__);
	status = clFinish(cmdQueue);
	ckEr(status, __LINE__);

	cout<<"Kernel Run Success!"<<endl;
    cl_ulong start, end;
    status = clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_START, sizeof(cl_ulong), &start, NULL);
    ckEr(status, __LINE__);
    status = clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_END, sizeof(cl_ulong), &end, NULL);
    ckEr(status, __LINE__);

    cl_ulong duration = end-start;
    cout<<"The duration is "<<duration<<endl;
	status = clEnqueueReadBuffer(cmdQueue, output, CL_TRUE, 0, arraySize*sizeof(cl_uint), re_arr, 0, NULL, NULL);
	ckEr(status, __LINE__);

	status = clFinish(cmdQueue);
	ckEr(status, __LINE__);
	cout<<"Data Transfer Back Success!"<<endl;

    //result output
    std::fstream f("regTestTime.txt", (std::fstream::out | std::fstream::binary| std::fstream::app));
    if(!f.is_open())
    {
        cout<<"Output File Open False"<<endl;
        return -1;
    }
    f<<progTest<<","<<duration<<endl;
    f.close();

	clReleaseMemObject(input);
	clReleaseMemObject(output);
    clReleaseProgram(program);
    clReleaseKernel(kernel);
    clReleaseCommandQueue(cmdQueue);
	delete arr;
	delete re_arr;
	
	return 0;
}
