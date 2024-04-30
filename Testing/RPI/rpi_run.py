from gpiozero import *
import time

################################################################################################################################
#  000  00000 00000 0   0 000
# 0     0       0   0   0 0  0
#  000  00000   0   0   0 000
#     0 0       0   0   0 0
#  000  00000   0    000  0
################################################################################################################################
# Constants
clk_half_period     = 0.001
# GPIO pin number
# Output pins
aclk_pin            = 14
aresetb_pin         = 4
awriteb_pin         = 22
aaddr_0_pin         = 10
aaddr_1_pin         = 9
aaddr_2_pin         = 11
aaddr_3_pin         = 18
aaddr_4_pin         = 23
aaddr_5_pin         = 13
avalid_pin          = 15
wvalid_pin          = 16
rready_pin          = 3
rsel_pin            = 2
# Input pins
aready_pin          = 25
wready_pin          = 8
rvalid_pin          = 24
# data_# pins are used as both inputs and outputs based on read mode or write mode
# for start-up set it as write mode (output)
data_0_pin          = 7
data_1_pin          = 5
data_2_pin          = 12
data_3_pin          = 6
data_4_pin          = 19
data_5_pin          = 20
data_6_pin          = 26
data_7_pin          = 21

# Digital outputs
# Intial value is 0 (default)
aclk                = DigitalOutputDevice(aclk_pin)
aresetb             = DigitalOutputDevice(aresetb_pin)
awriteb             = DigitalOutputDevice(awriteb_pin)
aaddr_0             = DigitalOutputDevice(aaddr_0_pin)
aaddr_1             = DigitalOutputDevice(aaddr_1_pin)
aaddr_2             = DigitalOutputDevice(aaddr_2_pin)
aaddr_3             = DigitalOutputDevice(aaddr_3_pin)
aaddr_4             = DigitalOutputDevice(aaddr_4_pin)
aaddr_5             = DigitalOutputDevice(aaddr_5_pin)
avalid              = DigitalOutputDevice(avalid_pin)
wvalid              = DigitalOutputDevice(wvalid_pin)
rready              = DigitalOutputDevice(rready_pin)
rsel                = DigitalOutputDevice(rsel_pin)
data_0              = DigitalOutputDevice(data_0_pin)
data_1              = DigitalOutputDevice(data_1_pin)
data_2              = DigitalOutputDevice(data_2_pin)
data_3              = DigitalOutputDevice(data_3_pin)
data_4              = DigitalOutputDevice(data_4_pin)
data_5              = DigitalOutputDevice(data_5_pin)
data_6              = DigitalOutputDevice(data_6_pin)
data_7              = DigitalOutputDevice(data_7_pin)
# Digital inputs
aready              = DigitalInputDevice(aready_pin)
wready              = DigitalInputDevice(wready_pin)
rvalid              = DigitalInputDevice(rvalid_pin)

################################################################################################################################
#   0   0   0 00000       0000  00000  000
#  0 0   0 0    0         0   0 0     0
# 00000   0     0         0000  00000 0  00
# 0   0  0 0    0         0   0 0     0   0
# 0   0 0   0 00000       0   0 00000  000
################################################################################################################################
ADDR_INSTR_ADDR                 = 0x00
ADDR_INSTR_DATA_IN              = 0x01
ADDR_INSTR_DATA_OUT             = 0x02 # READ ONLY
ADDR_DATA_ADDR                  = 0x03
ADDR_DATA_DATA_IN               = 0x04
ADDR_DATA_DATA_OUT              = 0x05 # READ ONLY
ADDR_CACHE_CONTROL              = 0x06 #[0] Instr read start [1] Data read start
                                       #[2] Instr read done [3] Data read done
                                       #[4] DDLS read start [5] DDLS read done
                                       #[7:6] STREAM_SEL
