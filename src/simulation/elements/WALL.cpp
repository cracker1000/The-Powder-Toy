#include "simulation/ElementCommon.h"
#include "simulation/Air.h"
static int update(UPDATE_FUNC_ARGS);

void Element::Element_WALL()
{
	Identifier = "DEFAULT_PT_WALL";
	Name = "WALL";
	Colour = 0x808080_rgb;
	MenuVisible = 1;
	MenuSection = SC_SPECIAL;
	Enabled = 1;

	Advection = 0.0f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 0.00f;
	Loss = 0.00f;
	Collision = 0.0f;
	Gravity = 0.0f;
	Diffusion = 0.0f;
	HotAir = 0.000f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 0;

	Weight = 102;

	DefaultProperties.temp = 293.15f;
	HeatConduct = 0;
	Description = "Elemental wall (1x1), indestructible, immune to VIRS. Blocks pressure like TTAN.";

	Properties = TYPE_SOLID;

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
	sim->air->bmap_blockair[y / CELL][x / CELL] = 1; //Block pressure.
	sim->air->bmap_blockairh[y / CELL][x / CELL] = 0x8;
	return 0;
}

