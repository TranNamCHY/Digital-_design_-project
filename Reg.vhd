LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY Reg IS
 GENERIC ( DATA_WIDTH : Integer := 8);
 PORT (
	Reset,Clk : IN STD_LOGIC;
	Enable : IN STD_LOGIC;
	D : IN STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
 	Q : OUT STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
 );
END Reg;

ARCHITECTURE RTL OF Reg IS
BEGIN
 PROCESS (Reset, Clk)
 BEGIN
  IF(Reset= '1') THEN
   Q <= (OTHERS => '0');
  ELSIF(Clk'EVENT and Clk = '1') THEN
   IF(Enable = '1') THEN
    Q <= D;
   END IF;
  END IF;
 END PROCESS;
END RTL;
 