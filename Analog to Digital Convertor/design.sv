module ADC (
  input wire clk,
  input wire start,
  input wire [7:0] analog_input,
  output reg [7:0] digital_output
);

  reg [7:0] reg_value;
  reg [2:0] bit_counter;
  reg conversion_done;

  always @(posedge clk) begin
    if (start) begin
      reg_value <= 8'h00;
      bit_counter <= 3'b000;
      conversion_done <= 0;
    end else if (!conversion_done) begin
      if (bit_counter < 3'b111) begin
        reg_value[bit_counter] <= analog_input[bit_counter];
        bit_counter <= bit_counter + 1;
      end else begin
        reg_value[bit_counter] <= analog_input[bit_counter];
        digital_output <= reg_value;
        conversion_done <= 1;
      end
    end
  end

endmodule
