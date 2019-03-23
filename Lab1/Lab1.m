addpath(genpath('DD2423_Lab_Files'))
close all
%% 1

num = 2;
p = 100;
q = 4;
Fhat = zeros(128,128);
Fhat(p,q) = 1;
Fhat2 = zeros(128,128);
Fhat2(p+2*num,q+2*num) = 1;
%figure;
%showgrey(Fhat)

F = ifft2(Fhat);
F2 = ifft2(Fhat2);
 Fabsmax = max(abs(F(:)));
 Fabsmax2 = max(abs(F2(:)));
 figure;
 showgrey(real(F), 64, -Fabsmax, Fabsmax)
 figure;
 showgrey(real(F2), 64, -Fabsmax2, Fabsmax2);
% figure;
% showgrey(imag(F), 64, -Fabsmax, Fabsmax)
% figure;
% showgrey(abs(F), 64, -Fabsmax, Fabsmax)
% figure;
% showgrey(angle(F), 64, -pi, pi)

%% 2

pvec = [5 9 17 17 5 125]';
qvec = [9 5 9 121 1 1]';

for i = 1:size(pvec)
    figure;
    fftwavetemplate(pvec(i),qvec(i))
end

figure;
fftwavetemplate(66,66);