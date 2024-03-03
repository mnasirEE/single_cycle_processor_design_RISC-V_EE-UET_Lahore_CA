module reg_file #(parameter reg_addr_width = 5, reg_data_width = 32, reg_depth = 4;)
    ( input logic [reg_addr_width -1:0] wr_addr, r_addr1, r_addr2, wr_data,
    output logic [reg_data_width - 1:0] r_data1, r_data2
);

reg [reg_data_width - 1:0] reg_file_16 [reg_depth - 1:0];

assign reg_file_16[0] = 0; // x0 = 0 hard wire

// reading data asynchrounous
initial begin
    r_data1 = reg_file_16[r_addr1];
    r_data2 = reg_file_16[r_addr2];
end
    
endmodule