
data.mat includes data of 16 subjects acquired in Pavia --> trcHI, parHI
trcHI=[eyeVelocity headVelocity eyePos headPos sac_idx sogNum]  includes head impulse signals and indices of beginning and end of the corrective saccade
parHI=[headPeakAcc headPeakVel sacLatency gain comp_error sacc_amplitude saccPeakVel sogNum]  includes parameters of the head impulse and of the corrrective saccade

optimization.m optimize pG and vsG parameters (of data included in data.mat) and save results in optimizationRes.mat -->optimPar=[pG vsG]

simulateSubject(nsub) shows simulation results for the subject nsub 

modelOpt.mdl is the simulink model

A simulation was already done you can see the results using simulateSubject(nsub)