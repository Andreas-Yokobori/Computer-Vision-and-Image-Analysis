function [linepar, acc] = houghedgecircle(pic,scale,threshold,na,nb,nr,ncirc,verbose)

shape = 'same';
curves = extractedge(pic, scale, gradmagnthreshold, shape);
magnitude = Lv(pic, shape);


[linepar, acc] = houghcircle(curves,magnitude,na,nb,nr,threshold,ncirc,verbose);
if verbose > 0
    disp(linepar)
end
end