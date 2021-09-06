
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
       4:	move.l #24576,d3
       a:	subi.l #24576,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	beq.s 26 <_start+0x26>
      14:	lea 6000 <colScrollMirror>,a2
      1a:	moveq #0,d2
		__preinit_array_start[i]();
      1c:	movea.l (a2)+,a0
      1e:	jsr (a0)
	for (i = 0; i < count; i++)
      20:	addq.l #1,d2
      22:	cmp.l d3,d2
      24:	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	move.l #24576,d3
      2c:	subi.l #24576,d3
      32:	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	beq.s 48 <_start+0x48>
      36:	lea 6000 <colScrollMirror>,a2
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
      4e:	move.l #24576,d2
      54:	subi.l #24576,d2
      5a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	beq.s 6e <_start+0x6e>
      5e:	lea 6000 <colScrollMirror>,a2
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
      80:	move.l a6,238d2 <SysBase>
	custom = (struct Custom *)0xdff000;
      86:	move.l #14675968,238d8 <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
      90:	lea 45ed <incbin_P61_Player_end+0x1>,a1
      96:	moveq #0,d0
      98:	jsr -552(a6)
      9c:	move.l d0,238ce <GfxBase>
	if (!GfxBase)
      a2:	beq.w 1f40 <main+0x1ecc>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
      a6:	movea.l 238d2 <SysBase>,a6
      ac:	lea 45fe <incbin_P61_Player_end+0x12>,a1
      b2:	moveq #0,d0
      b4:	jsr -552(a6)
      b8:	move.l d0,238ca <DOSBase>
	if (!DOSBase)
      be:	beq.w 1dbc <main+0x1d48>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      c2:	pea 460a <incbin_P61_Player_end+0x1e>
      c8:	lea 280e <KPrintF>,a4
      ce:	jsr (a4)
