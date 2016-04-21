
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2016 22:17:52
// Design Name: 
// Module Name: mf_disp_addr_dec
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "mf_disp_conf.vh"

module mf_disp_intf_vga_top(
   //VGA Clk 25.175Mhz
   input wire vga_clk,
   input wire resetn,

   //Mode Signals
   input  wire         intf_mode_enabled, //Interface Enabled
   input  wire         intf_mode_pix_double,  //Interface Pixel Doubling Mode
   input  wire         intf_mode_test,      //Interface Test Pattern Mode

   output reg          intf_frame_sel,

   input  wire         intf_frame_switch, //Interface Show Next Frame
   input  wire         intf_frame_restrt, //Interface Restart Frame

   //Framebuffer Data Read Signals
   output  wire        intf_pix_rd_vld,
   output  wire [15:0] intf_pix_rd_addr,
   
   input   wire [5:0]  intf_pix_rd_rdata,
   input   wire [5:0]  intf_pix_rd_gdata,
   input   wire [5:0]  intf_pix_rd_bdata,

    //VGA Signals
   output  wire        VGA_hsync,
   output  wire        VGA_vsync,
   output  wire [3:0]  VGA_red,
   output  wire [3:0]  VGA_green,
   output  wire [3:0]  VGA_blue
 );
 
 
 reg [9:0] frame_x_ptr;
 reg [9:0] frame_y_ptr;
 
 reg        frame_switch_pending;
 reg [16:0] mapped_frame_ptr;
 wire       filler;
 
 wire      test_mode;
 reg [5:0] test_mode_rdata;
 reg [5:0] test_mode_gdata;
 reg [5:0] test_mode_bdata;
 
 reg [9:0] h_count;
 reg [9:0] v_count;
 
 wire h_data;
 wire h_front;
 wire h_sync;
 wire h_back;
 wire h_end;
 
 wire v_data;
 wire v_front;
 wire v_sync;
 wire v_back;
 wire v_end;
 
//------------------------------------------------------------------------
 // Generate VGA Sync, and internal control signals for 640x480
 //------------------------------------------------------------------------
 //Horiz Timing
 //640 cycles  |  16cycles | 96cycles | 48cycles    (800Cycles)
 //    1             1          0           1
 // Line Data  |    Front  |  Sync     |  Back
 
 // Vert Timing
  //480 Lines  |  10Lines | 2Lines | 33Lines    (525Lines)
 //    1             1          0           1
 // Line Data  |    Front  |  Sync     |  Back
 
