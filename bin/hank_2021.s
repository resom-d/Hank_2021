
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
       4:	move.l #26300,d3
       a:	subi.l #26300,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	beq.s 26 <_start+0x26>
      14:	lea 66bc <NextPlot>,a2
      1a:	moveq #0,d2
		__preinit_array_start[i]();
      1c:	movea.l (a2)+,a0
      1e:	jsr (a0)
	for (i = 0; i < count; i++)
      20:	addq.l #1,d2
      22:	cmp.l d3,d2
      24:	bne.s 1c <_start+0x1c>

	count = __init_array_end - __init_array_start;
      26:	move.l #26300,d3
      2c:	subi.l #26300,d3
      32:	asr.l #2,d3
	for (i = 0; i < count; i++)
      34:	beq.s 48 <_start+0x48>
      36:	lea 66bc <NextPlot>,a2
      3c:	moveq #0,d2
		__init_array_start[i]();
      3e:	movea.l (a2)+,a0
      40:	jsr (a0)
	for (i = 0; i < count; i++)
      42:	addq.l #1,d2
      44:	cmp.l d3,d2
      46:	bne.s 3e <_start+0x3e>

	main();
      48:	jsr 1e22 <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
      4e:	move.l #26300,d2
      54:	subi.l #26300,d2
      5a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      5c:	beq.s 6e <_start+0x6e>
      5e:	lea 66bc <NextPlot>,a2
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
		//custom->color[0]=0xf00;
	}
}

void MoveBobs()
{
      74:	move.l d3,-(sp)
      76:	move.l d2,-(sp)
	switch (BobPhase)
      78:	move.w 23de8 <BobPhase>,d0
      7e:	beq.s ec <MoveBobs+0x78>
      80:	cmpi.w #1,d0
      84:	beq.w 1b0 <MoveBobs+0x13c>
			BobPhase = 0;
			*copPF1BmpP = 1 << 6;	
		}
		break;
	}
}
      88:	move.l (sp)+,d2
      8a:	move.l (sp)+,d3
      8c:	rts
				BobTarget[b].X += BobVecs[b].X;
      8e:	lea 66c2 <BobVecs>,a1
      94:	move.l d0,d3
      96:	lsl.l #3,d3
      98:	movea.l d3,a0
      9a:	add.l (0,a1,d3.l),d1
      9e:	lea 66e2 <BobTarget>,a1
      a4:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X > 320 - 32)
      a8:	cmpi.l #288,d1
      ae:	ble.s b8 <MoveBobs+0x44>
					BobTarget[b].X = 320 - 32;
      b0:	move.l #288,(0,a1,d3.l)
{
      b8:	move.l d2,d0
		for (int b = 0; b < BOBSN - 1; b++)
      ba:	moveq #2,d1
      bc:	cmp.l d0,d1
      be:	blt.s f0 <MoveBobs+0x7c>
			if ((BobTarget[b + 1].X - BobTarget[b].X) > 34 || BobTarget[b + 1].X >= 320 - 32)
      c0:	move.l d0,d2
      c2:	addq.l #1,d2
      c4:	lea 66e2 <BobTarget>,a0
      ca:	move.l d2,d1
      cc:	lsl.l #3,d1
      ce:	movea.l (0,a0,d1.l),a1
      d2:	move.l d0,d1
      d4:	lsl.l #3,d1
      d6:	move.l (0,a0,d1.l),d1
      da:	movea.l a1,a0
      dc:	suba.l d1,a0
      de:	moveq #34,d3
      e0:	cmp.l a0,d3
      e2:	blt.s 8e <MoveBobs+0x1a>
      e4:	cmpa.w #287,a1
      e8:	ble.s b8 <MoveBobs+0x44>
      ea:	bra.s 8e <MoveBobs+0x1a>
	switch (BobPhase)
      ec:	moveq #0,d0
      ee:	bra.s ba <MoveBobs+0x46>
		if (BobTarget[BOBSN - 1].X < 320 - 32)
      f0:	move.l 66fa <BobTarget+0x18>,d0
      f6:	cmpi.l #287,d0
      fc:	bgt.s 10a <MoveBobs+0x96>
			BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
      fe:	add.l 66da <BobVecs+0x18>,d0
     104:	move.l d0,66fa <BobTarget+0x18>
		if (BobTarget[BOBSN - 1].X > 320 - 32)
     10a:	cmpi.l #288,66fa <BobTarget+0x18>
     114:	ble.s 120 <MoveBobs+0xac>
			BobTarget[BOBSN - 1].X = 320 - 32;
     116:	move.l #288,66fa <BobTarget+0x18>
		if (BobTarget[0].X >= 320 - 32)
     120:	cmpi.l #287,66e2 <BobTarget>
     12a:	ble.w 88 <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     12e:	neg.l 66c2 <BobVecs>
			BobVecs[1].X *= -1;
     134:	neg.l 66ca <BobVecs+0x8>
			BobVecs[2].X *= -1;
     13a:	neg.l 66d2 <BobVecs+0x10>
			BobVecs[3].X *= -1;
     140:	neg.l 66da <BobVecs+0x18>
			BobPhase = 1;
     146:	move.w #1,23de8 <BobPhase>
			*copPF1BmpP = 0 << 6;
     14e:	movea.l 23de4 <copPF1BmpP>,a0
     154:	clr.w (a0)
     156:	bra.w 88 <MoveBobs+0x14>
				BobTarget[b].X += BobVecs[b].X;
     15a:	lea 66c2 <BobVecs>,a1
     160:	move.l d0,d3
     162:	lsl.l #3,d3
     164:	movea.l d3,a0
     166:	add.l (0,a1,d3.l),d1
     16a:	lea 66e2 <BobTarget>,a1
     170:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X < 0)
     174:	bmi.s 1aa <MoveBobs+0x136>
	switch (BobPhase)
     176:	move.l d2,d0
		for (int b = 0; b < BOBSN - 1; b++)
     178:	moveq #2,d1
     17a:	cmp.l d0,d1
     17c:	blt.s 1b4 <MoveBobs+0x140>
			if ((BobTarget[b].X - BobTarget[b + 1].X) > 34 || BobTarget[b + 1].X <= 0)
     17e:	lea 66e2 <BobTarget>,a0
     184:	move.l d0,d1
     186:	lsl.l #3,d1
     188:	move.l (0,a0,d1.l),d1
     18c:	move.l d0,d2
     18e:	addq.l #1,d2
     190:	move.l d2,d3
     192:	lsl.l #3,d3
     194:	movea.l (0,a0,d3.l),a0
     198:	movea.l d1,a1
     19a:	suba.l a0,a1
     19c:	moveq #34,d3
     19e:	cmp.l a1,d3
     1a0:	blt.s 15a <MoveBobs+0xe6>
     1a2:	cmpa.w #0,a0
     1a6:	bgt.s 176 <MoveBobs+0x102>
     1a8:	bra.s 15a <MoveBobs+0xe6>
					BobTarget[b].X = 0;
     1aa:	clr.l (0,a1,d3.l)
     1ae:	bra.s 176 <MoveBobs+0x102>
	switch (BobPhase)
     1b0:	moveq #0,d0
     1b2:	bra.s 178 <MoveBobs+0x104>
		if (BobTarget[BOBSN - 1].X > 0)
     1b4:	move.l 66fa <BobTarget+0x18>,d0
     1ba:	ble.s 1c8 <MoveBobs+0x154>
			BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
     1bc:	add.l 66da <BobVecs+0x18>,d0
     1c2:	move.l d0,66fa <BobTarget+0x18>
		if (BobTarget[BOBSN - 1].X < 0)
     1c8:	tst.l 66fa <BobTarget+0x18>
     1ce:	blt.s 206 <MoveBobs+0x192>
		if (BobTarget[0].X <= 0)
     1d0:	tst.l 66e2 <BobTarget>
     1d6:	bgt.w 88 <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     1da:	neg.l 66c2 <BobVecs>
			BobVecs[1].X *= -1;
     1e0:	neg.l 66ca <BobVecs+0x8>
			BobVecs[2].X *= -1;
     1e6:	neg.l 66d2 <BobVecs+0x10>
			BobVecs[3].X *= -1;
     1ec:	neg.l 66da <BobVecs+0x18>
			BobPhase = 0;
     1f2:	clr.w 23de8 <BobPhase>
			*copPF1BmpP = 1 << 6;	
     1f8:	movea.l 23de4 <copPF1BmpP>,a0
     1fe:	move.w #64,(a0)
     202:	bra.w 88 <MoveBobs+0x14>
			BobTarget[BOBSN - 1].X = 0;
     206:	clr.l 66fa <BobTarget+0x18>
     20c:	bra.s 1d0 <MoveBobs+0x15c>

0000020e <SetupCopper>:

