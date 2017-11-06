
function set_colors()
    global cells;
    global n;

    for i=1:n
      for j=1:n
        c='w';
        if (cells(i,j)==1)
          c='g';
        elseif (cells(i,j)==2)
          c='r';
        end
    %     disp(c);
        set_color(i,j,c);
      end
    end
    
end
%%%
function set_color(x,y,c)
  global r;
  global g;
  global b;
  if (c == 'r' )
    r(x,y)=1;
    g(x,y)=0;
    b(x,y)=0;
  elseif(c == 'g' )
    r(x,y)=0;
    g(x,y)=1;
    b(x,y)=0;
  elseif(c == 'w' )
    r(x,y)=1;
    g(x,y)=1;
    b(x,y)=1;
  end
  
end

