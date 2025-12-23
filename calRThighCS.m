function CS = calRThighCS(trial,nFr)

CS = zeros(4);
CS(1,1) = 1;
%Origin
CS(2:4,1) =  trial.rTHIGHG(:,nFr)';
%Z axis
CS(2:4,4) = (trial.rHIPc(nFr,:) - trial.rKNEEc(nFr,:))/norm((trial.rHIPc(nFr,:) - trial.rKNEEc(nFr,:)));
rTHIGHs = (trial.rKNEEl(nFr,:) - trial.rKNEEm(nFr,:))/norm((trial.rKNEEl(nFr,:) - trial.rKNEEm(nFr,:)));
%Y axis
CS(2:4,3) = cross(CS(2:4,4),rTHIGHs)/norm(cross(CS(2:4,4),rTHIGHs));
%X axis
CS(2:4,2) = cross(CS(2:4,3),CS(2:4,4))/norm(cross(CS(2:4,3),CS(2:4,4)));
CS(isnan(CS)) = 0;
end
