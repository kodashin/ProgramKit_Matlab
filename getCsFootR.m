function R=getCsFootR(helC,baRl,baRm,balC)

s=baRl-baRm;
y=balC-helC;
z=cross(s,y);

unit_y=y/norm(y);
unit_z=z/norm(z);
unit_x=cross(unit_y,unit_z);

R=[unit_x' unit_y' unit_z'];



return;