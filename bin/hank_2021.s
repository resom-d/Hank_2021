
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
       4:	move.l #32984,d3
       a:	subi.l #32984,d3
      10:	asr.l #2,d3
	for (i = 0; i < count; i++)
      12:	moveq #0,d2
      14:	bra.s 2a <_start+0x2a>
		__preinit_array_start[i]();
      16:	move.l d2,d0
      18:	add.l d2,d0
      1a:	add.l d0,d0
      1c:	lea 80d8 <NextPlot>,a0
      22:	movea.l (0,a0,d0.l),a0
      26:	jsr (a0)
	for (i = 0; i < count; i++)
      28:	addq.l #1,d2
      2a:	cmp.l d2,d3
      2c:	bhi.s 16 <_start+0x16>

	count = __init_array_end - __init_array_start;
      2e:	move.l #32984,d3
      34:	subi.l #32984,d3
      3a:	asr.l #2,d3
	for (i = 0; i < count; i++)
      3c:	moveq #0,d2
      3e:	bra.s 54 <_start+0x54>
		__init_array_start[i]();
      40:	move.l d2,d0
      42:	add.l d2,d0
      44:	add.l d0,d0
      46:	lea 80d8 <NextPlot>,a0
      4c:	movea.l (0,a0,d0.l),a0
      50:	jsr (a0)
	for (i = 0; i < count; i++)
      52:	addq.l #1,d2
      54:	cmp.l d2,d3
      56:	bhi.s 40 <_start+0x40>

	main();
      58:	jsr 374c <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
      5e:	move.l #32984,d2
      64:	subi.l #32984,d2
      6a:	asr.l #2,d2
	for (i = count; i > 0; i--)
      6c:	bra.s 82 <_start+0x82>
		__fini_array_start[i - 1]();
      6e:	subq.l #1,d2
      70:	move.l d2,d0
      72:	add.l d2,d0
      74:	add.l d0,d0
      76:	lea 80d8 <NextPlot>,a0
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

int p61Init(const void *module);
void p61Music(void);
void p61End(void);

inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
      8c:	move.b bfe001 <_end+0xbb8ded>,d0
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
      9e:	move.w 44f54 <BobPhase>,d0
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
      b4:	lea 80da <BobVecs>,a1
      ba:	move.l d0,d3
      bc:	lsl.l #3,d3
      be:	movea.l d3,a0
      c0:	add.l (0,a1,d3.l),d1
      c4:	lea 811a <BobTarget>,a1
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
      ea:	lea 811a <BobTarget>,a0
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
     116:	move.l 8112 <BobVecs+0x38>,d1
     11c:	move.l d1,d0
     11e:	add.l 8152 <BobTarget+0x38>,d0
     124:	move.l d0,8152 <BobTarget+0x38>
		if (BobTarget[BOBSN - 1].X > 320 + 32)
     12a:	cmpi.l #352,d0
     130:	ble.s 13c <MoveBobs+0xa2>
			BobTarget[BOBSN - 1].X = 320 + 32;
     132:	move.l #352,8152 <BobTarget+0x38>
		if (BobTarget[0].X >= 320 + 32)
     13c:	cmpi.l #351,811a <BobTarget>
     146:	ble.w ae <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     14a:	neg.l 80da <BobVecs>
			BobVecs[1].X *= -1;
     150:	neg.l 80e2 <BobVecs+0x8>
			BobVecs[2].X *= -1;
     156:	neg.l 80ea <BobVecs+0x10>
			BobVecs[3].X *= -1;
     15c:	neg.l 80f2 <BobVecs+0x18>
			BobVecs[4].X *= -1;
     162:	neg.l 80fa <BobVecs+0x20>
			BobVecs[5].X *= -1;
     168:	neg.l 8102 <BobVecs+0x28>
			BobVecs[6].X *= -1;
     16e:	neg.l 810a <BobVecs+0x30>
			BobVecs[7].X *= -1;
     174:	neg.l d1
     176:	move.l d1,8112 <BobVecs+0x38>
			BobPhase = 1;
     17c:	move.w #1,44f54 <BobPhase>
			BobPause = 2 * 50;
     184:	move.w #100,44f56 <BobPause>
			*copPF1BmpP = 0 << 6; // prio. in bplcon2: pf1 >> pf 2 >> sprites
     18c:	movea.l 44f50 <copPF1BmpP>,a0
     192:	clr.w (a0)
     194:	bra.w ae <MoveBobs+0x14>
				BobTarget[b].X += BobVecs[b].X;
     198:	lea 80da <BobVecs>,a1
     19e:	move.l d0,d3
     1a0:	lsl.l #3,d3
     1a2:	movea.l d3,a0
     1a4:	add.l (0,a1,d3.l),d1
     1a8:	lea 811a <BobTarget>,a1
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
     1bc:	lea 811a <BobTarget>,a0
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
     1f2:	move.l 8112 <BobVecs+0x38>,d1
     1f8:	move.l d1,d0
     1fa:	add.l 8152 <BobTarget+0x38>,d0
     200:	move.l d0,8152 <BobTarget+0x38>
		if (BobTarget[BOBSN - 1].X < 0)
     206:	bmi.s 260 <MoveBobs+0x1c6>
		if (BobTarget[0].X <= 0)
     208:	tst.l 811a <BobTarget>
     20e:	bgt.w ae <MoveBobs+0x14>
			BobVecs[0].X *= -1;
     212:	neg.l 80da <BobVecs>
			BobVecs[1].X *= -1;
     218:	neg.l 80e2 <BobVecs+0x8>
			BobVecs[2].X *= -1;
     21e:	neg.l 80ea <BobVecs+0x10>
			BobVecs[3].X *= -1;
     224:	neg.l 80f2 <BobVecs+0x18>
			BobVecs[4].X *= -1;
     22a:	neg.l 80fa <BobVecs+0x20>
			BobVecs[5].X *= -1;
     230:	neg.l 8102 <BobVecs+0x28>
			BobVecs[6].X *= -1;
     236:	neg.l 810a <BobVecs+0x30>
			BobVecs[7].X *= -1;
     23c:	neg.l d1
     23e:	move.l d1,8112 <BobVecs+0x38>
			BobPause = 2 * 50;
     244:	move.w #100,44f56 <BobPause>
			BobPhase = 0;
     24c:	clr.w 44f54 <BobPhase>
			*copPF1BmpP = 1 << 6; // prio. in bplcon2: pf2 >> pf 1 >> sprites
     252:	movea.l 44f50 <copPF1BmpP>,a0
     258:	move.w #64,(a0)
     25c:	bra.w ae <MoveBobs+0x14>
			BobTarget[BOBSN - 1].X = 0;
     260:	clr.l 8152 <BobTarget+0x38>
     266:	bra.s 208 <MoveBobs+0x16e>

00000268 <EnableMirrorEffect>:

void EnableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2),
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
     268:	move.w 45014 <BmpScroller+0x8>,d0
     26e:	move.w d0,d1
     270:	sub.w 451d4 <Screen+0x6>,d1
     276:	add.w d0,d0
     278:	sub.w d0,d1
	copSetBplMod(0, copMirrorBmpP,
     27a:	movea.l 44f2c <copMirrorBmpP>,a0
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
     294:	move.w 45014 <BmpScroller+0x8>,d0
     29a:	sub.w 451d4 <Screen+0x6>,d0
	copSetBplMod(0, copMirrorBmpP,
     2a0:	movea.l 44f2c <copMirrorBmpP>,a0
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

000002ba <LightsUp>:

void LightsUp(BYTE *phase)
{
     2ba:	movea.l 4(sp),a0
	static USHORT pause = 0;

	if (pause > 0)
     2be:	move.w 44f2a <pause.0>,d0
     2c4:	bne.s 2e8 <LightsUp+0x2e>
	{
		pause--;
		return;
	}
	switch (*phase)
     2c6:	move.b (a0),d0
     2c8:	cmpi.b #4,d0
     2cc:	bhi.s 2f0 <LightsUp+0x36>
     2ce:	andi.l #255,d0
     2d4:	add.l d0,d0
     2d6:	move.w (2de <LightsUp+0x24>,pc,d0.l),d0
     2da:	jmp (2de <LightsUp+0x24>,pc,d0.w)
     2de:	ori.b #-104,(a4)
     2e2:	.short 0x00c8
     2e4:	.short 0x00f8
     2e6:	btst d0,21312(a0)
		pause--;
     2ea:	move.w d0,44f2a <pause.0>
		break;

	default:
		break;
	}
}
     2f0:	rts
		copSetColor(copLightUp[0], 0, 0x111);
     2f2:	movea.l 44f30 <copLightUp>,a0
    *copListEnd++ = COP_SKIP;
    return copListEnd;
}
inline USHORT *copSetColor(USHORT *copListCurrent, USHORT index, USHORT color)
{
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     2f8:	move.w #384,(a0)
    *copListCurrent++ = color;
     2fc:	move.w #273,2(a0)
		copSetColor(copLightUp[1], 0, 0x222);
     302:	movea.l 44f34 <copLightUp+0x4>,a0
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     308:	move.w #384,(a0)
    *copListCurrent++ = color;
     30c:	move.w #546,2(a0)
		copSetColor(copLightUp[2], 0, 0x111);
     312:	movea.l 44f38 <copLightUp+0x8>,a0
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     318:	move.w #384,(a0)
    *copListCurrent++ = color;
     31c:	move.w #273,2(a0)
		copSetColor(copLightUp[3], 0, 0x222);
     322:	movea.l 44f3c <copLightUp+0xc>,a0
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     328:	move.w #384,(a0)
    *copListCurrent++ = color;
     32c:	move.w #546,2(a0)
		copSetColor(copLightUp[4], 0, 0x111);
     332:	movea.l 44f40 <copLightUp+0x10>,a0
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     338:	move.w #384,(a0)
    *copListCurrent++ = color;
     33c:	move.w #273,2(a0)
		copSetColor(copLightUp[5], 0, 0x222);
     342:	movea.l 44f44 <copLightUp+0x14>,a0
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     348:	move.w #384,(a0)
    *copListCurrent++ = color;
     34c:	move.w #546,2(a0)
		copSetColor(copLightUp[6], 0, 0x111);
     352:	movea.l 44f48 <copLightUp+0x18>,a0
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     358:	move.w #384,(a0)
    *copListCurrent++ = color;
     35c:	move.w #273,2(a0)
		copSetColor(copLightUp[7], 0, 0x222);
     362:	movea.l 44f4c <copLightUp+0x1c>,a0
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     368:	move.w #384,(a0)
    *copListCurrent++ = color;
     36c:	move.w #546,2(a0)
    return copListCurrent;
     372:	bra.w 2f0 <LightsUp+0x36>
		copSetColor(copLightUp[0], 0, 0x6bf);
     376:	movea.l 44f30 <copLightUp>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     37c:	move.w #384,(a1)
    *copListCurrent++ = color;
     380:	move.w #1727,2(a1)
		copSetColor(copLightUp[1], 0, 0x49b);
     386:	movea.l 44f34 <copLightUp+0x4>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     38c:	move.w #384,(a1)
    *copListCurrent++ = color;
     390:	move.w #1179,2(a1)
		pause = 35;
     396:	move.w #35,44f2a <pause.0>
		*phase = 2;
     39e:	move.b #2,(a0)
		break;
     3a2:	bra.w 2f0 <LightsUp+0x36>
		copSetColor(copLightUp[2], 0, 0x6bf);
     3a6:	movea.l 44f38 <copLightUp+0x8>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     3ac:	move.w #384,(a1)
    *copListCurrent++ = color;
     3b0:	move.w #1727,2(a1)
		copSetColor(copLightUp[3], 0, 0x49b);
     3b6:	movea.l 44f3c <copLightUp+0xc>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     3bc:	move.w #384,(a1)
    *copListCurrent++ = color;
     3c0:	move.w #1179,2(a1)
		pause = 35;
     3c6:	move.w #35,44f2a <pause.0>
		*phase = 3;
     3ce:	move.b #3,(a0)
		break;
     3d2:	bra.w 2f0 <LightsUp+0x36>
		copSetColor(copLightUp[4], 0, 0x6bf);
     3d6:	movea.l 44f40 <copLightUp+0x10>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     3dc:	move.w #384,(a1)
    *copListCurrent++ = color;
     3e0:	move.w #1727,2(a1)
		copSetColor(copLightUp[5], 0, 0x49b);
     3e6:	movea.l 44f44 <copLightUp+0x14>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     3ec:	move.w #384,(a1)
    *copListCurrent++ = color;
     3f0:	move.w #1179,2(a1)
		pause = 35;
     3f6:	move.w #35,44f2a <pause.0>
		*phase= 4;
     3fe:	move.b #4,(a0)
		break;
     402:	bra.w 2f0 <LightsUp+0x36>
		copSetColor(copLightUp[6], 0, 0x6bf);
     406:	movea.l 44f48 <copLightUp+0x18>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     40c:	move.w #384,(a1)
    *copListCurrent++ = color;
     410:	move.w #1727,2(a1)
		copSetColor(copLightUp[7], 0, 0x49b);
     416:	movea.l 44f4c <copLightUp+0x1c>,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     41c:	move.w #384,(a1)
    *copListCurrent++ = color;
     420:	move.w #1179,2(a1)
		pause = 35;
     426:	move.w #35,44f2a <pause.0>
		*phase = 5;
     42e:	move.b #5,(a0)
		break;
     432:	bra.w 2f0 <LightsUp+0x36>

00000436 <PlotChar>:
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
	}
}

void PlotChar(BmpDescriptor bmpFont, BmpDescriptor bmpDest, USHORT plotY, USHORT charW, USHORT charH)
{
     436:	movem.l d2-d6/a2/a6,-(sp)
     43a:	move.l 136(sp),d5
     43e:	move.l 140(sp),d3
     442:	move.l 144(sp),d4
	UBYTE chr = Scrolltext[ScrolltextCnt++];
     446:	move.w 44f26 <ScrolltextCnt>,d0
     44c:	move.w d0,d1
     44e:	addq.w #1,d1
     450:	move.w d1,44f26 <ScrolltextCnt>
     456:	andi.l #65535,d0
     45c:	lea 580b <Scrolltext>,a0
     462:	move.b (0,a0,d0.l),d0
	ULONG source, dest;
	ULONG row, col;

	// Set standard char distance
	NextPlot = 32;
     466:	move.w #32,80d8 <NextPlot>
	// scroller commands: b=bounce; m=mirror; s=stop; c=color
	if (chr == 'b')
     46e:	cmpi.b #98,d0
     472:	beq.w 5ae <PlotChar+0x178>
		}
		BounceEnabled = !BounceEnabled;

		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'm')
     476:	cmpi.b #109,d0
     47a:	beq.w 5f8 <PlotChar+0x1c2>
		}

		MirrorEnabled = !MirrorEnabled;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 's')
     47e:	cmpi.b #115,d0
     482:	beq.w 640 <PlotChar+0x20a>
	{
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'c')
     486:	cmpi.b #99,d0
     48a:	beq.w 6c6 <PlotChar+0x290>
			LightsUpPhase = 1;
			LightsUpEnabled = TRUE;
		}
	}
	// select character for different spacing
	if (chr == '!' || chr == 'I' || chr == '.' || chr == ',' || chr == ':' || chr == ';' || chr == '\'')
     48e:	cmpi.b #33,d0
     492:	beq.s 4b8 <PlotChar+0x82>
     494:	cmpi.b #73,d0
     498:	beq.s 4b8 <PlotChar+0x82>
     49a:	cmpi.b #46,d0
     49e:	beq.s 4b8 <PlotChar+0x82>
     4a0:	cmpi.b #44,d0
     4a4:	beq.s 4b8 <PlotChar+0x82>
     4a6:	cmpi.b #58,d0
     4aa:	beq.s 4b8 <PlotChar+0x82>
     4ac:	cmpi.b #59,d0
     4b0:	beq.s 4b8 <PlotChar+0x82>
     4b2:	cmpi.b #39,d0
     4b6:	bne.s 4c0 <PlotChar+0x8a>
	{
		NextPlot = 12;
     4b8:	move.w #12,80d8 <NextPlot>
	}
	if (chr == 'J')
     4c0:	cmpi.b #74,d0
     4c4:	beq.w 6f2 <PlotChar+0x2bc>
	{
		NextPlot = 24;
	}
	// check for end of text
	if (chr == 0)
     4c8:	tst.b d0
     4ca:	bne.s 4dc <PlotChar+0xa6>
	{
		ScrolltextCnt = 0;
     4cc:	clr.w 44f26 <ScrolltextCnt>
		chr = Scrolltext[ScrolltextCnt++];		
     4d2:	move.w #1,44f26 <ScrolltextCnt>
     4da:	moveq #32,d0
	}
	// check legal values
	if (chr < 32 || chr > (32 + 80))
     4dc:	addi.b #-32,d0
     4e0:	cmpi.b #80,d0
     4e4:	bhi.w 5a8 <PlotChar+0x172>
		return;
	}
	// skip first 32 ascii codes
	chr -= 32;
	// get row and column of source bitmap (10 chrs per row)
	row = chr / 10;
     4e8:	andi.w #255,d0
     4ec:	move.w d0,d6
     4ee:	mulu.w #-13107,d6
     4f2:	clr.w d6
     4f4:	swap d6
     4f6:	lsr.w #3,d6
	col = chr % 10;
     4f8:	move.w d6,d1
     4fa:	add.w d6,d1
     4fc:	add.w d1,d1
     4fe:	add.w d6,d1
     500:	add.w d1,d1
     502:	sub.w d1,d0
     504:	moveq #0,d2
     506:	move.b d0,d2
	// calc source bitplane pointer
	source = (row * bmpFont.Bplt * charH) + (col << 2);
     508:	moveq #0,d0
     50a:	move.w 40(sp),d0
     50e:	lea 3c7c <__mulsi3>,a2
     514:	moveq #31,d1
     516:	and.l d6,d1
     518:	move.l d1,-(sp)
     51a:	move.l d0,-(sp)
     51c:	jsr (a2)
     51e:	addq.l #8,sp
     520:	move.l d0,-(sp)
     522:	move.w d4,-(sp)
     524:	clr.w -(sp)
     526:	jsr (a2)
     528:	addq.l #8,sp
     52a:	add.l d2,d2
     52c:	add.l d2,d2
     52e:	add.l d0,d2
	// calc destination bitplane pointer
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
     530:	moveq #0,d0
     532:	move.w 92(sp),d0
     536:	move.l d0,-(sp)
     538:	move.w d5,-(sp)
     53a:	clr.w -(sp)
     53c:	jsr (a2)
     53e:	addq.l #8,sp
     540:	moveq #0,d5
     542:	move.w 451d4 <Screen+0x6>,d5
     548:	add.l d0,d5
	// wait for blitter and blit
	WaitBlit();
     54a:	movea.l 45204 <GfxBase>,a6
     550:	jsr -228(a6)
	custom->bltcon0 = 0x09f0;
     554:	movea.l 4520e <custom>,a0
     55a:	move.w #2544,64(a0)
	custom->bltcon1 = 0x0000;
     560:	move.w #0,66(a0)
	custom->bltafwm = 0xffff;
     566:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     56c:	move.w #-1,70(a0)
	custom->bltapt = ((UBYTE *)bmpFont.ImageData) + source;
     572:	add.l 46(sp),d2
     576:	move.l d2,80(a0)
	custom->bltdpt = ((UBYTE *)bmpDest.ImageData) + dest;
     57a:	add.l 98(sp),d5
     57e:	move.l d5,84(a0)
	custom->bltamod = bmpFont.Bpl - charW / 8;
     582:	move.w d3,d0
     584:	lsr.w #3,d0
     586:	move.w 38(sp),d1
     58a:	sub.w d0,d1
     58c:	move.w d1,100(a0)
	custom->bltdmod = bmpDest.Bpl - charW / 8;
     590:	move.w 90(sp),d1
     594:	sub.w d0,d1
     596:	move.w d1,102(a0)
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
     59a:	muls.w 36(sp),d4
     59e:	lsl.w #6,d4
     5a0:	lsr.w #4,d3
     5a2:	add.w d4,d3
     5a4:	move.w d3,88(a0)
}
     5a8:	movem.l (sp)+,d2-d6/a2/a6
     5ac:	rts
		if (BounceEnabled)
     5ae:	move.w 44f60 <BounceEnabled>,d0
     5b4:	beq.s 5cc <PlotChar+0x196>
			ScrollerY = SCRT_MIN;
     5b6:	clr.w 44f5e <ScrollerY>
			ScrollerDir = 1;
     5bc:	move.b #1,815c <ScrollerDir>
			ScrollerMax = 4;
     5c4:	move.w #4,815a <ScrollerMax>
		BounceEnabled = !BounceEnabled;
     5cc:	tst.w d0
     5ce:	seq d0
     5d0:	ext.w d0
     5d2:	neg.w d0
     5d4:	move.w d0,44f60 <BounceEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     5da:	move.w d1,d0
     5dc:	addq.w #1,d0
     5de:	move.w d0,44f26 <ScrolltextCnt>
     5e4:	andi.l #65535,d1
     5ea:	lea 580b <Scrolltext>,a0
     5f0:	move.b (0,a0,d1.l),d0
     5f4:	bra.w 476 <PlotChar+0x40>
		if (MirrorEnabled)
     5f8:	tst.w 44f24 <MirrorEnabled>
     5fe:	beq.s 63a <PlotChar+0x204>
			DisableMirrorEffect();
     600:	jsr 294 <DisableMirrorEffect>(pc)
		MirrorEnabled = !MirrorEnabled;
     604:	tst.w 44f24 <MirrorEnabled>
     60a:	seq d0
     60c:	ext.w d0
     60e:	neg.w d0
     610:	move.w d0,44f24 <MirrorEnabled>
		chr = Scrolltext[ScrolltextCnt++];
     616:	move.w 44f26 <ScrolltextCnt>,d0
     61c:	move.w d0,d1
     61e:	addq.w #1,d1
     620:	move.w d1,44f26 <ScrolltextCnt>
     626:	andi.l #65535,d0
     62c:	lea 580b <Scrolltext>,a0
     632:	move.b (0,a0,d0.l),d0
     636:	bra.w 47e <PlotChar+0x48>
			EnableMirrorEffect();
     63a:	jsr 268 <EnableMirrorEffect>(pc)
     63e:	bra.s 604 <PlotChar+0x1ce>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     640:	tst.w 44f60 <BounceEnabled>
     646:	beq.s 698 <PlotChar+0x262>
     648:	move.w 44f26 <ScrolltextCnt>,d0
     64e:	move.w d0,d1
     650:	addq.w #1,d1
     652:	move.w d1,44f26 <ScrolltextCnt>
     658:	andi.l #65535,d0
     65e:	lea 580b <Scrolltext>,a0
     664:	move.b (0,a0,d0.l),d0
     668:	ext.w d0
     66a:	addi.w #-48,d0
     66e:	move.w d0,44f5c <ScrollerPause>
		chr = Scrolltext[ScrolltextCnt++];
     674:	move.w 44f26 <ScrolltextCnt>,d0
     67a:	move.w d0,d1
     67c:	addq.w #1,d1
     67e:	move.w d1,44f26 <ScrolltextCnt>
     684:	andi.l #65535,d0
     68a:	lea 580b <Scrolltext>,a0
     690:	move.b (0,a0,d0.l),d0
     694:	bra.w 486 <PlotChar+0x50>
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
     698:	move.w 44f26 <ScrolltextCnt>,d0
     69e:	move.w d0,d1
     6a0:	addq.w #1,d1
     6a2:	move.w d1,44f26 <ScrolltextCnt>
     6a8:	andi.l #65535,d0
     6ae:	lea 580b <Scrolltext>,a0
     6b4:	move.b (0,a0,d0.l),d0
     6b8:	ext.w d0
     6ba:	movea.w d0,a0
     6bc:	moveq #-48,d0
     6be:	add.l a0,d0
     6c0:	muls.w #50,d0
     6c4:	bra.s 66e <PlotChar+0x238>
		if (LightsUpEnabled)
     6c6:	tst.w 44f22 <LightsUpEnabled>
     6cc:	beq.s 6de <PlotChar+0x2a8>
			LightsUpPhase = 0;
     6ce:	clr.b 44f6d <LightsUpPhase>
			LightsUpEnabled = FALSE;
     6d4:	clr.w 44f22 <LightsUpEnabled>
     6da:	bra.w 48e <PlotChar+0x58>
			LightsUpPhase = 1;
     6de:	move.b #1,44f6d <LightsUpPhase>
			LightsUpEnabled = TRUE;
     6e6:	move.w #1,44f22 <LightsUpEnabled>
     6ee:	bra.w 48e <PlotChar+0x58>
		NextPlot = 24;
     6f2:	move.w #24,80d8 <NextPlot>
     6fa:	bra.w 4c8 <PlotChar+0x92>

000006fe <Scrollit>:
{
     6fe:	movem.l d2-d7/a2/a6,-(sp)
     702:	move.l 96(sp),d3
     706:	move.l 100(sp),d4
	int BltOffs = startY * theDesc.Bplt;
     70a:	moveq #0,d5
     70c:	move.w 94(sp),d5
     710:	moveq #0,d6
     712:	move.w 44(sp),d6
     716:	lea 3c7c <__mulsi3>,a2
     71c:	move.l d6,-(sp)
     71e:	move.l d5,-(sp)
     720:	jsr (a2)
     722:	addq.l #8,sp
     724:	move.l d0,d2
	int Brcorner = height * theDesc.Bplt - 2;
     726:	move.l d6,-(sp)
     728:	move.w d3,-(sp)
     72a:	clr.w -(sp)
     72c:	jsr (a2)
     72e:	addq.l #8,sp
     730:	move.l d0,d7
     732:	subq.l #2,d7
	WaitBlit();
     734:	movea.l 45204 <GfxBase>,a6
     73a:	jsr -228(a6)
	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
     73e:	clr.w d6
     740:	move.b d4,d6
     742:	moveq #12,d0
     744:	lsl.w d0,d4
     746:	movea.l 4520e <custom>,a0
     74c:	addi.w #2544,d4
     750:	move.w d4,64(a0)
	custom->bltcon1 = 0x0002;
     754:	move.w #2,66(a0)
	custom->bltafwm = 0xffff;
     75a:	move.w #-1,68(a0)
	custom->bltalwm = 0xffff;
     760:	move.w #-1,70(a0)
	custom->bltapt = theBitmap + BltOffs + Brcorner;
     766:	move.l d2,d0
     768:	add.l d7,d0
     76a:	add.l 88(sp),d0
     76e:	move.l d0,80(a0)
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
     772:	move.l d0,84(a0)
	custom->bltamod = 0;
     776:	move.w #0,100(a0)
	custom->bltdmod = 0;
     77c:	move.w #0,102(a0)
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;
     782:	move.w 40(sp),d0
     786:	muls.w d3,d0
     788:	lsl.w #6,d0
     78a:	move.w 4500c <BmpScroller>,d1
     790:	lsr.w #4,d1
     792:	add.w d1,d0
     794:	move.w d0,88(a0)
	ScrollCnt += speed;
     798:	add.w 44f28 <ScrollCnt>,d6
     79e:	move.w d6,44f28 <ScrollCnt>
	if (ScrollCnt >= NextPlot)
     7a4:	cmp.w 80d8 <NextPlot>,d6
     7aa:	bcc.s 7b2 <Scrollit+0xb4>
}
     7ac:	movem.l (sp)+,d2-d7/a2/a6
     7b0:	rts
		ScrollCnt = 0;
     7b2:	clr.w 44f28 <ScrollCnt>
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
     7b8:	pea 20 <_start+0x20>
     7bc:	pea 20 <_start+0x20>
     7c0:	move.l d5,-(sp)
     7c2:	subq.l #2,sp
     7c4:	move.l 4503a <BmpScroller+0x2e>,-(sp)
     7ca:	move.l 45036 <BmpScroller+0x2a>,-(sp)
     7d0:	move.l 45032 <BmpScroller+0x26>,-(sp)
     7d6:	move.l 4502e <BmpScroller+0x22>,-(sp)
     7dc:	move.l 4502a <BmpScroller+0x1e>,-(sp)
     7e2:	move.l 45026 <BmpScroller+0x1a>,-(sp)
     7e8:	move.l 45022 <BmpScroller+0x16>,-(sp)
     7ee:	move.l 4501e <BmpScroller+0x12>,-(sp)
     7f4:	move.l 4501a <BmpScroller+0xe>,-(sp)
     7fa:	move.l 45016 <BmpScroller+0xa>,-(sp)
     800:	move.l 45012 <BmpScroller+0x6>,-(sp)
     806:	move.l 4500e <BmpScroller+0x2>,-(sp)
     80c:	move.w 4500c <BmpScroller>,-(sp)
     812:	subq.l #2,sp
     814:	move.l 45008 <BmpFont32+0x2e>,-(sp)
     81a:	move.l 45004 <BmpFont32+0x2a>,-(sp)
     820:	move.l 45000 <BmpFont32+0x26>,-(sp)
     826:	move.l 44ffc <BmpFont32+0x22>,-(sp)
     82c:	move.l 44ff8 <BmpFont32+0x1e>,-(sp)
     832:	move.l 44ff4 <BmpFont32+0x1a>,-(sp)
     838:	move.l 44ff0 <BmpFont32+0x16>,-(sp)
     83e:	move.l 44fec <BmpFont32+0x12>,-(sp)
     844:	move.l 44fe8 <BmpFont32+0xe>,-(sp)
     84a:	move.l 44fe4 <BmpFont32+0xa>,-(sp)
     850:	move.l 44fe0 <BmpFont32+0x6>,-(sp)
     856:	move.l 44fdc <BmpFont32+0x2>,-(sp)
     85c:	move.w 44fda <BmpFont32>,-(sp)
     862:	jsr 436 <PlotChar>(pc)
     866:	lea 116(sp),sp
     86a:	bra.w 7ac <Scrollit+0xae>

