function CS = calRForeFootCS(seg,nFr)

CS = zeros(4);
CS(1,1) = 1;
%Origin
CS(2:4,1) = seg.rMPc(nFr,:);

CS(2:4,2:4) = getCsFootL(seg.rMPc(nFr,:),seg.rBALm(nFr,:),seg.rBALl(nFr,:),seg.rTOE(nFr,:));
CS(2:4,2) = CS(2:4,2);
CS(isnan(CS)) = 0;

end