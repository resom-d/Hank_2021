
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
       4:	move.l #24576,d3
       a:	subi.l #24576,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	moveq #0,d2
      14:	bra.s 2a <_start+0x2a>
		__preinit_array_start[i]();
      16:	move.l d2,d0
      18:	add.l d2,d0
      1a:	add.l d0,d0
      1c:	lea 6000 <NextPlot>,a0
      22:	movea.l (0,a0,d0.l),a0
      26:	jsr (a0)
	for (i = 0; i < count; i++)
      28:	addq.l #1,d2
      2a:	cmp.l d2,d3
      2c:	bhi.s 16 <_start+0x16>

	count = __init_array_end - __init_array_start;
      2e:	move.l #24576,d3
      34:	subi.l #24576,d3
      3a:	asr.l #2,d3
	for (i = 0; i < count; i++)
      3c:	moveq #0,d2
      3e:	bra.s 54 <_start+0x54>
		__init_array_start[i]();
      40:	move.l d2,d0
      42:	add.l d2,d0
      44:	add.l d0,d0
      46:	lea 6000 <NextPlot>,a0
      4c:	movea.l (0,a0,d0.l),a0
      50:	jsr (a0)
	for (i = 0; i < count; i++)
      52:	addq.l #1,d2
      54:	cmp.l d2,d3
      56:	bhi.s 40 <_start+0x40>

	main();
      58:	jsr 35b8 <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
      5e:	move.l #24576,d2
      64:	subi.l #24576,d2
      6a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      6c:	bra.s 82 <_start+0x82>
		__fini_array_start[i - 1]();
      6e:	subq.l #1,d2
      70:	move.l d2,d0
      72:	add.l d2,d0
      74:	add.l d0,d0
      76:	lea 6000 <NextPlot>,a0
      7c:	movea.l (0,a0,d0.l),a0
      80:	jsr (a0)
	for (i = count; i > 0; i--)
      82:	tst.l d2
      84:	bne.s 6e <_start+0x6e>
}
      86:	move.l (sp)+,d2
      88:	move.l (sp)+,d3
      8a:	rts

0000008c <IntroLoop>:
void DissolveLogo(short mode);
int p61Init(const void *module);
void p61Music(void);
void p61End(void);

inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
      8c:	move.b bfe001 <_end+0xbbaee5>,d0
	}
}

void IntroLoop()
{
	while (!MouseLeft())
      92:	btst #6,d0
      96:	bne.s 8c <IntroLoop>
	{
	}
}
      98:	rts

0000009a <MoveBobs>:

void MoveBobs()
{
      9a:	move.l d3,-(sp)
      9c:	move.l d2,-(sp)
	switch (BobPhase)
      9e:	move.w 42e5c <BobPhase>,d0
      a4:	beq.s 112 <MoveBobs+0x78>
      a6:	cmpi.w #1,d0
      aa:	beq.w 1ee <MoveBobs+0x154>
			BobPhase = 0;
			*copPF1BmpP = 1 << 6; // prio. in bplcon2: pf2 >> pf 1 >> sprites
		}
		break;
	}
}
      ae:	move.l (sp)+,d2
      b0:	move.l (sp)+,d3
      b2:	rts
				BobTarget[b].X += BobVecs[b].X;
      b4:	lea 6006 <BobVecs>,a1
      ba:	move.l d0,d3
      bc:	lsl.l #3,d3
      be:	movea.l d3,a0
      c0:	add.l (0,a1,d3.l),d1
      c4:	lea 6046 <BobTarget>,a1
      ca:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X > 320 + 32)
      ce:	cmpi.l #352,d1
      d4:	ble.s de <MoveBobs+0x44>
					BobTarget[b].X = 320 + 32;
      d6:	move.l #352,(0,a1,d3.l)
{
      de:	move.l d2,d0
		for (int b = 0; b < BOBSN - 1; b++)
      e0:	moveq #6,d1
      e2:	cmp.l d0,d1
      e4:	blt.s 116 <MoveBobs+0x7c>
			if ((BobTarget[b + 1].X - BobTarget[b].X) > 34 || BobTarget[b + 1].X >= 320 + 32)
      e6:	move.l d0,d2
      e8:	addq.l #1,d2
      ea:	lea 6046 <BobTarget>,a0
      f0:	move.l d2,d1
      f2:	lsl.l #3,d1
      f4:	movea.l (0,a0,d1.l),a1
      f8:	move.l d0,d1
      fa:	lsl.l #3,d1
      fc:	move.l (0,a0,d1.l),d1
     100:	movea.l a1,a0
     102:	suba.l d1,a0
     104:	moveq #34,d3
     106:	cmp.l a0,d3
     108:	blt.s b4 <MoveBobs+0x1a>
     10a:	cmpa.w #351,a1
     10e:	ble.s de <MoveBobs+0x44>
     110:	bra.s b4 <MoveBobs+0x1a>
	switch (BobPhase)
     112:	moveq #0,d0
     114:	bra.s e0 <MoveBobs+0x46>
		BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
     116:	move.l 603e <BobVecs+0x38>,d1
     11c:	move.l d1,d0
     11e:	add.l 607e <BobTarget+0x38>,d0
     124:	move.l d0,607e <BobTarget+0x38>
		if (BobTarget[BOBSN - 1].X > 320+32)
     12a:	cmpi.l #352,d0
     130:	ble.s 13c <MoveBobs+0xa2>
			BobTarget[BOBSN - 1].X = 320+32;
     132:	move.l #352,607e <BobTarget+0x38>
		if (BobTarget[0].X >= 320+32)
     13c:	cmpi.l #351,6046 <BobTarget>
     146:	ble.w ae <MoveBobs+0x14>
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
			BobPhase = 1;
     17c:	move.w #1,42e5c <BobPhase>
			BobPause = 2 * 50;
     184:	move.w #100,42e5e <BobPause>
			*copPF1BmpP = 0 << 6; // prio. in bplcon2: pf1 >> pf 2 >> sprites
     18c:	movea.l 42e58 <copPF1BmpP>,a0
     192:	clr.w (a0)
     194:	bra.w ae <MoveBobs+0x14>
				BobTarget[b].X += BobVecs[b].X;
     198:	lea 6006 <BobVecs>,a1
     19e:	move.l d0,d3
     1a0:	lsl.l #3,d3
     1a2:	movea.l d3,a0
     1a4:	add.l (0,a1,d3.l),d1
     1a8:	lea 6046 <BobTarget>,a1
     1ae:	move.l d1,(0,a0,a1.l)
				if (BobTarget[b].X < 0)
     1b2:	bmi.s 1e8 <MoveBobs+0x14e>
	switch (BobPhase)
     1b4:	move.l d2,d0
		for (int b = 0; b < BOBSN - 1; b++)
     1b6:	moveq #6,d1
     1b8:	cmp.l d0,d1
     1ba:	blt.s 1f2 <MoveBobs+0x158>
			if ((BobTarget[b].X - BobTarget[b + 1].X) > 34 || BobTarget[b + 1].X <= 0)
     1bc:	lea 6046 <BobTarget>,a0
     1c2:	move.l d0,d1
     1c4:	lsl.l #3,d1
     1c6:	move.l (0,a0,d1.l),d1
     1ca:	move.l d0,d2
     1cc:	addq.l #1,d2
     1ce:	move.l d2,d3
     1d0:	lsl.l #3,d3
     1d2:	movea.l (0,a0,d3.l),a0
     1d6:	movea.l d1,a1
     1d8:	suba.l a0,a1
     1da:	moveq #34,d3
     1dc:	cmp.l a1,d3
     1de:	blt.s 198 <MoveBobs+0xfe>
     1e0:	cmpa.w #0,a0
     1e4:	bgt.s 1b4 <MoveBobs+0x11a>
     1e6:	bra.s 198 <MoveBobs+0xfe>
					BobTarget[b].X = 0;
     1e8:	clr.l (0,a1,d3.l)
     1ec:	bra.s 1b4 <MoveBobs+0x11a>
	switch (BobPhase)
     1ee:	moveq #0,d0
     1f0:	bra.s 1b6 <MoveBobs+0x11c>
		BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
     1f2:	move.l 603e <BobVecs+0x38>,d1
     1f8:	move.l d1,d0
     1fa:	add.l 607e <BobTarget+0x38>,d0
     200:	move.l d0,607e <BobTarget+0x38>
		if (BobTarget[BOBSN - 1].X < 0)
     206:	bmi.s 260 <MoveBobs+0x1c6>
		if (BobTarget[0].X <= 0)
     208:	tst.l 6046 <BobTarget>
     20e:	bgt.w ae <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     212:	neg.l 6006 <BobVecs>
			BobVecs[1].X *= -1;
     218:	neg.l 600e <BobVecs+0x8>
			BobVecs[2].X *= -1;
     21e:	neg.l 6016 <BobVecs+0x10>
			BobVecs[3].X *= -1;
     224:	neg.l 601e <BobVecs+0x18>
			BobVecs[4].X *= -1;
     22a:	neg.l 6026 <BobVecs+0x20>
			BobVecs[5].X *= -1;
     230:	neg.l 602e <BobVecs+0x28>
			BobVecs[6].X *= -1;
     236:	neg.l 6036 <BobVecs+0x30>
			BobVecs[7].X *= -1;
     23c:	neg.l d1
     23e:	move.l d1,603e <BobVecs+0x38>
			BobPause = 2 * 50;
     244:	move.w #100,42e5e <BobPause>
			BobPhase = 0;
     24c:	clr.w 42e5c <BobPhase>
			*copPF1BmpP = 1 << 6; // prio. in bplcon2: pf2 >> pf 1 >> sprites
     252:	movea.l 42e58 <copPF1BmpP>,a0
     258:	move.w #64,(a0)
     25c:	bra.w ae <MoveBobs+0x14>
			BobTarget[BOBSN - 1].X = 0;
     260:	clr.l 607e <BobTarget+0x38>
     266:	bra.s 208 <MoveBobs+0x16e>

00000268 <EnableMirrorEffect>:

void EnableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2),
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
     268:	move.w 42f1e <BmpScroller+0x8>,d0
     26e:	move.w d0,d1
     270:	sub.w 430de <Screen+0x6>,d1
     276:	add.w d0,d0
     278:	sub.w d0,d1
	copSetBplMod(0, copMirrorBmpP,
     27a:	movea.l 42e54 <copMirrorBmpP>,a0
}

inline USHORT *copSetBplMod(UBYTE bplPtrStart, USHORT *copListEnd, USHORT modOdd, USHORT modEven)
{
    //set bitplane modulo
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     280:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     284:	move.w d1,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     288:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     28e:	move.w d1,6(a0)
}
     292:	rts

00000294 <DisableMirrorEffect>:

void DisableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 BmpScroller.Bplt - Screen.Bpl,
				 BmpScroller.Bplt - Screen.Bpl);
     294:	move.w 42f1e <BmpScroller+0x8>,d0
     29a:	sub.w 430de <Screen+0x6>,d0
	copSetBplMod(0, copMirrorBmpP,
     2a0:	movea.l 42e54 <copMirrorBmpP>,a0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     2a6:	move.w #264,(a0)
    *copListEnd++ = modOdd;
     2aa:	move.w d0,2(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     2ae:	move.w #266,4(a0)
    *copListEnd++ = modEven;
     2b4:	move.w d0,6(a0)
}
     2b8:	rts

000002ba <PlotChar>:
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
	}
}

void PlotChar(BmpDescriptor bmpFont, BmpDescriptor bmpDest, USHORT plotY, USHORT charW, USHORT charH)
{
     2ba:	movem.l d2-d6/a2/a6,-(sp)
     2be:	move.l 136(sp),d5
     2c2:	move.l 140(sp),d3
     2c6:	move.l 144(sp),d4
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     2ca:	move.w 42e50 <ScrolltextCnt>,d0
     2d0:	move.w d0,d1
     2d2:	addq.w #1,d1
     2d4:	move.w d1,42e50 <ScrolltextCnt>
     2da:	andi.l #65535,d0
     2e0:	lea 5677 <Scrolltext>,a0
     2e6:	move.b (0,a0,d0.l),d0
	ULONG source, dest;
	ULONG row, col;

	// Set standard char distance
	NextPlot = 32;
     2ea:	move.w #32,6000 <NextPlot>
	// scroller commands: b=bounce; m=mirror; s=stop; c=color
	if (chr == 'b')
     2f2:	cmpi.b #98,d0
     2f6:	beq.w 44a <PlotChar+0x190>
		}
		BounceEnabled = !BounceEnabled;

		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'm')
     2fa:	cmpi.b #109,d0
     2fe:	beq.w 494 <PlotChar+0x1da>
		}

		MirrorEnabled = !MirrorEnabled;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 's')
     302:	cmpi.b #115,d0
     306:	beq.w 4dc <PlotChar+0x222>
	{
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
		chr = Scrolltext[ScrolltextCnt++];
	}		
	if (chr == 'c')
     30a:	cmpi.b #99,d0
     30e:	beq.w 562 <PlotChar+0x2a8>
		colScrollMirror[0] = 0x6bf;
		colScrollMirror[1] = 0x49b;
		ResetCopper = TRUE;
	}
	// select character for different spacing
	if (chr == '!' || chr == 'I' || chr == '.' || chr == ',' || chr == ':' || chr == ';' || chr == '\'')
     312:	cmpi.b #33,d0
     316:	beq.s 33c <PlotChar+0x82>
     318:	cmpi.b #73,d0
     31c:	beq.s 33c <PlotChar+0x82>
     31e:	cmpi.b #46,d0
     322:	beq.s 33c <PlotChar+0x82>
     324:	cmpi.b #44,d0
     328:	beq.s 33c <PlotChar+0x82>
     32a:	cmpi.b #58,d0
     32e:	beq.s 33c <PlotChar+0x82>
     330:	cmpi.b #59,d0
     334:	beq.s 33c <PlotChar+0x82>
     336:	cmpi.b #39,d0
     33a:	bne.s 344 <PlotChar+0x8a>
	{
		NextPlot = 12;
     33c:	move.w #12,6000 <NextPlot>
	}
	if (chr == 'J')
     344:	cmpi.b #74,d0
     348:	beq.w 57e <PlotChar+0x2c4>
	{
		NextPlot = 24;
	}
	// check for end of text
	if (chr == 0)
     34c:	tst.b d0
     34e:	bne.s 378 <PlotChar+0xbe>
	{
		ScrolltextCnt = 0;
     350:	clr.w 42e50 <ScrolltextCnt>
		chr = Scrolltext[ScrolltextCnt++];
     356:	move.w #1,42e50 <ScrolltextCnt>
		colScrollMirror[0] = 0x111;
     35e:	move.w #273,6002 <colScrollMirror>
		colScrollMirror[1] = 0x222;
     366:	move.w #546,6004 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     36e:	move.w #1,42e6a <ResetCopper>
		chr = Scrolltext[ScrolltextCnt++];
     376:	moveq #32,d0
	}
	// check legal values
	if (chr < 32 || chr > (32 + 80))
     378:	addi.b #-32,d0
     37c:	cmpi.b #80,d0
     380:	bhi.w 444 <PlotChar+0x18a>
		return;
	}
	// skip first 32 ascii codes
	chr -= 32;
	// get row and column of source bitmap (10 chrs per row)
	row = chr / 10;
     384:	andi.w #255,d0
     388:	move.w d0,d6
     38a:	mulu.w #-13107,d6
     38e:	clr.w d6
     390:	swap d6
     392:	lsr.w #3,d6
	col = chr % 10;
     394:	move.w d6,d1
     396:	add.w d6,d1
     398:	add.w d1,d1
     39a:	add.w d6,d1
     39c:	add.w d1,d1
     39e:	sub.w d1,d0
     3a0:	moveq #0,d2
     3a2:	move.b d0,d2
	// calc source bitplane pointer
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     3a4:	moveq #0,d0
     3a6:	move.w 40(sp),d0
     3aa:	lea 3ae8 <__mulsi3>,a2
     3b0:	moveq #31,d1
     3b2:	and.l d6,d1
     3b4:	move.l d1,-(sp)
     3b6:	move.l d0,-(sp)
     3b8:	jsr (a2)
     3ba:	addq.l #8,sp
     3bc:	move.l d0,-(sp)
     3be:	move.w d4,-(sp)
     3c0:	clr.w -(sp)
     3c2:	jsr (a2)
     3c4:	addq.l #8,sp
     3c6:	add.l d2,d2
     3c8:	add.l d2,d2
     3ca:	add.l d0,d2
	// calc destination bitplane pointer
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     3cc:	moveq #0,d0
     3ce:	move.w 92(sp),d0
     3d2:	move.l d0,-(sp)
     3d4:	move.w d5,-(sp)
     3d6:	clr.w -(sp)
     3d8:	jsr (a2)
     3da:	addq.l #8,sp
     3dc:	moveq #0,d5
     3de:	move.w 430de <Screen+0x6>,d5
     3e4:	add.l d0,d5
	// wait for blitter and blit
	WaitBlit();
     3e6:	movea.l 4310e <GfxBase>,a6
     3ec:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     3f0:	movea.l 43118 <custom>,a0
     3f6:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     3fc:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     402:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     408:	move.w #-1,70(a0)
	custom->bltapt = ((UBYTE *)bmpFont.ImageData) + source;
     40e:	add.l 46(sp),d2
     412:	move.l d2,80(a0)
	custom->bltdpt = ((UBYTE *)bmpDest.ImageData) + dest;
     416:	add.l 98(sp),d5
     41a:	move.l d5,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     41e:	move.w d3,d0
     420:	lsr.w #3,d0
     422:	move.w 38(sp),d1
     426:	sub.w d0,d1
     428:	move.w d1,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     42c:	move.w 90(sp),d1
     430:	sub.w d0,d1
     432:	move.w d1,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     436:	muls.w 36(sp),d4
     43a:	lsl.w #6,d4
     43c:	lsr.w #4,d3
     43e:	add.w d4,d3
     440:	move.w d3,88(a0)
}
     444:	movem.l (sp)+,d2-d6/a2/a6
     448:	rts
		if (BounceEnabled)
     44a:	move.w 42e68 <BounceEnabled>,d0
     450:	beq.s 468 <PlotChar+0x1ae>
			ScrollerY = SCRT_MIN;
     452:	clr.w 42e66 <ScrollerY>
			ScrollerDir = 1;
     458:	move.b #1,6088 <ScrollerDir>
			ScrollerMax = 4;
     460:	move.w #4,6086 <ScrollerMax>
		BounceEnabled = !BounceEnabled;
     468:	tst.w d0
     46a:	seq d0
     46c:	ext.w d0
     46e:	neg.w d0
     470:	move.w d0,42e68 <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     476:	move.w d1,d0
     478:	addq.w #1,d0
     47a:	move.w d0,42e50 <ScrolltextCnt>
     480:	andi.l #65535,d1
     486:	lea 5677 <Scrolltext>,a0
     48c:	move.b (0,a0,d1.l),d0
     490:	bra.w 2fa <PlotChar+0x40>
		if (MirrorEnabled)
     494:	tst.w 42e4e <MirrorEnabled>
     49a:	beq.s 4d6 <PlotChar+0x21c>
			DisableMirrorEffect();
     49c:	jsr 294 <DisableMirrorEffect>(pc)
		MirrorEnabled = !MirrorEnabled;
     4a0:	tst.w 42e4e <MirrorEnabled>
     4a6:	seq d0
     4a8:	ext.w d0
     4aa:	neg.w d0
     4ac:	move.w d0,42e4e <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     4b2:	move.w 42e50 <ScrolltextCnt>,d0
     4b8:	move.w d0,d1
     4ba:	addq.w #1,d1
     4bc:	move.w d1,42e50 <ScrolltextCnt>
     4c2:	andi.l #65535,d0
     4c8:	lea 5677 <Scrolltext>,a0
     4ce:	move.b (0,a0,d0.l),d0
     4d2:	bra.w 302 <PlotChar+0x48>
			EnableMirrorEffect();
     4d6:	jsr 268 <EnableMirrorEffect>(pc)
     4da:	bra.s 4a0 <PlotChar+0x1e6>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     4dc:	tst.w 42e68 <BounceEnabled>
     4e2:	beq.s 534 <PlotChar+0x27a>
     4e4:	move.w 42e50 <ScrolltextCnt>,d0
     4ea:	move.w d0,d1
     4ec:	addq.w #1,d1
     4ee:	move.w d1,42e50 <ScrolltextCnt>
     4f4:	andi.l #65535,d0
     4fa:	lea 5677 <Scrolltext>,a0
     500:	move.b (0,a0,d0.l),d0
     504:	ext.w d0
     506:	addi.w #-48,d0
     50a:	move.w d0,42e64 <ScrollerPause>
		chr = Scrolltext[ScrolltextCnt++];
     510:	move.w 42e50 <ScrolltextCnt>,d0
     516:	move.w d0,d1
     518:	addq.w #1,d1
     51a:	move.w d1,42e50 <ScrolltextCnt>
     520:	andi.l #65535,d0
     526:	lea 5677 <Scrolltext>,a0
     52c:	move.b (0,a0,d0.l),d0
     530:	bra.w 30a <PlotChar+0x50>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     534:	move.w 42e50 <ScrolltextCnt>,d0
     53a:	move.w d0,d1
     53c:	addq.w #1,d1
     53e:	move.w d1,42e50 <ScrolltextCnt>
     544:	andi.l #65535,d0
     54a:	lea 5677 <Scrolltext>,a0
     550:	move.b (0,a0,d0.l),d0
     554:	ext.w d0
     556:	movea.w d0,a0
     558:	moveq #-48,d0
     55a:	add.l a0,d0
     55c:	muls.w #50,d0
     560:	bra.s 50a <PlotChar+0x250>
		colScrollMirror[0] = 0x6bf;
     562:	move.w #1727,6002 <colScrollMirror>
		colScrollMirror[1] = 0x49b;
     56a:	move.w #1179,6004 <colScrollMirror+0x2>
		ResetCopper = TRUE;
     572:	move.w #1,42e6a <ResetCopper>
     57a:	bra.w 312 <PlotChar+0x58>
		NextPlot = 24;
     57e:	move.w #24,6000 <NextPlot>
     586:	bra.w 34c <PlotChar+0x92>

0000058a <Scrollit>:
{
     58a:	movem.l d2-d7/a2/a6,-(sp)
     58e:	move.l 96(sp),d3
     592:	move.l 100(sp),d4
	int BltOffs = startY * theDesc.Bplt;
     596:	moveq #0,d5
     598:	move.w 94(sp),d5
     59c:	moveq #0,d6
     59e:	move.w 44(sp),d6
     5a2:	lea 3ae8 <__mulsi3>,a2
     5a8:	move.l d6,-(sp)
     5aa:	move.l d5,-(sp)
     5ac:	jsr (a2)
     5ae:	addq.l #8,sp
     5b0:	move.l d0,d2
	int Brcorner = height * theDesc.Bplt - 2;
     5b2:	move.l d6,-(sp)
     5b4:	move.w d3,-(sp)
     5b6:	clr.w -(sp)
     5b8:	jsr (a2)
     5ba:	addq.l #8,sp
     5bc:	move.l d0,d7
     5be:	subq.l #2,d7
	WaitBlit();
     5c0:	movea.l 4310e <GfxBase>,a6
     5c6:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     5ca:	clr.w d6
     5cc:	move.b d4,d6
     5ce:	moveq #12,d0
     5d0:	lsl.w d0,d4
     5d2:	movea.l 43118 <custom>,a0
     5d8:	addi.w #2544,d4
     5dc:	move.w d4,64(a0)
	custom->bltcon1 = 0x0002;
     5e0:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     5e6:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     5ec:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     5f2:	move.l d2,d0
     5f4:	add.l d7,d0
     5f6:	add.l 88(sp),d0
     5fa:	move.l d0,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     5fe:	move.l d0,84(a0)
	custom->bltamod = 0;
     602:	move.w #0,100(a0)
	custom->bltdmod = 0;
     608:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
     60e:	move.w 40(sp),d0
     612:	muls.w d3,d0
     614:	lsl.w #6,d0
     616:	move.w 42f16 <BmpScroller>,d1
     61c:	lsr.w #4,d1
     61e:	add.w d1,d0
     620:	move.w d0,88(a0)
	ScrollCnt += speed;
     624:	add.w 42e52 <ScrollCnt>,d6
     62a:	move.w d6,42e52 <ScrollCnt>
	if (ScrollCnt >= NextPlot)
     630:	cmp.w 6000 <NextPlot>,d6
     636:	bcc.s 63e <Scrollit+0xb4>
}
     638:	movem.l (sp)+,d2-d7/a2/a6
     63c:	rts
		ScrollCnt = 0;
     63e:	clr.w 42e52 <ScrollCnt>
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
     644:	pea 20 <_start+0x20>
     648:	pea 20 <_start+0x20>
     64c:	move.l d5,-(sp)
     64e:	subq.l #2,sp
     650:	move.l 42f44 <BmpScroller+0x2e>,-(sp)
     656:	move.l 42f40 <BmpScroller+0x2a>,-(sp)
     65c:	move.l 42f3c <BmpScroller+0x26>,-(sp)
     662:	move.l 42f38 <BmpScroller+0x22>,-(sp)
     668:	move.l 42f34 <BmpScroller+0x1e>,-(sp)
     66e:	move.l 42f30 <BmpScroller+0x1a>,-(sp)
     674:	move.l 42f2c <BmpScroller+0x16>,-(sp)
     67a:	move.l 42f28 <BmpScroller+0x12>,-(sp)
     680:	move.l 42f24 <BmpScroller+0xe>,-(sp)
     686:	move.l 42f20 <BmpScroller+0xa>,-(sp)
     68c:	move.l 42f1c <BmpScroller+0x6>,-(sp)
     692:	move.l 42f18 <BmpScroller+0x2>,-(sp)
     698:	move.w 42f16 <BmpScroller>,-(sp)
     69e:	subq.l #2,sp
     6a0:	move.l 42f12 <BmpFont32+0x2e>,-(sp)
     6a6:	move.l 42f0e <BmpFont32+0x2a>,-(sp)
     6ac:	move.l 42f0a <BmpFont32+0x26>,-(sp)
     6b2:	move.l 42f06 <BmpFont32+0x22>,-(sp)
     6b8:	move.l 42f02 <BmpFont32+0x1e>,-(sp)
     6be:	move.l 42efe <BmpFont32+0x1a>,-(sp)
     6c4:	move.l 42efa <BmpFont32+0x16>,-(sp)
     6ca:	move.l 42ef6 <BmpFont32+0x12>,-(sp)
     6d0:	move.l 42ef2 <BmpFont32+0xe>,-(sp)
     6d6:	move.l 42eee <BmpFont32+0xa>,-(sp)
     6dc:	move.l 42eea <BmpFont32+0x6>,-(sp)
     6e2:	move.l 42ee6 <BmpFont32+0x2>,-(sp)
     6e8:	move.w 42ee4 <BmpFont32>,-(sp)
     6ee:	jsr 2ba <PlotChar>(pc)
     6f2:	lea 116(sp),sp
     6f6:	bra.w 638 <Scrollit+0xae>

