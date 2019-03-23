function prob = mixture_prob1(image, K, L, mask)
%Input: 
%K: Gaussian components
%L: Number of iterations
%mask: same size as image (a pixel that is to be included has a mask value
%1, otherwise 0
%Output:
%prob: image of probabilities that corresponts to p(c_i)

%Let I be a set of pixels and V be a set of K Gaussian components in 3D
%(R,G,B)

%Initialize w_k, 
[height, width]=size(mask);
N=sum(sum(mask));
w_k(1:K,1) = 1;
g_k(1:K,1:N) = 1/K;

%Possible code for p_ik
% w_k_mat = repmat(w_k,1,N); %A KxN matrix of repeated w_k. Used below
% 
% p_ik_non_normalized = w_k_mat.*g_k;
% sum_thing = sum(w_k_mat.*g_k); %A row vector containing the sums in the denominator for each i
% normalizer = repmat(sum_thing,K,1); %Repeated matrix with all the sums
% p_ik = p_ik_non_normalized./normalizer;

sigma_k = cell(K,1);

%Store all pixels for which mask=1 in a Nx3 matrix
index_ones=find(reshape(mask,height*width,1)==1);
mask_matrix(:,1)=single(reshape(image(:,:,1) .* mask,height*width,1));
mask_matrix(:,2)=single(reshape(image(:,:,2) .* mask,height*width,1));
mask_matrix(:,3)=single(reshape(image(:,:,3) .* mask,height*width,1));
c(:,1:3) = mask_matrix(index_ones,:);


%Randomly initialize the K components using masked pixels
K_index=c(randi(size(c,1),K,1));
K_values=c(K_index,:);

%Iterate L times
for j=1:1:L
    %Expectation: Compute probabilities P_ik using masked pixels
    for i=1:1:N
        p_ik(:,i)=w_k .* g_k(:,i) / sum(w_k .* g_k(:,i));
    end
    %Maximization
    
    w_k = 1/N * sum(p_ik,2);
    
    mu_k = p_ik*c ./ sum(p_ik,2);
    
%     for m=1:1:K
%         sigma_k(1:3,1:3,m) = p_ik(m,:) .* (c-mu_k(m,:))' * (c-mu_k(m,:)) ./ sum(p_ik(m,:),2);
%         g_k(m,:) = 1/sqrt((2*pi)^3 * det(sigma_k(1:3,1:3,m))) * exp(-1/2 * (c-mu_k(m,:)) / sigma_k(1:3,1:3,m) * (c-mu_k(m,:))'); %%continue here 
%     end
       
    for m=1:1:K
        mu_k_rep = repmat(mu_k(m,:),N,1);
        c_diff = c-mu_k_rep;
        sigma_k{m} = p_ik(m,:) .* c_diff' * c_diff ./ sum(p_ik(m,:),2);
        g_k(m,:) = 1/sqrt((2*pi)^3 * det(sigma_k{m})) * exp(-1/2 * c_diff / sigma_k{m} * c_diff'); %%continue here 
    end

end

%Compute probabilities p(c_i) in Eq. (3) for all pixels I