ADDR_BOOT_ADDR                  = 0x07
ADDR_MTVEC_ADDR                 = 0x08
ADDR_RISCV_START                = 0x09
ADDR_RISCV_OFFSET               = 0x0A
ADDR_RISCV_RUN_CYCLE            = 0x0B
ADDR_RISCV_STATUS               = 0x0C
ADDR_RISCV_ERRCNT               = 0x0D # Read only
ADDR_DELAY_SEL                  = 0x0E
ADDR_DDLS_OFFSET                = 0x0F
ADDR_DDLS_ADDR                  = 0x10
ADDR_DDLS_DATA_IN               = 0x11
ADDR_DDLS_DATA_OUT              = 0x12
ADDR_CLK_CONTROL                = 0x13
ADDR_MAIN_DCO_CONTROL           = 0x14 # [7:4] COARSE [3:0] FINE
ADDR_RISCV_RUN_CYCLE_OFFSET     = 0x15
ADDR_SCAN_OUT                   = 0x16
ADDR_SCAN_OUT_OFFSET            = 0x17
ADDR_CORE_CYCLE_PRIMARY         = 0x1C
ADDR_CORE_CYCLE_SECONDARY       = 0x1D
ADDR_HEATER_P_SEL               = 0x22
ADDR_HEATER_P_IN                = 0x23
ADDR_HEATER_S_SEL               = 0x24
ADDR_HEATER_S_IN                = 0x25
ADDR_HEATER_CONTROL             = 0x26 # {GLOBAL_ENABLE, TEMP_SENSOR_EN, VOLT_SENSOR_EN, 2'b00, LOAD_HEATER_TOP, LOAD_HEATER_P, LOAD_HEATER_S}
ADDR_TEMP_SENSOR_SEL            = 0x27
ADDR_ODOMETER_SEL_7_0           = 0x29
ADDR_ODOMETER_SEL_15_8          = 0x2A
ADDR_ODOMETER_IN                = 0x2B
ADDR_ODOMETER_CONTROL           = 0x2C
ADDR_ODOMETER_BIT_CNT_7_0       = 0x2D
ADDR_ODOMETER_BIT_CNT_15_8      = 0x2E
ADDR_DEBUG_FREQ_OUT_SEL         = 0x30
ADDR_MAIN_DCO_EN                = 0x3F

################################################################################################################################
#  000  0      000   000  0   0
# 0     0     0   0 0     0 00
# 0     0     0   0 0     00
# 0     0     0   0 0     0 00
#  000  00000  000   000  0   0
################################################################################################################################
def clk_toggle():
    aclk.on()
    time.sleep(clk_half_period)
    aclk.off()
    time.sleep(clk_half_period)
    
def dco_sel():
    write_stream()
    
################################################################################################################################
# 0000  00000  000  00000 00000
# 0   0 0     0     0       0  
# 0000  00000  000  00000   0  
# 0   0 0         0 0       0 
# 0   0 00000  000  00000   0  
################################################################################################################################
def rare_reset():
    input_list = [awriteb, aaddr_0, aaddr_1, aaddr_2, aaddr_3, aaddr_4, aaddr_5, avalid, wvalid, rready, rsel]
    for input_port in input_list:
        input_port.off()
    # need to shutdown data GPIO pins
    data_0.close()
    data_1.close()
    data_2.close()
    data_3.close()
    data_4.close()
    data_5.close()
    data_6.close()
    data_7.close()
        
    data_0 = DigitalOutputDevice(data_0_pin)
    data_1 = DigitalOutputDevice(data_1_pin)
    data_2 = DigitalOutputDevice(data_2_pin)
    data_3 = DigitalOutputDevice(data_3_pin)
    data_4 = DigitalOutputDevice(data_4_pin)
    data_5 = DigitalOutputDevice(data_5_pin)
    data_6 = DigitalOutputDevice(data_6_pin)
    data_7 = DigitalOutputDevice(data_7_pin)
    clk_toggle()
    aresetb.off()
    clk_toggle()
    aresetb.on()
    clk_toggle()    

