%% Load images
clear; close; clc;

%if ~exist("cells/", "dir")
%    unzip("cells.zip");
%end

image_list = dir("Week3/cells/images/*.png");
mask_list = dir("Week3/cells/masks/*.png");

X = {}; Y = {};

for i = 1:length(image_list)

    ifname = image_list(i).name;
    gfname = mask_list(i).name;
    X{i} = imread(strcat("Week3/cells/images/", ifname));
    Y{i} = imread(strcat("Week3/cells/masks/", gfname));
end

idx = 1; % <-- change this to select a different image
I = X{idx}; Yt = logical(Y{idx}(:,:,1));
I_gray = rgb2gray(I);

%% Task 2: Segmentation
level = graythresh(I_gray); %otsuthresh %adaptthresh
BW = imbinarize(I_gray,level);
BW = ~BW
imshowpair(I_gray,BW,'montage')
% ...

%% Tasks 3 & 4: Evaluation
similarity = dice(BW, Yt);

figure
imshowpair(BW, Yt)
title(['Dice Index = ' num2str(similarity)])

%% Task 5: Calculating statistics

% ...