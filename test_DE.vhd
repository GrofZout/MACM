
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
signal RegWr, clk, Init : std_logic;
signal Reg1, Reg2, Op3_DE : std_logic_vector(3 downto 0);
signal Op1, Op2, extImm : std_logic_vector(31 downto 0);

begin


------------------------------------------------------------------
-- instanciation et mapping du composant fifo
test_DE : entity work.etageFE  
            port map (i_DE, WD_ER, pc_plus_4
            Op3_ER, 
            RegSrc, immSrc, 
            RegWr, clk, Init,
            Reg1, Reg2, Op3_DE,
            Op1, Op2, extImm);

------------------------------------------------------------------

P_TEST: process
begin
    --instanciation pc_reg_in =2
    E_CLK <= '0';

    E_npc <= (2=>'1', others =>'0');
    E_npc_fw_br <= (3=>'1', others => '0');
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
    E_CLK <= '0';

    E_GEL_LI <= '1';
    E_PCSrc_ER <= '0';
    E_Bpris_EX <= '0';

    wait for clkpulse;
    E_CLK <= '1';

    wait for clkpulse;
    wait;

end process P_TEST;

end behavior;