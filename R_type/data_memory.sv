module data_memory (
    input wire clk,
    input wire reset
);
     // byte alligned, word addressable
    // reg [31:0] ex2_memory [0:31]; // Memory for reading from file
    reg [31:0] ram_memory [31:0]; // Memory for writing to file
    
    // Reading from file
    initial begin
        $readmemh("read_from.txt", ram_memory);
    end
    
    // Writing to file on positive clock edge
    always_ff @ (posedge clk) begin
        $writememh("write_in.txt", ram_memory);
    end

endmodule

// if (write_enable) begin
//                 // Write data to memory
//                 memory[byte_address] <= data_in[7:0];
//                 memory[byte_address + 1] <= data_in[15:8];
//                 memory[byte_address + 2] <= data_in[23:16];
//                 memory[byte_address + 3] <= data_in[31:24];
//             end