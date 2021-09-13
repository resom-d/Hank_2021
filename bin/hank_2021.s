
bin/hank_2021.elf:     file format elf32-m68k


Disassembly of section .text:

00000000 <_start>:
extern void (*__init_array_start[])() __attribute__((weak));
extern void (*__init_array_end[])() __attribute__((weak));
extern void (*__fini_array_start[])() __attribute__((weak));
extern void (*__fini_array_end[])() __attribute__((weak));

__attribute__((used)) __attribute__((section(".text.unlikely"))) void _start() {
       0:	move.l d3,-(sp)
       2:	move.l d2,-(sp)
	// initialize globals, ctors etc.
	unsigned long count;
	unsigned long i;

	count = __preinit_array_end - __preinit_array_start;
       4:	move.l #27220,d3
       a:	subi.l #27220,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	moveq #0,d2
      14:	bra.s 2a <_start+0x2a>
		__preinit_array_start[i]();
      16:	move.l d2,d0
      18:	add.l d2,d0
      1a:	add.l d0,d0
      1c:	lea 6a54 <NextPlot>,a0
      22:	movea.l (0,a0,d0.l),a0
      26:	jsr (a0)
	for (i = 0; i < count; i++)
      28:	addq.l #1,d2
      2a:	cmp.l d2,d3
      2c:	bhi.s 16 <_start+0x16>

	count = __init_array_end - __init_array_start;
      2e:	move.l #27220,d3
      34:	subi.l #27220,d3
      3a:	asr.l #2,d3
	for (i = 0; i < count; i++)
      3c:	moveq #0,d2
      3e:	bra.s 54 <_start+0x54>
		__init_array_start[i]();
      40:	move.l d2,d0
      42:	add.l d2,d0
      44:	add.l d0,d0
      46:	lea 6a54 <NextPlot>,a0
      4c:	movea.l (0,a0,d0.l),a0
      50:	jsr (a0)
	for (i = 0; i < count; i++)
      52:	addq.l #1,d2
      54:	cmp.l d2,d3
      56:	bhi.s 40 <_start+0x40>

	main();
      58:	jsr 2314 <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
      5e:	move.l #27220,d2
      64:	subi.l #27220,d2
      6a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      6c:	bra.s 82 <_start+0x82>
		__fini_array_start[i - 1]();
      6e:	subq.l #1,d2
      70:	move.l d2,d0
      72:	add.l d2,d0
      74:	add.l d0,d0
      76:	lea 6a54 <NextPlot>,a0
      7c:	movea.l (0,a0,d0.l),a0
      80:	jsr (a0)
	for (i = count; i > 0; i--)
      82:	tst.l d2
      84:	bne.s 6e <_start+0x6e>
}
      86:	move.l (sp)+,d2
      88:	move.l (sp)+,d3
      8a:	rts

0000008c <MoveBobs>:
		//custom->color[0] = 0xf00;
	}
}

void MoveBobs()
{
      8c:	move.l d3,-(sp)
      8e:	move.l d2,-(sp)
	switch (BobPhase)
      90:	move.w 2492c <BobPhase>,d0
      96:	beq.s 104 <MoveBobs+0x78>
      98:	cmpi.w #1,d0
      9c:	beq.w 1d8 <MoveBobs+0x14c>
			BobPhase = 0;
			*copPF1BmpP = 1 << 6; // prio. in bplcon2: pf2 >> pf 1 >> sprites
		}
		break;
	}
}
      a0:	move.l (sp)+,d2
      a2:	move.l (sp)+,d3
      a4:	rts
				BobTarget[b].X += BobVecs[b].X;
      a6:	lea 6a5a <BobVecs>,a1
      ac:	move.l d0,d3
      ae:	lsl.l #3,d3
      b0:	movea.l d3,a0
      b2:	add.l (0,a1,d3.l),d1
      b6:	lea 6a9a <BobTarget>,a1
      bc:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X > 320+32)
      c0:	cmpi.l #352,d1
      c6:	ble.s d0 <MoveBobs+0x44>
					BobTarget[b].X = 320+32;
      c8:	move.l #352,(0,a1,d3.l)
{
      d0:	move.l d2,d0
		for (int b = 0; b < BOBSN - 1; b++)
      d2:	moveq #6,d1
      d4:	cmp.l d0,d1
      d6:	blt.s 108 <MoveBobs+0x7c>
			if ((BobTarget[b + 1].X - BobTarget[b].X) > 34 || BobTarget[b + 1].X >= 320+32)
      d8:	move.l d0,d2
      da:	addq.l #1,d2
      dc:	lea 6a9a <BobTarget>,a0
      e2:	move.l d2,d1
      e4:	lsl.l #3,d1
      e6:	movea.l (0,a0,d1.l),a1
      ea:	move.l d0,d1
      ec:	lsl.l #3,d1
      ee:	move.l (0,a0,d1.l),d1
      f2:	movea.l a1,a0
      f4:	suba.l d1,a0
      f6:	moveq #34,d3
      f8:	cmp.l a0,d3
      fa:	blt.s a6 <MoveBobs+0x1a>
      fc:	cmpa.w #351,a1
     100:	ble.s d0 <MoveBobs+0x44>
     102:	bra.s a6 <MoveBobs+0x1a>
	switch (BobPhase)
     104:	moveq #0,d0
     106:	bra.s d2 <MoveBobs+0x46>
		BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
     108:	move.l 6a92 <BobVecs+0x38>,d1
     10e:	move.l d1,d0
     110:	add.l 6ad2 <BobTarget+0x38>,d0
     116:	move.l d0,6ad2 <BobTarget+0x38>
		if (BobTarget[BOBSN - 1].X > 320+32)
     11c:	cmpi.l #352,d0
     122:	ble.s 12e <MoveBobs+0xa2>
			BobTarget[BOBSN - 1].X = 320+32;
     124:	move.l #352,6ad2 <BobTarget+0x38>
		if (BobTarget[0].X >= 320+32)
     12e:	cmpi.l #351,6a9a <BobTarget>
     138:	ble.w a0 <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     13c:	neg.l 6a5a <BobVecs>
			BobVecs[1].X *= -1;
     142:	neg.l 6a62 <BobVecs+0x8>
			BobVecs[2].X *= -1;
     148:	neg.l 6a6a <BobVecs+0x10>
			BobVecs[3].X *= -1;
     14e:	neg.l 6a72 <BobVecs+0x18>
			BobVecs[4].X *= -1;
     154:	neg.l 6a7a <BobVecs+0x20>
			BobVecs[5].X *= -1;
     15a:	neg.l 6a82 <BobVecs+0x28>
			BobVecs[6].X *= -1;
     160:	neg.l 6a8a <BobVecs+0x30>
			BobVecs[7].X *= -1;			
     166:	neg.l d1
     168:	move.l d1,6a92 <BobVecs+0x38>
			BobPhase = 1;
     16e:	move.w #1,2492c <BobPhase>
			*copPF1BmpP = 0 << 6; // prio. in bplcon2: pf1 >> pf 2 >> sprites
     176:	movea.l 24928 <copPF1BmpP>,a0
     17c:	clr.w (a0)
     17e:	bra.w a0 <MoveBobs+0x14>
				BobTarget[b].X += BobVecs[b].X;
     182:	lea 6a5a <BobVecs>,a1
     188:	move.l d0,d3
     18a:	lsl.l #3,d3
     18c:	movea.l d3,a0
     18e:	add.l (0,a1,d3.l),d1
     192:	lea 6a9a <BobTarget>,a1
     198:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X < 0)
     19c:	bmi.s 1d2 <MoveBobs+0x146>
	switch (BobPhase)
     19e:	move.l d2,d0
		for (int b = 0; b < BOBSN - 1; b++)
     1a0:	moveq #6,d1
     1a2:	cmp.l d0,d1
     1a4:	blt.s 1dc <MoveBobs+0x150>
			if ((BobTarget[b].X - BobTarget[b + 1].X) > 34 || BobTarget[b + 1].X <= 0)
     1a6:	lea 6a9a <BobTarget>,a0
     1ac:	move.l d0,d1
     1ae:	lsl.l #3,d1
     1b0:	move.l (0,a0,d1.l),d1
     1b4:	move.l d0,d2
     1b6:	addq.l #1,d2
     1b8:	move.l d2,d3
     1ba:	lsl.l #3,d3
     1bc:	movea.l (0,a0,d3.l),a0
     1c0:	movea.l d1,a1
     1c2:	suba.l a0,a1
     1c4:	moveq #34,d3
     1c6:	cmp.l a1,d3
     1c8:	blt.s 182 <MoveBobs+0xf6>
     1ca:	cmpa.w #0,a0
     1ce:	bgt.s 19e <MoveBobs+0x112>
     1d0:	bra.s 182 <MoveBobs+0xf6>
					BobTarget[b].X = 0;
     1d2:	clr.l (0,a1,d3.l)
     1d6:	bra.s 19e <MoveBobs+0x112>
	switch (BobPhase)
     1d8:	moveq #0,d0
     1da:	bra.s 1a0 <MoveBobs+0x114>
		BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
     1dc:	move.l 6a92 <BobVecs+0x38>,d1
     1e2:	move.l d1,d0
     1e4:	add.l 6ad2 <BobTarget+0x38>,d0
     1ea:	move.l d0,6ad2 <BobTarget+0x38>
		if (BobTarget[BOBSN - 1].X < 0)
     1f0:	bmi.s 242 <MoveBobs+0x1b6>
		if (BobTarget[0].X <= 0)
     1f2:	tst.l 6a9a <BobTarget>
     1f8:	bgt.w a0 <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     1fc:	neg.l 6a5a <BobVecs>
			BobVecs[1].X *= -1;
     202:	neg.l 6a62 <BobVecs+0x8>
			BobVecs[2].X *= -1;
     208:	neg.l 6a6a <BobVecs+0x10>
			BobVecs[3].X *= -1;
     20e:	neg.l 6a72 <BobVecs+0x18>
			BobVecs[4].X *= -1;
     214:	neg.l 6a7a <BobVecs+0x20>
			BobVecs[5].X *= -1;
     21a:	neg.l 6a82 <BobVecs+0x28>
			BobVecs[6].X *= -1;
     220:	neg.l 6a8a <BobVecs+0x30>
			BobVecs[7].X *= -1;
     226:	neg.l d1
     228:	move.l d1,6a92 <BobVecs+0x38>
			BobPhase = 0;
     22e:	clr.w 2492c <BobPhase>
			*copPF1BmpP = 1 << 6; // prio. in bplcon2: pf2 >> pf 1 >> sprites
     234:	movea.l 24928 <copPF1BmpP>,a0
     23a:	move.w #64,(a0)
     23e:	bra.w a0 <MoveBobs+0x14>
			BobTarget[BOBSN - 1].X = 0;
     242:	clr.l 6ad2 <BobTarget+0x38>
     248:	bra.s 1f2 <MoveBobs+0x166>

0000024a <SetupCopper>:

