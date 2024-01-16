#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_DFOM()
{
	Identifier = "DEFAULT_PT_DFOM";
	Name = "DFOM";
	Colour = 0x708090_rgb;
	MenuVisible = 1;
	MenuSection = SC_GAS;
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
	Hardness = 1;

	Weight = 100;

	HeatConduct = 251;
	Description = "Defence foam. absorbs shock of an explosion and then returns to set shape. Read wiki.";

	Properties = TYPE_PART | PROP_HOT_GLOW;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 6273.0f;
	HighTemperatureTransition = PT_LAVA;
	Update = &update;
	Create = &create;
	Graphics = &graphics;
}
constexpr float ADVECTION = 0.4f;
static int update(UPDATE_FUNC_ARGS)
{
	if (sim->pv[y/CELL][x/CELL]>1.0f || parts[i].temp > 60 + 273.15f)
	{
		parts[i].tmp4 = 250;
		parts[i].vx += ADVECTION*sim->vx[y/CELL][x/CELL];
		parts[i].vy += ADVECTION*sim->vy[y/CELL][x/CELL];
	}
	//Temp. checks
	if (parts[i].temp > 22.0f + 273.15f)
	{
		parts[i].temp -= 4.0f;
	}
	if (parts[i].temp < 22 + 273.15f)
	{
		parts[i].temp += 1.0f;
	}
	if (parts[i].tmp3 > 0)
	{
		parts[i].tmp3 -= 1; 
	}
	if (parts[i].tmp4 > 0)
	{
		parts[i].tmp4 -= 1; 
	}
	//uneven texture 
	if (parts[i].tmp3 < 15 and parts[i].tmp3 > 1)
	{
	if (parts[i].tmp3 == 1)
	{
		parts[i].tmp = parts[i].x;
		parts[i].tmp2 = parts[i].y;
	}
		for (auto rx = -1; rx < 1; rx++)
		for (auto ry = -1; ry < 1; ry++)
		if (rx || ry)
	{
			auto r = pmap[y + ry][x + rx];
			if (!r)
			continue;
		if (parts[ID(r)].type == PT_DFOM)
		{
		parts[i].vx = (float)(-rx * 2);
		parts[i].vy = (float)(-ry * 2);				
		}
	}
	}
	//Structure recovery
	if (parts[i].tmp4 < 200 && parts[i].tmp4 > 0)
	{
		if (sim->rng.chance(1, 3))
	{
		if (parts[i].x > parts[i].tmp)
		{
			parts[i].vx -= 2.0f;
		}
	else
		{
			parts[i].vx += 2.0f;
		}
		
	if (parts[i].y > parts[i].tmp2)
		{
			parts[i].vy -= 2.0f;
		}
	else
		{
			parts[i].vy += 2.0f;
		}
	}
	}
	//Sets shape when cold (below 0.0C)
	if (parts[i].temp < 273.15f)
	{
    sim->parts[i].tmp = sim->parts[i].x;
	sim->parts[i].tmp2 = sim->parts[i].y;
	}
	return 0;
}
static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->tmp4 < 200 && cpart->tmp4 > 0)
	{
	*firea = 250;
	*firer = ren->rng.between(50,255);
	*fireg = ren->rng.between(50,255);
	*fireb = ren->rng.between(50,255);
	}
	else
	{
	*firea = 30;
	*firer = 112;
	*fireg = 128;
	*fireb = 144;
	}
	if (cpart->temp < 273.15f)
	{
	*colr = 244;
	*colg = 84;
	*colb = 84;
	*pixel_mode |= PMODE_FLARE;
	}
	else
	{
	*pixel_mode = FIRE_BLEND;
	}
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].tmp = sim->parts[i].x;
	sim->parts[i].tmp2 = sim->parts[i].y;
	sim->parts[i].tmp3 = 40;
}