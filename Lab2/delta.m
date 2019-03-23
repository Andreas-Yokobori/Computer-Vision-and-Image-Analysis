function [dxmask, dymask, dxxmask, dyymask] = delta()

dxmask = [0 0 0 0 0;0 0 0 0 0;0 -1/2 0 1/2 0;0 0 0 0 0;0 0 0 0 0]';
dymask = [0 0 0 0 0;0 0 0 0 0;0 -1/2 0 1/2 0;0 0 0 0 0;0 0 0 0 0];

dxxmask = [0 0 0 0 0;0 0 0 0 0;0 1 -2 1 0;0 0 0 0 0;0 0 0 0 0]';
dyymask = [0 0 0 0 0;0 0 0 0 0;0 1 -2 1 0;0 0 0 0 0;0 0 0 0 0];

%xcord in vertical, increasing downwards
%ycord horizontal, increasing to the right

end
