
-- Definition des librairies

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Definition de l'entite
entity test_RE is
end test_RE;

-- Definition de l'architecture
architecture behavior of test_RE is

constant TIMEOUT 	: time := 300 ns; -- timeout de la simulation

-- definition de constantes
constant clkpulse : Time := 5 ns; -- 1/2 periode horloge

-- definition de types

-- definition de ressources externes
signal Res_Mem_RE, Res_ALU_RE: std_logic_vector(31 downto 0);
signal Op3_RE : std_logic_vector(3 downto 0);
signal MemToReg_RE: std_logic;

signal Res_RE: std_logic_vector(31 downto 0);
signal Op3_RE_out : std_logic_vector(3 downto 0);

begin


------------------------------------------------------------------
-- instanciation et mapping du composant fifo
test_RE : entity work.etageER  
    port map (Res_Mem_RE, Res_ALU_RE,
        Op3_RE, 
        MemToReg_RE, 
        Res_RE,
        Op3_RE_out);

------------------------------------------------------------------

P_TEST: process
begin
    

    Res_Mem_RE <= "00000000000000000000000000000101";

    Res_ALU_RE <= "00000000000000000000000000000001";

    MemToReg_RE <= '1';

    Op3_RE <= "0011";

    wait for clkpulse;
    





    wait for clkpulse;
    


    MemToReg_RE <= '0';




    wait for clkpulse;
    


    wait for clkpulse;
    




    wait for clkpulse;
    

    wait for clkpulse;
    


    wait for clkpulse;
    

    wait for clkpulse;
    wait;

end process P_TEST;

end behavior;