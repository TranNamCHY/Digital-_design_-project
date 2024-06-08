library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for the 2-to-1 MUX
entity Mux1bit is
    Port (
        D0     : in  STD_LOGIC;
        D1     : in  STD_LOGIC;
        S   : in  STD_LOGIC;  -- Select signal
        Y     : out STD_LOGIC
    );
end Mux1bit;

-- Architecture definition using dataflow style
architecture Dataflow of Mux1bit is
begin
    -- Dataflow description using 'when else'
    Y <= D0 when S = '0' else
         D1;
end Dataflow;