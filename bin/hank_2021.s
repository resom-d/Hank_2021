
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
       4:	move.l #21108,d3
       a:	subi.l #21108,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	beq.s 26 <_start+0x26>
      14:	lea 5274 <ScrollerDir>,a2
      1a:	moveq #0,d2
		__preinit_array_start[i]();
      1c:	movea.l (a2)+,a0
      1e:	jsr (a0)
	for (i = 0; i < count; i++)
      20:	addq.l #1,d2
      22:	cmp.l d3,d2
      24:	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	move.l #21108,d3
      2c:	subi.l #21108,d3
      32:	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	beq.s 48 <_start+0x48>
      36:	lea 5274 <ScrollerDir>,a2
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
      4e:	move.l #21108,d2
      54:	subi.l #21108,d2
      5a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	beq.s 6e <_start+0x6e>
      5e:	lea 5274 <ScrollerDir>,a2
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
      80:	move.l a6,1d77c <SysBase>
	custom = (struct Custom *)0xdff000;
      86:	move.l #14675968,1d782 <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
      90:	lea 2e61 <incbin_player_end+0x1>,a1
      96:	moveq #0,d0
      98:	jsr -552(a6)
      9c:	move.l d0,1d778 <GfxBase>
	if (!GfxBase)
      a2:	beq.w f7c <main+0xf08>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
      a6:	movea.l 1d77c <SysBase>,a6
      ac:	lea 2e72 <incbin_player_end+0x12>,a1
      b2:	moveq #0,d0
      b4:	jsr -552(a6)
      b8:	move.l d0,1d774 <DOSBase>
	if (!DOSBase)
      be:	beq.w f70 <main+0xefc>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      c2:	pea 2e7e <incbin_player_end+0x1e>
      c8:	lea 1084 <KPrintF>,a5
      ce:	jsr (a5)
#endif

	Write(Output(), (APTR) "Hello console!\n", 15);
      d0:	movea.l 1d774 <DOSBase>,a6
      d6:	jsr -60(a6)
      da:	movea.l 1d774 <DOSBase>,a6
      e0:	move.l d0,d1
      e2:	move.l #11930,d2
      e8:	moveq #15,d3
      ea:	jsr -48(a6)

	copPtr = AllocMem(1024, MEMF_CHIP);
      ee:	movea.l 1d77c <SysBase>,a6
      f4:	move.l #1024,d0
      fa:	moveq #2,d1
      fc:	jsr -198(a6)
     100:	move.l d0,1d770 <copPtr>
	BmpWorkP = AllocMem(BmpWork.Btot, MEMF_CHIP | MEMF_CLEAR);
     106:	movea.l 1d77c <SysBase>,a6
     10c:	moveq #0,d0
     10e:	move.w 5354 <BmpWork+0xe>,d0
     114:	move.l #65538,d1
     11a:	jsr -198(a6)
     11e:	move.l d0,1d76c <BmpWorkP>

	//HANK
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
     124:	move.l #21372,5322 <BmpLogo+0x10>
	Enable();
}