000006fa <GetVBR>:

static APTR GetVBR()
{
     6fa:	subq.l #8,sp
     6fc:	move.l a6,-(sp)
     6fe:	move.l d7,-(sp)
	APTR vbr = 0;
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     700:	move.w #20090,10(sp)
     706:	move.w #2049,12(sp)
     70c:	move.w #20083,14(sp)

	if (SysBase->AttnFlags & AFF_68010)
     712:	movea.l 43112 <SysBase>,a6
     718:	btst #0,297(a6)
     71e:	beq.s 734 <GetVBR+0x3a>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     720:	moveq #10,d7
     722:	add.l sp,d7
     724:	exg d7,a5
     726:	jsr -30(a6)
     72a:	exg d7,a5

	return vbr;
}
     72c:	move.l (sp)+,d7
     72e:	movea.l (sp)+,a6
     730:	addq.l #8,sp
     732:	rts
	APTR vbr = 0;
     734:	moveq #0,d0
	return vbr;
     736:	bra.s 72c <GetVBR+0x32>

00000738 <SetInterruptHandler>:

void SetInterruptHandler(APTR interrupt)
{
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     738:	movea.l 42e4a <VBR>,a0
     73e:	move.l 4(sp),108(a0)
}
     744:	rts

00000746 <GetInterruptHandler>:

APTR GetInterruptHandler()
{
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     746:	movea.l 42e4a <VBR>,a0
     74c:	move.l 108(a0),d0
}
     750:	rts

00000752 <WaitVbl>:

//vblank begins at vpos 312 hpos 1 and ends at vpos 25 hpos 1
//vsync begins at line 2 hpos 132 and ends at vpos 5 hpos 18
void WaitVbl()
{
     752:	subq.l #8,sp
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     754:	move.l dff004 <_end+0xdbbee8>,d0
     75a:	move.l d0,(sp)
		vpos &= 0x1ff00;
     75c:	move.l (sp),d0
     75e:	andi.l #130816,d0
     764:	move.l d0,(sp)
		if (vpos != (311 << 8))
     766:	move.l (sp),d0
     768:	cmpi.l #79616,d0
     76e:	beq.s 754 <WaitVbl+0x2>
			break;
	}
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     770:	move.l dff004 <_end+0xdbbee8>,d0
     776:	move.l d0,4(sp)
		vpos &= 0x1ff00;
     77a:	move.l 4(sp),d0
     77e:	andi.l #130816,d0
     784:	move.l d0,4(sp)
		if (vpos == (311 << 8))
     788:	move.l 4(sp),d0
     78c:	cmpi.l #79616,d0
     792:	bne.s 770 <WaitVbl+0x1e>
			break;
	}
}
     794:	addq.l #8,sp
     796:	rts

00000798 <TakeSystem>:
	{
	} //blitter busy wait
}

void TakeSystem()
{
     798:	move.l a6,-(sp)
     79a:	move.l a2,-(sp)
	ActiView = GfxBase->ActiView; //store current view
     79c:	movea.l 4310e <GfxBase>,a6
     7a2:	move.l 34(a6),42e46 <ActiView>
	OwnBlitter();
     7aa:	jsr -456(a6)
	WaitBlit();
     7ae:	movea.l 4310e <GfxBase>,a6
     7b4:	jsr -228(a6)
	Disable();
     7b8:	movea.l 43112 <SysBase>,a6
     7be:	jsr -120(a6)

	//Save current interrupts and DMA settings so we can restore them upon exit.
	SystemADKCON = custom->adkconr;
     7c2:	movea.l 43118 <custom>,a0
     7c8:	move.w 16(a0),d0
     7cc:	move.w d0,42e44 <SystemADKCON>
	SystemInts = custom->intenar;
     7d2:	move.w 28(a0),d0
     7d6:	move.w d0,42e42 <SystemInts>
	SystemDMA = custom->dmaconr;
     7dc:	move.w 2(a0),d0
     7e0:	move.w d0,42e40 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     7e6:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     7ec:	move.w #32767,156(a0)

	WaitVbl();
     7f2:	lea 752 <WaitVbl>(pc),a2
     7f6:	jsr (a2)
	WaitVbl();
     7f8:	jsr (a2)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     7fa:	movea.l 43118 <custom>,a0
     800:	move.w #32767,150(a0)

	//set all colors black
	for (int a = 0; a < 32; a++)
     806:	moveq #0,d1
     808:	bra.s 81c <TakeSystem+0x84>
		custom->color[a] = 0;
     80a:	move.l d1,d0
     80c:	addi.l #192,d0
     812:	add.l d0,d0
     814:	move.w #0,(0,a0,d0.l)
	for (int a = 0; a < 32; a++)
     81a:	addq.l #1,d1
     81c:	moveq #31,d0
     81e:	cmp.l d1,d0
     820:	bge.s 80a <TakeSystem+0x72>

	LoadView(0);
     822:	movea.l 4310e <GfxBase>,a6
     828:	suba.l a1,a1
     82a:	jsr -222(a6)
	WaitTOF();
     82e:	movea.l 4310e <GfxBase>,a6
     834:	jsr -270(a6)
	WaitTOF();
     838:	movea.l 4310e <GfxBase>,a6
     83e:	jsr -270(a6)

	WaitVbl();
     842:	lea 752 <WaitVbl>(pc),a2
     846:	jsr (a2)
	WaitVbl();
     848:	jsr (a2)

	VBR = GetVBR();
     84a:	jsr 6fa <GetVBR>(pc)
     84e:	move.l d0,42e4a <VBR>
	SystemIrq = GetInterruptHandler(); //store interrupt register
     854:	jsr 746 <GetInterruptHandler>(pc)
     858:	move.l d0,42e3c <SystemIrq>
}
     85e:	movea.l (sp)+,a2
     860:	movea.l (sp)+,a6
     862:	rts

00000864 <FreeSystem>:

void FreeSystem()
{
     864:	move.l a6,-(sp)
	WaitVbl();
     866:	jsr 752 <WaitVbl>(pc)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     86a:	movea.l 43118 <custom>,a0
     870:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     874:	move.w 2(a0),d0
     878:	btst #14,d0
     87c:	bne.s 874 <FreeSystem+0x10>
	WaitBlt();
	custom->intena = 0x7fff; //disable all interrupts
     87e:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     884:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     88a:	move.w #32767,150(a0)

	//restore interrupts
	SetInterruptHandler(SystemIrq);
     890:	move.l 42e3c <SystemIrq>,-(sp)
     896:	jsr 738 <SetInterruptHandler>(pc)

	/*Restore system copper list(s). */
	custom->cop1lc = (ULONG)GfxBase->copinit;
     89a:	movea.l 4310e <GfxBase>,a6
     8a0:	movea.l 43118 <custom>,a0
     8a6:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     8ac:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     8b2:	move.w #32767,136(a0)

	/*Restore all interrupts and DMA settings. */
	custom->intena = SystemInts | 0x8000;
     8b8:	move.w 42e42 <SystemInts>,d0
     8be:	ori.w #-32768,d0
     8c2:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     8c6:	move.w 42e40 <SystemDMA>,d0
     8cc:	ori.w #-32768,d0
     8d0:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     8d4:	move.w 42e44 <SystemADKCON>,d0
     8da:	ori.w #-32768,d0
     8de:	move.w d0,158(a0)

	LoadView(ActiView);
     8e2:	movea.l 42e46 <ActiView>,a1
     8e8:	jsr -222(a6)
	WaitTOF();
     8ec:	movea.l 4310e <GfxBase>,a6
     8f2:	jsr -270(a6)
	WaitTOF();
     8f6:	movea.l 4310e <GfxBase>,a6
     8fc:	jsr -270(a6)
	WaitBlit();
     900:	movea.l 4310e <GfxBase>,a6
     906:	jsr -228(a6)
	DisownBlitter();
     90a:	movea.l 4310e <GfxBase>,a6
     910:	jsr -462(a6)
	Enable();
     914:	movea.l 43112 <SysBase>,a6
     91a:	jsr -126(a6)
     91e:	addq.l #4,sp
}
     920:	movea.l (sp)+,a6
     922:	rts

00000924 <InitImagePlanes>:

void InitImagePlanes(BmpDescriptor *img, USHORT offs)
{
     924:	movem.l d2-d4/a2,-(sp)
     928:	movea.l 20(sp),a2
     92c:	move.w 26(sp),d4
	for (int p = 0; p < img->Bpls; p++)
     930:	moveq #0,d2
     932:	bra.s 95e <InitImagePlanes+0x3a>
	{
		img->Planes[p] = ((UBYTE *)img->ImageData) + offs + (p * (img->Bpl));
     934:	move.l 14(a2),d3
     938:	moveq #0,d0
     93a:	move.w 6(a2),d0
     93e:	move.l d2,-(sp)
     940:	move.l d0,-(sp)
     942:	jsr 3ae8 <__mulsi3>
     948:	addq.l #8,sp
     94a:	moveq #0,d1
     94c:	move.w d4,d1
     94e:	add.l d1,d0
     950:	move.l d2,d1
     952:	add.l d2,d1
     954:	add.l d1,d1
     956:	add.l d0,d3
     958:	move.l d3,(18,a2,d1.l)
	for (int p = 0; p < img->Bpls; p++)
     95c:	addq.l #1,d2
     95e:	moveq #0,d0
     960:	move.w 4(a2),d0
     964:	cmp.l d0,d2
     966:	blt.s 934 <InitImagePlanes+0x10>
	}
}
     968:	movem.l (sp)+,d2-d4/a2
     96c:	rts

0000096e <copSetPlanesInterleafed>:

USHORT *copSetPlanesInterleafed(UBYTE bplPtrStart, USHORT *copListEnd, const UBYTE *bitmap, int numPlanes, int Bpl, int offsY)
{
     96e:	movem.l d2-d5/a2-a3,-(sp)
     972:	movea.l 32(sp),a2
     976:	move.l 40(sp),d2
     97a:	move.l 44(sp),d3
     97e:	move.b 31(sp),d4
	ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     982:	lea 3ae8 <__mulsi3>,a3
     988:	move.l d3,-(sp)
     98a:	move.l 52(sp),-(sp)
     98e:	jsr (a3)
     990:	addq.l #8,sp
     992:	move.l d2,-(sp)
     994:	move.l d0,-(sp)
     996:	jsr (a3)
     998:	addq.l #8,sp
     99a:	add.l 36(sp),d0
	for (USHORT i = 0; i < numPlanes; i++)
     99e:	suba.l a0,a0
     9a0:	bra.s 9ce <copSetPlanesInterleafed+0x60>
	{
		*copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     9a2:	moveq #0,d5
     9a4:	move.b d4,d5
     9a6:	movea.l d1,a1
     9a8:	lea (56,a1,d5.l),a1
     9ac:	move.l a1,d1
     9ae:	add.w a1,d1
     9b0:	add.w d1,d1
     9b2:	move.w d1,(a2)
		*copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     9b4:	move.l d0,d5
     9b6:	clr.w d5
     9b8:	swap d5
     9ba:	move.w d5,2(a2)
		*copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     9be:	addq.w #2,d1
     9c0:	move.w d1,4(a2)
		*copListEnd++ = (UWORD)addr; // high-word of adress
     9c4:	move.w d0,6(a2)
		addr += Bpl;
     9c8:	add.l d3,d0
	for (USHORT i = 0; i < numPlanes; i++)
     9ca:	addq.w #1,a0
		*copListEnd++ = (UWORD)addr; // high-word of adress
     9cc:	addq.l #8,a2
	for (USHORT i = 0; i < numPlanes; i++)
     9ce:	moveq #0,d1
     9d0:	move.w a0,d1
     9d2:	cmp.l d1,d2
     9d4:	bgt.s 9a2 <copSetPlanesInterleafed+0x34>
	}
	return copListEnd;
}
     9d6:	move.l a2,d0
     9d8:	movem.l (sp)+,d2-d5/a2-a3
     9dc:	rts

