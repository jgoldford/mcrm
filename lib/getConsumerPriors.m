function [R] = getConsumerPriors(T,r,p,s,numResources)
R = zeros(numResources,1);
% pick a dominate resourced
if isempty(r)
r = randsample(1:numResources,1);
end

f = normrnd(p,s);
R(r) = f*T;

R = rand(numResources,1);
R(setdiff(1:numResources,r)) = (T-f*T).*R(setdiff(1:numResources,r))./sum(R(setdiff(1:numResources,r)))';
R(r) = f*T;


end