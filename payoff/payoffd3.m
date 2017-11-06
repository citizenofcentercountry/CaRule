[x,y] = meshgrid(0:0.02:1);

d=0.3;
f=2.*x.*y-x-y.*d;

i=0.1;
f1=x.*(1-i-2.*y);

surf(x,y,f);
axis tight
hold on;
surf(x,y,f1);
