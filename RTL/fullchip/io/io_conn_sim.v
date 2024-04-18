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
    input HEATER_PWM_B_IO,
    
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
    input wire VSS1P8   
);

wire UNCONNECTED;
wire UNCONNECTED1;
wire UNCONNECTED2;
wire UNCONNECTED3;
wire UNCONNECTED4;
wire UNCONNECTED5;
wire UNCONNECTED6;
wire [7:0] tiehi_WDATA, tielo_WDATA;
wire tiehi_RREADY,tielo_RREADY;
wire tiehi_AVALID,tielo_AVALID;
wire tiehi_AWRITEB,tielo_AWRITEB;
wire [5:0] tiehi_AADDR, tielo_AADDR;
wire tiehi_ARESETB,tielo_ARESETB;
wire tiehi_ACLK,tielo_ACLK;
wire tiehi_HEATER_PWM_B,tielo_HEATER_PWM_B;
wire tiehi_HEATER_PWM_A,tielo_HEATER_PWM_A;
wire tiehi_WVALID,tielo_WVALID;
wire tiehi_WREADY,tielo_WREADY;
wire tiehi_DEBUG_OUT,tielo_DEBUG_OUT;
wire tiehi_RVALID,tielo_RVALID;
wire tiehi_DCO_FREQ_OUT,tielo_DCO_FREQ_OUT;
wire [7:0] tiehi_RDATA, tielo_RDATA;
wire tiehi_AREADY,tielo_AREADY;
wire TEMP_SENSE_HI;
wire TEMP_SENSE_LO;


// --------------------------------------------------------------------
// 00000  000  0000
//   0   0   0 0   0
//   0   0   0 0000
//   0   0   0 0
//   0    000  0
// --------------------------------------------------------------------

TIEHBWP30P140 AADDR5hi (.Z(tiehi_AADDR[5]));
TIELBWP30P140 AADDR5lo (.ZN(tielo_AADDR[5]));
PRDW12SDGZ_V_G AADDR5_INST (.C(AADDR[5]),
.OEN(tiehi_AADDR[5]),
.REN(tielo_AADDR[5]),
.I(tielo_AADDR[5]),
.PAD(AADDR_IO[5]));

TIEHBWP30P140 AADDR4hi (.Z(tiehi_AADDR[4]));
TIELBWP30P140 AADDR4lo (.ZN(tielo_AADDR[4]));
PRDW12SDGZ_V_G AADDR4_INST (.C(AADDR[4]),
.OEN(tiehi_AADDR[4]),
.REN(tielo_AADDR[4]),
.I(tielo_AADDR[4]),
.PAD(AADDR_IO[4]));

TIEHBWP30P140 AADDR3hi (.Z(tiehi_AADDR[3]));
TIELBWP30P140 AADDR3lo (.ZN(tielo_AADDR[3]));
PRDW12SDGZ_V_G AADDR3_INST (.C(AADDR[3]),
.OEN(tiehi_AADDR[3]),
.REN(tielo_AADDR[3]),
.I(tielo_AADDR[3]),
.PAD(AADDR_IO[3]));

TIEHBWP30P140 AREADYhi (.Z(tiehi_AREADY));
TIELBWP30P140 AREADYlo (.ZN(tielo_AREADY));
PRDW12SDGZ_V_G AREADY_INST (.C(),
.OEN(tielo_AREADY),
.REN(tielo_AREADY),
.I(AREADY),
.PAD(AREADY_IO));

TIEHBWP30P140 AVALIDhi (.Z(tiehi_AVALID));
TIELBWP30P140 AVALIDlo (.ZN(tielo_AVALID));
PRDW12SDGZ_V_G AVALID_INST (.C(AVALID),
.OEN(tiehi_AVALID),
.REN(tielo_AVALID),
.I(tielo_AVALID),
.PAD(AVALID_IO));

