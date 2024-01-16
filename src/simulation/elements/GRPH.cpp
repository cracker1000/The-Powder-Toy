#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_GRPH()
{
	Identifier = "DEFAULT_PT_GRPH";
	Name = "GRPH";
	Colour = 0x3B3B3B_rgb;
	MenuVisible = 1;
	MenuSection = SC_SOLIDS;
	Enabled = 1;

	Advection = 0.0f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 0.90f;
	Loss = 0.00f;
	Collision = 0.0f;
	Gravity = 0.0f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 5;
	Hardness = 1;

	Weight = 100;

	HeatConduct = 255;
	DefaultProperties.tmp2 = interfaceRng.between(0, 4);
	Description = "Graphite, efficient heat and electricity conductor. Ignites when above 450C. Absorbs NEUT. GRPH + O2 -> CO2.";

	Properties = TYPE_SOLID| PROP_CONDUCTS | PROP_LIFE_DEC | PROP_HOT_GLOW | PROP_NEUTPASS;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 3950.15f;
	HighTemperatureTransition = PT_LAVA;

	Update = &update;
	Graphics = &graphics;
	Create = &create;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp3 > 100)
		parts[i].tmp3--;

	if (parts[i].tmp == 1)
	{
		if (sim->rng.chance(1, 80))
		{
			sim->create_part(-1, x, y-1, PT_FIRE);
		}
		if (sim->rng.chance(1, 500))
		{
			sim->create_part(-1, x, y - 1, PT_CO2);
		}
		if (sim->rng.chance(1, 700))
		{
			parts[i].life = 70;
			sim->part_change_type(i, x, y, PT_FIRE);
		}
	}

	if (!parts[i].life)
	{
		for (int j = 0; j < 4; j++)
		{
			static const int checkCoordsX[] = { -4, 4, 0, 0 };
			static const int checkCoordsY[] = { 0, 0, -4, 4 };
			auto  rx = checkCoordsX[j];
			auto  ry = checkCoordsY[j];
			auto  r = pmap[y + ry][x + rx];
			if (r && TYP(r) == PT_SPRK && parts[ID(r)].life && parts[ID(r)].life < 4)
			{
				sim->part_change_type(i, x, y, PT_SPRK);
				parts[i].life = 4;
				parts[i].ctype = PT_GRPH;
			}
		}
	}

	for (auto rx = -2; rx < 3; rx++)
		for (auto ry = -2; ry < 3; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					r = sim->photons[y + ry][x + rx];
				if (!r)
					continue;
		
				switch (TYP(r))
				{
				case PT_FIRE:
				case PT_SMKE:
				case PT_PLSM:
				{
					if (parts[i].temp > 693.15f)
					parts[i].tmp = 1;
				}
				break;
				case PT_GRPH:
				{
					if (parts[ID(r)].tmp > 0)
					parts[i].tmp = 1;
				}
				break;
				case PT_SPRK:
				{
						parts[i].tmp3 = 255;
				}
				break;
				case PT_PHOT:
				{
					sim->part_change_type(ID(r), x, y, PT_UVRD);
				}
				break;
				case PT_O2:
				{
					if (sim->rng.chance(1, 40))
					{
						sim->part_change_type(i, x, y, PT_CO2);
						sim->kill_part(ID(r));
					}
				}
				break;
				case PT_NEUT:
				{
					if (sim->rng.chance(1,4))
					{
						sim->kill_part(ID(r));
					}
				}
				break;
				}
			}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp2 > 4)
	{
		*colr = (int)(cpart->tmp3);
		*colg = 50;
		*colb = 50;
		*pixel_mode |= PMODE_FLARE;
	}
	else
	{
		int z = (cpart->tmp2 - 2) * 8;
		*colr += z;
		*colg += z;
		*colb += z;
	}
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].tmp2 = interfaceRng.between(0, 5);
	sim->parts[i].tmp3 = 100;
}