void InitImagePlanes(BmpDescriptor *img)
{
	for (int p = 0; p < img->Bpls; p++)
     12e:	moveq #0,d2
     130:	move.w 5316 <BmpLogo+0x4>,d2
     136:	addq.l #4,sp
     138:	tst.l d2
     13a:	beq.w 1e8 <main+0x174>
	{
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     13e:	moveq #0,d3
     140:	move.w 531a <BmpLogo+0x8>,d3
     146:	move.l #21372,5326 <BmpLogo+0x14>
	for (int p = 0; p < img->Bpls; p++)
     150:	moveq #1,d1
     152:	cmp.l d2,d1
     154:	beq.w 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     158:	move.l d3,d4
     15a:	addi.l #21372,d4
     160:	move.l d4,532a <BmpLogo+0x18>
	for (int p = 0; p < img->Bpls; p++)
     166:	moveq #2,d1
     168:	cmp.l d2,d1
     16a:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     16c:	move.l d3,d1
     16e:	add.l d3,d1
     170:	move.l d1,d4
     172:	addi.l #21372,d4
     178:	move.l d4,532e <BmpLogo+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     17e:	moveq #3,d4
     180:	cmp.l d2,d4
     182:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     184:	add.l d3,d1
     186:	move.l d1,d4
     188:	addi.l #21372,d4
     18e:	move.l d4,5332 <BmpLogo+0x20>
	for (int p = 0; p < img->Bpls; p++)
     194:	moveq #4,d4
     196:	cmp.l d2,d4
     198:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     19a:	add.l d3,d1
     19c:	move.l d1,d4
     19e:	addi.l #21372,d4
     1a4:	move.l d4,5336 <BmpLogo+0x24>
	for (int p = 0; p < img->Bpls; p++)
     1aa:	moveq #5,d4
     1ac:	cmp.l d2,d4
     1ae:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     1b0:	add.l d3,d1
     1b2:	move.l d1,d4
     1b4:	addi.l #21372,d4
     1ba:	move.l d4,533a <BmpLogo+0x28>
	for (int p = 0; p < img->Bpls; p++)
     1c0:	moveq #6,d4
     1c2:	cmp.l d2,d4
     1c4:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     1c6:	add.l d3,d1
     1c8:	move.l d1,d4
     1ca:	addi.l #21372,d4
     1d0:	move.l d4,533e <BmpLogo+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     1d6:	subq.l #7,d2
     1d8:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     1da:	add.l d3,d1
     1dc:	addi.l #21372,d1
     1e2:	move.l d1,5342 <BmpLogo+0x30>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
     1e8:	move.l #33854,52ee <BmpFont32+0x10>
	BmpWork.ImageData = (UWORD *)BmpWorkP;
     1f2:	move.l d0,5356 <BmpWork+0x10>
	for (int p = 0; p < img->Bpls; p++)
     1f8:	moveq #0,d2
     1fa:	move.w 534a <BmpWork+0x4>,d2
     200:	tst.l d2
     202:	beq.w 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     206:	moveq #0,d3
     208:	move.w 534e <BmpWork+0x8>,d3
     20e:	move.l d0,535a <BmpWork+0x14>
	for (int p = 0; p < img->Bpls; p++)
     214:	moveq #1,d1
     216:	cmp.l d2,d1
     218:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     21a:	move.l d0,d4
     21c:	add.l d3,d4
     21e:	move.l d4,535e <BmpWork+0x18>
	for (int p = 0; p < img->Bpls; p++)
     224:	moveq #2,d1
     226:	cmp.l d2,d1
     228:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     22a:	move.l d3,d1
     22c:	add.l d3,d1
     22e:	move.l d0,d4
     230:	add.l d1,d4
     232:	move.l d4,5362 <BmpWork+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     238:	moveq #3,d4
     23a:	cmp.l d2,d4
     23c:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     23e:	add.l d3,d1
     240:	move.l d0,d4
     242:	add.l d1,d4
     244:	move.l d4,5366 <BmpWork+0x20>
	for (int p = 0; p < img->Bpls; p++)
     24a:	moveq #4,d4
     24c:	cmp.l d2,d4
     24e:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     250:	add.l d3,d1
     252:	move.l d0,d4
     254:	add.l d1,d4
     256:	move.l d4,536a <BmpWork+0x24>
	for (int p = 0; p < img->Bpls; p++)
     25c:	moveq #5,d4
     25e:	cmp.l d2,d4
     260:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     262:	add.l d3,d1
     264:	move.l d0,d4
     266:	add.l d1,d4
     268:	move.l d4,536e <BmpWork+0x28>
	for (int p = 0; p < img->Bpls; p++)
     26e:	moveq #6,d4
     270:	cmp.l d2,d4
     272:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     274:	add.l d3,d1
     276:	move.l d0,d4
     278:	add.l d1,d4
     27a:	move.l d4,5372 <BmpWork+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     280:	subq.l #7,d2
     282:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     284:	add.l d3,d1
     286:	add.l d1,d0
     288:	move.l d0,5376 <BmpWork+0x30>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
     28e:	move.l #64576,52ba <BmpCookie+0x10>
	for (int p = 0; p < img->Bpls; p++)
     298:	moveq #0,d1
     29a:	move.w 52ae <BmpCookie+0x4>,d1
     2a0:	tst.l d1
     2a2:	beq.w 350 <main+0x2dc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2a6:	moveq #0,d2
     2a8:	move.w 52b2 <BmpCookie+0x8>,d2
     2ae:	move.l #64576,52be <BmpCookie+0x14>
	for (int p = 0; p < img->Bpls; p++)
     2b8:	moveq #1,d0
     2ba:	cmp.l d1,d0
     2bc:	beq.w 350 <main+0x2dc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2c0:	move.l d2,d3
     2c2:	addi.l #64576,d3
     2c8:	move.l d3,52c2 <BmpCookie+0x18>
	for (int p = 0; p < img->Bpls; p++)
     2ce:	moveq #2,d4
     2d0:	cmp.l d1,d4
     2d2:	beq.s 350 <main+0x2dc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2d4:	move.l d2,d0
     2d6:	add.l d2,d0
     2d8:	move.l d0,d3
     2da:	addi.l #64576,d3
     2e0:	move.l d3,52c6 <BmpCookie+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     2e6:	moveq #3,d4
     2e8:	cmp.l d1,d4
     2ea:	beq.s 350 <main+0x2dc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     2ec:	add.l d2,d0
     2ee:	move.l d0,d3
     2f0:	addi.l #64576,d3
     2f6:	move.l d3,52ca <BmpCookie+0x20>
	for (int p = 0; p < img->Bpls; p++)
     2fc:	moveq #4,d4
     2fe:	cmp.l d1,d4
     300:	beq.s 350 <main+0x2dc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     302:	add.l d2,d0
     304:	move.l d0,d3
     306:	addi.l #64576,d3
     30c:	move.l d3,52ce <BmpCookie+0x24>
	for (int p = 0; p < img->Bpls; p++)
     312:	moveq #5,d4
     314:	cmp.l d1,d4
     316:	beq.s 350 <main+0x2dc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     318:	add.l d2,d0
     31a:	move.l d0,d3
     31c:	addi.l #64576,d3
     322:	move.l d3,52d2 <BmpCookie+0x28>
	for (int p = 0; p < img->Bpls; p++)
     328:	moveq #6,d4
     32a:	cmp.l d1,d4
     32c:	beq.s 350 <main+0x2dc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     32e:	add.l d2,d0
     330:	move.l d0,d3
     332:	addi.l #64576,d3
     338:	move.l d3,52d6 <BmpCookie+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     33e:	subq.l #7,d1
     340:	beq.s 350 <main+0x2dc>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     342:	add.l d2,d0
     344:	addi.l #64576,d0
     34a:	move.l d0,52da <BmpCookie+0x30>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
     350:	move.l #95298,5286 <BmpCookieMask+0x10>
	for (int p = 0; p < img->Bpls; p++)
     35a:	moveq #0,d1
     35c:	move.w 527a <BmpCookieMask+0x4>,d1
     362:	tst.l d1
     364:	beq.w 412 <main+0x39e>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     368:	moveq #0,d2
     36a:	move.w 527e <BmpCookieMask+0x8>,d2
     370:	move.l #95298,528a <BmpCookieMask+0x14>
	for (int p = 0; p < img->Bpls; p++)
     37a:	moveq #1,d0
     37c:	cmp.l d1,d0
     37e:	beq.w 412 <main+0x39e>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     382:	move.l d2,d3
     384:	addi.l #95298,d3
     38a:	move.l d3,528e <BmpCookieMask+0x18>
	for (int p = 0; p < img->Bpls; p++)
     390:	moveq #2,d4
     392:	cmp.l d1,d4
     394:	beq.s 412 <main+0x39e>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     396:	move.l d2,d0
     398:	add.l d2,d0
     39a:	move.l d0,d3
     39c:	addi.l #95298,d3
     3a2:	move.l d3,5292 <BmpCookieMask+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     3a8:	moveq #3,d4
     3aa:	cmp.l d1,d4
     3ac:	beq.s 412 <main+0x39e>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3ae:	add.l d2,d0
     3b0:	move.l d0,d3
     3b2:	addi.l #95298,d3
     3b8:	move.l d3,5296 <BmpCookieMask+0x20>
	for (int p = 0; p < img->Bpls; p++)
     3be:	moveq #4,d4
     3c0:	cmp.l d1,d4
     3c2:	beq.s 412 <main+0x39e>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3c4:	add.l d2,d0
     3c6:	move.l d0,d3
     3c8:	addi.l #95298,d3
     3ce:	move.l d3,529a <BmpCookieMask+0x24>
	for (int p = 0; p < img->Bpls; p++)
     3d4:	moveq #5,d4
     3d6:	cmp.l d1,d4
     3d8:	beq.s 412 <main+0x39e>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3da:	add.l d2,d0
     3dc:	move.l d0,d3
     3de:	addi.l #95298,d3
     3e4:	move.l d3,529e <BmpCookieMask+0x28>
	for (int p = 0; p < img->Bpls; p++)
     3ea:	moveq #6,d4
     3ec:	cmp.l d1,d4
     3ee:	beq.s 412 <main+0x39e>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     3f0:	add.l d2,d0
     3f2:	move.l d0,d3
     3f4:	addi.l #95298,d3
     3fa:	move.l d3,52a2 <BmpCookieMask+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     400:	subq.l #7,d1
     402:	beq.s 412 <main+0x39e>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     404:	add.l d2,d0
     406:	addi.l #95298,d0
     40c:	move.l d0,52a6 <BmpCookieMask+0x30>
	ActiView = GfxBase->ActiView; //store current view
     412:	movea.l 1d778 <GfxBase>,a6
     418:	move.l 34(a6),1d75a <ActiView>
	OwnBlitter();
     420:	jsr -456(a6)
	WaitBlit();
     424:	movea.l 1d778 <GfxBase>,a6
     42a:	jsr -228(a6)
	Disable();
     42e:	movea.l 1d77c <SysBase>,a6
     434:	jsr -120(a6)
	SystemADKCON = custom->adkconr;
     438:	movea.l 1d782 <custom>,a2
     43e:	move.w 16(a2),d0
     442:	move.w d0,1d75e <SystemADKCON>
	SystemInts = custom->intenar;
     448:	move.w 28(a2),d0
     44c:	move.w d0,1d762 <SystemInts>
	SystemDMA = custom->dmaconr;
     452:	move.w 2(a2),d0
     456:	move.w d0,1d760 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     45c:	move.w #32767,154(a2)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     462:	move.w #32767,156(a2)
	WaitVbl();
     468:	lea 103e <WaitVbl>,a4
     46e:	jsr (a4)
	WaitVbl();
     470:	jsr (a4)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     472:	move.w #32767,150(a2)
	for (int a = 0; a < 32; a++)
     478:	moveq #0,d1
		custom->color[a] = 0;
     47a:	move.l d1,d0
     47c:	addi.l #192,d0
     482:	add.l d0,d0
     484:	move.w #0,(0,a2,d0.l)
	for (int a = 0; a < 32; a++)
     48a:	addq.l #1,d1
     48c:	moveq #32,d0
     48e:	cmp.l d1,d0
     490:	bne.s 47a <main+0x406>
	LoadView(0);
     492:	movea.l 1d778 <GfxBase>,a6
     498:	suba.l a1,a1
     49a:	jsr -222(a6)
	WaitTOF();
     49e:	movea.l 1d778 <GfxBase>,a6
     4a4:	jsr -270(a6)
	WaitTOF();
     4a8:	movea.l 1d778 <GfxBase>,a6
     4ae:	jsr -270(a6)
	WaitVbl();
     4b2:	jsr (a4)
	WaitVbl();
     4b4:	jsr (a4)
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     4b6:	move.w #20090,50(sp)
     4bc:	move.w #2049,52(sp)
     4c2:	move.w #20083,54(sp)
	if (SysBase->AttnFlags & AFF_68010)
     4c8:	movea.l 1d77c <SysBase>,a6
     4ce:	btst #0,297(a6)
     4d4:	beq.w fa6 <main+0xf32>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     4d8:	moveq #50,d7
     4da:	add.l sp,d7
     4dc:	exg d7,a5
     4de:	jsr -30(a6)
     4e2:	exg d7,a5
	VBR = GetVBR();
     4e4:	move.l d0,1d768 <VBR>
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     4ea:	movea.l 1d768 <VBR>,a0
     4f0:	move.l 108(a0),d0
	SystemIrq = GetInterruptHandler(); //store interrupt register
     4f4:	move.l d0,1d764 <SystemIrq>
	WaitVbl();
     4fa:	jsr (a4)
	SetupCopper(copPtr);
     4fc:	movea.l 1d770 <copPtr>,a1
	*copPtr++ = DIWSTRT;
     502:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     506:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     50c:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     512:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     518:	move.w #146,8(a1)
	*copPtr++ = 0x38 + ((Screen.Width - BmpLogo.Width) / 4);
     51e:	moveq #0,d1
     520:	move.w 5312 <BmpLogo>,d1
     526:	move.l #320,d0
     52c:	sub.l d1,d0
     52e:	move.l d0,d1
     530:	bmi.w ef6 <main+0xe82>
     534:	asr.l #2,d1
     536:	addi.w #56,d1
     53a:	move.w d1,10(a1)
	*copPtr++ = DDFSTOP;
     53e:	move.w #148,12(a1)
	*copPtr++ = 0xd0 - ((Screen.Width - BmpLogo.Width) / 4);
     544:	tst.l d0
     546:	blt.w e36 <main+0xdc2>
     54a:	asr.l #2,d0
     54c:	move.w #208,d1
     550:	sub.w d0,d1
     552:	move.w d1,14(a1)
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     556:	move.w 531a <BmpLogo+0x8>,d5
     55c:	move.w 531c <BmpLogo+0xa>,d3
     562:	sub.w d5,d3


inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     564:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     56a:	move.w d3,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     56e:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     574:	move.w d3,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     578:	move.w #258,24(a1)
	*copPtr++ = 0;
     57e:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     582:	move.w #260,28(a1)
	*copPtr++ = 1 << 6;	 //0x24;  Sprites have priority over playfields
     588:	move.w #64,30(a1)
    return copListEnd;
}

inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     58e:	move.w #384,32(a1)
    *copListCurrent++ = color;
     594:	clr.w 34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     598:	move.w #386,36(a1)
    *copListCurrent++ = color;
     59e:	move.w #1366,38(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5a4:	move.w #388,40(a1)
    *copListCurrent++ = color;
     5aa:	move.w #3221,42(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5b0:	move.w #390,44(a1)
    *copListCurrent++ = color;
     5b6:	move.w #3750,46(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5bc:	move.w #392,48(a1)
    *copListCurrent++ = color;
     5c2:	move.w #1074,50(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5c8:	move.w #394,52(a1)
    *copListCurrent++ = color;
     5ce:	move.w #1329,54(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5d4:	move.w #396,56(a1)
    *copListCurrent++ = color;
     5da:	move.w #530,58(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5e0:	move.w #398,60(a1)
    *copListCurrent++ = color;
     5e6:	move.w #2177,62(a1)
     5ec:	lea 64(a1),a3
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpLogo.ImageData, BmpLogo.Bpls, BmpLogo.Bpl, 0);
     5f0:	move.w 5316 <BmpLogo+0x4>,d6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     5f6:	move.l 5322 <BmpLogo+0x10>,d0
    for (USHORT i = 0; i < numPlanes; i++)
     5fc:	tst.w d6
     5fe:	beq.w ef0 <main+0xe7c>
        addr += Bpl;
     602:	andi.l #65535,d5
     608:	move.w d6,d4
     60a:	subq.w #1,d4
     60c:	andi.l #65535,d4
     612:	moveq #9,d2
     614:	add.l d2,d4
     616:	lsl.l #3,d4
     618:	add.l a1,d4
    *copListCurrent++ = color;
     61a:	movea.l a3,a0
        addr += Bpl;
     61c:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     620:	move.w d1,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     622:	move.l d0,d2
     624:	clr.w d2
     626:	swap d2
     628:	move.w d2,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     62c:	movea.w d1,a2
     62e:	addq.w #2,a2
     630:	move.w a2,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     634:	addq.l #8,a0
     636:	move.w d0,-2(a0)
        addr += Bpl;
     63a:	add.l d5,d0
    for (USHORT i = 0; i < numPlanes; i++)
     63c:	addq.w #4,d1
     63e:	cmp.l a0,d4
     640:	bne.s 620 <main+0x5ac>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     642:	andi.l #65535,d6
     648:	move.l d6,d0
     64a:	lsl.l #3,d0
     64c:	adda.l d0,a3
	*copPtr++ = BPLCON0;
     64e:	move.w #256,(a3)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     652:	moveq #12,d0
     654:	lsl.l d0,d6
     656:	ori.w #512,d6
     65a:	move.w d6,2(a3)
	copPtr = copWaitY(copPtr, 0x2c + BmpLogo.Height);
     65e:	move.w 5314 <BmpLogo+0x2>,d6
     664:	move.w d6,d0
     666:	addi.w #44,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     66a:	lsl.w #8,d0
     66c:	ori.w #5,d0
     670:	move.w d0,4(a3)
    *copListEnd++ = COP_WAIT;
     674:	move.w #-2,6(a3)
	*copPtr++ = DDFSTRT;
     67a:	move.w #146,8(a3)
	*copPtr++ = 0x38;
     680:	move.w #56,10(a3)
	*copPtr++ = DDFSTOP;
     686:	move.w #148,12(a3)
	*copPtr++ = 0xd0;
     68c:	move.w #208,14(a3)
						  BmpWork.Bplt - Screen.Bpl);
     692:	move.w 5350 <BmpWork+0xa>,d0
     698:	addi.w #-40,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     69c:	move.w #264,16(a3)
    *copListEnd++ = modOdd;
     6a2:	move.w d0,18(a3)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     6a6:	move.w #266,20(a3)
    *copListEnd++ = modEven;
     6ac:	lea 24(a3),a2
     6b0:	move.w d0,22(a3)
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     6b4:	move.l a2,1d752 <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpWork.ImageData, BmpWork.Bpls, BmpWork.Bpl, 0);
     6ba:	move.w 534e <BmpWork+0x8>,d4
     6c0:	move.w 534a <BmpWork+0x4>,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     6c6:	move.l 5356 <BmpWork+0x10>,d0
    for (USHORT i = 0; i < numPlanes; i++)
     6cc:	tst.w d5
     6ce:	beq.s 718 <main+0x6a4>
        addr += Bpl;
     6d0:	andi.l #65535,d4
     6d6:	move.w d5,d1
     6d8:	subq.w #1,d1
     6da:	andi.l #65535,d1
     6e0:	addq.l #4,d1
     6e2:	lsl.l #3,d1
     6e4:	adda.l d1,a3
     6e6:	movea.l a2,a0
     6e8:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     6ec:	move.w d1,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     6ee:	move.l d0,d2
     6f0:	clr.w d2
     6f2:	swap d2
     6f4:	move.w d2,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     6f8:	move.w d1,d2
     6fa:	addq.w #2,d2
     6fc:	move.w d2,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     700:	addq.l #8,a0
     702:	move.w d0,-2(a0)
        addr += Bpl;
     706:	add.l d4,d0
    for (USHORT i = 0; i < numPlanes; i++)
     708:	addq.w #4,d1
     70a:	cmpa.l a3,a0
     70c:	bne.s 6ec <main+0x678>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     70e:	andi.l #65535,d5
     714:	lsl.l #3,d5
     716:	adda.l d5,a2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     718:	move.w #384,(a2)
    *copListCurrent++ = color;
     71c:	clr.w 2(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     720:	move.w #386,4(a2)
    *copListCurrent++ = color;
     726:	move.w #23,6(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     72c:	move.w #388,8(a2)
    *copListCurrent++ = color;
     732:	move.w #601,10(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     738:	move.w #390,12(a2)
    *copListCurrent++ = color;
     73e:	move.w #874,14(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     744:	move.w #392,16(a2)
    *copListCurrent++ = color;
     74a:	move.w #1163,18(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     750:	move.w #394,20(a2)
    *copListCurrent++ = color;
     756:	move.w #1469,22(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     75c:	move.w #396,24(a2)
    *copListCurrent++ = color;
     762:	move.w #1758,26(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     768:	move.w #398,28(a2)
    *copListCurrent++ = color;
     76e:	move.w #2303,30(a2)
	copPtr = copWaitY(copPtr, 0x2c + BmpLogo.Height + 64);
     774:	addi.w #108,d6
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     778:	lsl.w #8,d6
     77a:	ori.w #5,d6
     77e:	move.w d6,32(a2)
    *copListEnd++ = COP_WAIT;
     782:	move.w #-2,34(a2)
     788:	lea 36(a2),a0
     78c:	move.l a0,1d748 <copMirrorBmpP>
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     792:	move.w #264,36(a2)
    *copListEnd++ = modOdd;
     798:	move.w d3,38(a2)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     79c:	move.w #266,40(a2)
    *copListEnd++ = modEven;
     7a2:	move.w d3,42(a2)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     7a6:	move.w #-1,44(a2)
    *copListEnd++ = COP_WAIT;
     7ac:	move.w #-2,46(a2)
	custom->cop1lc = (ULONG)copPtr;
     7b2:	movea.l 1d782 <custom>,a0
     7b8:	move.l a1,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
     7bc:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
     7c2:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER;
     7c8:	move.w #-31808,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     7ce:	movea.l 1d768 <VBR>,a1
     7d4:	move.l #4092,108(a1)
	custom->intena = INTF_SETCLR | INTF_EXTER; // ThePlayer needs INTF_EXTER
     7dc:	move.w #-24576,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
     7e2:	move.w #32,156(a0)
	// custom->bltsize = bltsize;
}

