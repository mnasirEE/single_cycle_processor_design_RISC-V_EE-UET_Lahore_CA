module imm_gene (
    input logic [31:0] inst,
    output logic [11:0] imm
);

logic [6:0] opcode;
assign opcode = inst[6:0];


always @(*) begin
    case (opcode)
        7'b0000011 : imm = inst[31:20];
        7'b0010011 : imm = inst[31:20];
        default: 
    endcase
end
     
endmodule

// imm(.inst(), .imm());