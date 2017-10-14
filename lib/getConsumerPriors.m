function [R] = getConsumerPriors(T,r,specialist,specialistVar,numResources)
% function generates a single consumer vector R, that represents the total
% uptake capacity for a group of organisms

% the specialist paramaters controls the propotion of total uptake capacity
% (T) that is dedicated to uptake resource "r"

% input
%     T = total uptake capacity (e.g. controlled by fixed amount of enzymes, transporters)
%     specialist, specialistVar = mean and std to randomly draw the
%     fraction of uptake capcity dedicated to consumer resource "r"
%     r = index of resource for which a consumer will be a "specialist" on
%     numResources = total number of resources 

% initialize resource consumer vector
R = zeros(numResources,1);
% pick a dominate resource
if isempty(r)
r = randsample(1:numResources,1);
end
%draw proportion of fixed resources
f = normrnd(specialist,specialistVar);
% ensure f falls between 0 and 1
if f<0;
    f = 0;
elseif f>1
    f = 1;
end


% choose other resource consumption proportions  from a uniform
% distribution
R = rand(numResources,1);
R(setdiff(1:numResources,r)) = (T-f*T).*R(setdiff(1:numResources,r))./sum(R(setdiff(1:numResources,r)))';

% compute fraction of total uptake capacity dedicated to consuming resource
% "r"
R(r) = f*T;


end