TIEHBWP30P140 ACLKhi (.Z(tiehi_ACLK));
TIELBWP30P140 ACLKlo (.ZN(tielo_ACLK));
PRDW12SDGZ_V_G ACLK_INST (.C(ACLK),
.OEN(tiehi_ACLK),
.REN(tielo_ACLK),
.I(tielo_ACLK),
.PAD(ACLK_IO));

PVDD1DGZ_V_G VDD0P9_TOP_2_INST (
.VDD(VDD0P9_TOP));

PVSS1DGZ_V_G VSS0P9_4_INST (.VSS(VSS0P9));

TIEHBWP30P140 AADDR2hi (.Z(tiehi_AADDR[2]));
TIELBWP30P140 AADDR2lo (.ZN(tielo_AADDR[2]));
PRDW12SDGZ_V_G AADDR2_INST (.C(AADDR[2]),
.OEN(tiehi_AADDR[2]),
.REN(tielo_AADDR[2]),
.I(tielo_AADDR[2]),
.PAD(AADDR_IO[2]));

TIEHBWP30P140 AADDR1hi (.Z(tiehi_AADDR[1]));
TIELBWP30P140 AADDR1lo (.ZN(tielo_AADDR[1]));
PRDW12SDGZ_V_G AADDR1_INST (.C(AADDR[1]),
.OEN(tiehi_AADDR[1]),
.REN(tielo_AADDR[1]),
.I(tielo_AADDR[1]),
.PAD(AADDR_IO[1]));

TIEHBWP30P140 AADDR0hi (.Z(tiehi_AADDR[0]));
TIELBWP30P140 AADDR0lo (.ZN(tielo_AADDR[0]));
PRDW12SDGZ_V_G AADDR0_INST (.C(AADDR[0]),
.OEN(tiehi_AADDR[0]),
.REN(tielo_AADDR[0]),
.I(tielo_AADDR[0]),
.PAD(AADDR_IO[0]));

PVDD1ANA_V_G VDD0P9_CORE1_3_INST (.AVDD(VDD0P9_CORE1));


PRDW12SDGZ_V_G TEMP_SENSE_HI_INST (.C(UNCONNECTED1),
.OEN(UNCONNECTED2),
.REN(UNCONNECTED3),
.I(TEMP_SENSE_HI),
.PAD(TEMP_SENSE_HI_IO));


TIEHBWP30P140 AWRITEBhi (.Z(tiehi_AWRITEB));
TIELBWP30P140 AWRITEBlo (.ZN(tielo_AWRITEB));
PRDW12SDGZ_V_G AWRITEB_INST (.C(AWRITEB),
.OEN(tiehi_AWRITEB),
.REN(tielo_AWRITEB),
.I(tielo_AWRITEB),
.PAD(AWRITEB_IO));



// --------------------------------------------------------------------
// 0     00000 00000 00000
// 0     0     0       0
// 0     00000 00000   0
// 0     0     0       0
// 00000 00000 0       0
// --------------------------------------------------------------------
// Top to bottom

TIEHBWP30P140 WDATA0hi (.Z(tiehi_WDATA[0]));
TIELBWP30P140 WDATA0lo (.ZN(tielo_WDATA[0]));
PRDW12SDGZ_H_G WDATA0_INST (.C(WDATA[0]),
.OEN(tiehi_WDATA[0]),
.REN(tielo_WDATA[0]),
.I(tielo_WDATA[0]),
.PAD(WDATA_IO[0]));

TIEHBWP30P140 WDATA1hi (.Z(tiehi_WDATA[1]));
TIELBWP30P140 WDATA1lo (.ZN(tielo_WDATA[1]));
PRDW12SDGZ_H_G WDATA1_INST (.C(WDATA[1]),
.OEN(tiehi_WDATA[1]),
.REN(tielo_WDATA[1]),
.I(tielo_WDATA[1]),
.PAD(WDATA_IO[1]));

