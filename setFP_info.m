function [posiFP, Dposi, fpNo, fpOrder, side1, side2] = setFP_info(step, fp)

 %FPを踏む順番を定義
        if step == "lr" && fp == "12"

            side1 = "l";
            side2 = "r";
             posiFP = [0.3 0.45 0.6 0.9;0.3 -0.45 0.6 0.9];
            Dposi = [29:36;12:19];
            fpNo = [5 1];
            % fpOrder = [1 2];
           
        elseif step == "lr" && fp == "21"

            side1 = "l";
            side2 = "r";
             posiFP = [0.3 -0.45 0.6 0.9;0.3 0.45 0.6 0.9];
            Dposi = [12:19;29:36;];
            fpNo = [1 5];
            % fpOrder = [2 1];
           
        elseif step == "rl" && fp == "12"

            side1 = "r";
            side2 = "l";
            posiFP = [0.3 0.45 0.6 0.9;0.3 -0.45 0.6 0.9];
            Dposi = [29:36;12:19];
            fpNo = [5 1];
             % fpOrder = [1 2];
           
        elseif step == "rl" && fp == "21"
    
            side1 = "r";
            side2 = "l";
            posiFP = [0.3 -0.45 0.6 0.9;0.3 0.45 0.6 0.9];
            Dposi = [12:19;29:36;];
            fpNo = [1 5];
            % fpOrder = [1 2];
          
        end
        fpOrder = [1 2];


end