#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_UVRD()
{
	Identifier = "DEFAULT_PT_UVRD";
	Name = "UV";
	Colour = PIXPACK(0x9400D3);
	MenuVisible = 1;
	MenuSection = SC_NUCLEAR;
	Enabled = 1;

	Advection = 0.0f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 1.00f;
	Loss = 1.00f;
	Collision = -0.99f;
	Gravity = 0.0f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 0;

	Weight = -1;

	DefaultProperties.temp = R_TEMP + 100.0f + 273.15f;
	HeatConduct = 251;
	Description = "UV rays emitted by SUN, reacts differently with different elements. Visible when passing through FILT ";

	Properties = TYPE_ENERGY | PROP_LIFE_DEC;

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
	int r, rx, ry;
	for (rx = -1; rx < 2; rx++)
		for (ry = -1; ry < 2; ry++)
			if (BOUNDS_CHECK && (rx || ry))
			{
				r = pmap[y + ry][x + rx];
				switch (TYP(r))
				{
				case PT_PLNT:
					if (RNG::Ref().chance(1, 40))
					{
						sim->create_part(ID(r), x + rx, y + ry, PT_VINE);
					}
					break;
				case PT_WATR:
				case PT_DSTW:
				case PT_CBNW:
				case PT_SLTW:
				{
					if (parts[i].life > 1)
					{
						if (RNG::Ref().chance(1, 2))
						{
							sim->part_change_type(ID(r), x + rx, y + ry, PT_H2);
						}
						if (RNG::Ref().chance(1, 2))
						{
							sim->part_change_type(ID(r), x + rx, y + ry, PT_O2);
						}
					}
					else 
						sim->part_change_type(ID(r), x + rx, y + ry, PT_WTRV);
				}
				break;
				case PT_PSCN:
				{
					sim->create_part(ID(r), x + rx, y + ry, PT_SPRK);
				}
				break;
				case PT_FILT:
				{
					parts[i].life++;
				}
				break;
				case PT_STKM:
				case PT_FIGH:
				case PT_STKM2:
				{
					parts[ID(r)].life -= 05;
				}
				break;
				}
			}
	return 0;
}
static int graphics(GRAPHICS_FUNC_ARGS)
		{
			if (cpart->life > 0)
			{
				*colr = cpart->life + 50;
				*colg = 0;
				*colb = cpart->life + 50;
				*pixel_mode |= PMODE_FLARE;
			}
			else
			{
				*colr = 0;
				*colb = 0;
				*colg = 0;
				*pixel_mode |= NO_DECO;
			}
		*pixel_mode |= NO_DECO;
		return 0;
	}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	float a = RNG::Ref().between(0, 359) * 3.14159f / 180.0f;
	sim->parts[i].life = 5;
	sim->parts[i].vx = 2.0f * cosf(a);
	sim->parts[i].vy = 2.0f * sinf(a);
}
