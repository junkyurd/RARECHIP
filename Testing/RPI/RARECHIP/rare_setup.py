from gpiozero import *
import time
import sys
import signal
import pyvisa
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

def set_data_2_output():
    # set data ports to write mode
    # write mode switch to write mode trigate first
    rsel.off()
    awriteb.off()
    # shutdown data GPIO pins to switch between read and write
    global data_0, data_1, data_2, data_3, data_4, data_5, data_6, data_7
    time.sleep(0.1)
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
    return 0
    
def set_data_2_input():
    # set data ports to read mode
    # shutdown data GPIO pins to switch between read and write
    global data_0, data_1, data_2, data_3, data_4, data_5, data_6, data_7
    time.sleep(0.1)
    data_0.close()
    data_1.close()
    data_2.close()
    data_3.close()
    data_4.close()
    data_5.close()
    data_6.close()
    data_7.close()
    data_0 = DigitalInputDevice(data_0_pin)
    data_1 = DigitalInputDevice(data_1_pin)
    data_2 = DigitalInputDevice(data_2_pin)
    data_3 = DigitalInputDevice(data_3_pin)
    data_4 = DigitalInputDevice(data_4_pin)
    data_5 = DigitalInputDevice(data_5_pin)
    data_6 = DigitalInputDevice(data_6_pin)
    data_7 = DigitalInputDevice(data_7_pin)
    
    # read mode switch to write mode trigate last
    rsel.on()
    awriteb.on()
    return 0

def check_switch_data_port(switch_mode):
    # if switch_mode = 0: switch to write mode if it is in read mode currently
    # if switch_mode = 1: switch to read mode if it is in write mode currently
    
    # check current mode by checking rsel pin value
    if (rsel.value == 0): # it is in write mode
        if (switch_mode == 1):
            print("Switching to read mode...")
            set_data_2_input()
        elif (switch_mode != 0):
            print("Error, exiting...")
            sys.exit()
    elif (rsel.value == 1): # it is in read mode
        if (switch_mode == 0):
            print("Switching to write mode...")
            set_data_2_output()
        elif (switch_mode != 1):
            print("Error, exiting...")
            sys.exit()
    else: # this should not happen
        if (switch_mode == 0):
            print("Switching to write mode...")
            set_data_2_output()
        elif (switch_mode == 1):
            print("Switching to read mode...")
            set_data_2_input()
        else:
            print("Error, exiting...")
            sys.exit()
            
    clk_toggle()
    

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
    print("reseting rare chip")
    input_list = [awriteb, aaddr_0, aaddr_1, aaddr_2, aaddr_3, aaddr_4, aaddr_5, avalid, wvalid, rready, rsel]
    for input_port in input_list:
        input_port.off()
    # default for data pins are output
    set_data_2_output()
    clk_toggle()
    aresetb.off()
    clk_toggle()
    aresetb.on()
    clk_toggle()    
    print("reset finished")
    return 0

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

    check_switch_data_port(0)
        
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
    clk_toggle()
    clk_toggle()
    
    return 0

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
    check_switch_data_port(1)
    
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
    
    return data_read, data_0, data_1, data_2, data_3, data_4, data_5, data_6, data_7

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
            while((read_stream(ADDR_CACHE_CONTROL)[0] & read_done_mask) != read_done_mask):
                clk_toggle()
            read_data_1 = format(read_stream(addr_cache_data_out)[0], '02x')
            read_data_2 = format(read_stream(addr_cache_data_out)[0], '02x')
            read_data_3 = format(read_stream(addr_cache_data_out)[0], '02x')
            read_data_4 = format(read_stream(addr_cache_data_out)[0], '02x')
            file.write(read_data_4+read_data_3+read_data_2+read_data_1+"\n")
            #print(read_data_4+read_data_3+read_data_2+read_data_1+"\n")
    print("Cache reading finished...")

