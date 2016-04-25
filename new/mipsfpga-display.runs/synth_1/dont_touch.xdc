# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# XDC: imports/new/timing.xdc

# IP: ip/fb_bram_mem_gen/fb_bram_mem_gen.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==fb_bram_mem_gen || ORIG_REF_NAME==fb_bram_mem_gen}]

# IP: ip/pal_bram_mem_gen/pal_bram_mem_gen.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==pal_bram_mem_gen || ORIG_REF_NAME==pal_bram_mem_gen}]

# IP: ip/cdc_fifo_gen/cdc_fifo_gen.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==cdc_fifo_gen || ORIG_REF_NAME==cdc_fifo_gen}]

# XDC: ip/fb_bram_mem_gen/fb_bram_mem_gen_ooc.xdc

# XDC: ip/pal_bram_mem_gen/pal_bram_mem_gen_ooc.xdc

# XDC: ip/cdc_fifo_gen/cdc_fifo_gen/cdc_fifo_gen_clocks.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==cdc_fifo_gen || ORIG_REF_NAME==cdc_fifo_gen}] {/U0 }]/U0 ]]

# XDC: ip/cdc_fifo_gen/cdc_fifo_gen/cdc_fifo_gen.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==cdc_fifo_gen || ORIG_REF_NAME==cdc_fifo_gen}] {/U0 }]/U0 ]]
