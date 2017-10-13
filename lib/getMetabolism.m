function [ D ] = getMetabolism(numResources,flag,p)
%GETMETABOLISM Summary of this function goes here
%   Detailed explanation goes here

switch flag
    case 'thermo'
        w = [numResources:-1:1];
        % construct D matrix
        d = fliplr(w)./numResources;
        D = cell2mat(arrayfun(@(x) [zeros(1,x),d(1:end-x)],1:numResources,'uni',0)');
        D = D';
        % rescale D s.t. W > D'W
        D = 0.3*D;
    case 'sparse'
        w = [numResources:-1:1];
        % construct D matrix
        d = fliplr(w)./numResources;
        D = cell2mat(arrayfun(@(x) [zeros(1,x),d(1:end-x)],1:numResources,'uni',0)');
        D = D';
        % rescale D s.t. W > D'W
        D = 0.3*D;
        
        M = binornd(1,p,[numResources,numResources]);
        D = M.*D;
    case 'rand'
        D = rand(numResources);
        scale = p;
        D = D.*scale;
end
        

        
end

