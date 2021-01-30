#include "simulation/ElementCommon.h"
static bool ctypeDraw(CTYPEDRAW_FUNC_ARGS);
static int update(UPDATE_FUNC_ARGS);

void Element::Element_CSNS()
{
	Identifier = "DEFAULT_PT_CSNS";
	Name = "CSNS";
	Colour = PIXPACK(0xFFFF00);
	MenuVisible = 1;
	MenuSection = SC_SENSOR;
	Enabled = 1;

	Advection = 0.0f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 0.96f;
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

	DefaultProperties.temp = 4.0f + 273.15f;
	HeatConduct = 0;
	Description = "Ctype sensor, creates a spark when there's a nearby particle with same ctype.";

	Properties = TYPE_SOLID;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = ITH;
	HighTemperatureTransition = NT;

	DefaultProperties.tmp2 = 2;

	Update = &update;
	CtypeDraw = &ctypeDraw;
}

static int update(UPDATE_FUNC_ARGS)
{
	int rd = parts[i].tmp2;
	if (rd > 25) parts[i].tmp2 = rd = 25;
	if (parts[i].life)
	{
		parts[i].life = 0;
		for (int rx = -2; rx <= 2; rx++)
			for (int ry = -2; ry <= 2; ry++)
				if (BOUNDS_CHECK && (rx || ry))
				{
					int r = pmap[y + ry][x + rx];
					if (!r)
						continue;
					int rt = TYP(r);
					if (sim->parts_avg(i, ID(r), PT_INSL) != PT_INSL)
					{
						if ((sim->elements[rt].Properties&PROP_CONDUCTS) && !(rt == PT_WATR || rt == PT_SLTW || rt == PT_NTCT || rt == PT_PTCT || rt == PT_INWR) && parts[ID(r)].life == 0)
						{
							parts[ID(r)].life = 4;
							parts[ID(r)].ctype = rt;
							sim->part_change_type(ID(r), x + rx, y + ry, PT_SPRK);
						}
					}

				}
	}
	bool doSerialization = false;
	bool doDeserialization = false;
	int tmppr = 0;

	for (int rx = -rd; rx < rd + 1; rx++)
		for (int ry = -rd; ry < rd + 1; ry++)
			if (x + rx >= 0 && y + ry >= 0 && x + rx < XRES && y + ry < YRES && (rx || ry))


			{
				int r = pmap[y + ry][x + rx];
				if (!r)
					r = sim->photons[y + ry][x + rx];
				if (!r)
					continue;

				switch (parts[i].tmp)
				{
				case 1:
					// .ctype serialization
					if (TYP(r) != PT_CSNS && TYP(r) != PT_FILT)
					{
						doSerialization = true;
						tmppr = parts[ID(r)].ctype;
					}
					break;
				case 3:
					// .ctype deserialization
					if (TYP(r) == PT_FILT)
					{
						doDeserialization = true;
						tmppr = parts[ID(r)].ctype;
					}
					break;
				case 2:
					// Invert mode
					if (TYP(r) && TYP(r) != PT_METL && parts[ID(r)].ctype != parts[i].ctype)
						parts[i].life = 1;
					else
						parts[i].life = 0;
					break;
				default:
					// Normal mode
					if (TYP(r) != PT_METL && parts[ID(r)].ctype == parts[i].ctype)
						parts[i].life = 1;
					break;
				}
			}

	for (int rx = -1; rx <= 1; rx++)
		for (int ry = -1; ry <= 1; ry++)
			if (BOUNDS_CHECK && (rx || ry))
			{

				int r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				int nx = x + rx;
				int ny = y + ry;
				// serialization.
				if (doSerialization)
				{
					while (TYP(r) == PT_FILT)
					{
						parts[ID(r)].ctype = 0x10000000 + tmppr;
						nx += rx;
						ny += ry;
						if (nx < 0 || ny < 0 || nx >= XRES || ny >= YRES)
							break;
						r = pmap[ny][nx];
					}
				}
				// deserialization.
				if (doDeserialization)
				{

					if (TYP(r) != PT_FILT)
					{
						parts[ID(r)].ctype = tmppr - 0x10000000;
						break;
					}
				}
			}

	return 0;
}

static bool ctypeDraw(CTYPEDRAW_FUNC_ARGS)
{
	if (!Element::ctypeDrawVInCtype(CTYPEDRAW_FUNC_SUBCALL_ARGS))
	{
		return false;
	}
	if (t == PT_LIGH)
	{
		sim->parts[i].ctype |= PMAPID(30);
	}
	return true;
}
