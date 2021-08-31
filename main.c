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
	BitmapInit(&BmpUpperPart_PF2, 320, 130, 3);
	BitmapInit(&BmpScroller, 320 + 32, 166, 3);
	BitmapInit(&BmpFont32, 320, 256, 3);
	BitmapInit(&BmpCookie, 320, 256, 3);
	BitmapInit(&BmpCookieMask, 320, 256, 1);

	copPtr = AllocMem(1024, MEMF_CHIP);
	BmpScroller.ImageData = (UWORD *)AllocMem(BmpScroller.Btot, MEMF_CHIP | MEMF_CLEAR);
	BmpUpperPart_PF1.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF1.Btot, MEMF_CHIP | MEMF_CLEAR);
	BmpUpperPart_PF2.ImageData = (UWORD *)AllocMem(BmpUpperPart_PF2.Btot, MEMF_CHIP | MEMF_CLEAR);
	BmpLogo.ImageData = (UWORD *)BmpLogoP;
	BmpFont32.ImageData = (UWORD *)BmpFont32P;
	BmpCookie.ImageData = (UWORD *)BmpCookieP;
	BmpCookieMask.ImageData = (UWORD *)BmpCookieMaskP;

	InitImagePlanes(&BmpUpperPart_PF1);
	InitImagePlanes(&BmpUpperPart_PF2);
	InitImagePlanes(&BmpScroller);
	InitImagePlanes(&BmpFont32);
	InitImagePlanes(&BmpCookie);
	InitImagePlanes(&BmpCookieMask);

	TakeSystem();

	WaitVbl();
	SetupCopper(copPtr);

	custom->cop1lc = (ULONG)copPtr;
	custom->dmacon = DMAF_BLITTER; //disable blitter dma for copjmp bug
	custom->copjmp1 = 0x7fff;	   //start coppper
	custom->dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER | DMAF_BLITTER;
	// DEMO
	SetInterruptHandler((APTR)interruptHandler);
	custom->intena = INTF_SETCLR | INTF_INTEN | INTF_VERTB;
#ifdef MUSIC
	custom->intena = INTF_SETCLR | INTF_EXTER; // TheP61_Player needs INTF_EXTER
#endif
	custom->intreq = 1 << INTB_VERTB; //reset vbl req
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
	// FREE SYSTEM
	FreeSystem();
	// CLOSE SYSTEM-LIBS
	CloseLibrary((struct Library *)DOSBase);
	CloseLibrary((struct Library *)GfxBase);

	return 0;
}

void MainLoop()
{
	Point2D ps = {0, 0};
	Point2D pd = {32, 0};
	Point2D ps2 = {0, 32};
	Point2D pd2 = {32, 0};
	Point2D pd3 = {224, 0};
	Point2D pd4 = {32, 16};
	Point2D pd5 = {224, 16};
	Point2D pd6 = {32, 32};
	Point2D pd7 = {224, 32};
	Point2D pd8 = {32, 48};
	Point2D pd9 = {224, 48};

	SimpleBlit(BmpLogo, BmpUpperPart_PF1, ps, pd, 130, 256);
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd2, 32, 32);
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd3, 32, 32);
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd4, 32, 32);
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd5, 32, 32);
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd6, 32, 32);
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd7, 32, 32);
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd8, 32, 32);
	BetterBlit(BmpCookie, BmpUpperPart_PF2, ps2, pd9, 32, 32);
	while (!MouseLeft())
	{
		WaitVbl();

		if (BounceEnabled)
		{
			if (ScrollerDir > 0)
			{
				ScrollerDir = (ScrollerMax - ScrollerY) * 1000 / 12000;
				if (ScrollerDir > 6)
					ScrollerDir = 6;
				if (ScrollerDir < 1)
					ScrollerDir = 1;
			}
			else
			{
				ScrollerDir -= 1;

				if (ScrollerDir < -4)
					ScrollerDir = -4;
				if (ScrollerDir > -1)
					ScrollerDir = -1;
			}
			ScrollerY += ScrollerDir;
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
		}
		// make scroller scroll
		Scrollit(BmpScroller, (UBYTE *)BmpScroller.ImageData, 40, 32, 4);
		// make scroller bounce
		copSetPlanesInterleafed(0, copScrollerBmpP, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, ScrollerY);
	}
}

