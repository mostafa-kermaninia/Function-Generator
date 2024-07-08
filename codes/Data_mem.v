module Data_mem ( clk, A, WD, WE ,RD);
    input  [31:0] A, WD;
    input WE , clk;
    output [31:0] RD;
    reg [31:0] RD;
    reg [7:0] dataMem [0:$pow(2, 16)-1];

    reg [31:0] adr;

    initial $readmemb("data.mem", dataMem);

    always @(posedge clk) begin
        if (WE)
            {dataMem[adr + 3], dataMem[adr + 2], dataMem[adr + 1], dataMem[adr]} = WD;
    end

    always @(*) begin
           RD = {dataMem[adr + 3], dataMem[adr + 2], dataMem[adr + 1], dataMem[adr]};
    end


    assign adr = {A[31:2], 2'b00}; 

endmodule

