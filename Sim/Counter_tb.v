module Counter_TestBench();
  
  reg clk;
  reg aclr_n;
  wire [1:0] count;

  // Instantiate the Asynchronous_Counter module
  counter DUT (
    .clk(clk),
    .aclr_n(aclr_n),
    .count(count)
  );

  // Toggle the clock every 5 time units
  always #5 begin
    clk = ~clk;
  end

  // Initialize signals before simulation starts
  initial begin
    clk = 0;
    aclr_n = 1;

    // Assert asynchronous reset for 20 time units
    #20;
    aclr_n = 0;

    // Deassert asynchronous reset after 20 time units
    #20;
    aclr_n = 1;
    
  end

endmodule
