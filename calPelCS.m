function CS = calPelCS(trial,nFr)
%Pelvis segment
CS(:,1:4) = zeros(4);
CS(1,1) = 1;
%Origin
CS(2:4,1) = trial.PELc(nFr,:);
%X axis
CS(2:4,2) = (trial.lPSIS(nFr,:) - trial.rPSIS(nFr,:))/norm((trial.lPSIS(nFr,:) - trial.rPSIS(nFr,:)));
sPEL = (trial.ASISc(nFr,:) - trial.PSISc(nFr,:))/norm((trial.ASISc(nFr,:) - trial.PSISc(nFr,:)));
%Z axis
CS(2:4,4) = cross(sPEL,CS(2:4,2))/norm(cross(sPEL,CS(2:4,2)));
%Y axis
CS(2:4,3) = cross(CS(2:4,4),CS(2:4,2))/norm(cross(CS(2:4,4),CS(2:4,2)));
CS(isnan(CS)) = 0;

end
