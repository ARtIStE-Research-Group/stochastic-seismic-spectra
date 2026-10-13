function wg = sss_wg_evol(IN, t)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.

wg0 = IN.filter.wg;
if ~isfield(IN, 'freq_evol') || ~IN.freq_evol.flag
    wg = wg0;
    return;
end

wgend = IN.freq_evol.wg_end;
switch lower(char(IN.freq_evol.law))
    case 'linear'
        wg = wg0 + (wgend - wg0) * min(max(t / IN.Ttot, 0), 1);
    case 'exponential'
        wg = wgend + (wg0 - wgend) * exp(-3.0 * t / IN.Ttot);
    otherwise
        error('SSS:Input', 'Unknown IN.freq_evol.law.');
end
end

