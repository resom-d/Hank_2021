
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
      14:	lea 6000 <NextPlot>,a2
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
      36:	lea 6000 <NextPlot>,a2
      3c:	moveq #0,d2
		__init_array_start[i]();
      3e:	movea.l (a2)+,a0
      40:	jsr (a0)
	for (i = 0; i < count; i++)
      42:	addq.l #1,d2
      44:	cmp.l d3,d2
      46:	bne.s 3e <_start+0x3e>

	main();
      48:	jsr 254e <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
      4e:	move.l #24576,d2
      54:	subi.l #24576,d2
      5a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	beq.s 6e <_start+0x6e>
      5e:	lea 6000 <NextPlot>,a2
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

00000074 <MoveBobs>:
		custom->color[0]=0xf00;
	}
}

void MoveBobs()
{
      74:	movem.l d2-d5,-(sp)
	switch (BobPhase)
      78:	move.w 23770 <BobPhase>,d0
      7e:	beq.w 10a <MoveBobs+0x96>
      82:	cmpi.w #1,d0
      86:	beq.w 20a <MoveBobs+0x196>
			BobPhase = 0;
			*copPF1BmpP = 1 << 6; // prio. in bplcon2: pf2 >> pf 1 >> sprites
		}
		break;
	}
}
      8a:	movem.l (sp)+,d2-d5
      8e:	rts
				BobVisible |= (1 << b);
      90:	moveq #1,d2
      92:	lsl.l d0,d2
      94:	move.w 6046 <BobVisible>,d4
      9a:	or.w d2,d4
      9c:	move.w d4,6046 <BobVisible>
				BobTarget[b].X += BobVecs[b].X;
      a2:	lea 6006 <BobVecs>,a1
      a8:	move.l d0,d5
      aa:	lsl.l #3,d5
      ac:	movea.l d5,a0
      ae:	add.l (0,a1,d5.l),d1
      b2:	lea 6048 <BobTarget>,a1
      b8:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X > 320 - 32)
      bc:	cmpi.l #288,d1
      c2:	ble.s d6 <MoveBobs+0x62>
					BobTarget[b].X = 320 - 32;
      c4:	move.l #288,(0,a1,d5.l)
					BobVisible &= ~(1 << b);
      cc:	not.w d2
      ce:	and.w d4,d2
      d0:	move.w d2,6046 <BobVisible>
{
      d6:	move.l d3,d0
		for (int b = 0; b < BOBSN - 1; b++)
      d8:	moveq #6,d1
      da:	cmp.l d0,d1
      dc:	blt.s 10e <MoveBobs+0x9a>
			if ((BobTarget[b + 1].X - BobTarget[b].X) > 34 || BobTarget[b + 1].X >= 320 - 32)
      de:	move.l d0,d3
      e0:	addq.l #1,d3
      e2:	lea 6048 <BobTarget>,a0
      e8:	move.l d3,d1
      ea:	lsl.l #3,d1
      ec:	movea.l (0,a0,d1.l),a1
      f0:	move.l d0,d1
      f2:	lsl.l #3,d1
      f4:	move.l (0,a0,d1.l),d1
      f8:	movea.l a1,a0
      fa:	suba.l d1,a0
      fc:	moveq #34,d2
      fe:	cmp.l a0,d2
     100:	blt.s 90 <MoveBobs+0x1c>
     102:	cmpa.w #287,a1
     106:	ble.s d6 <MoveBobs+0x62>
     108:	bra.s 90 <MoveBobs+0x1c>
	switch (BobPhase)
     10a:	moveq #0,d0
     10c:	bra.s d8 <MoveBobs+0x64>
		BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
     10e:	move.l 603e <BobVecs+0x38>,d1
     114:	move.l d1,d0
     116:	add.l 6080 <BobTarget+0x38>,d0
     11c:	move.l d0,6080 <BobTarget+0x38>
		if (BobTarget[BOBSN - 1].X > 320 - 32)
     122:	cmpi.l #288,d0
     128:	ble.s 13c <MoveBobs+0xc8>
			BobTarget[BOBSN - 1].X = 320 - 32;
     12a:	move.l #288,6080 <BobTarget+0x38>
			BobVisible &= ~(1 << 7);
     134:	andi.w #-129,6046 <BobVisible>
		if (BobTarget[0].X >= 320 - 32)
     13c:	cmpi.l #287,6048 <BobTarget>
     146:	ble.w 8a <MoveBobs+0x16>
			BobVecs[0].X *= -1;
     14a:	neg.l 6006 <BobVecs>
			BobVecs[1].X *= -1;
     150:	neg.l 600e <BobVecs+0x8>
			BobVecs[2].X *= -1;
     156:	neg.l 6016 <BobVecs+0x10>
			BobVecs[3].X *= -1;
     15c:	neg.l 601e <BobVecs+0x18>
			BobVecs[4].X *= -1;
     162:	neg.l 6026 <BobVecs+0x20>
			BobVecs[5].X *= -1;
     168:	neg.l 602e <BobVecs+0x28>
			BobVecs[6].X *= -1;
     16e:	neg.l 6036 <BobVecs+0x30>
			BobVecs[7].X *= -1;
     174:	neg.l d1
     176:	move.l d1,603e <BobVecs+0x38>
			BobVisible = 1 << 7;
     17c:	move.w #128,6046 <BobVisible>
			BobPhase = 1;
     184:	move.w #1,23770 <BobPhase>
			*copPF1BmpP = 0 << 6; // prio. in bplcon2: pf1 >> pf 2 >> sprites
     18c:	movea.l 2376c <copPF1BmpP>,a0
     192:	clr.w (a0)
     194:	bra.w 8a <MoveBobs+0x16>
				BobVisible |= (1 << b);
     198:	moveq #1,d2
     19a:	lsl.l d0,d2
     19c:	move.w 6046 <BobVisible>,d4
     1a2:	or.w d2,d4
     1a4:	move.w d4,6046 <BobVisible>
				BobTarget[b].X += BobVecs[b].X;
     1aa:	lea 6006 <BobVecs>,a1
     1b0:	move.l d0,d5
     1b2:	lsl.l #3,d5
     1b4:	movea.l d5,a0
     1b6:	add.l (0,a1,d5.l),d1
     1ba:	lea 6048 <BobTarget>,a1
     1c0:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X < 0)
     1c4:	bmi.s 1fa <MoveBobs+0x186>
	switch (BobPhase)
     1c6:	move.l d3,d0
		for (int b = 0; b < BOBSN - 1; b++)
     1c8:	moveq #6,d1
     1ca:	cmp.l d0,d1
     1cc:	blt.s 20e <MoveBobs+0x19a>
			if ((BobTarget[b].X - BobTarget[b + 1].X) > 34 || BobTarget[b + 1].X <= 0)
     1ce:	lea 6048 <BobTarget>,a0
     1d4:	move.l d0,d1
     1d6:	lsl.l #3,d1
     1d8:	move.l (0,a0,d1.l),d1
     1dc:	move.l d0,d3
     1de:	addq.l #1,d3
     1e0:	move.l d3,d2
     1e2:	lsl.l #3,d2
     1e4:	movea.l (0,a0,d2.l),a0
     1e8:	movea.l d1,a1
     1ea:	suba.l a0,a1
     1ec:	moveq #34,d2
     1ee:	cmp.l a1,d2
     1f0:	blt.s 198 <MoveBobs+0x124>
     1f2:	cmpa.w #0,a0
     1f6:	bgt.s 1c6 <MoveBobs+0x152>
     1f8:	bra.s 198 <MoveBobs+0x124>
					BobTarget[b].X = 0;
     1fa:	clr.l (0,a1,d5.l)
					BobVisible &= ~(1 << b);
     1fe:	not.w d2
     200:	and.w d4,d2
     202:	move.w d2,6046 <BobVisible>
     208:	bra.s 1c6 <MoveBobs+0x152>
	switch (BobPhase)
     20a:	moveq #0,d0
     20c:	bra.s 1c8 <MoveBobs+0x154>
		BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
     20e:	move.l 603e <BobVecs+0x38>,d1
     214:	move.l d1,d0
     216:	add.l 6080 <BobTarget+0x38>,d0
     21c:	move.l d0,6080 <BobTarget+0x38>
		if (BobTarget[BOBSN - 1].X < 0)
     222:	bmi.s 27c <MoveBobs+0x208>
		if (BobTarget[0].X <= 0)
     224:	tst.l 6048 <BobTarget>
     22a:	bgt.w 8a <MoveBobs+0x16>
			BobVecs[0].X *= -1;
     22e:	neg.l 6006 <BobVecs>
			BobVecs[1].X *= -1;
     234:	neg.l 600e <BobVecs+0x8>
			BobVecs[2].X *= -1;
     23a:	neg.l 6016 <BobVecs+0x10>
			BobVecs[3].X *= -1;
     240:	neg.l 601e <BobVecs+0x18>
			BobVecs[4].X *= -1;
     246:	neg.l 6026 <BobVecs+0x20>
			BobVecs[5].X *= -1;
     24c:	neg.l 602e <BobVecs+0x28>
			BobVecs[6].X *= -1;
     252:	neg.l 6036 <BobVecs+0x30>
			BobVecs[7].X *= -1;
     258:	neg.l d1
     25a:	move.l d1,603e <BobVecs+0x38>
			BobVisible = 1 << 7;
     260:	move.w #128,6046 <BobVisible>
			BobPhase = 0;
     268:	clr.w 23770 <BobPhase>
			*copPF1BmpP = 1 << 6; // prio. in bplcon2: pf2 >> pf 1 >> sprites
     26e:	movea.l 2376c <copPF1BmpP>,a0
     274:	move.w #64,(a0)
     278:	bra.w 8a <MoveBobs+0x16>
			BobTarget[BOBSN - 1].X = 0;
     27c:	clr.l 6080 <BobTarget+0x38>
			BobVisible &= ~(1 << 7);
     282:	andi.w #-129,6046 <BobVisible>
     28a:	bra.s 224 <MoveBobs+0x1b0>

0000028c <SetupCopper>:

