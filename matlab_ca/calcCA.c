#include "mex.h"    //ͷ�ļ��������mex.h  
double mexSimpleDemo(double *y,double a,double b);           //C�����㷨������������������ʱ����һ  
                //                 �������Ƿ��ؽ��  
//c���Ե�matlab�任����mexFunction����  
void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])  
{  
    double *y;  
    double m,n;  
      
    //��ȡ�����������ֵ��С  
    m=mxGetScalar(prhs[0]);  
    n=mxGetScalar(prhs[1]);  
    //��ȡ���������ָ��  
    plhs[0]=mxCreateDoubleMatrix(1,1,mxREAL);  
    y=mxGetPr(plhs[0]);  
       
    //�����Ӻ���  
    mexSimpleDemo(y,m,n);  
  
}  
  
//C���Ժ���    
double mexSimpleDemo(double *y,double a,double b)  
{  
    return *y=(a>b)?a:b;  
  
} 