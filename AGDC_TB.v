`timescale 1ns/1ps
module AGC_TB ();

reg Up_Max_TB,Dn_Max_TB;
reg Activate_TB;
reg CLK_TB;
reg RST_TB;
wire UP_M_TB;
wire DN_M_TB;


parameter CLOCK_Period=20;

initial 
 begin
   
 // Save Waveform
   $dumpfile("AGC.vcd") ;       
   $dumpvars; 
 

 // initialization
     Initial();


 // Reset
    reset();
   
 // Input Sequence
   OPera(5'b10010,5'b01101,5'b11111);
   
   #100 ;
    $stop;
   end
  

                                     

////////////////////////////////////////////////
always #CLOCK_Period CLK_TB= ~CLK_TB;
////////////////////////////////////////////////





///////////////////////////////////////////////////////
task OPera (
input [4:0] Up_Max_sesnor,
input [4:0] Dn_Max_sesnor,
input [4:0] Activ
);

integer i;

begin
 for(i=0;i<5;i=i+1)
	begin
	 @(negedge CLK_TB)
	  Up_Max_TB   = Up_Max_sesnor[i];
	  Activate_TB = Activ[i];
	  Dn_Max_TB   = Dn_Max_sesnor[i];
	end
end
endtask 
/////////////////////////////////////////////////////




/////////////////////////////////////////////////////////
task Initial;
 begin
	CLK_TB       =1'b0;
	Activate_TB  =1'b0;
	Up_Max_TB    =1'b0;
	Dn_Max_TB	 =1'b0;
 end
endtask
////////////////////////////////////////////////////////////




/////////////////////////////////////////////////////////////////
task reset ;
begin
	RST_TB=1'b1;
	# CLOCK_Period
	RST_TB=1'b0;
	# CLOCK_Period
	RST_TB=1'b1;
end 
endtask
/////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////
Automatic_Garage_Door_Controller DUT (
.Up_Max   (Up_Max_TB),
.Dn_Max	  (Dn_Max_TB),
.Activate (Activate_TB),
.CLK 	  (CLK_TB),
.RST 	  (RST_TB),
.UP_M	  (UP_M_TB),
.DN_M 	  (DN_M_TB)
);
/////////////////////////////////////////////////////////////////////////
endmodule

