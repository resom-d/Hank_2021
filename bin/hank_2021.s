
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
      14:	lea 4000 <ScrollerDir>,a2
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
      36:	lea 4000 <ScrollerDir>,a2
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
      5e:	lea 4000 <ScrollerDir>,a2
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
      80:	move.l a6,fe14 <SysBase>
	custom = (struct Custom *)0xdff000;
      86:	move.l #14675968,fe1a <custom>

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
      90:	lea 2c29 <incbin_player_end+0x1>,a1
      96:	moveq #0,d0
      98:	jsr -552(a6)
      9c:	move.l d0,fe10 <GfxBase>
	if (!GfxBase)
      a2:	beq.w d42 <main+0xcce>
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
      a6:	movea.l fe14 <SysBase>,a6
      ac:	lea 2c3a <incbin_player_end+0x12>,a1
      b2:	moveq #0,d0
      b4:	jsr -552(a6)
      b8:	move.l d0,fe0c <DOSBase>
	if (!DOSBase)
      be:	beq.w d36 <main+0xcc2>
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
      c2:	pea 2c46 <incbin_player_end+0x1e>
      c8:	lea e4c <KPrintF>,a5
      ce:	jsr (a5)
#endif

	Write(Output(), (APTR) "Hello console!\n", 15);
      d0:	movea.l fe0c <DOSBase>,a6
      d6:	jsr -60(a6)
      da:	movea.l fe0c <DOSBase>,a6
      e0:	move.l d0,d1
      e2:	move.l #11362,d2
      e8:	moveq #15,d3
      ea:	jsr -48(a6)

	copPtr = AllocMem(1024, MEMF_CHIP);
      ee:	movea.l fe14 <SysBase>,a6
      f4:	move.l #1024,d0
      fa:	moveq #2,d1
      fc:	jsr -198(a6)
     100:	move.l d0,fe08 <copPtr>
	BmpWorkP = AllocMem(BmpWork.Btot, MEMF_CHIP | MEMF_CLEAR);
     106:	movea.l fe14 <SysBase>,a6
     10c:	moveq #0,d0
     10e:	move.w 4078 <BmpWork+0xe>,d0
     114:	move.l #65538,d1
     11a:	jsr -198(a6)
     11e:	move.l d0,fe04 <BmpWorkP>

	//HANK
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
     124:	move.l #16544,4046 <BmpLogo+0x10>
	Enable();
}

