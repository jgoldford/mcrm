function [ params ] = removeExtinctSpecies(params,simulation,minRelativeAbundance)
%REVMOVEEXTINCTSPECIES Summary of this function goes here
%   Detailed explanation goes here

x = simulation.species(end,:);
x(x<0) = 0;
k = x > minRelativeAbundance;
params.num_species = sum(k);
params.varIdx.species = 1:(params.num_species);
params.varIdx.resources = (params.num_species+1):(params.num_resources + params.num_species);
x0 = [x(k)';simulation.resources(end,:)'];
params.x0 = x0;
params.C = params.C(k,:);
params.death_rate = params.death_rate(k);


end

