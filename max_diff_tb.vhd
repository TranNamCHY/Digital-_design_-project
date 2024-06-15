LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY max_diff_tb IS
END ENTITY max_diff_tb;

ARCHITECTURE Behavioral OF max_diff_tb IS
    COMPONENT max_diff 
        Port ( Clk,Reset,Start   : in  STD_LOGIC;
               N,DataOut : in  STD_LOGIC_VECTOR (7 downto 0);
               AddressOut,AddressIn : in  STD_LOGIC_VECTOR (7 downto 0);
               Done ,ResultWriteEn: out  STD_LOGIC;
               MemAddress, ALUResult: out  STD_LOGIC_VECTOR (7 downto 0));
    END COMPONENT max_diff;
    COMPONENT Memory2 IS GENERIC (filename: STRING);
        PORT ( Clk   : IN  STD_LOGIC;
               Address : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
               WriteEn : IN  STD_LOGIC;
               DataIn  : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
               DataOut : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT Memory2;
    SIGNAL Clk, Reset, Start, Done, ResultWriteEn: STD_LOGIC;
    SIGNAL N, DataOut, AddressOut, AddressIn, MemAddress, ALUResult: STD_LOGIC_VECTOR (7 DOWNTO 0);
    CONSTANT clk_t: TIME := 10 NS;
    CONSTANT half_clk_t: TIME := clk_t / 2;
BEGIN
    dut: max_diff PORT MAP (Clk => Clk, Reset => Reset,
                    Start => Start, N => N, DataOut => DataOut,
                    AddressOut => AddressOut, AddressIn => AddressIn,
                    Done => Done, ResultWriteEn => ResultWriteEn,
                    MemAddress => MemAddress, ALUResult => ALUResult);
    memory_i: Memory2 GENERIC MAP (filename => "C:/Users/admin/Desktop/project/Digital-_design_-project/mem.dat")
                      PORT MAP (Clk => Clk, Address => MemAddress,
                            WriteEn => ResultWriteEn, DataIn => ALUResult,
                            DataOut => DataOut);
                            
    PROCESS BEGIN
        Clk <= '0';
        WAIT FOR half_clk_t;
        Clk <= '1';
        WAIT FOR half_clk_t;
    END PROCESS;
    
    PROCESS BEGIN
        Reset <= '1';
        WAIT FOR clk_t;
        Reset <= '0';
        WAIT FOR clk_t / 10;
        Start <= '1';
        N <= 8D"255";
        AddressIn <= 8D"0";
        AddressOut <= 8D"255";
        WAIT FOR 2 * clk_t;
        Start <= '0';
        
        WAIT UNTIL RISING_EDGE (Done);
        WAIT FOR clk_t / 10;
        
        REPORT "Result = " & INTEGER'IMAGE(TO_INTEGER(UNSIGNED(ALUResult)));
   
        WAIT;
    END PROCESS;
END ARCHITECTURE Behavioral;


