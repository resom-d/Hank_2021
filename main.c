#include "headers/hank2021.h"

int main()
{

	SysBase = *((struct ExecBase **)4UL);
	custom = (struct Custom *)0xdff000;

	// We will use the graphics library only to locate and restore the system copper list once we are through.
	GfxBase = (struct GfxBase *)OpenLibrary((CONST_STRPTR) "graphics.library", 0);
	if (!GfxBase)
		Exit(0);

	// used for printing
	DOSBase = (struct DosLibrary *)OpenLibrary((CONST_STRPTR) "dos.library", 0);
	if (!DOSBase)
		Exit(0);

#ifdef __cplusplus
	KPrintF("Hello debugger from Amiga: %ld!\n", staticClass.i);
#else
	KPrintF("Hello debugger from Amiga!\n");
#endif

	Write(Output(), (APTR) "Hello console!\n", 15);

	BitmapInit(&Screen, 320, 256, 3);
	BitmapInit(&BmpLogo, 256, 130, 3);
	BitmapInit(&BmpUpperPart_PF1, 320, 130, 3);
	BitmapInit(&BmpUpperPart_PF2, 320 + 64, 130, 3);
	BitmapInit(&BmpUpperPart_Buf1, 320 + 64, 130, 3);
	BitmapInit(&BmpScroller, 320 + 32, 166, 3);
	BitmapInit(&BmpFont32, 320, 256, 3);
	BitmapInit(&BmpCookie, 320, 256, 3);
	BitmapInit(&BmpCookieMask, 320, 256, 3);

	copPtr = AllocMem(1024, MEMF_CHIP);
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
	BmpUpperPart_Buf1.ImageData = (UWORD *)AllocMem(BmpUpperPart_Buf1.Btot, MEMF_CHIP | MEMF_CLEAR);
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;

	InitImagePlanes(&BmpUpperPart_PF1, 0);
	InitImagePlanes(&BmpUpperPart_PF2, 32 / 8);
	InitImagePlanes(&BmpUpperPart_Buf1, 32 / 8);
	InitImagePlanes(&BmpScroller, 0);
	InitImagePlanes(&BmpFont32, 0);
	InitImagePlanes(&BmpCookie, 0);
	InitImagePlanes(&BmpCookieMask, 0);

	TakeSystem();

	// setup the sprite's pixels
	InitStarfieldSprite();
	// copy logo to upper half
	// Point2D ps = {0, 0};
	// Point2D pd = {32, 0};
	// SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);

	WaitVbl();

	SetupCopper(copPtr);
	custom->cop1lc = (ULONG)copPtr;
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
	custom->copjmp1 = 0x7fff;	   //start coppper
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
	// DEMO
	SetInterruptHandler((APTR)interruptHandler);
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
#ifdef MUSIC
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
#endif
		//try init music

#ifdef MUSIC
	if (p61Init(module) != 0)
		KPrintF("p61Init failed!\n");
#endif
	// MAIN LOOP
	MainLoop();
	// CLEANUP
#ifdef MUSIC
	p61End();
#endif
	FreeMem(copPtr, 1024);
	FreeMem((UBYTE *)BmpScroller.ImageData, BmpScroller.Btot);
	FreeMem((UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Btot);
	FreeMem((UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Btot);
	FreeMem((UBYTE *)BmpUpperPart_Buf1.ImageData, BmpUpperPart_PF2.Btot);
	// CLOSE SYSTEM-LIBS
	CloseLibrary((struct Library *)DOSBase);
	CloseLibrary((struct Library *)GfxBase);
	// FREE SYSTEM
	FreeSystem();

	Exit(0);
}

void MainLoop()
{
	static BOOL LogoShowEnabled = TRUE;
	static BOOL BobsMoveEnabled = FALSE;

	while (!MouseLeft())
	{
		// wait for vertical blank
		WaitVbl();
		// logo show && dissolve
		if (LogoShowPause > 0)
		{
			LogoShowPause--;
		}
		else if (LogoShowPhase == 0 && LogoShowPause == 0)
		{
			BuildLogo();
			if (LogoShowY1 > 128 && LogoShowY2 > 129)
			{
				LogoShowY1 = 128;
				LogoShowY2 = 129;
				LogoShowPhase = 1;
				LogoShowPause = 4 * 50;
			}
		}
		else if (LogoShowPhase == 1 && LogoShowPause == 0)
		{
			DissolveLogo();
			if (LogoShowY1 < 0 && LogoShowY2 < 1)
			{
				LogoShowY1 = 0;
				LogoShowY2 = 1;
				LogoShowPhase = 0;
				LogoShowPause = 2 * 50;
			}
		}
		// needed for color change in lower half
		if (ResetCopper)
		{
			SetupCopper(copPtr);
			custom->cop1lc = (ULONG)copPtr;
			custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
			custom->copjmp1 = 0x7fff;	   //start coppper
			custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER | DMAF_BLITHOG | DMAF_SPRITE;
			ResetCopper = FALSE;
		}
		// copy buffer to bob-bitplanes
		CopyBitmap(BmpUpperPart_Buf1, BmpUpperPart_PF2);
		// calculate bounce levels and check bounds
		if (BounceEnabled)
		{
			if (ScrollerDir > 0)
			{
				ScrollerDir = ((ScrollerMax - ScrollerY) * 1000 / 12000);
				if(ScrollerDir > 6)
				{
					ScrollerDir = 6;
				}
				if(ScrollerDir < 1)
				{
					ScrollerDir = 1;
				}
			}
			else
			{
				if (ScrollerDir > -5)
				{
					ScrollerDir--;
				}
			}
			ScrollerY += ScrollerDir;
		}
		else
		{
			// decrement scroller pause
			if (ScrollerPause > 0)
			{
				ScrollerPause--;
			}
		}

		if (ScrollerY >= ScrollerMax)
		{
			ScrollerY = ScrollerMax;
			ScrollerDir = -1;
		}
		else if (ScrollerY <= ScrollerMin)
		{
			ScrollerY = ScrollerMin;
			ScrollerDir = 1;
			// decrement scroller pause
			if (ScrollerPause > 0)
			{
				ScrollerPause--;
			}
		}
		// make scroller scroll
		if (ScrollerPause < 1)
		{
			Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
		}
		// make scroller bounce
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
		// start preparing for next vblank
		// clear all bobs...
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[0].X, BobTarget[0].Y, 32, 32);
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[1].X, BobTarget[1].Y, 32, 32);
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[2].X, BobTarget[2].Y, 32, 32);
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[3].X, BobTarget[3].Y, 32, 32);
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[4].X, BobTarget[4].Y, 32, 32);
		ClearBitmapPart(BmpUpperPart_Buf1, BobTarget[5].X, BobTarget[5].Y, 32, 32);
		// ...move bobs...
		if (BobPause > 0)
		{
			BobPause--;
		}
		else
		{
			MoveBobs();
		}
		// ...and repaint them
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[0], BobTarget[0], 32, 32);
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[1], BobTarget[1], 32, 32);
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[2], BobTarget[2], 32, 32);
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[3], BobTarget[3], 32, 32);
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[4], BobTarget[4], 32, 32);
		BetterBlit(BmpCookie, BmpUpperPart_Buf1, BmpCookieMask, BobSource[5], BobTarget[5], 32, 32);
		// move sprites at last - they won't flicker anyways
		MoveStarfield();
		//custom->color[0] = 0xf00;
	}
}

