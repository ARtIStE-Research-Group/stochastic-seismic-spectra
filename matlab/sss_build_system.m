function SYS = sss_build_system(IN, ST)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Build the normalized system structure consumed by the integrator.

IN = sss_normalize_input(IN);
ST = sss_normalize_struct(ST);

if isempty(IN.S0)
    IN.S0 = sss_S0_from_PGA(IN);
end

SYS.version = 'beta 01';
SYS.IN = IN;
SYS.ST = ST;
SYS.filter = sss_filter_params(IN);
SYS.ws = sss_struct_frequency(ST);
SYS.xi = ST.xi;
SYS.model = lower(ST.type);

is_bw = strcmpi(ST.type, 'BW') || strcmpi(ST.type, 'BoucWen') || strcmpi(ST.type, 'Bouc-Wen');
is_cp = strcmpi(SYS.filter.type, 'CP');

SYS.is_bw = is_bw;
SYS.is_cp = is_cp;
SYS.alpha = 1.0;
SYS.BW = [];

if is_bw
    SYS.alpha = ST.alpha;
    SYS.BW.Abw = ST.Abw;
    SYS.BW.n = ST.n;
    SYS.BW.uy = ST.uy;
    SYS.BW.beta = ST.beta;
    SYS.BW.gamma = ST.gamma;
    if isempty(SYS.BW.beta)
        SYS.BW.beta = 1.0 / (2.0 * ST.uy);
    end
    if isempty(SYS.BW.gamma)
        SYS.BW.gamma = SYS.BW.beta;
    end
else
    SYS.alpha = 1.0;
end

if is_cp && ~is_bw
    SYS.n = 6;
    SYS.idx.x = 1;
    SYS.idx.xp = 2;
    SYS.idx.xg = 3;
    SYS.idx.v = 4;
    SYS.idx.vp = 5;
    SYS.idx.vg = 6;
    SYS.idx.noise = 6;
elseif is_cp && is_bw
    SYS.n = 7;
    SYS.idx.x = 1;
    SYS.idx.xp = 2;
    SYS.idx.xg = 3;
    SYS.idx.z = 4;
    SYS.idx.v = 5;
    SYS.idx.vp = 6;
    SYS.idx.vg = 7;
    SYS.idx.noise = 7;
elseif ~is_cp && ~is_bw
    SYS.n = 4;
    SYS.idx.x = 1;
    SYS.idx.xg = 2;
    SYS.idx.v = 3;
    SYS.idx.vg = 4;
    SYS.idx.noise = 4;
else
    SYS.n = 5;
    SYS.idx.x = 1;
    SYS.idx.xg = 2;
    SYS.idx.z = 3;
    SYS.idx.v = 4;
    SYS.idx.vg = 5;
    SYS.idx.noise = 5;
end

SYS.tvec = 0:IN.dt:IN.Ttot;
if SYS.tvec(end) < IN.Ttot
    SYS.tvec(end + 1) = IN.Ttot;
end
end

