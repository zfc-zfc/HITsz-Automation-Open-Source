(* ::Package:: *)

BeginPackage["Search1D`"];

(*
 * Function usage
 *
 * Document all of the functions which are defined in this file.
 * This is the same line that appears in the printed documentation.
 *)

Fib1D::usage=
  "Fib1D[f, left, right, \[Epsilon], (prt), (maxIt)] yields the minimum point in interval [left, right] of function f with an error no more than \[Epsilon], using Fibonacci method. ";

GldnRt1D::usage=
  "GldnRt1D[f, left, right, \[Epsilon], (prt), (maxIt)] yields the minimum point in interval [left, right] of function f with an error no more than \[Epsilon], using 0.618 method. ";

Newton::usage=
	"Newton[f, {var1,...,varN}, X0, \[Epsilon], (prt), (maxIt)] yields the minimum point of function f with an error no more than \[Epsilon], given an initial point X0, using Newton method.";

PRP::usage=
	"PRP[f, {var1,...,varN}, X0, \[Epsilon], (prt), (maxIt)] yields the minimum point of function f with an error no more than \[Epsilon], given an initial point X0, using PRP-based conjugate gradient method.";
	
DFP::usage=
	"DFP[f, {var1,...,varN}, X0, \[Epsilon], (prt), (maxIt)] yields the minimum point of function f with an error no more than \[Epsilon], given an initial point X0, using DFP-based Newton-like method.";
	
SUMTExt::usage=
	"SUMTExt[f, {var1,...,varN}, {g1,...,gm}, {h1,...,hp}, X0, \[Epsilon], C, (prt), (maxIt)] yields the minimum point of function f with an error no more than \[Epsilon],\
	 given an initial EXTERIOR point X0, inequality constraints {g}, and equality constraints {h}, using Sequential Unconstrained Minimization Technique, \
	 with C as the exponential increasing rate of the punishment term(s)."

SUMTInt::usage=
	"SUMTInt[f, {var1,...,varN}, {g1,...,gm}, X0, \[Epsilon], C, (prt), (maxIt)] yields the minimum point of function f with an error no more than \[Epsilon],\
	 given an initial INTERIOR point X0, and inequality constraints {g}, using Sequential Unconstrained Minimization Technique, \
	 with C as the exponential decreasing rate of the punishment term(s)." 
	 
Hestenes::usage=
	"Hestenes[f, {var1,...,varN}, {h1,...,hm}, X0, {\[Mu]10,...,\[Mu]m0}, \[Epsilon], C, r, (prt), (maxIt)] yields the minimum point of function f with an error no more than \[Epsilon],\
	 given an initial point X0 and an initial multiplier vector {\[Mu]0}, and equality constraints {h}, using Hestenes' Multiplier Method, \
	 with C as the exponential increasing rate of the punishment term(s), and r as the expected convergence rate." 


(* Begin private section of the package *)
Begin["`Private`"];

(* Wheels...  *)
(* Gradient (vector) function *)
Grd[f_, X_][x_]:=Grad[f @@ X, X]/.Thread[X->x];
(* Hessian (matrix) function *)
Hesse[f_, X_][x_]:=Grad[Grad[f @@ X, X], X]/.Thread[X->x];


(* Fibonacci Method *)
Fib1D[f_, left_, right_, \[Epsilon]_, prt_:1, maxIter_:100]:= 
Module[
{l=left,r=right, k=1, m2, m1, fm1, fm2,F, maxIt=maxIter},
	F=f;
(* Find a searching interval *)

	If[maxIt < 1 || maxIt == Null,
		maxIt = N[2^31-1];
	];
	While[Fibonacci[k+1]*\[Epsilon]< (r-l),
		k = k+1; 
	];
	If[prt==1,
		Print["N=", k+1, ",  F(N)=", Fibonacci[k+1]];
	];
	m2 = l+Fibonacci[k]/Fibonacci[k+1]*(r-l);
	fm2 = F[m2];
	m1 = l+r-m2;
	fm1 = F[m1];
	k=0;
	If[prt==1,
		Print["Initial interval: "];
		Print["[", l, " , ", r, "]"];
	];
	While[r-l>\[Epsilon] && k < maxIt,
		If[prt==1,
			Print["Iteration ", k+1, ": "];
			Print["\[Lambda]=", m1,",  ", "f(\[Lambda])=", fm1];
			Print["\[Mu]=", m2,",  ", "f(\[Mu])=", fm2];
		];
		If[fm2>fm1,
		r = m2;
		m2 = m1;
		m1 = l+r-m2;
		fm2 = fm1;
		fm1 = F[m1];
		,
		l = m1;
		m1 = m2;
		m2 = l+r-m1;
		fm1 = fm2;
		fm2 = F[m2];
		];
		k=k+1;
		If[prt==1,
			Print["[", l, " , ", r, "]"];
			Print[""];
		];
	];
	(m2+m1)/2
];


