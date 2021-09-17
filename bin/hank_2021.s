
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
       4:	move.l #27090,d3
       a:	subi.l #27090,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	moveq #0,d2
      14:	bra.s 2a <_start+0x2a>
		__preinit_array_start[i]();
      16:	move.l d2,d0
      18:	add.l d2,d0
      1a:	add.l d0,d0
      1c:	lea 69d2 <__fini_array_end>,a0
      22:	movea.l (0,a0,d0.l),a0
      26:	jsr (a0)
	for (i = 0; i < count; i++)
      28:	addq.l #1,d2
      2a:	cmp.l d2,d3
      2c:	bhi.s 16 <_start+0x16>

	count = __init_array_end - __init_array_start;
      2e:	move.l #27090,d3
      34:	subi.l #27090,d3
      3a:	asr.l #2,d3
	for (i = 0; i < count; i++)
      3c:	moveq #0,d2
      3e:	bra.s 54 <_start+0x54>
		__init_array_start[i]();
      40:	move.l d2,d0
      42:	add.l d2,d0
      44:	add.l d0,d0
      46:	lea 69d2 <__fini_array_end>,a0
      4c:	movea.l (0,a0,d0.l),a0
      50:	jsr (a0)
	for (i = 0; i < count; i++)
      52:	addq.l #1,d2
      54:	cmp.l d2,d3
      56:	bhi.s 40 <_start+0x40>

	main();
      58:	jsr 2374 <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
      5e:	move.l #27090,d2
      64:	subi.l #27090,d2
      6a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      6c:	bra.s 82 <_start+0x82>
		__fini_array_start[i - 1]();
      6e:	subq.l #1,d2
      70:	move.l d2,d0
      72:	add.l d2,d0
      74:	add.l d0,d0
      76:	lea 69d2 <__fini_array_end>,a0
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
      90:	move.w 2d9a0 <BobPhase>,d0
      96:	beq.s 104 <MoveBobs+0x78>
      98:	cmpi.w #1,d0
      9c:	beq.w 1d4 <MoveBobs+0x148>
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
      a6:	lea 69da <BobVecs>,a1
      ac:	move.l d0,d3
      ae:	lsl.l #3,d3
      b0:	movea.l d3,a0
      b2:	add.l (0,a1,d3.l),d1
      b6:	lea 6a0a <BobTarget>,a1
      bc:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X > 320 + 32)
      c0:	cmpi.l #352,d1
      c6:	ble.s d0 <MoveBobs+0x44>
					BobTarget[b].X = 320 + 32;
      c8:	move.l #352,(0,a1,d3.l)
{
      d0:	move.l d2,d0
		for (int b = 0; b < BOBSN - 1; b++)
      d2:	moveq #4,d1
      d4:	cmp.l d0,d1
      d6:	blt.s 108 <MoveBobs+0x7c>
			if ((BobTarget[b + 1].X - BobTarget[b].X) > 34 || BobTarget[b + 1].X >= 320 + 32)
      d8:	move.l d0,d2
      da:	addq.l #1,d2
      dc:	lea 6a0a <BobTarget>,a0
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
     108:	move.l 6a02 <BobVecs+0x28>,d1
     10e:	move.l d1,d0
     110:	add.l 6a32 <BobTarget+0x28>,d0
     116:	move.l d0,6a32 <BobTarget+0x28>
		if (BobTarget[BOBSN - 1].X > 320 + 32)
     11c:	cmpi.l #352,d0
     122:	ble.s 12e <MoveBobs+0xa2>
			BobTarget[BOBSN - 1].X = 320 + 32;
     124:	move.l #352,6a32 <BobTarget+0x28>
		if (BobTarget[0].X >= 320 + 32)
     12e:	cmpi.l #351,6a0a <BobTarget>
     138:	ble.w a0 <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     13c:	neg.l 69da <BobVecs>
			BobVecs[1].X *= -1;
     142:	neg.l 69e2 <BobVecs+0x8>
			BobVecs[2].X *= -1;
     148:	neg.l 69ea <BobVecs+0x10>
			BobVecs[3].X *= -1;
     14e:	neg.l 69f2 <BobVecs+0x18>
			BobVecs[4].X *= -1;
     154:	neg.l 69fa <BobVecs+0x20>
			BobVecs[5].X *= -1;
     15a:	neg.l d1
     15c:	move.l d1,6a02 <BobVecs+0x28>
			BobPhase = 1;
     162:	move.w #1,2d9a0 <BobPhase>
			BobPause = 2 * 50;
     16a:	move.w #100,2d9a2 <BobPause>
			*copPF1BmpP = 0 << 6; // prio. in bplcon2: pf1 >> pf 2 >> sprites
     172:	movea.l 2d99c <copPF1BmpP>,a0
     178:	clr.w (a0)
     17a:	bra.w a0 <MoveBobs+0x14>
				BobTarget[b].X += BobVecs[b].X;
     17e:	lea 69da <BobVecs>,a1
     184:	move.l d0,d3
     186:	lsl.l #3,d3
     188:	movea.l d3,a0
     18a:	add.l (0,a1,d3.l),d1
     18e:	lea 6a0a <BobTarget>,a1
     194:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X < 0)
     198:	bmi.s 1ce <MoveBobs+0x142>
	switch (BobPhase)
     19a:	move.l d2,d0
		for (int b = 0; b < BOBSN - 1; b++)
     19c:	moveq #4,d1
     19e:	cmp.l d0,d1
     1a0:	blt.s 1d8 <MoveBobs+0x14c>
			if ((BobTarget[b].X - BobTarget[b + 1].X) > 34 || BobTarget[b + 1].X <= 0)
     1a2:	lea 6a0a <BobTarget>,a0
     1a8:	move.l d0,d1
     1aa:	lsl.l #3,d1
     1ac:	move.l (0,a0,d1.l),d1
     1b0:	move.l d0,d2
     1b2:	addq.l #1,d2
     1b4:	move.l d2,d3
     1b6:	lsl.l #3,d3
     1b8:	movea.l (0,a0,d3.l),a0
     1bc:	movea.l d1,a1
     1be:	suba.l a0,a1
     1c0:	moveq #34,d3
     1c2:	cmp.l a1,d3
     1c4:	blt.s 17e <MoveBobs+0xf2>
     1c6:	cmpa.w #0,a0
     1ca:	bgt.s 19a <MoveBobs+0x10e>
     1cc:	bra.s 17e <MoveBobs+0xf2>
					BobTarget[b].X = 0;
     1ce:	clr.l (0,a1,d3.l)
     1d2:	bra.s 19a <MoveBobs+0x10e>
	switch (BobPhase)
     1d4:	moveq #0,d0
     1d6:	bra.s 19c <MoveBobs+0x110>
		BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
     1d8:	move.l 6a02 <BobVecs+0x28>,d1
     1de:	move.l d1,d0
     1e0:	add.l 6a32 <BobTarget+0x28>,d0
     1e6:	move.l d0,6a32 <BobTarget+0x28>
		if (BobTarget[BOBSN - 1].X < 0)
     1ec:	bmi.s 23a <MoveBobs+0x1ae>
		if (BobTarget[0].X <= 0)
     1ee:	tst.l 6a0a <BobTarget>
     1f4:	bgt.w a0 <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     1f8:	neg.l 69da <BobVecs>
			BobVecs[1].X *= -1;
     1fe:	neg.l 69e2 <BobVecs+0x8>
			BobVecs[2].X *= -1;
     204:	neg.l 69ea <BobVecs+0x10>
			BobVecs[3].X *= -1;
     20a:	neg.l 69f2 <BobVecs+0x18>
			BobVecs[4].X *= -1;
     210:	neg.l 69fa <BobVecs+0x20>
			BobVecs[5].X *= -1;
     216:	neg.l d1
     218:	move.l d1,6a02 <BobVecs+0x28>
			BobPause = 2 * 50;
     21e:	move.w #100,2d9a2 <BobPause>
			BobPhase = 0;
     226:	clr.w 2d9a0 <BobPhase>
			*copPF1BmpP = 1 << 6; // prio. in bplcon2: pf2 >> pf 1 >> sprites
     22c:	movea.l 2d99c <copPF1BmpP>,a0
     232:	move.w #64,(a0)
     236:	bra.w a0 <MoveBobs+0x14>
			BobTarget[BOBSN - 1].X = 0;
     23a:	clr.l 6a32 <BobTarget+0x28>
     240:	bra.s 1ee <MoveBobs+0x162>

00000242 <SetupCopper>:

