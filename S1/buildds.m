

% nautilus
% 34 = windows time base, windows time, map 
% 
% 35 = usb data
% time
% base
% udp: otime
%
% 16 amp1 = EEG
% 16 amp2 = skin su channel 2

%prepare dataset

%%
nd = squeeze(a.ans.Data);

ds = dataset();
ds.time = nd(:,1);
dsbase = nd(1,2);
ds.eeg = nd(:,3:end);
m = [];
m.timebase = dsbase;
ds = set(ds,'UserData',m);


%%
ud =  squeeze(b.ans.Data)';
dsu = dataset();
dsu.time = ud(:,1);
dsubase = ud(:,2);
dsu.vtime = ud(:,3);
dsu.usbgsr= ud(:,4:19);
dsu.gsr = dsu.usbgsr(:,2);
dsu.eeg = ud(:,20:end);
m = [];
m.timebase = dsubase;
dsu = set(dsu,'UserData',m);
