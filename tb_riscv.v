`timescale 1ns/1ps

module tb_riscv;

reg clk;
reg reset;

// =========================
// Instanciation du DUT
// =========================
riscv_199 dut (
    .clk(clk),
    .reset(reset)
);

// =========================
// Horloge (10 ns)
// =========================
always #5 clk = ~clk;

// =========================
// Simulation
// =========================
integer i;

initial begin
    clk = 0;
    reset = 1;

    // Dump GTKWave
    $dumpfile("wave.vcd");
    $dumpvars(0, tb_riscv);

    for (i = 0; i < 5; i = i + 1) begin
      $dumpvars(0, dut.dmem[i]);
    end
    for (i = 0; i < 5; i = i + 1) begin
      $dumpvars(0, dut.registers[i]);
    end
    
    // Reset
    #20;
    reset = 0;

    // Laisser tourner assez longtemps pour la boucle
    #500;

    // =========================
    // Affichage registres
    // =========================
    $display("==== REGISTERS ====");
    for (i = 0; i < 8; i = i + 1) begin
        $display("x%0d = %0d", i, dut.registers[i]);
    end

    // =========================
    // Affichage mémoire
    // =========================
    $display("==== MEMORY ====");
    for (i = 0; i < 4; i = i + 1) begin
        $display("MEM[%0d] = %0d", i, dut.dmem[i]);
    end

    // =========================
    // Vérification automatique
    // =========================
    if (dut.registers[1] == 5 &&   // x1
        dut.registers[2] == 5 &&   // x2
        dut.registers[4] == 5 &&   // x4 (load)
        dut.dmem[0] == 5)          // mémoire
    begin
        $display("✅ TEST PASSED");
    end
    else begin
        $display("❌ TEST FAILED");
    end

    $finish;
end

endmodule
