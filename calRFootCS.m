function CS = calRFootCS(trial,nFr)

CS = zeros(4);
CS(1,1) = 1;
%Origin
CS(2:4,1) = trial.rHEELc(nFr,:);
%matrix
CS(2:4,2:4) = getCsFootR(trial.rHEELc(nFr,:),trial.rBALl(nFr,:),trial.rBALm(nFr,:),trial.rMPc(nFr,:));
CS(2:4,2) = CS(2:4,2);
CS(2:4,3) = CS(2:4,3);
CS(2:4,4) = CS(2:4,4);
CS(isnan(CS)) = 0;


end