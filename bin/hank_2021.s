
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
       4:	move.l #27430,d3
       a:	subi.l #27430,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	moveq #0,d2
      14:	bra.s 2a <_start+0x2a>
		__preinit_array_start[i]();
      16:	move.l d2,d0
      18:	add.l d2,d0
      1a:	add.l d0,d0
      1c:	lea 6b26 <__fini_array_end>,a0
      22:	movea.l (0,a0,d0.l),a0
      26:	jsr (a0)
	for (i = 0; i < count; i++)
      28:	addq.l #1,d2
      2a:	cmp.l d2,d3
      2c:	bhi.s 16 <_start+0x16>

	count = __init_array_end - __init_array_start;
      2e:	move.l #27430,d3
      34:	subi.l #27430,d3
      3a:	asr.l #2,d3
	for (i = 0; i < count; i++)
      3c:	moveq #0,d2
      3e:	bra.s 54 <_start+0x54>
		__init_array_start[i]();
      40:	move.l d2,d0
      42:	add.l d2,d0
      44:	add.l d0,d0
      46:	lea 6b26 <__fini_array_end>,a0
      4c:	movea.l (0,a0,d0.l),a0
      50:	jsr (a0)
	for (i = 0; i < count; i++)
      52:	addq.l #1,d2
      54:	cmp.l d2,d3
      56:	bhi.s 40 <_start+0x40>

	main();
      58:	jsr 24a4 <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
      5e:	move.l #27430,d2
      64:	subi.l #27430,d2
      6a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      6c:	bra.s 82 <_start+0x82>
		__fini_array_start[i - 1]();
      6e:	subq.l #1,d2
      70:	move.l d2,d0
      72:	add.l d2,d0
      74:	add.l d0,d0
      76:	lea 6b26 <__fini_array_end>,a0
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
      90:	move.w 30bd8 <BobPhase>,d0
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
      a6:	lea 6b2e <BobVecs>,a1
      ac:	move.l d0,d3
      ae:	lsl.l #3,d3
      b0:	movea.l d3,a0
      b2:	add.l (0,a1,d3.l),d1
      b6:	lea 6b5e <BobTarget>,a1
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
      dc:	lea 6b5e <BobTarget>,a0
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
     108:	move.l 6b56 <BobVecs+0x28>,d1
     10e:	move.l d1,d0
     110:	add.l 6b86 <BobTarget+0x28>,d0
     116:	move.l d0,6b86 <BobTarget+0x28>
		if (BobTarget[BOBSN - 1].X > 320 + 32)
     11c:	cmpi.l #352,d0
     122:	ble.s 12e <MoveBobs+0xa2>
			BobTarget[BOBSN - 1].X = 320 + 32;
     124:	move.l #352,6b86 <BobTarget+0x28>
		if (BobTarget[0].X >= 320 + 32)
     12e:	cmpi.l #351,6b5e <BobTarget>
     138:	ble.w a0 <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     13c:	neg.l 6b2e <BobVecs>
			BobVecs[1].X *= -1;
     142:	neg.l 6b36 <BobVecs+0x8>
			BobVecs[2].X *= -1;
     148:	neg.l 6b3e <BobVecs+0x10>
			BobVecs[3].X *= -1;
     14e:	neg.l 6b46 <BobVecs+0x18>
			BobVecs[4].X *= -1;
     154:	neg.l 6b4e <BobVecs+0x20>
			BobVecs[5].X *= -1;
     15a:	neg.l d1
     15c:	move.l d1,6b56 <BobVecs+0x28>
			BobPhase = 1;
     162:	move.w #1,30bd8 <BobPhase>
			BobPause = 2 * 50;
     16a:	move.w #100,30bda <BobPause>
			*copPF1BmpP = 0 << 6; // prio. in bplcon2: pf1 >> pf 2 >> sprites
     172:	movea.l 30bd4 <copPF1BmpP>,a0
     178:	clr.w (a0)
     17a:	bra.w a0 <MoveBobs+0x14>
				BobTarget[b].X += BobVecs[b].X;
     17e:	lea 6b2e <BobVecs>,a1
     184:	move.l d0,d3
     186:	lsl.l #3,d3
     188:	movea.l d3,a0
     18a:	add.l (0,a1,d3.l),d1
     18e:	lea 6b5e <BobTarget>,a1
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
     1a2:	lea 6b5e <BobTarget>,a0
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
     1d8:	move.l 6b56 <BobVecs+0x28>,d1
     1de:	move.l d1,d0
     1e0:	add.l 6b86 <BobTarget+0x28>,d0
     1e6:	move.l d0,6b86 <BobTarget+0x28>
		if (BobTarget[BOBSN - 1].X < 0)
     1ec:	bmi.s 23a <MoveBobs+0x1ae>
		if (BobTarget[0].X <= 0)
     1ee:	tst.l 6b5e <BobTarget>
     1f4:	bgt.w a0 <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     1f8:	neg.l 6b2e <BobVecs>
			BobVecs[1].X *= -1;
     1fe:	neg.l 6b36 <BobVecs+0x8>
			BobVecs[2].X *= -1;
     204:	neg.l 6b3e <BobVecs+0x10>
			BobVecs[3].X *= -1;
     20a:	neg.l 6b46 <BobVecs+0x18>
			BobVecs[4].X *= -1;
     210:	neg.l 6b4e <BobVecs+0x20>
			BobVecs[5].X *= -1;
     216:	neg.l d1
     218:	move.l d1,6b56 <BobVecs+0x28>
			BobPause = 2 * 50;
     21e:	move.w #100,30bda <BobPause>
			BobPhase = 0;
     226:	clr.w 30bd8 <BobPhase>
			*copPF1BmpP = 1 << 6; // prio. in bplcon2: pf2 >> pf 1 >> sprites
     22c:	movea.l 30bd4 <copPF1BmpP>,a0
     232:	move.w #64,(a0)
     236:	bra.w a0 <MoveBobs+0x14>
			BobTarget[BOBSN - 1].X = 0;
     23a:	clr.l 6b86 <BobTarget+0x28>
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
     278:	move.w 30dbc <Screen+0x6>,d0
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     27e:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     284:	move.w 30d28 <BmpUpperPart_PF1+0x8>,d1
     28a:	sub.w d0,d1
     28c:	move.w d1,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     290:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     296:	move.w 30cf6 <BmpUpperPart_PF2+0x8>,d2
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
     2b6:	move.l a0,30bd4 <copPF1BmpP>
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
     2ce:	move.w #400,36(a1)
    *copListCurrent++ = color;
     2d4:	lea 40(a1),a0
     2d8:	move.w #21,38(a1)
	// set logo colors
	copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[0]);
	copPtr = copSetColor(copPtr, 8, colgradbluePaletteRGB4[0]);
	copPF1ColP = copPtr;
     2de:	move.l a0,30be8 <copPF1ColP>
	for (int a = 1; a < 8; a++)
     2e4:	moveq #1,d0
     2e6:	bra.s 306 <SetupCopper+0xc4>
	{
		copPtr = copSetColor(copPtr, a, ActPfCol[a]);
     2e8:	move.l d0,d1
     2ea:	add.l d0,d1
     2ec:	movea.l 6bb0 <ActPfCol>,a1
     2f2:	move.w (0,a1,d1.l),2(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2f8:	move.w d0,d1
     2fa:	addi.w #192,d1
     2fe:	add.w d1,d1
     300:	move.w d1,(a0)
	for (int a = 1; a < 8; a++)
     302:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, ActPfCol[a]);
     304:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     306:	moveq #7,d1
     308:	cmp.l d0,d1
     30a:	bge.s 2e8 <SetupCopper+0xa6>
	}
	for (int a = 9; a < 16; a++)
     30c:	moveq #9,d0
     30e:	bra.s 330 <SetupCopper+0xee>
	{
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     310:	move.l d0,d1
     312:	subq.l #8,d1
     314:	add.l d1,d1
     316:	movea.w d0,a1
     318:	lea 192(a1),a1
     31c:	adda.w a1,a1
     31e:	move.w a1,(a0)
    *copListCurrent++ = color;
     320:	lea 4a96 <CookiePaletteRGB4>,a1
     326:	move.w (0,a1,d1.l),2(a0)
	for (int a = 9; a < 16; a++)
     32c:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     32e:	addq.l #4,a0
	for (int a = 9; a < 16; a++)
     330:	moveq #15,d2
     332:	cmp.l d0,d2
     334:	bge.s 310 <SetupCopper+0xce>
	}
	// set upper part, pf1, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.Planes[0], BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
     336:	moveq #0,d5
     338:	move.w 30d26 <BmpUpperPart_PF1+0x6>,d5
     33e:	moveq #0,d4
     340:	move.w 30d24 <BmpUpperPart_PF1+0x4>,d4
     346:	move.l 30d32 <BmpUpperPart_PF1+0x12>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     34c:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     34e:	clr.b d2
     350:	bra.s 37e <SetupCopper+0x13c>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     352:	move.b d2,d0
     354:	ext.w d0
     356:	movea.w d0,a1
     358:	moveq #56,d0
     35a:	add.l a1,d0
     35c:	add.w d0,d0
     35e:	add.w d0,d0
     360:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     362:	move.l d1,d3
     364:	clr.w d3
     366:	swap d3
     368:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     36c:	addq.w #2,d0
     36e:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     372:	move.w d1,6(a0)
        addr += Bpl;
     376:	add.l d5,d1
        plane += 2;
     378:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     37a:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     37c:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     37e:	moveq #0,d0
     380:	move.w a2,d0
     382:	cmp.l d4,d0
     384:	blt.s 352 <SetupCopper+0x110>
	// set upper part, pf2, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.Planes[0], BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
     386:	moveq #0,d5
     388:	move.w 30cf4 <BmpUpperPart_PF2+0x6>,d5
     38e:	moveq #0,d4
     390:	move.w 30cf2 <BmpUpperPart_PF2+0x4>,d4
     396:	move.l 30d00 <BmpUpperPart_PF2+0x12>,d1
     39c:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     39e:	moveq #1,d2
     3a0:	bra.s 3ce <SetupCopper+0x18c>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     3a2:	move.b d2,d0
     3a4:	ext.w d0
     3a6:	movea.w d0,a1
     3a8:	moveq #56,d0
     3aa:	add.l a1,d0
     3ac:	add.w d0,d0
     3ae:	add.w d0,d0
     3b0:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     3b2:	move.l d1,d3
     3b4:	clr.w d3
     3b6:	swap d3
     3b8:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     3bc:	addq.w #2,d0
     3be:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3c2:	move.w d1,6(a0)
        addr += Bpl;
     3c6:	add.l d5,d1
        plane += 2;
     3c8:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     3ca:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3cc:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     3ce:	moveq #0,d0
     3d0:	move.w a2,d0
     3d2:	cmp.l d4,d0
     3d4:	blt.s 3a2 <SetupCopper+0x160>
	// set sprite pointers
	*copPtr++ = SPR0PTH;
     3d6:	move.w #288,(a0)
	*copPtr++ = (LONG)StarSprite >> 16;
     3da:	move.l #198860,d0
     3e0:	move.l d0,d1
     3e2:	swap d1
     3e4:	ext.l d1
     3e6:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
     3ea:	move.w #290,4(a0)
	*copPtr++ = (LONG)StarSprite;
     3f0:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
     3f4:	move.w #292,8(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     3fa:	move.l #198848,d0
     400:	move.l d0,d1
     402:	swap d1
     404:	ext.l d1
     406:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
     40a:	move.w #294,12(a0)
	*copPtr++ = (LONG)NullSprite;
     410:	move.w d0,14(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     414:	move.w #418,16(a0)
    *copListCurrent++ = color;
     41a:	move.w #2120,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     420:	move.w #420,20(a0)
    *copListCurrent++ = color;
     426:	move.w #143,22(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     42c:	move.w #422,24(a0)
    *copListCurrent++ = color;
     432:	move.w #4095,26(a0)
	// sprite 0+1 colors
	copPtr = copSetColor(copPtr, 17, 0x848);
	copPtr = copSetColor(copPtr, 18, 0x08f);
	copPtr = copSetColor(copPtr, 19, 0xfff);
	*copPtr++ = SPR2PTH;
     438:	move.w #296,28(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     43e:	move.w d1,30(a0)
	*copPtr++ = SPR2PTL;
     442:	move.w #298,32(a0)
	*copPtr++ = (LONG)NullSprite;
     448:	move.w d0,34(a0)
	*copPtr++ = SPR3PTH;
     44c:	move.w #300,36(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     452:	move.w d1,38(a0)
	*copPtr++ = SPR3PTL;
     456:	move.w #302,40(a0)
	*copPtr++ = (LONG)NullSprite;
     45c:	move.w d0,42(a0)
	*copPtr++ = SPR4PTH;
     460:	move.w #304,44(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     466:	move.w d1,46(a0)
	*copPtr++ = SPR4PTL;
     46a:	move.w #306,48(a0)
	*copPtr++ = (LONG)NullSprite;
     470:	move.w d0,50(a0)
	*copPtr++ = SPR5PTH;
     474:	move.w #308,52(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     47a:	move.w d1,54(a0)
	*copPtr++ = SPR5PTL;
     47e:	move.w #310,56(a0)
	*copPtr++ = (LONG)NullSprite;
     484:	move.w d0,58(a0)
	*copPtr++ = SPR6PTH;
     488:	move.w #312,60(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     48e:	move.w d1,62(a0)
	*copPtr++ = SPR6PTL;
     492:	move.w #314,64(a0)
	*copPtr++ = (LONG)NullSprite;
     498:	move.w d0,66(a0)
	*copPtr++ = SPR7PTH;
     49c:	move.w #316,68(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     4a2:	move.w d1,70(a0)
	*copPtr++ = SPR7PTL;
     4a6:	move.w #318,72(a0)
	*copPtr++ = (LONG)NullSprite;
     4ac:	move.w d0,74(a0)
	// enable bitplanes
	*copPtr++ = BPLCON0;
     4b0:	move.w #256,76(a0)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     4b6:	moveq #0,d0
     4b8:	move.w 30d88 <BmpLogo+0x4>,d0
     4be:	add.l d0,d0
     4c0:	moveq #12,d3
     4c2:	lsl.l d3,d0
     4c4:	ori.w #1536,d0
     4c8:	move.w d0,78(a0)
	// wait till below logo
	line = 0x2c + BmpUpperPart_PF1.Height;
     4cc:	move.b 30d23 <BmpUpperPart_PF1+0x3>,d0
     4d2:	addi.b #44,d0
	copPtr = copWaitY(copPtr, line++);
     4d6:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     4dc:	lsl.l #8,d0
     4de:	ori.w #5,d0
     4e2:	move.w d0,80(a0)
    *copListEnd++ = COP_WAIT;
     4e6:	move.w #-2,82(a0)
	// turn off bitplanes to waste 8 lines, giving the logo more bottom space
	*copPtr++ = BPLCON0;
     4ec:	move.w #256,84(a0)
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     4f2:	move.w #512,86(a0)
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
     4f8:	move.b 30d23 <BmpUpperPart_PF1+0x3>,d0
     4fe:	addi.b #52,d0
	copPtr = copWaitY(copPtr, line++);
     502:	move.b 30d23 <BmpUpperPart_PF1+0x3>,d1
     508:	addi.b #53,d1
     50c:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     512:	lsl.l #8,d0
     514:	ori.w #5,d0
     518:	move.w d0,88(a0)
    *copListEnd++ = COP_WAIT;
     51c:	lea 92(a0),a1
     520:	move.w #-2,90(a0)
	// set bitplane pointers
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     526:	move.l a1,30bdc <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     52c:	moveq #0,d5
     52e:	move.w 30c90 <BmpScroller+0x6>,d5
     534:	moveq #0,d4
     536:	move.w 30c8e <BmpScroller+0x4>,d4
     53c:	move.l 30c98 <BmpScroller+0xe>,d2
    for (USHORT i = 0; i < numPlanes; i++)
     542:	suba.l a0,a0
     544:	bra.s 56a <SetupCopper+0x328>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     546:	moveq #56,d3
     548:	add.l d3,d0
     54a:	add.w d0,d0
     54c:	add.w d0,d0
     54e:	move.w d0,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     550:	move.l d2,d3
     552:	clr.w d3
     554:	swap d3
     556:	move.w d3,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     55a:	addq.w #2,d0
     55c:	move.w d0,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     560:	move.w d2,6(a1)
        addr += Bpl;
     564:	add.l d5,d2
    for (USHORT i = 0; i < numPlanes; i++)
     566:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
     568:	addq.l #8,a1
    for (USHORT i = 0; i < numPlanes; i++)
     56a:	moveq #0,d0
     56c:	move.w a0,d0
     56e:	cmp.l d4,d0
     570:	blt.s 546 <SetupCopper+0x304>
	//set modulo for scroller
	copPtr = copSetBplMod(0, copPtr,
						  BmpScroller.Bplt - Screen.Bpl,
						  BmpScroller.Bplt - Screen.Bpl);
     572:	move.w 30c92 <BmpScroller+0x8>,d0
     578:	sub.w 30dbc <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     57e:	move.w #264,(a1)
    *copListEnd++ = modOdd;
     582:	move.w d0,2(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     586:	move.w #266,4(a1)
    *copListEnd++ = modEven;
     58c:	move.w d0,6(a1)
	*copPtr++ = BPLCON0;
     590:	move.w #256,8(a1)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     596:	moveq #0,d0
     598:	move.w 30d88 <BmpLogo+0x4>,d0
     59e:	moveq #12,d2
     5a0:	lsl.l d2,d0
     5a2:	lea 12(a1),a0
     5a6:	ori.w #512,d0
     5aa:	move.w d0,10(a1)
	// set font colors for scroller
	for (int a = 1; a < 8; a++)
     5ae:	moveq #1,d0
     5b0:	bra.s 5d0 <SetupCopper+0x38e>
	{
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     5b2:	move.l d0,d2
     5b4:	add.l d0,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5b6:	movea.w d0,a1
     5b8:	lea 192(a1),a1
     5bc:	adda.w a1,a1
     5be:	move.w a1,(a0)
    *copListCurrent++ = color;
     5c0:	lea 4a86 <FontPaletteRGB4>,a1
     5c6:	move.w (0,a1,d2.l),2(a0)
	for (int a = 1; a < 8; a++)
     5cc:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     5ce:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     5d0:	moveq #7,d3
     5d2:	cmp.l d0,d3
     5d4:	bge.s 5b2 <SetupCopper+0x370>
	}
	// blue gradient below logo
	for (int l = 0; l < 24; l++)
     5d6:	moveq #0,d0
     5d8:	bra.s 608 <SetupCopper+0x3c6>
	{
		copPtr = copWaitY(copPtr, line);
     5da:	moveq #0,d2
     5dc:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     5de:	lsl.l #8,d2
     5e0:	ori.w #5,d2
     5e4:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     5e6:	move.w #-2,2(a0)
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     5ec:	movea.l d0,a1
     5ee:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5f0:	move.w #384,4(a0)
    *copListCurrent++ = color;
     5f6:	lea 4aa6 <colgradbluePaletteRGB4>,a2
     5fc:	move.w (0,a2,a1.l),6(a0)
		line += 2;
     602:	addq.b #2,d1
	for (int l = 0; l < 24; l++)
     604:	addq.l #1,d0
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     606:	addq.l #8,a0
	for (int l = 0; l < 24; l++)
     608:	moveq #23,d2
     60a:	cmp.l d0,d2
     60c:	bge.s 5da <SetupCopper+0x398>
	}
	copPtr = copWaitY(copPtr, line++);
     60e:	move.b d1,d0
     610:	addq.b #1,d0
     612:	moveq #0,d2
     614:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     616:	lsl.l #8,d2
     618:	ori.w #5,d2
     61c:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     61e:	move.w #-2,2(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
     624:	movea.w 6b2a <colScrollMirror>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     62a:	move.w #384,4(a0)
    *copListCurrent++ = color;
     630:	move.w a1,6(a0)
	copPtr = copWaitY(copPtr, line++);
     634:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     63a:	lsl.l #8,d0
     63c:	ori.w #5,d0
     640:	move.w d0,8(a0)
    *copListEnd++ = COP_WAIT;
     644:	move.w #-2,10(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
     64a:	move.w 6b2c <colScrollMirror+0x2>,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     650:	move.w #384,12(a0)
    *copListCurrent++ = color;
     656:	move.w d2,14(a0)
	line += 7;
     65a:	move.b d1,d0
     65c:	addi.b #9,d0
	copPtr = copWaitY(copPtr, line++);
     660:	addi.b #10,d1
     664:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     66a:	lsl.l #8,d0
     66c:	ori.w #5,d0
     670:	move.w d0,16(a0)
    *copListEnd++ = COP_WAIT;
     674:	move.w #-2,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     67a:	move.w #384,20(a0)
    *copListCurrent++ = color;
     680:	move.w a1,22(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
     684:	andi.l #255,d1
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     68a:	lsl.l #8,d1
     68c:	ori.w #5,d1
     690:	move.w d1,24(a0)
    *copListEnd++ = COP_WAIT;
     694:	move.w #-2,26(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     69a:	move.w #384,28(a0)
    *copListCurrent++ = color;
     6a0:	move.w d2,30(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// set bitplane mods
	line = 0x2c + BmpLogo.Height + 72 + 7; // 209
     6a4:	move.b 30d87 <BmpLogo+0x3>,d0
     6aa:	addi.b #123,d0
	copPtr = copWaitY(copPtr, line++);
     6ae:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6b4:	lsl.l #8,d0
     6b6:	ori.w #5,d0
     6ba:	move.w d0,32(a0)
    *copListEnd++ = COP_WAIT;
     6be:	move.w #-2,34(a0)
	copMirrorBmpP = copPtr;
     6c4:	lea 36(a0),a2
     6c8:	move.l a2,30bd0 <copMirrorBmpP>
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     6ce:	move.w 30d8c <BmpLogo+0x8>,d0
     6d4:	sub.w 30d8a <BmpLogo+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     6da:	move.w #264,36(a0)
    *copListEnd++ = modOdd;
     6e0:	move.w d0,38(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     6e4:	move.w #266,40(a0)
    *copListEnd++ = modEven;
     6ea:	move.w d0,42(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6ee:	move.w #-31,44(a0)
    *copListEnd++ = COP_WAIT;
     6f4:	move.w #-2,46(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6fa:	move.w #1285,48(a0)
    *copListEnd++ = COP_WAIT;
     700:	move.w #-2,50(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     706:	move.w #384,52(a0)
    *copListCurrent++ = color;
     70c:	move.w a1,54(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     710:	move.w #1541,56(a0)
    *copListEnd++ = COP_WAIT;
     716:	move.w #-2,58(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     71c:	move.w #384,60(a0)
    *copListCurrent++ = color;
     722:	move.w d2,62(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     726:	move.w #11269,64(a0)
    *copListEnd++ = COP_WAIT;
     72c:	move.w #-2,66(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     732:	move.w #384,68(a0)
    *copListCurrent++ = color;
     738:	move.w a1,70(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     73c:	move.w #11525,72(a0)
    *copListEnd++ = COP_WAIT;
     742:	move.w #-2,74(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     748:	move.w #384,76(a0)
    *copListCurrent++ = color;
     74e:	move.w d2,78(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     752:	move.w #-1,80(a0)
    *copListEnd++ = COP_WAIT;
     758:	move.w #-2,82(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// copper end
	copPtr = copWaitXY(copPtr, 0xff, 0xff);
}
     75e:	movem.l (sp)+,d2-d5/a2
     762:	rts

00000764 <EnableMirrorEffect>:

void EnableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2),
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
     764:	move.w 30c92 <BmpScroller+0x8>,d0
     76a:	move.w d0,d1
     76c:	sub.w 30dbc <Screen+0x6>,d1
     772:	add.w d0,d0
     774:	sub.w d0,d1
	copSetBplMod(0, copMirrorBmpP,
     776:	movea.l 30bd0 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     77c:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     780:	move.w d1,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     784:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     78a:	move.w d1,6(a0)
}
     78e:	rts

00000790 <DisableMirrorEffect>:

void DisableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 BmpScroller.Bplt - Screen.Bpl,
				 BmpScroller.Bplt - Screen.Bpl);
     790:	move.w 30c92 <BmpScroller+0x8>,d0
     796:	sub.w 30dbc <Screen+0x6>,d0
	copSetBplMod(0, copMirrorBmpP,
     79c:	movea.l 30bd0 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     7a2:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     7a6:	move.w d0,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     7aa:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     7b0:	move.w d0,6(a0)
}
     7b4:	rts

000007b6 <PlotChar>:
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
	}
}

void PlotChar(BmpDescriptor bmpFont, BmpDescriptor bmpDest, USHORT plotY, USHORT charW, USHORT charH)
{
     7b6:	movem.l d2-d6/a2/a6,-(sp)
     7ba:	move.l 136(sp),d5
     7be:	move.l 140(sp),d3
     7c2:	move.l 144(sp),d4
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     7c6:	move.w 30bcc <ScrolltextCnt>,d0
     7cc:	move.w d0,d1
     7ce:	addq.w #1,d1
     7d0:	move.w d1,30bcc <ScrolltextCnt>
     7d6:	andi.l #65535,d0
     7dc:	lea 44a3 <Scrolltext>,a0
     7e2:	move.b (0,a0,d0.l),d0
	ULONG source, dest;
	ULONG row, col;

	// Set standard char distance
	NextPlot = 32;
     7e6:	move.w #32,6b28 <NextPlot>
	// scroller commands: b=bounce; m=mirror; s=stop; c=color
	if (chr == 'b')
     7ee:	cmpi.b #98,d0
     7f2:	beq.w 946 <PlotChar+0x190>
		}
		BounceEnabled = !BounceEnabled;

		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'm')
     7f6:	cmpi.b #109,d0
     7fa:	beq.w 988 <PlotChar+0x1d2>
		}

		MirrorEnabled = !MirrorEnabled;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 's')
     7fe:	cmpi.b #115,d0
     802:	beq.w 9d0 <PlotChar+0x21a>
	{
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'c')
     806:	cmpi.b #99,d0
     80a:	beq.w a56 <PlotChar+0x2a0>
		colScrollMirror[0] = 0x6bf;
		colScrollMirror[1] = 0x49b;
		ResetCopper = TRUE;
	}
	// select character for different spacing
	if (chr == '!' || chr == 'I' || chr == '.' || chr == ',' || chr == ':' || chr == ';' || chr == '\'')
     80e:	cmpi.b #33,d0
     812:	beq.s 838 <PlotChar+0x82>
     814:	cmpi.b #73,d0
     818:	beq.s 838 <PlotChar+0x82>
     81a:	cmpi.b #46,d0
     81e:	beq.s 838 <PlotChar+0x82>
     820:	cmpi.b #44,d0
     824:	beq.s 838 <PlotChar+0x82>
     826:	cmpi.b #58,d0
     82a:	beq.s 838 <PlotChar+0x82>
     82c:	cmpi.b #59,d0
     830:	beq.s 838 <PlotChar+0x82>
     832:	cmpi.b #39,d0
     836:	bne.s 840 <PlotChar+0x8a>
	{
		NextPlot = 12;
     838:	move.w #12,6b28 <NextPlot>
	}
	if (chr == 'J')
     840:	cmpi.b #74,d0
     844:	beq.w a72 <PlotChar+0x2bc>
	{
		NextPlot = 24;
	}
	// check for end of text
	if (chr == 0)
     848:	tst.b d0
     84a:	bne.s 874 <PlotChar+0xbe>
	{
		ScrolltextCnt = 0;
     84c:	clr.w 30bcc <ScrolltextCnt>
		chr = Scrolltext[ScrolltextCnt++];
     852:	move.w #1,30bcc <ScrolltextCnt>
		colScrollMirror[0] = 0x111;
     85a:	move.w #273,6b2a <colScrollMirror>
		colScrollMirror[1] = 0x222;
     862:	move.w #546,6b2c <colScrollMirror+0x2>
		ResetCopper = TRUE;
     86a:	move.w #1,30be6 <ResetCopper>
		chr = Scrolltext[ScrolltextCnt++];
     872:	moveq #32,d0
	}
	// check legal values
	if (chr < 32 || chr > (32 + 80))
     874:	addi.b #-32,d0
     878:	cmpi.b #80,d0
     87c:	bhi.w 940 <PlotChar+0x18a>
		return;
	}
	// skip first 32 ascii codes
	chr -= 32;
	// get row and column of source bitmap (10 chrs per row)
	row = chr / 10;
     880:	andi.w #255,d0
     884:	move.w d0,d6
     886:	mulu.w #-13107,d6
     88a:	clr.w d6
     88c:	swap d6
     88e:	lsr.w #3,d6
	col = chr % 10;
     890:	move.w d6,d1
     892:	add.w d6,d1
     894:	add.w d1,d1
     896:	add.w d6,d1
     898:	add.w d1,d1
     89a:	sub.w d1,d0
     89c:	moveq #0,d2
     89e:	move.b d0,d2
	// calc source bitplane pointer
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     8a0:	moveq #0,d0
     8a2:	move.w 40(sp),d0
     8a6:	lea 2904 <__mulsi3>,a2
     8ac:	moveq #31,d1
     8ae:	and.l d6,d1
     8b0:	move.l d1,-(sp)
     8b2:	move.l d0,-(sp)
     8b4:	jsr (a2)
     8b6:	addq.l #8,sp
     8b8:	move.l d0,-(sp)
     8ba:	move.w d4,-(sp)
     8bc:	clr.w -(sp)
     8be:	jsr (a2)
     8c0:	addq.l #8,sp
     8c2:	add.l d2,d2
     8c4:	add.l d2,d2
     8c6:	add.l d0,d2
	// calc destination bitplane pointer
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     8c8:	moveq #0,d0
     8ca:	move.w 92(sp),d0
     8ce:	move.l d0,-(sp)
     8d0:	move.w d5,-(sp)
     8d2:	clr.w -(sp)
     8d4:	jsr (a2)
     8d6:	addq.l #8,sp
     8d8:	moveq #0,d5
     8da:	move.w 30dbc <Screen+0x6>,d5
     8e0:	add.l d0,d5
	// wait for blitter and blit
	WaitBlit();
     8e2:	movea.l 30dec <GfxBase>,a6
     8e8:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     8ec:	movea.l 30df6 <custom>,a0
     8f2:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     8f8:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     8fe:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     904:	move.w #-1,70(a0)
	custom->bltapt = ((UBYTE *)bmpFont.ImageData) + source;
     90a:	add.l 46(sp),d2
     90e:	move.l d2,80(a0)
	custom->bltdpt = ((UBYTE *)bmpDest.ImageData) + dest;
     912:	add.l 98(sp),d5
     916:	move.l d5,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     91a:	move.w d3,d0
     91c:	lsr.w #3,d0
     91e:	move.w 38(sp),d1
     922:	sub.w d0,d1
     924:	move.w d1,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     928:	move.w 90(sp),d1
     92c:	sub.w d0,d1
     92e:	move.w d1,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     932:	muls.w 36(sp),d4
     936:	lsl.w #6,d4
     938:	lsr.w #4,d3
     93a:	add.w d4,d3
     93c:	move.w d3,88(a0)
}
     940:	movem.l (sp)+,d2-d6/a2/a6
     944:	rts
		if (BounceEnabled)
     946:	move.w 30be4 <BounceEnabled>,d0
     94c:	beq.s 95c <PlotChar+0x1a6>
			ScrollerY = SCRT_MIN;
     94e:	clr.w 30be2 <ScrollerY>
			ScrollerDir = 1;
     954:	move.b #1,6b8e <ScrollerDir>
		BounceEnabled = !BounceEnabled;
     95c:	tst.w d0
     95e:	seq d0
     960:	ext.w d0
     962:	neg.w d0
     964:	move.w d0,30be4 <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     96a:	move.w d1,d0
     96c:	addq.w #1,d0
     96e:	move.w d0,30bcc <ScrolltextCnt>
     974:	andi.l #65535,d1
     97a:	lea 44a3 <Scrolltext>,a0
     980:	move.b (0,a0,d1.l),d0
     984:	bra.w 7f6 <PlotChar+0x40>
		if (MirrorEnabled)
     988:	tst.w 30bca <MirrorEnabled>
     98e:	beq.s 9ca <PlotChar+0x214>
			DisableMirrorEffect();
     990:	jsr 790 <DisableMirrorEffect>(pc)
		MirrorEnabled = !MirrorEnabled;
     994:	tst.w 30bca <MirrorEnabled>
     99a:	seq d0
     99c:	ext.w d0
     99e:	neg.w d0
     9a0:	move.w d0,30bca <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     9a6:	move.w 30bcc <ScrolltextCnt>,d0
     9ac:	move.w d0,d1
     9ae:	addq.w #1,d1
     9b0:	move.w d1,30bcc <ScrolltextCnt>
     9b6:	andi.l #65535,d0
     9bc:	lea 44a3 <Scrolltext>,a0
     9c2:	move.b (0,a0,d0.l),d0
     9c6:	bra.w 7fe <PlotChar+0x48>
			EnableMirrorEffect();
     9ca:	jsr 764 <EnableMirrorEffect>(pc)
     9ce:	bra.s 994 <PlotChar+0x1de>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     9d0:	tst.w 30be4 <BounceEnabled>
     9d6:	beq.s a28 <PlotChar+0x272>
     9d8:	move.w 30bcc <ScrolltextCnt>,d0
     9de:	move.w d0,d1
     9e0:	addq.w #1,d1
     9e2:	move.w d1,30bcc <ScrolltextCnt>
     9e8:	andi.l #65535,d0
     9ee:	lea 44a3 <Scrolltext>,a0
     9f4:	move.b (0,a0,d0.l),d0
     9f8:	ext.w d0
     9fa:	addi.w #-48,d0
     9fe:	move.w d0,30be0 <ScrollerPause>
		chr = Scrolltext[ScrolltextCnt++];
     a04:	move.w 30bcc <ScrolltextCnt>,d0
     a0a:	move.w d0,d1
     a0c:	addq.w #1,d1
     a0e:	move.w d1,30bcc <ScrolltextCnt>
     a14:	andi.l #65535,d0
     a1a:	lea 44a3 <Scrolltext>,a0
     a20:	move.b (0,a0,d0.l),d0
     a24:	bra.w 806 <PlotChar+0x50>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     a28:	move.w 30bcc <ScrolltextCnt>,d0
     a2e:	move.w d0,d1
     a30:	addq.w #1,d1
     a32:	move.w d1,30bcc <ScrolltextCnt>
     a38:	andi.l #65535,d0
     a3e:	lea 44a3 <Scrolltext>,a0
     a44:	move.b (0,a0,d0.l),d0
     a48:	ext.w d0
     a4a:	movea.w d0,a0
     a4c:	moveq #-48,d0
     a4e:	add.l a0,d0
     a50:	muls.w #50,d0
     a54:	bra.s 9fe <PlotChar+0x248>
		colScrollMirror[0] = 0x6bf;
     a56:	move.w #1727,6b2a <colScrollMirror>
		colScrollMirror[1] = 0x49b;
     a5e:	move.w #1179,6b2c <colScrollMirror+0x2>
		ResetCopper = TRUE;
     a66:	move.w #1,30be6 <ResetCopper>
     a6e:	bra.w 80e <PlotChar+0x58>
		NextPlot = 24;
     a72:	move.w #24,6b28 <NextPlot>
     a7a:	bra.w 848 <PlotChar+0x92>

