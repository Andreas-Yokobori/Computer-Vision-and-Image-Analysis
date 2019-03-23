function [linepar, acc] = houghline(curves,magnitude,nrho,ntheta,threshold,nlines,verbose)

value = -1;
pixels = pixelplotcurves(magnitude,curves,value);
[rows,cols] = size(pixels);

%[rows,cols] = size(magnitude);

max_radius = sqrt(rows^2 + cols^2);

theta = linspace(0,359,ntheta);
rho = linspace(0,max_radius,nrho);

acc = zeros(nrho,ntheta);
linepar  = zeros(2,nlines); %2 X nlines, rho 
rho_spacing = 1/(rho(2)-rho(1));



% figure;
% edges = zeros(rows, cols);
% edges = pixelplotcurves(edges, curves, 255);
% showgrey(edges,64)

for i = 3:rows-2
    for j = 3:cols-2        
        if (pixels(i,j) == value)
            for angle_idx = 1:ntheta
                radius = i*cosd(theta(angle_idx)) + j*sind(theta(angle_idx));
                if (radius >= 0)
                    rho_index = round(radius*rho_spacing) + 1;
                    %disp(round(radius*rho_spacing));
                    inc = 1;
                    %inc = round(sqrt((i*(rows-i) + j*(cols-j))))*magnitude(i,j);
                    %if 
                    acc(rho_index,angle_idx) = acc(rho_index,angle_idx) + inc; 
                end 
            end
        end
    end
end

%acc = binsmoothiter(acc, 0.25, 0.5, 1);

[pos value] = locmax8(acc);
[dummy indexvector] = sort(value);
nmaxima = size(value, 1);

for idx = 1:nlines
%     pos(indexvector(nmaxima - idx + 1), 1)
%     rho(pos(indexvector(nmaxima - idx + 1), 1))
    rhoidxacc = pos(indexvector(nmaxima - idx + 1), 1);
    thetaidxacc = pos(indexvector(nmaxima - idx + 1), 2);
    linepar(:,idx) = [rho(rhoidxacc), theta(thetaidxacc)]';
end

% disp(rhoidxacc)
% disp(thetaidxacc)


if verbose > 1
    %Shows the hough space
    figure(6);
    peaks = houghpeaks(acc, nlines);
    imshow(acc, [], 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    plot(theta(peaks(:,2)),rho(peaks(:,1)),'s','color','white');
end

end