%note---------------------------
%行ベクトル
%data:データの行配列　3行以上
%3列計算可

function res = diff3(data,time_int)
[~,cc] = size(data);
res = zeros(length(data),cc);

res(1,:) = (-3*data(1,:) + 4*data(2,:) -data(3,:))./(2*time_int);
for i = 2:length(data)-1

    res(i,:) = (data(i+1,:) - data(i-1,:))./(time_int * 2);

end
res(end,:) = (data(end-2,:) -4*data(end-1,:) +3*data(end,:)) ./ (2*time_int);
% [max_value,max_index] = max(res);


end
 

    