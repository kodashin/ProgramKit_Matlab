function JointAngle = calRightAnglesStand(trial,nFr)

%Calculate lower extrimity joint angle-----
HIP_ro = trial.PEL(:,1+4*(nFr-1):4+4*(nFr-1)) \ trial.rTHIGH(:,1+4*(nFr-1):4+4*(nFr-1));
KNEE_ro = trial.rTHIGH(:,1+4*(nFr-1):4+4*(nFr-1)) \ trial.rSHANK(:,1+4*(nFr-1):4+4*(nFr-1));
ANK_ro = trial.rSHANK(:,1+4*(nFr-1):4+4*(nFr-1)) \ trial.rFOOT(:,1+4*(nFr-1):4+4*(nFr-1));
SHOES_ro = trial.rFOOT(:,1+4*(nFr-1):4+4*(nFr-1));% \ ground;
PelFoot_ro = trial.PEL(:,1+4*(nFr-1):4+4*(nFr-1)) \ trial.rFOOT(:,1+4*(nFr-1):4+4*(nFr-1)); 
ForeFOOT_ro = trial.rForeFOOT(:,1+4*(nFr-1):4+4*(nFr-1));
PEL_ro = trial.PEL(:,1+4*(nFr-1):4+4*(nFr-1));
MPMP_ro = trial.rFOOT(:,1+4*(nFr-1):4+4*(nFr-1)) \ trial.rForeFOOT(:,1+4*(nFr-1):4+4*(nFr-1));

% rHIP_ang = Cal_RM_ang_trans(HIP_ro(:,:))';
% rKNEE_ang = Cal_RM_ang_trans(KNEE_ro(:,:))';
% tmp = Cal_RM_ang_trans(ANK_ro(:,:))';
% rANK_ang = tmp;
% tmp = Cal_RM_ang_trans(SHOES_ro(:,:))';
% rSHOES_ang = [180+tmp(1) tmp(2) tmp(1)];
% tmp = Cal_RM_ang_trans(PelFoot_ro(:,:))';
% PelFoot_ang = tmp;
% tmp = Cal_RM_ang_trans(ForeFOOT_ro);
% ForeFOOT_ang = tmp;
% tmp = Cal_RM_ang_trans(PEL_ro(:,:))';
% PEL_ang = tmp;

rHIP_ang = rxyzsolv(HIP_ro(2:4,2:4))';
rKNEE_ang = rxyzsolv(KNEE_ro(2:4,2:4))';
tmp = rxyzsolv(ANK_ro(2:4,2:4))';
rANK_ang = tmp;
tmp = rxyzsolv(SHOES_ro(2:4,2:4))';
rSHOES_ang = [180+tmp(1) tmp(2) tmp(1)];
tmp = rxyzsolv(PelFoot_ro(2:4,2:4))';
PelFoot_ang = tmp;
tmp = rxyzsolv(ForeFOOT_ro);
ForeFOOT_ang = tmp;
tmp = rxyzsolv(PEL_ro(2:4,2:4))';
PEL_ang = tmp;
tmp = 180-rxyzsolv(MPMP_ro);
MPMP_ang = tmp;

JointAngle(1,:) = rHIP_ang;
JointAngle(2,:) = rKNEE_ang;
JointAngle(3,:) = rANK_ang;
JointAngle(4,:) = rSHOES_ang;
JointAngle(5,:) = PelFoot_ang;
JointAngle(6,:) = ForeFOOT_ang;
JointAngle(7,:) = PEL_ang;
JointAngle(8,:) = MPMP_ang;

end