function header = setDataHeader()

header = ["Trial No.";
    "Subject";
    "Action";
    "Shoes";
    "InpoputE[J]"
    "AER[J]"
    "RER[%]"
    "MaxDisplacement[mm]"

    %接地時間
    "Contact time[s]";%

    %骨盤中心速度
    "Entry velocity X[m/s]";
    "Entry velocity Y[m/s]"
    "Entry velocity Z[m/s]";
    "Exit velocity X[m/s]";
    "Exit velocity Y[m/s]";
    "Exit velocity Z[m/s]";
    "Max velocity X[m/s]";
    "Max velocity Y[m/s]";
    "Max velocity Z[m/s]";
    "Velocity gap X[m/s]";
    "Velocity gap Y[m/s]";
    "Velocity gap Z[m/s]";
    
%力積
    "Impulse X[Ns/kg]";
    "Impulse Y[Ns/kg]";
    "Impulse Z[Ns/kg]";
    "Impulse X nega[Ns/kg]";
    "Impulse Y nega[Ns/kg]";
    "Impulse Z nega[Ns/kg]";
    "Impulse X posi[Ns/kg]";
    "Impulse Y posi[Ns/kg]";
    "Impulse Z posi[Ns/kg]";
    "Impulse X strt-peak[Ns/kg]";
    "Impulse Y strt-peak[Ns/kg]";
    "Impulse Z strt-peak[Ns/kg]";
    "Impulse X peak-end[Ns/kg]";
    "Impulse Y peak-end[Ns/kg]";
    "Impulse Z peak-end[Ns/kg]"; 

    %力積
    "Impulse X[Ns]";
    "Impulse Y[Ns]";
    "Impulse Z[Ns]";
    "Impulse X nega[Ns]";
    "Impulse Y nega[Ns]";
    "Impulse Z nega[Ns]";
    "Impulse X posi[Ns]";
    "Impulse Y posi[Ns]";
    "Impulse Z posi[Ns]";
    "Impulse X strt-peak[Ns]";
    "Impulse Y strt-peak[Ns]";
    "Impulse Z strt-peak[Ns]";
    "Impulse X peak-end[Ns]";
    "Impulse Y peak-end[Ns]";
    "Impulse Z peak-end[Ns]";



%平均力
    "Average force X[N]";
    "Average force Y[N]";
    "Average force Z[N]";
    "Average positive force X[N]";%
    "Average positive force Y[N]";%
    "Average positive force Z[N]";%
    "Average negative force X[N]";%
    "Average negative force Y[N]";%
    "Average negative force Z[N]";%
    "Average force X strt-peak[N]";
    "Average force Y strt-peak[N]";
    "Average force Z strt-peak[N]";
    "Average force X peak-end[N]";
    "Average force Y peak-end[N]";
    "Average force Z peak-end[N]";

    %平均力
    "Average force X[N/kg]";
    "Average force Y[N/kg]";
    "Average force Z[N/kg]";
    "Average positive force X[N/kg]";%
    "Average positive force Y[N/kg]";%
    "Average positive force Z[N/kg]";%
    "Average negative force X[N/kg]";%
    "Average negative force Y[N/kg]";%
    "Average negative force Z[N/kg]";%
     "Average force X strt-peak[N/kg]";
    "Average force Y strt-peak[N/kg]";
    "Average force Z strt-peak[N/kg]";
    "Average force X peak-end[N/kg]";
    "Average force Y peak-end[N/kg]";
    "Average force Z peak-end[N/kg]";

    "Fx max time[s]"
    "Fy max time[s]"
    "Fz max time[s]"
    "Fx min time[s]"
    "Fy min time[s]"
    "Fz min time[s]"

    "Max force X[N]";
    "Max force Y[N]";
    "Max force Z[N]";
    "Min force X[N]";
    "Min force Y[N]";
    "Min force Z[N]";

    "Max force X[N/kg]";
    "Max force Y[N/kg]";
    "Max force Z[N/kg]";
    "Min force X[N/kg]";
    "Min force Y[N/kg]";
    "Min force Z[N/kg]";

    %トルク積
    "Ankle angular impulse X[Nms/kg]"
    "Ankle angular impulse Y[Nms/kg]"
    "Ankle angular impulse Z[Nms/kg]"
    "Knee angular impulse X[Nms/kg]"
    "Knee angular impulse Y[Nms/kg]"
    "Knee angular impulse Z[Nms/kg]"

    %平均トルク
    "Mean ankle torque X[Nms/kg]"
    "Mean ankle torque Y[Nms/kg]"
    "Mean ankle torque Z[Nms/kg]"
    "Mean knee torque X[Nms/kg]"
    "Mean knee torque Y[Nms/kg]"
    "Mean knee torque Z[Nms/kg]"

    %    %フリーモーメント
    %    "Free moment[Nm]"
    %
    %接地時の関節角度
    "Foot ang at entry X[deg.]"
    "Foot ang at entry Y[deg.]"
    "Foot ang at entry Z[deg.]"
    "Shank ang at entry X[deg.]"
    "Shank ang at entry Y[deg.]"
    "Shank ang at entry Z[deg.]"
    "Thigh ang at entry X[deg.]"
    "Thigh ang at entry Y[deg.]"
    "Thigh ang at entry Z[deg.]"

    "Ankle ang at entry X[deg.]"
    "Ankle ang at entry Y[deg.]"
    "Ankle ang at entry Z[deg.]"
    "Knee ang at entry X[deg.]"
    "Knee ang at entry Y[deg.]"
    "Knee ang at entry Z[deg.]"
    "Hip ang at entry X[deg.]"
    "Hip ang at entry Y[deg.]"
    "Hip ang at entry Z[deg.]"

    "Leg length at extit[m]"
    "Leg ang X at entry[deg]"
    "Leg ang Y at entry[deg]"
    "Leg ang Z at entry[deg]"
    "Leg ang omg X at entry[deg/s]"
    "Leg ang omg Y at entry[deg/s]"
    "Leg ang omg Z at entry[deg/s]"

    "Step Length[m]"
    %
    %    "COP X in shoes[m]"
    %    "COP Y in shoes[m]"
    %    "COP Z in shoes[m]"
    %
    %    "Min COP X in shoes[m]"
    %    "Min COP Y in shoes[m]"
    %    "Min COP Z in shoes[m]"
    %    "Max COP X in shoes[m]"
    %    "Max COP Y in shoes[m]"
    %    "Max COP Z in shoes[m]"
    %
    %
    %    "Ankle Center X at entry[m]"
    %    "Ankle Center Y at entry[m]"
    %    "Ankle Center Z at entry[m]"
    %    "Knee Center X at entry[m]"
    %    "Knee Center Y at entry[m]"
    %    "Knee Center Z at entry[m]"
    %    "Hip Center X at entry[m]"
    %    "Hip Center Y at entry[m]"
    %    "Hip Center Z at entry[m]"
    %
    %
    %離地時の関節角度
    "Foot ang at exit X[deg.]"
    "Foot ang at exit Y[deg.]"
    "Foot ang at exit Z[deg.]"
    "Shank ang at exit X[deg.]"
    "Shank ang at exit Y[deg.]"
    "Shank ang at exit Z[deg.]"
    "Thigh ang at exit X[deg.]"
    "Thigh ang at exit Y[deg.]"
    "Thigh ang at exit Z[deg.]"

    "Ankle ang at exit X[deg.]"
    "Ankle ang at exit Y[deg.]"
    "Ankle ang at exit Z[deg.]"
    "Knee ang at exit X[deg.]"
    "Knee ang at exit Y[deg.]"
    "Knee ang at exit Z[deg.]"
    "Hip ang at exit X[deg.]"
    "Hip ang at exit Y[deg.]"
    "Hip ang at exit Z[deg.]"

    "Leg length at extit[m]"
    "Leg ang at exit X[m]"
    "Leg ang at exit Y[m]"
    "Leg ang at exit Z[m]"
    "Leg ang omg X at exit[deg/s]"
    "Leg ang omg Y at exit[deg/s]"
    "Leg ang omg Z at exit[deg/s]"

    "ANKc-COG distance X[m]"
    "ANKc-COG distance Y[m]"
    "ANKc-COG distance Z[m]"


    %鉛直力最大値とその時の変数たち
    "Max Propulsion Force[N/kg]"
    "Max GRF X at max Prop[N/kg]"
    "Max GRF Y at max Prop[N/kg]"
    "Max GRF Z at max prop[N/kg]"
    "Impulse X until max prop[Ns/kg]";
    "Impulse Y until max prop[Ns/kg]";
    "Impulse Z until max prop[Ns/kg]";
    "Impulse X after max prop[Ns/kg]";
    "Impulse Y after max prop[Ns/kg]";
    "Impulse Z after max prop[Ns/kg]";


    "GRF vec ang X at max prop[deg.]"
    "GRF vec ang Y at max prop[deg.]"
    "GRF vec ang Z at max prop[deg.]"
    "Ankle tor X at max prop[Nm/kg]"
    "Ankle tor Y at max prop[Nm/kg]"
    "Ankle tor Z at max prop[Nm/kg]"
    "Knee tor X at max prop[Nm/kg]"
    "Knee tor Y at max prop[Nm/kg]"
    "Knee tor Z at max prop[Nm/kg]"
    "Ankle pow X at max prop[W/kg]"
    "Ankle pow Y at max prop[W/kg]"
    "Ankle pow Z at max prop[W/kg]"
    "Knee pow X at max prop[W/kg]"
    "Knee pow Y at max prop[W/kg]"
    "Knee pow Z at max prop[W/kg]"
    "Ankle tor lever arm  X at max prop[Nm/kg]"
    "Ankle tor lever arm Y at max prop[Nm/kg]"
    "Ankle tor lever arm Z at max prop[Nm/kg]"

    "Ankle angle X at max prop[deg.]"
    "Ankle angle Y at max prop[deg.]"
    "Ankle angle Z at max prop[deg.]"
    "Foot angle X at max prop[deg.]"
    "Foot angle Y at max prop[deg.]"
    "Foot angle Z at max prop[deg.]"
    "Leg angle X at max prop[deg.]"
    "Leg angle Y at max prop[deg.]"
    "Leg angle Z at max prop[deg.]"
    "Shoes COP X at max prop[m]"
    "Shoes COP Y at max prop[m]"
    "Shoes COP Z at max prop[m]"

    "Ankle angle gap X at max prop[deg.]"
    "Ankle anglegap Y at max prop[deg.]"
    "Ankle angle gap Z at max prop[deg.]"
    "Foot angle gap X at max prop[deg.]"
    "Foot angle gap Y at max prop[deg.]"
    "Foot angle gap Z at max prop[deg.]"
    "Leg angle gap X at max prop[deg.]"
    "Leg angle gap Y at max prop[deg.]"
    "Leg angle gap Z at max prop[deg.]"
    "COP-COG gap X at max prop[m]"
    "COP-COG gap Y at max prop[m]"
    "COP-COG gap Z at max prop[m]"
    %

    %パワー関連変数
    "Ankle max power X[W/kg]"
    "Ankle max power Y[W/kg]"
    "Ankle max power Z[W/kg]"
    "Knee max power X[W/kg]"
    "Knee max power Y[W/kg]"
    "Knee max power Z[W/kg]"
    "Hip max power X[W/kg]"
    "Hip max power Y[W/kg]"
    "Hip max power Z[W/kg]"

    "Ankle work X[J/kg]"
    "Ankle work Y[J/kg]"
    "Ankle work Z[J/kg]"
    "Ankle work X in Fstrt-peak[J/kg]"
    "Ankle work Y in Fstrt-peak[J/kg]"
    "Ankle work Z in Fstrt-peak[J/kg]"
    "Ankle work X in Fpeak-end[J/kg]"
    "Ankle work Y in Fpeak-end[J/kg]"
    "Ankle work Z in Fpeak-end[J/kg]"

    "Knee work X[J/kg]"
    "Knee work Y[J/kg]"
    "Knee work Z[J/kg]"
    "Knee work X in Fstrt-peak[J/kg]"
    "Knee work Y in Fstrt-peak[J/kg]"
    "Knee work Z in Fstrt-peak[J/kg]"
    "Knee work X in Fpeak-end[J/kg]"
    "Knee work Y in Fpeak-end[J/kg]"
    "Knee work Z in Fpeak-end[J/kg]"


    "Hip work X[J/kg]"
    "Hip work Y[J/kg]"
    "Hip work Z[J/kg]"
    "Hip work X in Fstrt-peak[J/kg]"
    "Hip work Y in Fstrt-peak[J/kg]"
    "Hip work Z in Fstrt-peak[J/kg]"
    "Hip work X in Fpeak-end[J/kg]"
    "Hip work Y in Fpeak-end[J/kg]"
    "Hip work Z in Fpeak-end[J/kg]"    

    "Ankle work X positive [J/kg]"
    "Ankle work Y positive [J/kg]"
    "Ankle work Z positive [J/kg]"
    "Ankle work X negative [J/kg]"
    "Ankle work Y negative [J/kg]"
    "Ankle work Z negative [J/kg]"

    "Knee work X positive [J/kg]"
    "Knee work Y positive [J/kg]"
    "Knee work Z positive [J/kg]"
    "Knee work X negative [J/kg]"
    "Knee work Y negative [J/kg]"
    "Knee work Z negative [J/kg]"

    "Hip work X positive [J/kg]"
    "Hip work Y positive [J/kg]"
    "Hip work Z positive [J/kg]"
    "Hip work X negative [J/kg]"
    "Hip work Y negative [J/kg]"
    "Hip work Z negative [J/kg]"

    "Impulse Z/Ankle work X[Ns/kgJ]"
    "Impulse Z/Ankle work X posi[Ns/kgJ]"
    "Impulse Z/Ankle work X nega[Ns/kgJ]"
    "Impulse Z/Knee work X[Ns/kgJ]"
    "Impulse Z/Knee work X posi[Ns/kgJ]"
    "Impulse Z/Knee work X nega[Ns/kgJ]"
    "Impulse Z/Hip work X[Ns/kgJ]"
    "Impulse Z/Hip work X posi[Ns/kgJ]"
    "Impulse Z/Hip work X nega[Ns/kgJ]"

  % 
    %足関節トルクmax時の地面反力
    "Ankle torque max X[Nm/kg]"
    "Ankle torque max Y[Nm/kg]"
    "Ankle torque max Z[Nm/kg]"
    "Knee torque max X[Nm/kg]"
    "Knee torque max Y[Nm/kg]"
    "Knee torque max Z[Nm/kg]"
    "Hip torque max X[Nm/kg]"
    "Hip torque max Y[Nm/kg]"
    "Hip torque max Z[Nm/kg]"

    "Ankle ang X at Ankle tor max[deg.]"
    "Ankle ang Y at Ankle tor max[deg.]"
    "Ankle ang Z at Ankle tor max[deg.]"
    "Knee ang X at Ankle tor max[deg.]"
    "Knee ang Y at Ankle tor max[deg.]"
    "Knee ang Z at Ankle tor max[deg.]"
    "Hip ang X at Ankle tor max[deg.]"
    "Hip ang Y at Ankle tor max[deg.]"
    "Hip ang Z at Ankle tor max[deg.]"

    "Foot ang X at Ankle tor max[deg.]"
    "Foot ang Y at Ankle tor max[deg.]"
    "Foot ang Z at Ankle tor max[deg.]"
    "Shank ang X at Ankle tor max[deg.]"
    "Shank ang Y at Ankle tor max[deg.]"
    "Shank ang Z at Ankle tor max[deg.]"
    "Leg ang X at Ankle tor max[deg.]"
    "Leg ang Y at Ankle tor max[deg.]"
    "Leg ang Z at Ankle tor max[deg.]"

    "GRF X at Ankle tor max[N/kg]"
    "GRF Y at Ankle tor max[N/kg]"
    "GRF Z at Ankle tor max[N/kg]"
    "GRF vec ang X at Ankle tor max[deg.]"
    "GRF vec ang Y at Ankle tor max[deg.]"
    "GRF vec ang Z at Ankle tor max[deg.]"

    "Ankle tor lever arm X at Ankle tor max[m]"
    "Ankle tor lever arm Y at Ankle tor max[m]"
    "Ankle tor lever arm Z at Ankle tor max[m.]"
    "COP in shoes X at Ankle tor max[m]"
    "COP in shoes Y at Ankle tor max[m]"
    "COP in shoes Z at Ankle tor max[m.]"

    "AnkGRF vec angle[deg.]"
    "FootGRF vec angle[deg.]"
  %   %
  %   %
  %   %足関節角度，膝関節角度と足関節トルク，膝関節トルク，地面反力
  %   "Ankle Max dorsi flex ang X[deg.]"
  %   "Ankle Max dorsi flex ang Y[deg.]"
  %   "Ankle Max dorsi flex ang Z[deg.]"
  %   "Leg ang X at dorsi max[deg.]"
  %   "Leg ang Y at dorsi max[deg.]"
  %   "Leg ang Z at dorsi max[deg.]"
  %   "Foot ang X at dorsi max[deg.]"
  %   "Foot ang Y at dorsi max[deg.]"
  %   "Foot ang Z at dorsi max[deg.]"
  %   "Shank ang X at dorsi max[deg.]"
  %   "Shank ang Y at dorsi max[deg.]"
  %   "Shank ang Z at dorsi max[deg.]"
  %   "Ankle tor X at dorsi max[Nm/kg]"
  %   "Ankle tor Y at dorsi max[Nm/kg]"
  %   "Ankle tor Z at dorsi max[Nm/kg]"
  %   "Ankle tor X LeverArm at dorsi max[m]"
  %   "Ankle tor Y LeverArmat dorsi max[m]"
  %   "Ankle tor Z LeverArmat dorsi max[m]"
  %   "Knee tor X at dorsi max[Nm/kg]"
  %   "Knee tor Y at dorsi max[Nm/kg]"
  %   "Knee tor Z at dorsi max[Nm/kg]"
  %   "GRF X at dorsi max[N/kg]"
  %   "GRF Y at dorsi max[N/kg]"
  %   "GRF Z at dorsi max[N/kg]"
  %   "GRF norm at dorsi max[N]"
  %   "COP in shoes X at dorsi max[m]"
  %   "COP in shoes Y at dorsi max[m]"
  %   "COP in shoes Z at dorsi max[m]"
  % 
    %COPCOG関連の変数
    "COP-COG distance at contact[m]"
    "COP-COG distance XY at contact[m]"
    "COP-COG distance YZ at contact[m]"
    "Leg ang XY at contact[deg.]"
    "Leg ang YZ at contact[deg.]"
    "Leg ang ZX at contact[deg.]"
  % 
  %   %足部角度変化とCOP，力積の関係
  %   "Max foot angle X[deg.]"
  %   "Max foot angle Y[deg.]"
  %   "Max foot angle Z[deg.]"
  %   "Time toMax foot angle X[%]"
  %   "Time toMax foot angle Y[%]"
  %   "Time toMax foot angle Z[%]"
  %   "Time toMax foot angle X[s]"
  %   "Time toMax foot angle Y[s]"
  %   "Time toMax foot angle Z[s]"
  % 
  % 
  %   "Shank angle X at Max foot angle[deg.]"
  %   "Shank angle Y at Max foot angle[deg.]"
  %   "Shank angle Z at Max foot angle[deg.]"
  %   "Ankle angle X at Max foot angle[deg.]"
  %   "Ankle angle Y at Max foot angle[deg.]"
  %   "Ankle angle Z at Max foot angle[deg.]"
  %   "Knee angle X at Max foot angle[deg.]"
  %   "Knee angle Y at Max foot angle[deg.]"
  %   "Knee angle Z at Max foot angle[deg.]"
  %   "Leg angle X at Max foot angle[deg.]"
  %   "Leg angle Y at Max foot angle[deg.]"
  %   "Leg angle Z at Max foot angle[deg.]"
  %   "COPCOG dist. X at Max foot angle[m]"
  %   "COPCOG dist. Y at Max foot angle[m]"
  %   "COPCOG dist. Z at Max foot angle[m]"
  %   "COPCOG angle X at Max foot angle[deg.]"
  %   "COPCOG angle Y at Max foot angle[deg.]"
  %   "COPCOG angle Z at Max foot angle[deg.]"
  %   "COP in Shoes X at Foot ang max[m]"
  %   "COP in Shoes Y at Foot ang max[m]"
  %   "COP in Shoes Z at Foot ang max[m]"
  %   "COP in Shoes2 X at Foot ang max[m]"
  %   "COP in Shoes2 Y at Foot ang max[m]"
  %   "COP in Shoes2 Z at Foot ang max[m]"
  % 
  %   "Foot angle gap X at Max foot angle[deg.]"
  %   "Foot angle gap Y at Max foot angle[deg.]"
  %   "Foot angle gap Z at Max foot angle[deg.]"
  %   "Shank angle gap X at Max foot angle[deg.]"
  %   "Shank angle gap Y at Max foot angle[deg.]"
  %   "Shank angle gap Z at Max foot angle[deg.]"
  %   "Ankle angle gap X at Max foot angle[deg.]"
  %   "Ankle angle gap Y at Max foot angle[deg.]"
  %   "Ankle angle gap Z at Max foot angle[deg.]"
  %   "Knee angle gap X at Max foot angle[deg.]"
  %   "Knee angle gap Y at Max foot angle[deg.]"
  %   "Knee angle gap Z at Max foot angle[deg.]"
  %   "Leg angle gap X at Max foot angle[deg.]"
  %   "Leg angle gap Y at Max foot angle[deg.]"
  %   "Leg angle gap Z at Max foot angle[deg.]"
  %   "COPCOG dist gap X at Max foot angle[m]"
  %   "COPCOG dist gap Y at Max foot angle[m]"
  %   "COPCOG dist gap Z at Max foot angle[m]"
  %   "COPCOG angle gap X at Max foot angle[deg.]"
  %   "COPCOG angle gap Y at Max foot angle[deg.]"
  %   "COPCOG angle gap Z at Max foot angle[deg.]"
  %   "COP in shoes gap X at Max foot angle[m]"
  %   "COP in shoes gap Y at Max foot angle[m]"
  %   "COP in shoes gap Z at Max foot angle[m]"
  % 
  %   "Impulse X contact to Max foot angle[Ns/kg]"
  %   "Impulse Y contact to Max foot angle[Ns/kg]"
  %   "Impulse Z contact to Max foot angle[Ns/kg]"
  %   "Impulse X Max foot angle to TO[Ns/kg]"
  %   "Impulse Y Max foot angle to TO[Ns/kg]"
  %   "Impulse Z Max foot angle to TO[Ns/kg]"
  %   "GRF vec angle X at Max foot angle[deg.]"
  %   "GRF vec angle Y at Max foot angle[deg.]"
  %   "GRF vec angle Z at Max foot angle[deg.]"
  %   "GRF X at Max foot angle[N/kg]"
  %   "GRF Y at Max foot angle[N/kg]"
  %   "GRF Z at Max foot angle[N/kg]"
  %   "Average force X until Max foot angle[deg.]"
  %   "Average force Y until Max foot angle[deg.]"
  %   "Average force Z until Max foot angle[deg.]"
  %   "GRF vector norm at Max foot angle[N/kg]"
  % 
  %   "Ankle torque X at Max foot angle[Nm/kg]"
  %   "Ankle torque Y at Max foot angle[Nm/kg]"
  %   "Ankle torque Z at Max foot angle[Nm/kg]"
  %   "Knee torque X at Max foot angle[Nm/kg]"
  %   "Knee torque Y at Max foot angle[Nm/kg]"
  %   "Knee torque Z at Max foot angle[Nm/kg]"
  %   "Ankle torque lever arm X[m]"
  %   "Ankle torque lever arm Y[m]"
  %   "Ankle torque lever arm Z[m]"
  % 
  %   "Ankle angular impulse X until Max foot angle[Nms/kg]"
  %   "Ankle angular impulse Y until Max foot angle[Nms/kg]"
  %   "Ankle angular impulse Z until Max foot angle[Nms/kg]"
  %   "Knee angular impulse X until Max foot angle[Nms/kg]"
  %   "Knee angular impulse Y until Max foot angle[Nms/kg]"
  %   "Knee angular impulse Z until Max foot angle[Nms/kg]"
  % 
  % 
  %

  "Ankle angle gap X[deg.]"
  "Ankle angle gap Y[deg.]"
  "Ankle angle gap Z[deg.]"
  "Knee angle gap X[deg.]"
  "Knee angle gap Y[deg.]"
  "Knee angle gap Z[deg.]"
  "Hip angle gap X[deg.]"
  "Hip angle gap Y[deg.]"
  "Hip angle gap Z[deg.]"

  "Ankle stiffness X"
  "Ankle stiffness Y"
  "Ankle stiffness Z" 
  "Knee stiffness X"
  "Knee stiffness Y"
  "Knee stiffness Z"
  "Hip stiffness X"
  "Hip stiffness Y"
  "Hip stiffness Z"

  "Leg stiffness: max v[N/m]"
  "Leg stiffness: legn len min[N/m]"
  "Leg stiffness: max fz/leg len[N/m]"
  "Ankle stiffness 2 X[Nm/rad]"
  "Knee stiffness 2 X[Nm/rad]"
  "Hip stiffness 2 X[Nm/rad]"
  "Ankle angle gap 2 X[deg.]"
  "Ankle angle gap 2 Y[deg.]"
  "Ankle angle gap 2 Z[deg.]"
  "Knee angle gap 2 X[deg.]"
  "Knee angle gap 2 Y[deg.]"
  "Knee angle gap 2 Z[deg.]"
  "Hip angle gap 2 X[deg.]"
  "Hip angle gap 2 Y[deg.]"
  "Hip angle gap 2 Z[deg.]"




 
    
  % 
  %   "COP X in shoes at ctct[m]"
  %   "COP Y in shoes at ctct[m]"
  %   "COP Z in shoes at ctct[m]"
  %   "COP X in shoes at to[m]"
  %   "COP Y in shoes at to[m]"
  %   "COP Z in shoes at to[m]"
  % 
  %   "Max COP X in shoes 0-100%[m]"
  %   "Max COP Y in shoes 0-100%[m]"
  %   "Max COP Z in shoes 0-100%[m]"
  %   "Max COP X in shoes 0-20%[m]"
  %   "Max COP Y in shoes 0-20%[m]"
  %   "Max COP Z in shoes 0-20%[m]"
  %   "Max COP X in shoes 20-40%[m]"
  %   "Max COP Y in shoes 20-40%[m]"
  %   "Max COP Z in shoes 20-40%[m]"
  %   "Max COP X in shoes 40-60%[m]"
  %   "Max COP Y in shoes 40-60%[m]"
  %   "Max COP Z in shoes 40-60%[m]"
  %   "Max COP X in shoes 60-80%[m]"
  %   "Max COP Y in shoes 60-80%[m]"
  %   "Max COP Z in shoes 60-80%[m]"
  %   "Max COP X in shoes 80-100%[m]"
  %   "Max COP Y in shoes 80-100%[m]"
  %   "Max COP Z in shoes 80-100%[m]"
  % 
  %   "Min COP X in shoes 0-100%[m]"
  %   "Min COP Y in shoes 0-100%[m]"
  %   "Min COP Z in shoes 0-100%[m]"
  %   "Min COP X in shoes 0-20%[m]"
  %   "Min COP Y in shoes 0-20%[m]"
  %   "Min COP Z in shoes 0-20%[m]"
  %   "Min COP X in shoes 20-40%[m]"
  %   "Min COP Y in shoes 20-40%[m]"
  %   "Min COP Z in shoes 20-40%[m]"
  %   "Min COP X in shoes 40-60%[m]"
  %   "Min COP Y in shoes 40-60%[m]"
  %   "Min COP Z in shoes 40-60%[m]"
  %   "Min COP X in shoes 60-80%[m]"
  %   "Min COP Y in shoes 60-80%[m]"
  %   "Min COP Z in shoes 60-80%[m]"
  %   "Min COP X in shoes 80-100%[m]"
  %   "Min COP Y in shoes 80-100%[m]"
  %   "Min COP Z in shoes 80-100%[m]"
  % 
  %   "COP gap MaxX in shoes 0-100%[m]"
  %   "COP gap Y in shoes 0-100%[m]"
  %   "COP gap Z in shoes 0-100%[m]"
  %   "COP gap MaxX in shoes 0-20%[m]"
  %   "COP gap Y in shoes 0-20%[m]"
  %   "COP gap Z in shoes 0-20%[m]"
  %   "COP gap X in shoes 20-40%[m]"
  %   "COP gap Y in shoes 20-40%[m]"
  %   "COP gap Z in shoes 20-40%[m]"
  %   "COP gap X in shoes 40-60%[m]"
  %   "COP gap Y in shoes 40-60%[m]"
  %   "COP gap Z in shoes 40-60%[m]"
  %   "COP gap X in shoes 60-80%[m]"
  %   "COP gap Y in shoes 60-80%[m]"
  %   "COP gap Z in shoes 60-80%[m]"
  %   "COP gap X in shoes 80-100%[m]"
  %   "COP gap Y in shoes 80-100%[m]"
  %   "COP gap Z in shoes 80-100%[m]"
  % 
  % "Foot angle X in shoes at ctct[m]"
  %   "Foot angle Y in shoes at ctct[m]"
  %   "Foot angle Z in shoes at ctct[m]"
  %   "Foot angle X in shoes at to[m]"
  %   "Foot angle Y in shoes at to[m]"
  %   "Foot angle Z in shoes at to[m]"
  % 
  %   "Max Foot angle X in shoes 0-100%[m]"
  %   "Max Foot angle Y in shoes 0-100%[m]"
  %   "Max Foot angle Z in shoes 0-100%[m]"
  %   "Max Foot angle X in shoes 0-20%[m]"
  %   "Max Foot angle Y in shoes 0-20%[m]"
  %   "Max Foot angle Z in shoes 0-20%[m]"
  %   "Max Foot angle X in shoes 20-40%[m]"
  %   "Max Foot angle Y in shoes 20-40%[m]"
  %   "Max Foot angle Z in shoes 20-40%[m]"
  %   "Max Foot angle X in shoes 40-60%[m]"
  %   "Max Foot angle Y in shoes 40-60%[m]"
  %   "Max Foot angle Z in shoes 40-60%[m]"
  %   "Max Foot angle X in shoes 60-80%[m]"
  %   "Max Foot angle Y in shoes 60-80%[m]"
  %   "Max Foot angle Z in shoes 60-80%[m]"
  %   "Max Foot angle X in shoes 80-100%[m]"
  %   "Max Foot angle Y in shoes 80-100%[m]"
  %   "Max Foot angle Z in shoes 80-100%[m]"
  % 
  %   "Min Foot angle X in shoes 0-100%[m]"
  %   "Min Foot angle Y in shoes 0-100%[m]"
  %   "Min Foot angle Z in shoes 0-100%[m]"
  %   "Min Foot angle X in shoes 0-20%[m]"
  %   "Min Foot angle Y in shoes 0-20%[m]"
  %   "Min Foot angle Z in shoes 0-20%[m]"
  %   "Min Foot angle X in shoes 20-40%[m]"
  %   "Min Foot angle Y in shoes 20-40%[m]"
  %   "Min Foot angle Z in shoes 20-40%[m]"
  %   "Min Foot angle X in shoes 40-60%[m]"
  %   "Min Foot angle Y in shoes 40-60%[m]"
  %   "Min Foot angle Z in shoes 40-60%[m]"
  %   "Min Foot angle X in shoes 60-80%[m]"
  %   "Min Foot angle Y in shoes 60-80%[m]"
  %   "Min Foot angle Z in shoes 60-80%[m]"
  %   "Min Foot angle X in shoes 80-100%[m]"
  %   "Min Foot angle Y in shoes 80-100%[m]"
  %   "Min Foot angle Z in shoes 80-100%[m]"
  % 
  %   "Foot angle gap MaxX in shoes 0-100%[m]"
  %   "Foot angle gap Y in shoes 0-100%[m]"
  %   "Foot angle gap Z in shoes 0-100%[m]"
  %   "Foot angle gap MaxX in shoes 0-20%[m]"
  %   "Foot angle gap Y in shoes 0-20%[m]"
  %   "Foot angle gap Z in shoes 0-20%[m]"
  %   "Foot angle gap X in shoes 20-40%[m]"
  %   "Foot angle gap Y in shoes 20-40%[m]"
  %   "Foot angle gap Z in shoes 20-40%[m]"
  %   "Foot angle gap X in shoes 40-60%[m]"
  %   "Foot angle gap Y in shoes 40-60%[m]"
  %   "Foot angle gap Z in shoes 40-60%[m]"
  %   "Foot angle gap X in shoes 60-80%[m]"
  %   "Foot angle gap Y in shoes 60-80%[m]"
  %   "Foot angle gap Z in shoes 60-80%[m]"
  %   "Foot angle gap X in shoes 80-100%[m]"
  %   "Foot angle gap Y in shoes 80-100%[m]"
  %   "Foot angle gap Z in shoes 80-100%[m]"
  % 
  %   %ロボ試験との比較用データ
  %    "GRF X robo ang 1-1"
  %   "GRF Y robo ang 1-1"
  %   "GRF Z robo ang 1-1"
  %   "GRF W X robo ang 1-1"
  %   "GRF W Y robo ang 1-1"
  %   "GRF W Z robo ang 1-1"
  %   "GRF vecang X robo ang 1-1"
  %   "GRF vecang Y robo ang 1-1"
  %   "GRF vecang Z robo ang 1-1"
  %   "FOOT ang X robo ang 1-1"
  %   "FOOT ang Y robo ang 1-1"
  %   "FOOT ang Z robo ang 1-1"
  % 
  %   "GRF X robo ang 1-2"
  %   "GRF Y robo ang 1-2"
  %   "GRF Z robo ang 1-2"
  %   "GRF W X robo ang 1-2"
  %   "GRF W Y robo ang 1-2"
  %   "GRF W Z robo ang 1-2"
  %   "GRF vecang X robo ang 1-2"
  %   "GRF vecang Y robo ang 1-2"
  %   "GRF vecang Z robo ang 1-2"
  %   "FOOT ang X robo ang 1-2"
  %   "FOOT ang Y robo ang 1-2"
  %   "FOOT ang Z robo ang 1-2"
  % 
  %   "GRF X robo ang 1-3"
  %   "GRF Y robo ang 1-3"
  %   "GRF Z robo ang 1-3"
  %   "GRF W X robo ang 1-3"
  %   "GRF W Y robo ang 1-3"
  %   "GRF W Z robo ang 1-3"
  %   "GRF vecang X robo ang 1-3"
  %   "GRF vecang Y robo ang 1-3"
  %   "GRF vecang Z robo ang 1-3"
  %    "FOOT ang X robo ang 1-3"
  %   "FOOT ang Y robo ang 1-3"
  %   "FOOT ang Z robo ang 1-3"
  % 
  %   "GRF X robo ang 1-4"
  %   "GRF Y robo ang 1-4"
  %   "GRF Z robo ang 1-4"
  %   "GRF W X robo ang 1-4"
  %   "GRF W Y robo ang 1-4"
  %   "GRF W Z robo ang 1-4"
  %   "GRF vecang X robo ang 1-4"
  %   "GRF vecang Y robo ang 1-4"
  %   "GRF vecang Z robo ang 1-4"
  %    "FOOT ang X robo ang 1-4"
  %   "FOOT ang Y robo ang 1-4"
  %   "FOOT ang Z robo ang 1-4"
  % 
  %    "GRF X robo 2-1"
  %   "GRF Y robo 2-1"
  %   "GRF Z robo 2-1"
  %   "GRF W X robo 2-1"
  %   "GRF W Y robo 2-1"
  %   "GRF W Z robo 2-1"
  %   "GRF vecang X robo ang 2-1"
  %   "GRF vecang Y robo ang 2-1"
  %   "GRF vecang Z robo ang 2-1"
  %    "FOOT ang X robo ang 2-1"
  %   "FOOT ang Y robo ang 2-1"
  %   "FOOT ang Z robo ang 2-1"
  % 
  %   "GRF X robo  2-2"
  %   "GRF Y robo  2-2"
  %   "GRF Z robo  2-2"
  %   "GRF W X robo  2-2"
  %   "GRF W Y robo  2-2"
  %   "GRF W Z robo  2-2"
  %   "GRF vecang X robo ang 2-2"
  %   "GRF vecang Y robo ang 2-2"
  %   "GRF vecang Z robo ang 2-2"
  %     "FOOT ang X robo ang 2-2"
  %   "FOOT ang Y robo ang 2-2"
  %   "FOOT ang Z robo ang 2-2"
  % 
  %   "GRF X robo  2-3"
  %   "GRF Y robo  2-3"
  %   "GRF Z robo  2-3"
  %   "GRF W X robo  2-3"
  %   "GRF W Y robo  2-3"
  %   "GRF W Z robo  2-3"
  %   "GRF vecang X robo ang 2-3"
  %   "GRF vecang Y robo ang 2-3"
  %   "GRF vecang Z robo ang 2-3"
  %    "FOOT ang X robo ang 2-3"
  %   "FOOT ang Y robo ang 2-3"
  %   "FOOT ang Z robo ang 2-3"
  % 
  %   "GRF X robo  2-4"
  %   "GRF Y robo  2-4"
  %   "GRF Z robo  2-4"
  %   "GRF W X robo  2-4"
  %   "GRF W Y robo  2-4"
  %   "GRF W Z robo  2-4"
  %   "GRF vecang X robo ang 2-4"
  %   "GRF vecang Y robo ang 2-4"
  %   "GRF vecang Z robo ang 2-4"
  %   "FOOT ang X robo ang 2-4"
  %   "FOOT ang Y robo ang 2-4"
  %   "FOOT ang Z robo ang 2-4"
  % 
  % 
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FF時間中の力積，平均力 etc
"BFF time[s]"
"FF time[s]"
"AFF time[s]"

"Impulse X in BFF[Ns/kg]"
"Impulse Y in BFF[Ns/kg]"
"Impulse Z in BFF[Ns/kg]"
"Mean force X in BFF[N/kg]"
"Mean force Y in BFF[N/kg]"
"Mean force Z in BFF[N/kg]"
"Anle work X in BFF[J]"
"Anle work Y in BFF[J]"
"Anle work Z in BFF[J]"
"Knee work X in BFF[J]"
"Knee work Y in BFF[J]"
"Knee work Z in BFF[J]"
"Hip work X in BFF[J]"
"Hip work Y in BFF[J]"
"Hip work Z in BFF[J]"



"Impulse X in FF[Ns/kg]"
"Impulse Y in FF[Ns/kg]"
"Impulse Z in FF[Ns/kg]"
"Mean force X in FF[N/kg]"
"Mean force Y in FF[N/kg]"
"Mean force Z in FF[N/kg]"
"Anle work X in FF[J]"
"Anle work Y in FF[J]"
"Anle work Z in FF[J]"
"Knee work X in FF[J]"
"Knee work Y in FF[J]"
"Knee work Z in FF[J]"
"Hip work X in FF[J]"
"Hip work Y in FF[J]"
"Hip work Z in FF[J]"



"Impulse X in AFF[Ns/kg]"
"Impulse Y in AFF[Ns/kg]"
"Impulse Z in AFF[Ns/kg]"
"Mean force X in AFF[N/kg]"
"Mean force Y in AFF[N/kg]"
"Mean force Z in AFF[N/kg]"
"Anle work X in AFF[J]"
"Anle work Y in AFF[J]"
"Anle work Z in AFF[J]"
"Knee work X in AFF[J]"
"Knee work Y in AFF[J]"
"Knee work Z in AFF[J]"
"Hip work X in AFF[J]"
"Hip work Y in AFF[J]"
"Hip work Z in AFF[J]"

"Max GRF X in AER phase[N/kg]"
"Max GRF Y in AER phase[N/kg]"
"Max GRF Z in AER phase[N/kg]"
"Comp Impulse X in AER phase[N/kg]"
"Comp Impulse Y in AER phase[N/kg]"
"Comp Impulse Z in AER phase[N/kg]"
"Bounce Impulse X in AER phase[N/kg]"
"Bounce Impulse Y in AER phase[N/kg]"
"Bounce Impulse Z in AER phase[N/kg]"

%　起こしモーメント
"Mement Arm CG Max X index[frm]"
"Mement Arm CG Max Y index[frm]"
"Mement Arm CG Max Z index[frm]"
"Mement Arm CG Max X[mm]"
"Mement Arm CG Max Y[mm]"
"Mement Arm CG Max Z[mm]"
"Mement Arm CG Min X index[frm]"
"Mement Arm CG Min Y index[frm]"
"Mement Arm CG Min Z index[frm]"
"Mement Arm CG Min X[mm]"
"Mement Arm CG Min Y[mm]"
"Mement Arm CG Min Z[mm]"

"Mement CG Max X index[frm]"
"Mement CG Max Y index[frm]"
"Mement CG Max Z index[frm]"
"Mement CG Max X[Nm]"
"Mement CG Max Y[Nm]"
"Mement CG Max Z[Nm]"
"Mement CG Min X index[frm]"
"Mement CG Min Y index[frm]"
"Mement CG Min Z index[frm]"
"Mement CG Min X[Nm]"
"Mement CG Min Y[Nm]"
"Mement CG Min Z[Nm]"





    ];

header = header';