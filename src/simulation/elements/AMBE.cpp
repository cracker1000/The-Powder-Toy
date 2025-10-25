#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
void Element::Element_AMBE()
{
	Identifier = "DEFAULT_PT_AMBE";
	Name = "AMBE";
	Colour = 0x420075_rgb;
	MenuVisible = 1;
	MenuSection = SC_POWERED;
	Enabled = 1;

	Advection = 0.0f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 0.00f;
	Loss = 0.00f;
	Collision = 0.0f;
	Gravity = 0.0f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 5;

	Weight = 100;

	HeatConduct = 0;
	Description = "Element that sets the nearby ambient air temperature to its own temperature. tmp = effective area. Use with PSCN & NSCN.";

	Properties = TYPE_SOLID;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = ITH;
	HighTemperatureTransition = NT;
	DefaultProperties.tmp = 4;
	Update = &update;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp < 1 || parts[i].tmp > 25)
		parts[i].tmp = 25;
	int ar = parts[i].tmp;
	if (parts[i].life != 10)
	{
		if (parts[i].life > 0)
			parts[i].life--;
	}
	else
	{
		for (auto rx = -ar; rx <= ar; rx++)
			for (auto ry = -ar; ry <= ar; ry++)
			{
				if (x + rx >= 0 && y + ry >= 0 && x + rx < XRES && y + ry < YRES && (rx || ry))
				{
					sim->hv[(y / CELL) + ry][(x / CELL) + rx] = parts[i].temp;
				}
			}

		for (auto rx = -2; rx <= 2; rx++)
			for (auto ry = -2; ry <= 2; ry++)
				if (rx || ry)
				{
					auto r = pmap[y + ry][x + rx];
					if (!r)
						continue;
					if (TYP(r) == PT_AMBE)
					{
						if (parts[ID(r)].life < 10 && parts[ID(r)].life > 0)
							parts[i].life = 9;
						else if (parts[ID(r)].life == 0)
							parts[ID(r)].life = 10;
					}
				}
	}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->life == 10)
	{
		*colr = 143;
		*colg = 0;
		*colb = 255;
	}
	return 0;
}
