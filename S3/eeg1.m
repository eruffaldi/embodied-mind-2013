%%
preleg=19:22
postleg=39:43

mask = zeros(56,1);
mask(preleg) = 1;
mask(postleg) = 2;
emask = [0; mask];

ueventin = emask(dsu.event+1);
teventin = emask(ds.event+1);

% O1 to be removed = ch 10


% stand is 89sec == 3, equals
% sit is 52sec == 5
%  3      3       16854           19.625     87.037       16854          67.412    
%    4      4        2540           87.041     97.197        2540          10.156    
%    5      5       15466           97.201     159.06       15466           61.86    
%    6      6        2164           159.07     167.72        2164           8.652    

% 
%   19    19        6142           412.91     437.48        6142          24.564    
%     20    20        3700           437.48     452.28        3700          14.796    
%     21    21        9655           452.28      490.9        9655          38.616    
%     22    22        2823            490.9     502.19        2823          11.288    
%23    23       11880           502.19     549.71       11880          47.516    
% 
%   39    39        1958           1360.9     1368.7        1958           7.828    
%     40    40         602           1368.8     1371.2         602           2.404    
%     41    41        3798           1371.2     1386.3        3798          15.188    
%     42    42        4155           1386.4       1403        4155          16.616    
%     43    43        2730             1403     1413.9        2730          10.916 
%  44    44       10407           1413.9     1455.5       10407          41.624    
% In baseline ch10=O1 and ch13=P6

%% Looking at Baseline Relax 3 and 5
% Durations by event in samples => 
dsug = grpstats(dsu,'event',{@min,@max,@numel,@(x) max(x)-min(x)},'DataVars',{'etime'});



% 1) selected preleg [19,22]
% 2) removed with auto rejection on channel
% 3) inspecting 100 seconds
% 4) 

%% Pre
[lpre,lpost] = getlegtimes();
rangesetime = lpre.rangesetime - lpre.etime;
ranges = lpre.rangesvtime + lpre.vtime;
legleft = lpre.legleft;
isini = lpre.isini;
for I=1:length(ranges)
    f=  figure;
    
     pop_spectopo( EEG, 1, 1000*rangesetime(I,:), 'EEG', 'percent',100,'freq',[6 12 14 20],'freqrange',[2 40]);
    set(f,'Name',sprintf('Pre Range %d, %d-%d of video, legleft %d, inibit %d',I,ranges(I,1),ranges(I,2),legleft(I),isini(I)));
    ylim([-60 40]);
exportfig(f,sprintf('pre%d-legleft%d-inibit%d.pdf',I,legleft(I),isini(I)),'Color','rgb');
end

%% Post
rangesetime = lpost.rangesetime - lpost.etime + 3;
ranges = lpost.rangesvtime + lpost.vtime;
legleft = lpost.legleft;
isini = lpost.isini;


for I=1:length(ranges)
    f=  figure;
    
     pop_spectopo( EEG, 1, 1000*rangesetime(I,:), 'EEG', 'percent',100,'freq',[6 12 14 20],'freqrange',[2 40]);
    set(f,'Name',sprintf('Post Range %d, %d-%d of video, legleft %d, inibit %d',I,ranges(I,1),ranges(I,2),legleft(I),isini(I)));
    ylim([-60 40]);
exportfig(f,sprintf('post%d-legleft%d-inibit%d.pdf',I,legleft(I),isini(I)),'Color','rgb');
end



