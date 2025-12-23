function Joint = calJointKineData(seg,segVar,CS,FP,side,FPno)

distP.ank = FP.COP(FPno).data;
distP.knee = seg.(side+"ANKc");
distP.hip = seg.(side+"KNEEc");
proxiP.ank = seg.(side+"ANKc");
proxiP.knee = seg.(side+"KNEEc");
proxiP.hip = seg.(side+"HIPc");
distF.ank = FP.GRF(FPno).data;
distN.ank = FP.Tz(FPno).data;

bodyseg = setBodySegPara(seg,segVar,CS,side);
[Joint.Fglb,Joint.Tglb,Joint.Pglb,Joint.Oglb] = cal3JointFTP(distP,proxiP,distF,distN,bodyseg);


end