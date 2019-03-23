scale_factor = 1;          % image downscale factor
area = [ 100, 95, 230, 450 ] % image region to train foreground with
%area = [ 80, 150, 400, 300]
K = 15;                      % number of mixture components
alpha = 8.0;                 % maximum edge cost
sigma = 10.0;                % edge cost decay factor

%Itiger = imread('tiger1.jpg');
I = imread('speedphoto.jpg');
I = imresize(I, scale_factor);

% Im = zeros(size(I,2),size(I,1),3);
% Im(:,:,1) = I(:,:,1)';
% Im(:,:,2) = I(:,:,2)';
% Im(:,:,3) = I(:,:,3)';
% 
% I = uint8(Im);

Iback = I;
area = int16(area*scale_factor);
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
% imwrite(Inew,'result6/graphcut1K3.png')
% imwrite(I,'result6/graphcut2K3.png')
% imwrite(prior,'result6/graphcut3K3.png')
subplot(2,2,1); imshow(Inew);
subplot(2,2,2); imshow(I);
subplot(2,2,3); imshow(prior);
