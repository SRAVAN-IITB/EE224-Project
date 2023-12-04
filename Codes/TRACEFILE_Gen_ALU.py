import numpy as np

A = np.random.randint(1, 2 ** 16, 200)
B = np.random.randint(1, 2 ** 16, 200)
operations = ["0000", "0010", "0011", "0100", "0101", "0110"]

with open("TRACEFILE.txt", "w") as tracefile:
    for i in range(len(A)):
        for oper in operations:
            a = bin(A[i])[2:]
            b = bin(B[i])[2:]
            a = "0" * (16 - len(a)) + a
            b = "0" * (16 - len(b)) + b
            z = "0"
            p_out = ""
            # Test cases for ADDITION
            if (oper == "0000"):
                out = bin(A[i] + B[i])[2:]
                if (len(out) < 16):
                    out = "0" * (16 - len(out)) + out
                p_out = out[-16:]
                z = "1" if (out == "0000000000000000") else "0"

            # Test cases for SUBTRACTION
            elif (oper == "0010"):
                if A[i] < B[i]:
                    # Handle negative result using 2's complement
                    neg_result = bin((1 << 16) + A[i] - B[i])[2:]
                    p_out = neg_result[-16:]
                    z = "1" if p_out == "0000000000000000" else "0"
                else:
                    # subtraction cases giving non-negative results
                    out = bin(A[i] - B[i])[2:]
                    if len(out) < 16:
                        out = "0" * (16 - len(out)) + out
                    p_out = out[-16:]
                    z = "1" if out == "0000000000000000" else "0"

            # Test cases for 'MUL' [multiply content of regB (4 least significant bits)
            # to regA (4 least significant bits) and store result in regC]
            elif (oper == "0011"):
                # Extract the 4 least significant bits of A and B
                A_ls = A[i] & 0b1111
                B_ls = B[i] & 0b1111

                # Perform binary multiplication on the 4 least significant bits
                out = bin(A_ls * B_ls)[2:]

                # Ensure the result is represented using 4 bits
                if len(out) < 16:
                    out = "0" * (16 - len(out)) + out

                # Assign the result to p_out
                p_out = out[-16:]

                # Set z based on whether the result is zero
                z = "1" if p_out == "0000000000000000" else "0"

            # Test cases for Bit-wise 'AND' operation
            elif (oper == "0100"):
                out = bin(A[i] & B[i])[2:]
                if len(out) < 16:
                    out = "0" * (16 - len(out)) + out
                p_out = out[-16:]
                z = "1" if out == "0000000000000000" else "0"

            # Test cases for Bit-wise 'OR' operation
            elif (oper == "0101"):
                out = bin(A[i] | B[i])[2:]
                if len(out) < 16:
                    out = "0" * (16 - len(out)) + out
                p_out = out[-16:]
                z = "1" if out == "0000000000000000" else "0"

            # Test cases for Bit-wise 'Implies' operation
            elif (oper == "0110"):
                out = bin((~A[i] & 0xFFFF) | B[i])[2:]  # Implements A' U B
                if len(out) < 16:
                    out = "0" * (16 - len(out)) + out
                p_out = out[-16:]
                z = "1" if out == "0000000000000000" else "0"

            else:
                continue

            tracefile.write(a + b + oper + " "+ z + p_out + "1" * 18 + "\n")
