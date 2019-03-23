%% Spatial
scale_factor = 0.5;       % image downscale factor
spatial_bandwidth = [2.0 5.0 10.0];  % spatial bandwidth
colour_bandwidth = 5.0;   % colour bandwidth
num_iterations = 40;      % number of mean-shift iterations
image_sigma = 1.0;        % image preblurring scale

sz_sb = size(spatial_bandwidth,2);

I = imread('tiger1.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

%figure(1);
for i = 1:sz_sb
segm = mean_shift_segm(I, spatial_bandwidth(i), colour_bandwidth, num_iterations);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
% imwrite(Inew,'result3/meanshift1sb5cb5.png')
% imwrite(I,'result3/meanshift2sb5cb5.png')

    subplot(sz_sb,2,2*i-1); imshow(Inew);
    subplot(sz_sb,2,2*i); imshow(I);
end

%% Colour
scale_factor = 0.5;       % image downscale factor
spatial_bandwidth = 10.0;  % spatial bandwidth
colour_bandwidth = [1.0 2.0 5.0 10.0 20.0];   % colour bandwidth
num_iterations = 40;      % number of mean-shift iterations
image_sigma = 1.0;        % image preblurring scale

sz_cb = size(colour_bandwidth,2);

I = imread('tiger1.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

%figure(2);
for i = 1:sz_cb
segm = mean_shift_segm(I, spatial_bandwidth, colour_bandwidth(i), num_iterations);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
% imwrite(Inew,'result3/meanshift1sb5cb5.png')
% imwrite(I,'result3/meanshift2sb5cb5.png')
    figure(i);
    subplot(1,2,1); imshow(Inew);
    subplot(1,2,2); imshow(I);
end


%% 

scale_factor = 0.5;       % image downscale factor
spatial_bandwidth = 7.0;  % spatial bandwidth
colour_bandwidth = 3.0;   % colour bandwidth
num_iterations = 40;      % number of mean-shift iterations
image_sigma = 1.0;        % image preblurring scale

sz_cb = size(colour_bandwidth,2);

I = imread('tiger3.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);



segm = mean_shift_segm(I, spatial_bandwidth, colour_bandwidth, num_iterations);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
% imwrite(Inew,'result3/meanshift1sb5cb5.png')
% imwrite(I,'result3/meanshift2sb5cb5.png')
    subplot(1,2,1); imshow(Inew);
    subplot(1,2,2); imshow(I);