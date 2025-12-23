function res = arrangePlotData(segR,segL,FP, FPno)

tmpL = length(FP.contactPhase);
phase = FP.contactPhase(FPno).data;

% phase = tmpArr;
res.WholeContactPhase = phase';

rGRF = FP.GRF(1).data(phase,:);% + FP.GRF(3).data(phase,:);
lGRF = FP.GRF(2).data(phase,:);
rCOP = FP.COP(1).data(phase,:);% + FP.COP(3).data(phase,:);
lCOP = FP.COP(2).data(phase,:);

% fnames = fieldnames(segR);
side = "r";
seg = "GRF";
FPno = length(rGRF);%FP.side_no(FP.side==side);
res.(side+seg) = rGRF;
seg = "COP";
res.(side+seg) = rCOP;
seg = "rASIS";
res.(seg) = segR.(seg)(phase,:);
seg = "lASIS";
res.(seg) = segR.(seg)(phase,:);
seg = "rPSIS";
res.(seg) = segR.(seg)(phase,:);
seg = "lPSIS";
res.(seg) = segR.(seg)(phase,:);
seg = "rTRO";
res.(seg) = segR.(seg)(phase,:);
% seg = "lTRO";
% res.(seg) = segR.(seg)(phase,:);
seg = "rHIPc";
res.(seg) = segR.(seg)(phase,:);
% seg = "lHIPc";
% res.(seg) = segR.(seg)(phase,:);
seg = "KNEEc";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "ANKc";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "HEELl";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "HEELm";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "HEELc";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "BALm";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "BALl";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "MPc";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "TOE";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "KNEEl";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "KNEEm";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "ANKl";
res.(side+seg) = segR.(side+seg)(phase,:);
seg = "ANKm";
res.(side+seg) = segR.(side+seg)(phase,:);



side = "l";
seg = "GRF";
res.(side+seg) = lGRF;
seg = "COP";
res.(side+seg) = lCOP;
seg = "ASIS";
res.(side+seg) = segL.(side+seg)(phase,:);
seg = "PSIS";
res.(side+seg) = segL.(side+seg)(phase,:);
seg = "TRO";
res.(side+seg) = segL.(side+seg)(phase,:);
seg = "HIPc";
res.(side+seg) = segL.(side+seg)(phase,:);
seg = "KNEEc";
res.(side+seg) = segL.(side+seg)(phase,:);
seg = "ANKc";
res.(side+seg) = segL.(side+seg)(phase,:);
seg = "HEELl";
res.(side+seg) = segL.(side+seg)(phase,:);
seg = "HEELm";
res.(side+seg) = segL.(side+seg)(phase,:);
seg = "HEELc";
res.(side+seg) = segL.(side+seg)(phase,:);
seg = "BALm";
res.(side+seg) = segL.(side+seg)(phase,:);
seg = "BALl";
res.(side+seg) = segL.(side+seg)(phase,:);
seg = "TOE";
res.(side+seg) = segL.(side+seg)(phase,:);


side = "rl";
res.(side+"GRF") = FP.GRF(end).data(phase,:);
res.(side+"COP") = FP.COP(end).data(phase,:);
res.("PELc") = segR.PELc(phase,:);
FR1000 = 1/1000;
res.("PEL_vel") = diff3(segR.PELc(phase,:), FR1000);

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

