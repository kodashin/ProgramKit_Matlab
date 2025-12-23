%% lever arm
function LA_A = getLeverArm(F_g, CP_g, AJC, time)

hc_time = time(1);
to_time = time(end);

a = length(F_g(hc_time:to_time, 1));
F_g2 = F_g(hc_time:to_time, :);
CoP = CP_g(hc_time:to_time, :);
AJC = AJC(hc_time:to_time, :);

GRF_l = zeros(a, 1);
GRF_e = zeros(a, 3);
for t  =  1:a
    GRF_l(t, 1) = sqrt(F_g2(t, 1)^2 + F_g2(t, 2)^2 + F_g2(t, 3)^2);
    GRF_e(t, 1) = F_g2(t, 1) / GRF_l(t, 1);
    GRF_e(t, 2) = F_g2(t, 2) / GRF_l(t, 1);
    GRF_e(t, 3) = F_g2(t, 3) / GRF_l(t, 1);
end
clear t GRF_l

%%
% Scalar projection
CoPA(:, 1) = AJC(:, 1) - CoP(:, 1);
CoPA(:, 2) = AJC(:, 2) - CoP(:, 2);
CoPA(:, 3) = AJC(:, 3) - CoP(:, 3);


for t  =  1:a
    SP = dot(CoPA(t, 2:3), GRF_e(t, 2:3));
    LA_A(t, 1:2) = (SP*GRF_e(t, 2:3) - CoPA(t, 2:3));
    LA_A(t, 3) = sqrt(LA_A(t, 1)^2 + LA_A(t, 2)^2);
    if LA_A(t, 1)>0
        LA_A(t, 3) = LA_A(t, 3)*-1;
    end
    
    clear SP
end

LA_A(isnan(LA_A)) = 0;
end

% figure(1110011)
% plot(LA_A(:, 3))
% hold on
% nLA_A=norm_data(LA_A(:, 3), 1, length(LA_A(:, 3)));
% figure(1110012)
% plot(nLA_A)
% hold on