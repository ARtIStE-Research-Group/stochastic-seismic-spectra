function [IN, ST] = input_case_beta01()
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Editable input case for one stochastic seismic analysis.

IN = sss_input_default();
ST = sss_struct_default();

% Ground motion and analysis controls.
IN.PGA = 0.35 * IN.g;       % target PGA [m/s^2]
IN.peakf = 3.0;             % peak factor used for S0 calibration
IN.Pf = 0.95;               % non-exceedance probability for maxima
IN.Ttot = 30.0;             % analysis duration [s]
IN.dt = 0.01;               % time step [s]

% Filter parameters.
IN.filter.type = 'CP';      % 'CP' or 'KT'
IN.filter.wg = 15.0;        % Kanai-Tajimi circular frequency [rad/s]
IN.filter.xg = 0.60;        % Kanai-Tajimi damping ratio
IN.filter.wp = 1.50;        % Clough-Penzien high-pass frequency [rad/s]
IN.filter.xp = 0.60;        % Clough-Penzien high-pass damping ratio

% Structural system. Frequency can be supplied through T, omega, or frequency_hz.
ST.type = 'linear';         % 'linear' or 'BW'
ST.T = 0.50;                % natural period [s]
ST.xi = 0.05;               % viscous damping ratio

% Bouc-Wen fields are used only when ST.type = 'BW'.
ST.alpha = 0.20;            % post-yield to initial stiffness ratio
ST.uy = 0.015;              % yield displacement [m]
ST.Abw = 1.0;
ST.n = 1.0;
end