void SetupCopper(USHORT *copPtr)
{
     20e:	movem.l d2-d5/a2,-(sp)
     212:	movea.l 24(sp),a1
	UBYTE line = 0x1c;
	// set screen output size
	*copPtr++ = DIWSTRT;
     216:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     21a:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     220:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     226:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     22c:	move.w #146,8(a1)
	*copPtr++ = 0x38; // + ((Screen.Width - BmpLogo.Width) / 4);
     232:	move.w #56,10(a1)
	*copPtr++ = DDFSTOP;
     238:	move.w #148,12(a1)
	*copPtr++ = 0xd0; // - ((Screen.Width - BmpLogo.Width) / 4);
     23e:	move.w #208,14(a1)
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl);
     244:	move.w 23f2e <BmpUpperPart_PF1+0x8>,d0
     24a:	sub.w 23f2c <BmpUpperPart_PF1+0x6>,d0
    return copListEnd;
}
inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     250:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     256:	move.w d0,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     25a:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     260:	move.w d0,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     264:	move.w #258,24(a1)
	*copPtr++ = 0;
     26a:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     26e:	move.w #260,28(a1)
	copPF1BmpP = copPtr;
     274:	lea 30(a1),a0
     278:	move.l a0,23de4 <copPF1BmpP>
	*copPtr++ = 1 << 6;	 //0x24; pf1 >> pf 2 >> sprites
     27e:	move.w #64,30(a1)
    *copListEnd++ = COP_SKIP;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     284:	move.w #384,32(a1)
    *copListCurrent++ = color;
     28a:	move.w #21,34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     290:	move.w #398,36(a1)
    *copListCurrent++ = color;
     296:	lea 40(a1),a0
     29a:	move.w #21,38(a1)
	// set logo colors
	copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[0]);
	copPtr = copSetColor(copPtr, 7, colgradbluePaletteRGB4[0]);
	for (int a = 1; a < 8; a++)
     2a0:	moveq #1,d0
     2a2:	bra.s 2c2 <SetupCopper+0xb4>
	{
		copPtr = copSetColor(copPtr, a, LogoPaletteRGB4[a]);
     2a4:	movea.l d0,a1
     2a6:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2a8:	move.w d0,d1
     2aa:	addi.w #192,d1
     2ae:	add.w d1,d1
     2b0:	move.w d1,(a0)
    *copListCurrent++ = color;
     2b2:	lea 463c <LogoPaletteRGB4>,a2
     2b8:	move.w (0,a2,a1.l),2(a0)
	for (int a = 1; a < 8; a++)
     2be:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, LogoPaletteRGB4[a]);
     2c0:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     2c2:	moveq #7,d1
     2c4:	cmp.l d0,d1
     2c6:	bge.s 2a4 <SetupCopper+0x96>
	}
	for (int a = 8; a < 16; a++)
     2c8:	moveq #8,d0
     2ca:	bra.s 2ec <SetupCopper+0xde>
	{
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     2cc:	move.l d0,d1
     2ce:	subq.l #8,d1
     2d0:	add.l d1,d1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2d2:	movea.w d0,a1
     2d4:	lea 192(a1),a1
     2d8:	adda.w a1,a1
     2da:	move.w a1,(a0)
    *copListCurrent++ = color;
     2dc:	lea 462c <CookiePaletteRGB4>,a1
     2e2:	move.w (0,a1,d1.l),2(a0)
	for (int a = 8; a < 16; a++)
     2e8:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     2ea:	addq.l #4,a0
	for (int a = 8; a < 16; a++)
     2ec:	moveq #15,d2
     2ee:	cmp.l d0,d2
     2f0:	bge.s 2cc <SetupCopper+0xbe>
	}
	// set upper part, pf1, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
     2f2:	moveq #0,d5
     2f4:	move.w 23f2c <BmpUpperPart_PF1+0x6>,d5
     2fa:	moveq #0,d4
     2fc:	move.w 23f2a <BmpUpperPart_PF1+0x4>,d4
     302:	move.l 23f34 <BmpUpperPart_PF1+0xe>,d1
    for (USHORT i = 0; i < numPlanes; i++)
     308:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     30a:	clr.b d2
     30c:	bra.s 33a <SetupCopper+0x12c>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     30e:	move.b d2,d0
     310:	ext.w d0
     312:	movea.w d0,a1
     314:	moveq #56,d0
     316:	add.l a1,d0
     318:	add.w d0,d0
     31a:	add.w d0,d0
     31c:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     31e:	move.l d1,d3
     320:	clr.w d3
     322:	swap d3
     324:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     328:	addq.w #2,d0
     32a:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     32e:	move.w d1,6(a0)
        addr += Bpl;
     332:	add.l d5,d1
        plane += 2;
     334:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     336:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     338:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     33a:	moveq #0,d0
     33c:	move.w a2,d0
     33e:	cmp.l d4,d0
     340:	blt.s 30e <SetupCopper+0x100>
	// set upper part, pf2, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
     342:	moveq #0,d5
     344:	move.w 23efa <BmpUpperPart_PF2+0x6>,d5
     34a:	moveq #0,d4
     34c:	move.w 23ef8 <BmpUpperPart_PF2+0x4>,d4
     352:	move.l 23f02 <BmpUpperPart_PF2+0xe>,d1
     358:	suba.l a2,a2
    BYTE plane = odd ? 1 : 0;
     35a:	moveq #1,d2
     35c:	bra.s 38a <SetupCopper+0x17c>
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     35e:	move.b d2,d0
     360:	ext.w d0
     362:	movea.w d0,a1
     364:	moveq #56,d0
     366:	add.l a1,d0
     368:	add.w d0,d0
     36a:	add.w d0,d0
     36c:	move.w d0,(a0)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     36e:	move.l d1,d3
     370:	clr.w d3
     372:	swap d3
     374:	move.w d3,2(a0)
        *copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     378:	addq.w #2,d0
     37a:	move.w d0,4(a0)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     37e:	move.w d1,6(a0)
        addr += Bpl;
     382:	add.l d5,d1
        plane += 2;
     384:	addq.b #2,d2
    for (USHORT i = 0; i < numPlanes; i++)
     386:	addq.w #1,a2
        *copListEnd++ = (UWORD)addr; // high-word of adress
     388:	addq.l #8,a0
    for (USHORT i = 0; i < numPlanes; i++)
     38a:	moveq #0,d0
     38c:	move.w a2,d0
     38e:	cmp.l d4,d0
     390:	blt.s 35e <SetupCopper+0x150>
	// set sprite pointers
	*copPtr++ = SPR0PTH;
     392:	move.w #288,(a0)
	*copPtr++ = (LONG)StarSprite >> 16;
     396:	move.l #146140,d0
     39c:	move.l d0,d1
     39e:	swap d1
     3a0:	ext.l d1
     3a2:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
     3a6:	move.w #290,4(a0)
	*copPtr++ = (LONG)StarSprite;
     3ac:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
     3b0:	move.w #292,8(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     3b6:	move.l #146128,d0
     3bc:	move.l d0,d1
     3be:	swap d1
     3c0:	ext.l d1
     3c2:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
     3c6:	move.w #294,12(a0)
	*copPtr++ = (LONG)NullSprite;
     3cc:	move.w d0,14(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     3d0:	move.w #418,16(a0)
    *copListCurrent++ = color;
     3d6:	move.w #3234,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     3dc:	move.w #420,20(a0)
    *copListCurrent++ = color;
     3e2:	move.w #3276,22(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     3e8:	move.w #422,24(a0)
    *copListCurrent++ = color;
     3ee:	move.w #4095,26(a0)
	// sprite 0+1 colors
	copPtr = copSetColor(copPtr, 17, 0xca2);
	copPtr = copSetColor(copPtr, 18, 0xccc);
	copPtr = copSetColor(copPtr, 19, 0xfff);
	*copPtr++ = SPR2PTH;
     3f4:	move.w #296,28(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     3fa:	move.w d1,30(a0)
	*copPtr++ = SPR2PTL;
     3fe:	move.w #298,32(a0)
	*copPtr++ = (LONG)NullSprite;
     404:	move.w d0,34(a0)
	*copPtr++ = SPR3PTH;
     408:	move.w #300,36(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     40e:	move.w d1,38(a0)
	*copPtr++ = SPR3PTL;
     412:	move.w #302,40(a0)
	*copPtr++ = (LONG)NullSprite;
     418:	move.w d0,42(a0)
	*copPtr++ = SPR4PTH;
     41c:	move.w #304,44(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     422:	move.w d1,46(a0)
	*copPtr++ = SPR4PTL;
     426:	move.w #306,48(a0)
	*copPtr++ = (LONG)NullSprite;
     42c:	move.w d0,50(a0)
	*copPtr++ = SPR5PTH;
     430:	move.w #308,52(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     436:	move.w d1,54(a0)
	*copPtr++ = SPR5PTL;
     43a:	move.w #310,56(a0)
	*copPtr++ = (LONG)NullSprite;
     440:	move.w d0,58(a0)
	*copPtr++ = SPR6PTH;
     444:	move.w #312,60(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     44a:	move.w d1,62(a0)
	*copPtr++ = SPR6PTL;
     44e:	move.w #314,64(a0)
	*copPtr++ = (LONG)NullSprite;
     454:	move.w d0,66(a0)
	*copPtr++ = SPR7PTH;
     458:	move.w #316,68(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     45e:	move.w d1,70(a0)
	*copPtr++ = SPR7PTL;
     462:	move.w #318,72(a0)
	*copPtr++ = (LONG)NullSprite;
     468:	move.w d0,74(a0)
	// enable bitplanes
	*copPtr++ = BPLCON0;
     46c:	move.w #256,76(a0)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     472:	moveq #0,d0
     474:	move.w 23f5c <BmpLogo+0x4>,d0
     47a:	add.l d0,d0
     47c:	moveq #12,d3
     47e:	lsl.l d3,d0
     480:	ori.w #1536,d0
     484:	move.w d0,78(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     488:	move.w #7173,80(a0)
    *copListEnd++ = COP_WAIT;
     48e:	move.w #-2,82(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     494:	move.w #384,84(a0)
    *copListCurrent++ = color;
     49a:	move.w #21,86(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     4a0:	move.w #398,88(a0)
    *copListCurrent++ = color;
     4a6:	move.w #21,90(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     4ac:	move.w #7429,92(a0)
    *copListEnd++ = COP_WAIT;
     4b2:	move.w #-2,94(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     4b8:	move.w #384,96(a0)
    *copListCurrent++ = color;
     4be:	move.w #22,98(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     4c4:	move.w #398,100(a0)
    *copListCurrent++ = color;
     4ca:	move.w #22,102(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     4d0:	move.w #7685,104(a0)
    *copListEnd++ = COP_WAIT;
     4d6:	move.w #-2,106(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     4dc:	move.w #384,108(a0)
    *copListCurrent++ = color;
     4e2:	move.w #22,110(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     4e8:	move.w #398,112(a0)
    *copListCurrent++ = color;
     4ee:	move.w #22,114(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     4f4:	move.w #7941,116(a0)
    *copListEnd++ = COP_WAIT;
     4fa:	move.w #-2,118(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     500:	move.w #384,120(a0)
    *copListCurrent++ = color;
     506:	move.w #22,122(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     50c:	move.w #398,124(a0)
    *copListCurrent++ = color;
     512:	move.w #22,126(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     518:	move.w #8197,128(a0)
    *copListEnd++ = COP_WAIT;
     51e:	move.w #-2,130(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     524:	move.w #384,132(a0)
    *copListCurrent++ = color;
     52a:	move.w #38,134(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     530:	move.w #398,136(a0)
    *copListCurrent++ = color;
     536:	move.w #38,138(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     53c:	move.w #8453,140(a0)
    *copListEnd++ = COP_WAIT;
     542:	move.w #-2,142(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     548:	move.w #384,144(a0)
    *copListCurrent++ = color;
     54e:	move.w #39,146(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     554:	move.w #398,148(a0)
    *copListCurrent++ = color;
     55a:	move.w #39,150(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     560:	move.w #8709,152(a0)
    *copListEnd++ = COP_WAIT;
     566:	move.w #-2,154(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     56c:	move.w #384,156(a0)
    *copListCurrent++ = color;
     572:	move.w #39,158(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     578:	move.w #398,160(a0)
    *copListCurrent++ = color;
     57e:	move.w #39,162(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     584:	move.w #8965,164(a0)
    *copListEnd++ = COP_WAIT;
     58a:	move.w #-2,166(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     590:	move.w #384,168(a0)
    *copListCurrent++ = color;
     596:	move.w #21,170(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     59c:	move.w #398,172(a0)
    *copListCurrent++ = color;
     5a2:	move.w #21,174(a0)
	copPtr = copSetColor(copPtr, 7, colgradbluePaletteRGB4[6]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[0]);
	copPtr = copSetColor(copPtr, 7, colgradbluePaletteRGB4[0]);
	// wait till below logo
	line = 0x2c + BmpUpperPart_PF1.Height;
     5a8:	move.b 23f29 <BmpUpperPart_PF1+0x3>,d0
     5ae:	addi.b #44,d0
	copPtr = copWaitY(copPtr, line++);
     5b2:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     5b8:	lsl.l #8,d0
     5ba:	ori.w #5,d0
     5be:	move.w d0,176(a0)
    *copListEnd++ = COP_WAIT;
     5c2:	move.w #-2,178(a0)
	// turn off bitplanes to waste 8 lines, giving the logo more bottom space
	*copPtr++ = BPLCON0;
     5c8:	move.w #256,180(a0)
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     5ce:	move.w #512,182(a0)
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
     5d4:	move.b 23f29 <BmpUpperPart_PF1+0x3>,d0
     5da:	addi.b #52,d0
	copPtr = copWaitY(copPtr, line++);
     5de:	move.b 23f29 <BmpUpperPart_PF1+0x3>,d1
     5e4:	addi.b #53,d1
     5e8:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     5ee:	lsl.l #8,d0
     5f0:	ori.w #5,d0
     5f4:	move.w d0,184(a0)
    *copListEnd++ = COP_WAIT;
     5f8:	lea 188(a0),a1
     5fc:	move.w #-2,186(a0)
	// set bitplane pointers
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     602:	move.l a1,23dea <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     608:	moveq #0,d5
     60a:	move.w 23e96 <BmpScroller+0x6>,d5
     610:	moveq #0,d4
     612:	move.w 23e94 <BmpScroller+0x4>,d4
     618:	move.l 23e9e <BmpScroller+0xe>,d2
    for (USHORT i = 0; i < numPlanes; i++)
     61e:	suba.l a0,a0
     620:	bra.s 646 <SetupCopper+0x438>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     622:	moveq #56,d3
     624:	add.l d3,d0
     626:	add.w d0,d0
     628:	add.w d0,d0
     62a:	move.w d0,(a1)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     62c:	move.l d2,d3
     62e:	clr.w d3
     630:	swap d3
     632:	move.w d3,2(a1)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     636:	addq.w #2,d0
     638:	move.w d0,4(a1)
        *copListEnd++ = (UWORD)addr; // high-word of adress
     63c:	move.w d2,6(a1)
        addr += Bpl;
     640:	add.l d5,d2
    for (USHORT i = 0; i < numPlanes; i++)
     642:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
     644:	addq.l #8,a1
    for (USHORT i = 0; i < numPlanes; i++)
     646:	moveq #0,d0
     648:	move.w a0,d0
     64a:	cmp.l d4,d0
     64c:	blt.s 622 <SetupCopper+0x414>
	//set modulo for scroller
	copPtr = copSetBplMod(0, copPtr,
						  BmpScroller.Bplt - Screen.Bpl,
						  BmpScroller.Bplt - Screen.Bpl);
     64e:	move.w 23e98 <BmpScroller+0x8>,d0
     654:	sub.w 23f90 <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     65a:	move.w #264,(a1)
    *copListEnd++ = modOdd;
     65e:	move.w d0,2(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     662:	move.w #266,4(a1)
    *copListEnd++ = modEven;
     668:	move.w d0,6(a1)
	*copPtr++ = BPLCON0;
     66c:	move.w #256,8(a1)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     672:	moveq #0,d0
     674:	move.w 23f5c <BmpLogo+0x4>,d0
     67a:	moveq #12,d2
     67c:	lsl.l d2,d0
     67e:	lea 12(a1),a0
     682:	ori.w #512,d0
     686:	move.w d0,10(a1)
	// set font colors for scroller
	for (int a = 1; a < 8; a++)
     68a:	moveq #1,d0
     68c:	bra.s 6ac <SetupCopper+0x49e>
	{
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     68e:	move.l d0,d2
     690:	add.l d0,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     692:	movea.w d0,a1
     694:	lea 192(a1),a1
     698:	adda.w a1,a1
     69a:	move.w a1,(a0)
    *copListCurrent++ = color;
     69c:	lea 461c <FontPaletteRGB4>,a1
     6a2:	move.w (0,a1,d2.l),2(a0)
	for (int a = 1; a < 8; a++)
     6a8:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     6aa:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     6ac:	moveq #7,d3
     6ae:	cmp.l d0,d3
     6b0:	bge.s 68e <SetupCopper+0x480>
	}
	// blue gradient below logo
	for (int l = 0; l < 24; l++)
     6b2:	moveq #0,d0
     6b4:	bra.s 6e4 <SetupCopper+0x4d6>
	{
		copPtr = copWaitY(copPtr, line);
     6b6:	moveq #0,d2
     6b8:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6ba:	lsl.l #8,d2
     6bc:	ori.w #5,d2
     6c0:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     6c2:	move.w #-2,2(a0)
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     6c8:	movea.l d0,a1
     6ca:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     6cc:	move.w #384,4(a0)
    *copListCurrent++ = color;
     6d2:	lea 464c <colgradbluePaletteRGB4>,a2
     6d8:	move.w (0,a2,a1.l),6(a0)
		line += 2;
     6de:	addq.b #2,d1
	for (int l = 0; l < 24; l++)
     6e0:	addq.l #1,d0
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     6e2:	addq.l #8,a0
	for (int l = 0; l < 24; l++)
     6e4:	moveq #23,d2
     6e6:	cmp.l d0,d2
     6e8:	bge.s 6b6 <SetupCopper+0x4a8>
	}
	copPtr = copWaitY(copPtr, line++);
     6ea:	move.b d1,d0
     6ec:	addq.b #1,d0
     6ee:	moveq #0,d2
     6f0:	move.b d1,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     6f2:	lsl.l #8,d2
     6f4:	ori.w #5,d2
     6f8:	move.w d2,(a0)
    *copListEnd++ = COP_WAIT;
     6fa:	move.w #-2,2(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
     700:	movea.w 66be <colScrollMirror>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     706:	move.w #384,4(a0)
    *copListCurrent++ = color;
     70c:	move.w a1,6(a0)
	copPtr = copWaitY(copPtr, line++);
     710:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     716:	lsl.l #8,d0
     718:	ori.w #5,d0
     71c:	move.w d0,8(a0)
    *copListEnd++ = COP_WAIT;
     720:	move.w #-2,10(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
     726:	move.w 66c0 <colScrollMirror+0x2>,d2
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     72c:	move.w #384,12(a0)
    *copListCurrent++ = color;
     732:	move.w d2,14(a0)
	line += 7;
     736:	move.b d1,d0
     738:	addi.b #9,d0
	copPtr = copWaitY(copPtr, line++);
     73c:	addi.b #10,d1
     740:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     746:	lsl.l #8,d0
     748:	ori.w #5,d0
     74c:	move.w d0,16(a0)
    *copListEnd++ = COP_WAIT;
     750:	move.w #-2,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     756:	move.w #384,20(a0)
    *copListCurrent++ = color;
     75c:	move.w a1,22(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
     760:	andi.l #255,d1
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     766:	lsl.l #8,d1
     768:	ori.w #5,d1
     76c:	move.w d1,24(a0)
    *copListEnd++ = COP_WAIT;
     770:	move.w #-2,26(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     776:	move.w #384,28(a0)
    *copListCurrent++ = color;
     77c:	move.w d2,30(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// set bitplane mods
	line = 0x2c + BmpLogo.Height + 72 + 7; // 209
     780:	move.b 23f5b <BmpLogo+0x3>,d0
     786:	addi.b #123,d0
	copPtr = copWaitY(copPtr, line++);
     78a:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     790:	lsl.l #8,d0
     792:	ori.w #5,d0
     796:	move.w d0,32(a0)
    *copListEnd++ = COP_WAIT;
     79a:	move.w #-2,34(a0)
	copMirrorBmpP = copPtr;
     7a0:	lea 36(a0),a2
     7a4:	move.l a2,23de0 <copMirrorBmpP>
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
     7aa:	move.w 23f60 <BmpLogo+0x8>,d0
     7b0:	sub.w 23f5e <BmpLogo+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     7b6:	move.w #264,36(a0)
    *copListEnd++ = modOdd;
     7bc:	move.w d0,38(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     7c0:	move.w #266,40(a0)
    *copListEnd++ = modEven;
     7c6:	move.w d0,42(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     7ca:	move.w #-31,44(a0)
    *copListEnd++ = COP_WAIT;
     7d0:	move.w #-2,46(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     7d6:	move.w #1285,48(a0)
    *copListEnd++ = COP_WAIT;
     7dc:	move.w #-2,50(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     7e2:	move.w #384,52(a0)
    *copListCurrent++ = color;
     7e8:	move.w a1,54(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     7ec:	move.w #1541,56(a0)
    *copListEnd++ = COP_WAIT;
     7f2:	move.w #-2,58(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     7f8:	move.w #384,60(a0)
    *copListCurrent++ = color;
     7fe:	move.w d2,62(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     802:	move.w #11269,64(a0)
    *copListEnd++ = COP_WAIT;
     808:	move.w #-2,66(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     80e:	move.w #384,68(a0)
    *copListCurrent++ = color;
     814:	move.w a1,70(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     818:	move.w #11525,72(a0)
    *copListEnd++ = COP_WAIT;
     81e:	move.w #-2,74(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     824:	move.w #384,76(a0)
    *copListCurrent++ = color;
     82a:	move.w d2,78(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     82e:	move.w #-1,80(a0)
    *copListEnd++ = COP_WAIT;
     834:	move.w #-2,82(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// copper end
	copPtr = copWaitXY(copPtr, 0xff, 0xff);
}
     83a:	movem.l (sp)+,d2-d5/a2
     83e:	rts

00000840 <EnableMirrorEffect>:

void EnableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2),
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
     840:	move.w 23e98 <BmpScroller+0x8>,d0
     846:	move.w d0,d1
     848:	sub.w 23f90 <Screen+0x6>,d1
     84e:	add.w d0,d0
     850:	sub.w d0,d1
	copSetBplMod(0, copMirrorBmpP,
     852:	movea.l 23de0 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     858:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     85c:	move.w d1,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     860:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     866:	move.w d1,6(a0)
}
     86a:	rts

0000086c <DisableMirrorEffect>:

void DisableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 BmpScroller.Bplt - Screen.Bpl,
				 BmpScroller.Bplt - Screen.Bpl);
     86c:	move.w 23e98 <BmpScroller+0x8>,d0
     872:	sub.w 23f90 <Screen+0x6>,d0
	copSetBplMod(0, copMirrorBmpP,
     878:	movea.l 23de0 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     87e:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     882:	move.w d0,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     886:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     88c:	move.w d0,6(a0)
}
     890:	rts

00000892 <PlotChar>:
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
	}
}

void PlotChar(BmpDescriptor bmpFont, BmpDescriptor bmpDest, USHORT plotY, USHORT charW, USHORT charH)
{
     892:	movem.l d2-d6/a2/a6,-(sp)
     896:	move.l 136(sp),d5
     89a:	move.l 140(sp),d3
     89e:	move.l 144(sp),d4
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     8a2:	move.w 23ddc <ScrolltextCnt>,d0
     8a8:	move.w d0,d1
     8aa:	addq.w #1,d1
     8ac:	move.w d1,23ddc <ScrolltextCnt>
     8b2:	andi.l #65535,d0
     8b8:	lea 401f <Scrolltext>,a0
     8be:	move.b (0,a0,d0.l),d0
	ULONG source, dest;
	ULONG row, col;

	// Set standard char distance
	NextPlot = 32;
     8c2:	move.w #32,66bc <NextPlot>
	// scroller commands: b=bounce; m=mirror; s=stop; c=color
	if (chr == 'b')
     8ca:	cmpi.b #98,d0
     8ce:	beq.w a22 <PlotChar+0x190>
		}
		BounceEnabled = !BounceEnabled;

		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'm')
     8d2:	cmpi.b #109,d0
     8d6:	beq.w a64 <PlotChar+0x1d2>
		}

		MirrorEnabled = !MirrorEnabled;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 's')
     8da:	cmpi.b #115,d0
     8de:	beq.w aac <PlotChar+0x21a>
	{
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'c')
     8e2:	cmpi.b #99,d0
     8e6:	beq.w b32 <PlotChar+0x2a0>
		colScrollMirror[0] = 0x6bf;
		colScrollMirror[1] = 0x49b;
		ResetCopper = TRUE;
	}
	// select character for different spacing
	if (chr == '!' || chr == 'I' || chr == '.' || chr == ',' || chr == ':' || chr == ';' || chr == '\'')
     8ea:	cmpi.b #33,d0
     8ee:	beq.s 914 <PlotChar+0x82>
     8f0:	cmpi.b #73,d0
     8f4:	beq.s 914 <PlotChar+0x82>
     8f6:	cmpi.b #46,d0
     8fa:	beq.s 914 <PlotChar+0x82>
     8fc:	cmpi.b #44,d0
     900:	beq.s 914 <PlotChar+0x82>
     902:	cmpi.b #58,d0
     906:	beq.s 914 <PlotChar+0x82>
     908:	cmpi.b #59,d0
     90c:	beq.s 914 <PlotChar+0x82>
     90e:	cmpi.b #39,d0
     912:	bne.s 91c <PlotChar+0x8a>
	{
		NextPlot = 12;
     914:	move.w #12,66bc <NextPlot>
	}
	if (chr == 'J')
     91c:	cmpi.b #74,d0
     920:	beq.w b4e <PlotChar+0x2bc>
	{
		NextPlot = 24;
	}
	// check for end of text
	if (chr == 0)
     924:	tst.b d0
     926:	bne.s 950 <PlotChar+0xbe>
	{
		ScrolltextCnt = 0;
     928:	clr.w 23ddc <ScrolltextCnt>
		chr = Scrolltext[ScrolltextCnt++];
     92e:	move.w #1,23ddc <ScrolltextCnt>
		colScrollMirror[0] = 0x111;
     936:	move.w #273,66be <colScrollMirror>
		colScrollMirror[1] = 0x222;
     93e:	move.w #546,66c0 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     946:	move.w #1,23df4 <ResetCopper>
		chr = Scrolltext[ScrolltextCnt++];
     94e:	moveq #32,d0
	}
	// check legal values
	if (chr < 32 || chr > (32 + 80))
     950:	addi.b #-32,d0
     954:	cmpi.b #80,d0
     958:	bhi.w a1c <PlotChar+0x18a>
		return;
	}
	// skip first 32 ascii codes
	chr -= 32;
	// get row and column of source bitmap (10 chrs per row)
	row = chr / 10;
     95c:	andi.w #255,d0
     960:	move.w d0,d6
     962:	mulu.w #-13107,d6
     966:	clr.w d6
     968:	swap d6
     96a:	lsr.w #3,d6
	col = chr % 10;
     96c:	move.w d6,d1
     96e:	add.w d6,d1
     970:	add.w d1,d1
     972:	add.w d6,d1
     974:	add.w d1,d1
     976:	sub.w d1,d0
     978:	moveq #0,d2
     97a:	move.b d0,d2
	// calc source bitplane pointer
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     97c:	moveq #0,d0
     97e:	move.w 40(sp),d0
     982:	lea 2480 <__mulsi3>,a2
     988:	moveq #31,d1
     98a:	and.l d6,d1
     98c:	move.l d1,-(sp)
     98e:	move.l d0,-(sp)
     990:	jsr (a2)
     992:	addq.l #8,sp
     994:	move.l d0,-(sp)
     996:	move.w d4,-(sp)
     998:	clr.w -(sp)
     99a:	jsr (a2)
     99c:	addq.l #8,sp
     99e:	add.l d2,d2
     9a0:	add.l d2,d2
     9a2:	add.l d0,d2
	// calc destination bitplane pointer
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     9a4:	moveq #0,d0
     9a6:	move.w 92(sp),d0
     9aa:	move.l d0,-(sp)
     9ac:	move.w d5,-(sp)
     9ae:	clr.w -(sp)
     9b0:	jsr (a2)
     9b2:	addq.l #8,sp
     9b4:	moveq #0,d5
     9b6:	move.w 23f90 <Screen+0x6>,d5
     9bc:	add.l d0,d5
	// wait for blitter and blit
	WaitBlit();
     9be:	movea.l 23fc0 <GfxBase>,a6
     9c4:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     9c8:	movea.l 23fca <custom>,a0
     9ce:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     9d4:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     9da:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     9e0:	move.w #-1,70(a0)
	custom->bltapt = ((UBYTE *)bmpFont.ImageData) + source;
     9e6:	add.l 46(sp),d2
     9ea:	move.l d2,80(a0)
	custom->bltdpt = ((UBYTE *)bmpDest.ImageData) + dest;
     9ee:	add.l 98(sp),d5
     9f2:	move.l d5,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     9f6:	move.w d3,d0
     9f8:	lsr.w #3,d0
     9fa:	move.w 38(sp),d1
     9fe:	sub.w d0,d1
     a00:	move.w d1,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     a04:	move.w 90(sp),d1
     a08:	sub.w d0,d1
     a0a:	move.w d1,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     a0e:	muls.w 36(sp),d4
     a12:	lsl.w #6,d4
     a14:	lsr.w #4,d3
     a16:	add.w d4,d3
     a18:	move.w d3,88(a0)
}
     a1c:	movem.l (sp)+,d2-d6/a2/a6
     a20:	rts
		if (BounceEnabled)
     a22:	move.w 23df2 <BounceEnabled>,d0
     a28:	beq.s a38 <PlotChar+0x1a6>
			ScrollerY = SCRT_MIN;
     a2a:	clr.w 23df0 <ScrollerY>
			ScrollerDir = 1;
     a30:	move.b #1,6702 <ScrollerDir>
		BounceEnabled = !BounceEnabled;
     a38:	tst.w d0
     a3a:	seq d0
     a3c:	ext.w d0
     a3e:	neg.w d0
     a40:	move.w d0,23df2 <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     a46:	move.w d1,d0
     a48:	addq.w #1,d0
     a4a:	move.w d0,23ddc <ScrolltextCnt>
     a50:	andi.l #65535,d1
     a56:	lea 401f <Scrolltext>,a0
     a5c:	move.b (0,a0,d1.l),d0
     a60:	bra.w 8d2 <PlotChar+0x40>
		if (MirrorEnabled)
     a64:	tst.w 23dda <MirrorEnabled>
     a6a:	beq.s aa6 <PlotChar+0x214>
			DisableMirrorEffect();
     a6c:	jsr 86c <DisableMirrorEffect>(pc)
		MirrorEnabled = !MirrorEnabled;
     a70:	tst.w 23dda <MirrorEnabled>
     a76:	seq d0
     a78:	ext.w d0
     a7a:	neg.w d0
     a7c:	move.w d0,23dda <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     a82:	move.w 23ddc <ScrolltextCnt>,d0
     a88:	move.w d0,d1
     a8a:	addq.w #1,d1
     a8c:	move.w d1,23ddc <ScrolltextCnt>
     a92:	andi.l #65535,d0
     a98:	lea 401f <Scrolltext>,a0
     a9e:	move.b (0,a0,d0.l),d0
     aa2:	bra.w 8da <PlotChar+0x48>
			EnableMirrorEffect();
     aa6:	jsr 840 <EnableMirrorEffect>(pc)
     aaa:	bra.s a70 <PlotChar+0x1de>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     aac:	tst.w 23df2 <BounceEnabled>
     ab2:	beq.s b04 <PlotChar+0x272>
     ab4:	move.w 23ddc <ScrolltextCnt>,d0
     aba:	move.w d0,d1
     abc:	addq.w #1,d1
     abe:	move.w d1,23ddc <ScrolltextCnt>
     ac4:	andi.l #65535,d0
     aca:	lea 401f <Scrolltext>,a0
     ad0:	move.b (0,a0,d0.l),d0
     ad4:	ext.w d0
     ad6:	addi.w #-48,d0
     ada:	move.w d0,23dee <ScrollerPause>
		chr = Scrolltext[ScrolltextCnt++];
     ae0:	move.w 23ddc <ScrolltextCnt>,d0
     ae6:	move.w d0,d1
     ae8:	addq.w #1,d1
     aea:	move.w d1,23ddc <ScrolltextCnt>
     af0:	andi.l #65535,d0
     af6:	lea 401f <Scrolltext>,a0
     afc:	move.b (0,a0,d0.l),d0
     b00:	bra.w 8e2 <PlotChar+0x50>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     b04:	move.w 23ddc <ScrolltextCnt>,d0
     b0a:	move.w d0,d1
     b0c:	addq.w #1,d1
     b0e:	move.w d1,23ddc <ScrolltextCnt>
     b14:	andi.l #65535,d0
     b1a:	lea 401f <Scrolltext>,a0
     b20:	move.b (0,a0,d0.l),d0
     b24:	ext.w d0
     b26:	movea.w d0,a0
     b28:	moveq #-48,d0
     b2a:	add.l a0,d0
     b2c:	muls.w #50,d0
     b30:	bra.s ada <PlotChar+0x248>
		colScrollMirror[0] = 0x6bf;
     b32:	move.w #1727,66be <colScrollMirror>
		colScrollMirror[1] = 0x49b;
     b3a:	move.w #1179,66c0 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     b42:	move.w #1,23df4 <ResetCopper>
     b4a:	bra.w 8ea <PlotChar+0x58>
		NextPlot = 24;
     b4e:	move.w #24,66bc <NextPlot>
     b56:	bra.w 924 <PlotChar+0x92>

