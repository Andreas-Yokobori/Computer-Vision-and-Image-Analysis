K = 15;               % number of clusters used
L = 20;              % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor
image_sigma = 2.0;   % image preblurring scale

I = imread('tiger1.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

tic
[ segm, centers ] = kmeans_segm(I, K, L, seed);
centers
toc
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
% imwrite(Inew,'result2/kmeans1orangeK8L8scale3sigma4.png')
% imwrite(I,'result2/kmeans2orangeK8L8scale3sigma4.png')
% 
% imwrite(Inew,'result2/kmeans1tiger1K15L20scale1sigma2.png')
% imwrite(I,'result2/kmeans2tiger1K15L20scale1sigma2.png')