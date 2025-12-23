function [CG_posi, CG_vel] = calBodyCG_FP(GRF, sub_weight_kg, v0, p0)

FR1000 = 1/1000;
tmp = GRF*FR1000;
CG_vel = (cumsum(tmp, 1)/sub_weight_kg) + v0;

tmp = GRF*FR1000*FR1000;
CG_posi = (cumsum(tmp, 1))/sub_weight_kg + v0*FR1000 + p0;

