-------------------------------------------------------

-- Chemin de données

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity dataPath is
  port(
    clk,  init, ALUSrc_EX, MemWr_Mem, PCSrc_ER, Bpris_EX, Gel_LI, Gel_DI, RAZ_DI, RegWR, Clr_EX, MemToReg_RE : in std_logic;
    RegSrc, EA_EX, EB_EX, immSrc, ALUCtrl_EX : in std_logic_vector(1 downto 0);
    instr_DE: out std_logic_vector(31 downto 0);
    a1, a2, rs1, rs2, CC, op3_EX_out, op3_ME_out, op3_RE_out: out std_logic_vector(3 downto 0)
);      
end entity;

architecture dataPath_arch of dataPath is
  signal Res_RE, npc_fwd_br, pc_plus_4, i_FE, i_DE, Op1_DE, Op2_DE, Op1_EX, Op2_EX, extImm_DE, extImm_EX, Res_EX, Res_ME, WD_EX, WD_ME, Res_Mem_ME, Res_Mem_RE, Res_ALU_ME, Res_ALU_RE, Res_fwd_ME : std_logic_vector(31 downto 0);
  signal Op3_DE, Op3_EX, a1_DE, a1_EX, a2_DE, a2_EX, Op3_EX_out_t, Op3_ME, Op3_ME_out_t, Op3_RE, Op3_RE_out_t : std_logic_vector(3 downto 0);

  signal ImmSrc_t, RegSrc_t : std_logic_vector(1 downto 0);
  signal RegWR_DE, RegWR_EX, RegWR_ME, RegWR_RE, RegWR_And : std_logic;
  signal PCSrc_DE, PCSrc_EX, PCSrc_ME, PCSrc_And, PCSrc_RE : std_logic;
  signal CCWR_DE, CCWr_EX_t : std_logic;
  signal MemWR_DE, MemWR_EX, MemWR_And, MemWR_ME: std_logic;
  signal AluCtrl_DE, AluCtrl_EX_t: std_logic_vector(1 downto 0);
  signal Branch_DE, Branch_EX, Branch_And: std_logic;
  signal MemToReg_DE, MemToReg_EX, MemToReg_ME, MemToReg_RE_t: std_logic;
  signal ALUSrc_DE, ALUSrc_EX_t: std_logic;
  signal Cond, Cond_t: std_logic_vector(3 downto 0);

  signal CCp, CC_EX, CC_t : std_logic_vector(3 downto 0);
  signal CondEX : std_logic;