void SetupCopper(USHORT *copPtr)
{
     24a:	movem.l d2-d5/a2,-(sp)
     24e:	movea.l 24(sp),a1
	UBYTE line = 0x1c;
	// set screen output size
	*copPtr++ = DIWSTRT;
     252:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     256:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     25c:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     262:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     268:	move.w #146,8(a1)
	*copPtr++ = 0x38;
     26e:	move.w #56,10(a1)
	*copPtr++ = DDFSTOP;
     274:	move.w #148,12(a1)
	*copPtr++ = 0xd0;
     27a:	move.w #208,14(a1)
	// set pf1/2 modulos
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - Screen.Bpl, BmpUpperPart_PF2.Bplt - Screen.Bpl);
     280:	move.w 24ad4 <Screen+0x6>,d0
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     286:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     28c:	move.w 24a72 <BmpUpperPart_PF1+0x8>,d1
     292:	sub.w d0,d1
     294:	move.w d1,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     298:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     29e:	move.w 24a40 <BmpUpperPart_PF2+0x8>,d2
     2a4:	sub.w d0,d2
     2a6:	move.w d2,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     2aa:	move.w #258,24(a1)
	*copPtr++ = 0;
     2b0:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     2b4:	move.w #260,28(a1)
	copPF1BmpP = copPtr;
     2ba:	lea 30(a1),a0
     2be:	move.l a0,24928 <copPF1BmpP>
	*copPtr++ = 1 << 6; //pf2 >> pf 1 >> sprites
     2c4:	move.w #64,30(a1)
    *copListEnd++ = COP_SKIP;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2ca:	move.w #384,32(a1)
    *copListCurrent++ = color;
     2d0:	move.w #21,34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2d6:	move.w #398,36(a1)
    *copListCurrent++ = color;
     2dc:	lea 40(a1),a0
     2e0:	move.w #21,38(a1)
	// set logo colors
	copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[0]);
	copPtr = copSetColor(copPtr, 7, colgradbluePaletteRGB4[0]);
	for (int a = 1; a < 8; a++)
     2e6:	moveq #1,d0
     2e8:	bra.s 308 <SetupCopper+0xbe>
	{
		copPtr = copSetColor(copPtr, a, LogoPaletteRGB4[a]);
     2ea:	movea.l d0,a1
     2ec:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2ee:	move.w d0,d1
     2f0:	addi.w #192,d1
     2f4:	add.w d1,d1
     2f6:	move.w d1,(a0)
    *copListCurrent++ = color;
     2f8:	lea 49b4 <LogoPaletteRGB4>,a2
     2fe:	move.w (0,a2,a1.l),2(a0)
	for (int a = 1; a < 8; a++)
     304:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, LogoPaletteRGB4[a]);
     306:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     308:	moveq #7,d1
     30a:	cmp.l d0,d1
     30c:	bge.s 2ea <SetupCopper+0xa0>
	}
	for (int a = 8; a < 16; a++)
     30e:	moveq #8,d0
     310:	bra.s 332 <SetupCopper+0xe8>
	{
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     312:	move.l d0,d1
     314:	subq.l #8,d1
     316:	add.l d1,d1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     318:	movea.w d0,a1
     31a:	lea 192(a1),a1
     31e:	adda.w a1,a1
     320:	move.w a1,(a0)
    *copListCurrent++ = color;
     322:	lea 49a4 <CookiePaletteRGB4>,a1
     328:	move.w (0,a1,d1.l),2(a0)
	for (int a = 8; a < 16; a++)
     32e:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     330:	addq.l #4,a0
	for (int a = 8; a < 16; a++)
     332:	moveq #15,d2
     334:	cmp.l d0,d2
     336:	bge.s 312 <SetupCopper+0xc8>
	}
	// set upper part, pf1, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.Planes[0], BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
     338:	moveq #0,d5
     33a:	move.w 24a70 <BmpUpperPart_PF1+0x6>,d5
     340:	moveq #0,d4
     342:	move.w 24a6e <BmpUpperPart_PF1+0x4>,d4
     348:	move.l 24a7c <BmpUpperPart_PF1+0x12>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     34e:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     350:	clr.b d2
     352:	bra.s 380 <SetupCopper+0x136>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     354:	move.b d2,d0
     356:	ext.w d0
     358:	movea.w d0,a1
     35a:	moveq #56,d0
     35c:	add.l a1,d0
     35e:	add.w d0,d0
     360:	add.w d0,d0
     362:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     364:	move.l d1,d3
     366:	clr.w d3
     368:	swap d3
     36a:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     36e:	addq.w #2,d0
     370:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     374:	move.w d1,6(a0)
        addr += Bpl;
     378:	add.l d5,d1
        plane += 2;
     37a:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     37c:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     37e:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     380:	moveq #0,d0
     382:	move.w a2,d0
     384:	cmp.l d4,d0
     386:	blt.s 354 <SetupCopper+0x10a>
	// set upper part, pf2, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.Planes[0], BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
     388:	moveq #0,d5
     38a:	move.w 24a3e <BmpUpperPart_PF2+0x6>,d5
     390:	moveq #0,d4
     392:	move.w 24a3c <BmpUpperPart_PF2+0x4>,d4
     398:	move.l 24a4a <BmpUpperPart_PF2+0x12>,d1
     39e:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     3a0:	moveq #1,d2
     3a2:	bra.s 3d0 <SetupCopper+0x186>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     3a4:	move.b d2,d0
     3a6:	ext.w d0
     3a8:	movea.w d0,a1
     3aa:	moveq #56,d0
     3ac:	add.l a1,d0
     3ae:	add.w d0,d0
     3b0:	add.w d0,d0
     3b2:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     3b4:	move.l d1,d3
     3b6:	clr.w d3
     3b8:	swap d3
     3ba:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     3be:	addq.w #2,d0
     3c0:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3c4:	move.w d1,6(a0)
        addr += Bpl;
     3c8:	add.l d5,d1
        plane += 2;
     3ca:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     3cc:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3ce:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     3d0:	moveq #0,d0
     3d2:	move.w a2,d0
     3d4:	cmp.l d4,d0
     3d6:	blt.s 3a4 <SetupCopper+0x15a>
	// set sprite pointers
	*copPtr++ = SPR0PTH;
     3d8:	move.w #288,(a0)
	*copPtr++ = (LONG)StarSprite >> 16;
     3dc:	move.l #149022,d0
     3e2:	move.l d0,d1
     3e4:	swap d1
     3e6:	ext.l d1
     3e8:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
     3ec:	move.w #290,4(a0)
	*copPtr++ = (LONG)StarSprite;
     3f2:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
     3f6:	move.w #292,8(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     3fc:	move.l #149010,d0
     402:	move.l d0,d1
     404:	swap d1
     406:	ext.l d1
     408:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
     40c:	move.w #294,12(a0)
	*copPtr++ = (LONG)NullSprite;
     412:	move.w d0,14(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     416:	move.w #418,16(a0)
    *copListCurrent++ = color;
     41c:	move.w #3234,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     422:	move.w #420,20(a0)
    *copListCurrent++ = color;
     428:	move.w #3276,22(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     42e:	move.w #422,24(a0)
    *copListCurrent++ = color;
     434:	move.w #4095,26(a0)
	// sprite 0+1 colors
	copPtr = copSetColor(copPtr, 17, 0xca2);
	copPtr = copSetColor(copPtr, 18, 0xccc);
	copPtr = copSetColor(copPtr, 19, 0xfff);
	*copPtr++ = SPR2PTH;
     43a:	move.w #296,28(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     440:	move.w d1,30(a0)
	*copPtr++ = SPR2PTL;
     444:	move.w #298,32(a0)
	*copPtr++ = (LONG)NullSprite;
     44a:	move.w d0,34(a0)
	*copPtr++ = SPR3PTH;
     44e:	move.w #300,36(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     454:	move.w d1,38(a0)
	*copPtr++ = SPR3PTL;
     458:	move.w #302,40(a0)
	*copPtr++ = (LONG)NullSprite;
     45e:	move.w d0,42(a0)
	*copPtr++ = SPR4PTH;
     462:	move.w #304,44(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     468:	move.w d1,46(a0)
	*copPtr++ = SPR4PTL;
     46c:	move.w #306,48(a0)
	*copPtr++ = (LONG)NullSprite;
     472:	move.w d0,50(a0)
	*copPtr++ = SPR5PTH;
     476:	move.w #308,52(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     47c:	move.w d1,54(a0)
	*copPtr++ = SPR5PTL;
     480:	move.w #310,56(a0)
	*copPtr++ = (LONG)NullSprite;
     486:	move.w d0,58(a0)
	*copPtr++ = SPR6PTH;
     48a:	move.w #312,60(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     490:	move.w d1,62(a0)
	*copPtr++ = SPR6PTL;
     494:	move.w #314,64(a0)
	*copPtr++ = (LONG)NullSprite;
     49a:	move.w d0,66(a0)
	*copPtr++ = SPR7PTH;
     49e:	move.w #316,68(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     4a4:	move.w d1,70(a0)
	*copPtr++ = SPR7PTL;
     4a8:	move.w #318,72(a0)
	*copPtr++ = (LONG)NullSprite;
     4ae:	move.w d0,74(a0)
	// enable bitplanes
	*copPtr++ = BPLCON0;
     4b2:	move.w #256,76(a0)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     4b8:	moveq #0,d0
     4ba:	move.w 24aa0 <BmpLogo+0x4>,d0
     4c0:	add.l d0,d0
     4c2:	moveq #12,d3
     4c4:	lsl.l d3,d0
     4c6:	ori.w #1536,d0
     4ca:	move.w d0,78(a0)
	// wait till below logo
	line = 0x2c + BmpUpperPart_PF1.Height;
     4ce:	move.b 24a6d <BmpUpperPart_PF1+0x3>,d0
     4d4:	addi.b #44,d0
	copPtr = copWaitY(copPtr, line++);
     4d8:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     4de:	lsl.l #8,d0
     4e0:	ori.w #5,d0
     4e4:	move.w d0,80(a0)
    *copListEnd++ = COP_WAIT;
     4e8:	move.w #-2,82(a0)
	// turn off bitplanes to waste 8 lines, giving the logo more bottom space
	// turn off bitplanes to waste 8 lines, giving the logo more bottom space
	*copPtr++ = BPLCON0;
     4ee:	move.w #256,84(a0)
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     4f4:	move.w #512,86(a0)
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
     4fa:	move.b 24a6d <BmpUpperPart_PF1+0x3>,d0
     500:	addi.b #52,d0
	copPtr = copWaitY(copPtr, line++);
     504:	move.b 24a6d <BmpUpperPart_PF1+0x3>,d1
     50a:	addi.b #53,d1
     50e:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     514:	lsl.l #8,d0
     516:	ori.w #5,d0
     51a:	move.w d0,88(a0)
    *copListEnd++ = COP_WAIT;
     51e:	lea 92(a0),a1
     522:	move.w #-2,90(a0)
	// set bitplane pointers
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     528:	move.l a1,2492e <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     52e:	moveq #0,d5
     530:	move.w 249da <BmpScroller+0x6>,d5
     536:	moveq #0,d4
     538:	move.w 249d8 <BmpScroller+0x4>,d4
     53e:	move.l 249e2 <BmpScroller+0xe>,d2
    for (USHORT i = 0; i < numPlanes; i++)
     544:	suba.l a0,a0
     546:	bra.s 56c <SetupCopper+0x322>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     548:	moveq #56,d3
     54a:	add.l d3,d0
     54c:	add.w d0,d0
     54e:	add.w d0,d0
     550:	move.w d0,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     552:	move.l d2,d3
     554:	clr.w d3
     556:	swap d3
     558:	move.w d3,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     55c:	addq.w #2,d0
     55e:	move.w d0,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     562:	move.w d2,6(a1)
        addr += Bpl;
     566:	add.l d5,d2
    for (USHORT i = 0; i < numPlanes; i++)
     568:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
     56a:	addq.l #8,a1
    for (USHORT i = 0; i < numPlanes; i++)
     56c:	moveq #0,d0
     56e:	move.w a0,d0
     570:	cmp.l d4,d0
     572:	blt.s 548 <SetupCopper+0x2fe>
	//set modulo for scroller
	copPtr = copSetBplMod(0, copPtr,
						  BmpScroller.Bplt - Screen.Bpl,
						  BmpScroller.Bplt - Screen.Bpl);
     574:	move.w 249dc <BmpScroller+0x8>,d0
     57a:	sub.w 24ad4 <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     580:	move.w #264,(a1)
    *copListEnd++ = modOdd;
     584:	move.w d0,2(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     588:	move.w #266,4(a1)
    *copListEnd++ = modEven;
     58e:	move.w d0,6(a1)
	*copPtr++ = BPLCON0;
     592:	move.w #256,8(a1)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     598:	moveq #0,d0
     59a:	move.w 24aa0 <BmpLogo+0x4>,d0
     5a0:	moveq #12,d2
     5a2:	lsl.l d2,d0
     5a4:	lea 12(a1),a0
     5a8:	ori.w #512,d0
     5ac:	move.w d0,10(a1)
	// set font colors for scroller
	for (int a = 1; a < 8; a++)
     5b0:	moveq #1,d0
     5b2:	bra.s 5d2 <SetupCopper+0x388>
	{
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     5b4:	move.l d0,d2
     5b6:	add.l d0,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5b8:	movea.w d0,a1
     5ba:	lea 192(a1),a1
     5be:	adda.w a1,a1
     5c0:	move.w a1,(a0)
    *copListCurrent++ = color;
     5c2:	lea 4994 <FontPaletteRGB4>,a1
     5c8:	move.w (0,a1,d2.l),2(a0)
	for (int a = 1; a < 8; a++)
     5ce:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     5d0:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     5d2:	moveq #7,d3
     5d4:	cmp.l d0,d3
     5d6:	bge.s 5b4 <SetupCopper+0x36a>
	}
	// blue gradient below logo
	for (int l = 0; l < 24; l++)
     5d8:	moveq #0,d0
     5da:	bra.s 60a <SetupCopper+0x3c0>
	{
		copPtr = copWaitY(copPtr, line);
     5dc:	moveq #0,d2
     5de:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     5e0:	lsl.l #8,d2
     5e2:	ori.w #5,d2
     5e6:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     5e8:	move.w #-2,2(a0)
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     5ee:	movea.l d0,a1
     5f0:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5f2:	move.w #384,4(a0)
    *copListCurrent++ = color;
     5f8:	lea 49c4 <colgradbluePaletteRGB4>,a2
     5fe:	move.w (0,a2,a1.l),6(a0)
		line += 2;
     604:	addq.b #2,d1
	for (int l = 0; l < 24; l++)
     606:	addq.l #1,d0
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     608:	addq.l #8,a0
	for (int l = 0; l < 24; l++)
     60a:	moveq #23,d2
     60c:	cmp.l d0,d2
     60e:	bge.s 5dc <SetupCopper+0x392>
	}
	copPtr = copWaitY(copPtr, line++);
     610:	move.b d1,d0
     612:	addq.b #1,d0
     614:	moveq #0,d2
     616:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     618:	lsl.l #8,d2
     61a:	ori.w #5,d2
     61e:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     620:	move.w #-2,2(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
     626:	movea.w 6a56 <colScrollMirror>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     62c:	move.w #384,4(a0)
    *copListCurrent++ = color;
     632:	move.w a1,6(a0)
	copPtr = copWaitY(copPtr, line++);
     636:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     63c:	lsl.l #8,d0
     63e:	ori.w #5,d0
     642:	move.w d0,8(a0)
    *copListEnd++ = COP_WAIT;
     646:	move.w #-2,10(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
     64c:	move.w 6a58 <colScrollMirror+0x2>,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     652:	move.w #384,12(a0)
    *copListCurrent++ = color;
     658:	move.w d2,14(a0)
	line += 7;
     65c:	move.b d1,d0
     65e:	addi.b #9,d0
	copPtr = copWaitY(copPtr, line++);
     662:	addi.b #10,d1
     666:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     66c:	lsl.l #8,d0
     66e:	ori.w #5,d0
     672:	move.w d0,16(a0)
    *copListEnd++ = COP_WAIT;
     676:	move.w #-2,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     67c:	move.w #384,20(a0)
    *copListCurrent++ = color;
     682:	move.w a1,22(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
     686:	andi.l #255,d1
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     68c:	lsl.l #8,d1
     68e:	ori.w #5,d1
     692:	move.w d1,24(a0)
    *copListEnd++ = COP_WAIT;
     696:	move.w #-2,26(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     69c:	move.w #384,28(a0)
    *copListCurrent++ = color;
     6a2:	move.w d2,30(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// set bitplane mods
	line = 0x2c + BmpLogo.Height + 72 + 7; // 209
     6a6:	move.b 24a9f <BmpLogo+0x3>,d0
     6ac:	addi.b #123,d0
	copPtr = copWaitY(copPtr, line++);
     6b0:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6b6:	lsl.l #8,d0
     6b8:	ori.w #5,d0
     6bc:	move.w d0,32(a0)
    *copListEnd++ = COP_WAIT;
     6c0:	move.w #-2,34(a0)
	copMirrorBmpP = copPtr;
     6c6:	lea 36(a0),a2
     6ca:	move.l a2,24924 <copMirrorBmpP>
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     6d0:	move.w 24aa4 <BmpLogo+0x8>,d0
     6d6:	sub.w 24aa2 <BmpLogo+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     6dc:	move.w #264,36(a0)
    *copListEnd++ = modOdd;
     6e2:	move.w d0,38(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     6e6:	move.w #266,40(a0)
    *copListEnd++ = modEven;
     6ec:	move.w d0,42(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6f0:	move.w #-31,44(a0)
    *copListEnd++ = COP_WAIT;
     6f6:	move.w #-2,46(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6fc:	move.w #1285,48(a0)
    *copListEnd++ = COP_WAIT;
     702:	move.w #-2,50(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     708:	move.w #384,52(a0)
    *copListCurrent++ = color;
     70e:	move.w a1,54(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     712:	move.w #1541,56(a0)
    *copListEnd++ = COP_WAIT;
     718:	move.w #-2,58(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     71e:	move.w #384,60(a0)
    *copListCurrent++ = color;
     724:	move.w d2,62(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     728:	move.w #11269,64(a0)
    *copListEnd++ = COP_WAIT;
     72e:	move.w #-2,66(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     734:	move.w #384,68(a0)
    *copListCurrent++ = color;
     73a:	move.w a1,70(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     73e:	move.w #11525,72(a0)
    *copListEnd++ = COP_WAIT;
     744:	move.w #-2,74(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     74a:	move.w #384,76(a0)
    *copListCurrent++ = color;
     750:	move.w d2,78(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     754:	move.w #-1,80(a0)
    *copListEnd++ = COP_WAIT;
     75a:	move.w #-2,82(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// copper end
	copPtr = copWaitXY(copPtr, 0xff, 0xff);
}
     760:	movem.l (sp)+,d2-d5/a2
     764:	rts

00000766 <EnableMirrorEffect>:

void EnableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2),
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
     766:	move.w 249dc <BmpScroller+0x8>,d0
     76c:	move.w d0,d1
     76e:	sub.w 24ad4 <Screen+0x6>,d1
     774:	add.w d0,d0
     776:	sub.w d0,d1
	copSetBplMod(0, copMirrorBmpP,
     778:	movea.l 24924 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     77e:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     782:	move.w d1,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     786:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     78c:	move.w d1,6(a0)
}
     790:	rts

00000792 <DisableMirrorEffect>:

void DisableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 BmpScroller.Bplt - Screen.Bpl,
				 BmpScroller.Bplt - Screen.Bpl);
     792:	move.w 249dc <BmpScroller+0x8>,d0
     798:	sub.w 24ad4 <Screen+0x6>,d0
	copSetBplMod(0, copMirrorBmpP,
     79e:	movea.l 24924 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     7a4:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     7a8:	move.w d0,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     7ac:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     7b2:	move.w d0,6(a0)
}
     7b6:	rts

000007b8 <PlotChar>:
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
	}
}

void PlotChar(BmpDescriptor bmpFont, BmpDescriptor bmpDest, USHORT plotY, USHORT charW, USHORT charH)
{
     7b8:	movem.l d2-d6/a2/a6,-(sp)
     7bc:	move.l 136(sp),d5
     7c0:	move.l 140(sp),d3
     7c4:	move.l 144(sp),d4
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     7c8:	move.w 24920 <ScrolltextCnt>,d0
     7ce:	move.w d0,d1
     7d0:	addq.w #1,d1
     7d2:	move.w d1,24920 <ScrolltextCnt>
     7d8:	andi.l #65535,d0
     7de:	lea 4397 <Scrolltext>,a0
     7e4:	move.b (0,a0,d0.l),d0
	ULONG source, dest;
	ULONG row, col;

	// Set standard char distance
	NextPlot = 32;
     7e8:	move.w #32,6a54 <NextPlot>
	// scroller commands: b=bounce; m=mirror; s=stop; c=color
	if (chr == 'b')
     7f0:	cmpi.b #98,d0
     7f4:	beq.w 948 <PlotChar+0x190>
		}
		BounceEnabled = !BounceEnabled;

		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'm')
     7f8:	cmpi.b #109,d0
     7fc:	beq.w 98a <PlotChar+0x1d2>
		}

		MirrorEnabled = !MirrorEnabled;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 's')
     800:	cmpi.b #115,d0
     804:	beq.w 9d2 <PlotChar+0x21a>
	{
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'c')
     808:	cmpi.b #99,d0
     80c:	beq.w a58 <PlotChar+0x2a0>
		colScrollMirror[0] = 0x6bf;
		colScrollMirror[1] = 0x49b;
		ResetCopper = TRUE;
	}
	// select character for different spacing
	if (chr == '!' || chr == 'I' || chr == '.' || chr == ',' || chr == ':' || chr == ';' || chr == '\'')
     810:	cmpi.b #33,d0
     814:	beq.s 83a <PlotChar+0x82>
     816:	cmpi.b #73,d0
     81a:	beq.s 83a <PlotChar+0x82>
     81c:	cmpi.b #46,d0
     820:	beq.s 83a <PlotChar+0x82>
     822:	cmpi.b #44,d0
     826:	beq.s 83a <PlotChar+0x82>
     828:	cmpi.b #58,d0
     82c:	beq.s 83a <PlotChar+0x82>
     82e:	cmpi.b #59,d0
     832:	beq.s 83a <PlotChar+0x82>
     834:	cmpi.b #39,d0
     838:	bne.s 842 <PlotChar+0x8a>
	{
		NextPlot = 12;
     83a:	move.w #12,6a54 <NextPlot>
	}
	if (chr == 'J')
     842:	cmpi.b #74,d0
     846:	beq.w a74 <PlotChar+0x2bc>
	{
		NextPlot = 24;
	}
	// check for end of text
	if (chr == 0)
     84a:	tst.b d0
     84c:	bne.s 876 <PlotChar+0xbe>
	{
		ScrolltextCnt = 0;
     84e:	clr.w 24920 <ScrolltextCnt>
		chr = Scrolltext[ScrolltextCnt++];
     854:	move.w #1,24920 <ScrolltextCnt>
		colScrollMirror[0] = 0x111;
     85c:	move.w #273,6a56 <colScrollMirror>
		colScrollMirror[1] = 0x222;
     864:	move.w #546,6a58 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     86c:	move.w #1,24938 <ResetCopper>
		chr = Scrolltext[ScrolltextCnt++];
     874:	moveq #32,d0
	}
	// check legal values
	if (chr < 32 || chr > (32 + 80))
     876:	addi.b #-32,d0
     87a:	cmpi.b #80,d0
     87e:	bhi.w 942 <PlotChar+0x18a>
		return;
	}
	// skip first 32 ascii codes
	chr -= 32;
	// get row and column of source bitmap (10 chrs per row)
	row = chr / 10;
     882:	andi.w #255,d0
     886:	move.w d0,d6
     888:	mulu.w #-13107,d6
     88c:	clr.w d6
     88e:	swap d6
     890:	lsr.w #3,d6
	col = chr % 10;
     892:	move.w d6,d1
     894:	add.w d6,d1
     896:	add.w d1,d1
     898:	add.w d6,d1
     89a:	add.w d1,d1
     89c:	sub.w d1,d0
     89e:	moveq #0,d2
     8a0:	move.b d0,d2
	// calc source bitplane pointer
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     8a2:	moveq #0,d0
     8a4:	move.w 40(sp),d0
     8a8:	lea 27f8 <__mulsi3>,a2
     8ae:	moveq #31,d1
     8b0:	and.l d6,d1
     8b2:	move.l d1,-(sp)
     8b4:	move.l d0,-(sp)
     8b6:	jsr (a2)
     8b8:	addq.l #8,sp
     8ba:	move.l d0,-(sp)
     8bc:	move.w d4,-(sp)
     8be:	clr.w -(sp)
     8c0:	jsr (a2)
     8c2:	addq.l #8,sp
     8c4:	add.l d2,d2
     8c6:	add.l d2,d2
     8c8:	add.l d0,d2
	// calc destination bitplane pointer
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     8ca:	moveq #0,d0
     8cc:	move.w 92(sp),d0
     8d0:	move.l d0,-(sp)
     8d2:	move.w d5,-(sp)
     8d4:	clr.w -(sp)
     8d6:	jsr (a2)
     8d8:	addq.l #8,sp
     8da:	moveq #0,d5
     8dc:	move.w 24ad4 <Screen+0x6>,d5
     8e2:	add.l d0,d5
	// wait for blitter and blit
	WaitBlit();
     8e4:	movea.l 24b04 <GfxBase>,a6
     8ea:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     8ee:	movea.l 24b0e <custom>,a0
     8f4:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     8fa:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     900:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     906:	move.w #-1,70(a0)
	custom->bltapt = ((UBYTE *)bmpFont.ImageData) + source;
     90c:	add.l 46(sp),d2
     910:	move.l d2,80(a0)
	custom->bltdpt = ((UBYTE *)bmpDest.ImageData) + dest;
     914:	add.l 98(sp),d5
     918:	move.l d5,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     91c:	move.w d3,d0
     91e:	lsr.w #3,d0
     920:	move.w 38(sp),d1
     924:	sub.w d0,d1
     926:	move.w d1,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     92a:	move.w 90(sp),d1
     92e:	sub.w d0,d1
     930:	move.w d1,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     934:	muls.w 36(sp),d4
     938:	lsl.w #6,d4
     93a:	lsr.w #4,d3
     93c:	add.w d4,d3
     93e:	move.w d3,88(a0)
}
     942:	movem.l (sp)+,d2-d6/a2/a6
     946:	rts
		if (BounceEnabled)
     948:	move.w 24936 <BounceEnabled>,d0
     94e:	beq.s 95e <PlotChar+0x1a6>
			ScrollerY = SCRT_MIN;
     950:	clr.w 24934 <ScrollerY>
			ScrollerDir = 1;
     956:	move.b #1,6ada <ScrollerDir>
		BounceEnabled = !BounceEnabled;
     95e:	tst.w d0
     960:	seq d0
     962:	ext.w d0
     964:	neg.w d0
     966:	move.w d0,24936 <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     96c:	move.w d1,d0
     96e:	addq.w #1,d0
     970:	move.w d0,24920 <ScrolltextCnt>
     976:	andi.l #65535,d1
     97c:	lea 4397 <Scrolltext>,a0
     982:	move.b (0,a0,d1.l),d0
     986:	bra.w 7f8 <PlotChar+0x40>
		if (MirrorEnabled)
     98a:	tst.w 2491e <MirrorEnabled>
     990:	beq.s 9cc <PlotChar+0x214>
			DisableMirrorEffect();
     992:	jsr 792 <DisableMirrorEffect>(pc)
		MirrorEnabled = !MirrorEnabled;
     996:	tst.w 2491e <MirrorEnabled>
     99c:	seq d0
     99e:	ext.w d0
     9a0:	neg.w d0
     9a2:	move.w d0,2491e <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     9a8:	move.w 24920 <ScrolltextCnt>,d0
     9ae:	move.w d0,d1
     9b0:	addq.w #1,d1
     9b2:	move.w d1,24920 <ScrolltextCnt>
     9b8:	andi.l #65535,d0
     9be:	lea 4397 <Scrolltext>,a0
     9c4:	move.b (0,a0,d0.l),d0
     9c8:	bra.w 800 <PlotChar+0x48>
			EnableMirrorEffect();
     9cc:	jsr 766 <EnableMirrorEffect>(pc)
     9d0:	bra.s 996 <PlotChar+0x1de>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     9d2:	tst.w 24936 <BounceEnabled>
     9d8:	beq.s a2a <PlotChar+0x272>
     9da:	move.w 24920 <ScrolltextCnt>,d0
     9e0:	move.w d0,d1
     9e2:	addq.w #1,d1
     9e4:	move.w d1,24920 <ScrolltextCnt>
     9ea:	andi.l #65535,d0
     9f0:	lea 4397 <Scrolltext>,a0
     9f6:	move.b (0,a0,d0.l),d0
     9fa:	ext.w d0
     9fc:	addi.w #-48,d0
     a00:	move.w d0,24932 <ScrollerPause>
		chr = Scrolltext[ScrolltextCnt++];
     a06:	move.w 24920 <ScrolltextCnt>,d0
     a0c:	move.w d0,d1
     a0e:	addq.w #1,d1
     a10:	move.w d1,24920 <ScrolltextCnt>
     a16:	andi.l #65535,d0
     a1c:	lea 4397 <Scrolltext>,a0
     a22:	move.b (0,a0,d0.l),d0
     a26:	bra.w 808 <PlotChar+0x50>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     a2a:	move.w 24920 <ScrolltextCnt>,d0
     a30:	move.w d0,d1
     a32:	addq.w #1,d1
     a34:	move.w d1,24920 <ScrolltextCnt>
     a3a:	andi.l #65535,d0
     a40:	lea 4397 <Scrolltext>,a0
     a46:	move.b (0,a0,d0.l),d0
     a4a:	ext.w d0
     a4c:	movea.w d0,a0
     a4e:	moveq #-48,d0
     a50:	add.l a0,d0
     a52:	muls.w #50,d0
     a56:	bra.s a00 <PlotChar+0x248>
		colScrollMirror[0] = 0x6bf;
     a58:	move.w #1727,6a56 <colScrollMirror>
		colScrollMirror[1] = 0x49b;
     a60:	move.w #1179,6a58 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     a68:	move.w #1,24938 <ResetCopper>
     a70:	bra.w 810 <PlotChar+0x58>
		NextPlot = 24;
     a74:	move.w #24,6a54 <NextPlot>
     a7c:	bra.w 84a <PlotChar+0x92>

