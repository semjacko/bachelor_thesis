#include "sigar.h"

static sigar_version_t sigar_version = {
    "unknown",
    "unknown",
    "1.6.4",
    "sigar",
    "libsigar",
    "sigar",
    "SIGAR-1.6.4, "
    "SCM revision unknown, "
    "built unknown as unknown",
    1,
    6,
    4,
    0
};

SIGAR_DECLARE(sigar_version_t *) sigar_version_get(void)
{
    return &sigar_version;
}
