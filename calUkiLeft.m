function res = calUkiLeft(luki_files_unique, marker, header, data_dir)
ext = ".csv";
[rr, ~] = size(luki_files_unique);
[status, msg, msgID] = mkdir('..\mat');


for i = 1:rr
    disp(string(i)+"/"+rr)
    disp(luki_files_unique(i, 1)+"  L-uki calculating...")
    disp("Shoes:  "+luki_files_unique(i, 3))
    disp("Subject: "+luki_files_unique(i, 2))

    sub = luki_files_unique(i, 2);
    shoes = luki_files_unique(i, 3);
   


    try
        [luki.data, luki.text, luki.raw] = xlsread(data_dir+"\"+ruki_files_unique(i, 2)+"\"+string(ruki_files_unique(i, 1))+ext);

    catch
        [luki.data, luki.text, luki.raw] = xlsread(data_dir+"\"+string(ruki_files_unique(i, 1))+ext);

    end
    tra = find(string(luki.text) == 'Trajectories');
    nFr_ruki = length(luki.data(5:tra-3, 12:19));

    %------------------------------- 座標データの処理
    % データの抜出し
    rm = 0;
    lm = 0;
    for ii = 1:length(marker)

        luki.(marker(ii)) = mean(getMarkerData4(luki.data, luki.text, header, marker(ii), nFr_ruki, "R"));
        luki.sdata(:, 1+3*(ii-1):3+3*(ii-1)) = [marker(ii)+"_x" marker(ii)+"_y" marker(ii)+"_z" ;string(luki.(marker(ii)))];


    end

    %-----ソール座標系の定義
    Sangle = calLeftAnglesSole(luki, 1);
    luki.TOE_ang = Sangle.toe;
    luki.MP_ang = Sangle.mp;
    luki.MID_ang = Sangle.mid;
    luki.HEEL_ang = Sangle.heel;
    luki.TOEMID_ang = Sangle.toemid;
    luki.MIDMID_ang = Sangle.midmid;

    luki.lR1 = Sangle.R1;
    luki.lR2 = Sangle.R2;
    luki.lR3 = Sangle.R3;
    luki.lR4 = Sangle.R4;
    luki.lR5 = Sangle.R5;

    res.matome(i, :) = ["" luki_files_unique(i, 1) luki_files_unique(i, 2) luki_files_unique(i, 3) luki.TOE_ang luki.MP_ang luki.MID_ang luki.HEEL_ang luki.TOEMID_ang luki.MIDMID_ang];

    fields = {'data', 'text', 'raw'};
    S = rmfield(luki, fields);
    save("..\mat\"+luki_files_unique(i, 2)+"_Luki_"+luki_files_unique(i, 1)+"_"+luki_files_unique(i, 3)+".mat", "S")
    disp("L-uki saved")
    disp("-------------------------------------------------")


end
res.matome = ["L uki" "Trial No." "Subject" "Shoes" "TOE X[deg.]" "TOE Y[deg.]" "TOE Z[deg.]" "MP X[deg.]" "MP Y[deg.]" "MP Z[deg.]" "MID X[deg.]" "MID Y[deg.]" "MID Z[deg.]" "HEEL X[deg.]" "HEEL Y[deg.]" "HEEL Z[deg.]" "TOEMID X[deg.]" "TOEMID Y[deg.]" "TOEMID Z[deg.]" "MIDMID X[deg.]" "MIDMID Y[deg.]" "MIDMID Z[deg.]";res.matome];
fclose('all');
end