00000b5a <Scrollit>:
{
     b5a:	movem.l d2-d7/a2/a6,-(sp)
     b5e:	move.l 96(sp),d3
     b62:	move.l 100(sp),d4
	int BltOffs = startY * theDesc.Bplt;
     b66:	moveq #0,d5
     b68:	move.w 94(sp),d5
     b6c:	moveq #0,d6
     b6e:	move.w 44(sp),d6
     b72:	lea 2480 <__mulsi3>,a2
     b78:	move.l d6,-(sp)
     b7a:	move.l d5,-(sp)
     b7c:	jsr (a2)
     b7e:	addq.l #8,sp
     b80:	move.l d0,d2
	int Brcorner = height * theDesc.Bplt - 2;
     b82:	move.l d6,-(sp)
     b84:	move.w d3,-(sp)
     b86:	clr.w -(sp)
     b88:	jsr (a2)
     b8a:	addq.l #8,sp
     b8c:	move.l d0,d7
     b8e:	subq.l #2,d7
	WaitBlit();
     b90:	movea.l 23fc0 <GfxBase>,a6
     b96:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     b9a:	clr.w d6
     b9c:	move.b d4,d6
     b9e:	moveq #12,d0
     ba0:	lsl.w d0,d4
     ba2:	movea.l 23fca <custom>,a0
     ba8:	addi.w #2544,d4
     bac:	move.w d4,64(a0)
	custom->bltcon1 = 0x0002;
     bb0:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     bb6:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     bbc:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     bc2:	move.l d2,d0
     bc4:	add.l d7,d0
     bc6:	add.l 88(sp),d0
     bca:	move.l d0,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     bce:	move.l d0,84(a0)
	custom->bltamod = 0;
     bd2:	move.w #0,100(a0)
	custom->bltdmod = 0;
     bd8:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
     bde:	move.w 40(sp),d0
     be2:	muls.w d3,d0
     be4:	lsl.w #6,d0
     be6:	move.w 23e90 <BmpScroller>,d1
     bec:	lsr.w #4,d1
     bee:	add.w d1,d0
     bf0:	move.w d0,88(a0)
	ScrollCnt += speed;
     bf4:	add.w 23dde <ScrollCnt>,d6
     bfa:	move.w d6,23dde <ScrollCnt>
	if (ScrollCnt >= NextPlot)
     c00:	cmp.w 66bc <NextPlot>,d6
     c06:	bcc.s c0e <Scrollit+0xb4>
}
     c08:	movem.l (sp)+,d2-d7/a2/a6
     c0c:	rts
		ScrollCnt = 0;
     c0e:	clr.w 23dde <ScrollCnt>
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
     c14:	pea 20 <_start+0x20>
     c18:	pea 20 <_start+0x20>
     c1c:	move.l d5,-(sp)
     c1e:	subq.l #2,sp
     c20:	move.l 23ebe <BmpScroller+0x2e>,-(sp)
     c26:	move.l 23eba <BmpScroller+0x2a>,-(sp)
     c2c:	move.l 23eb6 <BmpScroller+0x26>,-(sp)
     c32:	move.l 23eb2 <BmpScroller+0x22>,-(sp)
     c38:	move.l 23eae <BmpScroller+0x1e>,-(sp)
     c3e:	move.l 23eaa <BmpScroller+0x1a>,-(sp)
     c44:	move.l 23ea6 <BmpScroller+0x16>,-(sp)
     c4a:	move.l 23ea2 <BmpScroller+0x12>,-(sp)
     c50:	move.l 23e9e <BmpScroller+0xe>,-(sp)
     c56:	move.l 23e9a <BmpScroller+0xa>,-(sp)
     c5c:	move.l 23e96 <BmpScroller+0x6>,-(sp)
     c62:	move.l 23e92 <BmpScroller+0x2>,-(sp)
     c68:	move.w 23e90 <BmpScroller>,-(sp)
     c6e:	subq.l #2,sp
     c70:	move.l 23e8c <BmpFont32+0x2e>,-(sp)
     c76:	move.l 23e88 <BmpFont32+0x2a>,-(sp)
     c7c:	move.l 23e84 <BmpFont32+0x26>,-(sp)
     c82:	move.l 23e80 <BmpFont32+0x22>,-(sp)
     c88:	move.l 23e7c <BmpFont32+0x1e>,-(sp)
     c8e:	move.l 23e78 <BmpFont32+0x1a>,-(sp)
     c94:	move.l 23e74 <BmpFont32+0x16>,-(sp)
     c9a:	move.l 23e70 <BmpFont32+0x12>,-(sp)
     ca0:	move.l 23e6c <BmpFont32+0xe>,-(sp)
     ca6:	move.l 23e68 <BmpFont32+0xa>,-(sp)
     cac:	move.l 23e64 <BmpFont32+0x6>,-(sp)
     cb2:	move.l 23e60 <BmpFont32+0x2>,-(sp)
     cb8:	move.w 23e5e <BmpFont32>,-(sp)
     cbe:	jsr 892 <PlotChar>(pc)
     cc2:	lea 116(sp),sp
     cc6:	bra.w c08 <Scrollit+0xae>

00000cca <GetVBR>:

static APTR GetVBR()
{
     cca:	subq.l #8,sp
     ccc:	move.l a6,-(sp)
     cce:	move.l d7,-(sp)
	APTR vbr = 0;
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     cd0:	move.w #20090,10(sp)
     cd6:	move.w #2049,12(sp)
     cdc:	move.w #20083,14(sp)

	if (SysBase->AttnFlags & AFF_68010)
     ce2:	movea.l 23fc4 <SysBase>,a6
     ce8:	btst #0,297(a6)
     cee:	beq.s d04 <GetVBR+0x3a>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     cf0:	moveq #10,d7
     cf2:	add.l sp,d7
     cf4:	exg d7,a5
     cf6:	jsr -30(a6)
     cfa:	exg d7,a5

	return vbr;
}
     cfc:	move.l (sp)+,d7
     cfe:	movea.l (sp)+,a6
     d00:	addq.l #8,sp
     d02:	rts
	APTR vbr = 0;
     d04:	moveq #0,d0
	return vbr;
     d06:	bra.s cfc <GetVBR+0x32>

00000d08 <SetInterruptHandler>:

void SetInterruptHandler(APTR interrupt)
{
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     d08:	movea.l 23dd6 <VBR>,a0
     d0e:	move.l 4(sp),108(a0)
}
     d14:	rts

00000d16 <GetInterruptHandler>:

APTR GetInterruptHandler()
{
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     d16:	movea.l 23dd6 <VBR>,a0
     d1c:	move.l 108(a0),d0
}
     d20:	rts

00000d22 <WaitVbl>:

//vblank begins at vpos 312 hpos 1 and ends at vpos 25 hpos 1
//vsync begins at line 2 hpos 132 and ends at vpos 5 hpos 18
void WaitVbl()
{
     d22:	subq.l #8,sp
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     d24:	move.l dff004 <_end+0xddb034>,d0
     d2a:	move.l d0,(sp)
		vpos &= 0x1ff00;
     d2c:	move.l (sp),d0
     d2e:	andi.l #130816,d0
     d34:	move.l d0,(sp)
		if (vpos != (311 << 8))
     d36:	move.l (sp),d0
     d38:	cmpi.l #79616,d0
     d3e:	beq.s d24 <WaitVbl+0x2>
			break;
	}
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     d40:	move.l dff004 <_end+0xddb034>,d0
     d46:	move.l d0,4(sp)
		vpos &= 0x1ff00;
     d4a:	move.l 4(sp),d0
     d4e:	andi.l #130816,d0
     d54:	move.l d0,4(sp)
		if (vpos == (311 << 8))
     d58:	move.l 4(sp),d0
     d5c:	cmpi.l #79616,d0
     d62:	bne.s d40 <WaitVbl+0x1e>
			break;
	}
}
     d64:	addq.l #8,sp
     d66:	rts

00000d68 <TakeSystem>:
	{
	} //blitter busy wait
}

void TakeSystem()
{
     d68:	move.l a6,-(sp)
     d6a:	move.l a2,-(sp)
	ActiView = GfxBase->ActiView; //store current view
     d6c:	movea.l 23fc0 <GfxBase>,a6
     d72:	move.l 34(a6),23dd2 <ActiView>
	OwnBlitter();
     d7a:	jsr -456(a6)
	WaitBlit();
     d7e:	movea.l 23fc0 <GfxBase>,a6
     d84:	jsr -228(a6)
	Disable();
     d88:	movea.l 23fc4 <SysBase>,a6
     d8e:	jsr -120(a6)

	//Save current interrupts and DMA settings so we can restore them upon exit.
	SystemADKCON = custom->adkconr;
     d92:	movea.l 23fca <custom>,a0
     d98:	move.w 16(a0),d0
     d9c:	move.w d0,23dd0 <SystemADKCON>
	SystemInts = custom->intenar;
     da2:	move.w 28(a0),d0
     da6:	move.w d0,23dce <SystemInts>
	SystemDMA = custom->dmaconr;
     dac:	move.w 2(a0),d0
     db0:	move.w d0,23dcc <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     db6:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     dbc:	move.w #32767,156(a0)

	WaitVbl();
     dc2:	lea d22 <WaitVbl>(pc),a2
     dc6:	jsr (a2)
	WaitVbl();
     dc8:	jsr (a2)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     dca:	movea.l 23fca <custom>,a0
     dd0:	move.w #32767,150(a0)

	//set all colors black
	for (int a = 0; a < 32; a++)
     dd6:	moveq #0,d1
     dd8:	bra.s dec <TakeSystem+0x84>
		custom->color[a] = 0;
     dda:	move.l d1,d0
     ddc:	addi.l #192,d0
     de2:	add.l d0,d0
     de4:	move.w #0,(0,a0,d0.l)
	for (int a = 0; a < 32; a++)
     dea:	addq.l #1,d1
     dec:	moveq #31,d0
     dee:	cmp.l d1,d0
     df0:	bge.s dda <TakeSystem+0x72>

	LoadView(0);
     df2:	movea.l 23fc0 <GfxBase>,a6
     df8:	suba.l a1,a1
     dfa:	jsr -222(a6)
	WaitTOF();
     dfe:	movea.l 23fc0 <GfxBase>,a6
     e04:	jsr -270(a6)
	WaitTOF();
     e08:	movea.l 23fc0 <GfxBase>,a6
     e0e:	jsr -270(a6)

	WaitVbl();
     e12:	lea d22 <WaitVbl>(pc),a2
     e16:	jsr (a2)
	WaitVbl();
     e18:	jsr (a2)

	VBR = GetVBR();
     e1a:	jsr cca <GetVBR>(pc)
     e1e:	move.l d0,23dd6 <VBR>
	SystemIrq = GetInterruptHandler(); //store interrupt register
     e24:	jsr d16 <GetInterruptHandler>(pc)
     e28:	move.l d0,23dc8 <SystemIrq>
}
     e2e:	movea.l (sp)+,a2
     e30:	movea.l (sp)+,a6
     e32:	rts

00000e34 <FreeSystem>:

void FreeSystem()
{
     e34:	move.l a6,-(sp)
	WaitVbl();
     e36:	jsr d22 <WaitVbl>(pc)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     e3a:	movea.l 23fca <custom>,a0
     e40:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     e44:	move.w 2(a0),d0
     e48:	btst #14,d0
     e4c:	bne.s e44 <FreeSystem+0x10>
	WaitBlt();
	custom->intena = 0x7fff; //disable all interrupts
     e4e:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     e54:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     e5a:	move.w #32767,150(a0)

	//restore interrupts
	SetInterruptHandler(SystemIrq);
     e60:	move.l 23dc8 <SystemIrq>,-(sp)
     e66:	jsr d08 <SetInterruptHandler>(pc)

	/*Restore system copper list(s). */
	custom->cop1lc = (ULONG)GfxBase->copinit;
     e6a:	movea.l 23fc0 <GfxBase>,a6
     e70:	movea.l 23fca <custom>,a0
     e76:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     e7c:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     e82:	move.w #32767,136(a0)

	/*Restore all interrupts and DMA settings. */
	custom->intena = SystemInts | 0x8000;
     e88:	move.w 23dce <SystemInts>,d0
     e8e:	ori.w #-32768,d0
     e92:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     e96:	move.w 23dcc <SystemDMA>,d0
     e9c:	ori.w #-32768,d0
     ea0:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     ea4:	move.w 23dd0 <SystemADKCON>,d0
     eaa:	ori.w #-32768,d0
     eae:	move.w d0,158(a0)

	LoadView(ActiView);
     eb2:	movea.l 23dd2 <ActiView>,a1
     eb8:	jsr -222(a6)
	WaitTOF();
     ebc:	movea.l 23fc0 <GfxBase>,a6
     ec2:	jsr -270(a6)
	WaitTOF();
     ec6:	movea.l 23fc0 <GfxBase>,a6
     ecc:	jsr -270(a6)
	WaitBlit();
     ed0:	movea.l 23fc0 <GfxBase>,a6
     ed6:	jsr -228(a6)
	DisownBlitter();
     eda:	movea.l 23fc0 <GfxBase>,a6
     ee0:	jsr -462(a6)
	Enable();
     ee4:	movea.l 23fc4 <SysBase>,a6
     eea:	jsr -126(a6)
     eee:	addq.l #4,sp
}
     ef0:	movea.l (sp)+,a6
     ef2:	rts

