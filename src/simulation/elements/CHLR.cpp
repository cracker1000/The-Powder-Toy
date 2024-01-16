#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_CHLR()
{
	Identifier = "DEFAULT_PT_CHLR";
	Name = "Cl";
	Colour = 0x8bc34a_rgb;
	MenuVisible = 1;
	MenuSection = SC_GAS;
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

	Weight = 27;

	DefaultProperties.temp = R_TEMP+273.15f;
	HeatConduct = 42;
	Description = "Chlorine, photochemical rxn with H2. WATR-> DSTW below 50C (ACID > 50C), rusts IRON/BMTL. Decays organic matter.";

	Properties = TYPE_GAS | PROP_NEUTPASS;

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

	if (parts[i].temp < 273.15f)
	{
		parts[i].vy = 0.1f;
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
					case PT_WATR:
					case PT_SLTW:
					case PT_CBNW:
					case PT_DSTW:
					case PT_WTRV:
					{
						if (parts[i].temp > 323.15f)
						{
							if (sim->rng.chance(1, 400))
							{
								sim->pv[(y / CELL)][(x / CELL)] = 6.0f;
								sim->kill_part(ID(r));
								parts[i].life = 200;
								sim->part_change_type(i, x + rx, y + ry, PT_ACID);
							}
						}

						else if (parts[i].temp < 323.15f)
						{
							sim->part_change_type(ID(r), x + rx, y + ry, PT_DSTW);
							if (sim->rng.chance(1, 300))
							{
								sim->kill_part(i);
							}
						}
					}
					break;
					//Photochemical reaction
					case PT_H2:
					{
						parts[i].tmp = 50;
						if (sim->rng.chance(1, 400))
					{
						sim->kill_part(ID(r));
						sim->create_part(i, x + rx, y + ry, PT_ACID);
					}
					}
					break;

					case PT_ACTY:
					{
						parts[i].temp += 1.0f;
						if (sim->rng.chance(1, 700))
						{
							sim->kill_part(ID(r));
							sim->create_part(i, x + rx, y + ry, PT_LRBD);
						}
					}
					break;

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
					case PT_IRON:
					case PT_BMTL:
					{

						if (sim->rng.chance(1, 1000))
						{
							sim->part_change_type(ID(r), x + rx, y + ry, PT_BRMT);
							sim->kill_part(i);
						}
					}
					break;
					case PT_PLNT:
					case PT_VINE:
					case PT_WOOD:
					case PT_YEST:
					case PT_SEED:
					{
						if (sim->rng.chance(1, 200))
						{
							sim->kill_part(ID(r));
							sim->kill_part(i);
						}
					}
					break;
					}
				}
				
			}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp == 0)
	{
		*firer = 139;
		*fireg = 295;
		*fireb = 74;
		*firea = 15;
	}
	else
	{
		*firer = 205;
		*fireg = 205;
		*fireb = 255;
		*firea = cpart->tmp*3;
	}
	*pixel_mode = FIRE_BLEND;
	return 0;
}
