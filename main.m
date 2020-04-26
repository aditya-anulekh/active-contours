%
% This is a demo file for active_contour function
% 
%
clear; clc;

img = imread('shapes.jpg');
img = im2double(img);
phi = active_contour(img,1500,'manual','1',1);