0000086e <GetVBR>:

static APTR GetVBR()
{
     86e:	subq.l #8,sp
     870:	move.l a6,-(sp)
     872:	move.l d7,-(sp)
	APTR vbr = 0;
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE
     874:	move.w #20090,10(sp)
     87a:	move.w #2049,12(sp)
     880:	move.w #20083,14(sp)

	if (SysBase->AttnFlags & AFF_68010)
     886:	movea.l 45208 <SysBase>,a6
     88c:	btst #0,297(a6)
     892:	beq.s 8a8 <GetVBR+0x3a>
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);
     894:	moveq #10,d7
     896:	add.l sp,d7
     898:	exg d7,a5
     89a:	jsr -30(a6)
     89e:	exg d7,a5

	return vbr;
}
     8a0:	move.l (sp)+,d7
     8a2:	movea.l (sp)+,a6
     8a4:	addq.l #8,sp
     8a6:	rts
	APTR vbr = 0;
     8a8:	moveq #0,d0
	return vbr;
     8aa:	bra.s 8a0 <GetVBR+0x32>

000008ac <SetInterruptHandler>:

void SetInterruptHandler(APTR interrupt)
{
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
     8ac:	movea.l 44f1e <VBR>,a0
     8b2:	move.l 4(sp),108(a0)
}
     8b8:	rts

000008ba <GetInterruptHandler>:

APTR GetInterruptHandler()
{
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
     8ba:	movea.l 44f1e <VBR>,a0
     8c0:	move.l 108(a0),d0
}
     8c4:	rts

000008c6 <WaitVbl>:

//vblank begins at vpos 312 hpos 1 and ends at vpos 25 hpos 1
//vsync begins at line 2 hpos 132 and ends at vpos 5 hpos 18
void WaitVbl()
{
     8c6:	subq.l #8,sp
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     8c8:	move.l dff004 <_end+0xdb9df0>,d0
     8ce:	move.l d0,(sp)
		vpos &= 0x1ff00;
     8d0:	move.l (sp),d0
     8d2:	andi.l #130816,d0
     8d8:	move.l d0,(sp)
		if (vpos != (311 << 8))
     8da:	move.l (sp),d0
     8dc:	cmpi.l #79616,d0
     8e2:	beq.s 8c8 <WaitVbl+0x2>
			break;
	}
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
     8e4:	move.l dff004 <_end+0xdb9df0>,d0
     8ea:	move.l d0,4(sp)
		vpos &= 0x1ff00;
     8ee:	move.l 4(sp),d0
     8f2:	andi.l #130816,d0
     8f8:	move.l d0,4(sp)
		if (vpos == (311 << 8))
     8fc:	move.l 4(sp),d0
     900:	cmpi.l #79616,d0
     906:	bne.s 8e4 <WaitVbl+0x1e>
			break;
	}
}
     908:	addq.l #8,sp
     90a:	rts

0000090c <TakeSystem>:
	{
	} //blitter busy wait
}

void TakeSystem()
{
     90c:	move.l a6,-(sp)
     90e:	move.l a2,-(sp)
	ActiView = GfxBase->ActiView; //store current view
     910:	movea.l 45204 <GfxBase>,a6
     916:	move.l 34(a6),44f1a <ActiView>
	OwnBlitter();
     91e:	jsr -456(a6)
	WaitBlit();
     922:	movea.l 45204 <GfxBase>,a6
     928:	jsr -228(a6)
	Disable();
     92c:	movea.l 45208 <SysBase>,a6
     932:	jsr -120(a6)

	//Save current interrupts and DMA settings so we can restore them upon exit.
	SystemADKCON = custom->adkconr;
     936:	movea.l 4520e <custom>,a0
     93c:	move.w 16(a0),d0
     940:	move.w d0,44f18 <SystemADKCON>
	SystemInts = custom->intenar;
     946:	move.w 28(a0),d0
     94a:	move.w d0,44f16 <SystemInts>
	SystemDMA = custom->dmaconr;
     950:	move.w 2(a0),d0
     954:	move.w d0,44f14 <SystemDMA>
	custom->intena = 0x7fff; //disable all interrupts
     95a:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     960:	move.w #32767,156(a0)

	WaitVbl();
     966:	lea 8c6 <WaitVbl>(pc),a2
     96a:	jsr (a2)
	WaitVbl();
     96c:	jsr (a2)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     96e:	movea.l 4520e <custom>,a0
     974:	move.w #32767,150(a0)

	//set all colors black
	for (int a = 0; a < 32; a++)
     97a:	moveq #0,d1
     97c:	bra.s 990 <TakeSystem+0x84>
		custom->color[a] = 0;
     97e:	move.l d1,d0
     980:	addi.l #192,d0
     986:	add.l d0,d0
     988:	move.w #0,(0,a0,d0.l)
	for (int a = 0; a < 32; a++)
     98e:	addq.l #1,d1
     990:	moveq #31,d0
     992:	cmp.l d1,d0
     994:	bge.s 97e <TakeSystem+0x72>

	LoadView(0);
     996:	movea.l 45204 <GfxBase>,a6
     99c:	suba.l a1,a1
     99e:	jsr -222(a6)
	WaitTOF();
     9a2:	movea.l 45204 <GfxBase>,a6
     9a8:	jsr -270(a6)
	WaitTOF();
     9ac:	movea.l 45204 <GfxBase>,a6
     9b2:	jsr -270(a6)

	WaitVbl();
     9b6:	lea 8c6 <WaitVbl>(pc),a2
     9ba:	jsr (a2)
	WaitVbl();
     9bc:	jsr (a2)

	VBR = GetVBR();
     9be:	jsr 86e <GetVBR>(pc)
     9c2:	move.l d0,44f1e <VBR>
	SystemIrq = GetInterruptHandler(); //store interrupt register
     9c8:	jsr 8ba <GetInterruptHandler>(pc)
     9cc:	move.l d0,44f10 <SystemIrq>
}
     9d2:	movea.l (sp)+,a2
     9d4:	movea.l (sp)+,a6
     9d6:	rts

000009d8 <FreeSystem>:

void FreeSystem()
{
     9d8:	move.l a6,-(sp)
	WaitVbl();
     9da:	jsr 8c6 <WaitVbl>(pc)
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
     9de:	movea.l 4520e <custom>,a0
     9e4:	move.w 2(a0),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
     9e8:	move.w 2(a0),d0
     9ec:	btst #14,d0
     9f0:	bne.s 9e8 <FreeSystem+0x10>
	WaitBlt();
	custom->intena = 0x7fff; //disable all interrupts
     9f2:	move.w #32767,154(a0)
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
     9f8:	move.w #32767,156(a0)
	custom->dmacon = 0x7fff; //Clear all DMA channels
     9fe:	move.w #32767,150(a0)

	//restore interrupts
	SetInterruptHandler(SystemIrq);
     a04:	move.l 44f10 <SystemIrq>,-(sp)
     a0a:	jsr 8ac <SetInterruptHandler>(pc)

	/*Restore system copper list(s). */
	custom->cop1lc = (ULONG)GfxBase->copinit;
     a0e:	movea.l 45204 <GfxBase>,a6
     a14:	movea.l 4520e <custom>,a0
     a1a:	move.l 38(a6),128(a0)
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
     a20:	move.l 50(a6),132(a0)
	custom->copjmp1 = 0x7fff; //start coppper
     a26:	move.w #32767,136(a0)

	/*Restore all interrupts and DMA settings. */
	custom->intena = SystemInts | 0x8000;
     a2c:	move.w 44f16 <SystemInts>,d0
     a32:	ori.w #-32768,d0
     a36:	move.w d0,154(a0)
	custom->dmacon = SystemDMA | 0x8000;
     a3a:	move.w 44f14 <SystemDMA>,d0
     a40:	ori.w #-32768,d0
     a44:	move.w d0,150(a0)
	custom->adkcon = SystemADKCON | 0x8000;
     a48:	move.w 44f18 <SystemADKCON>,d0
     a4e:	ori.w #-32768,d0
     a52:	move.w d0,158(a0)

	LoadView(ActiView);
     a56:	movea.l 44f1a <ActiView>,a1
     a5c:	jsr -222(a6)
	WaitTOF();
     a60:	movea.l 45204 <GfxBase>,a6
     a66:	jsr -270(a6)
	WaitTOF();
     a6a:	movea.l 45204 <GfxBase>,a6
     a70:	jsr -270(a6)
	WaitBlit();
     a74:	movea.l 45204 <GfxBase>,a6
     a7a:	jsr -228(a6)
	DisownBlitter();
     a7e:	movea.l 45204 <GfxBase>,a6
     a84:	jsr -462(a6)
	Enable();
     a88:	movea.l 45208 <SysBase>,a6
     a8e:	jsr -126(a6)
     a92:	addq.l #4,sp
}
     a94:	movea.l (sp)+,a6
     a96:	rts

00000a98 <InitImagePlanes>:

void InitImagePlanes(BmpDescriptor *img, USHORT offs)
{
     a98:	movem.l d2-d4/a2,-(sp)
     a9c:	movea.l 20(sp),a2
     aa0:	move.w 26(sp),d4
	for (int p = 0; p < img->Bpls; p++)
     aa4:	moveq #0,d2
     aa6:	bra.s ad2 <InitImagePlanes+0x3a>
	{
		img->Planes[p] = ((UBYTE *)img->ImageData) + offs + (p * (img->Bpl));
     aa8:	move.l 14(a2),d3
     aac:	moveq #0,d0
     aae:	move.w 6(a2),d0
     ab2:	move.l d2,-(sp)
     ab4:	move.l d0,-(sp)
     ab6:	jsr 3c7c <__mulsi3>
     abc:	addq.l #8,sp
     abe:	moveq #0,d1
     ac0:	move.w d4,d1
     ac2:	add.l d1,d0
     ac4:	move.l d2,d1
     ac6:	add.l d2,d1
     ac8:	add.l d1,d1
     aca:	add.l d0,d3
     acc:	move.l d3,(18,a2,d1.l)
	for (int p = 0; p < img->Bpls; p++)
     ad0:	addq.l #1,d2
     ad2:	moveq #0,d0
     ad4:	move.w 4(a2),d0
     ad8:	cmp.l d0,d2
     ada:	blt.s aa8 <InitImagePlanes+0x10>
	}
}
     adc:	movem.l (sp)+,d2-d4/a2
     ae0:	rts

00000ae2 <copSetPlanesInterleafed>:

USHORT *copSetPlanesInterleafed(UBYTE bplPtrStart, USHORT *copListEnd, const UBYTE *bitmap, int numPlanes, int Bpl, int offsY)
{
     ae2:	movem.l d2-d5/a2-a3,-(sp)
     ae6:	movea.l 32(sp),a2
     aea:	move.l 40(sp),d2
     aee:	move.l 44(sp),d3
     af2:	move.b 31(sp),d4
	ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     af6:	lea 3c7c <__mulsi3>,a3
     afc:	move.l d3,-(sp)
     afe:	move.l 52(sp),-(sp)
     b02:	jsr (a3)
     b04:	addq.l #8,sp
     b06:	move.l d2,-(sp)
     b08:	move.l d0,-(sp)
     b0a:	jsr (a3)
     b0c:	addq.l #8,sp
     b0e:	add.l 36(sp),d0
	for (USHORT i = 0; i < numPlanes; i++)
     b12:	suba.l a0,a0
     b14:	bra.s b42 <copSetPlanesInterleafed+0x60>
	{
		*copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]);
     b16:	moveq #0,d5
     b18:	move.b d4,d5
     b1a:	movea.l d1,a1
     b1c:	lea (56,a1,d5.l),a1
     b20:	move.l a1,d1
     b22:	add.w a1,d1
     b24:	add.w d1,d1
     b26:	move.w d1,(a2)
		*copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     b28:	move.l d0,d5
     b2a:	clr.w d5
     b2c:	swap d5
     b2e:	move.w d5,2(a2)
		*copListEnd++ = offsetof(struct Custom, bplpt[i + bplPtrStart]) + 2;
     b32:	addq.w #2,d1
     b34:	move.w d1,4(a2)
		*copListEnd++ = (UWORD)addr; // high-word of adress
     b38:	move.w d0,6(a2)
		addr += Bpl;
     b3c:	add.l d3,d0
	for (USHORT i = 0; i < numPlanes; i++)
     b3e:	addq.w #1,a0
		*copListEnd++ = (UWORD)addr; // high-word of adress
     b40:	addq.l #8,a2
	for (USHORT i = 0; i < numPlanes; i++)
     b42:	moveq #0,d1
     b44:	move.w a0,d1
     b46:	cmp.l d1,d2
     b48:	bgt.s b16 <copSetPlanesInterleafed+0x34>
	}
	return copListEnd;
}
     b4a:	move.l a2,d0
     b4c:	movem.l (sp)+,d2-d5/a2-a3
     b50:	rts

00000b52 <SetupCopperIntro>:
{
     b52:	move.l a2,-(sp)
     b54:	movea.l 8(sp),a1
	*copPtr++ = DIWSTRT;
     b58:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     b5c:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     b62:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     b68:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     b6e:	move.w #146,8(a1)
	*copPtr++ = 0x38;
     b74:	move.w #56,10(a1)
	*copPtr++ = DDFSTOP;
     b7a:	move.w #148,12(a1)
	*copPtr++ = 0xd0;
     b80:	move.w #208,14(a1)
	copPtr = copSetBplMod(0, copPtr, BmpMuerte.Bplt - Screen.Bpl, BmpMuerte.Bplt - Screen.Bpl);
     b86:	move.w 451a4 <BmpMuerte+0x8>,d0
     b8c:	sub.w 451d4 <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     b92:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     b98:	move.w d0,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     b9c:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     ba2:	move.w d0,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     ba6:	move.w #258,24(a1)
	*copPtr++ = 0;
     bac:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     bb0:	move.w #260,28(a1)
	*copPtr++ = 0 << 6;	 //pf2 >> pf 1 >> sprites
     bb6:	lea 32(a1),a0
     bba:	clr.w 30(a1)
	for (int a = 0; a < 32; a++)
     bbe:	moveq #0,d0
     bc0:	bra.s be0 <SetupCopperIntro+0x8e>
		copPtr = copSetColor(copPtr, a, muertePaletteRGB4[a]);
     bc2:	movea.l d0,a1
     bc4:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     bc6:	move.w d0,d1
     bc8:	addi.w #192,d1
     bcc:	add.w d1,d1
     bce:	move.w d1,(a0)
    *copListCurrent++ = color;
     bd0:	lea 5fe8 <muertePaletteRGB4>,a2
     bd6:	move.w (0,a2,a1.l),2(a0)
	for (int a = 0; a < 32; a++)
     bdc:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, muertePaletteRGB4[a]);
     bde:	addq.l #4,a0
	for (int a = 0; a < 32; a++)
     be0:	moveq #31,d1
     be2:	cmp.l d0,d1
     be4:	bge.s bc2 <SetupCopperIntro+0x70>
	copPtr = copSetPlanesInterleafed(0, copPtr, BmpMuerte.Planes[0], BmpMuerte.Bpls, BmpMuerte.Bpl, 0);
     be6:	clr.l -(sp)
     be8:	moveq #0,d0
     bea:	move.w 451a2 <BmpMuerte+0x6>,d0
     bf0:	move.l d0,-(sp)
     bf2:	moveq #0,d0
     bf4:	move.w 451a0 <BmpMuerte+0x4>,d0
     bfa:	move.l d0,-(sp)
     bfc:	move.l 451ae <BmpMuerte+0x12>,-(sp)
     c02:	move.l a0,-(sp)
     c04:	clr.l -(sp)
     c06:	jsr ae2 <copSetPlanesInterleafed>(pc)
     c0a:	movea.l d0,a0
	*copPtr++ = SPR0PTH;
     c0c:	move.w #288,(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     c10:	move.l #280874,d0
     c16:	move.l d0,d1
     c18:	swap d1
     c1a:	ext.l d1
     c1c:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
     c20:	move.w #290,4(a0)
	*copPtr++ = (LONG)NullSprite;
     c26:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
     c2a:	move.w #292,8(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     c30:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
     c34:	move.w #294,12(a0)
	*copPtr++ = (LONG)NullSprite;
     c3a:	move.w d0,14(a0)
	*copPtr++ = SPR2PTH;
     c3e:	move.w #296,16(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     c44:	move.w d1,18(a0)
	*copPtr++ = SPR2PTL;
     c48:	move.w #298,20(a0)
	*copPtr++ = (LONG)NullSprite;
     c4e:	move.w d0,22(a0)
	*copPtr++ = SPR3PTH;
     c52:	move.w #300,24(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     c58:	move.w d1,26(a0)
	*copPtr++ = SPR3PTL;
     c5c:	move.w #302,28(a0)
	*copPtr++ = (LONG)NullSprite;
     c62:	move.w d0,30(a0)
	*copPtr++ = SPR4PTH;
     c66:	move.w #304,32(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     c6c:	move.w d1,34(a0)
	*copPtr++ = SPR4PTL;
     c70:	move.w #306,36(a0)
	*copPtr++ = (LONG)NullSprite;
     c76:	move.w d0,38(a0)
	*copPtr++ = SPR5PTH;
     c7a:	move.w #308,40(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     c80:	move.w d1,42(a0)
	*copPtr++ = SPR5PTL;
     c84:	move.w #310,44(a0)
	*copPtr++ = (LONG)NullSprite;
     c8a:	move.w d0,46(a0)
	*copPtr++ = SPR6PTH;
     c8e:	move.w #312,48(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     c94:	move.w d1,50(a0)
	*copPtr++ = SPR6PTL;
     c98:	move.w #314,52(a0)
	*copPtr++ = (LONG)NullSprite;
     c9e:	move.w d0,54(a0)
	*copPtr++ = SPR7PTH;
     ca2:	move.w #316,56(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     ca8:	move.w d1,58(a0)
	*copPtr++ = SPR7PTL;
     cac:	move.w #318,60(a0)
	*copPtr++ = (LONG)NullSprite;
     cb2:	move.w d0,62(a0)
	*copPtr++ = BPLCON0;
     cb6:	move.w #256,64(a0)
	*copPtr++ = ((BmpMuerte.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     cbc:	moveq #0,d0
     cbe:	move.w 451a0 <BmpMuerte+0x4>,d0
     cc4:	moveq #12,d1
     cc6:	lsl.l d1,d0
     cc8:	ori.w #512,d0
     ccc:	move.w d0,66(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     cd0:	move.w #-1,68(a0)
    *copListEnd++ = COP_WAIT;
     cd6:	move.w #-2,70(a0)
     cdc:	lea 24(sp),sp
}
     ce0:	movea.l (sp)+,a2
     ce2:	rts

00000ce4 <copSetPlanesInterleafedOddEven>:

USHORT *copSetPlanesInterleafedOddEven(UBYTE bplPtrStart, USHORT *copListEnd, const UBYTE *bitmap, int numPlanes, int Bpl, int offsY, BOOL odd)
{
     ce4:	movem.l d2-d6/a2-a3,-(sp)
     ce8:	movea.l 36(sp),a2
     cec:	move.l 44(sp),d3
     cf0:	move.l 48(sp),d4
     cf4:	move.b 35(sp),d5
	ULONG addr = (ULONG)bitmap + (offsY * Bpl * numPlanes);
     cf8:	lea 3c7c <__mulsi3>,a3
     cfe:	move.l d4,-(sp)
     d00:	move.l 56(sp),-(sp)
     d04:	jsr (a3)
     d06:	addq.l #8,sp
     d08:	move.l d3,-(sp)
     d0a:	move.l d0,-(sp)
     d0c:	jsr (a3)
     d0e:	addq.l #8,sp
     d10:	add.l 40(sp),d0
	BYTE plane = odd ? 1 : 0;
     d14:	tst.w 58(sp)
     d18:	sne d2
     d1a:	neg.b d2
	for (USHORT i = 0; i < numPlanes; i++)
     d1c:	suba.l a0,a0
     d1e:	bra.s d54 <copSetPlanesInterleafedOddEven+0x70>
	{
		*copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]);
     d20:	move.b d2,d6
     d22:	ext.w d6
     d24:	moveq #0,d1
     d26:	move.b d5,d1
     d28:	movea.w d6,a1
     d2a:	movea.l d1,a3
     d2c:	lea (56,a1,a3.l),a1
     d30:	move.l a1,d1
     d32:	add.w a1,d1
     d34:	add.w d1,d1
     d36:	move.w d1,(a2)
		*copListEnd++ = (UWORD)(addr >> 16); // low-word of adress
     d38:	move.l d0,d6
     d3a:	clr.w d6
     d3c:	swap d6
     d3e:	move.w d6,2(a2)
		*copListEnd++ = offsetof(struct Custom, bplpt[plane + bplPtrStart]) + 2;
     d42:	addq.w #2,d1
     d44:	move.w d1,4(a2)
		*copListEnd++ = (UWORD)addr; // high-word of adress
     d48:	move.w d0,6(a2)
		addr += Bpl;
     d4c:	add.l d4,d0
		plane += 2;
     d4e:	addq.b #2,d2
	for (USHORT i = 0; i < numPlanes; i++)
     d50:	addq.w #1,a0
		*copListEnd++ = (UWORD)addr; // high-word of adress
     d52:	addq.l #8,a2
	for (USHORT i = 0; i < numPlanes; i++)
     d54:	moveq #0,d1
     d56:	move.w a0,d1
     d58:	cmp.l d1,d3
     d5a:	bgt.s d20 <copSetPlanesInterleafedOddEven+0x3c>
	}
	return copListEnd;
}
     d5c:	move.l a2,d0
     d5e:	movem.l (sp)+,d2-d6/a2-a3
     d62:	rts

