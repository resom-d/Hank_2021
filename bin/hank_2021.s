
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
       4:	move.l #31436,d3
       a:	subi.l #31436,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	moveq #0,d2
      14:	bra.s 2a <_start+0x2a>
		__preinit_array_start[i]();
      16:	move.l d2,d0
      18:	add.l d2,d0
      1a:	add.l d0,d0
      1c:	lea 7acc <NextPlot>,a0
      22:	movea.l (0,a0,d0.l),a0
      26:	jsr (a0)
	for (i = 0; i < count; i++)
      28:	addq.l #1,d2
      2a:	cmp.l d2,d3
      2c:	bhi.s 16 <_start+0x16>

	count = __init_array_end - __init_array_start;
      2e:	move.l #31436,d3
      34:	subi.l #31436,d3
      3a:	asr.l #2,d3
	for (i = 0; i < count; i++)
      3c:	moveq #0,d2
      3e:	bra.s 54 <_start+0x54>
		__init_array_start[i]();
      40:	move.l d2,d0
      42:	add.l d2,d0
      44:	add.l d0,d0
      46:	lea 7acc <NextPlot>,a0
      4c:	movea.l (0,a0,d0.l),a0
      50:	jsr (a0)
	for (i = 0; i < count; i++)
      52:	addq.l #1,d2
      54:	cmp.l d2,d3
      56:	bhi.s 40 <_start+0x40>

	main();
      58:	jsr 31cc <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
      5e:	move.l #31436,d2
      64:	subi.l #31436,d2
      6a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      6c:	bra.s 82 <_start+0x82>
		__fini_array_start[i - 1]();
      6e:	subq.l #1,d2
      70:	move.l d2,d0
      72:	add.l d2,d0
      74:	add.l d0,d0
      76:	lea 7acc <NextPlot>,a0
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
      90:	move.w 37d40 <BobPhase>,d0
      96:	beq.s 104 <MoveBobs+0x78>
      98:	cmpi.w #1,d0
      9c:	beq.w 1e0 <MoveBobs+0x154>
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
      a6:	lea 7ad2 <BobVecs>,a1
      ac:	move.l d0,d3
      ae:	lsl.l #3,d3
      b0:	movea.l d3,a0
      b2:	add.l (0,a1,d3.l),d1
      b6:	lea 7b12 <BobTarget>,a1
      bc:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X > 320 + 32)
      c0:	cmpi.l #352,d1
      c6:	ble.s d0 <MoveBobs+0x44>
					BobTarget[b].X = 320 + 32;
      c8:	move.l #352,(0,a1,d3.l)
{
      d0:	move.l d2,d0
		for (int b = 0; b < BOBSN - 1; b++)
      d2:	moveq #6,d1
      d4:	cmp.l d0,d1
      d6:	blt.s 108 <MoveBobs+0x7c>
			if ((BobTarget[b + 1].X - BobTarget[b].X) > 34 || BobTarget[b + 1].X >= 320 + 32)
      d8:	move.l d0,d2
      da:	addq.l #1,d2
      dc:	lea 7b12 <BobTarget>,a0
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
     108:	move.l 7b0a <BobVecs+0x38>,d1
     10e:	move.l d1,d0
     110:	add.l 7b4a <BobTarget+0x38>,d0
     116:	move.l d0,7b4a <BobTarget+0x38>
		if (BobTarget[BOBSN - 1].X > 320 + 32)
     11c:	cmpi.l #352,d0
     122:	ble.s 12e <MoveBobs+0xa2>
			BobTarget[BOBSN - 1].X = 320 + 32;
     124:	move.l #352,7b4a <BobTarget+0x38>
		if (BobTarget[0].X >= 320 + 32)
     12e:	cmpi.l #351,7b12 <BobTarget>
     138:	ble.w a0 <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     13c:	neg.l 7ad2 <BobVecs>
			BobVecs[1].X *= -1;
     142:	neg.l 7ada <BobVecs+0x8>
			BobVecs[2].X *= -1;
     148:	neg.l 7ae2 <BobVecs+0x10>
			BobVecs[3].X *= -1;
     14e:	neg.l 7aea <BobVecs+0x18>
			BobVecs[4].X *= -1;
     154:	neg.l 7af2 <BobVecs+0x20>
			BobVecs[5].X *= -1;
     15a:	neg.l 7afa <BobVecs+0x28>
			BobVecs[6].X *= -1;
     160:	neg.l 7b02 <BobVecs+0x30>
			BobVecs[7].X *= -1;
     166:	neg.l d1
     168:	move.l d1,7b0a <BobVecs+0x38>
			BobPhase = 1;
     16e:	move.w #1,37d40 <BobPhase>
			BobPause = 2 * 50;
     176:	move.w #100,37d42 <BobPause>
			*copPF1BmpP = 0 << 6; // prio. in bplcon2: pf1 >> pf 2 >> sprites
     17e:	movea.l 37d3c <copPF1BmpP>,a0
     184:	clr.w (a0)
     186:	bra.w a0 <MoveBobs+0x14>
				BobTarget[b].X += BobVecs[b].X;
     18a:	lea 7ad2 <BobVecs>,a1
     190:	move.l d0,d3
     192:	lsl.l #3,d3
     194:	movea.l d3,a0
     196:	add.l (0,a1,d3.l),d1
     19a:	lea 7b12 <BobTarget>,a1
     1a0:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X < 0)
     1a4:	bmi.s 1da <MoveBobs+0x14e>
	switch (BobPhase)
     1a6:	move.l d2,d0
		for (int b = 0; b < BOBSN - 1; b++)
     1a8:	moveq #6,d1
     1aa:	cmp.l d0,d1
     1ac:	blt.s 1e4 <MoveBobs+0x158>
			if ((BobTarget[b].X - BobTarget[b + 1].X) > 34 || BobTarget[b + 1].X <= 0)
     1ae:	lea 7b12 <BobTarget>,a0
     1b4:	move.l d0,d1
     1b6:	lsl.l #3,d1
     1b8:	move.l (0,a0,d1.l),d1
     1bc:	move.l d0,d2
     1be:	addq.l #1,d2
     1c0:	move.l d2,d3
     1c2:	lsl.l #3,d3
     1c4:	movea.l (0,a0,d3.l),a0
     1c8:	movea.l d1,a1
     1ca:	suba.l a0,a1
     1cc:	moveq #34,d3
     1ce:	cmp.l a1,d3
     1d0:	blt.s 18a <MoveBobs+0xfe>
     1d2:	cmpa.w #0,a0
     1d6:	bgt.s 1a6 <MoveBobs+0x11a>
     1d8:	bra.s 18a <MoveBobs+0xfe>
					BobTarget[b].X = 0;
     1da:	clr.l (0,a1,d3.l)
     1de:	bra.s 1a6 <MoveBobs+0x11a>
	switch (BobPhase)
     1e0:	moveq #0,d0
     1e2:	bra.s 1a8 <MoveBobs+0x11c>
		BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
     1e4:	move.l 7b0a <BobVecs+0x38>,d1
     1ea:	move.l d1,d0
     1ec:	add.l 7b4a <BobTarget+0x38>,d0
     1f2:	move.l d0,7b4a <BobTarget+0x38>
		if (BobTarget[BOBSN - 1].X < 0)
     1f8:	bmi.s 252 <MoveBobs+0x1c6>
		if (BobTarget[0].X <= 0)
     1fa:	tst.l 7b12 <BobTarget>
     200:	bgt.w a0 <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     204:	neg.l 7ad2 <BobVecs>
			BobVecs[1].X *= -1;
     20a:	neg.l 7ada <BobVecs+0x8>
			BobVecs[2].X *= -1;
     210:	neg.l 7ae2 <BobVecs+0x10>
			BobVecs[3].X *= -1;
     216:	neg.l 7aea <BobVecs+0x18>
			BobVecs[4].X *= -1;
     21c:	neg.l 7af2 <BobVecs+0x20>
			BobVecs[5].X *= -1;
     222:	neg.l 7afa <BobVecs+0x28>
			BobVecs[6].X *= -1;
     228:	neg.l 7b02 <BobVecs+0x30>
			BobVecs[7].X *= -1;
     22e:	neg.l d1
     230:	move.l d1,7b0a <BobVecs+0x38>
			BobPause = 2 * 50;
     236:	move.w #100,37d42 <BobPause>
			BobPhase = 0;
     23e:	clr.w 37d40 <BobPhase>
			*copPF1BmpP = 1 << 6; // prio. in bplcon2: pf2 >> pf 1 >> sprites
     244:	movea.l 37d3c <copPF1BmpP>,a0
     24a:	move.w #64,(a0)
     24e:	bra.w a0 <MoveBobs+0x14>
			BobTarget[BOBSN - 1].X = 0;
     252:	clr.l 7b4a <BobTarget+0x38>
     258:	bra.s 1fa <MoveBobs+0x16e>

0000025a <SetupCopper>:

