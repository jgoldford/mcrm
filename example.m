% define hyperparamters
% the total number of species in your "world"

Total_Number_Of_Species = 1000;

% the number of species in your ecosystem (i.e. inocula)
numSpecies = 100;

% the total number of metabolic families
numGroups = 4;

% the total number of resources (must equal or exceed numGroups)
numResource = 10;

% dirichlet hypoerparameter (controls the variablity of the family
% metabolism)
Total = 100;

% get a secretion matrix for everyone
D = getMetabolism(numResource,'rand',1/numResource);

% determine how much of the community you want to be specialists vs.
% generalists
% more generalist, set to 1/M, and more specialist set to 0.9
specialist = 0.2;

specialistVariation = 0.01;

priors = arrayfun(@(x) getConsumerPriors(100,x,specialist,specialistVariation,numResource)',1:numGroups,'uni',0);
[out,~]=makePhyloConsumers(Total_Number_Of_Species,numResource,numGroups,priors,Total,true);

% if you don't want community struture, use the function
% getRandomConsumerMatrix


% randomly sample a sub population:
k = randsample(1:Total_Number_Of_Species,numSpecies);
% construct an ecosystem
params = mcrm_params(1,numSpecies,out.C(k,:),D,'eye','');

% run ODE solver for ecosystem
r = run_mcrm(params);
g = out.group(k((r.communityStruct > 1e-4)));
x = r.communityStruct(r.communityStruct > 1e-4);

% compute the coarse grained structure of the community
%x = coarseGrainCommunityStructure(r.communityStruct,out.group(k),numGroups);
% figure();
% pie(x)
% legend(arrayfun(@(x) ['Family ',num2str(x)],1:numGroups,'uni',0));

% how  stable is the community to species loss?
% this function reduces the parameter structure to only include species
% that survived in the prior simulation
p_new = removeExtinctSpecies(params,r,1e-4);
% knockout a species (i.e. set it's consumption rates to zero)

I = zeros(p_new.num_species);

for ko_species = 1:p_new.num_species
    params_knockout = knockoutSpecies(p_new,ko_species);
    ko_sim = run_mcrm(params_knockout);
    
    % compute the number of species that went co-extinct
    extinct = find(ko_sim.communityStruct < 1e-4);
    I(ko_species,extinct) = 1;
    %extinct = setdiff(extinct,ko_species);
    
end

%compute average species loss 
avgLoss = (sum(sum(I)) - length(I))/length(I);
fractionalLoss = avgLoss/p_new.num_species;

    





