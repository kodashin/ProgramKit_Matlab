function trial = setTrialMarkerData(trial, all_marker,  svdMarks, replace_list, nFr_trial, arm, header, sole_angleCal, shoes_marker)
cnt1=0;
cnt2=0;
cnt3=0;
rSHOESmkr = [];
lSHOESmkr = [];
side = ["r", "l"];

for iRep = 1:length(shoes_marker)
    %マーカー名の入れ替え
    if  isempty(replace_list) == 0

        if sum(contains(replace_list(1,:),"r"+shoes_marker(iRep)))>0
            tmp = char(replace_list(2, contains(replace_list(1,:),"r"+shoes_marker(iRep))));
            shoes_marker(iRep) = string(tmp(2:end));

        end
    end
end

%trialデータを取得
for ii = 1:length(all_marker)
    mrk = all_marker(ii);
    mrk_char = char(mrk);

    %SVDmに使うマーカーと関節中心のマーカーをスキップ
    if contains(mrk, svdMarks) == 0

        try


            %マーカー名を変更する必要がある時は変更する
            %マーカー名の入れ替え
            if  isempty(replace_list) == 0
                if any(strcmp(mrk, replace_list(1,:)))
                    tmp = getMarkerData4(trial.data, trial.text, header, mrk, nFr_trial, arm);
                    mrk = replace_list(2, replace_list(1,:) == mrk);

                end
            else
                tmp = getMarkerData4(trial.data, trial.text, header, mrk, nFr_trial, arm);

            end
            trial.(mrk) = tmp;

            %ソール角度の計算をしないときはマーカー座標をすべて0にしたダミーデータを持たせる
            if sole_angleCal == 0
                if contains(mrk, ["r"+shoes_marker, "l"+shoes_marker]) == 1
                    cnt2 = cnt2+1;
                    % trial.(mrk) = zeros(nFr_trial, 3);
                    % disp("Shoes marker: "+mrk)
                    if mrk_char(1) == "r" %contains(mrk, "r")
                        rSHOESmkr = [rSHOESmkr [mrk+"_x" mrk+"_y" mrk+"_z" ;string(trial.(mrk))]];

                    elseif mrk_char(1) == "l"
                        lSHOESmkr = [lSHOESmkr [mrk+"_x" mrk+"_y" mrk+"_z" ;string(trial.(mrk))]];

                    end
                end

            elseif sole_angleCal == 1
                % disp("Shoes marker2: "+mrk)
                if mrk_char(1) == "r" %contains(mrk, "r")
                    rSHOESmkr = [rSHOESmkr [mrk+"_x" mrk+"_y" mrk+"_z" ;string(trial.(mrk))]];

                elseif mrk_char(1) == "l"
                    lSHOESmkr = [lSHOESmkr [mrk+"_x" mrk+"_y" mrk+"_z" ;string(trial.(mrk))]];

                end

            end



            trial.sdata(:, 1+3*(ii-1):3+3*(ii-1)) = [mrk+"_x" mrk+"_y" mrk+"_z" ;string(trial.(mrk))];


        catch exception
            msgText = getReport(exception,'extended','hyperlinks','off');
            disp("error occured in setting marker data: "+mrk)
            stop

        end
        %SVDmに使うマーカーと関節中心のマーカーにtmpをつける
    elseif contains(mrk, [ svdMarks]) == 1
        try

            trial.("tmp"+mrk) = getMarkerData4(trial.data, trial.text, header, mrk, nFr_trial, arm);
            trial.tmpsdata(:, 1+3*(ii-1):3+3*(ii-1)) = ["tmp"+mrk+"_x" "tmp"+mrk+"_y" "tmp"+mrk+"_z" ;string(trial.("tmp"+mrk))];

        catch
            disp("error occured: "+mrk)

        end
    end
end

trial.rSHOESmkr =rSHOESmkr;
trial.lSHOESmkr =lSHOESmkr;


end



% if sole_angleCal == 0 && contains(mrk, ["r"+shoes_marker, "l"+shoes_marker]) == 1
%                 cnt2 = cnt2+1;
%                 % trial.(mrk) = zeros(nFr_trial, 3);
%                 disp("Shoes marker: "+mrk)
%                 trial.rSHOESmkr(:, 1+3*(cnt2-1):3+3*(cnt2-1)) = [mrk+"_x" mrk+"_y" mrk+"_z" ;string(trial.(mrk))];
%                 trial.lSHOESmkr(:, 1+3*(cnt2-1):3+3*(cnt2-1)) = [mrk+"_x" mrk+"_y" mrk+"_z" ;string(trial.(mrk))];
%
%                 %ソール角度の計算をするときはマーカー座標を持たせる
%             elseif sole_angleCal == 1 && contains(mrk, ["r"+shoes_marker, "l"+shoes_marker]) == 1
%                 %right side
%                 if ismember(mrk, "r"+shoes_marker) > 0
%                     cnt1 = cnt1 + 1;
%                     trial.rSHOESmkr(:, 1+3*(cnt1-1):3+3*(cnt1-1)) = [mrk+"_x" mrk+"_y" mrk+"_z" ;string(trial.(mrk))];
%
%                     %left side
%                 elseif ismember(mrk, "l"+shoes_marker) > 0
%                     cnt3= cnt3 + 1;
%                     trial.lSHOESmkr(:, 1+3*(cnt3-1):3+3*(cnt3-1)) = [mrk+"_x" mrk+"_y" mrk+"_z" ;string(trial.(mrk))];
%
%                 end
%             end