void InitImagePlanes(BmpDescriptor *img)
{
	for (int p = 0; p < img->Bpls; p++)
     12e:	moveq #0,d2
     130:	move.w 403a <BmpLogo+0x4>,d2
     136:	addq.l #4,sp
     138:	tst.l d2
     13a:	beq.w 1e8 <main+0x174>
	{
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     13e:	moveq #0,d3
     140:	move.w 403e <BmpLogo+0x8>,d3
     146:	move.l #16544,404a <BmpLogo+0x14>
	for (int p = 0; p < img->Bpls; p++)
     150:	moveq #1,d1
     152:	cmp.l d2,d1
     154:	beq.w 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     158:	move.l d3,d4
     15a:	addi.l #16544,d4
     160:	move.l d4,404e <BmpLogo+0x18>
	for (int p = 0; p < img->Bpls; p++)
     166:	moveq #2,d1
     168:	cmp.l d2,d1
     16a:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     16c:	move.l d3,d1
     16e:	add.l d3,d1
     170:	move.l d1,d4
     172:	addi.l #16544,d4
     178:	move.l d4,4052 <BmpLogo+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     17e:	moveq #3,d4
     180:	cmp.l d2,d4
     182:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     184:	add.l d3,d1
     186:	move.l d1,d4
     188:	addi.l #16544,d4
     18e:	move.l d4,4056 <BmpLogo+0x20>
	for (int p = 0; p < img->Bpls; p++)
     194:	moveq #4,d4
     196:	cmp.l d2,d4
     198:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     19a:	add.l d3,d1
     19c:	move.l d1,d4
     19e:	addi.l #16544,d4
     1a4:	move.l d4,405a <BmpLogo+0x24>
	for (int p = 0; p < img->Bpls; p++)
     1aa:	moveq #5,d4
     1ac:	cmp.l d2,d4
     1ae:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     1b0:	add.l d3,d1
     1b2:	move.l d1,d4
     1b4:	addi.l #16544,d4
     1ba:	move.l d4,405e <BmpLogo+0x28>
	for (int p = 0; p < img->Bpls; p++)
     1c0:	moveq #6,d4
     1c2:	cmp.l d2,d4
     1c4:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     1c6:	add.l d3,d1
     1c8:	move.l d1,d4
     1ca:	addi.l #16544,d4
     1d0:	move.l d4,4062 <BmpLogo+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     1d6:	subq.l #7,d2
     1d8:	beq.s 1e8 <main+0x174>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     1da:	add.l d3,d1
     1dc:	addi.l #16544,d1
     1e2:	move.l d1,4066 <BmpLogo+0x30>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
     1e8:	move.l #29026,4012 <BmpFont32+0x10>
	BmpWork.ImageData = (UWORD *)BmpWorkP;
     1f2:	move.l d0,407a <BmpWork+0x10>
	for (int p = 0; p < img->Bpls; p++)
     1f8:	moveq #0,d2
     1fa:	move.w 406e <BmpWork+0x4>,d2
     200:	tst.l d2
     202:	beq.w 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     206:	moveq #0,d3
     208:	move.w 4072 <BmpWork+0x8>,d3
     20e:	move.l d0,407e <BmpWork+0x14>
	for (int p = 0; p < img->Bpls; p++)
     214:	moveq #1,d1
     216:	cmp.l d2,d1
     218:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     21a:	move.l d0,d4
     21c:	add.l d3,d4
     21e:	move.l d4,4082 <BmpWork+0x18>
	for (int p = 0; p < img->Bpls; p++)
     224:	moveq #2,d1
     226:	cmp.l d2,d1
     228:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     22a:	move.l d3,d1
     22c:	add.l d3,d1
     22e:	move.l d0,d4
     230:	add.l d1,d4
     232:	move.l d4,4086 <BmpWork+0x1c>
	for (int p = 0; p < img->Bpls; p++)
     238:	moveq #3,d4
     23a:	cmp.l d2,d4
     23c:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     23e:	add.l d3,d1
     240:	move.l d0,d4
     242:	add.l d1,d4
     244:	move.l d4,408a <BmpWork+0x20>
	for (int p = 0; p < img->Bpls; p++)
     24a:	moveq #4,d4
     24c:	cmp.l d2,d4
     24e:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     250:	add.l d3,d1
     252:	move.l d0,d4
     254:	add.l d1,d4
     256:	move.l d4,408e <BmpWork+0x24>
	for (int p = 0; p < img->Bpls; p++)
     25c:	moveq #5,d4
     25e:	cmp.l d2,d4
     260:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     262:	add.l d3,d1
     264:	move.l d0,d4
     266:	add.l d1,d4
     268:	move.l d4,4092 <BmpWork+0x28>
	for (int p = 0; p < img->Bpls; p++)
     26e:	moveq #6,d4
     270:	cmp.l d2,d4
     272:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     274:	add.l d3,d1
     276:	move.l d0,d4
     278:	add.l d1,d4
     27a:	move.l d4,4096 <BmpWork+0x2c>
	for (int p = 0; p < img->Bpls; p++)
     280:	subq.l #7,d2
     282:	beq.s 28e <main+0x21a>
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     284:	add.l d3,d1
     286:	add.l d1,d0
     288:	move.l d0,409a <BmpWork+0x30>
	ActiView = GfxBase->ActiView; //store current view
     28e:	movea.l fe10 <GfxBase>,a6
     294:	move.l 34(a6),fdf2 <ActiView>
	OwnBlitter();
     29c:	jsr -456(a6)
	WaitBlit();
     2a0:	movea.l fe10 <GfxBase>,a6
     2a6:	jsr -228(a6)
	Disable();
     2aa:	movea.l fe14 <SysBase>,a6
     2b0:	jsr -120(a6)
	SystemADKCON = custom->adkconr;
     2b4:	movea.l fe1a <custom>,a2
     2ba:	move.w 16(a2),d0
     2be:	move.w d0,fdf6 <SystemADKCON>
	SystemInts = custom->intenar;
     2c4:	move.w 28(a2),d0
     2c8:	move.w d0,fdfa <SystemInts>
	SystemDMA = custom->dmaconr;
     2ce:	move.w 2(a2),d0
     2d2:	move.w d0,fdf8 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     2d8:	move.w #32767,154(a2)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     2de:	move.w #32767,156(a2)
	WaitVbl();
     2e4:	lea e06 <WaitVbl>,a4
     2ea:	jsr (a4)
	WaitVbl();
     2ec:	jsr (a4)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     2ee:	move.w #32767,150(a2)
	for (int a = 0; a < 32; a++)
     2f4:	moveq #0,d1
		custom->color[a] = 0;
     2f6:	move.l d1,d0
     2f8:	addi.l #192,d0
     2fe:	add.l d0,d0
     300:	move.w #0,(0,a2,d0.l)
	for (int a = 0; a < 32; a++)
     306:	addq.l #1,d1
     308:	moveq #32,d0
     30a:	cmp.l d1,d0
     30c:	bne.s 2f6 <main+0x282>
	LoadView(0);
     30e:	movea.l fe10 <GfxBase>,a6
     314:	suba.l a1,a1
     316:	jsr -222(a6)
	WaitTOF();
     31a:	movea.l fe10 <GfxBase>,a6
     320:	jsr -270(a6)
	WaitTOF();
     324:	movea.l fe10 <GfxBase>,a6
     32a:	jsr -270(a6)
	WaitVbl();
     32e:	jsr (a4)
	WaitVbl();
     330:	jsr (a4)
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     332:	move.w #20090,50(sp)
     338:	move.w #2049,52(sp)
     33e:	move.w #20083,54(sp)
	if (SysBase->AttnFlags & AFF_68010)
     344:	movea.l fe14 <SysBase>,a6
     34a:	btst #0,297(a6)
     350:	beq.w d6c <main+0xcf8>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     354:	moveq #50,d7
     356:	add.l sp,d7
     358:	exg d7,a5
     35a:	jsr -30(a6)
     35e:	exg d7,a5
	VBR = GetVBR();
     360:	move.l d0,fe00 <VBR>
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     366:	movea.l fe00 <VBR>,a0
     36c:	move.l 108(a0),d0
	SystemIrq = GetInterruptHandler(); //store interrupt register
     370:	move.l d0,fdfc <SystemIrq>
	WaitVbl();
     376:	jsr (a4)
	SetupCopper(copPtr);
     378:	movea.l fe08 <copPtr>,a1
	*copPtr++ = DIWSTRT;
     37e:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     382:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     388:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     38e:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     394:	move.w #146,8(a1)
	*copPtr++ = 0x38 + ((Screen.Width - BmpLogo.Width) / 4);
     39a:	moveq #0,d1
     39c:	move.w 4036 <BmpLogo>,d1
     3a2:	move.l #320,d0
     3a8:	sub.l d1,d0
     3aa:	move.l d0,d1
     3ac:	bmi.w d0c <main+0xc98>
     3b0:	asr.l #2,d1
     3b2:	addi.w #56,d1
     3b6:	move.w d1,10(a1)
	*copPtr++ = DDFSTOP;
     3ba:	move.w #148,12(a1)
	*copPtr++ = 0xd0 - ((Screen.Width - BmpLogo.Width) / 4);
     3c0:	tst.l d0
     3c2:	blt.w c4c <main+0xbd8>
     3c6:	asr.l #2,d0
     3c8:	move.w #208,d1
     3cc:	sub.w d0,d1
     3ce:	move.w d1,14(a1)
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     3d2:	move.w 403e <BmpLogo+0x8>,d5
     3d8:	move.w 4040 <BmpLogo+0xa>,d3
     3de:	sub.w d5,d3


inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     3e0:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     3e6:	move.w d3,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     3ea:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     3f0:	move.w d3,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     3f4:	move.w #258,24(a1)
	*copPtr++ = 0;
     3fa:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     3fe:	move.w #260,28(a1)
	*copPtr++ = 1 << 6;	 //0x24;  Sprites have priority over playfields
     404:	move.w #64,30(a1)
    return copListEnd;
}

inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     40a:	move.w #384,32(a1)
    *copListCurrent++ = color;
     410:	clr.w 34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     414:	move.w #386,36(a1)
    *copListCurrent++ = color;
     41a:	move.w #1366,38(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     420:	move.w #388,40(a1)
    *copListCurrent++ = color;
     426:	move.w #3221,42(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     42c:	move.w #390,44(a1)
    *copListCurrent++ = color;
     432:	move.w #3750,46(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     438:	move.w #392,48(a1)
    *copListCurrent++ = color;
     43e:	move.w #1074,50(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     444:	move.w #394,52(a1)
    *copListCurrent++ = color;
     44a:	move.w #1329,54(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     450:	move.w #396,56(a1)
    *copListCurrent++ = color;
     456:	move.w #530,58(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     45c:	move.w #398,60(a1)
    *copListCurrent++ = color;
     462:	move.w #2177,62(a1)
     468:	lea 64(a1),a3
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpLogo.ImageData, BmpLogo.Bpls, BmpLogo.Bpl, 0);
     46c:	move.w 403a <BmpLogo+0x4>,d6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     472:	move.l 4046 <BmpLogo+0x10>,d0
    for (USHORT i = 0; i < numPlanes; i++)
     478:	tst.w d6
     47a:	beq.w d06 <main+0xc92>
        addr += Bpl;
     47e:	andi.l #65535,d5
     484:	move.w d6,d4
     486:	subq.w #1,d4
     488:	andi.l #65535,d4
     48e:	moveq #9,d2
     490:	add.l d2,d4
     492:	lsl.l #3,d4
     494:	add.l a1,d4
    *copListCurrent++ = color;
     496:	movea.l a3,a0
        addr += Bpl;
     498:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     49c:	move.w d1,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     49e:	move.l d0,d2
     4a0:	clr.w d2
     4a2:	swap d2
     4a4:	move.w d2,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     4a8:	movea.w d1,a2
     4aa:	addq.w #2,a2
     4ac:	move.w a2,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     4b0:	addq.l #8,a0
     4b2:	move.w d0,-2(a0)
        addr += Bpl;
     4b6:	add.l d5,d0
    for (USHORT i = 0; i < numPlanes; i++)
     4b8:	addq.w #4,d1
     4ba:	cmp.l a0,d4
     4bc:	bne.s 49c <main+0x428>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     4be:	andi.l #65535,d6
     4c4:	move.l d6,d0
     4c6:	lsl.l #3,d0
     4c8:	adda.l d0,a3
	*copPtr++ = BPLCON0;
     4ca:	move.w #256,(a3)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     4ce:	moveq #12,d0
     4d0:	lsl.l d0,d6
     4d2:	ori.w #512,d6
     4d6:	move.w d6,2(a3)
	copPtr = copWaitY(copPtr, 0x2c + BmpLogo.Height);
     4da:	move.w 4038 <BmpLogo+0x2>,d6
     4e0:	move.w d6,d0
     4e2:	addi.w #44,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     4e6:	lsl.w #8,d0
     4e8:	ori.w #5,d0
     4ec:	move.w d0,4(a3)
    *copListEnd++ = COP_WAIT;
     4f0:	move.w #-2,6(a3)
	*copPtr++ = DDFSTRT;
     4f6:	move.w #146,8(a3)
	*copPtr++ = 0x38;
     4fc:	move.w #56,10(a3)
	*copPtr++ = DDFSTOP;
     502:	move.w #148,12(a3)
	*copPtr++ = 0xd0;
     508:	move.w #208,14(a3)
						  BmpWork.Bplt - Screen.Bpl);
     50e:	move.w 4074 <BmpWork+0xa>,d0
     514:	addi.w #-40,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     518:	move.w #264,16(a3)
    *copListEnd++ = modOdd;
     51e:	move.w d0,18(a3)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     522:	move.w #266,20(a3)
    *copListEnd++ = modEven;
     528:	lea 24(a3),a2
     52c:	move.w d0,22(a3)
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     530:	move.l a2,fdea <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpWork.ImageData, BmpWork.Bpls, BmpWork.Bpl, 0);
     536:	move.w 4072 <BmpWork+0x8>,d4
     53c:	move.w 406e <BmpWork+0x4>,d5
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     542:	move.l 407a <BmpWork+0x10>,d0
    for (USHORT i = 0; i < numPlanes; i++)
     548:	tst.w d5
     54a:	beq.s 594 <main+0x520>
        addr += Bpl;
     54c:	andi.l #65535,d4
     552:	move.w d5,d1
     554:	subq.w #1,d1
     556:	andi.l #65535,d1
     55c:	addq.l #4,d1
     55e:	lsl.l #3,d1
     560:	adda.l d1,a3
     562:	movea.l a2,a0
     564:	move.w #224,d1
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     568:	move.w d1,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     56a:	move.l d0,d2
     56c:	clr.w d2
     56e:	swap d2
     570:	move.w d2,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     574:	move.w d1,d2
     576:	addq.w #2,d2
     578:	move.w d2,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     57c:	addq.l #8,a0
     57e:	move.w d0,-2(a0)
        addr += Bpl;
     582:	add.l d4,d0
    for (USHORT i = 0; i < numPlanes; i++)
     584:	addq.w #4,d1
     586:	cmpa.l a3,a0
     588:	bne.s 568 <main+0x4f4>
        *copListEnd++ = (UWORD)addr; // high-word of adress
     58a:	andi.l #65535,d5
     590:	lsl.l #3,d5
     592:	adda.l d5,a2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     594:	move.w #384,(a2)
    *copListCurrent++ = color;
     598:	clr.w 2(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     59c:	move.w #386,4(a2)
    *copListCurrent++ = color;
     5a2:	move.w #23,6(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5a8:	move.w #388,8(a2)
    *copListCurrent++ = color;
     5ae:	move.w #601,10(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5b4:	move.w #390,12(a2)
    *copListCurrent++ = color;
     5ba:	move.w #874,14(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5c0:	move.w #392,16(a2)
    *copListCurrent++ = color;
     5c6:	move.w #1163,18(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5cc:	move.w #394,20(a2)
    *copListCurrent++ = color;
     5d2:	move.w #1469,22(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5d8:	move.w #396,24(a2)
    *copListCurrent++ = color;
     5de:	move.w #1758,26(a2)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5e4:	move.w #398,28(a2)
    *copListCurrent++ = color;
     5ea:	move.w #2303,30(a2)
	copPtr = copWaitY(copPtr, 0x2c + BmpLogo.Height + 64);
     5f0:	addi.w #108,d6
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     5f4:	lsl.w #8,d6
     5f6:	ori.w #5,d6
     5fa:	move.w d6,32(a2)
    *copListEnd++ = COP_WAIT;
     5fe:	move.w #-2,34(a2)
     604:	lea 36(a2),a0
     608:	move.l a0,fde0 <copMirrorBmpP>
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     60e:	move.w #264,36(a2)
    *copListEnd++ = modOdd;
     614:	move.w d3,38(a2)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     618:	move.w #266,40(a2)
    *copListEnd++ = modEven;
     61e:	move.w d3,42(a2)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     622:	move.w #-1,44(a2)
    *copListEnd++ = COP_WAIT;
     628:	move.w #-2,46(a2)
	custom->cop1lc = (ULONG)copPtr;
     62e:	movea.l fe1a <custom>,a0
     634:	move.l a1,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
     638:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
     63e:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER;
     644:	move.w #-31808,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     64a:	movea.l fe00 <VBR>,a1
     650:	move.l #3524,108(a1)
	custom->intena = INTF_SETCLR | INTF_EXTER; // ThePlayer needs INTF_EXTER
     658:	move.w #-24576,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
     65e:	move.w #32,156(a0)
}


