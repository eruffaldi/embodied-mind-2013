
k = unique(dsu.event);
k = k(k > 0);
a = dataset();
a.event = k;
setime = [];
sindex = [];
for I=1:length(k)
    ii = find(dsu.event == k(I));
    setime(I,:) = dsu.etime([ii(1),ii(end)]);
    sindex(I,:) = [ii(1),ii(end)];
end
a.setime = setime;
a.sindex = sindex;

a = a((a.setime(:,2)-a.setime(:,1)) < 30,:);

setime2video = dsgetparam(dsu,'etime2video');
videotime2filevideotime = 5;
a.videotime = a.setime + setime2video + videotime2filevideotime;
a.tetime = dsu.tetime(a.sindex);
a.tindex = findrange(ds.etime,a.tetime);

actions = {''};
phases = {''};
a.prepost = ones(length(a),1);
a.action = ones(length(a),1);

dlmwrite('Subject4phasesmat.csv',[a.prepost,a.videotime,a.action],'delimiter',',');


%% First try to look at the 
kT = eeglabselect('S4T');
kS = eeglabselect('S4S');
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
    pop_spectopo(QEEG, 1, tS(I,1:2)*1000, 'EEG' , 'freq', freq, 'freqrange',freqrange,'electrodes','off');%'maplimits',[-20,40]);
    cc = get(gcf,'Children');
    title(cc(end),sprintf('ST & TE #%d - %s - %s - VidetoTime %3.0f-%3.0f (%3.0fs)', I,phases{a.prepost(I)},actions{a.action(I)},a.videotime(I,1),a.videotime(I,2),a.videotime(I,2)-a.videotime(I,1)));

    subplot(1,2,2);
    QEEG = ALLEEG(kT);
    pop_spectopo(QEEG, 1, tT(I,1:2)*1000, 'EEG' , 'freq', freq, 'freqrange',freqrange,'electrodes','off'); %'maplimits',[-20,40]);
    export_fig(gcf,sprintf('event%d.pdf',a.event(I)),'-transparent','-pdf');
end

