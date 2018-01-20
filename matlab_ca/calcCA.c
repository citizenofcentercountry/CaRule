#include "mex.h"    //
#include "matrix.h"
    #define no_changed 0
    #define infected 1            
// 
void UpdateCaStatus(int *out_cell, int *in_cell, int m, int n, double die_rate, double xy_range, int st_d, int st_s, int st_i, int strategy_none, int strategy_work, int *strtegy);
int caRules(int *in_cell, int m, int n, double die_rate, double xy_range, int st_d, int st_s, int st_i, int strategy_none, int strategy_work, int *strtegy, int x, int y);
int caRule(int *in_cell, int m, int n, double die_rate, double xy_range, int st_d, int st_s, int st_i, int strategy_none, int strategy_work, int *strtegy, int x, int y, int x1, int y1);
void mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])  
{  
    int *out_cell;
    int *in_cell;
    int m;
    int n;
    double die_rate;
    double xy_range;
    int st_d;
    int st_s;
    int st_i;
    int strategy_none;
    int strategy_work;
    int *strtegy;
    //die_rate,xy_range,st_d,st_s,st_i
    //size of input  
    in_cell=(int *)mxGetPr(prhs[0]); 
    die_rate =mxGetScalar(prhs[1]);  
    xy_range =mxGetScalar(prhs[2]);
    st_d = mxGetScalar(prhs[3]);
    st_s = mxGetScalar(prhs[4]);
    st_i = mxGetScalar(prhs[5]);
    strategy_none = mxGetScalar(prhs[6]);
    strategy_work = mxGetScalar(prhs[7]);  
    strtegy=(int *)mxGetPr(prhs[8]); 
    
    m = mxGetM(prhs[0]);
    n = mxGetN(prhs[0]);
    plhs[0]=mxCreateNumericMatrix(m,n,mxINT32_CLASS, mxREAL);
    //outputd pointer
    out_cell=(int *)mxGetPr(plhs[0]);  
    
    
    
    //call subfunction  
  UpdateCaStatus(out_cell, in_cell, m, n, die_rate, xy_range, st_d, st_s, st_i, strategy_none, strategy_work, strtegy); 
}
void UpdateCaStatus(int *out_cell, int *in_cell, int m, int n, double die_rate, double xy_range, int st_d, int st_s, int st_i, int strategy_none, int strategy_work, int *strtegy)
{
   int i,j;
 for (i = 1; i < m-1; ++i)
 {
     for (j = 1; j < n-1; ++j)
     {
         if (in_cell[i*n+j] == st_s)
         {
             out_cell[i*n+j] = st_s;
             if (rand() > die_rate)
             {
                 if (caRules(in_cell, m, n, die_rate, xy_range, st_d, st_s, st_i, strategy_none, strategy_work,strtegy, i, j) == infected)
                 {
                     out_cell[i*n+j] = st_i;
                 }
             } else {
                 out_cell[i*n+j] = st_d;
             }
         } else if (in_cell[i*n+j] == st_i)
         {
             
             if (rand() > die_rate)
             {
                 out_cell[i*n+j] = st_i;
             } else {
                 out_cell[i*n+j] = st_d;
             }
         } else {
             out_cell[i*n+j] = st_d;
         }
     }
 }
}

int caRules(int *in_cell, int m, int n, double die_rate, double xy_range, int st_d, int st_s, int st_i, int strategy_none, int strategy_work, int *strtegy, int x, int y)
{
    int sx,ex,sy,ey, i,j;
    // x  - row ; y - colum
     sx = x - xy_range;
    if (sx < 0) {
        sx = 0;
    }
    
     ex = x + xy_range;
    if (ex >= m) {
        ex = m-1;
    }
    
     sy = y - xy_range;
    if (sy < 0){
        sy = 0;
    }
    
     ey = y + xy_range;
    if (ey >= n){
        ey = n - 1;
    }
    
    
    for ( i =sx; i <= ex; ++i) {
        for ( j=sy; j <=ey; ++j) {
            if (caRule(in_cell, m, n, die_rate, xy_range, st_d, st_s, st_i, strategy_none, strategy_work,strtegy, x, y, i, j) == infected){
                
                return infected;
            }
        }
    }
    return no_changed;
}

int caRule(int *in_cell, int m, int n, double die_rate, double xy_range, int st_d, int st_s, int st_i, int strategy_none, int strategy_work, int *strtegy, int x, int y, int x1, int y1)
{
    int ce, nb, res;
     ce = in_cell[x * n + y];
     nb = in_cell[x1 * n + y1];
     res = no_changed;
    
    if (ce == st_d){
        res = no_changed;
    }else if (ce == st_s){ 
        if (nb == st_i){
            if (strtegy[x * n + y] == strategy_none && strtegy[x1 * n + y1] == strategy_work) {
                res = infected;
            }else{
                res = no_changed;
            }
        }else{
            res = no_changed;
        }
    }else if (ce == st_i){
        res = no_changed;
    }else{
        res = no_changed;
    }
 return res;       
}
