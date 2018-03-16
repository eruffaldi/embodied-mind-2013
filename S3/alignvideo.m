
% Order: fissa mobile grande pc
a = imread('Subject3_Markers.png');
imshow(a);
p = ginput(4);



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
p3 = [0 0 0;  -300 0 0; NaN NaN NaN; 0 0 0 ; 0 300 0; -300 300 0 ];
   
up3 = cvproject(p3,ecalib);


hold off
imshow(a);
hold on
line([up3(:,1) ],[up3(:,2)]);
hold off