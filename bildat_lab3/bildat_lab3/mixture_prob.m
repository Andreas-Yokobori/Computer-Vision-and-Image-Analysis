function [prob] = mixture_prob(image, K, L, mask)
%MIXTURE_PROB Summary of this function goes here
%   Detailed explanation goes here
    
    verbose = 0;
    [rows, cols, channels] = size(image);
    image = im2double(image);
    image_vec = double(reshape(image, rows*cols, channels));
    mask = double(mask);
    mask_vec = reshape(mask, rows*cols, 1);
    masked_img = bsxfun(@times, image, mask);
    image_masked = image_vec(find(mask_vec),:);

        if (verbose > 0)
            figure(1)
            imshow(bsxfun(@times, image, mask), [0,1])
            title('Original image after masking')
%             pause
        end
    
    
    if (sum(mask_vec, 1) > 0)
        tic
        fprintf('Find colour channels with K-means...\n');
        [ segm, mu ] = kmeans_segm(masked_img, K, L, 4321);
        mu = im2double(uint8(mu));
        segm_vec = reshape(segm, rows*cols, 1);
        toc

            if (verbose > 0)
                figure(2)
                imshow(segm, [1, K])
                title('K-means Segmentation')
%                 pause
            end

        [w, sigma, gaussian] = initialize_EM(image_masked, mask_vec, segm_vec, mu, K);
        
            if (verbose >= 1)
                figure(5)
                prod_w_gaussian = bsxfun(@times, gaussian, w);
                prob_masked = sum(prod_w_gaussian, 2) / max(sum(prod_w_gaussian, 2));
                prob = zeros(rows, cols);
                prob(find(mask_vec)) = prob_masked;
                imshow(reshape(prob, rows, cols), [0,1])
                title('Initial probability of each masked pixel')
                pause
            end
        
        for l=1:L
            p_ik = Expectation(w, gaussian, K);
            [mu, sigma, gaussian] = Maximization(image_masked, mu, p_ik, K);
        end
        
        G = zeros(rows*cols, K);
        
        for k=1:K
            G(:,k) = mvnpdf(image_vec, mu(k,:), sigma{k});
        end
        
        prob = G * w';
    else
        prob = zeros(rows*cols, 1);
    end

        if (verbose == 4)
            figure(9)
            imshow(reshape(prob, [rows, cols]), [0, max(max(prob))])
            title('Probability of pixel i being foreground/background')
            pause
        end
end






function [w, sigma, gaussian] = initialize_EM(image_masked, mask_vec, segm_vec, mu, K)
    N = size(image_masked,1);
    w = zeros(1,K);
    sigma = cell(K, 1);
    gaussian = zeros(N, K);
    
    for k=1:K
        segm_cluster_mask = (segm_vec==k) & mask_vec;           
        w(k) = sum(segm_vec(segm_cluster_mask) == k) / sum(segm_vec .* mask_vec ~= 0);
        sigma{k} = eye(3) * 1;
        gaussian(:,k) = mvnpdf(image_masked, mu(k,:), sigma{k});
    end
end





function [p_ik] = Expectation(w, gaussian, K)
    [N,~] = size(gaussian);
    p_ik = zeros(N, K);
    
    for k=1:K
        p_ik(:,k) = w(k) * gaussian(:,k);
        p_ik(:,k) = p_ik(:,k) ./ sum(repmat(w,N,1) .* gaussian, 2);
    end
    p_ik = p_ik ./ repmat(sum(p_ik, 2), 1, K);
end






function [mu, sigma, gaussian] = Maximization(image_masked, mu, p_ik, K)
    N = size(image_masked,1);
    sigma = cell(K, 1);
    gaussian = zeros(N, K);
    w = zeros(1,K);
    
    P_ik = sum(p_ik, 1);
    for k=1:K
        w(k) = (1/N) * P_ik(k);
        if (P_ik(k) ~= 0)
            mu(k,:) = sum(p_ik(:,k)' * image_masked,1) / P_ik(k);
            diff = image_masked - repmat(mu(k,:),N,1);
            sigma{k} = (diff' * (repmat(p_ik(:,k), 1, 3) .* diff)) / P_ik(k);
        else
            mu(k,:) = sum(p_ik(:,k)' * image_masked,1);
            diff = image_masked - repmat(mu(k,:),N,1);
            sigma{k} = (diff' * (repmat(p_ik(:,k), 1, 3) .* diff));
        end
        [~,p] = chol(sigma{k});
        if (p~=0)
            sigma{k} = 0.001 * eye(3);
        end
        
        gaussian(:,k) = mvnpdf(image_masked, mu(k,:), sigma{k});
    end
end