void SetupCopper(USHORT *copPtr)
{
     28c:	movem.l d2-d5/a2,-(sp)
     290:	movea.l 24(sp),a1
	UBYTE line = 0x1c;
	// set screen output size
	*copPtr++ = DIWSTRT;
     294:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     298:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     29e:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     2a4:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     2aa:	move.w #146,8(a1)
	*copPtr++ = 0x38;
     2b0:	move.w #56,10(a1)
	*copPtr++ = DDFSTOP;
     2b6:	move.w #148,12(a1)
	*copPtr++ = 0xd0;
     2bc:	move.w #208,14(a1)
	// set pf1/2 modulos
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl);
     2c2:	move.w 238b6 <BmpUpperPart_PF1+0x8>,d0
     2c8:	sub.w 238b4 <BmpUpperPart_PF1+0x6>,d0
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     2ce:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     2d4:	move.w d0,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     2d8:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     2de:	move.w d0,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     2e2:	move.w #258,24(a1)
	*copPtr++ = 0;
     2e8:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     2ec:	move.w #260,28(a1)
	copPF1BmpP = copPtr;
     2f2:	lea 30(a1),a0
     2f6:	move.l a0,2376c <copPF1BmpP>
	*copPtr++ = 1 << 6; //pf2 >> pf 1 >> sprites
     2fc:	move.w #64,30(a1)
    *copListEnd++ = COP_SKIP;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     302:	move.w #384,32(a1)
    *copListCurrent++ = color;
     308:	move.w #21,34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     30e:	move.w #398,36(a1)
    *copListCurrent++ = color;
     314:	lea 40(a1),a0
     318:	move.w #21,38(a1)
	// set logo colors
	copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[0]);
	copPtr = copSetColor(copPtr, 7, colgradbluePaletteRGB4[0]);
	for (int a = 1; a < 8; a++)
     31e:	moveq #1,d0
     320:	bra.s 340 <SetupCopper+0xb4>
	{
		copPtr = copSetColor(copPtr, a, LogoPaletteRGB4[a]);
     322:	movea.l d0,a1
     324:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     326:	move.w d0,d1
     328:	addi.w #192,d1
     32c:	add.w d1,d1
     32e:	move.w d1,(a0)
    *copListCurrent++ = color;
     330:	lea 4d68 <LogoPaletteRGB4>,a2
     336:	move.w (0,a2,a1.l),2(a0)
	for (int a = 1; a < 8; a++)
     33c:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, LogoPaletteRGB4[a]);
     33e:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     340:	moveq #7,d1
     342:	cmp.l d0,d1
     344:	bge.s 322 <SetupCopper+0x96>
	}
	for (int a = 8; a < 16; a++)
     346:	moveq #8,d0
     348:	bra.s 36a <SetupCopper+0xde>
	{
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     34a:	move.l d0,d1
     34c:	subq.l #8,d1
     34e:	add.l d1,d1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     350:	movea.w d0,a1
     352:	lea 192(a1),a1
     356:	adda.w a1,a1
     358:	move.w a1,(a0)
    *copListCurrent++ = color;
     35a:	lea 4d58 <CookiePaletteRGB4>,a1
     360:	move.w (0,a1,d1.l),2(a0)
	for (int a = 8; a < 16; a++)
     366:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     368:	addq.l #4,a0
	for (int a = 8; a < 16; a++)
     36a:	moveq #15,d2
     36c:	cmp.l d0,d2
     36e:	bge.s 34a <SetupCopper+0xbe>
	}
	// set upper part, pf1, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
     370:	moveq #0,d5
     372:	move.w 238b4 <BmpUpperPart_PF1+0x6>,d5
     378:	moveq #0,d4
     37a:	move.w 238b2 <BmpUpperPart_PF1+0x4>,d4
     380:	move.l 238bc <BmpUpperPart_PF1+0xe>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     386:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     388:	clr.b d2
     38a:	bra.s 3b8 <SetupCopper+0x12c>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     38c:	move.b d2,d0
     38e:	ext.w d0
     390:	movea.w d0,a1
     392:	moveq #56,d0
     394:	add.l a1,d0
     396:	add.w d0,d0
     398:	add.w d0,d0
     39a:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     39c:	move.l d1,d3
     39e:	clr.w d3
     3a0:	swap d3
     3a2:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     3a6:	addq.w #2,d0
     3a8:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3ac:	move.w d1,6(a0)
        addr += Bpl;
     3b0:	add.l d5,d1
        plane += 2;
     3b2:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     3b4:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3b6:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     3b8:	moveq #0,d0
     3ba:	move.w a2,d0
     3bc:	cmp.l d4,d0
     3be:	blt.s 38c <SetupCopper+0x100>
	// set upper part, pf2, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
     3c0:	moveq #0,d5
     3c2:	move.w 23882 <BmpUpperPart_PF2+0x6>,d5
     3c8:	moveq #0,d4
     3ca:	move.w 23880 <BmpUpperPart_PF2+0x4>,d4
     3d0:	move.l 2388a <BmpUpperPart_PF2+0xe>,d1
     3d6:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     3d8:	moveq #1,d2
     3da:	bra.s 408 <SetupCopper+0x17c>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     3dc:	move.b d2,d0
     3de:	ext.w d0
     3e0:	movea.w d0,a1
     3e2:	moveq #56,d0
     3e4:	add.l a1,d0
     3e6:	add.w d0,d0
     3e8:	add.w d0,d0
     3ea:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     3ec:	move.l d1,d3
     3ee:	clr.w d3
     3f0:	swap d3
     3f2:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     3f6:	addq.w #2,d0
     3f8:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     3fc:	move.w d1,6(a0)
        addr += Bpl;
     400:	add.l d5,d1
        plane += 2;
     402:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     404:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     406:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     408:	moveq #0,d0
     40a:	move.w a2,d0
     40c:	cmp.l d4,d0
     40e:	blt.s 3dc <SetupCopper+0x150>
	// set sprite pointers
	*copPtr++ = SPR0PTH;
     410:	move.w #288,(a0)
	*copPtr++ = (LONG)StarSprite >> 16;
     414:	move.l #144484,d0
     41a:	move.l d0,d1
     41c:	swap d1
     41e:	ext.l d1
     420:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
     424:	move.w #290,4(a0)
	*copPtr++ = (LONG)StarSprite;
     42a:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
     42e:	move.w #292,8(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     434:	move.l #144472,d0
     43a:	move.l d0,d1
     43c:	swap d1
     43e:	ext.l d1
     440:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
     444:	move.w #294,12(a0)
	*copPtr++ = (LONG)NullSprite;
     44a:	move.w d0,14(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     44e:	move.w #418,16(a0)
    *copListCurrent++ = color;
     454:	move.w #3234,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     45a:	move.w #420,20(a0)
    *copListCurrent++ = color;
     460:	move.w #3276,22(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     466:	move.w #422,24(a0)
    *copListCurrent++ = color;
     46c:	move.w #4095,26(a0)
	// sprite 0+1 colors
	copPtr = copSetColor(copPtr, 17, 0xca2);
	copPtr = copSetColor(copPtr, 18, 0xccc);
	copPtr = copSetColor(copPtr, 19, 0xfff);
	*copPtr++ = SPR2PTH;
     472:	move.w #296,28(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     478:	move.w d1,30(a0)
	*copPtr++ = SPR2PTL;
     47c:	move.w #298,32(a0)
	*copPtr++ = (LONG)NullSprite;
     482:	move.w d0,34(a0)
	*copPtr++ = SPR3PTH;
     486:	move.w #300,36(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     48c:	move.w d1,38(a0)
	*copPtr++ = SPR3PTL;
     490:	move.w #302,40(a0)
	*copPtr++ = (LONG)NullSprite;
     496:	move.w d0,42(a0)
	*copPtr++ = SPR4PTH;
     49a:	move.w #304,44(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     4a0:	move.w d1,46(a0)
	*copPtr++ = SPR4PTL;
     4a4:	move.w #306,48(a0)
	*copPtr++ = (LONG)NullSprite;
     4aa:	move.w d0,50(a0)
	*copPtr++ = SPR5PTH;
     4ae:	move.w #308,52(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     4b4:	move.w d1,54(a0)
	*copPtr++ = SPR5PTL;
     4b8:	move.w #310,56(a0)
	*copPtr++ = (LONG)NullSprite;
     4be:	move.w d0,58(a0)
	*copPtr++ = SPR6PTH;
     4c2:	move.w #312,60(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     4c8:	move.w d1,62(a0)
	*copPtr++ = SPR6PTL;
     4cc:	move.w #314,64(a0)
	*copPtr++ = (LONG)NullSprite;
     4d2:	move.w d0,66(a0)
	*copPtr++ = SPR7PTH;
     4d6:	move.w #316,68(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     4dc:	move.w d1,70(a0)
	*copPtr++ = SPR7PTL;
     4e0:	move.w #318,72(a0)
	*copPtr++ = (LONG)NullSprite;
     4e6:	move.w d0,74(a0)
	// enable bitplanes
	*copPtr++ = BPLCON0;
     4ea:	move.w #256,76(a0)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     4f0:	moveq #0,d0
     4f2:	move.w 238e4 <BmpLogo+0x4>,d0
     4f8:	add.l d0,d0
     4fa:	moveq #12,d3
     4fc:	lsl.l d3,d0
     4fe:	ori.w #1536,d0
     502:	move.w d0,78(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     506:	move.w #7173,80(a0)
    *copListEnd++ = COP_WAIT;
     50c:	move.w #-2,82(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     512:	move.w #384,84(a0)
    *copListCurrent++ = color;
     518:	move.w #21,86(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     51e:	move.w #398,88(a0)
    *copListCurrent++ = color;
     524:	move.w #21,90(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     52a:	move.w #7429,92(a0)
    *copListEnd++ = COP_WAIT;
     530:	move.w #-2,94(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     536:	move.w #384,96(a0)
    *copListCurrent++ = color;
     53c:	move.w #22,98(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     542:	move.w #398,100(a0)
    *copListCurrent++ = color;
     548:	move.w #22,102(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     54e:	move.w #7685,104(a0)
    *copListEnd++ = COP_WAIT;
     554:	move.w #-2,106(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     55a:	move.w #384,108(a0)
    *copListCurrent++ = color;
     560:	move.w #22,110(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     566:	move.w #398,112(a0)
    *copListCurrent++ = color;
     56c:	move.w #22,114(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     572:	move.w #7941,116(a0)
    *copListEnd++ = COP_WAIT;
     578:	move.w #-2,118(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     57e:	move.w #384,120(a0)
    *copListCurrent++ = color;
     584:	move.w #22,122(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     58a:	move.w #398,124(a0)
    *copListCurrent++ = color;
     590:	move.w #22,126(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     596:	move.w #8197,128(a0)
    *copListEnd++ = COP_WAIT;
     59c:	move.w #-2,130(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5a2:	move.w #384,132(a0)
    *copListCurrent++ = color;
     5a8:	move.w #38,134(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5ae:	move.w #398,136(a0)
    *copListCurrent++ = color;
     5b4:	move.w #38,138(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     5ba:	move.w #8453,140(a0)
    *copListEnd++ = COP_WAIT;
     5c0:	move.w #-2,142(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5c6:	move.w #384,144(a0)
    *copListCurrent++ = color;
     5cc:	move.w #39,146(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5d2:	move.w #398,148(a0)
    *copListCurrent++ = color;
     5d8:	move.w #39,150(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     5de:	move.w #8709,152(a0)
    *copListEnd++ = COP_WAIT;
     5e4:	move.w #-2,154(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5ea:	move.w #384,156(a0)
    *copListCurrent++ = color;
     5f0:	move.w #39,158(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     5f6:	move.w #398,160(a0)
    *copListCurrent++ = color;
     5fc:	move.w #39,162(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     602:	move.w #8965,164(a0)
    *copListEnd++ = COP_WAIT;
     608:	move.w #-2,166(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     60e:	move.w #384,168(a0)
    *copListCurrent++ = color;
     614:	move.w #21,170(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     61a:	move.w #398,172(a0)
    *copListCurrent++ = color;
     620:	move.w #21,174(a0)
	copPtr = copSetColor(copPtr, 7, colgradbluePaletteRGB4[6]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[0]);
	copPtr = copSetColor(copPtr, 7, colgradbluePaletteRGB4[0]);
	// wait till below logo
	line = 0x2c + BmpUpperPart_PF1.Height;
     626:	move.b 238b1 <BmpUpperPart_PF1+0x3>,d0
     62c:	addi.b #44,d0
	copPtr = copWaitY(copPtr, line++);
     630:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     636:	lsl.l #8,d0
     638:	ori.w #5,d0
     63c:	move.w d0,176(a0)
    *copListEnd++ = COP_WAIT;
     640:	move.w #-2,178(a0)
	// turn off bitplanes to waste 8 lines, giving the logo more bottom space
	*copPtr++ = BPLCON0;
     646:	move.w #256,180(a0)
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     64c:	move.w #512,182(a0)
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
     652:	move.b 238b1 <BmpUpperPart_PF1+0x3>,d0
     658:	addi.b #52,d0
	copPtr = copWaitY(copPtr, line++);
     65c:	move.b 238b1 <BmpUpperPart_PF1+0x3>,d1
     662:	addi.b #53,d1
     666:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     66c:	lsl.l #8,d0
     66e:	ori.w #5,d0
     672:	move.w d0,184(a0)
    *copListEnd++ = COP_WAIT;
     676:	lea 188(a0),a1
     67a:	move.w #-2,186(a0)
	// set bitplane pointers
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     680:	move.l a1,23772 <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     686:	moveq #0,d5
     688:	move.w 2381e <BmpScroller+0x6>,d5
     68e:	moveq #0,d4
     690:	move.w 2381c <BmpScroller+0x4>,d4
     696:	move.l 23826 <BmpScroller+0xe>,d2
    for (USHORT i = 0; i < numPlanes; i++)
     69c:	suba.l a0,a0
     69e:	bra.s 6c4 <SetupCopper+0x438>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     6a0:	moveq #56,d3
     6a2:	add.l d3,d0
     6a4:	add.w d0,d0
     6a6:	add.w d0,d0
     6a8:	move.w d0,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     6aa:	move.l d2,d3
     6ac:	clr.w d3
     6ae:	swap d3
     6b0:	move.w d3,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     6b4:	addq.w #2,d0
     6b6:	move.w d0,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     6ba:	move.w d2,6(a1)
        addr += Bpl;
     6be:	add.l d5,d2
    for (USHORT i = 0; i < numPlanes; i++)
     6c0:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
     6c2:	addq.l #8,a1
    for (USHORT i = 0; i < numPlanes; i++)
     6c4:	moveq #0,d0
     6c6:	move.w a0,d0
     6c8:	cmp.l d4,d0
     6ca:	blt.s 6a0 <SetupCopper+0x414>
	//set modulo for scroller
	copPtr = copSetBplMod(0, copPtr,
						  BmpScroller.Bplt - Screen.Bpl,
						  BmpScroller.Bplt - Screen.Bpl);
     6cc:	move.w 23820 <BmpScroller+0x8>,d0
     6d2:	sub.w 23918 <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     6d8:	move.w #264,(a1)
    *copListEnd++ = modOdd;
     6dc:	move.w d0,2(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     6e0:	move.w #266,4(a1)
    *copListEnd++ = modEven;
     6e6:	move.w d0,6(a1)
	*copPtr++ = BPLCON0;
     6ea:	move.w #256,8(a1)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     6f0:	moveq #0,d0
     6f2:	move.w 238e4 <BmpLogo+0x4>,d0
     6f8:	moveq #12,d2
     6fa:	lsl.l d2,d0
     6fc:	lea 12(a1),a0
     700:	ori.w #512,d0
     704:	move.w d0,10(a1)
	// set font colors for scroller
	for (int a = 1; a < 8; a++)
     708:	moveq #1,d0
     70a:	bra.s 72a <SetupCopper+0x49e>
	{
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     70c:	move.l d0,d2
     70e:	add.l d0,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     710:	movea.w d0,a1
     712:	lea 192(a1),a1
     716:	adda.w a1,a1
     718:	move.w a1,(a0)
    *copListCurrent++ = color;
     71a:	lea 4d48 <FontPaletteRGB4>,a1
     720:	move.w (0,a1,d2.l),2(a0)
	for (int a = 1; a < 8; a++)
     726:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     728:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     72a:	moveq #7,d3
     72c:	cmp.l d0,d3
     72e:	bge.s 70c <SetupCopper+0x480>
	}
	// blue gradient below logo
	for (int l = 0; l < 24; l++)
     730:	moveq #0,d0
     732:	bra.s 762 <SetupCopper+0x4d6>
	{
		copPtr = copWaitY(copPtr, line);
     734:	moveq #0,d2
     736:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     738:	lsl.l #8,d2
     73a:	ori.w #5,d2
     73e:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     740:	move.w #-2,2(a0)
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     746:	movea.l d0,a1
     748:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     74a:	move.w #384,4(a0)
    *copListCurrent++ = color;
     750:	lea 4d78 <colgradbluePaletteRGB4>,a2
     756:	move.w (0,a2,a1.l),6(a0)
		line += 2;
     75c:	addq.b #2,d1
	for (int l = 0; l < 24; l++)
     75e:	addq.l #1,d0
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     760:	addq.l #8,a0
	for (int l = 0; l < 24; l++)
     762:	moveq #23,d2
     764:	cmp.l d0,d2
     766:	bge.s 734 <SetupCopper+0x4a8>
	}
	copPtr = copWaitY(copPtr, line++);
     768:	move.b d1,d0
     76a:	addq.b #1,d0
     76c:	moveq #0,d2
     76e:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     770:	lsl.l #8,d2
     772:	ori.w #5,d2
     776:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     778:	move.w #-2,2(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
     77e:	movea.w 6002 <colScrollMirror>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     784:	move.w #384,4(a0)
    *copListCurrent++ = color;
     78a:	move.w a1,6(a0)
	copPtr = copWaitY(copPtr, line++);
     78e:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     794:	lsl.l #8,d0
     796:	ori.w #5,d0
     79a:	move.w d0,8(a0)
    *copListEnd++ = COP_WAIT;
     79e:	move.w #-2,10(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
     7a4:	move.w 6004 <colScrollMirror+0x2>,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     7aa:	move.w #384,12(a0)
    *copListCurrent++ = color;
     7b0:	move.w d2,14(a0)
	line += 7;
     7b4:	move.b d1,d0
     7b6:	addi.b #9,d0
	copPtr = copWaitY(copPtr, line++);
     7ba:	addi.b #10,d1
     7be:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     7c4:	lsl.l #8,d0
     7c6:	ori.w #5,d0
     7ca:	move.w d0,16(a0)
    *copListEnd++ = COP_WAIT;
     7ce:	move.w #-2,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     7d4:	move.w #384,20(a0)
    *copListCurrent++ = color;
     7da:	move.w a1,22(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
     7de:	andi.l #255,d1
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     7e4:	lsl.l #8,d1
     7e6:	ori.w #5,d1
     7ea:	move.w d1,24(a0)
    *copListEnd++ = COP_WAIT;
     7ee:	move.w #-2,26(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     7f4:	move.w #384,28(a0)
    *copListCurrent++ = color;
     7fa:	move.w d2,30(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// set bitplane mods
	line = 0x2c + BmpLogo.Height + 72 + 7; // 209
     7fe:	move.b 238e3 <BmpLogo+0x3>,d0
     804:	addi.b #123,d0
	copPtr = copWaitY(copPtr, line++);
     808:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     80e:	lsl.l #8,d0
     810:	ori.w #5,d0
     814:	move.w d0,32(a0)
    *copListEnd++ = COP_WAIT;
     818:	move.w #-2,34(a0)
	copMirrorBmpP = copPtr;
     81e:	lea 36(a0),a2
     822:	move.l a2,23768 <copMirrorBmpP>
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     828:	move.w 238e8 <BmpLogo+0x8>,d0
     82e:	sub.w 238e6 <BmpLogo+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     834:	move.w #264,36(a0)
    *copListEnd++ = modOdd;
     83a:	move.w d0,38(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     83e:	move.w #266,40(a0)
    *copListEnd++ = modEven;
     844:	move.w d0,42(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     848:	move.w #-31,44(a0)
    *copListEnd++ = COP_WAIT;
     84e:	move.w #-2,46(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     854:	move.w #1285,48(a0)
    *copListEnd++ = COP_WAIT;
     85a:	move.w #-2,50(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     860:	move.w #384,52(a0)
    *copListCurrent++ = color;
     866:	move.w a1,54(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     86a:	move.w #1541,56(a0)
    *copListEnd++ = COP_WAIT;
     870:	move.w #-2,58(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     876:	move.w #384,60(a0)
    *copListCurrent++ = color;
     87c:	move.w d2,62(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     880:	move.w #11269,64(a0)
    *copListEnd++ = COP_WAIT;
     886:	move.w #-2,66(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     88c:	move.w #384,68(a0)
    *copListCurrent++ = color;
     892:	move.w a1,70(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     896:	move.w #11525,72(a0)
    *copListEnd++ = COP_WAIT;
     89c:	move.w #-2,74(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     8a2:	move.w #384,76(a0)
    *copListCurrent++ = color;
     8a8:	move.w d2,78(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     8ac:	move.w #-1,80(a0)
    *copListEnd++ = COP_WAIT;
     8b2:	move.w #-2,82(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// copper end
	copPtr = copWaitXY(copPtr, 0xff, 0xff);
}
     8b8:	movem.l (sp)+,d2-d5/a2
     8bc:	rts

000008be <EnableMirrorEffect>:

void EnableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2),
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
     8be:	move.w 23820 <BmpScroller+0x8>,d0
     8c4:	move.w d0,d1
     8c6:	sub.w 23918 <Screen+0x6>,d1
     8cc:	add.w d0,d0
     8ce:	sub.w d0,d1
	copSetBplMod(0, copMirrorBmpP,
     8d0:	movea.l 23768 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     8d6:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     8da:	move.w d1,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     8de:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     8e4:	move.w d1,6(a0)
}
     8e8:	rts

000008ea <DisableMirrorEffect>:

void DisableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 BmpScroller.Bplt - Screen.Bpl,
				 BmpScroller.Bplt - Screen.Bpl);
     8ea:	move.w 23820 <BmpScroller+0x8>,d0
     8f0:	sub.w 23918 <Screen+0x6>,d0
	copSetBplMod(0, copMirrorBmpP,
     8f6:	movea.l 23768 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     8fc:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     900:	move.w d0,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     904:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     90a:	move.w d0,6(a0)
}
     90e:	rts

00000910 <PlotChar>:
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
	}
}

void PlotChar(BmpDescriptor bmpFont, BmpDescriptor bmpDest, USHORT plotY, USHORT charW, USHORT charH)
{
     910:	movem.l d2-d6/a2/a6,-(sp)
     914:	move.l 136(sp),d5
     918:	move.l 140(sp),d3
     91c:	move.l 144(sp),d4
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     920:	move.w 23764 <ScrolltextCnt>,d0
     926:	move.w d0,d1
     928:	addq.w #1,d1
     92a:	move.w d1,23764 <ScrolltextCnt>
     930:	andi.l #65535,d0
     936:	lea 474b <Scrolltext>,a0
     93c:	move.b (0,a0,d0.l),d0
	ULONG source, dest;
	ULONG row, col;

	// Set standard char distance
	NextPlot = 32;
     940:	move.w #32,6000 <NextPlot>
	// scroller commands: b=bounce; m=mirror; s=stop; c=color
	if (chr == 'b')
     948:	cmpi.b #98,d0
     94c:	beq.w aa0 <PlotChar+0x190>
		}
		BounceEnabled = !BounceEnabled;

		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'm')
     950:	cmpi.b #109,d0
     954:	beq.w ae2 <PlotChar+0x1d2>
		}

		MirrorEnabled = !MirrorEnabled;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 's')
     958:	cmpi.b #115,d0
     95c:	beq.w b2a <PlotChar+0x21a>
	{
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'c')
     960:	cmpi.b #99,d0
     964:	beq.w bb0 <PlotChar+0x2a0>
		colScrollMirror[0] = 0x6bf;
		colScrollMirror[1] = 0x49b;
		ResetCopper = TRUE;
	}
	// select character for different spacing
	if (chr == '!' || chr == 'I' || chr == '.' || chr == ',' || chr == ':' || chr == ';' || chr == '\'')
     968:	cmpi.b #33,d0
     96c:	beq.s 992 <PlotChar+0x82>
     96e:	cmpi.b #73,d0
     972:	beq.s 992 <PlotChar+0x82>
     974:	cmpi.b #46,d0
     978:	beq.s 992 <PlotChar+0x82>
     97a:	cmpi.b #44,d0
     97e:	beq.s 992 <PlotChar+0x82>
     980:	cmpi.b #58,d0
     984:	beq.s 992 <PlotChar+0x82>
     986:	cmpi.b #59,d0
     98a:	beq.s 992 <PlotChar+0x82>
     98c:	cmpi.b #39,d0
     990:	bne.s 99a <PlotChar+0x8a>
	{
		NextPlot = 12;
     992:	move.w #12,6000 <NextPlot>
	}
	if (chr == 'J')
     99a:	cmpi.b #74,d0
     99e:	beq.w bcc <PlotChar+0x2bc>
	{
		NextPlot = 24;
	}
	// check for end of text
	if (chr == 0)
     9a2:	tst.b d0
     9a4:	bne.s 9ce <PlotChar+0xbe>
	{
		ScrolltextCnt = 0;
     9a6:	clr.w 23764 <ScrolltextCnt>
		chr = Scrolltext[ScrolltextCnt++];
     9ac:	move.w #1,23764 <ScrolltextCnt>
		colScrollMirror[0] = 0x111;
     9b4:	move.w #273,6002 <colScrollMirror>
		colScrollMirror[1] = 0x222;
     9bc:	move.w #546,6004 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     9c4:	move.w #1,2377c <ResetCopper>
		chr = Scrolltext[ScrolltextCnt++];
     9cc:	moveq #32,d0
	}
	// check legal values
	if (chr < 32 || chr > (32 + 80))
     9ce:	addi.b #-32,d0
     9d2:	cmpi.b #80,d0
     9d6:	bhi.w a9a <PlotChar+0x18a>
		return;
	}
	// skip first 32 ascii codes
	chr -= 32;
	// get row and column of source bitmap (10 chrs per row)
	row = chr / 10;
     9da:	andi.w #255,d0
     9de:	move.w d0,d6
     9e0:	mulu.w #-13107,d6
     9e4:	clr.w d6
     9e6:	swap d6
     9e8:	lsr.w #3,d6
	col = chr % 10;
     9ea:	move.w d6,d1
     9ec:	add.w d6,d1
     9ee:	add.w d1,d1
     9f0:	add.w d6,d1
     9f2:	add.w d1,d1
     9f4:	sub.w d1,d0
     9f6:	moveq #0,d2
     9f8:	move.b d0,d2
	// calc source bitplane pointer
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     9fa:	moveq #0,d0
     9fc:	move.w 40(sp),d0
     a00:	lea 2bac <__mulsi3>,a2
     a06:	moveq #31,d1
     a08:	and.l d6,d1
     a0a:	move.l d1,-(sp)
     a0c:	move.l d0,-(sp)
     a0e:	jsr (a2)
     a10:	addq.l #8,sp
     a12:	move.l d0,-(sp)
     a14:	move.w d4,-(sp)
     a16:	clr.w -(sp)
     a18:	jsr (a2)
     a1a:	addq.l #8,sp
     a1c:	add.l d2,d2
     a1e:	add.l d2,d2
     a20:	add.l d0,d2
	// calc destination bitplane pointer
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     a22:	moveq #0,d0
     a24:	move.w 92(sp),d0
     a28:	move.l d0,-(sp)
     a2a:	move.w d5,-(sp)
     a2c:	clr.w -(sp)
     a2e:	jsr (a2)
     a30:	addq.l #8,sp
     a32:	moveq #0,d5
     a34:	move.w 23918 <Screen+0x6>,d5
     a3a:	add.l d0,d5
	// wait for blitter and blit
	WaitBlit();
     a3c:	movea.l 23948 <GfxBase>,a6
     a42:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     a46:	movea.l 23952 <custom>,a0
     a4c:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     a52:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     a58:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     a5e:	move.w #-1,70(a0)
	custom->bltapt = ((UBYTE *)bmpFont.ImageData) + source;
     a64:	add.l 46(sp),d2
     a68:	move.l d2,80(a0)
	custom->bltdpt = ((UBYTE *)bmpDest.ImageData) + dest;
     a6c:	add.l 98(sp),d5
     a70:	move.l d5,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     a74:	move.w d3,d0
     a76:	lsr.w #3,d0
     a78:	move.w 38(sp),d1
     a7c:	sub.w d0,d1
     a7e:	move.w d1,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     a82:	move.w 90(sp),d1
     a86:	sub.w d0,d1
     a88:	move.w d1,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     a8c:	muls.w 36(sp),d4
     a90:	lsl.w #6,d4
     a92:	lsr.w #4,d3
     a94:	add.w d4,d3
     a96:	move.w d3,88(a0)
}
     a9a:	movem.l (sp)+,d2-d6/a2/a6
     a9e:	rts
		if (BounceEnabled)
     aa0:	move.w 2377a <BounceEnabled>,d0
     aa6:	beq.s ab6 <PlotChar+0x1a6>
			ScrollerY = SCRT_MIN;
     aa8:	clr.w 23778 <ScrollerY>
			ScrollerDir = 1;
     aae:	move.b #1,6088 <ScrollerDir>
		BounceEnabled = !BounceEnabled;
     ab6:	tst.w d0
     ab8:	seq d0
     aba:	ext.w d0
     abc:	neg.w d0
     abe:	move.w d0,2377a <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     ac4:	move.w d1,d0
     ac6:	addq.w #1,d0
     ac8:	move.w d0,23764 <ScrolltextCnt>
     ace:	andi.l #65535,d1
     ad4:	lea 474b <Scrolltext>,a0
     ada:	move.b (0,a0,d1.l),d0
     ade:	bra.w 950 <PlotChar+0x40>
		if (MirrorEnabled)
     ae2:	tst.w 23762 <MirrorEnabled>
     ae8:	beq.s b24 <PlotChar+0x214>
			DisableMirrorEffect();
     aea:	jsr 8ea <DisableMirrorEffect>(pc)
		MirrorEnabled = !MirrorEnabled;
     aee:	tst.w 23762 <MirrorEnabled>
     af4:	seq d0
     af6:	ext.w d0
     af8:	neg.w d0
     afa:	move.w d0,23762 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     b00:	move.w 23764 <ScrolltextCnt>,d0
     b06:	move.w d0,d1
     b08:	addq.w #1,d1
     b0a:	move.w d1,23764 <ScrolltextCnt>
     b10:	andi.l #65535,d0
     b16:	lea 474b <Scrolltext>,a0
     b1c:	move.b (0,a0,d0.l),d0
     b20:	bra.w 958 <PlotChar+0x48>
			EnableMirrorEffect();
     b24:	jsr 8be <EnableMirrorEffect>(pc)
     b28:	bra.s aee <PlotChar+0x1de>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     b2a:	tst.w 2377a <BounceEnabled>
     b30:	beq.s b82 <PlotChar+0x272>
     b32:	move.w 23764 <ScrolltextCnt>,d0
     b38:	move.w d0,d1
     b3a:	addq.w #1,d1
     b3c:	move.w d1,23764 <ScrolltextCnt>
     b42:	andi.l #65535,d0
     b48:	lea 474b <Scrolltext>,a0
     b4e:	move.b (0,a0,d0.l),d0
     b52:	ext.w d0
     b54:	addi.w #-48,d0
     b58:	move.w d0,23776 <ScrollerPause>
		chr = Scrolltext[ScrolltextCnt++];
     b5e:	move.w 23764 <ScrolltextCnt>,d0
     b64:	move.w d0,d1
     b66:	addq.w #1,d1
     b68:	move.w d1,23764 <ScrolltextCnt>
     b6e:	andi.l #65535,d0
     b74:	lea 474b <Scrolltext>,a0
     b7a:	move.b (0,a0,d0.l),d0
     b7e:	bra.w 960 <PlotChar+0x50>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     b82:	move.w 23764 <ScrolltextCnt>,d0
     b88:	move.w d0,d1
     b8a:	addq.w #1,d1
     b8c:	move.w d1,23764 <ScrolltextCnt>
     b92:	andi.l #65535,d0
     b98:	lea 474b <Scrolltext>,a0
     b9e:	move.b (0,a0,d0.l),d0
     ba2:	ext.w d0
     ba4:	movea.w d0,a0
     ba6:	moveq #-48,d0
     ba8:	add.l a0,d0
     baa:	muls.w #50,d0
     bae:	bra.s b58 <PlotChar+0x248>
		colScrollMirror[0] = 0x6bf;
     bb0:	move.w #1727,6002 <colScrollMirror>
		colScrollMirror[1] = 0x49b;
     bb8:	move.w #1179,6004 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     bc0:	move.w #1,2377c <ResetCopper>
     bc8:	bra.w 968 <PlotChar+0x58>
		NextPlot = 24;
     bcc:	move.w #24,6000 <NextPlot>
     bd4:	bra.w 9a2 <PlotChar+0x92>

