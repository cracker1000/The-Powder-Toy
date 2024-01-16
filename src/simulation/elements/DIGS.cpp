#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_DIGS()
{
	Identifier = "DEFAULT_PT_DIGS";
	Name = "DIGS";
	Colour = 0xFFFFFFFF_rgb;
	MenuVisible = 1;
	MenuSection = SC_SPECIAL;
	Enabled = 1;

	Advection = 0.0f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 0.00f;
	Loss = 0.00f;
	Collision = -0.1f;
	Gravity = 0.0f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 0;

	Weight = 91;

	HeatConduct = 255;
	Description = "Digital sign. Powered element, use with PSCN, NSCN and INST. tmp changes modes. (Read wiki for more info.)";
	DefaultProperties.temp = 274.15f;
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
	Create = &create;
	Graphics = &graphics;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].tmp > 5 || parts[i].tmp < 1)
		parts[i].tmp = 1;
	
	if (parts[i].tmp == 5 && parts[i].life == 10)
	{
		parts[i].tmp4 += 1;
        if (parts[i].tmp4 > 9999)
        parts[i].tmp4 = 0;		
	}
	for (auto rx = -2; rx < 3; rx++)
		for (auto ry = -2; ry < 3; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
			if (sim->parts_avg(i, ID(r), PT_INSL) != PT_INSL)
			{
				//Activation and deactivation part
				if (parts[ID(r)].type == PT_SPRK && parts[ID(r)].ctype == PT_PSCN && parts[ID(r)].life < 3)
				{
					parts[i].life = 10;
				}
				else if (parts[ID(r)].type == PT_SPRK && parts[ID(r)].ctype == PT_NSCN && parts[ID(r)].life < 3)
				{
					parts[i].life = 0;
				}
				else if (parts[ID(r)].type == PT_SPRK && parts[ID(r)].ctype == PT_INST && parts[ID(r)].life > 2)
				{
					parts[i].tmp += 1;
				}
				// Properties copy
				if (parts[i].life == 10)
				{
					parts[i].tmp2 = sim->pv[y/CELL][x/CELL]; //Pressure
					parts[i].tmp3 = sim->gravp[(y/CELL)*XCELLS+(x/CELL)]; //Gravity
				}
			}
			}
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].dcolour = 0xFFFF0000;
	sim->parts[i].tmp = 1;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{ 
	*colr = ((cpart->dcolour >> 16) & 0xFF);
	*colg = ((cpart->dcolour >> 8) & 0xFF);
	*colb = ((cpart->dcolour) & 0xFF);
	if (cpart->life == 10) //Active state
	{
	if (cpart->tmp == 1) // Temp. [1]
	{
	cpart->dcolour = 0xFFFF0000;

	ren->BlendText(Vec2((int)(cpart->x-8), (int)(cpart->y - 10)),String::Build(roundf(cpart->temp-273.15f)), RGBA<uint8_t>(*colr, *colg, *colb, 255));
	}
	else if (cpart->tmp == 2) //Pressure [2]
	{
	cpart->dcolour = 0xFF478ED6;
	ren->BlendText(Vec2((int)(cpart->x-2), (int)(cpart->y - 10)),String::Build(cpart->tmp2), RGBA<uint8_t>(*colr, *colg, *colb, 255));
	}
	else if (cpart->tmp == 3) //Gravity [3]
	{
	cpart->dcolour = 0xFF00FF00;
	ren->BlendText(Vec2((int)(cpart->x-2), (int)(cpart->y - 10)),String::Build(cpart->tmp3), RGBA<uint8_t>(*colr, *colg, *colb, 255));
	}
	else if (cpart->tmp == 4) //Crack Mod [4]
	{
	cpart->dcolour = 0xFF8300FF;
	ren->BlendFilledRect(RectSized(Vec2((int)(cpart->x - 22), (int)(cpart->y-13)),Vec2( 51, 13)),RGBA<uint8_t>(*colr, *colg, *colb,50));
	ren->DrawRect(RectSized(Vec2((int)(cpart->x - 22), (int)(cpart->y-13)),Vec2( 51, 13)),RGB<uint8_t>(*colr, *colg, *colb));
	ren->BlendText(Vec2((int)(cpart->x-20), (int)(cpart->y - 10)),"Crack Mod", RGBA<uint8_t>(*colr, *colg, *colb, 255));
	}
	else if (cpart->tmp == 5) //Timer [5]
	{
	cpart->dcolour = 0xFFFFFFFF;
	ren->BlendText(Vec2((int)(cpart->x-4), (int)(cpart->y - 10)),String::Build(cpart->tmp4), RGBA<uint8_t>(*colr, *colg, *colb, 255));
	}
	}
	return 0;
}
