function [res, stand] = calStandRight(nude_list ,stand_files_unique ,marker ,header ,data_dir, replace_list)

tic
ext = ".csv";
FR1000 = 1/1000;
[rr ,~] = size(stand_files_unique);
sub_list = unique(stand_files_unique(:, 2),  "row",  "stable");
nFr_stand = 20;
seg_list = ["THIGH" "SHANK"];
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

%Stand staticの計算
% head = ["Stand Right" "Trial No." "Subject" "Shoes" "Weight[N]" "Hip ang X[deg.]" "Hip ang Y[deg.]" "Hip ang Z[deg.]" "Knee ang X[deg.]" "Knee ang Y[deg.]" "Knee ang Z[deg.]" "Ank ang X[deg.]" "Ank ang Y[deg.]" "Ank ang Z[deg.]" "Foot ang X[deg.]" "Foot ang Y[deg.]" "Foot ang Z[deg.]" "Pel-Foot ang X[deg.]" "Pel-Foot ang Y[deg.]" "Pel-Foot ang Z[deg.]" "Stand COG height[m]"];
% writematrix(head, res_filename+"_static"+resEXT, 'Sheet', 'Rstand', 'WriteMode', 'overwrite', 'UseExcel', 1, 'PreserveFormat', 1, "Range", "A1:A21")


