%------------------------------------------------------------------------------
%		BSP算出
%------------------------------------------------------------------------------
function [pnt,sg]=setSgRside(p,pnt,d)

	[cgdataR,bspdataR]=cg(pnt.datBspR,1,'m',p.weight,'y',3);
% 	[cgdataL,bspdataL]=cg(pnt.datBspL,1,'m',p.weight,'y',3);

	pnt.cg=cgdataR(10:12,:);
	[~,nFr] =size(pnt.cg);

	%--------------------------
	%	各セグメント重心座標算出
	%--------------------------
	for iSg=1:3
		for iFr=1:nFr
			sg(1,iSg).cg(:,iFr)=cgdataR(3*(3-iSg)+1:3*(4-iSg),iFr);
% 			sg(2,iSg).cg(:,iFr)=cgdataL(3*(3-iSg)+1:3*(4-iSg),iFr);
		end
	end

	%------------------------------
	%	各セグメントInertia,mass算出
	%------------------------------
	for iSg=1:3
        %right side
		sg(1,iSg).Iobj=bspdataR(3:5,(4-iSg));
		sg(1,iSg).m		=bspdataR(2,(4-iSg));
        sg(1,iSg).slength = bspdataR(1,(4-iSg));
        
% 		%left side
%         sg(2,iSg).Iobj=bspdataL(3:5,(4-iSg));
% 		sg(2,iSg).m		=bspdataL(2,(4-iSg));
%         sg(2,iSg).slength = bspdataL(1,(4-iSg));
        
	end

	return;
