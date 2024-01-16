#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_COPR()
{
	Identifier = "DEFAULT_PT_COPR";
	Name = "COPR";
	Colour = 0xB87333_rgb;
	MenuVisible = 1;
	MenuSection = SC_ELEC;
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

	Weight = 100;

	HeatConduct = 255;
	Description = "Excellent conductor. Turns into oxide when exposed to O2, losing conductivity. Shows superconductivity at low temps.";

	Properties = TYPE_PART|PROP_CONDUCTS|PROP_LIFE_DEC| PROP_HOT_GLOW;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 1085.85f + 273.15f;
	HighTemperatureTransition = PT_LAVA;

	Update = &update;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp2 == 0)
	{
		parts[i].vy = 0;
		parts[i].vx = 0;
	}
	if (parts[i].temp <= 173.15f)
	{
		if (!parts[i].life)
		{
			for (int j = 0; j < 4; j++)
			{
				static const int checkCoordsX[] = { -8, 8, 0, 0 };
				static const int checkCoordsY[] = { 0, 0, -8, 8 };
				int rx = checkCoordsX[j];
				int ry = checkCoordsY[j];
				int r = pmap[y + ry][x + rx];
				if (r && TYP(r) == PT_SPRK && parts[ID(r)].life && parts[ID(r)].life < 4)
				{
					sim->part_change_type(i, x, y, PT_SPRK);
					parts[i].life = 4;
					parts[i].ctype = PT_COPR;
				}
			}
		}
	}

	for (auto rx = -2; rx < 3; rx++)
		for (auto ry = -2; ry < 3; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				if ((sim->pv[y / CELL][x / CELL] > 4.3f) && parts[i].tmp > 30)
				{
					parts[i].tmp2 = 1;
				}
				switch (TYP(r))
				{
				case PT_O2:
				{
					if (parts[i].tmp < 100)
					{
						if (sim->rng.chance(1, 80))
						{
							sim->pv[y / CELL][x / CELL] = -1.0;
							parts[i].tmp += 1;
							sim->kill_part(ID(r));
						}
					}
				}
				break;
				case PT_SPRK:
			 {
					if (parts[ID(r)].ctype == PT_COPR && (parts[i].tmp > 20 || parts[i].temp >= 573.15f))
						sim->part_change_type(ID(r), x , y, PT_COPR);
					if (parts[ID(r)].tmp > 30)
					parts[i].tmp2 = 1;
			}
				break;
			}
			}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp > 0)
	{
		*colg += cpart->tmp;
		*colr-= cpart->tmp;
		*colb -= cpart->tmp;
	}
	if (cpart->life > 1)
	{
		if (cpart->temp <= 173.15f)
		{
			*firer = 0;
			*fireg = 0;
			*fireb = 250;
		}
		else if (cpart->temp > 173.15f)
		{
			*firer = 250;
			*fireg = 250;
			*fireb = 0;
		}
		*firea = 30;
		*pixel_mode |= FIRE_ADD;
	}
	return 0;
}
