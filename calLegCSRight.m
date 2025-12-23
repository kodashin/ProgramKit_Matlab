function [ProjData, CS] = calLegCSRight(trial, seg, FP, no)
num = no;

for nFr = 1:length(seg.PELc)

    %Pelvis segment
    CS.PEL(:, 1+4*(nFr-1):4+4*(nFr-1)) = calPelCS(seg, nFr);
    %Forefoot segment
    CS.rForeFOOT(:, 1+4*(nFr-1):4+4*(nFr-1)) = calRForeFootCS(seg, nFr);
    %Foot segment
    CS.rFOOT(:, 1+4*(nFr-1):4+4*(nFr-1)) = calRFootCS(seg, nFr);
    %Shank segment
    CS.rSHANK(:, 1+4*(nFr-1):4+4*(nFr-1)) = calRShankCS(seg, nFr);
    %Thigh segment
    CS.rTHIGH(:, 1+4*(nFr-1):4+4*(nFr-1))  = calRThighCS(seg, nFr);
    %Ankle joint CS
    CS.rANKjoint(:, 1+4*(nFr-1):4+4*(nFr-1)) = calRAnkleCS(seg, CS, nFr);
    %Knee joint CS
    CS.rKNEEjoint(:, 1+4*(nFr-1):4+4*(nFr-1)) = calRKneeCS(seg, CS, nFr);
    %Hip joint CS
    CS.rHIPjoint(:, 1+4*(nFr-1):4+4*(nFr-1)) = calRHipCS(seg, CS, nFr);


    %-----ソール座標系の定義
    Sangle = calRightAnglesSole(trial, nFr);
    %つま先
    CS.rR1(:, 1+4*(nFr-1):4+4*(nFr-1)) = ones(4);%Sangle.R1;%(:, 1+4*(nFr-1):4+4*(nFr-1));
    %前足部
    CS.rR2(:, 1+4*(nFr-1):4+4*(nFr-1)) = ones(4);%Sangle.R2;%(:, 1+4*(nFr-1):4+4*(nFr-1));
    %中足部2
    CS.rR3(:, 1+4*(nFr-1):4+4*(nFr-1)) = ones(4);%Sangle.R3;%(:, 1+4*(nFr-1):4+4*(nFr-1));
    %後足部
    CS.rR4(:, 1+4*(nFr-1):4+4*(nFr-1)) = ones(4);%Sangle.R4;%(:, 1+4*(nFr-1):4+4*(nFr-1));
    %かかと部
    CS.rR5(:, 1+4*(nFr-1):4+4*(nFr-1)) = ones(4);%Sangle.R5;%(:, 1+4*(nFr-1):4+4*(nFr-1));


    %シューズ座標系にCOP，GRFを投影
    R = CS.rForeFOOT(:, 1+4*(nFr-1):4+4*(nFr-1));
    % R(2:4,1) = seg.rHEELc(nFr,:);
    tmpCOP = R \ [1 FP.COP(num).data(nFr, :)]';
    ProjData.COP_ForeFOOT(nFr, :) = [tmpCOP(2:3, :)' 0];
    tmpGRF = R \ [1 FP.GRF(num).data(nFr, :)]';
    ProjData.GRF_ForeFOOT(nFr, :) = tmpGRF(2:4, :)';

    R = CS.rFOOT(:, 1+4*(nFr-1):4+4*(nFr-1));
    R(2:4,1) = seg.rHEELc(nFr,:);
    tmpCOP = R \ [1 FP.COP(num).data(nFr, :)]';
    ProjData.COP_FOOT(nFr, :) = [tmpCOP(2:3, :)' 0];
    tmpGRF = R \ [1 FP.GRF(num).data(nFr, :)]';
    ProjData.GRF_FOOT(nFr, :) = tmpGRF(2:4, :)';

   


    [~, cc] = size(trial.rSHOESmkr);

    %描画用にシューズマーカーをシューズ座標系へ投影
    for ij = 1:cc/3

        try
            tmprSHOES = R \ [1 str2double(trial.rSHOESmkr(nFr+1, 1+3*(ij-1):3+3*(ij-1)))]';
            tmprBAL = R \ [1 str2double(trial.rBALl(nFr+1, 1+3*(ij-1):3+3*(ij-1)))]';

        catch
            tmprSHOES = R \ [1 0 0 0]';
            tmprBAL = R \ [1 0 0 0]';

        end
        ProjData.rSHOESmkr_trans(nFr, 1+3*(ij-1):3+3*(ij-1)) = tmprSHOES(2:4, :)';
         ProjData.rBALl_trans(nFr, 1+3*(ij-1):3+3*(ij-1)) = tmprBAL(2:4, :)';

    end

     R = CS.rANKjoint(:, 1+4*(nFr-1):4+4*(nFr-1));
    % R(2:4,1) = seg.rANKc(nFr,:);
    tmpCOP = R \ [1 FP.COP(num).data(nFr, :)]';
    ProjData.COP_ANK(nFr, :) =tmpCOP(2:4, :)';
    tmpGRF = R \ [1 FP.GRF(num).data(nFr, :)]';
    ProjData.GRF_ANK(nFr, :) = tmpGRF(2:4, :)';


end

end