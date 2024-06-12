LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY Memory2 IS GENERIC (filename: STRING);
    PORT ( Clk   : IN  STD_LOGIC;
           Address : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
           WriteEn : IN  STD_LOGIC;
           DataIn  : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
           DataOut : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
END Memory2;

ARCHITECTURE Behavioral OF Memory2 IS
    TYPE mem_array IS ARRAY (0 TO 255) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    IMPURE FUNCTION init_mem(filename: IN STRING) RETURN mem_array IS
        FILE mem_file: TEXT;
        VARIABLE L: LINE;
        VARIABLE mem_data: mem_array;
        VARIABLE mem_val: INTEGER;
        VARIABLE i: INTEGER := 0;    
    BEGIN
        FILE_OPEN (mem_file, filename, READ_MODE);
        WHILE NOT ENDFILE (mem_file) LOOP
            READLINE (mem_file, L);
            READ (L, mem_val);
            mem_data(i) := STD_LOGIC_VECTOR(TO_SIGNED(mem_val, 8));
            i := i + 1;
        END LOOP;
       
        RETURN mem_data;
    END FUNCTION;
    
    SIGNAL mem : mem_array := init_mem("C:/Users/admin/Desktop/project/Digital-_design_-project/mem.dat");  -- Initialize memory to all 
BEGIN
    PROCESS (Clk)
    BEGIN
        IF RISING_EDGE (Clk) THEN
            IF WriteEn = '1' THEN
                mem(TO_INTEGER(UNSIGNED(Address))) <= DataIn;  -- Write data to memory
            END IF;
            DataOut <= mem(TO_INTEGER(UNSIGNED(Address)));  -- Read data from memory
        END IF;
    END PROCESS;
END ARCHITECTURE Behavioral;