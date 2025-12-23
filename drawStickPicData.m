function drawStickPicData(allall, n, ik, Line, LineWidth, Color, Sub, arrow_scale)

markD = allall.("pelP"+n);
plot3(markD(ik,  1:3:end),  markD(ik,  2:3:end),  markD(ik,  3:3:end),  Line,  "LineWidth",  LineWidth,  "Color",  Color ,'DisplayName', Sub)
hold on

%骨盤中心
scatter3(allall.("PELc"+n)(ik,  1),  allall.("PELc"+n)(ik,  2),  allall.("PELc"+n)(ik,  3),  "ko")
hold on
grid on

%骨盤中心速度ベクトル
quiver3(allall.("PELc"+n)(ik,  1),  allall.("PELc"+n)(ik,  2),  allall.("PELc"+n)(ik,  3),allall.("PELc"+n)(ik,  4),  allall.("PELc"+n)(ik,  5),  allall.("PELc"+n)(ik,  6), arrow_scale*250, Line,  "Color", "k", "LineWidth", 2.5, "ShowArrowHead","on")

try
scatter(allall.("rCOP"+n)(ik,  1),  allall.("rCOP"+n)(ik,  2),  25,  'MarkerFaceColor',  Color)
hold on
quiver3(allall.("rCOP"+n)(ik,  1),  allall.("rCOP"+n)(ik,  2), allall.("rCOP"+n)(ik,  3), allall.("rGRF"+n)(ik,  1),  allall.("rGRF"+n)(ik,  2), allall.("rGRF"+n)(ik,  3), arrow_scale, Line,  "Color",  Color)
hold on
markD = allall.("rlegP"+n);
plot3(markD(ik,  1:3:end),  markD(ik,  2:3:end),  markD(ik,  3:3:end),  Line,  "LineWidth",  LineWidth,  "Color",  Color)
hold on
markD = allall.("rfootP"+n);
plot3(markD(ik,  1:3:end),  markD(ik,  2:3:end),  markD(ik,  3:3:end),  Line,  "LineWidth",  LineWidth,  "Color",  Color)
hold on

catch
disp("R data skipped")
end

try
scatter(allall.("lCOP"+n)(ik,  1),  allall.("lCOP"+n)(ik,  2),  25,  'MarkerFaceColor',  Color)
hold on
quiver3(allall.("lCOP"+n)(ik,  1),  allall.("lCOP"+n)(ik,  2), allall.("lCOP"+n)(ik,  3), allall.("lGRF"+n)(ik,  1),  allall.("lGRF"+n)(ik,  2), allall.("lGRF"+n)(ik,  3), arrow_scale, Line,  "Color",  Color)
hold on
markD = allall.("llegP"+n);
plot3(markD(ik,  1:3:end),  markD(ik,  2:3:end),  markD(ik,  3:3:end),  Line,  "LineWidth",  LineWidth,  "Color",  Color)
hold on
markD = allall.("lfootP"+n);
plot3(markD(ik,  1:3:end),  markD(ik,  2:3:end),  markD(ik,  3:3:end),  Line,  "LineWidth",  LineWidth,  "Color",  Color,'DisplayName', Sub)
hold on

catch
disp("L data skipped")
end


