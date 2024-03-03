module program_counter #(parameter counter_width = 32 ;)
    ( output logic [31:0] pc,
    input logic reset,
    input logic clk
    
);

always_ff @(posedge clk, posedge reset)
    if (reset)
        pc = 0;
    else
        pc = pc + 4;


    
endmodule