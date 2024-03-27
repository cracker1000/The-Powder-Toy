#include "simulation/ToolCommon.h"

#include "common/tpt-rand.h"
#include <cmath>

static int perform(Simulation * sim, Particle * cpart, int x, int y, int brushX, int brushY, float strength);

void SimTool::Tool_LEVI()
{
	Identifier = "DEFAULT_TOOL_LEVI";
	Name = "LEVI";
	Colour = 0x808080_rgb;
	Description = "Levitates particles in the air.";
	Perform = &perform;
}

static int perform(Simulation * sim, Particle * cpart, int x, int y, int brushX, int brushY, float strength)
{
	auto &sd = SimulationData::CRef();
	auto &elements = sd.elements;
	int thisPart = sim->pmap[y][x];
	if(!thisPart)
		return 0;

	if(!(elements[TYP(thisPart)].Properties & (TYPE_PART | TYPE_LIQUID | TYPE_GAS)))
		return 0;

	int newX = x + brushX;
	int newY = y + brushY;
if(newX < 0 || newY < 0 || newX >= XRES || newY >= YRES)
{
	if (cpart->y > newY)
{
	cpart->vy = strength*.3f;;
}
else if (cpart->y < newY)
{
	cpart->vy = -1*(strength*.3f);
}
}
	return 1;
}