00000bd8 <Scrollit>:
{
     bd8:	movem.l d2-d7/a2/a6,-(sp)
     bdc:	move.l 96(sp),d3
     be0:	move.l 100(sp),d4
	int BltOffs = startY * theDesc.Bplt;
     be4:	moveq #0,d5
     be6:	move.w 94(sp),d5
     bea:	moveq #0,d6
     bec:	move.w 44(sp),d6
     bf0:	lea 2bac <__mulsi3>,a2
     bf6:	move.l d6,-(sp)
     bf8:	move.l d5,-(sp)
     bfa:	jsr (a2)
     bfc:	addq.l #8,sp
     bfe:	move.l d0,d2
	int Brcorner = height * theDesc.Bplt - 2;
     c00:	move.l d6,-(sp)
     c02:	move.w d3,-(sp)
     c04:	clr.w -(sp)
     c06:	jsr (a2)
     c08:	addq.l #8,sp
     c0a:	move.l d0,d7
     c0c:	subq.l #2,d7
	WaitBlit();
     c0e:	movea.l 23948 <GfxBase>,a6
     c14:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     c18:	clr.w d6
     c1a:	move.b d4,d6
     c1c:	moveq #12,d0
     c1e:	lsl.w d0,d4
     c20:	movea.l 23952 <custom>,a0
     c26:	addi.w #2544,d4
     c2a:	move.w d4,64(a0)
	custom->bltcon1 = 0x0002;
     c2e:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     c34:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     c3a:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     c40:	move.l d2,d0
     c42:	add.l d7,d0
     c44:	add.l 88(sp),d0
     c48:	move.l d0,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     c4c:	move.l d0,84(a0)
	custom->bltamod = 0;
     c50:	move.w #0,100(a0)
	custom->bltdmod = 0;
     c56:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
     c5c:	move.w 40(sp),d0
     c60:	muls.w d3,d0
     c62:	lsl.w #6,d0
     c64:	move.w 23818 <BmpScroller>,d1
     c6a:	lsr.w #4,d1
     c6c:	add.w d1,d0
     c6e:	move.w d0,88(a0)
	ScrollCnt += speed;
     c72:	add.w 23766 <ScrollCnt>,d6
     c78:	move.w d6,23766 <ScrollCnt>
	if (ScrollCnt >= NextPlot)
     c7e:	cmp.w 6000 <NextPlot>,d6
     c84:	bcc.s c8c <Scrollit+0xb4>
}
     c86:	movem.l (sp)+,d2-d7/a2/a6
     c8a:	rts
		ScrollCnt = 0;
     c8c:	clr.w 23766 <ScrollCnt>
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
     c92:	pea 20 <_start+0x20>
     c96:	pea 20 <_start+0x20>
     c9a:	move.l d5,-(sp)
     c9c:	subq.l #2,sp
     c9e:	move.l 23846 <BmpScroller+0x2e>,-(sp)
     ca4:	move.l 23842 <BmpScroller+0x2a>,-(sp)
     caa:	move.l 2383e <BmpScroller+0x26>,-(sp)
     cb0:	move.l 2383a <BmpScroller+0x22>,-(sp)
     cb6:	move.l 23836 <BmpScroller+0x1e>,-(sp)
     cbc:	move.l 23832 <BmpScroller+0x1a>,-(sp)
     cc2:	move.l 2382e <BmpScroller+0x16>,-(sp)
     cc8:	move.l 2382a <BmpScroller+0x12>,-(sp)
     cce:	move.l 23826 <BmpScroller+0xe>,-(sp)
     cd4:	move.l 23822 <BmpScroller+0xa>,-(sp)
     cda:	move.l 2381e <BmpScroller+0x6>,-(sp)
     ce0:	move.l 2381a <BmpScroller+0x2>,-(sp)
     ce6:	move.w 23818 <BmpScroller>,-(sp)
     cec:	subq.l #2,sp
     cee:	move.l 23814 <BmpFont32+0x2e>,-(sp)
     cf4:	move.l 23810 <BmpFont32+0x2a>,-(sp)
     cfa:	move.l 2380c <BmpFont32+0x26>,-(sp)
     d00:	move.l 23808 <BmpFont32+0x22>,-(sp)
     d06:	move.l 23804 <BmpFont32+0x1e>,-(sp)
     d0c:	move.l 23800 <BmpFont32+0x1a>,-(sp)
     d12:	move.l 237fc <BmpFont32+0x16>,-(sp)
     d18:	move.l 237f8 <BmpFont32+0x12>,-(sp)
     d1e:	move.l 237f4 <BmpFont32+0xe>,-(sp)
     d24:	move.l 237f0 <BmpFont32+0xa>,-(sp)
     d2a:	move.l 237ec <BmpFont32+0x6>,-(sp)
     d30:	move.l 237e8 <BmpFont32+0x2>,-(sp)
     d36:	move.w 237e6 <BmpFont32>,-(sp)
     d3c:	jsr 910 <PlotChar>(pc)
     d40:	lea 116(sp),sp
     d44:	bra.w c86 <Scrollit+0xae>

00000d48 <GetVBR>:

static APTR GetVBR()
{
     d48:	subq.l #8,sp
     d4a:	move.l a6,-(sp)
     d4c:	move.l d7,-(sp)
	APTR vbr = 0;
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     d4e:	move.w #20090,10(sp)
     d54:	move.w #2049,12(sp)
     d5a:	move.w #20083,14(sp)

	if (SysBase->AttnFlags & AFF_68010)
     d60:	movea.l 2394c <SysBase>,a6
     d66:	btst #0,297(a6)
     d6c:	beq.s d82 <GetVBR+0x3a>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     d6e:	moveq #10,d7
     d70:	add.l sp,d7
     d72:	exg d7,a5
     d74:	jsr -30(a6)
     d78:	exg d7,a5

	return vbr;
}
     d7a:	move.l (sp)+,d7
     d7c:	movea.l (sp)+,a6
     d7e:	addq.l #8,sp
     d80:	rts
	APTR vbr = 0;
     d82:	moveq #0,d0
	return vbr;
     d84:	bra.s d7a <GetVBR+0x32>

00000d86 <SetInterruptHandler>:

void SetInterruptHandler(APTR interrupt)
{
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     d86:	movea.l 2375e <VBR>,a0
     d8c:	move.l 4(sp),108(a0)
}
     d92:	rts

00000d94 <GetInterruptHandler>:

APTR GetInterruptHandler()
{
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     d94:	movea.l 2375e <VBR>,a0
     d9a:	move.l 108(a0),d0
}
     d9e:	rts

00000da0 <WaitVbl>:

//vblank begins at vpos 312 hpos 1 and ends at vpos 25 hpos 1
//vsync begins at line 2 hpos 132 and ends at vpos 5 hpos 18
void WaitVbl()
{
     da0:	subq.l #8,sp
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     da2:	move.l dff004 <_end+0xddb6ac>,d0
     da8:	move.l d0,(sp)
		vpos &= 0x1ff00;
     daa:	move.l (sp),d0
     dac:	andi.l #130816,d0
     db2:	move.l d0,(sp)
		if (vpos != (311 << 8))
     db4:	move.l (sp),d0
     db6:	cmpi.l #79616,d0
     dbc:	beq.s da2 <WaitVbl+0x2>
			break;
	}
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     dbe:	move.l dff004 <_end+0xddb6ac>,d0
     dc4:	move.l d0,4(sp)
		vpos &= 0x1ff00;
     dc8:	move.l 4(sp),d0
     dcc:	andi.l #130816,d0
     dd2:	move.l d0,4(sp)
		if (vpos == (311 << 8))
     dd6:	move.l 4(sp),d0
     dda:	cmpi.l #79616,d0
     de0:	bne.s dbe <WaitVbl+0x1e>
			break;
	}
}
     de2:	addq.l #8,sp
     de4:	rts

00000de6 <TakeSystem>:
	{
	} //blitter busy wait
}

void TakeSystem()
{
     de6:	move.l a6,-(sp)
     de8:	move.l a2,-(sp)
	ActiView = GfxBase->ActiView; //store current view
     dea:	movea.l 23948 <GfxBase>,a6
     df0:	move.l 34(a6),2375a <ActiView>
	OwnBlitter();
     df8:	jsr -456(a6)
	WaitBlit();
     dfc:	movea.l 23948 <GfxBase>,a6
     e02:	jsr -228(a6)
	Disable();
     e06:	movea.l 2394c <SysBase>,a6
     e0c:	jsr -120(a6)

	//Save current interrupts and DMA settings so we can restore them upon exit.
	SystemADKCON = custom->adkconr;
     e10:	movea.l 23952 <custom>,a0
     e16:	move.w 16(a0),d0
     e1a:	move.w d0,23758 <SystemADKCON>
	SystemInts = custom->intenar;
     e20:	move.w 28(a0),d0
     e24:	move.w d0,23756 <SystemInts>
	SystemDMA = custom->dmaconr;
     e2a:	move.w 2(a0),d0
     e2e:	move.w d0,23754 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     e34:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     e3a:	move.w #32767,156(a0)

	WaitVbl();
     e40:	lea da0 <WaitVbl>(pc),a2
     e44:	jsr (a2)
	WaitVbl();
     e46:	jsr (a2)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     e48:	movea.l 23952 <custom>,a0
     e4e:	move.w #32767,150(a0)

	//set all colors black
	for (int a = 0; a < 32; a++)
     e54:	moveq #0,d1
     e56:	bra.s e6a <TakeSystem+0x84>
		custom->color[a] = 0;
     e58:	move.l d1,d0
     e5a:	addi.l #192,d0
     e60:	add.l d0,d0
     e62:	move.w #0,(0,a0,d0.l)
	for (int a = 0; a < 32; a++)
     e68:	addq.l #1,d1
     e6a:	moveq #31,d0
     e6c:	cmp.l d1,d0
     e6e:	bge.s e58 <TakeSystem+0x72>

	LoadView(0);
     e70:	movea.l 23948 <GfxBase>,a6
     e76:	suba.l a1,a1
     e78:	jsr -222(a6)
	WaitTOF();
     e7c:	movea.l 23948 <GfxBase>,a6
     e82:	jsr -270(a6)
	WaitTOF();
     e86:	movea.l 23948 <GfxBase>,a6
     e8c:	jsr -270(a6)

	WaitVbl();
     e90:	lea da0 <WaitVbl>(pc),a2
     e94:	jsr (a2)
	WaitVbl();
     e96:	jsr (a2)

	VBR = GetVBR();
     e98:	jsr d48 <GetVBR>(pc)
     e9c:	move.l d0,2375e <VBR>
	SystemIrq = GetInterruptHandler(); //store interrupt register
     ea2:	jsr d94 <GetInterruptHandler>(pc)
     ea6:	move.l d0,23750 <SystemIrq>
}
     eac:	movea.l (sp)+,a2
     eae:	movea.l (sp)+,a6
     eb0:	rts

00000eb2 <FreeSystem>:

void FreeSystem()
{
     eb2:	move.l a6,-(sp)
	WaitVbl();
     eb4:	jsr da0 <WaitVbl>(pc)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     eb8:	movea.l 23952 <custom>,a0
     ebe:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     ec2:	move.w 2(a0),d0
     ec6:	btst #14,d0
     eca:	bne.s ec2 <FreeSystem+0x10>
	WaitBlt();
	custom->intena = 0x7fff; //disable all interrupts
     ecc:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     ed2:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     ed8:	move.w #32767,150(a0)

	//restore interrupts
	SetInterruptHandler(SystemIrq);
     ede:	move.l 23750 <SystemIrq>,-(sp)
     ee4:	jsr d86 <SetInterruptHandler>(pc)

	/*Restore system copper list(s). */
	custom->cop1lc = (ULONG)GfxBase->copinit;
     ee8:	movea.l 23948 <GfxBase>,a6
     eee:	movea.l 23952 <custom>,a0
     ef4:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     efa:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     f00:	move.w #32767,136(a0)

	/*Restore all interrupts and DMA settings. */
	custom->intena = SystemInts | 0x8000;
     f06:	move.w 23756 <SystemInts>,d0
     f0c:	ori.w #-32768,d0
     f10:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     f14:	move.w 23754 <SystemDMA>,d0
     f1a:	ori.w #-32768,d0
     f1e:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     f22:	move.w 23758 <SystemADKCON>,d0
     f28:	ori.w #-32768,d0
     f2c:	move.w d0,158(a0)

	LoadView(ActiView);
     f30:	movea.l 2375a <ActiView>,a1
     f36:	jsr -222(a6)
	WaitTOF();
     f3a:	movea.l 23948 <GfxBase>,a6
     f40:	jsr -270(a6)
	WaitTOF();
     f44:	movea.l 23948 <GfxBase>,a6
     f4a:	jsr -270(a6)
	WaitBlit();
     f4e:	movea.l 23948 <GfxBase>,a6
     f54:	jsr -228(a6)
	DisownBlitter();
     f58:	movea.l 23948 <GfxBase>,a6
     f5e:	jsr -462(a6)
	Enable();
     f62:	movea.l 2394c <SysBase>,a6
     f68:	jsr -126(a6)
     f6c:	addq.l #4,sp
}
     f6e:	movea.l (sp)+,a6
     f70:	rts

00000f72 <InitImagePlanes>:

void InitImagePlanes(BmpDescriptor *img)
{
     f72:	movem.l d2-d3/a2,-(sp)
     f76:	movea.l 16(sp),a2
	for (int p = 0; p < img->Bpls; p++)
     f7a:	moveq #0,d2
     f7c:	bra.s fa2 <InitImagePlanes+0x30>
	{
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     f7e:	move.l 14(a2),d3
     f82:	moveq #0,d0
     f84:	move.w 6(a2),d0
     f88:	move.l d2,-(sp)
     f8a:	move.l d0,-(sp)
     f8c:	jsr 2bac <__mulsi3>
     f92:	addq.l #8,sp
     f94:	move.l d2,d1
     f96:	add.l d2,d1
     f98:	add.l d1,d1
     f9a:	add.l d0,d3
     f9c:	move.l d3,(18,a2,d1.l)
	for (int p = 0; p < img->Bpls; p++)
     fa0:	addq.l #1,d2
     fa2:	moveq #0,d0
     fa4:	move.w 4(a2),d0
     fa8:	cmp.l d0,d2
     faa:	blt.s f7e <InitImagePlanes+0xc>
	}
}
     fac:	movem.l (sp)+,d2-d3/a2
     fb0:	rts

00000fb2 <CopyBitmap>:
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     fb2:	movea.l 23952 <custom>,a0
     fb8:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     fbc:	move.w 2(a0),d0
     fc0:	btst #14,d0
     fc4:	bne.s fbc <CopyBitmap+0xa>

void CopyBitmap(BmpDescriptor bmpS, BmpDescriptor bmpD)
{
	WaitBlt();

	custom->bltcon0 = 0x09f0;
     fc6:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     fcc:	move.w #0,66(a0)
	custom->bltapt = (UBYTE *)bmpS.ImageData;
     fd2:	move.l 18(sp),80(a0)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
     fd8:	move.l 70(sp),84(a0)
	custom->bltafwm = 0xffff;
     fde:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     fe4:	move.w #-1,70(a0)
	custom->bltamod = 0;
     fea:	move.w #0,100(a0)
	custom->bltdmod = 0;
     ff0:	move.w #0,102(a0)
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
     ff6:	move.w 6(sp),d1
     ffa:	muls.w 8(sp),d1
     ffe:	lsl.w #6,d1
    1000:	move.w 10(sp),d0
    1004:	lsr.w #1,d0
    1006:	add.w d1,d0
    1008:	move.w d0,88(a0)
}
    100c:	rts

0000100e <ClearBitmapPart>:
	custom->bltdmod = 0;
	custom->bltsize = ((lines * bmpD.Bpls) << 6) + (bmpD.Width / 16);
}

