function IN = sss_normalize_input(IN)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.

IN = sss_merge_defaults(sss_input_default(), IN);

if IN.dt <= 0 || IN.Ttot <= 0
    error('SSS:Input', 'IN.dt and IN.Ttot must be positive.');
end
if IN.Pf <= 0 || IN.Pf >= 1
    error('SSS:Input', 'IN.Pf must lie in (0, 1).');
end
if IN.PGA <= 0 && isempty(IN.S0)
    error('SSS:Input', 'IN.PGA must be positive when IN.S0 is empty.');
end
end

