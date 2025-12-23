function point = savePntData3(result, side, dinfo, label)

FR1000 = 1/1000;
point = [];

bodyMass = dinfo.weight_kg;

len = length(result.("GRF_W"));
% phase = 11:len-10;
phase = result.extra+1:len - result.extra-1;
[~, posi] = max(result.("GRF_W")(phase, 2));
posi = posi+10;
[~, posi2] = max(result.("GRF_W")(posi+1:end, 3));
[v, t] = max(result.PELc(:, 3));
flag="off";

[bot, top] = getWavePeak(result.("LEG_len")(phase, :), flag);
[botA, topA] = getWavePeak(result.("ANK_ang")(phase, 1), flag);
[botK, topK] = getWavePeak(result.("KNEE_ang")(phase, 1), flag);
[botH, topH] = getWavePeak(result.("HIP_ang")(phase, 1), flag);
rphase = result.("Contact")(1)-result.("Contact")(1)+1:result.("Contact")(end)-result.("Contact")(1);
gravity = -9.8;
gravityF = gravity*bodyMass;%unit:m/s^2
[fmax, fmax_idx] = max(result.("GRF_W"));
% [fymax, fymax_idx] = max(result.("GRF_W")(:, 2));
% [fzmax, fzmax_idx] = max(result.("GRF_W")(:, 3));
[fmin, fmin_idx] = min(result.("GRF_W"));
% [fymin, fymin_idx] = min(result.("GRF_W")(:, 2));

entX = mean(result.PEL_vel(phase(1)-3:phase(1)-1, 1));
entY = mean(result.PEL_vel(phase(1)-3:phase(1)-1, 2));
entZ = mean(result.PEL_vel(phase(1)-3:phase(1)-1, 3));

entV = mean(result.PEL_vel(phase(1)-3:phase(1)-1, :));

exitX = mean(result.PEL_vel(phase(end)+1:phase(end)+3, 1));
exitY = mean(result.PEL_vel(phase(end)+1:phase(end)+3, 2));
exitZ = mean(result.PEL_vel(phase(end)+1:phase(end)+3, 3));

exitV = mean(result.PEL_vel(phase(end)+1:phase(end)+3, :));

compTest = [dinfo.InputE dinfo.AER dinfo.RER dinfo.MaxDisp];



%データ格納用の空配列を準備
velocity = [];
impulse = [];
impulse_w = [];
aveF_w = [];
aveF = [];
segAng_cntct = [];
segAng_to = [];
torque = [];
maxF = [];
anktorMax = [];
powVar = [];
propMax = [];
footAng = [];
copcog = [];
var1 = [];
trjctCOP = [];
footPos = [];
robo_val = [];

robo_val = [];

%COP関連の変数用に接地期開始点を変更
alpha = 5;

%PELc_velのフェーズ分け
bb = getWavePeak(result.PEL_vel(:, 3), "off");

if bb==11
    bb = bb+1;

end
% PELv_change = bb(end);%max([bb(end) u0]);
data_header = setDataHeader();
tmp = zeros(1,length(data_header));
nLabel = length(label);

%接地時間
ctime = length(phase)*FR1000;
% point = horzcat(point, ctime);

%%%%%%%%%%%%%%ブロックごとに値をまとめる，最後にすべてのブロックの結果をまとめた配列を作成し戻り値として返す%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%骨盤中心速度

velocity = horzcat(velocity, entX);
velocity = horzcat(velocity, entY);
velocity = horzcat(velocity, entZ);
velocity = horzcat(velocity, exitX);
velocity = horzcat(velocity, exitY);
velocity = horzcat(velocity, exitZ);
velocity = horzcat(velocity, max(result.PEL_vel(phase, :)));
velocity = horzcat(velocity, exitX - entX);
velocity = horzcat(velocity, exitY - entY);
velocity = horzcat(velocity, exitZ - entZ);
if length(velocity)~=12
    error("Check Data in velocity")

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%力積
GRF = "GRF";%GRF:オリジナルの地面反力，GRF_W：体重規格化地面反力
[v,i] = max(result.(GRF)(:, 3));
impulse = horzcat(impulse, sum(result.(GRF)(phase, :))* FR1000);
impulse = horzcat(impulse, sum(result.(GRF)(result.(GRF)(:, 1)>0, 1))* FR1000);
impulse = horzcat(impulse, sum(result.(GRF)(result.(GRF)(:, 2)<0, 2))* FR1000);
impulse = horzcat(impulse, sum(result.(GRF)(result.(GRF)(:, 3)<0, 3))* FR1000);
impulse = horzcat(impulse, sum(result.(GRF)(result.(GRF)(:, 1)>0, 1))* FR1000);
impulse = horzcat(impulse, sum(result.(GRF)(result.(GRF)(:, 2)>0, 2))* FR1000);
impulse = horzcat(impulse, sum(result.(GRF)(result.(GRF)(:, 3)>0, 3))* FR1000);
impulse = horzcat(impulse, sum(result.(GRF)(phase(1)+1:i, :))*FR1000);
impulse = horzcat(impulse, sum(result.(GRF)(i:phase(end), :))*FR1000);