TIEHBWP30P140 WDATA2hi (.Z(tiehi_WDATA[2]));
TIELBWP30P140 WDATA2lo (.ZN(tielo_WDATA[2]));
PRDW12SDGZ_H_G WDATA2_INST (.C(WDATA[2]),
.OEN(tiehi_WDATA[2]),
.REN(tielo_WDATA[2]),
.I(tielo_WDATA[2]),
.PAD(WDATA_IO[2]));

TIEHBWP30P140 WDATA3hi (.Z(tiehi_WDATA[3]));
TIELBWP30P140 WDATA3lo (.ZN(tielo_WDATA[3]));
PRDW12SDGZ_H_G WDATA3_INST (.C(WDATA[3]),
.OEN(tiehi_WDATA[3]),
.REN(tielo_WDATA[3]),
.I(tielo_WDATA[3]),
.PAD(WDATA_IO[3]));


TIEHBWP30P140 WVALIDhi (.Z(tiehi_WVALID));
TIELBWP30P140 WVALIDlo (.ZN(tielo_WVALID));
PRDW12SDGZ_H_G WVALID_INST (.C(WVALID),
.OEN(tiehi_WVALID),
.REN(tielo_WVALID),
.I(tielo_WVALID),
.PAD(WVALID_IO));


TIEHBWP30P140 WREADYhi (.Z(tiehi_WREADY));
TIELBWP30P140 WREADYlo (.ZN(tielo_WREADY));
PRDW12SDGZ_H_G WREADY_INST (.C(),
.OEN(tielo_WREADY),
.REN(tielo_WREADY),
.I(WREADY),
.PAD(WREADY_IO));

PVSS2DGZ_H_G VSS1P8_2_INST (
.VSSPST(VSS1P8));

PVSS1DGZ_H_G VSS0P9_5_INST (.VSS(VSS0P9));

PVDD2DGZ_H_G VDD1P8_2_INST (
.VDDPST(VDD1P8));

TIEHBWP30P140 WDATA4hi (.Z(tiehi_WDATA[4]));
TIELBWP30P140 WDATA4lo (.ZN(tielo_WDATA[4]));
PRDW12SDGZ_H_G WDATA4_INST (.C(WDATA[4]),
.OEN(tiehi_WDATA[4]),
.REN(tielo_WDATA[4]),
.I(tielo_WDATA[4]),
.PAD(WDATA_IO[4]));

TIEHBWP30P140 WDATA5hi (.Z(tiehi_WDATA[5]));
TIELBWP30P140 WDATA5lo (.ZN(tielo_WDATA[5]));
PRDW12SDGZ_H_G WDATA5_INST (.C(WDATA[5]),
.OEN(tiehi_WDATA[5]),
.REN(tielo_WDATA[5]),
.I(tielo_WDATA[5]),
.PAD(WDATA_IO[5]));

TIEHBWP30P140 WDATA6hi (.Z(tiehi_WDATA[6]));
TIELBWP30P140 WDATA6lo (.ZN(tielo_WDATA[6]));
PRDW12SDGZ_H_G WDATA6_INST (.C(WDATA[6]),
.OEN(tiehi_WDATA[6]),
.REN(tielo_WDATA[6]),
.I(tielo_WDATA[6]),
.PAD(WDATA_IO[6]));

TIEHBWP30P140 WDATA7hi (.Z(tiehi_WDATA[7]));
TIELBWP30P140 WDATA7lo (.ZN(tielo_WDATA[7]));
PRDW12SDGZ_H_G WDATA7_INST (.C(WDATA[7]),
.OEN(tiehi_WDATA[7]),
.REN(tielo_WDATA[7]),
.I(tielo_WDATA[7]),
.PAD(WDATA_IO[7]));

