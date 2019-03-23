%% Q 1 (section 1)
tools = few256;
[dxmask, dymask, dxxmask, dyymask] = delta();
dxtools = conv2(tools, dxmask, 'valid');
dytools = conv2(tools, dymask, 'valid');

figure;
subplot(3,1,1);
showgrey(few256);
subplot(3,1,2);
showgrey(dxtools);
subplot(3,1,3);
showgrey(dytools);


%% Q 2,3 (section 2)
clear all;
close all;

tools = few256;
[deltax, deltay] = delta();
dxtoolsconv = conv2(tools, deltax, 'same');
dytoolsconv = conv2(tools, deltay, 'same');

gradmagntools = sqrt(dxtoolsconv .^2 + dytoolsconv .^2);


threshold = [20 35 50 65 80];
for i=1:size(threshold,2)
 
    subplot(1,size(threshold,2),i)
    showgrey((gradmagntools - threshold(i)) > 0);
    
end

%% Q 2,3 (section 2)
imgGauss=godthem256;
imgGauss = gaussfft(imgGauss,0.1);
pixels = Lv(imgGauss);
%pixels = sqrt(pixels);

%threshold = 20^2;
%testvar = (pixels - thresholdtest) > 0;
threshold = [5 10 20 35 50];
for i=1:size(threshold,2)
 
    subplot(1,size(threshold,2),i)
    showgrey((pixels - threshold(i)) > 0);
    
end

%figure;
%histogram(pixels)

%% Q 4,5,6 (sections 3,4)

[dxmask, dymask, dxxmask, dyymask] = delta();

dxymask = conv2(dxmask,dymask,'same');

dxxxmask = conv2(dxmask,dxxmask,'same');
dxxymask = conv2(dxmask,dxymask,'same');
dxyymask = conv2(dxmask,dyymask,'same');
dyyymask = conv2(dymask,dyymask,'same');

[x,y] = meshgrid(-5:5,-5:5);

% filter2(dxxxmask,x.^3,'valid') %Seems to work
% filter2(dxxmask,x.^3,'valid') %Seems to work
% filter2(dxxymask,x.^2.*y,'valid') %Seems to work

house = godthem256;

scale = [0.0001 1.0 4.0 16.0 64.0];

for i = 1:size(scale,2)
    subplot(2,size(scale,2),i)
    contour(Lvvtilde(discgaussfft(house,scale(i)),'same'),[0 0])

    axis('image')
    axis('ij')
end


for i = 1:size(scale,2)
    subplot(2,size(scale,2),i+size(scale,2))
    showgrey(Lvvvtilde(discgaussfft(house,scale(i)),'same') < 0)
end

%% Q5, Q6 for tools

tools = few256;

scale = [0.0001 1.0 4.0 16.0 64.0];
abcd = zeros(size(scale));

for i = 1:size(scale,2)
    subplot(1,size(scale,2),i)
    showgrey(Lvvvtilde(discgaussfft(tools,scale(i)),'same') < 0)
     axis('image')
     axis('ij')
end

%% 7 

inpic = godthem256;
%inpic = few256;
scale = 1;
threshold = 10; %Change the threshold according to scale. Threshold defined in Lv is sqrt:ed
shape = 'same';
curves = extractedge(inpic, scale,threshold,shape);
%curves = extractedge(inpic, scale,shape);
figure(1)
overlaycurves(inpic,curves)


% img = discgaussfft(godthem256,0.0001);
% threshPic = Lv(img);
% logicalPic = (threshPic - 20^2) > 0;
% img = logicalPic.*img;
% 
% showgrey(img)

% The code below is for testing purposes
% figure;
% img = discgaussfft(inpic,4);
% threshold = 5;
%     threshPic = Lv(img);
%     logicalPic = (threshPic - threshold) < 0;
%     logicalPic = -logicalPic;
%     zeropic = Lvvtilde(img,shape);
%     greaterThanZero = -Lvvvtilde(img,shape);
%     edges = zerocrosscurves(zeropic,logicalPic);
%     edgecurves = thresholdcurves(edges,greaterThanZero);

%% Q 8 (section 8)

pic = triangle128;
%pic = houghtest256;
pic = few256;
%pic = phonecalc256;
%pic = godthem256;
scale = 4.0;
gradmagnthreshold = 6; %Change the threshold according to scale. Threshold defined in Lv is sqrt:ed

%curves = extractedge(pic, scale,gradmagnthreshold,shape);

% pixelplotcurves(image, curves, 0)

nrho = 200;
ntheta = 360;
nlines = 10;
verbose = 2; %set 1 to show linepar, 2 to show hough space

[linepar, acc] = houghedgeline(pic,scale,gradmagnthreshold,nrho,ntheta,nlines,verbose);

outcurves = zeros(2,4*(nlines-1) + 1);
for idx = 1:nlines
    x0 = linepar(1,idx)*cosd(linepar(2,idx));
    y0 = linepar(1,idx)*sind(linepar(2,idx));
    dx = 200 * sind(linepar(2,idx));
    dy = 200 * (-cosd(linepar(2,idx)));    
    
    outcurves(1, 4*(idx-1) + 1) = 0; % level, not significant
    outcurves(2, 4*(idx-1) + 1) = 3; % number of points in the curve
    outcurves(2, 4*(idx-1) + 2) = x0-dx;
    outcurves(1, 4*(idx-1) + 2) = y0-dy;
    outcurves(2, 4*(idx-1) + 3) = x0;
    outcurves(1, 4*(idx-1) + 3) = y0;
    outcurves(2, 4*(idx-1) + 4) = x0+dx;
    outcurves(1, 4*(idx-1) + 4) = y0+dy;
end
outcurves;
figure(1)
overlaycurves(pic,outcurves);

%% Test

pic = houghtest256;
scale = 2.0;
gradmagnthreshold = 5; %Change the threshold according to scale. Threshold defined in Lv is sqrt:ed
shape = 'same';
curves = extractedge(pic, scale,gradmagnthreshold,shape);

pixels = pixelplotcurves(pic,curves,-1);
showgrey(pixels)

t = triangle128;
% figure(1);
% showgrey(t)

c = zerocrosscurves(t-128);
figure(2);
overlaycurves(t, c)

b = zerocrosscurves(t);
figure(3);
overlaycurves(t,b)

%% Comparison, with and without smoothing (Q3)

imgGauss=godthem256;
imgGauss = discgaussfft(imgGauss,1);
pixelstest = Lv(imgGauss);
%pixels = sqrt(pixels);

figure(2);
threshold = [5 10 20 35 50 65];
    showgrey((pixelstest - threshold(2)) > 0);
    
%% Hough cicle

