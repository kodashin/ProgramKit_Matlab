function [PrjctData, CS] = calLegCS(trial, seg, FP, FPno,side)

if side == "r"
    [PrjctData, CS] = calLegCSRight(trial, seg, FP, FPno);

elseif side =="l"
    [PrjctData, CS] = calLegCSLeft(trial, seg, FP, FPno);

end


end