colour_bandwidth = 20.0; % color bandwidth
radius = 3; %3             % maximum neighbourhood distance
ncuts_thresh = 0.1; %0.1     % cutting threshold
min_area = 1000; %200         % minimum area of segment
max_depth = 8;  %8         % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

theImage = 'tiger2';

I = imread(strcat(theImage,'.jpg'));
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, -colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);

cbStr = strcat('cb',num2str(colour_bandwidth));
rStr = strcat('r',num2str(radius));
thrStr = strcat('thr0',num2str(10*ncuts_thresh));
mdStr = strcat('md',num2str(max_depth));
maStr = strcat('ma',num2str(min_area));

%imwrite(Inew,strcat('result5/normcuts1',theImage,cbStr,rStr,thrStr,mdStr,maStr,'.png'))
imshow(I)
%imwrite(I,'result5/normcuts2,theImage,cbStr,rStr,thrStr,mdStr,maStr,'.png'))

