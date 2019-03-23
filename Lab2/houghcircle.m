function [linepar, acc] = houghcircle(curves,magnitude,na,nb,nr,threshold,ncirc,verbose)

value = -1;
pixels = pixelplotcurves(magnitude,curves,value);
[rows,cols] = size(pixels);

%[rows,cols] = size(magnitude);

% a = linspace(0,rows,na);
% b = linspace(0,cols,nn);

acc = zeros(na,nb,nr);
linepar  = zeros(3,ncirc); %3 X ncirc, 
%rho_spacing = 1/(rho(2)-rho(1));


for y = 3:rows-2
    for x = 3:cols-2  
        for r = 10:60 %the possible radius
          for theta = 0:360  %the possible  theta 0 to 360 
             a = x - r * cosd(theta); %polar coordinate for center
             b = y - r * sind(theta);  %polar coordinate for center 
             acc(a,b,r) = acc(a,b,r) + 1; %voting
          end
        end
    end
end
  
%acc = binsmoothiter(acc, 0.25, 0.5, 1);

[pos value] = locmax8(acc);
[dummy indexvector] = sort(value);
nmaxima = size(value, 1);

for idx = 1:circ
%     pos(indexvector(nmaxima - idx + 1), 1)
%     rho(pos(indexvector(nmaxima - idx + 1), 1))
    aidxacc = pos(indexvector(nmaxima - idx + 1), 1);
    bidxacc = pos(indexvector(nmaxima - idx + 1), 2);
    
    
    linepar(:,idx) = [a, b, r]';
end

end