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
global i_num;
global s_num;
global s2d_rate;
global i2d_rate;
global s2i_rate;
global xy_range;
global check_rate;
global error_report_rate;
global defend_cost;
global infect_cost;
global w_cost;


global strtegy;
global st_n;
global st_d;
global st_s;
global st_i;
global no_changed;
global infected;
global strategy_none;
global strategy_work;    


delete 'countCell.csv';
%%
% initialize configure
n=500; %元胞行列
i_num =  10; %%感染节点个数
s_num = 1000; %%正常节点个数
s2d_rate = 0.005; %%S -> D 的概率
i2d_rate = 0.008; %%I->D的概率
xy_range = 4; %可以传播的范围,通信半径

check_rate = 0.7; %入侵检测系统检测率
error_report_rate = 0.2; %误报率
defend_cost = 80; %防御的成本
infect_cost = 80; %传播的成本
w_cost = 100; %传感节点感知数据的收益

%%
Cd=10; %入侵检测系统防御恶意程序的传播消耗的能量
R=15; %奖励能量(>Cd)
w=error_report_rate;
a=check_rate;
rho_0=fun_rho(Cd, R, w, a);%rho
rho=rand(); %应该随机生成

phi=20; %状态I传感节点如果传播恶意程序,没有被检测到，它将收获能量(>R)
Ci=10;
sigma_a_0 = fun_sigma_a(rho, phi, Ci, R, w, a);
sigma_b_0 = fun_sigma_b(rho, Cd, R, w, a);
sigma_a=rand(); %应该随机生成
sigma_b=rand(); %应该随机生成



%% 恶意程序进行传播的概率
s2i_rate = (defend_cost + error_report_rate * w_cost) / (2 * check_rate * w_cost);

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


