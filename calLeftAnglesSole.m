function Sangle = calLeftAnglesSole(trial,nFr)

%デフォルト引数を設定
arguments
    trial = [];
    nFr = 1;
end

try

    tmpRO = setLeftSoleCS(trial,nFr);
    %つま先
    uki.R1(:,1+4*(nFr-1):4+4*(nFr-1)) = [tmpRO(:,1) tmpRO(:,2) tmpRO(:,3) tmpRO(:,4)];
    %前足部
    uki.R2(:,1+4*(nFr-1):4+4*(nFr-1)) = [tmpRO(:,5) tmpRO(:,6) tmpRO(:,7) tmpRO(:,8)];
    %中足部
    uki.R3(:,1+4*(nFr-1):4+4*(nFr-1)) = [tmpRO(:,9) tmpRO(:,10) tmpRO(:,11) tmpRO(:,12)];
    %後足部
    uki.R4(:,1+4*(nFr-1):4+4*(nFr-1)) = [tmpRO(:,13) tmpRO(:,14) tmpRO(:,15) tmpRO(:,16)];
    %かかと部
    uki.R5(:,1+4*(nFr-1):4+4*(nFr-1)) = [tmpRO(:,17) tmpRO(:,18) tmpRO(:,19) tmpRO(:,20)];

    %定義された座標系の確認：軸の向きを表す部分がすべて0の場合は1を代入
    for i = 1:5
        if sum(uki.("R"+i)(2:4, 2+4*(nFr-1):4+4*(nFr-1)), "all") == 0
            uki.("R"+i)(:,1+4*(nFr-1):4+4*(nFr-1))  = ones(4,4);

        end
    end


    %Calculate sole bending angle-----
    Ro_mat1 = uki.R1(:,1+4*(nFr-1):4+4*(nFr-1)) \  uki.R2(:,1+4*(nFr-1):4+4*(nFr-1));
    Ro_mat2 = uki.R2(:,1+4*(nFr-1):4+4*(nFr-1)) \ uki.R3(:,1+4*(nFr-1):4+4*(nFr-1));
    Ro_mat3 = uki.R3(:,1+4*(nFr-1):4+4*(nFr-1)) \ uki.R4(:,1+4*(nFr-1):4+4*(nFr-1));
    Ro_mat4 = uki.R4(:,1+4*(nFr-1):4+4*(nFr-1)) \ uki.R5(:,1+4*(nFr-1):4+4*(nFr-1));
    Ro_mat5 = uki.R1(:,1+4*(nFr-1):4+4*(nFr-1)) \ uki.R3(:,1+4*(nFr-1):4+4*(nFr-1));
    Ro_mat6 = uki.R3(:,1+4*(nFr-1):4+4*(nFr-1)) \ uki.R5(:,1+4*(nFr-1):4+4*(nFr-1));


    try
        tmpAngTOE  = rxyzsolv(Ro_mat1(2:4,2:4));
        tmpAngMP  = rxyzsolv(Ro_mat2(2:4,2:4));
        tmpAngMID  = rxyzsolv(Ro_mat3(2:4,2:4));
        tmpAngHEEL  = rxyzsolv(Ro_mat4(2:4,2:4));
        tmpAngTOEMID  = rxyzsolv(Ro_mat5(2:4,2:4));
        tmpAngMIDMID  = rxyzsolv(Ro_mat6(2:4,2:4));

    catch
        tmpAngTOE  = zeros(1,3);
        tmpAngMP  = zeros(1,3);
        tmpAngMID  = zeros(1,3);
        tmpAngHEEL  = zeros(1,3);
        tmpAngTOEMID  = zeros(1,3);
        tmpAngMIDMID  = zeros(1,3);

    end

    TOE_ang = (tmpAngTOE);
    MP_ang = (tmpAngMP);
    MID_ang = (tmpAngMID);
    HEEL_ang = (tmpAngHEEL);
    TOEMID_ang = tmpAngTOEMID;
    MIDMID_ang = tmpAngMIDMID;


    Sangle.R1 = uki.R1;
    Sangle.R2 = uki.R2;
    Sangle.R3 = uki.R3;
    Sangle.R4 = uki.R4;
    Sangle.R5 = uki.R5;


catch
    TOE_ang = zeros(1,3);
    MP_ang = zeros(1,3);
    MID_ang = zeros(1,3);
    HEEL_ang = zeros(1,3);
    TOEMID_ang = zeros(1,3);
    MIDMID_ang = zeros(1,3);

    Sangle.R1 = zeros(4);
    Sangle.R2 = zeros(4);
    Sangle.R3 = zeros(4);
    Sangle.R4 = zeros(4);
    Sangle.R5 = zeros(4);

end

Sangle.toe = TOE_ang;
Sangle.mp = MP_ang;
Sangle.mid = MID_ang;
Sangle.heel = HEEL_ang;
Sangle.toemid = TOEMID_ang;
Sangle.midmid = MIDMID_ang;


end