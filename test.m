clear; clc;

img = imread('shapes_2.jpg');
img = rgb2gray(img);
img = im2double(img);
dt = 0.5;
lambda1 = 1;
lambda2 = 1;
mu_value = 0.2; %0.01*255^2;
iter = 1500;

% [m,n] = size(img);
% [X,Y] = meshgrid(1:m,1:n);
% r = n/2;
% c = [32.5 32.5];
% u = -sqrt((X-c(1)).^2 + (Y-c(2)).^2 ) + 30;
% phi = u;

% u=ones(size(img));
% [p,q]=size(u);
% u(10:p-10,10:q-10)=-1;
% phi = u;


% mask = roipoly(img);
% mask = 2*mask - 1;
% phi = mask;
temp_fig = figure;
figure(temp_fig)
imshow(img)
r = drawrectangle;
mask = createMask(r);
mask = 1 - 2*mask;
close(temp_fig)

phi = mask;
h = figure;
subplot(3,2,1)
imshow(img)
c1_values = zeros(1,iter);
c2_values = zeros(1,iter);
iter_num = 1:iter;
for i = 1:iter
    uxx = centralDiff(phi,2,0);
    uyy = centralDiff(phi,0,2);
    ux = centralDiff(phi,1,0);
    uy = centralDiff(phi,0,1);
    uxy = centralDiff(phi,1,1);
    
    K = (uxx.*uy.^2+uyy.*ux.^2-2*ux.*uy.*uxy)./((sqrt(ux.^2+uy.^2)).*(ux.^2+uy.^2)+10^-3);
    subplot(3,2,5)
    imshow(K)
    title('curvature')
    drawnow;
    [H,H_d] = Heavside(phi,'2');
    c1 = sum(H.*img)/sum(H);
    c2 = sum((1-H).*img)/sum(1-H);
    c1_values(i) = c1;
    c2_values(i) = c2;
    subplot(3,2,3)
    plot(iter_num,c1_values)
    xlim([1,iter])
    ylim([0,1])
    ylabel('c1')
    xlabel('Iterations')
    drawnow;
    subplot(3,2,4)
    plot(iter_num,c2_values)
    xlim([1,iter])
    ylim([0,1])
    ylabel('c2')
    xlabel('Iterations')
    drawnow;
    temp = dt*H_d.*(mu_value*K - lambda1*(img-c1).^2 + lambda2*(img-c2).^2);
    phi = phi + temp;
    subplot(3,2,2)
    imshow(phi>0,[]);hold on;
    contour(phi>0,[0.5 0.5],'r');
    title(i);
    drawnow;
end
