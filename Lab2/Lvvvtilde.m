function aVeryLongVariableName = Lvvvtilde(inpic, shape)

[dxmask, dymask, dxxmask, dyymask] = delta();

dxymask = conv2(dxmask,dymask,'same');

dxxxmask = conv2(dxmask,dxxmask,'same');
dxxymask = conv2(dxmask,dxymask,'same');
dxyymask = conv2(dxmask,dyymask,'same');
dyyymask = conv2(dymask,dyymask,'same');


Lx = filter2(dxmask,inpic,shape);
Ly = filter2(dymask,inpic,shape);

Lxxx = filter2(dxxxmask,inpic,shape);
Lxxy = filter2(dxxymask,inpic,shape);
Lxyy = filter2(dxyymask,inpic,shape);
Lyyy = filter2(dyyymask,inpic,shape);

aVeryLongVariableName = (Lx.^3).*Lxxx + 3*(Lx.^2).*Ly.*Lxxy + 3*Lx.*(Ly.^2).*Lxyy + (Ly.^3).*Lyyy;
end