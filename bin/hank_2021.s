
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
       4:	move.l #21070,d3
       a:	subi.l #21070,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	beq.s 26 <_start+0x26>
      14:	lea 524e <__fini_array_end>,a2
      1a:	moveq #0,d2
		__preinit_array_start[i]();
      1c:	movea.l (a2)+,a0
      1e:	jsr (a0)
	for (i = 0; i < count; i++)
      20:	addq.l #1,d2
      22:	cmp.l d3,d2
      24:	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	move.l #21070,d3
      2c:	subi.l #21070,d3
      32:	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	beq.s 48 <_start+0x48>
      36:	lea 524e <__fini_array_end>,a2
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
      4e:	move.l #21070,d2
      54:	subi.l #21070,d2
      5a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	beq.s 6e <_start+0x6e>
      5e:	lea 524e <__fini_array_end>,a2
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
      80:	move.l a6,1d7bc <SysBase>
	custom = (struct Custom *)0xdff000;
      86:	move.l #14675968,1d7c2 <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
      90:	lea 2fb5 <incbin_player_end+0x1>,a1
      96:	moveq #0,d0
      98:	jsr -552(a6)
      9c:	move.l d0,1d7b8 <GfxBase>
	if (!GfxBase)
      a2:	beq.w 1104 <main+0x1090>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
      a6:	movea.l 1d7bc <SysBase>,a6
      ac:	lea 2fc6 <incbin_player_end+0x12>,a1
      b2:	moveq #0,d0
      b4:	jsr -552(a6)
      b8:	move.l d0,1d7b4 <DOSBase>
	if (!DOSBase)
      be:	beq.w 10f8 <main+0x1084>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      c2:	pea 2fd2 <incbin_player_end+0x1e>
      c8:	lea 11d8 <KPrintF>,a5
      ce:	jsr (a5)
#endif

	Write(Output(), (APTR) "Hello console!\n", 15);
      d0:	movea.l 1d7b4 <DOSBase>,a6
      d6:	jsr -60(a6)
      da:	movea.l 1d7b4 <DOSBase>,a6
      e0:	move.l d0,d1
      e2:	move.l #12270,d2
      e8:	moveq #15,d3
      ea:	jsr -48(a6)

	copPtr = AllocMem(1024, MEMF_CHIP);
      ee:	movea.l 1d7bc <SysBase>,a6
      f4:	move.l #1024,d0
      fa:	moveq #2,d1
      fc:	jsr -198(a6)
     100:	move.l d0,1d7b0 <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
     106:	movea.l 1d7bc <SysBase>,a6
     10c:	moveq #0,d0
     10e:	move.w 5398 <BmpScroller+0xe>,d0
     114:	move.l #65538,d1
     11a:	jsr -198(a6)
     11e:	move.l d0,539a <BmpScroller+0x10>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
     124:	movea.l 1d7bc <SysBase>,a6
     12a:	moveq #0,d0
     12c:	move.w 5364 <BmpUpperPart_PF1+0xe>,d0
     132:	move.l #65538,d1
     138:	jsr -198(a6)
     13c:	move.l d0,5366 <BmpUpperPart_PF1+0x10>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
     142:	movea.l 1d7bc <SysBase>,a6
     148:	moveq #0,d0
     14a:	move.w 5330 <BmpUpperPart_PF2+0xe>,d0
     150:	move.l #65538,d1
     156:	jsr -198(a6)
     15a:	move.l d0,5332 <BmpUpperPart_PF2+0x10>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
     160:	move.l #21440,52fe <BmpLogo+0x10>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
     16a:	move.l #33922,52ca <BmpFont32+0x10>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
     174:	move.l #64644,5296 <BmpCookie+0x10>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
     17e:	move.l #95366,5262 <BmpCookieMask+0x10>
	Enable();
}

