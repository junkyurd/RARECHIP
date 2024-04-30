from rare_setup import *

# DCO Test
rare_reset()
# write_stream(ADDR_CLK_CONTROL,0x40)       # reset clock_cnt
# print(read_stream(ADDR_CLK_CONTROL)[0])
write_stream(ADDR_MAIN_DCO_CONTROL, 0xd0)  # Write value for FINE and COARSE
# print(read_stream(ADDR_MAIN_DCO_CONTROL)[0])
write_stream(ADDR_CLK_CONTROL, 0x02)       # Enable frequency out
# 300 MHz
# print(read_stream(ADDR_CLK_CONTROL)[0])
write_stream(ADDR_DEBUG_FREQ_OUT_SEL, 0x00)# Select dco through the dco output mux
# print(read_stream(ADDR_DEBUG_FREQ_OUT_SEL)[0])

write_stream(ADDR_MAIN_DCO_EN, 0x01)      # Enable DCO

input("Press Enter to continue...")

write_stream(ADDR_MAIN_DCO_EN, 0x00)       # Disable DCO


rare_reset()