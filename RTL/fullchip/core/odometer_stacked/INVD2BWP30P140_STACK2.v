`timescale 1ns/1ps

`celldefine
module INVD2BWP30P140_STACK2 (I, ZN, VDD, VSS);
    input I, VDD, VSS;
    output ZN;
    not (ZN, I);

  specify
    (I => ZN) = (0, 0);
  endspecify
endmodule
`endcelldefine