00000a7e <Scrollit>:
{
     a7e:	movem.l d2-d7/a2/a6,-(sp)
     a82:	move.l 96(sp),d3
     a86:	move.l 100(sp),d4
	int BltOffs = startY * theDesc.Bplt;
     a8a:	moveq #0,d5
     a8c:	move.w 94(sp),d5
     a90:	moveq #0,d6
     a92:	move.w 44(sp),d6
     a96:	lea 2904 <__mulsi3>,a2
     a9c:	move.l d6,-(sp)
     a9e:	move.l d5,-(sp)
     aa0:	jsr (a2)
     aa2:	addq.l #8,sp
     aa4:	move.l d0,d2
	int Brcorner = height * theDesc.Bplt - 2;
     aa6:	move.l d6,-(sp)
     aa8:	move.w d3,-(sp)
     aaa:	clr.w -(sp)
     aac:	jsr (a2)
     aae:	addq.l #8,sp
     ab0:	move.l d0,d7
     ab2:	subq.l #2,d7
	WaitBlit();
     ab4:	movea.l 30dec <GfxBase>,a6
     aba:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     abe:	clr.w d6
     ac0:	move.b d4,d6
     ac2:	moveq #12,d0
     ac4:	lsl.w d0,d4
     ac6:	movea.l 30df6 <custom>,a0
     acc:	addi.w #2544,d4
     ad0:	move.w d4,64(a0)
	custom->bltcon1 = 0x0002;
     ad4:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     ada:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     ae0:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     ae6:	move.l d2,d0
     ae8:	add.l d7,d0
     aea:	add.l 88(sp),d0
     aee:	move.l d0,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     af2:	move.l d0,84(a0)
	custom->bltamod = 0;
     af6:	move.w #0,100(a0)
	custom->bltdmod = 0;
     afc:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
     b02:	move.w 40(sp),d0
     b06:	muls.w d3,d0
     b08:	lsl.w #6,d0
     b0a:	move.w 30c8a <BmpScroller>,d1
     b10:	lsr.w #4,d1
     b12:	add.w d1,d0
     b14:	move.w d0,88(a0)
	ScrollCnt += speed;
     b18:	add.w 30bce <ScrollCnt>,d6
     b1e:	move.w d6,30bce <ScrollCnt>
	if (ScrollCnt >= NextPlot)
     b24:	cmp.w 6b28 <NextPlot>,d6
     b2a:	bcc.s b32 <Scrollit+0xb4>
}
     b2c:	movem.l (sp)+,d2-d7/a2/a6
     b30:	rts
		ScrollCnt = 0;
     b32:	clr.w 30bce <ScrollCnt>
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
     b38:	pea 20 <_start+0x20>
     b3c:	pea 20 <_start+0x20>
     b40:	move.l d5,-(sp)
     b42:	subq.l #2,sp
     b44:	move.l 30cb8 <BmpScroller+0x2e>,-(sp)
     b4a:	move.l 30cb4 <BmpScroller+0x2a>,-(sp)
     b50:	move.l 30cb0 <BmpScroller+0x26>,-(sp)
     b56:	move.l 30cac <BmpScroller+0x22>,-(sp)
     b5c:	move.l 30ca8 <BmpScroller+0x1e>,-(sp)
     b62:	move.l 30ca4 <BmpScroller+0x1a>,-(sp)
     b68:	move.l 30ca0 <BmpScroller+0x16>,-(sp)
     b6e:	move.l 30c9c <BmpScroller+0x12>,-(sp)
     b74:	move.l 30c98 <BmpScroller+0xe>,-(sp)
     b7a:	move.l 30c94 <BmpScroller+0xa>,-(sp)
     b80:	move.l 30c90 <BmpScroller+0x6>,-(sp)
     b86:	move.l 30c8c <BmpScroller+0x2>,-(sp)
     b8c:	move.w 30c8a <BmpScroller>,-(sp)
     b92:	subq.l #2,sp
     b94:	move.l 30c86 <BmpFont32+0x2e>,-(sp)
     b9a:	move.l 30c82 <BmpFont32+0x2a>,-(sp)
     ba0:	move.l 30c7e <BmpFont32+0x26>,-(sp)
     ba6:	move.l 30c7a <BmpFont32+0x22>,-(sp)
     bac:	move.l 30c76 <BmpFont32+0x1e>,-(sp)
     bb2:	move.l 30c72 <BmpFont32+0x1a>,-(sp)
     bb8:	move.l 30c6e <BmpFont32+0x16>,-(sp)
     bbe:	move.l 30c6a <BmpFont32+0x12>,-(sp)
     bc4:	move.l 30c66 <BmpFont32+0xe>,-(sp)
     bca:	move.l 30c62 <BmpFont32+0xa>,-(sp)
     bd0:	move.l 30c5e <BmpFont32+0x6>,-(sp)
     bd6:	move.l 30c5a <BmpFont32+0x2>,-(sp)
     bdc:	move.w 30c58 <BmpFont32>,-(sp)
     be2:	jsr 7b6 <PlotChar>(pc)
     be6:	lea 116(sp),sp
     bea:	bra.w b2c <Scrollit+0xae>

