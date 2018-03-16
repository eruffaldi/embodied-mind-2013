function [r,ds] = groupedepochs(ds)

if nargin == 0
    ds = [];
end
e = [];

e.sync = 1;
e.ciak = 2;
e.relaxup = 3;
e.relaxsit = 5;

epre = [];
epre.sit2up = [6, 10, 14];
epre.up2sit = [8, 12, 16];
epre.legnat = [19]; % BUG see Excel
epre.legin = [21]; % BUG see Excel
e.pre = epre;

epost = [];
epost.legnat = [39,41];
epost.legin = [43]; % twice
epost.sit2up = [44,48,52];
epost.up2sit = [46,50,54];
e.post = epost;
e.lesson = 23:37;
epochs = e;


maxepoch = 56;

epochtype = zeros(maxepoch,1);
epochphase = epochtype; 
epochtrigger = epochtype;
typename = { 'relaxup',3; 'relaxsit',4; 'sync', 1; 'ciak',2 ; 'lesson', 9};
subtype = {  'sit2up',5; 'up2sit',6; 'legnat',7;'legin',8};

trigger1 = [24,30,32,34,37];
trigger2 = [25,26,27,28,29,31,33,35];

allpre = 7:18;
allpost = 44:54;
allprepost = zeros(maxepoch,1);
allprepost(allpre) = 1;
allprepost(allpost) = 2;

legpost = 39:43;
legpre = 19:21;
allleg = zeros(maxepoch,1);
allleg(legpre) = 1;
allleg(legpost) = 2;

epochtrigger(trigger1) = 1;
epochtrigger(trigger2) = 2;

for I=1:size(typename,1)
    f = typename{I,1};
    epochtype(e.(f)) = typename{I,2};
    epochtype(e.(f)) = 1; % other
end

for I=1:size(subtype,1)
    f = subtype{I,1};
    epochtype(e.pre.(f)) = subtype{I,2};
    epochtype(e.post.(f)) = subtype{I,2};
    epochphase(e.pre.(f)) = 2; % pre
    epochphase(e.post.(f)) = 3; %post
end

epochphase(e.lesson) = 4;

r = [];
r.type = epochtype;
r.phase = epochphase;
r.trigger = epochtrigger;
r.epochs = epochs;

if isempty(ds) == 0
    ee = ds.event+1;
    eepochtype = [0;epochtype];
    eepochphase = [0;epochphase];
    eallprepost =[0;allprepost];
eallleg = [0;allleg];
    
    triggerwindowsec = [-10,0];
    ds.etrigger = zeros(length(ds),1);
    ds.eprepost = eallprepost(ds.event+1);
    ds.elegprepost = eallleg(ds.event+1);

    trigger = {trigger1,trigger2};
    
    st = mean(diff(ds.etime));
    triggerwindowsam = floor(triggerwindowsec/st);
    for I=1:2
        t = trigger{I}; 
        for J=1:length(t)
            k = find(ds.event == t(J),1,'first');
            ds.etrigger(k+triggerwindowsam(1):k+triggerwindowsam(2)) = I;
        end
    end
    
    ds.etype = eepochtype(ee);
    ds.ephase = eepochphase(ee);
end
