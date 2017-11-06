x=0.2;
y=0.01:0.01:0.99;
d=0.3;
f=2*x.*y-x-y.*d;
plot(y,f,'r','LineWidth',0.5);
hold on;

i=0.1;
f1=x.*(1-i-2.*y);
plot(y,f1,'b','LineWidth',0.5);
