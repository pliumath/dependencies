function lpl = layerlabeling(pl)
%LAYERLABELING Computes the layers or heights for each node in the tree and
%  updates the parent list.
%
%  LAYERLABLEDPARENTLIST = LAYERLABELING(PARENTLIST) Returns the layer
%  labeled parent list of a given list, which prepares the computation of
%  the polynomial.
%


% set a temporary list
T = pl;
T(:,2) = 0;

% find the label of the root as a current parent node
cp = find(T(:,1)==0);

% set up the initial label
lb = 0;

while 1
    
    % update the label
    lb = lb + 1;
    
    % clear the temporary memory of nodes in a layer
    tmp = [];
    
    % go through all the nodes in a layer
    for i = 1:length(cp)
    
        % find all the children of a node
        children = find(T(:,1)==cp(i));
        
        % label them with the new label
        T(children,2) = lb;
        
        % store the child nodes for the next layer as parent nodes
        tmp = [tmp;children];
    
    end
    
    % update the current parent nodes
    cp = tmp;
    
    % termination condition
    if length(find(T(:,2)==0))==1
        
        break;
        
    end
    
end

% return the layer labeled parent list
lpl = T;

end