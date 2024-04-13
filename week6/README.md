# UART BYPASSING, SYNTHESIS, AND GATE LEVEL SIMULATION USING YOSYS VERILOG RTL SYNTHESIS FRAMEWORK #

### UART BYPASSING ###

We must modify our test bench Verilog file (testbench.v) for the UART bypassing.

All the instructions will be commented out for the UART bypassing.
```
This portion in the testbench file should be commented out for UART bypassing.
 /* @(posedge slow_clk);write_instruction(32'h00000000); 
    @(posedge slow_clk);write_instruction(32'h00000000); 
    @(posedge slow_clk);write_instruction(32'hfe010113); 
    @(posedge slow_clk);write_instruction(32'h00812e23); 
    @(posedge slow_clk);write_instruction(32'h02010413); 
    @(posedge slow_clk);write_instruction(32'hfe042623); 
    @(posedge slow_clk);write_instruction(32'hffd00793); 
    @(posedge slow_clk);write_instruction(32'hfef42423); 
    @(posedge slow_clk);write_instruction(32'hfec42783); 
    @(posedge slow_clk);write_instruction(32'h00179793); 
    @(posedge slow_clk);write_instruction(32'hfef42223); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'hfe842703); 
    @(posedge slow_clk);write_instruction(32'h00ef7f33); 
    @(posedge slow_clk);write_instruction(32'h00ff6f33); 
    @(posedge slow_clk);write_instruction(32'h001f7793); 
    @(posedge slow_clk);write_instruction(32'hfef42023); 
    @(posedge slow_clk);write_instruction(32'hfe042783); 
    @(posedge slow_clk);write_instruction(32'h02078663); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'hfef42623); 
    @(posedge slow_clk);write_instruction(32'hfec42783); 
    @(posedge slow_clk);write_instruction(32'h00179793); 
    @(posedge slow_clk);write_instruction(32'hfef42223); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'hfe842703); 
    @(posedge slow_clk);write_instruction(32'h00ef7f33); 
    @(posedge slow_clk);write_instruction(32'h00ff6f33); 
    @(posedge slow_clk);write_instruction(32'hfcdff06f); 
    @(posedge slow_clk);write_instruction(32'hfe042623); 
    @(posedge slow_clk);write_instruction(32'hfec42783); 
    @(posedge slow_clk);write_instruction(32'h00179793); 
    @(posedge slow_clk);write_instruction(32'hfef42223); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'hfe842703); 
    @(posedge slow_clk);write_instruction(32'h00ef7f33); 
    @(posedge slow_clk);write_instruction(32'h00ff6f33); 
    @(posedge slow_clk);write_instruction(32'hfa9ff06f); 
    @(posedge slow_clk);write_instruction(32'hffffffff); 
    @(posedge slow_clk);write_instruction(32'hffffffff); */
```
After running it with **Iverilog** simulator, we will get the following output.
```
iverilog -o out testbench.v processor.v
vvp out 
```
![image1](/week6/bypassing_uart.png)

## GATE-LEVEL SYNTHESIS ##

The processor.v file is modified before the synthesis is executed.

Commenting the module definitions of both **sky130_sram_2kbyte_1rw1r_32x256_8_data** and **sky130_sram_2kbyte_1rw1r_32x256_8_inst**. 

Since the CPU doesn't truly need 2k RAM, the already instantiated SRAM modules are also modified from **sky130_sram_2kbyte_1rw1r_32x256_8_data** and **sky130_sram_2kbyte_1rw1r_32x256_8_inst** to **sky130_sram_1kbyte_1rw1r_32x256_8**.

Using writing_inst_done=1 and writing_inst_done=0, perform synthesis twice. and two netlists, dubbed synth_test.v and synth_processor.v, respectively, are obtained. When **writing_inst_done=1**, it indicates that simulation and verification are carried out using the matching netlist gate level and that the UART is passed to prevent the.vcd file from taking up more than 20 GB.

### YOSYS Installation ###
Installing Yosys: https://github.com/YosysHQ/yosys on the vsdworkshop VM.

-- Install the latest version by entering the following commands in the terminal:
```
sudo apt install build-essential clang bison flex libreadline-dev \
    gawk tcl-dev libffi-dev git graphviz \
    xdot pkg-config python python3 libftdi-dev \
    qt5-default python3-dev libboost-all-dev cmake libeigen3-dev
```
Clone yosys repository
```
git clone https://github.com/YosysHQ/yosys yosys --depth 1
cd yosys
git fetch --unshallow
```
To build Yosys simply type 'make' in this directory.
```
make -j$(nproc)
sudo make install
```

-- Comment out the data & instruction memory modules in processor.v and ensure **writing_inst_done=1** for uart verification,
OR **writing_inst_done=0** to bypass UART for simulation.

-- All required sky130 libs are kept in the current working directory, and proper instantiation name is used for SRAM from sky130 libs.\

Use the following yosys commands to synthesize gate-level netlist
```
yosys
```
![image2](/week6/yosys.png)
Make sure to use the latest version of Yosys.

-- Read liberty file to import sky130 cells
```
read_liberty -lib sky130_fd_sc_hd__tt_025C_1v80_256.lib
```
-- Read your verilog file and generate RTLIL

```
read_verilog gpio_syn.v
```
-- Synthesis of the top module (wrapper)
```
synth -top wrapper
```
![image3](/week6/design_hierarchy.png)
-- Mapping yosys standard cell to sky130 lib logic cells
```
abc -liberty sky130_fd_sc_hd__tt_025C_1v80_256.lib
```
-- Mapping sky130 lib flip-flop cells
```
dfflibmap -liberty sky130_fd_sc_hd__tt_025C_1v80_256.lib
```
-- Synthesis dumping output
```
write_verilog synth_gpio.v
```
-- Generating Graphviz representation of the design
```
show wrapper
```
![image4](/week6/wrapper_module.png)

## Gate Level Simulation ##

 Some modifications are done to the synthesized netlist file before doing gate-level simulation utilizing the synthesized netlist.

We modified the SRAM module instantiation names to match the standard cell before beginning synthesis. Still, since this is a simulation and not a cell, we must instantiate the module names exactly as they appear in the file sky130_sram_1kbyte_1rw1r_32x256_8.v, which contains the sine module definition. Particularly, sky130_sram_1kbyte_1rw1r_32x256_8_data and sky130_sram_1kbyte_1rw1r_32x256_8_inst.

Also, we will replace the mem instructions in the sky130_sram_1kbyte_1rw1r_32x256_8? v file with our processor instructions derived from the processor.v.

Use the command below to launch the simulation once the modifications have been made.
```
iverilog -o output_gls testbench.v synth_processor.v sky130_sram_1kbyte_1rw1r_32x256_8.v sky130_fd_sc_hd.v primitives.v
```
![image5](/week6/gls.png)

We can see some numbers underneath the dut on the left side of the above screenshot, which suggests that we used the synthesized netlist to simulate. Additionally, the behavior of the output matches that of the RTL functional simulation. 


