function ST = sss_struct_default()
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Default structural-system input.

ST.version = 'beta 01';
ST.type = 'linear';

ST.T = 0.50;
ST.omega = [];
ST.omega0 = [];
ST.w0 = [];
ST.frequency_hz = [];
ST.xi = 0.05;

ST.alpha = 1.0;
ST.uy = 0.015;
ST.Abw = 1.0;
ST.beta = [];
ST.gamma = [];
ST.n = 1.0;
end