00000d64 <SetupCopper>:
{
     d64:	move.l a2,-(sp)
     d66:	move.l d2,-(sp)
     d68:	movea.l 12(sp),a1
	*copPtr++ = DIWSTRT;
     d6c:	move.w #142,(a1)
	*copPtr++ = 0x2c81;
     d70:	move.w #11393,2(a1)
	*copPtr++ = DIWSTOP;
     d76:	move.w #144,4(a1)
	*copPtr++ = 0x2cc1;
     d7c:	move.w #11457,6(a1)
	*copPtr++ = DDFSTRT;
     d82:	move.w #146,8(a1)
	*copPtr++ = 0x38;
     d88:	move.w #56,10(a1)
	*copPtr++ = DDFSTOP;
     d8e:	move.w #148,12(a1)
	*copPtr++ = 0xd0;
     d94:	move.w #208,14(a1)
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - Screen.Bpl, BmpUpperPart_PF2.Bplt - Screen.Bpl);
     d9a:	move.w 451d4 <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
     da0:	move.w #264,16(a1)
    *copListEnd++ = modOdd;
     da6:	move.w 450aa <BmpUpperPart_PF1+0x8>,d1
     dac:	sub.w d0,d1
     dae:	move.w d1,18(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
     db2:	move.w #266,20(a1)
    *copListEnd++ = modEven;
     db8:	movea.w 45078 <BmpUpperPart_PF2+0x8>,a0
     dbe:	suba.w d0,a0
     dc0:	move.w a0,22(a1)
	*copPtr++ = BPLCON1; //scrolling
     dc4:	move.w #258,24(a1)
	*copPtr++ = 0;
     dca:	clr.w 26(a1)
	*copPtr++ = BPLCON2; //playfied priority
     dce:	move.w #260,28(a1)
	copPF1BmpP = copPtr;
     dd4:	lea 30(a1),a0
     dd8:	move.l a0,44f50 <copPF1BmpP>
	*copPtr++ = BobPhase == 0 ? 1 << 6 : 0; //pf2 >> pf 1 >> sprites
     dde:	tst.w 44f54 <BobPhase>
     de4:	bne.s e12 <SetupCopper+0xae>
     de6:	moveq #64,d0
     de8:	move.w d0,30(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     dec:	move.w #384,32(a1)
    *copListCurrent++ = color;
     df2:	move.w #21,34(a1)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     df8:	move.w #400,36(a1)
    *copListCurrent++ = color;
     dfe:	lea 40(a1),a0
     e02:	move.w #21,38(a1)
	copPF1ColP = copPtr;
     e08:	move.l a0,44f62 <copPF1ColP>
	for (int a = 1; a < 8; a++)
     e0e:	moveq #1,d0
     e10:	bra.s e34 <SetupCopper+0xd0>
	*copPtr++ = BobPhase == 0 ? 1 << 6 : 0; //pf2 >> pf 1 >> sprites
     e12:	clr.w d0
     e14:	bra.s de8 <SetupCopper+0x84>
		copPtr = copSetColor(copPtr, a, ActPfCol[a]);
     e16:	move.l d0,d1
     e18:	add.l d0,d1
     e1a:	movea.l 819e <ActPfCol>,a1
     e20:	move.w (0,a1,d1.l),2(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     e26:	move.w d0,d1
     e28:	addi.w #192,d1
     e2c:	add.w d1,d1
     e2e:	move.w d1,(a0)
	for (int a = 1; a < 8; a++)
     e30:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, ActPfCol[a]);
     e32:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
     e34:	moveq #7,d1
     e36:	cmp.l d0,d1
     e38:	bge.s e16 <SetupCopper+0xb2>
	for (int a = 9; a < 16; a++)
     e3a:	moveq #9,d0
     e3c:	bra.s e5e <SetupCopper+0xfa>
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     e3e:	move.l d0,d1
     e40:	subq.l #8,d1
     e42:	add.l d1,d1
     e44:	movea.w d0,a1
     e46:	lea 192(a1),a1
     e4a:	adda.w a1,a1
     e4c:	move.w a1,(a0)
    *copListCurrent++ = color;
     e4e:	lea 6038 <CookiePaletteRGB4>,a1
     e54:	move.w (0,a1,d1.l),2(a0)
	for (int a = 9; a < 16; a++)
     e5a:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
     e5c:	addq.l #4,a0
	for (int a = 9; a < 16; a++)
     e5e:	moveq #15,d1
     e60:	cmp.l d0,d1
     e62:	bge.s e3e <SetupCopper+0xda>
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.Planes[0], BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
     e64:	clr.l -(sp)
     e66:	clr.l -(sp)
     e68:	moveq #0,d0
     e6a:	move.w 450a8 <BmpUpperPart_PF1+0x6>,d0
     e70:	move.l d0,-(sp)
     e72:	moveq #0,d0
     e74:	move.w 450a6 <BmpUpperPart_PF1+0x4>,d0
     e7a:	move.l d0,-(sp)
     e7c:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
     e82:	move.l a0,-(sp)
     e84:	clr.l -(sp)
     e86:	lea ce4 <copSetPlanesInterleafedOddEven>(pc),a2
     e8a:	jsr (a2)
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.Planes[0], BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
     e8c:	pea 1 <_start+0x1>
     e90:	clr.l -(sp)
     e92:	moveq #0,d1
     e94:	move.w 45076 <BmpUpperPart_PF2+0x6>,d1
     e9a:	move.l d1,-(sp)
     e9c:	moveq #0,d1
     e9e:	move.w 45074 <BmpUpperPart_PF2+0x4>,d1
     ea4:	move.l d1,-(sp)
     ea6:	move.l 45082 <BmpUpperPart_PF2+0x12>,-(sp)
     eac:	move.l d0,-(sp)
     eae:	clr.l -(sp)
     eb0:	jsr (a2)
     eb2:	movea.l d0,a0
	*copPtr++ = SPR0PTH;
     eb4:	move.w #288,(a0)
	*copPtr++ = (LONG)StarSprite >> 16;
     eb8:	move.l #281634,d0
     ebe:	move.l d0,d1
     ec0:	swap d1
     ec2:	ext.l d1
     ec4:	move.w d1,2(a0)
	*copPtr++ = SPR0PTL;
     ec8:	move.w #290,4(a0)
	*copPtr++ = (LONG)StarSprite;
     ece:	move.w d0,6(a0)
	*copPtr++ = SPR1PTH;
     ed2:	move.w #292,8(a0)
	*copPtr++ = (LONG)StarSprite2 >> 16;
     ed8:	move.l #280886,d0
     ede:	move.l d0,d1
     ee0:	swap d1
     ee2:	ext.l d1
     ee4:	move.w d1,10(a0)
	*copPtr++ = SPR1PTL;
     ee8:	move.w #294,12(a0)
	*copPtr++ = (LONG)StarSprite2;
     eee:	move.w d0,14(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     ef2:	move.w #418,16(a0)
    *copListCurrent++ = color;
     ef8:	move.w #2120,18(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     efe:	move.w #420,20(a0)
    *copListCurrent++ = color;
     f04:	move.w #143,22(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
     f0a:	move.w #422,24(a0)
    *copListCurrent++ = color;
     f10:	move.w #4095,26(a0)
	*copPtr++ = SPR2PTH;
     f16:	move.w #296,28(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     f1c:	move.l #280874,d0
     f22:	move.l d0,d1
     f24:	swap d1
     f26:	ext.l d1
     f28:	move.w d1,30(a0)
	*copPtr++ = SPR2PTL;
     f2c:	move.w #298,32(a0)
	*copPtr++ = (LONG)NullSprite;
     f32:	move.w d0,34(a0)
	*copPtr++ = SPR3PTH;
     f36:	move.w #300,36(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     f3c:	move.w d1,38(a0)
	*copPtr++ = SPR3PTL;
     f40:	move.w #302,40(a0)
	*copPtr++ = (LONG)NullSprite;
     f46:	move.w d0,42(a0)
	*copPtr++ = SPR4PTH;
     f4a:	move.w #304,44(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     f50:	move.w d1,46(a0)
	*copPtr++ = SPR4PTL;
     f54:	move.w #306,48(a0)
	*copPtr++ = (LONG)NullSprite;
     f5a:	move.w d0,50(a0)
	*copPtr++ = SPR5PTH;
     f5e:	move.w #308,52(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     f64:	move.w d1,54(a0)
	*copPtr++ = SPR5PTL;
     f68:	move.w #310,56(a0)
	*copPtr++ = (LONG)NullSprite;
     f6e:	move.w d0,58(a0)
	*copPtr++ = SPR6PTH;
     f72:	move.w #312,60(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     f78:	move.w d1,62(a0)
	*copPtr++ = SPR6PTL;
     f7c:	move.w #314,64(a0)
	*copPtr++ = (LONG)NullSprite;
     f82:	move.w d0,66(a0)
	*copPtr++ = SPR7PTH;
     f86:	move.w #316,68(a0)
	*copPtr++ = (LONG)NullSprite >> 16;
     f8c:	move.w d1,70(a0)
	*copPtr++ = SPR7PTL;
     f90:	move.w #318,72(a0)
	*copPtr++ = (LONG)NullSprite;
     f96:	move.w d0,74(a0)
	*copPtr++ = BPLCON0;
     f9a:	move.w #256,76(a0)
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     fa0:	moveq #0,d0
     fa2:	move.w 4516e <BmpLogo+0x4>,d0
     fa8:	add.l d0,d0
     faa:	moveq #12,d1
     fac:	lsl.l d1,d0
     fae:	ori.w #1536,d0
     fb2:	move.w d0,78(a0)
	line = 0x2c + BmpUpperPart_PF1.Height;
     fb6:	move.b 450a5 <BmpUpperPart_PF1+0x3>,d0
     fbc:	addi.b #44,d0
	copPtr = copWaitY(copPtr, line++);
     fc0:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     fc6:	lsl.l #8,d0
     fc8:	ori.w #5,d0
     fcc:	move.w d0,80(a0)
    *copListEnd++ = COP_WAIT;
     fd0:	move.w #-2,82(a0)
	*copPtr++ = BPLCON0;
     fd6:	move.w #256,84(a0)
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
     fdc:	move.w #512,86(a0)
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
     fe2:	move.b 450a5 <BmpUpperPart_PF1+0x3>,d0
     fe8:	addi.b #52,d0
	copPtr = copWaitY(copPtr, line++);
     fec:	move.b 450a5 <BmpUpperPart_PF1+0x3>,d2
     ff2:	addi.b #53,d2
     ff6:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
     ffc:	lsl.l #8,d0
     ffe:	ori.w #5,d0
    1002:	move.w d0,88(a0)
    *copListEnd++ = COP_WAIT;
    1006:	lea 92(a0),a1
    100a:	move.w #-2,90(a0)
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
    1010:	move.l a1,44f58 <copScrollerBmpP>
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
    1016:	lea 56(sp),sp
    101a:	clr.l -(sp)
    101c:	moveq #0,d0
    101e:	move.w 45012 <BmpScroller+0x6>,d0
    1024:	move.l d0,-(sp)
    1026:	moveq #0,d0
    1028:	move.w 45010 <BmpScroller+0x4>,d0
    102e:	move.l d0,-(sp)
    1030:	move.l 4501a <BmpScroller+0xe>,-(sp)
    1036:	move.l a1,-(sp)
    1038:	clr.l -(sp)
    103a:	jsr ae2 <copSetPlanesInterleafed>(pc)
    103e:	movea.l d0,a1
						  BmpScroller.Bplt - Screen.Bpl);
    1040:	move.w 45014 <BmpScroller+0x8>,d0
    1046:	sub.w 451d4 <Screen+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    104c:	move.w #264,(a1)
    *copListEnd++ = modOdd;
    1050:	move.w d0,2(a1)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    1054:	move.w #266,4(a1)
    *copListEnd++ = modEven;
    105a:	move.w d0,6(a1)
	*copPtr++ = BPLCON0;
    105e:	move.w #256,8(a1)
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
    1064:	moveq #0,d0
    1066:	move.w 4516e <BmpLogo+0x4>,d0
    106c:	moveq #12,d1
    106e:	lsl.l d1,d0
    1070:	lea 12(a1),a0
    1074:	ori.w #512,d0
    1078:	move.w d0,10(a1)
    107c:	lea 24(sp),sp
	for (int a = 1; a < 8; a++)
    1080:	moveq #1,d0
    1082:	bra.s 10a2 <SetupCopper+0x33e>
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
    1084:	movea.l d0,a1
    1086:	adda.l d0,a1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    1088:	move.w d0,d1
    108a:	addi.w #192,d1
    108e:	add.w d1,d1
    1090:	move.w d1,(a0)
    *copListCurrent++ = color;
    1092:	lea 6028 <FontPaletteRGB4>,a2
    1098:	move.w (0,a2,a1.l),2(a0)
	for (int a = 1; a < 8; a++)
    109e:	addq.l #1,d0
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
    10a0:	addq.l #4,a0
	for (int a = 1; a < 8; a++)
    10a2:	moveq #7,d1
    10a4:	cmp.l d0,d1
    10a6:	bge.s 1084 <SetupCopper+0x320>
	for (int l = 0; l < 24; l++)
    10a8:	moveq #0,d0
    10aa:	bra.s 10da <SetupCopper+0x376>
		copPtr = copWaitY(copPtr, line);
    10ac:	moveq #0,d1
    10ae:	move.b d2,d1
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    10b0:	lsl.l #8,d1
    10b2:	ori.w #5,d1
    10b6:	move.w d1,(a0)
    *copListEnd++ = COP_WAIT;
    10b8:	move.w #-2,2(a0)
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
    10be:	move.l d0,d1
    10c0:	add.l d0,d1
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    10c2:	move.w #384,4(a0)
    *copListCurrent++ = color;
    10c8:	lea 6048 <colgradbluePaletteRGB4>,a1
    10ce:	move.w (0,a1,d1.l),6(a0)
		line += 2;
    10d4:	addq.b #2,d2
	for (int l = 0; l < 24; l++)
    10d6:	addq.l #1,d0
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
    10d8:	addq.l #8,a0
	for (int l = 0; l < 24; l++)
    10da:	moveq #23,d1
    10dc:	cmp.l d0,d1
    10de:	bge.s 10ac <SetupCopper+0x348>
	copPtr = copWaitY(copPtr, line++);
    10e0:	move.b d2,d0
    10e2:	addq.b #1,d0
    10e4:	moveq #0,d1
    10e6:	move.b d2,d1
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    10e8:	lsl.l #8,d1
    10ea:	ori.w #5,d1
    10ee:	move.w d1,(a0)
    *copListEnd++ = COP_WAIT;
    10f0:	move.w #-2,2(a0)
	copLightUp[0] = copPtr;
    10f6:	lea 4(a0),a1
    10fa:	move.l a1,44f30 <copLightUp>
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    1100:	move.w #384,4(a0)
    *copListCurrent++ = color;
    1106:	move.w #273,6(a0)
	copPtr = copWaitY(copPtr, line++);
    110c:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    1112:	lsl.l #8,d0
    1114:	ori.w #5,d0
    1118:	move.w d0,8(a0)
    *copListEnd++ = COP_WAIT;
    111c:	move.w #-2,10(a0)
	copLightUp[1] = copPtr;
    1122:	lea 12(a0),a1
    1126:	move.l a1,44f34 <copLightUp+0x4>
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    112c:	move.w #384,12(a0)
    *copListCurrent++ = color;
    1132:	move.w #546,14(a0)
	line += 7;
    1138:	move.b d2,d0
    113a:	addi.b #9,d0
	copPtr = copWaitY(copPtr, line++);
    113e:	addi.b #10,d2
    1142:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    1148:	lsl.l #8,d0
    114a:	ori.w #5,d0
    114e:	move.w d0,16(a0)
    *copListEnd++ = COP_WAIT;
    1152:	move.w #-2,18(a0)
	copLightUp[2] = copPtr;
    1158:	lea 20(a0),a1
    115c:	move.l a1,44f38 <copLightUp+0x8>
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    1162:	move.w #384,20(a0)
    *copListCurrent++ = color;
    1168:	move.w #273,22(a0)
	copPtr = copWaitY(copPtr, line++);
    116e:	andi.l #255,d2
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    1174:	lsl.l #8,d2
    1176:	ori.w #5,d2
    117a:	move.w d2,24(a0)
    *copListEnd++ = COP_WAIT;
    117e:	move.w #-2,26(a0)
	copLightUp[3] = copPtr;
    1184:	lea 28(a0),a1
    1188:	move.l a1,44f3c <copLightUp+0xc>
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    118e:	move.w #384,28(a0)
    *copListCurrent++ = color;
    1194:	move.w #546,30(a0)
	line = 0x2c + BmpLogo.Height + 72 + 7; // 209
    119a:	move.b 4516d <BmpLogo+0x3>,d0
    11a0:	addi.b #123,d0
	copPtr = copWaitY(copPtr, line++);
    11a4:	andi.l #255,d0
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    11aa:	lsl.l #8,d0
    11ac:	ori.w #5,d0
    11b0:	move.w d0,32(a0)
    *copListEnd++ = COP_WAIT;
    11b4:	move.w #-2,34(a0)
	copMirrorBmpP = copPtr;
    11ba:	lea 36(a0),a1
    11be:	move.l a1,44f2c <copMirrorBmpP>
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
    11c4:	move.w 45172 <BmpLogo+0x8>,d0
    11ca:	sub.w 45170 <BmpLogo+0x6>,d0
    *copListEnd++ = BPL1MOD; //odd planes   1,3,5
    11d0:	move.w #264,36(a0)
    *copListEnd++ = modOdd;
    11d6:	move.w d0,38(a0)
    *copListEnd++ = BPL2MOD; //even  planes 2,4
    11da:	move.w #266,40(a0)
    *copListEnd++ = modEven;
    11e0:	move.w d0,42(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    11e4:	move.w #386,44(a0)
    *copListCurrent++ = color;
    11ea:	move.w #4032,46(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    11f0:	move.w #-31,48(a0)
    *copListEnd++ = COP_WAIT;
    11f6:	move.w #-2,50(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    11fc:	move.w #1285,52(a0)
    *copListEnd++ = COP_WAIT;
    1202:	move.w #-2,54(a0)
	copLightUp[4] = copPtr;
    1208:	lea 56(a0),a1
    120c:	move.l a1,44f40 <copLightUp+0x10>
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    1212:	move.w #384,56(a0)
    *copListCurrent++ = color;
    1218:	move.w #273,58(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    121e:	move.w #1541,60(a0)
    *copListEnd++ = COP_WAIT;
    1224:	move.w #-2,62(a0)
	copLightUp[5] = copPtr;
    122a:	lea 64(a0),a1
    122e:	move.l a1,44f44 <copLightUp+0x14>
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    1234:	move.w #384,64(a0)
    *copListCurrent++ = color;
    123a:	move.w #546,66(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    1240:	move.w #11269,68(a0)
    *copListEnd++ = COP_WAIT;
    1246:	move.w #-2,70(a0)
	copLightUp[6] = copPtr;
    124c:	lea 72(a0),a1
    1250:	move.l a1,44f48 <copLightUp+0x18>
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    1256:	move.w #384,72(a0)
    *copListCurrent++ = color;
    125c:	move.w #273,74(a0)
    *copListEnd++ = (i << 8) | 4 | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    1262:	move.w #11525,76(a0)
    *copListEnd++ = COP_WAIT;
    1268:	move.w #-2,78(a0)
	copLightUp[7] = copPtr;
    126e:	lea 80(a0),a1
    1272:	move.l a1,44f4c <copLightUp+0x1c>
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    1278:	move.w #384,80(a0)
    *copListCurrent++ = color;
    127e:	move.w #546,82(a0)
    *copListEnd++ = (i << 8) | (x << 1) | 1; //bit 1 means wait. waits for vertical position x<<8, first raster stop position outside the left
    1284:	move.w #-1,84(a0)
    *copListEnd++ = COP_WAIT;
    128a:	move.w #-2,86(a0)
}
    1290:	move.l (sp)+,d2
    1292:	movea.l (sp)+,a2
    1294:	rts

00001296 <CopyBitmapPart>:
	custom->bltdmod = 0;
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
}

void CopyBitmapPart(BmpDescriptor bmpS, BmpDescriptor bmpD, USHORT startY, USHORT stopY)
{
    1296:	movem.l d2-d3/a2,-(sp)
    129a:	move.l 120(sp),d3
    129e:	move.l 124(sp),d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    12a2:	movea.l 4520e <custom>,a2
    12a8:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    12ac:	move.w 2(a2),d0
    12b0:	btst #14,d0
    12b4:	bne.s 12ac <CopyBitmapPart+0x16>
	WaitBlt();

	custom->bltcon0 = 0x09f0;
    12b6:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
    12bc:	move.w #0,66(a2)
	custom->bltapt = (UBYTE *)bmpS.ImageData + (startY * bmpS.Bplt);
    12c2:	moveq #0,d0
    12c4:	move.w 24(sp),d0
    12c8:	move.l d0,-(sp)
    12ca:	move.w d3,-(sp)
    12cc:	clr.w -(sp)
    12ce:	jsr 3c7c <__mulsi3>
    12d4:	addq.l #8,sp
    12d6:	move.l 30(sp),d1
    12da:	add.l d0,d1
    12dc:	move.l d1,80(a2)
	custom->bltdpt = (UBYTE *)bmpD.ImageData + (startY * bmpS.Bplt);
    12e0:	add.l 82(sp),d0
    12e4:	move.l d0,84(a2)
	custom->bltafwm = 0xffff;
    12e8:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    12ee:	move.w #-1,70(a2)
	custom->bltamod = 0;
    12f4:	move.w #0,100(a2)
	custom->bltdmod = 0;
    12fa:	move.w #0,102(a2)
	custom->bltsize = (((stopY - startY) * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
    1300:	sub.w d3,d2
    1302:	muls.w 20(sp),d2
    1306:	lsl.w #6,d2
    1308:	move.w 22(sp),d0
    130c:	lsr.w #1,d0
    130e:	add.w d0,d2
    1310:	move.w d2,88(a2)
}
    1314:	movem.l (sp)+,d2-d3/a2
    1318:	rts

0000131a <ClearBitmapPart>:
	custom->bltdmod = 0;
	custom->bltsize = ((lines * bmpD.Bpls) << 6) + (bmpD.Width / 16);
}

void ClearBitmapPart(BmpDescriptor bmp, int x, int y, int height, int width)
{
    131a:	movem.l d2-d5/a2-a3,-(sp)
    131e:	move.l 80(sp),d5
    1322:	movea.l 92(sp),a3
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    1326:	movea.l 4520e <custom>,a2
    132c:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1330:	move.w 2(a2),d0
    1334:	btst #14,d0
    1338:	bne.s 1330 <ClearBitmapPart+0x16>
	WaitBlt();
	BYTE shift = x % 16;
    133a:	move.l d5,d2
    133c:	andi.l #-2147483633,d2
    1342:	tst.l d5
    1344:	blt.w 13e0 <ClearBitmapPart+0xc6>
	if (shift)
    1348:	tst.b d2
    134a:	beq.s 1350 <ClearBitmapPart+0x36>
		width += 16;
    134c:	lea 16(a3),a3
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    1350:	move.b d2,d0
    1352:	ext.w d0
    1354:	move.w d0,d4
    1356:	ext.l d4
    1358:	move.l d4,d1
    135a:	moveq #12,d3
    135c:	lsl.l d3,d1
    135e:	ori.w #2304,d1
    1362:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1366:	moveq #12,d1
    1368:	lsl.w d1,d0
    136a:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    136e:	move.l 42(sp),d3
    1372:	moveq #0,d0
    1374:	move.w 36(sp),d0
    1378:	move.l 84(sp),-(sp)
    137c:	move.l d0,-(sp)
    137e:	jsr 3c7c <__mulsi3>
    1384:	addq.l #8,sp
    1386:	move.l d5,d1
    1388:	bmi.s 13ec <ClearBitmapPart+0xd2>
    138a:	asr.l #3,d1
    138c:	add.l d1,d0
    138e:	add.l d3,d0
    1390:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    1394:	move.l d0,84(a2)
	custom->bltafwm = 0xffff;
    1398:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    139e:	tst.b d2
    13a0:	beq.s 13f0 <ClearBitmapPart+0xd6>
    13a2:	moveq #15,d1
    13a4:	sub.l d4,d1
    13a6:	moveq #0,d0
    13a8:	not.w d0
    13aa:	asr.l d1,d0
    13ac:	move.w d0,70(a2)
	;
	custom->bltamod = bmp.Bpl - (width / 8);
    13b0:	move.w 34(sp),d0
    13b4:	move.l a3,d1
    13b6:	bmi.s 13f4 <ClearBitmapPart+0xda>
    13b8:	asr.l #3,d1
    13ba:	sub.w d1,d0
    13bc:	move.w d0,100(a2)
	custom->bltdmod = bmp.Bpl - (width / 8);
    13c0:	move.w d0,102(a2)
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    13c4:	move.w 32(sp),d0
    13c8:	muls.w 90(sp),d0
    13cc:	lsl.w #6,d0
    13ce:	move.l a3,d1
    13d0:	bmi.s 13f8 <ClearBitmapPart+0xde>
    13d2:	asr.l #4,d1
    13d4:	add.w d1,d0
    13d6:	move.w d0,88(a2)
}
    13da:	movem.l (sp)+,d2-d5/a2-a3
    13de:	rts
	BYTE shift = x % 16;
    13e0:	subq.l #1,d2
    13e2:	moveq #-16,d0
    13e4:	or.l d0,d2
    13e6:	addq.l #1,d2
    13e8:	bra.w 1348 <ClearBitmapPart+0x2e>
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
    13ec:	addq.l #7,d1
    13ee:	bra.s 138a <ClearBitmapPart+0x70>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    13f0:	moveq #-1,d0
    13f2:	bra.s 13ac <ClearBitmapPart+0x92>
	custom->bltamod = bmp.Bpl - (width / 8);
    13f4:	addq.l #7,d1
    13f6:	bra.s 13b8 <ClearBitmapPart+0x9e>
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
    13f8:	moveq #15,d1
    13fa:	add.l a3,d1
    13fc:	bra.s 13d2 <ClearBitmapPart+0xb8>

000013fe <SimpleBlit>:

void SimpleBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    13fe:	movem.l d2-d7/a2,-(sp)
    1402:	move.l 136(sp),d7
    1406:	move.l 140(sp),d1
    140a:	move.l 144(sp),d4
    140e:	move.l 148(sp),d5
    1412:	move.l 152(sp),d3
    1416:	move.l 156(sp),d2
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    141a:	movea.l 4520e <custom>,a2
    1420:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    1424:	move.w 2(a2),d0
    1428:	btst #14,d0
    142c:	bne.s 1424 <SimpleBlit+0x26>
	WaitBlt();
	custom->bltcon0 = 0x09f0;
    142e:	move.w #2544,64(a2)
	custom->bltcon1 = 0x0000;
    1434:	move.w #0,66(a2)
	custom->bltafwm = 0xffff;
    143a:	move.w #-1,68(a2)
	custom->bltalwm = 0xffff;
    1440:	move.w #-1,70(a2)
	custom->bltamod = imgA.Bpl - (width / 8);
    1446:	move.w d2,d0
    1448:	lsr.w #3,d0
    144a:	movea.w 38(sp),a0
    144e:	suba.w d0,a0
    1450:	move.w a0,100(a2)
	custom->bltdmod = imgD.Bpl - (width / 8);
    1454:	movea.w 90(sp),a0
    1458:	suba.w d0,a0
    145a:	move.w a0,102(a2)
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    145e:	move.l 46(sp),d6
    1462:	moveq #0,d0
    1464:	move.w 40(sp),d0
    1468:	move.l d0,-(sp)
    146a:	move.l d1,-(sp)
    146c:	jsr 3c7c <__mulsi3>
    1472:	addq.l #8,sp
    1474:	move.l d7,d1
    1476:	bmi.s 14ba <SimpleBlit+0xbc>
    1478:	asr.l #3,d1
    147a:	add.l d1,d0
    147c:	add.l d6,d0
    147e:	move.l d0,80(a2)
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1482:	move.l 98(sp),d6
    1486:	moveq #0,d0
    1488:	move.w 92(sp),d0
    148c:	move.l d0,-(sp)
    148e:	move.l d5,-(sp)
    1490:	jsr 3c7c <__mulsi3>
    1496:	addq.l #8,sp
    1498:	move.l d4,d1
    149a:	bmi.s 14be <SimpleBlit+0xc0>
    149c:	asr.l #3,d1
    149e:	add.l d1,d0
    14a0:	add.l d6,d0
    14a2:	move.l d0,84(a2)
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
    14a6:	muls.w 36(sp),d3
    14aa:	lsl.w #6,d3
    14ac:	lsr.w #4,d2
    14ae:	add.w d3,d2
    14b0:	move.w d2,88(a2)
}
    14b4:	movem.l (sp)+,d2-d7/a2
    14b8:	rts
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
    14ba:	addq.l #7,d1
    14bc:	bra.s 1478 <SimpleBlit+0x7a>
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    14be:	addq.l #7,d1
    14c0:	bra.s 149c <SimpleBlit+0x9e>

000014c2 <BetterBlit>:

void BetterBlit(BmpDescriptor imgS, BmpDescriptor imgD, BmpDescriptor imgM, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
    14c2:	movem.l d2-d7/a2-a6,-(sp)
    14c6:	movea.l 204(sp),a3
    14ca:	move.l 208(sp),d7
    14ce:	move.l 212(sp),d5
    14d2:	movea.l 216(sp),a5
    14d6:	movea.l 220(sp),a4
    14da:	move.l 224(sp),d1
    14de:	move.w d1,d4
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
    14e0:	movea.l 4520e <custom>,a2
    14e6:	move.w 2(a2),d0
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
    14ea:	move.w 2(a2),d0
    14ee:	btst #14,d0
    14f2:	bne.s 14ea <BetterBlit+0x28>
	WaitBlt();
	BYTE shift = startD.X % 16;
    14f4:	move.l d5,d3
    14f6:	andi.l #-2147483633,d3
    14fc:	tst.l d5
    14fe:	blt.w 15f2 <BetterBlit+0x130>
	if (shift)
    1502:	tst.b d3
    1504:	beq.s 150c <BetterBlit+0x4a>
		width += 16;
    1506:	move.w d1,d4
    1508:	addi.w #16,d4

	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
    150c:	move.b d3,d0
    150e:	ext.w d0
    1510:	movea.w d0,a6
    1512:	move.l a6,d1
    1514:	moveq #12,d2
    1516:	lsl.l d2,d1
    1518:	ori.w #4042,d1
    151c:	move.w d1,64(a2)
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
    1520:	moveq #12,d1
    1522:	lsl.w d1,d0
    1524:	move.w d0,66(a2)
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    1528:	move.l 62(sp),d6
    152c:	moveq #0,d0
    152e:	move.w 56(sp),d0
    1532:	move.l d0,-(sp)
    1534:	move.l d7,-(sp)
    1536:	jsr 3c7c <__mulsi3>
    153c:	addq.l #8,sp
    153e:	move.l a3,d2
    1540:	bmi.w 15fe <BetterBlit+0x13c>
    1544:	asr.l #3,d2
    1546:	add.l d2,d0
    1548:	add.l d6,d0
    154a:	move.l d0,80(a2)
	custom->bltamod = imgS.Bpl - (width / 8);
    154e:	move.w d4,d6
    1550:	lsr.w #3,d6
    1552:	move.w 54(sp),d0
    1556:	sub.w d6,d0
    1558:	move.w d0,100(a2)
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
    155c:	moveq #0,d0
    155e:	move.w 160(sp),d0
    1562:	lea 3c7c <__mulsi3>,a3
    1568:	move.l d0,-(sp)
    156a:	move.l d7,-(sp)
    156c:	jsr (a3)
    156e:	addq.l #8,sp
    1570:	add.l d0,d2
    1572:	add.l 166(sp),d2
    1576:	move.l d2,76(a2)
	custom->bltbmod = imgM.Bpl - (width / 8);
    157a:	move.w 158(sp),d0
    157e:	sub.w d6,d0
    1580:	move.w d0,98(a2)
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1584:	move.l 114(sp),d2
    1588:	moveq #0,d0
    158a:	move.w 108(sp),d0
    158e:	move.l d0,-(sp)
    1590:	move.l a5,-(sp)
    1592:	jsr (a3)
    1594:	addq.l #8,sp
    1596:	move.l d5,d1
    1598:	bmi.s 1604 <BetterBlit+0x142>
    159a:	asr.l #3,d1
    159c:	add.l d1,d0
    159e:	add.l d2,d0
    15a0:	move.l d0,84(a2)
    15a4:	move.l d0,72(a2)
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
    15a8:	move.w 106(sp),d0
    15ac:	sub.w d6,d0
    15ae:	move.w d0,102(a2)
    15b2:	move.w d0,96(a2)
	custom->bltafwm = 0xffff;
    15b6:	move.w #-1,68(a2)
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    15bc:	tst.b d3
    15be:	beq.s 1608 <BetterBlit+0x146>
    15c0:	moveq #15,d1
    15c2:	sub.l a6,d1
    15c4:	moveq #0,d0
    15c6:	not.w d0
    15c8:	asr.l d1,d0
    15ca:	move.w d0,70(a2)
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
    15ce:	moveq #0,d0
    15d0:	move.w 52(sp),d0
    15d4:	move.l d0,-(sp)
    15d6:	move.w a4,-(sp)
    15d8:	clr.w -(sp)
    15da:	jsr 3c7c <__mulsi3>
    15e0:	addq.l #8,sp
    15e2:	lsl.l #6,d0
    15e4:	lsr.w #4,d4
    15e6:	or.w d0,d4
    15e8:	move.w d4,88(a2)
}
    15ec:	movem.l (sp)+,d2-d7/a2-a6
    15f0:	rts
	BYTE shift = startD.X % 16;
    15f2:	subq.l #1,d3
    15f4:	moveq #-16,d0
    15f6:	or.l d0,d3
    15f8:	addq.l #1,d3
    15fa:	bra.w 1502 <BetterBlit+0x40>
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
    15fe:	addq.l #7,d2
    1600:	bra.w 1544 <BetterBlit+0x82>
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
    1604:	addq.l #7,d1
    1606:	bra.s 159a <BetterBlit+0xd8>
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
    1608:	moveq #-1,d0
    160a:	bra.s 15ca <BetterBlit+0x108>

0000160c <p61Init>:

int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
    160c:	move.l a3,-(sp)
    160e:	move.l a2,-(sp)
	register volatile const void *_a0 ASM("a0") = module;
    1610:	movea.l 12(sp),a0
	register volatile const void *_a1 ASM("a1") = NULL;
    1614:	suba.l a1,a1
	register volatile const void *_a2 ASM("a2") = NULL;
    1616:	suba.l a2,a2
	register volatile const void *_a3 ASM("a3") = P61_Player;
    1618:	lea 3e5a <incbin_P61_Player_start>,a3
	register int _d0 ASM("d0"); // return value
	__asm volatile(
    161e:	movem.l d1-d7/a4-a6,-(sp)
    1622:	jsr (a3)
    1624:	movem.l (sp)+,d1-d7/a4-a6
		"movem.l (%%sp)+,%%d1-%%d7/%%a4-%%a6"
		: "=r"(_d0), "+rf"(_a0), "+rf"(_a1), "+rf"(_a2), "+rf"(_a3)
		:
		: "cc", "memory");
	return _d0;
}
    1628:	movea.l (sp)+,a2
    162a:	movea.l (sp)+,a3
    162c:	rts

