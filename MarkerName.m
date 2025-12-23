function [header, marker_name] = MarkerName(test_file)

sheet_names = sheetnames(test_file);
flag = any(ismember(sheet_names, "marker"));

if flag == 1
    data = readcell(test_file, "Sheet","marker");
    header = string(data(1));
    marker_name = string(data(2:end));

    return
else

    [file, path] = uigetfile("", "Select Stand File to pick up Marker List");

    data = readlines(path+"/"+file);

    tgt_row = find(data=="Trajectories")+2;
    name_list_whole = strsplit(replace(data(tgt_row), ",,", ""), ",");

    for i = 1:length(name_list_whole)
        name_list(i, :) = strsplit(name_list_whole(i), ":");

    end
    header = unique(name_list(:,1));
    header = header(ismember(header, "") == 0)+":";
    marker_name = name_list(:,2);

    writematrix([header;marker_name], test_file, "Sheet", "marker",  "Range", "A1:"+cellName2(length(marker_name)+1, 1, 0) );
end
