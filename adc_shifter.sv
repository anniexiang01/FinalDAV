module adc_shifter #(WIDTH=36) (
    input clk,
    input signed [11:0] adc_out,
    output logic signed [WIDTH-1:0] f [0:15]
);

initial begin
	f = '{default: '0};
end

always @(posedge clk) begin
    // Shift the elements in f
    for (int i = 15; i > 0; i = i - 1) begin
        f[i] <= f[i - 1];
    end
    // Assign adc_out to the first element of f with sign extension
    f[0] <= {{(WIDTH-12){adc_out[11]}}, adc_out}; // Sign extension by replicating MSB
end

endmodule