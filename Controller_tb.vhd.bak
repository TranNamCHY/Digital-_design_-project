library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use std.textio.all;
entity Controller_tb is
end entity Controller_tb;

architecture behavioral of Controller_tb is

    -- Component Declaration for the memory
    component Controller
        Port (
        Clk : in STD_LOGIC;
        Reset : in STD_LOGIC;
        Start,Lt : in STD_LOGIC;
        MaxWriteEn, MaxSrc, MinWriteEn, MinSrc, ValueWriteEn,IndexSrc, IndexWriteEn,AddrInWriteEn,AddrInSrc, AddressSrc, ALUOp : out STD_LOGIC;
        Done, ResultWriteEn : out STD_LOGIC;
        ALUSrcA, ALUSrcB : out std_logic_vector ( 1 downto 0)
    );
    end component;

    -- Signals to connect to the memory component
    signal data_in : std_logic_vector(7 downto 0);
    signal Clk,Reset,Start,Lt    : std_logic := '0';
    signal MaxWriteEn, MaxSrc, MinWriteEn, MinSrc, ValueWriteEn,IndexSrc, IndexWriteEn,AddrInWriteEn,AddrInSrc, AddressSrc, ALUOp : std_logic:= '0';
    signal Done, ResultWriteEn : STD_LOGIC;
    signal ALUSrcA, ALUSrcB : std_logic_vector ( 1 downto 0);
    file input_file : text open read_mode is "test.txt";
    file output_file : text is out "output.txt";
    -- Function to convert std_logic_vector to string for display
    function std_logic_vector_to_string(vector: std_logic_vector) return string is
        variable result : string(1 to vector'length);
    begin
        for i in vector'range loop
            if vector(i) = '1' then
                result(i+1) := '1';
            else
                result(i+1) := '0';
            end if;
        end loop;
        return result;
    end function;
    -- File declarations


    -- Clock period definition
    constant clk_period : time := 10 ns;
begin

    --variable line_buffer : line;
    --variable data_buffer : std_logic_vector(7 downto 0);
    --variable X : std_ulogic;
    --variable data_buffer : std_logic_vector(7 downto 0);
    -- Instantiate the memory component
    uut: Controller
        port map (
             Clk,Reset,Start,Lt,
    	     MaxWriteEn, MaxSrc, MinWriteEn, MinSrc, ValueWriteEn,IndexSrc, IndexWriteEn,AddrInWriteEn,AddrInSrc, AddressSrc, ALUOp,
    	     Done, ResultWriteEn, ALUSrcA, ALUSrcB
        );

    -- Function to convert std_logic_vector to string for display
    test: process
	variable line_buffer : line;
	variable data_buffer : std_logic_vector(7 downto 0);
	variable str : string(1 to 8);
    begin
        -- Read lines from the file until end of file
        while not endfile(input_file) loop
            readline(input_file, line_buffer);
	    read(line_buffer, str);
             -- Convert string to std_logic_vector
            for i in 0 to 7 loop
                if str(i+1) = '0' then
                    data_buffer(i) := '0';
                elsif str(i+1) = '1' then
                    data_buffer(i) := '1';
                else
                    data_buffer(i) := '0'; -- Default case for non-binary characters
                end if;
            end loop;
 	    data_in <= data_buffer;
            -- Apply the data to the signal and wait for one clock cycle
            wait until rising_edge(Clk);
            report "Read data: " & std_logic_vector_to_string(data_in);
        end loop;

        -- Close the file and end the simulation
        file_close(input_file);
	wait;
    end process;

    -- Clock process definitions
    clk_process : process
    begin
        Clk <= '0';
        wait for clk_period/2;
        Clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        wait for clk_period; -- clock 1
        Reset <= '1';        
        wait for clk_period; -- clock 2
        Reset <= '0';
        -- Disable write and read from address '00000001'
        wait for clk_period;  -- switch to IDLE state -- clock 3
        Start <= '1';
        -- Check data output
        wait for clk_period;  -- switch to state 1 clock 4
        Start <= '0';
	assert ResultWriteEn = '0'
            report "Test failed for ResultWriteEn"
            severity error;
	assert Done = '0'
            report "Test failed for address Done"
            severity error;
	assert MaxSrc = '0'
            report "Test failed for address MaxSrc"
            severity error;
	assert MaxWriteEn = '1'
            report "Test failed for address MaxWriteEn"
            severity error;
	assert MinSrc = '0'
            report "Test failed for address MinSrc"
            severity error;
	assert MinWriteEn = '1'
            report "Test failed for address MinWriteEn"
            severity error;
	assert AddrInSrc = '0'
            report "Test failed for address AddrInSrc"
            severity error;
	assert AddrInWriteEn = '1'
            report "Test failed for address AddrInWriteEn"
            severity error;
	assert IndexSrc = '0'
            report "Test failed for address IndexSrc"
            severity error;
	assert IndexWriteEn = '1'
            report "Test failed for address IndexWriteEn"
            severity error;

        wait for clk_period;  -- switch to state 2 clock 5
	assert MaxWriteEn = '0'
            report "Test failed for address MaxWriteEn"
            severity error;
	assert MinWriteEn = '0'
            report "Test failed for address MaxWriteEn"
            severity error;
	assert AddrInWriteEn  =  '0'
            report "Test failed for address AddrInWriteEn"
            severity error;
	assert IndexWriteEn = '0'
            report "Test failed for address IndexWriteEn"
            severity error;
	assert AddressSrc = '0'
            report "Test failed for address AddressSrc"
            severity error;
	assert ValueWriteEn = '1'
            report "Test failed for address ValueWriteEn"
            severity error;

        wait for clk_period;  -- switch to state 3 clock 6
	
	
	assert ALUSrcA(0) = '1'
            report "Test failed for address ALUSrcA"
            severity error;
	assert ALUSrcA(1) = '1'
            report "Test failed for address ALUSrcA"
            severity error;
	assert ALUSrcB(0) = '0'
            report "Test failed for address ALUSrcB"
            severity error;
	assert ALUSrcB(1) = '1'
            report "Test failed for address ALUSrcB"
            severity error;
	assert ALUOp = '1'
            report "Test failed for address ALUOp"
            severity error;
	Lt <= '1';

        wait for clk_period;  -- switch to state 4 clock 7

	wait for clk_period; -- switch to state 5
	assert MinSrc = '1'
            report "Test failed for address MinSrc"
            severity error;
	assert MinWriteEn = '1'
            report "Test failed for address MinWriteEn"
            severity error;

	wait for clk_period; -- switch to state 6
	assert MinWriteEn = '0'
            report "Test failed for address MinWriteEn"
            severity error;
	--report "Output Vector Value: " & std_logic_vector'image(ALUSrcA);
	--report "Output Vector Value: " & std_logic_vector'image(ALUSrcB);
            --report "Test failed for address ALUOp"
            --severity error;
	Lt <= '1';

	wait for clk_period; -- switch to state 7

	wait for clk_period; -- switch to state 8
	assert MaxSrc = '1'
            report "Test failed for address MaxSrc"
            severity error;
	assert MaxWriteEn = '1'
            report "Test failed for address MaxWriteEn"
            severity error;

	wait for clk_period; -- switch to state 9
	assert MaxWriteEn = '0'
            report "Test failed for address MaxWriteEn"
            severity error;
	assert ALUSrcA = "01"
            report "Test failed for address ALUSrcA"
            severity error;
	assert ALUSrcB = "01"
            report "Test failed for address ALUSrcB"
            severity error;
	assert ALUOp = '0'
            report "Test failed for address ALUOp"
            severity error;
	assert AddrInSrc = '1'
            report "Test failed for address AddrInSrc"
            severity error;
	assert AddrInWriteEn = '1'
            report "Test failed for address AddrInWriteEn"
            severity error;

	wait for clk_period; -- switch to state 10
	assert AddrInWriteEn = '0'
            report "Test failed for address AddrInWriteEn"
            severity error;
	assert ALUSrcA = "00"
            report "Test failed for address ALUSrcA"
            severity error;
	assert ALUSrcB = "01"
            report "Test failed for address ALUSrcB"
            severity error;
	assert ALUOp = '0'
            report "Test failed for address ALUOp"
            severity error;
	assert IndexSrc = '1'
            report "Test failed for address IndexSrc"
            severity error;
	assert IndexWriteEn = '1'
            report "Test failed for address IndexWriteEn"
            severity error;

	wait for clk_period; -- switch to state 11
	assert IndexWriteEn = '0'
            report "Test failed for address IndexWriteEn"
            severity error;
	assert ALUSrcA = "00"
            report "Test failed for address ALUSrcA"
            severity error;
	assert ALUSrcB = "00"
            report "Test failed for address ALUSrcB"
            severity error;
	assert ALUOp = '1'
            report "Test failed for address ALUOp"
            severity error;
	Lt <= '1';

	wait for clk_period; -- switch to state 12
	
	wait for clk_period; -- switch to state 2
        wait;
    end process;
end architecture behavioral;