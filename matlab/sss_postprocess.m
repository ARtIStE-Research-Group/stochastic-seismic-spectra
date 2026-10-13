function OUT = sss_postprocess(Rhist, Ahist, tvec, SYS)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Extract enlarged covariance, response statistics, maxima and energies.

n = SYS.n;
nt = numel(tvec);
ix = SYS.idx.x;
iv = SYS.idx.v;

ex = zeros(1, n); ex(ix) = 1.0;
ev = zeros(1, n); ev(iv) = 1.0;
ca = sss_abs_accel_vector(SYS);

Cxva = zeros(3, 3, nt);
var_x = zeros(1, nt);
var_v = zeros(1, nt);
var_a = zeros(1, nt);
var_adot = zeros(1, nt);
cov_x_v = zeros(1, nt);
cov_v_vdot = zeros(1, nt);
cov_a_adot = zeros(1, nt);
var_vdot = zeros(1, nt);
var_ag = zeros(1, nt);

for i = 1:nt
    R = Rhist(:, :, i);
    A = Ahist(:, :, i);
    H = [ex; ev; ca];
    C = H * R * H.';
    Cxva(:, :, i) = 0.5 * (C + C.');

    da = ca * A;
    dv = A(iv, :);
    qg = sss_ground_accel_vector(SYS, tvec(i));

    var_x(i) = max(Cxva(1, 1, i), 0.0);
    var_v(i) = max(Cxva(2, 2, i), 0.0);
    var_a(i) = max(Cxva(3, 3, i), 0.0);
    var_adot(i) = max(da * R * da.', 0.0);
    var_vdot(i) = max(dv * R * dv.', 0.0);
    cov_x_v(i) = ex * R * ev.';
    cov_v_vdot(i) = ev * R * dv.';
    cov_a_adot(i) = ca * R * da.';
    var_ag(i) = max(qg * R * qg.', 0.0);
end

sig_x = sqrt(max(var_x, 0.0));
sig_v = sqrt(max(var_v, 0.0));
sig_a = sqrt(max(var_a, 0.0));
sig_adot = sqrt(max(var_adot, 0.0));
sig_vdot = sqrt(max(var_vdot, 0.0));

beta_x = sss_firstpassage(tvec, sig_x, sig_v, cov_x_v, SYS.IN.Pf);
beta_v = sss_firstpassage(tvec, sig_v, sig_vdot, cov_v_vdot, SYS.IN.Pf);
beta_a = sss_firstpassage(tvec, sig_a, sig_adot, cov_a_adot, SYS.IN.Pf);

[energy, energy_rates] = sss_energy(Rhist, tvec, SYS, var_ag);

OUT.tvec = tvec;
OUT.covariance.state = Rhist;
OUT.covariance.xva = Cxva;
OUT.covariance.xva_labels = {'relative displacement x', 'relative velocity v', 'absolute acceleration a'};
OUT.covariance.xva_final = Cxva(:, :, end);

OUT.state.sig_x = sig_x;
OUT.state.sig_v = sig_v;
OUT.state.sig_a = sig_a;
OUT.state.sig_adot = sig_adot;
OUT.state.var_x = var_x;
OUT.state.var_v = var_v;
OUT.state.var_a = var_a;
OUT.state.var_adot = var_adot;

OUT.threshold.beta_x = beta_x;
OUT.threshold.beta_v = beta_v;
OUT.threshold.beta_a = beta_a;
OUT.threshold.Pf = SYS.IN.Pf;
OUT.threshold.meaning = 'Reliability-based maxima: P(max |response| <= beta) = Pf.';

OUT.max.displacement = beta_x;
OUT.max.velocity = beta_v;
OUT.max.acceleration = beta_a;
OUT.max.units = 'x [m], v [m/s], a [m/s^2]';

OUT.statistics.displacement = sss_response_stats(tvec, var_x);
OUT.statistics.velocity = sss_response_stats(tvec, var_v);
OUT.statistics.acceleration = sss_response_stats(tvec, var_a);
OUT.statistics.note = 'The Gaussian model is zero-mean; variance histories come from the covariance matrix.';

OUT.energy = energy;
OUT.energy_rates = energy_rates;
end
