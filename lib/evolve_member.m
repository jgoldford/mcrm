function [params_out] = evolve_member(params,percentChange)
%EVOLVE_MEMBER takes a parameter structure, copies a random member and
%"mutates" the consumer vector by a max. percent change.  This new member
%is appended into the mcrm structure

%   Detailed explanation goes here
species = randsample(1:params.num_species,1);
total = sum(params.C(species,:));
uptake = params.C(species,:)./total;
dir = binornd(1,[0.5]);
resource = randsample(1:params.num_resources,1);

if dir > 0
    uptake(resource) = uptake(resource) + percentChange;
else
    uptake(resource) = uptake(resource) - percentChange;
end
uptake(uptake<0) = 0;
uptake = uptake./sum(uptake);

% now there is a small chance of changing the total enzyme capacity through
% some global mutation
p_change = 0;
q = binornd(1,p_change);
if q == 1
   total = total + total.*normrnd(0,0.01);
end

c = uptake.*total;

d = 1e-2.*params.x0(params.varIdx.species(species));

% append a new member to the community structure
params_out = appendMember(params,c,d,0);


end

