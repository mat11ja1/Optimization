function D = DFP(D,p,q)
D =  D + p*p'/(p'*q) - D*q*q'*D/(q'*D*q);
