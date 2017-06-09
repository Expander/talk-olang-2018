Get["models/MSSMMuBMu/MSSMMuBMu_librarylink.m"];
Get["models/MSSMtower/MSSMtower_librarylink.m"];
Get["models/HSSUSY/HSSUSY_librarylink.m"];

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

RunMSSMMuBMu[MS_?NumericQ, TB_?NumericQ, Xt_?NumericQ] :=
    Module[{handle, spectrum},
           handle = FSMSSMMuBMuOpenHandle[
               fsSettings -> {
                   precisionGoal -> 1.*^-5,           (* FlexibleSUSY[0] *)
                   maxIterations -> 10000,            (* FlexibleSUSY[1] *)
                   calculateStandardModelMasses -> 0, (* FlexibleSUSY[3] *)
                   poleMassLoopOrder -> 2,            (* FlexibleSUSY[4] *)
                   ewsbLoopOrder -> 2,                (* FlexibleSUSY[5] *)
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
                   poleMassScale -> 0,                (* FlexibleSUSY[17] *)
                   eftPoleMassScale -> 0,             (* FlexibleSUSY[18] *)
                   eftMatchingScale -> 0,             (* FlexibleSUSY[19] *)
                   eftMatchingLoopOrderUp -> 2,       (* FlexibleSUSY[20] *)
                   eftMatchingLoopOrderDown -> 1,     (* FlexibleSUSY[21] *)
                   eftHiggsIndex -> 0,                (* FlexibleSUSY[22] *)
                   calculateBSMMasses -> 1,           (* FlexibleSUSY[23] *)
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
                   MSUSY   -> MS,
                   M1Input -> MS,
                   M2Input -> MS,
                   M3Input -> MS,
                   MuInput -> MS,
                   mAInput -> MS,
                   TanBeta -> TB,
                   mq2Input -> MS^2 IdentityMatrix[3],
                   mu2Input -> MS^2 IdentityMatrix[3],
                   md2Input -> MS^2 IdentityMatrix[3],
                   ml2Input -> MS^2 IdentityMatrix[3],
                   me2Input -> MS^2 IdentityMatrix[3],
                   AuInput -> {{MS/TB, 0    , 0},
                               {0    , MS/TB, 0},
                               {0    , 0    , MS/TB + Xt MS}},
                   AdInput -> MS TB IdentityMatrix[3],
                   AeInput -> MS TB IdentityMatrix[3]
               }
           ];
           spectrum = FSMSSMMuBMuCalculateSpectrum[handle];
           FSMSSMMuBMuCloseHandle[handle];
           spectrum
          ];

RunMSSMtower[MS_?NumericQ, TB_?NumericQ, Xt_?NumericQ,
             mhLoops_:1, ytLoops_:2] :=
    Module[{handle, spectrum},
           handle = FSMSSMtowerOpenHandle[
               fsSettings -> {
                   precisionGoal -> 1.*^-5,           (* FlexibleSUSY[0] *)
                   maxIterations -> 10000,            (* FlexibleSUSY[1] *)
                   calculateStandardModelMasses -> 0, (* FlexibleSUSY[3] *)
                   poleMassLoopOrder -> mhLoops,      (* FlexibleSUSY[4] *)
                   ewsbLoopOrder -> mhLoops,          (* FlexibleSUSY[5] *)
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
                   poleMassScale -> 0,                (* FlexibleSUSY[17] *)
                   eftPoleMassScale -> 0,             (* FlexibleSUSY[18] *)
                   eftMatchingScale -> 0,             (* FlexibleSUSY[19] *)
                   eftMatchingLoopOrderUp -> ytLoops, (* FlexibleSUSY[20] *)
                   eftMatchingLoopOrderDown -> mhLoops,(* FlexibleSUSY[21] *)
                   eftHiggsIndex -> 0,                (* FlexibleSUSY[22] *)
                   calculateBSMMasses -> 0,           (* FlexibleSUSY[23] *)
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
                   MSUSY   -> MS,
                   M1Input -> MS,
                   M2Input -> MS,
                   M3Input -> MS,
                   MuInput -> MS,
                   mAInput -> MS,
                   TanBeta -> TB,
                   mq2Input -> MS^2 IdentityMatrix[3],
                   mu2Input -> MS^2 IdentityMatrix[3],
                   md2Input -> MS^2 IdentityMatrix[3],
                   ml2Input -> MS^2 IdentityMatrix[3],
                   me2Input -> MS^2 IdentityMatrix[3],
                   AuInput -> {{MS/TB, 0    , 0},
                               {0    , MS/TB, 0},
                               {0    , 0    , MS/TB + Xt MS}},
                   AdInput -> MS TB IdentityMatrix[3],
                   AeInput -> MS TB IdentityMatrix[3]
               }
           ];
           spectrum = FSMSSMtowerCalculateSpectrum[handle];
           FSMSSMtowerCloseHandle[handle];
           spectrum
          ];

