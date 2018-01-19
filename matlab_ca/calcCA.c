#include "mex.h"    //头文件必须包含mex.h  
double mexSimpleDemo(double *y,double a,double b);           //C语言算法程序声明，在最后调用时，第一  
                //                 个参数是返回结果  
//c语言到matlab变换，以mexFunction命名  
void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])  
{  
    double *y;  
    double m,n;  
      
    //获取输入变量的数值大小  
    m=mxGetScalar(prhs[0]);  
    n=mxGetScalar(prhs[1]);  
    //获取输出变量的指针  
    plhs[0]=mxCreateDoubleMatrix(1,1,mxREAL);  
    y=mxGetPr(plhs[0]);  
       
    //调用子函数  
    mexSimpleDemo(y,m,n);  
  
}  
  
//C语言函数    
double mexSimpleDemo(double *y,double a,double b)  
{  
    return *y=(a>b)?a:b;  
  
} 