
-- Definition des librairies

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Definition de l'entite
entity test_ME is
end test_ME;

-- Definition de l'architecture
architecture behavior of test_ME is

constant TIMEOUT 	: time := 300 ns; -- timeout de la simulation

-- definition de constantes
constant clkpulse : Time := 5 ns; -- 1/2 periode horloge

-- definition de types

-- definition de ressources externes
signal Res_ME, WD_ME: std_logic_vector(31 downto 0);
signal Op3_ME : std_logic_vector(3 downto 0);
signal E_CLK, MemWR_Mem: std_logic;
signal Res_Mem_ME, Res_ALU_ME, Res_fwd_ME: std_logic_vector(31 downto 0);
signal Op3_ME_out : std_logic_vector(3 downto 0);

begin


------------------------------------------------------------------
-- instanciation et mapping du composant fifo
test_ME : entity work.etageME  
    port map (Res_ME, WD_ME,
        Op3_ME, 
        E_CLK, MemWR_Mem, 
        Res_Mem_ME, Res_ALU_ME, Res_fwd_ME,
        Op3_ME_out);

------------------------------------------------------------------

P_TEST: process
begin
    E_CLK <= '0';

    MemWR_Mem <= '1';

    Res_ME<="00000000000000000000000000000001";

    WD_ME <= "00000000000000000000000000000000";

    Op3_ME <= "0101";

    wait for clkpulse;
    E_CLK <= '1';




    wait for clkpulse;
    E_CLK <= '0';

    MemWR_Mem <= '1';

    Res_ME<="00000000000000000000000000000010";

    WD_ME <= "00000000000000000000000000000001";



    wait for clkpulse;
    E_CLK <= '1';


    wait for clkpulse;
    E_CLK <= '0';

    MemWR_Mem <= '0';

    Res_ME<="00000000000000000000000000000001";



    wait for clkpulse;
    E_CLK <= '1';

    wait for clkpulse;
    wait;

end process P_TEST;

end behavior;