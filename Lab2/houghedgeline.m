function [linepar, acc] = houghedgeline(pic,scale,gradmagnthreshold,nrho,ntheta,nlines,verbose)

shape = 'same';
curves = extractedge(pic, scale, gradmagnthreshold, shape);
magnitude = Lv(pic, shape);



[linepar, acc] = houghline(curves,magnitude, nrho, ntheta, gradmagnthreshold, nlines, verbose);
if verbose > 0
    disp(linepar)
end
end
