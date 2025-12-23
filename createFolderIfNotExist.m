function createFolderIfNotExist(relativePath)
    % 相対パスを絶対パスに変換
    fullPath = fullfile(pwd, relativePath);
    
    % フォルダが存在するかチェック
    if ~exist(fullPath, 'dir')
        % フォルダが存在しない場合は作成
        mkdir(fullPath);
        fprintf('フォルダ "%s" を作成しました。\n', fullPath);
    else
        % フォルダが存在する場合は何もしない
        fprintf('フォルダ "%s" は既に存在します。\n', fullPath);
    end
end