00000ef4 <InitImagePlanes>:

void InitImagePlanes(BmpDescriptor *img)
{
     ef4:	movem.l d2-d3/a2,-(sp)
     ef8:	movea.l 16(sp),a2
	for (int p = 0; p < img->Bpls; p++)
     efc:	moveq #0,d2
     efe:	bra.s f24 <InitImagePlanes+0x30>
	{
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
     f00:	move.l 14(a2),d3
     f04:	moveq #0,d0
     f06:	move.w 6(a2),d0
     f0a:	move.l d2,-(sp)
     f0c:	move.l d0,-(sp)
     f0e:	jsr 2480 <__mulsi3>
     f14:	addq.l #8,sp
     f16:	move.l d2,d1
     f18:	add.l d2,d1
     f1a:	add.l d1,d1
     f1c:	add.l d0,d3
     f1e:	move.l d3,(18,a2,d1.l)
	for (int p = 0; p < img->Bpls; p++)
     f22:	addq.l #1,d2
     f24:	moveq #0,d0
     f26:	move.w 4(a2),d0
     f2a:	cmp.l d0,d2
     f2c:	blt.s f00 <InitImagePlanes+0xc>
	}
}
     f2e:	movem.l (sp)+,d2-d3/a2
     f32:	rts

00000f34 <CopyBitmap>:
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     f34:	movea.l 23fca <custom>,a0
     f3a:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     f3e:	move.w 2(a0),d0
     f42:	btst #14,d0
     f46:	bne.s f3e <CopyBitmap+0xa>

void CopyBitmap(BmpDescriptor bmpS, BmpDescriptor bmpD)
{
	WaitBlt();

	custom->bltcon0 = 0x09f0;
     f48:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     f4e:	move.w #0,66(a0)
	custom->bltapt = (UBYTE *)bmpS.ImageData;
     f54:	move.l 18(sp),80(a0)
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
     f5a:	move.l 70(sp),84(a0)
	custom->bltafwm = 0xffff;
     f60:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     f66:	move.w #-1,70(a0)
	custom->bltamod = 0;
     f6c:	move.w #0,100(a0)
	custom->bltdmod = 0;
     f72:	move.w #0,102(a0)
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
     f78:	move.w 6(sp),d1
     f7c:	muls.w 8(sp),d1
     f80:	lsl.w #6,d1
     f82:	move.w 10(sp),d0
     f86:	lsr.w #1,d0
     f88:	add.w d1,d0
     f8a:	move.w d0,88(a0)
}
     f8e:	rts

00000f90 <ClearBitmapPart>:
	custom->bltdmod = 0;
	custom->bltsize = ((lines * bmpD.Bpls) << 6) + (bmpD.Width / 16);
}

void ClearBitmapPart(BmpDescriptor bmp, int x, int y, int height, int width)
{
     f90:	movem.l d2-d5/a2-a3,-(sp)
     f94:	move.l 80(sp),d5
     f98:	movea.l 92(sp),a3
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     f9c:	movea.l 23fca <custom>,a2
     fa2:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     fa6:	move.w 2(a2),d0
     faa:	btst #14,d0
     fae:	bne.s fa6 <ClearBitmapPart+0x16>
	WaitBlt();
	BYTE shift = x % 16;
     fb0:	move.l d5,d2
     fb2:	andi.l #-2147483633,d2
     fb8:	tst.l d5
     fba:	blt.w 1056 <ClearBitmapPart+0xc6>
	if (shift)
     fbe:	tst.b d2
     fc0:	beq.s fc6 <ClearBitmapPart+0x36>
		width += 16;
     fc2:	lea 16(a3),a3
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
     fc6:	move.b d2,d0
     fc8:	ext.w d0
     fca:	move.w d0,d4
     fcc:	ext.l d4
     fce:	move.l d4,d1
     fd0:	moveq #12,d3
     fd2:	lsl.l d3,d1
     fd4:	ori.w #2304,d1
     fd8:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
     fdc:	moveq #12,d1
     fde:	lsl.w d1,d0
     fe0:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
     fe4:	move.l 42(sp),d3
     fe8:	moveq #0,d0
     fea:	move.w 36(sp),d0
     fee:	move.l 84(sp),-(sp)
     ff2:	move.l d0,-(sp)
     ff4:	jsr 2480 <__mulsi3>
     ffa:	addq.l #8,sp
     ffc:	move.l d5,d1
     ffe:	bmi.s 1062 <ClearBitmapPart+0xd2>
    1000:	asr.l #3,d1
    1002:	add.l d1,d0
    1004:	add.l d3,d0
    1006:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    100a:	move.l d0,84(a2)
	custom->bltafwm = 0xffff;
    100e:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1014:	tst.b d2
    1016:	beq.s 1066 <ClearBitmapPart+0xd6>
    1018:	moveq #15,d1
    101a:	sub.l d4,d1
    101c:	moveq #0,d0
    101e:	not.w d0
    1020:	asr.l d1,d0
    1022:	move.w d0,70(a2)
	;
	custom->bltamod = bmp.Bpl - (width / 8);
    1026:	move.w 34(sp),d0
    102a:	move.l a3,d1
    102c:	bmi.s 106a <ClearBitmapPart+0xda>
    102e:	asr.l #3,d1
    1030:	sub.w d1,d0
    1032:	move.w d0,100(a2)
	custom->bltdmod = bmp.Bpl - (width / 8);
    1036:	move.w d0,102(a2)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    103a:	move.w 32(sp),d0
    103e:	muls.w 90(sp),d0
    1042:	lsl.w #6,d0
    1044:	move.l a3,d1
    1046:	bmi.s 106e <ClearBitmapPart+0xde>
    1048:	asr.l #4,d1
    104a:	add.w d1,d0
    104c:	move.w d0,88(a2)
}
    1050:	movem.l (sp)+,d2-d5/a2-a3
    1054:	rts
	BYTE shift = x % 16;
    1056:	subq.l #1,d2
    1058:	moveq #-16,d0
    105a:	or.l d0,d2
    105c:	addq.l #1,d2
    105e:	bra.w fbe <ClearBitmapPart+0x2e>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1062:	addq.l #7,d1
    1064:	bra.s 1000 <ClearBitmapPart+0x70>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1066:	moveq #-1,d0
    1068:	bra.s 1022 <ClearBitmapPart+0x92>
	custom->bltamod = bmp.Bpl - (width / 8);
    106a:	addq.l #7,d1
    106c:	bra.s 102e <ClearBitmapPart+0x9e>
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    106e:	moveq #15,d1
    1070:	add.l a3,d1
    1072:	bra.s 1048 <ClearBitmapPart+0xb8>

00001074 <SimpleBlit>:

void SimpleBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    1074:	movem.l d2-d7/a2,-(sp)
    1078:	move.l 136(sp),d7
    107c:	move.l 140(sp),d1
    1080:	move.l 144(sp),d4
    1084:	move.l 148(sp),d5
    1088:	move.l 152(sp),d3
    108c:	move.l 156(sp),d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1090:	movea.l 23fca <custom>,a2
    1096:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    109a:	move.w 2(a2),d0
    109e:	btst #14,d0
    10a2:	bne.s 109a <SimpleBlit+0x26>
	WaitBlt();
	custom->bltcon0 = 0x09f0;
    10a4:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
    10aa:	move.w #0,66(a2)
	custom->bltafwm = 0xffff;
    10b0:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    10b6:	move.w #-1,70(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
    10bc:	move.w d2,d0
    10be:	lsr.w #3,d0
    10c0:	movea.w 38(sp),a0
    10c4:	suba.w d0,a0
    10c6:	move.w a0,100(a2)
	custom->bltdmod = imgD.Bpl - (width / 8);
    10ca:	movea.w 90(sp),a0
    10ce:	suba.w d0,a0
    10d0:	move.w a0,102(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    10d4:	move.l 46(sp),d6
    10d8:	moveq #0,d0
    10da:	move.w 40(sp),d0
    10de:	move.l d0,-(sp)
    10e0:	move.l d1,-(sp)
    10e2:	jsr 2480 <__mulsi3>
    10e8:	addq.l #8,sp
    10ea:	move.l d7,d1
    10ec:	bmi.s 1130 <SimpleBlit+0xbc>
    10ee:	asr.l #3,d1
    10f0:	add.l d1,d0
    10f2:	add.l d6,d0
    10f4:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    10f8:	move.l 98(sp),d6
    10fc:	moveq #0,d0
    10fe:	move.w 92(sp),d0
    1102:	move.l d0,-(sp)
    1104:	move.l d5,-(sp)
    1106:	jsr 2480 <__mulsi3>
    110c:	addq.l #8,sp
    110e:	move.l d4,d1
    1110:	bmi.s 1134 <SimpleBlit+0xc0>
    1112:	asr.l #3,d1
    1114:	add.l d1,d0
    1116:	add.l d6,d0
    1118:	move.l d0,84(a2)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
    111c:	muls.w 36(sp),d3
    1120:	lsl.w #6,d3
    1122:	lsr.w #4,d2
    1124:	add.w d3,d2
    1126:	move.w d2,88(a2)
}
    112a:	movem.l (sp)+,d2-d7/a2
    112e:	rts
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1130:	addq.l #7,d1
    1132:	bra.s 10ee <SimpleBlit+0x7a>
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1134:	addq.l #7,d1
    1136:	bra.s 1112 <SimpleBlit+0x9e>

00001138 <BetterBlit>:

void BetterBlit(BmpDescriptor imgS, BmpDescriptor imgD, BmpDescriptor imgM, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    1138:	movem.l d2-d7/a2-a6,-(sp)
    113c:	movea.l 204(sp),a3
    1140:	move.l 208(sp),d7
    1144:	move.l 212(sp),d5
    1148:	movea.l 216(sp),a5
    114c:	movea.l 220(sp),a4
    1150:	move.l 224(sp),d1
    1154:	move.w d1,d4
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1156:	movea.l 23fca <custom>,a2
    115c:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1160:	move.w 2(a2),d0
    1164:	btst #14,d0
    1168:	bne.s 1160 <BetterBlit+0x28>
	WaitBlt();
	BYTE shift = startD.X % 16;
    116a:	move.l d5,d3
    116c:	andi.l #-2147483633,d3
    1172:	tst.l d5
    1174:	blt.w 1268 <BetterBlit+0x130>
	if (shift)
    1178:	tst.b d3
    117a:	beq.s 1182 <BetterBlit+0x4a>
		width += 16;
    117c:	move.w d1,d4
    117e:	addi.w #16,d4

	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1182:	move.b d3,d0
    1184:	ext.w d0
    1186:	movea.w d0,a6
    1188:	move.l a6,d1
    118a:	moveq #12,d2
    118c:	lsl.l d2,d1
    118e:	ori.w #4042,d1
    1192:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1196:	moveq #12,d1
    1198:	lsl.w d1,d0
    119a:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    119e:	move.l 62(sp),d6
    11a2:	moveq #0,d0
    11a4:	move.w 56(sp),d0
    11a8:	move.l d0,-(sp)
    11aa:	move.l d7,-(sp)
    11ac:	jsr 2480 <__mulsi3>
    11b2:	addq.l #8,sp
    11b4:	move.l a3,d2
    11b6:	bmi.w 1274 <BetterBlit+0x13c>
    11ba:	asr.l #3,d2
    11bc:	add.l d2,d0
    11be:	add.l d6,d0
    11c0:	move.l d0,80(a2)
	custom->bltamod = imgS.Bpl - (width / 8);
    11c4:	move.w d4,d6
    11c6:	lsr.w #3,d6
    11c8:	move.w 54(sp),d0
    11cc:	sub.w d6,d0
    11ce:	move.w d0,100(a2)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    11d2:	moveq #0,d0
    11d4:	move.w 160(sp),d0
    11d8:	lea 2480 <__mulsi3>,a3
    11de:	move.l d0,-(sp)
    11e0:	move.l d7,-(sp)
    11e2:	jsr (a3)
    11e4:	addq.l #8,sp
    11e6:	add.l d0,d2
    11e8:	add.l 166(sp),d2
    11ec:	move.l d2,76(a2)
	custom->bltbmod = imgM.Bpl - (width / 8);
    11f0:	move.w 158(sp),d0
    11f4:	sub.w d6,d0
    11f6:	move.w d0,98(a2)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    11fa:	move.l 114(sp),d2
    11fe:	moveq #0,d0
    1200:	move.w 108(sp),d0
    1204:	move.l d0,-(sp)
    1206:	move.l a5,-(sp)
    1208:	jsr (a3)
    120a:	addq.l #8,sp
    120c:	move.l d5,d1
    120e:	bmi.s 127a <BetterBlit+0x142>
    1210:	asr.l #3,d1
    1212:	add.l d1,d0
    1214:	add.l d2,d0
    1216:	move.l d0,84(a2)
    121a:	move.l d0,72(a2)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    121e:	move.w 106(sp),d0
    1222:	sub.w d6,d0
    1224:	move.w d0,102(a2)
    1228:	move.w d0,96(a2)
	custom->bltafwm = 0xffff;
    122c:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1232:	tst.b d3
    1234:	beq.s 127e <BetterBlit+0x146>
    1236:	moveq #15,d1
    1238:	sub.l a6,d1
    123a:	moveq #0,d0
    123c:	not.w d0
    123e:	asr.l d1,d0
    1240:	move.w d0,70(a2)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1244:	moveq #0,d0
    1246:	move.w 52(sp),d0
    124a:	move.l d0,-(sp)
    124c:	move.w a4,-(sp)
    124e:	clr.w -(sp)
    1250:	jsr 2480 <__mulsi3>
    1256:	addq.l #8,sp
    1258:	lsl.l #6,d0
    125a:	lsr.w #4,d4
    125c:	or.w d0,d4
    125e:	move.w d4,88(a2)
}
    1262:	movem.l (sp)+,d2-d7/a2-a6
    1266:	rts
	BYTE shift = startD.X % 16;
    1268:	subq.l #1,d3
    126a:	moveq #-16,d0
    126c:	or.l d0,d3
    126e:	addq.l #1,d3
    1270:	bra.w 1178 <BetterBlit+0x40>
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1274:	addq.l #7,d2
    1276:	bra.w 11ba <BetterBlit+0x82>
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    127a:	addq.l #7,d1
    127c:	bra.s 1210 <BetterBlit+0xd8>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    127e:	moveq #-1,d0
    1280:	bra.s 1240 <BetterBlit+0x108>

00001282 <p61Init>:

int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
    1282:	move.l a3,-(sp)
    1284:	move.l a2,-(sp)
	register volatile const void *_a0 ASM("a0") = module;
    1286:	movea.l 12(sp),a0
	register volatile const void *_a1 ASM("a1") = NULL;
    128a:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
    128c:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
    128e:	lea 265e <incbin_P61_Player_start>,a3
	register int _d0 ASM("d0"); // return value
	__asm volatile(
    1294:	movem.l d1-d7/a4-a6,-(sp)
    1298:	jsr (a3)
    129a:	movem.l (sp)+,d1-d7/a4-a6
		"movem.l (%%sp)+,%%d1-%%d7/%%a4-%%a6"
		: "=r"(_d0), "+rf"(_a0), "+rf"(_a1), "+rf"(_a2), "+rf"(_a3)
		:
		: "cc", "memory");
	return _d0;
}
    129e:	movea.l (sp)+,a2
    12a0:	movea.l (sp)+,a3
    12a2:	rts

000012a4 <p61Music>:

