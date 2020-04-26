clear; clc;

img = imread('shapes.jpg');
img = im2double(img);
dt = 0.1;
lambda1 = 1;
lambda2 = 1;
mu_value = 2*255^2;
iter = 500;

% [m,n] = size(img);
% [X,Y] = meshgrid(1:m,1:n);
% r = n/2;
% c = [r r];
% u = sqrt( (X-c(1)).^2 + (Y-c(2)).^2 ) - r;
% phi = u;

u=ones(size(img));
[p,q]=size(u);
u(15:p-15,15:q-15)=-1;
phi = u;


% mask = roipoly(img);
% mask = 2*mask - 1;
% phi = mask;

figure
for i = 1:1500
    uxx = centralDiff(phi,2,0);
    uyy = centralDiff(phi,0,2);
    ux = centralDiff(phi,1,0);
    uy = centralDiff(phi,0,1);
    uxy = centralDiff(phi,1,1);
    
    K = (uxx.*uy.^2+uyy.*ux.^2-2*ux.*uy.*uxy)./((sqrt(ux.^2+uy.^2)).*(ux.^2+uy.^2)+10^-3);
    [H,H_d] = Heavside(phi,'2');
    c1 = sum(H.*img)/sum(H);
    c2 = sum((1-H).*img)/sum(1-H);
    temp = dt*H_d.*(K - lambda1*(img-c1).^2 + lambda2*(img-c2).^2);
    phi = phi + temp;
    imshow(phi>0,[]);hold on;
    contour(phi>0,[0.5 0.5],'r');
    title(i);
    drawnow;
end