void SetupCopper(USHORT *copPtr)
{
     242:	movem.l d2-d5/a2,-(sp)
     246:	movea.l 24(sp),a1
	UBYTE line = 0x1c;
	// set screen output size
	*copPtr++ = DIWSTRT;
     24a:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     24e:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     254:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     25a:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     260:	move.w #146,8(a1)
	*copPtr++ = 0x38;
     266:	move.w #56,10(a1)
	*copPtr++ = DDFSTOP;
     26c:	move.w #148,12(a1)
	*copPtr++ = 0xd0;
     272:	move.w #208,14(a1)
	// set pf1/2 modulos
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - Screen.Bpl, BmpUpperPart_PF2.Bplt - Screen.Bpl);
     278:	move.w 2db4e <Screen+0x6>,d0
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     27e:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     284:	move.w 2daec <BmpUpperPart_PF1+0x8>,d1
     28a:	sub.w d0,d1
     28c:	move.w d1,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     290:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     296:	move.w 2daba <BmpUpperPart_PF2+0x8>,d2
     29c:	sub.w d0,d2
     29e:	move.w d2,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     2a2:	move.w #258,24(a1)
	*copPtr++ = 0;
     2a8:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     2ac:	move.w #260,28(a1)
	copPF1BmpP = copPtr;
     2b2:	lea 30(a1),a0
     2b6:	move.l a0,2d99c <copPF1BmpP>
	*copPtr++ = 1 << 6; //pf2 >> pf 1 >> sprites
     2bc:	move.w #64,30(a1)
    *copListEnd++ = COP_SKIP;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2c2:	move.w #384,32(a1)
    *copListCurrent++ = color;
     2c8:	move.w #21,34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2ce:	move.w #398,36(a1)
    *copListCurrent++ = color;
     2d4:	lea 40(a1),a0
     2d8:	move.w #21,38(a1)
	// set logo colors
	copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[0]);
	copPtr = copSetColor(copPtr, 7, colgradbluePaletteRGB4[0]);
	for (int a = 1; a < 8; a++)
     2de:	moveq #1,d0
     2e0:	bra.s 300 <SetupCopper+0xbe>
	{
		copPtr = copSetColor(copPtr, a, LogoPaletteRGB4[a]);
     2e2:	movea.l d0,a1
     2e4:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2e6:	move.w d0,d1
     2e8:	addi.w #192,d1
     2ec:	add.w d1,d1
     2ee:	move.w d1,(a0)
    *copListCurrent++ = color;
     2f0:	lea 4942 <LogoPaletteRGB4>,a2
     2f6:	move.w (0,a2,a1.l),2(a0)
	for (int a = 1; a < 8; a++)
     2fc:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, LogoPaletteRGB4[a]);
     2fe:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     300:	moveq #7,d1
     302:	cmp.l d0,d1
     304:	bge.s 2e2 <SetupCopper+0xa0>
	}
	for (int a = 8; a < 16; a++)
     306:	moveq #8,d0
     308:	bra.s 32a <SetupCopper+0xe8>
	{
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     30a:	move.l d0,d1
     30c:	subq.l #8,d1
     30e:	add.l d1,d1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     310:	movea.w d0,a1
     312:	lea 192(a1),a1
     316:	adda.w a1,a1
     318:	move.w a1,(a0)
    *copListCurrent++ = color;
     31a:	lea 4932 <CookiePaletteRGB4>,a1
     320:	move.w (0,a1,d1.l),2(a0)
	for (int a = 8; a < 16; a++)
     326:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     328:	addq.l #4,a0
	for (int a = 8; a < 16; a++)
     32a:	moveq #15,d2
     32c:	cmp.l d0,d2
     32e:	bge.s 30a <SetupCopper+0xc8>
	}
	// set upper part, pf1, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.Planes[0], BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
     330:	moveq #0,d5
     332:	move.w 2daea <BmpUpperPart_PF1+0x6>,d5
     338:	moveq #0,d4
     33a:	move.w 2dae8 <BmpUpperPart_PF1+0x4>,d4
     340:	move.l 2daf6 <BmpUpperPart_PF1+0x12>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     346:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     348:	clr.b d2
     34a:	bra.s 378 <SetupCopper+0x136>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     34c:	move.b d2,d0
     34e:	ext.w d0
     350:	movea.w d0,a1
     352:	moveq #56,d0
     354:	add.l a1,d0
     356:	add.w d0,d0
     358:	add.w d0,d0
     35a:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     35c:	move.l d1,d3
     35e:	clr.w d3
     360:	swap d3
     362:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     366:	addq.w #2,d0
     368:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     36c:	move.w d1,6(a0)
        addr += Bpl;
     370:	add.l d5,d1
        plane += 2;
     372:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     374:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     376:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     378:	moveq #0,d0
     37a:	move.w a2,d0
     37c:	cmp.l d4,d0
     37e:	blt.s 34c <SetupCopper+0x10a>
	// set upper part, pf2, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.Planes[0], BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
     380:	moveq #0,d5
     382:	move.w 2dab8 <BmpUpperPart_PF2+0x6>,d5
     388:	moveq #0,d4
     38a:	move.w 2dab6 <BmpUpperPart_PF2+0x4>,d4
     390:	move.l 2dac4 <BmpUpperPart_PF2+0x12>,d1
     396:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     398:	moveq #1,d2
     39a:	bra.s 3c8 <SetupCopper+0x186>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     39c:	move.b d2,d0
     39e:	ext.w d0
     3a0:	movea.w d0,a1
     3a2:	moveq #56,d0
     3a4:	add.l a1,d0
     3a6:	add.w d0,d0
     3a8:	add.w d0,d0
     3aa:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     3ac:	move.l d1,d3
     3ae:	clr.w d3
     3b0:	swap d3
     3b2:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     3b6:	addq.w #2,d0
     3b8:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3bc:	move.w d1,6(a0)
        addr += Bpl;
     3c0:	add.l d5,d1
        plane += 2;
     3c2:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     3c4:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3c6:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     3c8:	moveq #0,d0
     3ca:	move.w a2,d0
     3cc:	cmp.l d4,d0
     3ce:	blt.s 39c <SetupCopper+0x15a>
	// set sprite pointers
	*copPtr++ = SPR0PTH;
     3d0:	move.w #288,(a0)
	*copPtr++ = (LONG)StarSprite >> 16;
     3d4:	move.l #186002,d0
     3da:	move.l d0,d1
     3dc:	swap d1
     3de:	ext.l d1
     3e0:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
     3e4:	move.w #290,4(a0)
	*copPtr++ = (LONG)StarSprite;
     3ea:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
     3ee:	move.w #292,8(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     3f4:	move.l #185990,d0
     3fa:	move.l d0,d1
     3fc:	swap d1
     3fe:	ext.l d1
     400:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
     404:	move.w #294,12(a0)
	*copPtr++ = (LONG)NullSprite;
     40a:	move.w d0,14(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     40e:	move.w #418,16(a0)
    *copListCurrent++ = color;
     414:	move.w #2120,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     41a:	move.w #420,20(a0)
    *copListCurrent++ = color;
     420:	move.w #143,22(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     426:	move.w #422,24(a0)
    *copListCurrent++ = color;
     42c:	move.w #4095,26(a0)
	// sprite 0+1 colors
	copPtr = copSetColor(copPtr, 17, 0x848);
	copPtr = copSetColor(copPtr, 18, 0x08f);
	copPtr = copSetColor(copPtr, 19, 0xfff);
	*copPtr++ = SPR2PTH;
     432:	move.w #296,28(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     438:	move.w d1,30(a0)
	*copPtr++ = SPR2PTL;
     43c:	move.w #298,32(a0)
	*copPtr++ = (LONG)NullSprite;
     442:	move.w d0,34(a0)
	*copPtr++ = SPR3PTH;
     446:	move.w #300,36(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     44c:	move.w d1,38(a0)
	*copPtr++ = SPR3PTL;
     450:	move.w #302,40(a0)
	*copPtr++ = (LONG)NullSprite;
     456:	move.w d0,42(a0)
	*copPtr++ = SPR4PTH;
     45a:	move.w #304,44(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     460:	move.w d1,46(a0)
	*copPtr++ = SPR4PTL;
     464:	move.w #306,48(a0)
	*copPtr++ = (LONG)NullSprite;
     46a:	move.w d0,50(a0)
	*copPtr++ = SPR5PTH;
     46e:	move.w #308,52(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     474:	move.w d1,54(a0)
	*copPtr++ = SPR5PTL;
     478:	move.w #310,56(a0)
	*copPtr++ = (LONG)NullSprite;
     47e:	move.w d0,58(a0)
	*copPtr++ = SPR6PTH;
     482:	move.w #312,60(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     488:	move.w d1,62(a0)
	*copPtr++ = SPR6PTL;
     48c:	move.w #314,64(a0)
	*copPtr++ = (LONG)NullSprite;
     492:	move.w d0,66(a0)
	*copPtr++ = SPR7PTH;
     496:	move.w #316,68(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     49c:	move.w d1,70(a0)
	*copPtr++ = SPR7PTL;
     4a0:	move.w #318,72(a0)
	*copPtr++ = (LONG)NullSprite;
     4a6:	move.w d0,74(a0)
	// enable bitplanes
	*copPtr++ = BPLCON0;
     4aa:	move.w #256,76(a0)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     4b0:	moveq #0,d0
     4b2:	move.w 2db1a <BmpLogo+0x4>,d0
     4b8:	add.l d0,d0
     4ba:	moveq #12,d3
     4bc:	lsl.l d3,d0
     4be:	ori.w #1536,d0
     4c2:	move.w d0,78(a0)
	// wait till below logo
	line = 0x2c + BmpUpperPart_PF1.Height;
     4c6:	move.b 2dae7 <BmpUpperPart_PF1+0x3>,d0
     4cc:	addi.b #44,d0
	copPtr = copWaitY(copPtr, line++);
     4d0:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     4d6:	lsl.l #8,d0
     4d8:	ori.w #5,d0
     4dc:	move.w d0,80(a0)
    *copListEnd++ = COP_WAIT;
     4e0:	move.w #-2,82(a0)
	// turn off bitplanes to waste 8 lines, giving the logo more bottom space
	// turn off bitplanes to waste 8 lines, giving the logo more bottom space
	*copPtr++ = BPLCON0;
     4e6:	move.w #256,84(a0)
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     4ec:	move.w #512,86(a0)
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
     4f2:	move.b 2dae7 <BmpUpperPart_PF1+0x3>,d0
     4f8:	addi.b #52,d0
	copPtr = copWaitY(copPtr, line++);
     4fc:	move.b 2dae7 <BmpUpperPart_PF1+0x3>,d1
     502:	addi.b #53,d1
     506:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     50c:	lsl.l #8,d0
     50e:	ori.w #5,d0
     512:	move.w d0,88(a0)
    *copListEnd++ = COP_WAIT;
     516:	lea 92(a0),a1
     51a:	move.w #-2,90(a0)
	// set bitplane pointers
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     520:	move.l a1,2d9a4 <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     526:	moveq #0,d5
     528:	move.w 2da54 <BmpScroller+0x6>,d5
     52e:	moveq #0,d4
     530:	move.w 2da52 <BmpScroller+0x4>,d4
     536:	move.l 2da5c <BmpScroller+0xe>,d2
    for (USHORT i = 0; i < numPlanes; i++)
     53c:	suba.l a0,a0
     53e:	bra.s 564 <SetupCopper+0x322>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     540:	moveq #56,d3
     542:	add.l d3,d0
     544:	add.w d0,d0
     546:	add.w d0,d0
     548:	move.w d0,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     54a:	move.l d2,d3
     54c:	clr.w d3
     54e:	swap d3
     550:	move.w d3,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     554:	addq.w #2,d0
     556:	move.w d0,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     55a:	move.w d2,6(a1)
        addr += Bpl;
     55e:	add.l d5,d2
    for (USHORT i = 0; i < numPlanes; i++)
     560:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
     562:	addq.l #8,a1
    for (USHORT i = 0; i < numPlanes; i++)
     564:	moveq #0,d0
     566:	move.w a0,d0
     568:	cmp.l d4,d0
     56a:	blt.s 540 <SetupCopper+0x2fe>
	//set modulo for scroller
	copPtr = copSetBplMod(0, copPtr,
						  BmpScroller.Bplt - Screen.Bpl,
						  BmpScroller.Bplt - Screen.Bpl);
     56c:	move.w 2da56 <BmpScroller+0x8>,d0
     572:	sub.w 2db4e <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     578:	move.w #264,(a1)
    *copListEnd++ = modOdd;
     57c:	move.w d0,2(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     580:	move.w #266,4(a1)
    *copListEnd++ = modEven;
     586:	move.w d0,6(a1)
	*copPtr++ = BPLCON0;
     58a:	move.w #256,8(a1)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     590:	moveq #0,d0
     592:	move.w 2db1a <BmpLogo+0x4>,d0
     598:	moveq #12,d2
     59a:	lsl.l d2,d0
     59c:	lea 12(a1),a0
     5a0:	ori.w #512,d0
     5a4:	move.w d0,10(a1)
	// set font colors for scroller
	for (int a = 1; a < 8; a++)
     5a8:	moveq #1,d0
     5aa:	bra.s 5ca <SetupCopper+0x388>
	{
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     5ac:	move.l d0,d2
     5ae:	add.l d0,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5b0:	movea.w d0,a1
     5b2:	lea 192(a1),a1
     5b6:	adda.w a1,a1
     5b8:	move.w a1,(a0)
    *copListCurrent++ = color;
     5ba:	lea 4922 <FontPaletteRGB4>,a1
     5c0:	move.w (0,a1,d2.l),2(a0)
	for (int a = 1; a < 8; a++)
     5c6:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     5c8:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     5ca:	moveq #7,d3
     5cc:	cmp.l d0,d3
     5ce:	bge.s 5ac <SetupCopper+0x36a>
	}
	// blue gradient below logo
	for (int l = 0; l < 24; l++)
     5d0:	moveq #0,d0
     5d2:	bra.s 602 <SetupCopper+0x3c0>
	{
		copPtr = copWaitY(copPtr, line);
     5d4:	moveq #0,d2
     5d6:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     5d8:	lsl.l #8,d2
     5da:	ori.w #5,d2
     5de:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     5e0:	move.w #-2,2(a0)
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     5e6:	movea.l d0,a1
     5e8:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5ea:	move.w #384,4(a0)
    *copListCurrent++ = color;
     5f0:	lea 4952 <colgradbluePaletteRGB4>,a2
     5f6:	move.w (0,a2,a1.l),6(a0)
		line += 2;
     5fc:	addq.b #2,d1
	for (int l = 0; l < 24; l++)
     5fe:	addq.l #1,d0
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     600:	addq.l #8,a0
	for (int l = 0; l < 24; l++)
     602:	moveq #23,d2
     604:	cmp.l d0,d2
     606:	bge.s 5d4 <SetupCopper+0x392>
	}
	copPtr = copWaitY(copPtr, line++);
     608:	move.b d1,d0
     60a:	addq.b #1,d0
     60c:	moveq #0,d2
     60e:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     610:	lsl.l #8,d2
     612:	ori.w #5,d2
     616:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     618:	move.w #-2,2(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
     61e:	movea.w 69d6 <colScrollMirror>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     624:	move.w #384,4(a0)
    *copListCurrent++ = color;
     62a:	move.w a1,6(a0)
	copPtr = copWaitY(copPtr, line++);
     62e:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     634:	lsl.l #8,d0
     636:	ori.w #5,d0
     63a:	move.w d0,8(a0)
    *copListEnd++ = COP_WAIT;
     63e:	move.w #-2,10(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
     644:	move.w 69d8 <colScrollMirror+0x2>,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     64a:	move.w #384,12(a0)
    *copListCurrent++ = color;
     650:	move.w d2,14(a0)
	line += 7;
     654:	move.b d1,d0
     656:	addi.b #9,d0
	copPtr = copWaitY(copPtr, line++);
     65a:	addi.b #10,d1
     65e:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     664:	lsl.l #8,d0
     666:	ori.w #5,d0
     66a:	move.w d0,16(a0)
    *copListEnd++ = COP_WAIT;
     66e:	move.w #-2,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     674:	move.w #384,20(a0)
    *copListCurrent++ = color;
     67a:	move.w a1,22(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
     67e:	andi.l #255,d1
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     684:	lsl.l #8,d1
     686:	ori.w #5,d1
     68a:	move.w d1,24(a0)
    *copListEnd++ = COP_WAIT;
     68e:	move.w #-2,26(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     694:	move.w #384,28(a0)
    *copListCurrent++ = color;
     69a:	move.w d2,30(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// set bitplane mods
	line = 0x2c + BmpLogo.Height + 72 + 7; // 209
     69e:	move.b 2db19 <BmpLogo+0x3>,d0
     6a4:	addi.b #123,d0
	copPtr = copWaitY(copPtr, line++);
     6a8:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6ae:	lsl.l #8,d0
     6b0:	ori.w #5,d0
     6b4:	move.w d0,32(a0)
    *copListEnd++ = COP_WAIT;
     6b8:	move.w #-2,34(a0)
	copMirrorBmpP = copPtr;
     6be:	lea 36(a0),a2
     6c2:	move.l a2,2d998 <copMirrorBmpP>
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     6c8:	move.w 2db1e <BmpLogo+0x8>,d0
     6ce:	sub.w 2db1c <BmpLogo+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     6d4:	move.w #264,36(a0)
    *copListEnd++ = modOdd;
     6da:	move.w d0,38(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     6de:	move.w #266,40(a0)
    *copListEnd++ = modEven;
     6e4:	move.w d0,42(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6e8:	move.w #-31,44(a0)
    *copListEnd++ = COP_WAIT;
     6ee:	move.w #-2,46(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6f4:	move.w #1285,48(a0)
    *copListEnd++ = COP_WAIT;
     6fa:	move.w #-2,50(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     700:	move.w #384,52(a0)
    *copListCurrent++ = color;
     706:	move.w a1,54(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     70a:	move.w #1541,56(a0)
    *copListEnd++ = COP_WAIT;
     710:	move.w #-2,58(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     716:	move.w #384,60(a0)
    *copListCurrent++ = color;
     71c:	move.w d2,62(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     720:	move.w #11269,64(a0)
    *copListEnd++ = COP_WAIT;
     726:	move.w #-2,66(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     72c:	move.w #384,68(a0)
    *copListCurrent++ = color;
     732:	move.w a1,70(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     736:	move.w #11525,72(a0)
    *copListEnd++ = COP_WAIT;
     73c:	move.w #-2,74(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     742:	move.w #384,76(a0)
    *copListCurrent++ = color;
     748:	move.w d2,78(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     74c:	move.w #-1,80(a0)
    *copListEnd++ = COP_WAIT;
     752:	move.w #-2,82(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// copper end
	copPtr = copWaitXY(copPtr, 0xff, 0xff);
}
     758:	movem.l (sp)+,d2-d5/a2
     75c:	rts

0000075e <EnableMirrorEffect>:

void EnableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2),
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
     75e:	move.w 2da56 <BmpScroller+0x8>,d0
     764:	move.w d0,d1
     766:	sub.w 2db4e <Screen+0x6>,d1
     76c:	add.w d0,d0
     76e:	sub.w d0,d1
	copSetBplMod(0, copMirrorBmpP,
     770:	movea.l 2d998 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     776:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     77a:	move.w d1,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     77e:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     784:	move.w d1,6(a0)
}
     788:	rts

0000078a <DisableMirrorEffect>:

void DisableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 BmpScroller.Bplt - Screen.Bpl,
				 BmpScroller.Bplt - Screen.Bpl);
     78a:	move.w 2da56 <BmpScroller+0x8>,d0
     790:	sub.w 2db4e <Screen+0x6>,d0
	copSetBplMod(0, copMirrorBmpP,
     796:	movea.l 2d998 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     79c:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     7a0:	move.w d0,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     7a4:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     7aa:	move.w d0,6(a0)
}
     7ae:	rts

000007b0 <PlotChar>:
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
	}
}

void PlotChar(BmpDescriptor bmpFont, BmpDescriptor bmpDest, USHORT plotY, USHORT charW, USHORT charH)
{
     7b0:	movem.l d2-d6/a2/a6,-(sp)
     7b4:	move.l 136(sp),d5
     7b8:	move.l 140(sp),d3
     7bc:	move.l 144(sp),d4
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     7c0:	move.w 2d994 <ScrolltextCnt>,d0
     7c6:	move.w d0,d1
     7c8:	addq.w #1,d1
     7ca:	move.w d1,2d994 <ScrolltextCnt>
     7d0:	andi.l #65535,d0
     7d6:	lea 433f <Scrolltext>,a0
     7dc:	move.b (0,a0,d0.l),d0
	ULONG source, dest;
	ULONG row, col;

	// Set standard char distance
	NextPlot = 32;
     7e0:	move.w #32,69d4 <NextPlot>
	// scroller commands: b=bounce; m=mirror; s=stop; c=color
	if (chr == 'b')
     7e8:	cmpi.b #98,d0
     7ec:	beq.w 940 <PlotChar+0x190>
		}
		BounceEnabled = !BounceEnabled;

		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'm')
     7f0:	cmpi.b #109,d0
     7f4:	beq.w 982 <PlotChar+0x1d2>
		}

		MirrorEnabled = !MirrorEnabled;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 's')
     7f8:	cmpi.b #115,d0
     7fc:	beq.w 9ca <PlotChar+0x21a>
	{
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'c')
     800:	cmpi.b #99,d0
     804:	beq.w a50 <PlotChar+0x2a0>
		colScrollMirror[0] = 0x6bf;
		colScrollMirror[1] = 0x49b;
		ResetCopper = TRUE;
	}
	// select character for different spacing
	if (chr == '!' || chr == 'I' || chr == '.' || chr == ',' || chr == ':' || chr == ';' || chr == '\'')
     808:	cmpi.b #33,d0
     80c:	beq.s 832 <PlotChar+0x82>
     80e:	cmpi.b #73,d0
     812:	beq.s 832 <PlotChar+0x82>
     814:	cmpi.b #46,d0
     818:	beq.s 832 <PlotChar+0x82>
     81a:	cmpi.b #44,d0
     81e:	beq.s 832 <PlotChar+0x82>
     820:	cmpi.b #58,d0
     824:	beq.s 832 <PlotChar+0x82>
     826:	cmpi.b #59,d0
     82a:	beq.s 832 <PlotChar+0x82>
     82c:	cmpi.b #39,d0
     830:	bne.s 83a <PlotChar+0x8a>
	{
		NextPlot = 12;
     832:	move.w #12,69d4 <NextPlot>
	}
	if (chr == 'J')
     83a:	cmpi.b #74,d0
     83e:	beq.w a6c <PlotChar+0x2bc>
	{
		NextPlot = 24;
	}
	// check for end of text
	if (chr == 0)
     842:	tst.b d0
     844:	bne.s 86e <PlotChar+0xbe>
	{
		ScrolltextCnt = 0;
     846:	clr.w 2d994 <ScrolltextCnt>
		chr = Scrolltext[ScrolltextCnt++];
     84c:	move.w #1,2d994 <ScrolltextCnt>
		colScrollMirror[0] = 0x111;
     854:	move.w #273,69d6 <colScrollMirror>
		colScrollMirror[1] = 0x222;
     85c:	move.w #546,69d8 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     864:	move.w #1,2d9ae <ResetCopper>
		chr = Scrolltext[ScrolltextCnt++];
     86c:	moveq #32,d0
	}
	// check legal values
	if (chr < 32 || chr > (32 + 80))
     86e:	addi.b #-32,d0
     872:	cmpi.b #80,d0
     876:	bhi.w 93a <PlotChar+0x18a>
		return;
	}
	// skip first 32 ascii codes
	chr -= 32;
	// get row and column of source bitmap (10 chrs per row)
	row = chr / 10;
     87a:	andi.w #255,d0
     87e:	move.w d0,d6
     880:	mulu.w #-13107,d6
     884:	clr.w d6
     886:	swap d6
     888:	lsr.w #3,d6
	col = chr % 10;
     88a:	move.w d6,d1
     88c:	add.w d6,d1
     88e:	add.w d1,d1
     890:	add.w d6,d1
     892:	add.w d1,d1
     894:	sub.w d1,d0
     896:	moveq #0,d2
     898:	move.b d0,d2
	// calc source bitplane pointer
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     89a:	moveq #0,d0
     89c:	move.w 40(sp),d0
     8a0:	lea 27a0 <__mulsi3>,a2
     8a6:	moveq #31,d1
     8a8:	and.l d6,d1
     8aa:	move.l d1,-(sp)
     8ac:	move.l d0,-(sp)
     8ae:	jsr (a2)
     8b0:	addq.l #8,sp
     8b2:	move.l d0,-(sp)
     8b4:	move.w d4,-(sp)
     8b6:	clr.w -(sp)
     8b8:	jsr (a2)
     8ba:	addq.l #8,sp
     8bc:	add.l d2,d2
     8be:	add.l d2,d2
     8c0:	add.l d0,d2
	// calc destination bitplane pointer
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     8c2:	moveq #0,d0
     8c4:	move.w 92(sp),d0
     8c8:	move.l d0,-(sp)
     8ca:	move.w d5,-(sp)
     8cc:	clr.w -(sp)
     8ce:	jsr (a2)
     8d0:	addq.l #8,sp
     8d2:	moveq #0,d5
     8d4:	move.w 2db4e <Screen+0x6>,d5
     8da:	add.l d0,d5
	// wait for blitter and blit
	WaitBlit();
     8dc:	movea.l 2db7e <GfxBase>,a6
     8e2:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     8e6:	movea.l 2db88 <custom>,a0
     8ec:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     8f2:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     8f8:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     8fe:	move.w #-1,70(a0)
	custom->bltapt = ((UBYTE *)bmpFont.ImageData) + source;
     904:	add.l 46(sp),d2
     908:	move.l d2,80(a0)
	custom->bltdpt = ((UBYTE *)bmpDest.ImageData) + dest;
     90c:	add.l 98(sp),d5
     910:	move.l d5,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     914:	move.w d3,d0
     916:	lsr.w #3,d0
     918:	move.w 38(sp),d1
     91c:	sub.w d0,d1
     91e:	move.w d1,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     922:	move.w 90(sp),d1
     926:	sub.w d0,d1
     928:	move.w d1,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     92c:	muls.w 36(sp),d4
     930:	lsl.w #6,d4
     932:	lsr.w #4,d3
     934:	add.w d4,d3
     936:	move.w d3,88(a0)
}
     93a:	movem.l (sp)+,d2-d6/a2/a6
     93e:	rts
		if (BounceEnabled)
     940:	move.w 2d9ac <BounceEnabled>,d0
     946:	beq.s 956 <PlotChar+0x1a6>
			ScrollerY = SCRT_MIN;
     948:	clr.w 2d9aa <ScrollerY>
			ScrollerDir = 1;
     94e:	move.b #1,6a3a <ScrollerDir>
		BounceEnabled = !BounceEnabled;
     956:	tst.w d0
     958:	seq d0
     95a:	ext.w d0
     95c:	neg.w d0
     95e:	move.w d0,2d9ac <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     964:	move.w d1,d0
     966:	addq.w #1,d0
     968:	move.w d0,2d994 <ScrolltextCnt>
     96e:	andi.l #65535,d1
     974:	lea 433f <Scrolltext>,a0
     97a:	move.b (0,a0,d1.l),d0
     97e:	bra.w 7f0 <PlotChar+0x40>
		if (MirrorEnabled)
     982:	tst.w 2d992 <MirrorEnabled>
     988:	beq.s 9c4 <PlotChar+0x214>
			DisableMirrorEffect();
     98a:	jsr 78a <DisableMirrorEffect>(pc)
		MirrorEnabled = !MirrorEnabled;
     98e:	tst.w 2d992 <MirrorEnabled>
     994:	seq d0
     996:	ext.w d0
     998:	neg.w d0
     99a:	move.w d0,2d992 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     9a0:	move.w 2d994 <ScrolltextCnt>,d0
     9a6:	move.w d0,d1
     9a8:	addq.w #1,d1
     9aa:	move.w d1,2d994 <ScrolltextCnt>
     9b0:	andi.l #65535,d0
     9b6:	lea 433f <Scrolltext>,a0
     9bc:	move.b (0,a0,d0.l),d0
     9c0:	bra.w 7f8 <PlotChar+0x48>
			EnableMirrorEffect();
     9c4:	jsr 75e <EnableMirrorEffect>(pc)
     9c8:	bra.s 98e <PlotChar+0x1de>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     9ca:	tst.w 2d9ac <BounceEnabled>
     9d0:	beq.s a22 <PlotChar+0x272>
     9d2:	move.w 2d994 <ScrolltextCnt>,d0
     9d8:	move.w d0,d1
     9da:	addq.w #1,d1
     9dc:	move.w d1,2d994 <ScrolltextCnt>
     9e2:	andi.l #65535,d0
     9e8:	lea 433f <Scrolltext>,a0
     9ee:	move.b (0,a0,d0.l),d0
     9f2:	ext.w d0
     9f4:	addi.w #-48,d0
     9f8:	move.w d0,2d9a8 <ScrollerPause>
		chr = Scrolltext[ScrolltextCnt++];
     9fe:	move.w 2d994 <ScrolltextCnt>,d0
     a04:	move.w d0,d1
     a06:	addq.w #1,d1
     a08:	move.w d1,2d994 <ScrolltextCnt>
     a0e:	andi.l #65535,d0
     a14:	lea 433f <Scrolltext>,a0
     a1a:	move.b (0,a0,d0.l),d0
     a1e:	bra.w 800 <PlotChar+0x50>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     a22:	move.w 2d994 <ScrolltextCnt>,d0
     a28:	move.w d0,d1
     a2a:	addq.w #1,d1
     a2c:	move.w d1,2d994 <ScrolltextCnt>
     a32:	andi.l #65535,d0
     a38:	lea 433f <Scrolltext>,a0
     a3e:	move.b (0,a0,d0.l),d0
     a42:	ext.w d0
     a44:	movea.w d0,a0
     a46:	moveq #-48,d0
     a48:	add.l a0,d0
     a4a:	muls.w #50,d0
     a4e:	bra.s 9f8 <PlotChar+0x248>
		colScrollMirror[0] = 0x6bf;
     a50:	move.w #1727,69d6 <colScrollMirror>
		colScrollMirror[1] = 0x49b;
     a58:	move.w #1179,69d8 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     a60:	move.w #1,2d9ae <ResetCopper>
     a68:	bra.w 808 <PlotChar+0x58>
		NextPlot = 24;
     a6c:	move.w #24,69d4 <NextPlot>
     a74:	bra.w 842 <PlotChar+0x92>

