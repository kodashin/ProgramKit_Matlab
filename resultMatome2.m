function result = resultMatome2(seg, segVar, FP, segAng, soleAng, jointPL, ProjD, side, num, dinfo)
%返り値の範囲は接地期の±5コマ
%phase：右足接地期
%phase2：左足接地期


FP.GRF(num).data = [FP.GRF(num).data(:,1) -FP.GRF(num).data(:,2) FP.GRF(num).data(:,3)]; 

weight_kg = dinfo.weight_kg;
result.side = side;

FR1000 = 1/1000;
result.extra = 5;
phase = FP.contactPhase(num).data(1)-result.extra:FP.contactPhase(num).data(end)+result.extra;

result.WholeContactPhase = phase;
if phase(1)<1
    phase = 1:phase(end);

end
Cphase = phase(1)- phase(1)+1:phase(end) - phase(1)+1;
len = length(phase);
v0 = mean(segVar.PELc_vel(phase(1):phase(3), :));

result.Contact = phase';
result.GRF = FP.GRF(num).data(phase, :);
GRF = result.GRF;
result.GRFvec_ang(:, 1) = rad2deg(atan2(GRF(:, 2),  GRF(:, 1)));
result.GRFvec_ang(:, 2) = rad2deg(atan2(GRF(:, 3),  GRF(:, 2)));
result.GRFvec_ang(:, 3) = rad2deg(atan2(GRF(:, 1),  GRF(:, 3)));

result.GRF_W = result.GRF/weight_kg;
result.GRF_FOOT = ProjD.GRF_FOOT(phase, :);
result.GRF_FOOT_ang(:,1) = rad2deg(atan2(result.GRF_FOOT(:,2), result.GRF_FOOT(:,1)));%XY
result.GRF_FOOT_ang(:,2) = rad2deg(atan2(result.GRF_FOOT(:,3), result.GRF_FOOT(:,2)));%YZ
result.GRF_FOOT_ang(:,3) = rad2deg(atan2(result.GRF_FOOT(:,3), result.GRF_FOOT(:,1)));%Zx

result.GRF_FOOT_W = result.GRF_FOOT/weight_kg;
result.COP_FOOT = ProjD.COP_FOOT(phase, :);

result.BODY_CG = seg.BODY_CG( phase, :);

GRF = result.GRF_W;
for i = 1:len-1
    tmp(i, :) = ((GRF(i, :)+GRF(i+1, :))*FR1000)/2;

end
for j = 1:len-1
    if j == 1
        result.COG_vel(j, :) = tmp(j, :)+v0;

    else
        result.COG_vel(j, :) = result.COG_vel(j-1, :) + tmp(j, :);

    end
end
% result.name = dinfo.subject+"_"+dinfo.trialNo+"_"+dinfo.action+"_"+dinfo.shoes;
result.PELc = seg.PELc(phase, :);
result.COPCOG = seg.COPCOG(phase, :);
result.COPCOG_len = vecnorm(seg.PELc(phase, :),  2,  2);
result.COPCOG_lenXY = vecnorm(seg.PELc(phase, 1:2),  2,  2);
result.COPCOG_lenYZ = vecnorm(seg.PELc(phase, 2:3),  2,  2);
result.COG_vel_norm = (result.COG_vel.^2)./(vecnorm(result.COG_vel, 2, 2).^2);

result.ANKcCOG = result.PELc - seg.(side+"ANKc")(phase, :);

result.KNEE_c = seg.(side+"KNEEc")(phase, :);
result.HIP_c = seg.(side+"HIPc")(phase, :);
result.COP =  FP.COP(num).data(phase, :);
result.Tz =  FP.Tz(num).data(phase, :);
result.GRFvecYZ_ang =  FP.GRFvecYZ_ang(num).data(phase, :);

result.BALl_trans = ProjD.(side+"BALl_trans")(phase, :);


