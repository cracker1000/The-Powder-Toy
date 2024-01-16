#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

void Element::Element_CEXP()
{
	Identifier = "DEFAULT_PT_CEXP";
	Name = "CEXP";
	Colour = 0xFFA500_rgb;
	MenuVisible = 1;
	MenuSection = SC_EXPLOSIVE;
	Enabled = 1;

	Advection = 0.0f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 0.95f;
	Loss = 0.00f;
	Collision = 0.0f;
	Gravity = 0.0f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 10;
	Weight = 100;
	PhotonReflectWavelengths = 0xFF6347;

	HeatConduct = 0;
	Description = "Custom explosive. Temp. = Temp upon explosion, Life = Pressure it creates, tmp = gravity. ctype = exploding element.";

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
}
static int update(UPDATE_FUNC_ARGS)
{
	for (auto rx = -2; rx <= 2; rx++)
		{
			for (auto ry = -2; ry <= 2; ry++)
			{
				if (rx || ry)
				{
					auto r = pmap[y + ry][x + rx];
					if (!r)
						r = sim->photons[y + ry][x + rx];
					if (!r)
						continue;
				{
				if (parts[ID(r)].type == PT_SPRK||parts[ID(r)].type == PT_FIRE||parts[ID(r)].type == PT_PLSM||parts[ID(r)].type == PT_THDR||parts[ID(r)].type == PT_LIGH)
				{
                 parts[i].tmp2 = 10;
				}
				
				if(parts[ID(r)].type== PT_CEXP && parts[ID(r)].tmp2 > 0)
				{
				parts[i].tmp2 = 10;
				sim->flood_prop(x, y, Particle::GetProperties()[FIELD_TMP2], 10);
				}
				
				if (parts[i].tmp2 > 0)
				{
					sim->pv[(y / CELL) + ry][(x / CELL) + rx] = (float)(parts[i].life);
					sim->hv[(y / CELL) + ry][(x / CELL) + rx] = parts[i].temp;
					sim->gravmap[(y/CELL)*XCELLS+(x/CELL)] = parts[i].tmp;
					parts[ID(r)].temp = parts[i].temp;
					sim->part_change_type(i, x, y, parts[i].ctype);
				}
				}
				}
				}
				}
				return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].temp = 9720;
	sim->parts[i].ctype = PT_PLSM;
	sim->parts[i].tmp = 100;
	sim->parts[i].life = 256;
}
