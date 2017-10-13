function [params] = knockoutSpecies(params,speciesIdx)
% set species abundance to zero
%params.x0(params.varIdx.species(speciesIdx)) = 0;
params.C(speciesIdx,:) = zeros(length(speciesIdx),params.num_resources);

end