#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

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
	Graphics = &graphics;
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
		if (elemid != 78 && elemid != 226 && elemid != 232 && elemid != 236 && elemid < 253) // prevent from turning into BFLM, GoL, WHEL, MIST and itself.
		{
			sim->create_part(i, x, y, elemid);
		}
	}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	int cr, cb, cg = 0;
	if (cpart->temp < 273.15f)
	{
		cr = 255;
		cg = 20;
		cb = 20;
	}
	else 
	{
		float frequency = 0.1045f;
		cr = (int)(sin(frequency* cpart->tmp + 4) * 127 + 150);
		cg = (int)(sin(frequency* cpart->tmp + 5) * 127 + 150);
		cb = (int)(sin(frequency* cpart->tmp + 8) * 127 + 150);
		if (cpart->tmp > 70)
	{
		ren->DrawLine(Vec2((int)(cpart->x), (int)(cpart->y)), Vec2(ren->rng.between((int)(cpart->x - 9), (int)(cpart->x + 9)), ren->rng.between((int)(cpart->y - 9), (int)(cpart->y + 9))),RGB<uint8_t>(255, 255, 255));
	}
	}
	ren->BlendEllipse(Vec2((int)(cpart->x), (int)(cpart->y)),Vec2( 2, 2), RGBA<uint8_t>(cr, cg, cb, 150));
	ren->BlendFilledEllipse(Vec2((int)(cpart->x), (int)(cpart->y)),Vec2(1, 1), RGBA<uint8_t>(cr, cg, cb, 100));
	return 0;
}
