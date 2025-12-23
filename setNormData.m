function result_all = setNormData(result,head)
result_all = [];
result_field = fields(result);
[rr_result,~] = size(result_field);
cnt=0;
FR1000 = 1/1000;
try
    duration = result.Contact(1)+result.extra:result.Contact(end)-result.extra;
catch
    try
        duration = result.lContact(1)+result.extra:result.lContact(end)-result.extra;
    
    catch
       duration = result.WholeContactPhase(1)+result.extra:result.WholeContactPhase(end)-result.extra; 
    end
end

for ii =1:rr_result
    if length(result.(string(result_field(ii))))>3

        [~,cc_data] = size(result.(string(result_field(ii))));
        cnt = cnt +cc_data;
        if cc_data == 3
            compo = ["X" "Y" "Z"];

        else
            compo = "o";

        end

        time = length(duration)*FR1000;
        %         if extractBefore(string(result_field(ii)),2) == "r"
        %             time = length(duration)*FR1000;
        %
        %         elseif extractBefore(string(result_field(ii)),2) == "l"
        %             time = length(lduration)*FR1000;
        %
        %         end
        try
            data_label = [repmat([head;string(result_field(ii))],1,cc_data);compo;repmat(time,1,cc_data)];
            result_all = horzcat(result_all,[data_label;NormalTime2(result.(string(result_field(ii)))(result.extra+1:end-(result.extra+1),:),FR1000,200)]);

        catch
            disp("Error occured: "+result_field(ii))
        end
    end



end