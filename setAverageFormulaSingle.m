function singleL = setAverageFormulaSingle(subject_list, action_list, shoes_list, rP, cP)
combi = allcomb([subject_list],action_list,shoes_list);
[rC,cC] = size(combi);
% [rP,cP] = size(rPntData);

range00 = cellName2(2,2,3)+":"+cellName2(rP,2,3);
range01 = cellName2(2,3,3)+":"+cellName2(rP,3,3);
range02 = cellName2(2,4,3)+":"+cellName2(rP,4,3);
tgt00 = cellName2(5+rP,2,1);

for i = 1:cP
    range11(i,:) = string(cellName2(1,4+i,2));
    range1(i,:) = cellName2(2,4+i,2)+":"+cellName2(rP,4+i,2);

end

for i = 1:rC
    range3(i,:) = string(cellName2(rP+3+i,2,1));
    range33(i,:) = string(cellName2(rP+rC+6+i,2,1));
    range4(i,:) = string(cellName2(rP+3+i,3,1));
    range44(i,:) = string(cellName2(rP+rC+6+i,3,1));
    range5(i,:) = string(cellName2(rP+3+i,4,1));
    range55(i,:) = string(cellName2(rP+rC+6+i,4,1));

end


%片足データの平均，標準偏差算出数式
% tmpcombi = allcomb("","ALL",action_list,shoes_list);
aveCal1 = [["AVERAGE" "Subject" "Action" "Shoes"];[repmat("",rC,1) combi]];
[all_len, ~] = size(combi(combi(:,1)=="ALL",:));
tmp1 = ["="+range11]';
tmp2 = "=averageifs("...
    +range1'+","...
    +repmat(range00,rC,length(range1))+","...
    +repmat(range3,1,length(range1))+","...
    +repmat(range01,rC,length(range1))+","...
    +repmat(range4,1,length(range1))+","...
    +repmat(range02,rC,length(range1))+","...
    +repmat(range5,1,length(range1))+")";

tmp3 = "=averageifs("...
    +range1'+","...
    +repmat(range01,rC,length(range1))+","...
    +repmat(range4,1,length(range1))+","...
    +repmat(range02,rC,length(range1))+","...
    +repmat(range5,1,length(range1))+")";

tmp2(end-all_len+1:end,:) = tmp3(end-all_len+1:end,:);

aveCal1 = [aveCal1 [tmp1;tmp2]];
aveCal1(2:end,1) = "";

sdCal1 = [["S.D." "Subject" "Action" "Shoes"];[repmat("",rC,1) combi]];
tmp1 = ["="+range11]';
tmp2 = "=stdev.p(if(("+repmat(range00,rC,length(range1))+"="+repmat(range33,1,length(range1))+")*("...
    +repmat(range01,rC,length(range1))+"="+repmat(range44,1,length(range1))+")*("...
    +repmat(range02,rC,length(range1))+"="+repmat(range55,1,length(range1))+")," + ...
    ""+repmat(range1',rC,1)+"))";
tmp3 = "=stdev.p(if(("...
    +repmat(range01,rC,length(range1))+"="+repmat(range44,1,length(range1))+")*("...
    +repmat(range02,rC,length(range1))+"="+repmat(range55,1,length(range1))+")," + ...
    ""+repmat(range1',rC,1)+"))";
tmp2(end-all_len+1:end,:) = tmp3(end-all_len+1:end,:);

sdCal1 = [sdCal1 [tmp1;tmp2]];
sdCal1(2:end,1) = "";

[r,c] = size(aveCal1);
singleL = [repmat("",2,c); aveCal1; repmat("",2,c); sdCal1];
