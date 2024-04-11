
-- Definition des librairies

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Definition de l'entite
entity test_deco is
end test_deco;

-- Definition de l'architecture
architecture behavior of test_deco is

constant TIMEOUT 	: time := 300 ns; -- timeout de la simulation

-- definition de constantes
constant clkpulse : Time := 5 ns; -- 1/2 periode horloge

-- definition de types

-- definition de ressources externes
signal instr : std_logic_vector(31 downto 0);
signal PCSrc, RegWr, MemToReg, MemWr, Branch, CCWr, AluSrc  : std_logic;
signal AluCtrl, ImmSrc, RegSrc : std_logic_vector(1 downto 0);
signal Cond : std_logic_vector(3 downto 0);

begin


------------------------------------------------------------------
-- instanciation et mapping du composant fifo
test_deco : entity work.Decodeur  
    port map (instr,
        PCSrc, RegWr, MemToReg, MemWr, Branch, CCWr, AluSrc, 
        AluCtrl, ImmSrc, RegSrc, 
        Cond);

------------------------------------------------------------------

P_TEST: process
begin
    
    instr <= x"e0810002";
    

    wait for clkpulse;
    

    instr <= x"e081f002";



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