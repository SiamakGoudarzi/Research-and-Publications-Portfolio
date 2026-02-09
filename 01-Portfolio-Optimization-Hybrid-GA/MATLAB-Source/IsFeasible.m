%% This function checks if x is 
function feasibility = IsFeasible (x)

global M2;
global boundary;


constraint1 = sqrt(x*M2*x');
if (constraint1 <= boundary(1))
    feasibility1 = 1;
else
    feasibility1 = 0;
end

%constraint2 = x * constraint(:,2);
%if (constraint2 >= boundary(2))
%    feasibility2 = 1;
%else
%    feasibility2 = 0;
%end

feasibility = feasibility1; % * feasibility2;

end
    