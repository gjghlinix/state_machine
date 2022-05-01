module state_cola_2
(
	input 	wire 	sys_clk,
	input 	wire 	sys_rst_n,
	input 	wire  	pi_money_one,
	input 	wire 	pi_money_half,
	
	output 	reg   	po_cola,
	output  reg		po_money
);
reg [4:0] state;
wire [1:0] pi_money;	

//独热码
parameter 	ZERO  = 5'b00001, 
			HALF  = 5'b00010,
			ONE   = 5'b00100,
		 ONE_HALF = 5'b01000,
			TWO   = 5'b10000;

assign pi_money = {pi_money_one,pi_money_half};

//状态机的赋值
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		state <= ZERO;
	else case(state)
		ZERO: 	if(pi_money == 2'b01)
					state <= HALF;
				else if(pi_money == 2'b10)
					state <= ONE_HALF;
				else
					state <= state;
		HALF: 	if(pi_money == 2'b01)
					state <= ONE;
				else if(pi_money == 2'b10)
					state <= TWO;
				else
					state <= state;
		ONE: 	if(pi_money == 2'b01)
					state <= ONE_HALF;
				else if(pi_money == 2'b10)
					state <= TWO;
				else
					state <= state;
	ONE_HALF: 	if(pi_money == 2'b01)
					state <= TWO;
				else if(pi_money == 2'b10)
					state <= ZERO;
				else
					state <= state;
		TWO: 	if(pi_money == 2'b01)
					state <= ZERO;
				else if(pi_money == 2'b10)
					state <= ZERO;
				else
					state <= state;
		default: state <= ZERO;
	endcase
	
//state 和 pi_money如何影响po_money
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		po_money <= 1'b0;
	else if(state == TWO && pi_money == 2'b10)
		po_money <= 1'b1;
	else
		po_money <= 1'b0;

//state 和 pi_money如何影响po_cola
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		po_cola <= 1'b0;
	else if((state == ONE_HALF && pi_money == 2'b10) || (state == TWO && pi_money == 2'b01) 
			|| (state == TWO && pi_money == 2'b10))
		po_cola <= 1'b1;
	else
		po_cola <= 1'b0;
endmodule

//看代码比较长，但写起来思路还是挺清晰的，主要就是对状态和输出起到变化效果的几个条件都考虑到，ex_1中，
//我把各个因素的影响变化都放在一个always语句中反而是显得有些混乱,因此不可取。
//另外，我一直想把pi_money看做是两位的输入变量，而不是当作中间变量，以01和10代表5毛钱和1块钱，是不是不太对应现实？