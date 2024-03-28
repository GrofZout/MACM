
-- Definition des librairies

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Definition de l'entite
entity test_DE is
end test_DE;

-- Definition de l'architecture
architecture behavior of test_DE is

constant TIMEOUT 	: time := 300 ns; -- timeout de la simulation

-- definition de constantes
constant clkpulse : Time := 5 ns; -- 1/2 periode horloge

-- definition de types

-- definition de ressources externes
signal i_DE, WD_ER, pc_plus_4 : std_logic_vector(31 downto 0);
signal Op3_ER : std_logic_vector(3 downto 0);
signal RegSrc, immSrc : std_logic_vector(1 downto 0);
signal RegWr, E_CLK, Init : std_logic;
signal Reg1, Reg2, Op3_DE : std_logic_vector(3 downto 0);
signal Op1, Op2, extImm : std_logic_vector(31 downto 0);

begin


------------------------------------------------------------------
-- instanciation et mapping du composant fifo
test_DE : entity work.etageDE  
    port map (i_DE, WD_ER, pc_plus_4,
        Op3_ER, 
        RegSrc, immSrc, 
        RegWr, E_CLK, Init,
        Reg1, Reg2, Op3_DE,
        Op1, Op2, extImm);

------------------------------------------------------------------

P_TEST: process
begin
    E_CLK <= '0';

    Init <= '1';


    -- add R0, R2, R3
    --I_DE <= 0000 00 0 0100 0 0000 0010 00000000 0011
    i_DE<="00000000100000000010000000000011";

    -- Adresse dans laquelle on écrit
    -- On regardera sur gtkwave si ça abien écrit dans l'adresse.
    Op3_ER<="0011";

    WD_ER<="00000000000000000000000000000101";

    pc_plus_4<="00000000000000000000000000000100";

    RegWr<='1';

    immSrc <= "11";

    RegSrc <= "00";


    wait for clkpulse;
    E_CLK <= '1';

    Init <='0';


    RegSrc <= "00";



    wait for clkpulse;
    E_CLK <= '0';

    immSrc <= "01";


    wait for clkpulse;
    E_CLK <= '1';


    wait for clkpulse;
    E_CLK <= '0';

    RegSrc <= "11";

    wait for clkpulse;
    E_CLK <= '1';

    wait for clkpulse;
    wait;

end process P_TEST;

end behavior;