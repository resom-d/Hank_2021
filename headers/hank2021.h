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
USHORT *copPtrMain;
USHORT *copPtrIntro;
// pointer to copperlist bitplane pointers for bouncing
USHORT *copScrollerBmpP;
// pointer to copperlist bitplane pointers for pf 1/2 pointers
USHORT *copPF1BmpP;
USHORT *copPF2BmpP;
USHORT *copPF1ColP;
USHORT *copPF2ColP;
// pointer to (re)set mirror effect (change bplmod) in copperlist
USHORT *copMirrorBmpP;
// bitmaps
INCBIN_CHIP(BmpMuerteP, "Art/grfx/muerte.raw")        // load image into chipmem so we can use it without copying
INCBIN_CHIP(BmpLogoP, "Art/grfx/hank_002.raw")        // load image into chipmem so we can use it without copying
INCBIN_CHIP(BmpLogo2P, "Art/grfx/Bastards.raw")        // load image into chipmem so we can use it without copying
INCBIN_CHIP(BmpLogo3P, "Art/grfx/bastard_too.raw")        // load image into chipmem so we can use it without copying
INCBIN_CHIP(BmpLogo4P, "Art/grfx/bastard_three.raw")        // load image into chipmem so we can use it without copying
INCBIN_CHIP(BmpFont32P, "Art/grfx/font_hank.raw") // load image into chipmem so we can use it without copying
INCBIN_CHIP(BmpCookieP, "Art/grfx/cookie2.raw");
INCBIN_CHIP(BmpCookieMaskP, "Art/grfx/cookie2.msk.raw");
BmpDescriptor Screen;
BmpDescriptor BmpMuerte;
BmpDescriptor BmpUpperPart_PF1;
BmpDescriptor BmpUpperPart_PF2;
BmpDescriptor BmpUpperPart_Buf1;
BmpDescriptor BmpLogo;
BmpDescriptor BmpLogo2;
BmpDescriptor BmpLogo3;
BmpDescriptor BmpLogo4;
BmpDescriptor BmpScroller;
BmpDescriptor BmpFont32;
BmpDescriptor BmpCookie;
BmpDescriptor BmpCookieMask;
// Bobs
#define BOBSN (8)
Point2D BobSource[BOBSN] = {
    {0, 0},
    {48, 0},
    {96, 0},
    {144, 0},
    {0, 32},
    {48, 32},
    {0, 32},
    {96, 32}};
Point2D BobTarget[BOBSN] = {
    {0, 46},
    {0, 46},
    {0, 46},
    {0, 46},
    {0, 46},
    {0, 46},
    {0, 46},
    {0, 46}};
Point2D BobVecs[BOBSN] = {
    {2, 0},
    {2, 0},
    {2, 0},
    {2, 0},
    {2, 0},
    {2, 0},
    {2, 0},
    {2, 0}};
USHORT BobPhase = 0;
USHORT BobPause = 0;
// palettes
UWORD muertePaletteRGB4[32] ={
	0x0000,0x0844,0x0777,0x099A,0x0D57,0x0BBC,0x0DEE,0x0D1A,
	0x05B8,0x0FF0,0x0474,0x09A7,0x0254,0x0C00,0x0141,0x07DC,
	0x0111,0x0944,0x0A95,0x06B9,0x05F3,0x0133,0x0599,0x0333,
	0x0554,0x0273,0x0645,0x0992,0x06B7,0x0377,0x0996,0x038B
};
UWORD LogoPaletteRGB4[8] = {
    0x0000,0x0C95,0x0C95,0x0EA6,0x0432,0x0542,0x0430,0x0B81};
UWORD BastardsPaletteRGB4[8] ={
	0x0CCC,0x0FFF,0x0A20,0x0B30,0x0B30,0x0C40,0x0C40,0x0D50
};
UWORD bastard_tooPaletteRGB4[8] ={
	0x0CCC,0x0FFF,0x007C,0x007C,0x006B,0x006B,0x005B,0x005A
};
UWORD bastard_threePaletteRGB4[8] ={
	0x0CCC,0x0FFF,0x0F50,0x0F60,0x0F80,0x0E90,0x0EA0,0x0EB0
};
UWORD *ActPfCol = LogoPaletteRGB4;
UWORD FontPaletteRGB4[8] = {
    0x0000,0x0e80,0x0fc0,0x0080,0x04f4,0x0050,0x03C3,0x04F4};