#endif

	Write(Output(), (APTR) "Hello console!\n", 15);
      d0:	movea.l 238ca <DOSBase>,a6
      d6:	jsr -60(a6)
      da:	movea.l 238ca <DOSBase>,a6
      e0:	move.l d0,d1
      e2:	move.l #17958,d2
      e8:	moveq #15,d3
      ea:	jsr -48(a6)
}

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{

	bmp->Width = w;
      ee:	move.l #20971776,23898 <Screen>
      f8:	move.l #196648,2389c <Screen+0x4>
	bmp->Height = h;
	bmp->Bpls = bpls;
	bmp->Bpl = w / 8;
	bmp->Bplt = w / 8 * bpls;
     102:	move.w #120,238a0 <Screen+0x8>
	bmp->Btot = w / 8 * h * bpls;
     10a:	move.w #30720,238a4 <Screen+0xc>
	bmp->Width = w;
     112:	move.l #16777346,23864 <BmpLogo>
     11c:	move.l #196640,23868 <BmpLogo+0x4>
	bmp->Bplt = w / 8 * bpls;
     126:	move.w #96,2386c <BmpLogo+0x8>
	bmp->Btot = w / 8 * h * bpls;
     12e:	move.w #12480,23870 <BmpLogo+0xc>
	bmp->Width = w;
     136:	move.l #20971650,23830 <BmpUpperPart_PF1>
     140:	move.l #196648,23834 <BmpUpperPart_PF1+0x4>
	bmp->Bplt = w / 8 * bpls;
     14a:	move.w #120,23838 <BmpUpperPart_PF1+0x8>
	bmp->Btot = w / 8 * h * bpls;
     152:	move.w #15600,2383c <BmpUpperPart_PF1+0xc>
	bmp->Width = w;
     15a:	move.l #20971650,237fc <BmpUpperPart_PF2>
     164:	move.l #196648,23800 <BmpUpperPart_PF2+0x4>
	bmp->Bplt = w / 8 * bpls;
     16e:	move.w #120,23804 <BmpUpperPart_PF2+0x8>
	bmp->Btot = w / 8 * h * bpls;
     176:	move.w #15600,23808 <BmpUpperPart_PF2+0xc>
	bmp->Width = w;
     17e:	move.l #20971650,237c8 <BmpUpperPart_Buf1>
     188:	move.l #196648,237cc <BmpUpperPart_Buf1+0x4>
	bmp->Bplt = w / 8 * bpls;
     192:	move.w #120,237d0 <BmpUpperPart_Buf1+0x8>
	bmp->Btot = w / 8 * h * bpls;
     19a:	move.w #15600,237d4 <BmpUpperPart_Buf1+0xc>
	bmp->Width = w;
     1a2:	move.l #23068838,23794 <BmpScroller>
     1ac:	move.l #196652,23798 <BmpScroller+0x4>
	bmp->Bplt = w / 8 * bpls;
     1b6:	move.w #132,2379c <BmpScroller+0x8>
	bmp->Btot = w / 8 * h * bpls;
     1be:	move.w #21912,237a0 <BmpScroller+0xc>
	bmp->Width = w;
     1c6:	move.l #20971776,23760 <BmpFont32>
     1d0:	move.l #196648,23764 <BmpFont32+0x4>
	bmp->Bplt = w / 8 * bpls;
     1da:	move.w #120,23768 <BmpFont32+0x8>
	bmp->Btot = w / 8 * h * bpls;
     1e2:	move.w #30720,2376c <BmpFont32+0xc>
	bmp->Width = w;
     1ea:	move.l #20971776,2372c <BmpCookie>
     1f4:	move.l #196648,23730 <BmpCookie+0x4>
	bmp->Bplt = w / 8 * bpls;
     1fe:	move.w #120,23734 <BmpCookie+0x8>
	bmp->Btot = w / 8 * h * bpls;
     206:	move.w #30720,23738 <BmpCookie+0xc>
	bmp->Width = w;
     20e:	move.l #20971776,236f8 <BmpCookieMask>
     218:	move.l #196648,236fc <BmpCookieMask+0x4>
	bmp->Bplt = w / 8 * bpls;
     222:	move.w #120,23700 <BmpCookieMask+0x8>
	bmp->Btot = w / 8 * h * bpls;
     22a:	move.w #30720,23704 <BmpCookieMask+0xc>
	copPtr = AllocMem(1024, MEMF_CHIP);
     232:	movea.l 238d2 <SysBase>,a6
     238:	move.l #1024,d0
     23e:	moveq #2,d1
     240:	jsr -198(a6)
     244:	move.l d0,236f4 <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
     24a:	movea.l 238d2 <SysBase>,a6
     250:	moveq #0,d0
     252:	move.w 237a0 <BmpScroller+0xc>,d0
     258:	move.l #65538,d1
     25e:	jsr -198(a6)
     262:	move.l d0,237a2 <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
     268:	movea.l 238d2 <SysBase>,a6
     26e:	moveq #0,d0
     270:	move.w 2383c <BmpUpperPart_PF1+0xc>,d0
     276:	move.l #65538,d1
     27c:	jsr -198(a6)
     280:	move.l d0,2383e <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
     286:	movea.l 238d2 <SysBase>,a6
     28c:	moveq #0,d0
     28e:	move.w 23808 <BmpUpperPart_PF2+0xc>,d0
     294:	move.l #65538,d1
     29a:	jsr -198(a6)
     29e:	move.l d0,2380a <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
     2a4:	movea.l 238d2 <SysBase>,a6
     2aa:	moveq #0,d0
     2ac:	move.w 237d4 <BmpUpperPart_Buf1+0xc>,d0
     2b2:	move.l #65538,d1
     2b8:	jsr -198(a6)
     2bc:	move.l d0,237d6 <BmpUpperPart_Buf1+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
     2c2:	move.l #24584,23872 <BmpLogo+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
     2cc:	move.l #37066,2376e <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
     2d6:	move.l #67788,2373a <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
     2e0:	move.l #98510,23706 <BmpCookieMask+0xe>
	for (int p = 0; p < img->Bpls; p++)
     2ea:	moveq #0,d2
     2ec:	move.w 23834 <BmpUpperPart_PF1+0x4>,d2
     2f2:	addq.l #4,sp
     2f4:	tst.l d2
     2f6:	beq.w 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2fa:	movea.l 2383e <BmpUpperPart_PF1+0xe>,a0
     300:	moveq #0,d3
     302:	move.w 23836 <BmpUpperPart_PF1+0x6>,d3
     308:	move.l a0,23842 <BmpUpperPart_PF1+0x12>
	for (int p = 0; p < img->Bpls; p++)
     30e:	moveq #1,d1
     310:	cmp.l d2,d1
     312:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     314:	lea (0,a0,d3.l),a1
     318:	move.l a1,23846 <BmpUpperPart_PF1+0x16>
	for (int p = 0; p < img->Bpls; p++)
     31e:	moveq #2,d1
     320:	cmp.l d2,d1
     322:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     324:	move.l d3,d1
     326:	add.l d3,d1
     328:	lea (0,a0,d1.l),a1
     32c:	move.l a1,2384a <BmpUpperPart_PF1+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     332:	moveq #3,d4
     334:	cmp.l d2,d4
     336:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     338:	add.l d3,d1
     33a:	lea (0,a0,d1.l),a1
     33e:	move.l a1,2384e <BmpUpperPart_PF1+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     344:	moveq #4,d4
     346:	cmp.l d2,d4
     348:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     34a:	add.l d3,d1
     34c:	lea (0,a0,d1.l),a1
     350:	move.l a1,23852 <BmpUpperPart_PF1+0x22>
	for (int p = 0; p < img->Bpls; p++)
     356:	moveq #5,d4
     358:	cmp.l d2,d4
     35a:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     35c:	add.l d3,d1
     35e:	lea (0,a0,d1.l),a1
     362:	move.l a1,23856 <BmpUpperPart_PF1+0x26>
	for (int p = 0; p < img->Bpls; p++)
     368:	moveq #6,d4
     36a:	cmp.l d2,d4
     36c:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     36e:	add.l d3,d1
     370:	lea (0,a0,d1.l),a1
     374:	move.l a1,2385a <BmpUpperPart_PF1+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     37a:	subq.l #7,d2
     37c:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     37e:	add.l d3,d1
     380:	add.l a0,d1
     382:	move.l d1,2385e <BmpUpperPart_PF1+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     388:	moveq #0,d2
     38a:	move.w 23800 <BmpUpperPart_PF2+0x4>,d2
     390:	tst.l d2
     392:	beq.w 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     396:	movea.l 2380a <BmpUpperPart_PF2+0xe>,a0
     39c:	moveq #0,d3
     39e:	move.w 23802 <BmpUpperPart_PF2+0x6>,d3
     3a4:	move.l a0,2380e <BmpUpperPart_PF2+0x12>
	for (int p = 0; p < img->Bpls; p++)
     3aa:	moveq #1,d6
     3ac:	cmp.l d2,d6
     3ae:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3b0:	lea (0,a0,d3.l),a1
     3b4:	move.l a1,23812 <BmpUpperPart_PF2+0x16>
	for (int p = 0; p < img->Bpls; p++)
     3ba:	moveq #2,d1
     3bc:	cmp.l d2,d1
     3be:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3c0:	move.l d3,d1
     3c2:	add.l d3,d1
     3c4:	lea (0,a0,d1.l),a1
     3c8:	move.l a1,23816 <BmpUpperPart_PF2+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     3ce:	moveq #3,d4
     3d0:	cmp.l d2,d4
     3d2:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3d4:	add.l d3,d1
     3d6:	lea (0,a0,d1.l),a1
     3da:	move.l a1,2381a <BmpUpperPart_PF2+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     3e0:	moveq #4,d4
     3e2:	cmp.l d2,d4
     3e4:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3e6:	add.l d3,d1
     3e8:	lea (0,a0,d1.l),a1
     3ec:	move.l a1,2381e <BmpUpperPart_PF2+0x22>
	for (int p = 0; p < img->Bpls; p++)
     3f2:	moveq #5,d4
     3f4:	cmp.l d2,d4
     3f6:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3f8:	add.l d3,d1
     3fa:	lea (0,a0,d1.l),a1
     3fe:	move.l a1,23822 <BmpUpperPart_PF2+0x26>
	for (int p = 0; p < img->Bpls; p++)
     404:	moveq #6,d4
     406:	cmp.l d2,d4
     408:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     40a:	add.l d3,d1
     40c:	lea (0,a0,d1.l),a1
     410:	move.l a1,23826 <BmpUpperPart_PF2+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     416:	subq.l #7,d2
     418:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     41a:	add.l d3,d1
     41c:	add.l a0,d1
     41e:	move.l d1,2382a <BmpUpperPart_PF2+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     424:	moveq #0,d2
     426:	move.w 237cc <BmpUpperPart_Buf1+0x4>,d2
     42c:	tst.l d2
     42e:	beq.w 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     432:	moveq #0,d3
     434:	move.w 237ce <BmpUpperPart_Buf1+0x6>,d3
     43a:	move.l d0,237da <BmpUpperPart_Buf1+0x12>
	for (int p = 0; p < img->Bpls; p++)
     440:	moveq #1,d6
     442:	cmp.l d2,d6
     444:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     446:	move.l d0,d1
     448:	add.l d3,d1
     44a:	move.l d1,237de <BmpUpperPart_Buf1+0x16>
	for (int p = 0; p < img->Bpls; p++)
     450:	moveq #2,d4
     452:	cmp.l d2,d4
     454:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     456:	move.l d3,d1
     458:	add.l d3,d1
     45a:	move.l d0,d6
     45c:	add.l d1,d6
     45e:	move.l d6,237e2 <BmpUpperPart_Buf1+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     464:	moveq #3,d4
     466:	cmp.l d2,d4
     468:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     46a:	add.l d3,d1
     46c:	move.l d0,d6
     46e:	add.l d1,d6
     470:	move.l d6,237e6 <BmpUpperPart_Buf1+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     476:	moveq #4,d4
     478:	cmp.l d2,d4
     47a:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     47c:	add.l d3,d1
     47e:	move.l d0,d6
     480:	add.l d1,d6
     482:	move.l d6,237ea <BmpUpperPart_Buf1+0x22>
	for (int p = 0; p < img->Bpls; p++)
     488:	moveq #5,d4
     48a:	cmp.l d2,d4
     48c:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     48e:	add.l d3,d1
     490:	move.l d0,d6
     492:	add.l d1,d6
     494:	move.l d6,237ee <BmpUpperPart_Buf1+0x26>
	for (int p = 0; p < img->Bpls; p++)
     49a:	moveq #6,d4
     49c:	cmp.l d2,d4
     49e:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4a0:	add.l d3,d1
     4a2:	move.l d0,d6
     4a4:	add.l d1,d6
     4a6:	move.l d6,237f2 <BmpUpperPart_Buf1+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     4ac:	subq.l #7,d2
     4ae:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4b0:	add.l d3,d1
     4b2:	add.l d1,d0
     4b4:	move.l d0,237f6 <BmpUpperPart_Buf1+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     4ba:	moveq #0,d1
     4bc:	move.w 23798 <BmpScroller+0x4>,d1
     4c2:	tst.l d1
     4c4:	beq.w 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4c8:	movea.l 237a2 <BmpScroller+0xe>,a0
     4ce:	moveq #0,d2
     4d0:	move.w 2379a <BmpScroller+0x6>,d2
     4d6:	move.l a0,237a6 <BmpScroller+0x12>
	for (int p = 0; p < img->Bpls; p++)
     4dc:	moveq #1,d6
     4de:	cmp.l d1,d6
     4e0:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4e2:	lea (0,a0,d2.l),a1
     4e6:	move.l a1,237aa <BmpScroller+0x16>
	for (int p = 0; p < img->Bpls; p++)
     4ec:	moveq #2,d0
     4ee:	cmp.l d1,d0
     4f0:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4f2:	move.l d2,d0
     4f4:	add.l d2,d0
     4f6:	lea (0,a0,d0.l),a1
     4fa:	move.l a1,237ae <BmpScroller+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     500:	moveq #3,d3
     502:	cmp.l d1,d3
     504:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     506:	add.l d2,d0
     508:	lea (0,a0,d0.l),a1
     50c:	move.l a1,237b2 <BmpScroller+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     512:	moveq #4,d3
     514:	cmp.l d1,d3
     516:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     518:	add.l d2,d0
     51a:	lea (0,a0,d0.l),a1
     51e:	move.l a1,237b6 <BmpScroller+0x22>
	for (int p = 0; p < img->Bpls; p++)
     524:	moveq #5,d3
     526:	cmp.l d1,d3
     528:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     52a:	add.l d2,d0
     52c:	lea (0,a0,d0.l),a1
     530:	move.l a1,237ba <BmpScroller+0x26>
	for (int p = 0; p < img->Bpls; p++)
     536:	moveq #6,d3
     538:	cmp.l d1,d3
     53a:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     53c:	add.l d2,d0
     53e:	lea (0,a0,d0.l),a1
     542:	move.l a1,237be <BmpScroller+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     548:	subq.l #7,d1
     54a:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     54c:	add.l d2,d0
     54e:	add.l a0,d0
     550:	move.l d0,237c2 <BmpScroller+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     556:	moveq #0,d1
     558:	move.w 23764 <BmpFont32+0x4>,d1
     55e:	tst.l d1
     560:	beq.w 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     564:	moveq #0,d2
     566:	move.w 23766 <BmpFont32+0x6>,d2
     56c:	move.l #37066,23772 <BmpFont32+0x12>
	for (int p = 0; p < img->Bpls; p++)
     576:	moveq #1,d4
     578:	cmp.l d1,d4
     57a:	beq.w 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     57e:	move.l d2,d6
     580:	addi.l #37066,d6
     586:	move.l d6,23776 <BmpFont32+0x16>
	for (int p = 0; p < img->Bpls; p++)
     58c:	moveq #2,d0
     58e:	cmp.l d1,d0
     590:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     592:	move.l d2,d0
     594:	add.l d2,d0
     596:	move.l d0,d3
     598:	addi.l #37066,d3
     59e:	move.l d3,2377a <BmpFont32+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     5a4:	moveq #3,d4
     5a6:	cmp.l d1,d4
     5a8:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5aa:	add.l d2,d0
     5ac:	move.l d0,d6
     5ae:	addi.l #37066,d6
     5b4:	move.l d6,2377e <BmpFont32+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     5ba:	moveq #4,d3
     5bc:	cmp.l d1,d3
     5be:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5c0:	add.l d2,d0
     5c2:	move.l d0,d4
     5c4:	addi.l #37066,d4
     5ca:	move.l d4,23782 <BmpFont32+0x22>
	for (int p = 0; p < img->Bpls; p++)
     5d0:	moveq #5,d6
     5d2:	cmp.l d1,d6
     5d4:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5d6:	add.l d2,d0
     5d8:	move.l d0,d3
     5da:	addi.l #37066,d3
     5e0:	move.l d3,23786 <BmpFont32+0x26>
	for (int p = 0; p < img->Bpls; p++)
     5e6:	moveq #6,d4
     5e8:	cmp.l d1,d4
     5ea:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5ec:	add.l d2,d0
     5ee:	move.l d0,d6
     5f0:	addi.l #37066,d6
     5f6:	move.l d6,2378a <BmpFont32+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     5fc:	subq.l #7,d1
     5fe:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     600:	add.l d2,d0
     602:	addi.l #37066,d0
     608:	move.l d0,2378e <BmpFont32+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     60e:	moveq #0,d1
     610:	move.w 23730 <BmpCookie+0x4>,d1
     616:	tst.l d1
     618:	beq.w 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     61c:	moveq #0,d2
     61e:	move.w 23732 <BmpCookie+0x6>,d2
     624:	move.l #67788,2373e <BmpCookie+0x12>
	for (int p = 0; p < img->Bpls; p++)
     62e:	moveq #1,d4
     630:	cmp.l d1,d4
     632:	beq.w 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     636:	move.l d2,d6
     638:	addi.l #67788,d6
     63e:	move.l d6,23742 <BmpCookie+0x16>
	for (int p = 0; p < img->Bpls; p++)
     644:	moveq #2,d0
     646:	cmp.l d1,d0
     648:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     64a:	move.l d2,d0
     64c:	add.l d2,d0
     64e:	move.l d0,d3
     650:	addi.l #67788,d3
     656:	move.l d3,23746 <BmpCookie+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     65c:	moveq #3,d4
     65e:	cmp.l d1,d4
     660:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     662:	add.l d2,d0
     664:	move.l d0,d6
     666:	addi.l #67788,d6
     66c:	move.l d6,2374a <BmpCookie+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     672:	moveq #4,d3
     674:	cmp.l d1,d3
     676:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     678:	add.l d2,d0
     67a:	move.l d0,d4
     67c:	addi.l #67788,d4
     682:	move.l d4,2374e <BmpCookie+0x22>
	for (int p = 0; p < img->Bpls; p++)
     688:	moveq #5,d6
     68a:	cmp.l d1,d6
     68c:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     68e:	add.l d2,d0
     690:	move.l d0,d3
     692:	addi.l #67788,d3
     698:	move.l d3,23752 <BmpCookie+0x26>
	for (int p = 0; p < img->Bpls; p++)
     69e:	moveq #6,d4
     6a0:	cmp.l d1,d4
     6a2:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6a4:	add.l d2,d0
     6a6:	move.l d0,d6
     6a8:	addi.l #67788,d6
     6ae:	move.l d6,23756 <BmpCookie+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     6b4:	subq.l #7,d1
     6b6:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6b8:	add.l d2,d0
     6ba:	addi.l #67788,d0
     6c0:	move.l d0,2375a <BmpCookie+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     6c6:	moveq #0,d1
     6c8:	move.w 236fc <BmpCookieMask+0x4>,d1
     6ce:	tst.l d1
     6d0:	beq.w 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6d4:	moveq #0,d2
     6d6:	move.w 236fe <BmpCookieMask+0x6>,d2
     6dc:	move.l #98510,2370a <BmpCookieMask+0x12>
	for (int p = 0; p < img->Bpls; p++)
     6e6:	moveq #1,d4
     6e8:	cmp.l d1,d4
     6ea:	beq.w 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6ee:	move.l d2,d6
     6f0:	addi.l #98510,d6
     6f6:	move.l d6,2370e <BmpCookieMask+0x16>
	for (int p = 0; p < img->Bpls; p++)
     6fc:	moveq #2,d0
     6fe:	cmp.l d1,d0
     700:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     702:	move.l d2,d0
     704:	add.l d2,d0
     706:	move.l d0,d3
     708:	addi.l #98510,d3
     70e:	move.l d3,23712 <BmpCookieMask+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     714:	moveq #3,d4
     716:	cmp.l d1,d4
     718:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     71a:	add.l d2,d0
     71c:	move.l d0,d6
     71e:	addi.l #98510,d6
     724:	move.l d6,23716 <BmpCookieMask+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     72a:	moveq #4,d3
     72c:	cmp.l d1,d3
     72e:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     730:	add.l d2,d0
     732:	move.l d0,d4
     734:	addi.l #98510,d4
     73a:	move.l d4,2371a <BmpCookieMask+0x22>
	for (int p = 0; p < img->Bpls; p++)
     740:	moveq #5,d6
     742:	cmp.l d1,d6
     744:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     746:	add.l d2,d0
     748:	move.l d0,d3
     74a:	addi.l #98510,d3
     750:	move.l d3,2371e <BmpCookieMask+0x26>
	for (int p = 0; p < img->Bpls; p++)
     756:	moveq #6,d4
     758:	cmp.l d1,d4
     75a:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     75c:	add.l d2,d0
     75e:	move.l d0,d6
     760:	addi.l #98510,d6
     766:	move.l d6,23722 <BmpCookieMask+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     76c:	subq.l #7,d1
     76e:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     770:	add.l d2,d0
     772:	addi.l #98510,d0
     778:	move.l d0,23726 <BmpCookieMask+0x2e>
	ActiView = GfxBase->ActiView; //store current view
     77e:	movea.l 238ce <GfxBase>,a6
     784:	move.l 34(a6),236e2 <ActiView>
	OwnBlitter();
     78c:	jsr -456(a6)
	WaitBlit();
     790:	movea.l 238ce <GfxBase>,a6
     796:	jsr -228(a6)
	Disable();
     79a:	movea.l 238d2 <SysBase>,a6
     7a0:	jsr -120(a6)
	SystemADKCON = custom->adkconr;
     7a4:	movea.l 238d8 <custom>,a2
     7aa:	move.w 16(a2),d0
     7ae:	move.w d0,236e6 <SystemADKCON>
	SystemInts = custom->intenar;
     7b4:	move.w 28(a2),d0
     7b8:	move.w d0,236ea <SystemInts>
	SystemDMA = custom->dmaconr;
     7be:	move.w 2(a2),d0
     7c2:	move.w d0,236e8 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     7c8:	move.w #32767,154(a2)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     7ce:	move.w #32767,156(a2)
	WaitVbl();
     7d4:	jsr 2116 <WaitVbl>
	WaitVbl();
     7da:	jsr 2116 <WaitVbl>
	custom->dmacon = 0x7fff; //Clear all DMA channels
     7e0:	move.w #32767,150(a2)
	for (int a = 0; a < 32; a++)
     7e6:	moveq #0,d1
		custom->color[a] = 0;
     7e8:	move.l d1,d0
     7ea:	addi.l #192,d0
     7f0:	add.l d0,d0
     7f2:	move.w #0,(0,a2,d0.l)
	for (int a = 0; a < 32; a++)
     7f8:	addq.l #1,d1
     7fa:	moveq #32,d4
     7fc:	cmp.l d1,d4
     7fe:	bne.s 7e8 <main+0x774>
	LoadView(0);
     800:	movea.l 238ce <GfxBase>,a6
     806:	suba.l a1,a1
     808:	jsr -222(a6)
	WaitTOF();
     80c:	movea.l 238ce <GfxBase>,a6
     812:	jsr -270(a6)
	WaitTOF();
     816:	movea.l 238ce <GfxBase>,a6
     81c:	jsr -270(a6)
	WaitVbl();
     820:	jsr 2116 <WaitVbl>
	WaitVbl();
     826:	jsr 2116 <WaitVbl>
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     82c:	move.w #20090,168(sp)
     832:	move.w #2049,170(sp)
     838:	move.w #20083,172(sp)
	if (SysBase->AttnFlags & AFF_68010)
     83e:	movea.l 238d2 <SysBase>,a6
     844:	btst #0,297(a6)
     84a:	beq.w 1fe2 <main+0x1f6e>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     84e:	move.l sp,d7
     850:	addi.l #168,d7
     856:	exg d7,a5
     858:	jsr -30(a6)
     85c:	exg d7,a5
	VBR = GetVBR();
     85e:	move.l d0,236f0 <VBR>
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     864:	movea.l 236f0 <VBR>,a0
     86a:	move.l 108(a0),d0
	SystemIrq = GetInterruptHandler(); //store interrupt register
     86e:	move.l d0,236ec <SystemIrq>
	WaitVbl();
     874:	jsr 2116 <WaitVbl>
	SetupCopper(copPtr);
     87a:	move.l 236f4 <copPtr>,d2
     880:	move.l d2,-(sp)
     882:	jsr 215c <SetupCopper>
	custom->cop1lc = (ULONG)copPtr;
     888:	movea.l 238d8 <custom>,a0
     88e:	move.l d2,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
     892:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
     898:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
     89e:	move.w #-30752,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     8a4:	movea.l 236f0 <VBR>,a1
     8aa:	move.l #8404,108(a1)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
     8b2:	move.w #-16352,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
     8b8:	move.w #32,156(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
     8be:	move.w #-24576,154(a0)
	register volatile const void *_a0 ASM("a0") = module;
     8c4:	lea 1f8d0 <incbin_module_start>,a0
	register volatile const void *_a1 ASM("a1") = NULL;
     8ca:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
     8cc:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
     8ce:	lea 2c86 <incbin_P61_Player_start>,a3
	__asm volatile(
     8d4:	movem.l d1-d7/a4-a6,-(sp)
     8d8:	jsr (a3)
     8da:	movem.l (sp)+,d1-d7/a4-a6
	if (p61Init(module) != 0)
     8de:	addq.l #4,sp
     8e0:	tst.l d0
     8e2:	bne.w 1cee <main+0x1c7a>
	APTR vbr = 0;
     8e6:	lea 233e0 <StarSprite>,a2
     8ec:	moveq #0,d3
     8ee:	moveq #44,d4
     8f0:	moveq #3,d2
     8f2:	lea 2b50 <__modsi3>,a3
	USHORT hpos = 3;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 93; l++)
	{
		hpos = (7 * hpos) % 255;
     8f8:	andi.l #65535,d2
     8fe:	move.l d2,d1
     900:	lsl.l #3,d1
     902:	pea ff <main+0x8b>
     906:	sub.l d2,d1
     908:	move.l d1,-(sp)
     90a:	jsr (a3)
     90c:	addq.l #8,sp
     90e:	move.w d0,d2

		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
     910:	move.w d4,d1
     912:	lsl.w #8,d1
     914:	or.w d0,d1
     916:	move.w d1,(a2)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
     918:	move.w d4,d0
     91a:	lsl.w #8,d0
     91c:	addi.w #256,d0
     920:	move.w d0,2(a2)

		switch (l % 3)
     924:	pea 3 <_start+0x3>
     928:	move.l d3,-(sp)
     92a:	jsr (a3)
     92c:	addq.l #8,sp
     92e:	moveq #1,d6
     930:	cmp.l d0,d6
     932:	beq.w 1898 <main+0x1824>
     936:	moveq #2,d1
		{
		case 0:
			StarSprite[line++] = 0x8000; //color-1
     938:	move.w #-32768,4(a2)
		switch (l % 3)
     93e:	cmp.l d0,d1
     940:	beq.w 1880 <main+0x180c>
			StarSprite[line++] = 0x0000; //color-1
     944:	clr.w 6(a2)
			StarSprite[line++] = 0x8000; //color-3
			StarSprite[line++] = 0x8000; //color-3
			break;
		}

		vpos += 2;
     948:	addq.b #2,d4
	for (int l = 0; l < 93; l++)
     94a:	addq.l #1,d3
     94c:	addq.l #8,a2
     94e:	cmpi.b #-26,d4
     952:	bne.s 8f8 <main+0x884>
	}
	StarSprite[line++] = 0;
     954:	clr.w 236c8 <StarSprite+0x2e8>
	StarSprite[line++] = 0;
     95a:	clr.w 236ca <StarSprite+0x2ea>
	short incX[6] = {3, 3, 3, 3, 3, 3};
     960:	move.w #3,164(sp)
	short incY[6] = {1, 1, 1, 1, 1, 1};
     966:	move.w #1,176(sp)
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
     96c:	move.w 23868 <BmpLogo+0x4>,d2
     972:	movea.w 2386a <BmpLogo+0x6>,a1
     978:	move.l 23872 <BmpLogo+0xe>,d3
     97e:	movea.w 23836 <BmpUpperPart_PF1+0x6>,a0
     984:	move.l 2383e <BmpUpperPart_PF1+0xe>,d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     98a:	movea.l 238d8 <custom>,a5
     990:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     994:	move.w 2(a5),d0
     998:	btst #14,d0
     99c:	bne.s 994 <main+0x920>
	custom->bltcon0 = 0x09f0;
     99e:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
     9a4:	move.w #0,66(a5)
	custom->bltafwm = 0xffff;
     9aa:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
     9b0:	move.w #-1,70(a5)
	custom->bltamod = imgA.Bpl - (width / 8);
     9b6:	lea -32(a1),a1
     9ba:	move.w a1,100(a5)
	custom->bltdmod = imgD.Bpl - (width / 8);
     9be:	lea -32(a0),a0
     9c2:	move.w a0,102(a5)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
     9c6:	move.l d3,80(a5)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
     9ca:	addq.l #4,d1
     9cc:	move.l d1,84(a5)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
     9d0:	move.w d2,d0
     9d2:	lsl.w #6,d0
     9d4:	add.w d2,d0
     9d6:	lsl.w #7,d0
     9d8:	addi.w #16,d0
     9dc:	move.w d0,88(a5)
void SetInterruptHandler(APTR interrupt);
void WaitVbl(void);
inline void WaitBlt();
void TakeSystem(void);
void FreeSystem(void);
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
     9e0:	move.b bfe001 <_end+0xbda725>,d0
	while (!MouseLeft())
     9e6:	btst #6,d0
     9ea:	beq.w 12a6 <main+0x1232>
     9ee:	move.w 237cc <BmpUpperPart_Buf1+0x4>,110(sp)
     9f6:	move.w 237ce <BmpUpperPart_Buf1+0x6>,54(sp)
     9fe:	move.l 237d6 <BmpUpperPart_Buf1+0xe>,56(sp)
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
     a06:	move.w 236da <ScrollerY>,80(sp)
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
     a0e:	move.l 237a2 <BmpScroller+0xe>,126(sp)
     a16:	move.w 23798 <BmpScroller+0x4>,130(sp)
	short incY[6] = {1, 1, 1, 1, 1, 1};
     a1e:	move.w #1,98(sp)
     a24:	move.w #1,100(sp)
     a2a:	move.w #1,106(sp)
     a30:	move.w #1,108(sp)
	short incX[6] = {3, 3, 3, 3, 3, 3};
     a36:	move.w #3,104(sp)
     a3c:	move.w #3,102(sp)
     a42:	move.w #3,94(sp)
     a48:	move.w #3,96(sp)
	Point2D pdb[6] = {
     a4e:	movea.w #78,a2
     a52:	move.l a2,68(sp)
     a56:	clr.l 60(sp)
     a5a:	movea.w #82,a2
     a5e:	move.l a2,64(sp)
     a62:	moveq #28,d3
     a64:	move.l d3,46(sp)
     a68:	movea.w #86,a2
     a6c:	move.l a2,72(sp)
     a70:	moveq #56,d3
     a72:	move.l d3,50(sp)
     a76:	movea.w #90,a2
     a7a:	move.l a2,76(sp)
     a7e:	moveq #84,d7
     a80:	lea 236c9 <StarSprite+0x2e9>,a4
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     a86:	move.l dff004 <_end+0xddb728>,d0
     a8c:	move.l d0,152(sp)
		vpos &= 0x1ff00;
     a90:	move.l 152(sp),d0
     a94:	andi.l #130816,d0
     a9a:	move.l d0,152(sp)
		if (vpos != (311 << 8))
     a9e:	move.l 152(sp),d0
     aa2:	cmpi.l #79616,d0
     aa8:	beq.s a86 <main+0xa12>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     aaa:	move.l dff004 <_end+0xddb728>,d0
     ab0:	move.l d0,148(sp)
		vpos &= 0x1ff00;
     ab4:	move.l 148(sp),d0
     ab8:	andi.l #130816,d0
     abe:	move.l d0,148(sp)
		if (vpos == (311 << 8))
     ac2:	move.l 148(sp),d0
     ac6:	cmpi.l #79616,d0
     acc:	bne.s aaa <main+0xa36>
		if (ResetCopper)
     ace:	tst.w 236e0 <ResetCopper>
     ad4:	bne.w 1418 <main+0x13a4>
		if (ScrollerPause > 0)
     ad8:	move.w 236de <ScrollerPause>,d3
     ade:	beq.s ae8 <main+0xa74>
			ScrollerPause--;
     ae0:	subq.w #1,d3
     ae2:	move.w d3,236de <ScrollerPause>
		CopyBitmap(BmpUpperPart_Buf1, BmpUpperPart_PF2);
     ae8:	move.w 237ca <BmpUpperPart_Buf1+0x2>,d1
     aee:	movea.l 2380a <BmpUpperPart_PF2+0xe>,a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     af4:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     af8:	move.w 2(a5),d0
     afc:	move.w d0,d2
     afe:	andi.w #16384,d2
     b02:	btst #14,d0
     b06:	bne.s af8 <main+0xa84>
	custom->bltcon0 = 0x09f0;
     b08:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
     b0e:	move.w #0,66(a5)
	custom->bltapt = (UBYTE *)bmpS.ImageData;
     b14:	move.l 56(sp),80(a5)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
     b1a:	move.l a0,84(a5)
	custom->bltafwm = 0xffff;
     b1e:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
     b24:	move.w #-1,70(a5)
	custom->bltamod = 0;
     b2a:	move.w #0,100(a5)
	custom->bltdmod = 0;
     b30:	move.w #0,102(a5)
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
     b36:	move.w 110(sp),d0
     b3a:	muls.w d1,d0
     b3c:	lsl.w #6,d0
     b3e:	move.w 54(sp),d1
     b42:	lsr.w #1,d1
     b44:	add.w d1,d0
     b46:	move.w d0,88(a5)
		if (BounceEnabled)
     b4a:	tst.w 236dc <BounceEnabled>
     b50:	beq.s b90 <main+0xb1c>
			if (ScrollerDir > 0)
     b52:	move.b 6006 <ScrollerDir>,d0
     b58:	ble.w 1b60 <main+0x1aec>
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
     b5c:	pea c <_start+0xc>
     b60:	movea.w #40,a0
     b64:	suba.w 84(sp),a0
     b68:	move.l a0,-(sp)
     b6a:	jsr 2b26 <__divsi3>
     b70:	addq.l #8,sp
				if (ScrollerDir > 6)
     b72:	cmpi.b #6,d0
     b76:	ble.w 1b82 <main+0x1b0e>
					ScrollerDir = 6;
     b7a:	move.b #6,6006 <ScrollerDir>
     b82:	moveq #6,d0
			ScrollerY += ScrollerDir;
     b84:	add.w d0,80(sp)
     b88:	move.w 80(sp),236da <ScrollerY>
		if (ScrollerY >= ScrollerMax)
     b90:	movea.w 80(sp),a0
     b94:	cmpi.w #39,80(sp)
     b9a:	ble.w 1b3a <main+0x1ac6>
			ScrollerY = ScrollerMax;
     b9e:	move.w #40,236da <ScrollerY>
			ScrollerDir = -1;
     ba6:	st 6006 <ScrollerDir>
     bac:	movea.w #40,a0
     bb0:	move.w #40,80(sp)
		if (ScrollerPause < 1)
     bb6:	tst.w d3
     bb8:	beq.w 15e6 <main+0x1572>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
     bbc:	moveq #0,d4
     bbe:	move.w 130(sp),d4
     bc2:	movea.l 236d6 <copScrollerBmpP>,a2
     bc8:	moveq #0,d5
     bca:	move.w 2379a <BmpScroller+0x6>,d5
    }
    return copListEnd;
}
inline USHORT *copSetPlanesInterleafed(UBYTE bplPtrStart, USHORT *copListEnd, const UBYTE *bitmap, int numPlanes, int Bpl, int offsY)
{
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     bd0:	move.l a0,-(sp)
     bd2:	move.l d5,-(sp)
     bd4:	jsr 2aa8 <__mulsi3>
     bda:	addq.l #4,sp
     bdc:	move.l d4,(sp)
     bde:	move.l d0,-(sp)
     be0:	jsr 2aa8 <__mulsi3>
     be6:	addq.l #8,sp
     be8:	add.l 126(sp),d0
    {
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
        *copListEnd++ = (UWORD)addr; // high-word of adress
        addr += Bpl;
     bec:	move.w #224,d1
    for (USHORT i = 0; i < numPlanes; i++)
     bf0:	tst.l d4
     bf2:	beq.s c1c <main+0xba8>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     bf4:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     bf6:	move.l d0,d3
     bf8:	clr.w d3
     bfa:	swap d3
     bfc:	move.w d3,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     c00:	movea.w d1,a0
     c02:	addq.w #2,a0
     c04:	move.w a0,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     c08:	addq.l #8,a2
     c0a:	move.w d0,-2(a2)
        addr += Bpl;
     c0e:	add.l d5,d0
    for (USHORT i = 0; i < numPlanes; i++)
     c10:	addq.w #1,d2
     c12:	addq.w #4,d1
     c14:	moveq #0,d3
     c16:	move.w d2,d3
     c18:	cmp.l d4,d3
     c1a:	blt.s bf4 <main+0xb80>
		ClearBitmapPart(BmpUpperPart_Buf1, pdb[0].X, pdb[0].Y, 32, 32);
     c1c:	movea.w 237d0 <BmpUpperPart_Buf1+0x8>,a2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     c22:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     c26:	move.w 2(a5),d0
     c2a:	btst #14,d0
     c2e:	bne.s c26 <main+0xbb2>
	BYTE shift = x % 16;
     c30:	move.l d7,d4
     c32:	andi.l #-2147483633,d4
     c38:	tst.l d7
     c3a:	blt.w 14ce <main+0x145a>
     c3e:	moveq #15,d5
     c40:	and.l d7,d5
	if (shift)
     c42:	beq.w 14de <main+0x146a>
     c46:	moveq #3,d2
     c48:	moveq #-6,d3
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
     c4a:	move.l d4,d0
     c4c:	moveq #12,d1
     c4e:	lsl.l d1,d0
     c50:	ori.w #2304,d0
     c54:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
     c58:	move.w d4,d0
     c5a:	moveq #12,d6
     c5c:	lsl.w d6,d0
     c5e:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     c62:	moveq #0,d6
     c64:	move.w a2,d6
     c66:	move.l 76(sp),-(sp)
     c6a:	move.l d6,-(sp)
     c6c:	jsr 2aa8 <__mulsi3>
     c72:	addq.l #8,sp
     c74:	move.l d7,d1
     c76:	bmi.w 1488 <main+0x1414>
     c7a:	asr.l #3,d1
     c7c:	add.l d1,d0
     c7e:	add.l 56(sp),d0
     c82:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     c86:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
     c8a:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     c90:	tst.l d5
     c92:	beq.w 14a6 <main+0x1432>
     c96:	moveq #15,d1
     c98:	sub.l d4,d1
     c9a:	moveq #0,d0
     c9c:	not.w d0
     c9e:	asr.l d1,d0
     ca0:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl - (width / 8);
     ca4:	add.w 54(sp),d3
     ca8:	move.w d3,100(a5)
	custom->bltdmod = bmp.Bpl - (width / 8);
     cac:	move.w d3,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     cb0:	move.w 110(sp),d3
     cb4:	moveq #11,d0
     cb6:	lsl.w d0,d3
     cb8:	add.w d3,d2
     cba:	move.w d2,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     cbe:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     cc2:	move.w 2(a5),d0
     cc6:	btst #14,d0
     cca:	bne.s cc2 <main+0xc4e>
	BYTE shift = x % 16;
     ccc:	move.l 50(sp),d5
     cd0:	andi.l #-2147483633,d5
     cd6:	tst.l 50(sp)
     cda:	blt.w 1556 <main+0x14e2>
     cde:	moveq #15,d4
     ce0:	and.l 50(sp),d4
     ce4:	movea.l d4,a3
	if (shift)
     ce6:	beq.w 156a <main+0x14f6>
     cea:	moveq #3,d4
     cec:	moveq #-6,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
     cee:	move.l d5,d0
     cf0:	moveq #12,d1
     cf2:	lsl.l d1,d0
     cf4:	ori.w #2304,d0
     cf8:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
     cfc:	move.w d5,d0
     cfe:	lsl.w d1,d0
     d00:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     d04:	move.l d6,-(sp)
     d06:	move.l 76(sp),-(sp)
     d0a:	jsr 2aa8 <__mulsi3>
     d10:	addq.l #8,sp
     d12:	move.l 50(sp),d1
     d16:	bmi.w 1516 <main+0x14a2>
     d1a:	asr.l #3,d1
     d1c:	add.l d1,d0
     d1e:	add.l 56(sp),d0
     d22:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     d26:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
     d2a:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     d30:	cmpa.w #0,a3
     d34:	beq.w 1536 <main+0x14c2>
     d38:	moveq #15,d1
     d3a:	sub.l d5,d1
     d3c:	moveq #0,d0
     d3e:	not.w d0
     d40:	asr.l d1,d0
     d42:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl - (width / 8);
     d46:	add.w 54(sp),d2
     d4a:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl - (width / 8);
     d4e:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     d52:	add.w d3,d4
     d54:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     d58:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     d5c:	move.w 2(a5),d0
     d60:	btst #14,d0
     d64:	bne.s d5c <main+0xce8>
	BYTE shift = x % 16;
     d66:	move.l 46(sp),d5
     d6a:	andi.l #-2147483633,d5
     d70:	tst.l 46(sp)
     d74:	blt.w 159e <main+0x152a>
     d78:	moveq #15,d0
     d7a:	and.l 46(sp),d0
     d7e:	movea.l d0,a3
	if (shift)
     d80:	beq.w 15b2 <main+0x153e>
     d84:	moveq #3,d4
     d86:	moveq #-6,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
     d88:	move.l d5,d0
     d8a:	moveq #12,d1
     d8c:	lsl.l d1,d0
     d8e:	ori.w #2304,d0
     d92:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
     d96:	move.w d5,d0
     d98:	lsl.w d1,d0
     d9a:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     d9e:	move.l d6,-(sp)
     da0:	move.l 68(sp),-(sp)
     da4:	jsr 2aa8 <__mulsi3>
     daa:	addq.l #8,sp
     dac:	move.l 46(sp),d1
     db0:	bmi.w 1448 <main+0x13d4>
     db4:	asr.l #3,d1
     db6:	add.l d1,d0
     db8:	add.l 56(sp),d0
     dbc:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     dc0:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
     dc4:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     dca:	cmpa.w #0,a3
     dce:	beq.w 1468 <main+0x13f4>
     dd2:	moveq #15,d1
     dd4:	sub.l d5,d1
     dd6:	moveq #0,d0
     dd8:	not.w d0
     dda:	asr.l d1,d0
     ddc:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl - (width / 8);
     de0:	add.w 54(sp),d2
     de4:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl - (width / 8);
     de8:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     dec:	add.w d3,d4
     dee:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     df2:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     df6:	move.w 2(a5),d0
     dfa:	move.w d0,d2
     dfc:	andi.w #16384,d2
     e00:	btst #14,d0
     e04:	bne.s df6 <main+0xd82>
	BYTE shift = x % 16;
     e06:	moveq #15,d5
     e08:	and.l 60(sp),d5
	if (shift)
     e0c:	beq.w 1b30 <main+0x1abc>
     e10:	movea.w #3,a3
     e14:	moveq #-6,d4
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
     e16:	move.l d5,d0
     e18:	moveq #12,d1
     e1a:	lsl.l d1,d0
     e1c:	ori.w #2304,d0
     e20:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
     e24:	move.w d5,d0
     e26:	lsl.w d1,d0
     e28:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     e2c:	move.l d6,-(sp)
     e2e:	move.l 72(sp),-(sp)
     e32:	jsr 2aa8 <__mulsi3>
     e38:	addq.l #8,sp
     e3a:	move.l 60(sp),d1
     e3e:	asr.l #3,d1
     e40:	add.l d1,d0
     e42:	add.l 56(sp),d0
     e46:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     e4a:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
     e4e:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     e54:	tst.l d5
     e56:	beq.w 1ac8 <main+0x1a54>
     e5a:	moveq #15,d1
     e5c:	sub.l d5,d1
     e5e:	moveq #0,d0
     e60:	not.w d0
     e62:	asr.l d1,d0
     e64:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl - (width / 8);
     e68:	add.w 54(sp),d4
     e6c:	move.w d4,100(a5)
	custom->bltdmod = bmp.Bpl - (width / 8);
     e70:	move.w d4,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     e74:	add.w a3,d3
     e76:	move.w d3,88(a5)
			pdb[b].X += incX[b];
     e7a:	movea.w 96(sp),a0
     e7e:	move.w a0,d0
     e80:	ext.l d0
     e82:	movea.l d7,a1
     e84:	lea (0,a1,d0.l),a0
     e88:	move.l a0,d7
			pdb[b].Y += incY[b];
     e8a:	movea.l 76(sp),a0
     e8e:	move.w 108(sp),d3
     e92:	move.w d3,d4
     e94:	ext.l d4
     e96:	lea (0,a0,d4.l),a0
     e9a:	move.l a0,76(sp)
			if (pdb[b].X >= 320 - 32)
     e9e:	cmpi.l #287,d7
     ea4:	ble.w 1b0e <main+0x1a9a>
				incX[b] *= -1;
     ea8:	neg.w 96(sp)
     eac:	clr.w 124(sp)
     eb0:	movea.w #36,a3
     eb4:	move.w #4042,122(sp)
     eba:	clr.l 136(sp)
     ebe:	suba.l a6,a6
				pdb[b].X = 320 - 32;
     ec0:	move.l #288,d7
			if (pdb[b].Y >= 130 - 32)
     ec6:	moveq #97,d1
     ec8:	cmp.l 76(sp),d1
     ecc:	bge.w 19f2 <main+0x197e>
				incY[b] *= -1;
     ed0:	neg.w 108(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
     ed4:	move.w a2,d0
     ed6:	mulu.w #98,d0
     eda:	adda.l d0,a3
				pdb[b].Y = 130 - 32;
     edc:	movea.w #98,a0
     ee0:	move.l a0,76(sp)
			pdb[b].X += incX[b];
     ee4:	movea.l 50(sp),a1
     ee8:	move.w 94(sp),d3
     eec:	move.w d3,d4
     eee:	ext.l d4
     ef0:	lea (0,a1,d4.l),a1
     ef4:	move.l a1,50(sp)
			pdb[b].Y += incY[b];
     ef8:	movea.l 72(sp),a0
     efc:	move.w 106(sp),d3
     f00:	move.w d3,d4
     f02:	ext.l d4
     f04:	lea (0,a0,d4.l),a0
     f08:	move.l a0,72(sp)
			if (pdb[b].X >= 320 - 32)
     f0c:	cmpa.w #287,a1
     f10:	ble.w 1a32 <main+0x19be>
				incX[b] *= -1;
     f14:	neg.w 94(sp)
     f18:	clr.w 114(sp)
     f1c:	moveq #36,d3
     f1e:	move.w #4042,112(sp)
     f24:	clr.l 140(sp)
     f28:	clr.l 82(sp)
				pdb[b].X = 320 - 32;
     f2c:	move.l #288,50(sp)
			if (pdb[b].Y >= 130 - 32)
     f34:	moveq #97,d0
     f36:	cmp.l 72(sp),d0
     f3a:	bge.w 1a60 <main+0x19ec>
				incY[b] *= -1;
     f3e:	neg.w 106(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
     f42:	move.w a2,d0
     f44:	mulu.w #98,d0
     f48:	add.l d0,d3
				pdb[b].Y = 130 - 32;
     f4a:	movea.w #98,a0
     f4e:	move.l a0,72(sp)
			pdb[b].X += incX[b];
     f52:	movea.l 46(sp),a1
     f56:	move.w 102(sp),d4
     f5a:	movea.w d4,a0
     f5c:	lea (0,a0,a1.l),a1
     f60:	move.l a1,46(sp)
			pdb[b].Y += incY[b];
     f64:	movea.l 64(sp),a1
     f68:	move.w 100(sp),d4
     f6c:	movea.w d4,a0
     f6e:	lea (0,a0,a1.l),a1
     f72:	move.l a1,64(sp)
			if (pdb[b].X >= 320 - 32)
     f76:	cmpi.l #287,46(sp)
     f7e:	ble.w 1aa0 <main+0x1a2c>
				incX[b] *= -1;
     f82:	neg.w 102(sp)
     f86:	clr.w 118(sp)
     f8a:	moveq #36,d4
     f8c:	move.w #4042,116(sp)
     f92:	clr.l 144(sp)
     f96:	clr.l 86(sp)
				pdb[b].X = 320 - 32;
     f9a:	move.l #288,46(sp)
			if (pdb[b].Y >= 130 - 32)
     fa2:	moveq #97,d1
     fa4:	cmp.l 64(sp),d1
     fa8:	bge.w 19de <main+0x196a>
				incY[b] *= -1;
     fac:	neg.w 100(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
     fb0:	move.w a2,d0
     fb2:	mulu.w #98,d0
     fb6:	add.l d0,d4
				pdb[b].Y = 130 - 32;
     fb8:	movea.w #98,a0
     fbc:	move.l a0,64(sp)
			pdb[b].X += incX[b];
     fc0:	movea.l 60(sp),a1
     fc4:	move.w 104(sp),d0
     fc8:	move.w d0,d1
     fca:	ext.l d1
     fcc:	lea (0,a1,d1.l),a1
     fd0:	move.l a1,60(sp)
			pdb[b].Y += incY[b];
     fd4:	movea.l 68(sp),a0
     fd8:	movea.w 98(sp),a1
     fdc:	move.w a1,d0
     fde:	ext.l d0
     fe0:	lea (0,a0,d0.l),a0
     fe4:	move.l a0,68(sp)
			if (pdb[b].X >= 320 - 32)
     fe8:	cmpi.l #287,60(sp)
     ff0:	ble.w 19ba <main+0x1946>
				incX[b] *= -1;
     ff4:	neg.w 104(sp)
     ff8:	clr.l 90(sp)
     ffc:	moveq #36,d5
     ffe:	move.w #4042,120(sp)
    1004:	clr.l 132(sp)
				pdb[b].X = 320 - 32;
    1008:	move.l #288,60(sp)
			if (pdb[b].Y >= 130 - 32)
    1010:	moveq #97,d1
    1012:	cmp.l 68(sp),d1
    1016:	bge.w 197e <main+0x190a>
				incY[b] *= -1;
    101a:	neg.w 98(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    101e:	move.w a2,d0
    1020:	mulu.w #98,d0
    1024:	add.l d0,d5
				pdb[b].Y = 130 - 32;
    1026:	movea.w #98,a2
    102a:	move.l a2,68(sp)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, ps2, pdb[0], 32, 32);
    102e:	move.w 23730 <BmpCookie+0x4>,44(sp)
    1036:	movea.w 23732 <BmpCookie+0x6>,a1
    103c:	movea.l 2373a <BmpCookie+0xe>,a2
    1042:	move.w 236fe <BmpCookieMask+0x6>,d1
    1048:	movea.l 23706 <BmpCookieMask+0xe>,a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    104e:	move.w 2(a5),d6
    1052:	move.w 44(sp),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1056:	move.w 2(a5),d6
    105a:	btst #14,d6
    105e:	bne.s 1056 <main+0xfe2>
	if (shift)
    1060:	move.w d0,44(sp)
    1064:	cmpa.w #0,a6
    1068:	beq.w 1914 <main+0x18a0>
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    106c:	move.w 122(sp),64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1072:	move.w 124(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1078:	move.l a2,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    107c:	move.w a1,d6
    107e:	subq.w #6,d6
    1080:	move.w d6,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1084:	move.l a0,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1088:	move.w d1,d6
    108a:	subq.w #6,d6
    108c:	move.w d6,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1090:	adda.l 56(sp),a3
    1094:	move.l a3,84(a5)
    1098:	move.l a3,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    109c:	move.w 54(sp),d6
    10a0:	subq.w #6,d6
    10a2:	move.w d6,102(a5)
    10a6:	move.w d6,96(a5)
	custom->bltafwm = 0xffff;
    10aa:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    10b0:	movea.w #15,a6
    10b4:	suba.l 136(sp),a6
    10b8:	moveq #0,d0
    10ba:	not.w d0
    10bc:	move.l a6,d6
    10be:	asr.l d6,d0
    10c0:	movea.l d0,a3
    10c2:	movea.w #3,a6
    10c6:	move.w a3,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    10ca:	moveq #0,d0
    10cc:	move.w 44(sp),d0
    10d0:	moveq #11,d6
    10d2:	lsl.l d6,d0
    10d4:	move.w a6,d6
    10d6:	or.w d0,d6
    10d8:	move.w d6,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    10dc:	move.w 2(a5),d6
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    10e0:	move.w 2(a5),d6
    10e4:	btst #14,d6
    10e8:	bne.s 10e0 <main+0x106c>
	if (shift)
    10ea:	tst.l 82(sp)
    10ee:	beq.w 1906 <main+0x1892>
    10f2:	move.w #3,122(sp)
    10f8:	movea.w #6,a3
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    10fc:	move.w 112(sp),64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1102:	move.w 114(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1108:	lea 6(a2),a6
    110c:	move.l a6,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    1110:	movea.w a1,a6
    1112:	suba.w a3,a6
    1114:	move.w a6,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1118:	lea 6(a0),a6
    111c:	move.l a6,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1120:	movea.w d1,a6
    1122:	suba.w a3,a6
    1124:	move.w a6,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1128:	add.l 56(sp),d3
    112c:	move.l d3,84(a5)
    1130:	move.l d3,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1134:	move.w 54(sp),d3
    1138:	sub.w a3,d3
    113a:	move.w d3,102(a5)
    113e:	move.w d3,96(a5)
	custom->bltafwm = 0xffff;
    1142:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1148:	tst.l 82(sp)
    114c:	beq.w 18ee <main+0x187a>
    1150:	movea.w #15,a3
    1154:	suba.l 140(sp),a3
    1158:	moveq #0,d3
    115a:	not.w d3
    115c:	move.l a3,d6
    115e:	asr.l d6,d3
    1160:	move.w d3,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1164:	move.w 122(sp),d6
    1168:	or.w d0,d6
    116a:	move.w d6,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    116e:	move.w 2(a5),d3
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1172:	move.w 2(a5),d3
    1176:	btst #14,d3
    117a:	bne.s 1172 <main+0x10fe>
	if (shift)
    117c:	tst.l 86(sp)
    1180:	beq.w 18e6 <main+0x1872>
    1184:	moveq #3,d3
    1186:	moveq #6,d6
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1188:	move.w 116(sp),64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    118e:	move.w 118(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1194:	lea 12(a2),a3
    1198:	move.l a3,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    119c:	movea.w a1,a3
    119e:	suba.w d6,a3
    11a0:	move.w a3,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    11a4:	lea 12(a0),a3
    11a8:	move.l a3,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    11ac:	movea.w d1,a3
    11ae:	suba.w d6,a3
    11b0:	move.w a3,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    11b4:	add.l 56(sp),d4
    11b8:	move.l d4,84(a5)
    11bc:	move.l d4,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    11c0:	move.w 54(sp),d4
    11c4:	sub.w d6,d4
    11c6:	move.w d4,102(a5)
    11ca:	move.w d4,96(a5)
	custom->bltafwm = 0xffff;
    11ce:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    11d4:	tst.l 86(sp)
    11d8:	beq.w 18d2 <main+0x185e>
    11dc:	moveq #15,d6
    11de:	sub.l 144(sp),d6
    11e2:	moveq #0,d4
    11e4:	not.w d4
    11e6:	asr.l d6,d4
    11e8:	move.w d4,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    11ec:	or.w d0,d3
    11ee:	move.w d3,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    11f2:	move.w 2(a5),d3
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    11f6:	move.w 2(a5),d3
    11fa:	btst #14,d3
    11fe:	bne.s 11f6 <main+0x1182>
	if (shift)
    1200:	tst.l 90(sp)
    1204:	beq.w 18ca <main+0x1856>
    1208:	moveq #3,d3
    120a:	moveq #6,d4
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    120c:	move.w 120(sp),64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1212:	move.w d2,66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1216:	lea 18(a2),a2
    121a:	move.l a2,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    121e:	suba.w d4,a1
    1220:	move.w a1,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1224:	lea 18(a0),a0
    1228:	move.l a0,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    122c:	sub.w d4,d1
    122e:	move.w d1,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1232:	add.l 56(sp),d5
    1236:	move.l d5,84(a5)
    123a:	move.l d5,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    123e:	move.w 54(sp),d1
    1242:	sub.w d4,d1
    1244:	move.w d1,102(a5)
    1248:	move.w d1,96(a5)
	custom->bltafwm = 0xffff;
    124c:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1252:	tst.l 90(sp)
    1256:	beq.w 18b4 <main+0x1840>
    125a:	moveq #15,d2
    125c:	sub.l 132(sp),d2
    1260:	moveq #0,d1
    1262:	not.w d1
    1264:	asr.l d2,d1
    1266:	move.w d1,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    126a:	or.w d3,d0
    126c:	move.w d0,88(a5)

void MoveStarfield()
{
	BYTE hpos;
	int line = 1;
	for (int l = 0; l < 31; l++)
    1270:	lea 233e1 <StarSprite+0x1>,a0
	{		
			((volatile UBYTE *)StarSprite)[line] += 3;
    1276:	move.b (a0),d0
    1278:	addq.b #3,d0
    127a:	move.b d0,(a0)
			((volatile UBYTE *)StarSprite)[line+8] += 1;
    127c:	lea 8(a0),a1
    1280:	move.b (a1),d0
    1282:	addq.b #1,d0
    1284:	move.b d0,(a1)
			((volatile UBYTE *)StarSprite)[line+16] += 2;
    1286:	lea 16(a0),a1
    128a:	move.b (a1),d0
    128c:	addq.b #2,d0
    128e:	move.b d0,(a1)
	for (int l = 0; l < 31; l++)
    1290:	lea 24(a0),a0
    1294:	cmpa.l a4,a0
    1296:	bne.s 1276 <main+0x1202>
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    1298:	move.b bfe001 <_end+0xbda725>,d0
	while (!MouseLeft())
    129e:	btst #6,d0
    12a2:	bne.w a86 <main+0xa12>
	register volatile const void *_a3 ASM("a3") = P61_Player;
    12a6:	lea 2c86 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    12ac:	movea.l #14675968,a6
	__asm volatile(
    12b2:	movem.l d0-d1/a0-a1,-(sp)
    12b6:	jsr 8(a3)
    12ba:	movem.l (sp)+,d0-d1/a0-a1
	FreeMem(copPtr, 1024);
    12be:	movea.l 238d2 <SysBase>,a6
    12c4:	movea.l 236f4 <copPtr>,a1
    12ca:	move.l #1024,d0
    12d0:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    12d4:	movea.l 238d2 <SysBase>,a6
    12da:	movea.l 237a2 <BmpScroller+0xe>,a1
    12e0:	moveq #0,d0
    12e2:	move.w 237a0 <BmpScroller+0xc>,d0
    12e8:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    12ec:	movea.l 238d2 <SysBase>,a6
    12f2:	movea.l 2383e <BmpUpperPart_PF1+0xe>,a1
    12f8:	moveq #0,d0
    12fa:	move.w 2383c <BmpUpperPart_PF1+0xc>,d0
    1300:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    1304:	movea.l 238d2 <SysBase>,a6
    130a:	movea.l 2380a <BmpUpperPart_PF2+0xe>,a1
    1310:	moveq #0,d0
    1312:	move.w 23808 <BmpUpperPart_PF2+0xc>,d0
    1318:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_Buf1.ImageData, BmpUpperPart_PF2.Btot);
    131c:	movea.l 238d2 <SysBase>,a6
    1322:	movea.l 237d6 <BmpUpperPart_Buf1+0xe>,a1
    1328:	moveq #0,d0
    132a:	move.w 23808 <BmpUpperPart_PF2+0xc>,d0
    1330:	jsr -210(a6)
	CloseLibrary((struct Library *)DOSBase);
    1334:	movea.l 238d2 <SysBase>,a6
    133a:	movea.l 238ca <DOSBase>,a1
    1340:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    1344:	movea.l 238d2 <SysBase>,a6
    134a:	movea.l 238ce <GfxBase>,a1
    1350:	jsr -414(a6)
	WaitVbl();
    1354:	jsr 2116 <WaitVbl>
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    135a:	movea.l 238d8 <custom>,a0
    1360:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1364:	move.w 2(a0),d0
    1368:	btst #14,d0
    136c:	bne.s 1364 <main+0x12f0>
	custom->intena = 0x7fff; //disable all interrupts
    136e:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
    1374:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
    137a:	move.w #32767,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
    1380:	movea.l 236f0 <VBR>,a1
    1386:	move.l 236ec <SystemIrq>,108(a1)
	custom->cop1lc = (ULONG)GfxBase->copinit;
    138e:	movea.l 238ce <GfxBase>,a6
    1394:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
    139a:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
    13a0:	move.w #32767,136(a0)
	custom->intena = SystemInts | 0x8000;
    13a6:	move.w 236ea <SystemInts>,d0
    13ac:	ori.w #-32768,d0
    13b0:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
    13b4:	move.w 236e8 <SystemDMA>,d0
    13ba:	ori.w #-32768,d0
    13be:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
    13c2:	move.w 236e6 <SystemADKCON>,d0
    13c8:	ori.w #-32768,d0
    13cc:	move.w d0,158(a0)
	LoadView(ActiView);
    13d0:	movea.l 236e2 <ActiView>,a1
    13d6:	jsr -222(a6)
	WaitTOF();
    13da:	movea.l 238ce <GfxBase>,a6
    13e0:	jsr -270(a6)
	WaitTOF();
    13e4:	movea.l 238ce <GfxBase>,a6
    13ea:	jsr -270(a6)
	WaitBlit();
    13ee:	movea.l 238ce <GfxBase>,a6
    13f4:	jsr -228(a6)
	DisownBlitter();
    13f8:	movea.l 238ce <GfxBase>,a6
    13fe:	jsr -462(a6)
	Enable();
    1402:	movea.l 238d2 <SysBase>,a6
    1408:	jsr -126(a6)
}
    140c:	moveq #0,d0
    140e:	movem.l (sp)+,d2-d7/a2-a6
    1412:	lea 136(sp),sp
    1416:	rts
			SetupCopper(copPtr);
    1418:	move.l 236f4 <copPtr>,d2
    141e:	move.l d2,-(sp)
    1420:	jsr 215c <SetupCopper>
			custom->cop1lc = (ULONG)copPtr;
    1426:	move.l d2,128(a5)
			custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    142a:	move.w #64,150(a5)
			custom->copjmp1 = 0x7fff;	   //start coppper
    1430:	move.w #32767,136(a5)
			custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    1436:	move.w #-30752,150(a5)
			ResetCopper = FALSE;
    143c:	clr.w 236e0 <ResetCopper>
    1442:	addq.l #4,sp
    1444:	bra.w ad8 <main+0xa64>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1448:	addq.l #7,d1
    144a:	asr.l #3,d1
    144c:	add.l d1,d0
    144e:	add.l 56(sp),d0
    1452:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1456:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    145a:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1460:	cmpa.w #0,a3
    1464:	bne.w dd2 <main+0xd5e>
    1468:	moveq #-1,d0
    146a:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl - (width / 8);
    146e:	add.w 54(sp),d2
    1472:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl - (width / 8);
    1476:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    147a:	add.w d3,d4
    147c:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1480:	move.w 2(a5),d0
    1484:	bra.w df6 <main+0xd82>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1488:	addq.l #7,d1
    148a:	asr.l #3,d1
    148c:	add.l d1,d0
    148e:	add.l 56(sp),d0
    1492:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1496:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    149a:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    14a0:	tst.l d5
    14a2:	bne.w c96 <main+0xc22>
    14a6:	moveq #-1,d0
    14a8:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl - (width / 8);
    14ac:	add.w 54(sp),d3
    14b0:	move.w d3,100(a5)
	custom->bltdmod = bmp.Bpl - (width / 8);
    14b4:	move.w d3,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    14b8:	move.w 110(sp),d3
    14bc:	moveq #11,d0
    14be:	lsl.w d0,d3
    14c0:	add.w d3,d2
    14c2:	move.w d2,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    14c6:	move.w 2(a5),d0
    14ca:	bra.w cc2 <main+0xc4e>
	BYTE shift = x % 16;
    14ce:	subq.l #1,d4
    14d0:	moveq #-16,d0
    14d2:	or.l d0,d4
    14d4:	addq.l #1,d4
    14d6:	moveq #15,d5
    14d8:	and.l d7,d5
	if (shift)
    14da:	bne.w c46 <main+0xbd2>
    14de:	moveq #2,d2
    14e0:	moveq #-4,d3
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    14e2:	move.l d4,d0
    14e4:	moveq #12,d1
    14e6:	lsl.l d1,d0
    14e8:	ori.w #2304,d0
    14ec:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    14f0:	move.w d4,d0
    14f2:	moveq #12,d6
    14f4:	lsl.w d6,d0
    14f6:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    14fa:	moveq #0,d6
    14fc:	move.w a2,d6
    14fe:	move.l 76(sp),-(sp)
    1502:	move.l d6,-(sp)
    1504:	jsr 2aa8 <__mulsi3>
    150a:	addq.l #8,sp
    150c:	move.l d7,d1
    150e:	bpl.w c7a <main+0xc06>
    1512:	bra.w 1488 <main+0x1414>
    1516:	addq.l #7,d1
    1518:	asr.l #3,d1
    151a:	add.l d1,d0
    151c:	add.l 56(sp),d0
    1520:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1524:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    1528:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    152e:	cmpa.w #0,a3
    1532:	bne.w d38 <main+0xcc4>
    1536:	moveq #-1,d0
    1538:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl - (width / 8);
    153c:	add.w 54(sp),d2
    1540:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl - (width / 8);
    1544:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    1548:	add.w d3,d4
    154a:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    154e:	move.w 2(a5),d0
    1552:	bra.w d5c <main+0xce8>
	BYTE shift = x % 16;
    1556:	subq.l #1,d5
    1558:	moveq #-16,d1
    155a:	or.l d1,d5
    155c:	addq.l #1,d5
    155e:	moveq #15,d4
    1560:	and.l 50(sp),d4
    1564:	movea.l d4,a3
	if (shift)
    1566:	bne.w cea <main+0xc76>
    156a:	moveq #2,d4
    156c:	moveq #-4,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    156e:	move.l d5,d0
    1570:	moveq #12,d1
    1572:	lsl.l d1,d0
    1574:	ori.w #2304,d0
    1578:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    157c:	move.w d5,d0
    157e:	lsl.w d1,d0
    1580:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1584:	move.l d6,-(sp)
    1586:	move.l 76(sp),-(sp)
    158a:	jsr 2aa8 <__mulsi3>
    1590:	addq.l #8,sp
    1592:	move.l 50(sp),d1
    1596:	bpl.w d1a <main+0xca6>
    159a:	bra.w 1516 <main+0x14a2>
	BYTE shift = x % 16;
    159e:	subq.l #1,d5
    15a0:	moveq #-16,d4
    15a2:	or.l d4,d5
    15a4:	addq.l #1,d5
    15a6:	moveq #15,d0
    15a8:	and.l 46(sp),d0
    15ac:	movea.l d0,a3
	if (shift)
    15ae:	bne.w d84 <main+0xd10>
    15b2:	moveq #2,d4
    15b4:	moveq #-4,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    15b6:	move.l d5,d0
    15b8:	moveq #12,d1
    15ba:	lsl.l d1,d0
    15bc:	ori.w #2304,d0
    15c0:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    15c4:	move.w d5,d0
    15c6:	lsl.w d1,d0
    15c8:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    15cc:	move.l d6,-(sp)
    15ce:	move.l 68(sp),-(sp)
    15d2:	jsr 2aa8 <__mulsi3>
    15d8:	addq.l #8,sp
    15da:	move.l 46(sp),d1
    15de:	bpl.w db4 <main+0xd40>
    15e2:	bra.w 1448 <main+0x13d4>
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    15e6:	move.w 2379c <BmpScroller+0x8>,d3
	int BltOffs = startY * theDesc.Bplt;
    15ec:	move.w d3,d4
    15ee:	mulu.w #40,d4
	int Brcorner = height * theDesc.Bplt - 2;
    15f2:	andi.l #65535,d3
    15f8:	lsl.l #5,d3
    15fa:	subq.l #2,d3
	WaitBlit();
    15fc:	movea.l 238ce <GfxBase>,a6
    1602:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
    1606:	movea.l 238d8 <custom>,a5
    160c:	move.w #18928,64(a5)
	custom->bltcon1 = 0x0002;
    1612:	move.w #2,66(a5)
	custom->bltafwm = 0xffff;
    1618:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    161e:	move.w #-1,70(a5)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
    1624:	add.l d4,d3
    1626:	add.l 126(sp),d3
    162a:	move.l d3,80(a5)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
    162e:	move.l d3,84(a5)
	custom->bltamod = 0;
    1632:	move.w #0,100(a5)
	custom->bltdmod = 0;
    1638:	move.w #0,102(a5)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
    163e:	move.w 130(sp),d0
    1642:	moveq #11,d1
    1644:	lsl.w d1,d0
    1646:	lea 23794 <BmpScroller>,a0
    164c:	move.w (a0),d1
    164e:	lsr.w #4,d1
    1650:	add.w d1,d0
    1652:	move.w d0,88(a5)
	ScrollCnt += speed;
    1656:	move.w 236d4 <ScrollCnt>,d0
    165c:	addq.w #4,d0
    165e:	move.w d0,236d4 <ScrollCnt>
	if (ScrollCnt >= NextPlot)
    1664:	cmp.w 6004 <NextPlot>,d0
    166a:	bcc.s 16de <main+0x166a>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    166c:	move.w 236da <ScrollerY>,80(sp)
    1674:	movea.w 80(sp),a0
    1678:	move.w 23798 <BmpScroller+0x4>,130(sp)
    1680:	move.l 237a2 <BmpScroller+0xe>,126(sp)
    1688:	move.w 237cc <BmpUpperPart_Buf1+0x4>,110(sp)
    1690:	move.w 237ce <BmpUpperPart_Buf1+0x6>,54(sp)
    1698:	move.l 237d6 <BmpUpperPart_Buf1+0xe>,56(sp)
    16a0:	moveq #0,d4
    16a2:	move.w 130(sp),d4
    16a6:	movea.l 236d6 <copScrollerBmpP>,a2
    16ac:	moveq #0,d5
    16ae:	move.w 2379a <BmpScroller+0x6>,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    16b4:	move.l a0,-(sp)
    16b6:	move.l d5,-(sp)
    16b8:	jsr 2aa8 <__mulsi3>
    16be:	addq.l #4,sp
    16c0:	move.l d4,(sp)
    16c2:	move.l d0,-(sp)
    16c4:	jsr 2aa8 <__mulsi3>
    16ca:	addq.l #8,sp
    16cc:	add.l 126(sp),d0
        addr += Bpl;
    16d0:	move.w #224,d1
    for (USHORT i = 0; i < numPlanes; i++)
    16d4:	tst.l d4
    16d6:	bne.w bf4 <main+0xb80>
    16da:	bra.w c1c <main+0xba8>
		ScrollCnt = 0;
    16de:	clr.w 236d4 <ScrollCnt>
		PlotChar(BmpFont32, (UBYTE *)BmpFont32P, BmpScroller, (UBYTE *)BmpScroller.ImageData, startY, 32, 32);
    16e4:	move.l 237a2 <BmpScroller+0xe>,126(sp)
    16ec:	move.w 23764 <BmpFont32+0x4>,d4
    16f2:	move.w 23766 <BmpFont32+0x6>,d6
    16f8:	movea.w 23768 <BmpFont32+0x8>,a1
    16fe:	move.w 2379a <BmpScroller+0x6>,d5
    1704:	move.w 2379c <BmpScroller+0x8>,d1
	UBYTE chr = Scrolltext[ScrolltextCnt++];
    170a:	movea.w 236d2 <ScrolltextCnt>,a0
    1710:	move.w a0,d3
    1712:	addq.w #1,d3
    1714:	move.w d3,236d2 <ScrolltextCnt>
    171a:	moveq #0,d0
    171c:	move.w a0,d0
    171e:	lea 4698 <Scrolltext>,a2
    1724:	move.b (0,a2,d0.l),d0
	NextPlot = 32;
    1728:	move.w #32,6004 <NextPlot>
	if (chr == 'b')
    1730:	cmpi.b #98,d0
    1734:	beq.w 1d74 <main+0x1d00>
	if (chr == 'm')
    1738:	cmpi.b #109,d0
    173c:	beq.w 1d0e <main+0x1c9a>
	if (chr == 's')
    1740:	cmpi.b #115,d0
    1744:	beq.w 1e5e <main+0x1dea>
	if (chr == 'c')
    1748:	cmpi.b #99,d0
    174c:	beq.w 1ea0 <main+0x1e2c>
	if (chr == '!' || chr == 'I' || chr == '.' || chr == ',' || chr == ':' || chr == ';' || chr == '\'')
    1750:	cmpi.b #33,d0
    1754:	bne.w 1848 <main+0x17d4>
		NextPlot = 12;
    1758:	move.w #12,6004 <NextPlot>
	if (chr == 'J')
    1760:	cmpi.b #74,d0
    1764:	beq.w 1dc8 <main+0x1d54>
	if (chr == 0)
    1768:	tst.b d0
    176a:	bne.w 1f6c <main+0x1ef8>
		chr = Scrolltext[ScrolltextCnt++];
    176e:	move.w #1,236d2 <ScrolltextCnt>
		colScrollMirror[0] = 0x111;
    1776:	move.l #17891874,6000 <colScrollMirror>
		ResetCopper = TRUE;
    1780:	move.w #1,236e0 <ResetCopper>
	row = chr / 10;
    1788:	ext.w d0
    178a:	moveq #10,d3
    178c:	ext.l d0
    178e:	divs.w d3,d0
    1790:	move.l d0,d3
    1792:	swap d3
    1794:	movea.w d3,a0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    1796:	clr.w d3
    1798:	move.b d0,d3
    179a:	move.w a1,d0
    179c:	mulu.w d0,d3
    179e:	lsl.l #5,d3
    17a0:	movea.l d3,a1
	col = chr % 10;
    17a2:	move.w a0,d3
    17a4:	moveq #0,d0
    17a6:	move.b d3,d0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    17a8:	add.l d0,d0
    17aa:	add.l d0,d0
    17ac:	move.l a1,d3
    17ae:	add.l d0,d3
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    17b0:	mulu.w #40,d1
    17b4:	moveq #0,d0
    17b6:	move.w 2389e <Screen+0x6>,d0
    17bc:	movea.l d1,a2
    17be:	adda.l d0,a2
	WaitBlit();
    17c0:	movea.l 238ce <GfxBase>,a6
    17c6:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    17ca:	movea.l 238d8 <custom>,a5
    17d0:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
    17d6:	move.w #0,66(a5)
	custom->bltafwm = 0xffff;
    17dc:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    17e2:	move.w #-1,70(a5)
	custom->bltapt = bmpFontP + source;
    17e8:	addi.l #37066,d3
    17ee:	move.l d3,80(a5)
	custom->bltdpt = bmpDestP + dest;
    17f2:	adda.l 126(sp),a2
    17f6:	move.l a2,84(a5)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    17fa:	subq.w #4,d6
    17fc:	move.w d6,100(a5)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    1800:	subq.w #4,d5
    1802:	move.w d5,102(a5)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    1806:	moveq #11,d6
    1808:	lsl.w d6,d4
    180a:	addq.w #2,d4
    180c:	move.w d4,88(a5)
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    1810:	move.w 236da <ScrollerY>,80(sp)
    1818:	movea.w 80(sp),a0
    181c:	move.w 23798 <BmpScroller+0x4>,130(sp)
    1824:	move.l 237a2 <BmpScroller+0xe>,126(sp)
    182c:	move.w 237cc <BmpUpperPart_Buf1+0x4>,110(sp)
    1834:	move.w 237ce <BmpUpperPart_Buf1+0x6>,54(sp)
    183c:	move.l 237d6 <BmpUpperPart_Buf1+0xe>,56(sp)
    1844:	bra.w 16a0 <main+0x162c>
	if (chr == '!' || chr == 'I' || chr == '.' || chr == ',' || chr == ':' || chr == ';' || chr == '\'')
    1848:	cmpi.b #73,d0
    184c:	beq.w 1758 <main+0x16e4>
    1850:	move.b d0,d3
    1852:	andi.b #-3,d3
    1856:	cmpi.b #44,d3
    185a:	beq.w 1758 <main+0x16e4>
    185e:	move.b d0,d3
    1860:	addi.b #-58,d3
    1864:	cmpi.b #1,d3
    1868:	bls.w 1758 <main+0x16e4>
    186c:	cmpi.b #39,d0
    1870:	bne.w 1760 <main+0x16ec>
		NextPlot = 12;
    1874:	move.w #12,6004 <NextPlot>
    187c:	bra.w 1760 <main+0x16ec>
			StarSprite[line++] = 0x8000; //color-3
    1880:	move.w #-32768,6(a2)
		vpos += 2;
    1886:	addq.b #2,d4
	for (int l = 0; l < 93; l++)
    1888:	addq.l #1,d3
    188a:	addq.l #8,a2
    188c:	cmpi.b #-26,d4
    1890:	bne.w 8f8 <main+0x884>
    1894:	bra.w 954 <main+0x8e0>
			StarSprite[line++] = 0x0000; //color-2
    1898:	clr.w 4(a2)
			StarSprite[line++] = 0x8000; //color-2
    189c:	move.w #-32768,6(a2)
		vpos += 2;
    18a2:	addq.b #2,d4
	for (int l = 0; l < 93; l++)
    18a4:	addq.l #1,d3
    18a6:	addq.l #8,a2
    18a8:	cmpi.b #-26,d4
    18ac:	bne.w 8f8 <main+0x884>
    18b0:	bra.w 954 <main+0x8e0>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    18b4:	moveq #-1,d1
    18b6:	move.w d1,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    18ba:	or.w d3,d0
    18bc:	move.w d0,88(a5)
	for (int l = 0; l < 31; l++)
    18c0:	lea 233e1 <StarSprite+0x1>,a0
    18c6:	bra.w 1276 <main+0x1202>
	if (shift)
    18ca:	moveq #2,d3
    18cc:	moveq #4,d4
    18ce:	bra.w 120c <main+0x1198>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    18d2:	moveq #-1,d4
    18d4:	move.w d4,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    18d8:	or.w d0,d3
    18da:	move.w d3,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    18de:	move.w 2(a5),d3
    18e2:	bra.w 11f6 <main+0x1182>
	if (shift)
    18e6:	moveq #2,d3
    18e8:	moveq #4,d6
    18ea:	bra.w 1188 <main+0x1114>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    18ee:	moveq #-1,d3
    18f0:	move.w d3,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    18f4:	move.w 122(sp),d6
    18f8:	or.w d0,d6
    18fa:	move.w d6,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    18fe:	move.w 2(a5),d3
    1902:	bra.w 1172 <main+0x10fe>
	if (shift)
    1906:	move.w #2,122(sp)
    190c:	movea.w #4,a3
    1910:	bra.w 10fc <main+0x1088>
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1914:	move.w 122(sp),64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    191a:	move.w 124(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1920:	move.l a2,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    1924:	move.w a1,d6
    1926:	subq.w #4,d6
    1928:	move.w d6,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    192c:	move.l a0,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1930:	move.w d1,d6
    1932:	subq.w #4,d6
    1934:	move.w d6,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1938:	adda.l 56(sp),a3
    193c:	move.l a3,84(a5)
    1940:	move.l a3,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1944:	move.w 54(sp),d6
    1948:	subq.w #4,d6
    194a:	move.w d6,102(a5)
    194e:	move.w d6,96(a5)
	custom->bltafwm = 0xffff;
    1952:	move.w #-1,68(a5)
    1958:	movea.w #2,a6
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    195c:	movea.w #-1,a3
    1960:	move.w a3,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1964:	moveq #0,d0
    1966:	move.w 44(sp),d0
    196a:	moveq #11,d6
    196c:	lsl.l d6,d0
    196e:	move.w a6,d6
    1970:	or.w d0,d6
    1972:	move.w d6,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1976:	move.w 2(a5),d6
    197a:	bra.w 10e0 <main+0x106c>
			if (pdb[b].Y <= 0)
    197e:	tst.l 68(sp)
    1982:	bgt.w 1bf0 <main+0x1b7c>
				incY[b] *= -1;
    1986:	neg.w 98(sp)
				pdb[b].Y = 0;
    198a:	clr.l 68(sp)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, ps2, pdb[0], 32, 32);
    198e:	move.w 23730 <BmpCookie+0x4>,44(sp)
    1996:	movea.w 23732 <BmpCookie+0x6>,a1
    199c:	movea.l 2373a <BmpCookie+0xe>,a2
    19a2:	move.w 236fe <BmpCookieMask+0x6>,d1
    19a8:	movea.l 23706 <BmpCookieMask+0xe>,a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    19ae:	move.w 2(a5),d6
    19b2:	move.w 44(sp),d0
    19b6:	bra.w 1056 <main+0xfe2>
			if (pdb[b].X <= 0)
    19ba:	tst.l 60(sp)
    19be:	bgt.w 1bc0 <main+0x1b4c>
				incX[b] *= -1;
    19c2:	neg.w 104(sp)
    19c6:	clr.l 90(sp)
    19ca:	moveq #0,d5
    19cc:	move.w #4042,120(sp)
    19d2:	clr.l 132(sp)
				pdb[b].X = 0;
    19d6:	clr.l 60(sp)
    19da:	bra.w 1010 <main+0xf9c>
			if (pdb[b].Y <= 0)
    19de:	tst.l 64(sp)
    19e2:	bgt.w 1c6e <main+0x1bfa>
				incY[b] *= -1;
    19e6:	neg.w 100(sp)
				pdb[b].Y = 0;
    19ea:	clr.l 64(sp)
    19ee:	bra.w fc0 <main+0xf4c>
			if (pdb[b].Y <= 0)
    19f2:	tst.l 76(sp)
    19f6:	bgt.w 1c2c <main+0x1bb8>
				incY[b] *= -1;
    19fa:	neg.w 108(sp)
				pdb[b].Y = 0;
    19fe:	clr.l 76(sp)
			pdb[b].X += incX[b];
    1a02:	movea.l 50(sp),a1
    1a06:	move.w 94(sp),d3
    1a0a:	move.w d3,d4
    1a0c:	ext.l d4
    1a0e:	lea (0,a1,d4.l),a1
    1a12:	move.l a1,50(sp)
			pdb[b].Y += incY[b];
    1a16:	movea.l 72(sp),a0
    1a1a:	move.w 106(sp),d3
    1a1e:	move.w d3,d4
    1a20:	ext.l d4
    1a22:	lea (0,a0,d4.l),a0
    1a26:	move.l a0,72(sp)
			if (pdb[b].X >= 320 - 32)
    1a2a:	cmpa.w #287,a1
    1a2e:	bgt.w f14 <main+0xea0>
			if (pdb[b].X <= 0)
    1a32:	tst.l 50(sp)
    1a36:	bgt.w 1c82 <main+0x1c0e>
				incX[b] *= -1;
    1a3a:	neg.w 94(sp)
    1a3e:	clr.w 114(sp)
    1a42:	moveq #0,d3
    1a44:	move.w #4042,112(sp)
    1a4a:	clr.l 140(sp)
    1a4e:	clr.l 82(sp)
				pdb[b].X = 0;
    1a52:	clr.l 50(sp)
			if (pdb[b].Y >= 130 - 32)
    1a56:	moveq #97,d0
    1a58:	cmp.l 72(sp),d0
    1a5c:	blt.w f3e <main+0xeca>
			if (pdb[b].Y <= 0)
    1a60:	tst.l 72(sp)
    1a64:	bgt.w 1cb0 <main+0x1c3c>
				incY[b] *= -1;
    1a68:	neg.w 106(sp)
				pdb[b].Y = 0;
    1a6c:	clr.l 72(sp)
			pdb[b].X += incX[b];
    1a70:	movea.l 46(sp),a1
    1a74:	move.w 102(sp),d4
    1a78:	movea.w d4,a0
    1a7a:	lea (0,a0,a1.l),a1
    1a7e:	move.l a1,46(sp)
			pdb[b].Y += incY[b];
    1a82:	movea.l 64(sp),a1
    1a86:	move.w 100(sp),d4
    1a8a:	movea.w d4,a0
    1a8c:	lea (0,a0,a1.l),a1
    1a90:	move.l a1,64(sp)
			if (pdb[b].X >= 320 - 32)
    1a94:	cmpi.l #287,46(sp)
    1a9c:	bgt.w f82 <main+0xf0e>
			if (pdb[b].X <= 0)
    1aa0:	tst.l 46(sp)
    1aa4:	bgt.w 1c40 <main+0x1bcc>
				incX[b] *= -1;
    1aa8:	neg.w 102(sp)
    1aac:	clr.w 118(sp)
    1ab0:	moveq #0,d4
    1ab2:	move.w #4042,116(sp)
    1ab8:	clr.l 144(sp)
    1abc:	clr.l 86(sp)
				pdb[b].X = 0;
    1ac0:	clr.l 46(sp)
    1ac4:	bra.w fa2 <main+0xf2e>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1ac8:	moveq #-1,d0
    1aca:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl - (width / 8);
    1ace:	add.w 54(sp),d4
    1ad2:	move.w d4,100(a5)
	custom->bltdmod = bmp.Bpl - (width / 8);
    1ad6:	move.w d4,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    1ada:	add.w a3,d3
    1adc:	move.w d3,88(a5)
			pdb[b].X += incX[b];
    1ae0:	movea.w 96(sp),a0
    1ae4:	move.w a0,d0
    1ae6:	ext.l d0
    1ae8:	movea.l d7,a1
    1aea:	lea (0,a1,d0.l),a0
    1aee:	move.l a0,d7
			pdb[b].Y += incY[b];
    1af0:	movea.l 76(sp),a0
    1af4:	move.w 108(sp),d3
    1af8:	move.w d3,d4
    1afa:	ext.l d4
    1afc:	lea (0,a0,d4.l),a0
    1b00:	move.l a0,76(sp)
			if (pdb[b].X >= 320 - 32)
    1b04:	cmpi.l #287,d7
    1b0a:	bgt.w ea8 <main+0xe34>
			if (pdb[b].X <= 0)
    1b0e:	tst.l d7
    1b10:	bgt.w 1cc4 <main+0x1c50>
				incX[b] *= -1;
    1b14:	neg.w 96(sp)
    1b18:	clr.w 124(sp)
    1b1c:	suba.l a3,a3
    1b1e:	move.w #4042,122(sp)
    1b24:	clr.l 136(sp)
    1b28:	suba.l a6,a6
				pdb[b].X = 0;
    1b2a:	moveq #0,d7
    1b2c:	bra.w ec6 <main+0xe52>
	if (shift)
    1b30:	movea.w #2,a3
    1b34:	moveq #-4,d4
    1b36:	bra.w e16 <main+0xda2>
		else if (ScrollerY <= ScrollerMin)
    1b3a:	cmpa.w #0,a0
    1b3e:	bgt.w bb6 <main+0xb42>
			ScrollerY = ScrollerMin;
    1b42:	clr.w 236da <ScrollerY>
			ScrollerDir = 1;
    1b48:	move.b #1,6006 <ScrollerDir>
    1b50:	suba.l a0,a0
    1b52:	clr.w 80(sp)
		if (ScrollerPause < 1)
    1b56:	tst.w d3
    1b58:	bne.w bbc <main+0xb48>
    1b5c:	bra.w 15e6 <main+0x1572>
				ScrollerDir -= 1;
    1b60:	subq.b #1,d0
				if (ScrollerDir < -4)
    1b62:	cmpi.b #-4,d0
    1b66:	bge.s 1ba2 <main+0x1b2e>
					ScrollerDir = -4;
    1b68:	move.b #-4,6006 <ScrollerDir>
    1b70:	moveq #-4,d0
			ScrollerY += ScrollerDir;
    1b72:	add.w d0,80(sp)
    1b76:	move.w 80(sp),236da <ScrollerY>
    1b7e:	bra.w b90 <main+0xb1c>
				if (ScrollerDir < 1)
    1b82:	tst.b d0
    1b84:	bgt.w 2070 <main+0x1ffc>
					ScrollerDir = 1;
    1b88:	move.b #1,6006 <ScrollerDir>
    1b90:	moveq #1,d0
			ScrollerY += ScrollerDir;
    1b92:	add.w d0,80(sp)
    1b96:	move.w 80(sp),236da <ScrollerY>
    1b9e:	bra.w b90 <main+0xb1c>
				if (ScrollerDir > -1)
    1ba2:	tst.b d0
    1ba4:	blt.w 2070 <main+0x1ffc>
					ScrollerDir = -1;
    1ba8:	st 6006 <ScrollerDir>
    1bae:	moveq #-1,d0
			ScrollerY += ScrollerDir;
    1bb0:	add.w d0,80(sp)
    1bb4:	move.w 80(sp),236da <ScrollerY>
    1bbc:	bra.w b90 <main+0xb1c>
	BYTE shift = startD.X % 16;
    1bc0:	moveq #15,d1
    1bc2:	and.l 60(sp),d1
    1bc6:	move.l d1,132(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1bca:	move.l d1,d0
    1bcc:	moveq #12,d1
    1bce:	lsl.l d1,d0
    1bd0:	ori.w #4042,d0
    1bd4:	move.w d0,120(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1bd8:	move.w 134(sp),d2
    1bdc:	moveq #12,d0
    1bde:	lsl.w d0,d2
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1be0:	move.l 60(sp),d5
    1be4:	asr.l #3,d5
    1be6:	move.l 132(sp),90(sp)
    1bec:	bra.w 1010 <main+0xf9c>
    1bf0:	move.l 68(sp),-(sp)
    1bf4:	move.l d6,-(sp)
    1bf6:	jsr 2aa8 <__mulsi3>
    1bfc:	addq.l #8,sp
    1bfe:	add.l d0,d5
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, ps2, pdb[0], 32, 32);
    1c00:	move.w 23730 <BmpCookie+0x4>,44(sp)
    1c08:	movea.w 23732 <BmpCookie+0x6>,a1
    1c0e:	movea.l 2373a <BmpCookie+0xe>,a2
    1c14:	move.w 236fe <BmpCookieMask+0x6>,d1
    1c1a:	movea.l 23706 <BmpCookieMask+0xe>,a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1c20:	move.w 2(a5),d6
    1c24:	move.w 44(sp),d0
    1c28:	bra.w 1056 <main+0xfe2>
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1c2c:	move.l d6,-(sp)
    1c2e:	move.l 80(sp),-(sp)
    1c32:	jsr 2aa8 <__mulsi3>
    1c38:	addq.l #8,sp
    1c3a:	adda.l d0,a3
    1c3c:	bra.w ee4 <main+0xe70>
    1c40:	moveq #15,d1
    1c42:	and.l 46(sp),d1
    1c46:	move.l d1,86(sp)
	BYTE shift = startD.X % 16;
    1c4a:	move.l d1,144(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1c4e:	move.l d1,d0
    1c50:	moveq #12,d4
    1c52:	lsl.l d4,d0
    1c54:	ori.w #4042,d0
    1c58:	move.w d0,116(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1c5c:	moveq #12,d0
    1c5e:	lsl.w d0,d1
    1c60:	move.w d1,118(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1c64:	move.l 46(sp),d4
    1c68:	asr.l #3,d4
    1c6a:	bra.w fa2 <main+0xf2e>
    1c6e:	move.l 64(sp),-(sp)
    1c72:	move.l d6,-(sp)
    1c74:	jsr 2aa8 <__mulsi3>
    1c7a:	addq.l #8,sp
    1c7c:	add.l d0,d4
    1c7e:	bra.w fc0 <main+0xf4c>
    1c82:	moveq #15,d1
    1c84:	and.l 50(sp),d1
    1c88:	move.l d1,82(sp)
	BYTE shift = startD.X % 16;
    1c8c:	move.l d1,140(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1c90:	move.l d1,d0
    1c92:	moveq #12,d3
    1c94:	lsl.l d3,d0
    1c96:	ori.w #4042,d0
    1c9a:	move.w d0,112(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1c9e:	moveq #12,d4
    1ca0:	lsl.w d4,d1
    1ca2:	move.w d1,114(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1ca6:	move.l 50(sp),d3
    1caa:	asr.l #3,d3
    1cac:	bra.w f34 <main+0xec0>
    1cb0:	move.l d6,-(sp)
    1cb2:	move.l 76(sp),-(sp)
    1cb6:	jsr 2aa8 <__mulsi3>
    1cbc:	addq.l #8,sp
    1cbe:	add.l d0,d3
    1cc0:	bra.w f52 <main+0xede>
    1cc4:	moveq #15,d0
    1cc6:	and.l d7,d0
    1cc8:	movea.l d0,a6
	BYTE shift = startD.X % 16;
    1cca:	move.l d0,136(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1cce:	moveq #12,d1
    1cd0:	lsl.l d1,d0
    1cd2:	ori.w #4042,d0
    1cd6:	move.w d0,122(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1cda:	move.w a6,d3
    1cdc:	moveq #12,d4
    1cde:	lsl.w d4,d3
    1ce0:	move.w d3,124(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1ce4:	move.l d7,d0
    1ce6:	asr.l #3,d0
    1ce8:	movea.l d0,a3
    1cea:	bra.w ec6 <main+0xe52>
		KPrintF("p61Init failed!\n");
    1cee:	pea 4636 <incbin_P61_Player_end+0x4a>
    1cf4:	jsr (a4)
    1cf6:	addq.l #4,sp
	APTR vbr = 0;
    1cf8:	lea 233e0 <StarSprite>,a2
    1cfe:	moveq #0,d3
    1d00:	moveq #44,d4
    1d02:	moveq #3,d2
    1d04:	lea 2b50 <__modsi3>,a3
    1d0a:	bra.w 8f8 <main+0x884>
		if (MirrorEnabled)
    1d0e:	move.w 236d0 <MirrorEnabled>,d0
				 BmpScroller.Bplt - Screen.Bpl);
    1d14:	move.w d1,d3
    1d16:	sub.w 2389e <Screen+0x6>,d3
	copSetBplMod(0, copMirrorBmpP,
    1d1c:	movea.l 236cc <copMirrorBmpP>,a0
		if (MirrorEnabled)
    1d22:	tst.w d0
    1d24:	beq.w 2088 <main+0x2014>
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    1d28:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    1d2c:	move.w d3,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    1d30:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    1d36:	move.w d3,6(a0)
		MirrorEnabled = !MirrorEnabled;
    1d3a:	tst.w d0
    1d3c:	seq d0
    1d3e:	ext.w d0
    1d40:	neg.w d0
    1d42:	move.w d0,236d0 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    1d48:	move.w 236d2 <ScrolltextCnt>,d0
    1d4e:	movea.w d0,a2
    1d50:	addq.w #1,a2
    1d52:	move.w a2,236d2 <ScrolltextCnt>
    1d58:	andi.l #65535,d0
    1d5e:	lea 4698 <Scrolltext>,a0
    1d64:	move.b (0,a0,d0.l),d0
	if (chr == 's')
    1d68:	cmpi.b #115,d0
    1d6c:	bne.w 1748 <main+0x16d4>
    1d70:	bra.w 1e5e <main+0x1dea>
		if (BounceEnabled)
    1d74:	move.w 236dc <BounceEnabled>,d0
    1d7a:	beq.s 1d8a <main+0x1d16>
			ScrollerY = SCRT_MIN;
    1d7c:	clr.w 236da <ScrollerY>
			ScrollerDir = 1;
    1d82:	move.b #1,6006 <ScrollerDir>
		BounceEnabled = !BounceEnabled;
    1d8a:	tst.w d0
    1d8c:	seq d0
    1d8e:	ext.w d0
    1d90:	neg.w d0
    1d92:	move.w d0,236dc <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    1d98:	addq.w #2,a0
    1d9a:	move.w a0,236d2 <ScrolltextCnt>
    1da0:	andi.l #65535,d3
    1da6:	lea 4698 <Scrolltext>,a0
    1dac:	move.b (0,a0,d3.l),d0
	if (chr == 'm')
    1db0:	cmpi.b #109,d0
    1db4:	bne.w 1740 <main+0x16cc>
    1db8:	bra.w 1d0e <main+0x1c9a>
		Exit(0);
    1dbc:	suba.l a6,a6
    1dbe:	moveq #0,d1
    1dc0:	jsr -144(a6)
    1dc4:	bra.w c2 <main+0x4e>
		NextPlot = 24;
    1dc8:	move.w #24,6004 <NextPlot>
	if (chr < 32 || chr > (32 + 80))
    1dd0:	moveq #42,d0
	row = chr / 10;
    1dd2:	ext.w d0
    1dd4:	moveq #10,d3
    1dd6:	ext.l d0
    1dd8:	divs.w d3,d0
    1dda:	move.l d0,d3
    1ddc:	swap d3
    1dde:	movea.w d3,a0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    1de0:	clr.w d3
    1de2:	move.b d0,d3
    1de4:	move.w a1,d0
    1de6:	mulu.w d0,d3
    1de8:	lsl.l #5,d3
    1dea:	movea.l d3,a1
	col = chr % 10;
    1dec:	move.w a0,d3
    1dee:	moveq #0,d0
    1df0:	move.b d3,d0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    1df2:	add.l d0,d0
    1df4:	add.l d0,d0
    1df6:	move.l a1,d3
    1df8:	add.l d0,d3
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    1dfa:	mulu.w #40,d1
    1dfe:	moveq #0,d0
    1e00:	move.w 2389e <Screen+0x6>,d0
    1e06:	movea.l d1,a2
    1e08:	adda.l d0,a2
	WaitBlit();
    1e0a:	movea.l 238ce <GfxBase>,a6
    1e10:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    1e14:	movea.l 238d8 <custom>,a5
    1e1a:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
    1e20:	move.w #0,66(a5)
	custom->bltafwm = 0xffff;
    1e26:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    1e2c:	move.w #-1,70(a5)
	custom->bltapt = bmpFontP + source;
    1e32:	addi.l #37066,d3
    1e38:	move.l d3,80(a5)
	custom->bltdpt = bmpDestP + dest;
    1e3c:	adda.l 126(sp),a2
    1e40:	move.l a2,84(a5)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    1e44:	subq.w #4,d6
    1e46:	move.w d6,100(a5)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    1e4a:	subq.w #4,d5
    1e4c:	move.w d5,102(a5)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    1e50:	moveq #11,d6
    1e52:	lsl.w d6,d4
    1e54:	addq.w #2,d4
    1e56:	move.w d4,88(a5)
    1e5a:	bra.w 1810 <main+0x179c>
		ScrollerPause = (Scrolltext[ScrolltextCnt++] - 48) * 50;
    1e5e:	move.w 236d2 <ScrolltextCnt>,d0
    1e64:	moveq #0,d3
    1e66:	move.w d0,d3
    1e68:	lea 4698 <Scrolltext>,a2
    1e6e:	move.b (0,a2,d3.l),d3
    1e72:	ext.w d3
    1e74:	addi.w #-48,d3
    1e78:	muls.w #50,d3
    1e7c:	move.w d3,236de <ScrollerPause>
		chr = Scrolltext[ScrolltextCnt++];
    1e82:	move.w d0,d3
    1e84:	addq.w #2,d3
    1e86:	move.w d3,236d2 <ScrolltextCnt>
		ScrollerPause = (Scrolltext[ScrolltextCnt++] - 48) * 50;
    1e8c:	addq.w #1,d0
		chr = Scrolltext[ScrolltextCnt++];
    1e8e:	andi.l #65535,d0
    1e94:	move.b (0,a2,d0.l),d0
	if (chr == 'c')
    1e98:	cmpi.b #99,d0
    1e9c:	bne.w 1750 <main+0x16dc>
		colScrollMirror[0] = 0x6bf;
    1ea0:	move.l #113181851,6000 <colScrollMirror>
		ResetCopper = TRUE;
    1eaa:	move.w #1,236e0 <ResetCopper>
    1eb2:	moveq #67,d0
	row = chr / 10;
    1eb4:	ext.w d0
    1eb6:	moveq #10,d3
    1eb8:	ext.l d0
    1eba:	divs.w d3,d0
    1ebc:	move.l d0,d3
    1ebe:	swap d3
    1ec0:	movea.w d3,a0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    1ec2:	clr.w d3
    1ec4:	move.b d0,d3
    1ec6:	move.w a1,d0
    1ec8:	mulu.w d0,d3
    1eca:	lsl.l #5,d3
    1ecc:	movea.l d3,a1
	col = chr % 10;
    1ece:	move.w a0,d3
    1ed0:	moveq #0,d0
    1ed2:	move.b d3,d0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    1ed4:	add.l d0,d0
    1ed6:	add.l d0,d0
    1ed8:	move.l a1,d3
    1eda:	add.l d0,d3
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    1edc:	mulu.w #40,d1
    1ee0:	moveq #0,d0
    1ee2:	move.w 2389e <Screen+0x6>,d0
    1ee8:	movea.l d1,a2
    1eea:	adda.l d0,a2
	WaitBlit();
    1eec:	movea.l 238ce <GfxBase>,a6
    1ef2:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    1ef6:	movea.l 238d8 <custom>,a5
    1efc:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
    1f02:	move.w #0,66(a5)
	custom->bltafwm = 0xffff;
    1f08:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    1f0e:	move.w #-1,70(a5)
	custom->bltapt = bmpFontP + source;
    1f14:	addi.l #37066,d3
    1f1a:	move.l d3,80(a5)
	custom->bltdpt = bmpDestP + dest;
    1f1e:	adda.l 126(sp),a2
    1f22:	move.l a2,84(a5)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    1f26:	subq.w #4,d6
    1f28:	move.w d6,100(a5)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    1f2c:	subq.w #4,d5
    1f2e:	move.w d5,102(a5)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    1f32:	moveq #11,d6
    1f34:	lsl.w d6,d4
    1f36:	addq.w #2,d4
    1f38:	move.w d4,88(a5)
    1f3c:	bra.w 1810 <main+0x179c>
		Exit(0);
    1f40:	movea.l 238ca <DOSBase>,a6
    1f46:	moveq #0,d1
    1f48:	jsr -144(a6)
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    1f4c:	movea.l 238d2 <SysBase>,a6
    1f52:	lea 45fe <incbin_P61_Player_end+0x12>,a1
    1f58:	moveq #0,d0
    1f5a:	jsr -552(a6)
    1f5e:	move.l d0,238ca <DOSBase>
	if (!DOSBase)
    1f64:	bne.w c2 <main+0x4e>
    1f68:	bra.w 1dbc <main+0x1d48>
	if (chr < 32 || chr > (32 + 80))
    1f6c:	addi.b #-32,d0
    1f70:	cmpi.b #80,d0
    1f74:	bls.w 1788 <main+0x1714>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    1f78:	move.w 236da <ScrollerY>,80(sp)
    1f80:	movea.w 80(sp),a0
    1f84:	move.w 23798 <BmpScroller+0x4>,130(sp)
    1f8c:	move.w 237cc <BmpUpperPart_Buf1+0x4>,110(sp)
    1f94:	move.w 237ce <BmpUpperPart_Buf1+0x6>,54(sp)
    1f9c:	move.l 237d6 <BmpUpperPart_Buf1+0xe>,56(sp)
    1fa4:	moveq #0,d4
    1fa6:	move.w 130(sp),d4
    1faa:	movea.l 236d6 <copScrollerBmpP>,a2
    1fb0:	moveq #0,d5
    1fb2:	move.w 2379a <BmpScroller+0x6>,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    1fb8:	move.l a0,-(sp)
    1fba:	move.l d5,-(sp)
    1fbc:	jsr 2aa8 <__mulsi3>
    1fc2:	addq.l #4,sp
    1fc4:	move.l d4,(sp)
    1fc6:	move.l d0,-(sp)
    1fc8:	jsr 2aa8 <__mulsi3>
    1fce:	addq.l #8,sp
    1fd0:	add.l 126(sp),d0
        addr += Bpl;
    1fd4:	move.w #224,d1
    for (USHORT i = 0; i < numPlanes; i++)
    1fd8:	tst.l d4
    1fda:	bne.w bf4 <main+0xb80>
    1fde:	bra.w c1c <main+0xba8>
	APTR vbr = 0;
    1fe2:	moveq #0,d0
	VBR = GetVBR();
    1fe4:	move.l d0,236f0 <VBR>
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
    1fea:	movea.l 236f0 <VBR>,a0
    1ff0:	move.l 108(a0),d0
	SystemIrq = GetInterruptHandler(); //store interrupt register
    1ff4:	move.l d0,236ec <SystemIrq>
	WaitVbl();
    1ffa:	jsr 2116 <WaitVbl>
	SetupCopper(copPtr);
    2000:	move.l 236f4 <copPtr>,d2
    2006:	move.l d2,-(sp)
    2008:	jsr 215c <SetupCopper>
	custom->cop1lc = (ULONG)copPtr;
    200e:	movea.l 238d8 <custom>,a0
    2014:	move.l d2,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    2018:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
    201e:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    2024:	move.w #-30752,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
    202a:	movea.l 236f0 <VBR>,a1
    2030:	move.l #8404,108(a1)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
    2038:	move.w #-16352,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
    203e:	move.w #32,156(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
    2044:	move.w #-24576,154(a0)
	register volatile const void *_a0 ASM("a0") = module;
    204a:	lea 1f8d0 <incbin_module_start>,a0
	register volatile const void *_a1 ASM("a1") = NULL;
    2050:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
    2052:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
    2054:	lea 2c86 <incbin_P61_Player_start>,a3
	__asm volatile(
    205a:	movem.l d1-d7/a4-a6,-(sp)
    205e:	jsr (a3)
    2060:	movem.l (sp)+,d1-d7/a4-a6
	if (p61Init(module) != 0)
    2064:	addq.l #4,sp
    2066:	tst.l d0
    2068:	beq.w 8e6 <main+0x872>
    206c:	bra.w 1cee <main+0x1c7a>
				ScrollerDir -= 1;
    2070:	move.b d0,6006 <ScrollerDir>
			ScrollerY += ScrollerDir;
    2076:	ext.w d0
    2078:	add.w d0,80(sp)
    207c:	move.w 80(sp),236da <ScrollerY>
    2084:	bra.w b90 <main+0xb1c>
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
    2088:	movea.w d1,a2
    208a:	adda.w d1,a2
    208c:	sub.w a2,d3
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    208e:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    2092:	move.w d3,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    2096:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    209c:	move.w d3,6(a0)
		MirrorEnabled = !MirrorEnabled;
    20a0:	tst.w d0
    20a2:	seq d0
    20a4:	ext.w d0
    20a6:	neg.w d0
    20a8:	move.w d0,236d0 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    20ae:	move.w 236d2 <ScrolltextCnt>,d0
    20b4:	movea.w d0,a2
    20b6:	addq.w #1,a2
    20b8:	move.w a2,236d2 <ScrolltextCnt>
    20be:	andi.l #65535,d0
    20c4:	lea 4698 <Scrolltext>,a0
    20ca:	move.b (0,a0,d0.l),d0
    20ce:	bra.w 1d68 <main+0x1cf4>
    20d2:	nop

000020d4 <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

static __attribute__((interrupt)) void interruptHandler()
{
    20d4:	movem.l d0/a0/a3/a6,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    20d8:	movea.l 238d8 <custom>,a0
    20de:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    20e4:	move.w #32,156(a0)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    20ea:	lea 2c86 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    20f0:	movea.l #14675968,a6
	__asm volatile(
    20f6:	movem.l d0-a2/a4-a5,-(sp)
    20fa:	jsr 4(a3)
    20fe:	movem.l (sp)+,d0-a2/a4-a5

    // DEMO - ThePlayer
    p61Music();

    // DEMO - increment frameCounter
    frameCounter++;
    2102:	move.w 238d6 <frameCounter>,d0
    2108:	addq.w #1,d0
    210a:	move.w d0,238d6 <frameCounter>
}
    2110:	movem.l (sp)+,d0/a0/a3/a6
    2114:	rte

00002116 <WaitVbl>:
{
    2116:	subq.l #8,sp
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    2118:	move.l dff004 <_end+0xddb728>,d0
    211e:	move.l d0,(sp)
		vpos &= 0x1ff00;
    2120:	move.l (sp),d0
    2122:	andi.l #130816,d0
    2128:	move.l d0,(sp)
		if (vpos != (311 << 8))
    212a:	move.l (sp),d0
    212c:	cmpi.l #79616,d0
    2132:	beq.s 2118 <WaitVbl+0x2>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    2134:	move.l dff004 <_end+0xddb728>,d0
    213a:	move.l d0,4(sp)
		vpos &= 0x1ff00;
    213e:	move.l 4(sp),d0
    2142:	andi.l #130816,d0
    2148:	move.l d0,4(sp)
		if (vpos == (311 << 8))
    214c:	move.l 4(sp),d0
    2150:	cmpi.l #79616,d0
    2156:	bne.s 2134 <WaitVbl+0x1e>
}
    2158:	addq.l #8,sp
    215a:	rts

0000215c <SetupCopper>:
{
    215c:	movem.l d2-d7/a2,-(sp)
    2160:	movea.l 32(sp),a1
	*copPtr++ = DIWSTRT;
    2164:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
    2168:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
    216e:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
    2174:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
    217a:	move.w #146,8(a1)
	*copPtr++ = 0x38; // + ((Screen.Width - BmpLogo.Width) / 4);
    2180:	move.w #56,10(a1)
	*copPtr++ = DDFSTOP;
    2186:	move.w #148,12(a1)
	*copPtr++ = 0xd0; // - ((Screen.Width - BmpLogo.Width) / 4);
    218c:	move.w #208,14(a1)
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl);
    2192:	move.w 23836 <BmpUpperPart_PF1+0x6>,d4
    2198:	move.w 23838 <BmpUpperPart_PF1+0x8>,d0
    219e:	sub.w d4,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    21a0:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
    21a6:	move.w d0,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    21aa:	move.w #266,20(a1)
    *copListEnd++ = modEven;
    21b0:	move.w d0,22(a1)
	*copPtr++ = BPLCON1; //scrolling
    21b4:	move.w #258,24(a1)
	*copPtr++ = 0;
    21ba:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
    21be:	move.w #260,28(a1)
	*copPtr++ = 1 << 6;	 //0x24;  Sprites have priority over playfields
    21c4:	move.w #64,30(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    21ca:	move.w #384,32(a1)
    *copListCurrent++ = color;
    21d0:	move.w #21,34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    21d6:	move.w #398,36(a1)
    *copListCurrent++ = color;
    21dc:	move.w #21,38(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    21e2:	move.w #386,40(a1)
    *copListCurrent++ = color;
    21e8:	move.w #1366,42(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    21ee:	move.w #388,44(a1)
    *copListCurrent++ = color;
    21f4:	move.w #3221,46(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    21fa:	move.w #390,48(a1)
    *copListCurrent++ = color;
    2200:	move.w #3750,50(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2206:	move.w #392,52(a1)
    *copListCurrent++ = color;
    220c:	move.w #1074,54(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2212:	move.w #394,56(a1)
    *copListCurrent++ = color;
    2218:	move.w #1329,58(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    221e:	move.w #396,60(a1)
    *copListCurrent++ = color;
    2224:	move.w #530,62(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    222a:	move.w #398,64(a1)
    *copListCurrent++ = color;
    2230:	move.w #2177,66(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2236:	move.w #400,68(a1)
    *copListCurrent++ = color;
    223c:	clr.w 70(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2240:	move.w #402,72(a1)
    *copListCurrent++ = color;
    2246:	move.w #102,74(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    224c:	move.w #404,76(a1)
    *copListCurrent++ = color;
    2252:	move.w #119,78(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2258:	move.w #406,80(a1)
    *copListCurrent++ = color;
    225e:	move.w #136,82(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2264:	move.w #408,84(a1)
    *copListCurrent++ = color;
    226a:	move.w #169,86(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2270:	move.w #410,88(a1)
    *copListCurrent++ = color;
    2276:	move.w #187,90(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    227c:	move.w #412,92(a1)
    *copListCurrent++ = color;
    2282:	move.w #204,94(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2288:	move.w #414,96(a1)
    *copListCurrent++ = color;
    228e:	lea 100(a1),a0
    2292:	move.w #221,98(a1)
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
    2298:	move.w 23834 <BmpUpperPart_PF1+0x4>,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    229e:	move.l 2383e <BmpUpperPart_PF1+0xe>,d1
    for (USHORT i = 0; i < numPlanes; i++)
    22a4:	tst.w d5
    22a6:	beq.s 22f6 <SetupCopper+0x19a>
        addr += Bpl;
    22a8:	andi.l #65535,d4
    22ae:	move.w d5,d0
    22b0:	subq.w #1,d0
    22b2:	andi.l #65535,d0
    22b8:	lsl.l #3,d0
    22ba:	lea (108,a1,d0.l),a2
    *copListCurrent++ = color;
    22be:	movea.l a0,a1
    BYTE plane = odd ? 1 : 0;
    22c0:	clr.b d2
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
    22c2:	move.b d2,d0
    22c4:	ext.w d0
    22c6:	lsl.w #2,d0
    22c8:	addi.w #224,d0
    22cc:	move.w d0,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    22ce:	move.l d1,d3
    22d0:	clr.w d3
    22d2:	swap d3
    22d4:	move.w d3,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
    22d8:	addq.w #2,d0
    22da:	move.w d0,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    22de:	addq.l #8,a1
    22e0:	move.w d1,-2(a1)
        addr += Bpl;
    22e4:	add.l d4,d1
        plane += 2;
    22e6:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
    22e8:	cmpa.l a2,a1
    22ea:	bne.s 22c2 <SetupCopper+0x166>
        *copListEnd++ = (UWORD)addr; // high-word of adress
    22ec:	andi.l #65535,d5
    22f2:	lsl.l #3,d5
    22f4:	adda.l d5,a0
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
    22f6:	move.w 23802 <BmpUpperPart_PF2+0x6>,d4
    22fc:	move.w 23800 <BmpUpperPart_PF2+0x4>,d0
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    2302:	move.l 2380a <BmpUpperPart_PF2+0xe>,d1
    for (USHORT i = 0; i < numPlanes; i++)
    2308:	tst.w d0
    230a:	beq.s 234a <SetupCopper+0x1ee>
        addr += Bpl;
    230c:	andi.l #65535,d4
    2312:	andi.l #65535,d0
    2318:	lsl.l #3,d0
    231a:	lea (0,a0,d0.l),a1
    BYTE plane = odd ? 1 : 0;
    231e:	moveq #1,d2
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
    2320:	move.b d2,d0
    2322:	ext.w d0
    2324:	lsl.w #2,d0
    2326:	addi.w #224,d0
    232a:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    232c:	move.l d1,d3
    232e:	clr.w d3
    2330:	swap d3
    2332:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
    2336:	addq.w #2,d0
    2338:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    233c:	addq.l #8,a0
    233e:	move.w d1,-2(a0)
        addr += Bpl;
    2342:	add.l d4,d1
        plane += 2;
    2344:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
    2346:	cmpa.l a1,a0
    2348:	bne.s 2320 <SetupCopper+0x1c4>
	*copPtr++ = SPR0PTH;
    234a:	move.w #288,(a0)
	*copPtr++ = (LONG)StarSprite >> 16;
    234e:	move.l #144352,d0
    2354:	move.l d0,d1
    2356:	swap d1
    2358:	ext.l d1
    235a:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
    235e:	move.w #290,4(a0)
	*copPtr++ = (LONG)StarSprite;
    2364:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
    2368:	move.w #292,8(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
    236e:	move.l #144340,d0
    2374:	move.l d0,d1
    2376:	swap d1
    2378:	ext.l d1
    237a:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
    237e:	move.w #294,12(a0)
	*copPtr++ = (LONG)NullSprite;
    2384:	move.w d0,14(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2388:	move.w #418,16(a0)
    *copListCurrent++ = color;
    238e:	move.w #4095,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2394:	move.w #420,20(a0)
    *copListCurrent++ = color;
    239a:	move.w #1103,22(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    23a0:	move.w #422,24(a0)
    *copListCurrent++ = color;
    23a6:	move.w #2190,26(a0)
	*copPtr++ = SPR2PTH;
    23ac:	move.w #296,28(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
    23b2:	move.w d1,30(a0)
	*copPtr++ = SPR2PTL;
    23b6:	move.w #298,32(a0)
	*copPtr++ = (LONG)NullSprite;
    23bc:	move.w d0,34(a0)
	*copPtr++ = SPR3PTH;
    23c0:	move.w #300,36(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
    23c6:	move.w d1,38(a0)
	*copPtr++ = SPR3PTL;
    23ca:	move.w #302,40(a0)
	*copPtr++ = (LONG)NullSprite;
    23d0:	move.w d0,42(a0)
	*copPtr++ = SPR4PTH;
    23d4:	move.w #304,44(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
    23da:	move.w d1,46(a0)
	*copPtr++ = SPR4PTL;
    23de:	move.w #306,48(a0)
	*copPtr++ = (LONG)NullSprite;
    23e4:	move.w d0,50(a0)
	*copPtr++ = SPR5PTH;
    23e8:	move.w #308,52(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
    23ee:	move.w d1,54(a0)
	*copPtr++ = SPR5PTL;
    23f2:	move.w #310,56(a0)
	*copPtr++ = (LONG)NullSprite;
    23f8:	move.w d0,58(a0)
	*copPtr++ = SPR6PTH;
    23fc:	move.w #312,60(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
    2402:	move.w d1,62(a0)
	*copPtr++ = SPR6PTL;
    2406:	move.w #314,64(a0)
	*copPtr++ = (LONG)NullSprite;
    240c:	move.w d0,66(a0)
	*copPtr++ = SPR7PTH;
    2410:	move.w #316,68(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
    2416:	move.w d1,70(a0)
	*copPtr++ = SPR7PTL;
    241a:	move.w #318,72(a0)
	*copPtr++ = (LONG)NullSprite;
    2420:	move.w d0,74(a0)
	*copPtr++ = BPLCON0;
    2424:	move.w #256,76(a0)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
    242a:	moveq #0,d7
    242c:	move.w 23868 <BmpLogo+0x4>,d7
    2432:	move.l d7,d0
    2434:	moveq #13,d1
    2436:	lsl.l d1,d0
    2438:	ori.w #1536,d0
    243c:	move.w d0,78(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    2440:	move.w #7173,80(a0)
    *copListEnd++ = COP_WAIT;
    2446:	move.w #-2,82(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    244c:	move.w #384,84(a0)
    *copListCurrent++ = color;
    2452:	move.w #21,86(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2458:	move.w #398,88(a0)
    *copListCurrent++ = color;
    245e:	move.w #21,90(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    2464:	move.w #7429,92(a0)
    *copListEnd++ = COP_WAIT;
    246a:	move.w #-2,94(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2470:	move.w #384,96(a0)
    *copListCurrent++ = color;
    2476:	move.w #22,98(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    247c:	move.w #398,100(a0)
    *copListCurrent++ = color;
    2482:	move.w #22,102(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    2488:	move.w #7685,104(a0)
    *copListEnd++ = COP_WAIT;
    248e:	move.w #-2,106(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2494:	move.w #384,108(a0)
    *copListCurrent++ = color;
    249a:	move.w #22,110(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    24a0:	move.w #398,112(a0)
    *copListCurrent++ = color;
    24a6:	move.w #22,114(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    24ac:	move.w #7941,116(a0)
    *copListEnd++ = COP_WAIT;
    24b2:	move.w #-2,118(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    24b8:	move.w #384,120(a0)
    *copListCurrent++ = color;
    24be:	move.w #22,122(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    24c4:	move.w #398,124(a0)
    *copListCurrent++ = color;
    24ca:	move.w #22,126(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    24d0:	move.w #8197,128(a0)
    *copListEnd++ = COP_WAIT;
    24d6:	move.w #-2,130(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    24dc:	move.w #384,132(a0)
    *copListCurrent++ = color;
    24e2:	move.w #38,134(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    24e8:	move.w #398,136(a0)
    *copListCurrent++ = color;
    24ee:	move.w #38,138(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    24f4:	move.w #8453,140(a0)
    *copListEnd++ = COP_WAIT;
    24fa:	move.w #-2,142(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2500:	move.w #384,144(a0)
    *copListCurrent++ = color;
    2506:	move.w #39,146(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    250c:	move.w #398,148(a0)
    *copListCurrent++ = color;
    2512:	move.w #39,150(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    2518:	move.w #8709,152(a0)
    *copListEnd++ = COP_WAIT;
    251e:	move.w #-2,154(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2524:	move.w #384,156(a0)
    *copListCurrent++ = color;
    252a:	move.w #39,158(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2530:	move.w #398,160(a0)
    *copListCurrent++ = color;
    2536:	move.w #39,162(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    253c:	move.w #8965,164(a0)
    *copListEnd++ = COP_WAIT;
    2542:	move.w #-2,166(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2548:	move.w #384,168(a0)
    *copListCurrent++ = color;
    254e:	move.w #21,170(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2554:	move.w #398,172(a0)
    *copListCurrent++ = color;
    255a:	move.w #21,174(a0)
	line = 0x2c + BmpUpperPart_PF1.Height;
    2560:	move.b 23833 <BmpUpperPart_PF1+0x3>,d4
    2566:	move.b d4,d0
    2568:	addi.b #44,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    256c:	lsl.w #8,d0
    256e:	ori.w #5,d0
    2572:	move.w d0,176(a0)
    *copListEnd++ = COP_WAIT;
    2576:	move.w #-2,178(a0)
	*copPtr++ = BPLCON0;
    257c:	move.w #256,180(a0)
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
    2582:	move.w #512,182(a0)
	copPtr = copWaitY(copPtr, line++);
    2588:	move.b d4,d2
    258a:	addi.b #53,d2
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
    258e:	move.b d4,d0
    2590:	addi.b #52,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    2594:	lsl.w #8,d0
    2596:	ori.w #5,d0
    259a:	move.w d0,184(a0)
    *copListEnd++ = COP_WAIT;
    259e:	lea 188(a0),a2
    25a2:	move.w #-2,186(a0)
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
    25a8:	move.l a2,236d6 <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
    25ae:	move.w 2379a <BmpScroller+0x6>,d5
    25b4:	move.w 23798 <BmpScroller+0x4>,d6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    25ba:	move.l 237a2 <BmpScroller+0xe>,d0
    for (USHORT i = 0; i < numPlanes; i++)
    25c0:	tst.w d6
    25c2:	beq.s 2610 <SetupCopper+0x4b4>
        addr += Bpl;
    25c4:	andi.l #65535,d5
    25ca:	move.w d6,d1
    25cc:	subq.w #1,d1
    25ce:	andi.l #65535,d1
    25d4:	lsl.l #3,d1
    25d6:	addi.l #196,d1
    25dc:	adda.l d1,a0
    25de:	movea.l a2,a1
    25e0:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
    25e4:	move.w d1,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    25e6:	move.l d0,d3
    25e8:	clr.w d3
    25ea:	swap d3
    25ec:	move.w d3,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
    25f0:	move.w d1,d3
    25f2:	addq.w #2,d3
    25f4:	move.w d3,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    25f8:	addq.l #8,a1
    25fa:	move.w d0,-2(a1)
        addr += Bpl;
    25fe:	add.l d5,d0
    for (USHORT i = 0; i < numPlanes; i++)
    2600:	addq.w #4,d1
    2602:	cmpa.l a0,a1
    2604:	bne.s 25e4 <SetupCopper+0x488>
        *copListEnd++ = (UWORD)addr; // high-word of adress
    2606:	andi.l #65535,d6
    260c:	lsl.l #3,d6
    260e:	adda.l d6,a2
						  BmpScroller.Bplt - Screen.Bpl);
    2610:	move.w 2379c <BmpScroller+0x8>,d0
    2616:	sub.w 2389e <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    261c:	move.w #264,(a2)
    *copListEnd++ = modOdd;
    2620:	move.w d0,2(a2)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    2624:	move.w #266,4(a2)
    *copListEnd++ = modEven;
    262a:	move.w d0,6(a2)
	*copPtr++ = BPLCON0;
    262e:	move.w #256,8(a2)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
    2634:	moveq #12,d0
    2636:	lsl.l d0,d7
    2638:	ori.w #512,d7
    263c:	move.w d7,10(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2640:	move.w #386,12(a2)
    *copListCurrent++ = color;
    2646:	move.w #2288,14(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    264c:	move.w #388,16(a2)
    *copListCurrent++ = color;
    2652:	move.w #1776,18(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2658:	move.w #390,20(a2)
    *copListCurrent++ = color;
    265e:	move.w #1008,22(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2664:	move.w #392,24(a2)
    *copListCurrent++ = color;
    266a:	move.w #496,26(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2670:	move.w #394,28(a2)
    *copListCurrent++ = color;
    2676:	move.w #241,30(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    267c:	move.w #396,32(a2)
    *copListCurrent++ = color;
    2682:	move.w #244,34(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2688:	move.w #398,36(a2)
    *copListCurrent++ = color;
    268e:	lea 40(a2),a0
    2692:	move.w #246,38(a2)
	for (int l = 0; l < 24; l++)
    2698:	lea 4648 <colgradbluePaletteRGB4>,a1
    269e:	move.w a1,d1
    26a0:	sub.b d1,d2
		copPtr = copWaitY(copPtr, line);
    26a2:	move.w a1,d0
    26a4:	add.b d2,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    26a6:	lsl.w #8,d0
    26a8:	ori.w #5,d0
    26ac:	move.w d0,(a0)
    *copListEnd++ = COP_WAIT;
    26ae:	move.w #-2,2(a0)
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
    26b4:	move.w (a1)+,d0
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    26b6:	move.w #384,4(a0)
    *copListCurrent++ = color;
    26bc:	addq.l #8,a0
    26be:	move.w d0,-2(a0)
	for (int l = 0; l < 24; l++)
    26c2:	cmpa.l #18040,a1
    26c8:	bne.s 26a2 <SetupCopper+0x546>
		line += 2;
    26ca:	move.b d4,d0
    26cc:	addi.b #101,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    26d0:	lsl.w #8,d0
    26d2:	ori.w #5,d0
    26d6:	move.w d0,232(a2)
    *copListEnd++ = COP_WAIT;
    26da:	move.w #-2,234(a2)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
    26e0:	move.w 6000 <colScrollMirror>,d1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    26e6:	move.w #384,236(a2)
    *copListCurrent++ = color;
    26ec:	move.w d1,238(a2)
	copPtr = copWaitY(copPtr, line++);
    26f0:	move.b d4,d0
    26f2:	addi.b #102,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    26f6:	lsl.w #8,d0
    26f8:	ori.w #5,d0
    26fc:	move.w d0,240(a2)
    *copListEnd++ = COP_WAIT;
    2700:	move.w #-2,242(a2)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
    2706:	move.w 6002 <colScrollMirror+0x2>,d0
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    270c:	move.w #384,244(a2)
    *copListCurrent++ = color;
    2712:	move.w d0,246(a2)
	line += 7;
    2716:	move.b d4,d2
    2718:	addi.b #110,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    271c:	lsl.w #8,d2
    271e:	ori.w #5,d2
    2722:	move.w d2,248(a2)
    *copListEnd++ = COP_WAIT;
    2726:	move.w #-2,250(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    272c:	move.w #384,252(a2)
    *copListCurrent++ = color;
    2732:	move.w d1,254(a2)
	copPtr = copWaitY(copPtr, line++);
    2736:	addi.b #111,d4
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    273a:	lsl.w #8,d4
    273c:	ori.w #5,d4
    2740:	move.w d4,256(a2)
    *copListEnd++ = COP_WAIT;
    2744:	move.w #-2,258(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    274a:	move.w #384,260(a2)
    *copListCurrent++ = color;
    2750:	move.w d0,262(a2)
	line = 0x2c + BmpLogo.Height + 72 + 7; // 209
    2754:	move.b 23867 <BmpLogo+0x3>,d2
    275a:	addi.b #123,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    275e:	lsl.w #8,d2
    2760:	ori.w #5,d2
    2764:	move.w d2,264(a2)
    *copListEnd++ = COP_WAIT;
    2768:	move.w #-2,266(a2)
    276e:	lea 268(a2),a0
    2772:	move.l a0,236cc <copMirrorBmpP>
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
    2778:	movea.w 2386c <BmpLogo+0x8>,a0
    277e:	suba.w 2386a <BmpLogo+0x6>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    2784:	move.w #264,268(a2)
    *copListEnd++ = modOdd;
    278a:	move.w a0,270(a2)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    278e:	move.w #266,272(a2)
    *copListEnd++ = modEven;
    2794:	move.w a0,274(a2)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    2798:	move.w #-31,276(a2)
    *copListEnd++ = COP_WAIT;
    279e:	move.w #-2,278(a2)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    27a4:	move.w #1285,280(a2)
    *copListEnd++ = COP_WAIT;
    27aa:	move.w #-2,282(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    27b0:	move.w #384,284(a2)
    *copListCurrent++ = color;
    27b6:	move.w d1,286(a2)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    27ba:	move.w #1541,288(a2)
    *copListEnd++ = COP_WAIT;
    27c0:	move.w #-2,290(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    27c6:	move.w #384,292(a2)
    *copListCurrent++ = color;
    27cc:	move.w d0,294(a2)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    27d0:	move.w #11269,296(a2)
    *copListEnd++ = COP_WAIT;
    27d6:	move.w #-2,298(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    27dc:	move.w #384,300(a2)
    *copListCurrent++ = color;
    27e2:	move.w d1,302(a2)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    27e6:	move.w #11525,304(a2)
    *copListEnd++ = COP_WAIT;
    27ec:	move.w #-2,306(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    27f2:	move.w #384,308(a2)
    *copListCurrent++ = color;
    27f8:	move.w d0,310(a2)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    27fc:	move.w #-1,312(a2)
    *copListEnd++ = COP_WAIT;
    2802:	move.w #-2,314(a2)
}
    2808:	movem.l (sp)+,d2-d7/a2
    280c:	rts

0000280e <KPrintF>:
void KPrintF(const char* fmt, ...) {
    280e:	lea -128(sp),sp
    2812:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    2816:	move.w f0ff60 <_end+0xeec684>,d0
    281c:	cmpi.w #20153,d0
    2820:	beq.s 284c <KPrintF+0x3e>
    2822:	cmpi.w #-24562,d0
    2826:	beq.s 284c <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    2828:	movea.l 238d2 <SysBase>,a6
    282e:	movea.l 144(sp),a0
    2832:	lea 148(sp),a1
    2836:	lea 2ba2 <KPutCharX>,a2
    283c:	suba.l a3,a3
    283e:	jsr -522(a6)
}
    2842:	movem.l (sp)+,a2-a3/a6
    2846:	lea 128(sp),sp
    284a:	rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    284c:	movea.l 238d2 <SysBase>,a6
    2852:	movea.l 144(sp),a0
    2856:	lea 148(sp),a1
    285a:	lea 2bb0 <PutChar>,a2
    2860:	lea 12(sp),a3
    2864:	jsr -522(a6)
		UaeDbgLog(86, temp);
    2868:	move.l a3,-(sp)
    286a:	pea 56 <_start+0x56>
    286e:	jsr f0ff60 <_end+0xeec684>
    2874:	addq.l #8,sp
}
    2876:	movem.l (sp)+,a2-a3/a6
    287a:	lea 128(sp),sp
    287e:	rts

00002880 <strlen>:
unsigned long strlen(const char* s) {
    2880:	movea.l 4(sp),a0
	unsigned long t=0;
    2884:	moveq #0,d0
	while(*s++)
    2886:	tst.b (a0)
    2888:	beq.s 2892 <strlen+0x12>
		t++;
    288a:	addq.l #1,d0
	while(*s++)
    288c:	tst.b (0,a0,d0.l)
    2890:	bne.s 288a <strlen+0xa>
}
    2892:	rts

00002894 <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    2894:	movem.l d2-d7/a2-a3,-(sp)
    2898:	move.l 36(sp),d0
    289c:	move.l 40(sp),d4
    28a0:	movea.l 44(sp),a1
	while(len-- > 0)
    28a4:	move.l a1,d5
    28a6:	subq.l #1,d5
    28a8:	cmpa.w #0,a1
    28ac:	beq.w 295c <memset+0xc8>
		*ptr++ = val;
    28b0:	move.b d4,d7
    28b2:	move.l d0,d1
    28b4:	neg.l d1
    28b6:	moveq #3,d2
    28b8:	and.l d2,d1
    28ba:	moveq #5,d6
    28bc:	movea.l d0,a2
    28be:	cmp.l d5,d6
    28c0:	bcc.s 292c <memset+0x98>
    28c2:	tst.l d1
    28c4:	beq.s 28ea <memset+0x56>
    28c6:	move.b d4,(a2)+
	while(len-- > 0)
    28c8:	subq.l #1,d5
    28ca:	moveq #1,d2
    28cc:	cmp.l d1,d2
    28ce:	beq.s 28ea <memset+0x56>
		*ptr++ = val;
    28d0:	movea.l d0,a2
    28d2:	addq.l #2,a2
    28d4:	movea.l d0,a0
    28d6:	move.b d4,1(a0)
	while(len-- > 0)
    28da:	subq.l #1,d5
    28dc:	moveq #3,d2
    28de:	cmp.l d1,d2
    28e0:	bne.s 28ea <memset+0x56>
		*ptr++ = val;
    28e2:	addq.l #1,a2
    28e4:	move.b d4,2(a0)
	while(len-- > 0)
    28e8:	subq.l #1,d5
    28ea:	move.l a1,d3
    28ec:	sub.l d1,d3
    28ee:	moveq #0,d6
    28f0:	move.b d4,d6
    28f2:	move.l d6,d2
    28f4:	swap d2
    28f6:	clr.w d2
    28f8:	movea.l d2,a0
    28fa:	move.l d4,d2
    28fc:	lsl.w #8,d2
    28fe:	swap d2
    2900:	clr.w d2
    2902:	lsl.l #8,d6
    2904:	movea.l d6,a3
    2906:	move.l a0,d6
    2908:	or.l d6,d2
    290a:	move.l a3,d6
    290c:	or.l d6,d2
    290e:	move.b d7,d2
    2910:	movea.l d0,a0
    2912:	adda.l d1,a0
    2914:	moveq #-4,d1
    2916:	and.l d3,d1
    2918:	add.l a0,d1
		*ptr++ = val;
    291a:	move.l d2,(a0)+
	while(len-- > 0)
    291c:	cmpa.l d1,a0
    291e:	bne.s 291a <memset+0x86>
    2920:	moveq #-4,d1
    2922:	and.l d3,d1
    2924:	adda.l d1,a2
    2926:	sub.l d1,d5
    2928:	cmp.l d3,d1
    292a:	beq.s 295c <memset+0xc8>
		*ptr++ = val;
    292c:	move.b d4,(a2)
	while(len-- > 0)
    292e:	tst.l d5
    2930:	beq.s 295c <memset+0xc8>
		*ptr++ = val;
    2932:	move.b d4,1(a2)
	while(len-- > 0)
    2936:	moveq #1,d1
    2938:	cmp.l d5,d1
    293a:	beq.s 295c <memset+0xc8>
		*ptr++ = val;
    293c:	move.b d4,2(a2)
	while(len-- > 0)
    2940:	moveq #2,d2
    2942:	cmp.l d5,d2
    2944:	beq.s 295c <memset+0xc8>
		*ptr++ = val;
    2946:	move.b d4,3(a2)
	while(len-- > 0)
    294a:	moveq #3,d6
    294c:	cmp.l d5,d6
    294e:	beq.s 295c <memset+0xc8>
		*ptr++ = val;
    2950:	move.b d4,4(a2)
	while(len-- > 0)
    2954:	subq.l #4,d5
    2956:	beq.s 295c <memset+0xc8>
		*ptr++ = val;
    2958:	move.b d4,5(a2)
}
    295c:	movem.l (sp)+,d2-d7/a2-a3
    2960:	rts

00002962 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    2962:	movem.l d2-d6,-(sp)
    2966:	move.l 24(sp),d0
    296a:	move.l 28(sp),d1
    296e:	move.l 32(sp),d3
	while(len--)
    2972:	move.l d3,d4
    2974:	subq.l #1,d4
    2976:	tst.l d3
    2978:	beq.s 29d8 <memcpy+0x76>
    297a:	movea.l d1,a0
    297c:	addq.l #1,a0
    297e:	move.l d0,d2
    2980:	sub.l a0,d2
    2982:	moveq #2,d5
    2984:	cmp.l d2,d5
    2986:	sc.s d2
    2988:	neg.b d2
    298a:	moveq #8,d6
    298c:	cmp.l d4,d6
    298e:	sc.s d5
    2990:	neg.b d5
    2992:	and.b d5,d2
    2994:	beq.s 29de <memcpy+0x7c>
    2996:	move.l d0,d2
    2998:	or.l d1,d2
    299a:	moveq #3,d5
    299c:	and.l d5,d2
    299e:	bne.s 29de <memcpy+0x7c>
    29a0:	movea.l d1,a0
    29a2:	movea.l d0,a1
    29a4:	moveq #-4,d2
    29a6:	and.l d3,d2
    29a8:	add.l d1,d2
		*d++ = *s++;
    29aa:	move.l (a0)+,(a1)+
	while(len--)
    29ac:	cmp.l a0,d2
    29ae:	bne.s 29aa <memcpy+0x48>
    29b0:	moveq #-4,d2
    29b2:	and.l d3,d2
    29b4:	movea.l d0,a0
    29b6:	adda.l d2,a0
    29b8:	add.l d2,d1
    29ba:	sub.l d2,d4
    29bc:	cmp.l d3,d2
    29be:	beq.s 29d8 <memcpy+0x76>
		*d++ = *s++;
    29c0:	movea.l d1,a1
    29c2:	move.b (a1),(a0)
	while(len--)
    29c4:	tst.l d4
    29c6:	beq.s 29d8 <memcpy+0x76>
		*d++ = *s++;
    29c8:	move.b 1(a1),1(a0)
	while(len--)
    29ce:	subq.l #1,d4
    29d0:	beq.s 29d8 <memcpy+0x76>
		*d++ = *s++;
    29d2:	move.b 2(a1),2(a0)
}
    29d8:	movem.l (sp)+,d2-d6
    29dc:	rts
    29de:	movea.l d0,a1
    29e0:	add.l d3,d1
		*d++ = *s++;
    29e2:	move.b -1(a0),(a1)+
	while(len--)
    29e6:	cmp.l a0,d1
    29e8:	beq.s 29d8 <memcpy+0x76>
    29ea:	addq.l #1,a0
    29ec:	bra.s 29e2 <memcpy+0x80>

000029ee <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    29ee:	movem.l d2-d5/a2,-(sp)
    29f2:	move.l 24(sp),d0
    29f6:	move.l 28(sp),d1
    29fa:	move.l 32(sp),d2
		while (len--)
    29fe:	movea.l d2,a1
    2a00:	subq.l #1,a1
	if (d < s) {
    2a02:	cmp.l d0,d1
    2a04:	bls.s 2a72 <memmove+0x84>
		while (len--)
    2a06:	tst.l d2
    2a08:	beq.s 2a6c <memmove+0x7e>
    2a0a:	movea.l d1,a2
    2a0c:	addq.l #1,a2
    2a0e:	move.l d0,d3
    2a10:	sub.l a2,d3
    2a12:	moveq #2,d4
    2a14:	cmp.l d3,d4
    2a16:	sc.s d3
    2a18:	neg.b d3
    2a1a:	moveq #8,d5
    2a1c:	cmp.l a1,d5
    2a1e:	sc.s d4
    2a20:	neg.b d4
    2a22:	and.b d4,d3
    2a24:	beq.s 2a96 <memmove+0xa8>
    2a26:	move.l d0,d3
    2a28:	or.l d1,d3
    2a2a:	moveq #3,d4
    2a2c:	and.l d4,d3
    2a2e:	bne.s 2a96 <memmove+0xa8>
    2a30:	movea.l d1,a0
    2a32:	movea.l d0,a2
    2a34:	moveq #-4,d3
    2a36:	and.l d2,d3
    2a38:	add.l d1,d3
			*d++ = *s++;
    2a3a:	move.l (a0)+,(a2)+
		while (len--)
    2a3c:	cmp.l a0,d3
    2a3e:	bne.s 2a3a <memmove+0x4c>
    2a40:	moveq #-4,d3
    2a42:	and.l d2,d3
    2a44:	movea.l d0,a2
    2a46:	adda.l d3,a2
    2a48:	movea.l d1,a0
    2a4a:	adda.l d3,a0
    2a4c:	suba.l d3,a1
    2a4e:	cmp.l d2,d3
    2a50:	beq.s 2a6c <memmove+0x7e>
			*d++ = *s++;
    2a52:	move.b (a0),(a2)
		while (len--)
    2a54:	cmpa.w #0,a1
    2a58:	beq.s 2a6c <memmove+0x7e>
			*d++ = *s++;
    2a5a:	move.b 1(a0),1(a2)
		while (len--)
    2a60:	moveq #1,d5
    2a62:	cmp.l a1,d5
    2a64:	beq.s 2a6c <memmove+0x7e>
			*d++ = *s++;
    2a66:	move.b 2(a0),2(a2)
}
    2a6c:	movem.l (sp)+,d2-d5/a2
    2a70:	rts
		const char *lasts = s + (len - 1);
    2a72:	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    2a76:	adda.l d0,a1
		while (len--)
    2a78:	tst.l d2
    2a7a:	beq.s 2a6c <memmove+0x7e>
    2a7c:	move.l a0,d1
    2a7e:	sub.l d2,d1
			*lastd-- = *lasts--;
    2a80:	move.b (a0),(a1)
		while (len--)
    2a82:	subq.l #1,a0
    2a84:	subq.l #1,a1
    2a86:	cmp.l a0,d1
    2a88:	beq.s 2a6c <memmove+0x7e>
			*lastd-- = *lasts--;
    2a8a:	move.b (a0),(a1)
		while (len--)
    2a8c:	subq.l #1,a0
    2a8e:	subq.l #1,a1
    2a90:	cmp.l a0,d1
    2a92:	bne.s 2a80 <memmove+0x92>
    2a94:	bra.s 2a6c <memmove+0x7e>
    2a96:	movea.l d0,a1
    2a98:	add.l d2,d1
			*d++ = *s++;
    2a9a:	move.b -1(a2),(a1)+
		while (len--)
    2a9e:	cmp.l a2,d1
    2aa0:	beq.s 2a6c <memmove+0x7e>
    2aa2:	addq.l #1,a2
    2aa4:	bra.s 2a9a <memmove+0xac>
    2aa6:	nop

00002aa8 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    2aa8:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    2aac:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2ab0:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    2ab4:	mulu.w 8(sp),d1
	addw	d1, d0
    2ab8:	add.w d1,d0
	swap	d0
    2aba:	swap d0
	clrw	d0
    2abc:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2abe:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    2ac2:	mulu.w 10(sp),d1
	addl	d1, d0
    2ac6:	add.l d1,d0
	rts
    2ac8:	rts

00002aca <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    2aca:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    2acc:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    2ad0:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    2ad4:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    2ada:	bcc.s 2af2 <__udivsi3+0x28>
	movel	d0, d2
    2adc:	move.l d0,d2
	clrw	d2
    2ade:	clr.w d2
	swap	d2
    2ae0:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    2ae2:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    2ae4:	move.w d2,d0
	swap	d0
    2ae6:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    2ae8:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    2aec:	divu.w d1,d2
	movew	d2, d0
    2aee:	move.w d2,d0
	jra	6f
    2af0:	bra.s 2b22 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    2af2:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    2af4:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    2af6:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    2af8:	cmpi.l #65536,d1
	jcc	4b
    2afe:	bcc.s 2af4 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    2b00:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    2b02:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    2b08:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    2b0a:	mulu.w d0,d1
	swap	d2
    2b0c:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    2b0e:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    2b10:	swap d2
	tstw	d2		/* high part 17 bits? */
    2b12:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    2b14:	bne.s 2b20 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    2b16:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    2b18:	bcs.s 2b20 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    2b1a:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    2b1e:	bls.s 2b22 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    2b20:	subq.l #1,d0

6:	movel	sp@+, d2
    2b22:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    2b24:	rts

00002b26 <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    2b26:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    2b28:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    2b2a:	move.l 12(sp),d1
	jpl	1f
    2b2e:	bpl.s 2b34 <__divsi3+0xe>
	negl	d1
    2b30:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    2b32:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    2b34:	move.l 8(sp),d0
	jpl	2f
    2b38:	bpl.s 2b3e <__divsi3+0x18>
	negl	d0
    2b3a:	neg.l d0
	negb	d2
    2b3c:	neg.b d2

2:	movel	d1, sp@-
    2b3e:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2b40:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    2b42:	bsr.s 2aca <__udivsi3>
	addql	#8, sp
    2b44:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    2b46:	tst.b d2
	jpl	3f
    2b48:	bpl.s 2b4c <__divsi3+0x26>
	negl	d0
    2b4a:	neg.l d0

3:	movel	sp@+, d2
    2b4c:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    2b4e:	rts

00002b50 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    2b50:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    2b54:	move.l 4(sp),d0
	movel	d1, sp@-
    2b58:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2b5a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    2b5c:	bsr.s 2b26 <__divsi3>
	addql	#8, sp
    2b5e:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    2b60:	move.l 8(sp),d1
	movel	d1, sp@-
    2b64:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2b66:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    2b68:	bsr.w 2aa8 <__mulsi3>
	addql	#8, sp
    2b6c:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2b6e:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2b72:	sub.l d0,d1
	movel	d1, d0
    2b74:	move.l d1,d0
	rts
    2b76:	rts

00002b78 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    2b78:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    2b7c:	move.l 4(sp),d0
	movel	d1, sp@-
    2b80:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2b82:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    2b84:	bsr.w 2aca <__udivsi3>
	addql	#8, sp
    2b88:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    2b8a:	move.l 8(sp),d1
	movel	d1, sp@-
    2b8e:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2b90:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    2b92:	bsr.w 2aa8 <__mulsi3>
	addql	#8, sp
    2b96:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2b98:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2b9c:	sub.l d0,d1
	movel	d1, d0
    2b9e:	move.l d1,d0
	rts
    2ba0:	rts

00002ba2 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    2ba2:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    2ba4:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    2ba8:	jsr -516(a6)
    move.l (sp)+, a6
    2bac:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    2bae:	rts

00002bb0 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    2bb0:	move.b d0,(a3)+
	rts
    2bb2:	rts

00002bb4 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    2bb4:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    2bb6:	adda.l a0,a2
	move.l	a2,a3
    2bb8:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    2bba:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    2bbc:	moveq #56,d4
	moveq	#8,d5
    2bbe:	moveq #8,d5
	bra.s	.Lliteral
    2bc0:	bra.s 2c2a <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    2bc2:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    2bc4:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    2bc6:	dbf d1,2bc2 <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    2bca:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    2bcc:	bcc.s 2bd0 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    2bce:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    2bd0:	tst.w d0
    2bd2:	bne.s 2bdc <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    2bd4:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    2bd6:	bls.s 2c4e <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    2bd8:	move.w (a0)+,d0
    2bda:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    2bdc:	rol.l #6,d0
	move.w	d0,d1
    2bde:	move.w d0,d1
	and.w	d4,d1
    2be0:	and.w d4,d1
	eor.w	d1,d0
    2be2:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    2be4:	movem.w (2c48 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    2bea:	rol.l d2,d0
	and.w	d0,d3					|scaling
    2bec:	and.w d0,d3
	eor.w	d3,d0
    2bee:	eor.w d3,d0
	suba.w	d3,a4
    2bf0:	suba.w d3,a4
	adda.l	a1,a4
    2bf2:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    2bf4:	tst.w d0
    2bf6:	bne.s 2bfc <_doynaxdepack_asm+0x48>
    2bf8:	move.w (a0)+,d0
    2bfa:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    2bfc:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    2bfe:	beq.s 2c16 <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    2c00:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    2c02:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    2c04:	bpl.s 2c12 <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    2c06:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    2c08:	bpl.s 2c10 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    2c0a:	addx.b d1,d1
	lsl.l	#2,d0
    2c0c:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    2c0e:	bmi.s 2c0a <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    2c10:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    2c12:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    2c14:	bcc.s 2c18 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    2c16:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    2c18:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    2c1a:	dbf d1,2c16 <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    2c1e:	add.l d0,d0
	bcc.s	.Lmatch
    2c20:	bcc.s 2bd0 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    2c22:	tst.w d0
    2c24:	bne.s 2c2a <_doynaxdepack_asm+0x76>
    2c26:	move.w (a0)+,d0
    2c28:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    2c2a:	moveq #0,d1
	add.l	d0,d0
    2c2c:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    2c2e:	bcc.s 2bce <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    2c30:	bpl.s 2c38 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    2c32:	addx.b d1,d1
	lsl.l	#2,d0
    2c34:	lsl.l #2,d0
	bmi.s	.Llgetlen
    2c36:	bmi.s 2c32 <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    2c38:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    2c3a:	dbv.s d1,2bc2 <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    2c3e:	add.l d0,d0
	eor.w	d1,d0		
    2c40:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    2c42:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    2c44:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    2c46:	bra.s 2c3a <_doynaxdepack_asm+0x86>

00002c48 <doy_table>:
    2c48:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    2c58:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    2c68:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    2c78:	.............o
