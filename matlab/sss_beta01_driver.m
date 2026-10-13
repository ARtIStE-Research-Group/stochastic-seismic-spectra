function OUT = sss_beta01_driver(IN_or_file, ST)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% OUT = sss_beta01_driver(IN, ST)
% OUT = sss_beta01_driver('case.mat')
% OUT = sss_beta01_driver('case.json')
%
% The driver reads the input data, including frequency, damping and optional
% Bouc-Wen parameters, and returns the enlarged covariance of [x, v, a],
% response maxima, response means/variances and all mean energy quantities.

if nargin == 0
    [IN, ST] = input_case_beta01();
elseif nargin == 1
    if ischar(IN_or_file) || isstring(IN_or_file)
        [IN, ST] = sss_read_input_file(char(IN_or_file));
    elseif isstruct(IN_or_file) && isfield(IN_or_file, 'IN') && isfield(IN_or_file, 'ST')
        IN = IN_or_file.IN;
        ST = IN_or_file.ST;
    else
        IN = IN_or_file;
        ST = sss_struct_default();
    end
else
    IN = IN_or_file;
end

OUT = sss_main(IN, ST);
end

