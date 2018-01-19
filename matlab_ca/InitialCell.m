function InitialCell( i_num, s_num )
global st_n;
global st_d;
global st_s;
global st_i;
    global cells;
    global n;
    disp(strcat('I number=', num2str(i_num)));
    disp(strcat('S number=', num2str(s_num)));
    disp(strcat('line number=', num2str(n)));
    %全部设置为正常状态
    for x = 1:n
        for y = 1:n
            cells(x,y) = st_s;
        end
    end
    
    %随机设置感染节点的位置
    while i_num > 0
        xy=ceil(rand(1,2) * n);
        if (cells(xy(1,1), xy(1,2)) ~= st_i) 
            cells(xy(1,1), xy(1,2)) = st_i;
            i_num = i_num  - 1;
        end
    end
    
%     %随机设置正常节点的位置
%     while s_num > 0
%         xy=ceil(rand(1,2) * n);
%         if (cells(xy(1,1), xy(1,2)) == st_n)
%             cells(xy(1,1), xy(1,2)) = st_s;
%             s_num = s_num - 1;
%         end
%     end
    
    % 周围一圈设置为D
    y = 1;
    for x = 1:n
        cells(x,y) = st_n;
    end
    
    y = n;
    for x = 1:n
        cells(x,y) = st_n;
    end
    
    x = 1;
    for y = 1:n
        cells(x,y) = st_n;
    end

    x = n;
    for y = 1:n
        cells(x,y) = st_n;
    end
    
end

