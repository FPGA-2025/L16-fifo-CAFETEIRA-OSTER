module fifo(
    input wire clk,
    input wire rstn,
    input wire wr_en,
    input wire rd_en,
    input wire [7:0] data_in,
    output reg [7:0] data_out,
    output full,
    output empty
);

    reg [7:0] fifo_mem [3:0];
    reg [1:0] w_ptr = 2'b0;
    reg [1:0] r_ptr = 2'b0;
    assign empty = (w_ptr == r_ptr);
    // assign full = (w_ptr < r_ptr);
    assign full = ((w_ptr + 1'b1) == r_ptr);

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            w_ptr = 2'b0;
            r_ptr = 2'b0;
            fifo_mem[0] = 8'b0;
            fifo_mem[1] = 8'b0;
            fifo_mem[2] = 8'b0;
            fifo_mem[3] = 8'b0;
        end else begin
            if(wr_en && !full) begin
                fifo_mem[w_ptr] = data_in;
                w_ptr = w_ptr + 1;
            end else begin
                if(rd_en && !empty) begin
                    data_out = fifo_mem[r_ptr];
                    r_ptr = r_ptr + 1;
                end
            end
        end
    end
endmodule