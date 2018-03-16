%%
load('filterBW4GSR');
dsu.gsrf = filter(Hd,dsu.gsr);
dsu.gsrf(dsu.gsrf < 0) = NaN;


%%
[r,dsu] = groupedepochs(dsu);


%% phase = 1 (other), 2 (pre), 3 (post)
plotyy(dsu.etime,dsu.gsrf,dsu.etime,dsu.ephase);
xlabel('Time from g-tec sampling (s)');
title('GSR filtered on left, phase (other,pre,post,lesson)');

%% phase = 1 (other), 2 (pre), 3 (post)
plotyy(dsu.etime,dsu.gsrf,dsu.etime,dsu.etrigger);
xlabel('Time from g-tec sampling (s)');
title('GSR filtered on left, trigger');

%% phase = 1 (other), 2 (pre), 3 (post)
apre = dsu(dsu.eprepost == 1,:);
apost = dsu(dsu.eprepost == 2,:);



figure(1)
plot(apre.etime-apre.etime(1),apre.gsrf,'r');
hold on
plot(apost.etime-apost.etime(1),apost.gsrf,'g');
hold off
legend({'Pre','Post'})
ylabel('GSR Filtered');
xlabel('Time (sec)');
% figure(3)
% plotyy(apre.etime-apre.etime(1),apre.gsrf,apre.etime-apre.etime(1),apre.event);
% hold on
% plotyy(apost.etime-apost.etime(1),apost.gsrf,apost.etime-apost.etime(1),apost.event);
% hold off
% legend({'Pre','Post'})
% ylabel('GSR Filtered');
% xlabel('Time (sec)');

figure(2)
plot(apre.etime-apre.etime(1),apre.event,'r');
hold on
plot(apost.etime-apost.etime(1),apost.event,'g');
hold off
legend({'Pre','Post'})
ylabel('Event');
xlabel('Time (sec)');


%%
plot(dsu.gsrf)



%%
apre = dsu(dsu.elegprepost == 1,:);
apost = dsu(dsu.elegprepost == 2,:);

[lpre,lpost] = getlegtimes();

lpre.rangesreletime = lpre.rangesetime - apre.etime(1);
lpost.rangesreletime = lpost.rangesetime - apost.etime(1);

figure(1)
plot(apre.etime-apre.etime(1),apre.gsrf,'r');
hold on
plot(apost.etime-apost.etime(1),apost.gsrf,'g');
legend({'Pre','Post'})
scatter(lpre.rangesreletime(:,1),2e5*ones(length(lpre.rangesreletime),1),'m*');
scatter(lpre.rangesreletime(:,2),2e5*ones(length(lpre.rangesreletime),1),'m+');
hold on
scatter(lpost.rangesreletime(:,1),2e5*ones(length(lpost.rangesreletime),1),'c*');
scatter(lpost.rangesreletime(:,2),2e5*ones(length(lpost.rangesreletime),1),'c+');
hold off
ylabel('GSR Filtered');
xlabel('Time (sec)');