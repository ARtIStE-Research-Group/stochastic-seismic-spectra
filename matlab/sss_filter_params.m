function P = sss_filter_params(IN)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.

F = IN.filter;
P.type = upper(char(F.type));
P.wg = F.wg;
P.xig = sss_get_field(F, {'xig', 'xg'}, 0.60);
P.wp = sss_get_field(F, {'wp'}, 1.50);
P.xip = sss_get_field(F, {'xip', 'xp'}, 0.60);

if ~(strcmpi(P.type, 'CP') || strcmpi(P.type, 'KT'))
    error('SSS:Input', 'IN.filter.type must be ''CP'' or ''KT''.');
end
if P.wg <= 0 || P.xig < 0
    error('SSS:Input', 'Kanai-Tajimi frequency must be positive and damping non-negative.');
end
if strcmpi(P.type, 'CP') && (P.wp <= 0 || P.xip < 0)
    error('SSS:Input', 'Clough-Penzien frequency must be positive and damping non-negative.');
end
end

