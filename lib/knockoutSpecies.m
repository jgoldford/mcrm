function [params] = knockoutSpecies(params,speciesIdx)
% Set species abundance to zero
%
params.C(speciesIdx,:) = zeros(length(speciesIdx),params.num_resources);

end