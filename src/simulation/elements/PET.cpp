#include "simulation/ElementCommon.h"

static int update(UPDATE_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);

void Element::Element_PET()
{
	Identifier = "DEFAULT_PT_PET";
	Name = "PET";
	Colour = 0x8A8AFF_rgb;
	MenuVisible = 1;
	MenuSection = SC_SPECIAL;
	Enabled = 1;

	Advection = 0.4f;
	AirDrag = 0.04f * CFDS;
	AirLoss = 0.94f;
	Loss = 0.95f;
	Collision = -0.1f;
	Gravity = 0.1f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 1;

	Flammable = 0;
	Explosive = 0;
	Meltable = 5;
	Hardness = 1;

	Weight = 90;

	HeatConduct = 150;

	Properties = TYPE_PART;
	DefaultProperties.temp = R_TEMP + 14.6f + 273.15f;
	HeatConduct = 150;
	Description = "Robot Pet, follows STKM/ STKM2, fights with FIGH, uses PLNT and WATR to stay alive (Read wiki for more info.)";

	Properties = PROP_NOCTYPEDRAW| TYPE_PART;
	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 720.0f;
	HighTemperatureTransition = PT_FIRE;

	Update = &update;
	Create = &create;
	Graphics = &graphics;
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
	//Slowly loses life if there's nothing to eat.
	if (sim->rng.chance(1, 80))
	{
		parts[i].life -= 1;
	}
	//Temp. regulation.
	if (parts[i].temp <= 10 + 273.15f)
	{
		parts[i].tmp = 10;
		parts[i].temp++;
		if (sim->rng.chance(1, 10))
			parts[i].life--;
	}

	if (parts[i].temp > 50 + 273.15f)
	{
		parts[i].tmp = 10;
		parts[i].temp--;
		if (sim->rng.chance(1, 10))
			parts[i].life--;
	}

	if (parts[i].tmp > 0)
	{
		if (sim->rng.chance(1, 30))
			parts[i].tmp = 0;
	}

	//Life check, god sees everything.

	if (parts[i].life > 100)
		parts[i].life = 100;

	else if (parts[i].life <= 0)
	{
	sim->part_change_type(i, x, y, PT_DUST);
	sim->pv[(y / CELL)][(x / CELL)] = 270;
	sim->kill_part(i);
    }

	//Velocity check.
	if (parts[i].vx > 5)   
		parts[i].vx = 5;

	else if (parts[i].vx < -4)  
		parts[i].vx = -4;

	if (parts[i].vy > 5)
		parts[i].vy = 5;

	else if (parts[i].vy < -4)   //Vel.check
		parts[i].vy = -4;

	//Expansion jutsu
	if (parts[i].life < 10 && parts[i].ctype <35)
	{
		if (sim->rng.chance(1, 25))
		parts[i].ctype += 1;
	}
	else if (parts[i].life > 10)
	{
		parts[i].ctype = 3;
	}

	for (auto rx = -70; rx < 70; rx++)
		for (auto ry = -30; ry < 5; ry++)
			if (x + rx >= 0 && y + ry >= 0 && x + rx < XRES && y + ry < YRES && (rx || ry))
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				r = pmap[y + ry][x + rx];
				switch (TYP(r))
				{
				// Follow STKM and STKM2
				case PT_STKM:
				case PT_STKM2:
				{
					    parts[i].tmp = 4;

						if (parts[ID(r)].ctype == PT_PET)
						{
							parts[ID(r)].ctype = PT_DUST;
						}

						if (parts[ID(r)].life < 100)
						{
							parts[ID(r)].life += 1;
						}
						if (parts[i].x < parts[ID(r)].x)
						{
							parts[i].x++;
						}
						else if (parts[i].x > parts[ID(r)].x)
						{
							parts[i].x--;
						}		

						if (parts[i].y < parts[ID(r)].y)
						{
							parts[i].y++;
						}
						else if (parts[i].y > parts[ID(r)].y)
						{
							parts[i].y--;
						}
				}
					break;

				case PT_FIGH:
				{
						parts[i].tmp = 10;
						if (parts[ID(r)].life >= 10)
						{
							parts[ID(r)].life -= 1;
						}
						else if (parts[ID(r)].life < 10)
						{
							sim->part_change_type(ID(r), x + rx, y + ry, PT_DUST);
						}
							if (parts[i].x < parts[ID(r)].x)
							{
								parts[i].x++;
							}
							else if (parts[i].x > parts[ID(r)].x)
							{
								parts[i].x--;
							}

							if (parts[i].y < parts[ID(r)].y)
							{
								parts[i].y++;
							}
							else if (parts[i].y > parts[ID(r)].y)
							{
								parts[i].y--;
							}

				}
					break;
					//Prevent multiple pets.
					case PT_PET:
					{
							sim->kill_part(ID(r));
					}
					break;
					}
				}

	for (auto rx = -15; rx < 15; rx++)
		for (auto ry = -10; ry < 5; ry++)
				if (x + rx >= 0 && y + ry >= 0 && x + rx < XRES && y + ry < YRES && (rx || ry))
				{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				r = pmap[y + ry][x + rx];

				if (parts)
				{
					switch (TYP(r))
					{
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
						case PT_BFLM:
						case PT_THDR:
						{
							parts[i].tmp = 10;
							parts[i].vx = (float)(-rx * 2);
							parts[i].vy = (float)(-ry * 2);						
						}	break;
						case PT_PLNT:
						case PT_WATR:
						{
							if (sim->rng.chance(1, 200))
							{
								parts[i].life += 1;
								sim->kill_part(ID(r));
							}

							if (parts[i].x < parts[ID(r)].x)
							{
								parts[i].x++;
							}
							else if (parts[i].x > parts[ID(r)].x)
							{
								parts[i].x--;
							}

							if (parts[i].y < parts[ID(r)].y)
							{
								parts[i].y++;
							}
							else if (parts[i].y > parts[ID(r)].y)
							{
								parts[i].y--;
							}
						}	break;
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
				if (parts[ID(r)].temp > 373.15f || parts[ID(r)].temp < 273.15f)
				{
					parts[i].tmp = 10;
					if (parts[i].x < parts[ID(r)].x)
					{
						parts[i].x--;
					}
					else if (parts[i].x > parts[ID(r)].x)
					{
						parts[i].x++;
					}

					if (parts[i].y < parts[ID(r)].y)
					{
						parts[i].y--;
					}
					else if (parts[i].y > parts[ID(r)].y)
					{
						parts[i].y++;
					}
				}
			}
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].life = 100;
	sim->parts[i].ctype = 3;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	int mr = 255;
	int mg = 0;
	int mb = 0;

	if (cpart->life >= 80)
	{
		mr = 50;
		mg = 255;
		mb = 50;
	}
	else if (cpart->life > 30 && cpart->life < 80)
	{
		mr = 250;
		mg = 150;
		mb = 20;
	}
	if (cpart->tmp > 5 || cpart->life < 30)
	{
			mr = 250;
			mg = 50;
			mb = 50;
	ren->BlendText(Vec2((int)(cpart->x + 9.0f), (int)(cpart->y - 17.0f)), "!", RGBA<uint8_t>(255, 0, 0, 255));
	}
	if (cpart->tmp > 0 && cpart->tmp <5)
	{
	ren->BlendText(Vec2((int)(cpart->x - 10.0f), (int)(cpart->y - 27.0f)), "Stkm",  RGBA<uint8_t>(55, 255, 55, 250));
	}

	if (cpart->vy > 0)
	{
	ren->BlendText(Vec2((int)(cpart->x - 2.0f), (int)(cpart->y + 3.0f)), "*", RGBA<uint8_t>(255, 255, 0, 255)); 
	}
	// draw body
	ren->BlendFilledEllipse(Vec2((int)(cpart->x), (int)(cpart->y - 10.0f)),Vec2(cpart->ctype, cpart->ctype), RGBA<uint8_t>(mr, mg, mb, 255));
	ren->BlendFilledEllipse(Vec2((int)(cpart->x), (int)(cpart->y - 2.0f)), Vec2(cpart->ctype + 1, cpart->ctype + 1),RGBA<uint8_t>( 138, 138, 255, 205));
	ren->DrawRect(RectSized(Vec2((int)(cpart->x - 1.0f), (int)(cpart->y - 11.0f)),Vec2( 3, 1)),RGB<uint8_t>( 0, 0, 0));

	// health bar
	ren->DrawFilledRect(RectSized(Vec2((int)(cpart->x - 4.0f), (int)(cpart->y - 17.0f)), Vec2(cpart->life / 10, 1)), RGB<uint8_t>(mr, mg, mb));
	ren->DrawRect(RectSized(Vec2((int)(cpart->x - 5.0f), (int)(cpart->y - 18.0f)),Vec2( 12, 3)), RGB<uint8_t>(138, 138, 255));

	// Hand
	ren->DrawRect(RectSized(Vec2((int)(cpart->x - 5.0f), (int)(cpart->y - 6.0f)),Vec2( 1, 4)), RGB<uint8_t>(255, 255, 255));
	ren->DrawRect(RectSized(Vec2((int)(cpart->x + 5.0f), (int)(cpart->y - 6.0f)),Vec2( 1, 4)), RGB<uint8_t>(255, 255, 255));

	// anteena
	ren->DrawRect(RectSized(Vec2((int)(cpart->x - 4.0f), (int)(cpart->y - 13.0f)),Vec2( 1, 3)),RGB<uint8_t>(mr, mg, mb));
	ren->DrawRect(RectSized(Vec2((int)(cpart->x + 4.0f), (int)(cpart->y - 13.0f)),Vec2( 1, 3)),RGB<uint8_t>(mr, mg, mb));
	return 0;
}
