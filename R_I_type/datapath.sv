module datapath #( parameter addr_data_width = 32;)
    (input logic [addr_data_width - 1:0] PC,
    output logic [addr_data_width - 1:0] alu_out
);

// fetch 

wire reset1;
wire clk1;
program_counter pc1 (.pc(PC), .reset(reset1), .clk (clk1));

logic [addr_data_width -1:0];

instruction_memory imem (.byte_address(PC), .instruction(instr_out));

logic wr_enable;
logic [4:0] alu_ope;
logic sel_B;

// controller 
controller c (.instruction(instr_out), .alu_op(alu_ope), .regfile_write_enable(wr_enable), .sel_b(sel_B));

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

reg_file r1 (.wr_addr (addr_dr), .r_addr1 (addr_rs1), .r_addr2 (addr_rs2), .wr_data (wr_data1), .r_data1 (rs1_data), .r_data2 (rs2_data));

// imm gene
imm(.inst(instr_out), .imm(imm_out));
// execute
mux_2x1 m1 (.in0(rs1_data), .in1(imm_out), .sel(sel_B), .mux_out(data_2));
alu a1 (.operand_a (rs1_data), .operand_b (data_2), .select_op (alu_ope), .result_out (alu_out));

data_memory dm1 (.clk(clk1),.wr_en(), .r_en(read_en), .data_in(), .addr(alu_out), .data_out(memdata_out));
// mux

mux_2x1 m2 (.in0(alu_out), .in1(memdata_out), .sel(wb_sel), .mux_out(wb_data));
// write back
reg_file r2 (.wr_addr (addr_dr), .r_addr1 (addr_rs1), .r_addr2 (addr_rs2), .wr_data (wb_data),.write_back_en(wr_enable), .r_data1 (rs1_data), .r_data2 (rs2_data));

    
endmodule