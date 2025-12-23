function [sdat] = butterworth(rdat, np, nf, dt, cf)
%   Butterworth Digital Filter Function
%
%   Usage:
%     [output_variables] = butterworth('paddname')
%
%   Input:
%     paddname = file name of padded data.
%
%   Output:
%     output_variables = smoothed data filterd by butterworth_type digital filter.
%
%   Start:2001/4/22(Sun) by Keizo TAKAHASHI
%
% Modified Aug. 22, '01 by Tetsu YAMADA (add error routine)
% Bugfixed Nov. 14, '01 by Tetsu YAMADA (about a second filtering error)
% Bugfixed May  08, '02 by Tetsu YAMADA (about data padding routine less than 20 data)
%
%-----------------------------------------------------------------------------------
%

if size(rdat,2)<=5
    errordlg(sprintf('not enough number of data : only %d !',size(rdat,2)))
    sdat=rdat;
    return
end

% Data padding (adding 40 data by millor method)
if size(rdat,2)>=21
    padn=20;
else
    padn=size(rdat,2)-1;
end
for p = 1 : padn
    spad(:, p) = 2*rdat(:, 1) - rdat(:, padn+2-p);
    epad(:, p) = 2*rdat(:, nf) - rdat(:, nf-p);
end
pdat = [spad rdat epad];

pnf = nf+padn*2;

%   Filter Coefficients (from Winter(1990, pp36-41))
ncf = cf/0.802; sv = 1/(ncf*dt);
z = pi*ncf*dt; wc = tan(z); 
a1 = wc*sqrt(2); b1 = wc^2;
co1 = b1/(1+a1+b1);
co2 = 2*co1;
co3 = co1;
co4 = (-1)*(2*b1-2)/(1+a1+b1);
co5 = (-1)*(b1-a1+1)/(1+a1+b1);
%
KAISU = 0;
while KAISU < 2
spdat(:, 1:2) = pdat(:, 1:2);
    for p = 3 : pnf
        l = p-1; m = p-2;
        spdat(:, p) = co1*pdat(:, p)+co2*pdat(:, l)+co3*pdat(:, m)+co4*spdat(:, l)+co5*spdat(:, m);
    end
%
pdat = fliplr(spdat);
KAISU = KAISU+1;
end
%

sdat(:,1:nf) = pdat( : , padn+1 : nf+padn);

