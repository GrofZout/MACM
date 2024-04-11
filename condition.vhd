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
    CC' : out std_logic_vector(3 downto 0);
);
end entity;


architecture Cond_arch of Cond is
begin

  CC' <= CC when CCWr_EX='1'

end architecture;

