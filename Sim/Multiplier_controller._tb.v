module mult_control_TestBench;

reg clk, reset_a, start;
   reg [1:0] count;        
   wire done,clk_ena,sclr_n;
   wire [2:0] state_out;
   wire [1:0] input_sel,shift_sel;    

   mult_control DUT (
   .clk(clk),
   .reset_a(reset_a),
   .start(start),
   .count(count),
   .done(done),
   .clk_ena(clk_ena),
   .sclr_n(sclr_n),
   .state_out(state_out),
   .input_sel(input_sel),
   .shift_sel(shift_sel)  
);

    always begin
        clk = 1'b1;
        #25;
        clk = 1'b0;
        #25;
    end

    initial begin
        reset_a = 1'b0;
        #75;
        reset_a = 1'b1;
    end

   initial begin

       start = 0;
       #50;
       @(negedge clk);
       start = 1'b1;
       #50;
       @(negedge clk);
       start = 1'b0;
       count= 2'b00;
       #50;
       @(negedge clk);
       count= 2'b01;
       #50; 
      @(negedge clk);
       count= 2'b10;
       #50;
       @(negedge clk);
       count=2'b11;
       #50;
       start = 1'b1;
       #50;
      
   end
endmodule


