function nude = calNudeData(nude_list, subs, data_dir, marker, marker_sdata, replace_list, header, nFr_stand)

ext = ".csv";
for i= 1:length(subs)
    sub = subs(i);
    nude_file =nude_list(nude_list(:,2)==subs(i), 1);
    
    for iRep = 1:length(nude_file)        

        disp("Nude trial: "+ nude_file(iRep))
        disp("Subject: "+sub)

        arm = "R";
        [data, text, raw] = xlsread(data_dir+"\"+sub+"\"+string(nude_file(iRep))+ext);%xlsread(data_dir+string(nude_files(i, 1))+ext);%
        
        for ii = 1:length(marker)

            mrk = marker(ii);

            if contains(mrk, marker_sdata)==1
                %マーカー名入れ替え
                if  isempty(replace_list) == 0 && any(strcmp(mrk, replace_list(1,:)))
                        mrk = replace_list(2, replace_list(1,:) == mrk);
                        nude.(sub).(nude_file(iRep)).(mrk) = mean(getMarkerData_stand(data, text, header, marker(ii), nFr_stand, arm));                   
                    
                else

                    nude.(sub).(nude_file(iRep)).(mrk) = mean(getMarkerData_stand(data, text, header, mrk, nFr_stand, arm));
                
                end
               
            elseif contains(mrk, marker_sdata)==0
                nude.(sub).(nude_file(iRep)).(mrk) = zeros(1,3);
                nude.(sub).(nude_file(iRep)).sdata(:, 1+3*(ii-1):3+3*(ii-1)) = [mrk+"_x" mrk+"_y" mrk+"_z" ;string(nude.(sub).(nude_file(iRep)).mrk)];

            end
        end

    end
    disp("----------------------------------------------")
end




end