TIEHBWP30P140 RDATA0hi (.Z(tiehi_RDATA[0]));
TIELBWP30P140 RDATA0lo (.ZN(tielo_RDATA[0]));
PRDW12SDGZ_H_G RDATA0_INST (.C(),
.OEN(tielo_RDATA[0]),
.REN(tielo_RDATA[0]),.I(RDATA[0]),
.PAD(RDATA_IO[0]));




//BOTTOM
//


TIEHBWP30P140 RDATA1hi (.Z(tiehi_RDATA[1]));
TIELBWP30P140 RDATA1lo (.ZN(tielo_RDATA[1]));
PRDW12SDGZ_V_G RDATA1_INST (.C(),
.OEN(tielo_RDATA[1]),
.REN(tielo_RDATA[1]),.I(RDATA[1]),
.PAD(RDATA_IO[1]));

TIEHBWP30P140 RDATA2hi (.Z(tiehi_RDATA[2]));
TIELBWP30P140 RDATA2lo (.ZN(tielo_RDATA[2]));
PRDW12SDGZ_V_G RDATA2_INST (.C(),
.OEN(tielo_RDATA[2]),
.REN(tielo_RDATA[2]),.I(RDATA[2]),
.PAD(RDATA_IO[2]));

TIEHBWP30P140 RDATA3hi (.Z(tiehi_RDATA[3]));
TIELBWP30P140 RDATA3lo (.ZN(tielo_RDATA[3]));
PRDW12SDGZ_V_G RDATA3_INST (.C(),
.OEN(tielo_RDATA[3]),
.REN(tielo_RDATA[3]),.I(RDATA[3]),
.PAD(RDATA_IO[3]));

TIEHBWP30P140 RDATA4hi (.Z(tiehi_RDATA[4]));
TIELBWP30P140 RDATA4lo (.ZN(tielo_RDATA[4]));
PRDW12SDGZ_V_G RDATA4_INST (.C(),
.OEN(tielo_RDATA[4]),
.REN(tielo_RDATA[4]),.I(RDATA[4]),
.PAD(RDATA_IO[4]));

TIEHBWP30P140 RDATA5hi (.Z(tiehi_RDATA[5]));
TIELBWP30P140 RDATA5lo (.ZN(tielo_RDATA[5]));
PRDW12SDGZ_V_G RDATA5_INST (.C(),
.OEN(tielo_RDATA[5]),
.REN(tielo_RDATA[5]),.I(RDATA[5]),
.PAD(RDATA_IO[5]));



TIEHBWP30P140 RVALIDhi (.Z(tiehi_RVALID));
TIELBWP30P140 RVALIDlo (.ZN(tielo_RVALID));
PRDW12SDGZ_V_G RVALID_INST (.C(),
.OEN(tielo_RVALID),
.REN(tielo_RVALID),
.I(RVALID),
.PAD(RVALID_IO));

PVDD1DGZ_V_G VDD0P9_TOP_1_INST (.VDD(VDD0P9_TOP));

PVSS1DGZ_V_G VSS0P9_1_INST (.VSS(VSS0P9));


TIEHBWP30P140 RDATA6hi (.Z(tiehi_RDATA[6]));
TIELBWP30P140 RDATA6lo (.ZN(tielo_RDATA[6]));
PRDW12SDGZ_V_G RDATA6_INST (.C(),
.OEN(tielo_RDATA[6]),
.REN(tielo_RDATA[6]),.I(RDATA[6]),
.PAD(RDATA_IO[6]));

TIEHBWP30P140 RDATA7hi (.Z(tiehi_RDATA[7]));
TIELBWP30P140 RDATA7lo (.ZN(tielo_RDATA[7]));
PRDW12SDGZ_V_G RDATA7_INST (.C(),
.OEN(tielo_RDATA[7]),
.REN(tielo_RDATA[7]),.I(RDATA[7]),
.PAD(RDATA_IO[7]));

