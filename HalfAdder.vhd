LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY HalfAdder IS
    PORT (A, B: IN STD_LOGIC;
          S, Cout: OUT STD_LOGIC);
END HalfAdder;

ARCHITECTURE Dataflow OF HalfAdder IS
BEGIN
    S <= A XOR B;
    Cout <= A AND B;
END Dataflow;
