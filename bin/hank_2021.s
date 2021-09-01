
bin/hank_2021.elf:     file format elf32-m68k


Disassembly of section .text:

00000000 <_start>:
extern void (*__init_array_start[])() __attribute__((weak));
extern void (*__init_array_end[])() __attribute__((weak));
extern void (*__fini_array_start[])() __attribute__((weak));
extern void (*__fini_array_end[])() __attribute__((weak));

__attribute__((used)) __attribute__((section(".text.unlikely"))) void _start() {
       0:	movem.l d2-d3/a2,-(sp)
	// initialize globals, ctors etc.
	unsigned long count;
	unsigned long i;

	count = __preinit_array_end - __preinit_array_start;
       4:	move.l #16384,d3
       a:	subi.l #16384,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	beq.s 26 <_start+0x26>
      14:	lea 4000 <ScrollerY>,a2
      1a:	moveq #0,d2
		__preinit_array_start[i]();
      1c:	movea.l (a2)+,a0
      1e:	jsr (a0)
	for (i = 0; i < count; i++)
      20:	addq.l #1,d2
      22:	cmp.l d3,d2
      24:	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	move.l #16384,d3
      2c:	subi.l #16384,d3
      32:	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	beq.s 48 <_start+0x48>
      36:	lea 4000 <ScrollerY>,a2
      3c:	moveq #0,d2
		__init_array_start[i]();
      3e:	movea.l (a2)+,a0
      40:	jsr (a0)
	for (i = 0; i < count; i++)
      42:	addq.l #1,d2
      44:	cmp.l d3,d2
      46:	bne.s 3e <_start+0x3e>

	main();
      48:	jsr 74 <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
      4e:	move.l #16384,d2
      54:	subi.l #16384,d2
      5a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	beq.s 6e <_start+0x6e>
      5e:	lea 4000 <ScrollerY>,a2
		__fini_array_start[i - 1]();
      64:	subq.l #1,d2
      66:	movea.l -(a2),a0
      68:	jsr (a0)
	for (i = count; i > 0; i--)
      6a:	tst.l d2
      6c:	bne.s 64 <_start+0x64>
}
      6e:	movem.l (sp)+,d2-d3/a2
      72:	rts

00000074 <main>:
#include "headers/hank2021.h"