RunHSSUSY[MS_?NumericQ, TB_?NumericQ, Xt_?NumericQ,
          mhLoops_:2, ytLoops_:2] :=
    Module[{handle, spectrum},
           handle = FSHSSUSYOpenHandle[
               fsSettings -> {
                   precisionGoal -> 1.*^-5,           (* FlexibleSUSY[0] *)
                   maxIterations -> 100,              (* FlexibleSUSY[1] *)
                   calculateStandardModelMasses -> 1, (* FlexibleSUSY[3] *)
                   poleMassLoopOrder -> mhLoops,      (* FlexibleSUSY[4] *)
                   ewsbLoopOrder -> mhLoops,          (* FlexibleSUSY[5] *)
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
                   poleMassScale -> 0,                (* FlexibleSUSY[17] *)
                   eftPoleMassScale -> 0,             (* FlexibleSUSY[18] *)
                   eftMatchingScale -> 0,             (* FlexibleSUSY[19] *)
                   eftMatchingLoopOrderUp -> 0,       (* FlexibleSUSY[20] *)
                   eftMatchingLoopOrderDown -> 0,     (* FlexibleSUSY[21] *)
                   eftHiggsIndex -> 0,                (* FlexibleSUSY[22] *)
                   calculateBSMMasses -> 0,           (* FlexibleSUSY[23] *)
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
                   MSUSY   -> MS,
                   M1Input -> MS,
                   M2Input -> MS,
                   M3Input -> MS,
                   MuInput -> MS,
                   mAInput -> MS,
                   MEWSB   -> Mtpole,
                   AtInput -> MS/TB + Xt MS,
                   TanBeta -> TB,
                   LambdaLoopOrder -> mhLoops,
                   msq2 -> MS^2 IdentityMatrix[3],
                   msu2 -> MS^2 IdentityMatrix[3],
                   msd2 -> MS^2 IdentityMatrix[3],
                   msl2 -> MS^2 IdentityMatrix[3],
                   mse2 -> MS^2 IdentityMatrix[3]
               }
           ];
           spectrum = FSHSSUSYCalculateSpectrum[handle];
           FSHSSUSYCloseHandle[handle];
           spectrum
          ];

GetPar[spec_, par__] :=
    GetPar[spec, #]& /@ {par};

GetPar[spec_, par_] :=
    If[spec =!= $Failed, (par /. spec), invalid];

GetPar[spec_, par_[n__?IntegerQ]] :=
    If[spec =!= $Failed, (par /. spec)[[n]], invalid];

RunMSSMMuBMuMh[args__] :=
    Module[{spec = RunMSSMMuBMu[args]},
           If[spec === $Failed,
              invalid,
              GetPar[MSSMMuBMu /. spec, Pole[M[hh]][1]]
             ]
          ];

RunMSSMtowerMh[args__] :=
    Module[{spec = RunMSSMtower[args]},
           If[spec === $Failed,
              invalid,
              GetPar[MSSMtower /. spec, Pole[M[hh]][1]]
             ]
          ];

RunHSSUSYMh[args__] :=
    Module[{spec = RunHSSUSY[args]},
           If[spec === $Failed,
              invalid,
              GetPar[HSSUSY /. spec, Pole[M[hh]]]
             ]
          ];

Xtt = 0;
TBX = 5;

(* MS *)

range = LogRange[Mtpole, 10^5, 60];

data = {N[#], RunMSSMtowerMh[#, TBX, Xtt]}& /@ range;
Export["scan_MSSMtower-2.0_Mh_MS_TB-5_Xt-0.dat", data];

data = {N[#], RunMSSMMuBMuMh[#, TBX, Xtt]}& /@ range;
Export["scan_MSSMMuBMu_Mh_MS_TB-5_Xt-0.dat", data];

data = {N[#], RunHSSUSYMh[#, TBX, Xtt]}& /@ range;
Export["scan_HSSUSY_Mh_MS_TB-5_Xt-0.dat", data];

data = {N[#], RunHSSUSYMh[#, TBX, Xtt, 1]}& /@ range;
Export["scan_HSSUSY-1L_Mh_MS_TB-5_Xt-0.dat", data];

(* Xt *)

range = LinearRange[-3, 3, 60];

data = {N[#], RunMSSMtowerMh[2000, TBX, #]}& /@ range;
Export["scan_MSSMtower-2.0_Mh_Xt_TB-5_MS-2000.dat", data];

data = {N[#], RunMSSMMuBMuMh[2000, TBX, #]}& /@ range;
Export["scan_MSSMMuBMu_Mh_Xt_TB-5_MS-2000.dat", data];

data = {N[#], RunHSSUSYMh[2000, TBX, #]}& /@ range;
Export["scan_HSSUSY_Mh_Xt_TB-5_MS-2000.dat", data];

data = {N[#], RunHSSUSYMh[2000, TBX, #, 1]}& /@ range;
Export["scan_HSSUSY-1L_Mh_Xt_TB-5_MS-2000.dat", data];
