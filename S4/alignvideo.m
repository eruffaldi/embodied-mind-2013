

a = imread('Subject4_Markers.png');
imshow(a);
p = ginput(4);

%% pts are taken as: camera_fissa camera_mobile tavolo_grande tavolo_pc

p1 =[
      496.0000  495.0000
  431.0000  488.0000
  487.0000  473.0000
  547.0000  479.0000
];


%% pts from the vsk marker information (use automatic from ema)
p2 = [0 0 0; 0 0 -277.989; 0 360.296 -279.666; 1.69639 358.81 -2.29506];

%%
ecalib = opencvcalib(p2,p1,size(a));

save('ecalib','ecalib');

%%
% Test

up1 = cvproject(p2,ecalib);
hold off
imshow(a);
hold on
line([up1(:,1) ;up1(1,1)],[up1(:,2); up1(1,2)]);
hold off
%%
p3 = [0 0 0;  -300 0 0; NaN NaN NaN; 0 0 0 ; 0 300 0; 500 300 0 ];
   
ecalib.dist = ecalib.dist*0;
up3 = cvproject(p3,ecalib);

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