void p61Music()
{
    12a4:	move.l a6,-(sp)
    12a6:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    12a8:	lea 265e <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    12ae:	movea.l #14675968,a6
	__asm volatile(
    12b4:	movem.l d0-a2/a4-a5,-(sp)
    12b8:	jsr 4(a3)
    12bc:	movem.l (sp)+,d0-a2/a4-a5
		"jsr 4(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d7/%%a0-%%a2/%%a4-%%a5"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    12c0:	movea.l (sp)+,a3
    12c2:	movea.l (sp)+,a6
    12c4:	rts

000012c6 <interruptHandler>:
int p61Init(const void *module);
void p61Music(void);
void p61End(void);
// interrupt handler
static __attribute__((interrupt)) void interruptHandler()
{
    12c6:	movem.l d0-d1/a0-a1,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    12ca:	movea.l 23fca <custom>,a0
    12d0:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    12d6:	move.w #32,156(a0)

    // DEMO - ThePlayer
    p61Music();
    12dc:	jsr 12a4 <p61Music>(pc)

    // DEMO - increment frameCounter
    frameCounter++;
    12e0:	move.w 23fc8 <frameCounter>,d0
    12e6:	addq.w #1,d0
    12e8:	move.w d0,23fc8 <frameCounter>
}
    12ee:	movem.l (sp)+,d0-d1/a0-a1
    12f2:	rte

000012f4 <p61End>:

void p61End()
{
    12f4:	move.l a6,-(sp)
    12f6:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    12f8:	lea 265e <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    12fe:	movea.l #14675968,a6
	__asm volatile(
    1304:	movem.l d0-d1/a0-a1,-(sp)
    1308:	jsr 8(a3)
    130c:	movem.l (sp)+,d0-d1/a0-a1
		"jsr 8(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d1/%%a0-%%a1"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    1310:	movea.l (sp)+,a3
    1312:	movea.l (sp)+,a6
    1314:	rts

00001316 <BitmapInit>:

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{
    1316:	move.l d3,-(sp)
    1318:	move.l d2,-(sp)
    131a:	movea.l 12(sp),a0
    131e:	move.l 16(sp),d0
    1322:	move.l 20(sp),d2
    1326:	move.l 24(sp),d1

	bmp->Width = w;
    132a:	move.w d0,(a0)
	bmp->Height = h;
    132c:	move.w d2,2(a0)
	bmp->Bpls = bpls;
    1330:	move.w d1,4(a0)
	bmp->Bpl = w / 8;
    1334:	lsr.w #3,d0
    1336:	move.w d0,6(a0)
	bmp->Bplt = w / 8 * bpls;
    133a:	move.w d0,d3
    133c:	muls.w d1,d3
    133e:	move.w d3,8(a0)
	bmp->Btot = w / 8 * h * bpls;
    1342:	muls.w d2,d0
    1344:	muls.w d1,d0
    1346:	move.w d0,12(a0)
}
    134a:	move.l (sp)+,d2
    134c:	move.l (sp)+,d3
    134e:	rts

00001350 <InitStarfieldSprite>:

void InitStarfieldSprite()
{
    1350:	movem.l d2-d7/a2-a3,-(sp)
	short line = 0;
	USHORT hpos = 3;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 31; l++)
    1354:	moveq #0,d5
	BYTE vpos = 0x2c;
    1356:	moveq #44,d3
	USHORT hpos = 3;
    1358:	movea.w #3,a1
	short line = 0;
    135c:	clr.w d2
    135e:	bra.w 1498 <InitStarfieldSprite+0x148>
	{
		hpos = (7 * hpos) % 255;
    1362:	moveq #0,d0
    1364:	move.w a1,d0
    1366:	move.l d0,d1
    1368:	lsl.l #3,d1
    136a:	lea 2528 <__modsi3>,a3
    1370:	pea ff <MoveBobs+0x8b>
    1374:	sub.l d0,d1
    1376:	move.l d1,-(sp)
    1378:	jsr (a3)
    137a:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    137c:	move.b d3,d1
    137e:	ext.w d1
    1380:	move.w d1,d4
    1382:	ext.l d4
    1384:	lsl.l #8,d4
    1386:	move.w d0,d6
    1388:	andi.w #255,d6
    138c:	movea.w d2,a0
    138e:	addq.w #1,a0
    1390:	movea.w d2,a1
    1392:	lea 23adc <StarSprite>,a2
    1398:	adda.l a1,a1
    139a:	or.w d4,d6
    139c:	move.w d6,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    13a0:	addq.w #1,d1
    13a2:	movea.w d2,a1
    13a4:	addq.w #2,a1
    13a6:	movea.w a0,a0
    13a8:	lsl.w #8,d1
    13aa:	adda.l a0,a0
    13ac:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-1
    13b0:	movea.w d2,a0
    13b2:	addq.w #3,a0
    13b4:	movea.w a1,a1
    13b6:	adda.l a1,a1
    13b8:	move.w #-32768,(0,a1,a2.l)
		StarSprite[line++] = 0x0000;					  //color-1
    13be:	move.w d2,d6
    13c0:	addq.w #4,d6
    13c2:	movea.w a0,a0
    13c4:	adda.l a0,a0
    13c6:	clr.w (0,a0,a2.l)
		vpos += 2;
    13ca:	move.b d3,d4
    13cc:	addq.b #2,d4

		hpos = (7 * hpos) % 255;
    13ce:	andi.l #65535,d0
    13d4:	move.l d0,d1
    13d6:	lsl.l #3,d1
    13d8:	pea ff <MoveBobs+0x8b>
    13dc:	sub.l d0,d1
    13de:	move.l d1,-(sp)
    13e0:	jsr (a3)
    13e2:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    13e4:	move.b d4,d1
    13e6:	ext.w d1
    13e8:	move.w d1,d4
    13ea:	ext.l d4
    13ec:	lsl.l #8,d4
    13ee:	move.w d0,d7
    13f0:	andi.w #255,d7
    13f4:	movea.w d2,a0
    13f6:	addq.w #5,a0
    13f8:	movea.w d6,a1
    13fa:	adda.l a1,a1
    13fc:	or.w d4,d7
    13fe:	move.w d7,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    1402:	addq.w #1,d1
    1404:	movea.w d2,a1
    1406:	addq.w #6,a1
    1408:	movea.w a0,a0
    140a:	lsl.w #8,d1
    140c:	adda.l a0,a0
    140e:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x0000;					  //color-2
    1412:	movea.w d2,a0
    1414:	addq.w #7,a0
    1416:	movea.w a1,a1
    1418:	adda.l a1,a1
    141a:	clr.w (0,a1,a2.l)
		StarSprite[line++] = 0x8000;					  //color-2
    141e:	addq.w #4,d6
    1420:	movea.w a0,a0
    1422:	adda.l a0,a0
    1424:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    142a:	move.b d3,d4
    142c:	addq.b #4,d4

		hpos = (7 * hpos) % 255;
    142e:	andi.l #65535,d0
    1434:	move.l d0,d1
    1436:	lsl.l #3,d1
    1438:	pea ff <MoveBobs+0x8b>
    143c:	sub.l d0,d1
    143e:	move.l d1,-(sp)
    1440:	jsr (a3)
    1442:	addq.l #8,sp
    1444:	movea.w d0,a1
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    1446:	move.b d4,d1
    1448:	ext.w d1
    144a:	move.w d1,d4
    144c:	ext.l d4
    144e:	lsl.l #8,d4
    1450:	andi.w #255,d0
    1454:	movea.w d2,a3
    1456:	lea 9(a3),a3
    145a:	movea.w d6,a0
    145c:	adda.l a0,a0
    145e:	or.w d4,d0
    1460:	move.w d0,(0,a2,a0.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    1464:	addq.w #1,d1
    1466:	movea.w d2,a0
    1468:	lea 10(a0),a0
    146c:	movea.w a3,a3
    146e:	lsl.w #8,d1
    1470:	adda.l a3,a3
    1472:	move.w d1,(0,a3,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    1476:	movea.w a0,a0
    1478:	adda.l a0,a0
    147a:	move.w #-32768,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    1480:	movea.w d2,a0
    1482:	lea 11(a0),a0
    1486:	movea.w a0,a0
    1488:	addi.w #12,d2
    148c:	adda.l a0,a0
    148e:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    1494:	addq.b #6,d3
	for (int l = 0; l < 31; l++)
    1496:	addq.l #1,d5
    1498:	moveq #30,d0
    149a:	cmp.l d5,d0
    149c:	bge.w 1362 <InitStarfieldSprite+0x12>
	}
	// sprite end-mark
	StarSprite[line++] = 0;
    14a0:	move.w d2,d0
    14a2:	addq.w #1,d0
    14a4:	ext.l d2
    14a6:	lea 23adc <StarSprite>,a1
    14ac:	add.l d2,d2
    14ae:	clr.w (0,a1,d2.l)
	StarSprite[line++] = 0;
    14b2:	movea.w d0,a0
    14b4:	adda.l a0,a0
    14b6:	clr.w (0,a0,a1.l)
}
    14ba:	movem.l (sp)+,d2-d7/a2-a3
    14be:	rts

000014c0 <MoveStarfield>:

void MoveStarfield()
{
	for (int l = 1; l < 31 * 24; l += 24)
    14c0:	movea.w #1,a0
    14c4:	bra.s 14f4 <MoveStarfield+0x34>
	{
		((volatile UBYTE *)StarSprite)[l] += 1;
    14c6:	movea.l a0,a1
    14c8:	adda.l #146140,a1
    14ce:	move.b (a1),d0
    14d0:	addq.b #1,d0
    14d2:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 8] += 2;
    14d4:	movea.l a0,a1
    14d6:	adda.l #146148,a1
    14dc:	move.b (a1),d0
    14de:	addq.b #2,d0
    14e0:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 16] += 3;	
    14e2:	movea.l a0,a1
    14e4:	adda.l #146156,a1
    14ea:	move.b (a1),d0
    14ec:	addq.b #3,d0
    14ee:	move.b d0,(a1)
	for (int l = 1; l < 31 * 24; l += 24)
    14f0:	lea 24(a0),a0
    14f4:	cmpa.w #743,a0
    14f8:	ble.s 14c6 <MoveStarfield+0x6>
	}
}
    14fa:	rts

000014fc <MainLoop>:
{
    14fc:	movem.l d2-d4/a2-a5,-(sp)
	while (!MouseLeft())
    1500:	bra.w 1c2a <MainLoop+0x72e>
			SetupCopper(copPtr);
    1504:	move.l 23df6 <copPtr>,-(sp)
    150a:	jsr 20e <SetupCopper>(pc)
			custom->cop1lc = (ULONG)copPtr;
    150e:	movea.l 23fca <custom>,a0
    1514:	move.l 23df6 <copPtr>,128(a0)
			custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    151c:	move.w #64,150(a0)
			custom->copjmp1 = 0x7fff;	   //start coppper
    1522:	move.w #32767,136(a0)
			custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    1528:	move.w #-30752,150(a0)
			ResetCopper = FALSE;
    152e:	clr.w 23df4 <ResetCopper>
    1534:	addq.l #4,sp
    1536:	bra.w 1c46 <MainLoop+0x74a>
					ScrollerDir = 1;
    153a:	move.b #1,6702 <ScrollerDir>
    1542:	bra.w 1d38 <MainLoop+0x83c>
				ScrollerDir -= 1;
    1546:	subq.b #1,d0
    1548:	move.b d0,6702 <ScrollerDir>
				if (ScrollerDir < -4)
    154e:	cmpi.b #-4,d0
    1552:	bge.s 155c <MainLoop+0x60>
					ScrollerDir = -4;
    1554:	move.b #-4,6702 <ScrollerDir>
				if (ScrollerDir > -1)
    155c:	tst.b 6702 <ScrollerDir>
    1562:	blt.w 1d38 <MainLoop+0x83c>
					ScrollerDir = -1;
    1566:	st 6702 <ScrollerDir>
    156c:	bra.w 1d38 <MainLoop+0x83c>
			if (ScrollerPause > 0)
    1570:	move.w 23dee <ScrollerPause>,d0
    1576:	beq.w 1d46 <MainLoop+0x84a>
				ScrollerPause--;
    157a:	subq.w #1,d0
    157c:	move.w d0,23dee <ScrollerPause>
    1582:	bra.w 1d46 <MainLoop+0x84a>
		else if (ScrollerY <= ScrollerMin)
    1586:	cmpa.w #0,a0
    158a:	bgt.w 1d62 <MainLoop+0x866>
			ScrollerY = ScrollerMin;
    158e:	clr.w 23df0 <ScrollerY>
			ScrollerDir = 1;
    1594:	move.b #1,6702 <ScrollerDir>
			if (ScrollerPause > 0)
    159c:	move.w 23dee <ScrollerPause>,d0
    15a2:	beq.w 1d62 <MainLoop+0x866>
				ScrollerPause--;
    15a6:	subq.w #1,d0
    15a8:	move.w d0,23dee <ScrollerPause>
    15ae:	bra.w 1d62 <MainLoop+0x866>
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    15b2:	pea 4 <_start+0x4>
    15b6:	pea 20 <_start+0x20>
    15ba:	pea 28 <_start+0x28>
    15be:	move.l 23e9e <BmpScroller+0xe>,-(sp)
    15c4:	subq.l #2,sp
    15c6:	move.l 23ebe <BmpScroller+0x2e>,-(sp)
    15cc:	move.l 23eba <BmpScroller+0x2a>,-(sp)
    15d2:	move.l 23eb6 <BmpScroller+0x26>,-(sp)
    15d8:	move.l 23eb2 <BmpScroller+0x22>,-(sp)
    15de:	move.l 23eae <BmpScroller+0x1e>,-(sp)
    15e4:	move.l 23eaa <BmpScroller+0x1a>,-(sp)
    15ea:	move.l 23ea6 <BmpScroller+0x16>,-(sp)
    15f0:	move.l 23ea2 <BmpScroller+0x12>,-(sp)
    15f6:	move.l 23e9e <BmpScroller+0xe>,-(sp)
    15fc:	move.l 23e9a <BmpScroller+0xa>,-(sp)
    1602:	move.l 23e96 <BmpScroller+0x6>,-(sp)
    1608:	move.l 23e92 <BmpScroller+0x2>,-(sp)
    160e:	move.w 23e90 <BmpScroller>,-(sp)
    1614:	jsr b5a <Scrollit>(pc)
    1618:	lea 68(sp),sp
    161c:	bra.w 1d6c <MainLoop+0x870>
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
    1620:	moveq #56,d2
    1622:	add.l d2,d1
    1624:	add.w d1,d1
    1626:	add.w d1,d1
    1628:	move.w d1,(a2)
        *copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
    162a:	move.l d0,d2
    162c:	clr.w d2
    162e:	swap d2
    1630:	move.w d2,2(a2)
        *copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
    1634:	addq.w #2,d1
    1636:	move.w d1,4(a2)
        *copListEnd++ = (UWORD)addr; // high-word of adress
    163a:	move.w d0,6(a2)
        addr += Bpl;
    163e:	add.l d4,d0
    for (USHORT i = 0; i < numPlanes; i++)
    1640:	addq.w #1,a0
        *copListEnd++ = (UWORD)addr; // high-word of adress
    1642:	addq.l #8,a2
    for (USHORT i = 0; i < numPlanes; i++)
    1644:	moveq #0,d1
    1646:	move.w a0,d1
    1648:	cmp.l d3,d1
    164a:	blt.s 1620 <MainLoop+0x124>
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[0].X, BobTarget[0].Y, 32, 32);
    164c:	pea 20 <_start+0x20>
    1650:	pea 20 <_start+0x20>
    1654:	lea 66e2 <BobTarget>,a4
    165a:	move.l 66e6 <BobTarget+0x4>,-(sp)
    1660:	move.l (a4),-(sp)
    1662:	subq.l #2,sp
    1664:	move.l 23ef0 <BmpUpperPart_Buf1+0x2e>,-(sp)
    166a:	move.l 23eec <BmpUpperPart_Buf1+0x2a>,-(sp)
    1670:	move.l 23ee8 <BmpUpperPart_Buf1+0x26>,-(sp)
    1676:	move.l 23ee4 <BmpUpperPart_Buf1+0x22>,-(sp)
    167c:	move.l 23ee0 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1682:	move.l 23edc <BmpUpperPart_Buf1+0x1a>,-(sp)
    1688:	move.l 23ed8 <BmpUpperPart_Buf1+0x16>,-(sp)
    168e:	move.l 23ed4 <BmpUpperPart_Buf1+0x12>,-(sp)
    1694:	move.l 23ed0 <BmpUpperPart_Buf1+0xe>,-(sp)
    169a:	move.l 23ecc <BmpUpperPart_Buf1+0xa>,-(sp)
    16a0:	move.l 23ec8 <BmpUpperPart_Buf1+0x6>,-(sp)
    16a6:	move.l 23ec4 <BmpUpperPart_Buf1+0x2>,-(sp)
    16ac:	lea 23ec2 <BmpUpperPart_Buf1>,a2
    16b2:	move.w (a2),-(sp)
    16b4:	lea f90 <ClearBitmapPart>(pc),a3
    16b8:	jsr (a3)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[1].X, BobTarget[1].Y, 32, 32);
    16ba:	lea 68(sp),sp
    16be:	pea 20 <_start+0x20>
    16c2:	pea 20 <_start+0x20>
    16c6:	move.l 66ee <BobTarget+0xc>,-(sp)
    16cc:	move.l 66ea <BobTarget+0x8>,-(sp)
    16d2:	subq.l #2,sp
    16d4:	move.l 23ef0 <BmpUpperPart_Buf1+0x2e>,-(sp)
    16da:	move.l 23eec <BmpUpperPart_Buf1+0x2a>,-(sp)
    16e0:	move.l 23ee8 <BmpUpperPart_Buf1+0x26>,-(sp)
    16e6:	move.l 23ee4 <BmpUpperPart_Buf1+0x22>,-(sp)
    16ec:	move.l 23ee0 <BmpUpperPart_Buf1+0x1e>,-(sp)
    16f2:	move.l 23edc <BmpUpperPart_Buf1+0x1a>,-(sp)
    16f8:	move.l 23ed8 <BmpUpperPart_Buf1+0x16>,-(sp)
    16fe:	move.l 23ed4 <BmpUpperPart_Buf1+0x12>,-(sp)
    1704:	move.l 23ed0 <BmpUpperPart_Buf1+0xe>,-(sp)
    170a:	move.l 23ecc <BmpUpperPart_Buf1+0xa>,-(sp)
    1710:	move.l 23ec8 <BmpUpperPart_Buf1+0x6>,-(sp)
    1716:	move.l 23ec4 <BmpUpperPart_Buf1+0x2>,-(sp)
    171c:	move.w (a2),-(sp)
    171e:	jsr (a3)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[2].X, BobTarget[2].Y, 32, 32);
    1720:	lea 68(sp),sp
    1724:	pea 20 <_start+0x20>
    1728:	pea 20 <_start+0x20>
    172c:	move.l 66f6 <BobTarget+0x14>,-(sp)
    1732:	move.l 66f2 <BobTarget+0x10>,-(sp)
    1738:	subq.l #2,sp
    173a:	move.l 23ef0 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1740:	move.l 23eec <BmpUpperPart_Buf1+0x2a>,-(sp)
    1746:	move.l 23ee8 <BmpUpperPart_Buf1+0x26>,-(sp)
    174c:	move.l 23ee4 <BmpUpperPart_Buf1+0x22>,-(sp)
    1752:	move.l 23ee0 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1758:	move.l 23edc <BmpUpperPart_Buf1+0x1a>,-(sp)
    175e:	move.l 23ed8 <BmpUpperPart_Buf1+0x16>,-(sp)
    1764:	move.l 23ed4 <BmpUpperPart_Buf1+0x12>,-(sp)
    176a:	move.l 23ed0 <BmpUpperPart_Buf1+0xe>,-(sp)
    1770:	move.l 23ecc <BmpUpperPart_Buf1+0xa>,-(sp)
    1776:	move.l 23ec8 <BmpUpperPart_Buf1+0x6>,-(sp)
    177c:	move.l 23ec4 <BmpUpperPart_Buf1+0x2>,-(sp)
    1782:	move.w (a2),-(sp)
    1784:	jsr (a3)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[3].X, BobTarget[3].Y, 32, 32);
    1786:	lea 68(sp),sp
    178a:	pea 20 <_start+0x20>
    178e:	pea 20 <_start+0x20>
    1792:	move.l 66fe <BobTarget+0x1c>,-(sp)
    1798:	move.l 66fa <BobTarget+0x18>,-(sp)
    179e:	subq.l #2,sp
    17a0:	move.l 23ef0 <BmpUpperPart_Buf1+0x2e>,-(sp)
    17a6:	move.l 23eec <BmpUpperPart_Buf1+0x2a>,-(sp)
    17ac:	move.l 23ee8 <BmpUpperPart_Buf1+0x26>,-(sp)
    17b2:	move.l 23ee4 <BmpUpperPart_Buf1+0x22>,-(sp)
    17b8:	move.l 23ee0 <BmpUpperPart_Buf1+0x1e>,-(sp)
    17be:	move.l 23edc <BmpUpperPart_Buf1+0x1a>,-(sp)
    17c4:	move.l 23ed8 <BmpUpperPart_Buf1+0x16>,-(sp)
    17ca:	move.l 23ed4 <BmpUpperPart_Buf1+0x12>,-(sp)
    17d0:	move.l 23ed0 <BmpUpperPart_Buf1+0xe>,-(sp)
    17d6:	move.l 23ecc <BmpUpperPart_Buf1+0xa>,-(sp)
    17dc:	move.l 23ec8 <BmpUpperPart_Buf1+0x6>,-(sp)
    17e2:	move.l 23ec4 <BmpUpperPart_Buf1+0x2>,-(sp)
    17e8:	move.w (a2),-(sp)
    17ea:	jsr (a3)
		MoveBobs();
    17ec:	lea 68(sp),sp
    17f0:	jsr 74 <MoveBobs>(pc)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[0], BobTarget[0], 32, 32);
    17f4:	pea 20 <_start+0x20>
    17f8:	pea 20 <_start+0x20>
    17fc:	move.l 4(a4),-(sp)
    1800:	move.l (a4),-(sp)
    1802:	move.l 46a0 <BobSource+0x4>,-(sp)
    1808:	move.l 469c <BobSource>,-(sp)
    180e:	subq.l #2,sp
    1810:	move.l 23e28 <BmpCookieMask+0x2e>,-(sp)
    1816:	move.l 23e24 <BmpCookieMask+0x2a>,-(sp)
    181c:	move.l 23e20 <BmpCookieMask+0x26>,-(sp)
    1822:	move.l 23e1c <BmpCookieMask+0x22>,-(sp)
    1828:	move.l 23e18 <BmpCookieMask+0x1e>,-(sp)
    182e:	move.l 23e14 <BmpCookieMask+0x1a>,-(sp)
    1834:	move.l 23e10 <BmpCookieMask+0x16>,-(sp)
    183a:	move.l 23e0c <BmpCookieMask+0x12>,-(sp)
    1840:	move.l 23e08 <BmpCookieMask+0xe>,-(sp)
    1846:	move.l 23e04 <BmpCookieMask+0xa>,-(sp)
    184c:	move.l 23e00 <BmpCookieMask+0x6>,-(sp)
    1852:	move.l 23dfc <BmpCookieMask+0x2>,-(sp)
    1858:	lea 23dfa <BmpCookieMask>,a5
    185e:	move.w (a5),-(sp)
    1860:	subq.l #2,sp
    1862:	move.l 23ef0 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1868:	move.l 23eec <BmpUpperPart_Buf1+0x2a>,-(sp)
    186e:	move.l 23ee8 <BmpUpperPart_Buf1+0x26>,-(sp)
    1874:	move.l 23ee4 <BmpUpperPart_Buf1+0x22>,-(sp)
    187a:	move.l 23ee0 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1880:	move.l 23edc <BmpUpperPart_Buf1+0x1a>,-(sp)
    1886:	move.l 23ed8 <BmpUpperPart_Buf1+0x16>,-(sp)
    188c:	move.l 23ed4 <BmpUpperPart_Buf1+0x12>,-(sp)
    1892:	move.l 23ed0 <BmpUpperPart_Buf1+0xe>,-(sp)
    1898:	move.l 23ecc <BmpUpperPart_Buf1+0xa>,-(sp)
    189e:	move.l 23ec8 <BmpUpperPart_Buf1+0x6>,-(sp)
    18a4:	move.l 23ec4 <BmpUpperPart_Buf1+0x2>,-(sp)
    18aa:	move.w (a2),-(sp)
    18ac:	subq.l #2,sp
    18ae:	move.l 23e5a <BmpCookie+0x2e>,-(sp)
    18b4:	move.l 23e56 <BmpCookie+0x2a>,-(sp)
    18ba:	move.l 23e52 <BmpCookie+0x26>,-(sp)
    18c0:	move.l 23e4e <BmpCookie+0x22>,-(sp)
    18c6:	move.l 23e4a <BmpCookie+0x1e>,-(sp)
    18cc:	move.l 23e46 <BmpCookie+0x1a>,-(sp)
    18d2:	move.l 23e42 <BmpCookie+0x16>,-(sp)
    18d8:	move.l 23e3e <BmpCookie+0x12>,-(sp)
    18de:	move.l 23e3a <BmpCookie+0xe>,-(sp)
    18e4:	move.l 23e36 <BmpCookie+0xa>,-(sp)
    18ea:	move.l 23e32 <BmpCookie+0x6>,-(sp)
    18f0:	move.l 23e2e <BmpCookie+0x2>,-(sp)
    18f6:	lea 23e2c <BmpCookie>,a4
    18fc:	move.w (a4),-(sp)
    18fe:	lea 1138 <BetterBlit>(pc),a3
    1902:	jsr (a3)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[1], BobTarget[1], 32, 32);
    1904:	lea 180(sp),sp
    1908:	pea 20 <_start+0x20>
    190c:	pea 20 <_start+0x20>
    1910:	move.l 66ee <BobTarget+0xc>,-(sp)
    1916:	move.l 66ea <BobTarget+0x8>,-(sp)
    191c:	move.l 46a8 <BobSource+0xc>,-(sp)
    1922:	move.l 46a4 <BobSource+0x8>,-(sp)
    1928:	subq.l #2,sp
    192a:	move.l 23e28 <BmpCookieMask+0x2e>,-(sp)
    1930:	move.l 23e24 <BmpCookieMask+0x2a>,-(sp)
    1936:	move.l 23e20 <BmpCookieMask+0x26>,-(sp)
    193c:	move.l 23e1c <BmpCookieMask+0x22>,-(sp)
    1942:	move.l 23e18 <BmpCookieMask+0x1e>,-(sp)
    1948:	move.l 23e14 <BmpCookieMask+0x1a>,-(sp)
    194e:	move.l 23e10 <BmpCookieMask+0x16>,-(sp)
    1954:	move.l 23e0c <BmpCookieMask+0x12>,-(sp)
    195a:	move.l 23e08 <BmpCookieMask+0xe>,-(sp)
    1960:	move.l 23e04 <BmpCookieMask+0xa>,-(sp)
    1966:	move.l 23e00 <BmpCookieMask+0x6>,-(sp)
    196c:	move.l 23dfc <BmpCookieMask+0x2>,-(sp)
    1972:	move.w (a5),-(sp)
    1974:	subq.l #2,sp
    1976:	move.l 23ef0 <BmpUpperPart_Buf1+0x2e>,-(sp)
    197c:	move.l 23eec <BmpUpperPart_Buf1+0x2a>,-(sp)
    1982:	move.l 23ee8 <BmpUpperPart_Buf1+0x26>,-(sp)
    1988:	move.l 23ee4 <BmpUpperPart_Buf1+0x22>,-(sp)
    198e:	move.l 23ee0 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1994:	move.l 23edc <BmpUpperPart_Buf1+0x1a>,-(sp)
    199a:	move.l 23ed8 <BmpUpperPart_Buf1+0x16>,-(sp)
    19a0:	move.l 23ed4 <BmpUpperPart_Buf1+0x12>,-(sp)
    19a6:	move.l 23ed0 <BmpUpperPart_Buf1+0xe>,-(sp)
    19ac:	move.l 23ecc <BmpUpperPart_Buf1+0xa>,-(sp)
    19b2:	move.l 23ec8 <BmpUpperPart_Buf1+0x6>,-(sp)
    19b8:	move.l 23ec4 <BmpUpperPart_Buf1+0x2>,-(sp)
    19be:	move.w (a2),-(sp)
    19c0:	subq.l #2,sp
    19c2:	move.l 23e5a <BmpCookie+0x2e>,-(sp)
    19c8:	move.l 23e56 <BmpCookie+0x2a>,-(sp)
    19ce:	move.l 23e52 <BmpCookie+0x26>,-(sp)
    19d4:	move.l 23e4e <BmpCookie+0x22>,-(sp)
    19da:	move.l 23e4a <BmpCookie+0x1e>,-(sp)
    19e0:	move.l 23e46 <BmpCookie+0x1a>,-(sp)
    19e6:	move.l 23e42 <BmpCookie+0x16>,-(sp)
    19ec:	move.l 23e3e <BmpCookie+0x12>,-(sp)
    19f2:	move.l 23e3a <BmpCookie+0xe>,-(sp)
    19f8:	move.l 23e36 <BmpCookie+0xa>,-(sp)
    19fe:	move.l 23e32 <BmpCookie+0x6>,-(sp)
    1a04:	move.l 23e2e <BmpCookie+0x2>,-(sp)
    1a0a:	move.w (a4),-(sp)
    1a0c:	jsr (a3)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[2], BobTarget[2], 32, 32);
    1a0e:	lea 180(sp),sp
    1a12:	pea 20 <_start+0x20>
    1a16:	pea 20 <_start+0x20>
    1a1a:	move.l 66f6 <BobTarget+0x14>,-(sp)
    1a20:	move.l 66f2 <BobTarget+0x10>,-(sp)
    1a26:	move.l 46b0 <BobSource+0x14>,-(sp)
    1a2c:	move.l 46ac <BobSource+0x10>,-(sp)
    1a32:	subq.l #2,sp
    1a34:	move.l 23e28 <BmpCookieMask+0x2e>,-(sp)
    1a3a:	move.l 23e24 <BmpCookieMask+0x2a>,-(sp)
    1a40:	move.l 23e20 <BmpCookieMask+0x26>,-(sp)
    1a46:	move.l 23e1c <BmpCookieMask+0x22>,-(sp)
    1a4c:	move.l 23e18 <BmpCookieMask+0x1e>,-(sp)
    1a52:	move.l 23e14 <BmpCookieMask+0x1a>,-(sp)
    1a58:	move.l 23e10 <BmpCookieMask+0x16>,-(sp)
    1a5e:	move.l 23e0c <BmpCookieMask+0x12>,-(sp)
    1a64:	move.l 23e08 <BmpCookieMask+0xe>,-(sp)
    1a6a:	move.l 23e04 <BmpCookieMask+0xa>,-(sp)
    1a70:	move.l 23e00 <BmpCookieMask+0x6>,-(sp)
    1a76:	move.l 23dfc <BmpCookieMask+0x2>,-(sp)
    1a7c:	move.w (a5),-(sp)
    1a7e:	subq.l #2,sp
    1a80:	move.l 23ef0 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1a86:	move.l 23eec <BmpUpperPart_Buf1+0x2a>,-(sp)
    1a8c:	move.l 23ee8 <BmpUpperPart_Buf1+0x26>,-(sp)
    1a92:	move.l 23ee4 <BmpUpperPart_Buf1+0x22>,-(sp)
    1a98:	move.l 23ee0 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1a9e:	move.l 23edc <BmpUpperPart_Buf1+0x1a>,-(sp)
    1aa4:	move.l 23ed8 <BmpUpperPart_Buf1+0x16>,-(sp)
    1aaa:	move.l 23ed4 <BmpUpperPart_Buf1+0x12>,-(sp)
    1ab0:	move.l 23ed0 <BmpUpperPart_Buf1+0xe>,-(sp)
    1ab6:	move.l 23ecc <BmpUpperPart_Buf1+0xa>,-(sp)
    1abc:	move.l 23ec8 <BmpUpperPart_Buf1+0x6>,-(sp)
    1ac2:	move.l 23ec4 <BmpUpperPart_Buf1+0x2>,-(sp)
    1ac8:	move.w (a2),-(sp)
    1aca:	subq.l #2,sp
    1acc:	move.l 23e5a <BmpCookie+0x2e>,-(sp)
    1ad2:	move.l 23e56 <BmpCookie+0x2a>,-(sp)
    1ad8:	move.l 23e52 <BmpCookie+0x26>,-(sp)
    1ade:	move.l 23e4e <BmpCookie+0x22>,-(sp)
    1ae4:	move.l 23e4a <BmpCookie+0x1e>,-(sp)
    1aea:	move.l 23e46 <BmpCookie+0x1a>,-(sp)
    1af0:	move.l 23e42 <BmpCookie+0x16>,-(sp)
    1af6:	move.l 23e3e <BmpCookie+0x12>,-(sp)
    1afc:	move.l 23e3a <BmpCookie+0xe>,-(sp)
    1b02:	move.l 23e36 <BmpCookie+0xa>,-(sp)
    1b08:	move.l 23e32 <BmpCookie+0x6>,-(sp)
    1b0e:	move.l 23e2e <BmpCookie+0x2>,-(sp)
    1b14:	move.w (a4),-(sp)
    1b16:	jsr (a3)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[3], BobTarget[3], 32, 32);
    1b18:	lea 180(sp),sp
    1b1c:	pea 20 <_start+0x20>
    1b20:	pea 20 <_start+0x20>
    1b24:	move.l 66fe <BobTarget+0x1c>,-(sp)
    1b2a:	move.l 66fa <BobTarget+0x18>,-(sp)
    1b30:	move.l 46b8 <BobSource+0x1c>,-(sp)
    1b36:	move.l 46b4 <BobSource+0x18>,-(sp)
    1b3c:	subq.l #2,sp
    1b3e:	move.l 23e28 <BmpCookieMask+0x2e>,-(sp)
    1b44:	move.l 23e24 <BmpCookieMask+0x2a>,-(sp)
    1b4a:	move.l 23e20 <BmpCookieMask+0x26>,-(sp)
    1b50:	move.l 23e1c <BmpCookieMask+0x22>,-(sp)
    1b56:	move.l 23e18 <BmpCookieMask+0x1e>,-(sp)
    1b5c:	move.l 23e14 <BmpCookieMask+0x1a>,-(sp)
    1b62:	move.l 23e10 <BmpCookieMask+0x16>,-(sp)
    1b68:	move.l 23e0c <BmpCookieMask+0x12>,-(sp)
    1b6e:	move.l 23e08 <BmpCookieMask+0xe>,-(sp)
    1b74:	move.l 23e04 <BmpCookieMask+0xa>,-(sp)
    1b7a:	move.l 23e00 <BmpCookieMask+0x6>,-(sp)
    1b80:	move.l 23dfc <BmpCookieMask+0x2>,-(sp)
    1b86:	move.w (a5),-(sp)
    1b88:	subq.l #2,sp
    1b8a:	move.l 23ef0 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1b90:	move.l 23eec <BmpUpperPart_Buf1+0x2a>,-(sp)
    1b96:	move.l 23ee8 <BmpUpperPart_Buf1+0x26>,-(sp)
    1b9c:	move.l 23ee4 <BmpUpperPart_Buf1+0x22>,-(sp)
    1ba2:	move.l 23ee0 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1ba8:	move.l 23edc <BmpUpperPart_Buf1+0x1a>,-(sp)
    1bae:	move.l 23ed8 <BmpUpperPart_Buf1+0x16>,-(sp)
    1bb4:	move.l 23ed4 <BmpUpperPart_Buf1+0x12>,-(sp)
    1bba:	move.l 23ed0 <BmpUpperPart_Buf1+0xe>,-(sp)
    1bc0:	move.l 23ecc <BmpUpperPart_Buf1+0xa>,-(sp)
    1bc6:	move.l 23ec8 <BmpUpperPart_Buf1+0x6>,-(sp)
    1bcc:	move.l 23ec4 <BmpUpperPart_Buf1+0x2>,-(sp)
    1bd2:	move.w (a2),-(sp)
    1bd4:	subq.l #2,sp
    1bd6:	move.l 23e5a <BmpCookie+0x2e>,-(sp)
    1bdc:	move.l 23e56 <BmpCookie+0x2a>,-(sp)
    1be2:	move.l 23e52 <BmpCookie+0x26>,-(sp)
    1be8:	move.l 23e4e <BmpCookie+0x22>,-(sp)
    1bee:	move.l 23e4a <BmpCookie+0x1e>,-(sp)
    1bf4:	move.l 23e46 <BmpCookie+0x1a>,-(sp)
    1bfa:	move.l 23e42 <BmpCookie+0x16>,-(sp)
    1c00:	move.l 23e3e <BmpCookie+0x12>,-(sp)
    1c06:	move.l 23e3a <BmpCookie+0xe>,-(sp)
    1c0c:	move.l 23e36 <BmpCookie+0xa>,-(sp)
    1c12:	move.l 23e32 <BmpCookie+0x6>,-(sp)
    1c18:	move.l 23e2e <BmpCookie+0x2>,-(sp)
    1c1e:	move.w (a4),-(sp)
    1c20:	jsr (a3)
		MoveStarfield();
    1c22:	lea 180(sp),sp
    1c26:	jsr 14c0 <MoveStarfield>(pc)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    1c2a:	move.b bfe001 <_end+0xbda031>,d0
	while (!MouseLeft())
    1c30:	btst #6,d0
    1c34:	beq.w 1daa <MainLoop+0x8ae>
		WaitVbl();
    1c38:	jsr d22 <WaitVbl>(pc)
		if (ResetCopper)
    1c3c:	tst.w 23df4 <ResetCopper>
    1c42:	bne.w 1504 <MainLoop+0x8>
		CopyBitmap(BmpUpperPart_Buf1, BmpUpperPart_PF2);
    1c46:	subq.l #2,sp
    1c48:	move.l 23f22 <BmpUpperPart_PF2+0x2e>,-(sp)
    1c4e:	move.l 23f1e <BmpUpperPart_PF2+0x2a>,-(sp)
    1c54:	move.l 23f1a <BmpUpperPart_PF2+0x26>,-(sp)
    1c5a:	move.l 23f16 <BmpUpperPart_PF2+0x22>,-(sp)
    1c60:	move.l 23f12 <BmpUpperPart_PF2+0x1e>,-(sp)
    1c66:	move.l 23f0e <BmpUpperPart_PF2+0x1a>,-(sp)
    1c6c:	move.l 23f0a <BmpUpperPart_PF2+0x16>,-(sp)
    1c72:	move.l 23f06 <BmpUpperPart_PF2+0x12>,-(sp)
    1c78:	move.l 23f02 <BmpUpperPart_PF2+0xe>,-(sp)
    1c7e:	move.l 23efe <BmpUpperPart_PF2+0xa>,-(sp)
    1c84:	move.l 23efa <BmpUpperPart_PF2+0x6>,-(sp)
    1c8a:	move.l 23ef6 <BmpUpperPart_PF2+0x2>,-(sp)
    1c90:	move.w 23ef4 <BmpUpperPart_PF2>,-(sp)
    1c96:	subq.l #2,sp
    1c98:	move.l 23ef0 <BmpUpperPart_Buf1+0x2e>,-(sp)
    1c9e:	move.l 23eec <BmpUpperPart_Buf1+0x2a>,-(sp)
    1ca4:	move.l 23ee8 <BmpUpperPart_Buf1+0x26>,-(sp)
    1caa:	move.l 23ee4 <BmpUpperPart_Buf1+0x22>,-(sp)
    1cb0:	move.l 23ee0 <BmpUpperPart_Buf1+0x1e>,-(sp)
    1cb6:	move.l 23edc <BmpUpperPart_Buf1+0x1a>,-(sp)
    1cbc:	move.l 23ed8 <BmpUpperPart_Buf1+0x16>,-(sp)
    1cc2:	move.l 23ed4 <BmpUpperPart_Buf1+0x12>,-(sp)
    1cc8:	move.l 23ed0 <BmpUpperPart_Buf1+0xe>,-(sp)
    1cce:	move.l 23ecc <BmpUpperPart_Buf1+0xa>,-(sp)
    1cd4:	move.l 23ec8 <BmpUpperPart_Buf1+0x6>,-(sp)
    1cda:	move.l 23ec4 <BmpUpperPart_Buf1+0x2>,-(sp)
    1ce0:	move.w 23ec2 <BmpUpperPart_Buf1>,-(sp)
    1ce6:	jsr f34 <CopyBitmap>(pc)
		if (BounceEnabled)
    1cea:	lea 104(sp),sp
    1cee:	tst.w 23df2 <BounceEnabled>
    1cf4:	beq.w 1570 <MainLoop+0x74>
			if (ScrollerDir > 0)
    1cf8:	move.b 6702 <ScrollerDir>,d0
    1cfe:	ble.w 1546 <MainLoop+0x4a>
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
    1d02:	pea c <_start+0xc>
    1d06:	movea.w #40,a0
    1d0a:	suba.w 23df0 <ScrollerY>,a0
    1d10:	move.l a0,-(sp)
    1d12:	jsr 24fe <__divsi3>
    1d18:	addq.l #8,sp
    1d1a:	move.b d0,6702 <ScrollerDir>
				if (ScrollerDir > 6)
    1d20:	cmpi.b #6,d0
    1d24:	ble.s 1d2e <MainLoop+0x832>
					ScrollerDir = 6;
    1d26:	move.b #6,6702 <ScrollerDir>
				if (ScrollerDir < 1)
    1d2e:	tst.b 6702 <ScrollerDir>
    1d34:	ble.w 153a <MainLoop+0x3e>
			ScrollerY += ScrollerDir;
    1d38:	move.b 6702 <ScrollerDir>,d0
    1d3e:	ext.w d0
    1d40:	add.w d0,23df0 <ScrollerY>
		if (ScrollerY >= ScrollerMax)
    1d46:	movea.w 23df0 <ScrollerY>,a0
    1d4c:	moveq #39,d0
    1d4e:	cmp.l a0,d0
    1d50:	bge.w 1586 <MainLoop+0x8a>
			ScrollerY = ScrollerMax;
    1d54:	move.w #40,23df0 <ScrollerY>
			ScrollerDir = -1;
    1d5c:	st 6702 <ScrollerDir>
		if (ScrollerPause < 1)
    1d62:	tst.w 23dee <ScrollerPause>
    1d68:	beq.w 15b2 <MainLoop+0xb6>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    1d6c:	moveq #0,d4
    1d6e:	move.w 23e96 <BmpScroller+0x6>,d4
    1d74:	moveq #0,d3
    1d76:	move.w 23e94 <BmpScroller+0x4>,d3
    1d7c:	movea.l 23dea <copScrollerBmpP>,a2
    ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
    1d82:	lea 2480 <__mulsi3>,a3
    1d88:	move.l d4,-(sp)
    1d8a:	movea.w 23df0 <ScrollerY>,a0
    1d90:	move.l a0,-(sp)
    1d92:	jsr (a3)
    1d94:	addq.l #8,sp
    1d96:	move.l d0,-(sp)
    1d98:	move.l d3,-(sp)
    1d9a:	jsr (a3)
    1d9c:	addq.l #8,sp
    1d9e:	add.l 23e9e <BmpScroller+0xe>,d0
    for (USHORT i = 0; i < numPlanes; i++)
    1da4:	suba.l a0,a0
    1da6:	bra.w 1644 <MainLoop+0x148>
}
    1daa:	movem.l (sp)+,d2-d4/a2-a5
    1dae:	rts

