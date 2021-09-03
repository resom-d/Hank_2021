
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
       4:	move.l #24959,d3
       a:	subi.l #24959,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	beq.s 26 <_start+0x26>
      14:	lea 617f <__fini_array_end>,a2
      1a:	moveq #0,d2
		__preinit_array_start[i]();
      1c:	movea.l (a2)+,a0
      1e:	jsr (a0)
	for (i = 0; i < count; i++)
      20:	addq.l #1,d2
      22:	cmp.l d3,d2
      24:	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	move.l #24959,d3
      2c:	subi.l #24959,d3
      32:	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	beq.s 48 <_start+0x48>
      36:	lea 617f <__fini_array_end>,a2
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
      4e:	move.l #24959,d2
      54:	subi.l #24959,d2
      5a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	beq.s 6e <_start+0x6e>
      5e:	lea 617f <__fini_array_end>,a2
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
      74:	lea -156(sp),sp
      78:	movem.l d2-d7/a2-a6,-(sp)

	SysBase = *((struct ExecBase **)4UL);
      7c:	movea.l 4 <_start+0x4>,a6
      80:	move.l a6,23752 <SysBase>
	custom = (struct Custom *)0xdff000;
      86:	move.l #14675968,23758 <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
      90:	lea 3e7d <incbin_P61_Player_end+0x1>,a1
      96:	moveq #0,d0
      98:	jsr -552(a6)
      9c:	move.l d0,2374e <GfxBase>
	if (!GfxBase)
      a2:	beq.w 1fce <main+0x1f5a>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
      a6:	movea.l 23752 <SysBase>,a6
      ac:	lea 3e8e <incbin_P61_Player_end+0x12>,a1
      b2:	moveq #0,d0
      b4:	jsr -552(a6)
      b8:	move.l d0,2374a <DOSBase>
	if (!DOSBase)
      be:	beq.w 1fc2 <main+0x1f4e>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      c2:	pea 3e9a <incbin_P61_Player_end+0x1e>
      c8:	lea 20a0 <KPrintF>,a4
      ce:	jsr (a4)
