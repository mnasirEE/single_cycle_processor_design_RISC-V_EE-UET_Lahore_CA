
// controller c1 (.instruction(), .alu_op(), .regfile_write_enable());
module controller #(parameter instr_width = 32, alu_op_width = 4;)
    ( input logic [instr_width - 1:0] instruction,
    output logic [alu_op_width -1:0] alu_op,
    output logic regfile_write_enable
    
);

logic [6:0] opcode;
logic [2:0] func3;
logic [6:0] func7;
assign opcode = instruction[6:0];

logic [3:0] add, sub, sll, slt, sltu, Xor, srl, sra, or, And;
initial begin
    add = 4'b0000;
    sub = 4'b0001;
    sll = 4'b0010;
    slt = 4'b0011;
    sltu = 4'b0100;
    Xor = 4'b0101;
    srl = 4'b0110;
    sra = 4'b0111;
    or = 4'b1000;
    And = 4'b1001;
end

// generating alu_op signals 
// R_type
always @ (*)
    case (opcode)
        7'b0110011 : begin
            case (func3)
                3'b000: begin
                    case (func7)
                        7'b0000000: alu_op = add;
                        7'b0100000; alu_op = sub; 
                        default: alu_op = 4'b0000;
                    endcase
                3'b001 : alu_op = sll; // shift left logical
                3'b010 : alu_op = slt; // set less than
                3'b011 : alu_op = sltu; // set less than unsigned
                3'b100 : alu_op = Xor; // xor
                
                end
                3'b101 : begin
                    case (func7)
                        7'b0000000: alu_op = srl; // shift right logical
                        7'b0100000: alu_op = sra; // shift right arithmetic
                        default: alu_op = 4'b0000;
                    endcase
                3'b110 : alu_op = or; // or
                3'b111 : alu_op = And; // and
                end
                
                default: alu_op = 4'b0000;
            endcase
        end
        default: alu_op = 4'b0000;
    endcase

always @(*) begin 
    case (opcode)
        7'b0110011: regfile_write_enable = 1'b1; // R_type
        default: regfile_write_enable = 1'b0; // for not write back instructions
    endcase
end
    
endmodule