void ClearBitmapPart(BmpDescriptor bmp, int x, int y, int height, int width)
{
    100e:	movem.l d2-d5/a2-a3,-(sp)
    1012:	move.l 80(sp),d5
    1016:	movea.l 92(sp),a3
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    101a:	movea.l 23952 <custom>,a2
    1020:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1024:	move.w 2(a2),d0
    1028:	btst #14,d0
    102c:	bne.s 1024 <ClearBitmapPart+0x16>
	WaitBlt();
	BYTE shift = x % 16;
    102e:	move.l d5,d2
    1030:	andi.l #-2147483633,d2
    1036:	tst.l d5
    1038:	blt.w 10d4 <ClearBitmapPart+0xc6>
	if (shift)
    103c:	tst.b d2
    103e:	beq.s 1044 <ClearBitmapPart+0x36>
		width += 16;
    1040:	lea 16(a3),a3
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1044:	move.b d2,d0
    1046:	ext.w d0
    1048:	move.w d0,d4
    104a:	ext.l d4
    104c:	move.l d4,d1
    104e:	moveq #12,d3
    1050:	lsl.l d3,d1
    1052:	ori.w #2304,d1
    1056:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    105a:	moveq #12,d1
    105c:	lsl.w d1,d0
    105e:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1062:	move.l 42(sp),d3
    1066:	moveq #0,d0
    1068:	move.w 36(sp),d0
    106c:	move.l 84(sp),-(sp)
    1070:	move.l d0,-(sp)
    1072:	jsr 2bac <__mulsi3>
    1078:	addq.l #8,sp
    107a:	move.l d5,d1
    107c:	bmi.s 10e0 <ClearBitmapPart+0xd2>
    107e:	asr.l #3,d1
    1080:	add.l d1,d0
    1082:	add.l d3,d0
    1084:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1088:	move.l d0,84(a2)
	custom->bltafwm = 0xffff;
    108c:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1092:	tst.b d2
    1094:	beq.s 10e4 <ClearBitmapPart+0xd6>
    1096:	moveq #15,d1
    1098:	sub.l d4,d1
    109a:	moveq #0,d0
    109c:	not.w d0
    109e:	asr.l d1,d0
    10a0:	move.w d0,70(a2)
	;
	custom->bltamod = bmp.Bpl - (width / 8);
    10a4:	move.w 34(sp),d0
    10a8:	move.l a3,d1
    10aa:	bmi.s 10e8 <ClearBitmapPart+0xda>
    10ac:	asr.l #3,d1
    10ae:	sub.w d1,d0
    10b0:	move.w d0,100(a2)
	custom->bltdmod = bmp.Bpl - (width / 8);
    10b4:	move.w d0,102(a2)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    10b8:	move.w 32(sp),d0
    10bc:	muls.w 90(sp),d0
    10c0:	lsl.w #6,d0
    10c2:	move.l a3,d1
    10c4:	bmi.s 10ec <ClearBitmapPart+0xde>
    10c6:	asr.l #4,d1
    10c8:	add.w d1,d0
    10ca:	move.w d0,88(a2)
}
    10ce:	movem.l (sp)+,d2-d5/a2-a3
    10d2:	rts
	BYTE shift = x % 16;
    10d4:	subq.l #1,d2
    10d6:	moveq #-16,d0
    10d8:	or.l d0,d2
    10da:	addq.l #1,d2
    10dc:	bra.w 103c <ClearBitmapPart+0x2e>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    10e0:	addq.l #7,d1
    10e2:	bra.s 107e <ClearBitmapPart+0x70>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    10e4:	moveq #-1,d0
    10e6:	bra.s 10a0 <ClearBitmapPart+0x92>
	custom->bltamod = bmp.Bpl - (width / 8);
    10e8:	addq.l #7,d1
    10ea:	bra.s 10ac <ClearBitmapPart+0x9e>
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    10ec:	moveq #15,d1
    10ee:	add.l a3,d1
    10f0:	bra.s 10c6 <ClearBitmapPart+0xb8>

000010f2 <SimpleBlit>:

void SimpleBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    10f2:	movem.l d2-d7/a2,-(sp)
    10f6:	move.l 136(sp),d7
    10fa:	move.l 140(sp),d1
    10fe:	move.l 144(sp),d4
    1102:	move.l 148(sp),d5
    1106:	move.l 152(sp),d3
    110a:	move.l 156(sp),d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    110e:	movea.l 23952 <custom>,a2
    1114:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1118:	move.w 2(a2),d0
    111c:	btst #14,d0
    1120:	bne.s 1118 <SimpleBlit+0x26>
	WaitBlt();
	custom->bltcon0 = 0x09f0;
    1122:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
    1128:	move.w #0,66(a2)
	custom->bltafwm = 0xffff;
    112e:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    1134:	move.w #-1,70(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
    113a:	move.w d2,d0
    113c:	lsr.w #3,d0
    113e:	movea.w 38(sp),a0
    1142:	suba.w d0,a0
    1144:	move.w a0,100(a2)
	custom->bltdmod = imgD.Bpl - (width / 8);
    1148:	movea.w 90(sp),a0
    114c:	suba.w d0,a0
    114e:	move.w a0,102(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1152:	move.l 46(sp),d6
    1156:	moveq #0,d0
    1158:	move.w 40(sp),d0
    115c:	move.l d0,-(sp)
    115e:	move.l d1,-(sp)
    1160:	jsr 2bac <__mulsi3>
    1166:	addq.l #8,sp
    1168:	move.l d7,d1
    116a:	bmi.s 11ae <SimpleBlit+0xbc>
    116c:	asr.l #3,d1
    116e:	add.l d1,d0
    1170:	add.l d6,d0
    1172:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1176:	move.l 98(sp),d6
    117a:	moveq #0,d0
    117c:	move.w 92(sp),d0
    1180:	move.l d0,-(sp)
    1182:	move.l d5,-(sp)
    1184:	jsr 2bac <__mulsi3>
    118a:	addq.l #8,sp
    118c:	move.l d4,d1
    118e:	bmi.s 11b2 <SimpleBlit+0xc0>
    1190:	asr.l #3,d1
    1192:	add.l d1,d0
    1194:	add.l d6,d0
    1196:	move.l d0,84(a2)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
    119a:	muls.w 36(sp),d3
    119e:	lsl.w #6,d3
    11a0:	lsr.w #4,d2
    11a2:	add.w d3,d2
    11a4:	move.w d2,88(a2)
}
    11a8:	movem.l (sp)+,d2-d7/a2
    11ac:	rts
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    11ae:	addq.l #7,d1
    11b0:	bra.s 116c <SimpleBlit+0x7a>
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    11b2:	addq.l #7,d1
    11b4:	bra.s 1190 <SimpleBlit+0x9e>

000011b6 <BetterBlit>:

void BetterBlit(BmpDescriptor imgS, BmpDescriptor imgD, BmpDescriptor imgM, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    11b6:	movem.l d2-d7/a2-a6,-(sp)
    11ba:	movea.l 204(sp),a3
    11be:	move.l 208(sp),d7
    11c2:	move.l 212(sp),d5
    11c6:	movea.l 216(sp),a5
    11ca:	movea.l 220(sp),a4
    11ce:	move.l 224(sp),d1
    11d2:	move.w d1,d4
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    11d4:	movea.l 23952 <custom>,a2
    11da:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    11de:	move.w 2(a2),d0
    11e2:	btst #14,d0
    11e6:	bne.s 11de <BetterBlit+0x28>
	WaitBlt();
	BYTE shift = startD.X % 16;
    11e8:	move.l d5,d3
    11ea:	andi.l #-2147483633,d3
    11f0:	tst.l d5
    11f2:	blt.w 12e6 <BetterBlit+0x130>
	if (shift)
    11f6:	tst.b d3
    11f8:	beq.s 1200 <BetterBlit+0x4a>
		width += 16;
    11fa:	move.w d1,d4
    11fc:	addi.w #16,d4

	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1200:	move.b d3,d0
    1202:	ext.w d0
    1204:	movea.w d0,a6
    1206:	move.l a6,d1
    1208:	moveq #12,d2
    120a:	lsl.l d2,d1
    120c:	ori.w #4042,d1
    1210:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1214:	moveq #12,d1
    1216:	lsl.w d1,d0
    1218:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    121c:	move.l 62(sp),d6
    1220:	moveq #0,d0
    1222:	move.w 56(sp),d0
    1226:	move.l d0,-(sp)
    1228:	move.l d7,-(sp)
    122a:	jsr 2bac <__mulsi3>
    1230:	addq.l #8,sp
    1232:	move.l a3,d2
    1234:	bmi.w 12f2 <BetterBlit+0x13c>
    1238:	asr.l #3,d2
    123a:	add.l d2,d0
    123c:	add.l d6,d0
    123e:	move.l d0,80(a2)
	custom->bltamod = imgS.Bpl - (width / 8);
    1242:	move.w d4,d6
    1244:	lsr.w #3,d6
    1246:	move.w 54(sp),d0
    124a:	sub.w d6,d0
    124c:	move.w d0,100(a2)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1250:	moveq #0,d0
    1252:	move.w 160(sp),d0
    1256:	lea 2bac <__mulsi3>,a3
    125c:	move.l d0,-(sp)
    125e:	move.l d7,-(sp)
    1260:	jsr (a3)
    1262:	addq.l #8,sp
    1264:	add.l d0,d2
    1266:	add.l 166(sp),d2
    126a:	move.l d2,76(a2)
	custom->bltbmod = imgM.Bpl - (width / 8);
    126e:	move.w 158(sp),d0
    1272:	sub.w d6,d0
    1274:	move.w d0,98(a2)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1278:	move.l 114(sp),d2
    127c:	moveq #0,d0
    127e:	move.w 108(sp),d0
    1282:	move.l d0,-(sp)
    1284:	move.l a5,-(sp)
    1286:	jsr (a3)
    1288:	addq.l #8,sp
    128a:	move.l d5,d1
    128c:	bmi.s 12f8 <BetterBlit+0x142>
    128e:	asr.l #3,d1
    1290:	add.l d1,d0
    1292:	add.l d2,d0
    1294:	move.l d0,84(a2)
    1298:	move.l d0,72(a2)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    129c:	move.w 106(sp),d0
    12a0:	sub.w d6,d0
    12a2:	move.w d0,102(a2)
    12a6:	move.w d0,96(a2)
	custom->bltafwm = 0xffff;
    12aa:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    12b0:	tst.b d3
    12b2:	beq.s 12fc <BetterBlit+0x146>
    12b4:	moveq #15,d1
    12b6:	sub.l a6,d1
    12b8:	moveq #0,d0
    12ba:	not.w d0
    12bc:	asr.l d1,d0
    12be:	move.w d0,70(a2)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    12c2:	moveq #0,d0
    12c4:	move.w 52(sp),d0
    12c8:	move.l d0,-(sp)
    12ca:	move.w a4,-(sp)
    12cc:	clr.w -(sp)
    12ce:	jsr 2bac <__mulsi3>
    12d4:	addq.l #8,sp
    12d6:	lsl.l #6,d0
    12d8:	lsr.w #4,d4
    12da:	or.w d0,d4
    12dc:	move.w d4,88(a2)
}
    12e0:	movem.l (sp)+,d2-d7/a2-a6
    12e4:	rts
	BYTE shift = startD.X % 16;
    12e6:	subq.l #1,d3
    12e8:	moveq #-16,d0
    12ea:	or.l d0,d3
    12ec:	addq.l #1,d3
    12ee:	bra.w 11f6 <BetterBlit+0x40>
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    12f2:	addq.l #7,d2
    12f4:	bra.w 1238 <BetterBlit+0x82>
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    12f8:	addq.l #7,d1
    12fa:	bra.s 128e <BetterBlit+0xd8>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    12fc:	moveq #-1,d0
    12fe:	bra.s 12be <BetterBlit+0x108>

00001300 <p61Init>:

int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
    1300:	move.l a3,-(sp)
    1302:	move.l a2,-(sp)
	register volatile const void *_a0 ASM("a0") = module;
    1304:	movea.l 12(sp),a0
	register volatile const void *_a1 ASM("a1") = NULL;
    1308:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
    130a:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
    130c:	lea 2d8a <incbin_P61_Player_start>,a3
	register int _d0 ASM("d0"); // return value
	__asm volatile(
    1312:	movem.l d1-d7/a4-a6,-(sp)
    1316:	jsr (a3)
    1318:	movem.l (sp)+,d1-d7/a4-a6
		"movem.l (%%sp)+,%%d1-%%d7/%%a4-%%a6"
		: "=r"(_d0), "+rf"(_a0), "+rf"(_a1), "+rf"(_a2), "+rf"(_a3)
		:
		: "cc", "memory");
	return _d0;
}
    131c:	movea.l (sp)+,a2
    131e:	movea.l (sp)+,a3
    1320:	rts

00001322 <p61Music>:

