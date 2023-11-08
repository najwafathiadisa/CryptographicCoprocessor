# Mini_Processor

Mini_Processor is a minimalistic processor that features a 16x16-bit register file, an Arithmetic Logic Unit (ALU), a shifter, and a hasher. The ALU supports operations like ADD, SUB, AND, OR, XOR, NOT, and MOVE, each with its respective opcode. The shifter allows for ROR8, ROR4, and SLL8 operations, each with its unique opcode. The hasher in this project uses a non-linear lookup table mechanism, enabling faster parallel hashing that completes on the same clock cycle. However, it lacks security as anyone with access to the key can decipher the actual data content.

For a more detailed explanation and to see the program in action, check out this YouTube video: [Mini_Processor Demo](https://youtu.be/KIACj-xC7h8).

## Features

- 16x16-bit Register File
- Arithmetic Logic Unit (ALU) with various operations
- Shifter with rotation and shift operations
- Hasher with a non-linear lookup table

## Usage

1. Clone the repository:

   ```sh
   git clone https://github.com/your-username/Mini_Processor.git
