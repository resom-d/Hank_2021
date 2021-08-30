#if !defined(HANK_2021)
#define HANK_2021

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

void* doynaxdepack(const void* input, void* output) { // returns end of output data, input needs to be 16-bit aligned!
	register volatile const void* _a0 ASM("a0") = input;
	register volatile       void* _a1 ASM("a1") = output;
	__asm volatile (
		"movem.l %%d0-%%d7/%%a2-%%a6,-(%%sp)\n"
		"jsr _doynaxdepack_asm\n"
		"movem.l (%%sp)+,%%d0-%%d7/%%a2-%%a6"
	: "+rf"(_a0), "+rf"(_a1)
	:
	: "cc", "memory");
	return (void*)_a1;
}

#define Abs(a) (a < 0 ? a * -1 : a)
#define SHIFT_PADDING (16)

/// <summary>
/// USHORT Width   - Width
/// USHORT Height  - Height
/// USHORT Bpls    - No of bitplanes
/// USHORT NoCols  - No of Colors (2**Bpls)
/// USHORT Bpl     - Bytes per Line
/// USHORT Bplt    - Bytes per Line total
/// USHORT Bpp     - Bytes per bitplane
/// USHORT Btot    - Bytes per bitmap total
/// </summary>

INCBIN_CHIP(BmpLogoP, "Art/grfx/hank_002.raw")               // load image into chipmem so we can use it without copying
INCBIN_CHIP(BmpFont32P, "Art/grfx/320x256x3_32x32_font.raw") // load image into chipmem so we can use it without copying
INCBIN_CHIP(BmpCookieP, "Art/grfx/cookie.raw");
INCBIN_CHIP(BmpCookieMaskP, "Art/grfx/cookieMask.raw");
BmpDescriptor Screen = {320, 256, 3, 8, 320 / 8, 320 / 8 * 3, 320 / 8 * 256, 320 / 8 * 256 * 3, NULL, NULL};
BmpDescriptor BmpWork = {320 + 32, 256, 3, 8, (320 + 32) / 8, (320 + 32) / 8 * 3, (320 + 32) / 8 * 256, (320 + 32) / 8 * 256 * 3, NULL, NULL};
BmpDescriptor BmpLogo = {256, 130, 3, 8, 256 / 8, 256 / 8 * 3, 256 / 8 * 130, 256 / 8 * 130 * 3, NULL, NULL};
BmpDescriptor BmpFont32 = {320, 256, 3, 16, 320 / 8, 320 / 8 * 3, 320 / 8 * 256, 320 / 8 * 256 * 3, NULL, NULL};
BmpDescriptor BmpCookie = {320, 256, 3, 8, 320 / 8, 320 / 8 * 3, 320 / 8 * 256, 320 / 8 * 256 * 3, NULL, NULL};
BmpDescriptor BmpCookieMask = {320 + 32, 256, 1, 8, (320 + 32) / 8, (320 + 32) / 8 * 1, (320 + 32) / 8 * 256, (320 + 32) / 8 * 256 * 1, NULL, NULL};

UWORD LogoPaletteRGB4[8] =
    {
        0x0000, 0x0556, 0x0C95, 0x0EA6, 0x0432, 0x0531, 0x0212, 0x0881};
UWORD FontPaletteRGB4[8] =
    {
        0x0000, 0x0017, 0x0259, 0x036A, 0x048B, 0x05BD, 0x06DE, 0x08FF};
UWORD CookiePaletteRGB4[8] =
{
	0x00CC,0x0FFF,0x0A20,0x0B40,0x0C70,0x0D90,0x0EB0,0x0080
};
//libs
struct ExecBase *
    SysBase;
volatile struct Custom *custom;
struct DosLibrary *DOSBase;
struct GfxBase *GfxBase;
volatile short frameCounter = 0;

//backup
static UWORD SystemInts;
static UWORD SystemDMA;
static UWORD SystemADKCON;
static volatile  APTR VBR = 0;
static APTR SystemIrq;
// active view
struct View *ActiView;
USHORT *copPtr;
// Pointers to bitmaps
UWORD *BmpWorkP;
// Scrolltext-stuff
USHORT ScollerMin = 0;
USHORT ScollerMax = 30;
SHORT ScrollerY = 0;
BYTE ScrollerDir = 2;
USHORT ScrollCnt;
USHORT ScrolltextCnt;
BOOL BounceEnabled = FALSE;
USHORT *copScrollerBmpP;

BOOL MirrorEnabled = FALSE;
USHORT *copMirrorBmpP;

