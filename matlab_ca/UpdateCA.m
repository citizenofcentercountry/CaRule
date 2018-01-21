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
    %1 - D, 2 - S, 3 - I
    for x = 2:n-1
        for y = 2:n-1
            strtegy(x, y) = calcStrategy(x, y);
        end
    end
end
    
%% LEVEL 2 STEP 1.1
% 0 - ����Ϊ; 1 - ����Ǹ�Ⱦ�ڵ�,���ȡ��Ⱦ����;����������ڵ�,���ȡ��������
function [strategy] = calcStrategy(x, y)
    global st_n;
    global st_d;
    global st_s;
    global st_i;
    global cells;
    global i_rate;
    global d_rate;
    global strategy_none;
    global strategy_work;    

    strategy = strategy_none; %0 - ����Ϊ
    
    if cells(x,y) == st_s %S�����ڵ�
        if rand(1) < d_rate
            strategy = strategy_work; % ����Ϊ,������
        end
    elseif cells(x,y) == st_i %I ��Ⱦ�ڵ�
        if rand(1) < i_rate
            strategy = strategy_work; % ����Ϊ,����Ⱦ
        end
    else %D �����ڵ�
        %%����D״̬����
    end
end

%% LEVEL 1 STEP 2
function UpdateCaStatus()
    global cells;
    global xy_range;
    global strtegy;
    global n;
    global die_rate;
    global no_changed;
    global infected;
    
    global strategy_none;
    global strategy_work;    

    %nearest neighbor sum
    global st_n;
    global st_d;
    global st_s;
    global st_i;
    cells2 = cells;
    % cells=func(cells,die_rate,xy_range,st_d,st_s,st_i)
    
    cells = calcCA( cells2,  die_rate,  xy_range,  st_d,  st_s,  st_i,  strategy_none,  strategy_work, strtegy);
    return;
    %%%%%%%%%%%%%%%%
    tic
    for x = 2:n-1

        for y = 2:n-1
            if cells(x,y) == st_s %S�����ڵ�
                cells2(x,y) = st_s;
                if rand(1) > die_rate
                    if (caRules(x, y) == infected)
                        cells2(x,y) = st_i; %����Ϊ��Ⱦ
                    end
%                     if (caRule(x, y, x, y-1) == infected || caRule(x, y, x, y+1) == infected ...
%                           || caRule(x, y, x - 1, y) == infected || caRule(x, y, x + 1, y) == infected ...
%                           || caRule(x, y, x - 1, y-1) == infected || caRule(x, y, x - 1, y+1) == infected ...
%                           || caRule(x, y, x, y-1) == infected || caRule(x, y, x + 1, y+1) == infected )
%                         cells2(x,y) = st_i; %����Ϊ��Ⱦ
%                     end
                   
                else
                    cells2(x,y) = st_d; %����Ϊ����
                end
            elseif cells(x,y) == st_i %I ��Ⱦ�ڵ�
                if rand(1) > die_rate
                     %%���ָ�Ⱦ״̬����
                     cells2(x,y) = st_i;
                else
                    cells2(x,y) = st_d; %����Ϊ����
                end
            else %D �����ڵ�
                %%����D״̬����
                cells2(x,y) = st_d;
            end
        end

    end
    toc
    cells=cells2;
end

%%
function [res] = caRules(x, y)
    %xy_range ���Ը�Ⱦ�ķ�Χ
    global xy_range;
    global n;
    global no_changed;
    global infected;
    
    sx = x - xy_range;
    if sx < 1
        sx = 1;
    end
    
    ex = x + xy_range;
    if ex > n
        ex = n;
    end
    
    sy = y - xy_range;
    if sy < 1
        sy = 1;
    end
    
    ey = y + xy_range;
    if ey > n
        ey = n;
    end
    
    res = no_changed;
    for i =sx:ex
        for j=sy:ey
            if (caRule(x, y, i, j) == infected)
                res = infected;
                return;
            end
        end
    end
end
%%
 %1 - D, 2 - S, 3 - I
 %res: 1 - not change; 2 - infect
function [res] = caRule(x, y, x1, y1)
    global cells;
    global strtegy;
    
    ce = cells(x,y);
    nb = cells(x1,y1);

    global st_n;
    global st_d;
    global st_s;
    global st_i;
    global no_changed;
    global infected;
    global strategy_none;
    global strategy_work;    

    
    if ce == st_d %D �����ڵ�
        res = no_changed;
    elseif ce == st_s %S �����ڵ�
        if nb == st_i
            if (strtegy(x, y) == strategy_none && strtegy(x1, y1) == strategy_work)
                res = infected;
                %disp('res=2');
            else
                res = no_changed;
            end
        else
            res = no_changed;
        end
    elseif ce == st_i %I ��Ⱦ�ڵ�
        res = no_changed;
    else
        res = no_changed;
    end
        
end
