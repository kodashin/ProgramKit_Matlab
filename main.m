
clc
clear
close all
format long


%% テストファイルの読み込み
%staticファイルとの組み合わせを取得
num = 1;
combi = "list";
names = ["KO" "TAKEMOTO" "ALL"];%
o=3;

data_dir = "E:\OneDrive - ASICS Corporation\DataBank\Volleyball\20250202_VB_27AW_Metarise3_Proto\Vicon";
% data_dir = "E:\OneDrive - ASICS Corporation\Main\ResearchTheme\2024\TopModelVolleyball\Spike&Block\Data";
test_file = data_dir+"\20250202_TestFile_27AW_Metarise3_Proto1.xlsx";
 
try
      [~,  tmp_table, raw] = xlsread(test_file,  combi);
      CompD =readtable(test_file, "Sheet", "comp");

catch
    data_dir = replace(data_dir, "E:", "C:\Users\kodaira-sh");
    test_file = replace(test_file, "E:", "C:\Users\kodaira-sh");
   [~,  tmp_table, raw] = xlsread(test_file,  combi);
   CompD =readtable(test_file, "Sheet", "comp");

end
tmp_table = string(raw);

 [~,color,~] = xlsread(test_file,  "color");
 line_color = color(2:end, :);

 [~,step_list,~] = xlsread(test_file,  "step");

 Action = "Attack";
 disp("Action: "+Action)

subName ="ALL";%names(o);%;%names(o);%"2";%
static_table = sortrows(tmp_table(2:end, :));% sortrows(tmp_table( tmp_table(:,  3)~="Nude",  1:end),  [2, 4],  "ascend");%tmp_table(:,  4)~=Action |

fclose('all');


if o == 3
    static_table = string(static_table(static_table(:,  3)== "Attack"  , :));

else
     static_table = string(static_table(static_table(:,  2) == names(o)  , :));

end

static_table = string(sortrows(static_table,  [2, 4],  "ascend"));
%試技の繰り返し回数
nRep = 4;

%結果格納excelのファイル名
date = datetime('now',  'Format',  'yyyyMMdd');%datetime("20220708",  "Format",  "yyyyMMdd");%
res_dir = "..\Res\"+string(date)+"\";
mat_dir = res_dir+"\ResMat\";
res_filename = res_dir+string(date)+"_VB_Block&Spike_Pre_ResultSumary";
%データ保存先ディレクトリの確認
if  exist(res_dir, "dir")==0
    mkdir(res_dir)
end

resEXT = ".xlsx";

%Trial,  stand,  r-uki,  l-ukiのファイル一覧を取得
subject_table = static_table(:,  2);
shoes_table = static_table(:,  4);
stand_list = static_table(:,  5);
ruki_list =  static_table(:,  6);
luki_list = static_table(:,  7);
trial_list = static_table(:,  1);
action_table = static_table(:,  3);
nude_list = static_table(:,[1, 2, 8]);
% step_list = static_table(:,  9);
% row_order = string(static_table(:,  9));
% arm_list = string(static_table(:,  8));
% fpno_list = string(static_table(:,  10));

shoes_list = unique(shoes_table,  "stable");
subject_list = [unique(subject_table,  "stable"); "ALL"];
action_list = unique(action_table,  "stable");
nShoes = length(shoes_list);
nSub = length(subject_list);
nAction = length(action_list);

%マーカーのリストを設定
[header, marker] = MarkerName(test_file);
marker_nude = marker; %([1:24, 37:54])
shoes_marker = ["TOE", "BALl", "HEELl",  "HEELc",  "HEELm",  "BALm"];
body_marker = marker_nude;


