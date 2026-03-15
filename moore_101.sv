module moore_101 (
    input  logic clk,
    input  logic rst_n,   // reset assíncrono ativo em nível baixo
    input  logic data_in,
    output logic sequence_detected
);

    typedef enum logic [1:0] {
        S0,   // estado inicial
        S1,   // recebeu '1'
        S2    // recebeu '10'
    } state_t;

    state_t state, next_state;

    // Registrador de estado
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    // Lógica de transição
    always_comb begin
        case (state)

            S0: begin
                if (data_in)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (data_in)
                    next_state = S1;
                else
                    next_state = S2;
            end

            S2: begin
                if (data_in)
                    next_state = S1;
                else
                    next_state = S0;
            end

            default: next_state = S0;

        endcase
    end

    // saída (Mealy registrada)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            sequence_detected <= 0;
        else
            sequence_detected <= (state == S2 && data_in == 1);
    end

endmodule