000009de <SetupCopperIntro>:
{
     9de:	move.l a2,-(sp)
     9e0:	movea.l 8(sp),a1
	*copPtr++ = DIWSTRT;
     9e4:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     9e8:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     9ee:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     9f4:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     9fa:	move.w #146,8(a1)
	*copPtr++ = 0x38;
     a00:	move.w #56,10(a1)
	*copPtr++ = DDFSTOP;
     a06:	move.w #148,12(a1)
	*copPtr++ = 0xd0;
     a0c:	move.w #208,14(a1)
	copPtr = copSetBplMod(0, copPtr, BmpMuerte.Bplt - Screen.Bpl, BmpMuerte.Bplt - Screen.Bpl);
     a12:	move.w 430ae <BmpMuerte+0x8>,d0
     a18:	sub.w 430de <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     a1e:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     a24:	move.w d0,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     a28:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     a2e:	move.w d0,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     a32:	move.w #258,24(a1)
	*copPtr++ = 0;
     a38:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     a3c:	move.w #260,28(a1)
	*copPtr++ = 0 << 6; //pf2 >> pf 1 >> sprites
     a42:	lea 32(a1),a0
     a46:	clr.w 30(a1)
	for (int a = 0; a < 32; a++)
     a4a:	moveq #0,d0
     a4c:	bra.s a6c <SetupCopperIntro+0x8e>
		copPtr = copSetColor(copPtr, a, muertePaletteRGB4[a]);
     a4e:	movea.l d0,a1
     a50:	adda.l d0,a1
    *copListEnd++ = COP_SKIP;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     a52:	move.w d0,d1
     a54:	addi.w #192,d1
     a58:	add.w d1,d1
     a5a:	move.w d1,(a0)
    *copListCurrent++ = color;
     a5c:	lea 5e90 <muertePaletteRGB4>,a2
     a62:	move.w (0,a2,a1.l),2(a0)
	for (int a = 0; a < 32; a++)
     a68:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, muertePaletteRGB4[a]);
     a6a:	addq.l #4,a0
	for (int a = 0; a < 32; a++)
     a6c:	moveq #31,d1
     a6e:	cmp.l d0,d1
     a70:	bge.s a4e <SetupCopperIntro+0x70>
	copPtr = copSetPlanesInterleafed(0, copPtr, BmpMuerte.Planes[0], BmpMuerte.Bpls, BmpMuerte.Bpl, 0);
     a72:	clr.l -(sp)
     a74:	moveq #0,d0
     a76:	move.w 430ac <BmpMuerte+0x6>,d0
     a7c:	move.l d0,-(sp)
     a7e:	moveq #0,d0
     a80:	move.w 430aa <BmpMuerte+0x4>,d0
     a86:	move.l d0,-(sp)
     a88:	move.l 430b8 <BmpMuerte+0x12>,-(sp)
     a8e:	move.l a0,-(sp)
     a90:	clr.l -(sp)
     a92:	jsr 96e <copSetPlanesInterleafed>(pc)
     a96:	movea.l d0,a0
	*copPtr++ = SPR0PTH;
     a98:	move.w #288,(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     a9c:	move.l #272470,d0
     aa2:	move.l d0,d1
     aa4:	swap d1
     aa6:	ext.l d1
     aa8:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
     aac:	move.w #290,4(a0)
	*copPtr++ = (LONG)NullSprite;
     ab2:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
     ab6:	move.w #292,8(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     abc:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
     ac0:	move.w #294,12(a0)
	*copPtr++ = (LONG)NullSprite;
     ac6:	move.w d0,14(a0)
	*copPtr++ = SPR2PTH;
     aca:	move.w #296,16(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     ad0:	move.w d1,18(a0)
	*copPtr++ = SPR2PTL;
     ad4:	move.w #298,20(a0)
	*copPtr++ = (LONG)NullSprite;
     ada:	move.w d0,22(a0)
	*copPtr++ = SPR3PTH;
     ade:	move.w #300,24(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     ae4:	move.w d1,26(a0)
	*copPtr++ = SPR3PTL;
     ae8:	move.w #302,28(a0)
	*copPtr++ = (LONG)NullSprite;
     aee:	move.w d0,30(a0)
	*copPtr++ = SPR4PTH;
     af2:	move.w #304,32(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     af8:	move.w d1,34(a0)
	*copPtr++ = SPR4PTL;
     afc:	move.w #306,36(a0)
	*copPtr++ = (LONG)NullSprite;
     b02:	move.w d0,38(a0)
	*copPtr++ = SPR5PTH;
     b06:	move.w #308,40(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     b0c:	move.w d1,42(a0)
	*copPtr++ = SPR5PTL;
     b10:	move.w #310,44(a0)
	*copPtr++ = (LONG)NullSprite;
     b16:	move.w d0,46(a0)
	*copPtr++ = SPR6PTH;
     b1a:	move.w #312,48(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     b20:	move.w d1,50(a0)
	*copPtr++ = SPR6PTL;
     b24:	move.w #314,52(a0)
	*copPtr++ = (LONG)NullSprite;
     b2a:	move.w d0,54(a0)
	*copPtr++ = SPR7PTH;
     b2e:	move.w #316,56(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     b34:	move.w d1,58(a0)
	*copPtr++ = SPR7PTL;
     b38:	move.w #318,60(a0)
	*copPtr++ = (LONG)NullSprite;
     b3e:	move.w d0,62(a0)
	*copPtr++ = BPLCON0;
     b42:	move.w #256,64(a0)
	*copPtr++ = ((BmpMuerte.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     b48:	moveq #0,d0
     b4a:	move.w 430aa <BmpMuerte+0x4>,d0
     b50:	moveq #12,d1
     b52:	lsl.l d1,d0
     b54:	ori.w #512,d0
     b58:	move.w d0,66(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     b5c:	move.w #-1,68(a0)
    *copListEnd++ = COP_WAIT;
     b62:	move.w #-2,70(a0)
     b68:	lea 24(sp),sp
}
     b6c:	movea.l (sp)+,a2
     b6e:	rts

00000b70 <copSetPlanesInterleafedOddEven>:

USHORT *copSetPlanesInterleafedOddEven(UBYTE bplPtrStart, USHORT *copListEnd, const UBYTE *bitmap, int numPlanes, int Bpl, int offsY, BOOL odd)
{
     b70:	movem.l d2-d6/a2-a3,-(sp)
     b74:	movea.l 36(sp),a2
     b78:	move.l 44(sp),d3
     b7c:	move.l 48(sp),d4
     b80:	move.b 35(sp),d5
	ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     b84:	lea 3ae8 <__mulsi3>,a3
     b8a:	move.l d4,-(sp)
     b8c:	move.l 56(sp),-(sp)
     b90:	jsr (a3)
     b92:	addq.l #8,sp
     b94:	move.l d3,-(sp)
     b96:	move.l d0,-(sp)
     b98:	jsr (a3)
     b9a:	addq.l #8,sp
     b9c:	add.l 40(sp),d0
	BYTE plane = odd ? 1 : 0;
     ba0:	tst.w 58(sp)
     ba4:	sne d2
     ba6:	neg.b d2
	for (USHORT i = 0; i < numPlanes; i++)
     ba8:	suba.l a0,a0
     baa:	bra.s be0 <copSetPlanesInterleafedOddEven+0x70>
	{
		*copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     bac:	move.b d2,d6
     bae:	ext.w d6
     bb0:	moveq #0,d1
     bb2:	move.b d5,d1
     bb4:	movea.w d6,a1
     bb6:	movea.l d1,a3
     bb8:	lea (56,a1,a3.l),a1
     bbc:	move.l a1,d1
     bbe:	add.w a1,d1
     bc0:	add.w d1,d1
     bc2:	move.w d1,(a2)
		*copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     bc4:	move.l d0,d6
     bc6:	clr.w d6
     bc8:	swap d6
     bca:	move.w d6,2(a2)
		*copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     bce:	addq.w #2,d1
     bd0:	move.w d1,4(a2)
		*copListEnd++ = (UWORD)addr; // high-word of adress
     bd4:	move.w d0,6(a2)
		addr += Bpl;
     bd8:	add.l d4,d0
		plane += 2;
     bda:	addq.b #2,d2
	for (USHORT i = 0; i < numPlanes; i++)
     bdc:	addq.w #1,a0
		*copListEnd++ = (UWORD)addr; // high-word of adress
     bde:	addq.l #8,a2
	for (USHORT i = 0; i < numPlanes; i++)
     be0:	moveq #0,d1
     be2:	move.w a0,d1
     be4:	cmp.l d1,d3
     be6:	bgt.s bac <copSetPlanesInterleafedOddEven+0x3c>
	}
	return copListEnd;
}
     be8:	move.l a2,d0
     bea:	movem.l (sp)+,d2-d6/a2-a3
     bee:	rts

00000bf0 <SetupCopper>:
{
     bf0:	move.l a2,-(sp)
     bf2:	move.l d2,-(sp)
     bf4:	movea.l 12(sp),a1
	*copPtr++ = DIWSTRT;
     bf8:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     bfc:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     c02:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     c08:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     c0e:	move.w #146,8(a1)
	*copPtr++ = 0x38;
     c14:	move.w #56,10(a1)
	*copPtr++ = DDFSTOP;
     c1a:	move.w #148,12(a1)
	*copPtr++ = 0xd0;
     c20:	move.w #208,14(a1)
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - Screen.Bpl, BmpUpperPart_PF2.Bplt - Screen.Bpl);
     c26:	move.w 430de <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     c2c:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     c32:	move.w 42fb4 <BmpUpperPart_PF1+0x8>,d1
     c38:	sub.w d0,d1
     c3a:	move.w d1,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     c3e:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     c44:	movea.w 42f82 <BmpUpperPart_PF2+0x8>,a0
     c4a:	suba.w d0,a0
     c4c:	move.w a0,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     c50:	move.w #258,24(a1)
	*copPtr++ = 0;
     c56:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     c5a:	move.w #260,28(a1)
	copPF1BmpP = copPtr;
     c60:	lea 30(a1),a2
     c64:	move.l a2,42e58 <copPF1BmpP>
	*copPtr++ = BobPhase == 0 ? 1 << 6 : 0; //pf2 >> pf 1 >> sprites
     c6a:	tst.w 42e5c <BobPhase>
     c70:	bne.s c9e <SetupCopper+0xae>
     c72:	moveq #64,d0
     c74:	move.w d0,30(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c78:	move.w #384,32(a1)
    *copListCurrent++ = color;
     c7e:	move.w #21,34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     c84:	move.w #400,36(a1)
    *copListCurrent++ = color;
     c8a:	lea 40(a1),a0
     c8e:	move.w #21,38(a1)
	copPF1ColP = copPtr;
     c94:	move.l a0,42e6c <copPF1ColP>
	for (int a = 1; a < 8; a++)
     c9a:	moveq #1,d0
     c9c:	bra.s cc0 <SetupCopper+0xd0>
	*copPtr++ = BobPhase == 0 ? 1 << 6 : 0; //pf2 >> pf 1 >> sprites
     c9e:	clr.w d0
     ca0:	bra.s c74 <SetupCopper+0x84>
		copPtr = copSetColor(copPtr, a, ActPfCol[a]);
     ca2:	move.l d0,d1
     ca4:	add.l d0,d1
     ca6:	movea.l 60ca <ActPfCol>,a1
     cac:	move.w (0,a1,d1.l),2(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     cb2:	move.w d0,d1
     cb4:	addi.w #192,d1
     cb8:	add.w d1,d1
     cba:	move.w d1,(a0)
	for (int a = 1; a < 8; a++)
     cbc:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, ActPfCol[a]);
     cbe:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     cc0:	moveq #7,d1
     cc2:	cmp.l d0,d1
     cc4:	bge.s ca2 <SetupCopper+0xb2>
	for (int a = 9; a < 16; a++)
     cc6:	moveq #9,d0
     cc8:	bra.s cea <SetupCopper+0xfa>
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     cca:	move.l d0,d1
     ccc:	subq.l #8,d1
     cce:	add.l d1,d1
     cd0:	movea.w d0,a1
     cd2:	lea 192(a1),a1
     cd6:	adda.w a1,a1
     cd8:	move.w a1,(a0)
    *copListCurrent++ = color;
     cda:	lea 5ee0 <CookiePaletteRGB4>,a1
     ce0:	move.w (0,a1,d1.l),2(a0)
	for (int a = 9; a < 16; a++)
     ce6:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     ce8:	addq.l #4,a0
	for (int a = 9; a < 16; a++)
     cea:	moveq #15,d1
     cec:	cmp.l d0,d1
     cee:	bge.s cca <SetupCopper+0xda>
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.Planes[0], BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
     cf0:	clr.l -(sp)
     cf2:	clr.l -(sp)
     cf4:	moveq #0,d0
     cf6:	move.w 42fb2 <BmpUpperPart_PF1+0x6>,d0
     cfc:	move.l d0,-(sp)
     cfe:	moveq #0,d0
     d00:	move.w 42fb0 <BmpUpperPart_PF1+0x4>,d0
     d06:	move.l d0,-(sp)
     d08:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
     d0e:	move.l a0,-(sp)
     d10:	clr.l -(sp)
     d12:	lea b70 <copSetPlanesInterleafedOddEven>(pc),a2
     d16:	jsr (a2)
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.Planes[0], BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
     d18:	pea 1 <_start+0x1>
     d1c:	clr.l -(sp)
     d1e:	moveq #0,d1
     d20:	move.w 42f80 <BmpUpperPart_PF2+0x6>,d1
     d26:	move.l d1,-(sp)
     d28:	moveq #0,d1
     d2a:	move.w 42f7e <BmpUpperPart_PF2+0x4>,d1
     d30:	move.l d1,-(sp)
     d32:	move.l 42f8c <BmpUpperPart_PF2+0x12>,-(sp)
     d38:	move.l d0,-(sp)
     d3a:	clr.l -(sp)
     d3c:	jsr (a2)
     d3e:	movea.l d0,a0
	*copPtr++ = SPR0PTH;
     d40:	move.w #288,(a0)
	*copPtr++ = (LONG)StarSprite >> 16;
     d44:	move.l #273230,d0
     d4a:	move.l d0,d1
     d4c:	swap d1
     d4e:	ext.l d1
     d50:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
     d54:	move.w #290,4(a0)
	*copPtr++ = (LONG)StarSprite;
     d5a:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
     d5e:	move.w #292,8(a0)
	*copPtr++ = (LONG)StarSprite2 >> 16;
     d64:	move.l #272482,d0
     d6a:	move.l d0,d1
     d6c:	swap d1
     d6e:	ext.l d1
     d70:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
     d74:	move.w #294,12(a0)
	*copPtr++ = (LONG)StarSprite2;
     d7a:	move.w d0,14(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     d7e:	move.w #418,16(a0)
    *copListCurrent++ = color;
     d84:	move.w #2120,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     d8a:	move.w #420,20(a0)
    *copListCurrent++ = color;
     d90:	move.w #143,22(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     d96:	move.w #422,24(a0)
    *copListCurrent++ = color;
     d9c:	move.w #4095,26(a0)
	*copPtr++ = SPR2PTH;
     da2:	move.w #296,28(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     da8:	move.l #272470,d0
     dae:	move.l d0,d1
     db0:	swap d1
     db2:	ext.l d1
     db4:	move.w d1,30(a0)
	*copPtr++ = SPR2PTL;
     db8:	move.w #298,32(a0)
	*copPtr++ = (LONG)NullSprite;
     dbe:	move.w d0,34(a0)
	*copPtr++ = SPR3PTH;
     dc2:	move.w #300,36(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     dc8:	move.w d1,38(a0)
	*copPtr++ = SPR3PTL;
     dcc:	move.w #302,40(a0)
	*copPtr++ = (LONG)NullSprite;
     dd2:	move.w d0,42(a0)
	*copPtr++ = SPR4PTH;
     dd6:	move.w #304,44(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     ddc:	move.w d1,46(a0)
	*copPtr++ = SPR4PTL;
     de0:	move.w #306,48(a0)
	*copPtr++ = (LONG)NullSprite;
     de6:	move.w d0,50(a0)
	*copPtr++ = SPR5PTH;
     dea:	move.w #308,52(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     df0:	move.w d1,54(a0)
	*copPtr++ = SPR5PTL;
     df4:	move.w #310,56(a0)
	*copPtr++ = (LONG)NullSprite;
     dfa:	move.w d0,58(a0)
	*copPtr++ = SPR6PTH;
     dfe:	move.w #312,60(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     e04:	move.w d1,62(a0)
	*copPtr++ = SPR6PTL;
     e08:	move.w #314,64(a0)
	*copPtr++ = (LONG)NullSprite;
     e0e:	move.w d0,66(a0)
	*copPtr++ = SPR7PTH;
     e12:	move.w #316,68(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     e18:	move.w d1,70(a0)
	*copPtr++ = SPR7PTL;
     e1c:	move.w #318,72(a0)
	*copPtr++ = (LONG)NullSprite;
     e22:	move.w d0,74(a0)
	*copPtr++ = BPLCON0;
     e26:	move.w #256,76(a0)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     e2c:	moveq #0,d0
     e2e:	move.w 43078 <BmpLogo+0x4>,d0
     e34:	add.l d0,d0
     e36:	moveq #12,d1
     e38:	lsl.l d1,d0
     e3a:	ori.w #1536,d0
     e3e:	move.w d0,78(a0)
	line = 0x2c + BmpUpperPart_PF1.Height;
     e42:	move.b 42faf <BmpUpperPart_PF1+0x3>,d0
     e48:	addi.b #44,d0
	copPtr = copWaitY(copPtr, line++);
     e4c:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     e52:	lsl.l #8,d0
     e54:	ori.w #5,d0
     e58:	move.w d0,80(a0)
    *copListEnd++ = COP_WAIT;
     e5c:	move.w #-2,82(a0)
	*copPtr++ = BPLCON0;
     e62:	move.w #256,84(a0)
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     e68:	move.w #512,86(a0)
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
     e6e:	move.b 42faf <BmpUpperPart_PF1+0x3>,d0
     e74:	addi.b #52,d0
	copPtr = copWaitY(copPtr, line++);
     e78:	move.b 42faf <BmpUpperPart_PF1+0x3>,d2
     e7e:	addi.b #53,d2
     e82:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     e88:	lsl.l #8,d0
     e8a:	ori.w #5,d0
     e8e:	move.w d0,88(a0)
    *copListEnd++ = COP_WAIT;
     e92:	lea 92(a0),a1
     e96:	move.w #-2,90(a0)
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
     e9c:	move.l a1,42e60 <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
     ea2:	lea 56(sp),sp
     ea6:	clr.l -(sp)
     ea8:	moveq #0,d0
     eaa:	move.w 42f1c <BmpScroller+0x6>,d0
     eb0:	move.l d0,-(sp)
     eb2:	moveq #0,d0
     eb4:	move.w 42f1a <BmpScroller+0x4>,d0
     eba:	move.l d0,-(sp)
     ebc:	move.l 42f24 <BmpScroller+0xe>,-(sp)
     ec2:	move.l a1,-(sp)
     ec4:	clr.l -(sp)
     ec6:	jsr 96e <copSetPlanesInterleafed>(pc)
     eca:	movea.l d0,a1
						  BmpScroller.Bplt - Screen.Bpl);
     ecc:	move.w 42f1e <BmpScroller+0x8>,d0
     ed2:	sub.w 430de <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     ed8:	move.w #264,(a1)
    *copListEnd++ = modOdd;
     edc:	move.w d0,2(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     ee0:	move.w #266,4(a1)
    *copListEnd++ = modEven;
     ee6:	move.w d0,6(a1)
	*copPtr++ = BPLCON0;
     eea:	move.w #256,8(a1)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     ef0:	moveq #0,d0
     ef2:	move.w 43078 <BmpLogo+0x4>,d0
     ef8:	moveq #12,d1
     efa:	lsl.l d1,d0
     efc:	lea 12(a1),a0
     f00:	ori.w #512,d0
     f04:	move.w d0,10(a1)
     f08:	lea 24(sp),sp
	for (int a = 1; a < 8; a++)
     f0c:	moveq #1,d0
     f0e:	bra.s f2e <SetupCopper+0x33e>
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     f10:	movea.l d0,a1
     f12:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     f14:	move.w d0,d1
     f16:	addi.w #192,d1
     f1a:	add.w d1,d1
     f1c:	move.w d1,(a0)
    *copListCurrent++ = color;
     f1e:	lea 5ed0 <FontPaletteRGB4>,a2
     f24:	move.w (0,a2,a1.l),2(a0)
	for (int a = 1; a < 8; a++)
     f2a:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
     f2c:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     f2e:	moveq #7,d1
     f30:	cmp.l d0,d1
     f32:	bge.s f10 <SetupCopper+0x320>
	for (int l = 0; l < 24; l++)
     f34:	moveq #0,d0
     f36:	bra.s f66 <SetupCopper+0x376>
		copPtr = copWaitY(copPtr, line);
     f38:	moveq #0,d1
     f3a:	move.b d2,d1
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     f3c:	lsl.l #8,d1
     f3e:	ori.w #5,d1
     f42:	move.w d1,(a0)
    *copListEnd++ = COP_WAIT;
     f44:	move.w #-2,2(a0)
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     f4a:	move.l d0,d1
     f4c:	add.l d0,d1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     f4e:	move.w #384,4(a0)
    *copListCurrent++ = color;
     f54:	lea 5ef0 <colgradbluePaletteRGB4>,a1
     f5a:	move.w (0,a1,d1.l),6(a0)
		line += 2;
     f60:	addq.b #2,d2
	for (int l = 0; l < 24; l++)
     f62:	addq.l #1,d0
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
     f64:	addq.l #8,a0
	for (int l = 0; l < 24; l++)
     f66:	moveq #23,d1
     f68:	cmp.l d0,d1
     f6a:	bge.s f38 <SetupCopper+0x348>
	copPtr = copWaitY(copPtr, line++);
     f6c:	move.b d2,d0
     f6e:	addq.b #1,d0
     f70:	moveq #0,d1
     f72:	move.b d2,d1
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     f74:	lsl.l #8,d1
     f76:	ori.w #5,d1
     f7a:	move.w d1,(a0)
    *copListEnd++ = COP_WAIT;
     f7c:	move.w #-2,2(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
     f82:	move.w 6002 <colScrollMirror>,d1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     f88:	move.w #384,4(a0)
    *copListCurrent++ = color;
     f8e:	move.w d1,6(a0)
	copPtr = copWaitY(copPtr, line++);
     f92:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     f98:	lsl.l #8,d0
     f9a:	ori.w #5,d0
     f9e:	move.w d0,8(a0)
    *copListEnd++ = COP_WAIT;
     fa2:	move.w #-2,10(a0)
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
     fa8:	movea.w 6004 <colScrollMirror+0x2>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     fae:	move.w #384,12(a0)
    *copListCurrent++ = color;
     fb4:	move.w a1,14(a0)
	line += 7;
     fb8:	move.b d2,d0
     fba:	addi.b #9,d0
	copPtr = copWaitY(copPtr, line++);
     fbe:	addi.b #10,d2
     fc2:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     fc8:	lsl.l #8,d0
     fca:	ori.w #5,d0
     fce:	move.w d0,16(a0)
    *copListEnd++ = COP_WAIT;
     fd2:	move.w #-2,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     fd8:	move.w #384,20(a0)
    *copListCurrent++ = color;
     fde:	move.w d1,22(a0)
	copPtr = copWaitY(copPtr, line++);
     fe2:	andi.l #255,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     fe8:	lsl.l #8,d2
     fea:	ori.w #5,d2
     fee:	move.w d2,24(a0)
    *copListEnd++ = COP_WAIT;
     ff2:	move.w #-2,26(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ff8:	move.w #384,28(a0)
    *copListCurrent++ = color;
     ffe:	move.w a1,30(a0)
	line = 0x2c + BmpLogo.Height + 72 + 7; // 209
    1002:	move.b 43077 <BmpLogo+0x3>,d0
    1008:	addi.b #123,d0
	copPtr = copWaitY(copPtr, line++);
    100c:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    1012:	lsl.l #8,d0
    1014:	ori.w #5,d0
    1018:	move.w d0,32(a0)
    *copListEnd++ = COP_WAIT;
    101c:	move.w #-2,34(a0)
	copMirrorBmpP = copPtr;
    1022:	lea 36(a0),a2
    1026:	move.l a2,42e54 <copMirrorBmpP>
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
    102c:	move.w 4307c <BmpLogo+0x8>,d0
    1032:	sub.w 4307a <BmpLogo+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    1038:	move.w #264,36(a0)
    *copListEnd++ = modOdd;
    103e:	move.w d0,38(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    1042:	move.w #266,40(a0)
    *copListEnd++ = modEven;
    1048:	move.w d0,42(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    104c:	move.w #386,44(a0)
    *copListCurrent++ = color;
    1052:	move.w #4032,46(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    1058:	move.w #-31,48(a0)
    *copListEnd++ = COP_WAIT;
    105e:	move.w #-2,50(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    1064:	move.w #1285,52(a0)
    *copListEnd++ = COP_WAIT;
    106a:	move.w #-2,54(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    1070:	move.w #384,56(a0)
    *copListCurrent++ = color;
    1076:	move.w d1,58(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    107a:	move.w #1541,60(a0)
    *copListEnd++ = COP_WAIT;
    1080:	move.w #-2,62(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    1086:	move.w #384,64(a0)
    *copListCurrent++ = color;
    108c:	move.w a1,66(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    1090:	move.w #11269,68(a0)
    *copListEnd++ = COP_WAIT;
    1096:	move.w #-2,70(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    109c:	move.w #384,72(a0)
    *copListCurrent++ = color;
    10a2:	move.w d1,74(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    10a6:	move.w #11525,76(a0)
    *copListEnd++ = COP_WAIT;
    10ac:	move.w #-2,78(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    10b2:	move.w #384,80(a0)
    *copListCurrent++ = color;
    10b8:	move.w a1,82(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    10bc:	move.w #-1,84(a0)
    *copListEnd++ = COP_WAIT;
    10c2:	move.w #-2,86(a0)
}
    10c8:	move.l (sp)+,d2
    10ca:	movea.l (sp)+,a2
    10cc:	rts

000010ce <CopyBitmapPart>:
	custom->bltdmod = 0;
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
}

void CopyBitmapPart(BmpDescriptor bmpS, BmpDescriptor bmpD, USHORT startY, USHORT stopY)
{
    10ce:	movem.l d2-d3/a2,-(sp)
    10d2:	move.l 120(sp),d3
    10d6:	move.l 124(sp),d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    10da:	movea.l 43118 <custom>,a2
    10e0:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    10e4:	move.w 2(a2),d0
    10e8:	btst #14,d0
    10ec:	bne.s 10e4 <CopyBitmapPart+0x16>
	WaitBlt();

	custom->bltcon0 = 0x09f0;
    10ee:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
    10f4:	move.w #0,66(a2)
	custom->bltapt = (UBYTE *)bmpS.ImageData + (startY * bmpS.Bplt);
    10fa:	moveq #0,d0
    10fc:	move.w 24(sp),d0
    1100:	move.l d0,-(sp)
    1102:	move.w d3,-(sp)
    1104:	clr.w -(sp)
    1106:	jsr 3ae8 <__mulsi3>
    110c:	addq.l #8,sp
    110e:	move.l 30(sp),d1
    1112:	add.l d0,d1
    1114:	move.l d1,80(a2)
	custom->bltdpt = (UBYTE *)bmpD.ImageData + (startY * bmpS.Bplt);
    1118:	add.l 82(sp),d0
    111c:	move.l d0,84(a2)
	custom->bltafwm = 0xffff;
    1120:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    1126:	move.w #-1,70(a2)
	custom->bltamod = 0;
    112c:	move.w #0,100(a2)
	custom->bltdmod = 0;
    1132:	move.w #0,102(a2)
	custom->bltsize = (((stopY - startY) * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
    1138:	sub.w d3,d2
    113a:	muls.w 20(sp),d2
    113e:	lsl.w #6,d2
    1140:	move.w 22(sp),d0
    1144:	lsr.w #1,d0
    1146:	add.w d0,d2
    1148:	move.w d2,88(a2)
}
    114c:	movem.l (sp)+,d2-d3/a2
    1150:	rts

00001152 <ClearBitmapPart>:
	custom->bltdmod = 0;
	custom->bltsize = ((lines * bmpD.Bpls) << 6) + (bmpD.Width / 16);
}

void ClearBitmapPart(BmpDescriptor bmp, int x, int y, int height, int width)
{
    1152:	movem.l d2-d5/a2-a3,-(sp)
    1156:	move.l 80(sp),d5
    115a:	movea.l 92(sp),a3
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    115e:	movea.l 43118 <custom>,a2
    1164:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1168:	move.w 2(a2),d0
    116c:	btst #14,d0
    1170:	bne.s 1168 <ClearBitmapPart+0x16>
	WaitBlt();
	BYTE shift = x % 16;
    1172:	move.l d5,d2
    1174:	andi.l #-2147483633,d2
    117a:	tst.l d5
    117c:	blt.w 1218 <ClearBitmapPart+0xc6>
	if (shift)
    1180:	tst.b d2
    1182:	beq.s 1188 <ClearBitmapPart+0x36>
		width += 16;
    1184:	lea 16(a3),a3
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1188:	move.b d2,d0
    118a:	ext.w d0
    118c:	move.w d0,d4
    118e:	ext.l d4
    1190:	move.l d4,d1
    1192:	moveq #12,d3
    1194:	lsl.l d3,d1
    1196:	ori.w #2304,d1
    119a:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    119e:	moveq #12,d1
    11a0:	lsl.w d1,d0
    11a2:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    11a6:	move.l 42(sp),d3
    11aa:	moveq #0,d0
    11ac:	move.w 36(sp),d0
    11b0:	move.l 84(sp),-(sp)
    11b4:	move.l d0,-(sp)
    11b6:	jsr 3ae8 <__mulsi3>
    11bc:	addq.l #8,sp
    11be:	move.l d5,d1
    11c0:	bmi.s 1224 <ClearBitmapPart+0xd2>
    11c2:	asr.l #3,d1
    11c4:	add.l d1,d0
    11c6:	add.l d3,d0
    11c8:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    11cc:	move.l d0,84(a2)
	custom->bltafwm = 0xffff;
    11d0:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    11d6:	tst.b d2
    11d8:	beq.s 1228 <ClearBitmapPart+0xd6>
    11da:	moveq #15,d1
    11dc:	sub.l d4,d1
    11de:	moveq #0,d0
    11e0:	not.w d0
    11e2:	asr.l d1,d0
    11e4:	move.w d0,70(a2)
	;
	custom->bltamod = bmp.Bpl - (width / 8);
    11e8:	move.w 34(sp),d0
    11ec:	move.l a3,d1
    11ee:	bmi.s 122c <ClearBitmapPart+0xda>
    11f0:	asr.l #3,d1
    11f2:	sub.w d1,d0
    11f4:	move.w d0,100(a2)
	custom->bltdmod = bmp.Bpl - (width / 8);
    11f8:	move.w d0,102(a2)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    11fc:	move.w 32(sp),d0
    1200:	muls.w 90(sp),d0
    1204:	lsl.w #6,d0
    1206:	move.l a3,d1
    1208:	bmi.s 1230 <ClearBitmapPart+0xde>
    120a:	asr.l #4,d1
    120c:	add.w d1,d0
    120e:	move.w d0,88(a2)
}
    1212:	movem.l (sp)+,d2-d5/a2-a3
    1216:	rts
	BYTE shift = x % 16;
    1218:	subq.l #1,d2
    121a:	moveq #-16,d0
    121c:	or.l d0,d2
    121e:	addq.l #1,d2
    1220:	bra.w 1180 <ClearBitmapPart+0x2e>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1224:	addq.l #7,d1
    1226:	bra.s 11c2 <ClearBitmapPart+0x70>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1228:	moveq #-1,d0
    122a:	bra.s 11e4 <ClearBitmapPart+0x92>
	custom->bltamod = bmp.Bpl - (width / 8);
    122c:	addq.l #7,d1
    122e:	bra.s 11f0 <ClearBitmapPart+0x9e>
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    1230:	moveq #15,d1
    1232:	add.l a3,d1
    1234:	bra.s 120a <ClearBitmapPart+0xb8>

00001236 <SimpleBlit>:

void SimpleBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    1236:	movem.l d2-d7/a2,-(sp)
    123a:	move.l 136(sp),d7
    123e:	move.l 140(sp),d1
    1242:	move.l 144(sp),d4
    1246:	move.l 148(sp),d5
    124a:	move.l 152(sp),d3
    124e:	move.l 156(sp),d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1252:	movea.l 43118 <custom>,a2
    1258:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    125c:	move.w 2(a2),d0
    1260:	btst #14,d0
    1264:	bne.s 125c <SimpleBlit+0x26>
	WaitBlt();
	custom->bltcon0 = 0x09f0;
    1266:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
    126c:	move.w #0,66(a2)
	custom->bltafwm = 0xffff;
    1272:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    1278:	move.w #-1,70(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
    127e:	move.w d2,d0
    1280:	lsr.w #3,d0
    1282:	movea.w 38(sp),a0
    1286:	suba.w d0,a0
    1288:	move.w a0,100(a2)
	custom->bltdmod = imgD.Bpl - (width / 8);
    128c:	movea.w 90(sp),a0
    1290:	suba.w d0,a0
    1292:	move.w a0,102(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    1296:	move.l 46(sp),d6
    129a:	moveq #0,d0
    129c:	move.w 40(sp),d0
    12a0:	move.l d0,-(sp)
    12a2:	move.l d1,-(sp)
    12a4:	jsr 3ae8 <__mulsi3>
    12aa:	addq.l #8,sp
    12ac:	move.l d7,d1
    12ae:	bmi.s 12f2 <SimpleBlit+0xbc>
    12b0:	asr.l #3,d1
    12b2:	add.l d1,d0
    12b4:	add.l d6,d0
    12b6:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    12ba:	move.l 98(sp),d6
    12be:	moveq #0,d0
    12c0:	move.w 92(sp),d0
    12c4:	move.l d0,-(sp)
    12c6:	move.l d5,-(sp)
    12c8:	jsr 3ae8 <__mulsi3>
    12ce:	addq.l #8,sp
    12d0:	move.l d4,d1
    12d2:	bmi.s 12f6 <SimpleBlit+0xc0>
    12d4:	asr.l #3,d1
    12d6:	add.l d1,d0
    12d8:	add.l d6,d0
    12da:	move.l d0,84(a2)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
    12de:	muls.w 36(sp),d3
    12e2:	lsl.w #6,d3
    12e4:	lsr.w #4,d2
    12e6:	add.w d3,d2
    12e8:	move.w d2,88(a2)
}
    12ec:	movem.l (sp)+,d2-d7/a2
    12f0:	rts
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    12f2:	addq.l #7,d1
    12f4:	bra.s 12b0 <SimpleBlit+0x7a>
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    12f6:	addq.l #7,d1
    12f8:	bra.s 12d4 <SimpleBlit+0x9e>

000012fa <BetterBlit>:

void BetterBlit(BmpDescriptor imgS, BmpDescriptor imgD, BmpDescriptor imgM, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    12fa:	movem.l d2-d7/a2-a6,-(sp)
    12fe:	movea.l 204(sp),a3
    1302:	move.l 208(sp),d7
    1306:	move.l 212(sp),d5
    130a:	movea.l 216(sp),a5
    130e:	movea.l 220(sp),a4
    1312:	move.l 224(sp),d1
    1316:	move.w d1,d4
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1318:	movea.l 43118 <custom>,a2
    131e:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1322:	move.w 2(a2),d0
    1326:	btst #14,d0
    132a:	bne.s 1322 <BetterBlit+0x28>
	WaitBlt();
	BYTE shift = startD.X % 16;
    132c:	move.l d5,d3
    132e:	andi.l #-2147483633,d3
    1334:	tst.l d5
    1336:	blt.w 142a <BetterBlit+0x130>
	if (shift)
    133a:	tst.b d3
    133c:	beq.s 1344 <BetterBlit+0x4a>
		width += 16;
    133e:	move.w d1,d4
    1340:	addi.w #16,d4

	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1344:	move.b d3,d0
    1346:	ext.w d0
    1348:	movea.w d0,a6
    134a:	move.l a6,d1
    134c:	moveq #12,d2
    134e:	lsl.l d2,d1
    1350:	ori.w #4042,d1
    1354:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1358:	moveq #12,d1
    135a:	lsl.w d1,d0
    135c:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1360:	move.l 62(sp),d6
    1364:	moveq #0,d0
    1366:	move.w 56(sp),d0
    136a:	move.l d0,-(sp)
    136c:	move.l d7,-(sp)
    136e:	jsr 3ae8 <__mulsi3>
    1374:	addq.l #8,sp
    1376:	move.l a3,d2
    1378:	bmi.w 1436 <BetterBlit+0x13c>
    137c:	asr.l #3,d2
    137e:	add.l d2,d0
    1380:	add.l d6,d0
    1382:	move.l d0,80(a2)
	custom->bltamod = imgS.Bpl - (width / 8);
    1386:	move.w d4,d6
    1388:	lsr.w #3,d6
    138a:	move.w 54(sp),d0
    138e:	sub.w d6,d0
    1390:	move.w d0,100(a2)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    1394:	moveq #0,d0
    1396:	move.w 160(sp),d0
    139a:	lea 3ae8 <__mulsi3>,a3
    13a0:	move.l d0,-(sp)
    13a2:	move.l d7,-(sp)
    13a4:	jsr (a3)
    13a6:	addq.l #8,sp
    13a8:	add.l d0,d2
    13aa:	add.l 166(sp),d2
    13ae:	move.l d2,76(a2)
	custom->bltbmod = imgM.Bpl - (width / 8);
    13b2:	move.w 158(sp),d0
    13b6:	sub.w d6,d0
    13b8:	move.w d0,98(a2)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    13bc:	move.l 114(sp),d2
    13c0:	moveq #0,d0
    13c2:	move.w 108(sp),d0
    13c6:	move.l d0,-(sp)
    13c8:	move.l a5,-(sp)
    13ca:	jsr (a3)
    13cc:	addq.l #8,sp
    13ce:	move.l d5,d1
    13d0:	bmi.s 143c <BetterBlit+0x142>
    13d2:	asr.l #3,d1
    13d4:	add.l d1,d0
    13d6:	add.l d2,d0
    13d8:	move.l d0,84(a2)
    13dc:	move.l d0,72(a2)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    13e0:	move.w 106(sp),d0
    13e4:	sub.w d6,d0
    13e6:	move.w d0,102(a2)
    13ea:	move.w d0,96(a2)
	custom->bltafwm = 0xffff;
    13ee:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    13f4:	tst.b d3
    13f6:	beq.s 1440 <BetterBlit+0x146>
    13f8:	moveq #15,d1
    13fa:	sub.l a6,d1
    13fc:	moveq #0,d0
    13fe:	not.w d0
    1400:	asr.l d1,d0
    1402:	move.w d0,70(a2)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    1406:	moveq #0,d0
    1408:	move.w 52(sp),d0
    140c:	move.l d0,-(sp)
    140e:	move.w a4,-(sp)
    1410:	clr.w -(sp)
    1412:	jsr 3ae8 <__mulsi3>
    1418:	addq.l #8,sp
    141a:	lsl.l #6,d0
    141c:	lsr.w #4,d4
    141e:	or.w d0,d4
    1420:	move.w d4,88(a2)
}
    1424:	movem.l (sp)+,d2-d7/a2-a6
    1428:	rts
	BYTE shift = startD.X % 16;
    142a:	subq.l #1,d3
    142c:	moveq #-16,d0
    142e:	or.l d0,d3
    1430:	addq.l #1,d3
    1432:	bra.w 133a <BetterBlit+0x40>
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1436:	addq.l #7,d2
    1438:	bra.w 137c <BetterBlit+0x82>
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    143c:	addq.l #7,d1
    143e:	bra.s 13d2 <BetterBlit+0xd8>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1440:	moveq #-1,d0
    1442:	bra.s 1402 <BetterBlit+0x108>

00001444 <p61Init>:

int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
    1444:	move.l a3,-(sp)
    1446:	move.l a2,-(sp)
	register volatile const void *_a0 ASM("a0") = module;
    1448:	movea.l 12(sp),a0
	register volatile const void *_a1 ASM("a1") = NULL;
    144c:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
    144e:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
    1450:	lea 3cc6 <incbin_P61_Player_start>,a3
	register int _d0 ASM("d0"); // return value
	__asm volatile(
    1456:	movem.l d1-d7/a4-a6,-(sp)
    145a:	jsr (a3)
    145c:	movem.l (sp)+,d1-d7/a4-a6
		"movem.l (%%sp)+,%%d1-%%d7/%%a4-%%a6"
		: "=r"(_d0), "+rf"(_a0), "+rf"(_a1), "+rf"(_a2), "+rf"(_a3)
		:
		: "cc", "memory");
	return _d0;
}
    1460:	movea.l (sp)+,a2
    1462:	movea.l (sp)+,a3
    1464:	rts

00001466 <p61Music>:

void p61Music()
{
    1466:	move.l a6,-(sp)
    1468:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    146a:	lea 3cc6 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    1470:	movea.l #14675968,a6
	__asm volatile(
    1476:	movem.l d0-a2/a4-a5,-(sp)
    147a:	jsr 4(a3)
    147e:	movem.l (sp)+,d0-a2/a4-a5
		"jsr 4(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d7/%%a0-%%a2/%%a4-%%a5"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    1482:	movea.l (sp)+,a3
    1484:	movea.l (sp)+,a6
    1486:	rts

00001488 <interruptHandler>:
    return copListCurrent;
}
// interrupt handler
static __attribute__((interrupt)) void interruptHandler()
{
    1488:	movem.l d0-d1/a0-a1,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    148c:	movea.l 43118 <custom>,a0
    1492:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    1498:	move.w #32,156(a0)

    // DEMO - ThePlayer
    p61Music();
    149e:	jsr 1466 <p61Music>(pc)

    // DEMO - increment frameCounter
    frameCounter++;
    14a2:	move.w 43116 <frameCounter>,d0
    14a8:	addq.w #1,d0
    14aa:	move.w d0,43116 <frameCounter>
}
    14b0:	movem.l (sp)+,d0-d1/a0-a1
    14b4:	rte

000014b6 <p61End>:

void p61End()
{
    14b6:	move.l a6,-(sp)
    14b8:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    14ba:	lea 3cc6 <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    14c0:	movea.l #14675968,a6
	__asm volatile(
    14c6:	movem.l d0-d1/a0-a1,-(sp)
    14ca:	jsr 8(a3)
    14ce:	movem.l (sp)+,d0-d1/a0-a1
		"jsr 8(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d1/%%a0-%%a1"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    14d2:	movea.l (sp)+,a3
    14d4:	movea.l (sp)+,a6
    14d6:	rts

000014d8 <BitmapInit>:

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{
    14d8:	move.l d3,-(sp)
    14da:	move.l d2,-(sp)
    14dc:	movea.l 12(sp),a0
    14e0:	move.l 16(sp),d0
    14e4:	move.l 20(sp),d2
    14e8:	move.l 24(sp),d1

	bmp->Width = w;
    14ec:	move.w d0,(a0)
	bmp->Height = h;
    14ee:	move.w d2,2(a0)
	bmp->Bpls = bpls;
    14f2:	move.w d1,4(a0)
	bmp->Bpl = w / 8;
    14f6:	lsr.w #3,d0
    14f8:	move.w d0,6(a0)
	bmp->Bplt = w / 8 * bpls;
    14fc:	move.w d0,d3
    14fe:	muls.w d1,d3
    1500:	move.w d3,8(a0)
	bmp->Btot = w / 8 * h * bpls;
    1504:	muls.w d2,d0
    1506:	muls.w d1,d0
    1508:	move.w d0,12(a0)
}
    150c:	move.l (sp)+,d2
    150e:	move.l (sp)+,d3
    1510:	rts

00001512 <InitStarfieldSprite>:

void InitStarfieldSprite()
{
    1512:	movem.l d2-d7/a2-a3,-(sp)
	short line = 0;
	USHORT hpos = 3;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 31; l++)
    1516:	moveq #0,d5
	BYTE vpos = 0x2c;
    1518:	moveq #44,d3
	USHORT hpos = 3;
    151a:	movea.w #3,a1
	short line = 0;
    151e:	clr.w d2
    1520:	bra.w 165a <InitStarfieldSprite+0x148>
	{
		hpos = (7 * hpos) % 255;
    1524:	moveq #0,d0
    1526:	move.w a1,d0
    1528:	move.l d0,d1
    152a:	lsl.l #3,d1
    152c:	lea 3b90 <__modsi3>,a3
    1532:	pea ff <MoveBobs+0x65>
    1536:	sub.l d0,d1
    1538:	move.l d1,-(sp)
    153a:	jsr (a3)
    153c:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    153e:	move.b d3,d1
    1540:	ext.w d1
    1542:	move.w d1,d4
    1544:	ext.l d4
    1546:	lsl.l #8,d4
    1548:	move.w d0,d6
    154a:	andi.w #255,d6
    154e:	movea.w d2,a0
    1550:	addq.w #1,a0
    1552:	movea.w d2,a1
    1554:	lea 42b4e <StarSprite>,a2
    155a:	adda.l a1,a1
    155c:	or.w d4,d6
    155e:	move.w d6,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    1562:	addq.w #1,d1
    1564:	movea.w d2,a1
    1566:	addq.w #2,a1
    1568:	movea.w a0,a0
    156a:	lsl.w #8,d1
    156c:	adda.l a0,a0
    156e:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-1
    1572:	movea.w d2,a0
    1574:	addq.w #3,a0
    1576:	movea.w a1,a1
    1578:	adda.l a1,a1
    157a:	move.w #-32768,(0,a1,a2.l)
		StarSprite[line++] = 0x0000;					  //color-1
    1580:	move.w d2,d6
    1582:	addq.w #4,d6
    1584:	movea.w a0,a0
    1586:	adda.l a0,a0
    1588:	clr.w (0,a0,a2.l)
		vpos += 2;
    158c:	move.b d3,d4
    158e:	addq.b #2,d4

		hpos = (7 * hpos) % 255;
    1590:	andi.l #65535,d0
    1596:	move.l d0,d1
    1598:	lsl.l #3,d1
    159a:	pea ff <MoveBobs+0x65>
    159e:	sub.l d0,d1
    15a0:	move.l d1,-(sp)
    15a2:	jsr (a3)
    15a4:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    15a6:	move.b d4,d1
    15a8:	ext.w d1
    15aa:	move.w d1,d4
    15ac:	ext.l d4
    15ae:	lsl.l #8,d4
    15b0:	move.w d0,d7
    15b2:	andi.w #255,d7
    15b6:	movea.w d2,a0
    15b8:	addq.w #5,a0
    15ba:	movea.w d6,a1
    15bc:	adda.l a1,a1
    15be:	or.w d4,d7
    15c0:	move.w d7,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    15c4:	addq.w #1,d1
    15c6:	movea.w d2,a1
    15c8:	addq.w #6,a1
    15ca:	movea.w a0,a0
    15cc:	lsl.w #8,d1
    15ce:	adda.l a0,a0
    15d0:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x0000;					  //color-2
    15d4:	movea.w d2,a0
    15d6:	addq.w #7,a0
    15d8:	movea.w a1,a1
    15da:	adda.l a1,a1
    15dc:	clr.w (0,a1,a2.l)
		StarSprite[line++] = 0x8000;					  //color-2
    15e0:	addq.w #4,d6
    15e2:	movea.w a0,a0
    15e4:	adda.l a0,a0
    15e6:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    15ec:	move.b d3,d4
    15ee:	addq.b #4,d4

		hpos = (7 * hpos) % 255;
    15f0:	andi.l #65535,d0
    15f6:	move.l d0,d1
    15f8:	lsl.l #3,d1
    15fa:	pea ff <MoveBobs+0x65>
    15fe:	sub.l d0,d1
    1600:	move.l d1,-(sp)
    1602:	jsr (a3)
    1604:	addq.l #8,sp
    1606:	movea.w d0,a1
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    1608:	move.b d4,d1
    160a:	ext.w d1
    160c:	move.w d1,d4
    160e:	ext.l d4
    1610:	lsl.l #8,d4
    1612:	andi.w #255,d0
    1616:	movea.w d2,a3
    1618:	lea 9(a3),a3
    161c:	movea.w d6,a0
    161e:	adda.l a0,a0
    1620:	or.w d4,d0
    1622:	move.w d0,(0,a2,a0.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    1626:	addq.w #1,d1
    1628:	movea.w d2,a0
    162a:	lea 10(a0),a0
    162e:	movea.w a3,a3
    1630:	lsl.w #8,d1
    1632:	adda.l a3,a3
    1634:	move.w d1,(0,a3,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    1638:	movea.w a0,a0
    163a:	adda.l a0,a0
    163c:	move.w #-32768,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    1642:	movea.w d2,a0
    1644:	lea 11(a0),a0
    1648:	movea.w a0,a0
    164a:	addi.w #12,d2
    164e:	adda.l a0,a0
    1650:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    1656:	addq.b #6,d3
	for (int l = 0; l < 31; l++)
    1658:	addq.l #1,d5
    165a:	moveq #30,d0
    165c:	cmp.l d5,d0
    165e:	bge.w 1524 <InitStarfieldSprite+0x12>
	}
	// sprite end-mark
	StarSprite[line++] = 0;
    1662:	move.w d2,d0
    1664:	addq.w #1,d0
    1666:	ext.l d2
    1668:	lea 42b4e <StarSprite>,a1
    166e:	add.l d2,d2
    1670:	clr.w (0,a1,d2.l)
	StarSprite[line++] = 0;
    1674:	movea.w d0,a0
    1676:	adda.l a0,a0
    1678:	clr.w (0,a0,a1.l)

	line = 0;
	hpos = 7;
	vpos = 0x2d;
	for (int l = 0; l < 31; l++)
    167c:	moveq #0,d5
	vpos = 0x2d;
    167e:	moveq #45,d3
	hpos = 7;
    1680:	movea.w #7,a1
	line = 0;
    1684:	clr.w d2
    1686:	bra.w 17c0 <InitStarfieldSprite+0x2ae>
	{
		hpos = (7 * hpos) % 255;
    168a:	moveq #0,d0
    168c:	move.w a1,d0
    168e:	move.l d0,d1
    1690:	lsl.l #3,d1
    1692:	lea 3b90 <__modsi3>,a3
    1698:	pea ff <MoveBobs+0x65>
    169c:	sub.l d0,d1
    169e:	move.l d1,-(sp)
    16a0:	jsr (a3)
    16a2:	addq.l #8,sp
		StarSprite2[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    16a4:	move.b d3,d1
    16a6:	ext.w d1
    16a8:	move.w d1,d4
    16aa:	ext.l d4
    16ac:	lsl.l #8,d4
    16ae:	move.w d0,d6
    16b0:	andi.w #255,d6
    16b4:	movea.w d2,a0
    16b6:	addq.w #1,a0
    16b8:	movea.w d2,a1
    16ba:	lea 42862 <StarSprite2>,a2
    16c0:	adda.l a1,a1
    16c2:	or.w d4,d6
    16c4:	move.w d6,(0,a2,a1.l)
		StarSprite2[line++] = (vpos + 1) << 8 | 0;		   //v-stop, ctrl
    16c8:	addq.w #1,d1
    16ca:	movea.w d2,a1
    16cc:	addq.w #2,a1
    16ce:	movea.w a0,a0
    16d0:	lsl.w #8,d1
    16d2:	adda.l a0,a0
    16d4:	move.w d1,(0,a0,a2.l)
		StarSprite2[line++] = 0x8000;					   //color-1
    16d8:	movea.w d2,a0
    16da:	addq.w #3,a0
    16dc:	movea.w a1,a1
    16de:	adda.l a1,a1
    16e0:	move.w #-32768,(0,a1,a2.l)
		StarSprite2[line++] = 0x0000;					   //color-1
    16e6:	move.w d2,d6
    16e8:	addq.w #4,d6
    16ea:	movea.w a0,a0
    16ec:	adda.l a0,a0
    16ee:	clr.w (0,a0,a2.l)
		vpos += 2;
    16f2:	move.b d3,d4
    16f4:	addq.b #2,d4

		hpos = (7 * hpos) % 255;
    16f6:	andi.l #65535,d0
    16fc:	move.l d0,d1
    16fe:	lsl.l #3,d1
    1700:	pea ff <MoveBobs+0x65>
    1704:	sub.l d0,d1
    1706:	move.l d1,-(sp)
    1708:	jsr (a3)
    170a:	addq.l #8,sp
		StarSprite2[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    170c:	move.b d4,d1
    170e:	ext.w d1
    1710:	move.w d1,d4
    1712:	ext.l d4
    1714:	lsl.l #8,d4
    1716:	move.w d0,d7
    1718:	andi.w #255,d7
    171c:	movea.w d2,a0
    171e:	addq.w #5,a0
    1720:	movea.w d6,a1
    1722:	adda.l a1,a1
    1724:	or.w d4,d7
    1726:	move.w d7,(0,a2,a1.l)
		StarSprite2[line++] = (vpos + 1) << 8 | 0;		   //v-stop, ctrl
    172a:	addq.w #1,d1
    172c:	movea.w d2,a1
    172e:	addq.w #6,a1
    1730:	movea.w a0,a0
    1732:	lsl.w #8,d1
    1734:	adda.l a0,a0
    1736:	move.w d1,(0,a0,a2.l)
		StarSprite2[line++] = 0x0000;					   //color-2
    173a:	movea.w d2,a0
    173c:	addq.w #7,a0
    173e:	movea.w a1,a1
    1740:	adda.l a1,a1
    1742:	clr.w (0,a1,a2.l)
		StarSprite2[line++] = 0x8000;					   //color-2
    1746:	addq.w #4,d6
    1748:	movea.w a0,a0
    174a:	adda.l a0,a0
    174c:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    1752:	move.b d3,d4
    1754:	addq.b #4,d4

		hpos = (7 * hpos) % 255;
    1756:	andi.l #65535,d0
    175c:	move.l d0,d1
    175e:	lsl.l #3,d1
    1760:	pea ff <MoveBobs+0x65>
    1764:	sub.l d0,d1
    1766:	move.l d1,-(sp)
    1768:	jsr (a3)
    176a:	addq.l #8,sp
    176c:	movea.w d0,a1
		StarSprite2[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    176e:	move.b d4,d1
    1770:	ext.w d1
    1772:	move.w d1,d4
    1774:	ext.l d4
    1776:	lsl.l #8,d4
    1778:	andi.w #255,d0
    177c:	movea.w d2,a3
    177e:	lea 9(a3),a3
    1782:	movea.w d6,a0
    1784:	adda.l a0,a0
    1786:	or.w d4,d0
    1788:	move.w d0,(0,a2,a0.l)
		StarSprite2[line++] = (vpos + 1) << 8 | 0;		   //v-stop, ctrl
    178c:	addq.w #1,d1
    178e:	movea.w d2,a0
    1790:	lea 10(a0),a0
    1794:	movea.w a3,a3
    1796:	lsl.w #8,d1
    1798:	adda.l a3,a3
    179a:	move.w d1,(0,a3,a2.l)
		StarSprite2[line++] = 0x8000;					   //color-3
    179e:	movea.w a0,a0
    17a0:	adda.l a0,a0
    17a2:	move.w #-32768,(0,a0,a2.l)
		StarSprite2[line++] = 0x8000;					   //color-3
    17a8:	movea.w d2,a0
    17aa:	lea 11(a0),a0
    17ae:	movea.w a0,a0
    17b0:	addi.w #12,d2
    17b4:	adda.l a0,a0
    17b6:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    17bc:	addq.b #6,d3
	for (int l = 0; l < 31; l++)
    17be:	addq.l #1,d5
    17c0:	moveq #30,d0
    17c2:	cmp.l d5,d0
    17c4:	bge.w 168a <InitStarfieldSprite+0x178>
	}
	// sprite end-mark
	StarSprite2[line++] = 0;
    17c8:	move.w d2,d0
    17ca:	addq.w #1,d0
    17cc:	ext.l d2
    17ce:	lea 42862 <StarSprite2>,a1
    17d4:	add.l d2,d2
    17d6:	clr.w (0,a1,d2.l)
	StarSprite2[line++] = 0;
    17da:	movea.w d0,a0
    17dc:	adda.l a0,a0
    17de:	clr.w (0,a0,a1.l)
}
    17e2:	movem.l (sp)+,d2-d7/a2-a3
    17e6:	rts

000017e8 <MoveStarfield>:

void MoveStarfield()
{
    17e8:	move.l a3,-(sp)
    17ea:	move.l a2,-(sp)
	for (int l = 1; l < 31 * 24; l += 24)
    17ec:	movea.w #1,a0
    17f0:	bra.s 180e <MoveStarfield+0x26>
		((volatile UBYTE *)StarSprite)[l + 16] += 4;
		if (frameCounter % 2)
		{
			((volatile UBYTE *)StarSprite2)[l] += 1;
		}
		((volatile UBYTE *)StarSprite2)[l + 8] += 2;
    17f2:	adda.l #272482,a2
    17f8:	move.b (a2),d0
    17fa:	addq.b #2,d0
    17fc:	move.b d0,(a2)
		((volatile UBYTE *)StarSprite2)[l + 16] += 3;
    17fe:	adda.l #272482,a1
    1804:	move.b (a1),d0
    1806:	addq.b #3,d0
    1808:	move.b d0,(a1)
	for (int l = 1; l < 31 * 24; l += 24)
    180a:	lea 24(a0),a0
    180e:	cmpa.w #743,a0
    1812:	bgt.s 186e <MoveStarfield+0x86>
		if (frameCounter % 4)
    1814:	move.w 43116 <frameCounter>,d0
    181a:	andi.w #3,d0
    181e:	beq.s 182e <MoveStarfield+0x46>
			((volatile UBYTE *)StarSprite)[l] += 1;
    1820:	movea.l a0,a1
    1822:	adda.l #273230,a1
    1828:	move.b (a1),d0
    182a:	addq.b #1,d0
    182c:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 8] += 1;
    182e:	lea 8(a0),a2
    1832:	movea.l a0,a1
    1834:	adda.l #273238,a1
    183a:	move.b (a1),d0
    183c:	addq.b #1,d0
    183e:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 16] += 4;
    1840:	lea 16(a0),a1
    1844:	movea.l a0,a3
    1846:	adda.l #273246,a3
    184c:	move.b (a3),d0
    184e:	addq.b #4,d0
    1850:	move.b d0,(a3)
		if (frameCounter % 2)
    1852:	move.w 43116 <frameCounter>,d0
    1858:	btst #0,d0
    185c:	beq.s 17f2 <MoveStarfield+0xa>
			((volatile UBYTE *)StarSprite2)[l] += 1;
    185e:	movea.l a0,a3
    1860:	adda.l #272482,a3
    1866:	move.b (a3),d0
    1868:	addq.b #1,d0
    186a:	move.b d0,(a3)
    186c:	bra.s 17f2 <MoveStarfield+0xa>
	}
}
    186e:	movea.l (sp)+,a2
    1870:	movea.l (sp)+,a3
    1872:	rts

00001874 <BuildLogo>:

void BuildLogo(BmpDescriptor d, short mode)
{
    1874:	move.l a2,-(sp)
    1876:	move.l d2,-(sp)
    1878:	move.w 66(sp),d0
	Point2D ps;
	Point2D pd;

	switch (mode)
    187c:	cmpi.w #2,d0
    1880:	beq.w 1bf2 <BuildLogo+0x37e>
    1884:	bgt.w 195e <BuildLogo+0xea>
    1888:	tst.w d0
    188a:	beq.w 1990 <BuildLogo+0x11c>
    188e:	cmpi.w #1,d0
    1892:	bne.w 19be <BuildLogo+0x14a>
		}
		LogoShowDone = LogoShowY2 > 129;
		break;

	case 1:
		if (LogoShowY1 >= 0)
    1896:	move.w 42e72 <LogoShowY1>,d2
    189c:	bpl.w 1b2c <BuildLogo+0x2b8>
			pd.X = 32;
			pd.Y = LogoShowY1;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
			LogoShowY1 -= 2;
		}
		else if (LogoShowY2 >= 1)
    18a0:	move.w 60ce <LogoShowY2>,d2
    18a6:	ble.w 1bdc <BuildLogo+0x368>
		{
			ps.X = 0;
    18aa:	clr.l d0
    18ac:	clr.l d1
			ps.Y = LogoShowY2;
    18ae:	movea.w d2,a2
			pd.X = 32;
    18b0:	movea.w #32,a0
    18b4:	suba.l a1,a1
			pd.Y = LogoShowY2;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    18b6:	pea 100 <MoveBobs+0x66>
    18ba:	pea 1 <_start+0x1>
    18be:	move.l a2,-(sp)
    18c0:	move.l a0,-(sp)
    18c2:	move.l a2,-(sp)
    18c4:	move.l d0,-(sp)
    18c6:	subq.l #2,sp
    18c8:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    18ce:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    18d4:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    18da:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    18e0:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    18e6:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    18ec:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    18f2:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    18f8:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    18fe:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    1904:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    190a:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    1910:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    1916:	subq.l #2,sp
    1918:	move.l 136(sp),-(sp)
    191c:	move.l 136(sp),-(sp)
    1920:	move.l 136(sp),-(sp)
    1924:	move.l 136(sp),-(sp)
    1928:	move.l 136(sp),-(sp)
    192c:	move.l 136(sp),-(sp)
    1930:	move.l 136(sp),-(sp)
    1934:	move.l 136(sp),-(sp)
    1938:	move.l 136(sp),-(sp)
    193c:	move.l 136(sp),-(sp)
    1940:	move.l 136(sp),-(sp)
    1944:	move.l 136(sp),-(sp)
    1948:	move.w 138(sp),-(sp)
    194c:	jsr 1236 <SimpleBlit>(pc)
			LogoShowY2 -= 2;
    1950:	subq.w #2,60ce <LogoShowY2>
    1956:	lea 128(sp),sp
    195a:	bra.w 1bdc <BuildLogo+0x368>
	switch (mode)
    195e:	cmpi.w #3,d0
    1962:	bne.s 19be <BuildLogo+0x14a>
		}
		LogoShowDone = LogoShowY2 > 129;
		break;

	case 3:
		if (LogoShowY1 <= 128)
    1964:	move.w 42e72 <LogoShowY1>,d2
    196a:	cmpi.w #128,d2
    196e:	ble.w 1d86 <BuildLogo+0x512>
			pd.X = 32;
			pd.Y = LogoShowY1;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
			LogoShowY1 += 2;
		}
		else if (LogoShowY2 >= 1)
    1972:	move.w 60ce <LogoShowY2>,d2
    1978:	bgt.w 1e3a <BuildLogo+0x5c6>
			pd.X = 32;
			pd.Y = LogoShowY2;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
			LogoShowY2 -= 2;
		}
		LogoShowDone = LogoShowY2 < 1;
    197c:	tst.w 60ce <LogoShowY2>
    1982:	sle d0
    1984:	ext.w d0
    1986:	neg.w d0
    1988:	move.w d0,42e74 <LogoShowDone>
		break;
    198e:	bra.s 19be <BuildLogo+0x14a>
		if (LogoShowY1 <= 128)
    1990:	move.w 42e72 <LogoShowY1>,d2
    1996:	cmpi.w #128,d2
    199a:	ble.s 19c4 <BuildLogo+0x150>
		else if (LogoShowY2 <= 129)
    199c:	move.w 60ce <LogoShowY2>,d2
    19a2:	cmpi.w #129,d2
    19a6:	ble.w 1a78 <BuildLogo+0x204>
		LogoShowDone = LogoShowY2 > 129;
    19aa:	cmpi.w #129,60ce <LogoShowY2>
    19b2:	sgt d0
    19b4:	ext.w d0
    19b6:	neg.w d0
    19b8:	move.w d0,42e74 <LogoShowDone>
	}
}
    19be:	move.l (sp)+,d2
    19c0:	movea.l (sp)+,a2
    19c2:	rts
			ps.X = 0;
    19c4:	clr.l d0
    19c6:	clr.l d1
			ps.Y = LogoShowY1;
    19c8:	movea.w d2,a2
			pd.X = 32;
    19ca:	movea.w #32,a0
    19ce:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    19d0:	pea 100 <MoveBobs+0x66>
    19d4:	pea 1 <_start+0x1>
    19d8:	move.l a2,-(sp)
    19da:	move.l a0,-(sp)
    19dc:	move.l a2,-(sp)
    19de:	move.l d0,-(sp)
    19e0:	subq.l #2,sp
    19e2:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    19e8:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    19ee:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    19f4:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    19fa:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    1a00:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1a06:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    1a0c:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    1a12:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    1a18:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    1a1e:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    1a24:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    1a2a:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    1a30:	subq.l #2,sp
    1a32:	move.l 136(sp),-(sp)
    1a36:	move.l 136(sp),-(sp)
    1a3a:	move.l 136(sp),-(sp)
    1a3e:	move.l 136(sp),-(sp)
    1a42:	move.l 136(sp),-(sp)
    1a46:	move.l 136(sp),-(sp)
    1a4a:	move.l 136(sp),-(sp)
    1a4e:	move.l 136(sp),-(sp)
    1a52:	move.l 136(sp),-(sp)
    1a56:	move.l 136(sp),-(sp)
    1a5a:	move.l 136(sp),-(sp)
    1a5e:	move.l 136(sp),-(sp)
    1a62:	move.w 138(sp),-(sp)
    1a66:	jsr 1236 <SimpleBlit>(pc)
			LogoShowY1 += 2;
    1a6a:	addq.w #2,42e72 <LogoShowY1>
    1a70:	lea 128(sp),sp
    1a74:	bra.w 19aa <BuildLogo+0x136>
			ps.X = 0;
    1a78:	clr.l d0
    1a7a:	clr.l d1
			ps.Y = LogoShowY2;
    1a7c:	movea.w d2,a2
			pd.X = 32;
    1a7e:	movea.w #32,a0
    1a82:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1a84:	pea 100 <MoveBobs+0x66>
    1a88:	pea 1 <_start+0x1>
    1a8c:	move.l a2,-(sp)
    1a8e:	move.l a0,-(sp)
    1a90:	move.l a2,-(sp)
    1a92:	move.l d0,-(sp)
    1a94:	subq.l #2,sp
    1a96:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    1a9c:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1aa2:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    1aa8:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    1aae:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    1ab4:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1aba:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    1ac0:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    1ac6:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    1acc:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    1ad2:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    1ad8:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    1ade:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    1ae4:	subq.l #2,sp
    1ae6:	move.l 136(sp),-(sp)
    1aea:	move.l 136(sp),-(sp)
    1aee:	move.l 136(sp),-(sp)
    1af2:	move.l 136(sp),-(sp)
    1af6:	move.l 136(sp),-(sp)
    1afa:	move.l 136(sp),-(sp)
    1afe:	move.l 136(sp),-(sp)
    1b02:	move.l 136(sp),-(sp)
    1b06:	move.l 136(sp),-(sp)
    1b0a:	move.l 136(sp),-(sp)
    1b0e:	move.l 136(sp),-(sp)
    1b12:	move.l 136(sp),-(sp)
    1b16:	move.w 138(sp),-(sp)
    1b1a:	jsr 1236 <SimpleBlit>(pc)
			LogoShowY2 += 2;
    1b1e:	addq.w #2,60ce <LogoShowY2>
    1b24:	lea 128(sp),sp
    1b28:	bra.w 19aa <BuildLogo+0x136>
			ps.X = 0;
    1b2c:	clr.l d0
    1b2e:	clr.l d1
			ps.Y = LogoShowY1;
    1b30:	movea.w d2,a2
			pd.X = 32;
    1b32:	movea.w #32,a0
    1b36:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1b38:	pea 100 <MoveBobs+0x66>
    1b3c:	pea 1 <_start+0x1>
    1b40:	move.l a2,-(sp)
    1b42:	move.l a0,-(sp)
    1b44:	move.l a2,-(sp)
    1b46:	move.l d0,-(sp)
    1b48:	subq.l #2,sp
    1b4a:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    1b50:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1b56:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    1b5c:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    1b62:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    1b68:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1b6e:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    1b74:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    1b7a:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    1b80:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    1b86:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    1b8c:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    1b92:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    1b98:	subq.l #2,sp
    1b9a:	move.l 136(sp),-(sp)
    1b9e:	move.l 136(sp),-(sp)
    1ba2:	move.l 136(sp),-(sp)
    1ba6:	move.l 136(sp),-(sp)
    1baa:	move.l 136(sp),-(sp)
    1bae:	move.l 136(sp),-(sp)
    1bb2:	move.l 136(sp),-(sp)
    1bb6:	move.l 136(sp),-(sp)
    1bba:	move.l 136(sp),-(sp)
    1bbe:	move.l 136(sp),-(sp)
    1bc2:	move.l 136(sp),-(sp)
    1bc6:	move.l 136(sp),-(sp)
    1bca:	move.w 138(sp),-(sp)
    1bce:	jsr 1236 <SimpleBlit>(pc)
			LogoShowY1 -= 2;
    1bd2:	subq.w #2,42e72 <LogoShowY1>
    1bd8:	lea 128(sp),sp
		LogoShowDone = LogoShowY2 < 1;
    1bdc:	tst.w 60ce <LogoShowY2>
    1be2:	sle d0
    1be4:	ext.w d0
    1be6:	neg.w d0
    1be8:	move.w d0,42e74 <LogoShowDone>
		break;
    1bee:	bra.w 19be <BuildLogo+0x14a>
		if (LogoShowY1 >= 0)
    1bf2:	move.w 42e72 <LogoShowY1>,d2
    1bf8:	bpl.w 1cbe <BuildLogo+0x44a>
		else if (LogoShowY2 <= 129)
    1bfc:	move.w 60ce <LogoShowY2>,d2
    1c02:	cmpi.w #129,d2
    1c06:	bgt.w 1d6e <BuildLogo+0x4fa>
			ps.X = 0;
    1c0a:	clr.l d0
    1c0c:	clr.l d1
			ps.Y = LogoShowY2;
    1c0e:	movea.w d2,a2
			pd.X = 32;
    1c10:	movea.w #32,a0
    1c14:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1c16:	pea 100 <MoveBobs+0x66>
    1c1a:	pea 1 <_start+0x1>
    1c1e:	move.l a2,-(sp)
    1c20:	move.l a0,-(sp)
    1c22:	move.l a2,-(sp)
    1c24:	move.l d0,-(sp)
    1c26:	subq.l #2,sp
    1c28:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    1c2e:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1c34:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    1c3a:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    1c40:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    1c46:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1c4c:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    1c52:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    1c58:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    1c5e:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    1c64:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    1c6a:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    1c70:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    1c76:	subq.l #2,sp
    1c78:	move.l 136(sp),-(sp)
    1c7c:	move.l 136(sp),-(sp)
    1c80:	move.l 136(sp),-(sp)
    1c84:	move.l 136(sp),-(sp)
    1c88:	move.l 136(sp),-(sp)
    1c8c:	move.l 136(sp),-(sp)
    1c90:	move.l 136(sp),-(sp)
    1c94:	move.l 136(sp),-(sp)
    1c98:	move.l 136(sp),-(sp)
    1c9c:	move.l 136(sp),-(sp)
    1ca0:	move.l 136(sp),-(sp)
    1ca4:	move.l 136(sp),-(sp)
    1ca8:	move.w 138(sp),-(sp)
    1cac:	jsr 1236 <SimpleBlit>(pc)
			LogoShowY2 += 2;
    1cb0:	addq.w #2,60ce <LogoShowY2>
    1cb6:	lea 128(sp),sp
    1cba:	bra.w 1d6e <BuildLogo+0x4fa>
			ps.X = 0;
    1cbe:	clr.l d0
    1cc0:	clr.l d1
			ps.Y = LogoShowY1;
    1cc2:	movea.w d2,a2
			pd.X = 32;
    1cc4:	movea.w #32,a0
    1cc8:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1cca:	pea 100 <MoveBobs+0x66>
    1cce:	pea 1 <_start+0x1>
    1cd2:	move.l a2,-(sp)
    1cd4:	move.l a0,-(sp)
    1cd6:	move.l a2,-(sp)
    1cd8:	move.l d0,-(sp)
    1cda:	subq.l #2,sp
    1cdc:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    1ce2:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1ce8:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    1cee:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    1cf4:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    1cfa:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1d00:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    1d06:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    1d0c:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    1d12:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    1d18:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    1d1e:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    1d24:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    1d2a:	subq.l #2,sp
    1d2c:	move.l 136(sp),-(sp)
    1d30:	move.l 136(sp),-(sp)
    1d34:	move.l 136(sp),-(sp)
    1d38:	move.l 136(sp),-(sp)
    1d3c:	move.l 136(sp),-(sp)
    1d40:	move.l 136(sp),-(sp)
    1d44:	move.l 136(sp),-(sp)
    1d48:	move.l 136(sp),-(sp)
    1d4c:	move.l 136(sp),-(sp)
    1d50:	move.l 136(sp),-(sp)
    1d54:	move.l 136(sp),-(sp)
    1d58:	move.l 136(sp),-(sp)
    1d5c:	move.w 138(sp),-(sp)
    1d60:	jsr 1236 <SimpleBlit>(pc)
			LogoShowY1 -= 2;
    1d64:	subq.w #2,42e72 <LogoShowY1>
    1d6a:	lea 128(sp),sp
		LogoShowDone = LogoShowY2 > 129;
    1d6e:	cmpi.w #129,60ce <LogoShowY2>
    1d76:	sgt d0
    1d78:	ext.w d0
    1d7a:	neg.w d0
    1d7c:	move.w d0,42e74 <LogoShowDone>
		break;
    1d82:	bra.w 19be <BuildLogo+0x14a>
			ps.X = 0;
    1d86:	clr.l d0
    1d88:	clr.l d1
			ps.Y = LogoShowY1;
    1d8a:	movea.w d2,a2
			pd.X = 32;
    1d8c:	movea.w #32,a0
    1d90:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1d92:	pea 100 <MoveBobs+0x66>
    1d96:	pea 1 <_start+0x1>
    1d9a:	move.l a2,-(sp)
    1d9c:	move.l a0,-(sp)
    1d9e:	move.l a2,-(sp)
    1da0:	move.l d0,-(sp)
    1da2:	subq.l #2,sp
    1da4:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    1daa:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1db0:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    1db6:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    1dbc:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    1dc2:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1dc8:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    1dce:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    1dd4:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    1dda:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    1de0:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    1de6:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    1dec:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    1df2:	subq.l #2,sp
    1df4:	move.l 136(sp),-(sp)
    1df8:	move.l 136(sp),-(sp)
    1dfc:	move.l 136(sp),-(sp)
    1e00:	move.l 136(sp),-(sp)
    1e04:	move.l 136(sp),-(sp)
    1e08:	move.l 136(sp),-(sp)
    1e0c:	move.l 136(sp),-(sp)
    1e10:	move.l 136(sp),-(sp)
    1e14:	move.l 136(sp),-(sp)
    1e18:	move.l 136(sp),-(sp)
    1e1c:	move.l 136(sp),-(sp)
    1e20:	move.l 136(sp),-(sp)
    1e24:	move.w 138(sp),-(sp)
    1e28:	jsr 1236 <SimpleBlit>(pc)
			LogoShowY1 += 2;
    1e2c:	addq.w #2,42e72 <LogoShowY1>
    1e32:	lea 128(sp),sp
    1e36:	bra.w 197c <BuildLogo+0x108>
			ps.X = 0;
    1e3a:	clr.l d0
    1e3c:	clr.l d1
			ps.Y = LogoShowY2;
    1e3e:	movea.w d2,a2
			pd.X = 32;
    1e40:	movea.w #32,a0
    1e44:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1e46:	pea 100 <MoveBobs+0x66>
    1e4a:	pea 1 <_start+0x1>
    1e4e:	move.l a2,-(sp)
    1e50:	move.l a0,-(sp)
    1e52:	move.l a2,-(sp)
    1e54:	move.l d0,-(sp)
    1e56:	subq.l #2,sp
    1e58:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    1e5e:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1e64:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    1e6a:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    1e70:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    1e76:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1e7c:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    1e82:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    1e88:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    1e8e:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    1e94:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    1e9a:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    1ea0:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    1ea6:	subq.l #2,sp
    1ea8:	move.l 136(sp),-(sp)
    1eac:	move.l 136(sp),-(sp)
    1eb0:	move.l 136(sp),-(sp)
    1eb4:	move.l 136(sp),-(sp)
    1eb8:	move.l 136(sp),-(sp)
    1ebc:	move.l 136(sp),-(sp)
    1ec0:	move.l 136(sp),-(sp)
    1ec4:	move.l 136(sp),-(sp)
    1ec8:	move.l 136(sp),-(sp)
    1ecc:	move.l 136(sp),-(sp)
    1ed0:	move.l 136(sp),-(sp)
    1ed4:	move.l 136(sp),-(sp)
    1ed8:	move.w 138(sp),-(sp)
    1edc:	jsr 1236 <SimpleBlit>(pc)
			LogoShowY2 -= 2;
    1ee0:	subq.w #2,60ce <LogoShowY2>
    1ee6:	lea 128(sp),sp
    1eea:	bra.w 197c <BuildLogo+0x108>

00001eee <DissolveLogo>:

void DissolveLogo(short mode)
{
    1eee:	move.w 6(sp),d0
	switch (mode)
    1ef2:	cmpi.w #2,d0
    1ef6:	beq.w 21b8 <DissolveLogo+0x2ca>
    1efa:	bgt.s 1f3e <DissolveLogo+0x50>
    1efc:	tst.w d0
    1efe:	beq.w 1fd0 <DissolveLogo+0xe2>
    1f02:	cmpi.w #1,d0
    1f06:	bne.w 20d2 <DissolveLogo+0x1e4>
		}
		LogoDissolveDone = LogoShowY2 < 1;
		break;

	case 1:
		if (LogoShowY1 <= 128)
    1f0a:	move.w 42e72 <LogoShowY1>,d0
    1f10:	cmpi.w #128,d0
    1f14:	ble.w 20d4 <DissolveLogo+0x1e6>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
			LogoShowY1 += 2;
		}
		else if (LogoShowY2 <= 129)
    1f18:	move.w 60ce <LogoShowY2>,d0
    1f1e:	cmpi.w #129,d0
    1f22:	ble.w 2146 <DissolveLogo+0x258>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
			LogoShowY2 += 2;
		}
		LogoDissolveDone = LogoShowY2 > 129;
    1f26:	cmpi.w #129,60ce <LogoShowY2>
    1f2e:	sgt d0
    1f30:	ext.w d0
    1f32:	neg.w d0
    1f34:	move.w d0,42e70 <LogoDissolveDone>
		break;
    1f3a:	bra.w 20d2 <DissolveLogo+0x1e4>
	switch (mode)
    1f3e:	cmpi.w #3,d0
    1f42:	bne.w 20d2 <DissolveLogo+0x1e4>
		}
		LogoDissolveDone = LogoShowY2 < 1;
		break;

	case 3:
		if (LogoShowY1 >= 0)
    1f46:	move.w 42e72 <LogoShowY1>,d0
    1f4c:	bpl.w 22c8 <DissolveLogo+0x3da>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
			LogoShowY1 -= 2;
		}
		else if (LogoShowY2 <= 129)
    1f50:	move.w 60ce <LogoShowY2>,d0
    1f56:	cmpi.w #129,d0
    1f5a:	bgt.w 2336 <DissolveLogo+0x448>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    1f5e:	pea 100 <MoveBobs+0x66>
    1f62:	pea 1 <_start+0x1>
    1f66:	movea.w d0,a0
    1f68:	move.l a0,-(sp)
    1f6a:	pea 20 <_start+0x20>
    1f6e:	subq.l #2,sp
    1f70:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    1f76:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    1f7c:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    1f82:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    1f88:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    1f8e:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    1f94:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    1f9a:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    1fa0:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    1fa6:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    1fac:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    1fb2:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    1fb8:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    1fbe:	jsr 1152 <ClearBitmapPart>(pc)
			LogoShowY2 += 2;
    1fc2:	addq.w #2,60ce <LogoShowY2>
    1fc8:	lea 68(sp),sp
    1fcc:	bra.w 2336 <DissolveLogo+0x448>
		if (LogoShowY1 >= 0)
    1fd0:	move.w 42e72 <LogoShowY1>,d0
    1fd6:	bpl.s 2052 <DissolveLogo+0x164>
		else if (LogoShowY2 >= 1)
    1fd8:	move.w 60ce <LogoShowY2>,d0
    1fde:	ble.w 20c0 <DissolveLogo+0x1d2>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    1fe2:	pea 100 <MoveBobs+0x66>
    1fe6:	pea 1 <_start+0x1>
    1fea:	movea.w d0,a0
    1fec:	move.l a0,-(sp)
    1fee:	pea 20 <_start+0x20>
    1ff2:	subq.l #2,sp
    1ff4:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    1ffa:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    2000:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    2006:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    200c:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    2012:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    2018:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    201e:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    2024:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    202a:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    2030:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    2036:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    203c:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    2042:	jsr 1152 <ClearBitmapPart>(pc)
			LogoShowY2 -= 2;
    2046:	subq.w #2,60ce <LogoShowY2>
    204c:	lea 68(sp),sp
    2050:	bra.s 20c0 <DissolveLogo+0x1d2>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    2052:	pea 100 <MoveBobs+0x66>
    2056:	pea 1 <_start+0x1>
    205a:	movea.w d0,a0
    205c:	move.l a0,-(sp)
    205e:	pea 20 <_start+0x20>
    2062:	subq.l #2,sp
    2064:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    206a:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    2070:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    2076:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    207c:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    2082:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    2088:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    208e:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    2094:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    209a:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    20a0:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    20a6:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    20ac:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    20b2:	jsr 1152 <ClearBitmapPart>(pc)
			LogoShowY1 -= 2;
    20b6:	subq.w #2,42e72 <LogoShowY1>
    20bc:	lea 68(sp),sp
		LogoDissolveDone = LogoShowY2 < 1;
    20c0:	tst.w 60ce <LogoShowY2>
    20c6:	sle d0
    20c8:	ext.w d0
    20ca:	neg.w d0
    20cc:	move.w d0,42e70 <LogoDissolveDone>
		}
		LogoDissolveDone = LogoShowY2 > 129;
		break;
	}
    20d2:	rts
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    20d4:	pea 100 <MoveBobs+0x66>
    20d8:	pea 1 <_start+0x1>
    20dc:	movea.w d0,a0
    20de:	move.l a0,-(sp)
    20e0:	pea 20 <_start+0x20>
    20e4:	subq.l #2,sp
    20e6:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    20ec:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    20f2:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    20f8:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    20fe:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    2104:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    210a:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    2110:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    2116:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    211c:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    2122:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    2128:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    212e:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    2134:	jsr 1152 <ClearBitmapPart>(pc)
			LogoShowY1 += 2;
    2138:	addq.w #2,42e72 <LogoShowY1>
    213e:	lea 68(sp),sp
    2142:	bra.w 1f26 <DissolveLogo+0x38>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    2146:	pea 100 <MoveBobs+0x66>
    214a:	pea 1 <_start+0x1>
    214e:	movea.w d0,a0
    2150:	move.l a0,-(sp)
    2152:	pea 20 <_start+0x20>
    2156:	subq.l #2,sp
    2158:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    215e:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    2164:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    216a:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    2170:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    2176:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    217c:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    2182:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    2188:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    218e:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    2194:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    219a:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    21a0:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    21a6:	jsr 1152 <ClearBitmapPart>(pc)
			LogoShowY2 += 2;
    21aa:	addq.w #2,60ce <LogoShowY2>
    21b0:	lea 68(sp),sp
    21b4:	bra.w 1f26 <DissolveLogo+0x38>
		if (LogoShowY1 <= 128)
    21b8:	move.w 42e72 <LogoShowY1>,d0
    21be:	cmpi.w #128,d0
    21c2:	ble.s 21e4 <DissolveLogo+0x2f6>
		else if (LogoShowY2 >= 1)
    21c4:	move.w 60ce <LogoShowY2>,d0
    21ca:	bgt.w 2256 <DissolveLogo+0x368>
		LogoDissolveDone = LogoShowY2 < 1;
    21ce:	tst.w 60ce <LogoShowY2>
    21d4:	sle d0
    21d6:	ext.w d0
    21d8:	neg.w d0
    21da:	move.w d0,42e70 <LogoDissolveDone>
		break;
    21e0:	bra.w 20d2 <DissolveLogo+0x1e4>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    21e4:	pea 100 <MoveBobs+0x66>
    21e8:	pea 1 <_start+0x1>
    21ec:	movea.w d0,a0
    21ee:	move.l a0,-(sp)
    21f0:	pea 20 <_start+0x20>
    21f4:	subq.l #2,sp
    21f6:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    21fc:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    2202:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    2208:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    220e:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    2214:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    221a:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    2220:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    2226:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    222c:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    2232:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    2238:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    223e:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    2244:	jsr 1152 <ClearBitmapPart>(pc)
			LogoShowY1 += 2;
    2248:	addq.w #2,42e72 <LogoShowY1>
    224e:	lea 68(sp),sp
    2252:	bra.w 21ce <DissolveLogo+0x2e0>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    2256:	pea 100 <MoveBobs+0x66>
    225a:	pea 1 <_start+0x1>
    225e:	movea.w d0,a0
    2260:	move.l a0,-(sp)
    2262:	pea 20 <_start+0x20>
    2266:	subq.l #2,sp
    2268:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    226e:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    2274:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    227a:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    2280:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    2286:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    228c:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    2292:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    2298:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    229e:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    22a4:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    22aa:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    22b0:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    22b6:	jsr 1152 <ClearBitmapPart>(pc)
			LogoShowY2 -= 2;
    22ba:	subq.w #2,60ce <LogoShowY2>
    22c0:	lea 68(sp),sp
    22c4:	bra.w 21ce <DissolveLogo+0x2e0>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    22c8:	pea 100 <MoveBobs+0x66>
    22cc:	pea 1 <_start+0x1>
    22d0:	movea.w d0,a0
    22d2:	move.l a0,-(sp)
    22d4:	pea 20 <_start+0x20>
    22d8:	subq.l #2,sp
    22da:	move.l 42fda <BmpUpperPart_PF1+0x2e>,-(sp)
    22e0:	move.l 42fd6 <BmpUpperPart_PF1+0x2a>,-(sp)
    22e6:	move.l 42fd2 <BmpUpperPart_PF1+0x26>,-(sp)
    22ec:	move.l 42fce <BmpUpperPart_PF1+0x22>,-(sp)
    22f2:	move.l 42fca <BmpUpperPart_PF1+0x1e>,-(sp)
    22f8:	move.l 42fc6 <BmpUpperPart_PF1+0x1a>,-(sp)
    22fe:	move.l 42fc2 <BmpUpperPart_PF1+0x16>,-(sp)
    2304:	move.l 42fbe <BmpUpperPart_PF1+0x12>,-(sp)
    230a:	move.l 42fba <BmpUpperPart_PF1+0xe>,-(sp)
    2310:	move.l 42fb6 <BmpUpperPart_PF1+0xa>,-(sp)
    2316:	move.l 42fb2 <BmpUpperPart_PF1+0x6>,-(sp)
    231c:	move.l 42fae <BmpUpperPart_PF1+0x2>,-(sp)
    2322:	move.w 42fac <BmpUpperPart_PF1>,-(sp)
    2328:	jsr 1152 <ClearBitmapPart>(pc)
			LogoShowY1 -= 2;
    232c:	subq.w #2,42e72 <LogoShowY1>
    2332:	lea 68(sp),sp
		LogoDissolveDone = LogoShowY2 > 129;
    2336:	cmpi.w #129,60ce <LogoShowY2>
    233e:	sgt d0
    2340:	ext.w d0
    2342:	neg.w d0
    2344:	move.w d0,42e70 <LogoDissolveDone>
		break;
    234a:	bra.w 20d2 <DissolveLogo+0x1e4>

0000234e <MainLoop>:
{
    234e:	link.w a5,#-52
    2352:	movem.l d2-d5/a2-a4,-(sp)
	BmpDescriptor bmd = BmpLogo;
    2356:	move.l 43074 <BmpLogo>,-50(a5)
    235e:	move.l 43078 <BmpLogo+0x4>,-46(a5)
    2366:	move.l 4307c <BmpLogo+0x8>,-42(a5)
    236e:	move.l 43080 <BmpLogo+0xc>,-38(a5)
    2376:	move.l 43084 <BmpLogo+0x10>,-34(a5)
    237e:	move.l 43088 <BmpLogo+0x14>,-30(a5)
    2386:	move.l 4308c <BmpLogo+0x18>,-26(a5)
    238e:	move.l 43090 <BmpLogo+0x1c>,-22(a5)
    2396:	move.l 43094 <BmpLogo+0x20>,-18(a5)
    239e:	move.l 43098 <BmpLogo+0x24>,-14(a5)
    23a6:	move.l 4309c <BmpLogo+0x28>,-10(a5)
    23ae:	move.l 430a0 <BmpLogo+0x2c>,-6(a5)
    23b6:	move.w 430a4 <BmpLogo+0x30>,-2(a5)
	short dissolveMode = 3;
    23be:	moveq #3,d4
	short logoMode = 0;
    23c0:	clr.w d3
	short bmpCnt = 0;
    23c2:	clr.w d2
    23c4:	bra.w 3322 <MainLoop+0xfd4>
		else if (LogoShowPhase % 2 == 0)
    23c8:	move.b 42e76 <LogoShowPhase>,d0
    23ce:	btst #0,d0
    23d2:	bne.w 248a <MainLoop+0x13c>
			if (bmpCnt > 3)
    23d6:	cmpi.w #3,d2
    23da:	ble.s 23de <MainLoop+0x90>
				bmpCnt = 0;
    23dc:	clr.w d2
			if (LogoShowDone)
    23de:	tst.w 42e74 <LogoShowDone>
    23e4:	beq.s 240a <MainLoop+0xbc>
				LogoShowPhase++;
    23e6:	addq.b #1,d0
    23e8:	move.b d0,42e76 <LogoShowPhase>
				if (dissolveMode == 0)
    23ee:	tst.w d4
    23f0:	bne.s 243c <MainLoop+0xee>
					LogoShowY1 = 0;
    23f2:	clr.w 42e72 <LogoShowY1>
					LogoShowY2 = 1;
    23f8:	move.w #1,60ce <LogoShowY2>
					dissolveMode = 1;
    2400:	moveq #1,d4
				LogoShowPause = 6 * 50;
    2402:	move.w #300,60d0 <LogoShowPause>
			BuildLogo(bmd, logoMode);
    240a:	movea.w d3,a0
    240c:	move.l a0,-(sp)
    240e:	subq.l #2,sp
    2410:	lea -4(a5),a0
    2414:	move.l (a0),-(sp)
    2416:	move.l -(a0),-(sp)
    2418:	move.l -(a0),-(sp)
    241a:	move.l -(a0),-(sp)
    241c:	move.l -(a0),-(sp)
    241e:	move.l -(a0),-(sp)
    2420:	move.l -(a0),-(sp)
    2422:	move.l -(a0),-(sp)
    2424:	move.l -(a0),-(sp)
    2426:	move.l -(a0),-(sp)
    2428:	move.l -(a0),-(sp)
    242a:	move.l -(a0),-(sp)
    242c:	move.w -2(a0),-(sp)
    2430:	jsr 1874 <BuildLogo>(pc)
    2434:	lea 56(sp),sp
    2438:	bra.w 3346 <MainLoop+0xff8>
				else if (dissolveMode == 1)
    243c:	cmpi.w #1,d4
    2440:	beq.s 2462 <MainLoop+0x114>
				else if (dissolveMode == 2)
    2442:	cmpi.w #2,d4
    2446:	beq.s 2474 <MainLoop+0x126>
				else if (dissolveMode == 3)
    2448:	cmpi.w #3,d4
    244c:	bne.s 2402 <MainLoop+0xb4>
					LogoShowY1 = 128;
    244e:	move.w #128,42e72 <LogoShowY1>
					LogoShowY2 = 129;
    2456:	move.w #129,60ce <LogoShowY2>
					dissolveMode = 0;
    245e:	clr.w d4
    2460:	bra.s 2402 <MainLoop+0xb4>
					LogoShowY1 = 0;
    2462:	clr.w 42e72 <LogoShowY1>
					LogoShowY2 = 129;
    2468:	move.w #129,60ce <LogoShowY2>
					dissolveMode = 2;
    2470:	moveq #2,d4
    2472:	bra.s 2402 <MainLoop+0xb4>
					LogoShowY1 = 128;
    2474:	move.w #128,42e72 <LogoShowY1>
					LogoShowY2 = 1;
    247c:	move.w #1,60ce <LogoShowY2>
					dissolveMode = 3;
    2484:	moveq #3,d4
    2486:	bra.w 2402 <MainLoop+0xb4>
			if (LogoDissolveDone)
    248a:	tst.w 42e70 <LogoDissolveDone>
    2490:	beq.s 24e8 <MainLoop+0x19a>
				LogoShowPhase++;
    2492:	addq.b #1,d0
    2494:	move.b d0,42e76 <LogoShowPhase>
				LogoShowPause = 2 * 50;
    249a:	move.w #100,60d0 <LogoShowPause>
				bmpCnt++;
    24a2:	addq.w #1,d2
				if (bmpCnt % 4 == 0)
    24a4:	move.w d2,d0
    24a6:	andi.w #3,d0
    24aa:	beq.s 24f6 <MainLoop+0x1a8>
				else if (bmpCnt % 4 == 1)
    24ac:	move.w d2,d0
    24ae:	andi.w #-32765,d0
    24b2:	tst.w d2
    24b4:	blt.w 2546 <MainLoop+0x1f8>
    24b8:	cmpi.w #1,d0
    24bc:	beq.w 2552 <MainLoop+0x204>
				else if (bmpCnt % 4 == 2)
    24c0:	cmpi.w #2,d0
    24c4:	beq.w 25a4 <MainLoop+0x256>
				else if (bmpCnt % 4 == 3)
    24c8:	cmpi.w #3,d0
    24cc:	beq.w 25f6 <MainLoop+0x2a8>
				if (logoMode == 0)
    24d0:	tst.w d3
    24d2:	bne.w 2648 <MainLoop+0x2fa>
					LogoShowY1 = 128;
    24d6:	move.w #128,42e72 <LogoShowY1>
					LogoShowY2 = 129;
    24de:	move.w #129,60ce <LogoShowY2>
					logoMode = 1;
    24e6:	moveq #1,d3
			DissolveLogo(dissolveMode);
    24e8:	movea.w d4,a0
    24ea:	move.l a0,-(sp)
    24ec:	jsr 1eee <DissolveLogo>(pc)
    24f0:	addq.l #4,sp
    24f2:	bra.w 3346 <MainLoop+0xff8>
					bmd = BmpLogo;
    24f6:	pea 32 <_start+0x32>
    24fa:	pea 43074 <BmpLogo>
    2500:	pea -50(a5)
    2504:	jsr 3a84 <memcpy>(pc)
					colP = copPF1ColP;
    2508:	movea.l 42e6c <copPF1ColP>,a0
    250e:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    2512:	moveq #1,d0
    2514:	bra.s 253e <MainLoop+0x1f0>
						ActPfCol = LogoPaletteRGB4;
    2516:	move.l #24762,60ca <ActPfCol>
						colP = copSetColor(colP, a, LogoPaletteRGB4[a]);
    2520:	move.l d0,d1
    2522:	add.l d0,d1
    2524:	lea 60ba <LogoPaletteRGB4>,a1
    252a:	move.w (0,a1,d1.l),2(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    2530:	move.w d0,d1
    2532:	addi.w #192,d1
    2536:	add.w d1,d1
    2538:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    253a:	addq.l #1,d0
						colP = copSetColor(colP, a, LogoPaletteRGB4[a]);
    253c:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    253e:	moveq #7,d1
    2540:	cmp.l d0,d1
    2542:	bge.s 2516 <MainLoop+0x1c8>
    2544:	bra.s 24d0 <MainLoop+0x182>
				else if (bmpCnt % 4 == 1)
    2546:	subq.w #1,d0
    2548:	ori.w #-4,d0
    254c:	addq.w #1,d0
    254e:	bra.w 24b8 <MainLoop+0x16a>
					bmd = BmpLogo2;
    2552:	pea 32 <_start+0x32>
    2556:	pea 43042 <BmpLogo2>
    255c:	pea -50(a5)
    2560:	jsr 3a84 <memcpy>(pc)
					colP = copPF1ColP;
    2564:	movea.l 42e6c <copPF1ColP>,a0
    256a:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    256e:	moveq #1,d0
    2570:	bra.s 259a <MainLoop+0x24c>
						ActPfCol = BastardsPaletteRGB4;
    2572:	move.l #24746,60ca <ActPfCol>
						colP = copSetColor(colP, a, BastardsPaletteRGB4[a]);
    257c:	move.l d0,d1
    257e:	add.l d0,d1
    2580:	lea 60aa <BastardsPaletteRGB4>,a1
    2586:	move.w (0,a1,d1.l),2(a0)
    258c:	move.w d0,d1
    258e:	addi.w #192,d1
    2592:	add.w d1,d1
    2594:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    2596:	addq.l #1,d0
						colP = copSetColor(colP, a, BastardsPaletteRGB4[a]);
    2598:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    259a:	moveq #7,d1
    259c:	cmp.l d0,d1
    259e:	bge.s 2572 <MainLoop+0x224>
    25a0:	bra.w 24d0 <MainLoop+0x182>
					bmd = BmpLogo3;
    25a4:	pea 32 <_start+0x32>
    25a8:	pea 43010 <BmpLogo3>
    25ae:	pea -50(a5)
    25b2:	jsr 3a84 <memcpy>(pc)
					colP = copPF1ColP;
    25b6:	movea.l 42e6c <copPF1ColP>,a0
    25bc:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    25c0:	moveq #1,d0
    25c2:	bra.s 25ec <MainLoop+0x29e>
						ActPfCol = bastard_tooPaletteRGB4;
    25c4:	move.l #24730,60ca <ActPfCol>
						colP = copSetColor(colP, a, bastard_tooPaletteRGB4[a]);
    25ce:	move.l d0,d1
    25d0:	add.l d0,d1
    25d2:	lea 609a <bastard_tooPaletteRGB4>,a1
    25d8:	move.w (0,a1,d1.l),2(a0)
    25de:	move.w d0,d1
    25e0:	addi.w #192,d1
    25e4:	add.w d1,d1
    25e6:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    25e8:	addq.l #1,d0
						colP = copSetColor(colP, a, bastard_tooPaletteRGB4[a]);
    25ea:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    25ec:	moveq #7,d1
    25ee:	cmp.l d0,d1
    25f0:	bge.s 25c4 <MainLoop+0x276>
    25f2:	bra.w 24d0 <MainLoop+0x182>
					bmd = BmpLogo4;
    25f6:	pea 32 <_start+0x32>
    25fa:	pea 42fde <BmpLogo4>
    2600:	pea -50(a5)
    2604:	jsr 3a84 <memcpy>(pc)
					colP = copPF1ColP;
    2608:	movea.l 42e6c <copPF1ColP>,a0
    260e:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    2612:	moveq #1,d0
    2614:	bra.s 263e <MainLoop+0x2f0>
						ActPfCol = bastard_threePaletteRGB4;
    2616:	move.l #24714,60ca <ActPfCol>
						colP = copSetColor(colP, a, bastard_threePaletteRGB4[a]);
    2620:	move.l d0,d1
    2622:	add.l d0,d1
    2624:	lea 608a <bastard_threePaletteRGB4>,a1
    262a:	move.w (0,a1,d1.l),2(a0)
    2630:	move.w d0,d1
    2632:	addi.w #192,d1
    2636:	add.w d1,d1
    2638:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    263a:	addq.l #1,d0
						colP = copSetColor(colP, a, bastard_threePaletteRGB4[a]);
    263c:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    263e:	moveq #7,d1
    2640:	cmp.l d0,d1
    2642:	bge.s 2616 <MainLoop+0x2c8>
    2644:	bra.w 24d0 <MainLoop+0x182>
				else if (logoMode == 1)
    2648:	cmpi.w #1,d3
    264c:	beq.s 2670 <MainLoop+0x322>
				else if (logoMode == 2)
    264e:	cmpi.w #2,d3
    2652:	beq.s 2686 <MainLoop+0x338>
				else if (logoMode == 3)
    2654:	cmpi.w #3,d3
    2658:	bne.w 24e8 <MainLoop+0x19a>
					LogoShowY1 = 0;
    265c:	clr.w 42e72 <LogoShowY1>
					LogoShowY2 = 1;
    2662:	move.w #1,60ce <LogoShowY2>
					logoMode = 0;
    266a:	clr.w d3
    266c:	bra.w 24e8 <MainLoop+0x19a>
					LogoShowY1 = 128;
    2670:	move.w #128,42e72 <LogoShowY1>
					LogoShowY2 = 1;
    2678:	move.w #1,60ce <LogoShowY2>
					logoMode = 2;
    2680:	moveq #2,d3
    2682:	bra.w 24e8 <MainLoop+0x19a>
					LogoShowY1 = 0;
    2686:	clr.w 42e72 <LogoShowY1>
					LogoShowY2 = 129;
    268c:	move.w #129,60ce <LogoShowY2>
					logoMode = 3;
    2694:	moveq #3,d3
    2696:	bra.w 24e8 <MainLoop+0x19a>
			SetupCopper(copPtrMain);
    269a:	move.l 42e7c <copPtrMain>,-(sp)
    26a0:	jsr bf0 <SetupCopper>(pc)
			custom->cop1lc = (ULONG)copPtrMain;
    26a4:	movea.l 43118 <custom>,a0
    26aa:	move.l 42e7c <copPtrMain>,128(a0)
			custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    26b2:	move.w #64,150(a0)
			custom->copjmp1 = 0x7fff;	   //start coppper
    26b8:	move.w #32767,136(a0)
			custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    26be:	move.w #-30752,150(a0)
			ResetCopper = FALSE;
    26c4:	clr.w 42e6a <ResetCopper>
    26ca:	addq.l #4,sp
    26cc:	bra.w 3350 <MainLoop+0x1002>
				if (ScrollerDir < 1)
    26d0:	tst.b 6088 <ScrollerDir>
    26d6:	ble.w 3448 <MainLoop+0x10fa>
			ScrollerY += ScrollerDir;
    26da:	move.b 6088 <ScrollerDir>,d0
    26e0:	ext.w d0
    26e2:	add.w d0,42e66 <ScrollerY>
		if (ScrollerY >= ScrollerMax)
    26e8:	movea.w 42e66 <ScrollerY>,a0
    26ee:	move.w 6086 <ScrollerMax>,d0
    26f4:	moveq #0,d1
    26f6:	move.w d0,d1
    26f8:	cmp.l a0,d1
    26fa:	bgt.w 347e <MainLoop+0x1130>
			ScrollerY = ScrollerMax;
    26fe:	move.w d0,42e66 <ScrollerY>
			ScrollerDir = -1;
    2704:	st 6088 <ScrollerDir>
		if (ScrollerPause < 1)
    270a:	tst.w 42e64 <ScrollerPause>
    2710:	beq.w 34ce <MainLoop+0x1180>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    2714:	movea.w 42e66 <ScrollerY>,a0
    271a:	move.l a0,-(sp)
    271c:	moveq #0,d0
    271e:	move.w 42f1c <BmpScroller+0x6>,d0
    2724:	move.l d0,-(sp)
    2726:	moveq #0,d0
    2728:	move.w 42f1a <BmpScroller+0x4>,d0
    272e:	move.l d0,-(sp)
    2730:	move.l 42f24 <BmpScroller+0xe>,-(sp)
    2736:	move.l 42e60 <copScrollerBmpP>,-(sp)
    273c:	clr.l -(sp)
    273e:	jsr 96e <copSetPlanesInterleafed>(pc)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[0].X, BobTarget[0].Y, 32, 32);
    2742:	pea 20 <_start+0x20>
    2746:	pea 20 <_start+0x20>
    274a:	move.l 604a <BobTarget+0x4>,-(sp)
    2750:	move.l 6046 <BobTarget>,-(sp)
    2756:	subq.l #2,sp
    2758:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    275e:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2764:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    276a:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    2770:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2776:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    277c:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    2782:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    2788:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    278e:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    2794:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    279a:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    27a0:	lea 42f48 <BmpUpperPart_Buf1>,a3
    27a6:	move.w (a3),-(sp)
    27a8:	lea 1152 <ClearBitmapPart>(pc),a2
    27ac:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[1].X, BobTarget[1].Y, 32, 32);
    27ae:	lea 92(sp),sp
    27b2:	pea 20 <_start+0x20>
    27b6:	pea 20 <_start+0x20>
    27ba:	move.l 6052 <BobTarget+0xc>,-(sp)
    27c0:	move.l 604e <BobTarget+0x8>,-(sp)
    27c6:	subq.l #2,sp
    27c8:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    27ce:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    27d4:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    27da:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    27e0:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    27e6:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    27ec:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    27f2:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    27f8:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    27fe:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    2804:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    280a:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    2810:	move.w (a3),-(sp)
    2812:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[2].X, BobTarget[2].Y, 32, 32);
    2814:	lea 68(sp),sp
    2818:	pea 20 <_start+0x20>
    281c:	pea 20 <_start+0x20>
    2820:	move.l 605a <BobTarget+0x14>,-(sp)
    2826:	move.l 6056 <BobTarget+0x10>,-(sp)
    282c:	subq.l #2,sp
    282e:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2834:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    283a:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    2840:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    2846:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    284c:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2852:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    2858:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    285e:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    2864:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    286a:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    2870:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    2876:	move.w (a3),-(sp)
    2878:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[3].X, BobTarget[3].Y, 32, 32);
    287a:	lea 68(sp),sp
    287e:	pea 20 <_start+0x20>
    2882:	pea 20 <_start+0x20>
    2886:	move.l 6062 <BobTarget+0x1c>,-(sp)
    288c:	move.l 605e <BobTarget+0x18>,-(sp)
    2892:	subq.l #2,sp
    2894:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    289a:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    28a0:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    28a6:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    28ac:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    28b2:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    28b8:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    28be:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    28c4:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    28ca:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    28d0:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    28d6:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    28dc:	move.w (a3),-(sp)
    28de:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[4].X, BobTarget[4].Y, 32, 32);
    28e0:	lea 68(sp),sp
    28e4:	pea 20 <_start+0x20>
    28e8:	pea 20 <_start+0x20>
    28ec:	move.l 606a <BobTarget+0x24>,-(sp)
    28f2:	move.l 6066 <BobTarget+0x20>,-(sp)
    28f8:	subq.l #2,sp
    28fa:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2900:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2906:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    290c:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    2912:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2918:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    291e:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    2924:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    292a:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    2930:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    2936:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    293c:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    2942:	move.w (a3),-(sp)
    2944:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[5].X, BobTarget[5].Y, 32, 32);
    2946:	lea 68(sp),sp
    294a:	pea 20 <_start+0x20>
    294e:	pea 20 <_start+0x20>
    2952:	move.l 6072 <BobTarget+0x2c>,-(sp)
    2958:	move.l 606e <BobTarget+0x28>,-(sp)
    295e:	subq.l #2,sp
    2960:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2966:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    296c:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    2972:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    2978:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    297e:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2984:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    298a:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    2990:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    2996:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    299c:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    29a2:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    29a8:	move.w (a3),-(sp)
    29aa:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[6].X, BobTarget[6].Y, 32, 32);
    29ac:	lea 68(sp),sp
    29b0:	pea 20 <_start+0x20>
    29b4:	pea 20 <_start+0x20>
    29b8:	move.l 607a <BobTarget+0x34>,-(sp)
    29be:	move.l 6076 <BobTarget+0x30>,-(sp)
    29c4:	subq.l #2,sp
    29c6:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    29cc:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    29d2:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    29d8:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    29de:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    29e4:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    29ea:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    29f0:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    29f6:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    29fc:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    2a02:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    2a08:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    2a0e:	move.w (a3),-(sp)
    2a10:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[7].X, BobTarget[7].Y, 32, 32);
    2a12:	lea 68(sp),sp
    2a16:	pea 20 <_start+0x20>
    2a1a:	pea 20 <_start+0x20>
    2a1e:	move.l 6082 <BobTarget+0x3c>,-(sp)
    2a24:	move.l 607e <BobTarget+0x38>,-(sp)
    2a2a:	subq.l #2,sp
    2a2c:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2a32:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2a38:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    2a3e:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    2a44:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2a4a:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2a50:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    2a56:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    2a5c:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    2a62:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    2a68:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    2a6e:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    2a74:	move.w (a3),-(sp)
    2a76:	jsr (a2)
		if (BobPause > 0)
    2a78:	move.w 42e5e <BobPause>,d0
    2a7e:	lea 68(sp),sp
    2a82:	beq.w 353c <MainLoop+0x11ee>
			BobPause--;
    2a86:	subq.w #1,d0
    2a88:	move.w d0,42e5e <BobPause>
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[0], BobTarget[0], 32, 32);
    2a8e:	pea 20 <_start+0x20>
    2a92:	pea 20 <_start+0x20>
    2a96:	move.l 604a <BobTarget+0x4>,-(sp)
    2a9c:	move.l 6046 <BobTarget>,-(sp)
    2aa2:	move.l 5f44 <BobSource+0x4>,-(sp)
    2aa8:	move.l 5f40 <BobSource>,-(sp)
    2aae:	subq.l #2,sp
    2ab0:	move.l 42eae <BmpCookieMask+0x2e>,-(sp)
    2ab6:	move.l 42eaa <BmpCookieMask+0x2a>,-(sp)
    2abc:	move.l 42ea6 <BmpCookieMask+0x26>,-(sp)
    2ac2:	move.l 42ea2 <BmpCookieMask+0x22>,-(sp)
    2ac8:	move.l 42e9e <BmpCookieMask+0x1e>,-(sp)
    2ace:	move.l 42e9a <BmpCookieMask+0x1a>,-(sp)
    2ad4:	move.l 42e96 <BmpCookieMask+0x16>,-(sp)
    2ada:	move.l 42e92 <BmpCookieMask+0x12>,-(sp)
    2ae0:	move.l 42e8e <BmpCookieMask+0xe>,-(sp)
    2ae6:	move.l 42e8a <BmpCookieMask+0xa>,-(sp)
    2aec:	move.l 42e86 <BmpCookieMask+0x6>,-(sp)
    2af2:	move.l 42e82 <BmpCookieMask+0x2>,-(sp)
    2af8:	lea 42e80 <BmpCookieMask>,a0
    2afe:	move.w (a0),-(sp)
    2b00:	subq.l #2,sp
    2b02:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2b08:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2b0e:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    2b14:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    2b1a:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2b20:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2b26:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    2b2c:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    2b32:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    2b38:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    2b3e:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    2b44:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    2b4a:	lea 42f48 <BmpUpperPart_Buf1>,a4
    2b50:	move.w (a4),-(sp)
    2b52:	subq.l #2,sp
    2b54:	move.l 42ee0 <BmpCookie+0x2e>,-(sp)
    2b5a:	move.l 42edc <BmpCookie+0x2a>,-(sp)
    2b60:	move.l 42ed8 <BmpCookie+0x26>,-(sp)
    2b66:	move.l 42ed4 <BmpCookie+0x22>,-(sp)
    2b6c:	move.l 42ed0 <BmpCookie+0x1e>,-(sp)
    2b72:	move.l 42ecc <BmpCookie+0x1a>,-(sp)
    2b78:	move.l 42ec8 <BmpCookie+0x16>,-(sp)
    2b7e:	move.l 42ec4 <BmpCookie+0x12>,-(sp)
    2b84:	move.l 42ec0 <BmpCookie+0xe>,-(sp)
    2b8a:	move.l 42ebc <BmpCookie+0xa>,-(sp)
    2b90:	move.l 42eb8 <BmpCookie+0x6>,-(sp)
    2b96:	move.l 42eb4 <BmpCookie+0x2>,-(sp)
    2b9c:	lea 42eb2 <BmpCookie>,a3
    2ba2:	move.w (a3),-(sp)
    2ba4:	lea 12fa <BetterBlit>(pc),a2
    2ba8:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[1], BobTarget[1], 32, 32);
    2baa:	lea 180(sp),sp
    2bae:	pea 20 <_start+0x20>
    2bb2:	pea 20 <_start+0x20>
    2bb6:	move.l 6052 <BobTarget+0xc>,-(sp)
    2bbc:	move.l 604e <BobTarget+0x8>,-(sp)
    2bc2:	move.l 5f4c <BobSource+0xc>,-(sp)
    2bc8:	move.l 5f48 <BobSource+0x8>,-(sp)
    2bce:	subq.l #2,sp
    2bd0:	move.l 42eae <BmpCookieMask+0x2e>,-(sp)
    2bd6:	move.l 42eaa <BmpCookieMask+0x2a>,-(sp)
    2bdc:	move.l 42ea6 <BmpCookieMask+0x26>,-(sp)
    2be2:	move.l 42ea2 <BmpCookieMask+0x22>,-(sp)
    2be8:	move.l 42e9e <BmpCookieMask+0x1e>,-(sp)
    2bee:	move.l 42e9a <BmpCookieMask+0x1a>,-(sp)
    2bf4:	move.l 42e96 <BmpCookieMask+0x16>,-(sp)
    2bfa:	move.l 42e92 <BmpCookieMask+0x12>,-(sp)
    2c00:	move.l 42e8e <BmpCookieMask+0xe>,-(sp)
    2c06:	move.l 42e8a <BmpCookieMask+0xa>,-(sp)
    2c0c:	move.l 42e86 <BmpCookieMask+0x6>,-(sp)
    2c12:	move.l 42e82 <BmpCookieMask+0x2>,-(sp)
    2c18:	lea 42e80 <BmpCookieMask>,a0
    2c1e:	move.w (a0),-(sp)
    2c20:	subq.l #2,sp
    2c22:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2c28:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2c2e:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    2c34:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    2c3a:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2c40:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2c46:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    2c4c:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    2c52:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    2c58:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    2c5e:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    2c64:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    2c6a:	move.w (a4),-(sp)
    2c6c:	subq.l #2,sp
    2c6e:	move.l 42ee0 <BmpCookie+0x2e>,-(sp)
    2c74:	move.l 42edc <BmpCookie+0x2a>,-(sp)
    2c7a:	move.l 42ed8 <BmpCookie+0x26>,-(sp)
    2c80:	move.l 42ed4 <BmpCookie+0x22>,-(sp)
    2c86:	move.l 42ed0 <BmpCookie+0x1e>,-(sp)
    2c8c:	move.l 42ecc <BmpCookie+0x1a>,-(sp)
    2c92:	move.l 42ec8 <BmpCookie+0x16>,-(sp)
    2c98:	move.l 42ec4 <BmpCookie+0x12>,-(sp)
    2c9e:	move.l 42ec0 <BmpCookie+0xe>,-(sp)
    2ca4:	move.l 42ebc <BmpCookie+0xa>,-(sp)
    2caa:	move.l 42eb8 <BmpCookie+0x6>,-(sp)
    2cb0:	move.l 42eb4 <BmpCookie+0x2>,-(sp)
    2cb6:	move.w (a3),-(sp)
    2cb8:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[2], BobTarget[2], 32, 32);
    2cba:	lea 180(sp),sp
    2cbe:	pea 20 <_start+0x20>
    2cc2:	pea 20 <_start+0x20>
    2cc6:	move.l 605a <BobTarget+0x14>,-(sp)
    2ccc:	move.l 6056 <BobTarget+0x10>,-(sp)
    2cd2:	move.l 5f54 <BobSource+0x14>,-(sp)
    2cd8:	move.l 5f50 <BobSource+0x10>,-(sp)
    2cde:	subq.l #2,sp
    2ce0:	move.l 42eae <BmpCookieMask+0x2e>,-(sp)
    2ce6:	move.l 42eaa <BmpCookieMask+0x2a>,-(sp)
    2cec:	move.l 42ea6 <BmpCookieMask+0x26>,-(sp)
    2cf2:	move.l 42ea2 <BmpCookieMask+0x22>,-(sp)
    2cf8:	move.l 42e9e <BmpCookieMask+0x1e>,-(sp)
    2cfe:	move.l 42e9a <BmpCookieMask+0x1a>,-(sp)
    2d04:	move.l 42e96 <BmpCookieMask+0x16>,-(sp)
    2d0a:	move.l 42e92 <BmpCookieMask+0x12>,-(sp)
    2d10:	move.l 42e8e <BmpCookieMask+0xe>,-(sp)
    2d16:	move.l 42e8a <BmpCookieMask+0xa>,-(sp)
    2d1c:	move.l 42e86 <BmpCookieMask+0x6>,-(sp)
    2d22:	move.l 42e82 <BmpCookieMask+0x2>,-(sp)
    2d28:	lea 42e80 <BmpCookieMask>,a0
    2d2e:	move.w (a0),-(sp)
    2d30:	subq.l #2,sp
    2d32:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2d38:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2d3e:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    2d44:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    2d4a:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2d50:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2d56:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    2d5c:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    2d62:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    2d68:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    2d6e:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    2d74:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    2d7a:	move.w (a4),-(sp)
    2d7c:	subq.l #2,sp
    2d7e:	move.l 42ee0 <BmpCookie+0x2e>,-(sp)
    2d84:	move.l 42edc <BmpCookie+0x2a>,-(sp)
    2d8a:	move.l 42ed8 <BmpCookie+0x26>,-(sp)
    2d90:	move.l 42ed4 <BmpCookie+0x22>,-(sp)
    2d96:	move.l 42ed0 <BmpCookie+0x1e>,-(sp)
    2d9c:	move.l 42ecc <BmpCookie+0x1a>,-(sp)
    2da2:	move.l 42ec8 <BmpCookie+0x16>,-(sp)
    2da8:	move.l 42ec4 <BmpCookie+0x12>,-(sp)
    2dae:	move.l 42ec0 <BmpCookie+0xe>,-(sp)
    2db4:	move.l 42ebc <BmpCookie+0xa>,-(sp)
    2dba:	move.l 42eb8 <BmpCookie+0x6>,-(sp)
    2dc0:	move.l 42eb4 <BmpCookie+0x2>,-(sp)
    2dc6:	move.w (a3),-(sp)
    2dc8:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[3], BobTarget[3], 32, 32);
    2dca:	lea 180(sp),sp
    2dce:	pea 20 <_start+0x20>
    2dd2:	pea 20 <_start+0x20>
    2dd6:	move.l 6062 <BobTarget+0x1c>,-(sp)
    2ddc:	move.l 605e <BobTarget+0x18>,-(sp)
    2de2:	move.l 5f5c <BobSource+0x1c>,-(sp)
    2de8:	move.l 5f58 <BobSource+0x18>,-(sp)
    2dee:	subq.l #2,sp
    2df0:	move.l 42eae <BmpCookieMask+0x2e>,-(sp)
    2df6:	move.l 42eaa <BmpCookieMask+0x2a>,-(sp)
    2dfc:	move.l 42ea6 <BmpCookieMask+0x26>,-(sp)
    2e02:	move.l 42ea2 <BmpCookieMask+0x22>,-(sp)
    2e08:	move.l 42e9e <BmpCookieMask+0x1e>,-(sp)
    2e0e:	move.l 42e9a <BmpCookieMask+0x1a>,-(sp)
    2e14:	move.l 42e96 <BmpCookieMask+0x16>,-(sp)
    2e1a:	move.l 42e92 <BmpCookieMask+0x12>,-(sp)
    2e20:	move.l 42e8e <BmpCookieMask+0xe>,-(sp)
    2e26:	move.l 42e8a <BmpCookieMask+0xa>,-(sp)
    2e2c:	move.l 42e86 <BmpCookieMask+0x6>,-(sp)
    2e32:	move.l 42e82 <BmpCookieMask+0x2>,-(sp)
    2e38:	lea 42e80 <BmpCookieMask>,a0
    2e3e:	move.w (a0),-(sp)
    2e40:	subq.l #2,sp
    2e42:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2e48:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2e4e:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    2e54:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    2e5a:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2e60:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2e66:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    2e6c:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    2e72:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    2e78:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    2e7e:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    2e84:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    2e8a:	move.w (a4),-(sp)
    2e8c:	subq.l #2,sp
    2e8e:	move.l 42ee0 <BmpCookie+0x2e>,-(sp)
    2e94:	move.l 42edc <BmpCookie+0x2a>,-(sp)
    2e9a:	move.l 42ed8 <BmpCookie+0x26>,-(sp)
    2ea0:	move.l 42ed4 <BmpCookie+0x22>,-(sp)
    2ea6:	move.l 42ed0 <BmpCookie+0x1e>,-(sp)
    2eac:	move.l 42ecc <BmpCookie+0x1a>,-(sp)
    2eb2:	move.l 42ec8 <BmpCookie+0x16>,-(sp)
    2eb8:	move.l 42ec4 <BmpCookie+0x12>,-(sp)
    2ebe:	move.l 42ec0 <BmpCookie+0xe>,-(sp)
    2ec4:	move.l 42ebc <BmpCookie+0xa>,-(sp)
    2eca:	move.l 42eb8 <BmpCookie+0x6>,-(sp)
    2ed0:	move.l 42eb4 <BmpCookie+0x2>,-(sp)
    2ed6:	move.w (a3),-(sp)
    2ed8:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[4], BobTarget[4], 32, 32);
    2eda:	lea 180(sp),sp
    2ede:	pea 20 <_start+0x20>
    2ee2:	pea 20 <_start+0x20>
    2ee6:	move.l 606a <BobTarget+0x24>,-(sp)
    2eec:	move.l 6066 <BobTarget+0x20>,-(sp)
    2ef2:	move.l 5f64 <BobSource+0x24>,-(sp)
    2ef8:	move.l 5f60 <BobSource+0x20>,-(sp)
    2efe:	subq.l #2,sp
    2f00:	move.l 42eae <BmpCookieMask+0x2e>,-(sp)
    2f06:	move.l 42eaa <BmpCookieMask+0x2a>,-(sp)
    2f0c:	move.l 42ea6 <BmpCookieMask+0x26>,-(sp)
    2f12:	move.l 42ea2 <BmpCookieMask+0x22>,-(sp)
    2f18:	move.l 42e9e <BmpCookieMask+0x1e>,-(sp)
    2f1e:	move.l 42e9a <BmpCookieMask+0x1a>,-(sp)
    2f24:	move.l 42e96 <BmpCookieMask+0x16>,-(sp)
    2f2a:	move.l 42e92 <BmpCookieMask+0x12>,-(sp)
    2f30:	move.l 42e8e <BmpCookieMask+0xe>,-(sp)
    2f36:	move.l 42e8a <BmpCookieMask+0xa>,-(sp)
    2f3c:	move.l 42e86 <BmpCookieMask+0x6>,-(sp)
    2f42:	move.l 42e82 <BmpCookieMask+0x2>,-(sp)
    2f48:	lea 42e80 <BmpCookieMask>,a0
    2f4e:	move.w (a0),-(sp)
    2f50:	subq.l #2,sp
    2f52:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    2f58:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2f5e:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    2f64:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    2f6a:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    2f70:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2f76:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    2f7c:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    2f82:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    2f88:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    2f8e:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    2f94:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    2f9a:	move.w (a4),-(sp)
    2f9c:	subq.l #2,sp
    2f9e:	move.l 42ee0 <BmpCookie+0x2e>,-(sp)
    2fa4:	move.l 42edc <BmpCookie+0x2a>,-(sp)
    2faa:	move.l 42ed8 <BmpCookie+0x26>,-(sp)
    2fb0:	move.l 42ed4 <BmpCookie+0x22>,-(sp)
    2fb6:	move.l 42ed0 <BmpCookie+0x1e>,-(sp)
    2fbc:	move.l 42ecc <BmpCookie+0x1a>,-(sp)
    2fc2:	move.l 42ec8 <BmpCookie+0x16>,-(sp)
    2fc8:	move.l 42ec4 <BmpCookie+0x12>,-(sp)
    2fce:	move.l 42ec0 <BmpCookie+0xe>,-(sp)
    2fd4:	move.l 42ebc <BmpCookie+0xa>,-(sp)
    2fda:	move.l 42eb8 <BmpCookie+0x6>,-(sp)
    2fe0:	move.l 42eb4 <BmpCookie+0x2>,-(sp)
    2fe6:	move.w (a3),-(sp)
    2fe8:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[5], BobTarget[5], 32, 32);
    2fea:	lea 180(sp),sp
    2fee:	pea 20 <_start+0x20>
    2ff2:	pea 20 <_start+0x20>
    2ff6:	move.l 6072 <BobTarget+0x2c>,-(sp)
    2ffc:	move.l 606e <BobTarget+0x28>,-(sp)
    3002:	move.l 5f6c <BobSource+0x2c>,-(sp)
    3008:	move.l 5f68 <BobSource+0x28>,-(sp)
    300e:	subq.l #2,sp
    3010:	move.l 42eae <BmpCookieMask+0x2e>,-(sp)
    3016:	move.l 42eaa <BmpCookieMask+0x2a>,-(sp)
    301c:	move.l 42ea6 <BmpCookieMask+0x26>,-(sp)
    3022:	move.l 42ea2 <BmpCookieMask+0x22>,-(sp)
    3028:	move.l 42e9e <BmpCookieMask+0x1e>,-(sp)
    302e:	move.l 42e9a <BmpCookieMask+0x1a>,-(sp)
    3034:	move.l 42e96 <BmpCookieMask+0x16>,-(sp)
    303a:	move.l 42e92 <BmpCookieMask+0x12>,-(sp)
    3040:	move.l 42e8e <BmpCookieMask+0xe>,-(sp)
    3046:	move.l 42e8a <BmpCookieMask+0xa>,-(sp)
    304c:	move.l 42e86 <BmpCookieMask+0x6>,-(sp)
    3052:	move.l 42e82 <BmpCookieMask+0x2>,-(sp)
    3058:	lea 42e80 <BmpCookieMask>,a0
    305e:	move.w (a0),-(sp)
    3060:	subq.l #2,sp
    3062:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    3068:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    306e:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    3074:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    307a:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    3080:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    3086:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    308c:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    3092:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    3098:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    309e:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    30a4:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    30aa:	move.w (a4),-(sp)
    30ac:	subq.l #2,sp
    30ae:	move.l 42ee0 <BmpCookie+0x2e>,-(sp)
    30b4:	move.l 42edc <BmpCookie+0x2a>,-(sp)
    30ba:	move.l 42ed8 <BmpCookie+0x26>,-(sp)
    30c0:	move.l 42ed4 <BmpCookie+0x22>,-(sp)
    30c6:	move.l 42ed0 <BmpCookie+0x1e>,-(sp)
    30cc:	move.l 42ecc <BmpCookie+0x1a>,-(sp)
    30d2:	move.l 42ec8 <BmpCookie+0x16>,-(sp)
    30d8:	move.l 42ec4 <BmpCookie+0x12>,-(sp)
    30de:	move.l 42ec0 <BmpCookie+0xe>,-(sp)
    30e4:	move.l 42ebc <BmpCookie+0xa>,-(sp)
    30ea:	move.l 42eb8 <BmpCookie+0x6>,-(sp)
    30f0:	move.l 42eb4 <BmpCookie+0x2>,-(sp)
    30f6:	move.w (a3),-(sp)
    30f8:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[6], BobTarget[6], 32, 32);
    30fa:	lea 180(sp),sp
    30fe:	pea 20 <_start+0x20>
    3102:	pea 20 <_start+0x20>
    3106:	move.l 607a <BobTarget+0x34>,-(sp)
    310c:	move.l 6076 <BobTarget+0x30>,-(sp)
    3112:	move.l 5f74 <BobSource+0x34>,-(sp)
    3118:	move.l 5f70 <BobSource+0x30>,-(sp)
    311e:	subq.l #2,sp
    3120:	move.l 42eae <BmpCookieMask+0x2e>,-(sp)
    3126:	move.l 42eaa <BmpCookieMask+0x2a>,-(sp)
    312c:	move.l 42ea6 <BmpCookieMask+0x26>,-(sp)
    3132:	move.l 42ea2 <BmpCookieMask+0x22>,-(sp)
    3138:	move.l 42e9e <BmpCookieMask+0x1e>,-(sp)
    313e:	move.l 42e9a <BmpCookieMask+0x1a>,-(sp)
    3144:	move.l 42e96 <BmpCookieMask+0x16>,-(sp)
    314a:	move.l 42e92 <BmpCookieMask+0x12>,-(sp)
    3150:	move.l 42e8e <BmpCookieMask+0xe>,-(sp)
    3156:	move.l 42e8a <BmpCookieMask+0xa>,-(sp)
    315c:	move.l 42e86 <BmpCookieMask+0x6>,-(sp)
    3162:	move.l 42e82 <BmpCookieMask+0x2>,-(sp)
    3168:	lea 42e80 <BmpCookieMask>,a0
    316e:	move.w (a0),-(sp)
    3170:	subq.l #2,sp
    3172:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    3178:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    317e:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    3184:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    318a:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    3190:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    3196:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    319c:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    31a2:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    31a8:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    31ae:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    31b4:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    31ba:	move.w (a4),-(sp)
    31bc:	subq.l #2,sp
    31be:	move.l 42ee0 <BmpCookie+0x2e>,-(sp)
    31c4:	move.l 42edc <BmpCookie+0x2a>,-(sp)
    31ca:	move.l 42ed8 <BmpCookie+0x26>,-(sp)
    31d0:	move.l 42ed4 <BmpCookie+0x22>,-(sp)
    31d6:	move.l 42ed0 <BmpCookie+0x1e>,-(sp)
    31dc:	move.l 42ecc <BmpCookie+0x1a>,-(sp)
    31e2:	move.l 42ec8 <BmpCookie+0x16>,-(sp)
    31e8:	move.l 42ec4 <BmpCookie+0x12>,-(sp)
    31ee:	move.l 42ec0 <BmpCookie+0xe>,-(sp)
    31f4:	move.l 42ebc <BmpCookie+0xa>,-(sp)
    31fa:	move.l 42eb8 <BmpCookie+0x6>,-(sp)
    3200:	move.l 42eb4 <BmpCookie+0x2>,-(sp)
    3206:	move.w (a3),-(sp)
    3208:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[7], BobTarget[7], 32, 32);
    320a:	lea 180(sp),sp
    320e:	pea 20 <_start+0x20>
    3212:	pea 20 <_start+0x20>
    3216:	move.l 6082 <BobTarget+0x3c>,-(sp)
    321c:	move.l 607e <BobTarget+0x38>,-(sp)
    3222:	move.l 5f7c <BobSource+0x3c>,-(sp)
    3228:	move.l 5f78 <BobSource+0x38>,-(sp)
    322e:	subq.l #2,sp
    3230:	move.l 42eae <BmpCookieMask+0x2e>,-(sp)
    3236:	move.l 42eaa <BmpCookieMask+0x2a>,-(sp)
    323c:	move.l 42ea6 <BmpCookieMask+0x26>,-(sp)
    3242:	move.l 42ea2 <BmpCookieMask+0x22>,-(sp)
    3248:	move.l 42e9e <BmpCookieMask+0x1e>,-(sp)
    324e:	move.l 42e9a <BmpCookieMask+0x1a>,-(sp)
    3254:	move.l 42e96 <BmpCookieMask+0x16>,-(sp)
    325a:	move.l 42e92 <BmpCookieMask+0x12>,-(sp)
    3260:	move.l 42e8e <BmpCookieMask+0xe>,-(sp)
    3266:	move.l 42e8a <BmpCookieMask+0xa>,-(sp)
    326c:	move.l 42e86 <BmpCookieMask+0x6>,-(sp)
    3272:	move.l 42e82 <BmpCookieMask+0x2>,-(sp)
    3278:	lea 42e80 <BmpCookieMask>,a0
    327e:	move.w (a0),-(sp)
    3280:	subq.l #2,sp
    3282:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    3288:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    328e:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    3294:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    329a:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    32a0:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    32a6:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    32ac:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    32b2:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    32b8:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    32be:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    32c4:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    32ca:	move.w (a4),-(sp)
    32cc:	subq.l #2,sp
    32ce:	move.l 42ee0 <BmpCookie+0x2e>,-(sp)
    32d4:	move.l 42edc <BmpCookie+0x2a>,-(sp)
    32da:	move.l 42ed8 <BmpCookie+0x26>,-(sp)
    32e0:	move.l 42ed4 <BmpCookie+0x22>,-(sp)
    32e6:	move.l 42ed0 <BmpCookie+0x1e>,-(sp)
    32ec:	move.l 42ecc <BmpCookie+0x1a>,-(sp)
    32f2:	move.l 42ec8 <BmpCookie+0x16>,-(sp)
    32f8:	move.l 42ec4 <BmpCookie+0x12>,-(sp)
    32fe:	move.l 42ec0 <BmpCookie+0xe>,-(sp)
    3304:	move.l 42ebc <BmpCookie+0xa>,-(sp)
    330a:	move.l 42eb8 <BmpCookie+0x6>,-(sp)
    3310:	move.l 42eb4 <BmpCookie+0x2>,-(sp)
    3316:	move.w (a3),-(sp)
    3318:	jsr (a2)
		MoveStarfield();
    331a:	lea 180(sp),sp
    331e:	jsr 17e8 <MoveStarfield>(pc)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    3322:	move.b bfe001 <_end+0xbbaee5>,d0
	while (!MouseLeft())
    3328:	btst #6,d0
    332c:	beq.w 3544 <MainLoop+0x11f6>
		WaitVbl();
    3330:	jsr 752 <WaitVbl>(pc)
		if (LogoShowPause > 0)
    3334:	move.w 60d0 <LogoShowPause>,d0
    333a:	beq.w 23c8 <MainLoop+0x7a>
			LogoShowPause--;
    333e:	subq.w #1,d0
    3340:	move.w d0,60d0 <LogoShowPause>
		if (ResetCopper)
    3346:	tst.w 42e6a <ResetCopper>
    334c:	bne.w 269a <MainLoop+0x34c>
		CopyBitmapPart(BmpUpperPart_Buf1, BmpUpperPart_PF2, 46, 78);
    3350:	pea 4e <_start+0x4e>
    3354:	pea 2e <_start+0x2e>
    3358:	subq.l #2,sp
    335a:	move.l 42fa8 <BmpUpperPart_PF2+0x2e>,-(sp)
    3360:	move.l 42fa4 <BmpUpperPart_PF2+0x2a>,-(sp)
    3366:	move.l 42fa0 <BmpUpperPart_PF2+0x26>,-(sp)
    336c:	move.l 42f9c <BmpUpperPart_PF2+0x22>,-(sp)
    3372:	move.l 42f98 <BmpUpperPart_PF2+0x1e>,-(sp)
    3378:	move.l 42f94 <BmpUpperPart_PF2+0x1a>,-(sp)
    337e:	move.l 42f90 <BmpUpperPart_PF2+0x16>,-(sp)
    3384:	move.l 42f8c <BmpUpperPart_PF2+0x12>,-(sp)
    338a:	move.l 42f88 <BmpUpperPart_PF2+0xe>,-(sp)
    3390:	move.l 42f84 <BmpUpperPart_PF2+0xa>,-(sp)
    3396:	move.l 42f80 <BmpUpperPart_PF2+0x6>,-(sp)
    339c:	move.l 42f7c <BmpUpperPart_PF2+0x2>,-(sp)
    33a2:	move.w 42f7a <BmpUpperPart_PF2>,-(sp)
    33a8:	subq.l #2,sp
    33aa:	move.l 42f76 <BmpUpperPart_Buf1+0x2e>,-(sp)
    33b0:	move.l 42f72 <BmpUpperPart_Buf1+0x2a>,-(sp)
    33b6:	move.l 42f6e <BmpUpperPart_Buf1+0x26>,-(sp)
    33bc:	move.l 42f6a <BmpUpperPart_Buf1+0x22>,-(sp)
    33c2:	move.l 42f66 <BmpUpperPart_Buf1+0x1e>,-(sp)
    33c8:	move.l 42f62 <BmpUpperPart_Buf1+0x1a>,-(sp)
    33ce:	move.l 42f5e <BmpUpperPart_Buf1+0x16>,-(sp)
    33d4:	move.l 42f5a <BmpUpperPart_Buf1+0x12>,-(sp)
    33da:	move.l 42f56 <BmpUpperPart_Buf1+0xe>,-(sp)
    33e0:	move.l 42f52 <BmpUpperPart_Buf1+0xa>,-(sp)
    33e6:	move.l 42f4e <BmpUpperPart_Buf1+0x6>,-(sp)
    33ec:	move.l 42f4a <BmpUpperPart_Buf1+0x2>,-(sp)
    33f2:	move.w 42f48 <BmpUpperPart_Buf1>,-(sp)
    33f8:	jsr 10ce <CopyBitmapPart>(pc)
		if (BounceEnabled)
    33fc:	move.w 42e68 <BounceEnabled>,d5
    3402:	lea 112(sp),sp
    3406:	beq.s 3468 <MainLoop+0x111a>
			if (ScrollerDir > 0)
    3408:	move.b 6088 <ScrollerDir>,d0
    340e:	ble.s 3454 <MainLoop+0x1106>
				ScrollerDir = ((ScrollerMax - ScrollerY) * 1000 / 12000);
    3410:	moveq #0,d0
    3412:	move.w 6086 <ScrollerMax>,d0
    3418:	pea c <_start+0xc>
    341c:	movea.l d0,a0
    341e:	suba.w 42e66 <ScrollerY>,a0
    3424:	move.l a0,-(sp)
    3426:	jsr 3b66 <__divsi3>
    342c:	addq.l #8,sp
    342e:	move.b d0,6088 <ScrollerDir>
				if (ScrollerDir > 6)
    3434:	cmpi.b #6,d0
    3438:	ble.w 26d0 <MainLoop+0x382>
					ScrollerDir = 6;
    343c:	move.b #6,6088 <ScrollerDir>
    3444:	bra.w 26d0 <MainLoop+0x382>
					ScrollerDir = 1;
    3448:	move.b #1,6088 <ScrollerDir>
    3450:	bra.w 26da <MainLoop+0x38c>
				if (ScrollerDir > -5)
    3454:	cmpi.b #-4,d0
    3458:	blt.w 26da <MainLoop+0x38c>
					ScrollerDir--;
    345c:	subq.b #1,d0
    345e:	move.b d0,6088 <ScrollerDir>
    3464:	bra.w 26da <MainLoop+0x38c>
			if (ScrollerPause > 0)
    3468:	move.w 42e64 <ScrollerPause>,d0
    346e:	beq.w 26e8 <MainLoop+0x39a>
				ScrollerPause--;
    3472:	subq.w #1,d0
    3474:	move.w d0,42e64 <ScrollerPause>
    347a:	bra.w 26e8 <MainLoop+0x39a>
		else if (ScrollerY <= ScrollerMin)
    347e:	cmpa.w #0,a0
    3482:	bgt.w 270a <MainLoop+0x3bc>
			ScrollerY = ScrollerMin;
    3486:	clr.w 42e66 <ScrollerY>
			ScrollerDir = 1;
    348c:	move.b #1,6088 <ScrollerDir>
			if (BounceEnabled)
    3494:	tst.w d5
    3496:	beq.s 34b8 <MainLoop+0x116a>
				if (ScrollerMax < SCRT_MAX)
    3498:	cmpi.w #39,d0
    349c:	bhi.s 34a6 <MainLoop+0x1158>
					ScrollerMax += ScrollerMax;
    349e:	add.w d0,d0
    34a0:	move.w d0,6086 <ScrollerMax>
				if (ScrollerMax > SCRT_MAX)
    34a6:	cmpi.w #40,6086 <ScrollerMax>
    34ae:	bls.s 34b8 <MainLoop+0x116a>
					ScrollerMax = SCRT_MAX;
    34b0:	move.w #40,6086 <ScrollerMax>
			if (ScrollerPause > 0)
    34b8:	move.w 42e64 <ScrollerPause>,d0
    34be:	beq.w 270a <MainLoop+0x3bc>
				ScrollerPause--;
    34c2:	subq.w #1,d0
    34c4:	move.w d0,42e64 <ScrollerPause>
    34ca:	bra.w 270a <MainLoop+0x3bc>
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    34ce:	pea 4 <_start+0x4>
    34d2:	pea 20 <_start+0x20>
    34d6:	pea 28 <_start+0x28>
    34da:	move.l 42f24 <BmpScroller+0xe>,-(sp)
    34e0:	subq.l #2,sp
    34e2:	move.l 42f44 <BmpScroller+0x2e>,-(sp)
    34e8:	move.l 42f40 <BmpScroller+0x2a>,-(sp)
    34ee:	move.l 42f3c <BmpScroller+0x26>,-(sp)
    34f4:	move.l 42f38 <BmpScroller+0x22>,-(sp)
    34fa:	move.l 42f34 <BmpScroller+0x1e>,-(sp)
    3500:	move.l 42f30 <BmpScroller+0x1a>,-(sp)
    3506:	move.l 42f2c <BmpScroller+0x16>,-(sp)
    350c:	move.l 42f28 <BmpScroller+0x12>,-(sp)
    3512:	move.l 42f24 <BmpScroller+0xe>,-(sp)
    3518:	move.l 42f20 <BmpScroller+0xa>,-(sp)
    351e:	move.l 42f1c <BmpScroller+0x6>,-(sp)
    3524:	move.l 42f18 <BmpScroller+0x2>,-(sp)
    352a:	move.w 42f16 <BmpScroller>,-(sp)
    3530:	jsr 58a <Scrollit>(pc)
    3534:	lea 68(sp),sp
    3538:	bra.w 2714 <MainLoop+0x3c6>
			MoveBobs();
    353c:	jsr 9a <MoveBobs>(pc)
    3540:	bra.w 2a8e <MainLoop+0x740>
}
    3544:	movem.l -80(a5),d2-d5/a2-a4
    354a:	unlk a5
    354c:	rts

