function resD = exTrial(original, list_NotEx_trialname)
ppp = original';

resD = [];
for jj = 2:length(list_NotEx_trialname)
    ddd = ppp(ppp(:,1)==list_NotEx_trialname(jj,1) & ppp(:,2)==list_NotEx_trialname(jj,2) & ppp(:,4)==list_NotEx_trialname(jj,4) ,:);
    resD = [resD; ddd];

end

resD = sortrows(resD, [3, 5, 6], 'ascend')';