UWORD CookiePaletteRGB4[8] = {
    0x0000, 0x0066, 0x0077, 0x0088, 0x00A9, 0x00BB, 0x00CC, 0x00DD};
UWORD colgradbluePaletteRGB4[40] = {
    0x0015, 0x0016, 0x0016, 0x0016, 0x0026, 0x0027, 0x0027,
    0x0037, 0x0037, 0x0038, 0x0038, 0x0048, 0x0048, 0x0049, 0x0049,
    0x0059, 0x0059, 0x005A, 0x005A, 0x006A, 0x006A, 0x006B, 0x006B,
    0x007B, 0x007B, 0x007C, 0x008C, 0x008C, 0x008C, 0x008D, 0x009D,
    0x009D, 0x009D, 0x009E, 0x00AE, 0x00AE, 0x00AE, 0x00AF, 0x00BF,
    0x00BF};
UWORD colScrollMirror[] = {0x111, 0x222};
SHORT LogoShowY1 = 0;
SHORT LogoShowY2 = 1;
UBYTE LogoShowPhase = 0;
USHORT LogoShowPause = 1*50;
BOOL LogoShowDone = FALSE;
BOOL LogoDissolveDone = FALSE;
// scrolltext-stuff
#define SCRT_MIN (0)
#define SCRT_MAX (40)
USHORT ScrollerMin = SCRT_MIN;
USHORT ScrollerMax = 4;
SHORT ScrollerY = SCRT_MIN;
BYTE ScrollerDir = 1;
USHORT ScrollCnt;
USHORT NextPlot = 32;
USHORT ScrolltextCnt;
USHORT ScrollerPause = 0;
BOOL BounceEnabled = FALSE;
BOOL MirrorEnabled = FALSE;
BOOL ResetCopper = FALSE;
CONST char Scrolltext[] = "            \
HANK   s1VAN    s1BASTARD s1 PRESENTS: s1     #THE HANK VAN BASTARD SHOW#           \
HEY SCROLLER! YOU DON'T LOOK TOO HAPPY - WHAT'S UP?     I'M BORED! I WANT TO BOUNCE!       \
OK SCROLLER I'LL TRY TO HELP US OUT - WHERE DID I PUT THAT BOUNCE-FLAG? JUST A SECOND....SH..AH THERE.... \
OFF WE GO!bs4        MMHH, THAT'S MUCH BETTER. THANK YOU VERY MUCH!        NEVERMIND - \
BUT STILL NOT HAPPY?        LOOK AT ALL THAT DIRT BELOW ME. WHAT A MESS!     \
OK, OK...GODDA... I'LL TRY MY BEST TO CLEAN IT UP....            \
c m     YES, NICE! I CAN SEE MYSELF IN A MIRROR. CODER, YOU ARE  MY HERO! s6            \
THIS PIECE OF CODE WOULDN'T HAVE BEEN POSSIBLE WITHOUT THE WORK OF LOTS OF PEOPLE \
PROVIDING TOOLS AND PASSING ON KNOWLEDGE. SO I TAKE PLEASURE IN SAYING THANKS TO YOU ALL. \
SPECIAL THANKS TO  PHOTON  s4 OF SCOOPEX FOR HIS LOVELY \
AMIGA HARDWARE PROGRAMMING SERIES 'ASMSKOOL' s4 TO BE WATCHED ON YOUTUBE. THIS DEMO IS BASICALLY THE ATTEMPT TO \
GET DONE WHAT HE SHOWS AND PORTING IT TO THE C PROGRAMMING LANGUAGE.  BUT MEANWHILE I STARTED \
WRITING IN ASSEMBLER AS WELL WHICH I NEVER THOUGHT COULD BE ENJOYABLE - BUT IT'S NEVER TOO EARLY \
AND SELDOMLY TOO LATE :-)        \
ALSO WEI-JU WU s4 FOR HIS SERIES ON YOUTUBE.         \
HANK USES THE AMIGA VSCODE EXTENSION BY BARTMAN  s4OF ABYSS.    \
THANKS FOR THE EXCELLENT WORK DUDES IT'S VERY MUCH APPRECIATED.          SEE YOU MY FRIENDS.                \
IF YOU LIKE WHAT YOU'VE SEEN AND THINK: YES, THAT'S THE KIND OF STUFF I WANT TO MAKE (OR BEYOND) AND YOU'D LIKE TO JOIN FORCES \
FEEL FREE TO CONTACT THE WORLD'S GREATEST BASTARD VIA 'HANKVANBASTARD(A)GMAIL.COM'    \
YES - RIGHT NOW THIS IS A ONE MAN SHOW AND THAT ISN'T ALWAYS THE BEST FUN, SO...              \
BY THE WAY: I USED THE (A) TO INDICATE AN AT INSTEAD OF MY UGLY       NOW IT'S COMING      @     s4     WHOA! WHAT A SHAME!      \
HEY! STOP LAUGHING YOU LOUSY BASTARD! BETTER DESIGN ME A NICER @.       ANY CONTACTS WELCOME.   \
SEND A HELLO TO 'HANKVANBASTARD@GMAIL.COM'          \
REMEMBER: s4      A BASTARD'S WORK IS NEVER DONE.                m b                   \
\0";
// music bin
INCBIN(P61_Player, "Art/music/player610.6.no_cia.bin")
INCBIN_CHIP(module, "Art/music/P61.Hank003")
// sprite data
__attribute__((section("tut.MEMF_CHIP"))) UWORD StarSprite[93 * 4 + 2];
__attribute__((section("tut.MEMF_CHIP"))) UWORD StarSprite2[93 * 4 + 2];
__attribute__((section("tut.MEMF_CHIP"))) UWORD NullSprite[] = {0x1c07, 0x1d00, 0x0000, 0x0000, 0x0000, 0x0000};
// misc
BOOL ONSMousClick;

