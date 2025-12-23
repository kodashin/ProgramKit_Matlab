function point = savePntDataRL(result, dinfo, top)
FR1000 = 1/1000;
point = [];
weight_kg = dinfo.weight_kg;

%データ範囲は接地期のみ
%Fzから重力を引く
phase1 = result.ContactPhase1 - result.ContactPhase1(1)+1;
phase2 = result.ContactPhase2 - result.ContactPhase1(1)+1;


phase = result.ContactPhase - result.ContactPhase(1)+1;

PELc = result.PELc(:,2) - result.PELc(1,2);

H = max(result.PELc(:,3));
H0 = dinfo.PELc_stand(:,3);
H0H1 = result.PELc(result.ContactPhase(end),3);
H1 = H0H1 - H0; 
H2 = H - H0H1;

try
    H_cg = max(result.BODY_CG(:,3));
    H2_cg = H_cg - H0H1;

catch

end

g = 9.81;

PEL_vel_contact = result.PEL_vel_contact;
PELc_contact = result.PELc_contact;
PEL_vel_ang_contact =  result.PEL_vel_ang_contact;

[pel_bot, pel_bot_idx] = min(PELc_contact(:,3));
[pel_vel_bot, pel_vel_bot_idx] = min(PEL_vel_contact(:,3));

[H_cal, H2_cal]= calHighestPoint(H0H1, PEL_vel_contact(end,:));

a = vecnorm(PEL_vel_contact(end, : ));
b = PEL_vel_contact(end, 3 );
H_stan = (b^2)/(2*g);
H2_stan = H_stan - H0H1;

H2_ene = (PEL_vel_contact(end, 3)^2)/(2*g);
H_ene = H2_ene + H0H1; 

H2_imp = ((dinfo.weight_kg*result.PEL_vel_contact(end-result.extra, 3) - sum(result.GRF(:,3))*FR1000)/dinfo.weight_kg)^2/(2*9.81);

point = horzcat(point, [dinfo.InputE dinfo.AER dinfo.RER dinfo.MaxDisp]);

point = horzcat(point, H);
point = horzcat(point, H2);
point = horzcat(point, H_ene);
point = horzcat(point, H2_ene);


try
point = horzcat(point, H_cg);
point = horzcat(point, H2_cg);

catch

end

point = horzcat(point, H_cal);
point = horzcat(point, H2_cal);
point = horzcat(point, H_stan);
point = horzcat(point, H2_stan);
point = horzcat(point, H2_imp);
point = horzcat(point, H0H1);
point = horzcat(point, H0);
point = horzcat(point, H1);

point = horzcat(point, H/H0);
point = horzcat(point, H2/H0);
point = horzcat(point, H0H1/H0);
point = horzcat(point, H0/H0);


point = horzcat(point, length(phase1)*FR1000);
point = horzcat(point, length(phase2)*FR1000);
point = horzcat(point, phase2(1)*FR1000);

point = horzcat(point, PELc_contact(1,:));
point = horzcat(point, PELc_contact(pel_bot_idx,:));
point = horzcat(point, PELc_contact(end,:));
point = horzcat(point, PELc_contact(pel_bot_idx,:)- PELc_contact(1,:));
point = horzcat(point, PELc_contact(end,:) - PELc_contact(pel_bot_idx,:));

point = horzcat(point, PELc_contact(end,:) - PELc_contact(1,:));


[pel_vel_max,pel_vel_max_i] = max(PEL_vel_contact);
point = horzcat(point, PEL_vel_contact(1,:));
point = horzcat(point, PEL_vel_contact(pel_bot_idx,:));
point = horzcat(point, PEL_vel_contact(end,:));
point = horzcat(point, PEL_vel_contact(pel_bot_idx,:) - PEL_vel_contact(1,:));
point = horzcat(point, PEL_vel_contact(end,:) - PEL_vel_contact(pel_bot_idx,:));
point = horzcat(point, pel_vel_max - PEL_vel_contact(pel_bot_idx,:));
point = horzcat(point, PEL_vel_contact(end,:) - PEL_vel_contact(1,:));
point = horzcat(point, PEL_vel_ang_contact(1,:));
point = horzcat(point, PEL_vel_ang_contact(pel_bot_idx,:));
point = horzcat(point, PEL_vel_ang_contact(end,:));


% %Impulse-all
GRF_W = result.GRF_W;
GRF_WG = result.GRF_WG;
GRF_G = result.GRF_G;
GRF = result.GRF;

GRF_R = result.GRF1;
GRF_L = result.GRF2;

point = horzcat(point, sum(GRF_WG)*FR1000);
point = horzcat(point, sum(GRF_WG(1:pel_bot_idx, :))*FR1000);
point = horzcat(point, sum(GRF_WG(pel_bot_idx:end, :))*FR1000);
point = horzcat(point, sum(GRF_WG(pel_bot_idx:pel_vel_max_i, :))*FR1000);
point = horzcat(point, sum(GRF_W(1:pel_bot_idx, :))*FR1000);
point = horzcat(point, sum(GRF_W(pel_bot_idx:end, :))*FR1000);
point = horzcat(point, sum(GRF_W(pel_bot_idx:pel_vel_max_i, :))*FR1000);
point = horzcat(point, sum(GRF_W)*FR1000);
point = horzcat(point, sum(GRF_G)*FR1000);
point = horzcat(point, sum(GRF)*FR1000);

