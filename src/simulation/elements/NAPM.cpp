#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
void Element::Element_NAPM()
{

	Identifier = "DEFAULT_PT_NAPM";
	Name = "NAPM";
	Colour = 0xFF7518_rgb;
	MenuVisible = 1;
	MenuSection = SC_EXPLOSIVE;
	Enabled = 1;

	Advection = 0.2f;
	AirDrag = 0.02f * CFDS;
	AirLoss = 0.77f;
	Loss = 0.60f;
	Collision = 0.0f;
	Gravity = 0.3f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 2;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 5;

	Weight = 20;
	HeatConduct = 255;
	Description = "Napalm, liquid that sticks to solids and can reach temp. around 1200C while burning. Cannot be extinguished once ignited.";

	Properties = TYPE_LIQUID | PROP_LIFE_DEC;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = ITH;
	HighTemperatureTransition = NT;

	Update = &update;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].life > 1)
	{
		parts[i].vy = 0;
		parts[i].vx = 0;
	}
	if (parts[i].temp > 374.15f)
	{
		parts[i].tmp = 1;
	}

	if (parts[i].tmp == 1)
	{
		sim->pv[(y / CELL)][(x / CELL)] = 3.0f;
		if (parts[i].temp < 1200 + 273.15f)
		{
			parts[i].temp += 30.15f;
		}
		if (sim->rng.chance(1, 35))
		{
			sim->create_part(-1, x, y-1, PT_FIRE);
		}
		if (sim->rng.chance(1, 10))
		{
			sim->create_part(-1, x, y - 1, PT_EMBR);
		}
		if (sim->rng.chance(1, 900))
		{
			sim->part_change_type(i, x, y, PT_FIRE);
		}
	}

	for (auto  rx = -2; rx < 3; rx++)
		for (auto  ry = -2; ry < 3; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					r = sim->photons[y + ry][x + rx];
				if (!r)
					continue;
				if (sim->elements[TYP(r)].Properties&TYPE_SOLID)
				{
					parts[i].life = 5;
				}
				switch (TYP(r))
				{
				case PT_FIRE:
				case PT_SMKE:
				case PT_PLSM:
				case PT_SPRK:
				{
				 parts[i].tmp = 1;
				}
				break;
				case PT_NAPM:
				{
					if (parts[ID(r)].tmp > 0)
					{
						parts[i].tmp = 1;
					}
				}
				break;
				}
			}
	return 0;
}
