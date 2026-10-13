function c = sss_abs_accel_vector(SYS)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Observation vector for absolute structural acceleration, up to a sign.

c = zeros(1, SYS.n);
c(SYS.idx.x) = SYS.alpha * SYS.ws^2;
c(SYS.idx.v) = 2.0 * SYS.xi * SYS.ws;
if SYS.is_bw
    c(SYS.idx.z) = (1.0 - SYS.alpha) * SYS.ws^2;
end
end