int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
	register volatile const void *_a0 ASM("a0") = module;
     7e8:	lea 19c44 <incbin_module_start>,a0
	register volatile const void *_a1 ASM("a1") = NULL;
     7ee:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
     7f0:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = player;
     7f2:	lea 14fa <incbin_player_start>,a3
	register int _d0 ASM("d0"); // return value
	__asm volatile(
     7f8:	movem.l d1-d7/a4-a6,-(sp)
     7fc:	jsr (a3)
     7fe:	movem.l (sp)+,d1-d7/a4-a6
	if (p61Init(module) != 0)
     802:	tst.l d0
     804:	bne.w f12 <main+0xe9e>
	SimpleBlit(BmpCookie, BmpLogo, ps, ps, 32, 32);
     808:	move.w 52ae <BmpCookie+0x4>,d1
	custom->bltcon0 = 0x09f0;
     80e:	movea.l 1d782 <custom>,a0
     814:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     81a:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     820:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     826:	move.w #-1,70(a0)
	custom->bltamod = imgA.Bpl - (width / 8);
     82c:	move.w 52b2 <BmpCookie+0x8>,d0
     832:	subq.w #4,d0
     834:	move.w d0,100(a0)
	custom->bltdmod = imgD.Bpl - (width / 8);
     838:	move.w 531a <BmpLogo+0x8>,d0
     83e:	subq.w #4,d0
     840:	move.w d0,102(a0)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
     844:	move.l 52ba <BmpCookie+0x10>,80(a0)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
     84c:	move.l 5322 <BmpLogo+0x10>,84(a0)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     854:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     858:	move.w 2(a0),d0
     85c:	btst #14,d0
     860:	bne.s 858 <main+0x7e4>
	custom->bltsize = ((height*imgA.Bpls) << 6) + (width / 16);
     862:	move.w d1,d0
     864:	moveq #11,d2
     866:	lsl.w d2,d0
     868:	addq.w #2,d0
     86a:	move.w d0,88(a0)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
     86e:	move.b bfe001 <_end+0xbe0879>,d0
	while (!MouseLeft())
     874:	btst #6,d0
     878:	beq.w a0a <main+0x996>
			ScrollerY += ScrollerDir;
     87c:	move.w 1d756 <ScrollerY>,d5
		Scrollit(BmpWork, (UBYTE *)BmpWork.ImageData, 40, 32, 4);
     882:	move.l 5356 <BmpWork+0x10>,d3
     888:	move.w 534a <BmpWork+0x4>,d2
     88e:	lea 5346 <BmpWork>,a5
     894:	lea 131c <__mulsi3>,a3
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     89a:	move.l dff004 <_end+0xde187c>,d0
     8a0:	move.l d0,50(sp)
		vpos &= 0x1ff00;
     8a4:	move.l 50(sp),d0
     8a8:	andi.l #130816,d0
     8ae:	move.l d0,50(sp)
		if (vpos != (311 << 8))
     8b2:	move.l 50(sp),d0
     8b6:	cmpi.l #79616,d0
     8bc:	beq.s 89a <main+0x826>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     8be:	move.l dff004 <_end+0xde187c>,d0
     8c4:	move.l d0,46(sp)
		vpos &= 0x1ff00;
     8c8:	move.l 46(sp),d0
     8cc:	andi.l #130816,d0
     8d2:	move.l d0,46(sp)
		if (vpos == (311 << 8))
     8d6:	move.l 46(sp),d0
     8da:	cmpi.l #79616,d0
     8e0:	bne.s 8be <main+0x84a>
		if (BounceEnabled)
     8e2:	tst.w 1d758 <BounceEnabled>
     8e8:	beq.s 8fa <main+0x886>
			ScrollerY += ScrollerDir;
     8ea:	move.b 5274 <ScrollerDir>,d0
     8f0:	ext.w d0
     8f2:	add.w d0,d5
     8f4:	move.w d5,1d756 <ScrollerY>
		if (ScrollerY >= ScollerMax)
     8fa:	movea.w d5,a0
     8fc:	cmpi.w #29,d5
     900:	ble.w d5e <main+0xcea>
			ScrollerY = ScollerMax;
     904:	move.w #30,1d756 <ScrollerY>
			ScrollerDir = -2;
     90c:	move.b #-2,5274 <ScrollerDir>
		Scrollit(BmpWork, (UBYTE *)BmpWork.ImageData, 40, 32, 4);
     914:	move.w 5350 <BmpWork+0xa>,d5
	int BltOffs = startY * theDesc.Bplt;
     91a:	move.w d5,d6
     91c:	mulu.w #40,d6
	int Brcorner = height * theDesc.Bplt - 2;
     920:	andi.l #65535,d5
     926:	lsl.l #5,d5
     928:	subq.l #2,d5
	WaitBlit();
     92a:	movea.l 1d778 <GfxBase>,a6
     930:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     934:	movea.l 1d782 <custom>,a0
     93a:	move.w #18928,64(a0)
	custom->bltcon1 = 0x0002;
     940:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     946:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     94c:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     952:	add.l d6,d5
     954:	add.l d5,d3
     956:	move.l d3,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     95a:	move.l d3,84(a0)
	custom->bltamod = 0;
     95e:	move.w #0,100(a0)
	custom->bltdmod = 0;
     964:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpWork.Width / 16;
     96a:	moveq #11,d3
     96c:	lsl.w d3,d2
     96e:	move.w (a5),d0
     970:	lsr.w #4,d0
     972:	add.w d0,d2
     974:	move.w d2,88(a0)
	ScrollCnt += speed;
     978:	move.w 1d750 <ScrollCnt>,d0
     97e:	addq.w #4,d0
     980:	move.w d0,1d750 <ScrollCnt>
	if (ScrollCnt >= 32)
     986:	cmpi.w #31,d0
     98a:	bhi.w b30 <main+0xabc>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpWork.ImageData, BmpWork.Bpls, BmpWork.Bpl, ScrollerY);
     98e:	move.w 534e <BmpWork+0x8>,d6
     994:	move.l 5356 <BmpWork+0x10>,d3
     99a:	move.w 1d756 <ScrollerY>,d5
     9a0:	move.w 534a <BmpWork+0x4>,d2
     9a6:	moveq #0,d7
     9a8:	move.w d2,d7
     9aa:	movea.l 1d752 <copScrollerBmpP>,a2
     9b0:	andi.l #65535,d6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     9b6:	move.l d6,-(sp)
     9b8:	movea.w d5,a0
     9ba:	move.l a0,-(sp)
     9bc:	jsr (a3)
     9be:	addq.l #4,sp
     9c0:	move.l d7,(sp)
     9c2:	move.l d0,-(sp)
     9c4:	jsr (a3)
     9c6:	addq.l #8,sp
     9c8:	add.l d3,d0
    for (USHORT i = 0; i < numPlanes; i++)
     9ca:	tst.l d7
     9cc:	beq.s 9fc <main+0x988>
     9ce:	suba.l a0,a0
        addr += Bpl;
     9d0:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     9d4:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     9d6:	move.l d0,d4
     9d8:	clr.w d4
     9da:	swap d4
     9dc:	move.w d4,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     9e0:	movea.w d1,a1
     9e2:	addq.w #2,a1
     9e4:	move.w a1,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     9e8:	addq.l #8,a2
     9ea:	move.w d0,-2(a2)
        addr += Bpl;
     9ee:	add.l d6,d0
    for (USHORT i = 0; i < numPlanes; i++)
     9f0:	addq.w #1,a0
     9f2:	addq.w #4,d1
     9f4:	moveq #0,d4
     9f6:	move.w a0,d4
     9f8:	cmp.l d7,d4
     9fa:	blt.s 9d4 <main+0x960>
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
     9fc:	move.b bfe001 <_end+0xbe0879>,d0
	while (!MouseLeft())
     a02:	btst #6,d0
     a06:	bne.w 89a <main+0x826>
		: "cc", "memory");
}

