function y=AccTrain(x,trn)

SzW=0.01; % for alpha and beta
x=x>0.5;
x=logical(x);

if sum(x)==0
    y=inf;
    return;
end

training=trn(:,1:end-1);

% KNN Classifier

Mdl = fitcknn(training(:,x),trn(:,end));
CVKNNMdl = crossval(Mdl,'kfold',5);
classError = kfoldLoss(CVKNNMdl);

y=(1-SzW)*(classError)+(SzW)*sum(x)/(length(x));



