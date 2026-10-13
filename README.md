# SSS — Stochastic Seismic Spectra

MATLAB toolbox for the time-domain random-vibration analysis of linear and equivalent-linearised Bouc–Wen SDOF systems under filtered, amplitude-modulated Gaussian seismic excitation (Kanai–Tajimi / Clough–Penzien filter, Jennings-type envelope). The state covariance is obtained from the evolutionary (differential) Lyapunov equation, and the toolbox returns covariance histories of displacement, velocity and absolute acceleration, first-passage (reliability-based) peak estimates, and mean energy histories.

> **Release status — please read.** This repository contains the **beta 01** code together with the **v2.3-beta technical manual**. The manual is ahead of the code: it documents planned features that are **not yet included in beta 01**, namely the adaptive trapezoidal / TR-BDF2 integrators, first- and second-order covariance sensitivities, FOSM/SOSM uncertainty propagation, and the robust NSGA-II optimisation layer, as well as the `sss_config` / `sss_run_case` / `sss_run_uncertain_case` interface. For beta 01, use the interface described in this README. Sections 1–4 of the manual describe the underlying formulation that beta 01 implements.

## Repository contents

| Path | Contents |
|---|---|
| `matlab/` | SSS-Spectra beta 01 MATLAB source code |
| `docs/SSS_Manual_v2.3-beta.pdf` | Technical lecture notes and methodological report (v2.3-beta) |
| `CITATION.cff`, `.zenodo.json` | Citation and archive metadata |

## Requirements

MATLAB R2018b or later. The Control System Toolbox (`lyap`) is useful but not required.

## Quick start

```matlab
addpath(genpath('matlab'));

[IN, ST] = input_case_beta01();     % editable input case
OUT = sss_beta01_driver(IN, ST);    % single stochastic analysis
```

Ready-made examples: `matlab/example_linear_beta01.m` and `matlab/example_bw_beta01.m`.

Main outputs:

- `OUT.covariance.state` — full state covariance history R(t)
- `OUT.covariance.xva` — covariance history of [x, v, a]
- `OUT.state` — standard deviations and variances of displacement, velocity, absolute acceleration
- `OUT.statistics` — zero-mean response statistics and maximum variances
- `OUT.threshold` — reliability-based peak displacement, velocity, acceleration at `IN.Pf`
- `OUT.energy` — kinetic, elastic, viscous, hysteretic, input energy and Arias intensity

## Input conventions

Use `IN = sss_input_default()` and `ST = sss_struct_default()` as templates. The structural frequency may be given as `ST.T` (period, s), `ST.omega` / `ST.omega0` / `ST.w0` (rad/s) or `ST.frequency_hz` (Hz).

Bouc–Wen analysis:

```matlab
ST.type  = 'BW';
ST.alpha = 0.2;     % post-yield stiffness ratio
ST.uy    = 0.015;   % yield displacement [m]
```

Beta 01 uses the non-degrading Bouc–Wen model with n = 1, A = 1, beta = gamma = 1/(2 uy), and Gaussian equivalent linearisation.

## Authors

Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco, Gaurav Datta, Arman Hajiha.

## How to cite

Please cite the archived release via its Zenodo DOI (10.5281/zenodo.23336450), and the reference article:

Marano G.C. et al. (2026). *A systematic random-vibration framework for stochastic seismic spectra: kinematic and energy spectra of linear and hysteretic systems by covariance analysis.*

## License

- Source code (`matlab/`): MIT License — see `LICENSE`.
- Manual (`docs/`): Creative Commons Attribution 4.0 International (CC BY 4.0) — see `docs/LICENSE`.

## Disclaimer

Research software in beta. It is not a substitute for model validation or nonlinear Monte Carlo verification. Results should be independently verified before use in design.