00000bee <GetVBR>:

static APTR GetVBR()
{
     bee:	subq.l #8,sp
     bf0:	move.l a6,-(sp)
     bf2:	move.l d7,-(sp)
	APTR vbr = 0;
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     bf4:	move.w #20090,10(sp)
     bfa:	move.w #2049,12(sp)
     c00:	move.w #20083,14(sp)

	if (SysBase->AttnFlags & AFF_68010)
     c06:	movea.l 30df0 <SysBase>,a6
     c0c:	btst #0,297(a6)
     c12:	beq.s c28 <GetVBR+0x3a>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     c14:	moveq #10,d7
     c16:	add.l sp,d7
     c18:	exg d7,a5
     c1a:	jsr -30(a6)
     c1e:	exg d7,a5

	return vbr;
}
     c20:	move.l (sp)+,d7
     c22:	movea.l (sp)+,a6
     c24:	addq.l #8,sp
     c26:	rts
	APTR vbr = 0;
     c28:	moveq #0,d0
	return vbr;
     c2a:	bra.s c20 <GetVBR+0x32>

00000c2c <SetInterruptHandler>:

void SetInterruptHandler(APTR interrupt)
{
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     c2c:	movea.l 30bc6 <VBR>,a0
     c32:	move.l 4(sp),108(a0)
}
     c38:	rts

00000c3a <GetInterruptHandler>:

APTR GetInterruptHandler()
{
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     c3a:	movea.l 30bc6 <VBR>,a0
     c40:	move.l 108(a0),d0
}
     c44:	rts

00000c46 <WaitVbl>:

//vblank begins at vpos 312 hpos 1 and ends at vpos 25 hpos 1
//vsync begins at line 2 hpos 132 and ends at vpos 5 hpos 18
void WaitVbl()
{
     c46:	subq.l #8,sp
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     c48:	move.l dff004 <_end+0xdce208>,d0
     c4e:	move.l d0,(sp)
		vpos &= 0x1ff00;
     c50:	move.l (sp),d0
     c52:	andi.l #130816,d0
     c58:	move.l d0,(sp)
		if (vpos != (311 << 8))
     c5a:	move.l (sp),d0
     c5c:	cmpi.l #79616,d0
     c62:	beq.s c48 <WaitVbl+0x2>
			break;
	}
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     c64:	move.l dff004 <_end+0xdce208>,d0
     c6a:	move.l d0,4(sp)
		vpos &= 0x1ff00;
     c6e:	move.l 4(sp),d0
     c72:	andi.l #130816,d0
     c78:	move.l d0,4(sp)
		if (vpos == (311 << 8))
     c7c:	move.l 4(sp),d0
     c80:	cmpi.l #79616,d0
     c86:	bne.s c64 <WaitVbl+0x1e>
			break;
	}
}
     c88:	addq.l #8,sp
     c8a:	rts

00000c8c <TakeSystem>:
	{
	} //blitter busy wait
}

void TakeSystem()
{
     c8c:	move.l a6,-(sp)
     c8e:	move.l a2,-(sp)
	ActiView = GfxBase->ActiView; //store current view
     c90:	movea.l 30dec <GfxBase>,a6
     c96:	move.l 34(a6),30bc2 <ActiView>
	OwnBlitter();
     c9e:	jsr -456(a6)
	WaitBlit();
     ca2:	movea.l 30dec <GfxBase>,a6
     ca8:	jsr -228(a6)
	Disable();
     cac:	movea.l 30df0 <SysBase>,a6
     cb2:	jsr -120(a6)

	//Save current interrupts and DMA settings so we can restore them upon exit.
	SystemADKCON = custom->adkconr;
     cb6:	movea.l 30df6 <custom>,a0
     cbc:	move.w 16(a0),d0
     cc0:	move.w d0,30bc0 <SystemADKCON>
	SystemInts = custom->intenar;
     cc6:	move.w 28(a0),d0
     cca:	move.w d0,30bbe <SystemInts>
	SystemDMA = custom->dmaconr;
     cd0:	move.w 2(a0),d0
     cd4:	move.w d0,30bbc <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     cda:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     ce0:	move.w #32767,156(a0)

	WaitVbl();
     ce6:	lea c46 <WaitVbl>(pc),a2
     cea:	jsr (a2)
	WaitVbl();
     cec:	jsr (a2)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     cee:	movea.l 30df6 <custom>,a0
     cf4:	move.w #32767,150(a0)

	//set all colors black
	for (int a = 0; a < 32; a++)
     cfa:	moveq #0,d1
     cfc:	bra.s d10 <TakeSystem+0x84>
		custom->color[a] = 0;
     cfe:	move.l d1,d0
     d00:	addi.l #192,d0
     d06:	add.l d0,d0
     d08:	move.w #0,(0,a0,d0.l)
	for (int a = 0; a < 32; a++)
     d0e:	addq.l #1,d1
     d10:	moveq #31,d0
     d12:	cmp.l d1,d0
     d14:	bge.s cfe <TakeSystem+0x72>

	LoadView(0);
     d16:	movea.l 30dec <GfxBase>,a6
     d1c:	suba.l a1,a1
     d1e:	jsr -222(a6)
	WaitTOF();
     d22:	movea.l 30dec <GfxBase>,a6
     d28:	jsr -270(a6)
	WaitTOF();
     d2c:	movea.l 30dec <GfxBase>,a6
     d32:	jsr -270(a6)

	WaitVbl();
     d36:	lea c46 <WaitVbl>(pc),a2
     d3a:	jsr (a2)
	WaitVbl();
     d3c:	jsr (a2)

	VBR = GetVBR();
     d3e:	jsr bee <GetVBR>(pc)
     d42:	move.l d0,30bc6 <VBR>
	SystemIrq = GetInterruptHandler(); //store interrupt register
     d48:	jsr c3a <GetInterruptHandler>(pc)
     d4c:	move.l d0,30bb8 <SystemIrq>
}
     d52:	movea.l (sp)+,a2
     d54:	movea.l (sp)+,a6
     d56:	rts

00000d58 <FreeSystem>:

void FreeSystem()
{
     d58:	move.l a6,-(sp)
	WaitVbl();
     d5a:	jsr c46 <WaitVbl>(pc)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     d5e:	movea.l 30df6 <custom>,a0
     d64:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     d68:	move.w 2(a0),d0
     d6c:	btst #14,d0
     d70:	bne.s d68 <FreeSystem+0x10>
	WaitBlt();
	custom->intena = 0x7fff; //disable all interrupts
     d72:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     d78:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     d7e:	move.w #32767,150(a0)

	//restore interrupts
	SetInterruptHandler(SystemIrq);
     d84:	move.l 30bb8 <SystemIrq>,-(sp)
     d8a:	jsr c2c <SetInterruptHandler>(pc)

	/*Restore system copper list(s). */
	custom->cop1lc = (ULONG)GfxBase->copinit;
     d8e:	movea.l 30dec <GfxBase>,a6
     d94:	movea.l 30df6 <custom>,a0
     d9a:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     da0:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     da6:	move.w #32767,136(a0)

	/*Restore all interrupts and DMA settings. */
	custom->intena = SystemInts | 0x8000;
     dac:	move.w 30bbe <SystemInts>,d0
     db2:	ori.w #-32768,d0
     db6:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     dba:	move.w 30bbc <SystemDMA>,d0
     dc0:	ori.w #-32768,d0
     dc4:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     dc8:	move.w 30bc0 <SystemADKCON>,d0
     dce:	ori.w #-32768,d0
     dd2:	move.w d0,158(a0)

	LoadView(ActiView);
     dd6:	movea.l 30bc2 <ActiView>,a1
     ddc:	jsr -222(a6)
	WaitTOF();
     de0:	movea.l 30dec <GfxBase>,a6
     de6:	jsr -270(a6)
	WaitTOF();
     dea:	movea.l 30dec <GfxBase>,a6
     df0:	jsr -270(a6)
	WaitBlit();
     df4:	movea.l 30dec <GfxBase>,a6
     dfa:	jsr -228(a6)
	DisownBlitter();
     dfe:	movea.l 30dec <GfxBase>,a6
     e04:	jsr -462(a6)
	Enable();
     e08:	movea.l 30df0 <SysBase>,a6
     e0e:	jsr -126(a6)
     e12:	addq.l #4,sp
}
     e14:	movea.l (sp)+,a6
     e16:	rts

00000e18 <InitImagePlanes>:

void InitImagePlanes(BmpDescriptor *img, USHORT offs)
{
     e18:	movem.l d2-d4/a2,-(sp)
     e1c:	movea.l 20(sp),a2
     e20:	move.w 26(sp),d4
	for (int p = 0; p < img->Bpls; p++)
     e24:	moveq #0,d2
     e26:	bra.s e52 <InitImagePlanes+0x3a>
	{
		img->Planes[p] = ((UBYTE *)img->ImageData) + offs + (p * (img->Bpl));
     e28:	move.l 14(a2),d3
     e2c:	moveq #0,d0
     e2e:	move.w 6(a2),d0
     e32:	move.l d2,-(sp)
     e34:	move.l d0,-(sp)
     e36:	jsr 2904 <__mulsi3>
     e3c:	addq.l #8,sp
     e3e:	moveq #0,d1
     e40:	move.w d4,d1
     e42:	add.l d1,d0
     e44:	move.l d2,d1
     e46:	add.l d2,d1
     e48:	add.l d1,d1
     e4a:	add.l d0,d3
     e4c:	move.l d3,(18,a2,d1.l)
	for (int p = 0; p < img->Bpls; p++)
     e50:	addq.l #1,d2
     e52:	moveq #0,d0
     e54:	move.w 4(a2),d0
     e58:	cmp.l d0,d2
     e5a:	blt.s e28 <InitImagePlanes+0x10>
	}
}
     e5c:	movem.l (sp)+,d2-d4/a2
     e60:	rts

00000e62 <CopyBitmap>:
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     e62:	movea.l 30df6 <custom>,a0
     e68:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     e6c:	move.w 2(a0),d0
     e70:	btst #14,d0
     e74:	bne.s e6c <CopyBitmap+0xa>

void CopyBitmap(BmpDescriptor bmpS, BmpDescriptor bmpD)
{
	WaitBlt();

	custom->bltcon0 = 0x09f0;
     e76:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     e7c:	move.w #0,66(a0)
	custom->bltapt = (UBYTE *)bmpS.ImageData;
     e82:	move.l 18(sp),80(a0)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
     e88:	move.l 70(sp),84(a0)
	custom->bltafwm = 0xffff;
     e8e:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     e94:	move.w #-1,70(a0)
	custom->bltamod = 0;
     e9a:	move.w #0,100(a0)
	custom->bltdmod = 0;
     ea0:	move.w #0,102(a0)
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
     ea6:	move.w 6(sp),d1
     eaa:	muls.w 8(sp),d1
     eae:	lsl.w #6,d1
     eb0:	move.w 10(sp),d0
     eb4:	lsr.w #1,d0
     eb6:	add.w d1,d0
     eb8:	move.w d0,88(a0)
}
     ebc:	rts

00000ebe <ClearBitmapPart>:
	custom->bltdmod = 0;
	custom->bltsize = ((lines * bmpD.Bpls) << 6) + (bmpD.Width / 16);
}

void ClearBitmapPart(BmpDescriptor bmp, int x, int y, int height, int width)
{
     ebe:	movem.l d2-d5/a2-a3,-(sp)
     ec2:	move.l 80(sp),d5
     ec6:	movea.l 92(sp),a3
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     eca:	movea.l 30df6 <custom>,a2
     ed0:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     ed4:	move.w 2(a2),d0
     ed8:	btst #14,d0
     edc:	bne.s ed4 <ClearBitmapPart+0x16>
	WaitBlt();
	BYTE shift = x % 16;
     ede:	move.l d5,d2
     ee0:	andi.l #-2147483633,d2
     ee6:	tst.l d5
     ee8:	blt.w f84 <ClearBitmapPart+0xc6>
	if (shift)
     eec:	tst.b d2
     eee:	beq.s ef4 <ClearBitmapPart+0x36>
		width += 16;
     ef0:	lea 16(a3),a3
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
     ef4:	move.b d2,d0
     ef6:	ext.w d0
     ef8:	move.w d0,d4
     efa:	ext.l d4
     efc:	move.l d4,d1
     efe:	moveq #12,d3
     f00:	lsl.l d3,d1
     f02:	ori.w #2304,d1
     f06:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
     f0a:	moveq #12,d1
     f0c:	lsl.w d1,d0
     f0e:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     f12:	move.l 42(sp),d3
     f16:	moveq #0,d0
     f18:	move.w 36(sp),d0
     f1c:	move.l 84(sp),-(sp)
     f20:	move.l d0,-(sp)
     f22:	jsr 2904 <__mulsi3>
     f28:	addq.l #8,sp
     f2a:	move.l d5,d1
     f2c:	bmi.s f90 <ClearBitmapPart+0xd2>
     f2e:	asr.l #3,d1
     f30:	add.l d1,d0
     f32:	add.l d3,d0
     f34:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     f38:	move.l d0,84(a2)
	custom->bltafwm = 0xffff;
     f3c:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     f42:	tst.b d2
     f44:	beq.s f94 <ClearBitmapPart+0xd6>
     f46:	moveq #15,d1
     f48:	sub.l d4,d1
     f4a:	moveq #0,d0
     f4c:	not.w d0
     f4e:	asr.l d1,d0
     f50:	move.w d0,70(a2)
	;
	custom->bltamod = bmp.Bpl - (width / 8);
     f54:	move.w 34(sp),d0
     f58:	move.l a3,d1
     f5a:	bmi.s f98 <ClearBitmapPart+0xda>
     f5c:	asr.l #3,d1
     f5e:	sub.w d1,d0
     f60:	move.w d0,100(a2)
	custom->bltdmod = bmp.Bpl - (width / 8);
     f64:	move.w d0,102(a2)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     f68:	move.w 32(sp),d0
     f6c:	muls.w 90(sp),d0
     f70:	lsl.w #6,d0
     f72:	move.l a3,d1
     f74:	bmi.s f9c <ClearBitmapPart+0xde>
     f76:	asr.l #4,d1
     f78:	add.w d1,d0
     f7a:	move.w d0,88(a2)
}
     f7e:	movem.l (sp)+,d2-d5/a2-a3
     f82:	rts
	BYTE shift = x % 16;
     f84:	subq.l #1,d2
     f86:	moveq #-16,d0
     f88:	or.l d0,d2
     f8a:	addq.l #1,d2
     f8c:	bra.w eec <ClearBitmapPart+0x2e>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     f90:	addq.l #7,d1
     f92:	bra.s f2e <ClearBitmapPart+0x70>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
     f94:	moveq #-1,d0
     f96:	bra.s f50 <ClearBitmapPart+0x92>
	custom->bltamod = bmp.Bpl - (width / 8);
     f98:	addq.l #7,d1
     f9a:	bra.s f5c <ClearBitmapPart+0x9e>
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
     f9c:	moveq #15,d1
     f9e:	add.l a3,d1
     fa0:	bra.s f76 <ClearBitmapPart+0xb8>

00000fa2 <SimpleBlit>:

void SimpleBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
     fa2:	movem.l d2-d7/a2,-(sp)
     fa6:	move.l 136(sp),d7
     faa:	move.l 140(sp),d1
     fae:	move.l 144(sp),d4
     fb2:	move.l 148(sp),d5
     fb6:	move.l 152(sp),d3
     fba:	move.l 156(sp),d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     fbe:	movea.l 30df6 <custom>,a2
     fc4:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     fc8:	move.w 2(a2),d0
     fcc:	btst #14,d0
     fd0:	bne.s fc8 <SimpleBlit+0x26>
	WaitBlt();
	custom->bltcon0 = 0x09f0;
     fd2:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
     fd8:	move.w #0,66(a2)
	custom->bltafwm = 0xffff;
     fde:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
     fe4:	move.w #-1,70(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
     fea:	move.w d2,d0
     fec:	lsr.w #3,d0
     fee:	movea.w 38(sp),a0
     ff2:	suba.w d0,a0
     ff4:	move.w a0,100(a2)
	custom->bltdmod = imgD.Bpl - (width / 8);
     ff8:	movea.w 90(sp),a0
     ffc:	suba.w d0,a0
     ffe:	move.w a0,102(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1002:	move.l 46(sp),d6
    1006:	moveq #0,d0
    1008:	move.w 40(sp),d0
    100c:	move.l d0,-(sp)
    100e:	move.l d1,-(sp)
    1010:	jsr 2904 <__mulsi3>
    1016:	addq.l #8,sp
    1018:	move.l d7,d1
    101a:	bmi.s 105e <SimpleBlit+0xbc>
    101c:	asr.l #3,d1
    101e:	add.l d1,d0
    1020:	add.l d6,d0
    1022:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1026:	move.l 98(sp),d6
    102a:	moveq #0,d0
    102c:	move.w 92(sp),d0
    1030:	move.l d0,-(sp)
    1032:	move.l d5,-(sp)
    1034:	jsr 2904 <__mulsi3>
    103a:	addq.l #8,sp
    103c:	move.l d4,d1
    103e:	bmi.s 1062 <SimpleBlit+0xc0>
    1040:	asr.l #3,d1
    1042:	add.l d1,d0
    1044:	add.l d6,d0
    1046:	move.l d0,84(a2)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
    104a:	muls.w 36(sp),d3
    104e:	lsl.w #6,d3
    1050:	lsr.w #4,d2
    1052:	add.w d3,d2
    1054:	move.w d2,88(a2)
}
    1058:	movem.l (sp)+,d2-d7/a2
    105c:	rts
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    105e:	addq.l #7,d1
    1060:	bra.s 101c <SimpleBlit+0x7a>
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1062:	addq.l #7,d1
    1064:	bra.s 1040 <SimpleBlit+0x9e>

00001066 <BetterBlit>:

void BetterBlit(BmpDescriptor imgS, BmpDescriptor imgD, BmpDescriptor imgM, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    1066:	movem.l d2-d7/a2-a6,-(sp)
    106a:	movea.l 204(sp),a3
    106e:	move.l 208(sp),d7
    1072:	move.l 212(sp),d5
    1076:	movea.l 216(sp),a5
    107a:	movea.l 220(sp),a4
    107e:	move.l 224(sp),d1
    1082:	move.w d1,d4
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1084:	movea.l 30df6 <custom>,a2
    108a:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    108e:	move.w 2(a2),d0
    1092:	btst #14,d0
    1096:	bne.s 108e <BetterBlit+0x28>
	WaitBlt();
	BYTE shift = startD.X % 16;
    1098:	move.l d5,d3
    109a:	andi.l #-2147483633,d3
    10a0:	tst.l d5
    10a2:	blt.w 1196 <BetterBlit+0x130>
	if (shift)
    10a6:	tst.b d3
    10a8:	beq.s 10b0 <BetterBlit+0x4a>
		width += 16;
    10aa:	move.w d1,d4
    10ac:	addi.w #16,d4

	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    10b0:	move.b d3,d0
    10b2:	ext.w d0
    10b4:	movea.w d0,a6
    10b6:	move.l a6,d1
    10b8:	moveq #12,d2
    10ba:	lsl.l d2,d1
    10bc:	ori.w #4042,d1
    10c0:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    10c4:	moveq #12,d1
    10c6:	lsl.w d1,d0
    10c8:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    10cc:	move.l 62(sp),d6
    10d0:	moveq #0,d0
    10d2:	move.w 56(sp),d0
    10d6:	move.l d0,-(sp)
    10d8:	move.l d7,-(sp)
    10da:	jsr 2904 <__mulsi3>
    10e0:	addq.l #8,sp
    10e2:	move.l a3,d2
    10e4:	bmi.w 11a2 <BetterBlit+0x13c>
    10e8:	asr.l #3,d2
    10ea:	add.l d2,d0
    10ec:	add.l d6,d0
    10ee:	move.l d0,80(a2)
	custom->bltamod = imgS.Bpl - (width / 8);
    10f2:	move.w d4,d6
    10f4:	lsr.w #3,d6
    10f6:	move.w 54(sp),d0
    10fa:	sub.w d6,d0
    10fc:	move.w d0,100(a2)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1100:	moveq #0,d0
    1102:	move.w 160(sp),d0
    1106:	lea 2904 <__mulsi3>,a3
    110c:	move.l d0,-(sp)
    110e:	move.l d7,-(sp)
    1110:	jsr (a3)
    1112:	addq.l #8,sp
    1114:	add.l d0,d2
    1116:	add.l 166(sp),d2
    111a:	move.l d2,76(a2)
	custom->bltbmod = imgM.Bpl - (width / 8);
    111e:	move.w 158(sp),d0
    1122:	sub.w d6,d0
    1124:	move.w d0,98(a2)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1128:	move.l 114(sp),d2
    112c:	moveq #0,d0
    112e:	move.w 108(sp),d0
    1132:	move.l d0,-(sp)
    1134:	move.l a5,-(sp)
    1136:	jsr (a3)
    1138:	addq.l #8,sp
    113a:	move.l d5,d1
    113c:	bmi.s 11a8 <BetterBlit+0x142>
    113e:	asr.l #3,d1
    1140:	add.l d1,d0
    1142:	add.l d2,d0
    1144:	move.l d0,84(a2)
    1148:	move.l d0,72(a2)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    114c:	move.w 106(sp),d0
    1150:	sub.w d6,d0
    1152:	move.w d0,102(a2)
    1156:	move.w d0,96(a2)
	custom->bltafwm = 0xffff;
    115a:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1160:	tst.b d3
    1162:	beq.s 11ac <BetterBlit+0x146>
    1164:	moveq #15,d1
    1166:	sub.l a6,d1
    1168:	moveq #0,d0
    116a:	not.w d0
    116c:	asr.l d1,d0
    116e:	move.w d0,70(a2)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1172:	moveq #0,d0
    1174:	move.w 52(sp),d0
    1178:	move.l d0,-(sp)
    117a:	move.w a4,-(sp)
    117c:	clr.w -(sp)
    117e:	jsr 2904 <__mulsi3>
    1184:	addq.l #8,sp
    1186:	lsl.l #6,d0
    1188:	lsr.w #4,d4
    118a:	or.w d0,d4
    118c:	move.w d4,88(a2)
}
    1190:	movem.l (sp)+,d2-d7/a2-a6
    1194:	rts
	BYTE shift = startD.X % 16;
    1196:	subq.l #1,d3
    1198:	moveq #-16,d0
    119a:	or.l d0,d3
    119c:	addq.l #1,d3
    119e:	bra.w 10a6 <BetterBlit+0x40>
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    11a2:	addq.l #7,d2
    11a4:	bra.w 10e8 <BetterBlit+0x82>
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    11a8:	addq.l #7,d1
    11aa:	bra.s 113e <BetterBlit+0xd8>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    11ac:	moveq #-1,d0
    11ae:	bra.s 116e <BetterBlit+0x108>

000011b0 <p61Init>:

int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
    11b0:	move.l a3,-(sp)
    11b2:	move.l a2,-(sp)
	register volatile const void *_a0 ASM("a0") = module;
    11b4:	movea.l 12(sp),a0
	register volatile const void *_a1 ASM("a1") = NULL;
    11b8:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
    11ba:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
    11bc:	lea 2ae2 <incbin_P61_Player_start>,a3
	register int _d0 ASM("d0"); // return value
	__asm volatile(
    11c2:	movem.l d1-d7/a4-a6,-(sp)
    11c6:	jsr (a3)
    11c8:	movem.l (sp)+,d1-d7/a4-a6
		"movem.l (%%sp)+,%%d1-%%d7/%%a4-%%a6"
		: "=r"(_d0), "+rf"(_a0), "+rf"(_a1), "+rf"(_a2), "+rf"(_a3)
		:
		: "cc", "memory");
	return _d0;
}
    11cc:	movea.l (sp)+,a2
    11ce:	movea.l (sp)+,a3
    11d0:	rts

000011d2 <p61Music>:

void p61Music()
{
    11d2:	move.l a6,-(sp)
    11d4:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    11d6:	lea 2ae2 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    11dc:	movea.l #14675968,a6
	__asm volatile(
    11e2:	movem.l d0-a2/a4-a5,-(sp)
    11e6:	jsr 4(a3)
    11ea:	movem.l (sp)+,d0-a2/a4-a5
		"jsr 4(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d7/%%a0-%%a2/%%a4-%%a5"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    11ee:	movea.l (sp)+,a3
    11f0:	movea.l (sp)+,a6
    11f2:	rts

000011f4 <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);
// interrupt handler
static __attribute__((interrupt)) void interruptHandler()
{
    11f4:	movem.l d0-d1/a0-a1,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    11f8:	movea.l 30df6 <custom>,a0
    11fe:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    1204:	move.w #32,156(a0)

    // DEMO - ThePlayer
    p61Music();
    120a:	jsr 11d2 <p61Music>(pc)

    // DEMO - increment frameCounter
    frameCounter++;
    120e:	move.w 30df4 <frameCounter>,d0
    1214:	addq.w #1,d0
    1216:	move.w d0,30df4 <frameCounter>
}
    121c:	movem.l (sp)+,d0-d1/a0-a1
    1220:	rte

00001222 <p61End>:

void p61End()
{
    1222:	move.l a6,-(sp)
    1224:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    1226:	lea 2ae2 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    122c:	movea.l #14675968,a6
	__asm volatile(
    1232:	movem.l d0-d1/a0-a1,-(sp)
    1236:	jsr 8(a3)
    123a:	movem.l (sp)+,d0-d1/a0-a1
		"jsr 8(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d1/%%a0-%%a1"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    123e:	movea.l (sp)+,a3
    1240:	movea.l (sp)+,a6
    1242:	rts

00001244 <BitmapInit>:

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{
    1244:	move.l d3,-(sp)
    1246:	move.l d2,-(sp)
    1248:	movea.l 12(sp),a0
    124c:	move.l 16(sp),d0
    1250:	move.l 20(sp),d2
    1254:	move.l 24(sp),d1

	bmp->Width = w;
    1258:	move.w d0,(a0)
	bmp->Height = h;
    125a:	move.w d2,2(a0)
	bmp->Bpls = bpls;
    125e:	move.w d1,4(a0)
	bmp->Bpl = w / 8;
    1262:	lsr.w #3,d0
    1264:	move.w d0,6(a0)
	bmp->Bplt = w / 8 * bpls;
    1268:	move.w d0,d3
    126a:	muls.w d1,d3
    126c:	move.w d3,8(a0)
	bmp->Btot = w / 8 * h * bpls;
    1270:	muls.w d2,d0
    1272:	muls.w d1,d0
    1274:	move.w d0,12(a0)
}
    1278:	move.l (sp)+,d2
    127a:	move.l (sp)+,d3
    127c:	rts

0000127e <InitStarfieldSprite>:

void InitStarfieldSprite()
{
    127e:	movem.l d2-d7/a2-a3,-(sp)
	short line = 0;
	USHORT hpos = 3;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 31; l++)
    1282:	moveq #0,d5
	BYTE vpos = 0x2c;
    1284:	moveq #44,d3
	USHORT hpos = 3;
    1286:	movea.w #3,a1
	short line = 0;
    128a:	clr.w d2
    128c:	bra.w 13c6 <InitStarfieldSprite+0x148>
	{
		hpos = (7 * hpos) % 255;
    1290:	moveq #0,d0
    1292:	move.w a1,d0
    1294:	move.l d0,d1
    1296:	lsl.l #3,d1
    1298:	lea 29ac <__modsi3>,a3
    129e:	pea ff <MoveBobs+0x73>
    12a2:	sub.l d0,d1
    12a4:	move.l d1,-(sp)
    12a6:	jsr (a3)
    12a8:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    12aa:	move.b d3,d1
    12ac:	ext.w d1
    12ae:	move.w d1,d4
    12b0:	ext.l d4
    12b2:	lsl.l #8,d4
    12b4:	move.w d0,d6
    12b6:	andi.w #255,d6
    12ba:	movea.w d2,a0
    12bc:	addq.w #1,a0
    12be:	movea.w d2,a1
    12c0:	lea 308cc <StarSprite>,a2
    12c6:	adda.l a1,a1
    12c8:	or.w d4,d6
    12ca:	move.w d6,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    12ce:	addq.w #1,d1
    12d0:	movea.w d2,a1
    12d2:	addq.w #2,a1
    12d4:	movea.w a0,a0
    12d6:	lsl.w #8,d1
    12d8:	adda.l a0,a0
    12da:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-1
    12de:	movea.w d2,a0
    12e0:	addq.w #3,a0
    12e2:	movea.w a1,a1
    12e4:	adda.l a1,a1
    12e6:	move.w #-32768,(0,a1,a2.l)
		StarSprite[line++] = 0x0000;					  //color-1
    12ec:	move.w d2,d6
    12ee:	addq.w #4,d6
    12f0:	movea.w a0,a0
    12f2:	adda.l a0,a0
    12f4:	clr.w (0,a0,a2.l)
		vpos += 2;
    12f8:	move.b d3,d4
    12fa:	addq.b #2,d4

		hpos = (7 * hpos) % 255;
    12fc:	andi.l #65535,d0
    1302:	move.l d0,d1
    1304:	lsl.l #3,d1
    1306:	pea ff <MoveBobs+0x73>
    130a:	sub.l d0,d1
    130c:	move.l d1,-(sp)
    130e:	jsr (a3)
    1310:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    1312:	move.b d4,d1
    1314:	ext.w d1
    1316:	move.w d1,d4
    1318:	ext.l d4
    131a:	lsl.l #8,d4
    131c:	move.w d0,d7
    131e:	andi.w #255,d7
    1322:	movea.w d2,a0
    1324:	addq.w #5,a0
    1326:	movea.w d6,a1
    1328:	adda.l a1,a1
    132a:	or.w d4,d7
    132c:	move.w d7,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    1330:	addq.w #1,d1
    1332:	movea.w d2,a1
    1334:	addq.w #6,a1
    1336:	movea.w a0,a0
    1338:	lsl.w #8,d1
    133a:	adda.l a0,a0
    133c:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x0000;					  //color-2
    1340:	movea.w d2,a0
    1342:	addq.w #7,a0
    1344:	movea.w a1,a1
    1346:	adda.l a1,a1
    1348:	clr.w (0,a1,a2.l)
		StarSprite[line++] = 0x8000;					  //color-2
    134c:	addq.w #4,d6
    134e:	movea.w a0,a0
    1350:	adda.l a0,a0
    1352:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    1358:	move.b d3,d4
    135a:	addq.b #4,d4

		hpos = (7 * hpos) % 255;
    135c:	andi.l #65535,d0
    1362:	move.l d0,d1
    1364:	lsl.l #3,d1
    1366:	pea ff <MoveBobs+0x73>
    136a:	sub.l d0,d1
    136c:	move.l d1,-(sp)
    136e:	jsr (a3)
    1370:	addq.l #8,sp
    1372:	movea.w d0,a1
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    1374:	move.b d4,d1
    1376:	ext.w d1
    1378:	move.w d1,d4
    137a:	ext.l d4
    137c:	lsl.l #8,d4
    137e:	andi.w #255,d0
    1382:	movea.w d2,a3
    1384:	lea 9(a3),a3
    1388:	movea.w d6,a0
    138a:	adda.l a0,a0
    138c:	or.w d4,d0
    138e:	move.w d0,(0,a2,a0.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    1392:	addq.w #1,d1
    1394:	movea.w d2,a0
    1396:	lea 10(a0),a0
    139a:	movea.w a3,a3
    139c:	lsl.w #8,d1
    139e:	adda.l a3,a3
    13a0:	move.w d1,(0,a3,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    13a4:	movea.w a0,a0
    13a6:	adda.l a0,a0
    13a8:	move.w #-32768,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    13ae:	movea.w d2,a0
    13b0:	lea 11(a0),a0
    13b4:	movea.w a0,a0
    13b6:	addi.w #12,d2
    13ba:	adda.l a0,a0
    13bc:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    13c2:	addq.b #6,d3
	for (int l = 0; l < 31; l++)
    13c4:	addq.l #1,d5
    13c6:	moveq #30,d0
    13c8:	cmp.l d5,d0
    13ca:	bge.w 1290 <InitStarfieldSprite+0x12>
	}
	// sprite end-mark
	StarSprite[line++] = 0;
    13ce:	move.w d2,d0
    13d0:	addq.w #1,d0
    13d2:	ext.l d2
    13d4:	lea 308cc <StarSprite>,a1
    13da:	add.l d2,d2
    13dc:	clr.w (0,a1,d2.l)
	StarSprite[line++] = 0;
    13e0:	movea.w d0,a0
    13e2:	adda.l a0,a0
    13e4:	clr.w (0,a0,a1.l)
}
    13e8:	movem.l (sp)+,d2-d7/a2-a3
    13ec:	rts

000013ee <MoveStarfield>:

void MoveStarfield()
{
	for (int l = 1; l < 31 * 24; l += 24)
    13ee:	movea.w #1,a0
    13f2:	bra.s 1422 <MoveStarfield+0x34>
	{
		((volatile UBYTE *)StarSprite)[l] += 1;
    13f4:	movea.l a0,a1
    13f6:	adda.l #198860,a1
    13fc:	move.b (a1),d0
    13fe:	addq.b #1,d0
    1400:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 8] += 2;
    1402:	movea.l a0,a1
    1404:	adda.l #198868,a1
    140a:	move.b (a1),d0
    140c:	addq.b #2,d0
    140e:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 16] += 3;
    1410:	movea.l a0,a1
    1412:	adda.l #198876,a1
    1418:	move.b (a1),d0
    141a:	addq.b #3,d0
    141c:	move.b d0,(a1)
	for (int l = 1; l < 31 * 24; l += 24)
    141e:	lea 24(a0),a0
    1422:	cmpa.w #743,a0
    1426:	ble.s 13f4 <MoveStarfield+0x6>
	}
}
    1428:	rts

0000142a <BuildLogo>:

void BuildLogo(BmpDescriptor d)
{
    142a:	move.l d3,-(sp)
    142c:	move.l d2,-(sp)
	Point2D ps;
	Point2D pd;

	if (LogoShowY1 <= 128)
    142e:	move.w 30bec <LogoShowY1>,d0
    1434:	cmpi.w #128,d0
    1438:	ble.s 144e <BuildLogo+0x24>
		pd.X = 32;
		pd.Y = LogoShowY1;
		SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
		LogoShowY1 += 2;
	}
	else if (LogoShowY2 <= 129)
    143a:	move.w 6bb4 <LogoShowY2>,d0
    1440:	cmpi.w #129,d0
    1444:	ble.w 1500 <BuildLogo+0xd6>
		pd.X = 32;
		pd.Y = LogoShowY2;
		SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
		LogoShowY2 += 2;
	}
}
    1448:	move.l (sp)+,d2
    144a:	move.l (sp)+,d3
    144c:	rts
		ps.X = 0;
    144e:	clr.l d2
    1450:	clr.l d3
		ps.Y = LogoShowY1;
    1452:	movea.w d0,a0
		pd.X = 32;
    1454:	moveq #32,d0
    1456:	clr.l d1
		SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1458:	pea 100 <MoveBobs+0x74>
    145c:	pea 1 <_start+0x1>
    1460:	move.l a0,-(sp)
    1462:	move.l d0,-(sp)
    1464:	move.l a0,-(sp)
    1466:	move.l d2,-(sp)
    1468:	subq.l #2,sp
    146a:	move.l 30d4e <BmpUpperPart_PF1+0x2e>,-(sp)
    1470:	move.l 30d4a <BmpUpperPart_PF1+0x2a>,-(sp)
    1476:	move.l 30d46 <BmpUpperPart_PF1+0x26>,-(sp)
    147c:	move.l 30d42 <BmpUpperPart_PF1+0x22>,-(sp)
    1482:	move.l 30d3e <BmpUpperPart_PF1+0x1e>,-(sp)
    1488:	move.l 30d3a <BmpUpperPart_PF1+0x1a>,-(sp)
    148e:	move.l 30d36 <BmpUpperPart_PF1+0x16>,-(sp)
    1494:	move.l 30d32 <BmpUpperPart_PF1+0x12>,-(sp)
    149a:	move.l 30d2e <BmpUpperPart_PF1+0xe>,-(sp)
    14a0:	move.l 30d2a <BmpUpperPart_PF1+0xa>,-(sp)
    14a6:	move.l 30d26 <BmpUpperPart_PF1+0x6>,-(sp)
    14ac:	move.l 30d22 <BmpUpperPart_PF1+0x2>,-(sp)
    14b2:	move.w 30d20 <BmpUpperPart_PF1>,-(sp)
    14b8:	subq.l #2,sp
    14ba:	move.l 136(sp),-(sp)
    14be:	move.l 136(sp),-(sp)
    14c2:	move.l 136(sp),-(sp)
    14c6:	move.l 136(sp),-(sp)
    14ca:	move.l 136(sp),-(sp)
    14ce:	move.l 136(sp),-(sp)
    14d2:	move.l 136(sp),-(sp)
    14d6:	move.l 136(sp),-(sp)
    14da:	move.l 136(sp),-(sp)
    14de:	move.l 136(sp),-(sp)
    14e2:	move.l 136(sp),-(sp)
    14e6:	move.l 136(sp),-(sp)
    14ea:	move.w 138(sp),-(sp)
    14ee:	jsr fa2 <SimpleBlit>(pc)
		LogoShowY1 += 2;
    14f2:	addq.w #2,30bec <LogoShowY1>
    14f8:	lea 128(sp),sp
    14fc:	bra.w 1448 <BuildLogo+0x1e>
		ps.X = 0;
    1500:	clr.l d2
    1502:	clr.l d3
		ps.Y = LogoShowY2;
    1504:	movea.w d0,a0
		pd.X = 32;
    1506:	moveq #32,d0
    1508:	clr.l d1
		SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    150a:	pea 100 <MoveBobs+0x74>
    150e:	pea 1 <_start+0x1>
    1512:	move.l a0,-(sp)
    1514:	move.l d0,-(sp)
    1516:	move.l a0,-(sp)
    1518:	move.l d2,-(sp)
    151a:	subq.l #2,sp
    151c:	move.l 30d4e <BmpUpperPart_PF1+0x2e>,-(sp)
    1522:	move.l 30d4a <BmpUpperPart_PF1+0x2a>,-(sp)
    1528:	move.l 30d46 <BmpUpperPart_PF1+0x26>,-(sp)
    152e:	move.l 30d42 <BmpUpperPart_PF1+0x22>,-(sp)
    1534:	move.l 30d3e <BmpUpperPart_PF1+0x1e>,-(sp)
    153a:	move.l 30d3a <BmpUpperPart_PF1+0x1a>,-(sp)
    1540:	move.l 30d36 <BmpUpperPart_PF1+0x16>,-(sp)
    1546:	move.l 30d32 <BmpUpperPart_PF1+0x12>,-(sp)
    154c:	move.l 30d2e <BmpUpperPart_PF1+0xe>,-(sp)
    1552:	move.l 30d2a <BmpUpperPart_PF1+0xa>,-(sp)
    1558:	move.l 30d26 <BmpUpperPart_PF1+0x6>,-(sp)
    155e:	move.l 30d22 <BmpUpperPart_PF1+0x2>,-(sp)
    1564:	move.w 30d20 <BmpUpperPart_PF1>,-(sp)
    156a:	subq.l #2,sp
    156c:	move.l 136(sp),-(sp)
    1570:	move.l 136(sp),-(sp)
    1574:	move.l 136(sp),-(sp)
    1578:	move.l 136(sp),-(sp)
    157c:	move.l 136(sp),-(sp)
    1580:	move.l 136(sp),-(sp)
    1584:	move.l 136(sp),-(sp)
    1588:	move.l 136(sp),-(sp)
    158c:	move.l 136(sp),-(sp)
    1590:	move.l 136(sp),-(sp)
    1594:	move.l 136(sp),-(sp)
    1598:	move.l 136(sp),-(sp)
    159c:	move.w 138(sp),-(sp)
    15a0:	jsr fa2 <SimpleBlit>(pc)
		LogoShowY2 += 2;
    15a4:	addq.w #2,6bb4 <LogoShowY2>
    15aa:	lea 128(sp),sp
    15ae:	bra.w 1448 <BuildLogo+0x1e>

