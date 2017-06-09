Get["models/HSSUSY/HSSUSY_librarylink.m"];
Get["models/MSSMEFTHiggs/MSSMEFTHiggs_librarylink.m"];
Get["models/MSSMMuBMu/MSSMMuBMu_librarylink.m"];
Needs["SUSYHD`"];

invalid;
Mtpole = 173.34;
MZpole = 91.1876;
MWpole = 80.384;
alphaEmAtMZ = 1/127.944;
Mtaupole = 1.777;
mbmbInput = 4.18;
alphaSAtMZ = 0.1184;
GFInput = 1.1663787 10^-5;

SMParameters = {
    alphaEmMZ -> alphaEmAtMZ, (* SMINPUTS[1] *)
    GF -> GFInput,            (* SMINPUTS[2] *)
    alphaSMZ -> alphaSAtMZ,   (* SMINPUTS[3] *)
    MZ -> MZpole,             (* SMINPUTS[4] *)
    mbmb -> mbmbInput,        (* SMINPUTS[5] *)
    Mt -> Mtpole,             (* SMINPUTS[6] *)
    Mtau -> 1.777,            (* SMINPUTS[7] *)
    Mv3 -> 0,                 (* SMINPUTS[8] *)
    MW -> MWpole,             (* SMINPUTS[9] *)
    Me -> 0.000510998902,     (* SMINPUTS[11] *)
    Mv1 -> 0,                 (* SMINPUTS[12] *)
    Mm -> 0.1056583715,       (* SMINPUTS[13] *)
    Mv2 -> 0,                 (* SMINPUTS[14] *)
    md2GeV -> 0.00475,        (* SMINPUTS[21] *)
    mu2GeV -> 0.0024,         (* SMINPUTS[22] *)
    ms2GeV -> 0.104,          (* SMINPUTS[23] *)
    mcmc -> 1.27,             (* SMINPUTS[24] *)
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
};

LinearRange[start_, stop_, steps_] :=
    Table[start + i/steps (stop - start), {i, 0, steps}];

LogRange[start_, stop_, steps_] :=
    Module[{i, result = {}},
           For[i = 0, i <= steps, i++,
               result = AppendTo[result, Exp[Log[start] + (Log[stop] - Log[start]) i / steps]];
              ];
           result
          ];

RunMSSMEFTHiggs[MS_?NumericQ, TB_?NumericQ, Xt_?NumericQ,
                ytLoops_:2, Qpole_:0, Qmatch_:0] :=
    Module[{handle, spectrum, uncerts = {}},
           handle = FSMSSMEFTHiggsOpenHandle[
               fsSettings -> {
                   precisionGoal -> 1.*^-5,           (* FlexibleSUSY[0] *)
                   maxIterations -> 1000,             (* FlexibleSUSY[1] *)
                   calculateStandardModelMasses -> 0, (* FlexibleSUSY[3] *)
                   poleMassLoopOrder -> 1,            (* FlexibleSUSY[4] *)
                   ewsbLoopOrder -> 1,                (* FlexibleSUSY[5] *)
                   betaFunctionLoopOrder -> 3,        (* FlexibleSUSY[6] *)
                   thresholdCorrectionsLoopOrder -> 3,(* FlexibleSUSY[7] *)
                   higgs2loopCorrectionAtAs -> 1,     (* FlexibleSUSY[8] *)
                   higgs2loopCorrectionAbAs -> 1,     (* FlexibleSUSY[9] *)
                   higgs2loopCorrectionAtAt -> 1,     (* FlexibleSUSY[10] *)
                   higgs2loopCorrectionAtauAtau -> 1, (* FlexibleSUSY[11] *)
                   forceOutput -> 0,                  (* FlexibleSUSY[12] *)
                   topPoleQCDCorrections -> 1,        (* FlexibleSUSY[13] *)
                   betaZeroThreshold -> 1.*^-11,      (* FlexibleSUSY[14] *)
                   forcePositiveMasses -> 0,          (* FlexibleSUSY[16] *)
                   poleMassScale -> 0,                (* FlexibleSUSY[17] *)
                   eftPoleMassScale -> Qpole,         (* FlexibleSUSY[18] *)
                   eftMatchingScale -> Qmatch,        (* FlexibleSUSY[19] *)
                   eftMatchingLoopOrderUp -> 1,       (* FlexibleSUSY[20] *)
                   eftMatchingLoopOrderDown -> 1,     (* FlexibleSUSY[21] *)
                   eftHiggsIndex -> 0,                (* FlexibleSUSY[22] *)
                   calculateBSMMasses -> 0,           (* FlexibleSUSY[23] *)
                   thresholdCorrections -> 120111121 + ytLoops 10^6, (* FlexibleSUSY[24] *)
                   parameterOutputScale -> 0          (* MODSEL[12] *)
               },
               fsSMParameters -> SMParameters,
               fsModelParameters -> {
                   MSUSY -> MS,
                   M1Input -> MS,
                   M2Input -> MS,
                   M3Input -> MS,
                   MuInput -> MS,
                   mAInput -> MS,
                   TanBeta -> TB,
                   AeInput -> MS TB IdentityMatrix[3],
                   AdInput -> MS TB IdentityMatrix[3],
                   AuInput -> {
                       {MS/TB, 0    , 0            },
                       {0    , MS/TB, 0            },
                       {0    , 0    , MS/TB + Xt MS}
                   },
                   mq2Input -> MS^2 IdentityMatrix[3],
                   mu2Input -> MS^2 IdentityMatrix[3],
                   md2Input -> MS^2 IdentityMatrix[3],
                   ml2Input -> MS^2 IdentityMatrix[3],
                   me2Input -> MS^2 IdentityMatrix[3]
               }
           ];
           spectrum = FSMSSMEFTHiggsCalculateSpectrum[handle];
           FSMSSMEFTHiggsCloseHandle[handle];
           spectrum
          ];

