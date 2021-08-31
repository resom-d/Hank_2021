
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
       4:	move.l #21931,d3
       a:	subi.l #21931,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	beq.s 26 <_start+0x26>
      14:	lea 55ab <__fini_array_end>,a2
      1a:	moveq #0,d2
		__preinit_array_start[i]();
      1c:	movea.l (a2)+,a0
      1e:	jsr (a0)
	for (i = 0; i < count; i++)
      20:	addq.l #1,d2
      22:	cmp.l d3,d2
      24:	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	move.l #21931,d3
      2c:	subi.l #21931,d3
      32:	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	beq.s 48 <_start+0x48>
      36:	lea 55ab <__fini_array_end>,a2
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
      4e:	move.l #21931,d2
      54:	subi.l #21931,d2
      5a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	beq.s 6e <_start+0x6e>
      5e:	lea 55ab <__fini_array_end>,a2
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
      74:	lea -12(sp),sp
      78:	movem.l d2-d7/a2-a6,-(sp)

	SysBase = *((struct ExecBase **)4UL);
      7c:	movea.l 4 <_start+0x4>,a6
      80:	move.l a6,1db4c <SysBase>
	custom = (struct Custom *)0xdff000;
      86:	move.l #14675968,1db52 <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
      90:	lea 3301 <incbin_P61_Player_end+0x1>,a1
      96:	moveq #0,d0
      98:	jsr -552(a6)
      9c:	move.l d0,1db48 <GfxBase>
	if (!GfxBase)
      a2:	beq.w 1358 <main+0x12e4>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
      a6:	movea.l 1db4c <SysBase>,a6
      ac:	lea 3312 <incbin_P61_Player_end+0x12>,a1
      b2:	moveq #0,d0
      b4:	jsr -552(a6)
      b8:	move.l d0,1db44 <DOSBase>
	if (!DOSBase)
      be:	beq.w 134c <main+0x12d8>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      c2:	pea 331e <incbin_P61_Player_end+0x1e>
      c8:	lea 142c <KPrintF>,a5
      ce:	jsr (a5)
