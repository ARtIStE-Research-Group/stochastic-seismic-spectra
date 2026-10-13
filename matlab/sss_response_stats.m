function S = sss_response_stats(tvec, variance)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Zero-mean response process statistics.

[max_variance, idx] = max(variance);
S.mean = zeros(size(tvec));
S.variance = variance;
S.std = sqrt(max(variance, 0.0));
S.max_variance = max_variance;
S.max_std = sqrt(max(max_variance, 0.0));
S.time_of_max_variance = tvec(idx);
S.final_variance = variance(end);
S.final_std = sqrt(max(variance(end), 0.0));
end