000015b2 <DissolveLogo>:

void DissolveLogo()
{
	if (LogoShowY1 >= 0)
    15b2:	move.w 30bec <LogoShowY1>,d0
    15b8:	bpl.s 1634 <DissolveLogo+0x82>
	{
		ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
		LogoShowY1 -= 2;
	}
	else if (LogoShowY2 >= 1)
    15ba:	move.w 6bb4 <LogoShowY2>,d0
    15c0:	ble.w 16a2 <DissolveLogo+0xf0>
	{
		ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    15c4:	pea 100 <MoveBobs+0x74>
    15c8:	pea 1 <_start+0x1>
    15cc:	movea.w d0,a0
    15ce:	move.l a0,-(sp)
    15d0:	pea 20 <_start+0x20>
    15d4:	subq.l #2,sp
    15d6:	move.l 30d4e <BmpUpperPart_PF1+0x2e>,-(sp)
    15dc:	move.l 30d4a <BmpUpperPart_PF1+0x2a>,-(sp)
    15e2:	move.l 30d46 <BmpUpperPart_PF1+0x26>,-(sp)
    15e8:	move.l 30d42 <BmpUpperPart_PF1+0x22>,-(sp)
    15ee:	move.l 30d3e <BmpUpperPart_PF1+0x1e>,-(sp)
    15f4:	move.l 30d3a <BmpUpperPart_PF1+0x1a>,-(sp)
    15fa:	move.l 30d36 <BmpUpperPart_PF1+0x16>,-(sp)
    1600:	move.l 30d32 <BmpUpperPart_PF1+0x12>,-(sp)
    1606:	move.l 30d2e <BmpUpperPart_PF1+0xe>,-(sp)
    160c:	move.l 30d2a <BmpUpperPart_PF1+0xa>,-(sp)
    1612:	move.l 30d26 <BmpUpperPart_PF1+0x6>,-(sp)
    1618:	move.l 30d22 <BmpUpperPart_PF1+0x2>,-(sp)
    161e:	move.w 30d20 <BmpUpperPart_PF1>,-(sp)
    1624:	jsr ebe <ClearBitmapPart>(pc)
		LogoShowY2 -= 2;
    1628:	subq.w #2,6bb4 <LogoShowY2>
    162e:	lea 68(sp),sp
    1632:	bra.s 16a2 <DissolveLogo+0xf0>
		ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    1634:	pea 100 <MoveBobs+0x74>
    1638:	pea 1 <_start+0x1>
    163c:	movea.w d0,a0
    163e:	move.l a0,-(sp)
    1640:	pea 20 <_start+0x20>
    1644:	subq.l #2,sp
    1646:	move.l 30d4e <BmpUpperPart_PF1+0x2e>,-(sp)
    164c:	move.l 30d4a <BmpUpperPart_PF1+0x2a>,-(sp)
    1652:	move.l 30d46 <BmpUpperPart_PF1+0x26>,-(sp)
    1658:	move.l 30d42 <BmpUpperPart_PF1+0x22>,-(sp)
    165e:	move.l 30d3e <BmpUpperPart_PF1+0x1e>,-(sp)
    1664:	move.l 30d3a <BmpUpperPart_PF1+0x1a>,-(sp)
    166a:	move.l 30d36 <BmpUpperPart_PF1+0x16>,-(sp)
    1670:	move.l 30d32 <BmpUpperPart_PF1+0x12>,-(sp)
    1676:	move.l 30d2e <BmpUpperPart_PF1+0xe>,-(sp)
    167c:	move.l 30d2a <BmpUpperPart_PF1+0xa>,-(sp)
    1682:	move.l 30d26 <BmpUpperPart_PF1+0x6>,-(sp)
    1688:	move.l 30d22 <BmpUpperPart_PF1+0x2>,-(sp)
    168e:	move.w 30d20 <BmpUpperPart_PF1>,-(sp)
    1694:	jsr ebe <ClearBitmapPart>(pc)
		LogoShowY1 -= 2;
    1698:	subq.w #2,30bec <LogoShowY1>
    169e:	lea 68(sp),sp
	}
    16a2:	rts

000016a4 <MainLoop>:
{
    16a4:	link.w a5,#-52
    16a8:	movem.l d2-d5/a2-a4,-(sp)
	BmpDescriptor bmd = BmpLogo;
    16ac:	move.l 30d84 <BmpLogo>,-50(a5)
    16b4:	move.l 30d88 <BmpLogo+0x4>,-46(a5)
    16bc:	move.l 30d8c <BmpLogo+0x8>,-42(a5)
    16c4:	move.l 30d90 <BmpLogo+0xc>,-38(a5)
    16cc:	move.l 30d94 <BmpLogo+0x10>,-34(a5)
    16d4:	move.l 30d98 <BmpLogo+0x14>,-30(a5)
    16dc:	move.l 30d9c <BmpLogo+0x18>,-26(a5)
    16e4:	move.l 30da0 <BmpLogo+0x1c>,-22(a5)
    16ec:	move.l 30da4 <BmpLogo+0x20>,-18(a5)
    16f4:	move.l 30da8 <BmpLogo+0x24>,-14(a5)
    16fc:	move.l 30dac <BmpLogo+0x28>,-10(a5)
    1704:	move.l 30db0 <BmpLogo+0x2c>,-6(a5)
    170c:	move.w 30db4 <BmpLogo+0x30>,-2(a5)
	short bmpCnt = 0;
    1714:	clr.w d4
    1716:	bra.w 2296 <MainLoop+0xbf2>
		else if (LogoShowPhase % 2 == 0)
    171a:	move.b 30bee <LogoShowPhase>,d0
    1720:	btst #0,d0
    1724:	bne.s 1792 <MainLoop+0xee>
		{	if(bmpCnt > 1)
    1726:	cmpi.w #1,d4
    172a:	ble.s 172e <MainLoop+0x8a>
			bmpCnt=0;
    172c:	clr.w d4
			if (LogoShowY1 > 128 && LogoShowY2 > 129)
    172e:	cmpi.w #128,30bec <LogoShowY1>
    1736:	ble.s 1764 <MainLoop+0xc0>
    1738:	cmpi.w #129,6bb4 <LogoShowY2>
    1740:	ble.s 1764 <MainLoop+0xc0>
				LogoShowY1 = 128;
    1742:	move.w #128,30bec <LogoShowY1>
				LogoShowY2 = 129;
    174a:	move.w #129,6bb4 <LogoShowY2>
				LogoShowPhase++;
    1752:	addq.b #1,d0
    1754:	move.b d0,30bee <LogoShowPhase>
				LogoShowPause = 4 * 50;
    175a:	move.w #200,6bb6 <LogoShowPause>
				bmpCnt++;
    1762:	addq.w #1,d4
			BuildLogo(bmd);
    1764:	subq.l #2,sp
    1766:	lea -4(a5),a0
    176a:	move.l (a0),-(sp)
    176c:	move.l -(a0),-(sp)
    176e:	move.l -(a0),-(sp)
    1770:	move.l -(a0),-(sp)
    1772:	move.l -(a0),-(sp)
    1774:	move.l -(a0),-(sp)
    1776:	move.l -(a0),-(sp)
    1778:	move.l -(a0),-(sp)
    177a:	move.l -(a0),-(sp)
    177c:	move.l -(a0),-(sp)
    177e:	move.l -(a0),-(sp)
    1780:	move.l -(a0),-(sp)
    1782:	move.w -2(a0),-(sp)
    1786:	jsr 142a <BuildLogo>(pc)
    178a:	lea 52(sp),sp
    178e:	bra.w 22ba <MainLoop+0xc16>
			DissolveLogo();
    1792:	jsr 15b2 <DissolveLogo>(pc)
			if (LogoShowY1 < 0 && LogoShowY2 < 1)
    1796:	tst.w 30bec <LogoShowY1>
    179c:	bge.w 22ba <MainLoop+0xc16>
    17a0:	tst.w 6bb4 <LogoShowY2>
    17a6:	bgt.w 22ba <MainLoop+0xc16>
				LogoShowY1 = 0;
    17aa:	clr.w 30bec <LogoShowY1>
				LogoShowY2 = 1;
    17b0:	move.w #1,6bb4 <LogoShowY2>
				LogoShowPhase++;
    17b8:	addq.b #1,30bee <LogoShowPhase>
				LogoShowPause = 2 * 50;
    17be:	move.w #100,6bb6 <LogoShowPause>
				if (bmpCnt % 2 == 0)
    17c6:	btst #0,d4
    17ca:	bne.s 181e <MainLoop+0x17a>
					bmd = BmpLogo;
    17cc:	pea 32 <_start+0x32>
    17d0:	pea 30d84 <BmpLogo>
    17d6:	pea -50(a5)
    17da:	jsr 28a0 <memcpy>(pc)
					colP = copPF1ColP;
    17de:	movea.l 30be8 <copPF1ColP>,a0
    17e4:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    17e8:	moveq #1,d0
    17ea:	bra.s 1814 <MainLoop+0x170>
						ActPfCol = LogoPaletteRGB4;
    17ec:	move.l #27552,6bb0 <ActPfCol>
						colP = copSetColor(colP, a, LogoPaletteRGB4[a]);
    17f6:	move.l d0,d1
    17f8:	add.l d0,d1
    17fa:	lea 6ba0 <LogoPaletteRGB4>,a1
    1800:	move.w (0,a1,d1.l),2(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    1806:	move.w d0,d1
    1808:	addi.w #192,d1
    180c:	add.w d1,d1
    180e:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    1810:	addq.l #1,d0
						colP = copSetColor(colP, a, LogoPaletteRGB4[a]);
    1812:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    1814:	moveq #7,d1
    1816:	cmp.l d0,d1
    1818:	bge.s 17ec <MainLoop+0x148>
    181a:	bra.w 22ba <MainLoop+0xc16>
					bmd = BmpLogo2;
    181e:	pea 32 <_start+0x32>
    1822:	pea 30d52 <BmpLogo2>
    1828:	pea -50(a5)
    182c:	jsr 28a0 <memcpy>(pc)
					colP = copPF1ColP;
    1830:	movea.l 30be8 <copPF1ColP>,a0
    1836:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    183a:	moveq #1,d0
    183c:	bra.s 1866 <MainLoop+0x1c2>
						ActPfCol = BastardsPaletteRGB4;
    183e:	move.l #27536,6bb0 <ActPfCol>
						colP = copSetColor(colP, a, BastardsPaletteRGB4[a]);
    1848:	move.l d0,d1
    184a:	add.l d0,d1
    184c:	lea 6b90 <BastardsPaletteRGB4>,a1
    1852:	move.w (0,a1,d1.l),2(a0)
    1858:	move.w d0,d1
    185a:	addi.w #192,d1
    185e:	add.w d1,d1
    1860:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    1862:	addq.l #1,d0
						colP = copSetColor(colP, a, BastardsPaletteRGB4[a]);
    1864:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    1866:	moveq #7,d5
    1868:	cmp.l d0,d5
    186a:	bge.s 183e <MainLoop+0x19a>
    186c:	bra.w 22ba <MainLoop+0xc16>
			SetupCopper(copPtr);
    1870:	move.l 30bf0 <copPtr>,-(sp)
    1876:	jsr 242 <SetupCopper>(pc)
			custom->cop1lc = (ULONG)copPtr;
    187a:	movea.l 30df6 <custom>,a0
    1880:	move.l 30bf0 <copPtr>,128(a0)
			custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    1888:	move.w #64,150(a0)
			custom->copjmp1 = 0x7fff;	   //start coppper
    188e:	move.w #32767,136(a0)
			custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    1894:	move.w #-30752,150(a0)
			ResetCopper = FALSE;
    189a:	clr.w 30be6 <ResetCopper>
    18a0:	addq.l #4,sp
    18a2:	bra.w 22c4 <MainLoop+0xc20>
					ScrollerDir = 1;
    18a6:	move.b #1,6b8e <ScrollerDir>
    18ae:	bra.w 23b6 <MainLoop+0xd12>
				if (ScrollerDir > -5)
    18b2:	cmpi.b #-4,d0
    18b6:	blt.w 23b6 <MainLoop+0xd12>
					ScrollerDir--;
    18ba:	subq.b #1,d0
    18bc:	move.b d0,6b8e <ScrollerDir>
    18c2:	bra.w 23b6 <MainLoop+0xd12>
			if (ScrollerPause > 0)
    18c6:	move.w 30be0 <ScrollerPause>,d0
    18cc:	beq.w 23c4 <MainLoop+0xd20>
				ScrollerPause--;
    18d0:	subq.w #1,d0
    18d2:	move.w d0,30be0 <ScrollerPause>
    18d8:	bra.w 23c4 <MainLoop+0xd20>
		else if (ScrollerY <= ScrollerMin)
    18dc:	cmpa.w #0,a0
    18e0:	bgt.w 23e0 <MainLoop+0xd3c>
			ScrollerY = ScrollerMin;
    18e4:	clr.w 30be2 <ScrollerY>
			ScrollerDir = 1;
    18ea:	move.b #1,6b8e <ScrollerDir>
			if (ScrollerPause > 0)
    18f2:	move.w 30be0 <ScrollerPause>,d0
    18f8:	beq.w 23e0 <MainLoop+0xd3c>
				ScrollerPause--;
    18fc:	subq.w #1,d0
    18fe:	move.w d0,30be0 <ScrollerPause>
    1904:	bra.w 23e0 <MainLoop+0xd3c>
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    1908:	pea 4 <_start+0x4>
    190c:	pea 20 <_start+0x20>
    1910:	pea 28 <_start+0x28>
    1914:	move.l 30c98 <BmpScroller+0xe>,-(sp)
    191a:	subq.l #2,sp
    191c:	move.l 30cb8 <BmpScroller+0x2e>,-(sp)
    1922:	move.l 30cb4 <BmpScroller+0x2a>,-(sp)
    1928:	move.l 30cb0 <BmpScroller+0x26>,-(sp)
    192e:	move.l 30cac <BmpScroller+0x22>,-(sp)
    1934:	move.l 30ca8 <BmpScroller+0x1e>,-(sp)
    193a:	move.l 30ca4 <BmpScroller+0x1a>,-(sp)
    1940:	move.l 30ca0 <BmpScroller+0x16>,-(sp)
    1946:	move.l 30c9c <BmpScroller+0x12>,-(sp)
    194c:	move.l 30c98 <BmpScroller+0xe>,-(sp)
    1952:	move.l 30c94 <BmpScroller+0xa>,-(sp)
    1958:	move.l 30c90 <BmpScroller+0x6>,-(sp)
    195e:	move.l 30c8c <BmpScroller+0x2>,-(sp)
    1964:	move.w 30c8a <BmpScroller>,-(sp)
    196a:	jsr a7e <Scrollit>(pc)
    196e:	lea 68(sp),sp
    1972:	bra.w 23ea <MainLoop+0xd46>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
    1976:	moveq #56,d5
    1978:	add.l d5,d1
    197a:	add.w d1,d1
    197c:	add.w d1,d1
    197e:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    1980:	move.l d0,d5
    1982:	clr.w d5
    1984:	swap d5
    1986:	move.w d5,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
    198a:	addq.w #2,d1
    198c:	move.w d1,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    1990:	move.w d0,6(a2)
        addr += Bpl;
    1994:	add.l d3,d0
    for (USHORT i = 0; i < numPlanes; i++)
    1996:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
    1998:	addq.l #8,a2
    for (USHORT i = 0; i < numPlanes; i++)
    199a:	moveq #0,d1
    199c:	move.w a0,d1
    199e:	cmp.l d2,d1
    19a0:	blt.s 1976 <MainLoop+0x2d2>
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[0].X, BobTarget[0].Y, 32, 32);
    19a2:	pea 20 <_start+0x20>
    19a6:	pea 20 <_start+0x20>
    19aa:	move.l 6b62 <BobTarget+0x4>,-(sp)
    19b0:	move.l 6b5e <BobTarget>,-(sp)
    19b6:	subq.l #2,sp
    19b8:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    19be:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    19c4:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    19ca:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    19d0:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    19d6:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    19dc:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    19e2:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    19e8:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    19ee:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    19f4:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    19fa:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    1a00:	lea 30cbc <BmpUpperPart_Buf1>,a3
    1a06:	move.w (a3),-(sp)
    1a08:	lea ebe <ClearBitmapPart>(pc),a2
    1a0c:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[1].X, BobTarget[1].Y, 32, 32);
    1a0e:	lea 68(sp),sp
    1a12:	pea 20 <_start+0x20>
    1a16:	pea 20 <_start+0x20>
    1a1a:	move.l 6b6a <BobTarget+0xc>,-(sp)
    1a20:	move.l 6b66 <BobTarget+0x8>,-(sp)
    1a26:	subq.l #2,sp
    1a28:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    1a2e:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1a34:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    1a3a:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    1a40:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    1a46:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1a4c:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    1a52:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    1a58:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    1a5e:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    1a64:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    1a6a:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    1a70:	move.w (a3),-(sp)
    1a72:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[2].X, BobTarget[2].Y, 32, 32);
    1a74:	lea 68(sp),sp
    1a78:	pea 20 <_start+0x20>
    1a7c:	pea 20 <_start+0x20>
    1a80:	move.l 6b72 <BobTarget+0x14>,-(sp)
    1a86:	move.l 6b6e <BobTarget+0x10>,-(sp)
    1a8c:	subq.l #2,sp
    1a8e:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    1a94:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1a9a:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    1aa0:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    1aa6:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    1aac:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1ab2:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    1ab8:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    1abe:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    1ac4:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    1aca:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    1ad0:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    1ad6:	move.w (a3),-(sp)
    1ad8:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[3].X, BobTarget[3].Y, 32, 32);
    1ada:	lea 68(sp),sp
    1ade:	pea 20 <_start+0x20>
    1ae2:	pea 20 <_start+0x20>
    1ae6:	move.l 6b7a <BobTarget+0x1c>,-(sp)
    1aec:	move.l 6b76 <BobTarget+0x18>,-(sp)
    1af2:	subq.l #2,sp
    1af4:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    1afa:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1b00:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    1b06:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    1b0c:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    1b12:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1b18:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    1b1e:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    1b24:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    1b2a:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    1b30:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    1b36:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    1b3c:	move.w (a3),-(sp)
    1b3e:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[4].X, BobTarget[4].Y, 32, 32);
    1b40:	lea 68(sp),sp
    1b44:	pea 20 <_start+0x20>
    1b48:	pea 20 <_start+0x20>
    1b4c:	move.l 6b82 <BobTarget+0x24>,-(sp)
    1b52:	move.l 6b7e <BobTarget+0x20>,-(sp)
    1b58:	subq.l #2,sp
    1b5a:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    1b60:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1b66:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    1b6c:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    1b72:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    1b78:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1b7e:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    1b84:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    1b8a:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    1b90:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    1b96:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    1b9c:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    1ba2:	move.w (a3),-(sp)
    1ba4:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[5].X, BobTarget[5].Y, 32, 32);
    1ba6:	lea 68(sp),sp
    1baa:	pea 20 <_start+0x20>
    1bae:	pea 20 <_start+0x20>
    1bb2:	move.l 6b8a <BobTarget+0x2c>,-(sp)
    1bb8:	move.l 6b86 <BobTarget+0x28>,-(sp)
    1bbe:	subq.l #2,sp
    1bc0:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    1bc6:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1bcc:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    1bd2:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    1bd8:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    1bde:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1be4:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    1bea:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    1bf0:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    1bf6:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    1bfc:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    1c02:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    1c08:	move.w (a3),-(sp)
    1c0a:	jsr (a2)
		if (BobPause > 0)
    1c0c:	move.w 30bda <BobPause>,d0
    1c12:	lea 68(sp),sp
    1c16:	beq.w 2428 <MainLoop+0xd84>
			BobPause--;
    1c1a:	subq.w #1,d0
    1c1c:	move.w d0,30bda <BobPause>
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[0], BobTarget[0], 32, 32);
    1c22:	pea 20 <_start+0x20>
    1c26:	pea 20 <_start+0x20>
    1c2a:	move.l 6b62 <BobTarget+0x4>,-(sp)
    1c30:	move.l 6b5e <BobTarget>,-(sp)
    1c36:	move.l 4afa <BobSource+0x4>,-(sp)
    1c3c:	move.l 4af6 <BobSource>,-(sp)
    1c42:	subq.l #2,sp
    1c44:	move.l 30c22 <BmpCookieMask+0x2e>,-(sp)
    1c4a:	move.l 30c1e <BmpCookieMask+0x2a>,-(sp)
    1c50:	move.l 30c1a <BmpCookieMask+0x26>,-(sp)
    1c56:	move.l 30c16 <BmpCookieMask+0x22>,-(sp)
    1c5c:	move.l 30c12 <BmpCookieMask+0x1e>,-(sp)
    1c62:	move.l 30c0e <BmpCookieMask+0x1a>,-(sp)
    1c68:	move.l 30c0a <BmpCookieMask+0x16>,-(sp)
    1c6e:	move.l 30c06 <BmpCookieMask+0x12>,-(sp)
    1c74:	move.l 30c02 <BmpCookieMask+0xe>,-(sp)
    1c7a:	move.l 30bfe <BmpCookieMask+0xa>,-(sp)
    1c80:	move.l 30bfa <BmpCookieMask+0x6>,-(sp)
    1c86:	move.l 30bf6 <BmpCookieMask+0x2>,-(sp)
    1c8c:	lea 30bf4 <BmpCookieMask>,a0
    1c92:	move.w (a0),-(sp)
    1c94:	subq.l #2,sp
    1c96:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    1c9c:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1ca2:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    1ca8:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    1cae:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    1cb4:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1cba:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    1cc0:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    1cc6:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    1ccc:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    1cd2:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    1cd8:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    1cde:	lea 30cbc <BmpUpperPart_Buf1>,a4
    1ce4:	move.w (a4),-(sp)
    1ce6:	subq.l #2,sp
    1ce8:	move.l 30c54 <BmpCookie+0x2e>,-(sp)
    1cee:	move.l 30c50 <BmpCookie+0x2a>,-(sp)
    1cf4:	move.l 30c4c <BmpCookie+0x26>,-(sp)
    1cfa:	move.l 30c48 <BmpCookie+0x22>,-(sp)
    1d00:	move.l 30c44 <BmpCookie+0x1e>,-(sp)
    1d06:	move.l 30c40 <BmpCookie+0x1a>,-(sp)
    1d0c:	move.l 30c3c <BmpCookie+0x16>,-(sp)
    1d12:	move.l 30c38 <BmpCookie+0x12>,-(sp)
    1d18:	move.l 30c34 <BmpCookie+0xe>,-(sp)
    1d1e:	move.l 30c30 <BmpCookie+0xa>,-(sp)
    1d24:	move.l 30c2c <BmpCookie+0x6>,-(sp)
    1d2a:	move.l 30c28 <BmpCookie+0x2>,-(sp)
    1d30:	lea 30c26 <BmpCookie>,a3
    1d36:	move.w (a3),-(sp)
    1d38:	lea 1066 <BetterBlit>(pc),a2
    1d3c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[1], BobTarget[1], 32, 32);
    1d3e:	lea 180(sp),sp
    1d42:	pea 20 <_start+0x20>
    1d46:	pea 20 <_start+0x20>
    1d4a:	move.l 6b6a <BobTarget+0xc>,-(sp)
    1d50:	move.l 6b66 <BobTarget+0x8>,-(sp)
    1d56:	move.l 4b02 <BobSource+0xc>,-(sp)
    1d5c:	move.l 4afe <BobSource+0x8>,-(sp)
    1d62:	subq.l #2,sp
    1d64:	move.l 30c22 <BmpCookieMask+0x2e>,-(sp)
    1d6a:	move.l 30c1e <BmpCookieMask+0x2a>,-(sp)
    1d70:	move.l 30c1a <BmpCookieMask+0x26>,-(sp)
    1d76:	move.l 30c16 <BmpCookieMask+0x22>,-(sp)
    1d7c:	move.l 30c12 <BmpCookieMask+0x1e>,-(sp)
    1d82:	move.l 30c0e <BmpCookieMask+0x1a>,-(sp)
    1d88:	move.l 30c0a <BmpCookieMask+0x16>,-(sp)
    1d8e:	move.l 30c06 <BmpCookieMask+0x12>,-(sp)
    1d94:	move.l 30c02 <BmpCookieMask+0xe>,-(sp)
    1d9a:	move.l 30bfe <BmpCookieMask+0xa>,-(sp)
    1da0:	move.l 30bfa <BmpCookieMask+0x6>,-(sp)
    1da6:	move.l 30bf6 <BmpCookieMask+0x2>,-(sp)
    1dac:	lea 30bf4 <BmpCookieMask>,a0
    1db2:	move.w (a0),-(sp)
    1db4:	subq.l #2,sp
    1db6:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    1dbc:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1dc2:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    1dc8:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    1dce:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    1dd4:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1dda:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    1de0:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    1de6:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    1dec:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    1df2:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    1df8:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    1dfe:	move.w (a4),-(sp)
    1e00:	subq.l #2,sp
    1e02:	move.l 30c54 <BmpCookie+0x2e>,-(sp)
    1e08:	move.l 30c50 <BmpCookie+0x2a>,-(sp)
    1e0e:	move.l 30c4c <BmpCookie+0x26>,-(sp)
    1e14:	move.l 30c48 <BmpCookie+0x22>,-(sp)
    1e1a:	move.l 30c44 <BmpCookie+0x1e>,-(sp)
    1e20:	move.l 30c40 <BmpCookie+0x1a>,-(sp)
    1e26:	move.l 30c3c <BmpCookie+0x16>,-(sp)
    1e2c:	move.l 30c38 <BmpCookie+0x12>,-(sp)
    1e32:	move.l 30c34 <BmpCookie+0xe>,-(sp)
    1e38:	move.l 30c30 <BmpCookie+0xa>,-(sp)
    1e3e:	move.l 30c2c <BmpCookie+0x6>,-(sp)
    1e44:	move.l 30c28 <BmpCookie+0x2>,-(sp)
    1e4a:	move.w (a3),-(sp)
    1e4c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[2], BobTarget[2], 32, 32);
    1e4e:	lea 180(sp),sp
    1e52:	pea 20 <_start+0x20>
    1e56:	pea 20 <_start+0x20>
    1e5a:	move.l 6b72 <BobTarget+0x14>,-(sp)
    1e60:	move.l 6b6e <BobTarget+0x10>,-(sp)
    1e66:	move.l 4b0a <BobSource+0x14>,-(sp)
    1e6c:	move.l 4b06 <BobSource+0x10>,-(sp)
    1e72:	subq.l #2,sp
    1e74:	move.l 30c22 <BmpCookieMask+0x2e>,-(sp)
    1e7a:	move.l 30c1e <BmpCookieMask+0x2a>,-(sp)
    1e80:	move.l 30c1a <BmpCookieMask+0x26>,-(sp)
    1e86:	move.l 30c16 <BmpCookieMask+0x22>,-(sp)
    1e8c:	move.l 30c12 <BmpCookieMask+0x1e>,-(sp)
    1e92:	move.l 30c0e <BmpCookieMask+0x1a>,-(sp)
    1e98:	move.l 30c0a <BmpCookieMask+0x16>,-(sp)
    1e9e:	move.l 30c06 <BmpCookieMask+0x12>,-(sp)
    1ea4:	move.l 30c02 <BmpCookieMask+0xe>,-(sp)
    1eaa:	move.l 30bfe <BmpCookieMask+0xa>,-(sp)
    1eb0:	move.l 30bfa <BmpCookieMask+0x6>,-(sp)
    1eb6:	move.l 30bf6 <BmpCookieMask+0x2>,-(sp)
    1ebc:	lea 30bf4 <BmpCookieMask>,a0
    1ec2:	move.w (a0),-(sp)
    1ec4:	subq.l #2,sp
    1ec6:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    1ecc:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1ed2:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    1ed8:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    1ede:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    1ee4:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1eea:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    1ef0:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    1ef6:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    1efc:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    1f02:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    1f08:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    1f0e:	move.w (a4),-(sp)
    1f10:	subq.l #2,sp
    1f12:	move.l 30c54 <BmpCookie+0x2e>,-(sp)
    1f18:	move.l 30c50 <BmpCookie+0x2a>,-(sp)
    1f1e:	move.l 30c4c <BmpCookie+0x26>,-(sp)
    1f24:	move.l 30c48 <BmpCookie+0x22>,-(sp)
    1f2a:	move.l 30c44 <BmpCookie+0x1e>,-(sp)
    1f30:	move.l 30c40 <BmpCookie+0x1a>,-(sp)
    1f36:	move.l 30c3c <BmpCookie+0x16>,-(sp)
    1f3c:	move.l 30c38 <BmpCookie+0x12>,-(sp)
    1f42:	move.l 30c34 <BmpCookie+0xe>,-(sp)
    1f48:	move.l 30c30 <BmpCookie+0xa>,-(sp)
    1f4e:	move.l 30c2c <BmpCookie+0x6>,-(sp)
    1f54:	move.l 30c28 <BmpCookie+0x2>,-(sp)
    1f5a:	move.w (a3),-(sp)
    1f5c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[3], BobTarget[3], 32, 32);
    1f5e:	lea 180(sp),sp
    1f62:	pea 20 <_start+0x20>
    1f66:	pea 20 <_start+0x20>
    1f6a:	move.l 6b7a <BobTarget+0x1c>,-(sp)
    1f70:	move.l 6b76 <BobTarget+0x18>,-(sp)
    1f76:	move.l 4b12 <BobSource+0x1c>,-(sp)
    1f7c:	move.l 4b0e <BobSource+0x18>,-(sp)
    1f82:	subq.l #2,sp
    1f84:	move.l 30c22 <BmpCookieMask+0x2e>,-(sp)
    1f8a:	move.l 30c1e <BmpCookieMask+0x2a>,-(sp)
    1f90:	move.l 30c1a <BmpCookieMask+0x26>,-(sp)
    1f96:	move.l 30c16 <BmpCookieMask+0x22>,-(sp)
    1f9c:	move.l 30c12 <BmpCookieMask+0x1e>,-(sp)
    1fa2:	move.l 30c0e <BmpCookieMask+0x1a>,-(sp)
    1fa8:	move.l 30c0a <BmpCookieMask+0x16>,-(sp)
    1fae:	move.l 30c06 <BmpCookieMask+0x12>,-(sp)
    1fb4:	move.l 30c02 <BmpCookieMask+0xe>,-(sp)
    1fba:	move.l 30bfe <BmpCookieMask+0xa>,-(sp)
    1fc0:	move.l 30bfa <BmpCookieMask+0x6>,-(sp)
    1fc6:	move.l 30bf6 <BmpCookieMask+0x2>,-(sp)
    1fcc:	lea 30bf4 <BmpCookieMask>,a0
    1fd2:	move.w (a0),-(sp)
    1fd4:	subq.l #2,sp
    1fd6:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    1fdc:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1fe2:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    1fe8:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    1fee:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    1ff4:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1ffa:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    2000:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    2006:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    200c:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    2012:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    2018:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    201e:	move.w (a4),-(sp)
    2020:	subq.l #2,sp
    2022:	move.l 30c54 <BmpCookie+0x2e>,-(sp)
    2028:	move.l 30c50 <BmpCookie+0x2a>,-(sp)
    202e:	move.l 30c4c <BmpCookie+0x26>,-(sp)
    2034:	move.l 30c48 <BmpCookie+0x22>,-(sp)
    203a:	move.l 30c44 <BmpCookie+0x1e>,-(sp)
    2040:	move.l 30c40 <BmpCookie+0x1a>,-(sp)
    2046:	move.l 30c3c <BmpCookie+0x16>,-(sp)
    204c:	move.l 30c38 <BmpCookie+0x12>,-(sp)
    2052:	move.l 30c34 <BmpCookie+0xe>,-(sp)
    2058:	move.l 30c30 <BmpCookie+0xa>,-(sp)
    205e:	move.l 30c2c <BmpCookie+0x6>,-(sp)
    2064:	move.l 30c28 <BmpCookie+0x2>,-(sp)
    206a:	move.w (a3),-(sp)
    206c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[4], BobTarget[4], 32, 32);
    206e:	lea 180(sp),sp
    2072:	pea 20 <_start+0x20>
    2076:	pea 20 <_start+0x20>
    207a:	move.l 6b82 <BobTarget+0x24>,-(sp)
    2080:	move.l 6b7e <BobTarget+0x20>,-(sp)
    2086:	move.l 4b1a <BobSource+0x24>,-(sp)
    208c:	move.l 4b16 <BobSource+0x20>,-(sp)
    2092:	subq.l #2,sp
    2094:	move.l 30c22 <BmpCookieMask+0x2e>,-(sp)
    209a:	move.l 30c1e <BmpCookieMask+0x2a>,-(sp)
    20a0:	move.l 30c1a <BmpCookieMask+0x26>,-(sp)
    20a6:	move.l 30c16 <BmpCookieMask+0x22>,-(sp)
    20ac:	move.l 30c12 <BmpCookieMask+0x1e>,-(sp)
    20b2:	move.l 30c0e <BmpCookieMask+0x1a>,-(sp)
    20b8:	move.l 30c0a <BmpCookieMask+0x16>,-(sp)
    20be:	move.l 30c06 <BmpCookieMask+0x12>,-(sp)
    20c4:	move.l 30c02 <BmpCookieMask+0xe>,-(sp)
    20ca:	move.l 30bfe <BmpCookieMask+0xa>,-(sp)
    20d0:	move.l 30bfa <BmpCookieMask+0x6>,-(sp)
    20d6:	move.l 30bf6 <BmpCookieMask+0x2>,-(sp)
    20dc:	lea 30bf4 <BmpCookieMask>,a0
    20e2:	move.w (a0),-(sp)
    20e4:	subq.l #2,sp
    20e6:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    20ec:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    20f2:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    20f8:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    20fe:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    2104:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    210a:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    2110:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    2116:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    211c:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    2122:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    2128:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    212e:	move.w (a4),-(sp)
    2130:	subq.l #2,sp
    2132:	move.l 30c54 <BmpCookie+0x2e>,-(sp)
    2138:	move.l 30c50 <BmpCookie+0x2a>,-(sp)
    213e:	move.l 30c4c <BmpCookie+0x26>,-(sp)
    2144:	move.l 30c48 <BmpCookie+0x22>,-(sp)
    214a:	move.l 30c44 <BmpCookie+0x1e>,-(sp)
    2150:	move.l 30c40 <BmpCookie+0x1a>,-(sp)
    2156:	move.l 30c3c <BmpCookie+0x16>,-(sp)
    215c:	move.l 30c38 <BmpCookie+0x12>,-(sp)
    2162:	move.l 30c34 <BmpCookie+0xe>,-(sp)
    2168:	move.l 30c30 <BmpCookie+0xa>,-(sp)
    216e:	move.l 30c2c <BmpCookie+0x6>,-(sp)
    2174:	move.l 30c28 <BmpCookie+0x2>,-(sp)
    217a:	move.w (a3),-(sp)
    217c:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[5], BobTarget[5], 32, 32);
    217e:	lea 180(sp),sp
    2182:	pea 20 <_start+0x20>
    2186:	pea 20 <_start+0x20>
    218a:	move.l 6b8a <BobTarget+0x2c>,-(sp)
    2190:	move.l 6b86 <BobTarget+0x28>,-(sp)
    2196:	move.l 4b22 <BobSource+0x2c>,-(sp)
    219c:	move.l 4b1e <BobSource+0x28>,-(sp)
    21a2:	subq.l #2,sp
    21a4:	move.l 30c22 <BmpCookieMask+0x2e>,-(sp)
    21aa:	move.l 30c1e <BmpCookieMask+0x2a>,-(sp)
    21b0:	move.l 30c1a <BmpCookieMask+0x26>,-(sp)
    21b6:	move.l 30c16 <BmpCookieMask+0x22>,-(sp)
    21bc:	move.l 30c12 <BmpCookieMask+0x1e>,-(sp)
    21c2:	move.l 30c0e <BmpCookieMask+0x1a>,-(sp)
    21c8:	move.l 30c0a <BmpCookieMask+0x16>,-(sp)
    21ce:	move.l 30c06 <BmpCookieMask+0x12>,-(sp)
    21d4:	move.l 30c02 <BmpCookieMask+0xe>,-(sp)
    21da:	move.l 30bfe <BmpCookieMask+0xa>,-(sp)
    21e0:	move.l 30bfa <BmpCookieMask+0x6>,-(sp)
    21e6:	move.l 30bf6 <BmpCookieMask+0x2>,-(sp)
    21ec:	lea 30bf4 <BmpCookieMask>,a0
    21f2:	move.w (a0),-(sp)
    21f4:	subq.l #2,sp
    21f6:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    21fc:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2202:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    2208:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    220e:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    2214:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    221a:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    2220:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    2226:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    222c:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    2232:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    2238:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    223e:	move.w (a4),-(sp)
    2240:	subq.l #2,sp
    2242:	move.l 30c54 <BmpCookie+0x2e>,-(sp)
    2248:	move.l 30c50 <BmpCookie+0x2a>,-(sp)
    224e:	move.l 30c4c <BmpCookie+0x26>,-(sp)
    2254:	move.l 30c48 <BmpCookie+0x22>,-(sp)
    225a:	move.l 30c44 <BmpCookie+0x1e>,-(sp)
    2260:	move.l 30c40 <BmpCookie+0x1a>,-(sp)
    2266:	move.l 30c3c <BmpCookie+0x16>,-(sp)
    226c:	move.l 30c38 <BmpCookie+0x12>,-(sp)
    2272:	move.l 30c34 <BmpCookie+0xe>,-(sp)
    2278:	move.l 30c30 <BmpCookie+0xa>,-(sp)
    227e:	move.l 30c2c <BmpCookie+0x6>,-(sp)
    2284:	move.l 30c28 <BmpCookie+0x2>,-(sp)
    228a:	move.w (a3),-(sp)
    228c:	jsr (a2)
		MoveStarfield();
    228e:	lea 180(sp),sp
    2292:	jsr 13ee <MoveStarfield>(pc)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    2296:	move.b bfe001 <_end+0xbcd205>,d0
	while (!MouseLeft())
    229c:	btst #6,d0
    22a0:	beq.w 2430 <MainLoop+0xd8c>
		WaitVbl();
    22a4:	jsr c46 <WaitVbl>(pc)
		if (LogoShowPause > 0)
    22a8:	move.w 6bb6 <LogoShowPause>,d0
    22ae:	beq.w 171a <MainLoop+0x76>
			LogoShowPause--;
    22b2:	subq.w #1,d0
    22b4:	move.w d0,6bb6 <LogoShowPause>
		if (ResetCopper)
    22ba:	tst.w 30be6 <ResetCopper>
    22c0:	bne.w 1870 <MainLoop+0x1cc>
		CopyBitmap(BmpUpperPart_Buf1, BmpUpperPart_PF2);
    22c4:	subq.l #2,sp
    22c6:	move.l 30d1c <BmpUpperPart_PF2+0x2e>,-(sp)
    22cc:	move.l 30d18 <BmpUpperPart_PF2+0x2a>,-(sp)
    22d2:	move.l 30d14 <BmpUpperPart_PF2+0x26>,-(sp)
    22d8:	move.l 30d10 <BmpUpperPart_PF2+0x22>,-(sp)
    22de:	move.l 30d0c <BmpUpperPart_PF2+0x1e>,-(sp)
    22e4:	move.l 30d08 <BmpUpperPart_PF2+0x1a>,-(sp)
    22ea:	move.l 30d04 <BmpUpperPart_PF2+0x16>,-(sp)
    22f0:	move.l 30d00 <BmpUpperPart_PF2+0x12>,-(sp)
    22f6:	move.l 30cfc <BmpUpperPart_PF2+0xe>,-(sp)
    22fc:	move.l 30cf8 <BmpUpperPart_PF2+0xa>,-(sp)
    2302:	move.l 30cf4 <BmpUpperPart_PF2+0x6>,-(sp)
    2308:	move.l 30cf0 <BmpUpperPart_PF2+0x2>,-(sp)
    230e:	move.w 30cee <BmpUpperPart_PF2>,-(sp)
    2314:	subq.l #2,sp
    2316:	move.l 30cea <BmpUpperPart_Buf1+0x2e>,-(sp)
    231c:	move.l 30ce6 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2322:	move.l 30ce2 <BmpUpperPart_Buf1+0x26>,-(sp)
    2328:	move.l 30cde <BmpUpperPart_Buf1+0x22>,-(sp)
    232e:	move.l 30cda <BmpUpperPart_Buf1+0x1e>,-(sp)
    2334:	move.l 30cd6 <BmpUpperPart_Buf1+0x1a>,-(sp)
    233a:	move.l 30cd2 <BmpUpperPart_Buf1+0x16>,-(sp)
    2340:	move.l 30cce <BmpUpperPart_Buf1+0x12>,-(sp)
    2346:	move.l 30cca <BmpUpperPart_Buf1+0xe>,-(sp)
    234c:	move.l 30cc6 <BmpUpperPart_Buf1+0xa>,-(sp)
    2352:	move.l 30cc2 <BmpUpperPart_Buf1+0x6>,-(sp)
    2358:	move.l 30cbe <BmpUpperPart_Buf1+0x2>,-(sp)
    235e:	move.w 30cbc <BmpUpperPart_Buf1>,-(sp)
    2364:	jsr e62 <CopyBitmap>(pc)
		if (BounceEnabled)
    2368:	lea 104(sp),sp
    236c:	tst.w 30be4 <BounceEnabled>
    2372:	beq.w 18c6 <MainLoop+0x222>
			if (ScrollerDir > 0)
    2376:	move.b 6b8e <ScrollerDir>,d0
    237c:	ble.w 18b2 <MainLoop+0x20e>
				ScrollerDir = ((ScrollerMax - ScrollerY) * 1000 / 12000);
    2380:	pea c <_start+0xc>
    2384:	movea.w #40,a0
    2388:	suba.w 30be2 <ScrollerY>,a0
    238e:	move.l a0,-(sp)
    2390:	jsr 2982 <__divsi3>
    2396:	addq.l #8,sp
    2398:	move.b d0,6b8e <ScrollerDir>
				if (ScrollerDir > 6)
    239e:	cmpi.b #6,d0
    23a2:	ble.s 23ac <MainLoop+0xd08>
					ScrollerDir = 6;
    23a4:	move.b #6,6b8e <ScrollerDir>
				if (ScrollerDir < 1)
    23ac:	tst.b 6b8e <ScrollerDir>
    23b2:	ble.w 18a6 <MainLoop+0x202>
			ScrollerY += ScrollerDir;
    23b6:	move.b 6b8e <ScrollerDir>,d0
    23bc:	ext.w d0
    23be:	add.w d0,30be2 <ScrollerY>
		if (ScrollerY >= ScrollerMax)
    23c4:	movea.w 30be2 <ScrollerY>,a0
    23ca:	moveq #39,d0
    23cc:	cmp.l a0,d0
    23ce:	bge.w 18dc <MainLoop+0x238>
			ScrollerY = ScrollerMax;
    23d2:	move.w #40,30be2 <ScrollerY>
			ScrollerDir = -1;
    23da:	st 6b8e <ScrollerDir>
		if (ScrollerPause < 1)
    23e0:	tst.w 30be0 <ScrollerPause>
    23e6:	beq.w 1908 <MainLoop+0x264>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    23ea:	moveq #0,d3
    23ec:	move.w 30c90 <BmpScroller+0x6>,d3
    23f2:	moveq #0,d2
    23f4:	move.w 30c8e <BmpScroller+0x4>,d2
    23fa:	movea.l 30bdc <copScrollerBmpP>,a2
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    2400:	lea 2904 <__mulsi3>,a3
    2406:	move.l d3,-(sp)
    2408:	movea.w 30be2 <ScrollerY>,a0
    240e:	move.l a0,-(sp)
    2410:	jsr (a3)
    2412:	addq.l #8,sp
    2414:	move.l d0,-(sp)
    2416:	move.l d2,-(sp)
    2418:	jsr (a3)
    241a:	addq.l #8,sp
    241c:	add.l 30c98 <BmpScroller+0xe>,d0
    for (USHORT i = 0; i < numPlanes; i++)
    2422:	suba.l a0,a0
    2424:	bra.w 199a <MainLoop+0x2f6>
			MoveBobs();
    2428:	jsr 8c <MoveBobs>(pc)
    242c:	bra.w 1c22 <MainLoop+0x57e>
}
    2430:	movem.l -80(a5),d2-d5/a2-a4
    2436:	unlk a5
    2438:	rts

