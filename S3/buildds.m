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

%%
nd = load('Subject3_Nautilus.mat');
nd = nd.ans';

ds = dataset();
ds.tsimtime = nd(:,1);
ds.ttime = nd(:,2);
dstbase = nd(1,3);
ds.teeg = nd(:,4:end-3);
ds.acc = nd(:,end-3:end);
m = [];
m.ttimebase = dstbase;
ds = set(ds,'UserData',m);
save('Subject3_NautilusDS.mat','ds');

%%
vd = EEGNVicon(2:end,:)';

ds = dataset();
ds.ttime = vd(:,1);
%ds.teeg = vd(:,3:end); % NO MEANINGFUL
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
save('Subject3_VicNautilusDS','vic');

%%
ud = EEGUsb(2:end,:)';

dsu = dataset();
dsu.stime = ud(:,1);
dsu.vtime = ud(:,3);
dsu.usbgsr= ud(:,6:21);
dsu.gsr = dsu.usbgsr(:,2);
dsu.seeg = ud(:,22:end);

m = [];
m.stimebase = ud(1,2);
m.vtimebase = ud(1,4);
dsu = set(dsu,'UserData',m);
save('Subject3_UsbDS','dsu');