int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
	register volatile const void *_a0 ASM("a0") = module;
     664:	lea e964 <incbin_module_start>,a0
	register volatile const void *_a1 ASM("a1") = NULL;
     66a:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
     66c:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = player;
     66e:	lea 12c2 <incbin_player_start>,a3
	register int _d0 ASM("d0"); // return value
	__asm volatile(
     674:	movem.l d1-d7/a4-a6,-(sp)
     678:	jsr (a3)
     67a:	movem.l (sp)+,d1-d7/a4-a6
	if(p61Init(module) != 0)
     67e:	tst.l d0
     680:	bne.w d28 <main+0xcb4>
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
     684:	move.b bfe001 <_end+0xbee1e1>,d0
	while (!MouseLeft())
     68a:	btst #6,d0
     68e:	beq.w 820 <main+0x7ac>
			ScrollerY += ScrollerDir;
     692:	move.w fdee <ScrollerY>,d5
		Scrollit(BmpWork, (UBYTE *)BmpWork.ImageData, 40, 32, 4);
     698:	move.l 407a <BmpWork+0x10>,d3
     69e:	move.w 406e <BmpWork+0x4>,d2
     6a4:	lea 406a <BmpWork>,a5
     6aa:	lea 10e4 <__mulsi3>,a3
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     6b0:	move.l dff004 <_end+0xdef1e4>,d0
     6b6:	move.l d0,50(sp)
		vpos &= 0x1ff00;
     6ba:	move.l 50(sp),d0
     6be:	andi.l #130816,d0
     6c4:	move.l d0,50(sp)
		if (vpos != (311 << 8))
     6c8:	move.l 50(sp),d0
     6cc:	cmpi.l #79616,d0
     6d2:	beq.s 6b0 <main+0x63c>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     6d4:	move.l dff004 <_end+0xdef1e4>,d0
     6da:	move.l d0,46(sp)
		vpos &= 0x1ff00;
     6de:	move.l 46(sp),d0
     6e2:	andi.l #130816,d0
     6e8:	move.l d0,46(sp)
		if (vpos == (311 << 8))
     6ec:	move.l 46(sp),d0
     6f0:	cmpi.l #79616,d0
     6f6:	bne.s 6d4 <main+0x660>
		if (BounceEnabled)
     6f8:	tst.w fdf0 <BounceEnabled>
     6fe:	beq.s 710 <main+0x69c>
			ScrollerY += ScrollerDir;
     700:	move.b 4000 <ScrollerDir>,d0
     706:	ext.w d0
     708:	add.w d0,d5
     70a:	move.w d5,fdee <ScrollerY>
		if (ScrollerY >= ScollerMax)
     710:	movea.w d5,a0
     712:	cmpi.w #29,d5
     716:	ble.w b74 <main+0xb00>
			ScrollerY = ScollerMax;
     71a:	move.w #30,fdee <ScrollerY>
			ScrollerDir = -2;
     722:	move.b #-2,4000 <ScrollerDir>
		Scrollit(BmpWork, (UBYTE *)BmpWork.ImageData, 40, 32, 4);
     72a:	move.w 4074 <BmpWork+0xa>,d5
	int BltOffs = startY * theDesc.Bplt;
     730:	move.w d5,d6
     732:	mulu.w #40,d6
	int Brcorner = height * theDesc.Bplt - 2;
     736:	andi.l #65535,d5
     73c:	lsl.l #5,d5
     73e:	subq.l #2,d5
	WaitBlit();
     740:	movea.l fe10 <GfxBase>,a6
     746:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     74a:	movea.l fe1a <custom>,a0
     750:	move.w #18928,64(a0)
	custom->bltcon1 = 0x0002;
     756:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     75c:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     762:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     768:	add.l d6,d5
     76a:	add.l d5,d3
     76c:	move.l d3,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     770:	move.l d3,84(a0)
	custom->bltamod = 0;
     774:	move.w #0,100(a0)
	custom->bltdmod = 0;
     77a:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpWork.Width / 16;
     780:	moveq #11,d0
     782:	lsl.w d0,d2
     784:	move.w (a5),d0
     786:	lsr.w #4,d0
     788:	add.w d0,d2
     78a:	move.w d2,88(a0)
	ScrollCnt += speed;
     78e:	move.w fde8 <ScrollCnt>,d0
     794:	addq.w #4,d0
     796:	move.w d0,fde8 <ScrollCnt>
	if (ScrollCnt >= 32)
     79c:	cmpi.w #31,d0
     7a0:	bhi.w 946 <main+0x8d2>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpWork.ImageData, BmpWork.Bpls, BmpWork.Bpl, ScrollerY);
     7a4:	move.w 4072 <BmpWork+0x8>,d6
     7aa:	move.l 407a <BmpWork+0x10>,d3
     7b0:	move.w fdee <ScrollerY>,d5
     7b6:	move.w 406e <BmpWork+0x4>,d2
     7bc:	moveq #0,d7
     7be:	move.w d2,d7
     7c0:	movea.l fdea <copScrollerBmpP>,a2
     7c6:	andi.l #65535,d6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     7cc:	move.l d6,-(sp)
     7ce:	movea.w d5,a0
     7d0:	move.l a0,-(sp)
     7d2:	jsr (a3)
     7d4:	addq.l #4,sp
     7d6:	move.l d7,(sp)
     7d8:	move.l d0,-(sp)
     7da:	jsr (a3)
     7dc:	addq.l #8,sp
     7de:	add.l d3,d0
    for (USHORT i = 0; i < numPlanes; i++)
     7e0:	tst.l d7
     7e2:	beq.s 812 <main+0x79e>
        addr += Bpl;
     7e4:	move.w #224,d1
    for (USHORT i = 0; i < numPlanes; i++)
     7e8:	suba.l a0,a0
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     7ea:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     7ec:	move.l d0,d4
     7ee:	clr.w d4
     7f0:	swap d4
     7f2:	move.w d4,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     7f6:	movea.w d1,a1
     7f8:	addq.w #2,a1
     7fa:	move.w a1,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     7fe:	addq.l #8,a2
     800:	move.w d0,-2(a2)
        addr += Bpl;
     804:	add.l d6,d0
    for (USHORT i = 0; i < numPlanes; i++)
     806:	addq.w #1,a0
     808:	addq.w #4,d1
     80a:	moveq #0,d4
     80c:	move.w a0,d4
     80e:	cmp.l d7,d4
     810:	blt.s 7ea <main+0x776>
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
     812:	move.b bfe001 <_end+0xbee1e1>,d0
	while (!MouseLeft())
     818:	btst #6,d0
     81c:	bne.w 6b0 <main+0x63c>
		: "cc", "memory");
}