for i = 1:rr
    tic
    clear stand
    sub = stand_files_unique(i, 2);
    shoes = stand_files_unique(i, 3);
    arm = "R";
    disp(string(i)+"/"+rr)
    disp(stand_files_unique(i, 1)+" Right leg stand calculating...")
    disp("Shoes:  "+shoes)
    disp("Subject: "+sub)
  

    [stand.data, stand.text, stand.raw] = xlsread(data_dir+"\"+sub+"\"+string(stand_files_unique(i, 1))+ext);%xlsread(data_dir+string(stand_files_unique(i, 1))+ext);%
    dataRow = find(stand.text(:, 3)=="mm",  1,  "last");

    side = "r";

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
            %マーカー名の入れ替え
            %マーカー名の入れ替え
            if  isempty(replace_list) == 0
                if any(strcmp(mrk, replace_list(1,:)))
                    mrk = replace_list(2, replace_list(1,:) == mrk);
                    tmpP = getMarkerData_stand(stand.data, stand.text, header, marker(ii), nFr_stand, arm);
                end
            else
                tmpP = getMarkerData_stand(stand.data, stand.text, header, mrk, nFr_stand, arm);

            end
            stand.(mrk) = mean(tmpP);%(end-nFr_stand+1:end-nFr_stand+100 ,:
            stand.sdata(: ,1+3*(ii-1):3+3*(ii-1)) = [mrk+"_x" mrk+"_y" mrk+"_z" ;string(stand.(mrk))];

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
    hipc_karivec = (stand.rASIS + stand.rTRO .* 2)./3;
    stand.rHIPc = hipc_karivec.*0.18 + hipc_karivec.*0.82;

    stand.rKNEEc = (stand.rKNEEm + stand.rKNEEl) ./ 2;
    stand.rANKc = (stand.rANKm + stand.rANKl) ./ 2;
    stand.rMPc = (stand.rBALl + stand.rBALm) ./ 2;


    stand.ASISc = (stand.rASIS + stand.lASIS) ./ 2;
    stand.PSISc = (stand.rPSIS + stand.lPSIS) ./ 2;
    stand.PELc = (stand.rASIS + stand.lASIS + stand.rPSIS + stand.lPSIS) ./ 4;
    stand.sdata = horzcat(stand.sdata ,...
        vertcat(["PELc"+"_x" "PELc"+"_y" "PELc"+"_z" ] ,stand.PELc)...
        ,vertcat([side+"HIPc"+"_x" side+"HIPc"+"_y" side+"HIPc"+"_z" ] ,stand.rHIPc)...
        ,vertcat([side+"KNEEc"+"_x" side+"KNEEc"+"_y" side+"KNEEc"+"_z" ] ,stand.rKNEEc)...
        ,vertcat([side+"ANKc"+"_x" side+"ANKc"+"_y" side+"ANKc"+"_z" ] ,stand.rANKc)...
        ,vertcat([side+"MPc"+"_x" side+"MPc"+"_y" side+"MPc"+"_z" ] ,stand.rMPc));

    %立位時の骨盤中心高
    stand.PEL_height = stand.PELc(: ,3);

    %Body segment parameter算出-------------------------------------------------
    %sg :col1→thigh col2→shank col3→foot/row1→right row1→left
    p.weight = stand.sub_weight;
    pnt.datBspR = [stand.rTOE';	stand.rHEELc';	stand.rANKc';	stand.rKNEEc';	stand.rTRO';];
    d=[];
    [pnt ,sg]=setSgRside(p ,pnt ,d);


    %足部セグメント，下腿セグメント，大腿セグメント重心の算出
    stand.rFOOTG = sg(1 ,3).cg;
    stand.rSHANKG = sg(1 ,2).cg;
    stand.rTHIGHG = sg(1 ,1).cg;


    %座標系の定義&関節角度の算出----------------------------
    for ik=1
        %Pelvis segment
        stand.PEL(: ,1+4*(ik-1):4+4*(ik-1)) = calPelCS(stand ,ik);
        %Foot segment
        stand.rFOOT(: ,1+4*(ik-1):4+4*(ik-1)) = calRFootCS(stand ,ik);
        %Fore Foot segment
        [stand.rForeFOOT(: ,1+4*(ik-1):4+4*(ik-1)) ,~ ,~ ,~] = setCoodM(stand.rBALl ,stand.rBALm ,stand.rTOE);
        %Shank segment
        stand.rSHANK(: ,1+4*(ik-1):4+4*(ik-1)) = calRShankCS(stand ,ik);
        %Thigh segment
        stand.rTHIGH(: ,1+4*(ik-1):4+4*(ik-1))  = calRThighCS(stand ,ik);
        %Ankle joint stand
        stand.rANKjoint(: ,1+4*(ik-1):4+4*(ik-1)) = calRAnkleCS(stand ,stand ,ik);
        %Knee joint stand
        stand.rKNEEjoint(: ,1+4*(ik-1):4+4*(ik-1)) = calRKneeCS(stand ,stand ,ik);
        %Hip joint stand
        stand.rHIPjoint(: ,1+4*(ik-1):4+4*(ik-1)) = calRHipCS(stand ,stand ,ik);
        %関節角度の算出----------------------
        JointAngle = calRightAnglesStand(stand ,ik);
        stand.rHIP_ang(ik ,:) = JointAngle(1 ,:);
        stand.rKNEE_ang(ik ,:) = JointAngle(2 ,:);
        stand.rANK_ang(ik ,:) = JointAngle(3 ,:);
        stand.rFOOT_ang(ik ,:) = JointAngle(4 ,:);
        stand.rPelFoot_ang(ik ,:) = JointAngle(5 ,:);
        stand.rForeFoot_ang(ik ,:) = JointAngle(6 ,:);
        stand.PEL_ang(ik,:) = JointAngle(7,:);
        stand.rMP_ang(ik,:) = JointAngle(8,:);

    end
    res.matome(i ,:) = ["" stand_files_unique(i ,1) stand_files_unique(i ,2) stand_files_unique(i ,3) stand.sub_weight stand.rHIP_ang stand.rKNEE_ang stand.rANK_ang stand.rFOOT_ang stand.rPelFoot_ang stand.rForeFoot_ang stand.PELc(: ,3)];

    fields = {'data','text', 'raw'};
    S = rmfield(stand,fields);
    save(mat_dir+stand_files_unique(i, 2)+"_RightStand_"+stand_files_unique(i, 1)+"_"+stand_files_unique(i, 3)+".mat", "S")


    disp("Stand saved")
    disp("-------------------------------------------------")

    %     cellArea = cellName2(1, length(stand.matome(i, :)), 0);
    %     writematrix(stand.matome(i, :), res_filename+"_static"+resEXT, 'Sheet', 'Lstand', 'WriteMode', 'inplace', 'UseExcel', 1, 'PreserveFormat', 1, "Range", cellArea)


    %座標系の確認
    cood_check = "off";
    if cood_check == "on"
        markD = str2double(stand.sdata(2:end ,:));
        headD = stand.sdata(1 ,:);
        svdMarks = ["KNEEl" "KNEEm" "KNEEc" "ANKl" "ANKm" "ANKc"];
        checkD = markD(: ,startsWith(headD ,svdMarks));
        marker_size = 3;
        arrow_len = 0.2;
        figure();
        for ik = 1


            scatter3(markD(ik ,1:3:end) ,markD(ik ,2:3:end) ,markD(ik ,3:3:end) ,25 ,'MarkerFaceColor' ,'k')
            hold on
            scatter3(checkD(ik ,1:3:end) ,checkD(ik ,2:3:end) ,checkD(ik ,3:3:end) ,marker_size ,'MarkerFaceColor' ,'r' ,Marker='*')
            hold on
            grid on

            seg = side+"FOOT";
            quiver3(stand.(seg)(2 ,1+4*(ik-1)) ,stand.(seg)(3 ,1+4*(ik-1)) ,stand.(seg)(4 ,1+4*(ik-1)) ,stand.(seg)(2 ,2+4*(ik-1)) ,stand.(seg)(3 ,2+4*(ik-1)) ,stand.(seg)(4 ,2+4*(ik-1)) ,arrow_len ,"r")
            quiver3(stand.(seg)(2 ,1+4*(ik-1)) ,stand.(seg)(3 ,1+4*(ik-1)) ,stand.(seg)(4 ,1+4*(ik-1)) ,stand.(seg)(2 ,3+4*(ik-1)) ,stand.(seg)(3 ,3+4*(ik-1)) ,stand.(seg)(4 ,3+4*(ik-1)) ,arrow_len ,"g")
            quiver3(stand.(seg)(2 ,1+4*(ik-1)) ,stand.(seg)(3 ,1+4*(ik-1)) ,stand.(seg)(4 ,1+4*(ik-1)) ,stand.(seg)(2 ,4+4*(ik-1)) ,stand.(seg)(3 ,4+4*(ik-1)) ,stand.(seg)(4 ,4+4*(ik-1)) ,arrow_len ,"b")
            hold on

            seg = side+"SHANK";
            quiver3(stand.(seg)(2 ,1+4*(ik-1)) ,stand.(seg)(3 ,1+4*(ik-1)) ,stand.(seg)(4 ,1+4*(ik-1)) ,stand.(seg)(2 ,2+4*(ik-1)) ,stand.(seg)(3 ,2+4*(ik-1)) ,stand.(seg)(4 ,2+4*(ik-1)) ,arrow_len ,"r")
            quiver3(stand.(seg)(2 ,1+4*(ik-1)) ,stand.(seg)(3 ,1+4*(ik-1)) ,stand.(seg)(4 ,1+4*(ik-1)) ,stand.(seg)(2 ,3+4*(ik-1)) ,stand.(seg)(3 ,3+4*(ik-1)) ,stand.(seg)(4 ,3+4*(ik-1)) ,arrow_len ,"g")
            quiver3(stand.(seg)(2 ,1+4*(ik-1)) ,stand.(seg)(3 ,1+4*(ik-1)) ,stand.(seg)(4 ,1+4*(ik-1)) ,stand.(seg)(2 ,4+4*(ik-1)) ,stand.(seg)(3 ,4+4*(ik-1)) ,stand.(seg)(4 ,4+4*(ik-1)) ,arrow_len ,"b")
            hold on

            %FP4
            rectangle('Position' ,[0 0 0.6 0.9])
            hold on
            %FP2
            rectangle('Position' ,[0 -0.9 0.6 0.9])
            hold on

            %Global座標系
            quiver3(0 ,0 ,0 ,1 ,0 ,0 ,"r")
            hold on
            quiver3(0 ,0 ,0 ,0 ,1 ,0 ,"g")
            hold on
            quiver3(0 ,0 ,0 ,0 ,0 ,1 ,"b")
            hold on

            %             %FP座標系原点:FP1
            %             plot3(posiFP(1 ,1) ,posiFP(1 ,2) ,0 ,"ok")
            %             hold on
            %             %FP座標系原点:FP2
            %             plot3(posiFP(2 ,1) ,posiFP(2 ,2) ,0 ,"ok")
            %             hold on


            %         disp(string(round(cnt/(length(duration)+40)*100 ,0))+"%")
            axis([-1 1 -2 2 0 2])
            set(gca ,'DataAspectRatio' ,[1 1 1])
            grid on



        end

    end

    toc
end
res.matome = ["Stand Right" "Trial No." "Subject" "Shoes" "Weight[N]" "Hip ang X[deg.]" "Hip ang Y[deg.]" "Hip ang Z[deg.]" "Knee ang X[deg.]" "Knee ang Y[deg.]" "Knee ang Z[deg.]" "Ank ang X[deg.]" "Ank ang Y[deg.]" "Ank ang Z[deg.]" "Foot ang X[deg.]" "Foot ang Y[deg.]" "Foot ang Z[deg.]" "Pel-Foot ang X[deg.]" "Pel-Foot ang Y[deg.]" "Pel-Foot ang Z[deg.]" "ForeFoot ang X[deg.]" "ForeFoot ang Y[deg.]" "ForeFoot ang Z[deg.]" "Stand COG height[m]"; res.matome];

toc
end