void p61Music()
{
    1322:	move.l a6,-(sp)
    1324:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    1326:	lea 2d8a <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    132c:	movea.l #14675968,a6
	__asm volatile(
    1332:	movem.l d0-a2/a4-a5,-(sp)
    1336:	jsr 4(a3)
    133a:	movem.l (sp)+,d0-a2/a4-a5
		"jsr 4(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d7/%%a0-%%a2/%%a4-%%a5"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    133e:	movea.l (sp)+,a3
    1340:	movea.l (sp)+,a6
    1342:	rts

00001344 <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);
// interrupt handler
static __attribute__((interrupt)) void interruptHandler()
{
    1344:	movem.l d0-d1/a0-a1,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    1348:	movea.l 23952 <custom>,a0
    134e:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    1354:	move.w #32,156(a0)

    // DEMO - ThePlayer
    p61Music();
    135a:	jsr 1322 <p61Music>(pc)

    // DEMO - increment frameCounter
    frameCounter++;
    135e:	move.w 23950 <frameCounter>,d0
    1364:	addq.w #1,d0
    1366:	move.w d0,23950 <frameCounter>
}
    136c:	movem.l (sp)+,d0-d1/a0-a1
    1370:	rte

00001372 <p61End>:

void p61End()
{
    1372:	move.l a6,-(sp)
    1374:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    1376:	lea 2d8a <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    137c:	movea.l #14675968,a6
	__asm volatile(
    1382:	movem.l d0-d1/a0-a1,-(sp)
    1386:	jsr 8(a3)
    138a:	movem.l (sp)+,d0-d1/a0-a1
		"jsr 8(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d1/%%a0-%%a1"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    138e:	movea.l (sp)+,a3
    1390:	movea.l (sp)+,a6
    1392:	rts

00001394 <BitmapInit>:

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{
    1394:	move.l d3,-(sp)
    1396:	move.l d2,-(sp)
    1398:	movea.l 12(sp),a0
    139c:	move.l 16(sp),d0
    13a0:	move.l 20(sp),d2
    13a4:	move.l 24(sp),d1

	bmp->Width = w;
    13a8:	move.w d0,(a0)
	bmp->Height = h;
    13aa:	move.w d2,2(a0)
	bmp->Bpls = bpls;
    13ae:	move.w d1,4(a0)
	bmp->Bpl = w / 8;
    13b2:	lsr.w #3,d0
    13b4:	move.w d0,6(a0)
	bmp->Bplt = w / 8 * bpls;
    13b8:	move.w d0,d3
    13ba:	muls.w d1,d3
    13bc:	move.w d3,8(a0)
	bmp->Btot = w / 8 * h * bpls;
    13c0:	muls.w d2,d0
    13c2:	muls.w d1,d0
    13c4:	move.w d0,12(a0)
}
    13c8:	move.l (sp)+,d2
    13ca:	move.l (sp)+,d3
    13cc:	rts

000013ce <InitStarfieldSprite>:

void InitStarfieldSprite()
{
    13ce:	movem.l d2-d7/a2-a3,-(sp)
	short line = 0;
	USHORT hpos = 3;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 31; l++)
    13d2:	moveq #0,d5
	BYTE vpos = 0x2c;
    13d4:	moveq #44,d3
	USHORT hpos = 3;
    13d6:	movea.w #3,a1
	short line = 0;
    13da:	clr.w d2
    13dc:	bra.w 1516 <InitStarfieldSprite+0x148>
	{
		hpos = (7 * hpos) % 255;
    13e0:	moveq #0,d0
    13e2:	move.w a1,d0
    13e4:	move.l d0,d1
    13e6:	lsl.l #3,d1
    13e8:	lea 2c54 <__modsi3>,a3
    13ee:	pea ff <MoveBobs+0x8b>
    13f2:	sub.l d0,d1
    13f4:	move.l d1,-(sp)
    13f6:	jsr (a3)
    13f8:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    13fa:	move.b d3,d1
    13fc:	ext.w d1
    13fe:	move.w d1,d4
    1400:	ext.l d4
    1402:	lsl.l #8,d4
    1404:	move.w d0,d6
    1406:	andi.w #255,d6
    140a:	movea.w d2,a0
    140c:	addq.w #1,a0
    140e:	movea.w d2,a1
    1410:	lea 23464 <StarSprite>,a2
    1416:	adda.l a1,a1
    1418:	or.w d4,d6
    141a:	move.w d6,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    141e:	addq.w #1,d1
    1420:	movea.w d2,a1
    1422:	addq.w #2,a1
    1424:	movea.w a0,a0
    1426:	lsl.w #8,d1
    1428:	adda.l a0,a0
    142a:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-1
    142e:	movea.w d2,a0
    1430:	addq.w #3,a0
    1432:	movea.w a1,a1
    1434:	adda.l a1,a1
    1436:	move.w #-32768,(0,a1,a2.l)
		StarSprite[line++] = 0x0000;					  //color-1
    143c:	move.w d2,d6
    143e:	addq.w #4,d6
    1440:	movea.w a0,a0
    1442:	adda.l a0,a0
    1444:	clr.w (0,a0,a2.l)
		vpos += 2;
    1448:	move.b d3,d4
    144a:	addq.b #2,d4

		hpos = (7 * hpos) % 255;
    144c:	andi.l #65535,d0
    1452:	move.l d0,d1
    1454:	lsl.l #3,d1
    1456:	pea ff <MoveBobs+0x8b>
    145a:	sub.l d0,d1
    145c:	move.l d1,-(sp)
    145e:	jsr (a3)
    1460:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    1462:	move.b d4,d1
    1464:	ext.w d1
    1466:	move.w d1,d4
    1468:	ext.l d4
    146a:	lsl.l #8,d4
    146c:	move.w d0,d7
    146e:	andi.w #255,d7
    1472:	movea.w d2,a0
    1474:	addq.w #5,a0
    1476:	movea.w d6,a1
    1478:	adda.l a1,a1
    147a:	or.w d4,d7
    147c:	move.w d7,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    1480:	addq.w #1,d1
    1482:	movea.w d2,a1
    1484:	addq.w #6,a1
    1486:	movea.w a0,a0
    1488:	lsl.w #8,d1
    148a:	adda.l a0,a0
    148c:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x0000;					  //color-2
    1490:	movea.w d2,a0
    1492:	addq.w #7,a0
    1494:	movea.w a1,a1
    1496:	adda.l a1,a1
    1498:	clr.w (0,a1,a2.l)
		StarSprite[line++] = 0x8000;					  //color-2
    149c:	addq.w #4,d6
    149e:	movea.w a0,a0
    14a0:	adda.l a0,a0
    14a2:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    14a8:	move.b d3,d4
    14aa:	addq.b #4,d4

		hpos = (7 * hpos) % 255;
    14ac:	andi.l #65535,d0
    14b2:	move.l d0,d1
    14b4:	lsl.l #3,d1
    14b6:	pea ff <MoveBobs+0x8b>
    14ba:	sub.l d0,d1
    14bc:	move.l d1,-(sp)
    14be:	jsr (a3)
    14c0:	addq.l #8,sp
    14c2:	movea.w d0,a1
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    14c4:	move.b d4,d1
    14c6:	ext.w d1
    14c8:	move.w d1,d4
    14ca:	ext.l d4
    14cc:	lsl.l #8,d4
    14ce:	andi.w #255,d0
    14d2:	movea.w d2,a3
    14d4:	lea 9(a3),a3
    14d8:	movea.w d6,a0
    14da:	adda.l a0,a0
    14dc:	or.w d4,d0
    14de:	move.w d0,(0,a2,a0.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    14e2:	addq.w #1,d1
    14e4:	movea.w d2,a0
    14e6:	lea 10(a0),a0
    14ea:	movea.w a3,a3
    14ec:	lsl.w #8,d1
    14ee:	adda.l a3,a3
    14f0:	move.w d1,(0,a3,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    14f4:	movea.w a0,a0
    14f6:	adda.l a0,a0
    14f8:	move.w #-32768,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    14fe:	movea.w d2,a0
    1500:	lea 11(a0),a0
    1504:	movea.w a0,a0
    1506:	addi.w #12,d2
    150a:	adda.l a0,a0
    150c:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    1512:	addq.b #6,d3
	for (int l = 0; l < 31; l++)
    1514:	addq.l #1,d5
    1516:	moveq #30,d0
    1518:	cmp.l d5,d0
    151a:	bge.w 13e0 <InitStarfieldSprite+0x12>
	}
	// sprite end-mark
	StarSprite[line++] = 0;
    151e:	move.w d2,d0
    1520:	addq.w #1,d0
    1522:	ext.l d2
    1524:	lea 23464 <StarSprite>,a1
    152a:	add.l d2,d2
    152c:	clr.w (0,a1,d2.l)
	StarSprite[line++] = 0;
    1530:	movea.w d0,a0
    1532:	adda.l a0,a0
    1534:	clr.w (0,a0,a1.l)
}
    1538:	movem.l (sp)+,d2-d7/a2-a3
    153c:	rts

0000153e <MoveStarfield>:

void MoveStarfield()
{
	for (int l = 1; l < 31 * 24; l += 24)
    153e:	movea.w #1,a0
    1542:	bra.s 1572 <MoveStarfield+0x34>
	{
		((volatile UBYTE *)StarSprite)[l] += 1;
    1544:	movea.l a0,a1
    1546:	adda.l #144484,a1
    154c:	move.b (a1),d0
    154e:	addq.b #1,d0
    1550:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 8] += 2;
    1552:	movea.l a0,a1
    1554:	adda.l #144492,a1
    155a:	move.b (a1),d0
    155c:	addq.b #2,d0
    155e:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 16] += 3;
    1560:	movea.l a0,a1
    1562:	adda.l #144500,a1
    1568:	move.b (a1),d0
    156a:	addq.b #3,d0
    156c:	move.b d0,(a1)
	for (int l = 1; l < 31 * 24; l += 24)
    156e:	lea 24(a0),a0
    1572:	cmpa.w #743,a0
    1576:	ble.s 1544 <MoveStarfield+0x6>
	}
}
    1578:	rts

0000157a <MainLoop>:
{
    157a:	movem.l d2-d4/a2-a3,-(sp)
	while (!MouseLeft())
    157e:	bra.w 1a76 <MainLoop+0x4fc>
			SetupCopper(copPtr);
    1582:	move.l 2377e <copPtr>,-(sp)
    1588:	jsr 28c <SetupCopper>(pc)
			custom->cop1lc = (ULONG)copPtr;
    158c:	movea.l 23952 <custom>,a0
    1592:	move.l 2377e <copPtr>,128(a0)
			custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    159a:	move.w #64,150(a0)
			custom->copjmp1 = 0x7fff;	   //start coppper
    15a0:	move.w #32767,136(a0)
			custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    15a6:	move.w #-30752,150(a0)
			ResetCopper = FALSE;
    15ac:	clr.w 2377c <ResetCopper>
    15b2:	addq.l #4,sp
    15b4:	bra.w 1a92 <MainLoop+0x518>
					ScrollerDir = 1;
    15b8:	move.b #1,6088 <ScrollerDir>
    15c0:	bra.w 1b84 <MainLoop+0x60a>
				ScrollerDir -= 1;
    15c4:	subq.b #1,d0
    15c6:	move.b d0,6088 <ScrollerDir>
				if (ScrollerDir < -4)
    15cc:	cmpi.b #-4,d0
    15d0:	bge.s 15da <MainLoop+0x60>
					ScrollerDir = -4;
    15d2:	move.b #-4,6088 <ScrollerDir>
				if (ScrollerDir > -1)
    15da:	tst.b 6088 <ScrollerDir>
    15e0:	blt.w 1b84 <MainLoop+0x60a>
					ScrollerDir = -1;
    15e4:	st 6088 <ScrollerDir>
    15ea:	bra.w 1b84 <MainLoop+0x60a>
			if (ScrollerPause > 0)
    15ee:	move.w 23776 <ScrollerPause>,d0
    15f4:	beq.w 1b92 <MainLoop+0x618>
				ScrollerPause--;
    15f8:	subq.w #1,d0
    15fa:	move.w d0,23776 <ScrollerPause>
    1600:	bra.w 1b92 <MainLoop+0x618>
		else if (ScrollerY <= ScrollerMin)
    1604:	cmpa.w #0,a0
    1608:	bgt.w 1bae <MainLoop+0x634>
			ScrollerY = ScrollerMin;
    160c:	clr.w 23778 <ScrollerY>
			ScrollerDir = 1;
    1612:	move.b #1,6088 <ScrollerDir>
			if (ScrollerPause > 0)
    161a:	move.w 23776 <ScrollerPause>,d0
    1620:	beq.w 1bae <MainLoop+0x634>
				ScrollerPause--;
    1624:	subq.w #1,d0
    1626:	move.w d0,23776 <ScrollerPause>
    162c:	bra.w 1bae <MainLoop+0x634>
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    1630:	pea 4 <_start+0x4>
    1634:	pea 20 <_start+0x20>
    1638:	pea 28 <_start+0x28>
    163c:	move.l 23826 <BmpScroller+0xe>,-(sp)
    1642:	subq.l #2,sp
    1644:	move.l 23846 <BmpScroller+0x2e>,-(sp)
    164a:	move.l 23842 <BmpScroller+0x2a>,-(sp)
    1650:	move.l 2383e <BmpScroller+0x26>,-(sp)
    1656:	move.l 2383a <BmpScroller+0x22>,-(sp)
    165c:	move.l 23836 <BmpScroller+0x1e>,-(sp)
    1662:	move.l 23832 <BmpScroller+0x1a>,-(sp)
    1668:	move.l 2382e <BmpScroller+0x16>,-(sp)
    166e:	move.l 2382a <BmpScroller+0x12>,-(sp)
    1674:	move.l 23826 <BmpScroller+0xe>,-(sp)
    167a:	move.l 23822 <BmpScroller+0xa>,-(sp)
    1680:	move.l 2381e <BmpScroller+0x6>,-(sp)
    1686:	move.l 2381a <BmpScroller+0x2>,-(sp)
    168c:	move.w 23818 <BmpScroller>,-(sp)
    1692:	jsr bd8 <Scrollit>(pc)
    1696:	lea 68(sp),sp
    169a:	bra.w 1bb8 <MainLoop+0x63e>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
    169e:	moveq #56,d2
    16a0:	add.l d2,d1
    16a2:	add.w d1,d1
    16a4:	add.w d1,d1
    16a6:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    16a8:	move.l d0,d2
    16aa:	clr.w d2
    16ac:	swap d2
    16ae:	move.w d2,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
    16b2:	addq.w #2,d1
    16b4:	move.w d1,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    16b8:	move.w d0,6(a2)
        addr += Bpl;
    16bc:	add.l d4,d0
    for (USHORT i = 0; i < numPlanes; i++)
    16be:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
    16c0:	addq.l #8,a2
    for (USHORT i = 0; i < numPlanes; i++)
    16c2:	moveq #0,d1
    16c4:	move.w a0,d1
    16c6:	cmp.l d3,d1
    16c8:	blt.s 169e <MainLoop+0x124>
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[0].X, BobTarget[0].Y, 32, 32);
    16ca:	pea 20 <_start+0x20>
    16ce:	pea 20 <_start+0x20>
    16d2:	move.l 604c <BobTarget+0x4>,-(sp)
    16d8:	move.l 6048 <BobTarget>,-(sp)
    16de:	subq.l #2,sp
    16e0:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    16e6:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    16ec:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    16f2:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    16f8:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    16fe:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1704:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    170a:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    1710:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    1716:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    171c:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    1722:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    1728:	lea 2384a <BmpUpperPart_Buf1>,a3
    172e:	move.w (a3),-(sp)
    1730:	lea 100e <ClearBitmapPart>(pc),a2
    1734:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[1].X, BobTarget[1].Y, 32, 32);
    1736:	lea 68(sp),sp
    173a:	pea 20 <_start+0x20>
    173e:	pea 20 <_start+0x20>
    1742:	move.l 6054 <BobTarget+0xc>,-(sp)
    1748:	move.l 6050 <BobTarget+0x8>,-(sp)
    174e:	subq.l #2,sp
    1750:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1756:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    175c:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    1762:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    1768:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    176e:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1774:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    177a:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    1780:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    1786:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    178c:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    1792:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    1798:	move.w (a3),-(sp)
    179a:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[2].X, BobTarget[2].Y, 32, 32);
    179c:	lea 68(sp),sp
    17a0:	pea 20 <_start+0x20>
    17a4:	pea 20 <_start+0x20>
    17a8:	move.l 605c <BobTarget+0x14>,-(sp)
    17ae:	move.l 6058 <BobTarget+0x10>,-(sp)
    17b4:	subq.l #2,sp
    17b6:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    17bc:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    17c2:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    17c8:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    17ce:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    17d4:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    17da:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    17e0:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    17e6:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    17ec:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    17f2:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    17f8:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    17fe:	move.w (a3),-(sp)
    1800:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[3].X, BobTarget[3].Y, 32, 32);
    1802:	lea 68(sp),sp
    1806:	pea 20 <_start+0x20>
    180a:	pea 20 <_start+0x20>
    180e:	move.l 6064 <BobTarget+0x1c>,-(sp)
    1814:	move.l 6060 <BobTarget+0x18>,-(sp)
    181a:	subq.l #2,sp
    181c:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1822:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1828:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    182e:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    1834:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    183a:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1840:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    1846:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    184c:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    1852:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    1858:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    185e:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    1864:	move.w (a3),-(sp)
    1866:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[4].X, BobTarget[4].Y, 32, 32);
    1868:	lea 68(sp),sp
    186c:	pea 20 <_start+0x20>
    1870:	pea 20 <_start+0x20>
    1874:	move.l 606c <BobTarget+0x24>,-(sp)
    187a:	move.l 6068 <BobTarget+0x20>,-(sp)
    1880:	subq.l #2,sp
    1882:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1888:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    188e:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    1894:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    189a:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    18a0:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    18a6:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    18ac:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    18b2:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    18b8:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    18be:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    18c4:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    18ca:	move.w (a3),-(sp)
    18cc:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[5].X, BobTarget[5].Y, 32, 32);
    18ce:	lea 68(sp),sp
    18d2:	pea 20 <_start+0x20>
    18d6:	pea 20 <_start+0x20>
    18da:	move.l 6074 <BobTarget+0x2c>,-(sp)
    18e0:	move.l 6070 <BobTarget+0x28>,-(sp)
    18e6:	subq.l #2,sp
    18e8:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    18ee:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    18f4:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    18fa:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    1900:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1906:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    190c:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    1912:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    1918:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    191e:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    1924:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    192a:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    1930:	move.w (a3),-(sp)
    1932:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[6].X, BobTarget[6].Y, 32, 32);
    1934:	lea 68(sp),sp
    1938:	pea 20 <_start+0x20>
    193c:	pea 20 <_start+0x20>
    1940:	move.l 607c <BobTarget+0x34>,-(sp)
    1946:	move.l 6078 <BobTarget+0x30>,-(sp)
    194c:	subq.l #2,sp
    194e:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1954:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    195a:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    1960:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    1966:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    196c:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1972:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    1978:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    197e:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    1984:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    198a:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    1990:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    1996:	move.w (a3),-(sp)
    1998:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[7].X, BobTarget[7].Y, 32, 32);
    199a:	lea 68(sp),sp
    199e:	pea 20 <_start+0x20>
    19a2:	pea 20 <_start+0x20>
    19a6:	move.l 6084 <BobTarget+0x3c>,-(sp)
    19ac:	move.l 6080 <BobTarget+0x38>,-(sp)
    19b2:	subq.l #2,sp
    19b4:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    19ba:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    19c0:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    19c6:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    19cc:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    19d2:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    19d8:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    19de:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    19e4:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    19ea:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    19f0:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    19f6:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    19fc:	move.w (a3),-(sp)
    19fe:	jsr (a2)
		MoveBobs();
    1a00:	lea 68(sp),sp
    1a04:	jsr 74 <MoveBobs>(pc)
		if (BobVisible & 1)
    1a08:	btst #0,6047 <BobVisible+0x1>
    1a10:	bne.w 1bf6 <MainLoop+0x67c>
		if (BobVisible & (1 << 1))
    1a14:	btst #1,6047 <BobVisible+0x1>
    1a1c:	bne.w 1d12 <MainLoop+0x798>
		if (BobVisible & (1 << 2))
    1a20:	btst #2,6047 <BobVisible+0x1>
    1a28:	bne.w 1e2e <MainLoop+0x8b4>
		if (BobVisible & (1 << 3))
    1a2c:	btst #3,6047 <BobVisible+0x1>
    1a34:	bne.w 1f4a <MainLoop+0x9d0>
		if (BobVisible & (1 << 4))
    1a38:	btst #4,6047 <BobVisible+0x1>
    1a40:	bne.w 2066 <MainLoop+0xaec>
		if (BobVisible & (1 << 5))
    1a44:	btst #5,6047 <BobVisible+0x1>
    1a4c:	bne.w 2182 <MainLoop+0xc08>
		if (BobVisible & (1 << 6))
    1a50:	btst #6,6047 <BobVisible+0x1>
    1a58:	bne.w 229e <MainLoop+0xd24>
		if (BobVisible & (1 << 7))
    1a5c:	tst.b 6047 <BobVisible+0x1>
    1a62:	bmi.w 23ba <MainLoop+0xe40>
		MoveStarfield();
    1a66:	jsr 153e <MoveStarfield>(pc)
		custom->color[0]=0xf00;
    1a6a:	movea.l 23952 <custom>,a0
    1a70:	move.w #3840,384(a0)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    1a76:	move.b bfe001 <_end+0xbda6a9>,d0
	while (!MouseLeft())
    1a7c:	btst #6,d0
    1a80:	beq.w 24d6 <MainLoop+0xf5c>
		WaitVbl();
    1a84:	jsr da0 <WaitVbl>(pc)
		if (ResetCopper)
    1a88:	tst.w 2377c <ResetCopper>
    1a8e:	bne.w 1582 <MainLoop+0x8>
		CopyBitmap(BmpUpperPart_Buf1, BmpUpperPart_PF2);
    1a92:	subq.l #2,sp
    1a94:	move.l 238aa <BmpUpperPart_PF2+0x2e>,-(sp)
    1a9a:	move.l 238a6 <BmpUpperPart_PF2+0x2a>,-(sp)
    1aa0:	move.l 238a2 <BmpUpperPart_PF2+0x26>,-(sp)
    1aa6:	move.l 2389e <BmpUpperPart_PF2+0x22>,-(sp)
    1aac:	move.l 2389a <BmpUpperPart_PF2+0x1e>,-(sp)
    1ab2:	move.l 23896 <BmpUpperPart_PF2+0x1a>,-(sp)
    1ab8:	move.l 23892 <BmpUpperPart_PF2+0x16>,-(sp)
    1abe:	move.l 2388e <BmpUpperPart_PF2+0x12>,-(sp)
    1ac4:	move.l 2388a <BmpUpperPart_PF2+0xe>,-(sp)
    1aca:	move.l 23886 <BmpUpperPart_PF2+0xa>,-(sp)
    1ad0:	move.l 23882 <BmpUpperPart_PF2+0x6>,-(sp)
    1ad6:	move.l 2387e <BmpUpperPart_PF2+0x2>,-(sp)
    1adc:	move.w 2387c <BmpUpperPart_PF2>,-(sp)
    1ae2:	subq.l #2,sp
    1ae4:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1aea:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1af0:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    1af6:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    1afc:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1b02:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1b08:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    1b0e:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    1b14:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    1b1a:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    1b20:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    1b26:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    1b2c:	move.w 2384a <BmpUpperPart_Buf1>,-(sp)
    1b32:	jsr fb2 <CopyBitmap>(pc)
		if (BounceEnabled)
    1b36:	lea 104(sp),sp
    1b3a:	tst.w 2377a <BounceEnabled>
    1b40:	beq.w 15ee <MainLoop+0x74>
			if (ScrollerDir > 0)
    1b44:	move.b 6088 <ScrollerDir>,d0
    1b4a:	ble.w 15c4 <MainLoop+0x4a>
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
    1b4e:	pea c <_start+0xc>
    1b52:	movea.w #40,a0
    1b56:	suba.w 23778 <ScrollerY>,a0
    1b5c:	move.l a0,-(sp)
    1b5e:	jsr 2c2a <__divsi3>
    1b64:	addq.l #8,sp
    1b66:	move.b d0,6088 <ScrollerDir>
				if (ScrollerDir > 6)
    1b6c:	cmpi.b #6,d0
    1b70:	ble.s 1b7a <MainLoop+0x600>
					ScrollerDir = 6;
    1b72:	move.b #6,6088 <ScrollerDir>
				if (ScrollerDir < 1)
    1b7a:	tst.b 6088 <ScrollerDir>
    1b80:	ble.w 15b8 <MainLoop+0x3e>
			ScrollerY += ScrollerDir;
    1b84:	move.b 6088 <ScrollerDir>,d0
    1b8a:	ext.w d0
    1b8c:	add.w d0,23778 <ScrollerY>
		if (ScrollerY >= ScrollerMax)
    1b92:	movea.w 23778 <ScrollerY>,a0
    1b98:	moveq #39,d0
    1b9a:	cmp.l a0,d0
    1b9c:	bge.w 1604 <MainLoop+0x8a>
			ScrollerY = ScrollerMax;
    1ba0:	move.w #40,23778 <ScrollerY>
			ScrollerDir = -1;
    1ba8:	st 6088 <ScrollerDir>
		if (ScrollerPause < 1)
    1bae:	tst.w 23776 <ScrollerPause>
    1bb4:	beq.w 1630 <MainLoop+0xb6>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    1bb8:	moveq #0,d4
    1bba:	move.w 2381e <BmpScroller+0x6>,d4
    1bc0:	moveq #0,d3
    1bc2:	move.w 2381c <BmpScroller+0x4>,d3
    1bc8:	movea.l 23772 <copScrollerBmpP>,a2
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    1bce:	lea 2bac <__mulsi3>,a3
    1bd4:	move.l d4,-(sp)
    1bd6:	movea.w 23778 <ScrollerY>,a0
    1bdc:	move.l a0,-(sp)
    1bde:	jsr (a3)
    1be0:	addq.l #8,sp
    1be2:	move.l d0,-(sp)
    1be4:	move.l d3,-(sp)
    1be6:	jsr (a3)
    1be8:	addq.l #8,sp
    1bea:	add.l 23826 <BmpScroller+0xe>,d0
    for (USHORT i = 0; i < numPlanes; i++)
    1bf0:	suba.l a0,a0
    1bf2:	bra.w 16c2 <MainLoop+0x148>
			BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[0], BobTarget[0], 32, 32);
    1bf6:	pea 20 <_start+0x20>
    1bfa:	pea 20 <_start+0x20>
    1bfe:	move.l 604c <BobTarget+0x4>,-(sp)
    1c04:	move.l 6048 <BobTarget>,-(sp)
    1c0a:	move.l 4dcc <BobSource+0x4>,-(sp)
    1c10:	move.l 4dc8 <BobSource>,-(sp)
    1c16:	subq.l #2,sp
    1c18:	move.l 237b0 <BmpCookieMask+0x2e>,-(sp)
    1c1e:	move.l 237ac <BmpCookieMask+0x2a>,-(sp)
    1c24:	move.l 237a8 <BmpCookieMask+0x26>,-(sp)
    1c2a:	move.l 237a4 <BmpCookieMask+0x22>,-(sp)
    1c30:	move.l 237a0 <BmpCookieMask+0x1e>,-(sp)
    1c36:	move.l 2379c <BmpCookieMask+0x1a>,-(sp)
    1c3c:	move.l 23798 <BmpCookieMask+0x16>,-(sp)
    1c42:	move.l 23794 <BmpCookieMask+0x12>,-(sp)
    1c48:	move.l 23790 <BmpCookieMask+0xe>,-(sp)
    1c4e:	move.l 2378c <BmpCookieMask+0xa>,-(sp)
    1c54:	move.l 23788 <BmpCookieMask+0x6>,-(sp)
    1c5a:	move.l 23784 <BmpCookieMask+0x2>,-(sp)
    1c60:	move.w 23782 <BmpCookieMask>,-(sp)
    1c66:	subq.l #2,sp
    1c68:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1c6e:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1c74:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    1c7a:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    1c80:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1c86:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1c8c:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    1c92:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    1c98:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    1c9e:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    1ca4:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    1caa:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    1cb0:	move.w 2384a <BmpUpperPart_Buf1>,-(sp)
    1cb6:	subq.l #2,sp
    1cb8:	move.l 237e2 <BmpCookie+0x2e>,-(sp)
    1cbe:	move.l 237de <BmpCookie+0x2a>,-(sp)
    1cc4:	move.l 237da <BmpCookie+0x26>,-(sp)
    1cca:	move.l 237d6 <BmpCookie+0x22>,-(sp)
    1cd0:	move.l 237d2 <BmpCookie+0x1e>,-(sp)
    1cd6:	move.l 237ce <BmpCookie+0x1a>,-(sp)
    1cdc:	move.l 237ca <BmpCookie+0x16>,-(sp)
    1ce2:	move.l 237c6 <BmpCookie+0x12>,-(sp)
    1ce8:	move.l 237c2 <BmpCookie+0xe>,-(sp)
    1cee:	move.l 237be <BmpCookie+0xa>,-(sp)
    1cf4:	move.l 237ba <BmpCookie+0x6>,-(sp)
    1cfa:	move.l 237b6 <BmpCookie+0x2>,-(sp)
    1d00:	move.w 237b4 <BmpCookie>,-(sp)
    1d06:	jsr 11b6 <BetterBlit>(pc)
    1d0a:	lea 180(sp),sp
    1d0e:	bra.w 1a14 <MainLoop+0x49a>
			BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[1], BobTarget[1], 32, 32);
    1d12:	pea 20 <_start+0x20>
    1d16:	pea 20 <_start+0x20>
    1d1a:	move.l 6054 <BobTarget+0xc>,-(sp)
    1d20:	move.l 6050 <BobTarget+0x8>,-(sp)
    1d26:	move.l 4dd4 <BobSource+0xc>,-(sp)
    1d2c:	move.l 4dd0 <BobSource+0x8>,-(sp)
    1d32:	subq.l #2,sp
    1d34:	move.l 237b0 <BmpCookieMask+0x2e>,-(sp)
    1d3a:	move.l 237ac <BmpCookieMask+0x2a>,-(sp)
    1d40:	move.l 237a8 <BmpCookieMask+0x26>,-(sp)
    1d46:	move.l 237a4 <BmpCookieMask+0x22>,-(sp)
    1d4c:	move.l 237a0 <BmpCookieMask+0x1e>,-(sp)
    1d52:	move.l 2379c <BmpCookieMask+0x1a>,-(sp)
    1d58:	move.l 23798 <BmpCookieMask+0x16>,-(sp)
    1d5e:	move.l 23794 <BmpCookieMask+0x12>,-(sp)
    1d64:	move.l 23790 <BmpCookieMask+0xe>,-(sp)
    1d6a:	move.l 2378c <BmpCookieMask+0xa>,-(sp)
    1d70:	move.l 23788 <BmpCookieMask+0x6>,-(sp)
    1d76:	move.l 23784 <BmpCookieMask+0x2>,-(sp)
    1d7c:	move.w 23782 <BmpCookieMask>,-(sp)
    1d82:	subq.l #2,sp
    1d84:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1d8a:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1d90:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    1d96:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    1d9c:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1da2:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1da8:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    1dae:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    1db4:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    1dba:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    1dc0:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    1dc6:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    1dcc:	move.w 2384a <BmpUpperPart_Buf1>,-(sp)
    1dd2:	subq.l #2,sp
    1dd4:	move.l 237e2 <BmpCookie+0x2e>,-(sp)
    1dda:	move.l 237de <BmpCookie+0x2a>,-(sp)
    1de0:	move.l 237da <BmpCookie+0x26>,-(sp)
    1de6:	move.l 237d6 <BmpCookie+0x22>,-(sp)
    1dec:	move.l 237d2 <BmpCookie+0x1e>,-(sp)
    1df2:	move.l 237ce <BmpCookie+0x1a>,-(sp)
    1df8:	move.l 237ca <BmpCookie+0x16>,-(sp)
    1dfe:	move.l 237c6 <BmpCookie+0x12>,-(sp)
    1e04:	move.l 237c2 <BmpCookie+0xe>,-(sp)
    1e0a:	move.l 237be <BmpCookie+0xa>,-(sp)
    1e10:	move.l 237ba <BmpCookie+0x6>,-(sp)
    1e16:	move.l 237b6 <BmpCookie+0x2>,-(sp)
    1e1c:	move.w 237b4 <BmpCookie>,-(sp)
    1e22:	jsr 11b6 <BetterBlit>(pc)
    1e26:	lea 180(sp),sp
    1e2a:	bra.w 1a20 <MainLoop+0x4a6>
			BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[2], BobTarget[2], 32, 32);
    1e2e:	pea 20 <_start+0x20>
    1e32:	pea 20 <_start+0x20>
    1e36:	move.l 605c <BobTarget+0x14>,-(sp)
    1e3c:	move.l 6058 <BobTarget+0x10>,-(sp)
    1e42:	move.l 4ddc <BobSource+0x14>,-(sp)
    1e48:	move.l 4dd8 <BobSource+0x10>,-(sp)
    1e4e:	subq.l #2,sp
    1e50:	move.l 237b0 <BmpCookieMask+0x2e>,-(sp)
    1e56:	move.l 237ac <BmpCookieMask+0x2a>,-(sp)
    1e5c:	move.l 237a8 <BmpCookieMask+0x26>,-(sp)
    1e62:	move.l 237a4 <BmpCookieMask+0x22>,-(sp)
    1e68:	move.l 237a0 <BmpCookieMask+0x1e>,-(sp)
    1e6e:	move.l 2379c <BmpCookieMask+0x1a>,-(sp)
    1e74:	move.l 23798 <BmpCookieMask+0x16>,-(sp)
    1e7a:	move.l 23794 <BmpCookieMask+0x12>,-(sp)
    1e80:	move.l 23790 <BmpCookieMask+0xe>,-(sp)
    1e86:	move.l 2378c <BmpCookieMask+0xa>,-(sp)
    1e8c:	move.l 23788 <BmpCookieMask+0x6>,-(sp)
    1e92:	move.l 23784 <BmpCookieMask+0x2>,-(sp)
    1e98:	move.w 23782 <BmpCookieMask>,-(sp)
    1e9e:	subq.l #2,sp
    1ea0:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1ea6:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1eac:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    1eb2:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    1eb8:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1ebe:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1ec4:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    1eca:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    1ed0:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    1ed6:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    1edc:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    1ee2:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    1ee8:	move.w 2384a <BmpUpperPart_Buf1>,-(sp)
    1eee:	subq.l #2,sp
    1ef0:	move.l 237e2 <BmpCookie+0x2e>,-(sp)
    1ef6:	move.l 237de <BmpCookie+0x2a>,-(sp)
    1efc:	move.l 237da <BmpCookie+0x26>,-(sp)
    1f02:	move.l 237d6 <BmpCookie+0x22>,-(sp)
    1f08:	move.l 237d2 <BmpCookie+0x1e>,-(sp)
    1f0e:	move.l 237ce <BmpCookie+0x1a>,-(sp)
    1f14:	move.l 237ca <BmpCookie+0x16>,-(sp)
    1f1a:	move.l 237c6 <BmpCookie+0x12>,-(sp)
    1f20:	move.l 237c2 <BmpCookie+0xe>,-(sp)
    1f26:	move.l 237be <BmpCookie+0xa>,-(sp)
    1f2c:	move.l 237ba <BmpCookie+0x6>,-(sp)
    1f32:	move.l 237b6 <BmpCookie+0x2>,-(sp)
    1f38:	move.w 237b4 <BmpCookie>,-(sp)
    1f3e:	jsr 11b6 <BetterBlit>(pc)
    1f42:	lea 180(sp),sp
    1f46:	bra.w 1a2c <MainLoop+0x4b2>
			BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[3], BobTarget[3], 32, 32);
    1f4a:	pea 20 <_start+0x20>
    1f4e:	pea 20 <_start+0x20>
    1f52:	move.l 6064 <BobTarget+0x1c>,-(sp)
    1f58:	move.l 6060 <BobTarget+0x18>,-(sp)
    1f5e:	move.l 4de4 <BobSource+0x1c>,-(sp)
    1f64:	move.l 4de0 <BobSource+0x18>,-(sp)
    1f6a:	subq.l #2,sp
    1f6c:	move.l 237b0 <BmpCookieMask+0x2e>,-(sp)
    1f72:	move.l 237ac <BmpCookieMask+0x2a>,-(sp)
    1f78:	move.l 237a8 <BmpCookieMask+0x26>,-(sp)
    1f7e:	move.l 237a4 <BmpCookieMask+0x22>,-(sp)
    1f84:	move.l 237a0 <BmpCookieMask+0x1e>,-(sp)
    1f8a:	move.l 2379c <BmpCookieMask+0x1a>,-(sp)
    1f90:	move.l 23798 <BmpCookieMask+0x16>,-(sp)
    1f96:	move.l 23794 <BmpCookieMask+0x12>,-(sp)
    1f9c:	move.l 23790 <BmpCookieMask+0xe>,-(sp)
    1fa2:	move.l 2378c <BmpCookieMask+0xa>,-(sp)
    1fa8:	move.l 23788 <BmpCookieMask+0x6>,-(sp)
    1fae:	move.l 23784 <BmpCookieMask+0x2>,-(sp)
    1fb4:	move.w 23782 <BmpCookieMask>,-(sp)
    1fba:	subq.l #2,sp
    1fbc:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1fc2:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    1fc8:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    1fce:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    1fd4:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1fda:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    1fe0:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    1fe6:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    1fec:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    1ff2:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    1ff8:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    1ffe:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    2004:	move.w 2384a <BmpUpperPart_Buf1>,-(sp)
    200a:	subq.l #2,sp
    200c:	move.l 237e2 <BmpCookie+0x2e>,-(sp)
    2012:	move.l 237de <BmpCookie+0x2a>,-(sp)
    2018:	move.l 237da <BmpCookie+0x26>,-(sp)
    201e:	move.l 237d6 <BmpCookie+0x22>,-(sp)
    2024:	move.l 237d2 <BmpCookie+0x1e>,-(sp)
    202a:	move.l 237ce <BmpCookie+0x1a>,-(sp)
    2030:	move.l 237ca <BmpCookie+0x16>,-(sp)
    2036:	move.l 237c6 <BmpCookie+0x12>,-(sp)
    203c:	move.l 237c2 <BmpCookie+0xe>,-(sp)
    2042:	move.l 237be <BmpCookie+0xa>,-(sp)
    2048:	move.l 237ba <BmpCookie+0x6>,-(sp)
    204e:	move.l 237b6 <BmpCookie+0x2>,-(sp)
    2054:	move.w 237b4 <BmpCookie>,-(sp)
    205a:	jsr 11b6 <BetterBlit>(pc)
    205e:	lea 180(sp),sp
    2062:	bra.w 1a38 <MainLoop+0x4be>
			BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[4], BobTarget[4], 32, 32);
    2066:	pea 20 <_start+0x20>
    206a:	pea 20 <_start+0x20>
    206e:	move.l 606c <BobTarget+0x24>,-(sp)
    2074:	move.l 6068 <BobTarget+0x20>,-(sp)
    207a:	move.l 4dec <BobSource+0x24>,-(sp)
    2080:	move.l 4de8 <BobSource+0x20>,-(sp)
    2086:	subq.l #2,sp
    2088:	move.l 237b0 <BmpCookieMask+0x2e>,-(sp)
    208e:	move.l 237ac <BmpCookieMask+0x2a>,-(sp)
    2094:	move.l 237a8 <BmpCookieMask+0x26>,-(sp)
    209a:	move.l 237a4 <BmpCookieMask+0x22>,-(sp)
    20a0:	move.l 237a0 <BmpCookieMask+0x1e>,-(sp)
    20a6:	move.l 2379c <BmpCookieMask+0x1a>,-(sp)
    20ac:	move.l 23798 <BmpCookieMask+0x16>,-(sp)
    20b2:	move.l 23794 <BmpCookieMask+0x12>,-(sp)
    20b8:	move.l 23790 <BmpCookieMask+0xe>,-(sp)
    20be:	move.l 2378c <BmpCookieMask+0xa>,-(sp)
    20c4:	move.l 23788 <BmpCookieMask+0x6>,-(sp)
    20ca:	move.l 23784 <BmpCookieMask+0x2>,-(sp)
    20d0:	move.w 23782 <BmpCookieMask>,-(sp)
    20d6:	subq.l #2,sp
    20d8:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    20de:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    20e4:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    20ea:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    20f0:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    20f6:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    20fc:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    2102:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    2108:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    210e:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    2114:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    211a:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    2120:	move.w 2384a <BmpUpperPart_Buf1>,-(sp)
    2126:	subq.l #2,sp
    2128:	move.l 237e2 <BmpCookie+0x2e>,-(sp)
    212e:	move.l 237de <BmpCookie+0x2a>,-(sp)
    2134:	move.l 237da <BmpCookie+0x26>,-(sp)
    213a:	move.l 237d6 <BmpCookie+0x22>,-(sp)
    2140:	move.l 237d2 <BmpCookie+0x1e>,-(sp)
    2146:	move.l 237ce <BmpCookie+0x1a>,-(sp)
    214c:	move.l 237ca <BmpCookie+0x16>,-(sp)
    2152:	move.l 237c6 <BmpCookie+0x12>,-(sp)
    2158:	move.l 237c2 <BmpCookie+0xe>,-(sp)
    215e:	move.l 237be <BmpCookie+0xa>,-(sp)
    2164:	move.l 237ba <BmpCookie+0x6>,-(sp)
    216a:	move.l 237b6 <BmpCookie+0x2>,-(sp)
    2170:	move.w 237b4 <BmpCookie>,-(sp)
    2176:	jsr 11b6 <BetterBlit>(pc)
    217a:	lea 180(sp),sp
    217e:	bra.w 1a44 <MainLoop+0x4ca>
			BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[5], BobTarget[5], 32, 32);
    2182:	pea 20 <_start+0x20>
    2186:	pea 20 <_start+0x20>
    218a:	move.l 6074 <BobTarget+0x2c>,-(sp)
    2190:	move.l 6070 <BobTarget+0x28>,-(sp)
    2196:	move.l 4df4 <BobSource+0x2c>,-(sp)
    219c:	move.l 4df0 <BobSource+0x28>,-(sp)
    21a2:	subq.l #2,sp
    21a4:	move.l 237b0 <BmpCookieMask+0x2e>,-(sp)
    21aa:	move.l 237ac <BmpCookieMask+0x2a>,-(sp)
    21b0:	move.l 237a8 <BmpCookieMask+0x26>,-(sp)
    21b6:	move.l 237a4 <BmpCookieMask+0x22>,-(sp)
    21bc:	move.l 237a0 <BmpCookieMask+0x1e>,-(sp)
    21c2:	move.l 2379c <BmpCookieMask+0x1a>,-(sp)
    21c8:	move.l 23798 <BmpCookieMask+0x16>,-(sp)
    21ce:	move.l 23794 <BmpCookieMask+0x12>,-(sp)
    21d4:	move.l 23790 <BmpCookieMask+0xe>,-(sp)
    21da:	move.l 2378c <BmpCookieMask+0xa>,-(sp)
    21e0:	move.l 23788 <BmpCookieMask+0x6>,-(sp)
    21e6:	move.l 23784 <BmpCookieMask+0x2>,-(sp)
    21ec:	move.w 23782 <BmpCookieMask>,-(sp)
    21f2:	subq.l #2,sp
    21f4:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    21fa:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2200:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    2206:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    220c:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2212:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2218:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    221e:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    2224:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    222a:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    2230:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    2236:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    223c:	move.w 2384a <BmpUpperPart_Buf1>,-(sp)
    2242:	subq.l #2,sp
    2244:	move.l 237e2 <BmpCookie+0x2e>,-(sp)
    224a:	move.l 237de <BmpCookie+0x2a>,-(sp)
    2250:	move.l 237da <BmpCookie+0x26>,-(sp)
    2256:	move.l 237d6 <BmpCookie+0x22>,-(sp)
    225c:	move.l 237d2 <BmpCookie+0x1e>,-(sp)
    2262:	move.l 237ce <BmpCookie+0x1a>,-(sp)
    2268:	move.l 237ca <BmpCookie+0x16>,-(sp)
    226e:	move.l 237c6 <BmpCookie+0x12>,-(sp)
    2274:	move.l 237c2 <BmpCookie+0xe>,-(sp)
    227a:	move.l 237be <BmpCookie+0xa>,-(sp)
    2280:	move.l 237ba <BmpCookie+0x6>,-(sp)
    2286:	move.l 237b6 <BmpCookie+0x2>,-(sp)
    228c:	move.w 237b4 <BmpCookie>,-(sp)
    2292:	jsr 11b6 <BetterBlit>(pc)
    2296:	lea 180(sp),sp
    229a:	bra.w 1a50 <MainLoop+0x4d6>
			BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[6], BobTarget[6], 32, 32);
    229e:	pea 20 <_start+0x20>
    22a2:	pea 20 <_start+0x20>
    22a6:	move.l 607c <BobTarget+0x34>,-(sp)
    22ac:	move.l 6078 <BobTarget+0x30>,-(sp)
    22b2:	move.l 4dfc <BobSource+0x34>,-(sp)
    22b8:	move.l 4df8 <BobSource+0x30>,-(sp)
    22be:	subq.l #2,sp
    22c0:	move.l 237b0 <BmpCookieMask+0x2e>,-(sp)
    22c6:	move.l 237ac <BmpCookieMask+0x2a>,-(sp)
    22cc:	move.l 237a8 <BmpCookieMask+0x26>,-(sp)
    22d2:	move.l 237a4 <BmpCookieMask+0x22>,-(sp)
    22d8:	move.l 237a0 <BmpCookieMask+0x1e>,-(sp)
    22de:	move.l 2379c <BmpCookieMask+0x1a>,-(sp)
    22e4:	move.l 23798 <BmpCookieMask+0x16>,-(sp)
    22ea:	move.l 23794 <BmpCookieMask+0x12>,-(sp)
    22f0:	move.l 23790 <BmpCookieMask+0xe>,-(sp)
    22f6:	move.l 2378c <BmpCookieMask+0xa>,-(sp)
    22fc:	move.l 23788 <BmpCookieMask+0x6>,-(sp)
    2302:	move.l 23784 <BmpCookieMask+0x2>,-(sp)
    2308:	move.w 23782 <BmpCookieMask>,-(sp)
    230e:	subq.l #2,sp
    2310:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2316:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    231c:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    2322:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    2328:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    232e:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2334:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    233a:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    2340:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    2346:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    234c:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    2352:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    2358:	move.w 2384a <BmpUpperPart_Buf1>,-(sp)
    235e:	subq.l #2,sp
    2360:	move.l 237e2 <BmpCookie+0x2e>,-(sp)
    2366:	move.l 237de <BmpCookie+0x2a>,-(sp)
    236c:	move.l 237da <BmpCookie+0x26>,-(sp)
    2372:	move.l 237d6 <BmpCookie+0x22>,-(sp)
    2378:	move.l 237d2 <BmpCookie+0x1e>,-(sp)
    237e:	move.l 237ce <BmpCookie+0x1a>,-(sp)
    2384:	move.l 237ca <BmpCookie+0x16>,-(sp)
    238a:	move.l 237c6 <BmpCookie+0x12>,-(sp)
    2390:	move.l 237c2 <BmpCookie+0xe>,-(sp)
    2396:	move.l 237be <BmpCookie+0xa>,-(sp)
    239c:	move.l 237ba <BmpCookie+0x6>,-(sp)
    23a2:	move.l 237b6 <BmpCookie+0x2>,-(sp)
    23a8:	move.w 237b4 <BmpCookie>,-(sp)
    23ae:	jsr 11b6 <BetterBlit>(pc)
    23b2:	lea 180(sp),sp
    23b6:	bra.w 1a5c <MainLoop+0x4e2>
			BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[7], BobTarget[7], 32, 32);
    23ba:	pea 20 <_start+0x20>
    23be:	pea 20 <_start+0x20>
    23c2:	move.l 6084 <BobTarget+0x3c>,-(sp)
    23c8:	move.l 6080 <BobTarget+0x38>,-(sp)
    23ce:	move.l 4e04 <BobSource+0x3c>,-(sp)
    23d4:	move.l 4e00 <BobSource+0x38>,-(sp)
    23da:	subq.l #2,sp
    23dc:	move.l 237b0 <BmpCookieMask+0x2e>,-(sp)
    23e2:	move.l 237ac <BmpCookieMask+0x2a>,-(sp)
    23e8:	move.l 237a8 <BmpCookieMask+0x26>,-(sp)
    23ee:	move.l 237a4 <BmpCookieMask+0x22>,-(sp)
    23f4:	move.l 237a0 <BmpCookieMask+0x1e>,-(sp)
    23fa:	move.l 2379c <BmpCookieMask+0x1a>,-(sp)
    2400:	move.l 23798 <BmpCookieMask+0x16>,-(sp)
    2406:	move.l 23794 <BmpCookieMask+0x12>,-(sp)
    240c:	move.l 23790 <BmpCookieMask+0xe>,-(sp)
    2412:	move.l 2378c <BmpCookieMask+0xa>,-(sp)
    2418:	move.l 23788 <BmpCookieMask+0x6>,-(sp)
    241e:	move.l 23784 <BmpCookieMask+0x2>,-(sp)
    2424:	move.w 23782 <BmpCookieMask>,-(sp)
    242a:	subq.l #2,sp
    242c:	move.l 23878 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2432:	move.l 23874 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2438:	move.l 23870 <BmpUpperPart_Buf1+0x26>,-(sp)
    243e:	move.l 2386c <BmpUpperPart_Buf1+0x22>,-(sp)
    2444:	move.l 23868 <BmpUpperPart_Buf1+0x1e>,-(sp)
    244a:	move.l 23864 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2450:	move.l 23860 <BmpUpperPart_Buf1+0x16>,-(sp)
    2456:	move.l 2385c <BmpUpperPart_Buf1+0x12>,-(sp)
    245c:	move.l 23858 <BmpUpperPart_Buf1+0xe>,-(sp)
    2462:	move.l 23854 <BmpUpperPart_Buf1+0xa>,-(sp)
    2468:	move.l 23850 <BmpUpperPart_Buf1+0x6>,-(sp)
    246e:	move.l 2384c <BmpUpperPart_Buf1+0x2>,-(sp)
    2474:	move.w 2384a <BmpUpperPart_Buf1>,-(sp)
    247a:	subq.l #2,sp
    247c:	move.l 237e2 <BmpCookie+0x2e>,-(sp)
    2482:	move.l 237de <BmpCookie+0x2a>,-(sp)
    2488:	move.l 237da <BmpCookie+0x26>,-(sp)
    248e:	move.l 237d6 <BmpCookie+0x22>,-(sp)
    2494:	move.l 237d2 <BmpCookie+0x1e>,-(sp)
    249a:	move.l 237ce <BmpCookie+0x1a>,-(sp)
    24a0:	move.l 237ca <BmpCookie+0x16>,-(sp)
    24a6:	move.l 237c6 <BmpCookie+0x12>,-(sp)
    24ac:	move.l 237c2 <BmpCookie+0xe>,-(sp)
    24b2:	move.l 237be <BmpCookie+0xa>,-(sp)
    24b8:	move.l 237ba <BmpCookie+0x6>,-(sp)
    24be:	move.l 237b6 <BmpCookie+0x2>,-(sp)
    24c4:	move.w 237b4 <BmpCookie>,-(sp)
    24ca:	jsr 11b6 <BetterBlit>(pc)
    24ce:	lea 180(sp),sp
    24d2:	bra.w 1a66 <MainLoop+0x4ec>
}
    24d6:	movem.l (sp)+,d2-d4/a2-a3
    24da:	rts

