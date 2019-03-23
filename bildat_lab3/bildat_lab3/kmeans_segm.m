function [segmentation, centers] = kmeans_segm(image, K, L, seed)
%Input: 
%K: Number of cluster centers
%L: Number of iterations
%seed: initializing randomization
%Output:
%sementation: with a colour index per pixel
%centers: centers of all clusters in 3D colour space

image=im2double(image);
if length(size(image)) == 3
    [height,width, ~]=size(image);
    shapeImg=reshape(image,width*height,3);
else
    [height]=size(image,1);
    width = 1;
    shapeImg = image;
end


%% Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).
% Randomly initialize the K cluster centers
%centers=[randi([0 255],K,1),randi([0 255],K,1),randi([0 255],K,1)];

%centers=[0 0 0;252 152 2; 255 255 255];
rng(seed);
centers=shapeImg(randi([1 height*width],K,1),:);
% Compute all distances between pixels and cluster centers

distances = pdist2(shapeImg, centers,'euclidean');
segmentation = zeros(1,width*height);
% Iterate L times
for i=1:1:L
    % Assign each pixel to the cluster center for which the distance is minimum
    for row=1:1:width*height
        [~,index]=min(distances(row,:));
        segmentation(1,row)=index;
    end
    % Recompute each cluster center by taking the mean of all pixels assigned to it
    
    
        
    for row=1:1:K 
        if sum(segmentation == row)>0
            centers(row,:)=mean(shapeImg(find(segmentation == row),:));
        else
            %avoid NaN
            centers(row,:)=shapeImg(randi([1 height*width],1,1),:);
        end
    end
    
    % Recompute all distances between pixels and cluster centers
    distances= pdist2(shapeImg, centers,'euclidean');

end
segmentation=reshape(segmentation,height,width);

end