void MoveBobs()
{
	switch (BobPhase)
	{
	case 0: // left to right
		for (int b = 0; b < BOBSN - 1; b++)
		{
			if ((BobTarget[b + 1].X - BobTarget[b].X) > 34 || BobTarget[b + 1].X >= 320 + 32)
			{
				BobTarget[b].X += BobVecs[b].X;
				if (BobTarget[b].X > 320 + 32)
				{
					BobTarget[b].X = 320 + 32;
				}
			}
		}
		BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
		if (BobTarget[BOBSN - 1].X > 320 + 32)
		{
			BobTarget[BOBSN - 1].X = 320 + 32;
		}
		if (BobTarget[0].X >= 320 + 32)
		{
			BobVecs[0].X *= -1;
			BobVecs[1].X *= -1;
			BobVecs[2].X *= -1;
			BobVecs[3].X *= -1;
			BobVecs[4].X *= -1;
			BobVecs[5].X *= -1;
			BobPhase = 1;
			BobPause = 2 * 50;
			*copPF1BmpP = 0 << 6; // prio. in bplcon2: pf1 >> pf 2 >> sprites
		}
		break;

	case 1: // right to left
		for (int b = 0; b < BOBSN - 1; b++)
		{
			if ((BobTarget[b].X - BobTarget[b + 1].X) > 34 || BobTarget[b + 1].X <= 0)
			{
				BobTarget[b].X += BobVecs[b].X;
				if (BobTarget[b].X < 0)
				{
					BobTarget[b].X = 0;
				}
			}
		}
		BobTarget[BOBSN - 1].X += BobVecs[BOBSN - 1].X;
		if (BobTarget[BOBSN - 1].X < 0)
		{
			BobTarget[BOBSN - 1].X = 0;
		}
		if (BobTarget[0].X <= 0)
		{
			BobVecs[0].X *= -1;
			BobVecs[1].X *= -1;
			BobVecs[2].X *= -1;
			BobVecs[3].X *= -1;
			BobVecs[4].X *= -1;
			BobVecs[5].X *= -1;
			BobPause = 2 * 50;
			BobPhase = 0;
			*copPF1BmpP = 1 << 6; // prio. in bplcon2: pf2 >> pf 1 >> sprites
		}
		break;
	}
}