TIEHBWP30P140 RREADYhi (.Z(tiehi_RREADY));
TIELBWP30P140 RREADYlo (.ZN(tielo_RREADY));
PRDW12SDGZ_V_G RREADY_INST (.C(RREADY),
.OEN(tiehi_RREADY),
.REN(tielo_RREADY),
.I(tielo_RREADY),
.PAD(RREADY_IO));

PVDD1ANA_V_G VDD0P9_CORE2_1_INST (.AVDD(VDD0P9_CORE2));

PRDW12SDGZ_V_G TEMP_SENSE_LO_INST (.C(UNCONNECTED4),
.OEN(UNCONNECTED5),
.REN(UNCONNECTED6),
.I(TEMP_SENSE_LO),
.PAD(TEMP_SENSE_LO_IO));

TIEHBWP30P140 ARESETBhi (.Z(tiehi_ARESETB));
TIELBWP30P140 ARESETBlo (.ZN(tielo_ARESETB));
PRDW12SDGZ_V_G ARESETB_INST (.C(ARESETB),
.OEN(tiehi_ARESETB),
.REN(tielo_ARESETB),
.I(tielo_ARESETB),
.PAD(ARESETB_IO));


//RIGHT

PVSS1DGZ_H_G VSS0P9_3_INST (.VSS(VSS0P9));

PVDD1ANA_H_G VDD0P9_CORE1_2_INST (.AVDD(VDD0P9_CORE1));

TIEHBWP30P140 HEATER_PWM_Ahi (.Z(tiehi_HEATER_PWM_A));
TIELBWP30P140 HEATER_PWM_Alo (.ZN(tielo_HEATER_PWM_A));
PRDW12SDGZ_H_G HEATER_PWM_A_INST (.C(HEATER_PWM_A),
.OEN(tiehi_HEATER_PWM_A),
.REN(tielo_HEATER_PWM_A),
.I(tielo_HEATER_PWM_A),
.PAD(HEATER_PWM_A_IO));

PVSS2DGZ_H_G VSS1P8_1_INST (
.VSSPST(VSS1P8));

PVDD1ANA_H_G VDD0P9_CORE1_1_INST (.AVDD(VDD0P9_CORE1));

TIEHBWP30P140 DEBUG_OUThi (.Z(tiehi_DEBUG_OUT));
TIELBWP30P140 DEBUG_OUTlo (.ZN(tielo_DEBUG_OUT));
PRDW12SDGZ_H_G DEBUG_OUT_INST (.C(),
.OEN(tielo_DEBUG_OUT),
.REN(tielo_DEBUG_OUT),
.I(DEBUG_OUT),
.PAD(DEBUG_OUT_IO));

TIEHBWP30P140 DCO_FREQ_OUThi (.Z(tiehi_DCO_FREQ_OUT));
TIELBWP30P140 DCO_FREQ_OUTlo (.ZN(tielo_DCO_FREQ_OUT));
PRDW12SDGZ_H_G DCO_FREQ_OUT_INST (.C(),
.OEN(tielo_DCO_FREQ_OUT),
.REN(tielo_DCO_FREQ_OUT),
.I(DCO_FREQ_OUT),
.PAD(DCO_FREQ_OUT_IO));

PVDD1ANA_H_G VDD0P9_CORE2_3_INST (.AVDD(VDD0P9_CORE2));

PVDD2DGZ_H_G VDD1P8_1_INST (
.VDDPST(VDD1P8));

TIEHBWP30P140 HEATER_PWM_Bhi (.Z(tiehi_HEATER_PWM_B));
TIELBWP30P140 HEATER_PWM_Blo (.ZN(tielo_HEATER_PWM_B));
PRDW12SDGZ_H_G HEATER_PWM_B_INST (.C(HEATER_PWM_B),
.OEN(tiehi_HEATER_PWM_B),
.REN(tielo_HEATER_PWM_B),
.I(tielo_HEATER_PWM_B),
.PAD(HEATER_PWM_B_IO));

PVDD1ANA_H_G VDD0P9_CORE2_2_INST (.AVDD(VDD0P9_CORE2));

