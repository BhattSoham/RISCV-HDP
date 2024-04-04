# UPDATING THE JSON FILE AND GENERATING THE RTL FOR OUR SPECIFIC APP USING THE CHIPCRON TOOL #
### GPIO Config ###

processor.v gpio input and output verilog changes where input_gpio_pins is bit 31 of the x30 register and top_gpio_pins[0:0] is bit 0 of the x30 register.
```
input wire input_gpio_pins;
    output reg output_gpio_pins;
...
    output_pins = {30'b0, top_gpio_pins[1],  input_gpio_pins} ; 
    output_gpio_pins = top_gpio_pins[1]; 
```

### Functional Simulation using UART ###
From the **Week3** folder, the Chipcron tool has been used to generate the RTL design for our specific application and the testbench after generating the number of unique instructions.

The *obstacle_detection.txt* and the *obstacle_detection.json* files have been uploaded and the tool will generate the processor and its corresponding testbench in Verilog.

To simulate the code for our specific app, run the following commands using the **Iverilog** simulator:
```
iverilog -o obstacle_detection_v testbench.v processor.v
vvp obstacle_detection_v
```
For fast signal track (FST) and also for more optimized .vcd file, please use these commands:
```
iverilog -o obstacle_detection_v testbench.v processor.v
vvp obstacle_detection_v -fst
```

![image1](/week5/iverilog_commands.png)
![image2](/week5/simulation.png)

After that, we will run the **GTKWAVE** to generate the waveform and check our desired output.
![image3](/week5/output_gtkwave.png)