void SetupCopper(USHORT *copPtr)
{
	UBYTE line = 0x1c;
	// set screen output size
	*copPtr++ = DIWSTRT;
	*copPtr++ = 0x2c81;
	*copPtr++ = DIWSTOP;
	*copPtr++ = 0x2cc1;
	*copPtr++ = DDFSTRT;
	*copPtr++ = 0x38;
	*copPtr++ = DDFSTOP;
	*copPtr++ = 0xd0;
	// set pf1/2 modulos
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - Screen.Bpl, BmpUpperPart_PF2.Bplt - Screen.Bpl);
	*copPtr++ = BPLCON1; //scrolling
	*copPtr++ = 0;
	*copPtr++ = BPLCON2; //playfied priority
	copPF1BmpP = copPtr;
	*copPtr++ = 1 << 6; //pf2 >> pf 1 >> sprites
	// set logo colors
	copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[0]);
	copPtr = copSetColor(copPtr, 7, colgradbluePaletteRGB4[0]);
	for (int a = 1; a < 8; a++)
	{
		copPtr = copSetColor(copPtr, a, LogoPaletteRGB4[a]);
	}
	for (int a = 8; a < 16; a++)
	{
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a - 8]);
	}
	// set upper part, pf1, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.Planes[0], BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, FALSE);
	// set upper part, pf2, bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.Planes[0], BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, TRUE);
	// set sprite pointers
	*copPtr++ = SPR0PTH;
	*copPtr++ = (LONG)StarSprite >> 16;
	*copPtr++ = SPR0PTL;
	*copPtr++ = (LONG)StarSprite;
	*copPtr++ = SPR1PTH;
	*copPtr++ = (LONG)NullSprite >> 16;
	*copPtr++ = SPR1PTL;
	*copPtr++ = (LONG)NullSprite;
	// sprite 0+1 colors
	copPtr = copSetColor(copPtr, 17, 0x848);
	copPtr = copSetColor(copPtr, 18, 0x08f);
	copPtr = copSetColor(copPtr, 19, 0xfff);
	*copPtr++ = SPR2PTH;
	*copPtr++ = (LONG)NullSprite >> 16;
	*copPtr++ = SPR2PTL;
	*copPtr++ = (LONG)NullSprite;
	*copPtr++ = SPR3PTH;
	*copPtr++ = (LONG)NullSprite >> 16;
	*copPtr++ = SPR3PTL;
	*copPtr++ = (LONG)NullSprite;
	*copPtr++ = SPR4PTH;
	*copPtr++ = (LONG)NullSprite >> 16;
	*copPtr++ = SPR4PTL;
	*copPtr++ = (LONG)NullSprite;
	*copPtr++ = SPR5PTH;
	*copPtr++ = (LONG)NullSprite >> 16;
	*copPtr++ = SPR5PTL;
	*copPtr++ = (LONG)NullSprite;
	*copPtr++ = SPR6PTH;
	*copPtr++ = (LONG)NullSprite >> 16;
	*copPtr++ = SPR6PTL;
	*copPtr++ = (LONG)NullSprite;
	*copPtr++ = SPR7PTH;
	*copPtr++ = (LONG)NullSprite >> 16;
	*copPtr++ = SPR7PTL;
	*copPtr++ = (LONG)NullSprite;
	// enable bitplanes
	*copPtr++ = BPLCON0;
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;
	// wait till below logo
	line = 0x2c + BmpUpperPart_PF1.Height;
	copPtr = copWaitY(copPtr, line++);
	// turn off bitplanes to waste 8 lines, giving the logo more bottom space
	// turn off bitplanes to waste 8 lines, giving the logo more bottom space
	*copPtr++ = BPLCON0;
	*copPtr++ = (0) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
	line = 0x2c + BmpUpperPart_PF1.Height + 8;
	copPtr = copWaitY(copPtr, line++);
	// set bitplane pointers
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
	//set modulo for scroller
	copPtr = copSetBplMod(0, copPtr,
						  BmpScroller.Bplt - Screen.Bpl,
						  BmpScroller.Bplt - Screen.Bpl);
	*copPtr++ = BPLCON0;
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;
	// set font colors for scroller
	for (int a = 1; a < 8; a++)
	{
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);
	}
	// blue gradient below logo
	for (int l = 0; l < 24; l++)
	{
		copPtr = copWaitY(copPtr, line);
		copPtr = copSetColor(copPtr, 0, colgradbluePaletteRGB4[l]);
		line += 2;
	}
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	line += 7;
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// set bitplane mods
	line = 0x2c + BmpLogo.Height + 72 + 7; // 209
	copPtr = copWaitY(copPtr, line++);
	copMirrorBmpP = copPtr;
	copPtr = copSetBplMod(0, copPtr, (BmpLogo.Bplt - BmpLogo.Bpl), (BmpLogo.Bplt - BmpLogo.Bpl));
	// wait for beam crossing byte boundary
	copPtr = copWaitXY(copPtr, 0xf0, 0xff);
	// give lower part color and some stripes
	line = 0x05;
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	line = 0x2c;
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[0]);
	copPtr = copWaitY(copPtr, line++);
	copPtr = copSetColor(copPtr, 0, colScrollMirror[1]);
	// copper end
	copPtr = copWaitXY(copPtr, 0xff, 0xff);
}

void EnableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2),
				 (BmpScroller.Bplt - Screen.Bpl) - (BmpScroller.Bplt * 2));
}

void DisableMirrorEffect()
{
	copSetBplMod(0, copMirrorBmpP,
				 BmpScroller.Bplt - Screen.Bpl,
				 BmpScroller.Bplt - Screen.Bpl);
}

void Scrollit(BmpDescriptor theDesc, UBYTE *theBitmap, USHORT startY, USHORT height, UBYTE speed)
{
	int BltOffs = startY * theDesc.Bplt;
	int Brcorner = height * theDesc.Bplt - 2;

	WaitBlit();

	custom->bltcon0 = ((UWORD)speed << 12) + 0x9f0;
	custom->bltcon1 = 0x0002;
	custom->bltafwm = 0xffff;
	custom->bltalwm = 0xffff;
	custom->bltapt = theBitmap + BltOffs + Brcorner;
	custom->bltdpt = theBitmap + BltOffs + Brcorner;
	custom->bltamod = 0;
	custom->bltdmod = 0;
	custom->bltsize = ((height * theDesc.Bpls) << 6) + BmpScroller.Width / 16;

	ScrollCnt += speed;
	if (ScrollCnt >= NextPlot)
	{
		ScrollCnt = 0;
		PlotChar(BmpFont32, BmpScroller, startY, 32, 32);
	}
}

