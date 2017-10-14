function [out,priors] = makePhyloConsumers(num_species,num_resources,num_groups,priors,Total,nonNormal)
% function to make sets of consumer matricies drawn from priors,
% representing "families" of consumers.


% if no prior family-level consumer vectors, make some
if isempty(priors)
priors = arrayfun(@(x) Total.*rand(1,num_resources),1:num_groups,'uni',0);
else
end

% draw consumption vectors from dirichlet distribution
C = cellfun(@(y) drchrnd(y,num_species), priors,'uni',0);

% assign wich consumers are part of which family
group_labels = arrayfun(@(y) y.*ones(1,num_species), 1:num_groups,'uni',0);
group_labels = cell2mat(group_labels);

C_total = cell2mat(C');
% randomly sample a sub-population
idx = randsample(1:size(C_total,1),num_species);
C = C_total(idx,:);
group_labels = group_labels(idx);


% breaks the constraint that there has to be a "fixed enzyme budget per
% species"

if nonNormal
    % allow for a ~2 percent change in the total uptake capacity
    u = normrnd(1,0.01,[num_species,1]);
    C = diag(u)*C;
    
    
%     for i = 1:max(group_labels)
%         u = normrnd(1,0.01);
%         C(group_labels==i,:) = C(group_labels==i,:).*u;
%         uptakeFactor(i) = u;
%     end
   % out.uptakeFactor = uptakeFactor;
      
end

% construct output structure
out.C = C;
out.group = group_labels;
[~,out.k]=sort(out.group);



end