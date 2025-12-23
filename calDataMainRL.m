function [Result, Point, rlPlotD, trial] = calDataMainRL(FP, trial, dinfo, top)



%算出データを接地期のみ抽出----------------------------------------
Result = resultMatomeRL(FP, trial, dinfo);
%ポイントのデータを算出
Point = savePntDataRL(Result, dinfo, top);

%スティックピクチャー用データまとめ
%セグメントに関する変数の算出---------------------
stand_data.stand.PELc = zeros(length(trial.rPSIS),3);
stand_data.stand.sub_weight = dinfo.weight_kg;
side = "r";
segR = calSegData(trial, stand_data, FP, side,length(FP.GRF));
side = "l";
segL = calSegData(trial, stand_data, FP, side,length(FP.GRF));

rlPlotD = arrangePlotData(segR,  segL,  FP, length(FP.GRF));


%接地期のデータをmatファイルにして保存
% SaveData = Result;
%     save(mat_dir+"_Trial-rResult.mat", "rSaveData")
disp("All step data saved--------------------------")