RunMSSMMuBMu[MS_?NumericQ, TB_?NumericQ, Xt_?NumericQ,
             ytLoops_:2, Qpole_:0] :=
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
                   poleMassScale -> Qpole,            (* FlexibleSUSY[17] *)
                   eftPoleMassScale -> 0,             (* FlexibleSUSY[18] *)
                   eftMatchingScale -> 0,             (* FlexibleSUSY[19] *)
                   eftMatchingLoopOrderUp -> 2,       (* FlexibleSUSY[20] *)
                   eftMatchingLoopOrderDown -> 1,     (* FlexibleSUSY[21] *)
                   eftHiggsIndex -> 0,                (* FlexibleSUSY[22] *)
                   calculateBSMMasses -> 1,           (* FlexibleSUSY[23] *)
                   thresholdCorrections -> 120111121 + ytLoops 10^6, (* FlexibleSUSY[24] *)
                   parameterOutputScale -> 0          (* MODSEL[12] *)
               },
               fsSMParameters -> SMParameters,
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
               fsSMParameters -> SMParameters,
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

RunMSSMEFTHiggsMh[args__] :=
    Module[{spec = RunMSSMEFTHiggs[args]},
           If[spec === $Failed,
              invalid,
              GetPar[MSSMEFTHiggs /. spec, Pole[M[hh]][1]]
             ]
          ];

RunMSSMMuBMuMh[args__] :=
    Module[{spec = RunMSSMMuBMu[args]},
           If[spec === $Failed,
              invalid,
              GetPar[MSSMMuBMu /. spec, Pole[M[hh]][1]]
             ]
          ];

RunHSSUSYMh[args__] :=
    Module[{spec = RunHSSUSY[args]},
           If[spec === $Failed,
              invalid,
              GetPar[HSSUSY /. spec, Pole[M[hh]]]
             ]
          ];

VaryScale[Qmean_, factor_] := LogRange[Qmean/factor, Qmean factor, 10];

CheckInvalid[l_List] := If[FreeQ[l,invalid], l, invalid];

