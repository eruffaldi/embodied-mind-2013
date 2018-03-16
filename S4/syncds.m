

%% Load all files
%load('Subject2_VicDS');
load('Subject4_UsbDS');
load('Subject4_VicNautilusDS');
load('Subject4_NautilusDS');

% ds
%  tsimtime    ttime    eeg               
%    0           0.002    [1x1412866 double]

% vic
%   ttime     teeg             frame        vtime      event
%    18.436    [1x36 double]    7.561e+05    0.10941    0    

% dsu
%  stime       vtime    usbgsr           gsr    seeg         
%    0.039843    0        [1x16 double]    0      [1x16 double]
    

% dsu (usb,250Hz) <- vic (vicon,125Hz) <- ds  (teacher,nautilus,250Hz,othermachine)

% Augmented
% ds
%  tsimtime    ttime    eeg                   + stime  frame event
%    0           0.002    [1x1412866 double]

% vic
%   ttime     teeg             frame        vtime      event     +  stime
%    18.436    [1x36 double]    7.561e+05    0.10941    0    

% dsu 
%  stime       vtime    usbgsr           gsr    seeg         +    ttime frame event
%    0.039843    0        [1x16 double]    0      [1x16 double]

%%
sdt = 1.0/250;
tdt = 1.0/500;
vdt = 0.01;


dsu.etime = dsu.stime(1)+sdt*((1:length(dsu))-1)'; % assuming constantness of EEG

ds.etime = ds.ttime(1)+tdt*((1:length(ds))-1)';

%setimevideo0 = dsu.etime(find(dsu.event==1,1,'first'));

%%
% First instant of non negative vicon time received
e = [];
e.idsu = find(dsu.vtime > 0,1,'first'); % as index in receiver
e.vtime = vic.vtime(e.idsu);
e.ivic = find(vic.vtime == e.vtime,1,'first'); % as index in sender
e.frame = vic.frame(e.ivic); % as frame of vicon
e.setime = dsu.etime(e.ivic);
e.stime = dsu.stime(e.ivic);

firstvtime = e;

dsu.frame = e.frame + floor((dsu.etime-e.setime)/vdt);
dsu.frame(1:e.idsu-1) = 0;

dsu.event = interp1fwd(vic.frame,vic.event,dsu.frame);
dsu.event(isnan(dsu.event)) = 0;

setimevideo0 = dsu.etime(find(dsu.event==1,1,'first'));
vic.setime = (vic.vtime-e.vtime)+e.setime;

%% sync ds with vic using ttime in vic. Compute frame and event
e = [];
e.ivic = find(vic.ttime > 0,1,'first'); % as index in receiver
e.frame = vic.frame(e.ivic); % as frame of vicon
e.ttime = vic.ttime(e.ivic);
e.vtime = vic.vtime(e.ivic);
e.setime = vic.setime(e.ivic);
e.ids = find(ds.ttime == e.ttime,1,'first'); % as index in sender
e.tetime = ds.etime(e.ids);

firsttime = e;

ds.frame = e.frame + floor((ds.etime-e.tetime)/vdt);
ds.frame(1:e.ids-1) = 0;

ds.event = interp1fwd(vic.frame,vic.event,ds.frame);
ds.event(isnan(ds.event)) = 0;
tetimevideo0 = ds.etime(find(ds.event==1,1,'first'));

ds.setime = e.setime + (ds.etime-e.tetime);

ds = dssetparam(ds,'etime2video',tetimevideo0);
dsu = dssetparam(dsu,'etime2video',setimevideo0);


dsu.tetime = dsu.etime + (e.tetime-e.setime);

%%
% Import
dssa = [dsu.seeg,dsu.event]';
dsse = [dsu.event]';

dsta = [ds.teeg,ds.event]';
dste = [ds.event]';

%%
teacher_framebasedtime = ds.etime(end)-ds.etime(1)
teacher_windowsbasedtime = ds.ttime(end)-ds.ttime(1)
teacher_realrate = (teacher_framebasedtime./teacher_windowsbasedtime)/tdt
student_framebasedtime = dsu.etime(end)-dsu.etime(1)
student_windowsbasedtime = dsu.stime(end)-dsu.stime(1)
student_realrate = (student_framebasedtime./student_windowsbasedtime)/sdt

ts_deltawindowsduration = teacher_windowsbasedtime - student_windowsbasedtime
ts_deltaframeduration = teacher_framebasedtime - student_framebasedtime