0000243a <KPrintF>:
void KPrintF(const char* fmt, ...) {
    243a:	lea -128(sp),sp
    243e:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    2442:	move.w f0ff60 <_end+0xedf164>,d0
    2448:	cmpi.w #20153,d0
    244c:	beq.s 2470 <KPrintF+0x36>
    244e:	cmpi.w #-24562,d0
    2452:	beq.s 2470 <KPrintF+0x36>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    2454:	movea.l 30df0 <SysBase>,a6
    245a:	movea.l 144(sp),a0
    245e:	lea 148(sp),a1
    2462:	lea 29fe <KPutCharX>,a2
    2468:	suba.l a3,a3
    246a:	jsr -522(a6)
    246e:	bra.s 249a <KPrintF+0x60>
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    2470:	movea.l 30df0 <SysBase>,a6
    2476:	movea.l 144(sp),a0
    247a:	lea 148(sp),a1
    247e:	lea 2a0c <PutChar>,a2
    2484:	lea 12(sp),a3
    2488:	jsr -522(a6)
		UaeDbgLog(86, temp);
    248c:	move.l a3,-(sp)
    248e:	pea 56 <_start+0x56>
    2492:	jsr f0ff60 <_end+0xedf164>
    2498:	addq.l #8,sp
}
    249a:	movem.l (sp)+,a2-a3/a6
    249e:	lea 128(sp),sp
    24a2:	rts

