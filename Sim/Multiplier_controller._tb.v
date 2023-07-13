module mult_control_TestBench;

    // Inputs
    reg clk;
    reg reset_a;
    reg start;
    reg [1:0] count;

    // Outputs
    wire done;
    wire clk_ena;
    wire sclr_n;
    wire [2:0] state_out;
    wire [1:0] input_sel;
    wire [1:0] shift_sel;

    // Instantiate the Unit Under Test (UUT)
    mult_control uut (
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

    initial begin
        // Initialize Inputs
        clk = 0;
        reset_a = 0;
        start = 0;
        count = 0;

        // Wait for 100 ns for global reset to finish
        #100;
        
        // De-assert reset
        reset_a = 1;
        #100;

        // Assert start and provide count
        start = 1;
        count = 2'b10;
        #100;

        // De-assert start
        start = 0;
        #100;

        // Assert start and provide count
        start = 1;
        count = 2'b11;
        #100;

        // De-assert start
        start = 0;
        #100;

        // Assert start and provide count
        start = 1;
        count = 2'b01;
        #100;

        // De-assert start
        start = 0;
        #100;

        // Assert start and provide count
        start = 1;
        count = 2'b00;
        #100;

        // De-assert start
        start = 0;
        #100;

        // Finish the simulation
        $finish;
    end

    always #10 clk = ~clk;

endmodule
