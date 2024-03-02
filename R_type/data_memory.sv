module data_memory (
    input wire clk,
    input wire reset
);

    // reg [31:0] ex2_memory [0:31]; // Memory for reading from file
    reg [31:0] ex1_memory [0:31]; // Memory for writing to file
    
    // Reading from file
    initial begin
        $readmemh("datamem.txt", ex1_memory);
    end
    
    // Writing to file on positive clock edge
    always_ff @ (posedge clk) begin
        $writememh("ex2.txt", ex1_memory);
    end

endmodule