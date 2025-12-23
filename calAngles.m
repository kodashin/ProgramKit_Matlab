function [Jangle, Sangle] = calAngles(CS, stand_data, uki_data, num, side, arm)


for nFr = 1:num
    %Calculate lower extrimity joint angle-----
    %matrix
    if side == "l"
        xyz = [-1; -1; 1];
        ang = [0;0;0];

    else
        xyz = [1; 1; 1];
        ang = [0;0;0];

    end

    romatrix = zeros(4, 4);
    romatrix(1, 1) = 1;
    romatrix(2, 2) = xyz(1);
    romatrix(3, 3) = xyz(2);
    romatrix(4, 4) = xyz(3);

    HIP_ro = CS.PEL(:, 1+4*(nFr-1):4+4*(nFr-1)) \ CS.(side+"THIGH")(:, 1+4*(nFr-1):4+4*(nFr-1));
    KNEE_ro = CS.(side+"THIGH")(:, 1+4*(nFr-1):4+4*(nFr-1)) \ CS.(side+"SHANK")(:, 1+4*(nFr-1):4+4*(nFr-1));
    ANK_ro = CS.(side+"SHANK")(:, 1+4*(nFr-1):4+4*(nFr-1)) \ CS.(side+"FOOT")(:, 1+4*(nFr-1):4+4*(nFr-1));
    MP_ro = CS.(side+"FOOT")(:, 1+4*(nFr-1):4+4*(nFr-1)) \ CS.(side+"ForeFOOT")(:, 1+4*(nFr-1):4+4*(nFr-1));
    ForeFoot_ro = romatrix*CS.(side+"ForeFOOT")(:, 1+4*(nFr-1):4+4*(nFr-1));
    SHOES_ro = romatrix*CS.(side+"FOOT")(:, 1+4*(nFr-1):4+4*(nFr-1));% \ ground;%CS.(side+"FOOT")(:, 1+4*(nFr-1):4+4*(nFr-1));%
    PelFoot_ro = CS.PEL(:, 1+4*(nFr-1):4+4*(nFr-1)) \ CS.(side+"FOOT")(:, 1+4*(nFr-1):4+4*(nFr-1));
    SHANK_ro = CS.(side+"SHANK")(:, 1+4*(nFr-1):4+4*(nFr-1));
    THIGH_ro = CS.(side+"THIGH")(:, 1+4*(nFr-1):4+4*(nFr-1));
    PEL_ro = CS.PEL(:, 1+4*(nFr-1):4+4*(nFr-1));

    footAx = 90-rad2deg(acos(dot(SHOES_ro(2:4, 3), [0 1 0])));
    %左打ちの選手の場合はstandデータを左右入れ替える
    if arm == "L" && side == "r"
        side = "l";

    elseif arm == "L" && side == "l"
        side = "r";

    end

    if side == "l"
        try
            HIP_ang = rxyzsolv(HIP_ro(2:4, 2:4)) - stand_data.stand.(side+"HIP_ang");
            HIP_ang2 = rxyzsolv(HIP_ro(2:4, 2:4));

        catch
            HIP_ang = zeros(1, 3);
            HIP_ang2 = zeros(1, 3);

        end
    elseif side == "r"
        try
            HIP_ang = -(rxyzsolv(HIP_ro(2:4, 2:4)) - stand_data.stand.(side+"HIP_ang"));
            HIP_ang2 = -(rxyzsolv(HIP_ro(2:4, 2:4)));

        catch
            HIP_ang = zeros(1, 3);
            HIP_ang2 = zeros(1, 3);

        end
    end

    


    try

        KNEE_ang = rxyzsolv(KNEE_ro(2:4, 2:4)) - stand_data.stand.(side+"KNEE_ang");
        KNEE_ang2 = rxyzsolv(KNEE_ro(2:4, 2:4));
        tmp1 = rxyzsolv(ANK_ro(2:4, 2:4)) - stand_data.stand.(side+"ANK_ang");
        tmp2 = rxyzsolv(ANK_ro(2:4, 2:4));
        tmp3 = rxyzsolv(SHOES_ro(2:4, 2:4)) - stand_data.stand.(side+"FOOT_ang");
        tmp4 = rxyzsolv(SHOES_ro(2:4, 2:4));
        tmp5 = rxyzsolv(PelFoot_ro(2:4, 2:4)) - stand_data.stand.(side+"PelFoot_ang");
        tmp6 = rxyzsolv(PelFoot_ro(2:4, 2:4));
        tmp7 =  rxyzsolv(SHANK_ro(2:4, 2:4));
        tmp8 =  rxyzsolv(THIGH_ro(2:4, 2:4));
        tmp9 =  rxyzsolv(PEL_ro(2:4, 2:4));% - stand_data.stand.("PEL_ang");
        tmp10 = rxyzsolv(MP_ro(2:4, 2:4)) - stand_data.stand.(side+"MP_ang");
        tmp11 = rxyzsolv(ForeFoot_ro(2:4, 2:4)) - stand_data.stand.(side+"ForeFoot_ang");

    catch
        KNEE_ang = zeros(1, 3);
        KNEE_ang2 = zeros(1, 3);
        tmp1 = zeros(1, 3);
        tmp2 = zeros(1, 3);
        tmp3 = zeros(1, 3);
        tmp4 = zeros(1, 3);
        tmp5 = zeros(1, 3);
        tmp6 = zeros(1, 3);
        tmp7 =  zeros(1, 3);
        tmp8 =  zeros(1, 3);
        tmp9 =  zeros(1, 3);
        tmp10 =  zeros(1, 3);
        tmp11 =  zeros(1, 3);

    end



    ANK_ang = tmp1;
    ANK_ang2 = tmp2;
     SHOES_ang = [180+tmp3(1) tmp3(2) tmp3(1)];
    % if side == "r"
    % SHOES_ang = [180+tmp3(1) tmp3(2) tmp3(1)];
    % 
    % elseif side == "l"
    %     SHOES_ang = [180-tmp3(1) tmp3(2) tmp3(1)];
    % 
    % end
    SHOES_ang2 = [180+tmp4(1) tmp4(2) tmp4(1)];
    PelFoot_ang = tmp6;
    SHANK_ang = tmp7;
    THIGH_ang = tmp8;
    PEL_ang = tmp9;
    PEL_ang2 = tmp9;

    MPMP_ang = tmp10+180;
    ForeFoot_ang = tmp11;
    SHOES_ang3 = rad2deg(atan2(CS.(side+"FOOT")(4,3), CS.(side+"FOOT")(3,3)));





    tmp = CS.(side+"HIPjoint")(2:4, 1+4*(nFr-1)) - CS.(side+"ANKjoint")(2:4, 1+4*(nFr-1));
    legangXY = atan2(tmp(2), tmp(1))*180/pi;
    legangYZ = atan2(tmp(3), tmp(2))*180/pi;
    legangZX = atan2(tmp(3), tmp(1))*180/pi;

    %Calculate sole bending angle-----
    Ro_mat1 = CS.(side+"R1")(:, 1+4*(nFr-1):4+4*(nFr-1)) \ CS.(side+"R2")(:, 1+4*(nFr-1):4+4*(nFr-1));
    Ro_mat2 = CS.(side+"R2")(:, 1+4*(nFr-1):4+4*(nFr-1)) \ CS.(side+"R3")(:, 1+4*(nFr-1):4+4*(nFr-1));
    Ro_mat3 = CS.(side+"R3")(:, 1+4*(nFr-1):4+4*(nFr-1)) \ CS.(side+"R4")(:, 1+4*(nFr-1):4+4*(nFr-1));
    Ro_mat4 = CS.(side+"R4")(:, 1+4*(nFr-1):4+4*(nFr-1)) \ CS.(side+"R5")(:, 1+4*(nFr-1):4+4*(nFr-1));
    Ro_mat5 = CS.(side+"R1")(:, 1+4*(nFr-1):4+4*(nFr-1)) \ CS.(side+"R3")(:, 1+4*(nFr-1):4+4*(nFr-1));
    Ro_mat6 = CS.(side+"R3")(:, 1+4*(nFr-1):4+4*(nFr-1)) \ CS.(side+"R5")(:, 1+4*(nFr-1):4+4*(nFr-1));
    Ro_mat1 = replaceNaNInf(Ro_mat1);
    Ro_mat2 = replaceNaNInf(Ro_mat2);
    Ro_mat3 = replaceNaNInf(Ro_mat3);
    Ro_mat4 = replaceNaNInf(Ro_mat4);
    Ro_mat5 = replaceNaNInf(Ro_mat5);
    Ro_mat6 = replaceNaNInf(Ro_mat6);

    try
        tmpAngTOE  = rxyzsolv(Ro_mat1(2:4, 2:4));
        tmpAngMP  = rxyzsolv(Ro_mat2(2:4, 2:4));
        tmpAngMID  = rxyzsolv(Ro_mat3(2:4, 2:4));
        tmpAngHEEL  = rxyzsolv(Ro_mat4(2:4, 2:4));
        tmpAngTOEMID  = rxyzsolv(Ro_mat5(2:4, 2:4));
        tmpAngMIDMID  = rxyzsolv(Ro_mat6(2:4, 2:4));

    catch
        tmpAngTOE  = zeros(1,3);
        tmpAngMP  = zeros(1,3);
        tmpAngMID  = zeros(1,3);
        tmpAngHEEL  = zeros(1,3);
        tmpAngTOEMID  = zeros(1,3);
        tmpAngMIDMID  = zeros(1,3);

        % disp(upper(side)+" sole angle calculation error: "+ string(nFr))

    end

    TOE_ang = -((tmpAngTOE - uki_data.(side+"uki").TOE_ang));
    MP_ang = ((tmpAngMP - uki_data.(side+"uki").MP_ang));
    MID_ang = (tmpAngMID - uki_data.(side+"uki").MID_ang);
    HEEL_ang = (tmpAngHEEL - uki_data.(side+"uki").HEEL_ang);
    TOEMID_ang = (tmpAngTOEMID - uki_data.(side+"uki").TOEMID_ang);
    MIDMID_ang = (tmpAngMIDMID - uki_data.(side+"uki").MIDMID_ang);

    TOE_ang2 = tmpAngTOE;
    MP_ang2 = tmpAngMP;
    MID_ang2 = tmpAngMID;
    HEEL_ang2 = tmpAngHEEL;
    TOEMID_ang2 = tmpAngTOEMID;
    MIDMID_ang2 = tmpAngMIDMID;

    tmp1 = tmpAngTOE(1);
    tmp2 = tmpAngMP(1);
    tmp3 = tmpAngMID(1);
    tmp4 = tmpAngHEEL(1);
    tmp5 = tmpAngTOEMID(1);

    TOE_ang3 = (tmpAngTOE - tmp1);
    MP_ang3 = (tmpAngMP - tmp2);
    MID_ang3 = (tmpAngMID - tmp3);
    HEEL_ang3 = (tmpAngHEEL - tmp4);
    TOEMID_ang3 = tmpAngTOEMID - tmp5;

    %戻り値------------------------------------
    Jangle.(side+"HIP_ang")(nFr, :) = HIP_ang;
    Jangle.(side+"HIP_ang2")(nFr, :) = HIP_ang2;
    Jangle.(side+"KNEE_ang")(nFr, :) = KNEE_ang;
    Jangle.(side+"KNEE_ang2")(nFr, :) = KNEE_ang2;
    Jangle.(side+"ANK_ang")(nFr, :) = [-ANK_ang(1) ANK_ang(2:3)];
    Jangle.(side+"ANK_ang2")(nFr, :) = ANK_ang2;
     Jangle.(side+"MP_ang")(nFr, :) = MPMP_ang;
     Jangle.(side+"ForeFOOT_ang")(nFr, :) = ForeFoot_ang;
    Jangle.(side+"FOOT_ang")(nFr, :) = SHOES_ang;
    Jangle.(side+"FOOT_ang2")(nFr, :) = SHOES_ang2;
    Jangle.(side+"FOOT_ang3")(nFr, :) = SHOES_ang3;
    Jangle.(side+"PelFoot_ang")(nFr, :) = PelFoot_ang;
    Jangle.(side+"SHANK_ang")(nFr, :) = SHANK_ang;
    Jangle.(side+"THIGH_ang")(nFr, :) = THIGH_ang;
    Jangle.(side+"PEL_ang")(nFr, :) = PEL_ang;
    Jangle.(side+"PEL_ang2")(nFr, :) = PEL_ang2;
    Jangle.(side+"PEL_ang")(nFr, :) = PEL_ang;
    Jangle.(side+"LEG_ang")(nFr, 1) = legangXY;
    Jangle.(side+"LEG_ang")(nFr, 2) = legangYZ;
    Jangle.(side+"LEG_ang")(nFr, 3) = legangZX;
    Jangle.(side+"FOOTdir_ang")(nFr, 1) = footAx;

    if side == "r"
        Sangle.(side+"TOE_ang")(nFr, :) = TOE_ang;
        Sangle.(side+"MP_ang")(nFr, :) = MP_ang;
        Sangle.(side+"MID_ang")(nFr, :) = MID_ang;

    elseif side == "l"
        Sangle.(side+"TOE_ang")(nFr, :) = -TOE_ang;
        Sangle.(side+"MP_ang")(nFr, :) = MP_ang;
        Sangle.(side+"MID_ang")(nFr, :) = -MID_ang;

    end
    Sangle.(side+"HEEL_ang")(nFr, :) = HEEL_ang;
    Sangle.(side+"TOEMID_ang")(nFr, :) = TOEMID_ang;
    Sangle.(side+"MIDMID_ang")(nFr, :) = TOEMID_ang;

    Sangle.(side+"TOE_ang2")(nFr, :) = TOE_ang2;
    Sangle.(side+"MP_ang2")(nFr, :) = -MP_ang2;
    Sangle.(side+"MID_ang2")(nFr, :) = MID_ang2;
    Sangle.(side+"HEEL_ang2")(nFr, :) = -HEEL_ang2;
    Sangle.(side+"TOEMID_ang2")(nFr, :) = TOEMID_ang2;
    Sangle.(side+"MIDMID_ang2")(nFr, :) = TOEMID_ang2;


    Sangle.(side+"TOE_ang3")(nFr, :) = TOE_ang3;
    Sangle.(side+"MP_ang3")(nFr, :) = MP_ang3;
    Sangle.(side+"MID_ang3")(nFr, :) = MID_ang3;
    Sangle.(side+"HEEL_ang3")(nFr, :) = HEEL_ang3;
    Sangle.(side+"TOEMID_ang3")(nFr, :) = TOEMID_ang3;

end


end