#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_PHOS()
{
	Identifier = "DEFAULT_PT_PHOS";
	Name = "PHOS";
	Colour = 0xFFFFFF_rgb;
	MenuVisible = 1;
	MenuSection = SC_POWDERS;
	Enabled = 1;

	Advection = 0.4f;
	AirDrag = 0.04f * CFDS;
	AirLoss = 0.94f;
	Loss = 0.95f;
	Collision = -0.1f;
	Gravity = 0.3f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 1;

	Flammable = 0;
	Explosive = 1;
	Meltable = 5;
	Hardness = 1;

	Weight = 75;

	HeatConduct = 110;
	Description = "Phosphorus, slowly turns red, melts at 45C and reacts violently with O2. Glows under UV. Acts as a fertiliser for PLNT.";

	Properties = TYPE_PART;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 317.0f;
	HighTemperatureTransition = PT_LAVA;

	Update = &update;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp3 > 0)
		parts[i].tmp3--;

	if (parts[i].tmp2 == 1)
	{
		if (sim->rng.chance(1, 500))
		{
			parts[i].life = 150;
			sim->part_change_type(i, x, y, PT_FIRE);
		}
	}

	if (parts[i].tmp < 255 && (sim->rng.chance(1, 8)))
	{
		parts[i].tmp++;
	}
	for (auto rx = -2; rx < 3; rx++)
		for (auto ry = -2; ry < 3; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
				continue;
				switch (TYP(r))
				{
				case PT_O2:
				{
					sim->pv[(y / CELL) + ry][(x / CELL) + rx] += 10.0;
					sim->create_part(i, x, y, PT_FIRE);
				}
				break;
				case PT_OIL:
				{
					if(parts[i].tmp > 0)
					parts[i].tmp--;
				}
				break;
				case PT_CFLM:
				{
					sim->create_part(i, x, y, PT_CFLM);
				}
				break;
				case PT_FIRE:
				case PT_PLSM:
				{
					parts[i].tmp2 = 1;
				}
				break;
				case PT_PHOS:
				{
					if (parts[ID(r)].tmp2 > 0)
						parts[i].tmp2 = 1;
				}
				break;
				case PT_PLNT:
			    {
					if (sim->rng.chance(1, 100))
					{
						sim->part_change_type(ID(r), x + rx, y + ry, PT_VINE);
						sim->kill_part(i);
					}
				}
				break;
				}
	int rp = sim->photons[y + ry][x + rx];
	if (TYP(rp) == PT_UVRD)
	{
		parts[i].tmp3 = parts[i].tmp3+2;
	}
}
	return 0;
}
static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (*colr > 155)
	{
		*colr = 155;
	}
	if (cpart->tmp <= 100)
	{
		*pixel_mode |= PMODE_FLARE;
	}
	*colr += cpart->tmp;
	*colg -= cpart->tmp/2;
	*colb -= cpart->tmp/2;

	if (cpart->tmp3 > 0)
	{
		*firea = 55;
		*firer = *colr;
		*fireg = *colg;
		*fireb = *colb;
		*pixel_mode |= FIRE_ADD;
	}
	return 0;
}
