#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

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

	Flammable = 10;
	Explosive = 0;
	Meltable = 0;
	Hardness = 5;

	Weight = 84;

	HeatConduct = 45;
	Description = "Seeds, grows into trees when watered. Needs warm temp. and DUST/SAND/CLST as soil.";

	Properties = TYPE_PART;

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
	Graphics = &graphics;
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
				r = pmap[y + ry][x + rx];
				switch (TYP(r))
				{
				case PT_DUST: // Get micro nutrients from soil.
				case PT_SAND:
				case PT_CLST:
				{ 
					if (parts[i].tmp == 0)
					{
						sim->kill_part(ID(r));
						parts[i].tmp = 1;
					}
				}
				break;
				case PT_WATR: //Got the nutrients, time to drink and grow.
				case PT_SLTW:
				{
					if (parts[i].tmp == 1)
					{
						sim->kill_part(ID(r));
						parts[i].tmp = 2;
					}
				}
				break;
				}
			}
	//Actual life begins here.
	if (parts[i].tmp == 2 && parts[i].temp >= 275.15f)
	{
		parts[i].vy = -0.5;
		parts[i].vx = 0;
		parts[i].life--;
		if (parts[i].life >= 160)
		{
			sim->create_part(-1, x, y + 1, PT_WOOD);
			sim->create_part(-1, x + 1, y + 1, PT_WOOD);
		}
		else if (parts[i].life < 160 && parts[i].life >= 148)
		{
			sim->create_part(-1, x, y + 1, PT_PLNT);
			sim->create_part(-1, x+1, y+1, PT_PLNT);
		}
		else if (parts[i].life > 0 && parts[i].life < 148)
		{
			sim->create_part(-1, x - 2, y + 2, PT_VINE);
			sim->create_part(-1, x + 2, y + 2, PT_VINE);
			sim->create_part(-1, x - 6, y + 2, PT_VINE);
			sim->create_part(-1, x + 6, y + 2, PT_VINE);
			sim->create_part(-1, x - 14, y + 2, PT_VINE);
			sim->create_part(-1, x + 14, y + 2, PT_VINE);
			sim->create_part(-1, x, y + 2, PT_VINE);
		}
		//Played the role, time to say goodbye to simulation.
		if (parts[i].life == 0)
			sim->kill_part(i);
	}
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].life = RNG::Ref().between(190, 400);
	sim->parts[i].tmp2 = RNG::Ref().between(0, 4);
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp == 2 && cpart->temp >= 275.15f)// Infinity Seeds.
	{
		*colr = 255;
		*colg = 255;
		*colb = 255;
		*firer = 250;
		*fireg = 250;
		*fireb = 250;
		*firea = 100;
		*pixel_mode |= PMODE_LFLARE;
	}                            
	else if (cpart->temp < 275.15f) //Cold seeds.
	{
		*colr = 30;
		*colg = 30;
		*colb = 120;
	}
	int z = (cpart->tmp2 - 2) * 8;
	*colr += z;
	*colg += z;
	*colb += z;
	return 0;
}