LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
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
        FILE mem_file: TEXT IS IN filename;
        VARIABLE L: LINE;
        VARIABLE mem_data: mem_array;    
    BEGIN
        FOR i IN mem_array'range LOOP
            READLINE (mem_file, L);
            READ (L, mem_data(i));
        END LOOP;
       
        RETURN mem_data;
    END FUNCTION;
    
    SIGNAL mem : mem_array := init_mem(filename);  -- Initialize memory to all 
BEGIN
    PROCESS (Clk)
    BEGIN
        IF RISING_EDGE (Clk) THEN
            IF WriteEn = '1' THEN
                mem(CONV_INTEGER(Address)) <= DataIn;  -- Write data to memory
            END IF;
            DataOut <= mem(CONV_INTEGER(Address));  -- Read data from memory
        END IF;
    END PROCESS;
END ARCHITECTURE Behavioral;