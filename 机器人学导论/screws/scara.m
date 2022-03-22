(*
 * scara.m - Kinematics for SCARA robot
 *
 * Richard M. Murray
 * 22 January 1992
 *
 *)

<<Screws.m

(* twist axes for SCARA robot, reference frame at base *)
xi1 = {0,0,0, 0,0,1};		(* base *)
xi2 = {l1,0,0, 0,0,1};		(* elbow *)
xi3 = {l1+l2,0,0, 0,0,1};	(* wrist revolute *)
xi4 = {0,0,1, 0,0,0};		(* wrist prismatic *)

g0 = RPToHomogeneous[IdentityMatrix[3], {0,l1+l2,0}];

(* Forward Kinematics *)
g = Simplify[
  TwistExp[xi1,th1] . TwistExp[xi2,th2] .
  TwistExp[xi3,th3] . TwistExp[xi4,th4] . g0
];

(* Spatial Jacobian *)
Js = Simplify[StackCols[
  xi1,
  RigidAdjoint[TwistExp[xi1, th1]] . xi2,
  RigidAdjoint[TwistExp[xi1, th1] . TwistExp[xi2, th2]] . xi3,
  RigidAdjoint[
    TwistExp[xi1, th1] . TwistExp[xi2, th2] . TwistExp[xi3, th3]
  ] . xi4
]];

