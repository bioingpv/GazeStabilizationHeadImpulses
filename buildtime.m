function  time = buildtime(inarray, samp_freq)
%function  time = buildtime(inarray, samp_freq)
%Build a time array for a given data array
%SR 2000

if nargin == 0
   help buildtime
   return
end

if nargin == 1
   answer = inputdlg( 'Enter the sampling frequency (Hz): ', ...
      'Build time array',1,{'500'});
   samp_freq=str2num(answer{1});
end

time = (0:(length(inarray)-1))'/samp_freq;
