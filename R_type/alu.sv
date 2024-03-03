module alu (
    input logic [31:0] operand_a, operand_b,
    input logic [3:0] select_op,
    output logic [31:0] result_out
);

always @(*)
    case (select_op)
       4'b0000 : result_out = operand_a + operand_b;
       4'b0001 : result_out = operand_a - operand_b;
       4'b0010 : result_out = $signed(operand_a) + $signed(operand_b);
       4'b0011 : result_out = $signed(operand_a) - $signed(operand_b);
       default: result_out = operand_a + operand_b;
    endcase
    
endmodule