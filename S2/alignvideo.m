

a = imread('Subject2_Markers.png');
imshow(a);
p = ginput(4);

%% pts are taken as: camera_fissa camera_mobile tavolo_grande tavolo_pc

p1 =[
    785.7500  755.7500
  686.7500  745.2500
  773.7500  719.7500
  866.7500  727.2500];


%% pts from the vsk marker information (use automatic from ema)
p2 = [0 0 0; 0 0 -277.989; 0 360.296 -279.666; 1.69639 358.81 -2.29506];

%%
ecalib = opencvcalib(p2,p1,size(a));

%%
% Test

up1 = cvproject(p2,ecalib);