0000354e <KPrintF>:
void KPrintF(const char* fmt, ...) {
    354e:	lea -128(sp),sp
    3552:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    3556:	move.w f0ff60 <_end+0xecce44>,d0
    355c:	cmpi.w #20153,d0
    3560:	beq.s 3584 <KPrintF+0x36>
    3562:	cmpi.w #-24562,d0
    3566:	beq.s 3584 <KPrintF+0x36>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    3568:	movea.l 43112 <SysBase>,a6
    356e:	movea.l 144(sp),a0
    3572:	lea 148(sp),a1
    3576:	lea 3be2 <KPutCharX>,a2
    357c:	suba.l a3,a3
    357e:	jsr -522(a6)
    3582:	bra.s 35ae <KPrintF+0x60>
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    3584:	movea.l 43112 <SysBase>,a6
    358a:	movea.l 144(sp),a0
    358e:	lea 148(sp),a1
    3592:	lea 3bf0 <PutChar>,a2
    3598:	lea 12(sp),a3
    359c:	jsr -522(a6)
		UaeDbgLog(86, temp);
    35a0:	move.l a3,-(sp)
    35a2:	pea 56 <_start+0x56>
    35a6:	jsr f0ff60 <_end+0xecce44>
    35ac:	addq.l #8,sp
}
    35ae:	movem.l (sp)+,a2-a3/a6
    35b2:	lea 128(sp),sp
    35b6:	rts