void p61End()
{
	register volatile const void *_a3 ASM("a3") = player;
     a0a:	lea 14fa <incbin_player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
     a10:	movea.l #14675968,a6
	__asm volatile(
     a16:	movem.l d0-d1/a0-a1,-(sp)
     a1a:	jsr 8(a3)
     a1e:	movem.l (sp)+,d0-d1/a0-a1
	FreeMem(copPtr, 1024);
     a22:	movea.l 1d77c <SysBase>,a6
     a28:	movea.l 1d770 <copPtr>,a1
     a2e:	move.l #1024,d0
     a34:	jsr -210(a6)
	FreeMem((UBYTE *)BmpWorkP, BmpWork.Btot);
     a38:	movea.l 1d77c <SysBase>,a6
     a3e:	movea.l 1d76c <BmpWorkP>,a1
     a44:	moveq #0,d0
     a46:	move.w 5354 <BmpWork+0xe>,d0
     a4c:	jsr -210(a6)
	WaitVbl();
     a50:	jsr (a4)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     a52:	movea.l 1d782 <custom>,a0
     a58:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     a5c:	move.w 2(a0),d0
     a60:	btst #14,d0
     a64:	bne.s a5c <main+0x9e8>
	custom->intena = 0x7fff; //disable all interrupts
     a66:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     a6c:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     a72:	move.w #32767,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     a78:	movea.l 1d768 <VBR>,a1
     a7e:	move.l 1d764 <SystemIrq>,108(a1)
	custom->cop1lc = (ULONG)GfxBase->copinit;
     a86:	movea.l 1d778 <GfxBase>,a6
     a8c:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     a92:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     a98:	move.w #32767,136(a0)
	custom->intena = SystemInts | 0x8000;
     a9e:	move.w 1d762 <SystemInts>,d0
     aa4:	ori.w #-32768,d0
     aa8:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     aac:	move.w 1d760 <SystemDMA>,d0
     ab2:	ori.w #-32768,d0
     ab6:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     aba:	move.w 1d75e <SystemADKCON>,d0
     ac0:	ori.w #-32768,d0
     ac4:	move.w d0,158(a0)
	LoadView(ActiView);
     ac8:	movea.l 1d75a <ActiView>,a1
     ace:	jsr -222(a6)
	WaitTOF();
     ad2:	movea.l 1d778 <GfxBase>,a6
     ad8:	jsr -270(a6)
	WaitTOF();
     adc:	movea.l 1d778 <GfxBase>,a6
     ae2:	jsr -270(a6)
	WaitBlit();
     ae6:	movea.l 1d778 <GfxBase>,a6
     aec:	jsr -228(a6)
	DisownBlitter();
     af0:	movea.l 1d778 <GfxBase>,a6
     af6:	jsr -462(a6)
	Enable();
     afa:	movea.l 1d77c <SysBase>,a6
     b00:	jsr -126(a6)
	CloseLibrary((struct Library *)DOSBase);
     b04:	movea.l 1d77c <SysBase>,a6
     b0a:	movea.l 1d774 <DOSBase>,a1
     b10:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
     b14:	movea.l 1d77c <SysBase>,a6
     b1a:	movea.l 1d778 <GfxBase>,a1
     b20:	jsr -414(a6)
}
     b24:	moveq #0,d0
     b26:	movem.l (sp)+,d2-d7/a2-a6
     b2a:	lea 12(sp),sp
     b2e:	rts
		ScrollCnt = 0;
     b30:	clr.w 1d750 <ScrollCnt>
		PlotChar(BmpFont32, (UBYTE *)BmpFont32P, BmpWork, (UBYTE *)BmpWork.ImageData, startY, 32, 32);
     b36:	move.l 5356 <BmpWork+0x10>,d3
     b3c:	move.w 52e2 <BmpFont32+0x4>,d5
     b42:	move.w 52e6 <BmpFont32+0x8>,d7
     b48:	movea.w 52e8 <BmpFont32+0xa>,a1
     b4e:	move.w 534e <BmpWork+0x8>,d6
     b54:	movea.w 5350 <BmpWork+0xa>,a6
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     b5a:	movea.w 1d74e <ScrolltextCnt>,a0
     b60:	move.w a0,d1
     b62:	addq.w #1,d1
     b64:	move.w d1,1d74e <ScrolltextCnt>
     b6a:	moveq #0,d0
     b6c:	move.w a0,d0
     b6e:	lea 2ebb <Scrolltext>,a2
     b74:	move.b (0,a2,d0.l),d0
	if (chr == 'a')
     b78:	cmpi.b #97,d0
     b7c:	beq.w d1c <main+0xca8>
	if (chr == 'b')
     b80:	cmpi.b #98,d0
     b84:	beq.w c1a <main+0xba6>
	if (chr == 0)
     b88:	tst.b d0
     b8a:	bne.w c72 <main+0xbfe>
		chr = Scrolltext[ScrolltextCnt++];
     b8e:	move.w #1,1d74e <ScrolltextCnt>
     b96:	suba.l a2,a2
     b98:	moveq #4,d1
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     b9a:	move.l d1,-(sp)
     b9c:	move.w a1,-(sp)
     b9e:	clr.w -(sp)
     ba0:	jsr (a3)
     ba2:	addq.l #8,sp
     ba4:	move.l d0,d2
     ba6:	lsl.l #5,d2
     ba8:	add.l a2,d2
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     baa:	moveq #0,d0
     bac:	move.w a6,d0
     bae:	addq.l #1,d0
     bb0:	movea.l d0,a2
     bb2:	adda.l d0,a2
     bb4:	adda.l a2,a2
     bb6:	add.l a2,d0
     bb8:	lsl.l #3,d0
     bba:	movea.l d0,a2
	WaitBlit();
     bbc:	movea.l 1d778 <GfxBase>,a6
     bc2:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     bc6:	movea.l 1d782 <custom>,a0
     bcc:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     bd2:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     bd8:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     bde:	move.w #-1,70(a0)
	custom->bltapt = bmpFontP + source;
     be4:	addi.l #33854,d2
     bea:	move.l d2,80(a0)
	custom->bltdpt = bmpDestP + dest;
     bee:	add.l a2,d3
     bf0:	move.l d3,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     bf4:	subq.w #4,d7
     bf6:	move.w d7,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     bfa:	subq.w #4,d6
     bfc:	move.w d6,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     c00:	moveq #11,d0
     c02:	lsl.w d0,d5
     c04:	addq.w #2,d5
     c06:	move.w d5,88(a0)
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpWork.ImageData, BmpWork.Bpls, BmpWork.Bpl, ScrollerY);
     c0a:	move.w 534e <BmpWork+0x8>,d6
     c10:	move.l 5356 <BmpWork+0x10>,d3
     c16:	bra.w 99a <main+0x926>
		if (MirrorEnabled)
     c1a:	move.w 1d74c <MirrorEnabled>,d0
				 BmpWork.Bplt - Screen.Bpl);
     c20:	move.w a6,d2
     c22:	addi.w #-40,d2
	copSetBplMod(0, copMirrorBmpP,
     c26:	movea.l 1d748 <copMirrorBmpP>,a0
		if (MirrorEnabled)
     c2c:	tst.w d0
     c2e:	beq.w df2 <main+0xd7e>
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     c32:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     c36:	move.w d2,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     c3a:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     c40:	move.w d2,6(a0)
		MirrorEnabled = !MirrorEnabled;
     c44:	tst.w d0
     c46:	seq d0
     c48:	ext.w d0
     c4a:	neg.w d0
     c4c:	move.w d0,1d74c <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     c52:	move.w d1,d0
     c54:	addq.w #1,d0
     c56:	move.w d0,1d74e <ScrolltextCnt>
     c5c:	andi.l #65535,d1
     c62:	lea 2ebb <Scrolltext>,a0
     c68:	move.b (0,a0,d1.l),d0
	if (chr == 0)
     c6c:	tst.b d0
     c6e:	beq.w b8e <main+0xb1a>
	if (chr < 32 || chr > (32 + 80))
     c72:	addi.b #-32,d0
     c76:	cmpi.b #80,d0
     c7a:	bhi.w 99a <main+0x926>
	row = chr / 10;
     c7e:	andi.w #255,d0
     c82:	move.w d0,d2
     c84:	mulu.w #-13107,d2
     c88:	clr.w d2
     c8a:	swap d2
     c8c:	lsr.w #3,d2
     c8e:	moveq #0,d1
     c90:	move.b d2,d1
	col = chr % 10;
     c92:	movea.w d2,a0
     c94:	adda.w d2,a0
     c96:	adda.w a0,a0
     c98:	adda.w d2,a0
     c9a:	adda.w a0,a0
     c9c:	sub.w a0,d0
     c9e:	moveq #0,d2
     ca0:	move.b d0,d2
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     ca2:	add.l d2,d2
     ca4:	movea.l d2,a2
     ca6:	adda.l d2,a2
     ca8:	move.l d1,-(sp)
     caa:	move.w a1,-(sp)
     cac:	clr.w -(sp)
     cae:	jsr (a3)
     cb0:	addq.l #8,sp
     cb2:	move.l d0,d2
     cb4:	lsl.l #5,d2
     cb6:	add.l a2,d2
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     cb8:	moveq #0,d0
     cba:	move.w a6,d0
     cbc:	addq.l #1,d0
     cbe:	movea.l d0,a2
     cc0:	adda.l d0,a2
     cc2:	adda.l a2,a2
     cc4:	add.l a2,d0
     cc6:	lsl.l #3,d0
     cc8:	movea.l d0,a2
	WaitBlit();
     cca:	movea.l 1d778 <GfxBase>,a6
     cd0:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     cd4:	movea.l 1d782 <custom>,a0
     cda:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     ce0:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     ce6:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     cec:	move.w #-1,70(a0)
	custom->bltapt = bmpFontP + source;
     cf2:	addi.l #33854,d2
     cf8:	move.l d2,80(a0)
	custom->bltdpt = bmpDestP + dest;
     cfc:	add.l a2,d3
     cfe:	move.l d3,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     d02:	subq.w #4,d7
     d04:	move.w d7,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     d08:	subq.w #4,d6
     d0a:	move.w d6,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     d0e:	moveq #11,d0
     d10:	lsl.w d0,d5
     d12:	addq.w #2,d5
     d14:	move.w d5,88(a0)
     d18:	bra.w c0a <main+0xb96>
		if (BounceEnabled)
     d1c:	move.w 1d758 <BounceEnabled>,d0
     d22:	beq.s d2a <main+0xcb6>
			ScrollerY = 0;
     d24:	clr.w 1d756 <ScrollerY>
		BounceEnabled = !BounceEnabled;
     d2a:	tst.w d0
     d2c:	seq d0
     d2e:	ext.w d0
     d30:	neg.w d0
     d32:	move.w d0,1d758 <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     d38:	addq.w #2,a0
     d3a:	move.w a0,1d74e <ScrolltextCnt>
     d40:	andi.l #65535,d1
     d46:	lea 2ebb <Scrolltext>,a2
     d4c:	move.b (0,a2,d1.l),d0
     d50:	move.w a0,d1
	if (chr == 'b')
     d52:	cmpi.b #98,d0
     d56:	bne.w b88 <main+0xb14>
     d5a:	bra.w c1a <main+0xba6>
		else if (ScrollerY <= ScollerMin)
     d5e:	cmpa.w #0,a0
     d62:	bgt.w 914 <main+0x8a0>
			ScrollerY = ScollerMin;
     d66:	clr.w 1d756 <ScrollerY>
			ScrollerDir = 2;
     d6c:	move.b #2,5274 <ScrollerDir>
		Scrollit(BmpWork, (UBYTE *)BmpWork.ImageData, 40, 32, 4);
     d74:	move.w 5350 <BmpWork+0xa>,d5
	int BltOffs = startY * theDesc.Bplt;
     d7a:	move.w d5,d6
     d7c:	mulu.w #40,d6
	int Brcorner = height * theDesc.Bplt - 2;
     d80:	andi.l #65535,d5
     d86:	lsl.l #5,d5
     d88:	subq.l #2,d5
	WaitBlit();
     d8a:	movea.l 1d778 <GfxBase>,a6
     d90:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     d94:	movea.l 1d782 <custom>,a0
     d9a:	move.w #18928,64(a0)
	custom->bltcon1 = 0x0002;
     da0:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     da6:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     dac:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     db2:	add.l d6,d5
     db4:	add.l d5,d3
     db6:	move.l d3,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     dba:	move.l d3,84(a0)
	custom->bltamod = 0;
     dbe:	move.w #0,100(a0)
	custom->bltdmod = 0;
     dc4:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpWork.Width / 16;
     dca:	moveq #11,d3
     dcc:	lsl.w d3,d2
     dce:	move.w (a5),d0
     dd0:	lsr.w #4,d0
     dd2:	add.w d0,d2
     dd4:	move.w d2,88(a0)
	ScrollCnt += speed;
     dd8:	move.w 1d750 <ScrollCnt>,d0
     dde:	addq.w #4,d0
     de0:	move.w d0,1d750 <ScrollCnt>
	if (ScrollCnt >= 32)
     de6:	cmpi.w #31,d0
     dea:	bls.w 98e <main+0x91a>
     dee:	bra.w b30 <main+0xabc>
				 (BmpWork.Bplt - Screen.Bpl) - (BmpWork.Bplt * 2));
     df2:	movea.w a6,a2
     df4:	adda.w a6,a2
     df6:	sub.w a2,d2
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     df8:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     dfc:	move.w d2,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     e00:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     e06:	move.w d2,6(a0)
		MirrorEnabled = !MirrorEnabled;
     e0a:	tst.w d0
     e0c:	seq d0
     e0e:	ext.w d0
     e10:	neg.w d0
     e12:	move.w d0,1d74c <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     e18:	move.w d1,d0
     e1a:	addq.w #1,d0
     e1c:	move.w d0,1d74e <ScrolltextCnt>
     e22:	andi.l #65535,d1
     e28:	lea 2ebb <Scrolltext>,a0
     e2e:	move.b (0,a0,d1.l),d0
     e32:	bra.w c6c <main+0xbf8>
	*copPtr++ = 0xd0 - ((Screen.Width - BmpLogo.Width) / 4);
     e36:	addq.l #3,d0
     e38:	asr.l #2,d0
     e3a:	move.w #208,d1
     e3e:	sub.w d0,d1
     e40:	move.w d1,14(a1)
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     e44:	move.w 531a <BmpLogo+0x8>,d5
     e4a:	move.w 531c <BmpLogo+0xa>,d3
     e50:	sub.w d5,d3
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     e52:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     e58:	move.w d3,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     e5c:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     e62:	move.w d3,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     e66:	move.w #258,24(a1)
	*copPtr++ = 0;
     e6c:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     e70:	move.w #260,28(a1)
	*copPtr++ = 1 << 6;	 //0x24;  Sprites have priority over playfields
     e76:	move.w #64,30(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e7c:	move.w #384,32(a1)
    *copListCurrent++ = color;
     e82:	clr.w 34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e86:	move.w #386,36(a1)
    *copListCurrent++ = color;
     e8c:	move.w #1366,38(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e92:	move.w #388,40(a1)
    *copListCurrent++ = color;
     e98:	move.w #3221,42(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e9e:	move.w #390,44(a1)
    *copListCurrent++ = color;
     ea4:	move.w #3750,46(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     eaa:	move.w #392,48(a1)
    *copListCurrent++ = color;
     eb0:	move.w #1074,50(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     eb6:	move.w #394,52(a1)
    *copListCurrent++ = color;
     ebc:	move.w #1329,54(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ec2:	move.w #396,56(a1)
    *copListCurrent++ = color;
     ec8:	move.w #530,58(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ece:	move.w #398,60(a1)
    *copListCurrent++ = color;
     ed4:	move.w #2177,62(a1)
     eda:	lea 64(a1),a3
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpLogo.ImageData, BmpLogo.Bpls, BmpLogo.Bpl, 0);
     ede:	move.w 5316 <BmpLogo+0x4>,d6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     ee4:	move.l 5322 <BmpLogo+0x10>,d0
    for (USHORT i = 0; i < numPlanes; i++)
     eea:	tst.w d6
     eec:	bne.w 602 <main+0x58e>
     ef0:	moveq #0,d6
     ef2:	bra.w 64e <main+0x5da>
	*copPtr++ = 0x38 + ((Screen.Width - BmpLogo.Width) / 4);
     ef6:	addq.l #3,d1
     ef8:	asr.l #2,d1
     efa:	addi.w #56,d1
     efe:	move.w d1,10(a1)
	*copPtr++ = DDFSTOP;
     f02:	move.w #148,12(a1)
	*copPtr++ = 0xd0 - ((Screen.Width - BmpLogo.Width) / 4);
     f08:	tst.l d0
     f0a:	bge.w 54a <main+0x4d6>
     f0e:	bra.w e36 <main+0xdc2>
		KPrintF("p61Init failed!\n");
     f12:	pea 2eaa <incbin_player_end+0x4a>
     f18:	jsr (a5)
     f1a:	addq.l #4,sp
	SimpleBlit(BmpCookie, BmpLogo, ps, ps, 32, 32);
     f1c:	move.w 52ae <BmpCookie+0x4>,d1
	custom->bltcon0 = 0x09f0;
     f22:	movea.l 1d782 <custom>,a0
     f28:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     f2e:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     f34:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     f3a:	move.w #-1,70(a0)
	custom->bltamod = imgA.Bpl - (width / 8);
     f40:	move.w 52b2 <BmpCookie+0x8>,d0
     f46:	subq.w #4,d0
     f48:	move.w d0,100(a0)
	custom->bltdmod = imgD.Bpl - (width / 8);
     f4c:	move.w 531a <BmpLogo+0x8>,d0
     f52:	subq.w #4,d0
     f54:	move.w d0,102(a0)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
     f58:	move.l 52ba <BmpCookie+0x10>,80(a0)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
     f60:	move.l 5322 <BmpLogo+0x10>,84(a0)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     f68:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     f6c:	bra.w 858 <main+0x7e4>
		Exit(0);
     f70:	suba.l a6,a6
     f72:	moveq #0,d1
     f74:	jsr -144(a6)
     f78:	bra.w c2 <main+0x4e>
		Exit(0);
     f7c:	movea.l 1d774 <DOSBase>,a6
     f82:	moveq #0,d1
     f84:	jsr -144(a6)
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
     f88:	movea.l 1d77c <SysBase>,a6
     f8e:	lea 2e72 <incbin_player_end+0x12>,a1
     f94:	moveq #0,d0
     f96:	jsr -552(a6)
     f9a:	move.l d0,1d774 <DOSBase>
	if (!DOSBase)
     fa0:	bne.w c2 <main+0x4e>
     fa4:	bra.s f70 <main+0xefc>
	APTR vbr = 0;
     fa6:	moveq #0,d0
	VBR = GetVBR();
     fa8:	move.l d0,1d768 <VBR>
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     fae:	movea.l 1d768 <VBR>,a0
     fb4:	move.l 108(a0),d0
	SystemIrq = GetInterruptHandler(); //store interrupt register
     fb8:	move.l d0,1d764 <SystemIrq>
	WaitVbl();
     fbe:	jsr (a4)
	SetupCopper(copPtr);
     fc0:	movea.l 1d770 <copPtr>,a1
	*copPtr++ = DIWSTRT;
     fc6:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     fca:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     fd0:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     fd6:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     fdc:	move.w #146,8(a1)
	*copPtr++ = 0x38 + ((Screen.Width - BmpLogo.Width) / 4);
     fe2:	moveq #0,d1
     fe4:	move.w 5312 <BmpLogo>,d1
     fea:	move.l #320,d0
     ff0:	sub.l d1,d0
     ff2:	move.l d0,d1
     ff4:	bpl.w 534 <main+0x4c0>
     ff8:	bra.w ef6 <main+0xe82>

