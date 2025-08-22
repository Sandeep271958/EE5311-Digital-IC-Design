module adder (output reg[16:0] sum, input[15:0] a, input[15:0] b, input cin, input clk);
    reg[15:0] a_q, b_q;
    reg cin_q;
    wire[16:0] sum_d;
    assign sum_d = a_q + b_q + cin_q;
    always @ (posedge clk) begin
        a_q <= a;
        b_q <= b;
        cin_q <= cin;
        sum <= sum_d;
    end
endmodule
