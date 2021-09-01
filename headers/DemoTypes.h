#include <exec/execbase.h>

struct _bmpDescriptor
{
    /// Width
    USHORT Width;
    /// Height
    USHORT Height;
    /// Bitplanes
    USHORT Bpls;
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
/// <summary>
/// USHORT Width     - Width
/// USHORT Height    - Height
/// USHORT Bpls      - No of bitplanes
/// USHORT Bpl       - Bytes per Line
/// USHORT Bplt      - Bytes per Line total
/// USHORT Bpp       - Bytes per bitplane
/// USHORT Btot      - Bytes per bitmap
/// UWORD *ImageData - Pointer to bitmap data
/// UBYTE *Planes    - Pointers to bitplanes
/// </summary>
typedef struct _bmpDescriptor BmpDescriptor;

