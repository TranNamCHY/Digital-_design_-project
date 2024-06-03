library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for the test bench
entity tb_mux2to1 is
-- No ports for a test bench
end tb_mux2to1;

-- Architecture definition for the test bench
architecture Behavioral of tb_mux2to1 is
    -- Component declaration for the MUX
    component Mux2
        Port (
            A     : in  STD_LOGIC;
            B     : in  STD_LOGIC;
            Sel   : in  STD_LOGIC;
            Y     : out STD_LOGIC
        );
    end component;

    -- Signals to connect to the MUX inputs and output
    signal A     : STD_LOGIC := '0';
    signal B     : STD_LOGIC := '0';
    signal Sel   : STD_LOGIC := '0';
    signal Y     : STD_LOGIC;

begin
    -- Instantiate the MUX
    uut: mux2to1
        Port map (
            A => A,
            B => B,
            Sel => Sel,
            Y => Y
        );

    -- Test process
    process
    begin
        -- Test case 1: Sel = '0', A = '0', B = '0'
        A <= '0';
        B <= '0';
        Sel <= '0';
        wait for 10 ns;

        -- Test case 2: Sel = '0', A = '1', B = '0'
        A <= '1';
        B <= '0';
        Sel <= '0';
        wait for 10 ns;

        -- Test case 3: Sel = '1', A = '0', B = '0'
        A <= '0';
        B <= '0';
        Sel <= '1';
        wait for 10 ns;

        -- Test case 4: Sel = '1', A = '0', B = '1'
        A <= '0';
        B <= '1';
        Sel <= '1';
        wait for 10 ns;

        -- Test case 5: Sel = '0', A = '1', B = '1'
        A <= '1';
        B <= '1';
        Sel <= '0';
        wait for 10 ns;

        -- Test case 6: Sel = '1', A = '1', B = '0'
        A <= '1';
        B <= '0';
        Sel <= '1';
        wait for 10 ns;

        -- Stop the simulation
        wait;
    end process;

end Behavioral;
