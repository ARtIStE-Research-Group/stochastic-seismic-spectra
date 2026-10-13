function OUT = sss_main(IN, ST)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Main single-scenario solver.

if nargin < 1 || isempty(IN)
    IN = sss_input_default();
end
if nargin < 2 || isempty(ST)
    ST = sss_struct_default();
end

SYS = sss_build_system(IN, ST);
[Rhist, Ahist, tvec] = sss_integrate_lyapunov(SYS);
OUT = sss_postprocess(Rhist, Ahist, tvec, SYS);

OUT.meta.version = 'beta 01';
OUT.meta.authors = 'Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco';
OUT.meta.reference = 'Marano et al. (2026), A systematic random-vibration framework for stochastic seismic spectra';
OUT.SYS = SYS;
end