00000a80 <Scrollit>:
{
     a80:	movem.l d2-d7/a2/a6,-(sp)
     a84:	move.l 96(sp),d3
     a88:	move.l 100(sp),d4
	int BltOffs = startY * theDesc.Bplt;
     a8c:	moveq #0,d5
     a8e:	move.w 94(sp),d5
     a92:	moveq #0,d6
     a94:	move.w 44(sp),d6
     a98:	lea 27f8 <__mulsi3>,a2
     a9e:	move.l d6,-(sp)
     aa0:	move.l d5,-(sp)
     aa2:	jsr (a2)
     aa4:	addq.l #8,sp
     aa6:	move.l d0,d2
	int Brcorner = height * theDesc.Bplt - 2;
     aa8:	move.l d6,-(sp)
     aaa:	move.w d3,-(sp)
     aac:	clr.w -(sp)
     aae:	jsr (a2)
     ab0:	addq.l #8,sp
     ab2:	move.l d0,d7
     ab4:	subq.l #2,d7
	WaitBlit();
     ab6:	movea.l 24b04 <GfxBase>,a6
     abc:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     ac0:	clr.w d6
     ac2:	move.b d4,d6
     ac4:	moveq #12,d0
     ac6:	lsl.w d0,d4
     ac8:	movea.l 24b0e <custom>,a0
     ace:	addi.w #2544,d4
     ad2:	move.w d4,64(a0)
	custom->bltcon1 = 0x0002;
     ad6:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     adc:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     ae2:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     ae8:	move.l d2,d0
     aea:	add.l d7,d0
     aec:	add.l 88(sp),d0
     af0:	move.l d0,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     af4:	move.l d0,84(a0)
	custom->bltamod = 0;
     af8:	move.w #0,100(a0)
	custom->bltdmod = 0;
     afe:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
     b04:	move.w 40(sp),d0
     b08:	muls.w d3,d0
     b0a:	lsl.w #6,d0
     b0c:	move.w 249d4 <BmpScroller>,d1
     b12:	lsr.w #4,d1
     b14:	add.w d1,d0
     b16:	move.w d0,88(a0)
	ScrollCnt += speed;
     b1a:	add.w 24922 <ScrollCnt>,d6
     b20:	move.w d6,24922 <ScrollCnt>
	if (ScrollCnt >= NextPlot)
     b26:	cmp.w 6a54 <NextPlot>,d6
     b2c:	bcc.s b34 <Scrollit+0xb4>
}
     b2e:	movem.l (sp)+,d2-d7/a2/a6
     b32:	rts
		ScrollCnt = 0;
     b34:	clr.w 24922 <ScrollCnt>
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
     b3a:	pea 20 <_start+0x20>
     b3e:	pea 20 <_start+0x20>
     b42:	move.l d5,-(sp)
     b44:	subq.l #2,sp
     b46:	move.l 24a02 <BmpScroller+0x2e>,-(sp)
     b4c:	move.l 249fe <BmpScroller+0x2a>,-(sp)
     b52:	move.l 249fa <BmpScroller+0x26>,-(sp)
     b58:	move.l 249f6 <BmpScroller+0x22>,-(sp)
     b5e:	move.l 249f2 <BmpScroller+0x1e>,-(sp)
     b64:	move.l 249ee <BmpScroller+0x1a>,-(sp)
     b6a:	move.l 249ea <BmpScroller+0x16>,-(sp)
     b70:	move.l 249e6 <BmpScroller+0x12>,-(sp)
     b76:	move.l 249e2 <BmpScroller+0xe>,-(sp)
     b7c:	move.l 249de <BmpScroller+0xa>,-(sp)
     b82:	move.l 249da <BmpScroller+0x6>,-(sp)
     b88:	move.l 249d6 <BmpScroller+0x2>,-(sp)
     b8e:	move.w 249d4 <BmpScroller>,-(sp)
     b94:	subq.l #2,sp
     b96:	move.l 249d0 <BmpFont32+0x2e>,-(sp)
     b9c:	move.l 249cc <BmpFont32+0x2a>,-(sp)
     ba2:	move.l 249c8 <BmpFont32+0x26>,-(sp)
     ba8:	move.l 249c4 <BmpFont32+0x22>,-(sp)
     bae:	move.l 249c0 <BmpFont32+0x1e>,-(sp)
     bb4:	move.l 249bc <BmpFont32+0x1a>,-(sp)
     bba:	move.l 249b8 <BmpFont32+0x16>,-(sp)
     bc0:	move.l 249b4 <BmpFont32+0x12>,-(sp)
     bc6:	move.l 249b0 <BmpFont32+0xe>,-(sp)
     bcc:	move.l 249ac <BmpFont32+0xa>,-(sp)
     bd2:	move.l 249a8 <BmpFont32+0x6>,-(sp)
     bd8:	move.l 249a4 <BmpFont32+0x2>,-(sp)
     bde:	move.w 249a2 <BmpFont32>,-(sp)
     be4:	jsr 7b8 <PlotChar>(pc)
     be8:	lea 116(sp),sp
     bec:	bra.w b2e <Scrollit+0xae>

00000bf0 <GetVBR>:

static APTR GetVBR()
{
     bf0:	subq.l #8,sp
     bf2:	move.l a6,-(sp)
     bf4:	move.l d7,-(sp)
	APTR vbr = 0;
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     bf6:	move.w #20090,10(sp)
     bfc:	move.w #2049,12(sp)
     c02:	move.w #20083,14(sp)

	if (SysBase->AttnFlags & AFF_68010)
     c08:	movea.l 24b08 <SysBase>,a6
     c0e:	btst #0,297(a6)
     c14:	beq.s c2a <GetVBR+0x3a>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     c16:	moveq #10,d7
     c18:	add.l sp,d7
     c1a:	exg d7,a5
     c1c:	jsr -30(a6)
     c20:	exg d7,a5

	return vbr;
}
     c22:	move.l (sp)+,d7
     c24:	movea.l (sp)+,a6
     c26:	addq.l #8,sp
     c28:	rts
	APTR vbr = 0;
     c2a:	moveq #0,d0
	return vbr;
     c2c:	bra.s c22 <GetVBR+0x32>

00000c2e <SetInterruptHandler>:

void SetInterruptHandler(APTR interrupt)
{
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     c2e:	movea.l 2491a <VBR>,a0
     c34:	move.l 4(sp),108(a0)
}
     c3a:	rts

00000c3c <GetInterruptHandler>:

APTR GetInterruptHandler()
{
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     c3c:	movea.l 2491a <VBR>,a0
     c42:	move.l 108(a0),d0
}
     c46:	rts

00000c48 <WaitVbl>:

//vblank begins at vpos 312 hpos 1 and ends at vpos 25 hpos 1
//vsync begins at line 2 hpos 132 and ends at vpos 5 hpos 18
void WaitVbl()
{
     c48:	subq.l #8,sp
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     c4a:	move.l dff004 <_end+0xdda4f0>,d0
     c50:	move.l d0,(sp)
		vpos &= 0x1ff00;
     c52:	move.l (sp),d0
     c54:	andi.l #130816,d0
     c5a:	move.l d0,(sp)
		if (vpos != (311 << 8))
     c5c:	move.l (sp),d0
     c5e:	cmpi.l #79616,d0
     c64:	beq.s c4a <WaitVbl+0x2>
			break;
	}
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     c66:	move.l dff004 <_end+0xdda4f0>,d0
     c6c:	move.l d0,4(sp)
		vpos &= 0x1ff00;
     c70:	move.l 4(sp),d0
     c74:	andi.l #130816,d0
     c7a:	move.l d0,4(sp)
		if (vpos == (311 << 8))
     c7e:	move.l 4(sp),d0
     c82:	cmpi.l #79616,d0
     c88:	bne.s c66 <WaitVbl+0x1e>
			break;
	}
}
     c8a:	addq.l #8,sp
     c8c:	rts

00000c8e <TakeSystem>:
	{
	} //blitter busy wait
}

void TakeSystem()
{
     c8e:	move.l a6,-(sp)
     c90:	move.l a2,-(sp)
	ActiView = GfxBase->ActiView; //store current view
     c92:	movea.l 24b04 <GfxBase>,a6
     c98:	move.l 34(a6),24916 <ActiView>
	OwnBlitter();
     ca0:	jsr -456(a6)
	WaitBlit();
     ca4:	movea.l 24b04 <GfxBase>,a6
     caa:	jsr -228(a6)
	Disable();
     cae:	movea.l 24b08 <SysBase>,a6
     cb4:	jsr -120(a6)

	//Save current interrupts and DMA settings so we can restore them upon exit.
	SystemADKCON = custom->adkconr;
     cb8:	movea.l 24b0e <custom>,a0
     cbe:	move.w 16(a0),d0
     cc2:	move.w d0,24914 <SystemADKCON>
	SystemInts = custom->intenar;
     cc8:	move.w 28(a0),d0
     ccc:	move.w d0,24912 <SystemInts>
	SystemDMA = custom->dmaconr;
     cd2:	move.w 2(a0),d0
     cd6:	move.w d0,24910 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     cdc:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     ce2:	move.w #32767,156(a0)

	WaitVbl();
     ce8:	lea c48 <WaitVbl>(pc),a2
     cec:	jsr (a2)
	WaitVbl();
     cee:	jsr (a2)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     cf0:	movea.l 24b0e <custom>,a0
     cf6:	move.w #32767,150(a0)

	//set all colors black
	for (int a = 0; a < 32; a++)
     cfc:	moveq #0,d1
     cfe:	bra.s d12 <TakeSystem+0x84>
		custom->color[a] = 0;
     d00:	move.l d1,d0
     d02:	addi.l #192,d0
     d08:	add.l d0,d0
     d0a:	move.w #0,(0,a0,d0.l)
	for (int a = 0; a < 32; a++)
     d10:	addq.l #1,d1
     d12:	moveq #31,d0
     d14:	cmp.l d1,d0
     d16:	bge.s d00 <TakeSystem+0x72>

	LoadView(0);
     d18:	movea.l 24b04 <GfxBase>,a6
     d1e:	suba.l a1,a1
     d20:	jsr -222(a6)
	WaitTOF();
     d24:	movea.l 24b04 <GfxBase>,a6
     d2a:	jsr -270(a6)
	WaitTOF();
     d2e:	movea.l 24b04 <GfxBase>,a6
     d34:	jsr -270(a6)

	WaitVbl();
     d38:	lea c48 <WaitVbl>(pc),a2
     d3c:	jsr (a2)
	WaitVbl();
     d3e:	jsr (a2)

	VBR = GetVBR();
     d40:	jsr bf0 <GetVBR>(pc)
     d44:	move.l d0,2491a <VBR>
	SystemIrq = GetInterruptHandler(); //store interrupt register
     d4a:	jsr c3c <GetInterruptHandler>(pc)
     d4e:	move.l d0,2490c <SystemIrq>
}
     d54:	movea.l (sp)+,a2
     d56:	movea.l (sp)+,a6
     d58:	rts

00000d5a <FreeSystem>:

void FreeSystem()
{
     d5a:	move.l a6,-(sp)
	WaitVbl();
     d5c:	jsr c48 <WaitVbl>(pc)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     d60:	movea.l 24b0e <custom>,a0
     d66:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     d6a:	move.w 2(a0),d0
     d6e:	btst #14,d0
     d72:	bne.s d6a <FreeSystem+0x10>
	WaitBlt();
	custom->intena = 0x7fff; //disable all interrupts
     d74:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     d7a:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     d80:	move.w #32767,150(a0)

	//restore interrupts
	SetInterruptHandler(SystemIrq);
     d86:	move.l 2490c <SystemIrq>,-(sp)
     d8c:	jsr c2e <SetInterruptHandler>(pc)

	/*Restore system copper list(s). */
	custom->cop1lc = (ULONG)GfxBase->copinit;
     d90:	movea.l 24b04 <GfxBase>,a6
     d96:	movea.l 24b0e <custom>,a0
     d9c:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     da2:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     da8:	move.w #32767,136(a0)

	/*Restore all interrupts and DMA settings. */
	custom->intena = SystemInts | 0x8000;
     dae:	move.w 24912 <SystemInts>,d0
     db4:	ori.w #-32768,d0
     db8:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     dbc:	move.w 24910 <SystemDMA>,d0
     dc2:	ori.w #-32768,d0
     dc6:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     dca:	move.w 24914 <SystemADKCON>,d0
     dd0:	ori.w #-32768,d0
     dd4:	move.w d0,158(a0)

	LoadView(ActiView);
     dd8:	movea.l 24916 <ActiView>,a1
     dde:	jsr -222(a6)
	WaitTOF();
     de2:	movea.l 24b04 <GfxBase>,a6
     de8:	jsr -270(a6)
	WaitTOF();
     dec:	movea.l 24b04 <GfxBase>,a6
     df2:	jsr -270(a6)
	WaitBlit();
     df6:	movea.l 24b04 <GfxBase>,a6
     dfc:	jsr -228(a6)
	DisownBlitter();
     e00:	movea.l 24b04 <GfxBase>,a6
     e06:	jsr -462(a6)
	Enable();
     e0a:	movea.l 24b08 <SysBase>,a6
     e10:	jsr -126(a6)
     e14:	addq.l #4,sp
}
     e16:	movea.l (sp)+,a6
     e18:	rts

