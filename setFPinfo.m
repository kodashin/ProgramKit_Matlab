function FP = setFPinfo(trial, FPnum, posiFP, arm, fpOrder, stepOrder, Dposi, fpNo)

% Dposi = [29:36;12:19;46:53;];%
% fpNo = [5 1];
FR1000 = 1/1000;
if fpOrder == "12"
    direc = [-1 1;-1 1];

elseif fpOrder == "21"
    direc = [-1 1;-1 1];

end
side = ["l",  "r", "l","r"];
p=[];

line = ["-", "--", "-."];

FP.GRF(FPnum+1).data = zeros(length(trial.rASIS) ,3);
FP.COP(FPnum+1).data = zeros(length(trial.rASIS) ,3);
FP.Tz(FPnum+1).data = zeros(length(trial.rASIS) ,3);
%i = 2
FP.trial = trial.trial_file;
if arm == "L"
    posiFP = [-posiFP(1,1) posiFP(1,2) posiFP(1,3) posiFP(1,4);-posiFP(2,1) posiFP(2,2) posiFP(2,3) posiFP(2,4)];
    direc = [1 1;1 1];
end

figure()
for iFP = 1:FPnum
    try
        tra =  find(strcmp(trial.text(:, 1), "Trajectories"), 1);
        FP.raw.data = trial.data(5:tra-3, Dposi(iFP, :));
        FP.raw.data(isnan(FP.raw.data)) = 0; 
        %     FP.raw(i).data(FP.raw(i).data(:, 6)>7) = 0;
        FP.range_xy.data = 10000;
        FP.range_z.data = 10000;
        FP.thickness.data = 0.017;
        FP.threshold.data = 40;

        FP.side = side(iFP);
        FP.side_no = iFP;
        %基線の修正の有無-------------
        modify = "tail";
        [fp, ~] = getFPvar(p, FP, fpNo(iFP),modify);

        if mean(fp.F(1:10, 3))<-FP.threshold.data
            %基線の修正の有無-------------
        modify = "top";
        [fp, ~] = getFPvar(p, FP, fpNo(iFP),modify);


        end
        FP.sdata.data = fp.sdata;


        % else
        FP.GRF(iFP).data = [-fp.F(:, 1)*direc(iFP, 1) -fp.F(:, 2)*direc(iFP, 2) fp.F(:, 3)];
        FP.COP(iFP).data = [fp.cp(:, 1)*direc(iFP, 1)+posiFP(iFP, 1) fp.cp(:, 2)*direc(iFP, 2)+posiFP(iFP, 2) fp.cp(:, 3)];
        FP.M(iFP).data =  [fp.M(:, 1)*direc(iFP, 1) fp.M(:, 2)*direc(iFP, 2) fp.M(:, 3)];
        phase = find(FP.GRF(iFP).data(:, 3) > FP.threshold.data);
        topC = arraySeries(phase,  "top")';
        botC = arraySeries(phase,  "bot")';
        topImp = sum(FP.GRF(iFP).data(topC, 3))*FR1000;
        botImp = sum(FP.GRF(iFP).data(botC, 3))*FR1000;

        if topImp > botImp
            Ctime = topC;

        elseif topImp < botImp
            Ctime  = botC;

        end

      

        FP.Tz(iFP).data = [zeros(length(fp.sdata), 2) fp.Tz];


        %接地期の設定
        % endP = find(FP.GRF(i).data(:, 3)>FP.threshold(i).data, 1, "last");

        %Force, COPは接地機以外は0とする
        FP.contactPhase(iFP).data = Ctime;%arraySeries(find(FP.GRF(i).data(:, 3) > FP.threshold(i).data),  "top")'
        tmptmp = [1:FP.contactPhase(iFP).data(1) FP.contactPhase(iFP).data(end):length(FP.GRF(iFP).data(:, 3))];
        FP.GRF(iFP).data(tmptmp, :) = 0;
        FP.COP(iFP).data(tmptmp, :) = 0;
        clear tmptmp

        %トラクション係数の算出
        FP.COF(iFP).data = FP.GRF(iFP).data(:, 2)./FP.GRF(iFP).data(:, 3);
        FP.GRFvecYZ_ang(iFP).data = rad2deg(atan2(FP.GRF(iFP).data(:, 3), FP.GRF(iFP).data(:, 2)));
        FP.GRFvecXY_ang(iFP).data = rad2deg(atan2(FP.GRF(iFP).data(:, 1), FP.GRF(iFP).data(:, 2)));
        FP.GRFvecZX_ang(iFP).data = rad2deg(atan2(FP.GRF(iFP).data(:, 3), FP.GRF(iFP).data(:, 1)));

        %まとめFPデータを格納
        FP.GRF(FPnum+1).data= FP.GRF(FPnum+1).data + FP.GRF(iFP).data;
        FP.COP(FPnum+1).data =  FP.COP(FPnum+1).data+FP.COP(iFP).data;
        FP.Tz(FPnum+1).data =  FP.Tz(FPnum+1).data+FP.Tz(1).data;
      

        title("FP: "+fpNo(iFP))
        plot(FP.GRF(iFP).data(:,1), "r"+line(iFP))
        hold on
        plot(-FP.GRF(iFP).data(:,2), "g"+line(iFP))
        hold on
        plot(FP.GRF(iFP).data(:,3), "b"+line(iFP))
        hold on
        plot(FP.contactPhase(iFP).data([1 end]), FP.GRF(iFP).data(FP.contactPhase(iFP).data([1 end]), :), "o")
        hold on
        % close all

    catch
        disp("Check FP: "+iFP)
        continue

    end


end


  arr = [FP.contactPhase(1).data;FP.contactPhase(2).data];
  FP.contactPhase(FPnum+1).data = [min(arr):max(arr)]';

  axis([FP.contactPhase(FPnum+1).data(1)-20 FP.contactPhase(FPnum+1).data(end)+20 -1500 3000])


% FP = sumFP_Data(FP, posiFP);
% 
% FP.GRF(FPnum+1).data = FP.GRF(1).data+FP.GRF(2).data+FP.GRF(3).data;
% FP.COP(FPnum+1).data =  FP.COP(1).data+FP.COP(2).data+FP.COP(3).data;
% FP.COP(FPnum+1).data(:, 2) =
% FP.COP(FPnum+1).data(:, 3) = 0;
% FP.Tz(FPnum+1).data = FP.Tz(1).data+FP.Tz(2).data+FP.Tz(2).data;
% arr = [FP.contactPhase(1).data;FP.contactPhase(2).data;FP.contactPhase(3).data];
% FP.contactPhase(FPnum+1).data = [min(arr):max(arr)]';

% %接地期の重複の確認
% checkDuplicateContactPhase([FP.contactPhase])



end