00000a78 <Scrollit>:
{
     a78:	movem.l d2-d7/a2/a6,-(sp)
     a7c:	move.l 96(sp),d3
     a80:	move.l 100(sp),d4
	int BltOffs = startY * theDesc.Bplt;
     a84:	moveq #0,d5
     a86:	move.w 94(sp),d5
     a8a:	moveq #0,d6
     a8c:	move.w 44(sp),d6
     a90:	lea 27a0 <__mulsi3>,a2
     a96:	move.l d6,-(sp)
     a98:	move.l d5,-(sp)
     a9a:	jsr (a2)
     a9c:	addq.l #8,sp
     a9e:	move.l d0,d2
	int Brcorner = height * theDesc.Bplt - 2;
     aa0:	move.l d6,-(sp)
     aa2:	move.w d3,-(sp)
     aa4:	clr.w -(sp)
     aa6:	jsr (a2)
     aa8:	addq.l #8,sp
     aaa:	move.l d0,d7
     aac:	subq.l #2,d7
	WaitBlit();
     aae:	movea.l 2db7e <GfxBase>,a6
     ab4:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     ab8:	clr.w d6
     aba:	move.b d4,d6
     abc:	moveq #12,d0
     abe:	lsl.w d0,d4
     ac0:	movea.l 2db88 <custom>,a0
     ac6:	addi.w #2544,d4
     aca:	move.w d4,64(a0)
	custom->bltcon1 = 0x0002;
     ace:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     ad4:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     ada:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     ae0:	move.l d2,d0
     ae2:	add.l d7,d0
     ae4:	add.l 88(sp),d0
     ae8:	move.l d0,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     aec:	move.l d0,84(a0)
	custom->bltamod = 0;
     af0:	move.w #0,100(a0)
	custom->bltdmod = 0;
     af6:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
     afc:	move.w 40(sp),d0
     b00:	muls.w d3,d0
     b02:	lsl.w #6,d0
     b04:	move.w 2da4e <BmpScroller>,d1
     b0a:	lsr.w #4,d1
     b0c:	add.w d1,d0
     b0e:	move.w d0,88(a0)
	ScrollCnt += speed;
     b12:	add.w 2d996 <ScrollCnt>,d6
     b18:	move.w d6,2d996 <ScrollCnt>
	if (ScrollCnt >= NextPlot)
     b1e:	cmp.w 69d4 <NextPlot>,d6
     b24:	bcc.s b2c <Scrollit+0xb4>
}
     b26:	movem.l (sp)+,d2-d7/a2/a6
     b2a:	rts
		ScrollCnt = 0;
     b2c:	clr.w 2d996 <ScrollCnt>
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
     b32:	pea 20 <_start+0x20>
     b36:	pea 20 <_start+0x20>
     b3a:	move.l d5,-(sp)
     b3c:	subq.l #2,sp
     b3e:	move.l 2da7c <BmpScroller+0x2e>,-(sp)
     b44:	move.l 2da78 <BmpScroller+0x2a>,-(sp)
     b4a:	move.l 2da74 <BmpScroller+0x26>,-(sp)
     b50:	move.l 2da70 <BmpScroller+0x22>,-(sp)
     b56:	move.l 2da6c <BmpScroller+0x1e>,-(sp)
     b5c:	move.l 2da68 <BmpScroller+0x1a>,-(sp)
     b62:	move.l 2da64 <BmpScroller+0x16>,-(sp)
     b68:	move.l 2da60 <BmpScroller+0x12>,-(sp)
     b6e:	move.l 2da5c <BmpScroller+0xe>,-(sp)
     b74:	move.l 2da58 <BmpScroller+0xa>,-(sp)
     b7a:	move.l 2da54 <BmpScroller+0x6>,-(sp)
     b80:	move.l 2da50 <BmpScroller+0x2>,-(sp)
     b86:	move.w 2da4e <BmpScroller>,-(sp)
     b8c:	subq.l #2,sp
     b8e:	move.l 2da4a <BmpFont32+0x2e>,-(sp)
     b94:	move.l 2da46 <BmpFont32+0x2a>,-(sp)
     b9a:	move.l 2da42 <BmpFont32+0x26>,-(sp)
     ba0:	move.l 2da3e <BmpFont32+0x22>,-(sp)
     ba6:	move.l 2da3a <BmpFont32+0x1e>,-(sp)
     bac:	move.l 2da36 <BmpFont32+0x1a>,-(sp)
     bb2:	move.l 2da32 <BmpFont32+0x16>,-(sp)
     bb8:	move.l 2da2e <BmpFont32+0x12>,-(sp)
     bbe:	move.l 2da2a <BmpFont32+0xe>,-(sp)
     bc4:	move.l 2da26 <BmpFont32+0xa>,-(sp)
     bca:	move.l 2da22 <BmpFont32+0x6>,-(sp)
     bd0:	move.l 2da1e <BmpFont32+0x2>,-(sp)
     bd6:	move.w 2da1c <BmpFont32>,-(sp)
     bdc:	jsr 7b0 <PlotChar>(pc)
     be0:	lea 116(sp),sp
     be4:	bra.w b26 <Scrollit+0xae>

00000be8 <GetVBR>:

static APTR GetVBR()
{
     be8:	subq.l #8,sp
     bea:	move.l a6,-(sp)
     bec:	move.l d7,-(sp)
	APTR vbr = 0;
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     bee:	move.w #20090,10(sp)
     bf4:	move.w #2049,12(sp)
     bfa:	move.w #20083,14(sp)

	if (SysBase->AttnFlags & AFF_68010)
     c00:	movea.l 2db82 <SysBase>,a6
     c06:	btst #0,297(a6)
     c0c:	beq.s c22 <GetVBR+0x3a>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     c0e:	moveq #10,d7
     c10:	add.l sp,d7
     c12:	exg d7,a5
     c14:	jsr -30(a6)
     c18:	exg d7,a5

	return vbr;
}
     c1a:	move.l (sp)+,d7
     c1c:	movea.l (sp)+,a6
     c1e:	addq.l #8,sp
     c20:	rts
	APTR vbr = 0;
     c22:	moveq #0,d0
	return vbr;
     c24:	bra.s c1a <GetVBR+0x32>

00000c26 <SetInterruptHandler>:

void SetInterruptHandler(APTR interrupt)
{
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     c26:	movea.l 2d98e <VBR>,a0
     c2c:	move.l 4(sp),108(a0)
}
     c32:	rts

00000c34 <GetInterruptHandler>:

APTR GetInterruptHandler()
{
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     c34:	movea.l 2d98e <VBR>,a0
     c3a:	move.l 108(a0),d0
}
     c3e:	rts

00000c40 <WaitVbl>:

//vblank begins at vpos 312 hpos 1 and ends at vpos 25 hpos 1
//vsync begins at line 2 hpos 132 and ends at vpos 5 hpos 18
void WaitVbl()
{
     c40:	subq.l #8,sp
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     c42:	move.l dff004 <_end+0xdd1478>,d0
     c48:	move.l d0,(sp)
		vpos &= 0x1ff00;
     c4a:	move.l (sp),d0
     c4c:	andi.l #130816,d0
     c52:	move.l d0,(sp)
		if (vpos != (311 << 8))
     c54:	move.l (sp),d0
     c56:	cmpi.l #79616,d0
     c5c:	beq.s c42 <WaitVbl+0x2>
			break;
	}
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     c5e:	move.l dff004 <_end+0xdd1478>,d0
     c64:	move.l d0,4(sp)
		vpos &= 0x1ff00;
     c68:	move.l 4(sp),d0
     c6c:	andi.l #130816,d0
     c72:	move.l d0,4(sp)
		if (vpos == (311 << 8))
     c76:	move.l 4(sp),d0
     c7a:	cmpi.l #79616,d0
     c80:	bne.s c5e <WaitVbl+0x1e>
			break;
	}
}
     c82:	addq.l #8,sp
     c84:	rts

00000c86 <TakeSystem>:
	{
	} //blitter busy wait
}

void TakeSystem()
{
     c86:	move.l a6,-(sp)
     c88:	move.l a2,-(sp)
	ActiView = GfxBase->ActiView; //store current view
     c8a:	movea.l 2db7e <GfxBase>,a6
     c90:	move.l 34(a6),2d98a <ActiView>
	OwnBlitter();
     c98:	jsr -456(a6)
	WaitBlit();
     c9c:	movea.l 2db7e <GfxBase>,a6
     ca2:	jsr -228(a6)
	Disable();
     ca6:	movea.l 2db82 <SysBase>,a6
     cac:	jsr -120(a6)

	//Save current interrupts and DMA settings so we can restore them upon exit.
	SystemADKCON = custom->adkconr;
     cb0:	movea.l 2db88 <custom>,a0
     cb6:	move.w 16(a0),d0
     cba:	move.w d0,2d988 <SystemADKCON>
	SystemInts = custom->intenar;
     cc0:	move.w 28(a0),d0
     cc4:	move.w d0,2d986 <SystemInts>
	SystemDMA = custom->dmaconr;
     cca:	move.w 2(a0),d0
     cce:	move.w d0,2d984 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     cd4:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     cda:	move.w #32767,156(a0)

	WaitVbl();
     ce0:	lea c40 <WaitVbl>(pc),a2
     ce4:	jsr (a2)
	WaitVbl();
     ce6:	jsr (a2)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     ce8:	movea.l 2db88 <custom>,a0
     cee:	move.w #32767,150(a0)

	//set all colors black
	for (int a = 0; a < 32; a++)
     cf4:	moveq #0,d1
     cf6:	bra.s d0a <TakeSystem+0x84>
		custom->color[a] = 0;
     cf8:	move.l d1,d0
     cfa:	addi.l #192,d0
     d00:	add.l d0,d0
     d02:	move.w #0,(0,a0,d0.l)
	for (int a = 0; a < 32; a++)
     d08:	addq.l #1,d1
     d0a:	moveq #31,d0
     d0c:	cmp.l d1,d0
     d0e:	bge.s cf8 <TakeSystem+0x72>

	LoadView(0);
     d10:	movea.l 2db7e <GfxBase>,a6
     d16:	suba.l a1,a1
     d18:	jsr -222(a6)
	WaitTOF();
     d1c:	movea.l 2db7e <GfxBase>,a6
     d22:	jsr -270(a6)
	WaitTOF();
     d26:	movea.l 2db7e <GfxBase>,a6
     d2c:	jsr -270(a6)

	WaitVbl();
     d30:	lea c40 <WaitVbl>(pc),a2
     d34:	jsr (a2)
	WaitVbl();
     d36:	jsr (a2)

	VBR = GetVBR();
     d38:	jsr be8 <GetVBR>(pc)
     d3c:	move.l d0,2d98e <VBR>
	SystemIrq = GetInterruptHandler(); //store interrupt register
     d42:	jsr c34 <GetInterruptHandler>(pc)
     d46:	move.l d0,2d980 <SystemIrq>
}
     d4c:	movea.l (sp)+,a2
     d4e:	movea.l (sp)+,a6
     d50:	rts

00000d52 <FreeSystem>:

void FreeSystem()
{
     d52:	move.l a6,-(sp)
	WaitVbl();
     d54:	jsr c40 <WaitVbl>(pc)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     d58:	movea.l 2db88 <custom>,a0
     d5e:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     d62:	move.w 2(a0),d0
     d66:	btst #14,d0
     d6a:	bne.s d62 <FreeSystem+0x10>
	WaitBlt();
	custom->intena = 0x7fff; //disable all interrupts
     d6c:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     d72:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     d78:	move.w #32767,150(a0)

	//restore interrupts
	SetInterruptHandler(SystemIrq);
     d7e:	move.l 2d980 <SystemIrq>,-(sp)
     d84:	jsr c26 <SetInterruptHandler>(pc)

	/*Restore system copper list(s). */
	custom->cop1lc = (ULONG)GfxBase->copinit;
     d88:	movea.l 2db7e <GfxBase>,a6
     d8e:	movea.l 2db88 <custom>,a0
     d94:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     d9a:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     da0:	move.w #32767,136(a0)

	/*Restore all interrupts and DMA settings. */
	custom->intena = SystemInts | 0x8000;
     da6:	move.w 2d986 <SystemInts>,d0
     dac:	ori.w #-32768,d0
     db0:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     db4:	move.w 2d984 <SystemDMA>,d0
     dba:	ori.w #-32768,d0
     dbe:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     dc2:	move.w 2d988 <SystemADKCON>,d0
     dc8:	ori.w #-32768,d0
     dcc:	move.w d0,158(a0)

	LoadView(ActiView);
     dd0:	movea.l 2d98a <ActiView>,a1
     dd6:	jsr -222(a6)
	WaitTOF();
     dda:	movea.l 2db7e <GfxBase>,a6
     de0:	jsr -270(a6)
	WaitTOF();
     de4:	movea.l 2db7e <GfxBase>,a6
     dea:	jsr -270(a6)
	WaitBlit();
     dee:	movea.l 2db7e <GfxBase>,a6
     df4:	jsr -228(a6)
	DisownBlitter();
     df8:	movea.l 2db7e <GfxBase>,a6
     dfe:	jsr -462(a6)
	Enable();
     e02:	movea.l 2db82 <SysBase>,a6
     e08:	jsr -126(a6)
     e0c:	addq.l #4,sp
}
     e0e:	movea.l (sp)+,a6
     e10:	rts

00000e12 <InitImagePlanes>:

void InitImagePlanes(BmpDescriptor *img, USHORT offs)
{
     e12:	movem.l d2-d4/a2,-(sp)
     e16:	movea.l 20(sp),a2
     e1a:	move.w 26(sp),d4
	for (int p = 0; p < img->Bpls; p++)
     e1e:	moveq #0,d2
     e20:	bra.s e4c <InitImagePlanes+0x3a>
	{
		img->Planes[p] = ((UBYTE *)img->ImageData) + offs + (p * (img->Bpl));
     e22:	move.l 14(a2),d3
     e26:	moveq #0,d0
     e28:	move.w 6(a2),d0
     e2c:	move.l d2,-(sp)
     e2e:	move.l d0,-(sp)
     e30:	jsr 27a0 <__mulsi3>
     e36:	addq.l #8,sp
     e38:	moveq #0,d1
     e3a:	move.w d4,d1
     e3c:	add.l d1,d0
     e3e:	move.l d2,d1
     e40:	add.l d2,d1
     e42:	add.l d1,d1
     e44:	add.l d0,d3
     e46:	move.l d3,(18,a2,d1.l)
	for (int p = 0; p < img->Bpls; p++)
     e4a:	addq.l #1,d2
     e4c:	moveq #0,d0
     e4e:	move.w 4(a2),d0
     e52:	cmp.l d0,d2
     e54:	blt.s e22 <InitImagePlanes+0x10>
	}
}
     e56:	movem.l (sp)+,d2-d4/a2
     e5a:	rts

00000e5c <CopyBitmap>:
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     e5c:	movea.l 2db88 <custom>,a0
     e62:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     e66:	move.w 2(a0),d0
     e6a:	btst #14,d0
     e6e:	bne.s e66 <CopyBitmap+0xa>

void CopyBitmap(BmpDescriptor bmpS, BmpDescriptor bmpD)
{
	WaitBlt();

	custom->bltcon0 = 0x09f0;
     e70:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     e76:	move.w #0,66(a0)
	custom->bltapt = (UBYTE *)bmpS.ImageData;
     e7c:	move.l 18(sp),80(a0)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
     e82:	move.l 70(sp),84(a0)
	custom->bltafwm = 0xffff;
     e88:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     e8e:	move.w #-1,70(a0)
	custom->bltamod = 0;
     e94:	move.w #0,100(a0)
	custom->bltdmod = 0;
     e9a:	move.w #0,102(a0)
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
     ea0:	move.w 6(sp),d1
     ea4:	muls.w 8(sp),d1
     ea8:	lsl.w #6,d1
     eaa:	move.w 10(sp),d0
     eae:	lsr.w #1,d0
     eb0:	add.w d1,d0
     eb2:	move.w d0,88(a0)
}
     eb6:	rts

00000eb8 <ClearBitmapPart>:
	custom->bltdmod = 0;
	custom->bltsize = ((lines * bmpD.Bpls) << 6) + (bmpD.Width / 16);
}

