function scalar_proj = calLeverArm_ScalarProjection(a, b)
% SCALAR_PROJECTION ベクトルaのベクトルb上へのスカラー射影を計算
%
% 入力:
%   a - 射影されるベクトル (行ベクトルまたは列ベクトル)
%   b - 射影先のベクトル (行ベクトルまたは列ベクトル)
%
% 出力:
%   scalar_proj - スカラー射影の値
%
% 公式: scalar_proj = (a・b) / |b|

    % 入力チェック
    if length(a) ~= length(b)
        error('ベクトルaとbの次元が一致しません');
    end

    % ベクトルを列ベクトルに統一
    a = a(:);
    b = b(:);

    % ベクトルbがゼロベクトルでないかチェック
    if norm(b) == 0
        error('ベクトルbはゼロベクトルです。射影を計算できません。');
    end

    % スカラー射影を計算
    scalar_proj = dot(a, b) / norm(b);
