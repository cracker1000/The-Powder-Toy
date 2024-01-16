#include "simulation/ElementCommon.h"
static int update(UPDATE_FUNC_ARGS);

void Element::Element_STRC()
{
	Identifier = "DEFAULT_PT_STRC";
	Name = "STRC";
	Colour = 0x606060_rgb;
	MenuVisible = 1;
	MenuSection = SC_SOLIDS;
	Enabled = 1;

	// element properties here
	Advection = 0.0f;
	AirDrag = 0.00f * CFDS;
	AirLoss = 0.90f;
	Loss = 0.00f;
	Collision = 0.0f;
	Gravity = 0.0f;
	Diffusion = 0.00f;
	HotAir = 0.000f * CFDS;
	Falldown = 0;

	Flammable = 0;
	Explosive = 0;
	Meltable = 0;
	Hardness = 1;

	Weight = 100;

	HeatConduct = 251;
	Description = "Structure. Without support will collapse. Only solids and CNCT support it. Tmp2 sets max overhang length.";

	Properties = TYPE_SOLID | PROP_HOT_GLOW;

	LowPressure = IPL;
	LowPressureTransition = NT;
	HighPressure = 8.8f;
	HighPressureTransition = PT_STNE;
	LowTemperature = ITL;
	LowTemperatureTransition = NT;
	HighTemperature = 1223.0f;
	HighTemperatureTransition = PT_LAVA;

	Update = &update;	
}


constexpr int miscSideSupport = 2; //support provided by other elements from the sides
constexpr int defaultSupportStrenght = 10;

static Particle* getNeighbor(Simulation* sim, int x, int y)
{
	Particle* part = nullptr;
	int pId = sim->pmap[y][x];
	if (pId)
	{
		part = &sim->parts[ID(pId)];
		if (part->type == 0)
			return nullptr;

		//Only solids can support a structure
		if (
			!(sim->elements[TYP(pId)].Properties & TYPE_SOLID)
			&&
			part->type != PT_CNCT//Except for cnct
		   ) 
			return nullptr;		

	}

	return part;
}

static void collapse(Particle* self)
{
	//This delays the collapse upon creation so all particles can update (cause particle update order)
	if (self->tmp3 < defaultSupportStrenght)
		return;
	
	self->type = PT_STNE;
}

static int evaluateDistance(Particle* neighbor,Simulation* sim)
{
	int distance;

	if (neighbor->type != PT_STRC)
	{
		int pId = sim->pmap[(int)neighbor->y][(int)neighbor->x];
		if (sim->elements[TYP(pId)].Properties & TYPE_SOLID)
			distance = miscSideSupport;
		else
			distance = 0;
	}
	else
		distance = neighbor->tmp2;

	return distance;
}

static void checkSupport(Particle* neighbor,Particle* self,Simulation* sim)
{
	int distance = evaluateDistance(neighbor,sim);	

	if (distance > 0)
		self->tmp2 = distance - 1;
	else
		collapse(self);
}

static int update(UPDATE_FUNC_ARGS)
{
	Particle* top, * bottom, * left, * right;

	top		= getNeighbor(sim, x, y - 1);
	bottom	= getNeighbor(sim, x, y + 1);
	left	= getNeighbor(sim, x - 1, y);
	right	= getNeighbor(sim, x + 1, y);

	if (bottom != nullptr)
	{
		if (parts[i].tmp == 0)
		{
			parts[i].tmp = defaultSupportStrenght;
			parts[i].tmp2 = parts[i].tmp;
		}
	}
	else if (left != nullptr && right != nullptr)
	{
		int leftSupport = evaluateDistance(left,sim);
				
		int rightSupport = evaluateDistance(right, sim);;

		int distance = std::max(leftSupport, rightSupport);
		
		if (distance > 0)
			parts[i].tmp2 = distance - 1;
		else
			collapse(&parts[i]);
	}
	else if (left != nullptr)
	{
		checkSupport(left, &parts[i],sim);
	}
	else if (right != nullptr)
	{
		checkSupport(right, &parts[i],sim);
	}
	else
		collapse(&parts[i]);

	if (parts[i].tmp3 < defaultSupportStrenght)
		parts[i].tmp3 += 1;

	return 0;
}
