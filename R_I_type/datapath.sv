module datapath #( parameter addr_data_width = 32;)
    (input logic [addr_data_width - 1:0] PC,
    output logic [addr_data_width - 1:0] alu_out
);

// fetch 

wire reset1;
wire clk;
program_counter pc1 ((.pc) PC, (.reset) reset1, (.clk) clk1);

logic [addr_data_width -1:0];

instruction_memory imem ((.byte_address) PC, (.instruction)instr_out);

// decode

logic addr_dr;
logic addr_rs1;
logic addr_rs2;
logic wr_data1;
logic rs1_data;
logic rs2_data;

assign addr_dr = instr_out[11:7];
assign addr_rs1 = instr_out[19:15];
assign addr_rs2 = instr_out[24:20];

reg_file r1 ((.wr_addr) addr_dr, (.r_addr1) addr_rs1, (.r_addr2) addr_rs2, (.wr_data) wr_data1, (.r_data1) rs1_data, (.r_data2) rs2_data);

// execute
logic [1:0] sel_op;
alu a1 ((.operand_a) rs1_data, (.operand_b) rs2_data, (.select_op) sel_op, (.result_out) alu_out);


// write back
reg_file r2 ((.wr_addr) addr_dr, (.r_addr1) addr_rs1, (.r_addr2) addr_rs2, (.wr_data) alu_out, (.r_data1) rs1_data, (.r_data2) rs2_data);

    
endmodule