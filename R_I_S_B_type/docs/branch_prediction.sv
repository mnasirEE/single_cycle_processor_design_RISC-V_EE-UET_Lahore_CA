module branch_prediction #(
    parameter data_length = 32
) (
    input logic [data_length - 1:0] num1, num2,
    input logic branch_type, // 6 types BEQ, BNE, BLT, BLTU, BGT, BGTU
    output logic [data_length - 1 : 0] br_taken
);
    
endmodule