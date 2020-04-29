function r = delta(f,difference,x,y)
    switch(difference)
        case 0
            r = (0.5)*(translateImage(f,x,y) - translateImage(f,-x,-y));
        otherwise
            r = (difference)*(translateImage(f,x,y) - f);    
    end
end