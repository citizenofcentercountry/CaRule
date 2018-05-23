#include "mex.h"    //
#include "matrix.h"
#include "math.h"

#define no_changed 0
#define infected 1            
double *out_cell;
double *in_cell;
int m;
int n;

int st_n =0;
int st_d;
int st_s;
int st_i;

double s2d_rate; //S -> D 的概率
double i2d_rate; //I->D的概率
double s2i_rate; //S->I的概率
double xy_range; //可以传播的范围,通信半径
double k; //邻居节点中I节点的个数

// 
void UpdateCaStatus();
void dump_param();
void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])  
{  
    //mexPrintf("\nThere are %d right-hand-side argument(s).", nrhs);
    //die_rate,xy_range,st_d,st_s,st_i
    //size of input  
    in_cell=mxGetPr(prhs[0]); 
    xy_range =mxGetScalar(prhs[1]);  
    st_n =mxGetScalar(prhs[2]);
    st_d = mxGetScalar(prhs[3]);
    st_s = mxGetScalar(prhs[4]);
    st_i = mxGetScalar(prhs[5]);
    s2d_rate = mxGetScalar(prhs[6]);
    i2d_rate = mxGetScalar(prhs[7]);  
    s2i_rate = mxGetScalar(prhs[8]); 
    
    m = mxGetM(prhs[0]);
    n = mxGetN(prhs[0]);
	
	dump_param();
    
	plhs[0]=mxCreateDoubleMatrix(m,n, mxREAL);
    //outputd pointer
    out_cell=mxGetPr(plhs[0]);  
    memcpy(out_cell, in_cell, m * n *sizeof(int));

    //mexPrintf("%f\n",myrand());
    //call subfunction  
    UpdateCaStatus(); 
}

void dump_param()
{
	static int i = 0;
	if (i != 0) return;
	++i;
	mexPrintf("m*n=%d*%d\n", m, n);
	mexPrintf("xy_range=%f\n", xy_range);
	mexPrintf("st_n=%d\n", st_n);
	mexPrintf("st_d=%d\n", st_d);
	mexPrintf("st_s=%d\n", st_s);
	mexPrintf("st_i=%d\n", st_i);
	mexPrintf("s2d_rate=%f\n", s2d_rate);
	mexPrintf("i2d_rate=%f\n", i2d_rate);
	mexPrintf("s2i_rate=%f\n", s2i_rate);
}

double myrand()
{
    double r;
	static int i = 0;
	if (i == 0)
	{
		srand(time(0));
		i = 1;
	}
    
    r = rand() % 10000;
    return r / 10000.0f;
}

int statisticsNeighborStatus(int x, int y, int st)
{
	int k = 0;
	int i,j;
	int x0,x1,y0,y1;
	x0 = x - xy_range;
	x1 = x + xy_range;
	y0 = y - xy_range;
	y1 = y + xy_range;
	if (x0 < 0) x0 = 0;
	if (x1 >= m) x1 = m - 1;
	if (y0 < 0) y0 = 0;
	if (y1 >= n) y1 = n - 1;
	
	for ( i = x0; i <= x1; ++i)
	{
		for ( j = y0; j <= y1; ++j)
		{
			if ((int)in_cell[i*n+j] == st)
			{
				++k;
			}
		}
	}
	return k;
}

void UpdateCaStatus()
{
   int i,j, k;
   double r;
 for (i = 1; i < m-1; ++i)
 {
     //mexPrintf("\n");
     for (j = 1; j < n-1; ++j)
     {
         //mexPrintf("%d,",in_cell[i*n+j]);
         if ((int)in_cell[i*n+j] == st_s)
         {
			 k = statisticsNeighborStatus(i, j, st_i);
			 //if (k > 0)
			 //{
			//	 mexPrintf("k=%d, r=%f, s2d_rate=%f, s2i_rate=%f, s2s=%f\n",k, r, s2d_rate, s2i_rate, (1 - s2d_rate) * pow((1-s2i_rate), k) + s2d_rate);
			 //}
			 r = myrand();
             if (r < s2d_rate)
             {
				 out_cell[i*n+j] = st_d;
             } 
			 else if (r < (1 - s2d_rate) * pow((1-s2i_rate), k) + s2d_rate) 
			 {
                 out_cell[i*n+j] = st_s;
             }
			 else
			 {
				out_cell[i*n+j] = st_i;
			 }
         } 
		 else if ((int)in_cell[i*n+j] == st_i)
         {
             
             if (myrand() < i2d_rate)
             {
                 out_cell[i*n+j] = st_d;
             } else {
                 out_cell[i*n+j] = st_i;
             }
         } 
		 else if ((int)in_cell[i*n+j] == st_d)
		 {
             
             out_cell[i*n+j] = st_d;
         } 
		 else 
		 {
             out_cell[i*n+j] = st_n;
         }
     }
 }
}
