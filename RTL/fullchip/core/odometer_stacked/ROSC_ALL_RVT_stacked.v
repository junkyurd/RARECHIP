`timescale 1ns/100ps

module ROSC99_SEL_INV_RVT_REF_stacked ( IN, OUT, VDD, VSS );
  input IN, VDD, VSS;
  output OUT;
  parameter num = 99;
  wire   [num-2:0] w;
  genvar i;  

  
  INVD2BWP30P140 \genblk1.inv[0].INV (.ZN(w[0]), .I(IN) ); 
  generate begin
  	for (i=1;i<=num-2; i=i+1) begin:inv 
		INVD2BWP30P140 INV ( .ZN(w[i]), .I(w[i-1]) ); 
	end
        end
  endgenerate
  assign OUT = w[num-2];
endmodule


module ROSC101_SEL_INV_RVT_REF_stacked ( IN, OUT, VDD, VSS );
  input IN, VDD, VSS;
  output OUT;
  parameter num = 101;
  wire   [num-2:0] w;
  genvar i;  

  
  INVD2BWP30P140 \genblk1.inv[0].INV (.ZN(w[0]), .I(IN) ); 
  generate begin
  	for (i=1;i<=num-2; i=i+1) begin:inv 
		INVD2BWP30P140 INV ( .ZN(w[i]), .I(w[i-1]) ); 
	end
        end
  endgenerate
  assign OUT = w[num-2];
endmodule

module ROSC97_SEL_INV_RVT_REF_stacked ( IN, OUT, VDD, VSS );
  input IN, VDD, VSS;
  output OUT;
  parameter num = 97;
  wire   [num-2:0] w;
  genvar i;  

  
  INVD2BWP30P140 \genblk1.inv[0].INV (.ZN(w[0]), .I(IN) ); 
  generate begin
  	for (i=1;i<=num-2; i=i+1) begin:inv 
		INVD2BWP30P140 INV ( .ZN(w[i]), .I(w[i-1]) ); 
	end
        end
  endgenerate
  assign OUT = w[num-2];
endmodule


module ROSC35_SEL_INV_RVT_STRESS_stacked ( IN, OUT, VDD, VSS );
  input IN, VDD, VSS;
  output OUT;
  parameter num = 35;
  wire   [num-2:0] w;
  genvar i;  

  
  INVD2BWP30P140_STACK2 \genblk1.inv[0].INV (.ZN(w[0]), .I(IN) ); 
  generate begin
  	for (i=1;i<=num-2; i=i+1) begin:inv 
		INVD2BWP30P140_STACK2 INV ( .ZN(w[i]), .I(w[i-1]) ); 
	end
        end
  endgenerate
  assign OUT = w[num-2];
endmodule
  


