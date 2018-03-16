

%% build a csv file with: latency 
ecommon = csvreadany('Subject1.csv',',',1:4);
ecommon.event = ecommon.Sepoch;
ecommon.latency = zeros(length(ecommon),1);

step = 1.0/250;

%% now match using timing aligned
estu = ecommon;
for I=1:length(estu)
    ii = find(dsu.event == estu.event(I),1,'first');
    estu.latency(I) = (ii-1)*step; % expressed in relative time samples
end



%% now match
etea = ecommon;
for I=1:length(etea)
    ii = find(ds.event == etea.event(I),1,'first');
    etea.latency(I) = (ii-1)*step; % expressed in relative time samples
end
