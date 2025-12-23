function CS = calLForeFootCS(seg,nFr)

CS = zeros(4);
CS(1,1) = 1;
%Origin
CS(2:4,1) = seg.lMPc(nFr,:);

CS(2:4,2:4) = getCsFootL(seg.lMPc(nFr,:),seg.lBALm(nFr,:),seg.lBALl(nFr,:),seg.lTOE(nFr,:));
CS(2:4,2) = CS(2:4,2);
CS(isnan(CS)) = 0;
end