void InitImagePlanes(BmpDescriptor *img)
{
	for (int p = 0; p < img->Bpls; p++)
     188:	moveq #0,d2
     18a:	move.w 535a <BmpUpperPart_PF1+0x4>,d2
     190:	addq.l #4,sp
     192:	tst.l d2
     194:	beq.w 226 <main+0x1b2>
	{
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     198:	movea.l 5366 <BmpUpperPart_PF1+0x10>,a0
     19e:	moveq #0,d3
     1a0:	move.w 535e <BmpUpperPart_PF1+0x8>,d3
     1a6:	move.l a0,536a <BmpUpperPart_PF1+0x14>
	for (int p = 0; p < img->Bpls; p++)
     1ac:	moveq #1,d1
     1ae:	cmp.l d2,d1
     1b0:	beq.s 226 <main+0x1b2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     1b2:	lea (0,a0,d3.l),a1
     1b6:	move.l a1,536e <BmpUpperPart_PF1+0x18>
	for (int p = 0; p < img->Bpls; p++)
     1bc:	moveq #2,d1
     1be:	cmp.l d2,d1
     1c0:	beq.s 226 <main+0x1b2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     1c2:	move.l d3,d1
     1c4:	add.l d3,d1
     1c6:	lea (0,a0,d1.l),a1
     1ca:	move.l a1,5372 <BmpUpperPart_PF1+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     1d0:	moveq #3,d4
     1d2:	cmp.l d2,d4
     1d4:	beq.s 226 <main+0x1b2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     1d6:	add.l d3,d1
     1d8:	lea (0,a0,d1.l),a1
     1dc:	move.l a1,5376 <BmpUpperPart_PF1+0x20>
	for (int p = 0; p < img->Bpls; p++)
     1e2:	moveq #4,d4
     1e4:	cmp.l d2,d4
     1e6:	beq.s 226 <main+0x1b2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     1e8:	add.l d3,d1
     1ea:	lea (0,a0,d1.l),a1
     1ee:	move.l a1,537a <BmpUpperPart_PF1+0x24>
	for (int p = 0; p < img->Bpls; p++)
     1f4:	moveq #5,d4
     1f6:	cmp.l d2,d4
     1f8:	beq.s 226 <main+0x1b2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     1fa:	add.l d3,d1
     1fc:	lea (0,a0,d1.l),a1
     200:	move.l a1,537e <BmpUpperPart_PF1+0x28>
	for (int p = 0; p < img->Bpls; p++)
     206:	moveq #6,d4
     208:	cmp.l d2,d4
     20a:	beq.s 226 <main+0x1b2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     20c:	add.l d3,d1
     20e:	lea (0,a0,d1.l),a1
     212:	move.l a1,5382 <BmpUpperPart_PF1+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     218:	subq.l #7,d2
     21a:	beq.s 226 <main+0x1b2>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     21c:	add.l d3,d1
     21e:	add.l a0,d1
     220:	move.l d1,5386 <BmpUpperPart_PF1+0x30>
	for (int p = 0; p < img->Bpls; p++)
     226:	moveq #0,d2
     228:	move.w 5326 <BmpUpperPart_PF2+0x4>,d2
     22e:	tst.l d2
     230:	beq.w 2bc <main+0x248>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     234:	moveq #0,d3
     236:	move.w 532a <BmpUpperPart_PF2+0x8>,d3
     23c:	move.l d0,5336 <BmpUpperPart_PF2+0x14>
	for (int p = 0; p < img->Bpls; p++)
     242:	moveq #1,d1
     244:	cmp.l d2,d1
     246:	beq.s 2bc <main+0x248>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     248:	move.l d0,d4
     24a:	add.l d3,d4
     24c:	move.l d4,533a <BmpUpperPart_PF2+0x18>
	for (int p = 0; p < img->Bpls; p++)
     252:	moveq #2,d1
     254:	cmp.l d2,d1
     256:	beq.s 2bc <main+0x248>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     258:	move.l d3,d1
     25a:	add.l d3,d1
     25c:	move.l d0,d4
     25e:	add.l d1,d4
     260:	move.l d4,533e <BmpUpperPart_PF2+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     266:	moveq #3,d4
     268:	cmp.l d2,d4
     26a:	beq.s 2bc <main+0x248>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     26c:	add.l d3,d1
     26e:	move.l d0,d4
     270:	add.l d1,d4
     272:	move.l d4,5342 <BmpUpperPart_PF2+0x20>
	for (int p = 0; p < img->Bpls; p++)
     278:	moveq #4,d4
     27a:	cmp.l d2,d4
     27c:	beq.s 2bc <main+0x248>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     27e:	add.l d3,d1
     280:	move.l d0,d4
     282:	add.l d1,d4
     284:	move.l d4,5346 <BmpUpperPart_PF2+0x24>
	for (int p = 0; p < img->Bpls; p++)
     28a:	moveq #5,d4
     28c:	cmp.l d2,d4
     28e:	beq.s 2bc <main+0x248>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     290:	add.l d3,d1
     292:	move.l d0,d4
     294:	add.l d1,d4
     296:	move.l d4,534a <BmpUpperPart_PF2+0x28>
	for (int p = 0; p < img->Bpls; p++)
     29c:	moveq #6,d4
     29e:	cmp.l d2,d4
     2a0:	beq.s 2bc <main+0x248>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2a2:	add.l d3,d1
     2a4:	move.l d0,d4
     2a6:	add.l d1,d4
     2a8:	move.l d4,534e <BmpUpperPart_PF2+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     2ae:	subq.l #7,d2
     2b0:	beq.s 2bc <main+0x248>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2b2:	add.l d3,d1
     2b4:	add.l d1,d0
     2b6:	move.l d0,5352 <BmpUpperPart_PF2+0x30>
	for (int p = 0; p < img->Bpls; p++)
     2bc:	moveq #0,d1
     2be:	move.w 538e <BmpScroller+0x4>,d1
     2c4:	tst.l d1
     2c6:	beq.w 358 <main+0x2e4>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2ca:	movea.l 539a <BmpScroller+0x10>,a0
     2d0:	moveq #0,d2
     2d2:	move.w 5392 <BmpScroller+0x8>,d2
     2d8:	move.l a0,539e <BmpScroller+0x14>
	for (int p = 0; p < img->Bpls; p++)
     2de:	moveq #1,d0
     2e0:	cmp.l d1,d0
     2e2:	beq.s 358 <main+0x2e4>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2e4:	lea (0,a0,d2.l),a1
     2e8:	move.l a1,53a2 <BmpScroller+0x18>
	for (int p = 0; p < img->Bpls; p++)
     2ee:	moveq #2,d0
     2f0:	cmp.l d1,d0
     2f2:	beq.s 358 <main+0x2e4>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2f4:	move.l d2,d0
     2f6:	add.l d2,d0
     2f8:	lea (0,a0,d0.l),a1
     2fc:	move.l a1,53a6 <BmpScroller+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     302:	moveq #3,d3
     304:	cmp.l d1,d3
     306:	beq.s 358 <main+0x2e4>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     308:	add.l d2,d0
     30a:	lea (0,a0,d0.l),a1
     30e:	move.l a1,53aa <BmpScroller+0x20>
	for (int p = 0; p < img->Bpls; p++)
     314:	moveq #4,d3
     316:	cmp.l d1,d3
     318:	beq.s 358 <main+0x2e4>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     31a:	add.l d2,d0
     31c:	lea (0,a0,d0.l),a1
     320:	move.l a1,53ae <BmpScroller+0x24>
	for (int p = 0; p < img->Bpls; p++)
     326:	moveq #5,d3
     328:	cmp.l d1,d3
     32a:	beq.s 358 <main+0x2e4>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     32c:	add.l d2,d0
     32e:	lea (0,a0,d0.l),a1
     332:	move.l a1,53b2 <BmpScroller+0x28>
	for (int p = 0; p < img->Bpls; p++)
     338:	moveq #6,d3
     33a:	cmp.l d1,d3
     33c:	beq.s 358 <main+0x2e4>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     33e:	add.l d2,d0
     340:	lea (0,a0,d0.l),a1
     344:	move.l a1,53b6 <BmpScroller+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     34a:	subq.l #7,d1
     34c:	beq.s 358 <main+0x2e4>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     34e:	add.l d2,d0
     350:	add.l a0,d0
     352:	move.l d0,53ba <BmpScroller+0x30>
	for (int p = 0; p < img->Bpls; p++)
     358:	moveq #0,d1
     35a:	move.w 52be <BmpFont32+0x4>,d1
     360:	tst.l d1
     362:	beq.w 410 <main+0x39c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     366:	moveq #0,d2
     368:	move.w 52c2 <BmpFont32+0x8>,d2
     36e:	move.l #33922,52ce <BmpFont32+0x14>
	for (int p = 0; p < img->Bpls; p++)
     378:	moveq #1,d4
     37a:	cmp.l d1,d4
     37c:	beq.w 410 <main+0x39c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     380:	move.l d2,d0
     382:	addi.l #33922,d0
     388:	move.l d0,52d2 <BmpFont32+0x18>
	for (int p = 0; p < img->Bpls; p++)
     38e:	moveq #2,d3
     390:	cmp.l d1,d3
     392:	beq.s 410 <main+0x39c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     394:	move.l d2,d0
     396:	add.l d2,d0
     398:	move.l d0,d4
     39a:	addi.l #33922,d4
     3a0:	move.l d4,52d6 <BmpFont32+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     3a6:	moveq #3,d3
     3a8:	cmp.l d1,d3
     3aa:	beq.s 410 <main+0x39c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3ac:	add.l d2,d0
     3ae:	move.l d0,d4
     3b0:	addi.l #33922,d4
     3b6:	move.l d4,52da <BmpFont32+0x20>
	for (int p = 0; p < img->Bpls; p++)
     3bc:	moveq #4,d3
     3be:	cmp.l d1,d3
     3c0:	beq.s 410 <main+0x39c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3c2:	add.l d2,d0
     3c4:	move.l d0,d4
     3c6:	addi.l #33922,d4
     3cc:	move.l d4,52de <BmpFont32+0x24>
	for (int p = 0; p < img->Bpls; p++)
     3d2:	moveq #5,d3
     3d4:	cmp.l d1,d3
     3d6:	beq.s 410 <main+0x39c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3d8:	add.l d2,d0
     3da:	move.l d0,d4
     3dc:	addi.l #33922,d4
     3e2:	move.l d4,52e2 <BmpFont32+0x28>
	for (int p = 0; p < img->Bpls; p++)
     3e8:	moveq #6,d3
     3ea:	cmp.l d1,d3
     3ec:	beq.s 410 <main+0x39c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3ee:	add.l d2,d0
     3f0:	move.l d0,d4
     3f2:	addi.l #33922,d4
     3f8:	move.l d4,52e6 <BmpFont32+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     3fe:	subq.l #7,d1
     400:	beq.s 410 <main+0x39c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     402:	add.l d2,d0
     404:	addi.l #33922,d0
     40a:	move.l d0,52ea <BmpFont32+0x30>
	for (int p = 0; p < img->Bpls; p++)
     410:	moveq #0,d1
     412:	move.w 528a <BmpCookie+0x4>,d1
     418:	tst.l d1
     41a:	beq.w 4c8 <main+0x454>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     41e:	moveq #0,d2
     420:	move.w 528e <BmpCookie+0x8>,d2
     426:	move.l #64644,529a <BmpCookie+0x14>
	for (int p = 0; p < img->Bpls; p++)
     430:	moveq #1,d4
     432:	cmp.l d1,d4
     434:	beq.w 4c8 <main+0x454>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     438:	move.l d2,d0
     43a:	addi.l #64644,d0
     440:	move.l d0,529e <BmpCookie+0x18>
	for (int p = 0; p < img->Bpls; p++)
     446:	moveq #2,d3
     448:	cmp.l d1,d3
     44a:	beq.s 4c8 <main+0x454>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     44c:	move.l d2,d0
     44e:	add.l d2,d0
     450:	move.l d0,d4
     452:	addi.l #64644,d4
     458:	move.l d4,52a2 <BmpCookie+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     45e:	moveq #3,d3
     460:	cmp.l d1,d3
     462:	beq.s 4c8 <main+0x454>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     464:	add.l d2,d0
     466:	move.l d0,d4
     468:	addi.l #64644,d4
     46e:	move.l d4,52a6 <BmpCookie+0x20>
	for (int p = 0; p < img->Bpls; p++)
     474:	moveq #4,d3
     476:	cmp.l d1,d3
     478:	beq.s 4c8 <main+0x454>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     47a:	add.l d2,d0
     47c:	move.l d0,d4
     47e:	addi.l #64644,d4
     484:	move.l d4,52aa <BmpCookie+0x24>
	for (int p = 0; p < img->Bpls; p++)
     48a:	moveq #5,d3
     48c:	cmp.l d1,d3
     48e:	beq.s 4c8 <main+0x454>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     490:	add.l d2,d0
     492:	move.l d0,d4
     494:	addi.l #64644,d4
     49a:	move.l d4,52ae <BmpCookie+0x28>
	for (int p = 0; p < img->Bpls; p++)
     4a0:	moveq #6,d3
     4a2:	cmp.l d1,d3
     4a4:	beq.s 4c8 <main+0x454>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4a6:	add.l d2,d0
     4a8:	move.l d0,d4
     4aa:	addi.l #64644,d4
     4b0:	move.l d4,52b2 <BmpCookie+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     4b6:	subq.l #7,d1
     4b8:	beq.s 4c8 <main+0x454>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4ba:	add.l d2,d0
     4bc:	addi.l #64644,d0
     4c2:	move.l d0,52b6 <BmpCookie+0x30>
	for (int p = 0; p < img->Bpls; p++)
     4c8:	moveq #0,d1
     4ca:	move.w 5256 <BmpCookieMask+0x4>,d1
     4d0:	tst.l d1
     4d2:	beq.w 580 <main+0x50c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4d6:	moveq #0,d2
     4d8:	move.w 525a <BmpCookieMask+0x8>,d2
     4de:	move.l #95366,5266 <BmpCookieMask+0x14>
	for (int p = 0; p < img->Bpls; p++)
     4e8:	moveq #1,d4
     4ea:	cmp.l d1,d4
     4ec:	beq.w 580 <main+0x50c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     4f0:	move.l d2,d0
     4f2:	addi.l #95366,d0
     4f8:	move.l d0,526a <BmpCookieMask+0x18>
	for (int p = 0; p < img->Bpls; p++)
     4fe:	moveq #2,d3
     500:	cmp.l d1,d3
     502:	beq.s 580 <main+0x50c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     504:	move.l d2,d0
     506:	add.l d2,d0
     508:	move.l d0,d4
     50a:	addi.l #95366,d4
     510:	move.l d4,526e <BmpCookieMask+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     516:	moveq #3,d3
     518:	cmp.l d1,d3
     51a:	beq.s 580 <main+0x50c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     51c:	add.l d2,d0
     51e:	move.l d0,d4
     520:	addi.l #95366,d4
     526:	move.l d4,5272 <BmpCookieMask+0x20>
	for (int p = 0; p < img->Bpls; p++)
     52c:	moveq #4,d3
     52e:	cmp.l d1,d3
     530:	beq.s 580 <main+0x50c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     532:	add.l d2,d0
     534:	move.l d0,d4
     536:	addi.l #95366,d4
     53c:	move.l d4,5276 <BmpCookieMask+0x24>
	for (int p = 0; p < img->Bpls; p++)
     542:	moveq #5,d3
     544:	cmp.l d1,d3
     546:	beq.s 580 <main+0x50c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     548:	add.l d2,d0
     54a:	move.l d0,d4
     54c:	addi.l #95366,d4
     552:	move.l d4,527a <BmpCookieMask+0x28>
	for (int p = 0; p < img->Bpls; p++)
     558:	moveq #6,d3
     55a:	cmp.l d1,d3
     55c:	beq.s 580 <main+0x50c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     55e:	add.l d2,d0
     560:	move.l d0,d4
     562:	addi.l #95366,d4
     568:	move.l d4,527e <BmpCookieMask+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     56e:	subq.l #7,d1
     570:	beq.s 580 <main+0x50c>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     572:	add.l d2,d0
     574:	addi.l #95366,d0
     57a:	move.l d0,5282 <BmpCookieMask+0x30>
	ActiView = GfxBase->ActiView; //store current view
     580:	movea.l 1d7b8 <GfxBase>,a6
     586:	move.l 34(a6),1d79e <ActiView>
	OwnBlitter();
     58e:	jsr -456(a6)
	WaitBlit();
     592:	movea.l 1d7b8 <GfxBase>,a6
     598:	jsr -228(a6)
	Disable();
     59c:	movea.l 1d7bc <SysBase>,a6
     5a2:	jsr -120(a6)
	SystemADKCON = custom->adkconr;
     5a6:	movea.l 1d7c2 <custom>,a2
     5ac:	move.w 16(a2),d0
     5b0:	move.w d0,1d7a2 <SystemADKCON>
	SystemInts = custom->intenar;
     5b6:	move.w 28(a2),d0
     5ba:	move.w d0,1d7a6 <SystemInts>
	SystemDMA = custom->dmaconr;
     5c0:	move.w 2(a2),d0
     5c4:	move.w d0,1d7a4 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     5ca:	move.w #32767,154(a2)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     5d0:	move.w #32767,156(a2)
	WaitVbl();
     5d6:	lea 1192 <WaitVbl>,a4
     5dc:	jsr (a4)
	WaitVbl();
     5de:	jsr (a4)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     5e0:	move.w #32767,150(a2)
	for (int a = 0; a < 32; a++)
     5e6:	moveq #0,d1
		custom->color[a] = 0;
     5e8:	move.l d1,d0
     5ea:	addi.l #192,d0
     5f0:	add.l d0,d0
     5f2:	move.w #0,(0,a2,d0.l)
	for (int a = 0; a < 32; a++)
     5f8:	addq.l #1,d1
     5fa:	moveq #32,d4
     5fc:	cmp.l d1,d4
     5fe:	bne.s 5e8 <main+0x574>
	LoadView(0);
     600:	movea.l 1d7b8 <GfxBase>,a6
     606:	suba.l a1,a1
     608:	jsr -222(a6)
	WaitTOF();
     60c:	movea.l 1d7b8 <GfxBase>,a6
     612:	jsr -270(a6)
	WaitTOF();
     616:	movea.l 1d7b8 <GfxBase>,a6
     61c:	jsr -270(a6)
	WaitVbl();
     620:	jsr (a4)
	WaitVbl();
     622:	jsr (a4)
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     624:	move.w #20090,50(sp)
     62a:	move.w #2049,52(sp)
     630:	move.w #20083,54(sp)
	if (SysBase->AttnFlags & AFF_68010)
     636:	movea.l 1d7bc <SysBase>,a6
     63c:	btst #0,297(a6)
     642:	beq.w 112e <main+0x10ba>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     646:	moveq #50,d7
     648:	add.l sp,d7
     64a:	exg d7,a5
     64c:	jsr -30(a6)
     650:	exg d7,a5
	VBR = GetVBR();
     652:	move.l d0,1d7ac <VBR>
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     658:	movea.l 1d7ac <VBR>,a0
     65e:	move.l 108(a0),d0
	SystemIrq = GetInterruptHandler(); //store interrupt register
     662:	move.l d0,1d7a8 <SystemIrq>
	WaitVbl();
     668:	jsr (a4)
	SetupCopper(copPtr);
     66a:	movea.l 1d7b0 <copPtr>,a2
	*copPtr++ = DIWSTRT;
     670:	move.w #142,(a2)
	*copPtr++ = 0x2c81;
     674:	move.w #11393,2(a2)
	*copPtr++ = DIWSTOP;
     67a:	move.w #144,4(a2)
	*copPtr++ = 0x2cc1;
     680:	move.w #11457,6(a2)
	*copPtr++ = DDFSTRT;
     686:	move.w #146,8(a2)
	*copPtr++ = 0x38; // + ((Screen.Width - BmpLogo.Width) / 4);
     68c:	move.w #56,10(a2)
	*copPtr++ = DDFSTOP;
     692:	move.w #148,12(a2)
	*copPtr++ = 0xd0; // - ((Screen.Width - BmpLogo.Width) / 4);
     698:	move.w #208,14(a2)
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl);
     69e:	move.w 535e <BmpUpperPart_PF1+0x8>,d5
     6a4:	move.w 5360 <BmpUpperPart_PF1+0xa>,d0
     6aa:	sub.w d5,d0
}

inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     6ac:	move.w #264,16(a2)
    *copListEnd++ = modOdd;
     6b2:	move.w d0,18(a2)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     6b6:	move.w #266,20(a2)
    *copListEnd++ = modEven;
     6bc:	move.w d0,22(a2)
	*copPtr++ = BPLCON1; //scrolling
     6c0:	move.w #258,24(a2)
	*copPtr++ = 0;
     6c6:	clr.w 26(a2)
	*copPtr++ = BPLCON2; //playfied priority
     6ca:	move.w #260,28(a2)
	*copPtr++ = 1 << 6;	 //0x24;  Sprites have priority over playfields
     6d0:	move.w #64,30(a2)
    return copListEnd;
}

inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     6d6:	move.w #384,32(a2)
    *copListCurrent++ = color;
     6dc:	clr.w 34(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     6e0:	move.w #386,36(a2)
    *copListCurrent++ = color;
     6e6:	move.w #1366,38(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     6ec:	move.w #388,40(a2)
    *copListCurrent++ = color;
     6f2:	move.w #3221,42(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     6f8:	move.w #390,44(a2)
    *copListCurrent++ = color;
     6fe:	move.w #3750,46(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     704:	move.w #392,48(a2)
    *copListCurrent++ = color;
     70a:	move.w #1074,50(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     710:	move.w #394,52(a2)
    *copListCurrent++ = color;
     716:	move.w #1329,54(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     71c:	move.w #396,56(a2)
    *copListCurrent++ = color;
     722:	move.w #530,58(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     728:	move.w #398,60(a2)
    *copListCurrent++ = color;
     72e:	move.w #2177,62(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     734:	move.w #400,64(a2)
    *copListCurrent++ = color;
     73a:	move.w #204,66(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     740:	move.w #402,68(a2)
    *copListCurrent++ = color;
     746:	move.w #4095,70(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     74c:	move.w #404,72(a2)
    *copListCurrent++ = color;
     752:	move.w #2592,74(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     758:	move.w #406,76(a2)
    *copListCurrent++ = color;
     75e:	move.w #2880,78(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     764:	move.w #408,80(a2)
    *copListCurrent++ = color;
     76a:	move.w #3184,82(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     770:	move.w #410,84(a2)
    *copListCurrent++ = color;
     776:	move.w #3472,86(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     77c:	move.w #412,88(a2)
    *copListCurrent++ = color;
     782:	move.w #3760,90(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     788:	move.w #414,92(a2)
    *copListCurrent++ = color;
     78e:	lea 96(a2),a0
     792:	move.w #128,94(a2)
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
     798:	move.w 535a <BmpUpperPart_PF1+0x4>,d6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     79e:	move.l 5366 <BmpUpperPart_PF1+0x10>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     7a4:	tst.w d6
     7a6:	beq.s 7f8 <main+0x784>
        addr += Bpl;
     7a8:	andi.l #65535,d5
     7ae:	move.w d6,d4
     7b0:	subq.w #1,d4
     7b2:	andi.l #65535,d4
     7b8:	moveq #13,d0
     7ba:	add.l d0,d4
     7bc:	lsl.l #3,d4
     7be:	add.l a2,d4
    *copListCurrent++ = color;
     7c0:	movea.l a0,a1
    BYTE plane = odd ? 1 : 0;
     7c2:	clr.b d2
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     7c4:	move.b d2,d0
     7c6:	ext.w d0
     7c8:	lsl.w #2,d0
     7ca:	addi.w #224,d0
     7ce:	move.w d0,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     7d0:	move.l d1,d3
     7d2:	clr.w d3
     7d4:	swap d3
     7d6:	move.w d3,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     7da:	addq.w #2,d0
     7dc:	move.w d0,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     7e0:	addq.l #8,a1
     7e2:	move.w d1,-2(a1)
        addr += Bpl;
     7e6:	add.l d5,d1
        plane += 2;
     7e8:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     7ea:	cmp.l a1,d4
     7ec:	bne.s 7c4 <main+0x750>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     7ee:	andi.l #65535,d6
     7f4:	lsl.l #3,d6
     7f6:	adda.l d6,a0
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
     7f8:	move.w 532a <BmpUpperPart_PF2+0x8>,d4
     7fe:	move.w 5326 <BmpUpperPart_PF2+0x4>,d0
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     804:	move.l 5332 <BmpUpperPart_PF2+0x10>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     80a:	tst.w d0
     80c:	beq.w 1148 <main+0x10d4>
        addr += Bpl;
     810:	andi.l #65535,d4
     816:	andi.l #65535,d0
     81c:	lsl.l #3,d0
     81e:	lea (0,a0,d0.l),a1
    BYTE plane = odd ? 1 : 0;
     822:	moveq #1,d2
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     824:	move.b d2,d0
     826:	ext.w d0
     828:	lsl.w #2,d0
     82a:	addi.w #224,d0
     82e:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     830:	move.l d1,d3
     832:	clr.w d3
     834:	swap d3
     836:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     83a:	addq.w #2,d0
     83c:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     840:	addq.l #8,a0
     842:	move.w d1,-2(a0)
        addr += Bpl;
     846:	add.l d4,d1
        plane += 2;
     848:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     84a:	cmpa.l a0,a1
     84c:	bne.s 824 <main+0x7b0>
	*copPtr++ = BPLCON0;
     84e:	move.w #256,(a1)
	*copPtr++ = ((BmpLogo.Bpls*2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     852:	moveq #0,d5
     854:	move.w 52f2 <BmpLogo+0x4>,d5
     85a:	move.l d5,d0
     85c:	moveq #13,d1
     85e:	lsl.l d1,d0
     860:	ori.w #1536,d0
     864:	move.w d0,2(a1)
	copPtr = copWaitY(copPtr, 0x2c + BmpUpperPart_PF1.Height);
     868:	move.w 5358 <BmpUpperPart_PF1+0x2>,d0
     86e:	addi.w #44,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     872:	lsl.w #8,d0
     874:	ori.w #5,d0
     878:	move.w d0,4(a1)
    *copListEnd++ = COP_WAIT;
     87c:	move.w #-2,6(a1)
						  BmpScroller.Bplt - Screen.Bpl);
     882:	move.w 5394 <BmpScroller+0xa>,d0
     888:	addi.w #-40,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     88c:	move.w #264,8(a1)
    *copListEnd++ = modOdd;
     892:	move.w d0,10(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     896:	move.w #266,12(a1)
    *copListEnd++ = modEven;
     89c:	lea 16(a1),a3
     8a0:	move.w d0,14(a1)
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     8a4:	move.l a3,1d796 <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     8aa:	move.w 5392 <BmpScroller+0x8>,d3
     8b0:	move.w 538e <BmpScroller+0x4>,d4
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     8b6:	move.l 539a <BmpScroller+0x10>,d0
    for (USHORT i = 0; i < numPlanes; i++)
     8bc:	tst.w d4
     8be:	beq.s 908 <main+0x894>
        addr += Bpl;
     8c0:	andi.l #65535,d3
     8c6:	move.w d4,d1
     8c8:	subq.w #1,d1
     8ca:	andi.l #65535,d1
     8d0:	addq.l #3,d1
     8d2:	lsl.l #3,d1
     8d4:	adda.l d1,a1
     8d6:	movea.l a3,a0
     8d8:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     8dc:	move.w d1,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     8de:	move.l d0,d2
     8e0:	clr.w d2
     8e2:	swap d2
     8e4:	move.w d2,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     8e8:	move.w d1,d2
     8ea:	addq.w #2,d2
     8ec:	move.w d2,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     8f0:	addq.l #8,a0
     8f2:	move.w d0,-2(a0)
        addr += Bpl;
     8f6:	add.l d3,d0
    for (USHORT i = 0; i < numPlanes; i++)
     8f8:	addq.w #4,d1
     8fa:	cmpa.l a0,a1
     8fc:	bne.s 8dc <main+0x868>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     8fe:	andi.l #65535,d4
     904:	lsl.l #3,d4
     906:	adda.l d4,a3
	*copPtr++ = BPLCON0;
     908:	move.w #256,(a3)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     90c:	moveq #12,d3
     90e:	lsl.l d3,d5
     910:	ori.w #512,d5
     914:	move.w d5,2(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     918:	move.w #384,4(a3)
    *copListCurrent++ = color;
     91e:	clr.w 6(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     922:	move.w #386,8(a3)
    *copListCurrent++ = color;
     928:	move.w #23,10(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     92e:	move.w #388,12(a3)
    *copListCurrent++ = color;
     934:	move.w #601,14(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     93a:	move.w #390,16(a3)
    *copListCurrent++ = color;
     940:	move.w #874,18(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     946:	move.w #392,20(a3)
    *copListCurrent++ = color;
     94c:	move.w #1163,22(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     952:	move.w #394,24(a3)
    *copListCurrent++ = color;
     958:	move.w #1469,26(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     95e:	move.w #396,28(a3)
    *copListCurrent++ = color;
     964:	move.w #1758,30(a3)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     96a:	move.w #398,32(a3)
    *copListCurrent++ = color;
     970:	move.w #2303,34(a3)
	copPtr = copWaitY(copPtr, 0x2c + BmpLogo.Height + 64);
     976:	move.w 52f0 <BmpLogo+0x2>,d0
     97c:	addi.w #108,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     980:	lsl.w #8,d0
     982:	ori.w #5,d0
     986:	move.w d0,36(a3)
    *copListEnd++ = COP_WAIT;
     98a:	move.w #-2,38(a3)
     990:	lea 40(a3),a0
     994:	move.l a0,1d78c <copMirrorBmpP>
						  (BmpLogo.Bplt - BmpLogo.Bpl));
     99a:	move.w 52f8 <BmpLogo+0xa>,d0
     9a0:	sub.w 52f6 <BmpLogo+0x8>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     9a6:	move.w #264,40(a3)
    *copListEnd++ = modOdd;
     9ac:	move.w d0,42(a3)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     9b0:	move.w #266,44(a3)
    *copListEnd++ = modEven;
     9b6:	move.w d0,46(a3)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     9ba:	move.w #-1,48(a3)
    *copListEnd++ = COP_WAIT;
     9c0:	move.w #-2,50(a3)
	custom->cop1lc = (ULONG)copPtr;
     9c6:	movea.l 1d7c2 <custom>,a0
     9cc:	move.l a2,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
     9d0:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
     9d6:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER;
     9dc:	move.w #-31808,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     9e2:	movea.l 1d7ac <VBR>,a1
     9e8:	move.l #4432,108(a1)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
     9f0:	move.w #-16352,154(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // ThePlayer needs INTF_EXTER
     9f6:	move.w #-24576,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
     9fc:	move.w #32,156(a0)
	// custom->bltsize = bltsize;
}

int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
	register volatile const void *_a0 ASM("a0") = module;
     a02:	lea 19c88 <incbin_module_start>,a0
	register volatile const void *_a1 ASM("a1") = NULL;
     a08:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
     a0a:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = player;
     a0c:	lea 164e <incbin_player_start>,a3
	register int _d0 ASM("d0"); // return value
	__asm volatile(
     a12:	movem.l d1-d7/a4-a6,-(sp)
     a16:	jsr (a3)
     a18:	movem.l (sp)+,d1-d7/a4-a6
	if (p61Init(module) != 0)
     a1c:	tst.l d0
     a1e:	bne.w 10c2 <main+0x104e>
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
     a22:	move.w 52f2 <BmpLogo+0x4>,d3
     a28:	move.w 52f6 <BmpLogo+0x8>,d2
     a2e:	move.l 52fe <BmpLogo+0x10>,d4
     a34:	movea.w 535e <BmpUpperPart_PF1+0x8>,a1
     a3a:	move.l 5366 <BmpUpperPart_PF1+0x10>,d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     a40:	movea.l 1d7c2 <custom>,a0
     a46:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     a4a:	move.w 2(a0),d0
     a4e:	btst #14,d0
     a52:	bne.s a4a <main+0x9d6>
	custom->bltcon0 = 0x09f0;
     a54:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     a5a:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     a60:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     a66:	move.w #-1,70(a0)
	custom->bltamod = imgA.Bpl - (width / 8);
     a6c:	addi.w #-32,d2
     a70:	move.w d2,100(a0)
	custom->bltdmod = imgD.Bpl - (width / 8);
     a74:	lea -32(a1),a1
     a78:	move.w a1,102(a0)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
     a7c:	move.l d4,80(a0)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
     a80:	addq.l #4,d1
     a82:	move.l d1,84(a0)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
     a86:	move.w d3,d0
     a88:	lsl.w #6,d0
     a8a:	add.w d3,d0
     a8c:	lsl.w #7,d0
     a8e:	addi.w #16,d0
     a92:	move.w d0,88(a0)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
     a96:	move.b bfe001 <_end+0xbe0839>,d0
	while (!MouseLeft())
     a9c:	btst #6,d0
     aa0:	beq.w c5e <main+0xbea>
				ScrollerDir = (ScrollerMax - ScrollerY)*1000/12000;
     aa4:	move.w 1d79a <ScrollerY>,d5
		Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
     aaa:	move.l 539a <BmpScroller+0x10>,d3
     ab0:	move.w 538e <BmpScroller+0x4>,d4
     ab6:	lea 538a <BmpScroller>,a3
     abc:	lea 1470 <__mulsi3>,a2
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     ac2:	lea 300f <Scrolltext>,a5
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     ac8:	move.l dff004 <_end+0xde183c>,d0
     ace:	move.l d0,50(sp)
		vpos &= 0x1ff00;
     ad2:	move.l 50(sp),d0
     ad6:	andi.l #130816,d0
     adc:	move.l d0,50(sp)
		if (vpos != (311 << 8))
     ae0:	move.l 50(sp),d0
     ae4:	cmpi.l #79616,d0
     aea:	beq.s ac8 <main+0xa54>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     aec:	move.l dff004 <_end+0xde183c>,d0
     af2:	move.l d0,46(sp)
		vpos &= 0x1ff00;
     af6:	move.l 46(sp),d0
     afa:	andi.l #130816,d0
     b00:	move.l d0,46(sp)
		if (vpos == (311 << 8))
     b04:	move.l 46(sp),d0
     b08:	cmpi.l #79616,d0
     b0e:	bne.s aec <main+0xa78>
		if (BounceEnabled)
     b10:	tst.w 1d79c <BounceEnabled>
     b16:	beq.s b50 <main+0xadc>
			if(ScrollerDir > 0)
     b18:	move.b 5250 <ScrollerDir>,d0
     b1e:	ble.w 1030 <main+0xfbc>
				ScrollerDir = (ScrollerMax - ScrollerY)*1000/12000;
     b22:	pea c <_start+0xc>
     b26:	movea.w #38,a1
     b2a:	suba.w d5,a1
     b2c:	move.l a1,-(sp)
     b2e:	jsr 14ee <__divsi3>
     b34:	addq.l #8,sp
				if(ScrollerDir > 6) ScrollerDir = 6;
     b36:	cmpi.b #6,d0
     b3a:	ble.w 104e <main+0xfda>
     b3e:	move.b #6,5250 <ScrollerDir>
     b46:	moveq #6,d0
			ScrollerY += ScrollerDir;
     b48:	add.w d0,d5
     b4a:	move.w d5,1d79a <ScrollerY>
		if (ScrollerY >= ScrollerMax)
     b50:	movea.w d5,a0
     b52:	cmpi.w #37,d5
     b56:	ble.w f9c <main+0xf28>
			ScrollerY = ScrollerMax;
     b5a:	move.w #38,1d79a <ScrollerY>
			ScrollerDir = -1;
     b62:	st 5250 <ScrollerDir>
		Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
     b68:	move.w 5394 <BmpScroller+0xa>,d2
	int BltOffs = startY * theDesc.Bplt;
     b6e:	move.w d2,d5
     b70:	mulu.w #40,d5
	int Brcorner = height * theDesc.Bplt - 2;
     b74:	andi.l #65535,d2
     b7a:	lsl.l #5,d2
     b7c:	subq.l #2,d2
	WaitBlit();
     b7e:	movea.l 1d7b8 <GfxBase>,a6
     b84:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     b88:	movea.l 1d7c2 <custom>,a0
     b8e:	move.w #18928,64(a0)
	custom->bltcon1 = 0x0002;
     b94:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     b9a:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     ba0:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     ba6:	add.l d5,d2
     ba8:	add.l d2,d3
     baa:	move.l d3,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     bae:	move.l d3,84(a0)
	custom->bltamod = 0;
     bb2:	move.w #0,100(a0)
	custom->bltdmod = 0;
     bb8:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
     bbe:	moveq #11,d0
     bc0:	lsl.w d0,d4
     bc2:	move.w (a3),d0
     bc4:	lsr.w #4,d0
     bc6:	add.w d0,d4
     bc8:	move.w d4,88(a0)
	ScrollCnt += speed;
     bcc:	move.w 1d794 <ScrollCnt>,d0
     bd2:	addq.w #4,d0
     bd4:	move.w d0,1d794 <ScrollCnt>
	if (ScrollCnt >= 32)
     bda:	cmpi.w #31,d0
     bde:	bhi.w d84 <main+0xd10>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
     be2:	move.w 5392 <BmpScroller+0x8>,d2
     be8:	move.l 539a <BmpScroller+0x10>,d3
     bee:	move.w 1d79a <ScrollerY>,d5
     bf4:	move.w 538e <BmpScroller+0x4>,d4
     bfa:	moveq #0,d6
     bfc:	move.w d4,d6
     bfe:	movea.l 1d796 <copScrollerBmpP>,a6
     c04:	andi.l #65535,d2
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     c0a:	move.l d2,-(sp)
     c0c:	movea.w d5,a0
     c0e:	move.l a0,-(sp)
     c10:	jsr (a2)
     c12:	addq.l #4,sp
     c14:	move.l d6,(sp)
     c16:	move.l d0,-(sp)
     c18:	jsr (a2)
     c1a:	addq.l #8,sp
     c1c:	add.l d3,d0
    for (USHORT i = 0; i < numPlanes; i++)
     c1e:	tst.l d6
     c20:	beq.s c50 <main+0xbdc>
     c22:	suba.l a0,a0
        addr += Bpl;
     c24:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     c28:	move.w d1,(a6)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     c2a:	move.l d0,d7
     c2c:	clr.w d7
     c2e:	swap d7
     c30:	move.w d7,2(a6)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     c34:	movea.w d1,a1
     c36:	addq.w #2,a1
     c38:	move.w a1,4(a6)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     c3c:	addq.l #8,a6
     c3e:	move.w d0,-2(a6)
        addr += Bpl;
     c42:	add.l d2,d0
    for (USHORT i = 0; i < numPlanes; i++)
     c44:	addq.w #1,a0
     c46:	addq.w #4,d1
     c48:	moveq #0,d7
     c4a:	move.w a0,d7
     c4c:	cmp.l d6,d7
     c4e:	blt.s c28 <main+0xbb4>
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
     c50:	move.b bfe001 <_end+0xbe0839>,d0
	while (!MouseLeft())
     c56:	btst #6,d0
     c5a:	bne.w ac8 <main+0xa54>
		: "cc", "memory");
}

void p61End()
{
	register volatile const void *_a3 ASM("a3") = player;
     c5e:	lea 164e <incbin_player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
     c64:	movea.l #14675968,a6
	__asm volatile(
     c6a:	movem.l d0-d1/a0-a1,-(sp)
     c6e:	jsr 8(a3)
     c72:	movem.l (sp)+,d0-d1/a0-a1
	FreeMem(copPtr, 1024);
     c76:	movea.l 1d7bc <SysBase>,a6
     c7c:	movea.l 1d7b0 <copPtr>,a1
     c82:	move.l #1024,d0
     c88:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
     c8c:	movea.l 1d7bc <SysBase>,a6
     c92:	movea.l 539a <BmpScroller+0x10>,a1
     c98:	moveq #0,d0
     c9a:	move.w 5398 <BmpScroller+0xe>,d0
     ca0:	jsr -210(a6)
	WaitVbl();
     ca4:	jsr (a4)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     ca6:	movea.l 1d7c2 <custom>,a0
     cac:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     cb0:	move.w 2(a0),d0
     cb4:	btst #14,d0
     cb8:	bne.s cb0 <main+0xc3c>
	custom->intena = 0x7fff; //disable all interrupts
     cba:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     cc0:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     cc6:	move.w #32767,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     ccc:	movea.l 1d7ac <VBR>,a1
     cd2:	move.l 1d7a8 <SystemIrq>,108(a1)
	custom->cop1lc = (ULONG)GfxBase->copinit;
     cda:	movea.l 1d7b8 <GfxBase>,a6
     ce0:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     ce6:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     cec:	move.w #32767,136(a0)
	custom->intena = SystemInts | 0x8000;
     cf2:	move.w 1d7a6 <SystemInts>,d0
     cf8:	ori.w #-32768,d0
     cfc:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     d00:	move.w 1d7a4 <SystemDMA>,d0
     d06:	ori.w #-32768,d0
     d0a:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     d0e:	move.w 1d7a2 <SystemADKCON>,d0
     d14:	ori.w #-32768,d0
     d18:	move.w d0,158(a0)
	LoadView(ActiView);
     d1c:	movea.l 1d79e <ActiView>,a1
     d22:	jsr -222(a6)
	WaitTOF();
     d26:	movea.l 1d7b8 <GfxBase>,a6
     d2c:	jsr -270(a6)
	WaitTOF();
     d30:	movea.l 1d7b8 <GfxBase>,a6
     d36:	jsr -270(a6)
	WaitBlit();
     d3a:	movea.l 1d7b8 <GfxBase>,a6
     d40:	jsr -228(a6)
	DisownBlitter();
     d44:	movea.l 1d7b8 <GfxBase>,a6
     d4a:	jsr -462(a6)
	Enable();
     d4e:	movea.l 1d7bc <SysBase>,a6
     d54:	jsr -126(a6)
	CloseLibrary((struct Library *)DOSBase);
     d58:	movea.l 1d7bc <SysBase>,a6
     d5e:	movea.l 1d7b4 <DOSBase>,a1
     d64:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
     d68:	movea.l 1d7bc <SysBase>,a6
     d6e:	movea.l 1d7b8 <GfxBase>,a1
     d74:	jsr -414(a6)
}
     d78:	moveq #0,d0
     d7a:	movem.l (sp)+,d2-d7/a2-a6
     d7e:	lea 12(sp),sp
     d82:	rts
		ScrollCnt = 0;
     d84:	clr.w 1d794 <ScrollCnt>
		PlotChar(BmpFont32, (UBYTE *)BmpFont32P, BmpScroller, (UBYTE *)BmpScroller.ImageData, startY, 32, 32);
     d8a:	move.l 539a <BmpScroller+0x10>,d3
     d90:	move.w 52be <BmpFont32+0x4>,d5
     d96:	move.w 52c2 <BmpFont32+0x8>,d6
     d9c:	movea.w 52c4 <BmpFont32+0xa>,a1
     da2:	move.w 5392 <BmpScroller+0x8>,d2
     da8:	movea.w 5394 <BmpScroller+0xa>,a6
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     dae:	movea.w 1d792 <ScrolltextCnt>,a0
     db4:	move.w a0,d1
     db6:	addq.w #1,d1
     db8:	move.w d1,1d792 <ScrolltextCnt>
     dbe:	moveq #0,d0
     dc0:	move.w a0,d0
     dc2:	move.b (0,a5,d0.l),d0
	if (chr == 'b')
     dc6:	cmpi.b #98,d0
     dca:	beq.w f60 <main+0xeec>
	if (chr == 'm')
     dce:	cmpi.b #109,d0
     dd2:	beq.w e66 <main+0xdf2>
	if (chr == 0)
     dd6:	tst.b d0
     dd8:	bne.w eb8 <main+0xe44>
		chr = Scrolltext[ScrolltextCnt++];
     ddc:	move.w #1,1d792 <ScrolltextCnt>
     de4:	moveq #24,d7
     de6:	moveq #6,d1
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     de8:	move.l d1,-(sp)
     dea:	move.w a1,-(sp)
     dec:	clr.w -(sp)
     dee:	jsr (a2)
     df0:	addq.l #8,sp
     df2:	move.l d0,d4
     df4:	lsl.l #5,d4
     df6:	add.l d7,d4
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     df8:	moveq #0,d0
     dfa:	move.w a6,d0
     dfc:	addq.l #1,d0
     dfe:	move.l d0,d7
     e00:	add.l d0,d7
     e02:	add.l d7,d7
     e04:	add.l d0,d7
     e06:	lsl.l #3,d7
	WaitBlit();
     e08:	movea.l 1d7b8 <GfxBase>,a6
     e0e:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     e12:	movea.l 1d7c2 <custom>,a0
     e18:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     e1e:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     e24:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     e2a:	move.w #-1,70(a0)
	custom->bltapt = bmpFontP + source;
     e30:	addi.l #33922,d4
     e36:	move.l d4,80(a0)
	custom->bltdpt = bmpDestP + dest;
     e3a:	add.l d7,d3
     e3c:	move.l d3,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     e40:	subq.w #4,d6
     e42:	move.w d6,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     e46:	subq.w #4,d2
     e48:	move.w d2,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     e4c:	moveq #11,d0
     e4e:	lsl.w d0,d5
     e50:	addq.w #2,d5
     e52:	move.w d5,88(a0)
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
     e56:	move.w 5392 <BmpScroller+0x8>,d2
     e5c:	move.l 539a <BmpScroller+0x10>,d3
     e62:	bra.w bee <main+0xb7a>
		if (MirrorEnabled)
     e66:	move.w 1d790 <MirrorEnabled>,d0
				 BmpScroller.Bplt - Screen.Bpl);
     e6c:	move.w a6,d4
     e6e:	addi.w #-40,d4
	copSetBplMod(0, copMirrorBmpP,
     e72:	movea.l 1d78c <copMirrorBmpP>,a0
		if (MirrorEnabled)
     e78:	tst.w d0
     e7a:	beq.w 1084 <main+0x1010>
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     e7e:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     e82:	move.w d4,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     e86:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     e8c:	move.w d4,6(a0)
		MirrorEnabled = !MirrorEnabled;
     e90:	tst.w d0
     e92:	seq d0
     e94:	ext.w d0
     e96:	neg.w d0
     e98:	move.w d0,1d790 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     e9e:	move.w d1,d4
     ea0:	addq.w #1,d4
     ea2:	move.w d4,1d792 <ScrolltextCnt>
     ea8:	andi.l #65535,d1
     eae:	move.b (0,a5,d1.l),d0
	if (chr == 0)
     eb2:	tst.b d0
     eb4:	beq.w ddc <main+0xd68>
	if (chr < 32 || chr > (32 + 80))
     eb8:	addi.b #-32,d0
     ebc:	cmpi.b #80,d0
     ec0:	bhi.w bee <main+0xb7a>
	row = chr / 10;
     ec4:	andi.w #255,d0
     ec8:	move.w d0,d4
     eca:	mulu.w #-13107,d4
     ece:	clr.w d4
     ed0:	swap d4
     ed2:	lsr.w #3,d4
     ed4:	moveq #0,d1
     ed6:	move.b d4,d1
	col = chr % 10;
     ed8:	movea.w d4,a0
     eda:	adda.w d4,a0
     edc:	adda.w a0,a0
     ede:	adda.w d4,a0
     ee0:	adda.w a0,a0
     ee2:	sub.w a0,d0
     ee4:	moveq #0,d4
     ee6:	move.b d0,d4
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     ee8:	add.l d4,d4
     eea:	move.l d4,d7
     eec:	add.l d4,d7
     eee:	move.l d1,-(sp)
     ef0:	move.w a1,-(sp)
     ef2:	clr.w -(sp)
     ef4:	jsr (a2)
     ef6:	addq.l #8,sp
     ef8:	move.l d0,d4
     efa:	lsl.l #5,d4
     efc:	add.l d7,d4
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     efe:	moveq #0,d0
     f00:	move.w a6,d0
     f02:	addq.l #1,d0
     f04:	move.l d0,d7
     f06:	add.l d0,d7
     f08:	add.l d7,d7
     f0a:	add.l d0,d7
     f0c:	lsl.l #3,d7
	WaitBlit();
     f0e:	movea.l 1d7b8 <GfxBase>,a6
     f14:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     f18:	movea.l 1d7c2 <custom>,a0
     f1e:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     f24:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     f2a:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     f30:	move.w #-1,70(a0)
	custom->bltapt = bmpFontP + source;
     f36:	addi.l #33922,d4
     f3c:	move.l d4,80(a0)
	custom->bltdpt = bmpDestP + dest;
     f40:	add.l d7,d3
     f42:	move.l d3,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     f46:	subq.w #4,d6
     f48:	move.w d6,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     f4c:	subq.w #4,d2
     f4e:	move.w d2,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     f52:	moveq #11,d0
     f54:	lsl.w d0,d5
     f56:	addq.w #2,d5
     f58:	move.w d5,88(a0)
     f5c:	bra.w e56 <main+0xde2>
		if (BounceEnabled)
     f60:	move.w 1d79c <BounceEnabled>,d0
     f66:	beq.s f6e <main+0xefa>
			ScrollerY = 0;
     f68:	clr.w 1d79a <ScrollerY>
		BounceEnabled = !BounceEnabled;
     f6e:	tst.w d0
     f70:	seq d0
     f72:	ext.w d0
     f74:	neg.w d0
     f76:	move.w d0,1d79c <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     f7c:	addq.w #2,a0
     f7e:	move.w a0,1d792 <ScrolltextCnt>
     f84:	andi.l #65535,d1
     f8a:	move.b (0,a5,d1.l),d0
     f8e:	move.w a0,d1
	if (chr == 'm')
     f90:	cmpi.b #109,d0
     f94:	bne.w dd6 <main+0xd62>
     f98:	bra.w e66 <main+0xdf2>
		else if (ScrollerY <= ScrollerMin)
     f9c:	cmpa.w #0,a0
     fa0:	bgt.w b68 <main+0xaf4>
			ScrollerY = ScrollerMin;
     fa4:	clr.w 1d79a <ScrollerY>
			ScrollerDir = 1;
     faa:	move.b #1,5250 <ScrollerDir>
		Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
     fb2:	move.w 5394 <BmpScroller+0xa>,d2
	int BltOffs = startY * theDesc.Bplt;
     fb8:	move.w d2,d5
     fba:	mulu.w #40,d5
	int Brcorner = height * theDesc.Bplt - 2;
     fbe:	andi.l #65535,d2
     fc4:	lsl.l #5,d2
     fc6:	subq.l #2,d2
	WaitBlit();
     fc8:	movea.l 1d7b8 <GfxBase>,a6
     fce:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     fd2:	movea.l 1d7c2 <custom>,a0
     fd8:	move.w #18928,64(a0)
	custom->bltcon1 = 0x0002;
     fde:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     fe4:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     fea:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     ff0:	add.l d5,d2
     ff2:	add.l d2,d3
     ff4:	move.l d3,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     ff8:	move.l d3,84(a0)
	custom->bltamod = 0;
     ffc:	move.w #0,100(a0)
	custom->bltdmod = 0;
    1002:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
    1008:	moveq #11,d0
    100a:	lsl.w d0,d4
    100c:	move.w (a3),d0
    100e:	lsr.w #4,d0
    1010:	add.w d0,d4
    1012:	move.w d4,88(a0)
	ScrollCnt += speed;
    1016:	move.w 1d794 <ScrollCnt>,d0
    101c:	addq.w #4,d0
    101e:	move.w d0,1d794 <ScrollCnt>
	if (ScrollCnt >= 32)
    1024:	cmpi.w #31,d0
    1028:	bls.w be2 <main+0xb6e>
    102c:	bra.w d84 <main+0xd10>
				ScrollerDir -= 1;
    1030:	subq.b #1,d0
				if(ScrollerDir < -4) ScrollerDir = -4;
    1032:	cmpi.b #-4,d0
    1036:	bge.s 106a <main+0xff6>
    1038:	move.b #-4,5250 <ScrollerDir>
    1040:	moveq #-4,d0
			ScrollerY += ScrollerDir;
    1042:	add.w d0,d5
    1044:	move.w d5,1d79a <ScrollerY>
    104a:	bra.w b50 <main+0xadc>
				if(ScrollerDir < 1) ScrollerDir =1;
    104e:	tst.b d0
    1050:	bgt.w 1134 <main+0x10c0>
    1054:	move.b #1,5250 <ScrollerDir>
    105c:	moveq #1,d0
			ScrollerY += ScrollerDir;
    105e:	add.w d0,d5
    1060:	move.w d5,1d79a <ScrollerY>
    1066:	bra.w b50 <main+0xadc>
				if(ScrollerDir > -1) ScrollerDir = -1;
    106a:	tst.b d0
    106c:	blt.w 1134 <main+0x10c0>
    1070:	st 5250 <ScrollerDir>
    1076:	moveq #-1,d0
			ScrollerY += ScrollerDir;
    1078:	add.w d0,d5
    107a:	move.w d5,1d79a <ScrollerY>
    1080:	bra.w b50 <main+0xadc>
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
    1084:	move.w a6,d7
    1086:	add.w a6,d7
    1088:	sub.w d7,d4
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    108a:	move.w #264,(a0)
    *copListEnd++ = modOdd;
    108e:	move.w d4,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    1092:	move.w #266,4(a0)
    *copListEnd++ = modEven;
    1098:	move.w d4,6(a0)
		MirrorEnabled = !MirrorEnabled;
    109c:	tst.w d0
    109e:	seq d0
    10a0:	ext.w d0
    10a2:	neg.w d0
    10a4:	move.w d0,1d790 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
    10aa:	move.w d1,d4
    10ac:	addq.w #1,d4
    10ae:	move.w d4,1d792 <ScrolltextCnt>
    10b4:	andi.l #65535,d1
    10ba:	move.b (0,a5,d1.l),d0
    10be:	bra.w eb2 <main+0xe3e>
		KPrintF("p61Init failed!\n");
    10c2:	pea 2ffe <incbin_player_end+0x4a>
    10c8:	jsr (a5)
    10ca:	addq.l #4,sp
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
    10cc:	move.w 52f2 <BmpLogo+0x4>,d3
    10d2:	move.w 52f6 <BmpLogo+0x8>,d2
    10d8:	move.l 52fe <BmpLogo+0x10>,d4
    10de:	movea.w 535e <BmpUpperPart_PF1+0x8>,a1
    10e4:	move.l 5366 <BmpUpperPart_PF1+0x10>,d1
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    10ea:	movea.l 1d7c2 <custom>,a0
    10f0:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    10f4:	bra.w a4a <main+0x9d6>
		Exit(0);
    10f8:	suba.l a6,a6
    10fa:	moveq #0,d1
    10fc:	jsr -144(a6)
    1100:	bra.w c2 <main+0x4e>
		Exit(0);
    1104:	movea.l 1d7b4 <DOSBase>,a6
    110a:	moveq #0,d1
    110c:	jsr -144(a6)
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    1110:	movea.l 1d7bc <SysBase>,a6
    1116:	lea 2fc6 <incbin_player_end+0x12>,a1
    111c:	moveq #0,d0
    111e:	jsr -552(a6)
    1122:	move.l d0,1d7b4 <DOSBase>
	if (!DOSBase)
    1128:	bne.w c2 <main+0x4e>
    112c:	bra.s 10f8 <main+0x1084>
	APTR vbr = 0;
    112e:	moveq #0,d0
    1130:	bra.w 652 <main+0x5de>
				ScrollerDir -= 1;
    1134:	move.b d0,5250 <ScrollerDir>
			ScrollerY += ScrollerDir;
    113a:	ext.w d0
    113c:	add.w d0,d5
    113e:	move.w d5,1d79a <ScrollerY>
    1144:	bra.w b50 <main+0xadc>
    for (USHORT i = 0; i < numPlanes; i++)
    1148:	movea.l a0,a1
    114a:	bra.w 84e <main+0x7da>
    114e:	nop

00001150 <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);
void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls);
static __attribute__((interrupt)) void interruptHandler()
{
    1150:	movem.l d0/a0/a3/a6,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    1154:	movea.l 1d7c2 <custom>,a0
    115a:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    1160:	move.w #32,156(a0)
	register volatile const void *_a3 ASM("a3") = player;
    1166:	lea 164e <incbin_player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    116c:	movea.l #14675968,a6
	__asm volatile(
    1172:	movem.l d0-a2/a4-a5,-(sp)
    1176:	jsr 4(a3)
    117a:	movem.l (sp)+,d0-a2/a4-a5

    // DEMO - ThePlayer
    p61Music();

    // DEMO - increment frameCounter
    frameCounter++;
    117e:	move.w 1d7c0 <frameCounter>,d0
    1184:	addq.w #1,d0
    1186:	move.w d0,1d7c0 <frameCounter>
}
    118c:	movem.l (sp)+,d0/a0/a3/a6
    1190:	rte

00001192 <WaitVbl>:
{
    1192:	subq.l #8,sp
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    1194:	move.l dff004 <_end+0xde183c>,d0
    119a:	move.l d0,(sp)
		vpos &= 0x1ff00;
    119c:	move.l (sp),d0
    119e:	andi.l #130816,d0
    11a4:	move.l d0,(sp)
		if (vpos != (311 << 8))
    11a6:	move.l (sp),d0
    11a8:	cmpi.l #79616,d0
    11ae:	beq.s 1194 <WaitVbl+0x2>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    11b0:	move.l dff004 <_end+0xde183c>,d0
    11b6:	move.l d0,4(sp)
		vpos &= 0x1ff00;
    11ba:	move.l 4(sp),d0
    11be:	andi.l #130816,d0
    11c4:	move.l d0,4(sp)
		if (vpos == (311 << 8))
    11c8:	move.l 4(sp),d0
    11cc:	cmpi.l #79616,d0
    11d2:	bne.s 11b0 <WaitVbl+0x1e>
}
    11d4:	addq.l #8,sp
    11d6:	rts

000011d8 <KPrintF>:
void KPrintF(const char* fmt, ...) {
    11d8:	lea -128(sp),sp
    11dc:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    11e0:	move.w f0ff60 <_end+0xef2798>,d0
    11e6:	cmpi.w #20153,d0
    11ea:	beq.s 1216 <KPrintF+0x3e>
    11ec:	cmpi.w #-24562,d0
    11f0:	beq.s 1216 <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    11f2:	movea.l 1d7bc <SysBase>,a6
    11f8:	movea.l 144(sp),a0
    11fc:	lea 148(sp),a1
    1200:	lea 156a <KPutCharX>,a2
    1206:	suba.l a3,a3
    1208:	jsr -522(a6)
}
    120c:	movem.l (sp)+,a2-a3/a6
    1210:	lea 128(sp),sp
    1214:	rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    1216:	movea.l 1d7bc <SysBase>,a6
    121c:	movea.l 144(sp),a0
    1220:	lea 148(sp),a1
    1224:	lea 1578 <PutChar>,a2
    122a:	lea 12(sp),a3
    122e:	jsr -522(a6)
		UaeDbgLog(86, temp);
    1232:	move.l a3,-(sp)
    1234:	pea 56 <_start+0x56>
    1238:	jsr f0ff60 <_end+0xef2798>
    123e:	addq.l #8,sp
}
    1240:	movem.l (sp)+,a2-a3/a6
    1244:	lea 128(sp),sp
    1248:	rts

0000124a <strlen>:
unsigned long strlen(const char* s) {
    124a:	movea.l 4(sp),a0
	unsigned long t=0;
    124e:	moveq #0,d0
	while(*s++)
    1250:	tst.b (a0)
    1252:	beq.s 125c <strlen+0x12>
		t++;
    1254:	addq.l #1,d0
	while(*s++)
    1256:	tst.b (0,a0,d0.l)
    125a:	bne.s 1254 <strlen+0xa>
}
    125c:	rts

0000125e <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    125e:	movem.l d2-d7/a2-a3,-(sp)
    1262:	move.l 36(sp),d0
    1266:	move.l 40(sp),d4
    126a:	movea.l 44(sp),a1
	while(len-- > 0)
    126e:	move.l a1,d5
    1270:	subq.l #1,d5
    1272:	cmpa.w #0,a1
    1276:	beq.w 1326 <memset+0xc8>
		*ptr++ = val;
    127a:	move.b d4,d7
    127c:	move.l d0,d1
    127e:	neg.l d1
    1280:	moveq #3,d2
    1282:	and.l d2,d1
    1284:	moveq #5,d6
    1286:	movea.l d0,a2
    1288:	cmp.l d5,d6
    128a:	bcc.s 12f6 <memset+0x98>
    128c:	tst.l d1
    128e:	beq.s 12b4 <memset+0x56>
    1290:	move.b d4,(a2)+
	while(len-- > 0)
    1292:	subq.l #1,d5
    1294:	moveq #1,d2
    1296:	cmp.l d1,d2
    1298:	beq.s 12b4 <memset+0x56>
		*ptr++ = val;
    129a:	movea.l d0,a2
    129c:	addq.l #2,a2
    129e:	movea.l d0,a0
    12a0:	move.b d4,1(a0)
	while(len-- > 0)
    12a4:	subq.l #1,d5
    12a6:	moveq #3,d2
    12a8:	cmp.l d1,d2
    12aa:	bne.s 12b4 <memset+0x56>
		*ptr++ = val;
    12ac:	addq.l #1,a2
    12ae:	move.b d4,2(a0)
	while(len-- > 0)
    12b2:	subq.l #1,d5
    12b4:	move.l a1,d3
    12b6:	sub.l d1,d3
    12b8:	moveq #0,d6
    12ba:	move.b d4,d6
    12bc:	move.l d6,d2
    12be:	swap d2
    12c0:	clr.w d2
    12c2:	movea.l d2,a0
    12c4:	move.l d4,d2
    12c6:	lsl.w #8,d2
    12c8:	swap d2
    12ca:	clr.w d2
    12cc:	lsl.l #8,d6
    12ce:	movea.l d6,a3
    12d0:	move.l a0,d6
    12d2:	or.l d6,d2
    12d4:	move.l a3,d6
    12d6:	or.l d6,d2
    12d8:	move.b d7,d2
    12da:	movea.l d0,a0
    12dc:	adda.l d1,a0
    12de:	moveq #-4,d1
    12e0:	and.l d3,d1
    12e2:	add.l a0,d1
		*ptr++ = val;
    12e4:	move.l d2,(a0)+
	while(len-- > 0)
    12e6:	cmpa.l d1,a0
    12e8:	bne.s 12e4 <memset+0x86>
    12ea:	moveq #-4,d1
    12ec:	and.l d3,d1
    12ee:	adda.l d1,a2
    12f0:	sub.l d1,d5
    12f2:	cmp.l d3,d1
    12f4:	beq.s 1326 <memset+0xc8>
		*ptr++ = val;
    12f6:	move.b d4,(a2)
	while(len-- > 0)
    12f8:	tst.l d5
    12fa:	beq.s 1326 <memset+0xc8>
		*ptr++ = val;
    12fc:	move.b d4,1(a2)
	while(len-- > 0)
    1300:	moveq #1,d1
    1302:	cmp.l d5,d1
    1304:	beq.s 1326 <memset+0xc8>
		*ptr++ = val;
    1306:	move.b d4,2(a2)
	while(len-- > 0)
    130a:	moveq #2,d2
    130c:	cmp.l d5,d2
    130e:	beq.s 1326 <memset+0xc8>
		*ptr++ = val;
    1310:	move.b d4,3(a2)
	while(len-- > 0)
    1314:	moveq #3,d6
    1316:	cmp.l d5,d6
    1318:	beq.s 1326 <memset+0xc8>
		*ptr++ = val;
    131a:	move.b d4,4(a2)
	while(len-- > 0)
    131e:	subq.l #4,d5
    1320:	beq.s 1326 <memset+0xc8>
		*ptr++ = val;
    1322:	move.b d4,5(a2)
}
    1326:	movem.l (sp)+,d2-d7/a2-a3
    132a:	rts

