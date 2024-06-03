library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Controller is
    Port (
        Clk : in STD_LOGIC;
        Reset : in STD_LOGIC;
        Start,Lt : in STD_LOGIC;
        MaxWriteEn, MaxSrc, MinWriteEn, MinSrc, ValueWriteEn,IndexSrc, IndexWriteEn,AddrInWriteEn,AddrInSrc, AddressSrc, ALUOp : out STD_LOGIC;
        Done, ResultWriteEn : out STD_LOGIC;
        ALUSrcA, ALUSrcB : out std_logic_vector ( 1 downto 0)
    );
end Controller;
architecture Behavioral of Controller is

    -- Define the state type
    type state_type is (IDLE,S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16);
    signal state, next_state : state_type;
begin

    -- State transition process
    process (Clk, Reset)
    begin
        if Reset = '1' then
            state <= IDLE;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    -- Next state logic process
    process (state, Start, Lt)
    begin
        case state is
            when IDLE =>
                if Start = '1' then
                    next_state <= S1;
                else
                    next_state <= IDLE;
                end if;

            when S1 =>
                    next_state <= S2;
            when S2 =>
                    next_state <= S3;
            when S3 =>
                    next_state <= S4;
	    when S4 =>
                if( Lt = '1') then
                    next_state <= S5;
                else 
                    next_state <= S6;
                end if;
	    when S5 =>
                    next_state <= S6;
	    when S6 =>
                    next_state <= S7;
	    when S7 =>
                if( Lt = '1') then
                    next_state <= S8;
                else 
                    next_state <= S9;
                end if;
	    when S8 =>
                    next_state <= S9;
	    when S9 =>
                    next_state <= S10;
	    when S10 =>
                    next_state <= S11;
            when S11 =>
                    next_state <= S12;
            when S12 =>
                if( Lt = '1') then
                    next_state <= S2;
                else 
                    next_state <= S13;
                end if;
           when S13 =>
                    next_state <= IDLE;
            when others =>
                next_state <= IDLE;
        end case;
    end process;

    -- Output logic process
    process (state)
    begin
        case state is
            when S1 =>
		ResultWriteEn <= '0';
		MaxSrc <= '0';
		MaxWriteEn <= '1';
		MinSrc <= '0';
		MinWriteEn <= '1';
		AddrInSrc <= '0';
		AddrInWriteEn <= '1';
		IndexSrc <= '0';
		IndexWriteEn <= '1';
		Done <= '0';
            when S2 =>
                MaxWriteEn <= '0';
                MinWriteEn <= '0';
	        AddrInWriteEn <= '0';
	        IndexWriteEn <= '0';
		AddressSrc <= '0';
		ValueWriteEn <= '1';
            when S3 =>
                ALUSrcA <= "11";
		ALUSrcB <= "10";
		ALUOp <= '1';
	    when S4 =>
	    when S5 =>
                MinSrc <= '1';
		MinWriteEn <= '1';
	    when S6 =>
                MinWriteEn <= '0';
		ALUSrcA <= "10";
		ALUSrcB <= "11";
		ALUOp <= '1';
	    when S7 =>
	    when S8 =>
		MaxSrc <= '1';
		MaxWriteEn <= '1';                    
	    when S9 =>
                MaxWriteEn <= '0';
		ALUSrcA <= "01";
		ALUSrcB <= "01";
		ALUOp <= '0';
		AddrInSrc <= '1';
		AddrInWriteEn <= '1';
	    when S10 =>
                AddrInWriteEn <= '0';
		ALUSrcA <= "00";
		ALUSrcB <= "01";
		ALUOp <= '0';
		IndexSrc <= '1';
		IndexWriteEn <= '1';
            when S11 =>
                IndexWriteEn <= '0';
		ALUSrcA <= "00";
		ALUSrcB <= "00";
		ALUOp <= '1';
            when S12 =>
            when S13 =>
		ALUSrcA <= "10";
		ALUSrcB <= "10";
		ALUOp <= '1';
		AddressSrc <= '1';
		ResultWriteEn <= '1';
		Done <= '1';
            when others =>
        end case;
    end process;

end Behavioral;