00000e1a <InitImagePlanes>:

void InitImagePlanes(BmpDescriptor *img, USHORT offs)
{
     e1a:	movem.l d2-d4/a2,-(sp)
     e1e:	movea.l 20(sp),a2
     e22:	move.w 26(sp),d4
	for (int p = 0; p < img->Bpls; p++)
     e26:	moveq #0,d2
     e28:	bra.s e54 <InitImagePlanes+0x3a>
	{
		img->Planes[p] = ((UBYTE *)img->ImageData) + offs + (p * (img->Bpl));
     e2a:	move.l 14(a2),d3
     e2e:	moveq #0,d0
     e30:	move.w 6(a2),d0
     e34:	move.l d2,-(sp)
     e36:	move.l d0,-(sp)
     e38:	jsr 27f8 <__mulsi3>
     e3e:	addq.l #8,sp
     e40:	moveq #0,d1
     e42:	move.w d4,d1
     e44:	add.l d1,d0
     e46:	move.l d2,d1
     e48:	add.l d2,d1
     e4a:	add.l d1,d1
     e4c:	add.l d0,d3
     e4e:	move.l d3,(18,a2,d1.l)
	for (int p = 0; p < img->Bpls; p++)
     e52:	addq.l #1,d2
     e54:	moveq #0,d0
     e56:	move.w 4(a2),d0
     e5a:	cmp.l d0,d2
     e5c:	blt.s e2a <InitImagePlanes+0x10>
	}
}
     e5e:	movem.l (sp)+,d2-d4/a2
     e62:	rts

00000e64 <CopyBitmap>:
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     e64:	movea.l 24b0e <custom>,a0
     e6a:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     e6e:	move.w 2(a0),d0
     e72:	btst #14,d0
     e76:	bne.s e6e <CopyBitmap+0xa>

void CopyBitmap(BmpDescriptor bmpS, BmpDescriptor bmpD)
{
	WaitBlt();

	custom->bltcon0 = 0x09f0;
     e78:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     e7e:	move.w #0,66(a0)
	custom->bltapt = (UBYTE *)bmpS.ImageData;
     e84:	move.l 18(sp),80(a0)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
     e8a:	move.l 70(sp),84(a0)
	custom->bltafwm = 0xffff;
     e90:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     e96:	move.w #-1,70(a0)
	custom->bltamod = 0;
     e9c:	move.w #0,100(a0)
	custom->bltdmod = 0;
     ea2:	move.w #0,102(a0)
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
     ea8:	move.w 6(sp),d1
     eac:	muls.w 8(sp),d1
     eb0:	lsl.w #6,d1
     eb2:	move.w 10(sp),d0
     eb6:	lsr.w #1,d0
     eb8:	add.w d1,d0
     eba:	move.w d0,88(a0)
}
     ebe:	rts

00000ec0 <ClearBitmapPart>:
	custom->bltdmod = 0;
	custom->bltsize = ((lines * bmpD.Bpls) << 6) + (bmpD.Width / 16);
}

void ClearBitmapPart(BmpDescriptor bmp, int x, int y, int height, int width)
{
     ec0:	movem.l d2-d5/a2-a3,-(sp)
     ec4:	move.l 80(sp),d5
     ec8:	movea.l 92(sp),a3
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     ecc:	movea.l 24b0e <custom>,a2
     ed2:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     ed6:	move.w 2(a2),d0
     eda:	btst #14,d0
     ede:	bne.s ed6 <ClearBitmapPart+0x16>
	WaitBlt();
	BYTE shift = x % 16;
     ee0:	move.l d5,d2
     ee2:	andi.l #-2147483633,d2
     ee8:	tst.l d5
     eea:	blt.w f86 <ClearBitmapPart+0xc6>
	if (shift)
     eee:	tst.b d2
     ef0:	beq.s ef6 <ClearBitmapPart+0x36>
		width += 16;
     ef2:	lea 16(a3),a3
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
     ef6:	move.b d2,d0
     ef8:	ext.w d0
     efa:	move.w d0,d4
     efc:	ext.l d4
     efe:	move.l d4,d1
     f00:	moveq #12,d3
     f02:	lsl.l d3,d1
     f04:	ori.w #2304,d1
     f08:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
     f0c:	moveq #12,d1
     f0e:	lsl.w d1,d0
     f10:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     f14:	move.l 42(sp),d3
     f18:	moveq #0,d0
     f1a:	move.w 36(sp),d0
     f1e:	move.l 84(sp),-(sp)
     f22:	move.l d0,-(sp)
     f24:	jsr 27f8 <__mulsi3>
     f2a:	addq.l #8,sp
     f2c:	move.l d5,d1
     f2e:	bmi.s f92 <ClearBitmapPart+0xd2>
     f30:	asr.l #3,d1
     f32:	add.l d1,d0
     f34:	add.l d3,d0
     f36:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     f3a:	move.l d0,84(a2)
	custom->bltafwm = 0xffff;
     f3e:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     f44:	tst.b d2
     f46:	beq.s f96 <ClearBitmapPart+0xd6>
     f48:	moveq #15,d1
     f4a:	sub.l d4,d1
     f4c:	moveq #0,d0
     f4e:	not.w d0
     f50:	asr.l d1,d0
     f52:	move.w d0,70(a2)
	;
	custom->bltamod = bmp.Bpl - (width / 8);
     f56:	move.w 34(sp),d0
     f5a:	move.l a3,d1
     f5c:	bmi.s f9a <ClearBitmapPart+0xda>
     f5e:	asr.l #3,d1
     f60:	sub.w d1,d0
     f62:	move.w d0,100(a2)
	custom->bltdmod = bmp.Bpl - (width / 8);
     f66:	move.w d0,102(a2)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     f6a:	move.w 32(sp),d0
     f6e:	muls.w 90(sp),d0
     f72:	lsl.w #6,d0
     f74:	move.l a3,d1
     f76:	bmi.s f9e <ClearBitmapPart+0xde>
     f78:	asr.l #4,d1
     f7a:	add.w d1,d0
     f7c:	move.w d0,88(a2)
}
     f80:	movem.l (sp)+,d2-d5/a2-a3
     f84:	rts
	BYTE shift = x % 16;
     f86:	subq.l #1,d2
     f88:	moveq #-16,d0
     f8a:	or.l d0,d2
     f8c:	addq.l #1,d2
     f8e:	bra.w eee <ClearBitmapPart+0x2e>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     f92:	addq.l #7,d1
     f94:	bra.s f30 <ClearBitmapPart+0x70>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     f96:	moveq #-1,d0
     f98:	bra.s f52 <ClearBitmapPart+0x92>
	custom->bltamod = bmp.Bpl - (width / 8);
     f9a:	addq.l #7,d1
     f9c:	bra.s f5e <ClearBitmapPart+0x9e>
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     f9e:	moveq #15,d1
     fa0:	add.l a3,d1
     fa2:	bra.s f78 <ClearBitmapPart+0xb8>

00000fa4 <SimpleBlit>:

void SimpleBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
     fa4:	movem.l d2-d7/a2,-(sp)
     fa8:	move.l 136(sp),d7
     fac:	move.l 140(sp),d1
     fb0:	move.l 144(sp),d4
     fb4:	move.l 148(sp),d5
     fb8:	move.l 152(sp),d3
     fbc:	move.l 156(sp),d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     fc0:	movea.l 24b0e <custom>,a2
     fc6:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     fca:	move.w 2(a2),d0
     fce:	btst #14,d0
     fd2:	bne.s fca <SimpleBlit+0x26>
	WaitBlt();
	custom->bltcon0 = 0x09f0;
     fd4:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
     fda:	move.w #0,66(a2)
	custom->bltafwm = 0xffff;
     fe0:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
     fe6:	move.w #-1,70(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
     fec:	move.w d2,d0
     fee:	lsr.w #3,d0
     ff0:	movea.w 38(sp),a0
     ff4:	suba.w d0,a0
     ff6:	move.w a0,100(a2)
	custom->bltdmod = imgD.Bpl - (width / 8);
     ffa:	movea.w 90(sp),a0
     ffe:	suba.w d0,a0
    1000:	move.w a0,102(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1004:	move.l 46(sp),d6
    1008:	moveq #0,d0
    100a:	move.w 40(sp),d0
    100e:	move.l d0,-(sp)
    1010:	move.l d1,-(sp)
    1012:	jsr 27f8 <__mulsi3>
    1018:	addq.l #8,sp
    101a:	move.l d7,d1
    101c:	bmi.s 1060 <SimpleBlit+0xbc>
    101e:	asr.l #3,d1
    1020:	add.l d1,d0
    1022:	add.l d6,d0
    1024:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1028:	move.l 98(sp),d6
    102c:	moveq #0,d0
    102e:	move.w 92(sp),d0
    1032:	move.l d0,-(sp)
    1034:	move.l d5,-(sp)
    1036:	jsr 27f8 <__mulsi3>
    103c:	addq.l #8,sp
    103e:	move.l d4,d1
    1040:	bmi.s 1064 <SimpleBlit+0xc0>
    1042:	asr.l #3,d1
    1044:	add.l d1,d0
    1046:	add.l d6,d0
    1048:	move.l d0,84(a2)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
    104c:	muls.w 36(sp),d3
    1050:	lsl.w #6,d3
    1052:	lsr.w #4,d2
    1054:	add.w d3,d2
    1056:	move.w d2,88(a2)
}
    105a:	movem.l (sp)+,d2-d7/a2
    105e:	rts
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1060:	addq.l #7,d1
    1062:	bra.s 101e <SimpleBlit+0x7a>
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1064:	addq.l #7,d1
    1066:	bra.s 1042 <SimpleBlit+0x9e>

00001068 <BetterBlit>:

void BetterBlit(BmpDescriptor imgS, BmpDescriptor imgD, BmpDescriptor imgM, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    1068:	movem.l d2-d7/a2-a6,-(sp)
    106c:	movea.l 204(sp),a3
    1070:	move.l 208(sp),d7
    1074:	move.l 212(sp),d5
    1078:	movea.l 216(sp),a5
    107c:	movea.l 220(sp),a4
    1080:	move.l 224(sp),d1
    1084:	move.w d1,d4
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1086:	movea.l 24b0e <custom>,a2
    108c:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1090:	move.w 2(a2),d0
    1094:	btst #14,d0
    1098:	bne.s 1090 <BetterBlit+0x28>
	WaitBlt();
	BYTE shift = startD.X % 16;
    109a:	move.l d5,d3
    109c:	andi.l #-2147483633,d3
    10a2:	tst.l d5
    10a4:	blt.w 1198 <BetterBlit+0x130>
	if (shift)
    10a8:	tst.b d3
    10aa:	beq.s 10b2 <BetterBlit+0x4a>
		width += 16;
    10ac:	move.w d1,d4
    10ae:	addi.w #16,d4

	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    10b2:	move.b d3,d0
    10b4:	ext.w d0
    10b6:	movea.w d0,a6
    10b8:	move.l a6,d1
    10ba:	moveq #12,d2
    10bc:	lsl.l d2,d1
    10be:	ori.w #4042,d1
    10c2:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    10c6:	moveq #12,d1
    10c8:	lsl.w d1,d0
    10ca:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    10ce:	move.l 62(sp),d6
    10d2:	moveq #0,d0
    10d4:	move.w 56(sp),d0
    10d8:	move.l d0,-(sp)
    10da:	move.l d7,-(sp)
    10dc:	jsr 27f8 <__mulsi3>
    10e2:	addq.l #8,sp
    10e4:	move.l a3,d2
    10e6:	bmi.w 11a4 <BetterBlit+0x13c>
    10ea:	asr.l #3,d2
    10ec:	add.l d2,d0
    10ee:	add.l d6,d0
    10f0:	move.l d0,80(a2)
	custom->bltamod = imgS.Bpl - (width / 8);
    10f4:	move.w d4,d6
    10f6:	lsr.w #3,d6
    10f8:	move.w 54(sp),d0
    10fc:	sub.w d6,d0
    10fe:	move.w d0,100(a2)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1102:	moveq #0,d0
    1104:	move.w 160(sp),d0
    1108:	lea 27f8 <__mulsi3>,a3
    110e:	move.l d0,-(sp)
    1110:	move.l d7,-(sp)
    1112:	jsr (a3)
    1114:	addq.l #8,sp
    1116:	add.l d0,d2
    1118:	add.l 166(sp),d2
    111c:	move.l d2,76(a2)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1120:	move.w 158(sp),d0
    1124:	sub.w d6,d0
    1126:	move.w d0,98(a2)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    112a:	move.l 114(sp),d2
    112e:	moveq #0,d0
    1130:	move.w 108(sp),d0
    1134:	move.l d0,-(sp)
    1136:	move.l a5,-(sp)
    1138:	jsr (a3)
    113a:	addq.l #8,sp
    113c:	move.l d5,d1
    113e:	bmi.s 11aa <BetterBlit+0x142>
    1140:	asr.l #3,d1
    1142:	add.l d1,d0
    1144:	add.l d2,d0
    1146:	move.l d0,84(a2)
    114a:	move.l d0,72(a2)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    114e:	move.w 106(sp),d0
    1152:	sub.w d6,d0
    1154:	move.w d0,102(a2)
    1158:	move.w d0,96(a2)
	custom->bltafwm = 0xffff;
    115c:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1162:	tst.b d3
    1164:	beq.s 11ae <BetterBlit+0x146>
    1166:	moveq #15,d1
    1168:	sub.l a6,d1
    116a:	moveq #0,d0
    116c:	not.w d0
    116e:	asr.l d1,d0
    1170:	move.w d0,70(a2)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1174:	moveq #0,d0
    1176:	move.w 52(sp),d0
    117a:	move.l d0,-(sp)
    117c:	move.w a4,-(sp)
    117e:	clr.w -(sp)
    1180:	jsr 27f8 <__mulsi3>
    1186:	addq.l #8,sp
    1188:	lsl.l #6,d0
    118a:	lsr.w #4,d4
    118c:	or.w d0,d4
    118e:	move.w d4,88(a2)
}
    1192:	movem.l (sp)+,d2-d7/a2-a6
    1196:	rts
	BYTE shift = startD.X % 16;
    1198:	subq.l #1,d3
    119a:	moveq #-16,d0
    119c:	or.l d0,d3
    119e:	addq.l #1,d3
    11a0:	bra.w 10a8 <BetterBlit+0x40>
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    11a4:	addq.l #7,d2
    11a6:	bra.w 10ea <BetterBlit+0x82>
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    11aa:	addq.l #7,d1
    11ac:	bra.s 1140 <BetterBlit+0xd8>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    11ae:	moveq #-1,d0
    11b0:	bra.s 1170 <BetterBlit+0x108>

000011b2 <p61Init>:

int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
    11b2:	move.l a3,-(sp)
    11b4:	move.l a2,-(sp)
	register volatile const void *_a0 ASM("a0") = module;
    11b6:	movea.l 12(sp),a0
	register volatile const void *_a1 ASM("a1") = NULL;
    11ba:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
    11bc:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
    11be:	lea 29d6 <incbin_P61_Player_start>,a3
	register int _d0 ASM("d0"); // return value
	__asm volatile(
    11c4:	movem.l d1-d7/a4-a6,-(sp)
    11c8:	jsr (a3)
    11ca:	movem.l (sp)+,d1-d7/a4-a6
		"movem.l (%%sp)+,%%d1-%%d7/%%a4-%%a6"
		: "=r"(_d0), "+rf"(_a0), "+rf"(_a1), "+rf"(_a2), "+rf"(_a3)
		:
		: "cc", "memory");
	return _d0;
}
    11ce:	movea.l (sp)+,a2
    11d0:	movea.l (sp)+,a3
    11d2:	rts

000011d4 <p61Music>:

