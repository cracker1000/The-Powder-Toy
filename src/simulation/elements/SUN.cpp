#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_SUN()
{
	Identifier = "DEFAULT_PT_SUN";
	Name = "SUN";
	Colour = 0xFF4500_rgb;
	MenuVisible = 1;
	MenuSection = SC_SPECIAL;
	Enabled = 1;

	Advection = 0.0f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 0.95f;
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

	DefaultProperties.temp = 6300.15f;
	HeatConduct = 0;
	Description = "SUN, extremely hot, emits harmful UV radiation. Makes PLNT grow in direction of sunlight.";

	Properties = TYPE_SOLID;

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
	if (parts[i].tmp > 0)
		parts[i].tmp--;

	if (sim->rng.chance(1, 200))
	{
		parts[i].tmp = 100;
	}


	if (sim->rng.chance(1, 300))
	{
		sim->pv[(y / CELL)][(x / CELL)] = +2.0f;
		int t = sim->create_part(-1, x, y + 1, PT_PLSM);
		int s = sim->create_part(-1, x, y - 1, PT_PLSM);
		parts[s].temp = 24 + 273.15f;
		parts[s].life = 200;
		parts[t].temp = 24 + 273.15f;
		parts[t].life = 200;
	}

	for (auto rx = -1; rx < 2; rx++)
		for (auto ry = -1; ry < 2; ry++)
			if (rx || ry)
			{
				if (sim->rng.chance(1, 90))
				{
					auto r = sim->create_part(-1, x + rx, y + ry, PT_UVRD);
					if (r != -1)
					{
						parts[r].vx = (float)(rx * 3);
						parts[r].vy = (float)(ry * 3);
						if (r > i)
						{
							// Make sure movement doesn't happen until next frame, to avoid gaps in the beams of photons produced
							parts[r].flags |= FLAG_SKIPMOVE;
						}
					}
				}
			}

	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp <= 50)
	{
		*firer = 190;
		*fireg = 90;
		*fireb = 0;
	}
	else if (cpart->tmp > 50)
	{
		*firer = 0;
		*fireg = 0;
		*fireb = 200;
	}
	*firea = 60;
	*pixel_mode |= FIRE_ADD;
	return 0;
}
