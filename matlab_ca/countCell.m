function countCell2( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    global cells;
    global n;

    global st_d;
    global st_s;
    global st_i;
    
    d_n = 0;
    s_n = 0;
    i_n = 0;
    disp(strcat('n=', num2str(n))); %% ���뱣�������������forѭ��x��Խ�磬ufo������

    for x = 2:n-1
        for y = 2:n-1
            if cells(x,y) == st_s %S�����ڵ�
                s_n = s_n + 1;
            elseif cells(x,y) == st_i %I ��Ⱦ�ڵ�
                i_n = i_n + 1;
            elseif cells(x,y) == st_d %D �����ڵ�
                d_n = d_n + 1;
            else
            end
        end
    end
    
    append2file('countCell.csv', [d_n s_n i_n]);
end


function append2file(filename, line)

    fid1=fopen(filename,'a');
    [m,n]=size(line);
    for i=1:n-1
        fprintf(fid1,'%g,',line(i));
    end
    fprintf(fid1,'%g\n',line(n));
    fclose(fid1);
end
