module ROSC101_control_stress (
	SEL_INV, 
	SEL_NAND, 
	SEL_NOR, 
	IN_INV, 
	IN_NAND, 
	IN_NOR, 
	OUT_INV, 
	OUT_NAND, 
	OUT_NOR, 
	START, 
	AC_DC, 
	AC_STRESS_CLK, 
	EN_POWER_ROSC, 
	EN_ROSC, 
	MEAS_STRESS,
	OUT,
	MOD_VDD_INV, 
	MOD_VDD_NAND, 
	MOD_VDD_NOR,	 
	VDD, VSS);
	
	output IN_INV, IN_NAND, IN_NOR;
	wire IN_INV, IN_NAND, IN_NOR;
	input OUT_INV, OUT_NAND, OUT_NOR;
	input EN_POWER_ROSC;
	input SEL_INV, SEL_NAND, SEL_NOR;
	input START, AC_DC, AC_STRESS_CLK, EN_ROSC, MEAS_STRESS;
	output OUT;
	output MOD_VDD_INV, MOD_VDD_NAND, MOD_VDD_NOR; // modified VDD by power controller to be used at rosc
	inout VDD, VSS;
	//reg OUT;
	wire SEL_POWER_OFF, SELb_POWER_1, SELb_POWER_2, SELb_POWER_3;
	wire EN_CHAIN;

	freq_trimming_control freq_trim(EN_POWER_ROSC,SEL_POWER_OFF);

	pwr_controller pwr_inv(
	.SEL_POWER_OFF(SEL_POWER_OFF), 
	.MEAS_STRESS(MEAS_STRESS), 
	.OUT(MOD_VDD_INV), 
	.VDD(VDD), .VSS(VSS));

	pwr_controller pwr_NAND(
	.SEL_POWER_OFF(SEL_POWER_OFF), 
	.MEAS_STRESS(MEAS_STRESS), 
	.OUT(MOD_VDD_NAND), 
	.VDD(VDD), .VSS(VSS));

	pwr_controller pwr_NOR(
	.SEL_POWER_OFF(SEL_POWER_OFF), 
	.MEAS_STRESS(MEAS_STRESS), 
	.OUT(MOD_VDD_NOR), 
	.VDD(VDD), .VSS(VSS));

	assign EN_CHAIN =  ~(~MEAS_STRESS | SEL_POWER_OFF) ;

	//assign #251.00 IN_INV =(EN_ROSC &  ~(OUT_INV & SEL_INV)) | (~EN_ROSC & EN_CHAIN & START & AC_DC & AC_STRESS_CLK);
	//assign #252.00 IN_NAND =(EN_ROSC &  ~(OUT_NAND & SEL_NAND)) | (~EN_ROSC & EN_CHAIN & START & AC_DC & AC_STRESS_CLK);
	//assign #253.00 IN_NOR =(EN_ROSC &  ~(OUT_NOR & SEL_NOR)) | (~EN_ROSC & EN_CHAIN & START & AC_DC & AC_STRESS_CLK);

	//assign #251.1 OUT = EN_ROSC & ((OUT_INV & SEL_INV) | (OUT_NAND & SEL_NAND & ~SEL_INV) | (OUT_NOR & SEL_NOR & ~SEL_NAND & ~SEL_INV));
	
	
	assign #10 IN_INV =(EN_ROSC & SEL_INV &  ~OUT_INV) | (EN_ROSC & ~SEL_INV & START & AC_DC & AC_STRESS_CLK) | (~EN_ROSC & START & AC_DC & AC_STRESS_CLK);
	assign #12 IN_NAND =(EN_ROSC & SEL_NAND &  ~OUT_NAND) | (EN_ROSC & ~SEL_NAND & START & AC_DC & AC_STRESS_CLK) | (~EN_ROSC & START & AC_DC & AC_STRESS_CLK);
	assign #13 IN_NOR =(EN_ROSC & SEL_NOR &  ~OUT_NOR) | (EN_ROSC & ~SEL_NOR & START & AC_DC & AC_STRESS_CLK) | (~EN_ROSC & START & AC_DC & AC_STRESS_CLK);

	assign #10 OUT = EN_ROSC & ((OUT_INV & SEL_INV) | (OUT_NAND & SEL_NAND & ~SEL_INV) | (OUT_NOR & SEL_NOR & ~SEL_NAND & ~SEL_INV));	
	


endmodule

module rosc_block_top_pwr_lvt_stress(	
	SEL_INV, 
	SEL_NAND, 
	SEL_NOR, 
	START, 
	AC_DC, 
	AC_STRESS_CLK,
     	EN_POWER_ROSC, 
     	EN_ROSC, 
     	MEAS_STRESS, 
     	OUT, 
     	VDD, VSS);
     	
  	input SEL_INV; 
  	input SEL_NAND; 
  	input SEL_NOR; 
  	input START; 
  	input AC_DC; 
  	input AC_STRESS_CLK; 
  	input EN_POWER_ROSC;
       	input EN_ROSC; 
       	input MEAS_STRESS;
       	
  	output OUT;
  	
  	inout VDD, VSS;
  	
  	wire SEL_INV; 
  	wire SEL_NAND; 
  	wire SEL_NOR; 
  	wire START; 
  	wire AC_DC; 
  	wire AC_STRESS_CLK; 
  	wire EN_POWER_ROSC;
       	wire EN_ROSC, MEAS_STRESS;
  	wire OUT;
  	wire VDD, VSS;
  	wire IN_INV, IN_NAND, IN_NOR, MOD_VDD_INV, MOD_VDD_NAND, MOD_VDD_NOR, OUT_INV, OUT_NAND, OUT_NOR;

  	// 3 ring oscillators with control blocks
  	ROSC101_control_stress rosc_control(
  	.SEL_INV (SEL_INV), 
  	.SEL_NAND (SEL_NAND),
       	.SEL_NOR (SEL_NOR), 
       	.OUT_INV (OUT_INV), 
       	.OUT_NAND (OUT_NAND),
       	.OUT_NOR (OUT_NOR), 
       	.START (START), 
       	.AC_DC (AC_DC), 
       	.AC_STRESS_CLK (AC_STRESS_CLK),
       	.EN_POWER_ROSC (EN_POWER_ROSC), 
       	.EN_ROSC (EN_ROSC), 
       	.MEAS_STRESS (MEAS_STRESS), 
       	.IN_INV (IN_INV),
       	.IN_NAND (IN_NAND), 
       	.IN_NOR (IN_NOR), 
       	.OUT (OUT), 
       	.MOD_VDD_INV (MOD_VDD_INV), 
       	.MOD_VDD_NAND (MOD_VDD_NAND), 
       	.MOD_VDD_NOR (MOD_VDD_NOR),
       	.VDD (VDD),
       	.VSS (VSS));

	// chain for ring oscillator
	ROSC101_SEL_INV_LVT_STRESS ROSC_INV(.IN(IN_INV), .OUT(OUT_INV), .VDD(MOD_VDD_INV), .VSS(VSS));
	ROSC101_SEL_NAND_LVT_STRESS ROSC_NAND(.IN(IN_NAND), .OUT(OUT_NAND), .VDD(MOD_VDD_NAND), .VSS(VSS));
	ROSC101_SEL_NOR_LVT_STRESS ROSC_NOR(.IN(IN_NOR), .OUT(OUT_NOR), .VDD(MOD_VDD_NOR), .VSS(VSS));


endmodule

