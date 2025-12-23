function trial = estimateMarkerDataSVD(trial, nude, joint_marker, seg_list, stand_dataR, stand_dataL)
for ij = 1:length(trial.rASIS)

    % trial.svd_PEL(1+4*(ij-1):4+4*(ij-1), :) = SVDm([[nude.stand.rASIS nude.stand.rPSIS nude.stand.lPSIS];...
    %     [trial.rASIS(ij, :) trial.rPSIS(ij, :) trial.lPSIS(ij, :)]]);
    % tmp = trial.svd_PEL(1+4*(ij-1):4+4*(ij-1), :) * [nude.stand.lASIS 1]';
    % trial.lASIS(ij, :) = tmp(1:end-1)';

    side = "l";
    no = 1;
    trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) = SVDm([[nude.(side+"DUM"+no+"au")  nude.(side+"DUM"+no+"al") nude.(side+"DUM"+no+"pl")];...
        [trial.(side+"DUM"+no+"au")(ij, :) trial.(side+"DUM"+no+"al")(ij, :) trial.(side+"DUM"+no+"pl")(ij, :)]]);
    pnt_name = joint_marker(1);
    tmp = trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) * [nude.(side+pnt_name) 1]';
    trial.(side+pnt_name)(ij, :) = tmp(1:end-1)';
    pnt_name = joint_marker(2);
    tmp = trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) * [nude.(side+pnt_name) 1]';
    trial.(side+pnt_name)(ij, :) = tmp(1:end-1)';

    no = 2;
    trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) = SVDm([[nude.(side+"DUM"+no+"au")  nude.(side+"DUM"+no+"al") nude.(side+"DUM"+no+"pl")];...
        [trial.(side+"DUM"+no+"au")(ij, :) trial.(side+"DUM"+no+"al")(ij, :) trial.(side+"DUM"+no+"pl")(ij, :)]]);
    pnt_name = joint_marker(3);
    tmp = trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) * [nude.(side+pnt_name) 1]';
    trial.(side+pnt_name)(ij, :) = tmp(1:end-1)';
    pnt_name = joint_marker(4);
    tmp = trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) * [nude.(side+pnt_name) 1]';
    trial.(side+pnt_name)(ij, :) = tmp(1:end-1)';

    seg_name = side+"FOOT";
    standD = stand_dataR;
    trial.("svd"+seg_name) = SVDm([[standD.stand.(side+"HEELm") standD.stand.(side+"HEELc") standD.stand.(side+"HEELl") ];...
        [trial.(side+"HEELm")(ij, :) trial.(side+"HEELc")(ij, :) trial.(side+"HEELl")(ij, :) ]]);
    % pnt_name = side+"HEELm";
    % tmp = trial.("svd"+seg_name) * [standD.stand.(pnt_name) 1]';
    % trial.(pnt_name)(ij, :) = tmp(1:end-1)';
    % pnt_name = side+"HEELl";
    % tmp = trial.("svd"+seg_name) * [standD.stand.(pnt_name) 1]';
    % trial.(pnt_name)(ij, :) = tmp(1:end-1)';
    pnt_name = side+"BALm";
    tmp = trial.("svd"+seg_name) * [standD.stand.(pnt_name) 1]';
    trial.(pnt_name)(ij, :) = tmp(1:end-1)';
      pnt_name = side+"BALl";
    tmp = trial.("svd"+seg_name) * [standD.stand.(pnt_name) 1]';
    trial.(pnt_name)(ij, :) = tmp(1:end-1)';


    side = "r";
    no = 1;
    trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) = SVDm([[nude.(side+"DUM"+no+"au")  nude.(side+"DUM"+no+"al") nude.(side+"DUM"+no+"pl")];...
        [trial.(side+"DUM"+no+"au")(ij, :) trial.(side+"DUM"+no+"al")(ij, :) trial.(side+"DUM"+no+"pl")(ij, :)]]);
    pnt_name = joint_marker(1);
    tmp = trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) * [nude.(side+pnt_name) 1]';
    trial.(side+pnt_name)(ij, :) = tmp(1:end-1)';
    pnt_name = joint_marker(2);
    tmp = trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) * [nude.(side+pnt_name) 1]';
    trial.(side+pnt_name)(ij, :) = tmp(1:end-1)';

    no = 2;
    trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) = SVDm([[nude.(side+"DUM"+no+"au")  nude.(side+"DUM"+no+"al") nude.(side+"DUM"+no+"pl")];...
        [trial.(side+"DUM"+no+"au")(ij, :) trial.(side+"DUM"+no+"al")(ij, :) trial.(side+"DUM"+no+"pl")(ij, :)]]);
    pnt_name = joint_marker(3);
    tmp = trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) * [nude.(side+pnt_name) 1]';
    trial.(side+pnt_name)(ij, :) = tmp(1:end-1)';
    pnt_name = joint_marker(4);
    tmp = trial.("svd_"+side+seg_list(no))(1+4*(ij-1):4+4*(ij-1), :) * [nude.(side+pnt_name) 1]';
    trial.(side+pnt_name)(ij, :) = tmp(1:end-1)';

    seg_name = side+"FOOT";
    standD = stand_dataR;
    trial.("svd"+seg_name) = SVDm([[standD.stand.(side+"HEELm") standD.stand.(side+"HEELc") standD.stand.(side+"HEELl") ];...
        [trial.(side+"HEELm")(ij, :) trial.(side+"HEELc")(ij, :) trial.(side+"HEELl")(ij, :) ]]);
    % pnt_name = side+"HEELm";
    % tmp = trial.("svd"+seg_name) * [standD.stand.(pnt_name) 1]';
    % trial.(pnt_name)(ij, :) = tmp(1:end-1)';
    % pnt_name = side+"HEELl";
    % tmp = trial.("svd"+seg_name) * [standD.stand.(pnt_name) 1]';
    % trial.(pnt_name)(ij, :) = tmp(1:end-1)';
    pnt_name = side+"BALm";
    tmp = trial.("svd"+seg_name) * [standD.stand.(pnt_name) 1]';
    trial.(pnt_name)(ij, :) = tmp(1:end-1)';
        pnt_name = side+"BALl";
    tmp = trial.("svd"+seg_name) * [standD.stand.(pnt_name) 1]';
    trial.(pnt_name)(ij, :) = tmp(1:end-1)';


