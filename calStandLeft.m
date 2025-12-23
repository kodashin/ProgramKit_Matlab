function [res, stand] = calStandLeft(nude_list, stand_files_unique,  marker,  header,  data_dir, replace_list)%

ext = ".csv";
FR1000 = 1/1000;
[rr, ~] = size(stand_files_unique);
sub_list = unique(stand_files_unique(:, 2), "stable");
nFr_stand = 20;
seg_list = ["SHANK" "FOOT"];
resEXT = ".xlsx";
svdMarks = ["KNEEl" "KNEEm" "ANKl" "ANKm"];
% marker_sdata =  ["rASIS", "lASIS", "rPSIS", "lPSIS", "rTRO", "lTRO", ...
%     "rKNEEl", "rKNEEm", "rDUM1au", "rDUM1pu", "rDUM1al", "rDUM1pl", ...
%     "rANKl", "rANKm", "rDUM2au", "rDUM2pu", "rDUM2al", "rDUM2pl", ...
%         "lKNEEm", "lKNEEl", "lDUM1au", "lDUM1pu", "lDUM1al", "lDUM1pl", ...
%     "lANKm", "lANKl", "lDUM2au", "lDUM2pu", "lDUM2al", "lDUM2pl", ...
%     ];
marker_sdata = ["rASIS","lASIS","rPSIS","lPSIS","rTRO","lTRO","rDUM1au","rDUM1pu","rDUM1al","rDUM1pl",...
    "rKNL","rKNM","rDUM2au","rDUM2pu","rDUM2al","rDUM2pl","rANL","rANM",...
    "lDUM1au","lDUM1pu","lDUM1al","lDUM1pl","lKNl","lKNm","lDUM2au","lDUM2pu","lDUM2al","lDUM2pl","lANl","lANm"];

%結果を格納するフォルダの確認
mat_dir = "..\mat\";
createFolderIfNotExist(mat_dir);


%Nudeデータの計算
try
    nude = calNudeData(unique(nude_list(:,[3 2]),  "rows", "stable"), sub_list, data_dir, marker, marker, replace_list, header, nFr_stand);
    nude_cal = 1;

catch
    nude_cal = 0;

end

