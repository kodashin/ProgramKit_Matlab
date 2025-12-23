function [ProjData, CS] = calLegCSLeft(trial, seg, FP, no)
num = no;

for nFr = 1:length(seg.PELc)

    %Pelvis segment
    CS.PEL(:, 1+4*(nFr-1):4+4*(nFr-1)) = calPelCS(seg, nFr);
    %Forefoot segment
    CS.lForeFOOT(:, 1+4*(nFr-1):4+4*(nFr-1)) = calLForeFootCS(seg, nFr);
    %Foot segment
    CS.lFOOT(:, 1+4*(nFr-1):4+4*(nFr-1)) = calLFootCS(seg, nFr);
    %Shank segment
    CS.lSHANK(:, 1+4*(nFr-1):4+4*(nFr-1)) = calLShankCS(seg, nFr);
    %Thigh segment
    CS.lTHIGH(:, 1+4*(nFr-1):4+4*(nFr-1))  = calLThighCS(seg, nFr);
    %Ankle joint CS
    CS.lANKjoint(:, 1+4*(nFr-1):4+4*(nFr-1)) = calLAnkleCS(seg, CS, nFr);
    %Knee joint CS
    CS.lKNEEjoint(:, 1+4*(nFr-1):4+4*(nFr-1)) = calLKneeCS(seg, CS, nFr);
    %Hip joint CS
    CS.lHIPjoint(:, 1+4*(nFr-1):4+4*(nFr-1)) = calLHipCS(seg, CS, nFr);


    %-----ソール座標系の定義
    Sangle = calLeftAnglesSole(trial, nFr);
    %つま先
    CS.lR1(:, 1+4*(nFr-1):4+4*(nFr-1)) =Sangle.R1(:, 1+4*(nFr-1):4+4*(nFr-1));
    %前足部
    CS.lR2(:, 1+4*(nFr-1):4+4*(nFr-1)) =Sangle.R1(:, 1+4*(nFr-1):4+4*(nFr-1));
    %中足部2
    CS.lR3(:, 1+4*(nFr-1):4+4*(nFr-1)) =Sangle.R1(:, 1+4*(nFr-1):4+4*(nFr-1));
    %後足部
    CS.lR4(:, 1+4*(nFr-1):4+4*(nFr-1)) =Sangle.R1(:, 1+4*(nFr-1):4+4*(nFr-1));
    %かかと部
    CS.lR5(:, 1+4*(nFr-1):4+4*(nFr-1)) =Sangle.R1(:, 1+4*(nFr-1):4+4*(nFr-1));

    %シューズ座標系にCOP，GRFを投影
          R = CS.lForeFOOT(:, 1+4*(nFr-1):4+4*(nFr-1));
    % R(2:4,1) = seg.lHEELc(nFr,:);
    tmpCOP = R \ [1 FP.COP(num).data(nFr, :)]';
    ProjData.COP_ForeFOOT(nFr, :) = [tmpCOP(2:3, :)' 0];
    tmpGRF = R \ [1 FP.GRF(num).data(nFr, :)]';
    ProjData.GRF_ForeFOOT(nFr, :) = tmpGRF(2:4, :)';

     R = CS.lFOOT(:, 1+4*(nFr-1):4+4*(nFr-1));
    R(2:4,1) = seg.lHEELc(nFr,:);
    tmpCOP = R \ [1 FP.COP(num).data(nFr, :)]';
    ProjData.COP_FOOT(nFr, :) = [tmpCOP(2:3, :)' 0];
    tmpGRF = R \ [1 FP.GRF(num).data(nFr, :)]';
    ProjData.GRF_FOOT(nFr, :) = tmpGRF(2:4, :)';


    [~, cc] = size(trial.lSHOESmkr);
    %描画用にシューズマーカーをシューズ座標系へ投影
    for ij = 1:cc/3

        try
            tmprSHOES = R \ [1 str2double(trial.lSHOESmkr(nFr+1,  1+3*(ij-1):3+3*(ij-1)))]';
             tmprBAL = R \ [1 str2double(trial.lBALl(nFr+1, 1+3*(ij-1):3+3*(ij-1)))]';

        catch
            tmprSHOES = R \ [1 0 0 0]';
            tmprBAL = R \ [1 0 0 0]';


        end
        ProjData.lSHOESmkr_trans(nFr, 1+3*(ij-1):3+3*(ij-1)) = tmprSHOES(2:4, :)';
        ProjData.lBALl_trans(nFr, 1+3*(ij-1):3+3*(ij-1)) = tmprBAL(2:4, :)';

    end

       R = CS.lANKjoint(:, 1+4*(nFr-1):4+4*(nFr-1));
    % R(2:4,1) = seg.rANKc(nFr,:);
    tmpCOP = R \ [1 FP.COP(num).data(nFr, :)]';
    ProjData.COP_ANK(nFr, :) =tmpCOP(2:4, :)';
    tmpGRF = R \ [1 FP.GRF(num).data(nFr, :)]';
    ProjData.GRF_ANK(nFr, :) = tmpGRF(2:4, :)';


end

end