void SetupCopper(USHORT *copPtr)
{
	// set screen output size
	*copPtr++ = DIWSTRT;
	*copPtr++ = 0x2c81;
	*copPtr++ = DIWSTOP;
	*copPtr++ = 0x2cc1;
	*copPtr++ = DDFSTRT;
	*copPtr++ = 0x38; // + ((Screen.Width - BmpLogo.Width) / 4);
	*copPtr++ = DDFSTOP;
	*copPtr++ = 0xd0; // - ((Screen.Width - BmpLogo.Width) / 4);
	copPtr = copSetBplMod(0, copPtr, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl, BmpUpperPart_PF1.Bplt - BmpUpperPart_PF1.Bpl);
	*copPtr++ = BPLCON1; //scrolling
	*copPtr++ = 0;
	*copPtr++ = BPLCON2; //playfied priority
	*copPtr++ = 1 << 6;	 //0x24;  Sprites have priority over playfields

	// set logo colors
	for (int a = 0; a < 8; a++)
	{
		copPtr = copSetColor(copPtr, a, CookiePaletteRGB4[a]);
	}
	for (int a = 8; a < 16; a++)
	{
		copPtr = copSetColor(copPtr, a, LogoPaletteRGB4[a - 8]);
	}
	// set logo bitplane pointers
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF1.ImageData, BmpUpperPart_PF1.Bpls, BmpUpperPart_PF1.Bpl, 0, TRUE);
	copPtr = copSetPlanesInterleafedOddEven(0, copPtr, (UBYTE *)BmpUpperPart_PF2.ImageData, BmpUpperPart_PF2.Bpls, BmpUpperPart_PF2.Bpl, 0, FALSE);
	// enable bitplanes
	*copPtr++ = BPLCON0;
	*copPtr++ = ((BmpLogo.Bpls * 2) << 12) /*num bitplanes*/ | (1 << 10) /*dual pf*/ | (1 << 9) /*color*/;

	// wait till below logo
	copPtr = copWaitY(copPtr, 0x2c + BmpUpperPart_PF1.Height);
	//set dma-fetch start/stop to standard size
	copPtr = copSetBplMod(0, copPtr,
						  BmpScroller.Bplt - Screen.Bpl,
						  BmpScroller.Bplt - Screen.Bpl);

	// set bitplane pointers
	copScrollerBmpP = copPtr; // remember this adress to manipulate later
	copPtr = copSetPlanesInterleafed(0, copPtr, (UBYTE *)BmpScroller.ImageData, BmpScroller.Bpls, BmpScroller.Bpl, 0);
	*copPtr++ = BPLCON0;
	*copPtr++ = ((BmpLogo.Bpls) << 12) /*num bitplanes*/ | (0 << 10) /*dual pf*/ | (1 << 9) /*color*/;

	for (int a = 0; a < 8; a++)
		copPtr = copSetColor(copPtr, a, FontPaletteRGB4[a]);

	// mirror Effect?
	// set bitplane mods
	copPtr = copWaitY(copPtr, 0x2c + BmpLogo.Height + 64);
	copMirrorBmpP = copPtr;
	copPtr = copSetBplMod(0, copPtr,
						  (BmpLogo.Bplt - BmpLogo.Bpl),
						  (BmpLogo.Bplt - BmpLogo.Bpl));

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
	if (ScrollCnt >= 32)
	{
		ScrollCnt = 0;
		PlotChar(BmpFont32, (UBYTE *)BmpFont32P, BmpScroller, (UBYTE *)BmpScroller.ImageData, startY, 32, 32);
	}
}

