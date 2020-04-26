%
% This is the main function for the implementation of the Chan-Vese based
% model for active contours without edges
% Input variables
% img - The vector of the image.
% iter - Number of iterations for which phi should evolve.
% mask - Initial mask. Options are 'circle', 'square' or manual mask. Look
% up roipoly for more information
% heavside - '1' or '2'. The type of the heavside function. Refer the
% heavside function for further information
% verbose - Boolean. Updating plots for every iteration.
%


function final_phi = active_contour(img,iter,mask,heavside,verbose)
    dt = 0.1;
    lambda1 = 1;
    lambda2 = 1;
    switch(mask)
        case 'circle'
            [m,n] = size(img);
            [X,Y] = meshgrid(1:m,1:n);
            r = n/2;
            c = [r r];
            u = sqrt( (X-c(1)).^2 + (Y-c(2)).^2 ) - r;
            phi = u;
        case 'square'
            u=ones(size(img));
            [p,q]=size(u);
            u(15:p-15,15:q-15)=-1;
            phi = u;
        case 'manual'
            mask = roipoly(img);
            mask = 2*mask - 1;
            phi = mask;
    end
    if verbose
        h = figure;
    end
    for i = 1:iter
        disp(i)
        uxx = centralDiff(phi,2,0);
        uyy = centralDiff(phi,0,2);
        ux = centralDiff(phi,1,0);
        uy = centralDiff(phi,0,1);
        uxy = centralDiff(phi,1,1);

        K = (uxx.*uy.^2+uyy.*ux.^2-2*ux.*uy.*uxy)./((sqrt(ux.^2+uy.^2)).*(ux.^2+uy.^2)+10^-3);
        [H,H_d] = Heavside(phi,heavside);
        c1 = sum(H.*img)/sum(H);
        c2 = sum((1-H).*img)/sum(1-H);
        temp = dt*H_d.*(K - lambda1*(img-c1).^2 + lambda2*(img-c2).^2);
        phi = phi + temp;
        if verbose
            figure(h)
            imshow(phi>0,[]);hold on;
            contour(phi>0,[0.5 0.5],'r');
            title(i);
            drawnow;
        end
    end
    final_phi = phi;
end