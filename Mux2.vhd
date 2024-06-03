library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for the 2-to-1 MUX
entity Mux2 is
    GENERIC ( N : Integer := 8);
    Port (
        D0     : in  STD_LOGIC_VECTOR ( N - 1 downto 0);  -- Input A
        D1     : in  STD_LOGIC_VECTOR ( N - 1 downto 0);  -- Input B
        S   : in  STD_LOGIC;  -- Select signal
        Y     : out STD_LOGIC_VECTOR ( N - 1 downto 0)  -- Output Y
    );
end Mux2;

-- Architecture definition using dataflow style
architecture Dataflow of Mux2 is
begin
    -- Dataflow description using 'when else'
    Y <= D0 when S = '0' else
         D1;
end Dataflow;
