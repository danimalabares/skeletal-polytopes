# Define the golden ratio
# Define the matrices
R0 := [ [ -1, 0, 0, 0 ],
        [ 0, 1, 0, 0 ],
        [ 0, 0, 1, 0 ],
        [ 0, 0, 0, 1 ] ];

R1 := [ [ 0, 1, 0, 0 ],
        [ 1, 0, 0, 0 ],
        [ 0, 0, 1, 0 ],
        [ 0, 0, 0, 1 ] ];

R2 := [ [ 1, 0, 0, 0 ],
        [ 0, 0, 1, 0 ],
        [ 0, 1, 0, 0 ],
        [ 0, 0, 0, 1 ] ];

R3 := [ [ 1, 0, 0, 0 ],
        [ 0, 1, 0, 0 ],
        [ 0, 0, 0, 1 ],
        [ 0, 0, 1, 0 ] ];

g:=Group([R0,R1,R2,R3]);

S1:=R0*R1*R3*R2;
S2:=R2*R1;
S3:=R3*R2;

q:=Subgroup(g,[S1,S2,S3]);

#Define a function to act on sets of sets of sets (cells are such kind of sets)
OnSetsSetsSets:=
function(cell,g)
	return Set(List(cell, function ( i )
		return OnSetsSets(i,g);
		end ) );
	end;

#Counting the Regular Convex hypercube (8-cell)

vRC:=[1,1,1,1]; #Basic vertex
PvRC:=Orbit(g,vRC,OnPoints);#Vertices in the polytope
eRC:=[vRC,OnRight(vRC,R0)];#Basic edge
EfRC:=Orbit(Subgroup(g,[R0,R1]),SortedList(eRC),OnSets);#Edges in the face
EcRC:=Orbit(Subgroup(g,[R0,R1,R2]),SortedList(eRC),OnSets);#Edges in the cell
EpRC:=Orbit(g,SortedList(eRC),OnSets);#Edges in the polytope
FcRC:=Orbit(Subgroup(g,[R0,R1,R2]),SortedList(EfRC),OnSetsSets);#Faces in the cell
FpRC:=Orbit(g,SortedList(EfRC),OnSetsSets);#Faces in the polytope
CpRC:=Orbit(g,SortedList(FcRC),OnSetsSetsSets);#Cells in the polytope

Print("\n","Hypercube","\n","\n");
Print("Vertices in the polytope: ",Size(PvRC),"\n");
Print("Edges in the face: ",Size(EfRC),"\n");
Print("Edges in the cell: ",Size(EcRC),"\n");
Print("Edges in the polytope: ",Size(EpRC),"\n");
Print("Faces in the cell: ",Size(FcRC),"\n");
Print("Faces in the polytope: ",Size(FpRC),"\n");
Print("Cells in the polytope: ",Size(CpRC),"\n","\n","\n");


#Counting the Chiral Roli's Cube

vC:=[1,1,1,1]; #Basic vertex (same as the regular)
PvRC:=Orbit(q,vC,OnPoints);#Vertices in the polytope
eC:=[vC,OnRight(vC,S1^-1)];#Basic edge
EfC:=Orbit(Subgroup(q,[S1]),SortedList(eC),OnSets);#Edges in the face
EcC:=Orbit(Subgroup(q,[S1,S2]),SortedList(eC),OnSets);#Edges in the cell
EpC:=Orbit(q,SortedList(eC),OnSets);#Edges in the polytope
FcC:=Orbit(Subgroup(q,[S1,S2]),SortedList(EfC),OnSetsSets);#Faces in the cell
FpC:=Orbit(q,SortedList(EfC),OnSetsSets);#Faces in the polytope
CpC:=Orbit(q,SortedList(FcC),OnSetsSetsSets);#Cells in the polytope

Print("Chiral","\n","\n");
Print("Vertices in the polytope: ",Size(PvRC),"\n");
Print("Edges in the face: ",Size(EfC),"\n");
Print("Edges in the cell: ",Size(EcC),"\n");
Print("Edges in the polytope: ",Size(EpC),"\n");
Print("Faces in the cell: ",Size(FcC),"\n");
Print("Faces in the polytope: ",Size(FpC),"\n");
Print("Cells in the polytope: ",Size(CpC));






