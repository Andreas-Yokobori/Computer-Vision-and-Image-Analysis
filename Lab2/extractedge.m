function edgecurves = extractedge(inpic, scale, threshold, shape)

img = discgaussfft(inpic,scale);
if (nargin < 4)
    threshold = 1;
    shape = 'same';
end
threshPic = Lv(img); %An image containing the magnitude of the gradient.
                     %Note that it's the magnitude, i.e.
                     %sqrt(Lx^2+Ly^2) (see Lv.m)

logicalPic = (threshPic - threshold) < 0; %Creates an image of booleans.
%Note the direction of inequality. If the magnitude is larger than the 
%threshold it will be stored as false (0)

logicalPic = -logicalPic; %Sign flips
zeropic = Lvvtilde(img,shape); %Used for the contour

greaterThanZero = -Lvvvtilde(img,shape); %Since the given function "deletes"
%negative values we have to flip the signs of Lvvvtilde (because the
%edges are where it is < 0)

edges = zerocrosscurves(zeropic,greaterThanZero);
edgecurves = thresholdcurves(edges,logicalPic);

end