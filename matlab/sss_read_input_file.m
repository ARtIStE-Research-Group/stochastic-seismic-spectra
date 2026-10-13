function [IN, ST] = sss_read_input_file(file_name)
% SSS-Spectra beta 01
% Authors: Giuseppe Carlo Marano, Laura Sardone, Alessandra Fiore, Rita Greco.
% Reference: Marano et al. (2026), stochastic seismic spectra by covariance analysis.
%
% Read a .mat or .json file containing IN and ST structures.

[~, ~, ext] = fileparts(file_name);
ext = lower(ext);

switch ext
    case '.mat'
        data = load(file_name);
        if isfield(data, 'IN') && isfield(data, 'ST')
            IN = data.IN;
            ST = data.ST;
        elseif isfield(data, 'case_data') && isfield(data.case_data, 'IN') && isfield(data.case_data, 'ST')
            IN = data.case_data.IN;
            ST = data.case_data.ST;
        else
            error('SSS:InputFile', 'The MAT file must contain IN and ST.');
        end
    case '.json'
        raw = fileread(file_name);
        data = jsondecode(raw);
        if isfield(data, 'IN') && isfield(data, 'ST')
            IN = data.IN;
            ST = data.ST;
        else
            error('SSS:InputFile', 'The JSON file must contain IN and ST.');
        end
    otherwise
        error('SSS:InputFile', 'Supported input files are .mat and .json.');
end
end

