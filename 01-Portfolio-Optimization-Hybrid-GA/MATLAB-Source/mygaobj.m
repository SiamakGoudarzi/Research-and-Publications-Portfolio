function f = mygaobj (x)
    global M1;
    global M2;
    global M3;
    global NFE;
    global boundary;
    global VarMin;
    global VarMax;
    global nVar;
    
    NFE = NFE+1;
    skew_zarib = .001;
    penalty1 = 0;
    
    for uperCnt=1:nVar
        if (x(uperCnt) > VarMax)
            penalty1 = penalty1 + x(uperCnt) - VarMax;
        end
    end
    
    risk = sqrt(x*M2*x')/boundary
    if (risk > 1)
        f = 0;
    else
    penalty = sum(x);
    skew = -skew_zarib * (x*M3*kron(x',x'))
    exp_r = -(1 * (M1*x'))+skew
    f = exp_r + (2*abs (exp_r*(penalty1+abs(1-penalty))))
    end
end
