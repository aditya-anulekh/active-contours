function r = centralDiff(f,a,b)
    fpc = translateImage(f,1,0);
    fmc = translateImage(f,-1,0);
    fcp = translateImage(f,0,1);
    fcm = translateImage(f,0,-1);
    
    fpp = translateImage(f,1,1);
    fmm = translateImage(f,-1,-1);
    fmp = translateImage(f,-1,1);
    fpm = translateImage(f,1,-1);
    
    if a == 1 & b == 0
        r = 0.5*(fpc-fmc);
    end
    if a == 0 & b == 1
        r = 0.5*(fcp-fcm);
    end
    if a == 2 & b == 0
        r = fpc - 2*f + fmc;
    end
    if a == 0 & b == 2
        r = fcp - 2*f + fcm;
    end
    if a == 1 & b == 1
        r = 0.25*(fpp - fpm - fmp + fmm);
    end
end