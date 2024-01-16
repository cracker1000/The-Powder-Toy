#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);
static bool ctypeDraw(CTYPEDRAW_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_PROJ()
{
	Identifier = "DEFAULT_PT_PROJ";
	Name = "PROJ";
	Colour = 0xFFE21D24_rgb;
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
	Description = "Projectile, converts into ctype upon collision. SPRK with PSCN to launch. Use .tmp for range and temp. for power.";

	Properties = TYPE_PART;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = ITH;
	HighTemperatureTransition = NT;
	DefaultProperties.temp = R_TEMP + 30.0f; //Defualt power.

	Update = &update;
	CtypeDraw = &ctypeDraw;
	Graphics = &graphics;
	Create = &create;
}

static int update(UPDATE_FUNC_ARGS)
{
	//checks for .tmp and .temp
	if (parts[i].tmp <= 0 || parts[i].tmp > 100)
		parts[i].tmp = 10;
	if (parts[i].temp <= 273.15f || parts[i].temp > 373.15f )
		parts[i].temp = 293.15f;

	for (auto rx = -1; rx <= 1; rx++)
		for (auto ry = -1; ry <= 1; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				if (parts[ID(r)].type == PT_SPRK && parts[ID(r)].ctype == PT_PSCN && parts[ID(r)].life == 3) //Check for a sprk with ctype PSCN to activate and store the direction.
				{
					parts[i].tmp4 = (int)(-rx);
					parts[i].tmp3 = (int)(-ry);
					parts[i].life = 10;
				}
			}
	for (auto rx = -3; rx <= 4; rx++)
		for (auto ry = -3; ry <= 4; ry++)
			if (rx || ry)
			{
				auto r = pmap[y + ry][x + rx];
				if (!r)
					continue;
				//For collision detection.
				if (parts[i].life == 10 && parts[ID(r)].type != PT_EMBR && parts[ID(r)].type != PT_SPRK && parts[ID(r)].type != PT_PSCN && TYP(r))
				{
					sim->part_change_type(i, x, y, parts[i].ctype);
				}
			}

	if (parts[i].life == 10) //For motion, .temp determines the power while .tmp deterimines the range. 
	{
		parts[i].tmp2+= 1;
		parts[i].vx = parts[i].tmp4*((parts[i].temp-273.15f)/10);
		parts[i].vy = parts[i].tmp3 + 0.2*(parts[i].tmp2/parts[i].tmp);
		parts[i].vy = parts[i].tmp3 + 0.2*(parts[i].tmp2/parts[i].tmp);
	}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS) //Flare when activated.
{
	if (cpart->life == 10)
	{
		ren->BlendEllipse(Vec2((int)(cpart->x), (int)(cpart->y)),Vec2(4, 4),RGBA<uint8_t>(255, 100, 0, 255));
		*pixel_mode |= PMODE_LFLARE;
	}
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS) //Default range and ctype settings.
{
	sim->parts[i].tmp = 10;
	sim->parts[i].ctype = PT_BOMB;
}

static bool ctypeDraw(CTYPEDRAW_FUNC_ARGS) //For enabling ctype Draw.
{
	if (!Element::ctypeDrawVInCtype(CTYPEDRAW_FUNC_SUBCALL_ARGS))
	{
		return false;
	}
	if (t == PT_LIGH)
	{
		sim->parts[i].ctype |= PMAPID(30);
	}
	return true;
}