def read_cache_as_array(cache_sel, core_sel, start_addr, end_addr):
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
    cache_array = []
    # read and write to mem_file    
    for i in range(num_lines+1):
        write_stream(ADDR_CACHE_CONTROL, read_start_mask | core_mask)
        while((read_stream(ADDR_CACHE_CONTROL)[0] & read_done_mask) != read_done_mask):
            clk_toggle()
        read_data_1 = format(read_stream(addr_cache_data_out)[0], '02x')
        read_data_2 = format(read_stream(addr_cache_data_out)[0], '02x')
        read_data_3 = format(read_stream(addr_cache_data_out)[0], '02x')
        read_data_4 = format(read_stream(addr_cache_data_out)[0], '02x')
        cache_array.append(read_data_4+read_data_3+read_data_2+read_data_1)
        #print(read_data_4+read_data_3+read_data_2+read_data_1+"\n")
    print("Cache reading finished...")
    return cache_array

    
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
            while((read_stream(ADDR_CACHE_CONTROL)[0] & 0b00100000) != 0b00100000):
                clk_toggle()
            for i in range(32):
                read_data = format(read_stream(ADDR_DDLS_DATA_OUT)[0], '02x') +read_data
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
def odometer_test():
    write_stream(ADDR_ODOMETER_SEL_7_0, 42)
    write_stream(ADDR_ODOMETER_IN, 0b00010000)
    
    write_stream(ADDR_ODOMETER_SEL_7_0, 5)
    #print(read_stream(ADDR_ODOMETER_SEL_7_0)[0])
    write_stream(ADDR_ODOMETER_IN, 0b00000010) # 5
    #print(read_stream(ADDR_ODOMETER_SEL_7_0)[0])
    write_stream(ADDR_ODOMETER_IN, 0b00000100) # 6
    #print(read_stream(ADDR_ODOMETER_SEL_7_0)[0])
    write_stream(ADDR_ODOMETER_IN, 0b00000001) # 7
    #print(read_stream(ADDR_ODOMETER_SEL_7_0)[0])

    write_stream(ADDR_ODOMETER_CONTROL, 0b10000000) # RESETB 1


    write_stream(ADDR_ODOMETER_CONTROL, 0b10000001) # LOAD 1
    for i in range(20):
        clk_toggle()
    write_stream(ADDR_ODOMETER_CONTROL, 0b10000010)  # MEAS TRIG 1
    for i in range(1000):
        clk_toggle()
    write_stream(ADDR_ODOMETER_CONTROL, 0b10000000)  # MEAS TRIG 0
    for i in range(20):
        clk_toggle()
    write_stream(ADDR_ODOMETER_SEL_7_0, 5)
    write_stream(ADDR_ODOMETER_CONTROL, 0b10000100)
    print(read_stream(ADDR_ODOMETER_BIT_CNT_7_0)[0])
    print(read_stream(ADDR_ODOMETER_BIT_CNT_15_8)[0])
    write_stream(ADDR_ODOMETER_CONTROL, 0b10000100)
    print(read_stream(ADDR_ODOMETER_BIT_CNT_7_0)[0])
    print(read_stream(ADDR_ODOMETER_BIT_CNT_15_8)[0])
    write_stream(ADDR_ODOMETER_CONTROL, 0b10000100)
    print(read_stream(ADDR_ODOMETER_BIT_CNT_7_0)[0])
    print(read_stream(ADDR_ODOMETER_BIT_CNT_15_8)[0])

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
# 0   0 0     0   0   0   0     0   0 
# 0   0 00000 0   0   0   00000 0   0   
################################################################################################################################
# 84 heaters per core
def heater_sel(heater_type, heater_sel):
    # if heater_type = 0, primary core heater
    # if heater_type = 1, secondary core heater
    addr_heater_sel = ADDR_HEATER_P_SEL
    addr_heater_in = ADDR_HEATER_P_IN
    if (heater_type == 0):
        print("Primary core heater selected")
        addr_heater_sel = ADDR_HEATER_P_SEL
        addr_heater_in = ADDR_HEATER_P_IN
        write_stream(addr_heater_sel, heater_sel)
    elif (heater_type == 1):
        print("Secondary core heater selected")
        addr_heater_sel = ADDR_HEATER_S_SEL
        addr_heater_in = ADDR_HEATER_S_IN
        write_stream(addr_heater_sel, heater_sel)
    else:
        print ("No heater selected, exiting")
        return 0


