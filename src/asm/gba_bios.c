/*
 * Copyright (c) 2022 Devin Hill
 * zlib License -- see LICENSE for details.
 */


#include <stdint.h>
#include <stdbool.h>

#define BIOS_FN_NAME(name) __attribute__((target("arm"))) bios_arm__ ## name
#define BIOS_SVC_NUM(value) (value << 16)

#include "gba_bios_common.h"

#undef BIOS_FN_NAME
#undef BIOS_SVC_NUM


#define BIOS_FN_NAME(name) __attribute__((target("thumb"))) bios_thumb__ ## name
#define BIOS_SVC_NUM(value) value

#include "gba_bios_common.h"

#undef BIOS_FN_NAME
#undef BIOS_SVC_NUM

