function [q_vec, Dq_vec]=call_BFM(pts_mat)
% Multifractal dimension estimation with the Barycentric Fixed Mass method
% Covers a given 2D/3D point distribution with equal mass circles/spheres
% centered at each point and then applies two additional criteria: 
% 1) Barycentric: A circle/sphere is considered only if its center point is
% the closest point to its barycenter.
% 2) Non-Overlapping: Barycentric circles/spheres are randomly chosen such 
% that the overlap is minimized while maximizing the overall coverage
%
% For detailed information check the following publication:
% Y. Kamer, G. Ouillon and D. Sornette (2013)
% Barycentric fixed-mass method for multifractal analysis
% http://arxiv.org/abs/1305.7384
% 
% Function syntax
% pts_mat   : N by D matrix containing coordinates of N points in D dimensions. 
%             D can be 2 or 3.
% prm       : A structure containing various parameters of the method,
%             Explained in the comments below
%
% Y.Kamer
% Zurich, 20150421
%
% Coded & Tested on 7.12.0(R2011a)
%%%
%
% Example : Generate a 3D monofractal with D=1.58 and estimate D(q) vs q using BFM
% mat_p1            = [0 1; 0 0];
% mat_p1(:,:,2)     = [1 0; 1 0];
% pts_mat           = recursiveFrac(mat_p1,7); 
% [q_vec, Dq_vec]   = call_BFM(pts_mat);
%
%%%
%%
prm.tauVec         = [-5:-1 0.1 1:3]; 
% tau values should be chosen so as to scan the q range of interest, none of
% the elements should be equal to zero. Remember, too small or too high qs
% can be unstable. ALWAYS validate the accuracy with synthetics!
prm.MinMass       = 2;      
% minimum mass (closest ith neighbour) to be conisder
prm.LogStep       = 0.05;
% logarithmic step for mass increment mi= MinMass * 10^(i*LogStep)
prm.MinSphAvg     = 2;      
% minimum number of spheres to average R (Equation 3)
prm.massVec       = []; %[10 50 100 500 1000]
% user spacified ascending mi vector (for example if you need small steps 
% at small mass ranges) by-passed if empty

prm.DO_PLOT       = 1;      %Option to plot the average R vs Mass curves and D(q) vs q
prm.SAVE_MRTO     = 0;      %Option to save the average R vs Mass curves
prm.DATA_ID       = '';     %Suffix of the mat file for saving the output

%% Call the BFM function

D   = size(pts_mat,2);

    if(D==3 || D==2)
        [q_vec, Dq_vec]   = bfmFinalFx(pts_mat,prm);
    else
        disp('Dimension of input should be 2 or 3!');
    end

end