function [C] = getRandomConsumerMatrix(numSpecies,numResources,ctype)
% function to greate random consumer matricies
% if ctype is normalized, then make sure sum_alpha c_i,alpha = 1

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