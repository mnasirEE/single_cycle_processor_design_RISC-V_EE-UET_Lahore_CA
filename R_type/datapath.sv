module datapath #( parameter addr_data_width = 32)
    (output logic [addr_data_width - 1:0] PC,
    input logic reset1, clk1,
    output logic [addr_data_width-1:0] alu_out

);

// fetch 

always_ff @(posedge clk1, posedge reset1)
    if (reset1)
        PC <= 0;
    else
        PC <= PC + 1;

logic [addr_data_width -1:0] instr_out;

instruction_memory imem (.address(PC),
                         .instruction(instr_out));

// reg [31:0] inst_mem [0:511];

// assign inst_mem[0] = 32'h004182b3;
// assign inst_mem[1] = 32'h40418333;
// assign inst_mem[2] = 32'h004193b3;
// assign inst_mem[3] = 32'h0041c433;
// assign inst_mem[4] = 32'h0041d4b3;
// assign inst_mem[5] = 32'h0041e533;
// assign inst_mem[6] = 32'h0041f5b3;

// initial begin
//     $readmemh("read_instructions.txt", inst_mem);
// end

// assign instr_out = inst_mem[PC];
// assign instr_out = 32'h004182b3;

logic [3:0] alu_operation;
logic wr_enable;
controller c1 (.instruction(instr_out), 
                .alu_op(alu_operation), 
                .regfile_write_enable(wr_enable));

// decode

logic [4:0] addr_dr, addr_rs1, addr_rs2;
logic [addr_data_width - 1:0] rs1_data, rs2_data;

assign addr_dr = instr_out[11:7];
assign addr_rs1 = instr_out[19:15];
assign addr_rs2 = instr_out[24:20];

reg_file r1 (.wr_addr(addr_dr), 
            .r_addr1(addr_rs1), 
            .r_addr2(addr_rs2), 
            .wr_data (alu_out), 
            .write_back_en(wr_enable),
            .clk(clk1),
            .r_data1 (rs1_data), 
            .r_data2 (rs2_data));

// execute

alu a1 (.operand_a(rs1_data), 
        .operand_b(rs2_data), 
        .select_op(alu_operation), 
        .result_out (alu_out));


// write back
// reg_file r2 ((.wr_addr) addr_dr, (.r_addr1) addr_rs1, (.r_addr2) addr_rs2, (.wr_data) alu_out, (.r_data1) rs1_data, (.r_data2) rs2_data);

    
endmodule