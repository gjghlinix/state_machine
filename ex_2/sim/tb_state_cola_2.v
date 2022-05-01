module tb_state_cola_2();

	reg  sys_clk ;
	reg  sys_rst_n ;
	reg  pi_money_one ;
	reg  pi_money_half;

	wire   po_cola;	
	wire   po_money;	

initial begin
	sys_clk  		= 1'b1;
	sys_rst_n 		<= 1'b0;
	pi_money_half  	<= 1'b0;
	pi_money_one	<= 1'b0;
	#20
	sys_rst_n <= 1'b1;
end
always #10 sys_clk =~ sys_clk;

//pi_money 随机数模拟投币情况
always@(posedge sys_clk or negedge sys_rst_n)
if(sys_rst_n == 1'b0)
	begin
		pi_money_half <= 1'b0;
		pi_money_one  <= 1'b0;
	end
else 
	begin
		pi_money_half <= {$random} % 2;
		pi_money_one  <= {$random} % 2;
	end
	
state_cola_2 state_cola_inst2
(
	.sys_clk(sys_clk),
	.sys_rst_n(sys_rst_n),
	.pi_money_half (pi_money_half),
	.pi_money_one (pi_money_one),

	.po_cola (po_cola),
	.po_money (po_money)
);	
endmodule