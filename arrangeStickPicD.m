function [COP, GRF, PELc, pelP, legP, footP] = arrangeStickPicD(data, Sub, Shoes, action, pelM, legM, footM, side, gap, reverse)

cCol = find(data(4, :)=="ContactTime", 1, "last");
val = str2double(data(7:end, cCol+1:end));
header = data(1:5, cCol+1:end);


COP = val(:, header(4, :)== side+"COP" & header(3, :)==Shoes & header(1, :) == Sub & header(2, :)== action);%val(:, contains(header(4, :), side+"COP") & header(3, :)==Shoes & contains(header(1, :), Sub) & contains(header(2, :), action));%contains(header(3, :), Shoes)
GRF = val(:, header(4, :)== side+"GRF" & header(3, :)==Shoes & header(1, :) == Sub & header(2, :)== action);%header(:, contains(header(4, :), side+"GRF") & header(3, :)==Shoes & contains(header(1, :), Sub) & contains(header(2, :), action));%contains(header(3, :), Shoes)
% chk = header(:, header(4, :)== side+"GRF" & header(3, :)==Shoes & header(1, :) == Sub & header(2, :)== action);%header(:, contains(header(4, :), side+"GRF") & header(3, :)==Shoes & contains(header(1, :), Sub) & contains(header(2, :), action));%contains(header(3, :), Shoes)


COP = [COP(:, 1:2)-gap(:, 1:2) COP(:, 3)];

PELvel = val(:, header(4, :)== "PEL_vel" & header(3, :)==Shoes & header(1, :) == Sub & header(2, :)== action);%header(:, contains(header(4, :), side+"GRF") & header(3, :)==Shoes & contains(header(1, :), Sub) & contains(header(2, :), action));%contains(header(3, :), Shoes)


PELc = val(:, header(4, :)== "PELc" & header(3, :)==Shoes & header(1, :) == Sub & header(2, :)== action);%val(:, contains(header(4, :), side+"COP") & header(3, :)==Shoes & contains(header(1, :), Sub) & contains(header(2, :), action));%contains(header(3, :), Shoes)

PELc = [PELc PELvel];

if side == "r"
    tmp = arraySeries(find(GRF(:, 3)<20),"bot");
    part = 1;%tmp(end):tmp(end);

elseif side == "l"
    tmp = arraySeries(find(GRF(:, 3)<20), "top");
    part = tmp(1):tmp(end)-15;

end
partL = length(part);
COP(part, :) = zeros(partL, 3);
GRF(part, :) = zeros(partL, 3);
COP(part, :)= 0;
res = [];
ll = [];
marker = pelM;
nRep = length(marker);
for i = 1:nRep
    tmp = val(:, contains(header(4, :), marker(i)) &  header(3, :)==Shoes & contains(header(1, :), Sub) & contains(header(2, :), action)) - gap;
    res = horzcat(res, tmp);
    ll = vertcat(ll, marker(i));

end
pelP = res;

res = [];
ll = [];
marker = legM;
nRep = length(marker);
for i = 1:nRep
    tmp = val(:, contains(header(4, :), side+marker(i)) &  header(3, :)==Shoes & contains(header(1, :), Sub) & contains(header(2, :), action)) - gap;
    res = horzcat(res, tmp);
    ll = vertcat(ll, marker(i));

end
legP = res;
[~, c] = size(legP);
legP(part, :) = nan(length(part), c);

res = [];
ll = [];
marker = footM;
nRep = length(marker);
for i = 1:nRep
    tmp = val(:, contains(header(4, :), side+marker(i)) &  header(3, :)==Shoes & contains(header(1, :), Sub) & contains(header(2, :), action)) - gap;
    res = horzcat(res, tmp);
    ll = vertcat(ll, marker(i));

end
footP = res;
[~, c] = size(footP);
footP(part, :) = nan(length(part), c);

if reverse == 1
    COP = [-COP(:,1) COP(:,2:3)];
    GRF(:,1) = -GRF(:,1);
    PELc(:,1:3:end) = -PELc(:, 1:3:end);
    pelP(:,1:3:end) = -pelP(:, 1:3:end);
    legP(:,1:3:end) = -legP(:, 1:3:end);
    footP(:,1:3:end) = -footP(:, 1:3:end);

end

end