000035b8 <main>:
{
    35b8:	move.l a6,-(sp)
    35ba:	move.l a2,-(sp)
	SysBase = *((struct ExecBase **)4UL);
    35bc:	movea.l 4 <_start+0x4>,a6
    35c0:	move.l a6,43112 <SysBase>
	custom = (struct Custom *)0xdff000;
    35c6:	move.l #14675968,43118 <custom>
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
    35d0:	lea 562d <incbin_P61_Player_end+0x1>,a1
    35d6:	moveq #0,d0
    35d8:	jsr -552(a6)
    35dc:	move.l d0,4310e <GfxBase>
	if (!GfxBase)
    35e2:	beq.w 3a26 <main+0x46e>
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    35e6:	movea.l 43112 <SysBase>,a6
    35ec:	lea 563e <incbin_P61_Player_end+0x12>,a1
    35f2:	moveq #0,d0
    35f4:	jsr -552(a6)
    35f8:	move.l d0,4310a <DOSBase>
	if (!DOSBase)
    35fe:	beq.w 3a36 <main+0x47e>
	KPrintF("Hello debugger from Amiga!\n");
    3602:	pea 564a <incbin_P61_Player_end+0x1e>
    3608:	jsr 354e <KPrintF>(pc)
	BitmapInit(&Screen, 320, 256, 3);
    360c:	pea 3 <_start+0x3>
    3610:	pea 100 <MoveBobs+0x66>
    3614:	pea 140 <MoveBobs+0xa6>
    3618:	pea 430d8 <Screen>
    361e:	lea 14d8 <BitmapInit>(pc),a2
    3622:	jsr (a2)
	BitmapInit(&BmpMuerte, 320, 256, 5);
    3624:	pea 5 <_start+0x5>
    3628:	pea 100 <MoveBobs+0x66>
    362c:	pea 140 <MoveBobs+0xa6>
    3630:	pea 430a6 <BmpMuerte>
    3636:	jsr (a2)
	BitmapInit(&BmpLogo, 256, 130, 3);
    3638:	lea 36(sp),sp
    363c:	pea 3 <_start+0x3>
    3640:	pea 82 <_start+0x82>
    3644:	pea 100 <MoveBobs+0x66>
    3648:	pea 43074 <BmpLogo>
    364e:	jsr (a2)
	BitmapInit(&BmpLogo2, 256, 130, 3);
    3650:	pea 3 <_start+0x3>
    3654:	pea 82 <_start+0x82>
    3658:	pea 100 <MoveBobs+0x66>
    365c:	pea 43042 <BmpLogo2>
    3662:	jsr (a2)
	BitmapInit(&BmpLogo3, 256, 130, 3);
    3664:	lea 32(sp),sp
    3668:	pea 3 <_start+0x3>
    366c:	pea 82 <_start+0x82>
    3670:	pea 100 <MoveBobs+0x66>
    3674:	pea 43010 <BmpLogo3>
    367a:	jsr (a2)
	BitmapInit(&BmpLogo4, 256, 130, 3);
    367c:	pea 3 <_start+0x3>
    3680:	pea 82 <_start+0x82>
    3684:	pea 100 <MoveBobs+0x66>
    3688:	pea 42fde <BmpLogo4>
    368e:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF1, 320, 130, 3);
    3690:	lea 32(sp),sp
    3694:	pea 3 <_start+0x3>
    3698:	pea 82 <_start+0x82>
    369c:	pea 140 <MoveBobs+0xa6>
    36a0:	pea 42fac <BmpUpperPart_PF1>
    36a6:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF2, 320 + 64, 130, 3);
    36a8:	pea 3 <_start+0x3>
    36ac:	pea 82 <_start+0x82>
    36b0:	pea 180 <MoveBobs+0xe6>
    36b4:	pea 42f7a <BmpUpperPart_PF2>
    36ba:	jsr (a2)
	BitmapInit(&BmpUpperPart_Buf1, 320 + 64, 130, 3);
    36bc:	lea 32(sp),sp
    36c0:	pea 3 <_start+0x3>
    36c4:	pea 82 <_start+0x82>
    36c8:	pea 180 <MoveBobs+0xe6>
    36cc:	pea 42f48 <BmpUpperPart_Buf1>
    36d2:	jsr (a2)
	BitmapInit(&BmpScroller, 320 + 32, 166, 3);
    36d4:	pea 3 <_start+0x3>
    36d8:	pea a6 <MoveBobs+0xc>
    36dc:	pea 160 <MoveBobs+0xc6>
    36e0:	pea 42f16 <BmpScroller>
    36e6:	jsr (a2)
	BitmapInit(&BmpFont32, 320, 256, 3);
    36e8:	lea 32(sp),sp
    36ec:	pea 3 <_start+0x3>
    36f0:	pea 100 <MoveBobs+0x66>
    36f4:	pea 140 <MoveBobs+0xa6>
    36f8:	pea 42ee4 <BmpFont32>
    36fe:	jsr (a2)
	BitmapInit(&BmpCookie, 320, 256, 3);
    3700:	pea 3 <_start+0x3>
    3704:	pea 100 <MoveBobs+0x66>
    3708:	pea 140 <MoveBobs+0xa6>
    370c:	pea 42eb2 <BmpCookie>
    3712:	jsr (a2)
	BitmapInit(&BmpCookieMask, 320, 256, 3);
    3714:	lea 32(sp),sp
    3718:	pea 3 <_start+0x3>
    371c:	pea 100 <MoveBobs+0x66>
    3720:	pea 140 <MoveBobs+0xa6>
    3724:	pea 42e80 <BmpCookieMask>
    372a:	jsr (a2)
	copPtrMain = AllocMem(1024, MEMF_CHIP);
    372c:	movea.l 43112 <SysBase>,a6
    3732:	move.l #1024,d0
    3738:	moveq #2,d1
    373a:	jsr -198(a6)
    373e:	move.l d0,42e7c <copPtrMain>
	copPtrIntro = AllocMem(512, MEMF_CHIP);
    3744:	movea.l 43112 <SysBase>,a6
    374a:	move.l #512,d0
    3750:	moveq #2,d1
    3752:	jsr -198(a6)
    3756:	move.l d0,42e78 <copPtrIntro>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
    375c:	movea.l 43112 <SysBase>,a6
    3762:	moveq #0,d0
    3764:	move.w 42f22 <BmpScroller+0xc>,d0
    376a:	move.l #65538,d1
    3770:	jsr -198(a6)
    3774:	move.l d0,42f24 <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
    377a:	movea.l 43112 <SysBase>,a6
    3780:	moveq #0,d0
    3782:	move.w 42fb8 <BmpUpperPart_PF1+0xc>,d0
    3788:	move.l #65538,d1
    378e:	jsr -198(a6)
    3792:	move.l d0,42fba <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
    3798:	movea.l 43112 <SysBase>,a6
    379e:	moveq #0,d0
    37a0:	move.w 42f86 <BmpUpperPart_PF2+0xc>,d0
    37a6:	move.l #65538,d1
    37ac:	jsr -198(a6)
    37b0:	move.l d0,42f88 <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
    37b6:	movea.l 43112 <SysBase>,a6
    37bc:	moveq #0,d0
    37be:	move.w 42f54 <BmpUpperPart_Buf1+0xc>,d0
    37c4:	move.l #65538,d1
    37ca:	jsr -198(a6)
    37ce:	move.l d0,42f56 <BmpUpperPart_Buf1+0xe>
	BmpMuerte.ImageData = (UWORD *)BmpMuerteP;
    37d4:	move.l #24788,430b4 <BmpMuerte+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
    37de:	move.l #75990,43082 <BmpLogo+0xe>
	BmpLogo2.ImageData = (UWORD *)BmpLogo2P;
    37e8:	move.l #88472,43050 <BmpLogo2+0xe>
	BmpLogo3.ImageData = (UWORD *)BmpLogo3P;
    37f2:	move.l #100954,4301e <BmpLogo3+0xe>
	BmpLogo4.ImageData = (UWORD *)BmpLogo4P;
    37fc:	move.l #113436,42fec <BmpLogo4+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
    3806:	move.l #125918,42ef2 <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
    3810:	move.l #156640,42ec0 <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
    381a:	move.l #187362,42e8e <BmpCookieMask+0xe>
	InitImagePlanes(&BmpMuerte, 0);
    3824:	clr.l -(sp)
    3826:	pea 430a6 <BmpMuerte>
    382c:	lea 924 <InitImagePlanes>(pc),a2
    3830:	jsr (a2)
	InitImagePlanes(&BmpLogo, 0);
    3832:	clr.l -(sp)
    3834:	pea 43074 <BmpLogo>
    383a:	jsr (a2)
	InitImagePlanes(&BmpLogo2, 0);
    383c:	lea 32(sp),sp
    3840:	clr.l -(sp)
    3842:	pea 43042 <BmpLogo2>
    3848:	jsr (a2)
	InitImagePlanes(&BmpLogo3, 0);
    384a:	clr.l -(sp)
    384c:	pea 43010 <BmpLogo3>
    3852:	jsr (a2)
	InitImagePlanes(&BmpLogo4, 0);
    3854:	clr.l -(sp)
    3856:	pea 42fde <BmpLogo4>
    385c:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF1, 0);
    385e:	clr.l -(sp)
    3860:	pea 42fac <BmpUpperPart_PF1>
    3866:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF2, 32 / 8);
    3868:	lea 32(sp),sp
    386c:	pea 4 <_start+0x4>
    3870:	pea 42f7a <BmpUpperPart_PF2>
    3876:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_Buf1, 32 / 8);
    3878:	pea 4 <_start+0x4>
    387c:	pea 42f48 <BmpUpperPart_Buf1>
    3882:	jsr (a2)
	InitImagePlanes(&BmpScroller, 0);
    3884:	clr.l -(sp)
    3886:	pea 42f16 <BmpScroller>
    388c:	jsr (a2)
	InitImagePlanes(&BmpFont32, 0);
    388e:	clr.l -(sp)
    3890:	pea 42ee4 <BmpFont32>
    3896:	jsr (a2)
	InitImagePlanes(&BmpCookie, 0);
    3898:	lea 32(sp),sp
    389c:	clr.l -(sp)
    389e:	pea 42eb2 <BmpCookie>
    38a4:	jsr (a2)
	InitImagePlanes(&BmpCookieMask, 0);
    38a6:	clr.l -(sp)
    38a8:	pea 42e80 <BmpCookieMask>
    38ae:	jsr (a2)
	InitStarfieldSprite();
    38b0:	jsr 1512 <InitStarfieldSprite>(pc)
	SetupCopper(copPtrMain);
    38b4:	move.l 42e7c <copPtrMain>,-(sp)
    38ba:	jsr bf0 <SetupCopper>(pc)
	SetupCopperIntro(copPtrIntro);
    38be:	move.l 42e78 <copPtrIntro>,-(sp)
    38c4:	jsr 9de <SetupCopperIntro>(pc)
	TakeSystem();
    38c8:	jsr 798 <TakeSystem>(pc)
	WaitVbl();
    38cc:	jsr 752 <WaitVbl>(pc)
	custom->cop1lc = (ULONG)copPtrIntro;
    38d0:	movea.l 43118 <custom>,a0
    38d6:	move.l 42e78 <copPtrIntro>,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    38de:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
    38e4:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    38ea:	move.w #-30752,150(a0)
	SetInterruptHandler((APTR)interruptHandler);
    38f0:	pea 1488 <interruptHandler>(pc)
    38f4:	jsr 738 <SetInterruptHandler>(pc)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
    38f8:	movea.l 43118 <custom>,a0
    38fe:	move.w #-16352,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
    3904:	move.w #32,156(a0)
	IntroLoop();
    390a:	jsr 8c <IntroLoop>(pc)
    390e:	lea 28(sp),sp
    3912:	move.b bfe001 <_end+0xbbaee5>,d0
	while (MouseLeft())
    3918:	btst #6,d0
    391c:	beq.s 3912 <main+0x35a>
	WaitVbl();
    391e:	jsr 752 <WaitVbl>(pc)
	custom->cop1lc = (ULONG)copPtrMain;
    3922:	movea.l 43118 <custom>,a0
    3928:	move.l 42e7c <copPtrMain>,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    3930:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
    3936:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    393c:	move.w #-30752,150(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
    3942:	move.w #-24576,154(a0)
	if (p61Init(module) != 0)
    3948:	pea 353e4 <incbin_module_start>
    394e:	jsr 1444 <p61Init>(pc)
    3952:	addq.l #4,sp
    3954:	tst.l d0
    3956:	bne.w 3a42 <main+0x48a>
	MainLoop();
    395a:	jsr 234e <MainLoop>(pc)
	p61End();
    395e:	jsr 14b6 <p61End>(pc)
	FreeMem(copPtrMain, 1024);
    3962:	movea.l 43112 <SysBase>,a6
    3968:	movea.l 42e7c <copPtrMain>,a1
    396e:	move.l #1024,d0
    3974:	jsr -210(a6)
	FreeMem(copPtrIntro, 512);
    3978:	movea.l 43112 <SysBase>,a6
    397e:	movea.l 42e78 <copPtrIntro>,a1
    3984:	move.l #512,d0
    398a:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    398e:	movea.l 43112 <SysBase>,a6
    3994:	movea.l 42f24 <BmpScroller+0xe>,a1
    399a:	moveq #0,d0
    399c:	move.w 42f22 <BmpScroller+0xc>,d0
    39a2:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    39a6:	movea.l 43112 <SysBase>,a6
    39ac:	movea.l 42fba <BmpUpperPart_PF1+0xe>,a1
    39b2:	moveq #0,d0
    39b4:	move.w 42fb8 <BmpUpperPart_PF1+0xc>,d0
    39ba:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    39be:	movea.l 43112 <SysBase>,a6
    39c4:	movea.l 42f88 <BmpUpperPart_PF2+0xe>,a1
    39ca:	moveq #0,d0
    39cc:	move.w 42f86 <BmpUpperPart_PF2+0xc>,d0
    39d2:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_Buf1.ImageData, BmpUpperPart_PF2.Btot);
    39d6:	movea.l 43112 <SysBase>,a6
    39dc:	movea.l 42f56 <BmpUpperPart_Buf1+0xe>,a1
    39e2:	moveq #0,d0
    39e4:	move.w 42f86 <BmpUpperPart_PF2+0xc>,d0
    39ea:	jsr -210(a6)
	CloseLibrary((struct Library *)DOSBase);
    39ee:	movea.l 43112 <SysBase>,a6
    39f4:	movea.l 4310a <DOSBase>,a1
    39fa:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    39fe:	movea.l 43112 <SysBase>,a6
    3a04:	movea.l 4310e <GfxBase>,a1
    3a0a:	jsr -414(a6)
	FreeSystem();
    3a0e:	jsr 864 <FreeSystem>(pc)
	Exit(0);
    3a12:	movea.l 4310a <DOSBase>,a6
    3a18:	moveq #0,d1
    3a1a:	jsr -144(a6)
}
    3a1e:	moveq #0,d0
    3a20:	movea.l (sp)+,a2
    3a22:	movea.l (sp)+,a6
    3a24:	rts
		Exit(0);
    3a26:	movea.l 4310a <DOSBase>,a6
    3a2c:	moveq #0,d1
    3a2e:	jsr -144(a6)
    3a32:	bra.w 35e6 <main+0x2e>
		Exit(0);
    3a36:	movea.l d0,a6
    3a38:	moveq #0,d1
    3a3a:	jsr -144(a6)
    3a3e:	bra.w 3602 <main+0x4a>
		KPrintF("p61Init failed!\n");
    3a42:	pea 5666 <incbin_P61_Player_end+0x3a>
    3a48:	jsr 354e <KPrintF>(pc)
    3a4c:	addq.l #4,sp
    3a4e:	bra.w 395a <main+0x3a2>

