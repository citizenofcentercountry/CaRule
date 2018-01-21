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
global i_rate;
global d_rate;
global die_rate;
global strtegy;
global st_n;
global st_d;
global st_s;
global st_i;
global no_changed;
global infected;
global strategy_none;
global strategy_work;    
global xy_range;
delete 'countCell.csv';
% initialize configure
n=128; %Ԫ������
i_num =  mod(n, 10); %%��Ⱦ�ڵ����
s_num = ceil(n * (n-1)); %%�����ڵ����
i_rate = .2; %%ִ�и�Ⱦ���Եĸ���
d_rate = .8; %%ִ�з������Եĸ���
die_rate= .001; %%�����ĸ���
xy_range = 3; %���Դ����ķ�Χ

%caRule����ֵ
    no_changed = 1;
    infected = 2;
%strategy״̬
% strategy_none - ����Ϊ; strategy_work - ����Ǹ�Ⱦ�ڵ�,���ȡ��Ⱦ����;����������ڵ�,���ȡ��������
strategy_none = 0;
strategy_work = 1;

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
%cells=zeros(n,n);
cells=ones(n,n);
InitialCell(i_num, s_num );

strtegy=zeros(n,n);

set_colors();

%build an image and display it
%imh = image(cat(3,cells,z,z));
imh = image(cat(3,r,g,b));
set(imh, 'erasemode', 'none')
axis equal
axis tight

rng('shuffle');

%Main event loop
stop= 0; %wait for a quit button push
run = 0; %wait for a draw 
freeze = 0; %wait for a freeze

while (stop==0) 

    if (run==1)

        % The CA rule
        UpdateCA();
        countCell();
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


