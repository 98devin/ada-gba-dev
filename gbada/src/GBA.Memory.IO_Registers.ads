
package GBA.Memory.IO_Registers is

  pragma Preelaborate;
  

  -- Display Registers --

  DISPCNT   : constant := 16#4000000#;
  GREENSWAP : constant := 16#4000002#;
  DISPSTAT  : constant := 16#4000004#;
  VCOUNT    : constant := 16#4000006#;
  
  BG0CNT    : constant := 16#4000008#;
  BG1CNT    : constant := 16#400000A#;
  BG2CNT    : constant := 16#400000C#;
  BG3CNT    : constant := 16#400000E#;

  BG0HOFS   : constant := 16#4000010#;
  BG0VOFS   : constant := 16#4000012#;
  BG1HOFS   : constant := 16#4000014#;
  BG1VOFS   : constant := 16#4000016#;
  BG2HOFS   : constant := 16#4000018#;
  BG2VOFS   : constant := 16#400001A#;
  BG3HOFS   : constant := 16#400001C#;
  BG3VOFS   : constant := 16#400001E#;

  BG2PA     : constant := 16#4000020#;
  BG2PB     : constant := 16#4000022#;
  BG2PC     : constant := 16#4000024#;
  BG2PD     : constant := 16#4000026#;
  BG2X      : constant := 16#4000028#;
  BG2Y      : constant := 16#400002C#;
    
  BG3PA     : constant := 16#4000030#;
  BG3PB     : constant := 16#4000032#;
  BG3PC     : constant := 16#4000034#;
  BG3PD     : constant := 16#4000036#;
  BG3X      : constant := 16#4000038#;
  BG3Y      : constant := 16#400003C#;

  WIN0H     : constant := 16#4000040#;
  WIN1H     : constant := 16#4000042#;
  WIN0V     : constant := 16#4000044#;
  WIN1V     : constant := 16#4000046#;

  WININ     : constant := 16#4000048#;
  WINOUT    : constant := 16#400004A#; 

  MOSAIC    : constant := 16#400004C#;

  BLDCNT    : constant := 16#4000050#;
  BLDALPHA  : constant := 16#4000052#;
  BLDY      : constant := 16#4000054#;


  -- Sound Registers --

  SOUND1CNT_L : constant := 16#4000060#;
  SOUND1CNT_H : constant := 16#4000062#;
  SOUND1CNT_X : constant := 16#4000064#;
  
  SOUND2CNT_L : constant := 16#4000068#;
  SOUND2CNT_H : constant := 16#400006C#;
  
  SOUND3CNT_L : constant := 16#4000070#;
  SOUND3CNT_H : constant := 16#4000072#;
  SOUND3CNT_X : constant := 16#4000074#;
  
  SOUND4CNT_L : constant := 16#4000078#;
  SOUND4CNT_H : constant := 16#400007C#;
  
  SOUNDCNT_L  : constant := 16#4000080#;
  SOUNDCNT_H  : constant := 16#4000082#;
  SOUNDCNT_X  : constant := 16#4000084#;

  SOUNDBIAS   : constant := 16#4000088#;
  
  WAVE_RAM    : constant := 16#4000090#;
  
  FIFO_A      : constant := 16#40000A0#;
  FIFO_B      : constant := 16#40000A4#;


  -- DMA Transfer Registers --

  DMA0SAD   : constant := 16#40000B0#;
  DMA0DAD   : constant := 16#40000B4#;
  DMA0CNT_L : constant := 16#40000B8#;
  DMA0CNT_H : constant := 16#40000BA#;

  DMA1SAD   : constant := 16#40000BC#;
  DMA1DAD   : constant := 16#40000C0#;
  DMA1CNT_L : constant := 16#40000C4#;
  DMA1CNT_H : constant := 16#40000C6#;
  
  DMA2SAD   : constant := 16#40000C8#;
  DMA2DAD   : constant := 16#40000CC#;
  DMA2CNT_L : constant := 16#40000D0#;
  DMA2CNT_H : constant := 16#40000D2#;
  
  DMA3SAD   : constant := 16#40000D4#;
  DMA3DAD   : constant := 16#40000D8#;
  DMA3CNT_L : constant := 16#40000DC#;
  DMA3CNT_H : constant := 16#40000DE#;

  
  -- Timer Registers --

  TM0CNT_L : constant := 16#4000100#;
  TM0CNT_H : constant := 16#4000102#;

  TM1CNT_L : constant := 16#4000104#;
  TM1CNT_H : constant := 16#4000106#;
  
  TM2CNT_L : constant := 16#4000108#;
  TM2CNT_H : constant := 16#400010A#;
  
  TM3CNT_L : constant := 16#400010C#;
  TM3CNT_H : constant := 16#400010E#;


  -- Serial Communication Registers (1) --

  SIODATA32   : constant := 16#4000120#;
  SIOMULTI0   : constant := 16#4000120#;
  SIOMULTI1   : constant := 16#4000122#;
  SIOMULTI2   : constant := 16#4000124#;
  SIOMULTI3   : constant := 16#4000126#;
  SIOCNT      : constant := 16#4000128#;
  SIOMLT_SEND : constant := 16#400012A#;
  SIODATA8    : constant := 16#400012A#;  


  -- Keypad Input Registers --

  KEYINPUT : constant := 16#4000130#;
  KEYCNT   : constant := 16#4000132#;


  -- Serial Communication Registers (2) --

  RCNT      : constant := 16#4000134#;
  JOYCNT    : constant := 16#4000140#;
  JOY_RECV  : constant := 16#4000150#;
  JOY_TRANS : constant := 16#4000154#;
  JOYSTAT   : constant := 16#4000158#;


  -- Interrupt and CPU Control Registers --

  IE      : constant := 16#4000200#;
  IRF     : constant := 16#4000202#;
  WAITCNT : constant := 16#4000204#;
  IME     : constant := 16#4000208#;

  POSTFLG : constant := 16#4000300#;
  HALTCNT : constant := 16#4000301#;



end GBA.Memory.IO_Registers;