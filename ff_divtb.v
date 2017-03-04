//////////////////////////////////////////////////////////////////////
// Created by Actel SmartDesign Fri Mar 03 03:12:04 2017
// Testbench Template
// This is a basic testbench that instantiates your design with basic 
// clock and reset pins connected.  If your design has special
// clock/reset or testbench driver requirements then you should 
// copy this file and modify it. 
//////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: ff_divtb.v
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

`timescale 1ns / 100ps

module ff_divtb;

	reg clock;
	
	// Inputs
	reg[7:0] dividend, divisor;
	
	// Outputs
	wire[17:0] out;

	
	always #1 clock = ~clock; // Toggle clock every 1 tick

	initial
	begin
		clock 		<= 0;
		dividend 	<= 8'b00001011;
		divisor 	<= 8'b00000110;
	end

	//////////////////////////////////////////////////////////////////////
	// Instantiate Unit Under Test:  ffamuldivinv
	//////////////////////////////////////////////////////////////////////
	ffamuldivinv ffamuldivinv_0 (
    	// Inputs
    	clock,
    	dividend,
    	divisor,

    	// Outputs
    	out
);

endmodule