PVSS1DGZ_H_G VSS0P9_2_INST (.VSS(VSS0P9));

//POC cell
PVDD2POC_H_G POC_TOP (
.VDDPST(VDD1P8));

PVDD2POC_H_G POC_CORE1 (
.VDDPST(VDD1P8));

PVDD2POC_H_G POC_CORE2 (
.VDDPST(VDD1P8));

//Power cells as Fillers
//PVDD2DGZ_H_G VDD_iofilll0  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_H_G VDD_iofilll1  (.VDDPST(VDD1P8));
//PVDD2DGZ_H_G VDD_iofilll2  (.VDDPST(VDD1P8));
//PVDD2DGZ_H_G VDD_iofilll3  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_H_G VDD_iofilll4  (.VDDPST(VDD1P8));
//PVDD2DGZ_H_G VDD_iofilll5  (.VDDPST(VDD1P8)); 
PVDD2DGZ_H_G VDD_iofilll6  (.VDDPST(VDD1P8));
PVDD2DGZ_H_G VDD_iofilll7  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_H_G VDD_iofilll8  (.VDDPST(VDD1P8));
//PVDD2DGZ_H_G VDD_iofilll9  (.VDDPST(VDD1P8));
//PVDD2DGZ_H_G VDD_iofilll10  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_H_G VDD_iofilll11  (.VDDPST(VDD1P8));
//PVDD2DGZ_H_G VDD_iofilll12  (.VDDPST(VDD1P8));

//PVDD2DGZ_V_G VDD_iofillt0  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_V_G VDD_iofillt1  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillt2  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillt3  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_V_G VDD_iofillt4  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillt5  (.VDDPST(VDD1P8)); 
PVDD2DGZ_V_G VDD_iofillt6  (.VDDPST(VDD1P8));
PVDD2DGZ_V_G VDD_iofillt7  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_V_G VDD_iofillt8  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillt9  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillt10  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_V_G VDD_iofillt11  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillt12  (.VDDPST(VDD1P8));

//PVDD2DGZ_H_G VDD_iofillr0  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_H_G VDD_iofillr1  (.VDDPST(VDD1P8));
//PVDD2DGZ_H_G VDD_iofillr2  (.VDDPST(VDD1P8));
//PVDD2DGZ_H_G VDD_iofillr3  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_H_G VDD_iofillr4  (.VDDPST(VDD1P8));
PVDD2DGZ_H_G VDD_iofillr5  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_H_G VDD_iofillr6  (.VDDPST(VDD1P8));
PVDD2DGZ_H_G VDD_iofillr7  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_H_G VDD_iofillr8  (.VDDPST(VDD1P8));
//PVDD2DGZ_H_G VDD_iofillr9  (.VDDPST(VDD1P8));
//PVDD2DGZ_H_G VDD_iofillr10  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_H_G VDD_iofillr11  (.VDDPST(VDD1P8));
//PVDD2DGZ_H_G VDD_iofillr12  (.VDDPST(VDD1P8));

//PVDD2DGZ_V_G VDD_iofillb0  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_V_G VDD_iofillb1  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillb2  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillb3  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_V_G VDD_iofillb4  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillb5  (.VDDPST(VDD1P8)); 
PVDD2DGZ_V_G VDD_iofillb6  (.VDDPST(VDD1P8));
PVDD2DGZ_V_G VDD_iofillb7  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_V_G VDD_iofillb8  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillb9  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillb10  (.VDDPST(VDD1P8)); 
//PVDD2DGZ_V_G VDD_iofillb11  (.VDDPST(VDD1P8));
//PVDD2DGZ_V_G VDD_iofillb12  (.VDDPST(VDD1P8));

