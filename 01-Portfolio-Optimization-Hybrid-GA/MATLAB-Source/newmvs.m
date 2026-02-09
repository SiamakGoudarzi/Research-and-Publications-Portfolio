clc; clear; close all;

%% Problem Definition
global NFE;
NFE=0;

CostFunction=@(x) mygaobj(x);     % Cost Function

global VarMin;
global VarMax;
global boundary;
global r1;
global r2;

VarMin=0;         % Lower Bound of Variables
VarMax= .25;         % Upper Bound of Variables
boundary = 6;         % Max Acceptable Variance

%% Problem Data
P = xlsread ('cluster2.xls');
global nVar;

% Number of monthly returns (Times)
T = size(P,1);

nVar=size(P,2);             % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size
% m-vector containing the expected returns of securities
global M1;
M1=mean(P);

% Computation of M2, the covariance matrix
S=[];
for i=1:nVar
    for j=1:nVar
        u=0;
        for t=1:T
            u=u+((P(t,i)-mean(P(:,i)))*(P(t,j)-mean(P(:,j))));
        end
        S(i,j)=u/((T)-1);
    end
end
global M2;
M2=S; %

% Computation of M3, the co-skewness matrix
global M3;
M3=[];
for i=1:nVar
    S=[];
    for j=1:nVar
        for k=1:nVar
            u=0;
            for t=1:T 
                u=u+((P(t,i)-mean(P(:,i)))*(P(t,j)-mean(P(:,j))) ...
                    *(P(t,k)-mean(P(:,k))));
            end
            S(j,k)=u/(T); 
        end
    end
    M3=[M3 S];
end

%% GA Parameters

MaxIt=1000;      % Maximum Number of Iterations

nPop=40;        % Population Size

pc=0.75;                 % Crossover Percentage
nc=2*round(pc*nPop/2);  % Number of Offsprings (Parnets)

pm=0.2;                 % Mutation Percentage
nm=round(pm*nPop);      % Number of Mutants

%gamma=0.2;

mu=0.01;         % Mutation Rate

ANSWER=questdlg('Choose selection method:','Genetic Algorith',...
    'Roulette Wheel','Tournament','Roulette Wheel');


UseRouletteWheelSelection=strcmp(ANSWER,'Roulette Wheel');
UseTournamentSelection=strcmp(ANSWER,'Tournament');

if UseRouletteWheelSelection
    beta=5;         % Selection Pressure
end

if UseTournamentSelection
    TournamentSize=4;   % Tournamnet Size
end

pause(0.1);

% Array to Hold Number of Function Evaluations
nfe=zeros(MaxIt,1);

%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];

pop=repmat(empty_individual,nPop,1);

for i=1:nPop
    
    % Initialize Position 
    x=unifrnd(VarMin,VarMax,VarSize);
    t = sum (x);
    x = x / t;
    for lowerCnt=1:nVar
        if (x(lowerCnt) < VarMin)
            x(lowerCnt) = VarMin;
        end
    end
    for uperCnt=1:nVar
        if (x(uperCnt) > VarMax)
            x(uperCnt) = VarMax;
        end
    end
  
       
    pop(i).Position = x;
    % Evaluation
    pop(i).Cost=CostFunction(pop(i).Position);
    
end

% Sort Population
Costs=[pop.Cost];
[Costs, SortOrder]=sort(Costs);
pop=pop(SortOrder);

% Store Best Solution
BestSol=pop(1);

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);
objectiveFunction = zeros(MaxIt,1);
% Store Cost
WorstCost=pop(end).Cost;


%% Main Loop
stopIt = MaxIt;
for it=1:MaxIt
    
    % Calculate Selection Probabilities
    if UseRouletteWheelSelection
        P=exp(-beta*Costs/WorstCost);
        P=P/sum(P);
    end
    
    % crossover2
    popc=repmat(empty_individual,nc/2,2);
    for k=1:nc/2
        
        % Select Parents Indices
        if UseRouletteWheelSelection
            i1=RouletteWheelSelection(P);
            i2=RouletteWheelSelection(P);
        end
        if UseTournamentSelection
            i1=TournamentSelection(pop,TournamentSize);
            i2=TournamentSelection(pop,TournamentSize);
        end


        % Select Parents
        p1=pop(i1);
        p2=pop(i2);
        
        % Apply Crossover
        [popc(k,1).Position popc(k,2).Position]=...
            Crossover3(p1.Position,p2.Position,VarMin,VarMax);
        
        % Evaluate Offsprings
        popc(k,1).Cost=CostFunction(popc(k,1).Position);
        popc(k,2).Cost=CostFunction(popc(k,2).Position);
        
    end
    popc=popc(:);
    
    
    % Mutation
    popm=repmat(empty_individual,nm,1);
    for k=1:nm
        
        % Select Parent
        i=randi([1 nPop]);
        p=pop(i);
        
        % Apply Mutation
        popm(k).Position=Mutate(p.Position,mu,VarMin,VarMax);
        
        % Evaluate Mutant
        popm(k).Cost=CostFunction(popm(k).Position);
        
    end
    
    % Create Merged Population
    pop=[pop
         popc
         popm];
     
    % Sort Population
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);
    
    % Update Worst Cost
    WorstCost=max(WorstCost,pop(end).Cost);
    
    % Truncation
    pop=pop(1:nPop);
    Costs=Costs(1:nPop);
    
    % Store Best Solution Ever Found
    BestSol=pop(1);
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    objectiveFunction (it) = sum (M1 * BestSol.Position');
    % Store NFE
    nfe(it)=NFE;    
    if (it > 80)
        if (abs (BestCost(it)-BestCost(it-80)) < abs (.0002) )
            stopIt = it;
            break;
        end
    end
    
end

clc;
disp (['BestSol.Cost: ' num2str(BestSol.Cost)]); 
disp (['BestSol.Position: ' num2str(BestSol.Position)]); 

figure (1);
semilogy(1:MaxIt,BestCost,'LineWidth',4);
plot (1:stopIt, -1 * BestCost(1:stopIt));
xlabel('Iteration');
ylabel('Objective Function');