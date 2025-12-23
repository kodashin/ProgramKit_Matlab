%---------------------------------------------------------------------------
% function of differential calculus using spline function
% 							S.KOIKE 2003.12.25
%---------------------------------------------------------------------------
function 	diff=diffspl3(data,n_frame,time_int)

 data=data';  
	nDiv=1;
	time_intDiv=time_int/nDiv;
	tt=0:time_int:(n_frame-1)*time_int;
	ttDiv=0:time_intDiv:(n_frame-1)*time_int;
	DivData=spline(tt,data(:,1:n_frame),ttDiv);
  
	cs=spline(ttDiv,DivData);
  
	%-- ˆêŠK”÷•ª
	a=cs.coefs(:,1);
	b=cs.coefs(:,2);
	c=cs.coefs(:,3);
	d=cs.coefs(:,4);

	csd.coefs(:,1)=0*d;
	csd.coefs(:,2)=3*a;
	csd.coefs(:,3)=2*b;
	csd.coefs(:,4)=c;

	cs.coefs=csd.coefs;
	diff=ppval(cs,tt)';
%	Divdiff_1=ppval(cs,ttDiv);
%	diff_1=spline(ttDiv,Divdiff_1,tt);

return

%function 	diff=diffspl3(data,n_frame,time_int)
%
%	nDiv=2;
%	time_intDiv=time_int/nDiv;
%	tt=0:time_int:(n_frame-1)*time_int;
%	ttDiv=0:time_intDiv:(n_frame-1)*time_int;
%	nDiv=max(size(ttDiv));
%
%	DivData=spline(tt,data(:,1:n_frame),ttDiv);
%
%	cs=spline(ttDiv,DivData);
%
%	nDim=cs.dim;
%
%	nPcs=cs.pieces;
%	for iDim=1:nDim
%		for iPcs=1:nPcs
%			jj=nPcs*(iDim-1)+iPcs;
%			a=cs.coefs(jj,1);
%			b=cs.coefs(jj,2);
%			c=cs.coefs(jj,3);
%			d=cs.coefs(jj,4);
%
%			csd.coefs(jj,1)=0;
%			csd.coefs(jj,2)=3*a;
%			csd.coefs(jj,3)=2*b;
%			csd.coefs(jj,4)=c;
%		end
%	end
%	cs.coefs=csd.coefs;
%	Divdiff=ppval(cs,ttDiv);
%
%	diff=spline(ttDiv,Divdiff,tt);
%
%	return;
%