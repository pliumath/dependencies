%% load dataset and result

clear,clc

addpath('functions/');
addpath('data/');
addpath('data/PUD');

Datasets = {'ENG','GER','FRE','ITA','SPA'};

s = 1; %dataset index
c = [1,3,4,5,2]; %color order

load(strcat(Datasets{s},'.mat'))

Colors = lines(7); %load colors
fs = 16; %set font size

Names = L(:,1); %get language name mapping

n = size(L,1);
M = mean(D,3);

%%

phy = seqlinkage(M,'average',Names);
phytreeviewer(phy)

LN = get(phy,"LeafNames");

%print phytreeviewer to figure and then proceed

%%

h = findobj(gca,'Type','line');

hx = [h(1).XData,h(2).XData];
hy = [h(1).YData,h(2).YData];

hx = hx(1:38)';
hy = hy(1:38)';

%%

A = getmatrix(phy);
[x,y] = find(A);
EL = get(phy,'Distances');
A = sparse(x,y,EL(1:38));
A(20,38) = sum(A(39,:));
A(39,:) = [];
A = A+A';

G = graph(A);
EW = cell(37,1);

for i = 1:37
    if i <= 20
        EW{i} = num2str(G.Edges.Weight(i),'%.2f');
    else
        EW{i} = '';
    end
end

%% UPGMA

figure('Position', [0 1000 980 600]);

p = plot(G,'XData',hx,'YData',hy,'NodeLabel',[],'EdgeLabel',[], ...
    'EdgeColor','#000000','MarkerSize',7,'LineWidth',1.5, ...
    'NodeFontName','Palatino','NodeFontSize',fs, ...
    'EdgeFontName','Palatino','EdgeFontSize',fs);

highlight(p,21:38,'MarkerSize',0.001,'NodeColor','#000000')
highlight(p,1:20,'NodeColor',Colors(c(s),:))

title('UPGMA dendrogram of the language distance matrix')

hold on

for i = 1:20

    switch i

        
        case 1
        text(hx(i)-1.65,hy(i),LN{i},'fontname','Palatino','fontsize',16)
        case 2
        text(hx(i)-1.25,hy(i),LN{i},'fontname','Palatino','fontsize',16)
        case 3
        text(hx(i)-1,hy(i),LN{i},'fontname','Palatino','fontsize',16)
        case 4
        text(hx(i)-1,hy(i),LN{i},'fontname','Palatino','fontsize',16)
        case 5
        text(hx(i)-1.2,hy(i),LN{i},'fontname','Palatino','fontsize',16)
        case 6
        text(hx(i)+0.1,hy(i),LN{i},'fontname','Palatino','fontsize',16)
        case 20
        text(hx(i)-1.3,hy(i),LN{i},'fontname','Palatino','fontsize',16)
        otherwise

        text(hx(i)+0.1,hy(i),LN{i},'fontname','Palatino','fontsize',16)
    end
end

box on

set(gca,'fontname','Palatino','fontsize',16,'xtick',[],'ytick',[])

%% MDS

figure('Position', [0 1000 980 600]);

Y = cmdscale(M,3);

Y(:,[1,2]) = Y(:,[2,1]);

plot(Y(:,1),Y(:,2),'.','MarkerSize',25,'Color',Colors(c(s),:))

for i = 1:20

    switch i
        case 1 %Arabic
            text(Y(i,1)+0.1,Y(i,2)-0.1,strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 2 %Chinese
            text(Y(i,1)+0.1,Y(i,2),strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 3 %Czech
            text(Y(i,1)-1.2,Y(i,2)+0.3,strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
            line([Y(i,1),Y(i,1)-0.6],[Y(i,2),Y(i,2)+0.15],'Color',Colors(c(s),:),'LineWidth',1.5)
        case 4 %English
            text(Y(i,1)+0.1,Y(i,2),strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 5 %Finnish
            text(Y(i,1)+0.1,Y(i,2)-0.17,strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 6 %French
            text(Y(i,1)+0.1,Y(i,2)+0.15,strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 7 %German
            text(Y(i,1)+0.1,Y(i,2),strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 8 %Hindi
            text(Y(i,1)+0.1,Y(i,2),strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 9 %Icelandic
            text(Y(i,1)+0.1,Y(i,2),strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 10 %Indonesian
            text(Y(i,1)+0.1,Y(i,2)+0.45,strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
            line([Y(i,1),Y(i,1)+0.2],[Y(i,2),Y(i,2)+0.3],'Color',Colors(c(s),:),'LineWidth',1.5)
        case 11 %Italic
            text(Y(i,1)+0.1,Y(i,2)+0.05,strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 12 %Japanese
            text(Y(i,1)+0.1,Y(i,2),strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 13 %Korean
            text(Y(i,1)+0.1,Y(i,2),strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 14 %Polish
            text(Y(i,1)+0.1,Y(i,2)-0.17,strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 15 %Portuguese
            text(Y(i,1)+0.1,Y(i,2)-0.1,strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 16 %Russian
            text(Y(i,1)-1.4,Y(i,2)-0.3,strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
            line([Y(i,1),Y(i,1)-0.7],[Y(i,2),Y(i,2)-0.15],'Color',Colors(c(s),:),'LineWidth',1.5)

        case 17 %Spanish
            text(Y(i,1)+1.5,Y(i,2)+0.1,strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
            line([Y(i,1),Y(i,1)+1.5],[Y(i,2),Y(i,2)+0.1],'Color',Colors(c(s),:),'LineWidth',1.5)
        case 18 %Swedish
            text(Y(i,1)+0.1,Y(i,2),strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 19 %Thai
            text(Y(i,1)+0.1,Y(i,2),strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
        case 20 %Turkish
            text(Y(i,1)+0.1,Y(i,2)+0.1,strcat(Names{i},{' '},'(',num2str(Y(i,3),'%.2f'),')'),'fontname','Palatino','fontsize',16)
    end
end

title("MDS plot (Dim.3 after language names) of the language distance matrix")

xlim([-3,11])
ylim([-4,5])
xlabel("Dim.1")
ylabel("Dim.2")

box on
grid on

set(gca,'fontname','Palatino','fontsize',16)

