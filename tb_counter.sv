module tb_counter;

    logic clk;
    logic rst_n;
    logic en;
    logic [3:0] count;

    // Instância do DUT
    counter dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .count(count)
    );

    // Geração de clock (período = 10)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_counter);

        clk = 0;
        rst_n = 0;
        en = 0;

        // reset inicial
        #10 rst_n = 1;

        // habilita contador
        #10 en = 1;

        // contador roda por vários ciclos
        #200;

        // desabilita contador
        en = 0;

        #20;

        // testa reset novamente
        rst_n = 0;

        #10 rst_n = 1;

        #50 $finish;
    end

    // monitor de sinais
    initial begin
        $monitor("time=%0t rst_n=%b en=%b count=%b",
                 $time, rst_n, en, count);
    end

endmodule
