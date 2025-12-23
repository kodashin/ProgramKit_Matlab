function [sdata,ocf]=atsmt(rdata,np, nf, dt, clow,ctop,graphic_option,marker)

% Auto smoothing program (Wells and Winter's Method).
%
% Usage
%   [sdata,ocf]=atsmt(rdata,np,nf,dt,clow,ctop,graphic_option);
%
% Imput
%   rdata         : raw data
%   np            : number of point
%   nf            : number of frame
%   dt            : time interval
%   clow          : lowest % for regression line
%   ctop          : highest % for regression line
%   graphic_option: drawing graphics option ('' or 'no')
%
% Output
%   sdata         : smoothed data
%   ocf           : optimal cut-off frequency
%
% Last edit May 06,'01 by Tetsu YAMADA
% Modified Aug. 22,'01 by Tetsu YAMADA : error routine and non graphics routine
%
% -----------------------------------------------------------
%

dimtxt={'X direction','Y direction','Z direction'};
sdata=zeros(size(rdata));
sd=zeros(ctop,size(rdata,2));
fs=round(100/dt)/100;

dim=size(rdata,1)/np;

for i=1:dim
    for j=1:np
        if size(rdata((i+(j-1)*dim),:),2)<=5
            disp("Check error: "+marker)
            break
        end
        for k=1:ctop

            sd(k,:)=butterworth(rdata((i+(j-1)*dim),:),np,nf,dt,fs*k/100);

            % Computing Standard Error
            dif=sd(k,:)-rdata((i+(j-1)*dim),:);
            se(k,:)=[1,fs*k/100,sqrt((dif*dif')/nf)];
        end

        % Least Square Method
        xy(1:(ctop-clow+1),:)=se(clow:ctop,:);
        xy=xy'*xy;
        answer=xy(1:2,1:2)\xy(1:2,3);
        a=answer(1);
        b=answer(2);

        if b>0
            waitfor(errordlg('Impossible to compute the optimal cut-off frequency!',[num2str(j) ' point   ' dimtxt{i}],'on'));
            ocf(j,i)=fs*0.1;
        else
            k=1;
            while se(k,3)>a
                k=k+1;
            end
            ocf(j,i)=fs*k/100;
            sdata((i+(j-1)*dim),:)=sd(k,:);

            % Graphics
            if graphic_option=='Y' | graphic_option=='y'
                ax=[0,fs*ctop/100,0,se(1,3)];

                % ---- Difine the objects.
                clf
                set(gcf,'name',[num2str(j) ' point   ' dimtxt{i} '  : Cut-off Frequency =  ' num2str(ocf(j,i))],'DoubleBuffer','on');
                lab(1,:)=line('xdata',[0 fs*ctop/100],'ydata',[a a+fs*ctop/100*b],'linewidth',1,'erase','xor','linestyle','-','color',[1 0 0]);
                lab(2,:)=line('xdata',[0 fs*ctop/100],'ydata',[a a],'linewidth',1,'erase','normal','linestyle','--','color',[0 0 1]);
                lab(3,:)=line('xdata',se(:,2),'ydata',se(:,3),'linewidth',1,'erase','xor','linestyle','-','color',[0 0 0]);
                lab(4,:)=line('xdata',[ocf(j,i) ocf(j,i)],'ydata',[0 se(1,3)],'linewidth',1,'erase','xor','linestyle',':','color',[1 0 0]);

                axis('normal');axis(ax);
                set(gca,'xtick',[0:fs/100:fs*ctop/100]);

                drawnow
                %								pause(0.1)
            end
        end
    end
end
if graphic_option=='Y' | graphic_option=='y'
    close(gcf)

end