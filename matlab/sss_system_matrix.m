function A = sss_system_matrix(SYS, t, R)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% State matrix for the linear or equivalent-linearized Bouc-Wen system.

P = SYS.filter;
P.wg = sss_wg_evol(SYS.IN, t);
ws = SYS.ws;
xi = SYS.xi;
A = zeros(SYS.n);

if SYS.is_cp
    if SYS.is_bw
        ix = SYS.idx.x; ixp = SYS.idx.xp; ixg = SYS.idx.xg; iz = SYS.idx.z;
        iv = SYS.idx.v; ivp = SYS.idx.vp; ivg = SYS.idx.vg;
        A(ix, iv) = 1.0;
        A(ixp, ivp) = 1.0;
        A(ixg, ivg) = 1.0;
        [ce, ke] = sss_CKeq(R, SYS);
        A(iz, iz) = -ke;
        A(iz, iv) = SYS.BW.Abw - ce;
        A(iv, ix) = -SYS.alpha * ws^2;
        A(iv, iz) = -(1.0 - SYS.alpha) * ws^2;
        A(iv, iv) = -2.0 * xi * ws;
        A(iv, ixp) = P.wp^2;
        A(iv, ixg) = -P.wg^2;
        A(iv, ivp) = 2.0 * P.xip * P.wp;
        A(iv, ivg) = -2.0 * P.xig * P.wg;
        A(ivp, ixp) = -P.wp^2;
        A(ivp, ixg) = P.wg^2;
        A(ivp, ivp) = -2.0 * P.xip * P.wp;
        A(ivp, ivg) = 2.0 * P.xig * P.wg;
        A(ivg, ixg) = -P.wg^2;
        A(ivg, ivg) = -2.0 * P.xig * P.wg;
    else
        ix = SYS.idx.x; ixp = SYS.idx.xp; ixg = SYS.idx.xg;
        iv = SYS.idx.v; ivp = SYS.idx.vp; ivg = SYS.idx.vg;
        A(ix, iv) = 1.0;
        A(ixp, ivp) = 1.0;
        A(ixg, ivg) = 1.0;
        A(iv, ix) = -ws^2;
        A(iv, ixp) = P.wp^2;
        A(iv, ixg) = -P.wg^2;
        A(iv, iv) = -2.0 * xi * ws;
        A(iv, ivp) = 2.0 * P.xip * P.wp;
        A(iv, ivg) = -2.0 * P.xig * P.wg;
        A(ivp, ixp) = -P.wp^2;
        A(ivp, ixg) = P.wg^2;
        A(ivp, ivp) = -2.0 * P.xip * P.wp;
        A(ivp, ivg) = 2.0 * P.xig * P.wg;
        A(ivg, ixg) = -P.wg^2;
        A(ivg, ivg) = -2.0 * P.xig * P.wg;
    end
else
    if SYS.is_bw
        ix = SYS.idx.x; ixg = SYS.idx.xg; iz = SYS.idx.z;
        iv = SYS.idx.v; ivg = SYS.idx.vg;
        A(ix, iv) = 1.0;
        A(ixg, ivg) = 1.0;
        [ce, ke] = sss_CKeq(R, SYS);
        A(iz, iz) = -ke;
        A(iz, iv) = SYS.BW.Abw - ce;
        A(iv, ix) = -SYS.alpha * ws^2;
        A(iv, iz) = -(1.0 - SYS.alpha) * ws^2;
        A(iv, iv) = -2.0 * xi * ws;
        A(iv, ixg) = -P.wg^2;
        A(iv, ivg) = -2.0 * P.xig * P.wg;
        A(ivg, ixg) = -P.wg^2;
        A(ivg, ivg) = -2.0 * P.xig * P.wg;
    else
        ix = SYS.idx.x; ixg = SYS.idx.xg;
        iv = SYS.idx.v; ivg = SYS.idx.vg;
        A(ix, iv) = 1.0;
        A(ixg, ivg) = 1.0;
        A(iv, ix) = -ws^2;
        A(iv, iv) = -2.0 * xi * ws;
        A(iv, ixg) = -P.wg^2;
        A(iv, ivg) = -2.0 * P.xig * P.wg;
        A(ivg, ixg) = -P.wg^2;
        A(ivg, ivg) = -2.0 * P.xig * P.wg;
    end
end
end

