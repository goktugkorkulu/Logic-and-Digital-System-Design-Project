`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2022 23:08:56
// Design Name: 
// Module Name: telephone_conversation_simulation
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

module telephone_conversation_simulation();
reg rst,clk;
reg startCall, answerCall;
reg endCall;
reg sendChar;
reg [7:0] charSent;
wire [63:0] statusMsg;
wire  [63:0] sentMsg;

telephone_conversation_design mytel(clk, rst, startCall, answerCall, endCall,sendChar,charSent, statusMsg, sentMsg);

always #5 clk=~clk;

initial begin
   
    clk=0;
    rst=0;
    startCall = 0;
    endCall =  0;
    answerCall = 0;
    sendChar = 0;
    charSent = 0;
    #3;     
    rst=1;
    #10;
    rst=0;
    #10;
    startCall=1;
    #10;
    startCall=0;
    #200    //waits for get BUSY nad return IDLE
    startCall=1;
    #10;
    startCall=0;
    #20;
    endCall=1;
    #10;
    endCall=0;
    #120
    startCall = 1;
    #10 
    startCall = 0;
    #20
    answerCall = 1;
    #10 
    answerCall = 0;
    
    #10;
    charSent=8'd67;     //c
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd83;     //s
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd51;     //3
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd48;     //0
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd51;     //3
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd32;     //space
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd16;     //dummy, not in range
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd80;     //p
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd114;    //r
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    
    #10;
    charSent=8'd111;    //o
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;  
    charSent=8'd106;    //j
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd101;    //e
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd99;     //c
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd116;    //t
    #10;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd127;    //DEL
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #65;
    startCall = 1;
    #10;
    startCall = 0;
    
    #10 
    answerCall = 1;
    #5
    answerCall = 0;
    
    #7;
    charSent=8'd72;    //H
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #10;
    charSent=8'd105;    //i
    #5;
    sendChar=1;
    #5;
    sendChar=0;
    
    #9
    endCall = 1;
    charSent = 0;
    #5
    endCall = 0;
    
    end
endmodule
