`timescale 1ns / 1ps

module reg_bank_tb();
    reg [4:0] sr1, sr2, dr;
    reg [31:0] wdata;
    reg write, clk, reset;
    wire [31:0] regd1, regd2;

    // Instantiate the register bank
    register_bank_32X32 m1(sr1, sr2, dr, regd1, regd2, wdata, write, clk, reset);

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Write and read operations
    initial begin
        // Initialize signals
        reset = 1;
        write = 0;
        wdata = 0;
        dr = 0;
        sr1 = 0;
        sr2 = 0;

        // Apply reset
        #10 reset = 0;

        // Write data to the register bank
        for (integer i = 0; i < 32; i = i + 1) begin
            write = 1;
            wdata = i * 10;
            dr = i;
            #10; // Wait for one clock cycle
            write = 0;
            #10; // Wait for another clock cycle to ensure write completes
        end

        // Read and display register values
        for (integer j = 0; j < 32; j = j + 2) begin
            sr1 = j;
            sr2 = j + 1;
            #10; // Wait to ensure read is stable
            $display("reg[%2d]=%3d reg[%2d]=%3d", sr1, regd1, sr2, regd2);
        end

        $finish;
    end
       initial begin
         // Dump VCD file
         $dumpfile("reg_bank_tb.vcd");
         $dumpvars(0, reg_bank_tb);end
endmodule