function result_all = setNormDataRL(result,head)
result_all = [];
result_field = fields(result);
[rr_result,~] = size(result_field);
cnt=0;
FR1000 = 1/1000;
try
    duration = result.rContact(11):result.rContact(end-10);
catch
    try
    duration = result.lContact(11):result.lContact(end-10);
    
    catch
       duration = result.WholeContactPhase; 
    end
end

for ii =1:rr_result
    if length(result.(string(result_field(ii))))>3
        try
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
        
        data_label = [repmat([head;string(result_field(ii))],1,cc_data);compo;repmat(time,1,cc_data)];%データ方向↓時間，→データ種
        result_all = horzcat(result_all,[data_label;NormalTime2(result.(string(result_field(ii)))(:,:),FR1000,200)]);

        catch
            disp("Skipped normalising: "+result_field(ii))

        end
        
    end
end



end