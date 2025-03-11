%% 
% 
% 
% *Task 1: Co-occurence matrix (texture)*

% task 1

% Read and display the image
f = imread('Test_1.tiff');
imshow(f);
f = rgb2gray(f);
figure;
imshow(f);

% Define offsets for different angles
D = 1; % You can change this to 2, 3, or 4 for different distances
offsets = [0 D; -D D; -D 0; -D -D];

% Calculate and display GLCMs for different angles
glcm_0 = graycomatrix(f, 'offset', offsets(1,:), 'NumLevels', 256, 'Symmetric', true);
glcm_45 = graycomatrix(f, 'offset', offsets(2,:), 'NumLevels', 256, 'Symmetric', true);
glcm_90 = graycomatrix(f, 'offset', offsets(3,:), 'NumLevels', 256, 'Symmetric', true);
glcm_135 = graycomatrix(f, 'offset', offsets(4,:), 'NumLevels', 256, 'Symmetric', true);

% Display GLCMs
figure;
imshow(glcm_0, []);
title('GLCM 0°');

figure;
imshow(glcm_45, []);
title('GLCM 45°');

figure;
imshow(glcm_90, []);
title('GLCM 90°');

figure;
imshow(glcm_135, []);
title('GLCM 135°');

% Calculate the average GLCM
glcm_avg = (glcm_0 + glcm_45 + glcm_90 + glcm_135) / 4;
figure;
imshow(glcm_avg, []);
title('Average GLCM');

% Ensure GLCMs are integer-valued before passing to graycoprops
glcm_0 = uint32(glcm_0);
glcm_45 = uint32(glcm_45);
glcm_90 = uint32(glcm_90);
glcm_135 = uint32(glcm_135);
glcm_avg = uint32(glcm_avg);

% Estimate parameters for the co-occurrence matrices
stats_0 = graycoprops(glcm_0, {'contrast', 'correlation', 'energy', 'homogeneity'});
stats_45 = graycoprops(glcm_45, {'contrast', 'correlation', 'energy', 'homogeneity'});
stats_90 = graycoprops(glcm_90, {'contrast', 'correlation', 'energy', 'homogeneity'});
stats_135 = graycoprops(glcm_135, {'contrast', 'correlation', 'energy', 'homogeneity'});
stats_avg = graycoprops(glcm_avg, {'contrast', 'correlation', 'energy', 'homogeneity'});

% Display the estimated parameters
disp('GLCM 0° Stats:');
disp(stats_0);

disp('GLCM 45° Stats:');
disp(stats_45);

disp('GLCM 90° Stats:');
disp(stats_90);

disp('GLCM 135° Stats:');
disp(stats_135);

disp('Average GLCM Stats:');
disp(stats_avg);

%% 
% *Task 1: Additional Task: Rotate and Resize the Image*

% As an additional task, try to rotate and resize the input image, and rerun the above code. 
% Does orientation and/or image size have an effect?

%  Rotating and resizing the image can affect the texture measures. Here’s how you can test this:

%  Rotate the Image: Rotate the image by a certain angle (e.g., 45°) and recalculate the GLCMs and texture parameters.
% Rotate the image

fprintf('=================================')
fprintf('Task 1: Additional Task: Rotate and Resize the Image')
fprintf('=================================')


%  Rotate and Resize the Image: Resize the image to a different size (e.g., 50%) and recalculate the GLCMs and texture parameters.

f_rotated = imrotate(f, 45);
frr = imresize(f_rotated, 0.5); % Resize to 50% of rotated image size
figure;
imshow(frr);
title('Rotated and Resized Image');


% Calculate and display GLCMs for different angles
glcm_0 = graycomatrix(frr, 'offset', offsets(1,:), 'NumLevels', 256, 'Symmetric', true);
glcm_45 = graycomatrix(frr, 'offset', offsets(2,:), 'NumLevels', 256, 'Symmetric', true);
glcm_90 = graycomatrix(frr, 'offset', offsets(3,:), 'NumLevels', 256, 'Symmetric', true);
glcm_135 = graycomatrix(frr, 'offset', offsets(4,:), 'NumLevels', 256, 'Symmetric', true);

% Display GLCMs
figure;
imshow(glcm_0, []);
title('GLCM 0°');

figure;
imshow(glcm_45, []);
title('GLCM 45°');

figure;
imshow(glcm_90, []);
title('GLCM 90°');

figure;
imshow(glcm_135, []);
title('GLCM 135°');

% Calculate the average GLCM
glcm_avg = (glcm_0 + glcm_45 + glcm_90 + glcm_135) / 4;
figure;
imshow(glcm_avg, []);
title('Average GLCM');

% Ensure GLCMs are integer-valued before passing to graycoprops
glcm_0 = uint32(glcm_0);
glcm_45 = uint32(glcm_45);
glcm_90 = uint32(glcm_90);
glcm_135 = uint32(glcm_135);
glcm_avg = uint32(glcm_avg);

% Estimate parameters for the co-occurrence matrices
stats_0 = graycoprops(glcm_0, {'contrast', 'correlation', 'energy', 'homogeneity'});
stats_45 = graycoprops(glcm_45, {'contrast', 'correlation', 'energy', 'homogeneity'});
stats_90 = graycoprops(glcm_90, {'contrast', 'correlation', 'energy', 'homogeneity'});
stats_135 = graycoprops(glcm_135, {'contrast', 'correlation', 'energy', 'homogeneity'});
stats_avg = graycoprops(glcm_avg, {'contrast', 'correlation', 'energy', 'homogeneity'});

% Display the estimated parameters
disp('GLCM 0° Stats:');
disp(stats_0);

disp('GLCM 45° Stats:');
disp(stats_45);

disp('GLCM 90° Stats:');
disp(stats_90);

disp('GLCM 135° Stats:');
disp(stats_135);

disp('Average GLCM Stats:');
disp(stats_avg);

%% 
% 
% 
% *Task 2: Shape descriptors*

% task 2
% Step 1: Input the image
f = imread('shapes.png');
imshow(f);
title('Original Image');

% Step 2: Invert the image
inverse_f = uint8(255) - f;
figure;
imshow(inverse_f);
title('Inverted Image');

% Step 3: Threshold the image to obtain a proper black and white image
bw = imbinarize(inverse_f(:,:,1)); % Use only one channel for binarization
figure;
imshow(bw);
title('Binary Image');

% Step 4: Calculate shape descriptors using regionprops
s = regionprops(bw, 'Area', 'Perimeter', 'Centroid', 'BoundingBox', 'ConvexHull', ...
    'Eccentricity', 'Orientation', 'MajorAxisLength', 'MinorAxisLength');

% Display the binary image with centroids marked
imshow(bw);
hold on;
centroids = cat(1, s.Centroid);
plot(centroids(:,1), centroids(:,2), 'b*');
title('Centroids of Regions');
hold off;

% Display the shape descriptors for each region
for k = 1:length(s)
    fprintf('Object %d:\n', k);
    fprintf('  Area: %f\n', s(k).Area);
    fprintf('  Perimeter: %f\n', s(k).Perimeter);
    fprintf('  Centroid: [%f, %f]\n', s(k).Centroid);
    fprintf('  BoundingBox: [%f, %f, %f, %f]\n', s(k).BoundingBox);
    fprintf('  Eccentricity: %f\n', s(k).Eccentricity);
    fprintf('  Orientation: %f\n', s(k).Orientation);
    fprintf('  MajorAxisLength: %f\n', s(k).MajorAxisLength);
    fprintf('  MinorAxisLength: %f\n', s(k).MinorAxisLength);
    fprintf('\n');
end


%% 
%