function [v,c]=voronoin_bnd(pts_mat)
    BRD_RAT = 0.1; % border to range ratio;
    [NUM,DIM] = size(pts_mat);
    
    maxV    = max(pts_mat);
    minV    = min(pts_mat);
    bndL    = minV-BRD_RAT*(maxV-minV); % Mirror lines
    bndU    = maxV+BRD_RAT*(maxV-minV);
    [~,c]   = voronoin(pts_mat,{'QJ'});
    openID  = cellfun(@(x) any(x==1), c); % Points with unbounded voronois
        
    if(DIM==2)
        X       = pts_mat(:,1);
        Y       = pts_mat(:,2);
        mirX    = pts_mat(openID,1);
        mirY    = pts_mat(openID,2);
        
        XX      = [X;      2*bndL(1)-mirX;     2*bndU(1)-mirX;   mirX;      mirX];
        YY      = [Y;      mirY;          mirY;          2*bndL(2)-mirY;     2*bndU(2)-mirY];
        [v,c]   = voronoin([XX,YY]);
        c   = c(1:NUM);
    elseif(DIM==3)
        X       = pts_mat(:,1);
        Y       = pts_mat(:,2);
        Z       = pts_mat(:,3);
        mirX    = pts_mat(openID,1);
        mirY    = pts_mat(openID,2);
        mirZ    = pts_mat(openID,3);
        
        XX      = [X;      2*bndL(1)-mirX;  2*bndU(1)-mirX;     mirX;               mirX;           mirX;               mirX];
        YY      = [Y;      mirY;            mirY;               2*bndL(2)-mirY;     2*bndU(2)-mirY; mirY;               mirY;];
        ZZ      = [Z;      mirZ;            mirZ;               mirZ;               mirZ;           2*bndL(3)-mirZ;     2*bndU(3)-mirZ;];
        [v,c]   = voronoin([XX,YY,ZZ]);
        c   = c(1:NUM);
    end

end