if length(impulse)~= 15
    disp("Check Data in impulse")

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%力積
GRF = "GRF_W";%GRF:オリジナルの地面反力，GRF_W：体重規格化地面反力
impulse_w = horzcat(impulse_w, sum(result.(GRF)(phase, :))* FR1000);
impulse_w = horzcat(impulse_w, sum(result.(GRF)(result.(GRF)(:, 1)>0, 1))* FR1000);
impulse_w = horzcat(impulse_w, sum(result.(GRF)(result.(GRF)(:, 2)<0, 2))* FR1000);
impulse_w = horzcat(impulse_w, sum(result.(GRF)(result.(GRF)(:, 3)<0, 3))* FR1000);
impulse_w = horzcat(impulse_w, sum(result.(GRF)(result.(GRF)(:, 1)>0, 1))* FR1000);
impulse_w = horzcat(impulse_w, sum(result.(GRF)(result.(GRF)(:, 2)>0, 2))* FR1000);
impulse_w = horzcat(impulse_w, sum(result.(GRF)(result.(GRF)(:, 3)>0, 3))* FR1000);
impulse = horzcat(impulse, sum(result.(GRF)(phase(1)+1:i, :))*FR1000);
impulse = horzcat(impulse, sum(result.(GRF)(i:phase(end), :))*FR1000);


if length(impulse_w)~= 15
    disp("Check Data in impulse_w")

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%平均力
GRF = "GRF_W";%GRF:オリジナルの地面反力，GRF_W：体重規格化地面反力
aveF = horzcat(aveF, mean(result.(GRF)(phase, :)));
aveF = horzcat(aveF, mean(result.(GRF)(result.(GRF)(:, 1)>0, 1)));
aveF = horzcat(aveF, mean(result.(GRF)(result.(GRF)(:, 2)<0, 2)));
aveF = horzcat(aveF, mean(result.(GRF)(result.(GRF)(:, 3)<0, 3)));
aveF = horzcat(aveF, mean(result.(GRF)(result.(GRF)(:, 1)>0, 1)));
aveF = horzcat(aveF, mean(result.(GRF)(result.(GRF)(:, 2)<0, 2)));
aveF = horzcat(aveF, mean(result.(GRF)(result.(GRF)(:, 3)<0, 3)));
impulse = horzcat(impulse, mean(result.(GRF)(phase(1)+1:i, :)));
impulse = horzcat(impulse, mean(result.(GRF)(i:phase(end), :)));


if length(aveF)~= 15
    disp("Check Data in aveF")

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%平均力
GRF = "GRF";%GRF:オリジナルの地面反力，GRF_W：体重規格化地面反力
aveF_w = horzcat(aveF_w, mean(result.(GRF)(phase, :)));
aveF_w = horzcat(aveF_w, mean(result.(GRF)(result.(GRF)(:, 1)>0, 1)));
aveF_w = horzcat(aveF_w, mean(result.(GRF)(result.(GRF)(:, 2)<0, 2)));
aveF_w = horzcat(aveF_w, mean(result.(GRF)(result.(GRF)(:, 3)<0, 3)));
aveF_w = horzcat(aveF_w, mean(result.(GRF)(result.(GRF)(:, 1)>0, 1)));
aveF_w = horzcat(aveF_w, mean(result.(GRF)(result.(GRF)(:, 2)<0, 2)));
aveF_w = horzcat(aveF_w, mean(result.(GRF)(result.(GRF)(:, 3)<0, 3)));
impulse = horzcat(impulse, mean(result.(GRF)(phase(1)+1:i, :)));
impulse = horzcat(impulse, mean(result.(GRF)(i:phase(end), :)));


if length(aveF_w)~= 15
    disp("Check Data in aveF_w")

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

GRF = "GRF";%GRF:オリジナルの地面反力，GRF_W：体重規格化地面反力
maxF = horzcat(maxF, fmax_idx*FR1000);
maxF = horzcat(maxF, fmin_idx*FR1000);

maxF = horzcat(maxF, max(result.(GRF)(phase, :)));
maxF = horzcat(maxF, min(result.(GRF)(phase, :)));

tmp(1,nLabel+1:nLabel+length(maxF)) = maxF;
tmptmp = [data_header;tmp];

