#if !defined(HANK_2021)
#define HANK_2021

#define MUSIC

#include "../support/gcc8_c_support.h"
#include "custom_defines.h"
#include "vector.h"
#include "DemoTypes.h"
#include <proto/exec.h>
#include <exec/execbase.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <graphics/gfxbase.h>
#include <graphics/view.h>
#include <graphics/gfxmacros.h>
#include <hardware/custom.h>
#include <hardware/dmabits.h>
#include <hardware/intbits.h>
#include <utility/tagitem.h>
#include <proto/utility.h>
#include <clib/intuition_protos.h>

#ifdef __cplusplus
class TestClass
{
public:
    TestClass(int y)
    {
        static int x = 7;
        i = y + x;
    }

    int i;
};

TestClass staticClass(4);
#endif

void *doynaxdepack(const void *input, void *output)
{ // returns end of output data, input needs to be 16-bit aligned!
    register volatile const void *_a0 ASM("a0") = input;
    register volatile void *_a1 ASM("a1") = output;
    __asm volatile(
        "movem.l %%d0-%%d7/%%a2-%%a6,-(%%sp)\n"
        "jsr _doynaxdepack_asm\n"
        "movem.l (%%sp)+,%%d0-%%d7/%%a2-%%a6"
        : "+rf"(_a0), "+rf"(_a1)
        :
        : "cc", "memory");
    return (void *)_a1;
}

static APTR GetVBR(void);
APTR GetInterruptHandler(void);
#define Abs(a) (a < 0 ? a * -1 : a)

//libs
struct ExecBase *SysBase;
volatile struct Custom *custom;
struct DosLibrary *DOSBase;
struct GfxBase *GfxBase;
volatile short frameCounter = 0;

//backup
static UWORD SystemInts;
static UWORD SystemDMA;
static UWORD SystemADKCON;
static volatile APTR VBR = 0;
static APTR SystemIrq;
// active view
struct View *ActiView;
USHORT *copPtr;
// interrupt handler

// bitmaps
INCBIN_CHIP(BmpLogoP, "Art/grfx/hank_002.raw")               // load image into chipmem so we can use it without copying
INCBIN_CHIP(BmpFont32P, "Art/grfx/320x256x3_32x32_font.raw") // load image into chipmem so we can use it without copying
INCBIN_CHIP(BmpCookieP, "Art/grfx/cookie2.raw");
INCBIN_CHIP(BmpCookieMaskP, "Art/grfx/cookie2Mask.raw");
BmpDescriptor Screen;
BmpDescriptor BmpUpperPart_PF1;
BmpDescriptor BmpUpperPart_PF2;
BmpDescriptor BmpUpperPart_Buf1;
BmpDescriptor BmpLogo;
BmpDescriptor BmpScroller;
;
BmpDescriptor BmpFont32;
BmpDescriptor BmpCookie;
BmpDescriptor BmpCookieMask;
// palettes
UWORD LogoPaletteRGB4[8] = {
    0x0000, 0x0556, 0x0C95, 0x0EA6, 0x0432, 0x0531, 0x0212, 0x0881};
UWORD FontPaletteRGB4[8] = {
    0x0BF0,0x08F0,0x06F0,0x03F0,0x01F0,0x00F1,0x00F4,0x00F6};
UWORD CookiePaletteRGB4[8] = {
    0x0000,0x0066,0x0077,0x0088,0x00A9,0x00BB,0x00CC,0x00DD};
UWORD colgradbluePaletteRGB4[40] = {
    0x0015,0x0016,0x0016,0x0016,0x0026,0x0027,0x0027,
	0x0037,0x0037,0x0038,0x0038,0x0048,0x0048,0x0049,0x0049,
	0x0059,0x0059,0x005A,0x005A,0x006A,0x006A,0x006B,0x006B,
	0x007B,0x007B,0x007C,0x008C,0x008C,0x008C,0x008D,0x009D,
	0x009D,0x009D,0x009E,0x00AE,0x00AE,0x00AE,0x00AF,0x00BF,
	0x00BF};

 
// scrolltext-stuff
#define SCRT_MIN (0)
#define SCRT_MAX (40)
USHORT ScrollerMin = SCRT_MIN;
USHORT ScrollerMax = SCRT_MAX;
SHORT ScrollerY = SCRT_MAX - 24;
BYTE ScrollerDir = -1;
USHORT ScrollCnt;
USHORT ScrolltextCnt;
BOOL BounceEnabled = FALSE;
BOOL MirrorEnabled = FALSE;
// pointer to copperlist bitplane pointers for bouncing
USHORT *copScrollerBmpP;
// pointer to (re)set mirror effect (change bplmod) in copperlist
USHORT *copMirrorBmpP;
CONST char Scrolltext[] = "\
HANK VAN BASTARD PRESENTS: THE HANK VAN BASTARD SHOW           \
HEY SCROLLER! YOU DON'T LOOK TOO HAPPY - WHAT'S UP?  I WANT TO BOUNCE! ME IS A POOR SCROLLER NOBODY LOVES ME. \
OH, DEAR SCROLLER I'LL TRY TO HELP US OUT - WHERE DID I PUT THAT BOUNCE-FLAG? JUST A MOMENT....AH! THERE!....b  \
OOPS!     OH, THAT'S MUCH BETTER. THANK YOU VERY MUCH! NEVERMIND. \
BUT STILL NOT HAPPY?   LOOK AT ALL THAT DIRT BELOW ME. WHAT A MESS!  \
OK, OK... I'LL TRY MY BEST TO CLEAN IT UP ....            \
m     YES! NICE! I CAN SEE MYSELF IN A MIRROR. CODER, YOU ARE MY HERO!           \
SEE YOU MY FRIENDS.                 bm\
\0";
// music bin
INCBIN(P61_Player, "Art/music/player610.6.no_cia.bin")
INCBIN_CHIP(module, "Art/music/chipper.p61")

