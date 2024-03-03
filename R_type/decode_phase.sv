module decode_phase #(parameter addr_width = 5, data_width = 32;)
    (
    input logic [addr_width - 1:0] addr_wr, addr_rs1, addr_rs2,
    input logic [data_width - 1:0] destination_reg,
    output logic [data_width - 1:0] source_reg1, source_reg2
);

reg_file rf1 ((.wr_addr) addr_wr, (.r_addr1) addr_rs1, (.r_addr2) addr_rs2, (.wr_data) destination_reg, (.r_data1) source_reg1, (.r_data2) source_reg2);
    
endmodule