void ClearBitmapPart(BmpDescriptor bmp, int x, int y, int height, int width)
{
     eb8:	movem.l d2-d5/a2-a3,-(sp)
     ebc:	move.l 80(sp),d5
     ec0:	movea.l 92(sp),a3
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     ec4:	movea.l 2db88 <custom>,a2
     eca:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     ece:	move.w 2(a2),d0
     ed2:	btst #14,d0
     ed6:	bne.s ece <ClearBitmapPart+0x16>
	WaitBlt();
	BYTE shift = x % 16;
     ed8:	move.l d5,d2
     eda:	andi.l #-2147483633,d2
     ee0:	tst.l d5
     ee2:	blt.w f7e <ClearBitmapPart+0xc6>
	if (shift)
     ee6:	tst.b d2
     ee8:	beq.s eee <ClearBitmapPart+0x36>
		width += 16;
     eea:	lea 16(a3),a3
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
     eee:	move.b d2,d0
     ef0:	ext.w d0
     ef2:	move.w d0,d4
     ef4:	ext.l d4
     ef6:	move.l d4,d1
     ef8:	moveq #12,d3
     efa:	lsl.l d3,d1
     efc:	ori.w #2304,d1
     f00:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
     f04:	moveq #12,d1
     f06:	lsl.w d1,d0
     f08:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     f0c:	move.l 42(sp),d3
     f10:	moveq #0,d0
     f12:	move.w 36(sp),d0
     f16:	move.l 84(sp),-(sp)
     f1a:	move.l d0,-(sp)
     f1c:	jsr 27a0 <__mulsi3>
     f22:	addq.l #8,sp
     f24:	move.l d5,d1
     f26:	bmi.s f8a <ClearBitmapPart+0xd2>
     f28:	asr.l #3,d1
     f2a:	add.l d1,d0
     f2c:	add.l d3,d0
     f2e:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     f32:	move.l d0,84(a2)
	custom->bltafwm = 0xffff;
     f36:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     f3c:	tst.b d2
     f3e:	beq.s f8e <ClearBitmapPart+0xd6>
     f40:	moveq #15,d1
     f42:	sub.l d4,d1
     f44:	moveq #0,d0
     f46:	not.w d0
     f48:	asr.l d1,d0
     f4a:	move.w d0,70(a2)
	;
	custom->bltamod = bmp.Bpl - (width / 8);
     f4e:	move.w 34(sp),d0
     f52:	move.l a3,d1
     f54:	bmi.s f92 <ClearBitmapPart+0xda>
     f56:	asr.l #3,d1
     f58:	sub.w d1,d0
     f5a:	move.w d0,100(a2)
	custom->bltdmod = bmp.Bpl - (width / 8);
     f5e:	move.w d0,102(a2)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     f62:	move.w 32(sp),d0
     f66:	muls.w 90(sp),d0
     f6a:	lsl.w #6,d0
     f6c:	move.l a3,d1
     f6e:	bmi.s f96 <ClearBitmapPart+0xde>
     f70:	asr.l #4,d1
     f72:	add.w d1,d0
     f74:	move.w d0,88(a2)
}
     f78:	movem.l (sp)+,d2-d5/a2-a3
     f7c:	rts
	BYTE shift = x % 16;
     f7e:	subq.l #1,d2
     f80:	moveq #-16,d0
     f82:	or.l d0,d2
     f84:	addq.l #1,d2
     f86:	bra.w ee6 <ClearBitmapPart+0x2e>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     f8a:	addq.l #7,d1
     f8c:	bra.s f28 <ClearBitmapPart+0x70>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     f8e:	moveq #-1,d0
     f90:	bra.s f4a <ClearBitmapPart+0x92>
	custom->bltamod = bmp.Bpl - (width / 8);
     f92:	addq.l #7,d1
     f94:	bra.s f56 <ClearBitmapPart+0x9e>
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     f96:	moveq #15,d1
     f98:	add.l a3,d1
     f9a:	bra.s f70 <ClearBitmapPart+0xb8>

00000f9c <SimpleBlit>:

void SimpleBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
     f9c:	movem.l d2-d7/a2,-(sp)
     fa0:	move.l 136(sp),d7
     fa4:	move.l 140(sp),d1
     fa8:	move.l 144(sp),d4
     fac:	move.l 148(sp),d5
     fb0:	move.l 152(sp),d3
     fb4:	move.l 156(sp),d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     fb8:	movea.l 2db88 <custom>,a2
     fbe:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     fc2:	move.w 2(a2),d0
     fc6:	btst #14,d0
     fca:	bne.s fc2 <SimpleBlit+0x26>
	WaitBlt();
	custom->bltcon0 = 0x09f0;
     fcc:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
     fd2:	move.w #0,66(a2)
	custom->bltafwm = 0xffff;
     fd8:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
     fde:	move.w #-1,70(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
     fe4:	move.w d2,d0
     fe6:	lsr.w #3,d0
     fe8:	movea.w 38(sp),a0
     fec:	suba.w d0,a0
     fee:	move.w a0,100(a2)
	custom->bltdmod = imgD.Bpl - (width / 8);
     ff2:	movea.w 90(sp),a0
     ff6:	suba.w d0,a0
     ff8:	move.w a0,102(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
     ffc:	move.l 46(sp),d6
    1000:	moveq #0,d0
    1002:	move.w 40(sp),d0
    1006:	move.l d0,-(sp)
    1008:	move.l d1,-(sp)
    100a:	jsr 27a0 <__mulsi3>
    1010:	addq.l #8,sp
    1012:	move.l d7,d1
    1014:	bmi.s 1058 <SimpleBlit+0xbc>
    1016:	asr.l #3,d1
    1018:	add.l d1,d0
    101a:	add.l d6,d0
    101c:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1020:	move.l 98(sp),d6
    1024:	moveq #0,d0
    1026:	move.w 92(sp),d0
    102a:	move.l d0,-(sp)
    102c:	move.l d5,-(sp)
    102e:	jsr 27a0 <__mulsi3>
    1034:	addq.l #8,sp
    1036:	move.l d4,d1
    1038:	bmi.s 105c <SimpleBlit+0xc0>
    103a:	asr.l #3,d1
    103c:	add.l d1,d0
    103e:	add.l d6,d0
    1040:	move.l d0,84(a2)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
    1044:	muls.w 36(sp),d3
    1048:	lsl.w #6,d3
    104a:	lsr.w #4,d2
    104c:	add.w d3,d2
    104e:	move.w d2,88(a2)
}
    1052:	movem.l (sp)+,d2-d7/a2
    1056:	rts
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1058:	addq.l #7,d1
    105a:	bra.s 1016 <SimpleBlit+0x7a>
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    105c:	addq.l #7,d1
    105e:	bra.s 103a <SimpleBlit+0x9e>

00001060 <BetterBlit>:

void BetterBlit(BmpDescriptor imgS, BmpDescriptor imgD, BmpDescriptor imgM, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    1060:	movem.l d2-d7/a2-a6,-(sp)
    1064:	movea.l 204(sp),a3
    1068:	move.l 208(sp),d7
    106c:	move.l 212(sp),d5
    1070:	movea.l 216(sp),a5
    1074:	movea.l 220(sp),a4
    1078:	move.l 224(sp),d1
    107c:	move.w d1,d4
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    107e:	movea.l 2db88 <custom>,a2
    1084:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1088:	move.w 2(a2),d0
    108c:	btst #14,d0
    1090:	bne.s 1088 <BetterBlit+0x28>
	WaitBlt();
	BYTE shift = startD.X % 16;
    1092:	move.l d5,d3
    1094:	andi.l #-2147483633,d3
    109a:	tst.l d5
    109c:	blt.w 1190 <BetterBlit+0x130>
	if (shift)
    10a0:	tst.b d3
    10a2:	beq.s 10aa <BetterBlit+0x4a>
		width += 16;
    10a4:	move.w d1,d4
    10a6:	addi.w #16,d4

	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    10aa:	move.b d3,d0
    10ac:	ext.w d0
    10ae:	movea.w d0,a6
    10b0:	move.l a6,d1
    10b2:	moveq #12,d2
    10b4:	lsl.l d2,d1
    10b6:	ori.w #4042,d1
    10ba:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    10be:	moveq #12,d1
    10c0:	lsl.w d1,d0
    10c2:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    10c6:	move.l 62(sp),d6
    10ca:	moveq #0,d0
    10cc:	move.w 56(sp),d0
    10d0:	move.l d0,-(sp)
    10d2:	move.l d7,-(sp)
    10d4:	jsr 27a0 <__mulsi3>
    10da:	addq.l #8,sp
    10dc:	move.l a3,d2
    10de:	bmi.w 119c <BetterBlit+0x13c>
    10e2:	asr.l #3,d2
    10e4:	add.l d2,d0
    10e6:	add.l d6,d0
    10e8:	move.l d0,80(a2)
	custom->bltamod = imgS.Bpl - (width / 8);
    10ec:	move.w d4,d6
    10ee:	lsr.w #3,d6
    10f0:	move.w 54(sp),d0
    10f4:	sub.w d6,d0
    10f6:	move.w d0,100(a2)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    10fa:	moveq #0,d0
    10fc:	move.w 160(sp),d0
    1100:	lea 27a0 <__mulsi3>,a3
    1106:	move.l d0,-(sp)
    1108:	move.l d7,-(sp)
    110a:	jsr (a3)
    110c:	addq.l #8,sp
    110e:	add.l d0,d2
    1110:	add.l 166(sp),d2
    1114:	move.l d2,76(a2)
	custom->bltbmod = imgM.Bpl - (width / 8);
    1118:	move.w 158(sp),d0
    111c:	sub.w d6,d0
    111e:	move.w d0,98(a2)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1122:	move.l 114(sp),d2
    1126:	moveq #0,d0
    1128:	move.w 108(sp),d0
    112c:	move.l d0,-(sp)
    112e:	move.l a5,-(sp)
    1130:	jsr (a3)
    1132:	addq.l #8,sp
    1134:	move.l d5,d1
    1136:	bmi.s 11a2 <BetterBlit+0x142>
    1138:	asr.l #3,d1
    113a:	add.l d1,d0
    113c:	add.l d2,d0
    113e:	move.l d0,84(a2)
    1142:	move.l d0,72(a2)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    1146:	move.w 106(sp),d0
    114a:	sub.w d6,d0
    114c:	move.w d0,102(a2)
    1150:	move.w d0,96(a2)
	custom->bltafwm = 0xffff;
    1154:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    115a:	tst.b d3
    115c:	beq.s 11a6 <BetterBlit+0x146>
    115e:	moveq #15,d1
    1160:	sub.l a6,d1
    1162:	moveq #0,d0
    1164:	not.w d0
    1166:	asr.l d1,d0
    1168:	move.w d0,70(a2)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    116c:	moveq #0,d0
    116e:	move.w 52(sp),d0
    1172:	move.l d0,-(sp)
    1174:	move.w a4,-(sp)
    1176:	clr.w -(sp)
    1178:	jsr 27a0 <__mulsi3>
    117e:	addq.l #8,sp
    1180:	lsl.l #6,d0
    1182:	lsr.w #4,d4
    1184:	or.w d0,d4
    1186:	move.w d4,88(a2)
}
    118a:	movem.l (sp)+,d2-d7/a2-a6
    118e:	rts
	BYTE shift = startD.X % 16;
    1190:	subq.l #1,d3
    1192:	moveq #-16,d0
    1194:	or.l d0,d3
    1196:	addq.l #1,d3
    1198:	bra.w 10a0 <BetterBlit+0x40>
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    119c:	addq.l #7,d2
    119e:	bra.w 10e2 <BetterBlit+0x82>
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    11a2:	addq.l #7,d1
    11a4:	bra.s 1138 <BetterBlit+0xd8>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    11a6:	moveq #-1,d0
    11a8:	bra.s 1168 <BetterBlit+0x108>

000011aa <p61Init>:

int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
    11aa:	move.l a3,-(sp)
    11ac:	move.l a2,-(sp)
	register volatile const void *_a0 ASM("a0") = module;
    11ae:	movea.l 12(sp),a0
	register volatile const void *_a1 ASM("a1") = NULL;
    11b2:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
    11b4:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
    11b6:	lea 297e <incbin_P61_Player_start>,a3
	register int _d0 ASM("d0"); // return value
	__asm volatile(
    11bc:	movem.l d1-d7/a4-a6,-(sp)
    11c0:	jsr (a3)
    11c2:	movem.l (sp)+,d1-d7/a4-a6
		"movem.l (%%sp)+,%%d1-%%d7/%%a4-%%a6"
		: "=r"(_d0), "+rf"(_a0), "+rf"(_a1), "+rf"(_a2), "+rf"(_a3)
		:
		: "cc", "memory");
	return _d0;
}
    11c6:	movea.l (sp)+,a2
    11c8:	movea.l (sp)+,a3
    11ca:	rts

000011cc <p61Music>:

