module freq_trimming_control_stacked(
	EN_POWER_ROSC,
	SEL_POWER_OFF);
	
	input EN_POWER_ROSC;
	output SEL_POWER_OFF;

	assign SEL_POWER_OFF = ~EN_POWER_ROSC ;
endmodule

module pwr_controller_stacked(
	SEL_POWER_OFF,
	MEAS_STRESS,
	OUT,
	VDD,VSS);
	
	input SEL_POWER_OFF,MEAS_STRESS;
	output OUT;
	
	wire  SEL_POWER_OFF,MEAS_STRESS;
	
	wire OUT,MEAS_STRESS_INT,SEL_POWER_INT,SEL1_INT,SEL2_INT,SEL3_INT;
	inout VDD,VSS;

//supply1 VDD ;
//supply0 VSS ;

	INVD2BWP30P140 INV(.I(MEAS_STRESS), .ZN(MEAS_STRESS_INT));
	AN2D2BWP30P140 AND2_OFF (.A1(SEL_POWER_OFF), .A2(MEAS_STRESS_INT), .Z(SEL_POWER_INT));  // controlling of the default switch

	INVD8BWP30P140 INV8_base_1 (.I(SEL_POWER_INT), .ZN(OUT)); //default power switch1
	INVD8BWP30P140 INV8_base_2 (.I(SEL_POWER_INT), .ZN(OUT)); //default power switch	2
	INVD8BWP30P140 INV8_base_3 (.I(SEL_POWER_INT), .ZN(OUT)); //default power switch3
	INVD8BWP30P140 INV8_base_4 (.I(SEL_POWER_INT), .ZN(OUT)); //default power switch4
		

endmodule



// Block for controlling the virtual VDD and ring oscillator selection
module ROSC103_control_stacked (
	SEL_INV99, 
	SEL_INV101, 
	SEL_INV97, 
	IN_INV99, 
	IN_INV101, 
	IN_INV97, 
	OUT_INV99, 
	OUT_INV101, 
	OUT_INV97, 
	START, 
	AC_DC, 
	AC_STRESS_CLK, 
	EN_POWER_ROSC, 
	EN_ROSC, 
	MEAS_STRESS, 
	OUT, 
	MOD_VDD_INV99, 
	MOD_VDD_INV101, 
	MOD_VDD_INV97,
	VDD, VSS);
	
	output IN_INV99, IN_INV101, IN_INV97;
	input OUT_INV99, OUT_INV101, OUT_INV97;
	input EN_POWER_ROSC;
	input SEL_INV99, SEL_INV101, SEL_INV97;
	input START, AC_DC, AC_STRESS_CLK, EN_ROSC, MEAS_STRESS;
	output OUT;
	output MOD_VDD_INV99, MOD_VDD_INV101, MOD_VDD_INV97; // modified VDD by power controller to be used at rosc
	inout VDD, VSS;
	//reg OUT;
	wire SEL_POWER_OFF, SELb_POWER_1, SELb_POWER_2, SELb_POWER_3;
	wire EN_CHAIN;
	
	freq_trimming_control_stacked freq_trim(EN_POWER_ROSC, SEL_POWER_OFF);
	// power control unit which used to control power to be applied to reference and stress rosc
	pwr_controller_stacked pwr_INV99(
	.SEL_POWER_OFF(SEL_POWER_OFF), 
	.MEAS_STRESS(MEAS_STRESS), 
	.OUT(MOD_VDD_INV99), 
	.VDD(VDD), .VSS(VSS));

	pwr_controller_stacked pwr_INV101(
	.SEL_POWER_OFF(SEL_POWER_OFF), 
	.MEAS_STRESS(MEAS_STRESS), 
	.OUT(MOD_VDD_INV101), 
	.VDD(VDD), .VSS(VSS));

	pwr_controller_stacked pwr_INV97(
	.SEL_POWER_OFF(SEL_POWER_OFF), 
	.MEAS_STRESS(MEAS_STRESS), 
	.OUT(MOD_VDD_INV97), 
	.VDD(VDD), .VSS(VSS));

	// determine which ROSC to be used
	// determine use internal rosc or external AC_STRESS_CLK signal
	//buff_block_en buffer_chain (EN_ROSC,EN_ROSC_INT);
	assign EN_CHAIN = ~MEAS_STRESS | SEL_POWER_OFF ;

	assign  #10 IN_INV99 =(EN_ROSC &  ~(OUT_INV99 & SEL_INV99)) | (~EN_ROSC & EN_CHAIN & START & AC_DC & AC_STRESS_CLK);
	assign  #11 IN_INV101 =(EN_ROSC &  ~(OUT_INV101 & SEL_INV101)) | (~EN_ROSC & EN_CHAIN & START & AC_DC & AC_STRESS_CLK);
	assign  #12 IN_INV97 =(EN_ROSC &  ~(OUT_INV97 & SEL_INV97)) | (~EN_ROSC & EN_CHAIN & START & AC_DC & AC_STRESS_CLK);

	assign  #10 OUT = EN_ROSC & ((OUT_INV99 & SEL_INV99) | (OUT_INV101 & SEL_INV101 & ~SEL_INV99) | (OUT_INV97 & SEL_INV97 & ~SEL_INV101 & ~SEL_INV99));
	
	
	//assign #10 IN_INV99 =(EN_ROSC & SEL_INV99 &  ~OUT_INV99) | (EN_ROSC & ~SEL_INV99 & START & AC_DC & AC_STRESS_CLK) | (~EN_ROSC & START & AC_DC & AC_STRESS_CLK);
	//assign #11 IN_INV101 =(EN_ROSC & SEL_INV101 &  ~OUT_INV101) | (EN_ROSC & ~SEL_INV101 & START & AC_DC & AC_STRESS_CLK) | (~EN_ROSC & START & AC_DC & AC_STRESS_CLK);
	//assign #12 IN_INV97 =(EN_ROSC & SEL_INV97 &  ~OUT_INV97) | (EN_ROSC & ~SEL_INV97 & START & AC_DC & AC_STRESS_CLK) | (~EN_ROSC & START & AC_DC & AC_STRESS_CLK);

	//assign #10 OUT = EN_ROSC & ((OUT_INV99 & SEL_INV99) | (OUT_INV101 & SEL_INV101 & ~SEL_INV99) | (OUT_INV97 & SEL_INV97 & ~SEL_INV101 & ~SEL_INV99));	

endmodule

module rosc_block_top_pwr_rvt_ref_stacked(
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
       	.MOD_VDD_INV99 (MOD_VDD_INV99), 
       	.MOD_VDD_INV101 (MOD_VDD_INV101), 
       	.MOD_VDD_INV97 (MOD_VDD_INV97),
       	.OUT (OUT), 
       	.VDD (VDD),
       	.VSS (VSS)); 

	//  ring oscillator
	ROSC99_SEL_INV_RVT_REF_stacked ROSC_INV99(.IN(IN_INV99), .OUT(OUT_INV99), .VDD(MOD_VDD_INV99), .VSS(VSS));
	ROSC101_SEL_INV_RVT_REF_stacked ROSC_INV101(.IN(IN_INV101), .OUT(OUT_INV101), .VDD(MOD_VDD_INV101), .VSS(VSS));
	ROSC97_SEL_INV_RVT_REF_stacked ROSC_INV97(.IN(IN_INV97), .OUT(OUT_INV97), .VDD(MOD_VDD_INV97), .VSS(VSS));


endmodule

