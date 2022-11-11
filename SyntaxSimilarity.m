%% load dataset and result

clear,clc

addpath('functions/');
addpath('data/');
addpath('data/PUD');

Datasets = {'ENG','GER','FRE','ITA','SPA'};

s = 1; %dataset index

load(strcat(Datasets{s},'.mat'))

%% get minimum and maximum distance sentences

l1 = 2; % 2-Chinese
l2 = 4; % 4-English

[m,mp,M,Mp] = extremepairs(D,L,l1,l2); 

%%

mp1 = mp(1);

[plm1,wdm1] = getsentence(L,mp1,l1);
[plm2,wdm2] = getsentence(L,mp1,l2);

[plM1,wdM1] = getsentence(L,Mp,l1);
[plM2,wdM2] = getsentence(L,Mp,l2);

%% minimum language distance tree in language one
figure
Pm1 = plotdependency(plm1,wdm1,s);
 
%% minimum language distance tree in language two
figure
Pm2 = plotdependency(plm2,wdm2,s);

%% maximum language distance tree in language one
figure
PM1 = plotdependency(plM1,wdM1,s);

%% maximum language distance tree in language two
figure
PM2 = plotdependency(plM2,wdM2,s);