00003a52 <strlen>:
unsigned long strlen(const char* s) {
    3a52:	movea.l 4(sp),a0
	unsigned long t=0;
    3a56:	moveq #0,d0
    3a58:	bra.s 3a5c <strlen+0xa>
		t++;
    3a5a:	addq.l #1,d0
	while(*s++)
    3a5c:	tst.b (a0)+
    3a5e:	bne.s 3a5a <strlen+0x8>
}
    3a60:	rts

00003a62 <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    3a62:	move.l d2,-(sp)
    3a64:	move.l 8(sp),d0
    3a68:	move.l 12(sp),d2
    3a6c:	move.l 16(sp),d1
	unsigned char *ptr = (unsigned char *)dest;
    3a70:	movea.l d0,a0
    3a72:	bra.s 3a78 <memset+0x16>
		*ptr++ = val;
    3a74:	move.b d2,(a0)+
	while(len-- > 0)
    3a76:	move.l a1,d1
    3a78:	movea.l d1,a1
    3a7a:	subq.l #1,a1
    3a7c:	tst.l d1
    3a7e:	bne.s 3a74 <memset+0x12>
}
    3a80:	move.l (sp)+,d2
    3a82:	rts

00003a84 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    3a84:	move.l d2,-(sp)
    3a86:	move.l 8(sp),d0
    3a8a:	movea.l 12(sp),a1
    3a8e:	move.l 16(sp),d1
	char *d = (char *)dest;
    3a92:	movea.l d0,a0
    3a94:	bra.s 3a9a <memcpy+0x16>
		*d++ = *s++;
    3a96:	move.b (a1)+,(a0)+
	while(len--)
    3a98:	move.l d2,d1
    3a9a:	move.l d1,d2
    3a9c:	subq.l #1,d2
    3a9e:	tst.l d1
    3aa0:	bne.s 3a96 <memcpy+0x12>
}
    3aa2:	move.l (sp)+,d2
    3aa4:	rts

