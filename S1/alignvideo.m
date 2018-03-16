

a = imread('Subject1_Video.png');
imshow(a);
p = ginput(4)

%% pts are taken as: camera_fissa camera_mobile tavolo_grande tavolo_pc

p1 =[
  615.4934  510.9636
  547.6788  504.1821
  599.3874  487.2285
  662.1159  492.3146];


%% pts from the vsk marker information (use automatic from ema)
p2 = [0 0 0; 0 0 -277.989; 0 360.296 -279.666; 1.69639 358.81 -2.29506];


%%
cm = [ 454.8373889     0.          350.51008131
    0.          421.8303675   642.7467917 
    0.            0.            1.        ];
dist = [-0.01459674 -0.05297143 -0.07277375 -0.00250977 -0.07398006];
rvecs =[ 2.23588268,
        1.78687919,
        1.07388639];
tvecs =[  915.64211164,
        -443.80343492,
        1597.12352165];
    
calib = [];
calib.camera = cm;
calib.dist = dist;
calib.t = tvecs;
calib.R = rodrigues(rvecs);

    