#endif

	Write(Output(), (APTR) "Hello console!\n", 15);
      d0:	movea.l 1db44 <DOSBase>,a6
      d6:	jsr -60(a6)
      da:	movea.l 1db44 <DOSBase>,a6
      e0:	move.l d0,d1
      e2:	move.l #13114,d2
      e8:	moveq #15,d3
      ea:	jsr -48(a6)
}

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{

	bmp->Width = w;
      ee:	move.l #20971776,1db10 <Screen>
	bmp->Height = h;
	bmp->Bpls = bpls;
      f8:	move.w #3,1db14 <Screen+0x4>
	bmp->Bpl = w / 8;
     100:	move.l #2621560,1db18 <Screen+0x8>
	bmp->Bplt = w / 8 * bpls;
	bmp->Btot = w / 8 * h * bpls;
     10a:	move.w #30720,1db1e <Screen+0xe>
	bmp->Width = w;
     112:	move.l #16777346,1dadc <BmpLogo>
	bmp->Bpls = bpls;
     11c:	move.w #3,1dae0 <BmpLogo+0x4>
	bmp->Bpl = w / 8;
     124:	move.l #2097248,1dae4 <BmpLogo+0x8>
	bmp->Btot = w / 8 * h * bpls;
     12e:	move.w #12480,1daea <BmpLogo+0xe>
	bmp->Width = w;
     136:	move.l #20971650,1daa8 <BmpUpperPart_PF1>
	bmp->Bpls = bpls;
     140:	move.w #3,1daac <BmpUpperPart_PF1+0x4>
	bmp->Bpl = w / 8;
     148:	move.l #2621560,1dab0 <BmpUpperPart_PF1+0x8>
	bmp->Btot = w / 8 * h * bpls;
     152:	move.w #15600,1dab6 <BmpUpperPart_PF1+0xe>
	bmp->Width = w;
     15a:	move.l #20971650,1da74 <BmpUpperPart_PF2>
	bmp->Bpls = bpls;
     164:	move.w #3,1da78 <BmpUpperPart_PF2+0x4>
	bmp->Bpl = w / 8;
     16c:	move.l #2621560,1da7c <BmpUpperPart_PF2+0x8>
	bmp->Btot = w / 8 * h * bpls;
     176:	move.w #15600,1da82 <BmpUpperPart_PF2+0xe>
	bmp->Width = w;
     17e:	move.l #23068838,1da40 <BmpScroller>
	bmp->Bpls = bpls;
     188:	move.w #3,1da44 <BmpScroller+0x4>
	bmp->Bpl = w / 8;
     190:	move.l #2883716,1da48 <BmpScroller+0x8>
	bmp->Btot = w / 8 * h * bpls;
     19a:	move.w #21912,1da4e <BmpScroller+0xe>
	bmp->Width = w;
     1a2:	move.l #20971776,1da0c <BmpFont32>
	bmp->Bpls = bpls;
     1ac:	move.w #3,1da10 <BmpFont32+0x4>
	bmp->Bpl = w / 8;
     1b4:	move.l #2621560,1da14 <BmpFont32+0x8>
	bmp->Btot = w / 8 * h * bpls;
     1be:	move.w #30720,1da1a <BmpFont32+0xe>
	bmp->Width = w;
     1c6:	move.l #20971776,1d9d8 <BmpCookie>
	bmp->Bpls = bpls;
     1d0:	move.w #3,1d9dc <BmpCookie+0x4>
	bmp->Bpl = w / 8;
     1d8:	move.l #2621560,1d9e0 <BmpCookie+0x8>
	bmp->Btot = w / 8 * h * bpls;
     1e2:	move.w #30720,1d9e6 <BmpCookie+0xe>
	bmp->Width = w;
     1ea:	move.l #20971776,1d9a4 <BmpCookieMask>
	bmp->Bpls = bpls;
     1f4:	move.w #1,1d9a8 <BmpCookieMask+0x4>
	bmp->Bpl = w / 8;
     1fc:	move.l #2621480,1d9ac <BmpCookieMask+0x8>
	bmp->Btot = w / 8 * h * bpls;
     206:	move.w #10240,1d9b2 <BmpCookieMask+0xe>
	copPtr = AllocMem(1024, MEMF_CHIP);
     20e:	movea.l 1db4c <SysBase>,a6
     214:	move.l #1024,d0
     21a:	moveq #2,d1
     21c:	jsr -198(a6)
     220:	move.l d0,1d99e <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
     226:	movea.l 1db4c <SysBase>,a6
     22c:	moveq #0,d0
     22e:	move.w 1da4e <BmpScroller+0xe>,d0
     234:	move.l #65538,d1
     23a:	jsr -198(a6)
     23e:	move.l d0,1da50 <BmpScroller+0x10>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
     244:	movea.l 1db4c <SysBase>,a6
     24a:	moveq #0,d0
     24c:	move.w 1dab6 <BmpUpperPart_PF1+0xe>,d0
     252:	move.l #65538,d1
     258:	jsr -198(a6)
     25c:	move.l d0,1dab8 <BmpUpperPart_PF1+0x10>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
     262:	movea.l 1db4c <SysBase>,a6
     268:	moveq #0,d0
     26a:	move.w 1da82 <BmpUpperPart_PF2+0xe>,d0
     270:	move.l #65538,d1
     276:	jsr -198(a6)
     27a:	move.l d0,1da84 <BmpUpperPart_PF2+0x10>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
     280:	move.l #21936,1daec <BmpLogo+0x10>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
     28a:	move.l #34418,1da1c <BmpFont32+0x10>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
     294:	move.l #65140,1d9e8 <BmpCookie+0x10>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
     29e:	move.l #95862,1d9b4 <BmpCookieMask+0x10>
	for (int p = 0; p < img->Bpls; p++)
     2a8:	moveq #0,d2
     2aa:	move.w 1daac <BmpUpperPart_PF1+0x4>,d2
     2b0:	addq.l #4,sp
     2b2:	tst.l d2
     2b4:	beq.w 346 <main+0x2d2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2b8:	movea.l 1dab8 <BmpUpperPart_PF1+0x10>,a0
     2be:	moveq #0,d3
     2c0:	move.w 1dab0 <BmpUpperPart_PF1+0x8>,d3
     2c6:	move.l a0,1dabc <BmpUpperPart_PF1+0x14>
	for (int p = 0; p < img->Bpls; p++)
     2cc:	moveq #1,d1
     2ce:	cmp.l d2,d1
     2d0:	beq.s 346 <main+0x2d2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2d2:	lea (0,a0,d3.l),a1
     2d6:	move.l a1,1dac0 <BmpUpperPart_PF1+0x18>
	for (int p = 0; p < img->Bpls; p++)
     2dc:	moveq #2,d1
     2de:	cmp.l d2,d1
     2e0:	beq.s 346 <main+0x2d2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2e2:	move.l d3,d1
     2e4:	add.l d3,d1
     2e6:	lea (0,a0,d1.l),a1
     2ea:	move.l a1,1dac4 <BmpUpperPart_PF1+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     2f0:	moveq #3,d4
     2f2:	cmp.l d2,d4
     2f4:	beq.s 346 <main+0x2d2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2f6:	add.l d3,d1
     2f8:	lea (0,a0,d1.l),a1
     2fc:	move.l a1,1dac8 <BmpUpperPart_PF1+0x20>
	for (int p = 0; p < img->Bpls; p++)
     302:	moveq #4,d4
     304:	cmp.l d2,d4
     306:	beq.s 346 <main+0x2d2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     308:	add.l d3,d1
     30a:	lea (0,a0,d1.l),a1
     30e:	move.l a1,1dacc <BmpUpperPart_PF1+0x24>
	for (int p = 0; p < img->Bpls; p++)
     314:	moveq #5,d4
     316:	cmp.l d2,d4
     318:	beq.s 346 <main+0x2d2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     31a:	add.l d3,d1
     31c:	lea (0,a0,d1.l),a1
     320:	move.l a1,1dad0 <BmpUpperPart_PF1+0x28>
	for (int p = 0; p < img->Bpls; p++)
     326:	moveq #6,d4
     328:	cmp.l d2,d4
     32a:	beq.s 346 <main+0x2d2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     32c:	add.l d3,d1
     32e:	lea (0,a0,d1.l),a1
     332:	move.l a1,1dad4 <BmpUpperPart_PF1+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     338:	subq.l #7,d2
     33a:	beq.s 346 <main+0x2d2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     33c:	add.l d3,d1
     33e:	add.l a0,d1
     340:	move.l d1,1dad8 <BmpUpperPart_PF1+0x30>
	for (int p = 0; p < img->Bpls; p++)
     346:	moveq #0,d2
     348:	move.w 1da78 <BmpUpperPart_PF2+0x4>,d2
     34e:	tst.l d2
     350:	beq.w 3dc <main+0x368>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     354:	moveq #0,d3
     356:	move.w 1da7c <BmpUpperPart_PF2+0x8>,d3
     35c:	move.l d0,1da88 <BmpUpperPart_PF2+0x14>
	for (int p = 0; p < img->Bpls; p++)
     362:	moveq #1,d1
     364:	cmp.l d2,d1
     366:	beq.s 3dc <main+0x368>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     368:	move.l d0,d4
     36a:	add.l d3,d4
     36c:	move.l d4,1da8c <BmpUpperPart_PF2+0x18>
	for (int p = 0; p < img->Bpls; p++)
     372:	moveq #2,d1
     374:	cmp.l d2,d1
     376:	beq.s 3dc <main+0x368>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     378:	move.l d3,d1
     37a:	add.l d3,d1
     37c:	move.l d0,d4
     37e:	add.l d1,d4
     380:	move.l d4,1da90 <BmpUpperPart_PF2+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     386:	moveq #3,d4
     388:	cmp.l d2,d4
     38a:	beq.s 3dc <main+0x368>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     38c:	add.l d3,d1
     38e:	move.l d0,d4
     390:	add.l d1,d4
     392:	move.l d4,1da94 <BmpUpperPart_PF2+0x20>
	for (int p = 0; p < img->Bpls; p++)
     398:	moveq #4,d4
     39a:	cmp.l d2,d4
     39c:	beq.s 3dc <main+0x368>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     39e:	add.l d3,d1
     3a0:	move.l d0,d4
     3a2:	add.l d1,d4
     3a4:	move.l d4,1da98 <BmpUpperPart_PF2+0x24>
	for (int p = 0; p < img->Bpls; p++)
     3aa:	moveq #5,d4
     3ac:	cmp.l d2,d4
     3ae:	beq.s 3dc <main+0x368>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3b0:	add.l d3,d1
     3b2:	move.l d0,d4
     3b4:	add.l d1,d4
     3b6:	move.l d4,1da9c <BmpUpperPart_PF2+0x28>
	for (int p = 0; p < img->Bpls; p++)
     3bc:	moveq #6,d4
     3be:	cmp.l d2,d4
     3c0:	beq.s 3dc <main+0x368>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3c2:	add.l d3,d1
     3c4:	move.l d0,d4
     3c6:	add.l d1,d4
     3c8:	move.l d4,1daa0 <BmpUpperPart_PF2+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     3ce:	subq.l #7,d2
     3d0:	beq.s 3dc <main+0x368>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3d2:	add.l d3,d1
     3d4:	add.l d1,d0
     3d6:	move.l d0,1daa4 <BmpUpperPart_PF2+0x30>
	for (int p = 0; p < img->Bpls; p++)
     3dc:	moveq #0,d1
     3de:	move.w 1da44 <BmpScroller+0x4>,d1
     3e4:	tst.l d1
     3e6:	beq.w 478 <main+0x404>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3ea:	movea.l 1da50 <BmpScroller+0x10>,a0
     3f0:	moveq #0,d2
     3f2:	move.w 1da48 <BmpScroller+0x8>,d2
     3f8:	move.l a0,1da54 <BmpScroller+0x14>
	for (int p = 0; p < img->Bpls; p++)
     3fe:	moveq #1,d0
     400:	cmp.l d1,d0
     402:	beq.s 478 <main+0x404>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     404:	lea (0,a0,d2.l),a1
     408:	move.l a1,1da58 <BmpScroller+0x18>
	for (int p = 0; p < img->Bpls; p++)
     40e:	moveq #2,d0
     410:	cmp.l d1,d0
     412:	beq.s 478 <main+0x404>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     414:	move.l d2,d0
     416:	add.l d2,d0
     418:	lea (0,a0,d0.l),a1
     41c:	move.l a1,1da5c <BmpScroller+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     422:	moveq #3,d3
     424:	cmp.l d1,d3
     426:	beq.s 478 <main+0x404>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     428:	add.l d2,d0
     42a:	lea (0,a0,d0.l),a1
     42e:	move.l a1,1da60 <BmpScroller+0x20>
	for (int p = 0; p < img->Bpls; p++)
     434:	moveq #4,d3
     436:	cmp.l d1,d3
     438:	beq.s 478 <main+0x404>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     43a:	add.l d2,d0
     43c:	lea (0,a0,d0.l),a1
     440:	move.l a1,1da64 <BmpScroller+0x24>
	for (int p = 0; p < img->Bpls; p++)
     446:	moveq #5,d3
     448:	cmp.l d1,d3
     44a:	beq.s 478 <main+0x404>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     44c:	add.l d2,d0
     44e:	lea (0,a0,d0.l),a1
     452:	move.l a1,1da68 <BmpScroller+0x28>
	for (int p = 0; p < img->Bpls; p++)
     458:	moveq #6,d3
     45a:	cmp.l d1,d3
     45c:	beq.s 478 <main+0x404>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     45e:	add.l d2,d0
     460:	lea (0,a0,d0.l),a1
     464:	move.l a1,1da6c <BmpScroller+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     46a:	subq.l #7,d1
     46c:	beq.s 478 <main+0x404>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     46e:	add.l d2,d0
     470:	add.l a0,d0
     472:	move.l d0,1da70 <BmpScroller+0x30>
	for (int p = 0; p < img->Bpls; p++)
     478:	moveq #0,d1
     47a:	move.w 1da10 <BmpFont32+0x4>,d1
     480:	tst.l d1
     482:	beq.w 530 <main+0x4bc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     486:	moveq #0,d2
     488:	move.w 1da14 <BmpFont32+0x8>,d2
     48e:	move.l #34418,1da20 <BmpFont32+0x14>
	for (int p = 0; p < img->Bpls; p++)
     498:	moveq #1,d4
     49a:	cmp.l d1,d4
     49c:	beq.w 530 <main+0x4bc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4a0:	move.l d2,d0
     4a2:	addi.l #34418,d0
     4a8:	move.l d0,1da24 <BmpFont32+0x18>
	for (int p = 0; p < img->Bpls; p++)
     4ae:	moveq #2,d3
     4b0:	cmp.l d1,d3
     4b2:	beq.s 530 <main+0x4bc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4b4:	move.l d2,d0
     4b6:	add.l d2,d0
     4b8:	move.l d0,d4
     4ba:	addi.l #34418,d4
     4c0:	move.l d4,1da28 <BmpFont32+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     4c6:	moveq #3,d3
     4c8:	cmp.l d1,d3
     4ca:	beq.s 530 <main+0x4bc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4cc:	add.l d2,d0
     4ce:	move.l d0,d4
     4d0:	addi.l #34418,d4
     4d6:	move.l d4,1da2c <BmpFont32+0x20>
	for (int p = 0; p < img->Bpls; p++)
     4dc:	moveq #4,d3
     4de:	cmp.l d1,d3
     4e0:	beq.s 530 <main+0x4bc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4e2:	add.l d2,d0
     4e4:	move.l d0,d4
     4e6:	addi.l #34418,d4
     4ec:	move.l d4,1da30 <BmpFont32+0x24>
	for (int p = 0; p < img->Bpls; p++)
     4f2:	moveq #5,d3
     4f4:	cmp.l d1,d3
     4f6:	beq.s 530 <main+0x4bc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4f8:	add.l d2,d0
     4fa:	move.l d0,d4
     4fc:	addi.l #34418,d4
     502:	move.l d4,1da34 <BmpFont32+0x28>
	for (int p = 0; p < img->Bpls; p++)
     508:	moveq #6,d3
     50a:	cmp.l d1,d3
     50c:	beq.s 530 <main+0x4bc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     50e:	add.l d2,d0
     510:	move.l d0,d4
     512:	addi.l #34418,d4
     518:	move.l d4,1da38 <BmpFont32+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     51e:	subq.l #7,d1
     520:	beq.s 530 <main+0x4bc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     522:	add.l d2,d0
     524:	addi.l #34418,d0
     52a:	move.l d0,1da3c <BmpFont32+0x30>
	for (int p = 0; p < img->Bpls; p++)
     530:	moveq #0,d1
     532:	move.w 1d9dc <BmpCookie+0x4>,d1
     538:	tst.l d1
     53a:	beq.w 5e8 <main+0x574>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     53e:	moveq #0,d2
     540:	move.w 1d9e0 <BmpCookie+0x8>,d2
     546:	move.l #65140,1d9ec <BmpCookie+0x14>
	for (int p = 0; p < img->Bpls; p++)
     550:	moveq #1,d4
     552:	cmp.l d1,d4
     554:	beq.w 5e8 <main+0x574>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     558:	move.l d2,d0
     55a:	addi.l #65140,d0
     560:	move.l d0,1d9f0 <BmpCookie+0x18>
	for (int p = 0; p < img->Bpls; p++)
     566:	moveq #2,d3
     568:	cmp.l d1,d3
     56a:	beq.s 5e8 <main+0x574>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     56c:	move.l d2,d0
     56e:	add.l d2,d0
     570:	move.l d0,d4
     572:	addi.l #65140,d4
     578:	move.l d4,1d9f4 <BmpCookie+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     57e:	moveq #3,d3
     580:	cmp.l d1,d3
     582:	beq.s 5e8 <main+0x574>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     584:	add.l d2,d0
     586:	move.l d0,d4
     588:	addi.l #65140,d4
     58e:	move.l d4,1d9f8 <BmpCookie+0x20>
	for (int p = 0; p < img->Bpls; p++)
     594:	moveq #4,d3
     596:	cmp.l d1,d3
     598:	beq.s 5e8 <main+0x574>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     59a:	add.l d2,d0
     59c:	move.l d0,d4
     59e:	addi.l #65140,d4
     5a4:	move.l d4,1d9fc <BmpCookie+0x24>
	for (int p = 0; p < img->Bpls; p++)
     5aa:	moveq #5,d3
     5ac:	cmp.l d1,d3
     5ae:	beq.s 5e8 <main+0x574>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5b0:	add.l d2,d0
     5b2:	move.l d0,d4
     5b4:	addi.l #65140,d4
     5ba:	move.l d4,1da00 <BmpCookie+0x28>
	for (int p = 0; p < img->Bpls; p++)
     5c0:	moveq #6,d3
     5c2:	cmp.l d1,d3
     5c4:	beq.s 5e8 <main+0x574>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5c6:	add.l d2,d0
     5c8:	move.l d0,d4
     5ca:	addi.l #65140,d4
     5d0:	move.l d4,1da04 <BmpCookie+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     5d6:	subq.l #7,d1
     5d8:	beq.s 5e8 <main+0x574>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5da:	add.l d2,d0
     5dc:	addi.l #65140,d0
     5e2:	move.l d0,1da08 <BmpCookie+0x30>
	for (int p = 0; p < img->Bpls; p++)
     5e8:	moveq #0,d1
     5ea:	move.w 1d9a8 <BmpCookieMask+0x4>,d1
     5f0:	tst.l d1
     5f2:	beq.w 6a0 <main+0x62c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     5f6:	moveq #0,d2
     5f8:	move.w 1d9ac <BmpCookieMask+0x8>,d2
     5fe:	move.l #95862,1d9b8 <BmpCookieMask+0x14>
	for (int p = 0; p < img->Bpls; p++)
     608:	moveq #1,d4
     60a:	cmp.l d1,d4
     60c:	beq.w 6a0 <main+0x62c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     610:	move.l d2,d0
     612:	addi.l #95862,d0
     618:	move.l d0,1d9bc <BmpCookieMask+0x18>
	for (int p = 0; p < img->Bpls; p++)
     61e:	moveq #2,d3
     620:	cmp.l d1,d3
     622:	beq.s 6a0 <main+0x62c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     624:	move.l d2,d0
     626:	add.l d2,d0
     628:	move.l d0,d4
     62a:	addi.l #95862,d4
     630:	move.l d4,1d9c0 <BmpCookieMask+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     636:	moveq #3,d3
     638:	cmp.l d1,d3
     63a:	beq.s 6a0 <main+0x62c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     63c:	add.l d2,d0
     63e:	move.l d0,d4
     640:	addi.l #95862,d4
     646:	move.l d4,1d9c4 <BmpCookieMask+0x20>
	for (int p = 0; p < img->Bpls; p++)
     64c:	moveq #4,d3
     64e:	cmp.l d1,d3
     650:	beq.s 6a0 <main+0x62c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     652:	add.l d2,d0
     654:	move.l d0,d4
     656:	addi.l #95862,d4
     65c:	move.l d4,1d9c8 <BmpCookieMask+0x24>
	for (int p = 0; p < img->Bpls; p++)
     662:	moveq #5,d3
     664:	cmp.l d1,d3
     666:	beq.s 6a0 <main+0x62c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     668:	add.l d2,d0
     66a:	move.l d0,d4
     66c:	addi.l #95862,d4
     672:	move.l d4,1d9cc <BmpCookieMask+0x28>
	for (int p = 0; p < img->Bpls; p++)
     678:	moveq #6,d3
     67a:	cmp.l d1,d3
     67c:	beq.s 6a0 <main+0x62c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     67e:	add.l d2,d0
     680:	move.l d0,d4
     682:	addi.l #95862,d4
     688:	move.l d4,1d9d0 <BmpCookieMask+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     68e:	subq.l #7,d1
     690:	beq.s 6a0 <main+0x62c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     692:	add.l d2,d0
     694:	addi.l #95862,d0
     69a:	move.l d0,1d9d4 <BmpCookieMask+0x30>
	ActiView = GfxBase->ActiView; //store current view
     6a0:	movea.l 1db48 <GfxBase>,a6
     6a6:	move.l 34(a6),1d98c <ActiView>
	OwnBlitter();
     6ae:	jsr -456(a6)
	WaitBlit();
     6b2:	movea.l 1db48 <GfxBase>,a6
     6b8:	jsr -228(a6)
	Disable();
     6bc:	movea.l 1db4c <SysBase>,a6
     6c2:	jsr -120(a6)
	SystemADKCON = custom->adkconr;
     6c6:	movea.l 1db52 <custom>,a2
     6cc:	move.w 16(a2),d0
     6d0:	move.w d0,1d990 <SystemADKCON>
	SystemInts = custom->intenar;
     6d6:	move.w 28(a2),d0
     6da:	move.w d0,1d994 <SystemInts>
	SystemDMA = custom->dmaconr;
     6e0:	move.w 2(a2),d0
     6e4:	move.w d0,1d992 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     6ea:	move.w #32767,154(a2)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     6f0:	move.w #32767,156(a2)
	WaitVbl();
     6f6:	lea 13e6 <WaitVbl>,a4
     6fc:	jsr (a4)
	WaitVbl();
     6fe:	jsr (a4)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     700:	move.w #32767,150(a2)
	for (int a = 0; a < 32; a++)
     706:	moveq #0,d1
		custom->color[a] = 0;
     708:	move.l d1,d0
     70a:	addi.l #192,d0
     710:	add.l d0,d0
     712:	move.w #0,(0,a2,d0.l)
	for (int a = 0; a < 32; a++)
     718:	addq.l #1,d1
     71a:	moveq #32,d4
     71c:	cmp.l d1,d4
     71e:	bne.s 708 <main+0x694>
	LoadView(0);
     720:	movea.l 1db48 <GfxBase>,a6
     726:	suba.l a1,a1
     728:	jsr -222(a6)
	WaitTOF();
     72c:	movea.l 1db48 <GfxBase>,a6
     732:	jsr -270(a6)
	WaitTOF();
     736:	movea.l 1db48 <GfxBase>,a6
     73c:	jsr -270(a6)
	WaitVbl();
     740:	jsr (a4)
	WaitVbl();
     742:	jsr (a4)
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     744:	move.w #20090,50(sp)
     74a:	move.w #2049,52(sp)
     750:	move.w #20083,54(sp)
	if (SysBase->AttnFlags & AFF_68010)
     756:	movea.l 1db4c <SysBase>,a6
     75c:	btst #0,297(a6)
     762:	beq.w 1382 <main+0x130e>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     766:	moveq #50,d7
     768:	add.l sp,d7
     76a:	exg d7,a5
     76c:	jsr -30(a6)
     770:	exg d7,a5
	VBR = GetVBR();
     772:	move.l d0,1d99a <VBR>
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     778:	movea.l 1d99a <VBR>,a0
     77e:	move.l 108(a0),d0
	SystemIrq = GetInterruptHandler(); //store interrupt register
     782:	move.l d0,1d996 <SystemIrq>
	WaitVbl();
     788:	jsr (a4)
	SetupCopper(copPtr);
     78a:	movea.l 1d99e <copPtr>,a2
	*copPtr++ = DIWSTRT;
     790:	move.w #142,(a2)
	*copPtr++ = 0x2c81;
     794:	move.w #11393,2(a2)
	*copPtr++ = DIWSTOP;
     79a:	move.w #144,4(a2)
	*copPtr++ = 0x2cc1;
     7a0:	move.w #11457,6(a2)
	*copPtr++ = DDFSTRT;
     7a6:	move.w #146,8(a2)
	*copPtr++ = 0x38; // + ((Screen.Width - BmpLogo.Width) / 4);
     7ac:	move.w #56,10(a2)
	*copPtr++ = DDFSTOP;
     7b2:	move.w #148,12(a2)
	*copPtr++ = 0xd0; // - ((Screen.Width - BmpLogo.Width) / 4);
     7b8:	move.w #208,14(a2)
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl);
     7be:	move.w 1dab0 <BmpUpperPart_PF1+0x8>,d5
     7c4:	move.w 1dab2 <BmpUpperPart_PF1+0xa>,d0
     7ca:	sub.w d5,d0
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     7cc:	move.w #264,16(a2)
    *copListEnd++ = modOdd;
     7d2:	move.w d0,18(a2)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     7d6:	move.w #266,20(a2)
    *copListEnd++ = modEven;
     7dc:	move.w d0,22(a2)
	*copPtr++ = BPLCON1; //scrolling
     7e0:	move.w #258,24(a2)
	*copPtr++ = 0;
     7e6:	clr.w 26(a2)
	*copPtr++ = BPLCON2; //playfied priority
     7ea:	move.w #260,28(a2)
	*copPtr++ = 1 << 6;	 //0x24;  Sprites have priority over playfields
     7f0:	move.w #64,30(a2)
    *copListEnd++ = COP_WAIT;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     7f6:	move.w #384,32(a2)
    *copListCurrent++ = color;
     7fc:	clr.w 34(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     800:	move.w #386,36(a2)
    *copListCurrent++ = color;
     806:	move.w #4095,38(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     80c:	move.w #388,40(a2)
    *copListCurrent++ = color;
     812:	move.w #2592,42(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     818:	move.w #390,44(a2)
    *copListCurrent++ = color;
     81e:	move.w #2880,46(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     824:	move.w #392,48(a2)
    *copListCurrent++ = color;
     82a:	move.w #3184,50(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     830:	move.w #394,52(a2)
    *copListCurrent++ = color;
     836:	move.w #3472,54(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     83c:	move.w #396,56(a2)
    *copListCurrent++ = color;
     842:	move.w #3760,58(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     848:	move.w #398,60(a2)
    *copListCurrent++ = color;
     84e:	move.w #128,62(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     854:	move.w #400,64(a2)
    *copListCurrent++ = color;
     85a:	clr.w 66(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     85e:	move.w #402,68(a2)
    *copListCurrent++ = color;
     864:	move.w #1366,70(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     86a:	move.w #404,72(a2)
    *copListCurrent++ = color;
     870:	move.w #3221,74(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     876:	move.w #406,76(a2)
    *copListCurrent++ = color;
     87c:	move.w #3750,78(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     882:	move.w #408,80(a2)
    *copListCurrent++ = color;
     888:	move.w #1074,82(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     88e:	move.w #410,84(a2)
    *copListCurrent++ = color;
     894:	move.w #1329,86(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     89a:	move.w #412,88(a2)
    *copListCurrent++ = color;
     8a0:	move.w #530,90(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     8a6:	move.w #414,92(a2)
    *copListCurrent++ = color;
     8ac:	lea 96(a2),a0
     8b0:	move.w #2177,94(a2)
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, TRUE);
     8b6:	move.w 1daac <BmpUpperPart_PF1+0x4>,d6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     8bc:	move.l 1dab8 <BmpUpperPart_PF1+0x10>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     8c2:	tst.w d6
     8c4:	beq.s 916 <main+0x8a2>
        addr += Bpl;
     8c6:	andi.l #65535,d5
     8cc:	move.w d6,d4
     8ce:	subq.w #1,d4
     8d0:	andi.l #65535,d4
     8d6:	moveq #13,d0
     8d8:	add.l d0,d4
     8da:	lsl.l #3,d4
     8dc:	add.l a2,d4
    *copListCurrent++ = color;
     8de:	movea.l a0,a1
    BYTE plane = odd ? 1 : 0;
     8e0:	moveq #1,d2
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     8e2:	move.b d2,d0
     8e4:	ext.w d0
     8e6:	lsl.w #2,d0
     8e8:	addi.w #224,d0
     8ec:	move.w d0,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     8ee:	move.l d1,d3
     8f0:	clr.w d3
     8f2:	swap d3
     8f4:	move.w d3,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     8f8:	addq.w #2,d0
     8fa:	move.w d0,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     8fe:	addq.l #8,a1
     900:	move.w d1,-2(a1)
        addr += Bpl;
     904:	add.l d5,d1
        plane += 2;
     906:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     908:	cmpa.l d4,a1
     90a:	bne.s 8e2 <main+0x86e>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     90c:	andi.l #65535,d6
     912:	lsl.l #3,d6
     914:	adda.l d6,a0
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, FALSE);
     916:	move.w 1da7c <BmpUpperPart_PF2+0x8>,d4
     91c:	move.w 1da78 <BmpUpperPart_PF2+0x4>,d0
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     922:	move.l 1da84 <BmpUpperPart_PF2+0x10>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     928:	tst.w d0
     92a:	beq.w 139c <main+0x1328>
        addr += Bpl;
     92e:	andi.l #65535,d4
     934:	andi.l #65535,d0
     93a:	lsl.l #3,d0
     93c:	lea (0,a0,d0.l),a1
    BYTE plane = odd ? 1 : 0;
     940:	clr.b d2
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     942:	move.b d2,d0
     944:	ext.w d0
     946:	lsl.w #2,d0
     948:	addi.w #224,d0
     94c:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     94e:	move.l d1,d3
     950:	clr.w d3
     952:	swap d3
     954:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     958:	addq.w #2,d0
     95a:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     95e:	addq.l #8,a0
     960:	move.w d1,-2(a0)
        addr += Bpl;
     964:	add.l d4,d1
        plane += 2;
     966:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     968:	cmpa.l a0,a1
     96a:	bne.s 942 <main+0x8ce>
	*copPtr++ = BPLCON0;
     96c:	move.w #256,(a1)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     970:	moveq #0,d5
     972:	move.w 1dae0 <BmpLogo+0x4>,d5
     978:	move.l d5,d0
     97a:	moveq #13,d1
     97c:	lsl.l d1,d0
     97e:	ori.w #1536,d0
     982:	move.w d0,2(a1)
	copPtr = copWaitY(copPtr, 0x2c + BmpUpperPart_PF1.Height);
     986:	move.w 1daaa <BmpUpperPart_PF1+0x2>,d0
     98c:	addi.w #44,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     990:	lsl.w #8,d0
     992:	ori.w #5,d0
     996:	move.w d0,4(a1)
    *copListEnd++ = COP_WAIT;
     99a:	move.w #-2,6(a1)
						  BmpScroller.Bplt - Screen.Bpl);
     9a0:	move.w 1da4a <BmpScroller+0xa>,d0
     9a6:	sub.w 1db18 <Screen+0x8>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     9ac:	move.w #264,8(a1)
    *copListEnd++ = modOdd;
     9b2:	move.w d0,10(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     9b6:	move.w #266,12(a1)
    *copListEnd++ = modEven;
     9bc:	lea 16(a1),a3
     9c0:	move.w d0,14(a1)
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     9c4:	move.l a3,1d986 <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     9ca:	move.w 1da48 <BmpScroller+0x8>,d3
     9d0:	move.w 1da44 <BmpScroller+0x4>,d4
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     9d6:	move.l 1da50 <BmpScroller+0x10>,d0
    for (USHORT i = 0; i < numPlanes; i++)
     9dc:	tst.w d4
     9de:	beq.s a28 <main+0x9b4>
        addr += Bpl;
     9e0:	andi.l #65535,d3
     9e6:	move.w d4,d1
     9e8:	subq.w #1,d1
     9ea:	andi.l #65535,d1
     9f0:	addq.l #3,d1
     9f2:	lsl.l #3,d1
     9f4:	adda.l d1,a1
     9f6:	movea.l a3,a0
     9f8:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     9fc:	move.w d1,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     9fe:	move.l d0,d2
     a00:	clr.w d2
     a02:	swap d2
     a04:	move.w d2,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     a08:	move.w d1,d2
     a0a:	addq.w #2,d2
     a0c:	move.w d2,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     a10:	addq.l #8,a0
     a12:	move.w d0,-2(a0)
        addr += Bpl;
     a16:	add.l d3,d0
    for (USHORT i = 0; i < numPlanes; i++)
     a18:	addq.w #4,d1
     a1a:	cmpa.l a0,a1
     a1c:	bne.s 9fc <main+0x988>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     a1e:	andi.l #65535,d4
     a24:	lsl.l #3,d4
     a26:	adda.l d4,a3
	*copPtr++ = BPLCON0;
     a28:	move.w #256,(a3)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     a2c:	moveq #12,d3
     a2e:	lsl.l d3,d5
     a30:	ori.w #512,d5
     a34:	move.w d5,2(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     a38:	move.w #384,4(a3)
    *copListCurrent++ = color;
     a3e:	clr.w 6(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     a42:	move.w #386,8(a3)
    *copListCurrent++ = color;
     a48:	move.w #23,10(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     a4e:	move.w #388,12(a3)
    *copListCurrent++ = color;
     a54:	move.w #601,14(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     a5a:	move.w #390,16(a3)
    *copListCurrent++ = color;
     a60:	move.w #874,18(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     a66:	move.w #392,20(a3)
    *copListCurrent++ = color;
     a6c:	move.w #1163,22(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     a72:	move.w #394,24(a3)
    *copListCurrent++ = color;
     a78:	move.w #1469,26(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     a7e:	move.w #396,28(a3)
    *copListCurrent++ = color;
     a84:	move.w #1758,30(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     a8a:	move.w #398,32(a3)
    *copListCurrent++ = color;
     a90:	move.w #2303,34(a3)
	copPtr = copWaitY(copPtr, 0x2c + BmpLogo.Height + 64);
     a96:	move.w 1dade <BmpLogo+0x2>,d0
     a9c:	addi.w #108,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     aa0:	lsl.w #8,d0
     aa2:	ori.w #5,d0
     aa6:	move.w d0,36(a3)
    *copListEnd++ = COP_WAIT;
     aaa:	move.w #-2,38(a3)
     ab0:	lea 40(a3),a0
     ab4:	move.l a0,1d97c <copMirrorBmpP>
						  (BmpLogo.Bplt - BmpLogo.Bpl));
     aba:	move.w 1dae6 <BmpLogo+0xa>,d0
     ac0:	sub.w 1dae4 <BmpLogo+0x8>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     ac6:	move.w #264,40(a3)
    *copListEnd++ = modOdd;
     acc:	move.w d0,42(a3)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     ad0:	move.w #266,44(a3)
    *copListEnd++ = modEven;
     ad6:	move.w d0,46(a3)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     ada:	move.w #-1,48(a3)
    *copListEnd++ = COP_WAIT;
     ae0:	move.w #-2,50(a3)
	custom->cop1lc = (ULONG)copPtr;
     ae6:	movea.l 1db52 <custom>,a0
     aec:	move.l a2,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
     af0:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
     af6:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER;
     afc:	move.w #-31808,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     b02:	movea.l 1d99a <VBR>,a1
     b08:	move.l #5028,108(a1)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
     b10:	move.w #-16352,154(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
     b16:	move.w #-24576,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
     b1c:	move.w #32,156(a0)
	register volatile const void *_a0 ASM("a0") = module;
     b22:	lea 19e78 <incbin_module_start>,a0
	register volatile const void *_a1 ASM("a1") = NULL;
     b28:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
     b2a:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
     b2c:	lea 199a <incbin_P61_Player_start>,a3
	__asm volatile(
     b32:	movem.l d1-d7/a4-a6,-(sp)
     b36:	jsr (a3)
     b38:	movem.l (sp)+,d1-d7/a4-a6
	if (p61Init(module) != 0)
     b3c:	tst.l d0
     b3e:	bne.w 1312 <main+0x129e>
	Point2D ps2 = {0, 32};
     b42:	clr.l d2
     b44:	moveq #32,d3
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
     b46:	move.w 1dae0 <BmpLogo+0x4>,d5
     b4c:	move.w 1dae4 <BmpLogo+0x8>,d4
     b52:	move.l 1daec <BmpLogo+0x10>,d6
     b58:	movea.w 1dab0 <BmpUpperPart_PF1+0x8>,a1
     b5e:	move.l 1dab8 <BmpUpperPart_PF1+0x10>,d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     b64:	movea.l 1db52 <custom>,a0
     b6a:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     b6e:	move.w 2(a0),d0
     b72:	btst #14,d0
     b76:	bne.s b6e <main+0xafa>
	custom->bltcon0 = 0x09f0;
     b78:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     b7e:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     b84:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     b8a:	move.w #-1,70(a0)
	custom->bltamod = imgA.Bpl - (width / 8);
     b90:	addi.w #-32,d4
     b94:	move.w d4,100(a0)
	custom->bltdmod = imgD.Bpl - (width / 8);
     b98:	lea -32(a1),a1
     b9c:	move.w a1,102(a0)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
     ba0:	move.l d6,80(a0)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
     ba4:	addq.l #4,d1
     ba6:	move.l d1,84(a0)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
     baa:	move.w d5,d0
     bac:	lsl.w #6,d0
     bae:	add.w d5,d0
     bb0:	lsl.w #7,d0
     bb2:	addi.w #16,d0
     bb6:	move.w d0,88(a0)
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd2, 32, 32);
     bba:	move.w 1d9dc <BmpCookie+0x4>,d4
     bc0:	move.w 1d9e0 <BmpCookie+0x8>,d5
     bc6:	move.w 1d9e2 <BmpCookie+0xa>,d6
     bcc:	move.l 1d9e8 <BmpCookie+0x10>,d7
     bd2:	movea.w 1da7c <BmpUpperPart_PF2+0x8>,a3
     bd8:	movea.w 1da7e <BmpUpperPart_PF2+0xa>,a5
     bde:	movea.l 1da84 <BmpUpperPart_PF2+0x10>,a6
     be4:	clr.l -(sp)
     be6:	pea 20 <_start+0x20>
     bea:	move.l d3,-(sp)
     bec:	move.l d2,-(sp)
     bee:	move.l a6,-(sp)
     bf0:	move.l a5,-(sp)
     bf2:	move.l a3,-(sp)
     bf4:	move.l d7,-(sp)
     bf6:	move.l d6,-(sp)
     bf8:	move.l d5,-(sp)
     bfa:	move.l d4,-(sp)
     bfc:	lea 149e <BetterBlit.constprop.0.isra.0>,a2
     c02:	jsr (a2)
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd3, 32, 32);
     c04:	lea 40(sp),sp
     c08:	clr.l (sp)
     c0a:	pea e0 <main+0x6c>
     c0e:	move.l d3,-(sp)
     c10:	move.l d2,-(sp)
     c12:	move.l a6,-(sp)
     c14:	move.l a5,-(sp)
     c16:	move.l a3,-(sp)
     c18:	move.l d7,-(sp)
     c1a:	move.l d6,-(sp)
     c1c:	move.l d5,-(sp)
     c1e:	move.l d4,-(sp)
     c20:	jsr (a2)
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd4, 32, 32);
     c22:	lea 44(sp),sp
     c26:	pea 10 <_start+0x10>
     c2a:	pea 20 <_start+0x20>
     c2e:	move.l d3,-(sp)
     c30:	move.l d2,-(sp)
     c32:	move.l a6,-(sp)
     c34:	move.l a5,-(sp)
     c36:	move.l a3,-(sp)
     c38:	move.l d7,-(sp)
     c3a:	move.l d6,-(sp)
     c3c:	move.l d5,-(sp)
     c3e:	move.l d4,-(sp)
     c40:	jsr (a2)
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd5, 32, 32);
     c42:	lea 44(sp),sp
     c46:	pea 10 <_start+0x10>
     c4a:	pea e0 <main+0x6c>
     c4e:	move.l d3,-(sp)
     c50:	move.l d2,-(sp)
     c52:	move.l a6,-(sp)
     c54:	move.l a5,-(sp)
     c56:	move.l a3,-(sp)
     c58:	move.l d7,-(sp)
     c5a:	move.l d6,-(sp)
     c5c:	move.l d5,-(sp)
     c5e:	move.l d4,-(sp)
     c60:	jsr (a2)
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd6, 32, 32);
     c62:	lea 44(sp),sp
     c66:	pea 20 <_start+0x20>
     c6a:	pea 20 <_start+0x20>
     c6e:	move.l d3,-(sp)
     c70:	move.l d2,-(sp)
     c72:	move.l a6,-(sp)
     c74:	move.l a5,-(sp)
     c76:	move.l a3,-(sp)
     c78:	move.l d7,-(sp)
     c7a:	move.l d6,-(sp)
     c7c:	move.l d5,-(sp)
     c7e:	move.l d4,-(sp)
     c80:	jsr (a2)
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd7, 32, 32);
     c82:	lea 44(sp),sp
     c86:	pea 20 <_start+0x20>
     c8a:	pea e0 <main+0x6c>
     c8e:	move.l d3,-(sp)
     c90:	move.l d2,-(sp)
     c92:	move.l a6,-(sp)
     c94:	move.l a5,-(sp)
     c96:	move.l a3,-(sp)
     c98:	move.l d7,-(sp)
     c9a:	move.l d6,-(sp)
     c9c:	move.l d5,-(sp)
     c9e:	move.l d4,-(sp)
     ca0:	jsr (a2)
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd8, 32, 32);
     ca2:	lea 44(sp),sp
     ca6:	pea 30 <_start+0x30>
     caa:	pea 20 <_start+0x20>
     cae:	move.l d3,-(sp)
     cb0:	move.l d2,-(sp)
     cb2:	move.l a6,-(sp)
     cb4:	move.l a5,-(sp)
     cb6:	move.l a3,-(sp)
     cb8:	move.l d7,-(sp)
     cba:	move.l d6,-(sp)
     cbc:	move.l d5,-(sp)
     cbe:	move.l d4,-(sp)
     cc0:	jsr (a2)
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd9, 32, 32);
     cc2:	lea 44(sp),sp
     cc6:	pea 30 <_start+0x30>
     cca:	pea e0 <main+0x6c>
     cce:	move.l d3,-(sp)
     cd0:	move.l d2,-(sp)
     cd2:	move.l a6,-(sp)
     cd4:	move.l a5,-(sp)
     cd6:	move.l a3,-(sp)
     cd8:	move.l d7,-(sp)
     cda:	move.l d6,-(sp)
     cdc:	move.l d5,-(sp)
     cde:	move.l d4,-(sp)
     ce0:	jsr (a2)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
     ce2:	move.b bfe001 <_end+0xbe04a9>,d0
	while (!MouseLeft())
     ce8:	lea 44(sp),sp
     cec:	btst #6,d0
     cf0:	beq.w eae <main+0xe3a>
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
     cf4:	move.w 55ac <ScrollerY>,d5
		Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
     cfa:	move.l 1da50 <BmpScroller+0x10>,d3
     d00:	move.w 1da44 <BmpScroller+0x4>,d4
     d06:	lea 1da40 <BmpScroller>,a3
     d0c:	lea 17bc <__mulsi3>,a2
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     d12:	lea 335b <Scrolltext>,a5
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     d18:	move.l dff004 <_end+0xde14ac>,d0
     d1e:	move.l d0,50(sp)
		vpos &= 0x1ff00;
     d22:	move.l 50(sp),d0
     d26:	andi.l #130816,d0
     d2c:	move.l d0,50(sp)
		if (vpos != (311 << 8))
     d30:	move.l 50(sp),d0
     d34:	cmpi.l #79616,d0
     d3a:	beq.s d18 <main+0xca4>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     d3c:	move.l dff004 <_end+0xde14ac>,d0
     d42:	move.l d0,46(sp)
		vpos &= 0x1ff00;
     d46:	move.l 46(sp),d0
     d4a:	andi.l #130816,d0
     d50:	move.l d0,46(sp)
		if (vpos == (311 << 8))
     d54:	move.l 46(sp),d0
     d58:	cmpi.l #79616,d0
     d5e:	bne.s d3c <main+0xcc8>
		if (BounceEnabled)
     d60:	tst.w 1d98a <BounceEnabled>
     d66:	beq.s da0 <main+0xd2c>
			if (ScrollerDir > 0)
     d68:	move.b 55ae <ScrollerDir>,d0
     d6e:	ble.w 1280 <main+0x120c>
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
     d72:	pea c <_start+0xc>
     d76:	movea.w #40,a1
     d7a:	suba.w d5,a1
     d7c:	move.l a1,-(sp)
     d7e:	jsr 183a <__divsi3>
     d84:	addq.l #8,sp
				if (ScrollerDir > 6)
     d86:	cmpi.b #6,d0
     d8a:	ble.w 129e <main+0x122a>
					ScrollerDir = 6;
     d8e:	move.b #6,55ae <ScrollerDir>
     d96:	moveq #6,d0
			ScrollerY += ScrollerDir;
     d98:	add.w d0,d5
     d9a:	move.w d5,55ac <ScrollerY>
		if (ScrollerY >= ScrollerMax)
     da0:	movea.w d5,a0
     da2:	cmpi.w #39,d5
     da6:	ble.w 11ec <main+0x1178>
			ScrollerY = ScrollerMax;
     daa:	move.w #40,55ac <ScrollerY>
			ScrollerDir = -1;
     db2:	st 55ae <ScrollerDir>
		Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
     db8:	move.w 1da4a <BmpScroller+0xa>,d2
	int BltOffs = startY * theDesc.Bplt;
     dbe:	move.w d2,d5
     dc0:	mulu.w #40,d5
	int Brcorner = height * theDesc.Bplt - 2;
     dc4:	andi.l #65535,d2
     dca:	lsl.l #5,d2
     dcc:	subq.l #2,d2
	WaitBlit();
     dce:	movea.l 1db48 <GfxBase>,a6
     dd4:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     dd8:	movea.l 1db52 <custom>,a0
     dde:	move.w #18928,64(a0)
	custom->bltcon1 = 0x0002;
     de4:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     dea:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     df0:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     df6:	add.l d5,d2
     df8:	add.l d2,d3
     dfa:	move.l d3,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     dfe:	move.l d3,84(a0)
	custom->bltamod = 0;
     e02:	move.w #0,100(a0)
	custom->bltdmod = 0;
     e08:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
     e0e:	moveq #11,d0
     e10:	lsl.w d0,d4
     e12:	move.w (a3),d0
     e14:	lsr.w #4,d0
     e16:	add.w d0,d4
     e18:	move.w d4,88(a0)
	ScrollCnt += speed;
     e1c:	move.w 1d984 <ScrollCnt>,d0
     e22:	addq.w #4,d0
     e24:	move.w d0,1d984 <ScrollCnt>
	if (ScrollCnt >= 32)
     e2a:	cmpi.w #31,d0
     e2e:	bhi.w fd4 <main+0xf60>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
     e32:	move.w 1da48 <BmpScroller+0x8>,d2
     e38:	move.l 1da50 <BmpScroller+0x10>,d3
     e3e:	move.w 55ac <ScrollerY>,d5
     e44:	move.w 1da44 <BmpScroller+0x4>,d4
     e4a:	moveq #0,d6
     e4c:	move.w d4,d6
     e4e:	movea.l 1d986 <copScrollerBmpP>,a6
     e54:	andi.l #65535,d2
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     e5a:	move.l d2,-(sp)
     e5c:	movea.w d5,a0
     e5e:	move.l a0,-(sp)
     e60:	jsr (a2)
     e62:	addq.l #4,sp
     e64:	move.l d6,(sp)
     e66:	move.l d0,-(sp)
     e68:	jsr (a2)
     e6a:	addq.l #8,sp
     e6c:	add.l d3,d0
    for (USHORT i = 0; i < numPlanes; i++)
     e6e:	tst.l d6
     e70:	beq.s ea0 <main+0xe2c>
     e72:	suba.l a0,a0
        addr += Bpl;
     e74:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     e78:	move.w d1,(a6)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     e7a:	move.l d0,d7
     e7c:	clr.w d7
     e7e:	swap d7
     e80:	move.w d7,2(a6)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     e84:	movea.w d1,a1
     e86:	addq.w #2,a1
     e88:	move.w a1,4(a6)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     e8c:	addq.l #8,a6
     e8e:	move.w d0,-2(a6)
        addr += Bpl;
     e92:	add.l d2,d0
    for (USHORT i = 0; i < numPlanes; i++)
     e94:	addq.w #1,a0
     e96:	addq.w #4,d1
     e98:	moveq #0,d7
     e9a:	move.w a0,d7
     e9c:	cmp.l d6,d7
     e9e:	blt.s e78 <main+0xe04>
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
     ea0:	move.b bfe001 <_end+0xbe04a9>,d0
	while (!MouseLeft())
     ea6:	btst #6,d0
     eaa:	bne.w d18 <main+0xca4>
	register volatile const void *_a3 ASM("a3") = P61_Player;
     eae:	lea 199a <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
     eb4:	movea.l #14675968,a6
	__asm volatile(
     eba:	movem.l d0-d1/a0-a1,-(sp)
     ebe:	jsr 8(a3)
     ec2:	movem.l (sp)+,d0-d1/a0-a1
	FreeMem(copPtr, 1024);
     ec6:	movea.l 1db4c <SysBase>,a6
     ecc:	movea.l 1d99e <copPtr>,a1
     ed2:	move.l #1024,d0
     ed8:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
     edc:	movea.l 1db4c <SysBase>,a6
     ee2:	movea.l 1da50 <BmpScroller+0x10>,a1
     ee8:	moveq #0,d0
     eea:	move.w 1da4e <BmpScroller+0xe>,d0
     ef0:	jsr -210(a6)
	WaitVbl();
     ef4:	jsr (a4)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     ef6:	movea.l 1db52 <custom>,a0
     efc:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     f00:	move.w 2(a0),d0
     f04:	btst #14,d0
     f08:	bne.s f00 <main+0xe8c>
	custom->intena = 0x7fff; //disable all interrupts
     f0a:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     f10:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     f16:	move.w #32767,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     f1c:	movea.l 1d99a <VBR>,a1
     f22:	move.l 1d996 <SystemIrq>,108(a1)
	custom->cop1lc = (ULONG)GfxBase->copinit;
     f2a:	movea.l 1db48 <GfxBase>,a6
     f30:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     f36:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     f3c:	move.w #32767,136(a0)
	custom->intena = SystemInts | 0x8000;
     f42:	move.w 1d994 <SystemInts>,d0
     f48:	ori.w #-32768,d0
     f4c:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     f50:	move.w 1d992 <SystemDMA>,d0
     f56:	ori.w #-32768,d0
     f5a:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     f5e:	move.w 1d990 <SystemADKCON>,d0
     f64:	ori.w #-32768,d0
     f68:	move.w d0,158(a0)
	LoadView(ActiView);
     f6c:	movea.l 1d98c <ActiView>,a1
     f72:	jsr -222(a6)
	WaitTOF();
     f76:	movea.l 1db48 <GfxBase>,a6
     f7c:	jsr -270(a6)
	WaitTOF();
     f80:	movea.l 1db48 <GfxBase>,a6
     f86:	jsr -270(a6)
	WaitBlit();
     f8a:	movea.l 1db48 <GfxBase>,a6
     f90:	jsr -228(a6)
	DisownBlitter();
     f94:	movea.l 1db48 <GfxBase>,a6
     f9a:	jsr -462(a6)
	Enable();
     f9e:	movea.l 1db4c <SysBase>,a6
     fa4:	jsr -126(a6)
	CloseLibrary((struct Library *)DOSBase);
     fa8:	movea.l 1db4c <SysBase>,a6
     fae:	movea.l 1db44 <DOSBase>,a1
     fb4:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
     fb8:	movea.l 1db4c <SysBase>,a6
     fbe:	movea.l 1db48 <GfxBase>,a1
     fc4:	jsr -414(a6)
}
     fc8:	moveq #0,d0
     fca:	movem.l (sp)+,d2-d7/a2-a6
     fce:	lea 12(sp),sp
     fd2:	rts
		ScrollCnt = 0;
     fd4:	clr.w 1d984 <ScrollCnt>
		PlotChar(BmpFont32, (UBYTE *)BmpFont32P, BmpScroller, (UBYTE *)BmpScroller.ImageData, startY, 32, 32);
     fda:	move.l 1da50 <BmpScroller+0x10>,d3
     fe0:	move.w 1da10 <BmpFont32+0x4>,d5
     fe6:	move.w 1da14 <BmpFont32+0x8>,d6
     fec:	movea.w 1da16 <BmpFont32+0xa>,a1
     ff2:	move.w 1da48 <BmpScroller+0x8>,d2
     ff8:	move.w 1da4a <BmpScroller+0xa>,d7
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     ffe:	movea.w 1d982 <ScrolltextCnt>,a0
    1004:	move.w a0,d1
    1006:	addq.w #1,d1
    1008:	move.w d1,1d982 <ScrolltextCnt>
    100e:	moveq #0,d0
    1010:	move.w a0,d0
    1012:	move.b (0,a5,d0.l),d0
	if (chr == 'b')
    1016:	cmpi.b #98,d0
    101a:	beq.w 11a8 <main+0x1134>
	if (chr == 'm')
    101e:	cmpi.b #109,d0
    1022:	beq.w 10b2 <main+0x103e>
	if (chr == 0)
    1026:	tst.b d0
    1028:	bne.w 1106 <main+0x1092>
		chr = Scrolltext[ScrolltextCnt++];
    102c:	move.w #1,1d982 <ScrolltextCnt>
    1034:	moveq #0,d4
    1036:	moveq #4,d1
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    1038:	move.l d1,-(sp)
    103a:	move.w a1,-(sp)
    103c:	clr.w -(sp)
    103e:	jsr (a2)
    1040:	addq.l #8,sp
    1042:	lsl.l #5,d0
    1044:	add.l d0,d4
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    1046:	mulu.w #40,d7
    104a:	moveq #0,d0
    104c:	move.w 1db18 <Screen+0x8>,d0
    1052:	add.l d0,d7
	WaitBlit();
    1054:	movea.l 1db48 <GfxBase>,a6
    105a:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    105e:	movea.l 1db52 <custom>,a0
    1064:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
    106a:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
    1070:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
    1076:	move.w #-1,70(a0)
	custom->bltapt = bmpFontP + source;
    107c:	addi.l #34418,d4
    1082:	move.l d4,80(a0)
	custom->bltdpt = bmpDestP + dest;
    1086:	add.l d7,d3
    1088:	move.l d3,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    108c:	subq.w #4,d6
    108e:	move.w d6,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    1092:	subq.w #4,d2
    1094:	move.w d2,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    1098:	moveq #11,d0
    109a:	lsl.w d0,d5
    109c:	addq.w #2,d5
    109e:	move.w d5,88(a0)
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    10a2:	move.w 1da48 <BmpScroller+0x8>,d2
    10a8:	move.l 1da50 <BmpScroller+0x10>,d3
    10ae:	bra.w e3e <main+0xdca>
		if (MirrorEnabled)
    10b2:	move.w 1d980 <MirrorEnabled>,d0
				 BmpScroller.Bplt - Screen.Bpl);
    10b8:	move.w d7,d4
    10ba:	sub.w 1db18 <Screen+0x8>,d4
	copSetBplMod(0, copMirrorBmpP,
    10c0:	movea.l 1d97c <copMirrorBmpP>,a0
		if (MirrorEnabled)
    10c6:	tst.w d0
    10c8:	beq.w 12d4 <main+0x1260>
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    10cc:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    10d0:	move.w d4,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    10d4:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    10da:	move.w d4,6(a0)
		MirrorEnabled = !MirrorEnabled;
    10de:	tst.w d0
    10e0:	seq d0
    10e2:	ext.w d0
    10e4:	neg.w d0
    10e6:	move.w d0,1d980 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    10ec:	move.w d1,d4
    10ee:	addq.w #1,d4
    10f0:	move.w d4,1d982 <ScrolltextCnt>
    10f6:	andi.l #65535,d1
    10fc:	move.b (0,a5,d1.l),d0
	if (chr == 0)
    1100:	tst.b d0
    1102:	beq.w 102c <main+0xfb8>
	if (chr < 32 || chr > (32 + 80))
    1106:	addi.b #-32,d0
    110a:	cmpi.b #80,d0
    110e:	bhi.w e3e <main+0xdca>
	row = chr / 10;
    1112:	andi.w #255,d0
    1116:	move.w d0,d4
    1118:	mulu.w #-13107,d4
    111c:	clr.w d4
    111e:	swap d4
    1120:	lsr.w #3,d4
    1122:	moveq #0,d1
    1124:	move.b d4,d1
	col = chr % 10;
    1126:	movea.w d4,a0
    1128:	adda.w d4,a0
    112a:	adda.w a0,a0
    112c:	adda.w d4,a0
    112e:	adda.w a0,a0
    1130:	sub.w a0,d0
    1132:	moveq #0,d4
    1134:	move.b d0,d4
	source = (row * bmpFont.Bplt * charH) + (col << 2);
    1136:	add.l d4,d4
    1138:	add.l d4,d4
    113a:	move.l d1,-(sp)
    113c:	move.w a1,-(sp)
    113e:	clr.w -(sp)
    1140:	jsr (a2)
    1142:	addq.l #8,sp
    1144:	lsl.l #5,d0
    1146:	add.l d0,d4
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
    1148:	mulu.w #40,d7
    114c:	moveq #0,d0
    114e:	move.w 1db18 <Screen+0x8>,d0
    1154:	add.l d0,d7
	WaitBlit();
    1156:	movea.l 1db48 <GfxBase>,a6
    115c:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
    1160:	movea.l 1db52 <custom>,a0
    1166:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
    116c:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
    1172:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
    1178:	move.w #-1,70(a0)
	custom->bltapt = bmpFontP + source;
    117e:	addi.l #34418,d4
    1184:	move.l d4,80(a0)
	custom->bltdpt = bmpDestP + dest;
    1188:	add.l d7,d3
    118a:	move.l d3,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
    118e:	subq.w #4,d6
    1190:	move.w d6,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
    1194:	subq.w #4,d2
    1196:	move.w d2,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
    119a:	moveq #11,d0
    119c:	lsl.w d0,d5
    119e:	addq.w #2,d5
    11a0:	move.w d5,88(a0)
    11a4:	bra.w 10a2 <main+0x102e>
		if (BounceEnabled)
    11a8:	move.w 1d98a <BounceEnabled>,d0
    11ae:	beq.s 11be <main+0x114a>
			ScrollerY = ScrollerMax;
    11b0:	move.w #40,55ac <ScrollerY>
			ScrollerDir = -1;
    11b8:	st 55ae <ScrollerDir>
		BounceEnabled = !BounceEnabled;
    11be:	tst.w d0
    11c0:	seq d0
    11c2:	ext.w d0
    11c4:	neg.w d0
    11c6:	move.w d0,1d98a <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    11cc:	addq.w #2,a0
    11ce:	move.w a0,1d982 <ScrolltextCnt>
    11d4:	andi.l #65535,d1
    11da:	move.b (0,a5,d1.l),d0
    11de:	move.w a0,d1
	if (chr == 'm')
    11e0:	cmpi.b #109,d0
    11e4:	bne.w 1026 <main+0xfb2>
    11e8:	bra.w 10b2 <main+0x103e>
		else if (ScrollerY <= ScrollerMin)
    11ec:	cmpa.w #0,a0
    11f0:	bgt.w db8 <main+0xd44>
			ScrollerY = ScrollerMin;
    11f4:	clr.w 55ac <ScrollerY>
			ScrollerDir = 1;
    11fa:	move.b #1,55ae <ScrollerDir>
		Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    1202:	move.w 1da4a <BmpScroller+0xa>,d2
	int BltOffs = startY * theDesc.Bplt;
    1208:	move.w d2,d5
    120a:	mulu.w #40,d5
	int Brcorner = height * theDesc.Bplt - 2;
    120e:	andi.l #65535,d2
    1214:	lsl.l #5,d2
    1216:	subq.l #2,d2
	WaitBlit();
    1218:	movea.l 1db48 <GfxBase>,a6
    121e:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
    1222:	movea.l 1db52 <custom>,a0
    1228:	move.w #18928,64(a0)
	custom->bltcon1 = 0x0002;
    122e:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
    1234:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
    123a:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
    1240:	add.l d5,d2
    1242:	add.l d2,d3
    1244:	move.l d3,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
    1248:	move.l d3,84(a0)
	custom->bltamod = 0;
    124c:	move.w #0,100(a0)
	custom->bltdmod = 0;
    1252:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
    1258:	moveq #11,d0
    125a:	lsl.w d0,d4
    125c:	move.w (a3),d0
    125e:	lsr.w #4,d0
    1260:	add.w d0,d4
    1262:	move.w d4,88(a0)
	ScrollCnt += speed;
    1266:	move.w 1d984 <ScrollCnt>,d0
    126c:	addq.w #4,d0
    126e:	move.w d0,1d984 <ScrollCnt>
	if (ScrollCnt >= 32)
    1274:	cmpi.w #31,d0
    1278:	bls.w e32 <main+0xdbe>
    127c:	bra.w fd4 <main+0xf60>
				ScrollerDir -= 1;
    1280:	subq.b #1,d0
				if (ScrollerDir < -4)
    1282:	cmpi.b #-4,d0
    1286:	bge.s 12ba <main+0x1246>
					ScrollerDir = -4;
    1288:	move.b #-4,55ae <ScrollerDir>
    1290:	moveq #-4,d0
			ScrollerY += ScrollerDir;
    1292:	add.w d0,d5
    1294:	move.w d5,55ac <ScrollerY>
    129a:	bra.w da0 <main+0xd2c>
				if (ScrollerDir < 1)
    129e:	tst.b d0
    12a0:	bgt.w 1388 <main+0x1314>
					ScrollerDir = 1;
    12a4:	move.b #1,55ae <ScrollerDir>
    12ac:	moveq #1,d0
			ScrollerY += ScrollerDir;
    12ae:	add.w d0,d5
    12b0:	move.w d5,55ac <ScrollerY>
    12b6:	bra.w da0 <main+0xd2c>
				if (ScrollerDir > -1)
    12ba:	tst.b d0
    12bc:	blt.w 1388 <main+0x1314>
					ScrollerDir = -1;
    12c0:	st 55ae <ScrollerDir>
    12c6:	moveq #-1,d0
			ScrollerY += ScrollerDir;
    12c8:	add.w d0,d5
    12ca:	move.w d5,55ac <ScrollerY>
    12d0:	bra.w da0 <main+0xd2c>
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
    12d4:	movea.w d7,a6
    12d6:	adda.w d7,a6
    12d8:	sub.w a6,d4
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    12da:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    12de:	move.w d4,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    12e2:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    12e8:	move.w d4,6(a0)
		MirrorEnabled = !MirrorEnabled;
    12ec:	tst.w d0
    12ee:	seq d0
    12f0:	ext.w d0
    12f2:	neg.w d0
    12f4:	move.w d0,1d980 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    12fa:	move.w d1,d4
    12fc:	addq.w #1,d4
    12fe:	move.w d4,1d982 <ScrolltextCnt>
    1304:	andi.l #65535,d1
    130a:	move.b (0,a5,d1.l),d0
    130e:	bra.w 1100 <main+0x108c>
		KPrintF("p61Init failed!\n");
    1312:	pea 334a <incbin_P61_Player_end+0x4a>
    1318:	jsr (a5)
    131a:	addq.l #4,sp
	Point2D ps2 = {0, 32};
    131c:	clr.l d2
    131e:	moveq #32,d3
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
    1320:	move.w 1dae0 <BmpLogo+0x4>,d5
    1326:	move.w 1dae4 <BmpLogo+0x8>,d4
    132c:	move.l 1daec <BmpLogo+0x10>,d6
    1332:	movea.w 1dab0 <BmpUpperPart_PF1+0x8>,a1
    1338:	move.l 1dab8 <BmpUpperPart_PF1+0x10>,d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    133e:	movea.l 1db52 <custom>,a0
    1344:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1348:	bra.w b6e <main+0xafa>
		Exit(0);
    134c:	suba.l a6,a6
    134e:	moveq #0,d1
    1350:	jsr -144(a6)
    1354:	bra.w c2 <main+0x4e>
		Exit(0);
    1358:	movea.l 1db44 <DOSBase>,a6
    135e:	moveq #0,d1
    1360:	jsr -144(a6)
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    1364:	movea.l 1db4c <SysBase>,a6
    136a:	lea 3312 <incbin_P61_Player_end+0x12>,a1
    1370:	moveq #0,d0
    1372:	jsr -552(a6)
    1376:	move.l d0,1db44 <DOSBase>
	if (!DOSBase)
    137c:	bne.w c2 <main+0x4e>
    1380:	bra.s 134c <main+0x12d8>
	APTR vbr = 0;
    1382:	moveq #0,d0
    1384:	bra.w 772 <main+0x6fe>
				ScrollerDir -= 1;
    1388:	move.b d0,55ae <ScrollerDir>
			ScrollerY += ScrollerDir;
    138e:	ext.w d0
    1390:	add.w d0,d5
    1392:	move.w d5,55ac <ScrollerY>
    1398:	bra.w da0 <main+0xd2c>
    for (USHORT i = 0; i < numPlanes; i++)
    139c:	movea.l a0,a1
    139e:	bra.w 96c <main+0x8f8>
    13a2:	nop

000013a4 <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

static __attribute__((interrupt)) void interruptHandler()
{
    13a4:	movem.l d0/a0/a3/a6,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    13a8:	movea.l 1db52 <custom>,a0
    13ae:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    13b4:	move.w #32,156(a0)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    13ba:	lea 199a <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    13c0:	movea.l #14675968,a6
	__asm volatile(
    13c6:	movem.l d0-a2/a4-a5,-(sp)
    13ca:	jsr 4(a3)
    13ce:	movem.l (sp)+,d0-a2/a4-a5

    // DEMO - ThePlayer
    p61Music();

    // DEMO - increment frameCounter
    frameCounter++;
    13d2:	move.w 1db50 <frameCounter>,d0
    13d8:	addq.w #1,d0
    13da:	move.w d0,1db50 <frameCounter>
}
    13e0:	movem.l (sp)+,d0/a0/a3/a6
    13e4:	rte

000013e6 <WaitVbl>:
{
    13e6:	subq.l #8,sp
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    13e8:	move.l dff004 <_end+0xde14ac>,d0
    13ee:	move.l d0,(sp)
		vpos &= 0x1ff00;
    13f0:	move.l (sp),d0
    13f2:	andi.l #130816,d0
    13f8:	move.l d0,(sp)
		if (vpos != (311 << 8))
    13fa:	move.l (sp),d0
    13fc:	cmpi.l #79616,d0
    1402:	beq.s 13e8 <WaitVbl+0x2>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    1404:	move.l dff004 <_end+0xde14ac>,d0
    140a:	move.l d0,4(sp)
		vpos &= 0x1ff00;
    140e:	move.l 4(sp),d0
    1412:	andi.l #130816,d0
    1418:	move.l d0,4(sp)
		if (vpos == (311 << 8))
    141c:	move.l 4(sp),d0
    1420:	cmpi.l #79616,d0
    1426:	bne.s 1404 <WaitVbl+0x1e>
}
    1428:	addq.l #8,sp
    142a:	rts

0000142c <KPrintF>:
void KPrintF(const char* fmt, ...) {
    142c:	lea -128(sp),sp
    1430:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    1434:	move.w f0ff60 <_end+0xef2408>,d0
    143a:	cmpi.w #20153,d0
    143e:	beq.s 146a <KPrintF+0x3e>
    1440:	cmpi.w #-24562,d0
    1444:	beq.s 146a <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    1446:	movea.l 1db4c <SysBase>,a6
    144c:	movea.l 144(sp),a0
    1450:	lea 148(sp),a1
    1454:	lea 18b6 <KPutCharX>,a2
    145a:	suba.l a3,a3
    145c:	jsr -522(a6)
}
    1460:	movem.l (sp)+,a2-a3/a6
    1464:	lea 128(sp),sp
    1468:	rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    146a:	movea.l 1db4c <SysBase>,a6
    1470:	movea.l 144(sp),a0
    1474:	lea 148(sp),a1
    1478:	lea 18c4 <PutChar>,a2
    147e:	lea 12(sp),a3
    1482:	jsr -522(a6)
		UaeDbgLog(86, temp);
    1486:	move.l a3,-(sp)
    1488:	pea 56 <_start+0x56>
    148c:	jsr f0ff60 <_end+0xef2408>
    1492:	addq.l #8,sp
}
    1494:	movem.l (sp)+,a2-a3/a6
    1498:	lea 128(sp),sp
    149c:	rts

0000149e <BetterBlit.constprop.0.isra.0>:
void BetterBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
    149e:	move.l a2,-(sp)
    14a0:	move.l d2,-(sp)
    14a2:	move.l 48(sp),d2
    14a6:	movea.l 52(sp),a0
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    14aa:	movea.l 1db52 <custom>,a2
    14b0:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    14b4:	move.w 2(a2),d0
    14b8:	btst #14,d0
    14bc:	bne.s 14b4 <BetterBlit.constprop.0.isra.0+0x16>
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | x << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    14be:	move.w #4042,64(a2)
	custom->bltcon1 = x << BSHIFTSHIFT;
    14c4:	move.w #0,66(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    14ca:	moveq #0,d0
    14cc:	move.w 22(sp),d0
    14d0:	lsl.l #5,d0
    14d2:	add.l 24(sp),d0
    14d6:	move.l d0,80(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
    14da:	move.w 18(sp),d0
    14de:	subq.w #4,d0
    14e0:	move.w d0,100(a2)
	custom->bltbpt = (UBYTE *)BmpCookieMask.ImageData + (startA.Y * BmpCookieMask.Bpl) + (startA.X / 8);
    14e4:	move.w 1d9ac <BmpCookieMask+0x8>,d1
    14ea:	moveq #0,d0
    14ec:	move.w d1,d0
    14ee:	lsl.l #5,d0
    14f0:	add.l 1d9b4 <BmpCookieMask+0x10>,d0
    14f6:	move.l d0,76(a2)
	custom->bltbmod = BmpCookieMask.Bpl - (width / 8);
    14fa:	subq.w #4,d1
    14fc:	move.w d1,98(a2)
	custom->bltcpt = custom->bltdpt =  (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1500:	move.l a0,-(sp)
    1502:	move.w 38(sp),-(sp)
    1506:	clr.w -(sp)
    1508:	jsr 17bc <__mulsi3>
    150e:	addq.l #8,sp
    1510:	move.l d2,d1
    1512:	bmi.s 1554 <BetterBlit.constprop.0.isra.0+0xb6>
    1514:	asr.l #3,d1
    1516:	add.l d1,d0
    1518:	add.l 36(sp),d0
    151c:	move.l d0,84(a2)
    1520:	move.l d0,72(a2)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1524:	move.w 30(sp),d0
    1528:	subq.w #4,d0
    152a:	move.w d0,102(a2)
    152e:	move.w d0,96(a2)
	custom->bltafwm = 0xffff;
    1532:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    1538:	move.w #-1,70(a2)
	custom->bltsize = ((height * imgA.Bpls) << HSIZEBITS) | (width / 16);
    153e:	move.w 14(sp),d0
    1542:	moveq #11,d1
    1544:	lsl.w d1,d0
    1546:	ori.w #2,d0
    154a:	move.w d0,88(a2)
}
    154e:	move.l (sp)+,d2
    1550:	movea.l (sp)+,a2
    1552:	rts
	custom->bltcpt = custom->bltdpt =  (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1554:	addq.l #7,d1
    1556:	asr.l #3,d1
    1558:	add.l d1,d0
    155a:	add.l 36(sp),d0
    155e:	move.l d0,84(a2)
    1562:	move.l d0,72(a2)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1566:	move.w 30(sp),d0
    156a:	subq.w #4,d0
    156c:	move.w d0,102(a2)
    1570:	move.w d0,96(a2)
	custom->bltafwm = 0xffff;
    1574:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    157a:	move.w #-1,70(a2)
	custom->bltsize = ((height * imgA.Bpls) << HSIZEBITS) | (width / 16);
    1580:	move.w 14(sp),d0
    1584:	moveq #11,d1
    1586:	lsl.w d1,d0
    1588:	ori.w #2,d0
    158c:	move.w d0,88(a2)
}
    1590:	move.l (sp)+,d2
    1592:	movea.l (sp)+,a2
    1594:	rts

00001596 <strlen>:
unsigned long strlen(const char* s) {
    1596:	movea.l 4(sp),a0
	unsigned long t=0;
    159a:	moveq #0,d0
	while(*s++)
    159c:	tst.b (a0)
    159e:	beq.s 15a8 <strlen+0x12>
		t++;
    15a0:	addq.l #1,d0
	while(*s++)
    15a2:	tst.b (0,a0,d0.l)
    15a6:	bne.s 15a0 <strlen+0xa>
}
    15a8:	rts

000015aa <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    15aa:	movem.l d2-d7/a2-a3,-(sp)
    15ae:	move.l 36(sp),d0
    15b2:	move.l 40(sp),d4
    15b6:	movea.l 44(sp),a1
	while(len-- > 0)
    15ba:	move.l a1,d5
    15bc:	subq.l #1,d5
    15be:	cmpa.w #0,a1
    15c2:	beq.w 1672 <memset+0xc8>
		*ptr++ = val;
    15c6:	move.b d4,d7
    15c8:	move.l d0,d1
    15ca:	neg.l d1
    15cc:	moveq #3,d2
    15ce:	and.l d2,d1
    15d0:	moveq #5,d6
    15d2:	movea.l d0,a2
    15d4:	cmp.l d5,d6
    15d6:	bcc.s 1642 <memset+0x98>
    15d8:	tst.l d1
    15da:	beq.s 1600 <memset+0x56>
    15dc:	move.b d4,(a2)+
	while(len-- > 0)
    15de:	subq.l #1,d5
    15e0:	moveq #1,d2
    15e2:	cmp.l d1,d2
    15e4:	beq.s 1600 <memset+0x56>
		*ptr++ = val;
    15e6:	movea.l d0,a2
    15e8:	addq.l #2,a2
    15ea:	movea.l d0,a0
    15ec:	move.b d4,1(a0)
	while(len-- > 0)
    15f0:	subq.l #1,d5
    15f2:	moveq #3,d2
    15f4:	cmp.l d1,d2
    15f6:	bne.s 1600 <memset+0x56>
		*ptr++ = val;
    15f8:	addq.l #1,a2
    15fa:	move.b d4,2(a0)
	while(len-- > 0)
    15fe:	subq.l #1,d5
    1600:	move.l a1,d3
    1602:	sub.l d1,d3
    1604:	moveq #0,d6
    1606:	move.b d4,d6
    1608:	move.l d6,d2
    160a:	swap d2
    160c:	clr.w d2
    160e:	movea.l d2,a0
    1610:	move.l d4,d2
    1612:	lsl.w #8,d2
    1614:	swap d2
    1616:	clr.w d2
    1618:	lsl.l #8,d6
    161a:	movea.l d6,a3
    161c:	move.l a0,d6
    161e:	or.l d6,d2
    1620:	move.l a3,d6
    1622:	or.l d6,d2
    1624:	move.b d7,d2
    1626:	movea.l d0,a0
    1628:	adda.l d1,a0
    162a:	moveq #-4,d1
    162c:	and.l d3,d1
    162e:	add.l a0,d1
		*ptr++ = val;
    1630:	move.l d2,(a0)+
	while(len-- > 0)
    1632:	cmpa.l d1,a0
    1634:	bne.s 1630 <memset+0x86>
    1636:	moveq #-4,d1
    1638:	and.l d3,d1
    163a:	adda.l d1,a2
    163c:	sub.l d1,d5
    163e:	cmp.l d3,d1
    1640:	beq.s 1672 <memset+0xc8>
		*ptr++ = val;
    1642:	move.b d4,(a2)
	while(len-- > 0)
    1644:	tst.l d5
    1646:	beq.s 1672 <memset+0xc8>
		*ptr++ = val;
    1648:	move.b d4,1(a2)
	while(len-- > 0)
    164c:	moveq #1,d1
    164e:	cmp.l d5,d1
    1650:	beq.s 1672 <memset+0xc8>
		*ptr++ = val;
    1652:	move.b d4,2(a2)
	while(len-- > 0)
    1656:	moveq #2,d2
    1658:	cmp.l d5,d2
    165a:	beq.s 1672 <memset+0xc8>
		*ptr++ = val;
    165c:	move.b d4,3(a2)
	while(len-- > 0)
    1660:	moveq #3,d6
    1662:	cmp.l d5,d6
    1664:	beq.s 1672 <memset+0xc8>
		*ptr++ = val;
    1666:	move.b d4,4(a2)
	while(len-- > 0)
    166a:	subq.l #4,d5
    166c:	beq.s 1672 <memset+0xc8>
		*ptr++ = val;
    166e:	move.b d4,5(a2)
}
    1672:	movem.l (sp)+,d2-d7/a2-a3
    1676:	rts

00001678 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    1678:	movem.l d2-d6,-(sp)
    167c:	move.l 24(sp),d0
    1680:	move.l 28(sp),d1
    1684:	move.l 32(sp),d3
	while(len--)
    1688:	move.l d3,d4
    168a:	subq.l #1,d4
    168c:	tst.l d3
    168e:	beq.s 16ee <memcpy+0x76>
    1690:	movea.l d1,a0
    1692:	addq.l #1,a0
    1694:	move.l d0,d2
    1696:	sub.l a0,d2
    1698:	moveq #2,d5
    169a:	cmp.l d2,d5
    169c:	sc.s d2
    169e:	neg.b d2
    16a0:	moveq #8,d6
    16a2:	cmp.l d4,d6
    16a4:	sc.s d5
    16a6:	neg.b d5
    16a8:	and.b d5,d2
    16aa:	beq.s 16f4 <memcpy+0x7c>
    16ac:	move.l d0,d2
    16ae:	or.l d1,d2
    16b0:	moveq #3,d5
    16b2:	and.l d5,d2
    16b4:	bne.s 16f4 <memcpy+0x7c>
    16b6:	movea.l d1,a0
    16b8:	movea.l d0,a1
    16ba:	moveq #-4,d2
    16bc:	and.l d3,d2
    16be:	add.l d1,d2
		*d++ = *s++;
    16c0:	move.l (a0)+,(a1)+
	while(len--)
    16c2:	cmp.l a0,d2
    16c4:	bne.s 16c0 <memcpy+0x48>
    16c6:	moveq #-4,d2
    16c8:	and.l d3,d2
    16ca:	movea.l d0,a0
    16cc:	adda.l d2,a0
    16ce:	add.l d2,d1
    16d0:	sub.l d2,d4
    16d2:	cmp.l d3,d2
    16d4:	beq.s 16ee <memcpy+0x76>
		*d++ = *s++;
    16d6:	movea.l d1,a1
    16d8:	move.b (a1),(a0)
	while(len--)
    16da:	tst.l d4
    16dc:	beq.s 16ee <memcpy+0x76>
		*d++ = *s++;
    16de:	move.b 1(a1),1(a0)
	while(len--)
    16e4:	subq.l #1,d4
    16e6:	beq.s 16ee <memcpy+0x76>
		*d++ = *s++;
    16e8:	move.b 2(a1),2(a0)
}
    16ee:	movem.l (sp)+,d2-d6
    16f2:	rts
    16f4:	movea.l d0,a1
    16f6:	add.l d3,d1
		*d++ = *s++;
    16f8:	move.b -1(a0),(a1)+
	while(len--)
    16fc:	cmp.l a0,d1
    16fe:	beq.s 16ee <memcpy+0x76>
    1700:	addq.l #1,a0
    1702:	bra.s 16f8 <memcpy+0x80>