int main()
{
      74:	lea -136(sp),sp
      78:	movem.l d2-d7/a2-a6,-(sp)

	SysBase = *((struct ExecBase **)4UL);
      7c:	movea.l 4 <_start+0x4>,a6
      80:	move.l a6,215d2 <SysBase>
	custom = (struct Custom *)0xdff000;
      86:	move.l #14675968,215d8 <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
      90:	lea 389d <incbin_P61_Player_end+0x1>,a1
      96:	moveq #0,d0
      98:	jsr -552(a6)
      9c:	move.l d0,215ce <GfxBase>
	if (!GfxBase)
      a2:	beq.w 1898 <main+0x1824>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
      a6:	movea.l 215d2 <SysBase>,a6
      ac:	lea 38ae <incbin_P61_Player_end+0x12>,a1
      b2:	moveq #0,d0
      b4:	jsr -552(a6)
      b8:	move.l d0,215ca <DOSBase>
	if (!DOSBase)
      be:	beq.w 188c <main+0x1818>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      c2:	pea 38ba <incbin_P61_Player_end+0x1e>
      c8:	jsr 196c <KPrintF>
#endif

	Write(Output(), (APTR) "Hello console!\n", 15);
      ce:	movea.l 215ca <DOSBase>,a6
      d4:	jsr -60(a6)
      d8:	movea.l 215ca <DOSBase>,a6
      de:	move.l d0,d1
      e0:	move.l #14550,d2
      e6:	moveq #15,d3
      e8:	jsr -48(a6)
}

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{

	bmp->Width = w;
      ec:	move.l #20971776,21598 <Screen>
      f6:	move.l #196648,2159c <Screen+0x4>
	bmp->Height = h;
	bmp->Bpls = bpls;
	bmp->Bpl = w / 8;
	bmp->Bplt = w / 8 * bpls;
     100:	move.w #120,215a0 <Screen+0x8>
	bmp->Btot = w / 8 * h * bpls;
     108:	move.w #30720,215a4 <Screen+0xc>
	bmp->Width = w;
     110:	move.l #16777346,21564 <BmpLogo>
     11a:	move.l #196640,21568 <BmpLogo+0x4>
	bmp->Bplt = w / 8 * bpls;
     124:	move.w #96,2156c <BmpLogo+0x8>
	bmp->Btot = w / 8 * h * bpls;
     12c:	move.w #12480,21570 <BmpLogo+0xc>
	bmp->Width = w;
     134:	move.l #20971650,21530 <BmpUpperPart_PF1>
     13e:	move.l #196648,21534 <BmpUpperPart_PF1+0x4>
	bmp->Bplt = w / 8 * bpls;
     148:	move.w #120,21538 <BmpUpperPart_PF1+0x8>
	bmp->Btot = w / 8 * h * bpls;
     150:	move.w #15600,2153c <BmpUpperPart_PF1+0xc>
	bmp->Width = w;
     158:	move.l #20971650,214fc <BmpUpperPart_PF2>
     162:	move.l #196648,21500 <BmpUpperPart_PF2+0x4>
	bmp->Bplt = w / 8 * bpls;
     16c:	move.w #120,21504 <BmpUpperPart_PF2+0x8>
	bmp->Btot = w / 8 * h * bpls;
     174:	move.w #15600,21508 <BmpUpperPart_PF2+0xc>
	bmp->Width = w;
     17c:	move.l #20971650,214c8 <BmpUpperPart_Buf1>
     186:	move.l #196648,214cc <BmpUpperPart_Buf1+0x4>
	bmp->Bplt = w / 8 * bpls;
     190:	move.w #120,214d0 <BmpUpperPart_Buf1+0x8>
	bmp->Btot = w / 8 * h * bpls;
     198:	move.w #15600,214d4 <BmpUpperPart_Buf1+0xc>
	bmp->Width = w;
     1a0:	move.l #23068838,21494 <BmpScroller>
     1aa:	move.l #196652,21498 <BmpScroller+0x4>
	bmp->Bplt = w / 8 * bpls;
     1b4:	move.w #132,2149c <BmpScroller+0x8>
	bmp->Btot = w / 8 * h * bpls;
     1bc:	move.w #21912,214a0 <BmpScroller+0xc>
	bmp->Width = w;
     1c4:	move.l #20971776,21460 <BmpFont32>
     1ce:	move.l #196648,21464 <BmpFont32+0x4>
	bmp->Bplt = w / 8 * bpls;
     1d8:	move.w #120,21468 <BmpFont32+0x8>
	bmp->Btot = w / 8 * h * bpls;
     1e0:	move.w #30720,2146c <BmpFont32+0xc>
	bmp->Width = w;
     1e8:	move.l #20971776,2142c <BmpCookie>
     1f2:	move.l #196648,21430 <BmpCookie+0x4>
	bmp->Bplt = w / 8 * bpls;
     1fc:	move.w #120,21434 <BmpCookie+0x8>
	bmp->Btot = w / 8 * h * bpls;
     204:	move.w #30720,21438 <BmpCookie+0xc>
	bmp->Width = w;
     20c:	move.l #20971776,213f8 <BmpCookieMask>
     216:	move.l #196648,213fc <BmpCookieMask+0x4>
	bmp->Bplt = w / 8 * bpls;
     220:	move.w #120,21400 <BmpCookieMask+0x8>
	bmp->Btot = w / 8 * h * bpls;
     228:	move.w #30720,21404 <BmpCookieMask+0xc>
	copPtr = AllocMem(1024, MEMF_CHIP);
     230:	movea.l 215d2 <SysBase>,a6
     236:	move.l #1024,d0
     23c:	moveq #2,d1
     23e:	jsr -198(a6)
     242:	move.l d0,213f2 <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
     248:	movea.l 215d2 <SysBase>,a6
     24e:	moveq #0,d0
     250:	move.w 214a0 <BmpScroller+0xc>,d0
     256:	move.l #65538,d1
     25c:	jsr -198(a6)
     260:	move.l d0,214a2 <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
     266:	movea.l 215d2 <SysBase>,a6
     26c:	moveq #0,d0
     26e:	move.w 2153c <BmpUpperPart_PF1+0xc>,d0
     274:	move.l #65538,d1
     27a:	jsr -198(a6)
     27e:	move.l d0,2153e <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
     284:	movea.l 215d2 <SysBase>,a6
     28a:	moveq #0,d0
     28c:	move.w 21508 <BmpUpperPart_PF2+0xc>,d0
     292:	move.l #65538,d1
     298:	jsr -198(a6)
     29c:	move.l d0,2150a <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
     2a2:	movea.l 215d2 <SysBase>,a6
     2a8:	moveq #0,d0
     2aa:	move.w 214d4 <BmpUpperPart_Buf1+0xc>,d0
     2b0:	move.l #65538,d1
     2b6:	jsr -198(a6)
     2ba:	move.l d0,214d6 <BmpUpperPart_Buf1+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
     2c0:	move.l #16388,21572 <BmpLogo+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
     2ca:	move.l #28870,2146e <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
     2d4:	move.l #59592,2143a <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
     2de:	move.l #90314,21406 <BmpCookieMask+0xe>
	for (int p = 0; p < img->Bpls; p++)
     2e8:	moveq #0,d2
     2ea:	move.w 21534 <BmpUpperPart_PF1+0x4>,d2
     2f0:	addq.l #4,sp
     2f2:	tst.l d2
     2f4:	beq.w 386 <main+0x312>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2f8:	movea.l 2153e <BmpUpperPart_PF1+0xe>,a0
     2fe:	moveq #0,d3
     300:	move.w 21536 <BmpUpperPart_PF1+0x6>,d3
     306:	move.l a0,21542 <BmpUpperPart_PF1+0x12>
	for (int p = 0; p < img->Bpls; p++)
     30c:	moveq #1,d1
     30e:	cmp.l d2,d1
     310:	beq.s 386 <main+0x312>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     312:	lea (0,a0,d3.l),a1
     316:	move.l a1,21546 <BmpUpperPart_PF1+0x16>
	for (int p = 0; p < img->Bpls; p++)
     31c:	moveq #2,d1
     31e:	cmp.l d2,d1
     320:	beq.s 386 <main+0x312>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     322:	move.l d3,d1
     324:	add.l d3,d1
     326:	lea (0,a0,d1.l),a1
     32a:	move.l a1,2154a <BmpUpperPart_PF1+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     330:	moveq #3,d4
     332:	cmp.l d2,d4
     334:	beq.s 386 <main+0x312>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     336:	add.l d3,d1
     338:	lea (0,a0,d1.l),a1
     33c:	move.l a1,2154e <BmpUpperPart_PF1+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     342:	moveq #4,d4
     344:	cmp.l d2,d4
     346:	beq.s 386 <main+0x312>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     348:	add.l d3,d1
     34a:	lea (0,a0,d1.l),a1
     34e:	move.l a1,21552 <BmpUpperPart_PF1+0x22>
	for (int p = 0; p < img->Bpls; p++)
     354:	moveq #5,d4
     356:	cmp.l d2,d4
     358:	beq.s 386 <main+0x312>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     35a:	add.l d3,d1
     35c:	lea (0,a0,d1.l),a1
     360:	move.l a1,21556 <BmpUpperPart_PF1+0x26>
	for (int p = 0; p < img->Bpls; p++)
     366:	moveq #6,d4
     368:	cmp.l d2,d4
     36a:	beq.s 386 <main+0x312>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     36c:	add.l d3,d1
     36e:	lea (0,a0,d1.l),a1
     372:	move.l a1,2155a <BmpUpperPart_PF1+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     378:	subq.l #7,d2
     37a:	beq.s 386 <main+0x312>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     37c:	add.l d3,d1
     37e:	add.l a0,d1
     380:	move.l d1,2155e <BmpUpperPart_PF1+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     386:	moveq #0,d2
     388:	move.w 21500 <BmpUpperPart_PF2+0x4>,d2
     38e:	tst.l d2
     390:	beq.w 422 <main+0x3ae>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     394:	movea.l 2150a <BmpUpperPart_PF2+0xe>,a0
     39a:	moveq #0,d3
     39c:	move.w 21502 <BmpUpperPart_PF2+0x6>,d3
     3a2:	move.l a0,2150e <BmpUpperPart_PF2+0x12>
	for (int p = 0; p < img->Bpls; p++)
     3a8:	moveq #1,d1
     3aa:	cmp.l d2,d1
     3ac:	beq.s 422 <main+0x3ae>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3ae:	lea (0,a0,d3.l),a1
     3b2:	move.l a1,21512 <BmpUpperPart_PF2+0x16>
	for (int p = 0; p < img->Bpls; p++)
     3b8:	moveq #2,d1
     3ba:	cmp.l d2,d1
     3bc:	beq.s 422 <main+0x3ae>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3be:	move.l d3,d1
     3c0:	add.l d3,d1
     3c2:	lea (0,a0,d1.l),a1
     3c6:	move.l a1,21516 <BmpUpperPart_PF2+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     3cc:	moveq #3,d4
     3ce:	cmp.l d2,d4
     3d0:	beq.s 422 <main+0x3ae>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3d2:	add.l d3,d1
     3d4:	lea (0,a0,d1.l),a1
     3d8:	move.l a1,2151a <BmpUpperPart_PF2+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     3de:	moveq #4,d4
     3e0:	cmp.l d2,d4
     3e2:	beq.s 422 <main+0x3ae>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3e4:	add.l d3,d1
     3e6:	lea (0,a0,d1.l),a1
     3ea:	move.l a1,2151e <BmpUpperPart_PF2+0x22>
	for (int p = 0; p < img->Bpls; p++)
     3f0:	moveq #5,d4
     3f2:	cmp.l d2,d4
     3f4:	beq.s 422 <main+0x3ae>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3f6:	add.l d3,d1
     3f8:	lea (0,a0,d1.l),a1
     3fc:	move.l a1,21522 <BmpUpperPart_PF2+0x26>
	for (int p = 0; p < img->Bpls; p++)
     402:	moveq #6,d4
     404:	cmp.l d2,d4
     406:	beq.s 422 <main+0x3ae>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     408:	add.l d3,d1
     40a:	lea (0,a0,d1.l),a1
     40e:	move.l a1,21526 <BmpUpperPart_PF2+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     414:	subq.l #7,d2
     416:	beq.s 422 <main+0x3ae>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     418:	add.l d3,d1
     41a:	add.l a0,d1
     41c:	move.l d1,2152a <BmpUpperPart_PF2+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     422:	moveq #0,d2
     424:	move.w 214cc <BmpUpperPart_Buf1+0x4>,d2
     42a:	tst.l d2
     42c:	beq.w 4b8 <main+0x444>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     430:	moveq #0,d3
     432:	move.w 214ce <BmpUpperPart_Buf1+0x6>,d3
     438:	move.l d0,214da <BmpUpperPart_Buf1+0x12>
	for (int p = 0; p < img->Bpls; p++)
     43e:	moveq #1,d1
     440:	cmp.l d2,d1
     442:	beq.s 4b8 <main+0x444>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     444:	move.l d0,d4
     446:	add.l d3,d4
     448:	move.l d4,214de <BmpUpperPart_Buf1+0x16>
	for (int p = 0; p < img->Bpls; p++)
     44e:	moveq #2,d1
     450:	cmp.l d2,d1
     452:	beq.s 4b8 <main+0x444>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     454:	move.l d3,d1
     456:	add.l d3,d1
     458:	move.l d0,d4
     45a:	add.l d1,d4
     45c:	move.l d4,214e2 <BmpUpperPart_Buf1+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     462:	moveq #3,d4
     464:	cmp.l d2,d4
     466:	beq.s 4b8 <main+0x444>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     468:	add.l d3,d1
     46a:	move.l d0,d4
     46c:	add.l d1,d4
     46e:	move.l d4,214e6 <BmpUpperPart_Buf1+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     474:	moveq #4,d4
     476:	cmp.l d2,d4
     478:	beq.s 4b8 <main+0x444>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     47a:	add.l d3,d1
     47c:	move.l d0,d4
     47e:	add.l d1,d4
     480:	move.l d4,214ea <BmpUpperPart_Buf1+0x22>
	for (int p = 0; p < img->Bpls; p++)
     486:	moveq #5,d4
     488:	cmp.l d2,d4
     48a:	beq.s 4b8 <main+0x444>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     48c:	add.l d3,d1
     48e:	move.l d0,d4
     490:	add.l d1,d4
     492:	move.l d4,214ee <BmpUpperPart_Buf1+0x26>
	for (int p = 0; p < img->Bpls; p++)
     498:	moveq #6,d4
     49a:	cmp.l d2,d4
     49c:	beq.s 4b8 <main+0x444>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     49e:	add.l d3,d1
     4a0:	move.l d0,d4
     4a2:	add.l d1,d4
     4a4:	move.l d4,214f2 <BmpUpperPart_Buf1+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     4aa:	subq.l #7,d2
     4ac:	beq.s 4b8 <main+0x444>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4ae:	add.l d3,d1
     4b0:	add.l d1,d0
     4b2:	move.l d0,214f6 <BmpUpperPart_Buf1+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     4b8:	moveq #0,d1
     4ba:	move.w 21498 <BmpScroller+0x4>,d1
     4c0:	tst.l d1
     4c2:	beq.w 554 <main+0x4e0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4c6:	movea.l 214a2 <BmpScroller+0xe>,a0
     4cc:	moveq #0,d2
     4ce:	move.w 2149a <BmpScroller+0x6>,d2
     4d4:	move.l a0,214a6 <BmpScroller+0x12>
	for (int p = 0; p < img->Bpls; p++)
     4da:	moveq #1,d0
     4dc:	cmp.l d1,d0
     4de:	beq.s 554 <main+0x4e0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4e0:	lea (0,a0,d2.l),a1
     4e4:	move.l a1,214aa <BmpScroller+0x16>
	for (int p = 0; p < img->Bpls; p++)
     4ea:	moveq #2,d0
     4ec:	cmp.l d1,d0
     4ee:	beq.s 554 <main+0x4e0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4f0:	move.l d2,d0
     4f2:	add.l d2,d0
     4f4:	lea (0,a0,d0.l),a1
     4f8:	move.l a1,214ae <BmpScroller+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     4fe:	moveq #3,d3
     500:	cmp.l d1,d3
     502:	beq.s 554 <main+0x4e0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     504:	add.l d2,d0
     506:	lea (0,a0,d0.l),a1
     50a:	move.l a1,214b2 <BmpScroller+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     510:	moveq #4,d3
     512:	cmp.l d1,d3
     514:	beq.s 554 <main+0x4e0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     516:	add.l d2,d0
     518:	lea (0,a0,d0.l),a1
     51c:	move.l a1,214b6 <BmpScroller+0x22>
	for (int p = 0; p < img->Bpls; p++)
     522:	moveq #5,d3
     524:	cmp.l d1,d3
     526:	beq.s 554 <main+0x4e0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     528:	add.l d2,d0
     52a:	lea (0,a0,d0.l),a1
     52e:	move.l a1,214ba <BmpScroller+0x26>
	for (int p = 0; p < img->Bpls; p++)
     534:	moveq #6,d3
     536:	cmp.l d1,d3
     538:	beq.s 554 <main+0x4e0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     53a:	add.l d2,d0
     53c:	lea (0,a0,d0.l),a1
     540:	move.l a1,214be <BmpScroller+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     546:	subq.l #7,d1
     548:	beq.s 554 <main+0x4e0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     54a:	add.l d2,d0
     54c:	add.l a0,d0
     54e:	move.l d0,214c2 <BmpScroller+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     554:	moveq #0,d1
     556:	move.w 21464 <BmpFont32+0x4>,d1
     55c:	tst.l d1
     55e:	beq.w 60c <main+0x598>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     562:	moveq #0,d2
     564:	move.w 21466 <BmpFont32+0x6>,d2
     56a:	move.l #28870,21472 <BmpFont32+0x12>
	for (int p = 0; p < img->Bpls; p++)
     574:	moveq #1,d4
     576:	cmp.l d1,d4
     578:	beq.w 60c <main+0x598>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     57c:	move.l d2,d0
     57e:	addi.l #28870,d0
     584:	move.l d0,21476 <BmpFont32+0x16>
	for (int p = 0; p < img->Bpls; p++)
     58a:	moveq #2,d3
     58c:	cmp.l d1,d3
     58e:	beq.s 60c <main+0x598>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     590:	move.l d2,d0
     592:	add.l d2,d0
     594:	move.l d0,d4
     596:	addi.l #28870,d4
     59c:	move.l d4,2147a <BmpFont32+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     5a2:	moveq #3,d3
     5a4:	cmp.l d1,d3
     5a6:	beq.s 60c <main+0x598>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5a8:	add.l d2,d0
     5aa:	move.l d0,d4
     5ac:	addi.l #28870,d4
     5b2:	move.l d4,2147e <BmpFont32+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     5b8:	moveq #4,d3
     5ba:	cmp.l d1,d3
     5bc:	beq.s 60c <main+0x598>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5be:	add.l d2,d0
     5c0:	move.l d0,d4
     5c2:	addi.l #28870,d4
     5c8:	move.l d4,21482 <BmpFont32+0x22>
	for (int p = 0; p < img->Bpls; p++)
     5ce:	moveq #5,d3
     5d0:	cmp.l d1,d3
     5d2:	beq.s 60c <main+0x598>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5d4:	add.l d2,d0
     5d6:	move.l d0,d4
     5d8:	addi.l #28870,d4
     5de:	move.l d4,21486 <BmpFont32+0x26>
	for (int p = 0; p < img->Bpls; p++)
     5e4:	moveq #6,d3
     5e6:	cmp.l d1,d3
     5e8:	beq.s 60c <main+0x598>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5ea:	add.l d2,d0
     5ec:	move.l d0,d4
     5ee:	addi.l #28870,d4
     5f4:	move.l d4,2148a <BmpFont32+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     5fa:	subq.l #7,d1
     5fc:	beq.s 60c <main+0x598>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5fe:	add.l d2,d0
     600:	addi.l #28870,d0
     606:	move.l d0,2148e <BmpFont32+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     60c:	moveq #0,d1
     60e:	move.w 21430 <BmpCookie+0x4>,d1
     614:	tst.l d1
     616:	beq.w 6c4 <main+0x650>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     61a:	moveq #0,d2
     61c:	move.w 21432 <BmpCookie+0x6>,d2
     622:	move.l #59592,2143e <BmpCookie+0x12>
	for (int p = 0; p < img->Bpls; p++)
     62c:	moveq #1,d4
     62e:	cmp.l d1,d4
     630:	beq.w 6c4 <main+0x650>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     634:	move.l d2,d0
     636:	addi.l #59592,d0
     63c:	move.l d0,21442 <BmpCookie+0x16>
	for (int p = 0; p < img->Bpls; p++)
     642:	moveq #2,d3
     644:	cmp.l d1,d3
     646:	beq.s 6c4 <main+0x650>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     648:	move.l d2,d0
     64a:	add.l d2,d0
     64c:	move.l d0,d4
     64e:	addi.l #59592,d4
     654:	move.l d4,21446 <BmpCookie+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     65a:	moveq #3,d3
     65c:	cmp.l d1,d3
     65e:	beq.s 6c4 <main+0x650>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     660:	add.l d2,d0
     662:	move.l d0,d4
     664:	addi.l #59592,d4
     66a:	move.l d4,2144a <BmpCookie+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     670:	moveq #4,d3
     672:	cmp.l d1,d3
     674:	beq.s 6c4 <main+0x650>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     676:	add.l d2,d0
     678:	move.l d0,d4
     67a:	addi.l #59592,d4
     680:	move.l d4,2144e <BmpCookie+0x22>
	for (int p = 0; p < img->Bpls; p++)
     686:	moveq #5,d3
     688:	cmp.l d1,d3
     68a:	beq.s 6c4 <main+0x650>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     68c:	add.l d2,d0
     68e:	move.l d0,d4
     690:	addi.l #59592,d4
     696:	move.l d4,21452 <BmpCookie+0x26>
	for (int p = 0; p < img->Bpls; p++)
     69c:	moveq #6,d3
     69e:	cmp.l d1,d3
     6a0:	beq.s 6c4 <main+0x650>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6a2:	add.l d2,d0
     6a4:	move.l d0,d4
     6a6:	addi.l #59592,d4
     6ac:	move.l d4,21456 <BmpCookie+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     6b2:	subq.l #7,d1
     6b4:	beq.s 6c4 <main+0x650>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6b6:	add.l d2,d0
     6b8:	addi.l #59592,d0
     6be:	move.l d0,2145a <BmpCookie+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     6c4:	moveq #0,d1
     6c6:	move.w 213fc <BmpCookieMask+0x4>,d1
     6cc:	tst.l d1
     6ce:	beq.w 77c <main+0x708>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6d2:	moveq #0,d2
     6d4:	move.w 213fe <BmpCookieMask+0x6>,d2
     6da:	move.l #90314,2140a <BmpCookieMask+0x12>
	for (int p = 0; p < img->Bpls; p++)
     6e4:	moveq #1,d4
     6e6:	cmp.l d1,d4
     6e8:	beq.w 77c <main+0x708>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6ec:	move.l d2,d0
     6ee:	addi.l #90314,d0
     6f4:	move.l d0,2140e <BmpCookieMask+0x16>
	for (int p = 0; p < img->Bpls; p++)
     6fa:	moveq #2,d3
     6fc:	cmp.l d1,d3
     6fe:	beq.s 77c <main+0x708>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     700:	move.l d2,d0
     702:	add.l d2,d0
     704:	move.l d0,d4
     706:	addi.l #90314,d4
     70c:	move.l d4,21412 <BmpCookieMask+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     712:	moveq #3,d3
     714:	cmp.l d1,d3
     716:	beq.s 77c <main+0x708>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     718:	add.l d2,d0
     71a:	move.l d0,d4
     71c:	addi.l #90314,d4
     722:	move.l d4,21416 <BmpCookieMask+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     728:	moveq #4,d3
     72a:	cmp.l d1,d3
     72c:	beq.s 77c <main+0x708>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     72e:	add.l d2,d0
     730:	move.l d0,d4
     732:	addi.l #90314,d4
     738:	move.l d4,2141a <BmpCookieMask+0x22>
	for (int p = 0; p < img->Bpls; p++)
     73e:	moveq #5,d3
     740:	cmp.l d1,d3
     742:	beq.s 77c <main+0x708>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     744:	add.l d2,d0
     746:	move.l d0,d4
     748:	addi.l #90314,d4
     74e:	move.l d4,2141e <BmpCookieMask+0x26>
	for (int p = 0; p < img->Bpls; p++)
     754:	moveq #6,d3
     756:	cmp.l d1,d3
     758:	beq.s 77c <main+0x708>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     75a:	add.l d2,d0
     75c:	move.l d0,d4
     75e:	addi.l #90314,d4
     764:	move.l d4,21422 <BmpCookieMask+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     76a:	subq.l #7,d1
     76c:	beq.s 77c <main+0x708>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     76e:	add.l d2,d0
     770:	addi.l #90314,d0
     776:	move.l d0,21426 <BmpCookieMask+0x2e>
	ActiView = GfxBase->ActiView; //store current view
     77c:	movea.l 215ce <GfxBase>,a6
     782:	move.l 34(a6),213e0 <ActiView>
	OwnBlitter();
     78a:	jsr -456(a6)
	WaitBlit();
     78e:	movea.l 215ce <GfxBase>,a6
     794:	jsr -228(a6)
	Disable();
     798:	movea.l 215d2 <SysBase>,a6
     79e:	jsr -120(a6)
	SystemADKCON = custom->adkconr;
     7a2:	movea.l 215d8 <custom>,a2
     7a8:	move.w 16(a2),d0
     7ac:	move.w d0,213e4 <SystemADKCON>
	SystemInts = custom->intenar;
     7b2:	move.w 28(a2),d0
     7b6:	move.w d0,213e8 <SystemInts>
	SystemDMA = custom->dmaconr;
     7bc:	move.w 2(a2),d0
     7c0:	move.w d0,213e6 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     7c6:	move.w #32767,154(a2)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     7cc:	move.w #32767,156(a2)
	WaitVbl();
     7d2:	jsr 1926 <WaitVbl>
	WaitVbl();
     7d8:	jsr 1926 <WaitVbl>
	custom->dmacon = 0x7fff; //Clear all DMA channels
     7de:	move.w #32767,150(a2)
	for (int a = 0; a < 32; a++)
     7e4:	moveq #0,d1
		custom->color[a] = 0;
     7e6:	move.l d1,d0
     7e8:	addi.l #192,d0
     7ee:	add.l d0,d0
     7f0:	move.w #0,(0,a2,d0.l)
	for (int a = 0; a < 32; a++)
     7f6:	addq.l #1,d1
     7f8:	moveq #32,d4
     7fa:	cmp.l d1,d4
     7fc:	bne.s 7e6 <main+0x772>
	LoadView(0);
     7fe:	movea.l 215ce <GfxBase>,a6
     804:	suba.l a1,a1
     806:	jsr -222(a6)
	WaitTOF();
     80a:	movea.l 215ce <GfxBase>,a6
     810:	jsr -270(a6)
	WaitTOF();
     814:	movea.l 215ce <GfxBase>,a6
     81a:	jsr -270(a6)
	WaitVbl();
     81e:	jsr 1926 <WaitVbl>
	WaitVbl();
     824:	jsr 1926 <WaitVbl>
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     82a:	move.w #20090,132(sp)
     830:	move.w #2049,134(sp)
     836:	move.w #20083,136(sp)
	if (SysBase->AttnFlags & AFF_68010)
     83c:	movea.l 215d2 <SysBase>,a6
     842:	btst #0,297(a6)
     848:	beq.w 18c2 <main+0x184e>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     84c:	move.l sp,d7
     84e:	addi.l #132,d7
     854:	exg d7,a5
     856:	jsr -30(a6)
     85a:	exg d7,a5
	VBR = GetVBR();
     85c:	move.l d0,213ee <VBR>
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     862:	movea.l 213ee <VBR>,a0
     868:	move.l 108(a0),d0
	SystemIrq = GetInterruptHandler(); //store interrupt register
     86c:	move.l d0,213ea <SystemIrq>
	WaitVbl();
     872:	jsr 1926 <WaitVbl>
	SetupCopper(copPtr);
     878:	movea.l 213f2 <copPtr>,a1
	*copPtr++ = DIWSTRT;
     87e:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     882:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     888:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     88e:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     894:	move.w #146,8(a1)
	*copPtr++ = 0x38; // + ((Screen.Width - BmpLogo.Width) / 4);
     89a:	move.w #56,10(a1)
	*copPtr++ = DDFSTOP;
     8a0:	move.w #148,12(a1)
	*copPtr++ = 0xd0; // - ((Screen.Width - BmpLogo.Width) / 4);
     8a6:	move.w #208,14(a1)
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl);
     8ac:	move.w 21536 <BmpUpperPart_PF1+0x6>,d5
     8b2:	move.w 21538 <BmpUpperPart_PF1+0x8>,d0
     8b8:	sub.w d5,d0
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     8ba:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     8c0:	move.w d0,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     8c4:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     8ca:	move.w d0,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     8ce:	move.w #258,24(a1)
	*copPtr++ = 0;
     8d4:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     8d8:	move.w #260,28(a1)
	*copPtr++ = 1 << 6;	 //0x24;  Sprites have priority over playfields
     8de:	move.w #64,30(a1)
    *copListEnd++ = COP_WAIT;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     8e4:	move.w #384,32(a1)
    *copListCurrent++ = color;
     8ea:	clr.w 34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     8ee:	move.w #386,36(a1)
    *copListCurrent++ = color;
     8f4:	move.w #2080,38(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     8fa:	move.w #388,40(a1)
    *copListCurrent++ = color;
     900:	move.w #2368,42(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     906:	move.w #390,44(a1)
    *copListCurrent++ = color;
     90c:	move.w #2656,46(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     912:	move.w #392,48(a1)
    *copListCurrent++ = color;
     918:	move.w #3184,50(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     91e:	move.w #394,52(a1)
    *copListCurrent++ = color;
     924:	move.w #3472,54(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     92a:	move.w #396,56(a1)
    *copListCurrent++ = color;
     930:	move.w #3760,58(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     936:	move.w #398,60(a1)
    *copListCurrent++ = color;
     93c:	move.w #3760,62(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     942:	move.w #400,64(a1)
    *copListCurrent++ = color;
     948:	clr.w 66(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     94c:	move.w #402,68(a1)
    *copListCurrent++ = color;
     952:	move.w #1366,70(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     958:	move.w #404,72(a1)
    *copListCurrent++ = color;
     95e:	move.w #3221,74(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     964:	move.w #406,76(a1)
    *copListCurrent++ = color;
     96a:	move.w #3750,78(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     970:	move.w #408,80(a1)
    *copListCurrent++ = color;
     976:	move.w #1074,82(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     97c:	move.w #410,84(a1)
    *copListCurrent++ = color;
     982:	move.w #1329,86(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     988:	move.w #412,88(a1)
    *copListCurrent++ = color;
     98e:	move.w #530,90(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     994:	move.w #414,92(a1)
    *copListCurrent++ = color;
     99a:	lea 96(a1),a2
     99e:	move.w #2177,94(a1)
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, TRUE);
     9a4:	movea.w 21534 <BmpUpperPart_PF1+0x4>,a3
     9aa:	move.l 2153e <BmpUpperPart_PF1+0xe>,d6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     9b0:	move.l d6,d1
    for (USHORT i = 0; i < numPlanes; i++)
     9b2:	clr.w d0
     9b4:	cmp.w a3,d0
     9b6:	beq.s a04 <main+0x990>
        addr += Bpl;
     9b8:	moveq #0,d7
     9ba:	move.w d5,d7
     9bc:	move.w a3,d4
     9be:	subq.w #1,d4
     9c0:	andi.l #65535,d4
     9c6:	moveq #13,d3
     9c8:	add.l d3,d4
     9ca:	lsl.l #3,d4
     9cc:	add.l a1,d4
    *copListCurrent++ = color;
     9ce:	movea.l a2,a0
    BYTE plane = odd ? 1 : 0;
     9d0:	moveq #1,d2
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     9d2:	move.b d2,d0
     9d4:	ext.w d0
     9d6:	lsl.w #2,d0
     9d8:	addi.w #224,d0
     9dc:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     9de:	move.l d1,d3
     9e0:	clr.w d3
     9e2:	swap d3
     9e4:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     9e8:	addq.w #2,d0
     9ea:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     9ee:	addq.l #8,a0
     9f0:	move.w d1,-2(a0)
        addr += Bpl;
     9f4:	add.l d7,d1
        plane += 2;
     9f6:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     9f8:	cmp.l a0,d4
     9fa:	bne.s 9d2 <main+0x95e>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     9fc:	moveq #0,d0
     9fe:	move.w a3,d0
     a00:	lsl.l #3,d0
     a02:	adda.l d0,a2
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, FALSE);
     a04:	move.w 21502 <BmpUpperPart_PF2+0x6>,d4
     a0a:	move.w 21500 <BmpUpperPart_PF2+0x4>,d0
     a10:	movea.l 2150a <BmpUpperPart_PF2+0xe>,a0
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     a16:	move.l a0,d1
    for (USHORT i = 0; i < numPlanes; i++)
     a18:	tst.w d0
     a1a:	beq.w 18dc <main+0x1868>
        addr += Bpl;
     a1e:	andi.l #65535,d4
     a24:	andi.l #65535,d0
     a2a:	lsl.l #3,d0
     a2c:	lea (0,a2,d0.l),a6
    BYTE plane = odd ? 1 : 0;
     a30:	clr.b d2
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     a32:	move.b d2,d0
     a34:	ext.w d0
     a36:	lsl.w #2,d0
     a38:	addi.w #224,d0
     a3c:	move.w d0,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     a3e:	move.l d1,d3
     a40:	clr.w d3
     a42:	swap d3
     a44:	move.w d3,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     a48:	addq.w #2,d0
     a4a:	move.w d0,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     a4e:	addq.l #8,a2
     a50:	move.w d1,-2(a2)
        addr += Bpl;
     a54:	add.l d4,d1
        plane += 2;
     a56:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     a58:	cmpa.l a2,a6
     a5a:	bne.s a32 <main+0x9be>
	*copPtr++ = BPLCON0;
     a5c:	move.w #256,(a6)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     a60:	movea.w 21568 <BmpLogo+0x4>,a4
     a66:	moveq #0,d4
     a68:	move.w a4,d4
     a6a:	movea.l d4,a5
     a6c:	move.l a5,d0
     a6e:	moveq #13,d1
     a70:	lsl.l d1,d0
     a72:	ori.w #1536,d0
     a76:	move.w d0,2(a6)
	copPtr = copWaitY(copPtr, 0x2c + BmpUpperPart_PF1.Height);
     a7a:	move.w 21532 <BmpUpperPart_PF1+0x2>,d0
     a80:	addi.w #44,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     a84:	lsl.w #8,d0
     a86:	ori.w #5,d0
     a8a:	move.w d0,4(a6)
    *copListEnd++ = COP_WAIT;
     a8e:	move.w #-2,6(a6)
						  BmpScroller.Bplt - Screen.Bpl);
     a94:	move.w 2149c <BmpScroller+0x8>,d7
     a9a:	move.w d7,d0
     a9c:	sub.w 2159e <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     aa2:	move.w #264,8(a6)
    *copListEnd++ = modOdd;
     aa8:	move.w d0,10(a6)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     aac:	move.w #266,12(a6)
    *copListEnd++ = modEven;
     ab2:	lea 16(a6),a3
     ab6:	move.w d0,14(a6)
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     aba:	move.l a3,213da <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     ac0:	move.w 2149a <BmpScroller+0x6>,d4
     ac6:	move.w 21498 <BmpScroller+0x4>,98(sp)
     ace:	move.l 214a2 <BmpScroller+0xe>,94(sp)
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     ad6:	move.l 94(sp),d1
    for (USHORT i = 0; i < numPlanes; i++)
     ada:	tst.w 98(sp)
     ade:	beq.s b2a <main+0xab6>
        addr += Bpl;
     ae0:	andi.l #65535,d4
     ae6:	move.w 98(sp),d0
     aea:	subq.w #1,d0
     aec:	andi.l #65535,d0
     af2:	addq.l #3,d0
     af4:	lsl.l #3,d0
     af6:	add.l a6,d0
     af8:	movea.l a3,a2
     afa:	move.w #224,d2
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     afe:	move.w d2,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     b00:	move.l d1,d3
     b02:	clr.w d3
     b04:	swap d3
     b06:	move.w d3,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     b0a:	move.w d2,d3
     b0c:	addq.w #2,d3
     b0e:	move.w d3,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     b12:	addq.l #8,a2
     b14:	move.w d1,-2(a2)
        addr += Bpl;
     b18:	add.l d4,d1
    for (USHORT i = 0; i < numPlanes; i++)
     b1a:	addq.w #4,d2
     b1c:	cmp.l a2,d0
     b1e:	bne.s afe <main+0xa8a>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     b20:	moveq #0,d0
     b22:	move.w 98(sp),d0
     b26:	lsl.l #3,d0
     b28:	adda.l d0,a3
	*copPtr++ = BPLCON0;
     b2a:	move.w #256,(a3)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     b2e:	move.l a5,d0
     b30:	moveq #12,d4
     b32:	lsl.l d4,d0
     b34:	ori.w #512,d0
     b38:	move.w d0,2(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b3c:	move.w #384,4(a3)
    *copListCurrent++ = color;
     b42:	clr.w 6(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b46:	move.w #386,8(a3)
    *copListCurrent++ = color;
     b4c:	move.w #23,10(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b52:	move.w #388,12(a3)
    *copListCurrent++ = color;
     b58:	move.w #601,14(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b5e:	move.w #390,16(a3)
    *copListCurrent++ = color;
     b64:	move.w #874,18(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b6a:	move.w #392,20(a3)
    *copListCurrent++ = color;
     b70:	move.w #1163,22(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b76:	move.w #394,24(a3)
    *copListCurrent++ = color;
     b7c:	move.w #1469,26(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b82:	move.w #396,28(a3)
    *copListCurrent++ = color;
     b88:	move.w #1758,30(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b8e:	move.w #398,32(a3)
    *copListCurrent++ = color;
     b94:	move.w #2303,34(a3)
	copPtr = copWaitY(copPtr, 0x2c + BmpLogo.Height + 64);
     b9a:	move.w 21566 <BmpLogo+0x2>,d0
     ba0:	addi.w #108,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     ba4:	lsl.w #8,d0
     ba6:	ori.w #5,d0
     baa:	move.w d0,36(a3)
    *copListEnd++ = COP_WAIT;
     bae:	move.w #-2,38(a3)
     bb4:	lea 40(a3),a2
     bb8:	move.l a2,213d0 <copMirrorBmpP>
						  (BmpLogo.Bplt - BmpLogo.Bpl));
     bbe:	move.w 2156a <BmpLogo+0x6>,d1
     bc4:	move.w 2156c <BmpLogo+0x8>,d0
     bca:	sub.w d1,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     bcc:	move.w #264,40(a3)
    *copListEnd++ = modOdd;
     bd2:	move.w d0,42(a3)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     bd6:	move.w #266,44(a3)
    *copListEnd++ = modEven;
     bdc:	move.w d0,46(a3)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     be0:	move.w #-1,48(a3)
    *copListEnd++ = COP_WAIT;
     be6:	move.w #-2,50(a3)
	custom->cop1lc = (ULONG)copPtr;
     bec:	movea.l 215d8 <custom>,a2
     bf2:	move.l a1,128(a2)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
     bf6:	move.w #64,150(a2)
	custom->copjmp1 = 0x7fff;	   //start coppper
     bfc:	move.w #32767,136(a2)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG;
     c02:	move.w #-30784,150(a2)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     c08:	movea.l 213ee <VBR>,a3
     c0e:	move.l #6372,108(a3)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
     c16:	move.w #-16352,154(a2)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
     c1c:	move.w #32,156(a2)
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
     c22:	move.l 21572 <BmpLogo+0xe>,d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     c28:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     c2c:	move.w 2(a2),d0
     c30:	btst #14,d0
     c34:	bne.s c2c <main+0xbb8>
	custom->bltcon0 = 0x09f0;
     c36:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
     c3c:	move.w #0,66(a2)
	custom->bltafwm = 0xffff;
     c42:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
     c48:	move.w #-1,70(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
     c4e:	addi.w #-32,d1
     c52:	move.w d1,100(a2)
	custom->bltdmod = imgD.Bpl - (width / 8);
     c56:	addi.w #-32,d5
     c5a:	move.w d5,102(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
     c5e:	move.l d2,80(a2)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
     c62:	addq.l #4,d6
     c64:	move.l d6,84(a2)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
     c68:	move.w a4,d0
     c6a:	lsl.w #6,d0
     c6c:	adda.w d0,a4
     c6e:	move.w a4,d0
     c70:	lsl.w #7,d0
     c72:	movea.w d0,a4
     c74:	lea 16(a4),a4
     c78:	move.w a4,88(a2)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
     c7c:	move.b bfe001 <_end+0xbdca25>,d0
	while (!MouseLeft())
     c82:	btst #6,d0
     c86:	beq.w 16f2 <main+0x167e>
     c8a:	move.w 214cc <BmpUpperPart_Buf1+0x4>,d0
     c90:	move.w 214ce <BmpUpperPart_Buf1+0x6>,d3
     c96:	move.l 214d6 <BmpUpperPart_Buf1+0xe>,d2
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
     c9c:	move.w 4000 <ScrollerY>,d1
	short incY[6] = {3, 3, 2, 2, 5, 3};
     ca2:	move.w #3,118(sp)
     ca8:	move.w #5,120(sp)
     cae:	move.w #2,116(sp)
     cb4:	move.w #2,112(sp)
     cba:	move.w #3,114(sp)
     cc0:	move.w #3,122(sp)
	short incX[6] = {4, 5, 6, 7, 8, 9};
     cc6:	move.w #9,104(sp)
     ccc:	move.w #8,106(sp)
     cd2:	move.w #7,102(sp)
     cd8:	move.w #6,108(sp)
     cde:	move.w #5,100(sp)
     ce4:	move.w #4,110(sp)
	Point2D pdb[6] = {
     cea:	movea.w #90,a1
     cee:	move.l a1,66(sp)
     cf2:	movea.w #28,a6
     cf6:	move.l a6,62(sp)
     cfa:	movea.w #50,a5
     cfe:	move.l #160,70(sp)
     d06:	movea.w #70,a4
     d0a:	move.l a1,74(sp)
     d0e:	movea.w #30,a6
     d12:	move.l a6,78(sp)
     d16:	movea.w #70,a1
     d1a:	move.l a1,82(sp)
     d1e:	movea.w #10,a6
     d22:	move.l a6,58(sp)
     d26:	movea.w #20,a1
     d2a:	move.l a1,54(sp)
     d2e:	clr.l 86(sp)
     d32:	clr.l 90(sp)
     d36:	lea 19de <BetterBlit.constprop.0.isra.0>,a3
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     d3c:	movea.l dff004 <_end+0xddda28>,a1
     d42:	move.l a1,128(sp)
		vpos &= 0x1ff00;
     d46:	move.l 128(sp),d4
     d4a:	andi.l #130816,d4
     d50:	move.l d4,128(sp)
		if (vpos != (311 << 8))
     d54:	movea.l 128(sp),a1
     d58:	cmpa.l #79616,a1
     d5e:	beq.s d3c <main+0xcc8>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     d60:	movea.l dff004 <_end+0xddda28>,a1
     d66:	move.l a1,124(sp)
		vpos &= 0x1ff00;
     d6a:	move.l 124(sp),d4
     d6e:	andi.l #130816,d4
     d74:	move.l d4,124(sp)
		if (vpos == (311 << 8))
     d78:	movea.l 124(sp),a1
     d7c:	cmpa.l #79616,a1
     d82:	bne.s d60 <main+0xcec>
		CopyBitmap(BmpUpperPart_Buf1, BmpUpperPart_PF2);
     d84:	move.w 214ca <BmpUpperPart_Buf1+0x2>,d6
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     d8a:	movea.w 2(a2),a1
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     d8e:	move.w 2(a2),d5
     d92:	move.w d5,d4
     d94:	andi.w #16384,d4
     d98:	btst #14,d5
     d9c:	bne.s d8e <main+0xd1a>
	custom->bltcon0 = 0x09f0;
     d9e:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
     da4:	move.w #0,66(a2)
	custom->bltapt = (UBYTE *)bmpS.ImageData;
     daa:	move.l d2,80(a2)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
     dae:	move.l a0,84(a2)
	custom->bltafwm = 0xffff;
     db2:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
     db8:	move.w #-1,70(a2)
	custom->bltamod = 0;
     dbe:	move.w #0,100(a2)
	custom->bltdmod = 0;
     dc4:	move.w #0,102(a2)
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
     dca:	muls.w d6,d0
     dcc:	lsl.w #6,d0
     dce:	lsr.w #1,d3
     dd0:	add.w d0,d3
     dd2:	move.w d3,88(a2)
			pdb[b].X += incX[b];
     dd6:	movea.l 90(sp),a2
     dda:	move.w 110(sp),d3
     dde:	movea.w d3,a0
     de0:	lea (0,a0,a2.l),a2
     de4:	move.l a2,90(sp)
			pdb[b].Y += incY[b];
     de8:	movea.l 86(sp),a2
     dec:	move.w 122(sp),d3
     df0:	movea.w d3,a0
     df2:	lea (0,a0,a2.l),a2
     df6:	move.l a2,86(sp)
			if (pdb[b].X >= 320 - 32)
     dfa:	cmpi.l #287,90(sp)
     e02:	ble.w 169c <main+0x1628>
				incX[b] *= -1;
     e06:	neg.w 110(sp)
				pdb[b].X = 320 - 32;
     e0a:	move.l #288,90(sp)
			if (pdb[b].Y >= 130 - 32)
     e12:	moveq #97,d0
     e14:	cmp.l 86(sp),d0
     e18:	bge.w 1688 <main+0x1614>
				incY[b] *= -1;
     e1c:	neg.w 122(sp)
				pdb[b].Y = 130 - 32;
     e20:	movea.w #98,a2
     e24:	move.l a2,86(sp)
			pdb[b].X += incX[b];
     e28:	movea.l 54(sp),a2
     e2c:	move.w 100(sp),d3
     e30:	movea.w d3,a0
     e32:	lea (0,a0,a2.l),a2
     e36:	move.l a2,54(sp)
			pdb[b].Y += incY[b];
     e3a:	movea.l 58(sp),a2
     e3e:	move.w 114(sp),d3
     e42:	movea.w d3,a0
     e44:	lea (0,a0,a2.l),a2
     e48:	move.l a2,58(sp)
			if (pdb[b].X >= 320 - 32)
     e4c:	cmpi.l #287,54(sp)
     e54:	ble.w 1674 <main+0x1600>
				incX[b] *= -1;
     e58:	neg.w 100(sp)
				pdb[b].X = 320 - 32;
     e5c:	move.l #288,54(sp)
			if (pdb[b].Y >= 130 - 32)
     e64:	moveq #97,d0
     e66:	cmp.l 58(sp),d0
     e6a:	bge.w 1660 <main+0x15ec>
				incY[b] *= -1;
     e6e:	neg.w 114(sp)
				pdb[b].Y = 130 - 32;
     e72:	movea.w #98,a2
     e76:	move.l a2,58(sp)
			pdb[b].X += incX[b];
     e7a:	movea.l 82(sp),a2
     e7e:	move.w 108(sp),d3
     e82:	movea.w d3,a0
     e84:	lea (0,a0,a2.l),a2
     e88:	move.l a2,82(sp)
			pdb[b].Y += incY[b];
     e8c:	movea.l 78(sp),a2
     e90:	move.w 112(sp),d3
     e94:	movea.w d3,a0
     e96:	lea (0,a0,a2.l),a2
     e9a:	move.l a2,78(sp)
			if (pdb[b].X >= 320 - 32)
     e9e:	cmpi.l #287,82(sp)
     ea6:	ble.w 164c <main+0x15d8>
				incX[b] *= -1;
     eaa:	neg.w 108(sp)
				pdb[b].X = 320 - 32;
     eae:	move.l #288,82(sp)
			if (pdb[b].Y >= 130 - 32)
     eb6:	moveq #97,d0
     eb8:	cmp.l 78(sp),d0
     ebc:	bge.w 1638 <main+0x15c4>
				incY[b] *= -1;
     ec0:	neg.w 112(sp)
				pdb[b].Y = 130 - 32;
     ec4:	movea.w #98,a2
     ec8:	move.l a2,78(sp)
			pdb[b].X += incX[b];
     ecc:	movea.l 74(sp),a2
     ed0:	move.w 102(sp),d3
     ed4:	movea.w d3,a0
     ed6:	lea (0,a0,a2.l),a2
     eda:	move.l a2,74(sp)
			pdb[b].Y += incY[b];
     ede:	movea.w 116(sp),a2
     ee2:	movea.w a2,a6
     ee4:	lea (0,a6,a4.l),a4
			if (pdb[b].X >= 320 - 32)
     ee8:	cmpi.l #287,74(sp)
     ef0:	ble.w 1624 <main+0x15b0>
				incX[b] *= -1;
     ef4:	neg.w d3
     ef6:	move.w d3,102(sp)
				pdb[b].X = 320 - 32;
     efa:	move.l #288,74(sp)
			if (pdb[b].Y >= 130 - 32)
     f02:	moveq #97,d0
     f04:	cmp.l a4,d0
     f06:	bge.w 1612 <main+0x159e>
				incY[b] *= -1;
     f0a:	neg.w 116(sp)
				pdb[b].Y = 130 - 32;
     f0e:	movea.w #98,a4
			pdb[b].X += incX[b];
     f12:	movea.l 70(sp),a2
     f16:	move.w 106(sp),d3
     f1a:	movea.w d3,a0
     f1c:	lea (0,a0,a2.l),a2
     f20:	move.l a2,70(sp)
			pdb[b].Y += incY[b];
     f24:	movea.w 120(sp),a2
     f28:	movea.w a2,a6
     f2a:	lea (0,a6,a5.l),a5
			if (pdb[b].X >= 320 - 32)
     f2e:	cmpi.l #287,70(sp)
     f36:	ble.w 15fe <main+0x158a>
				incX[b] *= -1;
     f3a:	neg.w d3
     f3c:	move.w d3,106(sp)
				pdb[b].X = 320 - 32;
     f40:	move.l #288,70(sp)
			if (pdb[b].Y >= 130 - 32)
     f48:	moveq #97,d0
     f4a:	cmp.l a5,d0
     f4c:	bge.w 15ec <main+0x1578>
				incY[b] *= -1;
     f50:	neg.w 120(sp)
				pdb[b].Y = 130 - 32;
     f54:	movea.w #98,a5
			pdb[b].X += incX[b];
     f58:	movea.l 62(sp),a2
     f5c:	move.w 104(sp),d3
     f60:	movea.w d3,a0
     f62:	lea (0,a0,a2.l),a2
     f66:	move.l a2,62(sp)
			pdb[b].Y += incY[b];
     f6a:	movea.l 66(sp),a2
     f6e:	move.w 118(sp),d3
     f72:	movea.w d3,a0
     f74:	lea (0,a0,a2.l),a2
     f78:	move.l a2,66(sp)
			if (pdb[b].X >= 320 - 32)
     f7c:	cmpi.l #287,62(sp)
     f84:	ble.w 15d8 <main+0x1564>
				incX[b] *= -1;
     f88:	neg.w 104(sp)
				pdb[b].X = 320 - 32;
     f8c:	move.l #288,62(sp)
			if (pdb[b].Y >= 130 - 32)
     f94:	moveq #97,d0
     f96:	cmp.l 66(sp),d0
     f9a:	bge.w 15c4 <main+0x1550>
				incY[b] *= -1;
     f9e:	neg.w 118(sp)
				pdb[b].Y = 130 - 32;
     fa2:	movea.w #98,a2
     fa6:	move.l a2,66(sp)
		if (BounceEnabled)
     faa:	tst.w 213de <BounceEnabled>
     fb0:	beq.s ff2 <main+0xf7e>
			if (ScrollerDir > 0)
     fb2:	move.b 4002 <ScrollerDir>,d0
     fb8:	ble.w 16b0 <main+0x163c>
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
     fbc:	pea c <_start+0xc>
     fc0:	movea.w #40,a6
     fc4:	suba.w d1,a6
     fc6:	move.l a6,-(sp)
     fc8:	move.l d1,54(sp)
     fcc:	jsr 1dd6 <__divsi3>
     fd2:	addq.l #8,sp
				if (ScrollerDir > 6)
     fd4:	move.l 46(sp),d1
     fd8:	cmpi.b #6,d0
     fdc:	ble.w 16d0 <main+0x165c>
					ScrollerDir = 6;
     fe0:	move.b #6,4002 <ScrollerDir>
     fe8:	moveq #6,d0
			ScrollerY += ScrollerDir;
     fea:	add.w d0,d1
     fec:	move.w d1,4000 <ScrollerY>
		if (ScrollerY >= ScrollerMax)
     ff2:	movea.w d1,a0
     ff4:	cmpi.w #39,d1
     ff8:	ble.w 1528 <main+0x14b4>
			ScrollerY = ScrollerMax;
     ffc:	move.w #40,4000 <ScrollerY>
			ScrollerDir = -1;
    1004:	st 4002 <ScrollerDir>
	int BltOffs = startY * theDesc.Bplt;
    100a:	move.w d7,d2
    100c:	mulu.w #40,d2
	int Brcorner = height * theDesc.Bplt - 2;
    1010:	moveq #0,d0
    1012:	move.w d7,d0
    1014:	lsl.l #5,d0
    1016:	move.l d0,d7
    1018:	subq.l #2,d7
	WaitBlit();
    101a:	movea.l 215ce <GfxBase>,a6
    1020:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
    1024:	movea.l 215d8 <custom>,a2
    102a:	move.w #18928,64(a2)
	custom->bltcon1 = 0x0002;
    1030:	move.w #2,66(a2)
	custom->bltafwm = 0xffff;
    1036:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    103c:	move.w #-1,70(a2)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
    1042:	move.l d2,d0
    1044:	add.l d7,d0
    1046:	add.l 94(sp),d0
    104a:	move.l d0,80(a2)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
    104e:	move.l d0,84(a2)
	custom->bltamod = 0;
    1052:	move.w #0,100(a2)
	custom->bltdmod = 0;
    1058:	move.w #0,102(a2)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
    105e:	move.w 98(sp),d0
    1062:	moveq #11,d1
    1064:	lsl.w d1,d0
    1066:	lea 21494 <BmpScroller>,a0
    106c:	move.w (a0),d1
    106e:	lsr.w #4,d1
    1070:	add.w d1,d0
    1072:	move.w d0,88(a2)
	ScrollCnt += speed;
    1076:	move.w 213d8 <ScrollCnt>,d0
    107c:	addq.w #4,d0
    107e:	move.w d0,213d8 <ScrollCnt>
	if (ScrollCnt >= 32)
    1084:	cmpi.w #31,d0
    1088:	bhi.w 12ee <main+0x127a>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    108c:	move.w 2149a <BmpScroller+0x6>,d5
    1092:	move.l 214a2 <BmpScroller+0xe>,94(sp)
    109a:	move.w 4000 <ScrollerY>,d1
    10a0:	move.w 21498 <BmpScroller+0x4>,98(sp)
    10a8:	moveq #0,d6
    10aa:	move.w 98(sp),d6
    10ae:	movea.l 213da <copScrollerBmpP>,a6
    10b4:	andi.l #65535,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    10ba:	move.l d5,-(sp)
    10bc:	movea.w d1,a0
    10be:	move.l a0,-(sp)
    10c0:	move.l d1,54(sp)
    10c4:	jsr 1d58 <__mulsi3>
    10ca:	addq.l #4,sp
    10cc:	move.l d6,(sp)
    10ce:	move.l d0,-(sp)
    10d0:	jsr 1d58 <__mulsi3>
    10d6:	addq.l #8,sp
    10d8:	add.l 94(sp),d0
        addr += Bpl;
    10dc:	move.w #224,d2
    for (USHORT i = 0; i < numPlanes; i++)
    10e0:	move.l 46(sp),d1
    10e4:	tst.l d6
    10e6:	beq.s 1110 <main+0x109c>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
    10e8:	move.w d2,(a6)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    10ea:	move.l d0,d3
    10ec:	clr.w d3
    10ee:	swap d3
    10f0:	move.w d3,2(a6)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
    10f4:	move.w d2,d3
    10f6:	addq.w #2,d3
    10f8:	move.w d3,4(a6)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    10fc:	addq.l #8,a6
    10fe:	move.w d0,-2(a6)
        addr += Bpl;
    1102:	add.l d5,d0
    for (USHORT i = 0; i < numPlanes; i++)
    1104:	addq.w #1,d4
    1106:	addq.w #4,d2
    1108:	moveq #0,d3
    110a:	move.w d4,d3
    110c:	cmp.l d6,d3
    110e:	blt.s 10e8 <main+0x1074>
		ClearBitmap(BmpUpperPart_Buf1, 130);
    1110:	lea 214c8 <BmpUpperPart_Buf1>,a1
    1116:	movea.w (a1),a0
    1118:	move.w 214cc <BmpUpperPart_Buf1+0x4>,d0
    111e:	move.l 214d6 <BmpUpperPart_Buf1+0xe>,d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1124:	movea.w 2(a2),a1
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1128:	move.w 2(a2),d3
    112c:	btst #14,d3
    1130:	bne.s 1128 <main+0x10b4>
	custom->bltcon0 = 0x0900;
    1132:	move.w #2304,64(a2)
	custom->bltcon1 = 0x0000;
    1138:	move.w #0,66(a2)
	custom->bltapt = (UBYTE *)bmpD.ImageData;
    113e:	move.l d2,80(a2)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
    1142:	move.l d2,84(a2)
	custom->bltafwm = 0xffff;
    1146:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    114c:	move.w #-1,70(a2)
	custom->bltamod = 0;
    1152:	move.w #0,100(a2)
	custom->bltdmod = 0;
    1158:	move.w #0,102(a2)
	custom->bltsize = ((lines * bmpD.Bpls) << 6) + (bmpD.Width / 16);
    115e:	move.w d0,d3
    1160:	lsl.w #6,d3
    1162:	add.w d0,d3
    1164:	lsl.w #7,d3
    1166:	move.w a0,d4
    1168:	lsr.w #4,d4
    116a:	movea.w d4,a0
    116c:	adda.w d3,a0
    116e:	move.w a0,88(a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, ps2, pdb[0], 32, 32);
    1172:	move.w 21430 <BmpCookie+0x4>,d4
    1178:	move.w 21432 <BmpCookie+0x6>,d5
    117e:	move.w 21434 <BmpCookie+0x8>,d6
    1184:	move.l 2143a <BmpCookie+0xe>,d7
    118a:	move.w 214ce <BmpUpperPart_Buf1+0x6>,d3
    1190:	movea.w 214d0 <BmpUpperPart_Buf1+0x8>,a6
    1196:	move.l 90(sp),132(sp)
    119c:	move.l 86(sp),136(sp)
    11a2:	move.l 136(sp),-(sp)
    11a6:	move.l 136(sp),-(sp)
    11aa:	clr.l -(sp)
    11ac:	clr.l -(sp)
    11ae:	move.l d2,-(sp)
    11b0:	move.l a6,-(sp)
    11b2:	move.l d3,-(sp)
    11b4:	move.l d7,-(sp)
    11b6:	move.l d6,-(sp)
    11b8:	move.l d5,-(sp)
    11ba:	move.l d4,-(sp)
    11bc:	move.l d0,94(sp)
    11c0:	move.l d1,90(sp)
    11c4:	jsr (a3)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, ps2, pdb[1], 32, 32);
    11c6:	move.l 98(sp),184(sp)
    11cc:	move.l 102(sp),188(sp)
    11d2:	lea 44(sp),sp
    11d6:	move.l 144(sp),-(sp)
    11da:	move.l 144(sp),-(sp)
    11de:	clr.l -(sp)
    11e0:	clr.l -(sp)
    11e2:	move.l d2,-(sp)
    11e4:	move.l a6,-(sp)
    11e6:	move.l d3,-(sp)
    11e8:	move.l d7,-(sp)
    11ea:	move.l d6,-(sp)
    11ec:	move.l d5,-(sp)
    11ee:	move.l d4,-(sp)
    11f0:	jsr (a3)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, ps2, pdb[2], 32, 32);
    11f2:	move.l 126(sp),192(sp)
    11f8:	move.l 122(sp),196(sp)
    11fe:	lea 44(sp),sp
    1202:	move.l 152(sp),-(sp)
    1206:	move.l 152(sp),-(sp)
    120a:	clr.l -(sp)
    120c:	clr.l -(sp)
    120e:	move.l d2,-(sp)
    1210:	move.l a6,-(sp)
    1212:	move.l d3,-(sp)
    1214:	move.l d7,-(sp)
    1216:	move.l d6,-(sp)
    1218:	move.l d5,-(sp)
    121a:	move.l d4,-(sp)
    121c:	jsr (a3)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, ps2, pdb[3], 32, 32);
    121e:	move.l 118(sp),200(sp)
    1224:	move.l a4,204(sp)
    1228:	lea 44(sp),sp
    122c:	move.l 160(sp),-(sp)
    1230:	move.l 160(sp),-(sp)
    1234:	clr.l -(sp)
    1236:	clr.l -(sp)
    1238:	move.l d2,-(sp)
    123a:	move.l a6,-(sp)
    123c:	move.l d3,-(sp)
    123e:	move.l d7,-(sp)
    1240:	move.l d6,-(sp)
    1242:	move.l d5,-(sp)
    1244:	move.l d4,-(sp)
    1246:	jsr (a3)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, ps2, pdb[4], 32, 32);
    1248:	move.l 114(sp),208(sp)
    124e:	move.l a5,212(sp)
    1252:	lea 44(sp),sp
    1256:	move.l 168(sp),-(sp)
    125a:	move.l 168(sp),-(sp)
    125e:	clr.l -(sp)
    1260:	clr.l -(sp)
    1262:	move.l d2,-(sp)
    1264:	move.l a6,-(sp)
    1266:	move.l d3,-(sp)
    1268:	move.l d7,-(sp)
    126a:	move.l d6,-(sp)
    126c:	move.l d5,-(sp)
    126e:	move.l d4,-(sp)
    1270:	jsr (a3)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, ps2, pdb[5], 32, 32);
    1272:	move.l 106(sp),216(sp)
    1278:	move.l 110(sp),220(sp)
    127e:	lea 44(sp),sp
    1282:	move.l 176(sp),-(sp)
    1286:	move.l 176(sp),-(sp)
    128a:	clr.l -(sp)
    128c:	clr.l -(sp)
    128e:	move.l d2,-(sp)
    1290:	move.l a6,-(sp)
    1292:	move.l d3,-(sp)
    1294:	move.l d7,-(sp)
    1296:	move.l d6,-(sp)
    1298:	move.l d5,-(sp)
    129a:	move.l d4,-(sp)
    129c:	jsr (a3)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    129e:	move.b bfe001 <_end+0xbdca25>,d4
	while (!MouseLeft())
    12a4:	lea 44(sp),sp
    12a8:	move.l 50(sp),d0
    12ac:	move.l 46(sp),d1
    12b0:	btst #6,d4
    12b4:	beq.w 16ec <main+0x1678>
    12b8:	movea.l 2150a <BmpUpperPart_PF2+0xe>,a0
    12be:	move.w 2149c <BmpScroller+0x8>,d7
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    12c4:	movea.l dff004 <_end+0xddda28>,a1
    12ca:	move.l a1,128(sp)
		vpos &= 0x1ff00;
    12ce:	move.l 128(sp),d4
    12d2:	andi.l #130816,d4
    12d8:	move.l d4,128(sp)
		if (vpos != (311 << 8))
    12dc:	movea.l 128(sp),a1
    12e0:	cmpa.l #79616,a1
    12e6:	beq.w d3c <main+0xcc8>
    12ea:	bra.w d60 <main+0xcec>
		ScrollCnt = 0;
    12ee:	clr.w 213d8 <ScrollCnt>
		PlotChar(BmpFont32, (UBYTE *)BmpFont32P, BmpScroller, (UBYTE *)BmpScroller.ImageData, startY, 32, 32);
    12f4:	move.l 214a2 <BmpScroller+0xe>,94(sp)
    12fc:	move.w 21464 <BmpFont32+0x4>,d3
    1302:	move.w 21466 <BmpFont32+0x6>,d6
    1308:	movea.w 21468 <BmpFont32+0x8>,a1
    130e:	move.w 2149a <BmpScroller+0x6>,d5
    1314:	move.w 2149c <BmpScroller+0x8>,d7
	UBYTE chr = Scrolltext[ScrolltextCnt++];
    131a:	movea.w 213d6 <ScrolltextCnt>,a0
    1320:	move.w a0,d1
    1322:	addq.w #1,d1
    1324:	move.w d1,213d6 <ScrolltextCnt>
    132a:	moveq #0,d0
    132c:	move.w a0,d0
    132e:	lea 38e6 <Scrolltext>,a6
    1334:	move.b (0,a6,d0.l),d0
	if (chr == 'b')
    1338:	cmpi.b #98,d0
    133c:	beq.w 14de <main+0x146a>
	if (chr == 'm')
    1340:	cmpi.b #109,d0
    1344:	beq.w 13dc <main+0x1368>
	if (chr == 0)
    1348:	tst.b d0
    134a:	bne.w 1436 <main+0x13c2>
		chr = Scrolltext[ScrolltextCnt++];
    134e:	move.w #1,213d6 <ScrolltextCnt>
    1356:	moveq #0,d2
    1358:	moveq #4,d1
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    135a:	move.l d1,-(sp)
    135c:	move.w a1,-(sp)
    135e:	clr.w -(sp)
    1360:	jsr 1d58 <__mulsi3>
    1366:	addq.l #8,sp
    1368:	lsl.l #5,d0
    136a:	add.l d0,d2
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    136c:	mulu.w #40,d7
    1370:	moveq #0,d0
    1372:	move.w 2159e <Screen+0x6>,d0
    1378:	add.l d0,d7
	WaitBlit();
    137a:	movea.l 215ce <GfxBase>,a6
    1380:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    1384:	movea.l 215d8 <custom>,a2
    138a:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
    1390:	move.w #0,66(a2)
	custom->bltafwm = 0xffff;
    1396:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    139c:	move.w #-1,70(a2)
	custom->bltapt = bmpFontP + source;
    13a2:	addi.l #28870,d2
    13a8:	move.l d2,80(a2)
	custom->bltdpt = bmpDestP + dest;
    13ac:	add.l 94(sp),d7
    13b0:	move.l d7,84(a2)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    13b4:	subq.w #4,d6
    13b6:	move.w d6,100(a2)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    13ba:	subq.w #4,d5
    13bc:	move.w d5,102(a2)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    13c0:	moveq #11,d0
    13c2:	lsl.w d0,d3
    13c4:	addq.w #2,d3
    13c6:	move.w d3,88(a2)
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    13ca:	move.w 2149a <BmpScroller+0x6>,d5
    13d0:	move.l 214a2 <BmpScroller+0xe>,94(sp)
    13d8:	bra.w 109a <main+0x1026>
		if (MirrorEnabled)
    13dc:	move.w 213d4 <MirrorEnabled>,d0
				 BmpScroller.Bplt - Screen.Bpl);
    13e2:	move.w d7,d2
    13e4:	sub.w 2159e <Screen+0x6>,d2
	copSetBplMod(0, copMirrorBmpP,
    13ea:	movea.l 213d0 <copMirrorBmpP>,a0
		if (MirrorEnabled)
    13f0:	tst.w d0
    13f2:	beq.w 1848 <main+0x17d4>
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    13f6:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    13fa:	move.w d2,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    13fe:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    1404:	move.w d2,6(a0)
		MirrorEnabled = !MirrorEnabled;
    1408:	tst.w d0
    140a:	seq d0
    140c:	ext.w d0
    140e:	neg.w d0
    1410:	move.w d0,213d4 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    1416:	move.w d1,d0
    1418:	addq.w #1,d0
    141a:	move.w d0,213d6 <ScrolltextCnt>
    1420:	andi.l #65535,d1
    1426:	lea 38e6 <Scrolltext>,a0
    142c:	move.b (0,a0,d1.l),d0
	if (chr == 0)
    1430:	tst.b d0
    1432:	beq.w 134e <main+0x12da>
	if (chr < 32 || chr > (32 + 80))
    1436:	addi.b #-32,d0
    143a:	cmpi.b #80,d0
    143e:	bhi.w 109a <main+0x1026>
	row = chr / 10;
    1442:	andi.w #255,d0
    1446:	move.w d0,d2
    1448:	mulu.w #-13107,d2
    144c:	clr.w d2
    144e:	swap d2
    1450:	lsr.w #3,d2
    1452:	moveq #0,d1
    1454:	move.b d2,d1
	col = chr % 10;
    1456:	movea.w d2,a0
    1458:	adda.w d2,a0
    145a:	adda.w a0,a0
    145c:	adda.w d2,a0
    145e:	adda.w a0,a0
    1460:	sub.w a0,d0
    1462:	moveq #0,d2
    1464:	move.b d0,d2
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    1466:	add.l d2,d2
    1468:	add.l d2,d2
    146a:	move.l d1,-(sp)
    146c:	move.w a1,-(sp)
    146e:	clr.w -(sp)
    1470:	jsr 1d58 <__mulsi3>
    1476:	addq.l #8,sp
    1478:	lsl.l #5,d0
    147a:	add.l d0,d2
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    147c:	mulu.w #40,d7
    1480:	moveq #0,d0
    1482:	move.w 2159e <Screen+0x6>,d0
    1488:	add.l d0,d7
	WaitBlit();
    148a:	movea.l 215ce <GfxBase>,a6
    1490:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    1494:	movea.l 215d8 <custom>,a2
    149a:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
    14a0:	move.w #0,66(a2)
	custom->bltafwm = 0xffff;
    14a6:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    14ac:	move.w #-1,70(a2)
	custom->bltapt = bmpFontP + source;
    14b2:	addi.l #28870,d2
    14b8:	move.l d2,80(a2)
	custom->bltdpt = bmpDestP + dest;
    14bc:	add.l 94(sp),d7
    14c0:	move.l d7,84(a2)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    14c4:	subq.w #4,d6
    14c6:	move.w d6,100(a2)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    14ca:	subq.w #4,d5
    14cc:	move.w d5,102(a2)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    14d0:	moveq #11,d0
    14d2:	lsl.w d0,d3
    14d4:	addq.w #2,d3
    14d6:	move.w d3,88(a2)
    14da:	bra.w 13ca <main+0x1356>
		if (BounceEnabled)
    14de:	move.w 213de <BounceEnabled>,d0
    14e4:	beq.s 14f4 <main+0x1480>
			ScrollerY = ScrollerMax;
    14e6:	move.w #40,4000 <ScrollerY>
			ScrollerDir = -1;
    14ee:	st 4002 <ScrollerDir>
		BounceEnabled = !BounceEnabled;
    14f4:	tst.w d0
    14f6:	seq d0
    14f8:	ext.w d0
    14fa:	neg.w d0
    14fc:	move.w d0,213de <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    1502:	addq.w #2,a0
    1504:	move.w a0,213d6 <ScrolltextCnt>
    150a:	andi.l #65535,d1
    1510:	lea 38e6 <Scrolltext>,a6
    1516:	move.b (0,a6,d1.l),d0
    151a:	move.w a0,d1
	if (chr == 'm')
    151c:	cmpi.b #109,d0
    1520:	bne.w 1348 <main+0x12d4>
    1524:	bra.w 13dc <main+0x1368>
		else if (ScrollerY <= ScrollerMin)
    1528:	cmpa.w #0,a0
    152c:	bgt.w 100a <main+0xf96>
			ScrollerY = ScrollerMin;
    1530:	clr.w 4000 <ScrollerY>
			ScrollerDir = 1;
    1536:	move.b #1,4002 <ScrollerDir>
	int BltOffs = startY * theDesc.Bplt;
    153e:	move.w d7,d2
    1540:	mulu.w #40,d2
	int Brcorner = height * theDesc.Bplt - 2;
    1544:	moveq #0,d0
    1546:	move.w d7,d0
    1548:	lsl.l #5,d0
    154a:	move.l d0,d7
    154c:	subq.l #2,d7
	WaitBlit();
    154e:	movea.l 215ce <GfxBase>,a6
    1554:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
    1558:	movea.l 215d8 <custom>,a2
    155e:	move.w #18928,64(a2)
	custom->bltcon1 = 0x0002;
    1564:	move.w #2,66(a2)
	custom->bltafwm = 0xffff;
    156a:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    1570:	move.w #-1,70(a2)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
    1576:	move.l d2,d0
    1578:	add.l d7,d0
    157a:	add.l 94(sp),d0
    157e:	move.l d0,80(a2)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
    1582:	move.l d0,84(a2)
	custom->bltamod = 0;
    1586:	move.w #0,100(a2)
	custom->bltdmod = 0;
    158c:	move.w #0,102(a2)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
    1592:	move.w 98(sp),d0
    1596:	moveq #11,d1
    1598:	lsl.w d1,d0
    159a:	lea 21494 <BmpScroller>,a0
    15a0:	move.w (a0),d1
    15a2:	lsr.w #4,d1
    15a4:	add.w d1,d0
    15a6:	move.w d0,88(a2)
	ScrollCnt += speed;
    15aa:	move.w 213d8 <ScrollCnt>,d0
    15b0:	addq.w #4,d0
    15b2:	move.w d0,213d8 <ScrollCnt>
	if (ScrollCnt >= 32)
    15b8:	cmpi.w #31,d0
    15bc:	bls.w 108c <main+0x1018>
    15c0:	bra.w 12ee <main+0x127a>
			if (pdb[b].Y <= 0)
    15c4:	tst.l 66(sp)
    15c8:	bgt.w faa <main+0xf36>
				incY[b] *= -1;
    15cc:	neg.w 118(sp)
				pdb[b].Y = 0;
    15d0:	clr.l 66(sp)
    15d4:	bra.w faa <main+0xf36>
			if (pdb[b].X <= 0)
    15d8:	tst.l 62(sp)
    15dc:	bgt.w f94 <main+0xf20>
				incX[b] *= -1;
    15e0:	neg.w 104(sp)
				pdb[b].X = 0;
    15e4:	clr.l 62(sp)
    15e8:	bra.w f94 <main+0xf20>
			if (pdb[b].Y <= 0)
    15ec:	cmpa.w #0,a5
    15f0:	bgt.w f58 <main+0xee4>
				incY[b] *= -1;
    15f4:	neg.w 120(sp)
				pdb[b].Y = 0;
    15f8:	suba.l a5,a5
    15fa:	bra.w f58 <main+0xee4>
			if (pdb[b].X <= 0)
    15fe:	tst.l 70(sp)
    1602:	bgt.w f48 <main+0xed4>
				incX[b] *= -1;
    1606:	neg.w 106(sp)
				pdb[b].X = 0;
    160a:	clr.l 70(sp)
    160e:	bra.w f48 <main+0xed4>
			if (pdb[b].Y <= 0)
    1612:	cmpa.w #0,a4
    1616:	bgt.w f12 <main+0xe9e>
				incY[b] *= -1;
    161a:	neg.w 116(sp)
				pdb[b].Y = 0;
    161e:	suba.l a4,a4
    1620:	bra.w f12 <main+0xe9e>
			if (pdb[b].X <= 0)
    1624:	tst.l 74(sp)
    1628:	bgt.w f02 <main+0xe8e>
				incX[b] *= -1;
    162c:	neg.w 102(sp)
				pdb[b].X = 0;
    1630:	clr.l 74(sp)
    1634:	bra.w f02 <main+0xe8e>
			if (pdb[b].Y <= 0)
    1638:	tst.l 78(sp)
    163c:	bgt.w ecc <main+0xe58>
				incY[b] *= -1;
    1640:	neg.w 112(sp)
				pdb[b].Y = 0;
    1644:	clr.l 78(sp)
    1648:	bra.w ecc <main+0xe58>
			if (pdb[b].X <= 0)
    164c:	tst.l 82(sp)
    1650:	bgt.w eb6 <main+0xe42>
				incX[b] *= -1;
    1654:	neg.w 108(sp)
				pdb[b].X = 0;
    1658:	clr.l 82(sp)
    165c:	bra.w eb6 <main+0xe42>
			if (pdb[b].Y <= 0)
    1660:	tst.l 58(sp)
    1664:	bgt.w e7a <main+0xe06>
				incY[b] *= -1;
    1668:	neg.w 114(sp)
				pdb[b].Y = 0;
    166c:	clr.l 58(sp)
    1670:	bra.w e7a <main+0xe06>
			if (pdb[b].X <= 0)
    1674:	tst.l 54(sp)
    1678:	bgt.w e64 <main+0xdf0>
				incX[b] *= -1;
    167c:	neg.w 100(sp)
				pdb[b].X = 0;
    1680:	clr.l 54(sp)
    1684:	bra.w e64 <main+0xdf0>
			if (pdb[b].Y <= 0)
    1688:	tst.l 86(sp)
    168c:	bgt.w e28 <main+0xdb4>
				incY[b] *= -1;
    1690:	neg.w 122(sp)
				pdb[b].Y = 0;
    1694:	clr.l 86(sp)
    1698:	bra.w e28 <main+0xdb4>
			if (pdb[b].X <= 0)
    169c:	tst.l 90(sp)
    16a0:	bgt.w e12 <main+0xd9e>
				incX[b] *= -1;
    16a4:	neg.w 110(sp)
				pdb[b].X = 0;
    16a8:	clr.l 90(sp)
    16ac:	bra.w e12 <main+0xd9e>
				ScrollerDir -= 1;
    16b0:	subq.b #1,d0
				if (ScrollerDir < -4)
    16b2:	cmpi.b #-4,d0
    16b6:	bge.w 182e <main+0x17ba>
					ScrollerDir = -4;
    16ba:	move.b #-4,4002 <ScrollerDir>
    16c2:	moveq #-4,d0
			ScrollerY += ScrollerDir;
    16c4:	add.w d0,d1
    16c6:	move.w d1,4000 <ScrollerY>
    16cc:	bra.w ff2 <main+0xf7e>
				if (ScrollerDir < 1)
    16d0:	tst.b d0
    16d2:	bgt.w 18c8 <main+0x1854>
					ScrollerDir = 1;
    16d6:	move.b #1,4002 <ScrollerDir>
    16de:	moveq #1,d0
			ScrollerY += ScrollerDir;
    16e0:	add.w d0,d1
    16e2:	move.w d1,4000 <ScrollerY>
    16e8:	bra.w ff2 <main+0xf7e>
    16ec:	movea.l 213f2 <copPtr>,a1
	FreeMem(copPtr, 1024);
    16f2:	movea.l 215d2 <SysBase>,a6
    16f8:	move.l #1024,d0
    16fe:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    1702:	movea.l 215d2 <SysBase>,a6
    1708:	movea.l 214a2 <BmpScroller+0xe>,a1
    170e:	moveq #0,d0
    1710:	move.w 214a0 <BmpScroller+0xc>,d0
    1716:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    171a:	movea.l 215d2 <SysBase>,a6
    1720:	movea.l 2153e <BmpUpperPart_PF1+0xe>,a1
    1726:	moveq #0,d0
    1728:	move.w 2153c <BmpUpperPart_PF1+0xc>,d0
    172e:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    1732:	movea.l 215d2 <SysBase>,a6
    1738:	movea.l 2150a <BmpUpperPart_PF2+0xe>,a1
    173e:	moveq #0,d0
    1740:	move.w 21508 <BmpUpperPart_PF2+0xc>,d0
    1746:	jsr -210(a6)
	WaitVbl();
    174a:	jsr 1926 <WaitVbl>
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1750:	movea.l 215d8 <custom>,a0
    1756:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    175a:	move.w 2(a0),d0
    175e:	btst #14,d0
    1762:	bne.s 175a <main+0x16e6>
	custom->intena = 0x7fff; //disable all interrupts
    1764:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
    176a:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
    1770:	move.w #32767,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
    1776:	movea.l 213ee <VBR>,a1
    177c:	move.l 213ea <SystemIrq>,108(a1)
	custom->cop1lc = (ULONG)GfxBase->copinit;
    1784:	movea.l 215ce <GfxBase>,a6
    178a:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
    1790:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
    1796:	move.w #32767,136(a0)
	custom->intena = SystemInts | 0x8000;
    179c:	move.w 213e8 <SystemInts>,d0
    17a2:	ori.w #-32768,d0
    17a6:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
    17aa:	move.w 213e6 <SystemDMA>,d0
    17b0:	ori.w #-32768,d0
    17b4:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
    17b8:	move.w 213e4 <SystemADKCON>,d0
    17be:	ori.w #-32768,d0
    17c2:	move.w d0,158(a0)
	LoadView(ActiView);
    17c6:	movea.l 213e0 <ActiView>,a1
    17cc:	jsr -222(a6)
	WaitTOF();
    17d0:	movea.l 215ce <GfxBase>,a6
    17d6:	jsr -270(a6)
	WaitTOF();
    17da:	movea.l 215ce <GfxBase>,a6
    17e0:	jsr -270(a6)
	WaitBlit();
    17e4:	movea.l 215ce <GfxBase>,a6
    17ea:	jsr -228(a6)
	DisownBlitter();
    17ee:	movea.l 215ce <GfxBase>,a6
    17f4:	jsr -462(a6)
	Enable();
    17f8:	movea.l 215d2 <SysBase>,a6
    17fe:	jsr -126(a6)
	CloseLibrary((struct Library *)DOSBase);
    1802:	movea.l 215d2 <SysBase>,a6
    1808:	movea.l 215ca <DOSBase>,a1
    180e:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    1812:	movea.l 215d2 <SysBase>,a6
    1818:	movea.l 215ce <GfxBase>,a1
    181e:	jsr -414(a6)
}
    1822:	moveq #0,d0
    1824:	movem.l (sp)+,d2-d7/a2-a6
    1828:	lea 136(sp),sp
    182c:	rts
				if (ScrollerDir > -1)
    182e:	tst.b d0
    1830:	blt.w 18c8 <main+0x1854>
					ScrollerDir = -1;
    1834:	st 4002 <ScrollerDir>
    183a:	moveq #-1,d0
			ScrollerY += ScrollerDir;
    183c:	add.w d0,d1
    183e:	move.w d1,4000 <ScrollerY>
    1844:	bra.w ff2 <main+0xf7e>
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
    1848:	movea.w d7,a6
    184a:	adda.w d7,a6
    184c:	sub.w a6,d2
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    184e:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    1852:	move.w d2,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    1856:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    185c:	move.w d2,6(a0)
		MirrorEnabled = !MirrorEnabled;
    1860:	tst.w d0
    1862:	seq d0
    1864:	ext.w d0
    1866:	neg.w d0
    1868:	move.w d0,213d4 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    186e:	move.w d1,d0
    1870:	addq.w #1,d0
    1872:	move.w d0,213d6 <ScrolltextCnt>
    1878:	andi.l #65535,d1
    187e:	lea 38e6 <Scrolltext>,a0
    1884:	move.b (0,a0,d1.l),d0
    1888:	bra.w 1430 <main+0x13bc>
		Exit(0);
    188c:	suba.l a6,a6
    188e:	moveq #0,d1
    1890:	jsr -144(a6)
    1894:	bra.w c2 <main+0x4e>
		Exit(0);
    1898:	movea.l 215ca <DOSBase>,a6
    189e:	moveq #0,d1
    18a0:	jsr -144(a6)
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    18a4:	movea.l 215d2 <SysBase>,a6
    18aa:	lea 38ae <incbin_P61_Player_end+0x12>,a1
    18b0:	moveq #0,d0
    18b2:	jsr -552(a6)
    18b6:	move.l d0,215ca <DOSBase>
	if (!DOSBase)
    18bc:	bne.w c2 <main+0x4e>
    18c0:	bra.s 188c <main+0x1818>
	APTR vbr = 0;
    18c2:	moveq #0,d0
    18c4:	bra.w 85c <main+0x7e8>
				ScrollerDir -= 1;
    18c8:	move.b d0,4002 <ScrollerDir>
			ScrollerY += ScrollerDir;
    18ce:	ext.w d0
    18d0:	add.w d0,d1
    18d2:	move.w d1,4000 <ScrollerY>
    18d8:	bra.w ff2 <main+0xf7e>
    for (USHORT i = 0; i < numPlanes; i++)
    18dc:	movea.l a2,a6
    18de:	bra.w a5c <main+0x9e8>
    18e2:	nop