000024a4 <main>:
{
    24a4:	movem.l d2-d3/a2/a6,-(sp)
	SysBase = *((struct ExecBase **)4UL);
    24a8:	movea.l 4 <_start+0x4>,a6
    24ac:	move.l a6,30df0 <SysBase>
	custom = (struct Custom *)0xdff000;
    24b2:	move.l #14675968,30df6 <custom>
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
    24bc:	lea 4449 <incbin_P61_Player_end+0x1>,a1
    24c2:	moveq #0,d0
    24c4:	jsr -552(a6)
    24c8:	move.l d0,30dec <GfxBase>
	if (!GfxBase)
    24ce:	beq.w 2842 <main+0x39e>
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    24d2:	movea.l 30df0 <SysBase>,a6
    24d8:	lea 445a <incbin_P61_Player_end+0x12>,a1
    24de:	moveq #0,d0
    24e0:	jsr -552(a6)
    24e4:	move.l d0,30de8 <DOSBase>
	if (!DOSBase)
    24ea:	beq.w 2852 <main+0x3ae>
	KPrintF("Hello debugger from Amiga!\n");
    24ee:	pea 4466 <incbin_P61_Player_end+0x1e>
    24f4:	jsr 243a <KPrintF>(pc)
	Write(Output(), (APTR) "Hello console!\n", 15);
    24f8:	movea.l 30de8 <DOSBase>,a6
    24fe:	jsr -60(a6)
    2502:	movea.l 30de8 <DOSBase>,a6
    2508:	move.l d0,d1
    250a:	move.l #17538,d2
    2510:	moveq #15,d3
    2512:	jsr -48(a6)
	BitmapInit(&Screen, 320, 256, 3);
    2516:	pea 3 <_start+0x3>
    251a:	pea 100 <MoveBobs+0x74>
    251e:	pea 140 <MoveBobs+0xb4>
    2522:	pea 30db6 <Screen>
    2528:	lea 1244 <BitmapInit>(pc),a2
    252c:	jsr (a2)
	BitmapInit(&BmpLogo, 256, 130, 3);
    252e:	pea 3 <_start+0x3>
    2532:	pea 82 <_start+0x82>
    2536:	pea 100 <MoveBobs+0x74>
    253a:	pea 30d84 <BmpLogo>
    2540:	jsr (a2)
	BitmapInit(&BmpLogo2, 256, 130, 3);
    2542:	lea 36(sp),sp
    2546:	pea 3 <_start+0x3>
    254a:	pea 82 <_start+0x82>
    254e:	pea 100 <MoveBobs+0x74>
    2552:	pea 30d52 <BmpLogo2>
    2558:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF1, 320, 130, 3);
    255a:	pea 3 <_start+0x3>
    255e:	pea 82 <_start+0x82>
    2562:	pea 140 <MoveBobs+0xb4>
    2566:	pea 30d20 <BmpUpperPart_PF1>
    256c:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF2, 320 + 64, 130, 3);
    256e:	lea 32(sp),sp
    2572:	pea 3 <_start+0x3>
    2576:	pea 82 <_start+0x82>
    257a:	pea 180 <MoveBobs+0xf4>
    257e:	pea 30cee <BmpUpperPart_PF2>
    2584:	jsr (a2)
	BitmapInit(&BmpUpperPart_Buf1, 320 + 64, 130, 3);
    2586:	pea 3 <_start+0x3>
    258a:	pea 82 <_start+0x82>
    258e:	pea 180 <MoveBobs+0xf4>
    2592:	pea 30cbc <BmpUpperPart_Buf1>
    2598:	jsr (a2)
	BitmapInit(&BmpScroller, 320 + 32, 166, 3);
    259a:	lea 32(sp),sp
    259e:	pea 3 <_start+0x3>
    25a2:	pea a6 <MoveBobs+0x1a>
    25a6:	pea 160 <MoveBobs+0xd4>
    25aa:	pea 30c8a <BmpScroller>
    25b0:	jsr (a2)
	BitmapInit(&BmpFont32, 320, 256, 3);
    25b2:	pea 3 <_start+0x3>
    25b6:	pea 100 <MoveBobs+0x74>
    25ba:	pea 140 <MoveBobs+0xb4>
    25be:	pea 30c58 <BmpFont32>
    25c4:	jsr (a2)
	BitmapInit(&BmpCookie, 320, 256, 3);
    25c6:	lea 32(sp),sp
    25ca:	pea 3 <_start+0x3>
    25ce:	pea 100 <MoveBobs+0x74>
    25d2:	pea 140 <MoveBobs+0xb4>
    25d6:	pea 30c26 <BmpCookie>
    25dc:	jsr (a2)
	BitmapInit(&BmpCookieMask, 320, 256, 3);
    25de:	pea 3 <_start+0x3>
    25e2:	pea 100 <MoveBobs+0x74>
    25e6:	pea 140 <MoveBobs+0xb4>
    25ea:	pea 30bf4 <BmpCookieMask>
    25f0:	jsr (a2)
	copPtr = AllocMem(1024, MEMF_CHIP);
    25f2:	movea.l 30df0 <SysBase>,a6
    25f8:	move.l #1024,d0
    25fe:	moveq #2,d1
    2600:	jsr -198(a6)
    2604:	move.l d0,30bf0 <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
    260a:	movea.l 30df0 <SysBase>,a6
    2610:	moveq #0,d0
    2612:	move.w 30c96 <BmpScroller+0xc>,d0
    2618:	move.l #65538,d1
    261e:	jsr -198(a6)
    2622:	move.l d0,30c98 <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
    2628:	movea.l 30df0 <SysBase>,a6
    262e:	moveq #0,d0
    2630:	move.w 30d2c <BmpUpperPart_PF1+0xc>,d0
    2636:	move.l #65538,d1
    263c:	jsr -198(a6)
    2640:	move.l d0,30d2e <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
    2646:	movea.l 30df0 <SysBase>,a6
    264c:	moveq #0,d0
    264e:	move.w 30cfa <BmpUpperPart_PF2+0xc>,d0
    2654:	move.l #65538,d1
    265a:	jsr -198(a6)
    265e:	move.l d0,30cfc <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
    2664:	movea.l 30df0 <SysBase>,a6
    266a:	moveq #0,d0
    266c:	move.w 30cc8 <BmpUpperPart_Buf1+0xc>,d0
    2672:	move.l #65538,d1
    2678:	jsr -198(a6)
    267c:	move.l d0,30cca <BmpUpperPart_Buf1+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
    2682:	move.l #27576,30d92 <BmpLogo+0xe>
	BmpLogo2.ImageData = (UWORD *)BmpLogo2P;
    268c:	move.l #40058,30d60 <BmpLogo2+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
    2696:	move.l #52540,30c66 <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
    26a0:	move.l #83262,30c34 <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
    26aa:	move.l #113984,30c02 <BmpCookieMask+0xe>
	InitImagePlanes(&BmpLogo, 0);
    26b4:	lea 32(sp),sp
    26b8:	clr.l -(sp)
    26ba:	pea 30d84 <BmpLogo>
    26c0:	lea e18 <InitImagePlanes>(pc),a2
    26c4:	jsr (a2)
	InitImagePlanes(&BmpLogo2, 0);
    26c6:	clr.l -(sp)
    26c8:	pea 30d52 <BmpLogo2>
    26ce:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF1, 0);
    26d0:	clr.l -(sp)
    26d2:	pea 30d20 <BmpUpperPart_PF1>
    26d8:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF2, 32 / 8);
    26da:	pea 4 <_start+0x4>
    26de:	pea 30cee <BmpUpperPart_PF2>
    26e4:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_Buf1, 32 / 8);
    26e6:	lea 32(sp),sp
    26ea:	pea 4 <_start+0x4>
    26ee:	pea 30cbc <BmpUpperPart_Buf1>
    26f4:	jsr (a2)
	InitImagePlanes(&BmpScroller, 0);
    26f6:	clr.l -(sp)
    26f8:	pea 30c8a <BmpScroller>
    26fe:	jsr (a2)
	InitImagePlanes(&BmpFont32, 0);
    2700:	clr.l -(sp)
    2702:	pea 30c58 <BmpFont32>
    2708:	jsr (a2)
	InitImagePlanes(&BmpCookie, 0);
    270a:	clr.l -(sp)
    270c:	pea 30c26 <BmpCookie>
    2712:	jsr (a2)
	InitImagePlanes(&BmpCookieMask, 0);
    2714:	lea 32(sp),sp
    2718:	clr.l -(sp)
    271a:	pea 30bf4 <BmpCookieMask>
    2720:	jsr (a2)
	TakeSystem();
    2722:	jsr c8c <TakeSystem>(pc)
	InitStarfieldSprite();
    2726:	jsr 127e <InitStarfieldSprite>(pc)
	WaitVbl();
    272a:	jsr c46 <WaitVbl>(pc)
	SetupCopper(copPtr);
    272e:	move.l 30bf0 <copPtr>,-(sp)
    2734:	jsr 242 <SetupCopper>(pc)
	custom->cop1lc = (ULONG)copPtr;
    2738:	movea.l 30df6 <custom>,a0
    273e:	move.l 30bf0 <copPtr>,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    2746:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
    274c:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    2752:	move.w #-30752,150(a0)
	SetInterruptHandler((APTR)interruptHandler);
    2758:	pea 11f4 <interruptHandler>(pc)
    275c:	jsr c2c <SetInterruptHandler>(pc)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
    2760:	movea.l 30df6 <custom>,a0
    2766:	move.w #-16352,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
    276c:	move.w #32,156(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
    2772:	move.w #-24576,154(a0)
	if (p61Init(module) != 0)
    2778:	pea 23542 <incbin_module_start>
    277e:	jsr 11b0 <p61Init>(pc)
    2782:	lea 20(sp),sp
    2786:	tst.l d0
    2788:	bne.w 285e <main+0x3ba>
	MainLoop();
    278c:	jsr 16a4 <MainLoop>(pc)
	p61End();
    2790:	jsr 1222 <p61End>(pc)
	FreeMem(copPtr, 1024);
    2794:	movea.l 30df0 <SysBase>,a6
    279a:	movea.l 30bf0 <copPtr>,a1
    27a0:	move.l #1024,d0
    27a6:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    27aa:	movea.l 30df0 <SysBase>,a6
    27b0:	movea.l 30c98 <BmpScroller+0xe>,a1
    27b6:	moveq #0,d0
    27b8:	move.w 30c96 <BmpScroller+0xc>,d0
    27be:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    27c2:	movea.l 30df0 <SysBase>,a6
    27c8:	movea.l 30d2e <BmpUpperPart_PF1+0xe>,a1
    27ce:	moveq #0,d0
    27d0:	move.w 30d2c <BmpUpperPart_PF1+0xc>,d0
    27d6:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    27da:	movea.l 30df0 <SysBase>,a6
    27e0:	movea.l 30cfc <BmpUpperPart_PF2+0xe>,a1
    27e6:	moveq #0,d0
    27e8:	move.w 30cfa <BmpUpperPart_PF2+0xc>,d0
    27ee:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_Buf1.ImageData, BmpUpperPart_PF2.Btot);
    27f2:	movea.l 30df0 <SysBase>,a6
    27f8:	movea.l 30cca <BmpUpperPart_Buf1+0xe>,a1
    27fe:	moveq #0,d0
    2800:	move.w 30cfa <BmpUpperPart_PF2+0xc>,d0
    2806:	jsr -210(a6)
	CloseLibrary((struct Library *)DOSBase);
    280a:	movea.l 30df0 <SysBase>,a6
    2810:	movea.l 30de8 <DOSBase>,a1
    2816:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    281a:	movea.l 30df0 <SysBase>,a6
    2820:	movea.l 30dec <GfxBase>,a1
    2826:	jsr -414(a6)
	FreeSystem();
    282a:	jsr d58 <FreeSystem>(pc)
	Exit(0);
    282e:	movea.l 30de8 <DOSBase>,a6
    2834:	moveq #0,d1
    2836:	jsr -144(a6)
}
    283a:	moveq #0,d0
    283c:	movem.l (sp)+,d2-d3/a2/a6
    2840:	rts
		Exit(0);
    2842:	movea.l 30de8 <DOSBase>,a6
    2848:	moveq #0,d1
    284a:	jsr -144(a6)
    284e:	bra.w 24d2 <main+0x2e>
		Exit(0);
    2852:	movea.l d0,a6
    2854:	moveq #0,d1
    2856:	jsr -144(a6)
    285a:	bra.w 24ee <main+0x4a>
		KPrintF("p61Init failed!\n");
    285e:	pea 4492 <incbin_P61_Player_end+0x4a>
    2864:	jsr 243a <KPrintF>(pc)
    2868:	addq.l #4,sp
    286a:	bra.w 278c <main+0x2e8>

