function P = plotdependency(pl,wd,s)
%PLOTDEPENDENCY plots the dependency tree of a sentence represented by its
%parent list pl and words wd.

Cls = lines(7); %load colors
Colors(1,:) = Cls(1,:);
Colors(2,:) = Cls(3,:);
Colors(3,:) = Cls(4,:);
Colors(4,:) = Cls(5,:);
Colors(5,:) = Cls(2,:);

fs = 18; %set font size

n = size(pl,1); %number of nodes

T(:,2) = pl(:,1);
T(:,1) = (1:n)';

rt = T(T(:,2) == 0,1); %root of the tree
T(T(:,2) == 0,:) = [];

A = sparse(T(:,1),T(:,2),1); 

A(:,n) = 0;
A = A+A';
G = graph(A);

WD = cell(n,1);

for i = 1:n

    WD(i,1) = strcat(wd{i},{''},'(',num2str(pl(i,2)),')');

end


set(gcf,'position',[0 0 2000 600]);
P = plot(G,'LineWidth',2,'Layout','layered','Sources',rt,'MarkerSize',7);

P.EdgeColor=Colors(s,:);
P.NodeColor=Colors(s,:);
P.NodeLabel = WD;
P.NodeFontSize = fs;
P.NodeFontName = 'Palatino';

TTL = wd{1};

for i = 2:n

    TTL = strcat(TTL,{' '},wd{i});

end

box on

dim = [0.22,0.82, 0.625, 0.1];
annotation('textbox',dim,'String',TTL,'FontSize',fs,'FontName','Palatino','LineStyle','none');

end