void p61Music()
{
    11cc:	move.l a6,-(sp)
    11ce:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    11d0:	lea 297e <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    11d6:	movea.l #14675968,a6
	__asm volatile(
    11dc:	movem.l d0-a2/a4-a5,-(sp)
    11e0:	jsr 4(a3)
    11e4:	movem.l (sp)+,d0-a2/a4-a5
		"jsr 4(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d7/%%a0-%%a2/%%a4-%%a5"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    11e8:	movea.l (sp)+,a3
    11ea:	movea.l (sp)+,a6
    11ec:	rts

000011ee <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);
// interrupt handler
static __attribute__((interrupt)) void interruptHandler()
{
    11ee:	movem.l d0-d1/a0-a1,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    11f2:	movea.l 2db88 <custom>,a0
    11f8:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    11fe:	move.w #32,156(a0)

    // DEMO - ThePlayer
    p61Music();
    1204:	jsr 11cc <p61Music>(pc)

    // DEMO - increment frameCounter
    frameCounter++;
    1208:	move.w 2db86 <frameCounter>,d0
    120e:	addq.w #1,d0
    1210:	move.w d0,2db86 <frameCounter>
}
    1216:	movem.l (sp)+,d0-d1/a0-a1
    121a:	rte

0000121c <p61End>:

void p61End()
{
    121c:	move.l a6,-(sp)
    121e:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    1220:	lea 297e <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    1226:	movea.l #14675968,a6
	__asm volatile(
    122c:	movem.l d0-d1/a0-a1,-(sp)
    1230:	jsr 8(a3)
    1234:	movem.l (sp)+,d0-d1/a0-a1
		"jsr 8(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d1/%%a0-%%a1"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    1238:	movea.l (sp)+,a3
    123a:	movea.l (sp)+,a6
    123c:	rts

0000123e <BitmapInit>:

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{
    123e:	move.l d3,-(sp)
    1240:	move.l d2,-(sp)
    1242:	movea.l 12(sp),a0
    1246:	move.l 16(sp),d0
    124a:	move.l 20(sp),d2
    124e:	move.l 24(sp),d1

	bmp->Width = w;
    1252:	move.w d0,(a0)
	bmp->Height = h;
    1254:	move.w d2,2(a0)
	bmp->Bpls = bpls;
    1258:	move.w d1,4(a0)
	bmp->Bpl = w / 8;
    125c:	lsr.w #3,d0
    125e:	move.w d0,6(a0)
	bmp->Bplt = w / 8 * bpls;
    1262:	move.w d0,d3
    1264:	muls.w d1,d3
    1266:	move.w d3,8(a0)
	bmp->Btot = w / 8 * h * bpls;
    126a:	muls.w d2,d0
    126c:	muls.w d1,d0
    126e:	move.w d0,12(a0)
}
    1272:	move.l (sp)+,d2
    1274:	move.l (sp)+,d3
    1276:	rts

00001278 <InitStarfieldSprite>:

void InitStarfieldSprite()
{
    1278:	movem.l d2-d7/a2-a3,-(sp)
	short line = 0;
	USHORT hpos = 3;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 31; l++)
    127c:	moveq #0,d5
	BYTE vpos = 0x2c;
    127e:	moveq #44,d3
	USHORT hpos = 3;
    1280:	movea.w #3,a1
	short line = 0;
    1284:	clr.w d2
    1286:	bra.w 13c0 <InitStarfieldSprite+0x148>
	{
		hpos = (7 * hpos) % 255;
    128a:	moveq #0,d0
    128c:	move.w a1,d0
    128e:	move.l d0,d1
    1290:	lsl.l #3,d1
    1292:	lea 2848 <__modsi3>,a3
    1298:	pea ff <MoveBobs+0x73>
    129c:	sub.l d0,d1
    129e:	move.l d1,-(sp)
    12a0:	jsr (a3)
    12a2:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    12a4:	move.b d3,d1
    12a6:	ext.w d1
    12a8:	move.w d1,d4
    12aa:	ext.l d4
    12ac:	lsl.l #8,d4
    12ae:	move.w d0,d6
    12b0:	andi.w #255,d6
    12b4:	movea.w d2,a0
    12b6:	addq.w #1,a0
    12b8:	movea.w d2,a1
    12ba:	lea 2d692 <StarSprite>,a2
    12c0:	adda.l a1,a1
    12c2:	or.w d4,d6
    12c4:	move.w d6,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    12c8:	addq.w #1,d1
    12ca:	movea.w d2,a1
    12cc:	addq.w #2,a1
    12ce:	movea.w a0,a0
    12d0:	lsl.w #8,d1
    12d2:	adda.l a0,a0
    12d4:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-1
    12d8:	movea.w d2,a0
    12da:	addq.w #3,a0
    12dc:	movea.w a1,a1
    12de:	adda.l a1,a1
    12e0:	move.w #-32768,(0,a1,a2.l)
		StarSprite[line++] = 0x0000;					  //color-1
    12e6:	move.w d2,d6
    12e8:	addq.w #4,d6
    12ea:	movea.w a0,a0
    12ec:	adda.l a0,a0
    12ee:	clr.w (0,a0,a2.l)
		vpos += 2;
    12f2:	move.b d3,d4
    12f4:	addq.b #2,d4

		hpos = (7 * hpos) % 255;
    12f6:	andi.l #65535,d0
    12fc:	move.l d0,d1
    12fe:	lsl.l #3,d1
    1300:	pea ff <MoveBobs+0x73>
    1304:	sub.l d0,d1
    1306:	move.l d1,-(sp)
    1308:	jsr (a3)
    130a:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    130c:	move.b d4,d1
    130e:	ext.w d1
    1310:	move.w d1,d4
    1312:	ext.l d4
    1314:	lsl.l #8,d4
    1316:	move.w d0,d7
    1318:	andi.w #255,d7
    131c:	movea.w d2,a0
    131e:	addq.w #5,a0
    1320:	movea.w d6,a1
    1322:	adda.l a1,a1
    1324:	or.w d4,d7
    1326:	move.w d7,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    132a:	addq.w #1,d1
    132c:	movea.w d2,a1
    132e:	addq.w #6,a1
    1330:	movea.w a0,a0
    1332:	lsl.w #8,d1
    1334:	adda.l a0,a0
    1336:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x0000;					  //color-2
    133a:	movea.w d2,a0
    133c:	addq.w #7,a0
    133e:	movea.w a1,a1
    1340:	adda.l a1,a1
    1342:	clr.w (0,a1,a2.l)
		StarSprite[line++] = 0x8000;					  //color-2
    1346:	addq.w #4,d6
    1348:	movea.w a0,a0
    134a:	adda.l a0,a0
    134c:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    1352:	move.b d3,d4
    1354:	addq.b #4,d4

		hpos = (7 * hpos) % 255;
    1356:	andi.l #65535,d0
    135c:	move.l d0,d1
    135e:	lsl.l #3,d1
    1360:	pea ff <MoveBobs+0x73>
    1364:	sub.l d0,d1
    1366:	move.l d1,-(sp)
    1368:	jsr (a3)
    136a:	addq.l #8,sp
    136c:	movea.w d0,a1
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    136e:	move.b d4,d1
    1370:	ext.w d1
    1372:	move.w d1,d4
    1374:	ext.l d4
    1376:	lsl.l #8,d4
    1378:	andi.w #255,d0
    137c:	movea.w d2,a3
    137e:	lea 9(a3),a3
    1382:	movea.w d6,a0
    1384:	adda.l a0,a0
    1386:	or.w d4,d0
    1388:	move.w d0,(0,a2,a0.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    138c:	addq.w #1,d1
    138e:	movea.w d2,a0
    1390:	lea 10(a0),a0
    1394:	movea.w a3,a3
    1396:	lsl.w #8,d1
    1398:	adda.l a3,a3
    139a:	move.w d1,(0,a3,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    139e:	movea.w a0,a0
    13a0:	adda.l a0,a0
    13a2:	move.w #-32768,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    13a8:	movea.w d2,a0
    13aa:	lea 11(a0),a0
    13ae:	movea.w a0,a0
    13b0:	addi.w #12,d2
    13b4:	adda.l a0,a0
    13b6:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    13bc:	addq.b #6,d3
	for (int l = 0; l < 31; l++)
    13be:	addq.l #1,d5
    13c0:	moveq #30,d0
    13c2:	cmp.l d5,d0
    13c4:	bge.w 128a <InitStarfieldSprite+0x12>
	}
	// sprite end-mark
	StarSprite[line++] = 0;
    13c8:	move.w d2,d0
    13ca:	addq.w #1,d0
    13cc:	ext.l d2
    13ce:	lea 2d692 <StarSprite>,a1
    13d4:	add.l d2,d2
    13d6:	clr.w (0,a1,d2.l)
	StarSprite[line++] = 0;
    13da:	movea.w d0,a0
    13dc:	adda.l a0,a0
    13de:	clr.w (0,a0,a1.l)
}
    13e2:	movem.l (sp)+,d2-d7/a2-a3
    13e6:	rts

000013e8 <MoveStarfield>:

void MoveStarfield()
{
	for (int l = 1; l < 31 * 24; l += 24)
    13e8:	movea.w #1,a0
    13ec:	bra.s 141c <MoveStarfield+0x34>
	{
		((volatile UBYTE *)StarSprite)[l] += 1;
    13ee:	movea.l a0,a1
    13f0:	adda.l #186002,a1
    13f6:	move.b (a1),d0
    13f8:	addq.b #1,d0
    13fa:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 8] += 2;
    13fc:	movea.l a0,a1
    13fe:	adda.l #186010,a1
    1404:	move.b (a1),d0
    1406:	addq.b #2,d0
    1408:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 16] += 3;
    140a:	movea.l a0,a1
    140c:	adda.l #186018,a1
    1412:	move.b (a1),d0
    1414:	addq.b #3,d0
    1416:	move.b d0,(a1)
	for (int l = 1; l < 31 * 24; l += 24)
    1418:	lea 24(a0),a0
    141c:	cmpa.w #743,a0
    1420:	ble.s 13ee <MoveStarfield+0x6>
	}
}
    1422:	rts

00001424 <BuildLogo>:

void BuildLogo()
{
    1424:	move.l d3,-(sp)
    1426:	move.l d2,-(sp)
	Point2D ps;
	Point2D pd;

	if (LogoShowY1 <= 128)
    1428:	move.w 2d9b0 <LogoShowY1>,d0
    142e:	cmpi.w #128,d0
    1432:	ble.s 1448 <BuildLogo+0x24>
		pd.X = 32;
		pd.Y = LogoShowY1;
		SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 1, 256);
		LogoShowY1 += 2;
	}
	else if (LogoShowY2 <= 129)
    1434:	move.w 6a3c <LogoShowY2>,d0
    143a:	cmpi.w #129,d0
    143e:	ble.w 1514 <BuildLogo+0xf0>
		pd.X = 32;
		pd.Y = LogoShowY2;
		SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 1, 256);
		LogoShowY2 += 2;
	}
}
    1442:	move.l (sp)+,d2
    1444:	move.l (sp)+,d3
    1446:	rts
		ps.X = 0;
    1448:	clr.l d2
    144a:	clr.l d3
		ps.Y = LogoShowY1;
    144c:	movea.w d0,a0
		pd.X = 32;
    144e:	moveq #32,d0
    1450:	clr.l d1
		SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 1, 256);
    1452:	pea 100 <MoveBobs+0x74>
    1456:	pea 1 <_start+0x1>
    145a:	move.l a0,-(sp)
    145c:	move.l d0,-(sp)
    145e:	move.l a0,-(sp)
    1460:	move.l d2,-(sp)
    1462:	subq.l #2,sp
    1464:	move.l 2db12 <BmpUpperPart_PF1+0x2e>,-(sp)
    146a:	move.l 2db0e <BmpUpperPart_PF1+0x2a>,-(sp)
    1470:	move.l 2db0a <BmpUpperPart_PF1+0x26>,-(sp)
    1476:	move.l 2db06 <BmpUpperPart_PF1+0x22>,-(sp)
    147c:	move.l 2db02 <BmpUpperPart_PF1+0x1e>,-(sp)
    1482:	move.l 2dafe <BmpUpperPart_PF1+0x1a>,-(sp)
    1488:	move.l 2dafa <BmpUpperPart_PF1+0x16>,-(sp)
    148e:	move.l 2daf6 <BmpUpperPart_PF1+0x12>,-(sp)
    1494:	move.l 2daf2 <BmpUpperPart_PF1+0xe>,-(sp)
    149a:	move.l 2daee <BmpUpperPart_PF1+0xa>,-(sp)
    14a0:	move.l 2daea <BmpUpperPart_PF1+0x6>,-(sp)
    14a6:	move.l 2dae6 <BmpUpperPart_PF1+0x2>,-(sp)
    14ac:	move.w 2dae4 <BmpUpperPart_PF1>,-(sp)
    14b2:	subq.l #2,sp
    14b4:	move.l 2db44 <BmpLogo+0x2e>,-(sp)
    14ba:	move.l 2db40 <BmpLogo+0x2a>,-(sp)
    14c0:	move.l 2db3c <BmpLogo+0x26>,-(sp)
    14c6:	move.l 2db38 <BmpLogo+0x22>,-(sp)
    14cc:	move.l 2db34 <BmpLogo+0x1e>,-(sp)
    14d2:	move.l 2db30 <BmpLogo+0x1a>,-(sp)
    14d8:	move.l 2db2c <BmpLogo+0x16>,-(sp)
    14de:	move.l 2db28 <BmpLogo+0x12>,-(sp)
    14e4:	move.l 2db24 <BmpLogo+0xe>,-(sp)
    14ea:	move.l 2db20 <BmpLogo+0xa>,-(sp)
    14f0:	move.l 2db1c <BmpLogo+0x6>,-(sp)
    14f6:	move.l 2db18 <BmpLogo+0x2>,-(sp)
    14fc:	move.w 2db16 <BmpLogo>,-(sp)
    1502:	jsr f9c <SimpleBlit>(pc)
		LogoShowY1 += 2;
    1506:	addq.w #2,2d9b0 <LogoShowY1>
    150c:	lea 128(sp),sp
    1510:	bra.w 1442 <BuildLogo+0x1e>
		ps.X = 0;
    1514:	clr.l d2
    1516:	clr.l d3
		ps.Y = LogoShowY2;
    1518:	movea.w d0,a0
		pd.X = 32;
    151a:	moveq #32,d0
    151c:	clr.l d1
		SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 1, 256);
    151e:	pea 100 <MoveBobs+0x74>
    1522:	pea 1 <_start+0x1>
    1526:	move.l a0,-(sp)
    1528:	move.l d0,-(sp)
    152a:	move.l a0,-(sp)
    152c:	move.l d2,-(sp)
    152e:	subq.l #2,sp
    1530:	move.l 2db12 <BmpUpperPart_PF1+0x2e>,-(sp)
    1536:	move.l 2db0e <BmpUpperPart_PF1+0x2a>,-(sp)
    153c:	move.l 2db0a <BmpUpperPart_PF1+0x26>,-(sp)
    1542:	move.l 2db06 <BmpUpperPart_PF1+0x22>,-(sp)
    1548:	move.l 2db02 <BmpUpperPart_PF1+0x1e>,-(sp)
    154e:	move.l 2dafe <BmpUpperPart_PF1+0x1a>,-(sp)
    1554:	move.l 2dafa <BmpUpperPart_PF1+0x16>,-(sp)
    155a:	move.l 2daf6 <BmpUpperPart_PF1+0x12>,-(sp)
    1560:	move.l 2daf2 <BmpUpperPart_PF1+0xe>,-(sp)
    1566:	move.l 2daee <BmpUpperPart_PF1+0xa>,-(sp)
    156c:	move.l 2daea <BmpUpperPart_PF1+0x6>,-(sp)
    1572:	move.l 2dae6 <BmpUpperPart_PF1+0x2>,-(sp)
    1578:	move.w 2dae4 <BmpUpperPart_PF1>,-(sp)
    157e:	subq.l #2,sp
    1580:	move.l 2db44 <BmpLogo+0x2e>,-(sp)
    1586:	move.l 2db40 <BmpLogo+0x2a>,-(sp)
    158c:	move.l 2db3c <BmpLogo+0x26>,-(sp)
    1592:	move.l 2db38 <BmpLogo+0x22>,-(sp)
    1598:	move.l 2db34 <BmpLogo+0x1e>,-(sp)
    159e:	move.l 2db30 <BmpLogo+0x1a>,-(sp)
    15a4:	move.l 2db2c <BmpLogo+0x16>,-(sp)
    15aa:	move.l 2db28 <BmpLogo+0x12>,-(sp)
    15b0:	move.l 2db24 <BmpLogo+0xe>,-(sp)
    15b6:	move.l 2db20 <BmpLogo+0xa>,-(sp)
    15bc:	move.l 2db1c <BmpLogo+0x6>,-(sp)
    15c2:	move.l 2db18 <BmpLogo+0x2>,-(sp)
    15c8:	move.w 2db16 <BmpLogo>,-(sp)
    15ce:	jsr f9c <SimpleBlit>(pc)
		LogoShowY2 += 2;
    15d2:	addq.w #2,6a3c <LogoShowY2>
    15d8:	lea 128(sp),sp
    15dc:	bra.w 1442 <BuildLogo+0x1e>

000015e0 <DissolveLogo>:

void DissolveLogo()
{
	if (LogoShowY1 >= 0)
    15e0:	move.w 2d9b0 <LogoShowY1>,d0
    15e6:	bpl.s 1662 <DissolveLogo+0x82>
	{
		ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
		LogoShowY1 -= 2;
	}
	else if (LogoShowY2 >= 1)
    15e8:	move.w 6a3c <LogoShowY2>,d0
    15ee:	ble.w 16d0 <DissolveLogo+0xf0>
	{
		ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    15f2:	pea 100 <MoveBobs+0x74>
    15f6:	pea 1 <_start+0x1>
    15fa:	movea.w d0,a0
    15fc:	move.l a0,-(sp)
    15fe:	pea 20 <_start+0x20>
    1602:	subq.l #2,sp
    1604:	move.l 2db12 <BmpUpperPart_PF1+0x2e>,-(sp)
    160a:	move.l 2db0e <BmpUpperPart_PF1+0x2a>,-(sp)
    1610:	move.l 2db0a <BmpUpperPart_PF1+0x26>,-(sp)
    1616:	move.l 2db06 <BmpUpperPart_PF1+0x22>,-(sp)
    161c:	move.l 2db02 <BmpUpperPart_PF1+0x1e>,-(sp)
    1622:	move.l 2dafe <BmpUpperPart_PF1+0x1a>,-(sp)
    1628:	move.l 2dafa <BmpUpperPart_PF1+0x16>,-(sp)
    162e:	move.l 2daf6 <BmpUpperPart_PF1+0x12>,-(sp)
    1634:	move.l 2daf2 <BmpUpperPart_PF1+0xe>,-(sp)
    163a:	move.l 2daee <BmpUpperPart_PF1+0xa>,-(sp)
    1640:	move.l 2daea <BmpUpperPart_PF1+0x6>,-(sp)
    1646:	move.l 2dae6 <BmpUpperPart_PF1+0x2>,-(sp)
    164c:	move.w 2dae4 <BmpUpperPart_PF1>,-(sp)
    1652:	jsr eb8 <ClearBitmapPart>(pc)
		LogoShowY2 -= 2;
    1656:	subq.w #2,6a3c <LogoShowY2>
    165c:	lea 68(sp),sp
    1660:	bra.s 16d0 <DissolveLogo+0xf0>
		ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    1662:	pea 100 <MoveBobs+0x74>
    1666:	pea 1 <_start+0x1>
    166a:	movea.w d0,a0
    166c:	move.l a0,-(sp)
    166e:	pea 20 <_start+0x20>
    1672:	subq.l #2,sp
    1674:	move.l 2db12 <BmpUpperPart_PF1+0x2e>,-(sp)
    167a:	move.l 2db0e <BmpUpperPart_PF1+0x2a>,-(sp)
    1680:	move.l 2db0a <BmpUpperPart_PF1+0x26>,-(sp)
    1686:	move.l 2db06 <BmpUpperPart_PF1+0x22>,-(sp)
    168c:	move.l 2db02 <BmpUpperPart_PF1+0x1e>,-(sp)
    1692:	move.l 2dafe <BmpUpperPart_PF1+0x1a>,-(sp)
    1698:	move.l 2dafa <BmpUpperPart_PF1+0x16>,-(sp)
    169e:	move.l 2daf6 <BmpUpperPart_PF1+0x12>,-(sp)
    16a4:	move.l 2daf2 <BmpUpperPart_PF1+0xe>,-(sp)
    16aa:	move.l 2daee <BmpUpperPart_PF1+0xa>,-(sp)
    16b0:	move.l 2daea <BmpUpperPart_PF1+0x6>,-(sp)
    16b6:	move.l 2dae6 <BmpUpperPart_PF1+0x2>,-(sp)
    16bc:	move.w 2dae4 <BmpUpperPart_PF1>,-(sp)
    16c2:	jsr eb8 <ClearBitmapPart>(pc)
		LogoShowY1 -= 2;
    16c6:	subq.w #2,2d9b0 <LogoShowY1>
    16cc:	lea 68(sp),sp
	}
    16d0:	rts

000016d2 <MainLoop>:
{
    16d2:	movem.l d2-d4/a2-a5,-(sp)
	while (!MouseLeft())
    16d6:	bra.w 216a <MainLoop+0xa98>
		else if (LogoShowPhase == 0 && LogoShowPause == 0)
    16da:	move.b 2d9b2 <LogoShowPhase>,d0
    16e0:	beq.s 1722 <MainLoop+0x50>
		else if (LogoShowPhase == 1 && LogoShowPause == 0)
    16e2:	cmpi.b #1,d0
    16e6:	bne.w 218e <MainLoop+0xabc>
			DissolveLogo();
    16ea:	jsr 15e0 <DissolveLogo>(pc)
			if (LogoShowY1 < 0 && LogoShowY2 < 1)
    16ee:	tst.w 2d9b0 <LogoShowY1>
    16f4:	bge.w 218e <MainLoop+0xabc>
    16f8:	tst.w 6a3c <LogoShowY2>
    16fe:	bgt.w 218e <MainLoop+0xabc>
				LogoShowY1 = 0;
    1702:	clr.w 2d9b0 <LogoShowY1>
				LogoShowY2 = 1;
    1708:	move.w #1,6a3c <LogoShowY2>
				LogoShowPhase = 0;
    1710:	clr.b 2d9b2 <LogoShowPhase>
				LogoShowPause = 2 * 50;
    1716:	move.w #100,6a3e <LogoShowPause>
    171e:	bra.w 218e <MainLoop+0xabc>
			BuildLogo();
    1722:	jsr 1424 <BuildLogo>(pc)
			if (LogoShowY1 > 128 && LogoShowY2 > 129)
    1726:	cmpi.w #128,2d9b0 <LogoShowY1>
    172e:	ble.w 218e <MainLoop+0xabc>
    1732:	cmpi.w #129,6a3c <LogoShowY2>
    173a:	ble.w 218e <MainLoop+0xabc>
				LogoShowY1 = 128;
    173e:	move.w #128,2d9b0 <LogoShowY1>
				LogoShowY2 = 129;
    1746:	move.w #129,6a3c <LogoShowY2>
				LogoShowPhase = 1;
    174e:	move.b #1,2d9b2 <LogoShowPhase>
				LogoShowPause = 4 * 50;
    1756:	move.w #200,6a3e <LogoShowPause>
    175e:	bra.w 218e <MainLoop+0xabc>
			SetupCopper(copPtr);
    1762:	move.l 2d9b4 <copPtr>,-(sp)
    1768:	jsr 242 <SetupCopper>(pc)
			custom->cop1lc = (ULONG)copPtr;
    176c:	movea.l 2db88 <custom>,a0
    1772:	move.l 2d9b4 <copPtr>,128(a0)
			custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    177a:	move.w #64,150(a0)
			custom->copjmp1 = 0x7fff;	   //start coppper
    1780:	move.w #32767,136(a0)
			custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    1786:	move.w #-30752,150(a0)
			ResetCopper = FALSE;
    178c:	clr.w 2d9ae <ResetCopper>
    1792:	addq.l #4,sp
    1794:	bra.w 2198 <MainLoop+0xac6>
					ScrollerDir = 1;
    1798:	move.b #1,6a3a <ScrollerDir>
    17a0:	bra.w 228a <MainLoop+0xbb8>
				if (ScrollerDir > -5)
    17a4:	cmpi.b #-4,d0
    17a8:	blt.w 228a <MainLoop+0xbb8>
					ScrollerDir--;
    17ac:	subq.b #1,d0
    17ae:	move.b d0,6a3a <ScrollerDir>
    17b4:	bra.w 228a <MainLoop+0xbb8>
			if (ScrollerPause > 0)
    17b8:	move.w 2d9a8 <ScrollerPause>,d0
    17be:	beq.w 2298 <MainLoop+0xbc6>
				ScrollerPause--;
    17c2:	subq.w #1,d0
    17c4:	move.w d0,2d9a8 <ScrollerPause>
    17ca:	bra.w 2298 <MainLoop+0xbc6>
		else if (ScrollerY <= ScrollerMin)
    17ce:	cmpa.w #0,a0
    17d2:	bgt.w 22b4 <MainLoop+0xbe2>
			ScrollerY = ScrollerMin;
    17d6:	clr.w 2d9aa <ScrollerY>
			ScrollerDir = 1;
    17dc:	move.b #1,6a3a <ScrollerDir>
			if (ScrollerPause > 0)
    17e4:	move.w 2d9a8 <ScrollerPause>,d0
    17ea:	beq.w 22b4 <MainLoop+0xbe2>
				ScrollerPause--;
    17ee:	subq.w #1,d0
    17f0:	move.w d0,2d9a8 <ScrollerPause>
    17f6:	bra.w 22b4 <MainLoop+0xbe2>
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    17fa:	pea 4 <_start+0x4>
    17fe:	pea 20 <_start+0x20>
    1802:	pea 28 <_start+0x28>
    1806:	move.l 2da5c <BmpScroller+0xe>,-(sp)
    180c:	subq.l #2,sp
    180e:	move.l 2da7c <BmpScroller+0x2e>,-(sp)
    1814:	move.l 2da78 <BmpScroller+0x2a>,-(sp)
    181a:	move.l 2da74 <BmpScroller+0x26>,-(sp)
    1820:	move.l 2da70 <BmpScroller+0x22>,-(sp)
    1826:	move.l 2da6c <BmpScroller+0x1e>,-(sp)
    182c:	move.l 2da68 <BmpScroller+0x1a>,-(sp)
    1832:	move.l 2da64 <BmpScroller+0x16>,-(sp)
    1838:	move.l 2da60 <BmpScroller+0x12>,-(sp)
    183e:	move.l 2da5c <BmpScroller+0xe>,-(sp)
    1844:	move.l 2da58 <BmpScroller+0xa>,-(sp)
    184a:	move.l 2da54 <BmpScroller+0x6>,-(sp)
    1850:	move.l 2da50 <BmpScroller+0x2>,-(sp)
    1856:	move.w 2da4e <BmpScroller>,-(sp)
    185c:	jsr a78 <Scrollit>(pc)
    1860:	lea 68(sp),sp
    1864:	bra.w 22be <MainLoop+0xbec>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
    1868:	moveq #56,d2
    186a:	add.l d2,d1
    186c:	add.w d1,d1
    186e:	add.w d1,d1
    1870:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    1872:	move.l d0,d2
    1874:	clr.w d2
    1876:	swap d2
    1878:	move.w d2,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
    187c:	addq.w #2,d1
    187e:	move.w d1,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    1882:	move.w d0,6(a2)
        addr += Bpl;
    1886:	add.l d4,d0
    for (USHORT i = 0; i < numPlanes; i++)
    1888:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
    188a:	addq.l #8,a2
    for (USHORT i = 0; i < numPlanes; i++)
    188c:	moveq #0,d1
    188e:	move.w a0,d1
    1890:	cmp.l d3,d1
    1892:	blt.s 1868 <MainLoop+0x196>
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[0].X, BobTarget[0].Y, 32, 32);
    1894:	pea 20 <_start+0x20>
    1898:	pea 20 <_start+0x20>
    189c:	move.l 6a0e <BobTarget+0x4>,-(sp)
    18a2:	move.l 6a0a <BobTarget>,-(sp)
    18a8:	subq.l #2,sp
    18aa:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    18b0:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    18b6:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    18bc:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    18c2:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    18c8:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    18ce:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    18d4:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    18da:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    18e0:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    18e6:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    18ec:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    18f2:	lea 2da80 <BmpUpperPart_Buf1>,a3
    18f8:	move.w (a3),-(sp)
    18fa:	lea eb8 <ClearBitmapPart>(pc),a2
    18fe:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[1].X, BobTarget[1].Y, 32, 32);
    1900:	lea 68(sp),sp
    1904:	pea 20 <_start+0x20>
    1908:	pea 20 <_start+0x20>
    190c:	move.l 6a16 <BobTarget+0xc>,-(sp)
    1912:	move.l 6a12 <BobTarget+0x8>,-(sp)
    1918:	subq.l #2,sp
    191a:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    1920:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    1926:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    192c:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    1932:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    1938:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    193e:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    1944:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    194a:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    1950:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    1956:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    195c:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    1962:	move.w (a3),-(sp)
    1964:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[2].X, BobTarget[2].Y, 32, 32);
    1966:	lea 68(sp),sp
    196a:	pea 20 <_start+0x20>
    196e:	pea 20 <_start+0x20>
    1972:	move.l 6a1e <BobTarget+0x14>,-(sp)
    1978:	move.l 6a1a <BobTarget+0x10>,-(sp)
    197e:	subq.l #2,sp
    1980:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    1986:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    198c:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    1992:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    1998:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    199e:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    19a4:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    19aa:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    19b0:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    19b6:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    19bc:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    19c2:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    19c8:	move.w (a3),-(sp)
    19ca:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[3].X, BobTarget[3].Y, 32, 32);
    19cc:	lea 68(sp),sp
    19d0:	pea 20 <_start+0x20>
    19d4:	pea 20 <_start+0x20>
    19d8:	move.l 6a26 <BobTarget+0x1c>,-(sp)
    19de:	move.l 6a22 <BobTarget+0x18>,-(sp)
    19e4:	subq.l #2,sp
    19e6:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    19ec:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    19f2:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    19f8:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    19fe:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    1a04:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    1a0a:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    1a10:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    1a16:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    1a1c:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    1a22:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    1a28:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    1a2e:	move.w (a3),-(sp)
    1a30:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[4].X, BobTarget[4].Y, 32, 32);
    1a32:	lea 68(sp),sp
    1a36:	pea 20 <_start+0x20>
    1a3a:	pea 20 <_start+0x20>
    1a3e:	move.l 6a2e <BobTarget+0x24>,-(sp)
    1a44:	move.l 6a2a <BobTarget+0x20>,-(sp)
    1a4a:	subq.l #2,sp
    1a4c:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    1a52:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    1a58:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    1a5e:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    1a64:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    1a6a:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    1a70:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    1a76:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    1a7c:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    1a82:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    1a88:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    1a8e:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    1a94:	move.w (a3),-(sp)
    1a96:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[5].X, BobTarget[5].Y, 32, 32);
    1a98:	lea 68(sp),sp
    1a9c:	pea 20 <_start+0x20>
    1aa0:	pea 20 <_start+0x20>
    1aa4:	move.l 6a36 <BobTarget+0x2c>,-(sp)
    1aaa:	move.l 6a32 <BobTarget+0x28>,-(sp)
    1ab0:	subq.l #2,sp
    1ab2:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    1ab8:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    1abe:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    1ac4:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    1aca:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    1ad0:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    1ad6:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    1adc:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    1ae2:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    1ae8:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    1aee:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    1af4:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    1afa:	move.w (a3),-(sp)
    1afc:	jsr (a2)
		if (BobPause > 0)
    1afe:	move.w 2d9a2 <BobPause>,d0
    1b04:	lea 68(sp),sp
    1b08:	beq.w 22fc <MainLoop+0xc2a>
			BobPause--;
    1b0c:	subq.w #1,d0
    1b0e:	move.w d0,2d9a2 <BobPause>
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[0], BobTarget[0], 32, 32);
    1b14:	pea 20 <_start+0x20>
    1b18:	pea 20 <_start+0x20>
    1b1c:	move.l 6a0e <BobTarget+0x4>,-(sp)
    1b22:	move.l 6a0a <BobTarget>,-(sp)
    1b28:	move.l 49a6 <BobSource+0x4>,-(sp)
    1b2e:	move.l 49a2 <BobSource>,-(sp)
    1b34:	subq.l #2,sp
    1b36:	move.l 2d9e6 <BmpCookieMask+0x2e>,-(sp)
    1b3c:	move.l 2d9e2 <BmpCookieMask+0x2a>,-(sp)
    1b42:	move.l 2d9de <BmpCookieMask+0x26>,-(sp)
    1b48:	move.l 2d9da <BmpCookieMask+0x22>,-(sp)
    1b4e:	move.l 2d9d6 <BmpCookieMask+0x1e>,-(sp)
    1b54:	move.l 2d9d2 <BmpCookieMask+0x1a>,-(sp)
    1b5a:	move.l 2d9ce <BmpCookieMask+0x16>,-(sp)
    1b60:	move.l 2d9ca <BmpCookieMask+0x12>,-(sp)
    1b66:	move.l 2d9c6 <BmpCookieMask+0xe>,-(sp)
    1b6c:	move.l 2d9c2 <BmpCookieMask+0xa>,-(sp)
    1b72:	move.l 2d9be <BmpCookieMask+0x6>,-(sp)
    1b78:	move.l 2d9ba <BmpCookieMask+0x2>,-(sp)
    1b7e:	lea 2d9b8 <BmpCookieMask>,a5
    1b84:	move.w (a5),-(sp)
    1b86:	subq.l #2,sp
    1b88:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    1b8e:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    1b94:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    1b9a:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    1ba0:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    1ba6:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    1bac:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    1bb2:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    1bb8:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    1bbe:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    1bc4:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    1bca:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    1bd0:	lea 2da80 <BmpUpperPart_Buf1>,a4
    1bd6:	move.w (a4),-(sp)
    1bd8:	subq.l #2,sp
    1bda:	move.l 2da18 <BmpCookie+0x2e>,-(sp)
    1be0:	move.l 2da14 <BmpCookie+0x2a>,-(sp)
    1be6:	move.l 2da10 <BmpCookie+0x26>,-(sp)
    1bec:	move.l 2da0c <BmpCookie+0x22>,-(sp)
    1bf2:	move.l 2da08 <BmpCookie+0x1e>,-(sp)
    1bf8:	move.l 2da04 <BmpCookie+0x1a>,-(sp)
    1bfe:	move.l 2da00 <BmpCookie+0x16>,-(sp)
    1c04:	move.l 2d9fc <BmpCookie+0x12>,-(sp)
    1c0a:	move.l 2d9f8 <BmpCookie+0xe>,-(sp)
    1c10:	move.l 2d9f4 <BmpCookie+0xa>,-(sp)
    1c16:	move.l 2d9f0 <BmpCookie+0x6>,-(sp)
    1c1c:	move.l 2d9ec <BmpCookie+0x2>,-(sp)
    1c22:	lea 2d9ea <BmpCookie>,a3
    1c28:	move.w (a3),-(sp)
    1c2a:	lea 1060 <BetterBlit>(pc),a2
    1c2e:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[1], BobTarget[1], 32, 32);
    1c30:	lea 180(sp),sp
    1c34:	pea 20 <_start+0x20>
    1c38:	pea 20 <_start+0x20>
    1c3c:	move.l 6a16 <BobTarget+0xc>,-(sp)
    1c42:	move.l 6a12 <BobTarget+0x8>,-(sp)
    1c48:	move.l 49ae <BobSource+0xc>,-(sp)
    1c4e:	move.l 49aa <BobSource+0x8>,-(sp)
    1c54:	subq.l #2,sp
    1c56:	move.l 2d9e6 <BmpCookieMask+0x2e>,-(sp)
    1c5c:	move.l 2d9e2 <BmpCookieMask+0x2a>,-(sp)
    1c62:	move.l 2d9de <BmpCookieMask+0x26>,-(sp)
    1c68:	move.l 2d9da <BmpCookieMask+0x22>,-(sp)
    1c6e:	move.l 2d9d6 <BmpCookieMask+0x1e>,-(sp)
    1c74:	move.l 2d9d2 <BmpCookieMask+0x1a>,-(sp)
    1c7a:	move.l 2d9ce <BmpCookieMask+0x16>,-(sp)
    1c80:	move.l 2d9ca <BmpCookieMask+0x12>,-(sp)
    1c86:	move.l 2d9c6 <BmpCookieMask+0xe>,-(sp)
    1c8c:	move.l 2d9c2 <BmpCookieMask+0xa>,-(sp)
    1c92:	move.l 2d9be <BmpCookieMask+0x6>,-(sp)
    1c98:	move.l 2d9ba <BmpCookieMask+0x2>,-(sp)
    1c9e:	move.w (a5),-(sp)
    1ca0:	subq.l #2,sp
    1ca2:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    1ca8:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    1cae:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    1cb4:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    1cba:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    1cc0:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    1cc6:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    1ccc:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    1cd2:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    1cd8:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    1cde:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    1ce4:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    1cea:	move.w (a4),-(sp)
    1cec:	subq.l #2,sp
    1cee:	move.l 2da18 <BmpCookie+0x2e>,-(sp)
    1cf4:	move.l 2da14 <BmpCookie+0x2a>,-(sp)
    1cfa:	move.l 2da10 <BmpCookie+0x26>,-(sp)
    1d00:	move.l 2da0c <BmpCookie+0x22>,-(sp)
    1d06:	move.l 2da08 <BmpCookie+0x1e>,-(sp)
    1d0c:	move.l 2da04 <BmpCookie+0x1a>,-(sp)
    1d12:	move.l 2da00 <BmpCookie+0x16>,-(sp)
    1d18:	move.l 2d9fc <BmpCookie+0x12>,-(sp)
    1d1e:	move.l 2d9f8 <BmpCookie+0xe>,-(sp)
    1d24:	move.l 2d9f4 <BmpCookie+0xa>,-(sp)
    1d2a:	move.l 2d9f0 <BmpCookie+0x6>,-(sp)
    1d30:	move.l 2d9ec <BmpCookie+0x2>,-(sp)
    1d36:	move.w (a3),-(sp)
    1d38:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[2], BobTarget[2], 32, 32);
    1d3a:	lea 180(sp),sp
    1d3e:	pea 20 <_start+0x20>
    1d42:	pea 20 <_start+0x20>
    1d46:	move.l 6a1e <BobTarget+0x14>,-(sp)
    1d4c:	move.l 6a1a <BobTarget+0x10>,-(sp)
    1d52:	move.l 49b6 <BobSource+0x14>,-(sp)
    1d58:	move.l 49b2 <BobSource+0x10>,-(sp)
    1d5e:	subq.l #2,sp
    1d60:	move.l 2d9e6 <BmpCookieMask+0x2e>,-(sp)
    1d66:	move.l 2d9e2 <BmpCookieMask+0x2a>,-(sp)
    1d6c:	move.l 2d9de <BmpCookieMask+0x26>,-(sp)
    1d72:	move.l 2d9da <BmpCookieMask+0x22>,-(sp)
    1d78:	move.l 2d9d6 <BmpCookieMask+0x1e>,-(sp)
    1d7e:	move.l 2d9d2 <BmpCookieMask+0x1a>,-(sp)
    1d84:	move.l 2d9ce <BmpCookieMask+0x16>,-(sp)
    1d8a:	move.l 2d9ca <BmpCookieMask+0x12>,-(sp)
    1d90:	move.l 2d9c6 <BmpCookieMask+0xe>,-(sp)
    1d96:	move.l 2d9c2 <BmpCookieMask+0xa>,-(sp)
    1d9c:	move.l 2d9be <BmpCookieMask+0x6>,-(sp)
    1da2:	move.l 2d9ba <BmpCookieMask+0x2>,-(sp)
    1da8:	move.w (a5),-(sp)
    1daa:	subq.l #2,sp
    1dac:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    1db2:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    1db8:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    1dbe:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    1dc4:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    1dca:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    1dd0:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    1dd6:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    1ddc:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    1de2:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    1de8:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    1dee:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    1df4:	move.w (a4),-(sp)
    1df6:	subq.l #2,sp
    1df8:	move.l 2da18 <BmpCookie+0x2e>,-(sp)
    1dfe:	move.l 2da14 <BmpCookie+0x2a>,-(sp)
    1e04:	move.l 2da10 <BmpCookie+0x26>,-(sp)
    1e0a:	move.l 2da0c <BmpCookie+0x22>,-(sp)
    1e10:	move.l 2da08 <BmpCookie+0x1e>,-(sp)
    1e16:	move.l 2da04 <BmpCookie+0x1a>,-(sp)
    1e1c:	move.l 2da00 <BmpCookie+0x16>,-(sp)
    1e22:	move.l 2d9fc <BmpCookie+0x12>,-(sp)
    1e28:	move.l 2d9f8 <BmpCookie+0xe>,-(sp)
    1e2e:	move.l 2d9f4 <BmpCookie+0xa>,-(sp)
    1e34:	move.l 2d9f0 <BmpCookie+0x6>,-(sp)
    1e3a:	move.l 2d9ec <BmpCookie+0x2>,-(sp)
    1e40:	move.w (a3),-(sp)
    1e42:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[3], BobTarget[3], 32, 32);
    1e44:	lea 180(sp),sp
    1e48:	pea 20 <_start+0x20>
    1e4c:	pea 20 <_start+0x20>
    1e50:	move.l 6a26 <BobTarget+0x1c>,-(sp)
    1e56:	move.l 6a22 <BobTarget+0x18>,-(sp)
    1e5c:	move.l 49be <BobSource+0x1c>,-(sp)
    1e62:	move.l 49ba <BobSource+0x18>,-(sp)
    1e68:	subq.l #2,sp
    1e6a:	move.l 2d9e6 <BmpCookieMask+0x2e>,-(sp)
    1e70:	move.l 2d9e2 <BmpCookieMask+0x2a>,-(sp)
    1e76:	move.l 2d9de <BmpCookieMask+0x26>,-(sp)
    1e7c:	move.l 2d9da <BmpCookieMask+0x22>,-(sp)
    1e82:	move.l 2d9d6 <BmpCookieMask+0x1e>,-(sp)
    1e88:	move.l 2d9d2 <BmpCookieMask+0x1a>,-(sp)
    1e8e:	move.l 2d9ce <BmpCookieMask+0x16>,-(sp)
    1e94:	move.l 2d9ca <BmpCookieMask+0x12>,-(sp)
    1e9a:	move.l 2d9c6 <BmpCookieMask+0xe>,-(sp)
    1ea0:	move.l 2d9c2 <BmpCookieMask+0xa>,-(sp)
    1ea6:	move.l 2d9be <BmpCookieMask+0x6>,-(sp)
    1eac:	move.l 2d9ba <BmpCookieMask+0x2>,-(sp)
    1eb2:	move.w (a5),-(sp)
    1eb4:	subq.l #2,sp
    1eb6:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    1ebc:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    1ec2:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    1ec8:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    1ece:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    1ed4:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    1eda:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    1ee0:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    1ee6:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    1eec:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    1ef2:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    1ef8:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    1efe:	move.w (a4),-(sp)
    1f00:	subq.l #2,sp
    1f02:	move.l 2da18 <BmpCookie+0x2e>,-(sp)
    1f08:	move.l 2da14 <BmpCookie+0x2a>,-(sp)
    1f0e:	move.l 2da10 <BmpCookie+0x26>,-(sp)
    1f14:	move.l 2da0c <BmpCookie+0x22>,-(sp)
    1f1a:	move.l 2da08 <BmpCookie+0x1e>,-(sp)
    1f20:	move.l 2da04 <BmpCookie+0x1a>,-(sp)
    1f26:	move.l 2da00 <BmpCookie+0x16>,-(sp)
    1f2c:	move.l 2d9fc <BmpCookie+0x12>,-(sp)
    1f32:	move.l 2d9f8 <BmpCookie+0xe>,-(sp)
    1f38:	move.l 2d9f4 <BmpCookie+0xa>,-(sp)
    1f3e:	move.l 2d9f0 <BmpCookie+0x6>,-(sp)
    1f44:	move.l 2d9ec <BmpCookie+0x2>,-(sp)
    1f4a:	move.w (a3),-(sp)
    1f4c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[4], BobTarget[4], 32, 32);
    1f4e:	lea 180(sp),sp
    1f52:	pea 20 <_start+0x20>
    1f56:	pea 20 <_start+0x20>
    1f5a:	move.l 6a2e <BobTarget+0x24>,-(sp)
    1f60:	move.l 6a2a <BobTarget+0x20>,-(sp)
    1f66:	move.l 49c6 <BobSource+0x24>,-(sp)
    1f6c:	move.l 49c2 <BobSource+0x20>,-(sp)
    1f72:	subq.l #2,sp
    1f74:	move.l 2d9e6 <BmpCookieMask+0x2e>,-(sp)
    1f7a:	move.l 2d9e2 <BmpCookieMask+0x2a>,-(sp)
    1f80:	move.l 2d9de <BmpCookieMask+0x26>,-(sp)
    1f86:	move.l 2d9da <BmpCookieMask+0x22>,-(sp)
    1f8c:	move.l 2d9d6 <BmpCookieMask+0x1e>,-(sp)
    1f92:	move.l 2d9d2 <BmpCookieMask+0x1a>,-(sp)
    1f98:	move.l 2d9ce <BmpCookieMask+0x16>,-(sp)
    1f9e:	move.l 2d9ca <BmpCookieMask+0x12>,-(sp)
    1fa4:	move.l 2d9c6 <BmpCookieMask+0xe>,-(sp)
    1faa:	move.l 2d9c2 <BmpCookieMask+0xa>,-(sp)
    1fb0:	move.l 2d9be <BmpCookieMask+0x6>,-(sp)
    1fb6:	move.l 2d9ba <BmpCookieMask+0x2>,-(sp)
    1fbc:	move.w (a5),-(sp)
    1fbe:	subq.l #2,sp
    1fc0:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    1fc6:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    1fcc:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    1fd2:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    1fd8:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    1fde:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    1fe4:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    1fea:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    1ff0:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    1ff6:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    1ffc:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    2002:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    2008:	move.w (a4),-(sp)
    200a:	subq.l #2,sp
    200c:	move.l 2da18 <BmpCookie+0x2e>,-(sp)
    2012:	move.l 2da14 <BmpCookie+0x2a>,-(sp)
    2018:	move.l 2da10 <BmpCookie+0x26>,-(sp)
    201e:	move.l 2da0c <BmpCookie+0x22>,-(sp)
    2024:	move.l 2da08 <BmpCookie+0x1e>,-(sp)
    202a:	move.l 2da04 <BmpCookie+0x1a>,-(sp)
    2030:	move.l 2da00 <BmpCookie+0x16>,-(sp)
    2036:	move.l 2d9fc <BmpCookie+0x12>,-(sp)
    203c:	move.l 2d9f8 <BmpCookie+0xe>,-(sp)
    2042:	move.l 2d9f4 <BmpCookie+0xa>,-(sp)
    2048:	move.l 2d9f0 <BmpCookie+0x6>,-(sp)
    204e:	move.l 2d9ec <BmpCookie+0x2>,-(sp)
    2054:	move.w (a3),-(sp)
    2056:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[5], BobTarget[5], 32, 32);
    2058:	lea 180(sp),sp
    205c:	pea 20 <_start+0x20>
    2060:	pea 20 <_start+0x20>
    2064:	move.l 6a36 <BobTarget+0x2c>,-(sp)
    206a:	move.l 6a32 <BobTarget+0x28>,-(sp)
    2070:	move.l 49ce <BobSource+0x2c>,-(sp)
    2076:	move.l 49ca <BobSource+0x28>,-(sp)
    207c:	subq.l #2,sp
    207e:	move.l 2d9e6 <BmpCookieMask+0x2e>,-(sp)
    2084:	move.l 2d9e2 <BmpCookieMask+0x2a>,-(sp)
    208a:	move.l 2d9de <BmpCookieMask+0x26>,-(sp)
    2090:	move.l 2d9da <BmpCookieMask+0x22>,-(sp)
    2096:	move.l 2d9d6 <BmpCookieMask+0x1e>,-(sp)
    209c:	move.l 2d9d2 <BmpCookieMask+0x1a>,-(sp)
    20a2:	move.l 2d9ce <BmpCookieMask+0x16>,-(sp)
    20a8:	move.l 2d9ca <BmpCookieMask+0x12>,-(sp)
    20ae:	move.l 2d9c6 <BmpCookieMask+0xe>,-(sp)
    20b4:	move.l 2d9c2 <BmpCookieMask+0xa>,-(sp)
    20ba:	move.l 2d9be <BmpCookieMask+0x6>,-(sp)
    20c0:	move.l 2d9ba <BmpCookieMask+0x2>,-(sp)
    20c6:	move.w (a5),-(sp)
    20c8:	subq.l #2,sp
    20ca:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    20d0:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    20d6:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    20dc:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    20e2:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    20e8:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    20ee:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    20f4:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    20fa:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    2100:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    2106:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    210c:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    2112:	move.w (a4),-(sp)
    2114:	subq.l #2,sp
    2116:	move.l 2da18 <BmpCookie+0x2e>,-(sp)
    211c:	move.l 2da14 <BmpCookie+0x2a>,-(sp)
    2122:	move.l 2da10 <BmpCookie+0x26>,-(sp)
    2128:	move.l 2da0c <BmpCookie+0x22>,-(sp)
    212e:	move.l 2da08 <BmpCookie+0x1e>,-(sp)
    2134:	move.l 2da04 <BmpCookie+0x1a>,-(sp)
    213a:	move.l 2da00 <BmpCookie+0x16>,-(sp)
    2140:	move.l 2d9fc <BmpCookie+0x12>,-(sp)
    2146:	move.l 2d9f8 <BmpCookie+0xe>,-(sp)
    214c:	move.l 2d9f4 <BmpCookie+0xa>,-(sp)
    2152:	move.l 2d9f0 <BmpCookie+0x6>,-(sp)
    2158:	move.l 2d9ec <BmpCookie+0x2>,-(sp)
    215e:	move.w (a3),-(sp)
    2160:	jsr (a2)
		MoveStarfield();
    2162:	lea 180(sp),sp
    2166:	jsr 13e8 <MoveStarfield>(pc)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    216a:	move.b bfe001 <_end+0xbd0475>,d0
	while (!MouseLeft())
    2170:	btst #6,d0
    2174:	beq.w 2304 <MainLoop+0xc32>
		WaitVbl();
    2178:	jsr c40 <WaitVbl>(pc)
		if (LogoShowPause > 0)
    217c:	move.w 6a3e <LogoShowPause>,d0
    2182:	beq.w 16da <MainLoop+0x8>
			LogoShowPause--;
    2186:	subq.w #1,d0
    2188:	move.w d0,6a3e <LogoShowPause>
		if (ResetCopper)
    218e:	tst.w 2d9ae <ResetCopper>
    2194:	bne.w 1762 <MainLoop+0x90>
		CopyBitmap(BmpUpperPart_Buf1, BmpUpperPart_PF2);
    2198:	subq.l #2,sp
    219a:	move.l 2dae0 <BmpUpperPart_PF2+0x2e>,-(sp)
    21a0:	move.l 2dadc <BmpUpperPart_PF2+0x2a>,-(sp)
    21a6:	move.l 2dad8 <BmpUpperPart_PF2+0x26>,-(sp)
    21ac:	move.l 2dad4 <BmpUpperPart_PF2+0x22>,-(sp)
    21b2:	move.l 2dad0 <BmpUpperPart_PF2+0x1e>,-(sp)
    21b8:	move.l 2dacc <BmpUpperPart_PF2+0x1a>,-(sp)
    21be:	move.l 2dac8 <BmpUpperPart_PF2+0x16>,-(sp)
    21c4:	move.l 2dac4 <BmpUpperPart_PF2+0x12>,-(sp)
    21ca:	move.l 2dac0 <BmpUpperPart_PF2+0xe>,-(sp)
    21d0:	move.l 2dabc <BmpUpperPart_PF2+0xa>,-(sp)
    21d6:	move.l 2dab8 <BmpUpperPart_PF2+0x6>,-(sp)
    21dc:	move.l 2dab4 <BmpUpperPart_PF2+0x2>,-(sp)
    21e2:	move.w 2dab2 <BmpUpperPart_PF2>,-(sp)
    21e8:	subq.l #2,sp
    21ea:	move.l 2daae <BmpUpperPart_Buf1+0x2e>,-(sp)
    21f0:	move.l 2daaa <BmpUpperPart_Buf1+0x2a>,-(sp)
    21f6:	move.l 2daa6 <BmpUpperPart_Buf1+0x26>,-(sp)
    21fc:	move.l 2daa2 <BmpUpperPart_Buf1+0x22>,-(sp)
    2202:	move.l 2da9e <BmpUpperPart_Buf1+0x1e>,-(sp)
    2208:	move.l 2da9a <BmpUpperPart_Buf1+0x1a>,-(sp)
    220e:	move.l 2da96 <BmpUpperPart_Buf1+0x16>,-(sp)
    2214:	move.l 2da92 <BmpUpperPart_Buf1+0x12>,-(sp)
    221a:	move.l 2da8e <BmpUpperPart_Buf1+0xe>,-(sp)
    2220:	move.l 2da8a <BmpUpperPart_Buf1+0xa>,-(sp)
    2226:	move.l 2da86 <BmpUpperPart_Buf1+0x6>,-(sp)
    222c:	move.l 2da82 <BmpUpperPart_Buf1+0x2>,-(sp)
    2232:	move.w 2da80 <BmpUpperPart_Buf1>,-(sp)
    2238:	jsr e5c <CopyBitmap>(pc)
		if (BounceEnabled)
    223c:	lea 104(sp),sp
    2240:	tst.w 2d9ac <BounceEnabled>
    2246:	beq.w 17b8 <MainLoop+0xe6>
			if (ScrollerDir > 0)
    224a:	move.b 6a3a <ScrollerDir>,d0
    2250:	ble.w 17a4 <MainLoop+0xd2>
				ScrollerDir = ((ScrollerMax - ScrollerY) * 1000 / 12000);
    2254:	pea c <_start+0xc>
    2258:	movea.w #40,a0
    225c:	suba.w 2d9aa <ScrollerY>,a0
    2262:	move.l a0,-(sp)
    2264:	jsr 281e <__divsi3>
    226a:	addq.l #8,sp
    226c:	move.b d0,6a3a <ScrollerDir>
				if(ScrollerDir > 6)
    2272:	cmpi.b #6,d0
    2276:	ble.s 2280 <MainLoop+0xbae>
					ScrollerDir = 6;
    2278:	move.b #6,6a3a <ScrollerDir>
				if(ScrollerDir < 1)
    2280:	tst.b 6a3a <ScrollerDir>
    2286:	ble.w 1798 <MainLoop+0xc6>
			ScrollerY += ScrollerDir;
    228a:	move.b 6a3a <ScrollerDir>,d0
    2290:	ext.w d0
    2292:	add.w d0,2d9aa <ScrollerY>
		if (ScrollerY >= ScrollerMax)
    2298:	movea.w 2d9aa <ScrollerY>,a0
    229e:	moveq #39,d0
    22a0:	cmp.l a0,d0
    22a2:	bge.w 17ce <MainLoop+0xfc>
			ScrollerY = ScrollerMax;
    22a6:	move.w #40,2d9aa <ScrollerY>
			ScrollerDir = -1;
    22ae:	st 6a3a <ScrollerDir>
		if (ScrollerPause < 1)
    22b4:	tst.w 2d9a8 <ScrollerPause>
    22ba:	beq.w 17fa <MainLoop+0x128>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    22be:	moveq #0,d4
    22c0:	move.w 2da54 <BmpScroller+0x6>,d4
    22c6:	moveq #0,d3
    22c8:	move.w 2da52 <BmpScroller+0x4>,d3
    22ce:	movea.l 2d9a4 <copScrollerBmpP>,a2
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    22d4:	lea 27a0 <__mulsi3>,a3
    22da:	move.l d4,-(sp)
    22dc:	movea.w 2d9aa <ScrollerY>,a0
    22e2:	move.l a0,-(sp)
    22e4:	jsr (a3)
    22e6:	addq.l #8,sp
    22e8:	move.l d0,-(sp)
    22ea:	move.l d3,-(sp)
    22ec:	jsr (a3)
    22ee:	addq.l #8,sp
    22f0:	add.l 2da5c <BmpScroller+0xe>,d0
    for (USHORT i = 0; i < numPlanes; i++)
    22f6:	suba.l a0,a0
    22f8:	bra.w 188c <MainLoop+0x1ba>
			MoveBobs();
    22fc:	jsr 8c <MoveBobs>(pc)
    2300:	bra.w 1b14 <MainLoop+0x442>
}
    2304:	movem.l (sp)+,d2-d4/a2-a5
    2308:	rts

