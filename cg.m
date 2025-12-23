%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function [cgdata,bspdata]=cg(co_data,gen,sex,weight,torso,dim)

	%---------------------------------------------------------
	%	Computation of C.G. location and B.S.P..
	%
	%	Input
	%		co_data	: 2D or 3D coordinate data
	%		gen			: adult=1 kid=2 elder=3
	%		sex			: sex (f/m)
	%		height	: height (m)
	%		weight	: weight (kg)
	%		torso		: whether the torso was divided into 2 segments or not (y/n)
	%
	%	Output
	%		cgdata	: C.G. coordinates of the body segments
	%		bspdata	: Sg_length, Sg_mass,	moment of inertia about X,Y,Z axes
	% ------------------------------------------------------------

	%--------- read the list of B.S.P. coefficient	----------------
	if gen==1 && (sex=='M' || sex=='m')
		bsplist='cgae_m.lst';

	elseif gen==1 && (sex=='F' || sex=='f')
		bsplist='cgae_f.lst';

	else
		waitfor(errordlg('Check the dialogue for generation or sex!','Error'));
		cgdata=-1;
		bspdata=-1;
		return;

	end

	Coe=dlmread(bsplist);	%	Coefficient

	%--------- read the list of segment vector definition ------------
	if torso=='Y' || torso=='y'
		nSg		=3;
		Sglist='3seg.lst';
		Coe	 	=Coe(4:6,:);	% coefficient data abstraction

	elseif torso=='N' || torso=='n'
		nSg		=12;
		Sglist='12seg.lst';
		Coe		=Coe([2:3 2:3 4:6 4:6 9 10],:);

    elseif torso== 'F' || torso=='f'
        nSg		=15;
		Sglist='15seg.lst';
        Coe    = Coe([1:3 1:3 4:6 4:6 7:9], :);

         
	else
		waitfor(errordlg('Check the dialogue for torso separation!','Error'));
		cgdata=-1; bspdata=-1;
		return;

	end

	Sg=dlmread(Sglist);
%--------------------
%Coeの順番：行方向
%手→前腕→上腕→足→下腿→大腿→頭部→胴体→上胴→下胴
%--------------------
	cg_ratio	=Coe(:,1);		% C.G. ratio for each Sg
	co_mass		=Coe(:,2:4);	% coefficient to estimate Sg mass
	co_inertia=Coe(:,5:13);	% coefficient to estimate M_of_Inertia for each Sg

    for j=1:nSg
        jj	=dim*(Sg(j,1:4)-1)+1;%セグメントのつなぎ方を取得
        tail=co_data(jj(1):jj(1)+dim-1,:);	% tail coordinate of jth Sg for all frm
        tip	=co_data(jj(3):jj(3)+dim-1,:);	% tip coordinate

        if Sg(j,2)~=0
            tail2	=co_data(jj(2):jj(2)+dim-1,:);
            tail	=(tail+tail2)/2;
        end

        if Sg(j,4)~=0
            tip2=co_data(jj(4):jj(4)+dim-1,:);
            tip	=(tip+tip2)/2;
        end

        %------ calculation of C.G. location of body segment	---------
        cgdata(dim*(j-1)+1:dim*j,:)=cg_ratio(j)*tail+(1-cg_ratio(j))*tip;

        %---------- calculation of Sg length	----------
        slength(j,1)=mean(diag(sqrt((tip-tail)'*(tip-tail))));
        %            slength(j,1) = mean( diag( sqrt( (tip-tail)*(tip-tail)' ) ) );
    end
    
%     size(slength)
%	%----	average of Sg length for R and L extremities	----
%	slength(1:8)=mean([slength([1 1 3:5 3:5]) slength([2 2 6:8 6:8])],2);
	slength(1:nSg)=([slength([1:nSg])]);

    %------- calculation of segment mass	---------
    smass=co_mass(:,1)+co_mass(:,2).*slength+co_mass(:,3)*weight;
    % if nSg ~= 3
    % 	smass=smass*(weight/sum(smass));
    % 
    % end
	%------- calculation of Moment of Inertia	-------
	for j=1:3
		m_inertia(:,j)=(co_inertia(:,j*3-2)+co_inertia(:,j*3-1).*slength+co_inertia(:,j*3)*weight)/10000;
	end

    % calculation of  C.G. location of the whole body
    cgdata = cgdata';
    for j=1:dim
        cgdata(:, dim*nSg+j) = cgdata(:, j:dim:dim*(nSg-1)+j) * smass /weight;
    end
     cgdata = cgdata';

	%------- framing of bsp data	----------
	bspdata=[slength smass m_inertia]';

	return;
