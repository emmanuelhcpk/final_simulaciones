Data = DatosBalanceados;
[ Xtrain , Ytrain, Xtest, Ytest] = splitData(Data,70);
matriz=corrcoef(Xt);
criterial = FisherCriterial2(Xtrain , Ytrain, Xtest, Ytest);

