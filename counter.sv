module counter (
    input  logic clk,
    input  logic rst_n,   // reset assíncrono ativo em 0
    input  logic en,      // enable síncrono
    output logic [3:0] count
);

    // contador
    always_ff @(posedge clk or negedge rst_n) begin

        // reset assíncrono
        if (!rst_n)
            count <= 4'b0000;

        // enable síncrono
        else if (en)
            count <= count + 1;

    end

endmodule
