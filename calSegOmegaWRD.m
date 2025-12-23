function omega = calSegOmegaWRD(segR,time_int)

uX = segR(2:4,2:4:end);
uY = segR(2:4,3:4:end);
uZ = segR(2:4,4:4:end);

duX = diff3(uX',time_int)';
duY = diff3(uY',time_int)';
duZ = diff3(uZ',time_int)';

nFr = length(uX);

for iFr=1:nFr
    c1=duX(:,iFr);
    c2=duY(:,iFr);
    c3=duZ(:,iFr);
    B1=cal_Bmat(uX(:,iFr));
    B2=cal_Bmat(uY(:,iFr));
    B3=cal_Bmat(uZ(:,iFr));
    
    cc=[c1;c2;c3];
    BB=[B1;B2;B3];
    
    omega(iFr,:)=[(BB'*BB)\BB'*cc]';
end
end

function Bmat=cal_Bmat(b)
%外積マトリクス
Bmat=[0  b(3)  -b(2);
    -b(3)  0  b(1);
    b(2)  -b(1)  0];



return;

end

