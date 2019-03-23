function prob = mixture_prob2(image, K, L, mask)

%[height,width,colours] = size(image);


%size_ones = [max(sum(mask,1)),max(sum(mask,2))]; %Size of the mask of ones
[rows,cols,num_color] = size(image);
image_vec = double(reshape(image,rows*cols,num_color));
image_vec_size = size(mask,1)*size(mask,2);
mask_vec = reshape(mask,image_vec_size,1);
masked_image = image_vec(mask_vec == 1,:);
%prob = zeros(image_vec_size,1);
N = sum(sum(mask));
%N = image_vec_size;

c = zeros(N,3); %The rgb values
gaussians = zeros(K,N); %For storing the gaussians
%p_ik = zeros(K,N); %For the probabilities
w_k = zeros(K,1); %For the weights

%mask_resize = ones(size_ones);

red_vals = masked_image(:,1);
green_vals = masked_image(:,2);
blue_vals = masked_image(:,3);

% red = double(red_vals(mask == 1)); %The red values stored as a column vector etc.
% green = double(green_vals(mask == 1));
% blue = double(blue_vals(mask == 1));

%The colours
c(:,1) = reshape(red_vals,N,1);
c(:,2) = reshape(green_vals,N,1);
c(:,3) = reshape(blue_vals,N,1);

% %The masked image
% I(:,:,1) = reshape(red,size_ones);
% I(:,:,2) = reshape(blue,size_ones);
% I(:,:,3) = reshape(green,size_ones);

%Initialize mu_k
L1 = L;
seed = 452;
[segm, mu_k] = kmeans_segm(masked_image, K, L1, seed);

%Initialize sigma_k (cov) and w_k
cov = cell(K,1);
for k = 1:K
    cov{k} = eye(3);
    
    num_pix = sum(sum(segm == k));
    w_k(k,:) = 1/num_pix;
    gaussians(k,:) = mvnpdf(c, mu_k(k,:), cov{k})';
end

for i=1:L
    %Expectation
    w_times_g = bsxfun(@times,w_k,gaussians);
    sums_cluster = sum(w_times_g); %Row-vector with the sums 
                                   %over column of w_k*g_k

    sums_cluster = (sums_cluster == 0) + sums_cluster; %To avoid division with zero, set 0
                                                       %in denominator to 1;
    p_ik = bsxfun(@rdivide,w_times_g,sums_cluster);
    
    %Maximize
    p_ik_sum = sum(p_ik,2);
    w_k = 1/N*p_ik_sum;
    
    dummy_sum = (p_ik_sum == 0) + p_ik_sum; %To avoid division with zero
    
    mu_k = bsxfun(@rdivide,p_ik*c,dummy_sum);
    
    for k=1:K
        diff = bsxfun(@minus,c,mu_k(k,:));
        dummy = repmat((p_ik(k,:))', 1, 3) .* diff;
        debugger1 = diff'*dummy;
        cov{k} = bsxfun(@rdivide,diff'*dummy,dummy_sum(k,:));
        cov{k};
        
        [~,p] = chol(cov{k});
        if (p~=0)
            cov{k} = 0.001 * eye(3);
        end
        
        gaussians(k,:) = mvnpdf(c, mu_k(k,:), cov{k})';
    end
    
   
end

G = zeros(K,rows*cols);
for k = 1:K
    G(k,:) = mvnpdf(image_vec,mu_k(k,:),cov{k})';
end

figure(2);
imshow(bsxfun(@times, image, mask), [0,1])
prob = sum(bsxfun(@times,w_k,G));
%prob(mask_vec == 1) = prob1;

now_return_to_your_original_position = 1;


    