point = horzcat(point, sum(GRF_WG(phase1(1):phase2(1), :))*FR1000);
point = horzcat(point, sum(GRF_W(phase1(1):phase2(1), :))*FR1000);
point = horzcat(point, sum(GRF_G(phase1(1):phase2(1), :))*FR1000);
point = horzcat(point, sum(GRF(phase1(1):phase2(1), :))*FR1000);

point = horzcat(point, sum(GRF_WG(phase2, :))*FR1000);
point = horzcat(point, sum(GRF_W(phase2, :))*FR1000);
point = horzcat(point, sum(GRF_G(phase2, :))*FR1000);
point = horzcat(point, sum(GRF(phase2, :))*FR1000);
point = horzcat(point, sum(GRF_R(phase2, :))*FR1000);
point = horzcat(point, sum(GRF_L(phase2, :))*FR1000);

point = horzcat(point, PEL_vel_contact(phase2(1), :) - PEL_vel_contact(phase1(1), :));
point = horzcat(point, PEL_vel_contact(phase2(end), :) - PEL_vel_contact(phase2(1), :));


point = horzcat(point, mean(GRF_WG));
point = horzcat(point, mean(GRF_WG(1:pel_bot_idx, :)));
point = horzcat(point, mean(GRF_WG(pel_bot_idx:end, :)));
point = horzcat(point, max(GRF_W));
point = horzcat(point, min(GRF_W));
point  = horzcat(point, PEL_vel_contact(end,:)-PEL_vel_contact(1,:));
point  = horzcat(point, PELc_contact(end,:)-PELc_contact(1,:));
point  = horzcat(point, PELc_contact(1,:));
point  = horzcat(point, PELc_contact(end,:));


%Impulse-1
GRF_W = result.GRF1_W;
GRF = result.GRF1;
PEL_vel_contact = result.PEL_vel1;
PELc_contact = result.PELc_contact1;
point = horzcat(point, length(GRF)*FR1000);
point = horzcat(point, sum(GRF_W)*FR1000);
point = horzcat(point, sum(GRF_W(1:pel_bot_idx, :))*FR1000);
point = horzcat(point, sum(GRF_W(pel_bot_idx:end, :))*FR1000);
point = horzcat(point, sum(GRF)*FR1000);
point = horzcat(point, mean(GRF_W));
point = horzcat(point, mean(GRF_W(1:pel_bot_idx, :)));
point = horzcat(point, mean(GRF_W(pel_bot_idx:end, :)));
point = horzcat(point, max(GRF_W));
point = horzcat(point, min(GRF_W));
point  = horzcat(point, PEL_vel_contact(end,:)-PEL_vel_contact(1,:));
point  = horzcat(point, PELc_contact(end,:)-PELc_contact(1,:));
point  = horzcat(point, PELc_contact(1,:));
point  = horzcat(point, PELc_contact(end,:));

imp1 =sum(GRF_W)*FR1000;
imp1_posi =sum(GRF_W(GRF_W(:,2)<0, :))*FR1000;
imp1_nega =sum(GRF_W(GRF_W(:,2)<0, :))*FR1000;

%Impulse-2
GRF_W = result.GRF2_W;
GRF = result.GRF2;
PEL_vel_contact = result.PEL_vel2;
PELc_contact = result.PELc_contact2;
point = horzcat(point, length(GRF)*FR1000);
point = horzcat(point, sum(GRF_W)*FR1000);
point = horzcat(point, sum(GRF_W(1:pel_bot_idx, :))*FR1000);
point = horzcat(point, sum(GRF_W(pel_bot_idx:end, :))*FR1000);
point = horzcat(point, sum(GRF)*FR1000);
point = horzcat(point, mean(GRF_W));
point = horzcat(point, mean(GRF_W(1:pel_bot_idx, :)));
point = horzcat(point, mean(GRF_W(pel_bot_idx:end, :)));
point = horzcat(point, max(GRF_W));
point = horzcat(point, min(GRF_W));
point  = horzcat(point, PEL_vel_contact(end,:)-PEL_vel_contact(1,:));
point  = horzcat(point, PELc_contact(end,:)-PELc_contact(1,:));
point  = horzcat(point, PELc_contact(1,:));
point  = horzcat(point, PELc_contact(end,:));


 %Impulse ratio
imp2 =sum(GRF_W)*FR1000;
imp2_posi =sum(GRF_W(GRF_W(:,2)<0, :))*FR1000;
imp2_nega =sum(GRF_W(GRF_W(:,2)>=0, :))*FR1000;

imp_ratio = imp1./imp2;
imp_posi_ratio = imp1_posi./imp2_posi;
imp_nega_ratio = imp1_nega./imp2_nega;

point = horzcat(point, imp_ratio);
point = horzcat(point, imp_posi_ratio);
point = horzcat(point, imp_nega_ratio);

%Body Posture
point = horzcat(point, (result.ContactPhase2(end) - result.ContactPhase1(end) +1)*FR1000);
var1 = result.rANKcCOG_ctct(end, :);
var2 = result.lANKcCOG_ctct(end, :);
var3 = result.lANKcCOG_all(end, :);
var4 = result.lANKcCOG_all(end, :);

point = horzcat(point, var1);
point = horzcat(point, var2);

point = horzcat(point, var3);
point = horzcat(point, var4);

point = horzcat(point,var1./var2);
point = horzcat(point,var3./var4);

point = horzcat(point,vecnorm(var1)/vecnorm(var2));
point = horzcat(point,vecnorm(var3)/vecnorm(var4));


   

point = [top point];

end