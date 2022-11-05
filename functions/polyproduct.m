function prd = polyproduct(p,q)
%POLYPRODCUT Computes the product of two polynomials in the form of flat
%  vectors.
%
%  PRODUCT = POLYPRODUCT(P,Q) Returns the product of two polynomials in the
%  form of flat vectors.
%


% get the number of variables
v = size(p,2);

% get the number of terms in the polynomials
n = size(p,1);
m = size(q,1);

% set up the temporary product
temp = zeros(n*m,v);

% compute the polynomial
for i = 1:n
    
    for j = 1:m
        
        % get terms to multiply
        a = p(i,:);
        b = q(j,:);
        
        % preallocate the product
        ab = zeros(1,v);
        
        % multiply
        for k = 1:v
            
            if k ~= v
                
                ab(k) = a(k) + b(k);
                
            else
                
                ab(k) = a(k)*b(k);
                 
            end
        end
        
        % update he temporary product
        temp((i-1)*m+j,:) = ab;
        
    end
    
end

% prd = temp;

% combine similar terms
uniqterms = unique(temp(:,1:(v-1)),'rows');
uniqterms(:,v) = 0;

for i = 1:size(uniqterms,1)
    
    % locate the similar terms
    pla = issimilar(uniqterms(i,:),temp(:,:));
    
    % add the coefficients
    uniqterms(i,v) = sum(temp(pla,v));
    
end

% return the product
prd = uniqterms;

end