00001704 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    1704:	movem.l d2-d5/a2,-(sp)
    1708:	move.l 24(sp),d0
    170c:	move.l 28(sp),d1
    1710:	move.l 32(sp),d2
		while (len--)
    1714:	movea.l d2,a1
    1716:	subq.l #1,a1
	if (d < s) {
    1718:	cmp.l d0,d1
    171a:	bls.s 1788 <memmove+0x84>
		while (len--)
    171c:	tst.l d2
    171e:	beq.s 1782 <memmove+0x7e>
    1720:	movea.l d1,a2
    1722:	addq.l #1,a2
    1724:	move.l d0,d3
    1726:	sub.l a2,d3
    1728:	moveq #2,d4
    172a:	cmp.l d3,d4
    172c:	sc.s d3
    172e:	neg.b d3
    1730:	moveq #8,d5
    1732:	cmp.l a1,d5
    1734:	sc.s d4
    1736:	neg.b d4
    1738:	and.b d4,d3
    173a:	beq.s 17ac <memmove+0xa8>
    173c:	move.l d0,d3
    173e:	or.l d1,d3
    1740:	moveq #3,d4
    1742:	and.l d4,d3
    1744:	bne.s 17ac <memmove+0xa8>
    1746:	movea.l d1,a0
    1748:	movea.l d0,a2
    174a:	moveq #-4,d3
    174c:	and.l d2,d3
    174e:	add.l d1,d3
			*d++ = *s++;
    1750:	move.l (a0)+,(a2)+
		while (len--)
    1752:	cmp.l a0,d3
    1754:	bne.s 1750 <memmove+0x4c>
    1756:	moveq #-4,d3
    1758:	and.l d2,d3
    175a:	movea.l d0,a2
    175c:	adda.l d3,a2
    175e:	movea.l d1,a0
    1760:	adda.l d3,a0
    1762:	suba.l d3,a1
    1764:	cmp.l d2,d3
    1766:	beq.s 1782 <memmove+0x7e>
			*d++ = *s++;
    1768:	move.b (a0),(a2)
		while (len--)
    176a:	cmpa.w #0,a1
    176e:	beq.s 1782 <memmove+0x7e>
			*d++ = *s++;
    1770:	move.b 1(a0),1(a2)
		while (len--)
    1776:	moveq #1,d5
    1778:	cmp.l a1,d5
    177a:	beq.s 1782 <memmove+0x7e>
			*d++ = *s++;
    177c:	move.b 2(a0),2(a2)
}
    1782:	movem.l (sp)+,d2-d5/a2
    1786:	rts
		const char *lasts = s + (len - 1);
    1788:	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    178c:	adda.l d0,a1
		while (len--)
    178e:	tst.l d2
    1790:	beq.s 1782 <memmove+0x7e>
    1792:	move.l a0,d1
    1794:	sub.l d2,d1
			*lastd-- = *lasts--;
    1796:	move.b (a0),(a1)
		while (len--)
    1798:	subq.l #1,a0
    179a:	subq.l #1,a1
    179c:	cmp.l a0,d1
    179e:	beq.s 1782 <memmove+0x7e>
			*lastd-- = *lasts--;
    17a0:	move.b (a0),(a1)
		while (len--)
    17a2:	subq.l #1,a0
    17a4:	subq.l #1,a1
    17a6:	cmp.l a0,d1
    17a8:	bne.s 1796 <memmove+0x92>
    17aa:	bra.s 1782 <memmove+0x7e>
    17ac:	movea.l d0,a1
    17ae:	add.l d2,d1
			*d++ = *s++;
    17b0:	move.b -1(a2),(a1)+
		while (len--)
    17b4:	cmp.l a2,d1
    17b6:	beq.s 1782 <memmove+0x7e>
    17b8:	addq.l #1,a2
    17ba:	bra.s 17b0 <memmove+0xac>

