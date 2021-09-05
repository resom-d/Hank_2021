
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
      14:	lea 6000 <NextPlot>,a2
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
      36:	lea 6000 <NextPlot>,a2
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
      5e:	lea 6000 <NextPlot>,a2
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
      74:	lea -140(sp),sp
      78:	movem.l d2-d7/a2-a6,-(sp)

	SysBase = *((struct ExecBase **)4UL);
      7c:	movea.l 4 <_start+0x4>,a6
      80:	move.l a6,23b86 <SysBase>
	custom = (struct Custom *)0xdff000;
      86:	move.l #14675968,23b8c <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
      90:	lea 448d <incbin_P61_Player_end+0x1>,a1
      96:	moveq #0,d0
      98:	jsr -552(a6)
      9c:	move.l d0,23b82 <GfxBase>
	if (!GfxBase)
      a2:	beq.w 2384 <main+0x2310>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
      a6:	movea.l 23b86 <SysBase>,a6
      ac:	lea 449e <incbin_P61_Player_end+0x12>,a1
      b2:	moveq #0,d0
      b4:	jsr -552(a6)
      b8:	move.l d0,23b7e <DOSBase>
	if (!DOSBase)
      be:	beq.w 23ac <main+0x2338>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      c2:	pea 44aa <incbin_P61_Player_end+0x1e>
      c8:	jsr 26b0 <KPrintF>
