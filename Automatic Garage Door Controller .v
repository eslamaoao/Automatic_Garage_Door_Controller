module Automatic_Garage_Door_Controller 
(
input wire Up_Max,Dn_Max,
input wire Activate,
input wire CLK,
input wire RST,
output reg UP_M,
output reg DN_M
);



localparam [2:0]       IDLE= 3'b001,
					   Mv_Dn= 3'b010,
					   Mv_Up= 3'b100;
					   
reg    [2:0] current_state,next_state ;
					  
always@(posedge CLK or negedge RST)
 begin
	if(!RST)
		begin
			current_state <= IDLE ;
		end
	else
		begin
			current_state <= next_state ;
		end
 end

always @(*)
 begin
  case(current_state)
  IDLE      : begin
              if(Activate && Up_Max && !Dn_Max)
				next_state = Mv_Dn ;
              else if (Activate && !Up_Max && Dn_Max)
				next_state = Mv_Up ;	
			  else
				next_state = IDLE ;	
             end
  Mv_Dn     : begin
              if(Dn_Max)
				next_state = IDLE ;
              else
				next_state = Mv_Dn ;	   
			  end
  Mv_Up     : begin
              if(Up_Max)
				next_state = IDLE ;
              else
				next_state = Mv_Up ;	    
            end
  
  default :   	next_state = IDLE ;		 
  
  endcase
end	


// next_state logic
always @(*)
 begin
  case(current_state)
  IDLE     : begin
              UP_M   =  1'b0 ;	
			  DN_M	 =  1'b0 ;	
             end
  Mv_Dn    : begin
			    UP_M     =  1'b0 ;	
				DN_M	 =  1'b1 ;	
             end	
  Mv_Up    : begin
              UP_M   =  1'b1 ;	
			  DN_M	 =  1'b0 ;	   
             end
  default  : begin
              UP_M   =  1'b0 ;	
			  DN_M	 =  1'b0 ;	
             end			  
  endcase
 end	
		
		
endmodule					 					   

