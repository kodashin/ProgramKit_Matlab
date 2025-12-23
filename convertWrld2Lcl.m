function rJoint = convertWrld2Lcl(Kinedata, CS, segVar, side)

KineDataT = Kinedata.Tglb;
KineDataF = Kinedata.Fglb;
KineDataP = Kinedata.Pglb;
FrNum = length(KineDataF.ANK);

for nFr = 1:FrNum
    %ankle coordinate system
    RoMatA = CS.(side+"ANKjoint")(:, 1+4*(nFr-1):4+4*(nFr-1));
    tempDataTA = RoMatA \ [1;KineDataT.ANK(nFr, :)'];
    tempDataFA = RoMatA \ [1;KineDataF.ANK(nFr, :)'];
    tmptmp = RoMatA \ [1;segVar.(side+"FOOT_omegaG")(nFr, :)'];
    tmpA = RoMatA \ [1;segVar.(side+"ANK_omegaG")(nFr, :)'];
    tempDataPA =  tempDataTA(2:4).*tmpA(2:4);
    
    rJoint.Flcl.ANK(nFr, :) = tempDataFA(2:4);
    rJoint.Tlcl.ANK(nFr, :) = [-tempDataTA(2); tempDataTA(3:4)];
    rJoint.Plcl.ANK(nFr, :) = [-tempDataPA(1); tempDataPA(2:3)];
    rJoint.Olcl.ANK(nFr, :) =[-tmpA(2); tmpA(3:4)];
    rJoint.Olcl.FOOT(nFr, :) = tmptmp(2:4);
    
    %foot coordinate system
    RoMat = CS.(side+"FOOT")(:, 1+4*(nFr-1):4+4*(nFr-1));
    tempDataT = RoMat \ [1;KineDataT.ANK(nFr, :)'];
    tempDataF = RoMat \ [1;KineDataF.ANK(nFr, :)'];
    tmp = RoMat \ [1;segVar.(side+"ANK_omegaG")(nFr, :)'];
    tempDataP = tempDataT(2:4) .* tmp(2:4);
    
    rJoint.Flcl.FOOT(nFr, :) = tempDataF(2:4);
    rJoint.Tlcl.FOOT(nFr, :) = tempDataT(2:4);
    rJoint.Plcl.FOOT(nFr, :) = tempDataP;
    rJoint.Olcl.FOOT(nFr, :) = tmp(2:4);
    
    %knee coordinate system
    RoMatK = CS.(side+"KNEEjoint")(:, 1+4*(nFr-1):4+4*(nFr-1));
    tempDataTK = RoMatK \ [1;KineDataT.KNEE(nFr, :)'];
    tempDataFK = RoMatK \ [1;KineDataF.KNEE(nFr, :)'];
    tmpK = RoMatK \ [1;segVar.(side+"KNEE_omegaG")(nFr, :)'];
    tempDataPK = tempDataTK(2:4) .* tmpK(2:4);
    
    rJoint.Flcl.KNEE(nFr, :) = tempDataFK(2:4);
    rJoint.Tlcl.KNEE(nFr, :) = [tempDataTK(2);tempDataTK(3:4)];
    rJoint.Plcl.KNEE(nFr, :) = tempDataPK;
    rJoint.Olcl.KNEE(nFr, :) = tmpK(2:4);
    
     %hip coordinate system
    RoMatH = CS.(side+"HIPjoint")(:, 1+4*(nFr-1):4+4*(nFr-1));
    tempDataTH = RoMatH \ [1;KineDataT.HIP(nFr, :)'];
    tempDataFH = RoMatH \ [1;KineDataF.HIP(nFr, :)'];
    tmpH = RoMatH \ [1;segVar.(side+"HIP_omegaG")(nFr, :)'];
    tempDataPH = tempDataTH(2:4) .* tmpH(2:4);
    
    rJoint.Flcl.HIP(nFr, :) = tempDataFH(2:4);
    rJoint.Tlcl.HIP(nFr, :) = tempDataTH(2:4);
    rJoint.Plcl.HIP(nFr, :) = tempDataPH;
    rJoint.Olcl.HIP(nFr, :) = tmpH(2:4);
    
end

end