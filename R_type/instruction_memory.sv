// 2kB = 2048B = 
// byte addressable, // word alligned

module instruction_memory #(parameter addr_ins_width = 32, memory_width = 32, memory_height = 512)
    ( input logic [addr_ins_width-1:0] address,
    output logic [addr_ins_width-1:0] instruction

    
);
// reg [31:0] mem [0:511]
reg [memory_width - 1:0] inst_mem [0:memory_height -1];

assign inst_mem[0] = 32'h004182b3;
assign inst_mem[1] = 32'h40418333;
assign inst_mem[2] = 32'h004193b3;
assign inst_mem[3] = 32'h0041c433;
assign inst_mem[4] = 32'h0041d4b3;
assign inst_mem[5] = 32'h0041e533;
assign inst_mem[6] = 32'h0041f5b3;

// initial begin
//     $readmemh("read_instructions.txt", inst_mem);
// end



assign instruction = inst_mem[address];
endmodule