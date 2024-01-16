#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_RADN()
{
	Identifier = "DEFAULT_PT_RADN";
	Name = "RADN";
	Colour = 0x0c1875_rgb;
	MenuVisible = 1;
	MenuSection = SC_NUCLEAR;
	Enabled = 1;

	Advection = 1.0f;
	AirDrag = 0.01f * CFDS;
	AirLoss = 0.99f;
	Loss = 0.30f;
	Collision = -0.1f;
	Gravity = 0.2f;
	Diffusion = 0.40f;
	HotAir = 0.001f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 0;

	Weight = 38;

	DefaultProperties.temp = R_TEMP + 273.15f;
	HeatConduct = 52;
	Description = "Radon, a heavy radioactive conductive gas with short half-life. Gets ionised in presence of UV.";

	Properties = TYPE_GAS | PROP_NEUTPASS | PROP_CONDUCTS | PROP_LIFE_DEC;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = NT;
	HighTemperatureTransition = NT;

	Update = &update;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp == 0)
	{
		if (sim->rng.chance(1, 300))
		{
			sim->create_part(-1, x, y, PT_NEUT);
		}
		if (sim->rng.chance(1, 300))
		{
			parts[i].tmp = 1;
		}
	}

	if (parts[i].tmp2 > 0)
	{
		parts[i].tmp2--;
		if (parts[i].tmp2 < 500)
		{
			if (sim->rng.chance(1, 100))
			{
				sim->create_part(i, x, y, PT_PHOT);
			}
			if (sim->rng.chance(1, 190))
			{
				sim->create_part(i, x, y, PT_EMBR);
			}
			if (sim->rng.chance(1, 120))
			{
				sim->create_part(i, x, y, PT_GRVT);
			}
			if (sim->rng.chance(1, 90))
			{
				sim->create_part(i, x, y, PT_PROT);
			}
			if (sim->rng.chance(1, 290))
			{
				sim->create_part(i, x, y, PT_BVBR);
			}
			if (sim->rng.chance(1, 140))
			{
				sim->create_part(i, x, y, PT_NEUT);
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
				{
					switch (TYP(r))
					{
					case PT_STKM:
					case PT_STKM2:
					case PT_FIGH:
					{
						if (sim->rng.chance(1, 70))
						{
							sim->kill_part(ID(r));
						}
					}
					break;
					}
				}

	int rp = sim->photons[y + ry][x + rx];
	if (TYP(rp) == PT_UVRD)
	{
		parts[i].tmp2 = 700;
		sim->kill_part(ID(rp));
	}
			}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp2 > 0)
	{
		*firer = 200;
		*fireg = 100;
		*fireb = 100;
		*firea = 80;
	}
	else
	{
		*firer = 12;
		*fireg = 24;
		*fireb = 117;
		*firea = 30;
	}
	*pixel_mode = FIRE_BLEND;
	return 0;
}
