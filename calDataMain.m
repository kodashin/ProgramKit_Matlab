function [Result, Point, seg, PrjctData,CS, SegAng, SoleAng, SegVar, JointParaL, rlPlotD, trial, FP] = calDataMain(FP, trial, dinfo, stand_data, ukiD, nFr_trial, arm, flag, file_head, top, side, FPno)
order = ["1st"  "2nd" "3rd"];
file_head = file_head+"_Step"+order(FPno);

dinfo.weight_N = stand_data.stand.sub_weight_N;
dinfo.weight_kg = stand_data.stand.sub_weight_kg;

%セグメントに関する変数の算出---------------------
seg = calSegData(trial, stand_data, FP, side, FPno);
trial.BODY_CG = zeros(nFr_trial, 3);%seg.BODY_CG';
trial.PELc = seg.PELc;
trial.PELc_stand = stand_data.stand.PELc;

%FPに関する変数の算出--------------------
duration = FP.contactPhase(FPno).data;
GRF = FP.GRF(FPno).data;

%GRFをプロット---------------------
file_headGRF = replace(file_head,"Sumary", "Sumary\COP&GRF");
% showGRFdataXYZ(duration, GRF, flag, side, file_headGRF)

%セグメント座標系の定義＆関節角度，ソール角度算出----------------------------------------------
%セグメント座標系の定義--------
[PrjctData, CS] = calLegCS(trial, seg, FP, FPno, side);
[SegAng, SoleAng] = calAngles(CS, stand_data, ukiD, nFr_trial, side, arm);
FP.GRF_FOOT(FPno).data = PrjctData.GRF_FOOT;

%セグメント重心速度，加速度，重心周り角速度，角加速度算出--------------
SegVar = calSegVar(seg, CS, side);
%関節トルク------------------------------------
%グローバル座標系での算出
JointParaG = calJointKineData(seg, SegVar, CS, FP, side, FPno);
%算出した関節間力，トルク，パワー，関節角速度をグローバル座標系から関節座標系へ投影
JointParaL = convertWrld2Lcl(JointParaG, CS, SegVar, side);

trial.(side+"FOOTG") = seg.(side+"FOOTG");

%算出データを接地期のみ抽出----------------------------------------
Result = resultMatome2(seg, SegVar, FP, SegAng, SoleAng, JointParaL, PrjctData, side, FPno, dinfo);
%ポイントのデータを算出
dinfo.stepNo = order(FPno);
Point = savePntData3(Result, side, dinfo, top);

%シューズ内COPをグラフにして出力
% flag="on"
COPinSHOES = PrjctData.COP_FOOT;
shoes_mkr =  PrjctData.(side+"SHOESmkr_trans");
pnt = round(median(duration));
showCOPinSHOES(COPinSHOES, shoes_mkr, duration, file_headGRF, pnt, flag);

rlPlotD = arrangePlotDataSingle(seg,  FP, FPno, side);


%接地期のデータをmatファイルにして保存
% SaveData = Result;
%     save(mat_dir+"_Trial-rResult.mat", "rSaveData")
disp(order(FPno)+" step data saved--------------------------")

