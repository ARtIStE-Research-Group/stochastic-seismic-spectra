function omega = sss_struct_frequency(ST)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.

omega = [];
if isfield(ST, 'omega') && ~isempty(ST.omega)
    omega = ST.omega;
elseif isfield(ST, 'omega0') && ~isempty(ST.omega0)
    omega = ST.omega0;
elseif isfield(ST, 'w0') && ~isempty(ST.w0)
    omega = ST.w0;
elseif isfield(ST, 'frequency_hz') && ~isempty(ST.frequency_hz)
    omega = 2.0 * pi * ST.frequency_hz;
elseif isfield(ST, 'T') && ~isempty(ST.T)
    omega = 2.0 * pi / ST.T;
end

if isempty(omega)
    error('SSS:Input', 'Provide ST.T, ST.omega, ST.omega0, ST.w0 or ST.frequency_hz.');
end
end

