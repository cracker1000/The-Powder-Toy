#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
void Element::Element_SUBS()
{
	Identifier = "DEFAULT_PT_SUBS";
	Name = "SUBS";
	Colour = PIXPACK(0x404040);
	MenuVisible = 1;
	MenuSection = SC_POWERED;
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
	Meltable = 0;
	Hardness = 1;

	Weight = 100;
	HeatConduct = 0;
	Description = "Subframe sprk";

	Properties = TYPE_SOLID | PROP_CONDUCTS| PROP_NEUTPASS;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = NT;
	HighTemperatureTransition = NT;

	Update = &update;
}

static int update(UPDATE_FUNC_ARGS)
{
		parts[i].type = PT_SPRK;
		parts[i].ctype = PT_SUBS;
		parts[i].life = 4;
	return 0;
}

