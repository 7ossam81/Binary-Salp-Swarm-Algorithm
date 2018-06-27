%  Binary Salp Swarm Algorithm (SSA) developed by 
%  Faris, H., Mafarja, M.M., Heidari, A.A., Aljarah
%  
%  The code is based on:
%  Salp Swarm Algorithm (SSA) source codes version 1.0
%
%  Developed by Seyedali Mirjalili
%               e-Mail: ali.mirjalili@gmail.com
%                       seyedali.mirjalili@griffithuni.edu.au
%               Homepage: http://www.alimirjalili.com        
%       
%
%   Main papers:
%
%   S. Mirjalili, A.H. Gandomi, S.Z. Mirjalili, S. Saremi, H. Faris, S.M. Mirjalili,
%   Salp Swarm Algorithm: A bio-inspired optimizer for engineering design problems
%   Advances in Engineering Software
%   DOI: http://dx.doi.org/10.1016/j.advengsoft.2017.07.002
%
%   Faris, H., Mafarja, M.M., Heidari, A.A., Aljarah, I., Ala’M, A.Z., Mirjalili, S. and Fujita, H., 2018. 
%   An efficient binary Salp Swarm Algorithm with crossover scheme for feature selection problems. 
%   Knowledge-Based Systems, 154, pp.43-67.
%   https://doi.org/10.1016/j.knosys.2018.05.009
%____________________________________________________________________________________

function [FoodFitness,FoodPosition,Convergence_curve,Time]=BSSA(N,Max_iter,dim,trn,TFid)


tic;
Convergence_curve = zeros(1,Max_iter);

%Initialize the positions of salps
SalpPositions=initialization(N,dim,1,0)>0.5;



FoodPosition=zeros(1,dim);
FoodFitness=inf;


%calculate the fitness of initial salps

for i=1:size(SalpPositions,1)
      fitness=AccTrain(SalpPositions(i,:),trn);
      SalpFitness(1,i)=fitness;
end

[sorted_salps_fitness,sorted_indexes]=sort(SalpFitness);

for newindex=1:N
    Sorted_salps(newindex,:)=SalpPositions(sorted_indexes(newindex),:);
end

FoodPosition=Sorted_salps(1,:);
FoodFitness=sorted_salps_fitness(1);

%Main loop
l=2; % start from the second iteration since the first iteration was dedicated to calculating the fitness of salps
while l<Max_iter+1
    
    c1 = 2*exp(-(4*l/Max_iter)^2); % Eq. (3.2) in the paper

    
    for i=1:size(SalpPositions,1)
        
        SalpPositions= SalpPositions';
        
        if i<=N/2
            for j=1:1:dim
                c2=rand();
                c3=rand();
                %%%%%%%%%%%%% % Eq. (3.1) in the paper %%%%%%%%%%%%%%
                if c3<0.5 
                       temp=FoodPosition(j)+c1*c2; %Binary
                       SalpPositions(j,i)=trnasferFun(SalpPositions(j,i),temp,TFid);  %Binary                              
                else
                       temp=FoodPosition(j)-(c1*c2); %Binary
                       SalpPositions(j,i)=trnasferFun(SalpPositions(j,i),temp,TFid);  %Binary 
                 end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
            
        elseif i>N/2 && i<N+1
            point1=SalpPositions(:,i-1);
            point2=SalpPositions(:,i);
            
            SalpPositions(:,i)=(point2+point1)/2; % % Eq. (3.4) in the paper
        end
        
        SalpPositions= SalpPositions';
    end
    
    for i=1:size(SalpPositions,1)
        
        Tp=SalpPositions(i,:)>1;
        Tm=SalpPositions(i,:)<0;
        ub=1;
        lb=0;
        SalpPositions(i,:)=(SalpPositions(i,:).*(~(Tp+Tm)))+ub'.*Tp+lb'.*Tm;
        
        
         fitness=AccTrain(SalpPositions(i,:),trn);

        SalpFitness(1,i)=fitness;
        
        if SalpFitness(1,i)<FoodFitness
            FoodPosition=SalpPositions(i,:);
            FoodFitness=SalpFitness(1,i);
        end
    end
    if mod(l,1)==0
       display(['At iteration ', num2str(l), ' the best universes fitness is ', num2str(FoodFitness,'%.9f')]);
    end
    Convergence_curve(l)=FoodFitness;
    l = l + 1;
end
Time = toc;


