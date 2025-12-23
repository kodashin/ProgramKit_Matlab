function RO = calRAnkleCS(seg,CS,nFr)

RO = zeros(4);
RO(1,1) = 1;
%Origin
RO(2:4,1) = seg.rANKc(nFr,:)';
%Z axis
RO(2:4,4) = CS.rFOOT(2:4,4+4*(nFr-1));
ANKs = CS.rSHANK(2:4,2+4*(nFr-1));
%Y axis
RO(2:4,3) = cross(RO(2:4,4),ANKs)/norm(cross(RO(2:4,4),ANKs));
%X axis
RO(2:4,2) = cross(RO(2:4,3),RO(2:4,4))/...
    norm(cross(RO(2:4,3),RO(2:4,4)));
RO(isnan(RO)) = 0;
end