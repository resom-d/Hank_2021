
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
      14:	lea 6000 <ScrollerDir>,a2
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
      36:	lea 6000 <ScrollerDir>,a2
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
      5e:	lea 6000 <ScrollerDir>,a2
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
      90:	lea 43b1 <incbin_P61_Player_end+0x1>,a1
      96:	moveq #0,d0
      98:	jsr -552(a6)
      9c:	move.l d0,23b82 <GfxBase>
	if (!GfxBase)
      a2:	beq.w 24b0 <main+0x243c>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
      a6:	movea.l 23b86 <SysBase>,a6
      ac:	lea 43c2 <incbin_P61_Player_end+0x12>,a1
      b2:	moveq #0,d0
      b4:	jsr -552(a6)
      b8:	move.l d0,23b7e <DOSBase>
	if (!DOSBase)
      be:	beq.w 24d8 <main+0x2464>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      c2:	pea 43ce <incbin_P61_Player_end+0x1e>
      c8:	jsr 25d4 <KPrintF>
#endif

	Write(Output(), (APTR) "Hello console!\n", 15);
      ce:	movea.l 23b7e <DOSBase>,a6
      d4:	jsr -60(a6)
      d8:	movea.l 23b7e <DOSBase>,a6
      de:	move.l d0,d1
      e0:	move.l #17386,d2
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
     7d4:	jsr 258e <WaitVbl>
	WaitVbl();
     7da:	jsr 258e <WaitVbl>
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
     820:	jsr 258e <WaitVbl>
	WaitVbl();
     826:	jsr 258e <WaitVbl>
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     82c:	move.w #20090,172(sp)
     832:	move.w #2049,174(sp)
     838:	move.w #20083,176(sp)
	if (SysBase->AttnFlags & AFF_68010)
     83e:	movea.l 23b86 <SysBase>,a6
     844:	btst #0,297(a6)
     84a:	beq.w 24e4 <main+0x2470>
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
     874:	jsr 258e <WaitVbl>
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
     dcc:	lea 43fa <colgradbluePaletteRGB4>,a4
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
     df8:	cmpa.l #17450,a4
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
     f68:	move.l #9548,108(a0)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
     f70:	move.w #-16352,154(a5)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
     f76:	move.w #32,156(a5)
{
	short line = 0;
	USHORT hpos = 14633;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 100; l++)
     f7c:	lea 233dc <StarSprite>,a4
     f82:	moveq #0,d6
	BYTE vpos = 0x2c;
     f84:	moveq #44,d7
	USHORT hpos = 14633;
     f86:	move.w #14633,d5
     f8a:	lea 2914 <__modsi3>,a3
	{
		hpos = (7*hpos)%255;
     f90:	andi.l #65535,d5
     f96:	move.l d5,d0
     f98:	lsl.l #3,d0
     f9a:	pea ff <main+0x8b>
     f9e:	sub.l d5,d0
     fa0:	move.l d0,-(sp)
     fa2:	jsr (a3)
     fa4:	addq.l #8,sp
     fa6:	move.w d0,d5
		
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff);	  //v-pos, h-pos
     fa8:	move.w d7,d1
     faa:	lsl.w #8,d1
     fac:	or.w d0,d1
     fae:	move.w d1,(a4)
		StarSprite[line++] = (vpos + 1) << 8 | 0; //v-stop, ctrl
     fb0:	move.w d7,d0
     fb2:	lsl.w #8,d0
     fb4:	addi.w #256,d0
     fb8:	move.w d0,2(a4)

		switch (l % 3)
     fbc:	pea 3 <_start+0x3>
     fc0:	move.l d6,-(sp)
     fc2:	jsr (a3)
     fc4:	addq.l #8,sp
     fc6:	moveq #1,d1
     fc8:	cmp.l d0,d1
     fca:	beq.w 1ede <main+0x1e6a>
     fce:	moveq #2,d1
		{
		case 0:
			StarSprite[line++] = 0x8000; //color-1
     fd0:	move.w #-32768,4(a4)
		switch (l % 3)
     fd6:	cmp.l d0,d1
     fd8:	beq.w 1ec6 <main+0x1e52>
			StarSprite[line++] = 0x0000; //color-1
     fdc:	clr.w 6(a4)
			StarSprite[line++] = 0x8000; //color-3
			StarSprite[line++] = 0x8000; //color-3
			break;
		}

		vpos += 2;
     fe0:	addq.b #2,d7
	for (int l = 0; l < 100; l++)
     fe2:	addq.l #1,d6
     fe4:	addq.l #8,a4
     fe6:	cmpi.b #-12,d7
     fea:	bne.s f90 <main+0xf1c>
	}
	StarSprite[line++] = 0;
     fec:	clr.w 236fc <StarSprite+0x320>
	StarSprite[line++] = 0;
     ff2:	clr.w 236fe <StarSprite+0x322>
	short incX[6] = {3, 3, 3, 3, 3, 3};
     ff8:	move.w #3,168(sp)
	short incY[6] = {1, 1, 1, 1, 1, 1};
     ffe:	move.w #1,180(sp)
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
    1004:	move.l 23b26 <BmpLogo+0xe>,d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    100a:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    100e:	move.w 2(a5),d0
    1012:	btst #14,d0
    1016:	bne.s 100e <main+0xf9a>
	custom->bltcon0 = 0x09f0;
    1018:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
    101e:	move.w #0,66(a5)
	custom->bltafwm = 0xffff;
    1024:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    102a:	move.w #-1,70(a5)
	custom->bltamod = imgA.Bpl - (width / 8);
    1030:	move.w d4,d7
    1032:	addi.w #-32,d7
    1036:	move.w d7,100(a5)
	custom->bltdmod = imgD.Bpl - (width / 8);
    103a:	addi.w #-32,d2
    103e:	move.w d2,102(a5)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1042:	move.l d1,80(a5)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1046:	addq.l #4,a6
    1048:	move.l a6,84(a5)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
    104c:	move.w 48(sp),d0
    1050:	lsl.w #6,d0
    1052:	add.w 48(sp),d0
    1056:	lsl.w #7,d0
    1058:	addi.w #16,d0
    105c:	move.w d0,88(a5)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    1060:	move.b bfe001 <_end+0xbda471>,d0
	while (!MouseLeft())
    1066:	btst #6,d0
    106a:	beq.w 206c <main+0x1ff8>
    106e:	move.w 23a80 <BmpUpperPart_Buf1+0x4>,116(sp)
    1076:	move.w 23a82 <BmpUpperPart_Buf1+0x6>,56(sp)
    107e:	move.l 23a8a <BmpUpperPart_Buf1+0xe>,58(sp)
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
    1086:	move.w 2398e <ScrollerY>,82(sp)
	short incY[6] = {1, 1, 1, 1, 1, 1};
    108e:	move.w #1,104(sp)
    1094:	move.w #1,102(sp)
    109a:	move.w #1,106(sp)
    10a0:	move.w #1,100(sp)
	short incX[6] = {3, 3, 3, 3, 3, 3};
    10a6:	move.w #3,108(sp)
    10ac:	move.w #3,110(sp)
    10b2:	move.w #3,114(sp)
    10b8:	move.w #3,112(sp)
	Point2D pdb[6] = {
    10be:	movea.w #78,a2
    10c2:	move.l a2,70(sp)
    10c6:	clr.l 62(sp)
    10ca:	movea.w #82,a2
    10ce:	move.l a2,74(sp)
    10d2:	moveq #28,d4
    10d4:	move.l d4,48(sp)
    10d8:	movea.w #86,a2
    10dc:	move.l a2,66(sp)
    10e0:	moveq #56,d7
    10e2:	movea.w #90,a2
    10e6:	move.l a2,78(sp)
    10ea:	moveq #84,d4
    10ec:	move.l d4,52(sp)
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    10f0:	move.l dff004 <_end+0xddb474>,d0
    10f6:	move.l d0,156(sp)
		vpos &= 0x1ff00;
    10fa:	move.l 156(sp),d0
    10fe:	andi.l #130816,d0
    1104:	move.l d0,156(sp)
		if (vpos != (311 << 8))
    1108:	move.l 156(sp),d0
    110c:	cmpi.l #79616,d0
    1112:	beq.s 10f0 <main+0x107c>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    1114:	move.l dff004 <_end+0xddb474>,d0
    111a:	move.l d0,152(sp)
		vpos &= 0x1ff00;
    111e:	move.l 152(sp),d0
    1122:	andi.l #130816,d0
    1128:	move.l d0,152(sp)
		if (vpos == (311 << 8))
    112c:	move.l 152(sp),d0
    1130:	cmpi.l #79616,d0
    1136:	bne.s 1114 <main+0x10a0>
		if (ScrollerPause > 0)
    1138:	move.w 23992 <ScrollerPause>,d4
    113e:	beq.s 1148 <main+0x10d4>
			ScrollerPause--;
    1140:	subq.w #1,d4
    1142:	move.w d4,23992 <ScrollerPause>
		CopyBitmap(BmpUpperPart_Buf1, BmpUpperPart_PF2);
    1148:	move.w 23a7e <BmpUpperPart_Buf1+0x2>,d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    114e:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1152:	move.w 2(a5),d0
    1156:	move.w d0,d2
    1158:	andi.w #16384,d2
    115c:	btst #14,d0
    1160:	bne.s 1152 <main+0x10de>
	custom->bltcon0 = 0x09f0;
    1162:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
    1168:	move.w #0,66(a5)
	custom->bltapt = (UBYTE *)bmpS.ImageData;
    116e:	move.l 58(sp),80(a5)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
    1174:	move.l d3,84(a5)
	custom->bltafwm = 0xffff;
    1178:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    117e:	move.w #-1,70(a5)
	custom->bltamod = 0;
    1184:	move.w #0,100(a5)
	custom->bltdmod = 0;
    118a:	move.w #0,102(a5)
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
    1190:	move.w 116(sp),d0
    1194:	muls.w d1,d0
    1196:	lsl.w #6,d0
    1198:	move.w 56(sp),d1
    119c:	lsr.w #1,d1
    119e:	add.w d1,d0
    11a0:	move.w d0,88(a5)
		if (BounceEnabled)
    11a4:	tst.w 23990 <BounceEnabled>
    11aa:	beq.s 11ea <main+0x1176>
			if (ScrollerDir > 0)
    11ac:	move.b 6000 <ScrollerDir>,d0
    11b2:	ble.w 2022 <main+0x1fae>
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
    11b6:	pea c <_start+0xc>
    11ba:	movea.w #40,a0
    11be:	suba.w 86(sp),a0
    11c2:	move.l a0,-(sp)
    11c4:	jsr 28ea <__divsi3>
    11ca:	addq.l #8,sp
				if (ScrollerDir > 6)
    11cc:	cmpi.b #6,d0
    11d0:	ble.w 2046 <main+0x1fd2>
					ScrollerDir = 6;
    11d4:	move.b #6,6000 <ScrollerDir>
    11dc:	moveq #6,d0
			ScrollerY += ScrollerDir;
    11de:	add.w d0,82(sp)
    11e2:	move.w 82(sp),2398e <ScrollerY>
		if (ScrollerY >= ScrollerMax)
    11ea:	movea.w 82(sp),a0
    11ee:	cmpi.w #39,82(sp)
    11f4:	ble.w 1efa <main+0x1e86>
			ScrollerY = ScrollerMax;
    11f8:	move.w #40,2398e <ScrollerY>
			ScrollerDir = -1;
    1200:	st 6000 <ScrollerDir>
    1206:	movea.w #40,a0
    120a:	move.w #40,82(sp)
		if (ScrollerPause < 1)
    1210:	tst.w d4
    1212:	beq.w 1cc6 <main+0x1c52>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    1216:	moveq #0,d4
    1218:	move.w 118(sp),d4
    121c:	movea.l 2398a <copScrollerBmpP>,a2
    1222:	moveq #0,d5
    1224:	move.w 23a4e <BmpScroller+0x6>,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    122a:	move.l a0,-(sp)
    122c:	move.l d5,-(sp)
    122e:	jsr 286c <__mulsi3>
    1234:	addq.l #4,sp
    1236:	move.l d4,(sp)
    1238:	move.l d0,-(sp)
    123a:	jsr 286c <__mulsi3>
    1240:	addq.l #8,sp
    1242:	add.l 120(sp),d0
        addr += Bpl;
    1246:	move.w #224,d1
    for (USHORT i = 0; i < numPlanes; i++)
    124a:	tst.l d4
    124c:	beq.s 1276 <main+0x1202>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
    124e:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    1250:	move.l d0,d3
    1252:	clr.w d3
    1254:	swap d3
    1256:	move.w d3,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
    125a:	move.w d1,d6
    125c:	addq.w #2,d6
    125e:	move.w d6,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    1262:	addq.l #8,a2
    1264:	move.w d0,-2(a2)
        addr += Bpl;
    1268:	add.l d5,d0
    for (USHORT i = 0; i < numPlanes; i++)
    126a:	addq.w #1,d2
    126c:	addq.w #4,d1
    126e:	moveq #0,d3
    1270:	move.w d2,d3
    1272:	cmp.l d4,d3
    1274:	blt.s 124e <main+0x11da>
		ClearBitmapPart(BmpUpperPart_Buf1, pdb[3].X, pdb[3].Y, 32, 32);
    1276:	movea.w 23a84 <BmpUpperPart_Buf1+0x8>,a4
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    127c:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1280:	move.w 2(a5),d0
    1284:	btst #14,d0
    1288:	bne.s 1280 <main+0x120c>
	BYTE shift = x % 16;
    128a:	moveq #15,d2
    128c:	and.l 62(sp),d2
	if (shift)
    1290:	beq.w 1f62 <main+0x1eee>
    1294:	moveq #3,d5
    1296:	moveq #-6,d4
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1298:	move.l d2,d0
    129a:	moveq #12,d1
    129c:	lsl.l d1,d0
    129e:	ori.w #2304,d0
    12a2:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    12a6:	move.w d2,d0
    12a8:	moveq #12,d3
    12aa:	lsl.w d3,d0
    12ac:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    12b0:	moveq #0,d3
    12b2:	move.w a4,d3
    12b4:	move.l 70(sp),-(sp)
    12b8:	move.l d3,-(sp)
    12ba:	jsr 286c <__mulsi3>
    12c0:	addq.l #8,sp
    12c2:	move.l 62(sp),d1
    12c6:	asr.l #3,d1
    12c8:	add.l d1,d0
    12ca:	add.l 58(sp),d0
    12ce:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    12d2:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    12d6:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    12dc:	tst.l d2
    12de:	beq.w 1f38 <main+0x1ec4>
    12e2:	moveq #15,d1
    12e4:	sub.l d2,d1
    12e6:	moveq #0,d0
    12e8:	not.w d0
    12ea:	lsl.l d1,d0
    12ec:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    12f0:	move.w 56(sp),d0
    12f4:	add.w d4,d0
    12f6:	move.w d0,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    12fa:	move.w d0,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    12fe:	move.w 116(sp),d4
    1302:	moveq #11,d6
    1304:	lsl.w d6,d4
    1306:	add.w d4,d5
    1308:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    130c:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1310:	move.w 2(a5),d0
    1314:	btst #14,d0
    1318:	bne.s 1310 <main+0x129c>
	BYTE shift = x % 16;
    131a:	move.l 48(sp),d6
    131e:	andi.l #-2147483633,d6
    1324:	tst.l 48(sp)
    1328:	blt.w 1c7e <main+0x1c0a>
    132c:	moveq #15,d1
    132e:	and.l 48(sp),d1
    1332:	movea.l d1,a2
	if (shift)
    1334:	beq.w 1c92 <main+0x1c1e>
    1338:	moveq #3,d5
    133a:	moveq #-6,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    133c:	move.l d6,d0
    133e:	moveq #12,d1
    1340:	lsl.l d1,d0
    1342:	ori.w #2304,d0
    1346:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    134a:	move.w d6,d0
    134c:	lsl.w d1,d0
    134e:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1352:	move.l d3,-(sp)
    1354:	move.l 78(sp),-(sp)
    1358:	jsr 286c <__mulsi3>
    135e:	addq.l #8,sp
    1360:	move.l 48(sp),d1
    1364:	bmi.w 1c3e <main+0x1bca>
    1368:	asr.l #3,d1
    136a:	add.l d1,d0
    136c:	add.l 58(sp),d0
    1370:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1374:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    1378:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    137e:	cmpa.w #0,a2
    1382:	beq.w 1c5e <main+0x1bea>
    1386:	moveq #15,d1
    1388:	sub.l d6,d1
    138a:	moveq #0,d0
    138c:	not.w d0
    138e:	lsl.l d1,d0
    1390:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1394:	add.w 56(sp),d2
    1398:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    139c:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    13a0:	add.w d4,d5
    13a2:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    13a6:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    13aa:	move.w 2(a5),d0
    13ae:	btst #14,d0
    13b2:	bne.s 13aa <main+0x1336>
	BYTE shift = x % 16;
    13b4:	move.l d7,d6
    13b6:	andi.l #-2147483633,d6
    13bc:	tst.l d7
    13be:	blt.w 1bfa <main+0x1b86>
    13c2:	moveq #15,d0
    13c4:	and.l d7,d0
    13c6:	movea.l d0,a2
	if (shift)
    13c8:	beq.w 1c0c <main+0x1b98>
    13cc:	moveq #3,d5
    13ce:	moveq #-6,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    13d0:	move.l d6,d0
    13d2:	moveq #12,d1
    13d4:	lsl.l d1,d0
    13d6:	ori.w #2304,d0
    13da:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    13de:	move.w d6,d0
    13e0:	lsl.w d1,d0
    13e2:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    13e6:	move.l d3,-(sp)
    13e8:	move.l 70(sp),-(sp)
    13ec:	jsr 286c <__mulsi3>
    13f2:	addq.l #8,sp
    13f4:	move.l d7,d1
    13f6:	bmi.w 1bba <main+0x1b46>
    13fa:	asr.l #3,d1
    13fc:	add.l d1,d0
    13fe:	add.l 58(sp),d0
    1402:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1406:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    140a:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    1410:	cmpa.w #0,a2
    1414:	beq.w 1bda <main+0x1b66>
    1418:	moveq #15,d1
    141a:	sub.l d6,d1
    141c:	moveq #0,d0
    141e:	not.w d0
    1420:	lsl.l d1,d0
    1422:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1426:	add.w 56(sp),d2
    142a:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    142e:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    1432:	add.w d4,d5
    1434:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1438:	move.w 2(a5),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    143c:	move.w 2(a5),d0
    1440:	move.w d0,d2
    1442:	andi.w #16384,d2
    1446:	btst #14,d0
    144a:	bne.s 143c <main+0x13c8>
	BYTE shift = x % 16;
    144c:	move.l 52(sp),d6
    1450:	andi.l #-2147483633,d6
    1456:	tst.l 52(sp)
    145a:	blt.w 1b70 <main+0x1afc>
    145e:	moveq #15,d0
    1460:	and.l 52(sp),d0
    1464:	movea.l d0,a2
	if (shift)
    1466:	beq.w 1b84 <main+0x1b10>
    146a:	movea.w #3,a6
    146e:	moveq #-6,d5
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1470:	move.l d6,d0
    1472:	moveq #12,d1
    1474:	lsl.l d1,d0
    1476:	ori.w #2304,d0
    147a:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    147e:	move.w d6,d0
    1480:	lsl.w d1,d0
    1482:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1486:	move.l d3,-(sp)
    1488:	move.l 82(sp),-(sp)
    148c:	jsr 286c <__mulsi3>
    1492:	addq.l #8,sp
    1494:	move.l 52(sp),d1
    1498:	bmi.w 195c <main+0x18e8>
    149c:	asr.l #3,d1
    149e:	add.l d1,d0
    14a0:	add.l 58(sp),d0
    14a4:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    14a8:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    14ac:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    14b2:	cmpa.w #0,a2
    14b6:	beq.w 197c <main+0x1908>
    14ba:	movea.w #15,a0
    14be:	suba.l d6,a0
    14c0:	moveq #0,d0
    14c2:	not.w d0
    14c4:	move.l a0,d6
    14c6:	lsl.l d6,d0
    14c8:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    14cc:	add.w 56(sp),d5
    14d0:	move.w d5,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    14d4:	move.w d5,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    14d8:	add.w a6,d4
    14da:	move.w d4,88(a5)
			pdb[b].X += incX[b];
    14de:	movea.l 52(sp),a2
    14e2:	move.w 112(sp),d4
    14e6:	move.w d4,d5
    14e8:	ext.l d5
    14ea:	lea (0,a2,d5.l),a2
    14ee:	move.l a2,52(sp)
			pdb[b].Y += incY[b];
    14f2:	movea.l 78(sp),a2
    14f6:	move.w 100(sp),d4
    14fa:	move.w d4,d5
    14fc:	ext.l d5
    14fe:	lea (0,a2,d5.l),a2
    1502:	move.l a2,78(sp)
			if (pdb[b].X >= 320 - 32)
    1506:	cmpi.l #287,52(sp)
    150e:	ble.w 19c8 <main+0x1954>
				incX[b] *= -1;
    1512:	neg.w 112(sp)
    1516:	clr.w 124(sp)
    151a:	movea.w #36,a2
    151e:	move.w #4042,d4
    1522:	clr.l 136(sp)
    1526:	suba.l a6,a6
				pdb[b].X = 320 - 32;
    1528:	move.l #288,52(sp)
			if (pdb[b].Y >= 130 - 32)
    1530:	moveq #97,d0
    1532:	cmp.l 78(sp),d0
    1536:	bge.w 19f2 <main+0x197e>
				incY[b] *= -1;
    153a:	neg.w 100(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    153e:	move.w a4,d0
    1540:	mulu.w #98,d0
    1544:	adda.l d0,a2
				pdb[b].Y = 130 - 32;
    1546:	movea.w #98,a0
    154a:	move.l a0,78(sp)
			pdb[b].X += incX[b];
    154e:	movea.w 114(sp),a1
    1552:	move.w a1,d0
    1554:	ext.l d0
    1556:	movea.l d7,a0
    1558:	lea (0,a0,d0.l),a1
    155c:	move.l a1,d7
			pdb[b].Y += incY[b];
    155e:	movea.l 66(sp),a0
    1562:	move.w 106(sp),d5
    1566:	move.w d5,d6
    1568:	ext.l d6
    156a:	lea (0,a0,d6.l),a0
    156e:	move.l a0,66(sp)
			if (pdb[b].X >= 320 - 32)
    1572:	cmpa.w #287,a1
    1576:	ble.w 1a2e <main+0x19ba>
				incX[b] *= -1;
    157a:	neg.w 114(sp)
    157e:	clr.w 128(sp)
    1582:	moveq #36,d1
    1584:	move.l d1,96(sp)
    1588:	move.w #4042,126(sp)
    158e:	clr.l 140(sp)
    1592:	clr.l 84(sp)
				pdb[b].X = 320 - 32;
    1596:	move.l #288,d7
			if (pdb[b].Y >= 130 - 32)
    159c:	moveq #97,d5
    159e:	cmp.l 66(sp),d5
    15a2:	bge.w 1a5c <main+0x19e8>
				incY[b] *= -1;
    15a6:	neg.w 106(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    15aa:	move.w a4,d0
    15ac:	mulu.w #98,d0
    15b0:	add.l d0,96(sp)
				pdb[b].Y = 130 - 32;
    15b4:	movea.w #98,a0
    15b8:	move.l a0,66(sp)
			pdb[b].X += incX[b];
    15bc:	movea.l 48(sp),a1
    15c0:	move.w 110(sp),d5
    15c4:	move.w d5,d6
    15c6:	ext.l d6
    15c8:	lea (0,a1,d6.l),a1
    15cc:	move.l a1,48(sp)
			pdb[b].Y += incY[b];
    15d0:	movea.l 74(sp),a0
    15d4:	move.w 102(sp),d5
    15d8:	move.w d5,d6
    15da:	ext.l d6
    15dc:	lea (0,a0,d6.l),a0
    15e0:	move.l a0,74(sp)
			if (pdb[b].X >= 320 - 32)
    15e4:	cmpa.w #287,a1
    15e8:	ble.w 1a9c <main+0x1a28>
				incX[b] *= -1;
    15ec:	neg.w 110(sp)
    15f0:	clr.w 132(sp)
    15f4:	moveq #36,d1
    15f6:	move.l d1,44(sp)
    15fa:	move.w #4042,130(sp)
    1600:	clr.l 144(sp)
    1604:	clr.l 88(sp)
				pdb[b].X = 320 - 32;
    1608:	move.l #288,48(sp)
			if (pdb[b].Y >= 130 - 32)
    1610:	moveq #97,d6
    1612:	cmp.l 74(sp),d6
    1616:	bge.w 1acc <main+0x1a58>
				incY[b] *= -1;
    161a:	neg.w 102(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    161e:	move.w a4,d0
    1620:	mulu.w #98,d0
    1624:	add.l d0,44(sp)
				pdb[b].Y = 130 - 32;
    1628:	movea.w #98,a0
    162c:	move.l a0,74(sp)
			pdb[b].X += incX[b];
    1630:	movea.l 62(sp),a1
    1634:	move.w 108(sp),d5
    1638:	move.w d5,d6
    163a:	ext.l d6
    163c:	lea (0,a1,d6.l),a1
    1640:	move.l a1,62(sp)
			pdb[b].Y += incY[b];
    1644:	movea.l 70(sp),a0
    1648:	move.w 104(sp),d5
    164c:	move.w d5,d6
    164e:	ext.l d6
    1650:	lea (0,a0,d6.l),a0
    1654:	move.l a0,70(sp)
			if (pdb[b].X >= 320 - 32)
    1658:	cmpa.w #287,a1
    165c:	ble.w 1b0c <main+0x1a98>
				incX[b] *= -1;
    1660:	neg.w 108(sp)
    1664:	moveq #36,d6
    1666:	move.w #4042,134(sp)
    166c:	clr.l 148(sp)
    1670:	clr.l 92(sp)
				pdb[b].X = 320 - 32;
    1674:	move.l #288,62(sp)
			if (pdb[b].Y >= 130 - 32)
    167c:	moveq #97,d0
    167e:	cmp.l 70(sp),d0
    1682:	bge.w 1b36 <main+0x1ac2>
				incY[b] *= -1;
    1686:	neg.w 104(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    168a:	move.w a4,d0
    168c:	mulu.w #98,d0
    1690:	add.l d0,d6
				pdb[b].Y = 130 - 32;
    1692:	movea.w #98,a0
    1696:	move.l a0,70(sp)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, ps2, pdb[0], 32, 32);
    169a:	movea.w 239e4 <BmpCookie+0x4>,a4
    16a0:	move.w 239e6 <BmpCookie+0x6>,d1
    16a6:	movea.l 239ee <BmpCookie+0xe>,a1
    16ac:	move.w 239b2 <BmpCookieMask+0x6>,d0
    16b2:	movea.l 239ba <BmpCookieMask+0xe>,a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    16b8:	move.w 2(a5),d3
    16bc:	move.l 44(sp),d5
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    16c0:	move.w 2(a5),d3
    16c4:	btst #14,d3
    16c8:	bne.s 16c0 <main+0x164c>
	if (shift)
    16ca:	move.l d5,44(sp)
    16ce:	cmpa.w #0,a6
    16d2:	beq.w 1fba <main+0x1f46>
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    16d6:	move.w d4,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    16da:	move.w 124(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    16e0:	move.l a1,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    16e4:	move.w d1,d3
    16e6:	subq.w #6,d3
    16e8:	move.w d3,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    16ec:	move.l a0,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    16f0:	move.w d0,d3
    16f2:	subq.w #6,d3
    16f4:	move.w d3,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    16f8:	adda.l 58(sp),a2
    16fc:	move.l a2,84(a5)
    1700:	move.l a2,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1704:	move.w 56(sp),d3
    1708:	subq.w #6,d3
    170a:	move.w d3,102(a5)
    170e:	move.w d3,96(a5)
	custom->bltafwm = 0xffff;
    1712:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1718:	movea.w #15,a2
    171c:	suba.l 136(sp),a2
    1720:	moveq #0,d3
    1722:	not.w d3
    1724:	move.l a2,d4
    1726:	lsl.l d4,d3
    1728:	movea.w #3,a2
    172c:	move.w d3,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1730:	moveq #0,d3
    1732:	move.w a4,d3
    1734:	moveq #11,d4
    1736:	lsl.l d4,d3
    1738:	move.w a2,d5
    173a:	or.w d3,d5
    173c:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1740:	movea.w 2(a5),a2
    1744:	move.l 44(sp),d5
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1748:	move.w 2(a5),d4
    174c:	btst #14,d4
    1750:	bne.s 1748 <main+0x16d4>
	if (shift)
    1752:	move.l d5,44(sp)
    1756:	tst.l 84(sp)
    175a:	beq.w 1fae <main+0x1f3a>
    175e:	movea.w #3,a2
    1762:	movea.w #6,a4
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1766:	move.w 126(sp),64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    176c:	move.w 128(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1772:	lea 6(a1),a6
    1776:	move.l a6,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    177a:	movea.w d1,a6
    177c:	suba.w a4,a6
    177e:	move.w a6,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1782:	lea 6(a0),a6
    1786:	move.l a6,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    178a:	movea.w d0,a6
    178c:	suba.w a4,a6
    178e:	move.w a6,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1792:	move.l 58(sp),d4
    1796:	add.l 96(sp),d4
    179a:	move.l d4,84(a5)
    179e:	move.l d4,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    17a2:	move.w 56(sp),d4
    17a6:	sub.w a4,d4
    17a8:	move.w d4,102(a5)
    17ac:	move.w d4,96(a5)
	custom->bltafwm = 0xffff;
    17b0:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    17b6:	tst.l 84(sp)
    17ba:	beq.w 1f94 <main+0x1f20>
    17be:	movea.w #15,a4
    17c2:	suba.l 140(sp),a4
    17c6:	moveq #0,d4
    17c8:	not.w d4
    17ca:	move.l a4,d5
    17cc:	lsl.l d5,d4
    17ce:	move.w d4,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    17d2:	move.w a2,d4
    17d4:	or.w d3,d4
    17d6:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    17da:	move.w 2(a5),d4
    17de:	move.l 44(sp),d5
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    17e2:	move.w 2(a5),d4
    17e6:	btst #14,d4
    17ea:	bne.s 17e2 <main+0x176e>
	if (shift)
    17ec:	move.l d5,44(sp)
    17f0:	tst.l 88(sp)
    17f4:	beq.w 1f88 <main+0x1f14>
    17f8:	movea.w #3,a6
    17fc:	movea.w #6,a2
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1800:	move.w 130(sp),64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1806:	move.w 132(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    180c:	lea 12(a1),a4
    1810:	move.l a4,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    1814:	movea.w d1,a4
    1816:	suba.w a2,a4
    1818:	move.w a4,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    181c:	lea 12(a0),a4
    1820:	move.l a4,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1824:	movea.w d0,a4
    1826:	suba.w a2,a4
    1828:	move.w a4,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    182c:	add.l 58(sp),d5
    1830:	move.l d5,84(a5)
    1834:	move.l d5,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1838:	move.w 56(sp),d5
    183c:	sub.w a2,d5
    183e:	move.w d5,102(a5)
    1842:	move.w d5,96(a5)
	custom->bltafwm = 0xffff;
    1846:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    184c:	tst.l 88(sp)
    1850:	beq.w 1f72 <main+0x1efe>
    1854:	movea.w #15,a2
    1858:	suba.l 144(sp),a2
    185c:	moveq #0,d5
    185e:	not.w d5
    1860:	move.l a2,d4
    1862:	lsl.l d4,d5
    1864:	move.w d5,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1868:	move.w a6,d4
    186a:	or.w d3,d4
    186c:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1870:	move.w 2(a5),d4
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1874:	move.w 2(a5),d4
    1878:	btst #14,d4
    187c:	bne.s 1874 <main+0x1800>
	if (shift)
    187e:	tst.l 92(sp)
    1882:	beq.w 1f6a <main+0x1ef6>
    1886:	moveq #3,d4
    1888:	moveq #6,d5
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    188a:	move.w 134(sp),64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1890:	move.w d2,66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1894:	lea 18(a1),a1
    1898:	move.l a1,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    189c:	sub.w d5,d1
    189e:	move.w d1,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    18a2:	lea 18(a0),a0
    18a6:	move.l a0,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    18aa:	sub.w d5,d0
    18ac:	move.w d0,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    18b0:	add.l 58(sp),d6
    18b4:	move.l d6,84(a5)
    18b8:	move.l d6,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    18bc:	move.w 56(sp),d0
    18c0:	sub.w d5,d0
    18c2:	move.w d0,102(a5)
    18c6:	move.w d0,96(a5)
	custom->bltafwm = 0xffff;
    18ca:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    18d0:	tst.l 92(sp)
    18d4:	beq.w 1f20 <main+0x1eac>
    18d8:	moveq #15,d1
    18da:	sub.l 148(sp),d1
    18de:	moveq #0,d0
    18e0:	not.w d0
    18e2:	lsl.l d1,d0
    18e4:	move.w d0,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    18e8:	or.w d4,d3
    18ea:	move.w d3,88(a5)

void MoveStarfield()
{
	BYTE hpos;
	int line = 1;
	for (int l = 0; l < 100; l++)
    18ee:	lea 233dd <StarSprite+0x1>,a2
    18f4:	moveq #0,d2
	{
		switch (l % 3)
    18f6:	pea 3 <_start+0x3>
    18fa:	move.l d2,-(sp)
    18fc:	jsr (a3)
    18fe:	addq.l #8,sp
    1900:	moveq #1,d5
    1902:	cmp.l d0,d5
    1904:	beq.w 1e9a <main+0x1e26>
    1908:	subq.l #2,d0
    190a:	beq.w 1eb0 <main+0x1e3c>
		{
		case 0:
			((volatile UBYTE *)StarSprite)[line] += 3;
    190e:	move.b (a2),d0
    1910:	addq.b #3,d0
    1912:	move.b d0,(a2)
	for (int l = 0; l < 100; l++)
    1914:	addq.l #1,d2
    1916:	addq.l #8,a2
    1918:	moveq #100,d0
    191a:	cmp.l d2,d0
    191c:	bne.s 18f6 <main+0x1882>
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    191e:	move.b bfe001 <_end+0xbda471>,d0
	while (!MouseLeft())
    1924:	btst #6,d0
    1928:	beq.w 2066 <main+0x1ff2>
    192c:	move.l 23abe <BmpUpperPart_PF2+0xe>,d3
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    1932:	move.l dff004 <_end+0xddb474>,d0
    1938:	move.l d0,156(sp)
		vpos &= 0x1ff00;
    193c:	move.l 156(sp),d0
    1940:	andi.l #130816,d0
    1946:	move.l d0,156(sp)
		if (vpos != (311 << 8))
    194a:	move.l 156(sp),d0
    194e:	cmpi.l #79616,d0
    1954:	beq.w 10f0 <main+0x107c>
    1958:	bra.w 1114 <main+0x10a0>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    195c:	addq.l #7,d1
    195e:	asr.l #3,d1
    1960:	add.l d1,d0
    1962:	add.l 58(sp),d0
    1966:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    196a:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    196e:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    1974:	cmpa.w #0,a2
    1978:	bne.w 14ba <main+0x1446>
    197c:	moveq #-1,d0
    197e:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1982:	add.w 56(sp),d5
    1986:	move.w d5,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    198a:	move.w d5,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    198e:	add.w a6,d4
    1990:	move.w d4,88(a5)
			pdb[b].X += incX[b];
    1994:	movea.l 52(sp),a2
    1998:	move.w 112(sp),d4
    199c:	move.w d4,d5
    199e:	ext.l d5
    19a0:	lea (0,a2,d5.l),a2
    19a4:	move.l a2,52(sp)
			pdb[b].Y += incY[b];
    19a8:	movea.l 78(sp),a2
    19ac:	move.w 100(sp),d4
    19b0:	move.w d4,d5
    19b2:	ext.l d5
    19b4:	lea (0,a2,d5.l),a2
    19b8:	move.l a2,78(sp)
			if (pdb[b].X >= 320 - 32)
    19bc:	cmpi.l #287,52(sp)
    19c4:	bgt.w 1512 <main+0x149e>
			if (pdb[b].X <= 0)
    19c8:	tst.l 52(sp)
    19cc:	bgt.w 21c8 <main+0x2154>
				incX[b] *= -1;
    19d0:	neg.w 112(sp)
    19d4:	clr.w 124(sp)
    19d8:	suba.l a2,a2
    19da:	move.w #4042,d4
    19de:	clr.l 136(sp)
    19e2:	suba.l a6,a6
				pdb[b].X = 0;
    19e4:	clr.l 52(sp)
			if (pdb[b].Y >= 130 - 32)
    19e8:	moveq #97,d0
    19ea:	cmp.l 78(sp),d0
    19ee:	blt.w 153a <main+0x14c6>
			if (pdb[b].Y <= 0)
    19f2:	tst.l 78(sp)
    19f6:	bgt.w 224e <main+0x21da>
				incY[b] *= -1;
    19fa:	neg.w 100(sp)
				pdb[b].Y = 0;
    19fe:	clr.l 78(sp)
			pdb[b].X += incX[b];
    1a02:	movea.w 114(sp),a1
    1a06:	move.w a1,d0
    1a08:	ext.l d0
    1a0a:	movea.l d7,a0
    1a0c:	lea (0,a0,d0.l),a1
    1a10:	move.l a1,d7
			pdb[b].Y += incY[b];
    1a12:	movea.l 66(sp),a0
    1a16:	move.w 106(sp),d5
    1a1a:	move.w d5,d6
    1a1c:	ext.l d6
    1a1e:	lea (0,a0,d6.l),a0
    1a22:	move.l a0,66(sp)
			if (pdb[b].X >= 320 - 32)
    1a26:	cmpa.w #287,a1
    1a2a:	bgt.w 157a <main+0x1506>
			if (pdb[b].X <= 0)
    1a2e:	cmpa.w #0,a1
    1a32:	bgt.w 2220 <main+0x21ac>
				incX[b] *= -1;
    1a36:	neg.w 114(sp)
    1a3a:	clr.w 128(sp)
    1a3e:	clr.l 96(sp)
    1a42:	move.w #4042,126(sp)
    1a48:	clr.l 140(sp)
    1a4c:	clr.l 84(sp)
				pdb[b].X = 0;
    1a50:	moveq #0,d7
			if (pdb[b].Y >= 130 - 32)
    1a52:	moveq #97,d5
    1a54:	cmp.l 66(sp),d5
    1a58:	blt.w 15a6 <main+0x1532>
			if (pdb[b].Y <= 0)
    1a5c:	tst.l 66(sp)
    1a60:	bgt.w 21f4 <main+0x2180>
				incY[b] *= -1;
    1a64:	neg.w 106(sp)
				pdb[b].Y = 0;
    1a68:	clr.l 66(sp)
			pdb[b].X += incX[b];
    1a6c:	movea.l 48(sp),a1
    1a70:	move.w 110(sp),d5
    1a74:	move.w d5,d6
    1a76:	ext.l d6
    1a78:	lea (0,a1,d6.l),a1
    1a7c:	move.l a1,48(sp)
			pdb[b].Y += incY[b];
    1a80:	movea.l 74(sp),a0
    1a84:	move.w 102(sp),d5
    1a88:	move.w d5,d6
    1a8a:	ext.l d6
    1a8c:	lea (0,a0,d6.l),a0
    1a90:	move.l a0,74(sp)
			if (pdb[b].X >= 320 - 32)
    1a94:	cmpa.w #287,a1
    1a98:	bgt.w 15ec <main+0x1578>
			if (pdb[b].X <= 0)
    1a9c:	tst.l 48(sp)
    1aa0:	bgt.w 2262 <main+0x21ee>
				incX[b] *= -1;
    1aa4:	neg.w 110(sp)
    1aa8:	clr.w 132(sp)
    1aac:	clr.l 44(sp)
    1ab0:	move.w #4042,130(sp)
    1ab6:	clr.l 144(sp)
    1aba:	clr.l 88(sp)
				pdb[b].X = 0;
    1abe:	clr.l 48(sp)
			if (pdb[b].Y >= 130 - 32)
    1ac2:	moveq #97,d6
    1ac4:	cmp.l 74(sp),d6
    1ac8:	blt.w 161a <main+0x15a6>
			if (pdb[b].Y <= 0)
    1acc:	tst.l 74(sp)
    1ad0:	bgt.w 220a <main+0x2196>
				incY[b] *= -1;
    1ad4:	neg.w 102(sp)
				pdb[b].Y = 0;
    1ad8:	clr.l 74(sp)
			pdb[b].X += incX[b];
    1adc:	movea.l 62(sp),a1
    1ae0:	move.w 108(sp),d5
    1ae4:	move.w d5,d6
    1ae6:	ext.l d6
    1ae8:	lea (0,a1,d6.l),a1
    1aec:	move.l a1,62(sp)
			pdb[b].Y += incY[b];
    1af0:	movea.l 70(sp),a0
    1af4:	move.w 104(sp),d5
    1af8:	move.w d5,d6
    1afa:	ext.l d6
    1afc:	lea (0,a0,d6.l),a0
    1b00:	move.l a0,70(sp)
			if (pdb[b].X >= 320 - 32)
    1b04:	cmpa.w #287,a1
    1b08:	bgt.w 1660 <main+0x15ec>
			if (pdb[b].X <= 0)
    1b0c:	tst.l 62(sp)
    1b10:	bgt.w 2294 <main+0x2220>
				incX[b] *= -1;
    1b14:	neg.w 108(sp)
    1b18:	moveq #0,d6
    1b1a:	move.w #4042,134(sp)
    1b20:	clr.l 148(sp)
    1b24:	clr.l 92(sp)
				pdb[b].X = 0;
    1b28:	clr.l 62(sp)
			if (pdb[b].Y >= 130 - 32)
    1b2c:	moveq #97,d0
    1b2e:	cmp.l 70(sp),d0
    1b32:	blt.w 1686 <main+0x1612>
			if (pdb[b].Y <= 0)
    1b36:	tst.l 70(sp)
    1b3a:	bgt.w 22c0 <main+0x224c>
				incY[b] *= -1;
    1b3e:	neg.w 104(sp)
				pdb[b].Y = 0;
    1b42:	clr.l 70(sp)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, ps2, pdb[0], 32, 32);
    1b46:	movea.w 239e4 <BmpCookie+0x4>,a4
    1b4c:	move.w 239e6 <BmpCookie+0x6>,d1
    1b52:	movea.l 239ee <BmpCookie+0xe>,a1
    1b58:	move.w 239b2 <BmpCookieMask+0x6>,d0
    1b5e:	movea.l 239ba <BmpCookieMask+0xe>,a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1b64:	move.w 2(a5),d3
    1b68:	move.l 44(sp),d5
    1b6c:	bra.w 16c0 <main+0x164c>
	BYTE shift = x % 16;
    1b70:	subq.l #1,d6
    1b72:	moveq #-16,d5
    1b74:	or.l d5,d6
    1b76:	addq.l #1,d6
    1b78:	moveq #15,d0
    1b7a:	and.l 52(sp),d0
    1b7e:	movea.l d0,a2
	if (shift)
    1b80:	bne.w 146a <main+0x13f6>
    1b84:	movea.w #2,a6
    1b88:	moveq #-4,d5
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1b8a:	move.l d6,d0
    1b8c:	moveq #12,d1
    1b8e:	lsl.l d1,d0
    1b90:	ori.w #2304,d0
    1b94:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1b98:	move.w d6,d0
    1b9a:	lsl.w d1,d0
    1b9c:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1ba0:	move.l d3,-(sp)
    1ba2:	move.l 82(sp),-(sp)
    1ba6:	jsr 286c <__mulsi3>
    1bac:	addq.l #8,sp
    1bae:	move.l 52(sp),d1
    1bb2:	bpl.w 149c <main+0x1428>
    1bb6:	bra.w 195c <main+0x18e8>
    1bba:	addq.l #7,d1
    1bbc:	asr.l #3,d1
    1bbe:	add.l d1,d0
    1bc0:	add.l 58(sp),d0
    1bc4:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1bc8:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    1bcc:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    1bd2:	cmpa.w #0,a2
    1bd6:	bne.w 1418 <main+0x13a4>
    1bda:	moveq #-1,d0
    1bdc:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1be0:	add.w 56(sp),d2
    1be4:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    1be8:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    1bec:	add.w d4,d5
    1bee:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1bf2:	move.w 2(a5),d0
    1bf6:	bra.w 143c <main+0x13c8>
	BYTE shift = x % 16;
    1bfa:	subq.l #1,d6
    1bfc:	moveq #-16,d5
    1bfe:	or.l d5,d6
    1c00:	addq.l #1,d6
    1c02:	moveq #15,d0
    1c04:	and.l d7,d0
    1c06:	movea.l d0,a2
	if (shift)
    1c08:	bne.w 13cc <main+0x1358>
    1c0c:	moveq #2,d5
    1c0e:	moveq #-4,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1c10:	move.l d6,d0
    1c12:	moveq #12,d1
    1c14:	lsl.l d1,d0
    1c16:	ori.w #2304,d0
    1c1a:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1c1e:	move.w d6,d0
    1c20:	lsl.w d1,d0
    1c22:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1c26:	move.l d3,-(sp)
    1c28:	move.l 70(sp),-(sp)
    1c2c:	jsr 286c <__mulsi3>
    1c32:	addq.l #8,sp
    1c34:	move.l d7,d1
    1c36:	bpl.w 13fa <main+0x1386>
    1c3a:	bra.w 1bba <main+0x1b46>
    1c3e:	addq.l #7,d1
    1c40:	asr.l #3,d1
    1c42:	add.l d1,d0
    1c44:	add.l 58(sp),d0
    1c48:	move.l d0,80(a5)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1c4c:	move.l d0,84(a5)
	custom->bltafwm = 0xffff;
    1c50:	move.w #-1,68(a5)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    1c56:	cmpa.w #0,a2
    1c5a:	bne.w 1386 <main+0x1312>
    1c5e:	moveq #-1,d0
    1c60:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1c64:	add.w 56(sp),d2
    1c68:	move.w d2,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    1c6c:	move.w d2,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    1c70:	add.w d4,d5
    1c72:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1c76:	move.w 2(a5),d0
    1c7a:	bra.w 13aa <main+0x1336>
	BYTE shift = x % 16;
    1c7e:	subq.l #1,d6
    1c80:	moveq #-16,d0
    1c82:	or.l d0,d6
    1c84:	addq.l #1,d6
    1c86:	moveq #15,d1
    1c88:	and.l 48(sp),d1
    1c8c:	movea.l d1,a2
	if (shift)
    1c8e:	bne.w 1338 <main+0x12c4>
    1c92:	moveq #2,d5
    1c94:	moveq #-4,d2
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1c96:	move.l d6,d0
    1c98:	moveq #12,d1
    1c9a:	lsl.l d1,d0
    1c9c:	ori.w #2304,d0
    1ca0:	move.w d0,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1ca4:	move.w d6,d0
    1ca6:	lsl.w d1,d0
    1ca8:	move.w d0,66(a5)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1cac:	move.l d3,-(sp)
    1cae:	move.l 78(sp),-(sp)
    1cb2:	jsr 286c <__mulsi3>
    1cb8:	addq.l #8,sp
    1cba:	move.l 48(sp),d1
    1cbe:	bpl.w 1368 <main+0x12f4>
    1cc2:	bra.w 1c3e <main+0x1bca>
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    1cc6:	move.w 23a50 <BmpScroller+0x8>,d3
	int BltOffs = startY * theDesc.Bplt;
    1ccc:	move.w d3,d4
    1cce:	mulu.w #40,d4
	int Brcorner = height * theDesc.Bplt - 2;
    1cd2:	andi.l #65535,d3
    1cd8:	lsl.l #5,d3
    1cda:	subq.l #2,d3
	WaitBlit();
    1cdc:	movea.l 23b82 <GfxBase>,a6
    1ce2:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
    1ce6:	movea.l 23b8c <custom>,a5
    1cec:	move.w #18928,64(a5)
	custom->bltcon1 = 0x0002;
    1cf2:	move.w #2,66(a5)
	custom->bltafwm = 0xffff;
    1cf8:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    1cfe:	move.w #-1,70(a5)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
    1d04:	add.l d4,d3
    1d06:	add.l 120(sp),d3
    1d0a:	move.l d3,80(a5)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
    1d0e:	move.l d3,84(a5)
	custom->bltamod = 0;
    1d12:	move.w #0,100(a5)
	custom->bltdmod = 0;
    1d18:	move.w #0,102(a5)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
    1d1e:	move.w 118(sp),d0
    1d22:	moveq #11,d1
    1d24:	lsl.w d1,d0
    1d26:	lea 23a48 <BmpScroller>,a0
    1d2c:	move.w (a0),d1
    1d2e:	lsr.w #4,d1
    1d30:	add.w d1,d0
    1d32:	move.w d0,88(a5)
	ScrollCnt += speed;
    1d36:	move.w 23988 <ScrollCnt>,d0
    1d3c:	addq.w #4,d0
    1d3e:	move.w d0,23988 <ScrollCnt>
	if (ScrollCnt >= 32)
    1d44:	cmpi.w #31,d0
    1d48:	bhi.s 1dbc <main+0x1d48>
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
    1d96:	jsr 286c <__mulsi3>
    1d9c:	addq.l #4,sp
    1d9e:	move.l d4,(sp)
    1da0:	move.l d0,-(sp)
    1da2:	jsr 286c <__mulsi3>
    1da8:	addq.l #8,sp
    1daa:	add.l 120(sp),d0
        addr += Bpl;
    1dae:	move.w #224,d1
    for (USHORT i = 0; i < numPlanes; i++)
    1db2:	tst.l d4
    1db4:	bne.w 124e <main+0x11da>
    1db8:	bra.w 1276 <main+0x1202>
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
    1dfc:	lea 444a <Scrolltext>,a2
    1e02:	move.b (0,a2,d0.l),d0
	if (chr == 'b')
    1e06:	cmpi.b #98,d0
    1e0a:	beq.w 246a <main+0x23f6>
	if (chr == 'm')
    1e0e:	cmpi.b #109,d0
    1e12:	beq.w 2404 <main+0x2390>
	if (chr == 's')
    1e16:	cmpi.b #115,d0
    1e1a:	beq.w 23c2 <main+0x234e>
	if (chr == 0)
    1e1e:	tst.b d0
    1e20:	beq.w 22fa <main+0x2286>
	if (chr < 32 || chr > (32 + 80))
    1e24:	addi.b #-32,d0
    1e28:	cmpi.b #80,d0
    1e2c:	bls.w 2304 <main+0x2290>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    1e30:	move.w 2398e <ScrollerY>,82(sp)
    1e38:	movea.w 82(sp),a0
    1e3c:	move.w 23a4c <BmpScroller+0x4>,118(sp)
    1e44:	move.w 23a80 <BmpUpperPart_Buf1+0x4>,116(sp)
    1e4c:	move.w 23a82 <BmpUpperPart_Buf1+0x6>,56(sp)
    1e54:	move.l 23a8a <BmpUpperPart_Buf1+0xe>,58(sp)
    1e5c:	moveq #0,d4
    1e5e:	move.w 118(sp),d4
    1e62:	movea.l 2398a <copScrollerBmpP>,a2
    1e68:	moveq #0,d5
    1e6a:	move.w 23a4e <BmpScroller+0x6>,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    1e70:	move.l a0,-(sp)
    1e72:	move.l d5,-(sp)
    1e74:	jsr 286c <__mulsi3>
    1e7a:	addq.l #4,sp
    1e7c:	move.l d4,(sp)
    1e7e:	move.l d0,-(sp)
    1e80:	jsr 286c <__mulsi3>
    1e86:	addq.l #8,sp
    1e88:	add.l 120(sp),d0
        addr += Bpl;
    1e8c:	move.w #224,d1
    for (USHORT i = 0; i < numPlanes; i++)
    1e90:	tst.l d4
    1e92:	bne.w 124e <main+0x11da>
    1e96:	bra.w 1276 <main+0x1202>
			break;
		case 1:
			((volatile UBYTE *)StarSprite)[line] += 1;
    1e9a:	move.b (a2),d0
    1e9c:	addq.b #1,d0
    1e9e:	move.b d0,(a2)
	for (int l = 0; l < 100; l++)
    1ea0:	addq.l #1,d2
    1ea2:	addq.l #8,a2
    1ea4:	moveq #100,d0
    1ea6:	cmp.l d2,d0
    1ea8:	bne.w 18f6 <main+0x1882>
    1eac:	bra.w 191e <main+0x18aa>
			break;
		case 2:
			((volatile UBYTE *)StarSprite)[line] += 2;
    1eb0:	move.b (a2),d0
    1eb2:	addq.b #2,d0
    1eb4:	move.b d0,(a2)
	for (int l = 0; l < 100; l++)
    1eb6:	addq.l #1,d2
    1eb8:	addq.l #8,a2
    1eba:	moveq #100,d0
    1ebc:	cmp.l d2,d0
    1ebe:	bne.w 18f6 <main+0x1882>
    1ec2:	bra.w 191e <main+0x18aa>
			StarSprite[line++] = 0x8000; //color-3
    1ec6:	move.w #-32768,6(a4)
		vpos += 2;
    1ecc:	addq.b #2,d7
	for (int l = 0; l < 100; l++)
    1ece:	addq.l #1,d6
    1ed0:	addq.l #8,a4
    1ed2:	cmpi.b #-12,d7
    1ed6:	bne.w f90 <main+0xf1c>
    1eda:	bra.w fec <main+0xf78>
			StarSprite[line++] = 0x0000; //color-2
    1ede:	clr.w 4(a4)
			StarSprite[line++] = 0x8000; //color-2
    1ee2:	move.w #-32768,6(a4)
		vpos += 2;
    1ee8:	addq.b #2,d7
	for (int l = 0; l < 100; l++)
    1eea:	addq.l #1,d6
    1eec:	addq.l #8,a4
    1eee:	cmpi.b #-12,d7
    1ef2:	bne.w f90 <main+0xf1c>
    1ef6:	bra.w fec <main+0xf78>
		else if (ScrollerY <= ScrollerMin)
    1efa:	cmpa.w #0,a0
    1efe:	bgt.w 1210 <main+0x119c>
			ScrollerY = ScrollerMin;
    1f02:	clr.w 2398e <ScrollerY>
			ScrollerDir = 1;
    1f08:	move.b #1,6000 <ScrollerDir>
    1f10:	suba.l a0,a0
    1f12:	clr.w 82(sp)
		if (ScrollerPause < 1)
    1f16:	tst.w d4
    1f18:	bne.w 1216 <main+0x11a2>
    1f1c:	bra.w 1cc6 <main+0x1c52>
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1f20:	moveq #-1,d0
    1f22:	move.w d0,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1f26:	or.w d4,d3
    1f28:	move.w d3,88(a5)
	for (int l = 0; l < 100; l++)
    1f2c:	lea 233dd <StarSprite+0x1>,a2
    1f32:	moveq #0,d2
    1f34:	bra.w 18f6 <main+0x1882>
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;;
    1f38:	moveq #-1,d0
    1f3a:	move.w d0,70(a5)
	custom->bltamod = bmp.Bpl-(width/8);
    1f3e:	move.w 56(sp),d0
    1f42:	add.w d4,d0
    1f44:	move.w d0,100(a5)
	custom->bltdmod = bmp.Bpl-(width/8);
    1f48:	move.w d0,102(a5)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    1f4c:	move.w 116(sp),d4
    1f50:	moveq #11,d6
    1f52:	lsl.w d6,d4
    1f54:	add.w d4,d5
    1f56:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1f5a:	move.w 2(a5),d0
    1f5e:	bra.w 1310 <main+0x129c>
	if (shift)
    1f62:	moveq #2,d5
    1f64:	moveq #-4,d4
    1f66:	bra.w 1298 <main+0x1224>
	if (shift)
    1f6a:	moveq #2,d4
    1f6c:	moveq #4,d5
    1f6e:	bra.w 188a <main+0x1816>
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1f72:	moveq #-1,d5
    1f74:	move.w d5,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1f78:	move.w a6,d4
    1f7a:	or.w d3,d4
    1f7c:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1f80:	move.w 2(a5),d4
    1f84:	bra.w 1874 <main+0x1800>
	if (shift)
    1f88:	movea.w #2,a6
    1f8c:	movea.w #4,a2
    1f90:	bra.w 1800 <main+0x178c>
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1f94:	moveq #-1,d4
    1f96:	move.w d4,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1f9a:	move.w a2,d4
    1f9c:	or.w d3,d4
    1f9e:	move.w d4,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1fa2:	move.w 2(a5),d4
    1fa6:	move.l 44(sp),d5
    1faa:	bra.w 17e2 <main+0x176e>
	if (shift)
    1fae:	movea.w #2,a2
    1fb2:	movea.w #4,a4
    1fb6:	bra.w 1766 <main+0x16f2>
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1fba:	move.w d4,64(a5)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1fbe:	move.w 124(sp),66(a5)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1fc4:	move.l a1,80(a5)
	custom->bltamod = imgS.Bpl - (width / 8);
    1fc8:	move.w d1,d3
    1fca:	subq.w #4,d3
    1fcc:	move.w d3,100(a5)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1fd0:	move.l a0,76(a5)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1fd4:	move.w d0,d3
    1fd6:	subq.w #4,d3
    1fd8:	move.w d3,98(a5)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1fdc:	adda.l 58(sp),a2
    1fe0:	move.l a2,84(a5)
    1fe4:	move.l a2,72(a5)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1fe8:	move.w 56(sp),d3
    1fec:	subq.w #4,d3
    1fee:	move.w d3,102(a5)
    1ff2:	move.w d3,96(a5)
	custom->bltafwm = 0xffff;
    1ff6:	move.w #-1,68(a5)
    1ffc:	movea.w #2,a2
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    2000:	moveq #-1,d3
    2002:	move.w d3,70(a5)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    2006:	moveq #0,d3
    2008:	move.w a4,d3
    200a:	moveq #11,d4
    200c:	lsl.l d4,d3
    200e:	move.w a2,d5
    2010:	or.w d3,d5
    2012:	move.w d5,88(a5)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    2016:	movea.w 2(a5),a2
    201a:	move.l 44(sp),d5
    201e:	bra.w 1748 <main+0x16d4>
				ScrollerDir -= 1;
    2022:	subq.b #1,d0
				if (ScrollerDir < -4)
    2024:	cmpi.b #-4,d0
    2028:	bge.w 21aa <main+0x2136>
					ScrollerDir = -4;
    202c:	move.b #-4,6000 <ScrollerDir>
    2034:	moveq #-4,d0
			ScrollerY += ScrollerDir;
    2036:	add.w d0,82(sp)
    203a:	move.w 82(sp),2398e <ScrollerY>
    2042:	bra.w 11ea <main+0x1176>
				if (ScrollerDir < 1)
    2046:	tst.b d0
    2048:	bgt.w 24ea <main+0x2476>
					ScrollerDir = 1;
    204c:	move.b #1,6000 <ScrollerDir>
    2054:	moveq #1,d0
			ScrollerY += ScrollerDir;
    2056:	add.w d0,82(sp)
    205a:	move.w 82(sp),2398e <ScrollerY>
    2062:	bra.w 11ea <main+0x1176>
    2066:	movea.l 239a6 <copPtr>,a2
	FreeMem(copPtr, 1024);
    206c:	movea.l 23b86 <SysBase>,a6
    2072:	movea.l a2,a1
    2074:	move.l #1024,d0
    207a:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    207e:	movea.l 23b86 <SysBase>,a6
    2084:	movea.l 23a56 <BmpScroller+0xe>,a1
    208a:	moveq #0,d0
    208c:	move.w 23a54 <BmpScroller+0xc>,d0
    2092:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    2096:	movea.l 23b86 <SysBase>,a6
    209c:	movea.l 23af2 <BmpUpperPart_PF1+0xe>,a1
    20a2:	moveq #0,d0
    20a4:	move.w 23af0 <BmpUpperPart_PF1+0xc>,d0
    20aa:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    20ae:	movea.l 23b86 <SysBase>,a6
    20b4:	movea.l 23abe <BmpUpperPart_PF2+0xe>,a1
    20ba:	moveq #0,d0
    20bc:	move.w 23abc <BmpUpperPart_PF2+0xc>,d0
    20c2:	jsr -210(a6)
	WaitVbl();
    20c6:	jsr 258e <WaitVbl>
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    20cc:	movea.l 23b8c <custom>,a0
    20d2:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    20d6:	move.w 2(a0),d0
    20da:	btst #14,d0
    20de:	bne.s 20d6 <main+0x2062>
	custom->intena = 0x7fff; //disable all interrupts
    20e0:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
    20e6:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
    20ec:	move.w #32767,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
    20f2:	movea.l 239a2 <VBR>,a1
    20f8:	move.l 2399e <SystemIrq>,108(a1)
	custom->cop1lc = (ULONG)GfxBase->copinit;
    2100:	movea.l 23b82 <GfxBase>,a6
    2106:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
    210c:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
    2112:	move.w #32767,136(a0)
	custom->intena = SystemInts | 0x8000;
    2118:	move.w 2399c <SystemInts>,d0
    211e:	ori.w #-32768,d0
    2122:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
    2126:	move.w 2399a <SystemDMA>,d0
    212c:	ori.w #-32768,d0
    2130:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
    2134:	move.w 23998 <SystemADKCON>,d0
    213a:	ori.w #-32768,d0
    213e:	move.w d0,158(a0)
	LoadView(ActiView);
    2142:	movea.l 23994 <ActiView>,a1
    2148:	jsr -222(a6)
	WaitTOF();
    214c:	movea.l 23b82 <GfxBase>,a6
    2152:	jsr -270(a6)
	WaitTOF();
    2156:	movea.l 23b82 <GfxBase>,a6
    215c:	jsr -270(a6)
	WaitBlit();
    2160:	movea.l 23b82 <GfxBase>,a6
    2166:	jsr -228(a6)
	DisownBlitter();
    216a:	movea.l 23b82 <GfxBase>,a6
    2170:	jsr -462(a6)
	Enable();
    2174:	movea.l 23b86 <SysBase>,a6
    217a:	jsr -126(a6)
	CloseLibrary((struct Library *)DOSBase);
    217e:	movea.l 23b86 <SysBase>,a6
    2184:	movea.l 23b7e <DOSBase>,a1
    218a:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    218e:	movea.l 23b86 <SysBase>,a6
    2194:	movea.l 23b82 <GfxBase>,a1
    219a:	jsr -414(a6)
}
    219e:	moveq #0,d0
    21a0:	movem.l (sp)+,d2-d7/a2-a6
    21a4:	lea 140(sp),sp
    21a8:	rts
				if (ScrollerDir > -1)
    21aa:	tst.b d0
    21ac:	blt.w 24ea <main+0x2476>
					ScrollerDir = -1;
    21b0:	st 6000 <ScrollerDir>
    21b6:	moveq #-1,d0
			ScrollerY += ScrollerDir;
    21b8:	add.w d0,82(sp)
    21bc:	move.w 82(sp),2398e <ScrollerY>
    21c4:	bra.w 11ea <main+0x1176>
    21c8:	moveq #15,d6
    21ca:	and.l 52(sp),d6
    21ce:	movea.l d6,a6
	BYTE shift = startD.X % 16;
    21d0:	move.l d6,136(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    21d4:	move.l d6,d0
    21d6:	moveq #12,d1
    21d8:	lsl.l d1,d0
    21da:	move.w d0,d4
    21dc:	ori.w #4042,d4
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    21e0:	moveq #12,d5
    21e2:	lsl.w d5,d6
    21e4:	move.w d6,124(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    21e8:	move.l 52(sp),d6
    21ec:	asr.l #3,d6
    21ee:	movea.l d6,a2
    21f0:	bra.w 1530 <main+0x14bc>
    21f4:	move.l d3,-(sp)
    21f6:	move.l 70(sp),-(sp)
    21fa:	jsr 286c <__mulsi3>
    2200:	addq.l #8,sp
    2202:	add.l d0,96(sp)
    2206:	bra.w 15bc <main+0x1548>
    220a:	move.l 74(sp),-(sp)
    220e:	move.l d3,-(sp)
    2210:	jsr 286c <__mulsi3>
    2216:	addq.l #8,sp
    2218:	add.l d0,44(sp)
    221c:	bra.w 1630 <main+0x15bc>
    2220:	moveq #15,d5
    2222:	and.l d7,d5
    2224:	move.l d5,84(sp)
	BYTE shift = startD.X % 16;
    2228:	move.l d5,140(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    222c:	move.l d5,d0
    222e:	moveq #12,d6
    2230:	lsl.l d6,d0
    2232:	ori.w #4042,d0
    2236:	move.w d0,126(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    223a:	moveq #12,d0
    223c:	lsl.w d0,d5
    223e:	move.w d5,128(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    2242:	move.l a1,d1
    2244:	asr.l #3,d1
    2246:	move.l d1,96(sp)
    224a:	bra.w 159c <main+0x1528>
    224e:	move.l d3,-(sp)
    2250:	move.l 82(sp),-(sp)
    2254:	jsr 286c <__mulsi3>
    225a:	addq.l #8,sp
    225c:	adda.l d0,a2
    225e:	bra.w 154e <main+0x14da>
    2262:	moveq #15,d5
    2264:	and.l 48(sp),d5
    2268:	move.l d5,88(sp)
	BYTE shift = startD.X % 16;
    226c:	move.l d5,144(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    2270:	move.l d5,d0
    2272:	moveq #12,d6
    2274:	lsl.l d6,d0
    2276:	ori.w #4042,d0
    227a:	move.w d0,130(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    227e:	moveq #12,d0
    2280:	lsl.w d0,d5
    2282:	move.w d5,132(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    2286:	move.l 48(sp),d5
    228a:	asr.l #3,d5
    228c:	move.l d5,44(sp)
    2290:	bra.w 1610 <main+0x159c>
    2294:	moveq #15,d1
    2296:	and.l 62(sp),d1
    229a:	move.l d1,92(sp)
	BYTE shift = startD.X % 16;
    229e:	move.l d1,148(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    22a2:	move.l d1,d0
    22a4:	moveq #12,d5
    22a6:	lsl.l d5,d0
    22a8:	ori.w #4042,d0
    22ac:	move.w d0,134(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    22b0:	move.w d1,d2
    22b2:	moveq #12,d6
    22b4:	lsl.w d6,d2
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    22b6:	move.l 62(sp),d6
    22ba:	asr.l #3,d6
    22bc:	bra.w 167c <main+0x1608>
    22c0:	move.l 70(sp),-(sp)
    22c4:	move.l d3,-(sp)
    22c6:	jsr 286c <__mulsi3>
    22cc:	addq.l #8,sp
    22ce:	add.l d0,d6
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, ps2, pdb[0], 32, 32);
    22d0:	movea.w 239e4 <BmpCookie+0x4>,a4
    22d6:	move.w 239e6 <BmpCookie+0x6>,d1
    22dc:	movea.l 239ee <BmpCookie+0xe>,a1
    22e2:	move.w 239b2 <BmpCookieMask+0x6>,d0
    22e8:	movea.l 239ba <BmpCookieMask+0xe>,a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    22ee:	move.w 2(a5),d3
    22f2:	move.l 44(sp),d5
    22f6:	bra.w 16c0 <main+0x164c>
		chr = Scrolltext[ScrolltextCnt++];
    22fa:	move.w #1,23986 <ScrolltextCnt>
	if (chr < 32 || chr > (32 + 80))
    2302:	moveq #40,d0
	row = chr / 10;
    2304:	ext.w d0
    2306:	moveq #10,d6
    2308:	ext.l d0
    230a:	divs.w d6,d0
    230c:	move.l d0,d6
    230e:	swap d6
    2310:	movea.w d6,a0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    2312:	clr.w d6
    2314:	move.b d0,d6
    2316:	move.w a1,d0
    2318:	mulu.w d0,d6
    231a:	lsl.l #5,d6
	col = chr % 10;
    231c:	move.w a0,d3
    231e:	moveq #0,d0
    2320:	move.b d3,d0
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    2322:	add.l d0,d0
    2324:	add.l d0,d0
    2326:	add.l d0,d6
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    2328:	mulu.w #40,d1
    232c:	moveq #0,d0
    232e:	move.w 23b52 <Screen+0x6>,d0
    2334:	movea.l d1,a2
    2336:	adda.l d0,a2
	WaitBlit();
    2338:	movea.l 23b82 <GfxBase>,a6
    233e:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    2342:	movea.l 23b8c <custom>,a5
    2348:	move.w #2544,64(a5)
	custom->bltcon1 = 0x0000;
    234e:	move.w #0,66(a5)
	custom->bltafwm = 0xffff;
    2354:	move.w #-1,68(a5)
	custom->bltalwm = 0xffff;
    235a:	move.w #-1,70(a5)
	custom->bltapt = bmpFontP + source;
    2360:	addi.l #37062,d6
    2366:	move.l d6,80(a5)
	custom->bltdpt = bmpDestP + dest;
    236a:	adda.l 120(sp),a2
    236e:	move.l a2,84(a5)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    2372:	subq.w #4,d5
    2374:	move.w d5,100(a5)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    2378:	subq.w #4,d4
    237a:	move.w d4,102(a5)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    237e:	move.w a4,d0
    2380:	moveq #11,d4
    2382:	lsl.w d4,d0
    2384:	addq.w #2,d0
    2386:	move.w d0,88(a5)
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    238a:	move.w 2398e <ScrollerY>,82(sp)
    2392:	movea.w 82(sp),a0
    2396:	move.w 23a4c <BmpScroller+0x4>,118(sp)
    239e:	move.l 23a56 <BmpScroller+0xe>,120(sp)
    23a6:	move.w 23a80 <BmpUpperPart_Buf1+0x4>,116(sp)
    23ae:	move.w 23a82 <BmpUpperPart_Buf1+0x6>,56(sp)
    23b6:	move.l 23a8a <BmpUpperPart_Buf1+0xe>,58(sp)
    23be:	bra.w 1d7e <main+0x1d0a>
		ScrollerPause = (Scrolltext[ScrolltextCnt++] - 48) * 50;
    23c2:	move.w 23986 <ScrolltextCnt>,d0
    23c8:	moveq #0,d6
    23ca:	move.w d0,d6
    23cc:	lea 444a <Scrolltext>,a2
    23d2:	move.b (0,a2,d6.l),d6
    23d6:	ext.w d6
    23d8:	addi.w #-48,d6
    23dc:	muls.w #50,d6
    23e0:	move.w d6,23992 <ScrollerPause>
		chr = Scrolltext[ScrolltextCnt++];
    23e6:	move.w d0,d3
    23e8:	addq.w #2,d3
    23ea:	move.w d3,23986 <ScrolltextCnt>
		ScrollerPause = (Scrolltext[ScrolltextCnt++] - 48) * 50;
    23f0:	addq.w #1,d0
		chr = Scrolltext[ScrolltextCnt++];
    23f2:	andi.l #65535,d0
    23f8:	move.b (0,a2,d0.l),d0
	if (chr == 0)
    23fc:	bne.w 1e24 <main+0x1db0>
    2400:	bra.w 22fa <main+0x2286>
		if (MirrorEnabled)
    2404:	move.w 23984 <MirrorEnabled>,d0
				 BmpScroller.Bplt - Screen.Bpl);
    240a:	move.w d1,d6
    240c:	sub.w 23b52 <Screen+0x6>,d6
	copSetBplMod(0, copMirrorBmpP,
    2412:	movea.l 23980 <copMirrorBmpP>,a0
		if (MirrorEnabled)
    2418:	tst.w d0
    241a:	beq.w 2502 <main+0x248e>
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    241e:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    2422:	move.w d6,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    2426:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    242c:	move.w d6,6(a0)
		MirrorEnabled = !MirrorEnabled;
    2430:	tst.w d0
    2432:	seq d0
    2434:	ext.w d0
    2436:	neg.w d0
    2438:	move.w d0,23984 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    243e:	move.w 23986 <ScrolltextCnt>,d0
    2444:	movea.w d0,a2
    2446:	addq.w #1,a2
    2448:	move.w a2,23986 <ScrolltextCnt>
    244e:	andi.l #65535,d0
    2454:	lea 444a <Scrolltext>,a0
    245a:	move.b (0,a0,d0.l),d0
	if (chr == 's')
    245e:	cmpi.b #115,d0
    2462:	bne.w 1e1e <main+0x1daa>
    2466:	bra.w 23c2 <main+0x234e>
		if (BounceEnabled)
    246a:	move.w 23990 <BounceEnabled>,d0
    2470:	beq.s 2480 <main+0x240c>
			ScrollerY = SCRT_MIN;
    2472:	clr.w 2398e <ScrollerY>
			ScrollerDir = 1;
    2478:	move.b #1,6000 <ScrollerDir>
		BounceEnabled = !BounceEnabled;
    2480:	tst.w d0
    2482:	seq d0
    2484:	ext.w d0
    2486:	neg.w d0
    2488:	move.w d0,23990 <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    248e:	addq.w #2,d6
    2490:	move.w d6,23986 <ScrolltextCnt>
    2496:	moveq #0,d0
    2498:	move.w a0,d0
    249a:	lea 444a <Scrolltext>,a0
    24a0:	move.b (0,a0,d0.l),d0
	if (chr == 'm')
    24a4:	cmpi.b #109,d0
    24a8:	bne.w 1e16 <main+0x1da2>
    24ac:	bra.w 2404 <main+0x2390>
		Exit(0);
    24b0:	movea.l 23b7e <DOSBase>,a6
    24b6:	moveq #0,d1
    24b8:	jsr -144(a6)
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    24bc:	movea.l 23b86 <SysBase>,a6
    24c2:	lea 43c2 <incbin_P61_Player_end+0x12>,a1
    24c8:	moveq #0,d0
    24ca:	jsr -552(a6)
    24ce:	move.l d0,23b7e <DOSBase>
	if (!DOSBase)
    24d4:	bne.w c2 <main+0x4e>
		Exit(0);
    24d8:	suba.l a6,a6
    24da:	moveq #0,d1
    24dc:	jsr -144(a6)
    24e0:	bra.w c2 <main+0x4e>
	APTR vbr = 0;
    24e4:	moveq #0,d0
    24e6:	bra.w 85e <main+0x7ea>
				ScrollerDir -= 1;
    24ea:	move.b d0,6000 <ScrollerDir>
			ScrollerY += ScrollerDir;
    24f0:	ext.w d0
    24f2:	add.w d0,82(sp)
    24f6:	move.w 82(sp),2398e <ScrollerY>
    24fe:	bra.w 11ea <main+0x1176>
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
    2502:	movea.w d1,a2
    2504:	adda.w d1,a2
    2506:	sub.w a2,d6
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    2508:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    250c:	move.w d6,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    2510:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    2516:	move.w d6,6(a0)
		MirrorEnabled = !MirrorEnabled;
    251a:	tst.w d0
    251c:	seq d0
    251e:	ext.w d0
    2520:	neg.w d0
    2522:	move.w d0,23984 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    2528:	move.w 23986 <ScrolltextCnt>,d0
    252e:	movea.w d0,a2
    2530:	addq.w #1,a2
    2532:	move.w a2,23986 <ScrolltextCnt>
    2538:	andi.l #65535,d0
    253e:	lea 444a <Scrolltext>,a0
    2544:	move.b (0,a0,d0.l),d0
    2548:	bra.w 245e <main+0x23ea>

0000254c <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

static __attribute__((interrupt)) void interruptHandler()
{
    254c:	movem.l d0/a0/a3/a6,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    2550:	movea.l 23b8c <custom>,a0
    2556:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    255c:	move.w #32,156(a0)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    2562:	lea 2a4a <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    2568:	movea.l #14675968,a6
	__asm volatile(
    256e:	movem.l d0-a2/a4-a5,-(sp)
    2572:	jsr 4(a3)
    2576:	movem.l (sp)+,d0-a2/a4-a5

    // DEMO - ThePlayer
    p61Music();

    // DEMO - increment frameCounter
    frameCounter++;
    257a:	move.w 23b8a <frameCounter>,d0
    2580:	addq.w #1,d0
    2582:	move.w d0,23b8a <frameCounter>
}
    2588:	movem.l (sp)+,d0/a0/a3/a6
    258c:	rte

0000258e <WaitVbl>:
{
    258e:	subq.l #8,sp
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    2590:	move.l dff004 <_end+0xddb474>,d0
    2596:	move.l d0,(sp)
		vpos &= 0x1ff00;
    2598:	move.l (sp),d0
    259a:	andi.l #130816,d0
    25a0:	move.l d0,(sp)
		if (vpos != (311 << 8))
    25a2:	move.l (sp),d0
    25a4:	cmpi.l #79616,d0
    25aa:	beq.s 2590 <WaitVbl+0x2>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    25ac:	move.l dff004 <_end+0xddb474>,d0
    25b2:	move.l d0,4(sp)
		vpos &= 0x1ff00;
    25b6:	move.l 4(sp),d0
    25ba:	andi.l #130816,d0
    25c0:	move.l d0,4(sp)
		if (vpos == (311 << 8))
    25c4:	move.l 4(sp),d0
    25c8:	cmpi.l #79616,d0
    25ce:	bne.s 25ac <WaitVbl+0x1e>
}
    25d0:	addq.l #8,sp
    25d2:	rts

000025d4 <KPrintF>:
void KPrintF(const char* fmt, ...) {
    25d4:	lea -128(sp),sp
    25d8:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    25dc:	move.w f0ff60 <_end+0xeec3d0>,d0
    25e2:	cmpi.w #20153,d0
    25e6:	beq.s 2612 <KPrintF+0x3e>
    25e8:	cmpi.w #-24562,d0
    25ec:	beq.s 2612 <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    25ee:	movea.l 23b86 <SysBase>,a6
    25f4:	movea.l 144(sp),a0
    25f8:	lea 148(sp),a1
    25fc:	lea 2966 <KPutCharX>,a2
    2602:	suba.l a3,a3
    2604:	jsr -522(a6)
}
    2608:	movem.l (sp)+,a2-a3/a6
    260c:	lea 128(sp),sp
    2610:	rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    2612:	movea.l 23b86 <SysBase>,a6
    2618:	movea.l 144(sp),a0
    261c:	lea 148(sp),a1
    2620:	lea 2974 <PutChar>,a2
    2626:	lea 12(sp),a3
    262a:	jsr -522(a6)
		UaeDbgLog(86, temp);
    262e:	move.l a3,-(sp)
    2630:	pea 56 <_start+0x56>
    2634:	jsr f0ff60 <_end+0xeec3d0>
    263a:	addq.l #8,sp
}
    263c:	movem.l (sp)+,a2-a3/a6
    2640:	lea 128(sp),sp
    2644:	rts

00002646 <strlen>:
unsigned long strlen(const char* s) {
    2646:	movea.l 4(sp),a0
	unsigned long t=0;
    264a:	moveq #0,d0
	while(*s++)
    264c:	tst.b (a0)
    264e:	beq.s 2658 <strlen+0x12>
		t++;
    2650:	addq.l #1,d0
	while(*s++)
    2652:	tst.b (0,a0,d0.l)
    2656:	bne.s 2650 <strlen+0xa>
}
    2658:	rts

0000265a <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    265a:	movem.l d2-d7/a2-a3,-(sp)
    265e:	move.l 36(sp),d0
    2662:	move.l 40(sp),d4
    2666:	movea.l 44(sp),a1
	while(len-- > 0)
    266a:	move.l a1,d5
    266c:	subq.l #1,d5
    266e:	cmpa.w #0,a1
    2672:	beq.w 2722 <memset+0xc8>
		*ptr++ = val;
    2676:	move.b d4,d7
    2678:	move.l d0,d1
    267a:	neg.l d1
    267c:	moveq #3,d2
    267e:	and.l d2,d1
    2680:	moveq #5,d6
    2682:	movea.l d0,a2
    2684:	cmp.l d5,d6
    2686:	bcc.s 26f2 <memset+0x98>
    2688:	tst.l d1
    268a:	beq.s 26b0 <memset+0x56>
    268c:	move.b d4,(a2)+
	while(len-- > 0)
    268e:	subq.l #1,d5
    2690:	moveq #1,d2
    2692:	cmp.l d1,d2
    2694:	beq.s 26b0 <memset+0x56>
		*ptr++ = val;
    2696:	movea.l d0,a2
    2698:	addq.l #2,a2
    269a:	movea.l d0,a0
    269c:	move.b d4,1(a0)
	while(len-- > 0)
    26a0:	subq.l #1,d5
    26a2:	moveq #3,d2
    26a4:	cmp.l d1,d2
    26a6:	bne.s 26b0 <memset+0x56>
		*ptr++ = val;
    26a8:	addq.l #1,a2
    26aa:	move.b d4,2(a0)
	while(len-- > 0)
    26ae:	subq.l #1,d5
    26b0:	move.l a1,d3
    26b2:	sub.l d1,d3
    26b4:	moveq #0,d6
    26b6:	move.b d4,d6
    26b8:	move.l d6,d2
    26ba:	swap d2
    26bc:	clr.w d2
    26be:	movea.l d2,a0
    26c0:	move.l d4,d2
    26c2:	lsl.w #8,d2
    26c4:	swap d2
    26c6:	clr.w d2
    26c8:	lsl.l #8,d6
    26ca:	movea.l d6,a3
    26cc:	move.l a0,d6
    26ce:	or.l d6,d2
    26d0:	move.l a3,d6
    26d2:	or.l d6,d2
    26d4:	move.b d7,d2
    26d6:	movea.l d0,a0
    26d8:	adda.l d1,a0
    26da:	moveq #-4,d1
    26dc:	and.l d3,d1
    26de:	add.l a0,d1
		*ptr++ = val;
    26e0:	move.l d2,(a0)+
	while(len-- > 0)
    26e2:	cmpa.l d1,a0
    26e4:	bne.s 26e0 <memset+0x86>
    26e6:	moveq #-4,d1
    26e8:	and.l d3,d1
    26ea:	adda.l d1,a2
    26ec:	sub.l d1,d5
    26ee:	cmp.l d3,d1
    26f0:	beq.s 2722 <memset+0xc8>
		*ptr++ = val;
    26f2:	move.b d4,(a2)
	while(len-- > 0)
    26f4:	tst.l d5
    26f6:	beq.s 2722 <memset+0xc8>
		*ptr++ = val;
    26f8:	move.b d4,1(a2)
	while(len-- > 0)
    26fc:	moveq #1,d1
    26fe:	cmp.l d5,d1
    2700:	beq.s 2722 <memset+0xc8>
		*ptr++ = val;
    2702:	move.b d4,2(a2)
	while(len-- > 0)
    2706:	moveq #2,d2
    2708:	cmp.l d5,d2
    270a:	beq.s 2722 <memset+0xc8>
		*ptr++ = val;
    270c:	move.b d4,3(a2)
	while(len-- > 0)
    2710:	moveq #3,d6
    2712:	cmp.l d5,d6
    2714:	beq.s 2722 <memset+0xc8>
		*ptr++ = val;
    2716:	move.b d4,4(a2)
	while(len-- > 0)
    271a:	subq.l #4,d5
    271c:	beq.s 2722 <memset+0xc8>
		*ptr++ = val;
    271e:	move.b d4,5(a2)
}
    2722:	movem.l (sp)+,d2-d7/a2-a3
    2726:	rts

00002728 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    2728:	movem.l d2-d6,-(sp)
    272c:	move.l 24(sp),d0
    2730:	move.l 28(sp),d1
    2734:	move.l 32(sp),d3
	while(len--)
    2738:	move.l d3,d4
    273a:	subq.l #1,d4
    273c:	tst.l d3
    273e:	beq.s 279e <memcpy+0x76>
    2740:	movea.l d1,a0
    2742:	addq.l #1,a0
    2744:	move.l d0,d2
    2746:	sub.l a0,d2
    2748:	moveq #2,d5
    274a:	cmp.l d2,d5
    274c:	sc.s d2
    274e:	neg.b d2
    2750:	moveq #8,d6
    2752:	cmp.l d4,d6
    2754:	sc.s d5
    2756:	neg.b d5
    2758:	and.b d5,d2
    275a:	beq.s 27a4 <memcpy+0x7c>
    275c:	move.l d0,d2
    275e:	or.l d1,d2
    2760:	moveq #3,d5
    2762:	and.l d5,d2
    2764:	bne.s 27a4 <memcpy+0x7c>
    2766:	movea.l d1,a0
    2768:	movea.l d0,a1
    276a:	moveq #-4,d2
    276c:	and.l d3,d2
    276e:	add.l d1,d2
		*d++ = *s++;
    2770:	move.l (a0)+,(a1)+
	while(len--)
    2772:	cmp.l a0,d2
    2774:	bne.s 2770 <memcpy+0x48>
    2776:	moveq #-4,d2
    2778:	and.l d3,d2
    277a:	movea.l d0,a0
    277c:	adda.l d2,a0
    277e:	add.l d2,d1
    2780:	sub.l d2,d4
    2782:	cmp.l d3,d2
    2784:	beq.s 279e <memcpy+0x76>
		*d++ = *s++;
    2786:	movea.l d1,a1
    2788:	move.b (a1),(a0)
	while(len--)
    278a:	tst.l d4
    278c:	beq.s 279e <memcpy+0x76>
		*d++ = *s++;
    278e:	move.b 1(a1),1(a0)
	while(len--)
    2794:	subq.l #1,d4
    2796:	beq.s 279e <memcpy+0x76>
		*d++ = *s++;
    2798:	move.b 2(a1),2(a0)
}
    279e:	movem.l (sp)+,d2-d6
    27a2:	rts
    27a4:	movea.l d0,a1
    27a6:	add.l d3,d1
		*d++ = *s++;
    27a8:	move.b -1(a0),(a1)+
	while(len--)
    27ac:	cmp.l a0,d1
    27ae:	beq.s 279e <memcpy+0x76>
    27b0:	addq.l #1,a0
    27b2:	bra.s 27a8 <memcpy+0x80>

000027b4 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    27b4:	movem.l d2-d5/a2,-(sp)
    27b8:	move.l 24(sp),d0
    27bc:	move.l 28(sp),d1
    27c0:	move.l 32(sp),d2
		while (len--)
    27c4:	movea.l d2,a1
    27c6:	subq.l #1,a1
	if (d < s) {
    27c8:	cmp.l d0,d1
    27ca:	bls.s 2838 <memmove+0x84>
		while (len--)
    27cc:	tst.l d2
    27ce:	beq.s 2832 <memmove+0x7e>
    27d0:	movea.l d1,a2
    27d2:	addq.l #1,a2
    27d4:	move.l d0,d3
    27d6:	sub.l a2,d3
    27d8:	moveq #2,d4
    27da:	cmp.l d3,d4
    27dc:	sc.s d3
    27de:	neg.b d3
    27e0:	moveq #8,d5
    27e2:	cmp.l a1,d5
    27e4:	sc.s d4
    27e6:	neg.b d4
    27e8:	and.b d4,d3
    27ea:	beq.s 285c <memmove+0xa8>
    27ec:	move.l d0,d3
    27ee:	or.l d1,d3
    27f0:	moveq #3,d4
    27f2:	and.l d4,d3
    27f4:	bne.s 285c <memmove+0xa8>
    27f6:	movea.l d1,a0
    27f8:	movea.l d0,a2
    27fa:	moveq #-4,d3
    27fc:	and.l d2,d3
    27fe:	add.l d1,d3
			*d++ = *s++;
    2800:	move.l (a0)+,(a2)+
		while (len--)
    2802:	cmp.l a0,d3
    2804:	bne.s 2800 <memmove+0x4c>
    2806:	moveq #-4,d3
    2808:	and.l d2,d3
    280a:	movea.l d0,a2
    280c:	adda.l d3,a2
    280e:	movea.l d1,a0
    2810:	adda.l d3,a0
    2812:	suba.l d3,a1
    2814:	cmp.l d2,d3
    2816:	beq.s 2832 <memmove+0x7e>
			*d++ = *s++;
    2818:	move.b (a0),(a2)
		while (len--)
    281a:	cmpa.w #0,a1
    281e:	beq.s 2832 <memmove+0x7e>
			*d++ = *s++;
    2820:	move.b 1(a0),1(a2)
		while (len--)
    2826:	moveq #1,d5
    2828:	cmp.l a1,d5
    282a:	beq.s 2832 <memmove+0x7e>
			*d++ = *s++;
    282c:	move.b 2(a0),2(a2)
}
    2832:	movem.l (sp)+,d2-d5/a2
    2836:	rts
		const char *lasts = s + (len - 1);
    2838:	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    283c:	adda.l d0,a1
		while (len--)
    283e:	tst.l d2
    2840:	beq.s 2832 <memmove+0x7e>
    2842:	move.l a0,d1
    2844:	sub.l d2,d1
			*lastd-- = *lasts--;
    2846:	move.b (a0),(a1)
		while (len--)
    2848:	subq.l #1,a0
    284a:	subq.l #1,a1
    284c:	cmp.l a0,d1
    284e:	beq.s 2832 <memmove+0x7e>
			*lastd-- = *lasts--;
    2850:	move.b (a0),(a1)
		while (len--)
    2852:	subq.l #1,a0
    2854:	subq.l #1,a1
    2856:	cmp.l a0,d1
    2858:	bne.s 2846 <memmove+0x92>
    285a:	bra.s 2832 <memmove+0x7e>
    285c:	movea.l d0,a1
    285e:	add.l d2,d1
			*d++ = *s++;
    2860:	move.b -1(a2),(a1)+
		while (len--)
    2864:	cmp.l a2,d1
    2866:	beq.s 2832 <memmove+0x7e>
    2868:	addq.l #1,a2
    286a:	bra.s 2860 <memmove+0xac>

0000286c <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    286c:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    2870:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2874:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    2878:	mulu.w 8(sp),d1
	addw	d1, d0
    287c:	add.w d1,d0
	swap	d0
    287e:	swap d0
	clrw	d0
    2880:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2882:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    2886:	mulu.w 10(sp),d1
	addl	d1, d0
    288a:	add.l d1,d0
	rts
    288c:	rts

0000288e <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    288e:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    2890:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    2894:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    2898:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    289e:	bcc.s 28b6 <__udivsi3+0x28>
	movel	d0, d2
    28a0:	move.l d0,d2
	clrw	d2
    28a2:	clr.w d2
	swap	d2
    28a4:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    28a6:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    28a8:	move.w d2,d0
	swap	d0
    28aa:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    28ac:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    28b0:	divu.w d1,d2
	movew	d2, d0
    28b2:	move.w d2,d0
	jra	6f
    28b4:	bra.s 28e6 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    28b6:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    28b8:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    28ba:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    28bc:	cmpi.l #65536,d1
	jcc	4b
    28c2:	bcc.s 28b8 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    28c4:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    28c6:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    28cc:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    28ce:	mulu.w d0,d1
	swap	d2
    28d0:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    28d2:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    28d4:	swap d2
	tstw	d2		/* high part 17 bits? */
    28d6:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    28d8:	bne.s 28e4 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    28da:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    28dc:	bcs.s 28e4 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    28de:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    28e2:	bls.s 28e6 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    28e4:	subq.l #1,d0

6:	movel	sp@+, d2
    28e6:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    28e8:	rts

000028ea <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    28ea:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    28ec:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    28ee:	move.l 12(sp),d1
	jpl	1f
    28f2:	bpl.s 28f8 <__divsi3+0xe>
	negl	d1
    28f4:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    28f6:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    28f8:	move.l 8(sp),d0
	jpl	2f
    28fc:	bpl.s 2902 <__divsi3+0x18>
	negl	d0
    28fe:	neg.l d0
	negb	d2
    2900:	neg.b d2

2:	movel	d1, sp@-
    2902:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2904:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    2906:	bsr.s 288e <__udivsi3>
	addql	#8, sp
    2908:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    290a:	tst.b d2
	jpl	3f
    290c:	bpl.s 2910 <__divsi3+0x26>
	negl	d0
    290e:	neg.l d0

3:	movel	sp@+, d2
    2910:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    2912:	rts

00002914 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    2914:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    2918:	move.l 4(sp),d0
	movel	d1, sp@-
    291c:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    291e:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    2920:	bsr.s 28ea <__divsi3>
	addql	#8, sp
    2922:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    2924:	move.l 8(sp),d1
	movel	d1, sp@-
    2928:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    292a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    292c:	bsr.w 286c <__mulsi3>
	addql	#8, sp
    2930:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2932:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2936:	sub.l d0,d1
	movel	d1, d0
    2938:	move.l d1,d0
	rts
    293a:	rts

0000293c <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    293c:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    2940:	move.l 4(sp),d0
	movel	d1, sp@-
    2944:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2946:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    2948:	bsr.w 288e <__udivsi3>
	addql	#8, sp
    294c:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    294e:	move.l 8(sp),d1
	movel	d1, sp@-
    2952:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2954:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    2956:	bsr.w 286c <__mulsi3>
	addql	#8, sp
    295a:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    295c:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2960:	sub.l d0,d1
	movel	d1, d0
    2962:	move.l d1,d0
	rts
    2964:	rts

00002966 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    2966:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    2968:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    296c:	jsr -516(a6)
    move.l (sp)+, a6
    2970:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    2972:	rts

00002974 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    2974:	move.b d0,(a3)+
	rts
    2976:	rts

00002978 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    2978:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    297a:	adda.l a0,a2
	move.l	a2,a3
    297c:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    297e:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    2980:	moveq #56,d4
	moveq	#8,d5
    2982:	moveq #8,d5
	bra.s	.Lliteral
    2984:	bra.s 29ee <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    2986:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    2988:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    298a:	dbf d1,2986 <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    298e:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    2990:	bcc.s 2994 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    2992:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    2994:	tst.w d0
    2996:	bne.s 29a0 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    2998:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    299a:	bls.s 2a12 <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    299c:	move.w (a0)+,d0
    299e:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    29a0:	rol.l #6,d0
	move.w	d0,d1
    29a2:	move.w d0,d1
	and.w	d4,d1
    29a4:	and.w d4,d1
	eor.w	d1,d0
    29a6:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    29a8:	movem.w (2a0c <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    29ae:	rol.l d2,d0
	and.w	d0,d3					|scaling
    29b0:	and.w d0,d3
	eor.w	d3,d0
    29b2:	eor.w d3,d0
	suba.w	d3,a4
    29b4:	suba.w d3,a4
	adda.l	a1,a4
    29b6:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    29b8:	tst.w d0
    29ba:	bne.s 29c0 <_doynaxdepack_asm+0x48>
    29bc:	move.w (a0)+,d0
    29be:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    29c0:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    29c2:	beq.s 29da <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    29c4:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    29c6:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    29c8:	bpl.s 29d6 <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    29ca:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    29cc:	bpl.s 29d4 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    29ce:	addx.b d1,d1
	lsl.l	#2,d0
    29d0:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    29d2:	bmi.s 29ce <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    29d4:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    29d6:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    29d8:	bcc.s 29dc <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    29da:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    29dc:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    29de:	dbf d1,29da <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    29e2:	add.l d0,d0
	bcc.s	.Lmatch
    29e4:	bcc.s 2994 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    29e6:	tst.w d0
    29e8:	bne.s 29ee <_doynaxdepack_asm+0x76>
    29ea:	move.w (a0)+,d0
    29ec:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    29ee:	moveq #0,d1
	add.l	d0,d0
    29f0:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    29f2:	bcc.s 2992 <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    29f4:	bpl.s 29fc <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    29f6:	addx.b d1,d1
	lsl.l	#2,d0
    29f8:	lsl.l #2,d0
	bmi.s	.Llgetlen
    29fa:	bmi.s 29f6 <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    29fc:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    29fe:	dbv.s d1,2986 <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    2a02:	add.l d0,d0
	eor.w	d1,d0		
    2a04:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    2a06:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    2a08:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    2a0a:	bra.s 29fe <_doynaxdepack_asm+0x86>

00002a0c <doy_table>:
    2a0c:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    2a1c:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    2a2c:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    2a3c:	.............o
