#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_TIMC()
{
	Identifier = "DEFAULT_PT_TIMC";
	Name = "TIMC";
	Colour = 0x336699_rgb;
	MenuVisible = 1;
	MenuSection = SC_POWERED;
	Enabled = 1;

	Advection = 0.4f;
	AirDrag = 0.04f * CFDS;
	AirLoss = 0.94f;
	Loss = 0.95f;
	Collision = -0.1f;
	Gravity = 0.3f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 1;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 0;

	Weight = 100;
	HeatConduct = 0;
	Description = "Time crystal, converts into its ctype when sparked with PSCN.";
	DefaultProperties.ctype = PT_CHLR;
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
	Graphics = &graphics;
	Create = &create;
}

static int update(UPDATE_FUNC_ARGS)
{
	{
		if (parts[i].tmp2 > 0)
			parts[i].tmp2--;
		for (auto rx = -2; rx < 3; rx++)
			for (auto ry = -2; ry < 3; ry++)
				if (rx || ry)
				{
					auto r = pmap[y + ry][x + rx];
					if (!r || sim->parts_avg(ID(r), i, PT_INSL) == PT_INSL)
						continue;
					if (TYP(r) == PT_SPRK && parts[i].life == 0 && parts[ID(r)].life > 0 && parts[ID(r)].life < 4 && parts[ID(r)].ctype == PT_PSCN)
					{
						parts[i].tmp2 = 100;
					}
					else if (TYP(r) == PT_TIMC)
					{
						if (!parts[i].tmp2)
						{
							if (parts[ID(r)].tmp2)
							{
								parts[i].tmp2 = parts[ID(r)].tmp2;
								if ((ID(r)) > i)
									parts[i].tmp2--;
							}
						}
						else if (!parts[ID(r)].tmp2)
						{
							parts[ID(r)].tmp2 = parts[i].tmp2;
							if ((ID(r)) > i)
								parts[ID(r)].tmp2++;
						}
					}
					if (parts[i].tmp2 == 1)
					{
						sim->create_part(i, x, y, parts[i].ctype);
					}
				}
		return 0;
	}
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp2 > 1)
	{
		*firer = 95;
		*fireg = 235;
		*fireb = 95;
		*firea = 30;
		*pixel_mode |= FIRE_ADD;
	}
	*pixel_mode |= PMODE_FLARE;
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].tmp = 100;
}