000018e4 <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

static __attribute__((interrupt)) void interruptHandler()
{
    18e4:	movem.l d0/a0/a3/a6,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    18e8:	movea.l 215d8 <custom>,a0
    18ee:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    18f4:	move.w #32,156(a0)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    18fa:	lea 1f36 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    1900:	movea.l #14675968,a6
	__asm volatile(
    1906:	movem.l d0-a2/a4-a5,-(sp)
    190a:	jsr 4(a3)
    190e:	movem.l (sp)+,d0-a2/a4-a5

    // DEMO - ThePlayer
    p61Music();

    // DEMO - increment frameCounter
    frameCounter++;
    1912:	move.w 215d6 <frameCounter>,d0
    1918:	addq.w #1,d0
    191a:	move.w d0,215d6 <frameCounter>
}
    1920:	movem.l (sp)+,d0/a0/a3/a6
    1924:	rte

00001926 <WaitVbl>:
{
    1926:	subq.l #8,sp
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    1928:	move.l dff004 <_end+0xddda28>,d0
    192e:	move.l d0,(sp)
		vpos &= 0x1ff00;
    1930:	move.l (sp),d0
    1932:	andi.l #130816,d0
    1938:	move.l d0,(sp)
		if (vpos != (311 << 8))
    193a:	move.l (sp),d0
    193c:	cmpi.l #79616,d0
    1942:	beq.s 1928 <WaitVbl+0x2>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    1944:	move.l dff004 <_end+0xddda28>,d0
    194a:	move.l d0,4(sp)
		vpos &= 0x1ff00;
    194e:	move.l 4(sp),d0
    1952:	andi.l #130816,d0
    1958:	move.l d0,4(sp)
		if (vpos == (311 << 8))
    195c:	move.l 4(sp),d0
    1960:	cmpi.l #79616,d0
    1966:	bne.s 1944 <WaitVbl+0x1e>
}
    1968:	addq.l #8,sp
    196a:	rts

0000196c <KPrintF>:
void KPrintF(const char* fmt, ...) {
    196c:	lea -128(sp),sp
    1970:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    1974:	move.w f0ff60 <_end+0xeee984>,d0
    197a:	cmpi.w #20153,d0
    197e:	beq.s 19aa <KPrintF+0x3e>
    1980:	cmpi.w #-24562,d0
    1984:	beq.s 19aa <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    1986:	movea.l 215d2 <SysBase>,a6
    198c:	movea.l 144(sp),a0
    1990:	lea 148(sp),a1
    1994:	lea 1e52 <KPutCharX>,a2
    199a:	suba.l a3,a3
    199c:	jsr -522(a6)
}
    19a0:	movem.l (sp)+,a2-a3/a6
    19a4:	lea 128(sp),sp
    19a8:	rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    19aa:	movea.l 215d2 <SysBase>,a6
    19b0:	movea.l 144(sp),a0
    19b4:	lea 148(sp),a1
    19b8:	lea 1e60 <PutChar>,a2
    19be:	lea 12(sp),a3
    19c2:	jsr -522(a6)
		UaeDbgLog(86, temp);
    19c6:	move.l a3,-(sp)
    19c8:	pea 56 <_start+0x56>
    19cc:	jsr f0ff60 <_end+0xeee984>
    19d2:	addq.l #8,sp
}
    19d4:	movem.l (sp)+,a2-a3/a6
    19d8:	lea 128(sp),sp
    19dc:	rts

