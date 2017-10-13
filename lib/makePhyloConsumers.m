function [out,priors] = makePhyloConsumers(num_species,num_resources,num_groups,priors,Total,nonNormal)

% define 5 groups of 20 species
%Total = 20;
if isempty(priors)
priors = arrayfun(@(x) Total.*rand(1,num_resources),1:num_groups,'uni',0);
else
end

C = cellfun(@(y) drchrnd(y,num_species), priors,'uni',0);
group_labels = arrayfun(@(y) y.*ones(1,num_species), 1:num_groups,'uni',0);
group_labels = cell2mat(group_labels);

C_total = cell2mat(C');
idx = randsample(1:size(C_total,1),num_species);
C = C_total(idx,:);
group_labels = group_labels(idx);


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

out.C = C;
out.group = group_labels;
[~,out.k]=sort(out.group);



end