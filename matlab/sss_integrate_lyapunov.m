function [Rhist, Ahist, tvec] = sss_integrate_lyapunov(SYS)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Modified implicit trapezoidal integration of Rdot = A R + R A' + B.

tvec = SYS.tvec;
nt = numel(tvec);
n = SYS.n;
Rhist = zeros(n, n, nt);
Ahist = zeros(n, n, nt);
R = zeros(n);
I = eye(n);

for i = 1:(nt - 1)
    dt = tvec(i + 1) - tvec(i);
    A = sss_system_matrix(SYS, tvec(i), R);
    B0 = sss_input_matrix(SYS, tvec(i));
    B1 = sss_input_matrix(SYS, tvec(i + 1));
    PB = 0.5 * (I - dt * A);
    PF = 0.5 * (I + dt * A);
    C = PF * R + R * PF.' + 0.5 * dt * (B0 + B1);
    R = sss_lyap(PB, -C);
    if SYS.IN.numerics.symmetrize
        R = 0.5 * (R + R.');
    end
    Rhist(:, :, i + 1) = R;
    Ahist(:, :, i) = A;
end

Ahist(:, :, nt) = sss_system_matrix(SYS, tvec(end), R);
end

