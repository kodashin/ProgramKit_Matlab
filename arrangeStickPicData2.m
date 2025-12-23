function dd=arrangeStickPicData2(tgtM , SubA , ShoesA , others , plotD , action,  reverse)

%TrialAをその他に合わせこむ
[r1 , c1] = size(others);

pelM = ["lASIS" , "lTRO" , "lPSIS" , "rPSIS" , "rTRO" , "rASIS" , "lASIS" , "rPSIS" , "rASIS" , "lPSIS" , "lASIS"];
legM = ["HIPc" , "KNEEc" , "ANKc"];
footM = ["HEELl" , "HEELc" , "HEELm" , "BALm" , "TOE" , "BALl" , "HEELl" , ];


head = plotD(1:6 , contains(plotD(4 , :), tgtM)&plotD(1 , :)==SubA&plotD(3 , :)==ShoesA&plotD(2 , :)==action);
d.pA = str2double(plotD(7:end , contains(plotD(4 , :), tgtM)&plotD(1 , :)==SubA&plotD(3 , :)==ShoesA&plotD(2 , :)==action));

for j = 2:r1+1
    d.("p"+string(j)) = str2double(plotD(7:end , contains(plotD(4 , :), tgtM)&plotD(1 , :)==others(j-1 , 1)&plotD(3 , :)==others(j-1 , 2)&plotD(2 , :)==action));
    d.("gap"+string(j)) = d.("p"+string(j)) - d.pA;

    dd.("sub"+string(j)) = others(j-1 , 1);
    dd.("shoes"+string(j)) = others(j-1 , 2);
    dd.("action"+string(j)) = action;
    try
        side = "r";
         [dd.(side+"COP"+string(j)) , dd.(side+"GRF"+string(j)) , dd.("PELc"+string(j)) , dd.("pelP"+string(j)) , dd.(side+"legP"+string(j)) , dd.(side+"footP"+string(j))] = arrangeStickPicD(plotD , others(j-1 , 1) , others(j-1 , 2) , action , pelM , legM , footM , side , d.("gap"+string(j)) ,  reverse);

    catch
        disp("Skipped R data")
    end

    try
        side = "l";
        [dd.(side+"COP"+string(j)) , dd.(side+"GRF"+string(j)) , dd.("PELc"+string(j)) , dd.("pelP"+string(j)) , dd.(side+"legP"+string(j)) , dd.(side+"footP"+string(j))] = arrangeStickPicD(plotD , others(j-1 , 1) , others(j-1 , 2) , action , pelM , legM , footM , side , d.("gap"+string(j)) ,  reverse);

    catch       
        disp("Skipped L data")

    end

    try
        side = "rl";
        dd.(side+"GRF"+string(j)) = dd.("rGRF"+string(j)) + dd.("lGRF"+string(j));

    catch
        disp("Skipped RL data")
    end
      

end

[r , c] = size(d.("gap"+string(j)));

%Trial A
j=1;
dd.("sub"+string(j)) = SubA;
dd.("shoes"+string(j)) = ShoesA;
dd.("action"+string(j)) = action;
try
    side = "r";
    [dd.(side+"COP"+string(j)) , dd.(side+"GRF"+string(j)) , dd.("PELc"+string(j)) , dd.("pelP"+string(j)) , dd.(side+"legP"+string(j)) , dd.(side+"footP"+string(j))] = arrangeStickPicD(plotD , SubA , ShoesA , action , pelM , legM , footM , side , zeros(r ,c) ,  reverse);

catch
    disp("Skipped R data")
end

try
    side = "l";
    [dd.(side+"COP"+string(j)) , dd.(side+"GRF"+string(j)) , dd.("PELc"+string(j)) , dd.("pelP"+string(j)) , dd.(side+"legP"+string(j)) , dd.(side+"footP"+string(j))] = arrangeStickPicD(plotD , SubA , ShoesA , action , pelM , legM , footM , side , zeros(r ,c) ,  reverse);

catch
    disp("Skipped L data")

end

try
    side = "rl";
    dd.(side+"GRF"+string(j)) = dd.("rGRF"+string(j)) + dd.("lGRF"+string(j));

catch
    disp("Skipped RL data")
end