// program counter
// supports both relative and absolute jumps
// use either or both, as desired
module PC #(parameter D=8)(
  input reset,					// synchronous reset
        clk,
		reljump_en,             // rel. jump enable
	E,
	G,
        start,
  input       [D-1:0] target,	// how far/where to jump
  output logic[D-1:0] prog_ctr
);

  always_ff @(posedge clk)
    if(reset|start)
	  prog_ctr <= '0;
	else if(reljump_en && E)
	  prog_ctr <= prog_ctr + target;
	else if(reljump_en && G)
	  prog_ctr <= prog_ctr + target;
	else
	  prog_ctr <= prog_ctr + 'b1;

endmodule