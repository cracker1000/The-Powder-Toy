#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_PCON()
{
	Identifier = "DEFAULT_PT_PCON";
	Name = "PCON";
	Colour = 0x32CD32_rgb;
	MenuVisible = 1;
	MenuSection = SC_POWERED;
	Enabled = 1;

	Advection = 0.0f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 0.90f;
	Loss = 0.00f;
	Collision = 0.0f;
	Gravity = 0.0f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 1;

	Weight = 100;

	HeatConduct = 251;
	Description = "Powered Converter. Converts everything into whatever it first touches when powered. Set its Ctype carefully!";

	Properties = TYPE_SOLID | PROP_NOCTYPEDRAW;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = ITH;
	HighTemperatureTransition = NT;

	Update = &update;
	CtypeDraw = &Element::ctypeDrawVInCtype;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp2 != 10)
	{
		if (parts[i].tmp2 > 0)
			parts[i].tmp2--;
	}
	else
	{
		for (auto rx = -2; rx < 3; rx++)
			for (auto ry = -2; ry < 3; ry++)
				if (rx || ry)
				{
					auto r = pmap[y + ry][x + rx];
					if (!r)
						continue;
					if (TYP(r) == PT_PCON)
					{
						if (parts[ID(r)].tmp2 < 10 && parts[ID(r)].tmp2>0)
							parts[i].tmp2 = 9;
						else if (parts[ID(r)].tmp2 == 0)
							parts[ID(r)].tmp2 = 10;
					}
				}
	}

	if (parts[i].tmp2 == 0)
	{
		int ctype = TYP(parts[i].ctype);
		if (ctype <= 0 || ctype >= PT_NUM || !sim->elements[ctype].Enabled || ctype == PT_PCON)
		{
			for (auto rx = -1; rx < 2; rx++)
				for (auto ry = -1; ry < 2; ry++)
						if (rx || ry)
						{
							auto r = sim->photons[y + ry][x + rx];
						if (!r)
							r = pmap[y + ry][x + rx];
						if (!r)
							continue;
						int rt = TYP(r);
						if (rt != PT_CLNE && rt != PT_PCLN &&
							rt != PT_BCLN && rt != PT_STKM && rt != PT_PSCN && rt != PT_NSCN && rt != PT_SPRK &&
							rt != PT_PBCN && rt != PT_STKM2 &&
							rt != PT_PCON && rt < PT_NUM)
						{
							parts[i].ctype = rt;
							if (rt == PT_LIFE)
								parts[i].ctype |= PMAPID(parts[ID(r)].ctype);
						}
						}
		}
		else
		{
			int restrictElement = sim->IsElement(parts[i].tmp) ? parts[i].tmp : 0;
			for (auto rx = -1; rx < 2; rx++)
				for (auto ry = -1; ry < 2; ry++)
					if (x + rx >= 0 && y + ry >= 0 && x + rx < XRES && y + ry < YRES)
					{
						auto r = sim->photons[y + ry][x + rx];
						if (!r || (restrictElement && TYP(r) != restrictElement))
							r = pmap[y + ry][x + rx];
						if (!r || (restrictElement && TYP(r) != restrictElement))
							continue;
						if (TYP(r) != PT_PCON && TYP(r) != PT_DMND && TYP(r) != ctype)
						{
							sim->create_part(ID(r), x + rx, y + ry, TYP(parts[i].ctype), ID(parts[i].ctype));
						}
					}
		}
	}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp2 == 10)
	{
		*colr = 191;
		*colg = 10;
		*colb = 10;
	}
	return 0;
}
