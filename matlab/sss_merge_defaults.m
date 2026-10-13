function OUT = sss_merge_defaults(DEF, USER)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Recursive structure merge.

OUT = DEF;
if nargin < 2 || isempty(USER)
    return;
end

names = fieldnames(USER);
for k = 1:numel(names)
    name = names{k};
    if isfield(OUT, name) && isstruct(OUT.(name)) && isstruct(USER.(name))
        OUT.(name) = sss_merge_defaults(OUT.(name), USER.(name));
    else
        OUT.(name) = USER.(name);
    end
end
end

