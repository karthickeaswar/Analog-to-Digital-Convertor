module ADC_tb;

  reg clk;
  reg start;
  reg [7:0] analog_input;
  wire [7:0] digital_output;

  // Instantiate ADC module
  ADC dut (
    .clk(clk),
    .start(start),
    .analog_input(analog_input),
    .digital_output(digital_output)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Test stimulus
  initial begin
    clk = 0;
    start = 0;
    analog_input = 8'h00;

    // Apply start signal
    #10 start = 1;
    #10 start = 0;

    // Provide analog input values and capture digital outputs
    analog_input = 8'h12; // Example input value
    #50;
    analog_input = 8'hA5; // Example input value
    #50;
    // Add more input values as needed

    // Wait for conversion to complete
    #100;

    // Display digital outputs
    $display("Digital Output: %h", digital_output);

    // End simulation
    #10 $finish;
  end

  // Dump waveform variables
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, ADC_tb);
  end

endmodule
