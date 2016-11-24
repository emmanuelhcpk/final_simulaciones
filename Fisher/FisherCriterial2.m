function criterial = FisherCriterial2( Xtrain, Ytrain, Xtest, Ytest)

[XtrainN,mu,sigma] = zscore(Xtrain);
XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);

CLASS = classify(XtestN,XtrainN,Ytrain);
criterial = sum(CLASS ~= Ytest);

