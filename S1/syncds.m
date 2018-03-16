
%% Load all files
load('Subject1_VicDS');
load('Subject1_UsbDS');
load('Subject1_NautilusDS');

%%
sdt = 1.0/250;
tdt = 1.0/500;
vdt = 0.01;
ds.ttime = ds.time;
dsu.stime = dsu.time;
ds.etime = ds.time(1)+tdt*((1:length(ds))-1)'; % assuming constantness of EEG
dsu.etime = dsu.time(1)+sdt*((1:length(dsu))-1)'; % assuming constantness of EEG
vic.etime = vic.frame*vdt;

%%
% Student is USB with Vicon time and its own Time
iviclast = find(diff(dsu.vtime) > 0,1,'last');
usbtimelast = dsu.etime(iviclast);
usbframelast = vic.frame(end);

usbframeelapsed = floor((usbtimelast-dsu.etime(1))/vdt);

usbframefirst = usbframelast-usbframeelapsed;

dsu.frame = usbframefirst + floor((dsu.etime-dsu.etime(1))/vdt);

%%
% Nautilus is synchronized with first vic.event (except for some delay)
naufirst_vicindex = find(vic.event == 1,1,'first');
naufirst_vicframe = vic.frame(naufirst_vicindex);

naufirst_stuindex = find(dsu.frame == naufirst_vicframe,1,'first');
if isempty(naufirst_stuindex)
    disp('not exact');
    naufirst_stuindex = find(dsu.frame < naufirst_vicframe,1,'last');
     %   [dummy,naufirst_stuindex] = min(abs(dsu.frame-naufirst_vicframe));
end

naufirst_nautime = ds.etime(1);
naufirst_stutime = dsu.etime(naufirst_stuindex);

ds.stime = (ds.etime-naufirst_nautime)+naufirst_stutime;
ds.frame = naufirst_vicframe + floor((ds.etime-ds.etime(1))/vdt);


%%
%
% Associate Event to Vicon
dsu.event = interp1fwd(vic.frame,vic.event,dsu.frame);
ds.event = interp1fwd(vic.frame,vic.event,ds.frame);
dsu.event(isnan(dsu.event)) = 0;
ds.event(isnan(ds.event)) = 0;


%%
% Import
dssa = [dsu.eeg,dsu.event]';
dsta = [ds.eeg,ds.event]';
dsse = [dsu.event]';
dste = [ds.event]';




%% TODO use sync point

teacher_framebasedtime = ds.etime(end)-ds.etime(1)
teacher_windowsbasedtime = ds.ttime(end)-ds.ttime(1)
teacher_realrate = (teacher_framebasedtime./teacher_windowsbasedtime)/tdt
student_framebasedtime = dsu.etime(end)-dsu.etime(1)
student_windowsbasedtime = dsu.stime(end)-dsu.stime(1)
student_realrate = (student_framebasedtime./student_windowsbasedtime)/sdt

ts_deltawindowsduration = teacher_windowsbasedtime - student_windowsbasedtime
ts_deltaframeduration = teacher_framebasedtime - student_framebasedtime