00000ffc <interruptHandler>:
void DisableMirrorEffect(void);
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

static __attribute__((interrupt)) void interruptHandler() {
     ffc:	movem.l d0/a0/a3/a6,-(sp)

	custom->intreq=(1<<INTB_VERTB); 
    1000:	movea.l 1d782 <custom>,a0
    1006:	move.w #32,156(a0)
	custom->intreq=(1<<INTB_VERTB); //reset vbl req. twice for a4000 bug.
    100c:	move.w #32,156(a0)
	register volatile const void *_a3 ASM("a3") = player;
    1012:	lea 14fa <incbin_player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    1018:	movea.l #14675968,a6
	__asm volatile(
    101e:	movem.l d0-a2/a4-a5,-(sp)
    1022:	jsr 4(a3)
    1026:	movem.l (sp)+,d0-a2/a4-a5

	// DEMO - ThePlayer
	p61Music();

	// DEMO - increment frameCounter
	frameCounter++;
    102a:	move.w 1d780 <frameCounter>,d0
    1030:	addq.w #1,d0
    1032:	move.w d0,1d780 <frameCounter>
}
    1038:	movem.l (sp)+,d0/a0/a3/a6
    103c:	rte

0000103e <WaitVbl>:
{
    103e:	subq.l #8,sp
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    1040:	move.l dff004 <_end+0xde187c>,d0
    1046:	move.l d0,(sp)
		vpos &= 0x1ff00;
    1048:	move.l (sp),d0
    104a:	andi.l #130816,d0
    1050:	move.l d0,(sp)
		if (vpos != (311 << 8))
    1052:	move.l (sp),d0
    1054:	cmpi.l #79616,d0
    105a:	beq.s 1040 <WaitVbl+0x2>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
    105c:	move.l dff004 <_end+0xde187c>,d0
    1062:	move.l d0,4(sp)
		vpos &= 0x1ff00;
    1066:	move.l 4(sp),d0
    106a:	andi.l #130816,d0
    1070:	move.l d0,4(sp)
		if (vpos == (311 << 8))
    1074:	move.l 4(sp),d0
    1078:	cmpi.l #79616,d0
    107e:	bne.s 105c <WaitVbl+0x1e>
}
    1080:	addq.l #8,sp
    1082:	rts

00001084 <KPrintF>:
void KPrintF(const char* fmt, ...) {
    1084:	lea -128(sp),sp
    1088:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    108c:	move.w f0ff60 <_end+0xef27d8>,d0
    1092:	cmpi.w #20153,d0
    1096:	beq.s 10c2 <KPrintF+0x3e>
    1098:	cmpi.w #-24562,d0
    109c:	beq.s 10c2 <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    109e:	movea.l 1d77c <SysBase>,a6
    10a4:	movea.l 144(sp),a0
    10a8:	lea 148(sp),a1
    10ac:	lea 1416 <KPutCharX>,a2
    10b2:	suba.l a3,a3
    10b4:	jsr -522(a6)
}
    10b8:	movem.l (sp)+,a2-a3/a6
    10bc:	lea 128(sp),sp
    10c0:	rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    10c2:	movea.l 1d77c <SysBase>,a6
    10c8:	movea.l 144(sp),a0
    10cc:	lea 148(sp),a1
    10d0:	lea 1424 <PutChar>,a2
    10d6:	lea 12(sp),a3
    10da:	jsr -522(a6)
		UaeDbgLog(86, temp);
    10de:	move.l a3,-(sp)
    10e0:	pea 56 <_start+0x56>
    10e4:	jsr f0ff60 <_end+0xef27d8>
    10ea:	addq.l #8,sp
}
    10ec:	movem.l (sp)+,a2-a3/a6
    10f0:	lea 128(sp),sp
    10f4:	rts

