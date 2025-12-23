function bodyseg = setBodySegPara(seg,segVar,CS,side)
segname = "FOOT";
bodyseg.seg_mass.(segname) = seg.(segname+"_mass");
bodyseg.seg_acc.(segname) = segVar.(side+segname+"G_acc");
bodyseg.seg_omega.(segname) = segVar.(side+segname+"_omegaG");
bodyseg.seg_moi.(segname) = seg.(segname+"_MOI");
bodyseg.seg_ro.(segname) = CS.(side+segname);
bodyseg.cg.(segname) = seg.(side+segname+"G");
segname = "SHANK";
bodyseg.seg_mass.(segname) = seg.(segname+"_mass");
bodyseg.seg_acc.(segname) = segVar.(side+segname+"G_acc");
bodyseg.seg_omega.(segname) = segVar.(side+segname+"_omegaG");
bodyseg.seg_moi.(segname) = seg.(segname+"_MOI");
bodyseg.seg_ro.(segname) = CS.(side+segname);
bodyseg.cg.(segname) = seg.(side+segname+"G");
segname = "THIGH";
bodyseg.seg_mass.(segname) = seg.(segname+"_mass");
bodyseg.seg_acc.(segname) = segVar.(side+segname+"G_acc");
bodyseg.seg_omega.(segname) = segVar.(side+segname+"_omegaG");
bodyseg.seg_moi.(segname) = seg.(segname+"_MOI");
bodyseg.seg_ro.(segname) = CS.(side+segname);
bodyseg.cg.(segname) = seg.(side+segname+"G");

segname = "ANK";
bodyseg.seg_omega.(segname) = segVar.(side+segname+"_omegaG");
segname = "KNEE";
bodyseg.seg_omega.(segname) = segVar.(side+segname+"_omegaG");
segname = "HIP";
bodyseg.seg_omega.(segname) = segVar.(side+segname+"_omegaG");




end