void PlotChar(BmpDescriptor bmpFont, UBYTE *bmpFontP, BmpDescriptor bmpDest, UBYTE *bmpDestP, USHORT plotY, USHORT charW, USHORT charH)
{
	UBYTE chr = Scrolltext[ScrolltextCnt++];
	ULONG source, dest;
	ULONG row, col;

	if (chr == 'b')
	{
		if (BounceEnabled)
		{
			ScrollerY = ScrollerMax;
			ScrollerDir = -1;
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
	if (chr == 0)
	{
		ScrolltextCnt = 0;
		chr = Scrolltext[ScrolltextCnt++];
	}
	if (chr < 32 || chr > (32 + 80))
	{
		return;
	}

	chr -= 32;
	row = chr / 10;
	col = chr % 10;

	source = (row * bmpFont.Bplt * charH) + (col << 2);
	dest = (plotY * bmpDest.Bplt) + (Screen.Bpl);

	WaitBlit();

	custom->bltcon0 = 0x09f0;
	custom->bltcon1 = 0x0000;
	custom->bltafwm = 0xffff;
	custom->bltalwm = 0xffff;
	custom->bltapt = bmpFontP + source;
	custom->bltdpt = bmpDestP + dest;
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

void InitImagePlanes(BmpDescriptor *img)
{
	for (int p = 0; p < img->Bpls; p++)
	{
		img->Planes[p] = (UBYTE *)img->ImageData + (p * (img->Bpl));
	}
}

void SetPixel(BmpDescriptor bitmap, USHORT x, USHORT y, UBYTE col)
{
	USHORT xb = (x) / 8;
	UBYTE xo = 0x80 >> (x % 8);
	USHORT yb = y * bitmap.Bplt;
	for (int pl = 0; pl < bitmap.Bpls; pl++)
	{
		bitmap.Planes[pl][yb + xb] &= ~xo;
		if ((col >> pl) & (UBYTE)1)
		{
			bitmap.Planes[pl][yb + xb] |= xo;
		}
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

void Points2DRotate(Point2D *pointsA, Point2D *pointsB, USHORT length, Point2D origin, int alpha)
{
	for (int i = 0; i < length; i++)
	{
		pointsB[i] = Point2DRotate(pointsA[i], origin, alpha);
	}
}

void CopyBitmap(BmpDescriptor bmpS, BmpDescriptor bmpD)
{
	WaitBlt();

	custom->bltcon0 = 0x09f0;
	custom->bltcon1 = 0x0000;
	custom->bltapt = bmpS.ImageData;
	custom->bltdpt = bmpD.ImageData;
	custom->bltafwm = 0xffff;
	custom->bltalwm = 0xffff;
	custom->bltamod = 0;
	custom->bltdmod = 0;
	custom->bltsize = ((bmpS.Height * bmpS.Bpls) << 6) + (bmpS.Bpl / 2);
}

void ClearBitmap(BmpDescriptor bmpD)
{
	WaitBlt();

	custom->bltcon0 = 0x0900;
	custom->bltcon1 = 0x0000;
	custom->bltapt = bmpD.ImageData;
	custom->bltdpt = bmpD.ImageData;
	custom->bltafwm = 0xffff;
	custom->bltalwm = 0xffff;
	custom->bltamod = 0;
	custom->bltdmod = 0;
	custom->bltsize = ((bmpD.Height * bmpD.Bpls) << 6) + (bmpD.Bpl / 2);
}

void GetCookieMask(UBYTE planes, UBYTE **bmp, UBYTE *destMask, USHORT height, USHORT width)
{
	for (int x = 0; x < (width * height / 8); x++)
	{
		for (int p = 0; p < planes; p++)
		{
			destMask[x] |= bmp[p][x];
		}
	}
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

void BetterBlit(BmpDescriptor imgA, BmpDescriptor imgD, Point2D startA, Point2D startD, USHORT height, USHORT width)
{
	UBYTE x = 0;//startD.X % 16;

	WaitBlt();
	custom->bltcon0 = 0xca | SRCA | SRCB | SRCC | DEST | x << ASHIFTSHIFT; // A = source, B = mask, C = background, D = destination
	custom->bltcon1 = x << BSHIFTSHIFT;
	custom->bltapt = (UBYTE *)imgA.ImageData + (startA.Y * imgA.Bplt) + (startA.X / 8);
	custom->bltamod = imgA.Bpl - (width / 8);
	custom->bltbpt = (UBYTE *)BmpCookieMask.ImageData + (startA.Y * BmpCookieMask.Bpl) + (startA.X / 8);
	custom->bltbmod = BmpCookieMask.Bpl - (width / 8);
	custom->bltcpt = custom->bltdpt =  (UBYTE *)imgD.ImageData + (startD.Y * imgD.Bplt) + (startD.X / 8);
	custom->bltcmod = custom->bltdmod = imgD.Bpl - (width / 8);
	custom->bltafwm = 0xffff;
	custom->bltalwm = 0xffff;
	custom->bltsize = ((height * imgA.Bpls) << HSIZEBITS) | (width / 16);
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
