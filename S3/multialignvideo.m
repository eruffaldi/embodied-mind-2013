
ips = {};
sizes = {};

run('../S1/markerpts.m');
if shape(1) == 1080
    p1(:,1) = p1(:,1)*720/1080;
    p1(:,2) = p1(:,2)*1280/1980;
end
ips{1} = p1;

run('../S2/markerpts.m');
ips{2} = p1;

run('../S3/markerpts.m');
ips{3} = p1;

run('../S4/markerpts.m');
ips{4} = p1;

run('../S6/markerpts.m');
ips{5} = p1;

run('../S6/markerpts.m');
ips{6} = p1;

%% pts from the vsk marker information (use automatic from ema)
p2 = [0 0 0; 0 0 -277.989; 0 360.296 -279.666; 1.69639 358.81 -2.29506];

%IMAGE:  camera_fissa camera_mobile tavolog_grande tavolo_pc
%CSV: panchetto:tavolo_grande			panchetto:tavolo_pc			panchetto:camera_fissa			panchetto:camera_mobile
pW = [-924.429	195.913	-27.3042	
    -644.583	208.613	-24.3331	
    -629.642	-149.944	-28.7056	
    -906.634	-162.256	-27.5427];
pW = [pW(3,:);pW(4,:);pW(1,:);pW(2,:)];
pW(:,3) = -27.5;

ipo = {p2,p2,pW,p2,p2,p2};
%%
ecaliball = opencvcalib(ipo,ips,[720,1280]);

save('ecaliball','ecaliball');

ecalib = ecaliball;
ecalib.rvec = ecalib.rvec(3,:);
ecalib.t = ecalib.t(3,:);

%%
% Test

a = imread('Subject3_Markers.png');


%%
% XYZ

p33x = [-500:10:500]';
p33x = [p33x, 0*ones(length(p33x),1), 0*ones(length(p33x),1)];
up33x = cvproject(p33x,ecalib);

p33y = [p33x(:,2) p33x(:,1) p33x(:,3)];
up33y = cvproject(p33y,ecalib);

p33z = [p33x(:,3) p33x(:,2) p33x(:,1)];
up33z = cvproject(p33z,ecalib);

hold off
imshow(a);
hold on
line([up3(:,1) ],[up3(:,2)]);
scatter(up33x(:,1),up33x(:,2),'r');
scatter(up33y(:,1),up33y(:,2),'g');
scatter(up33z(:,1),up33z(:,2),'b');
hold off