void p61End()
{
	register volatile const void *_a3 ASM("a3") = player;
     820:	lea 12c2 <incbin_player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
     826:	movea.l #14675968,a6
	__asm volatile(
     82c:	movem.l d0-d1/a0-a1,-(sp)
     830:	jsr 8(a3)
     834:	movem.l (sp)+,d0-d1/a0-a1
	FreeMem(copPtr, 1024);
     838:	movea.l fe14 <SysBase>,a6
     83e:	movea.l fe08 <copPtr>,a1
     844:	move.l #1024,d0
     84a:	jsr -210(a6)
	FreeMem((UBYTE *)BmpWorkP, BmpWork.Btot);
     84e:	movea.l fe14 <SysBase>,a6
     854:	movea.l fe04 <BmpWorkP>,a1
     85a:	moveq #0,d0
     85c:	move.w 4078 <BmpWork+0xe>,d0
     862:	jsr -210(a6)
	WaitVbl();
     866:	jsr (a4)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     868:	movea.l fe1a <custom>,a0
     86e:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     872:	move.w 2(a0),d0
     876:	btst #14,d0
     87a:	bne.s 872 <main+0x7fe>
	custom->intena = 0x7fff; //disable all interrupts
     87c:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     882:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     888:	move.w #32767,150(a0)
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     88e:	movea.l fe00 <VBR>,a1
     894:	move.l fdfc <SystemIrq>,108(a1)
	custom->cop1lc = (ULONG)GfxBase->copinit;
     89c:	movea.l fe10 <GfxBase>,a6
     8a2:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     8a8:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     8ae:	move.w #32767,136(a0)
	custom->intena = SystemInts | 0x8000;
     8b4:	move.w fdfa <SystemInts>,d0
     8ba:	ori.w #-32768,d0
     8be:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     8c2:	move.w fdf8 <SystemDMA>,d0
     8c8:	ori.w #-32768,d0
     8cc:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     8d0:	move.w fdf6 <SystemADKCON>,d0
     8d6:	ori.w #-32768,d0
     8da:	move.w d0,158(a0)
	LoadView(ActiView);
     8de:	movea.l fdf2 <ActiView>,a1
     8e4:	jsr -222(a6)
	WaitTOF();
     8e8:	movea.l fe10 <GfxBase>,a6
     8ee:	jsr -270(a6)
	WaitTOF();
     8f2:	movea.l fe10 <GfxBase>,a6
     8f8:	jsr -270(a6)
	WaitBlit();
     8fc:	movea.l fe10 <GfxBase>,a6
     902:	jsr -228(a6)
	DisownBlitter();
     906:	movea.l fe10 <GfxBase>,a6
     90c:	jsr -462(a6)
	Enable();
     910:	movea.l fe14 <SysBase>,a6
     916:	jsr -126(a6)
	CloseLibrary((struct Library *)DOSBase);
     91a:	movea.l fe14 <SysBase>,a6
     920:	movea.l fe0c <DOSBase>,a1
     926:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
     92a:	movea.l fe14 <SysBase>,a6
     930:	movea.l fe10 <GfxBase>,a1
     936:	jsr -414(a6)
}
     93a:	moveq #0,d0
     93c:	movem.l (sp)+,d2-d7/a2-a6
     940:	lea 12(sp),sp
     944:	rts
		ScrollCnt = 0;
     946:	clr.w fde8 <ScrollCnt>
		PlotChar(BmpFont32, (UBYTE *)BmpFont32P, BmpWork, (UBYTE *)BmpWork.ImageData, startY, 32, 32);
     94c:	move.l 407a <BmpWork+0x10>,d3
     952:	move.w 4006 <BmpFont32+0x4>,d5
     958:	move.w 400a <BmpFont32+0x8>,d7
     95e:	movea.w 400c <BmpFont32+0xa>,a1
     964:	move.w 4072 <BmpWork+0x8>,d6
     96a:	movea.w 4074 <BmpWork+0xa>,a6
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     970:	movea.w fde6 <ScrolltextCnt>,a0
     976:	move.w a0,d1
     978:	addq.w #1,d1
     97a:	move.w d1,fde6 <ScrolltextCnt>
     980:	moveq #0,d0
     982:	move.w a0,d0
     984:	lea 2c83 <Scrolltext>,a2
     98a:	move.b (0,a2,d0.l),d0
	if (chr == 'a')
     98e:	cmpi.b #97,d0
     992:	beq.w b32 <main+0xabe>
	if (chr == 'b')
     996:	cmpi.b #98,d0
     99a:	beq.w a30 <main+0x9bc>
	if (chr == 0)
     99e:	tst.b d0
     9a0:	bne.w a88 <main+0xa14>
		chr = Scrolltext[ScrolltextCnt++];
     9a4:	move.w #1,fde6 <ScrolltextCnt>
     9ac:	suba.l a2,a2
     9ae:	moveq #4,d1
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     9b0:	move.l d1,-(sp)
     9b2:	move.w a1,-(sp)
     9b4:	clr.w -(sp)
     9b6:	jsr (a3)
     9b8:	addq.l #8,sp
     9ba:	move.l d0,d2
     9bc:	lsl.l #5,d2
     9be:	add.l a2,d2
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     9c0:	moveq #0,d0
     9c2:	move.w a6,d0
     9c4:	addq.l #1,d0
     9c6:	movea.l d0,a2
     9c8:	adda.l d0,a2
     9ca:	adda.l a2,a2
     9cc:	add.l a2,d0
     9ce:	lsl.l #3,d0
     9d0:	movea.l d0,a2
	WaitBlit();
     9d2:	movea.l fe10 <GfxBase>,a6
     9d8:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     9dc:	movea.l fe1a <custom>,a0
     9e2:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     9e8:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     9ee:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     9f4:	move.w #-1,70(a0)
	custom->bltapt = bmpFontP + source;
     9fa:	addi.l #29026,d2
     a00:	move.l d2,80(a0)
	custom->bltdpt = bmpDestP + dest;
     a04:	add.l a2,d3
     a06:	move.l d3,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     a0a:	subq.w #4,d7
     a0c:	move.w d7,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     a10:	subq.w #4,d6
     a12:	move.w d6,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     a16:	moveq #11,d0
     a18:	lsl.w d0,d5
     a1a:	addq.w #2,d5
     a1c:	move.w d5,88(a0)
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpWork.ImageData, BmpWork.Bpls, BmpWork.Bpl, ScrollerY);
     a20:	move.w 4072 <BmpWork+0x8>,d6
     a26:	move.l 407a <BmpWork+0x10>,d3
     a2c:	bra.w 7b0 <main+0x73c>
		if (MirrorEnabled)
     a30:	move.w fde4 <MirrorEnabled>,d0
				 BmpWork.Bplt - Screen.Bpl);
     a36:	move.w a6,d2
     a38:	addi.w #-40,d2
	copSetBplMod(0, copMirrorBmpP,
     a3c:	movea.l fde0 <copMirrorBmpP>,a0
		if (MirrorEnabled)
     a42:	tst.w d0
     a44:	beq.w c08 <main+0xb94>
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     a48:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     a4c:	move.w d2,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     a50:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     a56:	move.w d2,6(a0)
		MirrorEnabled = !MirrorEnabled;
     a5a:	tst.w d0
     a5c:	seq d0
     a5e:	ext.w d0
     a60:	neg.w d0
     a62:	move.w d0,fde4 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     a68:	move.w d1,d0
     a6a:	addq.w #1,d0
     a6c:	move.w d0,fde6 <ScrolltextCnt>
     a72:	andi.l #65535,d1
     a78:	lea 2c83 <Scrolltext>,a0
     a7e:	move.b (0,a0,d1.l),d0
	if (chr == 0)
     a82:	tst.b d0
     a84:	beq.w 9a4 <main+0x930>
	if (chr < 32 || chr > (32 + 80))
     a88:	addi.b #-32,d0
     a8c:	cmpi.b #80,d0
     a90:	bhi.w 7b0 <main+0x73c>
	row = chr / 10;
     a94:	andi.w #255,d0
     a98:	move.w d0,d2
     a9a:	mulu.w #-13107,d2
     a9e:	clr.w d2
     aa0:	swap d2
     aa2:	lsr.w #3,d2
     aa4:	moveq #0,d1
     aa6:	move.b d2,d1
	col = chr % 10;
     aa8:	movea.w d2,a0
     aaa:	adda.w d2,a0
     aac:	adda.w a0,a0
     aae:	adda.w d2,a0
     ab0:	adda.w a0,a0
     ab2:	sub.w a0,d0
     ab4:	moveq #0,d2
     ab6:	move.b d0,d2
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     ab8:	add.l d2,d2
     aba:	movea.l d2,a2
     abc:	adda.l d2,a2
     abe:	move.l d1,-(sp)
     ac0:	move.w a1,-(sp)
     ac2:	clr.w -(sp)
     ac4:	jsr (a3)
     ac6:	addq.l #8,sp
     ac8:	move.l d0,d2
     aca:	lsl.l #5,d2
     acc:	add.l a2,d2
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     ace:	moveq #0,d0
     ad0:	move.w a6,d0
     ad2:	addq.l #1,d0
     ad4:	movea.l d0,a2
     ad6:	adda.l d0,a2
     ad8:	adda.l a2,a2
     ada:	add.l a2,d0
     adc:	lsl.l #3,d0
     ade:	movea.l d0,a2
	WaitBlit();
     ae0:	movea.l fe10 <GfxBase>,a6
     ae6:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     aea:	movea.l fe1a <custom>,a0
     af0:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     af6:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     afc:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     b02:	move.w #-1,70(a0)
	custom->bltapt = bmpFontP + source;
     b08:	addi.l #29026,d2
     b0e:	move.l d2,80(a0)
	custom->bltdpt = bmpDestP + dest;
     b12:	add.l a2,d3
     b14:	move.l d3,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     b18:	subq.w #4,d7
     b1a:	move.w d7,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     b1e:	subq.w #4,d6
     b20:	move.w d6,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     b24:	moveq #11,d0
     b26:	lsl.w d0,d5
     b28:	addq.w #2,d5
     b2a:	move.w d5,88(a0)
     b2e:	bra.w a20 <main+0x9ac>
		if (BounceEnabled)
     b32:	move.w fdf0 <BounceEnabled>,d0
     b38:	beq.s b40 <main+0xacc>
			ScrollerY = 0;
     b3a:	clr.w fdee <ScrollerY>
		BounceEnabled = !BounceEnabled;
     b40:	tst.w d0
     b42:	seq d0
     b44:	ext.w d0
     b46:	neg.w d0
     b48:	move.w d0,fdf0 <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     b4e:	addq.w #2,a0
     b50:	move.w a0,fde6 <ScrolltextCnt>
     b56:	andi.l #65535,d1
     b5c:	lea 2c83 <Scrolltext>,a2
     b62:	move.b (0,a2,d1.l),d0
     b66:	move.w a0,d1
	if (chr == 'b')
     b68:	cmpi.b #98,d0
     b6c:	bne.w 99e <main+0x92a>
     b70:	bra.w a30 <main+0x9bc>
		else if (ScrollerY <= ScollerMin)
     b74:	cmpa.w #0,a0
     b78:	bgt.w 72a <main+0x6b6>
			ScrollerY = ScollerMin;
     b7c:	clr.w fdee <ScrollerY>
			ScrollerDir = 2;
     b82:	move.b #2,4000 <ScrollerDir>
		Scrollit(BmpWork, (UBYTE *)BmpWork.ImageData, 40, 32, 4);
     b8a:	move.w 4074 <BmpWork+0xa>,d5
	int BltOffs = startY * theDesc.Bplt;
     b90:	move.w d5,d6
     b92:	mulu.w #40,d6
	int Brcorner = height * theDesc.Bplt - 2;
     b96:	andi.l #65535,d5
     b9c:	lsl.l #5,d5
     b9e:	subq.l #2,d5
	WaitBlit();
     ba0:	movea.l fe10 <GfxBase>,a6
     ba6:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     baa:	movea.l fe1a <custom>,a0
     bb0:	move.w #18928,64(a0)
	custom->bltcon1 = 0x0002;
     bb6:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     bbc:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     bc2:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     bc8:	add.l d6,d5
     bca:	add.l d5,d3
     bcc:	move.l d3,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     bd0:	move.l d3,84(a0)
	custom->bltamod = 0;
     bd4:	move.w #0,100(a0)
	custom->bltdmod = 0;
     bda:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpWork.Width / 16;
     be0:	moveq #11,d0
     be2:	lsl.w d0,d2
     be4:	move.w (a5),d0
     be6:	lsr.w #4,d0
     be8:	add.w d0,d2
     bea:	move.w d2,88(a0)
	ScrollCnt += speed;
     bee:	move.w fde8 <ScrollCnt>,d0
     bf4:	addq.w #4,d0
     bf6:	move.w d0,fde8 <ScrollCnt>
	if (ScrollCnt >= 32)
     bfc:	cmpi.w #31,d0
     c00:	bls.w 7a4 <main+0x730>
     c04:	bra.w 946 <main+0x8d2>
				 (BmpWork.Bplt - Screen.Bpl) - (BmpWork.Bplt * 2));
     c08:	movea.w a6,a2
     c0a:	adda.w a6,a2
     c0c:	sub.w a2,d2
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     c0e:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     c12:	move.w d2,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     c16:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     c1c:	move.w d2,6(a0)
		MirrorEnabled = !MirrorEnabled;
     c20:	tst.w d0
     c22:	seq d0
     c24:	ext.w d0
     c26:	neg.w d0
     c28:	move.w d0,fde4 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     c2e:	move.w d1,d0
     c30:	addq.w #1,d0
     c32:	move.w d0,fde6 <ScrolltextCnt>
     c38:	andi.l #65535,d1
     c3e:	lea 2c83 <Scrolltext>,a0
     c44:	move.b (0,a0,d1.l),d0
     c48:	bra.w a82 <main+0xa0e>
	*copPtr++ = 0xd0 - ((Screen.Width - BmpLogo.Width) / 4);
     c4c:	addq.l #3,d0
     c4e:	asr.l #2,d0
     c50:	move.w #208,d1
     c54:	sub.w d0,d1
     c56:	move.w d1,14(a1)
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     c5a:	move.w 403e <BmpLogo+0x8>,d5
     c60:	move.w 4040 <BmpLogo+0xa>,d3
     c66:	sub.w d5,d3
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     c68:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     c6e:	move.w d3,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     c72:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     c78:	move.w d3,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     c7c:	move.w #258,24(a1)
	*copPtr++ = 0;
     c82:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     c86:	move.w #260,28(a1)
	*copPtr++ = 1 << 6;	 //0x24;  Sprites have priority over playfields
     c8c:	move.w #64,30(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c92:	move.w #384,32(a1)
    *copListCurrent++ = color;
     c98:	clr.w 34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c9c:	move.w #386,36(a1)
    *copListCurrent++ = color;
     ca2:	move.w #1366,38(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ca8:	move.w #388,40(a1)
    *copListCurrent++ = color;
     cae:	move.w #3221,42(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     cb4:	move.w #390,44(a1)
    *copListCurrent++ = color;
     cba:	move.w #3750,46(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     cc0:	move.w #392,48(a1)
    *copListCurrent++ = color;
     cc6:	move.w #1074,50(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ccc:	move.w #394,52(a1)
    *copListCurrent++ = color;
     cd2:	move.w #1329,54(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     cd8:	move.w #396,56(a1)
    *copListCurrent++ = color;
     cde:	move.w #530,58(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ce4:	move.w #398,60(a1)
    *copListCurrent++ = color;
     cea:	move.w #2177,62(a1)
     cf0:	lea 64(a1),a3
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpLogo.ImageData, BmpLogo.Bpls, BmpLogo.Bpl, 0);
     cf4:	move.w 403a <BmpLogo+0x4>,d6
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     cfa:	move.l 4046 <BmpLogo+0x10>,d0
    for (USHORT i = 0; i < numPlanes; i++)
     d00:	tst.w d6
     d02:	bne.w 47e <main+0x40a>
     d06:	moveq #0,d6
     d08:	bra.w 4ca <main+0x456>
	*copPtr++ = 0x38 + ((Screen.Width - BmpLogo.Width) / 4);
     d0c:	addq.l #3,d1
     d0e:	asr.l #2,d1
     d10:	addi.w #56,d1
     d14:	move.w d1,10(a1)
	*copPtr++ = DDFSTOP;
     d18:	move.w #148,12(a1)
	*copPtr++ = 0xd0 - ((Screen.Width - BmpLogo.Width) / 4);
     d1e:	tst.l d0
     d20:	bge.w 3c6 <main+0x352>
     d24:	bra.w c4c <main+0xbd8>
		KPrintF("p61Init failed!\n");
     d28:	pea 2c72 <incbin_player_end+0x4a>
     d2e:	jsr (a5)
     d30:	addq.l #4,sp
     d32:	bra.w 684 <main+0x610>
		Exit(0);
     d36:	suba.l a6,a6
     d38:	moveq #0,d1
     d3a:	jsr -144(a6)
     d3e:	bra.w c2 <main+0x4e>
		Exit(0);
     d42:	movea.l fe0c <DOSBase>,a6
     d48:	moveq #0,d1
     d4a:	jsr -144(a6)
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
     d4e:	movea.l fe14 <SysBase>,a6
     d54:	lea 2c3a <incbin_player_end+0x12>,a1
     d5a:	moveq #0,d0
     d5c:	jsr -552(a6)
     d60:	move.l d0,fe0c <DOSBase>
	if (!DOSBase)
     d66:	bne.w c2 <main+0x4e>
     d6a:	bra.s d36 <main+0xcc2>
	APTR vbr = 0;
     d6c:	moveq #0,d0
	VBR = GetVBR();
     d6e:	move.l d0,fe00 <VBR>
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     d74:	movea.l fe00 <VBR>,a0
     d7a:	move.l 108(a0),d0
	SystemIrq = GetInterruptHandler(); //store interrupt register
     d7e:	move.l d0,fdfc <SystemIrq>
	WaitVbl();
     d84:	jsr (a4)
	SetupCopper(copPtr);
     d86:	movea.l fe08 <copPtr>,a1
	*copPtr++ = DIWSTRT;
     d8c:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     d90:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     d96:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     d9c:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     da2:	move.w #146,8(a1)
	*copPtr++ = 0x38 + ((Screen.Width - BmpLogo.Width) / 4);
     da8:	moveq #0,d1
     daa:	move.w 4036 <BmpLogo>,d1
     db0:	move.l #320,d0
     db6:	sub.l d1,d0
     db8:	move.l d0,d1
     dba:	bpl.w 3b0 <main+0x33c>
     dbe:	bra.w d0c <main+0xc98>
     dc2:	nop