00003aa6 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    3aa6:	move.l d2,-(sp)
    3aa8:	move.l 8(sp),d0
    3aac:	movea.l 12(sp),a0
    3ab0:	move.l 16(sp),d1
	if (d < s) {
    3ab4:	cmpa.l d0,a0
    3ab6:	bhi.s 3ad2 <memmove+0x2c>
		const char *lasts = s + (len - 1);
    3ab8:	movea.l d1,a1
    3aba:	subq.l #1,a1
    3abc:	adda.l a1,a0
		char *lastd = d + (len - 1);
    3abe:	adda.l d0,a1
		while (len--)
    3ac0:	bra.s 3ade <memmove+0x38>
			*d++ = *s++;
    3ac2:	move.b (a0)+,(a1)+
		while (len--)
    3ac4:	move.l d2,d1
    3ac6:	move.l d1,d2
    3ac8:	subq.l #1,d2
    3aca:	tst.l d1
    3acc:	bne.s 3ac2 <memmove+0x1c>
}
    3ace:	move.l (sp)+,d2
    3ad0:	rts
	char *d = dest;
    3ad2:	movea.l d0,a1
    3ad4:	bra.s 3ac6 <memmove+0x20>
			*lastd-- = *lasts--;
    3ad6:	move.b (a0),(a1)
    3ad8:	subq.l #1,a1
    3ada:	subq.l #1,a0
		while (len--)
    3adc:	move.l d2,d1
    3ade:	move.l d1,d2
    3ae0:	subq.l #1,d2
    3ae2:	tst.l d1
    3ae4:	bne.s 3ad6 <memmove+0x30>
    3ae6:	bra.s 3ace <memmove+0x28>

