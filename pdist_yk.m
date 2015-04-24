function d=pdist_yk(A,B)
    d=sqrt( bsxfun(@plus,sum(A.^2,2),sum(B.^2,2)') - 2*(A*B') );
end