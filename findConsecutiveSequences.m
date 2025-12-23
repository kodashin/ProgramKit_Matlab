function sequences = findConsecutiveSequences(arr)
    % 配列を昇順にソート
    arr = sort(arr);

    sequences = {};  % 結果を格納するセル配列
    seqStart = 1;   % 現在の数列の開始位置

    % 配列の要素を順番にチェック
    for i = 2:length(arr)
        % 連続していない数値を見つけた場合
        if arr(i) - arr(i-1) > 1
            % これまでの連続する数列を保存
            sequences{end+1} = arr(seqStart:i-1);
            seqStart = i;  % 新しい数列の開始位置を更新
        end
    end

    % 最後の数列を保存
    sequences{end+1} = arr(seqStart:end);

    % 要素が1つの数列を除外したい場合は以下のコードを追加
    sequences = sequences(cellfun(@length, sequences) > 5);
end