module instruction_fetch_phase #(parameter addr_instr_width = 32;)
    ( input logic [addr_instr_width - 1:0] PC,
    output logic [addr_instr_width - 1:0] instr_out
);

wire reset1;
wire clk1;
program_counter pc1 ((.pc)PC,(.reset)reset1, (.clk)clk1 );

instruction_memory((.byte_address)PC, (.instruction)instr_out);

    
endmodule