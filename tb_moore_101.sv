module tb_moore_101;

    logic clk;
    logic rst_n;
    logic data_in;
    logic sequence_detected;

    moore_101 dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .sequence_detected(sequence_detected)
    );

    // clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);

        clk = 0;
        rst_n = 0;
        data_in = 0;

        #10 rst_n = 1;

        // sequência 10101
        #10 data_in = 1;
        #10 data_in = 0;
        #10 data_in = 1;
        #10 data_in = 0;
        #10 data_in = 1;

        #20 $finish;
    end

endmodule
