function [acc, cmtest]=AccTest(x,trn,vald)
SzW=0.01;
x=x>0.5;
x=logical(x);


training=trn(:,1:end-1);
validation= vald(:,1:end-1);

% KNN Classifier

c = knnclassify(validation(:,x),training(:,x),trn(:,end),5);
cp = classperf(vald(:,end),c);

acc = cp.CorrectRate;
cmtest=cp.CountingMatrix;
