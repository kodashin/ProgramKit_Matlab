function [out] = rxyzsolv(T)
%Euler angle X→ Y→ Z
beta = asin(-T(3,1));



alphasin = asin(T(3,2)/cos(beta));
alphacos = acos(T(3,3)/cos(beta));



if (alphacos>pi/2 && alphasin>0)
    alpha=pi-alphasin;
end

if (alphacos>pi/2 && alphasin<0)
    alpha=-pi-alphasin;
end


if (alphacos<=pi/2)
    alpha=alphasin;
end



gamasin = asin(T(2,1)/cos(beta));
gamacos = acos(T(1,1)/cos(beta));



if (gamacos>pi/2 && gamasin>0)
    gama=pi-gamasin;
end

if (gamacos>pi/2 && gamasin<0)
    gama=-pi-gamasin;
end

if (gamacos<=pi/2)
    gama=gamasin;
end



out=[alpha*180/pi,beta*180/pi,gama*180/pi];