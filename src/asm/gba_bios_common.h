/*
 * Copyright (c) 2022 Devin Hill
 * zlib License -- see LICENSE for details.
 */

#ifndef BIOS_FN_NAME
#define BIOS_FN_NAME(name) name
#endif

#ifndef BIOS_SVC_NUM
#define BIOS_SVC_NUM(value) value
#endif

void BIOS_FN_NAME(soft_reset) (void)
{
  __asm__ volatile (
    "svc %[code] \n\t" :: [code] "I"(BIOS_SVC_NUM(0x00)) : "r0", "r1", "r2", "r3", "memory"
  );
}

void BIOS_FN_NAME(hard_reset) (void)
{
  __asm__ volatile (
    "svc %[code] \n\t" :: [code] "I"(BIOS_SVC_NUM(0x26)) : "r0", "r1", "r2", "r3", "memory"
  );
}

void BIOS_FN_NAME(halt) (void)
{
  __asm__ volatile (
    "svc %[code] \n\t" :: [code] "I"(BIOS_SVC_NUM(0x02)) : "r0", "r1", "r2", "r3"
  );
}

void BIOS_FN_NAME(stop) (void)
{
  __asm__ volatile (
    "svc %[code] \n\t" :: [code] "I"(BIOS_SVC_NUM(0x03)) : "r0", "r1", "r2", "r3"
  );
}

void BIOS_FN_NAME(wait_for_interrupt) (register int32_t a0, register int32_t a1)
{
  register int32_t r0 asm("r0") = a0;
  register int32_t r1 asm("r1") = a1;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1) : [code] "I"(BIOS_SVC_NUM(0x04)) : "r2", "r3"
  );
}

void BIOS_FN_NAME(wait_for_vblank) (void)
{
  __asm__ volatile (
    "svc %[code] \n\t" :: [code] "I"(BIOS_SVC_NUM(0x05)) : "r0", "r1", "r2", "r3"
  );
}

uint64_t BIOS_FN_NAME(div_mod) (register int32_t a0, register int32_t a1)
{
  register int32_t r0 asm("r0") = a0;
  register int32_t r1 asm("r1") = a1;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1) : [code] "I"(BIOS_SVC_NUM(0x06)) : "r2", "r3"
  );
  return r0 | ((uint64_t)r1 << 32);
}

uint64_t BIOS_FN_NAME(div_mod_arm) (register int32_t a0, register int32_t a1)
{
  register int32_t r0 asm("r0") = a0;
  register int32_t r1 asm("r1") = a1;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1) : [code] "I"(BIOS_SVC_NUM(0x07)) : "r2", "r3"
  );
  return r0 | ((uint64_t)r1 << 32);
}

uint16_t BIOS_FN_NAME(sqrt) (register uint32_t a0)
{
  register int32_t r0 asm("r0") = a0;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0) : [code] "I"(BIOS_SVC_NUM(0x08)) : "r1", "r2", "r3"
  );
  return (uint16_t) r0;
}

uint16_t BIOS_FN_NAME(arc_tan) (register int16_t a0, register int16_t a1)
{
  register int32_t r0 asm("r0") = a0;
  register int32_t r1 asm("r1") = a1;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1) : [code] "I"(BIOS_SVC_NUM(0x09)) : "r2", "r3"
  );
  return (uint16_t) r0;
}

uint16_t BIOS_FN_NAME(arc_tan2) (register int16_t a0, register int16_t a1)
{
  register int32_t r0 asm("r0") = a0;
  register int32_t r1 asm("r1") = a1;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1) : [code] "I"(BIOS_SVC_NUM(0x0A)) : "r2", "r3"
  );
  return (uint16_t) r0;
}

void BIOS_FN_NAME(cpu_set) (register void *a0, register void *a1, register uint32_t a2)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  register int32_t r2 asm("r2") = a2;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1), "+r"(r2) : [code] "I"(BIOS_SVC_NUM(0x0B)) : "r3", "memory"
  );
}

void BIOS_FN_NAME(cpu_fast_set) (register void *a0, register void *a1, register uint32_t a2)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  register int32_t r2 asm("r2") = a2;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1), "+r"(r2) : [code] "I"(BIOS_SVC_NUM(0x0C)) : "r3", "memory"
  );
}

uint32_t BIOS_FN_NAME(get_bios_checksum) (void)
{
  register uint32_t r0 asm("r0");
  __asm__ volatile (
    "svc %[code] \n\t" : "=r"(r0) : [code] "I"(BIOS_SVC_NUM(0x0D)) : "r1", "r2", "r3", "memory"
  );
  return r0;
}

void BIOS_FN_NAME(bg_affine_set) (register void *a0, register void *a1, register int32_t a2)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  register int32_t r2 asm("r2") = a2;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1), "+r"(r2) : [code] "I"(BIOS_SVC_NUM(0x0E)) : "r3", "memory"
  );
}

void BIOS_FN_NAME(obj_affine_set) (register void *a0, register void *a1, register int32_t a2, register int32_t a3)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  register int32_t r2 asm("r2") = a2;
  register int32_t r3 asm("r3") = a3;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1), "+r"(r2), "+r"(r3) : [code] "I"(BIOS_SVC_NUM(0x0F)) : "memory"
  );
}

void BIOS_FN_NAME(bit_unpack) (register void *a0, register void *a1, register void *a2)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  register void *r2 asm("r2") = a2;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1), "+r"(r2) : [code] "I"(BIOS_SVC_NUM(0x10)) : "r3", "memory"
  );
}

void BIOS_FN_NAME(lz77_decompress_write8) (register void *a0, register void *a1)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1) : [code] "I"(BIOS_SVC_NUM(0x11)) : "r2", "r3", "memory"
  );
}

void BIOS_FN_NAME(lz77_decompress_write16) (register void *a0, register void *a1)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1) : [code] "I"(BIOS_SVC_NUM(0x12)) : "r2", "r3", "memory"
  );
}

void BIOS_FN_NAME(huff_decompress_write32) (register void *a0, register void *a1)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1) : [code] "I"(BIOS_SVC_NUM(0x13)) : "r2", "r3", "memory"
  );
}

void BIOS_FN_NAME(rl_decompress_write8) (register void *a0, register void *a1)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1) : [code] "I"(BIOS_SVC_NUM(0x14)) : "r2", "r3", "memory"
  );
}

void BIOS_FN_NAME(rl_decompress_write16) (register void *a0, register void *a1)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1) : [code] "I"(BIOS_SVC_NUM(0x15)) : "r2", "r3", "memory"
  );
}

void BIOS_FN_NAME(diff_unfilter8_write8) (register void *a0, register void *a1, register void *a2)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  register void *r2 asm("r2") = a2;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1), "+r"(r2) : [code] "I"(BIOS_SVC_NUM(0x16)) : "r3", "memory"
  );
}

void BIOS_FN_NAME(diff_unfilter8_write16) (register void *a0, register void *a1, register void *a2)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  register void *r2 asm("r2") = a2;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1), "+r"(r2) : [code] "I"(BIOS_SVC_NUM(0x17)) : "r3", "memory"
  );
}

void BIOS_FN_NAME(diff_unfilter16_write16) (register void *a0, register void *a1, register void *a2)
{
  register void *r0 asm("r0") = a0;
  register void *r1 asm("r1") = a1;
  register void *r2 asm("r2") = a2;
  __asm__ volatile (
    "svc %[code] \n\t" : "+r"(r0), "+r"(r1), "+r"(r2) : [code] "I"(BIOS_SVC_NUM(0x18)) : "r3", "memory"
  );
}