//PVSS1DGZ_H_G VSS_corefilll1 (.VSS(VSS0P9)); 
//PVSS1DGZ_H_G VSS_corefilll2 (.VSS(VSS0P9)); 
//PVSS1DGZ_H_G VSS_corefilll3 (.VSS(VSS0P9));
//PVSS1DGZ_H_G VSS_corefilll4 (.VSS(VSS0P9)); 
//PVSS1DGZ_H_G VSS_corefilll5 (.VSS(VSS0P9)); 
PVSS1DGZ_H_G VSS_corefilll6 (.VSS(VSS0P9));
PVSS1DGZ_H_G VSS_corefilll7 (.VSS(VSS0P9)); 
//PVSS1DGZ_H_G VSS_corefilll8 (.VSS(VSS0P9)); 
//PVSS1DGZ_H_G VSS_corefilll9 (.VSS(VSS0P9));
//PVSS1DGZ_H_G VSS_corefilll10 (.VSS(VSS0P9)); 
//PVSS1DGZ_H_G VSS_corefilll11 (.VSS(VSS0P9)); 
//PVSS1DGZ_H_G VSS_corefilll12 (.VSS(VSS0P9)); 

//PVSS1DGZ_V_G VSS_corefillt0 (.VSS(VSS0P9)); 
//PVSS1DGZ_V_G VSS_corefillt1 (.VSS(VSS0P9)); 
//PVSS1DGZ_V_G VSS_corefillt2 (.VSS(VSS0P9)); 
//PVSS1DGZ_V_G VSS_corefillt3 (.VSS(VSS0P9));
//PVSS1DGZ_V_G VSS_corefillt4 (.VSS(VSS0P9)); 
//PVSS1DGZ_V_G VSS_corefillt5 (.VSS(VSS0P9)); 
PVSS1DGZ_V_G VSS_corefillt6 (.VSS(VSS0P9));
PVSS1DGZ_V_G VSS_corefillt7 (.VSS(VSS0P9)); 
//PVSS1DGZ_V_G VSS_corefillt8 (.VSS(VSS0P9)); 
//PVSS1DGZ_V_G VSS_corefillt9 (.VSS(VSS0P9));
//PVSS1DGZ_V_G VSS_corefillt10 (.VSS(VSS0P9)); 
//PVSS1DGZ_V_G VSS_corefillt11 (.VSS(VSS0P9)); 
//PVSS1DGZ_V_G VSS_corefillt12 (.VSS(VSS0P9)); 

//PVDD1DGZ_V_G VDD_corefillb0 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_V_G VDD_corefillb1 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_V_G VDD_corefillb2 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_V_G VDD_corefillb3 (.VDD(VDD0P9_TOP));
//PVDD1DGZ_V_G VDD_corefillb4 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_V_G VDD_corefillb5 (.VDD(VDD0P9_TOP)); 
PVDD1DGZ_V_G VDD_corefillb6 (.VDD(VDD0P9_TOP));
PVDD1DGZ_V_G VDD_corefillb7 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_V_G VDD_corefillb8 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_V_G VDD_corefillb9 (.VDD(VDD0P9_TOP));
//PVDD1DGZ_V_G VDD_corefillb10 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_V_G VDD_corefillb11 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_V_G VDD_corefillb12 (.VDD(VDD0P9_TOP)); 

//PVDD1DGZ_H_G VDD_corefillr0 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_H_G VDD_corefillr1 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_H_G VDD_corefillr3 (.VDD(VDD0P9_TOP));
//PVDD1DGZ_H_G VDD_corefillr4 (.VDD(VDD0P9_TOP)); 
PVDD1DGZ_H_G VDD_corefillr5 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_H_G VDD_corefillr6 (.VDD(VDD0P9_TOP));
PVDD1DGZ_H_G VDD_corefillr7 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_H_G VDD_corefillr8 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_H_G VDD_corefillr10 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_H_G VDD_corefillr11 (.VDD(VDD0P9_TOP)); 
//PVDD1DGZ_H_G VDD_corefillr12 (.VDD(VDD0P9_TOP)); 




endmodule
