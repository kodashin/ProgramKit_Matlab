function [F,T,P,O] = cal3JointFTP(distP,proxiP,distF,distN,segvar)

%Ankle joint-------------
segname = "FOOT";
joint = "ANK";
% disp(joint+segname)
distPP = distP.ank;
proxiPP = proxiP.ank;
distNN = distN.ank;
distFF = distF.ank;
seg.seg_mass = segvar.seg_mass.(segname);
seg.seg_acc = segvar.seg_acc.(segname);
seg.seg_omega = segvar.seg_omega.(segname);
seg.seg_moi = segvar.seg_moi.(segname) ;
seg.seg_ro = segvar.seg_ro.(segname);
seg.cg = segvar.cg.(segname);
seg.seg_omegaJoint = segvar.seg_omega.(joint);
PcgD = distPP -seg.cg';
PcgP =  proxiPP - seg.cg';
[ankF2ndG,ankT2ndG,ankP2ndG,ankO2ndG] = calFTP(seg,distFF,distNN,PcgD,PcgP);

%Knee joint-------------
segname = "SHANK";
joint = "KNEE";
distPP = distP.knee;
proxiPP =  proxiP.knee;
distNN = ankT2ndG;
distFF = ankF2ndG;
seg.seg_mass = segvar.seg_mass.(segname);
seg.seg_acc = segvar.seg_acc.(segname);
seg.seg_omega = segvar.seg_omega.(segname);
seg.seg_moi = segvar.seg_moi.(segname) ;
seg.seg_ro = segvar.seg_ro.(segname);
seg.cg = segvar.cg.(segname);
seg.seg_omegaJoint = segvar.seg_omega.(joint);
PcgD = distPP - seg.cg';
PcgP =  proxiPP - seg.cg';
[kneeF2ndG,kneeT2ndG,kneeP2ndG,kneeO2ndG] = calFTP(seg,distFF,distNN,PcgD,PcgP);

%Hip joint-------------
segname = "THIGH";
joint = "HIP";
distPP = distP.hip;
proxiPP = proxiP.hip;
distNN = kneeT2ndG;
distFF = kneeF2ndG;
seg.seg_mass = segvar.seg_mass.(segname);
seg.seg_acc = segvar.seg_acc.(segname);
seg.seg_omega = segvar.seg_omega.(segname);
seg.seg_moi = segvar.seg_moi.(segname) ;
seg.seg_ro = segvar.seg_ro.(segname);
seg.cg = segvar.cg.(segname);
seg.seg_omegaJoint = segvar.seg_omega.(joint);
PcgD = distPP - seg.cg';
PcgP =  proxiPP - seg.cg';
[hipF2ndG,hipT2ndG,hipP2ndG,hipO2ndG] = calFTP(seg,distFF,distNN,PcgD,PcgP);

F.ANK = ankF2ndG;
F.KNEE = kneeF2ndG;
F.HIP = hipF2ndG;

T.ANK = ankT2ndG;
T.KNEE = kneeT2ndG;
T.HIP = hipT2ndG;

P.ANK = ankP2ndG;
P.KNEE = kneeP2ndG;
P.HIP = hipP2ndG;

O.ANK = ankO2ndG;
O.KNEE = kneeO2ndG;
O.HIP = hipO2ndG;




end