
function [output] = run_mcrm(params)

% parse input
num_species = params.num_species;
num_resources = params.num_resources;
varIdx = params.varIdx;
C = params.C;
D = params.D;
%Q = params.Q;
W = params.W;
B = params.B;
death_rate = params.death_rate;
mu = params.mu;
T = params.T;
tau = params.tau;
x0 = params.x0;
timeSteps = params.timeStep;
alpha = params.alpha;

% create a function handle for dynamics
y = @(t,x) population_dynamics(t,x,num_species,C,D,W,T,mu,alpha,death_rate,B,tau,varIdx);

% solve ODE
[T,Y] = ode15s(y,1:timeSteps,x0);

% parse  species, resource abundanes and consumer_matrix into output structure
output.species = Y(:,varIdx.species);
output.resources = Y(:,varIdx.resources);
%output.consumer_matrix = C;
%output.weights = W;
%output.production_matrix = D;
output.communityStruct = output.species(end,:);
output.environmentalStruct = output.resources(end,:);



end
function [dx] = population_dynamics(t,x,num_species,C,D,W,T,mu,alpha,death_rate,B,tau,varIdx)
    dx = zeros(sum(length(varIdx.resources)+num_species),1);
    % uptake, consumption matrix
    %C = update_consumption_matrix(C,x(varIdx.resources),diag(W));

    % calculate growth rate multiplier ([sum_j w_j * c_ij * r_j - T])
    growth_rate_multiplier = C*W*x(varIdx.resources) - T;
    % calculate consumption rate of resources
    consumption = (C*diag(x(varIdx.resources)))'*x(varIdx.species);
    % compute production rate 
    production = D*consumption;
    
    % calculate differential
    dx(varIdx.species) = x(varIdx.species)*diag(mu).*growth_rate_multiplier - death_rate.*(x(varIdx.species));
    dx(varIdx.resources) =  (alpha-x(varIdx.resources))./tau - consumption + production + B.*sum(death_rate.*x(varIdx.species));
    %dx = dx';
        
end