000024dc <KPrintF>:
void KPrintF(const char* fmt, ...) {
    24dc:	lea -128(sp),sp
    24e0:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    24e4:	move.w f0ff60 <_end+0xeec608>,d0
    24ea:	cmpi.w #20153,d0
    24ee:	beq.s 251a <KPrintF+0x3e>
    24f0:	cmpi.w #-24562,d0
    24f4:	beq.s 251a <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    24f6:	movea.l 2394c <SysBase>,a6
    24fc:	movea.l 144(sp),a0
    2500:	lea 148(sp),a1
    2504:	lea 2ca6 <KPutCharX>,a2
    250a:	suba.l a3,a3
    250c:	jsr -522(a6)
}
    2510:	movem.l (sp)+,a2-a3/a6
    2514:	lea 128(sp),sp
    2518:	rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    251a:	movea.l 2394c <SysBase>,a6
    2520:	movea.l 144(sp),a0
    2524:	lea 148(sp),a1
    2528:	lea 2cb4 <PutChar>,a2
    252e:	lea 12(sp),a3
    2532:	jsr -522(a6)
		UaeDbgLog(86, temp);
    2536:	move.l a3,-(sp)
    2538:	pea 56 <_start+0x56>
    253c:	jsr f0ff60 <_end+0xeec608>
    2542:	addq.l #8,sp
}
    2544:	movem.l (sp)+,a2-a3/a6
    2548:	lea 128(sp),sp
    254c:	rts