void SetupCopper(USHORT *copPtr)
{
     25a:	movem.l d2-d5/a2,-(sp)
     25e:	movea.l 24(sp),a1
	UBYTE line = 0x1c;
	// set screen output size
	*copPtr++ = DIWSTRT;
     262:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     266:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     26c:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     272:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     278:	move.w #146,8(a1)
	*copPtr++ = 0x38;
     27e:	move.w #56,10(a1)
	*copPtr++ = DDFSTOP;
     284:	move.w #148,12(a1)
	*copPtr++ = 0xd0;
     28a:	move.w #208,14(a1)
	// set pf1/2 modulos
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - Screen.Bpl, BmpUpperPart_PF2.Bplt - Screen.Bpl);
     290:	move.w 37f8c <Screen+0x6>,d0
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     296:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     29c:	move.w 37e94 <BmpUpperPart_PF1+0x8>,d1
     2a2:	sub.w d0,d1
     2a4:	move.w d1,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     2a8:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     2ae:	move.w 37e62 <BmpUpperPart_PF2+0x8>,d2
     2b4:	sub.w d0,d2
     2b6:	move.w d2,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     2ba:	move.w #258,24(a1)
	*copPtr++ = 0;
     2c0:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     2c4:	move.w #260,28(a1)
	copPF1BmpP = copPtr;
     2ca:	lea 30(a1),a0
     2ce:	move.l a0,37d3c <copPF1BmpP>
	*copPtr++ = BobPhase == 0 ? 1 << 6 : 0; //pf2 >> pf 1 >> sprites
     2d4:	tst.w 37d40 <BobPhase>
     2da:	bne.s 308 <SetupCopper+0xae>
     2dc:	moveq #64,d0
     2de:	move.w d0,30(a1)
    *copListEnd++ = COP_SKIP;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2e2:	move.w #384,32(a1)
    *copListCurrent++ = color;
     2e8:	move.w #21,34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2ee:	move.w #400,36(a1)
    *copListCurrent++ = color;
     2f4:	lea 40(a1),a0
     2f8:	move.w #21,38(a1)
	// set logo colors
	copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[0]);
	copPtr = copSetColor(copPtr, 8, colgradbluePaletteRGB4[0]);
	copPF1ColP = copPtr;
     2fe:	move.l a0,37d50 <copPF1ColP>
	for (int a = 1; a < 8; a++)
     304:	moveq #1,d0
     306:	bra.s 32a <SetupCopper+0xd0>
	*copPtr++ = BobPhase == 0 ? 1 << 6 : 0; //pf2 >> pf 1 >> sprites
     308:	clr.w d0
     30a:	bra.s 2de <SetupCopper+0x84>
	{
		copPtr = copSetColor(copPtr, a, ActPfCol[a]);
     30c:	move.l d0,d1
     30e:	add.l d0,d1
     310:	movea.l 7b94 <ActPfCol>,a1
     316:	move.w (0,a1,d1.l),2(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     31c:	move.w d0,d1
     31e:	addi.w #192,d1
     322:	add.w d1,d1
     324:	move.w d1,(a0)
	for (int a = 1; a < 8; a++)
     326:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, ActPfCol[a]);
     328:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     32a:	moveq #7,d1
     32c:	cmp.l d0,d1
     32e:	bge.s 30c <SetupCopper+0xb2>
	}
	for (int a = 9; a < 16; a++)
     330:	moveq #9,d0
     332:	bra.s 354 <SetupCopper+0xfa>
	{
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     334:	move.l d0,d1
     336:	subq.l #8,d1
     338:	add.l d1,d1
     33a:	movea.w d0,a1
     33c:	lea 192(a1),a1
     340:	adda.w a1,a1
     342:	move.w a1,(a0)
    *copListCurrent++ = color;
     344:	lea 5a2c <CookiePaletteRGB4>,a1
     34a:	move.w (0,a1,d1.l),2(a0)
	for (int a = 9; a < 16; a++)
     350:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     352:	addq.l #4,a0
	for (int a = 9; a < 16; a++)
     354:	moveq #15,d2
     356:	cmp.l d0,d2
     358:	bge.s 334 <SetupCopper+0xda>
	}
	// set upper part, pf1, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.Planes[0], BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
     35a:	moveq #0,d5
     35c:	move.w 37e92 <BmpUpperPart_PF1+0x6>,d5
     362:	moveq #0,d4
     364:	move.w 37e90 <BmpUpperPart_PF1+0x4>,d4
     36a:	move.l 37e9e <BmpUpperPart_PF1+0x12>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     370:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     372:	clr.b d2
     374:	bra.s 3a2 <SetupCopper+0x148>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     376:	move.b d2,d0
     378:	ext.w d0
     37a:	movea.w d0,a1
     37c:	moveq #56,d0
     37e:	add.l a1,d0
     380:	add.w d0,d0
     382:	add.w d0,d0
     384:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     386:	move.l d1,d3
     388:	clr.w d3
     38a:	swap d3
     38c:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     390:	addq.w #2,d0
     392:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     396:	move.w d1,6(a0)
        addr += Bpl;
     39a:	add.l d5,d1
        plane += 2;
     39c:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     39e:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3a0:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     3a2:	moveq #0,d0
     3a4:	move.w a2,d0
     3a6:	cmp.l d4,d0
     3a8:	blt.s 376 <SetupCopper+0x11c>
	// set upper part, pf2, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.Planes[0], BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
     3aa:	moveq #0,d5
     3ac:	move.w 37e60 <BmpUpperPart_PF2+0x6>,d5
     3b2:	moveq #0,d4
     3b4:	move.w 37e5e <BmpUpperPart_PF2+0x4>,d4
     3ba:	move.l 37e6c <BmpUpperPart_PF2+0x12>,d1
     3c0:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     3c2:	moveq #1,d2
     3c4:	bra.s 3f2 <SetupCopper+0x198>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     3c6:	move.b d2,d0
     3c8:	ext.w d0
     3ca:	movea.w d0,a1
     3cc:	moveq #56,d0
     3ce:	add.l a1,d0
     3d0:	add.w d0,d0
     3d2:	add.w d0,d0
     3d4:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     3d6:	move.l d1,d3
     3d8:	clr.w d3
     3da:	swap d3
     3dc:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     3e0:	addq.w #2,d0
     3e2:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3e6:	move.w d1,6(a0)
        addr += Bpl;
     3ea:	add.l d5,d1
        plane += 2;
     3ec:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     3ee:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3f0:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     3f2:	moveq #0,d0
     3f4:	move.w a2,d0
     3f6:	cmp.l d4,d0
     3f8:	blt.s 3c6 <SetupCopper+0x16c>
	// set sprite pointers
	*copPtr++ = SPR0PTH;
     3fa:	move.w #288,(a0)
	*copPtr++ = (LONG)StarSprite >> 16;
     3fe:	move.l #227892,d0
     404:	move.l d0,d1
     406:	swap d1
     408:	ext.l d1
     40a:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
     40e:	move.w #290,4(a0)
	*copPtr++ = (LONG)StarSprite;
     414:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
     418:	move.w #292,8(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     41e:	move.l #227880,d0
     424:	move.l d0,d1
     426:	swap d1
     428:	ext.l d1
     42a:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
     42e:	move.w #294,12(a0)
	*copPtr++ = (LONG)NullSprite;
     434:	move.w d0,14(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     438:	move.w #418,16(a0)
    *copListCurrent++ = color;
     43e:	move.w #2120,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     444:	move.w #420,20(a0)
    *copListCurrent++ = color;
     44a:	move.w #143,22(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     450:	move.w #422,24(a0)
    *copListCurrent++ = color;
     456:	move.w #4095,26(a0)
	// sprite 0+1 colors
	copPtr = copSetColor(copPtr, 17, 0x848);
	copPtr = copSetColor(copPtr, 18, 0x08f);
	copPtr = copSetColor(copPtr, 19, 0xfff);
	*copPtr++ = SPR2PTH;
     45c:	move.w #296,28(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     462:	move.w d1,30(a0)
	*copPtr++ = SPR2PTL;
     466:	move.w #298,32(a0)
	*copPtr++ = (LONG)NullSprite;
     46c:	move.w d0,34(a0)
	*copPtr++ = SPR3PTH;
     470:	move.w #300,36(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     476:	move.w d1,38(a0)
	*copPtr++ = SPR3PTL;
     47a:	move.w #302,40(a0)
	*copPtr++ = (LONG)NullSprite;
     480:	move.w d0,42(a0)
	*copPtr++ = SPR4PTH;
     484:	move.w #304,44(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     48a:	move.w d1,46(a0)
	*copPtr++ = SPR4PTL;
     48e:	move.w #306,48(a0)
	*copPtr++ = (LONG)NullSprite;
     494:	move.w d0,50(a0)
	*copPtr++ = SPR5PTH;
     498:	move.w #308,52(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     49e:	move.w d1,54(a0)
	*copPtr++ = SPR5PTL;
     4a2:	move.w #310,56(a0)
	*copPtr++ = (LONG)NullSprite;
     4a8:	move.w d0,58(a0)
	*copPtr++ = SPR6PTH;
     4ac:	move.w #312,60(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     4b2:	move.w d1,62(a0)
	*copPtr++ = SPR6PTL;
     4b6:	move.w #314,64(a0)
	*copPtr++ = (LONG)NullSprite;
     4bc:	move.w d0,66(a0)
	*copPtr++ = SPR7PTH;
     4c0:	move.w #316,68(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     4c6:	move.w d1,70(a0)
	*copPtr++ = SPR7PTL;
     4ca:	move.w #318,72(a0)
	*copPtr++ = (LONG)NullSprite;
     4d0:	move.w d0,74(a0)
	// enable bitplanes
	*copPtr++ = BPLCON0;
     4d4:	move.w #256,76(a0)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     4da:	moveq #0,d0
     4dc:	move.w 37f58 <BmpLogo+0x4>,d0
     4e2:	add.l d0,d0
     4e4:	moveq #12,d3
     4e6:	lsl.l d3,d0
     4e8:	ori.w #1536,d0
     4ec:	move.w d0,78(a0)
	// wait till below logo
	line = 0x2c + BmpUpperPart_PF1.Height;
     4f0:	move.b 37e8f <BmpUpperPart_PF1+0x3>,d0
     4f6:	addi.b #44,d0
	copPtr = copWaitY(copPtr, line++);
     4fa:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     500:	lsl.l #8,d0
     502:	ori.w #5,d0
     506:	move.w d0,80(a0)
    *copListEnd++ = COP_WAIT;
     50a:	move.w #-2,82(a0)
	// turn off bitplanes to waste 8 lines, giving the logo more bottom space
	*copPtr++ = BPLCON0;
     510:	move.w #256,84(a0)
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     516:	move.w #512,86(a0)
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
     51c:	move.b 37e8f <BmpUpperPart_PF1+0x3>,d0
     522:	addi.b #52,d0
	copPtr = copWaitY(copPtr, line++);
     526:	move.b 37e8f <BmpUpperPart_PF1+0x3>,d1
     52c:	addi.b #53,d1
     530:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     536:	lsl.l #8,d0
     538:	ori.w #5,d0
     53c:	move.w d0,88(a0)
    *copListEnd++ = COP_WAIT;
     540:	lea 92(a0),a1
     544:	move.w #-2,90(a0)
	// set bitplane pointers
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     54a:	move.l a1,37d44 <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     550:	moveq #0,d5
     552:	move.w 37dfc <BmpScroller+0x6>,d5
     558:	moveq #0,d4
     55a:	move.w 37dfa <BmpScroller+0x4>,d4
     560:	move.l 37e04 <BmpScroller+0xe>,d2
    for (USHORT i = 0; i < numPlanes; i++)
     566:	suba.l a0,a0
     568:	bra.s 58e <SetupCopper+0x334>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     56a:	moveq #56,d3
     56c:	add.l d3,d0
     56e:	add.w d0,d0
     570:	add.w d0,d0
     572:	move.w d0,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     574:	move.l d2,d3
     576:	clr.w d3
     578:	swap d3
     57a:	move.w d3,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     57e:	addq.w #2,d0
     580:	move.w d0,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     584:	move.w d2,6(a1)
        addr += Bpl;
     588:	add.l d5,d2
    for (USHORT i = 0; i < numPlanes; i++)
     58a:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
     58c:	addq.l #8,a1
    for (USHORT i = 0; i < numPlanes; i++)
     58e:	moveq #0,d0
     590:	move.w a0,d0
     592:	cmp.l d4,d0
     594:	blt.s 56a <SetupCopper+0x310>
	//set modulo for scroller
	copPtr = copSetBplMod(0, copPtr,
						  BmpScroller.Bplt - Screen.Bpl,
						  BmpScroller.Bplt - Screen.Bpl);
     596:	move.w 37dfe <BmpScroller+0x8>,d0
     59c:	sub.w 37f8c <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     5a2:	move.w #264,(a1)
    *copListEnd++ = modOdd;
     5a6:	move.w d0,2(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     5aa:	move.w #266,4(a1)
    *copListEnd++ = modEven;
     5b0:	move.w d0,6(a1)
	*copPtr++ = BPLCON0;
     5b4:	move.w #256,8(a1)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     5ba:	moveq #0,d0
     5bc:	move.w 37f58 <BmpLogo+0x4>,d0
     5c2:	moveq #12,d2
     5c4:	lsl.l d2,d0
     5c6:	lea 12(a1),a0
     5ca:	ori.w #512,d0
     5ce:	move.w d0,10(a1)
	// set font colors for scroller
	for (int a = 1; a < 8; a++)
     5d2:	moveq #1,d0
     5d4:	bra.s 5f4 <SetupCopper+0x39a>
	{
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     5d6:	move.l d0,d2
     5d8:	add.l d0,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5da:	movea.w d0,a1
     5dc:	lea 192(a1),a1
     5e0:	adda.w a1,a1
     5e2:	move.w a1,(a0)
    *copListCurrent++ = color;
     5e4:	lea 5a1c <FontPaletteRGB4>,a1
     5ea:	move.w (0,a1,d2.l),2(a0)
	for (int a = 1; a < 8; a++)
     5f0:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     5f2:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     5f4:	moveq #7,d3
     5f6:	cmp.l d0,d3
     5f8:	bge.s 5d6 <SetupCopper+0x37c>
	}
	// blue gradient below logo
	for (int l = 0; l < 24; l++)
     5fa:	moveq #0,d0
     5fc:	bra.s 62c <SetupCopper+0x3d2>
	{
		copPtr = copWaitY(copPtr, line);
     5fe:	moveq #0,d2
     600:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     602:	lsl.l #8,d2
     604:	ori.w #5,d2
     608:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     60a:	move.w #-2,2(a0)
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     610:	movea.l d0,a1
     612:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     614:	move.w #384,4(a0)
    *copListCurrent++ = color;
     61a:	lea 5a3c <colgradbluePaletteRGB4>,a2
     620:	move.w (0,a2,a1.l),6(a0)
		line += 2;
     626:	addq.b #2,d1
	for (int l = 0; l < 24; l++)
     628:	addq.l #1,d0
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     62a:	addq.l #8,a0
	for (int l = 0; l < 24; l++)
     62c:	moveq #23,d2
     62e:	cmp.l d0,d2
     630:	bge.s 5fe <SetupCopper+0x3a4>
	}
	copPtr = copWaitY(copPtr, line++);
     632:	move.b d1,d0
     634:	addq.b #1,d0
     636:	moveq #0,d2
     638:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     63a:	lsl.l #8,d2
     63c:	ori.w #5,d2
     640:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     642:	move.w #-2,2(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
     648:	movea.w 7ace <colScrollMirror>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     64e:	move.w #384,4(a0)
    *copListCurrent++ = color;
     654:	move.w a1,6(a0)
	copPtr = copWaitY(copPtr, line++);
     658:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     65e:	lsl.l #8,d0
     660:	ori.w #5,d0
     664:	move.w d0,8(a0)
    *copListEnd++ = COP_WAIT;
     668:	move.w #-2,10(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
     66e:	move.w 7ad0 <colScrollMirror+0x2>,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     674:	move.w #384,12(a0)
    *copListCurrent++ = color;
     67a:	move.w d2,14(a0)
	line += 7;
     67e:	move.b d1,d0
     680:	addi.b #9,d0
	copPtr = copWaitY(copPtr, line++);
     684:	addi.b #10,d1
     688:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     68e:	lsl.l #8,d0
     690:	ori.w #5,d0
     694:	move.w d0,16(a0)
    *copListEnd++ = COP_WAIT;
     698:	move.w #-2,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     69e:	move.w #384,20(a0)
    *copListCurrent++ = color;
     6a4:	move.w a1,22(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
     6a8:	andi.l #255,d1
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6ae:	lsl.l #8,d1
     6b0:	ori.w #5,d1
     6b4:	move.w d1,24(a0)
    *copListEnd++ = COP_WAIT;
     6b8:	move.w #-2,26(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     6be:	move.w #384,28(a0)
    *copListCurrent++ = color;
     6c4:	move.w d2,30(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);

	line = 0x2c + BmpLogo.Height + 72 + 7; // 209
     6c8:	move.b 37f57 <BmpLogo+0x3>,d0
     6ce:	addi.b #123,d0
	copPtr = copWaitY(copPtr, line++);
     6d2:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6d8:	lsl.l #8,d0
     6da:	ori.w #5,d0
     6de:	move.w d0,32(a0)
    *copListEnd++ = COP_WAIT;
     6e2:	move.w #-2,34(a0)
	copMirrorBmpP = copPtr;
     6e8:	lea 36(a0),a2
     6ec:	move.l a2,37d38 <copMirrorBmpP>
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     6f2:	move.w 37f5c <BmpLogo+0x8>,d0
     6f8:	sub.w 37f5a <BmpLogo+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     6fe:	move.w #264,36(a0)
    *copListEnd++ = modOdd;
     704:	move.w d0,38(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     708:	move.w #266,40(a0)
    *copListEnd++ = modEven;
     70e:	move.w d0,42(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     712:	move.w #386,44(a0)
    *copListCurrent++ = color;
     718:	move.w #4032,46(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     71e:	move.w #-31,48(a0)
    *copListEnd++ = COP_WAIT;
     724:	move.w #-2,50(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     72a:	move.w #1285,52(a0)
    *copListEnd++ = COP_WAIT;
     730:	move.w #-2,54(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     736:	move.w #384,56(a0)
    *copListCurrent++ = color;
     73c:	move.w a1,58(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     740:	move.w #1541,60(a0)
    *copListEnd++ = COP_WAIT;
     746:	move.w #-2,62(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     74c:	move.w #384,64(a0)
    *copListCurrent++ = color;
     752:	move.w d2,66(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     756:	move.w #11269,68(a0)
    *copListEnd++ = COP_WAIT;
     75c:	move.w #-2,70(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     762:	move.w #384,72(a0)
    *copListCurrent++ = color;
     768:	move.w a1,74(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     76c:	move.w #11525,76(a0)
    *copListEnd++ = COP_WAIT;
     772:	move.w #-2,78(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     778:	move.w #384,80(a0)
    *copListCurrent++ = color;
     77e:	move.w d2,82(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     782:	move.w #-1,84(a0)
    *copListEnd++ = COP_WAIT;
     788:	move.w #-2,86(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// copper end
	copPtr = copWaitXY(copPtr, 0xff, 0xff);
}
     78e:	movem.l (sp)+,d2-d5/a2
     792:	rts

00000794 <EnableMirrorEffect>:

void EnableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2),
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
     794:	move.w 37dfe <BmpScroller+0x8>,d0
     79a:	move.w d0,d1
     79c:	sub.w 37f8c <Screen+0x6>,d1
     7a2:	add.w d0,d0
     7a4:	sub.w d0,d1
	copSetBplMod(0, copMirrorBmpP,
     7a6:	movea.l 37d38 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     7ac:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     7b0:	move.w d1,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     7b4:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     7ba:	move.w d1,6(a0)
}
     7be:	rts

000007c0 <DisableMirrorEffect>:

void DisableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 BmpScroller.Bplt - Screen.Bpl,
				 BmpScroller.Bplt - Screen.Bpl);
     7c0:	move.w 37dfe <BmpScroller+0x8>,d0
     7c6:	sub.w 37f8c <Screen+0x6>,d0
	copSetBplMod(0, copMirrorBmpP,
     7cc:	movea.l 37d38 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     7d2:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     7d6:	move.w d0,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     7da:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     7e0:	move.w d0,6(a0)
}
     7e4:	rts

000007e6 <PlotChar>:
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
	}
}

void PlotChar(BmpDescriptor bmpFont, BmpDescriptor bmpDest, USHORT plotY, USHORT charW, USHORT charH)
{
     7e6:	movem.l d2-d6/a2/a6,-(sp)
     7ea:	move.l 136(sp),d5
     7ee:	move.l 140(sp),d3
     7f2:	move.l 144(sp),d4
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     7f6:	move.w 37d34 <ScrolltextCnt>,d0
     7fc:	move.w d0,d1
     7fe:	addq.w #1,d1
     800:	move.w d1,37d34 <ScrolltextCnt>
     806:	andi.l #65535,d0
     80c:	lea 5223 <Scrolltext>,a0
     812:	move.b (0,a0,d0.l),d0
	ULONG source, dest;
	ULONG row, col;

	// Set standard char distance
	NextPlot = 32;
     816:	move.w #32,7acc <NextPlot>
	// scroller commands: b=bounce; m=mirror; s=stop; c=color
	if (chr == 'b')
     81e:	cmpi.b #98,d0
     822:	beq.w 976 <PlotChar+0x190>
		}
		BounceEnabled = !BounceEnabled;

		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'm')
     826:	cmpi.b #109,d0
     82a:	beq.w 9b8 <PlotChar+0x1d2>
		}

		MirrorEnabled = !MirrorEnabled;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 's')
     82e:	cmpi.b #115,d0
     832:	beq.w a00 <PlotChar+0x21a>
	{
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'c')
     836:	cmpi.b #99,d0
     83a:	beq.w a86 <PlotChar+0x2a0>
		colScrollMirror[0] = 0x6bf;
		colScrollMirror[1] = 0x49b;
		ResetCopper = TRUE;
	}
	// select character for different spacing
	if (chr == '!' || chr == 'I' || chr == '.' || chr == ',' || chr == ':' || chr == ';' || chr == '\'')
     83e:	cmpi.b #33,d0
     842:	beq.s 868 <PlotChar+0x82>
     844:	cmpi.b #73,d0
     848:	beq.s 868 <PlotChar+0x82>
     84a:	cmpi.b #46,d0
     84e:	beq.s 868 <PlotChar+0x82>
     850:	cmpi.b #44,d0
     854:	beq.s 868 <PlotChar+0x82>
     856:	cmpi.b #58,d0
     85a:	beq.s 868 <PlotChar+0x82>
     85c:	cmpi.b #59,d0
     860:	beq.s 868 <PlotChar+0x82>
     862:	cmpi.b #39,d0
     866:	bne.s 870 <PlotChar+0x8a>
	{
		NextPlot = 12;
     868:	move.w #12,7acc <NextPlot>
	}
	if (chr == 'J')
     870:	cmpi.b #74,d0
     874:	beq.w aa2 <PlotChar+0x2bc>
	{
		NextPlot = 24;
	}
	// check for end of text
	if (chr == 0)
     878:	tst.b d0
     87a:	bne.s 8a4 <PlotChar+0xbe>
	{
		ScrolltextCnt = 0;
     87c:	clr.w 37d34 <ScrolltextCnt>
		chr = Scrolltext[ScrolltextCnt++];
     882:	move.w #1,37d34 <ScrolltextCnt>
		colScrollMirror[0] = 0x111;
     88a:	move.w #273,7ace <colScrollMirror>
		colScrollMirror[1] = 0x222;
     892:	move.w #546,7ad0 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     89a:	move.w #1,37d4e <ResetCopper>
		chr = Scrolltext[ScrolltextCnt++];
     8a2:	moveq #32,d0
	}
	// check legal values
	if (chr < 32 || chr > (32 + 80))
     8a4:	addi.b #-32,d0
     8a8:	cmpi.b #80,d0
     8ac:	bhi.w 970 <PlotChar+0x18a>
		return;
	}
	// skip first 32 ascii codes
	chr -= 32;
	// get row and column of source bitmap (10 chrs per row)
	row = chr / 10;
     8b0:	andi.w #255,d0
     8b4:	move.w d0,d6
     8b6:	mulu.w #-13107,d6
     8ba:	clr.w d6
     8bc:	swap d6
     8be:	lsr.w #3,d6
	col = chr % 10;
     8c0:	move.w d6,d1
     8c2:	add.w d6,d1
     8c4:	add.w d1,d1
     8c6:	add.w d6,d1
     8c8:	add.w d1,d1
     8ca:	sub.w d1,d0
     8cc:	moveq #0,d2
     8ce:	move.b d0,d2
	// calc source bitplane pointer
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     8d0:	moveq #0,d0
     8d2:	move.w 40(sp),d0
     8d6:	lea 3684 <__mulsi3>,a2
     8dc:	moveq #31,d1
     8de:	and.l d6,d1
     8e0:	move.l d1,-(sp)
     8e2:	move.l d0,-(sp)
     8e4:	jsr (a2)
     8e6:	addq.l #8,sp
     8e8:	move.l d0,-(sp)
     8ea:	move.w d4,-(sp)
     8ec:	clr.w -(sp)
     8ee:	jsr (a2)
     8f0:	addq.l #8,sp
     8f2:	add.l d2,d2
     8f4:	add.l d2,d2
     8f6:	add.l d0,d2
	// calc destination bitplane pointer
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     8f8:	moveq #0,d0
     8fa:	move.w 92(sp),d0
     8fe:	move.l d0,-(sp)
     900:	move.w d5,-(sp)
     902:	clr.w -(sp)
     904:	jsr (a2)
     906:	addq.l #8,sp
     908:	moveq #0,d5
     90a:	move.w 37f8c <Screen+0x6>,d5
     910:	add.l d0,d5
	// wait for blitter and blit
	WaitBlit();
     912:	movea.l 37fbc <GfxBase>,a6
     918:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     91c:	movea.l 37fc6 <custom>,a0
     922:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     928:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     92e:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     934:	move.w #-1,70(a0)
	custom->bltapt = ((UBYTE *)bmpFont.ImageData) + source;
     93a:	add.l 46(sp),d2
     93e:	move.l d2,80(a0)
	custom->bltdpt = ((UBYTE *)bmpDest.ImageData) + dest;
     942:	add.l 98(sp),d5
     946:	move.l d5,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     94a:	move.w d3,d0
     94c:	lsr.w #3,d0
     94e:	move.w 38(sp),d1
     952:	sub.w d0,d1
     954:	move.w d1,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     958:	move.w 90(sp),d1
     95c:	sub.w d0,d1
     95e:	move.w d1,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     962:	muls.w 36(sp),d4
     966:	lsl.w #6,d4
     968:	lsr.w #4,d3
     96a:	add.w d4,d3
     96c:	move.w d3,88(a0)
}
     970:	movem.l (sp)+,d2-d6/a2/a6
     974:	rts
		if (BounceEnabled)
     976:	move.w 37d4c <BounceEnabled>,d0
     97c:	beq.s 98c <PlotChar+0x1a6>
			ScrollerY = SCRT_MIN;
     97e:	clr.w 37d4a <ScrollerY>
			ScrollerDir = 1;
     984:	move.b #1,7b52 <ScrollerDir>
		BounceEnabled = !BounceEnabled;
     98c:	tst.w d0
     98e:	seq d0
     990:	ext.w d0
     992:	neg.w d0
     994:	move.w d0,37d4c <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     99a:	move.w d1,d0
     99c:	addq.w #1,d0
     99e:	move.w d0,37d34 <ScrolltextCnt>
     9a4:	andi.l #65535,d1
     9aa:	lea 5223 <Scrolltext>,a0
     9b0:	move.b (0,a0,d1.l),d0
     9b4:	bra.w 826 <PlotChar+0x40>
		if (MirrorEnabled)
     9b8:	tst.w 37d32 <MirrorEnabled>
     9be:	beq.s 9fa <PlotChar+0x214>
			DisableMirrorEffect();
     9c0:	jsr 7c0 <DisableMirrorEffect>(pc)
		MirrorEnabled = !MirrorEnabled;
     9c4:	tst.w 37d32 <MirrorEnabled>
     9ca:	seq d0
     9cc:	ext.w d0
     9ce:	neg.w d0
     9d0:	move.w d0,37d32 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     9d6:	move.w 37d34 <ScrolltextCnt>,d0
     9dc:	move.w d0,d1
     9de:	addq.w #1,d1
     9e0:	move.w d1,37d34 <ScrolltextCnt>
     9e6:	andi.l #65535,d0
     9ec:	lea 5223 <Scrolltext>,a0
     9f2:	move.b (0,a0,d0.l),d0
     9f6:	bra.w 82e <PlotChar+0x48>
			EnableMirrorEffect();
     9fa:	jsr 794 <EnableMirrorEffect>(pc)
     9fe:	bra.s 9c4 <PlotChar+0x1de>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     a00:	tst.w 37d4c <BounceEnabled>
     a06:	beq.s a58 <PlotChar+0x272>
     a08:	move.w 37d34 <ScrolltextCnt>,d0
     a0e:	move.w d0,d1
     a10:	addq.w #1,d1
     a12:	move.w d1,37d34 <ScrolltextCnt>
     a18:	andi.l #65535,d0
     a1e:	lea 5223 <Scrolltext>,a0
     a24:	move.b (0,a0,d0.l),d0
     a28:	ext.w d0
     a2a:	addi.w #-48,d0
     a2e:	move.w d0,37d48 <ScrollerPause>
		chr = Scrolltext[ScrolltextCnt++];
     a34:	move.w 37d34 <ScrolltextCnt>,d0
     a3a:	move.w d0,d1
     a3c:	addq.w #1,d1
     a3e:	move.w d1,37d34 <ScrolltextCnt>
     a44:	andi.l #65535,d0
     a4a:	lea 5223 <Scrolltext>,a0
     a50:	move.b (0,a0,d0.l),d0
     a54:	bra.w 836 <PlotChar+0x50>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     a58:	move.w 37d34 <ScrolltextCnt>,d0
     a5e:	move.w d0,d1
     a60:	addq.w #1,d1
     a62:	move.w d1,37d34 <ScrolltextCnt>
     a68:	andi.l #65535,d0
     a6e:	lea 5223 <Scrolltext>,a0
     a74:	move.b (0,a0,d0.l),d0
     a78:	ext.w d0
     a7a:	movea.w d0,a0
     a7c:	moveq #-48,d0
     a7e:	add.l a0,d0
     a80:	muls.w #50,d0
     a84:	bra.s a2e <PlotChar+0x248>
		colScrollMirror[0] = 0x6bf;
     a86:	move.w #1727,7ace <colScrollMirror>
		colScrollMirror[1] = 0x49b;
     a8e:	move.w #1179,7ad0 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     a96:	move.w #1,37d4e <ResetCopper>
     a9e:	bra.w 83e <PlotChar+0x58>
		NextPlot = 24;
     aa2:	move.w #24,7acc <NextPlot>
     aaa:	bra.w 878 <PlotChar+0x92>

00000aae <Scrollit>:
{
     aae:	movem.l d2-d7/a2/a6,-(sp)
     ab2:	move.l 96(sp),d3
     ab6:	move.l 100(sp),d4
	int BltOffs = startY * theDesc.Bplt;
     aba:	moveq #0,d5
     abc:	move.w 94(sp),d5
     ac0:	moveq #0,d6
     ac2:	move.w 44(sp),d6
     ac6:	lea 3684 <__mulsi3>,a2
     acc:	move.l d6,-(sp)
     ace:	move.l d5,-(sp)
     ad0:	jsr (a2)
     ad2:	addq.l #8,sp
     ad4:	move.l d0,d2
	int Brcorner = height * theDesc.Bplt - 2;
     ad6:	move.l d6,-(sp)
     ad8:	move.w d3,-(sp)
     ada:	clr.w -(sp)
     adc:	jsr (a2)
     ade:	addq.l #8,sp
     ae0:	move.l d0,d7
     ae2:	subq.l #2,d7
	WaitBlit();
     ae4:	movea.l 37fbc <GfxBase>,a6
     aea:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     aee:	clr.w d6
     af0:	move.b d4,d6
     af2:	moveq #12,d0
     af4:	lsl.w d0,d4
     af6:	movea.l 37fc6 <custom>,a0
     afc:	addi.w #2544,d4
     b00:	move.w d4,64(a0)
	custom->bltcon1 = 0x0002;
     b04:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     b0a:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     b10:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     b16:	move.l d2,d0
     b18:	add.l d7,d0
     b1a:	add.l 88(sp),d0
     b1e:	move.l d0,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     b22:	move.l d0,84(a0)
	custom->bltamod = 0;
     b26:	move.w #0,100(a0)
	custom->bltdmod = 0;
     b2c:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
     b32:	move.w 40(sp),d0
     b36:	muls.w d3,d0
     b38:	lsl.w #6,d0
     b3a:	move.w 37df6 <BmpScroller>,d1
     b40:	lsr.w #4,d1
     b42:	add.w d1,d0
     b44:	move.w d0,88(a0)
	ScrollCnt += speed;
     b48:	add.w 37d36 <ScrollCnt>,d6
     b4e:	move.w d6,37d36 <ScrollCnt>
	if (ScrollCnt >= NextPlot)
     b54:	cmp.w 7acc <NextPlot>,d6
     b5a:	bcc.s b62 <Scrollit+0xb4>
}
     b5c:	movem.l (sp)+,d2-d7/a2/a6
     b60:	rts
		ScrollCnt = 0;
     b62:	clr.w 37d36 <ScrollCnt>
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
     b68:	pea 20 <_start+0x20>
     b6c:	pea 20 <_start+0x20>
     b70:	move.l d5,-(sp)
     b72:	subq.l #2,sp
     b74:	move.l 37e24 <BmpScroller+0x2e>,-(sp)
     b7a:	move.l 37e20 <BmpScroller+0x2a>,-(sp)
     b80:	move.l 37e1c <BmpScroller+0x26>,-(sp)
     b86:	move.l 37e18 <BmpScroller+0x22>,-(sp)
     b8c:	move.l 37e14 <BmpScroller+0x1e>,-(sp)
     b92:	move.l 37e10 <BmpScroller+0x1a>,-(sp)
     b98:	move.l 37e0c <BmpScroller+0x16>,-(sp)
     b9e:	move.l 37e08 <BmpScroller+0x12>,-(sp)
     ba4:	move.l 37e04 <BmpScroller+0xe>,-(sp)
     baa:	move.l 37e00 <BmpScroller+0xa>,-(sp)
     bb0:	move.l 37dfc <BmpScroller+0x6>,-(sp)
     bb6:	move.l 37df8 <BmpScroller+0x2>,-(sp)
     bbc:	move.w 37df6 <BmpScroller>,-(sp)
     bc2:	subq.l #2,sp
     bc4:	move.l 37df2 <BmpFont32+0x2e>,-(sp)
     bca:	move.l 37dee <BmpFont32+0x2a>,-(sp)
     bd0:	move.l 37dea <BmpFont32+0x26>,-(sp)
     bd6:	move.l 37de6 <BmpFont32+0x22>,-(sp)
     bdc:	move.l 37de2 <BmpFont32+0x1e>,-(sp)
     be2:	move.l 37dde <BmpFont32+0x1a>,-(sp)
     be8:	move.l 37dda <BmpFont32+0x16>,-(sp)
     bee:	move.l 37dd6 <BmpFont32+0x12>,-(sp)
     bf4:	move.l 37dd2 <BmpFont32+0xe>,-(sp)
     bfa:	move.l 37dce <BmpFont32+0xa>,-(sp)
     c00:	move.l 37dca <BmpFont32+0x6>,-(sp)
     c06:	move.l 37dc6 <BmpFont32+0x2>,-(sp)
     c0c:	move.w 37dc4 <BmpFont32>,-(sp)
     c12:	jsr 7e6 <PlotChar>(pc)
     c16:	lea 116(sp),sp
     c1a:	bra.w b5c <Scrollit+0xae>

00000c1e <GetVBR>:

static APTR GetVBR()
{
     c1e:	subq.l #8,sp
     c20:	move.l a6,-(sp)
     c22:	move.l d7,-(sp)
	APTR vbr = 0;
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     c24:	move.w #20090,10(sp)
     c2a:	move.w #2049,12(sp)
     c30:	move.w #20083,14(sp)

	if (SysBase->AttnFlags & AFF_68010)
     c36:	movea.l 37fc0 <SysBase>,a6
     c3c:	btst #0,297(a6)
     c42:	beq.s c58 <GetVBR+0x3a>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     c44:	moveq #10,d7
     c46:	add.l sp,d7
     c48:	exg d7,a5
     c4a:	jsr -30(a6)
     c4e:	exg d7,a5

	return vbr;
}
     c50:	move.l (sp)+,d7
     c52:	movea.l (sp)+,a6
     c54:	addq.l #8,sp
     c56:	rts
	APTR vbr = 0;
     c58:	moveq #0,d0
	return vbr;
     c5a:	bra.s c50 <GetVBR+0x32>

00000c5c <SetInterruptHandler>:

void SetInterruptHandler(APTR interrupt)
{
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     c5c:	movea.l 37d2e <VBR>,a0
     c62:	move.l 4(sp),108(a0)
}
     c68:	rts

00000c6a <GetInterruptHandler>:

APTR GetInterruptHandler()
{
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     c6a:	movea.l 37d2e <VBR>,a0
     c70:	move.l 108(a0),d0
}
     c74:	rts

00000c76 <WaitVbl>:

//vblank begins at vpos 312 hpos 1 and ends at vpos 25 hpos 1
//vsync begins at line 2 hpos 132 and ends at vpos 5 hpos 18
void WaitVbl()
{
     c76:	subq.l #8,sp
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     c78:	move.l dff004 <_end+0xdc7038>,d0
     c7e:	move.l d0,(sp)
		vpos &= 0x1ff00;
     c80:	move.l (sp),d0
     c82:	andi.l #130816,d0
     c88:	move.l d0,(sp)
		if (vpos != (311 << 8))
     c8a:	move.l (sp),d0
     c8c:	cmpi.l #79616,d0
     c92:	beq.s c78 <WaitVbl+0x2>
			break;
	}
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     c94:	move.l dff004 <_end+0xdc7038>,d0
     c9a:	move.l d0,4(sp)
		vpos &= 0x1ff00;
     c9e:	move.l 4(sp),d0
     ca2:	andi.l #130816,d0
     ca8:	move.l d0,4(sp)
		if (vpos == (311 << 8))
     cac:	move.l 4(sp),d0
     cb0:	cmpi.l #79616,d0
     cb6:	bne.s c94 <WaitVbl+0x1e>
			break;
	}
}
     cb8:	addq.l #8,sp
     cba:	rts

00000cbc <TakeSystem>:
	{
	} //blitter busy wait
}

void TakeSystem()
{
     cbc:	move.l a6,-(sp)
     cbe:	move.l a2,-(sp)
	ActiView = GfxBase->ActiView; //store current view
     cc0:	movea.l 37fbc <GfxBase>,a6
     cc6:	move.l 34(a6),37d2a <ActiView>
	OwnBlitter();
     cce:	jsr -456(a6)
	WaitBlit();
     cd2:	movea.l 37fbc <GfxBase>,a6
     cd8:	jsr -228(a6)
	Disable();
     cdc:	movea.l 37fc0 <SysBase>,a6
     ce2:	jsr -120(a6)

	//Save current interrupts and DMA settings so we can restore them upon exit.
	SystemADKCON = custom->adkconr;
     ce6:	movea.l 37fc6 <custom>,a0
     cec:	move.w 16(a0),d0
     cf0:	move.w d0,37d28 <SystemADKCON>
	SystemInts = custom->intenar;
     cf6:	move.w 28(a0),d0
     cfa:	move.w d0,37d26 <SystemInts>
	SystemDMA = custom->dmaconr;
     d00:	move.w 2(a0),d0
     d04:	move.w d0,37d24 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     d0a:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     d10:	move.w #32767,156(a0)

	WaitVbl();
     d16:	lea c76 <WaitVbl>(pc),a2
     d1a:	jsr (a2)
	WaitVbl();
     d1c:	jsr (a2)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     d1e:	movea.l 37fc6 <custom>,a0
     d24:	move.w #32767,150(a0)

	//set all colors black
	for (int a = 0; a < 32; a++)
     d2a:	moveq #0,d1
     d2c:	bra.s d40 <TakeSystem+0x84>
		custom->color[a] = 0;
     d2e:	move.l d1,d0
     d30:	addi.l #192,d0
     d36:	add.l d0,d0
     d38:	move.w #0,(0,a0,d0.l)
	for (int a = 0; a < 32; a++)
     d3e:	addq.l #1,d1
     d40:	moveq #31,d0
     d42:	cmp.l d1,d0
     d44:	bge.s d2e <TakeSystem+0x72>

	LoadView(0);
     d46:	movea.l 37fbc <GfxBase>,a6
     d4c:	suba.l a1,a1
     d4e:	jsr -222(a6)
	WaitTOF();
     d52:	movea.l 37fbc <GfxBase>,a6
     d58:	jsr -270(a6)
	WaitTOF();
     d5c:	movea.l 37fbc <GfxBase>,a6
     d62:	jsr -270(a6)

	WaitVbl();
     d66:	lea c76 <WaitVbl>(pc),a2
     d6a:	jsr (a2)
	WaitVbl();
     d6c:	jsr (a2)

	VBR = GetVBR();
     d6e:	jsr c1e <GetVBR>(pc)
     d72:	move.l d0,37d2e <VBR>
	SystemIrq = GetInterruptHandler(); //store interrupt register
     d78:	jsr c6a <GetInterruptHandler>(pc)
     d7c:	move.l d0,37d20 <SystemIrq>
}
     d82:	movea.l (sp)+,a2
     d84:	movea.l (sp)+,a6
     d86:	rts

00000d88 <FreeSystem>:

void FreeSystem()
{
     d88:	move.l a6,-(sp)
	WaitVbl();
     d8a:	jsr c76 <WaitVbl>(pc)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     d8e:	movea.l 37fc6 <custom>,a0
     d94:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     d98:	move.w 2(a0),d0
     d9c:	btst #14,d0
     da0:	bne.s d98 <FreeSystem+0x10>
	WaitBlt();
	custom->intena = 0x7fff; //disable all interrupts
     da2:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     da8:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     dae:	move.w #32767,150(a0)

	//restore interrupts
	SetInterruptHandler(SystemIrq);
     db4:	move.l 37d20 <SystemIrq>,-(sp)
     dba:	jsr c5c <SetInterruptHandler>(pc)

	/*Restore system copper list(s). */
	custom->cop1lc = (ULONG)GfxBase->copinit;
     dbe:	movea.l 37fbc <GfxBase>,a6
     dc4:	movea.l 37fc6 <custom>,a0
     dca:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     dd0:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     dd6:	move.w #32767,136(a0)

	/*Restore all interrupts and DMA settings. */
	custom->intena = SystemInts | 0x8000;
     ddc:	move.w 37d26 <SystemInts>,d0
     de2:	ori.w #-32768,d0
     de6:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     dea:	move.w 37d24 <SystemDMA>,d0
     df0:	ori.w #-32768,d0
     df4:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     df8:	move.w 37d28 <SystemADKCON>,d0
     dfe:	ori.w #-32768,d0
     e02:	move.w d0,158(a0)

	LoadView(ActiView);
     e06:	movea.l 37d2a <ActiView>,a1
     e0c:	jsr -222(a6)
	WaitTOF();
     e10:	movea.l 37fbc <GfxBase>,a6
     e16:	jsr -270(a6)
	WaitTOF();
     e1a:	movea.l 37fbc <GfxBase>,a6
     e20:	jsr -270(a6)
	WaitBlit();
     e24:	movea.l 37fbc <GfxBase>,a6
     e2a:	jsr -228(a6)
	DisownBlitter();
     e2e:	movea.l 37fbc <GfxBase>,a6
     e34:	jsr -462(a6)
	Enable();
     e38:	movea.l 37fc0 <SysBase>,a6
     e3e:	jsr -126(a6)
     e42:	addq.l #4,sp
}
     e44:	movea.l (sp)+,a6
     e46:	rts

00000e48 <InitImagePlanes>:

void InitImagePlanes(BmpDescriptor *img, USHORT offs)
{
     e48:	movem.l d2-d4/a2,-(sp)
     e4c:	movea.l 20(sp),a2
     e50:	move.w 26(sp),d4
	for (int p = 0; p < img->Bpls; p++)
     e54:	moveq #0,d2
     e56:	bra.s e82 <InitImagePlanes+0x3a>
	{
		img->Planes[p] = ((UBYTE *)img->ImageData) + offs + (p * (img->Bpl));
     e58:	move.l 14(a2),d3
     e5c:	moveq #0,d0
     e5e:	move.w 6(a2),d0
     e62:	move.l d2,-(sp)
     e64:	move.l d0,-(sp)
     e66:	jsr 3684 <__mulsi3>
     e6c:	addq.l #8,sp
     e6e:	moveq #0,d1
     e70:	move.w d4,d1
     e72:	add.l d1,d0
     e74:	move.l d2,d1
     e76:	add.l d2,d1
     e78:	add.l d1,d1
     e7a:	add.l d0,d3
     e7c:	move.l d3,(18,a2,d1.l)
	for (int p = 0; p < img->Bpls; p++)
     e80:	addq.l #1,d2
     e82:	moveq #0,d0
     e84:	move.w 4(a2),d0
     e88:	cmp.l d0,d2
     e8a:	blt.s e58 <InitImagePlanes+0x10>
	}
}
     e8c:	movem.l (sp)+,d2-d4/a2
     e90:	rts

00000e92 <CopyBitmapPart>:
	custom->bltdmod = 0;
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
}

void CopyBitmapPart(BmpDescriptor bmpS, BmpDescriptor bmpD, USHORT startY, USHORT stopY)
{
     e92:	movem.l d2-d3/a2,-(sp)
     e96:	move.l 120(sp),d3
     e9a:	move.l 124(sp),d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     e9e:	movea.l 37fc6 <custom>,a2
     ea4:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     ea8:	move.w 2(a2),d0
     eac:	btst #14,d0
     eb0:	bne.s ea8 <CopyBitmapPart+0x16>
	WaitBlt();

	custom->bltcon0 = 0x09f0;
     eb2:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
     eb8:	move.w #0,66(a2)
	custom->bltapt = (UBYTE *)bmpS.ImageData + (startY * bmpS.Bplt);
     ebe:	moveq #0,d0
     ec0:	move.w 24(sp),d0
     ec4:	move.l d0,-(sp)
     ec6:	move.w d3,-(sp)
     ec8:	clr.w -(sp)
     eca:	jsr 3684 <__mulsi3>
     ed0:	addq.l #8,sp
     ed2:	move.l 30(sp),d1
     ed6:	add.l d0,d1
     ed8:	move.l d1,80(a2)
	custom->bltdpt = (UBYTE *)bmpD.ImageData + (startY * bmpS.Bplt);
     edc:	add.l 82(sp),d0
     ee0:	move.l d0,84(a2)
	custom->bltafwm = 0xffff;
     ee4:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
     eea:	move.w #-1,70(a2)
	custom->bltamod = 0;
     ef0:	move.w #0,100(a2)
	custom->bltdmod = 0;
     ef6:	move.w #0,102(a2)
	custom->bltsize = (((stopY - startY) * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
     efc:	sub.w d3,d2
     efe:	muls.w 20(sp),d2
     f02:	lsl.w #6,d2
     f04:	move.w 22(sp),d0
     f08:	lsr.w #1,d0
     f0a:	add.w d0,d2
     f0c:	move.w d2,88(a2)
}
     f10:	movem.l (sp)+,d2-d3/a2
     f14:	rts

00000f16 <ClearBitmapPart>:
	custom->bltdmod = 0;
	custom->bltsize = ((lines * bmpD.Bpls) << 6) + (bmpD.Width / 16);
}

void ClearBitmapPart(BmpDescriptor bmp, int x, int y, int height, int width)
{
     f16:	movem.l d2-d5/a2-a3,-(sp)
     f1a:	move.l 80(sp),d5
     f1e:	movea.l 92(sp),a3
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     f22:	movea.l 37fc6 <custom>,a2
     f28:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     f2c:	move.w 2(a2),d0
     f30:	btst #14,d0
     f34:	bne.s f2c <ClearBitmapPart+0x16>
	WaitBlt();
	BYTE shift = x % 16;
     f36:	move.l d5,d2
     f38:	andi.l #-2147483633,d2
     f3e:	tst.l d5
     f40:	blt.w fdc <ClearBitmapPart+0xc6>
	if (shift)
     f44:	tst.b d2
     f46:	beq.s f4c <ClearBitmapPart+0x36>
		width += 16;
     f48:	lea 16(a3),a3
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
     f4c:	move.b d2,d0
     f4e:	ext.w d0
     f50:	move.w d0,d4
     f52:	ext.l d4
     f54:	move.l d4,d1
     f56:	moveq #12,d3
     f58:	lsl.l d3,d1
     f5a:	ori.w #2304,d1
     f5e:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
     f62:	moveq #12,d1
     f64:	lsl.w d1,d0
     f66:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     f6a:	move.l 42(sp),d3
     f6e:	moveq #0,d0
     f70:	move.w 36(sp),d0
     f74:	move.l 84(sp),-(sp)
     f78:	move.l d0,-(sp)
     f7a:	jsr 3684 <__mulsi3>
     f80:	addq.l #8,sp
     f82:	move.l d5,d1
     f84:	bmi.s fe8 <ClearBitmapPart+0xd2>
     f86:	asr.l #3,d1
     f88:	add.l d1,d0
     f8a:	add.l d3,d0
     f8c:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     f90:	move.l d0,84(a2)
	custom->bltafwm = 0xffff;
     f94:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     f9a:	tst.b d2
     f9c:	beq.s fec <ClearBitmapPart+0xd6>
     f9e:	moveq #15,d1
     fa0:	sub.l d4,d1
     fa2:	moveq #0,d0
     fa4:	not.w d0
     fa6:	asr.l d1,d0
     fa8:	move.w d0,70(a2)
	;
	custom->bltamod = bmp.Bpl - (width / 8);
     fac:	move.w 34(sp),d0
     fb0:	move.l a3,d1
     fb2:	bmi.s ff0 <ClearBitmapPart+0xda>
     fb4:	asr.l #3,d1
     fb6:	sub.w d1,d0
     fb8:	move.w d0,100(a2)
	custom->bltdmod = bmp.Bpl - (width / 8);
     fbc:	move.w d0,102(a2)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     fc0:	move.w 32(sp),d0
     fc4:	muls.w 90(sp),d0
     fc8:	lsl.w #6,d0
     fca:	move.l a3,d1
     fcc:	bmi.s ff4 <ClearBitmapPart+0xde>
     fce:	asr.l #4,d1
     fd0:	add.w d1,d0
     fd2:	move.w d0,88(a2)
}
     fd6:	movem.l (sp)+,d2-d5/a2-a3
     fda:	rts
	BYTE shift = x % 16;
     fdc:	subq.l #1,d2
     fde:	moveq #-16,d0
     fe0:	or.l d0,d2
     fe2:	addq.l #1,d2
     fe4:	bra.w f44 <ClearBitmapPart+0x2e>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     fe8:	addq.l #7,d1
     fea:	bra.s f86 <ClearBitmapPart+0x70>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     fec:	moveq #-1,d0
     fee:	bra.s fa8 <ClearBitmapPart+0x92>
	custom->bltamod = bmp.Bpl - (width / 8);
     ff0:	addq.l #7,d1
     ff2:	bra.s fb4 <ClearBitmapPart+0x9e>
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     ff4:	moveq #15,d1
     ff6:	add.l a3,d1
     ff8:	bra.s fce <ClearBitmapPart+0xb8>

00000ffa <SimpleBlit>:

void SimpleBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
     ffa:	movem.l d2-d7/a2,-(sp)
     ffe:	move.l 136(sp),d7
    1002:	move.l 140(sp),d1
    1006:	move.l 144(sp),d4
    100a:	move.l 148(sp),d5
    100e:	move.l 152(sp),d3
    1012:	move.l 156(sp),d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1016:	movea.l 37fc6 <custom>,a2
    101c:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1020:	move.w 2(a2),d0
    1024:	btst #14,d0
    1028:	bne.s 1020 <SimpleBlit+0x26>
	WaitBlt();
	custom->bltcon0 = 0x09f0;
    102a:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
    1030:	move.w #0,66(a2)
	custom->bltafwm = 0xffff;
    1036:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    103c:	move.w #-1,70(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
    1042:	move.w d2,d0
    1044:	lsr.w #3,d0
    1046:	movea.w 38(sp),a0
    104a:	suba.w d0,a0
    104c:	move.w a0,100(a2)
	custom->bltdmod = imgD.Bpl - (width / 8);
    1050:	movea.w 90(sp),a0
    1054:	suba.w d0,a0
    1056:	move.w a0,102(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    105a:	move.l 46(sp),d6
    105e:	moveq #0,d0
    1060:	move.w 40(sp),d0
    1064:	move.l d0,-(sp)
    1066:	move.l d1,-(sp)
    1068:	jsr 3684 <__mulsi3>
    106e:	addq.l #8,sp
    1070:	move.l d7,d1
    1072:	bmi.s 10b6 <SimpleBlit+0xbc>
    1074:	asr.l #3,d1
    1076:	add.l d1,d0
    1078:	add.l d6,d0
    107a:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    107e:	move.l 98(sp),d6
    1082:	moveq #0,d0
    1084:	move.w 92(sp),d0
    1088:	move.l d0,-(sp)
    108a:	move.l d5,-(sp)
    108c:	jsr 3684 <__mulsi3>
    1092:	addq.l #8,sp
    1094:	move.l d4,d1
    1096:	bmi.s 10ba <SimpleBlit+0xc0>
    1098:	asr.l #3,d1
    109a:	add.l d1,d0
    109c:	add.l d6,d0
    109e:	move.l d0,84(a2)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
    10a2:	muls.w 36(sp),d3
    10a6:	lsl.w #6,d3
    10a8:	lsr.w #4,d2
    10aa:	add.w d3,d2
    10ac:	move.w d2,88(a2)
}
    10b0:	movem.l (sp)+,d2-d7/a2
    10b4:	rts
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    10b6:	addq.l #7,d1
    10b8:	bra.s 1074 <SimpleBlit+0x7a>
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    10ba:	addq.l #7,d1
    10bc:	bra.s 1098 <SimpleBlit+0x9e>

000010be <BetterBlit>:

void BetterBlit(BmpDescriptor imgS, BmpDescriptor imgD, BmpDescriptor imgM, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    10be:	movem.l d2-d7/a2-a6,-(sp)
    10c2:	movea.l 204(sp),a3
    10c6:	move.l 208(sp),d7
    10ca:	move.l 212(sp),d5
    10ce:	movea.l 216(sp),a5
    10d2:	movea.l 220(sp),a4
    10d6:	move.l 224(sp),d1
    10da:	move.w d1,d4
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    10dc:	movea.l 37fc6 <custom>,a2
    10e2:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    10e6:	move.w 2(a2),d0
    10ea:	btst #14,d0
    10ee:	bne.s 10e6 <BetterBlit+0x28>
	WaitBlt();
	BYTE shift = startD.X % 16;
    10f0:	move.l d5,d3
    10f2:	andi.l #-2147483633,d3
    10f8:	tst.l d5
    10fa:	blt.w 11ee <BetterBlit+0x130>
	if (shift)
    10fe:	tst.b d3
    1100:	beq.s 1108 <BetterBlit+0x4a>
		width += 16;
    1102:	move.w d1,d4
    1104:	addi.w #16,d4

	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1108:	move.b d3,d0
    110a:	ext.w d0
    110c:	movea.w d0,a6
    110e:	move.l a6,d1
    1110:	moveq #12,d2
    1112:	lsl.l d2,d1
    1114:	ori.w #4042,d1
    1118:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    111c:	moveq #12,d1
    111e:	lsl.w d1,d0
    1120:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1124:	move.l 62(sp),d6
    1128:	moveq #0,d0
    112a:	move.w 56(sp),d0
    112e:	move.l d0,-(sp)
    1130:	move.l d7,-(sp)
    1132:	jsr 3684 <__mulsi3>
    1138:	addq.l #8,sp
    113a:	move.l a3,d2
    113c:	bmi.w 11fa <BetterBlit+0x13c>
    1140:	asr.l #3,d2
    1142:	add.l d2,d0
    1144:	add.l d6,d0
    1146:	move.l d0,80(a2)
	custom->bltamod = imgS.Bpl - (width / 8);
    114a:	move.w d4,d6
    114c:	lsr.w #3,d6
    114e:	move.w 54(sp),d0
    1152:	sub.w d6,d0
    1154:	move.w d0,100(a2)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1158:	moveq #0,d0
    115a:	move.w 160(sp),d0
    115e:	lea 3684 <__mulsi3>,a3
    1164:	move.l d0,-(sp)
    1166:	move.l d7,-(sp)
    1168:	jsr (a3)
    116a:	addq.l #8,sp
    116c:	add.l d0,d2
    116e:	add.l 166(sp),d2
    1172:	move.l d2,76(a2)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1176:	move.w 158(sp),d0
    117a:	sub.w d6,d0
    117c:	move.w d0,98(a2)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1180:	move.l 114(sp),d2
    1184:	moveq #0,d0
    1186:	move.w 108(sp),d0
    118a:	move.l d0,-(sp)
    118c:	move.l a5,-(sp)
    118e:	jsr (a3)
    1190:	addq.l #8,sp
    1192:	move.l d5,d1
    1194:	bmi.s 1200 <BetterBlit+0x142>
    1196:	asr.l #3,d1
    1198:	add.l d1,d0
    119a:	add.l d2,d0
    119c:	move.l d0,84(a2)
    11a0:	move.l d0,72(a2)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    11a4:	move.w 106(sp),d0
    11a8:	sub.w d6,d0
    11aa:	move.w d0,102(a2)
    11ae:	move.w d0,96(a2)
	custom->bltafwm = 0xffff;
    11b2:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    11b8:	tst.b d3
    11ba:	beq.s 1204 <BetterBlit+0x146>
    11bc:	moveq #15,d1
    11be:	sub.l a6,d1
    11c0:	moveq #0,d0
    11c2:	not.w d0
    11c4:	asr.l d1,d0
    11c6:	move.w d0,70(a2)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    11ca:	moveq #0,d0
    11cc:	move.w 52(sp),d0
    11d0:	move.l d0,-(sp)
    11d2:	move.w a4,-(sp)
    11d4:	clr.w -(sp)
    11d6:	jsr 3684 <__mulsi3>
    11dc:	addq.l #8,sp
    11de:	lsl.l #6,d0
    11e0:	lsr.w #4,d4
    11e2:	or.w d0,d4
    11e4:	move.w d4,88(a2)
}
    11e8:	movem.l (sp)+,d2-d7/a2-a6
    11ec:	rts
	BYTE shift = startD.X % 16;
    11ee:	subq.l #1,d3
    11f0:	moveq #-16,d0
    11f2:	or.l d0,d3
    11f4:	addq.l #1,d3
    11f6:	bra.w 10fe <BetterBlit+0x40>
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    11fa:	addq.l #7,d2
    11fc:	bra.w 1140 <BetterBlit+0x82>
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1200:	addq.l #7,d1
    1202:	bra.s 1196 <BetterBlit+0xd8>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1204:	moveq #-1,d0
    1206:	bra.s 11c6 <BetterBlit+0x108>

00001208 <p61Init>:

int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
    1208:	move.l a3,-(sp)
    120a:	move.l a2,-(sp)
	register volatile const void *_a0 ASM("a0") = module;
    120c:	movea.l 12(sp),a0
	register volatile const void *_a1 ASM("a1") = NULL;
    1210:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
    1212:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
    1214:	lea 3862 <incbin_P61_Player_start>,a3
	register int _d0 ASM("d0"); // return value
	__asm volatile(
    121a:	movem.l d1-d7/a4-a6,-(sp)
    121e:	jsr (a3)
    1220:	movem.l (sp)+,d1-d7/a4-a6
		"movem.l (%%sp)+,%%d1-%%d7/%%a4-%%a6"
		: "=r"(_d0), "+rf"(_a0), "+rf"(_a1), "+rf"(_a2), "+rf"(_a3)
		:
		: "cc", "memory");
	return _d0;
}
    1224:	movea.l (sp)+,a2
    1226:	movea.l (sp)+,a3
    1228:	rts

0000122a <p61Music>:

void p61Music()
{
    122a:	move.l a6,-(sp)
    122c:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    122e:	lea 3862 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    1234:	movea.l #14675968,a6
	__asm volatile(
    123a:	movem.l d0-a2/a4-a5,-(sp)
    123e:	jsr 4(a3)
    1242:	movem.l (sp)+,d0-a2/a4-a5
		"jsr 4(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d7/%%a0-%%a2/%%a4-%%a5"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    1246:	movea.l (sp)+,a3
    1248:	movea.l (sp)+,a6
    124a:	rts

0000124c <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);
// interrupt handler
static __attribute__((interrupt)) void interruptHandler()
{
    124c:	movem.l d0-d1/a0-a1,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    1250:	movea.l 37fc6 <custom>,a0
    1256:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    125c:	move.w #32,156(a0)

    // DEMO - ThePlayer
    p61Music();
    1262:	jsr 122a <p61Music>(pc)

    // DEMO - increment frameCounter
    frameCounter++;
    1266:	move.w 37fc4 <frameCounter>,d0
    126c:	addq.w #1,d0
    126e:	move.w d0,37fc4 <frameCounter>
}
    1274:	movem.l (sp)+,d0-d1/a0-a1
    1278:	rte

0000127a <p61End>:

void p61End()
{
    127a:	move.l a6,-(sp)
    127c:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    127e:	lea 3862 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    1284:	movea.l #14675968,a6
	__asm volatile(
    128a:	movem.l d0-d1/a0-a1,-(sp)
    128e:	jsr 8(a3)
    1292:	movem.l (sp)+,d0-d1/a0-a1
		"jsr 8(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d1/%%a0-%%a1"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    1296:	movea.l (sp)+,a3
    1298:	movea.l (sp)+,a6
    129a:	rts

0000129c <BitmapInit>:

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{
    129c:	move.l d3,-(sp)
    129e:	move.l d2,-(sp)
    12a0:	movea.l 12(sp),a0
    12a4:	move.l 16(sp),d0
    12a8:	move.l 20(sp),d2
    12ac:	move.l 24(sp),d1

	bmp->Width = w;
    12b0:	move.w d0,(a0)
	bmp->Height = h;
    12b2:	move.w d2,2(a0)
	bmp->Bpls = bpls;
    12b6:	move.w d1,4(a0)
	bmp->Bpl = w / 8;
    12ba:	lsr.w #3,d0
    12bc:	move.w d0,6(a0)
	bmp->Bplt = w / 8 * bpls;
    12c0:	move.w d0,d3
    12c2:	muls.w d1,d3
    12c4:	move.w d3,8(a0)
	bmp->Btot = w / 8 * h * bpls;
    12c8:	muls.w d2,d0
    12ca:	muls.w d1,d0
    12cc:	move.w d0,12(a0)
}
    12d0:	move.l (sp)+,d2
    12d2:	move.l (sp)+,d3
    12d4:	rts

000012d6 <InitStarfieldSprite>:

void InitStarfieldSprite()
{
    12d6:	movem.l d2-d7/a2-a3,-(sp)
	short line = 0;
	USHORT hpos = 3;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 31; l++)
    12da:	moveq #0,d5
	BYTE vpos = 0x2c;
    12dc:	moveq #44,d3
	USHORT hpos = 3;
    12de:	movea.w #3,a1
	short line = 0;
    12e2:	clr.w d2
    12e4:	bra.w 141e <InitStarfieldSprite+0x148>
	{
		hpos = (7 * hpos) % 255;
    12e8:	moveq #0,d0
    12ea:	move.w a1,d0
    12ec:	move.l d0,d1
    12ee:	lsl.l #3,d1
    12f0:	lea 372c <__modsi3>,a3
    12f6:	pea ff <MoveBobs+0x73>
    12fa:	sub.l d0,d1
    12fc:	move.l d1,-(sp)
    12fe:	jsr (a3)
    1300:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    1302:	move.b d3,d1
    1304:	ext.w d1
    1306:	move.w d1,d4
    1308:	ext.l d4
    130a:	lsl.l #8,d4
    130c:	move.w d0,d6
    130e:	andi.w #255,d6
    1312:	movea.w d2,a0
    1314:	addq.w #1,a0
    1316:	movea.w d2,a1
    1318:	lea 37a34 <StarSprite>,a2
    131e:	adda.l a1,a1
    1320:	or.w d4,d6
    1322:	move.w d6,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    1326:	addq.w #1,d1
    1328:	movea.w d2,a1
    132a:	addq.w #2,a1
    132c:	movea.w a0,a0
    132e:	lsl.w #8,d1
    1330:	adda.l a0,a0
    1332:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-1
    1336:	movea.w d2,a0
    1338:	addq.w #3,a0
    133a:	movea.w a1,a1
    133c:	adda.l a1,a1
    133e:	move.w #-32768,(0,a1,a2.l)
		StarSprite[line++] = 0x0000;					  //color-1
    1344:	move.w d2,d6
    1346:	addq.w #4,d6
    1348:	movea.w a0,a0
    134a:	adda.l a0,a0
    134c:	clr.w (0,a0,a2.l)
		vpos += 2;
    1350:	move.b d3,d4
    1352:	addq.b #2,d4

		hpos = (7 * hpos) % 255;
    1354:	andi.l #65535,d0
    135a:	move.l d0,d1
    135c:	lsl.l #3,d1
    135e:	pea ff <MoveBobs+0x73>
    1362:	sub.l d0,d1
    1364:	move.l d1,-(sp)
    1366:	jsr (a3)
    1368:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    136a:	move.b d4,d1
    136c:	ext.w d1
    136e:	move.w d1,d4
    1370:	ext.l d4
    1372:	lsl.l #8,d4
    1374:	move.w d0,d7
    1376:	andi.w #255,d7
    137a:	movea.w d2,a0
    137c:	addq.w #5,a0
    137e:	movea.w d6,a1
    1380:	adda.l a1,a1
    1382:	or.w d4,d7
    1384:	move.w d7,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    1388:	addq.w #1,d1
    138a:	movea.w d2,a1
    138c:	addq.w #6,a1
    138e:	movea.w a0,a0
    1390:	lsl.w #8,d1
    1392:	adda.l a0,a0
    1394:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x0000;					  //color-2
    1398:	movea.w d2,a0
    139a:	addq.w #7,a0
    139c:	movea.w a1,a1
    139e:	adda.l a1,a1
    13a0:	clr.w (0,a1,a2.l)
		StarSprite[line++] = 0x8000;					  //color-2
    13a4:	addq.w #4,d6
    13a6:	movea.w a0,a0
    13a8:	adda.l a0,a0
    13aa:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    13b0:	move.b d3,d4
    13b2:	addq.b #4,d4

		hpos = (7 * hpos) % 255;
    13b4:	andi.l #65535,d0
    13ba:	move.l d0,d1
    13bc:	lsl.l #3,d1
    13be:	pea ff <MoveBobs+0x73>
    13c2:	sub.l d0,d1
    13c4:	move.l d1,-(sp)
    13c6:	jsr (a3)
    13c8:	addq.l #8,sp
    13ca:	movea.w d0,a1
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    13cc:	move.b d4,d1
    13ce:	ext.w d1
    13d0:	move.w d1,d4
    13d2:	ext.l d4
    13d4:	lsl.l #8,d4
    13d6:	andi.w #255,d0
    13da:	movea.w d2,a3
    13dc:	lea 9(a3),a3
    13e0:	movea.w d6,a0
    13e2:	adda.l a0,a0
    13e4:	or.w d4,d0
    13e6:	move.w d0,(0,a2,a0.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    13ea:	addq.w #1,d1
    13ec:	movea.w d2,a0
    13ee:	lea 10(a0),a0
    13f2:	movea.w a3,a3
    13f4:	lsl.w #8,d1
    13f6:	adda.l a3,a3
    13f8:	move.w d1,(0,a3,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    13fc:	movea.w a0,a0
    13fe:	adda.l a0,a0
    1400:	move.w #-32768,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    1406:	movea.w d2,a0
    1408:	lea 11(a0),a0
    140c:	movea.w a0,a0
    140e:	addi.w #12,d2
    1412:	adda.l a0,a0
    1414:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    141a:	addq.b #6,d3
	for (int l = 0; l < 31; l++)
    141c:	addq.l #1,d5
    141e:	moveq #30,d0
    1420:	cmp.l d5,d0
    1422:	bge.w 12e8 <InitStarfieldSprite+0x12>
	}
	// sprite end-mark
	StarSprite[line++] = 0;
    1426:	move.w d2,d0
    1428:	addq.w #1,d0
    142a:	ext.l d2
    142c:	lea 37a34 <StarSprite>,a1
    1432:	add.l d2,d2
    1434:	clr.w (0,a1,d2.l)
	StarSprite[line++] = 0;
    1438:	movea.w d0,a0
    143a:	adda.l a0,a0
    143c:	clr.w (0,a0,a1.l)
}
    1440:	movem.l (sp)+,d2-d7/a2-a3
    1444:	rts

00001446 <MoveStarfield>:

void MoveStarfield()
{
	for (int l = 1; l < 31 * 24; l += 24)
    1446:	movea.w #1,a0
    144a:	bra.s 147a <MoveStarfield+0x34>
	{
		((volatile UBYTE *)StarSprite)[l] += 1;
    144c:	movea.l a0,a1
    144e:	adda.l #227892,a1
    1454:	move.b (a1),d0
    1456:	addq.b #1,d0
    1458:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 8] += 2;
    145a:	movea.l a0,a1
    145c:	adda.l #227900,a1
    1462:	move.b (a1),d0
    1464:	addq.b #2,d0
    1466:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 16] += 3;
    1468:	movea.l a0,a1
    146a:	adda.l #227908,a1
    1470:	move.b (a1),d0
    1472:	addq.b #3,d0
    1474:	move.b d0,(a1)
	for (int l = 1; l < 31 * 24; l += 24)
    1476:	lea 24(a0),a0
    147a:	cmpa.w #743,a0
    147e:	ble.s 144c <MoveStarfield+0x6>
	}
}
    1480:	rts

00001482 <BuildLogo>:

void BuildLogo(BmpDescriptor d, short mode)
{
    1482:	move.l a2,-(sp)
    1484:	move.l d2,-(sp)
    1486:	move.w 66(sp),d0
	Point2D ps;
	Point2D pd;

	switch (mode)
    148a:	cmpi.w #2,d0
    148e:	beq.w 1800 <BuildLogo+0x37e>
    1492:	bgt.w 156c <BuildLogo+0xea>
    1496:	tst.w d0
    1498:	beq.w 159e <BuildLogo+0x11c>
    149c:	cmpi.w #1,d0
    14a0:	bne.w 15cc <BuildLogo+0x14a>
		}
		LogoShowDone = LogoShowY2 > 129;
		break;

	case 1:
		if (LogoShowY1 >= 0)
    14a4:	move.w 37d56 <LogoShowY1>,d2
    14aa:	bpl.w 173a <BuildLogo+0x2b8>
			pd.X = 32;
			pd.Y = LogoShowY1;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
			LogoShowY1 -= 2;
		}
		else if (LogoShowY2 >= 1)
    14ae:	move.w 7b98 <LogoShowY2>,d2
    14b4:	ble.w 17ea <BuildLogo+0x368>
		{
			ps.X = 0;
    14b8:	clr.l d0
    14ba:	clr.l d1
			ps.Y = LogoShowY2;
    14bc:	movea.w d2,a2
			pd.X = 32;
    14be:	movea.w #32,a0
    14c2:	suba.l a1,a1
			pd.Y = LogoShowY2;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    14c4:	pea 100 <MoveBobs+0x74>
    14c8:	pea 1 <_start+0x1>
    14cc:	move.l a2,-(sp)
    14ce:	move.l a0,-(sp)
    14d0:	move.l a2,-(sp)
    14d2:	move.l d0,-(sp)
    14d4:	subq.l #2,sp
    14d6:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    14dc:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    14e2:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    14e8:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    14ee:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    14f4:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    14fa:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1500:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1506:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    150c:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1512:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1518:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    151e:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1524:	subq.l #2,sp
    1526:	move.l 136(sp),-(sp)
    152a:	move.l 136(sp),-(sp)
    152e:	move.l 136(sp),-(sp)
    1532:	move.l 136(sp),-(sp)
    1536:	move.l 136(sp),-(sp)
    153a:	move.l 136(sp),-(sp)
    153e:	move.l 136(sp),-(sp)
    1542:	move.l 136(sp),-(sp)
    1546:	move.l 136(sp),-(sp)
    154a:	move.l 136(sp),-(sp)
    154e:	move.l 136(sp),-(sp)
    1552:	move.l 136(sp),-(sp)
    1556:	move.w 138(sp),-(sp)
    155a:	jsr ffa <SimpleBlit>(pc)
			LogoShowY2 -= 2;
    155e:	subq.w #2,7b98 <LogoShowY2>
    1564:	lea 128(sp),sp
    1568:	bra.w 17ea <BuildLogo+0x368>
	switch (mode)
    156c:	cmpi.w #3,d0
    1570:	bne.s 15cc <BuildLogo+0x14a>
		}
		LogoShowDone = LogoShowY2 > 129;
		break;
	
	case 3:
		if (LogoShowY1 <= 128)
    1572:	move.w 37d56 <LogoShowY1>,d2
    1578:	cmpi.w #128,d2
    157c:	ble.w 1994 <BuildLogo+0x512>
			pd.X = 32;
			pd.Y = LogoShowY1;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
			LogoShowY1 += 2;
		}
		else if (LogoShowY2 >= 1)
    1580:	move.w 7b98 <LogoShowY2>,d2
    1586:	bgt.w 1a48 <BuildLogo+0x5c6>
			pd.X = 32;
			pd.Y = LogoShowY2;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
			LogoShowY2 -= 2;
		}
		LogoShowDone = LogoShowY2 < 1;
    158a:	tst.w 7b98 <LogoShowY2>
    1590:	sle d0
    1592:	ext.w d0
    1594:	neg.w d0
    1596:	move.w d0,37d58 <LogoShowDone>
		break;
    159c:	bra.s 15cc <BuildLogo+0x14a>
		if (LogoShowY1 <= 128)
    159e:	move.w 37d56 <LogoShowY1>,d2
    15a4:	cmpi.w #128,d2
    15a8:	ble.s 15d2 <BuildLogo+0x150>
		else if (LogoShowY2 <= 129)
    15aa:	move.w 7b98 <LogoShowY2>,d2
    15b0:	cmpi.w #129,d2
    15b4:	ble.w 1686 <BuildLogo+0x204>
		LogoShowDone = LogoShowY2 > 129;
    15b8:	cmpi.w #129,7b98 <LogoShowY2>
    15c0:	sgt d0
    15c2:	ext.w d0
    15c4:	neg.w d0
    15c6:	move.w d0,37d58 <LogoShowDone>
	}
}
    15cc:	move.l (sp)+,d2
    15ce:	movea.l (sp)+,a2
    15d0:	rts
			ps.X = 0;
    15d2:	clr.l d0
    15d4:	clr.l d1
			ps.Y = LogoShowY1;
    15d6:	movea.w d2,a2
			pd.X = 32;
    15d8:	movea.w #32,a0
    15dc:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    15de:	pea 100 <MoveBobs+0x74>
    15e2:	pea 1 <_start+0x1>
    15e6:	move.l a2,-(sp)
    15e8:	move.l a0,-(sp)
    15ea:	move.l a2,-(sp)
    15ec:	move.l d0,-(sp)
    15ee:	subq.l #2,sp
    15f0:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    15f6:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    15fc:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    1602:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1608:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    160e:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1614:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    161a:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1620:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    1626:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    162c:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1632:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    1638:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    163e:	subq.l #2,sp
    1640:	move.l 136(sp),-(sp)
    1644:	move.l 136(sp),-(sp)
    1648:	move.l 136(sp),-(sp)
    164c:	move.l 136(sp),-(sp)
    1650:	move.l 136(sp),-(sp)
    1654:	move.l 136(sp),-(sp)
    1658:	move.l 136(sp),-(sp)
    165c:	move.l 136(sp),-(sp)
    1660:	move.l 136(sp),-(sp)
    1664:	move.l 136(sp),-(sp)
    1668:	move.l 136(sp),-(sp)
    166c:	move.l 136(sp),-(sp)
    1670:	move.w 138(sp),-(sp)
    1674:	jsr ffa <SimpleBlit>(pc)
			LogoShowY1 += 2;
    1678:	addq.w #2,37d56 <LogoShowY1>
    167e:	lea 128(sp),sp
    1682:	bra.w 15b8 <BuildLogo+0x136>
			ps.X = 0;
    1686:	clr.l d0
    1688:	clr.l d1
			ps.Y = LogoShowY2;
    168a:	movea.w d2,a2
			pd.X = 32;
    168c:	movea.w #32,a0
    1690:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1692:	pea 100 <MoveBobs+0x74>
    1696:	pea 1 <_start+0x1>
    169a:	move.l a2,-(sp)
    169c:	move.l a0,-(sp)
    169e:	move.l a2,-(sp)
    16a0:	move.l d0,-(sp)
    16a2:	subq.l #2,sp
    16a4:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    16aa:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    16b0:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    16b6:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    16bc:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    16c2:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    16c8:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    16ce:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    16d4:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    16da:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    16e0:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    16e6:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    16ec:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    16f2:	subq.l #2,sp
    16f4:	move.l 136(sp),-(sp)
    16f8:	move.l 136(sp),-(sp)
    16fc:	move.l 136(sp),-(sp)
    1700:	move.l 136(sp),-(sp)
    1704:	move.l 136(sp),-(sp)
    1708:	move.l 136(sp),-(sp)
    170c:	move.l 136(sp),-(sp)
    1710:	move.l 136(sp),-(sp)
    1714:	move.l 136(sp),-(sp)
    1718:	move.l 136(sp),-(sp)
    171c:	move.l 136(sp),-(sp)
    1720:	move.l 136(sp),-(sp)
    1724:	move.w 138(sp),-(sp)
    1728:	jsr ffa <SimpleBlit>(pc)
			LogoShowY2 += 2;
    172c:	addq.w #2,7b98 <LogoShowY2>
    1732:	lea 128(sp),sp
    1736:	bra.w 15b8 <BuildLogo+0x136>
			ps.X = 0;
    173a:	clr.l d0
    173c:	clr.l d1
			ps.Y = LogoShowY1;
    173e:	movea.w d2,a2
			pd.X = 32;
    1740:	movea.w #32,a0
    1744:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1746:	pea 100 <MoveBobs+0x74>
    174a:	pea 1 <_start+0x1>
    174e:	move.l a2,-(sp)
    1750:	move.l a0,-(sp)
    1752:	move.l a2,-(sp)
    1754:	move.l d0,-(sp)
    1756:	subq.l #2,sp
    1758:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    175e:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1764:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    176a:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1770:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1776:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    177c:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1782:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1788:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    178e:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1794:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    179a:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    17a0:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    17a6:	subq.l #2,sp
    17a8:	move.l 136(sp),-(sp)
    17ac:	move.l 136(sp),-(sp)
    17b0:	move.l 136(sp),-(sp)
    17b4:	move.l 136(sp),-(sp)
    17b8:	move.l 136(sp),-(sp)
    17bc:	move.l 136(sp),-(sp)
    17c0:	move.l 136(sp),-(sp)
    17c4:	move.l 136(sp),-(sp)
    17c8:	move.l 136(sp),-(sp)
    17cc:	move.l 136(sp),-(sp)
    17d0:	move.l 136(sp),-(sp)
    17d4:	move.l 136(sp),-(sp)
    17d8:	move.w 138(sp),-(sp)
    17dc:	jsr ffa <SimpleBlit>(pc)
			LogoShowY1 -= 2;
    17e0:	subq.w #2,37d56 <LogoShowY1>
    17e6:	lea 128(sp),sp
		LogoShowDone = LogoShowY2 < 1;
    17ea:	tst.w 7b98 <LogoShowY2>
    17f0:	sle d0
    17f2:	ext.w d0
    17f4:	neg.w d0
    17f6:	move.w d0,37d58 <LogoShowDone>
		break;
    17fc:	bra.w 15cc <BuildLogo+0x14a>
		if (LogoShowY1 >= 0)
    1800:	move.w 37d56 <LogoShowY1>,d2
    1806:	bpl.w 18cc <BuildLogo+0x44a>
		else if (LogoShowY2 <= 129)
    180a:	move.w 7b98 <LogoShowY2>,d2
    1810:	cmpi.w #129,d2
    1814:	bgt.w 197c <BuildLogo+0x4fa>
			ps.X = 0;
    1818:	clr.l d0
    181a:	clr.l d1
			ps.Y = LogoShowY2;
    181c:	movea.w d2,a2
			pd.X = 32;
    181e:	movea.w #32,a0
    1822:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1824:	pea 100 <MoveBobs+0x74>
    1828:	pea 1 <_start+0x1>
    182c:	move.l a2,-(sp)
    182e:	move.l a0,-(sp)
    1830:	move.l a2,-(sp)
    1832:	move.l d0,-(sp)
    1834:	subq.l #2,sp
    1836:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    183c:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1842:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    1848:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    184e:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1854:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    185a:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1860:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1866:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    186c:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1872:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1878:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    187e:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1884:	subq.l #2,sp
    1886:	move.l 136(sp),-(sp)
    188a:	move.l 136(sp),-(sp)
    188e:	move.l 136(sp),-(sp)
    1892:	move.l 136(sp),-(sp)
    1896:	move.l 136(sp),-(sp)
    189a:	move.l 136(sp),-(sp)
    189e:	move.l 136(sp),-(sp)
    18a2:	move.l 136(sp),-(sp)
    18a6:	move.l 136(sp),-(sp)
    18aa:	move.l 136(sp),-(sp)
    18ae:	move.l 136(sp),-(sp)
    18b2:	move.l 136(sp),-(sp)
    18b6:	move.w 138(sp),-(sp)
    18ba:	jsr ffa <SimpleBlit>(pc)
			LogoShowY2 += 2;
    18be:	addq.w #2,7b98 <LogoShowY2>
    18c4:	lea 128(sp),sp
    18c8:	bra.w 197c <BuildLogo+0x4fa>
			ps.X = 0;
    18cc:	clr.l d0
    18ce:	clr.l d1
			ps.Y = LogoShowY1;
    18d0:	movea.w d2,a2
			pd.X = 32;
    18d2:	movea.w #32,a0
    18d6:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    18d8:	pea 100 <MoveBobs+0x74>
    18dc:	pea 1 <_start+0x1>
    18e0:	move.l a2,-(sp)
    18e2:	move.l a0,-(sp)
    18e4:	move.l a2,-(sp)
    18e6:	move.l d0,-(sp)
    18e8:	subq.l #2,sp
    18ea:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    18f0:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    18f6:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    18fc:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1902:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1908:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    190e:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1914:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    191a:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    1920:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1926:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    192c:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    1932:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1938:	subq.l #2,sp
    193a:	move.l 136(sp),-(sp)
    193e:	move.l 136(sp),-(sp)
    1942:	move.l 136(sp),-(sp)
    1946:	move.l 136(sp),-(sp)
    194a:	move.l 136(sp),-(sp)
    194e:	move.l 136(sp),-(sp)
    1952:	move.l 136(sp),-(sp)
    1956:	move.l 136(sp),-(sp)
    195a:	move.l 136(sp),-(sp)
    195e:	move.l 136(sp),-(sp)
    1962:	move.l 136(sp),-(sp)
    1966:	move.l 136(sp),-(sp)
    196a:	move.w 138(sp),-(sp)
    196e:	jsr ffa <SimpleBlit>(pc)
			LogoShowY1 -= 2;
    1972:	subq.w #2,37d56 <LogoShowY1>
    1978:	lea 128(sp),sp
		LogoShowDone = LogoShowY2 > 129;
    197c:	cmpi.w #129,7b98 <LogoShowY2>
    1984:	sgt d0
    1986:	ext.w d0
    1988:	neg.w d0
    198a:	move.w d0,37d58 <LogoShowDone>
		break;
    1990:	bra.w 15cc <BuildLogo+0x14a>
			ps.X = 0;
    1994:	clr.l d0
    1996:	clr.l d1
			ps.Y = LogoShowY1;
    1998:	movea.w d2,a2
			pd.X = 32;
    199a:	movea.w #32,a0
    199e:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    19a0:	pea 100 <MoveBobs+0x74>
    19a4:	pea 1 <_start+0x1>
    19a8:	move.l a2,-(sp)
    19aa:	move.l a0,-(sp)
    19ac:	move.l a2,-(sp)
    19ae:	move.l d0,-(sp)
    19b0:	subq.l #2,sp
    19b2:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    19b8:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    19be:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    19c4:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    19ca:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    19d0:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    19d6:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    19dc:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    19e2:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    19e8:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    19ee:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    19f4:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    19fa:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1a00:	subq.l #2,sp
    1a02:	move.l 136(sp),-(sp)
    1a06:	move.l 136(sp),-(sp)
    1a0a:	move.l 136(sp),-(sp)
    1a0e:	move.l 136(sp),-(sp)
    1a12:	move.l 136(sp),-(sp)
    1a16:	move.l 136(sp),-(sp)
    1a1a:	move.l 136(sp),-(sp)
    1a1e:	move.l 136(sp),-(sp)
    1a22:	move.l 136(sp),-(sp)
    1a26:	move.l 136(sp),-(sp)
    1a2a:	move.l 136(sp),-(sp)
    1a2e:	move.l 136(sp),-(sp)
    1a32:	move.w 138(sp),-(sp)
    1a36:	jsr ffa <SimpleBlit>(pc)
			LogoShowY1 += 2;
    1a3a:	addq.w #2,37d56 <LogoShowY1>
    1a40:	lea 128(sp),sp
    1a44:	bra.w 158a <BuildLogo+0x108>
			ps.X = 0;
    1a48:	clr.l d0
    1a4a:	clr.l d1
			ps.Y = LogoShowY2;
    1a4c:	movea.w d2,a2
			pd.X = 32;
    1a4e:	movea.w #32,a0
    1a52:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1a54:	pea 100 <MoveBobs+0x74>
    1a58:	pea 1 <_start+0x1>
    1a5c:	move.l a2,-(sp)
    1a5e:	move.l a0,-(sp)
    1a60:	move.l a2,-(sp)
    1a62:	move.l d0,-(sp)
    1a64:	subq.l #2,sp
    1a66:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    1a6c:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1a72:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    1a78:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1a7e:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1a84:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1a8a:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1a90:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1a96:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    1a9c:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1aa2:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1aa8:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    1aae:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1ab4:	subq.l #2,sp
    1ab6:	move.l 136(sp),-(sp)
    1aba:	move.l 136(sp),-(sp)
    1abe:	move.l 136(sp),-(sp)
    1ac2:	move.l 136(sp),-(sp)
    1ac6:	move.l 136(sp),-(sp)
    1aca:	move.l 136(sp),-(sp)
    1ace:	move.l 136(sp),-(sp)
    1ad2:	move.l 136(sp),-(sp)
    1ad6:	move.l 136(sp),-(sp)
    1ada:	move.l 136(sp),-(sp)
    1ade:	move.l 136(sp),-(sp)
    1ae2:	move.l 136(sp),-(sp)
    1ae6:	move.w 138(sp),-(sp)
    1aea:	jsr ffa <SimpleBlit>(pc)
			LogoShowY2 -= 2;
    1aee:	subq.w #2,7b98 <LogoShowY2>
    1af4:	lea 128(sp),sp
    1af8:	bra.w 158a <BuildLogo+0x108>

