#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_BALL()
{
	Identifier = "DEFAULT_PT_BALL";
	Name = "BALL";
	Colour = 0xD2042D_rgb;
	MenuVisible = 1;
	MenuSection = SC_SPECIAL;
	Enabled = 1;

	Advection = 0.4f;
	AirDrag = 0.01f * CFDS;
	AirLoss = 0.00f;
	Loss = 0.99f;
	Collision = 0.8f;
	Gravity = 1.0f;
	Diffusion = 0.4f;
	HotAir = 0.000f	* CFDS;
	Falldown = 2;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 20;

	Weight = 15;

	HeatConduct = 251;
	Description = "Bouncy glass balls. Spills away liquids and powders when bouncing on them. Use sparingly!";

	Properties = TYPE_LIQUID | PROP_LIFE_DEC;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = 20.0f;
	HighPressureTransition = PT_GLAS;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 1973.0f;
	HighTemperatureTransition = PT_LAVA;

	Update = &update;
	Graphics = &graphics;
}
static int update(UPDATE_FUNC_ARGS)
{
	for (auto  rx = -3; rx <= 3; rx++)
		for (auto  ry = -3; ry <= 3; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				if (TYP(r) && TYP(r) != PT_BALL && parts[i].life < 2)
				{
					if (!(sim->elements[TYP(r)].Properties & TYPE_SOLID) && !(sim->elements[TYP(r)].Properties & TYPE_ENERGY))
					{
						parts[ID(r)].vx = -1*parts[i].vx;
						parts[ID(r)].vy = -1*parts[i].vy;
					}
					parts[i].life = 8;
					parts[i].vx = -0.90*(parts[i].vx);
					parts[i].vy = -0.90*(parts[i].vy);
				}
			}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	ren->BlendEllipse(Vec2((int)(cpart->x), (int)(cpart->y)),Vec2(3,3), RGBA<uint8_t>(210, 4, 45, 255));
	ren->BlendFilledEllipse(Vec2((int)(cpart->x), (int)(cpart->y)),Vec2(2, 2),RGBA<uint8_t>(210, 4, 45, 200));
	return 0;
}