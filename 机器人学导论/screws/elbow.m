(*
 * elbow.m - Kinematics for 6R elbow manipulator
 *
 * Richard M. Murray
 * 22 January 1992
 *
 *)

(* twist axes for SCARA robot, reference frame at base *)
xi1 = ScrewToTwist[0, {0,0,l0}, {0,0,1}];	(* base *)
xi2 = ScrewToTwist[0, {0,0,l0}, {-1,0,0}];
xi3 = ScrewToTwist[0, {0,l1,l0}, {-1,0,0}];	(* elbow *)
xi4 = ScrewToTwist[0, {0,l1+l2,l0}, {0,0,1}];	(* wrist *)
xi5 = ScrewToTwist[0, {0,l1+l2,l0}, {-1,0,0}];
xi6 = ScrewToTwist[0, {0,l1+l2,l0}, {0,1,0}];

g0 = RPToHomogeneous[IdentityMatrix[3], {0,l1+l2,l0}];

(* Forward Kinematics *)
g = Simplify[
  TwistExp[xi1,th1] . TwistExp[xi2,th2] .
  TwistExp[xi3,th3] . TwistExp[xi4,th4] .
  TwistExp[xi5,th5] . TwistExp[xi6,th6] . g0
];

(* Draw a picture of a elbow manipulator *)
parms = {l0->5, l1->5, l2->5}
elbowGraphics = {
  DrawFrame[{0,0,0}, IdentityMatrix[3]],
  DrawScrew[{0,0,l0} /. parms, {0,0,1}],
  DrawScrew[{0,0,l0} /. parms, {-1,0,0}],
  DrawScrew[{0,l1,l0} /. parms, {-1,0,0}],
  DrawScrew[{0,l1+l2,l0} /. parms, {0,0,1}],
  DrawScrew[{0,l1+l2,l0} /. parms, {-1,0,0}],
  DrawScrew[{0,l1+l2,l0} /. parms, {0,1,0}]
}
Show[elbowGraphics, PlotRange->All]
