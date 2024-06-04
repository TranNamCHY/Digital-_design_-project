LIBRARY IEEE;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.all;
ENTITY max_diff IS
    Port ( Clk,Reset,Start   : in  STD_LOGIC;
           N,DataOut : in  STD_LOGIC_VECTOR (7 downto 0);
           AddressOut,AddressIn : in  STD_LOGIC_VECTOR (7 downto 0);
           Done ,ResultWriteEn: out  STD_LOGIC;
	   MemAddress, ALUResult: out  STD_LOGIC_VECTOR (7 downto 0)
);
END max_diff;
architecture structural of max_diff is
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

    component Datapath
    	PORT (Clk, Reset: IN STD_LOGIC;
          MaxWriteEn, MaxSrc, MinWriteEn, MinSrc, ValueWriteEn,
          IndexSrc, IndexWriteEn, AddrInWriteEn, AddrInSrc,
          AddressSrc, ALUOp: IN STD_LOGIC;
          ALUSrcA, ALUSrcB: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
          AddressIn, AddressOut, N, DataOut: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
          Lt: OUT STD_LOGIC;
          ALUResult, MemAddress: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END component;

        signal Lt : STD_LOGIC;
        signal MaxWriteEn, MaxSrc, MinWriteEn, MinSrc, ValueWriteEn,IndexSrc, IndexWriteEn,AddrInWriteEn,AddrInSrc, AddressSrc, ALUOp : STD_LOGIC;
        --signal ResultWriteEn : STD_LOGIC;
        signal ALUSrcA, ALUSrcB : std_logic_vector ( 1 downto 0);
	--signal DataOut : STD_LOGIC_VECTOR (7 DOWNTO 0);
	--signal ALUResult, MemAddress : STD_LOGIC_VECTOR (7 DOWNTO 0);

begin
   CTRL_UNIT: Controller
   Port map (
        Clk,
        Reset,
        Start,Lt,
        MaxWriteEn, MaxSrc, MinWriteEn, MinSrc, ValueWriteEn,IndexSrc, IndexWriteEn,AddrInWriteEn,AddrInSrc, AddressSrc, ALUOp,
        Done, ResultWriteEn,
        ALUSrcA,ALUSrcB
    );

   DATAPATH_UNIT: Datapath
   Port map (
	  Clk, Reset,
          MaxWriteEn, MaxSrc, MinWriteEn, MinSrc, ValueWriteEn,
          IndexSrc, IndexWriteEn, AddrInWriteEn, AddrInSrc,
          AddressSrc, ALUOp,
          ALUSrcA, ALUSrcB,
          AddressIn, AddressOut, N, DataOut,
          Lt,
          ALUResult, MemAddress
    );


end structural;
 