0000162e <p61Music>:

void p61Music()
{
    162e:	move.l a6,-(sp)
    1630:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    1632:	lea 3e5a <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    1638:	movea.l #14675968,a6
	__asm volatile(
    163e:	movem.l d0-a2/a4-a5,-(sp)
    1642:	jsr 4(a3)
    1646:	movem.l (sp)+,d0-a2/a4-a5
		"jsr 4(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d7/%%a0-%%a2/%%a4-%%a5"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    164a:	movea.l (sp)+,a3
    164c:	movea.l (sp)+,a6
    164e:	rts

00001650 <interruptHandler>:
}
// interrupt handler
static __attribute__((interrupt)) void interruptHandler()
{
    1650:	movem.l d0-d1/a0-a1,-(sp)

    custom->intreq = (1 << INTB_VERTB);
    1654:	movea.l 4520e <custom>,a0
    165a:	move.w #32,156(a0)
    custom->intreq = (1 << INTB_VERTB); //reset vbl req. twice for a4000 bug.
    1660:	move.w #32,156(a0)

    // DEMO - ThePlayer
    p61Music();
    1666:	jsr 162e <p61Music>(pc)

    // DEMO - increment frameCounter
    frameCounter++;
    166a:	move.w 4520c <frameCounter>,d0
    1670:	addq.w #1,d0
    1672:	move.w d0,4520c <frameCounter>
}
    1678:	movem.l (sp)+,d0-d1/a0-a1
    167c:	rte

0000167e <p61End>:

void p61End()
{
    167e:	move.l a6,-(sp)
    1680:	move.l a3,-(sp)
	register volatile const void *_a3 ASM("a3") = P61_Player;
    1682:	lea 3e5a <incbin_P61_Player_start>,a3
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
    1688:	movea.l #14675968,a6
	__asm volatile(
    168e:	movem.l d0-d1/a0-a1,-(sp)
    1692:	jsr 8(a3)
    1696:	movem.l (sp)+,d0-d1/a0-a1
		"jsr 8(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d1/%%a0-%%a1"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}
    169a:	movea.l (sp)+,a3
    169c:	movea.l (sp)+,a6
    169e:	rts

000016a0 <BitmapInit>:

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{
    16a0:	move.l d3,-(sp)
    16a2:	move.l d2,-(sp)
    16a4:	movea.l 12(sp),a0
    16a8:	move.l 16(sp),d0
    16ac:	move.l 20(sp),d2
    16b0:	move.l 24(sp),d1

	bmp->Width = w;
    16b4:	move.w d0,(a0)
	bmp->Height = h;
    16b6:	move.w d2,2(a0)
	bmp->Bpls = bpls;
    16ba:	move.w d1,4(a0)
	bmp->Bpl = w / 8;
    16be:	lsr.w #3,d0
    16c0:	move.w d0,6(a0)
	bmp->Bplt = w / 8 * bpls;
    16c4:	move.w d0,d3
    16c6:	muls.w d1,d3
    16c8:	move.w d3,8(a0)
	bmp->Btot = w / 8 * h * bpls;
    16cc:	muls.w d2,d0
    16ce:	muls.w d1,d0
    16d0:	move.w d0,12(a0)
}
    16d4:	move.l (sp)+,d2
    16d6:	move.l (sp)+,d3
    16d8:	rts

000016da <InitStarfieldSprite>:

void InitStarfieldSprite()
{
    16da:	movem.l d2-d7/a2-a3,-(sp)
	short line = 0;
	USHORT hpos = 3;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 31; l++)
    16de:	moveq #0,d5
	BYTE vpos = 0x2c;
    16e0:	moveq #44,d3
	USHORT hpos = 3;
    16e2:	movea.w #3,a1
	short line = 0;
    16e6:	clr.w d2
    16e8:	bra.w 1822 <InitStarfieldSprite+0x148>
	{
		hpos = (7 * hpos) % 255;
    16ec:	moveq #0,d0
    16ee:	move.w a1,d0
    16f0:	move.l d0,d1
    16f2:	lsl.l #3,d1
    16f4:	lea 3d24 <__modsi3>,a3
    16fa:	pea ff <MoveBobs+0x65>
    16fe:	sub.l d0,d1
    1700:	move.l d1,-(sp)
    1702:	jsr (a3)
    1704:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    1706:	move.b d3,d1
    1708:	ext.w d1
    170a:	move.w d1,d4
    170c:	ext.l d4
    170e:	lsl.l #8,d4
    1710:	move.w d0,d6
    1712:	andi.w #255,d6
    1716:	movea.w d2,a0
    1718:	addq.w #1,a0
    171a:	movea.w d2,a1
    171c:	lea 44c22 <StarSprite>,a2
    1722:	adda.l a1,a1
    1724:	or.w d4,d6
    1726:	move.w d6,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    172a:	addq.w #1,d1
    172c:	movea.w d2,a1
    172e:	addq.w #2,a1
    1730:	movea.w a0,a0
    1732:	lsl.w #8,d1
    1734:	adda.l a0,a0
    1736:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-1
    173a:	movea.w d2,a0
    173c:	addq.w #3,a0
    173e:	movea.w a1,a1
    1740:	adda.l a1,a1
    1742:	move.w #-32768,(0,a1,a2.l)
		StarSprite[line++] = 0x0000;					  //color-1
    1748:	move.w d2,d6
    174a:	addq.w #4,d6
    174c:	movea.w a0,a0
    174e:	adda.l a0,a0
    1750:	clr.w (0,a0,a2.l)
		vpos += 2;
    1754:	move.b d3,d4
    1756:	addq.b #2,d4

		hpos = (7 * hpos) % 255;
    1758:	andi.l #65535,d0
    175e:	move.l d0,d1
    1760:	lsl.l #3,d1
    1762:	pea ff <MoveBobs+0x65>
    1766:	sub.l d0,d1
    1768:	move.l d1,-(sp)
    176a:	jsr (a3)
    176c:	addq.l #8,sp
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    176e:	move.b d4,d1
    1770:	ext.w d1
    1772:	move.w d1,d4
    1774:	ext.l d4
    1776:	lsl.l #8,d4
    1778:	move.w d0,d7
    177a:	andi.w #255,d7
    177e:	movea.w d2,a0
    1780:	addq.w #5,a0
    1782:	movea.w d6,a1
    1784:	adda.l a1,a1
    1786:	or.w d4,d7
    1788:	move.w d7,(0,a2,a1.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    178c:	addq.w #1,d1
    178e:	movea.w d2,a1
    1790:	addq.w #6,a1
    1792:	movea.w a0,a0
    1794:	lsl.w #8,d1
    1796:	adda.l a0,a0
    1798:	move.w d1,(0,a0,a2.l)
		StarSprite[line++] = 0x0000;					  //color-2
    179c:	movea.w d2,a0
    179e:	addq.w #7,a0
    17a0:	movea.w a1,a1
    17a2:	adda.l a1,a1
    17a4:	clr.w (0,a1,a2.l)
		StarSprite[line++] = 0x8000;					  //color-2
    17a8:	addq.w #4,d6
    17aa:	movea.w a0,a0
    17ac:	adda.l a0,a0
    17ae:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    17b4:	move.b d3,d4
    17b6:	addq.b #4,d4

		hpos = (7 * hpos) % 255;
    17b8:	andi.l #65535,d0
    17be:	move.l d0,d1
    17c0:	lsl.l #3,d1
    17c2:	pea ff <MoveBobs+0x65>
    17c6:	sub.l d0,d1
    17c8:	move.l d1,-(sp)
    17ca:	jsr (a3)
    17cc:	addq.l #8,sp
    17ce:	movea.w d0,a1
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    17d0:	move.b d4,d1
    17d2:	ext.w d1
    17d4:	move.w d1,d4
    17d6:	ext.l d4
    17d8:	lsl.l #8,d4
    17da:	andi.w #255,d0
    17de:	movea.w d2,a3
    17e0:	lea 9(a3),a3
    17e4:	movea.w d6,a0
    17e6:	adda.l a0,a0
    17e8:	or.w d4,d0
    17ea:	move.w d0,(0,a2,a0.l)
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
    17ee:	addq.w #1,d1
    17f0:	movea.w d2,a0
    17f2:	lea 10(a0),a0
    17f6:	movea.w a3,a3
    17f8:	lsl.w #8,d1
    17fa:	adda.l a3,a3
    17fc:	move.w d1,(0,a3,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    1800:	movea.w a0,a0
    1802:	adda.l a0,a0
    1804:	move.w #-32768,(0,a0,a2.l)
		StarSprite[line++] = 0x8000;					  //color-3
    180a:	movea.w d2,a0
    180c:	lea 11(a0),a0
    1810:	movea.w a0,a0
    1812:	addi.w #12,d2
    1816:	adda.l a0,a0
    1818:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    181e:	addq.b #6,d3
	for (int l = 0; l < 31; l++)
    1820:	addq.l #1,d5
    1822:	moveq #30,d0
    1824:	cmp.l d5,d0
    1826:	bge.w 16ec <InitStarfieldSprite+0x12>
	}
	// sprite end-mark
	StarSprite[line++] = 0;
    182a:	move.w d2,d0
    182c:	addq.w #1,d0
    182e:	ext.l d2
    1830:	lea 44c22 <StarSprite>,a1
    1836:	add.l d2,d2
    1838:	clr.w (0,a1,d2.l)
	StarSprite[line++] = 0;
    183c:	movea.w d0,a0
    183e:	adda.l a0,a0
    1840:	clr.w (0,a0,a1.l)

	line = 0;
	hpos = 7;
	vpos = 0x2d;
	for (int l = 0; l < 31; l++)
    1844:	moveq #0,d5
	vpos = 0x2d;
    1846:	moveq #45,d3
	hpos = 7;
    1848:	movea.w #7,a1
	line = 0;
    184c:	clr.w d2
    184e:	bra.w 1988 <InitStarfieldSprite+0x2ae>
	{
		hpos = (7 * hpos) % 255;
    1852:	moveq #0,d0
    1854:	move.w a1,d0
    1856:	move.l d0,d1
    1858:	lsl.l #3,d1
    185a:	lea 3d24 <__modsi3>,a3
    1860:	pea ff <MoveBobs+0x65>
    1864:	sub.l d0,d1
    1866:	move.l d1,-(sp)
    1868:	jsr (a3)
    186a:	addq.l #8,sp
		StarSprite2[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    186c:	move.b d3,d1
    186e:	ext.w d1
    1870:	move.w d1,d4
    1872:	ext.l d4
    1874:	lsl.l #8,d4
    1876:	move.w d0,d6
    1878:	andi.w #255,d6
    187c:	movea.w d2,a0
    187e:	addq.w #1,a0
    1880:	movea.w d2,a1
    1882:	lea 44936 <StarSprite2>,a2
    1888:	adda.l a1,a1
    188a:	or.w d4,d6
    188c:	move.w d6,(0,a2,a1.l)
		StarSprite2[line++] = (vpos + 1) << 8 | 0;		   //v-stop, ctrl
    1890:	addq.w #1,d1
    1892:	movea.w d2,a1
    1894:	addq.w #2,a1
    1896:	movea.w a0,a0
    1898:	lsl.w #8,d1
    189a:	adda.l a0,a0
    189c:	move.w d1,(0,a0,a2.l)
		StarSprite2[line++] = 0x8000;					   //color-1
    18a0:	movea.w d2,a0
    18a2:	addq.w #3,a0
    18a4:	movea.w a1,a1
    18a6:	adda.l a1,a1
    18a8:	move.w #-32768,(0,a1,a2.l)
		StarSprite2[line++] = 0x0000;					   //color-1
    18ae:	move.w d2,d6
    18b0:	addq.w #4,d6
    18b2:	movea.w a0,a0
    18b4:	adda.l a0,a0
    18b6:	clr.w (0,a0,a2.l)
		vpos += 2;
    18ba:	move.b d3,d4
    18bc:	addq.b #2,d4

		hpos = (7 * hpos) % 255;
    18be:	andi.l #65535,d0
    18c4:	move.l d0,d1
    18c6:	lsl.l #3,d1
    18c8:	pea ff <MoveBobs+0x65>
    18cc:	sub.l d0,d1
    18ce:	move.l d1,-(sp)
    18d0:	jsr (a3)
    18d2:	addq.l #8,sp
		StarSprite2[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    18d4:	move.b d4,d1
    18d6:	ext.w d1
    18d8:	move.w d1,d4
    18da:	ext.l d4
    18dc:	lsl.l #8,d4
    18de:	move.w d0,d7
    18e0:	andi.w #255,d7
    18e4:	movea.w d2,a0
    18e6:	addq.w #5,a0
    18e8:	movea.w d6,a1
    18ea:	adda.l a1,a1
    18ec:	or.w d4,d7
    18ee:	move.w d7,(0,a2,a1.l)
		StarSprite2[line++] = (vpos + 1) << 8 | 0;		   //v-stop, ctrl
    18f2:	addq.w #1,d1
    18f4:	movea.w d2,a1
    18f6:	addq.w #6,a1
    18f8:	movea.w a0,a0
    18fa:	lsl.w #8,d1
    18fc:	adda.l a0,a0
    18fe:	move.w d1,(0,a0,a2.l)
		StarSprite2[line++] = 0x0000;					   //color-2
    1902:	movea.w d2,a0
    1904:	addq.w #7,a0
    1906:	movea.w a1,a1
    1908:	adda.l a1,a1
    190a:	clr.w (0,a1,a2.l)
		StarSprite2[line++] = 0x8000;					   //color-2
    190e:	addq.w #4,d6
    1910:	movea.w a0,a0
    1912:	adda.l a0,a0
    1914:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    191a:	move.b d3,d4
    191c:	addq.b #4,d4

		hpos = (7 * hpos) % 255;
    191e:	andi.l #65535,d0
    1924:	move.l d0,d1
    1926:	lsl.l #3,d1
    1928:	pea ff <MoveBobs+0x65>
    192c:	sub.l d0,d1
    192e:	move.l d1,-(sp)
    1930:	jsr (a3)
    1932:	addq.l #8,sp
    1934:	movea.w d0,a1
		StarSprite2[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
    1936:	move.b d4,d1
    1938:	ext.w d1
    193a:	move.w d1,d4
    193c:	ext.l d4
    193e:	lsl.l #8,d4
    1940:	andi.w #255,d0
    1944:	movea.w d2,a3
    1946:	lea 9(a3),a3
    194a:	movea.w d6,a0
    194c:	adda.l a0,a0
    194e:	or.w d4,d0
    1950:	move.w d0,(0,a2,a0.l)
		StarSprite2[line++] = (vpos + 1) << 8 | 0;		   //v-stop, ctrl
    1954:	addq.w #1,d1
    1956:	movea.w d2,a0
    1958:	lea 10(a0),a0
    195c:	movea.w a3,a3
    195e:	lsl.w #8,d1
    1960:	adda.l a3,a3
    1962:	move.w d1,(0,a3,a2.l)
		StarSprite2[line++] = 0x8000;					   //color-3
    1966:	movea.w a0,a0
    1968:	adda.l a0,a0
    196a:	move.w #-32768,(0,a0,a2.l)
		StarSprite2[line++] = 0x8000;					   //color-3
    1970:	movea.w d2,a0
    1972:	lea 11(a0),a0
    1976:	movea.w a0,a0
    1978:	addi.w #12,d2
    197c:	adda.l a0,a0
    197e:	move.w #-32768,(0,a0,a2.l)
		vpos += 2;
    1984:	addq.b #6,d3
	for (int l = 0; l < 31; l++)
    1986:	addq.l #1,d5
    1988:	moveq #30,d0
    198a:	cmp.l d5,d0
    198c:	bge.w 1852 <InitStarfieldSprite+0x178>
	}
	// sprite end-mark
	StarSprite2[line++] = 0;
    1990:	move.w d2,d0
    1992:	addq.w #1,d0
    1994:	ext.l d2
    1996:	lea 44936 <StarSprite2>,a1
    199c:	add.l d2,d2
    199e:	clr.w (0,a1,d2.l)
	StarSprite2[line++] = 0;
    19a2:	movea.w d0,a0
    19a4:	adda.l a0,a0
    19a6:	clr.w (0,a0,a1.l)
}
    19aa:	movem.l (sp)+,d2-d7/a2-a3
    19ae:	rts

000019b0 <MoveStarfield>:

void MoveStarfield()
{
    19b0:	move.l a3,-(sp)
    19b2:	move.l a2,-(sp)
	for (int l = 1; l < 31 * 24; l += 24)
    19b4:	movea.w #1,a0
    19b8:	bra.s 19d6 <MoveStarfield+0x26>
		((volatile UBYTE *)StarSprite)[l + 16] += 4;
		if (frameCounter % 2)
		{
			((volatile UBYTE *)StarSprite2)[l] += 1;
		}
		((volatile UBYTE *)StarSprite2)[l + 8] += 2;
    19ba:	adda.l #280886,a2
    19c0:	move.b (a2),d0
    19c2:	addq.b #2,d0
    19c4:	move.b d0,(a2)
		((volatile UBYTE *)StarSprite2)[l + 16] += 3;
    19c6:	adda.l #280886,a1
    19cc:	move.b (a1),d0
    19ce:	addq.b #3,d0
    19d0:	move.b d0,(a1)
	for (int l = 1; l < 31 * 24; l += 24)
    19d2:	lea 24(a0),a0
    19d6:	cmpa.w #743,a0
    19da:	bgt.s 1a36 <MoveStarfield+0x86>
		if (frameCounter % 4)
    19dc:	move.w 4520c <frameCounter>,d0
    19e2:	andi.w #3,d0
    19e6:	beq.s 19f6 <MoveStarfield+0x46>
			((volatile UBYTE *)StarSprite)[l] += 1;
    19e8:	movea.l a0,a1
    19ea:	adda.l #281634,a1
    19f0:	move.b (a1),d0
    19f2:	addq.b #1,d0
    19f4:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 8] += 1;
    19f6:	lea 8(a0),a2
    19fa:	movea.l a0,a1
    19fc:	adda.l #281642,a1
    1a02:	move.b (a1),d0
    1a04:	addq.b #1,d0
    1a06:	move.b d0,(a1)
		((volatile UBYTE *)StarSprite)[l + 16] += 4;
    1a08:	lea 16(a0),a1
    1a0c:	movea.l a0,a3
    1a0e:	adda.l #281650,a3
    1a14:	move.b (a3),d0
    1a16:	addq.b #4,d0
    1a18:	move.b d0,(a3)
		if (frameCounter % 2)
    1a1a:	move.w 4520c <frameCounter>,d0
    1a20:	btst #0,d0
    1a24:	beq.s 19ba <MoveStarfield+0xa>
			((volatile UBYTE *)StarSprite2)[l] += 1;
    1a26:	movea.l a0,a3
    1a28:	adda.l #280886,a3
    1a2e:	move.b (a3),d0
    1a30:	addq.b #1,d0
    1a32:	move.b d0,(a3)
    1a34:	bra.s 19ba <MoveStarfield+0xa>
	}
}
    1a36:	movea.l (sp)+,a2
    1a38:	movea.l (sp)+,a3
    1a3a:	rts

00001a3c <BuildLogo>:

void BuildLogo(BmpDescriptor d, short mode)
{
    1a3c:	move.l a2,-(sp)
    1a3e:	move.l d2,-(sp)
    1a40:	move.w 66(sp),d0
	Point2D ps;
	Point2D pd;

	switch (mode)
    1a44:	cmpi.w #2,d0
    1a48:	beq.w 1dba <BuildLogo+0x37e>
    1a4c:	bgt.w 1b26 <BuildLogo+0xea>
    1a50:	tst.w d0
    1a52:	beq.w 1b58 <BuildLogo+0x11c>
    1a56:	cmpi.w #1,d0
    1a5a:	bne.w 1b86 <BuildLogo+0x14a>
		}
		LogoShowDone = LogoShowY2 > 129;
		break;

	case 1:
		if (LogoShowY1 >= 0)
    1a5e:	move.w 44f68 <LogoShowY1>,d2
    1a64:	bpl.w 1cf4 <BuildLogo+0x2b8>
			pd.X = 32;
			pd.Y = LogoShowY1;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
			LogoShowY1 -= 2;
		}
		else if (LogoShowY2 >= 1)
    1a68:	move.w 81a2 <LogoShowY2>,d2
    1a6e:	ble.w 1da4 <BuildLogo+0x368>
		{
			ps.X = 0;
    1a72:	clr.l d0
    1a74:	clr.l d1
			ps.Y = LogoShowY2;
    1a76:	movea.w d2,a2
			pd.X = 32;
    1a78:	movea.w #32,a0
    1a7c:	suba.l a1,a1
			pd.Y = LogoShowY2;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1a7e:	pea 100 <MoveBobs+0x66>
    1a82:	pea 1 <_start+0x1>
    1a86:	move.l a2,-(sp)
    1a88:	move.l a0,-(sp)
    1a8a:	move.l a2,-(sp)
    1a8c:	move.l d0,-(sp)
    1a8e:	subq.l #2,sp
    1a90:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    1a96:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    1a9c:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    1aa2:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    1aa8:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    1aae:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    1ab4:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    1aba:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    1ac0:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    1ac6:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    1acc:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    1ad2:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    1ad8:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    1ade:	subq.l #2,sp
    1ae0:	move.l 136(sp),-(sp)
    1ae4:	move.l 136(sp),-(sp)
    1ae8:	move.l 136(sp),-(sp)
    1aec:	move.l 136(sp),-(sp)
    1af0:	move.l 136(sp),-(sp)
    1af4:	move.l 136(sp),-(sp)
    1af8:	move.l 136(sp),-(sp)
    1afc:	move.l 136(sp),-(sp)
    1b00:	move.l 136(sp),-(sp)
    1b04:	move.l 136(sp),-(sp)
    1b08:	move.l 136(sp),-(sp)
    1b0c:	move.l 136(sp),-(sp)
    1b10:	move.w 138(sp),-(sp)
    1b14:	jsr 13fe <SimpleBlit>(pc)
			LogoShowY2 -= 2;
    1b18:	subq.w #2,81a2 <LogoShowY2>
    1b1e:	lea 128(sp),sp
    1b22:	bra.w 1da4 <BuildLogo+0x368>
	switch (mode)
    1b26:	cmpi.w #3,d0
    1b2a:	bne.s 1b86 <BuildLogo+0x14a>
		}
		LogoShowDone = LogoShowY2 > 129;
		break;

	case 3:
		if (LogoShowY1 <= 128)
    1b2c:	move.w 44f68 <LogoShowY1>,d2
    1b32:	cmpi.w #128,d2
    1b36:	ble.w 1f4e <BuildLogo+0x512>
			pd.X = 32;
			pd.Y = LogoShowY1;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
			LogoShowY1 += 2;
		}
		else if (LogoShowY2 >= 1)
    1b3a:	move.w 81a2 <LogoShowY2>,d2
    1b40:	bgt.w 2002 <BuildLogo+0x5c6>
			pd.X = 32;
			pd.Y = LogoShowY2;
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
			LogoShowY2 -= 2;
		}
		LogoShowDone = LogoShowY2 < 1;
    1b44:	tst.w 81a2 <LogoShowY2>
    1b4a:	sle d0
    1b4c:	ext.w d0
    1b4e:	neg.w d0
    1b50:	move.w d0,44f6a <LogoShowDone>
		break;
    1b56:	bra.s 1b86 <BuildLogo+0x14a>
		if (LogoShowY1 <= 128)
    1b58:	move.w 44f68 <LogoShowY1>,d2
    1b5e:	cmpi.w #128,d2
    1b62:	ble.s 1b8c <BuildLogo+0x150>
		else if (LogoShowY2 <= 129)
    1b64:	move.w 81a2 <LogoShowY2>,d2
    1b6a:	cmpi.w #129,d2
    1b6e:	ble.w 1c40 <BuildLogo+0x204>
		LogoShowDone = LogoShowY2 > 129;
    1b72:	cmpi.w #129,81a2 <LogoShowY2>
    1b7a:	sgt d0
    1b7c:	ext.w d0
    1b7e:	neg.w d0
    1b80:	move.w d0,44f6a <LogoShowDone>
	}
}
    1b86:	move.l (sp)+,d2
    1b88:	movea.l (sp)+,a2
    1b8a:	rts
			ps.X = 0;
    1b8c:	clr.l d0
    1b8e:	clr.l d1
			ps.Y = LogoShowY1;
    1b90:	movea.w d2,a2
			pd.X = 32;
    1b92:	movea.w #32,a0
    1b96:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1b98:	pea 100 <MoveBobs+0x66>
    1b9c:	pea 1 <_start+0x1>
    1ba0:	move.l a2,-(sp)
    1ba2:	move.l a0,-(sp)
    1ba4:	move.l a2,-(sp)
    1ba6:	move.l d0,-(sp)
    1ba8:	subq.l #2,sp
    1baa:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    1bb0:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    1bb6:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    1bbc:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    1bc2:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    1bc8:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    1bce:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    1bd4:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    1bda:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    1be0:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    1be6:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    1bec:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    1bf2:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    1bf8:	subq.l #2,sp
    1bfa:	move.l 136(sp),-(sp)
    1bfe:	move.l 136(sp),-(sp)
    1c02:	move.l 136(sp),-(sp)
    1c06:	move.l 136(sp),-(sp)
    1c0a:	move.l 136(sp),-(sp)
    1c0e:	move.l 136(sp),-(sp)
    1c12:	move.l 136(sp),-(sp)
    1c16:	move.l 136(sp),-(sp)
    1c1a:	move.l 136(sp),-(sp)
    1c1e:	move.l 136(sp),-(sp)
    1c22:	move.l 136(sp),-(sp)
    1c26:	move.l 136(sp),-(sp)
    1c2a:	move.w 138(sp),-(sp)
    1c2e:	jsr 13fe <SimpleBlit>(pc)
			LogoShowY1 += 2;
    1c32:	addq.w #2,44f68 <LogoShowY1>
    1c38:	lea 128(sp),sp
    1c3c:	bra.w 1b72 <BuildLogo+0x136>
			ps.X = 0;
    1c40:	clr.l d0
    1c42:	clr.l d1
			ps.Y = LogoShowY2;
    1c44:	movea.w d2,a2
			pd.X = 32;
    1c46:	movea.w #32,a0
    1c4a:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1c4c:	pea 100 <MoveBobs+0x66>
    1c50:	pea 1 <_start+0x1>
    1c54:	move.l a2,-(sp)
    1c56:	move.l a0,-(sp)
    1c58:	move.l a2,-(sp)
    1c5a:	move.l d0,-(sp)
    1c5c:	subq.l #2,sp
    1c5e:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    1c64:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    1c6a:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    1c70:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    1c76:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    1c7c:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    1c82:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    1c88:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    1c8e:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    1c94:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    1c9a:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    1ca0:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    1ca6:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    1cac:	subq.l #2,sp
    1cae:	move.l 136(sp),-(sp)
    1cb2:	move.l 136(sp),-(sp)
    1cb6:	move.l 136(sp),-(sp)
    1cba:	move.l 136(sp),-(sp)
    1cbe:	move.l 136(sp),-(sp)
    1cc2:	move.l 136(sp),-(sp)
    1cc6:	move.l 136(sp),-(sp)
    1cca:	move.l 136(sp),-(sp)
    1cce:	move.l 136(sp),-(sp)
    1cd2:	move.l 136(sp),-(sp)
    1cd6:	move.l 136(sp),-(sp)
    1cda:	move.l 136(sp),-(sp)
    1cde:	move.w 138(sp),-(sp)
    1ce2:	jsr 13fe <SimpleBlit>(pc)
			LogoShowY2 += 2;
    1ce6:	addq.w #2,81a2 <LogoShowY2>
    1cec:	lea 128(sp),sp
    1cf0:	bra.w 1b72 <BuildLogo+0x136>
			ps.X = 0;
    1cf4:	clr.l d0
    1cf6:	clr.l d1
			ps.Y = LogoShowY1;
    1cf8:	movea.w d2,a2
			pd.X = 32;
    1cfa:	movea.w #32,a0
    1cfe:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1d00:	pea 100 <MoveBobs+0x66>
    1d04:	pea 1 <_start+0x1>
    1d08:	move.l a2,-(sp)
    1d0a:	move.l a0,-(sp)
    1d0c:	move.l a2,-(sp)
    1d0e:	move.l d0,-(sp)
    1d10:	subq.l #2,sp
    1d12:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    1d18:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    1d1e:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    1d24:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    1d2a:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    1d30:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    1d36:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    1d3c:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    1d42:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    1d48:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    1d4e:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    1d54:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    1d5a:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    1d60:	subq.l #2,sp
    1d62:	move.l 136(sp),-(sp)
    1d66:	move.l 136(sp),-(sp)
    1d6a:	move.l 136(sp),-(sp)
    1d6e:	move.l 136(sp),-(sp)
    1d72:	move.l 136(sp),-(sp)
    1d76:	move.l 136(sp),-(sp)
    1d7a:	move.l 136(sp),-(sp)
    1d7e:	move.l 136(sp),-(sp)
    1d82:	move.l 136(sp),-(sp)
    1d86:	move.l 136(sp),-(sp)
    1d8a:	move.l 136(sp),-(sp)
    1d8e:	move.l 136(sp),-(sp)
    1d92:	move.w 138(sp),-(sp)
    1d96:	jsr 13fe <SimpleBlit>(pc)
			LogoShowY1 -= 2;
    1d9a:	subq.w #2,44f68 <LogoShowY1>
    1da0:	lea 128(sp),sp
		LogoShowDone = LogoShowY2 < 1;
    1da4:	tst.w 81a2 <LogoShowY2>
    1daa:	sle d0
    1dac:	ext.w d0
    1dae:	neg.w d0
    1db0:	move.w d0,44f6a <LogoShowDone>
		break;
    1db6:	bra.w 1b86 <BuildLogo+0x14a>
		if (LogoShowY1 >= 0)
    1dba:	move.w 44f68 <LogoShowY1>,d2
    1dc0:	bpl.w 1e86 <BuildLogo+0x44a>
		else if (LogoShowY2 <= 129)
    1dc4:	move.w 81a2 <LogoShowY2>,d2
    1dca:	cmpi.w #129,d2
    1dce:	bgt.w 1f36 <BuildLogo+0x4fa>
			ps.X = 0;
    1dd2:	clr.l d0
    1dd4:	clr.l d1
			ps.Y = LogoShowY2;
    1dd6:	movea.w d2,a2
			pd.X = 32;
    1dd8:	movea.w #32,a0
    1ddc:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1dde:	pea 100 <MoveBobs+0x66>
    1de2:	pea 1 <_start+0x1>
    1de6:	move.l a2,-(sp)
    1de8:	move.l a0,-(sp)
    1dea:	move.l a2,-(sp)
    1dec:	move.l d0,-(sp)
    1dee:	subq.l #2,sp
    1df0:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    1df6:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    1dfc:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    1e02:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    1e08:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    1e0e:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    1e14:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    1e1a:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    1e20:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    1e26:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    1e2c:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    1e32:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    1e38:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    1e3e:	subq.l #2,sp
    1e40:	move.l 136(sp),-(sp)
    1e44:	move.l 136(sp),-(sp)
    1e48:	move.l 136(sp),-(sp)
    1e4c:	move.l 136(sp),-(sp)
    1e50:	move.l 136(sp),-(sp)
    1e54:	move.l 136(sp),-(sp)
    1e58:	move.l 136(sp),-(sp)
    1e5c:	move.l 136(sp),-(sp)
    1e60:	move.l 136(sp),-(sp)
    1e64:	move.l 136(sp),-(sp)
    1e68:	move.l 136(sp),-(sp)
    1e6c:	move.l 136(sp),-(sp)
    1e70:	move.w 138(sp),-(sp)
    1e74:	jsr 13fe <SimpleBlit>(pc)
			LogoShowY2 += 2;
    1e78:	addq.w #2,81a2 <LogoShowY2>
    1e7e:	lea 128(sp),sp
    1e82:	bra.w 1f36 <BuildLogo+0x4fa>
			ps.X = 0;
    1e86:	clr.l d0
    1e88:	clr.l d1
			ps.Y = LogoShowY1;
    1e8a:	movea.w d2,a2
			pd.X = 32;
    1e8c:	movea.w #32,a0
    1e90:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1e92:	pea 100 <MoveBobs+0x66>
    1e96:	pea 1 <_start+0x1>
    1e9a:	move.l a2,-(sp)
    1e9c:	move.l a0,-(sp)
    1e9e:	move.l a2,-(sp)
    1ea0:	move.l d0,-(sp)
    1ea2:	subq.l #2,sp
    1ea4:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    1eaa:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    1eb0:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    1eb6:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    1ebc:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    1ec2:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    1ec8:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    1ece:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    1ed4:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    1eda:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    1ee0:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    1ee6:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    1eec:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    1ef2:	subq.l #2,sp
    1ef4:	move.l 136(sp),-(sp)
    1ef8:	move.l 136(sp),-(sp)
    1efc:	move.l 136(sp),-(sp)
    1f00:	move.l 136(sp),-(sp)
    1f04:	move.l 136(sp),-(sp)
    1f08:	move.l 136(sp),-(sp)
    1f0c:	move.l 136(sp),-(sp)
    1f10:	move.l 136(sp),-(sp)
    1f14:	move.l 136(sp),-(sp)
    1f18:	move.l 136(sp),-(sp)
    1f1c:	move.l 136(sp),-(sp)
    1f20:	move.l 136(sp),-(sp)
    1f24:	move.w 138(sp),-(sp)
    1f28:	jsr 13fe <SimpleBlit>(pc)
			LogoShowY1 -= 2;
    1f2c:	subq.w #2,44f68 <LogoShowY1>
    1f32:	lea 128(sp),sp
		LogoShowDone = LogoShowY2 > 129;
    1f36:	cmpi.w #129,81a2 <LogoShowY2>
    1f3e:	sgt d0
    1f40:	ext.w d0
    1f42:	neg.w d0
    1f44:	move.w d0,44f6a <LogoShowDone>
		break;
    1f4a:	bra.w 1b86 <BuildLogo+0x14a>
			ps.X = 0;
    1f4e:	clr.l d0
    1f50:	clr.l d1
			ps.Y = LogoShowY1;
    1f52:	movea.w d2,a2
			pd.X = 32;
    1f54:	movea.w #32,a0
    1f58:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    1f5a:	pea 100 <MoveBobs+0x66>
    1f5e:	pea 1 <_start+0x1>
    1f62:	move.l a2,-(sp)
    1f64:	move.l a0,-(sp)
    1f66:	move.l a2,-(sp)
    1f68:	move.l d0,-(sp)
    1f6a:	subq.l #2,sp
    1f6c:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    1f72:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    1f78:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    1f7e:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    1f84:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    1f8a:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    1f90:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    1f96:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    1f9c:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    1fa2:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    1fa8:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    1fae:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    1fb4:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    1fba:	subq.l #2,sp
    1fbc:	move.l 136(sp),-(sp)
    1fc0:	move.l 136(sp),-(sp)
    1fc4:	move.l 136(sp),-(sp)
    1fc8:	move.l 136(sp),-(sp)
    1fcc:	move.l 136(sp),-(sp)
    1fd0:	move.l 136(sp),-(sp)
    1fd4:	move.l 136(sp),-(sp)
    1fd8:	move.l 136(sp),-(sp)
    1fdc:	move.l 136(sp),-(sp)
    1fe0:	move.l 136(sp),-(sp)
    1fe4:	move.l 136(sp),-(sp)
    1fe8:	move.l 136(sp),-(sp)
    1fec:	move.w 138(sp),-(sp)
    1ff0:	jsr 13fe <SimpleBlit>(pc)
			LogoShowY1 += 2;
    1ff4:	addq.w #2,44f68 <LogoShowY1>
    1ffa:	lea 128(sp),sp
    1ffe:	bra.w 1b44 <BuildLogo+0x108>
			ps.X = 0;
    2002:	clr.l d0
    2004:	clr.l d1
			ps.Y = LogoShowY2;
    2006:	movea.w d2,a2
			pd.X = 32;
    2008:	movea.w #32,a0
    200c:	suba.l a1,a1
			SimpleBlit(d, BmpUpperPart_PF1, ps, pd, 1, 256);
    200e:	pea 100 <MoveBobs+0x66>
    2012:	pea 1 <_start+0x1>
    2016:	move.l a2,-(sp)
    2018:	move.l a0,-(sp)
    201a:	move.l a2,-(sp)
    201c:	move.l d0,-(sp)
    201e:	subq.l #2,sp
    2020:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    2026:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    202c:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    2032:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    2038:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    203e:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    2044:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    204a:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    2050:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    2056:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    205c:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    2062:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    2068:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    206e:	subq.l #2,sp
    2070:	move.l 136(sp),-(sp)
    2074:	move.l 136(sp),-(sp)
    2078:	move.l 136(sp),-(sp)
    207c:	move.l 136(sp),-(sp)
    2080:	move.l 136(sp),-(sp)
    2084:	move.l 136(sp),-(sp)
    2088:	move.l 136(sp),-(sp)
    208c:	move.l 136(sp),-(sp)
    2090:	move.l 136(sp),-(sp)
    2094:	move.l 136(sp),-(sp)
    2098:	move.l 136(sp),-(sp)
    209c:	move.l 136(sp),-(sp)
    20a0:	move.w 138(sp),-(sp)
    20a4:	jsr 13fe <SimpleBlit>(pc)
			LogoShowY2 -= 2;
    20a8:	subq.w #2,81a2 <LogoShowY2>
    20ae:	lea 128(sp),sp
    20b2:	bra.w 1b44 <BuildLogo+0x108>

