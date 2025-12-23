function res = arrangePlotDataSingle(segD,FP, FPno, side)

tmpL = length(FP.contactPhase);
phase = FP.contactPhase(FPno).data;

% phase = tmpArr;
res.WholeContactPhase = phase';

rGRF = FP.GRF(FPno).data(phase,:);% + FP.GRF(3).data(phase,:);
lGRF = FP.GRF(FPno).data(phase,:);
rCOP = FP.COP(FPno).data(phase,:);% + FP.COP(3).data(phase,:);
lCOP = FP.COP(FPno).data(phase,:);

% fnames = fieldnames(segR);
% side = "r";
seg = "GRF";
res.(side+seg) = rGRF;
seg = "COP";
res.(side+seg) = rCOP;
seg = "rASIS";
res.(seg) = segD.(seg)(phase,:);
seg = "lASIS";
res.(seg) = segD.(seg)(phase,:);
seg = "rPSIS";
res.(seg) = segD.(seg)(phase,:);
seg = "lPSIS";
res.(seg) = segD.(seg)(phase,:);
seg = "rTRO";
res.(seg) = segD.(seg)(phase,:);
seg = "lTRO";
res.(seg) = segD.(seg)(phase,:);
seg = side+"HIPc";
res.(seg) = segD.(seg)(phase,:);
% seg = "lHIPc";
% res.(seg) = segD.(seg)(phase,:);
seg = "KNEEc";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "ANKc";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "HEELl";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "HEELm";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "HEELc";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "BALm";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "BALl";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "MPc";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "TOE";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "KNEEl";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "KNEEm";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "ANKl";
res.(side+seg) = segD.(side+seg)(phase,:);
seg = "ANKm";
res.(side+seg) = segD.(side+seg)(phase,:);


side = "rl";
res.(side+"GRF") = FP.GRF(end).data(phase,:);
res.(side+"COP") = FP.COP(end).data(phase,:);
res.("PELc") = segD.PELc(phase,:);
FR1000 = 1/1000;
res.("PEL_vel") = diff3(segD.PELc(phase,:), FR1000);

% fields = fieldnames(res);
% for i = 1:length(fields)
%     try
%         res.(string(fields(i)))(phasephase,:) = zeros(length(phasephase),3);
% 
%     catch
%         %         res.(string(fields(i)))(:,phasephase) = zeros(1,length(phasephase));
%         continue
%     end
% 
% end


end

