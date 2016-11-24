
clc
%clear all
close all

Rept=10;

boxConstraint=1;%[0.01 0.1 1 10 100];
for gamma=[0.01 0.1 1 10 100];
    

    %%% punto de regresi???n %%%

    ECMTest=zeros(1,Rept);
    NumMuestras=size(X,1);

    for fold=1:Rept

        %%% Se hace la partici???n de las muestras %%%
        %%%      de entrenamiento y prueba       %%%
        rng('default');
        particion=cvpartition(NumMuestras,'Kfold',Rept);
        Xtrain=X(particion.training(fold),:);
        Xtest=X(particion.test(fold),:);
        Ytrain=Y(particion.training(fold));
        Ytest=Y(particion.test(fold));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%% Se normalizan los datos %%%

        [Xtrain,mu,sigma]=zscore(Xtrain);
        Xtest=(Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%% Entrenamiento del modelo. %%%

        Modelo=entrenarSVM(Xtrain,Ytrain,'f',boxConstraint,gamma); %incluir par???metros adicionales, boxcontrain,gamma si aplica, etc...
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%% Validaci???n del modelo. %%%

    Yest=testSVM(Modelo,Xtest);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ECMTest(fold)=(sum((Yest-Ytest).^2))/length(Ytest);

    end
    ECM = mean(ECMTest);
    IC = std(ECMTest);  
    Texto=['El error cuadratico medio obtenida fue = ', num2str(ECM),' +- ',num2str(IC)];
    disp(Texto);

    %%% Fin punto de regresi???n %%%



end



