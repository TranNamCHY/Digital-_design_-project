LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ALU_tb IS
END ALU_tb;

ARCHITECTURE Behavioral OF ALU_tb IS
    COMPONENT ALU IS
        PORT (ALUA, ALUB: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
              ALUOp: IN STD_LOGIC;
              ALUResult: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
              Lt: OUT STD_LOGIC);
    END COMPONENT ALU;
    SIGNAL ALUA, ALUB, ALUResult: STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL ALUOp, Lt: STD_LOGIC;
BEGIN
    dut: ALU PORT MAP (ALUA => ALUA, ALUB => ALUB, ALUOp => ALUOp,
                ALUResult => ALUResult, Lt => Lt);
                
    PROCESS BEGIN
        ALUA <= "00101101";
        ALUB <= "00001101";
        ALUOp <= '0';
        WAIT FOR 5 ns;
        ALUOp <= '1';
        WAIT FOR 5 ns;
        ALUB <= "01000001";
        WAIT;
    END PROCESS;

END Behavioral;
