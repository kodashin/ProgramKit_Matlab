function CS = calLThighCS(trial,nFr)

CS = zeros(4);
CS(1,1) = 1;
%Origin
CS(2:4,1) =  [trial.lTHIGHG(:,nFr)]';
%Z axis
CS(2:4,4) = (trial.lHIPc(nFr,:) - trial.lKNEEc(nFr,:))/norm((trial.lHIPc(nFr,:) - trial.lKNEEc(nFr,:)));
lTHIGHs = (trial.lKNEEm(nFr,:) - trial.lKNEEl(nFr,:))/norm((trial.lKNEEm(nFr,:) - trial.lKNEEl(nFr,:)));
%Y axis
CS(2:4,3) = cross(CS(2:4,4),lTHIGHs)/norm(cross(CS(2:4,4),lTHIGHs));
%X axis
CS(2:4,2) = cross(CS(2:4,3),CS(2:4,4))/norm(cross(CS(2:4,3),CS(2:4,4)));
CS(isnan(CS)) = 0;
end