0000132c <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    132c:	movem.l d2-d6,-(sp)
    1330:	move.l 24(sp),d0
    1334:	move.l 28(sp),d1
    1338:	move.l 32(sp),d3
	while(len--)
    133c:	move.l d3,d4
    133e:	subq.l #1,d4
    1340:	tst.l d3
    1342:	beq.s 13a2 <memcpy+0x76>
    1344:	movea.l d1,a0
    1346:	addq.l #1,a0
    1348:	move.l d0,d2
    134a:	sub.l a0,d2
    134c:	moveq #2,d5
    134e:	cmp.l d2,d5
    1350:	sc.s d2
    1352:	neg.b d2
    1354:	moveq #8,d6
    1356:	cmp.l d4,d6
    1358:	sc.s d5
    135a:	neg.b d5
    135c:	and.b d5,d2
    135e:	beq.s 13a8 <memcpy+0x7c>
    1360:	move.l d0,d2
    1362:	or.l d1,d2
    1364:	moveq #3,d5
    1366:	and.l d5,d2
    1368:	bne.s 13a8 <memcpy+0x7c>
    136a:	movea.l d1,a0
    136c:	movea.l d0,a1
    136e:	moveq #-4,d2
    1370:	and.l d3,d2
    1372:	add.l d1,d2
		*d++ = *s++;
    1374:	move.l (a0)+,(a1)+
	while(len--)
    1376:	cmp.l a0,d2
    1378:	bne.s 1374 <memcpy+0x48>
    137a:	moveq #-4,d2
    137c:	and.l d3,d2
    137e:	movea.l d0,a0
    1380:	adda.l d2,a0
    1382:	add.l d2,d1
    1384:	sub.l d2,d4
    1386:	cmp.l d3,d2
    1388:	beq.s 13a2 <memcpy+0x76>
		*d++ = *s++;
    138a:	movea.l d1,a1
    138c:	move.b (a1),(a0)
	while(len--)
    138e:	tst.l d4
    1390:	beq.s 13a2 <memcpy+0x76>
		*d++ = *s++;
    1392:	move.b 1(a1),1(a0)
	while(len--)
    1398:	subq.l #1,d4
    139a:	beq.s 13a2 <memcpy+0x76>
		*d++ = *s++;
    139c:	move.b 2(a1),2(a0)
}
    13a2:	movem.l (sp)+,d2-d6
    13a6:	rts
    13a8:	movea.l d0,a1
    13aa:	add.l d3,d1
		*d++ = *s++;
    13ac:	move.b -1(a0),(a1)+
	while(len--)
    13b0:	cmp.l a0,d1
    13b2:	beq.s 13a2 <memcpy+0x76>
    13b4:	addq.l #1,a0
    13b6:	bra.s 13ac <memcpy+0x80>