0000230a <KPrintF>:
void KPrintF(const char* fmt, ...) {
    230a:	lea -128(sp),sp
    230e:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    2312:	move.w f0ff60 <_end+0xee23d4>,d0
    2318:	cmpi.w #20153,d0
    231c:	beq.s 2340 <KPrintF+0x36>
    231e:	cmpi.w #-24562,d0
    2322:	beq.s 2340 <KPrintF+0x36>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    2324:	movea.l 2db82 <SysBase>,a6
    232a:	movea.l 144(sp),a0
    232e:	lea 148(sp),a1
    2332:	lea 289a <KPutCharX>,a2
    2338:	suba.l a3,a3
    233a:	jsr -522(a6)
    233e:	bra.s 236a <KPrintF+0x60>
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    2340:	movea.l 2db82 <SysBase>,a6
    2346:	movea.l 144(sp),a0
    234a:	lea 148(sp),a1
    234e:	lea 28a8 <PutChar>,a2
    2354:	lea 12(sp),a3
    2358:	jsr -522(a6)
		UaeDbgLog(86, temp);
    235c:	move.l a3,-(sp)
    235e:	pea 56 <_start+0x56>
    2362:	jsr f0ff60 <_end+0xee23d4>
    2368:	addq.l #8,sp
}
    236a:	movem.l (sp)+,a2-a3/a6
    236e:	lea 128(sp),sp
    2372:	rts

