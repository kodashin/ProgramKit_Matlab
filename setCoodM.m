%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function [R,Rx,Ry,Rz]=setCoodM(M,L,C)
% 
%1Ž²–Ú
x=L-M;
unit_x=x./norm(x);
% unit_x=x;

%2Ž²–Ú
a=M-C;
b=L-C;
tmp_s=cross(a,b);
if tmp_s(1,3)>0
    s=tmp_s;
else
    s=-tmp_s;
end
y=cross(unit_x,s);
unit_y=y./norm(y);

%3Ž²–Ú
z=cross(unit_x,unit_y);
unit_z=z./norm(z);


R = zeros(4);
R(1,1) = 1;
R(2:4,1) = C;
R(2:4,2:4) = [unit_x' unit_y' unit_z'];
R(isnan(R)) = 0;


Rx = unit_x;
Ry = unit_y;
Rz = unit_z;

end


