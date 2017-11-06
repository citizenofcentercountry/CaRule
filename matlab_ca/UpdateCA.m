%% LEVEL 0
function UpdateCA( )
    %index definition for cell update
    UpdateStrategy();
    UpdateCaStatus();
    
end

%% LEVEL 1 STEP 1
% 0 - ����Ϊ; 1 - ����Ǹ�Ⱦ�ڵ�,���ȡ��Ⱦ����;����������ڵ�,���ȡ��������
function UpdateStrategy()
    global n;
    global strtegy;
    %nearest neighbor sum
    %0 - D, 1 - S, 2 - I
    for x = 2:n-1
        for y = 2:n-1
            strtegy(x, y) = calcStrategy(x, y);
        end
    end
end
    
%% LEVEL 2 STEP 1.1
% 0 - ����Ϊ; 1 - ����Ǹ�Ⱦ�ڵ�,���ȡ��Ⱦ����;����������ڵ�,���ȡ��������
function [strategy] = calcStrategy(x, y)
    global cells;
    global i_rate;
    global d_rate;
    
    strategy = 0; %0 - ����Ϊ
    
    if cells(x,y) == 1 %S�����ڵ�
        if rand(1) > d_rate
            strategy = 1; % ����Ϊ,������
        end
    elseif cells(x,y) == 2 %I ��Ⱦ�ڵ�
        if rand(1) < i_rate
            strategy = 1; % ����Ϊ,����Ⱦ
        end
    else %D �����ڵ�
        %%����D״̬����
    end
end

%% LEVEL 1 STEP 2
function UpdateCaStatus()
    global cells;
    global n;
    global die_rate;
    
    %nearest neighbor sum
    %0 - D, 1 - S, 2 - I
    for x = 2:n-1
        for y = 2:n-1
            if cells(x,y) == 1 %S�����ڵ�
                if rand(1) > die_rate
                    if (caRule(x, y, x, y-1) == 2 || caRule(x, y, x, y+1) == 2 ...
                          || caRule(x, y, x - 1, y) == 2 || caRule(x, y, x + 1, y) == 2 ...
                          || caRule(x, y, x - 1, y-1) == 2 || caRule(x, y, x - 1, y+1) == 2 ...
                          || caRule(x, y, x, y-1) == 2 || caRule(x, y, x + 1, y+1) == 2 )
                        cells(x,y) = 2; %����Ϊ��Ⱦ
                    end
                else
                    cells(x,y) = 0; %����Ϊ����
                end
            elseif cells(x,y) == 2 %I ��Ⱦ�ڵ�
                if rand(1) > die_rate
                     %%���ָ�Ⱦ״̬����
                else
                    cells(x,y) = 0; %����Ϊ����
                end
            else %D �����ڵ�
                %%����D״̬����
            end
        end
    end
end

%%
 %0 - D, 1 - S, 2 - I
 %res: 1 - not change; 2 - infect
function [res] = caRule(x, y, x1, y1, strtegy)
    global cells;
    global strtegy;
    
    ce = cells(x,y);
    nb = cells(x1,y1);
    
    no_changed = 1;
    infected = 2;
    
    die=0;
    susceptible=1;
    infect=2;
     %0 - D, 1 - S, 2 - I
    if ce == die %D �����ڵ�
        res = no_changed;
    elseif ce == susceptible %S �����ڵ�
        if nb == infect
            if (strtegy(x, y) == 0 && strtegy(x1, y1) == 1)
                res = infected;
                %disp('res=2');
            else
                res = no_changed;
            end
        else
            res = no_changed;
        end
    elseif ce == infect %I ��Ⱦ�ڵ�
        res = no_changed;
    else
        res = no_changed;
    end
        
end
