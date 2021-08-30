#include <exec/execbase.h>

struct _bmpDescriptor
{
    /// Width
    USHORT Width;
    /// Height
    USHORT Height;
    /// Bitplanes
    USHORT Bpls;
    /// No. colors
    USHORT NoCols;
    /// Bytes per line
    USHORT Bpl;
    /// Bytes per line total (BPL*BPLS)
    USHORT Bplt;
    /// Bytes per bitplane
    USHORT Bpp;
    /// Bytes per bitmap
    USHORT Btot;

    UWORD *ImageData;
    UBYTE *Planes[8];
};
typedef struct _bmpDescriptor BmpDescriptor;

