function phi = sss_modulation(IN, t)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Deterministic intensity envelope.

M = IN.modulation;
t = max(t, 0);
phi = zeros(size(t));

switch lower(char(M.type))
    case 'jennings'
        t1 = M.t1;
        t2 = M.t2;
        cd = M.cd;
        i1 = t <= t1;
        i2 = t > t1 & t <= t2;
        i3 = t > t2;
        if t1 > 0
            phi(i1) = (t(i1) ./ t1).^2;
        else
            phi(i1) = 1.0;
        end
        phi(i2) = 1.0;
        phi(i3) = exp(-cd .* (t(i3) - t2));
    case 'box'
        phi(t >= M.t1 & t <= M.t2) = 1.0;
    case 'shinozaki'
        c1 = M.c1;
        c2 = M.c2;
        raw = (t.^c1) .* exp(-c2 .* t);
        if c1 > 0 && c2 > 0
            tmax = c1 / c2;
            rawmax = (tmax^c1) * exp(-c2 * tmax);
            phi = raw ./ max(rawmax, eps);
        else
            phi = raw;
        end
    otherwise
        error('SSS:Input', 'Unknown modulation type.');
end
end