(* Golden Ratio Method (0.618 Method) *)
GldnRt1D[f_, left_, right_, \[Epsilon]_, prt_:1, maxIter_:100]:= 
Module[
{l=left,r=right, k, m2, m1, fm1, fm2,F, maxIt=maxIter},
	F=f;
(* Find a searching interval *)

	If[maxIt < 1 || maxIt == Null,
		maxIt = N[2^31-1];
	];
	m2 = l+0.618*(r-l);
	fm2 = F[m2];
	m1 = l+r-m2;
	fm1 = F[m1];
	k=1;
	If[prt==1,
		Print["Initial interval: "];
		Print["[", l, " , ", r, "]"];
	];
	While[r-l>\[Epsilon] && k <= maxIt,
		If[prt==1,
			Print["Iteration ", k, ": "]; 
			Print["\[Lambda]=", m1,",  ", "f(\[Lambda])=", fm1];
			Print["\[Mu]=", m2,",  ", "f(\[Mu])=", fm2];
		];
		If[fm2>fm1,
		r = m2;
		m2 = m1;
		m1 = l+r-m2;
		fm2 = fm1;
		fm1 = F[m1];
		,
		l = m1;
		m1 = m2;
		m2 = l+r-m1;
		fm1 = fm2;
		fm2 = F[m2];
		];
		k=k+1;
		If[prt==1,
			Print["[", l, " , ", r, "]"];
			Print[""];
		];
	];
		(*Print["TEST"];*)
	(m2+m1)/2
];


(* Newton Method *) 
Newton[f_, vars_, X0_, \[Epsilon]_,  prt_:1, maxIt_:100]:= 
Module[
{   k = 0,
	X = X0, 
	dF, ddF, 
	g, h
},
	dF = Grd[f, vars];
	ddF = Hesse[f, vars];
	g = dF[X];
	If[prt==1,
		Print["\[Del]f=", MatrixForm[dF[vars]]];
		Print["\[Del]^2 f= ", MatrixForm[ddF[vars]]];
	];
	While[Norm[g] > \[Epsilon] && k<maxIt,
		h = ddF[X];
		X = X - Inverse[h].g;
		g = dF[X];
		k = k+1;
		If[prt==1,
			Print["X",k,"= ", MatrixForm[X]];
			Print["h",k,"= ", MatrixForm[h]];
		];
	];
	X
];


(* PRP-based Conjuate Gradient Method *)
PRP[f_, vars_, X0_, \[Epsilon]_, prt_:1, maxIt_:100, n_:3]:= 
Module[
	{   k=1, m=1, \[Lambda], u, \[Beta],
		X = X0,
		g, p, g1, 
		dF, F
	},
	dF = Grd[f, vars];
	If[prt==1,
		Print["\[Del]f=", MatrixForm[dF[vars]]];
	];
	g = dF[X];
	While[ Norm[g]>\[Epsilon] && m<=maxIt,
		p = -g;
		If[prt == 1,
			Print["Iteration ", m];
			Print["X(", m,")=", MatrixForm[X]];
			Print["g(",m,")=", MatrixForm[g]];
		];
		F[u_]:=f@@(X+u*p);
		(*\[Lambda] = GldnRt1D[F, 0, 1, 0.01, 0];*)
		\[Lambda] = FindArgMin[{F[u], u>=0}, {u, 0}][[1]];
		X = X + \[Lambda]*p;
		g1 = dF[X];
		If[prt==1,
			Print["\[Lambda]",m,"=", \[Lambda]];
			Print["f(\[Lambda])=", F[\[Lambda]]];
			Print["g(",m+1,")=", MatrixForm[g1]];
		];
		If[Norm[g1]<= \[Epsilon],
			Break[];
		];
		(* n-step Restart *)
		If[k==n,
			g = g1;
			k = 1;
			m = m+1;
			If[prt==1,
				Print[];
			];
			Continue[];
		];
		\[Beta] = g1.(g1-g)/Norm[g]^2;
		p = -g1 + \[Beta]*p;
		If[prt==1,
			Print["\[Beta]",m,"=", \[Beta]];
			Print["P(",m+1,")=", MatrixForm[p]];
			Print[];
		];
		g = g1;
		k = k + 1;
		m = m + 1;
	];
	X
];


