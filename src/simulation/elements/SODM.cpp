#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_SODM()
{
	Identifier = "DEFAULT_PT_SODM";
	Name = "SODM";
	Colour = 0xcaccce_rgb;
	MenuVisible = 1;
	MenuSection = SC_SOLIDS;
	Enabled = 1;


	Advection = 0.7f;
	AirDrag = 0.02f * CFDS;
	AirLoss = 0.96f;
	Loss = 0.80f;
	Collision = 0.0f;
	Gravity = 0.1f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 1;

	Flammable = 0;
	Explosive = 0;
	Meltable = 2;
	Hardness = 1;


	Weight = 28;
	HeatConduct = 100;
	Description = "Sodium, highly reactive metal. Read WIKI for all reactions.";

	Properties = TYPE_PART | PROP_LIFE_DEC |PROP_CONDUCTS;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 370.15f;
	HighTemperatureTransition = PT_LAVA;

	Update = &update;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp4 > 0)
	{
		parts[i].tmp4 = parts[i].tmp4 - 1;
	}

	if (parts[i].tmp3 == 0)
	{
		parts[i].vx = 0;
		parts[i].vy = 0;
	}

		for (auto  rx = -2; rx < 3; rx++)
			for (auto  ry = -2; ry < 3; ry++)
				if (rx || ry)
				{
					auto r = pmap[y + ry][x + rx];
					if (!r)
						continue;
					if (sim->pv[y / CELL][x / CELL] > 5.0f)
					{
						parts[i].tmp3 = 1;
					}
					if (sim->pv[y / CELL][x / CELL] < -2.0f && parts[i].tmp4 < 100)
					{
						if (sim->rng.chance(1, 10))
						{
							parts[i].tmp4 += 1;
						}
					}
					if ((TYP(r) == PT_O2 || TYP(r) == PT_CO2) && sim->rng.chance(1, 10) && parts[i].tmp < 100)
					{
						parts[i].tmp += 1;
						if (parts[i].temp < 364.15f)
						parts[i].temp += 1.0f;
					}
					if ((TYP(r) == PT_WATR || TYP(r) == PT_DSTW || TYP(r) == PT_SLTW || TYP(r) == PT_CBNW || TYP(r) == PT_WTRV))
						{
								if (sim->rng.chance(1, 100))
								{
									sim->part_change_type(ID(r), x, y, PT_H2);
									sim->kill_part(i);
								}
									parts[ID(r)].temp += 30.0f;
									sim->pv[(y / CELL) + ry][(x / CELL) + rx] += 0.07f ;
						}
						if (TYP(r) == PT_CHLR && parts[i].temp > 50 + 273.15f)
						{
							if (sim->rng.chance(1, 100))
							{
								sim->part_change_type(i, x, y, PT_SALT);
								sim->kill_part(ID(r));
							}
						}
						}
		return 0;
				}


static int graphics(GRAPHICS_FUNC_ARGS)
{

	if (cpart->tmp4 > 20)
	{
		*firer = 255;
		*fireg = 165;
		*fireb = 0;
		*firea = cpart->tmp4;
		*pixel_mode |= FIRE_ADD;
	}
	else
	{
		*colr = 255 - cpart->tmp*2;
		*colg = 255 - cpart->tmp*2;
		*colb = 255 - cpart->tmp*2;
		*pixel_mode |= PMODE_SPARK;
	}
	return 0;
}