void p61Music()
{
    11d4:	move.l a6,-(sp)
    11d6:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    11d8:	lea 29d6 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    11de:	movea.l #14675968,a6
	__asm volatile(
    11e4:	movem.l d0-a2/a4-a5,-(sp)
    11e8:	jsr 4(a3)
    11ec:	movem.l (sp)+,d0-a2/a4-a5
		"jsr 4(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d7/%%a0-%%a2/%%a4-%%a5"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    11f0:	movea.l (sp)+,a3
    11f2:	movea.l (sp)+,a6
    11f4:	rts

000011f6 <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);
// interrupt handler
static __attribute__((interrupt)) void interruptHandler()
{
    11f6:	movem.l d0-d1/a0-a1,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    11fa:	movea.l 24b0e <custom>,a0
    1200:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    1206:	move.w #32,156(a0)

    // DEMO - ThePlayer
    p61Music();
    120c:	jsr 11d4 <p61Music>(pc)

    // DEMO - increment frameCounter
    frameCounter++;
    1210:	move.w 24b0c <frameCounter>,d0
    1216:	addq.w #1,d0
    1218:	move.w d0,24b0c <frameCounter>
}
    121e:	movem.l (sp)+,d0-d1/a0-a1
    1222:	rte

00001224 <p61End>:

void p61End()
{
    1224:	move.l a6,-(sp)
    1226:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    1228:	lea 29d6 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    122e:	movea.l #14675968,a6
	__asm volatile(
    1234:	movem.l d0-d1/a0-a1,-(sp)
    1238:	jsr 8(a3)
    123c:	movem.l (sp)+,d0-d1/a0-a1
		"jsr 8(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d1/%%a0-%%a1"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    1240:	movea.l (sp)+,a3
    1242:	movea.l (sp)+,a6
    1244:	rts

00001246 <BitmapInit>:

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{
    1246:	move.l d3,-(sp)
    1248:	move.l d2,-(sp)
    124a:	movea.l 12(sp),a0
    124e:	move.l 16(sp),d0
    1252:	move.l 20(sp),d2
    1256:	move.l 24(sp),d1

	bmp->Width = w;
    125a:	move.w d0,(a0)
	bmp->Height = h;
    125c:	move.w d2,2(a0)
	bmp->Bpls = bpls;
    1260:	move.w d1,4(a0)
	bmp->Bpl = w / 8;
    1264:	lsr.w #3,d0
    1266:	move.w d0,6(a0)
	bmp->Bplt = w / 8 * bpls;
    126a:	move.w d0,d3
    126c:	muls.w d1,d3
    126e:	move.w d3,8(a0)
	bmp->Btot = w / 8 * h * bpls;
    1272:	muls.w d2,d0
    1274:	muls.w d1,d0
    1276:	move.w d0,12(a0)
}
    127a:	move.l (sp)+,d2
    127c:	move.l (sp)+,d3
    127e:	rts

00001280 <InitStarfieldSprite>:

void InitStarfieldSprite()
{
    1280:	movem.l d2-d7/a2-a3,-(sp)
	short line = 0;
	USHORT hpos = 3;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 31; l++)
    1284:	moveq #0,d5
	BYTE vpos = 0x2c;
    1286:	moveq #44,d3
	USHORT hpos = 3;
    1288:	movea.w #3,a1
	short line = 0;
    128c:	clr.w d2
    128e:	bra.w 13c8 <InitStarfieldSprite+0x148>
	{
		hpos = (7 * hpos) % 255;
    1292:	moveq #0,d0
    1294:	move.w a1,d0
    1296:	move.l d0,d1
    1298:	lsl.l #3,d1
    129a:	lea 28a0 <__modsi3>,a3
    12a0:	pea ff <MoveBobs+0x73>
    12a4:	sub.l d0,d1
    12a6:	move.l d1,-(sp)
    12a8:	jsr (a3)
    12aa:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    12ac:	move.b d3,d1
    12ae:	ext.w d1
    12b0:	move.w d1,d4
    12b2:	ext.l d4
    12b4:	lsl.l #8,d4
    12b6:	move.w d0,d6
    12b8:	andi.w #255,d6
    12bc:	movea.w d2,a0
    12be:	addq.w #1,a0
    12c0:	movea.w d2,a1
    12c2:	lea 2461e <StarSprite>,a2
    12c8:	adda.l a1,a1
    12ca:	or.w d4,d6
    12cc:	move.w d6,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    12d0:	addq.w #1,d1
    12d2:	movea.w d2,a1
    12d4:	addq.w #2,a1
    12d6:	movea.w a0,a0
    12d8:	lsl.w #8,d1
    12da:	adda.l a0,a0
    12dc:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-1
    12e0:	movea.w d2,a0
    12e2:	addq.w #3,a0
    12e4:	movea.w a1,a1
    12e6:	adda.l a1,a1
    12e8:	move.w #-32768,(0,a1,a2.l)
		StarSprite[line++] = 0x0000;					  //color-1
    12ee:	move.w d2,d6
    12f0:	addq.w #4,d6
    12f2:	movea.w a0,a0
    12f4:	adda.l a0,a0
    12f6:	clr.w (0,a0,a2.l)
		vpos += 2;
    12fa:	move.b d3,d4
    12fc:	addq.b #2,d4

		hpos = (7 * hpos) % 255;
    12fe:	andi.l #65535,d0
    1304:	move.l d0,d1
    1306:	lsl.l #3,d1
    1308:	pea ff <MoveBobs+0x73>
    130c:	sub.l d0,d1
    130e:	move.l d1,-(sp)
    1310:	jsr (a3)
    1312:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    1314:	move.b d4,d1
    1316:	ext.w d1
    1318:	move.w d1,d4
    131a:	ext.l d4
    131c:	lsl.l #8,d4
    131e:	move.w d0,d7
    1320:	andi.w #255,d7
    1324:	movea.w d2,a0
    1326:	addq.w #5,a0
    1328:	movea.w d6,a1
    132a:	adda.l a1,a1
    132c:	or.w d4,d7
    132e:	move.w d7,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    1332:	addq.w #1,d1
    1334:	movea.w d2,a1
    1336:	addq.w #6,a1
    1338:	movea.w a0,a0
    133a:	lsl.w #8,d1
    133c:	adda.l a0,a0
    133e:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x0000;					  //color-2
    1342:	movea.w d2,a0
    1344:	addq.w #7,a0
    1346:	movea.w a1,a1
    1348:	adda.l a1,a1
    134a:	clr.w (0,a1,a2.l)
		StarSprite[line++] = 0x8000;					  //color-2
    134e:	addq.w #4,d6
    1350:	movea.w a0,a0
    1352:	adda.l a0,a0
    1354:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    135a:	move.b d3,d4
    135c:	addq.b #4,d4

		hpos = (7 * hpos) % 255;
    135e:	andi.l #65535,d0
    1364:	move.l d0,d1
    1366:	lsl.l #3,d1
    1368:	pea ff <MoveBobs+0x73>
    136c:	sub.l d0,d1
    136e:	move.l d1,-(sp)
    1370:	jsr (a3)
    1372:	addq.l #8,sp
    1374:	movea.w d0,a1
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    1376:	move.b d4,d1
    1378:	ext.w d1
    137a:	move.w d1,d4
    137c:	ext.l d4
    137e:	lsl.l #8,d4
    1380:	andi.w #255,d0
    1384:	movea.w d2,a3
    1386:	lea 9(a3),a3
    138a:	movea.w d6,a0
    138c:	adda.l a0,a0
    138e:	or.w d4,d0
    1390:	move.w d0,(0,a2,a0.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    1394:	addq.w #1,d1
    1396:	movea.w d2,a0
    1398:	lea 10(a0),a0
    139c:	movea.w a3,a3
    139e:	lsl.w #8,d1
    13a0:	adda.l a3,a3
    13a2:	move.w d1,(0,a3,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    13a6:	movea.w a0,a0
    13a8:	adda.l a0,a0
    13aa:	move.w #-32768,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    13b0:	movea.w d2,a0
    13b2:	lea 11(a0),a0
    13b6:	movea.w a0,a0
    13b8:	addi.w #12,d2
    13bc:	adda.l a0,a0
    13be:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    13c4:	addq.b #6,d3
	for (int l = 0; l < 31; l++)
    13c6:	addq.l #1,d5
    13c8:	moveq #30,d0
    13ca:	cmp.l d5,d0
    13cc:	bge.w 1292 <InitStarfieldSprite+0x12>
	}
	// sprite end-mark
	StarSprite[line++] = 0;
    13d0:	move.w d2,d0
    13d2:	addq.w #1,d0
    13d4:	ext.l d2
    13d6:	lea 2461e <StarSprite>,a1
    13dc:	add.l d2,d2
    13de:	clr.w (0,a1,d2.l)
	StarSprite[line++] = 0;
    13e2:	movea.w d0,a0
    13e4:	adda.l a0,a0
    13e6:	clr.w (0,a0,a1.l)
}
    13ea:	movem.l (sp)+,d2-d7/a2-a3
    13ee:	rts

000013f0 <MoveStarfield>:

void MoveStarfield()
{
	for (int l = 1; l < 31 * 24; l += 24)
    13f0:	movea.w #1,a0
    13f4:	bra.s 1424 <MoveStarfield+0x34>
	{
		((volatile UBYTE *)StarSprite)[l] += 1;
    13f6:	movea.l a0,a1
    13f8:	adda.l #149022,a1
    13fe:	move.b (a1),d0
    1400:	addq.b #1,d0
    1402:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 8] += 2;
    1404:	movea.l a0,a1
    1406:	adda.l #149030,a1
    140c:	move.b (a1),d0
    140e:	addq.b #2,d0
    1410:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 16] += 3;
    1412:	movea.l a0,a1
    1414:	adda.l #149038,a1
    141a:	move.b (a1),d0
    141c:	addq.b #3,d0
    141e:	move.b d0,(a1)
	for (int l = 1; l < 31 * 24; l += 24)
    1420:	lea 24(a0),a0
    1424:	cmpa.w #743,a0
    1428:	ble.s 13f6 <MoveStarfield+0x6>
	}
}
    142a:	rts

0000142c <MainLoop>:
{
    142c:	movem.l d2-d4/a2-a5,-(sp)
	while (!MouseLeft())
    1430:	bra.w 2124 <MainLoop+0xcf8>
			SetupCopper(copPtr);
    1434:	move.l 2493a <copPtr>,-(sp)
    143a:	jsr 24a <SetupCopper>(pc)
			custom->cop1lc = (ULONG)copPtr;
    143e:	movea.l 24b0e <custom>,a0
    1444:	move.l 2493a <copPtr>,128(a0)
			custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    144c:	move.w #64,150(a0)
			custom->copjmp1 = 0x7fff;	   //start coppper
    1452:	move.w #32767,136(a0)
			custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    1458:	move.w #-30752,150(a0)
			ResetCopper = FALSE;
    145e:	clr.w 24938 <ResetCopper>
    1464:	addq.l #4,sp
    1466:	bra.w 2140 <MainLoop+0xd14>
					ScrollerDir = 1;
    146a:	move.b #1,6ada <ScrollerDir>
    1472:	bra.w 2232 <MainLoop+0xe06>
				ScrollerDir -= 1;
    1476:	subq.b #1,d0
    1478:	move.b d0,6ada <ScrollerDir>
				if (ScrollerDir < -4)
    147e:	cmpi.b #-4,d0
    1482:	bge.s 148c <MainLoop+0x60>
					ScrollerDir = -4;
    1484:	move.b #-4,6ada <ScrollerDir>
				if (ScrollerDir > -1)
    148c:	tst.b 6ada <ScrollerDir>
    1492:	blt.w 2232 <MainLoop+0xe06>
					ScrollerDir = -1;
    1496:	st 6ada <ScrollerDir>
    149c:	bra.w 2232 <MainLoop+0xe06>
			if (ScrollerPause > 0)
    14a0:	move.w 24932 <ScrollerPause>,d0
    14a6:	beq.w 2240 <MainLoop+0xe14>
				ScrollerPause--;
    14aa:	subq.w #1,d0
    14ac:	move.w d0,24932 <ScrollerPause>
    14b2:	bra.w 2240 <MainLoop+0xe14>
		else if (ScrollerY <= ScrollerMin)
    14b6:	cmpa.w #0,a0
    14ba:	bgt.w 225c <MainLoop+0xe30>
			ScrollerY = ScrollerMin;
    14be:	clr.w 24934 <ScrollerY>
			ScrollerDir = 1;
    14c4:	move.b #1,6ada <ScrollerDir>
			if (ScrollerPause > 0)
    14cc:	move.w 24932 <ScrollerPause>,d0
    14d2:	beq.w 225c <MainLoop+0xe30>
				ScrollerPause--;
    14d6:	subq.w #1,d0
    14d8:	move.w d0,24932 <ScrollerPause>
    14de:	bra.w 225c <MainLoop+0xe30>
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    14e2:	pea 4 <_start+0x4>
    14e6:	pea 20 <_start+0x20>
    14ea:	pea 28 <_start+0x28>
    14ee:	move.l 249e2 <BmpScroller+0xe>,-(sp)
    14f4:	subq.l #2,sp
    14f6:	move.l 24a02 <BmpScroller+0x2e>,-(sp)
    14fc:	move.l 249fe <BmpScroller+0x2a>,-(sp)
    1502:	move.l 249fa <BmpScroller+0x26>,-(sp)
    1508:	move.l 249f6 <BmpScroller+0x22>,-(sp)
    150e:	move.l 249f2 <BmpScroller+0x1e>,-(sp)
    1514:	move.l 249ee <BmpScroller+0x1a>,-(sp)
    151a:	move.l 249ea <BmpScroller+0x16>,-(sp)
    1520:	move.l 249e6 <BmpScroller+0x12>,-(sp)
    1526:	move.l 249e2 <BmpScroller+0xe>,-(sp)
    152c:	move.l 249de <BmpScroller+0xa>,-(sp)
    1532:	move.l 249da <BmpScroller+0x6>,-(sp)
    1538:	move.l 249d6 <BmpScroller+0x2>,-(sp)
    153e:	move.w 249d4 <BmpScroller>,-(sp)
    1544:	jsr a80 <Scrollit>(pc)
    1548:	lea 68(sp),sp
    154c:	bra.w 2266 <MainLoop+0xe3a>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
    1550:	moveq #56,d2
    1552:	add.l d2,d1
    1554:	add.w d1,d1
    1556:	add.w d1,d1
    1558:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    155a:	move.l d0,d2
    155c:	clr.w d2
    155e:	swap d2
    1560:	move.w d2,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
    1564:	addq.w #2,d1
    1566:	move.w d1,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    156a:	move.w d0,6(a2)
        addr += Bpl;
    156e:	add.l d4,d0
    for (USHORT i = 0; i < numPlanes; i++)
    1570:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
    1572:	addq.l #8,a2
    for (USHORT i = 0; i < numPlanes; i++)
    1574:	moveq #0,d1
    1576:	move.w a0,d1
    1578:	cmp.l d3,d1
    157a:	blt.s 1550 <MainLoop+0x124>
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[0].X, BobTarget[0].Y, 32, 32);
    157c:	pea 20 <_start+0x20>
    1580:	pea 20 <_start+0x20>
    1584:	lea 6a9a <BobTarget>,a4
    158a:	move.l 6a9e <BobTarget+0x4>,-(sp)
    1590:	move.l (a4),-(sp)
    1592:	subq.l #2,sp
    1594:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    159a:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    15a0:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    15a6:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    15ac:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    15b2:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    15b8:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    15be:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    15c4:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    15ca:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    15d0:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    15d6:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    15dc:	lea 24a06 <BmpUpperPart_Buf1>,a2
    15e2:	move.w (a2),-(sp)
    15e4:	lea ec0 <ClearBitmapPart>(pc),a3
    15e8:	jsr (a3)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[1].X, BobTarget[1].Y, 32, 32);
    15ea:	lea 68(sp),sp
    15ee:	pea 20 <_start+0x20>
    15f2:	pea 20 <_start+0x20>
    15f6:	move.l 6aa6 <BobTarget+0xc>,-(sp)
    15fc:	move.l 6aa2 <BobTarget+0x8>,-(sp)
    1602:	subq.l #2,sp
    1604:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    160a:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1610:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    1616:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    161c:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1622:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1628:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    162e:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    1634:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    163a:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    1640:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    1646:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    164c:	move.w (a2),-(sp)
    164e:	jsr (a3)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[2].X, BobTarget[2].Y, 32, 32);
    1650:	lea 68(sp),sp
    1654:	pea 20 <_start+0x20>
    1658:	pea 20 <_start+0x20>
    165c:	move.l 6aae <BobTarget+0x14>,-(sp)
    1662:	move.l 6aaa <BobTarget+0x10>,-(sp)
    1668:	subq.l #2,sp
    166a:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1670:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1676:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    167c:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    1682:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1688:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    168e:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    1694:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    169a:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    16a0:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    16a6:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    16ac:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    16b2:	move.w (a2),-(sp)
    16b4:	jsr (a3)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[3].X, BobTarget[3].Y, 32, 32);
    16b6:	lea 68(sp),sp
    16ba:	pea 20 <_start+0x20>
    16be:	pea 20 <_start+0x20>
    16c2:	move.l 6ab6 <BobTarget+0x1c>,-(sp)
    16c8:	move.l 6ab2 <BobTarget+0x18>,-(sp)
    16ce:	subq.l #2,sp
    16d0:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    16d6:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    16dc:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    16e2:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    16e8:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    16ee:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    16f4:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    16fa:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    1700:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    1706:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    170c:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    1712:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    1718:	move.w (a2),-(sp)
    171a:	jsr (a3)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[4].X, BobTarget[4].Y, 32, 32);
    171c:	lea 68(sp),sp
    1720:	pea 20 <_start+0x20>
    1724:	pea 20 <_start+0x20>
    1728:	move.l 6abe <BobTarget+0x24>,-(sp)
    172e:	move.l 6aba <BobTarget+0x20>,-(sp)
    1734:	subq.l #2,sp
    1736:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    173c:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1742:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    1748:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    174e:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1754:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    175a:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    1760:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    1766:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    176c:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    1772:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    1778:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    177e:	move.w (a2),-(sp)
    1780:	jsr (a3)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[5].X, BobTarget[5].Y, 32, 32);
    1782:	lea 68(sp),sp
    1786:	pea 20 <_start+0x20>
    178a:	pea 20 <_start+0x20>
    178e:	move.l 6ac6 <BobTarget+0x2c>,-(sp)
    1794:	move.l 6ac2 <BobTarget+0x28>,-(sp)
    179a:	subq.l #2,sp
    179c:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    17a2:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    17a8:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    17ae:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    17b4:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    17ba:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    17c0:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    17c6:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    17cc:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    17d2:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    17d8:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    17de:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    17e4:	move.w (a2),-(sp)
    17e6:	jsr (a3)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[6].X, BobTarget[6].Y, 32, 32);
    17e8:	lea 68(sp),sp
    17ec:	pea 20 <_start+0x20>
    17f0:	pea 20 <_start+0x20>
    17f4:	move.l 6ace <BobTarget+0x34>,-(sp)
    17fa:	move.l 6aca <BobTarget+0x30>,-(sp)
    1800:	subq.l #2,sp
    1802:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1808:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    180e:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    1814:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    181a:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1820:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1826:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    182c:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    1832:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    1838:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    183e:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    1844:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    184a:	move.w (a2),-(sp)
    184c:	jsr (a3)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[7].X, BobTarget[7].Y, 32, 32);
    184e:	lea 68(sp),sp
    1852:	pea 20 <_start+0x20>
    1856:	pea 20 <_start+0x20>
    185a:	move.l 6ad6 <BobTarget+0x3c>,-(sp)
    1860:	move.l 6ad2 <BobTarget+0x38>,-(sp)
    1866:	subq.l #2,sp
    1868:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    186e:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1874:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    187a:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    1880:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1886:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    188c:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    1892:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    1898:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    189e:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    18a4:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    18aa:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    18b0:	move.w (a2),-(sp)
    18b2:	jsr (a3)
		MoveBobs();
    18b4:	lea 68(sp),sp
    18b8:	jsr 8c <MoveBobs>(pc)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[0], BobTarget[0], 32, 32);
    18bc:	pea 20 <_start+0x20>
    18c0:	pea 20 <_start+0x20>
    18c4:	move.l 4(a4),-(sp)
    18c8:	move.l (a4),-(sp)
    18ca:	move.l 4a18 <BobSource+0x4>,-(sp)
    18d0:	move.l 4a14 <BobSource>,-(sp)
    18d6:	subq.l #2,sp
    18d8:	move.l 2496c <BmpCookieMask+0x2e>,-(sp)
    18de:	move.l 24968 <BmpCookieMask+0x2a>,-(sp)
    18e4:	move.l 24964 <BmpCookieMask+0x26>,-(sp)
    18ea:	move.l 24960 <BmpCookieMask+0x22>,-(sp)
    18f0:	move.l 2495c <BmpCookieMask+0x1e>,-(sp)
    18f6:	move.l 24958 <BmpCookieMask+0x1a>,-(sp)
    18fc:	move.l 24954 <BmpCookieMask+0x16>,-(sp)
    1902:	move.l 24950 <BmpCookieMask+0x12>,-(sp)
    1908:	move.l 2494c <BmpCookieMask+0xe>,-(sp)
    190e:	move.l 24948 <BmpCookieMask+0xa>,-(sp)
    1914:	move.l 24944 <BmpCookieMask+0x6>,-(sp)
    191a:	move.l 24940 <BmpCookieMask+0x2>,-(sp)
    1920:	lea 2493e <BmpCookieMask>,a3
    1926:	move.w (a3),-(sp)
    1928:	subq.l #2,sp
    192a:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1930:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1936:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    193c:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    1942:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1948:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    194e:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    1954:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    195a:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    1960:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    1966:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    196c:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    1972:	move.w (a2),-(sp)
    1974:	subq.l #2,sp
    1976:	move.l 2499e <BmpCookie+0x2e>,-(sp)
    197c:	move.l 2499a <BmpCookie+0x2a>,-(sp)
    1982:	move.l 24996 <BmpCookie+0x26>,-(sp)
    1988:	move.l 24992 <BmpCookie+0x22>,-(sp)
    198e:	move.l 2498e <BmpCookie+0x1e>,-(sp)
    1994:	move.l 2498a <BmpCookie+0x1a>,-(sp)
    199a:	move.l 24986 <BmpCookie+0x16>,-(sp)
    19a0:	move.l 24982 <BmpCookie+0x12>,-(sp)
    19a6:	move.l 2497e <BmpCookie+0xe>,-(sp)
    19ac:	move.l 2497a <BmpCookie+0xa>,-(sp)
    19b2:	move.l 24976 <BmpCookie+0x6>,-(sp)
    19b8:	move.l 24972 <BmpCookie+0x2>,-(sp)
    19be:	lea 24970 <BmpCookie>,a5
    19c4:	move.w (a5),-(sp)
    19c6:	lea 1068 <BetterBlit>(pc),a4
    19ca:	jsr (a4)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[1], BobTarget[1], 32, 32);
    19cc:	lea 180(sp),sp
    19d0:	pea 20 <_start+0x20>
    19d4:	pea 20 <_start+0x20>
    19d8:	move.l 6aa6 <BobTarget+0xc>,-(sp)
    19de:	move.l 6aa2 <BobTarget+0x8>,-(sp)
    19e4:	move.l 4a20 <BobSource+0xc>,-(sp)
    19ea:	move.l 4a1c <BobSource+0x8>,-(sp)
    19f0:	subq.l #2,sp
    19f2:	move.l 2496c <BmpCookieMask+0x2e>,-(sp)
    19f8:	move.l 24968 <BmpCookieMask+0x2a>,-(sp)
    19fe:	move.l 24964 <BmpCookieMask+0x26>,-(sp)
    1a04:	move.l 24960 <BmpCookieMask+0x22>,-(sp)
    1a0a:	move.l 2495c <BmpCookieMask+0x1e>,-(sp)
    1a10:	move.l 24958 <BmpCookieMask+0x1a>,-(sp)
    1a16:	move.l 24954 <BmpCookieMask+0x16>,-(sp)
    1a1c:	move.l 24950 <BmpCookieMask+0x12>,-(sp)
    1a22:	move.l 2494c <BmpCookieMask+0xe>,-(sp)
    1a28:	move.l 24948 <BmpCookieMask+0xa>,-(sp)
    1a2e:	move.l 24944 <BmpCookieMask+0x6>,-(sp)
    1a34:	move.l 24940 <BmpCookieMask+0x2>,-(sp)
    1a3a:	move.w (a3),-(sp)
    1a3c:	subq.l #2,sp
    1a3e:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1a44:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1a4a:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    1a50:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    1a56:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1a5c:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1a62:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    1a68:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    1a6e:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    1a74:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    1a7a:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    1a80:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    1a86:	move.w (a2),-(sp)
    1a88:	subq.l #2,sp
    1a8a:	move.l 2499e <BmpCookie+0x2e>,-(sp)
    1a90:	move.l 2499a <BmpCookie+0x2a>,-(sp)
    1a96:	move.l 24996 <BmpCookie+0x26>,-(sp)
    1a9c:	move.l 24992 <BmpCookie+0x22>,-(sp)
    1aa2:	move.l 2498e <BmpCookie+0x1e>,-(sp)
    1aa8:	move.l 2498a <BmpCookie+0x1a>,-(sp)
    1aae:	move.l 24986 <BmpCookie+0x16>,-(sp)
    1ab4:	move.l 24982 <BmpCookie+0x12>,-(sp)
    1aba:	move.l 2497e <BmpCookie+0xe>,-(sp)
    1ac0:	move.l 2497a <BmpCookie+0xa>,-(sp)
    1ac6:	move.l 24976 <BmpCookie+0x6>,-(sp)
    1acc:	move.l 24972 <BmpCookie+0x2>,-(sp)
    1ad2:	move.w (a5),-(sp)
    1ad4:	jsr (a4)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[2], BobTarget[2], 32, 32);
    1ad6:	lea 180(sp),sp
    1ada:	pea 20 <_start+0x20>
    1ade:	pea 20 <_start+0x20>
    1ae2:	move.l 6aae <BobTarget+0x14>,-(sp)
    1ae8:	move.l 6aaa <BobTarget+0x10>,-(sp)
    1aee:	move.l 4a28 <BobSource+0x14>,-(sp)
    1af4:	move.l 4a24 <BobSource+0x10>,-(sp)
    1afa:	subq.l #2,sp
    1afc:	move.l 2496c <BmpCookieMask+0x2e>,-(sp)
    1b02:	move.l 24968 <BmpCookieMask+0x2a>,-(sp)
    1b08:	move.l 24964 <BmpCookieMask+0x26>,-(sp)
    1b0e:	move.l 24960 <BmpCookieMask+0x22>,-(sp)
    1b14:	move.l 2495c <BmpCookieMask+0x1e>,-(sp)
    1b1a:	move.l 24958 <BmpCookieMask+0x1a>,-(sp)
    1b20:	move.l 24954 <BmpCookieMask+0x16>,-(sp)
    1b26:	move.l 24950 <BmpCookieMask+0x12>,-(sp)
    1b2c:	move.l 2494c <BmpCookieMask+0xe>,-(sp)
    1b32:	move.l 24948 <BmpCookieMask+0xa>,-(sp)
    1b38:	move.l 24944 <BmpCookieMask+0x6>,-(sp)
    1b3e:	move.l 24940 <BmpCookieMask+0x2>,-(sp)
    1b44:	move.w (a3),-(sp)
    1b46:	subq.l #2,sp
    1b48:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1b4e:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1b54:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    1b5a:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    1b60:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1b66:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1b6c:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    1b72:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    1b78:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    1b7e:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    1b84:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    1b8a:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    1b90:	move.w (a2),-(sp)
    1b92:	subq.l #2,sp
    1b94:	move.l 2499e <BmpCookie+0x2e>,-(sp)
    1b9a:	move.l 2499a <BmpCookie+0x2a>,-(sp)
    1ba0:	move.l 24996 <BmpCookie+0x26>,-(sp)
    1ba6:	move.l 24992 <BmpCookie+0x22>,-(sp)
    1bac:	move.l 2498e <BmpCookie+0x1e>,-(sp)
    1bb2:	move.l 2498a <BmpCookie+0x1a>,-(sp)
    1bb8:	move.l 24986 <BmpCookie+0x16>,-(sp)
    1bbe:	move.l 24982 <BmpCookie+0x12>,-(sp)
    1bc4:	move.l 2497e <BmpCookie+0xe>,-(sp)
    1bca:	move.l 2497a <BmpCookie+0xa>,-(sp)
    1bd0:	move.l 24976 <BmpCookie+0x6>,-(sp)
    1bd6:	move.l 24972 <BmpCookie+0x2>,-(sp)
    1bdc:	move.w (a5),-(sp)
    1bde:	jsr (a4)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[3], BobTarget[3], 32, 32);
    1be0:	lea 180(sp),sp
    1be4:	pea 20 <_start+0x20>
    1be8:	pea 20 <_start+0x20>
    1bec:	move.l 6ab6 <BobTarget+0x1c>,-(sp)
    1bf2:	move.l 6ab2 <BobTarget+0x18>,-(sp)
    1bf8:	move.l 4a30 <BobSource+0x1c>,-(sp)
    1bfe:	move.l 4a2c <BobSource+0x18>,-(sp)
    1c04:	subq.l #2,sp
    1c06:	move.l 2496c <BmpCookieMask+0x2e>,-(sp)
    1c0c:	move.l 24968 <BmpCookieMask+0x2a>,-(sp)
    1c12:	move.l 24964 <BmpCookieMask+0x26>,-(sp)
    1c18:	move.l 24960 <BmpCookieMask+0x22>,-(sp)
    1c1e:	move.l 2495c <BmpCookieMask+0x1e>,-(sp)
    1c24:	move.l 24958 <BmpCookieMask+0x1a>,-(sp)
    1c2a:	move.l 24954 <BmpCookieMask+0x16>,-(sp)
    1c30:	move.l 24950 <BmpCookieMask+0x12>,-(sp)
    1c36:	move.l 2494c <BmpCookieMask+0xe>,-(sp)
    1c3c:	move.l 24948 <BmpCookieMask+0xa>,-(sp)
    1c42:	move.l 24944 <BmpCookieMask+0x6>,-(sp)
    1c48:	move.l 24940 <BmpCookieMask+0x2>,-(sp)
    1c4e:	move.w (a3),-(sp)
    1c50:	subq.l #2,sp
    1c52:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1c58:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1c5e:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    1c64:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    1c6a:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1c70:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1c76:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    1c7c:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    1c82:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    1c88:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    1c8e:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    1c94:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    1c9a:	move.w (a2),-(sp)
    1c9c:	subq.l #2,sp
    1c9e:	move.l 2499e <BmpCookie+0x2e>,-(sp)
    1ca4:	move.l 2499a <BmpCookie+0x2a>,-(sp)
    1caa:	move.l 24996 <BmpCookie+0x26>,-(sp)
    1cb0:	move.l 24992 <BmpCookie+0x22>,-(sp)
    1cb6:	move.l 2498e <BmpCookie+0x1e>,-(sp)
    1cbc:	move.l 2498a <BmpCookie+0x1a>,-(sp)
    1cc2:	move.l 24986 <BmpCookie+0x16>,-(sp)
    1cc8:	move.l 24982 <BmpCookie+0x12>,-(sp)
    1cce:	move.l 2497e <BmpCookie+0xe>,-(sp)
    1cd4:	move.l 2497a <BmpCookie+0xa>,-(sp)
    1cda:	move.l 24976 <BmpCookie+0x6>,-(sp)
    1ce0:	move.l 24972 <BmpCookie+0x2>,-(sp)
    1ce6:	move.w (a5),-(sp)
    1ce8:	jsr (a4)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[4], BobTarget[4], 32, 32);
    1cea:	lea 180(sp),sp
    1cee:	pea 20 <_start+0x20>
    1cf2:	pea 20 <_start+0x20>
    1cf6:	move.l 6abe <BobTarget+0x24>,-(sp)
    1cfc:	move.l 6aba <BobTarget+0x20>,-(sp)
    1d02:	move.l 4a38 <BobSource+0x24>,-(sp)
    1d08:	move.l 4a34 <BobSource+0x20>,-(sp)
    1d0e:	subq.l #2,sp
    1d10:	move.l 2496c <BmpCookieMask+0x2e>,-(sp)
    1d16:	move.l 24968 <BmpCookieMask+0x2a>,-(sp)
    1d1c:	move.l 24964 <BmpCookieMask+0x26>,-(sp)
    1d22:	move.l 24960 <BmpCookieMask+0x22>,-(sp)
    1d28:	move.l 2495c <BmpCookieMask+0x1e>,-(sp)
    1d2e:	move.l 24958 <BmpCookieMask+0x1a>,-(sp)
    1d34:	move.l 24954 <BmpCookieMask+0x16>,-(sp)
    1d3a:	move.l 24950 <BmpCookieMask+0x12>,-(sp)
    1d40:	move.l 2494c <BmpCookieMask+0xe>,-(sp)
    1d46:	move.l 24948 <BmpCookieMask+0xa>,-(sp)
    1d4c:	move.l 24944 <BmpCookieMask+0x6>,-(sp)
    1d52:	move.l 24940 <BmpCookieMask+0x2>,-(sp)
    1d58:	move.w (a3),-(sp)
    1d5a:	subq.l #2,sp
    1d5c:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1d62:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1d68:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    1d6e:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    1d74:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1d7a:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1d80:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    1d86:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    1d8c:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    1d92:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    1d98:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    1d9e:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    1da4:	move.w (a2),-(sp)
    1da6:	subq.l #2,sp
    1da8:	move.l 2499e <BmpCookie+0x2e>,-(sp)
    1dae:	move.l 2499a <BmpCookie+0x2a>,-(sp)
    1db4:	move.l 24996 <BmpCookie+0x26>,-(sp)
    1dba:	move.l 24992 <BmpCookie+0x22>,-(sp)
    1dc0:	move.l 2498e <BmpCookie+0x1e>,-(sp)
    1dc6:	move.l 2498a <BmpCookie+0x1a>,-(sp)
    1dcc:	move.l 24986 <BmpCookie+0x16>,-(sp)
    1dd2:	move.l 24982 <BmpCookie+0x12>,-(sp)
    1dd8:	move.l 2497e <BmpCookie+0xe>,-(sp)
    1dde:	move.l 2497a <BmpCookie+0xa>,-(sp)
    1de4:	move.l 24976 <BmpCookie+0x6>,-(sp)
    1dea:	move.l 24972 <BmpCookie+0x2>,-(sp)
    1df0:	move.w (a5),-(sp)
    1df2:	jsr (a4)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[5], BobTarget[5], 32, 32);
    1df4:	lea 180(sp),sp
    1df8:	pea 20 <_start+0x20>
    1dfc:	pea 20 <_start+0x20>
    1e00:	move.l 6ac6 <BobTarget+0x2c>,-(sp)
    1e06:	move.l 6ac2 <BobTarget+0x28>,-(sp)
    1e0c:	move.l 4a40 <BobSource+0x2c>,-(sp)
    1e12:	move.l 4a3c <BobSource+0x28>,-(sp)
    1e18:	subq.l #2,sp
    1e1a:	move.l 2496c <BmpCookieMask+0x2e>,-(sp)
    1e20:	move.l 24968 <BmpCookieMask+0x2a>,-(sp)
    1e26:	move.l 24964 <BmpCookieMask+0x26>,-(sp)
    1e2c:	move.l 24960 <BmpCookieMask+0x22>,-(sp)
    1e32:	move.l 2495c <BmpCookieMask+0x1e>,-(sp)
    1e38:	move.l 24958 <BmpCookieMask+0x1a>,-(sp)
    1e3e:	move.l 24954 <BmpCookieMask+0x16>,-(sp)
    1e44:	move.l 24950 <BmpCookieMask+0x12>,-(sp)
    1e4a:	move.l 2494c <BmpCookieMask+0xe>,-(sp)
    1e50:	move.l 24948 <BmpCookieMask+0xa>,-(sp)
    1e56:	move.l 24944 <BmpCookieMask+0x6>,-(sp)
    1e5c:	move.l 24940 <BmpCookieMask+0x2>,-(sp)
    1e62:	move.w (a3),-(sp)
    1e64:	subq.l #2,sp
    1e66:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1e6c:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1e72:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    1e78:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    1e7e:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1e84:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1e8a:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    1e90:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    1e96:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    1e9c:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    1ea2:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    1ea8:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    1eae:	move.w (a2),-(sp)
    1eb0:	subq.l #2,sp
    1eb2:	move.l 2499e <BmpCookie+0x2e>,-(sp)
    1eb8:	move.l 2499a <BmpCookie+0x2a>,-(sp)
    1ebe:	move.l 24996 <BmpCookie+0x26>,-(sp)
    1ec4:	move.l 24992 <BmpCookie+0x22>,-(sp)
    1eca:	move.l 2498e <BmpCookie+0x1e>,-(sp)
    1ed0:	move.l 2498a <BmpCookie+0x1a>,-(sp)
    1ed6:	move.l 24986 <BmpCookie+0x16>,-(sp)
    1edc:	move.l 24982 <BmpCookie+0x12>,-(sp)
    1ee2:	move.l 2497e <BmpCookie+0xe>,-(sp)
    1ee8:	move.l 2497a <BmpCookie+0xa>,-(sp)
    1eee:	move.l 24976 <BmpCookie+0x6>,-(sp)
    1ef4:	move.l 24972 <BmpCookie+0x2>,-(sp)
    1efa:	move.w (a5),-(sp)
    1efc:	jsr (a4)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[6], BobTarget[6], 32, 32);
    1efe:	lea 180(sp),sp
    1f02:	pea 20 <_start+0x20>
    1f06:	pea 20 <_start+0x20>
    1f0a:	move.l 6ace <BobTarget+0x34>,-(sp)
    1f10:	move.l 6aca <BobTarget+0x30>,-(sp)
    1f16:	move.l 4a48 <BobSource+0x34>,-(sp)
    1f1c:	move.l 4a44 <BobSource+0x30>,-(sp)
    1f22:	subq.l #2,sp
    1f24:	move.l 2496c <BmpCookieMask+0x2e>,-(sp)
    1f2a:	move.l 24968 <BmpCookieMask+0x2a>,-(sp)
    1f30:	move.l 24964 <BmpCookieMask+0x26>,-(sp)
    1f36:	move.l 24960 <BmpCookieMask+0x22>,-(sp)
    1f3c:	move.l 2495c <BmpCookieMask+0x1e>,-(sp)
    1f42:	move.l 24958 <BmpCookieMask+0x1a>,-(sp)
    1f48:	move.l 24954 <BmpCookieMask+0x16>,-(sp)
    1f4e:	move.l 24950 <BmpCookieMask+0x12>,-(sp)
    1f54:	move.l 2494c <BmpCookieMask+0xe>,-(sp)
    1f5a:	move.l 24948 <BmpCookieMask+0xa>,-(sp)
    1f60:	move.l 24944 <BmpCookieMask+0x6>,-(sp)
    1f66:	move.l 24940 <BmpCookieMask+0x2>,-(sp)
    1f6c:	move.w (a3),-(sp)
    1f6e:	subq.l #2,sp
    1f70:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1f76:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1f7c:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    1f82:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    1f88:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1f8e:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1f94:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    1f9a:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    1fa0:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    1fa6:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    1fac:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    1fb2:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    1fb8:	move.w (a2),-(sp)
    1fba:	subq.l #2,sp
    1fbc:	move.l 2499e <BmpCookie+0x2e>,-(sp)
    1fc2:	move.l 2499a <BmpCookie+0x2a>,-(sp)
    1fc8:	move.l 24996 <BmpCookie+0x26>,-(sp)
    1fce:	move.l 24992 <BmpCookie+0x22>,-(sp)
    1fd4:	move.l 2498e <BmpCookie+0x1e>,-(sp)
    1fda:	move.l 2498a <BmpCookie+0x1a>,-(sp)
    1fe0:	move.l 24986 <BmpCookie+0x16>,-(sp)
    1fe6:	move.l 24982 <BmpCookie+0x12>,-(sp)
    1fec:	move.l 2497e <BmpCookie+0xe>,-(sp)
    1ff2:	move.l 2497a <BmpCookie+0xa>,-(sp)
    1ff8:	move.l 24976 <BmpCookie+0x6>,-(sp)
    1ffe:	move.l 24972 <BmpCookie+0x2>,-(sp)
    2004:	move.w (a5),-(sp)
    2006:	jsr (a4)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[7], BobTarget[7], 32, 32);
    2008:	lea 180(sp),sp
    200c:	pea 20 <_start+0x20>
    2010:	pea 20 <_start+0x20>
    2014:	move.l 6ad6 <BobTarget+0x3c>,-(sp)
    201a:	move.l 6ad2 <BobTarget+0x38>,-(sp)
    2020:	move.l 4a50 <BobSource+0x3c>,-(sp)
    2026:	move.l 4a4c <BobSource+0x38>,-(sp)
    202c:	subq.l #2,sp
    202e:	move.l 2496c <BmpCookieMask+0x2e>,-(sp)
    2034:	move.l 24968 <BmpCookieMask+0x2a>,-(sp)
    203a:	move.l 24964 <BmpCookieMask+0x26>,-(sp)
    2040:	move.l 24960 <BmpCookieMask+0x22>,-(sp)
    2046:	move.l 2495c <BmpCookieMask+0x1e>,-(sp)
    204c:	move.l 24958 <BmpCookieMask+0x1a>,-(sp)
    2052:	move.l 24954 <BmpCookieMask+0x16>,-(sp)
    2058:	move.l 24950 <BmpCookieMask+0x12>,-(sp)
    205e:	move.l 2494c <BmpCookieMask+0xe>,-(sp)
    2064:	move.l 24948 <BmpCookieMask+0xa>,-(sp)
    206a:	move.l 24944 <BmpCookieMask+0x6>,-(sp)
    2070:	move.l 24940 <BmpCookieMask+0x2>,-(sp)
    2076:	move.w (a3),-(sp)
    2078:	subq.l #2,sp
    207a:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2080:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2086:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    208c:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    2092:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2098:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    209e:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    20a4:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    20aa:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    20b0:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    20b6:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    20bc:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    20c2:	move.w 24a06 <BmpUpperPart_Buf1>,-(sp)
    20c8:	subq.l #2,sp
    20ca:	move.l 2499e <BmpCookie+0x2e>,-(sp)
    20d0:	move.l 2499a <BmpCookie+0x2a>,-(sp)
    20d6:	move.l 24996 <BmpCookie+0x26>,-(sp)
    20dc:	move.l 24992 <BmpCookie+0x22>,-(sp)
    20e2:	move.l 2498e <BmpCookie+0x1e>,-(sp)
    20e8:	move.l 2498a <BmpCookie+0x1a>,-(sp)
    20ee:	move.l 24986 <BmpCookie+0x16>,-(sp)
    20f4:	move.l 24982 <BmpCookie+0x12>,-(sp)
    20fa:	move.l 2497e <BmpCookie+0xe>,-(sp)
    2100:	move.l 2497a <BmpCookie+0xa>,-(sp)
    2106:	move.l 24976 <BmpCookie+0x6>,-(sp)
    210c:	move.l 24972 <BmpCookie+0x2>,-(sp)
    2112:	move.w 24970 <BmpCookie>,-(sp)
    2118:	jsr 1068 <BetterBlit>(pc)
		MoveStarfield();
    211c:	lea 180(sp),sp
    2120:	jsr 13f0 <MoveStarfield>(pc)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    2124:	move.b bfe001 <_end+0xbd94ed>,d0
	while (!MouseLeft())
    212a:	btst #6,d0
    212e:	beq.w 22a4 <MainLoop+0xe78>
		WaitVbl();
    2132:	jsr c48 <WaitVbl>(pc)
		if (ResetCopper)
    2136:	tst.w 24938 <ResetCopper>
    213c:	bne.w 1434 <MainLoop+0x8>
		CopyBitmap(BmpUpperPart_Buf1, BmpUpperPart_PF2);
    2140:	subq.l #2,sp
    2142:	move.l 24a66 <BmpUpperPart_PF2+0x2e>,-(sp)
    2148:	move.l 24a62 <BmpUpperPart_PF2+0x2a>,-(sp)
    214e:	move.l 24a5e <BmpUpperPart_PF2+0x26>,-(sp)
    2154:	move.l 24a5a <BmpUpperPart_PF2+0x22>,-(sp)
    215a:	move.l 24a56 <BmpUpperPart_PF2+0x1e>,-(sp)
    2160:	move.l 24a52 <BmpUpperPart_PF2+0x1a>,-(sp)
    2166:	move.l 24a4e <BmpUpperPart_PF2+0x16>,-(sp)
    216c:	move.l 24a4a <BmpUpperPart_PF2+0x12>,-(sp)
    2172:	move.l 24a46 <BmpUpperPart_PF2+0xe>,-(sp)
    2178:	move.l 24a42 <BmpUpperPart_PF2+0xa>,-(sp)
    217e:	move.l 24a3e <BmpUpperPart_PF2+0x6>,-(sp)
    2184:	move.l 24a3a <BmpUpperPart_PF2+0x2>,-(sp)
    218a:	move.w 24a38 <BmpUpperPart_PF2>,-(sp)
    2190:	subq.l #2,sp
    2192:	move.l 24a34 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2198:	move.l 24a30 <BmpUpperPart_Buf1+0x2a>,-(sp)
    219e:	move.l 24a2c <BmpUpperPart_Buf1+0x26>,-(sp)
    21a4:	move.l 24a28 <BmpUpperPart_Buf1+0x22>,-(sp)
    21aa:	move.l 24a24 <BmpUpperPart_Buf1+0x1e>,-(sp)
    21b0:	move.l 24a20 <BmpUpperPart_Buf1+0x1a>,-(sp)
    21b6:	move.l 24a1c <BmpUpperPart_Buf1+0x16>,-(sp)
    21bc:	move.l 24a18 <BmpUpperPart_Buf1+0x12>,-(sp)
    21c2:	move.l 24a14 <BmpUpperPart_Buf1+0xe>,-(sp)
    21c8:	move.l 24a10 <BmpUpperPart_Buf1+0xa>,-(sp)
    21ce:	move.l 24a0c <BmpUpperPart_Buf1+0x6>,-(sp)
    21d4:	move.l 24a08 <BmpUpperPart_Buf1+0x2>,-(sp)
    21da:	move.w 24a06 <BmpUpperPart_Buf1>,-(sp)
    21e0:	jsr e64 <CopyBitmap>(pc)
		if (BounceEnabled)
    21e4:	lea 104(sp),sp
    21e8:	tst.w 24936 <BounceEnabled>
    21ee:	beq.w 14a0 <MainLoop+0x74>
			if (ScrollerDir > 0)
    21f2:	move.b 6ada <ScrollerDir>,d0
    21f8:	ble.w 1476 <MainLoop+0x4a>
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
    21fc:	pea c <_start+0xc>
    2200:	movea.w #40,a0
    2204:	suba.w 24934 <ScrollerY>,a0
    220a:	move.l a0,-(sp)
    220c:	jsr 2876 <__divsi3>
    2212:	addq.l #8,sp
    2214:	move.b d0,6ada <ScrollerDir>
				if (ScrollerDir > 6)
    221a:	cmpi.b #6,d0
    221e:	ble.s 2228 <MainLoop+0xdfc>
					ScrollerDir = 6;
    2220:	move.b #6,6ada <ScrollerDir>
				if (ScrollerDir < 1)
    2228:	tst.b 6ada <ScrollerDir>
    222e:	ble.w 146a <MainLoop+0x3e>
			ScrollerY += ScrollerDir;
    2232:	move.b 6ada <ScrollerDir>,d0
    2238:	ext.w d0
    223a:	add.w d0,24934 <ScrollerY>
		if (ScrollerY >= ScrollerMax)
    2240:	movea.w 24934 <ScrollerY>,a0
    2246:	moveq #39,d0
    2248:	cmp.l a0,d0
    224a:	bge.w 14b6 <MainLoop+0x8a>
			ScrollerY = ScrollerMax;
    224e:	move.w #40,24934 <ScrollerY>
			ScrollerDir = -1;
    2256:	st 6ada <ScrollerDir>
		if (ScrollerPause < 1)
    225c:	tst.w 24932 <ScrollerPause>
    2262:	beq.w 14e2 <MainLoop+0xb6>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    2266:	moveq #0,d4
    2268:	move.w 249da <BmpScroller+0x6>,d4
    226e:	moveq #0,d3
    2270:	move.w 249d8 <BmpScroller+0x4>,d3
    2276:	movea.l 2492e <copScrollerBmpP>,a2
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    227c:	lea 27f8 <__mulsi3>,a3
    2282:	move.l d4,-(sp)
    2284:	movea.w 24934 <ScrollerY>,a0
    228a:	move.l a0,-(sp)
    228c:	jsr (a3)
    228e:	addq.l #8,sp
    2290:	move.l d0,-(sp)
    2292:	move.l d3,-(sp)
    2294:	jsr (a3)
    2296:	addq.l #8,sp
    2298:	add.l 249e2 <BmpScroller+0xe>,d0
    for (USHORT i = 0; i < numPlanes; i++)
    229e:	suba.l a0,a0
    22a0:	bra.w 1574 <MainLoop+0x148>
}
    22a4:	movem.l (sp)+,d2-d4/a2-a5
    22a8:	rts

