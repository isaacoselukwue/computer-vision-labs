%% Task 1: Extract data and show example
clear; close all; clc;

if ~isfolder("hand_points")
    unzip hand_points.zip
end

% Load all data (do not edit!)
X = zeros(17, 144);

for i = 1:17
    fname = strcat('hand_points/Hand/hand.', num2str(i), '.pts');
    h = table2array(readtable(fname, "FileType", "text"));
    X(i, :) = [h(:,1); h(:,2)]';
end

% Visualisation
j = 1; % try some different values
hand = vec2pts(X(j,:));
figure, scatter(hand(:,1), hand(:,2))
title("Example hand from dataset");
axis equal

%% Task 2: Mean centering

% ...
% Calculate mean hand shape from all examples
X_mean = mean(X, 1);

% Visualize mean hand
mean_hand = vec2pts(X_mean);
figure;
scatter(mean_hand(:,1), mean_hand(:,2));
title("Mean hand shape");
axis equal;

% Subtract mean from each hand to center the data
X_centered = X - repmat(X_mean, size(X, 1), 1);

%% Task 3: PCA

% ...
%% Task 3: PCA

% Compute covariance matrix
C = (X_centered' * X_centered) / (size(X_centered, 1) - 1);

% Compute eigendecomposition
[eigvecs, D] = eig(C);

% Extract eigenvalues and reverse order (highest to lowest)
eigvals = diag(D);
eigvals = flip(eigvals);

% Flip eigenvector matrix to match eigenvalue ordering
eigvecs = fliplr(eigvecs);

%% Task 4: Reconstructing hands

k = 7; % choose any hand you like!
example = X(k, :);
pts = vec2pts(example);
figure; scatter(pts(:, 1), pts(:,2), 14, "b");
axis equal;
hold on;

% Can we "reconstruct" using just a few eigenvectors?
% The vector b represents how much of each is needed:
b = eigvecs.' * (example - X_mean)';

% How many eigenvectors do we need to reconstruct hands well?
k = preserve_var(eigvals, 0.99);
b(k:end) = 0;

recon = X_mean' + eigvecs * b;
pts = vec2pts(recon');
scatter(pts(:,1), pts(:,2), 14, "r");
hold off;
legend("Original", "Reconstructed");
title(strcat("Reconstruction (k = ", num2str(k), ")"));

%% Task 5: Examining modes of variation

figure;
for i = 1:3  % First 3 principal components
    % Create a row of plots for each principal component
    for j = 1:3  % -3*sigma, 0, +3*sigma
        % Initialize b vector (all zeros)
        b = zeros(size(eigvecs, 2), 1);
        
        % Calculate variation amount
        if j == 1
            b(i) = -3 * sqrt(eigvals(i));  % -3*sigma
        elseif j == 3
            b(i) = 3 * sqrt(eigvals(i));   % +3*sigma
        end  % Middle case (j==2) stays at 0
        
        % Reconstruct hand with this variation
        recon = X_mean' + eigvecs * b;
        pts = vec2pts(recon');
        
        % Plot in appropriate subplot location
        subplot(3, 3, (i-1)*3 + j);
        scatter(pts(:,1), pts(:,2), 14);
        axis equal;
        
        % Add title based on position
        if j == 1
            title(sprintf("PC%d: -3σ", i));
        elseif j == 2
            title(sprintf("PC%d: Mean", i));
        else
            title(sprintf("PC%d: +3σ", i));
        end
    end
end

%% Some helper functions (do not edit!)

function face = vec2pts(vec)
    face = reshape(vec, [72, 2]);
end

function k = preserve_var(eigvals, thresh) 
    eigsum = sum(eigvals);
    csum = 0;
    for i = 1:numel(eigvals)
        csum = csum + eigvals(i);
        tv = csum / eigsum;
        if tv > thresh
            k = i;
            break
        end
    end
end
