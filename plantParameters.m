
%%%%load plant parameters

%%plant
tz=0.08;
t1=.224;
t2=.013;

w=200;
z=1.2;

%%%common path
a1=1.61;
a2=0.72;
ts=tz;
A=1;
B=t1*t2/ts;
C=t1+t2-ts-(t1*t2/ts);

B=B*a1;
C=C*a2;