00003ae8 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    3ae8:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    3aec:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    3af0:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    3af4:	mulu.w 8(sp),d1
	addw	d1, d0
    3af8:	add.w d1,d0
	swap	d0
    3afa:	swap d0
	clrw	d0
    3afc:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    3afe:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    3b02:	mulu.w 10(sp),d1
	addl	d1, d0
    3b06:	add.l d1,d0
	rts
    3b08:	rts

00003b0a <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    3b0a:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    3b0c:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    3b10:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    3b14:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    3b1a:	bcc.s 3b32 <__udivsi3+0x28>
	movel	d0, d2
    3b1c:	move.l d0,d2
	clrw	d2
    3b1e:	clr.w d2
	swap	d2
    3b20:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    3b22:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    3b24:	move.w d2,d0
	swap	d0
    3b26:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    3b28:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    3b2c:	divu.w d1,d2
	movew	d2, d0
    3b2e:	move.w d2,d0
	jra	6f
    3b30:	bra.s 3b62 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    3b32:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    3b34:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    3b36:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    3b38:	cmpi.l #65536,d1
	jcc	4b
    3b3e:	bcc.s 3b34 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    3b40:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    3b42:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    3b48:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    3b4a:	mulu.w d0,d1
	swap	d2
    3b4c:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    3b4e:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    3b50:	swap d2
	tstw	d2		/* high part 17 bits? */
    3b52:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    3b54:	bne.s 3b60 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    3b56:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    3b58:	bcs.s 3b60 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    3b5a:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    3b5e:	bls.s 3b62 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    3b60:	subq.l #1,d0

6:	movel	sp@+, d2
    3b62:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    3b64:	rts

00003b66 <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    3b66:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    3b68:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    3b6a:	move.l 12(sp),d1
	jpl	1f
    3b6e:	bpl.s 3b74 <__divsi3+0xe>
	negl	d1
    3b70:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    3b72:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    3b74:	move.l 8(sp),d0
	jpl	2f
    3b78:	bpl.s 3b7e <__divsi3+0x18>
	negl	d0
    3b7a:	neg.l d0
	negb	d2
    3b7c:	neg.b d2

2:	movel	d1, sp@-
    3b7e:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3b80:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    3b82:	bsr.s 3b0a <__udivsi3>
	addql	#8, sp
    3b84:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    3b86:	tst.b d2
	jpl	3f
    3b88:	bpl.s 3b8c <__divsi3+0x26>
	negl	d0
    3b8a:	neg.l d0

3:	movel	sp@+, d2
    3b8c:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    3b8e:	rts

00003b90 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    3b90:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    3b94:	move.l 4(sp),d0
	movel	d1, sp@-
    3b98:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3b9a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    3b9c:	bsr.s 3b66 <__divsi3>
	addql	#8, sp
    3b9e:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    3ba0:	move.l 8(sp),d1
	movel	d1, sp@-
    3ba4:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3ba6:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    3ba8:	bsr.w 3ae8 <__mulsi3>
	addql	#8, sp
    3bac:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    3bae:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    3bb2:	sub.l d0,d1
	movel	d1, d0
    3bb4:	move.l d1,d0
	rts
    3bb6:	rts

00003bb8 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    3bb8:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    3bbc:	move.l 4(sp),d0
	movel	d1, sp@-
    3bc0:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3bc2:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    3bc4:	bsr.w 3b0a <__udivsi3>
	addql	#8, sp
    3bc8:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    3bca:	move.l 8(sp),d1
	movel	d1, sp@-
    3bce:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3bd0:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    3bd2:	bsr.w 3ae8 <__mulsi3>
	addql	#8, sp
    3bd6:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    3bd8:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    3bdc:	sub.l d0,d1
	movel	d1, d0
    3bde:	move.l d1,d0
	rts
    3be0:	rts

00003be2 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    3be2:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    3be4:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    3be8:	jsr -516(a6)
    move.l (sp)+, a6
    3bec:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    3bee:	rts

00003bf0 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    3bf0:	move.b d0,(a3)+
	rts
    3bf2:	rts

00003bf4 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    3bf4:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    3bf6:	adda.l a0,a2
	move.l	a2,a3
    3bf8:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    3bfa:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    3bfc:	moveq #56,d4
	moveq	#8,d5
    3bfe:	moveq #8,d5
	bra.s	.Lliteral
    3c00:	bra.s 3c6a <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    3c02:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    3c04:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    3c06:	dbf d1,3c02 <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    3c0a:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    3c0c:	bcc.s 3c10 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    3c0e:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    3c10:	tst.w d0
    3c12:	bne.s 3c1c <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    3c14:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    3c16:	bls.s 3c8e <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    3c18:	move.w (a0)+,d0
    3c1a:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    3c1c:	rol.l #6,d0
	move.w	d0,d1
    3c1e:	move.w d0,d1
	and.w	d4,d1
    3c20:	and.w d4,d1
	eor.w	d1,d0
    3c22:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    3c24:	movem.w (3c88 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    3c2a:	rol.l d2,d0
	and.w	d0,d3					|scaling
    3c2c:	and.w d0,d3
	eor.w	d3,d0
    3c2e:	eor.w d3,d0
	suba.w	d3,a4
    3c30:	suba.w d3,a4
	adda.l	a1,a4
    3c32:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    3c34:	tst.w d0
    3c36:	bne.s 3c3c <_doynaxdepack_asm+0x48>
    3c38:	move.w (a0)+,d0
    3c3a:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    3c3c:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    3c3e:	beq.s 3c56 <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    3c40:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    3c42:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    3c44:	bpl.s 3c52 <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    3c46:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    3c48:	bpl.s 3c50 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    3c4a:	addx.b d1,d1
	lsl.l	#2,d0
    3c4c:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    3c4e:	bmi.s 3c4a <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    3c50:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    3c52:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    3c54:	bcc.s 3c58 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    3c56:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    3c58:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    3c5a:	dbf d1,3c56 <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    3c5e:	add.l d0,d0
	bcc.s	.Lmatch
    3c60:	bcc.s 3c10 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    3c62:	tst.w d0
    3c64:	bne.s 3c6a <_doynaxdepack_asm+0x76>
    3c66:	move.w (a0)+,d0
    3c68:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    3c6a:	moveq #0,d1
	add.l	d0,d0
    3c6c:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    3c6e:	bcc.s 3c0e <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    3c70:	bpl.s 3c78 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    3c72:	addx.b d1,d1
	lsl.l	#2,d0
    3c74:	lsl.l #2,d0
	bmi.s	.Llgetlen
    3c76:	bmi.s 3c72 <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    3c78:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    3c7a:	dbv.s d1,3c02 <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    3c7e:	add.l d0,d0
	eor.w	d1,d0		
    3c80:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    3c82:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    3c84:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    3c86:	bra.s 3c7a <_doynaxdepack_asm+0x86>

00003c88 <doy_table>:
    3c88:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    3c98:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    3ca8:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    3cb8:	.............o
