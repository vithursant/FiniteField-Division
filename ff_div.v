///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: ff_div.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::Fusion> <Die::M1AFS1500> <Package::484 FBGA>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

`timescale 1ns / 1ps

module ffamuldivinv(
 input              clock,
 input      [7:0]   dividend,
 input      [7:0]   divisor,
 output reg [17:0]   out );

 always @(posedge clock)
 begin
 	out = finitefieldarth_div(dividend, divisor);
 end
     
 // Division operation: Results both Quotient[17:9] & Remainder[8:0] in same register
 function [17:0] finitefieldarth_div;  
    input [8:0] operdA;	// Dividend
    input [8:0] operdB;	// Divisor
  
    reg  [8:0] quotient;	// Quotient
    reg  [8:0] remainder;	// Remainder
    reg  [8:0] temp_result;
    reg  [3:0] degA;
    reg  [3:0] degr;
  
    reg  [3:0] div_count;
    reg  [3:0] deg_count;
  
    begin
        quotient  = 8'h0;	// Initialize the quotient
        remainder = operdA;	// Set remainder to be the dividend
   
        for(div_count = 0; div_count < 8 ; div_count = div_count + 1)           // Logic generated for upto 8 cycles
        begin                                                                   // Considering the worst operation
            deg_count = (polytoleadterm(remainder) - polytoleadterm(operdB));	// Get your degree count
            if(polytoleadterm(remainder) >= polytoleadterm(operdB))             // Checking whether rem > divisor
            begin
                temp_result  = leadtermtopoly(deg_count);						// Temporary result is the polynomial of the degree count
                quotient     = quotient ^ temp_result;
                remainder    = remainder ^ (operdB << deg_count);
            end
            else
            begin
                temp_result  = temp_result;
                quotient     = quotient;
                remainder    = remainder;
            end
        end
        finitefieldarth_div = {quotient, remainder}; // Quotient & Remainder;
    end
 endfunction


 // Function to findout the leading term in the polynomial
 function [3:0] polytoleadterm;  
    input [8:0] operlA;
    begin
        casez (operlA)
            9'b1???????? : polytoleadterm = 4'h9;
            9'b01??????? : polytoleadterm = 4'h8;
            9'b001?????? : polytoleadterm = 4'h7;
            9'b0001????? : polytoleadterm = 4'h6;
            9'b00001???? : polytoleadterm = 4'h5;
            9'b000001??? : polytoleadterm = 4'h4;
            9'b0000001?? : polytoleadterm = 4'h3;
            9'b00000001? : polytoleadterm = 4'h2;
            9'b000000001 : polytoleadterm = 4'h1;
            default      : polytoleadterm = 4'h0;
        endcase
    end
 endfunction
 
 // Function to derive polynomial from leading term.
 function [8:0] leadtermtopoly;
    input [3:0] operlA;
    begin
        case (operlA)
            4'h8 : leadtermtopoly = 9'b100000000;
            4'h7 : leadtermtopoly = 9'b010000000;
            4'h6 : leadtermtopoly = 9'b001000000;
            4'h5 : leadtermtopoly = 9'b000100000;
            4'h4 : leadtermtopoly = 9'b000010000;
            4'h3 : leadtermtopoly = 9'b000001000;
            4'h2 : leadtermtopoly = 9'b000000100;
            4'h1 : leadtermtopoly = 9'b000000010;
            4'h0 : leadtermtopoly = 9'b000000001;
            default : leadtermtopoly= 9'b000000000;
        endcase
    end
 endfunction
endmodule

