#REGULAR CONVEX {3,3,5}

f:=FreeGroup("E0","E1","E2","E3");
g:=f/[f.1^2,f.2^2,f.3^2,f.4^2,
(f.1*f.2)^3,(f.2*f.3)^3,(f.3*f.4)^5,
(f.1*f.3)^2,(f.1*f.4)^2,(f.2*f.4)^2];

# Rename the generators of g
E0:=g.1;
E1:=g.2;
E2:=g.3;
E3:=g.4;

g:=Group([E0,E1,E2,E3]);#Group of {3,3,5}
cg:=Subgroup(g,[E0,E1,E2]);#Cell group
fg:=Subgroup(g,[E0,E1]);#Face group

#REGULAR STAR {5/2,3,5}

P0:=E0;
P1:=E1*E2*E3*E2*E1*E0*E1*E2*E3*E2*E1;
P2:=E3;
P3:=E2;

h:=Group([P0,P1,P2,P3]);#Group of {5/2,3,5}
ch:=Subgroup(h,[P0,P1,P2]);#Cell group
fh:=Subgroup(h,[P0,P1]);#Face group


#QUIRAL {12/(1,5),3,5}

S1:=P0*P1*P3*P2;
S2:=P2*P1;
S3:=P3*P2;

q:=Subgroup(h,[S1,S2,S3]);#Group of the chiral
cq:=Subgroup(q,[S1,S2]);#Cell group
fq:=Subgroup(q,[S1]);#Face group



#TEST FOR COMBINATORIAL CHIRALITY

#Find the automorphism within the cell
rho:=GroupHomomorphismByImages(cq,cq,[S1,S2],[S1^-1,S1^2*S2]);

#Ask GAP how this automorphism acts on the generators
Print("\n","rho(S1)=S1^-1  ",Image(rho,S1)=S1^-1,"\n");
Print("rho(S2)=S1^2*S2  ",Image(rho,S2)=S1^2*S2,"\n");


#Find the automorphism within the whole polytope
rho2:=GroupHomomorphismByImages(q,q,[S1,S2,S3],[S1^-1,S1^2*S2,S3]);

Print("\n","Can we extend to the whole group?  ",rho2,"\n");
