#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_QGPP()
{
	Identifier = "DEFAULT_PT_QGPP";
	Name = "QGP";
	Colour = 0X9400D3_rgb;
	MenuVisible = 1;
	MenuSection = SC_GAS;
	Enabled = 1;

	Advection = 1.0f;
	AirDrag = 0.01f * CFDS;
	AirLoss = 0.99f;
	Loss = 0.30f;
	Collision = -0.1f;
	Gravity = 0.0f;
	Diffusion = 0.40f;
	HotAir = 0.001f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 1;

	Weight = 1;

	DefaultProperties.temp = R_TEMP + 2.0f + 873.15f;
	DefaultProperties.tmp = 900;
	HeatConduct = 42;
	Description = "Quark Gluon Plasma, a strange element under investigation.";
	Properties = TYPE_GAS | PROP_NEUTPASS;

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
}

static int update(UPDATE_FUNC_ARGS)
{
				if (parts[i].tmp > 0)
				{
					parts[i].tmp--;
					parts[i].tmp2++;
				}

				if (parts[i].tmp == 0 && parts[i].temp >= 474.15f )
				{
					parts[i].tmp = 55;
					parts[i].type = PT_SING;
				}
				else if (parts[i].tmp <= 170 && parts[i].temp >= 474.15f)
					{
					 sim->pv[(y / CELL)][(x / CELL)] = -2.0f;
				    }
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp <= 400 && cpart->temp >= 374.15f)
	{
		*pixel_mode |= PMODE_LFLARE;
	}
	if (cpart->tmp <= 150 && cpart->temp >= 374.15f)
	{
		float frequency = 0.04045f;
		*colr = (int)(sin(frequency * cpart->tmp + 4) * 127 + 150);
		*colg = (int)(sin(frequency * cpart->tmp + 8) * 127 + 150);
		*colb = (int)(sin(frequency * cpart->tmp + 5) * 127 + 150);
	}
	if (cpart->temp < 373.15f)
	{
		*colr = 139;
		*colg = 0;
		*colb = 139;
		*pixel_mode |= PMODE_FLARE;
		
	}
	else if (cpart->temp >= 374.15f && cpart->tmp >50)
	{
		*colb = cpart->tmp2 / 5;
		*colg = cpart->tmp2 / 5;
		*colr = 240;
		*pixel_mode |= PMODE_FLARE;
	}

	return 0;
}
