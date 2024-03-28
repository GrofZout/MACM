-------------------------------------------------

-- Decodeur

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity Decodeur is
  port(
    instr : in std_logic_vector(31 downto 0);
    PCSrc, RegWr, MemToReg, MemWr, Branch, CCWr, AluSrc  : out std_logic;
    AluCtrl, ImmSrc, RegSrc : out std_logic_vector(1 downto 0)
    Cond : out std_logic_vector(3 downto 0);
);
end entity;


architecture Decodeur_arch of Decodeur is
begin

    AluCtrl <= "00" when instr(27 downto 26)="10" or (instr(27 downto 26)="00" and instr(24 downto 21)="0100") or (instr(27 downto 26)="01" and instr(23)='0') else
             "01" when (instr(27 downto 26)="00" and instr(24 downto 21)="0010") or (instr(27 downto 26)="01" and instr(23)='1') else
             "10" when instr(27 downto 26)="00" and instr(24 downto 21)="0000" else
             "11" when instr(27 downto 26)="00" and instr(24 downto 21)="1100";

    
    

end architecture;

