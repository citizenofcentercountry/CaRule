x=0.01:0.01:0.99;
y=0.01:0.01:0.99;
d=0.3;
f=2.*x.*y-x-y.*d;
plot3(x,y,f,'r','LineWidth',0.5);
hold on;

i=0.1;
f1=x.*(1-i-2.*y);
plot3(x,y,f1,'b','LineWidth',0.5);

% f2=4.*x.*y+(i-2).*x-d.*y;
% plot3(x,y,f2,'g','LineWidth',0.5);