000017bc <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    17bc:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    17c0:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    17c4:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    17c8:	mulu.w 8(sp),d1
	addw	d1, d0
    17cc:	add.w d1,d0
	swap	d0
    17ce:	swap d0
	clrw	d0
    17d0:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    17d2:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    17d6:	mulu.w 10(sp),d1
	addl	d1, d0
    17da:	add.l d1,d0
	rts
    17dc:	rts

000017de <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    17de:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    17e0:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    17e4:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    17e8:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    17ee:	bcc.s 1806 <__udivsi3+0x28>
	movel	d0, d2
    17f0:	move.l d0,d2
	clrw	d2
    17f2:	clr.w d2
	swap	d2
    17f4:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    17f6:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    17f8:	move.w d2,d0
	swap	d0
    17fa:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    17fc:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    1800:	divu.w d1,d2
	movew	d2, d0
    1802:	move.w d2,d0
	jra	6f
    1804:	bra.s 1836 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    1806:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    1808:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    180a:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    180c:	cmpi.l #65536,d1
	jcc	4b
    1812:	bcc.s 1808 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    1814:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    1816:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    181c:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    181e:	mulu.w d0,d1
	swap	d2
    1820:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    1822:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    1824:	swap d2
	tstw	d2		/* high part 17 bits? */
    1826:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    1828:	bne.s 1834 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    182a:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    182c:	bcs.s 1834 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    182e:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    1832:	bls.s 1836 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    1834:	subq.l #1,d0

