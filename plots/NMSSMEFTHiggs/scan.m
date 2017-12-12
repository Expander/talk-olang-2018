Get["models/NMSSMEFTHiggs/NMSSMEFTHiggs_librarylink.m"];
Get["model_files/NMSSMEFTHiggs/NMSSMEFTHiggs_uncertainty_estimate.m"];

Get["models/NUHNMSSM/NUHNMSSM_librarylink.m"];
Get["model_files/NUHNMSSM/NUHNMSSM_uncertainty_estimate.m"];

smpars = {
    alphaEmMZ -> 1/127.916, (* SMINPUTS[1] *)
    GF -> 1.166378700*^-5,  (* SMINPUTS[2] *)
    alphaSMZ -> 0.1184,     (* SMINPUTS[3] *)
    MZ -> 91.1876,          (* SMINPUTS[4] *)
    mbmb -> 4.18,           (* SMINPUTS[5] *)
    Mt -> 173.34,           (* SMINPUTS[6] *)
    Mtau -> 1.77699,        (* SMINPUTS[7] *)
    Mv3 -> 0,               (* SMINPUTS[8] *)
    MW -> 80.385,           (* SMINPUTS[9] *)
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
};

CalcTlambda[mA2_, TB_, lam_, kap_, muEff_] :=
    Module[{vS = muEff Sqrt[2] / lam},
           (mA2 Sqrt[2] TB / (vS (TB^2 + 1)) - muEff kap)
           ];

CalcTkappa[m2_, lam_, muEff_] :=
    Module[{vS = muEff Sqrt[2] / lam},
           - Sqrt[2] m2 / vS
           ];

NMSSMEFTHiggsCalcMh[MS_, TB_, Xtt_, lam_, kap_] :=
    CalcNMSSMEFTHiggsDMh[
        fsSettings -> {
            precisionGoal -> 1.*^-5,
            maxIterations -> 100,
            poleMassLoopOrder -> 3,
            ewsbLoopOrder -> 3,
            thresholdCorrectionsLoopOrder -> 2,
            thresholdCorrections -> 122111221
        },
        fsSMParameters -> smpars,
        fsModelParameters -> {
            MSUSY   -> MS,
            M1Input -> MS,
            M2Input -> MS,
            M3Input -> MS,
            MuInput -> MS,
            TanBeta -> TB,
            LambdaInput -> lam,
            KappaInput -> kap,
            ALambdaInput -> CalcTlambda[MS^2, TB, lam, kap, MS] / lam,
            AKappaInput -> CalcTkappa[MS^2, lam, MS] / kap,
            mq2Input -> MS^2 IdentityMatrix[3],
            mu2Input -> MS^2 IdentityMatrix[3],
            md2Input -> MS^2 IdentityMatrix[3],
            ml2Input -> MS^2 IdentityMatrix[3],
            me2Input -> MS^2 IdentityMatrix[3],
            AuInput -> {{MS/TB, 0    , 0},
                        {0    , MS/TB, 0},
                        {0    , 0    , MS/TB + Xtt MS}},
            AdInput -> MS TB IdentityMatrix[3],
            AeInput -> MS TB IdentityMatrix[3]
        }
   ];

NUHNMSSMCalcMh[MS_, TB_, Xtt_, lam_, kap_] :=
    CalcNUHNMSSMDMh[
        fsSettings -> {
            precisionGoal -> 1.*^-5,
            maxIterations -> 1000,
            poleMassLoopOrder -> 2,
            ewsbLoopOrder -> 2,
            thresholdCorrectionsLoopOrder -> 2,
            thresholdCorrections -> 121111121
        },
        fsSMParameters -> smpars,
        fsModelParameters -> {
            MSUSY   -> MS,
            M1Input -> MS,
            M2Input -> MS,
            M3Input -> MS,
            MuInput -> MS,
            TanBeta -> TB,
            LambdaInput -> lam,
            KappaInput -> kap,
            ALambdaInput -> CalcTlambda[MS^2, TB, lam, kap, MS] / lam,
            AKappaInput -> CalcTkappa[MS^2, lam, MS] / kap,
            mq2Input -> MS^2 IdentityMatrix[3],
            mu2Input -> MS^2 IdentityMatrix[3],
            md2Input -> MS^2 IdentityMatrix[3],
            ml2Input -> MS^2 IdentityMatrix[3],
            me2Input -> MS^2 IdentityMatrix[3],
            AuInput -> {{MS/TB, 0    , 0},
                        {0    , MS/TB, 0},
                        {0    , 0    , MS/TB + Xtt MS}},
            AdInput -> MS TB IdentityMatrix[3],
            AeInput -> MS TB IdentityMatrix[3]
        }
   ];

steps = 60;

(*** Xt = 0 ***)

TB  = 5;
Xtt = 0;
lam = kap = 0.1;

data = ParallelMap[
    { N[#],
      Sequence @@ N @ NUHNMSSMCalcMh[#, TB, Xtt, lam, kap],
      Sequence @@ N @ NMSSMEFTHiggsCalcMh[#, TB, Xtt, lam, kap]
    }&,
    LogRange[173.34, 10^5, steps]
];

Export["scan_NMSSM_TB-5_Xt-0_lam-0.1_kap-0.1.dat", data];

lam = kap = 0.3;

data = ParallelMap[
    { N[#],
      Sequence @@ N @ NUHNMSSMCalcMh[#, TB, Xtt, lam, kap],
      Sequence @@ N @ NMSSMEFTHiggsCalcMh[#, TB, Xtt, lam, kap]
    }&,
    LogRange[300, 10^5, steps]
];

Export["scan_NMSSM_TB-5_Xt-0_lam-0.3_kap-0.3.dat", data];

(*** Xt = -2 ***)

TB  = 5;
Xtt = -2;
lam = kap = 0.1;

data = ParallelMap[
    { N[#],
      Sequence @@ N @ NUHNMSSMCalcMh[#, TB, Xtt, lam, kap],
      Sequence @@ N @ NMSSMEFTHiggsCalcMh[#, TB, Xtt, lam, kap]
    }&,
    LogRange[173.34, 10^5, steps]
];

Export["scan_NMSSM_TB-5_Xt--2_lam-0.1_kap-0.1.dat", data];

lam = kap = 0.3;

data = ParallelMap[
    { N[#],
      Sequence @@ N @ NUHNMSSMCalcMh[#, TB, Xtt, lam, kap],
      Sequence @@ N @ NMSSMEFTHiggsCalcMh[#, TB, Xtt, lam, kap]
    }&,
    LogRange[300, 10^5, steps]
];

Export["scan_NMSSM_TB-5_Xt--2_lam-0.3_kap-0.3.dat", data];
