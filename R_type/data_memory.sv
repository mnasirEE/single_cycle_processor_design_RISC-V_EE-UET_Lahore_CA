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