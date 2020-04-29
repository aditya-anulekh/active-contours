function cont = segmentation(img,mask,iter,figure_handle)
dt = 1;
alpha_value = 1;
temp = centralDiff(img,1,0).^2 + centralDiff(img,0,1).^2;
lambda = 0.01;
g_1 = 1./(1+(temp./lambda^2));
gx = centralDiff(g_1,1,0);
gy = centralDiff(g_1,0,1);

phi1 = mask;
for i = 1:iter
    uxx = centralDiff(phi1,2,0);
    uyy = centralDiff(phi1,0,2);
    ux = centralDiff(phi1,1,0);
    uy = centralDiff(phi1,0,1);
    uxy = centralDiff(phi1,1,1);
    
    
    K = (uxx.*uy.^2+uyy.*ux.^2-2*ux.*uy.*uxy)./((sqrt(ux.^2+uy.^2)).*(ux.^2+uy.^2)+0.01);
    phi1 = phi1 + dt*(g_1.*K.*sqrt(centralDiff(phi1,1,0).^2+centralDiff(phi1,0,1).^2) + ...
        alpha_value*(max(g_1,0).*grad(phi1,'plus')+min(g_1,0).*grad(phi1,'minus')) + ...
        max(gx,0).*delta(phi1,-1,-1,0) + min(gx,0).*delta(phi1,1,1,0) + ...
        max(gy,0).*delta(phi1,-1,0,-1) + min(gy,0).*delta(phi1,1,0,1));
    if mod(i,10) == 0
        figure(figure_handle)
        imshow(phi1)
        title(i)
        drawnow;
    end
end

cont = phi1;
end

