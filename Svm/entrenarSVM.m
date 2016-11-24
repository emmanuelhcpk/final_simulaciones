function Modelo = entrenarSVM(X,Y,tipo,boxConstraint,sigma)
    %Kernel para clasificaciòn%
    
    Modelo=trainlssvm({X,Y,tipo,boxConstraint,sigma});
end
