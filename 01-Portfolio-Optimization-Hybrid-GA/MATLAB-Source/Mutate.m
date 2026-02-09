function y=Mutate(x,mu,VarMin,VarMax)
    
   
    global nVar;
    
   
    % Selecting Gens to mutate
    k1 = 0;
    k2 = 0;
    while (k1 == k2)
        k1 = randi (nVar);
        k2 = randi (nVar);
    end
    
    validRange = min ([x(k2)-VarMin VarMax-x(k1)]);
    changeSize = 0 + ((validRange-0)*rand(1));
    y=x;
    y(k1) = x (k1) + changeSize;
    y(k2) = x (k2) - changeSize;
    %y(j)=x(j)+sigma*randn(size(j));

    %y=max(y,VarMin);
    %y=min(y,VarMax);
    %ysum = sum (y);
    %y = y / ysum;
    isFeasible1 = IsFeasible (y);  
    if (~isFeasible1)
            y = x;
    end

end