%This function checks whether a constraint is met 
%%
function [y1 y2]=Crossover3(x1,x2,VarMin,VarMax)
    global nVar;
    global r1;
    global r2;

    r1 = randi ([1,nVar-2],1)
    r2 = randi ([r1+1,nVar-1],1)
    y1_copy = x1;
    y2_copy = x2;
    y1 = [y1_copy(1:r1) y2_copy(r1+1:r2) y1_copy(r2+1:nVar) ];
    y2 = [y2_copy(1:r1) y1_copy(r1+1:r2) y2_copy(r2+1:nVar)];
    
    y1sum = sum (y1);
    y1 = y1/ y1sum;
    y1=max(y1,VarMin);
    y1=min(y1,VarMax);
    y1sum = sum (y1);
    y1 = y1/ y1sum;
    
    y2sum = sum (y2);
    y2 = y2/ y2sum;
    y2=max(y2,VarMin);
    y2=min(y2,VarMax);
    y2sum = sum (y2);
    y2 = y2/ y2sum;
    isFeasible1 = IsFeasible (y1);
    isFeasible2 = IsFeasible (y2);
    
    if (~isFeasible1)
        y1 = x1;
    end
    if (~isFeasible2)
        y2 = x2;
    end

        
end