0000286e <strlen>:
unsigned long strlen(const char* s) {
    286e:	movea.l 4(sp),a0
	unsigned long t=0;
    2872:	moveq #0,d0
    2874:	bra.s 2878 <strlen+0xa>
		t++;
    2876:	addq.l #1,d0
	while(*s++)
    2878:	tst.b (a0)+
    287a:	bne.s 2876 <strlen+0x8>
}
    287c:	rts

0000287e <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    287e:	move.l d2,-(sp)
    2880:	move.l 8(sp),d0
    2884:	move.l 12(sp),d2
    2888:	move.l 16(sp),d1
	unsigned char *ptr = (unsigned char *)dest;
    288c:	movea.l d0,a0
    288e:	bra.s 2894 <memset+0x16>
		*ptr++ = val;
    2890:	move.b d2,(a0)+
	while(len-- > 0)
    2892:	move.l a1,d1
    2894:	movea.l d1,a1
    2896:	subq.l #1,a1
    2898:	tst.l d1
    289a:	bne.s 2890 <memset+0x12>
}
    289c:	move.l (sp)+,d2
    289e:	rts

000028a0 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    28a0:	move.l d2,-(sp)
    28a2:	move.l 8(sp),d0
    28a6:	movea.l 12(sp),a1
    28aa:	move.l 16(sp),d1
	char *d = (char *)dest;
    28ae:	movea.l d0,a0
    28b0:	bra.s 28b6 <memcpy+0x16>
		*d++ = *s++;
    28b2:	move.b (a1)+,(a0)+
	while(len--)
    28b4:	move.l d2,d1
    28b6:	move.l d1,d2
    28b8:	subq.l #1,d2
    28ba:	tst.l d1
    28bc:	bne.s 28b2 <memcpy+0x12>
}
    28be:	move.l (sp)+,d2
    28c0:	rts

000028c2 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    28c2:	move.l d2,-(sp)
    28c4:	move.l 8(sp),d0
    28c8:	movea.l 12(sp),a0
    28cc:	move.l 16(sp),d1
	if (d < s) {
    28d0:	cmpa.l d0,a0
    28d2:	bhi.s 28ee <memmove+0x2c>
		const char *lasts = s + (len - 1);
    28d4:	movea.l d1,a1
    28d6:	subq.l #1,a1
    28d8:	adda.l a1,a0
		char *lastd = d + (len - 1);
    28da:	adda.l d0,a1
		while (len--)
    28dc:	bra.s 28fa <memmove+0x38>
			*d++ = *s++;
    28de:	move.b (a0)+,(a1)+
		while (len--)
    28e0:	move.l d2,d1
    28e2:	move.l d1,d2
    28e4:	subq.l #1,d2
    28e6:	tst.l d1
    28e8:	bne.s 28de <memmove+0x1c>
}
    28ea:	move.l (sp)+,d2
    28ec:	rts
	char *d = dest;
    28ee:	movea.l d0,a1
    28f0:	bra.s 28e2 <memmove+0x20>
			*lastd-- = *lasts--;
    28f2:	move.b (a0),(a1)
    28f4:	subq.l #1,a1
    28f6:	subq.l #1,a0
		while (len--)
    28f8:	move.l d2,d1
    28fa:	move.l d1,d2
    28fc:	subq.l #1,d2
    28fe:	tst.l d1
    2900:	bne.s 28f2 <memmove+0x30>
    2902:	bra.s 28ea <memmove+0x28>

00002904 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    2904:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    2908:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    290c:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    2910:	mulu.w 8(sp),d1
	addw	d1, d0
    2914:	add.w d1,d0
	swap	d0
    2916:	swap d0
	clrw	d0
    2918:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    291a:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    291e:	mulu.w 10(sp),d1
	addl	d1, d0
    2922:	add.l d1,d0
	rts
    2924:	rts

00002926 <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    2926:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    2928:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    292c:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    2930:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    2936:	bcc.s 294e <__udivsi3+0x28>
	movel	d0, d2
    2938:	move.l d0,d2
	clrw	d2
    293a:	clr.w d2
	swap	d2
    293c:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    293e:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    2940:	move.w d2,d0
	swap	d0
    2942:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    2944:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    2948:	divu.w d1,d2
	movew	d2, d0
    294a:	move.w d2,d0
	jra	6f
    294c:	bra.s 297e <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    294e:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    2950:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    2952:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    2954:	cmpi.l #65536,d1
	jcc	4b
    295a:	bcc.s 2950 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    295c:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    295e:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    2964:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    2966:	mulu.w d0,d1
	swap	d2
    2968:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    296a:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    296c:	swap d2
	tstw	d2		/* high part 17 bits? */
    296e:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    2970:	bne.s 297c <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    2972:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    2974:	bcs.s 297c <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    2976:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    297a:	bls.s 297e <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    297c:	subq.l #1,d0

6:	movel	sp@+, d2
    297e:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    2980:	rts

00002982 <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    2982:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    2984:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    2986:	move.l 12(sp),d1
	jpl	1f
    298a:	bpl.s 2990 <__divsi3+0xe>
	negl	d1
    298c:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    298e:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    2990:	move.l 8(sp),d0
	jpl	2f
    2994:	bpl.s 299a <__divsi3+0x18>
	negl	d0
    2996:	neg.l d0
	negb	d2
    2998:	neg.b d2

2:	movel	d1, sp@-
    299a:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    299c:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    299e:	bsr.s 2926 <__udivsi3>
	addql	#8, sp
    29a0:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    29a2:	tst.b d2
	jpl	3f
    29a4:	bpl.s 29a8 <__divsi3+0x26>
	negl	d0
    29a6:	neg.l d0

3:	movel	sp@+, d2
    29a8:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    29aa:	rts

000029ac <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    29ac:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    29b0:	move.l 4(sp),d0
	movel	d1, sp@-
    29b4:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    29b6:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    29b8:	bsr.s 2982 <__divsi3>
	addql	#8, sp
    29ba:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    29bc:	move.l 8(sp),d1
	movel	d1, sp@-
    29c0:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    29c2:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    29c4:	bsr.w 2904 <__mulsi3>
	addql	#8, sp
    29c8:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    29ca:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    29ce:	sub.l d0,d1
	movel	d1, d0
    29d0:	move.l d1,d0
	rts
    29d2:	rts

000029d4 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    29d4:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    29d8:	move.l 4(sp),d0
	movel	d1, sp@-
    29dc:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    29de:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    29e0:	bsr.w 2926 <__udivsi3>
	addql	#8, sp
    29e4:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    29e6:	move.l 8(sp),d1
	movel	d1, sp@-
    29ea:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    29ec:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    29ee:	bsr.w 2904 <__mulsi3>
	addql	#8, sp
    29f2:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    29f4:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    29f8:	sub.l d0,d1
	movel	d1, d0
    29fa:	move.l d1,d0
	rts
    29fc:	rts

000029fe <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    29fe:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    2a00:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    2a04:	jsr -516(a6)
    move.l (sp)+, a6
    2a08:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    2a0a:	rts

00002a0c <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    2a0c:	move.b d0,(a3)+
	rts
    2a0e:	rts

00002a10 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    2a10:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    2a12:	adda.l a0,a2
	move.l	a2,a3
    2a14:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    2a16:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    2a18:	moveq #56,d4
	moveq	#8,d5
    2a1a:	moveq #8,d5
	bra.s	.Lliteral
    2a1c:	bra.s 2a86 <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    2a1e:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    2a20:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    2a22:	dbf d1,2a1e <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    2a26:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    2a28:	bcc.s 2a2c <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    2a2a:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    2a2c:	tst.w d0
    2a2e:	bne.s 2a38 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    2a30:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    2a32:	bls.s 2aaa <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    2a34:	move.w (a0)+,d0
    2a36:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    2a38:	rol.l #6,d0
	move.w	d0,d1
    2a3a:	move.w d0,d1
	and.w	d4,d1
    2a3c:	and.w d4,d1
	eor.w	d1,d0
    2a3e:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    2a40:	movem.w (2aa4 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    2a46:	rol.l d2,d0
	and.w	d0,d3					|scaling
    2a48:	and.w d0,d3
	eor.w	d3,d0
    2a4a:	eor.w d3,d0
	suba.w	d3,a4
    2a4c:	suba.w d3,a4
	adda.l	a1,a4
    2a4e:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    2a50:	tst.w d0
    2a52:	bne.s 2a58 <_doynaxdepack_asm+0x48>
    2a54:	move.w (a0)+,d0
    2a56:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    2a58:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    2a5a:	beq.s 2a72 <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    2a5c:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    2a5e:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    2a60:	bpl.s 2a6e <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    2a62:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    2a64:	bpl.s 2a6c <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    2a66:	addx.b d1,d1
	lsl.l	#2,d0
    2a68:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    2a6a:	bmi.s 2a66 <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    2a6c:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    2a6e:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    2a70:	bcc.s 2a74 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    2a72:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    2a74:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    2a76:	dbf d1,2a72 <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    2a7a:	add.l d0,d0
	bcc.s	.Lmatch
    2a7c:	bcc.s 2a2c <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    2a7e:	tst.w d0
    2a80:	bne.s 2a86 <_doynaxdepack_asm+0x76>
    2a82:	move.w (a0)+,d0
    2a84:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    2a86:	moveq #0,d1
	add.l	d0,d0
    2a88:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    2a8a:	bcc.s 2a2a <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    2a8c:	bpl.s 2a94 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    2a8e:	addx.b d1,d1
	lsl.l	#2,d0
    2a90:	lsl.l #2,d0
	bmi.s	.Llgetlen
    2a92:	bmi.s 2a8e <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    2a94:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    2a96:	dbv.s d1,2a1e <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    2a9a:	add.l d0,d0
	eor.w	d1,d0		
    2a9c:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    2a9e:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    2aa0:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    2aa2:	bra.s 2a96 <_doynaxdepack_asm+0x86>

00002aa4 <doy_table>:
    2aa4:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    2ab4:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    2ac4:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    2ad4:	.............o
