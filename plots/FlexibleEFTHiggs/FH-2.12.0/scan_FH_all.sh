./scan_FH.sh --parameter=MS --start=91.1876 --stop=100000 --Xt=0          | tee FH-2.12.2_MS_TB-5_Xt-0.dat
./scan_FH.sh --parameter=MS --start=91.1876 --stop=100000 --Xt=-2         | tee FH-2.12.2_MS_TB-5_Xt--2.dat
./scan_FH.sh --parameter=Xt --start=-3.5    --stop=3.5 --step-size=linear | tee FH-2.12.2_Xt_TB-5_MS-2000.dat