00001afc <DissolveLogo>:

void DissolveLogo(short mode)
{
    1afc:	move.w 6(sp),d0
	switch (mode)
    1b00:	cmpi.w #2,d0
    1b04:	beq.w 1dc6 <DissolveLogo+0x2ca>
    1b08:	bgt.s 1b4c <DissolveLogo+0x50>
    1b0a:	tst.w d0
    1b0c:	beq.w 1bde <DissolveLogo+0xe2>
    1b10:	cmpi.w #1,d0
    1b14:	bne.w 1ce0 <DissolveLogo+0x1e4>
		}
		LogoDissolveDone = LogoShowY2 < 1;
		break;

	case 1:
		if (LogoShowY1 <= 128)
    1b18:	move.w 37d56 <LogoShowY1>,d0
    1b1e:	cmpi.w #128,d0
    1b22:	ble.w 1ce2 <DissolveLogo+0x1e6>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
			LogoShowY1 += 2;
		}
		else if (LogoShowY2 <= 129)
    1b26:	move.w 7b98 <LogoShowY2>,d0
    1b2c:	cmpi.w #129,d0
    1b30:	ble.w 1d54 <DissolveLogo+0x258>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
			LogoShowY2 += 2;
		}
		LogoDissolveDone = LogoShowY2 > 129;
    1b34:	cmpi.w #129,7b98 <LogoShowY2>
    1b3c:	sgt d0
    1b3e:	ext.w d0
    1b40:	neg.w d0
    1b42:	move.w d0,37d54 <LogoDissolveDone>
		break;
    1b48:	bra.w 1ce0 <DissolveLogo+0x1e4>
	switch (mode)
    1b4c:	cmpi.w #3,d0
    1b50:	bne.w 1ce0 <DissolveLogo+0x1e4>
		}
		LogoDissolveDone = LogoShowY2 < 1;
		break;
	
	case 3:
		if (LogoShowY1 >= 0)
    1b54:	move.w 37d56 <LogoShowY1>,d0
    1b5a:	bpl.w 1ed6 <DissolveLogo+0x3da>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
			LogoShowY1 -= 2;
		}
		else if (LogoShowY2 <= 129)
    1b5e:	move.w 7b98 <LogoShowY2>,d0
    1b64:	cmpi.w #129,d0
    1b68:	bgt.w 1f44 <DissolveLogo+0x448>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    1b6c:	pea 100 <MoveBobs+0x74>
    1b70:	pea 1 <_start+0x1>
    1b74:	movea.w d0,a0
    1b76:	move.l a0,-(sp)
    1b78:	pea 20 <_start+0x20>
    1b7c:	subq.l #2,sp
    1b7e:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    1b84:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1b8a:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    1b90:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1b96:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1b9c:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1ba2:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1ba8:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1bae:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    1bb4:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1bba:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1bc0:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    1bc6:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1bcc:	jsr f16 <ClearBitmapPart>(pc)
			LogoShowY2 += 2;
    1bd0:	addq.w #2,7b98 <LogoShowY2>
    1bd6:	lea 68(sp),sp
    1bda:	bra.w 1f44 <DissolveLogo+0x448>
		if (LogoShowY1 >= 0)
    1bde:	move.w 37d56 <LogoShowY1>,d0
    1be4:	bpl.s 1c60 <DissolveLogo+0x164>
		else if (LogoShowY2 >= 1)
    1be6:	move.w 7b98 <LogoShowY2>,d0
    1bec:	ble.w 1cce <DissolveLogo+0x1d2>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    1bf0:	pea 100 <MoveBobs+0x74>
    1bf4:	pea 1 <_start+0x1>
    1bf8:	movea.w d0,a0
    1bfa:	move.l a0,-(sp)
    1bfc:	pea 20 <_start+0x20>
    1c00:	subq.l #2,sp
    1c02:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    1c08:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1c0e:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    1c14:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1c1a:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1c20:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1c26:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1c2c:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1c32:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    1c38:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1c3e:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1c44:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    1c4a:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1c50:	jsr f16 <ClearBitmapPart>(pc)
			LogoShowY2 -= 2;
    1c54:	subq.w #2,7b98 <LogoShowY2>
    1c5a:	lea 68(sp),sp
    1c5e:	bra.s 1cce <DissolveLogo+0x1d2>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    1c60:	pea 100 <MoveBobs+0x74>
    1c64:	pea 1 <_start+0x1>
    1c68:	movea.w d0,a0
    1c6a:	move.l a0,-(sp)
    1c6c:	pea 20 <_start+0x20>
    1c70:	subq.l #2,sp
    1c72:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    1c78:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1c7e:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    1c84:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1c8a:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1c90:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1c96:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1c9c:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1ca2:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    1ca8:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1cae:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1cb4:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    1cba:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1cc0:	jsr f16 <ClearBitmapPart>(pc)
			LogoShowY1 -= 2;
    1cc4:	subq.w #2,37d56 <LogoShowY1>
    1cca:	lea 68(sp),sp
		LogoDissolveDone = LogoShowY2 < 1;
    1cce:	tst.w 7b98 <LogoShowY2>
    1cd4:	sle d0
    1cd6:	ext.w d0
    1cd8:	neg.w d0
    1cda:	move.w d0,37d54 <LogoDissolveDone>
		}
		LogoDissolveDone = LogoShowY2 > 129;
		break;
	}
    1ce0:	rts
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    1ce2:	pea 100 <MoveBobs+0x74>
    1ce6:	pea 1 <_start+0x1>
    1cea:	movea.w d0,a0
    1cec:	move.l a0,-(sp)
    1cee:	pea 20 <_start+0x20>
    1cf2:	subq.l #2,sp
    1cf4:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    1cfa:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1d00:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    1d06:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1d0c:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1d12:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1d18:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1d1e:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1d24:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    1d2a:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1d30:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1d36:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    1d3c:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1d42:	jsr f16 <ClearBitmapPart>(pc)
			LogoShowY1 += 2;
    1d46:	addq.w #2,37d56 <LogoShowY1>
    1d4c:	lea 68(sp),sp
    1d50:	bra.w 1b34 <DissolveLogo+0x38>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    1d54:	pea 100 <MoveBobs+0x74>
    1d58:	pea 1 <_start+0x1>
    1d5c:	movea.w d0,a0
    1d5e:	move.l a0,-(sp)
    1d60:	pea 20 <_start+0x20>
    1d64:	subq.l #2,sp
    1d66:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    1d6c:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1d72:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    1d78:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1d7e:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1d84:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1d8a:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1d90:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1d96:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    1d9c:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1da2:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1da8:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    1dae:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1db4:	jsr f16 <ClearBitmapPart>(pc)
			LogoShowY2 += 2;
    1db8:	addq.w #2,7b98 <LogoShowY2>
    1dbe:	lea 68(sp),sp
    1dc2:	bra.w 1b34 <DissolveLogo+0x38>
		if (LogoShowY1 <= 128)
    1dc6:	move.w 37d56 <LogoShowY1>,d0
    1dcc:	cmpi.w #128,d0
    1dd0:	ble.s 1df2 <DissolveLogo+0x2f6>
		else if (LogoShowY2 >= 1)
    1dd2:	move.w 7b98 <LogoShowY2>,d0
    1dd8:	bgt.w 1e64 <DissolveLogo+0x368>
		LogoDissolveDone = LogoShowY2 < 1;
    1ddc:	tst.w 7b98 <LogoShowY2>
    1de2:	sle d0
    1de4:	ext.w d0
    1de6:	neg.w d0
    1de8:	move.w d0,37d54 <LogoDissolveDone>
		break;
    1dee:	bra.w 1ce0 <DissolveLogo+0x1e4>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    1df2:	pea 100 <MoveBobs+0x74>
    1df6:	pea 1 <_start+0x1>
    1dfa:	movea.w d0,a0
    1dfc:	move.l a0,-(sp)
    1dfe:	pea 20 <_start+0x20>
    1e02:	subq.l #2,sp
    1e04:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    1e0a:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1e10:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    1e16:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1e1c:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1e22:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1e28:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1e2e:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1e34:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    1e3a:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1e40:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1e46:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    1e4c:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1e52:	jsr f16 <ClearBitmapPart>(pc)
			LogoShowY1 += 2;
    1e56:	addq.w #2,37d56 <LogoShowY1>
    1e5c:	lea 68(sp),sp
    1e60:	bra.w 1ddc <DissolveLogo+0x2e0>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    1e64:	pea 100 <MoveBobs+0x74>
    1e68:	pea 1 <_start+0x1>
    1e6c:	movea.w d0,a0
    1e6e:	move.l a0,-(sp)
    1e70:	pea 20 <_start+0x20>
    1e74:	subq.l #2,sp
    1e76:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    1e7c:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1e82:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    1e88:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1e8e:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1e94:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1e9a:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1ea0:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1ea6:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    1eac:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1eb2:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1eb8:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    1ebe:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1ec4:	jsr f16 <ClearBitmapPart>(pc)
			LogoShowY2 -= 2;
    1ec8:	subq.w #2,7b98 <LogoShowY2>
    1ece:	lea 68(sp),sp
    1ed2:	bra.w 1ddc <DissolveLogo+0x2e0>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    1ed6:	pea 100 <MoveBobs+0x74>
    1eda:	pea 1 <_start+0x1>
    1ede:	movea.w d0,a0
    1ee0:	move.l a0,-(sp)
    1ee2:	pea 20 <_start+0x20>
    1ee6:	subq.l #2,sp
    1ee8:	move.l 37eba <BmpUpperPart_PF1+0x2e>,-(sp)
    1eee:	move.l 37eb6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1ef4:	move.l 37eb2 <BmpUpperPart_PF1+0x26>,-(sp)
    1efa:	move.l 37eae <BmpUpperPart_PF1+0x22>,-(sp)
    1f00:	move.l 37eaa <BmpUpperPart_PF1+0x1e>,-(sp)
    1f06:	move.l 37ea6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1f0c:	move.l 37ea2 <BmpUpperPart_PF1+0x16>,-(sp)
    1f12:	move.l 37e9e <BmpUpperPart_PF1+0x12>,-(sp)
    1f18:	move.l 37e9a <BmpUpperPart_PF1+0xe>,-(sp)
    1f1e:	move.l 37e96 <BmpUpperPart_PF1+0xa>,-(sp)
    1f24:	move.l 37e92 <BmpUpperPart_PF1+0x6>,-(sp)
    1f2a:	move.l 37e8e <BmpUpperPart_PF1+0x2>,-(sp)
    1f30:	move.w 37e8c <BmpUpperPart_PF1>,-(sp)
    1f36:	jsr f16 <ClearBitmapPart>(pc)
			LogoShowY1 -= 2;
    1f3a:	subq.w #2,37d56 <LogoShowY1>
    1f40:	lea 68(sp),sp
		LogoDissolveDone = LogoShowY2 > 129;
    1f44:	cmpi.w #129,7b98 <LogoShowY2>
    1f4c:	sgt d0
    1f4e:	ext.w d0
    1f50:	neg.w d0
    1f52:	move.w d0,37d54 <LogoDissolveDone>
		break;
    1f58:	bra.w 1ce0 <DissolveLogo+0x1e4>

