-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


package GBA.Memory.IO_Registers is

  pragma Preelaborate;

  -- Display Registers --

  DISPCNT   : constant Address := 16#4000000#;
  GREENSWAP : constant Address := 16#4000002#;
  DISPSTAT  : constant Address := 16#4000004#;
  VCOUNT    : constant Address := 16#4000006#;

  BG0CNT    : constant Address := 16#4000008#;
  BG1CNT    : constant Address := 16#400000A#;
  BG2CNT    : constant Address := 16#400000C#;
  BG3CNT    : constant Address := 16#400000E#;

  BG0HOFS   : constant Address := 16#4000010#;
  BG0VOFS   : constant Address := 16#4000012#;
  BG1HOFS   : constant Address := 16#4000014#;
  BG1VOFS   : constant Address := 16#4000016#;
  BG2HOFS   : constant Address := 16#4000018#;
  BG2VOFS   : constant Address := 16#400001A#;
  BG3HOFS   : constant Address := 16#400001C#;
  BG3VOFS   : constant Address := 16#400001E#;

  BG2PA     : constant Address := 16#4000020#;
  BG2PB     : constant Address := 16#4000022#;
  BG2PC     : constant Address := 16#4000024#;
  BG2PD     : constant Address := 16#4000026#;
  BG2X      : constant Address := 16#4000028#;
  BG2Y      : constant Address := 16#400002C#;

  BG3PA     : constant Address := 16#4000030#;
  BG3PB     : constant Address := 16#4000032#;
  BG3PC     : constant Address := 16#4000034#;
  BG3PD     : constant Address := 16#4000036#;
  BG3X      : constant Address := 16#4000038#;
  BG3Y      : constant Address := 16#400003C#;

  WIN0H     : constant Address := 16#4000040#;
  WIN1H     : constant Address := 16#4000042#;
  WIN0V     : constant Address := 16#4000044#;
  WIN1V     : constant Address := 16#4000046#;

  WININ     : constant Address := 16#4000048#;
  WINOUT    : constant Address := 16#400004A#;

  MOSAIC    : constant Address := 16#400004C#;

  BLDCNT    : constant Address := 16#4000050#;
  BLDALPHA  : constant Address := 16#4000052#;
  BLDY      : constant Address := 16#4000054#;


  -- Sound Registers --

  SOUND1CNT_L : constant Address := 16#4000060#;
  SOUND1CNT_H : constant Address := 16#4000062#;
  SOUND1CNT_X : constant Address := 16#4000064#;

  SOUND2CNT_L : constant Address := 16#4000068#;
  SOUND2CNT_H : constant Address := 16#400006C#;

  SOUND3CNT_L : constant Address := 16#4000070#;
  SOUND3CNT_H : constant Address := 16#4000072#;
  SOUND3CNT_X : constant Address := 16#4000074#;

  SOUND4CNT_L : constant Address := 16#4000078#;
  SOUND4CNT_H : constant Address := 16#400007C#;

  SOUNDCNT_L  : constant Address := 16#4000080#;
  SOUNDCNT_H  : constant Address := 16#4000082#;
  SOUNDCNT_X  : constant Address := 16#4000084#;

  SOUNDBIAS   : constant Address := 16#4000088#;

  WAVE_RAM    : constant Address := 16#4000090#;

  FIFO_A      : constant Address := 16#40000A0#;
  FIFO_B      : constant Address := 16#40000A4#;


  -- DMA Transfer Registers --

  DMA0SAD   : constant Address := 16#40000B0#;
  DMA0DAD   : constant Address := 16#40000B4#;
  DMA0CNT_L : constant Address := 16#40000B8#;
  DMA0CNT_H : constant Address := 16#40000BA#;

  DMA1SAD   : constant Address := 16#40000BC#;
  DMA1DAD   : constant Address := 16#40000C0#;
  DMA1CNT_L : constant Address := 16#40000C4#;
  DMA1CNT_H : constant Address := 16#40000C6#;

  DMA2SAD   : constant Address := 16#40000C8#;
  DMA2DAD   : constant Address := 16#40000CC#;
  DMA2CNT_L : constant Address := 16#40000D0#;
  DMA2CNT_H : constant Address := 16#40000D2#;

  DMA3SAD   : constant Address := 16#40000D4#;
  DMA3DAD   : constant Address := 16#40000D8#;
  DMA3CNT_L : constant Address := 16#40000DC#;
  DMA3CNT_H : constant Address := 16#40000DE#;


  -- Timer Registers --

  TM0CNT_L : constant Address := 16#4000100#;
  TM0CNT_H : constant Address := 16#4000102#;

  TM1CNT_L : constant Address := 16#4000104#;
  TM1CNT_H : constant Address := 16#4000106#;

  TM2CNT_L : constant Address := 16#4000108#;
  TM2CNT_H : constant Address := 16#400010A#;

  TM3CNT_L : constant Address := 16#400010C#;
  TM3CNT_H : constant Address := 16#400010E#;


  -- Serial Communication Registers (1) --

  SIODATA32   : constant Address := 16#4000120#;
  SIOMULTI0   : constant Address := 16#4000120#;
  SIOMULTI1   : constant Address := 16#4000122#;
  SIOMULTI2   : constant Address := 16#4000124#;
  SIOMULTI3   : constant Address := 16#4000126#;
  SIOCNT      : constant Address := 16#4000128#;
  SIOMLT_SEND : constant Address := 16#400012A#;
  SIODATA8    : constant Address := 16#400012A#;


  -- Keypad Input Registers --

  KEYINPUT : constant Address := 16#4000130#;
  KEYCNT   : constant Address := 16#4000132#;


  -- Serial Communication Registers (2) --

  RCNT      : constant Address := 16#4000134#;
  JOYCNT    : constant Address := 16#4000140#;
  JOY_RECV  : constant Address := 16#4000150#;
  JOY_TRANS : constant Address := 16#4000154#;
  JOYSTAT   : constant Address := 16#4000158#;


  -- Interrupt and CPU Control Registers --

  IE      : constant Address := 16#4000200#;
  IRF     : constant Address := 16#4000202#;
  WAITCNT : constant Address := 16#4000204#;
  IME     : constant Address := 16#4000208#;

  POSTFLG : constant Address := 16#4000300#;
  HALTCNT : constant Address := 16#4000301#;

end GBA.Memory.IO_Registers;