
-- Definition des librairies

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Definition de l'entite
entity test_EX is
end test_EX;

-- Definition de l'architecture
architecture behavior of test_EX is

constant TIMEOUT 	: time := 300 ns; -- timeout de la simulation

-- definition de constantes
constant clkpulse : Time := 5 ns; -- 1/2 periode horloge

-- definition de types

-- definition de ressources externes
signal Op1_EX, Op2_EX, ExtImm_EX, Res_fwd_ME, Res_fwd_ER: std_logic_vector(31 downto 0);
signal Op3_EX: std_logic_vector(3 downto 0);
signal EA_EX, EB_EX, ALUCtrl_EX: std_logic_vector(1 downto 0);
signal ALUSrc_EX: std_logic;
signal CC, Op3_EX_out: std_logic_vector(3 downto 0);
signal Res_EX, WD_EX, npc_fw_br: std_logic_vector(31 downto 0);

begin


------------------------------------------------------------------
-- instanciation et mapping du composant fifo
test_EX : entity work.etageEX  
    port map (Op1_EX, Op2_EX, ExtImm_EX, Res_fwd_ME, Res_fwd_ER,
        Op3_EX, 
        EA_EX, EB_EX, ALUCtrl_EX, 
        ALUSrc_EX,
        CC, Op3_EX_out,
        Res_EX, WD_EX, npc_fw_br);

------------------------------------------------------------------

P_TEST: process
begin

    --Test un peu random pour voir si les output sont correct
    

    Op1_EX <= "00000000000000000000000000000101";

    Op2_EX <= "00000000000000000000000000000001";

    ExtImm_EX <= "00000000000000000000000000000000";

    Res_fwd_ME <= "00000000000000000000000000001000";

    Res_fwd_ER <= "00000000000000000000000000001001";

    EA_EX <= "00";

    EB_EX <= "00";

    ALUSrc_EX <= '0';

    Op3_EX <= "0011";

    -- ADD
    ALUCtrl_EX <= "00";

    wait for clkpulse;
    





    wait for clkpulse;
    


    ALUSrc_EX <= '1';




    wait for clkpulse;
    


    wait for clkpulse;
    

    ALUSrc_EX <= '0';



    wait for clkpulse;
    

    wait for clkpulse;
    

    EA_EX <= "01";

    wait for clkpulse;
    

    wait for clkpulse;
    wait;

end process P_TEST;

end behavior;