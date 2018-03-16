addpath TrajPic;

load('ecaliball');
ecalib = ecaliball;
ecalib.rvec = ecalib.rvec(3,:);
ecalib.t = ecalib.t(3,:);

m =load('markers');

a = imread('Subject3_Presit.png');

%%
p3 = [m.markpresit.Student3_ShR;m.markpresit.Student3_ShL;m.markpresit.Student3_HipR;m.markpresit.Student3_ToeR;m.markpresit.Student3_KneeR;m.markpresit.Student3_HipL;m.markpresit.Student3_ToeL;m.markpresit.Student3_KneeL;m.markpresit.Student3_HeelL;m.markpresit.Student3_HeelR];

% following if now using the template
%p3 = [-p3(:,3),p3(:,2),p3(:,1)];

up3 = cvproject(p3,ecalib);


hold off
imshow(a);

p33x = [0:10:500]';
p33x = [p33x, 0*ones(length(p33x),1), 0*ones(length(p33x),1)];
up33x = cvproject(p33x,ecalib);

p33y = [p33x(:,2) p33x(:,1) p33x(:,3)];
up33y = cvproject(p33y,ecalib);

p33z = [p33x(:,3) p33x(:,2) p33x(:,1)];
up33z = cvproject(p33z,ecalib);

hold on
scatter(up33x(:,1),up33x(:,2),'r');
scatter(up33y(:,1),up33y(:,2),'g');
scatter(up33z(:,1),up33z(:,2),'b');

scatter(up3(:,1),up3(:,2));
hold off