000019de <BetterBlit.constprop.0.isra.0>:
void BetterBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
    19de:	movem.l d2-d7/a2,-(sp)
    19e2:	move.l 68(sp),d2
    19e6:	move.l 72(sp),d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    19ea:	movea.l 215d8 <custom>,a2
    19f0:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    19f4:	move.w 2(a2),d0
    19f8:	btst #14,d0
    19fc:	bne.s 19f4 <BetterBlit.constprop.0.isra.0+0x16>
	BYTE shift = startD.X % 16;
    19fe:	move.l d2,d4
    1a00:	andi.l #-2147483633,d4
    1a06:	tst.l d2
    1a08:	blt.w 1b26 <BetterBlit.constprop.0.isra.0+0x148>
    1a0c:	moveq #15,d6
    1a0e:	and.l d2,d6
	if (shift)
    1a10:	beq.w 1acc <BetterBlit.constprop.0.isra.0+0xee>
    1a14:	moveq #3,d3
    1a16:	moveq #6,d5
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1a18:	move.l d4,d0
    1a1a:	moveq #12,d7
    1a1c:	lsl.l d7,d0
    1a1e:	ori.w #4042,d0
    1a22:	move.w d0,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1a26:	move.w d4,d0
    1a28:	lsl.w d7,d0
    1a2a:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1a2e:	move.l 44(sp),80(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
    1a34:	move.w 38(sp),d0
    1a38:	sub.w d5,d0
    1a3a:	move.w d0,100(a2)
	custom->bltbpt = (UBYTE *)BmpCookieMask.ImageData + (startA.Y * BmpCookieMask.Bpl) + (startA.X / 8);
    1a3e:	move.l 21406 <BmpCookieMask+0xe>,76(a2)
	custom->bltbmod = BmpCookieMask.Bpl - (width / 8);
    1a46:	move.w 213fe <BmpCookieMask+0x6>,d0
    1a4c:	sub.w d5,d0
    1a4e:	move.w d0,98(a2)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1a52:	move.l d1,-(sp)
    1a54:	move.w 58(sp),-(sp)
    1a58:	clr.w -(sp)
    1a5a:	jsr 1d58 <__mulsi3>
    1a60:	addq.l #8,sp
    1a62:	tst.l d2
    1a64:	blt.w 1b20 <BetterBlit.constprop.0.isra.0+0x142>
    1a68:	asr.l #3,d2
    1a6a:	add.l d0,d2
    1a6c:	add.l 56(sp),d2
    1a70:	move.l d2,84(a2)
    1a74:	move.l d2,72(a2)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1a78:	move.w 50(sp),d0
    1a7c:	sub.w d5,d0
    1a7e:	move.w d0,102(a2)
    1a82:	move.w d0,96(a2)
	custom->bltafwm = 0xffff;
    1a86:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1a8c:	tst.l d6
    1a8e:	beq.s 1ab2 <BetterBlit.constprop.0.isra.0+0xd4>
    1a90:	moveq #15,d1
    1a92:	sub.l d4,d1
    1a94:	moveq #0,d0
    1a96:	not.w d0
    1a98:	lsl.l d1,d0
    1a9a:	move.w d0,70(a2)
	custom->bltsize = ((height * imgA.Bpls) << HSIZEBITS) | (width / 16);
    1a9e:	move.w 34(sp),d0
    1aa2:	moveq #11,d1
    1aa4:	lsl.w d1,d0
    1aa6:	or.w d3,d0
    1aa8:	move.w d0,88(a2)
}
    1aac:	movem.l (sp)+,d2-d7/a2
    1ab0:	rts
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1ab2:	moveq #-1,d0
    1ab4:	move.w d0,70(a2)
	custom->bltsize = ((height * imgA.Bpls) << HSIZEBITS) | (width / 16);
    1ab8:	move.w 34(sp),d0
    1abc:	moveq #11,d1
    1abe:	lsl.w d1,d0
    1ac0:	or.w d3,d0
    1ac2:	move.w d0,88(a2)
}
    1ac6:	movem.l (sp)+,d2-d7/a2
    1aca:	rts
	if (shift)
    1acc:	moveq #2,d3
    1ace:	moveq #4,d5
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1ad0:	move.l d4,d0
    1ad2:	moveq #12,d7
    1ad4:	lsl.l d7,d0
    1ad6:	ori.w #4042,d0
    1ada:	move.w d0,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1ade:	move.w d4,d0
    1ae0:	lsl.w d7,d0
    1ae2:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1ae6:	move.l 44(sp),80(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
    1aec:	move.w 38(sp),d0
    1af0:	sub.w d5,d0
    1af2:	move.w d0,100(a2)
	custom->bltbpt = (UBYTE *)BmpCookieMask.ImageData + (startA.Y * BmpCookieMask.Bpl) + (startA.X / 8);
    1af6:	move.l 21406 <BmpCookieMask+0xe>,76(a2)
	custom->bltbmod = BmpCookieMask.Bpl - (width / 8);
    1afe:	move.w 213fe <BmpCookieMask+0x6>,d0
    1b04:	sub.w d5,d0
    1b06:	move.w d0,98(a2)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1b0a:	move.l d1,-(sp)
    1b0c:	move.w 58(sp),-(sp)
    1b10:	clr.w -(sp)
    1b12:	jsr 1d58 <__mulsi3>
    1b18:	addq.l #8,sp
    1b1a:	tst.l d2
    1b1c:	bge.w 1a68 <BetterBlit.constprop.0.isra.0+0x8a>
    1b20:	addq.l #7,d2
    1b22:	bra.w 1a68 <BetterBlit.constprop.0.isra.0+0x8a>
	BYTE shift = startD.X % 16;
    1b26:	subq.l #1,d4
    1b28:	moveq #-16,d0
    1b2a:	or.l d0,d4
    1b2c:	addq.l #1,d4
    1b2e:	bra.w 1a0c <BetterBlit.constprop.0.isra.0+0x2e>

00001b32 <strlen>:
unsigned long strlen(const char* s) {
    1b32:	movea.l 4(sp),a0
	unsigned long t=0;
    1b36:	moveq #0,d0
	while(*s++)
    1b38:	tst.b (a0)
    1b3a:	beq.s 1b44 <strlen+0x12>
		t++;
    1b3c:	addq.l #1,d0
	while(*s++)
    1b3e:	tst.b (0,a0,d0.l)
    1b42:	bne.s 1b3c <strlen+0xa>
}
    1b44:	rts

00001b46 <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    1b46:	movem.l d2-d7/a2-a3,-(sp)
    1b4a:	move.l 36(sp),d0
    1b4e:	move.l 40(sp),d4
    1b52:	movea.l 44(sp),a1
	while(len-- > 0)
    1b56:	move.l a1,d5
    1b58:	subq.l #1,d5
    1b5a:	cmpa.w #0,a1
    1b5e:	beq.w 1c0e <memset+0xc8>
		*ptr++ = val;
    1b62:	move.b d4,d7
    1b64:	move.l d0,d1
    1b66:	neg.l d1
    1b68:	moveq #3,d2
    1b6a:	and.l d2,d1
    1b6c:	moveq #5,d6
    1b6e:	movea.l d0,a2
    1b70:	cmp.l d5,d6
    1b72:	bcc.s 1bde <memset+0x98>
    1b74:	tst.l d1
    1b76:	beq.s 1b9c <memset+0x56>
    1b78:	move.b d4,(a2)+
	while(len-- > 0)
    1b7a:	subq.l #1,d5
    1b7c:	moveq #1,d2
    1b7e:	cmp.l d1,d2
    1b80:	beq.s 1b9c <memset+0x56>
		*ptr++ = val;
    1b82:	movea.l d0,a2
    1b84:	addq.l #2,a2
    1b86:	movea.l d0,a0
    1b88:	move.b d4,1(a0)
	while(len-- > 0)
    1b8c:	subq.l #1,d5
    1b8e:	moveq #3,d2
    1b90:	cmp.l d1,d2
    1b92:	bne.s 1b9c <memset+0x56>
		*ptr++ = val;
    1b94:	addq.l #1,a2
    1b96:	move.b d4,2(a0)
	while(len-- > 0)
    1b9a:	subq.l #1,d5
    1b9c:	move.l a1,d3
    1b9e:	sub.l d1,d3
    1ba0:	moveq #0,d6
    1ba2:	move.b d4,d6
    1ba4:	move.l d6,d2
    1ba6:	swap d2
    1ba8:	clr.w d2
    1baa:	movea.l d2,a0
    1bac:	move.l d4,d2
    1bae:	lsl.w #8,d2
    1bb0:	swap d2
    1bb2:	clr.w d2
    1bb4:	lsl.l #8,d6
    1bb6:	movea.l d6,a3
    1bb8:	move.l a0,d6
    1bba:	or.l d6,d2
    1bbc:	move.l a3,d6
    1bbe:	or.l d6,d2
    1bc0:	move.b d7,d2
    1bc2:	movea.l d0,a0
    1bc4:	adda.l d1,a0
    1bc6:	moveq #-4,d1
    1bc8:	and.l d3,d1
    1bca:	add.l a0,d1
		*ptr++ = val;
    1bcc:	move.l d2,(a0)+
	while(len-- > 0)
    1bce:	cmpa.l d1,a0
    1bd0:	bne.s 1bcc <memset+0x86>
    1bd2:	moveq #-4,d1
    1bd4:	and.l d3,d1
    1bd6:	adda.l d1,a2
    1bd8:	sub.l d1,d5
    1bda:	cmp.l d3,d1
    1bdc:	beq.s 1c0e <memset+0xc8>
		*ptr++ = val;
    1bde:	move.b d4,(a2)
	while(len-- > 0)
    1be0:	tst.l d5
    1be2:	beq.s 1c0e <memset+0xc8>
		*ptr++ = val;
    1be4:	move.b d4,1(a2)
	while(len-- > 0)
    1be8:	moveq #1,d1
    1bea:	cmp.l d5,d1
    1bec:	beq.s 1c0e <memset+0xc8>
		*ptr++ = val;
    1bee:	move.b d4,2(a2)
	while(len-- > 0)
    1bf2:	moveq #2,d2
    1bf4:	cmp.l d5,d2
    1bf6:	beq.s 1c0e <memset+0xc8>
		*ptr++ = val;
    1bf8:	move.b d4,3(a2)
	while(len-- > 0)
    1bfc:	moveq #3,d6
    1bfe:	cmp.l d5,d6
    1c00:	beq.s 1c0e <memset+0xc8>
		*ptr++ = val;
    1c02:	move.b d4,4(a2)
	while(len-- > 0)
    1c06:	subq.l #4,d5
    1c08:	beq.s 1c0e <memset+0xc8>
		*ptr++ = val;
    1c0a:	move.b d4,5(a2)
}
    1c0e:	movem.l (sp)+,d2-d7/a2-a3
    1c12:	rts

