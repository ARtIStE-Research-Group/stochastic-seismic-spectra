function X = sss_lyap(A, Q)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Solve A X + X A' + Q = 0. Uses lyap when available, otherwise a
% Kronecker fallback suitable for the small SSS state dimensions.

if exist('lyap', 'file') == 2
    try
        X = lyap(A, Q);
        return;
    catch
    end
end

n = size(A, 1);
M = kron(eye(n), A) + kron(A, eye(n));
rhs = -Q(:);
X = reshape(M \ rhs, n, n);
X = real(X);
end

