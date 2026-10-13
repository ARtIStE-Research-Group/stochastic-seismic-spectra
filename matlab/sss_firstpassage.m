function beta = sss_firstpassage(tvec, sig_y, sig_ydot, cov_y_ydot, Pf)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Symmetric-barrier first-passage threshold by Rice-Vanmarcke crossing rate
% with Poisson survival: P(max |y(t)| <= beta) = Pf.

sig_y = max(sig_y(:).', 0.0);
sig_ydot = max(sig_ydot(:).', 0.0);
cov_y_ydot = cov_y_ydot(:).';
tvec = tvec(:).';

active = sig_y > 1.0e-14 & sig_ydot > 1.0e-14;
if ~any(active)
    beta = 0.0;
    return;
end

survival = @(b) exp(-trapz(tvec, local_rate(b, sig_y, sig_ydot, cov_y_ydot, active)));

lo = 0.0;
hi = 3.0 * max(sig_y(active));
if hi <= 0
    beta = 0.0;
    return;
end

while survival(hi) < Pf
    hi = 2.0 * hi;
    if hi > 1.0e8 * max(sig_y(active))
        break;
    end
end

for k = 1:80
    mid = 0.5 * (lo + hi);
    if survival(mid) >= Pf
        hi = mid;
    else
        lo = mid;
    end
end
beta = hi;
end

function nu = local_rate(beta, sig_y, sig_ydot, cov_y_ydot, active)
nu = zeros(size(sig_y));
rho = zeros(size(sig_y));
rho(active) = cov_y_ydot(active) ./ (sig_y(active) .* sig_ydot(active));
rho = min(max(rho, -0.999999), 0.999999);
r2 = max(1.0 - rho.^2, 1.0e-12);
u = zeros(size(sig_y));
u(active) = beta ./ sig_y(active);
d = u .* rho ./ sqrt(r2);
tail = 0.5 * erfc(d ./ sqrt(2.0));
chi = exp(-0.5 .* d.^2) + d .* sqrt(2.0 * pi) .* tail;
nu(active) = (1.0 / pi) .* (sig_ydot(active) ./ sig_y(active)) .* sqrt(r2(active)) ...
    .* exp(-0.5 .* u(active).^2) .* chi(active);
nu(~isfinite(nu)) = 0.0;
nu = max(nu, 0.0);
end

