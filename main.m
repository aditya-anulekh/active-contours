%
% This is a demo file for the project
% 
% [1] Active Contours without Edges by Chan and Vese

%% Normal image
clear; clc;
img = imread('images/world.jpg');
if size(img,3) > 1
    img = rgb2gray(img);
end
img = im2double(img);
demo(img)
%% Active Contours on Noisy image (Fig 4 in [1])
clear; clc;
img = imread('images/shapes_1.jpg');
if size(img,3) > 1
    img = rgb2gray(img);
end
img = im2double(img);
img = imnoise(img);
demo(img)

%% Active Conturs on Blurred image (Fig 5 in [1])
clear; clc;
img = imread('images/shapes_1.jpg');
if size(img,3) > 1
    img = rgb2gray(img);
end
img = im2double(img);
dt=0.1;
nitr=1/dt; 
for n=1:nitr

    Upc=translateImage(img,1,0); 
    Umc=translateImage(img,-1,0);
    Ucp=translateImage(img,0,1);
    Ucm=translateImage(img,0,-1);
 
    img=img+dt*(Upc+Umc+Ucp+Ucm-4*img);
end
demo(img)

%% Active Contours on lines and curves (Fig 6 in [1])
clear; clc;
img = imread('images/lines.jpg');
if size(img,3) > 1
    img = rgb2gray(img);
end
img = im2double(img);
demo(img)

%% Groups of objects (Fig 7 in [1])
clear; clc;
img = imread('coins.png');
if size(img,3) > 1
    img = rgb2gray(img);
end
img = im2double(img);
demo(img)