################################################################################################################################
# 0   0 0000  00000 00000 00000        000  00000 0000  00000   0   0   0
# 0   0 0   0   0     0   0           0       0   0   0 0      0 0  00 00
# 0 0 0 0000    0     0   00000        000    0   0000  00000 00000 0 0 0
# 0 0 0 0   0   0     0   0               0   0   0   0 0     0   0 0   0
#  0 0  0   0 00000   0   00000        000    0   0   0 00000 0   0 0   0
################################################################################################################################
def write_stream(addr, data):
    # write data to addr
    # set addr AXI to write mode
    rsel.off()
    awriteb.off()
    
    data_0 = DigitalOutputDevice(data_0_pin)
    data_1 = DigitalOutputDevice(data_1_pin)
    data_2 = DigitalOutputDevice(data_2_pin)
    data_3 = DigitalOutputDevice(data_3_pin)
    data_4 = DigitalOutputDevice(data_4_pin)
    data_5 = DigitalOutputDevice(data_5_pin)
    data_6 = DigitalOutputDevice(data_6_pin)
    data_7 = DigitalOutputDevice(data_7_pin)
    
    clk_toggle()
    addr_bin = '{:08b}'.format(addr) # address is 6 bit
    data_bin = '{:08b}'.format(data) # data is 8 bit
    
    aaddr_0.off() if int(addr_bin[7]) == 0 else aaddr_0.on()
    aaddr_1.off() if int(addr_bin[6]) == 0 else aaddr_1.on()
    aaddr_2.off() if int(addr_bin[5]) == 0 else aaddr_2.on()
    aaddr_3.off() if int(addr_bin[4]) == 0 else aaddr_3.on()
    aaddr_4.off() if int(addr_bin[3]) == 0 else aaddr_4.on()
    aaddr_5.off() if int(addr_bin[2]) == 0 else aaddr_5.on()
    
    data_0.off() if int(data_bin[7]) == 0 else data_0.on()
    data_1.off() if int(data_bin[6]) == 0 else data_1.on()
    data_2.off() if int(data_bin[5]) == 0 else data_2.on()
    data_3.off() if int(data_bin[4]) == 0 else data_3.on()
    data_4.off() if int(data_bin[3]) == 0 else data_4.on()
    data_5.off() if int(data_bin[2]) == 0 else data_5.on()
    data_6.off() if int(data_bin[1]) == 0 else data_6.on()
    data_7.off() if int(data_bin[0]) == 0 else data_7.on()
    
    while (aready.value == 0):
        clk_toggle()
    avalid.on()
    clk_toggle()
    avalid.off()
    clk_toggle()
    
    while(wready.value == 0):
        clk_toggle()
    wvalid.on()
    clk_toggle()
    wvalid.off()
    clk_toggle()

################################################################################################################################
# 0000  00000    0   0000        000  00000 0000  00000   0   0   0
# 0   0 0       0 0  0   0      0       0   0   0 0      0 0  00 00
# 0000  00000  00000 0   0       000    0   0000  00000 00000 0 0 0
# 0   0 0      0   0 0   0          0   0   0   0 0     0   0 0   0
# 0   0 00000  0   0 0000        000    0   0   0 00000 0   0 0   0
################################################################################################################################
def read_stream(addr):
    # read data from addr
    # set addr AXI to write mode
    data_0 = DigitalInputDevice(data_0_pin)
    data_1 = DigitalInputDevice(data_1_pin)
    data_2 = DigitalInputDevice(data_2_pin)
    data_3 = DigitalInputDevice(data_3_pin)
    data_4 = DigitalInputDevice(data_4_pin)
    data_5 = DigitalInputDevice(data_5_pin)
    data_6 = DigitalInputDevice(data_6_pin)
    data_7 = DigitalInputDevice(data_7_pin)
    
    rsel.off()
    awriteb.on()
    clk_toggle()
    addr_bin = '{:08b}'.format(addr) # address is 6 bit
    
    aaddr_0.off() if int(addr_bin[7]) == 0 else aaddr_0.on()
    aaddr_1.off() if int(addr_bin[6]) == 0 else aaddr_1.on()
    aaddr_2.off() if int(addr_bin[5]) == 0 else aaddr_2.on()
    aaddr_3.off() if int(addr_bin[4]) == 0 else aaddr_3.on()
    aaddr_4.off() if int(addr_bin[3]) == 0 else aaddr_4.on()
    aaddr_5.off() if int(addr_bin[2]) == 0 else aaddr_5.on()
    
    while (aready.value == 0):
        clk_toggle()
    avalid.on()
    clk_toggle()
    avalid.off()
    rready.on()
    clk_toggle()
    
    while(rvalid.value == 0):
        clk_toggle()
        
    data_read = data_7.value << 7 | data_6.value << 6 | data_5.value << 5 | data_4.value << 4 | data_3.value << 3 | data_2.value << 2 | data_1.value << 1 | data_0.value
    
    rready.off()
    clk_toggle()
    
    return data_read