00001f5c <MainLoop>:
{
    1f5c:	link.w a5,#-52
    1f60:	movem.l d2-d7/a2-a4,-(sp)
	BmpDescriptor bmd = BmpLogo;
    1f64:	move.l 37f54 <BmpLogo>,-50(a5)
    1f6c:	move.l 37f58 <BmpLogo+0x4>,-46(a5)
    1f74:	move.l 37f5c <BmpLogo+0x8>,-42(a5)
    1f7c:	move.l 37f60 <BmpLogo+0xc>,-38(a5)
    1f84:	move.l 37f64 <BmpLogo+0x10>,-34(a5)
    1f8c:	move.l 37f68 <BmpLogo+0x14>,-30(a5)
    1f94:	move.l 37f6c <BmpLogo+0x18>,-26(a5)
    1f9c:	move.l 37f70 <BmpLogo+0x1c>,-22(a5)
    1fa4:	move.l 37f74 <BmpLogo+0x20>,-18(a5)
    1fac:	move.l 37f78 <BmpLogo+0x24>,-14(a5)
    1fb4:	move.l 37f7c <BmpLogo+0x28>,-10(a5)
    1fbc:	move.l 37f80 <BmpLogo+0x2c>,-6(a5)
    1fc4:	move.w 37f84 <BmpLogo+0x30>,-2(a5)
	short dissolveMode = 3;
    1fcc:	moveq #3,d6
	short logoMode = 0;
    1fce:	clr.w d5
	short bmpCnt = 0;
    1fd0:	clr.w d4
    1fd2:	bra.w 2fb6 <MainLoop+0x105a>
		else if (LogoShowPhase % 2 == 0)
    1fd6:	move.b 37d5a <LogoShowPhase>,d0
    1fdc:	btst #0,d0
    1fe0:	bne.w 2098 <MainLoop+0x13c>
			if (bmpCnt > 3)
    1fe4:	cmpi.w #3,d4
    1fe8:	ble.s 1fec <MainLoop+0x90>
				bmpCnt = 0;
    1fea:	clr.w d4
			if (LogoShowDone)
    1fec:	tst.w 37d58 <LogoShowDone>
    1ff2:	beq.s 2018 <MainLoop+0xbc>
				LogoShowPhase++;
    1ff4:	addq.b #1,d0
    1ff6:	move.b d0,37d5a <LogoShowPhase>
				if (dissolveMode == 0)
    1ffc:	tst.w d6
    1ffe:	bne.s 204a <MainLoop+0xee>
					LogoShowY1 = 0;
    2000:	clr.w 37d56 <LogoShowY1>
					LogoShowY2 = 1;
    2006:	move.w #1,7b98 <LogoShowY2>
					dissolveMode = 1;
    200e:	moveq #1,d6
				LogoShowPause = 6 * 50;
    2010:	move.w #300,7b9a <LogoShowPause>
			BuildLogo(bmd, logoMode);
    2018:	movea.w d5,a0
    201a:	move.l a0,-(sp)
    201c:	subq.l #2,sp
    201e:	lea -4(a5),a0
    2022:	move.l (a0),-(sp)
    2024:	move.l -(a0),-(sp)
    2026:	move.l -(a0),-(sp)
    2028:	move.l -(a0),-(sp)
    202a:	move.l -(a0),-(sp)
    202c:	move.l -(a0),-(sp)
    202e:	move.l -(a0),-(sp)
    2030:	move.l -(a0),-(sp)
    2032:	move.l -(a0),-(sp)
    2034:	move.l -(a0),-(sp)
    2036:	move.l -(a0),-(sp)
    2038:	move.l -(a0),-(sp)
    203a:	move.w -2(a0),-(sp)
    203e:	jsr 1482 <BuildLogo>(pc)
    2042:	lea 56(sp),sp
    2046:	bra.w 2fda <MainLoop+0x107e>
				else if (dissolveMode == 1)
    204a:	cmpi.w #1,d6
    204e:	beq.s 2070 <MainLoop+0x114>
				else if (dissolveMode == 2)
    2050:	cmpi.w #2,d6
    2054:	beq.s 2082 <MainLoop+0x126>
				else if (dissolveMode == 3)
    2056:	cmpi.w #3,d6
    205a:	bne.s 2010 <MainLoop+0xb4>
					LogoShowY1 = 128;
    205c:	move.w #128,37d56 <LogoShowY1>
					LogoShowY2 = 129;
    2064:	move.w #129,7b98 <LogoShowY2>
					dissolveMode = 0;
    206c:	clr.w d6
    206e:	bra.s 2010 <MainLoop+0xb4>
					LogoShowY1 = 0;
    2070:	clr.w 37d56 <LogoShowY1>
					LogoShowY2 = 129;
    2076:	move.w #129,7b98 <LogoShowY2>
					dissolveMode = 2;
    207e:	moveq #2,d6
    2080:	bra.s 2010 <MainLoop+0xb4>
					LogoShowY1 = 128;
    2082:	move.w #128,37d56 <LogoShowY1>
					LogoShowY2 = 1;
    208a:	move.w #1,7b98 <LogoShowY2>
					dissolveMode = 3;
    2092:	moveq #3,d6
    2094:	bra.w 2010 <MainLoop+0xb4>
			if (LogoDissolveDone)
    2098:	tst.w 37d54 <LogoDissolveDone>
    209e:	beq.s 20f6 <MainLoop+0x19a>
				LogoShowPhase++;
    20a0:	addq.b #1,d0
    20a2:	move.b d0,37d5a <LogoShowPhase>
				LogoShowPause = 2 * 50;
    20a8:	move.w #100,7b9a <LogoShowPause>
				bmpCnt++;
    20b0:	addq.w #1,d4
				if (bmpCnt % 4 == 0)
    20b2:	move.w d4,d0
    20b4:	andi.w #3,d0
    20b8:	beq.s 2104 <MainLoop+0x1a8>
				else if (bmpCnt % 4 == 1)
    20ba:	move.w d4,d0
    20bc:	andi.w #-32765,d0
    20c0:	tst.w d4
    20c2:	blt.w 2154 <MainLoop+0x1f8>
    20c6:	cmpi.w #1,d0
    20ca:	beq.w 2160 <MainLoop+0x204>
				else if (bmpCnt % 4 == 2)
    20ce:	cmpi.w #2,d0
    20d2:	beq.w 21b2 <MainLoop+0x256>
				else if (bmpCnt % 4 == 3)
    20d6:	cmpi.w #3,d0
    20da:	beq.w 2202 <MainLoop+0x2a6>
				if (logoMode == 0)
    20de:	tst.w d5
    20e0:	bne.w 2252 <MainLoop+0x2f6>
					LogoShowY1 = 128;
    20e4:	move.w #128,37d56 <LogoShowY1>
					LogoShowY2 = 129;
    20ec:	move.w #129,7b98 <LogoShowY2>
					logoMode = 1;
    20f4:	moveq #1,d5
			DissolveLogo(dissolveMode);
    20f6:	movea.w d6,a0
    20f8:	move.l a0,-(sp)
    20fa:	jsr 1afc <DissolveLogo>(pc)
    20fe:	addq.l #4,sp
    2100:	bra.w 2fda <MainLoop+0x107e>
					bmd = BmpLogo;
    2104:	pea 32 <_start+0x32>
    2108:	pea 37f54 <BmpLogo>
    210e:	pea -50(a5)
    2112:	jsr 361e <memcpy>(pc)
					colP = copPF1ColP;
    2116:	movea.l 37d50 <copPF1ColP>,a0
    211c:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    2120:	moveq #1,d0
    2122:	bra.s 214c <MainLoop+0x1f0>
						ActPfCol = LogoPaletteRGB4;
    2124:	move.l #31620,7b94 <ActPfCol>
						colP = copSetColor(colP, a, LogoPaletteRGB4[a]);
    212e:	move.l d0,d1
    2130:	add.l d0,d1
    2132:	lea 7b84 <LogoPaletteRGB4>,a1
    2138:	move.w (0,a1,d1.l),2(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    213e:	move.w d0,d1
    2140:	addi.w #192,d1
    2144:	add.w d1,d1
    2146:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    2148:	addq.l #1,d0
						colP = copSetColor(colP, a, LogoPaletteRGB4[a]);
    214a:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    214c:	moveq #7,d1
    214e:	cmp.l d0,d1
    2150:	bge.s 2124 <MainLoop+0x1c8>
    2152:	bra.s 20de <MainLoop+0x182>
				else if (bmpCnt % 4 == 1)
    2154:	subq.w #1,d0
    2156:	ori.w #-4,d0
    215a:	addq.w #1,d0
    215c:	bra.w 20c6 <MainLoop+0x16a>
					bmd = BmpLogo2;
    2160:	pea 32 <_start+0x32>
    2164:	pea 37f22 <BmpLogo2>
    216a:	pea -50(a5)
    216e:	jsr 361e <memcpy>(pc)
					colP = copPF1ColP;
    2172:	movea.l 37d50 <copPF1ColP>,a0
    2178:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    217c:	moveq #1,d0
    217e:	bra.s 21a8 <MainLoop+0x24c>
						ActPfCol = BastardsPaletteRGB4;
    2180:	move.l #31604,7b94 <ActPfCol>
						colP = copSetColor(colP, a, BastardsPaletteRGB4[a]);
    218a:	move.l d0,d1
    218c:	add.l d0,d1
    218e:	lea 7b74 <BastardsPaletteRGB4>,a1
    2194:	move.w (0,a1,d1.l),2(a0)
    219a:	move.w d0,d1
    219c:	addi.w #192,d1
    21a0:	add.w d1,d1
    21a2:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    21a4:	addq.l #1,d0
						colP = copSetColor(colP, a, BastardsPaletteRGB4[a]);
    21a6:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    21a8:	moveq #7,d7
    21aa:	cmp.l d0,d7
    21ac:	bge.s 2180 <MainLoop+0x224>
    21ae:	bra.w 20de <MainLoop+0x182>
					bmd = BmpLogo3;
    21b2:	pea 32 <_start+0x32>
    21b6:	pea 37ef0 <BmpLogo3>
    21bc:	pea -50(a5)
    21c0:	jsr 361e <memcpy>(pc)
					colP = copPF1ColP;
    21c4:	movea.l 37d50 <copPF1ColP>,a0
    21ca:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    21ce:	moveq #1,d0
    21d0:	moveq #7,d1
    21d2:	cmp.l d0,d1
    21d4:	blt.w 20de <MainLoop+0x182>
						ActPfCol = bastard_tooPaletteRGB4;
    21d8:	move.l #31588,7b94 <ActPfCol>
						colP = copSetColor(colP, a, bastard_tooPaletteRGB4[a]);
    21e2:	move.l d0,d1
    21e4:	add.l d0,d1
    21e6:	lea 7b64 <bastard_tooPaletteRGB4>,a1
    21ec:	move.w (0,a1,d1.l),2(a0)
    21f2:	move.w d0,d1
    21f4:	addi.w #192,d1
    21f8:	add.w d1,d1
    21fa:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    21fc:	addq.l #1,d0
						colP = copSetColor(colP, a, bastard_tooPaletteRGB4[a]);
    21fe:	addq.l #4,a0
    2200:	bra.s 21d0 <MainLoop+0x274>
					bmd = BmpLogo4;
    2202:	pea 32 <_start+0x32>
    2206:	pea 37ebe <BmpLogo4>
    220c:	pea -50(a5)
    2210:	jsr 361e <memcpy>(pc)
					colP = copPF1ColP;
    2214:	movea.l 37d50 <copPF1ColP>,a0
    221a:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    221e:	moveq #1,d0
    2220:	moveq #7,d7
    2222:	cmp.l d0,d7
    2224:	blt.w 20de <MainLoop+0x182>
						ActPfCol = bastard_threePaletteRGB4;
    2228:	move.l #31572,7b94 <ActPfCol>
						colP = copSetColor(colP, a, bastard_threePaletteRGB4[a]);
    2232:	move.l d0,d1
    2234:	add.l d0,d1
    2236:	lea 7b54 <bastard_threePaletteRGB4>,a1
    223c:	move.w (0,a1,d1.l),2(a0)
    2242:	move.w d0,d1
    2244:	addi.w #192,d1
    2248:	add.w d1,d1
    224a:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    224c:	addq.l #1,d0
						colP = copSetColor(colP, a, bastard_threePaletteRGB4[a]);
    224e:	addq.l #4,a0
    2250:	bra.s 2220 <MainLoop+0x2c4>
				else if (logoMode == 1)
    2252:	cmpi.w #1,d5
    2256:	beq.s 227a <MainLoop+0x31e>
				else if (logoMode == 2)
    2258:	cmpi.w #2,d5
    225c:	beq.s 2290 <MainLoop+0x334>
				else if (logoMode == 3)
    225e:	cmpi.w #3,d5
    2262:	bne.w 20f6 <MainLoop+0x19a>
					LogoShowY1 = 0;
    2266:	clr.w 37d56 <LogoShowY1>
					LogoShowY2 = 1;
    226c:	move.w #1,7b98 <LogoShowY2>
					logoMode = 0;
    2274:	clr.w d5
    2276:	bra.w 20f6 <MainLoop+0x19a>
					LogoShowY1 = 128;
    227a:	move.w #128,37d56 <LogoShowY1>
					LogoShowY2 = 1;
    2282:	move.w #1,7b98 <LogoShowY2>
					logoMode = 2;
    228a:	moveq #2,d5
    228c:	bra.w 20f6 <MainLoop+0x19a>
					LogoShowY1 = 0;
    2290:	clr.w 37d56 <LogoShowY1>
					LogoShowY2 = 129;
    2296:	move.w #129,7b98 <LogoShowY2>
					logoMode = 3;
    229e:	moveq #3,d5
    22a0:	bra.w 20f6 <MainLoop+0x19a>
			SetupCopper(copPtr);
    22a4:	move.l 37d5c <copPtr>,-(sp)
    22aa:	jsr 25a <SetupCopper>(pc)
			custom->cop1lc = (ULONG)copPtr;
    22ae:	movea.l 37fc6 <custom>,a0
    22b4:	move.l 37d5c <copPtr>,128(a0)
			custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    22bc:	move.w #64,150(a0)
			custom->copjmp1 = 0x7fff;	   //start coppper
    22c2:	move.w #32767,136(a0)
			custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    22c8:	move.w #-30752,150(a0)
			ResetCopper = FALSE;
    22ce:	clr.w 37d4e <ResetCopper>
    22d4:	addq.l #4,sp
    22d6:	bra.w 2fe4 <MainLoop+0x1088>
					ScrollerDir = 1;
    22da:	move.b #1,7b52 <ScrollerDir>
    22e2:	bra.w 30de <MainLoop+0x1182>
				if (ScrollerDir > -5)
    22e6:	cmpi.b #-4,d0
    22ea:	blt.w 30de <MainLoop+0x1182>
					ScrollerDir--;
    22ee:	subq.b #1,d0
    22f0:	move.b d0,7b52 <ScrollerDir>
    22f6:	bra.w 30de <MainLoop+0x1182>
			if (ScrollerPause > 0)
    22fa:	move.w 37d48 <ScrollerPause>,d0
    2300:	beq.w 30ec <MainLoop+0x1190>
				ScrollerPause--;
    2304:	subq.w #1,d0
    2306:	move.w d0,37d48 <ScrollerPause>
    230c:	bra.w 30ec <MainLoop+0x1190>
		else if (ScrollerY <= ScrollerMin)
    2310:	cmpa.w #0,a0
    2314:	bgt.w 3108 <MainLoop+0x11ac>
			ScrollerY = ScrollerMin;
    2318:	clr.w 37d4a <ScrollerY>
			ScrollerDir = 1;
    231e:	move.b #1,7b52 <ScrollerDir>
			if (ScrollerPause > 0)
    2326:	move.w 37d48 <ScrollerPause>,d0
    232c:	beq.w 3108 <MainLoop+0x11ac>
				ScrollerPause--;
    2330:	subq.w #1,d0
    2332:	move.w d0,37d48 <ScrollerPause>
    2338:	bra.w 3108 <MainLoop+0x11ac>
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    233c:	pea 4 <_start+0x4>
    2340:	pea 20 <_start+0x20>
    2344:	pea 28 <_start+0x28>
    2348:	move.l 37e04 <BmpScroller+0xe>,-(sp)
    234e:	subq.l #2,sp
    2350:	move.l 37e24 <BmpScroller+0x2e>,-(sp)
    2356:	move.l 37e20 <BmpScroller+0x2a>,-(sp)
    235c:	move.l 37e1c <BmpScroller+0x26>,-(sp)
    2362:	move.l 37e18 <BmpScroller+0x22>,-(sp)
    2368:	move.l 37e14 <BmpScroller+0x1e>,-(sp)
    236e:	move.l 37e10 <BmpScroller+0x1a>,-(sp)
    2374:	move.l 37e0c <BmpScroller+0x16>,-(sp)
    237a:	move.l 37e08 <BmpScroller+0x12>,-(sp)
    2380:	move.l 37e04 <BmpScroller+0xe>,-(sp)
    2386:	move.l 37e00 <BmpScroller+0xa>,-(sp)
    238c:	move.l 37dfc <BmpScroller+0x6>,-(sp)
    2392:	move.l 37df8 <BmpScroller+0x2>,-(sp)
    2398:	move.w 37df6 <BmpScroller>,-(sp)
    239e:	jsr aae <Scrollit>(pc)
    23a2:	lea 68(sp),sp
    23a6:	bra.w 3112 <MainLoop+0x11b6>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
    23aa:	moveq #56,d7
    23ac:	add.l d7,d1
    23ae:	add.w d1,d1
    23b0:	add.w d1,d1
    23b2:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    23b4:	move.l d0,d7
    23b6:	clr.w d7
    23b8:	swap d7
    23ba:	move.w d7,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
    23be:	addq.w #2,d1
    23c0:	move.w d1,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    23c4:	move.w d0,6(a2)
        addr += Bpl;
    23c8:	add.l d3,d0
    for (USHORT i = 0; i < numPlanes; i++)
    23ca:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
    23cc:	addq.l #8,a2
    for (USHORT i = 0; i < numPlanes; i++)
    23ce:	moveq #0,d1
    23d0:	move.w a0,d1
    23d2:	cmp.l d2,d1
    23d4:	blt.s 23aa <MainLoop+0x44e>
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[0].X, BobTarget[0].Y, 32, 32);
    23d6:	pea 20 <_start+0x20>
    23da:	pea 20 <_start+0x20>
    23de:	move.l 7b16 <BobTarget+0x4>,-(sp)
    23e4:	move.l 7b12 <BobTarget>,-(sp)
    23ea:	subq.l #2,sp
    23ec:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    23f2:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    23f8:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    23fe:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    2404:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    240a:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2410:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    2416:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    241c:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    2422:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    2428:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    242e:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    2434:	lea 37e28 <BmpUpperPart_Buf1>,a3
    243a:	move.w (a3),-(sp)
    243c:	lea f16 <ClearBitmapPart>(pc),a2
    2440:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[1].X, BobTarget[1].Y, 32, 32);
    2442:	lea 68(sp),sp
    2446:	pea 20 <_start+0x20>
    244a:	pea 20 <_start+0x20>
    244e:	move.l 7b1e <BobTarget+0xc>,-(sp)
    2454:	move.l 7b1a <BobTarget+0x8>,-(sp)
    245a:	subq.l #2,sp
    245c:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2462:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2468:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    246e:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    2474:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    247a:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2480:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    2486:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    248c:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    2492:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    2498:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    249e:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    24a4:	move.w (a3),-(sp)
    24a6:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[2].X, BobTarget[2].Y, 32, 32);
    24a8:	lea 68(sp),sp
    24ac:	pea 20 <_start+0x20>
    24b0:	pea 20 <_start+0x20>
    24b4:	move.l 7b26 <BobTarget+0x14>,-(sp)
    24ba:	move.l 7b22 <BobTarget+0x10>,-(sp)
    24c0:	subq.l #2,sp
    24c2:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    24c8:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    24ce:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    24d4:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    24da:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    24e0:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    24e6:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    24ec:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    24f2:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    24f8:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    24fe:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    2504:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    250a:	move.w (a3),-(sp)
    250c:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[3].X, BobTarget[3].Y, 32, 32);
    250e:	lea 68(sp),sp
    2512:	pea 20 <_start+0x20>
    2516:	pea 20 <_start+0x20>
    251a:	move.l 7b2e <BobTarget+0x1c>,-(sp)
    2520:	move.l 7b2a <BobTarget+0x18>,-(sp)
    2526:	subq.l #2,sp
    2528:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    252e:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2534:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    253a:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    2540:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2546:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    254c:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    2552:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    2558:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    255e:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    2564:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    256a:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    2570:	move.w (a3),-(sp)
    2572:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[4].X, BobTarget[4].Y, 32, 32);
    2574:	lea 68(sp),sp
    2578:	pea 20 <_start+0x20>
    257c:	pea 20 <_start+0x20>
    2580:	move.l 7b36 <BobTarget+0x24>,-(sp)
    2586:	move.l 7b32 <BobTarget+0x20>,-(sp)
    258c:	subq.l #2,sp
    258e:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2594:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    259a:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    25a0:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    25a6:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    25ac:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    25b2:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    25b8:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    25be:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    25c4:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    25ca:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    25d0:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    25d6:	move.w (a3),-(sp)
    25d8:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[5].X, BobTarget[5].Y, 32, 32);
    25da:	lea 68(sp),sp
    25de:	pea 20 <_start+0x20>
    25e2:	pea 20 <_start+0x20>
    25e6:	move.l 7b3e <BobTarget+0x2c>,-(sp)
    25ec:	move.l 7b3a <BobTarget+0x28>,-(sp)
    25f2:	subq.l #2,sp
    25f4:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    25fa:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2600:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    2606:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    260c:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2612:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2618:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    261e:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    2624:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    262a:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    2630:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    2636:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    263c:	move.w (a3),-(sp)
    263e:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[6].X, BobTarget[6].Y, 32, 32);
    2640:	lea 68(sp),sp
    2644:	pea 20 <_start+0x20>
    2648:	pea 20 <_start+0x20>
    264c:	move.l 7b46 <BobTarget+0x34>,-(sp)
    2652:	move.l 7b42 <BobTarget+0x30>,-(sp)
    2658:	subq.l #2,sp
    265a:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2660:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2666:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    266c:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    2672:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2678:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    267e:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    2684:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    268a:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    2690:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    2696:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    269c:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    26a2:	move.w (a3),-(sp)
    26a4:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[7].X, BobTarget[7].Y, 32, 32);
    26a6:	lea 68(sp),sp
    26aa:	pea 20 <_start+0x20>
    26ae:	pea 20 <_start+0x20>
    26b2:	move.l 7b4e <BobTarget+0x3c>,-(sp)
    26b8:	move.l 7b4a <BobTarget+0x38>,-(sp)
    26be:	subq.l #2,sp
    26c0:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    26c6:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    26cc:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    26d2:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    26d8:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    26de:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    26e4:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    26ea:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    26f0:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    26f6:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    26fc:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    2702:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    2708:	move.w (a3),-(sp)
    270a:	jsr (a2)
		if (BobPause > 0)
    270c:	move.w 37d42 <BobPause>,d0
    2712:	lea 68(sp),sp
    2716:	beq.w 3150 <MainLoop+0x11f4>
			BobPause--;
    271a:	subq.w #1,d0
    271c:	move.w d0,37d42 <BobPause>
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[0], BobTarget[0], 32, 32);
    2722:	pea 20 <_start+0x20>
    2726:	pea 20 <_start+0x20>
    272a:	move.l 7b16 <BobTarget+0x4>,-(sp)
    2730:	move.l 7b12 <BobTarget>,-(sp)
    2736:	move.l 5a90 <BobSource+0x4>,-(sp)
    273c:	move.l 5a8c <BobSource>,-(sp)
    2742:	subq.l #2,sp
    2744:	move.l 37d8e <BmpCookieMask+0x2e>,-(sp)
    274a:	move.l 37d8a <BmpCookieMask+0x2a>,-(sp)
    2750:	move.l 37d86 <BmpCookieMask+0x26>,-(sp)
    2756:	move.l 37d82 <BmpCookieMask+0x22>,-(sp)
    275c:	move.l 37d7e <BmpCookieMask+0x1e>,-(sp)
    2762:	move.l 37d7a <BmpCookieMask+0x1a>,-(sp)
    2768:	move.l 37d76 <BmpCookieMask+0x16>,-(sp)
    276e:	move.l 37d72 <BmpCookieMask+0x12>,-(sp)
    2774:	move.l 37d6e <BmpCookieMask+0xe>,-(sp)
    277a:	move.l 37d6a <BmpCookieMask+0xa>,-(sp)
    2780:	move.l 37d66 <BmpCookieMask+0x6>,-(sp)
    2786:	move.l 37d62 <BmpCookieMask+0x2>,-(sp)
    278c:	lea 37d60 <BmpCookieMask>,a0
    2792:	move.w (a0),-(sp)
    2794:	subq.l #2,sp
    2796:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    279c:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    27a2:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    27a8:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    27ae:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    27b4:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    27ba:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    27c0:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    27c6:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    27cc:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    27d2:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    27d8:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    27de:	lea 37e28 <BmpUpperPart_Buf1>,a4
    27e4:	move.w (a4),-(sp)
    27e6:	subq.l #2,sp
    27e8:	move.l 37dc0 <BmpCookie+0x2e>,-(sp)
    27ee:	move.l 37dbc <BmpCookie+0x2a>,-(sp)
    27f4:	move.l 37db8 <BmpCookie+0x26>,-(sp)
    27fa:	move.l 37db4 <BmpCookie+0x22>,-(sp)
    2800:	move.l 37db0 <BmpCookie+0x1e>,-(sp)
    2806:	move.l 37dac <BmpCookie+0x1a>,-(sp)
    280c:	move.l 37da8 <BmpCookie+0x16>,-(sp)
    2812:	move.l 37da4 <BmpCookie+0x12>,-(sp)
    2818:	move.l 37da0 <BmpCookie+0xe>,-(sp)
    281e:	move.l 37d9c <BmpCookie+0xa>,-(sp)
    2824:	move.l 37d98 <BmpCookie+0x6>,-(sp)
    282a:	move.l 37d94 <BmpCookie+0x2>,-(sp)
    2830:	lea 37d92 <BmpCookie>,a3
    2836:	move.w (a3),-(sp)
    2838:	lea 10be <BetterBlit>(pc),a2
    283c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[1], BobTarget[1], 32, 32);
    283e:	lea 180(sp),sp
    2842:	pea 20 <_start+0x20>
    2846:	pea 20 <_start+0x20>
    284a:	move.l 7b1e <BobTarget+0xc>,-(sp)
    2850:	move.l 7b1a <BobTarget+0x8>,-(sp)
    2856:	move.l 5a98 <BobSource+0xc>,-(sp)
    285c:	move.l 5a94 <BobSource+0x8>,-(sp)
    2862:	subq.l #2,sp
    2864:	move.l 37d8e <BmpCookieMask+0x2e>,-(sp)
    286a:	move.l 37d8a <BmpCookieMask+0x2a>,-(sp)
    2870:	move.l 37d86 <BmpCookieMask+0x26>,-(sp)
    2876:	move.l 37d82 <BmpCookieMask+0x22>,-(sp)
    287c:	move.l 37d7e <BmpCookieMask+0x1e>,-(sp)
    2882:	move.l 37d7a <BmpCookieMask+0x1a>,-(sp)
    2888:	move.l 37d76 <BmpCookieMask+0x16>,-(sp)
    288e:	move.l 37d72 <BmpCookieMask+0x12>,-(sp)
    2894:	move.l 37d6e <BmpCookieMask+0xe>,-(sp)
    289a:	move.l 37d6a <BmpCookieMask+0xa>,-(sp)
    28a0:	move.l 37d66 <BmpCookieMask+0x6>,-(sp)
    28a6:	move.l 37d62 <BmpCookieMask+0x2>,-(sp)
    28ac:	lea 37d60 <BmpCookieMask>,a0
    28b2:	move.w (a0),-(sp)
    28b4:	subq.l #2,sp
    28b6:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    28bc:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    28c2:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    28c8:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    28ce:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    28d4:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    28da:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    28e0:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    28e6:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    28ec:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    28f2:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    28f8:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    28fe:	move.w (a4),-(sp)
    2900:	subq.l #2,sp
    2902:	move.l 37dc0 <BmpCookie+0x2e>,-(sp)
    2908:	move.l 37dbc <BmpCookie+0x2a>,-(sp)
    290e:	move.l 37db8 <BmpCookie+0x26>,-(sp)
    2914:	move.l 37db4 <BmpCookie+0x22>,-(sp)
    291a:	move.l 37db0 <BmpCookie+0x1e>,-(sp)
    2920:	move.l 37dac <BmpCookie+0x1a>,-(sp)
    2926:	move.l 37da8 <BmpCookie+0x16>,-(sp)
    292c:	move.l 37da4 <BmpCookie+0x12>,-(sp)
    2932:	move.l 37da0 <BmpCookie+0xe>,-(sp)
    2938:	move.l 37d9c <BmpCookie+0xa>,-(sp)
    293e:	move.l 37d98 <BmpCookie+0x6>,-(sp)
    2944:	move.l 37d94 <BmpCookie+0x2>,-(sp)
    294a:	move.w (a3),-(sp)
    294c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[2], BobTarget[2], 32, 32);
    294e:	lea 180(sp),sp
    2952:	pea 20 <_start+0x20>
    2956:	pea 20 <_start+0x20>
    295a:	move.l 7b26 <BobTarget+0x14>,-(sp)
    2960:	move.l 7b22 <BobTarget+0x10>,-(sp)
    2966:	move.l 5aa0 <BobSource+0x14>,-(sp)
    296c:	move.l 5a9c <BobSource+0x10>,-(sp)
    2972:	subq.l #2,sp
    2974:	move.l 37d8e <BmpCookieMask+0x2e>,-(sp)
    297a:	move.l 37d8a <BmpCookieMask+0x2a>,-(sp)
    2980:	move.l 37d86 <BmpCookieMask+0x26>,-(sp)
    2986:	move.l 37d82 <BmpCookieMask+0x22>,-(sp)
    298c:	move.l 37d7e <BmpCookieMask+0x1e>,-(sp)
    2992:	move.l 37d7a <BmpCookieMask+0x1a>,-(sp)
    2998:	move.l 37d76 <BmpCookieMask+0x16>,-(sp)
    299e:	move.l 37d72 <BmpCookieMask+0x12>,-(sp)
    29a4:	move.l 37d6e <BmpCookieMask+0xe>,-(sp)
    29aa:	move.l 37d6a <BmpCookieMask+0xa>,-(sp)
    29b0:	move.l 37d66 <BmpCookieMask+0x6>,-(sp)
    29b6:	move.l 37d62 <BmpCookieMask+0x2>,-(sp)
    29bc:	lea 37d60 <BmpCookieMask>,a0
    29c2:	move.w (a0),-(sp)
    29c4:	subq.l #2,sp
    29c6:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    29cc:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    29d2:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    29d8:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    29de:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    29e4:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    29ea:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    29f0:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    29f6:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    29fc:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    2a02:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    2a08:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    2a0e:	move.w (a4),-(sp)
    2a10:	subq.l #2,sp
    2a12:	move.l 37dc0 <BmpCookie+0x2e>,-(sp)
    2a18:	move.l 37dbc <BmpCookie+0x2a>,-(sp)
    2a1e:	move.l 37db8 <BmpCookie+0x26>,-(sp)
    2a24:	move.l 37db4 <BmpCookie+0x22>,-(sp)
    2a2a:	move.l 37db0 <BmpCookie+0x1e>,-(sp)
    2a30:	move.l 37dac <BmpCookie+0x1a>,-(sp)
    2a36:	move.l 37da8 <BmpCookie+0x16>,-(sp)
    2a3c:	move.l 37da4 <BmpCookie+0x12>,-(sp)
    2a42:	move.l 37da0 <BmpCookie+0xe>,-(sp)
    2a48:	move.l 37d9c <BmpCookie+0xa>,-(sp)
    2a4e:	move.l 37d98 <BmpCookie+0x6>,-(sp)
    2a54:	move.l 37d94 <BmpCookie+0x2>,-(sp)
    2a5a:	move.w (a3),-(sp)
    2a5c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[3], BobTarget[3], 32, 32);
    2a5e:	lea 180(sp),sp
    2a62:	pea 20 <_start+0x20>
    2a66:	pea 20 <_start+0x20>
    2a6a:	move.l 7b2e <BobTarget+0x1c>,-(sp)
    2a70:	move.l 7b2a <BobTarget+0x18>,-(sp)
    2a76:	move.l 5aa8 <BobSource+0x1c>,-(sp)
    2a7c:	move.l 5aa4 <BobSource+0x18>,-(sp)
    2a82:	subq.l #2,sp
    2a84:	move.l 37d8e <BmpCookieMask+0x2e>,-(sp)
    2a8a:	move.l 37d8a <BmpCookieMask+0x2a>,-(sp)
    2a90:	move.l 37d86 <BmpCookieMask+0x26>,-(sp)
    2a96:	move.l 37d82 <BmpCookieMask+0x22>,-(sp)
    2a9c:	move.l 37d7e <BmpCookieMask+0x1e>,-(sp)
    2aa2:	move.l 37d7a <BmpCookieMask+0x1a>,-(sp)
    2aa8:	move.l 37d76 <BmpCookieMask+0x16>,-(sp)
    2aae:	move.l 37d72 <BmpCookieMask+0x12>,-(sp)
    2ab4:	move.l 37d6e <BmpCookieMask+0xe>,-(sp)
    2aba:	move.l 37d6a <BmpCookieMask+0xa>,-(sp)
    2ac0:	move.l 37d66 <BmpCookieMask+0x6>,-(sp)
    2ac6:	move.l 37d62 <BmpCookieMask+0x2>,-(sp)
    2acc:	lea 37d60 <BmpCookieMask>,a0
    2ad2:	move.w (a0),-(sp)
    2ad4:	subq.l #2,sp
    2ad6:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2adc:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2ae2:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    2ae8:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    2aee:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2af4:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2afa:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    2b00:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    2b06:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    2b0c:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    2b12:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    2b18:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    2b1e:	move.w (a4),-(sp)
    2b20:	subq.l #2,sp
    2b22:	move.l 37dc0 <BmpCookie+0x2e>,-(sp)
    2b28:	move.l 37dbc <BmpCookie+0x2a>,-(sp)
    2b2e:	move.l 37db8 <BmpCookie+0x26>,-(sp)
    2b34:	move.l 37db4 <BmpCookie+0x22>,-(sp)
    2b3a:	move.l 37db0 <BmpCookie+0x1e>,-(sp)
    2b40:	move.l 37dac <BmpCookie+0x1a>,-(sp)
    2b46:	move.l 37da8 <BmpCookie+0x16>,-(sp)
    2b4c:	move.l 37da4 <BmpCookie+0x12>,-(sp)
    2b52:	move.l 37da0 <BmpCookie+0xe>,-(sp)
    2b58:	move.l 37d9c <BmpCookie+0xa>,-(sp)
    2b5e:	move.l 37d98 <BmpCookie+0x6>,-(sp)
    2b64:	move.l 37d94 <BmpCookie+0x2>,-(sp)
    2b6a:	move.w (a3),-(sp)
    2b6c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[4], BobTarget[4], 32, 32);
    2b6e:	lea 180(sp),sp
    2b72:	pea 20 <_start+0x20>
    2b76:	pea 20 <_start+0x20>
    2b7a:	move.l 7b36 <BobTarget+0x24>,-(sp)
    2b80:	move.l 7b32 <BobTarget+0x20>,-(sp)
    2b86:	move.l 5ab0 <BobSource+0x24>,-(sp)
    2b8c:	move.l 5aac <BobSource+0x20>,-(sp)
    2b92:	subq.l #2,sp
    2b94:	move.l 37d8e <BmpCookieMask+0x2e>,-(sp)
    2b9a:	move.l 37d8a <BmpCookieMask+0x2a>,-(sp)
    2ba0:	move.l 37d86 <BmpCookieMask+0x26>,-(sp)
    2ba6:	move.l 37d82 <BmpCookieMask+0x22>,-(sp)
    2bac:	move.l 37d7e <BmpCookieMask+0x1e>,-(sp)
    2bb2:	move.l 37d7a <BmpCookieMask+0x1a>,-(sp)
    2bb8:	move.l 37d76 <BmpCookieMask+0x16>,-(sp)
    2bbe:	move.l 37d72 <BmpCookieMask+0x12>,-(sp)
    2bc4:	move.l 37d6e <BmpCookieMask+0xe>,-(sp)
    2bca:	move.l 37d6a <BmpCookieMask+0xa>,-(sp)
    2bd0:	move.l 37d66 <BmpCookieMask+0x6>,-(sp)
    2bd6:	move.l 37d62 <BmpCookieMask+0x2>,-(sp)
    2bdc:	lea 37d60 <BmpCookieMask>,a0
    2be2:	move.w (a0),-(sp)
    2be4:	subq.l #2,sp
    2be6:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2bec:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2bf2:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    2bf8:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    2bfe:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2c04:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2c0a:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    2c10:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    2c16:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    2c1c:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    2c22:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    2c28:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    2c2e:	move.w (a4),-(sp)
    2c30:	subq.l #2,sp
    2c32:	move.l 37dc0 <BmpCookie+0x2e>,-(sp)
    2c38:	move.l 37dbc <BmpCookie+0x2a>,-(sp)
    2c3e:	move.l 37db8 <BmpCookie+0x26>,-(sp)
    2c44:	move.l 37db4 <BmpCookie+0x22>,-(sp)
    2c4a:	move.l 37db0 <BmpCookie+0x1e>,-(sp)
    2c50:	move.l 37dac <BmpCookie+0x1a>,-(sp)
    2c56:	move.l 37da8 <BmpCookie+0x16>,-(sp)
    2c5c:	move.l 37da4 <BmpCookie+0x12>,-(sp)
    2c62:	move.l 37da0 <BmpCookie+0xe>,-(sp)
    2c68:	move.l 37d9c <BmpCookie+0xa>,-(sp)
    2c6e:	move.l 37d98 <BmpCookie+0x6>,-(sp)
    2c74:	move.l 37d94 <BmpCookie+0x2>,-(sp)
    2c7a:	move.w (a3),-(sp)
    2c7c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[5], BobTarget[5], 32, 32);
    2c7e:	lea 180(sp),sp
    2c82:	pea 20 <_start+0x20>
    2c86:	pea 20 <_start+0x20>
    2c8a:	move.l 7b3e <BobTarget+0x2c>,-(sp)
    2c90:	move.l 7b3a <BobTarget+0x28>,-(sp)
    2c96:	move.l 5ab8 <BobSource+0x2c>,-(sp)
    2c9c:	move.l 5ab4 <BobSource+0x28>,-(sp)
    2ca2:	subq.l #2,sp
    2ca4:	move.l 37d8e <BmpCookieMask+0x2e>,-(sp)
    2caa:	move.l 37d8a <BmpCookieMask+0x2a>,-(sp)
    2cb0:	move.l 37d86 <BmpCookieMask+0x26>,-(sp)
    2cb6:	move.l 37d82 <BmpCookieMask+0x22>,-(sp)
    2cbc:	move.l 37d7e <BmpCookieMask+0x1e>,-(sp)
    2cc2:	move.l 37d7a <BmpCookieMask+0x1a>,-(sp)
    2cc8:	move.l 37d76 <BmpCookieMask+0x16>,-(sp)
    2cce:	move.l 37d72 <BmpCookieMask+0x12>,-(sp)
    2cd4:	move.l 37d6e <BmpCookieMask+0xe>,-(sp)
    2cda:	move.l 37d6a <BmpCookieMask+0xa>,-(sp)
    2ce0:	move.l 37d66 <BmpCookieMask+0x6>,-(sp)
    2ce6:	move.l 37d62 <BmpCookieMask+0x2>,-(sp)
    2cec:	lea 37d60 <BmpCookieMask>,a0
    2cf2:	move.w (a0),-(sp)
    2cf4:	subq.l #2,sp
    2cf6:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2cfc:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2d02:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    2d08:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    2d0e:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2d14:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2d1a:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    2d20:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    2d26:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    2d2c:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    2d32:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    2d38:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    2d3e:	move.w (a4),-(sp)
    2d40:	subq.l #2,sp
    2d42:	move.l 37dc0 <BmpCookie+0x2e>,-(sp)
    2d48:	move.l 37dbc <BmpCookie+0x2a>,-(sp)
    2d4e:	move.l 37db8 <BmpCookie+0x26>,-(sp)
    2d54:	move.l 37db4 <BmpCookie+0x22>,-(sp)
    2d5a:	move.l 37db0 <BmpCookie+0x1e>,-(sp)
    2d60:	move.l 37dac <BmpCookie+0x1a>,-(sp)
    2d66:	move.l 37da8 <BmpCookie+0x16>,-(sp)
    2d6c:	move.l 37da4 <BmpCookie+0x12>,-(sp)
    2d72:	move.l 37da0 <BmpCookie+0xe>,-(sp)
    2d78:	move.l 37d9c <BmpCookie+0xa>,-(sp)
    2d7e:	move.l 37d98 <BmpCookie+0x6>,-(sp)
    2d84:	move.l 37d94 <BmpCookie+0x2>,-(sp)
    2d8a:	move.w (a3),-(sp)
    2d8c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[6], BobTarget[6], 32, 32);
    2d8e:	lea 180(sp),sp
    2d92:	pea 20 <_start+0x20>
    2d96:	pea 20 <_start+0x20>
    2d9a:	move.l 7b46 <BobTarget+0x34>,-(sp)
    2da0:	move.l 7b42 <BobTarget+0x30>,-(sp)
    2da6:	move.l 5ac0 <BobSource+0x34>,-(sp)
    2dac:	move.l 5abc <BobSource+0x30>,-(sp)
    2db2:	subq.l #2,sp
    2db4:	move.l 37d8e <BmpCookieMask+0x2e>,-(sp)
    2dba:	move.l 37d8a <BmpCookieMask+0x2a>,-(sp)
    2dc0:	move.l 37d86 <BmpCookieMask+0x26>,-(sp)
    2dc6:	move.l 37d82 <BmpCookieMask+0x22>,-(sp)
    2dcc:	move.l 37d7e <BmpCookieMask+0x1e>,-(sp)
    2dd2:	move.l 37d7a <BmpCookieMask+0x1a>,-(sp)
    2dd8:	move.l 37d76 <BmpCookieMask+0x16>,-(sp)
    2dde:	move.l 37d72 <BmpCookieMask+0x12>,-(sp)
    2de4:	move.l 37d6e <BmpCookieMask+0xe>,-(sp)
    2dea:	move.l 37d6a <BmpCookieMask+0xa>,-(sp)
    2df0:	move.l 37d66 <BmpCookieMask+0x6>,-(sp)
    2df6:	move.l 37d62 <BmpCookieMask+0x2>,-(sp)
    2dfc:	lea 37d60 <BmpCookieMask>,a0
    2e02:	move.w (a0),-(sp)
    2e04:	subq.l #2,sp
    2e06:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2e0c:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2e12:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    2e18:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    2e1e:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2e24:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2e2a:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    2e30:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    2e36:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    2e3c:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    2e42:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    2e48:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    2e4e:	move.w (a4),-(sp)
    2e50:	subq.l #2,sp
    2e52:	move.l 37dc0 <BmpCookie+0x2e>,-(sp)
    2e58:	move.l 37dbc <BmpCookie+0x2a>,-(sp)
    2e5e:	move.l 37db8 <BmpCookie+0x26>,-(sp)
    2e64:	move.l 37db4 <BmpCookie+0x22>,-(sp)
    2e6a:	move.l 37db0 <BmpCookie+0x1e>,-(sp)
    2e70:	move.l 37dac <BmpCookie+0x1a>,-(sp)
    2e76:	move.l 37da8 <BmpCookie+0x16>,-(sp)
    2e7c:	move.l 37da4 <BmpCookie+0x12>,-(sp)
    2e82:	move.l 37da0 <BmpCookie+0xe>,-(sp)
    2e88:	move.l 37d9c <BmpCookie+0xa>,-(sp)
    2e8e:	move.l 37d98 <BmpCookie+0x6>,-(sp)
    2e94:	move.l 37d94 <BmpCookie+0x2>,-(sp)
    2e9a:	move.w (a3),-(sp)
    2e9c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[7], BobTarget[7], 32, 32);
    2e9e:	lea 180(sp),sp
    2ea2:	pea 20 <_start+0x20>
    2ea6:	pea 20 <_start+0x20>
    2eaa:	move.l 7b4e <BobTarget+0x3c>,-(sp)
    2eb0:	move.l 7b4a <BobTarget+0x38>,-(sp)
    2eb6:	move.l 5ac8 <BobSource+0x3c>,-(sp)
    2ebc:	move.l 5ac4 <BobSource+0x38>,-(sp)
    2ec2:	subq.l #2,sp
    2ec4:	move.l 37d8e <BmpCookieMask+0x2e>,-(sp)
    2eca:	move.l 37d8a <BmpCookieMask+0x2a>,-(sp)
    2ed0:	move.l 37d86 <BmpCookieMask+0x26>,-(sp)
    2ed6:	move.l 37d82 <BmpCookieMask+0x22>,-(sp)
    2edc:	move.l 37d7e <BmpCookieMask+0x1e>,-(sp)
    2ee2:	move.l 37d7a <BmpCookieMask+0x1a>,-(sp)
    2ee8:	move.l 37d76 <BmpCookieMask+0x16>,-(sp)
    2eee:	move.l 37d72 <BmpCookieMask+0x12>,-(sp)
    2ef4:	move.l 37d6e <BmpCookieMask+0xe>,-(sp)
    2efa:	move.l 37d6a <BmpCookieMask+0xa>,-(sp)
    2f00:	move.l 37d66 <BmpCookieMask+0x6>,-(sp)
    2f06:	move.l 37d62 <BmpCookieMask+0x2>,-(sp)
    2f0c:	lea 37d60 <BmpCookieMask>,a0
    2f12:	move.w (a0),-(sp)
    2f14:	subq.l #2,sp
    2f16:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2f1c:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2f22:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    2f28:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    2f2e:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2f34:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2f3a:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    2f40:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    2f46:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    2f4c:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    2f52:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    2f58:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    2f5e:	move.w (a4),-(sp)
    2f60:	subq.l #2,sp
    2f62:	move.l 37dc0 <BmpCookie+0x2e>,-(sp)
    2f68:	move.l 37dbc <BmpCookie+0x2a>,-(sp)
    2f6e:	move.l 37db8 <BmpCookie+0x26>,-(sp)
    2f74:	move.l 37db4 <BmpCookie+0x22>,-(sp)
    2f7a:	move.l 37db0 <BmpCookie+0x1e>,-(sp)
    2f80:	move.l 37dac <BmpCookie+0x1a>,-(sp)
    2f86:	move.l 37da8 <BmpCookie+0x16>,-(sp)
    2f8c:	move.l 37da4 <BmpCookie+0x12>,-(sp)
    2f92:	move.l 37da0 <BmpCookie+0xe>,-(sp)
    2f98:	move.l 37d9c <BmpCookie+0xa>,-(sp)
    2f9e:	move.l 37d98 <BmpCookie+0x6>,-(sp)
    2fa4:	move.l 37d94 <BmpCookie+0x2>,-(sp)
    2faa:	move.w (a3),-(sp)
    2fac:	jsr (a2)
		MoveStarfield();
    2fae:	lea 180(sp),sp
    2fb2:	jsr 1446 <MoveStarfield>(pc)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    2fb6:	move.b bfe001 <_end+0xbc6035>,d0
	while (!MouseLeft())
    2fbc:	btst #6,d0
    2fc0:	beq.w 3158 <MainLoop+0x11fc>
		WaitVbl();
    2fc4:	jsr c76 <WaitVbl>(pc)
		if (LogoShowPause > 0)
    2fc8:	move.w 7b9a <LogoShowPause>,d0
    2fce:	beq.w 1fd6 <MainLoop+0x7a>
			LogoShowPause--;
    2fd2:	subq.w #1,d0
    2fd4:	move.w d0,7b9a <LogoShowPause>
		if (ResetCopper)
    2fda:	tst.w 37d4e <ResetCopper>
    2fe0:	bne.w 22a4 <MainLoop+0x348>
		CopyBitmapPart(BmpUpperPart_Buf1, BmpUpperPart_PF2, 46, 78);
    2fe4:	pea 4e <_start+0x4e>
    2fe8:	pea 2e <_start+0x2e>
    2fec:	subq.l #2,sp
    2fee:	move.l 37e88 <BmpUpperPart_PF2+0x2e>,-(sp)
    2ff4:	move.l 37e84 <BmpUpperPart_PF2+0x2a>,-(sp)
    2ffa:	move.l 37e80 <BmpUpperPart_PF2+0x26>,-(sp)
    3000:	move.l 37e7c <BmpUpperPart_PF2+0x22>,-(sp)
    3006:	move.l 37e78 <BmpUpperPart_PF2+0x1e>,-(sp)
    300c:	move.l 37e74 <BmpUpperPart_PF2+0x1a>,-(sp)
    3012:	move.l 37e70 <BmpUpperPart_PF2+0x16>,-(sp)
    3018:	move.l 37e6c <BmpUpperPart_PF2+0x12>,-(sp)
    301e:	move.l 37e68 <BmpUpperPart_PF2+0xe>,-(sp)
    3024:	move.l 37e64 <BmpUpperPart_PF2+0xa>,-(sp)
    302a:	move.l 37e60 <BmpUpperPart_PF2+0x6>,-(sp)
    3030:	move.l 37e5c <BmpUpperPart_PF2+0x2>,-(sp)
    3036:	move.w 37e5a <BmpUpperPart_PF2>,-(sp)
    303c:	subq.l #2,sp
    303e:	move.l 37e56 <BmpUpperPart_Buf1+0x2e>,-(sp)
    3044:	move.l 37e52 <BmpUpperPart_Buf1+0x2a>,-(sp)
    304a:	move.l 37e4e <BmpUpperPart_Buf1+0x26>,-(sp)
    3050:	move.l 37e4a <BmpUpperPart_Buf1+0x22>,-(sp)
    3056:	move.l 37e46 <BmpUpperPart_Buf1+0x1e>,-(sp)
    305c:	move.l 37e42 <BmpUpperPart_Buf1+0x1a>,-(sp)
    3062:	move.l 37e3e <BmpUpperPart_Buf1+0x16>,-(sp)
    3068:	move.l 37e3a <BmpUpperPart_Buf1+0x12>,-(sp)
    306e:	move.l 37e36 <BmpUpperPart_Buf1+0xe>,-(sp)
    3074:	move.l 37e32 <BmpUpperPart_Buf1+0xa>,-(sp)
    307a:	move.l 37e2e <BmpUpperPart_Buf1+0x6>,-(sp)
    3080:	move.l 37e2a <BmpUpperPart_Buf1+0x2>,-(sp)
    3086:	move.w 37e28 <BmpUpperPart_Buf1>,-(sp)
    308c:	jsr e92 <CopyBitmapPart>(pc)
		if (BounceEnabled)
    3090:	lea 112(sp),sp
    3094:	tst.w 37d4c <BounceEnabled>
    309a:	beq.w 22fa <MainLoop+0x39e>
			if (ScrollerDir > 0)
    309e:	move.b 7b52 <ScrollerDir>,d0
    30a4:	ble.w 22e6 <MainLoop+0x38a>
				ScrollerDir = ((ScrollerMax - ScrollerY) * 1000 / 12000);
    30a8:	pea c <_start+0xc>
    30ac:	movea.w #40,a0
    30b0:	suba.w 37d4a <ScrollerY>,a0
    30b6:	move.l a0,-(sp)
    30b8:	jsr 3702 <__divsi3>
    30be:	addq.l #8,sp
    30c0:	move.b d0,7b52 <ScrollerDir>
				if (ScrollerDir > 6)
    30c6:	cmpi.b #6,d0
    30ca:	ble.s 30d4 <MainLoop+0x1178>
					ScrollerDir = 6;
    30cc:	move.b #6,7b52 <ScrollerDir>
				if (ScrollerDir < 1)
    30d4:	tst.b 7b52 <ScrollerDir>
    30da:	ble.w 22da <MainLoop+0x37e>
			ScrollerY += ScrollerDir;
    30de:	move.b 7b52 <ScrollerDir>,d0
    30e4:	ext.w d0
    30e6:	add.w d0,37d4a <ScrollerY>
		if (ScrollerY >= ScrollerMax)
    30ec:	movea.w 37d4a <ScrollerY>,a0
    30f2:	moveq #39,d0
    30f4:	cmp.l a0,d0
    30f6:	bge.w 2310 <MainLoop+0x3b4>
			ScrollerY = ScrollerMax;
    30fa:	move.w #40,37d4a <ScrollerY>
			ScrollerDir = -1;
    3102:	st 7b52 <ScrollerDir>
		if (ScrollerPause < 1)
    3108:	tst.w 37d48 <ScrollerPause>
    310e:	beq.w 233c <MainLoop+0x3e0>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    3112:	moveq #0,d3
    3114:	move.w 37dfc <BmpScroller+0x6>,d3
    311a:	moveq #0,d2
    311c:	move.w 37dfa <BmpScroller+0x4>,d2
    3122:	movea.l 37d44 <copScrollerBmpP>,a2
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    3128:	lea 3684 <__mulsi3>,a3
    312e:	move.l d3,-(sp)
    3130:	movea.w 37d4a <ScrollerY>,a0
    3136:	move.l a0,-(sp)
    3138:	jsr (a3)
    313a:	addq.l #8,sp
    313c:	move.l d0,-(sp)
    313e:	move.l d2,-(sp)
    3140:	jsr (a3)
    3142:	addq.l #8,sp
    3144:	add.l 37e04 <BmpScroller+0xe>,d0
    for (USHORT i = 0; i < numPlanes; i++)
    314a:	suba.l a0,a0
    314c:	bra.w 23ce <MainLoop+0x472>
			MoveBobs();
    3150:	jsr 8c <MoveBobs>(pc)
    3154:	bra.w 2722 <MainLoop+0x7c6>
}
    3158:	movem.l -88(a5),d2-d7/a2-a4
    315e:	unlk a5
    3160:	rts

