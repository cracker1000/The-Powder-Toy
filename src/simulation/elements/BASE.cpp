#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
void Element::Element_BASE()
{

	Identifier = "DEFAULT_PT_BASE";
	Name = "BASE";
	Colour = 0x5C5CFF_rgb;
	MenuVisible = 1;
	MenuSection = SC_LIQUID;
	Enabled = 1;

	Advection = 0.6f;
	AirDrag = 0.01f * CFDS;
	AirLoss = 0.98f;
	Loss = 0.95f;
	Collision = 0.0f;
	Gravity = 0.1f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 2;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 0;
	PhotonReflectWavelengths = 0x5C5CFF;
	HeatConduct = 44;
	Weight = 34;
	Description = "Base, neutralisation rxn with acid. Dissolves certain metals, releases CO2 with COAL, GRPH, etc. Dilutes with acid/ watr.";

	Properties = TYPE_LIQUID;
	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 403.15f;
	HighTemperatureTransition = PT_WTRV;

	DefaultProperties.tmp = 10;
	Update = &update;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp < 10)
		parts[i].tmp = 10;
	int trade;
	for (auto rx = -2; rx < 3; rx++)
		for (auto ry = -2; ry < 3; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				switch (TYP(r))
				{
				case PT_ACID:
				{
					if (parts[i].tmp < 150)
					{
						if (sim->rng.chance(1, parts[i].tmp*4))
						{
							parts[i].tmp += 20;
							sim->pv[(y / CELL) + ry][(x / CELL) + rx] = 0.3f;
							sim->kill_part(ID(r));
						}
						parts[i].temp = parts[i].temp + 1.15f;
						if (sim->rng.chance(1, parts[i].tmp * 8))
						{
							sim->part_change_type(i, x, y, PT_SALT);
						}
					}
				}
				break;
				case PT_BMTL:
				case PT_METL:
				case PT_GOLD:
				case PT_BRMT:
				case PT_MERC:
				case PT_IRON:
				case PT_BREC:
				{
					if (parts[i].tmp < 130)
					{
						if (sim->rng.chance(1, parts[i].tmp * 3))
						{
							parts[i].tmp += 40;
							sim->kill_part(ID(r));
						}
							parts[i].temp = parts[i].temp + 1.15f;
						}
				}
				break;
				case PT_WATR:
				case PT_DSTW:
				case PT_SLTW:
				{
					if (parts[i].tmp < 200)
					{
						if (sim->rng.chance(1, 100))
						{
							parts[i].tmp += 45;
						}
						if (sim->rng.chance(1, 250))
						{
							sim->part_change_type(ID(r), x, y, PT_BASE);

						}
					}
				}
				break;
				case PT_GRPH:
				case PT_COAL:
				case PT_BCOL:
				{
					if (parts[i].tmp < 200)
					{
						if (sim->rng.chance(1, 100))
						{
							parts[i].tmp += 55;
						}
						if (sim->rng.chance(1, 250))
						{
							sim->part_change_type(ID(r), x+rx, y+ry, PT_CO2);
						}
					}
				}
				break;
				}
			}
	for (trade = 0; trade < 2; trade++)
	{
		auto rx = sim->rng.between(-2, 2);
		auto ry = sim->rng.between(-2, 2);
		if (rx || ry)
		{
			auto r = pmap[y + ry][x + rx];
			if (!r)
				continue;
			if (TYP(r) == PT_BASE && (parts[i].tmp > parts[ID(r)].tmp) && parts[i].tmp > 0)//diffusion
			{
				int temp = parts[i].tmp - parts[ID(r)].tmp;
				if (temp == 1)
				{
					parts[ID(r)].tmp++;
					parts[i].tmp--;
				}
				else if (temp > 0)
				{
					parts[ID(r)].tmp += temp / 2;
					parts[i].tmp -= temp / 2;
				}
			}
		}
	}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS) //Flare when activated.
{
	*colr = 92;
	*colg = 92;
	*colb = 255-cpart->tmp*2;
	return 0;
}