0000254e <main>:
{
    254e:	movem.l d2-d3/a2/a6,-(sp)
	SysBase = *((struct ExecBase **)4UL);
    2552:	movea.l 4 <_start+0x4>,a6
    2556:	move.l a6,2394c <SysBase>
	custom = (struct Custom *)0xdff000;
    255c:	move.l #14675968,23952 <custom>
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
    2566:	lea 46f1 <incbin_P61_Player_end+0x1>,a1
    256c:	moveq #0,d0
    256e:	jsr -552(a6)
    2572:	move.l d0,23948 <GfxBase>
	if (!GfxBase)
    2578:	beq.w 295a <main+0x40c>
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    257c:	movea.l 2394c <SysBase>,a6
    2582:	lea 4702 <incbin_P61_Player_end+0x12>,a1
    2588:	moveq #0,d0
    258a:	jsr -552(a6)
    258e:	move.l d0,23944 <DOSBase>
	if (!DOSBase)
    2594:	beq.w 296a <main+0x41c>
	KPrintF("Hello debugger from Amiga!\n");
    2598:	pea 470e <incbin_P61_Player_end+0x1e>
    259e:	jsr 24dc <KPrintF>(pc)
	Write(Output(), (APTR) "Hello console!\n", 15);
    25a2:	movea.l 23944 <DOSBase>,a6
    25a8:	jsr -60(a6)
    25ac:	movea.l 23944 <DOSBase>,a6
    25b2:	move.l d0,d1
    25b4:	move.l #18218,d2
    25ba:	moveq #15,d3
    25bc:	jsr -48(a6)
	BitmapInit(&Screen, 320, 256, 3);
    25c0:	pea 3 <_start+0x3>
    25c4:	pea 100 <MoveBobs+0x8c>
    25c8:	pea 140 <MoveBobs+0xcc>
    25cc:	pea 23912 <Screen>
    25d2:	lea 1394 <BitmapInit>(pc),a2
    25d6:	jsr (a2)
	BitmapInit(&BmpLogo, 256, 130, 3);
    25d8:	pea 3 <_start+0x3>
    25dc:	pea 82 <MoveBobs+0xe>
    25e0:	pea 100 <MoveBobs+0x8c>
    25e4:	pea 238e0 <BmpLogo>
    25ea:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF1, 320, 130, 3);
    25ec:	lea 36(sp),sp
    25f0:	pea 3 <_start+0x3>
    25f4:	pea 82 <MoveBobs+0xe>
    25f8:	pea 140 <MoveBobs+0xcc>
    25fc:	pea 238ae <BmpUpperPart_PF1>
    2602:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF2, 320, 130, 3);
    2604:	pea 3 <_start+0x3>
    2608:	pea 82 <MoveBobs+0xe>
    260c:	pea 140 <MoveBobs+0xcc>
    2610:	pea 2387c <BmpUpperPart_PF2>
    2616:	jsr (a2)
	BitmapInit(&BmpUpperPart_Buf1, 320, 130, 3);
    2618:	lea 32(sp),sp
    261c:	pea 3 <_start+0x3>
    2620:	pea 82 <MoveBobs+0xe>
    2624:	pea 140 <MoveBobs+0xcc>
    2628:	pea 2384a <BmpUpperPart_Buf1>
    262e:	jsr (a2)
	BitmapInit(&BmpScroller, 320 + 32, 166, 3);
    2630:	pea 3 <_start+0x3>
    2634:	pea a6 <MoveBobs+0x32>
    2638:	pea 160 <MoveBobs+0xec>
    263c:	pea 23818 <BmpScroller>
    2642:	jsr (a2)
	BitmapInit(&BmpFont32, 320, 256, 3);
    2644:	lea 32(sp),sp
    2648:	pea 3 <_start+0x3>
    264c:	pea 100 <MoveBobs+0x8c>
    2650:	pea 140 <MoveBobs+0xcc>
    2654:	pea 237e6 <BmpFont32>
    265a:	jsr (a2)
	BitmapInit(&BmpCookie, 320, 256, 3);
    265c:	pea 3 <_start+0x3>
    2660:	pea 100 <MoveBobs+0x8c>
    2664:	pea 140 <MoveBobs+0xcc>
    2668:	pea 237b4 <BmpCookie>
    266e:	jsr (a2)
	BitmapInit(&BmpCookieMask, 320, 256, 3);
    2670:	lea 32(sp),sp
    2674:	pea 3 <_start+0x3>
    2678:	pea 100 <MoveBobs+0x8c>
    267c:	pea 140 <MoveBobs+0xcc>
    2680:	pea 23782 <BmpCookieMask>
    2686:	jsr (a2)
	copPtr = AllocMem(1024, MEMF_CHIP);
    2688:	movea.l 2394c <SysBase>,a6
    268e:	move.l #1024,d0
    2694:	moveq #2,d1
    2696:	jsr -198(a6)
    269a:	move.l d0,2377e <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
    26a0:	movea.l 2394c <SysBase>,a6
    26a6:	moveq #0,d0
    26a8:	move.w 23824 <BmpScroller+0xc>,d0
    26ae:	move.l #65538,d1
    26b4:	jsr -198(a6)
    26b8:	move.l d0,23826 <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
    26be:	movea.l 2394c <SysBase>,a6
    26c4:	moveq #0,d0
    26c6:	move.w 238ba <BmpUpperPart_PF1+0xc>,d0
    26cc:	move.l #65538,d1
    26d2:	jsr -198(a6)
    26d6:	move.l d0,238bc <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
    26dc:	movea.l 2394c <SysBase>,a6
    26e2:	moveq #0,d0
    26e4:	move.w 23888 <BmpUpperPart_PF2+0xc>,d0
    26ea:	move.l #65538,d1
    26f0:	jsr -198(a6)
    26f4:	move.l d0,2388a <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
    26fa:	movea.l 2394c <SysBase>,a6
    2700:	moveq #0,d0
    2702:	move.w 23856 <BmpUpperPart_Buf1+0xc>,d0
    2708:	move.l #65538,d1
    270e:	jsr -198(a6)
    2712:	move.l d0,23858 <BmpUpperPart_Buf1+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
    2718:	move.l #24716,238ee <BmpLogo+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
    2722:	move.l #37198,237f4 <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
    272c:	move.l #67920,237c2 <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
    2736:	move.l #98642,23790 <BmpCookieMask+0xe>
	InitImagePlanes(&BmpUpperPart_PF1);
    2740:	pea 238ae <BmpUpperPart_PF1>
    2746:	lea f72 <InitImagePlanes>(pc),a2
    274a:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF2);
    274c:	pea 2387c <BmpUpperPart_PF2>
    2752:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_Buf1);
    2754:	pea 2384a <BmpUpperPart_Buf1>
    275a:	jsr (a2)
	InitImagePlanes(&BmpScroller);
    275c:	pea 23818 <BmpScroller>
    2762:	jsr (a2)
	InitImagePlanes(&BmpFont32);
    2764:	lea 32(sp),sp
    2768:	pea 237e6 <BmpFont32>
    276e:	jsr (a2)
	InitImagePlanes(&BmpCookie);
    2770:	pea 237b4 <BmpCookie>
    2776:	jsr (a2)
	InitImagePlanes(&BmpCookieMask);
    2778:	pea 23782 <BmpCookieMask>
    277e:	jsr (a2)
	TakeSystem();
    2780:	jsr de6 <TakeSystem>(pc)
	WaitVbl();
    2784:	jsr da0 <WaitVbl>(pc)
	SetupCopper(copPtr);
    2788:	move.l 2377e <copPtr>,-(sp)
    278e:	jsr 28c <SetupCopper>(pc)
	custom->cop1lc = (ULONG)copPtr;
    2792:	movea.l 23952 <custom>,a0
    2798:	move.l 2377e <copPtr>,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    27a0:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
    27a6:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    27ac:	move.w #-30752,150(a0)
	SetInterruptHandler((APTR)interruptHandler);
    27b2:	pea 1344 <interruptHandler>(pc)
    27b6:	jsr d86 <SetInterruptHandler>(pc)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
    27ba:	movea.l 23952 <custom>,a0
    27c0:	move.w #-16352,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
    27c6:	move.w #32,156(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
    27cc:	move.w #-24576,154(a0)
	if (p61Init(module) != 0)
    27d2:	pea 1f954 <incbin_module_start>
    27d8:	jsr 1300 <p61Init>(pc)
    27dc:	lea 24(sp),sp
    27e0:	tst.l d0
    27e2:	bne.w 2976 <main+0x428>
	InitStarfieldSprite();
    27e6:	jsr 13ce <InitStarfieldSprite>(pc)
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
    27ea:	pea 100 <MoveBobs+0x8c>
    27ee:	pea 82 <MoveBobs+0xe>
    27f2:	clr.l -(sp)
    27f4:	pea 20 <_start+0x20>
    27f8:	clr.l -(sp)
    27fa:	clr.l -(sp)
    27fc:	subq.l #2,sp
    27fe:	move.l 238dc <BmpUpperPart_PF1+0x2e>,-(sp)
    2804:	move.l 238d8 <BmpUpperPart_PF1+0x2a>,-(sp)
    280a:	move.l 238d4 <BmpUpperPart_PF1+0x26>,-(sp)
    2810:	move.l 238d0 <BmpUpperPart_PF1+0x22>,-(sp)
    2816:	move.l 238cc <BmpUpperPart_PF1+0x1e>,-(sp)
    281c:	move.l 238c8 <BmpUpperPart_PF1+0x1a>,-(sp)
    2822:	move.l 238c4 <BmpUpperPart_PF1+0x16>,-(sp)
    2828:	move.l 238c0 <BmpUpperPart_PF1+0x12>,-(sp)
    282e:	move.l 238bc <BmpUpperPart_PF1+0xe>,-(sp)
    2834:	move.l 238b8 <BmpUpperPart_PF1+0xa>,-(sp)
    283a:	move.l 238b4 <BmpUpperPart_PF1+0x6>,-(sp)
    2840:	move.l 238b0 <BmpUpperPart_PF1+0x2>,-(sp)
    2846:	move.w 238ae <BmpUpperPart_PF1>,-(sp)
    284c:	subq.l #2,sp
    284e:	move.l 2390e <BmpLogo+0x2e>,-(sp)
    2854:	move.l 2390a <BmpLogo+0x2a>,-(sp)
    285a:	move.l 23906 <BmpLogo+0x26>,-(sp)
    2860:	move.l 23902 <BmpLogo+0x22>,-(sp)
    2866:	move.l 238fe <BmpLogo+0x1e>,-(sp)
    286c:	move.l 238fa <BmpLogo+0x1a>,-(sp)
    2872:	move.l 238f6 <BmpLogo+0x16>,-(sp)
    2878:	move.l 238f2 <BmpLogo+0x12>,-(sp)
    287e:	move.l 238ee <BmpLogo+0xe>,-(sp)
    2884:	move.l 238ea <BmpLogo+0xa>,-(sp)
    288a:	move.l 238e6 <BmpLogo+0x6>,-(sp)
    2890:	move.l 238e2 <BmpLogo+0x2>,-(sp)
    2896:	move.w 238e0 <BmpLogo>,-(sp)
    289c:	jsr 10f2 <SimpleBlit>(pc)
	MainLoop();
    28a0:	lea 128(sp),sp
    28a4:	jsr 157a <MainLoop>(pc)
	p61End();
    28a8:	jsr 1372 <p61End>(pc)
	FreeMem(copPtr, 1024);
    28ac:	movea.l 2394c <SysBase>,a6
    28b2:	movea.l 2377e <copPtr>,a1
    28b8:	move.l #1024,d0
    28be:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    28c2:	movea.l 2394c <SysBase>,a6
    28c8:	movea.l 23826 <BmpScroller+0xe>,a1
    28ce:	moveq #0,d0
    28d0:	move.w 23824 <BmpScroller+0xc>,d0
    28d6:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    28da:	movea.l 2394c <SysBase>,a6
    28e0:	movea.l 238bc <BmpUpperPart_PF1+0xe>,a1
    28e6:	moveq #0,d0
    28e8:	move.w 238ba <BmpUpperPart_PF1+0xc>,d0
    28ee:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    28f2:	movea.l 2394c <SysBase>,a6
    28f8:	movea.l 2388a <BmpUpperPart_PF2+0xe>,a1
    28fe:	moveq #0,d0
    2900:	move.w 23888 <BmpUpperPart_PF2+0xc>,d0
    2906:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_Buf1.ImageData, BmpUpperPart_PF2.Btot);
    290a:	movea.l 2394c <SysBase>,a6
    2910:	movea.l 23858 <BmpUpperPart_Buf1+0xe>,a1
    2916:	moveq #0,d0
    2918:	move.w 23888 <BmpUpperPart_PF2+0xc>,d0
    291e:	jsr -210(a6)
	CloseLibrary((struct Library *)DOSBase);
    2922:	movea.l 2394c <SysBase>,a6
    2928:	movea.l 23944 <DOSBase>,a1
    292e:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    2932:	movea.l 2394c <SysBase>,a6
    2938:	movea.l 23948 <GfxBase>,a1
    293e:	jsr -414(a6)
	FreeSystem();
    2942:	jsr eb2 <FreeSystem>(pc)
	Exit(0);
    2946:	movea.l 23944 <DOSBase>,a6
    294c:	moveq #0,d1
    294e:	jsr -144(a6)
}
    2952:	moveq #0,d0
    2954:	movem.l (sp)+,d2-d3/a2/a6
    2958:	rts
		Exit(0);
    295a:	movea.l 23944 <DOSBase>,a6
    2960:	moveq #0,d1
    2962:	jsr -144(a6)
    2966:	bra.w 257c <main+0x2e>
		Exit(0);
    296a:	movea.l d0,a6
    296c:	moveq #0,d1
    296e:	jsr -144(a6)
    2972:	bra.w 2598 <main+0x4a>
		KPrintF("p61Init failed!\n");
    2976:	pea 473a <incbin_P61_Player_end+0x4a>
    297c:	jsr 24dc <KPrintF>(pc)
    2980:	addq.l #4,sp
    2982:	bra.w 27e6 <main+0x298>