all_marker = unique([ body_marker ; ["r"+shoes_marker "l"+shoes_marker]' ]);


% replace_list = ["lBAl" "lBAm";"lBALl" "lBALm"];
 replace_list = [];
joint_marker = ["KNEEl" "KNEEm" "ANKl" "ANKm" ];
seg_list = ["THIGH" "SHANK"];

data_header2 = setDataHeader2();
data_header = setDataHeader();
ext = '.csv';

rangerange = 1000;
FR1000 = 1/1000;
FR250 = 1/250;

%オプションの選択------------------------------------
%staticの際の座標系確認
flag = "off";
%座標系確認グラフのマーカー，ベクトルサイズ
marker_size = 50;
len_arrow = 0.3;

%staticの再計算
re_calculate = 0;

%ソール角度の計算
sole_angleCal = 0;%ソール角度の計算をしないときはマーカー座標をすべて0にしたダミーデータを持たせる 0→計算しない 1→計算する


%まとめ用配列
Result_all1=[];
Result_all2=[];
Result_all3=[];
Result_all=[];
rlPlotD_all = [];
rlPlotD_all1 = [];
rlPlotD_all2 = [];
GRF_all = [];
PntData1 = repmat("", length(trial_list), length(data_header));
PntData2 = repmat("", length(trial_list), length(data_header));

for iShoes = 1:length(shoes_list)
    for iAction = 1:length(action_list)
        for iSub = 1:length(subject_list)
            shoesMKR1.(subject_list(iSub)).(action_list(iAction)).(shoes_list(iShoes)) = zeros(201, 3*length(shoes_marker));
            shoesMKR2.(subject_list(iSub)).(action_list(iAction)).(shoes_list(iShoes)) = zeros(201, 3*length(shoes_marker));
            cntcheck.(subject_list(iSub)).(action_list(iAction)).(shoes_list(iShoes)) = 0;
        end
    end
end
% shoesMKR1 = [];
% shoesMKR2 = [];




%FPのGainと閾値の設定
gaingain = 10000;
threshold = 20;

%FPのグローバル座標系における位置を設定
posiFP = [0.3 -0.45 0.6 0.9;0.3 -0.45 0.6 0.9];
weight = ["fujita" 728.6;"hotta" 591.5;"ichikawa" 664.0;"kamioka" 537.6;"nakai" 611.7;"oohata" 719.5;"sato" 629.8;"takemoto" 627.1;"tanaka" 536.0;"igawa" 747.2];
height = ["KIJIMA" 1.933;"NAGAMI" 1.838;"SAKAMOTO" 1.830 ;"MORI" 1.790];

%グローバル座標系
ground = zeros(4);
ground(1,  1) = 1;
ground(2,  2) = 1;
ground(3,  3) = 1;
ground(4,  4) = 1;

skipped_list = [];

warning off

%% uki
if re_calculate == 0 || sole_angleCal == 0
    disp("Uki calculation skipped...")
else
    ruki_files_unique = unique([ruki_list subject_table shoes_table ],  "rows",  "stable");
    % ruki_files_unique = ruki_files_unique([3], :);
    luki_files_unique = unique([luki_list subject_table shoes_table ],  "rows",  "stable");
    % luki_files_unique = luki_files_unique([3], :);

    %R-uki calculation--------------------
    ruki = calUkiRight(ruki_files_unique,  "r"+shoes_marker,  header,  data_dir);
    writematrix(ruki.matome,  res_dir+res_filename+"_static"+resEXT,  'Sheet',  'Ruki',  'WriteMode',  'overwrite',  'UseExcel',  1,  'PreserveFormat',  1)

    %L-uki calculation--------------------
    luki = calUkiLeft(luki_files_unique,  "l"+shoes_marker,  header,  data_dir);
    writematrix(luki.matome,  res_dir+res_filename+"_static"+resEXT,  'Sheet',  'Luki',  'WriteMode',  'overwrite',  'UseExcel',  1,  'PreserveFormat',  1)


end

%% stand
%座標系の確認---------------
if re_calculate == 0
  
       disp("Stand calculation skipped...")
else

  
    %Stand calculation---------------------
    stand_files_unique = unique([stand_list subject_table shoes_table nude_list(:,3)], "rows", "stable");
    % stand_files_unique =  stand_files_unique(stand_files_unique(:,2)=="NAGAMI", :);%stand_files_unique(:,1)=="Trial89"&
    [Lstand, Lstand_check] = calStandLeft(nude_list, stand_files_unique, body_marker, header, data_dir, replace_list);    
    [Rstand, Rstand_check] = calStandRight(nude_list, stand_files_unique, body_marker, header, data_dir, replace_list);
    
    writematrix(Rstand.matome, res_filename+"_static"+resEXT, 'Sheet', 'Rstand', 'WriteMode', 'overwrite', 'UseExcel', 1, 'PreserveFormat', 1)
     writematrix(Lstand.matome, res_filename+"_static"+resEXT, 'Sheet', 'Lstand', 'WriteMode', 'overwrite', 'UseExcel', 1, 'PreserveFormat', 1)

   

end
%座標系の確認
if flag == "on"
    data = Lstand.sdata;
    markD = str2double(data(2,  :));
    headD = data(1,  :);
    valP2 = markD(:,   startsWith(headD,   "r"));
    checkD = markD(1,   startsWith(headD,   ["r"+joint_marker "l"+joint_marker]));
    checkD_head = headD(1,   startsWith(headD,   ["r"+joint_marker "l"+joint_marker]));

    for ik = 1
        

        figure()
        %FP4
        numFP = 1;
        rectangle('Position',  [posiFP(numFP,  1)-0.3 posiFP(numFP,  2)-0.45 posiFP(numFP,  3) posiFP(numFP,  4)],  'LineStyle',  '-')
        hold on
        plot3(posiFP(numFP,  1),  posiFP(numFP,  2),  0,  "ok")
        hold on
        %FP2
        numFP = 2;
        rectangle('Position',  [posiFP(numFP,  1)-0.3 posiFP(numFP,  2)-0.45 posiFP(numFP,  3) posiFP(numFP,  4)],  'LineStyle',  '--')
        hold on
        plot3(posiFP(numFP,  1),  posiFP(numFP,  2),  0,  "ok")
        hold on

        %Global座標系
        quiver3(0,  0,  0,  1,  0,  0,  "r")
        hold on
        quiver3(0,  0,  0,  0,  1,  0,  "g")
        hold on
        quiver3(0,  0,  0,  0,  0,  1,  "b")
        hold on

        %         disp(string(round(cnt/(length(duration)+40)*100,  0))+"%")
        axis([-1 1 -1 1 0 2])
        set(gca,  'DataAspectRatio',  [1 1 1])
        grid on


        title('stand_RightSide')
        scatter3(markD(ik,  1:3:end),  markD(ik,  2:3:end),  markD(ik,  3:3:end),  marker_size,  'MarkerFaceColor',  'k')
        hold on
        scatter3(checkD(ik,  1:3:end),  checkD(ik,  2:3:end),  checkD(ik,  3:3:end),  marker_size,  'MarkerFaceColor',  'b',  "Marker" , '*')
        hold on
        %         val = valP2;
        %         scatter3(markD(ik,  1:3:end),   markD(ik,  2:3:end),   markD(ik,  3:3:end),  50,  'mo')
        %         hold on

        %         scatter3(str2double(stand.left_side(ik+1,  1:3:end)),  str2double(stand.left_side(ik+1,  2:3:end)),  str2double(stand.left_side(ik+1,  3:3:end)),  50,  'MarkerFaceColor',  'k')
        %         hold on
        grid on

        seg4 = "PEL";
        stand = Rstand;
        quiver3(stand.(seg4)(2,  1+4*(ik-1)),  stand.(seg4)(3,  1+4*(ik-1)),  stand.(seg4)(4,  1+4*(ik-1)),  stand.(seg4)(2,  2+4*(ik-1)),  stand.(seg4)(3,  2+4*(ik-1)),  stand.(seg4)(4,  2+4*(ik-1)),  "r")
        quiver3(stand.(seg4)(2,  1+4*(ik-1)),  stand.(seg4)(3,  1+4*(ik-1)),  stand.(seg4)(4,  1+4*(ik-1)),  stand.(seg4)(2,  3+4*(ik-1)),  stand.(seg4)(3,  3+4*(ik-1)),  stand.(seg4)(4,  3+4*(ik-1)),  "g")
        quiver3(stand.(seg4)(2,  1+4*(ik-1)),  stand.(seg4)(3,  1+4*(ik-1)),  stand.(seg4)(4,  1+4*(ik-1)),  stand.(seg4)(2,  4+4*(ik-1)),  stand.(seg4)(3,  4+4*(ik-1)),  stand.(seg4)(4,  4+4*(ik-1)),  "b")


        %right side--------------
        seg1 = "rFOOT";
        quiver3(stand.(seg1)(2,  1+4*(ik-1)),  stand.(seg1)(3,  1+4*(ik-1)),  stand.(seg1)(4,  1+4*(ik-1)),  stand.(seg1)(2,  2+4*(ik-1)),  stand.(seg1)(3,  2+4*(ik-1)),  stand.(seg1)(4,  2+4*(ik-1)),  "r")
        quiver3(stand.(seg1)(2,  1+4*(ik-1)),  stand.(seg1)(3,  1+4*(ik-1)),  stand.(seg1)(4,  1+4*(ik-1)),  stand.(seg1)(2,  3+4*(ik-1)),  stand.(seg1)(3,  3+4*(ik-1)),  stand.(seg1)(4,  3+4*(ik-1)),  "g")
        quiver3(stand.(seg1)(2,  1+4*(ik-1)),  stand.(seg1)(3,  1+4*(ik-1)),  stand.(seg1)(4,  1+4*(ik-1)),  stand.(seg1)(2,  4+4*(ik-1)),  stand.(seg1)(3,  4+4*(ik-1)),  stand.(seg1)(4,  4+4*(ik-1)),  "b")

        seg2 = "rSHANK";
        quiver3(stand.(seg2)(2,  1+4*(ik-1)),  stand.(seg2)(3,  1+4*(ik-1)),  stand.(seg2)(4,  1+4*(ik-1)),  stand.(seg2)(2,  2+4*(ik-1)),  stand.(seg2)(3,  2+4*(ik-1)),  stand.(seg2)(4,  2+4*(ik-1)),  "r")
        quiver3(stand.(seg2)(2,  1+4*(ik-1)),  stand.(seg2)(3,  1+4*(ik-1)),  stand.(seg2)(4,  1+4*(ik-1)),  stand.(seg2)(2,  3+4*(ik-1)),  stand.(seg2)(3,  3+4*(ik-1)),  stand.(seg2)(4,  3+4*(ik-1)),  "g")
        quiver3(stand.(seg2)(2,  1+4*(ik-1)),  stand.(seg2)(3,  1+4*(ik-1)),  stand.(seg2)(4,  1+4*(ik-1)),  stand.(seg2)(2,  4+4*(ik-1)),  stand.(seg2)(3,  4+4*(ik-1)),  stand.(seg2)(4,  4+4*(ik-1)),  "b")

        seg3 = "rTHIGH";
        quiver3(stand.(seg3)(2,  1+4*(ik-1)),  stand.(seg3)(3,  1+4*(ik-1)),  stand.(seg3)(4,  1+4*(ik-1)),  stand.(seg3)(2,  2+4*(ik-1)),  stand.(seg3)(3,  2+4*(ik-1)),  stand.(seg3)(4,  2+4*(ik-1)),  "r")
        quiver3(stand.(seg3)(2,  1+4*(ik-1)),  stand.(seg3)(3,  1+4*(ik-1)),  stand.(seg3)(4,  1+4*(ik-1)),  stand.(seg3)(2,  3+4*(ik-1)),  stand.(seg3)(3,  3+4*(ik-1)),  stand.(seg3)(4,  3+4*(ik-1)),  "g")
        quiver3(stand.(seg3)(2,  1+4*(ik-1)),  stand.(seg3)(3,  1+4*(ik-1)),  stand.(seg3)(4,  1+4*(ik-1)),  stand.(seg3)(2,  4+4*(ik-1)),  stand.(seg3)(3,  4+4*(ik-1)),  stand.(seg3)(4,  4+4*(ik-1)),  "b")

        %         left side--------------
        %         seg5 = "lFOOT";
        %         quiver3(stand.(seg5)(2,  1+4*(ik-1)),  stand.(seg5)(3,  1+4*(ik-1)),  stand.(seg5)(4,  1+4*(ik-1)),  stand.(seg5)(2,  2+4*(ik-1)),  stand.(seg5)(3,  2+4*(ik-1)),  stand.(seg5)(4,  2+4*(ik-1)),  "r")
        %         quiver3(stand.(seg5)(2,  1+4*(ik-1)),  stand.(seg5)(3,  1+4*(ik-1)),  stand.(seg5)(4,  1+4*(ik-1)),  stand.(seg5)(2,  3+4*(ik-1)),  stand.(seg5)(3,  3+4*(ik-1)),  stand.(seg5)(4,  3+4*(ik-1)),  "g")
        %         quiver3(stand.(seg5)(2,  1+4*(ik-1)),  stand.(seg5)(3,  1+4*(ik-1)),  stand.(seg5)(4,  1+4*(ik-1)),  stand.(seg5)(2,  4+4*(ik-1)),  stand.(seg5)(3,  4+4*(ik-1)),  stand.(seg5)(4,  4+4*(ik-1)),  "b")
        %
        %         seg6 = "lSHANK";
        %         quiver3(stand.(seg6)(2,  1+4*(ik-1)),  stand.(seg6)(3,  1+4*(ik-1)),  stand.(seg6)(4,  1+4*(ik-1)),  stand.(seg6)(2,  2+4*(ik-1)),  stand.(seg6)(3,  2+4*(ik-1)),  stand.(seg6)(4,  2+4*(ik-1)),  "r")
        %         quiver3(stand.(seg6)(2,  1+4*(ik-1)),  stand.(seg6)(3,  1+4*(ik-1)),  stand.(seg6)(4,  1+4*(ik-1)),  stand.(seg6)(2,  3+4*(ik-1)),  stand.(seg6)(3,  3+4*(ik-1)),  stand.(seg6)(4,  3+4*(ik-1)),  "g")
        %         quiver3(stand.(seg6)(2,  1+4*(ik-1)),  stand.(seg6)(3,  1+4*(ik-1)),  stand.(seg6)(4,  1+4*(ik-1)),  stand.(seg6)(2,  4+4*(ik-1)),  stand.(seg6)(3,  4+4*(ik-1)),  stand.(seg6)(4,  4+4*(ik-1)),  "b")
        %
        %         seg7 = "lTHIGH";
        %         quiver3(stand.(seg7)(2,  1+4*(ik-1)),  stand.(seg7)(3,  1+4*(ik-1)),  stand.(seg7)(4,  1+4*(ik-1)),  stand.(seg7)(2,  2+4*(ik-1)),  stand.(seg7)(3,  2+4*(ik-1)),  stand.(seg7)(4,  2+4*(ik-1)),  "r")
        %         quiver3(stand.(seg7)(2,  1+4*(ik-1)),  stand.(seg7)(3,  1+4*(ik-1)),  stand.(seg7)(4,  1+4*(ik-1)),  stand.(seg7)(2,  3+4*(ik-1)),  stand.(seg7)(3,  3+4*(ik-1)),  stand.(seg7)(4,  3+4*(ik-1)),  "g")
        %         quiver3(stand.(seg7)(2,  1+4*(ik-1)),  stand.(seg7)(3,  1+4*(ik-1)),  stand.(seg7)(4,  1+4*(ik-1)),  stand.(seg7)(2,  4+4*(ik-1)),  stand.(seg7)(3,  4+4*(ik-1)),  stand.(seg7)(4,  4+4*(ik-1)),  "b")

        %FP座標系原点:FP1
        plot3(posiFP(1,  1),  posiFP(1,  2),  0,  "ok")
        hold on
        %FP座標系原点:FP2
        plot3(posiFP(2,  1),  posiFP(2,  2),  0,  "ok")
        hold on

    end

end


%% trial
tic

nTrial = length(trial_list);

%% trial
TrialsNo = 1:nTrial;

for iTrial = TrialsNo%:
    tic
        
    %Trial file，Static file読み込み
    trial_file = trial_list(iTrial);
    stand_file = stand_list(iTrial);
    arm = "R";
    % ruki_file = ruki_list(il);
    % luki_file = luki_list(il);
    shoes = shoes_table(iTrial);
    subject = subject_table(iTrial);
    action = action_table(iTrial);
    nude_file = nude_list(iTrial, 3);
    fp = string(step_list(step_list(:,2) == action&step_list(:,1) == subject,4));
    step = lower(char(step_list(step_list(:,2) == action&step_list(:,1) == subject,3)));

    %stand
    tmp = load("..\mat\"+subject+"_RightStand_"+stand_file+"_"+shoes+".mat");
    standR.stand = tmp.S;
    tmp = load("..\mat\"+subject+"_LeftStand_"+stand_file+"_"+shoes+".mat");
    standL.stand = tmp.S;
    stand_height = standL.stand.PELc(:,3);
    weight_kg = standR.stand.sub_weight_kg;


    disp(string(iTrial)+"/"+length(trial_list))
    disp(trial_file+" calculating...")
    disp("Shoes:  "+shoes)
    disp("Subject: "+subject)
    disp("Stand file: "+ stand_file)

    % disp("R uki file: "+ ruki_file)
    % disp("L uki file: "+ luki_file)
    disp("Nude file: "+ nude_file)
    disp("Action: "+ action)
    disp("FP order: "+fp)
    disp("Step: "+step)
    disp("COG height: "+stand_height +" m")

    %trial情報まとめ
    dinfo = setDataInfo(static_table(iTrial,:));
    dinfo.res_dir = res_dir;
    dinfo.step = step;
    dinfo.weight_kg = weight_kg;
    dinfo.PELc_stand = standL.stand.PELc;
    dinfo.InputE = CompD.InputE(string(CompD.Shoes)==shoes);
    dinfo.AER = CompD.AER(CompD.Shoes==shoes);
    dinfo.RER = CompD.RER(CompD.Shoes==shoes);
    dinfo.RER = CompD.RER(CompD.Shoes==shoes);
    dinfo.MaxDisp = CompD.MaxDisp(CompD.Shoes==shoes);


    [ posiFP, Dposi, fpNo, fpOrder, side1, side2] = setFP_info(step, fp);
    dinfo.fpOrder = fpOrder;

    %データ出力用ファイル名ヘッダー
    file_head = res_dir+subject+"_"+trial_file+"_"+shoes+"_"+action;

    clear trial

    % %Trialデータ
    % t = data_dir+"\"+subject+"\"+string(trial_file)+ext;

    try
        [trial.data,  trial.text,  trial.raw] = xlsread(data_dir+"\"+subject+"\"+string(trial_file)+ext);   %+"\"+subject+"\"
        [nude.data, nude.text, nude.raw] = xlsread(data_dir+"\"+subject+"\"+string(nude_file)+ext);


    catch
        [trial.data,  trial.text,  trial.raw] = xlsread(data_dir+"\"+string(trial_file)+ext);   %+"\"+subject+"\"
        [nude.data, nude.text, nude.raw] = xlsread(data_dir+"\"+string(nude_file)+ext);

    end

    %nude条件データを取得
    nude = setNudeMakerData(nude, body_marker, joint_marker, replace_list, header, arm);

    trial.trial_file = trial_file;
    nFr_trial = find(strcmp(trial.text(:, 1), "Trajectories"), 1)-7;

    %trialデータを取得
    trial = setTrialMarkerData(trial, all_marker, joint_marker, replace_list, nFr_trial, arm, header, sole_angleCal, shoes_marker);

    %SVDによってマーカーを補完
    trial = estimateMarkerDataSVD(trial, nude, joint_marker, seg_list, standR, standL);

    %データまとめ用のラベル
    top = [trial_file subject action shoes];

    %FPデータの計算
    FP = setFPinfo(trial,  2,  posiFP,  "R", fp, step, Dposi, fpNo);

    % [cgData,bspData]=cg(trial.sdata,1,"M",dinfo.weight_kg,'y',3);

    %ソール角度計算：今回は計算しないためダミーデータ
    tmp = returnDummyData_ang();
    ukiD.luki = tmp.luki;
    ukiD.ruki = tmp.ruki;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%1歩目に関する分析%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    FPno = 1;
    side = side1;
    if side == "l"
        standD = standL;

    elseif side == "r"
        standD = standR;

    end
    [Result1, Point1, Seg, PrjctData1, rCS, ~, ~, ~, ~, rlPlotD1, trial, FP] = calDataMain(FP, trial, dinfo, standD, ukiD, nFr_trial, arm, flag, file_head, top, side, FPno);
    PntData1(iTrial,:) = Point1;
      trial.PELc_stand = dinfo.PELc_stand;
  
    %規格化-------------------------------
    Result_all1 = horzcat(Result_all1, setNormData(Result1, top'));
    rlPlotD_all1 = horzcat(rlPlotD_all1,  setNormDataRL(rlPlotD1,  top'));

    shoesMKR1.(subject).(action).(shoes) = shoesMKR1.(subject).(action).(shoes) + mean(PrjctData1.(side+"SHOESmkr_trans"), "omitnan");
    shoesMKR1.ALL.(action).(shoes) = shoesMKR1.ALL.(action).(shoes) + mean(PrjctData1.(side+"SHOESmkr_trans"), "omitnan");

    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%2歩目に関する分析%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    FPno = 2;
    side = side2;
    if side == "l"
        standD = standL;

    elseif side == "r"
        standD = standR;

    end
    [Result2, Point2, ~,  PrjctData2, lCS, ~, ~, ~, ~,rlPlotD2, trial, FP]= calDataMain(FP, trial, dinfo, standD, ukiD, nFr_trial, arm, flag, file_head, top, side, FPno);
    PntData2(iTrial,:) = Point2;
    %規格化-------------------------------
    Result_all2 = horzcat(Result_all2, setNormData(Result2, top'));
    rlPlotD_all2 = horzcat(rlPlotD_all2,  setNormDataRL(rlPlotD2,  top'));

    shoesMKR2.(subject).(action).(shoes) = shoesMKR2.(subject).(action).(shoes) + mean(PrjctData2.(side+"SHOESmkr_trans"), "omitnan");
    shoesMKR2.ALL.(action).(shoes) = shoesMKR2.ALL.(action).(shoes) + mean(PrjctData2.(side+"SHOESmkr_trans"), "omitnan");


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%全体関する分析%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % dinfo.weight_N = standL.stand.sub_weight_N;
    % dinfo.weight_kg = standL.stand.sub_weight_kg;
    [Result, Point, rlPlotD, trial] = calDataMainRL(FP, trial, dinfo,  top);

    PntData(iTrial,:) = Point;
    %規格化-------------------------------
    Result_all = horzcat(Result_all, setNormData(Result, top'));
    rlPlotD_all = horzcat(rlPlotD_all,  setNormDataRL(rlPlotD,  top'));
    %
    % clear Result Point
    % clear Result1 Point1
    % clear Result2 Point2

    disp("-------------------------------------------------")


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %座標データの確認
        coodi_check = "off";
        if coodi_check == "on"

            arm = "R";
            Frm = 350;
            showStickPicture(FP, posiFP, rCS, lCS, trial, arm, Frm)

        end

        close all

    % toc
end


%% 結果のまとめ，書き出し（ループ最後で実施）

%データ保存先ディレクトリの確認
if  exist(res_dir+"\mat", "dir")==0
    mkdir(res_dir+"\mat")
end

%ポイントのデータにヘッダーを結合

PntData1_excel = [data_header;PntData1];
PntData2_excel = [data_header;PntData2];
% PntData3_excel = [data_header;PntData3];
PntData_excel = [data_header2;PntData];

list_NotEx_trialname = PntData1_excel(:, 1:4);


%算出した変数を成分ごとにソート
disp("-------------------------------------Choose trials--------------------------------------------")
Result_sorted1 = exTrial(Result_all1,  list_NotEx_trialname);
Result_sorted2 = exTrial(Result_all2,  list_NotEx_trialname);
% Result_sorted3 = exTrial(Result_all3,  list_NotEx_trialname);
rlResult_sorted = exTrial(Result_all,  list_NotEx_trialname);
rlPlotD_sorted = exTrial(rlPlotD_all,  list_NotEx_trialname);
rlPlotD_sorted1 = exTrial(rlPlotD_all1,  list_NotEx_trialname);
rlPlotD_sorted2 = exTrial(rlPlotD_all2,  list_NotEx_trialname);

% % Guidance Repeatability
% GRep = calGuidanceRepeatability(Result_sorted1 );


disp("-------------------------------------Calculating average--------------------------------------------")
Mean_array1 = setMeanArrayReverse(Result_sorted1,  file_head);
Mean_array2 = setMeanArrayReverse(Result_sorted2,  file_head);


% Mean_array3 = setMeanArrayReverse(Result_sorted3,  file_head);
%Both:接地期全体
rlMean_array = setMeanArrayReverse(rlResult_sorted,  file_head);
rlMean_plotD = setMeanArrayReverse(rlPlotD_sorted,  file_head);
rlMean_plotD1 = setMeanArrayReverse(rlPlotD_sorted1,  file_head);
rlMean_plotD2 = setMeanArrayReverse(rlPlotD_sorted2,  file_head);


save(res_dir+"\mat\rlMean_plotD", "rlMean_plotD")
save(res_dir+"\mat\rlMean_plotD1", "rlMean_plotD1")
save(res_dir+"\mat\rlMean_plotD2", "rlMean_plotD2")

% %シューズ座標系に投影したGRFを描画
% for iShoes = 1:length(shoes_list)
%     for iAction = 1:length(action_list)
%         for iSub = 1:length(subject_list)
%             if subject_list(iSub) ~= "ALL"
%                 shoesMKR1_plot.(subject_list(iSub)).(action_list(iAction)).(shoes_list(iShoes)) = shoesMKR1.(subject_list(iSub)).(action_list(iAction)).(shoes_list(iShoes))/nRep;
%                 shoesMKR2_plot.(subject_list(iSub)).(action_list(iAction)).(shoes_list(iShoes)) = shoesMKR2.(subject_list(iSub)).(action_list(iAction)).(shoes_list(iShoes))/nRep;
% 
%             elseif subject_list(iSub) == "ALL"
%                  shoesMKR1_plot.ALL.(action_list(iAction)).(shoes_list(iShoes)) = shoesMKR1.ALL.(action_list(iAction)).(shoes_list(iShoes))/((nSub-1)*nRep);
%                  shoesMKR2_plot.ALL.(action_list(iAction)).(shoes_list(iShoes)) = shoesMKR2.ALL.(action_list(iAction)).(shoes_list(iShoes))/((nSub-1)*nRep);
% 
%             end
%         end       
%     end
% end


% % データ保存先ディレクトリの確認
% fileheadGRF = res_dir+"COP_GRFinFoot\";
% if  exist(fileheadGRF, "dir")==0
%     mkdir(fileheadGRF)
% end
% 
% flag = "off";
% [nRow, nCol] = size(Mean_array1);
% duration = 1:nRow;
% 
% side = "r";
% COPinSHOES = Mean_array1;
% shoes_mkr = shoesMKR1_plot;
% showCOP_GRFinSHOES(COPinSHOES, shoes_mkr,  fileheadGRF, side,  flag);
% side = "l";
% COPinSHOES = Mean_array2;
% shoes_mkr = shoesMKR1_plot;
% showCOP_GRFinSHOES(COPinSHOES, shoes_mkr,  fileheadGRF, side,  flag);


%Excelに書き込み
disp("-------------------------------------Making formula average&S.D.--------------------------------------------")

combi_all = allcomb(subject_list,  action_list,  shoes_list);
[rC,  cC] = size(combi_all);
[rP,  cP] = size(PntData1_excel);
[rrCC,  ccCC] = size(PntData_excel);

singleL = setAverageFormulaSingle(subject_list,  action_list,  shoes_list,  rP,  cP-4);
doubleL = setAverageFormulaDouble(subject_list,  action_list,  shoes_list,  rrCC,  ccCC-4);

%Excelファイルに書き込み
%Attack:1→trail leg，2→lead leg
%Block:1→1st leg，2→2nd leg
%Quick:1→1st leg，2→2nd leg
tic
disp("-------------------------------------Saving data to excel.--------------------------------------------")
indi_data = 0;
writeRes2Sheet(res_filename+"R"+resEXT,  PntData1_excel,  Mean_array1,  Result_sorted1,  singleL, indi_data)
writeRes2Sheet(res_filename+"L"+resEXT,  PntData2_excel,  Mean_array2,  Result_sorted2,  singleL, indi_data)
% writeRes2Sheet(res_filename+"3rd"+resEXT,  PntData3_excel,  Mean_array3,  Result_sorted3,  singleL, indi_data)

writeRes2Sheet(res_filename+"RL"+resEXT,  PntData_excel,  rlMean_array,  rlResult_sorted,  doubleL, indi_data)

disp("-------------------------------------Drawing time series data graph--------------------------------------------")
% var_pickup = [["GRF1_W", "Y"],  ["GRF1_W", "Z"], ["GRF2_W", "Y"],  ["GRF2_W", "Z"],["GRF_W", "Y"], ["GRF_W", "X"], ["GRF_W", "Z"], ["GRF_GW", "Z"], ...
%                            ["LEG_ang", "X"],["LEG_ang", "Y"],["ANK_ang", "X"],["ANK_ang_disp", "X"], ["KNEE_ang", "X"],["KNEE_ang_disp", "X"],["HIP_ang", "X"],["HIP_ang_disp", "X"], ["PEL_vel", "Y"], ["PEL_vel", "Z"], ["PEL_vel_contact", "Z"], ["PEL_vel_contact", "Y"], ["LEG_ang", "Y"], ["FOOT_ang", "Y"], ["FOOT_ang", "X"], ["FOOT_ang", "Z"],...
%                                     ["ANK_torW", "X"], ["KNEE_torW", "X"], ["ANK_powW", "X"], ["KNEE_powW", "X"], ["COPCOG", "Y"], ["GRFvecYZ_ang", "o"],["BALl_trans", "X"],...
%                                     ["ANK_omgL", "X"], ["KNEE_omgL", "X"], ["COP_shoes", "Y"], ["COP_shoes2", "Y"], ["COP_shoes", "X"],["LeverArm_ANK","X"],["LeverArm_ank","X"],["GRF_norm", "o"],["PELC_contact", "Y"],["FOOT_omg", "X"],...
%                                     ["FOOTG_vel", "X"],["FOOTG_vel", "Y"],["FOOTG_vel", "Z"],["momentCM", "X"], ["momentARM", "X"], ["momentARM", "Y"], ["momentARM", "Z"]];
pyrunfile("main_ExcelGraphSD_obj_ver2.py", "date", string(date), "test_file", test_file)
% % pyrunfile("main_ExcelGraph_scatter.py", "date", string(date), "test_file", test_file, "mode", 1)

%シューズ内COPをグラフにして出力
% flag="on"
COPinSHOES = PrjctData.COP_FOOT;
shoes_mkr =  PrjctData.(side+"SHOESmkr_trans");
pnt = round(median(duration));
showCOPinSHOES(COPinSHOES, shoes_mkr, duration, file_headGRF, pnt, flag);


toc


flag = "on";
if flag == "on"

    %あわせこみマーカーの指定:shoesAのrheelcに合わせる
    tgtM = "ANKc";
    focus_list = [ "Whole" "Foot"];%"Foot"
    %Line type
    line = ["-",   "--",   ":"];
    color = ["r",   "g",   "b"];

    shoes_stick = shoes_list;
    [r, ~] = size(shoes_stick);
    plotD_name = ["rlMean_plotD1" "rlMean_plotD2" "rlMean_plotD"];%"rlMean_plotD"
    step_name = ["1st", "2nd", "All"];
    % iData = 1;

    for iData = 3
        tmp = load((res_dir+"\mat\"+plotD_name(iData)));
        plotD = tmp.(plotD_name(iData));
        

        for iSub = 1:length(subject_list)
            % for iShoes = 1:length(shoes_list)%1:r
            for iAction = 1:length(action_list)
                %被験者とシューズの指定
                SubA = subject_list(iSub);%"Sanekata";%subject_list(iSub);%"MORI";
                ShoesA = "Metarise2";%shoes_stick(iShoes, 1);
                ColorA = string(line_color(line_color(:,1)==ShoesA,2));%hex2rgb(char(line_color(line_color(:,1)==ShoesA,2)));
                LineA = line(1);
                LineWidthA = 1;
                SubB = SubA;
                ShoesB = "DC15";%ShoesA ;%shoes_stick(iShoes, 2);
                ColorB = string(line_color(line_color(:,1)==ShoesB,2));%hex2rgb(char(line_color(line_color(:,1)==ShoesB,2)));
                LineB = line(1);
                LineWidthB = 2;
                % SubC = SubA;
                % ShoesC = "Type1";
                %  ColorC = hex2rgb(char(line_color(line_color(:,1)==ShoesC,2)));
                % SubD = SubA;
                % ShoesD = "Type7";
                side = "r";
                Action = action_list(iAction);

                others = [SubB,  ShoesB];%;SubC,  ShoesC;SubD,  ShoesD

                %2歩目は左右反転してから1歩目に合わせる
                reverse = 0;
                % allall = arrangeStickPicData2("l"+tgtM,  SubA,  ShoesA,  others,  rlMean_plotD,  act, reverse);
                % arrangeStickPicData(tgtM,SubA,ShoesA,SubB,ShoesB,rlMean_plotD,action)

                allall1 = arrangeStickPicData2(side+tgtM,  SubA,  ShoesA,  others,  rlMean_plotD,  Action, reverse);
                % allall2 = arrangeStickPicData2(side+tgtM,  SubB,  ShoesB,  others,  rlMean_plotD,  Action, reverse);
                fields = fieldnames(allall1);


                %スティックピクチャの比較
                for iFocus = 1%:length(focus_list)
                    focus = focus_list(iFocus);

                    for iAngle = 1
                        figure()

                        for ik = 1:length(allall1.pelP1)%200

                            Sub1 = SubA;
                            Sub2 = SubB;
                            % Sub3 = SubC;
                            Shoes1 = ShoesA;
                            Shoes2 = ShoesB;
                            % Shoes3 = ShoesC;

                            %Global座標系
                            quiver3(0,  0,  0,  1,  0,  0,  "r")
                            hold on
                            quiver3(0,  0,  0,  0,  1,  0,  "g")
                            hold on
                            quiver3(0,  0,  0,  0,  0,  1,  "b")
                            hold on

                            %         disp(string(round(cnt/(length(duration)+40)*100,  0))+"%")

                            set(gca,  'DataAspectRatio',  [1 1 1])
                            grid on
                            title(string(round(ik/2))+"%")
                            grid on
                            if iAngle == 1
                               
                                ang = "90-00_";

                                if focus == "Foot"
                                     view(-90,  00)
                                    center = mean(allall1.PELc1(:,2));
                                    axis([-0.5 1 center-0.2 center+0.2 0 0.3])
                                    arrow_scale = 1/2500;

                                elseif focus == "Whole"
                                     view(90,  00)
                                    center = mean(allall1.PELc1(:,2));
                                    axis([-0.5 1 -1.5 1.5 0 1.5])
                                    arrow_scale = 1/2000;

                                end

                            elseif iAngle == 2
                                view(00,  90)
                                ang = "00-90_";
                                % axis([-0.75 0.25 -1.5 1.5 0 1.5])
                                %
                                % axis([-0.75 0.25 -1.5 1.5 0 1.5])
                                %FP4
                                numFP = 1;
                                rectangle('Position',  [posiFP(numFP,  1)-0.3 posiFP(numFP,  2)-0.45 posiFP(numFP,  3) posiFP(numFP,  4)],  'LineStyle',  '-')
                                hold on
                                plot3(posiFP(numFP,  1),  posiFP(numFP,  2),  0,  "ok")
                                hold on
                                %FP2
                                numFP = 2;
                                rectangle('Position',  [posiFP(numFP,  1)-0.3 posiFP(numFP,  2)-0.45 posiFP(numFP,  3) posiFP(numFP,  4)],  'LineStyle',  '-')
                                hold on
                                plot3(posiFP(numFP,  1),  posiFP(numFP,  2),  0,  "ok")
                                hold on


                            end

                            if ik == 1
                                newFolder = res_dir+step+"_"+Sub1+Shoes1+Action+Sub2+Shoes2+Action+ang+focus;
                                mkdir(newFolder)
                            end


                            %Sub A
                            n = 1;
                            drawStickPicData(allall1, n, ik, LineB, LineWidthB, ColorA, SubA, arrow_scale)

                            %Trial B
                            n = 2;
                            drawStickPicData(allall1, n, ik, LineB, LineWidthB, ColorB, SubB, arrow_scale)

                            %  %Trial B
                            % n = 3;
                            % drawStickPicData(allall1, n, ik, LineB, LineWidthB, ColorC, SubC, arrow_scale)

                            % 凡例の設定
                            % legend({LineA, SubA, LineB, SubB, 'LineA + SubA', 'LineB + SubB'}, 'Location', 'northwest');
                            % h = get(gca, 'Children');
                            % lgd  = legend;
                            % legend_handles = lgd.EntryHandles([4, 10]);
                            % new_legend = legend(legend_handles);


                            %
                            % hold on
                            % legend(SubB, 'Location', 'northwest');
                            % hold off

                            I = getframe(gcf);
                            imwrite(I.cdata,  newFolder+"\"+string(round(ik/2, 1))+"%"+"_StickPic.png")

                            drawnow
                            hold off

                            close all
                        end

                    end
                end
        
            
            end

        end

        %地面反力ベクトルの比較
        skipFrm = 3;
        figure()
        side_list = ["r",  "l",  "rl"];

        rep = round(length(fields)/11, 0);

        scale = 0;
        arrow_color = [ColorA,  ColorB,  "g",  "#ffa200"];
        lgd = [SubA+ShoesA+action,  SubB+ShoesB+action];
        maxim = 0;
        d=0;
        linewidth = 2;

        for iSide = 3%1:length(side_list)
            ele = side_list(iSide)+"GRF";

            for i = 1:2
                %         i=i+1;
                GRF = allall1.(ele+string(i));
                axisX = 1:skipFrm:length(GRF);
                %         plot(axisX,  GRF(axisX,  3))
                quiver3(zeros(length(axisX),  1),  axisX*10,  zeros(length(axisX),  1),  GRF(axisX,  1),  GRF(axisX,  2),  GRF(axisX,  3),  "ShowArrowHead",  "off",  "AutoScale",  scale,  "LineWidth",  linewidth,  "Color",  arrow_color(i))
                hold on
                lgd = vertcat(lgd(i),  allall1.("sub"+string(i))+allall1.("shoes"+string(i))+allall1.("action"+string(i)));
                hold on

                if max(GRF(:,  3)) > maxim
                    maxim = max(GRF(:,  3));

                end
            end

            %     axis([0 200 0 2000 0 maxim])
            legend(lgd,  'Location',  'best')
            view(90,  0)
            grid off
            I = getframe(gcf);
            set(gcf,  'Color',  '#FFFFFF');
            set(gca,  'Color',  '#FFFFFF');
            fig=gcf;
            fig.Color='#FFFFFF';
            fig.InvertHardcopy = 'off';
            ax=gca;
            ax.Color='#FFFFFF';
            saveas(fig,  "..\Res\"+strjoin(erase(strjoin(lgd),  " "))+ele+"_Pic.png")
            %                 imwrite(I.cdata,  "..\Res\"+strjoin(lgd)+ele+"_Pic.png")
            close(gcf)
        end

        %         %速度ベクトルの表示
        %         quier3(allall.PELc(:, 1),  allall.PELc(:, 2),  allall.PELc(:, 3),  )


    end

end


% end

toc
