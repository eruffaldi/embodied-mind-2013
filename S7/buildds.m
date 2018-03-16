%% Modelli Simulink:
% Nautilus (500Hz)
% time base eeg[32]

% NautilusVIcon (100Hz) = 39
% - udp Natilus: time base eeg[32]
% - frame
% - udp send to usb: time base event

% Usb (250Hz grouped by 8) = 38
% - time
% - base
% - udp: time base event (from vicon)
% - skin: 16 (#2 is good)
% - eeg: 16

%prepare dataset
load('Subject7_VicNaut.mat')
%%
vd = EEGNVicon(2:end,:)';

ds = dataset();
ds.ttime = vd(:,1);
ds.teeg = vd(:,3:end); % NO MEANINGFUL
ds.frame = vd(:,38);
ds.vtime = vd(:,39);
ds.event = vd(:,41);

dstbase = vd(1,2);
dsvbase = vd(1,37);

m = [];
m.vtimebase = dsvbase;
m.ttimebase = dstbase;
ds = set(ds,'UserData',m);
vic = ds;
save('Subject7_VicNautDS','vic');