000013b8 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    13b8:	movem.l d2-d5/a2,-(sp)
    13bc:	move.l 24(sp),d0
    13c0:	move.l 28(sp),d1
    13c4:	move.l 32(sp),d2
		while (len--)
    13c8:	movea.l d2,a1
    13ca:	subq.l #1,a1
	if (d < s) {
    13cc:	cmp.l d0,d1
    13ce:	bls.s 143c <memmove+0x84>
		while (len--)
    13d0:	tst.l d2
    13d2:	beq.s 1436 <memmove+0x7e>
    13d4:	movea.l d1,a2
    13d6:	addq.l #1,a2
    13d8:	move.l d0,d3
    13da:	sub.l a2,d3
    13dc:	moveq #2,d4
    13de:	cmp.l d3,d4
    13e0:	sc.s d3
    13e2:	neg.b d3
    13e4:	moveq #8,d5
    13e6:	cmp.l a1,d5
    13e8:	sc.s d4
    13ea:	neg.b d4
    13ec:	and.b d4,d3
    13ee:	beq.s 1460 <memmove+0xa8>
    13f0:	move.l d0,d3
    13f2:	or.l d1,d3
    13f4:	moveq #3,d4
    13f6:	and.l d4,d3
    13f8:	bne.s 1460 <memmove+0xa8>
    13fa:	movea.l d1,a0
    13fc:	movea.l d0,a2
    13fe:	moveq #-4,d3
    1400:	and.l d2,d3
    1402:	add.l d1,d3
			*d++ = *s++;
    1404:	move.l (a0)+,(a2)+
		while (len--)
    1406:	cmp.l a0,d3
    1408:	bne.s 1404 <memmove+0x4c>
    140a:	moveq #-4,d3
    140c:	and.l d2,d3
    140e:	movea.l d0,a2
    1410:	adda.l d3,a2
    1412:	movea.l d1,a0
    1414:	adda.l d3,a0
    1416:	suba.l d3,a1
    1418:	cmp.l d2,d3
    141a:	beq.s 1436 <memmove+0x7e>
			*d++ = *s++;
    141c:	move.b (a0),(a2)
		while (len--)
    141e:	cmpa.w #0,a1
    1422:	beq.s 1436 <memmove+0x7e>
			*d++ = *s++;
    1424:	move.b 1(a0),1(a2)
		while (len--)
    142a:	moveq #1,d5
    142c:	cmp.l a1,d5
    142e:	beq.s 1436 <memmove+0x7e>
			*d++ = *s++;
    1430:	move.b 2(a0),2(a2)
}
    1436:	movem.l (sp)+,d2-d5/a2
    143a:	rts
		const char *lasts = s + (len - 1);
    143c:	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    1440:	adda.l d0,a1
		while (len--)
    1442:	tst.l d2
    1444:	beq.s 1436 <memmove+0x7e>
    1446:	move.l a0,d1
    1448:	sub.l d2,d1
			*lastd-- = *lasts--;
    144a:	move.b (a0),(a1)
		while (len--)
    144c:	subq.l #1,a0
    144e:	subq.l #1,a1
    1450:	cmp.l a0,d1
    1452:	beq.s 1436 <memmove+0x7e>
			*lastd-- = *lasts--;
    1454:	move.b (a0),(a1)
		while (len--)
    1456:	subq.l #1,a0
    1458:	subq.l #1,a1
    145a:	cmp.l a0,d1
    145c:	bne.s 144a <memmove+0x92>
    145e:	bra.s 1436 <memmove+0x7e>
    1460:	movea.l d0,a1
    1462:	add.l d2,d1
			*d++ = *s++;
    1464:	move.b -1(a2),(a1)+
		while (len--)
    1468:	cmp.l a2,d1
    146a:	beq.s 1436 <memmove+0x7e>
    146c:	addq.l #1,a2
    146e:	bra.s 1464 <memmove+0xac>

