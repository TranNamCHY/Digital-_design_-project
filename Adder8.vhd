LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Adder8 IS
    PORT (A, B: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
          Cin: IN STD_LOGIC;
          S: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
          Cout: OUT STD_LOGIC);
END Adder8;

ARCHITECTURE Structural OF Adder8 IS
    COMPONENT FullAdder IS
        PORT (A, B, Cin: IN STD_LOGIC;
                S, Cout: OUT STD_LOGIC);
    END COMPONENT FullAdder;
    SIGNAL C: STD_LOGIC_VECTOR (7 DOWNTO 0);
BEGIN
    C(0) <= Cin;
    gen_full_adder: FOR i IN 0 TO 6 GENERATE
        full_adder: FullAdder 
            PORT MAP (A => A(i), B => B(i), Cin => C(i),
                    S => S(i), Cout => C(i + 1));
    END GENERATE;
    last_full_adder: FullAdder
            PORT MAP (A => A(7), B => B(7), Cin => C(7),
                    S => S(7), Cout => Cout);
END Structural;
