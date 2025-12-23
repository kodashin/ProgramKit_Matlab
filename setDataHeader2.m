function header = setDataHeader2()

header = ["Trial No.";
    "Subject";
    "Action";
    "Shoes";
    "InpoputE[J]"
    "AER[J]"
    "RER[%]"
    "MaxDisplacement[mm]"


    "H[m]"
    "H2[m]"

    "H energy[m]"
    "H2 energy[m]"

    "H cg[m]"
    "H2 cg[m]"

    "H cal[m]"
    "H2 cal[m]"

    "H standerdised[m]"
    "H2 standerdised[m]"

    "H2 impulse[m]"


    "H0H1[m]"
    "H0[m]"
    "H1[m]"

     "H ratio"
    "H2 ratio"
    "H0H1 ratio"
    "H0 ratio"
        
    
    "1st step contact time[s]"
    "2nd step contact time[s]"
    "1-Leg time[s]"

    

    "Pel center entry X[m]";
    "Pel center entry Y[m]";
    "Pel center entry Z[m]";
    "Pel center bottom X[m]";
    "Pel center bottom Y[m]";
    "Pel center bottom Z[m]";
    "Pel center exit X[m]";
    "Pel center exit Y[m]";
    "Pel center exit Z[m]";
    "Pel center entry-bottom X[m]";
    "Pel center entry-bottom Y[m]";
    "Pel center entry-bottom Z[m]";
    "Pel center bottom-exit X[m]";
    "Pel center bottom-exit Y[m]";
    "Pel center bottom-exit Z[m]";
    "Pel center entry-exit X[m]";
    "Pel center entry-exit Y[m]";
    "Pel center entry-exit Z[m]";

    "Pel vel entry X[m/s]";
    "Pel vel entry Y[m/s]";
    "Pel vel entry Z[m/s]";
    "Pel vel bottom X[m/s]";
    "Pel vel bottom Y[m/s]";
    "Pel vel bottom Z[m/s]";
    "Pel vel exit X[m/s]";
    "Pel vel exit Y[m/s]";
    "Pel vel exit Z[m/s]";
    "Pel vel entry-bottom X[m/s]";
    "Pel vel entry-bottom Y[m/s]";
    "Pel vel entry-bottom Z[m/s]";
    "Pel vel bottom-exit X[m/s]";
    "Pel vel bottom-exit Y[m/s]";
    "Pel vel bottom-exit Z[m/s]";
    "Pel vel bottom-max X[m/s]";
    "Pel vel bottom-max Y[m/s]";
    "Pel vel bottom-max Z[m/s]";
    "Pel vel entry-exit X[m/s]";
    "Pel vel entry-exit Y[m/s]";
    "Pel vel entry-exit Z[m/s]";

    "Pel vel angle entry X[deg]";
    "Pel vel angle entry Y[deg]";
    "Pel vel angle entry Z[deg]";
    "Pel vel angle bottom X[degs]";
    "Pel vel angle bottom Y[deg]";
    "Pel vel angle bottom Z[deg]";
    "Pel vel angle exit X[deg]";
    "Pel vel angle exit Y[deg]";
    "Pel vel angle exit Z[deg]";


    % %Impulse-all
    "Impulse X WG ALL[Ns/kg]"
    "Impulse Y WG ALL[Ns/kg]"
    "Impulse Z WG ALL[Ns/kg]"
    "Impulse X WG entry-bottom ALL[Ns/kg]"
    "Impulse Y WG entry-bottom ALL[Ns/kg]"
    "Impulse Z WG entry-bottom ALL[Ns/kg]"
    "Impulse X WG bottom-exit ALL[Ns/kg]"
    "Impulse Y WG bottom-exit ALL[Ns/kg]"
    "Impulse Z WG bottom-exit ALL[Ns/kg]"
    "Impulse X WG bottom-max ALL[Ns/kg]"
    "Impulse Y WG bottom-max ALL[Ns/kg]"
    "Impulse Z WG bottom-max ALL[Ns/kg]"
    "Impulse X W entry-bottom ALL[Ns/kg]"
    "Impulse Y W entry-bottom ALL[Ns/kg]"
    "Impulse Z W entry-bottom ALL[Ns/kg]"
    "Impulse X W bottom-exit ALL[Ns/kg]"
    "Impulse Y W bottom-exit ALL[Ns/kg]"
    "Impulse Z W bottom-exit ALL[Ns/kg]"
    "Impulse X W bottom-max ALL[Ns/kg]"
    "Impulse Y W bottom-max ALL[Ns/kg]"
    "Impulse Z W bottom-max ALL[Ns/kg]"
    "Impulse X W ALL[Ns/kg]"
    "Impulse Y W ALL[Ns/kg]"
    "Impulse Z W ALL[Ns/kg]"
    "Impulse X G ALL[Ns/kg]"
    "Impulse Y G ALL[Ns/kg]"
    "Impulse Z G ALL[Ns/kg]"
    "Impulse X ALL[Ns]"
    "Impulse Y ALL[Ns]"
    "Impulse Z ALL[Ns]"

    "Impulse X WG ALL singleL[Ns/kg]"
    "Impulse Y WG ALL singleL[Ns/kg]"
    "Impulse Z WG ALL singleL[Ns/kg]"
    "Impulse X W ALL singleL[Ns/kg]"
    "Impulse Y W ALL singleL[Ns/kg]"
    "Impulse Z W ALL singleL[Ns/kg]"
    "Impulse X G ALL singleL[Ns/kg]"
    "Impulse Y G ALL singleL[Ns/kg]"
    "Impulse Z G ALL singleL[Ns/kg]"
    "Impulse X ALL singleL[Ns]"
    "Impulse Y ALL singleL[Ns]"
    "Impulse Z ALL singleL[Ns]"

    "Impulse X WG ALL doubleL[Ns/kg]"
    "Impulse Y WG ALL doubleL[Ns/kg]"
    "Impulse Z WG ALL doubleL[Ns/kg]"
    "Impulse X W ALL doubleL[Ns/kg]"
    "Impulse Y W ALL doubleL[Ns/kg]"
    "Impulse Z W ALL doubleL[Ns/kg]"
    "Impulse X G ALL doubleL[Ns/kg]"
    "Impulse Y G ALL doubleL[Ns/kg]"
    "Impulse Z G ALL doubleL[Ns/kg]"
    "Impulse X ALL doubleL[Ns]"
    "Impulse Y ALL doubleL[Ns]"
    "Impulse Z ALL doubleL[Ns]"
    "Impulse-R X ALL doubleL[Ns]"
    "Impulse-R Y ALL doubleL[Ns]"
    "Impulse-R Z ALL doubleL[Ns]"
    "Impulse-L X ALL doubleL[Ns]"
    "Impulse-L Y ALL doubleL[Ns]"
    "Impulse-L Z ALL doubleL[Ns]"

    "Pelvis velocity X singleL[m/s]"
    "Pelvis velocity Y singleL[m/s]"
    "Pelvis velocity Z singleL[m/s]"
    "Pelvis velocity X  doubleL[m/s]"
    "Pelvis velocity Y  doubleL[m/s]"
    "Pelvis velocity Z  doubleL[m/s]"


    "Mean force X WG ALL[N/kg]"
    "Mean force Y WG ALL[N/kg]"
    "Mean force Z WG ALL[N/kg]"
    "Mean force X WG entry-bottom ALL[N/kg]"
    "Mean force Y WG entry-bottom ALL[N/kg]"
    "Mean force Z WG entry-bottom ALL[N/kg]"
    "Mean force X WG bottom-exit ALL[N/kg]"
    "Mean force Y WG bottom-exit ALL[N/kg]"
    "Mean force Z WG bottom-exit ALL[N/kg]"
    "Max force X W ALL[N/kg]"
    "Max force Y W ALL[N/kg]"
    "Max force Z W ALL[N/kg]"
    "Min force X W ALL[N/kg]"
    "Min force Y W ALL[N/kg]"
    "Min force Z W ALL[N/kg]"
    "PEL vel gap X ALL[m/s]"
    "PEL vel gap Y ALL[m/s]"
    "PEL vel gap Z ALL[m/s]"
    "PEL Center gap X ALL[m/s]"
    "PEL Center gap Y ALL[m/s]"
    "PEL Center gap Z ALL[m/s]"
    "PEL Center start X ALL[m/s]"
    "PEL Center start Y ALL[m/s]"
    "PEL Center start Z ALL[m/s]"
    "PEL Center end X ALL[m/s]"
    "PEL Center end Y ALL[m/s]"
    "PEL Center end Z ALL[m/s]"


    %Impulse-1
    "Contact Time 1st[s]"
    "Impulse X W 1st[Ns/kg]"
    "Impulse Y W 1st[Ns/kg]"
    "Impulse Z W 1st[Ns/kg]"
     "Impulse X W entry-bottom 1st[Ns/kg]"
    "Impulse Y W entry-bottom 1st[Ns/kg]"
    "Impulse Z W entry-bottom 1st[Ns/kg]"
    "Impulse X W bottom-exit 1st[Ns/kg]"
    "Impulse Y W bottom-exit 1st[Ns/kg]"
    "Impulse Z W bottom-exit 1st[Ns/kg]"
    "Impulse X 1st[Ns]"
    "Impulse Y 1st[Ns]"
    "Impulse Z 1st[Ns]"
    "Mean force X W 1st[N/kg]"
    "Mean force Y W 1st[N/kg]"
    "Mean force Z W 1st[N/kg]"
    "Mean force X W entry-bottom 1st[N/kg]"
    "Mean force Y W entry-bottom 1st[N/kg]"
    "Mean force Z W entry-bottom 1st[N/kg]"
    "Mean force X W bottom-exit 1st[N/kg]"
    "Mean force Y W bottom-exit 1st[N/kg]"
    "Mean force Z W bottom-exit 1st[N/kg]"
    "Max force X W 1st[N/kg]"
    "Max force Y W 1st[N/kg]"
    "Max force Z W 1st[N/kg]"
    "Min force X W 1st[N/kg]"
    "Min force Y W 1st[N/kg]"
    "Min force Z W 1st[N/kg]"
    "PEL vel gap X 1st[m/s]"
    "PEL vel gap Y 1st[m/s]"
    "PEL vel gap Z 1st[m/s]"
    "PEL Center gap X 1st[m/s]"
    "PEL Center gap Y 1st[m/s]"
    "PEL Center gap Z 1st[m/s]"
    "PEL Center start X 1st[m/s]"
    "PEL Center start Y 1st[m/s]"
    "PEL Center start Z 1st[m/s]"
    "PEL Center end X 1st[m/s]"
    "PEL Center end Y 1st[m/s]"
    "PEL Center end Z 1st[m/s]"



    %Impulse-2
    "Contact Time 2nd[s]"
    "Impulse X W 2nd[Ns/kg]"
    "Impulse Y W 2nd[Ns/kg]"
    "Impulse Z W 2nd[Ns/kg]"
     "Impulse X W entry-bottom 2nd[Ns/kg]"
    "Impulse Y W entry-bottom 2nd[Ns/kg]"
    "Impulse Z W entry-bottom 2nd[Ns/kg]"
    "Impulse X W bottom-exit 2nd[Ns/kg]"
    "Impulse Y W bottom-exit 2nd[Ns/kg]"
    "Impulse Z W bottom-exit 2nd[Ns/kg]"
    "Impulse X 2nd[Ns]"
    "Impulse Y 2nd[Ns]"
    "Impulse Z 2nd[Ns]"
    "Mean force X W 2nd[N/kg]"
    "Mean force Y W 2nd[N/kg]"
    "Mean force Z W 2nd[N/kg]"
    "Mean force X W entry-bottom 2nd[N/kg]"
    "Mean force Y W entry-bottom 2nd[N/kg]"
    "Mean force Z W entry-bottom 2nd[N/kg]"
    "Mean force X W bottom-exit 2nd[N/kg]"
    "Mean force Y W bottom-exit 2nd[N/kg]"
    "Mean force Z W bottom-exit 2nd[N/kg]"
    "Max force X W 2nd[N/kg]"
    "Max force Y W 2nd[N/kg]"
    "Max force Z W 2nd[N/kg]"
    "Min force X W 2nd[N/kg]"
    "Min force Y W 2nd[N/kg]"
    "Min force Z W 2nd[N/kg]"
    "PEL vel gap X 2nd[m/s]"
    "PEL vel gap Y 2nd[m/s]"
    "PEL vel gap Z 2nd[m/s]"
    "PEL Center gap X 2nd[m/s]"
    "PEL Center gap Y 2nd[m/s]"
    "PEL Center gap Z 2nd[m/s]"
    "PEL Center start X 2nd[m/s]"
    "PEL Center start Y 2nd[m/s]"
    "PEL Center start Z 2nd[m/s]"
    "PEL Center end X 2nd[m/s]"
    "PEL Center end Y 2nd[m/s]"
    "PEL Center end Z 2nd[m/s]"

    %Impulse ratio
    "Impulse ratio X"
    "Impulse ratio Y"
    "Impulse ratio Z"

    "Impulse posi(Y) ratio X"
    "Impulse posi(Y) ratio Y"
    "Impulse posi(Y) ratio Z"

    "Impulse nega(Y) ratio X"
    "Impulse nega(Y) ratio Y"
    "Impulse nega(Y) ratio Z"


%Body Posture
"Time gap between Rtakeoff-Ltakeoff"
"R AnkC - COG distance X at take off[m]"
"R AnkC - COG distance Y at take off[m]"
"R AnkC - COG distance Z at take off[m]"
"L AnkC - COG distance X at take off[m]"
"L AnkC - COG distance Y at take off[m]"
"L AnkC - COG distance Z at take off[m]"

"R AnkC - COG distance X at R take off[m]"
"R AnkC - COG distance Y at R take off[m]"
"R AnkC - COG distance Z at R take off[m]"
"L AnkC - COG distance X at R take off[m]"
"L AnkC - COG distance Y at R ake off[m]"
"L AnkC - COG distance Z at R ake off[m]"

"R - COG - L distance ratio X at take off[m]"
"R - COG - L distance ratio Y at take off[m]"
"R - COG - L distance ratio Z at take off[m]"
"R - COG - L distance ratio X at R take off[m]"
"R - COG - L distance ratio Y at R take off[m]"
"R - COG - L distance ratio Z at R take off[m]"

"R - COG - L distance norm ratio at take off[m]"
"R - COG - L distance norm ratio at R take off[m]"

    


    ]';


end