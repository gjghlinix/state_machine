module tb_state_cola_1();

	reg  sys_clk ;
	reg  sys_rst_n ;
	reg  pi_money ;

	wire   po_cola;	

initial begin
	sys_clk  = 1'b1;
	sys_rst_n <= 1'b0;
	pi_money    <= 1'b0;
	#20
	sys_rst_n <= 1'b1;
end
always #10 sys_clk =~ sys_clk;

//pi_money 随机数模拟投币情况
always@(posedge sys_clk or negedge sys_rst_n)
if(sys_rst_n == 1'b0)
	pi_money <= 1'b0;
else 
	pi_money <= {$random} % 2;

state_cola_1 state_cola_inst1
(
	.sys_clk(sys_clk),
	.sys_rst_n(sys_rst_n),
	.pi_money (pi_money),

	.po_cola (po_cola)
);	
endmodule