000022aa <KPrintF>:
void KPrintF(const char* fmt, ...) {
    22aa:	lea -128(sp),sp
    22ae:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    22b2:	move.w f0ff60 <_end+0xeeb44c>,d0
    22b8:	cmpi.w #20153,d0
    22bc:	beq.s 22e0 <KPrintF+0x36>
    22be:	cmpi.w #-24562,d0
    22c2:	beq.s 22e0 <KPrintF+0x36>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    22c4:	movea.l 24b08 <SysBase>,a6
    22ca:	movea.l 144(sp),a0
    22ce:	lea 148(sp),a1
    22d2:	lea 28f2 <KPutCharX>,a2
    22d8:	suba.l a3,a3
    22da:	jsr -522(a6)
    22de:	bra.s 230a <KPrintF+0x60>
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    22e0:	movea.l 24b08 <SysBase>,a6
    22e6:	movea.l 144(sp),a0
    22ea:	lea 148(sp),a1
    22ee:	lea 2900 <PutChar>,a2
    22f4:	lea 12(sp),a3
    22f8:	jsr -522(a6)
		UaeDbgLog(86, temp);
    22fc:	move.l a3,-(sp)
    22fe:	pea 56 <_start+0x56>
    2302:	jsr f0ff60 <_end+0xeeb44c>
    2308:	addq.l #8,sp
}
    230a:	movem.l (sp)+,a2-a3/a6
    230e:	lea 128(sp),sp
    2312:	rts

