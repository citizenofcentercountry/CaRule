#include "mex.h"    //
#include "matrix.h"
#include "math.h"
#include "stdio.h"
#include "stdlib.h"

double *in_cell;
int m;
int n;

int st_n =0;
int st_d;
int st_s;
int st_i;

int d_n = 0;
int s_n = 0;
int i_n = 0;

	void dump_param();
	void append2file(const char * filename);
	void statisticsStatus();
	
void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])  
{  
    //mexPrintf("\nThere are %d right-hand-side argument(s).", nrhs);
    //die_rate,xy_range,st_d,st_s,st_i
    //size of input  
    in_cell=mxGetPr(prhs[0]);  
    st_n =mxGetScalar(prhs[1]);
    st_d = mxGetScalar(prhs[2]);
    st_s = mxGetScalar(prhs[3]);
    st_i = mxGetScalar(prhs[4]);
    m = mxGetM(prhs[0]);
    n = mxGetN(prhs[0]);

    //mexPrintf("%f\n",myrand());
    //call subfunction  
    statisticsStatus(); 
}

void dump_param()
{
	static int i = 0;
	if (i != 0) return;
	++i;
	mexPrintf("m*n=%d*%d\n", m, n);
	mexPrintf("st_n=%d\n", st_n);
	mexPrintf("st_d=%d\n", st_d);
	mexPrintf("st_s=%d\n", st_s);
	mexPrintf("st_i=%d\n", st_i);
}

void statisticsStatus()
{
	int i,j;
	
	d_n = 0;
    s_n = 0;
    i_n = 0;
	
	for (i = 1; i < m-1; ++i)
	{
	 //mexPrintf("\n");
	 for (j = 1; j < n-1; ++j)
	 {
		 //mexPrintf("%d,",in_cell[i*n+j]);
		 if ((int)in_cell[i*n+j] == st_s)
		 {
			 ++s_n;
		 }
		 else if ((int)in_cell[i*n+j] == st_i)
		 {
			 ++i_n;
		 }
		 else if ((int)in_cell[i*n+j] == st_d)
		 {
			 ++d_n;
		 }
	 }
	}
	
	append2file("countCell.csv");
}

void append2file(const char * filename)
{
	FILE *fp = NULL;
	fp = fopen(filename, "a");
	fprintf(fp, "%d,%d,%d\n", d_n, s_n, i_n);
	fflush(fp);
	fclose(fp);
}
