
function [params] = mcrm_params(resourceIdx,num_species,C,D,qual,ctype)
% construct the param structure for the MCRM ode solver
% resourceIdx = vector of indexes to specify which resources are non-zero (default value for resource
% abundance is 1e6).  
% num_species = total number of species
% C = the consumer matrix
% D = global stoichiometric matrix
% qual = type of resource qualities ('rand' or 'ranked')
% ctype = not used here (need to remove this and update code)


% specify the number of species and resources in simulation
%num_species = 100;
if iscell(D)
    num_resources = size(D{1},2);
else
    num_resources = size(D,2);
end
% set up variable indexes for ORDE variable
varIdx.species = [1:num_species];
varIdx.resources = [num_species+1:num_resources+num_species];

% % randomly sample resource utilization matrix (C) from uniform distribution
% C = rand(num_species,num_resources);
% % normalize distribution for each species
% if strcmp(ctype,'normalized')
% C = cell2mat(cellfun(@(x) x./sum(x), num2cell(C,2),'uni',0));
% else
% end

% define each resource to be of higher quality than the next;  i.e for R1,
% R2, ..., Rn ==> w_1 > w_2 > ... > w_n
switch qual
    case 'ranked'
    w = [num_resources:-1:1];
    W = diag(w);
    case 'eye'
        W = eye(num_resources);
end

% set maximum growth rate for all species
mu = 1;

% construct D matrix
%d = fliplr(w)./num_resources;
%D = cell2mat(arrayfun(@(x) [zeros(1,x),d(1:end-x)],1:num_resources,'uni',0)');
%D = D';
% rescale D s.t. W > D'W
%D = 0.3*D;
%D = zeros(num_resources);
% set input of nutrients;  in this simulation I am only inputting 1
% nutrient of variable (ranked_quality) qauality
alpha = zeros(num_resources,1);
alpha(resourceIdx) = 1e6;

% define maintenance value for all species 
T = 1;
tau = ones(num_resources,1);
% define death rate
death_rate = 0.*ones(num_species,1);
% define random composition of cell
B = rand(num_resources,1);
B = B./sum(B);


x0 = rand(num_species+num_resources,1);
timeSteps = 10000;


params.num_species = num_species;
params.num_resources = num_resources;
params.varIdx = varIdx;
params.C = C;
params.D = D;
%params.Q = diag(1-sum(params.D));
params.W = W - diag(sum(params.D)) ;
params.B = B;
params.alpha = alpha;
params.death_rate = death_rate;
params.mu = mu;
params.T = T;
params.tau = tau;
params.x0 = x0;
params.timeStep = timeSteps;


end