(* DFP Method *) 
DFP[f_, vars_, X0_, \[Epsilon]_, prt_:1, maxIt_:100, n_:3]:= 
Module[
	{   k=1, m=0, \[Lambda],    (* Scalars *)
		X = X0, g, p, g1, X1, Y, S,   (* Vectors *)
		H=IdentityMatrix[Length[vars]],    (* Matrices *)
		dF, F  (* Functions *)
	},
	dF = Grd[f, vars];
	If[prt==1,
		Print["\[Del]f=", MatrixForm[dF[vars]]];
	];
	g = dF[X];
	H = IdentityMatrix[Length[vars]];
	While[m<maxIt,
		If[Norm[g] <= \[Epsilon],
			Break[];
		];
		p = -H.g;
		If[prt == 1,
			Print[];
			Print["Iteration ", m];
			Print["X=", MatrixForm[X]];
			Print["g(k)=", MatrixForm[g]];
		];
		F[u_]:=f@@(X+u*p);
		(*\[Lambda] = GldnRt1D[F, 0, 1, 0.01, 0];*)
		\[Lambda] = FindArgMin[{F[u], u>=0}, {u, 0}][[1]];
		X1 = X + \[Lambda]*p;
		g1 = dF[X1];
		If[prt==1,
			Print["g(k+1)= ", MatrixForm[g1]];
			Print["H= ", MatrixForm[H]];
			Print["\[Lambda]= ", \[Lambda]];
			Print["f(\[Lambda])=", F[\[Lambda]]];
			Print["p=", MatrixForm[p]];
			(*Print["|g(k+1)|= ", Norm[g1], "    \[Epsilon]=", \[Epsilon]];*)
		];
		If[Norm[g1]<= \[Epsilon],
			X = X1;
			Break[];
		];
		(* n-step Restart *)
		If[k==n,
			g = g1;
			k = 1;
			H = IdentityMatrix[Length[vars]];
			Continue[];
		];
		Y = g1-g;
		S = X1-X;
		If[prt==1,
			Print["Y= ", MatrixForm[Y]];
			Print["S=", MatrixForm[S]];
			(*Print["HYYH=", MatrixForm[KroneckerProduct[H.Y,Y].H]];
			Print["SS=", MatrixForm[KroneckerProduct[S,S]]];*)
		];
		H = H - KroneckerProduct[H.Y,Y].H/(Y.H.Y) + KroneckerProduct[S,S]/(S.Y);
		X = X1;
		g = g1;
		k = k + 1;
		m = m + 1;
	];
	X
];


(* SUMT Exterior *)
SUMTExt[f_, vars_, g_, h_, X0_, \[Epsilon]_, C_:10, prt_:1, maxIt_:100]:= 
Module[
	{   k = 1, i, j, M = 1,
		m = Length[g],p = Length[h],
		maxErr, gg,
		X = X0,
		\[Phi]
	},
	If[C<1,
		C = 10;
	];
	maxErr = 0;
	gg = Table[0, m];
	For[i=1, i<=m && maxErr<\[Epsilon], i++,
		gg[[i]] = -g[[i]]@@X;
		(*Print["gg[",i,"]=", gg[[i]]];*)
		If[gg[[i]]>maxErr,
			maxErr = gg[[i]];
		];
	];
	For[i=1, i<=p && maxErr<\[Epsilon], i++,
		(*Print["|h[", i, "]|=", Abs[h[[i]]@@X]];*)
		If[Abs[h[[i]]@@X]>maxErr,
			maxErr = Abs[h[[i]]@@X];
		];
	];
	M = 1/C;
	If[prt==1,
			Print["X(", k-1, ")= ", X];
			Print["|g|i(",k-1,")= ", maxErr];
			Print[];
	];
	While[maxErr>=\[Epsilon] && k<=maxIt,
		M = M*C;
		\[Phi][x_]:=f@@x + M*\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(m\)]\(\((Min[0, \ g[\([i]\)] @@ x])\)^2\)\) + M*\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(j = 1\), \(p\)]\(\((h[\([j]\)] @@ x)\)^2\)\);
		If[prt==1,
			Print["\[Phi]",k-1,"[",X,"]= ", \[Phi][X]];
		];
		X = FindArgMin[f@@vars + M*\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(m\)]\(\((Min[0, \ g[\([i]\)] @@ vars])\)^2\)\) + M*\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(j = 1\), \(p\)]\(\((h[\([j]\)] @@ vars)\)^2\)\), vars, Method->"ConjugateGradient"];
		maxErr = 0;
		For[i=1, i<=m && maxErr<\[Epsilon], i++,
			gg[[i]] = -g[[i]]@@X;
			(*Print["gg[",i,"]=", gg[[i]]];*)
			If[gg[[i]]>maxErr,
				maxErr = gg[[i]];
			];
		];
		For[i=1, i<=p && maxErr<\[Epsilon], i++,
			(*Print["|h[", i, "]|=", Abs[h[[i]]@@X]];*)
			If[Abs[h[[i]]@@X]>maxErr,
				maxErr = Abs[h[[i]]@@X];
			];
		];
		If[prt==1,
			Print["X(", k, ")= ", X];
			Print["|g|i(",k,")= ", maxErr];
			Print[];
		];
		k++;
	];
	If[prt==1,
		Print["\[Phi]",k-1,"[",X,"]= ", \[Phi][X]];
	];
	X
];


