%% Question 1 and 2

clear all;
close all;

u=[5; 9; 17; 17; 5; 125;1];
v=[9;5;9;121;1;1;1];

for i=1:1:size(v,1)
   f=figure;
   set(f,'name',['2-dimensional inverse Fourier Transformation (p=', num2str(u(i)), ', q=', num2str(v(i)), ')'],'numbertitle','off')
   fftwavetemplate(u(i),v(i)); 
   
end

%% Question 5

clear all;
close all;

u=[1;1;1;60;65;70;120;10];  %u passes the point in the center in the 4th image
v=[60;65;70;1;1;1;1;1];     %v passes the point in the center in the 2nd image

for i=1:1:length(u)
   f=figure;
   set(f,'name',['2-dimensional inverse Fourier Transformation (p=', num2str(u(i)), ', q=', num2str(v(i)), ')'],'numbertitle','off')
   fftwavetemplate(u(i),v(i)); 
   
end

%% Question 7, 8 and 9

clear all;
close all;

%Define rectangular test images
F=[zeros(56,128);ones(16,128);zeros(56,128)];
G=F';
H=F+2*G;

%Display the imagescloes
subplot(3,3,1);
showgrey(F);
title('F = ones(16,128)');
subplot(3,3,4);
showgrey(G);
title('G=F''');
subplot(3,3,7);
showgrey(H);
title('H = F+2*G');

%Compute discrete Fourier transform
Fhat=fft2(F);
Ghat=fft2(G);
Hhat=fft2(H);

%Display fourier spectra
subplot(3,3,2);
showgrey(log(1+abs(Fhat)));
title('Fhat=fft2(F)');
subplot(3,3,5);
showgrey(log(1+abs(Ghat)));
title('Ghat=fft2(G)');
subplot(3,3,8);
showgrey(log(1+abs(Hhat)));
title('Hhat=fft2(H)');


subplot(3,3,3);
showgrey(log(1+abs(fftshift(Fhat))));
title('Fhat with fftshift');
subplot(3,3,6);
showgrey(log(1+abs(fftshift(Ghat))));
title('Ghat with fftshift');
subplot(3,3,9);
showgrey(log(1+abs(fftshift(Hhat))));
title('Hhat with fftshift');


%% Question 10

clear all;
close all;

%Define rectangular test images
F=[zeros(56,128);ones(16,128);zeros(56,128)];
G=F';
H=F+2*G;

subplot(3,1,1);
showgrey(F .*G);
title('F.*G');
subplot(3,1,2);
showfs(fft2(F .*G));
test1=fft2(F.*G);
title('showfs(fft2(F.*G))');


subplot(3,1,3);
Fhat=1/128*fft2(F);     %Calculate the fourier transformation of F
Ghat=1/128*fft2(G);     %Calculate the fourier transformation of G
convFG=conv2(Fhat,Ghat);    %Calculate the convolutional of these
convFG=convFG(1:128,1:128);
showfs(convFG);
title('Convolutional of Fhat and Ghat');
%showgrey(log(abs(fftshift(conv2(Fhat,Ghat)))));


%% Question 11

clear all;
close all;


%Define rectangular test images
F=[zeros(60,128);ones(8,128);zeros(60,128)] .* ...
    [zeros(128,48) ones(128,32) zeros(128,48)];
subplot(2,1,1);
showgrey(F);
title('F');
subplot(2,1,2);
showfs(fft2(F));
title('showfs(fft2(F))')

%% Question 12

clear all;
close all;


%Define rectangular test images
F=[zeros(60,128);ones(8,128);zeros(60,128)] .* ...
    [zeros(128,48) ones(128,32) zeros(128,48)];
subplot(5,3,1);
showgrey(F);
title('F');
subplot(5,3,2);
showfs(fft2(F));
title('showfs(fft2(F))')


%Rotation of F
alpha=[30,45,60,90];
for i=1:1:4
    
    G=rot(F,alpha(i));
    subplot(5,3,3*i+1);
    showgrey(G);
    title(['G=rot(F,', num2str(alpha(i)),')']);
    subplot(5,3,3*i+2);
    Ghat=fft2(G);
    showfs(Ghat);
    title('showfs(Ghat)');
    subplot(5,3,3*i+3)
    Hhat=rot(fftshift(Ghat),-alpha(i));
    showgrey(log(1+abs(Hhat)));
    title('Hhat');
end

%% Question 13
clear all;
close all;

img=[phonecalc128, few128, nallo128];

for i=1:1:3

subplot(3,3,i*3-2);
showgrey(img(:,((i-1)*128+1):(i*128)));
pixels = pow2image(img(:,((i-1)*128+1:i*128)), 10^(-10));
subplot(3,3,3*i-1);
showgrey(pixels);
pixels = randphaseimage(img(:,((i-1)*128+1:i*128)));
subplot(3,3,3*i);
showgrey(pixels)
end



