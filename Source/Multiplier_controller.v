module mult_control (
  input clk, reset_a, start,
  input [1:0] count,
  output reg[1:0] input_sel, shift_sel,
  output [2:0] state_out,
  output reg done, clk_ena, sclr_n
);
  reg [2:0] next_state;
  reg [2:0] state_out_reg;

  localparam IDLE = 3'b000;
  localparam LSB = 3'b001;
  localparam MID = 3'b010;
  localparam MSB = 3'b011;
  localparam CALC_DONE = 3'b100;
  localparam ERR = 3'b101;

  always @(posedge clk,negedge reset_a) begin
    if (~reset_a)
      state_out_reg <= IDLE;
    else
      state_out_reg <= next_state;
  end

  always @(*) begin
    done = 1'b0;
    clk_ena = 1'b0;
    sclr_n = 1'b0;
    input_sel = 2'bxx;
    shift_sel = 2'bxx;
  end

  always @(state_out_reg) begin
    case (state_out_reg)
      IDLE: begin
        if (start) begin
          next_state = LSB;
          done = 1'b0;
          clk_ena = 1'b0;
          sclr_n = 1'b0;
        end else begin
          next_state = IDLE;
        end
      end

      LSB: begin
        if (start == 0 && count == 0) begin
          next_state = MID;
          done = 1'b0;
          clk_ena = 1'b1;
          sclr_n = 1'b1;
          input_sel = 2'b00;
          shift_sel = 2'b00;
        end else begin
          next_state = ERR;
        end
      end

      MID: begin
        if (start == 0 && count == 2'b01) begin
          next_state = MID;
          done = 1'b0;
          clk_ena = 1'b1;
          sclr_n = 1'b1;
          input_sel = 2'b01;
          shift_sel = 2'b01;
        end else if (start == 0 && count == 2'b10) begin
          next_state = MSB;
          done = 1'b0;
          clk_ena = 1'b1;
          sclr_n = 1'b1;
          input_sel = 2'b10;
          shift_sel = 2'b01;
        end else begin
          next_state = ERR;
        end
      end

      MSB: begin
        if (start == 0 && count == 2'b11) begin
          next_state = CALC_DONE;
          done = 1'b0;
          clk_ena = 1'b1;
          sclr_n = 1'b1;
          input_sel = 2'b11;
          shift_sel = 2'b10;
        end else begin
          next_state = ERR;
        end
      end

      CALC_DONE: begin
        if (start == 0 && count == 2'b11) begin
          next_state = IDLE;
          done = 1'b1;
          clk_ena = 1'b0;
          sclr_n = 1'b1;
          input_sel = 2'bxx;
          shift_sel = 2'bxx;
        end else begin
          next_state = ERR;
        end
      end

      ERR: begin
        if (~start) begin
          next_state = ERR;
          done = 1'b0;
          clk_ena = 1'b0;
          sclr_n = 1'b1;
          input_sel = 2'bxx;
          shift_sel = 2'bxx;
        end else if (start) begin
          next_state = LSB;
          done = 1'b0;
          clk_ena = 1'b1;
          sclr_n = 1'b0;
          input_sel = 2'bxx;
          shift_sel = 2'bxx;
        end
      end
    endcase
  end

  assign state_out = state_out_reg;

endmodule
