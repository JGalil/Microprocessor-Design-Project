// cache memory/register file
// default address pointer width = 4, for 16 registers
module reg_file #(parameter pw)(
  input[7:0] dat_in,
  input      clk,
  input      wr_en,           // write enable
  input[pw-1:0] wr_addr,		  // write address pointer
	      rd_addrA,		  // read address pointers
	      rd_addrB,
	      mv_addr,
  input 	reset, start,
  input logic       movR,
  output logic[7:0] datA_out, // read data
                    datB_out);



  logic[7:0] core[2**pw];    // 2-dim array  8 wide  16 deep


  always_ff @(posedge clk) begin
	if(reset|start) begin
		//integer i;
    		//for (i = 0; i < 2**pw; i = i + 1) begin
     			//core[i] = 8'b0; // Set each 8-bit element in the array to zero
    	//	end
		core[0] <= 0;
		core[1] <= 0;
		core[2] <= 0;
		core[3] <= 0;
		core[4] <= 0;
		core[5] <= 0;
		core[6] <= 0;
		core[7] <= 0;
		
	end
        if(wr_en & !movR)begin			   // anything but stores or no ops
           core[wr_addr] <= dat_in; 
        end 
        if(movR) begin
	   core[mv_addr] <= core[rd_addrA];
        end

  end
  
// reads are combinational


  assign datA_out = core[rd_addrA];
  assign datB_out = core[rd_addrB];
  


endmodule
/*
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
*/