6:	movel	sp@+, d2
    1836:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1838:	rts

0000183a <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    183a:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    183c:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    183e:	move.l 12(sp),d1
	jpl	1f
    1842:	bpl.s 1848 <__divsi3+0xe>
	negl	d1
    1844:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    1846:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    1848:	move.l 8(sp),d0
	jpl	2f
    184c:	bpl.s 1852 <__divsi3+0x18>
	negl	d0
    184e:	neg.l d0
	negb	d2
    1850:	neg.b d2

2:	movel	d1, sp@-
    1852:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1854:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    1856:	bsr.s 17de <__udivsi3>
	addql	#8, sp
    1858:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    185a:	tst.b d2
	jpl	3f
    185c:	bpl.s 1860 <__divsi3+0x26>
	negl	d0
    185e:	neg.l d0

3:	movel	sp@+, d2
    1860:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1862:	rts

00001864 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1864:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1868:	move.l 4(sp),d0
	movel	d1, sp@-
    186c:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    186e:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    1870:	bsr.s 183a <__divsi3>
	addql	#8, sp
    1872:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1874:	move.l 8(sp),d1
	movel	d1, sp@-
    1878:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    187a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    187c:	bsr.w 17bc <__mulsi3>
	addql	#8, sp
    1880:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1882:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1886:	sub.l d0,d1
	movel	d1, d0
    1888:	move.l d1,d0
	rts
    188a:	rts