00001db0 <KPrintF>:
void KPrintF(const char* fmt, ...) {
    1db0:	lea -128(sp),sp
    1db4:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    1db8:	move.w f0ff60 <_end+0xeebf90>,d0
    1dbe:	cmpi.w #20153,d0
    1dc2:	beq.s 1dee <KPrintF+0x3e>
    1dc4:	cmpi.w #-24562,d0
    1dc8:	beq.s 1dee <KPrintF+0x3e>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    1dca:	movea.l 23fc4 <SysBase>,a6
    1dd0:	movea.l 144(sp),a0
    1dd4:	lea 148(sp),a1
    1dd8:	lea 257a <KPutCharX>,a2
    1dde:	suba.l a3,a3
    1de0:	jsr -522(a6)
}
    1de4:	movem.l (sp)+,a2-a3/a6
    1de8:	lea 128(sp),sp
    1dec:	rts
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    1dee:	movea.l 23fc4 <SysBase>,a6
    1df4:	movea.l 144(sp),a0
    1df8:	lea 148(sp),a1
    1dfc:	lea 2588 <PutChar>,a2
    1e02:	lea 12(sp),a3
    1e06:	jsr -522(a6)
		UaeDbgLog(86, temp);
    1e0a:	move.l a3,-(sp)
    1e0c:	pea 56 <_start+0x56>
    1e10:	jsr f0ff60 <_end+0xeebf90>
    1e16:	addq.l #8,sp
}
    1e18:	movem.l (sp)+,a2-a3/a6
    1e1c:	lea 128(sp),sp
    1e20:	rts

