function [C] = getRandomConsumerMatrix(numSpecies,numResources,ctype)
%p = inputParser;
%parse(p,numSpecies,numResources,varargin)
%addParameter(p,'normalized',false)

% distributionSets = {'uniform','normal','lognormal'};
% 
% % find the distribution used in type provided
% if ~isfield(p.Results,'distribution')
%     dist = 'uniform';
% else
%     dist = p.Results.distribution;
% end
if ~isfield(ctype,'normalized')
    normalizedBool = true;
else
    normalizedBool = false;
end
    


% randomly sample resource utilization matrix (C) from uniform distribution
C = rand(numSpecies,numResources);
% normalize distribution for each species
if normalizedBool
    C = cell2mat(cellfun(@(x) x./sum(x), num2cell(C,2),'uni',0));
end


end