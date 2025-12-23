function nude = setNudeMakerData(nude, body_marker, joint_marker, replace_list, header, arm)
nFr_nude = find(strcmp(nude.text(:, 1), "Trajectories"), 1)-7;
for ii = 1:length(body_marker)
    mrk = body_marker(ii);

    % % if contains(mrk, joint_marker) == 0
    %     try

            if isempty(replace_list) == 0
                if any(strcmp(mrk, replace_list(1,:)))
                    mrk = replace_list(2, replace_list(1,:) == mrk);
                    nude.(mrk) = mean(getMarkerData4(nude.data, nude.text, header, body_marker(ii), nFr_nude, arm));

                end

            else
                nude.(mrk) = mean(getMarkerData4(nude.data, nude.text, header, mrk, nFr_nude, arm));

            end              


        % catch
        %     disp("Trial marker data missing(Nude Data): "+mrk)
        % end

    % elseif contains(mrk, joint_marker) == 1
    %     try
    %         nude.("tmp"+mrk) = mean(getMarkerData4(nude.data, nude.text, header, mrk, nFr_nude, arm));
    % 
    %     catch
    %         disp("Trial marker data missing(Nude Data): tmp"+mrk)
    %     end
    % 
    % end
end

