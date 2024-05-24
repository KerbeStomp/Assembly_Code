#include <iostream>
#include <fstream>
#include <cmath>
using namespace std;

const int total_instructions = 13; // total instructions in MIPS file
const int file_size = 64; // MIPS file size in bytes
const int instruction_size = 4; // amount of bytes in a byte

int get_bit_sum(int offset, int num_bits, bool* arr);

int main()
{
	// create bool array to store individual bits from each instruction
	bool bit_value[32];
	// use char variable to store byte value (8 bits)
	char byte_value[4];
	// use int variable to hold values from added bits
	int bit_sum;

	// create and open binary MIPS file
	ifstream MIPS_file;
	MIPS_file.open ("mips-test.bin", ios::binary);

	// test if file was opened successfully
	if (!MIPS_file.is_open())
	{
			cout << "Error opening MIPS test file..." << endl;
			return 1;
	}

	// loop through each instruction (4 bytes each)
	for (int i = 0; i < total_instructions; ++i)
	{
		cout << "Reading instruction " << i+1 << endl;
		// read 4 bytes from MIPS binary
		MIPS_file.read(byte_value, 4);

		// store each bit (8 bits per byte) in array
		for (int j = 0; j < instruction_size; ++j)
		{
			// determine offset in bit_value array
			int arr_offset = j * 8;
			
			// loop thorugh each bit in a byte (8 bits per byte)
			for (int k = 0; k < 8; ++k)
			{
				// use bitmask to get bits from right to left
				// use bitwise AND to determine bit value
				bool temp_bool = (byte_value[j] & (1 << (7 - k)));
				bit_value[arr_offset + k] = temp_bool;
			}
		}

		
		// deocde the first 6 bits
		// access one bit at a time, then add up sum
		bit_sum = get_bit_sum(0, 6, bit_value);
		//
		// if opcode = 0, decode as R-format
		if (bit_sum == 0)
		{
			cout << "Instruction Format: R" << endl;

			// get Rs register
			bit_sum = get_bit_sum(6, 5, bit_value);
			cout << "\tRs: " << bit_sum << endl;
			
			// get Rt register
			bit_sum = get_bit_sum(11, 5, bit_value);
			cout << "\tRt: " << bit_sum << endl;
			
			// get Rd register
			bit_sum = get_bit_sum(16, 5, bit_value);
			cout << "\tRd: " << bit_sum << endl;

			// get shift amount
			bit_sum = get_bit_sum(21, 5, bit_value);
			cout << "\tShift amount: " << bit_sum << endl;

			// get function
			bit_sum = get_bit_sum(26, 6, bit_value);
			cout << "\tFunction: " << bit_sum << endl;
		}

		// if opcode = 2 or 3, decode as J format
		else if (bit_sum == 2 || bit_sum == 3)
		{
			cout << "Instruction Format: J" << endl;
			bit_sum = get_bit_sum(6, 26, bit_value);
			cout << "\tJump address: " << bit_sum << endl;
		}

		// else, decode as I format
		else
		{
			cout << "Instruction Format: I" << endl;
			bit_sum = get_bit_sum(6, 5, bit_value);
			cout << "\tRs: " << bit_sum << endl;
			bit_sum = get_bit_sum(11, 5, bit_value);
			cout << "\tRd: " << bit_sum << endl;
			bit_sum = get_bit_sum(16, 16, bit_value);
			cout << "\tImmediate value: " << bit_sum << endl;
		}
		cout << endl;
	}
	
	return 0;
}

// get the sum of num_bits from an offset in boolean array arr
int get_bit_sum(int offset, int num_bits, bool* arr)
{
	int temp_sum = 0;
	for (int b = 0; b < num_bits; ++b)
	{
		int power = pow(2, num_bits - 1 - b);
		temp_sum += (arr[b + offset] * power);
	}

	return temp_sum;
}
