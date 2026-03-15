module mealy_101 (
    input  logic clk,
    input  logic rst_n,   // reset assíncrono ativo em 0
    input  logic data_in,
    output logic sequence_detected
);

    typedef enum logic [1:0] {
        S0,   // estado inicial
        S1,   // recebeu '1'
        S2    // recebeu '10'
    } state_t;

    state_t state, next_state;

    // registrador de estado
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    // lógica de transição + saída Mealy
    always_comb begin

        next_state = state;
        sequence_detected = 0;

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
                if (data_in) begin
                    next_state = S1;
                    sequence_detected = 1; // detecta 101
                end
                else
                    next_state = S0;
            end

        endcase

    end

endmodule
