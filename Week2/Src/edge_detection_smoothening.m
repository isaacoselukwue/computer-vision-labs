%% loading an image

% this clears the whole workspace and any open figures
clear all; close all; clc;

% load image, and convert to greyscale
RGB = imread("C:\Users\princ\OneDrive\Documents\MATLAB\ComputerVision\Week2\Resources\library.jpg");
figure; imshow(RGB);
size(RGB)

GREY = rgb2gray(RGB);
imshow(GREY); title('Greyscale Image');

% Convert to double precision
GREY_DOUBLE = im2double(GREY);

% Declare the sobel filter
SOBEL_X = [[-1,0,1],[-2,0,2],[-1,0,1]];
SOBEL_Y = [[-1,-2,-1],[0,0,0],[1,2,1]];

%Filter the images with the kernel seperately
G_x = conv2(GREY_DOUBLE, SOBEL_X);
G_y = conv2(GREY_DOUBLE, SOBEL_Y);

% Display the 2 images side-by-side
imshowpair(G_x, G_y, 'montage')

% Show gradient magnitude 
G = sqrt(G_y.^2 + G_x.^2);
imshow(G)

sigma = 0.0000001
G = imgaussfilt(G, sigma);
imshow(G);