//proto
void SetInterruptHandler(APTR interrupt);
void WaitVbl(void);
inline void WaitBlt();
void TakeSystem(void);
void FreeSystem(void);

void SetupCopper(USHORT *copPtr);
void SetupCopperIntro(USHORT *copPtr);
void MainLoop(void);
void IntroLoop(void);
void Scrollit(BmpDescriptor theDesc, UBYTE *theBitmap, USHORT startY, USHORT height, UBYTE speed);
void PlotChar(BmpDescriptor bmpFont, BmpDescriptor bmpDest, USHORT plotY, USHORT charW, USHORT charH);
void BounceScroller(USHORT pos);
void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls);
void InitImagePlanes(BmpDescriptor *img, USHORT offs);
USHORT *copSetPlanesInterleafedOddEven(UBYTE bplPtrStart, USHORT *copListEnd, const UBYTE *bitmap, int numPlanes, int Bpl, int offsY, BOOL odd);
USHORT *copSetPlanesInterleafed(UBYTE bplPtrStart, USHORT *copListEnd, const UBYTE *bitmap, int numPlanes, int Bpl, int offsY);
void SimpleBlit(BmpDescriptor imgS, BmpDescriptor imgD, Point2D startS, Point2D startD, USHORT height, USHORT width);
void BetterBlit(BmpDescriptor imgS, BmpDescriptor imgD, BmpDescriptor imgM, Point2D startS, Point2D startD, USHORT height, USHORT width);
void ClearBitmap(BmpDescriptor bmpD, USHORT lines);
void ClearBitmapPart(BmpDescriptor bmp, int x, int y, int height, int width);
void CopyBitmap(BmpDescriptor bmpS, BmpDescriptor bmpD);
void CopyBitmapPart(BmpDescriptor bmpS, BmpDescriptor bmpD, USHORT start, USHORT stop);
void MoveBobs(void);
void SetPixel(BmpDescriptor bitmap, USHORT x, USHORT y, UBYTE col);
void ClearPixel(BmpDescriptor bitmap, USHORT x, USHORT y);
void LineDraw(BmpDescriptor bitmap, int x0, int y0, int x1, int y1, UBYTE col);
void PolygonDraw(BmpDescriptor bitmap, Point2D *pointlist, USHORT length, BYTE col, BOOL closed);
void EllipseDraw(BmpDescriptor bitmap, BYTE col, int xm, int ym, int a, int b);
void SinusDraw(Point2D *targetList, USHORT sinstart, USHORT x, USHORT y, int amp, int width);
void MakePolys();
void EnableMirrorEffect(void);
void DisableMirrorEffect(void);
void InitStarfieldSprite(void);
void MoveStarfield(void);
void BuildLogo(BmpDescriptor d, short mode);
void DissolveLogo(short mode);
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

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
BOOL LogoShowDone = FALSE;
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
// interrupt handler
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