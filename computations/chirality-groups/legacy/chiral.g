#Primero se debe cargar este paquete! (Luego lo comento porque pone un anuncio cada vez que leo el archivo) (Es para usar la función IsIsomorphicGroup)
#LoadPackage("sonata");

# Define the golden ratio
rho := (1 + Sqrt(5)) / 2;

# Define the matrices
R0 := (1/2) * [ [rho, 1, 0, -1 + rho],
                [1, 1 - rho, 0, -rho],
                [0, 0, 2, 0],
                [-1 + rho, -rho, 0, 1] ];

R1 := [ [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, -1] ];

R2 := (1/2) * [ [2, 0, 0, 0],
                [0, rho, -1, rho - 1],
                [0, -1, 1 - rho, rho],
                [0, rho - 1, rho, 1] ];

R3 := [ [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, -1, 0],
        [0, 0, 0, 1] ];

g:=Group([R0,R1,R2,R3]);#Group of the 600-cell

P0:=R0;
P1:=R1*R2*R3*R2*R1*R0*R1*R2*R3*R2*R1;
P2:=R3;
P3:=R2;

h:=Group([P0,P1,P2,P3]);#Group of the starry {5/2,3,5}

S1:=P0*P1*P3*P2;
S2:=P2*P1;
S3:=P3*P2;

q:=Subgroup(h,[S1,S2,S3]);#Group of the chiral {(12/1,5),3,5}

#Define a function to act on sets of sets of sets (cells are such kind of sets)
OnSetsSetsSets:=
function(cell,g)
	return Set(List(cell, function ( i )
		return OnSetsSets(i,g);
		end ) );
	end;


#Counting the Regular Convex 600-cell

vRC:=[1,0,0,0]; #Basic vertex
EvRC:=Orbit(Subgroup(g,[R0]),vRC,OnPoints);#Vertices in the edge
FvRC:=Orbit(Subgroup(g,[R0,R1]),vRC,OnPoints);#Vertices in the face
CvRC:=Orbit(Subgroup(g,[R0,R1,R2]),vRC,OnPoints);#Vertices in the cell
PvRC:=Orbit(g,vRC,OnPoints);#Vertices in the polytope
eRC:=[vRC,OnRight(vRC,R0)];#Basic edge
EfRC:=Orbit(Subgroup(g,[R0,R1]),SortedList(eRC),OnSets);#Edges in the face
EcRC:=Orbit(Subgroup(g,[R0,R1,R2]),SortedList(eRC),OnSets);#Edges in the cell
EpRC:=Orbit(g,SortedList(eRC),OnSets);#Edges in the polytope
FcRC:=Orbit(Subgroup(g,[R0,R1,R2]),SortedList(EfRC),OnSetsSets);#Faces in the cell
FpRC:=Orbit(g,SortedList(EfRC),OnSetsSets);#Faces in the polytope
CpRC:=Orbit(g,SortedList(FcRC),OnSetsSetsSets);#Cells in the polytope

Print("\n","600-cell","\n","\n");
Print("Vertices in the edge: ",Size(EvRC),"\n");
Print("Vertices in the face: ",Size(FvRC),"\n");
Print("Vertices in the cell: ",Size(CvRC),"\n");
Print("Vertices in the polytope: ",Size(PvRC),"\n");
Print("Edges in the face: ",Size(EfRC),"\n");
Print("Edges in the cell: ",Size(EcRC),"\n");
Print("Edges in the polytope: ",Size(EpRC),"\n");
Print("Faces in the cell: ",Size(FcRC),"\n");
Print("Faces in the polytope: ",Size(FpRC),"\n");
Print("Cells in the polytope: ",Size(CpRC),"\n","\n","\n");

#Counting the Regular Starry {5/2,3,5}

vRS:=[rho/2,-(1/2),0,1/2-rho/2]; #Basic vertex
EvRS:=Orbit(Subgroup(h,[P0]),vRS,OnPoints);#Vertices in the edge
FvRS:=Orbit(Subgroup(h,[P0,P1]),vRS,OnPoints);#Vertices in the face
CvRS:=Orbit(Subgroup(h,[P0,P1,P2]),vRS,OnPoints);#Vertices in the cell
PvRS:=Orbit(h,vRS,OnPoints);#Vertices in the polytope
eRS:=[vRS,OnRight(vRS,P0)];#Basic edge
EfRS:=Orbit(Subgroup(h,[P0,P1]),SortedList(eRS),OnSets);#Edges in the face
EcRS:=Orbit(Subgroup(h,[P0,P1,P2]),SortedList(eRS),OnSets);#Edges in the cell
EpRS:=Orbit(h,SortedList(eRS),OnSets);#Edges in the polytope
FcRS:=Orbit(Subgroup(h,[P0,P1,P2]),SortedList(EfRS),OnSetsSets);#Faces in the cell
FpRS:=Orbit(h,SortedList(EfRS),OnSetsSets);#Faces in the polytope
CpRS:=Orbit(h,SortedList(FcRS),OnSetsSetsSets);#Cells in the polytope

Print("Starry {5/2,3,5}","\n","\n");
Print("Vertices in the edge: ",Size(EvRS),"\n");
Print("Vertices in the face: ",Size(FvRS),"\n");
Print("Vertices in the cell: ",Size(CvRS),"\n");
Print("Vertices in the polytope: ",Size(PvRS),"\n");
Print("Edges in the face: ",Size(EfRS),"\n");
Print("Edges in the cell: ",Size(EcRS),"\n");
Print("Edges in the polytope: ",Size(EpRS),"\n");
Print("Faces in the cell: ",Size(FcRS),"\n");
Print("Faces in the polytope: ",Size(FpRS),"\n");
Print("Cells in the polytope: ",Size(CpRS),"\n","\n","\n");

#Counting the Chiral

vC:=[rho/2,-(1/2),0,1/2-rho/2]; #Basic vertex (same as the starry)
FvC:=Orbit(Subgroup(q,[S1]),vC,OnPoints);#Vertices in the face
CvC:=Orbit(Subgroup(q,[S1,S2]),vC,OnPoints);#Vertices in the cell
PvC:=Orbit(q,vC,OnPoints);#Vertices in the polytope
eC:=[vC,OnRight(vC,S1^-1)];#Basic edge
EfC:=Orbit(Subgroup(q,[S1]),SortedList(eC),OnSets);#Edges in the face
EcC:=Orbit(Subgroup(q,[S1,S2]),SortedList(eC),OnSets);#Edges in the cell
EpC:=Orbit(q,SortedList(eC),OnSets);#Edges in the polytope
FcC:=Orbit(Subgroup(q,[S1,S2]),SortedList(EfC),OnSetsSets);#Faces in the cell
FpC:=Orbit(q,SortedList(EfC),OnSetsSets);#Faces in the polytope
CpC:=Orbit(q,SortedList(FcC),OnSetsSetsSets);#Cells in the polytope

Print("Chiral","\n","\n");
Print("Vertices in the face: ",Size(FvC),"\n");
Print("Vertices in the cell: ",Size(CvC),"\n");
Print("Vertices in the polytope: ",Size(PvRC),"\n");
Print("Edges in the face: ",Size(EfC),"\n");
Print("Edges in the cell: ",Size(EcC),"\n");
Print("Edges in the polytope: ",Size(EpC),"\n");
Print("Faces in the cell: ",Size(FcC),"\n");
Print("Faces in the polytope: ",Size(FpC),"\n");
Print("Cells in the polytope: ",Size(CpC),"\n");

#Maybe double check that SetsSetsSets is correctly defined

Print(Size(q));
