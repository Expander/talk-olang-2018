Get["models/NUHMSSMNoFV/NUHMSSMNoFV_librarylink.m"];
Get["models/NUHMSSMNoFVHimalaya/NUHMSSMNoFVHimalaya_librarylink.m"];

invalid;
Mtpole = 173.34;

MZpole = 91.1876;
MWpole = 80.384;
AI = 1/127.944;
Mtaupole = 1.777;
mbmbInput = 4.18;
AS = 0.1184;
GFinput = 1.1663787 10^-5;

LinearRange[start_, stop_, steps_] :=
    Table[start + i/steps (stop - start), {i, 0, steps}];

LogRange[start_, stop_, steps_] :=
    Module[{i, result = {}},
           For[i = 0, i <= steps, i++,
               result = AppendTo[result, Exp[Log[start] + (Log[stop] - Log[start]) i / steps]];
              ];
           result
          ];

CreateStrictThresholds[MhLoops_?NumericQ] :=
    Switch[MhLoops,
           0, 000111021,
           1, 000111021,
           2, 123111121,
           3, 123111121,
           _, Print["Error: unknown loop order MhLoops = ", MhLoops];
          ];

RunNUHMSSMNoFV[MS_?NumericQ, TB_?NumericQ, Xt_?NumericQ, MhLoops_?NumericQ,
               Qpole_?NumericQ] :=
    Module[{handle, spectrum},
           handle = FSNUHMSSMNoFVOpenHandle[
               fsSettings -> {
                   precisionGoal -> 1.*^-5,           (* FlexibleSUSY[0] *)
                   maxIterations -> 1000,             (* FlexibleSUSY[1] *)
                   calculateStandardModelMasses -> 0, (* FlexibleSUSY[3] *)
                   poleMassLoopOrder -> MhLoops,      (* FlexibleSUSY[4] *)
                   ewsbLoopOrder -> MhLoops,          (* FlexibleSUSY[5] *)
                   betaFunctionLoopOrder -> 3,        (* FlexibleSUSY[6] *)
                   thresholdCorrectionsLoopOrder -> 2,(* FlexibleSUSY[7] *)
                   higgs2loopCorrectionAtAs -> 1,     (* FlexibleSUSY[8] *)
                   higgs2loopCorrectionAbAs -> 1,     (* FlexibleSUSY[9] *)
                   higgs2loopCorrectionAtAt -> 1,     (* FlexibleSUSY[10] *)
                   higgs2loopCorrectionAtauAtau -> 1, (* FlexibleSUSY[11] *)
                   forceOutput -> 0,                  (* FlexibleSUSY[12] *)
                   topPoleQCDCorrections -> 1,        (* FlexibleSUSY[13] *)
                   betaZeroThreshold -> 1.*^-11,      (* FlexibleSUSY[14] *)
                   forcePositiveMasses -> 0,          (* FlexibleSUSY[16] *)
                   poleMassScale -> Qpole,            (* FlexibleSUSY[17] *)
                   eftPoleMassScale -> 0,             (* FlexibleSUSY[18] *)
                   eftMatchingScale -> 0,             (* FlexibleSUSY[19] *)
                   eftMatchingLoopOrderUp -> 2,       (* FlexibleSUSY[20] *)
                   eftMatchingLoopOrderDown -> 1,     (* FlexibleSUSY[21] *)
                   eftHiggsIndex -> 0,                (* FlexibleSUSY[22] *)
                   calculateBSMMasses -> 1,           (* FlexibleSUSY[23] *)
                   thresholdCorrections -> CreateStrictThresholds[MhLoops], (* FlexibleSUSY[24] *)
                   higgs3loopCorrectionRenScheme -> 0,(* FlexibleSUSY[25] *)
                   higgs3loopCorrectionAtAsAs -> 1,   (* FlexibleSUSY[26] *)
                   higgs3loopCorrectionAbAsAs -> 1,   (* FlexibleSUSY[27] *)
                   parameterOutputScale -> 0          (* MODSEL[12] *)
               },
               fsSMParameters -> {
                   alphaEmMZ -> AI,        (* SMINPUTS[1] *)
                   GF -> GFinput,          (* SMINPUTS[2] *)
                   alphaSMZ -> AS,         (* SMINPUTS[3] *)
                   MZ -> MZpole,           (* SMINPUTS[4] *)
                   mbmb -> mbmbInput,      (* SMINPUTS[5] *)
                   Mt -> Mtpole,           (* SMINPUTS[6] *)
                   Mtau -> Mtaupole,       (* SMINPUTS[7] *)
                   Mv3 -> 0,               (* SMINPUTS[8] *)
                   MW -> MWpole,           (* SMINPUTS[9] *)
                   Me -> 0.000510998902,   (* SMINPUTS[11] *)
                   Mv1 -> 0,               (* SMINPUTS[12] *)
                   Mm -> 0.1056583715,     (* SMINPUTS[13] *)
                   Mv2 -> 0,               (* SMINPUTS[14] *)
                   md2GeV -> 0.00475,      (* SMINPUTS[21] *)
                   mu2GeV -> 0.0024,       (* SMINPUTS[22] *)
                   ms2GeV -> 0.104,        (* SMINPUTS[23] *)
                   mcmc -> 1.27,           (* SMINPUTS[24] *)
                   CKMTheta12 -> 0,
                   CKMTheta13 -> 0,
                   CKMTheta23 -> 0,
                   CKMDelta -> 0,
                   PMNSTheta12 -> 0,
                   PMNSTheta13 -> 0,
                   PMNSTheta23 -> 0,
                   PMNSDelta -> 0,
                   PMNSAlpha1 -> 0,
                   PMNSAlpha2 -> 0,
                   alphaEm0 -> 1/137.035999074,
                   Mh -> 125.09
               },
               fsModelParameters -> {
                   TanBeta -> TB,
                   Qin -> MS,
                   M1 -> MS,
                   M2 -> MS,
                   M3 -> MS,
                   AtIN -> MS/TB + Xt MS,
                   AbIN -> 0,
                   AtauIN -> 0,
                   AcIN -> 0,
                   AsIN -> 0,
                   AmuonIN -> 0,
                   AuIN -> 0,
                   AdIN -> 0,
                   AeIN -> 0,
                   MuIN -> MS,
                   mA2IN -> MS^2,
                   ml11IN -> MS,
                   ml22IN -> MS,
                   ml33IN -> MS,
                   me11IN -> MS,
                   me22IN -> MS,
                   me33IN -> MS,
                   mq11IN -> MS,
                   mq22IN -> MS,
                   mq33IN -> MS,
                   mu11IN -> MS,
                   mu22IN -> MS,
                   mu33IN -> MS,
                   md11IN -> MS,
                   md22IN -> MS,
                   md33IN -> MS,
                   Mlow -> 0
               }
           ];
           spectrum = FSNUHMSSMNoFVCalculateSpectrum[handle];
           FSNUHMSSMNoFVCloseHandle[handle];
           spectrum
          ];

