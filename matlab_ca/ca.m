%Conway's life with GUI

clf
clear all
clc

%=============================================
%build the GUI
%define the plot button
plotbutton=uicontrol('style','pushbutton',...
   'string','Run', ...
   'fontsize',12, ...
   'position',[100,400,50,20], ...
   'callback', 'run=1;');

%define the stop button
erasebutton=uicontrol('style','pushbutton',...
   'string','Stop', ...
   'fontsize',12, ...
   'position',[200,400,50,20], ...
   'callback','freeze=1;');

%define the Quit button
quitbutton=uicontrol('style','pushbutton',...
   'string','Quit', ...
   'fontsize',12, ...
   'position',[300,400,50,20], ...
   'callback','stop=1;close;');

number = uicontrol('style','text', ...
    'string','1', ...
   'fontsize',12, ...
   'position',[20,400,50,20]);


%=============================================
%CA setup


global r;
global g;
global b;
global cells;

global n;

global st_n;
global st_d;
global st_s;
global st_i;


delete 'countCell.csv';
%%
% initialize configure
n=500; %Ԫ������
i_num =  10; %%��Ⱦ�ڵ����
s_num = 1000; %%�����ڵ����
s2d_rate = 0.005; %%S -> D �ĸ��� eta
i2d_rate = 0.008; %%I->D�ĸ��� epsilon
xy_range = 4; %���Դ����ķ�Χ,ͨ�Ű뾶

check_rate = 0.7; %���ּ��ϵͳ�����
error_report_rate = 0.2; %����
Ci=10; %���ֶ������Ĵ������ĵ�����
Cd=10; %���ּ��ϵͳ�����������Ĵ������ĵ�����
R=15; %��������(>Cd)
phi=20; %״̬I���нڵ���������������,û�б���⵽�������ջ�����(>R)
rho=0.7; %��ʾWSNs�д���I״̬�Ĵ��нڵ�ĸ���

%%

w=error_report_rate;
a=check_rate;
rho_0=fun_rho(Cd, R, w, a);%rho
disp(['rho=', num2str(rho)]);
disp(['rho_0=', num2str(rho_0)]);
if (rho < rho_0)
    disp('Warning : rho SHOULD BE GREATER THAN rho_0');
end
sigma_a = fun_sigma_a(rho, phi, Ci, R, w, a);
sigma_b = fun_sigma_b(rho, Cd, R, w, a);


%% ���������д����ĸ��� beta
s2i_rate = sigma_a;
%s2i_rate = sigma_a * (1 - sigma_b);

%%

%initialize the arrays
%0 - D, 1 - S, 2 - I
st_n = 0;
st_d = 1;
st_s = 2;
st_i = 3;
% white, green, red
r=ones(n,n);
g=ones(n,n);
b=ones(n,n);
cells=zeros(n,n);
%cells=ones(n,n);
InitialCell(i_num, s_num );

strtegy=zeros(n,n);

set_colors();

%build an image and display it
%imh = image(cat(3,cells,z,z));
imh = image(cat(3,r,g,b));
set(imh, 'erasemode', 'none')
axis equal
axis tight
axis([0,n,0,n]);
axis xy;
%title('Title','FontName','Times New Roman','FontWeight','Bold','FontSize',16)
xlabel('x','FontName','Times New Roman','FontSize',14)
ylabel('y','FontName','Times New Roman','FontSize',14,'Rotation',90)

rng('shuffle');

%Main event loop
stop= 0; %wait for a quit button push
run = 0; %wait for a draw 
freeze = 0; %wait for a freeze

while (stop==0) 

    if (run==1)

        cells2 = cells;
        cells = calcCA( cells2, xy_range, st_n, st_d,  st_s,  st_i, s2d_rate, i2d_rate, s2i_rate);
        
        countCell(cells, st_n, st_d,  st_s,  st_i);
        set_colors();
        %draw the new image
        set(imh, 'cdata', cat(3,r,g,b));
        %update the step number diaplay
        stepnumber = 1 + str2num(get(number,'string'));
        set(number,'string',num2str(stepnumber))
    end

    if (freeze==1)
        run = 0;
        freeze = 0;
    end

    drawnow  %need this in the loop for controls to work

end


