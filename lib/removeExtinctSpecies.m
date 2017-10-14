function [ params ] = removeExtinctSpecies(params,simulation,minAbundance)
%REVMOVEEXTINCTSPECIES removes species at the end of the simulation that
%are zero
%  

x = simulation.species(end,:);
x(x<0) = 0;
k = x > minAbundance;
params.num_species = sum(k);
params.varIdx.species = 1:(params.num_species);
params.varIdx.resources = (params.num_species+1):(params.num_resources + params.num_species);
x0 = [x(k)';simulation.resources(end,:)'];
params.x0 = x0;
params.C = params.C(k,:);
params.death_rate = params.death_rate(k);


end

