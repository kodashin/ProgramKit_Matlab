function writeRes2Sheet(filename,  PntData,  MeanArray,  Result_sorted,  formula, indi_data)

%被験者全体データの書き込み
%         writematrix(Result_sorted, filename, 'Sheet', 'All', 'WriteMode', 'inplace', 'UseExcel', 1, 'PreserveFormat', 1)

pos = strfind(filename,  ".");
str = char("_ALL");
fnameSEparated = insertAfter(filename,  pos(3)-1,  str);
writematrix(MeanArray, fnameSEparated, 'Sheet', 'Mean', 'WriteMode', 'inplace', 'UseExcel', 1, 'PreserveFormat', 1)
writematrix(PntData,fnameSEparated, 'Sheet', 'Pnt', 'WriteMode', 'inplace', 'UseExcel', 1, 'PreserveFormat', 1)
writematrix(formula, fnameSEparated, 'Sheet', 'Pnt', 'WriteMode', 'append', 'UseExcel', 1, 'PreserveFormat', 1)

subjects = unique(Result_sorted(2, :));
shoes = unique(Result_sorted(4, :));

fclose all;


if indi_data == 1
    %被験者個別データの書き込み
    for i = 1:length(subjects)
        tmp = formula(formula(:, 2)==subjects(i), :);
        % ff = horzcat(["Average";repmat("", length(shoes)-1, 1);"S.D.";repmat("", length(shoes)-1, 1)],  tmp(:, 2:end));

        [r, c] = size(tmp);
        tmp(1, 1) = "Average";
        tmp((r/2)+1, 1) = "S.D.";
        ff = tmp;
        
        [~,  nVar] = size(ff);
        blank = repmat("",  2,  nVar);
        formulaSeparated = vertcat(blank,  ff);

        tmp = MeanArray(:, MeanArray(1, :) == subjects(i));
        MeanSeparated = tmp;

        pos = strfind(filename,  ".");
        str = char("_"+subjects(i));
        fnameSEparated = insertAfter(filename,  pos(3)-1,  str);

        tmp = PntData(PntData(:, 2) == subjects(i), :);
        PntSeparated = [PntData(1, :);tmp];

        tmp = Result_sorted(:, Result_sorted(2, :) == subjects(i));
        ResSeparated = tmp;

        writematrix(ResSeparated, fnameSEparated, 'Sheet', 'All', 'WriteMode', 'inplace', 'UseExcel', 1, 'PreserveFormat', 1)
        writematrix(MeanSeparated, fnameSEparated, 'Sheet', 'Mean', 'WriteMode', 'inplace', 'UseExcel', 1, 'PreserveFormat', 1)
        writematrix(PntSeparated, fnameSEparated, 'Sheet', 'Pnt', 'WriteMode', 'inplace', 'UseExcel', 1, 'PreserveFormat', 1)
        writematrix(formulaSeparated, fnameSEparated, 'Sheet', 'Pnt', 'WriteMode', 'append', 'UseExcel', 1, 'PreserveFormat', 1)

        fclose all;


    end

end
end