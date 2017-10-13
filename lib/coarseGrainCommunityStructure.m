function [coarsedGrainedAbundanceVec] = coarseGrainCommunityStructure(abundanceVector,groupVector,maxGroups)
% function just sums the total abundance for each group
coarsedGrainedAbundanceVec = arrayfun(@(y) sum(abundanceVector(groupVector==y)),1:maxGroups);
end