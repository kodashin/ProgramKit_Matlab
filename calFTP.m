function [F,T,P,O] = calFTP(seg,distF,externalMoment,PcgD,PcgP)
% clear Fcg distF wrOMG wrOMGd sgOMG wrIn sgVar Lsg distN PcgD PcgP moP moD
gravity = [0 0 -9.807];
FR1000 = 1/1000;

massmass =  seg.seg_mass;
Fcg = massmass.*(seg.seg_acc-gravity);
% distF = -distF;
F = -Fcg + distF;

%　各セグメントの角速度ベクトル算出
wrOMG	= seg.seg_omega';
Isg = diag(seg.seg_moi);

for iFr=1:length(wrOMG)
    ORmat=seg.seg_ro(2:4,2+4*(iFr-1):4+4*(iFr-1));
    
    %	角速度ベクトル(segment座標系表示)算出
    sgOMG(:,iFr)=inv(ORmat)*wrOMG(:,iFr);
    
    %　慣性行列の計算(ワールド座標系)
    wrIn(iFr).sg		=ORmat*Isg*ORmat';
    sgVar.wr(iFr).I	=wrIn(iFr).sg;
    
    % 角運動量の算出(ワールド座標系)
    Lsg(:,iFr)=wrIn(iFr).sg*wrOMG(:,iFr);
end


%　角運動量の時間微分 → モーメントの算出(ワールド座標系)
Ld=diffspl3(Lsg',length(Lsg),FR1000);

Ncg = Ld;
% externalMoment = -externalMoment;
momentProximal = cross(PcgP,F);
momentDistal = cross(PcgD,distF);
T =  - momentProximal + momentDistal + Ncg + externalMoment;
wrOMG = seg.seg_omegaJoint;
P = T .* wrOMG;
O = wrOMG;


end