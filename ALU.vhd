LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ALU IS
    PORT (ALUA, ALUB: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
          ALUOp: IN STD_LOGIC;
          ALUResult: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
          Lt, Lo: OUT STD_LOGIC);
END ALU;

ARCHITECTURE Structural OF ALU IS
    COMPONENT Adder8 IS
        PORT (A, B: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
          Cin: IN STD_LOGIC;
          S: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
          Cout: OUT STD_LOGIC);
    END COMPONENT Adder8;
    COMPONENT Mux2 IS
        GENERIC ( DATA_WIDTH : Integer := 8);
        Port (
            D0     : in  STD_LOGIC_VECTOR ( DATA_WIDTH - 1 downto 0);  -- Input A
            D1     : in  STD_LOGIC_VECTOR ( DATA_WIDTH - 1 downto 0);  -- Input B
            S   : in  STD_LOGIC;  -- Select signal
            Y     : out STD_LOGIC_VECTOR ( DATA_WIDTH - 1 downto 0)  -- Output Y
        );
    END COMPONENT Mux2;
    
    SIGNAL NotB, BOrNotB, Sum: STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL Cout, Neg, Overflow, SignABEq, SignASumNeq: STD_LOGIC;
BEGIN
    bmux: Mux2 PORT MAP (D0 => ALUB, D1 => NotB, S => ALUOp, Y => BOrNotB);
    adder: Adder8 PORT MAP (A => ALUA, B => BOrNotB,
                            Cin => ALUOp, S => Sum, Cout => Cout);

    NotB <= NOT ALUB;
    ALUResult <= Sum;
    Neg <= Sum(7);
    SignABEq <= NOT (ALUOp XOR ALUA(7) XOR ALUB(7));
    SignASumNeq <= ALUA(7) XOR Sum(7);
    Overflow <= SignABEq AND SignASumNeq;
    Lt <= Neg XOR Overflow;
    Lo <= NOT Cout;
    
END Structural;
