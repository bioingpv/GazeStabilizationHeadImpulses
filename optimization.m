clear
close all 
clc
%%%%%%%% optimization of parameters pG and vsG
%%%%%%%% results are saved in optimizationRes


load burstpar %%saccadic burst paramentrs
load data %%%head impulse data

%%%parHI=[headPeakAcc headPeakVel sacLatency gain comp_error sacc_amplitude saccPeakVel sogNum]
%%%trcHI= [eyeVelocity headVelocity eyePos headPos sac_idx sogNum]


optimPar=[];
sg=1:1:size(trcHI,1);
for i=sg%:size(trc,1)
    i
    [~, b]=max(abs(trcHI{i,2}));
    if trcHI{i,2}(b)<0
        s=1;
    else
        s=-1;
    end
    head.signals.values=s*trcHI{i,2};
    head.signals.dimension=1;
    head.time=buildtime(1:1:length(head.signals.values),220);
    eye.signals.values=s*trcHI{i,3};
    eye.signals.dimension=1;
    eye.time=head.time;
    tempo.signals.values=head.time;
    tempo.signals.dimension=1;
    tempo.time=head.time;
    
    vg=parHI(i,4); %vorgain
    strc=head.time(trcHI{i,5}(1)); %%start saccade
    stpc=head.time(trcHI{i,5}(2)); %% end saccade
    
    pr0=[.9 1];%%[gain-pred vor-switch]
    lb=[.1  0];
    ub=[1.5   1];
    
    psac=sacPar(parHI(i,8),1:2);%%saccadic burst paramentrs
    paropt=lsqnonlin(@(p) simMov(p,head,eye,tempo,strc,stpc,vg,psac),pr0,lb,ub);
    optimPar(i,:)=paropt; %%%[pG vsG]
end

save  optimizationRes optimPar












