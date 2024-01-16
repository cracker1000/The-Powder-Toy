#include "simulation/ElementCommon.h"
#include "simulation/Air.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_RUBR()
{
	Identifier = "DEFAULT_PT_RUBR";
	Name = "RUBR";
	Colour = 0x5A5A5A_rgb;
	MenuVisible = 1;
	MenuSection = SC_LIQUID;
	Enabled = 1;

	Advection = 0.3f;
	AirDrag = 0.02f * CFDS;
	AirLoss = 0.98f;
	Loss = 0.80f;
	Collision = 0.0f;
	Gravity = 0.15f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 2;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 2;

	Weight = 100;

	HeatConduct = 10;
	Description = "Rubber (latex form). Bounces off particles, can be set into shape when above 230C. Blocks heat and pressure. Read wiki.";

	Properties = TYPE_LIQUID;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = ITH;
	HighTemperatureTransition = NT;

	Update = &update;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp2 == 1)
	{
		if (sim->rng.chance(1, 50))
		{
			sim->create_part(-1, x, y - 1, PT_FIRE);
		}
		if (sim->rng.chance(1, 300))
		{
			sim->create_part(-1, x, y - 1, PT_CO2);
		}
		if (sim->rng.chance(1, 500))
		{
			parts[i].life = 70;
			sim->part_change_type(i, x, y, PT_FIRE);
		}
	}

	if (parts[i].tmp != 0)
	{
		parts[i].vx = 0;
	    parts[i].vy = 0;
		sim->air->bmap_blockair[y / CELL][x / CELL] = 1; //Block pressure.
		sim->air->bmap_blockairh[y / CELL][x / CELL] = 0x8;
	}
	if (parts[i].temp > 230 + 273.15f && sim->rng.chance(1, 100))
	{
		parts[i].tmp = 1;
	}

	for (auto rx = -1; rx < 2; rx++)
		for (auto ry = -1; ry < 2; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				{
					if (parts[ID(r)].type != PT_RUBR && parts[i].tmp == 1 && !(sim->elements[TYP(r)].Properties&TYPE_SOLID) && !(sim->elements[TYP(r)].Properties&TYPE_ENERGY))//Bouncy behaviour.
					{
						parts[ID(r)].vx = -1.3*(parts[ID(r)].vx);
						parts[ID(r)].vy = -1.3*(parts[ID(r)].vy);
					}
					if (parts[i].temp >= 800.15f || parts[ID(r)].type == PT_FIRE || parts[ID(r)].type == PT_PLSM || parts[ID(r)].type == PT_SMKE)//Burning code
					{
						parts[i].tmp2 = 1;
					}
					if (parts[ID(r)].type == PT_RUBR && parts[ID(r)].tmp2 == 1)
					{
						parts[i].tmp2 = 1;
					}
					if (parts[ID(r)].type == PT_GAS || parts[ID(r)].type == PT_OIL) //GAS and OIL dissolves RUBR.
					{
						if (sim->rng.chance(1, 150))
						{
							sim->kill_part(i);
						}
					}
				}
			}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp == 1)
	{
		*colr = 105;
		*colg = 105;
		*colb = 105;
	}
	else
	{
		*colr = 255;
		*colg = 217;
		*colb = 209;
	}
	return 0;
}