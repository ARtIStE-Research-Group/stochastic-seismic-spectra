% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Bouc-Wen hysteretic example.

addpath(genpath(fileparts(mfilename('fullpath'))));
[IN, ST] = input_case_beta01();
ST.type = 'BW';
ST.alpha = 0.20;
ST.uy = 0.015;
OUT = sss_beta01_driver(IN, ST);

fprintf('beta_x = %.4g m at Pf = %.2f\n', OUT.threshold.beta_x, OUT.threshold.Pf);
fprintf('beta_v = %.4g m/s\n', OUT.threshold.beta_v);
fprintf('beta_a = %.4g m/s^2\n', OUT.threshold.beta_a);
fprintf('final hysteretic energy = %.4g m^2/s^2\n', OUT.energy.final.hysteretic);
fprintf('final input energy = %.4g m^2/s^2\n', OUT.energy.final.input_balance);