end
side="r";
pnt_name = joint_marker(1);
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(trial.(side+joint_marker(1)))]);
pnt_name = joint_marker(2);
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(trial.(side+joint_marker(2)))]);
pnt_name = joint_marker(3);
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(trial.(side+joint_marker(3)))]);
pnt_name = joint_marker(4);
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(trial.(side+joint_marker(4)))]);
pnt_name = "BALm";
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(trial.(side+pnt_name))]);
pnt_name = "HEELm";
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(trial.(side+pnt_name))]);


pnt_name = "KNEEc";
tmp = (trial.(side+joint_marker(1))+trial.(side+joint_marker(1)))/2;
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(tmp)]);
trial.(side+pnt_name) = tmp;
pnt_name = "ANKc";
tmp = (trial.(side+joint_marker(3))+trial.(side+joint_marker(4)))/2;
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(tmp)]);
trial.(side+pnt_name) = tmp;

side="l";
pnt_name = joint_marker(1);
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(trial.(side+joint_marker(1)))]);
pnt_name = joint_marker(2);
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(trial.(side+joint_marker(2)))]);
pnt_name = joint_marker(3);
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(trial.(side+joint_marker(3)))]);
pnt_name = joint_marker(4);
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(trial.(side+joint_marker(4)))]);
pnt_name = "BALm";
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(trial.(side+pnt_name))]);


pnt_name = "KNEEc";
tmp = (trial.(side+joint_marker(1))+trial.(side+joint_marker(1)))/2;
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(tmp)]);
trial.(side+pnt_name) = tmp;
pnt_name = "ANKc";
tmp = (trial.(side+joint_marker(3))+trial.(side+joint_marker(4)))/2;
trial.sdata = horzcat(trial.sdata, [side+pnt_name+"_x" side+pnt_name+"_y" side+pnt_name+"_z" ;string(tmp)]);
trial.(side+pnt_name) = tmp;

trial.sdata = rmmissing(trial.sdata,2);

end