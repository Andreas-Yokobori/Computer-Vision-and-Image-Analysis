addpath(genpath('DD2423_Lab_Files'))
load canoe256;
nallo = nallo256;
hund1 = double(imread('dog.jpg'));
hund2 = double(imread('dog.tiff'));
phone = phonecalc256;
vad = whatisthis256;

%% 1
% image(nallo)
% colormap(gray(256))
% colormap(cool)
% colormap(hot)
% colorbar;

%showgrey(vad,64,0,70)
%colormap(gray(256))
%axis equal
% for i = 8:-1:1
% showgrey(vad,2^i)
% figure;
% end


%% 2
ninepic = indexpic9;


% image(rawsubsample(phone))
% colormap(gray(256))
% figure;
% image(binsubsample(phone))
%
% colormap(gray(256))

% figure;
% image(rawsubsample(binsubsample(phone)))
% colormap(gray(256))
% figure;
% image(binsubsample(rawsubsample(phone)))
% colormap(gray(256))

%% 3

neg1 = - Canoe;
figure;
showgrey(neg1);
neg2 = 255 - Canoe;
figure;
showgrey(neg2);
nallo = nallo256;
figure;
nallo13 = nallo.^(1/3);
showgrey(nallo13);
figure;
nallocos = cos(nallo/10);
showgrey(nallocos);

figure;
hist(neg1(:))
figure;
hist(neg2(:))

figure;
hist(nallo13(:))
figure;
hist(nallocos(:))