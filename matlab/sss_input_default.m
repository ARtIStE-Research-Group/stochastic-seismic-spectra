function IN = sss_input_default()
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Default ground-motion and analysis input.

IN.version = 'beta 01';
IN.g = 9.80665;

IN.PGA = 0.35 * IN.g;
IN.peakf = 3.0;
IN.S0 = [];
IN.Pf = 0.95;
IN.Ttot = 30.0;
IN.dt = 0.01;

IN.modulation.type = 'jennings';
IN.modulation.t1 = 2.0;
IN.modulation.t2 = 12.0;
IN.modulation.cd = 0.25;
IN.modulation.c1 = 2.0;
IN.modulation.c2 = 0.35;

IN.filter.type = 'CP';
IN.filter.wg = 15.0;
IN.filter.xg = 0.60;
IN.filter.wp = 1.50;
IN.filter.xp = 0.60;

IN.freq_evol.flag = false;
IN.freq_evol.law = 'linear';
IN.freq_evol.wg_end = IN.filter.wg;

IN.numerics.symmetrize = true;
IN.numerics.min_variance = 1.0e-18;
end

