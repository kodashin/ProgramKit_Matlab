function segVar = calSegVar(seg, CS, side)
FR1000 = 1/1000;

%セグメント重心速度，加速度，角速度，角加速度の算出 in グローバル座標系----------------
nFr = length(seg.PELc);
segVar.PELc = seg.PELc;
segVar.PEL_vel = diffspl3(seg.PELc, nFr, FR1000);
segVar.(side+"FOOTG_vel") = diffspl3(seg.(side+"FOOTG")', nFr, FR1000);
segVar.(side+"FOOTG_acc") = diffspl3(segVar.(side+"FOOTG_vel"), nFr, FR1000);
segVar.(side+"SHANKG_vel") = diffspl3(seg.(side+"SHANKG")', nFr, FR1000);
segVar.(side+"SHANKG_acc") = diffspl3(segVar.(side+"SHANKG_vel"), nFr, FR1000);
segVar.(side+"THIGHG_vel") = diffspl3(seg.(side+"THIGHG")', nFr, FR1000);
segVar.(side+"THIGHG_acc") = diffspl3(segVar.(side+"THIGHG_vel"), nFr, FR1000);
segVar.PELc_vel = diffspl3(seg.PELc, nFr, FR1000);
segVar.PELc_vel_norm = vecnorm(segVar.PELc_vel, 2, 2);
tmp = diffspl3(segVar.PELc_vel_norm, nFr, FR1000);
segVar.part = find(segVar.PELc_vel_norm>tmp);

segname = "PEL";
segVar.(segname+"_omegaG") = calSegOmegaWRD(CS.(segname), FR1000);
segVar.(segname+"_alphaG") = diffspl3(segVar.(segname+"_omegaG"), nFr, FR1000);

%right side--------
%大腿角速度，角加速度
segname = side+"THIGH";
segVar.(segname+"_omegaG") = calSegOmegaWRD(CS.(segname), FR1000);
segVar.(segname+"_alphaG") = diffspl3(segVar.(segname+"_omegaG"), nFr, FR1000);
%下腿角速度，角加速度
segname = side+"SHANK";
segVar.(segname+"_omegaG") = calSegOmegaWRD(CS.(segname), FR1000);
segVar.(segname+"_alphaG") = diffspl3(segVar.(segname+"_omegaG"), nFr, FR1000);
%足部角速度，角加速度
segname = side+"FOOT";
segVar.(segname+"_omegaG") = calSegOmegaWRD(CS.(segname), FR1000);
segVar.(segname+"_alphaG") = diffspl3(segVar.(segname+"_omegaG"), nFr, FR1000);

%足関節角速度，角加速度
for ii = 1:nFr
    segname = side+"ANKjoint";
    tmp = segVar.(side+"SHANK_omegaG")(ii, :) - segVar.(side+"FOOT_omegaG")(ii, :);
    tmpAngV = CS.(segname)(:, 1+4*(ii-1):4+4*(ii-1))\[1 tmp]';
    segVar.(side+"ANK_omegaG")(ii, :) = tmpAngV(2:4);

    %膝関節角速度，角加速度
    segname = side+"KNEEjoint";
    tmp = segVar.(side+"THIGH_omegaG")(ii, :) - segVar.(side+"SHANK_omegaG")(ii, :);
    tmpAngV = CS.(segname)(:, 1+4*(ii-1):4+4*(ii-1))\[1 tmp]';
    segVar.(side+"KNEE_omegaG")(ii, :) =  tmpAngV(2:4);

    %股関節角速度，角加速度
    segname = side+"HIPjoint";
    tmp = segVar.PEL_omegaG(ii, :) - segVar.(side+"THIGH_omegaG")(ii, :);
    tmpAngV = CS.(segname)(:, 1+4*(ii-1):4+4*(ii-1))\[1 tmp]';
    segVar.(side+"HIP_omegaG")(ii, :) =  tmpAngV(2:4);

end

segVar.(side+"ANK_alphaG") = diffspl3(segVar.(side+"ANK_omegaG"), nFr, FR1000);
segVar.(side+"KNEE_alphaG") = diff3(segVar.(side+"KNEE_omegaG"), FR1000);
segVar.(side+"HIP_alphaG") = diff3(segVar.(side+"HIP_omegaG"), FR1000);

end