00003162 <KPrintF>:
void KPrintF(const char* fmt, ...) {
    3162:	lea -128(sp),sp
    3166:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    316a:	move.w f0ff60 <_end+0xed7f94>,d0
    3170:	cmpi.w #20153,d0
    3174:	beq.s 3198 <KPrintF+0x36>
    3176:	cmpi.w #-24562,d0
    317a:	beq.s 3198 <KPrintF+0x36>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    317c:	movea.l 37fc0 <SysBase>,a6
    3182:	movea.l 144(sp),a0
    3186:	lea 148(sp),a1
    318a:	lea 377e <KPutCharX>,a2
    3190:	suba.l a3,a3
    3192:	jsr -522(a6)
    3196:	bra.s 31c2 <KPrintF+0x60>
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    3198:	movea.l 37fc0 <SysBase>,a6
    319e:	movea.l 144(sp),a0
    31a2:	lea 148(sp),a1
    31a6:	lea 378c <PutChar>,a2
    31ac:	lea 12(sp),a3
    31b0:	jsr -522(a6)
		UaeDbgLog(86, temp);
    31b4:	move.l a3,-(sp)
    31b6:	pea 56 <_start+0x56>
    31ba:	jsr f0ff60 <_end+0xed7f94>
    31c0:	addq.l #8,sp
}
    31c2:	movem.l (sp)+,a2-a3/a6
    31c6:	lea 128(sp),sp
    31ca:	rts