0000188c <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    188c:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1890:	move.l 4(sp),d0
	movel	d1, sp@-
    1894:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1896:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    1898:	bsr.w 17de <__udivsi3>
	addql	#8, sp
    189c:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    189e:	move.l 8(sp),d1
	movel	d1, sp@-
    18a2:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    18a4:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    18a6:	bsr.w 17bc <__mulsi3>
	addql	#8, sp
    18aa:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    18ac:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    18b0:	sub.l d0,d1
	movel	d1, d0
    18b2:	move.l d1,d0
	rts
    18b4:	rts

000018b6 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    18b6:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    18b8:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    18bc:	jsr -516(a6)
    move.l (sp)+, a6
    18c0:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    18c2:	rts

000018c4 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    18c4:	move.b d0,(a3)+
	rts
    18c6:	rts

000018c8 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    18c8:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    18ca:	adda.l a0,a2
	move.l	a2,a3
    18cc:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    18ce:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    18d0:	moveq #56,d4
	moveq	#8,d5
    18d2:	moveq #8,d5
	bra.s	.Lliteral
    18d4:	bra.s 193e <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    18d6:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    18d8:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    18da:	dbf d1,18d6 <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    18de:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    18e0:	bcc.s 18e4 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    18e2:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    18e4:	tst.w d0
    18e6:	bne.s 18f0 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    18e8:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    18ea:	bls.s 1962 <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    18ec:	move.w (a0)+,d0
    18ee:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    18f0:	rol.l #6,d0
	move.w	d0,d1
    18f2:	move.w d0,d1
	and.w	d4,d1
    18f4:	and.w d4,d1
	eor.w	d1,d0
    18f6:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    18f8:	movem.w (195c <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    18fe:	rol.l d2,d0
	and.w	d0,d3					|scaling
    1900:	and.w d0,d3
	eor.w	d3,d0
    1902:	eor.w d3,d0
	suba.w	d3,a4
    1904:	suba.w d3,a4
	adda.l	a1,a4
    1906:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    1908:	tst.w d0
    190a:	bne.s 1910 <_doynaxdepack_asm+0x48>
    190c:	move.w (a0)+,d0
    190e:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    1910:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    1912:	beq.s 192a <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    1914:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    1916:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    1918:	bpl.s 1926 <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    191a:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    191c:	bpl.s 1924 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    191e:	addx.b d1,d1
	lsl.l	#2,d0
    1920:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    1922:	bmi.s 191e <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    1924:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    1926:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    1928:	bcc.s 192c <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    192a:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    192c:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    192e:	dbf d1,192a <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    1932:	add.l d0,d0
	bcc.s	.Lmatch
    1934:	bcc.s 18e4 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    1936:	tst.w d0
    1938:	bne.s 193e <_doynaxdepack_asm+0x76>
    193a:	move.w (a0)+,d0
    193c:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    193e:	moveq #0,d1
	add.l	d0,d0
    1940:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    1942:	bcc.s 18e2 <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    1944:	bpl.s 194c <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    1946:	addx.b d1,d1
	lsl.l	#2,d0
    1948:	lsl.l #2,d0
	bmi.s	.Llgetlen
    194a:	bmi.s 1946 <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    194c:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    194e:	dbv.s d1,18d6 <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    1952:	add.l d0,d0
	eor.w	d1,d0		
    1954:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    1956:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    1958:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    195a:	bra.s 194e <_doynaxdepack_asm+0x86>

0000195c <doy_table>:
    195c:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    196c:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    197c:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    198c:	.............o
