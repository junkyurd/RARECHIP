
module power_enable(
	START,
	MEAS_STRESS,
	MEAS_DONE,
	EN_POWER_ROSC_STRESS,
	EN_ROSC,
	VDD,VSS);

	input START; 
	input MEAS_STRESS; 
	input MEAS_DONE;
	input VDD, VSS;
	
	output EN_POWER_ROSC_STRESS; 
	output EN_ROSC;

	wire EN_ROSC; 
	wire EN_POWER_ROSC_STRESS;
	
	assign EN_POWER_ROSC_STRESS = START | MEAS_STRESS;    // enable power for the stress ROSC
	assign EN_ROSC = ~(~(MEAS_STRESS) | MEAS_DONE);       // enable ROSC


endmodule