################################################################################################################################
# 0   0 0000  00000 00000 00000        000     0     000   0   0 00000
# 0   0 0   0   0     0   0           0       0 0   0      0   0 0
# 0 0 0 0000    0     0   00000       0      00000  0      00000 00000
# 0 0 0 0   0   0     0   0           0      0   0  0      0   0 0
#  0 0  0   0 00000   0   00000        000   0   0   000   0   0 00000
################################################################################################################################
# writes lines from mem_file to selected cache from start_addr to end of the mem_file
# if mem_file is longer than cache depth, it will overflow and overwrite from 00000000
# addr width is 11 bits
# cache depth is 2048
# data width is 32 bits
# ADDR_CACHE_CONTROL {Stream_select[7:6], DDLS read done, DDLS read start, Data read done, Instr read done, Data read start, Instr read start}
def write_cache(mem_file, cache_sel, core_sel, start_addr):  
    # Set SRAM write mode to stream
    write_stream(ADDR_RISCV_START, 0x00)
    
    # if cache_sel = 0, instr cache
    # if cache_sel = 1, data cache
    addr_cache_data_in = ADDR_INSTR_DATA_IN
    addr_cache_addr = ADDR_INSTR_ADDR
    if (cache_sel == 0):
        print("Instruction cache selected")
        addr_cache_data_in = ADDR_INSTR_DATA_IN
        addr_cache_addr = ADDR_INSTR_ADDR
    elif (cache_sel == 1):
        print("Data cache selected")
        addr_cache_data_in = ADDR_DATA_DATA_IN
        addr_cache_addr = ADDR_DATA_ADDR
    else:
        print ("No cache selected, exiting")
        return 0
    
    # if core_sel = 0, primary core only
    # if core_sel = 1, secondary core only
    # if core_sel = 2, both primary and secondary cores
    core_mask = 0b10000000
    if core_sel == 0:
        print("Primary core selected")
        core_mask = 0b10000000
    elif core_sel == 1:
        print("Secondary core selected")
        core_mask = 0b01000000
    elif core_sel == 2:
        print("Both primary and secondary selected")
        core_mask = 0b11000000
    else:
        print("No core selected, exiting")
        return 0
    write_stream(ADDR_CACHE_CONTROL, core_mask)    
    
    write_stream(ADDR_RISCV_OFFSET, 0x00)
    # starting address is start_addr
    for i in range(4):
        addr = (start_addr >> (8*i)) & 0xFF
        write_stream(addr_cache_addr, addr)
        
    print("Cache streaming...")
    write_stream(ADDR_RISCV_OFFSET, 0x00)
    # write to cache addr
    with open (mem_file, 'r') as file:
        for line in file:
            for i in range(4):
                data = (int(line.strip(), 16) >> (8*i)) & 0xFF
                write_stream(addr_cache_data_in, data)
    print("Cache streaming finished...")
    
