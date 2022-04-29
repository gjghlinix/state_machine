module state_cola_1
(
	input 	wire 	sys_clk,
	input 	wire 	sys_rst_n,
	input 	wire 	pi_money,
	
	output 	reg 	po_cola
);
reg [2:0] state;

parameter ZERO = 3'b001, ONE = 3'b010, TWO = 3'b100;

//状态机的赋值
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		state <= ZERO;
	else case(state)
		ZERO: 	if(pi_money == 1'b1)
					begin
						state <= ONE;
						po_cola <= 1'b0;
					end
				else
					begin 
						state <= state;
						po_cola <= 1'b0;
					end
		ONE:	if(pi_money == 1'b1)
					begin
						state <= TWO;
						po_cola <= 1'b0;
					end
				else
					begin 
						state <= state;
						po_cola <= 1'b0;
					end
		TWO:	if(pi_money == 1'b1)
					begin
						state <= ZERO;
						po_cola <= 1'b1;
					end
				else
					begin 
						state <= state;
						po_cola <= 1'b0;
					end
		default: state <= ZERO;
		endcase
endmodule