RunNUHMSSMNoFVHimalaya[MS_?NumericQ, TB_?NumericQ, Xt_?NumericQ, MhLoops_?NumericQ,
                       Qpole_?NumericQ] :=
    Module[{handle, spectrum},
           handle = FSNUHMSSMNoFVHimalayaOpenHandle[
               fsSettings -> {
                   precisionGoal -> 1.*^-5,           (* FlexibleSUSY[0] *)
                   maxIterations -> 1000,             (* FlexibleSUSY[1] *)
                   calculateStandardModelMasses -> 0, (* FlexibleSUSY[3] *)
                   poleMassLoopOrder -> MhLoops,      (* FlexibleSUSY[4] *)
                   ewsbLoopOrder -> MhLoops,          (* FlexibleSUSY[5] *)
                   betaFunctionLoopOrder -> 3,        (* FlexibleSUSY[6] *)
                   thresholdCorrectionsLoopOrder -> 2,(* FlexibleSUSY[7] *)
                   higgs2loopCorrectionAtAs -> 1,     (* FlexibleSUSY[8] *)
                   higgs2loopCorrectionAbAs -> 1,     (* FlexibleSUSY[9] *)
                   higgs2loopCorrectionAtAt -> 1,     (* FlexibleSUSY[10] *)
                   higgs2loopCorrectionAtauAtau -> 1, (* FlexibleSUSY[11] *)
                   forceOutput -> 0,                  (* FlexibleSUSY[12] *)
                   topPoleQCDCorrections -> 1,        (* FlexibleSUSY[13] *)
                   betaZeroThreshold -> 1.*^-11,      (* FlexibleSUSY[14] *)
                   forcePositiveMasses -> 0,          (* FlexibleSUSY[16] *)
                   poleMassScale -> Qpole,            (* FlexibleSUSY[17] *)
                   eftPoleMassScale -> 0,             (* FlexibleSUSY[18] *)
                   eftMatchingScale -> 0,             (* FlexibleSUSY[19] *)
                   eftMatchingLoopOrderUp -> 2,       (* FlexibleSUSY[20] *)
                   eftMatchingLoopOrderDown -> 1,     (* FlexibleSUSY[21] *)
                   eftHiggsIndex -> 0,                (* FlexibleSUSY[22] *)
                   calculateBSMMasses -> 1,           (* FlexibleSUSY[23] *)
                   thresholdCorrections -> CreateStrictThresholds[MhLoops], (* FlexibleSUSY[24] *)
                   higgs3loopCorrectionRenScheme -> 0,(* FlexibleSUSY[25] *)
                   higgs3loopCorrectionAtAsAs -> 1,   (* FlexibleSUSY[26] *)
                   higgs3loopCorrectionAbAsAs -> 1,   (* FlexibleSUSY[27] *)
                   parameterOutputScale -> 0          (* MODSEL[12] *)
               },
               fsSMParameters -> {
                   alphaEmMZ -> AI,        (* SMINPUTS[1] *)
                   GF -> GFinput,          (* SMINPUTS[2] *)
                   alphaSMZ -> AS,         (* SMINPUTS[3] *)
                   MZ -> MZpole,           (* SMINPUTS[4] *)
                   mbmb -> mbmbInput,      (* SMINPUTS[5] *)
                   Mt -> Mtpole,           (* SMINPUTS[6] *)
                   Mtau -> Mtaupole,       (* SMINPUTS[7] *)
                   Mv3 -> 0,               (* SMINPUTS[8] *)
                   MW -> MWpole,           (* SMINPUTS[9] *)
                   Me -> 0.000510998902,   (* SMINPUTS[11] *)
                   Mv1 -> 0,               (* SMINPUTS[12] *)
                   Mm -> 0.1056583715,     (* SMINPUTS[13] *)
                   Mv2 -> 0,               (* SMINPUTS[14] *)
                   md2GeV -> 0.00475,      (* SMINPUTS[21] *)
                   mu2GeV -> 0.0024,       (* SMINPUTS[22] *)
                   ms2GeV -> 0.104,        (* SMINPUTS[23] *)
                   mcmc -> 1.27,           (* SMINPUTS[24] *)
                   CKMTheta12 -> 0,
                   CKMTheta13 -> 0,
                   CKMTheta23 -> 0,
                   CKMDelta -> 0,
                   PMNSTheta12 -> 0,
                   PMNSTheta13 -> 0,
                   PMNSTheta23 -> 0,
                   PMNSDelta -> 0,
                   PMNSAlpha1 -> 0,
                   PMNSAlpha2 -> 0,
                   alphaEm0 -> 1/137.035999074,
                   Mh -> 125.09
               },
               fsModelParameters -> {
                   TanBeta -> TB,
                   Qin -> MS,
                   M1 -> MS,
                   M2 -> MS,
                   M3 -> MS,
                   AtIN -> MS/TB + Xt MS,
                   AbIN -> 0,
                   AtauIN -> 0,
                   AcIN -> 0,
                   AsIN -> 0,
                   AmuonIN -> 0,
                   AuIN -> 0,
                   AdIN -> 0,
                   AeIN -> 0,
                   MuIN -> MS,
                   mA2IN -> MS^2,
                   ml11IN -> MS,
                   ml22IN -> MS,
                   ml33IN -> MS,
                   me11IN -> MS,
                   me22IN -> MS,
                   me33IN -> MS,
                   mq11IN -> MS,
                   mq22IN -> MS,
                   mq33IN -> MS,
                   mu11IN -> MS,
                   mu22IN -> MS,
                   mu33IN -> MS,
                   md11IN -> MS,
                   md22IN -> MS,
                   md33IN -> MS,
                   Mlow -> 0
               }
           ];
           spectrum = FSNUHMSSMNoFVHimalayaCalculateSpectrum[handle];
           FSNUHMSSMNoFVHimalayaCloseHandle[handle];
           spectrum
          ];

