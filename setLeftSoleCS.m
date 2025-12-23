function tmpRO = setLeftSoleCS(trial,nFr)

%デフォルト引数を設定
arguments
    trial = [];
    nFr = 1;    
end

%つま先
[tmpRO(:, 1:4), ~, ~, ~] = setCoodM(trial.lP1(nFr, :), trial.lP15(nFr, :), trial.lP2(nFr, :));
%前足部
[tmpRO(:, 5:8), ~, ~, ~] = setCoodM(trial.lP14(nFr, :), trial.lP3(nFr, :), trial.lP13(nFr, :));
%中足部2
[tmpRO(:, 9:12), ~, ~, ~] = setCoodM(trial.lP4(nFr, :), trial.lP12(nFr, :), trial.lP5(nFr, :));
%後足部
[tmpRO(:, 13:16), ~, ~, ~] = setCoodM(trial.lP11(nFr, :), trial.lP6(nFr, :), trial.lP10(nFr, :));
%かかと部
[tmpRO(:, 17:20), ~, ~, ~] = setCoodM(trial.lP7(nFr, :), trial.lP9(nFr, :), trial.lP8(nFr, :));
% %かかと部2
% [tmpRO(:, 21:24), ~, ~, ~] = setCoodM(trial.rP11(nFr, :), trial.rP9(nFr, :), trial.rP10(nFr, :));

end


