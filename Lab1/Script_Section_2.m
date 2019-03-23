%% Question 14

clear all;
close all;
t=[0.1; 0.3; 1; 10; 100];
for i=1:1:5
    
    psf=gaussfft(deltafcn(128,128),t(i));
    %surf(psf);
    psf_var=variance(psf);
    subplot(1,5,i);
    showgrey(psf);
    title({['psf with t=', num2str(t(i))];['|',num2str(psf_var(1,1)),'   ',num2str(psf_var(1,2)),'|'];['|',num2str(psf_var(2,1)),'   ',num2str(psf_var(2,2)),'|']});

end
  

%% Question 16

clear all;
close all;

img=[phonecalc128, few128, nallo128];
t=[1;4;16;64;256];

for i=1:1:3
    img_i=img(:,((i-1)*128+1):(i*128));
    for j=1:1:5
        psf=gaussfft(img_i,t(j));
        subplot(3,5,j+(i*5-5));
        showgrey(psf);
        if i==1
            title(['conv with t=',num2str(t(j))]);
        end  
    end
end
