module imm_gene (
    input logic [31:0] inst,
    output logic [31:0] imm_out
);

logic [6:0] opcode;
assign opcode = inst[6:0];
logic [11:0] imm;

always @(*) begin
    case (opcode)
        7'b0000011 : imm = inst[31:20];
        7'b0010011 : imm = inst[31:20];
        default:  imm = inst[31:20]; 
    endcase
end

assign imm_out[11:0] = imm;
// sign extension
always @(*) begin
    if (imm[11] == 0) begin
        imm_out[31:12] = 20'h00000;
    end
    else // begin
        imm_out[31:12] = 20'hFFFFF;
    // end
end
     
endmodule

// imm_gene immg1 (.inst(), .imm_out());