00002986 <strlen>:
unsigned long strlen(const char* s) {
    2986:	movea.l 4(sp),a0
	unsigned long t=0;
    298a:	moveq #0,d0
	while(*s++)
    298c:	tst.b (a0)
    298e:	beq.s 2998 <strlen+0x12>
		t++;
    2990:	addq.l #1,d0
	while(*s++)
    2992:	tst.b (0,a0,d0.l)
    2996:	bne.s 2990 <strlen+0xa>
}
    2998:	rts

0000299a <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    299a:	movem.l d2-d7/a2-a3,-(sp)
    299e:	move.l 36(sp),d0
    29a2:	move.l 40(sp),d4
    29a6:	movea.l 44(sp),a1
	while(len-- > 0)
    29aa:	move.l a1,d5
    29ac:	subq.l #1,d5
    29ae:	cmpa.w #0,a1
    29b2:	beq.w 2a62 <memset+0xc8>
		*ptr++ = val;
    29b6:	move.b d4,d7
    29b8:	move.l d0,d1
    29ba:	neg.l d1
    29bc:	moveq #3,d2
    29be:	and.l d2,d1
    29c0:	moveq #5,d6
    29c2:	movea.l d0,a2
    29c4:	cmp.l d5,d6
    29c6:	bcc.s 2a32 <memset+0x98>
    29c8:	tst.l d1
    29ca:	beq.s 29f0 <memset+0x56>
    29cc:	move.b d4,(a2)+
	while(len-- > 0)
    29ce:	subq.l #1,d5
    29d0:	moveq #1,d2
    29d2:	cmp.l d1,d2
    29d4:	beq.s 29f0 <memset+0x56>
		*ptr++ = val;
    29d6:	movea.l d0,a2
    29d8:	addq.l #2,a2
    29da:	movea.l d0,a0
    29dc:	move.b d4,1(a0)
	while(len-- > 0)
    29e0:	subq.l #1,d5
    29e2:	moveq #3,d2
    29e4:	cmp.l d1,d2
    29e6:	bne.s 29f0 <memset+0x56>
		*ptr++ = val;
    29e8:	addq.l #1,a2
    29ea:	move.b d4,2(a0)
	while(len-- > 0)
    29ee:	subq.l #1,d5
    29f0:	move.l a1,d3
    29f2:	sub.l d1,d3
    29f4:	moveq #0,d6
    29f6:	move.b d4,d6
    29f8:	move.l d6,d2
    29fa:	swap d2
    29fc:	clr.w d2
    29fe:	movea.l d2,a0
    2a00:	move.l d4,d2
    2a02:	lsl.w #8,d2
    2a04:	swap d2
    2a06:	clr.w d2
    2a08:	lsl.l #8,d6
    2a0a:	movea.l d6,a3
    2a0c:	move.l a0,d6
    2a0e:	or.l d6,d2
    2a10:	move.l a3,d6
    2a12:	or.l d6,d2
    2a14:	move.b d7,d2
    2a16:	movea.l d0,a0
    2a18:	adda.l d1,a0
    2a1a:	moveq #-4,d1
    2a1c:	and.l d3,d1
    2a1e:	add.l a0,d1
		*ptr++ = val;
    2a20:	move.l d2,(a0)+
	while(len-- > 0)
    2a22:	cmpa.l d1,a0
    2a24:	bne.s 2a20 <memset+0x86>
    2a26:	moveq #-4,d1
    2a28:	and.l d3,d1
    2a2a:	adda.l d1,a2
    2a2c:	sub.l d1,d5
    2a2e:	cmp.l d3,d1
    2a30:	beq.s 2a62 <memset+0xc8>
		*ptr++ = val;
    2a32:	move.b d4,(a2)
	while(len-- > 0)
    2a34:	tst.l d5
    2a36:	beq.s 2a62 <memset+0xc8>
		*ptr++ = val;
    2a38:	move.b d4,1(a2)
	while(len-- > 0)
    2a3c:	moveq #1,d1
    2a3e:	cmp.l d5,d1
    2a40:	beq.s 2a62 <memset+0xc8>
		*ptr++ = val;
    2a42:	move.b d4,2(a2)
	while(len-- > 0)
    2a46:	moveq #2,d2
    2a48:	cmp.l d5,d2
    2a4a:	beq.s 2a62 <memset+0xc8>
		*ptr++ = val;
    2a4c:	move.b d4,3(a2)
	while(len-- > 0)
    2a50:	moveq #3,d6
    2a52:	cmp.l d5,d6
    2a54:	beq.s 2a62 <memset+0xc8>
		*ptr++ = val;
    2a56:	move.b d4,4(a2)
	while(len-- > 0)
    2a5a:	subq.l #4,d5
    2a5c:	beq.s 2a62 <memset+0xc8>
		*ptr++ = val;
    2a5e:	move.b d4,5(a2)
}
    2a62:	movem.l (sp)+,d2-d7/a2-a3
    2a66:	rts

00002a68 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    2a68:	movem.l d2-d6,-(sp)
    2a6c:	move.l 24(sp),d0
    2a70:	move.l 28(sp),d1
    2a74:	move.l 32(sp),d3
	while(len--)
    2a78:	move.l d3,d4
    2a7a:	subq.l #1,d4
    2a7c:	tst.l d3
    2a7e:	beq.s 2ade <memcpy+0x76>
    2a80:	movea.l d1,a0
    2a82:	addq.l #1,a0
    2a84:	move.l d0,d2
    2a86:	sub.l a0,d2
    2a88:	moveq #2,d5
    2a8a:	cmp.l d2,d5
    2a8c:	sc.s d2
    2a8e:	neg.b d2
    2a90:	moveq #8,d6
    2a92:	cmp.l d4,d6
    2a94:	sc.s d5
    2a96:	neg.b d5
    2a98:	and.b d5,d2
    2a9a:	beq.s 2ae4 <memcpy+0x7c>
    2a9c:	move.l d0,d2
    2a9e:	or.l d1,d2
    2aa0:	moveq #3,d5
    2aa2:	and.l d5,d2
    2aa4:	bne.s 2ae4 <memcpy+0x7c>
    2aa6:	movea.l d1,a0
    2aa8:	movea.l d0,a1
    2aaa:	moveq #-4,d2
    2aac:	and.l d3,d2
    2aae:	add.l d1,d2
		*d++ = *s++;
    2ab0:	move.l (a0)+,(a1)+
	while(len--)
    2ab2:	cmp.l a0,d2
    2ab4:	bne.s 2ab0 <memcpy+0x48>
    2ab6:	moveq #-4,d2
    2ab8:	and.l d3,d2
    2aba:	movea.l d0,a0
    2abc:	adda.l d2,a0
    2abe:	add.l d2,d1
    2ac0:	sub.l d2,d4
    2ac2:	cmp.l d3,d2
    2ac4:	beq.s 2ade <memcpy+0x76>
		*d++ = *s++;
    2ac6:	movea.l d1,a1
    2ac8:	move.b (a1),(a0)
	while(len--)
    2aca:	tst.l d4
    2acc:	beq.s 2ade <memcpy+0x76>
		*d++ = *s++;
    2ace:	move.b 1(a1),1(a0)
	while(len--)
    2ad4:	subq.l #1,d4
    2ad6:	beq.s 2ade <memcpy+0x76>
		*d++ = *s++;
    2ad8:	move.b 2(a1),2(a0)
}
    2ade:	movem.l (sp)+,d2-d6
    2ae2:	rts
    2ae4:	movea.l d0,a1
    2ae6:	add.l d3,d1
		*d++ = *s++;
    2ae8:	move.b -1(a0),(a1)+
	while(len--)
    2aec:	cmp.l a0,d1
    2aee:	beq.s 2ade <memcpy+0x76>
    2af0:	addq.l #1,a0
    2af2:	bra.s 2ae8 <memcpy+0x80>

00002af4 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    2af4:	movem.l d2-d5/a2,-(sp)
    2af8:	move.l 24(sp),d0
    2afc:	move.l 28(sp),d1
    2b00:	move.l 32(sp),d2
		while (len--)
    2b04:	movea.l d2,a1
    2b06:	subq.l #1,a1
	if (d < s) {
    2b08:	cmp.l d0,d1
    2b0a:	bls.s 2b78 <memmove+0x84>
		while (len--)
    2b0c:	tst.l d2
    2b0e:	beq.s 2b72 <memmove+0x7e>
    2b10:	movea.l d1,a2
    2b12:	addq.l #1,a2
    2b14:	move.l d0,d3
    2b16:	sub.l a2,d3
    2b18:	moveq #2,d4
    2b1a:	cmp.l d3,d4
    2b1c:	sc.s d3
    2b1e:	neg.b d3
    2b20:	moveq #8,d5
    2b22:	cmp.l a1,d5
    2b24:	sc.s d4
    2b26:	neg.b d4
    2b28:	and.b d4,d3
    2b2a:	beq.s 2b9c <memmove+0xa8>
    2b2c:	move.l d0,d3
    2b2e:	or.l d1,d3
    2b30:	moveq #3,d4
    2b32:	and.l d4,d3
    2b34:	bne.s 2b9c <memmove+0xa8>
    2b36:	movea.l d1,a0
    2b38:	movea.l d0,a2
    2b3a:	moveq #-4,d3
    2b3c:	and.l d2,d3
    2b3e:	add.l d1,d3
			*d++ = *s++;
    2b40:	move.l (a0)+,(a2)+
		while (len--)
    2b42:	cmp.l a0,d3
    2b44:	bne.s 2b40 <memmove+0x4c>
    2b46:	moveq #-4,d3
    2b48:	and.l d2,d3
    2b4a:	movea.l d0,a2
    2b4c:	adda.l d3,a2
    2b4e:	movea.l d1,a0
    2b50:	adda.l d3,a0
    2b52:	suba.l d3,a1
    2b54:	cmp.l d2,d3
    2b56:	beq.s 2b72 <memmove+0x7e>
			*d++ = *s++;
    2b58:	move.b (a0),(a2)
		while (len--)
    2b5a:	cmpa.w #0,a1
    2b5e:	beq.s 2b72 <memmove+0x7e>
			*d++ = *s++;
    2b60:	move.b 1(a0),1(a2)
		while (len--)
    2b66:	moveq #1,d5
    2b68:	cmp.l a1,d5
    2b6a:	beq.s 2b72 <memmove+0x7e>
			*d++ = *s++;
    2b6c:	move.b 2(a0),2(a2)
}
    2b72:	movem.l (sp)+,d2-d5/a2
    2b76:	rts
		const char *lasts = s + (len - 1);
    2b78:	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    2b7c:	adda.l d0,a1
		while (len--)
    2b7e:	tst.l d2
    2b80:	beq.s 2b72 <memmove+0x7e>
    2b82:	move.l a0,d1
    2b84:	sub.l d2,d1
			*lastd-- = *lasts--;
    2b86:	move.b (a0),(a1)
		while (len--)
    2b88:	subq.l #1,a0
    2b8a:	subq.l #1,a1
    2b8c:	cmp.l a0,d1
    2b8e:	beq.s 2b72 <memmove+0x7e>
			*lastd-- = *lasts--;
    2b90:	move.b (a0),(a1)
		while (len--)
    2b92:	subq.l #1,a0
    2b94:	subq.l #1,a1
    2b96:	cmp.l a0,d1
    2b98:	bne.s 2b86 <memmove+0x92>
    2b9a:	bra.s 2b72 <memmove+0x7e>
    2b9c:	movea.l d0,a1
    2b9e:	add.l d2,d1
			*d++ = *s++;
    2ba0:	move.b -1(a2),(a1)+
		while (len--)
    2ba4:	cmp.l a2,d1
    2ba6:	beq.s 2b72 <memmove+0x7e>
    2ba8:	addq.l #1,a2
    2baa:	bra.s 2ba0 <memmove+0xac>

00002bac <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    2bac:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    2bb0:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2bb4:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    2bb8:	mulu.w 8(sp),d1
	addw	d1, d0
    2bbc:	add.w d1,d0
	swap	d0
    2bbe:	swap d0
	clrw	d0
    2bc0:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2bc2:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    2bc6:	mulu.w 10(sp),d1
	addl	d1, d0
    2bca:	add.l d1,d0
	rts
    2bcc:	rts

00002bce <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    2bce:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    2bd0:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    2bd4:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    2bd8:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    2bde:	bcc.s 2bf6 <__udivsi3+0x28>
	movel	d0, d2
    2be0:	move.l d0,d2
	clrw	d2
    2be2:	clr.w d2
	swap	d2
    2be4:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    2be6:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    2be8:	move.w d2,d0
	swap	d0
    2bea:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    2bec:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    2bf0:	divu.w d1,d2
	movew	d2, d0
    2bf2:	move.w d2,d0
	jra	6f
    2bf4:	bra.s 2c26 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    2bf6:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    2bf8:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    2bfa:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    2bfc:	cmpi.l #65536,d1
	jcc	4b
    2c02:	bcc.s 2bf8 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    2c04:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    2c06:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    2c0c:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    2c0e:	mulu.w d0,d1
	swap	d2
    2c10:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    2c12:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    2c14:	swap d2
	tstw	d2		/* high part 17 bits? */
    2c16:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    2c18:	bne.s 2c24 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    2c1a:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    2c1c:	bcs.s 2c24 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    2c1e:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    2c22:	bls.s 2c26 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    2c24:	subq.l #1,d0

6:	movel	sp@+, d2
    2c26:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    2c28:	rts

00002c2a <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    2c2a:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    2c2c:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    2c2e:	move.l 12(sp),d1
	jpl	1f
    2c32:	bpl.s 2c38 <__divsi3+0xe>
	negl	d1
    2c34:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    2c36:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    2c38:	move.l 8(sp),d0
	jpl	2f
    2c3c:	bpl.s 2c42 <__divsi3+0x18>
	negl	d0
    2c3e:	neg.l d0
	negb	d2
    2c40:	neg.b d2

2:	movel	d1, sp@-
    2c42:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2c44:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    2c46:	bsr.s 2bce <__udivsi3>
	addql	#8, sp
    2c48:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    2c4a:	tst.b d2
	jpl	3f
    2c4c:	bpl.s 2c50 <__divsi3+0x26>
	negl	d0
    2c4e:	neg.l d0

3:	movel	sp@+, d2
    2c50:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    2c52:	rts

00002c54 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    2c54:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    2c58:	move.l 4(sp),d0
	movel	d1, sp@-
    2c5c:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2c5e:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    2c60:	bsr.s 2c2a <__divsi3>
	addql	#8, sp
    2c62:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    2c64:	move.l 8(sp),d1
	movel	d1, sp@-
    2c68:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2c6a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    2c6c:	bsr.w 2bac <__mulsi3>
	addql	#8, sp
    2c70:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2c72:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2c76:	sub.l d0,d1
	movel	d1, d0
    2c78:	move.l d1,d0
	rts
    2c7a:	rts

00002c7c <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    2c7c:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    2c80:	move.l 4(sp),d0
	movel	d1, sp@-
    2c84:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2c86:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    2c88:	bsr.w 2bce <__udivsi3>
	addql	#8, sp
    2c8c:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    2c8e:	move.l 8(sp),d1
	movel	d1, sp@-
    2c92:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2c94:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    2c96:	bsr.w 2bac <__mulsi3>
	addql	#8, sp
    2c9a:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2c9c:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2ca0:	sub.l d0,d1
	movel	d1, d0
    2ca2:	move.l d1,d0
	rts
    2ca4:	rts

00002ca6 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    2ca6:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    2ca8:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    2cac:	jsr -516(a6)
    move.l (sp)+, a6
    2cb0:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    2cb2:	rts

00002cb4 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    2cb4:	move.b d0,(a3)+
	rts
    2cb6:	rts

00002cb8 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    2cb8:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    2cba:	adda.l a0,a2
	move.l	a2,a3
    2cbc:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    2cbe:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    2cc0:	moveq #56,d4
	moveq	#8,d5
    2cc2:	moveq #8,d5
	bra.s	.Lliteral
    2cc4:	bra.s 2d2e <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    2cc6:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    2cc8:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    2cca:	dbf d1,2cc6 <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    2cce:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    2cd0:	bcc.s 2cd4 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    2cd2:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    2cd4:	tst.w d0
    2cd6:	bne.s 2ce0 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    2cd8:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    2cda:	bls.s 2d52 <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    2cdc:	move.w (a0)+,d0
    2cde:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    2ce0:	rol.l #6,d0
	move.w	d0,d1
    2ce2:	move.w d0,d1
	and.w	d4,d1
    2ce4:	and.w d4,d1
	eor.w	d1,d0
    2ce6:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    2ce8:	movem.w (2d4c <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    2cee:	rol.l d2,d0
	and.w	d0,d3					|scaling
    2cf0:	and.w d0,d3
	eor.w	d3,d0
    2cf2:	eor.w d3,d0
	suba.w	d3,a4
    2cf4:	suba.w d3,a4
	adda.l	a1,a4
    2cf6:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    2cf8:	tst.w d0
    2cfa:	bne.s 2d00 <_doynaxdepack_asm+0x48>
    2cfc:	move.w (a0)+,d0
    2cfe:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    2d00:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    2d02:	beq.s 2d1a <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    2d04:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    2d06:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    2d08:	bpl.s 2d16 <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    2d0a:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    2d0c:	bpl.s 2d14 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    2d0e:	addx.b d1,d1
	lsl.l	#2,d0
    2d10:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    2d12:	bmi.s 2d0e <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    2d14:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    2d16:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    2d18:	bcc.s 2d1c <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    2d1a:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    2d1c:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    2d1e:	dbf d1,2d1a <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    2d22:	add.l d0,d0
	bcc.s	.Lmatch
    2d24:	bcc.s 2cd4 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    2d26:	tst.w d0
    2d28:	bne.s 2d2e <_doynaxdepack_asm+0x76>
    2d2a:	move.w (a0)+,d0
    2d2c:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    2d2e:	moveq #0,d1
	add.l	d0,d0
    2d30:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    2d32:	bcc.s 2cd2 <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    2d34:	bpl.s 2d3c <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    2d36:	addx.b d1,d1
	lsl.l	#2,d0
    2d38:	lsl.l #2,d0
	bmi.s	.Llgetlen
    2d3a:	bmi.s 2d36 <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    2d3c:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    2d3e:	dbv.s d1,2cc6 <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    2d42:	add.l d0,d0
	eor.w	d1,d0		
    2d44:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    2d46:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    2d48:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    2d4a:	bra.s 2d3e <_doynaxdepack_asm+0x86>

00002d4c <doy_table>:
    2d4c:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    2d5c:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    2d6c:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    2d7c:	.............o