void PlotChar(BmpDescriptor bmpFont, BmpDescriptor bmpDest, USHORT plotY, USHORT charW, USHORT charH)
{
	UBYTE chr = Scrolltext[ScrolltextCnt++];
	ULONG source, dest;
	ULONG row, col;

	// Set standard char distance
	NextPlot = 32;
	// scroller commands: b=bounce; m=mirror; s=stop; c=color
	if (chr == 'b')
	{
		if (BounceEnabled)
		{
			ScrollerY = SCRT_MIN;
			ScrollerDir = 1;
		}
		BounceEnabled = !BounceEnabled;

		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'm')
	{
		if (MirrorEnabled)
		{
			DisableMirrorEffect();
		}
		else
		{
			EnableMirrorEffect();
		}

		MirrorEnabled = !MirrorEnabled;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 's')
	{
		ScrollerPause = BounceEnabled ? (Scrolltext[ScrolltextCnt++] - 48) : (Scrolltext[ScrolltextCnt++] - 48) * 50;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr == 'c')
	{
		colScrollMirror[0] = 0x6bf;
		colScrollMirror[1] = 0x49b;
		ResetCopper = TRUE;
	}
	// select character for different spacing
	if (chr == '!' || chr == 'I' || chr == '.' || chr == ',' || chr == ':' || chr == ';' || chr == '\'')
	{
		NextPlot = 12;
	}
	if (chr == 'J')
	{
		NextPlot = 24;
	}
	// check for end of text
	if (chr == 0)
	{
		ScrolltextCnt = 0;
		chr = Scrolltext[ScrolltextCnt++];
		colScrollMirror[0] = 0x111;
		colScrollMirror[1] = 0x222;
		ResetCopper = TRUE;
	}
	// check legal values
	if (chr < 32 || chr > (32 + 80))
	{
		return;
	}
	// skip first 32 ascii codes
	chr -= 32;
	// get row and column of source bitmap (10 chrs per row)
	row = chr / 10;
	col = chr % 10;
	// calc source bitplane pointer
	source = (row * bmpFont.Bplt * charH) + (col << 2);
	// calc destination bitplane pointer
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);
	// wait for blitter and blit
	WaitBlit();
	custom->bltcon0 = 0x09f0;
	custom->bltcon1 = 0x0000;
	custom->bltafwm = 0xffff;
	custom->bltalwm = 0xffff;
	custom->bltapt = ((UBYTE *)bmpFont.ImageData) + source;
	custom->bltdpt = ((UBYTE *)bmpDest.ImageData) + dest;
	custom->bltamod = bmpFont.Bpl - charW / 8;
	custom->bltdmod = bmpDest.Bpl - charW / 8;
	custom->bltsize = ((charH * bmpFont.Bpls) << 6) + (charW / 16);
}

static APTR GetVBR()
{
	APTR vbr = 0;
	UWORD getvbr[] = {0x4e7a, 0x0801, 0x4e73}; // MOVEC.L VBR,D0 RTE

	if (SysBase->AttnFlags & AFF_68010)
		vbr = (APTR)Supervisor((ULONG(*)())getvbr);

	return vbr;
}

void SetInterruptHandler(APTR interrupt)
{
	*(volatile APTR *)(((UBYTE *)VBR) + 0x6c) = interrupt;
}

APTR GetInterruptHandler()
{
	return *(volatile APTR *)(((UBYTE *)VBR) + 0x6c);
}

//vblank begins at vpos 312 hpos 1 and ends at vpos 25 hpos 1
//vsync begins at line 2 hpos 132 and ends at vpos 5 hpos 18
void WaitVbl()
{
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
		vpos &= 0x1ff00;
		if (vpos != (311 << 8))
			break;
	}
	while (1)
	{
		volatile ULONG vpos = *(volatile ULONG *)0xDFF004;
		vpos &= 0x1ff00;
		if (vpos == (311 << 8))
			break;
	}
}

inline void WaitBlt()
{
	UWORD tst = *(volatile UWORD *)&custom->dmaconr; //for compatiblity a1000
	(void)tst;
	while (*(volatile UWORD *)&custom->dmaconr & (1 << 14))
	{
	} //blitter busy wait
}

void TakeSystem()
{
	ActiView = GfxBase->ActiView; //store current view
	OwnBlitter();
	WaitBlit();
	Disable();

	//Save current interrupts and DMA settings so we can restore them upon exit.
	SystemADKCON = custom->adkconr;
	SystemInts = custom->intenar;
	SystemDMA = custom->dmaconr;
	custom->intena = 0x7fff; //disable all interrupts
	custom->intreq = 0x7fff; //Clear any interrupts that were pending

	WaitVbl();
	WaitVbl();
	custom->dmacon = 0x7fff; //Clear all DMA channels

	//set all colors black
	for (int a = 0; a < 32; a++)
		custom->color[a] = 0;

	LoadView(0);
	WaitTOF();
	WaitTOF();

	WaitVbl();
	WaitVbl();

	VBR = GetVBR();
	SystemIrq = GetInterruptHandler(); //store interrupt register
}

