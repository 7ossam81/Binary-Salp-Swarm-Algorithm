function Positions=initialization(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries

if Boundary_no==1
    Positions=rand(SearchAgents_no,dim)*(ub-lb)+lb;
end