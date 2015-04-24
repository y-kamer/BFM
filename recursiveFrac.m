function pts_out=recursiveFrac(mat_p1,iter)
DO_PLOT = 0;
if(DO_PLOT)
figure;
clr=jet(iter);
end
    for i=1:iter
        if(i==1)
            pts_out=fracSingle([0 0 0],mat_p1,i);
        else
            %mat_p1  = reshape(mat_p1(randperm(numel(mat_p1))),size(mat_p1));
            pts_out=fracSingle(pts_out,mat_p1,i);
        end
        if(DO_PLOT)
            scatter3(pts_out(:,1),pts_out(:,2),pts_out(:,3),...
                ones(size(pts_out(:,1)))*(iter-i+2)*1,'ok',...
                'markeredgecolor',clr(i,:),...
                'markerfacecolor',clr(i,:));
            hold on;
        end
    end
end