void FreeSystem()
{
	WaitVbl();
	WaitBlt();
	custom->intena = 0x7fff; //disable all interrupts
	custom->intreq = 0x7fff; //Clear any interrupts that were pending
	custom->dmacon = 0x7fff; //Clear all DMA channels

	//restore interrupts
	SetInterruptHandler(SystemIrq);

	/*Restore system copper list(s). */
	custom->cop1lc = (ULONG)GfxBase->copinit;
	custom->cop2lc = (ULONG)GfxBase->LOFlist;
	custom->copjmp1 = 0x7fff; //start coppper

	/*Restore all interrupts and DMA settings. */
	custom->intena = SystemInts | 0x8000;
	custom->dmacon = SystemDMA | 0x8000;
	custom->adkcon = SystemADKCON | 0x8000;

	LoadView(ActiView);
	WaitTOF();
	WaitTOF();
	WaitBlit();
	DisownBlitter();
	Enable();
}

void InitImagePlanes(BmpDescriptor *img, USHORT offs)
{
	for (int p = 0; p < img->Bpls; p++)
	{
		img->Planes[p] = ((UBYTE *)img->ImageData) + offs + (p * (img->Bpl));
	}
}

void SetPixel(BmpDescriptor bitmap, USHORT x, USHORT y, UBYTE col)
{
	USHORT xByteOffset = (x) / 8;
	UBYTE xBitOffset = 0x80 >> (x % 8);
	USHORT yByteOffset = y * bitmap.Bplt;
	for (int pl = 0; pl < bitmap.Bpls; pl++)
	{
		bitmap.Planes[pl][yByteOffset + xByteOffset] &= ~xBitOffset;
		if ((col >> pl) & (UBYTE)1)
		{
			bitmap.Planes[pl][yByteOffset + xByteOffset] |= xBitOffset;
		}
	}
}

void ClearPixel(BmpDescriptor bitmap, USHORT x, USHORT y)
{
	USHORT xByteOffset = (x) / 8;
	UBYTE xBitOffset = 0x80 >> (x % 8);
	USHORT yByteOffset = y * bitmap.Bplt;
	for (int pl = 0; pl < bitmap.Bpls; pl++)
	{
		bitmap.Planes[pl][yByteOffset + xByteOffset] &= ~xBitOffset;
	}
}

void LineDraw(BmpDescriptor bitmap, int x0, int y0, int x1, int y1, UBYTE col)
{
	int dx = Abs(x1 - x0), sx = x0 < x1 ? 1 : -1;
	int dy = -Abs(y1 - y0), sy = y0 < y1 ? 1 : -1;
	int err = dx + dy, e2; /* error value e_xy */

	while (1)
	{
		SetPixel(bitmap, x0, y0, col);
		if (x0 == x1 && y0 == y1)
			break;
		e2 = 2 * err;
		if (e2 > dy)
		{
			err += dy;
			x0 += sx;
		} /* e_xy+e_x > 0 */
		if (e2 < dx)
		{
			err += dx;
			y0 += sy;
		} /* e_xy+e_y < 0 */
	}
}

void SinusDraw(Point2D *targetlist, USHORT sinstart, USHORT x, USHORT y, int amp, int width)
{
	int idx = sinstart;
	int mod = width / (SINSIZE % width);

	for (int i = 0; i < width; i++)
	{
		idx += (SINSIZE / width);
		if (idx > 719)
			idx = 0;
		if (i % mod == 0)
			idx++;
		if (idx > 719)
			idx = 0;

		targetlist[i].X = x + i;
		targetlist[i].Y = y + (sin_05[idx] * amp / 1000);
	}
}

void PolygonDraw(BmpDescriptor bitmap, Point2D *pointlist, USHORT length, BYTE col, BOOL closed)
{
	for (int i = 0; i < length - 1; i++)
	{
		LineDraw(bitmap, pointlist[i].X, pointlist[i].Y, pointlist[i + 1].X, pointlist[i + 1].Y, col);
	}
	if (closed)
	{
		LineDraw(bitmap, pointlist[length - 1].X, pointlist[length - 1].Y, pointlist[0].X, pointlist[0].Y, col);
	}
}

