%% loading an image

% this clears the whole workspace and any open figures
clear all; close all; clc;

% load image, and confirms that it has three (R, G, B) channels
I = imread("Resources/mandril_color.tif");
figure; imshow(I);
size(I)

% examine a single pixel locaton (try using different values)
row = 10; col = 10;
px = I(row, col, :) % rows, columns, channels

%% channels

% extract and display the red channel
R = I(:, :, 1);
figure; imshow(R);  % note the mandril's red nose appears bright

% Task 2(a) write code to display the blue and green channels
G = I(:,:,2);
figure; imshow(G)
B = I(:,:,3);
figure; imshow(B)

%% rows and columns

% let's extract a whole column and plot it
x = R(:, size(I, 2) / 2);
figure; plot(x); xlabel("position"); ylabel("intensity");

% write code to extract a row, and plot it
y = R(round(size(I,1)/2), :)
figure; plot(y); xlabel("position"); ylabel("intensity");

%% calculate min and max

R_min = intmax;
R_max = intmin;

for i = 1:size(R, 1)  % iterate over each row i

    for j = 1:size(R, 2)  % iterate over each column j

        % replace the following pseudocode with MATLAB code:
        % if the pixel value at i,j is less than R_min, update it
        % else, if the pixel is greater than R_max, update it,
        % else, continue
        if R(i,j) < R_min
            R_min = R(i,j);
        elseif R(i,j) > R_max
            R_max = R(i,j);
        else
            continue;
        end

    end
end

R_min
R_max