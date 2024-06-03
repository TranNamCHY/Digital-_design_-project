LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FullAdder IS
    PORT (A, B, Cin: IN STD_LOGIC;
          S, Cout: OUT STD_LOGIC);
END FullAdder;

ARCHITECTURE Structural OF FullAdder IS
    COMPONENT HalfAdder IS
        PORT (A, B: IN STD_LOGIC;
              S, Cout: OUT STD_LOGIC);
    END COMPONENT HalfAdder;
    SIGNAL S1, Cout1, Cout2: STD_LOGIC;
BEGIN
    half_adder_1: HalfAdder PORT MAP (
        A => A, B => B, S => S1, Cout => Cout1);
    half_adder_2: HalfAdder PORT MAP (
        A => Cin, B => S1, S => S, Cout => Cout2);
    Cout <= Cout1 OR Cout2;
    
END Structural;