################################################################################################################################
# 00000 00000 0   0 0000   000  00000 0   0  000   000  0000
#   0   0     00 00 0   0 0     0     00  0 0     0   0 0   0
#   0   00000 0 0 0 0000   000  00000 0 0 0  000  0   0 0000
#   0   0     0   0 0         0 0     0  00     0 0   0 0   0
#   0   00000 0   0 0      000  00000 0   0  000   000  0   0
################################################################################################################################
def temp_sensor_sel(temp_sensor):
    write_stream(ADDR_TEMP_SENSOR_SEL, temp_sensor)
    
################################################################################################################################
#  000  0000  0   0
# 0     0   0 0   0
# 0     0000  0   0
# 0     0     0   0
#  000  0      000
################################################################################################################################
def cpu_start_rpi_clk(mem_file):
    # instruction write
    write_cache(mem_file = mem_file, cache_sel = 0, core_sel = 2, start_addr = 0)
    
    # Enable DCO
    write_stream(ADDR_CLK_CONTROL, 0b01000001)
    write_stream(ADDR_MAIN_DCO_CONTROL, 0xd8)
    write_stream(ADDR_MAIN_DCO_EN, 0x01)

    write_stream(ADDR_DELAY_SEL, 0) # DDLS secondary delay is 0
    write_stream(ADDR_RISCV_RUN_CYCLE_OFFSET, 0b00000000) # run cycle disable

    write_stream(ADDR_RISCV_RUN_CYCLE, 0x04)
    write_stream(ADDR_RISCV_RUN_CYCLE, 0x00)
    write_stream(ADDR_RISCV_RUN_CYCLE, 0x00)
    write_stream(ADDR_RISCV_RUN_CYCLE, 0x00)

    write_stream(ADDR_RISCV_OFFSET, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    
    write_stream(ADDR_MTVEC_ADDR, 0x00)
    write_stream(ADDR_MTVEC_ADDR, 0x00)
    write_stream(ADDR_MTVEC_ADDR, 0x00)
    write_stream(ADDR_MTVEC_ADDR, 0x00)

    write_stream(ADDR_DEBUG_FREQ_OUT_SEL, 0x00)

    write_stream(ADDR_RISCV_START, 0b00000000)
    write_stream(ADDR_RISCV_START, 0b00000010) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB 
    write_stream(ADDR_RISCV_START, 0b00000010) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB 
    write_stream(ADDR_RISCV_START, 0b00001110) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB 
    write_stream(ADDR_RISCV_START, 0b00001111) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB

    while((read_stream(ADDR_RISCV_STATUS)[0] & 0b00000001) != 0b00000001): # Wait until RISC-V done
        #print("Checking program done: " + str(bin(read_stream(ADDR_RISCV_STATUS))))
        clk_toggle() # check[0] for both core operation [6] for only primary [7] for only secondary
    #print("Program pause by a program")
    #print("Program resume")
    #write_stream(ADDR_CLK_CONTROL, 0b00000001)
    #write_stream(ADDR_CLK_CONTROL, 0b01000001)
    #while((read_stream(ADDR_RISCV_STATUS)[0] & 0b00000001) != 0b00000001): # Wait until RISC-V done
        #print("Checking program done: " + str(bin(read_stream(ADDR_RISCV_STATUS))))
    #    clk_toggle() # check[0] for both core operation [6] for only primary [7] for only secondary

    # check data results
    data_start_addr = 0x000007EC >> 2
    data_end_addr = 0x000007FC >> 2
    read_cache(mem_file = 'cpu_data_p.m', cache_sel = 1, core_sel = 0 , start_addr = data_start_addr, end_addr = data_end_addr)
    read_cache(mem_file = 'cpu_data_s.m', cache_sel = 1, core_sel = 1 , start_addr = data_start_addr, end_addr = data_end_addr)

def cpu_check_dco_clk(mem_file, clk_control, ddls_delay):
    # Clear data cache
    data_start_addr = 0x00000784 >> 2
    data_end_addr = 0x000007F8 >> 2
    write_cache(mem_file = 'clear_data.mem', cache_sel = 1, core_sel = 2, start_addr = data_start_addr)
    write_cache(mem_file = mem_file, cache_sel = 1, core_sel = 2, start_addr = 0)

    # Instruction write
    #write_cache(mem_file = mem_file, cache_sel = 0, core_sel = 2, start_addr = 0)
    # Enable DCO
    write_stream(ADDR_CLK_CONTROL, 0b01000000)
    write_stream(ADDR_MAIN_DCO_CONTROL, clk_control)

    write_stream(ADDR_MAIN_DCO_EN, 0x01)
    
    write_stream(ADDR_DELAY_SEL, ddls_delay) # DDLS secondary delay is 0
    write_stream(ADDR_RISCV_RUN_CYCLE_OFFSET, 0b00000000) # run cycle disable

    write_stream(ADDR_RISCV_RUN_CYCLE, 0x04)
    write_stream(ADDR_RISCV_RUN_CYCLE, 0x00)
    write_stream(ADDR_RISCV_RUN_CYCLE, 0x00)
    write_stream(ADDR_RISCV_RUN_CYCLE, 0x00)

    write_stream(ADDR_RISCV_OFFSET, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    
    write_stream(ADDR_MTVEC_ADDR, 0x00)
    write_stream(ADDR_MTVEC_ADDR, 0x00)
    write_stream(ADDR_MTVEC_ADDR, 0x00)
    write_stream(ADDR_MTVEC_ADDR, 0x00)

    write_stream(ADDR_DEBUG_FREQ_OUT_SEL, 0x00)

    # Starting RISC-V
    
    write_stream(ADDR_RISCV_START, 0b00000000)
    write_stream(ADDR_RISCV_START, 0b00000010) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB 
    write_stream(ADDR_RISCV_START, 0b00000010) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB 
    write_stream(ADDR_RISCV_START, 0b00001110) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB 
    write_stream(ADDR_RISCV_START, 0b00001111) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB
    
    
    # if it does not finish after 5000 clk_toggle exit
    clk_toggle_count = 0
    while((read_stream(ADDR_RISCV_STATUS)[0] & 0b00000001) != 0b00000001): # Wait until RISC-V done
        #print("Checking program done: " + str(bin(read_stream(ADDR_RISCV_STATUS))))
        clk_toggle() # check[0] for both core operation [6] for only primary [7] for only secondary
        if (clk_toggle_count == 5000):
            break
        clk_toggle_count = clk_toggle_count + 1
    # correct answer
    # 7EC: 00000037
    # 7F0: fffffffb
    # 7F4: 00000078
    # 7F8: 00000010
    # 7FC: 00000005
    write_stream(ADDR_MAIN_DCO_EN, 0x00)
    correct_read = ['00000000', '00000001', '00000002', '00000005', '00000009', '0000000b', '0000000d', '00000011', '00000012', '00000013', '00000016', '00000017', '0000001c', '0000001e', '0000001f', '0000002a', '0000002d', '00000039', '0000003e', '00000043', '00000046', '0000004e', '0000005b', '0000005c', '00000062', '000003a3', '00000181', 'ffffffd3', '00375f00', '00000038']

    primary_read = read_cache_as_array(cache_sel = 1, core_sel = 0 , start_addr = data_start_addr, end_addr = data_end_addr)
    
    secondary_read = read_cache_as_array(cache_sel = 1, core_sel = 1 , start_addr = data_start_addr, end_addr = data_end_addr)
    primary_result = ''
    secondary_result = ''
    #print(primary_read)
    #print(secondary_read)
    for i in range(len(correct_read)):
        if correct_read[i] == primary_read[i]:
            primary_result = primary_result + '1,'
        else:
            primary_result = primary_result + '0,'
        if correct_read[i] == secondary_read[i]:
            secondary_result = secondary_result + '1,'
        else:
            secondary_result = secondary_result + '0,'
    secondary_result = secondary_result[:-1]
    return primary_result,secondary_result

def cpu_start_dco_clk(mem_file):
    # instruction write
    write_cache(mem_file = mem_file, cache_sel = 0, core_sel = 2, start_addr = 0)
    
    # Enable DCO
    write_stream(ADDR_CLK_CONTROL, 0b01000000)
    write_stream(ADDR_MAIN_DCO_CONTROL, 0x00)

    write_stream(ADDR_MAIN_DCO_EN, 0x01)

    write_stream(ADDR_DELAY_SEL, 0) # DDLS secondary delay is 0
    write_stream(ADDR_RISCV_RUN_CYCLE_OFFSET, 0b00000000) # run cycle disable

    write_stream(ADDR_RISCV_RUN_CYCLE, 0x04)
    write_stream(ADDR_RISCV_RUN_CYCLE, 0x00)
    write_stream(ADDR_RISCV_RUN_CYCLE, 0x00)
    write_stream(ADDR_RISCV_RUN_CYCLE, 0x00)

    write_stream(ADDR_RISCV_OFFSET, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    write_stream(ADDR_BOOT_ADDR, 0x00)
    
    write_stream(ADDR_MTVEC_ADDR, 0x00)
    write_stream(ADDR_MTVEC_ADDR, 0x00)
    write_stream(ADDR_MTVEC_ADDR, 0x00)
    write_stream(ADDR_MTVEC_ADDR, 0x00)

    write_stream(ADDR_DEBUG_FREQ_OUT_SEL, 0x00)

    write_stream(ADDR_RISCV_START, 0b00000000)
    write_stream(ADDR_RISCV_START, 0b00000010) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB 
    write_stream(ADDR_RISCV_START, 0b00000010) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB 
    write_stream(ADDR_RISCV_START, 0b00001110) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB 
    write_stream(ADDR_RISCV_START, 0b00001111) # [0] RISCV_RESETB [1] FETCH_ENABLE [2] RISCV_CLK_EN [3] DDLS_RESETB

    while((read_stream(ADDR_RISCV_STATUS)[0] & 0b00000001) != 0b00000001): # Wait until RISC-V done
        #print("Checking program done: " + str(bin(read_stream(ADDR_RISCV_STATUS))))
        clk_toggle() # check[0] for both core operation [6] for only primary [7] for only secondary
    #print("Program pause by a program")
    #print("Program resume")
    #write_stream(ADDR_CLK_CONTROL, 0b00000000)
    #write_stream(ADDR_CLK_CONTROL, 0b01000000)
    #while((read_stream(ADDR_RISCV_STATUS)[0] & 0b00000001) != 0b00000001): # Wait until RISC-V done
        #print("Checking program done: " + str(bin(read_stream(ADDR_RISCV_STATUS))))
    #    clk_toggle() # check[0] for both core operation [6] for only primary [7] for only secondary

    # check data results
    data_start_addr = 0x000007EC >> 2
    data_end_addr = 0x000007FC >> 2
    read_cache(mem_file = 'cpu_data_p.m', cache_sel = 1, core_sel = 0 , start_addr = data_start_addr, end_addr = data_end_addr)
    read_cache(mem_file = 'cpu_data_s.m', cache_sel = 1, core_sel = 1 , start_addr = data_start_addr, end_addr = data_end_addr)

#ddls cpu
#Writing different instructions between the primary and the secondary Primary will keep the instruction written previously while the secondary will receive sligtly modified instruction. (Different initial sum value (0 to 1), therefore the final sum result getting saved at the secondary should be 10)
def cpu_ddls_compare(mem_file_primary, mem_file_secondary, ddls_delay):
    # instruction write
    write_cache(mem_file = mem_file_primary, cache_sel = 0, core_sel = 0, start_addr = 0)
    write_cache(mem_file = mem_file_secondary, cache_sel = 0, core_sel = 1, start_addr = 0)
    

################################################################################################################################
# Clean up code everytime when I hit ctrl+c
################################################################################################################################
def signal_handler(sig, frame):
    print('\nYou pressed Ctrl+C!')
    rare_reset()
    sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)


################################################################################################################################
# Power Supply Operation
################################################################################################################################
#psu_address='USB0::10893::36609::CN61310222::0::INSTR'
#rm=pyvisa.ResourceManager()
#psu=rm.open_resource(psu_address)


#def psu_operation(volt, curr, channel, operation):
    # Set the selected channel of SMU on or off, with the provided voltage and current level.
    # Voltage level: Volt; Current level: Amp; Channel: (1,2,3)
    # Operation = 'on': turn on; Operation = 'off': turn off
    # psu.write('*RST')
#    psu.write('INST:NSEL '+str(channel)) # selects channel
#    psu.write('SOUR:VOLT:LEV:IMM:AMPL '+str(volt)) # set voltage
#    psu.write('SOUR:CURR:LEV:IMM:AMPL '+str(curr)) # set current
#    if (operation=='on'):
#        psu.write('OUTP:STAT 1') # enables channel output
#    elif (operation=='off'):
#        psu.write('OUTP:STAT 0') # disables channel output
#    else:
#        print ("invalid operation mode please enter 1 for turning on and 0 for turning off")
#        return 0

################################################################################################################################
# Sourcemeter Unit Operation
################################################################################################################################
#smu_address='USB0::1510::9732::4056097\x00::0::INSTR'
#smu=rm.open_resource(smu_address)
#limitCurrent = "10e-3"
#limitVoltage = "1.5"
#measureRangeI = "10e-3"
#measureRangeV = "10e-6"
#def K2604_sourceV_setup(measMode, smu_channel, sourceVoltage):
#    smu.write(smu_channel+'.reset()')
#    if(measMode == 2):
#        smu.write(smu_channel+'.sense='+smu_channel+'.SENSE_LOCAL')
#    elif(measMode ==4):
#        smu.write(smu_channel+'.sense='+smu_channel+'.SENSE_REMOTE')
#    smu.write(smu_channel+'.source.func='+smu_channel+'.OUTPUT_DCVOLTS')
#    smu.write(smu_channel+'.source.autorangev='+smu_channel+'.AUTORANGE_ON')
#    smu.write(smu_channel+'.source.limiti='+limitCurrent)
#    smu.write(smu_channel+'.measure.rangei='+measureRangeI)
#    smu.write(smu_channel+'.source.levelv='+str(sourceVoltage))
#    return 0

#def K2604_sourceV_start(smu_channel):
#    smu.write(smu_channel+'.source.output='+smu_channel+'.OUTPUT_ON')
#    volt = smu.query('print('+smu_channel+'.measure.v('+smu_channel+'.nvbuffer1))')
#    curr = smu.query('print('+smu_channel+'.measure.i('+smu_channel+'.nvbuffer1))')
#   res = smu.query('print('+smu_channel+'.measure.r('+smu_channel+'.nvbuffer1))')
#   return float(volt), float(curr), float(res)
#def K2604_sourceV_end(smu_channel):
#    smu.write(smu_channel+'.source.output='+smu_channel+'.OUTPUT_OFF')

################################################################################################################################
# DMM Operation
################################################################################################################################
#dmm_address = "USB0::2391::1543::MY53002735::0::INSTR"
#dmm=rm.open_resource(dmm_address)
#def A34410_measV():
#    # dmm.write('MEAS:DC?')
#    volt = dmm.query('MEAS:DC?')
#    return float(volt)


if __name__ == "__main__":
    
    # rare_reset()
    # check_switch_data_port(0)
    # check_switch_data_port(0)
    # check_switch_data_port(1)
    # check_switch_data_port(1)
    # check_switch_data_port(0)
    rare_reset()

    write_stream(ADDR_MAIN_DCO_CONTROL, 0xFF)
    print(read_stream(ADDR_MAIN_DCO_CONTROL)[0])

    write_stream(ADDR_MAIN_DCO_CONTROL, 0xFF)
    print(read_stream(ADDR_MAIN_DCO_CONTROL)[0])
