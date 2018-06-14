`timescale 1ns / 1ps

interface rv32i_rf_intf(input clk);
    logic [31:0] reg_sel_rs1;
    logic [31:0] reg_sel_rs2;
    logic [31:0] reg_sel_rd;
    logic [31:0] reg_rs1;
    logic [31:0] reg_rs2;
    logic [31:0] reg_rd;
    logic [31:0] pc_out;
    logic [31:0] pc_in;
    logic [31:0] pc_in_vld;
    
    
    modport sys (
        output reg_sel_rs1, reg_sel_rs2, reg_sel_rd,
        reg_rd, pc_in, pc_in_vld,
        input reg_rs1, reg_rs2, pc_out
        );
    
    modport rf(
        input reg_sel_rs1, reg_sel_rs2, reg_sel_rd,
        reg_rd, pc_in, pc_in_vld,
        output reg_rs1, reg_rs2, pc_out
        );
    
    
endinterface