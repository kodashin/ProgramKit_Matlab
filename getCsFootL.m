function R=getCsFootL(heelC,balL,balM,balC)


s=balL-balM;
y=balC-heelC;
z=cross(y,s);

unit_y=y/norm(y);
unit_z=z/norm(z);
unit_x=cross(unit_z,unit_y);

R=[unit_x' unit_y' unit_z'];

return;