00001c14 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    1c14:	movem.l d2-d6,-(sp)
    1c18:	move.l 24(sp),d0
    1c1c:	move.l 28(sp),d1
    1c20:	move.l 32(sp),d3
	while(len--)
    1c24:	move.l d3,d4
    1c26:	subq.l #1,d4
    1c28:	tst.l d3
    1c2a:	beq.s 1c8a <memcpy+0x76>
    1c2c:	movea.l d1,a0
    1c2e:	addq.l #1,a0
    1c30:	move.l d0,d2
    1c32:	sub.l a0,d2
    1c34:	moveq #2,d5
    1c36:	cmp.l d2,d5
    1c38:	sc.s d2
    1c3a:	neg.b d2
    1c3c:	moveq #8,d6
    1c3e:	cmp.l d4,d6
    1c40:	sc.s d5
    1c42:	neg.b d5
    1c44:	and.b d5,d2
    1c46:	beq.s 1c90 <memcpy+0x7c>
    1c48:	move.l d0,d2
    1c4a:	or.l d1,d2
    1c4c:	moveq #3,d5
    1c4e:	and.l d5,d2
    1c50:	bne.s 1c90 <memcpy+0x7c>
    1c52:	movea.l d1,a0
    1c54:	movea.l d0,a1
    1c56:	moveq #-4,d2
    1c58:	and.l d3,d2
    1c5a:	add.l d1,d2
		*d++ = *s++;
    1c5c:	move.l (a0)+,(a1)+
	while(len--)
    1c5e:	cmp.l a0,d2
    1c60:	bne.s 1c5c <memcpy+0x48>
    1c62:	moveq #-4,d2
    1c64:	and.l d3,d2
    1c66:	movea.l d0,a0
    1c68:	adda.l d2,a0
    1c6a:	add.l d2,d1
    1c6c:	sub.l d2,d4
    1c6e:	cmp.l d3,d2
    1c70:	beq.s 1c8a <memcpy+0x76>
		*d++ = *s++;
    1c72:	movea.l d1,a1
    1c74:	move.b (a1),(a0)
	while(len--)
    1c76:	tst.l d4
    1c78:	beq.s 1c8a <memcpy+0x76>
		*d++ = *s++;
    1c7a:	move.b 1(a1),1(a0)
	while(len--)
    1c80:	subq.l #1,d4
    1c82:	beq.s 1c8a <memcpy+0x76>
		*d++ = *s++;
    1c84:	move.b 2(a1),2(a0)
}
    1c8a:	movem.l (sp)+,d2-d6
    1c8e:	rts
    1c90:	movea.l d0,a1
    1c92:	add.l d3,d1
		*d++ = *s++;
    1c94:	move.b -1(a0),(a1)+
	while(len--)
    1c98:	cmp.l a0,d1
    1c9a:	beq.s 1c8a <memcpy+0x76>
    1c9c:	addq.l #1,a0
    1c9e:	bra.s 1c94 <memcpy+0x80>

