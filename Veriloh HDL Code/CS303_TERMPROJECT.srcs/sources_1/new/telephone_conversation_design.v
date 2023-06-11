`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2022 23:06:07
// Design Name: 
// Module Name: telephone_conversation_design
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


module telephone_conversation_design(clk, rst, startCall, answerCall, endCall, sendChar, charSent, statusMsg, sentMsg);

//inputs
input rst,clk;
input startCall, answerCall;
input endCall;
input sendChar;
input [7:0] charSent;
//outputs
output reg [63:0] statusMsg;
output reg [63:0] sentMsg;

reg [31:0] cost; 
reg [2:0] current_state; 
reg [2:0] next_state;

//states' corresponding binaries
parameter IDLE=3'd0;
parameter RINGING=3'd1;
parameter BUSY=3'd2;
parameter REJECTED=3'd3;
parameter CALLER=3'd4;
parameter COST=3'd5;

reg [3:0] counter;
reg [2:0] ct5;

//counter counts until 10 clock cycles
always @(posedge clk or posedge rst)
    if(rst || endCall || answerCall)
        counter<=0;
        
    else if(current_state==RINGING || current_state==BUSY|| current_state==REJECTED)
            if(counter == 9)
                counter<=0;
            else
                counter <= counter +1;
                
    else
            counter <= counter;

//counter 5
always @(posedge clk or posedge rst)
    if(rst)
        ct5<=0;
        
    else if(current_state==COST)
            if(ct5 ==4)
                ct5 <= 0;
            else
                ct5 <= ct5+1;
                
    else
            ct5 <= ct5;
        
// sequential part - state transitions
always @(posedge clk or posedge rst)
    if(rst)
        current_state <= IDLE;
    else
        current_state<=next_state;


//state changes
always @(*)
    if (current_state == IDLE)
    begin
        statusMsg="IDLE   ";
        sentMsg[63:0]<=0;
        cost[31:0]<=0;
           
        if(startCall)
            next_state <= RINGING;
        else
            next_state<=IDLE;
    end
    
    else if (current_state == RINGING)
    begin
        statusMsg="RINGING ";
              
        if(endCall)
            next_state <=REJECTED;
            
        else if(answerCall)
            next_state<=CALLER;
        
        else if(counter==9)
            next_state<=BUSY;
        
        else
            next_state<=RINGING;
    end
    
    
    else if (current_state == BUSY)
    begin
        statusMsg="BUSY   ";
        
        if(counter== 9)
            next_state<=IDLE;
        else
            next_state<=BUSY;
    end
        
    else if (current_state == REJECTED)
    begin
        statusMsg="REJECTED";
        
        if(counter==9)
            next_state<=IDLE;
        else
            next_state<=REJECTED;
    end
    
    else if (current_state == CALLER)
    begin
        statusMsg="CALLER  ";
        
        if((charSent==8'd127 && sendChar) || endCall)
        begin
                sentMsg[63:0]<=0;
                next_state<=COST;
        end
        else
            next_state<=CALLER; 
    end
    
    
    else if (current_state == COST)
    begin
        statusMsg="COST    ";
        
        if(ct5==4)
            next_state <= IDLE;
        else
            next_state <= COST;
    end
    

always @(*)
begin
    if (current_state == COST)
    begin
        case(cost[3:0])
        4'b0000:
                sentMsg[7:0] = 48;
        4'b0001:
                sentMsg[7:0] = 49;
        4'b0010:
                sentMsg[7:0] = 50;
        4'b0011:
                sentMsg[7:0] = 51;
        4'b0100:
                sentMsg[7:0] = 52;        
        4'b0101:
                sentMsg[7:0] = 53;       
        4'b0110:
                sentMsg[7:0] = 54;
        4'b0111:
                sentMsg[7:0] = 55;
        4'b1000:
                sentMsg[7:0] = 56;
        4'b1001:
                sentMsg[7:0] = 57;
        4'b1010:
                sentMsg[7:0] = 65;
        4'b1011:
                sentMsg[7:0] = 66;        
        4'b1100:
                sentMsg[7:0] = 67;       
        4'b1101:
                sentMsg[7:0] = 68;
        4'b1110:
                sentMsg[7:0] = 69;
        4'b1111:
                sentMsg[7:0] = 70;
        endcase
        
        case(cost[7:4])
        4'b0000:
                sentMsg[15:8] = 48;
        4'b0001:
                sentMsg[15:8] = 49;
        4'b0010:
                sentMsg[15:8] = 50;
        4'b0011:
                sentMsg[15:8] = 51;
        4'b0100:
                sentMsg[15:8] = 52;        
        4'b0101:
                sentMsg[15:8] = 53;       
        4'b0110:
                sentMsg[15:8] = 54;
        4'b0111:
                sentMsg[15:8] = 55;
        4'b1000:
                sentMsg[15:8] = 56;
        4'b1001:
                sentMsg[15:8] = 57;
        4'b1010:
                sentMsg[15:8] = 65;
        4'b1011:
                sentMsg[15:8] = 66;        
        4'b1100:
                sentMsg[15:8] = 67;       
        4'b1101:
                sentMsg[15:8] = 68;
        4'b1110:
                sentMsg[15:8] = 69;
        4'b1111:
                sentMsg[15:8] = 70;
        endcase
        
        case(cost[11:8])
        4'b0000:
                sentMsg[23:16] = 48;
        4'b0001:
                sentMsg[23:16] = 49;
        4'b0010:
                sentMsg[23:16] = 50;
        4'b0011:
                sentMsg[23:16] = 51;
        4'b0100:
                sentMsg[23:16] = 52;        
        4'b0101:
                sentMsg[23:16] = 53;       
        4'b0110:
                sentMsg[23:16] = 54;
        4'b0111:
                sentMsg[23:16] = 55;
        4'b1000:
                sentMsg[23:16] = 56;
        4'b1001:
                sentMsg[23:16] = 57;
        4'b1010:
                sentMsg[23:16] = 65;
        4'b1011:
                sentMsg[23:16] = 66;        
        4'b1100:
                sentMsg[23:16] = 67;       
        4'b1101:
                sentMsg[23:16] = 68;
        4'b1110:
                sentMsg[23:16] = 69;
        4'b1111:
                sentMsg[23:16] = 70;
        endcase
        
        case(cost[15:12])
        4'b0000:
                sentMsg[31:24] = 48;
        4'b0001:
                sentMsg[31:24] = 49;
        4'b0010:
                sentMsg[31:24] = 50;
        4'b0011:
                sentMsg[31:24] = 51;
        4'b0100:
                sentMsg[31:24] = 52;        
        4'b0101:
                sentMsg[31:24] = 53;       
        4'b0110:
                sentMsg[31:24] = 54;
        4'b0111:
                sentMsg[31:24] = 55;
        4'b1000:
                sentMsg[31:24] = 56;
        4'b1001:
                sentMsg[31:24] = 57;
        4'b1010:
                sentMsg[31:24] = 65;
        4'b1011:
                sentMsg[31:24] = 66;        
        4'b1100:
                sentMsg[31:24] = 67;       
        4'b1101:
                sentMsg[31:24] = 68;
        4'b1110:
                sentMsg[31:24] = 69;
        4'b1111:
                sentMsg[31:24] = 70;
        endcase        

        case(cost[19:16])
        4'b0000:
                sentMsg[39:32] = 48;
        4'b0001:
                sentMsg[39:32] = 49;
        4'b0010:
                sentMsg[39:32] = 50;
        4'b0011:
                sentMsg[39:32] = 51;
        4'b0100:
                sentMsg[39:32] = 52;        
        4'b0101:
                sentMsg[39:32] = 53;       
        4'b0110:
                sentMsg[39:32] = 54;
        4'b0111:
                sentMsg[39:32] = 55;
        4'b1000:
                sentMsg[39:32] = 56;
        4'b1001:
                sentMsg[39:32] = 57;
        4'b1010:
                sentMsg[39:32] = 65;
        4'b1011:
                sentMsg[39:32] = 66;        
        4'b1100:
                sentMsg[39:32] = 67;       
        4'b1101:
                sentMsg[39:32] = 68;
        4'b1110:
                sentMsg[39:32] = 69;
        4'b1111:
                sentMsg[39:32] = 70;
        endcase

        case(cost[23:20])
        4'b0000:
                sentMsg[47:40] = 48;
        4'b0001:
                sentMsg[47:40] = 49;
        4'b0010:
                sentMsg[47:40] = 50;
        4'b0011:
                sentMsg[47:40] = 51;
        4'b0100:
                sentMsg[47:40] = 52;        
        4'b0101:
                sentMsg[47:40] = 53;       
        4'b0110:
                sentMsg[47:40] = 54;
        4'b0111:
                sentMsg[47:40] = 55;
        4'b1000:
                sentMsg[47:40] = 56;
        4'b1001:
                sentMsg[47:40] = 57;
        4'b1010:
                sentMsg[47:40] = 65;
        4'b1011:
                sentMsg[47:40] = 66;        
        4'b1100:
                sentMsg[47:40] = 67;       
        4'b1101:
                sentMsg[47:40] = 68;
        4'b1110:
                sentMsg[47:40] = 69;
        4'b1111:
                sentMsg[47:40] = 70;
        endcase        
        
        case(cost[27:24])
        4'b0000:
                sentMsg[55:48] = 48;
        4'b0001:
                sentMsg[55:48] = 49;
        4'b0010:
                sentMsg[55:48] = 50;
        4'b0011:
                sentMsg[55:48] = 51;
        4'b0100:
                sentMsg[55:48] = 52;        
        4'b0101:
                sentMsg[55:48] = 53;       
        4'b0110:
                sentMsg[55:48] = 54;
        4'b0111:
                sentMsg[55:48] = 55;
        4'b1000:
                sentMsg[55:48] = 56;
        4'b1001:
                sentMsg[55:48] = 57;
        4'b1010:
                sentMsg[55:48] = 65;
        4'b1011:
                sentMsg[55:48] = 66;        
        4'b1100:
                sentMsg[55:48] = 67;       
        4'b1101:
                sentMsg[55:48] = 68;
        4'b1110:
                sentMsg[55:48] = 69;
        4'b1111:
                sentMsg[55:48] = 70;
       endcase 
          
       case(cost[31:28])
        4'b0000:
                sentMsg[63:56] = 48;
        4'b0001:
                sentMsg[63:56] = 49;
        4'b0010:
                sentMsg[63:56] = 50;
        4'b0011:
                sentMsg[63:56] = 51;
        4'b0100:
                sentMsg[63:56] = 52;        
        4'b0101:
                sentMsg[63:56] = 53;       
        4'b0110:
                sentMsg[63:56] = 54;
        4'b0111:
                sentMsg[63:56] = 55;
        4'b1000:
                sentMsg[63:56] = 56;
        4'b1001:
                sentMsg[63:56] = 57;
        4'b1010:
                sentMsg[63:56] = 65;
        4'b1011:
                sentMsg[63:56] = 66;        
        4'b1100:
                sentMsg[63:56] = 67;       
        4'b1101:
                sentMsg[63:56] = 68;
        4'b1110:
                sentMsg[63:56] = 69;
        4'b1111:
                sentMsg[63:56] = 70;
        endcase
    end
end


//cost calculation
always @(posedge sendChar) 
begin
    if(current_state == CALLER)
    begin
        if(8'd32<=charSent && charSent<=8'd126) 
        begin
            if(8'd48<=charSent && charSent<=8'd57)
                cost<=cost+1;
            
            else
                cost<=cost+2;
        end
    
        else if (charSent==8'd127)
            cost<=cost+2;
        
        else
            cost<=cost;
    end
end

//shift register for sentMsg
always @(posedge sendChar)
begin
    if(8'd32<=charSent && charSent<=8'd126 && current_state == CALLER)
    begin
        sentMsg[7:0]<=charSent;
        sentMsg[15:8]<=sentMsg[7:0];
        sentMsg[23:16]<=sentMsg[15:8];
        sentMsg[31:24]<=sentMsg[23:16];
        sentMsg[39:32]<=sentMsg[31:24];
        sentMsg[47:40]<=sentMsg[39:32];
        sentMsg[55:48]<=sentMsg[47:40];
        sentMsg[63:56]<=sentMsg[55:48];
     end
end
endmodule
