#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);

void Element::Element_ELEX()
{
	Identifier = "DEFAULT_PT_ELEX";
	Name = "ELEX";
	Colour = 0x303030_rgb;
	MenuVisible = 1;
	MenuSection = SC_SPECIAL;
	Enabled = 1;

	Advection = 0.5f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 0.6f;
	Loss = 0.60f;
	Collision = -0.1f;
	Gravity = 0.0f;
	Diffusion = 2.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 0;

	Weight = 100;
	HeatConduct = 51;
	Description = "Element X, turns into random element when above 0C.";

	Properties = TYPE_GAS;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = ITH;
	HighTemperatureTransition = NT;

	Update = &update;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp < 120)
	{
		parts[i].tmp++;
	}
	
	if (parts[i].tmp >= 115 && parts[i].temp >= 274.15f)
	{
		int elemid = (sim->rng.between(1, (1 << PMAPBITS) - 1)); //max element id.
		if (elemid != 230 && elemid != 217 && elemid < 253) // prevent from turning into BFLM, GoL, WHEL, MIST and itself [ use elements.DEFAULT_PT_WATR in game to get the id]
			sim->create_part(i, x, y, elemid);
	}
	return 0;
}