function [pre,post] = getlegtimes()


video2etime =  1.3812;
vtimestart = 06*60+35;
etimepart = 413; % 9 is because the cut (at 7 sec) is 9 seconds before our cut
legleft = [0,0,1,1,1];
isini = [0,1,0,1,1];
ranges = [20,24; 32,34; 49,55; 62,68; 73,80];
rangesetime = (ranges + vtimestart + video2etime);

pre = [];
pre.legleft = legleft;
pre.isini = isini;
pre.rangesvtime = ranges;
pre.vtime = vtimestart;
pre.etime = etimepart;
pre.video2etime = video2etime;
pre.rangesetime = rangesetime;

 
vtimestart = 22*60+31;
etimepart = 1360;
legleft = [0,0,0,0];
isini = [0,0,1,1];
ranges = [05,10; 14,18; 30,34;40,44];
rangesetime = (ranges + vtimestart + video2etime);

post = [];
post.legleft = legleft;
post.isini = isini;
post.rangesvtime = ranges;
post.vtime = vtimestart;
post.etime = etimepart;
post.video2etime = video2etime;
post.rangesetime = rangesetime;
