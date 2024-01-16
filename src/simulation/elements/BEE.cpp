#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_BEE()
{
	Identifier = "DEFAULT_PT_BEE";
	Name = "BEE";
	Colour = 0xff8000_rgb;
	MenuVisible = 1;
	MenuSection = SC_SPECIAL;
	Enabled = 1;

	Advection = 1.0f;
	AirDrag = 0.001f * CFDS;
	AirLoss = 0.9f;
	Loss = 0.002f;
	Collision = 0.0f;
	Gravity = 0.0f;
	Diffusion = 0.1f;
	HotAir = 0.000f	* CFDS;
	Falldown = 0;

	Flammable = 1;
	Explosive = 0;
	Meltable = 0;
	Hardness = 1;

	Weight = 91;

	DefaultProperties.temp = R_TEMP + 20.0f + 273.15f;
	HeatConduct = 42;
	Description = "BEE, attacks figh/stkm, uses plant to stay alive and reproduce. Avoids harmful elements. Makes hive at center when healthy.";

	Properties = TYPE_GAS;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 374.15f;
	HighTemperatureTransition = PT_FIRE;

	Update = &update;
	Graphics = &graphics;
	Create = &create;
}

static int update(UPDATE_FUNC_ARGS)
{
	// Edge detection
	if (parts[i].x < 20)
	{
		parts[i].vx = 0.6f;
	}
	else if (parts[i].x > 600)
	{
		parts[i].vx = -0.6f;
	}

	if (parts[i].y <= 10)
	{
		parts[i].vy = 0.6f;
	}
	else if (parts[i].y > 360)
	{
		parts[i].vy = -0.6f;
	}

	if (sim->rng.chance(1, 60)) //Slowly loses life if there's nothing to eat.
	{
		parts[i].life -= 1;
	}
	if (parts[i].life >= 100)   //Life check, god sees everything.
		parts[i].life = 100;

	else if (parts[i].life <= 0)  //Everyone has to die one day.
		sim->kill_part(i);

	if (parts[i].life > 30)
	{
		sim->pv[(y / CELL)][(x / CELL)] = 0.3f;  //Search areas for food if life drops below 90.
	}
	else if (parts[i].life <= 30)
	{
		sim->pv[(y / CELL)][(x / CELL)] = 0.9f;  //Search wider areas for food if life drops below 30.
	}
	if (parts[i].temp <= 44 + 273.15f && parts[i].life >= 75) //Temp. regulation.
	{
		parts[i].temp++;
		parts[i].life--;
	}

	if (parts[i].temp > 90 + 273.15f && parts[i].life >= 75)
	{
		parts[i].temp--;
		parts[i].life--;
	}

	if (parts[i].temp < 10 + 273.15f) //Stop moving when cold!
	{
		parts[i].vx = 0.0;
		parts[i].vy = 0.0;
	}
	if (parts[i].life < 20 && parts[i].x < 600 && parts[i].x > 20 && parts[i].y < 350) //Rest if no food is found.
	{
		parts[i].vy = 0.5;
	}
	//Meet at center if life is above 90.
	if (parts[i].life > 90)
	{
		if (parts[i].x < 325)
		{
			parts[i].vx = 0.6f;
		}
		else if (parts[i].x > 335)
		{
			parts[i].vx = -0.6f;
		}

		if (parts[i].y < 185)
		{
			parts[i].vy = 0.6f;
		}
		else if (parts[i].y > 195)
		{
			parts[i].vy = -0.6f;
		}

		if (parts[i].x > 325 && parts[i].x < 335 && parts[i].y > 185 && parts[i].y < 195)
		{
			sim->create_part(-1, x + 3, y + 3, PT_WAX);
		}
	}

	if (sim->rng.chance(1, 10))
	{
		for (auto rx = -20; rx < 21; rx++)
			for (auto ry = -20; ry < 21; ry++)
				if (x + rx >= 0 && y + ry >= 0 && x + rx < XRES && y + ry < YRES && (rx || ry))
				{
					auto r = pmap[y + ry][x + rx];
					if (!r)
						continue;
					if (TYP(r) == PT_PLNT)
				{
				parts[i].vx = (float)(rx * 3);
				parts[i].vy = (float)(ry * 3);
				sim->pv[(y / CELL) + ry][(x / CELL) + rx] = -4.0f;
				}
				}
	}

	for (auto rx = -2; rx < 3; rx++)
		for (auto ry = -2; ry < 3; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				if (parts[ID(r)].temp > 373.15f)
				{
					parts[i].vx = (float)(-rx);
					parts[i].vy = (float)(-ry);
				}

				switch (TYP(r))
				{
				case PT_BEE:
				{
					if (parts[i].life > 90)
					{
						parts[i].vx = (float)(-rx) * 2;
						parts[i].vy = (float)(-ry) * 2;
					}
				}
				break;
				// Avoid these particles.
				case PT_FIRE:
				case PT_PLSM:
				case PT_SMKE:
				case PT_ACID:
				case PT_BOMB:
				case PT_DEST:
				case PT_VIRS:
				case PT_LAVA:
				case PT_CFLM:
				{
					parts[i].vx = (float)(-rx)*2;
					parts[i].vy = (float)(-ry)*2;
				}
				break;
				case PT_PLNT:
				{
					if (sim->rng.chance(1, 30))
					{
						parts[i].life = 100;
						sim->kill_part(ID(r));
					}
					if (sim->rng.chance(1, 140))
					{
						sim->create_part(-1, x + 3, y + 3, PT_BEE);
					}
				}
				break;
				case PT_FIGH:
				case PT_STKM:
				case PT_STKM2:
				{
					sim->pv[(y / CELL) + ry][(x / CELL) + rx] = -2.0f;
					if (sim->rng.chance(1, 30))  //Attack stkms.
						parts[ID(r)].life -= 5;
				}
				break;
				}
			}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	if (cpart->life <= 30)
	{
		*colr = 250;
		*colg = 40;
		*colb = 40;
	}
	//wings
	ren->DrawLine(Vec2((int)(cpart->x),(int)(cpart->y)),Vec2(ren->rng.between((int)(cpart->x-2.0f),(int)(cpart->x + 2.0f)),(int)(cpart->y - 1.0f)),RGB<uint8_t>(255, 255, 0));
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].life = 100;
}
