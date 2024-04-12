
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
signal eclk,  einit,EALUSrc_EX, EMemWr_Mem, EPCSrc_ER, EBpris_EX, EGel_LI, EGel_DI, ERAZ_DI, ERegWR, EClr_EX, EMemToReg_RE : std_logic;
signal ERegSrc, EEA_EX, EEB_EX, eimmSrc, EALUCtrl_EX : std_logic_vector(1 downto 0);
signal einstr_DE: std_logic_vector(31 downto 0);
signal ea1, ea2, ereg1_de, ereg2_de,ECC,EOp3_out_EX,EOp3_out_ME,EOp3_out_RE: std_logic_vector(3 downto 0);


begin


------------------------------------------------------------------
-- instanciation et mapping du composant fifo
test_P : entity work.dataPath(dataPath_arch)
        port map (eclk,  einit,EALUSrc_EX, EMemWr_Mem, EPCSrc_ER, EBpris_EX, EGel_LI, EGel_DI, ERAZ_DI, ERegWR, EClr_EX, EMemToReg_RE,
                ERegSrc, EEA_EX, EEB_EX, eimmSrc, EALUCtrl_EX,
                einstr_DE,
                ea1,ea2,ereg1_de,ereg2_de,ECC ,EOp3_out_EX,EOp3_out_ME,EOp3_out_RE);

------------------------------------------------------------------

P_TEST: process
begin
    einit <= '1';

    wait for clkpulse;

    EPCSrc_ER <= '0';
    EBpris_EX <= '0';
    EGel_LI <= '1';
    EGel_DI <= '1';
    ERAZ_DI <= '1';
    EClr_EX <= '1';
    eimmSrc <= "10";
    EALUCtrl_EX <= "00";
    EALUSrc_EX <= '0';
    EMemWr_Mem <= '0';
    EMemToReg_RE <= '0';
    EEA_EX <= "00";
    EEB_EX <= "00";
    ERegSrc <= "10";
    ERegWr <= '1';
    einit <= '0';

    wait for clkpulse;

    ERegSrc <= "10";
    eimmSrc <= "00";


    wait for clkpulse*2;



    EALUSrc_EX <= '1';
    EALUCtrl_EX <= "00";



    wait for clkpulse*2;



    wait for clkpulse*2;



    wait for clkpulse*2;



    EALUSrc_EX <= '1';
    EEA_EX <=  "10";

    wait for clkpulse*2;


    EALUSrc_EX <= '0';
    EEA_EX <=  "00";
    EMemWr_Mem <= '1';


    wait for clkpulse*2;


    EMemWr_Mem <= '0';

    wait for clkpulse*2;



    wait for clkpulse*2;


    wait for clkpulse*2;

    wait for clkpulse*2;

    EMemToReg_RE <= '1';

    wait for clkpulse;
    wait;

end process P_TEST;

end behavior;