00000dc4 <interruptHandler>:
void DisableMirrorEffect(void);
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

static __attribute__((interrupt)) void interruptHandler() {
     dc4:	movem.l d0/a0/a3/a6,-(sp)

	custom->intreq=(1<<INTB_VERTB); 
     dc8:	movea.l fe1a <custom>,a0
     dce:	move.w #32,156(a0)
	custom->intreq=(1<<INTB_VERTB); //reset vbl req. twice for a4000 bug.
     dd4:	move.w #32,156(a0)
	register volatile const void *_a3 ASM("a3") = player;
     dda:	lea 12c2 <incbin_player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
     de0:	movea.l #14675968,a6
	__asm volatile(
     de6:	movem.l d0-a2/a4-a5,-(sp)
     dea:	jsr 4(a3)
     dee:	movem.l (sp)+,d0-a2/a4-a5

	// DEMO - ThePlayer
	p61Music();

	// DEMO - increment frameCounter
	frameCounter++;
     df2:	move.w fe18 <frameCounter>,d0
     df8:	addq.w #1,d0
     dfa:	move.w d0,fe18 <frameCounter>
}
     e00:	movem.l (sp)+,d0/a0/a3/a6
     e04:	rte

00000e06 <WaitVbl>:
{
     e06:	subq.l #8,sp
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     e08:	move.l dff004 <_end+0xdef1e4>,d0
     e0e:	move.l d0,(sp)
		vpos &= 0x1ff00;
     e10:	move.l (sp),d0
     e12:	andi.l #130816,d0
     e18:	move.l d0,(sp)
		if (vpos != (311 << 8))
     e1a:	move.l (sp),d0
     e1c:	cmpi.l #79616,d0
     e22:	beq.s e08 <WaitVbl+0x2>
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     e24:	move.l dff004 <_end+0xdef1e4>,d0
     e2a:	move.l d0,4(sp)
		vpos &= 0x1ff00;
     e2e:	move.l 4(sp),d0
     e32:	andi.l #130816,d0
     e38:	move.l d0,4(sp)
		if (vpos == (311 << 8))
     e3c:	move.l 4(sp),d0
     e40:	cmpi.l #79616,d0
     e46:	bne.s e24 <WaitVbl+0x1e>
}
     e48:	addq.l #8,sp
     e4a:	rts

00000e4c <KPrintF>:
void KPrintF(const char* fmt, ...) {
     e4c:	lea -128(sp),sp
     e50:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
     e54:	move.w f0ff60 <_end+0xf00140>,d0
     e5a:	cmpi.w #20153,d0
     e5e:	beq.s e8a <KPrintF+0x3e>
     e60:	cmpi.w #-24562,d0
     e64:	beq.s e8a <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
     e66:	movea.l fe14 <SysBase>,a6
     e6c:	movea.l 144(sp),a0
     e70:	lea 148(sp),a1
     e74:	lea 11de <KPutCharX>,a2
     e7a:	suba.l a3,a3
     e7c:	jsr -522(a6)
}
     e80:	movem.l (sp)+,a2-a3/a6
     e84:	lea 128(sp),sp
     e88:	rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
     e8a:	movea.l fe14 <SysBase>,a6
     e90:	movea.l 144(sp),a0
     e94:	lea 148(sp),a1
     e98:	lea 11ec <PutChar>,a2
     e9e:	lea 12(sp),a3
     ea2:	jsr -522(a6)
		UaeDbgLog(86, temp);
     ea6:	move.l a3,-(sp)
     ea8:	pea 56 <_start+0x56>
     eac:	jsr f0ff60 <_end+0xf00140>
     eb2:	addq.l #8,sp
}
     eb4:	movem.l (sp)+,a2-a3/a6
     eb8:	lea 128(sp),sp
     ebc:	rts

