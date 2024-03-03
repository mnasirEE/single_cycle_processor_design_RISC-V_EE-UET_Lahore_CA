// byte addressable 
// word alligned

module data_memory #(parameter addr_data_width = 32, memory_width = 8, memory_height = 2048 ;)
    (input wire clk,
    input wire wr_en,
    input logic r_en,
    input logic data_in,
    input logic [addr_data_width-1:0] addr,
    output logic [addr_data_width-1:0]data_out
);
     // byte alligned, word addressable
    // reg [31:0] ex2_memory [0:31]; // Memory for reading from file
    reg [memory_width - 1:0] ram_memory [memory_height - 1:0]; // Memory for writing to file
    
    // Reading from file
    initial begin
        
        $readmemh("read_from.txt", ram_memory);
        if (r_en)
            // Concatenate bytes to form a word
            data_out = {ram_memory[addr+: 4]};
    end
    
    // Writing to file on positive clock edge
    always_ff @ (posedge clk, posedge wr_en) begin
        if (wr_en)
            $writememh("write_in.txt", ram_memory);
            //Write data to memory
            memory[byte_address] <= data_in[7:0];
            memory[byte_address + 1] <= data_in[15:8];
            memory[byte_address + 2] <= data_in[23:16];
            memory[byte_address + 3] <= data_in[31:24];
    end

endmodule

// if (write_enable) begin
//                 // Write data to memory
//                 memory[byte_address] <= data_in[7:0];
//                 memory[byte_address + 1] <= data_in[15:8];
//                 memory[byte_address + 2] <= data_in[23:16];
//                 memory[byte_address + 3] <= data_in[31:24];
//             end

// Concatenate bytes to form a word
// assign instruction = {memory[byte_address * 4 +: 4]};