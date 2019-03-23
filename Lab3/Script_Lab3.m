%% Section 1 - Own Implementation
addpath('Functions','Images','Images-m','Images-mat')
clear all;
close all;
image=imread('orange.jpg');
[height,width, ~]=size(image);
K=2; %K = 2 does not separates the shadows of the two halves but separates 
L=2;
[segmentation, centers]=kmeans_segm(image,K,L,0);

newImg(:,:,1)=zeros(height,width);
newImg(:,:,2)=zeros(height,width);
newImg(:,:,3)=zeros(height,width);

for i=1:K
    if isnan(centers(i,1))==0
        newImg(:,:,1)=newImg(:,:,1)+(segmentation==i) .* centers(i,1); %r
        newImg(:,:,2)=newImg(:,:,2)+(segmentation==i) .* centers(i,2); %g
        newImg(:,:,3)=newImg(:,:,3)+(segmentation==i) .* centers(i,3); %b
    end
end

imshow(newImg)

%% Section - Template
clear all;
close all;
open kmeans_example

