-------------------------------------------------

-- Decodeur

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity Cond is
  port(
    CCWr_EX : in std_logic;
    Cond, CC_EX, CC : in std_logic_vector(3 downto 0);
    CondEx : out std_logic;
    CCp : out std_logic_vector(3 downto 0)
);
end entity;


architecture Cond_arch of Cond is
  signal sigCond : std_logic;
begin

  sigCond <= '1' when 
    (Cond="0000" and CC_EX(2)='1') or 
    (Cond="0001" and CC_EX(1)='0') or
    (Cond="0010" and CC_EX(1)='1') or
    (Cond="0011" and CC_EX(1)='0') or
    (Cond="0100" and CC_EX(3)='1') or
    (Cond="0101" and CC_EX(3)='0') or
    (Cond="0110" and CC_EX(0)='1') or
    (Cond="0111" and CC_EX(0)='0') or
    (Cond="1000" and CC_EX(1)='1' and CC_EX(2)='0') or
    (Cond="1001" and (CC_EX(1)='0' or CC_EX(2)='1')) or
    (Cond="1010" and CC_EX(0)=CC_EX(3)) or
    (Cond="1011" and CC_EX(0)/=CC_EX(3)) or
    (Cond="1100" and CC_EX(0)=CC_EX(3) and CC_EX(2)='0') or
    (Cond="1101" and (CC_EX(0)/=CC_EX(3) or CC_EX(2)='1')) or
    Cond="1110" else '0';

  CCp <= CC when CCWr_EX='1' and sigCond='1' else CC_EX;

  CondEx <= sigCond;


end architecture;

