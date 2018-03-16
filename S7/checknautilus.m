%%
nau = vic(logical([1;diff(vic.ttime) > 0]),:);
naufreq = 1.0./median(diff(nau.ttime))


%%
tdff  = diff(vic.ttime);
xdiff = diff(vic.teeg);

%%
Fs = 500;
teeg = interp1(nau.ttime,nau.teeg,min(nau.ttime):(1.0/Fs):max(nau.ttime));

%%
length(ds)/(ds.ttime(end)-ds.ttime(1))

%%
Fs = 500;
teeg = interp1(ds.ttime,ds.teeg,min(ds.ttime):(1.0/Fs):max(ds.ttime));
%%
teeg = ds.teeg;
%%
[f,p] = makepsd(teeg,Fs);
%%
plot(f,10*log10(p))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')