000010f6 <strlen>:
unsigned long strlen(const char* s) {
    10f6:	movea.l 4(sp),a0
	unsigned long t=0;
    10fa:	moveq #0,d0
	while(*s++)
    10fc:	tst.b (a0)
    10fe:	beq.s 1108 <strlen+0x12>
		t++;
    1100:	addq.l #1,d0
	while(*s++)
    1102:	tst.b (0,a0,d0.l)
    1106:	bne.s 1100 <strlen+0xa>
}
    1108:	rts

0000110a <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    110a:	movem.l d2-d7/a2-a3,-(sp)
    110e:	move.l 36(sp),d0
    1112:	move.l 40(sp),d4
    1116:	movea.l 44(sp),a1
	while(len-- > 0)
    111a:	move.l a1,d5
    111c:	subq.l #1,d5
    111e:	cmpa.w #0,a1
    1122:	beq.w 11d2 <memset+0xc8>
		*ptr++ = val;
    1126:	move.b d4,d7
    1128:	move.l d0,d1
    112a:	neg.l d1
    112c:	moveq #3,d2
    112e:	and.l d2,d1
    1130:	moveq #5,d6
    1132:	movea.l d0,a2
    1134:	cmp.l d5,d6
    1136:	bcc.s 11a2 <memset+0x98>
    1138:	tst.l d1
    113a:	beq.s 1160 <memset+0x56>
    113c:	move.b d4,(a2)+
	while(len-- > 0)
    113e:	subq.l #1,d5
    1140:	moveq #1,d2
    1142:	cmp.l d1,d2
    1144:	beq.s 1160 <memset+0x56>
		*ptr++ = val;
    1146:	movea.l d0,a2
    1148:	addq.l #2,a2
    114a:	movea.l d0,a0
    114c:	move.b d4,1(a0)
	while(len-- > 0)
    1150:	subq.l #1,d5
    1152:	moveq #3,d2
    1154:	cmp.l d1,d2
    1156:	bne.s 1160 <memset+0x56>
		*ptr++ = val;
    1158:	addq.l #1,a2
    115a:	move.b d4,2(a0)
	while(len-- > 0)
    115e:	subq.l #1,d5
    1160:	move.l a1,d3
    1162:	sub.l d1,d3
    1164:	moveq #0,d6
    1166:	move.b d4,d6
    1168:	move.l d6,d2
    116a:	swap d2
    116c:	clr.w d2
    116e:	movea.l d2,a0
    1170:	move.l d4,d2
    1172:	lsl.w #8,d2
    1174:	swap d2
    1176:	clr.w d2
    1178:	lsl.l #8,d6
    117a:	movea.l d6,a3
    117c:	move.l a0,d6
    117e:	or.l d6,d2
    1180:	move.l a3,d6
    1182:	or.l d6,d2
    1184:	move.b d7,d2
    1186:	movea.l d0,a0
    1188:	adda.l d1,a0
    118a:	moveq #-4,d1
    118c:	and.l d3,d1
    118e:	add.l a0,d1
		*ptr++ = val;
    1190:	move.l d2,(a0)+
	while(len-- > 0)
    1192:	cmpa.l d1,a0
    1194:	bne.s 1190 <memset+0x86>
    1196:	moveq #-4,d1
    1198:	and.l d3,d1
    119a:	adda.l d1,a2
    119c:	sub.l d1,d5
    119e:	cmp.l d3,d1
    11a0:	beq.s 11d2 <memset+0xc8>
		*ptr++ = val;
    11a2:	move.b d4,(a2)
	while(len-- > 0)
    11a4:	tst.l d5
    11a6:	beq.s 11d2 <memset+0xc8>
		*ptr++ = val;
    11a8:	move.b d4,1(a2)
	while(len-- > 0)
    11ac:	moveq #1,d1
    11ae:	cmp.l d5,d1
    11b0:	beq.s 11d2 <memset+0xc8>
		*ptr++ = val;
    11b2:	move.b d4,2(a2)
	while(len-- > 0)
    11b6:	moveq #2,d2
    11b8:	cmp.l d5,d2
    11ba:	beq.s 11d2 <memset+0xc8>
		*ptr++ = val;
    11bc:	move.b d4,3(a2)
	while(len-- > 0)
    11c0:	moveq #3,d6
    11c2:	cmp.l d5,d6
    11c4:	beq.s 11d2 <memset+0xc8>
		*ptr++ = val;
    11c6:	move.b d4,4(a2)
	while(len-- > 0)
    11ca:	subq.l #4,d5
    11cc:	beq.s 11d2 <memset+0xc8>
		*ptr++ = val;
    11ce:	move.b d4,5(a2)
}
    11d2:	movem.l (sp)+,d2-d7/a2-a3
    11d6:	rts

