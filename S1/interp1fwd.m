function Yo = interp1fwd(Xi,Yi,Xo)

index=floor(interp1(Xi(:,1),(1:size(Xi,1)),Xo));
Yo = nan(length(index),size(Yi,2));
Yo(isnan(index) == 0,:) = Yi(index(isnan(index) == 0),:);
