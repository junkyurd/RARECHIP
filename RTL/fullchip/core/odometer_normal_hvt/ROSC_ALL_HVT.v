`timescale 1ns/100ps

module ROSC103_SEL_NOR_HVT_REF ( IN, OUT, VDD, VSS );
  input IN, VDD, VSS;
  output OUT;
  parameter num = 103;
  wire   [num-2:0] w;
  wire LO;
  genvar i;  

  
  TIELBWP30P140HVT TIELO(.ZN(LO));
  NR2D2BWP30P140HVT \genblk1.nr[0].NOR (.ZN(w[0]), .A1(LO), .A2(IN) ); 
  generate begin
  	for (i=1;i<=num-2; i=i+1) begin:nr 
		NR2D2BWP30P140HVT NOR ( .ZN(w[i]), .A1(LO), .A2(w[i-1]) ); 
	end
        end
  endgenerate
  assign OUT = w[num-2];
endmodule


module ROSC101_SEL_NOR_HVT_STRESS ( IN, OUT, VDD, VSS );
  input IN, VDD, VSS;
  output OUT;
  parameter num = 101;
  wire   [num-2:0] w;
  wire LO;
  genvar i;  

  
  TIELBWP30P140HVT TIELO(.ZN(LO));
  NR2D2BWP30P140HVT \genblk1.nr[0].NOR (.ZN(w[0]), .A1(LO), .A2(IN) ); 
  generate begin
  	for (i=1;i<=num-2; i=i+1) begin:nr 
		NR2D2BWP30P140HVT NOR ( .ZN(w[i]), .A1(LO), .A2(w[i-1]) ); 
	end
        end
  endgenerate
  assign OUT = w[num-2];
endmodule


module ROSC103_SEL_NAND_HVT_REF ( IN, OUT, VDD, VSS );
  input IN, VDD, VSS;
  output OUT;
  parameter num = 103;
  wire   [num-2:0] w;
  wire HI;
  genvar i;  

  
  TIEHBWP30P140HVT TIEHI(.Z(HI));
  ND2D2BWP30P140HVT \genblk1.nd[0].NAND (.ZN(w[0]), .A1(HI), .A2(IN) ); 
  generate begin
  	for (i=1;i<=num-2; i=i+1) begin:nd 
		ND2D2BWP30P140HVT NAND ( .ZN(w[i]), .A1(HI), .A2(w[i-1]) ); 
	end
        end
  endgenerate
  assign OUT = w[num-2];
endmodule

module ROSC101_SEL_NAND_HVT_STRESS ( IN, OUT, VDD, VSS );
  input IN, VDD, VSS;
  output OUT;
  parameter num = 101;
  wire   [num-2:0] w;
  wire HI;
  genvar i;  

  
  TIEHBWP30P140HVT TIEHI(.Z(HI));
  ND2D2BWP30P140HVT \genblk1.nd[0].NAND (.ZN(w[0]), .A1(HI), .A2(IN) ); 
  generate begin
  	for (i=1;i<=num-2; i=i+1) begin:nd 
		ND2D2BWP30P140HVT NAND ( .ZN(w[i]), .A1(HI), .A2(w[i-1]) ); 
	end
        end
  endgenerate
  assign OUT = w[num-2];
endmodule


module ROSC103_SEL_INV_HVT_REF ( IN, OUT, VDD, VSS );
  input IN, VDD, VSS;
  output OUT;
  parameter num = 103;
  wire   [num-2:0] w;
  genvar i;  

  
  INVD2BWP30P140HVT \genblk1.inv[0].INV (.ZN(w[0]), .I(IN) ); 
  generate begin
  	for (i=1;i<=num-2; i=i+1) begin:inv 
		INVD2BWP30P140HVT INV ( .ZN(w[i]), .I(w[i-1]) ); 
	end
        end
  endgenerate
  assign OUT = w[num-2];
endmodule


module ROSC101_SEL_INV_HVT_STRESS ( IN, OUT, VDD, VSS );
  input IN, VDD, VSS;
  output OUT;
  parameter num = 101;
  wire   [num-2:0] w;
  genvar i;  

  
  INVD2BWP30P140HVT \genblk1.inv[0].INV (.ZN(w[0]), .I(IN) ); 
  generate begin
  	for (i=1;i<=num-2; i=i+1) begin:inv 
		INVD2BWP30P140HVT INV ( .ZN(w[i]), .I(w[i-1]) ); 
	end
        end
  endgenerate
  assign OUT = w[num-2];
endmodule
  
