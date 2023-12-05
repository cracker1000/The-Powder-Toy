#include "simulation/ElementCommon.h"
#include "simulation/Air.h"

static int update(UPDATE_FUNC_ARGS);
static int graphics(GRAPHICS_FUNC_ARGS);
static void create(ELEMENT_CREATE_FUNC_ARGS);

constexpr int AlmpBurnHealth = 40;

// Element overview:
// ALMP is the broken version of ALUM. Primarily meant to be used as a pyrotechnic powder.
// When ignited, it burns brilliantly, sending sparks and bits of burning powder in all directions.

// Its properties are used as follows:
// tmp: The number of sparks/fire that it can create before it dies.
// tmp2: Grain/sparkle effect.

void Element::Element_ALMP()
{
	Identifier = "DEFAULT_PT_ALMP";
	Name = "ALMP";
	Colour = 0x87A4AF_rgb;
	MenuVisible = 1;
	MenuSection = SC_EXPLOSIVE;
	Enabled = 1;

	Advection = 0.4f;
	AirDrag = 0.04f * CFDS;
	AirLoss = 0.94f;
	Loss = 0.92f;
	Collision = -0.1f;
	Gravity = 0.1f;
	Diffusion = 0.00f;
	HotAir = 0.000f	* CFDS;
	Falldown = 1;

	Flammable = 0;
	Explosive = 0;
	Meltable = 1;
	Hardness = 10;
	PhotonReflectWavelengths = 0x3FFFFFC0;

	Weight = 90;

	HeatConduct = 70;
	Description = "Aluminium powder. Flammable, burns with brilliant sparks.";

	Properties = TYPE_PART|PROP_SPARKSETTLE;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = IPH;
	HighPressureTransition = NT;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = ITH;
	HighTemperatureTransition = NT;

	DefaultProperties.tmp = 40;

	Update = &update;
	Graphics = &graphics;
	Create = &create;
}

static int update(UPDATE_FUNC_ARGS)
{
	// Oxidized aluminium powder is less reactive.
	// Should this be turned into a different element in the future? (aluminium oxide)
	if (parts[i].ctype != PT_O2)
	{
		if (parts[i].tmp >= AlmpBurnHealth)
		{
			for (int rx = -1; rx <= 1; rx++)
			{
				for (int ry = -1; ry <= 1; ry++)
				{
					if (rx || ry)
					{
						int r = pmap[y+ry][x+rx];
						if (!r)
							continue;
						if (TYP(r) == PT_FIRE || TYP(r) == PT_PLSM || TYP(r) == PT_SPRK || TYP(r) == PT_LIGH)
						{
							parts[i].tmp = AlmpBurnHealth - sim->rng.between(1, 10);
						}
					}
				}
			}
		} else if (parts[i].tmp <= 0) {
			sim->create_part(i, x, y, PT_FIRE);
			sim->pv[y / CELL][x / CELL] += 2;
			return 1;
		} else if (parts[i].tmp < AlmpBurnHealth && sim->rng.chance(1, 2)) { // Erratic burning pattern
			parts[i].tmp--;
			if (sim->rng.chance(2, 3))
			{
				sim->pv[y / CELL][x / CELL] += 0.2f;
				int p = sim->create_part(-1, x + sim->rng.between(-1, 1), y + sim->rng.between(-1, 1), PT_EMBR);
				parts[p].tmp = 0;
				parts[p].life = 50;
				parts[p].vx = float(sim->rng.between(-4, 4));
				parts[p].vy = float(sim->rng.between(-4, 4));
			}
			else
			{
				sim->create_part(-1, x + sim->rng.between(-1, 1), y + sim->rng.between(-1, 1), PT_FIRE);
			}
		}
	}
	else
	{
		// Aluminium oxide can be melted back into aluminium
		if (parts[i].temp > 2072.0f + 273.15f)
		{
			sim->part_change_type(i,x,y,PT_LAVA);
			parts[i].ctype = PT_ALUM;
			parts[i].tmp = 0;
			parts[i].tmp2 = 0;
			parts[i].tmp3 = 0;
			return 1;
		}
	}
	return 0;
}

static int graphics(GRAPHICS_FUNC_ARGS)
{
	// Spörkle
	int z = (cpart->tmp2) * 10 - 18;

	if (cpart->ctype == PT_O2)
	{
		z /= 2;
		z += 20;
	}
	*colr += z;
	*colg += z;
	*colb += z;

	if (cpart->ctype == PT_O2)
	{
		return 0;
	}

	if (ren->rng.chance(1, 6))
	{
		*pixel_mode |= PMODE_SPARK;
	}
	float s = sqrt(pow(cpart->vx, 2) + pow(cpart->vy, 2));
	if (cpart->tmp2 + 1 < s)
	{
		*pixel_mode |= PMODE_FLARE;
	}
	return 0;
}

static void create(ELEMENT_CREATE_FUNC_ARGS)
{
	sim->parts[i].tmp2 = sim->rng.between(0, 6);
}
