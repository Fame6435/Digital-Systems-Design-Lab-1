`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2024 11:05:12 AM
// Design Name: 
// Module Name: slw_clk
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//<slw_clk><count1>(<>);

module top(
    input CLK,
    output SCLK,
    input sw0,
    input sw1,
    output led0,
    input sw3,
    input sw4,
    output led1,
    input btnu,
    input btnd,
    output led2,
    output led3
    );
    
    andgate cond(.sw0(sw0), .sw1(sw1), .led0(led0)); // Run andgate module as condition 1
    orgate cond2(.sw3(sw3), .sw4(sw4), .led1(led1));// Run orgate module as condition 2
    xornor cond3(.btnu(btnu), .btnd(btnd), .led2(led2), .led3(led3));// Run xornor module as condition 3
    slw_clk cond4(.CLK(CLK), .SCLK(SCLK)); // Run slw_clk module as condition 4
    
endmodule

// Module 
module slw_clk(
    input CLK, 
    output reg SCLK
    );
    reg [26:0] count=0; // 27 bits for count lowercase for internal variables
    always@(posedge CLK)
        if (count<50000000)
            count<=count+1;
        else 
            begin
                count<=0;
                SCLK <=~SCLK;
            end    
endmodule

// Inverted Test Module
module INV_TB(
    );
    reg Atest;
    wire Btest;
    INV UUT (.A(Atest),.B(Btest));
    initial
    begin
            Atest=1;
        #5  Atest=0;
        #5  Atest=1;
        #5;
        $finish;
    end
endmodule

// Condition 1 AND gate for LED0  
module andgate(
    input sw0,
    input sw1,
    output reg led0
    );
   always@* led0=sw0&&sw1;
endmodule

// Condition 2 OR gate for LED1
module orgate (
    input sw3,
    input sw4,
    output reg led1
    );
    always@* led1=sw3||sw4;
endmodule

//Condition 3 
module xornor (
    input btnu,
    input btnd,
    output reg led2,
    output reg led3
    );
    always@*
    begin
        led2=btnu^btnd;
        led3=btnu~^btnd;
    end        
endmodule