000020b6 <DissolveLogo>:

void DissolveLogo(short mode)
{
    20b6:	move.w 6(sp),d0
	switch (mode)
    20ba:	cmpi.w #2,d0
    20be:	beq.w 2380 <DissolveLogo+0x2ca>
    20c2:	bgt.s 2106 <DissolveLogo+0x50>
    20c4:	tst.w d0
    20c6:	beq.w 2198 <DissolveLogo+0xe2>
    20ca:	cmpi.w #1,d0
    20ce:	bne.w 229a <DissolveLogo+0x1e4>
		}
		LogoDissolveDone = LogoShowY2 < 1;
		break;

	case 1:
		if (LogoShowY1 <= 128)
    20d2:	move.w 44f68 <LogoShowY1>,d0
    20d8:	cmpi.w #128,d0
    20dc:	ble.w 229c <DissolveLogo+0x1e6>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
			LogoShowY1 += 2;
		}
		else if (LogoShowY2 <= 129)
    20e0:	move.w 81a2 <LogoShowY2>,d0
    20e6:	cmpi.w #129,d0
    20ea:	ble.w 230e <DissolveLogo+0x258>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
			LogoShowY2 += 2;
		}
		LogoDissolveDone = LogoShowY2 > 129;
    20ee:	cmpi.w #129,81a2 <LogoShowY2>
    20f6:	sgt d0
    20f8:	ext.w d0
    20fa:	neg.w d0
    20fc:	move.w d0,44f66 <LogoDissolveDone>
		break;
    2102:	bra.w 229a <DissolveLogo+0x1e4>
	switch (mode)
    2106:	cmpi.w #3,d0
    210a:	bne.w 229a <DissolveLogo+0x1e4>
		}
		LogoDissolveDone = LogoShowY2 < 1;
		break;

	case 3:
		if (LogoShowY1 >= 0)
    210e:	move.w 44f68 <LogoShowY1>,d0
    2114:	bpl.w 2490 <DissolveLogo+0x3da>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
			LogoShowY1 -= 2;
		}
		else if (LogoShowY2 <= 129)
    2118:	move.w 81a2 <LogoShowY2>,d0
    211e:	cmpi.w #129,d0
    2122:	bgt.w 24fe <DissolveLogo+0x448>
		{
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    2126:	pea 100 <MoveBobs+0x66>
    212a:	pea 1 <_start+0x1>
    212e:	movea.w d0,a0
    2130:	move.l a0,-(sp)
    2132:	pea 20 <_start+0x20>
    2136:	subq.l #2,sp
    2138:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    213e:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    2144:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    214a:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    2150:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    2156:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    215c:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    2162:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    2168:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    216e:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    2174:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    217a:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    2180:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    2186:	jsr 131a <ClearBitmapPart>(pc)
			LogoShowY2 += 2;
    218a:	addq.w #2,81a2 <LogoShowY2>
    2190:	lea 68(sp),sp
    2194:	bra.w 24fe <DissolveLogo+0x448>
		if (LogoShowY1 >= 0)
    2198:	move.w 44f68 <LogoShowY1>,d0
    219e:	bpl.s 221a <DissolveLogo+0x164>
		else if (LogoShowY2 >= 1)
    21a0:	move.w 81a2 <LogoShowY2>,d0
    21a6:	ble.w 2288 <DissolveLogo+0x1d2>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    21aa:	pea 100 <MoveBobs+0x66>
    21ae:	pea 1 <_start+0x1>
    21b2:	movea.w d0,a0
    21b4:	move.l a0,-(sp)
    21b6:	pea 20 <_start+0x20>
    21ba:	subq.l #2,sp
    21bc:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    21c2:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    21c8:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    21ce:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    21d4:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    21da:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    21e0:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    21e6:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    21ec:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    21f2:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    21f8:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    21fe:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    2204:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    220a:	jsr 131a <ClearBitmapPart>(pc)
			LogoShowY2 -= 2;
    220e:	subq.w #2,81a2 <LogoShowY2>
    2214:	lea 68(sp),sp
    2218:	bra.s 2288 <DissolveLogo+0x1d2>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    221a:	pea 100 <MoveBobs+0x66>
    221e:	pea 1 <_start+0x1>
    2222:	movea.w d0,a0
    2224:	move.l a0,-(sp)
    2226:	pea 20 <_start+0x20>
    222a:	subq.l #2,sp
    222c:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    2232:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    2238:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    223e:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    2244:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    224a:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    2250:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    2256:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    225c:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    2262:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    2268:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    226e:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    2274:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    227a:	jsr 131a <ClearBitmapPart>(pc)
			LogoShowY1 -= 2;
    227e:	subq.w #2,44f68 <LogoShowY1>
    2284:	lea 68(sp),sp
		LogoDissolveDone = LogoShowY2 < 1;
    2288:	tst.w 81a2 <LogoShowY2>
    228e:	sle d0
    2290:	ext.w d0
    2292:	neg.w d0
    2294:	move.w d0,44f66 <LogoDissolveDone>
		}
		LogoDissolveDone = LogoShowY2 > 129;
		break;
	}
    229a:	rts
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    229c:	pea 100 <MoveBobs+0x66>
    22a0:	pea 1 <_start+0x1>
    22a4:	movea.w d0,a0
    22a6:	move.l a0,-(sp)
    22a8:	pea 20 <_start+0x20>
    22ac:	subq.l #2,sp
    22ae:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    22b4:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    22ba:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    22c0:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    22c6:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    22cc:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    22d2:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    22d8:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    22de:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    22e4:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    22ea:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    22f0:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    22f6:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    22fc:	jsr 131a <ClearBitmapPart>(pc)
			LogoShowY1 += 2;
    2300:	addq.w #2,44f68 <LogoShowY1>
    2306:	lea 68(sp),sp
    230a:	bra.w 20ee <DissolveLogo+0x38>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    230e:	pea 100 <MoveBobs+0x66>
    2312:	pea 1 <_start+0x1>
    2316:	movea.w d0,a0
    2318:	move.l a0,-(sp)
    231a:	pea 20 <_start+0x20>
    231e:	subq.l #2,sp
    2320:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    2326:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    232c:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    2332:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    2338:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    233e:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    2344:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    234a:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    2350:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    2356:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    235c:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    2362:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    2368:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    236e:	jsr 131a <ClearBitmapPart>(pc)
			LogoShowY2 += 2;
    2372:	addq.w #2,81a2 <LogoShowY2>
    2378:	lea 68(sp),sp
    237c:	bra.w 20ee <DissolveLogo+0x38>
		if (LogoShowY1 <= 128)
    2380:	move.w 44f68 <LogoShowY1>,d0
    2386:	cmpi.w #128,d0
    238a:	ble.s 23ac <DissolveLogo+0x2f6>
		else if (LogoShowY2 >= 1)
    238c:	move.w 81a2 <LogoShowY2>,d0
    2392:	bgt.w 241e <DissolveLogo+0x368>
		LogoDissolveDone = LogoShowY2 < 1;
    2396:	tst.w 81a2 <LogoShowY2>
    239c:	sle d0
    239e:	ext.w d0
    23a0:	neg.w d0
    23a2:	move.w d0,44f66 <LogoDissolveDone>
		break;
    23a8:	bra.w 229a <DissolveLogo+0x1e4>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    23ac:	pea 100 <MoveBobs+0x66>
    23b0:	pea 1 <_start+0x1>
    23b4:	movea.w d0,a0
    23b6:	move.l a0,-(sp)
    23b8:	pea 20 <_start+0x20>
    23bc:	subq.l #2,sp
    23be:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    23c4:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    23ca:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    23d0:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    23d6:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    23dc:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    23e2:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    23e8:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    23ee:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    23f4:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    23fa:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    2400:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    2406:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    240c:	jsr 131a <ClearBitmapPart>(pc)
			LogoShowY1 += 2;
    2410:	addq.w #2,44f68 <LogoShowY1>
    2416:	lea 68(sp),sp
    241a:	bra.w 2396 <DissolveLogo+0x2e0>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
    241e:	pea 100 <MoveBobs+0x66>
    2422:	pea 1 <_start+0x1>
    2426:	movea.w d0,a0
    2428:	move.l a0,-(sp)
    242a:	pea 20 <_start+0x20>
    242e:	subq.l #2,sp
    2430:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    2436:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    243c:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    2442:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    2448:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    244e:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    2454:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    245a:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    2460:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    2466:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    246c:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    2472:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    2478:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    247e:	jsr 131a <ClearBitmapPart>(pc)
			LogoShowY2 -= 2;
    2482:	subq.w #2,81a2 <LogoShowY2>
    2488:	lea 68(sp),sp
    248c:	bra.w 2396 <DissolveLogo+0x2e0>
			ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
    2490:	pea 100 <MoveBobs+0x66>
    2494:	pea 1 <_start+0x1>
    2498:	movea.w d0,a0
    249a:	move.l a0,-(sp)
    249c:	pea 20 <_start+0x20>
    24a0:	subq.l #2,sp
    24a2:	move.l 450d0 <BmpUpperPart_PF1+0x2e>,-(sp)
    24a8:	move.l 450cc <BmpUpperPart_PF1+0x2a>,-(sp)
    24ae:	move.l 450c8 <BmpUpperPart_PF1+0x26>,-(sp)
    24b4:	move.l 450c4 <BmpUpperPart_PF1+0x22>,-(sp)
    24ba:	move.l 450c0 <BmpUpperPart_PF1+0x1e>,-(sp)
    24c0:	move.l 450bc <BmpUpperPart_PF1+0x1a>,-(sp)
    24c6:	move.l 450b8 <BmpUpperPart_PF1+0x16>,-(sp)
    24cc:	move.l 450b4 <BmpUpperPart_PF1+0x12>,-(sp)
    24d2:	move.l 450b0 <BmpUpperPart_PF1+0xe>,-(sp)
    24d8:	move.l 450ac <BmpUpperPart_PF1+0xa>,-(sp)
    24de:	move.l 450a8 <BmpUpperPart_PF1+0x6>,-(sp)
    24e4:	move.l 450a4 <BmpUpperPart_PF1+0x2>,-(sp)
    24ea:	move.w 450a2 <BmpUpperPart_PF1>,-(sp)
    24f0:	jsr 131a <ClearBitmapPart>(pc)
			LogoShowY1 -= 2;
    24f4:	subq.w #2,44f68 <LogoShowY1>
    24fa:	lea 68(sp),sp
		LogoDissolveDone = LogoShowY2 > 129;
    24fe:	cmpi.w #129,81a2 <LogoShowY2>
    2506:	sgt d0
    2508:	ext.w d0
    250a:	neg.w d0
    250c:	move.w d0,44f66 <LogoDissolveDone>
		break;
    2512:	bra.w 229a <DissolveLogo+0x1e4>