00001ca0 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    1ca0:	movem.l d2-d5/a2,-(sp)
    1ca4:	move.l 24(sp),d0
    1ca8:	move.l 28(sp),d1
    1cac:	move.l 32(sp),d2
		while (len--)
    1cb0:	movea.l d2,a1
    1cb2:	subq.l #1,a1
	if (d < s) {
    1cb4:	cmp.l d0,d1
    1cb6:	bls.s 1d24 <memmove+0x84>
		while (len--)
    1cb8:	tst.l d2
    1cba:	beq.s 1d1e <memmove+0x7e>
    1cbc:	movea.l d1,a2
    1cbe:	addq.l #1,a2
    1cc0:	move.l d0,d3
    1cc2:	sub.l a2,d3
    1cc4:	moveq #2,d4
    1cc6:	cmp.l d3,d4
    1cc8:	sc.s d3
    1cca:	neg.b d3
    1ccc:	moveq #8,d5
    1cce:	cmp.l a1,d5
    1cd0:	sc.s d4
    1cd2:	neg.b d4
    1cd4:	and.b d4,d3
    1cd6:	beq.s 1d48 <memmove+0xa8>
    1cd8:	move.l d0,d3
    1cda:	or.l d1,d3
    1cdc:	moveq #3,d4
    1cde:	and.l d4,d3
    1ce0:	bne.s 1d48 <memmove+0xa8>
    1ce2:	movea.l d1,a0
    1ce4:	movea.l d0,a2
    1ce6:	moveq #-4,d3
    1ce8:	and.l d2,d3
    1cea:	add.l d1,d3
			*d++ = *s++;
    1cec:	move.l (a0)+,(a2)+
		while (len--)
    1cee:	cmp.l a0,d3
    1cf0:	bne.s 1cec <memmove+0x4c>
    1cf2:	moveq #-4,d3
    1cf4:	and.l d2,d3
    1cf6:	movea.l d0,a2
    1cf8:	adda.l d3,a2
    1cfa:	movea.l d1,a0
    1cfc:	adda.l d3,a0
    1cfe:	suba.l d3,a1
    1d00:	cmp.l d2,d3
    1d02:	beq.s 1d1e <memmove+0x7e>
			*d++ = *s++;
    1d04:	move.b (a0),(a2)
		while (len--)
    1d06:	cmpa.w #0,a1
    1d0a:	beq.s 1d1e <memmove+0x7e>
			*d++ = *s++;
    1d0c:	move.b 1(a0),1(a2)
		while (len--)
    1d12:	moveq #1,d5
    1d14:	cmp.l a1,d5
    1d16:	beq.s 1d1e <memmove+0x7e>
			*d++ = *s++;
    1d18:	move.b 2(a0),2(a2)
}
    1d1e:	movem.l (sp)+,d2-d5/a2
    1d22:	rts
		const char *lasts = s + (len - 1);
    1d24:	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    1d28:	adda.l d0,a1
		while (len--)
    1d2a:	tst.l d2
    1d2c:	beq.s 1d1e <memmove+0x7e>
    1d2e:	move.l a0,d1
    1d30:	sub.l d2,d1
			*lastd-- = *lasts--;
    1d32:	move.b (a0),(a1)
		while (len--)
    1d34:	subq.l #1,a0
    1d36:	subq.l #1,a1
    1d38:	cmp.l a0,d1
    1d3a:	beq.s 1d1e <memmove+0x7e>
			*lastd-- = *lasts--;
    1d3c:	move.b (a0),(a1)
		while (len--)
    1d3e:	subq.l #1,a0
    1d40:	subq.l #1,a1
    1d42:	cmp.l a0,d1
    1d44:	bne.s 1d32 <memmove+0x92>
    1d46:	bra.s 1d1e <memmove+0x7e>
    1d48:	movea.l d0,a1
    1d4a:	add.l d2,d1
			*d++ = *s++;
    1d4c:	move.b -1(a2),(a1)+
		while (len--)
    1d50:	cmp.l a2,d1
    1d52:	beq.s 1d1e <memmove+0x7e>
    1d54:	addq.l #1,a2
    1d56:	bra.s 1d4c <memmove+0xac>

