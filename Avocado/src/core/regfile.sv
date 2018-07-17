`timescale 1ns / 1ps
module regfile 
#(
    parameter [31:0] PC_INIT_ADDR=32'h0000_0000
)    
(
    input clk,
    input rst_n,
    rv32i_rf_intf.rf rf_intf 
);
logic [31:0] x[31:0];
logic [31:0] pc;
logic [31:0] reg_rs1_out;
logic [31:0] reg_rs2_out;

generate
genvar i;
for(i=1;i<32;i++) begin:reg_x
    always_ff @(posedge clk or negedge rst_n)
        if(~rst_n)
            x[i] <= 32'h0;
        else if(rf_intf.reg_sel_rd[i])
            x[i] <= rf_intf.reg_rd;
end
endgenerate

always_comb begin
    reg_rs1_out = 32'h0;
    reg_rs2_out = 32'h0;
    for(int j=1;j<32;j++) begin
        if(rf_intf.reg_sel_rs1[j])
            reg_rs1_out |= x[j];
        if(rf_intf.reg_sel_rs2[j])
            reg_rs2_out |= x[j];
    end        
end
assign rf_intf.reg_rs1 = reg_rs1_out;
assign rf_intf.reg_rs2 = reg_rs2_out;


always_ff @(posedge clk or negedge rst_n)
    if(~rst_n)
        pc <= PC_INIT_ADDR;
    else if(rf_intf.pc_in_vld)
        pc <= rf_intf.pc_in;
 
assign rf_intf.pc_out = pc; 

endmodule
