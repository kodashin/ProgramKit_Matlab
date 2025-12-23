function seg = calSegData(trial, stand_data, FP, side, no)
FR1000 = 1/1000;

seg.rPSIS = trial.rPSIS;
seg.lPSIS = trial.lPSIS;
seg.rASIS = trial.rASIS;
seg.lASIS = trial.lASIS;
seg.lTRO = trial.lTRO;
seg.rTRO = trial.rTRO;

FPno = no;%FP.side_no(FP.side==side);

seg.(side+"TOE") = trial.(side+"TOE");
seg.(side+"HEELc") = trial.(side+"HEELc");
% seg.(side+"TRO") = trial.(side+"TRO");
seg.(side+"BALl") = trial.(side+"BALl");
seg.(side+"BALm") = trial.(side+"BALm");
seg.(side+"HEELc") = trial.(side+"HEELc");
seg.(side+"HEELl") = trial.(side+"HEELl");
seg.(side+"HEELm") = trial.(side+"HEELm");
seg.(side+"ANKl") = trial.(side+"ANKl");
seg.(side+"ANKm") = trial.(side+"ANKm");
seg.(side+"KNEEl") = trial.(side+"KNEEl");
seg.(side+"KNEEm") = trial.(side+"KNEEm");

%骨盤
seg.PSISc = (seg.rPSIS + seg.lPSIS) ./2;
seg.ASISc = (seg.rASIS + seg.lASIS) ./2;
seg.PELc = (seg.PSISc + seg.ASISc) ./2;

seg.PELc_stand = stand_data.stand.PELc;

%股関節，足関節中心，肘関節中心，肩関節中心を算出
side_orginal = side;
tmpR					=trial.rASIS-2.0/3.0*(trial.rASIS-trial.rTRO);
seg.rHIPc			=tmpR+0.18*(trial.lTRO-trial.rTRO);

tmpL					=trial.lASIS-2.0/3.0*(trial.lASIS-trial.lTRO);
seg.lHIPc			=tmpL+0.18*(trial.rTRO-trial.lTRO);

side = "r";
try
seg.(side+"WRc") = (trial.(side+"WRl") + trial.(side+"WRm"))/2;
seg.(side+"ELc") = (trial.(side+"ELl") + trial.(side+"ELm"))/2;
seg.(side+"SHc") = (trial.(side+"SHf") + trial.(side+"SHb"))/2;
seg.EARc= (trial.(side+"EAR") + trial.(side+"EAR"))/2;
seg.NECKc = (trial.STEF + trial.STEB)/2;

catch
    disp("Skipped Whole Body Data")
end
%膝関節中心
seg.(side+"KNEEc") = trial.(side+"KNEEc");
%足関節中心
seg.(side+"ANKc") = trial.(side+"ANKc");
%MP関節中心
seg.(side+"MPc") = (trial.(side+"BALl") + trial.(side+"BALm")) ./ 2;


side = "l";
try
seg.(side+"WRc") = (trial.(side+"WRl") + trial.(side+"WRm"))/2;
seg.(side+"ELc") = (trial.(side+"ELl") + trial.(side+"ELm"))/2;
seg.(side+"SHc") = (trial.(side+"SHf") + trial.(side+"SHb"))/2;
seg.EARc= (trial.(side+"EAR") + trial.(side+"EAR"))/2;
seg.NECKc = (trial.STEF + trial.STEB)/2;

catch
    disp("Skipped Whole Body Data")
end
%膝関節中心
seg.(side+"KNEEc") = trial.(side+"KNEEc");
%足関節中心
seg.(side+"ANKc") = trial.(side+"ANKc");
%MP関節中心
seg.(side+"MPc") = (trial.(side+"BALl") + trial.(side+"BALm")) ./ 2;


side = side_orginal;

nFr = length(trial.rASIS);

%Body segment parameter算出-------------------------------------------------
%sg :col1→thigh col2→shank col3→foot/row1→right row1→left
p.weight = stand_data.stand.sub_weight;
p.switch = "y";
pnt.datBsp = [trial.(side+"TOE") trial.(side+"HEELc") seg.(side+"ANKc") seg.(side+"KNEEc") seg.(side+"HIPc")]';
d=[];
[~, sg]=setSgLside(p, pnt, d);

% %Body CG算出-------------------------------------------------
% pntCG.datBsp = [trial.rHAND seg.rWRc seg.rELc seg.rSHc trial.lHAND seg.lWRc seg.lELc seg.lSHc trial.rTOE seg.rMPc trial.rHEELc trial.rANKc trial.rKNEEc seg.rHIPc trial.lTOE seg.lMPc trial.lHEELc trial.lANKc trial.lKNEEc seg.lHIPc trial.HEAD seg.EARc seg.NECKc trial.rRIB trial.lRIB]';
% d=[];
% p.switch = "f";
% [sgCG, ~]=setSgLside(p, pntCG, d);


%セグメント重心の算出------
tmp = zeros(3, nFr);
tmp = sg(3).cg;
seg.(side+"FOOTG") = tmp;
tmp = zeros(3, nFr);
tmp = sg(2).cg;
seg.(side+"SHANKG") = tmp;
tmp = zeros(3, nFr);
tmp = sg(1).cg;
seg.(side+"THIGHG") = tmp;

%セグメント重量，長さ，慣性モーメント算出-----------
seg.FOOT_len = sg(1, 3).slength;
seg.SHANK_len = sg(1, 2).slength;
seg.THIGH_len = sg(1, 1).slength;
seg.FOOT_mass = sg(1, 3).m;
seg.SHANK_mass = sg(1, 2).m;
seg.THIGH_mass = sg(1, 1).m;
seg.FOOT_MOI = sg(1, 3).Iobj;
seg.SHANK_MOI = sg(1, 2).Iobj;
seg.THIGH_MOI = sg(1, 1).Iobj;
seg.BODY_mass = stand_data.stand.sub_weight;
seg.BODY_CG = zeros(nFr, 3);%sgCG.cg(end-2:end, :);


seg.COPCOG = seg.PELc - FP.COP(FPno).data;
seg.COPCOG_len = vecnorm(seg.COPCOG, 2, 2);
seg.COPCOG_stand = stand_data.stand.PELc;

seg.LEG = seg.(side+"HIPc") - seg.(side+"ANKc");
seg.LEG_len = vecnorm(seg.LEG, 2, 2);
seg.LEG_len_disp1 = seg.LEG_len - seg.LEG_len(1, :);

try
LEGvec_stand = stand_data.stand.(side+"HIPc") - stand_data.stand.(side+"ANKc");
seg.LEGvec_stand = LEGvec_stand;
seg.LEG_len_disp2 = seg.LEG_len - vecnorm(LEGvec_stand);

catch
    
end