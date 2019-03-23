function aVeryLongVariableName = Lvvtilde(inpic, shape)

[dxmask, dymask, dxxmask, dyymask] = delta();

dxymask = conv2(dxmask,dymask,'same');

Lx = filter2(dxmask,inpic,shape);
Ly = filter2(dymask,inpic,shape);

Lxx = filter2(dxxmask,inpic,shape);
Lxy = filter2(dxymask,inpic,shape);
Lyy = filter2(dyymask,inpic,shape);


aVeryLongVariableName = (Lx.^2).*Lxx + 2*Lx.*Ly.*Lxy + (Ly.^2).*Lyy;

end