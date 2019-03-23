function [pic_filtered] = gaussfft( pic, t )
%Gaussian convolution implemented via FFT


%Step 1: Create a filter based on a sampled version of the Gaussion function
size_pic = size(pic);
center=[floor(size_pic(1)/2),floor(size_pic(2)/2)];
[x,y] = ndgrid(1:size_pic(1), 1:size_pic(2));
xc = center(1);
yc = center(2);
exponent = ((x-xc).^2 + (y-yc).^2)./(2*t);
gauss_filter = 1 / (2*pi*t)*(exp(-exponent));  %See equation (8)

%Solution with convolutional
%pic_filtered=conv2(pic,gauss_filter);    %Calculate the convolutional of these


% Step 2: Fourier transform the original image and the Gaussian filter

Pic_hat=fft2(pic);
Gauss_hat=fft2(gauss_filter);

% Step 3: Multiply the Fourier transforms

pic_filtered_hat=Pic_hat .* Gauss_hat;

% Step 4: Invert the resulting Fourier transform

pic_filtered=real(fftshift(ifft2(pic_filtered_hat)));

end

