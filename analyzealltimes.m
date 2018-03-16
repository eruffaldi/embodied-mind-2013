
sessions = arrayfun(@(x) sprintf('S%d',x),1:8,'UniformOutput',false);
basepath = '/Users/eruffaldi/Documents/workdata/EmbeddedWorkshop/';
addpath([basepath 'code']);

ss = [];
for I=1:8
    p = [basepath sessions{I}];
    [r,subject,files] = dsexp_curexp(p);
    
    si = files;
    si.subject = subject;
    si.path = p;
    ss = [ss;si];
end
%%
ds = struct2dataset(ss);