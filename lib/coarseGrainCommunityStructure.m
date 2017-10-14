function [coarsedGrainedAbundanceVec] = coarseGrainCommunityStructure(abundanceVector,groupVector,maxGroups)
% function sums the total abundance within each group (groupVector conains the group id for each species)
coarsedGrainedAbundanceVec = arrayfun(@(y) sum(abundanceVector(groupVector==y)),1:maxGroups);
end