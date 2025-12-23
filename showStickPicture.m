function showStickPicture(FP, posiFP, rCS, lCS, trial, arm, Frm)

tgt = trial;

marker_plot = ["o", "+", "*", "square", "diamond"];

rCOP = FP.COP(2).data;
rGRF = FP.GRF(2).data;
lCOP = FP.COP(1).data;
lGRF = FP.GRF(1).data;
valP = str2double(tgt .sdata(2:end, :));
headP = tgt.sdata(1, :);

[rFP, cFP] = size(posiFP);

valP2 = valP(:, startsWith(headP, "r"));
valP3 = valP(:, startsWith(headP, "l"));
valP4 = valP(:, startsWith(headP, "rANKm"));
valP5 = valP(:, startsWith(headP, "lANKm"));
valP6 = valP(:, startsWith(headP, "rANKl"));
valP7 = valP(:, startsWith(headP, "lANKl"));
valP8 = valP(:, startsWith(headP, "rBALm"));
valP9 = valP(:, startsWith(headP, "lBALm"));
valP10 = valP(:, startsWith(headP, "rHEELl"));
valP11 = valP(:, startsWith(headP, "lHEELl"));
valP12 = valP(:, startsWith(headP, "rHEELm"));
valP13 = valP(:, startsWith(headP, "lHEELm"));
valP14 = valP(:, startsWith(headP, "rBALl"));
valP15 = valP(:, startsWith(headP, "lBALl"));
try
    BODY_CG = trial.BODY_CG;

catch

end

arrow_len = 0.2;
figure();

%side:R
ColorA = "c";
%side:L
ColorB = "m";

for ik = Frm

    if arm == "L"
        %FP4
        rectangle('Position', [-0.6 0 posiFP(1, 3:4)])
        hold on
        %FP2
        rectangle('Position', [-0.6 -0.9 posiFP(2, 3:4)])
        hold on

        %Global座標系
        quiver3(-0.6, 0, 0, 1, 0, 0, "r")
        hold on
        quiver3(-0.6, 0, 0, 0, 1, 0, "g")
        hold on
        quiver3(-0.6, 0, 0, 0, 0, 1, "b")
        hold on

        %FP座標系原点:FP1
        plot3(-posiFP(1, 1), posiFP(1, 2), 0, "+k")
        hold on
        %FP座標系原点:FP2
        plot3(-posiFP(2, 1), posiFP(2, 2), 0, "*k")
        hold on

    elseif arm == "R"
        for iFP = 1:rFP
            %FP4
            rectangle('Position', [posiFP(iFP, 1)-posiFP(iFP, 3)/2 posiFP(iFP, 2)-posiFP(iFP, 4)/2  posiFP(iFP, 3:4)])
            hold on

            %FP座標系原点:FP1
            plot3(posiFP(iFP, 1), posiFP(iFP, 2), 0, marker_plot(iFP)+"k")
            hold on


        end
        %Global座標系
        quiver3(0, 0, 0, 1, 0, 0, "r")
        hold on
        quiver3(0, 0, 0, 0, 1, 0, "g")
        hold on
        quiver3(0, 0, 0, 0, 0, 1, "b")
        hold on



    end

    try
        scatter3(BODY_CG(ik, 1), BODY_CG(ik, 2), BODY_CG(ik, 3), "rx")

    catch

    end

    scatter(rCOP(ik, 1), rCOP(ik, 2), 25, 'MarkerFaceColor', ColorA)
    hold on
    quiver3(rCOP(ik, 1), rCOP(ik, 2),rCOP(ik, 3),rGRF(ik, 1), rGRF(ik, 2),rGRF(ik, 3),arrow_len,"-", "Color", ColorA)
    hold on
    scatter(lCOP(ik, 1), lCOP(ik, 2), 25, 'MarkerFaceColor', ColorB)
    hold on
    quiver3(lCOP(ik, 1), lCOP(ik, 2),lCOP(ik, 3),lGRF(ik, 1), lGRF(ik, 2),lGRF(ik, 3),arrow_len,"-", "Color", ColorB)
    hold on


    %         disp(string(round(cnt/(length(duration)+40)*100, 0))+"%")
    axis([-1 1 -2 2 0 2])
    set(gca, 'DataAspectRatio', [1 1 1])
    grid on


    %side:R
    val = valP2;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'o', 'MarkerEdgeColor', ColorA)
    hold on
    %side:L
    val = valP3;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'o', 'MarkerEdgeColor', ColorB)
    hold on


    val = valP4;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'k+')
    hold on
    val = valP5;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'g*')
    hold on
    val = valP6;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'b*')
    hold on
    val = valP7;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'b*')
    hold on
    val = valP8;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'r*')
    hold on
    val = valP9;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'r*')
    hold on
    val = valP10;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'g+')
    hold on
    val = valP11;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'g+')
    hold on
    val = valP12;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'kx')
    hold on
    val = valP13;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'ko')
    hold on
    val = valP14;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'ks')
    hold on
    val = valP15;
    scatter3(val(ik, 1:3:end), val(ik, 2:3:end), val(ik, 3:3:end), 50, 'ks')
    hold on

    grid on
    scatter(rCOP(ik, 1), rCOP(ik, 2), 25, 'r*')
    hold on
    scatter(lCOP(ik, 1), lCOP(ik, 2), 25, 'r+')
    hold on

    try
        side = "r";
        CS = rCS;
        seg = side+"ANKjoint";
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
        hold on

    catch
        side = "l";
        CS = rCS;
        seg = side+"ANKjoint";
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
        hold on

    end
    % seg = side+"SHANK";
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
    % hold on
    % seg = side+"THIGH";
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
    % hold on
    % seg = side+"ANKjoint";
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
    % hold on
    % seg = side+"KNEEjoint";
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
    % hold on
    % seg = side+"HIPjoint";
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
    % hold on


    try
        side = "l";
        CS = lCS;
        seg = side+"ANKjoint";
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
        hold on

    catch
        side = "r";
        CS = lCS;
        seg = side+"ANKjoint";
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
        quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
        hold on

    end
    % seg = side+"SHANK";
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
    % hold on
    % seg = side+"THIGH";
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
    % hold on
    % seg = side+"ANKjoint";
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
    % hold on
    % seg = side+"KNEEjoint";
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
    % hold on
    % seg = side+"HIPjoint";
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 2+4*(ik-1)), CS.(seg)(3, 2+4*(ik-1)), CS.(seg)(4, 2+4*(ik-1)), arrow_len, "r")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 3+4*(ik-1)), CS.(seg)(3, 3+4*(ik-1)), CS.(seg)(4, 3+4*(ik-1)), arrow_len, "g")
    % quiver3(CS.(seg)(2, 1+4*(ik-1)), CS.(seg)(3, 1+4*(ik-1)), CS.(seg)(4, 1+4*(ik-1)), CS.(seg)(2, 4+4*(ik-1)), CS.(seg)(3, 4+4*(ik-1)), CS.(seg)(4, 4+4*(ik-1)), arrow_len, "b")
    % hold on

end



end