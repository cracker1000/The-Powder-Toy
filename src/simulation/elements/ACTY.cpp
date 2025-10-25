#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_ACTY()
{
	Identifier = "DEFAULT_PT_ACTY";
	Name = "ACTY";
	Colour = 0xADD8E6_rgb;
	MenuVisible = 1;
	MenuSection = SC_GAS;
	Enabled = 1;

	Advection = 1.0f;
	AirDrag = 0.01f * CFDS;
	AirLoss = 0.99f;
	Loss = 0.30f;
	Collision = -0.1f;
	Gravity = -0.5f;
	Diffusion = 0.40f;
	HotAir = 0.001f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 0;

	Weight = 30;

	DefaultProperties.temp = R_TEMP + 273.15f;
	DefaultProperties.tmp2 = 40;
	HeatConduct = 255;
	Description = "Acetylene gas, clean gas that reaches temp. of 1100C when ignited and around 3500C with O2. Makes LRBD with Chlorine.";

	Properties = TYPE_GAS;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 3800 + 273.15f;
	HighTemperatureTransition = PT_PLSM;

	Update = &update;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp > 0)
	{
		parts[i].temp = 3500 + 273.15f;
		parts[i].tmp2--;
	}

	if (parts[i].tmp2 <= 0)
	{
		sim->kill_part(i);
	}
	
	for (auto rx = -2; rx < 3; rx++)
		for (auto ry = -2; ry < 3; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				{
					if (TYP(r) && TYP(r) != PT_ACTY && TYP(r) != PT_FIRE && TYP(r) != PT_PLSM && TYP(r) != PT_O2 && parts[i].tmp == 1)
					{
					  sim->part_change_type(i, x, y, PT_FIRE);
					}
					switch (TYP(r))
					{
					case PT_O2:
					{
						parts[i].tmp = 1;
						sim->kill_part(ID(r));
					}
					break;
					case PT_ACTY:
					{
						if (parts[ID(r)].tmp > 0)
						parts[i].tmp = 1;
					}
					break;

					case PT_SPRK:
					case PT_SMKE:
					case PT_FIRE:
					case PT_PLSM:
					{
						if (parts[i].tmp != 1)
						{
							parts[i].life = 35;
							parts[i].temp = 1800 + 273.15f;
							sim->part_change_type(i, x + rx, y + ry, PT_FIRE);
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
	if (cpart->tmp > 0)
	{
		*firer = 75;
		*fireg = 75;
		*fireb = 195;
		*firea = cpart->tmp2;
	}
	else
	{
		*firer = 173;
		*fireg = 216;
		*fireb = 220;
		*firea = 8;
	}
	*pixel_mode = FIRE_BLEND;
	return 0;
}
