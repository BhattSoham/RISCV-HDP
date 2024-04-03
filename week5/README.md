# UPDATING THE JSON FILE AND GENERATING THE PROCESSOR FOR OUR SPECIFIC APP USING THE CHIPCRON TOOL #

From the **Week3** folder, the Chipcron tool has been used to generate the processor and the testbench after generating the number of unique instructions.

The *obstacle_detection.txt* and the *obstacle_detection.json* files have been uploaded and the tool will generate the processor and its corresponding testbench in Verilog.

To simulate the code for our specific app, run the following commands:
```
iverilog -o obstacle_detection_v testbench.v processor.v
vvp obstacle_detection_v
```