(* SUMT Interior *)
SUMTInt[f_, vars_, g_, X0_, \[Epsilon]_, C_:10, prt_:1, maxIt_:100]:= 
Module[
	{   k = 1, i, M = 1,
		m = Length[g],
		maxErr, 
		X = X0, 
		\[Phi]
	},
	If[C<1,
		C = 10;
	];
	maxErr = Abs[M*\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(m\)]\(Log[\((g[\([i]\)] @@ X)\) + 10^\((\(-8\))\)]\)\)];
	M = 1;
	If[prt==1,
			Print["X(", k-1, ")= ", X];
			Print["|M*\!\(\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(m\)]\)ln(\!\(\*SubscriptBox[\(g\), \(i\)]\)(X",k-1,"))|= ", N[maxErr]];
			Print[];
	];
	While[maxErr>=\[Epsilon] && k<=maxIt,
		If[prt==1,
			Print["M",k,"=", M];
			(*\[Phi][x_]:=f@@x + M*\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(m\)]\(1/\((g[\([i]\)] @@ x)\)\)\);*)
			\[Phi][x_]:=f@@x- M*\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(m\)]\(Log[\((g[\([i]\)] @@ x)\) + 10^\((\(-8\))\)]\)\);
			Print["\[Phi]",k-1,"[",X,"]=", N[\[Phi][X]]];
		];
		X = FindArgMin[f@@vars - M*\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(m\)]\(Log[\((g[\([i]\)] @@ vars)\) + 10^\((\(-8\))\)]\)\), vars, Method->"Newton"];
		maxErr = Abs[M*\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(m\)]\(Log[\((g[\([i]\)] @@ X)\) + 10^\((\(-8\))\)]\)\)];
		If[prt==1,
			Print["X(", k, ")= ", X];
			Print["|M*\!\(\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(m\)]\)ln(\!\(\*SubscriptBox[\(g\), \(i\)]\)(X",k,"))|= ", N[maxErr]];
			Print[];
		];
		M = M/C;
		k++;
	];
	If[prt==1,
		Print["min f = ", N[f@@X]];
	];
	X
];


(* Multiplier Method *)
Hestenes[f_, vars_, h_, X0_, \[Mu]0_, \[Epsilon]_, C_:10, r_:0.5, prt_:1, maxIt_:100]:= 
Module[
	{   k = 1, i, M = C, \[Mu] = \[Mu]0,
		p = Length[h],
		err, errLast=0, \[Beta],
		X = X0,
		\[Phi]
	},
	If[C<=1,
		C = 10;
	];
	If[r<=0 || r>=1,
		r = 0.5;
	];
	err = Sqrt[\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(p\)]\(\((h[\([i]\)] @@ X)\)^2\)\)];
	If[prt==1,
		Print["|h|(0)=", err];
		Print["X0=",X];
	];
	While[err>=\[Epsilon] && k<=maxIt,
		If[prt==1,
			Print["M",k,"=", M];
			\[Phi][x_]:=f@@x +\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(p\)]\(\[Mu][\([i]\)]*\((h[\([i]\)] @@ x)\)\)\)+ M/2*\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(p\)]\(\((h[\([i]\)] @@ x)\)^2\)\);
			Print["\[Phi]",k-1,"[",X,"]=", \[Phi][X]];
		];
		XLast = X;
		X = FindArgMin[f@@vars + \!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(p\)]\(\[Mu][\([i]\)]*\((h[\([i]\)] @@ vars)\)\)\)+M/2*\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(p\)]\(\((h[\([i]\)] @@ vars)\)^2\)\), vars, Method->"Newton"];
		errLast = err;
		err = Sqrt[\!\(
\*SubsuperscriptBox[\(\[Sum]\), \(i = 1\), \(p\)]\(\((h[\([i]\)] @@ X)\)^2\)\)];
		\[Beta] = err/errLast;
		If[prt==1,
			Print["\[Mu](",k,")=", \[Mu]];
			Print["|h|(",k,")=", err];
			Print["\[Beta](",k,")=", \[Beta]];
			Print["X(", k, ")= ", X];
			Print[];
		];
		If[\[Beta]>r,
			M = C*M;
		];
		For[i=1, i<=p, i++,
			\[Mu][[i]] = \[Mu][[i]] + C*(h[[i]]@@X);
		];
		k++;
	];
	Print["min f(X)=", f@@X];
	X
];



(* Close up the open environments *)
End[];
EndPackage[];

(* End Search1D.wl *)
