#include "simulation/ElementCommon.h"
int Element_BFLM_update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_BFLM()
{
	Identifier = "DEFAULT_PT_BFLM";
	Name = "BFLM";
	Colour = 0x202020_rgb;
	MenuVisible = 1;
	MenuSection = SC_EXPLOSIVE;
	Enabled = 1;

	Advection = 0.9f;
	AirDrag = 0.04f * CFDS;
	AirLoss = 0.97f;
	Loss = 0.20f;
	Collision = 0.0f;
	Gravity = -0.1f;
	Diffusion = 0.00f;
	HotAir = 0.001f  * CFDS;
	Falldown = 1;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 1;

	Weight = 2;

	DefaultProperties.temp = R_TEMP + 400.0f + 273.15f;
	HeatConduct = 88;
	Description = "Black Flames, unstoppable flames that eat everything in its way (except DMRN & WALL).";

	Properties = TYPE_GAS | PROP_LIFE_DEC | PROP_LIFE_KILL;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = ITH;
	HighTemperatureTransition = NT;

	Update = &Element_BFLM_update;
	Graphics = &graphics;
	Create = &create;
}

int Element_BFLM_update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp > 0)
	{
	parts[i].tmp--;
    }
	for (auto rx = -2; rx < 2; rx++)
		for (auto ry = -2; ry < 2; ry++)
		{
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					r = sim->photons[y + ry][x + rx];
				if (!r)
					continue;
				if (TYP(r) && TYP(r) != PT_BFLM && TYP(r) != PT_DMRN && TYP(r) != PT_WALL)
				{
					parts[i].tmp = 5;
					if (sim->rng.chance(1, 13))
					{
						parts[ID(r)].life = 55;
						sim->part_change_type(ID(r), x + rx, y + ry, PT_BFLM);
					}
				}
			}
		}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp > 0)
	{
		*colr = 120;
		*firer = 140;
	}
	else {
		*colr = 10;
		*firer = 10;
	}
	*firea = 200;
	*fireb = 10;
	*fireg = 10;
	*colg = 10;
	*colb = 10;
	*pixel_mode |= FIRE_BLEND;
	*pixel_mode |= FIRE_ADD;
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].life = sim->rng.between(80, 120);
}
