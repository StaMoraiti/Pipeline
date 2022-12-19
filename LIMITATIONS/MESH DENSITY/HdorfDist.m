function H=HdorfDist(P,Q)

D = pdist2(P,Q);
hab = max(min(D,[],2));% Directed from a to b
hba = max(min(D));% Directed from b to a
H = max([hab,hba]);