000011d8 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    11d8:	movem.l d2-d6,-(sp)
    11dc:	move.l 24(sp),d0
    11e0:	move.l 28(sp),d1
    11e4:	move.l 32(sp),d3
	while(len--)
    11e8:	move.l d3,d4
    11ea:	subq.l #1,d4
    11ec:	tst.l d3
    11ee:	beq.s 124e <memcpy+0x76>
    11f0:	movea.l d1,a0
    11f2:	addq.l #1,a0
    11f4:	move.l d0,d2
    11f6:	sub.l a0,d2
    11f8:	moveq #2,d5
    11fa:	cmp.l d2,d5
    11fc:	sc.s d2
    11fe:	neg.b d2
    1200:	moveq #8,d6
    1202:	cmp.l d4,d6
    1204:	sc.s d5
    1206:	neg.b d5
    1208:	and.b d5,d2
    120a:	beq.s 1254 <memcpy+0x7c>
    120c:	move.l d0,d2
    120e:	or.l d1,d2
    1210:	moveq #3,d5
    1212:	and.l d5,d2
    1214:	bne.s 1254 <memcpy+0x7c>
    1216:	movea.l d1,a0
    1218:	movea.l d0,a1
    121a:	moveq #-4,d2
    121c:	and.l d3,d2
    121e:	add.l d1,d2
		*d++ = *s++;
    1220:	move.l (a0)+,(a1)+
	while(len--)
    1222:	cmp.l a0,d2
    1224:	bne.s 1220 <memcpy+0x48>
    1226:	moveq #-4,d2
    1228:	and.l d3,d2
    122a:	movea.l d0,a0
    122c:	adda.l d2,a0
    122e:	add.l d2,d1
    1230:	sub.l d2,d4
    1232:	cmp.l d3,d2
    1234:	beq.s 124e <memcpy+0x76>
		*d++ = *s++;
    1236:	movea.l d1,a1
    1238:	move.b (a1),(a0)
	while(len--)
    123a:	tst.l d4
    123c:	beq.s 124e <memcpy+0x76>
		*d++ = *s++;
    123e:	move.b 1(a1),1(a0)
	while(len--)
    1244:	subq.l #1,d4
    1246:	beq.s 124e <memcpy+0x76>
		*d++ = *s++;
    1248:	move.b 2(a1),2(a0)
}
    124e:	movem.l (sp)+,d2-d6
    1252:	rts
    1254:	movea.l d0,a1
    1256:	add.l d3,d1
		*d++ = *s++;
    1258:	move.b -1(a0),(a1)+
	while(len--)
    125c:	cmp.l a0,d1
    125e:	beq.s 124e <memcpy+0x76>
    1260:	addq.l #1,a0
    1262:	bra.s 1258 <memcpy+0x80>