%Stand staの計算
% head = ["Stand Left" "Trial No." "Subject" "Shoes" "Weight[N]" "Hip ang X[deg.]" "Hip ang Y[deg.]" "Hip ang Z[deg.]" "Knee ang X[deg.]" "Knee ang Y[deg.]" "Knee ang Z[deg.]" "Ank ang X[deg.]" "Ank ang Y[deg.]" "Ank ang Z[deg.]" "Foot ang X[deg.]" "Foot ang Y[deg.]" "Foot ang Z[deg.]" "Pel-Foot ang X[deg.]" "Pel-Foot ang Y[deg.]" "Pel-Foot ang Z[deg.]" "Stand COG height[m]"];
% writematrix(head, res_filename+"_sta"+resEXT, 'Sheet', 'Lstand', 'WriteMode', 'overwrite', 'UseExcel', 1, 'PreserveFormat', 1, "Range", "A1:A21")
for i = 1:rr

    clear stand
    sub = stand_files_unique(i, 2);
    shoes = stand_files_unique(i, 3);  
    disp(string(i)+"/"+rr)
    disp(stand_files_unique(i, 1)+" Left leg stand calculating...")
    disp("Shoes:  "+shoes)
    disp("Subject: "+sub)
    arm = "R";
  

    [stand.data, stand.text, stand.raw] = xlsread(data_dir+"\"+sub+"\"+string(stand_files_unique(i, 1))+ext);%xlsread(data_dir+string(stand_files_unique(i, 1))+ext);%
    dataRow = find(stand.text(:, 3)=="mm",  1,  "last");
    side = "l";

    %--- 座標データの処理
    % データの抜出し
    if nude_cal == 1
        for ii = 1:length(marker)
            mrk = marker(ii);
            %SVDマーカー以外
            if contains(mrk ,svdMarks) == 0
                % try
                %マーカー名の入れ替え
                if  isempty(replace_list) == 0 &&  any(strcmp(mrk, replace_list(1,:)))
                    tmpP = getMarkerData_stand(stand.data, stand.text, header, mrk, nFr_stand, arm);
                    mrk = replace_list(2, replace_list(1,:) == mrk);

                else
                    tmpP = getMarkerData_stand(stand.data, stand.text, header, mrk, nFr_stand, arm);

                end
                stand.(mrk) = mean(tmpP);%(end-nFr_stand+1:end-nFr_stand+100 ,:
                col = 1+3*(ii-1):3+3*(ii-1);
                stand.sdata(: ,col) = [mrk+"_x" mrk+"_y" mrk+"_z" ;string(stand.(mrk))];

                % catch
                %     disp("Stand marker data missing: "+mrk)
                %
                % end

                %SVD対象マーカー
            else
                try
                    tmpPP = getMarkerData_stand(stand.dat, stand.text, header, mrk, nFr_stand, arm);
                    stand.("tmp"+mrk) =  mean(tmpPP(end-nFr_stand+1:end ,:));

                catch
                    disp("Stand marker data missing: tmp"+mrk)
                end
            end
        end

    elseif nude_cal == 0
        for ii = 1:length(marker)
            mrk = marker(ii);

            % マーカー名の置換処理
            if ~isempty(replace_list)
                idx = strcmp(mrk, replace_list(1,:));
                if any(idx)
                    mrk = replace_list(2, idx);
                end
            end

            % マーカーデータの取得と平均値の計算
            tmpP = getMarkerData_stand(stand.data, stand.text, header, mrk, nFr_stand, arm);
            stand.(mrk) = mean(tmpP);

            % データの格納
            colIdx = 1+3*(ii-1):3+3*(ii-1);
            stand.sdata(:, colIdx) = [mrk+"_x" mrk+"_y" mrk+"_z"; string(stand.(mrk))];

        end

    end

    if nude_cal == 1

        nudeD = nude.(stand_files_unique(i, 2)).(stand_files_unique(i, 4));
        
        no = 2;
        stand.("svd_"+side+seg_list(no)) = ...
            SVDm([[nudeD.(side+"DUM"+no+"au")  nudeD.(side+"DUM"+no+"al") nudeD.(side+"DUM"+no+"pl")];...
            [stand.(side+"DUM"+no+"au")  stand.(side+"DUM"+no+"al") stand.(side+"DUM"+no+"pl")]]);
        pnt_name = side+"ANKl";
        tmp = stand.("svd_"+side+seg_list(no)) * [nudeD.(pnt_name) 1]';
        stand.(pnt_name) = tmp(1:end-1)';
        stand.sdata = [stand.sdata [pnt_name+"_x" pnt_name+"_y" pnt_name+"_z";stand.(pnt_name)]];
        pnt_name = side+"ANKm";
        tmp = stand.("svd_"+side+seg_list(no)) * [nudeD.(pnt_name) 1]';
        stand.(pnt_name) = tmp(1:end-1)';
        stand.sdata = [stand.sdata [pnt_name+"_x" pnt_name+"_y" pnt_name+"_z";stand.(pnt_name)]];

        no = 1;
        stand.("svd_"+side+seg_list(no)) = SVDm([[nudeD.(side+"DUM"+no+"au")  nudeD.(side+"DUM"+no+"al") nudeD.(side+"DUM"+no+"pl")];...
            [stand.(side+"DUM"+no+"au")  stand.(side+"DUM"+no+"al") stand.(side+"DUM"+no+"pl")]]);
        pnt_name = side+"KNEEl";
        tmp = stand.("svd_"+side+seg_list(no)) * [nudeD.(pnt_name) 1]';
        stand.(pnt_name) = tmp(1:end-1)';
        stand.sdata = [stand.sdata [pnt_name+"_x" pnt_name+"_y" pnt_name+"_z";stand.(pnt_name)]];
        pnt_name = side+"KNEEm";
        tmp = stand.("svd_"+side+seg_list(no)) * [nudeD.(pnt_name) 1]';
        stand.(pnt_name) = tmp(1:end-1)';
        stand.sdata = [stand.sdata [pnt_name+"_x" pnt_name+"_y" pnt_name+"_z";stand.(pnt_name)]];

        stand.PEL_seg = SVDm([[nudeD.rASIS nudeD.lASIS nudeD.lPSIS];...
            [stand.rASIS stand.lASIS stand.lPSIS]]);
        tmp = stand.PEL_seg * [nudeD.rPSIS 1]';
        stand.rPSIS = tmp(1:end-1)';
        stand.sdata = [stand.sdata [pnt_name+"_x" pnt_name+"_y" pnt_name+"_z";stand.rPSIS]];

    end

    %---被験者体重の算出
    stand.tra = find(stand.text(:, 1) == "Trajectories");
    stand.FPdata = stand.data(20:30, 5);
    stand.sub_weight = -mean(stand.FPdata);%unit:N
    stand.sub_weight_N = stand.sub_weight;%unit:N
    stand.sub_weight_kg = stand.sub_weight/9.81;%unit:kg


    %---関節中心の推定
    hipc_karivecL = (stand.lASIS + stand.lTRO .* 2)./3;
    stand.lHIPc = hipc_karivecL.*0.18 + hipc_karivecL.*0.82;

    stand.lKNEEc = (stand.lKNEEm + stand.lKNEEl) ./ 2;
    stand.lANKc = (stand.lANKm + stand.lANKl) ./ 2;
    stand.lMPc = (stand.lBALl + stand.lBALm) ./ 2;


    stand.ASISc = (stand.rASIS + stand.lASIS) ./ 2;
    stand.PSISc = (stand.rPSIS + stand.lPSIS) ./ 2;
    stand.PELc = (stand.rASIS + stand.lASIS + stand.rPSIS + stand.lPSIS) ./ 4;
    stand.sdata = horzcat(stand.sdata, ...
        vertcat(["PELc"+"_x" "PELc"+"_y" "PELc"+"_z" ], stand.PELc)...
        , vertcat([side+"HIPc"+"_x" side+"HIPc"+"_y" side+"HIPc"+"_z" ], stand.lHIPc)...
        , vertcat([side+"KNEEc"+"_x" side+"KNEEc"+"_y" side+"KNEEc"+"_z" ], stand.lKNEEc)...
        , vertcat([side+"ANKc"+"_x" side+"ANKc"+"_y" side+"ANKc"+"_z" ], stand.lANKc)...
        , vertcat([side+"MPc"+"_x" side+"MPc"+"_y" side+"MPc"+"_z" ], stand.lMPc));

    %立位時の骨盤中心高
    stand.PEL_height = stand.PELc(:, 3);

    %Body segment parameter算出-------------------------------------------------
    %sg :col1→thigh col2→shank col3→foot/row1→right row1→left
    p.weight = stand.sub_weight;
    pnt.datBspR = [stand.lTOE';	stand.lHEELc';	stand.lANKc';	stand.lKNEEc';	stand.lTRO';];
    d=[];
    [~, sg]=setSgRside(p, pnt, d);


    %足部セグメント，下腿セグメント，大腿セグメント重心の算出
    stand.lFOOTG = sg(1, 3).cg;
    stand.lSHANKG = sg(1, 2).cg;
    stand.lTHIGHG = sg(1, 1).cg;

    %     %脚の長さ算出
    %     stand.lLeg_len = norm((stand.lHIPc - stand.lANKc));


    %座標系の定義&関節角度の算出----------------------------
    for ik=1
        %Pelvis segment
        stand.PEL(:, 1+4*(ik-1):4+4*(ik-1)) = calPelCS(stand, ik);
        %         %Toe segment
        %         stand.lTOE(:, 1+4*(ik-1):4+4*(ik-1))
        %Foot segment
        stand.lFOOT(:, 1+4*(ik-1):4+4*(ik-1)) = calLFootCS(stand, ik);
        %Fore Foot segment
        [stand.lForeFOOT(: , 1+4*(ik-1):4+4*(ik-1)) , ~ , ~ , ~] = setCoodM(stand.lBALl , stand.lBALm , stand.lTOE);
        %Shank segment
        stand.lSHANK(:, 1+4*(ik-1):4+4*(ik-1)) = calLShankCS(stand, ik);
        %Thigh segment
        stand.lTHIGH(:, 1+4*(ik-1):4+4*(ik-1))  = calLThighCS(stand, ik);
        %Ankle joint stand
        stand.lANKjoint(:, 1+4*(ik-1):4+4*(ik-1)) = calLAnkleCS(stand, stand, ik);
        %Knee joint stand
        stand.lKNEEjoint(:, 1+4*(ik-1):4+4*(ik-1)) = calLKneeCS(stand, stand, ik);
        %Hip joint stand
        stand.lHIPjoint(:, 1+4*(ik-1):4+4*(ik-1)) = calLHipCS(stand, stand, ik);

        %関節角度の算出----------------------
        JointAngle = calLeftAnglesStand(stand, ik);
        stand.lHIP_ang(ik, :) = JointAngle(1, :);
        stand.lKNEE_ang(ik, :) = JointAngle(2, :);
        stand.lANK_ang(ik, :) = JointAngle(3, :);
        stand.lFOOT_ang(ik, :) = JointAngle(4, :);
        stand.lPelFoot_ang(ik, :) = JointAngle(5, :);
        stand.lForeFoot_ang(ik , :) = JointAngle(6 , :);
        stand.PEL_ang(ik, :) = JointAngle(7, :);
        stand.lMP_ang(ik,:) = JointAngle(8,:);

    end
    res.matome(i, :) = ["" stand_files_unique(i, 1) stand_files_unique(i, 2) stand_files_unique(i, 3) stand.sub_weight stand.lHIP_ang stand.lKNEE_ang stand.lANK_ang stand.lFOOT_ang stand.lForeFoot_ang stand.PELc(:, 3)];

    fields = {'data','text', 'raw'};
    S = rmfield(stand,fields);
    save(mat_dir+stand_files_unique(i, 2)+"_LeftStand_"+stand_files_unique(i, 1)+"_"+stand_files_unique(i, 3)+".mat", "S")
    %     testS = load("..\mat\"+stand_files_unique(i, 2)+"_LeftStand_"+stand_files_unique(i, 1)+"_"+stand_files_unique(i, 3)+".mat");
    %     a = "..\mat\MORI_RightStand_Trial55_DC00.mat";
    %     b= "..\mat\"+stand_files_unique(i, 2)+"_RightStand_"+stand_files_unique(i, 1)+"_"+stand_files_unique(i, 3)+".mat";
    %     a==b


    disp("Stand saved")
    disp("-------------------------------------------------")


    %座標系の確認
    cood_check = "off";
    if cood_check == "on"
        data = stand.sdata;
        markD = str2double(data(2:end, :));
        headD = data(1, :);

        checkD = markD(:, startsWith(headD, "l"+svdMarks));
        marker_size = 3;
        arrow_len = 0.2;
        figure();
        for ik = 1


            scatter3(markD(ik, 1:3:end), markD(ik, 2:3:end), markD(ik, 3:3:end), 25, 'MarkerFaceColor', 'k')
            hold on
            scatter3(checkD(ik, 1:3:end), checkD(ik, 2:3:end), checkD(ik, 3:3:end), marker_size*2, 'MarkerFaceColor', 'r', Marker='*')
            hold on
            grid on

            %             seg = "lFOOT";
            %             quiver3(stand.(seg)(2, 1+4*(ik-1)), stand.(seg)(3, 1+4*(ik-1)), stand.(seg)(4, 1+4*(ik-1)), stand.(seg)(2, 2+4*(ik-1)), stand.(seg)(3, 2+4*(ik-1)), stand.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
            %             quiver3(stand.(seg)(2, 1+4*(ik-1)), stand.(seg)(3, 1+4*(ik-1)), stand.(seg)(4, 1+4*(ik-1)), stand.(seg)(2, 3+4*(ik-1)), stand.(seg)(3, 3+4*(ik-1)), stand.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
            %             quiver3(stand.(seg)(2, 1+4*(ik-1)), stand.(seg)(3, 1+4*(ik-1)), stand.(seg)(4, 1+4*(ik-1)), stand.(seg)(2, 4+4*(ik-1)), stand.(seg)(3, 4+4*(ik-1)), stand.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
            %             hold on
            %
            %             seg = "PEL";
            %             quiver3(stand.(seg)(2, 1+4*(ik-1)), stand.(seg)(3, 1+4*(ik-1)), stand.(seg)(4, 1+4*(ik-1)), stand.(seg)(2, 2+4*(ik-1)), stand.(seg)(3, 2+4*(ik-1)), stand.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
            %             quiver3(stand.(seg)(2, 1+4*(ik-1)), stand.(seg)(3, 1+4*(ik-1)), stand.(seg)(4, 1+4*(ik-1)), stand.(seg)(2, 3+4*(ik-1)), stand.(seg)(3, 3+4*(ik-1)), stand.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
            %             quiver3(stand.(seg)(2, 1+4*(ik-1)), stand.(seg)(3, 1+4*(ik-1)), stand.(seg)(4, 1+4*(ik-1)), stand.(seg)(2, 4+4*(ik-1)), stand.(seg)(3, 4+4*(ik-1)), stand.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
            %             hold on
            %
            %             seg = "lSHANK";
            %             quiver3(stand.(seg)(2, 1+4*(ik-1)), stand.(seg)(3, 1+4*(ik-1)), stand.(seg)(4, 1+4*(ik-1)), stand.(seg)(2, 2+4*(ik-1)), stand.(seg)(3, 2+4*(ik-1)), stand.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
            %             quiver3(stand.(seg)(2, 1+4*(ik-1)), stand.(seg)(3, 1+4*(ik-1)), stand.(seg)(4, 1+4*(ik-1)), stand.(seg)(2, 3+4*(ik-1)), stand.(seg)(3, 3+4*(ik-1)), stand.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
            %             quiver3(stand.(seg)(2, 1+4*(ik-1)), stand.(seg)(3, 1+4*(ik-1)), stand.(seg)(4, 1+4*(ik-1)), stand.(seg)(2, 4+4*(ik-1)), stand.(seg)(3, 4+4*(ik-1)), stand.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
            %             hold on

            %FP4
            rectangle('Position', [0 0 0.6 0.9])
            hold on
            %FP2
            rectangle('Position', [0 -0.9 0.6 0.9])
            hold on

            %Global座標系
            quiver3(0, 0, 0, 1, 0, 0, "r")
            hold on
            quiver3(0, 0, 0, 0, 1, 0, "g")
            hold on
            quiver3(0, 0, 0, 0, 0, 1, "b")
            hold on

            %             %FP座標系原点:FP1
            %             plot3(posiFP(1, 1), posiFP(1, 2), 0, "ok")
            %             hold on
            %             %FP座標系原点:FP2
            %             plot3(posiFP(2, 1), posiFP(2, 2), 0, "ok")
            %             hold on


            %         disp(string(round(cnt/(length(duration)+40)*100, 0))+"%")
            axis([-1 1 -2 2 0 2])
            set(gca, 'DataAspectRatio', [1 1 1])
            grid on



        end


    end


end



res.matome = ["Stand Left" "Trial No." "Subject" "Shoes" "Weight[N]" "Hip ang X[deg.]" "Hip ang Y[deg.]" "Hip ang Z[deg.]" "Knee ang X[deg.]" "Knee ang Y[deg.]" "Knee ang Z[deg.]" "Ank ang X[deg.]" "Ank ang Y[deg.]" "Ank ang Z[deg.]" "Foot ang X[deg.]" "Foot ang Y[deg.]" "Foot ang Z[deg.]" "Pel-Foot ang X[deg.]" "Pel-Foot ang Y[deg.]" "Pel-Foot ang Z[deg.]" "Stand COG height[m]"; res.matome];
% writematrix(stand.matome, res_dir+res_filename, 'Sheet', 'Lstand', 'WriteMode', 'overwritesheet', 'UseExcel', 1, 'PreserveFormat', 1)

end