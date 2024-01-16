#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_CLRC()
{
	Identifier = "DEFAULT_PT_CLRC";
	Name = "CLRC";
	Colour = 0xD1D1D1_rgb;
	MenuVisible = 1;
	MenuSection = SC_LIQUID;
	Enabled = 1;

	Advection = 0.3f;
	AirDrag = 0.02f * CFDS;
	AirLoss = 0.98f;
	Loss = 0.80f;
	Collision = 0.0f;
	Gravity = 0.15f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 2;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 0;

	Weight = 99;

	DefaultProperties.temp = 22.0f + 273.15f;
	HeatConduct = 0;
	Description = "Clear protective coat, liquid that sticks to solids and becomes invisible under UV.";

	Properties = TYPE_LIQUID|PROP_LIFE_DEC;

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
	if (parts[i].life > 1)
	{
		parts[i].vx = 0;
		parts[i].vy = 0;
	}

	int rp;
	for (auto rx = -2; rx < 3; rx++)
		for (auto ry = -2; ry < 3; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				if (sim->elements[TYP(r)].Properties&TYPE_SOLID||(parts[ID(r)].type == PT_COPR && parts[ID(r)].tmp2 == 0))
				{
					parts[i].life = 5;
				}
				rp = sim->photons[y + ry][x + rx];
				if (TYP(rp) == PT_UVRD)
				{
					parts[i].tmp = 1;
				}
			}
	return 0;
}
static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp == 1)
	{
		*colr = 20;
		*colb = 20;
		*colg = 20;
	}
	return 0;
}
