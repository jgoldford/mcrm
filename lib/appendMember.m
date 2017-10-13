function [params] = appendMember(params,c,abundance,death_rate)
%APPENDMEMBER Summary of this function goes here
%   Detailed explanation goes here

params.x0 = [params.x0(params.varIdx.species);abundance;params.x0(params.varIdx.resources)];
params.varIdx.species = [params.varIdx.species,params.varIdx.species(end)+1];
N = length(params.varIdx.species);
params.num_species = N;
params.varIdx.resources = (N+1):N+length(params.varIdx.resources);

params.C = [params.C;c];
params.death_rate = [params.death_rate;death_rate];

end

