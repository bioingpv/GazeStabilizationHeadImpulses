function res=simMov(p,head,eye,tempo,strc,stpc,vg,parsac)

plantParameters

smp=500;
ff=50;
[bf,af]=butter(4,ff/(smp/2));


vs=p(2); %vor switch
heg=p(1);% head estimate gain
Bm=parsac(1);
Bk=parsac(2);

options = simset('SrcWorkspace','current');
sim('modelOpt',[],options)

a=find(sw==1);
ep=filtfilt(bf,af,ep);
dt=derivata(ep,1/500);
dt1=dt(a(1):a(end));
sm=derivata(psim,1/500);
sm1=sm(a(1):a(end));

[~,m]=max(dt1);
[~,m1]=max(sm1);
%res=sqrt((dt(aaa(1):aaa(end))-sm(aaa(1):aaa(end))).^2);
res=sqrt((dt(m+a(1)-10:m+a(1)+10)-sm(m1+a(1)-10:m1+a(1)+10)).^2);
%res=sqrt((ep(a(1):a(end))-psim(a(1):a(end))).^2);