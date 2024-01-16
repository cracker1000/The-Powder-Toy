#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);
void Element::Element_LED()
{
	Identifier = "DEFAULT_PT_LED";
	Name = "LED";
	Colour = 0x404040_rgb;
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
	Description = "Light emitting diode, use decorations to set the glow colour. Activates with PSCN.";
	DefaultProperties.temp = 35.0f + 273.15f;

	Properties = TYPE_SOLID;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = NT;
	HighTemperatureTransition = NT;

	Update = &update;
	Graphics = &graphics;
	Create = &create;
}

static int update(UPDATE_FUNC_ARGS)
{

	if (parts[i].temp > 374.15f)
		parts[i].temp = 374.15f;
	if (parts[i].temp < 274.15f)
		parts[i].temp = 274.15f;

	if (parts[i].life > 0)
		parts[i].life--;

			for (auto rx = -2; rx < 2; rx++)
				for (auto ry = -2; ry < 2; ry++)
					if (rx || ry)
					{
						auto r = pmap[y + ry][x + rx];
						if (!r || sim->parts_avg(ID(r), i, PT_INSL) == PT_INSL)
							continue;
						if (parts[ID(r)].type == PT_SPRK && parts[ID(r)].life > 0 && parts[ID(r)].ctype == PT_PSCN)
						{
							{
								sim->flood_prop(x, y, Particle::GetProperties()[FIELD_LIFE], 8);
							}
						}
						}
		return 0;
	}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	*colr = ((cpart->dcolour >> 16) & 0xFF)/5;
	*colg = ((cpart->dcolour >> 8) & 0xFF)/5;
	*colb = ((cpart->dcolour) & 0xFF)/5;
	if (cpart->life > 0)
	{
			*firer = (cpart->dcolour >> 16) & 0xFF;
			*fireg = (cpart->dcolour >> 8) & 0xFF;
			*fireb = (cpart->dcolour) & 0xFF;
			*firea = (int)(cpart->temp - 273.15f);
			*pixel_mode |= FIRE_ADD;
	}
	*pixel_mode |= NO_DECO;
		return 0;
}
static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].dcolour = 0xFFFFFFFF;
}
