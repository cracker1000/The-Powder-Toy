#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_WHEL()
{
	Identifier = "DEFAULT_PT_WHEL";
	Name = "WHEL";
	Colour = 0x202020_rgb;
	MenuVisible = 1;
	MenuSection = SC_FORCE;
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
	Description = "Wheel. Use with PSCN and NSCN, .tmp sets wheel size while temp. sets the speed. Deco = spoke colourour. Read wiki!";

	Properties = TYPE_SOLID;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = ITH;
	HighTemperatureTransition = NT;
	DefaultProperties.temp = 400 + 273.15f;

	Update = &update;
	Graphics = &graphics;
	Create = &create;
}

static int update(UPDATE_FUNC_ARGS)
{
	if (parts[i].temp < 100 + 273.15f || parts[i].temp> 1000 + 273.15f)
		parts[i].temp = 400 + 273.15f;
	if (parts[i].tmp < 5 || parts[i].tmp > 50)
		parts[i].tmp = 5;
	if (parts[i].life >= parts[i].temp-273.15f)
		parts[i].life -= 40;
	if (parts[i].dcolour == 0 || parts[i].dcolour == 0xFF000000)
		parts[i].dcolour = 0xFFFF0000;
	if (parts[i].tmp2 > 0)
		parts[i].tmp2 -= 1;
	if (parts[i].tmp2 > 20)
		parts[i].tmp2 = 20;
	if (parts[i].life > 0 && parts[i].tmp2 < 4)
		parts[i].life -= 1;
	if (parts[i].life < 0)
		parts[i].life = 0;

	for (auto  rx = -2; rx <=2; rx++)
		for (auto  ry = -2; ry <= 2; ry++)
			if (rx || ry)
			{
				auto  r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				if (parts[ID(r)].type == PT_SPRK && parts[ID(r)].ctype == PT_PSCN)
				{
					parts[i].tmp2 += 7;
				}
				else if (parts[ID(r)].type == PT_SPRK && parts[ID(r)].ctype == PT_NSCN)
				{
					parts[i].tmp2 = 0;
					if (parts[i].life > 0)
					{
						parts[i].life -= 14;
					}
				}
				
				if (parts[i].tmp2 > 0)
				{
					sim->pv[(y / CELL)][(x / CELL)] = parts[i].life / 14.0f;
					parts[i].life += 1;
				}
			}
	for (auto rx = -1*(parts[i].tmp+8); rx <= (parts[i].tmp+8); rx++)
		for (auto ry = -1*(parts[i].tmp+8); ry <= (parts[i].tmp+8); ry++)
			if (x + rx >= 0 && y + ry >= 0 && x + rx < XRES && y + ry < YRES && (rx || ry))
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				{
					if (parts[ID(r)].type == PT_WHEL)
					{
						sim->kill_part(ID(r));
					}
				}
			}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	*colr = ((cpart->dcolour >> 16) & 0xFF);
	*colg = ((cpart->dcolour >> 8) & 0xFF);
	*colb = ((cpart->dcolour) & 0xFF);
	int angle = 0;
	angle = cpart->life/13;
	ren->DrawLine(Vec2((int)(cpart->x), (int)(cpart->y)), Vec2((int)(cpart->x + cpart->tmp * cos(angle * cpart->life / 13)), (int)(cpart->y + cpart->tmp * sin(angle * cpart->life / 13))), RGB<uint8_t>(*colr, *colg, *colb));
	ren->DrawLine(Vec2((int)(cpart->x), (int)(cpart->y)), Vec2((int)(cpart->x + cpart->tmp * cos(angle * cpart->life / 13 + 10)), (int)(cpart->y + cpart->tmp * sin(angle * cpart->life / 13 + 10))), RGB<uint8_t>(*colr, *colg, *colb));
	ren->DrawLine(Vec2((int)(cpart->x), (int)(cpart->y)), Vec2((int)(cpart->x + cpart->tmp * cos(angle * cpart->life / 13 + 20)), (int)(cpart->y + cpart->tmp * sin(angle * cpart->life / 13 + 20))), RGB<uint8_t>(*colr, *colg, *colb));
	ren->DrawLine(Vec2((int)(cpart->x), (int)(cpart->y)), Vec2((int)(cpart->x + cpart->tmp * cos(angle * cpart->life / 13 + 30)), (int)(cpart->y + cpart->tmp * sin(angle * cpart->life / 13 + 30))),RGB<uint8_t>( *colr, *colg, *colb));
	ren->DrawLine(Vec2((int)(cpart->x), (int)(cpart->y)), Vec2((int)(cpart->x + cpart->tmp * cos(angle * cpart->life / 13 + 40)), (int)(cpart->y + cpart->tmp * sin(angle * cpart->life / 13 + 40))), RGB<uint8_t>(*colr, *colg, *colb));
	ren->BlendEllipse(Vec2((int)(cpart->x), (int)(cpart->y)),Vec2(cpart->tmp + 3, cpart->tmp + 3), RGBA<uint8_t>(*colr, *colg, *colb, 255));
	ren->BlendEllipse(Vec2((int)(cpart->x), (int)(cpart->y)),Vec2(cpart->tmp + 5, cpart->tmp + 5),RGBA<uint8_t>(60, 60, 60, 255));
	ren->BlendFilledEllipse(Vec2((int)(cpart->x), (int)(cpart->y)),Vec2(cpart->tmp-cpart->tmp/2, cpart->tmp-cpart->tmp/2), RGBA<uint8_t>(*colr, *colg, *colb, 150));
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS) //Default length.
{
	sim->parts[i].dcolour = 0xFFFF0000;
	sim->parts[i].tmp = 8;
}
