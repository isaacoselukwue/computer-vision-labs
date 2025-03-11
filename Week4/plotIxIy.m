function [Ix, Iy] = plotIxIy(img)
%PlotIxIy returns the image derivatives
%   And plots the joint distribution between derivative values

img=mat2gray(img);

dx = [-1 0 1; -2 0 2; -1 0 1]; % Derivative masks
dy = dx'; %

Ix = conv2(img, dx, 'valid');
Iy = conv2(img, dy, 'valid');

Ix_flat = reshape(Ix.', 1, []);
Iy_flat = reshape(Iy.', 1, []);

% add your code here to plot the data
% and produce plot similar to lectures
% (slide 18)


end