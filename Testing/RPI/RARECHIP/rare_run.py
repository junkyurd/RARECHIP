from rare_setup import *
rare_reset()

'''
print("----------------------------------------")
print("Checking instruction cache read/write")
write_cache(mem_file = 'instr.m', cache_sel = 0, core_sel = 2, start_addr = 0)
read_cache(mem_file = 'instr_read_p.m', cache_sel = 0, core_sel = 0, start_addr = 0, end_addr = 1)
read_cache(mem_file = 'instr_read_s.m', cache_sel = 0, core_sel = 1, start_addr = 0, end_addr = 1)

print("----------------------------------------")
print("Checking data cache read/write")
write_cache(mem_file = 'instr.m', cache_sel = 1, core_sel = 2, start_addr = 0)
read_cache(mem_file = 'data_read_p.m', cache_sel = 1, core_sel = 0, start_addr = 0, end_addr = 1)
read_cache(mem_file = 'data_read_s.m', cache_sel = 1, core_sel = 1, start_addr = 0, end_addr = 1)

print("----------------------------------------")
print("Checking ddls cache read/write")
write_ddls(mem_file = 'ddls.m', start_addr = 0)
read_ddls(mem_file = 'ddls_read.m', start_addr = 0, end_addr = 1)
'''

# cpu run
def multi_cpu_run_dco():
    mem_file = 'RISCV_INSTR/sort_arithmetic/test_qsort.mem'
    with open('riscv_clk_result_fine.csv', 'w') as file:
        for run in range(1):
            write_cache(mem_file = mem_file, cache_sel = 0, core_sel = 2, start_addr = 0)
    
            for dc in range(0x80, 0x100, 0x01): #[0xa0, 0xa1, 0xa2, 0xa3, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 0xb0, 0xb1, 0xb2, 0xb3]:
                rare_reset()
                #primary_result, secondary_result = cpu_check_dco_clk('RISCV_INSTR/arithmetic/arithmetic_1.mem', dc, 0)
                primary_result, secondary_result = cpu_check_dco_clk(mem_file, dc, 0)
                Result = '{:02x}'.format(dc) + ',' + primary_result + secondary_result + '\n'
                
                file.write(Result)
multi_cpu_run_dco()
#odometer_test()
#with open ('riscv_ddls_delay_result.csv', 'w') as file:
#    for run in range(5):
#        for i in range(5): #[0x00, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70, 0x80, 0x90, 0xA0, 0xB0, 0xC0, 0xD0, 0xE0, 0xF0]:
#            rare_reset()
#            primary_result, secondary_result = cpu_check_dco_clk('RISCV_INSTR/arithmetic/arithmetic_2.mem', 0x00, i)
#            Result = str(i) + ',' + primary_result + secondary_result + '\n'
#            file.write(Result)
    #cpu_start_rpi_clk('RISCV_INSTR/arithmetic/arithmetic_1.mem')

#cpu_start_rpi_clk('instr_h_nostop.mem')
#cpu_start_dco_clk('RISCV_INSTR/arithmetic/arithmetic_2.mem')

# ddls compare cpu start
#mem_file_primary = 'RISCV_INSTR/arithmetic/arithmetic_1.mem'
#mem_file_secondary = 'RISCV_INSTR/arithmetic/arithmetic_2.mem'
#cpu_ddls_compare(mem_file_primary, mem_file_secondary, 0)


#rare_reset()


'''
# DCO Test
CLK_CONT = [0xFa, 0xFb, 0xFc, 0xFd, 0xFe, 0xFf]

for control in CLK_CONT:
	rare_reset()
	# write_stream(ADDR_CLK_CONTROL,0x40)       # reset clock_cnt
	# print(read_stream(ADDR_CLK_CONTROL)[0])
	print("Clock control = " + str(hex(control)))
	write_stream(ADDR_MAIN_DCO_CONTROL, control)  # Write value for FINE and COARSE
	# print(read_stream(ADDR_MAIN_DCO_CONTROL)[0])
	write_stream(ADDR_CLK_CONTROL, 0x02)       # Enable frequency out
	# 300 MHz
	# print(read_stream(ADDR_CLK_CONTROL)[0])
	write_stream(ADDR_DEBUG_FREQ_OUT_SEL, 0x00)# Select dco through the dco output mux
	# print(read_stream(ADDR_DEBUG_FREQ_OUT_SEL)[0])

	write_stream(ADDR_MAIN_DCO_EN, 0x01)      # Enable DCO

	input("Press Enter to continue...")

	write_stream(ADDR_MAIN_DCO_EN, 0x00)       # Disable DCO
'''

rare_reset()

print("finished")
