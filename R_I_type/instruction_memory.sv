// 2kB = 2048B = 
// byte addressable, // word alligned

module instruction_memory #(parameter addr_ins_width = 32, memory_width = 32, memory_height = 512)
    ( input logic [addr_ins_width-1:0] address,
    output logic [addr_ins_width-1:0] instruction

    
);

reg [memory_width - 1:0] inst_mem [0:memory_height -1];

// R_type instructions machine encoding - rs1 = x3, rs2 = x4, rd = x5,6,7,8,9,10,11
assign inst_mem[0] = 32'h004182b3;
assign inst_mem[1] = 32'h40418333;
assign inst_mem[2] = 32'h004193b3;
assign inst_mem[3] = 32'h0041c433;
assign inst_mem[4] = 32'h0041d4b3;
assign inst_mem[5] = 32'h0041e533;
assign inst_mem[6] = 32'h0041f5b3;

// I_type instructions Machine encoding - rs1 = x1, rs2 = x4, rd = x12,13,14,15,16,17,18
assign inst_mem[7] = 32'h0020a603;
assign inst_mem[8] = 32'h00108693;
assign inst_mem[9] = 32'h00209713;
assign inst_mem[10] = 32'h0030c793;
assign inst_mem[11] = 32'h0040d813;
assign inst_mem[12] = 32'h0050e893;
assign inst_mem[13] = 32'h0060f913;


// initial begin
//     $readmemh("read_instructions.txt", inst_mem);
// end



assign instruction = inst_mem[address];
endmodule