00001d58 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    1d58:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    1d5c:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1d60:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    1d64:	mulu.w 8(sp),d1
	addw	d1, d0
    1d68:	add.w d1,d0
	swap	d0
    1d6a:	swap d0
	clrw	d0
    1d6c:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1d6e:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    1d72:	mulu.w 10(sp),d1
	addl	d1, d0
    1d76:	add.l d1,d0
	rts
    1d78:	rts

00001d7a <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    1d7a:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    1d7c:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    1d80:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    1d84:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    1d8a:	bcc.s 1da2 <__udivsi3+0x28>
	movel	d0, d2
    1d8c:	move.l d0,d2
	clrw	d2
    1d8e:	clr.w d2
	swap	d2
    1d90:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    1d92:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    1d94:	move.w d2,d0
	swap	d0
    1d96:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    1d98:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    1d9c:	divu.w d1,d2
	movew	d2, d0
    1d9e:	move.w d2,d0
	jra	6f
    1da0:	bra.s 1dd2 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    1da2:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    1da4:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    1da6:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    1da8:	cmpi.l #65536,d1
	jcc	4b
    1dae:	bcc.s 1da4 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    1db0:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    1db2:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    1db8:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    1dba:	mulu.w d0,d1
	swap	d2
    1dbc:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    1dbe:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    1dc0:	swap d2
	tstw	d2		/* high part 17 bits? */
    1dc2:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    1dc4:	bne.s 1dd0 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    1dc6:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    1dc8:	bcs.s 1dd0 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    1dca:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    1dce:	bls.s 1dd2 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    1dd0:	subq.l #1,d0

