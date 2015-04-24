function pts_out=fracSingle(pts_tar,mat_p1,iter)
nT      = size(pts_tar,1);
D       = max(size(mat_p1));
cellOut = cell(nT,1);
    parfor i=1:nT
        mat_p1T  = reshape(mat_p1(randperm(numel(mat_p1))),size(mat_p1));
        [x y z] = ind2sub(size(mat_p1T),find(mat_p1T));
        pts_tmp = (([x y z] -0.5 - D/2)/D)/(D^(iter-1));
        pts_tmp = [ pts_tmp(:,1)+pts_tar(i,1)...
                    pts_tmp(:,2)+pts_tar(i,2)...
                    pts_tmp(:,3)+pts_tar(i,3)];
        cellOut{i} = pts_tmp;
    end
pts_out=cell2mat(cellOut);
end