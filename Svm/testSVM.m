function [Ytest,Z] = testSVM(Modelo,Xtest)
     
     [Ytest,Z]=simlssvm(Modelo,Xtest);
end