00001e22 <main>:
{
    1e22:	movem.l d2-d3/a2/a6,-(sp)
	SysBase = *((struct ExecBase **)4UL);
    1e26:	movea.l 4 <_start+0x4>,a6
    1e2a:	move.l a6,23fc4 <SysBase>
	custom = (struct Custom *)0xdff000;
    1e30:	move.l #14675968,23fca <custom>
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
    1e3a:	lea 3fc5 <incbin_P61_Player_end+0x1>,a1
    1e40:	moveq #0,d0
    1e42:	jsr -552(a6)
    1e46:	move.l d0,23fc0 <GfxBase>
	if (!GfxBase)
    1e4c:	beq.w 222e <main+0x40c>
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    1e50:	movea.l 23fc4 <SysBase>,a6
    1e56:	lea 3fd6 <incbin_P61_Player_end+0x12>,a1
    1e5c:	moveq #0,d0
    1e5e:	jsr -552(a6)
    1e62:	move.l d0,23fbc <DOSBase>
	if (!DOSBase)
    1e68:	beq.w 223e <main+0x41c>
	KPrintF("Hello debugger from Amiga!\n");
    1e6c:	pea 3fe2 <incbin_P61_Player_end+0x1e>
    1e72:	jsr 1db0 <KPrintF>(pc)
	Write(Output(), (APTR) "Hello console!\n", 15);
    1e76:	movea.l 23fbc <DOSBase>,a6
    1e7c:	jsr -60(a6)
    1e80:	movea.l 23fbc <DOSBase>,a6
    1e86:	move.l d0,d1
    1e88:	move.l #16382,d2
    1e8e:	moveq #15,d3
    1e90:	jsr -48(a6)
	BitmapInit(&Screen, 320, 256, 3);
    1e94:	pea 3 <_start+0x3>
    1e98:	pea 100 <MoveBobs+0x8c>
    1e9c:	pea 140 <MoveBobs+0xcc>
    1ea0:	pea 23f8a <Screen>
    1ea6:	lea 1316 <BitmapInit>(pc),a2
    1eaa:	jsr (a2)
	BitmapInit(&BmpLogo, 256, 130, 3);
    1eac:	pea 3 <_start+0x3>
    1eb0:	pea 82 <MoveBobs+0xe>
    1eb4:	pea 100 <MoveBobs+0x8c>
    1eb8:	pea 23f58 <BmpLogo>
    1ebe:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF1, 320, 130, 3);
    1ec0:	lea 36(sp),sp
    1ec4:	pea 3 <_start+0x3>
    1ec8:	pea 82 <MoveBobs+0xe>
    1ecc:	pea 140 <MoveBobs+0xcc>
    1ed0:	pea 23f26 <BmpUpperPart_PF1>
    1ed6:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF2, 320, 130, 3);
    1ed8:	pea 3 <_start+0x3>
    1edc:	pea 82 <MoveBobs+0xe>
    1ee0:	pea 140 <MoveBobs+0xcc>
    1ee4:	pea 23ef4 <BmpUpperPart_PF2>
    1eea:	jsr (a2)
	BitmapInit(&BmpUpperPart_Buf1, 320, 130, 3);
    1eec:	lea 32(sp),sp
    1ef0:	pea 3 <_start+0x3>
    1ef4:	pea 82 <MoveBobs+0xe>
    1ef8:	pea 140 <MoveBobs+0xcc>
    1efc:	pea 23ec2 <BmpUpperPart_Buf1>
    1f02:	jsr (a2)
	BitmapInit(&BmpScroller, 320 + 32, 166, 3);
    1f04:	pea 3 <_start+0x3>
    1f08:	pea a6 <MoveBobs+0x32>
    1f0c:	pea 160 <MoveBobs+0xec>
    1f10:	pea 23e90 <BmpScroller>
    1f16:	jsr (a2)
	BitmapInit(&BmpFont32, 320, 256, 3);
    1f18:	lea 32(sp),sp
    1f1c:	pea 3 <_start+0x3>
    1f20:	pea 100 <MoveBobs+0x8c>
    1f24:	pea 140 <MoveBobs+0xcc>
    1f28:	pea 23e5e <BmpFont32>
    1f2e:	jsr (a2)
	BitmapInit(&BmpCookie, 320, 256, 3);
    1f30:	pea 3 <_start+0x3>
    1f34:	pea 100 <MoveBobs+0x8c>
    1f38:	pea 140 <MoveBobs+0xcc>
    1f3c:	pea 23e2c <BmpCookie>
    1f42:	jsr (a2)
	BitmapInit(&BmpCookieMask, 320, 256, 3);
    1f44:	lea 32(sp),sp
    1f48:	pea 3 <_start+0x3>
    1f4c:	pea 100 <MoveBobs+0x8c>
    1f50:	pea 140 <MoveBobs+0xcc>
    1f54:	pea 23dfa <BmpCookieMask>
    1f5a:	jsr (a2)
	copPtr = AllocMem(1024, MEMF_CHIP);
    1f5c:	movea.l 23fc4 <SysBase>,a6
    1f62:	move.l #1024,d0
    1f68:	moveq #2,d1
    1f6a:	jsr -198(a6)
    1f6e:	move.l d0,23df6 <copPtr>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
    1f74:	movea.l 23fc4 <SysBase>,a6
    1f7a:	moveq #0,d0
    1f7c:	move.w 23e9c <BmpScroller+0xc>,d0
    1f82:	move.l #65538,d1
    1f88:	jsr -198(a6)
    1f8c:	move.l d0,23e9e <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
    1f92:	movea.l 23fc4 <SysBase>,a6
    1f98:	moveq #0,d0
    1f9a:	move.w 23f32 <BmpUpperPart_PF1+0xc>,d0
    1fa0:	move.l #65538,d1
    1fa6:	jsr -198(a6)
    1faa:	move.l d0,23f34 <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
    1fb0:	movea.l 23fc4 <SysBase>,a6
    1fb6:	moveq #0,d0
    1fb8:	move.w 23f00 <BmpUpperPart_PF2+0xc>,d0
    1fbe:	move.l #65538,d1
    1fc4:	jsr -198(a6)
    1fc8:	move.l d0,23f02 <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
    1fce:	movea.l 23fc4 <SysBase>,a6
    1fd4:	moveq #0,d0
    1fd6:	move.w 23ece <BmpUpperPart_Buf1+0xc>,d0
    1fdc:	move.l #65538,d1
    1fe2:	jsr -198(a6)
    1fe6:	move.l d0,23ed0 <BmpUpperPart_Buf1+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
    1fec:	move.l #26372,23f66 <BmpLogo+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
    1ff6:	move.l #38854,23e6c <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
    2000:	move.l #69576,23e3a <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
    200a:	move.l #100298,23e08 <BmpCookieMask+0xe>
	InitImagePlanes(&BmpUpperPart_PF1);
    2014:	pea 23f26 <BmpUpperPart_PF1>
    201a:	lea ef4 <InitImagePlanes>(pc),a2
    201e:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF2);
    2020:	pea 23ef4 <BmpUpperPart_PF2>
    2026:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_Buf1);
    2028:	pea 23ec2 <BmpUpperPart_Buf1>
    202e:	jsr (a2)
	InitImagePlanes(&BmpScroller);
    2030:	pea 23e90 <BmpScroller>
    2036:	jsr (a2)
	InitImagePlanes(&BmpFont32);
    2038:	lea 32(sp),sp
    203c:	pea 23e5e <BmpFont32>
    2042:	jsr (a2)
	InitImagePlanes(&BmpCookie);
    2044:	pea 23e2c <BmpCookie>
    204a:	jsr (a2)
	InitImagePlanes(&BmpCookieMask);
    204c:	pea 23dfa <BmpCookieMask>
    2052:	jsr (a2)
	TakeSystem();
    2054:	jsr d68 <TakeSystem>(pc)
	WaitVbl();
    2058:	jsr d22 <WaitVbl>(pc)
	SetupCopper(copPtr);
    205c:	move.l 23df6 <copPtr>,-(sp)
    2062:	jsr 20e <SetupCopper>(pc)
	custom->cop1lc = (ULONG)copPtr;
    2066:	movea.l 23fca <custom>,a0
    206c:	move.l 23df6 <copPtr>,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    2074:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
    207a:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    2080:	move.w #-30752,150(a0)
	SetInterruptHandler((APTR)interruptHandler);
    2086:	pea 12c6 <interruptHandler>(pc)
    208a:	jsr d08 <SetInterruptHandler>(pc)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
    208e:	movea.l 23fca <custom>,a0
    2094:	move.w #-16352,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
    209a:	move.w #32,156(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
    20a0:	move.w #-24576,154(a0)
	if (p61Init(module) != 0)
    20a6:	pea 1ffcc <incbin_module_start>
    20ac:	jsr 1282 <p61Init>(pc)
    20b0:	lea 24(sp),sp
    20b4:	tst.l d0
    20b6:	bne.w 224a <main+0x428>
	InitStarfieldSprite();
    20ba:	jsr 1350 <InitStarfieldSprite>(pc)
	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
    20be:	pea 100 <MoveBobs+0x8c>
    20c2:	pea 82 <MoveBobs+0xe>
    20c6:	clr.l -(sp)
    20c8:	pea 20 <_start+0x20>
    20cc:	clr.l -(sp)
    20ce:	clr.l -(sp)
    20d0:	subq.l #2,sp
    20d2:	move.l 23f54 <BmpUpperPart_PF1+0x2e>,-(sp)
    20d8:	move.l 23f50 <BmpUpperPart_PF1+0x2a>,-(sp)
    20de:	move.l 23f4c <BmpUpperPart_PF1+0x26>,-(sp)
    20e4:	move.l 23f48 <BmpUpperPart_PF1+0x22>,-(sp)
    20ea:	move.l 23f44 <BmpUpperPart_PF1+0x1e>,-(sp)
    20f0:	move.l 23f40 <BmpUpperPart_PF1+0x1a>,-(sp)
    20f6:	move.l 23f3c <BmpUpperPart_PF1+0x16>,-(sp)
    20fc:	move.l 23f38 <BmpUpperPart_PF1+0x12>,-(sp)
    2102:	move.l 23f34 <BmpUpperPart_PF1+0xe>,-(sp)
    2108:	move.l 23f30 <BmpUpperPart_PF1+0xa>,-(sp)
    210e:	move.l 23f2c <BmpUpperPart_PF1+0x6>,-(sp)
    2114:	move.l 23f28 <BmpUpperPart_PF1+0x2>,-(sp)
    211a:	move.w 23f26 <BmpUpperPart_PF1>,-(sp)
    2120:	subq.l #2,sp
    2122:	move.l 23f86 <BmpLogo+0x2e>,-(sp)
    2128:	move.l 23f82 <BmpLogo+0x2a>,-(sp)
    212e:	move.l 23f7e <BmpLogo+0x26>,-(sp)
    2134:	move.l 23f7a <BmpLogo+0x22>,-(sp)
    213a:	move.l 23f76 <BmpLogo+0x1e>,-(sp)
    2140:	move.l 23f72 <BmpLogo+0x1a>,-(sp)
    2146:	move.l 23f6e <BmpLogo+0x16>,-(sp)
    214c:	move.l 23f6a <BmpLogo+0x12>,-(sp)
    2152:	move.l 23f66 <BmpLogo+0xe>,-(sp)
    2158:	move.l 23f62 <BmpLogo+0xa>,-(sp)
    215e:	move.l 23f5e <BmpLogo+0x6>,-(sp)
    2164:	move.l 23f5a <BmpLogo+0x2>,-(sp)
    216a:	move.w 23f58 <BmpLogo>,-(sp)
    2170:	jsr 1074 <SimpleBlit>(pc)
	MainLoop();
    2174:	lea 128(sp),sp
    2178:	jsr 14fc <MainLoop>(pc)
	p61End();
    217c:	jsr 12f4 <p61End>(pc)
	FreeMem(copPtr, 1024);
    2180:	movea.l 23fc4 <SysBase>,a6
    2186:	movea.l 23df6 <copPtr>,a1
    218c:	move.l #1024,d0
    2192:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    2196:	movea.l 23fc4 <SysBase>,a6
    219c:	movea.l 23e9e <BmpScroller+0xe>,a1
    21a2:	moveq #0,d0
    21a4:	move.w 23e9c <BmpScroller+0xc>,d0
    21aa:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    21ae:	movea.l 23fc4 <SysBase>,a6
    21b4:	movea.l 23f34 <BmpUpperPart_PF1+0xe>,a1
    21ba:	moveq #0,d0
    21bc:	move.w 23f32 <BmpUpperPart_PF1+0xc>,d0
    21c2:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    21c6:	movea.l 23fc4 <SysBase>,a6
    21cc:	movea.l 23f02 <BmpUpperPart_PF2+0xe>,a1
    21d2:	moveq #0,d0
    21d4:	move.w 23f00 <BmpUpperPart_PF2+0xc>,d0
    21da:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_Buf1.ImageData, BmpUpperPart_PF2.Btot);
    21de:	movea.l 23fc4 <SysBase>,a6
    21e4:	movea.l 23ed0 <BmpUpperPart_Buf1+0xe>,a1
    21ea:	moveq #0,d0
    21ec:	move.w 23f00 <BmpUpperPart_PF2+0xc>,d0
    21f2:	jsr -210(a6)
	CloseLibrary((struct Library *)DOSBase);
    21f6:	movea.l 23fc4 <SysBase>,a6
    21fc:	movea.l 23fbc <DOSBase>,a1
    2202:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    2206:	movea.l 23fc4 <SysBase>,a6
    220c:	movea.l 23fc0 <GfxBase>,a1
    2212:	jsr -414(a6)
	FreeSystem();
    2216:	jsr e34 <FreeSystem>(pc)
	Exit(0);
    221a:	movea.l 23fbc <DOSBase>,a6
    2220:	moveq #0,d1
    2222:	jsr -144(a6)
}
    2226:	moveq #0,d0
    2228:	movem.l (sp)+,d2-d3/a2/a6
    222c:	rts
		Exit(0);
    222e:	movea.l 23fbc <DOSBase>,a6
    2234:	moveq #0,d1
    2236:	jsr -144(a6)
    223a:	bra.w 1e50 <main+0x2e>
		Exit(0);
    223e:	movea.l d0,a6
    2240:	moveq #0,d1
    2242:	jsr -144(a6)
    2246:	bra.w 1e6c <main+0x4a>
		KPrintF("p61Init failed!\n");
    224a:	pea 400e <incbin_P61_Player_end+0x4a>
    2250:	jsr 1db0 <KPrintF>(pc)
    2254:	addq.l #4,sp
    2256:	bra.w 20ba <main+0x298>

