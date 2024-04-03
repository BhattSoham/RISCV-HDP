unique_instructions = set()
lines = disassembly.split('\n')
for line in lines:
    if line.strip():  # Skip empty lines
        instruction = line.split()[1]  # Get the instruction part
        unique_instructions.add(instruction)

# Print unique instructions
print("Unique Instructions:")
for instr in sorted(unique_instructions):
    print(instr)