00001264 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    1264:	movem.l d2-d5/a2,-(sp)
    1268:	move.l 24(sp),d0
    126c:	move.l 28(sp),d1
    1270:	move.l 32(sp),d2
		while (len--)
    1274:	movea.l d2,a1
    1276:	subq.l #1,a1
	if (d < s) {
    1278:	cmp.l d0,d1
    127a:	bls.s 12e8 <memmove+0x84>
		while (len--)
    127c:	tst.l d2
    127e:	beq.s 12e2 <memmove+0x7e>
    1280:	movea.l d1,a2
    1282:	addq.l #1,a2
    1284:	move.l d0,d3
    1286:	sub.l a2,d3
    1288:	moveq #2,d4
    128a:	cmp.l d3,d4
    128c:	sc.s d3
    128e:	neg.b d3
    1290:	moveq #8,d5
    1292:	cmp.l a1,d5
    1294:	sc.s d4
    1296:	neg.b d4
    1298:	and.b d4,d3
    129a:	beq.s 130c <memmove+0xa8>
    129c:	move.l d0,d3
    129e:	or.l d1,d3
    12a0:	moveq #3,d4
    12a2:	and.l d4,d3
    12a4:	bne.s 130c <memmove+0xa8>
    12a6:	movea.l d1,a0
    12a8:	movea.l d0,a2
    12aa:	moveq #-4,d3
    12ac:	and.l d2,d3
    12ae:	add.l d1,d3
			*d++ = *s++;
    12b0:	move.l (a0)+,(a2)+
		while (len--)
    12b2:	cmp.l a0,d3
    12b4:	bne.s 12b0 <memmove+0x4c>
    12b6:	moveq #-4,d3
    12b8:	and.l d2,d3
    12ba:	movea.l d0,a2
    12bc:	adda.l d3,a2
    12be:	movea.l d1,a0
    12c0:	adda.l d3,a0
    12c2:	suba.l d3,a1
    12c4:	cmp.l d2,d3
    12c6:	beq.s 12e2 <memmove+0x7e>
			*d++ = *s++;
    12c8:	move.b (a0),(a2)
		while (len--)
    12ca:	cmpa.w #0,a1
    12ce:	beq.s 12e2 <memmove+0x7e>
			*d++ = *s++;
    12d0:	move.b 1(a0),1(a2)
		while (len--)
    12d6:	moveq #1,d5
    12d8:	cmp.l a1,d5
    12da:	beq.s 12e2 <memmove+0x7e>
			*d++ = *s++;
    12dc:	move.b 2(a0),2(a2)
}
    12e2:	movem.l (sp)+,d2-d5/a2
    12e6:	rts
		const char *lasts = s + (len - 1);
    12e8:	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    12ec:	adda.l d0,a1
		while (len--)
    12ee:	tst.l d2
    12f0:	beq.s 12e2 <memmove+0x7e>
    12f2:	move.l a0,d1
    12f4:	sub.l d2,d1
			*lastd-- = *lasts--;
    12f6:	move.b (a0),(a1)
		while (len--)
    12f8:	subq.l #1,a0
    12fa:	subq.l #1,a1
    12fc:	cmp.l a0,d1
    12fe:	beq.s 12e2 <memmove+0x7e>
			*lastd-- = *lasts--;
    1300:	move.b (a0),(a1)
		while (len--)
    1302:	subq.l #1,a0
    1304:	subq.l #1,a1
    1306:	cmp.l a0,d1
    1308:	bne.s 12f6 <memmove+0x92>
    130a:	bra.s 12e2 <memmove+0x7e>
    130c:	movea.l d0,a1
    130e:	add.l d2,d1
			*d++ = *s++;
    1310:	move.b -1(a2),(a1)+
		while (len--)
    1314:	cmp.l a2,d1
    1316:	beq.s 12e2 <memmove+0x7e>
    1318:	addq.l #1,a2
    131a:	bra.s 1310 <memmove+0xac>

0000131c <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    131c:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    1320:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1324:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    1328:	mulu.w 8(sp),d1
	addw	d1, d0
    132c:	add.w d1,d0
	swap	d0
    132e:	swap d0
	clrw	d0
    1330:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    1332:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    1336:	mulu.w 10(sp),d1
	addl	d1, d0
    133a:	add.l d1,d0
	rts
    133c:	rts

0000133e <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    133e:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    1340:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    1344:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    1348:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    134e:	bcc.s 1366 <__udivsi3+0x28>
	movel	d0, d2
    1350:	move.l d0,d2
	clrw	d2
    1352:	clr.w d2
	swap	d2
    1354:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    1356:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    1358:	move.w d2,d0
	swap	d0
    135a:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    135c:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    1360:	divu.w d1,d2
	movew	d2, d0
    1362:	move.w d2,d0
	jra	6f
    1364:	bra.s 1396 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    1366:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    1368:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    136a:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    136c:	cmpi.l #65536,d1
	jcc	4b
    1372:	bcc.s 1368 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    1374:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    1376:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    137c:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    137e:	mulu.w d0,d1
	swap	d2
    1380:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    1382:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    1384:	swap d2
	tstw	d2		/* high part 17 bits? */
    1386:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    1388:	bne.s 1394 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    138a:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    138c:	bcs.s 1394 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    138e:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    1392:	bls.s 1396 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    1394:	subq.l #1,d0

6:	movel	sp@+, d2
    1396:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1398:	rts

0000139a <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    139a:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    139c:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    139e:	move.l 12(sp),d1
	jpl	1f
    13a2:	bpl.s 13a8 <__divsi3+0xe>
	negl	d1
    13a4:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    13a6:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    13a8:	move.l 8(sp),d0
	jpl	2f
    13ac:	bpl.s 13b2 <__divsi3+0x18>
	negl	d0
    13ae:	neg.l d0
	negb	d2
    13b0:	neg.b d2

2:	movel	d1, sp@-
    13b2:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    13b4:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    13b6:	bsr.s 133e <__udivsi3>
	addql	#8, sp
    13b8:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    13ba:	tst.b d2
	jpl	3f
    13bc:	bpl.s 13c0 <__divsi3+0x26>
	negl	d0
    13be:	neg.l d0

3:	movel	sp@+, d2
    13c0:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    13c2:	rts

000013c4 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    13c4:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    13c8:	move.l 4(sp),d0
	movel	d1, sp@-
    13cc:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    13ce:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    13d0:	bsr.s 139a <__divsi3>
	addql	#8, sp
    13d2:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    13d4:	move.l 8(sp),d1
	movel	d1, sp@-
    13d8:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    13da:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    13dc:	bsr.w 131c <__mulsi3>
	addql	#8, sp
    13e0:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    13e2:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    13e6:	sub.l d0,d1
	movel	d1, d0
    13e8:	move.l d1,d0
	rts
    13ea:	rts

000013ec <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    13ec:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    13f0:	move.l 4(sp),d0
	movel	d1, sp@-
    13f4:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    13f6:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    13f8:	bsr.w 133e <__udivsi3>
	addql	#8, sp
    13fc:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    13fe:	move.l 8(sp),d1
	movel	d1, sp@-
    1402:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1404:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    1406:	bsr.w 131c <__mulsi3>
	addql	#8, sp
    140a:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    140c:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    1410:	sub.l d0,d1
	movel	d1, d0
    1412:	move.l d1,d0
	rts
    1414:	rts

00001416 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    1416:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    1418:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    141c:	jsr -516(a6)
    move.l (sp)+, a6
    1420:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    1422:	rts

00001424 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    1424:	move.b d0,(a3)+
	rts
    1426:	rts

00001428 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    1428:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    142a:	adda.l a0,a2
	move.l	a2,a3
    142c:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    142e:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    1430:	moveq #56,d4
	moveq	#8,d5
    1432:	moveq #8,d5
	bra.s	.Lliteral
    1434:	bra.s 149e <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    1436:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    1438:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    143a:	dbf d1,1436 <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    143e:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    1440:	bcc.s 1444 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    1442:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    1444:	tst.w d0
    1446:	bne.s 1450 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    1448:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    144a:	bls.s 14c2 <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    144c:	move.w (a0)+,d0
    144e:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    1450:	rol.l #6,d0
	move.w	d0,d1
    1452:	move.w d0,d1
	and.w	d4,d1
    1454:	and.w d4,d1
	eor.w	d1,d0
    1456:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    1458:	movem.w (14bc <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    145e:	rol.l d2,d0
	and.w	d0,d3					|scaling
    1460:	and.w d0,d3
	eor.w	d3,d0
    1462:	eor.w d3,d0
	suba.w	d3,a4
    1464:	suba.w d3,a4
	adda.l	a1,a4
    1466:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    1468:	tst.w d0
    146a:	bne.s 1470 <_doynaxdepack_asm+0x48>
    146c:	move.w (a0)+,d0
    146e:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    1470:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    1472:	beq.s 148a <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    1474:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    1476:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    1478:	bpl.s 1486 <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    147a:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    147c:	bpl.s 1484 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    147e:	addx.b d1,d1
	lsl.l	#2,d0
    1480:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    1482:	bmi.s 147e <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    1484:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    1486:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    1488:	bcc.s 148c <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    148a:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    148c:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    148e:	dbf d1,148a <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    1492:	add.l d0,d0
	bcc.s	.Lmatch
    1494:	bcc.s 1444 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    1496:	tst.w d0
    1498:	bne.s 149e <_doynaxdepack_asm+0x76>
    149a:	move.w (a0)+,d0
    149c:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    149e:	moveq #0,d1
	add.l	d0,d0
    14a0:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    14a2:	bcc.s 1442 <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    14a4:	bpl.s 14ac <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    14a6:	addx.b d1,d1
	lsl.l	#2,d0
    14a8:	lsl.l #2,d0
	bmi.s	.Llgetlen
    14aa:	bmi.s 14a6 <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    14ac:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    14ae:	dbv.s d1,1436 <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    14b2:	add.l d0,d0
	eor.w	d1,d0		
    14b4:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    14b6:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    14b8:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    14ba:	bra.s 14ae <_doynaxdepack_asm+0x86>

000014bc <doy_table>:
    14bc:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    14cc:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    14dc:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    14ec:	.............o
