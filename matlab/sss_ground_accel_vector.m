function q = sss_ground_accel_vector(SYS, t)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Vector q such that q*Z is the base-excitation term in the relative
% structural acceleration equation. The physical ground acceleration has
% opposite sign; energy input rate is E[(q*Z) v].

P = SYS.filter;
P.wg = sss_wg_evol(SYS.IN, t);
q = zeros(1, SYS.n);

if SYS.is_cp
    q(SYS.idx.xp) = P.wp^2;
    q(SYS.idx.xg) = -P.wg^2;
    q(SYS.idx.vp) = 2.0 * P.xip * P.wp;
    q(SYS.idx.vg) = -2.0 * P.xig * P.wg;
else
    q(SYS.idx.xg) = -P.wg^2;
    q(SYS.idx.vg) = -2.0 * P.xig * P.wg;
end
end

