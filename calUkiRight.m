function res = calUkiRight(ruki_files_unique, marker, header, data_dir)
ext = ".csv";
[rr, ~] = size(ruki_files_unique);
%     sdata = [];
[status,  msg,  msgID] = mkdir('..\mat');
excelapp = actxserver('Excel.Application');
excelapp.DisplayAlerts = false;
for i = 1:rr
    disp(string(i)+"/"+length(ruki_files_unique))
    disp(ruki_files_unique(i, 1)+"  R-uki calculating...")
    disp("Shoes:  "+ruki_files_unique(i, 3))
    disp("Subject: "+ruki_files_unique(i, 2))
   
    ttl = char(ruki_files_unique(i, 1));
   
    try
        [ruki.data, ruki.text, ruki.raw] = xlsread(data_dir+"\"+ruki_files_unique(i, 2)+"\"+string(ruki_files_unique(i, 1))+ext);

    catch
        [ruki.data, ruki.text, ruki.raw] = xlsread(data_dir+"\"+string(ruki_files_unique(i, 1))+ext);

    end

    tra = find(string(ruki.text) == 'Trajectories');
    nFr_ruki = length(ruki.data(5:tra-3, 12:19));

    %------------------------------- 座標データの処理
    % データの抜出し
    rm = 0;
    lm = 0;

    for ii = 1:length(marker)

        ruki.(marker(ii)) = mean(getMarkerData4(ruki.data, ruki.text, header, marker(ii), nFr_ruki, "R"));
        ruki.sdata(:, 1+3*(ii-1):3+3*(ii-1)) = [marker(ii)+"_x" marker(ii)+"_y" marker(ii)+"_z" ;string(ruki.(marker(ii)))];


    end
    sdata(1+2*(i-1):2+2*(i-1), :) = ruki.sdata;

    %-----ソール座標系の定義とソール角度の算出
    Sangle = calRightAnglesSole(ruki, 1);
    ruki.TOE_ang = Sangle.toe;
    ruki.MP_ang = Sangle.mp;
    ruki.MID_ang = Sangle.mid;
    ruki.HEEL_ang = Sangle.heel;
    ruki.TOEMID_ang = Sangle.toemid;
    ruki.MIDMID_ang = Sangle.midmid;


    ruki.rR1 = Sangle.R1;
    ruki.rR2 = Sangle.R2;
    ruki.rR3 = Sangle.R3;
    ruki.rR4 = Sangle.R4;
    ruki.rR5 = Sangle.R5;

    res.matome(i, :) = ["" ruki_files_unique(i, 1) ruki_files_unique(i, 2) ruki_files_unique(i, 3) ruki.TOE_ang ruki.MP_ang ruki.MID_ang ruki.HEEL_ang ruki.TOEMID_ang ruki.MIDMID_ang];


    fields = {'data', 'text',  'raw'};
    S = rmfield(ruki, fields);
    save("..\mat\"+ruki_files_unique(i, 2)+"_Ruki_"+ruki_files_unique(i, 1)+"_"+ruki_files_unique(i, 3)+".mat", "S")
    disp("R-uki saved")
    disp("-------------------------------------------------")


end
res.matome = ["R uki" "Trial No." "Subject" "Shoes" "TOE X[deg.]" "TOE Y[deg.]" "TOE Z[deg.]" "MP X[deg.]" "MP Y[deg.]" "MP Z[deg.]" "MID X[deg.]" "MID Y[deg.]" "MID Z[deg.]" "HEEL X[deg.]" "HEEL Y[deg.]" "HEEL Z[deg.]" "TOEMID X[deg.]" "TOEMID Y[deg.]" "TOEMID Z[deg.]" "MIDMID X[deg.]" "MIDMID Y[deg.]" "MIDMID Z[deg.]";res.matome];
fclose('all');

end