[coins CT] = imread("coins.gif");
corner = imread("noisy_corner.png");
fingerprint = imread("noisy-fingerprint.tif");


figure; imshow(fingerprint);

se = strel('disk',5);

dilated = imdilate(fingerprint, se);

figure; imshow(dilated); title('Dilated Image');

se2 = strel("disk",5);
eroded = imerode(fingerprint, se2);
figure; imshow(eroded); title('Eroded Image');

%coins = 
figure; imshow(coins, CT); title('Original Coin');
se3 = strel("disk",29);
open = imopen(coins, se3);
figure; imshow(open,CT); title('Open Coin');
se4 = strel('disk',9);
erode = imerode(coins, se4);
figure; imshow(erode,CT); title('Eroded Coin');