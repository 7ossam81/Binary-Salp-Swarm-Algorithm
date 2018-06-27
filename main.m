function main


%Parameters
AgentsNum=30;
MaxIteration=5;
TFid = 2;   %Transfer Function Selection  1-4: Sigmoid, 5-8: V-shaped
            %Check the transferFun.m for more details

data=load('Breastcancer.mat');

trn= data.trn; %training data
vald=data.vald; %testing data
nVar=size(trn,2)-1; % Original number of features in the dataset


[TargetFitness,TargetPosition,convergence, Time]=BSSA(AgentsNum,MaxIteration,nVar,trn,TFid); % training phase
[acc,cmtest] = AccTest(TargetPosition,trn,vald); % testing phase


redDim  = sum(TargetPosition(:)); % number of selected features

display(['Accuracy: ', num2str(acc), ' ----', 'Number of features:',num2str(redDim) ]);








