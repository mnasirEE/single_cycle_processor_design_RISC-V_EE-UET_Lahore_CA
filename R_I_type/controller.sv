module controller #(parameter instr_width = 32, alu_op_width = 5;)
    ( input logic [instr_width - 1:0] instruction,
    output logic [alu_op_width -1:0] alu_op,
    output logic regfile_write_enable,
    output logic sel_b
    
);

logic [6:0] opcode;
logic [2:0] func3;
logic [6:0] func7;
assign opcode = instruction[6:0];
assign func3 = [14:12];
assign func7 = [31:25];

logic [5:0] add, sub, sll, slt, sltu, Xor, srl, sra, or, And;
initial begin
    add = 00000;
    sub = 00001;
    sll = 00010;
    slt = 00011;
    sltu = 00100;
    Xor = 00101;
    srl = 00110;
    sra = 00111;
    or = 01000;
    And = 01001;
end

// generating alu_op signals
always @ (*)
    case (opcode)
        7'b0110011 : begin
            case (func3)
                3'b000: begin
                    case (func7)
                        7'b0000000: alu_op = add;
                        7'b0100000; alu_op = sub; 
                        default: 
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
                        default: 
                    endcase
                3'b110 : alu_op = or; // or
                3'b111 : alu_op = And; // and
                end
                
                default: 
            endcase
        7'b0000011 : begin
            case (func3)
                : 
                default: 
            endcase
        end
        end
        default: 
    endcase

// generating write back enable signal   
always_ff @(negedge clk)
    regfile_write_enable <= 1;
    
endmodule

// controller c (.instruction(), .alu_op(), .regfile_write_enable(), .sel_b());