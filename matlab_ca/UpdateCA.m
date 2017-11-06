%% LEVEL 0
function UpdateCA( )
    %index definition for cell update
    UpdateStrategy();
    UpdateCaStatus();
    
end

%% LEVEL 1 STEP 1
% 0 - 不作为; 1 - 如果是感染节点,则采取感染策略;如果是正常节点,则采取防御策略
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
% 0 - 不作为; 1 - 如果是感染节点,则采取感染策略;如果是正常节点,则采取防御策略
function [strategy] = calcStrategy(x, y)
    global cells;
    global i_rate;
    global d_rate;
    
    strategy = 0; %0 - 不作为
    
    if cells(x,y) == 1 %S正常节点
        if rand(1) > d_rate
            strategy = 1; % 有作为,即防御
        end
    elseif cells(x,y) == 2 %I 感染节点
        if rand(1) < i_rate
            strategy = 1; % 有作为,即感染
        end
    else %D 死亡节点
        %%保持D状态不变
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
            if cells(x,y) == 1 %S正常节点
                if rand(1) > die_rate
                    if (caRule(x, y, x, y-1) == 2 || caRule(x, y, x, y+1) == 2 ...
                          || caRule(x, y, x - 1, y) == 2 || caRule(x, y, x + 1, y) == 2 ...
                          || caRule(x, y, x - 1, y-1) == 2 || caRule(x, y, x - 1, y+1) == 2 ...
                          || caRule(x, y, x, y-1) == 2 || caRule(x, y, x + 1, y+1) == 2 )
                        cells(x,y) = 2; %设置为感染
                    end
                else
                    cells(x,y) = 0; %设置为死亡
                end
            elseif cells(x,y) == 2 %I 感染节点
                if rand(1) > die_rate
                     %%保持感染状态不变
                else
                    cells(x,y) = 0; %设置为死亡
                end
            else %D 死亡节点
                %%保持D状态不变
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
    if ce == die %D 死亡节点
        res = no_changed;
    elseif ce == susceptible %S 正常节点
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
    elseif ce == infect %I 感染节点
        res = no_changed;
    else
        res = no_changed;
    end
        
end
