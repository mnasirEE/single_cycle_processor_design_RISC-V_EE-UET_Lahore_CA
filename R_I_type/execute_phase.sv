module execute_phase #(parameter data_width = 32 ;)
    (
    input logic [data_width - 1:0] input1, input2,
    input logic [3:0] alu_op,
    output logic [data_width - 1 :0] alu_result
);

alu a1 ((.operand_a) input1, (.operand_b) input2, (.select_op) alu_op, (.result_out) alu_result);

    
endmodule