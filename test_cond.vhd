
-- Definition des librairies

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Definition de l'entite
entity test_cond is
end test_cond;

-- Definition de l'architecture
architecture behavior of test_cond is

constant TIMEOUT 	: time := 300 ns; -- timeout de la simulation

-- definition de constantes
constant clkpulse : Time := 5 ns; -- 1/2 periode horloge

-- definition de types

-- definition de ressources externes
signal CCWr_EX : std_logic;
signal Cond, CC_EX, CC : std_logic_vector(3 downto 0);
signal CondEx : std_logic;
signal CCp : std_logic_vector(3 downto 0);

begin


------------------------------------------------------------------
-- instanciation et mapping du composant fifo
test_cond : entity work.Cond  
    port map (CCWr_EX,
        Cond, CC_EX, CC, 
        CondEx, 
        CCp);

------------------------------------------------------------------

P_TEST: process
begin
    
    Cond <= "0000";

    CC_EX <= "1011";

    CCWr_EX <= '1';

    CC <= "0000";

    wait for clkpulse;
    
    CC_EX <= "0100";


    wait for clkpulse;



    wait for clkpulse;

    


    wait for clkpulse;
    




    wait for clkpulse;
    

    wait for clkpulse;
    


    wait for clkpulse;
    

    wait for clkpulse;
    wait;

end process P_TEST;

end behavior;