00002516 <MainLoop>:
{
    2516:	link.w a5,#-52
    251a:	movem.l d2-d5/a2-a4,-(sp)
	BmpDescriptor bmd = BmpLogo;
    251e:	move.l 4516a <BmpLogo>,-50(a5)
    2526:	move.l 4516e <BmpLogo+0x4>,-46(a5)
    252e:	move.l 45172 <BmpLogo+0x8>,-42(a5)
    2536:	move.l 45176 <BmpLogo+0xc>,-38(a5)
    253e:	move.l 4517a <BmpLogo+0x10>,-34(a5)
    2546:	move.l 4517e <BmpLogo+0x14>,-30(a5)
    254e:	move.l 45182 <BmpLogo+0x18>,-26(a5)
    2556:	move.l 45186 <BmpLogo+0x1c>,-22(a5)
    255e:	move.l 4518a <BmpLogo+0x20>,-18(a5)
    2566:	move.l 4518e <BmpLogo+0x24>,-14(a5)
    256e:	move.l 45192 <BmpLogo+0x28>,-10(a5)
    2576:	move.l 45196 <BmpLogo+0x2c>,-6(a5)
    257e:	move.w 4519a <BmpLogo+0x30>,-2(a5)
	short dissolveMode = 3;
    2586:	moveq #3,d4
	short logoMode = 0;
    2588:	clr.w d3
	short bmpCnt = 0;
    258a:	clr.w d2
    258c:	bra.w 34b4 <MainLoop+0xf9e>
		else if (LogoShowPhase % 2 == 0)
    2590:	move.b 44f6c <LogoShowPhase>,d0
    2596:	btst #0,d0
    259a:	bne.w 2652 <MainLoop+0x13c>
			if (bmpCnt > 3)
    259e:	cmpi.w #3,d2
    25a2:	ble.s 25a6 <MainLoop+0x90>
				bmpCnt = 0;
    25a4:	clr.w d2
			if (LogoShowDone)
    25a6:	tst.w 44f6a <LogoShowDone>
    25ac:	beq.s 25d2 <MainLoop+0xbc>
				LogoShowPhase++;
    25ae:	addq.b #1,d0
    25b0:	move.b d0,44f6c <LogoShowPhase>
				if (dissolveMode == 0)
    25b6:	tst.w d4
    25b8:	bne.s 2604 <MainLoop+0xee>
					LogoShowY1 = 0;
    25ba:	clr.w 44f68 <LogoShowY1>
					LogoShowY2 = 1;
    25c0:	move.w #1,81a2 <LogoShowY2>
					dissolveMode = 1;
    25c8:	moveq #1,d4
				LogoShowPause = 6 * 50;
    25ca:	move.w #300,81a4 <LogoShowPause>
			BuildLogo(bmd, logoMode);
    25d2:	movea.w d3,a0
    25d4:	move.l a0,-(sp)
    25d6:	subq.l #2,sp
    25d8:	lea -4(a5),a0
    25dc:	move.l (a0),-(sp)
    25de:	move.l -(a0),-(sp)
    25e0:	move.l -(a0),-(sp)
    25e2:	move.l -(a0),-(sp)
    25e4:	move.l -(a0),-(sp)
    25e6:	move.l -(a0),-(sp)
    25e8:	move.l -(a0),-(sp)
    25ea:	move.l -(a0),-(sp)
    25ec:	move.l -(a0),-(sp)
    25ee:	move.l -(a0),-(sp)
    25f0:	move.l -(a0),-(sp)
    25f2:	move.l -(a0),-(sp)
    25f4:	move.w -2(a0),-(sp)
    25f8:	jsr 1a3c <BuildLogo>(pc)
    25fc:	lea 56(sp),sp
    2600:	bra.w 34e4 <MainLoop+0xfce>
				else if (dissolveMode == 1)
    2604:	cmpi.w #1,d4
    2608:	beq.s 262a <MainLoop+0x114>
				else if (dissolveMode == 2)
    260a:	cmpi.w #2,d4
    260e:	beq.s 263c <MainLoop+0x126>
				else if (dissolveMode == 3)
    2610:	cmpi.w #3,d4
    2614:	bne.s 25ca <MainLoop+0xb4>
					LogoShowY1 = 128;
    2616:	move.w #128,44f68 <LogoShowY1>
					LogoShowY2 = 129;
    261e:	move.w #129,81a2 <LogoShowY2>
					dissolveMode = 0;
    2626:	clr.w d4
    2628:	bra.s 25ca <MainLoop+0xb4>
					LogoShowY1 = 0;
    262a:	clr.w 44f68 <LogoShowY1>
					LogoShowY2 = 129;
    2630:	move.w #129,81a2 <LogoShowY2>
					dissolveMode = 2;
    2638:	moveq #2,d4
    263a:	bra.s 25ca <MainLoop+0xb4>
					LogoShowY1 = 128;
    263c:	move.w #128,44f68 <LogoShowY1>
					LogoShowY2 = 1;
    2644:	move.w #1,81a2 <LogoShowY2>
					dissolveMode = 3;
    264c:	moveq #3,d4
    264e:	bra.w 25ca <MainLoop+0xb4>
			if (LogoDissolveDone)
    2652:	tst.w 44f66 <LogoDissolveDone>
    2658:	beq.s 26b0 <MainLoop+0x19a>
				LogoShowPhase++;
    265a:	addq.b #1,d0
    265c:	move.b d0,44f6c <LogoShowPhase>
				LogoShowPause = 2 * 50;
    2662:	move.w #100,81a4 <LogoShowPause>
				bmpCnt++;
    266a:	addq.w #1,d2
				if (bmpCnt % 4 == 0)
    266c:	move.w d2,d0
    266e:	andi.w #3,d0
    2672:	beq.s 26be <MainLoop+0x1a8>
				else if (bmpCnt % 4 == 1)
    2674:	move.w d2,d0
    2676:	andi.w #-32765,d0
    267a:	tst.w d2
    267c:	blt.w 270e <MainLoop+0x1f8>
    2680:	cmpi.w #1,d0
    2684:	beq.w 271a <MainLoop+0x204>
				else if (bmpCnt % 4 == 2)
    2688:	cmpi.w #2,d0
    268c:	beq.w 276c <MainLoop+0x256>
				else if (bmpCnt % 4 == 3)
    2690:	cmpi.w #3,d0
    2694:	beq.w 27be <MainLoop+0x2a8>
				if (logoMode == 0)
    2698:	tst.w d3
    269a:	bne.w 2810 <MainLoop+0x2fa>
					LogoShowY1 = 128;
    269e:	move.w #128,44f68 <LogoShowY1>
					LogoShowY2 = 129;
    26a6:	move.w #129,81a2 <LogoShowY2>
					logoMode = 1;
    26ae:	moveq #1,d3
			DissolveLogo(dissolveMode);
    26b0:	movea.w d4,a0
    26b2:	move.l a0,-(sp)
    26b4:	jsr 20b6 <DissolveLogo>(pc)
    26b8:	addq.l #4,sp
    26ba:	bra.w 34e4 <MainLoop+0xfce>
					bmd = BmpLogo;
    26be:	pea 32 <_start+0x32>
    26c2:	pea 4516a <BmpLogo>
    26c8:	pea -50(a5)
    26cc:	jsr 3c18 <memcpy>(pc)
					colP = copPF1ColP;
    26d0:	movea.l 44f62 <copPF1ColP>,a0
    26d6:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    26da:	moveq #1,d0
    26dc:	bra.s 2706 <MainLoop+0x1f0>
						ActPfCol = LogoPaletteRGB4;
    26de:	move.l #33166,819e <ActPfCol>
						colP = copSetColor(colP, a, LogoPaletteRGB4[a]);
    26e8:	move.l d0,d1
    26ea:	add.l d0,d1
    26ec:	lea 818e <LogoPaletteRGB4>,a1
    26f2:	move.w (0,a1,d1.l),2(a0)
    *copListCurrent++ = offsetof(struct Custom, color[index]);
    26f8:	move.w d0,d1
    26fa:	addi.w #192,d1
    26fe:	add.w d1,d1
    2700:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    2702:	addq.l #1,d0
						colP = copSetColor(colP, a, LogoPaletteRGB4[a]);
    2704:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    2706:	moveq #7,d1
    2708:	cmp.l d0,d1
    270a:	bge.s 26de <MainLoop+0x1c8>
    270c:	bra.s 2698 <MainLoop+0x182>
				else if (bmpCnt % 4 == 1)
    270e:	subq.w #1,d0
    2710:	ori.w #-4,d0
    2714:	addq.w #1,d0
    2716:	bra.w 2680 <MainLoop+0x16a>
					bmd = BmpLogo2;
    271a:	pea 32 <_start+0x32>
    271e:	pea 45138 <BmpLogo2>
    2724:	pea -50(a5)
    2728:	jsr 3c18 <memcpy>(pc)
					colP = copPF1ColP;
    272c:	movea.l 44f62 <copPF1ColP>,a0
    2732:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    2736:	moveq #1,d0
    2738:	bra.s 2762 <MainLoop+0x24c>
						ActPfCol = BastardsPaletteRGB4;
    273a:	move.l #33150,819e <ActPfCol>
						colP = copSetColor(colP, a, BastardsPaletteRGB4[a]);
    2744:	move.l d0,d1
    2746:	add.l d0,d1
    2748:	lea 817e <BastardsPaletteRGB4>,a1
    274e:	move.w (0,a1,d1.l),2(a0)
    2754:	move.w d0,d1
    2756:	addi.w #192,d1
    275a:	add.w d1,d1
    275c:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    275e:	addq.l #1,d0
						colP = copSetColor(colP, a, BastardsPaletteRGB4[a]);
    2760:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    2762:	moveq #7,d1
    2764:	cmp.l d0,d1
    2766:	bge.s 273a <MainLoop+0x224>
    2768:	bra.w 2698 <MainLoop+0x182>
					bmd = BmpLogo3;
    276c:	pea 32 <_start+0x32>
    2770:	pea 45106 <BmpLogo3>
    2776:	pea -50(a5)
    277a:	jsr 3c18 <memcpy>(pc)
					colP = copPF1ColP;
    277e:	movea.l 44f62 <copPF1ColP>,a0
    2784:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    2788:	moveq #1,d0
    278a:	bra.s 27b4 <MainLoop+0x29e>
						ActPfCol = bastard_tooPaletteRGB4;
    278c:	move.l #33134,819e <ActPfCol>
						colP = copSetColor(colP, a, bastard_tooPaletteRGB4[a]);
    2796:	move.l d0,d1
    2798:	add.l d0,d1
    279a:	lea 816e <bastard_tooPaletteRGB4>,a1
    27a0:	move.w (0,a1,d1.l),2(a0)
    27a6:	move.w d0,d1
    27a8:	addi.w #192,d1
    27ac:	add.w d1,d1
    27ae:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    27b0:	addq.l #1,d0
						colP = copSetColor(colP, a, bastard_tooPaletteRGB4[a]);
    27b2:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    27b4:	moveq #7,d1
    27b6:	cmp.l d0,d1
    27b8:	bge.s 278c <MainLoop+0x276>
    27ba:	bra.w 2698 <MainLoop+0x182>
					bmd = BmpLogo4;
    27be:	pea 32 <_start+0x32>
    27c2:	pea 450d4 <BmpLogo4>
    27c8:	pea -50(a5)
    27cc:	jsr 3c18 <memcpy>(pc)
					colP = copPF1ColP;
    27d0:	movea.l 44f62 <copPF1ColP>,a0
    27d6:	lea 12(sp),sp
					for (int a = 1; a < 8; a++)
    27da:	moveq #1,d0
    27dc:	bra.s 2806 <MainLoop+0x2f0>
						ActPfCol = bastard_threePaletteRGB4;
    27de:	move.l #33118,819e <ActPfCol>
						colP = copSetColor(colP, a, bastard_threePaletteRGB4[a]);
    27e8:	move.l d0,d1
    27ea:	add.l d0,d1
    27ec:	lea 815e <bastard_threePaletteRGB4>,a1
    27f2:	move.w (0,a1,d1.l),2(a0)
    27f8:	move.w d0,d1
    27fa:	addi.w #192,d1
    27fe:	add.w d1,d1
    2800:	move.w d1,(a0)
					for (int a = 1; a < 8; a++)
    2802:	addq.l #1,d0
						colP = copSetColor(colP, a, bastard_threePaletteRGB4[a]);
    2804:	addq.l #4,a0
					for (int a = 1; a < 8; a++)
    2806:	moveq #7,d1
    2808:	cmp.l d0,d1
    280a:	bge.s 27de <MainLoop+0x2c8>
    280c:	bra.w 2698 <MainLoop+0x182>
				else if (logoMode == 1)
    2810:	cmpi.w #1,d3
    2814:	beq.s 2838 <MainLoop+0x322>
				else if (logoMode == 2)
    2816:	cmpi.w #2,d3
    281a:	beq.s 284e <MainLoop+0x338>
				else if (logoMode == 3)
    281c:	cmpi.w #3,d3
    2820:	bne.w 26b0 <MainLoop+0x19a>
					LogoShowY1 = 0;
    2824:	clr.w 44f68 <LogoShowY1>
					LogoShowY2 = 1;
    282a:	move.w #1,81a2 <LogoShowY2>
					logoMode = 0;
    2832:	clr.w d3
    2834:	bra.w 26b0 <MainLoop+0x19a>
					LogoShowY1 = 128;
    2838:	move.w #128,44f68 <LogoShowY1>
					LogoShowY2 = 1;
    2840:	move.w #1,81a2 <LogoShowY2>
					logoMode = 2;
    2848:	moveq #2,d3
    284a:	bra.w 26b0 <MainLoop+0x19a>
					LogoShowY1 = 0;
    284e:	clr.w 44f68 <LogoShowY1>
					LogoShowY2 = 129;
    2854:	move.w #129,81a2 <LogoShowY2>
					logoMode = 3;
    285c:	moveq #3,d3
    285e:	bra.w 26b0 <MainLoop+0x19a>
				if (ScrollerDir < 1)
    2862:	tst.b 815c <ScrollerDir>
    2868:	ble.w 35dc <MainLoop+0x10c6>
			ScrollerY += ScrollerDir;
    286c:	move.b 815c <ScrollerDir>,d0
    2872:	ext.w d0
    2874:	add.w d0,44f5e <ScrollerY>
		if (ScrollerY >= ScrollerMax)
    287a:	movea.w 44f5e <ScrollerY>,a0
    2880:	move.w 815a <ScrollerMax>,d0
    2886:	moveq #0,d1
    2888:	move.w d0,d1
    288a:	cmp.l a0,d1
    288c:	bgt.w 3612 <MainLoop+0x10fc>
			ScrollerY = ScrollerMax;
    2890:	move.w d0,44f5e <ScrollerY>
			ScrollerDir = -1;
    2896:	st 815c <ScrollerDir>
		if (ScrollerPause < 1)
    289c:	tst.w 44f5c <ScrollerPause>
    28a2:	beq.w 3662 <MainLoop+0x114c>
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
    28a6:	movea.w 44f5e <ScrollerY>,a0
    28ac:	move.l a0,-(sp)
    28ae:	moveq #0,d0
    28b0:	move.w 45012 <BmpScroller+0x6>,d0
    28b6:	move.l d0,-(sp)
    28b8:	moveq #0,d0
    28ba:	move.w 45010 <BmpScroller+0x4>,d0
    28c0:	move.l d0,-(sp)
    28c2:	move.l 4501a <BmpScroller+0xe>,-(sp)
    28c8:	move.l 44f58 <copScrollerBmpP>,-(sp)
    28ce:	clr.l -(sp)
    28d0:	jsr ae2 <copSetPlanesInterleafed>(pc)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[0].X, BobTarget[0].Y, 32, 32);
    28d4:	pea 20 <_start+0x20>
    28d8:	pea 20 <_start+0x20>
    28dc:	move.l 811e <BobTarget+0x4>,-(sp)
    28e2:	move.l 811a <BobTarget>,-(sp)
    28e8:	subq.l #2,sp
    28ea:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    28f0:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    28f6:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    28fc:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    2902:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    2908:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    290e:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    2914:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    291a:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    2920:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    2926:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    292c:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    2932:	lea 4503e <BmpUpperPart_Buf1>,a3
    2938:	move.w (a3),-(sp)
    293a:	lea 131a <ClearBitmapPart>(pc),a2
    293e:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[1].X, BobTarget[1].Y, 32, 32);
    2940:	lea 92(sp),sp
    2944:	pea 20 <_start+0x20>
    2948:	pea 20 <_start+0x20>
    294c:	move.l 8126 <BobTarget+0xc>,-(sp)
    2952:	move.l 8122 <BobTarget+0x8>,-(sp)
    2958:	subq.l #2,sp
    295a:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    2960:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2966:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    296c:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    2972:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    2978:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    297e:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    2984:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    298a:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    2990:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    2996:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    299c:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    29a2:	move.w (a3),-(sp)
    29a4:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[2].X, BobTarget[2].Y, 32, 32);
    29a6:	lea 68(sp),sp
    29aa:	pea 20 <_start+0x20>
    29ae:	pea 20 <_start+0x20>
    29b2:	move.l 812e <BobTarget+0x14>,-(sp)
    29b8:	move.l 812a <BobTarget+0x10>,-(sp)
    29be:	subq.l #2,sp
    29c0:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    29c6:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    29cc:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    29d2:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    29d8:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    29de:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    29e4:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    29ea:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    29f0:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    29f6:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    29fc:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    2a02:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    2a08:	move.w (a3),-(sp)
    2a0a:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[3].X, BobTarget[3].Y, 32, 32);
    2a0c:	lea 68(sp),sp
    2a10:	pea 20 <_start+0x20>
    2a14:	pea 20 <_start+0x20>
    2a18:	move.l 8136 <BobTarget+0x1c>,-(sp)
    2a1e:	move.l 8132 <BobTarget+0x18>,-(sp)
    2a24:	subq.l #2,sp
    2a26:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    2a2c:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2a32:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    2a38:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    2a3e:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    2a44:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2a4a:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    2a50:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    2a56:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    2a5c:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    2a62:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    2a68:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    2a6e:	move.w (a3),-(sp)
    2a70:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[4].X, BobTarget[4].Y, 32, 32);
    2a72:	lea 68(sp),sp
    2a76:	pea 20 <_start+0x20>
    2a7a:	pea 20 <_start+0x20>
    2a7e:	move.l 813e <BobTarget+0x24>,-(sp)
    2a84:	move.l 813a <BobTarget+0x20>,-(sp)
    2a8a:	subq.l #2,sp
    2a8c:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    2a92:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2a98:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    2a9e:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    2aa4:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    2aaa:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2ab0:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    2ab6:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    2abc:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    2ac2:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    2ac8:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    2ace:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    2ad4:	move.w (a3),-(sp)
    2ad6:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[5].X, BobTarget[5].Y, 32, 32);
    2ad8:	lea 68(sp),sp
    2adc:	pea 20 <_start+0x20>
    2ae0:	pea 20 <_start+0x20>
    2ae4:	move.l 8146 <BobTarget+0x2c>,-(sp)
    2aea:	move.l 8142 <BobTarget+0x28>,-(sp)
    2af0:	subq.l #2,sp
    2af2:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    2af8:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2afe:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    2b04:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    2b0a:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    2b10:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2b16:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    2b1c:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    2b22:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    2b28:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    2b2e:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    2b34:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    2b3a:	move.w (a3),-(sp)
    2b3c:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[6].X, BobTarget[6].Y, 32, 32);
    2b3e:	lea 68(sp),sp
    2b42:	pea 20 <_start+0x20>
    2b46:	pea 20 <_start+0x20>
    2b4a:	move.l 814e <BobTarget+0x34>,-(sp)
    2b50:	move.l 814a <BobTarget+0x30>,-(sp)
    2b56:	subq.l #2,sp
    2b58:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    2b5e:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2b64:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    2b6a:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    2b70:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    2b76:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2b7c:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    2b82:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    2b88:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    2b8e:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    2b94:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    2b9a:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    2ba0:	move.w (a3),-(sp)
    2ba2:	jsr (a2)
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[7].X, BobTarget[7].Y, 32, 32);
    2ba4:	lea 68(sp),sp
    2ba8:	pea 20 <_start+0x20>
    2bac:	pea 20 <_start+0x20>
    2bb0:	move.l 8156 <BobTarget+0x3c>,-(sp)
    2bb6:	move.l 8152 <BobTarget+0x38>,-(sp)
    2bbc:	subq.l #2,sp
    2bbe:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    2bc4:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2bca:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    2bd0:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    2bd6:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    2bdc:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2be2:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    2be8:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    2bee:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    2bf4:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    2bfa:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    2c00:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    2c06:	move.w (a3),-(sp)
    2c08:	jsr (a2)
		if (BobPause > 0)
    2c0a:	move.w 44f56 <BobPause>,d0
    2c10:	lea 68(sp),sp
    2c14:	beq.w 36d0 <MainLoop+0x11ba>
			BobPause--;
    2c18:	subq.w #1,d0
    2c1a:	move.w d0,44f56 <BobPause>
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[0], BobTarget[0], 32, 32);
    2c20:	pea 20 <_start+0x20>
    2c24:	pea 20 <_start+0x20>
    2c28:	move.l 811e <BobTarget+0x4>,-(sp)
    2c2e:	move.l 811a <BobTarget>,-(sp)
    2c34:	move.l 609c <BobSource+0x4>,-(sp)
    2c3a:	move.l 6098 <BobSource>,-(sp)
    2c40:	subq.l #2,sp
    2c42:	move.l 44fa4 <BmpCookieMask+0x2e>,-(sp)
    2c48:	move.l 44fa0 <BmpCookieMask+0x2a>,-(sp)
    2c4e:	move.l 44f9c <BmpCookieMask+0x26>,-(sp)
    2c54:	move.l 44f98 <BmpCookieMask+0x22>,-(sp)
    2c5a:	move.l 44f94 <BmpCookieMask+0x1e>,-(sp)
    2c60:	move.l 44f90 <BmpCookieMask+0x1a>,-(sp)
    2c66:	move.l 44f8c <BmpCookieMask+0x16>,-(sp)
    2c6c:	move.l 44f88 <BmpCookieMask+0x12>,-(sp)
    2c72:	move.l 44f84 <BmpCookieMask+0xe>,-(sp)
    2c78:	move.l 44f80 <BmpCookieMask+0xa>,-(sp)
    2c7e:	move.l 44f7c <BmpCookieMask+0x6>,-(sp)
    2c84:	move.l 44f78 <BmpCookieMask+0x2>,-(sp)
    2c8a:	lea 44f76 <BmpCookieMask>,a0
    2c90:	move.w (a0),-(sp)
    2c92:	subq.l #2,sp
    2c94:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    2c9a:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2ca0:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    2ca6:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    2cac:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    2cb2:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2cb8:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    2cbe:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    2cc4:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    2cca:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    2cd0:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    2cd6:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    2cdc:	lea 4503e <BmpUpperPart_Buf1>,a4
    2ce2:	move.w (a4),-(sp)
    2ce4:	subq.l #2,sp
    2ce6:	move.l 44fd6 <BmpCookie+0x2e>,-(sp)
    2cec:	move.l 44fd2 <BmpCookie+0x2a>,-(sp)
    2cf2:	move.l 44fce <BmpCookie+0x26>,-(sp)
    2cf8:	move.l 44fca <BmpCookie+0x22>,-(sp)
    2cfe:	move.l 44fc6 <BmpCookie+0x1e>,-(sp)
    2d04:	move.l 44fc2 <BmpCookie+0x1a>,-(sp)
    2d0a:	move.l 44fbe <BmpCookie+0x16>,-(sp)
    2d10:	move.l 44fba <BmpCookie+0x12>,-(sp)
    2d16:	move.l 44fb6 <BmpCookie+0xe>,-(sp)
    2d1c:	move.l 44fb2 <BmpCookie+0xa>,-(sp)
    2d22:	move.l 44fae <BmpCookie+0x6>,-(sp)
    2d28:	move.l 44faa <BmpCookie+0x2>,-(sp)
    2d2e:	lea 44fa8 <BmpCookie>,a3
    2d34:	move.w (a3),-(sp)
    2d36:	lea 14c2 <BetterBlit>(pc),a2
    2d3a:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[1], BobTarget[1], 32, 32);
    2d3c:	lea 180(sp),sp
    2d40:	pea 20 <_start+0x20>
    2d44:	pea 20 <_start+0x20>
    2d48:	move.l 8126 <BobTarget+0xc>,-(sp)
    2d4e:	move.l 8122 <BobTarget+0x8>,-(sp)
    2d54:	move.l 60a4 <BobSource+0xc>,-(sp)
    2d5a:	move.l 60a0 <BobSource+0x8>,-(sp)
    2d60:	subq.l #2,sp
    2d62:	move.l 44fa4 <BmpCookieMask+0x2e>,-(sp)
    2d68:	move.l 44fa0 <BmpCookieMask+0x2a>,-(sp)
    2d6e:	move.l 44f9c <BmpCookieMask+0x26>,-(sp)
    2d74:	move.l 44f98 <BmpCookieMask+0x22>,-(sp)
    2d7a:	move.l 44f94 <BmpCookieMask+0x1e>,-(sp)
    2d80:	move.l 44f90 <BmpCookieMask+0x1a>,-(sp)
    2d86:	move.l 44f8c <BmpCookieMask+0x16>,-(sp)
    2d8c:	move.l 44f88 <BmpCookieMask+0x12>,-(sp)
    2d92:	move.l 44f84 <BmpCookieMask+0xe>,-(sp)
    2d98:	move.l 44f80 <BmpCookieMask+0xa>,-(sp)
    2d9e:	move.l 44f7c <BmpCookieMask+0x6>,-(sp)
    2da4:	move.l 44f78 <BmpCookieMask+0x2>,-(sp)
    2daa:	lea 44f76 <BmpCookieMask>,a0
    2db0:	move.w (a0),-(sp)
    2db2:	subq.l #2,sp
    2db4:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    2dba:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2dc0:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    2dc6:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    2dcc:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    2dd2:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2dd8:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    2dde:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    2de4:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    2dea:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    2df0:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    2df6:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    2dfc:	move.w (a4),-(sp)
    2dfe:	subq.l #2,sp
    2e00:	move.l 44fd6 <BmpCookie+0x2e>,-(sp)
    2e06:	move.l 44fd2 <BmpCookie+0x2a>,-(sp)
    2e0c:	move.l 44fce <BmpCookie+0x26>,-(sp)
    2e12:	move.l 44fca <BmpCookie+0x22>,-(sp)
    2e18:	move.l 44fc6 <BmpCookie+0x1e>,-(sp)
    2e1e:	move.l 44fc2 <BmpCookie+0x1a>,-(sp)
    2e24:	move.l 44fbe <BmpCookie+0x16>,-(sp)
    2e2a:	move.l 44fba <BmpCookie+0x12>,-(sp)
    2e30:	move.l 44fb6 <BmpCookie+0xe>,-(sp)
    2e36:	move.l 44fb2 <BmpCookie+0xa>,-(sp)
    2e3c:	move.l 44fae <BmpCookie+0x6>,-(sp)
    2e42:	move.l 44faa <BmpCookie+0x2>,-(sp)
    2e48:	move.w (a3),-(sp)
    2e4a:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[2], BobTarget[2], 32, 32);
    2e4c:	lea 180(sp),sp
    2e50:	pea 20 <_start+0x20>
    2e54:	pea 20 <_start+0x20>
    2e58:	move.l 812e <BobTarget+0x14>,-(sp)
    2e5e:	move.l 812a <BobTarget+0x10>,-(sp)
    2e64:	move.l 60ac <BobSource+0x14>,-(sp)
    2e6a:	move.l 60a8 <BobSource+0x10>,-(sp)
    2e70:	subq.l #2,sp
    2e72:	move.l 44fa4 <BmpCookieMask+0x2e>,-(sp)
    2e78:	move.l 44fa0 <BmpCookieMask+0x2a>,-(sp)
    2e7e:	move.l 44f9c <BmpCookieMask+0x26>,-(sp)
    2e84:	move.l 44f98 <BmpCookieMask+0x22>,-(sp)
    2e8a:	move.l 44f94 <BmpCookieMask+0x1e>,-(sp)
    2e90:	move.l 44f90 <BmpCookieMask+0x1a>,-(sp)
    2e96:	move.l 44f8c <BmpCookieMask+0x16>,-(sp)
    2e9c:	move.l 44f88 <BmpCookieMask+0x12>,-(sp)
    2ea2:	move.l 44f84 <BmpCookieMask+0xe>,-(sp)
    2ea8:	move.l 44f80 <BmpCookieMask+0xa>,-(sp)
    2eae:	move.l 44f7c <BmpCookieMask+0x6>,-(sp)
    2eb4:	move.l 44f78 <BmpCookieMask+0x2>,-(sp)
    2eba:	lea 44f76 <BmpCookieMask>,a0
    2ec0:	move.w (a0),-(sp)
    2ec2:	subq.l #2,sp
    2ec4:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    2eca:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2ed0:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    2ed6:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    2edc:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    2ee2:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2ee8:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    2eee:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    2ef4:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    2efa:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    2f00:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    2f06:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    2f0c:	move.w (a4),-(sp)
    2f0e:	subq.l #2,sp
    2f10:	move.l 44fd6 <BmpCookie+0x2e>,-(sp)
    2f16:	move.l 44fd2 <BmpCookie+0x2a>,-(sp)
    2f1c:	move.l 44fce <BmpCookie+0x26>,-(sp)
    2f22:	move.l 44fca <BmpCookie+0x22>,-(sp)
    2f28:	move.l 44fc6 <BmpCookie+0x1e>,-(sp)
    2f2e:	move.l 44fc2 <BmpCookie+0x1a>,-(sp)
    2f34:	move.l 44fbe <BmpCookie+0x16>,-(sp)
    2f3a:	move.l 44fba <BmpCookie+0x12>,-(sp)
    2f40:	move.l 44fb6 <BmpCookie+0xe>,-(sp)
    2f46:	move.l 44fb2 <BmpCookie+0xa>,-(sp)
    2f4c:	move.l 44fae <BmpCookie+0x6>,-(sp)
    2f52:	move.l 44faa <BmpCookie+0x2>,-(sp)
    2f58:	move.w (a3),-(sp)
    2f5a:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[3], BobTarget[3], 32, 32);
    2f5c:	lea 180(sp),sp
    2f60:	pea 20 <_start+0x20>
    2f64:	pea 20 <_start+0x20>
    2f68:	move.l 8136 <BobTarget+0x1c>,-(sp)
    2f6e:	move.l 8132 <BobTarget+0x18>,-(sp)
    2f74:	move.l 60b4 <BobSource+0x1c>,-(sp)
    2f7a:	move.l 60b0 <BobSource+0x18>,-(sp)
    2f80:	subq.l #2,sp
    2f82:	move.l 44fa4 <BmpCookieMask+0x2e>,-(sp)
    2f88:	move.l 44fa0 <BmpCookieMask+0x2a>,-(sp)
    2f8e:	move.l 44f9c <BmpCookieMask+0x26>,-(sp)
    2f94:	move.l 44f98 <BmpCookieMask+0x22>,-(sp)
    2f9a:	move.l 44f94 <BmpCookieMask+0x1e>,-(sp)
    2fa0:	move.l 44f90 <BmpCookieMask+0x1a>,-(sp)
    2fa6:	move.l 44f8c <BmpCookieMask+0x16>,-(sp)
    2fac:	move.l 44f88 <BmpCookieMask+0x12>,-(sp)
    2fb2:	move.l 44f84 <BmpCookieMask+0xe>,-(sp)
    2fb8:	move.l 44f80 <BmpCookieMask+0xa>,-(sp)
    2fbe:	move.l 44f7c <BmpCookieMask+0x6>,-(sp)
    2fc4:	move.l 44f78 <BmpCookieMask+0x2>,-(sp)
    2fca:	lea 44f76 <BmpCookieMask>,a0
    2fd0:	move.w (a0),-(sp)
    2fd2:	subq.l #2,sp
    2fd4:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    2fda:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    2fe0:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    2fe6:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    2fec:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    2ff2:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    2ff8:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    2ffe:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    3004:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    300a:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    3010:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    3016:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    301c:	move.w (a4),-(sp)
    301e:	subq.l #2,sp
    3020:	move.l 44fd6 <BmpCookie+0x2e>,-(sp)
    3026:	move.l 44fd2 <BmpCookie+0x2a>,-(sp)
    302c:	move.l 44fce <BmpCookie+0x26>,-(sp)
    3032:	move.l 44fca <BmpCookie+0x22>,-(sp)
    3038:	move.l 44fc6 <BmpCookie+0x1e>,-(sp)
    303e:	move.l 44fc2 <BmpCookie+0x1a>,-(sp)
    3044:	move.l 44fbe <BmpCookie+0x16>,-(sp)
    304a:	move.l 44fba <BmpCookie+0x12>,-(sp)
    3050:	move.l 44fb6 <BmpCookie+0xe>,-(sp)
    3056:	move.l 44fb2 <BmpCookie+0xa>,-(sp)
    305c:	move.l 44fae <BmpCookie+0x6>,-(sp)
    3062:	move.l 44faa <BmpCookie+0x2>,-(sp)
    3068:	move.w (a3),-(sp)
    306a:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[4], BobTarget[4], 32, 32);
    306c:	lea 180(sp),sp
    3070:	pea 20 <_start+0x20>
    3074:	pea 20 <_start+0x20>
    3078:	move.l 813e <BobTarget+0x24>,-(sp)
    307e:	move.l 813a <BobTarget+0x20>,-(sp)
    3084:	move.l 60bc <BobSource+0x24>,-(sp)
    308a:	move.l 60b8 <BobSource+0x20>,-(sp)
    3090:	subq.l #2,sp
    3092:	move.l 44fa4 <BmpCookieMask+0x2e>,-(sp)
    3098:	move.l 44fa0 <BmpCookieMask+0x2a>,-(sp)
    309e:	move.l 44f9c <BmpCookieMask+0x26>,-(sp)
    30a4:	move.l 44f98 <BmpCookieMask+0x22>,-(sp)
    30aa:	move.l 44f94 <BmpCookieMask+0x1e>,-(sp)
    30b0:	move.l 44f90 <BmpCookieMask+0x1a>,-(sp)
    30b6:	move.l 44f8c <BmpCookieMask+0x16>,-(sp)
    30bc:	move.l 44f88 <BmpCookieMask+0x12>,-(sp)
    30c2:	move.l 44f84 <BmpCookieMask+0xe>,-(sp)
    30c8:	move.l 44f80 <BmpCookieMask+0xa>,-(sp)
    30ce:	move.l 44f7c <BmpCookieMask+0x6>,-(sp)
    30d4:	move.l 44f78 <BmpCookieMask+0x2>,-(sp)
    30da:	lea 44f76 <BmpCookieMask>,a0
    30e0:	move.w (a0),-(sp)
    30e2:	subq.l #2,sp
    30e4:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    30ea:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    30f0:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    30f6:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    30fc:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    3102:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    3108:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    310e:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    3114:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    311a:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    3120:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    3126:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    312c:	move.w (a4),-(sp)
    312e:	subq.l #2,sp
    3130:	move.l 44fd6 <BmpCookie+0x2e>,-(sp)
    3136:	move.l 44fd2 <BmpCookie+0x2a>,-(sp)
    313c:	move.l 44fce <BmpCookie+0x26>,-(sp)
    3142:	move.l 44fca <BmpCookie+0x22>,-(sp)
    3148:	move.l 44fc6 <BmpCookie+0x1e>,-(sp)
    314e:	move.l 44fc2 <BmpCookie+0x1a>,-(sp)
    3154:	move.l 44fbe <BmpCookie+0x16>,-(sp)
    315a:	move.l 44fba <BmpCookie+0x12>,-(sp)
    3160:	move.l 44fb6 <BmpCookie+0xe>,-(sp)
    3166:	move.l 44fb2 <BmpCookie+0xa>,-(sp)
    316c:	move.l 44fae <BmpCookie+0x6>,-(sp)
    3172:	move.l 44faa <BmpCookie+0x2>,-(sp)
    3178:	move.w (a3),-(sp)
    317a:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[5], BobTarget[5], 32, 32);
    317c:	lea 180(sp),sp
    3180:	pea 20 <_start+0x20>
    3184:	pea 20 <_start+0x20>
    3188:	move.l 8146 <BobTarget+0x2c>,-(sp)
    318e:	move.l 8142 <BobTarget+0x28>,-(sp)
    3194:	move.l 60c4 <BobSource+0x2c>,-(sp)
    319a:	move.l 60c0 <BobSource+0x28>,-(sp)
    31a0:	subq.l #2,sp
    31a2:	move.l 44fa4 <BmpCookieMask+0x2e>,-(sp)
    31a8:	move.l 44fa0 <BmpCookieMask+0x2a>,-(sp)
    31ae:	move.l 44f9c <BmpCookieMask+0x26>,-(sp)
    31b4:	move.l 44f98 <BmpCookieMask+0x22>,-(sp)
    31ba:	move.l 44f94 <BmpCookieMask+0x1e>,-(sp)
    31c0:	move.l 44f90 <BmpCookieMask+0x1a>,-(sp)
    31c6:	move.l 44f8c <BmpCookieMask+0x16>,-(sp)
    31cc:	move.l 44f88 <BmpCookieMask+0x12>,-(sp)
    31d2:	move.l 44f84 <BmpCookieMask+0xe>,-(sp)
    31d8:	move.l 44f80 <BmpCookieMask+0xa>,-(sp)
    31de:	move.l 44f7c <BmpCookieMask+0x6>,-(sp)
    31e4:	move.l 44f78 <BmpCookieMask+0x2>,-(sp)
    31ea:	lea 44f76 <BmpCookieMask>,a0
    31f0:	move.w (a0),-(sp)
    31f2:	subq.l #2,sp
    31f4:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    31fa:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    3200:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    3206:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    320c:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    3212:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    3218:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    321e:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    3224:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    322a:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    3230:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    3236:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    323c:	move.w (a4),-(sp)
    323e:	subq.l #2,sp
    3240:	move.l 44fd6 <BmpCookie+0x2e>,-(sp)
    3246:	move.l 44fd2 <BmpCookie+0x2a>,-(sp)
    324c:	move.l 44fce <BmpCookie+0x26>,-(sp)
    3252:	move.l 44fca <BmpCookie+0x22>,-(sp)
    3258:	move.l 44fc6 <BmpCookie+0x1e>,-(sp)
    325e:	move.l 44fc2 <BmpCookie+0x1a>,-(sp)
    3264:	move.l 44fbe <BmpCookie+0x16>,-(sp)
    326a:	move.l 44fba <BmpCookie+0x12>,-(sp)
    3270:	move.l 44fb6 <BmpCookie+0xe>,-(sp)
    3276:	move.l 44fb2 <BmpCookie+0xa>,-(sp)
    327c:	move.l 44fae <BmpCookie+0x6>,-(sp)
    3282:	move.l 44faa <BmpCookie+0x2>,-(sp)
    3288:	move.w (a3),-(sp)
    328a:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[6], BobTarget[6], 32, 32);
    328c:	lea 180(sp),sp
    3290:	pea 20 <_start+0x20>
    3294:	pea 20 <_start+0x20>
    3298:	move.l 814e <BobTarget+0x34>,-(sp)
    329e:	move.l 814a <BobTarget+0x30>,-(sp)
    32a4:	move.l 60cc <BobSource+0x34>,-(sp)
    32aa:	move.l 60c8 <BobSource+0x30>,-(sp)
    32b0:	subq.l #2,sp
    32b2:	move.l 44fa4 <BmpCookieMask+0x2e>,-(sp)
    32b8:	move.l 44fa0 <BmpCookieMask+0x2a>,-(sp)
    32be:	move.l 44f9c <BmpCookieMask+0x26>,-(sp)
    32c4:	move.l 44f98 <BmpCookieMask+0x22>,-(sp)
    32ca:	move.l 44f94 <BmpCookieMask+0x1e>,-(sp)
    32d0:	move.l 44f90 <BmpCookieMask+0x1a>,-(sp)
    32d6:	move.l 44f8c <BmpCookieMask+0x16>,-(sp)
    32dc:	move.l 44f88 <BmpCookieMask+0x12>,-(sp)
    32e2:	move.l 44f84 <BmpCookieMask+0xe>,-(sp)
    32e8:	move.l 44f80 <BmpCookieMask+0xa>,-(sp)
    32ee:	move.l 44f7c <BmpCookieMask+0x6>,-(sp)
    32f4:	move.l 44f78 <BmpCookieMask+0x2>,-(sp)
    32fa:	lea 44f76 <BmpCookieMask>,a0
    3300:	move.w (a0),-(sp)
    3302:	subq.l #2,sp
    3304:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    330a:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    3310:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    3316:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    331c:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    3322:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    3328:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    332e:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    3334:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    333a:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    3340:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    3346:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    334c:	move.w (a4),-(sp)
    334e:	subq.l #2,sp
    3350:	move.l 44fd6 <BmpCookie+0x2e>,-(sp)
    3356:	move.l 44fd2 <BmpCookie+0x2a>,-(sp)
    335c:	move.l 44fce <BmpCookie+0x26>,-(sp)
    3362:	move.l 44fca <BmpCookie+0x22>,-(sp)
    3368:	move.l 44fc6 <BmpCookie+0x1e>,-(sp)
    336e:	move.l 44fc2 <BmpCookie+0x1a>,-(sp)
    3374:	move.l 44fbe <BmpCookie+0x16>,-(sp)
    337a:	move.l 44fba <BmpCookie+0x12>,-(sp)
    3380:	move.l 44fb6 <BmpCookie+0xe>,-(sp)
    3386:	move.l 44fb2 <BmpCookie+0xa>,-(sp)
    338c:	move.l 44fae <BmpCookie+0x6>,-(sp)
    3392:	move.l 44faa <BmpCookie+0x2>,-(sp)
    3398:	move.w (a3),-(sp)
    339a:	jsr (a2)
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[7], BobTarget[7], 32, 32);
    339c:	lea 180(sp),sp
    33a0:	pea 20 <_start+0x20>
    33a4:	pea 20 <_start+0x20>
    33a8:	move.l 8156 <BobTarget+0x3c>,-(sp)
    33ae:	move.l 8152 <BobTarget+0x38>,-(sp)
    33b4:	move.l 60d4 <BobSource+0x3c>,-(sp)
    33ba:	move.l 60d0 <BobSource+0x38>,-(sp)
    33c0:	subq.l #2,sp
    33c2:	move.l 44fa4 <BmpCookieMask+0x2e>,-(sp)
    33c8:	move.l 44fa0 <BmpCookieMask+0x2a>,-(sp)
    33ce:	move.l 44f9c <BmpCookieMask+0x26>,-(sp)
    33d4:	move.l 44f98 <BmpCookieMask+0x22>,-(sp)
    33da:	move.l 44f94 <BmpCookieMask+0x1e>,-(sp)
    33e0:	move.l 44f90 <BmpCookieMask+0x1a>,-(sp)
    33e6:	move.l 44f8c <BmpCookieMask+0x16>,-(sp)
    33ec:	move.l 44f88 <BmpCookieMask+0x12>,-(sp)
    33f2:	move.l 44f84 <BmpCookieMask+0xe>,-(sp)
    33f8:	move.l 44f80 <BmpCookieMask+0xa>,-(sp)
    33fe:	move.l 44f7c <BmpCookieMask+0x6>,-(sp)
    3404:	move.l 44f78 <BmpCookieMask+0x2>,-(sp)
    340a:	lea 44f76 <BmpCookieMask>,a0
    3410:	move.w (a0),-(sp)
    3412:	subq.l #2,sp
    3414:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    341a:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    3420:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    3426:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    342c:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    3432:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    3438:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    343e:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    3444:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    344a:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    3450:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    3456:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    345c:	move.w (a4),-(sp)
    345e:	subq.l #2,sp
    3460:	move.l 44fd6 <BmpCookie+0x2e>,-(sp)
    3466:	move.l 44fd2 <BmpCookie+0x2a>,-(sp)
    346c:	move.l 44fce <BmpCookie+0x26>,-(sp)
    3472:	move.l 44fca <BmpCookie+0x22>,-(sp)
    3478:	move.l 44fc6 <BmpCookie+0x1e>,-(sp)
    347e:	move.l 44fc2 <BmpCookie+0x1a>,-(sp)
    3484:	move.l 44fbe <BmpCookie+0x16>,-(sp)
    348a:	move.l 44fba <BmpCookie+0x12>,-(sp)
    3490:	move.l 44fb6 <BmpCookie+0xe>,-(sp)
    3496:	move.l 44fb2 <BmpCookie+0xa>,-(sp)
    349c:	move.l 44fae <BmpCookie+0x6>,-(sp)
    34a2:	move.l 44faa <BmpCookie+0x2>,-(sp)
    34a8:	move.w (a3),-(sp)
    34aa:	jsr (a2)
		MoveStarfield();
    34ac:	lea 180(sp),sp
    34b0:	jsr 19b0 <MoveStarfield>(pc)