00000ebe <strlen>:
unsigned long strlen(const char* s) {
     ebe:	movea.l 4(sp),a0
	unsigned long t=0;
     ec2:	moveq #0,d0
	while(*s++)
     ec4:	tst.b (a0)
     ec6:	beq.s ed0 <strlen+0x12>
		t++;
     ec8:	addq.l #1,d0
	while(*s++)
     eca:	tst.b (0,a0,d0.l)
     ece:	bne.s ec8 <strlen+0xa>
}
     ed0:	rts

00000ed2 <memset>:
	void* memset(void *dest, int val, unsigned long len) {
     ed2:	movem.l d2-d7/a2-a3,-(sp)
     ed6:	move.l 36(sp),d0
     eda:	move.l 40(sp),d4
     ede:	movea.l 44(sp),a1
	while(len-- > 0)
     ee2:	move.l a1,d5
     ee4:	subq.l #1,d5
     ee6:	cmpa.w #0,a1
     eea:	beq.w f9a <memset+0xc8>
		*ptr++ = val;
     eee:	move.b d4,d7
     ef0:	move.l d0,d1
     ef2:	neg.l d1
     ef4:	moveq #3,d2
     ef6:	and.l d2,d1
     ef8:	moveq #5,d6
     efa:	movea.l d0,a2
     efc:	cmp.l d5,d6
     efe:	bcc.s f6a <memset+0x98>
     f00:	tst.l d1
     f02:	beq.s f28 <memset+0x56>
     f04:	move.b d4,(a2)+
	while(len-- > 0)
     f06:	subq.l #1,d5
     f08:	moveq #1,d2
     f0a:	cmp.l d1,d2
     f0c:	beq.s f28 <memset+0x56>
		*ptr++ = val;
     f0e:	movea.l d0,a2
     f10:	addq.l #2,a2
     f12:	movea.l d0,a0
     f14:	move.b d4,1(a0)
	while(len-- > 0)
     f18:	subq.l #1,d5
     f1a:	moveq #3,d2
     f1c:	cmp.l d1,d2
     f1e:	bne.s f28 <memset+0x56>
		*ptr++ = val;
     f20:	addq.l #1,a2
     f22:	move.b d4,2(a0)
	while(len-- > 0)
     f26:	subq.l #1,d5
     f28:	move.l a1,d3
     f2a:	sub.l d1,d3
     f2c:	moveq #0,d6
     f2e:	move.b d4,d6
     f30:	move.l d6,d2
     f32:	swap d2
     f34:	clr.w d2
     f36:	movea.l d2,a0
     f38:	move.l d4,d2
     f3a:	lsl.w #8,d2
     f3c:	swap d2
     f3e:	clr.w d2
     f40:	lsl.l #8,d6
     f42:	movea.l d6,a3
     f44:	move.l a0,d6
     f46:	or.l d6,d2
     f48:	move.l a3,d6
     f4a:	or.l d6,d2
     f4c:	move.b d7,d2
     f4e:	movea.l d0,a0
     f50:	adda.l d1,a0
     f52:	moveq #-4,d1
     f54:	and.l d3,d1
     f56:	add.l a0,d1
		*ptr++ = val;
     f58:	move.l d2,(a0)+
	while(len-- > 0)
     f5a:	cmpa.l d1,a0
     f5c:	bne.s f58 <memset+0x86>
     f5e:	moveq #-4,d1
     f60:	and.l d3,d1
     f62:	adda.l d1,a2
     f64:	sub.l d1,d5
     f66:	cmp.l d3,d1
     f68:	beq.s f9a <memset+0xc8>
		*ptr++ = val;
     f6a:	move.b d4,(a2)
	while(len-- > 0)
     f6c:	tst.l d5
     f6e:	beq.s f9a <memset+0xc8>
		*ptr++ = val;
     f70:	move.b d4,1(a2)
	while(len-- > 0)
     f74:	moveq #1,d1
     f76:	cmp.l d5,d1
     f78:	beq.s f9a <memset+0xc8>
		*ptr++ = val;
     f7a:	move.b d4,2(a2)
	while(len-- > 0)
     f7e:	moveq #2,d2
     f80:	cmp.l d5,d2
     f82:	beq.s f9a <memset+0xc8>
		*ptr++ = val;
     f84:	move.b d4,3(a2)
	while(len-- > 0)
     f88:	moveq #3,d6
     f8a:	cmp.l d5,d6
     f8c:	beq.s f9a <memset+0xc8>
		*ptr++ = val;
     f8e:	move.b d4,4(a2)
	while(len-- > 0)
     f92:	subq.l #4,d5
     f94:	beq.s f9a <memset+0xc8>
		*ptr++ = val;
     f96:	move.b d4,5(a2)
}
     f9a:	movem.l (sp)+,d2-d7/a2-a3
     f9e:	rts