00002374 <main>:
{
    2374:	movem.l d2-d3/a2/a6,-(sp)
	SysBase = *((struct ExecBase **)4UL);
    2378:	movea.l 4 <_start+0x4>,a6
    237c:	move.l a6,2db82 <SysBase>
	custom = (struct Custom *)0xdff000;
    2382:	move.l #14675968,2db88 <custom>
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
    238c:	lea 42e5 <incbin_P61_Player_end+0x1>,a1
    2392:	moveq #0,d0
    2394:	jsr -552(a6)
    2398:	move.l d0,2db7e <GfxBase>
	if (!GfxBase)
    239e:	beq.w 26dc <main+0x368>
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    23a2:	movea.l 2db82 <SysBase>,a6
    23a8:	lea 42f6 <incbin_P61_Player_end+0x12>,a1
    23ae:	moveq #0,d0
    23b0:	jsr -552(a6)
    23b4:	move.l d0,2db7a <DOSBase>
	if (!DOSBase)
    23ba:	beq.w 26ec <main+0x378>
	KPrintF("Hello debugger from Amiga!\n");
    23be:	pea 4302 <incbin_P61_Player_end+0x1e>
    23c4:	jsr 230a <KPrintF>(pc)
	Write(Output(), (APTR) "Hello console!\n", 15);
    23c8:	movea.l 2db7a <DOSBase>,a6
    23ce:	jsr -60(a6)
    23d2:	movea.l 2db7a <DOSBase>,a6
    23d8:	move.l d0,d1
    23da:	move.l #17182,d2
    23e0:	moveq #15,d3
    23e2:	jsr -48(a6)
	BitmapInit(&Screen, 320, 256, 3);
    23e6:	pea 3 <_start+0x3>
    23ea:	pea 100 <MoveBobs+0x74>
    23ee:	pea 140 <MoveBobs+0xb4>
    23f2:	pea 2db48 <Screen>
    23f8:	lea 123e <BitmapInit>(pc),a2
    23fc:	jsr (a2)
	BitmapInit(&BmpLogo, 256, 130, 3);
    23fe:	pea 3 <_start+0x3>
    2402:	pea 82 <_start+0x82>
    2406:	pea 100 <MoveBobs+0x74>
    240a:	pea 2db16 <BmpLogo>
    2410:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF1, 320, 130, 3);
    2412:	lea 36(sp),sp
    2416:	pea 3 <_start+0x3>
    241a:	pea 82 <_start+0x82>
    241e:	pea 140 <MoveBobs+0xb4>
    2422:	pea 2dae4 <BmpUpperPart_PF1>
    2428:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF2, 320 + 64, 130, 3);
    242a:	pea 3 <_start+0x3>
    242e:	pea 82 <_start+0x82>
    2432:	pea 180 <MoveBobs+0xf4>
    2436:	pea 2dab2 <BmpUpperPart_PF2>
    243c:	jsr (a2)
	BitmapInit(&BmpUpperPart_Buf1, 320 + 64, 130, 3);
    243e:	lea 32(sp),sp
    2442:	pea 3 <_start+0x3>
    2446:	pea 82 <_start+0x82>
    244a:	pea 180 <MoveBobs+0xf4>
    244e:	pea 2da80 <BmpUpperPart_Buf1>
    2454:	jsr (a2)
	BitmapInit(&BmpScroller, 320 + 32, 166, 3);
    2456:	pea 3 <_start+0x3>
    245a:	pea a6 <MoveBobs+0x1a>
    245e:	pea 160 <MoveBobs+0xd4>
    2462:	pea 2da4e <BmpScroller>
    2468:	jsr (a2)
	BitmapInit(&BmpFont32, 320, 256, 3);
    246a:	lea 32(sp),sp
    246e:	pea 3 <_start+0x3>
    2472:	pea 100 <MoveBobs+0x74>
    2476:	pea 140 <MoveBobs+0xb4>
    247a:	pea 2da1c <BmpFont32>
    2480:	jsr (a2)
	BitmapInit(&BmpCookie, 320, 256, 3);
    2482:	pea 3 <_start+0x3>
    2486:	pea 100 <MoveBobs+0x74>
    248a:	pea 140 <MoveBobs+0xb4>
    248e:	pea 2d9ea <BmpCookie>
    2494:	jsr (a2)
	BitmapInit(&BmpCookieMask, 320, 256, 3);
    2496:	lea 32(sp),sp
    249a:	pea 3 <_start+0x3>
    249e:	pea 100 <MoveBobs+0x74>
    24a2:	pea 140 <MoveBobs+0xb4>
    24a6:	pea 2d9b8 <BmpCookieMask>
    24ac:	jsr (a2)
	copPtr = AllocMem(1024, MEMF_CHIP);
    24ae:	movea.l 2db82 <SysBase>,a6
    24b4:	move.l #1024,d0
    24ba:	moveq #2,d1
    24bc:	jsr -198(a6)
    24c0:	move.l d0,2d9b4 <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
    24c6:	movea.l 2db82 <SysBase>,a6
    24cc:	moveq #0,d0
    24ce:	move.w 2da5a <BmpScroller+0xc>,d0
    24d4:	move.l #65538,d1
    24da:	jsr -198(a6)
    24de:	move.l d0,2da5c <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
    24e4:	movea.l 2db82 <SysBase>,a6
    24ea:	moveq #0,d0
    24ec:	move.w 2daf0 <BmpUpperPart_PF1+0xc>,d0
    24f2:	move.l #65538,d1
    24f8:	jsr -198(a6)
    24fc:	move.l d0,2daf2 <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
    2502:	movea.l 2db82 <SysBase>,a6
    2508:	moveq #0,d0
    250a:	move.w 2dabe <BmpUpperPart_PF2+0xc>,d0
    2510:	move.l #65538,d1
    2516:	jsr -198(a6)
    251a:	move.l d0,2dac0 <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
    2520:	movea.l 2db82 <SysBase>,a6
    2526:	moveq #0,d0
    2528:	move.w 2da8c <BmpUpperPart_Buf1+0xc>,d0
    252e:	move.l #65538,d1
    2534:	jsr -198(a6)
    2538:	move.l d0,2da8e <BmpUpperPart_Buf1+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
    253e:	move.l #27200,2db24 <BmpLogo+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
    2548:	move.l #39682,2da2a <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
    2552:	move.l #70404,2d9f8 <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
    255c:	move.l #101126,2d9c6 <BmpCookieMask+0xe>
	InitImagePlanes(&BmpUpperPart_PF1, 0);
    2566:	clr.l -(sp)
    2568:	pea 2dae4 <BmpUpperPart_PF1>
    256e:	lea e12 <InitImagePlanes>(pc),a2
    2572:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF2, 32 / 8);
    2574:	pea 4 <_start+0x4>
    2578:	pea 2dab2 <BmpUpperPart_PF2>
    257e:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_Buf1, 32 / 8);
    2580:	lea 32(sp),sp
    2584:	pea 4 <_start+0x4>
    2588:	pea 2da80 <BmpUpperPart_Buf1>
    258e:	jsr (a2)
	InitImagePlanes(&BmpScroller, 0);
    2590:	clr.l -(sp)
    2592:	pea 2da4e <BmpScroller>
    2598:	jsr (a2)
	InitImagePlanes(&BmpFont32, 0);
    259a:	clr.l -(sp)
    259c:	pea 2da1c <BmpFont32>
    25a2:	jsr (a2)
	InitImagePlanes(&BmpCookie, 0);
    25a4:	clr.l -(sp)
    25a6:	pea 2d9ea <BmpCookie>
    25ac:	jsr (a2)
	InitImagePlanes(&BmpCookieMask, 0);
    25ae:	lea 32(sp),sp
    25b2:	clr.l -(sp)
    25b4:	pea 2d9b8 <BmpCookieMask>
    25ba:	jsr (a2)
	TakeSystem();
    25bc:	jsr c86 <TakeSystem>(pc)
	InitStarfieldSprite();
    25c0:	jsr 1278 <InitStarfieldSprite>(pc)
	WaitVbl();
    25c4:	jsr c40 <WaitVbl>(pc)
	SetupCopper(copPtr);
    25c8:	move.l 2d9b4 <copPtr>,-(sp)
    25ce:	jsr 242 <SetupCopper>(pc)
	custom->cop1lc = (ULONG)copPtr;
    25d2:	movea.l 2db88 <custom>,a0
    25d8:	move.l 2d9b4 <copPtr>,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    25e0:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
    25e6:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    25ec:	move.w #-30752,150(a0)
	SetInterruptHandler((APTR)interruptHandler);
    25f2:	pea 11ee <interruptHandler>(pc)
    25f6:	jsr c26 <SetInterruptHandler>(pc)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
    25fa:	movea.l 2db88 <custom>,a0
    2600:	move.w #-16352,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
    2606:	move.w #32,156(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
    260c:	move.w #-24576,154(a0)
	if (p61Init(module) != 0)
    2612:	pea 20308 <incbin_module_start>
    2618:	jsr 11aa <p61Init>(pc)
    261c:	lea 20(sp),sp
    2620:	tst.l d0
    2622:	bne.w 26f8 <main+0x384>
	MainLoop();
    2626:	jsr 16d2 <MainLoop>(pc)
	p61End();
    262a:	jsr 121c <p61End>(pc)
	FreeMem(copPtr, 1024);
    262e:	movea.l 2db82 <SysBase>,a6
    2634:	movea.l 2d9b4 <copPtr>,a1
    263a:	move.l #1024,d0
    2640:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    2644:	movea.l 2db82 <SysBase>,a6
    264a:	movea.l 2da5c <BmpScroller+0xe>,a1
    2650:	moveq #0,d0
    2652:	move.w 2da5a <BmpScroller+0xc>,d0
    2658:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    265c:	movea.l 2db82 <SysBase>,a6
    2662:	movea.l 2daf2 <BmpUpperPart_PF1+0xe>,a1
    2668:	moveq #0,d0
    266a:	move.w 2daf0 <BmpUpperPart_PF1+0xc>,d0
    2670:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    2674:	movea.l 2db82 <SysBase>,a6
    267a:	movea.l 2dac0 <BmpUpperPart_PF2+0xe>,a1
    2680:	moveq #0,d0
    2682:	move.w 2dabe <BmpUpperPart_PF2+0xc>,d0
    2688:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_Buf1.ImageData, BmpUpperPart_PF2.Btot);
    268c:	movea.l 2db82 <SysBase>,a6
    2692:	movea.l 2da8e <BmpUpperPart_Buf1+0xe>,a1
    2698:	moveq #0,d0
    269a:	move.w 2dabe <BmpUpperPart_PF2+0xc>,d0
    26a0:	jsr -210(a6)
	CloseLibrary((struct Library *)DOSBase);
    26a4:	movea.l 2db82 <SysBase>,a6
    26aa:	movea.l 2db7a <DOSBase>,a1
    26b0:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    26b4:	movea.l 2db82 <SysBase>,a6
    26ba:	movea.l 2db7e <GfxBase>,a1
    26c0:	jsr -414(a6)
	FreeSystem();
    26c4:	jsr d52 <FreeSystem>(pc)
	Exit(0);
    26c8:	movea.l 2db7a <DOSBase>,a6
    26ce:	moveq #0,d1
    26d0:	jsr -144(a6)
}
    26d4:	moveq #0,d0
    26d6:	movem.l (sp)+,d2-d3/a2/a6
    26da:	rts
		Exit(0);
    26dc:	movea.l 2db7a <DOSBase>,a6
    26e2:	moveq #0,d1
    26e4:	jsr -144(a6)
    26e8:	bra.w 23a2 <main+0x2e>
		Exit(0);
    26ec:	movea.l d0,a6
    26ee:	moveq #0,d1
    26f0:	jsr -144(a6)
    26f4:	bra.w 23be <main+0x4a>
		KPrintF("p61Init failed!\n");
    26f8:	pea 432e <incbin_P61_Player_end+0x4a>
    26fe:	jsr 230a <KPrintF>(pc)
    2702:	addq.l #4,sp
    2704:	bra.w 2626 <main+0x2b2>

00002708 <strlen>:
unsigned long strlen(const char* s) {
    2708:	movea.l 4(sp),a0
	unsigned long t=0;
    270c:	moveq #0,d0
    270e:	bra.s 2712 <strlen+0xa>
		t++;
    2710:	addq.l #1,d0
	while(*s++)
    2712:	tst.b (a0)+
    2714:	bne.s 2710 <strlen+0x8>
}
    2716:	rts

00002718 <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    2718:	move.l d2,-(sp)
    271a:	move.l 8(sp),d0
    271e:	move.l 12(sp),d2
    2722:	move.l 16(sp),d1
	unsigned char *ptr = (unsigned char *)dest;
    2726:	movea.l d0,a0
    2728:	bra.s 272e <memset+0x16>
		*ptr++ = val;
    272a:	move.b d2,(a0)+
	while(len-- > 0)
    272c:	move.l a1,d1
    272e:	movea.l d1,a1
    2730:	subq.l #1,a1
    2732:	tst.l d1
    2734:	bne.s 272a <memset+0x12>
}
    2736:	move.l (sp)+,d2
    2738:	rts

0000273a <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    273a:	move.l d2,-(sp)
    273c:	move.l 8(sp),d0
    2740:	movea.l 12(sp),a1
    2744:	move.l 16(sp),d1
	char *d = (char *)dest;
    2748:	movea.l d0,a0
    274a:	bra.s 2750 <memcpy+0x16>
		*d++ = *s++;
    274c:	move.b (a1)+,(a0)+
	while(len--)
    274e:	move.l d2,d1
    2750:	move.l d1,d2
    2752:	subq.l #1,d2
    2754:	tst.l d1
    2756:	bne.s 274c <memcpy+0x12>
}
    2758:	move.l (sp)+,d2
    275a:	rts

0000275c <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    275c:	move.l d2,-(sp)
    275e:	move.l 8(sp),d0
    2762:	movea.l 12(sp),a0
    2766:	move.l 16(sp),d1
	if (d < s) {
    276a:	cmpa.l d0,a0
    276c:	bhi.s 2788 <memmove+0x2c>
		const char *lasts = s + (len - 1);
    276e:	movea.l d1,a1
    2770:	subq.l #1,a1
    2772:	adda.l a1,a0
		char *lastd = d + (len - 1);
    2774:	adda.l d0,a1
		while (len--)
    2776:	bra.s 2794 <memmove+0x38>
			*d++ = *s++;
    2778:	move.b (a0)+,(a1)+
		while (len--)
    277a:	move.l d2,d1
    277c:	move.l d1,d2
    277e:	subq.l #1,d2
    2780:	tst.l d1
    2782:	bne.s 2778 <memmove+0x1c>
}
    2784:	move.l (sp)+,d2
    2786:	rts
	char *d = dest;
    2788:	movea.l d0,a1
    278a:	bra.s 277c <memmove+0x20>
			*lastd-- = *lasts--;
    278c:	move.b (a0),(a1)
    278e:	subq.l #1,a1
    2790:	subq.l #1,a0
		while (len--)
    2792:	move.l d2,d1
    2794:	move.l d1,d2
    2796:	subq.l #1,d2
    2798:	tst.l d1
    279a:	bne.s 278c <memmove+0x30>
    279c:	bra.s 2784 <memmove+0x28>
    279e:	nop

000027a0 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    27a0:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    27a4:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    27a8:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    27ac:	mulu.w 8(sp),d1
	addw	d1, d0
    27b0:	add.w d1,d0
	swap	d0
    27b2:	swap d0
	clrw	d0
    27b4:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    27b6:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    27ba:	mulu.w 10(sp),d1
	addl	d1, d0
    27be:	add.l d1,d0
	rts
    27c0:	rts

000027c2 <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    27c2:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    27c4:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    27c8:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    27cc:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    27d2:	bcc.s 27ea <__udivsi3+0x28>
	movel	d0, d2
    27d4:	move.l d0,d2
	clrw	d2
    27d6:	clr.w d2
	swap	d2
    27d8:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    27da:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    27dc:	move.w d2,d0
	swap	d0
    27de:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    27e0:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    27e4:	divu.w d1,d2
	movew	d2, d0
    27e6:	move.w d2,d0
	jra	6f
    27e8:	bra.s 281a <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    27ea:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    27ec:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    27ee:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    27f0:	cmpi.l #65536,d1
	jcc	4b
    27f6:	bcc.s 27ec <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    27f8:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    27fa:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    2800:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    2802:	mulu.w d0,d1
	swap	d2
    2804:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    2806:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    2808:	swap d2
	tstw	d2		/* high part 17 bits? */
    280a:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    280c:	bne.s 2818 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    280e:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    2810:	bcs.s 2818 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    2812:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    2816:	bls.s 281a <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    2818:	subq.l #1,d0

6:	movel	sp@+, d2
    281a:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    281c:	rts

0000281e <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    281e:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    2820:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    2822:	move.l 12(sp),d1
	jpl	1f
    2826:	bpl.s 282c <__divsi3+0xe>
	negl	d1
    2828:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    282a:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    282c:	move.l 8(sp),d0
	jpl	2f
    2830:	bpl.s 2836 <__divsi3+0x18>
	negl	d0
    2832:	neg.l d0
	negb	d2
    2834:	neg.b d2

2:	movel	d1, sp@-
    2836:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2838:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    283a:	bsr.s 27c2 <__udivsi3>
	addql	#8, sp
    283c:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    283e:	tst.b d2
	jpl	3f
    2840:	bpl.s 2844 <__divsi3+0x26>
	negl	d0
    2842:	neg.l d0

3:	movel	sp@+, d2
    2844:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    2846:	rts

00002848 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    2848:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    284c:	move.l 4(sp),d0
	movel	d1, sp@-
    2850:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2852:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    2854:	bsr.s 281e <__divsi3>
	addql	#8, sp
    2856:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    2858:	move.l 8(sp),d1
	movel	d1, sp@-
    285c:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    285e:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    2860:	bsr.w 27a0 <__mulsi3>
	addql	#8, sp
    2864:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2866:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    286a:	sub.l d0,d1
	movel	d1, d0
    286c:	move.l d1,d0
	rts
    286e:	rts

00002870 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    2870:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    2874:	move.l 4(sp),d0
	movel	d1, sp@-
    2878:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    287a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    287c:	bsr.w 27c2 <__udivsi3>
	addql	#8, sp
    2880:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    2882:	move.l 8(sp),d1
	movel	d1, sp@-
    2886:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2888:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    288a:	bsr.w 27a0 <__mulsi3>
	addql	#8, sp
    288e:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2890:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2894:	sub.l d0,d1
	movel	d1, d0
    2896:	move.l d1,d0
	rts
    2898:	rts

0000289a <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    289a:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    289c:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    28a0:	jsr -516(a6)
    move.l (sp)+, a6
    28a4:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    28a6:	rts

000028a8 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    28a8:	move.b d0,(a3)+
	rts
    28aa:	rts

000028ac <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    28ac:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    28ae:	adda.l a0,a2
	move.l	a2,a3
    28b0:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    28b2:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    28b4:	moveq #56,d4
	moveq	#8,d5
    28b6:	moveq #8,d5
	bra.s	.Lliteral
    28b8:	bra.s 2922 <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    28ba:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    28bc:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    28be:	dbf d1,28ba <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    28c2:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    28c4:	bcc.s 28c8 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    28c6:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    28c8:	tst.w d0
    28ca:	bne.s 28d4 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    28cc:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    28ce:	bls.s 2946 <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    28d0:	move.w (a0)+,d0
    28d2:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    28d4:	rol.l #6,d0
	move.w	d0,d1
    28d6:	move.w d0,d1
	and.w	d4,d1
    28d8:	and.w d4,d1
	eor.w	d1,d0
    28da:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    28dc:	movem.w (2940 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    28e2:	rol.l d2,d0
	and.w	d0,d3					|scaling
    28e4:	and.w d0,d3
	eor.w	d3,d0
    28e6:	eor.w d3,d0
	suba.w	d3,a4
    28e8:	suba.w d3,a4
	adda.l	a1,a4
    28ea:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    28ec:	tst.w d0
    28ee:	bne.s 28f4 <_doynaxdepack_asm+0x48>
    28f0:	move.w (a0)+,d0
    28f2:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    28f4:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    28f6:	beq.s 290e <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    28f8:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    28fa:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    28fc:	bpl.s 290a <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    28fe:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    2900:	bpl.s 2908 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    2902:	addx.b d1,d1
	lsl.l	#2,d0
    2904:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    2906:	bmi.s 2902 <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    2908:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    290a:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    290c:	bcc.s 2910 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    290e:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    2910:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    2912:	dbf d1,290e <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    2916:	add.l d0,d0
	bcc.s	.Lmatch
    2918:	bcc.s 28c8 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    291a:	tst.w d0
    291c:	bne.s 2922 <_doynaxdepack_asm+0x76>
    291e:	move.w (a0)+,d0
    2920:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    2922:	moveq #0,d1
	add.l	d0,d0
    2924:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    2926:	bcc.s 28c6 <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    2928:	bpl.s 2930 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    292a:	addx.b d1,d1
	lsl.l	#2,d0
    292c:	lsl.l #2,d0
	bmi.s	.Llgetlen
    292e:	bmi.s 292a <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    2930:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    2932:	dbv.s d1,28ba <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    2936:	add.l d0,d0
	eor.w	d1,d0		
    2938:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    293a:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    293c:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    293e:	bra.s 2932 <_doynaxdepack_asm+0x86>

00002940 <doy_table>:
    2940:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    2950:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    2960:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    2970:	.............o