void EllipseDraw(BmpDescriptor bitmap, BYTE col, int xm, int ym, int a, int b)
{
	int dx = 0, dy = b; /* im I. Quadranten von links oben nach rechts unten */
	long a2 = a * a, b2 = b * b;
	long err = b2 - (2 * b - 1) * a2, e2; /* Fehler im 1. Schritt */
	do
	{
		/* I. Quadrant */
		SetPixel(bitmap, xm + dx, ym + dy, col);
		/* II. Quadrant */
		SetPixel(bitmap, xm - dx, ym + dy, col);
		/* III. Quadrant */
		SetPixel(bitmap, xm - dx, ym - dy, col);
		/* IV. Quadrant */
		SetPixel(bitmap, xm + dx, ym - dy, col);

		e2 = 2 * err;
		if (e2 < (2 * dx + 1) * b2)
		{
			dx++;
			err += (2 * dx + 1) * b2;
		}
		if (e2 > -(2 * dy - 1) * a2)
		{
			dy--;
			err -= (2 * dy - 1) * a2;
		}
	} while (dy >= 0);

	while (dx++ < a)
	{	/* fehlerhafter Abbruch bei flachen Ellipsen (b=1) */
		//    setPixel(xm+dx, ym); /* -> Spitze der Ellipse vollenden */
		//    setPixel(xm-dx, ym);
	}
}

void MakePolys()
{
}

void CopyBitmap(BmpDescriptor bmpS, BmpDescriptor bmpD)
{
	WaitBlt();

	custom->bltcon0 = 0x09f0;
	custom->bltcon1 = 0x0000;
	custom->bltapt = (UBYTE *)bmpS.ImageData;
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
	custom->bltafwm = 0xffff;
	custom->bltalwm = 0xffff;
	custom->bltamod = 0;
	custom->bltdmod = 0;
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
}

void ClearBitmap(BmpDescriptor bmpD, USHORT lines)
{
	WaitBlt();

	custom->bltcon0 = 0x0900;
	custom->bltcon1 = 0x0000;
	custom->bltapt = (UBYTE *)bmpD.ImageData;
	custom->bltdpt = (UBYTE *)bmpD.ImageData;
	custom->bltafwm = 0xffff;
	custom->bltalwm = 0xffff;
	custom->bltamod = 0;
	custom->bltdmod = 0;
	custom->bltsize = ((lines * bmpD.Bpls) << 6) + (bmpD.Width / 16);
}

void ClearBitmapPart(BmpDescriptor bmp, int x, int y, int height, int width)
{
	WaitBlt();
	BYTE shift = x % 16;
	if (shift)
		width += 16;
	custom->bltcon0 = 0x0 | SRCA | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
	custom->bltapt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
	custom->bltdpt = (UBYTE *)bmp.ImageData + (bmp.Bplt * y) + (x / 8);
	custom->bltafwm = 0xffff;
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
	;
	custom->bltamod = bmp.Bpl - (width / 8);
	custom->bltdmod = bmp.Bpl - (width / 8);
	custom->bltsize = ((height * bmp.Bpls) << 6) + (width / 16);
}

void SimpleBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
	WaitBlt();
	custom->bltcon0 = 0x09f0;
	custom->bltcon1 = 0x0000;
	custom->bltafwm = 0xffff;
	custom->bltalwm = 0xffff;
	custom->bltamod = imgA.Bpl - (width / 8);
	custom->bltdmod = imgD.Bpl - (width / 8);
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
	custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
	custom->bltsize = ((height * imgA.Bpls) << 6) + (width / 16);
}

