
% Data = DatosBalanceados;
Data = DatosBalanceados;
%Separaci??n de caracter??sticas y variables a predecir

%--------------------------------------------------------------------------

Rept = 10;
tiempo = 0;
EfiTest= zeros(1, Rept);
NumArboles = 10;
sensibTest= zeros(1, Rept);
especifi= zeros(1, Rept);
ErrorTest = zeros(1,Rept);
Pres = zeros(1,Rept);
time= tic;
ECMTest=zeros(1,Rept);
for fold = 1:Rept
    %Separaci??n de los conjuntos de entrenamiento y validaci??n
    [ Xtrain , Ytrain, Xtest, Ytest] = splitData(Data,70);
    %----------------------------------------------------------------------
    %------------- Normalizaci??n ------------------------------------------
    [XtrainN,mu,sigma] = zscore(Xtrain);
    XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
    %----------------------------------------------------------------------
    %------------- Entrenamiento ------------------------------------------  
    perm = randperm(5);
    
    %Modelo = TreeBagger(NumArboles, XtrainN, Ytrain, 'oobpred', 'on','NVarToSample',perm(3));     % Obteniendo ???r.
    Modelo = TreeBagger(NumArboles, XtrainN, Ytrain,'Method','regression');     % Obteniendo ???r.

    
     %----------------------------------------------------------------------
    %------------- Validaci???n ---------------------------------------------
    
    Yest = predict(Modelo, XtestN); 
    ECMTest(fold) = (sum((Yest-Ytest).^2))/length(Ytest);
    % Invocaci???n a la validaci???n.  
    disp(ECMTest)
    ECM = mean(ECMTest);
    IC = std(ECMTest);
    disp(ECM)
    disp(IC)
    Texto=['El error cuadratico medio obtenida fue = ', num2str(ECM),' +- ',num2str(IC)];
    disp(Texto);
    tiempoEnt = tiempo/Rept;
    toc(time);
   
end
