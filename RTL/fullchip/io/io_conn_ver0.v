`timescale 1ns / 10ps

module io_conn(
    // input from Pad Port
    input ACLK_IO,
    input ARESETB_IO,
    input AWRITEB_IO,
    input [5:0] AADDR_IO,
    input AVALID_IO,

    input [7:0] WDATA_IO,
    input WVALID_IO,

    input RREADY_IO,
    
    input HEATER_PWM_A_IO,
    input HEATER_PWB_B_IO,
    
    // output to Pad Port
    output wire AREADY_IO,
    output wire WREADY_IO,
    output wire [7:0] RDATA_IO,
    output wire RVALID_IO,

    output wire DEBUG_OUT_IO,
    output wire DCO_FREQ_OUT_IO,
    
    // input from RARE_TOP
    input AREADY,
    input WREADY,
    input [7:0] RDATA,
    input RVALID,

    input DEBUG_OUT,
    input DCO_FREQ_OUT,

    // output to RARE_TOP
    output wire ACLK,
    output wire ARESETB,
    output wire AWRITEB,
    output wire [5:0] AADDR,
    output wire AVALID,

    output wire [7:0] WDATA,
    output wire WVALID,

    output wire RREADY,

    output wire HEATER_PWM_A,
    output wire HEATER_PWM_B,

    // inout bare pad
    inout TEMP_SOURCE_HI_IO,
    inout TEMP_SOURCE_LO_IO,
    inout TEMP_SENSE_HI_IO,
    inout TEMP_SENSE_LO_IO,
    inout TEMP_SOURCE_HI,
    input TEMP_SOURCE_LO,
    inout TEMP_SENSE_HI,
    inout TEMP_SENSE_LO,

    // power
    input wire VDD0P9_TOP,
    input wire VDD0P9_CORE1,
    input wire VDD0P9_CORE2,
    input wire VSS0P9,
    input wire VDD1P8,
    input wire VSS1P8V   
);

wire UNCONNECTED;

// --------------------------------------------------------------------
// 00000  000  0000
//   0   0   0 0   0
//   0   0   0 0000
//   0   0   0 0
//   0    000  0
// --------------------------------------------------------------------

PRDW12SDGZ_H_G AADDR_5_IN(
    .C(AADDR[5]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(AADDR_IO[5]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_H_G AADDR_4_IN(
    .C(AADDR[4]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(AADDR_IO[4]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_H_G AADDR_3_IN(
    .C(AADDR[3]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(AADDR_IO[3]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_H_G AADDR_2_IN(
    .C(AADDR[2]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(AADDR_IO[2]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_H_G AADDR_1_IN(
    .C(AADDR[1]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(AADDR_IO[1]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_H_G AADDR_0_IN(
    .C(AADDR[0]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(AADDR_IO[0]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_H_G AWRITEB_IN(
    .C(AWRITEB),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(AWRITEB_IO),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_H_G AVALID_IN(
    .C(AVALID),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(AVALID_IO),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);


// --------------------------------------------------------------------
// 0     00000 00000 00000
// 0     0     0       0
// 0     00000 00000   0
// 0     0     0       0
// 00000 00000 0       0
// --------------------------------------------------------------------
// Top to bottom
PRDW12SDGZ_V_G WDATA_0_IN(
    .C(WDATA[0]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(WDATA_IO[0]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_V_G WDATA_1_IN(
    .C(WDATA[1]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(WDATA_IO[1]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_V_G WDATA_2_IN(
    .C(WDATA[2]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(WDATA_IO[2]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_V_G WDATA_3_IN(
    .C(WDATA[3]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(WDATA_IO[3]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_V_G WVALID_IN(
    .C(WVALID),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(WVALID_IO),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_V_G WREADY_OUT(
    .C(UNCONNECTED),
    .OEN(),
    .REN(),
    .POC(),
    .I(WREADY),
    .PAD(WREADY_IO),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_V_G WDATA_7_IN(
    .C(WDATA[7]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(WDATA_IO[7]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_V_G WDATA_6_IN(
    .C(WDATA[6]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(WDATA_IO[6]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_V_G WDATA_5_IN(
    .C(WDATA[5]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(WDATA_IO[5]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);

PRDW12SDGZ_V_G WDATA_4_IN(
    .C(WDATA[4]),
    .OEN(),
    .REN(),
    .POC(),
    .I(),
    .PAD(WDATA_IO[4]),
    .VDD(VDD0P9_TOP),
    .VSS(VSS0P9),
    .VDDPST(VDD1P8),
    .VSSPST(VSS1P8)
);








endmodule