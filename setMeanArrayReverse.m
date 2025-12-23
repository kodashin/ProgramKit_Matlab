function mean_array = setMeanArrayReverse(result_sorted, file_head)
    FR1000 = 1/1000;

    % 項目ごとに平均時系列データを算出
    [a, ia, ic] = unique(result_sorted(2:6, :)', "rows");

    % 時間軸の合わせ方 0:接地合わせ，1:離地合わせ
    t = 1;

    num = length(ia);
    [r, c] = size(result_sorted);

    % 事前メモリ割り当て
    tmp_array = strings(r, num);

    % 平均時系列データの計算（ベクトル化）
    for iCol = 1:num
        tgt_col = ia(iCol):ia(iCol)+3;
        label = string(unique(result_sorted(2:6, tgt_col), "stable"));
        target_array = str2double(result_sorted(7:end, tgt_col));

        tmpAve = mean(target_array, 2, "omitnan");
        tmp_array(:, iCol) = [label; string(round(tmpAve(1), 4)); string(tmpAve(2:end))];
    end

    % 複数の被験者がいる場合の処理
    if length(unique(a(:, 1))) > 1
        [aa, ~, iicc] = unique(result_sorted(3:6, :)', "rows");
        numnum = length(unique(iicc));

        tmp_array2 = strings(r-1, numnum);
        for iiCol = 1:numnum
            mask = iicc == iiCol;
            label = string(unique(result_sorted(3:6, mask), "stable"));
            target_array = str2double(result_sorted(7:end, mask));

            tmpAve = mean(target_array, 2, "omitnan");
            tmp_array2(:, iiCol) = ["ALL"; label; string(round(tmpAve(1), 4)); string(tmpAve(2:end))];
        end

        pre_array = sortrows([tmp_array tmp_array2]', [5, 4], {'ascend'})';
    else
        pre_array = tmp_array;
    end

    % 時間配列を作成して結合
    head_list = unique(pre_array([1:3, 6], :)', "row", "stable")';
    subs = unique(head_list(1, :), "stable");
    actions = unique(head_list(2, :), "stable");
    shoes = unique(head_list(3, :), "stable");

    % 構造体の事前構築
    tgtCtime = struct();
    for i = 1:length(subs)
        for ii = 1:length(actions)
            mask = head_list(1, :) == subs(i) & head_list(2, :) == actions(ii);
            if any(mask)
                tgtCtime.(subs(i)).(actions(ii)) = max(str2double(head_list(4, mask)));
            end
        end
    end

    % ベクトル化された時間配列生成
    tmp_bar_cell = {};
    tmp_head_cell = {};

    for ii = 1:length(subs)
        for iiii = 1:length(actions)
            mask = head_list(1, :) == subs(ii) & head_list(2, :) == actions(iiii);
            if ~any(mask)
                continue;
            end

            time = str2double(head_list(4, mask));
            shoesshoes = head_list(3, mask);

            for iii = 1:length(shoesshoes)
                if t == 0
                    arr = linspace(-tgtCtime.(subs(ii)).(actions(iiii)), ...
                                   -(tgtCtime.(subs(ii)).(actions(iiii)) - time(iii)), 201);
                elseif t == 1
                    arr = linspace(0, time(iii), 201);
                    arr = -flip(arr);
                end

                tmp_bar_cell{end+1} = arr';

                mask_head = head_list(1, :) == subs(ii) & ...
                           head_list(3, :) == shoesshoes(iii) & ...
                           head_list(2, :) == actions(iiii);
                tmp_head_cell{end+1} = [unique(head_list(1:3, mask_head), "stable"); "ContactTime"; ""; ""];
            end
        end
    end

    % セル配列を結合
    if ~isempty(tmp_bar_cell)
        tmp_bar = horzcat(tmp_bar_cell{:});
        tmp_head = horzcat(tmp_head_cell{:});
        time_head = unique([tmp_head; tmp_bar]', "rows")';
    else
        time_head = [];
    end

    mean_array = horzcat(time_head, pre_array);
end

% function mean_array = setMeanArrayReverse(result_sorted, file_head)
% FR1000 = 1/1000;
% % offset = [0.2 0.3 0.4];
% 
% %項目ごとに平均時系列データを算出
% tmp = result_sorted(2:6, :)';
% [a,  ia,  ic] = unique(result_sorted(2:6, :)', "rows");
% 
% %時間軸の合わせ方 0:接地合わせ，1:離地合わせ
% t = 1;
% 
% num = length(unique(ic));
% [r, c] = size(result_sorted);
% tmp_array = repmat("", r-1, num);
% 
% %平均時系列データの計算
% for iCol = 1:num
%     clear target_array
%     tgt_col = ia(iCol):ia(iCol)+3;
%     % tgt_col = find(ic == ia(iCol));
%     label = string(unique(result_sorted(2:6, tgt_col), "stable"));%ic==iCol
%     target_array = result_sorted(7:end, tgt_col);%ic==iCol    
%     tmpAve = mean(str2double(target_array), 2, "omitnan");
%     tmp_array(:, iCol) = [label;round(tmpAve(1), 4);string(tmpAve(2:end))];
% 
% end
% 
% 
% 
% if length(unique(a(:, 1)))>1
%     [aa, ~, iicc] = unique(result_sorted(3:6, :)', "rows");
%     numnum = length(unique(iicc));
% 
%     tmp_array2 = repmat("", r-1, numnum);
%     for iiCol = 1:numnum
%         clear target_array
%         label = string(unique(result_sorted([3:6], iicc==iiCol), "stable"));
%         target_array = result_sorted(7:end, iicc==iiCol);
%         tmpAve = mean(str2double(target_array), 2);
%         tmp_array2(:, iiCol) = ["ALL";label;round(tmpAve(1), 4);string(tmpAve(2:end))];
% 
%     end
% 
%     pre_array = sortrows([tmp_array tmp_array2]', [5, 4], {'ascend'})';
% 
% else
%     pre_array = tmp_array;
% 
% end
% 
% %時間配列を作成して結合
% head_list = unique(pre_array([1:3, 6], :)', "row")';
% subs = unique(head_list(1, :));
% shoes = unique(head_list(3, :));
% actions = unique(head_list(2, :));
% 
% for i = 1:length(subs)
%     for ii = 1:length(actions)
%     tgtCtime.(subs(i)).(actions(ii)) = max(str2double(head_list(4, head_list(1, :)==subs(i) & head_list(2, :)==actions(ii))));
%     end
% end
% 
% % [rr, cc] = size(head_list);
% % % tgtCtime = max(str2double(head_list(4, :)));
% 
% tmp_bar = [];
% tmp_head = [];
% for ii = 1:length(subs)
%     for iiii = 1:length(actions)
%         time = str2double(head_list(4, head_list(1, :)==subs(ii) & head_list(2, :)==actions(iiii)));
%         shoesshoes = head_list(3,  head_list(1,  :)==subs(ii) & head_list(2, :)==actions(iiii));
% 
%         for iii = 1:length(shoesshoes)
% 
%             if t == 0
%                 arr = linspace(-tgtCtime.(subs(ii)).(actions(iiii)),  -(tgtCtime.(subs(ii)).(actions(iiii))-time(iii)),  201);
%                 tmp_bar = [tmp_bar arr'];%[-time:time/200:0]-ContactTime.(head_list(3, ii));
% 
%             elseif t == 1
%                 arr = linspace(0,  time(iii),  201);
%                 tmp_bar = [tmp_bar flip(-arr)'];%[-time:time/200:0]-ContactTime.(head_list(3, ii));
% 
%             end
%             tmp_head = [tmp_head [unique(head_list(1:3,  head_list(1, :) == subs(ii) & head_list(3, :) == shoesshoes(iii)& head_list(2, :) == actions(iiii)), "stable");"ContactTime";"";""]];
% 
%         end
%         %         disp("rep: "+string(ii*iii))
%     end
% end
% 
% time_head = unique([tmp_head;tmp_bar]',  "rows")';
% mean_array = horzcat(time_head, pre_array);
% 
% 
% % save(file_head+"_MeanArray.mat", "mean_array")
% 
% end