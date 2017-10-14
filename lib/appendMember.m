function [params] = appendMember(params,c,abundance,death_rate)
%APPENDMEMBER takes a parmater structure and appends a new member (consumer vector) onto this structure
%   inputs:
%		 params : mcrm paramater structure
%	     c : consumer vector (1XM dim)
%	     abundance : initial abundance of this consumer
%		 dealth rate: rate that this species dies relative to per capita growth (usually set to 0)
 

params.x0 = [params.x0(params.varIdx.species);abundance;params.x0(params.varIdx.resources)];
params.varIdx.species = [params.varIdx.species,params.varIdx.species(end)+1];
N = length(params.varIdx.species);
params.num_species = N;
params.varIdx.resources = (N+1):N+length(params.varIdx.resources);

params.C = [params.C;c];
params.death_rate = [params.death_rate;death_rate];

end

