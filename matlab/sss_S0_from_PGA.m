function S0 = sss_S0_from_PGA(IN)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Numerical stationary calibration of the white-noise spectral level.

P = sss_filter_params(IN);

if strcmpi(P.type, 'CP')
    A = zeros(4);
    A(1,3) = 1.0;
    A(2,4) = 1.0;
    A(3,1) = -P.wp^2;
    A(3,2) = P.wg^2;
    A(3,3) = -2.0 * P.xip * P.wp;
    A(3,4) = 2.0 * P.xig * P.wg;
    A(4,2) = -P.wg^2;
    A(4,4) = -2.0 * P.xig * P.wg;
    B = zeros(4);
    B(4,4) = 2.0 * pi;
    q = [P.wp^2, -P.wg^2, 2.0 * P.xip * P.wp, -2.0 * P.xig * P.wg];
else
    A = [0.0, 1.0; -P.wg^2, -2.0 * P.xig * P.wg];
    B = zeros(2);
    B(2,2) = 2.0 * pi;
    q = [-P.wg^2, -2.0 * P.xig * P.wg];
end

R = sss_lyap(A, B);
sigma2_for_S0_1 = max(q * R * q.', realmin);
target_sigma = IN.PGA / IN.peakf;
S0 = (target_sigma^2) / sigma2_for_S0_1;
end

