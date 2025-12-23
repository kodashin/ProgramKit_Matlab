function doubleL = setAverageFormulaDouble(subject_list, action_list, shoes_list, rPP, cPP)
combi = allcomb([subject_list],action_list,shoes_list);
[rC,cC] = size(combi);
% range00 = cellName(2,2)+":"+cellName(rPP,2);
% range01 = cellName(2,3)+":"+cellName(rPP,3);
% range02 = cellName(2,4)+":"+cellName(rPP,4);
range00 = cellName2(2,2,3)+":"+cellName2(rPP,2,3);
range01 = cellName2(2,3,3)+":"+cellName2(rPP,3,3);
range02 = cellName2(2,4,3)+":"+cellName2(rPP,4,3);
% tgt00 = cellName(5+rPP,2);

for i = 1:cPP
    range11(i,:) = string(cellName2(1,4+i,2));
    range1(i,:) = cellName2(2,4+i,2)+":"+cellName2(rPP,4+i,2);

end

for i = 1:rC
    range3(i,:) = string(cellName2(rPP+3+i,2,1));
    range33(i,:) = string(cellName2(rPP+rC+6+i,2,1));
    range4(i,:) = string(cellName2(rPP+3+i,3,1));
    range44(i,:) = string(cellName2(rPP+rC+6+i,3,1));
    range5(i,:) = string(cellName2(rPP+3+i,4,1));
    range55(i,:) = string(cellName2(rPP+rC+6+i,4,1));

end

for i = 1:cPP
    range22(i,:) = string(cellName2(1,4+i,2));
    range2(i,:) = cellName2(2,4+i,2)+":"+cellName2(rPP,4+i,2);

end

%両足データの平均，標準偏差算出数式
aveCal2 = [["AVERAGE" "Subject" "Action" "Shoes"];[repmat("",rC,1) combi]];
[all_len, ~] = size(combi(combi(:,1)=="ALL",:));
tmp1 = ["="+range22]';
tmp2 = "=averageifs("+range2'+","...
    +repmat(range00,rC,length(range2))+","...
    +repmat(range3,1,length(range2))+","...
    +repmat(range01,rC,length(range2))+","...
    +repmat(range4,1,length(range2))+","...
    +repmat(range02,rC,length(range2))+","...
    +repmat(range5,1,length(range2))+")";

tmp3 = "=averageifs("+range2'+","...
    +repmat(range01,rC,length(range2))+","...
    +repmat(range4,1,length(range2))+","...
    +repmat(range02,rC,length(range2))+","...
    +repmat(range5,1,length(range2))+")";
tmp2(end-all_len+1:end,:) = tmp3(end-all_len+1:end,:);

aveCal2 = [aveCal2 [tmp1;tmp2]];
aveCal2(2:end,1) = "";

sdCal2 = [["S.D." "Subject" "Action" "Shoes"];[repmat("",rC,1) combi]];
tmp1 = ["="+range22]';
tmp2 = "=stdev.p(if(("+repmat(range00,rC,length(range2))+"="+repmat(range33,1,length(range2))+")*("...
    +repmat(range01,rC,length(range2))+"="+repmat(range44,1,length(range2))+")*("...
    +repmat(range02,rC,length(range2))+"="+repmat(range55,1,length(range2))+"),"+repmat(range2',rC,1)+"))";
tmp3 = "=stdev.p(if(("...
    +repmat(range01,rC,length(range2))+"="+repmat(range44,1,length(range2))+")*("...
    +repmat(range02,rC,length(range2))+"="+repmat(range55,1,length(range2))+"),"+repmat(range2',rC,1)+"))";

tmp2(end-all_len+1:end,:) = tmp3(end-all_len+1:end,:);
sdCal2 = [sdCal2 [tmp1;tmp2]];
sdCal2(2:end,1) = "";

[r,c] = size(aveCal2);
doubleL =  [repmat("",2,c); aveCal2; repmat("",2,c); sdCal2];