#endif

	Write(Output(), (APTR) "Hello console!\n", 15);
      ce:	movea.l 23b7e <DOSBase>,a6
      d4:	jsr -60(a6)
      d8:	movea.l 23b7e <DOSBase>,a6
      de:	move.l d0,d1
      e0:	move.l #17606,d2
      e6:	moveq #15,d3
      e8:	jsr -48(a6)
}

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{

	bmp->Width = w;
      ec:	move.l #20971776,23b4c <Screen>
      f6:	move.l #196648,23b50 <Screen+0x4>
	bmp->Height = h;
	bmp->Bpls = bpls;
	bmp->Bpl = w / 8;
	bmp->Bplt = w / 8 * bpls;
     100:	move.w #120,23b54 <Screen+0x8>
	bmp->Btot = w / 8 * h * bpls;
     108:	move.w #30720,23b58 <Screen+0xc>
	bmp->Width = w;
     110:	move.l #16777346,23b18 <BmpLogo>
     11a:	move.l #196640,23b1c <BmpLogo+0x4>
	bmp->Bplt = w / 8 * bpls;
     124:	move.w #96,23b20 <BmpLogo+0x8>
	bmp->Btot = w / 8 * h * bpls;
     12c:	move.w #12480,23b24 <BmpLogo+0xc>
	bmp->Width = w;
     134:	move.l #20971650,23ae4 <BmpUpperPart_PF1>
     13e:	move.l #196648,23ae8 <BmpUpperPart_PF1+0x4>
	bmp->Bplt = w / 8 * bpls;
     148:	move.w #120,23aec <BmpUpperPart_PF1+0x8>
	bmp->Btot = w / 8 * h * bpls;
     150:	move.w #15600,23af0 <BmpUpperPart_PF1+0xc>
	bmp->Width = w;
     158:	move.l #20971650,23ab0 <BmpUpperPart_PF2>
     162:	move.l #196648,23ab4 <BmpUpperPart_PF2+0x4>
	bmp->Bplt = w / 8 * bpls;
     16c:	move.w #120,23ab8 <BmpUpperPart_PF2+0x8>
	bmp->Btot = w / 8 * h * bpls;
     174:	move.w #15600,23abc <BmpUpperPart_PF2+0xc>
	bmp->Width = w;
     17c:	move.l #20971650,23a7c <BmpUpperPart_Buf1>
     186:	move.l #196648,23a80 <BmpUpperPart_Buf1+0x4>
	bmp->Bplt = w / 8 * bpls;
     190:	move.w #120,23a84 <BmpUpperPart_Buf1+0x8>
	bmp->Btot = w / 8 * h * bpls;
     198:	move.w #15600,23a88 <BmpUpperPart_Buf1+0xc>
	bmp->Width = w;
     1a0:	move.l #23068838,23a48 <BmpScroller>
     1aa:	move.l #196652,23a4c <BmpScroller+0x4>
	bmp->Bplt = w / 8 * bpls;
     1b4:	move.w #132,23a50 <BmpScroller+0x8>
	bmp->Btot = w / 8 * h * bpls;
     1bc:	move.w #21912,23a54 <BmpScroller+0xc>
	bmp->Width = w;
     1c4:	move.l #20971776,23a14 <BmpFont32>
     1ce:	move.l #196648,23a18 <BmpFont32+0x4>
	bmp->Bplt = w / 8 * bpls;
     1d8:	move.w #120,23a1c <BmpFont32+0x8>
	bmp->Btot = w / 8 * h * bpls;
     1e0:	move.w #30720,23a20 <BmpFont32+0xc>
	bmp->Width = w;
     1e8:	move.l #20971776,239e0 <BmpCookie>
     1f2:	move.l #196648,239e4 <BmpCookie+0x4>
	bmp->Bplt = w / 8 * bpls;
     1fc:	move.w #120,239e8 <BmpCookie+0x8>
	bmp->Btot = w / 8 * h * bpls;
     204:	move.w #30720,239ec <BmpCookie+0xc>
	bmp->Width = w;
     20c:	move.l #20971776,239ac <BmpCookieMask>
     216:	move.l #196648,239b0 <BmpCookieMask+0x4>
	bmp->Bplt = w / 8 * bpls;
     220:	move.w #120,239b4 <BmpCookieMask+0x8>
	bmp->Btot = w / 8 * h * bpls;
     228:	move.w #30720,239b8 <BmpCookieMask+0xc>
	copPtr = AllocMem(1024, MEMF_CHIP);
     230:	movea.l 23b86 <SysBase>,a6
     236:	move.l #1024,d0
     23c:	moveq #2,d1
     23e:	jsr -198(a6)
     242:	move.l d0,239a6 <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
     248:	movea.l 23b86 <SysBase>,a6
     24e:	moveq #0,d0
     250:	move.w 23a54 <BmpScroller+0xc>,d0
     256:	move.l #65538,d1
     25c:	jsr -198(a6)
     260:	move.l d0,23a56 <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
     266:	movea.l 23b86 <SysBase>,a6
     26c:	moveq #0,d0
     26e:	move.w 23af0 <BmpUpperPart_PF1+0xc>,d0
     274:	move.l #65538,d1
     27a:	jsr -198(a6)
     27e:	move.l d0,23af2 <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
     284:	movea.l 23b86 <SysBase>,a6
     28a:	moveq #0,d0
     28c:	move.w 23abc <BmpUpperPart_PF2+0xc>,d0
     292:	move.l #65538,d1
     298:	jsr -198(a6)
     29c:	move.l d0,23abe <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
     2a2:	movea.l 23b86 <SysBase>,a6
     2a8:	moveq #0,d0
     2aa:	move.w 23a88 <BmpUpperPart_Buf1+0xc>,d0
     2b0:	move.l #65538,d1
     2b6:	jsr -198(a6)
     2ba:	move.l d0,d1
     2bc:	move.l d0,23a8a <BmpUpperPart_Buf1+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
     2c2:	move.l #24580,23b26 <BmpLogo+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
     2cc:	move.l #37062,23a22 <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
     2d6:	move.l #67784,239ee <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
     2e0:	move.l #98506,239ba <BmpCookieMask+0xe>
	for (int p = 0; p < img->Bpls; p++)
     2ea:	moveq #0,d3
     2ec:	move.w 23ae8 <BmpUpperPart_PF1+0x4>,d3
     2f2:	addq.l #4,sp
     2f4:	tst.l d3
     2f6:	beq.w 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2fa:	movea.l 23af2 <BmpUpperPart_PF1+0xe>,a0
     300:	moveq #0,d2
     302:	move.w 23aea <BmpUpperPart_PF1+0x6>,d2
     308:	move.l a0,23af6 <BmpUpperPart_PF1+0x12>
	for (int p = 0; p < img->Bpls; p++)
     30e:	moveq #1,d0
     310:	cmp.l d3,d0
     312:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     314:	lea (0,a0,d2.l),a1
     318:	move.l a1,23afa <BmpUpperPart_PF1+0x16>
	for (int p = 0; p < img->Bpls; p++)
     31e:	moveq #2,d0
     320:	cmp.l d3,d0
     322:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     324:	move.l d2,d0
     326:	add.l d2,d0
     328:	lea (0,a0,d0.l),a1
     32c:	move.l a1,23afe <BmpUpperPart_PF1+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     332:	moveq #3,d4
     334:	cmp.l d3,d4
     336:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     338:	add.l d2,d0
     33a:	lea (0,a0,d0.l),a1
     33e:	move.l a1,23b02 <BmpUpperPart_PF1+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     344:	moveq #4,d4
     346:	cmp.l d3,d4
     348:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     34a:	add.l d2,d0
     34c:	lea (0,a0,d0.l),a1
     350:	move.l a1,23b06 <BmpUpperPart_PF1+0x22>
	for (int p = 0; p < img->Bpls; p++)
     356:	moveq #5,d4
     358:	cmp.l d3,d4
     35a:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     35c:	add.l d2,d0
     35e:	lea (0,a0,d0.l),a1
     362:	move.l a1,23b0a <BmpUpperPart_PF1+0x26>
	for (int p = 0; p < img->Bpls; p++)
     368:	moveq #6,d4
     36a:	cmp.l d3,d4
     36c:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     36e:	add.l d2,d0
     370:	lea (0,a0,d0.l),a1
     374:	move.l a1,23b0e <BmpUpperPart_PF1+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     37a:	subq.l #7,d3
     37c:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     37e:	add.l d2,d0
     380:	add.l a0,d0
     382:	move.l d0,23b12 <BmpUpperPart_PF1+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     388:	moveq #0,d3
     38a:	move.w 23ab4 <BmpUpperPart_PF2+0x4>,d3
     390:	tst.l d3
     392:	beq.w 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     396:	movea.l 23abe <BmpUpperPart_PF2+0xe>,a0
     39c:	moveq #0,d2
     39e:	move.w 23ab6 <BmpUpperPart_PF2+0x6>,d2
     3a4:	move.l a0,23ac2 <BmpUpperPart_PF2+0x12>
	for (int p = 0; p < img->Bpls; p++)
     3aa:	moveq #1,d5
     3ac:	cmp.l d3,d5
     3ae:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3b0:	lea (0,a0,d2.l),a1
     3b4:	move.l a1,23ac6 <BmpUpperPart_PF2+0x16>
	for (int p = 0; p < img->Bpls; p++)
     3ba:	moveq #2,d0
     3bc:	cmp.l d3,d0
     3be:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3c0:	move.l d2,d0
     3c2:	add.l d2,d0
     3c4:	lea (0,a0,d0.l),a1
     3c8:	move.l a1,23aca <BmpUpperPart_PF2+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     3ce:	moveq #3,d4
     3d0:	cmp.l d3,d4
     3d2:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3d4:	add.l d2,d0
     3d6:	lea (0,a0,d0.l),a1
     3da:	move.l a1,23ace <BmpUpperPart_PF2+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     3e0:	moveq #4,d4
     3e2:	cmp.l d3,d4
     3e4:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3e6:	add.l d2,d0
     3e8:	lea (0,a0,d0.l),a1
     3ec:	move.l a1,23ad2 <BmpUpperPart_PF2+0x22>
	for (int p = 0; p < img->Bpls; p++)
     3f2:	moveq #5,d4
     3f4:	cmp.l d3,d4
     3f6:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3f8:	add.l d2,d0
     3fa:	lea (0,a0,d0.l),a1
     3fe:	move.l a1,23ad6 <BmpUpperPart_PF2+0x26>
	for (int p = 0; p < img->Bpls; p++)
     404:	moveq #6,d4
     406:	cmp.l d3,d4
     408:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     40a:	add.l d2,d0
     40c:	lea (0,a0,d0.l),a1
     410:	move.l a1,23ada <BmpUpperPart_PF2+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     416:	subq.l #7,d3
     418:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     41a:	add.l d2,d0
     41c:	add.l a0,d0
     41e:	move.l d0,23ade <BmpUpperPart_PF2+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     424:	moveq #0,d3
     426:	move.w 23a80 <BmpUpperPart_Buf1+0x4>,d3
     42c:	tst.l d3
     42e:	beq.w 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     432:	moveq #0,d2
     434:	move.w 23a82 <BmpUpperPart_Buf1+0x6>,d2
     43a:	move.l d1,23a8e <BmpUpperPart_Buf1+0x12>
	for (int p = 0; p < img->Bpls; p++)
     440:	moveq #1,d5
     442:	cmp.l d3,d5
     444:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     446:	move.l d1,d6
     448:	add.l d2,d6
     44a:	move.l d6,23a92 <BmpUpperPart_Buf1+0x16>
	for (int p = 0; p < img->Bpls; p++)
     450:	moveq #2,d0
     452:	cmp.l d3,d0
     454:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     456:	move.l d2,d0
     458:	add.l d2,d0
     45a:	move.l d1,d4
     45c:	add.l d0,d4
     45e:	move.l d4,23a96 <BmpUpperPart_Buf1+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     464:	moveq #3,d5
     466:	cmp.l d3,d5
     468:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     46a:	add.l d2,d0
     46c:	move.l d1,d6
     46e:	add.l d0,d6
     470:	move.l d6,23a9a <BmpUpperPart_Buf1+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     476:	moveq #4,d4
     478:	cmp.l d3,d4
     47a:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     47c:	add.l d2,d0
     47e:	move.l d1,d5
     480:	add.l d0,d5
     482:	move.l d5,23a9e <BmpUpperPart_Buf1+0x22>
	for (int p = 0; p < img->Bpls; p++)
     488:	moveq #5,d6
     48a:	cmp.l d3,d6
     48c:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     48e:	add.l d2,d0
     490:	move.l d1,d4
     492:	add.l d0,d4
     494:	move.l d4,23aa2 <BmpUpperPart_Buf1+0x26>
	for (int p = 0; p < img->Bpls; p++)
     49a:	moveq #6,d5
     49c:	cmp.l d3,d5
     49e:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4a0:	add.l d2,d0
     4a2:	move.l d1,d6
     4a4:	add.l d0,d6
     4a6:	move.l d6,23aa6 <BmpUpperPart_Buf1+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     4ac:	subq.l #7,d3
     4ae:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4b0:	add.l d2,d0
     4b2:	add.l d0,d1
     4b4:	move.l d1,23aaa <BmpUpperPart_Buf1+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     4ba:	moveq #0,d2
     4bc:	move.w 23a4c <BmpScroller+0x4>,d2
     4c2:	tst.l d2
     4c4:	beq.w 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4c8:	movea.l 23a56 <BmpScroller+0xe>,a0
     4ce:	moveq #0,d1
     4d0:	move.w 23a4e <BmpScroller+0x6>,d1
     4d6:	move.l a0,23a5a <BmpScroller+0x12>
	for (int p = 0; p < img->Bpls; p++)
     4dc:	moveq #1,d5
     4de:	cmp.l d2,d5
     4e0:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4e2:	lea (0,a0,d1.l),a1
     4e6:	move.l a1,23a5e <BmpScroller+0x16>
	for (int p = 0; p < img->Bpls; p++)
     4ec:	moveq #2,d0
     4ee:	cmp.l d2,d0
     4f0:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4f2:	move.l d1,d0
     4f4:	add.l d1,d0
     4f6:	lea (0,a0,d0.l),a1
     4fa:	move.l a1,23a62 <BmpScroller+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     500:	moveq #3,d3
     502:	cmp.l d2,d3
     504:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     506:	add.l d1,d0
     508:	lea (0,a0,d0.l),a1
     50c:	move.l a1,23a66 <BmpScroller+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     512:	moveq #4,d3
     514:	cmp.l d2,d3
     516:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     518:	add.l d1,d0
     51a:	lea (0,a0,d0.l),a1
     51e:	move.l a1,23a6a <BmpScroller+0x22>
	for (int p = 0; p < img->Bpls; p++)
     524:	moveq #5,d3
     526:	cmp.l d2,d3
     528:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     52a:	add.l d1,d0
     52c:	lea (0,a0,d0.l),a1
     530:	move.l a1,23a6e <BmpScroller+0x26>
	for (int p = 0; p < img->Bpls; p++)
     536:	moveq #6,d3
     538:	cmp.l d2,d3
     53a:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     53c:	add.l d1,d0
     53e:	lea (0,a0,d0.l),a1
     542:	move.l a1,23a72 <BmpScroller+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     548:	subq.l #7,d2
     54a:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     54c:	add.l d1,d0
     54e:	add.l a0,d0
     550:	move.l d0,23a76 <BmpScroller+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     556:	moveq #0,d2
     558:	move.w 23a18 <BmpFont32+0x4>,d2
     55e:	tst.l d2
     560:	beq.w 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     564:	moveq #0,d1
     566:	move.w 23a1a <BmpFont32+0x6>,d1
     56c:	move.l #37062,23a26 <BmpFont32+0x12>
	for (int p = 0; p < img->Bpls; p++)
     576:	moveq #1,d4
     578:	cmp.l d2,d4
     57a:	beq.w 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     57e:	move.l d1,d5
     580:	addi.l #37062,d5
     586:	move.l d5,23a2a <BmpFont32+0x16>
	for (int p = 0; p < img->Bpls; p++)
     58c:	moveq #2,d6
     58e:	cmp.l d2,d6
     590:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     592:	move.l d1,d0
     594:	add.l d1,d0
     596:	move.l d0,d3
     598:	addi.l #37062,d3
     59e:	move.l d3,23a2e <BmpFont32+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     5a4:	moveq #3,d4
     5a6:	cmp.l d2,d4
     5a8:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5aa:	add.l d1,d0
     5ac:	move.l d0,d5
     5ae:	addi.l #37062,d5
     5b4:	move.l d5,23a32 <BmpFont32+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     5ba:	moveq #4,d6
     5bc:	cmp.l d2,d6
     5be:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5c0:	add.l d1,d0
     5c2:	move.l d0,d3
     5c4:	addi.l #37062,d3
     5ca:	move.l d3,23a36 <BmpFont32+0x22>
	for (int p = 0; p < img->Bpls; p++)
     5d0:	moveq #5,d4
     5d2:	cmp.l d2,d4
     5d4:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5d6:	add.l d1,d0
     5d8:	move.l d0,d5
     5da:	addi.l #37062,d5
     5e0:	move.l d5,23a3a <BmpFont32+0x26>
	for (int p = 0; p < img->Bpls; p++)
     5e6:	moveq #6,d6
     5e8:	cmp.l d2,d6
     5ea:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5ec:	add.l d1,d0
     5ee:	move.l d0,d3
     5f0:	addi.l #37062,d3
     5f6:	move.l d3,23a3e <BmpFont32+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     5fc:	subq.l #7,d2
     5fe:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     600:	add.l d1,d0
     602:	addi.l #37062,d0
     608:	move.l d0,23a42 <BmpFont32+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     60e:	moveq #0,d2
     610:	move.w 239e4 <BmpCookie+0x4>,d2
     616:	tst.l d2
     618:	beq.w 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     61c:	moveq #0,d1
     61e:	move.w 239e6 <BmpCookie+0x6>,d1
     624:	move.l #67784,239f2 <BmpCookie+0x12>
	for (int p = 0; p < img->Bpls; p++)
     62e:	moveq #1,d5
     630:	cmp.l d2,d5
     632:	beq.w 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     636:	move.l d1,d6
     638:	addi.l #67784,d6
     63e:	move.l d6,239f6 <BmpCookie+0x16>
	for (int p = 0; p < img->Bpls; p++)
     644:	moveq #2,d0
     646:	cmp.l d2,d0
     648:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     64a:	move.l d1,d0
     64c:	add.l d1,d0
     64e:	move.l d0,d3
     650:	addi.l #67784,d3
     656:	move.l d3,239fa <BmpCookie+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     65c:	moveq #3,d4
     65e:	cmp.l d2,d4
     660:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     662:	add.l d1,d0
     664:	move.l d0,d5
     666:	addi.l #67784,d5
     66c:	move.l d5,239fe <BmpCookie+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     672:	moveq #4,d6
     674:	cmp.l d2,d6
     676:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     678:	add.l d1,d0
     67a:	move.l d0,d3
     67c:	addi.l #67784,d3
     682:	move.l d3,23a02 <BmpCookie+0x22>
	for (int p = 0; p < img->Bpls; p++)
     688:	moveq #5,d4
     68a:	cmp.l d2,d4
     68c:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     68e:	add.l d1,d0
     690:	move.l d0,d5
     692:	addi.l #67784,d5
     698:	move.l d5,23a06 <BmpCookie+0x26>
	for (int p = 0; p < img->Bpls; p++)
     69e:	moveq #6,d6
     6a0:	cmp.l d2,d6
     6a2:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6a4:	add.l d1,d0
     6a6:	move.l d0,d3
     6a8:	addi.l #67784,d3
     6ae:	move.l d3,23a0a <BmpCookie+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     6b4:	subq.l #7,d2
     6b6:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6b8:	add.l d1,d0
     6ba:	addi.l #67784,d0
     6c0:	move.l d0,23a0e <BmpCookie+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     6c6:	moveq #0,d2
     6c8:	move.w 239b0 <BmpCookieMask+0x4>,d2
     6ce:	tst.l d2
     6d0:	beq.w 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6d4:	moveq #0,d1
     6d6:	move.w 239b2 <BmpCookieMask+0x6>,d1
     6dc:	move.l #98506,239be <BmpCookieMask+0x12>
	for (int p = 0; p < img->Bpls; p++)
     6e6:	moveq #1,d5
     6e8:	cmp.l d2,d5
     6ea:	beq.w 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6ee:	move.l d1,d6
     6f0:	addi.l #98506,d6
     6f6:	move.l d6,239c2 <BmpCookieMask+0x16>
	for (int p = 0; p < img->Bpls; p++)
     6fc:	moveq #2,d0
     6fe:	cmp.l d2,d0
     700:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     702:	move.l d1,d0
     704:	add.l d1,d0
     706:	move.l d0,d3
     708:	addi.l #98506,d3
     70e:	move.l d3,239c6 <BmpCookieMask+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     714:	moveq #3,d4
     716:	cmp.l d2,d4
     718:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     71a:	add.l d1,d0
     71c:	move.l d0,d5
     71e:	addi.l #98506,d5
     724:	move.l d5,239ca <BmpCookieMask+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     72a:	moveq #4,d6
     72c:	cmp.l d2,d6
     72e:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     730:	add.l d1,d0
     732:	move.l d0,d3
     734:	addi.l #98506,d3
     73a:	move.l d3,239ce <BmpCookieMask+0x22>
	for (int p = 0; p < img->Bpls; p++)
     740:	moveq #5,d4
     742:	cmp.l d2,d4
     744:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     746:	add.l d1,d0
     748:	move.l d0,d5
     74a:	addi.l #98506,d5
     750:	move.l d5,239d2 <BmpCookieMask+0x26>
	for (int p = 0; p < img->Bpls; p++)
     756:	moveq #6,d6
     758:	cmp.l d2,d6
     75a:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     75c:	add.l d1,d0
     75e:	move.l d0,d3
     760:	addi.l #98506,d3
     766:	move.l d3,239d6 <BmpCookieMask+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     76c:	subq.l #7,d2
     76e:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     770:	add.l d1,d0
     772:	addi.l #98506,d0
     778:	move.l d0,239da <BmpCookieMask+0x2e>
	ActiView = GfxBase->ActiView; //store current view
     77e:	movea.l 23b82 <GfxBase>,a6
     784:	move.l 34(a6),23994 <ActiView>
	OwnBlitter();
     78c:	jsr -456(a6)
	WaitBlit();
     790:	movea.l 23b82 <GfxBase>,a6
     796:	jsr -228(a6)
	Disable();
     79a:	movea.l 23b86 <SysBase>,a6
     7a0:	jsr -120(a6)
	SystemADKCON = custom->adkconr;
     7a4:	movea.l 23b8c <custom>,a2
     7aa:	move.w 16(a2),d0
     7ae:	move.w d0,23998 <SystemADKCON>
	SystemInts = custom->intenar;
     7b4:	move.w 28(a2),d0
     7b8:	move.w d0,2399c <SystemInts>
	SystemDMA = custom->dmaconr;
     7be:	move.w 2(a2),d0
     7c2:	move.w d0,2399a <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     7c8:	move.w #32767,154(a2)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     7ce:	move.w #32767,156(a2)
	WaitVbl();
     7d4:	jsr 266a <WaitVbl>
	WaitVbl();
     7da:	jsr 266a <WaitVbl>
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
     7fa:	moveq #32,d5
     7fc:	cmp.l d1,d5
     7fe:	bne.s 7e8 <main+0x774>
	LoadView(0);
     800:	movea.l 23b82 <GfxBase>,a6
     806:	suba.l a1,a1
     808:	jsr -222(a6)
	WaitTOF();
     80c:	movea.l 23b82 <GfxBase>,a6
     812:	jsr -270(a6)
	WaitTOF();
     816:	movea.l 23b82 <GfxBase>,a6
     81c:	jsr -270(a6)
	WaitVbl();
     820:	jsr 266a <WaitVbl>
	WaitVbl();
     826:	jsr 266a <WaitVbl>
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     82c:	move.w #20090,172(sp)
     832:	move.w #2049,174(sp)
     838:	move.w #20083,176(sp)
	if (SysBase->AttnFlags & AFF_68010)
     83e:	movea.l 23b86 <SysBase>,a6
     844:	btst #0,297(a6)
     84a:	beq.w 25c0 <main+0x254c>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     84e:	move.l sp,d7
     850:	addi.l #172,d7
     856:	exg d7,a5
     858:	jsr -30(a6)
     85c:	exg d7,a5
	VBR = GetVBR();
     85e:	move.l d0,239a2 <VBR>
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     864:	movea.l 239a2 <VBR>,a0
     86a:	move.l 108(a0),d0
	SystemIrq = GetInterruptHandler(); //store interrupt register
     86e:	move.l d0,2399e <SystemIrq>
	WaitVbl();
     874:	jsr 266a <WaitVbl>
	SetupCopper(copPtr);
     87a:	movea.l 239a6 <copPtr>,a2
	*copPtr++ = DIWSTRT;
     880:	move.w #142,(a2)
	*copPtr++ = 0x2c81;
     884:	move.w #11393,2(a2)
	*copPtr++ = DIWSTOP;
     88a:	move.w #144,4(a2)
	*copPtr++ = 0x2cc1;
     890:	move.w #11457,6(a2)
	*copPtr++ = DDFSTRT;
     896:	move.w #146,8(a2)
	*copPtr++ = 0x38; // + ((Screen.Width - BmpLogo.Width) / 4);
     89c:	move.w #56,10(a2)
	*copPtr++ = DDFSTOP;
     8a2:	move.w #148,12(a2)
	*copPtr++ = 0xd0; // - ((Screen.Width - BmpLogo.Width) / 4);
     8a8:	move.w #208,14(a2)
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl);
     8ae:	move.w 23aea <BmpUpperPart_PF1+0x6>,d2
     8b4:	move.w 23aec <BmpUpperPart_PF1+0x8>,d0
     8ba:	sub.w d2,d0
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     8bc:	move.w #264,16(a2)
    *copListEnd++ = modOdd;
     8c2:	move.w d0,18(a2)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     8c6:	move.w #266,20(a2)
    *copListEnd++ = modEven;
     8cc:	move.w d0,22(a2)
	*copPtr++ = BPLCON1; //scrolling
     8d0:	move.w #258,24(a2)
	*copPtr++ = 0;
     8d6:	clr.w 26(a2)
	*copPtr++ = BPLCON2; //playfied priority
     8da:	move.w #260,28(a2)
	*copPtr++ = 1 << 6;	 //0x24;  Sprites have priority over playfields
     8e0:	move.w #64,30(a2)
    *copListEnd++ = COP_SKIP;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     8e6:	move.w #384,32(a2)
    *copListCurrent++ = color;
     8ec:	move.w #21,34(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     8f2:	move.w #398,36(a2)
    *copListCurrent++ = color;
     8f8:	move.w #21,38(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     8fe:	move.w #386,40(a2)
    *copListCurrent++ = color;
     904:	move.w #1366,42(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     90a:	move.w #388,44(a2)
    *copListCurrent++ = color;
     910:	move.w #3221,46(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     916:	move.w #390,48(a2)
    *copListCurrent++ = color;
     91c:	move.w #3750,50(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     922:	move.w #392,52(a2)
    *copListCurrent++ = color;
     928:	move.w #1074,54(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     92e:	move.w #394,56(a2)
    *copListCurrent++ = color;
     934:	move.w #1329,58(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     93a:	move.w #396,60(a2)
    *copListCurrent++ = color;
     940:	move.w #530,62(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     946:	move.w #398,64(a2)
    *copListCurrent++ = color;
     94c:	move.w #2177,66(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     952:	move.w #400,68(a2)
    *copListCurrent++ = color;
     958:	clr.w 70(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     95c:	move.w #402,72(a2)
    *copListCurrent++ = color;
     962:	move.w #102,74(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     968:	move.w #404,76(a2)
    *copListCurrent++ = color;
     96e:	move.w #119,78(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     974:	move.w #406,80(a2)
    *copListCurrent++ = color;
     97a:	move.w #136,82(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     980:	move.w #408,84(a2)
    *copListCurrent++ = color;
     986:	move.w #169,86(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     98c:	move.w #410,88(a2)
    *copListCurrent++ = color;
     992:	move.w #187,90(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     998:	move.w #412,92(a2)
    *copListCurrent++ = color;
     99e:	move.w #204,94(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     9a4:	move.w #414,96(a2)
    *copListCurrent++ = color;
     9aa:	lea 100(a2),a0
     9ae:	move.w #221,98(a2)
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
     9b4:	move.w 23ae8 <BmpUpperPart_PF1+0x4>,d6
     9ba:	movea.l 23af2 <BmpUpperPart_PF1+0xe>,a6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     9c0:	move.l a6,d1
    for (USHORT i = 0; i < numPlanes; i++)
     9c2:	tst.w d6
     9c4:	beq.s a10 <main+0x99c>
        addr += Bpl;
     9c6:	moveq #0,d5
     9c8:	move.w d2,d5
     9ca:	move.w d6,d0
     9cc:	subq.w #1,d0
     9ce:	andi.l #65535,d0
     9d4:	lsl.l #3,d0
     9d6:	lea (108,a2,d0.l),a3
    *copListCurrent++ = color;
     9da:	movea.l a0,a1
    BYTE plane = odd ? 1 : 0;
     9dc:	clr.b d3
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     9de:	move.b d3,d0
     9e0:	ext.w d0
     9e2:	lsl.w #2,d0
     9e4:	addi.w #224,d0
     9e8:	move.w d0,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     9ea:	move.l d1,d4
     9ec:	clr.w d4
     9ee:	swap d4
     9f0:	move.w d4,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     9f4:	addq.w #2,d0
     9f6:	move.w d0,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     9fa:	addq.l #8,a1
     9fc:	move.w d1,-2(a1)
        addr += Bpl;
     a00:	add.l d5,d1
        plane += 2;
     a02:	addq.b #2,d3
    for (USHORT i = 0; i < numPlanes; i++)
     a04:	cmpa.l a1,a3
     a06:	bne.s 9de <main+0x96a>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     a08:	moveq #0,d0
     a0a:	move.w d6,d0
     a0c:	lsl.l #3,d0
     a0e:	adda.l d0,a0
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
     a10:	move.w 23ab6 <BmpUpperPart_PF2+0x6>,d6
     a16:	move.w 23ab4 <BmpUpperPart_PF2+0x4>,d0
     a1c:	move.l 23abe <BmpUpperPart_PF2+0xe>,d3
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     a22:	move.l d3,d1
    for (USHORT i = 0; i < numPlanes; i++)
     a24:	tst.w d0
     a26:	beq.s a66 <main+0x9f2>
        addr += Bpl;
     a28:	andi.l #65535,d6
     a2e:	andi.l #65535,d0
     a34:	lsl.l #3,d0
     a36:	lea (0,a0,d0.l),a1
    BYTE plane = odd ? 1 : 0;
     a3a:	moveq #1,d4
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     a3c:	move.b d4,d0
     a3e:	ext.w d0
     a40:	lsl.w #2,d0
     a42:	addi.w #224,d0
     a46:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     a48:	move.l d1,d5
     a4a:	clr.w d5
     a4c:	swap d5
     a4e:	move.w d5,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     a52:	addq.w #2,d0
     a54:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     a58:	addq.l #8,a0
     a5a:	move.w d1,-2(a0)
        addr += Bpl;
     a5e:	add.l d6,d1
        plane += 2;
     a60:	addq.b #2,d4
    for (USHORT i = 0; i < numPlanes; i++)
     a62:	cmpa.l a1,a0
     a64:	bne.s a3c <main+0x9c8>
	*copPtr++ = SPR0PTH;
     a66:	move.w #288,(a0)
	*copPtr++ = (LONG)StarSprite >> 16;
     a6a:	move.l #144348,d0
     a70:	move.l d0,d1
     a72:	swap d1
     a74:	ext.l d1
     a76:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
     a7a:	move.w #290,4(a0)
	*copPtr++ = (LONG)StarSprite;
     a80:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
     a84:	move.w #292,8(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     a8a:	move.l #144336,d0
     a90:	move.l d0,d1
     a92:	swap d1
     a94:	ext.l d1
     a96:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
     a9a:	move.w #294,12(a0)
	*copPtr++ = (LONG)NullSprite;
     aa0:	move.w d0,14(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     aa4:	move.w #418,16(a0)
    *copListCurrent++ = color;
     aaa:	move.w #4095,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ab0:	move.w #420,20(a0)
    *copListCurrent++ = color;
     ab6:	move.w #1103,22(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     abc:	move.w #422,24(a0)
    *copListCurrent++ = color;
     ac2:	move.w #2190,26(a0)
	*copPtr++ = SPR2PTH;
     ac8:	move.w #296,28(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     ace:	move.w d1,30(a0)
	*copPtr++ = SPR2PTL;
     ad2:	move.w #298,32(a0)
	*copPtr++ = (LONG)NullSprite;
     ad8:	move.w d0,34(a0)
	*copPtr++ = SPR3PTH;
     adc:	move.w #300,36(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     ae2:	move.w d1,38(a0)
	*copPtr++ = SPR3PTL;
     ae6:	move.w #302,40(a0)
	*copPtr++ = (LONG)NullSprite;
     aec:	move.w d0,42(a0)
	*copPtr++ = SPR4PTH;
     af0:	move.w #304,44(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     af6:	move.w d1,46(a0)
	*copPtr++ = SPR4PTL;
     afa:	move.w #306,48(a0)
	*copPtr++ = (LONG)NullSprite;
     b00:	move.w d0,50(a0)
	*copPtr++ = SPR5PTH;
     b04:	move.w #308,52(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     b0a:	move.w d1,54(a0)
	*copPtr++ = SPR5PTL;
     b0e:	move.w #310,56(a0)
	*copPtr++ = (LONG)NullSprite;
     b14:	move.w d0,58(a0)
	*copPtr++ = SPR6PTH;
     b18:	move.w #312,60(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     b1e:	move.w d1,62(a0)
	*copPtr++ = SPR6PTL;
     b22:	move.w #314,64(a0)
	*copPtr++ = (LONG)NullSprite;
     b28:	move.w d0,66(a0)
	*copPtr++ = SPR7PTH;
     b2c:	move.w #316,68(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     b32:	move.w d1,70(a0)
	*copPtr++ = SPR7PTL;
     b36:	move.w #318,72(a0)
	*copPtr++ = (LONG)NullSprite;
     b3c:	move.w d0,74(a0)
	*copPtr++ = BPLCON0;
     b40:	move.w #256,76(a0)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     b46:	move.w 23b1c <BmpLogo+0x4>,48(sp)
     b4e:	moveq #0,d6
     b50:	move.w 48(sp),d6
     b54:	movea.l d6,a4
     b56:	move.l a4,d0
     b58:	moveq #13,d1
     b5a:	lsl.l d1,d0
     b5c:	ori.w #1536,d0
     b60:	move.w d0,78(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     b64:	move.w #7173,80(a0)
    *copListEnd++ = COP_WAIT;
     b6a:	move.w #-2,82(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b70:	move.w #384,84(a0)
    *copListCurrent++ = color;
     b76:	move.w #21,86(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b7c:	move.w #398,88(a0)
    *copListCurrent++ = color;
     b82:	move.w #21,90(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     b88:	move.w #7429,92(a0)
    *copListEnd++ = COP_WAIT;
     b8e:	move.w #-2,94(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b94:	move.w #384,96(a0)
    *copListCurrent++ = color;
     b9a:	move.w #22,98(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ba0:	move.w #398,100(a0)
    *copListCurrent++ = color;
     ba6:	move.w #22,102(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     bac:	move.w #7685,104(a0)
    *copListEnd++ = COP_WAIT;
     bb2:	move.w #-2,106(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     bb8:	move.w #384,108(a0)
    *copListCurrent++ = color;
     bbe:	move.w #22,110(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     bc4:	move.w #398,112(a0)
    *copListCurrent++ = color;
     bca:	move.w #22,114(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     bd0:	move.w #7941,116(a0)
    *copListEnd++ = COP_WAIT;
     bd6:	move.w #-2,118(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     bdc:	move.w #384,120(a0)
    *copListCurrent++ = color;
     be2:	move.w #22,122(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     be8:	move.w #398,124(a0)
    *copListCurrent++ = color;
     bee:	move.w #22,126(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     bf4:	move.w #8197,128(a0)
    *copListEnd++ = COP_WAIT;
     bfa:	move.w #-2,130(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c00:	move.w #384,132(a0)
    *copListCurrent++ = color;
     c06:	move.w #38,134(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c0c:	move.w #398,136(a0)
    *copListCurrent++ = color;
     c12:	move.w #38,138(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     c18:	move.w #8453,140(a0)
    *copListEnd++ = COP_WAIT;
     c1e:	move.w #-2,142(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c24:	move.w #384,144(a0)
    *copListCurrent++ = color;
     c2a:	move.w #39,146(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c30:	move.w #398,148(a0)
    *copListCurrent++ = color;
     c36:	move.w #39,150(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     c3c:	move.w #8709,152(a0)
    *copListEnd++ = COP_WAIT;
     c42:	move.w #-2,154(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c48:	move.w #384,156(a0)
    *copListCurrent++ = color;
     c4e:	move.w #39,158(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c54:	move.w #398,160(a0)
    *copListCurrent++ = color;
     c5a:	move.w #39,162(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     c60:	move.w #8965,164(a0)
    *copListEnd++ = COP_WAIT;
     c66:	move.w #-2,166(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c6c:	move.w #384,168(a0)
    *copListCurrent++ = color;
     c72:	move.w #21,170(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c78:	move.w #398,172(a0)
    *copListCurrent++ = color;
     c7e:	move.w #21,174(a0)
	line = 0x2c + BmpUpperPart_PF1.Height;
     c84:	move.b 23ae7 <BmpUpperPart_PF1+0x3>,d4
     c8a:	move.b d4,d0
     c8c:	addi.b #44,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     c90:	lsl.w #8,d0
     c92:	ori.w #5,d0
     c96:	move.w d0,176(a0)
    *copListEnd++ = COP_WAIT;
     c9a:	move.w #-2,178(a0)
	*copPtr++ = BPLCON0;
     ca0:	move.w #256,180(a0)
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     ca6:	move.w #512,182(a0)
	copPtr = copWaitY(copPtr, line++);
     cac:	move.b d4,d5
     cae:	addi.b #53,d5
     cb2:	movea.w d5,a5
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
     cb4:	move.b d4,d0
     cb6:	addi.b #52,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     cba:	lsl.w #8,d0
     cbc:	ori.w #5,d0
     cc0:	move.w d0,184(a0)
    *copListEnd++ = COP_WAIT;
     cc4:	lea 188(a0),a1
     cc8:	move.w #-2,186(a0)
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     cce:	move.l a1,2398a <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     cd4:	move.w 23a4e <BmpScroller+0x6>,d7
     cda:	move.w 23a4c <BmpScroller+0x4>,118(sp)
     ce2:	move.l 23a56 <BmpScroller+0xe>,120(sp)
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     cea:	move.l 120(sp),d5
    for (USHORT i = 0; i < numPlanes; i++)
     cee:	tst.w 118(sp)
     cf2:	beq.s d42 <main+0xcce>
        addr += Bpl;
     cf4:	andi.l #65535,d7
     cfa:	move.w 118(sp),d0
     cfe:	subq.w #1,d0
     d00:	andi.l #65535,d0
     d06:	lsl.l #3,d0
     d08:	addi.l #196,d0
     d0e:	add.l a0,d0
     d10:	movea.l a1,a0
     d12:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     d16:	move.w d1,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     d18:	move.l d5,d6
     d1a:	clr.w d6
     d1c:	swap d6
     d1e:	move.w d6,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     d22:	move.w d1,d6
     d24:	addq.w #2,d6
     d26:	move.w d6,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     d2a:	addq.l #8,a0
     d2c:	move.w d5,-2(a0)
        addr += Bpl;
     d30:	add.l d7,d5
    for (USHORT i = 0; i < numPlanes; i++)
     d32:	addq.w #4,d1
     d34:	cmpa.l d0,a0
     d36:	bne.s d16 <main+0xca2>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     d38:	moveq #0,d0
     d3a:	move.w 118(sp),d0
     d3e:	lsl.l #3,d0
     d40:	adda.l d0,a1
						  BmpScroller.Bplt - Screen.Bpl);
     d42:	move.w 23a50 <BmpScroller+0x8>,d0
     d48:	sub.w 23b52 <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     d4e:	move.w #264,(a1)
    *copListEnd++ = modOdd;
     d52:	move.w d0,2(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     d56:	move.w #266,4(a1)
    *copListEnd++ = modEven;
     d5c:	move.w d0,6(a1)
	*copPtr++ = BPLCON0;
     d60:	move.w #256,8(a1)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     d66:	move.l a4,d0
     d68:	moveq #12,d1
     d6a:	lsl.l d1,d0
     d6c:	ori.w #512,d0
     d70:	move.w d0,10(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     d74:	move.w #386,12(a1)
    *copListCurrent++ = color;
     d7a:	move.w #2288,14(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     d80:	move.w #388,16(a1)
    *copListCurrent++ = color;
     d86:	move.w #1776,18(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     d8c:	move.w #390,20(a1)
    *copListCurrent++ = color;
     d92:	move.w #1008,22(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     d98:	move.w #392,24(a1)
    *copListCurrent++ = color;
     d9e:	move.w #496,26(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     da4:	move.w #394,28(a1)
    *copListCurrent++ = color;
     daa:	move.w #241,30(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     db0:	move.w #396,32(a1)
    *copListCurrent++ = color;
     db6:	move.w #244,34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     dbc:	move.w #398,36(a1)
    *copListCurrent++ = color;
     dc2:	lea 40(a1),a0
     dc6:	move.w #246,38(a1)
	for (int l = 0; l < 24; l++)
     dcc:	lea 44d6 <colgradbluePaletteRGB4>,a4
     dd2:	move.w a5,d1
     dd4:	move.w a4,d5
     dd6:	sub.b d5,d1
		copPtr = copWaitY(copPtr, line);
     dd8:	move.w a4,d0
     dda:	add.b d1,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     ddc:	lsl.w #8,d0
     dde:	ori.w #5,d0
     de2:	move.w d0,(a0)
    *copListEnd++ = COP_WAIT;
     de4:	move.w #-2,2(a0)
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     dea:	move.w (a4)+,d0
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     dec:	move.w #384,4(a0)
    *copListCurrent++ = color;
     df2:	addq.l #8,a0
     df4:	move.w d0,-2(a0)
	for (int l = 0; l < 24; l++)
     df8:	cmpa.l #17670,a4
     dfe:	bne.s dd8 <main+0xd64>
		line += 2;
     e00:	move.b d4,d0
     e02:	addi.b #101,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     e06:	lsl.w #8,d0
     e08:	ori.w #5,d0
     e0c:	move.w d0,232(a1)
    *copListEnd++ = COP_WAIT;
     e10:	move.w #-2,234(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e16:	move.w #384,236(a1)
    *copListCurrent++ = color;
     e1c:	move.w #1911,238(a1)
	copPtr = copWaitY(copPtr, line++);
     e22:	move.b d4,d0
     e24:	addi.b #102,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     e28:	lsl.w #8,d0
     e2a:	ori.w #5,d0
     e2e:	move.w d0,240(a1)
    *copListEnd++ = COP_WAIT;
     e32:	move.w #-2,242(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e38:	move.w #384,244(a1)
    *copListCurrent++ = color;
     e3e:	move.w #1179,246(a1)
	line += 7;
     e44:	move.b d4,d0
     e46:	addi.b #110,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     e4a:	lsl.w #8,d0
     e4c:	ori.w #5,d0
     e50:	move.w d0,248(a1)
    *copListEnd++ = COP_WAIT;
     e54:	move.w #-2,250(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e5a:	move.w #384,252(a1)
    *copListCurrent++ = color;
     e60:	move.w #1911,254(a1)
	copPtr = copWaitY(copPtr, line++);
     e66:	move.b d4,d0
     e68:	addi.b #111,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     e6c:	lsl.w #8,d0
     e6e:	ori.w #5,d0
     e72:	move.w d0,256(a1)
    *copListEnd++ = COP_WAIT;
     e76:	move.w #-2,258(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e7c:	move.w #384,260(a1)
    *copListCurrent++ = color;
     e82:	move.w #1179,262(a1)
	line = 0x2c + BmpLogo.Height + 72 + 7; // 209
     e88:	move.b 23b1b <BmpLogo+0x3>,d0
     e8e:	addi.b #123,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     e92:	lsl.w #8,d0
     e94:	ori.w #5,d0
     e98:	move.w d0,264(a1)
    *copListEnd++ = COP_WAIT;
     e9c:	move.w #-2,266(a1)
     ea2:	lea 268(a1),a0
     ea6:	move.l a0,23980 <copMirrorBmpP>
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     eac:	move.w 23b1e <BmpLogo+0x6>,d4
     eb2:	move.w 23b20 <BmpLogo+0x8>,d0
     eb8:	sub.w d4,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     eba:	move.w #264,268(a1)
    *copListEnd++ = modOdd;
     ec0:	move.w d0,270(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     ec4:	move.w #266,272(a1)
    *copListEnd++ = modEven;
     eca:	move.w d0,274(a1)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     ece:	move.w #-31,276(a1)
    *copListEnd++ = COP_WAIT;
     ed4:	move.w #-2,278(a1)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     eda:	move.w #1285,280(a1)
    *copListEnd++ = COP_WAIT;
     ee0:	move.w #-2,282(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ee6:	move.w #384,284(a1)
    *copListCurrent++ = color;
     eec:	move.w #1911,286(a1)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     ef2:	move.w #1541,288(a1)
    *copListEnd++ = COP_WAIT;
     ef8:	move.w #-2,290(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     efe:	move.w #384,292(a1)
    *copListCurrent++ = color;
     f04:	move.w #1179,294(a1)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     f0a:	move.w #11269,296(a1)
    *copListEnd++ = COP_WAIT;
     f10:	move.w #-2,298(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     f16:	move.w #384,300(a1)
    *copListCurrent++ = color;
     f1c:	move.w #1911,302(a1)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     f22:	move.w #11525,304(a1)
    *copListEnd++ = COP_WAIT;
     f28:	move.w #-2,306(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     f2e:	move.w #384,308(a1)
    *copListCurrent++ = color;
     f34:	move.w #1179,310(a1)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     f3a:	move.w #-1,312(a1)
    *copListEnd++ = COP_WAIT;
     f40:	move.w #-2,314(a1)
	custom->cop1lc = (ULONG)copPtr;
     f46:	movea.l 23b8c <custom>,a5
     f4c:	move.l a2,128(a5)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
     f50:	move.w #64,150(a5)
	custom->copjmp1 = 0x7fff;	   //start coppper
     f56:	move.w #32767,136(a5)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
     f5c:	move.w #-30752,150(a5)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     f62:	movea.l 239a2 <VBR>,a0
     f68:	move.l #9768,108(a0)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
     f70:	move.w #-16352,154(a5)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
     f76:	move.w #32,156(a5)
{
	short line = 0;
	USHORT hpos = 3;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 93; l++)
     f7c:	lea 233dc <StarSprite>,a4
     f82:	moveq #0,d6
	BYTE vpos = 0x2c;
     f84:	moveq #44,d7
	USHORT hpos = 3;
     f86:	moveq #3,d5
     f88:	lea 29f0 <__modsi3>,a3
	{
		hpos = (7*hpos)%255;
     f8e:	andi.l #65535,d5
     f94:	move.l d5,d0
     f96:	lsl.l #3,d0
     f98:	pea ff <main+0x8b>
     f9c:	sub.l d5,d0
     f9e:	move.l d0,-(sp)
     fa0:	jsr (a3)
     fa2:	addq.l #8,sp
     fa4:	move.w d0,d5
		
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff);	  //v-pos, h-pos
     fa6:	move.w d7,d1
     fa8:	lsl.w #8,d1
     faa:	or.w d0,d1
     fac:	move.w d1,(a4)
		StarSprite[line++] = (vpos + 1) << 8 | 0; //v-stop, ctrl
     fae:	move.w d7,d0
     fb0:	lsl.w #8,d0
     fb2:	addi.w #256,d0
     fb6:	move.w d0,2(a4)

		switch (l % 3)
     fba:	pea 3 <_start+0x3>
     fbe:	move.l d6,-(sp)
     fc0:	jsr (a3)
     fc2:	addq.l #8,sp
     fc4:	moveq #1,d1
     fc6:	cmp.l d0,d1
     fc8:	beq.w 1f50 <main+0x1edc>
     fcc:	moveq #2,d1
		{
		case 0:
			StarSprite[line++] = 0x8000; //color-1
     fce:	move.w #-32768,4(a4)
		switch (l % 3)
     fd4:	cmp.l d0,d1
     fd6:	beq.w 1f38 <main+0x1ec4>
			StarSprite[line++] = 0x0000; //color-1
     fda:	clr.w 6(a4)
			StarSprite[line++] = 0x8000; //color-3
			StarSprite[line++] = 0x8000; //color-3
			break;
		}

		vpos += 2;
     fde:	addq.b #2,d7
	for (int l = 0; l < 93; l++)
     fe0:	addq.l #1,d6
     fe2:	addq.l #8,a4
     fe4:	cmpi.b #-26,d7
     fe8:	bne.s f8e <main+0xf1a>
	}
	StarSprite[line++] = 0;
     fea:	clr.w 236c4 <StarSprite+0x2e8>
	StarSprite[line++] = 0;
     ff0:	clr.w 236c6 <StarSprite+0x2ea>
	short incX[6] = {3, 3, 3, 3, 3, 3};
     ff6:	move.w #3,168(sp)
	short incY[6] = {1, 1, 1, 1, 1, 1};
     ffc:	move.w #1,180(sp)
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
    1002:	move.l 23b26 <BmpLogo+0xe>,d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1008:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    100c:	move.w 2(a5),d0
    1010:	btst #14,d0
    1014:	bne.s 100c <main+0xf98>
	custom->bltcon0 = 0x09f0;
    1016:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
    101c:	move.w #0,66(a5)
	custom->bltafwm = 0xffff;
    1022:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    1028:	move.w #-1,70(a5)
	custom->bltamod = imgA.Bpl - (width / 8);
    102e:	move.w d4,d7
    1030:	addi.w #-32,d7
    1034:	move.w d7,100(a5)
	custom->bltdmod = imgD.Bpl - (width / 8);
    1038:	addi.w #-32,d2
    103c:	move.w d2,102(a5)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1040:	move.l d1,80(a5)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1044:	addq.l #4,a6
    1046:	move.l a6,84(a5)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
    104a:	move.w 48(sp),d0
    104e:	lsl.w #6,d0
    1050:	add.w 48(sp),d0
    1054:	lsl.w #7,d0
    1056:	addi.w #16,d0
    105a:	move.w d0,88(a5)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    105e:	move.b bfe001 <_end+0xbda471>,d0
	while (!MouseLeft())
    1064:	btst #6,d0
    1068:	beq.w 20de <main+0x206a>
    106c:	move.w 23a80 <BmpUpperPart_Buf1+0x4>,116(sp)
    1074:	move.w 23a82 <BmpUpperPart_Buf1+0x6>,56(sp)
    107c:	move.l 23a8a <BmpUpperPart_Buf1+0xe>,58(sp)
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
    1084:	move.w 2398e <ScrollerY>,82(sp)
	short incY[6] = {1, 1, 1, 1, 1, 1};
    108c:	move.w #1,104(sp)
    1092:	move.w #1,102(sp)
    1098:	move.w #1,106(sp)
    109e:	move.w #1,100(sp)
	short incX[6] = {3, 3, 3, 3, 3, 3};
    10a4:	move.w #3,108(sp)
    10aa:	move.w #3,110(sp)
    10b0:	move.w #3,114(sp)
    10b6:	move.w #3,112(sp)
	Point2D pdb[6] = {
    10bc:	movea.w #78,a2
    10c0:	move.l a2,70(sp)
    10c4:	clr.l 62(sp)
    10c8:	movea.w #82,a2
    10cc:	move.l a2,74(sp)
    10d0:	moveq #28,d4
    10d2:	move.l d4,48(sp)
    10d6:	movea.w #86,a2
    10da:	move.l a2,66(sp)
    10de:	moveq #56,d7
    10e0:	movea.w #90,a2
    10e4:	move.l a2,78(sp)
    10e8:	moveq #84,d4
    10ea:	move.l d4,52(sp)
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    10ee:	move.l dff004 <_end+0xddb474>,d0
    10f4:	move.l d0,156(sp)
		vpos &= 0x1ff00;
    10f8:	move.l 156(sp),d0
    10fc:	andi.l #130816,d0
    1102:	move.l d0,156(sp)
		if (vpos != (311 << 8))
    1106:	move.l 156(sp),d0
    110a:	cmpi.l #79616,d0
    1110:	beq.s 10ee <main+0x107a>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    1112:	move.l dff004 <_end+0xddb474>,d0
    1118:	move.l d0,152(sp)
		vpos &= 0x1ff00;
    111c:	move.l 152(sp),d0
    1120:	andi.l #130816,d0
    1126:	move.l d0,152(sp)
		if (vpos == (311 << 8))
    112a:	move.l 152(sp),d0
    112e:	cmpi.l #79616,d0
    1134:	bne.s 1112 <main+0x109e>
		if (ScrollerPause > 0)
    1136:	move.w 23992 <ScrollerPause>,d4
    113c:	beq.s 1146 <main+0x10d2>
			ScrollerPause--;
    113e:	subq.w #1,d4
    1140:	move.w d4,23992 <ScrollerPause>
		CopyBitmap(BmpUpperPart_Buf1, BmpUpperPart_PF2);
    1146:	move.w 23a7e <BmpUpperPart_Buf1+0x2>,d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    114c:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1150:	move.w 2(a5),d0
    1154:	move.w d0,d2
    1156:	andi.w #16384,d2
    115a:	btst #14,d0
    115e:	bne.s 1150 <main+0x10dc>
	custom->bltcon0 = 0x09f0;
    1160:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
    1166:	move.w #0,66(a5)
	custom->bltapt = (UBYTE *)bmpS.ImageData;
    116c:	move.l 58(sp),80(a5)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
    1172:	move.l d3,84(a5)
	custom->bltafwm = 0xffff;
    1176:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    117c:	move.w #-1,70(a5)
	custom->bltamod = 0;
    1182:	move.w #0,100(a5)
	custom->bltdmod = 0;
    1188:	move.w #0,102(a5)
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
    118e:	move.w 116(sp),d0
    1192:	muls.w d1,d0
    1194:	lsl.w #6,d0
    1196:	move.w 56(sp),d1
    119a:	lsr.w #1,d1
    119c:	add.w d1,d0
    119e:	move.w d0,88(a5)
		if (BounceEnabled)
    11a2:	tst.w 23990 <BounceEnabled>
    11a8:	beq.s 11e8 <main+0x1174>
			if (ScrollerDir > 0)
    11aa:	move.b 6002 <ScrollerDir>,d0
    11b0:	ble.w 2094 <main+0x2020>
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
    11b4:	pea c <_start+0xc>
    11b8:	movea.w #40,a0
    11bc:	suba.w 86(sp),a0
    11c0:	move.l a0,-(sp)
    11c2:	jsr 29c6 <__divsi3>
    11c8:	addq.l #8,sp
				if (ScrollerDir > 6)
    11ca:	cmpi.b #6,d0
    11ce:	ble.w 20b8 <main+0x2044>
					ScrollerDir = 6;
    11d2:	move.b #6,6002 <ScrollerDir>
    11da:	moveq #6,d0
			ScrollerY += ScrollerDir;
    11dc:	add.w d0,82(sp)
    11e0:	move.w 82(sp),2398e <ScrollerY>
		if (ScrollerY >= ScrollerMax)
    11e8:	movea.w 82(sp),a0
    11ec:	cmpi.w #39,82(sp)
    11f2:	ble.w 1f6c <main+0x1ef8>
			ScrollerY = ScrollerMax;
    11f6:	move.w #40,2398e <ScrollerY>
			ScrollerDir = -1;
    11fe:	st 6002 <ScrollerDir>
    1204:	movea.w #40,a0
    1208:	move.w #40,82(sp)
		if (ScrollerPause < 1)
    120e:	tst.w d4
    1210:	beq.w 1cc4 <main+0x1c50>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    1214:	moveq #0,d4
    1216:	move.w 118(sp),d4
    121a:	movea.l 2398a <copScrollerBmpP>,a2
    1220:	moveq #0,d5
    1222:	move.w 23a4e <BmpScroller+0x6>,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    1228:	move.l a0,-(sp)
    122a:	move.l d5,-(sp)
    122c:	jsr 2948 <__mulsi3>
    1232:	addq.l #4,sp
    1234:	move.l d4,(sp)
    1236:	move.l d0,-(sp)
    1238:	jsr 2948 <__mulsi3>
    123e:	addq.l #8,sp
    1240:	add.l 120(sp),d0
        addr += Bpl;
    1244:	move.w #224,d1
    for (USHORT i = 0; i < numPlanes; i++)
    1248:	tst.l d4
    124a:	beq.s 1274 <main+0x1200>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
    124c:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    124e:	move.l d0,d3
    1250:	clr.w d3
    1252:	swap d3
    1254:	move.w d3,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
    1258:	move.w d1,d6
    125a:	addq.w #2,d6
    125c:	move.w d6,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    1260:	addq.l #8,a2
    1262:	move.w d0,-2(a2)
        addr += Bpl;
    1266:	add.l d5,d0
    for (USHORT i = 0; i < numPlanes; i++)
    1268:	addq.w #1,d2
    126a:	addq.w #4,d1
    126c:	moveq #0,d3
    126e:	move.w d2,d3
    1270:	cmp.l d4,d3
    1272:	blt.s 124c <main+0x11d8>
		ClearBitmapPart(BmpUpperPart_Buf1, pdb[3].X, pdb[3].Y, 32, 32);
    1274:	movea.w 23a84 <BmpUpperPart_Buf1+0x8>,a4
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    127a:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    127e:	move.w 2(a5),d0
    1282:	btst #14,d0
    1286:	bne.s 127e <main+0x120a>
	BYTE shift = x % 16;
    1288:	moveq #15,d2
    128a:	and.l 62(sp),d2
	if (shift)
    128e:	beq.w 1fd4 <main+0x1f60>
    1292:	moveq #3,d5
    1294:	moveq #-6,d4
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1296:	move.l d2,d0
    1298:	moveq #12,d1
    129a:	lsl.l d1,d0
    129c:	ori.w #2304,d0
    12a0:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    12a4:	move.w d2,d0
    12a6:	moveq #12,d3
    12a8:	lsl.w d3,d0
    12aa:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    12ae:	moveq #0,d3
    12b0:	move.w a4,d3
    12b2:	move.l 70(sp),-(sp)
    12b6:	move.l d3,-(sp)
    12b8:	jsr 2948 <__mulsi3>
    12be:	addq.l #8,sp
    12c0:	move.l 62(sp),d1
    12c4:	asr.l #3,d1
    12c6:	add.l d1,d0
    12c8:	add.l 58(sp),d0
    12cc:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    12d0:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    12d4:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    12da:	tst.l d2
    12dc:	beq.w 1faa <main+0x1f36>
    12e0:	moveq #15,d1
    12e2:	sub.l d2,d1
    12e4:	moveq #0,d0
    12e6:	not.w d0
    12e8:	lsl.l d1,d0
    12ea:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    12ee:	move.w 56(sp),d0
    12f2:	add.w d4,d0
    12f4:	move.w d0,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    12f8:	move.w d0,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    12fc:	move.w 116(sp),d4
    1300:	moveq #11,d6
    1302:	lsl.w d6,d4
    1304:	add.w d4,d5
    1306:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    130a:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    130e:	move.w 2(a5),d0
    1312:	btst #14,d0
    1316:	bne.s 130e <main+0x129a>
	BYTE shift = x % 16;
    1318:	move.l 48(sp),d6
    131c:	andi.l #-2147483633,d6
    1322:	tst.l 48(sp)
    1326:	blt.w 1c7c <main+0x1c08>
    132a:	moveq #15,d1
    132c:	and.l 48(sp),d1
    1330:	movea.l d1,a2
	if (shift)
    1332:	beq.w 1c90 <main+0x1c1c>
    1336:	moveq #3,d5
    1338:	moveq #-6,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    133a:	move.l d6,d0
    133c:	moveq #12,d1
    133e:	lsl.l d1,d0
    1340:	ori.w #2304,d0
    1344:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1348:	move.w d6,d0
    134a:	lsl.w d1,d0
    134c:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1350:	move.l d3,-(sp)
    1352:	move.l 78(sp),-(sp)
    1356:	jsr 2948 <__mulsi3>
    135c:	addq.l #8,sp
    135e:	move.l 48(sp),d1
    1362:	bmi.w 1c3c <main+0x1bc8>
    1366:	asr.l #3,d1
    1368:	add.l d1,d0
    136a:	add.l 58(sp),d0
    136e:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1372:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    1376:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    137c:	cmpa.w #0,a2
    1380:	beq.w 1c5c <main+0x1be8>
    1384:	moveq #15,d1
    1386:	sub.l d6,d1
    1388:	moveq #0,d0
    138a:	not.w d0
    138c:	lsl.l d1,d0
    138e:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1392:	add.w 56(sp),d2
    1396:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    139a:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    139e:	add.w d4,d5
    13a0:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    13a4:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    13a8:	move.w 2(a5),d0
    13ac:	btst #14,d0
    13b0:	bne.s 13a8 <main+0x1334>
	BYTE shift = x % 16;
    13b2:	move.l d7,d6
    13b4:	andi.l #-2147483633,d6
    13ba:	tst.l d7
    13bc:	blt.w 1bf8 <main+0x1b84>
    13c0:	moveq #15,d0
    13c2:	and.l d7,d0
    13c4:	movea.l d0,a2
	if (shift)
    13c6:	beq.w 1c0a <main+0x1b96>
    13ca:	moveq #3,d5
    13cc:	moveq #-6,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    13ce:	move.l d6,d0
    13d0:	moveq #12,d1
    13d2:	lsl.l d1,d0
    13d4:	ori.w #2304,d0
    13d8:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    13dc:	move.w d6,d0
    13de:	lsl.w d1,d0
    13e0:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    13e4:	move.l d3,-(sp)
    13e6:	move.l 70(sp),-(sp)
    13ea:	jsr 2948 <__mulsi3>
    13f0:	addq.l #8,sp
    13f2:	move.l d7,d1
    13f4:	bmi.w 1bb8 <main+0x1b44>
    13f8:	asr.l #3,d1
    13fa:	add.l d1,d0
    13fc:	add.l 58(sp),d0
    1400:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1404:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    1408:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    140e:	cmpa.w #0,a2
    1412:	beq.w 1bd8 <main+0x1b64>
    1416:	moveq #15,d1
    1418:	sub.l d6,d1
    141a:	moveq #0,d0
    141c:	not.w d0
    141e:	lsl.l d1,d0
    1420:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1424:	add.w 56(sp),d2
    1428:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    142c:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    1430:	add.w d4,d5
    1432:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1436:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    143a:	move.w 2(a5),d0
    143e:	move.w d0,d2
    1440:	andi.w #16384,d2
    1444:	btst #14,d0
    1448:	bne.s 143a <main+0x13c6>
	BYTE shift = x % 16;
    144a:	move.l 52(sp),d6
    144e:	andi.l #-2147483633,d6
    1454:	tst.l 52(sp)
    1458:	blt.w 1b6e <main+0x1afa>
    145c:	moveq #15,d0
    145e:	and.l 52(sp),d0
    1462:	movea.l d0,a2
	if (shift)
    1464:	beq.w 1b82 <main+0x1b0e>
    1468:	movea.w #3,a6
    146c:	moveq #-6,d5
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    146e:	move.l d6,d0
    1470:	moveq #12,d1
    1472:	lsl.l d1,d0
    1474:	ori.w #2304,d0
    1478:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    147c:	move.w d6,d0
    147e:	lsl.w d1,d0
    1480:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1484:	move.l d3,-(sp)
    1486:	move.l 82(sp),-(sp)
    148a:	jsr 2948 <__mulsi3>
    1490:	addq.l #8,sp
    1492:	move.l 52(sp),d1
    1496:	bmi.w 195a <main+0x18e6>
    149a:	asr.l #3,d1
    149c:	add.l d1,d0
    149e:	add.l 58(sp),d0
    14a2:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    14a6:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    14aa:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    14b0:	cmpa.w #0,a2
    14b4:	beq.w 197a <main+0x1906>
    14b8:	movea.w #15,a0
    14bc:	suba.l d6,a0
    14be:	moveq #0,d0
    14c0:	not.w d0
    14c2:	move.l a0,d6
    14c4:	lsl.l d6,d0
    14c6:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    14ca:	add.w 56(sp),d5
    14ce:	move.w d5,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    14d2:	move.w d5,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    14d6:	add.w a6,d4
    14d8:	move.w d4,88(a5)
			pdb[b].X += incX[b];
    14dc:	movea.l 52(sp),a2
    14e0:	move.w 112(sp),d4
    14e4:	move.w d4,d5
    14e6:	ext.l d5
    14e8:	lea (0,a2,d5.l),a2
    14ec:	move.l a2,52(sp)
			pdb[b].Y += incY[b];
    14f0:	movea.l 78(sp),a2
    14f4:	move.w 100(sp),d4
    14f8:	move.w d4,d5
    14fa:	ext.l d5
    14fc:	lea (0,a2,d5.l),a2
    1500:	move.l a2,78(sp)
			if (pdb[b].X >= 320 - 32)
    1504:	cmpi.l #287,52(sp)
    150c:	ble.w 19c6 <main+0x1952>
				incX[b] *= -1;
    1510:	neg.w 112(sp)
    1514:	clr.w 124(sp)
    1518:	movea.w #36,a2
    151c:	move.w #4042,d4
    1520:	clr.l 136(sp)
    1524:	suba.l a6,a6
				pdb[b].X = 320 - 32;
    1526:	move.l #288,52(sp)
			if (pdb[b].Y >= 130 - 32)
    152e:	moveq #97,d0
    1530:	cmp.l 78(sp),d0
    1534:	bge.w 19f0 <main+0x197c>
				incY[b] *= -1;
    1538:	neg.w 100(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    153c:	move.w a4,d0
    153e:	mulu.w #98,d0
    1542:	adda.l d0,a2
				pdb[b].Y = 130 - 32;
    1544:	movea.w #98,a0
    1548:	move.l a0,78(sp)
			pdb[b].X += incX[b];
    154c:	movea.w 114(sp),a1
    1550:	move.w a1,d0
    1552:	ext.l d0
    1554:	movea.l d7,a0
    1556:	lea (0,a0,d0.l),a1
    155a:	move.l a1,d7
			pdb[b].Y += incY[b];
    155c:	movea.l 66(sp),a0
    1560:	move.w 106(sp),d5
    1564:	move.w d5,d6
    1566:	ext.l d6
    1568:	lea (0,a0,d6.l),a0
    156c:	move.l a0,66(sp)
			if (pdb[b].X >= 320 - 32)
    1570:	cmpa.w #287,a1
    1574:	ble.w 1a2c <main+0x19b8>
				incX[b] *= -1;
    1578:	neg.w 114(sp)
    157c:	clr.w 128(sp)
    1580:	moveq #36,d1
    1582:	move.l d1,96(sp)
    1586:	move.w #4042,126(sp)
    158c:	clr.l 140(sp)
    1590:	clr.l 84(sp)
				pdb[b].X = 320 - 32;
    1594:	move.l #288,d7
			if (pdb[b].Y >= 130 - 32)
    159a:	moveq #97,d5
    159c:	cmp.l 66(sp),d5
    15a0:	bge.w 1a5a <main+0x19e6>
				incY[b] *= -1;
    15a4:	neg.w 106(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    15a8:	move.w a4,d0
    15aa:	mulu.w #98,d0
    15ae:	add.l d0,96(sp)
				pdb[b].Y = 130 - 32;
    15b2:	movea.w #98,a0
    15b6:	move.l a0,66(sp)
			pdb[b].X += incX[b];
    15ba:	movea.l 48(sp),a1
    15be:	move.w 110(sp),d5
    15c2:	move.w d5,d6
    15c4:	ext.l d6
    15c6:	lea (0,a1,d6.l),a1
    15ca:	move.l a1,48(sp)
			pdb[b].Y += incY[b];
    15ce:	movea.l 74(sp),a0
    15d2:	move.w 102(sp),d5
    15d6:	move.w d5,d6
    15d8:	ext.l d6
    15da:	lea (0,a0,d6.l),a0
    15de:	move.l a0,74(sp)
			if (pdb[b].X >= 320 - 32)
    15e2:	cmpa.w #287,a1
    15e6:	ble.w 1a9a <main+0x1a26>
				incX[b] *= -1;
    15ea:	neg.w 110(sp)
    15ee:	clr.w 132(sp)
    15f2:	moveq #36,d1
    15f4:	move.l d1,44(sp)
    15f8:	move.w #4042,130(sp)
    15fe:	clr.l 144(sp)
    1602:	clr.l 88(sp)
				pdb[b].X = 320 - 32;
    1606:	move.l #288,48(sp)
			if (pdb[b].Y >= 130 - 32)
    160e:	moveq #97,d6
    1610:	cmp.l 74(sp),d6
    1614:	bge.w 1aca <main+0x1a56>
				incY[b] *= -1;
    1618:	neg.w 102(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    161c:	move.w a4,d0
    161e:	mulu.w #98,d0
    1622:	add.l d0,44(sp)
				pdb[b].Y = 130 - 32;
    1626:	movea.w #98,a0
    162a:	move.l a0,74(sp)
			pdb[b].X += incX[b];
    162e:	movea.l 62(sp),a1
    1632:	move.w 108(sp),d5
    1636:	move.w d5,d6
    1638:	ext.l d6
    163a:	lea (0,a1,d6.l),a1
    163e:	move.l a1,62(sp)
			pdb[b].Y += incY[b];
    1642:	movea.l 70(sp),a0
    1646:	move.w 104(sp),d5
    164a:	move.w d5,d6
    164c:	ext.l d6
    164e:	lea (0,a0,d6.l),a0
    1652:	move.l a0,70(sp)
			if (pdb[b].X >= 320 - 32)
    1656:	cmpa.w #287,a1
    165a:	ble.w 1b0a <main+0x1a96>
				incX[b] *= -1;
    165e:	neg.w 108(sp)
    1662:	moveq #36,d6
    1664:	move.w #4042,134(sp)
    166a:	clr.l 148(sp)
    166e:	clr.l 92(sp)
				pdb[b].X = 320 - 32;
    1672:	move.l #288,62(sp)
			if (pdb[b].Y >= 130 - 32)
    167a:	moveq #97,d0
    167c:	cmp.l 70(sp),d0
    1680:	bge.w 1b34 <main+0x1ac0>
				incY[b] *= -1;
    1684:	neg.w 104(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1688:	move.w a4,d0
    168a:	mulu.w #98,d0
    168e:	add.l d0,d6
				pdb[b].Y = 130 - 32;
    1690:	movea.w #98,a0
    1694:	move.l a0,70(sp)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, ps2, pdb[0], 32, 32);
    1698:	movea.w 239e4 <BmpCookie+0x4>,a4
    169e:	move.w 239e6 <BmpCookie+0x6>,d1
    16a4:	movea.l 239ee <BmpCookie+0xe>,a1
    16aa:	move.w 239b2 <BmpCookieMask+0x6>,d0
    16b0:	movea.l 239ba <BmpCookieMask+0xe>,a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    16b6:	move.w 2(a5),d3
    16ba:	move.l 44(sp),d5
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    16be:	move.w 2(a5),d3
    16c2:	btst #14,d3
    16c6:	bne.s 16be <main+0x164a>
	if (shift)
    16c8:	move.l d5,44(sp)
    16cc:	cmpa.w #0,a6
    16d0:	beq.w 202c <main+0x1fb8>
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    16d4:	move.w d4,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    16d8:	move.w 124(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    16de:	move.l a1,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    16e2:	move.w d1,d3
    16e4:	subq.w #6,d3
    16e6:	move.w d3,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    16ea:	move.l a0,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    16ee:	move.w d0,d3
    16f0:	subq.w #6,d3
    16f2:	move.w d3,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    16f6:	adda.l 58(sp),a2
    16fa:	move.l a2,84(a5)
    16fe:	move.l a2,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1702:	move.w 56(sp),d3
    1706:	subq.w #6,d3
    1708:	move.w d3,102(a5)
    170c:	move.w d3,96(a5)
	custom->bltafwm = 0xffff;
    1710:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1716:	movea.w #15,a2
    171a:	suba.l 136(sp),a2
    171e:	moveq #0,d3
    1720:	not.w d3
    1722:	move.l a2,d4
    1724:	lsl.l d4,d3
    1726:	movea.w #3,a2
    172a:	move.w d3,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    172e:	moveq #0,d3
    1730:	move.w a4,d3
    1732:	moveq #11,d4
    1734:	lsl.l d4,d3
    1736:	move.w a2,d5
    1738:	or.w d3,d5
    173a:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    173e:	movea.w 2(a5),a2
    1742:	move.l 44(sp),d5
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1746:	move.w 2(a5),d4
    174a:	btst #14,d4
    174e:	bne.s 1746 <main+0x16d2>
	if (shift)
    1750:	move.l d5,44(sp)
    1754:	tst.l 84(sp)
    1758:	beq.w 2020 <main+0x1fac>
    175c:	movea.w #3,a2
    1760:	movea.w #6,a4
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1764:	move.w 126(sp),64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    176a:	move.w 128(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1770:	lea 6(a1),a6
    1774:	move.l a6,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    1778:	movea.w d1,a6
    177a:	suba.w a4,a6
    177c:	move.w a6,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1780:	lea 6(a0),a6
    1784:	move.l a6,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1788:	movea.w d0,a6
    178a:	suba.w a4,a6
    178c:	move.w a6,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1790:	move.l 58(sp),d4
    1794:	add.l 96(sp),d4
    1798:	move.l d4,84(a5)
    179c:	move.l d4,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    17a0:	move.w 56(sp),d4
    17a4:	sub.w a4,d4
    17a6:	move.w d4,102(a5)
    17aa:	move.w d4,96(a5)
	custom->bltafwm = 0xffff;
    17ae:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    17b4:	tst.l 84(sp)
    17b8:	beq.w 2006 <main+0x1f92>
    17bc:	movea.w #15,a4
    17c0:	suba.l 140(sp),a4
    17c4:	moveq #0,d4
    17c6:	not.w d4
    17c8:	move.l a4,d5
    17ca:	lsl.l d5,d4
    17cc:	move.w d4,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    17d0:	move.w a2,d4
    17d2:	or.w d3,d4
    17d4:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    17d8:	move.w 2(a5),d4
    17dc:	move.l 44(sp),d5
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    17e0:	move.w 2(a5),d4
    17e4:	btst #14,d4
    17e8:	bne.s 17e0 <main+0x176c>
	if (shift)
    17ea:	move.l d5,44(sp)
    17ee:	tst.l 88(sp)
    17f2:	beq.w 1ffa <main+0x1f86>
    17f6:	movea.w #3,a6
    17fa:	movea.w #6,a2
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    17fe:	move.w 130(sp),64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1804:	move.w 132(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    180a:	lea 12(a1),a4
    180e:	move.l a4,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    1812:	movea.w d1,a4
    1814:	suba.w a2,a4
    1816:	move.w a4,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    181a:	lea 12(a0),a4
    181e:	move.l a4,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1822:	movea.w d0,a4
    1824:	suba.w a2,a4
    1826:	move.w a4,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    182a:	add.l 58(sp),d5
    182e:	move.l d5,84(a5)
    1832:	move.l d5,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1836:	move.w 56(sp),d5
    183a:	sub.w a2,d5
    183c:	move.w d5,102(a5)
    1840:	move.w d5,96(a5)
	custom->bltafwm = 0xffff;
    1844:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    184a:	tst.l 88(sp)
    184e:	beq.w 1fe4 <main+0x1f70>
    1852:	movea.w #15,a2
    1856:	suba.l 144(sp),a2
    185a:	moveq #0,d5
    185c:	not.w d5
    185e:	move.l a2,d4
    1860:	lsl.l d4,d5
    1862:	move.w d5,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1866:	move.w a6,d4
    1868:	or.w d3,d4
    186a:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    186e:	move.w 2(a5),d4
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1872:	move.w 2(a5),d4
    1876:	btst #14,d4
    187a:	bne.s 1872 <main+0x17fe>
	if (shift)
    187c:	tst.l 92(sp)
    1880:	beq.w 1fdc <main+0x1f68>
    1884:	moveq #3,d4
    1886:	moveq #6,d5
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1888:	move.w 134(sp),64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    188e:	move.w d2,66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1892:	lea 18(a1),a1
    1896:	move.l a1,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    189a:	sub.w d5,d1
    189c:	move.w d1,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    18a0:	lea 18(a0),a0
    18a4:	move.l a0,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    18a8:	sub.w d5,d0
    18aa:	move.w d0,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    18ae:	add.l 58(sp),d6
    18b2:	move.l d6,84(a5)
    18b6:	move.l d6,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    18ba:	move.w 56(sp),d0
    18be:	sub.w d5,d0
    18c0:	move.w d0,102(a5)
    18c4:	move.w d0,96(a5)
	custom->bltafwm = 0xffff;
    18c8:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    18ce:	tst.l 92(sp)
    18d2:	beq.w 1f92 <main+0x1f1e>
    18d6:	moveq #15,d1
    18d8:	sub.l 148(sp),d1
    18dc:	moveq #0,d0
    18de:	not.w d0
    18e0:	lsl.l d1,d0
    18e2:	move.w d0,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    18e6:	or.w d4,d3
    18e8:	move.w d3,88(a5)

void MoveStarfield()
{
	BYTE hpos;
	int line = 1;
	for (int l = 0; l < 93; l++)
    18ec:	lea 233dd <StarSprite+0x1>,a2
    18f2:	moveq #0,d2
	{
		switch (l % 3)
    18f4:	pea 3 <_start+0x3>
    18f8:	move.l d2,-(sp)
    18fa:	jsr (a3)
    18fc:	addq.l #8,sp
    18fe:	moveq #1,d5
    1900:	cmp.l d0,d5
    1902:	beq.w 1f0c <main+0x1e98>
    1906:	subq.l #2,d0
    1908:	beq.w 1f22 <main+0x1eae>
		{
		case 0:
			((volatile UBYTE *)StarSprite)[line] += 3;
    190c:	move.b (a2),d0
    190e:	addq.b #3,d0
    1910:	move.b d0,(a2)
	for (int l = 0; l < 93; l++)
    1912:	addq.l #1,d2
    1914:	addq.l #8,a2
    1916:	moveq #93,d0
    1918:	cmp.l d2,d0
    191a:	bne.s 18f4 <main+0x1880>
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    191c:	move.b bfe001 <_end+0xbda471>,d0
	while (!MouseLeft())
    1922:	btst #6,d0
    1926:	beq.w 20d8 <main+0x2064>
    192a:	move.l 23abe <BmpUpperPart_PF2+0xe>,d3
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    1930:	move.l dff004 <_end+0xddb474>,d0
    1936:	move.l d0,156(sp)
		vpos &= 0x1ff00;
    193a:	move.l 156(sp),d0
    193e:	andi.l #130816,d0
    1944:	move.l d0,156(sp)
		if (vpos != (311 << 8))
    1948:	move.l 156(sp),d0
    194c:	cmpi.l #79616,d0
    1952:	beq.w 10ee <main+0x107a>
    1956:	bra.w 1112 <main+0x109e>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    195a:	addq.l #7,d1
    195c:	asr.l #3,d1
    195e:	add.l d1,d0
    1960:	add.l 58(sp),d0
    1964:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1968:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    196c:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    1972:	cmpa.w #0,a2
    1976:	bne.w 14b8 <main+0x1444>
    197a:	moveq #-1,d0
    197c:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1980:	add.w 56(sp),d5
    1984:	move.w d5,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    1988:	move.w d5,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    198c:	add.w a6,d4
    198e:	move.w d4,88(a5)
			pdb[b].X += incX[b];
    1992:	movea.l 52(sp),a2
    1996:	move.w 112(sp),d4
    199a:	move.w d4,d5
    199c:	ext.l d5
    199e:	lea (0,a2,d5.l),a2
    19a2:	move.l a2,52(sp)
			pdb[b].Y += incY[b];
    19a6:	movea.l 78(sp),a2
    19aa:	move.w 100(sp),d4
    19ae:	move.w d4,d5
    19b0:	ext.l d5
    19b2:	lea (0,a2,d5.l),a2
    19b6:	move.l a2,78(sp)
			if (pdb[b].X >= 320 - 32)
    19ba:	cmpi.l #287,52(sp)
    19c2:	bgt.w 1510 <main+0x149c>
			if (pdb[b].X <= 0)
    19c6:	tst.l 52(sp)
    19ca:	bgt.w 2252 <main+0x21de>
				incX[b] *= -1;
    19ce:	neg.w 112(sp)
    19d2:	clr.w 124(sp)
    19d6:	suba.l a2,a2
    19d8:	move.w #4042,d4
    19dc:	clr.l 136(sp)
    19e0:	suba.l a6,a6
				pdb[b].X = 0;
    19e2:	clr.l 52(sp)
			if (pdb[b].Y >= 130 - 32)
    19e6:	moveq #97,d0
    19e8:	cmp.l 78(sp),d0
    19ec:	blt.w 1538 <main+0x14c4>
			if (pdb[b].Y <= 0)
    19f0:	tst.l 78(sp)
    19f4:	bgt.w 22d8 <main+0x2264>
				incY[b] *= -1;
    19f8:	neg.w 100(sp)
				pdb[b].Y = 0;
    19fc:	clr.l 78(sp)
			pdb[b].X += incX[b];
    1a00:	movea.w 114(sp),a1
    1a04:	move.w a1,d0
    1a06:	ext.l d0
    1a08:	movea.l d7,a0
    1a0a:	lea (0,a0,d0.l),a1
    1a0e:	move.l a1,d7
			pdb[b].Y += incY[b];
    1a10:	movea.l 66(sp),a0
    1a14:	move.w 106(sp),d5
    1a18:	move.w d5,d6
    1a1a:	ext.l d6
    1a1c:	lea (0,a0,d6.l),a0
    1a20:	move.l a0,66(sp)
			if (pdb[b].X >= 320 - 32)
    1a24:	cmpa.w #287,a1
    1a28:	bgt.w 1578 <main+0x1504>
			if (pdb[b].X <= 0)
    1a2c:	cmpa.w #0,a1
    1a30:	bgt.w 22aa <main+0x2236>
				incX[b] *= -1;
    1a34:	neg.w 114(sp)
    1a38:	clr.w 128(sp)
    1a3c:	clr.l 96(sp)
    1a40:	move.w #4042,126(sp)
    1a46:	clr.l 140(sp)
    1a4a:	clr.l 84(sp)
				pdb[b].X = 0;
    1a4e:	moveq #0,d7
			if (pdb[b].Y >= 130 - 32)
    1a50:	moveq #97,d5
    1a52:	cmp.l 66(sp),d5
    1a56:	blt.w 15a4 <main+0x1530>
			if (pdb[b].Y <= 0)
    1a5a:	tst.l 66(sp)
    1a5e:	bgt.w 227e <main+0x220a>
				incY[b] *= -1;
    1a62:	neg.w 106(sp)
				pdb[b].Y = 0;
    1a66:	clr.l 66(sp)
			pdb[b].X += incX[b];
    1a6a:	movea.l 48(sp),a1
    1a6e:	move.w 110(sp),d5
    1a72:	move.w d5,d6
    1a74:	ext.l d6
    1a76:	lea (0,a1,d6.l),a1
    1a7a:	move.l a1,48(sp)
			pdb[b].Y += incY[b];
    1a7e:	movea.l 74(sp),a0
    1a82:	move.w 102(sp),d5
    1a86:	move.w d5,d6
    1a88:	ext.l d6
    1a8a:	lea (0,a0,d6.l),a0
    1a8e:	move.l a0,74(sp)
			if (pdb[b].X >= 320 - 32)
    1a92:	cmpa.w #287,a1
    1a96:	bgt.w 15ea <main+0x1576>
			if (pdb[b].X <= 0)
    1a9a:	tst.l 48(sp)
    1a9e:	bgt.w 22ec <main+0x2278>
				incX[b] *= -1;
    1aa2:	neg.w 110(sp)
    1aa6:	clr.w 132(sp)
    1aaa:	clr.l 44(sp)
    1aae:	move.w #4042,130(sp)
    1ab4:	clr.l 144(sp)
    1ab8:	clr.l 88(sp)
				pdb[b].X = 0;
    1abc:	clr.l 48(sp)
			if (pdb[b].Y >= 130 - 32)
    1ac0:	moveq #97,d6
    1ac2:	cmp.l 74(sp),d6
    1ac6:	blt.w 1618 <main+0x15a4>
			if (pdb[b].Y <= 0)
    1aca:	tst.l 74(sp)
    1ace:	bgt.w 2294 <main+0x2220>
				incY[b] *= -1;
    1ad2:	neg.w 102(sp)
				pdb[b].Y = 0;
    1ad6:	clr.l 74(sp)
			pdb[b].X += incX[b];
    1ada:	movea.l 62(sp),a1
    1ade:	move.w 108(sp),d5
    1ae2:	move.w d5,d6
    1ae4:	ext.l d6
    1ae6:	lea (0,a1,d6.l),a1
    1aea:	move.l a1,62(sp)
			pdb[b].Y += incY[b];
    1aee:	movea.l 70(sp),a0
    1af2:	move.w 104(sp),d5
    1af6:	move.w d5,d6
    1af8:	ext.l d6
    1afa:	lea (0,a0,d6.l),a0
    1afe:	move.l a0,70(sp)
			if (pdb[b].X >= 320 - 32)
    1b02:	cmpa.w #287,a1
    1b06:	bgt.w 165e <main+0x15ea>
			if (pdb[b].X <= 0)
    1b0a:	tst.l 62(sp)
    1b0e:	bgt.w 231e <main+0x22aa>
				incX[b] *= -1;
    1b12:	neg.w 108(sp)
    1b16:	moveq #0,d6
    1b18:	move.w #4042,134(sp)
    1b1e:	clr.l 148(sp)
    1b22:	clr.l 92(sp)
				pdb[b].X = 0;
    1b26:	clr.l 62(sp)
			if (pdb[b].Y >= 130 - 32)
    1b2a:	moveq #97,d0
    1b2c:	cmp.l 70(sp),d0
    1b30:	blt.w 1684 <main+0x1610>
			if (pdb[b].Y <= 0)
    1b34:	tst.l 70(sp)
    1b38:	bgt.w 234a <main+0x22d6>
				incY[b] *= -1;
    1b3c:	neg.w 104(sp)
				pdb[b].Y = 0;
    1b40:	clr.l 70(sp)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, ps2, pdb[0], 32, 32);
    1b44:	movea.w 239e4 <BmpCookie+0x4>,a4
    1b4a:	move.w 239e6 <BmpCookie+0x6>,d1
    1b50:	movea.l 239ee <BmpCookie+0xe>,a1
    1b56:	move.w 239b2 <BmpCookieMask+0x6>,d0
    1b5c:	movea.l 239ba <BmpCookieMask+0xe>,a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1b62:	move.w 2(a5),d3
    1b66:	move.l 44(sp),d5
    1b6a:	bra.w 16be <main+0x164a>
	BYTE shift = x % 16;
    1b6e:	subq.l #1,d6
    1b70:	moveq #-16,d5
    1b72:	or.l d5,d6
    1b74:	addq.l #1,d6
    1b76:	moveq #15,d0
    1b78:	and.l 52(sp),d0
    1b7c:	movea.l d0,a2
	if (shift)
    1b7e:	bne.w 1468 <main+0x13f4>
    1b82:	movea.w #2,a6
    1b86:	moveq #-4,d5
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1b88:	move.l d6,d0
    1b8a:	moveq #12,d1
    1b8c:	lsl.l d1,d0
    1b8e:	ori.w #2304,d0
    1b92:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1b96:	move.w d6,d0
    1b98:	lsl.w d1,d0
    1b9a:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1b9e:	move.l d3,-(sp)
    1ba0:	move.l 82(sp),-(sp)
    1ba4:	jsr 2948 <__mulsi3>
    1baa:	addq.l #8,sp
    1bac:	move.l 52(sp),d1
    1bb0:	bpl.w 149a <main+0x1426>
    1bb4:	bra.w 195a <main+0x18e6>
    1bb8:	addq.l #7,d1
    1bba:	asr.l #3,d1
    1bbc:	add.l d1,d0
    1bbe:	add.l 58(sp),d0
    1bc2:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1bc6:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    1bca:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    1bd0:	cmpa.w #0,a2
    1bd4:	bne.w 1416 <main+0x13a2>
    1bd8:	moveq #-1,d0
    1bda:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1bde:	add.w 56(sp),d2
    1be2:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    1be6:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    1bea:	add.w d4,d5
    1bec:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1bf0:	move.w 2(a5),d0
    1bf4:	bra.w 143a <main+0x13c6>
	BYTE shift = x % 16;
    1bf8:	subq.l #1,d6
    1bfa:	moveq #-16,d5
    1bfc:	or.l d5,d6
    1bfe:	addq.l #1,d6
    1c00:	moveq #15,d0
    1c02:	and.l d7,d0
    1c04:	movea.l d0,a2
	if (shift)
    1c06:	bne.w 13ca <main+0x1356>
    1c0a:	moveq #2,d5
    1c0c:	moveq #-4,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1c0e:	move.l d6,d0
    1c10:	moveq #12,d1
    1c12:	lsl.l d1,d0
    1c14:	ori.w #2304,d0
    1c18:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1c1c:	move.w d6,d0
    1c1e:	lsl.w d1,d0
    1c20:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1c24:	move.l d3,-(sp)
    1c26:	move.l 70(sp),-(sp)
    1c2a:	jsr 2948 <__mulsi3>
    1c30:	addq.l #8,sp
    1c32:	move.l d7,d1
    1c34:	bpl.w 13f8 <main+0x1384>
    1c38:	bra.w 1bb8 <main+0x1b44>
    1c3c:	addq.l #7,d1
    1c3e:	asr.l #3,d1
    1c40:	add.l d1,d0
    1c42:	add.l 58(sp),d0
    1c46:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1c4a:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    1c4e:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    1c54:	cmpa.w #0,a2
    1c58:	bne.w 1384 <main+0x1310>
    1c5c:	moveq #-1,d0
    1c5e:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1c62:	add.w 56(sp),d2
    1c66:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    1c6a:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    1c6e:	add.w d4,d5
    1c70:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1c74:	move.w 2(a5),d0
    1c78:	bra.w 13a8 <main+0x1334>
	BYTE shift = x % 16;
    1c7c:	subq.l #1,d6
    1c7e:	moveq #-16,d0
    1c80:	or.l d0,d6
    1c82:	addq.l #1,d6
    1c84:	moveq #15,d1
    1c86:	and.l 48(sp),d1
    1c8a:	movea.l d1,a2
	if (shift)
    1c8c:	bne.w 1336 <main+0x12c2>
    1c90:	moveq #2,d5
    1c92:	moveq #-4,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1c94:	move.l d6,d0
    1c96:	moveq #12,d1
    1c98:	lsl.l d1,d0
    1c9a:	ori.w #2304,d0
    1c9e:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1ca2:	move.w d6,d0
    1ca4:	lsl.w d1,d0
    1ca6:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1caa:	move.l d3,-(sp)
    1cac:	move.l 78(sp),-(sp)
    1cb0:	jsr 2948 <__mulsi3>
    1cb6:	addq.l #8,sp
    1cb8:	move.l 48(sp),d1
    1cbc:	bpl.w 1366 <main+0x12f2>
    1cc0:	bra.w 1c3c <main+0x1bc8>
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    1cc4:	move.w 23a50 <BmpScroller+0x8>,d3
	int BltOffs = startY * theDesc.Bplt;
    1cca:	move.w d3,d4
    1ccc:	mulu.w #40,d4
	int Brcorner = height * theDesc.Bplt - 2;
    1cd0:	andi.l #65535,d3
    1cd6:	lsl.l #5,d3
    1cd8:	subq.l #2,d3
	WaitBlit();
    1cda:	movea.l 23b82 <GfxBase>,a6
    1ce0:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
    1ce4:	movea.l 23b8c <custom>,a5
    1cea:	move.w #18928,64(a5)
	custom->bltcon1 = 0x0002;
    1cf0:	move.w #2,66(a5)
	custom->bltafwm = 0xffff;
    1cf6:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    1cfc:	move.w #-1,70(a5)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
    1d02:	add.l d4,d3
    1d04:	add.l 120(sp),d3
    1d08:	move.l d3,80(a5)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
    1d0c:	move.l d3,84(a5)
	custom->bltamod = 0;
    1d10:	move.w #0,100(a5)
	custom->bltdmod = 0;
    1d16:	move.w #0,102(a5)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
    1d1c:	move.w 118(sp),d0
    1d20:	moveq #11,d1
    1d22:	lsl.w d1,d0
    1d24:	lea 23a48 <BmpScroller>,a0
    1d2a:	move.w (a0),d1
    1d2c:	lsr.w #4,d1
    1d2e:	add.w d1,d0
    1d30:	move.w d0,88(a5)
	ScrollCnt += speed;
    1d34:	move.w 23988 <ScrollCnt>,d0
    1d3a:	addq.w #4,d0
    1d3c:	move.w d0,23988 <ScrollCnt>
	if (ScrollCnt >= NextPlot)
    1d42:	cmp.w 6000 <NextPlot>,d0
    1d48:	bcc.s 1dbc <main+0x1d48>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    1d4a:	move.w 2398e <ScrollerY>,82(sp)
    1d52:	movea.w 82(sp),a0
    1d56:	move.w 23a4c <BmpScroller+0x4>,118(sp)
    1d5e:	move.l 23a56 <BmpScroller+0xe>,120(sp)
    1d66:	move.w 23a80 <BmpUpperPart_Buf1+0x4>,116(sp)
    1d6e:	move.w 23a82 <BmpUpperPart_Buf1+0x6>,56(sp)
    1d76:	move.l 23a8a <BmpUpperPart_Buf1+0xe>,58(sp)
    1d7e:	moveq #0,d4
    1d80:	move.w 118(sp),d4
    1d84:	movea.l 2398a <copScrollerBmpP>,a2
    1d8a:	moveq #0,d5
    1d8c:	move.w 23a4e <BmpScroller+0x6>,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    1d92:	move.l a0,-(sp)
    1d94:	move.l d5,-(sp)
    1d96:	jsr 2948 <__mulsi3>
    1d9c:	addq.l #4,sp
    1d9e:	move.l d4,(sp)
    1da0:	move.l d0,-(sp)
    1da2:	jsr 2948 <__mulsi3>
    1da8:	addq.l #8,sp
    1daa:	add.l 120(sp),d0
        addr += Bpl;
    1dae:	move.w #224,d1
    for (USHORT i = 0; i < numPlanes; i++)
    1db2:	tst.l d4
    1db4:	bne.w 124c <main+0x11d8>
    1db8:	bra.w 1274 <main+0x1200>
		ScrollCnt = 0;
    1dbc:	clr.w 23988 <ScrollCnt>
		PlotChar(BmpFont32, (UBYTE *)BmpFont32P, BmpScroller, (UBYTE *)BmpScroller.ImageData, startY, 32, 32);
    1dc2:	move.l 23a56 <BmpScroller+0xe>,120(sp)
    1dca:	movea.w 23a18 <BmpFont32+0x4>,a4
    1dd0:	move.w 23a1a <BmpFont32+0x6>,d5
    1dd6:	movea.w 23a1c <BmpFont32+0x8>,a1
    1ddc:	move.w 23a4e <BmpScroller+0x6>,d4
    1de2:	move.w 23a50 <BmpScroller+0x8>,d1
	UBYTE chr = Scrolltext[ScrolltextCnt++];
    1de8:	move.w 23986 <ScrolltextCnt>,d6
    1dee:	movea.w d6,a0
    1df0:	addq.w #1,a0
    1df2:	move.w a0,23986 <ScrolltextCnt>
    1df8:	moveq #0,d0
    1dfa:	move.w d6,d0
    1dfc:	lea 4526 <Scrolltext>,a2
    1e02:	move.b (0,a2,d0.l),d0
	NextPlot = 32;
    1e06:	move.w #32,6000 <NextPlot>
	if (chr == 'b')
    1e0e:	cmpi.b #98,d0
    1e12:	beq.w 2504 <main+0x2490>
	if (chr == 'm')
    1e16:	cmpi.b #109,d0
    1e1a:	beq.w 249e <main+0x242a>
	if (chr == 's')
    1e1e:	cmpi.b #115,d0
    1e22:	beq.w 23b8 <main+0x2344>
	if (chr == '!' || chr == 'I')
    1e26:	cmpi.b #33,d0
    1e2a:	beq.w 23fa <main+0x2386>
    1e2e:	cmpi.b #73,d0
    1e32:	beq.w 23fa <main+0x2386>
	if (chr == 'J')
    1e36:	cmpi.b #74,d0
    1e3a:	beq.w 240a <main+0x2396>
	if (chr == 0)
    1e3e:	tst.b d0
    1e40:	bne.w 254a <main+0x24d6>
		chr = Scrolltext[ScrolltextCnt++];
    1e44:	move.w #1,23986 <ScrolltextCnt>
	if (chr < 32 || chr > (32 + 80))
    1e4c:	moveq #40,d0
	row = chr / 10;
    1e4e:	ext.w d0
    1e50:	moveq #10,d6
    1e52:	ext.l d0
    1e54:	divs.w d6,d0
    1e56:	move.l d0,d6
    1e58:	swap d6
    1e5a:	movea.w d6,a0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    1e5c:	clr.w d6
    1e5e:	move.b d0,d6
    1e60:	move.w a1,d0
    1e62:	mulu.w d0,d6
    1e64:	lsl.l #5,d6
	col = chr % 10;
    1e66:	move.w a0,d3
    1e68:	moveq #0,d0
    1e6a:	move.b d3,d0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    1e6c:	add.l d0,d0
    1e6e:	add.l d0,d0
    1e70:	add.l d0,d6
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    1e72:	mulu.w #40,d1
    1e76:	moveq #0,d0
    1e78:	move.w 23b52 <Screen+0x6>,d0
    1e7e:	movea.l d1,a2
    1e80:	adda.l d0,a2
	WaitBlit();
    1e82:	movea.l 23b82 <GfxBase>,a6
    1e88:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    1e8c:	movea.l 23b8c <custom>,a5
    1e92:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
    1e98:	move.w #0,66(a5)
	custom->bltafwm = 0xffff;
    1e9e:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    1ea4:	move.w #-1,70(a5)
	custom->bltapt = bmpFontP + source;
    1eaa:	addi.l #37062,d6
    1eb0:	move.l d6,80(a5)
	custom->bltdpt = bmpDestP + dest;
    1eb4:	adda.l 120(sp),a2
    1eb8:	move.l a2,84(a5)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    1ebc:	subq.w #4,d5
    1ebe:	move.w d5,100(a5)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    1ec2:	subq.w #4,d4
    1ec4:	move.w d4,102(a5)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    1ec8:	move.w a4,d0
    1eca:	moveq #11,d4
    1ecc:	lsl.w d4,d0
    1ece:	addq.w #2,d0
    1ed0:	move.w d0,88(a5)
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    1ed4:	move.w 2398e <ScrollerY>,82(sp)
    1edc:	movea.w 82(sp),a0
    1ee0:	move.w 23a4c <BmpScroller+0x4>,118(sp)
    1ee8:	move.l 23a56 <BmpScroller+0xe>,120(sp)
    1ef0:	move.w 23a80 <BmpUpperPart_Buf1+0x4>,116(sp)
    1ef8:	move.w 23a82 <BmpUpperPart_Buf1+0x6>,56(sp)
    1f00:	move.l 23a8a <BmpUpperPart_Buf1+0xe>,58(sp)
    1f08:	bra.w 1d7e <main+0x1d0a>
			break;
		case 1:
			((volatile UBYTE *)StarSprite)[line] += 1;
    1f0c:	move.b (a2),d0
    1f0e:	addq.b #1,d0
    1f10:	move.b d0,(a2)
	for (int l = 0; l < 93; l++)
    1f12:	addq.l #1,d2
    1f14:	addq.l #8,a2
    1f16:	moveq #93,d0
    1f18:	cmp.l d2,d0
    1f1a:	bne.w 18f4 <main+0x1880>
    1f1e:	bra.w 191c <main+0x18a8>
			break;
		case 2:
			((volatile UBYTE *)StarSprite)[line] += 2;
    1f22:	move.b (a2),d0
    1f24:	addq.b #2,d0
    1f26:	move.b d0,(a2)
	for (int l = 0; l < 93; l++)
    1f28:	addq.l #1,d2
    1f2a:	addq.l #8,a2
    1f2c:	moveq #93,d0
    1f2e:	cmp.l d2,d0
    1f30:	bne.w 18f4 <main+0x1880>
    1f34:	bra.w 191c <main+0x18a8>
			StarSprite[line++] = 0x8000; //color-3
    1f38:	move.w #-32768,6(a4)
		vpos += 2;
    1f3e:	addq.b #2,d7
	for (int l = 0; l < 93; l++)
    1f40:	addq.l #1,d6
    1f42:	addq.l #8,a4
    1f44:	cmpi.b #-26,d7
    1f48:	bne.w f8e <main+0xf1a>
    1f4c:	bra.w fea <main+0xf76>
			StarSprite[line++] = 0x0000; //color-2
    1f50:	clr.w 4(a4)
			StarSprite[line++] = 0x8000; //color-2
    1f54:	move.w #-32768,6(a4)
		vpos += 2;
    1f5a:	addq.b #2,d7
	for (int l = 0; l < 93; l++)
    1f5c:	addq.l #1,d6
    1f5e:	addq.l #8,a4
    1f60:	cmpi.b #-26,d7
    1f64:	bne.w f8e <main+0xf1a>
    1f68:	bra.w fea <main+0xf76>
		else if (ScrollerY <= ScrollerMin)
    1f6c:	cmpa.w #0,a0
    1f70:	bgt.w 120e <main+0x119a>
			ScrollerY = ScrollerMin;
    1f74:	clr.w 2398e <ScrollerY>
			ScrollerDir = 1;
    1f7a:	move.b #1,6002 <ScrollerDir>
    1f82:	suba.l a0,a0
    1f84:	clr.w 82(sp)
		if (ScrollerPause < 1)
    1f88:	tst.w d4
    1f8a:	bne.w 1214 <main+0x11a0>
    1f8e:	bra.w 1cc4 <main+0x1c50>
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1f92:	moveq #-1,d0
    1f94:	move.w d0,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1f98:	or.w d4,d3
    1f9a:	move.w d3,88(a5)
	for (int l = 0; l < 93; l++)
    1f9e:	lea 233dd <StarSprite+0x1>,a2
    1fa4:	moveq #0,d2
    1fa6:	bra.w 18f4 <main+0x1880>
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    1faa:	moveq #-1,d0
    1fac:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1fb0:	move.w 56(sp),d0
    1fb4:	add.w d4,d0
    1fb6:	move.w d0,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    1fba:	move.w d0,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    1fbe:	move.w 116(sp),d4
    1fc2:	moveq #11,d6
    1fc4:	lsl.w d6,d4
    1fc6:	add.w d4,d5
    1fc8:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1fcc:	move.w 2(a5),d0
    1fd0:	bra.w 130e <main+0x129a>
	if (shift)
    1fd4:	moveq #2,d5
    1fd6:	moveq #-4,d4
    1fd8:	bra.w 1296 <main+0x1222>
	if (shift)
    1fdc:	moveq #2,d4
    1fde:	moveq #4,d5
    1fe0:	bra.w 1888 <main+0x1814>
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1fe4:	moveq #-1,d5
    1fe6:	move.w d5,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1fea:	move.w a6,d4
    1fec:	or.w d3,d4
    1fee:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1ff2:	move.w 2(a5),d4
    1ff6:	bra.w 1872 <main+0x17fe>
	if (shift)
    1ffa:	movea.w #2,a6
    1ffe:	movea.w #4,a2
    2002:	bra.w 17fe <main+0x178a>
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    2006:	moveq #-1,d4
    2008:	move.w d4,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    200c:	move.w a2,d4
    200e:	or.w d3,d4
    2010:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    2014:	move.w 2(a5),d4
    2018:	move.l 44(sp),d5
    201c:	bra.w 17e0 <main+0x176c>
	if (shift)
    2020:	movea.w #2,a2
    2024:	movea.w #4,a4
    2028:	bra.w 1764 <main+0x16f0>
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    202c:	move.w d4,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    2030:	move.w 124(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    2036:	move.l a1,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    203a:	move.w d1,d3
    203c:	subq.w #4,d3
    203e:	move.w d3,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    2042:	move.l a0,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    2046:	move.w d0,d3
    2048:	subq.w #4,d3
    204a:	move.w d3,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    204e:	adda.l 58(sp),a2
    2052:	move.l a2,84(a5)
    2056:	move.l a2,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    205a:	move.w 56(sp),d3
    205e:	subq.w #4,d3
    2060:	move.w d3,102(a5)
    2064:	move.w d3,96(a5)
	custom->bltafwm = 0xffff;
    2068:	move.w #-1,68(a5)
    206e:	movea.w #2,a2
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    2072:	moveq #-1,d3
    2074:	move.w d3,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    2078:	moveq #0,d3
    207a:	move.w a4,d3
    207c:	moveq #11,d4
    207e:	lsl.l d4,d3
    2080:	move.w a2,d5
    2082:	or.w d3,d5
    2084:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    2088:	movea.w 2(a5),a2
    208c:	move.l 44(sp),d5
    2090:	bra.w 1746 <main+0x16d2>
				ScrollerDir -= 1;
    2094:	subq.b #1,d0
				if (ScrollerDir < -4)
    2096:	cmpi.b #-4,d0
    209a:	bge.w 2234 <main+0x21c0>
					ScrollerDir = -4;
    209e:	move.b #-4,6002 <ScrollerDir>
    20a6:	moveq #-4,d0
			ScrollerY += ScrollerDir;
    20a8:	add.w d0,82(sp)
    20ac:	move.w 82(sp),2398e <ScrollerY>
    20b4:	bra.w 11e8 <main+0x1174>
				if (ScrollerDir < 1)
    20b8:	tst.b d0
    20ba:	bgt.w 25c6 <main+0x2552>
					ScrollerDir = 1;
    20be:	move.b #1,6002 <ScrollerDir>
    20c6:	moveq #1,d0
			ScrollerY += ScrollerDir;
    20c8:	add.w d0,82(sp)
    20cc:	move.w 82(sp),2398e <ScrollerY>
    20d4:	bra.w 11e8 <main+0x1174>
    20d8:	movea.l 239a6 <copPtr>,a2
	FreeMem(copPtr, 1024);
    20de:	movea.l 23b86 <SysBase>,a6
    20e4:	movea.l a2,a1
    20e6:	move.l #1024,d0
    20ec:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    20f0:	movea.l 23b86 <SysBase>,a6
    20f6:	movea.l 23a56 <BmpScroller+0xe>,a1
    20fc:	moveq #0,d0
    20fe:	move.w 23a54 <BmpScroller+0xc>,d0
    2104:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    2108:	movea.l 23b86 <SysBase>,a6
    210e:	movea.l 23af2 <BmpUpperPart_PF1+0xe>,a1
    2114:	moveq #0,d0
    2116:	move.w 23af0 <BmpUpperPart_PF1+0xc>,d0
    211c:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    2120:	movea.l 23b86 <SysBase>,a6
    2126:	movea.l 23abe <BmpUpperPart_PF2+0xe>,a1
    212c:	moveq #0,d0
    212e:	move.w 23abc <BmpUpperPart_PF2+0xc>,d0
    2134:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_Buf1.ImageData, BmpUpperPart_PF2.Btot);
    2138:	movea.l 23b86 <SysBase>,a6
    213e:	movea.l 23a8a <BmpUpperPart_Buf1+0xe>,a1
    2144:	moveq #0,d0
    2146:	move.w 23abc <BmpUpperPart_PF2+0xc>,d0
    214c:	jsr -210(a6)
	CloseLibrary((struct Library *)DOSBase);
    2150:	movea.l 23b86 <SysBase>,a6
    2156:	movea.l 23b7e <DOSBase>,a1
    215c:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    2160:	movea.l 23b86 <SysBase>,a6
    2166:	movea.l 23b82 <GfxBase>,a1
    216c:	jsr -414(a6)
	WaitVbl();
    2170:	jsr 266a <WaitVbl>
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    2176:	movea.l 23b8c <custom>,a0
    217c:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    2180:	move.w 2(a0),d0
    2184:	btst #14,d0
    2188:	bne.s 2180 <main+0x210c>
	custom->intena = 0x7fff; //disable all interrupts
    218a:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
    2190:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
    2196:	move.w #32767,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
    219c:	movea.l 239a2 <VBR>,a1
    21a2:	move.l 2399e <SystemIrq>,108(a1)
	custom->cop1lc = (ULONG)GfxBase->copinit;
    21aa:	movea.l 23b82 <GfxBase>,a6
    21b0:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
    21b6:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
    21bc:	move.w #32767,136(a0)
	custom->intena = SystemInts | 0x8000;
    21c2:	move.w 2399c <SystemInts>,d0
    21c8:	ori.w #-32768,d0
    21cc:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
    21d0:	move.w 2399a <SystemDMA>,d0
    21d6:	ori.w #-32768,d0
    21da:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
    21de:	move.w 23998 <SystemADKCON>,d0
    21e4:	ori.w #-32768,d0
    21e8:	move.w d0,158(a0)
	LoadView(ActiView);
    21ec:	movea.l 23994 <ActiView>,a1
    21f2:	jsr -222(a6)
	WaitTOF();
    21f6:	movea.l 23b82 <GfxBase>,a6
    21fc:	jsr -270(a6)
	WaitTOF();
    2200:	movea.l 23b82 <GfxBase>,a6
    2206:	jsr -270(a6)
	WaitBlit();
    220a:	movea.l 23b82 <GfxBase>,a6
    2210:	jsr -228(a6)
	DisownBlitter();
    2214:	movea.l 23b82 <GfxBase>,a6
    221a:	jsr -462(a6)
	Enable();
    221e:	movea.l 23b86 <SysBase>,a6
    2224:	jsr -126(a6)
}
    2228:	moveq #0,d0
    222a:	movem.l (sp)+,d2-d7/a2-a6
    222e:	lea 140(sp),sp
    2232:	rts
				if (ScrollerDir > -1)
    2234:	tst.b d0
    2236:	blt.w 25c6 <main+0x2552>
					ScrollerDir = -1;
    223a:	st 6002 <ScrollerDir>
    2240:	moveq #-1,d0
			ScrollerY += ScrollerDir;
    2242:	add.w d0,82(sp)
    2246:	move.w 82(sp),2398e <ScrollerY>
    224e:	bra.w 11e8 <main+0x1174>
    2252:	moveq #15,d6
    2254:	and.l 52(sp),d6
    2258:	movea.l d6,a6
	BYTE shift = startD.X % 16;
    225a:	move.l d6,136(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    225e:	move.l d6,d0
    2260:	moveq #12,d1
    2262:	lsl.l d1,d0
    2264:	move.w d0,d4
    2266:	ori.w #4042,d4
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    226a:	moveq #12,d5
    226c:	lsl.w d5,d6
    226e:	move.w d6,124(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    2272:	move.l 52(sp),d6
    2276:	asr.l #3,d6
    2278:	movea.l d6,a2
    227a:	bra.w 152e <main+0x14ba>
    227e:	move.l d3,-(sp)
    2280:	move.l 70(sp),-(sp)
    2284:	jsr 2948 <__mulsi3>
    228a:	addq.l #8,sp
    228c:	add.l d0,96(sp)
    2290:	bra.w 15ba <main+0x1546>
    2294:	move.l 74(sp),-(sp)
    2298:	move.l d3,-(sp)
    229a:	jsr 2948 <__mulsi3>
    22a0:	addq.l #8,sp
    22a2:	add.l d0,44(sp)
    22a6:	bra.w 162e <main+0x15ba>
    22aa:	moveq #15,d5
    22ac:	and.l d7,d5
    22ae:	move.l d5,84(sp)
	BYTE shift = startD.X % 16;
    22b2:	move.l d5,140(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    22b6:	move.l d5,d0
    22b8:	moveq #12,d6
    22ba:	lsl.l d6,d0
    22bc:	ori.w #4042,d0
    22c0:	move.w d0,126(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    22c4:	moveq #12,d0
    22c6:	lsl.w d0,d5
    22c8:	move.w d5,128(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    22cc:	move.l a1,d1
    22ce:	asr.l #3,d1
    22d0:	move.l d1,96(sp)
    22d4:	bra.w 159a <main+0x1526>
    22d8:	move.l d3,-(sp)
    22da:	move.l 82(sp),-(sp)
    22de:	jsr 2948 <__mulsi3>
    22e4:	addq.l #8,sp
    22e6:	adda.l d0,a2
    22e8:	bra.w 154c <main+0x14d8>
    22ec:	moveq #15,d5
    22ee:	and.l 48(sp),d5
    22f2:	move.l d5,88(sp)
	BYTE shift = startD.X % 16;
    22f6:	move.l d5,144(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    22fa:	move.l d5,d0
    22fc:	moveq #12,d6
    22fe:	lsl.l d6,d0
    2300:	ori.w #4042,d0
    2304:	move.w d0,130(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    2308:	moveq #12,d0
    230a:	lsl.w d0,d5
    230c:	move.w d5,132(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    2310:	move.l 48(sp),d5
    2314:	asr.l #3,d5
    2316:	move.l d5,44(sp)
    231a:	bra.w 160e <main+0x159a>
    231e:	moveq #15,d1
    2320:	and.l 62(sp),d1
    2324:	move.l d1,92(sp)
	BYTE shift = startD.X % 16;
    2328:	move.l d1,148(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    232c:	move.l d1,d0
    232e:	moveq #12,d5
    2330:	lsl.l d5,d0
    2332:	ori.w #4042,d0
    2336:	move.w d0,134(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    233a:	move.w d1,d2
    233c:	moveq #12,d6
    233e:	lsl.w d6,d2
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    2340:	move.l 62(sp),d6
    2344:	asr.l #3,d6
    2346:	bra.w 167a <main+0x1606>
    234a:	move.l 70(sp),-(sp)
    234e:	move.l d3,-(sp)
    2350:	jsr 2948 <__mulsi3>
    2356:	addq.l #8,sp
    2358:	add.l d0,d6
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, ps2, pdb[0], 32, 32);
    235a:	movea.w 239e4 <BmpCookie+0x4>,a4
    2360:	move.w 239e6 <BmpCookie+0x6>,d1
    2366:	movea.l 239ee <BmpCookie+0xe>,a1
    236c:	move.w 239b2 <BmpCookieMask+0x6>,d0
    2372:	movea.l 239ba <BmpCookieMask+0xe>,a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    2378:	move.w 2(a5),d3
    237c:	move.l 44(sp),d5
    2380:	bra.w 16be <main+0x164a>
		Exit(0);
    2384:	movea.l 23b7e <DOSBase>,a6
    238a:	moveq #0,d1
    238c:	jsr -144(a6)
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    2390:	movea.l 23b86 <SysBase>,a6
    2396:	lea 449e <incbin_P61_Player_end+0x12>,a1
    239c:	moveq #0,d0
    239e:	jsr -552(a6)
    23a2:	move.l d0,23b7e <DOSBase>
	if (!DOSBase)
    23a8:	bne.w c2 <main+0x4e>
		Exit(0);
    23ac:	suba.l a6,a6
    23ae:	moveq #0,d1
    23b0:	jsr -144(a6)
    23b4:	bra.w c2 <main+0x4e>
		ScrollerPause = (Scrolltext[ScrolltextCnt++] - 48) * 50;
    23b8:	move.w 23986 <ScrolltextCnt>,d0
    23be:	moveq #0,d6
    23c0:	move.w d0,d6
    23c2:	lea 4526 <Scrolltext>,a2
    23c8:	move.b (0,a2,d6.l),d6
    23cc:	ext.w d6
    23ce:	addi.w #-48,d6
    23d2:	muls.w #50,d6
    23d6:	move.w d6,23992 <ScrollerPause>
		chr = Scrolltext[ScrolltextCnt++];
    23dc:	move.w d0,d3
    23de:	addq.w #2,d3
    23e0:	move.w d3,23986 <ScrolltextCnt>
		ScrollerPause = (Scrolltext[ScrolltextCnt++] - 48) * 50;
    23e6:	addq.w #1,d0
		chr = Scrolltext[ScrolltextCnt++];
    23e8:	andi.l #65535,d0
    23ee:	move.b (0,a2,d0.l),d0
	if (chr == '!' || chr == 'I')
    23f2:	cmpi.b #33,d0
    23f6:	bne.w 1e2e <main+0x1dba>
		NextPlot = 12;
    23fa:	move.w #12,6000 <NextPlot>
	if (chr == 'J')
    2402:	cmpi.b #74,d0
    2406:	bne.w 1e3e <main+0x1dca>
		NextPlot = 24;
    240a:	move.w #24,6000 <NextPlot>
	if (chr < 32 || chr > (32 + 80))
    2412:	moveq #42,d0
	row = chr / 10;
    2414:	ext.w d0
    2416:	moveq #10,d6
    2418:	ext.l d0
    241a:	divs.w d6,d0
    241c:	move.l d0,d6
    241e:	swap d6
    2420:	movea.w d6,a0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    2422:	clr.w d6
    2424:	move.b d0,d6
    2426:	move.w a1,d0
    2428:	mulu.w d0,d6
    242a:	lsl.l #5,d6
	col = chr % 10;
    242c:	move.w a0,d3
    242e:	moveq #0,d0
    2430:	move.b d3,d0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    2432:	add.l d0,d0
    2434:	add.l d0,d0
    2436:	add.l d0,d6
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    2438:	mulu.w #40,d1
    243c:	moveq #0,d0
    243e:	move.w 23b52 <Screen+0x6>,d0
    2444:	movea.l d1,a2
    2446:	adda.l d0,a2
	WaitBlit();
    2448:	movea.l 23b82 <GfxBase>,a6
    244e:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    2452:	movea.l 23b8c <custom>,a5
    2458:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
    245e:	move.w #0,66(a5)
	custom->bltafwm = 0xffff;
    2464:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    246a:	move.w #-1,70(a5)
	custom->bltapt = bmpFontP + source;
    2470:	addi.l #37062,d6
    2476:	move.l d6,80(a5)
	custom->bltdpt = bmpDestP + dest;
    247a:	adda.l 120(sp),a2
    247e:	move.l a2,84(a5)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    2482:	subq.w #4,d5
    2484:	move.w d5,100(a5)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    2488:	subq.w #4,d4
    248a:	move.w d4,102(a5)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    248e:	move.w a4,d0
    2490:	moveq #11,d4
    2492:	lsl.w d4,d0
    2494:	addq.w #2,d0
    2496:	move.w d0,88(a5)
    249a:	bra.w 1ed4 <main+0x1e60>
		if (MirrorEnabled)
    249e:	move.w 23984 <MirrorEnabled>,d0
				 BmpScroller.Bplt - Screen.Bpl);
    24a4:	move.w d1,d6
    24a6:	sub.w 23b52 <Screen+0x6>,d6
	copSetBplMod(0, copMirrorBmpP,
    24ac:	movea.l 23980 <copMirrorBmpP>,a0
		if (MirrorEnabled)
    24b2:	tst.w d0
    24b4:	beq.w 25de <main+0x256a>
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    24b8:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    24bc:	move.w d6,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    24c0:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    24c6:	move.w d6,6(a0)
		MirrorEnabled = !MirrorEnabled;
    24ca:	tst.w d0
    24cc:	seq d0
    24ce:	ext.w d0
    24d0:	neg.w d0
    24d2:	move.w d0,23984 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    24d8:	move.w 23986 <ScrolltextCnt>,d0
    24de:	movea.w d0,a2
    24e0:	addq.w #1,a2
    24e2:	move.w a2,23986 <ScrolltextCnt>
    24e8:	andi.l #65535,d0
    24ee:	lea 4526 <Scrolltext>,a0
    24f4:	move.b (0,a0,d0.l),d0
	if (chr == 's')
    24f8:	cmpi.b #115,d0
    24fc:	bne.w 1e26 <main+0x1db2>
    2500:	bra.w 23b8 <main+0x2344>
		if (BounceEnabled)
    2504:	move.w 23990 <BounceEnabled>,d0
    250a:	beq.s 251a <main+0x24a6>
			ScrollerY = SCRT_MIN;
    250c:	clr.w 2398e <ScrollerY>
			ScrollerDir = 1;
    2512:	move.b #1,6002 <ScrollerDir>
		BounceEnabled = !BounceEnabled;
    251a:	tst.w d0
    251c:	seq d0
    251e:	ext.w d0
    2520:	neg.w d0
    2522:	move.w d0,23990 <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    2528:	addq.w #2,d6
    252a:	move.w d6,23986 <ScrolltextCnt>
    2530:	moveq #0,d0
    2532:	move.w a0,d0
    2534:	lea 4526 <Scrolltext>,a0
    253a:	move.b (0,a0,d0.l),d0
	if (chr == 'm')
    253e:	cmpi.b #109,d0
    2542:	bne.w 1e1e <main+0x1daa>
    2546:	bra.w 249e <main+0x242a>
	if (chr < 32 || chr > (32 + 80))
    254a:	addi.b #-32,d0
    254e:	cmpi.b #80,d0
    2552:	bls.w 1e4e <main+0x1dda>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    2556:	move.w 2398e <ScrollerY>,82(sp)
    255e:	movea.w 82(sp),a0
    2562:	move.w 23a4c <BmpScroller+0x4>,118(sp)
    256a:	move.w 23a80 <BmpUpperPart_Buf1+0x4>,116(sp)
    2572:	move.w 23a82 <BmpUpperPart_Buf1+0x6>,56(sp)
    257a:	move.l 23a8a <BmpUpperPart_Buf1+0xe>,58(sp)
    2582:	moveq #0,d4
    2584:	move.w 118(sp),d4
    2588:	movea.l 2398a <copScrollerBmpP>,a2
    258e:	moveq #0,d5
    2590:	move.w 23a4e <BmpScroller+0x6>,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    2596:	move.l a0,-(sp)
    2598:	move.l d5,-(sp)
    259a:	jsr 2948 <__mulsi3>
    25a0:	addq.l #4,sp
    25a2:	move.l d4,(sp)
    25a4:	move.l d0,-(sp)
    25a6:	jsr 2948 <__mulsi3>
    25ac:	addq.l #8,sp
    25ae:	add.l 120(sp),d0
        addr += Bpl;
    25b2:	move.w #224,d1
    for (USHORT i = 0; i < numPlanes; i++)
    25b6:	tst.l d4
    25b8:	bne.w 124c <main+0x11d8>
    25bc:	bra.w 1274 <main+0x1200>
	APTR vbr = 0;
    25c0:	moveq #0,d0
    25c2:	bra.w 85e <main+0x7ea>
				ScrollerDir -= 1;
    25c6:	move.b d0,6002 <ScrollerDir>
			ScrollerY += ScrollerDir;
    25cc:	ext.w d0
    25ce:	add.w d0,82(sp)
    25d2:	move.w 82(sp),2398e <ScrollerY>
    25da:	bra.w 11e8 <main+0x1174>
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
    25de:	movea.w d1,a2
    25e0:	adda.w d1,a2
    25e2:	sub.w a2,d6
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    25e4:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    25e8:	move.w d6,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    25ec:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    25f2:	move.w d6,6(a0)
		MirrorEnabled = !MirrorEnabled;
    25f6:	tst.w d0
    25f8:	seq d0
    25fa:	ext.w d0
    25fc:	neg.w d0
    25fe:	move.w d0,23984 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    2604:	move.w 23986 <ScrolltextCnt>,d0
    260a:	movea.w d0,a2
    260c:	addq.w #1,a2
    260e:	move.w a2,23986 <ScrolltextCnt>
    2614:	andi.l #65535,d0
    261a:	lea 4526 <Scrolltext>,a0
    2620:	move.b (0,a0,d0.l),d0
    2624:	bra.w 24f8 <main+0x2484>

00002628 <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

static __attribute__((interrupt)) void interruptHandler()
{
    2628:	movem.l d0/a0/a3/a6,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    262c:	movea.l 23b8c <custom>,a0
    2632:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    2638:	move.w #32,156(a0)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    263e:	lea 2b26 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    2644:	movea.l #14675968,a6
	__asm volatile(
    264a:	movem.l d0-a2/a4-a5,-(sp)
    264e:	jsr 4(a3)
    2652:	movem.l (sp)+,d0-a2/a4-a5

    // DEMO - ThePlayer
    p61Music();

    // DEMO - increment frameCounter
    frameCounter++;
    2656:	move.w 23b8a <frameCounter>,d0
    265c:	addq.w #1,d0
    265e:	move.w d0,23b8a <frameCounter>
}
    2664:	movem.l (sp)+,d0/a0/a3/a6
    2668:	rte

0000266a <WaitVbl>:
{
    266a:	subq.l #8,sp
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    266c:	move.l dff004 <_end+0xddb474>,d0
    2672:	move.l d0,(sp)
		vpos &= 0x1ff00;
    2674:	move.l (sp),d0
    2676:	andi.l #130816,d0
    267c:	move.l d0,(sp)
		if (vpos != (311 << 8))
    267e:	move.l (sp),d0
    2680:	cmpi.l #79616,d0
    2686:	beq.s 266c <WaitVbl+0x2>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    2688:	move.l dff004 <_end+0xddb474>,d0
    268e:	move.l d0,4(sp)
		vpos &= 0x1ff00;
    2692:	move.l 4(sp),d0
    2696:	andi.l #130816,d0
    269c:	move.l d0,4(sp)
		if (vpos == (311 << 8))
    26a0:	move.l 4(sp),d0
    26a4:	cmpi.l #79616,d0
    26aa:	bne.s 2688 <WaitVbl+0x1e>
}
    26ac:	addq.l #8,sp
    26ae:	rts

000026b0 <KPrintF>:
void KPrintF(const char* fmt, ...) {
    26b0:	lea -128(sp),sp
    26b4:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    26b8:	move.w f0ff60 <_end+0xeec3d0>,d0
    26be:	cmpi.w #20153,d0
    26c2:	beq.s 26ee <KPrintF+0x3e>
    26c4:	cmpi.w #-24562,d0
    26c8:	beq.s 26ee <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    26ca:	movea.l 23b86 <SysBase>,a6
    26d0:	movea.l 144(sp),a0
    26d4:	lea 148(sp),a1
    26d8:	lea 2a42 <KPutCharX>,a2
    26de:	suba.l a3,a3
    26e0:	jsr -522(a6)
}
    26e4:	movem.l (sp)+,a2-a3/a6
    26e8:	lea 128(sp),sp
    26ec:	rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    26ee:	movea.l 23b86 <SysBase>,a6
    26f4:	movea.l 144(sp),a0
    26f8:	lea 148(sp),a1
    26fc:	lea 2a50 <PutChar>,a2
    2702:	lea 12(sp),a3
    2706:	jsr -522(a6)
		UaeDbgLog(86, temp);
    270a:	move.l a3,-(sp)
    270c:	pea 56 <_start+0x56>
    2710:	jsr f0ff60 <_end+0xeec3d0>
    2716:	addq.l #8,sp
}
    2718:	movem.l (sp)+,a2-a3/a6
    271c:	lea 128(sp),sp
    2720:	rts

00002722 <strlen>:
unsigned long strlen(const char* s) {
    2722:	movea.l 4(sp),a0
	unsigned long t=0;
    2726:	moveq #0,d0
	while(*s++)
    2728:	tst.b (a0)
    272a:	beq.s 2734 <strlen+0x12>
		t++;
    272c:	addq.l #1,d0
	while(*s++)
    272e:	tst.b (0,a0,d0.l)
    2732:	bne.s 272c <strlen+0xa>
}
    2734:	rts

00002736 <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    2736:	movem.l d2-d7/a2-a3,-(sp)
    273a:	move.l 36(sp),d0
    273e:	move.l 40(sp),d4
    2742:	movea.l 44(sp),a1
	while(len-- > 0)
    2746:	move.l a1,d5
    2748:	subq.l #1,d5
    274a:	cmpa.w #0,a1
    274e:	beq.w 27fe <memset+0xc8>
		*ptr++ = val;
    2752:	move.b d4,d7
    2754:	move.l d0,d1
    2756:	neg.l d1
    2758:	moveq #3,d2
    275a:	and.l d2,d1
    275c:	moveq #5,d6
    275e:	movea.l d0,a2
    2760:	cmp.l d5,d6
    2762:	bcc.s 27ce <memset+0x98>
    2764:	tst.l d1
    2766:	beq.s 278c <memset+0x56>
    2768:	move.b d4,(a2)+
	while(len-- > 0)
    276a:	subq.l #1,d5
    276c:	moveq #1,d2
    276e:	cmp.l d1,d2
    2770:	beq.s 278c <memset+0x56>
		*ptr++ = val;
    2772:	movea.l d0,a2
    2774:	addq.l #2,a2
    2776:	movea.l d0,a0
    2778:	move.b d4,1(a0)
	while(len-- > 0)
    277c:	subq.l #1,d5
    277e:	moveq #3,d2
    2780:	cmp.l d1,d2
    2782:	bne.s 278c <memset+0x56>
		*ptr++ = val;
    2784:	addq.l #1,a2
    2786:	move.b d4,2(a0)
	while(len-- > 0)
    278a:	subq.l #1,d5
    278c:	move.l a1,d3
    278e:	sub.l d1,d3
    2790:	moveq #0,d6
    2792:	move.b d4,d6
    2794:	move.l d6,d2
    2796:	swap d2
    2798:	clr.w d2
    279a:	movea.l d2,a0
    279c:	move.l d4,d2
    279e:	lsl.w #8,d2
    27a0:	swap d2
    27a2:	clr.w d2
    27a4:	lsl.l #8,d6
    27a6:	movea.l d6,a3
    27a8:	move.l a0,d6
    27aa:	or.l d6,d2
    27ac:	move.l a3,d6
    27ae:	or.l d6,d2
    27b0:	move.b d7,d2
    27b2:	movea.l d0,a0
    27b4:	adda.l d1,a0
    27b6:	moveq #-4,d1
    27b8:	and.l d3,d1
    27ba:	add.l a0,d1
		*ptr++ = val;
    27bc:	move.l d2,(a0)+
	while(len-- > 0)
    27be:	cmpa.l d1,a0
    27c0:	bne.s 27bc <memset+0x86>
    27c2:	moveq #-4,d1
    27c4:	and.l d3,d1
    27c6:	adda.l d1,a2
    27c8:	sub.l d1,d5
    27ca:	cmp.l d3,d1
    27cc:	beq.s 27fe <memset+0xc8>
		*ptr++ = val;
    27ce:	move.b d4,(a2)
	while(len-- > 0)
    27d0:	tst.l d5
    27d2:	beq.s 27fe <memset+0xc8>
		*ptr++ = val;
    27d4:	move.b d4,1(a2)
	while(len-- > 0)
    27d8:	moveq #1,d1
    27da:	cmp.l d5,d1
    27dc:	beq.s 27fe <memset+0xc8>
		*ptr++ = val;
    27de:	move.b d4,2(a2)
	while(len-- > 0)
    27e2:	moveq #2,d2
    27e4:	cmp.l d5,d2
    27e6:	beq.s 27fe <memset+0xc8>
		*ptr++ = val;
    27e8:	move.b d4,3(a2)
	while(len-- > 0)
    27ec:	moveq #3,d6
    27ee:	cmp.l d5,d6
    27f0:	beq.s 27fe <memset+0xc8>
		*ptr++ = val;
    27f2:	move.b d4,4(a2)
	while(len-- > 0)
    27f6:	subq.l #4,d5
    27f8:	beq.s 27fe <memset+0xc8>
		*ptr++ = val;
    27fa:	move.b d4,5(a2)
}
    27fe:	movem.l (sp)+,d2-d7/a2-a3
    2802:	rts

00002804 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    2804:	movem.l d2-d6,-(sp)
    2808:	move.l 24(sp),d0
    280c:	move.l 28(sp),d1
    2810:	move.l 32(sp),d3
	while(len--)
    2814:	move.l d3,d4
    2816:	subq.l #1,d4
    2818:	tst.l d3
    281a:	beq.s 287a <memcpy+0x76>
    281c:	movea.l d1,a0
    281e:	addq.l #1,a0
    2820:	move.l d0,d2
    2822:	sub.l a0,d2
    2824:	moveq #2,d5
    2826:	cmp.l d2,d5
    2828:	sc.s d2
    282a:	neg.b d2
    282c:	moveq #8,d6
    282e:	cmp.l d4,d6
    2830:	sc.s d5
    2832:	neg.b d5
    2834:	and.b d5,d2
    2836:	beq.s 2880 <memcpy+0x7c>
    2838:	move.l d0,d2
    283a:	or.l d1,d2
    283c:	moveq #3,d5
    283e:	and.l d5,d2
    2840:	bne.s 2880 <memcpy+0x7c>
    2842:	movea.l d1,a0
    2844:	movea.l d0,a1
    2846:	moveq #-4,d2
    2848:	and.l d3,d2
    284a:	add.l d1,d2
		*d++ = *s++;
    284c:	move.l (a0)+,(a1)+
	while(len--)
    284e:	cmp.l a0,d2
    2850:	bne.s 284c <memcpy+0x48>
    2852:	moveq #-4,d2
    2854:	and.l d3,d2
    2856:	movea.l d0,a0
    2858:	adda.l d2,a0
    285a:	add.l d2,d1
    285c:	sub.l d2,d4
    285e:	cmp.l d3,d2
    2860:	beq.s 287a <memcpy+0x76>
		*d++ = *s++;
    2862:	movea.l d1,a1
    2864:	move.b (a1),(a0)
	while(len--)
    2866:	tst.l d4
    2868:	beq.s 287a <memcpy+0x76>
		*d++ = *s++;
    286a:	move.b 1(a1),1(a0)
	while(len--)
    2870:	subq.l #1,d4
    2872:	beq.s 287a <memcpy+0x76>
		*d++ = *s++;
    2874:	move.b 2(a1),2(a0)
}
    287a:	movem.l (sp)+,d2-d6
    287e:	rts
    2880:	movea.l d0,a1
    2882:	add.l d3,d1
		*d++ = *s++;
    2884:	move.b -1(a0),(a1)+
	while(len--)
    2888:	cmp.l a0,d1
    288a:	beq.s 287a <memcpy+0x76>
    288c:	addq.l #1,a0
    288e:	bra.s 2884 <memcpy+0x80>

00002890 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    2890:	movem.l d2-d5/a2,-(sp)
    2894:	move.l 24(sp),d0
    2898:	move.l 28(sp),d1
    289c:	move.l 32(sp),d2
		while (len--)
    28a0:	movea.l d2,a1
    28a2:	subq.l #1,a1
	if (d < s) {
    28a4:	cmp.l d0,d1
    28a6:	bls.s 2914 <memmove+0x84>
		while (len--)
    28a8:	tst.l d2
    28aa:	beq.s 290e <memmove+0x7e>
    28ac:	movea.l d1,a2
    28ae:	addq.l #1,a2
    28b0:	move.l d0,d3
    28b2:	sub.l a2,d3
    28b4:	moveq #2,d4
    28b6:	cmp.l d3,d4
    28b8:	sc.s d3
    28ba:	neg.b d3
    28bc:	moveq #8,d5
    28be:	cmp.l a1,d5
    28c0:	sc.s d4
    28c2:	neg.b d4
    28c4:	and.b d4,d3
    28c6:	beq.s 2938 <memmove+0xa8>
    28c8:	move.l d0,d3
    28ca:	or.l d1,d3
    28cc:	moveq #3,d4
    28ce:	and.l d4,d3
    28d0:	bne.s 2938 <memmove+0xa8>
    28d2:	movea.l d1,a0
    28d4:	movea.l d0,a2
    28d6:	moveq #-4,d3
    28d8:	and.l d2,d3
    28da:	add.l d1,d3
			*d++ = *s++;
    28dc:	move.l (a0)+,(a2)+
		while (len--)
    28de:	cmp.l a0,d3
    28e0:	bne.s 28dc <memmove+0x4c>
    28e2:	moveq #-4,d3
    28e4:	and.l d2,d3
    28e6:	movea.l d0,a2
    28e8:	adda.l d3,a2
    28ea:	movea.l d1,a0
    28ec:	adda.l d3,a0
    28ee:	suba.l d3,a1
    28f0:	cmp.l d2,d3
    28f2:	beq.s 290e <memmove+0x7e>
			*d++ = *s++;
    28f4:	move.b (a0),(a2)
		while (len--)
    28f6:	cmpa.w #0,a1
    28fa:	beq.s 290e <memmove+0x7e>
			*d++ = *s++;
    28fc:	move.b 1(a0),1(a2)
		while (len--)
    2902:	moveq #1,d5
    2904:	cmp.l a1,d5
    2906:	beq.s 290e <memmove+0x7e>
			*d++ = *s++;
    2908:	move.b 2(a0),2(a2)
}
    290e:	movem.l (sp)+,d2-d5/a2
    2912:	rts
		const char *lasts = s + (len - 1);
    2914:	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    2918:	adda.l d0,a1
		while (len--)
    291a:	tst.l d2
    291c:	beq.s 290e <memmove+0x7e>
    291e:	move.l a0,d1
    2920:	sub.l d2,d1
			*lastd-- = *lasts--;
    2922:	move.b (a0),(a1)
		while (len--)
    2924:	subq.l #1,a0
    2926:	subq.l #1,a1
    2928:	cmp.l a0,d1
    292a:	beq.s 290e <memmove+0x7e>
			*lastd-- = *lasts--;
    292c:	move.b (a0),(a1)
		while (len--)
    292e:	subq.l #1,a0
    2930:	subq.l #1,a1
    2932:	cmp.l a0,d1
    2934:	bne.s 2922 <memmove+0x92>
    2936:	bra.s 290e <memmove+0x7e>
    2938:	movea.l d0,a1
    293a:	add.l d2,d1
			*d++ = *s++;
    293c:	move.b -1(a2),(a1)+
		while (len--)
    2940:	cmp.l a2,d1
    2942:	beq.s 290e <memmove+0x7e>
    2944:	addq.l #1,a2
    2946:	bra.s 293c <memmove+0xac>

00002948 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    2948:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    294c:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2950:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    2954:	mulu.w 8(sp),d1
	addw	d1, d0
    2958:	add.w d1,d0
	swap	d0
    295a:	swap d0
	clrw	d0
    295c:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    295e:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    2962:	mulu.w 10(sp),d1
	addl	d1, d0
    2966:	add.l d1,d0
	rts
    2968:	rts

0000296a <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    296a:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    296c:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    2970:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    2974:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    297a:	bcc.s 2992 <__udivsi3+0x28>
	movel	d0, d2
    297c:	move.l d0,d2
	clrw	d2
    297e:	clr.w d2
	swap	d2
    2980:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    2982:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    2984:	move.w d2,d0
	swap	d0
    2986:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    2988:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    298c:	divu.w d1,d2
	movew	d2, d0
    298e:	move.w d2,d0
	jra	6f
    2990:	bra.s 29c2 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    2992:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    2994:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    2996:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    2998:	cmpi.l #65536,d1
	jcc	4b
    299e:	bcc.s 2994 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    29a0:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    29a2:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    29a8:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    29aa:	mulu.w d0,d1
	swap	d2
    29ac:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    29ae:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    29b0:	swap d2
	tstw	d2		/* high part 17 bits? */
    29b2:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    29b4:	bne.s 29c0 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    29b6:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    29b8:	bcs.s 29c0 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    29ba:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    29be:	bls.s 29c2 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    29c0:	subq.l #1,d0

6:	movel	sp@+, d2
    29c2:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    29c4:	rts

000029c6 <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    29c6:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    29c8:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    29ca:	move.l 12(sp),d1
	jpl	1f
    29ce:	bpl.s 29d4 <__divsi3+0xe>
	negl	d1
    29d0:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    29d2:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    29d4:	move.l 8(sp),d0
	jpl	2f
    29d8:	bpl.s 29de <__divsi3+0x18>
	negl	d0
    29da:	neg.l d0
	negb	d2
    29dc:	neg.b d2

2:	movel	d1, sp@-
    29de:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    29e0:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    29e2:	bsr.s 296a <__udivsi3>
	addql	#8, sp
    29e4:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    29e6:	tst.b d2
	jpl	3f
    29e8:	bpl.s 29ec <__divsi3+0x26>
	negl	d0
    29ea:	neg.l d0

3:	movel	sp@+, d2
    29ec:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    29ee:	rts

000029f0 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    29f0:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    29f4:	move.l 4(sp),d0
	movel	d1, sp@-
    29f8:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    29fa:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    29fc:	bsr.s 29c6 <__divsi3>
	addql	#8, sp
    29fe:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    2a00:	move.l 8(sp),d1
	movel	d1, sp@-
    2a04:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2a06:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    2a08:	bsr.w 2948 <__mulsi3>
	addql	#8, sp
    2a0c:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2a0e:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2a12:	sub.l d0,d1
	movel	d1, d0
    2a14:	move.l d1,d0
	rts
    2a16:	rts

00002a18 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    2a18:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    2a1c:	move.l 4(sp),d0
	movel	d1, sp@-
    2a20:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2a22:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    2a24:	bsr.w 296a <__udivsi3>
	addql	#8, sp
    2a28:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    2a2a:	move.l 8(sp),d1
	movel	d1, sp@-
    2a2e:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2a30:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    2a32:	bsr.w 2948 <__mulsi3>
	addql	#8, sp
    2a36:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2a38:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2a3c:	sub.l d0,d1
	movel	d1, d0
    2a3e:	move.l d1,d0
	rts
    2a40:	rts

00002a42 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    2a42:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    2a44:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    2a48:	jsr -516(a6)
    move.l (sp)+, a6
    2a4c:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    2a4e:	rts

00002a50 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    2a50:	move.b d0,(a3)+
	rts
    2a52:	rts

00002a54 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    2a54:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    2a56:	adda.l a0,a2
	move.l	a2,a3
    2a58:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    2a5a:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    2a5c:	moveq #56,d4
	moveq	#8,d5
    2a5e:	moveq #8,d5
	bra.s	.Lliteral
    2a60:	bra.s 2aca <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    2a62:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    2a64:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    2a66:	dbf d1,2a62 <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    2a6a:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    2a6c:	bcc.s 2a70 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    2a6e:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    2a70:	tst.w d0
    2a72:	bne.s 2a7c <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    2a74:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    2a76:	bls.s 2aee <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    2a78:	move.w (a0)+,d0
    2a7a:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    2a7c:	rol.l #6,d0
	move.w	d0,d1
    2a7e:	move.w d0,d1
	and.w	d4,d1
    2a80:	and.w d4,d1
	eor.w	d1,d0
    2a82:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    2a84:	movem.w (2ae8 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    2a8a:	rol.l d2,d0
	and.w	d0,d3					|scaling
    2a8c:	and.w d0,d3
	eor.w	d3,d0
    2a8e:	eor.w d3,d0
	suba.w	d3,a4
    2a90:	suba.w d3,a4
	adda.l	a1,a4
    2a92:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    2a94:	tst.w d0
    2a96:	bne.s 2a9c <_doynaxdepack_asm+0x48>
    2a98:	move.w (a0)+,d0
    2a9a:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    2a9c:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    2a9e:	beq.s 2ab6 <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    2aa0:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    2aa2:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    2aa4:	bpl.s 2ab2 <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    2aa6:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    2aa8:	bpl.s 2ab0 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    2aaa:	addx.b d1,d1
	lsl.l	#2,d0
    2aac:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    2aae:	bmi.s 2aaa <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    2ab0:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    2ab2:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    2ab4:	bcc.s 2ab8 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    2ab6:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    2ab8:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    2aba:	dbf d1,2ab6 <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    2abe:	add.l d0,d0
	bcc.s	.Lmatch
    2ac0:	bcc.s 2a70 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    2ac2:	tst.w d0
    2ac4:	bne.s 2aca <_doynaxdepack_asm+0x76>
    2ac6:	move.w (a0)+,d0
    2ac8:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    2aca:	moveq #0,d1
	add.l	d0,d0
    2acc:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    2ace:	bcc.s 2a6e <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    2ad0:	bpl.s 2ad8 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    2ad2:	addx.b d1,d1
	lsl.l	#2,d0
    2ad4:	lsl.l #2,d0
	bmi.s	.Llgetlen
    2ad6:	bmi.s 2ad2 <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    2ad8:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    2ada:	dbv.s d1,2a62 <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    2ade:	add.l d0,d0
	eor.w	d1,d0		
    2ae0:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    2ae2:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    2ae4:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    2ae6:	bra.s 2ada <_doynaxdepack_asm+0x86>

00002ae8 <doy_table>:
    2ae8:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    2af8:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    2b08:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    2b18:	.............o