00001470 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    1470:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    1474:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1478:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    147c:	mulu.w 8(sp),d1
	addw	d1, d0
    1480:	add.w d1,d0
	swap	d0
    1482:	swap d0
	clrw	d0
    1484:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1486:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    148a:	mulu.w 10(sp),d1
	addl	d1, d0
    148e:	add.l d1,d0
	rts
    1490:	rts

00001492 <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    1492:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    1494:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    1498:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    149c:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    14a2:	bcc.s 14ba <__udivsi3+0x28>
	movel	d0, d2
    14a4:	move.l d0,d2
	clrw	d2
    14a6:	clr.w d2
	swap	d2
    14a8:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    14aa:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    14ac:	move.w d2,d0
	swap	d0
    14ae:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    14b0:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    14b4:	divu.w d1,d2
	movew	d2, d0
    14b6:	move.w d2,d0
	jra	6f
    14b8:	bra.s 14ea <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    14ba:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    14bc:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    14be:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    14c0:	cmpi.l #65536,d1
	jcc	4b
    14c6:	bcc.s 14bc <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    14c8:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    14ca:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    14d0:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    14d2:	mulu.w d0,d1
	swap	d2
    14d4:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    14d6:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    14d8:	swap d2
	tstw	d2		/* high part 17 bits? */
    14da:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    14dc:	bne.s 14e8 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    14de:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    14e0:	bcs.s 14e8 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    14e2:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    14e6:	bls.s 14ea <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    14e8:	subq.l #1,d0

