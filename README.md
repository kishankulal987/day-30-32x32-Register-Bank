# 32x32 Register Bank in Verilog

## 📘 Overview

In this project, I implemented a **32x32 register bank** in Verilog to simulate a register file commonly used in processors.

My goal was to design a module with 32 registers, each 32 bits wide, that allows simultaneous reading from two source registers (`sr1`, `sr2`) and writing to a destination register (`dr`) when enabled, with an **asynchronous reset** to clear all registers.

### ✅ Example  
If `dr = 5`, `wdata = 50`, and `write = 1`, register 5 is updated to 50. Subsequent reads from `sr1 = 5` will return 50.

The design uses a 32-element array of 32-bit registers, combinational logic for reads, and a sequential always block for writes and resets.

A testbench was written to verify functionality by writing sequential data and reading register pairs, confirming correct operation through simulation.

---

## 🔧 Module: `register_bank_32X32`

### ✅ What I Did
I designed a **32x32 register bank** with read and write capabilities.

### 📥 Inputs
- `sr1[4:0]`, `sr2[4:0]` – 5-bit addresses for the two source registers (0 to 31)
- `dr[4:0]` – 5-bit address for the destination register
- `wdata[31:0]` – 32-bit data to write to the destination register
- `write` – Enable signal for writing to the register bank
- `clk` – Clock signal for synchronous write operations
- `reset` – Asynchronous reset signal to clear all registers

### 📤 Outputs
- `regd1[31:0]`, `regd2[31:0]` – 32-bit data read from the source registers

### ⚙️ How It Works
- Declared a `32x32` register array:  
  `reg [31:0] bank [0:31];`
- Used combinational assignments:  
  `assign regd1 = bank[sr1];`  
  `assign regd2 = bank[sr2];`
- Inside an `always` block on `posedge clk` or `posedge reset`:
  - If `reset == 1`: a for loop sets all `bank[i] = 0`
  - If `write == 1`: `bank[dr] <= wdata`

---

## 🧪 Testbench: `reg_bank_tb`

### ✅ What I Did
I created a **testbench** to verify the register bank’s functionality.

### ⚙️ How It Works
- Defined all required inputs (`sr1`, `sr2`, `dr`, `wdata`, `write`, `clk`, `reset`) and outputs (`regd1`, `regd2`)
- Generated a clock signal with 10ns period:  
  `#5 clk = ~clk;`

### 🧪 Test Sequence
1. `reset = 1` for 10ns, then `reset = 0`
2. Loop writing `wdata = i * 10` to `dr = i` for `i = 0` to `31`
   - `write = 1` for 10ns, then `write = 0` for 10ns
3. Loop reading `regd1` and `regd2` for `sr1 = j`, `sr2 = j + 1` for `j = 0` to `30` in steps of 2
4. Used `$display` to log outputs
5. Enabled VCD dumping for waveform analysis:
   ```verilog
   $dumpfile("reg_bank_tb.vcd");
   $dumpvars(0, reg_bank_tb);

## 🎯 Purpose

The purpose of this project was to:

- Implement a 32-register file (each 32 bits wide) with dual-read and single-write capability.
- Validate asynchronous reset functionality.
- Ensure correct storage and retrieval of data across all registers.
- Develop a reusable and testable module to simulate basic processor register bank behavior.
- Use simulation waveform and log output to verify data flow and register state transitions.

---

## 📁 Files

- `register_bank_32X32.v` – Verilog module implementing the 32x32 register bank.
- `reg_bank_tb.v` – Verilog testbench that verifies functionality through write and read sequences.

---



## 📊 Simulation Waveform

![Screenshot 2025-06-30 194423](https://github.com/user-attachments/assets/75174e7b-e81e-4f80-82e9-22ebbeeae377)

This waveform shows:
- Initialization via asynchronous reset
- Sequential write operations to all 32 registers
- Sequential read operations from adjacent register pairs
- Signal transitions for `clk`, `write`, `reset`, `sr1`, `sr2`, `dr`, `wdata`, `regd1`, and `regd2`

---

## 🖥️ Console Output

![Screenshot 2025-06-30 195638](https://github.com/user-attachments/assets/7a6424d0-011e-4298-9cc0-d298fb52e2d8)

