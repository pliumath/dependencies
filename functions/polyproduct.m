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
    
    Tpro = zeros(m,v);
    blk = zeros(1,v);

    parfor j = 1:m

        tp = p;
        tq = q;
        
        % get terms to multiply
        a = tp(i,:);
        b = tq(j,:);
        
        % preallocate the product
        ab = blk;
        
        % multiply
        for k = 1:v
            
            if k ~= v
                
                ab(k) = a(k) + b(k);
                
            else
                
                ab(k) = a(k)*b(k);
                 
            end
        end
        
        % update he temporary product
        Tpro(j,:) = ab;
        
    end

    for j = 1:m

        temp((i-1)*m+j,:) = Tpro(j,:);

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