result.ANK_ang = segAng.(side+"ANK_ang")(phase, :);
result.ANK_ang2 = segAng.(side+"ANK_ang2")(phase, :);
% result.ANK_ang3 = segAng.(side+"ANK_ang"(phase, :) - segAng.(side+"ANK_ang"(phase(1), :);
result.KNEE_ang = segAng.(side+"KNEE_ang")(phase, :);
result.KNEE_ang2 = segAng.(side+"KNEE_ang2")(phase, :);
% result.KNEE_ang3 = segAng.(side+"KNEE_ang"(phase, :) - segAng.(side+"KNEE_ang"(phase(1), :);
result.HIP_ang = segAng.(side+"HIP_ang")(phase, :);
result.HIP_ang2 = segAng.(side+"HIP_ang2")(phase, :);
result.ANK_omgG = segVar.(side+"ANK_omegaG")(phase, :);
result.ANK_omgL = jointPL.Olcl.ANK(phase, :);
result.KNEE_omgG = segVar.(side+"KNEE_omegaG")(phase, :);
result.KNEE_omgL = jointPL.Olcl.KNEE(phase, :);
result.HIP_omgG = segVar.(side+"HIP_omegaG")(phase, :);
result.HIP_omgL = jointPL.Olcl.HIP(phase, :);
result.LEG = seg.LEG(phase, :);
result.LEG_ang = segAng.(side+"LEG_ang")(phase, :);
result.LEG_omg = diff3(result.LEG_ang, FR1000);
result.LEG_len = seg.LEG_len(phase, :);
tmp = seg.LEG_len(phase, :);
result.LEG_len_disp1 = tmp - tmp(1);
result.LEG_len_disp2 = seg.LEG_len(phase, :) - vecnorm(seg.LEGvec_stand);
result.LEG_len_disp3 = tmp - tmp(end);
result.MP_ang = segAng.(side+"MP_ang")(phase, :);
result.ForeFOOT_ang = segAng.(side+"ForeFOOT_ang")(phase, :);
result.FOOT_ang = segAng.(side+"FOOT_ang")(phase, :);
result.FOOT_ang2 = segAng.(side+"FOOT_ang2")(phase, :)-180;
result.FOOT_ang3 = segAng.(side+"FOOT_ang")(phase, :) - segAng.(side+"FOOT_ang")(phase(1), :);
result.SHANK_ang = segAng.(side+"SHANK_ang")(phase, :);
result.THIGH_ang = segAng.(side+"THIGH_ang")(phase, :);

result.ANK_ang_disp = result.ANK_ang - result.ANK_ang(1, :);
result.KNEE_ang_disp = result.KNEE_ang - result.KNEE_ang(1, :);
result.HIP_ang_disp = result.HIP_ang - result.HIP_ang(1, :);
result.FOOT_ang_disp = result.FOOT_ang - result.FOOT_ang(1, :);
result.SHANK_ang_disp = result.SHANK_ang - result.SHANK_ang(1, :);
result.THIGH_ang_disp = result.THIGH_ang - result.THIGH_ang(1, :);

result.LEG_ang_disp = 180 - result.LEG_ang - result.LEG_ang(1, :);
% result.PELc_disp = seg.PELc_disp(phase, :);



% d = filloutliersALL(soleAng.(side+"TOE_ang"(phase, :), "spline;
% result.TOE1_ang = d;
% d = filloutliersALL(soleAng.(side+"MP_ang"(phase, :), "spline;
% result.TOE2_ang = d;
% d = filloutliersALL(soleAng.(side+"MID_ang"(phase, :), "spline;
% result.TOE3_ang = d;
% d = filloutliersALL(soleAng.(side+"HEEL_ang"(phase, :), "spline;
% result.TOE4_ang = d;
% d = filloutliersALL(soleAng.(side+"TOEMID_ang"(phase, :), "spline;
% result.TOEMID_ang = d;
% d = filloutliersALL(soleAng.(side+"MIDMID_ang"(phase, :), "spline;
% result.MIDMID_ang = d;
% d = filloutliersALL(soleAng.(side+"TOE_ang2"(phase, :), "spline;
% result.TOE1_ang2 = d;
% d = filloutliersALL(soleAng.(side+"MP_ang2"(phase, :), "spline;
% result.TOE2_ang2 = d;
% d = filloutliersALL(soleAng.(side+"MID_ang2"(phase, :), "spline;
% result.TOE3_ang2 = d;
% d = filloutliersALL(soleAng.(side+"HEEL_ang2"(phase, :), "spline;
% result.TOE4_ang2 = d;
% d = filloutliersALL(soleAng.(side+"TOEMID_ang2"(phase, :), "spline;
% result.TOEMID_ang2 = d;
% d = filloutliersALL(soleAng.(side+"MIDMID_ang"(phase, :), "spline;
% result.MIDMID_ang2 = d;
% result.TOE_ang3 = soleAng.(side+"TOE_ang3"(phase, :);
% result.MP_ang3 = soleAng.(side+"MP_ang3"(phase, :);
% result.MID_ang3 = soleAng.(side+"MID_ang3"(phase, :);
% result.TOEMID_ang3 = soleAng.(side+"TOEMID_ang3"(phase, :);
% result.XG_ang = soleAng.(side+"XG_ang"(phase, :);
result.COP_shoes = ProjD.COP_FOOT(phase, :);
result.COP_shoes2 = ProjD.COP_ForeFOOT(phase, :);
% result.COP_shoes_vel = diff3(ProjD.COP_FOOT"(phase, :), FR1000);
% result.GRF_shoes = ProjD.GRF_FOOT"(phase, :);
result.COP_glb = FP.COP(num).data(phase, :);
result.TORQUE_lcl = jointPL.Tlcl.ANK(phase, :)/weight_kg;
result.POWER_lcl = jointPL.Plcl.ANK(phase, :)/weight_kg;
result.ANK_forW = jointPL.Flcl.ANK(phase, :)/weight_kg;
result.ANK_torW = jointPL.Tlcl.ANK(phase, :)/weight_kg;
result.ANK_powW = jointPL.Plcl.ANK(phase, :)/weight_kg;
result.KNEE_forW = jointPL.Flcl.KNEE(phase, :)/weight_kg;
result.KNEE_torW = jointPL.Tlcl.KNEE(phase, :)/weight_kg;
result.KNEE_powW = jointPL.Plcl.KNEE(phase, :)/weight_kg;
result.HIP_forW = jointPL.Flcl.HIP(phase, :)/weight_kg;
result.HIP_torW = jointPL.Tlcl.HIP(phase, :)/weight_kg;
result.HIP_powW = jointPL.Plcl.HIP(phase, :)/weight_kg;
result.FOOT_torW = jointPL.Tlcl.FOOT(phase, :)/weight_kg;
result.FOOT_powW = jointPL.Plcl.FOOT(phase, :)/weight_kg;
result.ANK_for = jointPL.Flcl.ANK(phase, :);
result.ANK_tor = jointPL.Tlcl.ANK(phase, :);
result.ANK_torNorm = vecnorm(result.ANK_tor, 2, 2);
result.ANK_pow = jointPL.Plcl.ANK(phase, :);
result.KNEE_for = jointPL.Flcl.KNEE(phase, :);
result.KNEE_tor = jointPL.Tlcl.KNEE(phase, :);
result.KNEE_pow = jointPL.Plcl.KNEE(phase, :);
result.HIP_for = jointPL.Flcl.HIP(phase, :);
result.HIP_tor = jointPL.Tlcl.HIP(phase, :);
result.HIP_pow = jointPL.Plcl.HIP(phase, :);
result.FOOT_tor = jointPL.Tlcl.FOOT(phase, :);
result.FOOT_pow = jointPL.Plcl.FOOT(phase, :);

result.ANK_forangWG(:,1) = rad2deg(atan2(result.ANK_forW (:,2), result.ANK_forW (:,1))); 
result.ANK_forangWG(:,2) = (rad2deg(atan2(result.ANK_forW (:,3), result.ANK_forW (:,2)))-180)+90; 
result.ANK_forangWG(:,3) = rad2deg(atan2(result.ANK_forW (:,1), result.ANK_forW (:,3))); 

result.KNEE_forangWG(:,1) = rad2deg(atan2(result.KNEE_forW (:,2), result.KNEE_forW (:,1))); 
result.KNEE_forangWG(:,2) = (rad2deg(atan2(result.KNEE_forW (:,3), result.KNEE_forW (:,2)))-180)+90; 
result.KNEE_forangWG(:,3) = rad2deg(atan2(result.KNEE_forW (:,1), result.KNEE_forW (:,3))); 


result.COF = FP.COF(num).data(phase, :);
result.COPCOG = seg.COPCOG(phase, :);
result.COPCOG_ang(:, 1) = atan2(result.COPCOG(:, 2), result.COPCOG(:, 1))*180/pi;
result.COPCOG_ang(:, 2) = atan2(result.COPCOG(:, 3), result.COPCOG(:, 2))*180/pi;
result.COPCOG_ang(:, 3) = atan2(result.COPCOG(:, 1), result.COPCOG(:, 3))*180/pi;
result.GRFvecYZ_ang = atan2(GRF(:, 3), GRF(:, 2))*180/pi;
result.GRFvecXY_ang = atan2(GRF(:, 2), GRF(:, 1))*180/pi;
result.GRFvecZX_ang = atan2(GRF(:, 3), GRF(:, 3))*180/pi;
result.LeverArm_glb = getLeverArm(FP.GRF(num).data, FP.COP(num).data, seg.(side+"ANKc"), phase);
result.LeverArm_ANK = getLeverArm(ProjD.GRF_ANK, ProjD.COP_ANK, zeros(length(ProjD.COP_ANK), 3), phase);
COPANKc = seg.(side+"ANKc") - FP.COP(num).data;
result.LeverArm_SP = calLeverArm_ScalarProjection(COPANKc(phase, :), result.GRF);

test = cross(result.LeverArm_ANK, ProjD.GRF_ANK(phase, :));
test1 = dot(result.LeverArm_ANK, ProjD.GRF_ANK(phase, :),2);


result.PEL_vel = segVar.PEL_vel(phase, :);
result.PEL_vel_norm = (result.PEL_vel.^2)./(vecnorm(result.PEL_vel, 2, 2).^2);
result.GRF_norm = vecnorm(result.GRF, 2, 2);
result.GRF_normW = vecnorm(result.GRF_W, 2, 2);
result.PELc = seg.PELc;
result.PELC_contact = seg.PELc(phase, :);
% result.PelFoot_ang = segAng.(side+"PelFoot_ang"(phase, :);
result.PEL_vel_ang = rad2deg(atan2(result.PEL_vel(:, 3), result.PEL_vel(:, 2)));
result.COF_YZ = FP.GRF(num).data(phase, 2) ./ FP.GRF(num).data(phase, 3);
result.COF_XZ = FP.GRF(num).data(phase, 1) ./ FP.GRF(num).data(phase, 3);
result.FOOT_omg = segVar.(side+"FOOT_omegaG")(phase, :);
result.SHANK_omg = segVar.(side+"SHANK_omegaG")(phase, :);
result.THIGH_omg = segVar.(side+"THIGH_omegaG")(phase, :);
result.cumsum = cumsum(result.GRF);
result.cumsum_W = cumsum(result.GRF_W);
% result.SHOES_trans = ProjD.SHOESmkr_trans"(phase, :);
tmp = FP.COP(num).data(phase, :) -seg.(side+"FOOTG")(:, phase)';%seg.(side+"ANKc")(phase, :);
result.FootGCOP = tmp;%vecnorm(tmp, 2, 2);
result.FootGCOP_norm = vecnorm(tmp, 2, 2);
tmp = seg.(side+"ANKc")(phase, :) - seg.(side+"FOOTG")(:, phase)' ;%seg.(side+"ANKc"(phase, :);
result.FootGANKc = tmp;
result.FootGANKc_norm = vecnorm(tmp, 2, 2);
result.FOOTdir_ang = segAng.(side+"FOOTdir_ang")(phase, :);
result.ANKc = seg.(side+"ANKc")(phase, :);
result.ANKc_vel = diff3(result.ANKc, FR1000);
result.FOOTG = seg.(side+"FOOTG")(:, phase)';
result.FOOTG_vel = diff3(result.FOOTG, FR1000);
result.FOOTG_acc = segVar.(side+"FOOTG_acc")(phase, :);
result.SHANKG_vel = segVar.(side+"SHANKG_vel")(phase, :);
result.SHANKG_acc = segVar.(side+"SHANKG_acc")(phase, :);
result.THIGHG_vel = segVar.(side+"THIGHG_vel")(phase, :);
result.THIGHG_acc = segVar.(side+"THIGHG_acc")(phase, :);
tmp = seg.(side+"SHANKG")(:, phase)' - seg.(side+"ANKc")(phase, :);
result.JointC2shankG = vecnorm(tmp, 2, 2);
result.FyFz = result.GRF(:, 2)./result.GRF(:, 3);

result.GRF_ratio = result.GRF./vecnorm(result.GRF, 2, 2);
result.FyAnkTor = result.GRF./result.ANK_tor;
result.FyAnkTorW = result.GRF_W./result.ANK_torW;

tmp = getLeverArm(FP.GRF(num).data, FP.COP(num).data, seg.PELc, phase);
result.RotationalMoment = result.GRF_norm.* tmp;

% result.HEELcHeight = seg.(side+"HEELcHeight"(phase, :);
result.FOOTG = seg.(side+"FOOTG")(:, phase)';
result.SHANKG = seg.(side+"SHANKG")(:, phase)';
result.TIGHG = seg.(side+"THIGHG")(:, phase)';

marm = seg.(side+"HIPc") - FP.COP(num).data;
GRF = FP.GRF(num).data;
MomentCM = cross(marm, GRF);
result.momentCM = MomentCM(phase, :);
result.momentARM = marm(phase, :);

% field_list = fieldnames(result);
% nField = length(field_list);
% for i = 1:nField
%     try
%     result.(string(field_list(i)))(~Cphase, :) = 0;
%
%     catch
%     end
% end