void BetterBlit(BmpDescriptor imgS, BmpDescriptor imgD, BmpDescriptor imgM, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
	WaitBlt();
	BYTE shift = startD.X % 16;
	if (shift)
		width += 16;

	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | (shift) << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
	custom->bltcon1 = (shift) << BSHIFTSHIFT;
	custom->bltapt = (UBYTE *)imgS.ImageData + (startA.Y * imgS.Bplt) + (startA.X / 8);
	custom->bltamod = imgS.Bpl - (width / 8);
	custom->bltbpt = (UBYTE *)imgM.ImageData + (startA.Y * imgM.Bplt) + (startA.X / 8);
	custom->bltbmod = imgM.Bpl - (width / 8);
	custom->bltcpt = custom->bltdpt = (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
	custom->bltafwm = 0xffff;
	custom->bltalwm = shift ? 0xffff >> (15 - shift) : 0xffff;
	custom->bltsize = ((height * imgS.Bpls) << HSIZEBITS) | (width / 16);
}

int p61Init(const void *module)
{ // returns 0 if success, non-zero otherwise
	register volatile const void *_a0 ASM("a0") = module;
	register volatile const void *_a1 ASM("a1") = NULL;
	register volatile const void *_a2 ASM("a2") = NULL;
	register volatile const void *_a3 ASM("a3") = P61_Player;
	register int _d0 ASM("d0"); // return value
	__asm volatile(
		"movem.l %%d1-%%d7/%%a4-%%a6,-(%%sp)\n"
		"jsr 0(%%a3)\n"
		"movem.l (%%sp)+,%%d1-%%d7/%%a4-%%a6"
		: "=r"(_d0), "+rf"(_a0), "+rf"(_a1), "+rf"(_a2), "+rf"(_a3)
		:
		: "cc", "memory");
	return _d0;
}

void p61Music()
{
	register volatile const void *_a3 ASM("a3") = P61_Player;
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
	__asm volatile(
		"movem.l %%d0-%%d7/%%a0-%%a2/%%a4-%%a5,-(%%sp)\n"
		"jsr 4(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d7/%%a0-%%a2/%%a4-%%a5"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}

void p61End()
{
	register volatile const void *_a3 ASM("a3") = P61_Player;
	register volatile const void *_a6 ASM("a6") = (void *)0xdff000;
	__asm volatile(
		"movem.l %%d0-%%d1/%%a0-%%a1,-(%%sp)\n"
		"jsr 8(%%a3)\n"
		"movem.l (%%sp)+,%%d0-%%d1/%%a0-%%a1"
		: "+rf"(_a3), "+rf"(_a6)
		:
		: "cc", "memory");
}

void BitmapInit(BmpDescriptor *bmp, USHORT w, USHORT h, USHORT bpls)
{

	bmp->Width = w;
	bmp->Height = h;
	bmp->Bpls = bpls;
	bmp->Bpl = w / 8;
	bmp->Bplt = w / 8 * bpls;
	bmp->Btot = w / 8 * h * bpls;
}

void InitStarfieldSprite()
{
	short line = 0;
	USHORT hpos = 3;
	BYTE vpos = 0x2c;

	for (int l = 0; l < 31; l++)
	{
		hpos = (7 * hpos) % 255;
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
		StarSprite[line++] = 0x8000;					  //color-1
		StarSprite[line++] = 0x0000;					  //color-1
		vpos += 2;

		hpos = (7 * hpos) % 255;
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
		StarSprite[line++] = 0x0000;					  //color-2
		StarSprite[line++] = 0x8000;					  //color-2
		vpos += 2;

		hpos = (7 * hpos) % 255;
		StarSprite[line++] = vpos << 8 | (hpos & 0x00ff); //v-pos, h-pos
		StarSprite[line++] = (vpos + 1) << 8 | 0;		  //v-stop, ctrl
		StarSprite[line++] = 0x8000;					  //color-3
		StarSprite[line++] = 0x8000;					  //color-3
		vpos += 2;
	}
	// sprite end-mark
	StarSprite[line++] = 0;
	StarSprite[line++] = 0;
}

void MoveStarfield()
{
	for (int l = 1; l < 31 * 24; l += 24)
	{
		((volatile UBYTE *)StarSprite)[l] += 1;
		((volatile UBYTE *)StarSprite)[l + 8] += 2;
		((volatile UBYTE *)StarSprite)[l + 16] += 3;
	}
}

void BuildLogo()
{
	Point2D ps;
	Point2D pd;

	if (LogoShowY1 <= 128)
	{
		ps.X = 0;
		ps.Y = LogoShowY1;
		pd.X = 32;
		pd.Y = LogoShowY1;
		SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 1, 256);
		LogoShowY1 += 2;
	}
	else if (LogoShowY2 <= 129)
	{
		ps.X = 0;
		ps.Y = LogoShowY2;
		pd.X = 32;
		pd.Y = LogoShowY2;
		SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 1, 256);
		LogoShowY2 += 2;
	}
}

void DissolveLogo()
{
	if (LogoShowY1 >= 0)
	{
		ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY1, 1, 256);
		LogoShowY1 -= 2;
	}
	else if (LogoShowY2 >= 1)
	{
		ClearBitmapPart(BmpUpperPart_PF1, 32, LogoShowY2, 1, 256);
		LogoShowY2 -= 2;
	}
}