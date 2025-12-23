function A = replaceNaNInf(A)
% A: 4x4の行列

% nanとinfを0に置き換える
A(isnan(A)) = 0;
A(isinf(A)) = 0;

end