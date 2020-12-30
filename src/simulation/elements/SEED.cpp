#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_SEED()
{
	Identifier = "DEFAULT_PT_SEED";
	Name = "SEED";
	Colour = PIXPACK(0x724e3a);
	MenuVisible = 1;
	MenuSection = SC_POWDERS;
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

	Flammable = 1;
	Explosive = 0;
	Meltable = 0;
	Hardness = 5;

	Weight = 84;

	HeatConduct = 35;
	Description = "Seeds, grows into trees when watered. Needs DUST or SAND as soil.";

	Properties = TYPE_PART | PROP_LIFE_DEC;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = ITH;
	HighTemperatureTransition = NT;

	Update = &update;
	Create = &create;
}

static int update(UPDATE_FUNC_ARGS)
{
	for (int rx = -2; rx < 3; rx++)
		for (int ry = -2; ry < 3; ry++)
			if (BOUNDS_CHECK && (rx || ry))
			{
				int r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				switch (TYP(r))
				{
				case PT_SAND:
				case PT_DUST:
				{
					parts[i].pavg[0] = 1;
				}
				break;
				case PT_WATR:
				case PT_SLTW:
				{
					if (parts[i].pavg[0] == 1)
					{
						parts[i].pavg[1] = 1;
						parts[i].life = 250 - parts[i].tmp2;
						parts[i].tmp = 1;
					}
				}
				break;
				}
			}

	if (parts[i].life > 110 && parts[i].pavg[0] > 0 && parts[i].pavg[1] > 0)
	{
		parts[i].vy = -1;
		parts[i].vx = 0;
		sim->create_part(-1, x, y + 1, PT_WOOD);
		sim->create_part(-1, x+1, y + 1, PT_WOOD);
	}

	if (parts[i].life >= 100 && parts[i].life < 110 && parts[i].pavg[0] > 0 && parts[i].pavg[1] > 0)
	{
		parts[i].vy = -1;
		parts[i].vx = 0;
		sim->create_part(-1, x, y + 1, PT_PLNT);
		sim->create_part(-1, x + 1, y + 1, PT_PLNT);
	}

	if (parts[i].life > 0 && parts[i].life < 100 && parts[i].pavg[0] > 0 && parts[i].pavg[1] > 0)
	{
		parts[i].vy = -1;
		parts[i].vx = 0;
		sim->create_part(-1, x - 1, y + 1, PT_VINE);
		sim->create_part(-1, x + 1, y + 1, PT_VINE);
		sim->create_part(-1, x - 2, y + 1, PT_VINE);
		sim->create_part(-1, x + 2, y + 1, PT_VINE);
		sim->create_part(-1, x , y + 1, PT_VINE);
	}

	if (parts[i].tmp == 1 && parts[i].life == 0)
		sim->part_change_type(i, x, y, PT_NONE);

	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].tmp2 = RNG::Ref().between(50, 110);
}
