create_clock -period 39.722 -name pix_clk -waveform {0.000 19.861} [get_ports pix_clk]
create_clock -period 20.000 -name s00_axi_aclk -waveform {0.000 10.000} [get_ports s00_axi_aclk]