always @(posedge vga_clk, negedge resetn) begin: sync_pulse_timing_logic
   if( ~resetn ) begin
      h_count <= 10'b0;
      v_count <= 10'b0;
   end
   else begin
      if( ~intf_mode_enabled ) begin //Disable Counters
         h_count <= 10'b0;
         v_count <= 10'b0;
      end
      else begin
         if(( h_count >= 10'd799 ) && (v_count >= 10'd524)) begin //End of Frame
            v_count <= 10'b0;
            h_count <= 10'b0;
         end
         else begin
            if ( h_count >= 10'd799) begin
               h_count <= 10'b0;       //Reset Pixel Count
               v_count <= v_count + 1; //Increment Line Count
            end
            else begin
               h_count <= h_count + 1'b1;
            end
         end
      end
   end
end

assign h_data  = ( h_count >= 0  ) && ( h_count < 640 );
assign h_front = ( h_count >= 640) && ( h_count < 656 );
assign h_sync  = ( h_count >= 656) && ( h_count < 752 );
assign h_back  = ( h_count >= 752) && ( h_count < 800 );
assign h_end   = ( h_count == 799);


assign v_data  = ( v_count >= 0  ) && ( v_count < 480 );
assign v_front = ( v_count >= 480) && ( v_count < 490 );
assign v_sync  = ( v_count >= 490) && ( v_count < 492 );
assign v_back  = ( v_count >= 492) && ( v_count < 525 );
assign v_end = (h_count == 799) && (v_count == 524);

//------------------------------------------------------------------------
// Generate Native 640x480 pixel pointers
//------------------------------------------------------------------------
always @(posedge vga_clk, negedge resetn) begin : pixel_pointer_logic
   if( ~resetn ) begin
      frame_x_ptr[9:0] <= 10'b0;
      frame_y_ptr[9:0] <= 10'b0;
   end
   else begin
      if( ~intf_mode_enabled ) begin //Disable Counters
         frame_x_ptr <= 10'b0;
         frame_y_ptr <= 10'b0;
      end
      else begin
         if( h_end & v_end ) begin // End of Frame
            frame_x_ptr <= 10'b0;
            frame_y_ptr <= 10'b0;
         end
         else if( h_end & v_data ) begin // End of Line
            frame_x_ptr <= 10'b0;
            frame_y_ptr <= frame_y_ptr + 1'b1;
         end
         else if( h_data ) begin// Count during Data
            frame_x_ptr <= frame_x_ptr + 1'b1;
         end
      end
   end
end


//------------------------------------------------------------------------
// Map 320x200 to native 640x480 resolution
//------------------------------------------------------------------------

//  40pixel black color for top and bottom
//  Single Mode: 320x200  (>319x stop pointer inc, black color)
//                        (>199y stop pointer inc, black color)

//  Double Mode: 640x400  (inc ptr every two x)
//                        (odd y,  ptr - 320)

always @(posedge vga_clk, negedge resetn) begin : resolution_map_pointer_logic
   if( ~resetn ) begin
      mapped_frame_ptr[16:0] <= 14'b0;
   end
   else begin
      if ( ~intf_mode_enabled | (v_end & h_end) ) begin // Reset Pointer
         mapped_frame_ptr[16:0] <= 14'b0;
      end
      else begin
         if ( ~filler ) begin // Dont increment pointer if in filler
            if ( ~intf_mode_pix_double ) begin //Single Mode
               mapped_frame_ptr[16:0] <= mapped_frame_ptr + 1'b1;
            end
            else begin                         //Double Mode
               if (frame_x_ptr[0]) mapped_frame_ptr[16:0] <= mapped_frame_ptr + 1'b1;  //Odd Pixel only increment
               if (frame_y_ptr[0] && (frame_x_ptr>=10'd640) ) mapped_frame_ptr[16:0] <= mapped_frame_ptr - 1'b321;  //Odd line repeat       
            end
         end
      end

   end
end

assign filler = //(( frame_y_ptr >=10'd0)   && (frame_y_ptr < 10'd40))  | // Top Bar
                //(( frame_y_ptr >=10'd600) && (frame_y_ptr < 10'd640)) | // Bottom Bar
                  (~intf_mode_pix_double & ( frame_x_ptr >=320)) |      // Single Mode Margin Right
                  (~intf_mode_pix_double & ( frame_y_ptr >=200)) ;      // Single Mode Margin Bottom

//------------------------------------------------------------------------
// Test Mode
//------------------------------------------------------------------------

assign test_mode = intf_mode_test; 

always @(*) begin // Test Mode Pattern, Red, Green, Blue horizontal bands
   if     ( mapped_frame_ptr < 17'd21333 ) begin //First Third of testmode buffer
      test_mode_rdata[5:0] = 6'h3f;
      test_mode_gdata[5:0] = 6'h0;
      test_mode_bdata[5:0] = 6'h0;
   end
   else if( mapped_frame_ptr < 17'd42666 ) begin //Second Third of testmode buffer
      test_mode_rdata[5:0] = 6'h0;
      test_mode_gdata[5:0] = 6'h3f;
      test_mode_bdata[5:0] = 6'h0;
   end      
   else begin                                    //Last Third of testmode buffer
      test_mode_rdata[5:0] = 6'h0;
      test_mode_gdata[5:0] = 6'h0;
      test_mode_bdata[5:0] = 6'h3f;
   end
end

//------------------------------------------------------------------------
// Framebuffer Read Signals
//------------------------------------------------------------------------

//Frame Buffer Frame Select, Toggle value when its the end of a frame 
 //and a frame_switch is pending
 always @(posedge vga_clk, negedge resetn) begin : flop_framebuffer_frame_sel_and_switch_pending
    if ( ~resetn ) begin
       intf_frame_sel <= 1'b0;
       frame_switch_pending <= 1'b0;
    end
    else begin
       if ( intf_frame_switch )                         // Set pending frame switch flag
          frame_switch_pending <= 1'b1;
       else if( ( h_end & v_end & frame_switch_pending) |
                ( ~intf_mode_enabled & frame_switch_pending) ) begin
          frame_switch_pending <= 1'b0;                // Clear pending frame switch flag
          intf_frame_sel <= ~intf_frame_sel;           // Toggle Frame Selector
       end
    end
 end


//Only Read Framebuffer during display data, not in filler or test_mode
assign intf_pix_rd_vld        = h_data & ~filler & ~test_mode;
assign intf_pix_rd_addr[15:0] = mapped_frame_ptr[15:0];


//------------------------------------------------------------------------
// VGA Interface Pins
//------------------------------------------------------------------------
//Sync Timing Signals
assign VGA_hsync = ~h_sync;
assign VGA_vsync = ~v_sync; 

//VGA Color Mux
assign VGA_red  [3:0] = filler    ? 4'h0                   :  // In Filler Section Display Black
                        test_mode ? test_mode_rdata  [5:2] :  // In TestMode use test_mode_rdata
                                    intf_pix_rd_rdata[5:2];   // Use Framebuffer R Value
                                 
assign VGA_green[3:0] = filler    ? 4'h0                   :  // In Filler Section Display Black
                        test_mode ? test_mode_gdata  [5:2] :  // In TestMode use test_mode_gdata
                                    intf_pix_rd_gdata[5:2];   // Use Framebuffer G Value          
                                 
assign VGA_blue [3:0] = filler    ? 4'h0                   :  // In Filler Section Display Black
                        test_mode ? test_mode_bdata  [5:2] :  // In TestMode use test_mode_bdata
                                    intf_pix_rd_bdata[5:2];   // Use Framebuffer B Value

endmodule