00000fa0 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
     fa0:	movem.l d2-d6,-(sp)
     fa4:	move.l 24(sp),d0
     fa8:	move.l 28(sp),d1
     fac:	move.l 32(sp),d3
	while(len--)
     fb0:	move.l d3,d4
     fb2:	subq.l #1,d4
     fb4:	tst.l d3
     fb6:	beq.s 1016 <memcpy+0x76>
     fb8:	movea.l d1,a0
     fba:	addq.l #1,a0
     fbc:	move.l d0,d2
     fbe:	sub.l a0,d2
     fc0:	moveq #2,d5
     fc2:	cmp.l d2,d5
     fc4:	sc.s d2
     fc6:	neg.b d2
     fc8:	moveq #8,d6
     fca:	cmp.l d4,d6
     fcc:	sc.s d5
     fce:	neg.b d5
     fd0:	and.b d5,d2
     fd2:	beq.s 101c <memcpy+0x7c>
     fd4:	move.l d0,d2
     fd6:	or.l d1,d2
     fd8:	moveq #3,d5
     fda:	and.l d5,d2
     fdc:	bne.s 101c <memcpy+0x7c>
     fde:	movea.l d1,a0
     fe0:	movea.l d0,a1
     fe2:	moveq #-4,d2
     fe4:	and.l d3,d2
     fe6:	add.l d1,d2
		*d++ = *s++;
     fe8:	move.l (a0)+,(a1)+
	while(len--)
     fea:	cmp.l a0,d2
     fec:	bne.s fe8 <memcpy+0x48>
     fee:	moveq #-4,d2
     ff0:	and.l d3,d2
     ff2:	movea.l d0,a0
     ff4:	adda.l d2,a0
     ff6:	add.l d2,d1
     ff8:	sub.l d2,d4
     ffa:	cmp.l d3,d2
     ffc:	beq.s 1016 <memcpy+0x76>
		*d++ = *s++;
     ffe:	movea.l d1,a1
    1000:	move.b (a1),(a0)
	while(len--)
    1002:	tst.l d4
    1004:	beq.s 1016 <memcpy+0x76>
		*d++ = *s++;
    1006:	move.b 1(a1),1(a0)
	while(len--)
    100c:	subq.l #1,d4
    100e:	beq.s 1016 <memcpy+0x76>
		*d++ = *s++;
    1010:	move.b 2(a1),2(a0)
}
    1016:	movem.l (sp)+,d2-d6
    101a:	rts
    101c:	movea.l d0,a1
    101e:	add.l d3,d1
		*d++ = *s++;
    1020:	move.b -1(a0),(a1)+
	while(len--)
    1024:	cmp.l a0,d1
    1026:	beq.s 1016 <memcpy+0x76>
    1028:	addq.l #1,a0
    102a:	bra.s 1020 <memcpy+0x80>

