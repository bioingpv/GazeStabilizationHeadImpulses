function simulateHeadPerturbation(nsub)

%%%%simulation of head perturbation during covert saccade


close all

if nargin<1
    nsub=4;
end




%%%%%%%%%%simulate a subject with optimized parameters
load data
load optimizationRes
load burstpar



sg=find(parHI(:,end)==nsub);

smp=500;%%%simulation sampling frequency
ff=50;
[bf,af]=butter(4,ff/(smp/2));

j=1;
for i=101%:size(trc,1)
    
    [~, b]=max(abs(trcHI{i,2}));
    if trcHI{i,2}(b)<0
        s=1;
    else
        s=-1;
    end
    trcHI{i,5}(1)=trcHI{i,5}(1)-5;
    trcHI{i,5}(2)=trcHI{i,5}(2)+2;
    perhv=perturbateHead(s*trcHI{i,2},trcHI{i,5});
    head.signals.values=s*trcHI{i,2};
    head.signals.dimension=1;
    head.time=buildtime(1:1:length(head.signals.values),220);
    eye.signals.values=s*trcHI{i,3};
    eye.signals.dimension=1;
    eye.time=head.time;
    tempo.signals.values=head.time;
    tempo.signals.dimension=1;
    tempo.time=head.time;
    
    vg=.3;%parHI(i,4); %vorgain
    strc=head.time(trcHI{i,5}(1)); %%start saccade
    stpc=head.time(trcHI{i,5}(2)); %% end saccade
    
    plantParameters
    
    Bm=sacPar(parHI(i,8),1);
    Bk=sacPar(parHI(i,8),2);
    
    vs=optimPar(i,2); %vsG
    heg=1;%optimPar(i,1);% pG
    
    options = simset('SrcWorkspace','current');
    sim('modelOpt',[],options)
    
    hp1=hp;
    psim1=psim;
    bn1=bn;
    
    head.signals.values=perhv;%trcHI{i,2};
    sim('modelOpt',[],options)
    
    figure
    sbp(1)=subplot(1,2,1);
    hold on
    plot(bn1)
    plot(bn,'r')
    plot(sw*10,'k')
    sbp(2)=subplot(1,2,2);
    hold on
    plot(hp,'r-')
    plot(hp1,'r')
    plot(psim1)
    plot(psim,'-')
    plot(sw*10,'k')
    linkaxes(sbp,'x')
    %%%[head_pos eye_pos sim_eye_pos head_vel eye_vel sim_eye_vel]
    %trcsim{j,1}=[hp(1:a(end)+10) ep(1:a(end)+10) psim(1:a(end)+10) hv(1:a(end)+10) v(1:a(end)+10) vsim(1:a(end)+10)];
    j=j+1;
end


function res=perturbateHead(headv,idx)
headv(idx(1):idx(1)+12)=NaN;
headv(idx(1)+5)=0;
res=interpNaN(headv);
% headv(idx(1):idx(2))=NaN;
% headv(round(idx(1)+(idx(2)-idx(1))/2))=0;
% res=interpNaN(headv);

% pG=optimPar(sg,1);
% vG=parHI(sg,4);
% 
% for i=1:size(trcsim,1)
%     m=trcsim{i,1};
%     t=buildtime(1:1:length(m),500);
%     yl=max(m(:,1));
%     
%     figure
%     sp(1)=subplot(1,3,1);
%     hold on
%     plot(t,m(:,1),'r')
%     plot(t,pG(i)*m(:,1),'g')
%     plot(t,m(:,2))
%     plot(t,m(:,3),'k')
%     ylabel('deg')
%     xlabel('s')
%     ylim([-1 yl])
%     xlim([0 max(t)])
%     title(strcat('pG=',num2str(pG(i))))
%     legend('head pos','head pos pred','eye pos','eye pos sim','Location','northwest')
%     
%     sp(1)=subplot(1,3,2);
%     hold on
%     plot(t,m(:,1)-m(:,2))
%     plot(t,m(:,1)-m(:,3),'k')
%     plot(t,pG(i)*m(:,1)-m(:,3),'g')
%     legend('gaze','gaze sim','gaze pred','Location','northwest')
%     xlim([0 max(t)])
%     ylabel('deg')
%     xlabel('s')
%     ylim([-1 yl])
%     
%     sp(1)=subplot(1,3,3);
%     hold on
%     plot(t,m(:,4),'r')
%     plot(t,m(:,5))
%     plot(t,m(:,6),'k')
%     legend('head vel','eye vel','eye vel sim','Location','northwest')
%     title(strcat('vor gain=',num2str(vG(i))))
%     ylabel('deg/s')
%     xlabel('s')
%     xlim([0 max(t)])
%     linkaxes(sp,'x')
% end
% 







