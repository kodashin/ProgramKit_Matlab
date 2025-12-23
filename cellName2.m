function cell = cellName2(row, col, mode)
arguments
    row (1,1) {mustBeInteger(row),mustBePositive(row)} = 1;
    col  (1,1) {mustBeInteger(col),mustBePositive(col)} = 1;
    %     mode = 0;
    mode{mustBeMember(mode,[0,1,2,3])} = 0;

end
% Generates excel cell name from numeric (row, col) index.
% The following assertions ensure valid generation of cell names
% for excel versions that requires to have rows between 1 and 65536,
% and columns between 1 and 676.
assert(((row > 0) && (row <= 65536)),...
    'Row index must be a positive integer not exceeding 65536.');
assert(((col > 0) && (col <= 676)),...
    'Column index must be a positive integer not exceeding 676.');
%※676 = alphabet 26 characters * alphabet 26 characters
%mode:0→何もなし，1→列のみ絶対参照 $A6，2→行のみ絶対参照 A$6，3→行列ともに絶対参照 $A$6

alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","O","Q","R","S","T","Y","V","W","X","Y","Z"];
a = mod(col, length(alphabet));
b = floor((col-a)/length(alphabet));
%絶対参照の設定
if mode == 0
    ref1 = "";
    ref2 = "";

elseif mode == 1
    ref1 = "$";
    ref2 = "";

elseif mode == 2
    ref1 = "";
    ref2 = "$";

elseif mode == 3
    ref1 = "$";
    ref2 = "$";

end


if b < 1
    if a ~=0
        cell = ref1+alphabet(a)+ref2+string(row);

    else
        cell = ref1+"Z"+ref2+string(row);

    end



elseif b >= 1
    if a ~=0
        cell = ref1+alphabet(b)+alphabet(a)+ref2+string(row);

    else
        cell = ref1+alphabet(b)+"Z"+ref2+string(row);

    end

end

end