00002314 <main>:
{
    2314:	movem.l d2-d3/a2-a3/a6,-(sp)
	SysBase = *((struct ExecBase **)4UL);
    2318:	movea.l 4 <_start+0x4>,a6
    231c:	move.l a6,24b08 <SysBase>
	custom = (struct Custom *)0xdff000;
    2322:	move.l #14675968,24b0e <custom>
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
    232c:	lea 433d <incbin_P61_Player_end+0x1>,a1
    2332:	moveq #0,d0
    2334:	jsr -552(a6)
    2338:	move.l d0,24b04 <GfxBase>
	if (!GfxBase)
    233e:	beq.w 2734 <main+0x420>
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    2342:	movea.l 24b08 <SysBase>,a6
    2348:	lea 434e <incbin_P61_Player_end+0x12>,a1
    234e:	moveq #0,d0
    2350:	jsr -552(a6)
    2354:	move.l d0,24b00 <DOSBase>
	if (!DOSBase)
    235a:	beq.w 2744 <main+0x430>
	KPrintF("Hello debugger from Amiga!\n");
    235e:	pea 435a <incbin_P61_Player_end+0x1e>
    2364:	jsr 22aa <KPrintF>(pc)
	Write(Output(), (APTR) "Hello console!\n", 15);
    2368:	movea.l 24b00 <DOSBase>,a6
    236e:	jsr -60(a6)
    2372:	movea.l 24b00 <DOSBase>,a6
    2378:	move.l d0,d1
    237a:	move.l #17270,d2
    2380:	moveq #15,d3
    2382:	jsr -48(a6)
	BitmapInit(&Screen, 320, 256, 3);
    2386:	pea 3 <_start+0x3>
    238a:	pea 100 <MoveBobs+0x74>
    238e:	pea 140 <MoveBobs+0xb4>
    2392:	pea 24ace <Screen>
    2398:	lea 1246 <BitmapInit>(pc),a2
    239c:	jsr (a2)
	BitmapInit(&BmpLogo, 256, 130, 3);
    239e:	pea 3 <_start+0x3>
    23a2:	pea 82 <_start+0x82>
    23a6:	pea 100 <MoveBobs+0x74>
    23aa:	pea 24a9c <BmpLogo>
    23b0:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF1, 320, 130, 3);
    23b2:	lea 36(sp),sp
    23b6:	pea 3 <_start+0x3>
    23ba:	pea 82 <_start+0x82>
    23be:	pea 140 <MoveBobs+0xb4>
    23c2:	pea 24a6a <BmpUpperPart_PF1>
    23c8:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF2, 320 + 64, 130, 3);
    23ca:	pea 3 <_start+0x3>
    23ce:	pea 82 <_start+0x82>
    23d2:	pea 180 <MoveBobs+0xf4>
    23d6:	pea 24a38 <BmpUpperPart_PF2>
    23dc:	jsr (a2)
	BitmapInit(&BmpUpperPart_Buf1, 320 + 64, 130, 3);
    23de:	lea 32(sp),sp
    23e2:	pea 3 <_start+0x3>
    23e6:	pea 82 <_start+0x82>
    23ea:	pea 180 <MoveBobs+0xf4>
    23ee:	pea 24a06 <BmpUpperPart_Buf1>
    23f4:	jsr (a2)
	BitmapInit(&BmpScroller, 320 + 32, 166, 3);
    23f6:	pea 3 <_start+0x3>
    23fa:	pea a6 <MoveBobs+0x1a>
    23fe:	pea 160 <MoveBobs+0xd4>
    2402:	pea 249d4 <BmpScroller>
    2408:	jsr (a2)
	BitmapInit(&BmpFont32, 320, 256, 3);
    240a:	lea 32(sp),sp
    240e:	pea 3 <_start+0x3>
    2412:	pea 100 <MoveBobs+0x74>
    2416:	pea 140 <MoveBobs+0xb4>
    241a:	pea 249a2 <BmpFont32>
    2420:	jsr (a2)
	BitmapInit(&BmpCookie, 320, 256, 3);
    2422:	pea 3 <_start+0x3>
    2426:	pea 100 <MoveBobs+0x74>
    242a:	pea 140 <MoveBobs+0xb4>
    242e:	pea 24970 <BmpCookie>
    2434:	jsr (a2)
	BitmapInit(&BmpCookieMask, 320, 256, 3);
    2436:	lea 32(sp),sp
    243a:	pea 3 <_start+0x3>
    243e:	pea 100 <MoveBobs+0x74>
    2442:	pea 140 <MoveBobs+0xb4>
    2446:	pea 2493e <BmpCookieMask>
    244c:	jsr (a2)
	copPtr = AllocMem(1024, MEMF_CHIP);
    244e:	movea.l 24b08 <SysBase>,a6
    2454:	move.l #1024,d0
    245a:	moveq #2,d1
    245c:	jsr -198(a6)
    2460:	move.l d0,2493a <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
    2466:	movea.l 24b08 <SysBase>,a6
    246c:	moveq #0,d0
    246e:	move.w 249e0 <BmpScroller+0xc>,d0
    2474:	move.l #65538,d1
    247a:	jsr -198(a6)
    247e:	move.l d0,249e2 <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
    2484:	lea 24a6a <BmpUpperPart_PF1>,a3
    248a:	movea.l 24b08 <SysBase>,a6
    2490:	moveq #0,d0
    2492:	move.w 24a76 <BmpUpperPart_PF1+0xc>,d0
    2498:	move.l #65538,d1
    249e:	jsr -198(a6)
    24a2:	move.l d0,24a78 <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
    24a8:	movea.l 24b08 <SysBase>,a6
    24ae:	moveq #0,d0
    24b0:	move.w 24a44 <BmpUpperPart_PF2+0xc>,d0
    24b6:	move.l #65538,d1
    24bc:	jsr -198(a6)
    24c0:	move.l d0,24a46 <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
    24c6:	movea.l 24b08 <SysBase>,a6
    24cc:	moveq #0,d0
    24ce:	move.w 24a12 <BmpUpperPart_Buf1+0xc>,d0
    24d4:	move.l #65538,d1
    24da:	jsr -198(a6)
    24de:	move.l d0,24a14 <BmpUpperPart_Buf1+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
    24e4:	move.l #27356,24aaa <BmpLogo+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
    24ee:	move.l #39838,249b0 <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
    24f8:	move.l #70560,2497e <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
    2502:	move.l #101282,2494c <BmpCookieMask+0xe>
	InitImagePlanes(&BmpUpperPart_PF1, 0);
    250c:	clr.l -(sp)
    250e:	move.l a3,-(sp)
    2510:	lea e1a <InitImagePlanes>(pc),a2
    2514:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF2, 32/8);
    2516:	pea 4 <_start+0x4>
    251a:	pea 24a38 <BmpUpperPart_PF2>
    2520:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_Buf1, 32/8);
    2522:	lea 32(sp),sp
    2526:	pea 4 <_start+0x4>
    252a:	pea 24a06 <BmpUpperPart_Buf1>
    2530:	jsr (a2)
	InitImagePlanes(&BmpScroller, 0);
    2532:	clr.l -(sp)
    2534:	pea 249d4 <BmpScroller>
    253a:	jsr (a2)
	InitImagePlanes(&BmpFont32, 0);
    253c:	clr.l -(sp)
    253e:	pea 249a2 <BmpFont32>
    2544:	jsr (a2)
	InitImagePlanes(&BmpCookie, 0);
    2546:	clr.l -(sp)
    2548:	pea 24970 <BmpCookie>
    254e:	jsr (a2)
	InitImagePlanes(&BmpCookieMask, 0);
    2550:	lea 32(sp),sp
    2554:	clr.l -(sp)
    2556:	pea 2493e <BmpCookieMask>
    255c:	jsr (a2)
	TakeSystem();
    255e:	jsr c8e <TakeSystem>(pc)
	InitStarfieldSprite();
    2562:	jsr 1280 <InitStarfieldSprite>(pc)
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
    2566:	pea 100 <MoveBobs+0x74>
    256a:	pea 82 <_start+0x82>
    256e:	clr.l -(sp)
    2570:	pea 20 <_start+0x20>
    2574:	clr.l -(sp)
    2576:	clr.l -(sp)
    2578:	subq.l #2,sp
    257a:	move.l 24a98 <BmpUpperPart_PF1+0x2e>,-(sp)
    2580:	move.l 24a94 <BmpUpperPart_PF1+0x2a>,-(sp)
    2586:	move.l 24a90 <BmpUpperPart_PF1+0x26>,-(sp)
    258c:	move.l 24a8c <BmpUpperPart_PF1+0x22>,-(sp)
    2592:	move.l 24a88 <BmpUpperPart_PF1+0x1e>,-(sp)
    2598:	move.l 24a84 <BmpUpperPart_PF1+0x1a>,-(sp)
    259e:	move.l 24a80 <BmpUpperPart_PF1+0x16>,-(sp)
    25a4:	move.l 24a7c <BmpUpperPart_PF1+0x12>,-(sp)
    25aa:	move.l 24a78 <BmpUpperPart_PF1+0xe>,-(sp)
    25b0:	move.l 24a74 <BmpUpperPart_PF1+0xa>,-(sp)
    25b6:	move.l 24a70 <BmpUpperPart_PF1+0x6>,-(sp)
    25bc:	move.l 24a6c <BmpUpperPart_PF1+0x2>,-(sp)
    25c2:	move.w (a3),-(sp)
    25c4:	subq.l #2,sp
    25c6:	move.l 24aca <BmpLogo+0x2e>,-(sp)
    25cc:	move.l 24ac6 <BmpLogo+0x2a>,-(sp)
    25d2:	move.l 24ac2 <BmpLogo+0x26>,-(sp)
    25d8:	move.l 24abe <BmpLogo+0x22>,-(sp)
    25de:	move.l 24aba <BmpLogo+0x1e>,-(sp)
    25e4:	move.l 24ab6 <BmpLogo+0x1a>,-(sp)
    25ea:	move.l 24ab2 <BmpLogo+0x16>,-(sp)
    25f0:	move.l 24aae <BmpLogo+0x12>,-(sp)
    25f6:	move.l 24aaa <BmpLogo+0xe>,-(sp)
    25fc:	move.l 24aa6 <BmpLogo+0xa>,-(sp)
    2602:	move.l 24aa2 <BmpLogo+0x6>,-(sp)
    2608:	move.l 24a9e <BmpLogo+0x2>,-(sp)
    260e:	move.w 24a9c <BmpLogo>,-(sp)
    2614:	jsr fa4 <SimpleBlit>(pc)
	WaitVbl();
    2618:	lea 136(sp),sp
    261c:	jsr c48 <WaitVbl>(pc)
	SetupCopper(copPtr);
    2620:	move.l 2493a <copPtr>,-(sp)
    2626:	jsr 24a <SetupCopper>(pc)
	custom->cop1lc = (ULONG)copPtr;
    262a:	movea.l 24b0e <custom>,a0
    2630:	move.l 2493a <copPtr>,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    2638:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
    263e:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    2644:	move.w #-30752,150(a0)
	SetInterruptHandler((APTR)interruptHandler);
    264a:	pea 11f6 <interruptHandler>(pc)
    264e:	jsr c2e <SetInterruptHandler>(pc)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
    2652:	movea.l 24b0e <custom>,a0
    2658:	move.w #-16352,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
    265e:	move.w #32,156(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
    2664:	move.w #-24576,154(a0)
	if (p61Init(module) != 0)
    266a:	pea 203a4 <incbin_module_start>
    2670:	jsr 11b2 <p61Init>(pc)
    2674:	lea 12(sp),sp
    2678:	tst.l d0
    267a:	bne.w 2750 <main+0x43c>
	MainLoop();
    267e:	jsr 142c <MainLoop>(pc)
	p61End();
    2682:	jsr 1224 <p61End>(pc)
	FreeMem(copPtr, 1024);
    2686:	movea.l 24b08 <SysBase>,a6
    268c:	movea.l 2493a <copPtr>,a1
    2692:	move.l #1024,d0
    2698:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    269c:	movea.l 24b08 <SysBase>,a6
    26a2:	movea.l 249e2 <BmpScroller+0xe>,a1
    26a8:	moveq #0,d0
    26aa:	move.w 249e0 <BmpScroller+0xc>,d0
    26b0:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    26b4:	movea.l 24b08 <SysBase>,a6
    26ba:	movea.l 24a78 <BmpUpperPart_PF1+0xe>,a1
    26c0:	moveq #0,d0
    26c2:	move.w 24a76 <BmpUpperPart_PF1+0xc>,d0
    26c8:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    26cc:	movea.l 24b08 <SysBase>,a6
    26d2:	movea.l 24a46 <BmpUpperPart_PF2+0xe>,a1
    26d8:	moveq #0,d0
    26da:	move.w 24a44 <BmpUpperPart_PF2+0xc>,d0
    26e0:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_Buf1.ImageData, BmpUpperPart_PF2.Btot);
    26e4:	movea.l 24b08 <SysBase>,a6
    26ea:	movea.l 24a14 <BmpUpperPart_Buf1+0xe>,a1
    26f0:	moveq #0,d0
    26f2:	move.w 24a44 <BmpUpperPart_PF2+0xc>,d0
    26f8:	jsr -210(a6)
	CloseLibrary((struct Library *)DOSBase);
    26fc:	movea.l 24b08 <SysBase>,a6
    2702:	movea.l 24b00 <DOSBase>,a1
    2708:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    270c:	movea.l 24b08 <SysBase>,a6
    2712:	movea.l 24b04 <GfxBase>,a1
    2718:	jsr -414(a6)
	FreeSystem();
    271c:	jsr d5a <FreeSystem>(pc)
	Exit(0);
    2720:	movea.l 24b00 <DOSBase>,a6
    2726:	moveq #0,d1
    2728:	jsr -144(a6)
}
    272c:	moveq #0,d0
    272e:	movem.l (sp)+,d2-d3/a2-a3/a6
    2732:	rts
		Exit(0);
    2734:	movea.l 24b00 <DOSBase>,a6
    273a:	moveq #0,d1
    273c:	jsr -144(a6)
    2740:	bra.w 2342 <main+0x2e>
		Exit(0);
    2744:	movea.l d0,a6
    2746:	moveq #0,d1
    2748:	jsr -144(a6)
    274c:	bra.w 235e <main+0x4a>
		KPrintF("p61Init failed!\n");
    2750:	pea 4386 <incbin_P61_Player_end+0x4a>
    2756:	jsr 22aa <KPrintF>(pc)
    275a:	addq.l #4,sp
    275c:	bra.w 267e <main+0x36a>

