#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_MISL()
{
	Identifier = "DEFAULT_PT_MISL";
	Name = "MISL";
	Colour = 0xFFA500_rgb;
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
	Description = "Missile, flies to target coordinates (tmp = X, tmp2 = Y) and then goes booom. Activates with PSCN. Use MIST tool for ease.";

	Properties = TYPE_PART;

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
	//checks for .tmp and .tmp2
	if (parts[i].tmp <= 0 || parts[i].tmp > 610)
		parts[i].tmp = 100;
	if (parts[i].tmp2 <= 0 || parts[i].tmp2 > 380)
		parts[i].tmp2 = 100;
	if (parts[i].tmp4 < 1)
		parts[i].tmp4 = 1;
	if (parts[i].life == 0)// Prevent it from being displaced by gravity.
	{
		parts[i].vx = 0;
		parts[i].vy = 0;
	}
	//Explosion
	if (parts[i].life > 0)
	{
		if (((abs(parts[i].x - parts[i].tmp) <= 3) && abs(parts[i].y - parts[i].tmp2) <= 2) || parts[i].tmp4 > 300 || parts[i].temp >= 873.15f)
		{
			sim->pv[(y / CELL)][(x / CELL)] = 270;
			parts[i].life = 1;
			parts[i].tmp = 400;
			sim->part_change_type(i, x, y, PT_SING);
		}
	}
	float velaccuracy = 0;
	if (parts[i].life == 20)
	{
		if ((abs(parts[i].y - parts[i].tmp2) > 6))
		{
			velaccuracy = 3;
		}
		else if ((abs(parts[i].y - parts[i].tmp2) <= 6))
		{
			velaccuracy = 1;
		}
			if (parts[i].y > parts[i].tmp2)
			{
				parts[i].vy = -1*(velaccuracy);
				sim->create_part(-1, x, y + 1, PT_BRAY); //Trail Up
			}
			else if (parts[i].y < parts[i].tmp2)
			{
				parts[i].vy = velaccuracy;
				sim->create_part(-1, x, y - 1, PT_BRAY); //Trail Down
			}
			if (parts[i].y == parts[i].tmp2)
			{
				parts[i].life = 10;
			}
		}
	// Motion path
	else if (parts[i].life == 10) //For motion
	{
		if ((abs(parts[i].x - parts[i].tmp) > 6))
		{
			velaccuracy = 3;
		}
		else if ((abs(parts[i].x - parts[i].tmp) <= 6))
		{
			velaccuracy = 1;
		}
		if (parts[i].x < parts[i].tmp)
		{
			parts[i].vx = velaccuracy;
			sim->create_part(-1, x-1, y, PT_BRAY); //Trail Left
		}
		else if (parts[i].x > parts[i].tmp)
		{
			parts[i].vx = -1*(velaccuracy);
			sim->create_part(-1, x+1, y, PT_BRAY); //Trail Right
		}
	}

	for (auto rx = -2; rx <= 2; rx++)
		for (auto ry = -2; ry <= 2; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r || sim->parts_avg(ID(r), i, PT_INSL) == PT_INSL)
					continue;
				if (parts[ID(r)].type == PT_SPRK && parts[ID(r)].ctype == PT_PSCN && parts[ID(r)].life == 3) //Check for a sprk with ctype PSCN to activate and store the direction.
				{
					parts[i].life = 20;
				}

				if (TYP(r) == PT_PSCN && parts[i].life == 0)
					{
					parts[i].tmp4 = 0;
					}
				if (parts[i].life > 0)
				{
					if (TYP(r))
						parts[i].tmp4++;
				}
			}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS) //Flare when activated.
{
	int cr = cpart->tmp;
	int cg = cpart->tmp2;
	int cb = cpart->tmp - cpart->tmp2;

	if (cpart->tmp4 > 0) // pointer
	{
		ren->DrawRect(RectSized(Vec2((int)(cpart->tmp - 2), (int)(cpart->tmp2)),Vec2(5, 1)), RGB<uint8_t>(cr, cg, cb));
		ren->DrawRect(RectSized(Vec2(cpart->tmp, cpart->tmp2 - 2),Vec2(1, 5)), RGB<uint8_t>(cr, cg, cb));
	}
	//Body
	if (cpart->life == 0)
	{
		ren->DrawLine(Vec2((int)(cpart->x), (int)(cpart->y - 1)),Vec2((int)(cpart->x), (int)(cpart->y - 4)), RGB<uint8_t>(cr, cg, cb));
	}
	else
	{
		if (cpart->vy < 0)
		{
			ren->DrawLine(Vec2((int)(cpart->x), (int)(cpart->y - 1)),Vec2((int)(cpart->x), (int)(cpart->y - 4)), RGB<uint8_t>(cr, cg, cb));
		}
		else if (cpart->vy > 0)
		{
			ren->DrawLine(Vec2((int)(cpart->x), (int)(cpart->y - 1)),Vec2((int)(cpart->x), (int)(cpart->y + 4)), RGB<uint8_t>(cr, cg, cb));
		}
		if (cpart->vx < 0)
		{
			ren->DrawLine(Vec2((int)(cpart->x+1), (int)(cpart->y)), Vec2((int)(cpart->x + 4),(int)(cpart->y)), RGB<uint8_t>(cr, cg, cb));
		}
		else if (cpart->vx > 0)
		{
			ren->DrawLine(Vec2((int)(cpart->x - 1), (int)(cpart->y)), Vec2((int)(cpart->x - 4), (int)(cpart->y)), RGB<uint8_t>(cr, cg, cb));
		}
	}
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS) //Default range and ctype settings.
{
	sim->parts[i].tmp = sim->rng.between(1, 610);
	sim->parts[i].tmp2 = sim->rng.between(1, 380);
}