0000102c <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    102c:	movem.l d2-d5/a2,-(sp)
    1030:	move.l 24(sp),d0
    1034:	move.l 28(sp),d1
    1038:	move.l 32(sp),d2
		while (len--)
    103c:	movea.l d2,a1
    103e:	subq.l #1,a1
	if (d < s) {
    1040:	cmp.l d0,d1
    1042:	bls.s 10b0 <memmove+0x84>
		while (len--)
    1044:	tst.l d2
    1046:	beq.s 10aa <memmove+0x7e>
    1048:	movea.l d1,a2
    104a:	addq.l #1,a2
    104c:	move.l d0,d3
    104e:	sub.l a2,d3
    1050:	moveq #2,d4
    1052:	cmp.l d3,d4
    1054:	sc.s d3
    1056:	neg.b d3
    1058:	moveq #8,d5
    105a:	cmp.l a1,d5
    105c:	sc.s d4
    105e:	neg.b d4
    1060:	and.b d4,d3
    1062:	beq.s 10d4 <memmove+0xa8>
    1064:	move.l d0,d3
    1066:	or.l d1,d3
    1068:	moveq #3,d4
    106a:	and.l d4,d3
    106c:	bne.s 10d4 <memmove+0xa8>
    106e:	movea.l d1,a0
    1070:	movea.l d0,a2
    1072:	moveq #-4,d3
    1074:	and.l d2,d3
    1076:	add.l d1,d3
			*d++ = *s++;
    1078:	move.l (a0)+,(a2)+
		while (len--)
    107a:	cmp.l a0,d3
    107c:	bne.s 1078 <memmove+0x4c>
    107e:	moveq #-4,d3
    1080:	and.l d2,d3
    1082:	movea.l d0,a2
    1084:	adda.l d3,a2
    1086:	movea.l d1,a0
    1088:	adda.l d3,a0
    108a:	suba.l d3,a1
    108c:	cmp.l d2,d3
    108e:	beq.s 10aa <memmove+0x7e>
			*d++ = *s++;
    1090:	move.b (a0),(a2)
		while (len--)
    1092:	cmpa.w #0,a1
    1096:	beq.s 10aa <memmove+0x7e>
			*d++ = *s++;
    1098:	move.b 1(a0),1(a2)
		while (len--)
    109e:	moveq #1,d5
    10a0:	cmp.l a1,d5
    10a2:	beq.s 10aa <memmove+0x7e>
			*d++ = *s++;
    10a4:	move.b 2(a0),2(a2)
}
    10aa:	movem.l (sp)+,d2-d5/a2
    10ae:	rts
		const char *lasts = s + (len - 1);
    10b0:	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    10b4:	adda.l d0,a1
		while (len--)
    10b6:	tst.l d2
    10b8:	beq.s 10aa <memmove+0x7e>
    10ba:	move.l a0,d1
    10bc:	sub.l d2,d1
			*lastd-- = *lasts--;
    10be:	move.b (a0),(a1)
		while (len--)
    10c0:	subq.l #1,a0
    10c2:	subq.l #1,a1
    10c4:	cmp.l a0,d1
    10c6:	beq.s 10aa <memmove+0x7e>
			*lastd-- = *lasts--;
    10c8:	move.b (a0),(a1)
		while (len--)
    10ca:	subq.l #1,a0
    10cc:	subq.l #1,a1
    10ce:	cmp.l a0,d1
    10d0:	bne.s 10be <memmove+0x92>
    10d2:	bra.s 10aa <memmove+0x7e>
    10d4:	movea.l d0,a1
    10d6:	add.l d2,d1
			*d++ = *s++;
    10d8:	move.b -1(a2),(a1)+
		while (len--)
    10dc:	cmp.l a2,d1
    10de:	beq.s 10aa <memmove+0x7e>
    10e0:	addq.l #1,a2
    10e2:	bra.s 10d8 <memmove+0xac>

000010e4 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    10e4:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    10e8:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    10ec:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    10f0:	mulu.w 8(sp),d1
	addw	d1, d0
    10f4:	add.w d1,d0
	swap	d0
    10f6:	swap d0
	clrw	d0
    10f8:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    10fa:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    10fe:	mulu.w 10(sp),d1
	addl	d1, d0
    1102:	add.l d1,d0
	rts
    1104:	rts

00001106 <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    1106:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    1108:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    110c:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    1110:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    1116:	bcc.s 112e <__udivsi3+0x28>
	movel	d0, d2
    1118:	move.l d0,d2
	clrw	d2
    111a:	clr.w d2
	swap	d2
    111c:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    111e:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    1120:	move.w d2,d0
	swap	d0
    1122:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    1124:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    1128:	divu.w d1,d2
	movew	d2, d0
    112a:	move.w d2,d0
	jra	6f
    112c:	bra.s 115e <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    112e:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    1130:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    1132:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    1134:	cmpi.l #65536,d1
	jcc	4b
    113a:	bcc.s 1130 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    113c:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    113e:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    1144:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    1146:	mulu.w d0,d1
	swap	d2
    1148:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    114a:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    114c:	swap d2
	tstw	d2		/* high part 17 bits? */
    114e:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    1150:	bne.s 115c <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    1152:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    1154:	bcs.s 115c <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    1156:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    115a:	bls.s 115e <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    115c:	subq.l #1,d0

6:	movel	sp@+, d2
    115e:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    1160:	rts

00001162 <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    1162:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    1164:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    1166:	move.l 12(sp),d1
	jpl	1f
    116a:	bpl.s 1170 <__divsi3+0xe>
	negl	d1
    116c:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    116e:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    1170:	move.l 8(sp),d0
	jpl	2f
    1174:	bpl.s 117a <__divsi3+0x18>
	negl	d0
    1176:	neg.l d0
	negb	d2
    1178:	neg.b d2

2:	movel	d1, sp@-
    117a:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    117c:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    117e:	bsr.s 1106 <__udivsi3>
	addql	#8, sp
    1180:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    1182:	tst.b d2
	jpl	3f
    1184:	bpl.s 1188 <__divsi3+0x26>
	negl	d0
    1186:	neg.l d0

3:	movel	sp@+, d2
    1188:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    118a:	rts

0000118c <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    118c:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    1190:	move.l 4(sp),d0
	movel	d1, sp@-
    1194:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    1196:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    1198:	bsr.s 1162 <__divsi3>
	addql	#8, sp
    119a:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    119c:	move.l 8(sp),d1
	movel	d1, sp@-
    11a0:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    11a2:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    11a4:	bsr.w 10e4 <__mulsi3>
	addql	#8, sp
    11a8:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    11aa:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    11ae:	sub.l d0,d1
	movel	d1, d0
    11b0:	move.l d1,d0
	rts
    11b2:	rts

000011b4 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    11b4:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    11b8:	move.l 4(sp),d0
	movel	d1, sp@-
    11bc:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    11be:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    11c0:	bsr.w 1106 <__udivsi3>
	addql	#8, sp
    11c4:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    11c6:	move.l 8(sp),d1
	movel	d1, sp@-
    11ca:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    11cc:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    11ce:	bsr.w 10e4 <__mulsi3>
	addql	#8, sp
    11d2:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    11d4:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    11d8:	sub.l d0,d1
	movel	d1, d0
    11da:	move.l d1,d0
	rts
    11dc:	rts

000011de <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    11de:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    11e0:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    11e4:	jsr -516(a6)
    move.l (sp)+, a6
    11e8:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    11ea:	rts

000011ec <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    11ec:	move.b d0,(a3)+
	rts
    11ee:	rts

000011f0 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    11f0:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    11f2:	adda.l a0,a2
	move.l	a2,a3
    11f4:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    11f6:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    11f8:	moveq #56,d4
	moveq	#8,d5
    11fa:	moveq #8,d5
	bra.s	.Lliteral
    11fc:	bra.s 1266 <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    11fe:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    1200:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    1202:	dbf d1,11fe <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    1206:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    1208:	bcc.s 120c <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    120a:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    120c:	tst.w d0
    120e:	bne.s 1218 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    1210:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    1212:	bls.s 128a <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    1214:	move.w (a0)+,d0
    1216:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    1218:	rol.l #6,d0
	move.w	d0,d1
    121a:	move.w d0,d1
	and.w	d4,d1
    121c:	and.w d4,d1
	eor.w	d1,d0
    121e:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    1220:	movem.w (1284 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    1226:	rol.l d2,d0
	and.w	d0,d3					|scaling
    1228:	and.w d0,d3
	eor.w	d3,d0
    122a:	eor.w d3,d0
	suba.w	d3,a4
    122c:	suba.w d3,a4
	adda.l	a1,a4
    122e:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    1230:	tst.w d0
    1232:	bne.s 1238 <_doynaxdepack_asm+0x48>
    1234:	move.w (a0)+,d0
    1236:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    1238:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    123a:	beq.s 1252 <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    123c:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    123e:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    1240:	bpl.s 124e <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    1242:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    1244:	bpl.s 124c <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    1246:	addx.b d1,d1
	lsl.l	#2,d0
    1248:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    124a:	bmi.s 1246 <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    124c:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    124e:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    1250:	bcc.s 1254 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    1252:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    1254:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    1256:	dbf d1,1252 <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    125a:	add.l d0,d0
	bcc.s	.Lmatch
    125c:	bcc.s 120c <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    125e:	tst.w d0
    1260:	bne.s 1266 <_doynaxdepack_asm+0x76>
    1262:	move.w (a0)+,d0
    1264:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    1266:	moveq #0,d1
	add.l	d0,d0
    1268:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    126a:	bcc.s 120a <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    126c:	bpl.s 1274 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    126e:	addx.b d1,d1
	lsl.l	#2,d0
    1270:	lsl.l #2,d0
	bmi.s	.Llgetlen
    1272:	bmi.s 126e <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    1274:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    1276:	dbv.s d1,11fe <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    127a:	add.l d0,d0
	eor.w	d1,d0		
    127c:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    127e:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    1280:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    1282:	bra.s 1276 <_doynaxdepack_asm+0x86>

00001284 <doy_table>:
    1284:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    1294:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    12a4:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    12b4:	.............o
