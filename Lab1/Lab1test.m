addpath(genpath('DD2423_Lab_Files'))

num = 2;
p = 100;
q = 100;
Fhat1 = zeros(128,128);
Fhat1(p,q) = 1;
Fhat2 = zeros(128,128);
Fhat2(p-128/2,q-64) = 1;
%figure;
%showgrey(Fhat)

F1 = ifft2(Fhat1);
F2 = ifft2(Fhat2);
F = F1+F2;
 Fabsmax1 = max(abs(F1(:)));
 Fabsmax2 = max(abs(F2(:)));
 figure;
 showgrey(real(F), 64, -Fabsmax1, Fabsmax1)
 figure;
 showgrey(real(F2), 64, -Fabsmax2, Fabsmax2);
 figure;
 showgrey(real(F), 64, -Fabsmax2, Fabsmax2);