CONST char Scrolltext[] = "\
HANK VAN BASTARD PRESENTS: THE HANK VAN BASTARD SHOW           \
HEY SCROLLER! YOU DON'T LOOK TOO HAPPY - WHAT'S UP?  I WANT TO BOUNCE! ME IS A POOR SCROLLER NOBODY LOVES ME.         \
OK SCROLLER I'LL TRY TO HELP US OUT - BUT THAT MAY TAKE A WHILE. DON'T BOTHER WE WILL FIND A WAY TO           \
FLY!a!!          OH, THAT'S MUCH BETTER. THANK YOU VERY MUCH!       THAT WAS THE LEAST I COULD DO.   \
BUT? STILL NOT HAPPY?   LOOK AT ALL THAT DIRT BELOW ME. WHAT A MESS!  \
OK, OK... I'LL TRY MY BEST AND ....          bYES! NICE! I CAN SEE MYSELF IN A MIRROR. CODER, YOU ARE MY HERO!   \
SEE YOU MY FRIENDS.               ab\
\0";

// DEMO - INCBIN
INCBIN(player, "Art/music/player610.6.no_cia.bin")
INCBIN_CHIP(module, "Art/music/chipper.p61")

//proto
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
    UBYTE po = odd ? 1: 0;
    for (USHORT i = 0; i < numPlanes; i++)
    {
        *copListEnd++ = offsetof(struct Custom, bplpt[po + bplPtrStart]);
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
        *copListEnd++ = offsetof(struct Custom, bplpt[po + bplPtrStart]) + 2;
        *copListEnd++ = (UWORD)addr; // high-word of adress
        addr += Bpl;
        po +=2;
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

inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    *copListCurrent++ = color;
    return copListCurrent;
}

void InitImagePlanes(BmpDescriptor *img);

void SinusDraw(Point2D *targetList, USHORT sinstart, USHORT x, USHORT y, int amp, int width);

void SetPixel(BmpDescriptor bitmap, USHORT x, USHORT y, UBYTE col);

void LineDraw(BmpDescriptor bitmap, int x0, int y0, int x1, int y1, UBYTE col);

void PolygonDraw(BmpDescriptor bitmap, Point2D *pointlist, USHORT length, BYTE col, BOOL closed);

void Points2DRotate(Point2D *pointsA, Point2D *pointsB, USHORT length, Point2D origin, int alpha);

void EllipseDraw(BmpDescriptor bitmap, BYTE col, int xm, int ym, int a, int b);

void CopyBitmap(BmpDescriptor bmpS, BmpDescriptor bmpD);

void ClearBitmap(BmpDescriptor bmpD);

void MakePolys();

void SimpleBlit(BmpDescriptor imgS, BmpDescriptor imgD, Point2D startS, Point2D startD, USHORT height, USHORT width);

void GetCookieMask(UBYTE planes, UBYTE **bmp, UBYTE *destMask, USHORT height, USHORT width);

void ImageToImgContainer(struct Image *img, BmpDescriptor *imgC);

void MainLoop(void);
static APTR GetVBR(void);
void SetInterruptHandler(APTR interrupt);
APTR GetInterruptHandler(void);
void WaitVbl(void);
inline void WaitBlt();
void TakeSystem(void);
void FreeSystem(void);

void SetupCopper(USHORT *copPtr);
void BounceScroller(USHORT pos);
void Scrollit(BmpDescriptor theDesc, UBYTE *theBitmap, USHORT startY, USHORT height, UBYTE speed);
void PlotChar(BmpDescriptor bmpFont, UBYTE *bmpFontP, BmpDescriptor bmpDest, UBYTE *bmpDestP, USHORT plotY, USHORT charW, USHORT charH);
void ClearBitmap(BmpDescriptor bmpD);
void CopyBitmap(BmpDescriptor bmpS, BmpDescriptor bmpD);
void BlitObject(BmpDescriptor bobs, BmpDescriptor background, UBYTE *maskData, int tilex, int tiley, int dstx, int dsty, int height, int width);
void EnableMirrorEffect(void);
void DisableMirrorEffect(void);
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

static __attribute__((interrupt)) void interruptHandler() {

	custom->intreq=(1<<INTB_VERTB); 
	custom->intreq=(1<<INTB_VERTB); //reset vbl req. twice for a4000 bug.

	// DEMO - ThePlayer
	p61Music();

	// DEMO - increment frameCounter
	frameCounter++;
}

#endif // HANK_2021