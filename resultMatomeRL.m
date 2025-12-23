function result = resultMatomeRL(FP, trial, dinfo)
% (segR, segL, segVarR, segVarL, segAngR, segAngL, rjointParaL, ljointParaL, FP, weight)
%返り値の範囲は接地期
%phase:接地期全体

weight = dinfo.weight_kg;
% fpOrder = replace(char(num2str(dinfo.fpOrder))," ","");
% if fpOrder == "12"
%     FP1 = 1;
%     FP2 = 2;
% 
% elseif fpOrder == "21"
%     FP1 = 2;
%     FP2 = 1;
% 
% end

FP1 = 1;
FP2 = 2;

phase = FP.contactPhase(end).data;
phase1 = FP.contactPhase(FP1).data;
phase2 = FP.contactPhase(FP2).data;
FR1000 = 1/1000;

result.extra = 0;

try
    result.BODY_CG = trial.BODY_CG;

catch
    disp("No body CG calculation")

end


if phase(1)<1
    phase = 1:phase(end);

end

result.rCOPlCOP = FP.COP(2).data(phase, :) - FP.COP(1).data(phase, :);
result.rCOPlCOP_len = vecnorm(result.rCOPlCOP,1,2);
result.rCOPlCOP_lenXY = vecnorm(result.rCOPlCOP(:,1:2),1,2);
result.rCOPlCOP_lenYZ = vecnorm(result.rCOPlCOP(:,2:3),1,2);


result.GRF = FP.GRF(end).data(phase, :);
result.GRF1 = FP.GRF(FP1).data(phase, :);
result.GRF2 = FP.GRF(FP2).data(phase, :);

result.GRF_W = result.GRF /weight;
result.GRF_G = [result.GRF(:,1:2) result.GRF(:,3)-weight];
result.GRF_WG = result.GRF_G/weight;
result.GRF1_W = result.GRF1 /weight;
result.GRF2_W = result.GRF2 /weight;


result.ContactPhase = phase;
result.ContactPhase1 = phase1;
result.ContactPhase2 = phase2;



GRF =FP.GRF(end).data(phase, :);

result.GRF = GRF;
result.GRFvec_ang(:,1) = rad2deg(atan2(GRF(:,2), GRF(:,1))); 
result.GRFvec_ang(:,2) = rad2deg(atan2(GRF(:,3), GRF(:,2))); 
result.GRFvec_ang(:,3) = rad2deg(atan2(GRF(:,1), GRF(:,3))); 
result.GRF_G = [GRF(:, [1, 2]) GRF(:, 3)-weight*9.8];
result.GRF_GW = [GRF(:, [1, 2]) GRF(:, 3)-weight*9.8]/weight;
result.GRF_W_norm = vecnorm(result.GRF_W, 2, 2);
result.GRF_G_norm = vecnorm(result.GRF_G, 2, 2);
result.GRF_GW_norm = vecnorm(result.GRF_GW, 2, 2);

vel = (trial.rASIS+trial.lASIS+trial.rPSIS+trial.lPSIS)/4;
result.PELc = vel;
result.PELc_contact = vel(phase,:);
result.PELc_contact1 = vel(phase1,:);
result.PELc_contact2 = vel(phase2,:);
result.PELc_contact_disp = result.PELc_contact - trial.PELc_stand;

result.rANKcCOG_ctct = vel(phase1,:) - trial.rANKc(phase1, :);
result.lANKcCOG_ctct = vel(phase2,:) - trial.lANKc(phase2, :);

result.rANKcCOG_all = vel(phase,:) - trial.rANKc(phase, :);
result.lANKcCOG_all = vel(phase,:) - trial.lANKc(phase, :);

result.PEL_vel = diff3(result.PELc, FR1000);
result.PEL_vel_contact = diff3(result.PELc_contact, FR1000);
result.PEL_vel1 = diff3(vel(phase1,:), FR1000);
result.PEL_vel2 = diff3(vel(phase2,:), FR1000);
result.PEL_vel_ang_contact(:,1) = rad2deg(atan2(result.PEL_vel_contact(:,2), result.PEL_vel_contact(:,1)));
result.PEL_vel_ang_contact(:,2) = rad2deg(atan2(result.PEL_vel_contact(:,3), result.PEL_vel_contact(:,2)));
result.PEL_vel_ang_contact(:,3) = rad2deg(atan2(result.PEL_vel_contact(:,3), result.PEL_vel_contact(:,1)));

v0 = result.PEL_vel_contact(1, :);
p0 = result.PELc_contact(1, :);
GRF = result.GRF;
 [CG_posi, CG_vel] = calBodyCG_FP(GRF, dinfo.weight_kg, v0, p0);
result.CG_vel_contact = CG_vel;
result.CG_posi_contact = CG_posi;



result.WholeContactPhase = phase';
result.PEL_vel_norm = vecnorm(result.PEL_vel, 2, 2);
result.PEL_vel_ratio = result.PEL_vel ./ result.PEL_vel_norm;


result.PELv_ang(:, 1) = rad2deg(atan2(result.PEL_vel(:, 2), result.PEL_vel(:, 1)));%XY plane
result.PELv_ang(:, 2) = rad2deg(atan2(result.PEL_vel(:, 3), result.PEL_vel(:, 2)));%YZ plane
result.PELv_ang(:, 3) = rad2deg(atan2(result.PEL_vel(:, 1), result.PEL_vel(:, 3)));%ZX plane


result.GRF_cumsum = cumsum(result.GRF);
result.GRF1_cumsum = cumsum(result.GRF1);
result.GRF2_cumsum = cumsum(result.GRF2);


result.GRF_cumsum_W = cumsum(result.GRF_W);
result.GRF1_cumsum_W = cumsum(result.GRF1_W);
result.GRF2_cumsum_W = cumsum(result.GRF2_W);


step = dinfo.step;