inline short MouseLeft() { return !((*(volatile UBYTE *)0xbfe001) & 64); }
    34b4:	move.b bfe001 <_end+0xbb8ded>,d0
	while (!MouseLeft())
    34ba:	btst #6,d0
    34be:	beq.w 36d8 <MainLoop+0x11c2>
		WaitVbl();
    34c2:	jsr 8c6 <WaitVbl>(pc)
		LightsUp(&LightsUpPhase);
    34c6:	pea 44f6d <LightsUpPhase>
    34cc:	jsr 2ba <LightsUp>(pc)
		if (LogoShowPause > 0)
    34d0:	move.w 81a4 <LogoShowPause>,d0
    34d6:	addq.l #4,sp
    34d8:	beq.w 2590 <MainLoop+0x7a>
			LogoShowPause--;
    34dc:	subq.w #1,d0
    34de:	move.w d0,81a4 <LogoShowPause>
		CopyBitmapPart(BmpUpperPart_Buf1, BmpUpperPart_PF2, 46, 78);
    34e4:	pea 4e <_start+0x4e>
    34e8:	pea 2e <_start+0x2e>
    34ec:	subq.l #2,sp
    34ee:	move.l 4509e <BmpUpperPart_PF2+0x2e>,-(sp)
    34f4:	move.l 4509a <BmpUpperPart_PF2+0x2a>,-(sp)
    34fa:	move.l 45096 <BmpUpperPart_PF2+0x26>,-(sp)
    3500:	move.l 45092 <BmpUpperPart_PF2+0x22>,-(sp)
    3506:	move.l 4508e <BmpUpperPart_PF2+0x1e>,-(sp)
    350c:	move.l 4508a <BmpUpperPart_PF2+0x1a>,-(sp)
    3512:	move.l 45086 <BmpUpperPart_PF2+0x16>,-(sp)
    3518:	move.l 45082 <BmpUpperPart_PF2+0x12>,-(sp)
    351e:	move.l 4507e <BmpUpperPart_PF2+0xe>,-(sp)
    3524:	move.l 4507a <BmpUpperPart_PF2+0xa>,-(sp)
    352a:	move.l 45076 <BmpUpperPart_PF2+0x6>,-(sp)
    3530:	move.l 45072 <BmpUpperPart_PF2+0x2>,-(sp)
    3536:	move.w 45070 <BmpUpperPart_PF2>,-(sp)
    353c:	subq.l #2,sp
    353e:	move.l 4506c <BmpUpperPart_Buf1+0x2e>,-(sp)
    3544:	move.l 45068 <BmpUpperPart_Buf1+0x2a>,-(sp)
    354a:	move.l 45064 <BmpUpperPart_Buf1+0x26>,-(sp)
    3550:	move.l 45060 <BmpUpperPart_Buf1+0x22>,-(sp)
    3556:	move.l 4505c <BmpUpperPart_Buf1+0x1e>,-(sp)
    355c:	move.l 45058 <BmpUpperPart_Buf1+0x1a>,-(sp)
    3562:	move.l 45054 <BmpUpperPart_Buf1+0x16>,-(sp)
    3568:	move.l 45050 <BmpUpperPart_Buf1+0x12>,-(sp)
    356e:	move.l 4504c <BmpUpperPart_Buf1+0xe>,-(sp)
    3574:	move.l 45048 <BmpUpperPart_Buf1+0xa>,-(sp)
    357a:	move.l 45044 <BmpUpperPart_Buf1+0x6>,-(sp)
    3580:	move.l 45040 <BmpUpperPart_Buf1+0x2>,-(sp)
    3586:	move.w 4503e <BmpUpperPart_Buf1>,-(sp)
    358c:	jsr 1296 <CopyBitmapPart>(pc)
		if (BounceEnabled)
    3590:	move.w 44f60 <BounceEnabled>,d5
    3596:	lea 112(sp),sp
    359a:	beq.s 35fc <MainLoop+0x10e6>
			if (ScrollerDir > 0)
    359c:	move.b 815c <ScrollerDir>,d0
    35a2:	ble.s 35e8 <MainLoop+0x10d2>
				ScrollerDir = ((ScrollerMax - ScrollerY) * 1000 / 12000);
    35a4:	moveq #0,d0
    35a6:	move.w 815a <ScrollerMax>,d0
    35ac:	pea c <_start+0xc>
    35b0:	movea.l d0,a0
    35b2:	suba.w 44f5e <ScrollerY>,a0
    35b8:	move.l a0,-(sp)
    35ba:	jsr 3cfa <__divsi3>
    35c0:	addq.l #8,sp
    35c2:	move.b d0,815c <ScrollerDir>
				if (ScrollerDir > 6)
    35c8:	cmpi.b #6,d0
    35cc:	ble.w 2862 <MainLoop+0x34c>
					ScrollerDir = 6;
    35d0:	move.b #6,815c <ScrollerDir>
    35d8:	bra.w 2862 <MainLoop+0x34c>
					ScrollerDir = 1;
    35dc:	move.b #1,815c <ScrollerDir>
    35e4:	bra.w 286c <MainLoop+0x356>
				if (ScrollerDir > -5)
    35e8:	cmpi.b #-4,d0
    35ec:	blt.w 286c <MainLoop+0x356>
					ScrollerDir--;
    35f0:	subq.b #1,d0
    35f2:	move.b d0,815c <ScrollerDir>
    35f8:	bra.w 286c <MainLoop+0x356>
			if (ScrollerPause > 0)
    35fc:	move.w 44f5c <ScrollerPause>,d0
    3602:	beq.w 287a <MainLoop+0x364>
				ScrollerPause--;
    3606:	subq.w #1,d0
    3608:	move.w d0,44f5c <ScrollerPause>
    360e:	bra.w 287a <MainLoop+0x364>
		else if (ScrollerY <= ScrollerMin)
    3612:	cmpa.w #0,a0
    3616:	bgt.w 289c <MainLoop+0x386>
			ScrollerY = ScrollerMin;
    361a:	clr.w 44f5e <ScrollerY>
			ScrollerDir = 1;
    3620:	move.b #1,815c <ScrollerDir>
			if (BounceEnabled)
    3628:	tst.w d5
    362a:	beq.s 364c <MainLoop+0x1136>
				if (ScrollerMax < SCRT_MAX)
    362c:	cmpi.w #39,d0
    3630:	bhi.s 363a <MainLoop+0x1124>
					ScrollerMax += ScrollerMax;
    3632:	add.w d0,d0
    3634:	move.w d0,815a <ScrollerMax>
				if (ScrollerMax > SCRT_MAX)
    363a:	cmpi.w #40,815a <ScrollerMax>
    3642:	bls.s 364c <MainLoop+0x1136>
					ScrollerMax = SCRT_MAX;
    3644:	move.w #40,815a <ScrollerMax>
			if (ScrollerPause > 0)
    364c:	move.w 44f5c <ScrollerPause>,d0
    3652:	beq.w 289c <MainLoop+0x386>
				ScrollerPause--;
    3656:	subq.w #1,d0
    3658:	move.w d0,44f5c <ScrollerPause>
    365e:	bra.w 289c <MainLoop+0x386>
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
    3662:	pea 4 <_start+0x4>
    3666:	pea 20 <_start+0x20>
    366a:	pea 28 <_start+0x28>
    366e:	move.l 4501a <BmpScroller+0xe>,-(sp)
    3674:	subq.l #2,sp
    3676:	move.l 4503a <BmpScroller+0x2e>,-(sp)
    367c:	move.l 45036 <BmpScroller+0x2a>,-(sp)
    3682:	move.l 45032 <BmpScroller+0x26>,-(sp)
    3688:	move.l 4502e <BmpScroller+0x22>,-(sp)
    368e:	move.l 4502a <BmpScroller+0x1e>,-(sp)
    3694:	move.l 45026 <BmpScroller+0x1a>,-(sp)
    369a:	move.l 45022 <BmpScroller+0x16>,-(sp)
    36a0:	move.l 4501e <BmpScroller+0x12>,-(sp)
    36a6:	move.l 4501a <BmpScroller+0xe>,-(sp)
    36ac:	move.l 45016 <BmpScroller+0xa>,-(sp)
    36b2:	move.l 45012 <BmpScroller+0x6>,-(sp)
    36b8:	move.l 4500e <BmpScroller+0x2>,-(sp)
    36be:	move.w 4500c <BmpScroller>,-(sp)
    36c4:	jsr 6fe <Scrollit>(pc)
    36c8:	lea 68(sp),sp
    36cc:	bra.w 28a6 <MainLoop+0x390>
			MoveBobs();
    36d0:	jsr 9a <MoveBobs>(pc)
    36d4:	bra.w 2c20 <MainLoop+0x70a>
}
    36d8:	movem.l -80(a5),d2-d5/a2-a4
    36de:	unlk a5
    36e0:	rts

