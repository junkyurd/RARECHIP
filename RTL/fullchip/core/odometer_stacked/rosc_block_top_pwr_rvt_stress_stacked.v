module rosc_block_top_pwr_rvt_stress_stacked(	
	SEL_INV99, 
	SEL_INV101, 
	SEL_INV97, 
	START, 
	AC_DC, 
	AC_STRESS_CLK,
     	EN_POWER_ROSC, 
     	EN_ROSC, 
     	MEAS_STRESS, 
     	OUT, 
     	VDD, VSS);
     	
  	input SEL_INV99; 
  	input SEL_INV101; 
  	input SEL_INV97; 
  	input START; 
  	input AC_DC; 
  	input AC_STRESS_CLK; 
  	input EN_POWER_ROSC;
       	input EN_ROSC; 
       	input MEAS_STRESS;
       	
  	output OUT;
  	
  	inout VDD, VSS;
  	
  	wire SEL_INV99; 
  	wire SEL_INV101; 
  	wire SEL_INV97; 
  	wire START; 
  	wire AC_DC; 
  	wire AC_STRESS_CLK; 
  	wire EN_POWER_ROSC;
       	wire EN_ROSC, MEAS_STRESS;
  	wire OUT;
  	wire VDD, VSS;
  	wire IN_INV99, IN_INV101, IN_INV97, MOD_VDD_INV99, MOD_VDD_INV101, MOD_VDD_INV97, OUT_INV99, OUT_INV101, OUT_INV97;

  	// 3 ring oscillators with control blocks
  	ROSC103_control_stacked rosc_control(
  	.SEL_INV99 (SEL_INV99), 
  	.SEL_INV101 (SEL_INV101),
       	.SEL_INV97 (SEL_INV97), 
       	.OUT_INV99 (OUT_INV99), 
       	.OUT_INV101 (OUT_INV101),
       	.OUT_INV97 (OUT_INV97), 
       	.START (START), 
       	.AC_DC (AC_DC), 
       	.AC_STRESS_CLK (AC_STRESS_CLK),
       	.EN_POWER_ROSC (EN_POWER_ROSC), 
       	.EN_ROSC (EN_ROSC), 
       	.MEAS_STRESS (MEAS_STRESS), 
       	.IN_INV99 (IN_INV99),
       	.IN_INV101 (IN_INV101), 
       	.IN_INV97 (IN_INV97), 
       	.OUT (OUT), 
       	.MOD_VDD_INV99 (MOD_VDD_INV99), 
       	.MOD_VDD_INV101 (MOD_VDD_INV101), 
       	.MOD_VDD_INV97 (MOD_VDD_INV97),
       	.VDD (VDD),
       	.VSS (VSS));

	// chain for ring oscillator
	ROSC35_SEL_INV_RVT_STRESS_stacked ROSC_INV99(.IN(IN_INV99), .OUT(OUT_INV99), .VDD(MOD_VDD_INV99), .VSS(VSS));
	ROSC35_SEL_INV_RVT_STRESS_stacked ROSC_INV101(.IN(IN_INV101), .OUT(OUT_INV101), .VDD(MOD_VDD_INV101), .VSS(VSS));
	ROSC35_SEL_INV_RVT_STRESS_stacked ROSC_INV97(.IN(IN_INV97), .OUT(OUT_INV97), .VDD(MOD_VDD_INV97), .VSS(VSS));


endmodule

