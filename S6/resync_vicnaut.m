%%
load('Subject6_VicNautilusDS');
load('Subject6_NautilusDS');

%%
dt = [diff(vic.ttime);0];
udt = vic.ttime(dt > 0);
edt = vic.event(dt > 0);
ds.event = interp1fwd(udt,edt,ds.ttime);