################################################################################################################################
# 0000  00000   0   0000         000     0     000   0   0 00000
# 0   0 0      0 0  0   0       0       0 0   0      0   0 0
# 0000  00000 00000 0   0       0      00000  0      00000 00000
# 0   0 0     0   0 0   0       0      0   0  0      0   0 0
# 0   0 00000 0   0 0000         000   0   0   000   0   0 00000
################################################################################################################################
# read data from selected cache from start_addr to sen_addr and write to mem_file
# addr width is 11 bits
# cache depth is 2048
# data width is 32 bits
def read_cache(mem_file, cache_sel, core_sel, start_addr, end_addr):
    # Set SRAM write mode to stream
    write_stream(ADDR_RISCV_START, 0x00)
    
    # if cache_sel = 0, instr cache
    # if cache_sel = 1, data cache
    addr_cache_data_out = ADDR_INSTR_DATA_OUT
    addr_cache_addr = ADDR_INSTR_ADDR
    read_start_mask = 0b00000001
    read_done_mask = 0b00000100
    if (cache_sel == 0):
        print("Instruction cache selected")
        addr_cache_data_out = ADDR_INSTR_DATA_OUT
        addr_cache_addr = ADDR_INSTR_ADDR
        read_start_mask = 0b00000001
        read_done_mask = 0b00000100
    elif (cache_sel == 1):
        print("Data cache selected")
        addr_cache_data_out = ADDR_DATA_DATA_OUT
        addr_cache_addr = ADDR_DATA_ADDR
        read_start_mask = 0b00000010
        read_done_mask = 0b00001000
    else:
        print ("No cache selected, exiting")
        return 0
    
    # if core_sel = 0, primary core only
    # if core_sel = 1, secondary core only
    core_mask = 0b10000000
    if core_sel == 0:
        print("Primary core selected")
        core_mask = 0b10000000
    elif core_sel == 1:
        print("Secondary core selected")
        core_mask = 0b01000000
    else:
        print("No core selected, exiting")
        return 0
    write_stream(ADDR_CACHE_CONTROL, core_mask)
    
    write_stream(ADDR_RISCV_OFFSET, 0x00)
    # starting address is start address
    for i in range(4):
        addr = (start_addr >> (8*i)) & 0xFF
        write_stream(addr_cache_addr, addr)
    # number of lines to read is if end_address - start_addr
    if (start_addr > end_addr):
        print("Invalid address value, exiting")
        return 0
    num_lines = end_addr - start_addr
        
    print("Cache reading...")
    write_stream(ADDR_RISCV_OFFSET, 0x00)
    # read and write to mem_file
    with open (mem_file, 'w') as file:
        for i in range(num_lines+1):
            write_stream(ADDR_CACHE_CONTROL, read_start_mask | core_mask)
            while((read_stream(ADDR_CACHE_CONTROL) & read_done_mask) != read_done_mask):
                clk_toggle()
            read_data_1 = format(read_stream(addr_cache_data_out), '02x')
            read_data_2 = format(read_stream(addr_cache_data_out), '02x')
            read_data_3 = format(read_stream(addr_cache_data_out), '02x')
            read_data_4 = format(read_stream(addr_cache_data_out), '02x')
            file.write(read_data_4+read_data_3+read_data_2+read_data_1+"\n")
    print("Cache reading finished...")
    
################################################################################################################################
# 0   0 0000  00000 00000 00000       0000  0000  0      000   
# 0   0 0   0   0     0   0           0   0 0   0 0     0      
# 0 0 0 0000    0     0   00000       0   0 0   0 0      000  
# 0 0 0 0   0   0     0   0           0   0 0   0 0         0 
#  0 0  0   0 00000   0   00000       0000  0000  00000  000  
################################################################################################################################
# DDLS cache width is 256 bits
# DDLS cache depth is 1024
def write_ddls(mem_file, start_addr):
    # Set SRAM write mode to stream
    write_stream(ADDR_RISCV_START, 0x00)
    write_stream(ADDR_DDLS_OFFSET, 0x00)
    for i in range(4):
        addr = (start_addr >> (8*i)) & 0xFF
        write_stream(ADDR_DDLS_ADDR, addr)
    
    print("DDLS streaming...")
    write_stream(ADDR_DDLS_OFFSET, 0x00)
    with open (mem_file, 'r') as file:
        for line in file:
            for i in range(32):
                data = (int(line.strip(), 16) >> (8*i)) & 0xFF
                write_stream(ADDR_DDLS_DATA_IN, data)
    print("DDLS streaming finished...")
    
################################################################################################################################
# 0000  00000   0   0000        0000  0000  0      000   
# 0   0 0      0 0  0   0       0   0 0   0 0     0      
# 0000  00000 00000 0   0       0   0 0   0 0      000  
# 0   0 0     0   0 0   0       0   0 0   0 0         0 
# 0   0 00000 0   0 0000        0000  0000  00000  000  
################################################################################################################################
# DDLS cache width is 256 bits
# DDLS cache depth is 1024
def read_ddls(mem_file, start_addr, end_addr):
    # Set SRAM write mode to stream
    write_stream(ADDR_RISCV_START, 0x00)
    write_stream(ADDR_DDLS_OFFSET, 0x00)
    for i in range(4):
        addr = (start_addr >> (8*i)) & 0xFF
        write_stream(ADDR_DDLS_ADDR,addr)
    if (start_addr > end_addr):
        print("Invalid address value, exiting")
        return 0
    num_lines = end_addr - start_addr
    
    print("DDLS reading...")
    write_stream(ADDR_DDLS_OFFSET, 0x00)
    # read and wirte to mem_file
    with open (mem_file, 'w') as file:
        for i in range(num_lines+1):
            read_data = "\n"
            write_stream(ADDR_CACHE_CONTROL, 0b00010000)
            while((read_stream(ADDR_CACHE_CONTROL) & 0b00100000) != 0b00100000):
                clk_toggle()
            for i in range(32):
                read_data = format(read_stream(ADDR_DDLS_DATA_OUT), '02x') +read_data
            file.write(read_data)
    print("DDLS reading finished...")
    