00002760 <strlen>:
unsigned long strlen(const char* s) {
    2760:	movea.l 4(sp),a0
	unsigned long t=0;
    2764:	moveq #0,d0
    2766:	bra.s 276a <strlen+0xa>
		t++;
    2768:	addq.l #1,d0
	while(*s++)
    276a:	tst.b (a0)+
    276c:	bne.s 2768 <strlen+0x8>
}
    276e:	rts

00002770 <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    2770:	move.l d2,-(sp)
    2772:	move.l 8(sp),d0
    2776:	move.l 12(sp),d2
    277a:	move.l 16(sp),d1
	unsigned char *ptr = (unsigned char *)dest;
    277e:	movea.l d0,a0
    2780:	bra.s 2786 <memset+0x16>
		*ptr++ = val;
    2782:	move.b d2,(a0)+
	while(len-- > 0)
    2784:	move.l a1,d1
    2786:	movea.l d1,a1
    2788:	subq.l #1,a1
    278a:	tst.l d1
    278c:	bne.s 2782 <memset+0x12>
}
    278e:	move.l (sp)+,d2
    2790:	rts

00002792 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    2792:	move.l d2,-(sp)
    2794:	move.l 8(sp),d0
    2798:	movea.l 12(sp),a1
    279c:	move.l 16(sp),d1
	char *d = (char *)dest;
    27a0:	movea.l d0,a0
    27a2:	bra.s 27a8 <memcpy+0x16>
		*d++ = *s++;
    27a4:	move.b (a1)+,(a0)+
	while(len--)
    27a6:	move.l d2,d1
    27a8:	move.l d1,d2
    27aa:	subq.l #1,d2
    27ac:	tst.l d1
    27ae:	bne.s 27a4 <memcpy+0x12>
}
    27b0:	move.l (sp)+,d2
    27b2:	rts

000027b4 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    27b4:	move.l d2,-(sp)
    27b6:	move.l 8(sp),d0
    27ba:	movea.l 12(sp),a0
    27be:	move.l 16(sp),d1
	if (d < s) {
    27c2:	cmpa.l d0,a0
    27c4:	bhi.s 27e0 <memmove+0x2c>
		const char *lasts = s + (len - 1);
    27c6:	movea.l d1,a1
    27c8:	subq.l #1,a1
    27ca:	adda.l a1,a0
		char *lastd = d + (len - 1);
    27cc:	adda.l d0,a1
		while (len--)
    27ce:	bra.s 27ec <memmove+0x38>
			*d++ = *s++;
    27d0:	move.b (a0)+,(a1)+
		while (len--)
    27d2:	move.l d2,d1
    27d4:	move.l d1,d2
    27d6:	subq.l #1,d2
    27d8:	tst.l d1
    27da:	bne.s 27d0 <memmove+0x1c>
}
    27dc:	move.l (sp)+,d2
    27de:	rts
	char *d = dest;
    27e0:	movea.l d0,a1
    27e2:	bra.s 27d4 <memmove+0x20>
			*lastd-- = *lasts--;
    27e4:	move.b (a0),(a1)
    27e6:	subq.l #1,a1
    27e8:	subq.l #1,a0
		while (len--)
    27ea:	move.l d2,d1
    27ec:	move.l d1,d2
    27ee:	subq.l #1,d2
    27f0:	tst.l d1
    27f2:	bne.s 27e4 <memmove+0x30>
    27f4:	bra.s 27dc <memmove+0x28>
    27f6:	nop

000027f8 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    27f8:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    27fc:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2800:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    2804:	mulu.w 8(sp),d1
	addw	d1, d0
    2808:	add.w d1,d0
	swap	d0
    280a:	swap d0
	clrw	d0
    280c:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    280e:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    2812:	mulu.w 10(sp),d1
	addl	d1, d0
    2816:	add.l d1,d0
	rts
    2818:	rts

0000281a <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    281a:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    281c:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    2820:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    2824:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    282a:	bcc.s 2842 <__udivsi3+0x28>
	movel	d0, d2
    282c:	move.l d0,d2
	clrw	d2
    282e:	clr.w d2
	swap	d2
    2830:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    2832:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    2834:	move.w d2,d0
	swap	d0
    2836:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    2838:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    283c:	divu.w d1,d2
	movew	d2, d0
    283e:	move.w d2,d0
	jra	6f
    2840:	bra.s 2872 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    2842:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    2844:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    2846:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    2848:	cmpi.l #65536,d1
	jcc	4b
    284e:	bcc.s 2844 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    2850:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    2852:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    2858:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    285a:	mulu.w d0,d1
	swap	d2
    285c:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    285e:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    2860:	swap d2
	tstw	d2		/* high part 17 bits? */
    2862:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    2864:	bne.s 2870 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    2866:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    2868:	bcs.s 2870 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    286a:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    286e:	bls.s 2872 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    2870:	subq.l #1,d0

6:	movel	sp@+, d2
    2872:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    2874:	rts

00002876 <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    2876:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    2878:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    287a:	move.l 12(sp),d1
	jpl	1f
    287e:	bpl.s 2884 <__divsi3+0xe>
	negl	d1
    2880:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    2882:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    2884:	move.l 8(sp),d0
	jpl	2f
    2888:	bpl.s 288e <__divsi3+0x18>
	negl	d0
    288a:	neg.l d0
	negb	d2
    288c:	neg.b d2

2:	movel	d1, sp@-
    288e:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2890:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    2892:	bsr.s 281a <__udivsi3>
	addql	#8, sp
    2894:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    2896:	tst.b d2
	jpl	3f
    2898:	bpl.s 289c <__divsi3+0x26>
	negl	d0
    289a:	neg.l d0

3:	movel	sp@+, d2
    289c:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    289e:	rts

000028a0 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    28a0:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    28a4:	move.l 4(sp),d0
	movel	d1, sp@-
    28a8:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    28aa:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    28ac:	bsr.s 2876 <__divsi3>
	addql	#8, sp
    28ae:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    28b0:	move.l 8(sp),d1
	movel	d1, sp@-
    28b4:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    28b6:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    28b8:	bsr.w 27f8 <__mulsi3>
	addql	#8, sp
    28bc:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    28be:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    28c2:	sub.l d0,d1
	movel	d1, d0
    28c4:	move.l d1,d0
	rts
    28c6:	rts

000028c8 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    28c8:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    28cc:	move.l 4(sp),d0
	movel	d1, sp@-
    28d0:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    28d2:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    28d4:	bsr.w 281a <__udivsi3>
	addql	#8, sp
    28d8:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    28da:	move.l 8(sp),d1
	movel	d1, sp@-
    28de:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    28e0:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    28e2:	bsr.w 27f8 <__mulsi3>
	addql	#8, sp
    28e6:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    28e8:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    28ec:	sub.l d0,d1
	movel	d1, d0
    28ee:	move.l d1,d0
	rts
    28f0:	rts

000028f2 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    28f2:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    28f4:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    28f8:	jsr -516(a6)
    move.l (sp)+, a6
    28fc:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    28fe:	rts

00002900 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    2900:	move.b d0,(a3)+
	rts
    2902:	rts

00002904 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    2904:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    2906:	adda.l a0,a2
	move.l	a2,a3
    2908:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    290a:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    290c:	moveq #56,d4
	moveq	#8,d5
    290e:	moveq #8,d5
	bra.s	.Lliteral
    2910:	bra.s 297a <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    2912:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    2914:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    2916:	dbf d1,2912 <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    291a:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    291c:	bcc.s 2920 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    291e:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    2920:	tst.w d0
    2922:	bne.s 292c <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    2924:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    2926:	bls.s 299e <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    2928:	move.w (a0)+,d0
    292a:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    292c:	rol.l #6,d0
	move.w	d0,d1
    292e:	move.w d0,d1
	and.w	d4,d1
    2930:	and.w d4,d1
	eor.w	d1,d0
    2932:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    2934:	movem.w (2998 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    293a:	rol.l d2,d0
	and.w	d0,d3					|scaling
    293c:	and.w d0,d3
	eor.w	d3,d0
    293e:	eor.w d3,d0
	suba.w	d3,a4
    2940:	suba.w d3,a4
	adda.l	a1,a4
    2942:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    2944:	tst.w d0
    2946:	bne.s 294c <_doynaxdepack_asm+0x48>
    2948:	move.w (a0)+,d0
    294a:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    294c:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    294e:	beq.s 2966 <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    2950:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    2952:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    2954:	bpl.s 2962 <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    2956:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    2958:	bpl.s 2960 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    295a:	addx.b d1,d1
	lsl.l	#2,d0
    295c:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    295e:	bmi.s 295a <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    2960:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    2962:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    2964:	bcc.s 2968 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    2966:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    2968:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    296a:	dbf d1,2966 <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    296e:	add.l d0,d0
	bcc.s	.Lmatch
    2970:	bcc.s 2920 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    2972:	tst.w d0
    2974:	bne.s 297a <_doynaxdepack_asm+0x76>
    2976:	move.w (a0)+,d0
    2978:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    297a:	moveq #0,d1
	add.l	d0,d0
    297c:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    297e:	bcc.s 291e <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    2980:	bpl.s 2988 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    2982:	addx.b d1,d1
	lsl.l	#2,d0
    2984:	lsl.l #2,d0
	bmi.s	.Llgetlen
    2986:	bmi.s 2982 <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    2988:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    298a:	dbv.s d1,2912 <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    298e:	add.l d0,d0
	eor.w	d1,d0		
    2990:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    2992:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    2994:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    2996:	bra.s 298a <_doynaxdepack_asm+0x86>

00002998 <doy_table>:
    2998:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    29a8:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    29b8:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    29c8:	.............o