000036e2 <KPrintF>:
void KPrintF(const char* fmt, ...) {
    36e2:	lea -128(sp),sp
    36e6:	movem.l a2-a3/a6,-(sp)
	if(*((UWORD *)UaeDbgLog) == 0x4eb9 || *((UWORD *)UaeDbgLog) == 0xa00e) {
    36ea:	move.w f0ff60 <_end+0xecad4c>,d0
    36f0:	cmpi.w #20153,d0
    36f4:	beq.s 3718 <KPrintF+0x36>
    36f6:	cmpi.w #-24562,d0
    36fa:	beq.s 3718 <KPrintF+0x36>
		RawDoFmt((CONST_STRPTR)fmt, vl, KPutCharX, 0);
    36fc:	movea.l 45208 <SysBase>,a6
    3702:	movea.l 144(sp),a0
    3706:	lea 148(sp),a1
    370a:	lea 3d76 <KPutCharX>,a2
    3710:	suba.l a3,a3
    3712:	jsr -522(a6)
    3716:	bra.s 3742 <KPrintF+0x60>
		RawDoFmt((CONST_STRPTR)fmt, vl, PutChar, temp);
    3718:	movea.l 45208 <SysBase>,a6
    371e:	movea.l 144(sp),a0
    3722:	lea 148(sp),a1
    3726:	lea 3d84 <PutChar>,a2
    372c:	lea 12(sp),a3
    3730:	jsr -522(a6)
		UaeDbgLog(86, temp);
    3734:	move.l a3,-(sp)
    3736:	pea 56 <_start+0x56>
    373a:	jsr f0ff60 <_end+0xecad4c>
    3740:	addq.l #8,sp
}
    3742:	movem.l (sp)+,a2-a3/a6
    3746:	lea 128(sp),sp
    374a:	rts

0000374c <main>:
{
    374c:	move.l a6,-(sp)
    374e:	move.l a2,-(sp)
	SysBase = *((struct ExecBase **)4UL);
    3750:	movea.l 4 <_start+0x4>,a6
    3754:	move.l a6,45208 <SysBase>
	custom = (struct Custom *)0xdff000;
    375a:	move.l #14675968,4520e <custom>
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
    3764:	lea 57c1 <incbin_P61_Player_end+0x1>,a1
    376a:	moveq #0,d0
    376c:	jsr -552(a6)
    3770:	move.l d0,45204 <GfxBase>
	if (!GfxBase)
    3776:	beq.w 3bba <main+0x46e>
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
    377a:	movea.l 45208 <SysBase>,a6
    3780:	lea 57d2 <incbin_P61_Player_end+0x12>,a1
    3786:	moveq #0,d0
    3788:	jsr -552(a6)
    378c:	move.l d0,45200 <DOSBase>
	if (!DOSBase)
    3792:	beq.w 3bca <main+0x47e>
	KPrintF("Hello debugger from Amiga!\n");
    3796:	pea 57de <incbin_P61_Player_end+0x1e>
    379c:	jsr 36e2 <KPrintF>(pc)
	BitmapInit(&Screen, 320, 256, 3);
    37a0:	pea 3 <_start+0x3>
    37a4:	pea 100 <MoveBobs+0x66>
    37a8:	pea 140 <MoveBobs+0xa6>
    37ac:	pea 451ce <Screen>
    37b2:	lea 16a0 <BitmapInit>(pc),a2
    37b6:	jsr (a2)
	BitmapInit(&BmpMuerte, 320, 256, 5);
    37b8:	pea 5 <_start+0x5>
    37bc:	pea 100 <MoveBobs+0x66>
    37c0:	pea 140 <MoveBobs+0xa6>
    37c4:	pea 4519c <BmpMuerte>
    37ca:	jsr (a2)
	BitmapInit(&BmpLogo, 256, 130, 3);
    37cc:	lea 36(sp),sp
    37d0:	pea 3 <_start+0x3>
    37d4:	pea 82 <_start+0x82>
    37d8:	pea 100 <MoveBobs+0x66>
    37dc:	pea 4516a <BmpLogo>
    37e2:	jsr (a2)
	BitmapInit(&BmpLogo2, 256, 130, 3);
    37e4:	pea 3 <_start+0x3>
    37e8:	pea 82 <_start+0x82>
    37ec:	pea 100 <MoveBobs+0x66>
    37f0:	pea 45138 <BmpLogo2>
    37f6:	jsr (a2)
	BitmapInit(&BmpLogo3, 256, 130, 3);
    37f8:	lea 32(sp),sp
    37fc:	pea 3 <_start+0x3>
    3800:	pea 82 <_start+0x82>
    3804:	pea 100 <MoveBobs+0x66>
    3808:	pea 45106 <BmpLogo3>
    380e:	jsr (a2)
	BitmapInit(&BmpLogo4, 256, 130, 3);
    3810:	pea 3 <_start+0x3>
    3814:	pea 82 <_start+0x82>
    3818:	pea 100 <MoveBobs+0x66>
    381c:	pea 450d4 <BmpLogo4>
    3822:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF1, 320, 130, 3);
    3824:	lea 32(sp),sp
    3828:	pea 3 <_start+0x3>
    382c:	pea 82 <_start+0x82>
    3830:	pea 140 <MoveBobs+0xa6>
    3834:	pea 450a2 <BmpUpperPart_PF1>
    383a:	jsr (a2)
	BitmapInit(&BmpUpperPart_PF2, 320 + 64, 130, 3);
    383c:	pea 3 <_start+0x3>
    3840:	pea 82 <_start+0x82>
    3844:	pea 180 <MoveBobs+0xe6>
    3848:	pea 45070 <BmpUpperPart_PF2>
    384e:	jsr (a2)
	BitmapInit(&BmpUpperPart_Buf1, 320 + 64, 130, 3);
    3850:	lea 32(sp),sp
    3854:	pea 3 <_start+0x3>
    3858:	pea 82 <_start+0x82>
    385c:	pea 180 <MoveBobs+0xe6>
    3860:	pea 4503e <BmpUpperPart_Buf1>
    3866:	jsr (a2)
	BitmapInit(&BmpScroller, 320 + 32, 166, 3);
    3868:	pea 3 <_start+0x3>
    386c:	pea a6 <MoveBobs+0xc>
    3870:	pea 160 <MoveBobs+0xc6>
    3874:	pea 4500c <BmpScroller>
    387a:	jsr (a2)
	BitmapInit(&BmpFont32, 320, 256, 3);
    387c:	lea 32(sp),sp
    3880:	pea 3 <_start+0x3>
    3884:	pea 100 <MoveBobs+0x66>
    3888:	pea 140 <MoveBobs+0xa6>
    388c:	pea 44fda <BmpFont32>
    3892:	jsr (a2)
	BitmapInit(&BmpCookie, 320, 256, 3);
    3894:	pea 3 <_start+0x3>
    3898:	pea 100 <MoveBobs+0x66>
    389c:	pea 140 <MoveBobs+0xa6>
    38a0:	pea 44fa8 <BmpCookie>
    38a6:	jsr (a2)
	BitmapInit(&BmpCookieMask, 320, 256, 3);
    38a8:	lea 32(sp),sp
    38ac:	pea 3 <_start+0x3>
    38b0:	pea 100 <MoveBobs+0x66>
    38b4:	pea 140 <MoveBobs+0xa6>
    38b8:	pea 44f76 <BmpCookieMask>
    38be:	jsr (a2)
	copPtrMain = AllocMem(1024, MEMF_CHIP);
    38c0:	movea.l 45208 <SysBase>,a6
    38c6:	move.l #1024,d0
    38cc:	moveq #2,d1
    38ce:	jsr -198(a6)
    38d2:	move.l d0,44f72 <copPtrMain>
	copPtrIntro = AllocMem(512, MEMF_CHIP);
    38d8:	movea.l 45208 <SysBase>,a6
    38de:	move.l #512,d0
    38e4:	moveq #2,d1
    38e6:	jsr -198(a6)
    38ea:	move.l d0,44f6e <copPtrIntro>
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
    38f0:	movea.l 45208 <SysBase>,a6
    38f6:	moveq #0,d0
    38f8:	move.w 45018 <BmpScroller+0xc>,d0
    38fe:	move.l #65538,d1
    3904:	jsr -198(a6)
    3908:	move.l d0,4501a <BmpScroller+0xe>
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
    390e:	movea.l 45208 <SysBase>,a6
    3914:	moveq #0,d0
    3916:	move.w 450ae <BmpUpperPart_PF1+0xc>,d0
    391c:	move.l #65538,d1
    3922:	jsr -198(a6)
    3926:	move.l d0,450b0 <BmpUpperPart_PF1+0xe>
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
    392c:	movea.l 45208 <SysBase>,a6
    3932:	moveq #0,d0
    3934:	move.w 4507c <BmpUpperPart_PF2+0xc>,d0
    393a:	move.l #65538,d1
    3940:	jsr -198(a6)
    3944:	move.l d0,4507e <BmpUpperPart_PF2+0xe>
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
    394a:	movea.l 45208 <SysBase>,a6
    3950:	moveq #0,d0
    3952:	move.w 4504a <BmpUpperPart_Buf1+0xc>,d0
    3958:	move.l #65538,d1
    395e:	jsr -198(a6)
    3962:	move.l d0,4504c <BmpUpperPart_Buf1+0xe>
	BmpMuerte.ImageData = (UWORD *)BmpMuerteP;
    3968:	move.l #33192,451aa <BmpMuerte+0xe>
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
    3972:	move.l #84394,45178 <BmpLogo+0xe>
	BmpLogo2.ImageData = (UWORD *)BmpLogo2P;
    397c:	move.l #96876,45146 <BmpLogo2+0xe>
	BmpLogo3.ImageData = (UWORD *)BmpLogo3P;
    3986:	move.l #109358,45114 <BmpLogo3+0xe>
	BmpLogo4.ImageData = (UWORD *)BmpLogo4P;
    3990:	move.l #121840,450e2 <BmpLogo4+0xe>
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
    399a:	move.l #134322,44fe8 <BmpFont32+0xe>
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
    39a4:	move.l #165044,44fb6 <BmpCookie+0xe>
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;
    39ae:	move.l #195766,44f84 <BmpCookieMask+0xe>
	InitImagePlanes(&BmpMuerte, 0);
    39b8:	clr.l -(sp)
    39ba:	pea 4519c <BmpMuerte>
    39c0:	lea a98 <InitImagePlanes>(pc),a2
    39c4:	jsr (a2)
	InitImagePlanes(&BmpLogo, 0);
    39c6:	clr.l -(sp)
    39c8:	pea 4516a <BmpLogo>
    39ce:	jsr (a2)
	InitImagePlanes(&BmpLogo2, 0);
    39d0:	lea 32(sp),sp
    39d4:	clr.l -(sp)
    39d6:	pea 45138 <BmpLogo2>
    39dc:	jsr (a2)
	InitImagePlanes(&BmpLogo3, 0);
    39de:	clr.l -(sp)
    39e0:	pea 45106 <BmpLogo3>
    39e6:	jsr (a2)
	InitImagePlanes(&BmpLogo4, 0);
    39e8:	clr.l -(sp)
    39ea:	pea 450d4 <BmpLogo4>
    39f0:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF1, 0);
    39f2:	clr.l -(sp)
    39f4:	pea 450a2 <BmpUpperPart_PF1>
    39fa:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_PF2, 32 / 8);
    39fc:	lea 32(sp),sp
    3a00:	pea 4 <_start+0x4>
    3a04:	pea 45070 <BmpUpperPart_PF2>
    3a0a:	jsr (a2)
	InitImagePlanes(&BmpUpperPart_Buf1, 32 / 8);
    3a0c:	pea 4 <_start+0x4>
    3a10:	pea 4503e <BmpUpperPart_Buf1>
    3a16:	jsr (a2)
	InitImagePlanes(&BmpScroller, 0);
    3a18:	clr.l -(sp)
    3a1a:	pea 4500c <BmpScroller>
    3a20:	jsr (a2)
	InitImagePlanes(&BmpFont32, 0);
    3a22:	clr.l -(sp)
    3a24:	pea 44fda <BmpFont32>
    3a2a:	jsr (a2)
	InitImagePlanes(&BmpCookie, 0);
    3a2c:	lea 32(sp),sp
    3a30:	clr.l -(sp)
    3a32:	pea 44fa8 <BmpCookie>
    3a38:	jsr (a2)
	InitImagePlanes(&BmpCookieMask, 0);
    3a3a:	clr.l -(sp)
    3a3c:	pea 44f76 <BmpCookieMask>
    3a42:	jsr (a2)
	InitStarfieldSprite();
    3a44:	jsr 16da <InitStarfieldSprite>(pc)
	SetupCopper(copPtrMain);
    3a48:	move.l 44f72 <copPtrMain>,-(sp)
    3a4e:	jsr d64 <SetupCopper>(pc)
	SetupCopperIntro(copPtrIntro);
    3a52:	move.l 44f6e <copPtrIntro>,-(sp)
    3a58:	jsr b52 <SetupCopperIntro>(pc)
	TakeSystem();
    3a5c:	jsr 90c <TakeSystem>(pc)
	WaitVbl();
    3a60:	jsr 8c6 <WaitVbl>(pc)
	custom->cop1lc = (ULONG)copPtrIntro;
    3a64:	movea.l 4520e <custom>,a0
    3a6a:	move.l 44f6e <copPtrIntro>,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    3a72:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
    3a78:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    3a7e:	move.w #-30752,150(a0)
	SetInterruptHandler((APTR)interruptHandler);
    3a84:	pea 1650 <interruptHandler>(pc)
    3a88:	jsr 8ac <SetInterruptHandler>(pc)
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
    3a8c:	movea.l 4520e <custom>,a0
    3a92:	move.w #-16352,154(a0)
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
    3a98:	move.w #32,156(a0)
	IntroLoop();
    3a9e:	jsr 8c <IntroLoop>(pc)
    3aa2:	lea 28(sp),sp
    3aa6:	move.b bfe001 <_end+0xbb8ded>,d0
	while (MouseLeft())
    3aac:	btst #6,d0
    3ab0:	beq.s 3aa6 <main+0x35a>
	WaitVbl();
    3ab2:	jsr 8c6 <WaitVbl>(pc)
	custom->cop1lc = (ULONG)copPtrMain;
    3ab6:	movea.l 4520e <custom>,a0
    3abc:	move.l 44f72 <copPtrMain>,128(a0)
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
    3ac4:	move.w #64,150(a0)
	custom->copjmp1 = 0x7fff;	   //start coppper
    3aca:	move.w #32767,136(a0)
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
    3ad0:	move.w #-30752,150(a0)
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
    3ad6:	move.w #-24576,154(a0)
	if (p61Init(module) != 0)
    3adc:	pea 374b8 <incbin_module_start>
    3ae2:	jsr 160c <p61Init>(pc)
    3ae6:	addq.l #4,sp
    3ae8:	tst.l d0
    3aea:	bne.w 3bd6 <main+0x48a>
	MainLoop();
    3aee:	jsr 2516 <MainLoop>(pc)
	p61End();
    3af2:	jsr 167e <p61End>(pc)
	FreeMem(copPtrMain, 1024);
    3af6:	movea.l 45208 <SysBase>,a6
    3afc:	movea.l 44f72 <copPtrMain>,a1
    3b02:	move.l #1024,d0
    3b08:	jsr -210(a6)
	FreeMem(copPtrIntro, 512);
    3b0c:	movea.l 45208 <SysBase>,a6
    3b12:	movea.l 44f6e <copPtrIntro>,a1
    3b18:	move.l #512,d0
    3b1e:	jsr -210(a6)
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
    3b22:	movea.l 45208 <SysBase>,a6
    3b28:	movea.l 4501a <BmpScroller+0xe>,a1
    3b2e:	moveq #0,d0
    3b30:	move.w 45018 <BmpScroller+0xc>,d0
    3b36:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
    3b3a:	movea.l 45208 <SysBase>,a6
    3b40:	movea.l 450b0 <BmpUpperPart_PF1+0xe>,a1
    3b46:	moveq #0,d0
    3b48:	move.w 450ae <BmpUpperPart_PF1+0xc>,d0
    3b4e:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
    3b52:	movea.l 45208 <SysBase>,a6
    3b58:	movea.l 4507e <BmpUpperPart_PF2+0xe>,a1
    3b5e:	moveq #0,d0
    3b60:	move.w 4507c <BmpUpperPart_PF2+0xc>,d0
    3b66:	jsr -210(a6)
	FreeMem((UBYTE *)BmpUpperPart_Buf1.ImageData, BmpUpperPart_PF2.Btot);
    3b6a:	movea.l 45208 <SysBase>,a6
    3b70:	movea.l 4504c <BmpUpperPart_Buf1+0xe>,a1
    3b76:	moveq #0,d0
    3b78:	move.w 4507c <BmpUpperPart_PF2+0xc>,d0
    3b7e:	jsr -210(a6)
	CloseLibrary((struct Library *)DOSBase);
    3b82:	movea.l 45208 <SysBase>,a6
    3b88:	movea.l 45200 <DOSBase>,a1
    3b8e:	jsr -414(a6)
	CloseLibrary((struct Library *)GfxBase);
    3b92:	movea.l 45208 <SysBase>,a6
    3b98:	movea.l 45204 <GfxBase>,a1
    3b9e:	jsr -414(a6)
	FreeSystem();
    3ba2:	jsr 9d8 <FreeSystem>(pc)
	Exit(0);
    3ba6:	movea.l 45200 <DOSBase>,a6
    3bac:	moveq #0,d1
    3bae:	jsr -144(a6)
}
    3bb2:	moveq #0,d0
    3bb4:	movea.l (sp)+,a2
    3bb6:	movea.l (sp)+,a6
    3bb8:	rts
		Exit(0);
    3bba:	movea.l 45200 <DOSBase>,a6
    3bc0:	moveq #0,d1
    3bc2:	jsr -144(a6)
    3bc6:	bra.w 377a <main+0x2e>
		Exit(0);
    3bca:	movea.l d0,a6
    3bcc:	moveq #0,d1
    3bce:	jsr -144(a6)
    3bd2:	bra.w 3796 <main+0x4a>
		KPrintF("p61Init failed!\n");
    3bd6:	pea 57fa <incbin_P61_Player_end+0x3a>
    3bdc:	jsr 36e2 <KPrintF>(pc)
    3be0:	addq.l #4,sp
    3be2:	bra.w 3aee <main+0x3a2>

00003be6 <strlen>:
unsigned long strlen(const char* s) {
    3be6:	movea.l 4(sp),a0
	unsigned long t=0;
    3bea:	moveq #0,d0
    3bec:	bra.s 3bf0 <strlen+0xa>
		t++;
    3bee:	addq.l #1,d0
	while(*s++)
    3bf0:	tst.b (a0)+
    3bf2:	bne.s 3bee <strlen+0x8>
}
    3bf4:	rts

00003bf6 <memset>:
	void* memset(void *dest, int val, unsigned long len) {
    3bf6:	move.l d2,-(sp)
    3bf8:	move.l 8(sp),d0
    3bfc:	move.l 12(sp),d2
    3c00:	move.l 16(sp),d1
	unsigned char *ptr = (unsigned char *)dest;
    3c04:	movea.l d0,a0
    3c06:	bra.s 3c0c <memset+0x16>
		*ptr++ = val;
    3c08:	move.b d2,(a0)+
	while(len-- > 0)
    3c0a:	move.l a1,d1
    3c0c:	movea.l d1,a1
    3c0e:	subq.l #1,a1
    3c10:	tst.l d1
    3c12:	bne.s 3c08 <memset+0x12>
}
    3c14:	move.l (sp)+,d2
    3c16:	rts

00003c18 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
    3c18:	move.l d2,-(sp)
    3c1a:	move.l 8(sp),d0
    3c1e:	movea.l 12(sp),a1
    3c22:	move.l 16(sp),d1
	char *d = (char *)dest;
    3c26:	movea.l d0,a0
    3c28:	bra.s 3c2e <memcpy+0x16>
		*d++ = *s++;
    3c2a:	move.b (a1)+,(a0)+
	while(len--)
    3c2c:	move.l d2,d1
    3c2e:	move.l d1,d2
    3c30:	subq.l #1,d2
    3c32:	tst.l d1
    3c34:	bne.s 3c2a <memcpy+0x12>
}
    3c36:	move.l (sp)+,d2
    3c38:	rts

00003c3a <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
    3c3a:	move.l d2,-(sp)
    3c3c:	move.l 8(sp),d0
    3c40:	movea.l 12(sp),a0
    3c44:	move.l 16(sp),d1
	if (d < s) {
    3c48:	cmpa.l d0,a0
    3c4a:	bhi.s 3c66 <memmove+0x2c>
		const char *lasts = s + (len - 1);
    3c4c:	movea.l d1,a1
    3c4e:	subq.l #1,a1
    3c50:	adda.l a1,a0
		char *lastd = d + (len - 1);
    3c52:	adda.l d0,a1
		while (len--)
    3c54:	bra.s 3c72 <memmove+0x38>
			*d++ = *s++;
    3c56:	move.b (a0)+,(a1)+
		while (len--)
    3c58:	move.l d2,d1
    3c5a:	move.l d1,d2
    3c5c:	subq.l #1,d2
    3c5e:	tst.l d1
    3c60:	bne.s 3c56 <memmove+0x1c>
}
    3c62:	move.l (sp)+,d2
    3c64:	rts
	char *d = dest;
    3c66:	movea.l d0,a1
    3c68:	bra.s 3c5a <memmove+0x20>
			*lastd-- = *lasts--;
    3c6a:	move.b (a0),(a1)
    3c6c:	subq.l #1,a1
    3c6e:	subq.l #1,a0
		while (len--)
    3c70:	move.l d2,d1
    3c72:	move.l d1,d2
    3c74:	subq.l #1,d2
    3c76:	tst.l d1
    3c78:	bne.s 3c6a <memmove+0x30>
    3c7a:	bra.s 3c62 <memmove+0x28>

00003c7c <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
    3c7c:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
    3c80:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
    3c84:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
    3c88:	mulu.w 8(sp),d1
	addw	d1, d0
    3c8c:	add.w d1,d0
	swap	d0
    3c8e:	swap d0
	clrw	d0
    3c90:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
    3c92:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
    3c96:	mulu.w 10(sp),d1
	addl	d1, d0
    3c9a:	add.l d1,d0
	rts
    3c9c:	rts

00003c9e <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
    3c9e:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
    3ca0:	move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
    3ca4:	move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
    3ca8:	cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
    3cae:	bcc.s 3cc6 <__udivsi3+0x28>
	movel	d0, d2
    3cb0:	move.l d0,d2
	clrw	d2
    3cb2:	clr.w d2
	swap	d2
    3cb4:	swap d2
	divu	d1, d2          /* high quotient in lower word */
    3cb6:	divu.w d1,d2
	movew	d2, d0		/* save high quotient */
    3cb8:	move.w d2,d0
	swap	d0
    3cba:	swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
    3cbc:	move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
    3cc0:	divu.w d1,d2
	movew	d2, d0
    3cc2:	move.w d2,d0
	jra	6f
    3cc4:	bra.s 3cf6 <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
    3cc6:	move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
    3cc8:	lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
    3cca:	lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
    3ccc:	cmpi.l #65536,d1
	jcc	4b
    3cd2:	bcc.s 3cc8 <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
    3cd4:	divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
    3cd6:	andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
    3cdc:	move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
    3cde:	mulu.w d0,d1
	swap	d2
    3ce0:	swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
    3ce2:	mulu.w d0,d2
	swap	d2		/* align high part with low part */
    3ce4:	swap d2
	tstw	d2		/* high part 17 bits? */
    3ce6:	tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
    3ce8:	bne.s 3cf4 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
    3cea:	add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
    3cec:	bcs.s 3cf4 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
    3cee:	cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
    3cf2:	bls.s 3cf6 <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
    3cf4:	subq.l #1,d0

6:	movel	sp@+, d2
    3cf6:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    3cf8:	rts

00003cfa <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
    3cfa:	move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
    3cfc:	moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
    3cfe:	move.l 12(sp),d1
	jpl	1f
    3d02:	bpl.s 3d08 <__divsi3+0xe>
	negl	d1
    3d04:	neg.l d1
	negb	d2		/* change sign because divisor <0  */
    3d06:	neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
    3d08:	move.l 8(sp),d0
	jpl	2f
    3d0c:	bpl.s 3d12 <__divsi3+0x18>
	negl	d0
    3d0e:	neg.l d0
	negb	d2
    3d10:	neg.b d2

2:	movel	d1, sp@-
    3d12:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3d14:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
    3d16:	bsr.s 3c9e <__udivsi3>
	addql	#8, sp
    3d18:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
    3d1a:	tst.b d2
	jpl	3f
    3d1c:	bpl.s 3d20 <__divsi3+0x26>
	negl	d0
    3d1e:	neg.l d0

3:	movel	sp@+, d2
    3d20:	move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
    3d22:	rts

00003d24 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    3d24:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    3d28:	move.l 4(sp),d0
	movel	d1, sp@-
    3d2c:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3d2e:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
    3d30:	bsr.s 3cfa <__divsi3>
	addql	#8, sp
    3d32:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    3d34:	move.l 8(sp),d1
	movel	d1, sp@-
    3d38:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3d3a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    3d3c:	bsr.w 3c7c <__mulsi3>
	addql	#8, sp
    3d40:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    3d42:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    3d46:	sub.l d0,d1
	movel	d1, d0
    3d48:	move.l d1,d0
	rts
    3d4a:	rts

00003d4c <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
    3d4c:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
    3d50:	move.l 4(sp),d0
	movel	d1, sp@-
    3d54:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3d56:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
    3d58:	bsr.w 3c9e <__udivsi3>
	addql	#8, sp
    3d5c:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
    3d5e:	move.l 8(sp),d1
	movel	d1, sp@-
    3d62:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
    3d64:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
    3d66:	bsr.w 3c7c <__mulsi3>
	addql	#8, sp
    3d6a:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
    3d6c:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
    3d70:	sub.l d0,d1
	movel	d1, d0
    3d72:	move.l d1,d0
	rts
    3d74:	rts

00003d76 <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
    3d76:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
    3d78:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
    3d7c:	jsr -516(a6)
    move.l (sp)+, a6
    3d80:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
    3d82:	rts

00003d84 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
    3d84:	move.b d0,(a3)+
	rts
    3d86:	rts

00003d88 <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
    3d88:	movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
    3d8a:	adda.l a0,a2
	move.l	a2,a3
    3d8c:	movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
    3d8e:	move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
    3d90:	moveq #56,d4
	moveq	#8,d5
    3d92:	moveq #8,d5
	bra.s	.Lliteral
    3d94:	bra.s 3dfe <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
    3d96:	move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
    3d98:	move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
    3d9a:	dbf d1,3d96 <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
    3d9e:	lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
    3da0:	bcc.s 3da4 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
    3da2:	move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
    3da4:	tst.w d0
    3da6:	bne.s 3db0 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
    3da8:	cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
    3daa:	bls.s 3e22 <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
    3dac:	move.w (a0)+,d0
    3dae:	swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
    3db0:	rol.l #6,d0
	move.w	d0,d1
    3db2:	move.w d0,d1
	and.w	d4,d1
    3db4:	and.w d4,d1
	eor.w	d1,d0
    3db6:	eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
    3db8:	movem.w (3e1c <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
    3dbe:	rol.l d2,d0
	and.w	d0,d3					|scaling
    3dc0:	and.w d0,d3
	eor.w	d3,d0
    3dc2:	eor.w d3,d0
	suba.w	d3,a4
    3dc4:	suba.w d3,a4
	adda.l	a1,a4
    3dc6:	adda.l a1,a4

	|Decode the match length
	DOY_REFILL
    3dc8:	tst.w d0
    3dca:	bne.s 3dd0 <_doynaxdepack_asm+0x48>
    3dcc:	move.w (a0)+,d0
    3dce:	swap d0
	and.w	d5,d1					|Check the initial length bit from the
    3dd0:	and.w d5,d1
	beq.s	.Lmcopy					|type triple
    3dd2:	beq.s 3dea <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
    3dd4:	moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
    3dd6:	tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
    3dd8:	bpl.s 3de6 <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
    3dda:	lsl.l #2,d0
	bpl.s	.Lmendlen1
    3ddc:	bpl.s 3de4 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
    3dde:	addx.b d1,d1
	lsl.l	#2,d0
    3de0:	lsl.l #2,d0
	bmi.s	.Lmgetlen
    3de2:	bmi.s 3dde <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
    3de4:	addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
    3de6:	lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
    3de8:	bcc.s 3dec <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
    3dea:	move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
    3dec:	move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
    3dee:	dbf d1,3dea <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
    3df2:	add.l d0,d0
	bcc.s	.Lmatch
    3df4:	bcc.s 3da4 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
    3df6:	tst.w d0
    3df8:	bne.s 3dfe <_doynaxdepack_asm+0x76>
    3dfa:	move.w (a0)+,d0
    3dfc:	swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
    3dfe:	moveq #0,d1
	add.l	d0,d0
    3e00:	add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
    3e02:	bcc.s 3da2 <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
    3e04:	bpl.s 3e0c <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
    3e06:	addx.b d1,d1
	lsl.l	#2,d0
    3e08:	lsl.l #2,d0
	bmi.s	.Llgetlen
    3e0a:	bmi.s 3e06 <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
    3e0c:	addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
    3e0e:	dbv.s d1,3d96 <_doynaxdepack_asm+0xe>

	add.l	d0,d0
    3e12:	add.l d0,d0
	eor.w	d1,d0		
    3e14:	eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
    3e16:	ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
    3e18:	move.w (a0)+,d1
	bra.s	.Llcopy_near
    3e1a:	bra.s 3e0e <_doynaxdepack_asm+0x86>

00003e1c <doy_table>:
    3e1c:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
    3e2c:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
    3e3c:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
    3e4c:	.............o
