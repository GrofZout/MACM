library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;

library work;


entity test_proc is
end test_proc;


architecture test_dataPath_archi of test_proc is


    constant clkpulse : Time := 5 ns;
    constant TIMEOUT : Time := 275 ns;

    signal eclk,  einit,EALUSrc_EX, EMemWr_Mem, EPCSrc_ER, EBpris_EX, EGel_LI, EGel_DI, ERAZ_DI, ERegWR, EClr_EX, EMemToReg_RE : std_logic;
    signal ERegSrc, EEA_EX, EEB_EX, eimmSrc, EALUCtrl_EX : std_logic_vector(1 downto 0);
    signal einstr_DE: std_logic_vector(31 downto 0);
    signal ea1, ea2, ereg1_de, ereg2_de,ECC,EOp3_out_EX,EOp3_out_ME,EOp3_out_RE: std_logic_vector(3 downto 0);

begin


P_TIMEOUT: process
begin
	wait for TIMEOUT;
	assert FALSE report "SIMULATION TIMEOUT!!!" severity FAILURE;
end process P_TIMEOUT;


clock : process
    begin
	    eclk <= '1';
	    wait for clkpulse;
	    eclk <= '0';
	    wait for clkpulse;
end process clock;


me_test : entity work.dataPath(dataPath_arch)
				PORT MAP (eclk,  einit,EALUSrc_EX, EMemWr_Mem, EPCSrc_ER, EBpris_EX, EGel_LI, EGel_DI, ERAZ_DI, ERegWR, EClr_EX, EMemToReg_RE,
                ERegSrc, EEA_EX, EEB_EX, eimmSrc, EALUCtrl_EX,
                einstr_DE,
                ea1,ea2,ereg1_de,ereg2_de,ECC ,EOp3_out_EX,EOp3_out_ME,EOp3_out_RE);

test : process
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

    --instruction 1 étage 2

    ERegSrc <= "10";
    eimmSrc <= "00";


    wait for clkpulse*2;

    --instruction 3 étage 1
    --instruction 2 étage 2
    --instruction 1 étage 3


    EALUSrc_EX <= '1';
    EALUCtrl_EX <= "00";



    wait for clkpulse*2;

    --instruction 4 étage 1
    --instruction 3 étage 2
    --instruction 2 étage 3
    --instruction 1 étage 4


    wait for clkpulse*2;

    --instruction 5 étage 1
    --instruction 4 étage 2
    --instruction 3 étage 3
    --instruction 2 étage 4
    --instruction 1 étage 5

    

    wait for clkpulse*2;


    --instruction 6 étage 1
    --instruction 5 étage 2
    --instruction 4 étage 3
    --instruction 3 étage 4
    --instruction 2 étage 5

    EALUSrc_EX <= '1';
    EEA_EX <=  "10";

    wait for clkpulse*2;

    --instruction 7 étage 1
    --instruction 6 étage 2
    --instruction 5 étage 3
    --instruction 4 étage 4
    --instruction 3 étage 5

    EALUSrc_EX <= '0';
    EEA_EX <=  "00";
    EMemWr_Mem <= '1';


    wait for clkpulse*2;

    --instruction 7 étage 2
    --instruction 6 étage 3
    --instruction 5 étage 4
    --instruction 4 étage 5

    EMemWr_Mem <= '0';

    wait for clkpulse*2;

    --instruction 7 etage 3
    --instruction 6 étage 4
    --instruction 5 étage 5

    wait for clkpulse*2;

    --instruction 7 etage 4
    --instruction 6 étage 5

    wait for clkpulse*2;

    wait for clkpulse*2;

    EMemToReg_RE <= '1';

    wait for clkpulse;
end process test;
end test_dataPath_archi;