function trial = getMarkerData_stand(val, text, header, marker, whole_length, arm)
%val:VICONデータの数値部分のみ
%text:VICONデータのテキスト部分のみ
%header:VICONマーカーのヘッダー
%marker:取得したいマーカーのリスト
%whole_length:補間後のフレーム数
% s = inputname(1);
FR250 = 1/250;
FR1000 = 1/1000;
%左打ちの選手のデータは左右を入れ替える，X（左右）方向を逆にする
marker = char(marker);
if arm == "R"
    xyz = [1;1;1];

elseif arm=="L"
    xyz = [-1;1;1];

    if contains(marker(1), "r")==1
        marker = "l"+marker(2:end);

    elseif contains(marker(1), "l")==1
        marker = "r"+marker(2:end);

    end

end

marker = string(marker);


%データの抜出1
try
    prepre = [];
    [rr, cc] = find(string(text) == header + marker);
    pre = val(rr+4:rr+4+whole_length, cc:cc+2);%(end-whole_length:end, cc:cc+2);
    pre(isnan(pre(:, 1))==1, :) = [];

    data_range = find(isnan(pre(:, 1))==0);
    testtest = pre(data_range, :);

    %補間データをスムージング
    [np dum]=size(testtest');
    np			=np/3;
    % --- Smoothing [Butterworth Digital Filter] ---
    nf=length(testtest');

    if nf < 5
        error("data shortage")

    end

    rdata=testtest';
    dt=1/250;
    clow=10;
    ctop=20;
    graphic_option='no';
    [sdata, ocf]=atsmt(rdata, np,  nf,  dt,  clow, ctop, graphic_option);
    kari=sdata'/1000;
    % cf=100;
    % kari=butterworth(testtest', nComp, nDat, FR1000, cf)'./1000;

    %FPデータに合わせてマーカーデータを補間
    %※対象データ部分のみを補間→FPのコマ数に合わせた配列にフレームNO.を合わせて代入
    nd=length(testtest);
    nFr = 4*(nd);


    rnx=0.004:FR250:(nd)*FR250;
    nnx=0.001:FR1000:(nd)*FR250;
    %250Hz→1000Hz
    prepre(:, 1) = spline(rnx, kari(:, 1), nnx)'*xyz(1);
    prepre(:, 2) = spline(rnx, kari(:, 2), nnx)'*xyz(2);
    prepre(:, 3) = spline(rnx, kari(:, 3), nnx)'*xyz(3);

    trial = prepre;

%     basho = flip(whole_length-[1:nFr])+1;
%     trial = zeros(whole_length, 3);
%     trial(basho, :) = prepre;

%     trial(1+4*(data_range(1)-1):4+4*(data_range(end)-1), :) = prepre;
catch
    
    trial = zeros(whole_length, 3);
    disp("Marker data skipped: "+marker)
end



