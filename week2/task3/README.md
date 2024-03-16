# CPU PERFORMANCE METRICS #

Everyone in this era is hungry for the performance of our CPU. However, the performance is generally based on the term "PPA", which is Power, Performance, and Area. To get better performance, we can make the power consumption of our CPU less and less in the case of area. But, there are other cases to be considered for better performance.

**Performance**

Let's take an example:

![image1](/week2/task3/CompA_vs_CompB.png)

In this picture, a task is defined as running a program. Computer A completes the program in 25 seconds and Computer B in 30 seconds. According to the image, computer A is 'X' times faster in running the program than Computer B. 

But what is this **'X'**?

**'X'** is the performance ratio, which is defined by (30s / 20s) = 1.2.

**So, Computer A is 1.2 times faster than Computer B.**

But another question is, is it the "Execution time" or the "Response time"? 

To know about this, we have to move towards the flow to know the whole process from writing any website or opening an application and displaying it to our monitor. How does the whole process work?

![image2](/week2/task3/Flow.png)

In the above picture, a website has been written to the computer or laptop using our keypad. It will then generate a huge binary sequence in the memory. This binary sequence is so big to store, and that's why we need a memory to store it as it has a lot of space. The memory will share the binary data with the CPU and the CPU will again send it back to the memory. The memory will share the data to the monitor and the monitor will display the website to us or the user. 

So, the time required to send the data from the memory to the CPU and send it back to the memory is called the **"Execution time"**. 

Now, this Execution time has two parts:

a. User CPU time -> Time spent on the User program.

b. System CPU time -> Time spent on the Operating system (OS) on behalf of the User program.

This **"User CPU time"** is the **"CPU Performance"**.

![image3](/week2/task3/Exec_time.png)

![image4](/week2/task3/Exec_time_2.png)

![image5](/week2/task3/CPU_performance.png)

**CPU Performance**

Our computer only knows combinational and sequential logic and operation regarding clock cycles.  There are different terminologies to measure CPU performance.

i. Clock cycle Time (T).

ii. Clock rate (1/T) or Clock Frequency (f).

iii. CPU time.

![image6](/week2/task3/Terminologies_new.png)

**How to measure CPU performance?**

This can be done using a formula:
```
CPU time = Number of CPU clock cycles x Clock cycle time (T)
                        OR
CPU time = Number of CPU clock cycles / Clock rate (f)
```
Let's take an example:

![image7](/week2/task3/Ex_CPU_Performance_new.png)

According to the example given above, the clock rate is given as 1GHz. The CPU needs the 20s to execute a program. So, the number of CPU clock cycles will be:

CPU time = Clock cycles / Clock rate

20 = Clock cycles / 1GHz or 10<sup>9</sup>

Therefore, the number of CPU Clock cycles = 20 x 10<sup>9</sup> cycles.

Another example is running the same program on two computers.

![image8](/week2/task3/CPU_performance_comp_new.png)


