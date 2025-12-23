function [fp, dt_FP]=getFPvar(p, FP, num,modify)

% %基線の修正の有無-------------
% modify = "tail";

% if FP.trial == "Trial211"
%     modify = "tail";
%
% end


tmp_fp(1).data	=FP.raw.data;			%新たな実験データの際には要修正

dt_FP = 1000;
nFr=length(tmp_fp(1).data(:, 1));

fp	=set_FP_parameters(p);


Gx=FP.range_xy.data;
Gy=FP.range_xy.data;
Gz=FP.range_z.data;
t	=FP.thickness.data;

for iFP=1%:length(fp)

    [nDat, nComp]=size(tmp_fp(iFP).data);
    time_int		=1/dt_FP;

    % --- Smoothing [Butterworth Digital Filter] ---
    cf=100;
    sdata=butterworth(tmp_fp(iFP).data', nComp, nDat, time_int, cf);
    tmp_fp(iFP).sdata=sdata';

    if modify == "top"
        % --- 基線の修正 ---
        for iCh=1:8
            tmpBase(iCh).dat=mean(tmp_fp(iFP).sdata(1:10, iCh));
            tmp_fp(iFP).sdata(:, iCh)=tmp_fp(iFP).sdata(:, iCh)-tmpBase(iCh).dat;
        end
    elseif modify == "tail"
        for iCh=1:8
            tmpBase(iCh).dat=mean(tmp_fp(iFP).sdata(end-10:end, iCh));
            tmp_fp(iFP).sdata(:, iCh)=tmp_fp(iFP).sdata(:, iCh)-tmpBase(iCh).dat;
        end


    end
    %     tmp_fp(iFP).sdata(tmpPhase_not,:) = 0;

    if sum(mean(tmp_fp(iFP).sdata(end-9:end, 6)) - mean(tmp_fp(iFP).sdata(1:10, 6)))> 2
        [b, ~] = getWavePeak2(tmp_fp(iFP).sdata(:, 6), "on", "time");
        c = b(find(tmp_fp(iFP).sdata(b, 6)<4, 1, "last"));
        tmp_fp(iFP).sdata(c+2:end, :) = 0;

    end


    %----- convert analog data [V] into the force data [N] -----
    sfp(iFP).dt	=time_int;
    % 		sfp(iFP).num=tmp_data(:, 1)';

    k1=Gx/(10*fp(num).S(1));
    k2=Gx/(10*fp(num).S(2));

    k3=Gy/(10*fp(num).S(3));
    k4=Gy/(10*fp(num).S(4));

    k5=Gz/(10*fp(num).S(5));
    k6=Gz/(10*fp(num).S(6));
    k7=Gz/(10*fp(num).S(7));
    k8=Gz/(10*fp(num).S(8));


   

    sfp(iFP).sFr	=0;
    flag_On	=0;
    flag_Off=0;

    for iFr=1:nDat
        sfp(iFP).c1(:, iFr)=fp(iFP).corner(1).xyz/1000;
        sfp(iFP).c2(:, iFr)=fp(iFP).corner(2).xyz/1000;
        sfp(iFP).c3(:, iFr)=fp(iFP).corner(3).xyz/1000;
        sfp(iFP).c4(:, iFr)=fp(iFP).corner(4).xyz/1000;

        Fx12=tmp_fp(iFP).sdata(iFr, 1)*k1;
        Fx34=tmp_fp(iFP).sdata(iFr, 2)*k2;
        Fy14=tmp_fp(iFP).sdata(iFr, 3)*k3;
        Fy23=tmp_fp(iFP).sdata(iFr, 4)*k4;

        Fz1	=tmp_fp(iFP).sdata(iFr, 5)*k5;
        Fz2	=tmp_fp(iFP).sdata(iFr, 6)*k6;
        Fz3	=tmp_fp(iFP).sdata(iFr, 7)*k7;
        Fz4	=tmp_fp(iFP).sdata(iFr, 8)*k8;


        fx=(Fx12+Fx34);
        fy=(Fy14+Fy23);
        fz=Fz1+Fz2+Fz3+Fz4;

        Mx=fp(iFP).b*(Fz1+Fz2-Fz3-Fz4);
        My=fp(iFP).a*(-Fz1+Fz2+Fz3-Fz4);
        Mz=fp(iFP).b*(-Fx12+Fx34)+fp(iFP).a*(Fy14-Fy23);



        if abs(fz)>FP(1).threshold.data
            if flag_On==0
                sfp(iFP).sFr=iFr;
                flag_On=1;
            end
          
            Ax=(fx*(fp(iFP).az-t)-My)/fz;		%	FP座標系でのCoPx
            Ay=(fy*(fp(iFP).az-t)+Mx)/fz;		%	FP座標系でのCoPy

            %             Ax
            %             stop
            AAx(iFr, :) = Ax;
            AAy(iFr, :) = Ay;
            Tz=Mz-fy*Ax+fx*Ay;

            %================================================================
            sfp(iFP).F(iFr, :) =[fx fy fz];	%	反力
            %             sfp(iFP).cp(iFr, :)=[(Ax+fp(iFP).o_x0) (Ay+fp(iFP).o_y0) 0];%World座標系でのCop
            sfp(iFP).cp(iFr, :)=[Ax Ay 0];%World座標系でのCop

            sfp(iFP).sdata(iFr, :)= tmp_fp(iFP).sdata(iFr, :);
            sfp(iFP).Tz(iFr, :)=Tz;
            sfp(iFP).M(iFr, :) = [Mx My Mz];
            %================================================================
            %             stvOn=1;
            %             if stvOn==1
            %                 list=dlmread('.\lsp\COP.lsp');
            %                 dim=3;
            %                 fps=15;
            %                 stview(sfp(1).cp, list, dim, fps);
            % %                 STVIEW(sfp(1).cp, list, dim, fps);
            %             end


        else
            sfp(iFP).sdata(iFr, :)	=[zeros(8, 1)];
            sfp(iFP).F(iFr, :)	=[zeros(3, 1)];
            sfp(iFP).cp(iFr, :)	=[zeros(3, 1)];
            sfp(iFP).Tz(iFr, :)	=0;
            sfp(iFP).M(iFr, :)	=[zeros(3, 1)];
        end
    end

    for iFr=1:nDat
        sfp(iFP).N(iFr, :)=[0 0 sfp(iFP).Tz(iFr)];
    end
    
end

fp=sfp;

return;