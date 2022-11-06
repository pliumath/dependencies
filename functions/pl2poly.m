function poly = pl2poly(pl,lb)
%PL2POLY Calculates the polynomial for a phylogenetic tree from
%  its parent list of the shape.
%
%  POLYNOMIAL = PL2POLY(PARENTLIST,LABELS) Returns the 
%  polynomial for a phylogenetic tree. The polynomial is stored in the 
%  form of flat vector. In each row of a vector, the first n entries 
%  represent the exponents of variables in a term and the last entry is 
%  the coeeficient. 
%
%  Example:
%    % the flat vector [1,0,1] represents x, [1,2,3] represents 3xy^2,
%    [0,1,1;2,0,1] represents x^2+y and [1,0,1,1,2] represents 2x_1x_3y.
%

% check if tip label exists
xst = exist('lb','var');

% prepare the list by assigning layer labels
T = layerlabeling(pl);
    
% get the size of the list(number of nodes)
n = size(T,1);
    
% get the height of the tree
h = max(T(:,2));
    
% initialize a temporary memory of polynomials for all nodes
C = cell(n,1);
    
% add original index for referring
T(:,3) = 1:n;

% get the number of labels and number of tips
if xst
    
    nlbs = 37; % 14 for denpendance tree
    tps = setdiff((1:n)',unique(T(:,1)));
    
else
    
    nlbs = 1/2;
    
end

for i = 1:n
        
    % check if tip labels are provided
    if ~xst
        
        C{i} = [1,0,1];
        
    else
        
        % set up the default polynomial
        C{i} = zeros(1,2*nlbs+1);
        
        % set up the polynomial for tips
        for j = 1:length(tps)
            
            C{tps(j)}(1,2*nlbs+1) = 1;
            C{tps(j)}(1,lb(tps(j))) = 1;
            
        end
        
    end
        
end
    
% compute the polynomial from leaves to the root
for i = h:-1:1
        
    % find the set of level i nodes
    n_i = T(T(:,2)==i,:);
        
    % find the parents of level i nodes
    p_i = unique(n_i(:,1));

    Tset = cell(length(p_i),1);

    % compute the polynomials for each parent node
    parfor j = 1:length(p_i)
            
        % find all children under then parent node p_i(j)
        children = n_i(n_i(:,1)==p_i(j),3);
            
        % initialize the polynomial for the parent node p_i(j)
        uno = zeros(1,2*nlbs+1);
        uno(1,2*nlbs+1) = 1;
        tempoly = uno;
            
        for k = 1:length(children)
                
            % multiply the polynomials of the children
            tempoly = polyproduct(tempoly,C{children(k)});
                
        end
            
        % finalize the computation by +y
        y = zeros(1,2*nlbs+1);
        y(1,2*nlbs+1) = 1;
        y(1,nlbs+lb(p_i(j))) = 1;
        tempoly = [tempoly;y];
        
        % update the polynomial for the parent node p_i(j)
        Tset{j} = tempoly;
            
    end

    for j = 1:length(p_i)
        C{p_i(j)} = Tset{j};
    end
        
end

% return the polynomial for the tree
r = find(T(:,2)==0);
poly = sortrows(C{r},'descend');
format long g

end