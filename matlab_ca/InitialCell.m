function InitialCell( i_num, s_num )
    %0 - D, 1 - S, 2 - I
    global cells;
    global n;
    disp(strcat('I number=', num2str(i_num)));
    disp(strcat('S number=', num2str(s_num)));
    
    %������ø�Ⱦ�ڵ��λ��
    while i_num > 0
        xy=ceil(rand(1,2) * n);
        if (cells(xy(1,1), xy(1,2)) == 0) 
            cells(xy(1,1), xy(1,2)) = 2;
            i_num = i_num  - 1;
        end
    end
    
    %������������ڵ��λ��
    while s_num > 0
        xy=ceil(rand(1,2) * n);
        if (cells(xy(1,1), xy(1,2)) == 0)
            cells(xy(1,1), xy(1,2)) = 1;
            s_num = s_num - 1;
        end
    end
    
    % ��ΧһȦ����ΪD
    y = 1;
    for x = 1:n
        cells(x,y) = 0;
    end
    
    y = n;
    for x = 1:n
        cells(x,y) = 0;
    end
    
    x = 1;
    for y = 1:n
        cells(x,y) = 0;
    end

    x = n;
    for y = 1:n
        cells(x,y) = 0;
    end
    
end

