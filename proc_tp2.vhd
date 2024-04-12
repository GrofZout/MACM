-------------------------------------------------------

-- Chemin de données

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity dataPath is
  port(
    clk,  init, ALUSrc_EX, MemWr_Mem, MemWr_RE, PCSrc_ER, Bpris_EX, Gel_LI, Gel_DI, RAZ_DI, RegWR, Clr_EX, MemToReg_RE : in std_logic;
    RegSrc, EA_EX, EB_EX, immSrc, ALUCtrl_EX : in std_logic_vector(1 downto 0);
    instr_DE: out std_logic_vector(31 downto 0);
    a1, a2, rs1, rs2, CC, op3_EX_out, op3_ME_out, op3_RE_out: out std_logic_vector(3 downto 0)
);      
end entity;

architecture dataPath_arch of dataPath is
  signal Res_RE, npc_fwd_br, pc_plus_4, i_FE, i_DE, Op1_DE, Op2_DE, Op1_EX, Op2_EX, extImm_DE, extImm_EX, Res_EX, Res_ME, WD_EX, WD_ME, Res_Mem_ME, Res_Mem_RE, Res_ALU_ME, Res_ALU_RE, Res_fwd_ME : std_logic_vector(31 downto 0);
  signal Op3_DE, Op3_EX, a1_DE, a1_EX, a2_DE, a2_EX, Op3_EX_out_t, Op3_ME, Op3_ME_out_t, Op3_RE, Op3_RE_out_t : std_logic_vector(3 downto 0);
begin

  -- FE
  FE : entity work.etageFE  
    port map (Res_RE, npc_fwd_br, 
    PCSrc_ER, Bpris_EX, Gel_LI, clk,
    pc_plus_4, i_FE);
 
  -- DE


  reg_DE : entity work.Reg32sync
    port map(
    i_FE,
    i_DE,
    Gel_DI, RAZ_DI, clk);

  instr_DE <= i_DE;

  Decodeur : entity work.Decodeur
    port map(
      instr => i_DE,
      PCSrc, RegWr, MemToReg, MemWr, Branch, CCWr, AluSrc,
      AluCtrl, ImmSrc, RegSrc,
      Cond);

  DE : entity work.etageDE  
    port map (
    i_DE => i_DE, WD_ER => Res_RE, pc_plus_4 => pc_plus_4,
    Op3_ER => Op3_RE_out_t,
    RegSrc => RegSrc, immSrc => immSrc,
    RegWr => RegWR, clk => clk, Init => init,
    Reg1 => a1_DE, Reg2 => a2_DE, Op3_DE => Op3_DE,
    Op1 => Op1_DE, Op2 => Op2_DE, extImm => extImm_DE);





  -- EX
  reg_EX_Op1 : entity work.Reg32sync
    port map(
    Op1_DE,
    Op1_EX,
    Clr_EX, '1', clk);


  reg_EX_Op2 : entity work.Reg32sync
    port map(
    Op2_DE,
    Op2_EX,
    Clr_EX, '1', clk);

  reg_EX_Imm : entity work.Reg32sync
    port map(
    extImm_DE,
    extImm_EX,
    Clr_EX, '1', clk);

  reg_EX_Op3 : entity work.Reg4
    port map(
    Op3_DE,
    Op3_EX,
    Clr_EX, '1', clk);

  reg_EX_a1 : entity work.Reg4
    port map(
    a1_DE,
    a1_EX,
    Clr_EX, '1', clk);

  reg_EX_a2 : entity work.Reg4
    port map(
    a2_DE,
    a2_EX,
    Clr_EX, '1', clk);

  
  a1 <= a1_EX;
  a2 <= a2_EX;


  Cond : entity work.Cond
    port map(
      CCWr_EX,
      Cond, CC_EX, CC,
      CondEx,
      CCp);



  EX : entity work.etageEX 
  port map (
    Op1_EX => Op1_EX, Op2_EX => Op2_EX, ExtImm_EX => extImm_EX, Res_fwd_ME => Res_fwd_ME, Res_fwd_ER => Res_RE,
    Op3_EX => Op3_EX,
    EA_EX => EA_EX, EB_EX => EB_EX, ALUCtrl_EX => ALUCtrl_EX,
    ALUSrc_EX => ALUSrc_EX,
    CC => CC, Op3_EX_out => Op3_EX_out_t,
    Res_EX => Res_EX, WD_EX => WD_EX, npc_fw_br => npc_fwd_br);

    Op3_EX_out <= Op3_EX_out_t;
 
  -- ME


  reg_ME_Res : entity work.Reg32sync
    port map(
    Res_EX,
    Res_ME,
    '1', '1', clk);

  reg_ME_WD : entity work.Reg32sync
    port map(
    WD_EX,
    WD_ME,
    '1', '1', clk);


  reg_ME_Op3 : entity work.Reg4
    port map(
    Op3_EX_out_t,
    Op3_ME,
    '1', '1', clk);


  ME : entity work.etageME
  port map (
    Res_ME => Res_ME, WD_ME => WD_ME,
    Op3_ME => Op3_ME,
    clk => clk, MemWR_Mem => MemWR_Mem,

    Res_Mem_ME => Res_Mem_ME, Res_ALU_ME => Res_ALU_ME, Res_fwd_ME => Res_fwd_ME,
    Op3_ME_out => Op3_ME_out_t);

    Op3_ME_out <= Op3_ME_out_t;
 
  -- RE

  reg_RE_Res : entity work.Reg32sync
    port map(
    Res_Mem_ME,
    Res_Mem_RE,
    '1', '1', clk);

  reg_RE_Alu : entity work.Reg32sync
    port map(
    Res_ALU_ME,
    Res_ALU_RE,
    '1', '1', clk);


  reg_RE_Op3 : entity work.Reg4
    port map(
    Op3_ME_out_t,
    Op3_RE,
    '1', '1', clk);
  

  RE : entity work.etageER
  port map (
    Res_Mem_RE => Res_Mem_RE, Res_ALU_RE => Res_ALU_RE,
    Op3_RE => Op3_RE,
    MemToReg_RE => MemToReg_RE,

    Res_RE => Res_RE,
    Op3_RE_out => Op3_RE_out_t);


  Op3_RE_out <= Op3_RE_out_t;

 
  
end architecture;
