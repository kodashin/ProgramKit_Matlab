%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function res=NormalTime2(rd,ti,nFr)

[nd,cc]=size(rd);

rnx=0:ti:(nd-1)*ti;
nnx=0:(nd/(nFr))*ti:(nd)*ti;

for ii = 1:cc
    %     try
    res(:,ii) = spline(rnx,rd(:,ii),nnx)';

    %     catch
    %  disp("Not numerical data included...")
    %
    %     end
end
return
