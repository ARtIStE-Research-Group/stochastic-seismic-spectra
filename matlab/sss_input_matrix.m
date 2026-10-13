function B = sss_input_matrix(SYS, t)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Modulated white-noise intensity matrix.

B = zeros(SYS.n);
phi = sss_modulation(SYS.IN, t);
B(SYS.idx.noise, SYS.idx.noise) = 2.0 * pi * SYS.IN.S0 * phi.^2;
end

