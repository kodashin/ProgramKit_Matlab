function CS = calRShankCS(trial,nFr)

CS = zeros(4);
CS(1,1) = 1;
%Origin
CS(2:4,1) = trial.rSHANKG(:,nFr);
%Z axis
CS(2:4,4) = (trial.rKNEEc(nFr,:) - trial.rANKc(nFr,:))/norm((trial.rKNEEc(nFr,:) - trial.rANKc(nFr,:)));
rSHANKs = (trial.rANKl(nFr,:) - trial.rANKm(nFr,:))/norm((trial.rANKl(nFr,:) - trial.rANKm(nFr,:)));
%Y axis
CS(2:4,3) = cross(CS(2:4,4),rSHANKs)/norm(cross(CS(2:4,4),rSHANKs));
%X axis
CS(2:4,2) = cross(CS(2:4,3),CS(2:4,4))/norm(cross(CS(2:4,3),CS(2:4,4)));
CS(isnan(CS)) = 0;
end