GRF = "GRF_W";%GRF:オリジナルの地面反力，GRF_W：体重規格化地面反力
maxF = horzcat(maxF, max(result.(GRF)(phase, :)));
maxF = horzcat(maxF, min(result.(GRF)(phase, :)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%トルク積
 torque = horzcat(torque, sum(result.("ANK_torW")(phase,:))*FR1000);
 torque = horzcat(torque, sum(result.("KNEE_torW")(phase,:))*FR1000);

%平均トルク
 torque = horzcat(torque, mean(result.("ANK_torW")(phase,:)));
 torque = horzcat(torque, mean(result.("KNEE_torW")(phase,:)));

 if length(torque)~=12
     error("Check data in torque")

 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%接地時の関節角度
segAng_cntct = horzcat(segAng_cntct,  result.("FOOT_ang")(phase(1)+2, :));
segAng_cntct = horzcat(segAng_cntct,  result.("SHANK_ang")(phase(1)+2, :));
segAng_cntct = horzcat(segAng_cntct,  result.("THIGH_ang")(phase(1)+2, :));

segAng_cntct = horzcat(segAng_cntct,  result.("ANK_ang")(phase(1)+2, :));
segAng_cntct = horzcat(segAng_cntct,  result.("KNEE_ang")(phase(1)+2, :));
segAng_cntct = horzcat(segAng_cntct,  result.("HIP_ang")(phase(1)+2, :));

segAng_cntct = horzcat(segAng_cntct,  result.("LEG_len")(phase(1)+2, :));
segAng_cntct = horzcat(segAng_cntct,  result.("LEG_ang")(phase(1)+2, :));
segAng_cntct = horzcat(segAng_cntct,  result.LEG_omg (phase(1)+2, :));

segAng_cntct = horzcat(segAng_cntct, result.("COPCOG")(phase(1)+2, 2));

if length(segAng_cntct)~=26
    error("Check Data in segAnk_cntct")

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% %接地時の関節中心位置
% point = horzcat(point,  result.("ANK_c")(1, :));
% point = horzcat(point,  result.("KNEE_c")(1, :));
% point = horzcat(point,  result.("HIP_c")(1, :));
%
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%離地時の関節角度
segAng_to = horzcat(segAng_to,  result.("FOOT_ang")(phase(end)-2, :));
segAng_to = horzcat(segAng_to,  result.("SHANK_ang")(phase(end)-2, :));
segAng_to = horzcat(segAng_to,  result.("THIGH_ang")(phase(end)-2, :));

segAng_to = horzcat(segAng_to,  result.("ANK_ang")(phase(end)-2, :));
segAng_to = horzcat(segAng_to,  result.("KNEE_ang")(phase(end)-2, :));
segAng_to = horzcat(segAng_to,  result.("HIP_ang")(phase(end)-2, :));

segAng_to = horzcat(segAng_to,  result.("LEG_len")(phase(end)-2, :));
segAng_to = horzcat(segAng_to,  result.("LEG_ang")(phase(end)-2, :));
segAng_to = horzcat(segAng_to,  result.LEG_omg (phase(end)-2, :));

segAng_to = horzcat(segAng_to, result.("ANKcCOG")(phase(end)-2, :));

if length(segAng_to)~=28
    error("Check Data in segAnk_to")

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%鉛直力最大値とその時の変数たち
[v,  i] = max(result.("GRF_W")(:,3));
propMax = horzcat(propMax,  v);
propMax = horzcat(propMax,  result.("GRF_W")(i, :));
propMax = horzcat(propMax,  sum(result.("GRF_W")(phase(1):i, :))*FR1000);
propMax = horzcat(propMax,  sum(result.("GRF_W")(i:phase(end), :))*FR1000);
propMax = horzcat(propMax,  result.("GRFvec_ang")(i, :));
propMax = horzcat(propMax,  result.("ANK_torW")(i, :));
propMax = horzcat(propMax,  result.("KNEE_torW")(i, :));
propMax = horzcat(propMax,  result.("ANK_powW")(i, :));
propMax = horzcat(propMax,  result.("KNEE_powW")(i, :));
propMax = horzcat(propMax, result.("LeverArm_ANK")(i,:));

propMax = horzcat(propMax, result.("ANK_ang")(i, :));
propMax = horzcat(propMax, result.("FOOT_ang")(i, :));
propMax = horzcat(propMax,  result.("LEG_ang")(i, :));
propMax = horzcat(propMax, result.("COP_FOOT")(i, :));

propMax = horzcat(propMax, result.("ANK_ang")(i, :) - result.("ANK_ang")(phase(1), :));
propMax = horzcat(propMax, result.("FOOT_ang")(i, :) - result.("FOOT_ang")(phase(1), :));
propMax = horzcat(propMax,  result.("LEG_ang")(i, :) - result.("LEG_ang")(phase(1), :));
propMax = horzcat(propMax,  result.("COPCOG")(i, :) - result.("COPCOG")(phase(1), :));


if length(propMax)~=52
    error("Check data in propMax")

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%パワー関連変数
imp = sum(result.GRF_W(phase, :))*FR1000;

[v, i] = max(result.GRF_W(:,3));

powVar = horzcat(powVar, max(result.("ANK_powW")(phase, :)));
powVar = horzcat(powVar, max(result.("KNEE_powW")(phase, :)));
powVar = horzcat(powVar, max(result.("HIP_powW")(phase, :)));

ankW =  sum(result.("ANK_powW")(phase, :))*FR1000;
kneeW = sum(result.("KNEE_powW")(phase, :))*FR1000;
hipW = sum(result.("HIP_powW")(phase, :))*FR1000;

ankW1 =  sum(result.("ANK_powW")(phase(1):i, :))*FR1000;
kneeW1 = sum(result.("KNEE_powW")(phase(1):i, :))*FR1000;
hipW1 = sum(result.("HIP_powW")(phase(1):i, :))*FR1000;

ankW2 =  sum(result.("ANK_powW")(i:phase(end), :))*FR1000;
kneeW2 = sum(result.("KNEE_powW")(i:phase(end), :))*FR1000;
hipW2 = sum(result.("HIP_powW")(i:phase(end), :))*FR1000;

powVar = horzcat(powVar, ankW);
powVar = horzcat(powVar, ankW1);
powVar = horzcat(powVar, ankW2);

powVar = horzcat(powVar, kneeW);
powVar = horzcat(powVar, kneeW1);
powVar = horzcat(powVar, kneeW2);

powVar = horzcat(powVar, hipW);
powVar = horzcat(powVar, hipW1);
powVar = horzcat(powVar, hipW2);

tgt = "ANK_powW";
tmp = result.(tgt)(phase, :);
ankPosW = sum(tmp(tmp(:,1)>0, :))*FR1000;
ankNegW = sum(tmp(tmp(:,1)<0, :))*FR1000;
powVar = horzcat(powVar, ankPosW);
powVar = horzcat(powVar, ankNegW);

tgt = "KNEE_powW";
tmp = result.(tgt)(phase, :);
kneePosW = sum(tmp(tmp(:,1)>0, :))*FR1000;
kneeNegW = sum(tmp(tmp(:,1)<0, :))*FR1000;
if length(kneePosW)<3
    kneePosW = zeros(1, 3);

end
if length(kneeNegW)<3
    kneeNegW = zeros(1, 3);

end

powVar = horzcat(powVar, kneePosW);
powVar = horzcat(powVar, kneeNegW);

tgt = "HIP_powW";
tmp = result.(tgt)(phase, :);
hipPosW = sum(tmp(tmp(:,1)>0, :))*FR1000;
hipNegW = sum(tmp(tmp(:,1)<0, :))*FR1000;
if length(hipPosW)<3
    hipPosW = zeros(1, 3);

end
if length(hipNegW)<3
    hipNegW = zeros(1, 3);

end

powVar = horzcat(powVar, hipPosW);
powVar = horzcat(powVar, hipNegW);

powVar = horzcat(powVar, imp(3)/ankW(1));
powVar = horzcat(powVar, imp(3)/ankPosW(1));
powVar = horzcat(powVar, imp(3)/ankNegW(1));
powVar = horzcat(powVar, imp(3)/kneeW(1));
powVar = horzcat(powVar, imp(3)/kneePosW(1));
powVar = horzcat(powVar, imp(3)/kneeNegW(1));
powVar = horzcat(powVar, imp(3)/hipW(1));
powVar = horzcat(powVar, imp(3)/hipPosW(1));
powVar = horzcat(powVar, imp(3)/hipNegW(1));


if length(powVar)~=63
    error("Check data in powVar")

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%足関節底屈トルクmin時の地面反力
[v,  i] = min(result.("ANK_torW"));
anktorMax = horzcat(anktorMax, result.("ANK_torW")(i(1),:));
anktorMax = horzcat(anktorMax, result.("KNEE_torW")(i(1),:));
anktorMax = horzcat(anktorMax, result.("HIP_torW")(i(1),:));

anktorMax = horzcat(anktorMax, result.("ANK_ang")(i(1),:));
anktorMax = horzcat(anktorMax, result.("KNEE_ang")(i(1),:));
anktorMax = horzcat(anktorMax, result.("HIP_ang")(i(1),:));

anktorMax = horzcat(anktorMax, result.("FOOT_ang")(i(1),:));
anktorMax = horzcat(anktorMax, result.("SHANK_ang")(i(1),:));
anktorMax = horzcat(anktorMax, result.("LEG_ang")(i(1),:));

anktorMax = horzcat(anktorMax, result.("GRF_W")(i(1),:));
anktorMax = horzcat(anktorMax, result.("GRFvec_ang")(i(1),:));

anktorMax = horzcat(anktorMax, result.("LeverArm_ANK")(i(1),:));
anktorMax = horzcat(anktorMax, result.("COP_shoes")(i(1),:));

ankVec = result.("COP")(i(1),:)- result.("ANK_ang")(i(1),:);
footgVec = result.("COP")(i(1),:)- result.("FOOTG")(i(1),:);
grfVec = result.("GRF")(i(1),:);
b = grfVec;
a = ankVec;
anktorMax = horzcat(anktorMax, rad2deg(acos(dot(a, b)/(norm(a)*norm(b)))));
a = footgVec;
anktorMax = horzcat(anktorMax, rad2deg(acos(dot(a, b)/(norm(a)*norm(b)))));

if length(anktorMax)~=41
    error("Check Data in anktorMax")

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% % % point = horzcat(point, );
% % % figure()
% % % plot(result.rANK_tor(:,1),"k-")
% % % yyaxis right
% % % hold on
% % % plot(result.rGRF(:,3), "k--")
% % % hold on
% % % plot(i(1), result.("ANK_tor")(i(1),:), "ro")
% % % hold on
% % % plot(i(1), result.rGRF(i(1),3), "bo")
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %足関節角度，膝関節角度と足関節トルク，膝関節トルク，地面反力
% [v ,i] = max(result.("ANK_ang")(round(len/2):end,:));
% i = i + round(len/2)-1;
% var1 = horzcat(var1, v);
% var1 = horzcat(var1, result.("LEG_ang")(i(1),:));
% var1 = horzcat(var1, result.("FOOT_ang")(i(1),:));
% var1 = horzcat(var1, result.("SHANK_ang")(i(1),:));
% var1 = horzcat(var1, result.("ANK_torW")(i(1),:));
% var1 = horzcat(var1, result.("LeverArm_ANK")(i(1),:));
% var1 = horzcat(var1, result.("KNEE_torW")(i(1),:));
% var1 = horzcat(var1, result.("GRF_W")(i(1),:));
% var1 = horzcat(var1, result.("GRF_norm")(i(1),:));
% var1 = horzcat(var1, result.("COP_shoes")(i(1),:));
% 
% 
% if length(var1)~=28
%     error("Check Data in var1")
% 
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%COPCOG距離関連の変数
copcog = horzcat(copcog, result.("COPCOG_len")(phase(1),:));
copcog = horzcat(copcog, result.("COPCOG_lenXY")(phase(1),:));
copcog = horzcat(copcog, result.("COPCOG_lenYZ")(phase(1),:));
copcog = horzcat(copcog, result.("LEG_ang")(phase(1),:));

if length(copcog)~=6
    error("Check Data in copcog")

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %足部角度変化とCOP，力積の関係
% [vv, ii] = max(result.("FOOT_ang")(phase,:));
% [b, t] = getWavePeak2(result.("FOOT_ang")(phase,1), "on", "time");
% 
% v = vv;
% i = ii;
% if i(1) < 10 
%     footAng = horzcat(footAng, zeros(1, 90));
% 
% else
%     % figure();
%     % plot(1:length(phase), result.("FOOT_ang")(phase, 1));
%     % hold on
%     % plot(i(1), result.("FOOT_ang")(phase(i(1)), 1), "ro");
%     % saveas(gca, dinfo.res_dir+"FootAngle"+dinfo.trialNo+"_"+dinfo.subject+"_"+dinfo.stepNo+"_FootAngleMax.png");
%     % close all;
% 
    ankDiff = result.("ANK_ang")(phase(end),:) - result.("ANK_ang")(phase(1),:);
    kneeDiff = result.("KNEE_ang")(phase(end),:) - result.("KNEE_ang")(phase(1),:);
    hipDiff = result.("HIP_ang")(phase(end),:) - result.("HIP_ang")(phase(1),:);
    ankStiff = (2*ankNegW*dinfo.weight_kg) ./ (deg2rad(ankDiff).^2) ;
    kneeStiff = (2*kneeNegW*dinfo.weight_kg) ./ (deg2rad(kneeDiff).^2) ;
    hipStiff = (2*hipNegW*dinfo.weight_kg) ./ (deg2rad(hipDiff).^2) ;
% 
%     footAng = horzcat(footAng, v);
%     footAng = horzcat(footAng, round((i/len)*100, 1));
%     footAng = horzcat(footAng, round((i/len)*ctime, 4));
% 
%     footAng = horzcat(footAng, result.("SHANK_ang")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("ANK_ang")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("KNEE_ang")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("LEG_ang")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("COPCOG")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("COPCOG_ang")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("COP_shoes")(phase(i(1)), :));
%     footAng = horzcat(footAng, result.("COP_shoes2")(phase(i(1)), :));
% 
% 
%     footAng = horzcat(footAng, result.("FOOT_ang")(phase(1),:) - v);
%     footAng = horzcat(footAng, result.("SHANK_ang")(phase(1),:) - result.("SHANK_ang")(phase(i(1)),:));
%     footAng = horzcat(footAng, rad2deg(ankDiff));
%     footAng = horzcat(footAng, rad2deg(kneeDiff));
%     footAng = horzcat(footAng, result.("LEG_ang")(phase(1),:) - result.("LEG_ang")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("COPCOG")(phase(1),:) - result.("COPCOG")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("COPCOG_ang")(phase(1),:) - result.("COPCOG_ang")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("COP_shoes")(phase(1)+2,:) - result.("COP_shoes")(phase(i(1)),:));
% 
%     footAng = horzcat(footAng, sum(result.("GRF_W")(phase(1):phase(i(1))-1,:))*FR1000);
%     if phase(i(1))~= phase(end)
%         footAng = horzcat(footAng, sum(result.("GRF_W")(phase(i(1)):phase(end),:))*FR1000);
% 
%     else
%          footAng = horzcat(footAng, zeros(1,3));
% 
%     end
%     footAng = horzcat(footAng, result.("GRFvec_ang")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("GRF_W")(phase(i(1)),:));
%     footAng = horzcat(footAng, mean(result.("GRF_W")(phase(1):phase(i(1)),:)));
%     footAng = horzcat(footAng, result.("GRF_normW")(phase(i(1)),:));
% 
%     footAng = horzcat(footAng, result.("ANK_torW")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("KNEE_torW")(phase(i(1)),:));
%     footAng = horzcat(footAng, result.("LeverArm_ANK")(phase(i(1)),:));
% 
%     footAng = horzcat(footAng, sum(result.("ANK_torW")(phase(1):phase(i(1)),:))*FR1000);
%     footAng = horzcat(footAng, sum(result.("KNEE_torW")(phase(1):phase(i(1)),:))*FR1000);
% 
%
footAng = horzcat(footAng, ankDiff);
footAng = horzcat(footAng, kneeDiff);
footAng = horzcat(footAng, hipDiff);
footAng = horzcat(footAng, ankStiff);
footAng = horzcat(footAng, kneeStiff);
footAng = horzcat(footAng, hipStiff);

COPCOG = result.COPCOG_len;
GRF = result.GRF;
[v_fzmax, i_fzmax] = max(GRF);
[v, i] = min(COPCOG);
k_leg1 = v_fzmax(3)/COPCOG(i_fzmax(3));
k_leg2 = GRF(i,3)/COPCOG(i_fzmax(3));
k_leg3 = v_fzmax(3)/result.LEG_len(i_fzmax(3));


joint = "ANK";
[v, i] = min(result.(joint+"_ang"));
ankDiff2 = (v - result.(joint+"_ang")(result.extra+1, 1));
k_ank = (result.(joint+"_tor")(i(:,1), 1) )/deg2rad(ankDiff2(:,1));
joint = "KNEE";
[v, i] = min(result.(joint+"_ang"));
kneeDiff2 = (v - result.(joint+"_ang")(result.extra+1, 1));
k_knee =   (result.(joint+"_tor")(i(:,1), 1) )/deg2rad(kneeDiff2(:,1));
joint = "HIP";
[v, i] = min(result.(joint+"_ang"));
hipDiff2 = (v - result.(joint+"_ang")(result.extra+1, 1));
k_hip =  (result.(joint+"_tor")(i(:,1), 1))/deg2rad(hipDiff2(:,1));

footAng = horzcat(footAng, k_leg1);
footAng = horzcat(footAng, k_leg2);
footAng = horzcat(footAng, k_leg3);
footAng = horzcat(footAng, k_ank);
footAng = horzcat(footAng, k_knee);
footAng = horzcat(footAng, k_hip);
footAng = horzcat(footAng, ankDiff2);
footAng = horzcat(footAng, kneeDiff2);
footAng = horzcat(footAng, hipDiff2);
    
% 
% 
% if length(footAng)~=90
%     error("Check Data in footAng")
% 
% end
% 
% 
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %接地後のCOPの軌跡について
% 
% groups = split_sequence_into_groups(phase, 5);
% Var = "COP_shoes";
% trjctCOP = horzcat(trjctCOP, result.(Var)(phase(1)+alpha,:));
% trjctCOP = horzcat(trjctCOP, result.(Var)(phase(end)-alpha,:));
% 
% part =phase(1)+alpha:phase(end)-alpha;
% trjctCOP = horzcat(trjctCOP, max(result.(Var)(part,:)));
%  for iRep = 1:length(groups)
%      part = cell2mat(groups(iRep));
%     trjctCOP = horzcat(trjctCOP, max(result.(Var)(part,:)));
% 
%  end
% 
% part =phase(1)+alpha:phase(end)-alpha;
% trjctCOP = horzcat(trjctCOP, min(result.(Var)(phase,:)));
% for iRep = 1:length(groups)
%      part = cell2mat(groups(iRep));
%      trjctCOP = horzcat(trjctCOP, min(result.(Var)(part,:)));
% 
%  end
% 
% part =phase(1)+alpha:phase(end)-alpha;
% trjctCOP = horzcat(trjctCOP, max(result.(Var)(part,:)) - min(result.(Var)(part,:)));
% for iRep = 1:length(groups)
%      part = cell2mat(groups(iRep));
%      trjctCOP = horzcat(trjctCOP, max(result.(Var)(part,:)) - min(result.(Var)(part,:)));
% 
% end
% 
% if length(trjctCOP) ~= 60
% error("Check Data in tjctCOP")
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %接地後のCOPの軌跡について
% 
% groups = split_sequence_into_groups(phase, 5);
% Var = "FOOT_ang";
% footPos = horzcat(footPos, result.(Var)(phase(1)+5,:));
% footPos = horzcat(footPos, result.(Var)(phase(end)-5,:));
% 
% part =phase(1)+alpha:phase(end)-alpha;
% footPos = horzcat(footPos, max(result.(Var)(part,:)));
%  for iRep = 1:length(groups)
%      part = cell2mat(groups(iRep));
%     footPos = horzcat(footPos, max(result.(Var)(part,:)));
% 
%  end
% 
% part =phase(1)+alpha:phase(end)-alpha;
% footPos = horzcat(footPos, min(result.(Var)(phase,:)));
% for iRep = 1:length(groups)
%      part = cell2mat(groups(iRep));
%      footPos = horzcat(footPos, min(result.(Var)(part,:)));
% 
%  end
% 
% part =phase(1)+alpha:phase(end)-alpha;
% footPos = horzcat(footPos, max(result.(Var)(part,:)) - min(result.(Var)(part,:)));
% for iRep = 1:length(groups)
%      part = cell2mat(groups(iRep));
%      footPos = horzcat(footPos, max(result.(Var)(part,:)) - min(result.(Var)(part,:)));
% 
% end
% 
% if length(footPos) ~= 60
% error("Check Data in tjctCOP")
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %ロボ試験との比較について
% robo_foot_ang = [-36.5, -29.8, -23.7, -21.4];
% for i = 1:length(robo_foot_ang)
%     minIdx1(i) = findClosestRow(result.FOOT_ang, robo_foot_ang(i), 1);
% 
% end
% 
% [b,t] = getWavePeak2(result.("ANK_forangWG")(result.extra+2:len-result.extra-2,2), "on", "frame");
% [~, minIdx2(1)] = max(result.("ANK_forangWG")(result.extra+2:len-round(len/2),2));
% minIdx2(2) = b(findClosestRow(b, minIdx2(1), 1));
% [foot_ang_max ,minIdx2(4)] = max(result.("FOOT_ang")(:,1));
% minIdx2(3) = round((minIdx2(4) - minIdx2(2))/2) + minIdx2(2);
% 
% figure()
% plot(result.("ANK_forangWG")(result.extra+2:len-result.extra-2,2))
% hold on
% plot(result.FOOT_ang(result.extra+2:len-result.extra-2,1))
% plot(minIdx2, result.FOOT_ang(minIdx2,1), "ro")
% yyaxis right
% plot(result.GRF(result.extra+2:len-result.extra-2, 2:3))
% saveas(gcf, dinfo.res_dir+dinfo.trialNo+dinfo.subject+"_CheckRoboData.png")
% 
% close all
% 
% %ロボ試験との比較用データ
% minIdx = minIdx1;
% for idx = 1:length(minIdx)
%     try
%     robo_val = horzcat(robo_val, result.("GRF")(minIdx(idx), :));
%     robo_val = horzcat(robo_val, result.("GRF_W")(minIdx(idx), :));
%     robo_val = horzcat(robo_val, result.("GRFvec_ang")(minIdx(idx), :));
%     robo_val = horzcat(robo_val, result.("FOOT_ang")(minIdx(idx), :));
% 
%     catch
%         robo_val = horzcat(robo_val, zeros(1,12));
% 
%     end
% 
% end
% 
% 
% %ロボ試験との比較用データ
% minIdx = minIdx2;
% for idx = 1:length(minIdx)
%     robo_val = horzcat(robo_val, result.("GRF")(minIdx(idx), :));
%     robo_val = horzcat(robo_val, result.("GRF_W")(minIdx(idx), :));
%      robo_val = horzcat(robo_val, result.("GRFvec_ang")(minIdx(idx), :));
%     robo_val = horzcat(robo_val, result.("FOOT_ang")(minIdx(idx), :));
% 
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FF時間中の力積，平均力 etc



try
    FFtime = find(result.FOOT_ang(:,1)>-5 & result.FOOT_ang(:,1)<5)';
    BFFtime = result.extra+1:FFtime(1)-1;
    AFFtime = FFtime(end)+1:len-(result.extra+1);

    ankW_bff =  sum(result.("ANK_powW")(BFFtime, :))*FR1000;
    ankW_ff =  sum(result.("ANK_powW")(FFtime, :))*FR1000;
    ankW_aff =  sum(result.("ANK_powW")(AFFtime, :))*FR1000;

    kneeW_bff = sum(result.("KNEE_powW")(BFFtime, :))*FR1000;
    kneeW_ff = sum(result.("KNEE_powW")(FFtime, :))*FR1000;
    kneeW_aff = sum(result.("KNEE_powW")(AFFtime, :))*FR1000;

    hipW_bff = sum(result.("HIP_powW")(BFFtime, :))*FR1000;
    hipW_ff = sum(result.("HIP_powW")(FFtime, :))*FR1000;
    hipW_aff = sum(result.("HIP_powW")(AFFtime, :))*FR1000;


    FFdata = [];
    FFdata = horzcat(FFdata, length(BFFtime)*FR1000);
    FFdata = horzcat(FFdata, length(FFtime)*FR1000);
    FFdata = horzcat(FFdata, length(AFFtime)*FR1000);

    TGTtime = BFFtime;
    FFdata = horzcat(FFdata, sum(result.GRF_W(TGTtime, :))*FR1000);
    FFdata = horzcat(FFdata, mean(result.GRF_W(BFFtime, :)));
    FFdata = horzcat(FFdata, ankW_bff);
    FFdata = horzcat(FFdata, ankW_ff);
    FFdata = horzcat(FFdata, ankW_aff);

    TGTtime = FFtime;
    FFdata = horzcat(FFdata, sum(result.GRF_W(TGTtime, :))*FR1000);
    FFdata = horzcat(FFdata, mean(result.GRF_W(BFFtime, :)));
    FFdata = horzcat(FFdata, kneeW_bff);
    FFdata = horzcat(FFdata, kneeW_ff);
    FFdata = horzcat(FFdata, kneeW_aff);

    TGTtime = AFFtime;
    FFdata = horzcat(FFdata, sum(result.GRF_W(TGTtime, :))*FR1000);
    FFdata = horzcat(FFdata, mean(result.GRF_W(BFFtime, :)));
    FFdata = horzcat(FFdata, hipW_bff);
    FFdata = horzcat(FFdata, hipW_ff);
    FFdata = horzcat(FFdata, hipW_aff);

catch
    FFdata = zeros(1, 48);
    disp("Skipped Foot angle Data...")
end

if length(FFdata) ~= 48
    disp("missing data...")
    FFdata = zeros(1, 48);

end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AERと地面反力力積の関係
AERimp = [];
if dinfo.stepNo == "1st"
    propPhase_tmp = findConsecutiveSequences(find(result.GRF(:,2) > 20));
    propPhase = cell2mat(propPhase_tmp(1));
    [v, i] = max(result.GRF_W(propPhase, 2));
    [vv, ii] = max(result.GRF_W(propPhase, :));
    formIMP = sum(result.GRF_W(propPhase(1):propPhase(i), :))*FR1000;
    lattIMP = sum(result.GRF_W(propPhase(i)+1:propPhase(end), :))*FR1000;   
    

elseif dinfo.stepNo == "2nd"
    [v, i] = min(result.GRF_W(:,2));
     [vv, ii] = max(result.GRF_W);
    formIMP = sum(result.GRF_W(1:i, :))*FR1000;
    lattIMP = sum(result.GRF_W(i+1:end, :))*FR1000;


end
AERimp = horzcat(AERimp, vv);
AERimp = horzcat(AERimp, formIMP);
AERimp = horzcat(AERimp, lattIMP);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%　起こしモーメント
momentPosture = [];

moment = result.momentARM;
[v,i] = max(moment);
momentPosture = horzcat(momentPosture, i);
momentPosture = horzcat(momentPosture, v);
[v,i] = min(moment);
momentPosture = horzcat(momentPosture, i);
momentPosture = horzcat(momentPosture, v);

moment = result.momentCM;
[v,i] = max(moment);
momentPosture = horzcat(momentPosture, i);
momentPosture = horzcat(momentPosture, v);
[v,i] = min(moment);
momentPosture = horzcat(momentPosture, i);
momentPosture = horzcat(momentPosture, v);



point = [compTest ctime velocity impulse_w impulse aveF_w aveF maxF torque segAng_cntct segAng_to propMax powVar anktorMax var1 copcog footAng FFdata AERimp momentPosture];%footAng trjctCOP footPos robo_val

point(ismissing(point))=0;
point(isnan(point))=0;
point = horzcat(label, point);

end