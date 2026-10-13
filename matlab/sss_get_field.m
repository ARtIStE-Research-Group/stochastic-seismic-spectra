function value = sss_get_field(S, names, default_value)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.

value = default_value;
for k = 1:numel(names)
    if isfield(S, names{k}) && ~isempty(S.(names{k}))
        value = S.(names{k});
        return;
    end
end
end