begin

  -- FE
  FE : entity work.etageFE  
    port map (Res_RE, npc_fwd_br, 
    PCSrc_RE, Branch_And, Gel_LI, clk,
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
      PCSrc => PCSrc_DE, RegWr => RegWR_DE, MemToReg => MemToReg_DE, MemWr => MemWR_DE, Branch => Branch_DE, CCWr => CCWR_DE, AluSrc => ALUSrc_DE,
      AluCtrl => AluCtrl_DE, ImmSrc => ImmSrc_t, RegSrc =>RegSrc_t,
      Cond => Cond);

  

  DE : entity work.etageDE  
    port map (
    i_DE => i_DE, WD_ER => Res_RE, pc_plus_4 => pc_plus_4,
    Op3_ER => Op3_RE_out_t,
    RegSrc => RegSrc, immSrc => immSrc,
    RegWr => RegWR_RE, clk => clk, Init => init,
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


  -- TP2

  reg_EX_Reg : entity work.Reg1
    port map(
    RegWR_DE,
    RegWR_EX,
    Clr_EX, '1', clk);


  reg_EX_PC : entity work.Reg1
    port map(
    PCSrc_DE,
    PCSrc_EX,
    Clr_EX, '1', clk);

  reg_EX_CC : entity work.Reg1
    port map(
    CCWR_DE,
    CCWR_EX_t,
    Clr_EX, '1', clk);

  reg_EX_Mem : entity work.Reg1
    port map(
      MemWR_DE,
      MemWR_EX,
    Clr_EX, '1', clk);

  reg_EX_Alu : entity work.Reg2
    port map(
      AluCtrl_DE,
      AluCtrl_EX_t,
    Clr_EX, '1', clk);

  reg_EX_Branch : entity work.Reg1
    port map(
      Branch_DE,
      Branch_EX,
    Clr_EX, '1', clk);

  
  reg_EX_MemTo: entity work.Reg1
    port map(
      MemToReg_DE,
      MemToReg_EX,
    Clr_EX, '1', clk);

    reg_EX_AluScr: entity work.Reg1
    port map(
      ALUSrc_DE,
      ALUSrc_EX_t,
    Clr_EX, '1', clk);

    reg_EX_Cond: entity work.Reg4
    port map(
      i_DE(31 downto 28),
      Cond_t,
      Clr_EX, '1', clk
    );
  





  EX : entity work.etageEX 
  port map (
    Op1_EX => Op1_EX, Op2_EX => Op2_EX, ExtImm_EX => extImm_EX, Res_fwd_ME => Res_fwd_ME, Res_fwd_ER => Res_RE,
    Op3_EX => Op3_EX,
    EA_EX => EA_EX, EB_EX => EB_EX, ALUCtrl_EX => AluCtrl_EX_t,
    ALUSrc_EX => ALUSrc_EX_t,
    CC => CC_t, Op3_EX_out => Op3_EX_out_t,
    Res_EX => Res_EX, WD_EX => WD_EX, npc_fw_br => npc_fwd_br);

    Op3_EX_out <= Op3_EX_out_t;

    CC <= CC_t;


  Cond_entity : entity work.Cond
    port map(
      CCWr_EX => CCWR_EX_t,
      Cond => Cond_t, CC_EX => CC_EX, CC => CC_t,
      CondEx => CondEx,
      CCp => CCp);

  reg_EX_CCp : entity work.Reg4
    port map(
      CCp,
      CC_EX,
      Clr_EX, '1', clk);
  
  -- And

  RegWR_And <= RegWR_EX when CondEx='1' else '0';
  PCSrc_And <= PCSrc_EX when CondEx='1' else '0';
  MemWR_And <= MemWR_EX when CondEx='1' else '0';
  Branch_And <= Branch_EX when CondEx='1' else '0';
  
 
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


  -- TP2

  reg_ME_Reg : entity work.Reg1
    port map(
    RegWR_And,
    RegWR_ME,
    '1', '1', clk);

  reg_ME_PC : entity work.Reg1
    port map(
    PCSrc_And,
    PCSrc_ME,
    '1', '1', clk);


  reg_ME_Mem : entity work.Reg1
    port map(
      MemWR_And,
      MemWR_ME,
    '1', '1', clk);


  reg_Me_MemTo: entity work.Reg1
    port map(
      MemToReg_EX,
      MemToReg_ME,
    '1', '1', clk);




  ME : entity work.etageME
  port map (
    Res_ME => Res_ME, WD_ME => WD_ME,
    Op3_ME => Op3_ME,
    clk => clk, MemWR_Mem => MemWR_ME,

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


  reg_RE_Reg : entity work.Reg1
    port map(
      RegWR_ME,
    RegWR_RE,
    '1', '1', clk);


  reg_RE_PC : entity work.Reg1
    port map(
      PCSrc_ME,
      PCSrc_RE,
    '1', '1', clk);

  
  reg_RE_MemTo: entity work.Reg1
    port map(
      MemToReg_ME,
      MemToReg_RE_t,
    '1', '1', clk);
  

  RE : entity work.etageER
  port map (
    Res_Mem_RE => Res_Mem_RE, Res_ALU_RE => Res_ALU_RE,
    Op3_RE => Op3_RE,
    MemToReg_RE => MemToReg_RE_t,

    Res_RE => Res_RE,
    Op3_RE_out => Op3_RE_out_t);


  Op3_RE_out <= Op3_RE_out_t;

 
  
end architecture;