6:	movel	sp@+, d2
    14ea:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    14ec:	rts

000014ee <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    14ee:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    14f0:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    14f2:	move.l 12(sp),d1
	jpl	1f
    14f6:	bpl.s 14fc <__divsi3+0xe>
	negl	d1
    14f8:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    14fa:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    14fc:	move.l 8(sp),d0
	jpl	2f
    1500:	bpl.s 1506 <__divsi3+0x18>
	negl	d0
    1502:	neg.l d0
	negb	d2
    1504:	neg.b d2

2:	movel	d1, sp@-
    1506:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1508:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    150a:	bsr.s 1492 <__udivsi3>
	addql	#8, sp
    150c:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    150e:	tst.b d2
	jpl	3f
    1510:	bpl.s 1514 <__divsi3+0x26>
	negl	d0
    1512:	neg.l d0

3:	movel	sp@+, d2
    1514:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1516:	rts

00001518 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1518:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    151c:	move.l 4(sp),d0
	movel	d1, sp@-
    1520:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1522:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    1524:	bsr.s 14ee <__divsi3>
	addql	#8, sp
    1526:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1528:	move.l 8(sp),d1
	movel	d1, sp@-
    152c:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    152e:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    1530:	bsr.w 1470 <__mulsi3>
	addql	#8, sp
    1534:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1536:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    153a:	sub.l d0,d1
	movel	d1, d0
    153c:	move.l d1,d0
	rts
    153e:	rts

