module alu (
    input logic [31:0] operand_a, operand_b,
    input logic [4:0] select_op,
    output logic [31:0] result_out
);

always @(*)
    case (select_op)
       5'b00000 : result_out = operand_a + operand_b;
       5'b00001 : result_out = operand_a - operand_b;
       5'b00010 : result_out = $signed(operand_a) + $signed(operand_b);
       5'b00011 : result_out = $signed(operand_a) - $signed(operand_b);
       default: result_out = operand_a + operand_b;
    endcase
    
endmodule