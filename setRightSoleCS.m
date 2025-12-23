function tmpRO = setRightSoleCS(trial, nFr)

%デフォルト引数を設定
arguments
    trial = [];
    nFr = 1;    
end

%つま先
[tmpRO(:, 1:4), ~, ~, ~] = setCoodM(trial.rP1(nFr, :), trial.rP15(nFr, :), trial.rP2(nFr, :));
%前足部
[tmpRO(:, 5:8), ~, ~, ~] = setCoodM(trial.rP14(nFr, :), trial.rP3(nFr, :), trial.rP13(nFr, :));
%中足部2
[tmpRO(:, 9:12), ~, ~, ~] = setCoodM(trial.rP4(nFr, :), trial.rP12(nFr, :), trial.rP5(nFr, :));
%後足部
[tmpRO(:, 13:16), ~, ~, ~] = setCoodM(trial.rP11(nFr, :), trial.rP6(nFr, :), trial.rP10(nFr, :));
%かかと部
[tmpRO(:, 17:20), ~, ~, ~] = setCoodM(trial.rP7(nFr, :), trial.rP9(nFr, :), trial.rP8(nFr, :));
% %かかと部2
% [tmpRO(:, 21:24), ~, ~, ~] = setCoodM(trial.rP11(nFr, :), trial.rP9(nFr, :), trial.rP10(nFr, :));

end