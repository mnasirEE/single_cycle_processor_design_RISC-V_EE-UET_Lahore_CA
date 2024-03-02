module alu (
    input logic [31:0] operand_a, operand_b,
    input logic [1:0] select_op,
    output logic [31:0] result_out
);

always @(*)
    case (select_op)
       2'b00 : result_out = operand_a + operand_b;
       2'b01 : result_out = operand_a - operand_b;
       2'b10 : result_out = $signed(operand_a) + $signed(operand_b);
       2'b11 : result_out = $signed(operand_a) - $signed(operand_b);
       default: result_out = operand_a + operand_b;
    endcase
    
endmodule