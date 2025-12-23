function CS = calLShankCS(trial,nFr)

CS = zeros(4);
CS(1,1) = 1;
%Origin
CS(2:4,1) = [trial.lSHANKG(:,nFr)]';
%Z axis
tmp = trial.lKNEEc(nFr,:) - trial.lANKc(nFr,:);
CS(2:4,4) = (tmp)/norm(tmp);
%Y axis
lSHANKs = (trial.lANKm(nFr,:) - trial.lANKl(nFr,:))/norm((trial.lANKm(nFr,:) - trial.lANKl(nFr,:)));
CS(2:4,3) = cross(CS(2:4,4),lSHANKs)/norm(cross(CS(2:4,4),lSHANKs));
%X axis
CS(2:4,2) = cross(CS(2:4,3),CS(2:4,4))/norm(cross(CS(2:4,3),CS(2:4,4)));
CS(isnan(CS)) = 0;
end