################################################################################################################################
#  000  0000   000  0   0 00000 00000 00000 0000
# 0   0 0   0 0   0 00 00 0       0   0     0   0       
# 0   0 0   0 0   0 0 0 0 00000   0   00000 0000 
# 0   0 0   0 0   0 0   0 0       0   0     0   0 
#  000  0000   000  0   0 00000   0   00000 0   0   
################################################################################################################################
# Odometer setup
# 21 odometers per core
# odometer 0-20 at primary odometer 21-41 at secondary
# writes same odometer control to start_odometer to end_odometer
def odometer_setup(start_odometer, end_odometer, odometer_control):
    if (start_odometer > end_odometer):
        print("Invalid odometer value, exiting")
        return 0
    num_odometer = end_odometer - start_odometer
    write_stream(ADDR_ODOMETER_SEL_7_0, start_odometer)   
    
    print("Odoemter writing...")
    for i in range(num_odometer+1):
        write_stream(ADDR_ODOMETER_IN, odometer_control)
    print("Odometer writing finished...")

def odometer_load():
    write_stream(ADDR_ODOMETER_CONTROL, 0b00000000) # odometer resetb = 0
    write_stream(ADDR_ODOMETER_CONTROL, 0b10000000) # odometer resetb = 1
    print("Odometer loading...")
    write_stream(ADDR_ODOMETER_CONTROL, 0b10000001) # load = 1
    print("Odometer loading finished...")
    
# triggers odometer measurement ant wait for meas_wait_sec until reset meas_trig back to 0
def odometer_meas_trig(meas_wait_sec):
    print("Odometer measuring...")
    write_stream(ADDR_ODOMETER_CONTROL, 0b10000010) # meas_trig = 1
    time.sleep(meas_wait_sec)
    write_stream(ADDR_ODOMETER_CONTROL, 0b10000000) # meas_trig = 0
    print("Odometer measuring finished...")
    
# Odometer bit count read
# Reads and writes bit count to mem_file from start_odometer to end_odometer
def odometer_bc_read(mem_file, start_odometer, end_odometer):
    if (start_odometer > end_odometer):
        print("Invalid odometer value, exiting")
        return 0
    num_odometer = end_odometer - start_odometer
    odometer_sel = start_odometer
    
    print("Odometer bit count reading...")
    with open (mem_file, 'w') as file:
        for i in range(num_odometer+1):
            read_data = "\n"
            write_stream(ADDR_ODOMETER_SEL_7_0, odometer_sel)
            write_stream(ADDR_ODOMETER_CONTROL, 0b10000100); # bit count read hit
            read_data = "Odometer " + str(odometer_sel) + ": " + read_stream(ADDR_ODOMETER_BIT_CNT_15_8) + read_stream(ADDR_ODOMETER_BIT_CNT_7_0) + read_data
            print(read_data)
            file.write(read_data)
            odometer_sel = odometer_sel + 1
    print("Odometer bit count reading finished...")
    
def odometer_dco_test_on():
    write_stream(ADDR_ODOMETER_SEL_7_0, 42)
    write_stream(ADDR_ODOMETER_IN, 0b00010011)
    write_stream(ADDR_DEBUG_FREQ_OUT_SEL, 0b00000001)
    
def odometer_dco_test_off():
    write_stream()
    
################################################################################################################################
# 0   0 00000   0   00000 00000 0000
# 0   0 0      0 0    0   0     0   0       
# 00000 00000 00000   0   00000 0000 
# 0   0 0   0 0   0   0   0     0   0 
# 0   0 00000 0   0   0   00000 0   0   
################################################################################################################################
# 84 heaters per core
def heater_sel():
    write_stream()
    
################################################################################################################################
# 00000 00000 0   0 0000   000  00000 0   0  000   000  0000
#   0   0     00 00 0   0 0     0     00  0 0     0   0 0   0
#   0   00000 0 0 0 0000   000  00000 0 0 0  000  0   0 0000
#   0   0     0   0 0         0 0     0  00     0 0   0 0   0
#   0   00000 0   0 0      000  00000 0   0  000   000  0   0
################################################################################################################################
def temp_sensor_sel():
    write_stream()