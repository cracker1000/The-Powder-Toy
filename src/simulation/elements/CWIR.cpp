#include "simulation/ElementCommon.h"
#include "simulation/Air.h"

static int update(UPDATE_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_CWIR()
{
	Identifier = "DEFAULT_PT_CWIR";
	Name = "CWIR";
	Colour = PIXPACK(0xCC0000);
	MenuVisible = 1;
	MenuSection = SC_ELEC;
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
	Meltable = 1;
	Hardness = 0;
	PhotonReflectWavelengths = 0xCC0000;

	Weight = 100;

	HeatConduct = 250;
	Description = "Customisable wire, conduction speed set with .tmp, melting point with .tmp2";

	Properties = TYPE_SOLID | PROP_CONDUCTS | PROP_HOT_GLOW | PROP_LIFE_DEC;

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
	int rx, ry, r;
	//some checks for speed and melting point.
	if (parts[i].tmp < 0 || parts[i].tmp > 8)
	{
		parts[i].tmp = 8;
	}

	if (parts[i].tmp2 < 1 || parts[i].tmp2 > 9725)
	{
		parts[i].tmp2 = 2000;
	}

	if (parts[i].temp-273.15f >= parts[i].tmp2)
	{
		parts[i].ctype = parts[i].type;
		sim->part_change_type(i, x, y, PT_LAVA); //custom melting point.
	}
	int cust = parts[i].tmp;
	int checkCoordsX[] = { -cust, cust, 0, 0 };
	int checkCoordsY[] = { 0, 0, -cust, cust }; //custom conductivity.

	if (!parts[i].life)
	{
		for (int j = 0; j < 4; j++) {
			rx = checkCoordsX[j];
			ry = checkCoordsY[j];
			if (BOUNDS_CHECK) {
				r = pmap[y + ry][x + rx];
				if (!r) continue;
				if (TYP(r) == PT_SPRK && parts[ID(r)].life && parts[ID(r)].life < 4)
				{
					sim->part_change_type(i, x, y, PT_SPRK);
					parts[i].life = 4;
					parts[i].ctype = PT_CWIR;
				}
			}
		}
	}
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].tmp2 = 2000;
}