//proto
void SetInterruptHandler(APTR interrupt);
void WaitVbl(void);
inline void WaitBlt();
void TakeSystem(void);
void FreeSystem(void);
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
inline short MouseRight() { return !((*(volatile UWORD *)0xdff016) & (1 << 10)); }
// set up a 320x256 lowres display
inline USHORT *screenScanDefault(USHORT *copListEnd)
{
    const USHORT x = 129;
    const USHORT width = 320;
    const USHORT height = 256;
    const USHORT y = 44;
    const USHORT RES = 8; //8=lowres,4=hires
    USHORT xstop = x + width;
    USHORT ystop = y + height;
    USHORT fw = (x >> 1) - RES;

    *copListEnd++ = DDFSTRT;
    *copListEnd++ = fw;
    *copListEnd++ = DDFSTOP;
    *copListEnd++ = fw + (((width >> 4) - 1) << 3);
    *copListEnd++ = DIWSTRT;
    *copListEnd++ = x + (y << 8);
    *copListEnd++ = DIWSTOP;
    *copListEnd++ = (xstop - 256) + ((ystop - 256) << 8);
    return copListEnd;
}
inline int powerOf(int b, int e)
{
    int r = b;

    for (UBYTE i = 0; i < e; i++)
        r *= b;

    return r;
}
inline USHORT *copSetPlanes(UBYTE bplPtrStart, USHORT *copListEnd, const UBYTE **planes, int numPlanes)
{
    for (USHORT i = 0; i < numPlanes; i++)
    {
        ULONG addr = (ULONG)planes[i];
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
        *copListEnd++ = (UWORD)addr; // high-word of adress
    }
    return copListEnd;
}
inline USHORT *copSetPlanesInterleafed(UBYTE bplPtrStart, USHORT *copListEnd, const UBYTE *bitmap, int numPlanes, int Bpl, int offsY)
{
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    for (USHORT i = 0; i < numPlanes; i++)
    {
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
        *copListEnd++ = (UWORD)addr; // high-word of adress
        addr += Bpl;
    }
    return copListEnd;
}
inline USHORT *copSetPlanesInterleafedOddEven(UBYTE bplPtrStart, USHORT *copListEnd, const UBYTE *bitmap, int numPlanes, int Bpl, int offsY, BOOL odd)
{
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    BYTE plane = odd ? 1 : 0;
    for (USHORT i = 0; i < numPlanes; i++)
    {
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
        *copListEnd++ = (UWORD)addr; // high-word of adress
        addr += Bpl;
        plane += 2;
    }
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    *copListEnd++ = modOdd;
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    *copListEnd++ = modEven;
    return copListEnd;
}
inline USHORT *copWaitXY(USHORT *copListEnd, USHORT x, USHORT i)
{
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    *copListEnd++ = COP_WAIT;
    return copListEnd;
}
inline USHORT *copWaitY(USHORT *copListEnd, USHORT i)
{
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    *copListEnd++ = COP_WAIT;
    return copListEnd;
}
inline USHORT *copSkipY(USHORT *copListEnd, USHORT i)
{
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    *copListEnd++ = COP_SKIP;
    return copListEnd;
}
inline USHORT *copSkipXY(USHORT *copListEnd, USHORT x, USHORT i)
{
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    *copListEnd++ = COP_SKIP;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    *copListCurrent++ = color;
    return copListCurrent;
}
void SetupCopper(USHORT *copPtr);
void MainLoop(void);
void Scrollit(BmpDescriptor theDesc, UBYTE *theBitmap, USHORT startY, USHORT height, UBYTE speed);
void PlotChar(BmpDescriptor bmpFont, UBYTE *bmpFontP, BmpDescriptor bmpDest, UBYTE *bmpDestP, USHORT plotY, USHORT charW, USHORT charH);
void BounceScroller(USHORT pos);
void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls);
void InitImagePlanes(BmpDescriptor *img);
void SimpleBlit(BmpDescriptor imgS, BmpDescriptor imgD, Point2D startS, Point2D startD, USHORT height, USHORT width);
void BetterBlit(BmpDescriptor imgS, BmpDescriptor imgD, BmpDescriptor imgM, Point2D startS, Point2D startD, USHORT height, USHORT width);
void ClearBitmap(BmpDescriptor bmpD, USHORT lines);
void CopyBitmap(BmpDescriptor bmpS, BmpDescriptor bmpD);
void SetPixel(BmpDescriptor bitmap, USHORT x, USHORT y, UBYTE col);
void LineDraw(BmpDescriptor bitmap, int x0, int y0, int x1, int y1, UBYTE col);
void PolygonDraw(BmpDescriptor bitmap, Point2D *pointlist, USHORT length, BYTE col, BOOL closed);
void EllipseDraw(BmpDescriptor bitmap, BYTE col, int xm, int ym, int a, int b);
void SinusDraw(Point2D *targetList, USHORT sinstart, USHORT x, USHORT y, int amp, int width);
void MakePolys();
void EnableMirrorEffect(void);
void DisableMirrorEffect(void);
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

static __attribute__((interrupt)) void interruptHandler()
{

    custom->intreq = (1 << INTB_VERTB);
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.

    // DEMO - ThePlayer
    p61Music();

    // DEMO - increment frameCounter
    frameCounter++;
}

#endif // HANK_2021