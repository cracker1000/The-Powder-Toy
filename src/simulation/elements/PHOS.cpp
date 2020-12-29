#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_PHOS()
{
	Identifier = "DEFAULT_PT_PHOS";
	Name = "PHOS";
	Colour = PIXPACK(0xFFFFFF);
	MenuVisible = 1;
	MenuSection = SC_POWDERS;
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
	Explosive = 1;
	Meltable = 5;
	Hardness = 1;

	Weight = 75;

	HeatConduct = 110;
	Description = "Phosphorus, slowly turns red, melts at 45C and reacts violently with O2.";

	Properties = TYPE_PART;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 317.0f;
	HighTemperatureTransition = PT_LAVA;

	Update = &update;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp < 250 && (RNG::Ref().chance(1, 5)))
	{
		parts[i].tmp++;
	}
	int r, rx, ry;
	for (rx = -1; rx < 1; rx++)
		for (ry = -1; ry < 1; ry++)
			if (BOUNDS_CHECK && (rx || ry))
			{
				r = pmap[y + ry][x + rx];
				switch (TYP(r))
				{
				case PT_O2:
				{
					sim->pv[(y / CELL) + ry][(x / CELL) + rx] += 10.0;
					sim->create_part(i, x, y, PT_FIRE);
				}
				break;
				case PT_OIL:
				{
					if(parts[i].tmp > 0)
					parts[i].tmp--;
				}
				break;
				case PT_CFLM:
				{
					sim->create_part(i, x, y, PT_CFLM);
				}
				break;
				case PT_FIRE:
				case PT_PLSM:
				{
					sim->create_part(i, x, y, PT_FIRE);
				}
				break;
				}
			}
	return 0;
}
static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (*colr > 155)
	{
		*colr = 155;
	}
	if (cpart->tmp <= 100)
	{
		*pixel_mode |= PMODE_FLARE;
	}
	*colr += cpart->tmp;
	*colg -= cpart->tmp/2;
	*colb -= cpart->tmp/2;
	return 0;
}