%------------------------------------------------------------------------------
%		BSP算出
%------------------------------------------------------------------------------
function [pnt, sg]=setSgLside(p, pnt, d)

% 	[cgdataR, bspdataR]=cg(pnt.datBspR, 1, 'm', p.weight, 'y', 3);
	[cgdataL, bspdataL]=cg(pnt.datBsp, 1, 'm', p.weight, p.switch, 3);

	pnt.cg=cgdataL;%(10:12, :)
	[~, nFr] =size(pnt.cg);

	%--------------------------
	%	各セグメント重心座標算出
	%--------------------------
	for iSg=1:3
		for iFr=1:nFr
% 			sg(1, iSg).cg(:, iFr)=cgdataR(3*(3-iSg)+1:3*(4-iSg), iFr);
			sg(1, iSg).cg(:, iFr)=cgdataL(3*(3-iSg)+1:3*(4-iSg), iFr);

		end
	end

	%------------------------------
	%	各セグメントInertia, mass算出
	%------------------------------
	for iSg=1:3        
		%left side
        sg(1, iSg).Iobj=bspdataL(3:5, (4-iSg));
		sg(1, iSg).m		=bspdataL(2, (4-iSg));
        sg(1, iSg).slength = bspdataL(1, (4-iSg));
        
	end

	return;