#endif

	Write(Output(), (APTR) "Hello console!\n", 15);
      d0:	movea.l 2374a <DOSBase>,a6
      d6:	jsr -60(a6)
      da:	movea.l 2374a <DOSBase>,a6
      e0:	move.l d0,d1
      e2:	move.l #16054,d2
      e8:	moveq #15,d3
      ea:	jsr -48(a6)
}

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{

	bmp->Width = w;
      ee:	move.l #20971776,23718 <Screen>
      f8:	move.l #196648,2371c <Screen+0x4>
	bmp->Height = h;
	bmp->Bpls = bpls;
	bmp->Bpl = w / 8;
	bmp->Bplt = w / 8 * bpls;
     102:	move.w #120,23720 <Screen+0x8>
	bmp->Btot = w / 8 * h * bpls;
     10a:	move.w #30720,23724 <Screen+0xc>
	bmp->Width = w;
     112:	move.l #16777346,236e4 <BmpLogo>
     11c:	move.l #196640,236e8 <BmpLogo+0x4>
	bmp->Bplt = w / 8 * bpls;
     126:	move.w #96,236ec <BmpLogo+0x8>
	bmp->Btot = w / 8 * h * bpls;
     12e:	move.w #12480,236f0 <BmpLogo+0xc>
	bmp->Width = w;
     136:	move.l #20971650,236b0 <BmpUpperPart_PF1>
     140:	move.l #196648,236b4 <BmpUpperPart_PF1+0x4>
	bmp->Bplt = w / 8 * bpls;
     14a:	move.w #120,236b8 <BmpUpperPart_PF1+0x8>
	bmp->Btot = w / 8 * h * bpls;
     152:	move.w #15600,236bc <BmpUpperPart_PF1+0xc>
	bmp->Width = w;
     15a:	move.l #20971650,2367c <BmpUpperPart_PF2>
     164:	move.l #196648,23680 <BmpUpperPart_PF2+0x4>
	bmp->Bplt = w / 8 * bpls;
     16e:	move.w #120,23684 <BmpUpperPart_PF2+0x8>
	bmp->Btot = w / 8 * h * bpls;
     176:	move.w #15600,23688 <BmpUpperPart_PF2+0xc>
	bmp->Width = w;
     17e:	move.l #20971650,23648 <BmpUpperPart_Buf1>
     188:	move.l #196648,2364c <BmpUpperPart_Buf1+0x4>
	bmp->Bplt = w / 8 * bpls;
     192:	move.w #120,23650 <BmpUpperPart_Buf1+0x8>
	bmp->Btot = w / 8 * h * bpls;
     19a:	move.w #15600,23654 <BmpUpperPart_Buf1+0xc>
	bmp->Width = w;
     1a2:	move.l #23068838,23614 <BmpScroller>
     1ac:	move.l #196652,23618 <BmpScroller+0x4>
	bmp->Bplt = w / 8 * bpls;
     1b6:	move.w #132,2361c <BmpScroller+0x8>
	bmp->Btot = w / 8 * h * bpls;
     1be:	move.w #21912,23620 <BmpScroller+0xc>
	bmp->Width = w;
     1c6:	move.l #20971776,235e0 <BmpFont32>
     1d0:	move.l #196648,235e4 <BmpFont32+0x4>
	bmp->Bplt = w / 8 * bpls;
     1da:	move.w #120,235e8 <BmpFont32+0x8>
	bmp->Btot = w / 8 * h * bpls;
     1e2:	move.w #30720,235ec <BmpFont32+0xc>
	bmp->Width = w;
     1ea:	move.l #20971776,235ac <BmpCookie>
     1f4:	move.l #196648,235b0 <BmpCookie+0x4>
	bmp->Bplt = w / 8 * bpls;
     1fe:	move.w #120,235b4 <BmpCookie+0x8>
	bmp->Btot = w / 8 * h * bpls;
     206:	move.w #30720,235b8 <BmpCookie+0xc>
	bmp->Width = w;
     20e:	move.l #20971776,23578 <BmpCookieMask>
     218:	move.l #196648,2357c <BmpCookieMask+0x4>
	bmp->Bplt = w / 8 * bpls;
     222:	move.w #120,23580 <BmpCookieMask+0x8>
	bmp->Btot = w / 8 * h * bpls;
     22a:	move.w #30720,23584 <BmpCookieMask+0xc>
	copPtr = AllocMem(1024, MEMF_CHIP);
     232:	movea.l 23752 <SysBase>,a6
     238:	move.l #1024,d0
     23e:	moveq #2,d1
     240:	jsr -198(a6)
     244:	move.l d0,23572 <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
     24a:	movea.l 23752 <SysBase>,a6
     250:	moveq #0,d0
     252:	move.w 23620 <BmpScroller+0xc>,d0
     258:	move.l #65538,d1
     25e:	jsr -198(a6)
     262:	move.l d0,23622 <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
     268:	movea.l 23752 <SysBase>,a6
     26e:	moveq #0,d0
     270:	move.w 236bc <BmpUpperPart_PF1+0xc>,d0
     276:	move.l #65538,d1
     27c:	jsr -198(a6)
     280:	move.l d0,236be <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
     286:	movea.l 23752 <SysBase>,a6
     28c:	moveq #0,d0
     28e:	move.w 23688 <BmpUpperPart_PF2+0xc>,d0
     294:	move.l #65538,d1
     29a:	jsr -198(a6)
     29e:	move.l d0,2368a <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
     2a4:	movea.l 23752 <SysBase>,a6
     2aa:	moveq #0,d0
     2ac:	move.w 23654 <BmpUpperPart_Buf1+0xc>,d0
     2b2:	move.l #65538,d1
     2b8:	jsr -198(a6)
     2bc:	move.l d0,23656 <BmpUpperPart_Buf1+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
     2c2:	move.l #24964,236f2 <BmpLogo+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
     2cc:	move.l #37446,235ee <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
     2d6:	move.l #68168,235ba <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
     2e0:	move.l #98890,23586 <BmpCookieMask+0xe>
	for (int p = 0; p < img->Bpls; p++)
     2ea:	moveq #0,d2
     2ec:	move.w 236b4 <BmpUpperPart_PF1+0x4>,d2
     2f2:	addq.l #4,sp
     2f4:	tst.l d2
     2f6:	beq.w 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2fa:	movea.l 236be <BmpUpperPart_PF1+0xe>,a0
     300:	moveq #0,d3
     302:	move.w 236b6 <BmpUpperPart_PF1+0x6>,d3
     308:	move.l a0,236c2 <BmpUpperPart_PF1+0x12>
	for (int p = 0; p < img->Bpls; p++)
     30e:	moveq #1,d1
     310:	cmp.l d2,d1
     312:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     314:	lea (0,a0,d3.l),a1
     318:	move.l a1,236c6 <BmpUpperPart_PF1+0x16>
	for (int p = 0; p < img->Bpls; p++)
     31e:	moveq #2,d1
     320:	cmp.l d2,d1
     322:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     324:	move.l d3,d1
     326:	add.l d3,d1
     328:	lea (0,a0,d1.l),a1
     32c:	move.l a1,236ca <BmpUpperPart_PF1+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     332:	moveq #3,d4
     334:	cmp.l d2,d4
     336:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     338:	add.l d3,d1
     33a:	lea (0,a0,d1.l),a1
     33e:	move.l a1,236ce <BmpUpperPart_PF1+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     344:	moveq #4,d4
     346:	cmp.l d2,d4
     348:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     34a:	add.l d3,d1
     34c:	lea (0,a0,d1.l),a1
     350:	move.l a1,236d2 <BmpUpperPart_PF1+0x22>
	for (int p = 0; p < img->Bpls; p++)
     356:	moveq #5,d4
     358:	cmp.l d2,d4
     35a:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     35c:	add.l d3,d1
     35e:	lea (0,a0,d1.l),a1
     362:	move.l a1,236d6 <BmpUpperPart_PF1+0x26>
	for (int p = 0; p < img->Bpls; p++)
     368:	moveq #6,d4
     36a:	cmp.l d2,d4
     36c:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     36e:	add.l d3,d1
     370:	lea (0,a0,d1.l),a1
     374:	move.l a1,236da <BmpUpperPart_PF1+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     37a:	subq.l #7,d2
     37c:	beq.s 388 <main+0x314>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     37e:	add.l d3,d1
     380:	add.l a0,d1
     382:	move.l d1,236de <BmpUpperPart_PF1+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     388:	moveq #0,d2
     38a:	move.w 23680 <BmpUpperPart_PF2+0x4>,d2
     390:	tst.l d2
     392:	beq.w 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     396:	movea.l 2368a <BmpUpperPart_PF2+0xe>,a0
     39c:	moveq #0,d3
     39e:	move.w 23682 <BmpUpperPart_PF2+0x6>,d3
     3a4:	move.l a0,2368e <BmpUpperPart_PF2+0x12>
	for (int p = 0; p < img->Bpls; p++)
     3aa:	moveq #1,d1
     3ac:	cmp.l d2,d1
     3ae:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3b0:	lea (0,a0,d3.l),a1
     3b4:	move.l a1,23692 <BmpUpperPart_PF2+0x16>
	for (int p = 0; p < img->Bpls; p++)
     3ba:	moveq #2,d1
     3bc:	cmp.l d2,d1
     3be:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3c0:	move.l d3,d1
     3c2:	add.l d3,d1
     3c4:	lea (0,a0,d1.l),a1
     3c8:	move.l a1,23696 <BmpUpperPart_PF2+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     3ce:	moveq #3,d4
     3d0:	cmp.l d2,d4
     3d2:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3d4:	add.l d3,d1
     3d6:	lea (0,a0,d1.l),a1
     3da:	move.l a1,2369a <BmpUpperPart_PF2+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     3e0:	moveq #4,d4
     3e2:	cmp.l d2,d4
     3e4:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3e6:	add.l d3,d1
     3e8:	lea (0,a0,d1.l),a1
     3ec:	move.l a1,2369e <BmpUpperPart_PF2+0x22>
	for (int p = 0; p < img->Bpls; p++)
     3f2:	moveq #5,d4
     3f4:	cmp.l d2,d4
     3f6:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3f8:	add.l d3,d1
     3fa:	lea (0,a0,d1.l),a1
     3fe:	move.l a1,236a2 <BmpUpperPart_PF2+0x26>
	for (int p = 0; p < img->Bpls; p++)
     404:	moveq #6,d4
     406:	cmp.l d2,d4
     408:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     40a:	add.l d3,d1
     40c:	lea (0,a0,d1.l),a1
     410:	move.l a1,236a6 <BmpUpperPart_PF2+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     416:	subq.l #7,d2
     418:	beq.s 424 <main+0x3b0>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     41a:	add.l d3,d1
     41c:	add.l a0,d1
     41e:	move.l d1,236aa <BmpUpperPart_PF2+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     424:	moveq #0,d2
     426:	move.w 2364c <BmpUpperPart_Buf1+0x4>,d2
     42c:	tst.l d2
     42e:	beq.w 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     432:	moveq #0,d3
     434:	move.w 2364e <BmpUpperPart_Buf1+0x6>,d3
     43a:	move.l d0,2365a <BmpUpperPart_Buf1+0x12>
	for (int p = 0; p < img->Bpls; p++)
     440:	moveq #1,d1
     442:	cmp.l d2,d1
     444:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     446:	move.l d0,d4
     448:	add.l d3,d4
     44a:	move.l d4,2365e <BmpUpperPart_Buf1+0x16>
	for (int p = 0; p < img->Bpls; p++)
     450:	moveq #2,d1
     452:	cmp.l d2,d1
     454:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     456:	move.l d3,d1
     458:	add.l d3,d1
     45a:	move.l d0,d4
     45c:	add.l d1,d4
     45e:	move.l d4,23662 <BmpUpperPart_Buf1+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     464:	moveq #3,d4
     466:	cmp.l d2,d4
     468:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     46a:	add.l d3,d1
     46c:	move.l d0,d4
     46e:	add.l d1,d4
     470:	move.l d4,23666 <BmpUpperPart_Buf1+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     476:	moveq #4,d4
     478:	cmp.l d2,d4
     47a:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     47c:	add.l d3,d1
     47e:	move.l d0,d4
     480:	add.l d1,d4
     482:	move.l d4,2366a <BmpUpperPart_Buf1+0x22>
	for (int p = 0; p < img->Bpls; p++)
     488:	moveq #5,d4
     48a:	cmp.l d2,d4
     48c:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     48e:	add.l d3,d1
     490:	move.l d0,d4
     492:	add.l d1,d4
     494:	move.l d4,2366e <BmpUpperPart_Buf1+0x26>
	for (int p = 0; p < img->Bpls; p++)
     49a:	moveq #6,d4
     49c:	cmp.l d2,d4
     49e:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4a0:	add.l d3,d1
     4a2:	move.l d0,d4
     4a4:	add.l d1,d4
     4a6:	move.l d4,23672 <BmpUpperPart_Buf1+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     4ac:	subq.l #7,d2
     4ae:	beq.s 4ba <main+0x446>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4b0:	add.l d3,d1
     4b2:	add.l d1,d0
     4b4:	move.l d0,23676 <BmpUpperPart_Buf1+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     4ba:	moveq #0,d1
     4bc:	move.w 23618 <BmpScroller+0x4>,d1
     4c2:	tst.l d1
     4c4:	beq.w 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4c8:	movea.l 23622 <BmpScroller+0xe>,a0
     4ce:	moveq #0,d2
     4d0:	move.w 2361a <BmpScroller+0x6>,d2
     4d6:	move.l a0,23626 <BmpScroller+0x12>
	for (int p = 0; p < img->Bpls; p++)
     4dc:	moveq #1,d0
     4de:	cmp.l d1,d0
     4e0:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4e2:	lea (0,a0,d2.l),a1
     4e6:	move.l a1,2362a <BmpScroller+0x16>
	for (int p = 0; p < img->Bpls; p++)
     4ec:	moveq #2,d0
     4ee:	cmp.l d1,d0
     4f0:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4f2:	move.l d2,d0
     4f4:	add.l d2,d0
     4f6:	lea (0,a0,d0.l),a1
     4fa:	move.l a1,2362e <BmpScroller+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     500:	moveq #3,d3
     502:	cmp.l d1,d3
     504:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     506:	add.l d2,d0
     508:	lea (0,a0,d0.l),a1
     50c:	move.l a1,23632 <BmpScroller+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     512:	moveq #4,d3
     514:	cmp.l d1,d3
     516:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     518:	add.l d2,d0
     51a:	lea (0,a0,d0.l),a1
     51e:	move.l a1,23636 <BmpScroller+0x22>
	for (int p = 0; p < img->Bpls; p++)
     524:	moveq #5,d3
     526:	cmp.l d1,d3
     528:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     52a:	add.l d2,d0
     52c:	lea (0,a0,d0.l),a1
     530:	move.l a1,2363a <BmpScroller+0x26>
	for (int p = 0; p < img->Bpls; p++)
     536:	moveq #6,d3
     538:	cmp.l d1,d3
     53a:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     53c:	add.l d2,d0
     53e:	lea (0,a0,d0.l),a1
     542:	move.l a1,2363e <BmpScroller+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     548:	subq.l #7,d1
     54a:	beq.s 556 <main+0x4e2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     54c:	add.l d2,d0
     54e:	add.l a0,d0
     550:	move.l d0,23642 <BmpScroller+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     556:	moveq #0,d1
     558:	move.w 235e4 <BmpFont32+0x4>,d1
     55e:	tst.l d1
     560:	beq.w 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     564:	moveq #0,d2
     566:	move.w 235e6 <BmpFont32+0x6>,d2
     56c:	move.l #37446,235f2 <BmpFont32+0x12>
	for (int p = 0; p < img->Bpls; p++)
     576:	moveq #1,d4
     578:	cmp.l d1,d4
     57a:	beq.w 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     57e:	move.l d2,d0
     580:	addi.l #37446,d0
     586:	move.l d0,235f6 <BmpFont32+0x16>
	for (int p = 0; p < img->Bpls; p++)
     58c:	moveq #2,d3
     58e:	cmp.l d1,d3
     590:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     592:	move.l d2,d0
     594:	add.l d2,d0
     596:	move.l d0,d4
     598:	addi.l #37446,d4
     59e:	move.l d4,235fa <BmpFont32+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     5a4:	moveq #3,d3
     5a6:	cmp.l d1,d3
     5a8:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5aa:	add.l d2,d0
     5ac:	move.l d0,d4
     5ae:	addi.l #37446,d4
     5b4:	move.l d4,235fe <BmpFont32+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     5ba:	moveq #4,d3
     5bc:	cmp.l d1,d3
     5be:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5c0:	add.l d2,d0
     5c2:	move.l d0,d4
     5c4:	addi.l #37446,d4
     5ca:	move.l d4,23602 <BmpFont32+0x22>
	for (int p = 0; p < img->Bpls; p++)
     5d0:	moveq #5,d3
     5d2:	cmp.l d1,d3
     5d4:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5d6:	add.l d2,d0
     5d8:	move.l d0,d4
     5da:	addi.l #37446,d4
     5e0:	move.l d4,23606 <BmpFont32+0x26>
	for (int p = 0; p < img->Bpls; p++)
     5e6:	moveq #6,d3
     5e8:	cmp.l d1,d3
     5ea:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5ec:	add.l d2,d0
     5ee:	move.l d0,d4
     5f0:	addi.l #37446,d4
     5f6:	move.l d4,2360a <BmpFont32+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     5fc:	subq.l #7,d1
     5fe:	beq.s 60e <main+0x59a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     600:	add.l d2,d0
     602:	addi.l #37446,d0
     608:	move.l d0,2360e <BmpFont32+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     60e:	moveq #0,d1
     610:	move.w 235b0 <BmpCookie+0x4>,d1
     616:	tst.l d1
     618:	beq.w 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     61c:	moveq #0,d2
     61e:	move.w 235b2 <BmpCookie+0x6>,d2
     624:	move.l #68168,235be <BmpCookie+0x12>
	for (int p = 0; p < img->Bpls; p++)
     62e:	moveq #1,d4
     630:	cmp.l d1,d4
     632:	beq.w 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     636:	move.l d2,d0
     638:	addi.l #68168,d0
     63e:	move.l d0,235c2 <BmpCookie+0x16>
	for (int p = 0; p < img->Bpls; p++)
     644:	moveq #2,d3
     646:	cmp.l d1,d3
     648:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     64a:	move.l d2,d0
     64c:	add.l d2,d0
     64e:	move.l d0,d4
     650:	addi.l #68168,d4
     656:	move.l d4,235c6 <BmpCookie+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     65c:	moveq #3,d3
     65e:	cmp.l d1,d3
     660:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     662:	add.l d2,d0
     664:	move.l d0,d4
     666:	addi.l #68168,d4
     66c:	move.l d4,235ca <BmpCookie+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     672:	moveq #4,d3
     674:	cmp.l d1,d3
     676:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     678:	add.l d2,d0
     67a:	move.l d0,d4
     67c:	addi.l #68168,d4
     682:	move.l d4,235ce <BmpCookie+0x22>
	for (int p = 0; p < img->Bpls; p++)
     688:	moveq #5,d3
     68a:	cmp.l d1,d3
     68c:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     68e:	add.l d2,d0
     690:	move.l d0,d4
     692:	addi.l #68168,d4
     698:	move.l d4,235d2 <BmpCookie+0x26>
	for (int p = 0; p < img->Bpls; p++)
     69e:	moveq #6,d3
     6a0:	cmp.l d1,d3
     6a2:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6a4:	add.l d2,d0
     6a6:	move.l d0,d4
     6a8:	addi.l #68168,d4
     6ae:	move.l d4,235d6 <BmpCookie+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     6b4:	subq.l #7,d1
     6b6:	beq.s 6c6 <main+0x652>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6b8:	add.l d2,d0
     6ba:	addi.l #68168,d0
     6c0:	move.l d0,235da <BmpCookie+0x2e>
	for (int p = 0; p < img->Bpls; p++)
     6c6:	moveq #0,d1
     6c8:	move.w 2357c <BmpCookieMask+0x4>,d1
     6ce:	tst.l d1
     6d0:	beq.w 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6d4:	moveq #0,d2
     6d6:	move.w 2357e <BmpCookieMask+0x6>,d2
     6dc:	move.l #98890,2358a <BmpCookieMask+0x12>
	for (int p = 0; p < img->Bpls; p++)
     6e6:	moveq #1,d4
     6e8:	cmp.l d1,d4
     6ea:	beq.w 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     6ee:	move.l d2,d0
     6f0:	addi.l #98890,d0
     6f6:	move.l d0,2358e <BmpCookieMask+0x16>
	for (int p = 0; p < img->Bpls; p++)
     6fc:	moveq #2,d3
     6fe:	cmp.l d1,d3
     700:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     702:	move.l d2,d0
     704:	add.l d2,d0
     706:	move.l d0,d4
     708:	addi.l #98890,d4
     70e:	move.l d4,23592 <BmpCookieMask+0x1a>
	for (int p = 0; p < img->Bpls; p++)
     714:	moveq #3,d3
     716:	cmp.l d1,d3
     718:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     71a:	add.l d2,d0
     71c:	move.l d0,d4
     71e:	addi.l #98890,d4
     724:	move.l d4,23596 <BmpCookieMask+0x1e>
	for (int p = 0; p < img->Bpls; p++)
     72a:	moveq #4,d3
     72c:	cmp.l d1,d3
     72e:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     730:	add.l d2,d0
     732:	move.l d0,d4
     734:	addi.l #98890,d4
     73a:	move.l d4,2359a <BmpCookieMask+0x22>
	for (int p = 0; p < img->Bpls; p++)
     740:	moveq #5,d3
     742:	cmp.l d1,d3
     744:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     746:	add.l d2,d0
     748:	move.l d0,d4
     74a:	addi.l #98890,d4
     750:	move.l d4,2359e <BmpCookieMask+0x26>
	for (int p = 0; p < img->Bpls; p++)
     756:	moveq #6,d3
     758:	cmp.l d1,d3
     75a:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     75c:	add.l d2,d0
     75e:	move.l d0,d4
     760:	addi.l #98890,d4
     766:	move.l d4,235a2 <BmpCookieMask+0x2a>
	for (int p = 0; p < img->Bpls; p++)
     76c:	subq.l #7,d1
     76e:	beq.s 77e <main+0x70a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     770:	add.l d2,d0
     772:	addi.l #98890,d0
     778:	move.l d0,235a6 <BmpCookieMask+0x2e>
	ActiView = GfxBase->ActiView; //store current view
     77e:	movea.l 2374e <GfxBase>,a6
     784:	move.l 34(a6),23560 <ActiView>
	OwnBlitter();
     78c:	jsr -456(a6)
	WaitBlit();
     790:	movea.l 2374e <GfxBase>,a6
     796:	jsr -228(a6)
	Disable();
     79a:	movea.l 23752 <SysBase>,a6
     7a0:	jsr -120(a6)
	SystemADKCON = custom->adkconr;
     7a4:	movea.l 23758 <custom>,a2
     7aa:	move.w 16(a2),d0
     7ae:	move.w d0,23564 <SystemADKCON>
	SystemInts = custom->intenar;
     7b4:	move.w 28(a2),d0
     7b8:	move.w d0,23568 <SystemInts>
	SystemDMA = custom->dmaconr;
     7be:	move.w 2(a2),d0
     7c2:	move.w d0,23566 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     7c8:	move.w #32767,154(a2)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     7ce:	move.w #32767,156(a2)
	WaitVbl();
     7d4:	jsr 205a <WaitVbl>
	WaitVbl();
     7da:	jsr 205a <WaitVbl>
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
     800:	movea.l 2374e <GfxBase>,a6
     806:	suba.l a1,a1
     808:	jsr -222(a6)
	WaitTOF();
     80c:	movea.l 2374e <GfxBase>,a6
     812:	jsr -270(a6)
	WaitTOF();
     816:	movea.l 2374e <GfxBase>,a6
     81c:	jsr -270(a6)
	WaitVbl();
     820:	jsr 205a <WaitVbl>
	WaitVbl();
     826:	jsr 205a <WaitVbl>
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     82c:	move.w #20090,188(sp)
     832:	move.w #2049,190(sp)
     838:	move.w #20083,192(sp)
	if (SysBase->AttnFlags & AFF_68010)
     83e:	movea.l 23752 <SysBase>,a6
     844:	btst #0,297(a6)
     84a:	beq.w 1ff8 <main+0x1f84>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     84e:	move.l sp,d7
     850:	addi.l #188,d7
     856:	exg d7,a5
     858:	jsr -30(a6)
     85c:	exg d7,a5
	VBR = GetVBR();
     85e:	move.l d0,2356e <VBR>
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     864:	movea.l 2356e <VBR>,a0
     86a:	move.l 108(a0),d0
	SystemIrq = GetInterruptHandler(); //store interrupt register
     86e:	move.l d0,2356a <SystemIrq>
	WaitVbl();
     874:	jsr 205a <WaitVbl>
	SetupCopper(copPtr);
     87a:	movea.l 23572 <copPtr>,a3
	*copPtr++ = DIWSTRT;
     880:	move.w #142,(a3)
	*copPtr++ = 0x2c81;
     884:	move.w #11393,2(a3)
	*copPtr++ = DIWSTOP;
     88a:	move.w #144,4(a3)
	*copPtr++ = 0x2cc1;
     890:	move.w #11457,6(a3)
	*copPtr++ = DDFSTRT;
     896:	move.w #146,8(a3)
	*copPtr++ = 0x38; // + ((Screen.Width - BmpLogo.Width) / 4);
     89c:	move.w #56,10(a3)
	*copPtr++ = DDFSTOP;
     8a2:	move.w #148,12(a3)
	*copPtr++ = 0xd0; // - ((Screen.Width - BmpLogo.Width) / 4);
     8a8:	move.w #208,14(a3)
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl);
     8ae:	move.w 236b6 <BmpUpperPart_PF1+0x6>,d4
     8b4:	move.w 236b8 <BmpUpperPart_PF1+0x8>,d0
     8ba:	sub.w d4,d0
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     8bc:	move.w #264,16(a3)
    *copListEnd++ = modOdd;
     8c2:	move.w d0,18(a3)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     8c6:	move.w #266,20(a3)
    *copListEnd++ = modEven;
     8cc:	move.w d0,22(a3)
	*copPtr++ = BPLCON1; //scrolling
     8d0:	move.w #258,24(a3)
	*copPtr++ = 0;
     8d6:	clr.w 26(a3)
	*copPtr++ = BPLCON2; //playfied priority
     8da:	move.w #260,28(a3)
	*copPtr++ = 1 << 6;	 //0x24;  Sprites have priority over playfields
     8e0:	move.w #64,30(a3)
    *copListEnd++ = COP_SKIP;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     8e6:	move.w #384,32(a3)
    *copListCurrent++ = color;
     8ec:	move.w #21,34(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     8f2:	move.w #398,36(a3)
    *copListCurrent++ = color;
     8f8:	move.w #21,38(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     8fe:	move.w #386,40(a3)
    *copListCurrent++ = color;
     904:	move.w #1366,42(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     90a:	move.w #388,44(a3)
    *copListCurrent++ = color;
     910:	move.w #3221,46(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     916:	move.w #390,48(a3)
    *copListCurrent++ = color;
     91c:	move.w #3750,50(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     922:	move.w #392,52(a3)
    *copListCurrent++ = color;
     928:	move.w #1074,54(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     92e:	move.w #394,56(a3)
    *copListCurrent++ = color;
     934:	move.w #1329,58(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     93a:	move.w #396,60(a3)
    *copListCurrent++ = color;
     940:	move.w #530,62(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     946:	move.w #398,64(a3)
    *copListCurrent++ = color;
     94c:	move.w #2177,66(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     952:	move.w #400,68(a3)
    *copListCurrent++ = color;
     958:	clr.w 70(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     95c:	move.w #402,72(a3)
    *copListCurrent++ = color;
     962:	move.w #102,74(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     968:	move.w #404,76(a3)
    *copListCurrent++ = color;
     96e:	move.w #119,78(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     974:	move.w #406,80(a3)
    *copListCurrent++ = color;
     97a:	move.w #136,82(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     980:	move.w #408,84(a3)
    *copListCurrent++ = color;
     986:	move.w #169,86(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     98c:	move.w #410,88(a3)
    *copListCurrent++ = color;
     992:	move.w #187,90(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     998:	move.w #412,92(a3)
    *copListCurrent++ = color;
     99e:	move.w #204,94(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     9a4:	move.w #414,96(a3)
    *copListCurrent++ = color;
     9aa:	lea 100(a3),a0
     9ae:	move.w #221,98(a3)
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
     9b4:	move.w 236b4 <BmpUpperPart_PF1+0x4>,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     9ba:	move.l 236be <BmpUpperPart_PF1+0xe>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     9c0:	tst.w d5
     9c2:	beq.s a12 <main+0x99e>
        addr += Bpl;
     9c4:	andi.l #65535,d4
     9ca:	move.w d5,d0
     9cc:	subq.w #1,d0
     9ce:	andi.l #65535,d0
     9d4:	lsl.l #3,d0
     9d6:	lea (108,a3,d0.l),a2
    *copListCurrent++ = color;
     9da:	movea.l a0,a1
    BYTE plane = odd ? 1 : 0;
     9dc:	clr.b d2
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     9de:	move.b d2,d0
     9e0:	ext.w d0
     9e2:	lsl.w #2,d0
     9e4:	addi.w #224,d0
     9e8:	move.w d0,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     9ea:	move.l d1,d3
     9ec:	clr.w d3
     9ee:	swap d3
     9f0:	move.w d3,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     9f4:	addq.w #2,d0
     9f6:	move.w d0,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     9fa:	addq.l #8,a1
     9fc:	move.w d1,-2(a1)
        addr += Bpl;
     a00:	add.l d4,d1
        plane += 2;
     a02:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     a04:	cmpa.l a2,a1
     a06:	bne.s 9de <main+0x96a>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     a08:	andi.l #65535,d5
     a0e:	lsl.l #3,d5
     a10:	adda.l d5,a0
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
     a12:	move.w 23682 <BmpUpperPart_PF2+0x6>,d4
     a18:	move.w 23680 <BmpUpperPart_PF2+0x4>,d0
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     a1e:	move.l 2368a <BmpUpperPart_PF2+0xe>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     a24:	tst.w d0
     a26:	beq.s a66 <main+0x9f2>
        addr += Bpl;
     a28:	andi.l #65535,d4
     a2e:	andi.l #65535,d0
     a34:	lsl.l #3,d0
     a36:	lea (0,a0,d0.l),a1
    BYTE plane = odd ? 1 : 0;
     a3a:	moveq #1,d2
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     a3c:	move.b d2,d0
     a3e:	ext.w d0
     a40:	lsl.w #2,d0
     a42:	addi.w #224,d0
     a46:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     a48:	move.l d1,d3
     a4a:	clr.w d3
     a4c:	swap d3
     a4e:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     a52:	addq.w #2,d0
     a54:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     a58:	addq.l #8,a0
     a5a:	move.w d1,-2(a0)
        addr += Bpl;
     a5e:	add.l d4,d1
        plane += 2;
     a60:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     a62:	cmpa.l a1,a0
     a64:	bne.s a3c <main+0x9c8>
	*copPtr++ = BPLCON0;
     a66:	move.w #256,(a0)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     a6a:	moveq #0,d7
     a6c:	move.w 236e8 <BmpLogo+0x4>,d7
     a72:	move.l d7,d0
     a74:	moveq #13,d1
     a76:	lsl.l d1,d0
     a78:	ori.w #1536,d0
     a7c:	move.w d0,2(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     a80:	move.w #7173,4(a0)
    *copListEnd++ = COP_WAIT;
     a86:	move.w #-2,6(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     a8c:	move.w #384,8(a0)
    *copListCurrent++ = color;
     a92:	move.w #21,10(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     a98:	move.w #398,12(a0)
    *copListCurrent++ = color;
     a9e:	move.w #21,14(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     aa4:	move.w #7429,16(a0)
    *copListEnd++ = COP_WAIT;
     aaa:	move.w #-2,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ab0:	move.w #384,20(a0)
    *copListCurrent++ = color;
     ab6:	move.w #22,22(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     abc:	move.w #398,24(a0)
    *copListCurrent++ = color;
     ac2:	move.w #22,26(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     ac8:	move.w #7685,28(a0)
    *copListEnd++ = COP_WAIT;
     ace:	move.w #-2,30(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ad4:	move.w #384,32(a0)
    *copListCurrent++ = color;
     ada:	move.w #22,34(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ae0:	move.w #398,36(a0)
    *copListCurrent++ = color;
     ae6:	move.w #22,38(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     aec:	move.w #7941,40(a0)
    *copListEnd++ = COP_WAIT;
     af2:	move.w #-2,42(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     af8:	move.w #384,44(a0)
    *copListCurrent++ = color;
     afe:	move.w #22,46(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b04:	move.w #398,48(a0)
    *copListCurrent++ = color;
     b0a:	move.w #22,50(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     b10:	move.w #8197,52(a0)
    *copListEnd++ = COP_WAIT;
     b16:	move.w #-2,54(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b1c:	move.w #384,56(a0)
    *copListCurrent++ = color;
     b22:	move.w #38,58(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b28:	move.w #398,60(a0)
    *copListCurrent++ = color;
     b2e:	move.w #38,62(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     b34:	move.w #8453,64(a0)
    *copListEnd++ = COP_WAIT;
     b3a:	move.w #-2,66(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b40:	move.w #384,68(a0)
    *copListCurrent++ = color;
     b46:	move.w #39,70(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b4c:	move.w #398,72(a0)
    *copListCurrent++ = color;
     b52:	move.w #39,74(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     b58:	move.w #8709,76(a0)
    *copListEnd++ = COP_WAIT;
     b5e:	move.w #-2,78(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b64:	move.w #384,80(a0)
    *copListCurrent++ = color;
     b6a:	move.w #39,82(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b70:	move.w #398,84(a0)
    *copListCurrent++ = color;
     b76:	move.w #39,86(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     b7c:	move.w #8965,88(a0)
    *copListEnd++ = COP_WAIT;
     b82:	move.w #-2,90(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b88:	move.w #384,92(a0)
    *copListCurrent++ = color;
     b8e:	move.w #21,94(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     b94:	move.w #398,96(a0)
    *copListCurrent++ = color;
     b9a:	move.w #21,98(a0)
	line = 0x2c + BmpUpperPart_PF1.Height;
     ba0:	move.b 236b3 <BmpUpperPart_PF1+0x3>,d2
     ba6:	move.b d2,d0
     ba8:	addi.b #44,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     bac:	lsl.w #8,d0
     bae:	ori.w #5,d0
     bb2:	move.w d0,100(a0)
    *copListEnd++ = COP_WAIT;
     bb6:	move.w #-2,102(a0)
	*copPtr++ = BPLCON0;
     bbc:	move.w #256,104(a0)
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     bc2:	move.w #512,106(a0)
	copPtr = copWaitY(copPtr, line++);
     bc8:	move.b d2,d3
     bca:	addi.b #53,d3
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
     bce:	move.b d2,d0
     bd0:	addi.b #52,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     bd4:	lsl.w #8,d0
     bd6:	ori.w #5,d0
     bda:	move.w d0,108(a0)
    *copListEnd++ = COP_WAIT;
     bde:	lea 112(a0),a2
     be2:	move.w #-2,110(a0)
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     be8:	move.l a2,2355a <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     bee:	move.w 2361a <BmpScroller+0x6>,d5
     bf4:	move.w 23618 <BmpScroller+0x4>,d6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     bfa:	move.l 23622 <BmpScroller+0xe>,d0
    for (USHORT i = 0; i < numPlanes; i++)
     c00:	tst.w d6
     c02:	beq.s c4e <main+0xbda>
        addr += Bpl;
     c04:	andi.l #65535,d5
     c0a:	move.w d6,d1
     c0c:	subq.w #1,d1
     c0e:	andi.l #65535,d1
     c14:	moveq #15,d4
     c16:	add.l d4,d1
     c18:	lsl.l #3,d1
     c1a:	adda.l d1,a0
     c1c:	movea.l a2,a1
     c1e:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     c22:	move.w d1,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     c24:	move.l d0,d4
     c26:	clr.w d4
     c28:	swap d4
     c2a:	move.w d4,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     c2e:	move.w d1,d4
     c30:	addq.w #2,d4
     c32:	move.w d4,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     c36:	addq.l #8,a1
     c38:	move.w d0,-2(a1)
        addr += Bpl;
     c3c:	add.l d5,d0
    for (USHORT i = 0; i < numPlanes; i++)
     c3e:	addq.w #4,d1
     c40:	cmpa.l a0,a1
     c42:	bne.s c22 <main+0xbae>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     c44:	andi.l #65535,d6
     c4a:	lsl.l #3,d6
     c4c:	adda.l d6,a2
						  BmpScroller.Bplt - Screen.Bpl);
     c4e:	move.w 2361c <BmpScroller+0x8>,d0
     c54:	sub.w 2371e <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     c5a:	move.w #264,(a2)
    *copListEnd++ = modOdd;
     c5e:	move.w d0,2(a2)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     c62:	move.w #266,4(a2)
    *copListEnd++ = modEven;
     c68:	move.w d0,6(a2)
	*copPtr++ = BPLCON0;
     c6c:	move.w #256,8(a2)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     c72:	moveq #12,d0
     c74:	lsl.l d0,d7
     c76:	ori.w #512,d7
     c7a:	move.w d7,10(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c7e:	move.w #386,12(a2)
    *copListCurrent++ = color;
     c84:	move.w #2288,14(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c8a:	move.w #388,16(a2)
    *copListCurrent++ = color;
     c90:	move.w #1776,18(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c96:	move.w #390,20(a2)
    *copListCurrent++ = color;
     c9c:	move.w #1008,22(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ca2:	move.w #392,24(a2)
    *copListCurrent++ = color;
     ca8:	move.w #496,26(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     cae:	move.w #394,28(a2)
    *copListCurrent++ = color;
     cb4:	move.w #241,30(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     cba:	move.w #396,32(a2)
    *copListCurrent++ = color;
     cc0:	move.w #244,34(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     cc6:	move.w #398,36(a2)
    *copListCurrent++ = color;
     ccc:	lea 40(a2),a0
     cd0:	move.w #246,38(a2)
	for (int l = 0; l < 24; l++)
     cd6:	lea 3ed8 <colgradbluePaletteRGB4>,a1
     cdc:	move.w a1,d1
     cde:	sub.b d1,d3
		copPtr = copWaitY(copPtr, line);
     ce0:	move.w a1,d0
     ce2:	add.b d3,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     ce4:	lsl.w #8,d0
     ce6:	ori.w #5,d0
     cea:	move.w d0,(a0)
    *copListEnd++ = COP_WAIT;
     cec:	move.w #-2,2(a0)
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     cf2:	move.w (a1)+,d0
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     cf4:	move.w #384,4(a0)
    *copListCurrent++ = color;
     cfa:	addq.l #8,a0
     cfc:	move.w d0,-2(a0)
	for (int l = 0; l < 24; l++)
     d00:	cmpa.l #16136,a1
     d06:	bne.s ce0 <main+0xc6c>
		line += 2;
     d08:	move.b d2,d0
     d0a:	addi.b #101,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     d0e:	lsl.w #8,d0
     d10:	ori.w #5,d0
     d14:	move.w d0,232(a2)
    *copListEnd++ = COP_WAIT;
     d18:	move.w #-2,234(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     d1e:	move.w #384,236(a2)
    *copListCurrent++ = color;
     d24:	move.w #4095,238(a2)
	copPtr = copWaitY(copPtr, line++);
     d2a:	move.b d2,d0
     d2c:	addi.b #102,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     d30:	lsl.w #8,d0
     d32:	ori.w #5,d0
     d36:	move.w d0,240(a2)
    *copListEnd++ = COP_WAIT;
     d3a:	move.w #-2,242(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     d40:	move.w #384,244(a2)
    *copListCurrent++ = color;
     d46:	move.w #1179,246(a2)
	copPtr = copWaitY(copPtr, line++);
     d4c:	move.b d2,d0
     d4e:	addi.b #103,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     d52:	lsl.w #8,d0
     d54:	ori.w #5,d0
     d58:	move.w d0,248(a2)
    *copListEnd++ = COP_WAIT;
     d5c:	move.w #-2,250(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     d62:	move.w #384,252(a2)
    *copListCurrent++ = color;
     d68:	move.w #4095,254(a2)
	copPtr = copWaitY(copPtr, line++);
     d6e:	move.b d2,d0
     d70:	addi.b #104,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     d74:	lsl.w #8,d0
     d76:	ori.w #5,d0
     d7a:	move.w d0,256(a2)
    *copListEnd++ = COP_WAIT;
     d7e:	move.w #-2,258(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     d84:	move.w #384,260(a2)
    *copListCurrent++ = color;
     d8a:	move.w #1179,262(a2)
	line += 3;
     d90:	move.b d2,d0
     d92:	addi.b #108,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     d96:	lsl.w #8,d0
     d98:	ori.w #5,d0
     d9c:	move.w d0,264(a2)
    *copListEnd++ = COP_WAIT;
     da0:	move.w #-2,266(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     da6:	move.w #384,268(a2)
    *copListCurrent++ = color;
     dac:	move.w #4095,270(a2)
	copPtr = copWaitY(copPtr, line++);
     db2:	move.b d2,d0
     db4:	addi.b #109,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     db8:	lsl.w #8,d0
     dba:	ori.w #5,d0
     dbe:	move.w d0,272(a2)
    *copListEnd++ = COP_WAIT;
     dc2:	move.w #-2,274(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     dc8:	move.w #384,276(a2)
    *copListCurrent++ = color;
     dce:	move.w #1179,278(a2)
	line += 5;
     dd4:	move.b d2,d0
     dd6:	addi.b #115,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     dda:	lsl.w #8,d0
     ddc:	ori.w #5,d0
     de0:	move.w d0,280(a2)
    *copListEnd++ = COP_WAIT;
     de4:	move.w #-2,282(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     dea:	move.w #384,284(a2)
    *copListCurrent++ = color;
     df0:	move.w #4095,286(a2)
	copPtr = copWaitY(copPtr, line++);
     df6:	move.b d2,d0
     df8:	addi.b #116,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     dfc:	lsl.w #8,d0
     dfe:	ori.w #5,d0
     e02:	move.w d0,288(a2)
    *copListEnd++ = COP_WAIT;
     e06:	move.w #-2,290(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e0c:	move.w #384,292(a2)
    *copListCurrent++ = color;
     e12:	move.w #1179,294(a2)
	line += 5;
     e18:	move.b d2,d0
     e1a:	addi.b #122,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     e1e:	lsl.w #8,d0
     e20:	ori.w #5,d0
     e24:	move.w d0,296(a2)
    *copListEnd++ = COP_WAIT;
     e28:	move.w #-2,298(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e2e:	move.w #384,300(a2)
    *copListCurrent++ = color;
     e34:	move.w #4095,302(a2)
	copPtr = copWaitY(copPtr, line++);
     e3a:	addi.b #123,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     e3e:	lsl.w #8,d2
     e40:	ori.w #5,d2
     e44:	move.w d2,304(a2)
    *copListEnd++ = COP_WAIT;
     e48:	move.w #-2,306(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e4e:	move.w #384,308(a2)
    *copListCurrent++ = color;
     e54:	move.w #1179,310(a2)
	line = 0x2c + BmpLogo.Height + 64 + 8; // 246
     e5a:	move.b 236e7 <BmpLogo+0x3>,d0
     e60:	addi.b #116,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     e64:	lsl.w #8,d0
     e66:	ori.w #5,d0
     e6a:	move.w d0,312(a2)
    *copListEnd++ = COP_WAIT;
     e6e:	move.w #-2,314(a2)
     e74:	lea 316(a2),a0
     e78:	move.l a0,23550 <copMirrorBmpP>
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     e7e:	move.w 236ec <BmpLogo+0x8>,d0
     e84:	sub.w 236ea <BmpLogo+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     e8a:	move.w #264,316(a2)
    *copListEnd++ = modOdd;
     e90:	move.w d0,318(a2)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     e94:	move.w #266,320(a2)
    *copListEnd++ = modEven;
     e9a:	move.w d0,322(a2)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     e9e:	move.w #-31,324(a2)
    *copListEnd++ = COP_WAIT;
     ea4:	move.w #-2,326(a2)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     eaa:	move.w #4101,328(a2)
    *copListEnd++ = COP_WAIT;
     eb0:	move.w #-2,330(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     eb6:	move.w #384,332(a2)
    *copListCurrent++ = color;
     ebc:	move.w #4095,334(a2)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     ec2:	move.w #4357,336(a2)
    *copListEnd++ = COP_WAIT;
     ec8:	move.w #-2,338(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ece:	move.w #384,340(a2)
    *copListCurrent++ = color;
     ed4:	move.w #1179,342(a2)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     eda:	move.w #8197,344(a2)
    *copListEnd++ = COP_WAIT;
     ee0:	move.w #-2,346(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ee6:	move.w #384,348(a2)
    *copListCurrent++ = color;
     eec:	move.w #4095,350(a2)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     ef2:	move.w #8453,352(a2)
    *copListEnd++ = COP_WAIT;
     ef8:	move.w #-2,354(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     efe:	move.w #384,356(a2)
    *copListCurrent++ = color;
     f04:	move.w #1179,358(a2)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     f0a:	move.w #11269,360(a2)
    *copListEnd++ = COP_WAIT;
     f10:	move.w #-2,362(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     f16:	move.w #384,364(a2)
    *copListCurrent++ = color;
     f1c:	move.w #4095,366(a2)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     f22:	move.w #11525,368(a2)
    *copListEnd++ = COP_WAIT;
     f28:	move.w #-2,370(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     f2e:	move.w #384,372(a2)
    *copListCurrent++ = color;
     f34:	move.w #1179,374(a2)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     f3a:	move.w #-1,376(a2)
    *copListEnd++ = COP_WAIT;
     f40:	move.w #-2,378(a2)
	custom->cop1lc = (ULONG)copPtr;
     f46:	movea.l 23758 <custom>,a0
     f4c:	move.l a3,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
     f50:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
     f56:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG;
     f5c:	move.w #-30784,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     f62:	movea.l 2356e <VBR>,a1
     f68:	move.l #8216,108(a1)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
     f70:	move.w #-16352,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
     f76:	move.w #32,156(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
     f7c:	move.w #-24576,154(a0)
	register volatile const void *_a0 ASM("a0") = module;
     f82:	lea 1fa4c <incbin_module_start>,a0
	register volatile const void *_a1 ASM("a1") = NULL;
     f88:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
     f8a:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
     f8c:	lea 2516 <incbin_P61_Player_start>,a3
	__asm volatile(
     f92:	movem.l d1-d7/a4-a6,-(sp)
     f96:	jsr (a3)
     f98:	movem.l (sp)+,d1-d7/a4-a6
	if (p61Init(module) != 0)
     f9c:	tst.l d0
     f9e:	bne.w 1f80 <main+0x1f0c>
	short incX[6] = {3, 3, 3, 3, 3, 3};
     fa2:	move.w #3,184(sp)
	short incY[6] = {1, 1, 1, 1, 1, 1};
     fa8:	move.w #1,196(sp)
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
     fae:	move.w 236e8 <BmpLogo+0x4>,d2
     fb4:	movea.w 236ea <BmpLogo+0x6>,a1
     fba:	move.l 236f2 <BmpLogo+0xe>,d3
     fc0:	movea.w 236b6 <BmpUpperPart_PF1+0x6>,a0
     fc6:	move.l 236be <BmpUpperPart_PF1+0xe>,d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     fcc:	movea.l 23758 <custom>,a4
     fd2:	move.w 2(a4),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     fd6:	move.w 2(a4),d0
     fda:	btst #14,d0
     fde:	bne.s fd6 <main+0xf62>
	custom->bltcon0 = 0x09f0;
     fe0:	move.w #2544,64(a4)
	custom->bltcon1 = 0x0000;
     fe6:	move.w #0,66(a4)
	custom->bltafwm = 0xffff;
     fec:	move.w #-1,68(a4)
	custom->bltalwm = 0xffff;
     ff2:	move.w #-1,70(a4)
	custom->bltamod = imgA.Bpl - (width / 8);
     ff8:	lea -32(a1),a1
     ffc:	move.w a1,100(a4)
	custom->bltdmod = imgD.Bpl - (width / 8);
    1000:	lea -32(a0),a0
    1004:	move.w a0,102(a4)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1008:	move.l d3,80(a4)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    100c:	addq.l #4,d1
    100e:	move.l d1,84(a4)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
    1012:	move.w d2,d0
    1014:	lsl.w #6,d0
    1016:	add.w d2,d0
    1018:	lsl.w #7,d0
    101a:	addi.w #16,d0
    101e:	move.w d0,88(a4)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    1022:	move.b bfe001 <_end+0xbda8a5>,d0
	while (!MouseLeft())
    1028:	btst #6,d0
    102c:	beq.w 1786 <main+0x1712>
    1030:	move.w 2364c <BmpUpperPart_Buf1+0x4>,88(sp)
    1038:	move.w 2364e <BmpUpperPart_Buf1+0x6>,d5
    103e:	movea.l 23656 <BmpUpperPart_Buf1+0xe>,a6
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
    1044:	move.w 6180 <ScrollerY>,54(sp)
		Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    104c:	move.l 23622 <BmpScroller+0xe>,90(sp)
    1054:	move.w 23618 <BmpScroller+0x4>,98(sp)
	short incY[6] = {1, 1, 1, 1, 1, 1};
    105c:	move.w #1,102(sp)
    1062:	move.w #1,104(sp)
    1068:	move.w #1,100(sp)
    106e:	move.w #1,106(sp)
	short incX[6] = {3, 3, 3, 3, 3, 3};
    1074:	move.w #3,110(sp)
    107a:	move.w #3,108(sp)
    1080:	move.w #3,114(sp)
    1086:	move.w #3,112(sp)
	Point2D pdb[6] = {
    108c:	movea.w #78,a1
    1090:	move.l a1,56(sp)
    1094:	clr.l 72(sp)
    1098:	movea.w #82,a0
    109c:	move.l a0,60(sp)
    10a0:	movea.w #28,a1
    10a4:	move.l a1,76(sp)
    10a8:	movea.w #86,a0
    10ac:	move.l a0,64(sp)
    10b0:	movea.w #56,a1
    10b4:	move.l a1,84(sp)
    10b8:	movea.w #90,a0
    10bc:	move.l a0,68(sp)
    10c0:	movea.w #84,a1
    10c4:	move.l a1,80(sp)
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    10c8:	move.l dff004 <_end+0xddb8a8>,d0
    10ce:	move.l d0,172(sp)
		vpos &= 0x1ff00;
    10d2:	move.l 172(sp),d0
    10d6:	andi.l #130816,d0
    10dc:	move.l d0,172(sp)
		if (vpos != (311 << 8))
    10e0:	move.l 172(sp),d0
    10e4:	cmpi.l #79616,d0
    10ea:	beq.s 10c8 <main+0x1054>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    10ec:	move.l dff004 <_end+0xddb8a8>,d0
    10f2:	move.l d0,168(sp)
		vpos &= 0x1ff00;
    10f6:	move.l 168(sp),d0
    10fa:	andi.l #130816,d0
    1100:	move.l d0,168(sp)
		if (vpos == (311 << 8))
    1104:	move.l 168(sp),d0
    1108:	cmpi.l #79616,d0
    110e:	bne.s 10ec <main+0x1078>
		CopyBitmap(BmpUpperPart_Buf1, BmpUpperPart_PF2);
    1110:	move.w 2364a <BmpUpperPart_Buf1+0x2>,d1
    1116:	movea.l 2368a <BmpUpperPart_PF2+0xe>,a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    111c:	move.w 2(a4),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1120:	move.w 2(a4),d0
    1124:	move.w d0,d2
    1126:	andi.w #16384,d2
    112a:	btst #14,d0
    112e:	bne.s 1120 <main+0x10ac>
	custom->bltcon0 = 0x09f0;
    1130:	move.w #2544,64(a4)
	custom->bltcon1 = 0x0000;
    1136:	move.w #0,66(a4)
	custom->bltapt = (UBYTE *)bmpS.ImageData;
    113c:	move.l a6,80(a4)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
    1140:	move.l a0,84(a4)
	custom->bltafwm = 0xffff;
    1144:	move.w #-1,68(a4)
	custom->bltalwm = 0xffff;
    114a:	move.w #-1,70(a4)
	custom->bltamod = 0;
    1150:	move.w #0,100(a4)
	custom->bltdmod = 0;
    1156:	move.w #0,102(a4)
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
    115c:	move.w 88(sp),d0
    1160:	muls.w d1,d0
    1162:	lsl.w #6,d0
    1164:	lsr.w #1,d5
    1166:	add.w d0,d5
    1168:	move.w d5,88(a4)
			pdb[b].X += incX[b];
    116c:	movea.l 80(sp),a0
    1170:	move.w 112(sp),d3
    1174:	move.w d3,d4
    1176:	ext.l d4
    1178:	lea (0,a0,d4.l),a0
    117c:	move.l a0,80(sp)
			pdb[b].Y += incY[b];
    1180:	movea.l 68(sp),a0
    1184:	move.w 106(sp),d3
    1188:	move.w d3,d4
    118a:	ext.l d4
    118c:	lea (0,a0,d4.l),a0
    1190:	move.l a0,68(sp)
			if (pdb[b].X >= 320 - 32)
    1194:	cmpi.l #287,80(sp)
    119c:	ble.w 1dd4 <main+0x1d60>
				incX[b] *= -1;
    11a0:	neg.w 112(sp)
    11a4:	clr.w 122(sp)
    11a8:	clr.l 50(sp)
    11ac:	moveq #36,d3
    11ae:	move.l d3,124(sp)
    11b2:	move.w #4042,120(sp)
    11b8:	clr.l 152(sp)
				pdb[b].X = 320 - 32;
    11bc:	move.l #288,80(sp)
			if (pdb[b].Y >= 130 - 32)
    11c4:	moveq #97,d0
    11c6:	cmp.l 68(sp),d0
    11ca:	bge.w 1e04 <main+0x1d90>
				incY[b] *= -1;
    11ce:	neg.w 106(sp)
				pdb[b].Y = 130 - 32;
    11d2:	movea.w #98,a0
    11d6:	move.l a0,68(sp)
			pdb[b].X += incX[b];
    11da:	movea.l 84(sp),a1
    11de:	move.w 114(sp),d3
    11e2:	move.w d3,d4
    11e4:	ext.l d4
    11e6:	lea (0,a1,d4.l),a1
    11ea:	move.l a1,84(sp)
			pdb[b].Y += incY[b];
    11ee:	movea.l 64(sp),a0
    11f2:	move.w 100(sp),d3
    11f6:	move.w d3,d4
    11f8:	ext.l d4
    11fa:	lea (0,a0,d4.l),a0
    11fe:	move.l a0,64(sp)
			if (pdb[b].X >= 320 - 32)
    1202:	cmpa.w #287,a1
    1206:	ble.w 1d3e <main+0x1cca>
				incX[b] *= -1;
    120a:	neg.w 114(sp)
    120e:	clr.w 130(sp)
    1212:	moveq #36,d3
    1214:	move.l d3,132(sp)
    1218:	move.w #4042,128(sp)
    121e:	clr.l 156(sp)
    1222:	suba.l a5,a5
				pdb[b].X = 320 - 32;
    1224:	move.l #288,84(sp)
			if (pdb[b].Y >= 130 - 32)
    122c:	moveq #97,d0
    122e:	cmp.l 64(sp),d0
    1232:	bge.w 1d6c <main+0x1cf8>
				incY[b] *= -1;
    1236:	neg.w 100(sp)
				pdb[b].Y = 130 - 32;
    123a:	movea.w #98,a0
    123e:	move.l a0,64(sp)
			pdb[b].X += incX[b];
    1242:	movea.l 76(sp),a1
    1246:	move.w 108(sp),d3
    124a:	move.w d3,d4
    124c:	ext.l d4
    124e:	lea (0,a1,d4.l),a1
    1252:	move.l a1,76(sp)
			pdb[b].Y += incY[b];
    1256:	movea.l 60(sp),a0
    125a:	move.w 104(sp),d3
    125e:	move.w d3,d4
    1260:	ext.l d4
    1262:	lea (0,a0,d4.l),a0
    1266:	move.l a0,60(sp)
			if (pdb[b].X >= 320 - 32)
    126a:	cmpa.w #287,a1
    126e:	ble.w 1dac <main+0x1d38>
				incX[b] *= -1;
    1272:	neg.w 108(sp)
    1276:	clr.w 138(sp)
    127a:	moveq #36,d3
    127c:	move.l d3,140(sp)
    1280:	move.w #4042,136(sp)
    1286:	clr.l 160(sp)
    128a:	moveq #0,d7
				pdb[b].X = 320 - 32;
    128c:	move.l #288,76(sp)
			if (pdb[b].Y >= 130 - 32)
    1294:	moveq #97,d4
    1296:	cmp.l 60(sp),d4
    129a:	bge.w 1d2a <main+0x1cb6>
				incY[b] *= -1;
    129e:	neg.w 104(sp)
				pdb[b].Y = 130 - 32;
    12a2:	movea.w #98,a0
    12a6:	move.l a0,60(sp)
			pdb[b].X += incX[b];
    12aa:	movea.l 72(sp),a1
    12ae:	move.w 110(sp),d3
    12b2:	move.w d3,d4
    12b4:	ext.l d4
    12b6:	lea (0,a1,d4.l),a1
    12ba:	move.l a1,72(sp)
			pdb[b].Y += incY[b];
    12be:	movea.l 56(sp),a0
    12c2:	move.w 102(sp),d3
    12c6:	move.w d3,d4
    12c8:	ext.l d4
    12ca:	lea (0,a0,d4.l),a0
    12ce:	move.l a0,56(sp)
			if (pdb[b].X >= 320 - 32)
    12d2:	cmpa.w #287,a1
    12d6:	ble.w 1d00 <main+0x1c8c>
				incX[b] *= -1;
    12da:	neg.w 110(sp)
    12de:	clr.w 146(sp)
    12e2:	moveq #36,d3
    12e4:	move.l d3,148(sp)
    12e8:	move.w #4042,144(sp)
    12ee:	clr.l 164(sp)
    12f2:	clr.l 94(sp)
				pdb[b].X = 320 - 32;
    12f6:	move.l #288,72(sp)
			if (pdb[b].Y >= 130 - 32)
    12fe:	moveq #97,d0
    1300:	cmp.l 56(sp),d0
    1304:	bge.w 1cec <main+0x1c78>
				incY[b] *= -1;
    1308:	neg.w 102(sp)
				pdb[b].Y = 130 - 32;
    130c:	movea.w #98,a0
    1310:	move.l a0,56(sp)
		if (BounceEnabled)
    1314:	tst.w 2355e <BounceEnabled>
    131a:	beq.s 135a <main+0x12e6>
			if (ScrollerDir > 0)
    131c:	move.b 6182 <ScrollerDir>,d0
    1322:	ble.w 1e18 <main+0x1da4>
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
    1326:	pea c <_start+0xc>
    132a:	movea.w #40,a1
    132e:	suba.w 58(sp),a1
    1332:	move.l a1,-(sp)
    1334:	jsr 23b6 <__divsi3>
    133a:	addq.l #8,sp
				if (ScrollerDir > 6)
    133c:	cmpi.b #6,d0
    1340:	ble.w 1e3a <main+0x1dc6>
					ScrollerDir = 6;
    1344:	move.b #6,6182 <ScrollerDir>
    134c:	moveq #6,d0
			ScrollerY += ScrollerDir;
    134e:	add.w d0,54(sp)
    1352:	move.w 54(sp),6180 <ScrollerY>
		if (ScrollerY >= ScrollerMax)
    135a:	movea.w 54(sp),a0
    135e:	cmpi.w #39,54(sp)
    1364:	ble.w 1c4c <main+0x1bd8>
			ScrollerY = ScrollerMax;
    1368:	move.w #40,6180 <ScrollerY>
			ScrollerDir = -1;
    1370:	st 6182 <ScrollerDir>
		Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    1376:	move.w 2361c <BmpScroller+0x8>,d3
	int BltOffs = startY * theDesc.Bplt;
    137c:	move.w d3,d4
    137e:	mulu.w #40,d4
	int Brcorner = height * theDesc.Bplt - 2;
    1382:	andi.l #65535,d3
    1388:	lsl.l #5,d3
    138a:	subq.l #2,d3
	WaitBlit();
    138c:	movea.l 2374e <GfxBase>,a6
    1392:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
    1396:	movea.l 23758 <custom>,a4
    139c:	move.w #18928,64(a4)
	custom->bltcon1 = 0x0002;
    13a2:	move.w #2,66(a4)
	custom->bltafwm = 0xffff;
    13a8:	move.w #-1,68(a4)
	custom->bltalwm = 0xffff;
    13ae:	move.w #-1,70(a4)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
    13b4:	add.l d3,d4
    13b6:	add.l 90(sp),d4
    13ba:	move.l d4,80(a4)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
    13be:	move.l d4,84(a4)
	custom->bltamod = 0;
    13c2:	move.w #0,100(a4)
	custom->bltdmod = 0;
    13c8:	move.w #0,102(a4)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
    13ce:	move.w 98(sp),d1
    13d2:	moveq #11,d0
    13d4:	lsl.w d0,d1
    13d6:	lea 23614 <BmpScroller>,a0
    13dc:	move.w (a0),d0
    13de:	lsr.w #4,d0
    13e0:	add.w d1,d0
    13e2:	move.w d0,88(a4)
	ScrollCnt += speed;
    13e6:	move.w 23558 <ScrollCnt>,d0
    13ec:	addq.w #4,d0
    13ee:	move.w d0,23558 <ScrollCnt>
	if (ScrollCnt >= 32)
    13f4:	cmpi.w #31,d0
    13f8:	bhi.w 18e0 <main+0x186c>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    13fc:	move.w 2361a <BmpScroller+0x6>,d3
    1402:	move.l 23622 <BmpScroller+0xe>,90(sp)
    140a:	move.w 6180 <ScrollerY>,54(sp)
    1412:	move.w 23618 <BmpScroller+0x4>,98(sp)
    141a:	moveq #0,d4
    141c:	move.w 98(sp),d4
    1420:	movea.l 2355a <copScrollerBmpP>,a2
    1426:	andi.l #65535,d3
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    142c:	move.l d3,-(sp)
    142e:	movea.w 58(sp),a0
    1432:	move.l a0,-(sp)
    1434:	jsr 2338 <__mulsi3>
    143a:	addq.l #4,sp
    143c:	move.l d4,(sp)
    143e:	move.l d0,-(sp)
    1440:	jsr 2338 <__mulsi3>
    1446:	addq.l #8,sp
    1448:	add.l 90(sp),d0
        addr += Bpl;
    144c:	move.w #224,d1
    for (USHORT i = 0; i < numPlanes; i++)
    1450:	tst.l d4
    1452:	beq.s 147c <main+0x1408>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
    1454:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    1456:	move.l d0,d5
    1458:	clr.w d5
    145a:	swap d5
    145c:	move.w d5,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
    1460:	movea.w d1,a0
    1462:	addq.w #2,a0
    1464:	move.w a0,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    1468:	addq.l #8,a2
    146a:	move.w d0,-2(a2)
        addr += Bpl;
    146e:	add.l d3,d0
    for (USHORT i = 0; i < numPlanes; i++)
    1470:	addq.w #1,d2
    1472:	addq.w #4,d1
    1474:	moveq #0,d5
    1476:	move.w d2,d5
    1478:	cmp.l d4,d5
    147a:	blt.s 1454 <main+0x13e0>
		ClearBitmap(BmpUpperPart_Buf1, 130);
    147c:	lea 23648 <BmpUpperPart_Buf1>,a1
    1482:	move.w (a1),d1
    1484:	move.w 2364c <BmpUpperPart_Buf1+0x4>,88(sp)
    148c:	movea.l 23656 <BmpUpperPart_Buf1+0xe>,a6
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1492:	move.w 2(a4),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1496:	move.w 2(a4),d0
    149a:	btst #14,d0
    149e:	bne.s 1496 <main+0x1422>
	custom->bltcon0 = 0x0900;
    14a0:	move.w #2304,64(a4)
	custom->bltcon1 = 0x0000;
    14a6:	move.w #0,66(a4)
	custom->bltapt = (UBYTE *)bmpD.ImageData;
    14ac:	move.l a6,80(a4)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
    14b0:	move.l a6,84(a4)
	custom->bltafwm = 0xffff;
    14b4:	move.w #-1,68(a4)
	custom->bltalwm = 0xffff;
    14ba:	move.w #-1,70(a4)
	custom->bltamod = 0;
    14c0:	move.w #0,100(a4)
	custom->bltdmod = 0;
    14c6:	move.w #0,102(a4)
	custom->bltsize = ((lines * bmpD.Bpls) << 6) + (bmpD.Width / 16);
    14cc:	move.w 88(sp),d0
    14d0:	lsl.w #6,d0
    14d2:	add.w 88(sp),d0
    14d6:	lsl.w #7,d0
    14d8:	lsr.w #4,d1
    14da:	add.w d0,d1
    14dc:	move.w d1,88(a4)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, ps2, pdb[0], 32, 32);
    14e0:	move.w 235b0 <BmpCookie+0x4>,116(sp)
    14e8:	move.w 235b2 <BmpCookie+0x6>,d6
    14ee:	movea.l 235ba <BmpCookie+0xe>,a3
    14f4:	move.w 2364e <BmpUpperPart_Buf1+0x6>,d5
    14fa:	move.w 23650 <BmpUpperPart_Buf1+0x8>,d3
    1500:	move.w 2357e <BmpCookieMask+0x6>,d4
    1506:	movea.l 23586 <BmpCookieMask+0xe>,a2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    150c:	move.w 2(a4),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1510:	move.w 2(a4),d0
    1514:	btst #14,d0
    1518:	bne.s 1510 <main+0x149c>
	if (shift)
    151a:	tst.l 50(sp)
    151e:	beq.w 1bb6 <main+0x1b42>
    1522:	move.w #3,118(sp)
    1528:	moveq #6,d2
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    152a:	move.w 120(sp),64(a4)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1530:	move.w 122(sp),66(a4)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1536:	move.l a3,80(a4)
	custom->bltamod = imgS.Bpl - (width / 8);
    153a:	move.w d6,d0
    153c:	sub.w d2,d0
    153e:	move.w d0,100(a4)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1542:	move.l a2,76(a4)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1546:	move.w d4,d0
    1548:	sub.w d2,d0
    154a:	move.w d0,98(a4)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    154e:	andi.l #65535,d3
    1554:	move.l 68(sp),-(sp)
    1558:	move.l d3,-(sp)
    155a:	jsr 2338 <__mulsi3>
    1560:	addq.l #8,sp
    1562:	add.l 124(sp),d0
    1566:	add.l a6,d0
    1568:	move.l d0,84(a4)
    156c:	move.l d0,72(a4)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1570:	move.w d5,d0
    1572:	sub.w d2,d0
    1574:	move.w d0,102(a4)
    1578:	move.w d0,96(a4)
	custom->bltafwm = 0xffff;
    157c:	move.w #-1,68(a4)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1582:	tst.l 50(sp)
    1586:	beq.w 1c1e <main+0x1baa>
    158a:	moveq #15,d1
    158c:	sub.l 152(sp),d1
    1590:	moveq #0,d0
    1592:	not.w d0
    1594:	lsl.l d1,d0
    1596:	move.w d0,70(a4)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    159a:	moveq #0,d2
    159c:	move.w 116(sp),d2
    15a0:	moveq #11,d0
    15a2:	lsl.l d0,d2
    15a4:	move.w 118(sp),d0
    15a8:	or.w d2,d0
    15aa:	move.w d0,88(a4)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    15ae:	move.w 2(a4),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    15b2:	move.w 2(a4),d0
    15b6:	btst #14,d0
    15ba:	bne.s 15b2 <main+0x153e>
	if (shift)
    15bc:	cmpa.w #0,a5
    15c0:	beq.w 1c40 <main+0x1bcc>
    15c4:	move.w #3,50(sp)
    15ca:	moveq #6,d1
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    15cc:	move.w 128(sp),64(a4)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    15d2:	move.w 130(sp),66(a4)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    15d8:	move.l a3,d0
    15da:	addq.l #6,d0
    15dc:	move.l d0,80(a4)
	custom->bltamod = imgS.Bpl - (width / 8);
    15e0:	move.w d6,d0
    15e2:	sub.w d1,d0
    15e4:	move.w d0,100(a4)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    15e8:	move.l a2,d0
    15ea:	addq.l #6,d0
    15ec:	move.l d0,76(a4)
	custom->bltbmod = imgM.Bpl - (width / 8);
    15f0:	move.w d4,d0
    15f2:	sub.w d1,d0
    15f4:	move.w d0,98(a4)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    15f8:	move.l 64(sp),-(sp)
    15fc:	move.l d3,-(sp)
    15fe:	move.l d1,54(sp)
    1602:	jsr 2338 <__mulsi3>
    1608:	addq.l #8,sp
    160a:	add.l 132(sp),d0
    160e:	add.l a6,d0
    1610:	move.l d0,84(a4)
    1614:	move.l d0,72(a4)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1618:	move.l 46(sp),d1
    161c:	move.w d5,d0
    161e:	sub.w d1,d0
    1620:	move.w d0,102(a4)
    1624:	move.w d0,96(a4)
	custom->bltafwm = 0xffff;
    1628:	move.w #-1,68(a4)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    162e:	cmpa.w #0,a5
    1632:	beq.w 1b9e <main+0x1b2a>
    1636:	moveq #15,d1
    1638:	sub.l 156(sp),d1
    163c:	moveq #0,d0
    163e:	not.w d0
    1640:	lsl.l d1,d0
    1642:	move.w d0,70(a4)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1646:	move.w 50(sp),d0
    164a:	or.w d2,d0
    164c:	move.w d0,88(a4)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1650:	move.w 2(a4),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1654:	move.w 2(a4),d0
    1658:	btst #14,d0
    165c:	bne.s 1654 <main+0x15e0>
	if (shift)
    165e:	tst.l d7
    1660:	beq.w 1b90 <main+0x1b1c>
    1664:	move.w #3,50(sp)
    166a:	movea.w #6,a5
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    166e:	move.w 136(sp),64(a4)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1674:	move.w 138(sp),66(a4)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    167a:	lea 12(a3),a0
    167e:	move.l a0,80(a4)
	custom->bltamod = imgS.Bpl - (width / 8);
    1682:	move.w d6,d0
    1684:	sub.w a5,d0
    1686:	move.w d0,100(a4)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    168a:	lea 12(a2),a0
    168e:	move.l a0,76(a4)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1692:	move.w d4,d0
    1694:	sub.w a5,d0
    1696:	move.w d0,98(a4)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    169a:	move.l d3,-(sp)
    169c:	move.l 64(sp),-(sp)
    16a0:	jsr 2338 <__mulsi3>
    16a6:	addq.l #8,sp
    16a8:	add.l 140(sp),d0
    16ac:	add.l a6,d0
    16ae:	move.l d0,84(a4)
    16b2:	move.l d0,72(a4)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    16b6:	move.w d5,d0
    16b8:	sub.w a5,d0
    16ba:	move.w d0,102(a4)
    16be:	move.w d0,96(a4)
	custom->bltafwm = 0xffff;
    16c2:	move.w #-1,68(a4)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    16c8:	tst.l d7
    16ca:	beq.w 1b78 <main+0x1b04>
    16ce:	moveq #15,d1
    16d0:	sub.l 160(sp),d1
    16d4:	moveq #0,d0
    16d6:	not.w d0
    16d8:	lsl.l d1,d0
    16da:	move.w d0,70(a4)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    16de:	move.w 50(sp),d0
    16e2:	or.w d2,d0
    16e4:	move.w d0,88(a4)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    16e8:	move.w 2(a4),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    16ec:	move.w 2(a4),d0
    16f0:	btst #14,d0
    16f4:	bne.s 16ec <main+0x1678>
	if (shift)
    16f6:	tst.l 94(sp)
    16fa:	beq.w 1b6e <main+0x1afa>
    16fe:	moveq #3,d7
    1700:	movea.w #6,a5
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1704:	move.w 144(sp),64(a4)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    170a:	move.w 146(sp),66(a4)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1710:	lea 18(a3),a3
    1714:	move.l a3,80(a4)
	custom->bltamod = imgS.Bpl - (width / 8);
    1718:	sub.w a5,d6
    171a:	move.w d6,100(a4)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    171e:	lea 18(a2),a2
    1722:	move.l a2,76(a4)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1726:	sub.w a5,d4
    1728:	move.w d4,98(a4)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    172c:	move.l d3,-(sp)
    172e:	move.l 60(sp),-(sp)
    1732:	jsr 2338 <__mulsi3>
    1738:	addq.l #8,sp
    173a:	add.l 148(sp),d0
    173e:	add.l a6,d0
    1740:	move.l d0,84(a4)
    1744:	move.l d0,72(a4)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1748:	move.w d5,d0
    174a:	sub.w a5,d0
    174c:	move.w d0,102(a4)
    1750:	move.w d0,96(a4)
	custom->bltafwm = 0xffff;
    1754:	move.w #-1,68(a4)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    175a:	tst.l 94(sp)
    175e:	beq.w 1b2a <main+0x1ab6>
    1762:	moveq #15,d1
    1764:	sub.l 164(sp),d1
    1768:	moveq #0,d0
    176a:	not.w d0
    176c:	lsl.l d1,d0
    176e:	move.w d0,70(a4)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1772:	or.w d7,d2
    1774:	move.w d2,88(a4)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    1778:	move.b bfe001 <_end+0xbda8a5>,d0
	while (!MouseLeft())
    177e:	btst #6,d0
    1782:	bne.w 10c8 <main+0x1054>
	register volatile const void *_a3 ASM("a3") = P61_Player;
    1786:	lea 2516 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    178c:	movea.l #14675968,a6
	__asm volatile(
    1792:	movem.l d0-d1/a0-a1,-(sp)
    1796:	jsr 8(a3)
    179a:	movem.l (sp)+,d0-d1/a0-a1
	FreeMem(copPtr, 1024);
    179e:	movea.l 23752 <SysBase>,a6
    17a4:	movea.l 23572 <copPtr>,a1
    17aa:	move.l #1024,d0
    17b0:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    17b4:	movea.l 23752 <SysBase>,a6
    17ba:	movea.l 23622 <BmpScroller+0xe>,a1
    17c0:	moveq #0,d0
    17c2:	move.w 23620 <BmpScroller+0xc>,d0
    17c8:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    17cc:	movea.l 23752 <SysBase>,a6
    17d2:	movea.l 236be <BmpUpperPart_PF1+0xe>,a1
    17d8:	moveq #0,d0
    17da:	move.w 236bc <BmpUpperPart_PF1+0xc>,d0
    17e0:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    17e4:	movea.l 23752 <SysBase>,a6
    17ea:	movea.l 2368a <BmpUpperPart_PF2+0xe>,a1
    17f0:	moveq #0,d0
    17f2:	move.w 23688 <BmpUpperPart_PF2+0xc>,d0
    17f8:	jsr -210(a6)
	WaitVbl();
    17fc:	jsr 205a <WaitVbl>
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1802:	movea.l 23758 <custom>,a0
    1808:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    180c:	move.w 2(a0),d0
    1810:	btst #14,d0
    1814:	bne.s 180c <main+0x1798>
	custom->intena = 0x7fff; //disable all interrupts
    1816:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
    181c:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
    1822:	move.w #32767,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
    1828:	movea.l 2356e <VBR>,a1
    182e:	move.l 2356a <SystemIrq>,108(a1)
	custom->cop1lc = (ULONG)GfxBase->copinit;
    1836:	movea.l 2374e <GfxBase>,a6
    183c:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
    1842:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
    1848:	move.w #32767,136(a0)
	custom->intena = SystemInts | 0x8000;
    184e:	move.w 23568 <SystemInts>,d0
    1854:	ori.w #-32768,d0
    1858:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
    185c:	move.w 23566 <SystemDMA>,d0
    1862:	ori.w #-32768,d0
    1866:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
    186a:	move.w 23564 <SystemADKCON>,d0
    1870:	ori.w #-32768,d0
    1874:	move.w d0,158(a0)
	LoadView(ActiView);
    1878:	movea.l 23560 <ActiView>,a1
    187e:	jsr -222(a6)
	WaitTOF();
    1882:	movea.l 2374e <GfxBase>,a6
    1888:	jsr -270(a6)
	WaitTOF();
    188c:	movea.l 2374e <GfxBase>,a6
    1892:	jsr -270(a6)
	WaitBlit();
    1896:	movea.l 2374e <GfxBase>,a6
    189c:	jsr -228(a6)
	DisownBlitter();
    18a0:	movea.l 2374e <GfxBase>,a6
    18a6:	jsr -462(a6)
	Enable();
    18aa:	movea.l 23752 <SysBase>,a6
    18b0:	jsr -126(a6)
	CloseLibrary((struct Library *)DOSBase);
    18b4:	movea.l 23752 <SysBase>,a6
    18ba:	movea.l 2374a <DOSBase>,a1
    18c0:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    18c4:	movea.l 23752 <SysBase>,a6
    18ca:	movea.l 2374e <GfxBase>,a1
    18d0:	jsr -414(a6)
}
    18d4:	moveq #0,d0
    18d6:	movem.l (sp)+,d2-d7/a2-a6
    18da:	lea 156(sp),sp
    18de:	rts
		ScrollCnt = 0;
    18e0:	clr.w 23558 <ScrollCnt>
		PlotChar(BmpFont32, (UBYTE *)BmpFont32P, BmpScroller, (UBYTE *)BmpScroller.ImageData, startY, 32, 32);
    18e6:	move.l 23622 <BmpScroller+0xe>,90(sp)
    18ee:	movea.w 235e4 <BmpFont32+0x4>,a2
    18f4:	move.w 235e6 <BmpFont32+0x6>,d6
    18fa:	movea.w 235e8 <BmpFont32+0x8>,a3
    1900:	move.w 2361a <BmpScroller+0x6>,d3
    1906:	move.w 2361c <BmpScroller+0x8>,d4
	UBYTE chr = Scrolltext[ScrolltextCnt++];
    190c:	movea.w 23556 <ScrolltextCnt>,a0
    1912:	move.w a0,d0
    1914:	addq.w #1,d0
    1916:	move.w d0,23556 <ScrolltextCnt>
    191c:	moveq #0,d1
    191e:	move.w a0,d1
    1920:	lea 3f28 <Scrolltext>,a1
    1926:	move.b (0,a1,d1.l),d1
	if (chr == 'b')
    192a:	cmpi.b #98,d1
    192e:	beq.w 1ae0 <main+0x1a6c>
	if (chr == 'm')
    1932:	cmpi.b #109,d1
    1936:	beq.w 19d4 <main+0x1960>
	if (chr == 0)
    193a:	tst.b d1
    193c:	bne.w 1a2e <main+0x19ba>
		chr = Scrolltext[ScrolltextCnt++];
    1940:	move.w #1,23556 <ScrolltextCnt>
    1948:	suba.l a4,a4
    194a:	moveq #4,d5
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    194c:	move.l d5,-(sp)
    194e:	move.w a3,-(sp)
    1950:	clr.w -(sp)
    1952:	jsr 2338 <__mulsi3>
    1958:	addq.l #8,sp
    195a:	move.l d0,d5
    195c:	lsl.l #5,d5
    195e:	add.l a4,d5
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    1960:	mulu.w #40,d4
    1964:	moveq #0,d0
    1966:	move.w 2371e <Screen+0x6>,d0
    196c:	add.l d0,d4
	WaitBlit();
    196e:	movea.l 2374e <GfxBase>,a6
    1974:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    1978:	movea.l 23758 <custom>,a4
    197e:	move.w #2544,64(a4)
	custom->bltcon1 = 0x0000;
    1984:	move.w #0,66(a4)
	custom->bltafwm = 0xffff;
    198a:	move.w #-1,68(a4)
	custom->bltalwm = 0xffff;
    1990:	move.w #-1,70(a4)
	custom->bltapt = bmpFontP + source;
    1996:	addi.l #37446,d5
    199c:	move.l d5,80(a4)
	custom->bltdpt = bmpDestP + dest;
    19a0:	add.l 90(sp),d4
    19a4:	move.l d4,84(a4)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    19a8:	subq.w #4,d6
    19aa:	move.w d6,100(a4)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    19ae:	subq.w #4,d3
    19b0:	move.w d3,102(a4)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    19b4:	move.w a2,d3
    19b6:	moveq #11,d4
    19b8:	lsl.w d4,d3
    19ba:	movea.w d3,a2
    19bc:	addq.w #2,a2
    19be:	move.w a2,88(a4)
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    19c2:	move.w 2361a <BmpScroller+0x6>,d3
    19c8:	move.l 23622 <BmpScroller+0xe>,90(sp)
    19d0:	bra.w 140a <main+0x1396>
		if (MirrorEnabled)
    19d4:	move.w 23554 <MirrorEnabled>,d1
				 BmpScroller.Bplt - Screen.Bpl);
    19da:	movea.w d4,a1
    19dc:	suba.w 2371e <Screen+0x6>,a1
	copSetBplMod(0, copMirrorBmpP,
    19e2:	movea.l 23550 <copMirrorBmpP>,a0
		if (MirrorEnabled)
    19e8:	tst.w d1
    19ea:	beq.w 1f3c <main+0x1ec8>
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    19ee:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    19f2:	move.w a1,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    19f6:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    19fc:	move.w a1,6(a0)
		MirrorEnabled = !MirrorEnabled;
    1a00:	tst.w d1
    1a02:	seq d1
    1a04:	ext.w d1
    1a06:	neg.w d1
    1a08:	move.w d1,23554 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    1a0e:	move.w d0,d1
    1a10:	addq.w #1,d1
    1a12:	move.w d1,23556 <ScrolltextCnt>
    1a18:	andi.l #65535,d0
    1a1e:	lea 3f28 <Scrolltext>,a0
    1a24:	move.b (0,a0,d0.l),d1
	if (chr == 0)
    1a28:	tst.b d1
    1a2a:	beq.w 1940 <main+0x18cc>
	if (chr < 32 || chr > (32 + 80))
    1a2e:	addi.b #-32,d1
    1a32:	cmpi.b #80,d1
    1a36:	bhi.w 140a <main+0x1396>
	row = chr / 10;
    1a3a:	clr.w d0
    1a3c:	move.b d1,d0
    1a3e:	move.w d0,d1
    1a40:	mulu.w #-13107,d1
    1a44:	clr.w d1
    1a46:	swap d1
    1a48:	lsr.w #3,d1
    1a4a:	movea.l d1,a0
    1a4c:	moveq #0,d5
    1a4e:	move.b d1,d5
	col = chr % 10;
    1a50:	add.w d1,d1
    1a52:	add.w d1,d1
    1a54:	add.w a0,d1
    1a56:	add.w d1,d1
    1a58:	sub.w d1,d0
    1a5a:	andi.l #255,d0
    1a60:	movea.l d0,a4
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    1a62:	adda.l d0,a4
    1a64:	adda.l a4,a4
    1a66:	move.l d5,-(sp)
    1a68:	move.w a3,-(sp)
    1a6a:	clr.w -(sp)
    1a6c:	jsr 2338 <__mulsi3>
    1a72:	addq.l #8,sp
    1a74:	move.l d0,d5
    1a76:	lsl.l #5,d5
    1a78:	add.l a4,d5
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    1a7a:	mulu.w #40,d4
    1a7e:	moveq #0,d0
    1a80:	move.w 2371e <Screen+0x6>,d0
    1a86:	add.l d0,d4
	WaitBlit();
    1a88:	movea.l 2374e <GfxBase>,a6
    1a8e:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    1a92:	movea.l 23758 <custom>,a4
    1a98:	move.w #2544,64(a4)
	custom->bltcon1 = 0x0000;
    1a9e:	move.w #0,66(a4)
	custom->bltafwm = 0xffff;
    1aa4:	move.w #-1,68(a4)
	custom->bltalwm = 0xffff;
    1aaa:	move.w #-1,70(a4)
	custom->bltapt = bmpFontP + source;
    1ab0:	addi.l #37446,d5
    1ab6:	move.l d5,80(a4)
	custom->bltdpt = bmpDestP + dest;
    1aba:	add.l 90(sp),d4
    1abe:	move.l d4,84(a4)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    1ac2:	subq.w #4,d6
    1ac4:	move.w d6,100(a4)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    1ac8:	subq.w #4,d3
    1aca:	move.w d3,102(a4)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    1ace:	move.w a2,d3
    1ad0:	moveq #11,d4
    1ad2:	lsl.w d4,d3
    1ad4:	movea.w d3,a2
    1ad6:	addq.w #2,a2
    1ad8:	move.w a2,88(a4)
    1adc:	bra.w 19c2 <main+0x194e>
		if (BounceEnabled)
    1ae0:	move.w 2355e <BounceEnabled>,d1
    1ae6:	beq.s 1af6 <main+0x1a82>
			ScrollerY = SCRT_MAX - 24;
    1ae8:	move.w #16,6180 <ScrollerY>
			ScrollerDir = -1;
    1af0:	st 6182 <ScrollerDir>
		BounceEnabled = !BounceEnabled;
    1af6:	tst.w d1
    1af8:	seq d1
    1afa:	ext.w d1
    1afc:	neg.w d1
    1afe:	move.w d1,2355e <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    1b04:	addq.w #2,a0
    1b06:	move.w a0,23556 <ScrolltextCnt>
    1b0c:	andi.l #65535,d0
    1b12:	lea 3f28 <Scrolltext>,a1
    1b18:	move.b (0,a1,d0.l),d1
    1b1c:	move.w a0,d0
	if (chr == 'm')
    1b1e:	cmpi.b #109,d1
    1b22:	bne.w 193a <main+0x18c6>
    1b26:	bra.w 19d4 <main+0x1960>
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1b2a:	move.w #-1,70(a4)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1b30:	or.w d7,d2
    1b32:	move.w d2,88(a4)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    1b36:	move.b bfe001 <_end+0xbda8a5>,d0
	while (!MouseLeft())
    1b3c:	btst #6,d0
    1b40:	beq.w 1786 <main+0x1712>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    1b44:	move.l dff004 <_end+0xddb8a8>,d0
    1b4a:	move.l d0,172(sp)
		vpos &= 0x1ff00;
    1b4e:	move.l 172(sp),d0
    1b52:	andi.l #130816,d0
    1b58:	move.l d0,172(sp)
		if (vpos != (311 << 8))
    1b5c:	move.l 172(sp),d0
    1b60:	cmpi.l #79616,d0
    1b66:	beq.w 10c8 <main+0x1054>
    1b6a:	bra.w 10ec <main+0x1078>
	if (shift)
    1b6e:	moveq #2,d7
    1b70:	movea.w #4,a5
    1b74:	bra.w 1704 <main+0x1690>
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1b78:	moveq #-1,d0
    1b7a:	move.w d0,70(a4)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1b7e:	move.w 50(sp),d0
    1b82:	or.w d2,d0
    1b84:	move.w d0,88(a4)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1b88:	move.w 2(a4),d0
    1b8c:	bra.w 16ec <main+0x1678>
	if (shift)
    1b90:	move.w #2,50(sp)
    1b96:	movea.w #4,a5
    1b9a:	bra.w 166e <main+0x15fa>
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1b9e:	moveq #-1,d0
    1ba0:	move.w d0,70(a4)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1ba4:	move.w 50(sp),d0
    1ba8:	or.w d2,d0
    1baa:	move.w d0,88(a4)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1bae:	move.w 2(a4),d0
    1bb2:	bra.w 1654 <main+0x15e0>
	if (shift)
    1bb6:	move.w #2,118(sp)
    1bbc:	moveq #4,d2
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1bbe:	move.w 120(sp),64(a4)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1bc4:	move.w 122(sp),66(a4)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1bca:	move.l a3,80(a4)
	custom->bltamod = imgS.Bpl - (width / 8);
    1bce:	move.w d6,d0
    1bd0:	sub.w d2,d0
    1bd2:	move.w d0,100(a4)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1bd6:	move.l a2,76(a4)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1bda:	move.w d4,d0
    1bdc:	sub.w d2,d0
    1bde:	move.w d0,98(a4)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1be2:	andi.l #65535,d3
    1be8:	move.l 68(sp),-(sp)
    1bec:	move.l d3,-(sp)
    1bee:	jsr 2338 <__mulsi3>
    1bf4:	addq.l #8,sp
    1bf6:	add.l 124(sp),d0
    1bfa:	add.l a6,d0
    1bfc:	move.l d0,84(a4)
    1c00:	move.l d0,72(a4)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1c04:	move.w d5,d0
    1c06:	sub.w d2,d0
    1c08:	move.w d0,102(a4)
    1c0c:	move.w d0,96(a4)
	custom->bltafwm = 0xffff;
    1c10:	move.w #-1,68(a4)
	custom->bltalwm = shift ? 0xffff << (15 - shift) : 0xffff;
    1c16:	tst.l 50(sp)
    1c1a:	bne.w 158a <main+0x1516>
    1c1e:	moveq #-1,d0
    1c20:	move.w d0,70(a4)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1c24:	moveq #0,d2
    1c26:	move.w 116(sp),d2
    1c2a:	moveq #11,d0
    1c2c:	lsl.l d0,d2
    1c2e:	move.w 118(sp),d0
    1c32:	or.w d2,d0
    1c34:	move.w d0,88(a4)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1c38:	move.w 2(a4),d0
    1c3c:	bra.w 15b2 <main+0x153e>
	if (shift)
    1c40:	move.w #2,50(sp)
    1c46:	moveq #4,d1
    1c48:	bra.w 15cc <main+0x1558>
		else if (ScrollerY <= ScrollerMin)
    1c4c:	cmpa.w #0,a0
    1c50:	bgt.w 1376 <main+0x1302>
			ScrollerY = ScrollerMin;
    1c54:	clr.w 6180 <ScrollerY>
			ScrollerDir = 1;
    1c5a:	move.b #1,6182 <ScrollerDir>
		Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    1c62:	move.w 2361c <BmpScroller+0x8>,d3
	int BltOffs = startY * theDesc.Bplt;
    1c68:	move.w d3,d4
    1c6a:	mulu.w #40,d4
	int Brcorner = height * theDesc.Bplt - 2;
    1c6e:	andi.l #65535,d3
    1c74:	lsl.l #5,d3
    1c76:	subq.l #2,d3
	WaitBlit();
    1c78:	movea.l 2374e <GfxBase>,a6
    1c7e:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
    1c82:	movea.l 23758 <custom>,a4
    1c88:	move.w #18928,64(a4)
	custom->bltcon1 = 0x0002;
    1c8e:	move.w #2,66(a4)
	custom->bltafwm = 0xffff;
    1c94:	move.w #-1,68(a4)
	custom->bltalwm = 0xffff;
    1c9a:	move.w #-1,70(a4)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
    1ca0:	add.l d3,d4
    1ca2:	add.l 90(sp),d4
    1ca6:	move.l d4,80(a4)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
    1caa:	move.l d4,84(a4)
	custom->bltamod = 0;
    1cae:	move.w #0,100(a4)
	custom->bltdmod = 0;
    1cb4:	move.w #0,102(a4)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
    1cba:	move.w 98(sp),d1
    1cbe:	moveq #11,d0
    1cc0:	lsl.w d0,d1
    1cc2:	lea 23614 <BmpScroller>,a0
    1cc8:	move.w (a0),d0
    1cca:	lsr.w #4,d0
    1ccc:	add.w d1,d0
    1cce:	move.w d0,88(a4)
	ScrollCnt += speed;
    1cd2:	move.w 23558 <ScrollCnt>,d0
    1cd8:	addq.w #4,d0
    1cda:	move.w d0,23558 <ScrollCnt>
	if (ScrollCnt >= 32)
    1ce0:	cmpi.w #31,d0
    1ce4:	bls.w 13fc <main+0x1388>
    1ce8:	bra.w 18e0 <main+0x186c>
			if (pdb[b].Y <= 0)
    1cec:	tst.l 56(sp)
    1cf0:	bgt.w 1314 <main+0x12a0>
				incY[b] *= -1;
    1cf4:	neg.w 102(sp)
				pdb[b].Y = 0;
    1cf8:	clr.l 56(sp)
    1cfc:	bra.w 1314 <main+0x12a0>
			if (pdb[b].X <= 0)
    1d00:	tst.l 72(sp)
    1d04:	bgt.w 1eac <main+0x1e38>
				incX[b] *= -1;
    1d08:	neg.w 110(sp)
    1d0c:	clr.w 146(sp)
    1d10:	clr.l 148(sp)
    1d14:	move.w #4042,144(sp)
    1d1a:	clr.l 164(sp)
    1d1e:	clr.l 94(sp)
				pdb[b].X = 0;
    1d22:	clr.l 72(sp)
    1d26:	bra.w 12fe <main+0x128a>
			if (pdb[b].Y <= 0)
    1d2a:	tst.l 60(sp)
    1d2e:	bgt.w 12aa <main+0x1236>
				incY[b] *= -1;
    1d32:	neg.w 104(sp)
				pdb[b].Y = 0;
    1d36:	clr.l 60(sp)
    1d3a:	bra.w 12aa <main+0x1236>
			if (pdb[b].X <= 0)
    1d3e:	tst.l 84(sp)
    1d42:	bgt.w 1ede <main+0x1e6a>
				incX[b] *= -1;
    1d46:	neg.w 114(sp)
    1d4a:	clr.w 130(sp)
    1d4e:	clr.l 132(sp)
    1d52:	move.w #4042,128(sp)
    1d58:	clr.l 156(sp)
    1d5c:	suba.l a5,a5
				pdb[b].X = 0;
    1d5e:	clr.l 84(sp)
			if (pdb[b].Y >= 130 - 32)
    1d62:	moveq #97,d0
    1d64:	cmp.l 64(sp),d0
    1d68:	blt.w 1236 <main+0x11c2>
			if (pdb[b].Y <= 0)
    1d6c:	tst.l 64(sp)
    1d70:	bgt.w 1242 <main+0x11ce>
				incY[b] *= -1;
    1d74:	neg.w 100(sp)
				pdb[b].Y = 0;
    1d78:	clr.l 64(sp)
			pdb[b].X += incX[b];
    1d7c:	movea.l 76(sp),a1
    1d80:	move.w 108(sp),d3
    1d84:	move.w d3,d4
    1d86:	ext.l d4
    1d88:	lea (0,a1,d4.l),a1
    1d8c:	move.l a1,76(sp)
			pdb[b].Y += incY[b];
    1d90:	movea.l 60(sp),a0
    1d94:	move.w 104(sp),d3
    1d98:	move.w d3,d4
    1d9a:	ext.l d4
    1d9c:	lea (0,a0,d4.l),a0
    1da0:	move.l a0,60(sp)
			if (pdb[b].X >= 320 - 32)
    1da4:	cmpa.w #287,a1
    1da8:	bgt.w 1272 <main+0x11fe>
			if (pdb[b].X <= 0)
    1dac:	tst.l 76(sp)
    1db0:	bgt.w 1f0e <main+0x1e9a>
				incX[b] *= -1;
    1db4:	neg.w 108(sp)
    1db8:	clr.w 138(sp)
    1dbc:	clr.l 140(sp)
    1dc0:	move.w #4042,136(sp)
    1dc6:	clr.l 160(sp)
    1dca:	moveq #0,d7
				pdb[b].X = 0;
    1dcc:	clr.l 76(sp)
    1dd0:	bra.w 1294 <main+0x1220>
			if (pdb[b].X <= 0)
    1dd4:	tst.l 80(sp)
    1dd8:	bgt.w 1e78 <main+0x1e04>
				incX[b] *= -1;
    1ddc:	neg.w 112(sp)
    1de0:	clr.w 122(sp)
    1de4:	clr.l 50(sp)
    1de8:	clr.l 124(sp)
    1dec:	move.w #4042,120(sp)
    1df2:	clr.l 152(sp)
				pdb[b].X = 0;
    1df6:	clr.l 80(sp)
			if (pdb[b].Y >= 130 - 32)
    1dfa:	moveq #97,d0
    1dfc:	cmp.l 68(sp),d0
    1e00:	blt.w 11ce <main+0x115a>
			if (pdb[b].Y <= 0)
    1e04:	tst.l 68(sp)
    1e08:	bgt.w 11da <main+0x1166>
				incY[b] *= -1;
    1e0c:	neg.w 106(sp)
				pdb[b].Y = 0;
    1e10:	clr.l 68(sp)
    1e14:	bra.w 11da <main+0x1166>
				ScrollerDir -= 1;
    1e18:	subq.b #1,d0
				if (ScrollerDir < -4)
    1e1a:	cmpi.b #-4,d0
    1e1e:	bge.s 1e5a <main+0x1de6>
					ScrollerDir = -4;
    1e20:	move.b #-4,6182 <ScrollerDir>
    1e28:	moveq #-4,d0
			ScrollerY += ScrollerDir;
    1e2a:	add.w d0,54(sp)
    1e2e:	move.w 54(sp),6180 <ScrollerY>
    1e36:	bra.w 135a <main+0x12e6>
				if (ScrollerDir < 1)
    1e3a:	tst.b d0
    1e3c:	bgt.w 1ffe <main+0x1f8a>
					ScrollerDir = 1;
    1e40:	move.b #1,6182 <ScrollerDir>
    1e48:	moveq #1,d0
			ScrollerY += ScrollerDir;
    1e4a:	add.w d0,54(sp)
    1e4e:	move.w 54(sp),6180 <ScrollerY>
    1e56:	bra.w 135a <main+0x12e6>
				if (ScrollerDir > -1)
    1e5a:	tst.b d0
    1e5c:	blt.w 1ffe <main+0x1f8a>
					ScrollerDir = -1;
    1e60:	st 6182 <ScrollerDir>
    1e66:	moveq #-1,d0
			ScrollerY += ScrollerDir;
    1e68:	add.w d0,54(sp)
    1e6c:	move.w 54(sp),6180 <ScrollerY>
    1e74:	bra.w 135a <main+0x12e6>
	BYTE shift = startD.X % 16;
    1e78:	moveq #15,d4
    1e7a:	and.l 80(sp),d4
    1e7e:	move.l d4,152(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1e82:	move.l d4,d0
    1e84:	moveq #12,d1
    1e86:	lsl.l d1,d0
    1e88:	ori.w #4042,d0
    1e8c:	move.w d0,120(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1e90:	moveq #12,d3
    1e92:	lsl.w d3,d4
    1e94:	move.w d4,122(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1e98:	move.l 80(sp),d4
    1e9c:	asr.l #3,d4
    1e9e:	move.l d4,124(sp)
    1ea2:	move.l 152(sp),50(sp)
    1ea8:	bra.w 11c4 <main+0x1150>
    1eac:	moveq #15,d4
    1eae:	and.l 72(sp),d4
    1eb2:	move.l d4,94(sp)
	BYTE shift = startD.X % 16;
    1eb6:	move.l d4,164(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1eba:	move.l d4,d0
    1ebc:	moveq #12,d1
    1ebe:	lsl.l d1,d0
    1ec0:	ori.w #4042,d0
    1ec4:	move.w d0,144(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1ec8:	moveq #12,d3
    1eca:	lsl.w d3,d4
    1ecc:	move.w d4,146(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1ed0:	move.l 72(sp),d4
    1ed4:	asr.l #3,d4
    1ed6:	move.l d4,148(sp)
    1eda:	bra.w 12fe <main+0x128a>
    1ede:	moveq #15,d4
    1ee0:	and.l 84(sp),d4
    1ee4:	movea.l d4,a5
	BYTE shift = startD.X % 16;
    1ee6:	move.l d4,156(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1eea:	move.l d4,d0
    1eec:	moveq #12,d1
    1eee:	lsl.l d1,d0
    1ef0:	ori.w #4042,d0
    1ef4:	move.w d0,128(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1ef8:	moveq #12,d3
    1efa:	lsl.w d3,d4
    1efc:	move.w d4,130(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1f00:	move.l 84(sp),d4
    1f04:	asr.l #3,d4
    1f06:	move.l d4,132(sp)
    1f0a:	bra.w 122c <main+0x11b8>
    1f0e:	moveq #15,d7
    1f10:	and.l 76(sp),d7
	BYTE shift = startD.X % 16;
    1f14:	move.l d7,160(sp)
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1f18:	move.l d7,d0
    1f1a:	moveq #12,d4
    1f1c:	lsl.l d4,d0
    1f1e:	ori.w #4042,d0
    1f22:	move.w d0,136(sp)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1f26:	move.w d7,d3
    1f28:	lsl.w d4,d3
    1f2a:	move.w d3,138(sp)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1f2e:	move.l 76(sp),d3
    1f32:	asr.l #3,d3
    1f34:	move.l d3,140(sp)
    1f38:	bra.w 1294 <main+0x1220>
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
    1f3c:	move.w d4,d5
    1f3e:	add.w d4,d5
    1f40:	suba.w d5,a1
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    1f42:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    1f46:	move.w a1,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    1f4a:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    1f50:	move.w a1,6(a0)
		MirrorEnabled = !MirrorEnabled;
    1f54:	tst.w d1
    1f56:	seq d1
    1f58:	ext.w d1
    1f5a:	neg.w d1
    1f5c:	move.w d1,23554 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    1f62:	move.w d0,d1
    1f64:	addq.w #1,d1
    1f66:	move.w d1,23556 <ScrolltextCnt>
    1f6c:	andi.l #65535,d0
    1f72:	lea 3f28 <Scrolltext>,a0
    1f78:	move.b (0,a0,d0.l),d1
    1f7c:	bra.w 1a28 <main+0x19b4>
		KPrintF("p61Init failed!\n");
    1f80:	pea 3ec6 <incbin_P61_Player_end+0x4a>
    1f86:	jsr (a4)
    1f88:	addq.l #4,sp
	short incX[6] = {3, 3, 3, 3, 3, 3};
    1f8a:	move.w #3,184(sp)
	short incY[6] = {1, 1, 1, 1, 1, 1};
    1f90:	move.w #1,196(sp)
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
    1f96:	move.w 236e8 <BmpLogo+0x4>,d2
    1f9c:	movea.w 236ea <BmpLogo+0x6>,a1
    1fa2:	move.l 236f2 <BmpLogo+0xe>,d3
    1fa8:	movea.w 236b6 <BmpUpperPart_PF1+0x6>,a0
    1fae:	move.l 236be <BmpUpperPart_PF1+0xe>,d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1fb4:	movea.l 23758 <custom>,a4
    1fba:	move.w 2(a4),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1fbe:	bra.w fd6 <main+0xf62>
		Exit(0);
    1fc2:	suba.l a6,a6
    1fc4:	moveq #0,d1
    1fc6:	jsr -144(a6)
    1fca:	bra.w c2 <main+0x4e>
		Exit(0);
    1fce:	movea.l 2374a <DOSBase>,a6
    1fd4:	moveq #0,d1
    1fd6:	jsr -144(a6)
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    1fda:	movea.l 23752 <SysBase>,a6
    1fe0:	lea 3e8e <incbin_P61_Player_end+0x12>,a1
    1fe6:	moveq #0,d0
    1fe8:	jsr -552(a6)
    1fec:	move.l d0,2374a <DOSBase>
	if (!DOSBase)
    1ff2:	bne.w c2 <main+0x4e>
    1ff6:	bra.s 1fc2 <main+0x1f4e>
	APTR vbr = 0;
    1ff8:	moveq #0,d0
    1ffa:	bra.w 85e <main+0x7ea>
				ScrollerDir -= 1;
    1ffe:	move.b d0,6182 <ScrollerDir>
			ScrollerY += ScrollerDir;
    2004:	ext.w d0
    2006:	add.w d0,54(sp)
    200a:	move.w 54(sp),6180 <ScrollerY>
    2012:	bra.w 135a <main+0x12e6>
    2016:	nop

00002018 <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

static __attribute__((interrupt)) void interruptHandler()
{
    2018:	movem.l d0/a0/a3/a6,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    201c:	movea.l 23758 <custom>,a0
    2022:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    2028:	move.w #32,156(a0)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    202e:	lea 2516 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    2034:	movea.l #14675968,a6
	__asm volatile(
    203a:	movem.l d0-a2/a4-a5,-(sp)
    203e:	jsr 4(a3)
    2042:	movem.l (sp)+,d0-a2/a4-a5

    // DEMO - ThePlayer
    p61Music();

    // DEMO - increment frameCounter
    frameCounter++;
    2046:	move.w 23756 <frameCounter>,d0
    204c:	addq.w #1,d0
    204e:	move.w d0,23756 <frameCounter>
}
    2054:	movem.l (sp)+,d0/a0/a3/a6
    2058:	rte

0000205a <WaitVbl>:
{
    205a:	subq.l #8,sp
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    205c:	move.l dff004 <_end+0xddb8a8>,d0
    2062:	move.l d0,(sp)
		vpos &= 0x1ff00;
    2064:	move.l (sp),d0
    2066:	andi.l #130816,d0
    206c:	move.l d0,(sp)
		if (vpos != (311 << 8))
    206e:	move.l (sp),d0
    2070:	cmpi.l #79616,d0
    2076:	beq.s 205c <WaitVbl+0x2>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    2078:	move.l dff004 <_end+0xddb8a8>,d0
    207e:	move.l d0,4(sp)
		vpos &= 0x1ff00;
    2082:	move.l 4(sp),d0
    2086:	andi.l #130816,d0
    208c:	move.l d0,4(sp)
		if (vpos == (311 << 8))
    2090:	move.l 4(sp),d0
    2094:	cmpi.l #79616,d0
    209a:	bne.s 2078 <WaitVbl+0x1e>
}
    209c:	addq.l #8,sp
    209e:	rts

000020a0 <KPrintF>:
void KPrintF(const char* fmt, ...) {
    20a0:	lea -128(sp),sp
    20a4:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    20a8:	move.w f0ff60 <_end+0xeec804>,d0
    20ae:	cmpi.w #20153,d0
    20b2:	beq.s 20de <KPrintF+0x3e>
    20b4:	cmpi.w #-24562,d0
    20b8:	beq.s 20de <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    20ba:	movea.l 23752 <SysBase>,a6
    20c0:	movea.l 144(sp),a0
    20c4:	lea 148(sp),a1
    20c8:	lea 2432 <KPutCharX>,a2
    20ce:	suba.l a3,a3
    20d0:	jsr -522(a6)
}
    20d4:	movem.l (sp)+,a2-a3/a6
    20d8:	lea 128(sp),sp
    20dc:	rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    20de:	movea.l 23752 <SysBase>,a6
    20e4:	movea.l 144(sp),a0
    20e8:	lea 148(sp),a1
    20ec:	lea 2440 <PutChar>,a2
    20f2:	lea 12(sp),a3
    20f6:	jsr -522(a6)
		UaeDbgLog(86, temp);
    20fa:	move.l a3,-(sp)
    20fc:	pea 56 <_start+0x56>
    2100:	jsr f0ff60 <_end+0xeec804>
    2106:	addq.l #8,sp
}
    2108:	movem.l (sp)+,a2-a3/a6
    210c:	lea 128(sp),sp
    2110:	rts

00002112 <strlen>:
unsigned long strlen(const char* s) {
    2112:	movea.l 4(sp),a0
	unsigned long t=0;
    2116:	moveq #0,d0
	while(*s++)
    2118:	tst.b (a0)
    211a:	beq.s 2124 <strlen+0x12>
		t++;
    211c:	addq.l #1,d0
	while(*s++)
    211e:	tst.b (0,a0,d0.l)
    2122:	bne.s 211c <strlen+0xa>
}
    2124:	rts

00002126 <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    2126:	movem.l d2-d7/a2-a3,-(sp)
    212a:	move.l 36(sp),d0
    212e:	move.l 40(sp),d4
    2132:	movea.l 44(sp),a1
	while(len-- > 0)
    2136:	move.l a1,d5
    2138:	subq.l #1,d5
    213a:	cmpa.w #0,a1
    213e:	beq.w 21ee <memset+0xc8>
		*ptr++ = val;
    2142:	move.b d4,d7
    2144:	move.l d0,d1
    2146:	neg.l d1
    2148:	moveq #3,d2
    214a:	and.l d2,d1
    214c:	moveq #5,d6
    214e:	movea.l d0,a2
    2150:	cmp.l d5,d6
    2152:	bcc.s 21be <memset+0x98>
    2154:	tst.l d1
    2156:	beq.s 217c <memset+0x56>
    2158:	move.b d4,(a2)+
	while(len-- > 0)
    215a:	subq.l #1,d5
    215c:	moveq #1,d2
    215e:	cmp.l d1,d2
    2160:	beq.s 217c <memset+0x56>
		*ptr++ = val;
    2162:	movea.l d0,a2
    2164:	addq.l #2,a2
    2166:	movea.l d0,a0
    2168:	move.b d4,1(a0)
	while(len-- > 0)
    216c:	subq.l #1,d5
    216e:	moveq #3,d2
    2170:	cmp.l d1,d2
    2172:	bne.s 217c <memset+0x56>
		*ptr++ = val;
    2174:	addq.l #1,a2
    2176:	move.b d4,2(a0)
	while(len-- > 0)
    217a:	subq.l #1,d5
    217c:	move.l a1,d3
    217e:	sub.l d1,d3
    2180:	moveq #0,d6
    2182:	move.b d4,d6
    2184:	move.l d6,d2
    2186:	swap d2
    2188:	clr.w d2
    218a:	movea.l d2,a0
    218c:	move.l d4,d2
    218e:	lsl.w #8,d2
    2190:	swap d2
    2192:	clr.w d2
    2194:	lsl.l #8,d6
    2196:	movea.l d6,a3
    2198:	move.l a0,d6
    219a:	or.l d6,d2
    219c:	move.l a3,d6
    219e:	or.l d6,d2
    21a0:	move.b d7,d2
    21a2:	movea.l d0,a0
    21a4:	adda.l d1,a0
    21a6:	moveq #-4,d1
    21a8:	and.l d3,d1
    21aa:	add.l a0,d1
		*ptr++ = val;
    21ac:	move.l d2,(a0)+
	while(len-- > 0)
    21ae:	cmpa.l d1,a0
    21b0:	bne.s 21ac <memset+0x86>
    21b2:	moveq #-4,d1
    21b4:	and.l d3,d1
    21b6:	adda.l d1,a2
    21b8:	sub.l d1,d5
    21ba:	cmp.l d3,d1
    21bc:	beq.s 21ee <memset+0xc8>
		*ptr++ = val;
    21be:	move.b d4,(a2)
	while(len-- > 0)
    21c0:	tst.l d5
    21c2:	beq.s 21ee <memset+0xc8>
		*ptr++ = val;
    21c4:	move.b d4,1(a2)
	while(len-- > 0)
    21c8:	moveq #1,d1
    21ca:	cmp.l d5,d1
    21cc:	beq.s 21ee <memset+0xc8>
		*ptr++ = val;
    21ce:	move.b d4,2(a2)
	while(len-- > 0)
    21d2:	moveq #2,d2
    21d4:	cmp.l d5,d2
    21d6:	beq.s 21ee <memset+0xc8>
		*ptr++ = val;
    21d8:	move.b d4,3(a2)
	while(len-- > 0)
    21dc:	moveq #3,d6
    21de:	cmp.l d5,d6
    21e0:	beq.s 21ee <memset+0xc8>
		*ptr++ = val;
    21e2:	move.b d4,4(a2)
	while(len-- > 0)
    21e6:	subq.l #4,d5
    21e8:	beq.s 21ee <memset+0xc8>
		*ptr++ = val;
    21ea:	move.b d4,5(a2)
}
    21ee:	movem.l (sp)+,d2-d7/a2-a3
    21f2:	rts

000021f4 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    21f4:	movem.l d2-d6,-(sp)
    21f8:	move.l 24(sp),d0
    21fc:	move.l 28(sp),d1
    2200:	move.l 32(sp),d3
	while(len--)
    2204:	move.l d3,d4
    2206:	subq.l #1,d4
    2208:	tst.l d3
    220a:	beq.s 226a <memcpy+0x76>
    220c:	movea.l d1,a0
    220e:	addq.l #1,a0
    2210:	move.l d0,d2
    2212:	sub.l a0,d2
    2214:	moveq #2,d5
    2216:	cmp.l d2,d5
    2218:	sc.s d2
    221a:	neg.b d2
    221c:	moveq #8,d6
    221e:	cmp.l d4,d6
    2220:	sc.s d5
    2222:	neg.b d5
    2224:	and.b d5,d2
    2226:	beq.s 2270 <memcpy+0x7c>
    2228:	move.l d0,d2
    222a:	or.l d1,d2
    222c:	moveq #3,d5
    222e:	and.l d5,d2
    2230:	bne.s 2270 <memcpy+0x7c>
    2232:	movea.l d1,a0
    2234:	movea.l d0,a1
    2236:	moveq #-4,d2
    2238:	and.l d3,d2
    223a:	add.l d1,d2
		*d++ = *s++;
    223c:	move.l (a0)+,(a1)+
	while(len--)
    223e:	cmp.l a0,d2
    2240:	bne.s 223c <memcpy+0x48>
    2242:	moveq #-4,d2
    2244:	and.l d3,d2
    2246:	movea.l d0,a0
    2248:	adda.l d2,a0
    224a:	add.l d2,d1
    224c:	sub.l d2,d4
    224e:	cmp.l d3,d2
    2250:	beq.s 226a <memcpy+0x76>
		*d++ = *s++;
    2252:	movea.l d1,a1
    2254:	move.b (a1),(a0)
	while(len--)
    2256:	tst.l d4
    2258:	beq.s 226a <memcpy+0x76>
		*d++ = *s++;
    225a:	move.b 1(a1),1(a0)
	while(len--)
    2260:	subq.l #1,d4
    2262:	beq.s 226a <memcpy+0x76>
		*d++ = *s++;
    2264:	move.b 2(a1),2(a0)
}
    226a:	movem.l (sp)+,d2-d6
    226e:	rts
    2270:	movea.l d0,a1
    2272:	add.l d3,d1
		*d++ = *s++;
    2274:	move.b -1(a0),(a1)+
	while(len--)
    2278:	cmp.l a0,d1
    227a:	beq.s 226a <memcpy+0x76>
    227c:	addq.l #1,a0
    227e:	bra.s 2274 <memcpy+0x80>

00002280 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    2280:	movem.l d2-d5/a2,-(sp)
    2284:	move.l 24(sp),d0
    2288:	move.l 28(sp),d1
    228c:	move.l 32(sp),d2
		while (len--)
    2290:	movea.l d2,a1
    2292:	subq.l #1,a1
	if (d < s) {
    2294:	cmp.l d0,d1
    2296:	bls.s 2304 <memmove+0x84>
		while (len--)
    2298:	tst.l d2
    229a:	beq.s 22fe <memmove+0x7e>
    229c:	movea.l d1,a2
    229e:	addq.l #1,a2
    22a0:	move.l d0,d3
    22a2:	sub.l a2,d3
    22a4:	moveq #2,d4
    22a6:	cmp.l d3,d4
    22a8:	sc.s d3
    22aa:	neg.b d3
    22ac:	moveq #8,d5
    22ae:	cmp.l a1,d5
    22b0:	sc.s d4
    22b2:	neg.b d4
    22b4:	and.b d4,d3
    22b6:	beq.s 2328 <memmove+0xa8>
    22b8:	move.l d0,d3
    22ba:	or.l d1,d3
    22bc:	moveq #3,d4
    22be:	and.l d4,d3
    22c0:	bne.s 2328 <memmove+0xa8>
    22c2:	movea.l d1,a0
    22c4:	movea.l d0,a2
    22c6:	moveq #-4,d3
    22c8:	and.l d2,d3
    22ca:	add.l d1,d3
			*d++ = *s++;
    22cc:	move.l (a0)+,(a2)+
		while (len--)
    22ce:	cmp.l a0,d3
    22d0:	bne.s 22cc <memmove+0x4c>
    22d2:	moveq #-4,d3
    22d4:	and.l d2,d3
    22d6:	movea.l d0,a2
    22d8:	adda.l d3,a2
    22da:	movea.l d1,a0
    22dc:	adda.l d3,a0
    22de:	suba.l d3,a1
    22e0:	cmp.l d2,d3
    22e2:	beq.s 22fe <memmove+0x7e>
			*d++ = *s++;
    22e4:	move.b (a0),(a2)
		while (len--)
    22e6:	cmpa.w #0,a1
    22ea:	beq.s 22fe <memmove+0x7e>
			*d++ = *s++;
    22ec:	move.b 1(a0),1(a2)
		while (len--)
    22f2:	moveq #1,d5
    22f4:	cmp.l a1,d5
    22f6:	beq.s 22fe <memmove+0x7e>
			*d++ = *s++;
    22f8:	move.b 2(a0),2(a2)
}
    22fe:	movem.l (sp)+,d2-d5/a2
    2302:	rts
		const char *lasts = s + (len - 1);
    2304:	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    2308:	adda.l d0,a1
		while (len--)
    230a:	tst.l d2
    230c:	beq.s 22fe <memmove+0x7e>
    230e:	move.l a0,d1
    2310:	sub.l d2,d1
			*lastd-- = *lasts--;
    2312:	move.b (a0),(a1)
		while (len--)
    2314:	subq.l #1,a0
    2316:	subq.l #1,a1
    2318:	cmp.l a0,d1
    231a:	beq.s 22fe <memmove+0x7e>
			*lastd-- = *lasts--;
    231c:	move.b (a0),(a1)
		while (len--)
    231e:	subq.l #1,a0
    2320:	subq.l #1,a1
    2322:	cmp.l a0,d1
    2324:	bne.s 2312 <memmove+0x92>
    2326:	bra.s 22fe <memmove+0x7e>
    2328:	movea.l d0,a1
    232a:	add.l d2,d1
			*d++ = *s++;
    232c:	move.b -1(a2),(a1)+
		while (len--)
    2330:	cmp.l a2,d1
    2332:	beq.s 22fe <memmove+0x7e>
    2334:	addq.l #1,a2
    2336:	bra.s 232c <memmove+0xac>

00002338 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    2338:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    233c:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2340:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    2344:	mulu.w 8(sp),d1
	addw	d1, d0
    2348:	add.w d1,d0
	swap	d0
    234a:	swap d0
	clrw	d0
    234c:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    234e:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    2352:	mulu.w 10(sp),d1
	addl	d1, d0
    2356:	add.l d1,d0
	rts
    2358:	rts

0000235a <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    235a:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    235c:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    2360:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    2364:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    236a:	bcc.s 2382 <__udivsi3+0x28>
	movel	d0, d2
    236c:	move.l d0,d2
	clrw	d2
    236e:	clr.w d2
	swap	d2
    2370:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    2372:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    2374:	move.w d2,d0
	swap	d0
    2376:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    2378:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    237c:	divu.w d1,d2
	movew	d2, d0
    237e:	move.w d2,d0
	jra	6f
    2380:	bra.s 23b2 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    2382:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    2384:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    2386:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    2388:	cmpi.l #65536,d1
	jcc	4b
    238e:	bcc.s 2384 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    2390:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    2392:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    2398:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    239a:	mulu.w d0,d1
	swap	d2
    239c:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    239e:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    23a0:	swap d2
	tstw	d2		/* high part 17 bits? */
    23a2:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    23a4:	bne.s 23b0 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    23a6:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    23a8:	bcs.s 23b0 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    23aa:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    23ae:	bls.s 23b2 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    23b0:	subq.l #1,d0

6:	movel	sp@+, d2
    23b2:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    23b4:	rts

000023b6 <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    23b6:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    23b8:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    23ba:	move.l 12(sp),d1
	jpl	1f
    23be:	bpl.s 23c4 <__divsi3+0xe>
	negl	d1
    23c0:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    23c2:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    23c4:	move.l 8(sp),d0
	jpl	2f
    23c8:	bpl.s 23ce <__divsi3+0x18>
	negl	d0
    23ca:	neg.l d0
	negb	d2
    23cc:	neg.b d2

2:	movel	d1, sp@-
    23ce:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    23d0:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    23d2:	bsr.s 235a <__udivsi3>
	addql	#8, sp
    23d4:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    23d6:	tst.b d2
	jpl	3f
    23d8:	bpl.s 23dc <__divsi3+0x26>
	negl	d0
    23da:	neg.l d0

3:	movel	sp@+, d2
    23dc:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    23de:	rts

000023e0 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    23e0:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    23e4:	move.l 4(sp),d0
	movel	d1, sp@-
    23e8:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    23ea:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    23ec:	bsr.s 23b6 <__divsi3>
	addql	#8, sp
    23ee:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    23f0:	move.l 8(sp),d1
	movel	d1, sp@-
    23f4:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    23f6:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    23f8:	bsr.w 2338 <__mulsi3>
	addql	#8, sp
    23fc:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    23fe:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2402:	sub.l d0,d1
	movel	d1, d0
    2404:	move.l d1,d0
	rts
    2406:	rts

00002408 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    2408:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    240c:	move.l 4(sp),d0
	movel	d1, sp@-
    2410:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2412:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    2414:	bsr.w 235a <__udivsi3>
	addql	#8, sp
    2418:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    241a:	move.l 8(sp),d1
	movel	d1, sp@-
    241e:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2420:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    2422:	bsr.w 2338 <__mulsi3>
	addql	#8, sp
    2426:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2428:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    242c:	sub.l d0,d1
	movel	d1, d0
    242e:	move.l d1,d0
	rts
    2430:	rts

00002432 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    2432:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    2434:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    2438:	jsr -516(a6)
    move.l (sp)+, a6
    243c:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    243e:	rts

00002440 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    2440:	move.b d0,(a3)+
	rts
    2442:	rts

00002444 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    2444:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    2446:	adda.l a0,a2
	move.l	a2,a3
    2448:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    244a:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    244c:	moveq #56,d4
	moveq	#8,d5
    244e:	moveq #8,d5
	bra.s	.Lliteral
    2450:	bra.s 24ba <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    2452:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    2454:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    2456:	dbf d1,2452 <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    245a:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    245c:	bcc.s 2460 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    245e:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    2460:	tst.w d0
    2462:	bne.s 246c <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    2464:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    2466:	bls.s 24de <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    2468:	move.w (a0)+,d0
    246a:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    246c:	rol.l #6,d0
	move.w	d0,d1
    246e:	move.w d0,d1
	and.w	d4,d1
    2470:	and.w d4,d1
	eor.w	d1,d0
    2472:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    2474:	movem.w (24d8 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    247a:	rol.l d2,d0
	and.w	d0,d3					|scaling
    247c:	and.w d0,d3
	eor.w	d3,d0
    247e:	eor.w d3,d0
	suba.w	d3,a4
    2480:	suba.w d3,a4
	adda.l	a1,a4
    2482:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    2484:	tst.w d0
    2486:	bne.s 248c <_doynaxdepack_asm+0x48>
    2488:	move.w (a0)+,d0
    248a:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    248c:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    248e:	beq.s 24a6 <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    2490:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    2492:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    2494:	bpl.s 24a2 <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    2496:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    2498:	bpl.s 24a0 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    249a:	addx.b d1,d1
	lsl.l	#2,d0
    249c:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    249e:	bmi.s 249a <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    24a0:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    24a2:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    24a4:	bcc.s 24a8 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    24a6:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    24a8:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    24aa:	dbf d1,24a6 <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    24ae:	add.l d0,d0
	bcc.s	.Lmatch
    24b0:	bcc.s 2460 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    24b2:	tst.w d0
    24b4:	bne.s 24ba <_doynaxdepack_asm+0x76>
    24b6:	move.w (a0)+,d0
    24b8:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    24ba:	moveq #0,d1
	add.l	d0,d0
    24bc:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    24be:	bcc.s 245e <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    24c0:	bpl.s 24c8 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    24c2:	addx.b d1,d1
	lsl.l	#2,d0
    24c4:	lsl.l #2,d0
	bmi.s	.Llgetlen
    24c6:	bmi.s 24c2 <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    24c8:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    24ca:	dbv.s d1,2452 <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    24ce:	add.l d0,d0
	eor.w	d1,d0		
    24d0:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    24d2:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    24d4:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    24d6:	bra.s 24ca <_doynaxdepack_asm+0x86>

000024d8 <doy_table>:
    24d8:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    24e8:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    24f8:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    2508:	.............o
