
% Characterization of Events
%
% Relaxation
%   standing up/down!
% Inhibition: pre/post
%   events from list
% Standing: pre/post
% Lesson
%   events from highlgihts
actions = {'starting','approach','legnat','instruct','legini','away','other','pull'};
phases = {'pre','post','other'};
a = csvreadany('Subject3phasesmat.csv',',',[1:4],{'prepost','tin','tfin','action'});
a.videotime = [a.tin,a.tfin];
% Map timings 

setime2video = dsgetparam(dsu,'etime2video');
a.setime = a.videotime - setime2video;

tetime2video = dsgetparam(ds,'etime2video');
a.tetime = a.videotime - tetime2video;


a.sindex = findrange(dsu.etime,a.setime);
a.tindex = findrange(ds.etime,a.tetime);



%% First try to look at the 
kT = eeglabselect('S3T');
kS = eeglabselect('S3S');
field = 'setime';
tS = a.(field);
freqrange = [2 45];
field = 'tetime';
tT = a.(field);
freq = [6 10 15 22]; % delta, alpha, beta, gamma high
for I=1:size(a)
    figure(1+I);
    set(gcf,'Position',[0 0 800 600])
    QEEG = ALLEEG(kS);
    subplot(1,2,1);
    pop_spectopo(QEEG, 1, tS(I,1:2)*1000, 'EEG' , 'freq', freq, 'freqrange',freqrange,'electrodes','off');
    cc = get(gcf,'Children');
    title(cc(end),sprintf('ST & TE #%d - %s - %s - VidetoTime %3.0f-%3.0f (%3.0fs)', I,phases{a.prepost(I)},actions{a.action(I)},a.videotime(I,1),a.videotime(I,2),a.videotime(I,2)-a.videotime(I,1)));

    subplot(1,2,2);
    QEEG = ALLEEG(kT);
    pop_spectopo(QEEG, 1, tT(I,1:2)*1000, 'EEG' , 'freq', freq, 'freqrange',freqrange,'electrodes','off');
    export_fig(gcf,sprintf('event%d.pdf',I),'-transparent','-pdf');
end