000031cc <main>:
{
    31cc:	movem.l d2-d3/a2/a6,-(sp)
	SysBase = *((struct ExecBase **)4UL);
    31d0:	movea.l 4 <_start+0x4>,a6
    31d4:	move.l a6,37fc0 <SysBase>
	custom = (struct Custom *)0xdff000;
    31da:	move.l #14675968,37fc6 <custom>
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
    31e4:	lea 51c9 <incbin_P61_Player_end+0x1>,a1
    31ea:	moveq #0,d0
    31ec:	jsr -552(a6)
    31f0:	move.l d0,37fbc <GfxBase>
	if (!GfxBase)
    31f6:	beq.w 35c0 <main+0x3f4>
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    31fa:	movea.l 37fc0 <SysBase>,a6
    3200:	lea 51da <incbin_P61_Player_end+0x12>,a1
    3206:	moveq #0,d0
    3208:	jsr -552(a6)
    320c:	move.l d0,37fb8 <DOSBase>
	if (!DOSBase)
    3212:	beq.w 35d0 <main+0x404>
	KPrintF("Hello debugger from Amiga!\n");
    3216:	pea 51e6 <incbin_P61_Player_end+0x1e>
    321c:	jsr 3162 <KPrintF>(pc)
	Write(Output(), (APTR) "Hello console!\n", 15);
    3220:	movea.l 37fb8 <DOSBase>,a6
    3226:	jsr -60(a6)
    322a:	movea.l 37fb8 <DOSBase>,a6
    3230:	move.l d0,d1
    3232:	move.l #20994,d2
    3238:	moveq #15,d3
    323a:	jsr -48(a6)
	BitmapInit(&Screen, 320, 256, 3);
    323e:	pea 3 <_start+0x3>
    3242:	pea 100 <MoveBobs+0x74>
    3246:	pea 140 <MoveBobs+0xb4>
    324a:	pea 37f86 <Screen>
    3250:	lea 129c <BitmapInit>(pc),a2
    3254:	jsr (a2)
	BitmapInit(&BmpLogo, 256, 130, 3);
    3256:	pea 3 <_start+0x3>
    325a:	pea 82 <_start+0x82>
    325e:	pea 100 <MoveBobs+0x74>
    3262:	pea 37f54 <BmpLogo>
    3268:	jsr (a2)
	BitmapInit(&BmpLogo2, 256, 130, 3);
    326a:	lea 36(sp),sp
    326e:	pea 3 <_start+0x3>
    3272:	pea 82 <_start+0x82>
    3276:	pea 100 <MoveBobs+0x74>
    327a:	pea 37f22 <BmpLogo2>
    3280:	jsr (a2)
	BitmapInit(&BmpLogo3, 256, 130, 3);
    3282:	pea 3 <_start+0x3>
    3286:	pea 82 <_start+0x82>
    328a:	pea 100 <MoveBobs+0x74>
    328e:	pea 37ef0 <BmpLogo3>
    3294:	jsr (a2)
	BitmapInit(&BmpLogo4, 256, 130, 3);
    3296:	lea 32(sp),sp
    329a:	pea 3 <_start+0x3>
    329e:	pea 82 <_start+0x82>
    32a2:	pea 100 <MoveBobs+0x74>
    32a6:	pea 37ebe <BmpLogo4>
    32ac:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF1, 320, 130, 3);
    32ae:	pea 3 <_start+0x3>
    32b2:	pea 82 <_start+0x82>
    32b6:	pea 140 <MoveBobs+0xb4>
    32ba:	pea 37e8c <BmpUpperPart_PF1>
    32c0:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF2, 320 + 64, 130, 3);
    32c2:	lea 32(sp),sp
    32c6:	pea 3 <_start+0x3>
    32ca:	pea 82 <_start+0x82>
    32ce:	pea 180 <MoveBobs+0xf4>
    32d2:	pea 37e5a <BmpUpperPart_PF2>
    32d8:	jsr (a2)
	BitmapInit(&BmpUpperPart_Buf1, 320 + 64, 130, 3);
    32da:	pea 3 <_start+0x3>
    32de:	pea 82 <_start+0x82>
    32e2:	pea 180 <MoveBobs+0xf4>
    32e6:	pea 37e28 <BmpUpperPart_Buf1>
    32ec:	jsr (a2)
	BitmapInit(&BmpScroller, 320 + 32, 166, 3);
    32ee:	lea 32(sp),sp
    32f2:	pea 3 <_start+0x3>
    32f6:	pea a6 <MoveBobs+0x1a>
    32fa:	pea 160 <MoveBobs+0xd4>
    32fe:	pea 37df6 <BmpScroller>
    3304:	jsr (a2)
	BitmapInit(&BmpFont32, 320, 256, 3);
    3306:	pea 3 <_start+0x3>
    330a:	pea 100 <MoveBobs+0x74>
    330e:	pea 140 <MoveBobs+0xb4>
    3312:	pea 37dc4 <BmpFont32>
    3318:	jsr (a2)
	BitmapInit(&BmpCookie, 320, 256, 3);
    331a:	lea 32(sp),sp
    331e:	pea 3 <_start+0x3>
    3322:	pea 100 <MoveBobs+0x74>
    3326:	pea 140 <MoveBobs+0xb4>
    332a:	pea 37d92 <BmpCookie>
    3330:	jsr (a2)
	BitmapInit(&BmpCookieMask, 320, 256, 3);
    3332:	pea 3 <_start+0x3>
    3336:	pea 100 <MoveBobs+0x74>
    333a:	pea 140 <MoveBobs+0xb4>
    333e:	pea 37d60 <BmpCookieMask>
    3344:	jsr (a2)
	copPtr = AllocMem(1024, MEMF_CHIP);
    3346:	movea.l 37fc0 <SysBase>,a6
    334c:	move.l #1024,d0
    3352:	moveq #2,d1
    3354:	jsr -198(a6)
    3358:	move.l d0,37d5c <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
    335e:	movea.l 37fc0 <SysBase>,a6
    3364:	moveq #0,d0
    3366:	move.w 37e02 <BmpScroller+0xc>,d0
    336c:	move.l #65538,d1
    3372:	jsr -198(a6)
    3376:	move.l d0,37e04 <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
    337c:	movea.l 37fc0 <SysBase>,a6
    3382:	moveq #0,d0
    3384:	move.w 37e98 <BmpUpperPart_PF1+0xc>,d0
    338a:	move.l #65538,d1
    3390:	jsr -198(a6)
    3394:	move.l d0,37e9a <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
    339a:	movea.l 37fc0 <SysBase>,a6
    33a0:	moveq #0,d0
    33a2:	move.w 37e66 <BmpUpperPart_PF2+0xc>,d0
    33a8:	move.l #65538,d1
    33ae:	jsr -198(a6)
    33b2:	move.l d0,37e68 <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
    33b8:	movea.l 37fc0 <SysBase>,a6
    33be:	moveq #0,d0
    33c0:	move.w 37e34 <BmpUpperPart_Buf1+0xc>,d0
    33c6:	move.l #65538,d1
    33cc:	jsr -198(a6)
    33d0:	move.l d0,37e36 <BmpUpperPart_Buf1+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
    33d6:	move.l #31644,37f62 <BmpLogo+0xe>
	BmpLogo2.ImageData = (UWORD *)BmpLogo2P;
    33e0:	move.l #44126,37f30 <BmpLogo2+0xe>
	BmpLogo3.ImageData = (UWORD *)BmpLogo3P;
    33ea:	move.l #56608,37efe <BmpLogo3+0xe>
	BmpLogo4.ImageData = (UWORD *)BmpLogo4P;
    33f4:	move.l #69090,37ecc <BmpLogo4+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
    33fe:	move.l #81572,37dd2 <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
    3408:	move.l #112294,37da0 <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
    3412:	move.l #143016,37d6e <BmpCookieMask+0xe>
	InitImagePlanes(&BmpLogo, 0);
    341c:	lea 32(sp),sp
    3420:	clr.l -(sp)
    3422:	pea 37f54 <BmpLogo>
    3428:	lea e48 <InitImagePlanes>(pc),a2
    342c:	jsr (a2)
	InitImagePlanes(&BmpLogo2, 0);
    342e:	clr.l -(sp)
    3430:	pea 37f22 <BmpLogo2>
    3436:	jsr (a2)
	InitImagePlanes(&BmpLogo3, 0);
    3438:	clr.l -(sp)
    343a:	pea 37ef0 <BmpLogo3>
    3440:	jsr (a2)
	InitImagePlanes(&BmpLogo4, 0);
    3442:	clr.l -(sp)
    3444:	pea 37ebe <BmpLogo4>
    344a:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF1, 0);
    344c:	lea 32(sp),sp
    3450:	clr.l -(sp)
    3452:	pea 37e8c <BmpUpperPart_PF1>
    3458:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF2, 32 / 8);
    345a:	pea 4 <_start+0x4>
    345e:	pea 37e5a <BmpUpperPart_PF2>
    3464:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_Buf1, 32 / 8);
    3466:	pea 4 <_start+0x4>
    346a:	pea 37e28 <BmpUpperPart_Buf1>
    3470:	jsr (a2)
	InitImagePlanes(&BmpScroller, 0);
    3472:	clr.l -(sp)
    3474:	pea 37df6 <BmpScroller>
    347a:	jsr (a2)
	InitImagePlanes(&BmpFont32, 0);
    347c:	lea 32(sp),sp
    3480:	clr.l -(sp)
    3482:	pea 37dc4 <BmpFont32>
    3488:	jsr (a2)
	InitImagePlanes(&BmpCookie, 0);
    348a:	clr.l -(sp)
    348c:	pea 37d92 <BmpCookie>
    3492:	jsr (a2)
	InitImagePlanes(&BmpCookieMask, 0);
    3494:	clr.l -(sp)
    3496:	pea 37d60 <BmpCookieMask>
    349c:	jsr (a2)
	TakeSystem();
    349e:	jsr cbc <TakeSystem>(pc)
	InitStarfieldSprite();
    34a2:	jsr 12d6 <InitStarfieldSprite>(pc)
	WaitVbl();
    34a6:	jsr c76 <WaitVbl>(pc)
	SetupCopper(copPtr);
    34aa:	move.l 37d5c <copPtr>,-(sp)
    34b0:	jsr 25a <SetupCopper>(pc)
	custom->cop1lc = (ULONG)copPtr;
    34b4:	movea.l 37fc6 <custom>,a0
    34ba:	move.l 37d5c <copPtr>,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    34c2:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
    34c8:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    34ce:	move.w #-30752,150(a0)
	SetInterruptHandler((APTR)interruptHandler);
    34d4:	pea 124c <interruptHandler>(pc)
    34d8:	jsr c5c <SetInterruptHandler>(pc)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
    34dc:	movea.l 37fc6 <custom>,a0
    34e2:	move.w #-16352,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
    34e8:	move.w #32,156(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
    34ee:	move.w #-24576,154(a0)
	if (p61Init(module) != 0)
    34f4:	lea 32(sp),sp
    34f8:	pea 2a6aa <incbin_module_start>
    34fe:	jsr 1208 <p61Init>(pc)
    3502:	addq.l #4,sp
    3504:	tst.l d0
    3506:	bne.w 35dc <main+0x410>
	MainLoop();
    350a:	jsr 1f5c <MainLoop>(pc)
	p61End();
    350e:	jsr 127a <p61End>(pc)
	FreeMem(copPtr, 1024);
    3512:	movea.l 37fc0 <SysBase>,a6
    3518:	movea.l 37d5c <copPtr>,a1
    351e:	move.l #1024,d0
    3524:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    3528:	movea.l 37fc0 <SysBase>,a6
    352e:	movea.l 37e04 <BmpScroller+0xe>,a1
    3534:	moveq #0,d0
    3536:	move.w 37e02 <BmpScroller+0xc>,d0
    353c:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    3540:	movea.l 37fc0 <SysBase>,a6
    3546:	movea.l 37e9a <BmpUpperPart_PF1+0xe>,a1
    354c:	moveq #0,d0
    354e:	move.w 37e98 <BmpUpperPart_PF1+0xc>,d0
    3554:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    3558:	movea.l 37fc0 <SysBase>,a6
    355e:	movea.l 37e68 <BmpUpperPart_PF2+0xe>,a1
    3564:	moveq #0,d0
    3566:	move.w 37e66 <BmpUpperPart_PF2+0xc>,d0
    356c:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_Buf1.ImageData, BmpUpperPart_PF2.Btot);
    3570:	movea.l 37fc0 <SysBase>,a6
    3576:	movea.l 37e36 <BmpUpperPart_Buf1+0xe>,a1
    357c:	moveq #0,d0
    357e:	move.w 37e66 <BmpUpperPart_PF2+0xc>,d0
    3584:	jsr -210(a6)
	CloseLibrary((struct Library *)DOSBase);
    3588:	movea.l 37fc0 <SysBase>,a6
    358e:	movea.l 37fb8 <DOSBase>,a1
    3594:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    3598:	movea.l 37fc0 <SysBase>,a6
    359e:	movea.l 37fbc <GfxBase>,a1
    35a4:	jsr -414(a6)
	FreeSystem();
    35a8:	jsr d88 <FreeSystem>(pc)
	Exit(0);
    35ac:	movea.l 37fb8 <DOSBase>,a6
    35b2:	moveq #0,d1
    35b4:	jsr -144(a6)
}
    35b8:	moveq #0,d0
    35ba:	movem.l (sp)+,d2-d3/a2/a6
    35be:	rts
		Exit(0);
    35c0:	movea.l 37fb8 <DOSBase>,a6
    35c6:	moveq #0,d1
    35c8:	jsr -144(a6)
    35cc:	bra.w 31fa <main+0x2e>
		Exit(0);
    35d0:	movea.l d0,a6
    35d2:	moveq #0,d1
    35d4:	jsr -144(a6)
    35d8:	bra.w 3216 <main+0x4a>
		KPrintF("p61Init failed!\n");
    35dc:	pea 5212 <incbin_P61_Player_end+0x4a>
    35e2:	jsr 3162 <KPrintF>(pc)
    35e6:	addq.l #4,sp
    35e8:	bra.w 350a <main+0x33e>

000035ec <strlen>:
unsigned long strlen(const char* s) {
    35ec:	movea.l 4(sp),a0
	unsigned long t=0;
    35f0:	moveq #0,d0
    35f2:	bra.s 35f6 <strlen+0xa>
		t++;
    35f4:	addq.l #1,d0
	while(*s++)
    35f6:	tst.b (a0)+
    35f8:	bne.s 35f4 <strlen+0x8>
}
    35fa:	rts

000035fc <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    35fc:	move.l d2,-(sp)
    35fe:	move.l 8(sp),d0
    3602:	move.l 12(sp),d2
    3606:	move.l 16(sp),d1
	unsigned char *ptr = (unsigned char *)dest;
    360a:	movea.l d0,a0
    360c:	bra.s 3612 <memset+0x16>
		*ptr++ = val;
    360e:	move.b d2,(a0)+
	while(len-- > 0)
    3610:	move.l a1,d1
    3612:	movea.l d1,a1
    3614:	subq.l #1,a1
    3616:	tst.l d1
    3618:	bne.s 360e <memset+0x12>
}
    361a:	move.l (sp)+,d2
    361c:	rts

0000361e <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    361e:	move.l d2,-(sp)
    3620:	move.l 8(sp),d0
    3624:	movea.l 12(sp),a1
    3628:	move.l 16(sp),d1
	char *d = (char *)dest;
    362c:	movea.l d0,a0
    362e:	bra.s 3634 <memcpy+0x16>
		*d++ = *s++;
    3630:	move.b (a1)+,(a0)+
	while(len--)
    3632:	move.l d2,d1
    3634:	move.l d1,d2
    3636:	subq.l #1,d2
    3638:	tst.l d1
    363a:	bne.s 3630 <memcpy+0x12>
}
    363c:	move.l (sp)+,d2
    363e:	rts

00003640 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    3640:	move.l d2,-(sp)
    3642:	move.l 8(sp),d0
    3646:	movea.l 12(sp),a0
    364a:	move.l 16(sp),d1
	if (d < s) {
    364e:	cmpa.l d0,a0
    3650:	bhi.s 366c <memmove+0x2c>
		const char *lasts = s + (len - 1);
    3652:	movea.l d1,a1
    3654:	subq.l #1,a1
    3656:	adda.l a1,a0
		char *lastd = d + (len - 1);
    3658:	adda.l d0,a1
		while (len--)
    365a:	bra.s 3678 <memmove+0x38>
			*d++ = *s++;
    365c:	move.b (a0)+,(a1)+
		while (len--)
    365e:	move.l d2,d1
    3660:	move.l d1,d2
    3662:	subq.l #1,d2
    3664:	tst.l d1
    3666:	bne.s 365c <memmove+0x1c>
}
    3668:	move.l (sp)+,d2
    366a:	rts
	char *d = dest;
    366c:	movea.l d0,a1
    366e:	bra.s 3660 <memmove+0x20>
			*lastd-- = *lasts--;
    3670:	move.b (a0),(a1)
    3672:	subq.l #1,a1
    3674:	subq.l #1,a0
		while (len--)
    3676:	move.l d2,d1
    3678:	move.l d1,d2
    367a:	subq.l #1,d2
    367c:	tst.l d1
    367e:	bne.s 3670 <memmove+0x30>
    3680:	bra.s 3668 <memmove+0x28>
    3682:	nop

00003684 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    3684:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    3688:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    368c:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    3690:	mulu.w 8(sp),d1
	addw	d1, d0
    3694:	add.w d1,d0
	swap	d0
    3696:	swap d0
	clrw	d0
    3698:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    369a:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    369e:	mulu.w 10(sp),d1
	addl	d1, d0
    36a2:	add.l d1,d0
	rts
    36a4:	rts

000036a6 <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    36a6:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    36a8:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    36ac:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    36b0:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    36b6:	bcc.s 36ce <__udivsi3+0x28>
	movel	d0, d2
    36b8:	move.l d0,d2
	clrw	d2
    36ba:	clr.w d2
	swap	d2
    36bc:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    36be:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    36c0:	move.w d2,d0
	swap	d0
    36c2:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    36c4:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    36c8:	divu.w d1,d2
	movew	d2, d0
    36ca:	move.w d2,d0
	jra	6f
    36cc:	bra.s 36fe <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    36ce:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    36d0:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    36d2:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    36d4:	cmpi.l #65536,d1
	jcc	4b
    36da:	bcc.s 36d0 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    36dc:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    36de:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    36e4:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    36e6:	mulu.w d0,d1
	swap	d2
    36e8:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    36ea:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    36ec:	swap d2
	tstw	d2		/* high part 17 bits? */
    36ee:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    36f0:	bne.s 36fc <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    36f2:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    36f4:	bcs.s 36fc <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    36f6:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    36fa:	bls.s 36fe <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    36fc:	subq.l #1,d0

6:	movel	sp@+, d2
    36fe:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    3700:	rts

00003702 <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    3702:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    3704:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    3706:	move.l 12(sp),d1
	jpl	1f
    370a:	bpl.s 3710 <__divsi3+0xe>
	negl	d1
    370c:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    370e:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    3710:	move.l 8(sp),d0
	jpl	2f
    3714:	bpl.s 371a <__divsi3+0x18>
	negl	d0
    3716:	neg.l d0
	negb	d2
    3718:	neg.b d2

2:	movel	d1, sp@-
    371a:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    371c:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    371e:	bsr.s 36a6 <__udivsi3>
	addql	#8, sp
    3720:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    3722:	tst.b d2
	jpl	3f
    3724:	bpl.s 3728 <__divsi3+0x26>
	negl	d0
    3726:	neg.l d0

3:	movel	sp@+, d2
    3728:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    372a:	rts

0000372c <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    372c:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    3730:	move.l 4(sp),d0
	movel	d1, sp@-
    3734:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3736:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    3738:	bsr.s 3702 <__divsi3>
	addql	#8, sp
    373a:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    373c:	move.l 8(sp),d1
	movel	d1, sp@-
    3740:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3742:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    3744:	bsr.w 3684 <__mulsi3>
	addql	#8, sp
    3748:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    374a:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    374e:	sub.l d0,d1
	movel	d1, d0
    3750:	move.l d1,d0
	rts
    3752:	rts

00003754 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    3754:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    3758:	move.l 4(sp),d0
	movel	d1, sp@-
    375c:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    375e:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    3760:	bsr.w 36a6 <__udivsi3>
	addql	#8, sp
    3764:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    3766:	move.l 8(sp),d1
	movel	d1, sp@-
    376a:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    376c:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    376e:	bsr.w 3684 <__mulsi3>
	addql	#8, sp
    3772:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    3774:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    3778:	sub.l d0,d1
	movel	d1, d0
    377a:	move.l d1,d0
	rts
    377c:	rts

0000377e <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    377e:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    3780:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    3784:	jsr -516(a6)
    move.l (sp)+, a6
    3788:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    378a:	rts

0000378c <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    378c:	move.b d0,(a3)+
	rts
    378e:	rts

00003790 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    3790:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    3792:	adda.l a0,a2
	move.l	a2,a3
    3794:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    3796:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    3798:	moveq #56,d4
	moveq	#8,d5
    379a:	moveq #8,d5
	bra.s	.Lliteral
    379c:	bra.s 3806 <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    379e:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    37a0:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    37a2:	dbf d1,379e <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    37a6:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    37a8:	bcc.s 37ac <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    37aa:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    37ac:	tst.w d0
    37ae:	bne.s 37b8 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    37b0:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    37b2:	bls.s 382a <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    37b4:	move.w (a0)+,d0
    37b6:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    37b8:	rol.l #6,d0
	move.w	d0,d1
    37ba:	move.w d0,d1
	and.w	d4,d1
    37bc:	and.w d4,d1
	eor.w	d1,d0
    37be:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    37c0:	movem.w (3824 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    37c6:	rol.l d2,d0
	and.w	d0,d3					|scaling
    37c8:	and.w d0,d3
	eor.w	d3,d0
    37ca:	eor.w d3,d0
	suba.w	d3,a4
    37cc:	suba.w d3,a4
	adda.l	a1,a4
    37ce:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    37d0:	tst.w d0
    37d2:	bne.s 37d8 <_doynaxdepack_asm+0x48>
    37d4:	move.w (a0)+,d0
    37d6:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    37d8:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    37da:	beq.s 37f2 <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    37dc:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    37de:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    37e0:	bpl.s 37ee <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    37e2:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    37e4:	bpl.s 37ec <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    37e6:	addx.b d1,d1
	lsl.l	#2,d0
    37e8:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    37ea:	bmi.s 37e6 <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    37ec:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    37ee:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    37f0:	bcc.s 37f4 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    37f2:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    37f4:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    37f6:	dbf d1,37f2 <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    37fa:	add.l d0,d0
	bcc.s	.Lmatch
    37fc:	bcc.s 37ac <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    37fe:	tst.w d0
    3800:	bne.s 3806 <_doynaxdepack_asm+0x76>
    3802:	move.w (a0)+,d0
    3804:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    3806:	moveq #0,d1
	add.l	d0,d0
    3808:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    380a:	bcc.s 37aa <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    380c:	bpl.s 3814 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    380e:	addx.b d1,d1
	lsl.l	#2,d0
    3810:	lsl.l #2,d0
	bmi.s	.Llgetlen
    3812:	bmi.s 380e <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    3814:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    3816:	dbv.s d1,379e <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    381a:	add.l d0,d0
	eor.w	d1,d0		
    381c:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    381e:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    3820:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    3822:	bra.s 3816 <_doynaxdepack_asm+0x86>

00003824 <doy_table>:
    3824:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    3834:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    3844:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    3854:	.............o
