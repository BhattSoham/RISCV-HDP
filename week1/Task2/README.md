# ASSIGNMENT / TASK 2 #

 ***1. Binary Arithmetic of (10-19)<sub>10</sub>*** 

(10 - 19)<sub>10</sub> = (-9)<sub>10</sub>

**-> Signed Addition:** 

For 9, it is (00001001)<sub>2</sub>. For -9, it should be (10001001)<sub>2</sub>. Simply interchange the most significant bit (MSB) with 1.

**-> 1's Complement Addition:** 

(10)<sub>10</sub> : (00001010)<sub>2</sub>

(19)<sub>10</sub> : (00010011)<sub>2</sub> -> (11101100)<sub>2</sub>

So,

 (00001010)<sub>2</sub> + (11101100)<sub>2</sub> =  (11110110)<sub>2</sub>
        
1's complement addition of (10-19)<sub>10</sub> is (11110110)<sub>2</sub>.

**-> 2's Complement Addition:** 

(10)<sub>10</sub> : (00001010)<sub>2</sub> 

(-19)<sub>10</sub>: (00010011)<sub>2</sub> -> (11110110)<sub>2</sub>

So,
2's complement = 1's complement of (11101100)<sub>2</sub> + 1 = (11110111)<sub>2</sub>.

***2. Binary Arithmetic of (20 + 30)<sub>10</sub>***

(20)<sub>10</sub> : (00010100)<sub>2</sub>

(30)<sub>10</sub> : (00011110)<sub>2</sub>

**-> Signed:** 

For signed it is a simple addition. (00010100)<sub>2</sub> + (00011110)<sub>2</sub> = (00110010)<sub>2</sub>

**-> 1's Complement Addition:** 


(20)<sub>10</sub> : (00010100)<sub>2</sub>

(30)<sub>10</sub> : (00011110)<sub>2</sub> 

So, for performing 1's complement,

 a. Add binary numbers.
 b. Add carry to low-order bit.

 Therefore, 1's complement is (00010100)<sub>2</sub> + (00011110)<sub>2</sub> = (00110010)<sub>2</sub> + 0(low-order carry) = (00110010)<sub>2</sub>. 

**-> 2's Complement Addition:** 

For performing 2's complement,

a. Add binary numbers.
b. Ignore carry to low-order bit.

Therefore, 2's complement is (00110010)<sub>2</sub>.

***3. Binary Arithmetic of (36 - 12)<sub>10</sub>***

(36)<sub>10</sub> = (00100100)<sub>2</sub>

(12)<sub>10</sub> = (00001100)<sub>2</sub> --> 1's complement : (11110011)<sub>2</sub> --> 2's complement: (11110100)<sub>2</sub>

Therefore,

(36)<sub>10</sub> - (12)<sub>10</sub> = (00100100)<sub>2</sub> + (11110100)<sub>2</sub> = (00011000)<sub>2</sub>