6:	movel	sp@+, d2
    1dd2:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1dd4:	rts

00001dd6 <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    1dd6:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    1dd8:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    1dda:	move.l 12(sp),d1
	jpl	1f
    1dde:	bpl.s 1de4 <__divsi3+0xe>
	negl	d1
    1de0:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    1de2:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    1de4:	move.l 8(sp),d0
	jpl	2f
    1de8:	bpl.s 1dee <__divsi3+0x18>
	negl	d0
    1dea:	neg.l d0
	negb	d2
    1dec:	neg.b d2

2:	movel	d1, sp@-
    1dee:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1df0:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    1df2:	bsr.s 1d7a <__udivsi3>
	addql	#8, sp
    1df4:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    1df6:	tst.b d2
	jpl	3f
    1df8:	bpl.s 1dfc <__divsi3+0x26>
	negl	d0
    1dfa:	neg.l d0

3:	movel	sp@+, d2
    1dfc:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1dfe:	rts

00001e00 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1e00:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1e04:	move.l 4(sp),d0
	movel	d1, sp@-
    1e08:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1e0a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    1e0c:	bsr.s 1dd6 <__divsi3>
	addql	#8, sp
    1e0e:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1e10:	move.l 8(sp),d1
	movel	d1, sp@-
    1e14:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1e16:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    1e18:	bsr.w 1d58 <__mulsi3>
	addql	#8, sp
    1e1c:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1e1e:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1e22:	sub.l d0,d1
	movel	d1, d0
    1e24:	move.l d1,d0
	rts
    1e26:	rts

00001e28 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1e28:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1e2c:	move.l 4(sp),d0
	movel	d1, sp@-
    1e30:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1e32:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    1e34:	bsr.w 1d7a <__udivsi3>
	addql	#8, sp
    1e38:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1e3a:	move.l 8(sp),d1
	movel	d1, sp@-
    1e3e:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1e40:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    1e42:	bsr.w 1d58 <__mulsi3>
	addql	#8, sp
    1e46:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1e48:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1e4c:	sub.l d0,d1
	movel	d1, d0
    1e4e:	move.l d1,d0
	rts
    1e50:	rts

00001e52 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    1e52:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    1e54:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    1e58:	jsr -516(a6)
    move.l (sp)+, a6
    1e5c:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    1e5e:	rts

00001e60 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    1e60:	move.b d0,(a3)+
	rts
    1e62:	rts

00001e64 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    1e64:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    1e66:	adda.l a0,a2
	move.l	a2,a3
    1e68:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    1e6a:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    1e6c:	moveq #56,d4
	moveq	#8,d5
    1e6e:	moveq #8,d5
	bra.s	.Lliteral
    1e70:	bra.s 1eda <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    1e72:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    1e74:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    1e76:	dbf d1,1e72 <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    1e7a:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    1e7c:	bcc.s 1e80 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    1e7e:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    1e80:	tst.w d0
    1e82:	bne.s 1e8c <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    1e84:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    1e86:	bls.s 1efe <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    1e88:	move.w (a0)+,d0
    1e8a:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    1e8c:	rol.l #6,d0
	move.w	d0,d1
    1e8e:	move.w d0,d1
	and.w	d4,d1
    1e90:	and.w d4,d1
	eor.w	d1,d0
    1e92:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    1e94:	movem.w (1ef8 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    1e9a:	rol.l d2,d0
	and.w	d0,d3					|scaling
    1e9c:	and.w d0,d3
	eor.w	d3,d0
    1e9e:	eor.w d3,d0
	suba.w	d3,a4
    1ea0:	suba.w d3,a4
	adda.l	a1,a4
    1ea2:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    1ea4:	tst.w d0
    1ea6:	bne.s 1eac <_doynaxdepack_asm+0x48>
    1ea8:	move.w (a0)+,d0
    1eaa:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    1eac:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    1eae:	beq.s 1ec6 <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    1eb0:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    1eb2:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    1eb4:	bpl.s 1ec2 <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    1eb6:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    1eb8:	bpl.s 1ec0 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    1eba:	addx.b d1,d1
	lsl.l	#2,d0
    1ebc:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    1ebe:	bmi.s 1eba <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    1ec0:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    1ec2:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    1ec4:	bcc.s 1ec8 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    1ec6:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    1ec8:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    1eca:	dbf d1,1ec6 <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    1ece:	add.l d0,d0
	bcc.s	.Lmatch
    1ed0:	bcc.s 1e80 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    1ed2:	tst.w d0
    1ed4:	bne.s 1eda <_doynaxdepack_asm+0x76>
    1ed6:	move.w (a0)+,d0
    1ed8:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    1eda:	moveq #0,d1
	add.l	d0,d0
    1edc:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    1ede:	bcc.s 1e7e <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    1ee0:	bpl.s 1ee8 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    1ee2:	addx.b d1,d1
	lsl.l	#2,d0
    1ee4:	lsl.l #2,d0
	bmi.s	.Llgetlen
    1ee6:	bmi.s 1ee2 <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    1ee8:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    1eea:	dbv.s d1,1e72 <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    1eee:	add.l d0,d0
	eor.w	d1,d0		
    1ef0:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    1ef2:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    1ef4:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    1ef6:	bra.s 1eea <_doynaxdepack_asm+0x86>

00001ef8 <doy_table>:
    1ef8:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    1f08:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    1f18:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    1f28:	.............o
