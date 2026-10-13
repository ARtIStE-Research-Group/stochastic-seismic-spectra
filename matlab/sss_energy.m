function [E, PWR] = sss_energy(Rhist, tvec, SYS, var_ag)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Mean energy components per unit mass.

nt = numel(tvec);
ix = SYS.idx.x;
iv = SYS.idx.v;
ws = SYS.ws;
xi = SYS.xi;
alpha = SYS.alpha;

Rxx = squeeze(Rhist(ix, ix, :)).';
Rvv = squeeze(Rhist(iv, iv, :)).';

E.ek = 0.5 * Rvv;
E.es = 0.5 * alpha * ws^2 * Rxx;

PWR.viscous = 2.0 * xi * ws * Rvv;
E.exi = cumtrapz(tvec, PWR.viscous);

if SYS.is_bw
    iz = SYS.idx.z;
    Rzv = squeeze(Rhist(iz, iv, :)).';
    PWR.hysteretic = (1.0 - alpha) * ws^2 * Rzv;
else
    Rzv = zeros(1, nt);
    PWR.hysteretic = zeros(1, nt);
end
E.eh = cumtrapz(tvec, PWR.hysteretic);

PWR.input = zeros(1, nt);
for i = 1:nt
    qg = sss_ground_accel_vector(SYS, tvec(i));
    R = Rhist(:, :, i);
    ev = zeros(SYS.n, 1);
    ev(iv) = 1.0;
    PWR.input(i) = qg * R * ev;
end

E.eI_direct = cumtrapz(tvec, PWR.input);
E.eI_balance = E.ek + E.es + E.exi + E.eh;
E.eI = E.eI_balance;
E.recoverable = E.ek + E.es;
E.dissipated = E.exi + E.eh;
E.balance_residual = E.eI_direct - E.eI_balance;

E.final.kinetic = E.ek(end);
E.final.elastic = E.es(end);
E.final.viscous = E.exi(end);
E.final.hysteretic = E.eh(end);
E.final.input_balance = E.eI_balance(end);
E.final.input_direct = E.eI_direct(end);
E.final.balance_residual = E.balance_residual(end);

PWR.kinetic = gradient(E.ek, tvec);
PWR.elastic = gradient(E.es, tvec);
PWR.recoverable = gradient(E.recoverable, tvec);
PWR.balance = PWR.kinetic + PWR.elastic + PWR.viscous + PWR.hysteretic;

E.ground.var_ag = var_ag;
E.ground.arias_intensity = (pi / (2.0 * SYS.IN.g)) * cumtrapz(tvec, var_ag);
E.ground.final_arias_intensity = E.ground.arias_intensity(end);
if isfield(SYS.IN.modulation, 't1') && isfield(SYS.IN.modulation, 't2')
    E.ground.strong_motion_duration = SYS.IN.modulation.t2 - SYS.IN.modulation.t1;
else
    E.ground.strong_motion_duration = NaN;
end

E.hysteretic_cross_covariance_zv = Rzv;
E.units = 'mean energies per unit mass [m^2/s^2]';
end

