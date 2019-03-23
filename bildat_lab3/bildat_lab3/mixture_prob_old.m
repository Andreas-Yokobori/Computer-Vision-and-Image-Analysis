function prob = mixture_prob(image, K, L, mask)
%Input: 
%K: Gaussian components
%L: Number of iterations
%mask: same size as image (a pixel that is to be included has a mask value
%1, otherwise 0
%Output:
%prob: image of probabilities that corresponts to p(c_i)

%Let I be a set of pixels and V be a set of K Gaussian components in 3D
%(R,G,B)

%Initialize N, mu_k, w_k, cov_k, 
[height, width]=size(mask);
N=sum(sum(mask));

[centers, mu_k] = kmeans_segm(image, K, L, 10);
mu_k = mu_k .* 255;

sigma=10;
cov_k = zeros(3,3,18);
cov_k(1,1,1:18)=sigma^2;
cov_k(2,2,1:18)=sigma^2;
cov_k(3,3,1:18)=sigma^2;

w_k=zeros(K,1);
for m=1:1:K
    w_k(m,1)=1/sum(sum(centers==m));
end

%Store all pixels for which mask=1 in a Nx3 matrix -> c
index_ones = find(reshape(mask,height*width,1)==1);
Ivec(:,1) = single(reshape(image(:,:,1) .* mask,height*width,1));
Ivec(:,2) = single(reshape(image(:,:,2) .* mask,height*width,1));
Ivec(:,3) = single(reshape(image(:,:,3) .* mask,height*width,1));
c(:,1:3) = Ivec(index_ones,:);

% Calculate initial g(k) with w_k, sigma_k and c
g_k = zeros(K,N);
for m=1:1:K
    power(1,:) = sum(((c-mu_k(m,:))/cov_k(:,:,m)) .* (c-mu_k(m,:)),2)';
    g_k(m,:) = 1/sqrt((2*pi)^3 * det(cov_k(1:3,1:3,m))) * exp(-1/2 * power(1,:));
end

%Randomly initialize the K components using masked pixels
K_index=randi(size(c,1),K,1);
K_values=c(K_index,:);

%Initialize zero matrix
power = zeros(K,N);
cov_k = zeros(3,3,K);
p_ik = zeros(K,N);

%Iterate L times
for j=1:1:L
    %Expectation: Compute probabilities P_ik using masked pixels

%     for m=1:1:K
%         p_ik(m,:) = w_k(m) .* g_k(m,:) ./ sum(w_k .* g_k(m,:));
%     end
    
%Possible code for p_ik
w_k_mat = repmat(w_k,1,N); %A KxN matrix of repeated w_k. Used below

p_ik_non_normalized = w_k_mat.*g_k;
sum_thing = sum(w_k_mat.*g_k); %A row vector containing the sums in the denominator for each i
normalizer = repmat(sum_thing,K,1); %Repeated matrix with all the sums
p_ik = p_ik_non_normalized./normalizer;
    
    %Maximization:Update weights, means and covariances using masked pixels
    w_k = 1/N * sum(p_ik,2);
    mu_k = p_ik*c ./ sum(p_ik,2);
    
    for m=1:1:K
        cov_k(1:3,1:3,m) = p_ik(m,:) .* (c-mu_k(m,:))' * (c-mu_k(m,:)) ./ sum(p_ik(m,:),2);
        
        power(1,:) = sum(((c-mu_k(m,:))/cov_k(:,:,m)) .* (c-mu_k(m,:)),2)';
        g_k(m,:) = 1/sqrt((2*pi)^3 * det(cov_k(1:3,1:3,m))) * exp(-1/2 * power(m,:));
    end
       
end

%Compute probabilities p(c_i) in Eq. (3) for all pixels I

prob_N=sum(w_k .* g_k);
prob = zeros(height*width,1);
prob(index_ones) = prob_N; 

