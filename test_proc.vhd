
-- Definition des librairies

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
library work;

-- Definition de l'entite
entity test_proc is
end test_proc;

-- Definition de l'architecture
architecture behavior of test_proc is

constant TIMEOUT 	: time := 300 ns; -- timeout de la simulation

-- definition de constantes
constant clkpulse : Time := 5 ns; -- 1/2 periode horloge

-- definition de types

-- definition de ressources externes
signal eclk,  init,EALUSrc_EX, EMemWr_Mem, PCSrc_ER, Bpris_EX, Gel_LI, Gel_DI, RAZ_DI, RegWr, Clr_EX, MemToReg_RE : std_logic;
signal RegSrc, EA_EX, EB_EX, immSrc, ALUCtrl_EX : std_logic_vector(1 downto 0);
signal instr_DE: std_logic_vector(31 downto 0);
signal a1, a2, reg1_de, reg2_de,CC,Op3_out_EX,Op3_out_ME,Op3_out_RE: std_logic_vector(3 downto 0);


begin


------------------------------------------------------------------
-- instanciation et mapping du composant fifo
test_P : entity work.dataPath(dataPath_arch)
        port map (eclk,  init,EALUSrc_EX, EMemWr_Mem, PCSrc_ER, Bpris_EX, Gel_LI, Gel_DI, RAZ_DI, RegWr, Clr_EX, MemToReg_RE,
                RegSrc, EA_EX, EB_EX, immSrc, ALUCtrl_EX,
                instr_DE,
                a1,a2,reg1_de,reg2_de,CC ,Op3_out_EX,Op3_out_ME,Op3_out_RE);

------------------------------------------------------------------

P_TEST: process
begin

    --J'utilise ce fichier de test pour le proc tp1 et tp2. Je pense que les deux versions marchent, je n'ai pas eu le temps de faire le TP3
    init <= '1';

    wait for clkpulse;


    EB_EX <= "00";
    RegSrc <= "10";
    RegWr <= '1';
    init <= '0';
    PCSrc_ER <= '0';
    Bpris_EX <= '0';
    immSrc <= "10";
    ALUCtrl_EX <= "00";
    EALUSrc_EX <= '0';
    EMemWr_Mem <= '0';
    MemToReg_RE <= '0';
    EA_EX <= "00";
    Gel_LI <= '1';
    Gel_DI <= '1';
    RAZ_DI <= '1';
    Clr_EX <= '1';

    wait for clkpulse;

    RegSrc <= "10";
    immSrc <= "00";


    wait for clkpulse;



    EALUSrc_EX <= '1';
    ALUCtrl_EX <= "00";



    wait for clkpulse;



    wait for clkpulse;



    wait for clkpulse;



    EALUSrc_EX <= '1';
    EA_EX <=  "10";

    wait for clkpulse;


    EALUSrc_EX <= '0';
    EA_EX <=  "00";
    EMemWr_Mem <= '1';


    wait for clkpulse;


    EMemWr_Mem <= '0';

    wait for clkpulse;



    wait for clkpulse;


    wait for clkpulse;

    wait for clkpulse;

    MemToReg_RE <= '1';

    wait for clkpulse;
    wait;

end process P_TEST;

end behavior;