GetPar[spec_, par__] :=
    GetPar[spec, #]& /@ {par};

GetPar[spec_, par_] :=
    If[spec =!= $Failed, (par /. spec), invalid];

GetPar[spec_, par_[n__?IntegerQ]] :=
    If[spec =!= $Failed, (par /. spec)[[n]], invalid];

RunNUHMSSMNoFVMhQ[args__] :=
    Module[{spec = RunNUHMSSMNoFV[args]},
           If[spec === $Failed,
              { invalid, invalid },
              {
                  GetPar[NUHMSSMNoFV /. spec, Pole[M[hh]][1]],
                  GetPar[NUHMSSMNoFV /. spec, SCALE]
              }
             ]
          ];

RunNUHMSSMNoFVHimalayaMhQ[args__] :=
    Module[{spec = RunNUHMSSMNoFVHimalaya[args]},
           If[spec === $Failed,
              { invalid, invalid },
              {
                  GetPar[NUHMSSMNoFVHimalaya /. spec, Pole[M[hh]][1]],
                  GetPar[NUHMSSMNoFVHimalaya /. spec, SCALE]
              }
             ]
          ];

VaryScale[Qmean_, factor_] := LogRange[Qmean/factor, Qmean factor, 10];

CheckInvalid[l_List] := Cases[l, Except[invalid | Infinity]];

RunPoint[SG_, pars__] :=
    Module[{MhMean, SUSYscale, poleScales},
           { MhMean, SUSYscale } = SG[pars, 0];
           If[MhMean === invalid, Return[Array[invalid&, 3]]];
           poleScales = CheckInvalid[First /@ (SG[pars, #]& /@ VaryScale[SUSYscale, 2])];
           If[poleScales === invalid, Return[Array[invalid&, 3]]];
           {
               MhMean,
               Min[poleScales], Max[poleScales]
           }
          ];

Xtt = -Sqrt[6];
TBX = 20;
range = LogRange[500, 10^4, 100];
filename = "Mh_MS_TB-20_Xt--sqrt6";

data = ParallelMap[
    {N[#], Sequence @@ RunPoint[RunNUHMSSMNoFVMhQ, #, TBX, Xtt, 2]}&,
    range
];
Export["scan_NUHMSSMNoFV_2L_" <> filename <> ".dat", data];

data = ParallelMap[
    {N[#], Sequence @@ RunPoint[RunNUHMSSMNoFVHimalayaMhQ, #, TBX, Xtt, 3]}&,
    range
];
Export["scan_NUHMSSMNoFV_3L_" <> filename <> ".dat", data];