RunPoint[SG_, pars__, scale_] :=
    Module[{MhMean, scales},
           MhMean = SG[pars, scale];
           If[MhMean === invalid, Return[Array[invalid&, 2]]];
           scales = CheckInvalid[SG[pars, #]& /@ VaryScale[scale, 2]];
           If[scales === invalid, Return[Array[invalid&, 2]]];
           { Min[scales], Max[scales] }
          ];

RunEFTHiggs[MS_?NumericQ, TB_?NumericQ, Xt_?NumericQ] :=
    Module[{MhYt2, MhYt3, Qpole = 0, Qmatch = 0, MhQpole, MhQmatch, DMh},
           MhYt2 = RunMSSMEFTHiggsMh[MS, TB, Xt, 2, Qpole, Qmatch];
           MhYt3 = RunMSSMEFTHiggsMh[MS, TB, Xt, 3, Qpole, Qmatch];
           MhQpole = RunPoint[RunMSSMEFTHiggsMh, MS, TB, Xt, 2, Mtpole];
           MhQmatch = RunPoint[RunMSSMEFTHiggsMh, MS, TB, Xt, 2, 0, MS];
           DMh = Abs[MhYt2 - MhYt3] + Abs[Min[MhQpole] - Max[MhQpole]] + Abs[Min[MhQmatch] - Max[MhQmatch]];
           If[MhYt2 === $Failed,
              { invalid, invalid },
              { MhYt2, DMh }
             ]
          ];

RunMSSM[MS_?NumericQ, TB_?NumericQ, Xt_?NumericQ] :=
    Module[{MhYt1, MhYt2, Qpole = 0, MhQpole, DMh},
           MhYt1 = RunMSSMMuBMuMh[MS, TB, Xt, 1, Qpole];
           If[MhYt1 === invalid, Return[{ invalid, invalid }]];
           MhYt2 = RunMSSMMuBMuMh[MS, TB, Xt, 2, Qpole];
           If[MhYt2 === invalid, Return[{ invalid, invalid }]];
           MhQpole = RunPoint[RunMSSMMuBMuMh, MS, TB, Xt, 2, MS];
           DMh = Abs[MhYt1 - MhYt2] + Abs[Min[MhQpole] - Max[MhQpole]];
           If[MhYt2 === $Failed,
              { invalid, invalid },
              { MhYt2, DMh }
             ]
          ];

RunSUSYHD[MS_, TB_, Xt_] :=
    Module[{gauginoM1 = MS, gauginoM2 = MS, gauginoM3 = MS, higgsMu = MS, higgsAt, mq3=MS,
            mu3=MS, md3=MS, mq2=MS, mu2=MS, md2=MS, mq1=MS, mu1=MS, md1=MS,
            ml3=MS, me3=MS, ml2=MS, me2=MS, ml1=MS, me1=MS, mA=MS,
            mass, dmass },

           SetSMparameters[Mtpole, alphaSAtMZ];
           higgsAt=(higgsMu/TB + Xt MS);

           mass = MHiggs[{TB, gauginoM1, gauginoM2, gauginoM3,
                          higgsMu, higgsAt, mq3, mu3, md3, mq2, mu2,
                          md2, mq1, mu1, md1, ml3, me3, ml2, me2, ml1,
                          me1, mA}, Rscale->MS, scheme->"DRbar",
                          hiOrd->{1,1,1,0}, numerical->True,
                          split->False];

           dmass= \[CapitalDelta]MHiggs[{TB, gauginoM1, gauginoM2,
                                         gauginoM3, higgsMu, higgsAt,
                                         mq3, mu3, md3, mq2, mu2, md2,
                                         mq1, mu1, md1, ml3, me3, ml2,
                                         me2, ml1, me1, mA},
                                         Rscale->MS, scheme->"DRbar",
                                         sources->{1,1,1},
                                         numerical->False];

           {mass, dmass}
    ];

IsValid[ex_]          := FreeQ[ex, invalid];
RemoveInvalid[l_List] := Select[l, IsValid];
MaxDiff[l_List]       := Max[Abs[RemoveInvalid[l]]] - Min[Abs[RemoveInvalid[l]]];
MaxDiff[{}]           := 0;
MinMax[l_List]        := { Min[Abs[RemoveInvalid[l]]], Max[Abs[RemoveInvalid[l]]] };
MinMax[{}]            := { invalid, invalid };

steps = 60;

MSstart = Mtpole;
MSstop  = 1.0 10^5;
Xtstart = -3.5;
Xtstop  = 3.5;
TBX = 5;
XtX = 0;

(********** SUSYHD **********)

res = {N[#], Sequence @@ RunSUSYHD[#, TBX, XtX]}& /@ LogRange[MSstart, MSstop, steps];
Export["SUSYHD_MS_TB-" <> ToString[TBX] <> "_Xt-" <> ToString[N[XtX]] <> ".dat", res, "Table"];

(********** HSSUSY **********)

res = {N[#], RunHSSUSYMh[#, TBX, XtX]}& /@ LogRange[MSstart, MSstop, steps];
Export["HSSUSY_MS_TB-" <> ToString[TBX] <> "_Xt-" <> ToString[N[XtX]] <> ".dat", res, "Table"];

(********** FlexibleEFTHiggs **********)

res = {N[#], Sequence @@ RunEFTHiggs[#, TBX, XtX]}& /@ LogRange[MSstart, MSstop, steps];
Export["MSSMEFTHiggs_MS_TB-" <> ToString[TBX] <> "_Xt-" <> ToString[N[XtX]] <> ".dat", res, "Table"];

(********** MSSM **********)

res = {N[#], Sequence @@ RunMSSM[#, TBX, XtX]}& /@ LogRange[MSstart, MSstop, steps];
Export["MSSMMuBMu_MS_TB-" <> ToString[TBX] <> "_Xt-" <> ToString[N[XtX]] <> ".dat", res, "Table"];
