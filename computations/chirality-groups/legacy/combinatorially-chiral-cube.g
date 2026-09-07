#REGULAR CONVEX {4,3,3}

f:=FreeGroup("E0","E1","E2","E3");
g:=f/[f.1^2,f.2^2,f.3^2,f.4^2,
(f.1*f.2)^4,(f.2*f.3)^3,(f.3*f.4)^3,
(f.1*f.3)^2,(f.1*f.4)^2,(f.2*f.4)^2];

# Rename the generators of g
E0:=g.1;
E1:=g.2;
E2:=g.3;
E3:=g.4;


#CUBO DE ROLI

S1:=E0*E1*E3*E2;
S2:=E2*E1;
S3:=E3*E2;

q:=Subgroup(g,[S1,S2,S3]);#Group of the chiral
cq:=Subgroup(q,[S1,S2]);#Cell group
fq:=Subgroup(q,[S1]);#Face group



#TEST FOR COMBINATORIAL CHIRALITY

# Recall that in Schulte & Weiss, Chiral Polytopes, 1991
# we have that an abstract polytope is directly regular
# if and only if there is an involutory automorphism rho 
# such that

# rho(s1) = s1^-1,
# rho(s2) = s1^2 * s2
# rho(s3) = s3



#Find rho within the cell
rho:=GroupHomomorphismByImages(cq,cq,[S1,S2],[S1^-1,S1^2*S2]);

#Ask GAP how this automorphism acts on the generators
Print("\n","rho(S1)=S1^-1  ",Image(rho,S1)=S1^-1,"\n");
Print("rho(S2)=S1^2*S2  ",Image(rho,S2)=S1^2*S2,"\n");


#Find rho within the whole polytope
rho2:=GroupHomomorphismByImages(q,q,[S1,S2,S3],[S1^-1,S1^2*S2,S3]);

Print("\n","Can we extend to the whole group?  ",rho2,"\n");
