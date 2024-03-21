
-- Definition des librairies

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Definition de l'entite
entity test_fetch is
end test_fetch;

-- Definition de l'architecture
architecture behavior of test_fetch is

constant TIMEOUT 	: time := 300 ns; -- timeout de la simulation

-- definition de constantes
constant clkpulse : Time := 5 ns; -- 1/2 periode horloge

-- definition de types

-- definition de ressources externes
signal E_CLK    				: std_logic;
signal E_npc, E_npc_fw_br       : std_logic_vector(31 downto 0);
signal E_PCSrc_ER, E_Bpris_EX, E_GEL_LI : std_logic;
signal E_pc_plus_4, E_i_FE      : std_logic_vector(31 downto 0);

begin


------------------------------------------------------------------
-- instanciation et mapping du composant fifo
test_FE : entity work.etageFE  
            port map (E_npc, E_npc_fw_br, 
            E_PCSrc_ER, E_Bpris_EX, E_GEL_LI, E_CLK,
            E_pc_plus_4, E_i_FE);

------------------------------------------------------------------

P_TEST: process
begin
    --instanciation pc_reg_in =2
    E_CLK <= '0';

    E_npc <= (1=>'1', others =>'0');
    E_npc_fw_br <= (4=>'1', others => '0');
    E_PCSrc_ER <= '1';
    E_Bpris_EX <= '0';
    E_GEL_LI <= '1';

    wait for clkpulse;
    -- pc_reg_out = 2, pc_reg_in =6
    E_CLK <= '1';

    E_PCSrc_ER <= '0';

    wait for clkpulse;
    E_CLK <= '0';

    -- GEL
    E_GEL_LI <= '0';

    --pc_reg_in change de valeur
    E_Bpris_EX <= '1';

    wait for clkpulse;
    E_CLK <= '1';
    -- pc_reg_out = 2

    wait for clkpulse;
    wait;

end process P_TEST;

end behavior;