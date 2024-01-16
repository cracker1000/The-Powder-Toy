#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
void Element::Element_TURB()
{
	Identifier = "DEFAULT_PT_TURB";
	Name = "TURB";
	Colour = 0x505050_rgb;
	MenuVisible = 1;
	MenuSection = SC_FORCE;
	Enabled = 1;

	Advection = 0.0f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 0.00f;
	Loss = 0.00f;
	Collision = 0.0f;
	Gravity = 0.0f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 5;

	Weight = 100;

	HeatConduct = 40;
	Description = "Turbine, Makes sprk when under pressure (Read Wiki!). Conducts to PSCN. Breaks when pressure >= 50.";

	Properties = TYPE_SOLID | PROP_LIFE_DEC;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 2275;
	HighTemperatureTransition = PT_LAVA;

	Update = &update;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].life > 100)
	{
		parts[i].life = 100;
	}
	if (sim->pv[y / CELL][x / CELL] >= 1.0 && sim->pv[y / CELL][x / CELL] < 8.0)
	{
		if (sim->rng.chance(1, 40))
		{
			parts[i].life += 2;
		}
		parts[i].tmp = 1;
	}
	else if (sim->pv[y / CELL][x / CELL] >= 8.0 && sim->pv[y / CELL][x / CELL] < 20.0)
	{
		if (sim->rng.chance(1, 15))
		{
			parts[i].life += 8;
		}
		parts[i].tmp = 2;
	}

	else if (sim->pv[y / CELL][x / CELL] >= 20.0)
	{
		parts[i].life += 10;
		parts[i].tmp = 3;
	}

	else if (sim->pv[y / CELL][x / CELL] < 4.0)
		parts[i].tmp = 0;

	if (sim->pv[y / CELL][x / CELL] >= 50.0)
	{
		sim->part_change_type(i, x,y, PT_BRMT);
	}

	for (auto rx = -1; rx < 2; rx++)
		for (auto ry = -1; ry < 2; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				if (parts[ID(r)].type == PT_PSCN && parts[i].life > 0)
				{
					if (parts[ID(r)].life == 0)
					{
						parts[ID(r)].life = 4;
						parts[ID(r)].ctype = parts[ID(r)].type;
						sim->part_change_type(ID(r), x + rx, y + ry, PT_SPRK);
					}
				}
			}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp == 1)
	{
		*colr = 150;
		*colg = 150;
		*colb = 150;
	}
	else if (cpart->tmp == 2)
	{

		*colr = 255;
		*colg = 255;
		*colb = 255;;
	}
	else if (cpart->tmp == 3)
	{
		*colr = 255;
		*colg = 100;
		*colb = 100;
	}
	return 0;
}
