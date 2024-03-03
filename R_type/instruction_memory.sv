// 2kB = 2048B = 
// byte addressable, // word alligned

module instruction_memory #(parameter addr_ins_width = 32, memory_width = 8, memory_height = 2048 ;)
    ( input logic [addr_ins_width-1:0] byte_address,
    output logic [addr_ins_width-1:0] instruction

    
);

reg [memory_width - 1:0] inst_mem [memory_height -1:0];

initial begin
    $readmemh("read_instructions.txt", inst_mem);
end

// Concatenate bytes to form a word
assign instruction = {memory[byte_address * 4 +: 4]};
    
endmodule