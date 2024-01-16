#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);

void Element::Element_TMPS()
{
	Identifier = "DEFAULT_PT_TMPS";
	Name = "TMPS";
	Colour = 0x247BFE_rgb;
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
	Description = "Tmp sensor. Use .tmp3 for detecting different tmp values. Read wiki for more information.";

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
}

static int update(UPDATE_FUNC_ARGS)
{
	int rd = parts[i].tmp2;
	if (rd > 25) parts[i].tmp2 = rd = 25;
	if (parts[i].life)
	{
		parts[i].life = 0;
		for (auto rx = -2; rx <= 2; rx++)
			for (auto ry = -2; ry <= 2; ry++)
				if (rx || ry)
				{
					auto r = pmap[y + ry][x + rx];
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
	int tmpp = 0;
//.tmp3 modes: .tmp3 = 0 or 1 (tmp), 2 = .tmp2, 3 = .tmp3 and so on. Currently supported upto .tmp4
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
					// .tmp serialization into FILT
					if (TYP(r) != PT_TMPS && TYP(r) != PT_FILT)
					{
						doSerialization = true;
						if (parts[i].tmp3 == 0 || parts[i].tmp3 == 1)
						{
							tmpp = parts[ID(r)].tmp;
						}
						else if (parts[i].tmp3 == 2)
						{
							tmpp = parts[ID(r)].tmp2;
						}
						else if (parts[i].tmp3 == 3)
						{
							tmpp = parts[ID(r)].tmp3;
						}
						else if (parts[i].tmp3 == 4)
						{
							tmpp = parts[ID(r)].tmp4;
						}
					}
					break;
				case 3:
					// .tmp deserialization
					if (TYP(r) == PT_FILT)
					{
						doDeserialization = true;
						tmpp = parts[ID(r)].ctype;
					}
					break;
				case 2:
					// Invert mode
					if (parts[i].tmp3 == 0 || parts[i].tmp3 == 1)
					{
						if (TYP(r) != PT_METL && parts[ID(r)].tmp <= parts[i].temp - 273.15)
							parts[i].life = 1;
					}
					else if (parts[i].tmp3 == 2)
					{
						if (TYP(r) != PT_METL && parts[ID(r)].tmp2 <= parts[i].temp - 273.15)
							parts[i].life = 1;
					}
					else if (parts[i].tmp3 == 3)
					{
						if (TYP(r) != PT_METL && parts[ID(r)].tmp3 <= parts[i].temp - 273.15)
							parts[i].life = 1;
					}
					else if (parts[i].tmp3 == 4)
					{
						if (TYP(r) != PT_METL && parts[ID(r)].tmp4 <= parts[i].temp - 273.15)
							parts[i].life = 1;
					}
					break;
				default:
					// Normal mode
					if (parts[i].tmp3 == 0 || parts[i].tmp3 == 1)
					{
						if (TYP(r) != PT_METL && parts[ID(r)].tmp > parts[i].temp - 273.15)
							parts[i].life = 1;
					}
					else if (parts[i].tmp3 == 2)
					{
						if (TYP(r) != PT_METL && parts[ID(r)].tmp2 > parts[i].temp - 273.15)
							parts[i].life = 1;
					}
					else if (parts[i].tmp3 == 3)
					{
						if (TYP(r) != PT_METL && parts[ID(r)].tmp3 > parts[i].temp - 273.15)
							parts[i].life = 1;
					}
					else if (parts[i].tmp3 == 4)
					{
						if (TYP(r) != PT_METL && parts[ID(r)].tmp4 > parts[i].temp - 273.15)
							parts[i].life = 1;
					}
					break;
				}
			}

	for (auto rx = -1; rx <= 1; rx++)
		for (auto ry = -1; ry <= 1; ry++)
			if (rx || ry)
			{

				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				int nx = x + rx;
				int ny = y + ry;
				// serialization.
				if (doSerialization)
				{
					while (TYP(r) == PT_FILT)
					{
						parts[ID(r)].ctype = 0x10000000 + tmpp;
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
						if (parts[i].tmp3 == 0 || parts[i].tmp3 == 1)
						{
							parts[ID(r)].tmp = tmpp - 0x10000000;
						}
						else if (parts[i].tmp3 == 2)
						{
							parts[ID(r)].tmp2 = tmpp - 0x10000000;
						}
						else if (parts[i].tmp3 == 3)
						{
							parts[ID(r)].tmp3 = tmpp - 0x10000000;
						}
						else if (parts[i].tmp3 == 4)
						{
							parts[ID(r)].tmp4 = tmpp - 0x10000000;
						}
						break;
						
					}
				}
			}

	return 0;
}
