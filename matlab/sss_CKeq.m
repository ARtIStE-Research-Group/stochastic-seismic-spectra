function [ce, ke, info] = sss_CKeq(R, SYS)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Equivalent-linearization coefficients for the non-degrading Bouc-Wen
% model with n = 1, Abw = 1 and beta = gamma unless supplied otherwise.

ce = 0.0;
ke = 0.0;
info.rho_zv = 0.0;
info.sig_z = 0.0;
info.sig_v = 0.0;

if ~SYS.is_bw
    return;
end

iz = SYS.idx.z;
iv = SYS.idx.v;
minv = SYS.IN.numerics.min_variance;
sig_z = sqrt(max(R(iz, iz), minv));
sig_v = sqrt(max(R(iv, iv), minv));
rho = R(iz, iv) / (sig_z * sig_v);
rho = min(max(rho, -0.999999), 0.999999);

beta_bw = SYS.BW.beta;
gamma_bw = SYS.BW.gamma;
ce = sqrt(2.0 / pi) * sig_z * (beta_bw * rho + gamma_bw);
ke = sqrt(2.0 / pi) * sig_v * (beta_bw + gamma_bw * rho);

info.rho_zv = rho;
info.sig_z = sig_z;
info.sig_v = sig_v;
end

