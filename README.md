# MIPS32 Single-Cycle Processor (VHDL)

A 32-bit MIPS-style processor that runs each instruction in one clock cycle. It is written in VHDL and runs on a **Digilent Nexys A7-100T** FPGA board (Artix-7). You step through the program with a button and inspect internal values on the 7-segment display and the LEDs.

Built as a university project for the **Computer Architecture** course (2026). The pipelined version of the same processor is in [mips32-pipeline-vhdl](https://github.com/bogdansusman-prog/mips32-pipeline-vhdl).

## Architecture

The datapath is split into the classic MIPS units:

| Unit | File | Role |
|---|---|---|
| Instruction Fetch | `src/cpu/IFetch.vhd` | PC register, instruction ROM, PC+4, branch and jump multiplexers |
| Instruction Decode | `src/cpu/ID.vhd` | Register file (32 × 32-bit) and sign/zero extension of immediates |
| Control Unit | `src/cpu/UC.vhd` | Decodes the opcode into the control signals |
| Execute | `src/cpu/EX.vhd` | ALU, ALU control, branch address, Zero/GEZ/GTZ flags |
| Memory | `src/cpu/MEM.vhd` | Synchronous data RAM |
| Top level | `src/cpu/test_env.vhd` | Wires the units together and connects them to the board I/O |
| Peripherals | `src/peripherals/MPG.vhd`, `SSD.vhd` | Button debouncer (single-pulse generator) and 8-digit 7-segment display driver |

### Instruction set

| Type | Instructions |
|---|---|
| R-type | `add`, `sub`, `and`, `or`, `xor`, `slt`, `sll`, `srl` |
| I-type | `addi`, `lw`, `sw`, `beq`, `bgez`, `bgtz` |
| J-type | `j` |

## Test program

The instruction ROM holds a program that **counts how many elements of a zero-terminated array are smaller than X**:

- `MEM[0]` holds X and `MEM[4]` holds the start address A of the array.
- The result is written to `MEM[8]`.

With the data preloaded in RAM (X = 5 and the array `3, 7, 2, 9, 0`), the expected result is **2**. Each ROM line is commented with its hex encoding and meaning, and [`docs/TrasareExecutieMIPS32.docx`](docs) has the full execution trace.

## Using it on the board

| Input | Function |
|---|---|
| `btn(0)` | Execute the next instruction (step) |
| `btn(1)` | Reset the PC |
| `sw(7:5)` | Choose what the 7-segment display shows: instruction, PC+4, RD1, RD2, extended immediate, ALU result, memory data, write-back data |
| `led(15:0)` | Control signals: RegWrite, MemtoReg, MemWrite, Jump, Branch, ALUSrc, ExtOp, RegDst, ALUOp, flags and PCSrc |

## Repository contents

```
src/cpu/           processor units + top level
src/peripherals/   debouncer and 7-segment driver
sim/               testbench (tb_test_env.vhd)
bit/               prebuilt bitstream for the Nexys A7-100T
docs/              report, RTL schematics, control-signal table, execution trace
```

## Building

1. Create a Vivado project for part **xc7a100tcsg324-1**.
2. Add all files from `src/` as design sources, set `test_env` as the top module, and add `sim/tb_test_env.vhd` as a simulation source.
3. Add a constraints file. Start from Digilent's [Nexys A7-100T master XDC](https://github.com/Digilent/digilent-xdc/blob/master/Nexys-A7-100T-Master.xdc) and uncomment `clk`, `btn`, `sw`, `led`, `an` and `cat` (the 7-segment cathodes). Rename the ports to match `test_env` if needed.
4. Run synthesis and implementation, then generate the bitstream. Or program the board directly with `bit/test_env.bit`.

## Tech

VHDL · Xilinx Vivado · Artix-7 FPGA (Nexys A7-100T)