00001540 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    1540:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1544:	move.l 4(sp),d0
	movel	d1, sp@-
    1548:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    154a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    154c:	bsr.w 1492 <__udivsi3>
	addql	#8, sp
    1550:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    1552:	move.l 8(sp),d1
	movel	d1, sp@-
    1556:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1558:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    155a:	bsr.w 1470 <__mulsi3>
	addql	#8, sp
    155e:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    1560:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1564:	sub.l d0,d1
	movel	d1, d0
    1566:	move.l d1,d0
	rts
    1568:	rts

0000156a <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    156a:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    156c:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    1570:	jsr -516(a6)
    move.l (sp)+, a6
    1574:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    1576:	rts

00001578 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    1578:	move.b d0,(a3)+
	rts
    157a:	rts

0000157c <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    157c:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    157e:	adda.l a0,a2
	move.l	a2,a3
    1580:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    1582:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    1584:	moveq #56,d4
	moveq	#8,d5
    1586:	moveq #8,d5
	bra.s	.Lliteral
    1588:	bra.s 15f2 <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    158a:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    158c:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    158e:	dbf d1,158a <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    1592:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    1594:	bcc.s 1598 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    1596:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    1598:	tst.w d0
    159a:	bne.s 15a4 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    159c:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    159e:	bls.s 1616 <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    15a0:	move.w (a0)+,d0
    15a2:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    15a4:	rol.l #6,d0
	move.w	d0,d1
    15a6:	move.w d0,d1
	and.w	d4,d1
    15a8:	and.w d4,d1
	eor.w	d1,d0
    15aa:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    15ac:	movem.w (1610 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    15b2:	rol.l d2,d0
	and.w	d0,d3					|scaling
    15b4:	and.w d0,d3
	eor.w	d3,d0
    15b6:	eor.w d3,d0
	suba.w	d3,a4
    15b8:	suba.w d3,a4
	adda.l	a1,a4
    15ba:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    15bc:	tst.w d0
    15be:	bne.s 15c4 <_doynaxdepack_asm+0x48>
    15c0:	move.w (a0)+,d0
    15c2:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    15c4:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    15c6:	beq.s 15de <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    15c8:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    15ca:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    15cc:	bpl.s 15da <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    15ce:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    15d0:	bpl.s 15d8 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    15d2:	addx.b d1,d1
	lsl.l	#2,d0
    15d4:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    15d6:	bmi.s 15d2 <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    15d8:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    15da:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    15dc:	bcc.s 15e0 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    15de:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    15e0:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    15e2:	dbf d1,15de <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    15e6:	add.l d0,d0
	bcc.s	.Lmatch
    15e8:	bcc.s 1598 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    15ea:	tst.w d0
    15ec:	bne.s 15f2 <_doynaxdepack_asm+0x76>
    15ee:	move.w (a0)+,d0
    15f0:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    15f2:	moveq #0,d1
	add.l	d0,d0
    15f4:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    15f6:	bcc.s 1596 <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    15f8:	bpl.s 1600 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    15fa:	addx.b d1,d1
	lsl.l	#2,d0
    15fc:	lsl.l #2,d0
	bmi.s	.Llgetlen
    15fe:	bmi.s 15fa <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    1600:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    1602:	dbv.s d1,158a <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    1606:	add.l d0,d0
	eor.w	d1,d0		
    1608:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    160a:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    160c:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    160e:	bra.s 1602 <_doynaxdepack_asm+0x86>

00001610 <doy_table>:
    1610:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    1620:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    1630:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    1640:	.............o
