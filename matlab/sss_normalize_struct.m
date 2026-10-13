function ST = sss_normalize_struct(ST)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.

ST = sss_merge_defaults(sss_struct_default(), ST);
ST.type = char(ST.type);

if ST.xi < 0
    error('SSS:Input', 'ST.xi must be non-negative.');
end

is_bw = strcmpi(ST.type, 'BW') || strcmpi(ST.type, 'BoucWen') || strcmpi(ST.type, 'Bouc-Wen');
if is_bw
    ST.type = 'BW';
    if ST.alpha < 0 || ST.alpha > 1
        error('SSS:Input', 'ST.alpha must lie in [0, 1].');
    end
    if ST.uy <= 0
        error('SSS:Input', 'ST.uy must be positive for Bouc-Wen analyses.');
    end
    if abs(ST.n - 1.0) > 1.0e-12
        error('SSS:Input', 'SSS beta 01 supports the Bouc-Wen case n = 1.');
    end
else
    ST.type = 'linear';
    ST.alpha = 1.0;
end

omega = sss_struct_frequency(ST);
if omega <= 0
    error('SSS:Input', 'The structural frequency must be positive.');
end
ST.T = 2.0 * pi / omega;
end