0000225a <strlen>:
unsigned long strlen(const char* s) {
    225a:	movea.l 4(sp),a0
	unsigned long t=0;
    225e:	moveq #0,d0
	while(*s++)
    2260:	tst.b (a0)
    2262:	beq.s 226c <strlen+0x12>
		t++;
    2264:	addq.l #1,d0
	while(*s++)
    2266:	tst.b (0,a0,d0.l)
    226a:	bne.s 2264 <strlen+0xa>
}
    226c:	rts

0000226e <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    226e:	movem.l d2-d7/a2-a3,-(sp)
    2272:	move.l 36(sp),d0
    2276:	move.l 40(sp),d4
    227a:	movea.l 44(sp),a1
	while(len-- > 0)
    227e:	move.l a1,d5
    2280:	subq.l #1,d5
    2282:	cmpa.w #0,a1
    2286:	beq.w 2336 <memset+0xc8>
		*ptr++ = val;
    228a:	move.b d4,d7
    228c:	move.l d0,d1
    228e:	neg.l d1
    2290:	moveq #3,d2
    2292:	and.l d2,d1
    2294:	moveq #5,d6
    2296:	movea.l d0,a2
    2298:	cmp.l d5,d6
    229a:	bcc.s 2306 <memset+0x98>
    229c:	tst.l d1
    229e:	beq.s 22c4 <memset+0x56>
    22a0:	move.b d4,(a2)+
	while(len-- > 0)
    22a2:	subq.l #1,d5
    22a4:	moveq #1,d2
    22a6:	cmp.l d1,d2
    22a8:	beq.s 22c4 <memset+0x56>
		*ptr++ = val;
    22aa:	movea.l d0,a2
    22ac:	addq.l #2,a2
    22ae:	movea.l d0,a0
    22b0:	move.b d4,1(a0)
	while(len-- > 0)
    22b4:	subq.l #1,d5
    22b6:	moveq #3,d2
    22b8:	cmp.l d1,d2
    22ba:	bne.s 22c4 <memset+0x56>
		*ptr++ = val;
    22bc:	addq.l #1,a2
    22be:	move.b d4,2(a0)
	while(len-- > 0)
    22c2:	subq.l #1,d5
    22c4:	move.l a1,d3
    22c6:	sub.l d1,d3
    22c8:	moveq #0,d6
    22ca:	move.b d4,d6
    22cc:	move.l d6,d2
    22ce:	swap d2
    22d0:	clr.w d2
    22d2:	movea.l d2,a0
    22d4:	move.l d4,d2
    22d6:	lsl.w #8,d2
    22d8:	swap d2
    22da:	clr.w d2
    22dc:	lsl.l #8,d6
    22de:	movea.l d6,a3
    22e0:	move.l a0,d6
    22e2:	or.l d6,d2
    22e4:	move.l a3,d6
    22e6:	or.l d6,d2
    22e8:	move.b d7,d2
    22ea:	movea.l d0,a0
    22ec:	adda.l d1,a0
    22ee:	moveq #-4,d1
    22f0:	and.l d3,d1
    22f2:	add.l a0,d1
		*ptr++ = val;
    22f4:	move.l d2,(a0)+
	while(len-- > 0)
    22f6:	cmpa.l d1,a0
    22f8:	bne.s 22f4 <memset+0x86>
    22fa:	moveq #-4,d1
    22fc:	and.l d3,d1
    22fe:	adda.l d1,a2
    2300:	sub.l d1,d5
    2302:	cmp.l d3,d1
    2304:	beq.s 2336 <memset+0xc8>
		*ptr++ = val;
    2306:	move.b d4,(a2)
	while(len-- > 0)
    2308:	tst.l d5
    230a:	beq.s 2336 <memset+0xc8>
		*ptr++ = val;
    230c:	move.b d4,1(a2)
	while(len-- > 0)
    2310:	moveq #1,d1
    2312:	cmp.l d5,d1
    2314:	beq.s 2336 <memset+0xc8>
		*ptr++ = val;
    2316:	move.b d4,2(a2)
	while(len-- > 0)
    231a:	moveq #2,d2
    231c:	cmp.l d5,d2
    231e:	beq.s 2336 <memset+0xc8>
		*ptr++ = val;
    2320:	move.b d4,3(a2)
	while(len-- > 0)
    2324:	moveq #3,d6
    2326:	cmp.l d5,d6
    2328:	beq.s 2336 <memset+0xc8>
		*ptr++ = val;
    232a:	move.b d4,4(a2)
	while(len-- > 0)
    232e:	subq.l #4,d5
    2330:	beq.s 2336 <memset+0xc8>
		*ptr++ = val;
    2332:	move.b d4,5(a2)
}
    2336:	movem.l (sp)+,d2-d7/a2-a3
    233a:	rts

0000233c <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    233c:	movem.l d2-d6,-(sp)
    2340:	move.l 24(sp),d0
    2344:	move.l 28(sp),d1
    2348:	move.l 32(sp),d3
	while(len--)
    234c:	move.l d3,d4
    234e:	subq.l #1,d4
    2350:	tst.l d3
    2352:	beq.s 23b2 <memcpy+0x76>
    2354:	movea.l d1,a0
    2356:	addq.l #1,a0
    2358:	move.l d0,d2
    235a:	sub.l a0,d2
    235c:	moveq #2,d5
    235e:	cmp.l d2,d5
    2360:	sc.s d2
    2362:	neg.b d2
    2364:	moveq #8,d6
    2366:	cmp.l d4,d6
    2368:	sc.s d5
    236a:	neg.b d5
    236c:	and.b d5,d2
    236e:	beq.s 23b8 <memcpy+0x7c>
    2370:	move.l d0,d2
    2372:	or.l d1,d2
    2374:	moveq #3,d5
    2376:	and.l d5,d2
    2378:	bne.s 23b8 <memcpy+0x7c>
    237a:	movea.l d1,a0
    237c:	movea.l d0,a1
    237e:	moveq #-4,d2
    2380:	and.l d3,d2
    2382:	add.l d1,d2
		*d++ = *s++;
    2384:	move.l (a0)+,(a1)+
	while(len--)
    2386:	cmp.l a0,d2
    2388:	bne.s 2384 <memcpy+0x48>
    238a:	moveq #-4,d2
    238c:	and.l d3,d2
    238e:	movea.l d0,a0
    2390:	adda.l d2,a0
    2392:	add.l d2,d1
    2394:	sub.l d2,d4
    2396:	cmp.l d3,d2
    2398:	beq.s 23b2 <memcpy+0x76>
		*d++ = *s++;
    239a:	movea.l d1,a1
    239c:	move.b (a1),(a0)
	while(len--)
    239e:	tst.l d4
    23a0:	beq.s 23b2 <memcpy+0x76>
		*d++ = *s++;
    23a2:	move.b 1(a1),1(a0)
	while(len--)
    23a8:	subq.l #1,d4
    23aa:	beq.s 23b2 <memcpy+0x76>
		*d++ = *s++;
    23ac:	move.b 2(a1),2(a0)
}
    23b2:	movem.l (sp)+,d2-d6
    23b6:	rts
    23b8:	movea.l d0,a1
    23ba:	add.l d3,d1
		*d++ = *s++;
    23bc:	move.b -1(a0),(a1)+
	while(len--)
    23c0:	cmp.l a0,d1
    23c2:	beq.s 23b2 <memcpy+0x76>
    23c4:	addq.l #1,a0
    23c6:	bra.s 23bc <memcpy+0x80>

000023c8 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    23c8:	movem.l d2-d5/a2,-(sp)
    23cc:	move.l 24(sp),d0
    23d0:	move.l 28(sp),d1
    23d4:	move.l 32(sp),d2
		while (len--)
    23d8:	movea.l d2,a1
    23da:	subq.l #1,a1
	if (d < s) {
    23dc:	cmp.l d0,d1
    23de:	bls.s 244c <memmove+0x84>
		while (len--)
    23e0:	tst.l d2
    23e2:	beq.s 2446 <memmove+0x7e>
    23e4:	movea.l d1,a2
    23e6:	addq.l #1,a2
    23e8:	move.l d0,d3
    23ea:	sub.l a2,d3
    23ec:	moveq #2,d4
    23ee:	cmp.l d3,d4
    23f0:	sc.s d3
    23f2:	neg.b d3
    23f4:	moveq #8,d5
    23f6:	cmp.l a1,d5
    23f8:	sc.s d4
    23fa:	neg.b d4
    23fc:	and.b d4,d3
    23fe:	beq.s 2470 <memmove+0xa8>
    2400:	move.l d0,d3
    2402:	or.l d1,d3
    2404:	moveq #3,d4
    2406:	and.l d4,d3
    2408:	bne.s 2470 <memmove+0xa8>
    240a:	movea.l d1,a0
    240c:	movea.l d0,a2
    240e:	moveq #-4,d3
    2410:	and.l d2,d3
    2412:	add.l d1,d3
			*d++ = *s++;
    2414:	move.l (a0)+,(a2)+
		while (len--)
    2416:	cmp.l a0,d3
    2418:	bne.s 2414 <memmove+0x4c>
    241a:	moveq #-4,d3
    241c:	and.l d2,d3
    241e:	movea.l d0,a2
    2420:	adda.l d3,a2
    2422:	movea.l d1,a0
    2424:	adda.l d3,a0
    2426:	suba.l d3,a1
    2428:	cmp.l d2,d3
    242a:	beq.s 2446 <memmove+0x7e>
			*d++ = *s++;
    242c:	move.b (a0),(a2)
		while (len--)
    242e:	cmpa.w #0,a1
    2432:	beq.s 2446 <memmove+0x7e>
			*d++ = *s++;
    2434:	move.b 1(a0),1(a2)
		while (len--)
    243a:	moveq #1,d5
    243c:	cmp.l a1,d5
    243e:	beq.s 2446 <memmove+0x7e>
			*d++ = *s++;
    2440:	move.b 2(a0),2(a2)
}
    2446:	movem.l (sp)+,d2-d5/a2
    244a:	rts
		const char *lasts = s + (len - 1);
    244c:	lea (0,a1,d1.l),a0
		char *lastd = d + (len - 1);
    2450:	adda.l d0,a1
		while (len--)
    2452:	tst.l d2
    2454:	beq.s 2446 <memmove+0x7e>
    2456:	move.l a0,d1
    2458:	sub.l d2,d1
			*lastd-- = *lasts--;
    245a:	move.b (a0),(a1)
		while (len--)
    245c:	subq.l #1,a0
    245e:	subq.l #1,a1
    2460:	cmp.l a0,d1
    2462:	beq.s 2446 <memmove+0x7e>
			*lastd-- = *lasts--;
    2464:	move.b (a0),(a1)
		while (len--)
    2466:	subq.l #1,a0
    2468:	subq.l #1,a1
    246a:	cmp.l a0,d1
    246c:	bne.s 245a <memmove+0x92>
    246e:	bra.s 2446 <memmove+0x7e>
    2470:	movea.l d0,a1
    2472:	add.l d2,d1
			*d++ = *s++;
    2474:	move.b -1(a2),(a1)+
		while (len--)
    2478:	cmp.l a2,d1
    247a:	beq.s 2446 <memmove+0x7e>
    247c:	addq.l #1,a2
    247e:	bra.s 2474 <memmove+0xac>

00002480 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    2480:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    2484:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2488:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    248c:	mulu.w 8(sp),d1
	addw	d1, d0
    2490:	add.w d1,d0
	swap	d0
    2492:	swap d0
	clrw	d0
    2494:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    2496:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    249a:	mulu.w 10(sp),d1
	addl	d1, d0
    249e:	add.l d1,d0
	rts
    24a0:	rts

000024a2 <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    24a2:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    24a4:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    24a8:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    24ac:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    24b2:	bcc.s 24ca <__udivsi3+0x28>
	movel	d0, d2
    24b4:	move.l d0,d2
	clrw	d2
    24b6:	clr.w d2
	swap	d2
    24b8:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    24ba:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    24bc:	move.w d2,d0
	swap	d0
    24be:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    24c0:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    24c4:	divu.w d1,d2
	movew	d2, d0
    24c6:	move.w d2,d0
	jra	6f
    24c8:	bra.s 24fa <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    24ca:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    24cc:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    24ce:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    24d0:	cmpi.l #65536,d1
	jcc	4b
    24d6:	bcc.s 24cc <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    24d8:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    24da:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    24e0:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    24e2:	mulu.w d0,d1
	swap	d2
    24e4:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    24e6:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    24e8:	swap d2
	tstw	d2		/* high part 17 bits? */
    24ea:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    24ec:	bne.s 24f8 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    24ee:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    24f0:	bcs.s 24f8 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    24f2:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    24f6:	bls.s 24fa <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    24f8:	subq.l #1,d0

6:	movel	sp@+, d2
    24fa:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    24fc:	rts

000024fe <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    24fe:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    2500:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    2502:	move.l 12(sp),d1
	jpl	1f
    2506:	bpl.s 250c <__divsi3+0xe>
	negl	d1
    2508:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    250a:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    250c:	move.l 8(sp),d0
	jpl	2f
    2510:	bpl.s 2516 <__divsi3+0x18>
	negl	d0
    2512:	neg.l d0
	negb	d2
    2514:	neg.b d2

2:	movel	d1, sp@-
    2516:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2518:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    251a:	bsr.s 24a2 <__udivsi3>
	addql	#8, sp
    251c:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    251e:	tst.b d2
	jpl	3f
    2520:	bpl.s 2524 <__divsi3+0x26>
	negl	d0
    2522:	neg.l d0

3:	movel	sp@+, d2
    2524:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    2526:	rts

00002528 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    2528:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    252c:	move.l 4(sp),d0
	movel	d1, sp@-
    2530:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2532:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    2534:	bsr.s 24fe <__divsi3>
	addql	#8, sp
    2536:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    2538:	move.l 8(sp),d1
	movel	d1, sp@-
    253c:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    253e:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    2540:	bsr.w 2480 <__mulsi3>
	addql	#8, sp
    2544:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2546:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    254a:	sub.l d0,d1
	movel	d1, d0
    254c:	move.l d1,d0
	rts
    254e:	rts

00002550 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    2550:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    2554:	move.l 4(sp),d0
	movel	d1, sp@-
    2558:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    255a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    255c:	bsr.w 24a2 <__udivsi3>
	addql	#8, sp
    2560:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    2562:	move.l 8(sp),d1
	movel	d1, sp@-
    2566:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    2568:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    256a:	bsr.w 2480 <__mulsi3>
	addql	#8, sp
    256e:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    2570:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    2574:	sub.l d0,d1
	movel	d1, d0
    2576:	move.l d1,d0
	rts
    2578:	rts

0000257a <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    257a:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    257c:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    2580:	jsr -516(a6)
    move.l (sp)+, a6
    2584:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    2586:	rts

00002588 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    2588:	move.b d0,(a3)+
	rts
    258a:	rts

0000258c <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    258c:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    258e:	adda.l a0,a2
	move.l	a2,a3
    2590:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    2592:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    2594:	moveq #56,d4
	moveq	#8,d5
    2596:	moveq #8,d5
	bra.s	.Lliteral
    2598:	bra.s 2602 <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    259a:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    259c:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    259e:	dbf d1,259a <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    25a2:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    25a4:	bcc.s 25a8 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    25a6:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    25a8:	tst.w d0
    25aa:	bne.s 25b4 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    25ac:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    25ae:	bls.s 2626 <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    25b0:	move.w (a0)+,d0
    25b2:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    25b4:	rol.l #6,d0
	move.w	d0,d1
    25b6:	move.w d0,d1
	and.w	d4,d1
    25b8:	and.w d4,d1
	eor.w	d1,d0
    25ba:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    25bc:	movem.w (2620 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    25c2:	rol.l d2,d0
	and.w	d0,d3					|scaling
    25c4:	and.w d0,d3
	eor.w	d3,d0
    25c6:	eor.w d3,d0
	suba.w	d3,a4
    25c8:	suba.w d3,a4
	adda.l	a1,a4
    25ca:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    25cc:	tst.w d0
    25ce:	bne.s 25d4 <_doynaxdepack_asm+0x48>
    25d0:	move.w (a0)+,d0
    25d2:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    25d4:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    25d6:	beq.s 25ee <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    25d8:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    25da:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    25dc:	bpl.s 25ea <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    25de:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    25e0:	bpl.s 25e8 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    25e2:	addx.b d1,d1
	lsl.l	#2,d0
    25e4:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    25e6:	bmi.s 25e2 <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    25e8:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    25ea:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    25ec:	bcc.s 25f0 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    25ee:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    25f0:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    25f2:	dbf d1,25ee <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    25f6:	add.l d0,d0
	bcc.s	.Lmatch
    25f8:	bcc.s 25a8 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    25fa:	tst.w d0
    25fc:	bne.s 2602 <_doynaxdepack_asm+0x76>
    25fe:	move.w (a0)+,d0
    2600:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    2602:	moveq #0,d1
	add.l	d0,d0
    2604:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    2606:	bcc.s 25a6 <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    2608:	bpl.s 2610 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    260a:	addx.b d1,d1
	lsl.l	#2,d0
    260c:	lsl.l #2,d0
	bmi.s	.Llgetlen
    260e:	bmi.s 260a <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    2610:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    2612:	dbv.s d1,259a <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    2616:	add.l d0,d0
	eor.w	d1,d0		
    2618:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    261a:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    261c:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    261e:	bra.s 2612 <_doynaxdepack_asm+0x86>

00002620 <doy_table>:
    2620:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    2630:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    2640:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    2650:	.............o
