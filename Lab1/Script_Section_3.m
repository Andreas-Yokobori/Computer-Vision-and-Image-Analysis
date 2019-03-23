%% Question 17

% clear all;
% close all;

office=office256;

add=gaussnoise(office,16);
sap=sapnoise(office, 0.1, 255);

%showgrey(office);
subplot(2,4,1);
showgrey(add);
subplot(2,4,5);
showgrey(sap);

t=3; % For add: t=3 and for sap=5
wheight=5; % For add: wheight=5 and for sap=wheight=3
cutoff=0.1; % For add: cutoff=0.2 and for sap=

subplot(2,4,2);
add_gauss=gaussfft(add,t);
showgrey(add_gauss);
subplot(2,4,6);
sap_gauss=gaussfft(sap,t);
showgrey(sap_gauss);

subplot(2,4,3);
add_median=medfilt(add,wheight);
showgrey(add_median);
subplot(2,4,7);
sap_median=medfilt(sap,wheight);
showgrey(sap_median);

subplot(2,4,4);
add_lowpass=ideal(add,cutoff);
showgrey(add_lowpass);
subplot(2,4,8);
sap_lowpass=ideal(sap,cutoff);
showgrey(sap_lowpass);


%% Question 19

clear all;
close all;

img=phonecalc256;
smoothimg_gauss=img;
smoothimg_lowpass=img;
N=5;
for i=1:N
    if i>1
        img=rawsubsample(img);
        
        smoothimg_gauss=gaussfft(smoothimg_gauss,1);
        smoothimg_gauss=rawsubsample(smoothimg_gauss);
        
        smoothimg_lowpass=ideal(smoothimg_lowpass,0.25);
        smoothimg_lowpass=rawsubsample(smoothimg_lowpass);
    end
    subplot(3,N,i);
    showgrey(img);
    subplot(3,N,i+N);
    showgrey(smoothimg_gauss);
    subplot(3,N,i+2*N);
    showgrey(smoothimg_lowpass);
end
  

