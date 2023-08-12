--Cracker1000 mod interface script--
local passreal = "12345678"
local crackversion = 55.0 --Next version: 55.1 
local passreal2 = "DMND"
local motw = "."
local specialmsgval = 0
local dr, dg, db, da, defaulttheme = 131,0,255,255, "Default"

--TOOL for MISL
local MISLT = elem.allocate("CR1K", "MIST")
local tcount, posxt, posyt = 0,0,0
elem.element(MISLT, elem.element(elem.DEFAULT_PT_DMND))
elem.property(MISLT, "Name", "MIST")
elem.property(MISLT, "Properties", elem.PROP_NOCTYPEDRAW)
elem.property(MISLT, "Description", "Missile Target Tool. Click once to place the holder and then click again to set the target. Places one at a time.")
elem.property(MISLT, "Color", 0xFFA500)
elem.property(MISLT, "MenuSection", elem.SC_TOOL)
elem.property(MISLT, "Update", function (i)
if tonumber(sim.elementCount(elem.CR1K_PT_MIST)) > 1 then
sim.partKill(i)
elseif tonumber(sim.elementCount(elem.CR1K_PT_MIST)) < 2 then
posxt = tpt.get_property("x",i)
posyt = tpt.get_property("y",i)
end
function setcoord()
pcall(tpt.set_property, "tmp", tpt.mousex, i)
pcall(tpt.set_property, "tmp2", tpt.mousey, i)
pcall(tpt.set_property, "type",228,i)
print("Target set ("..tpt.mousex..", "..tpt.mousey..")")
end
function setcoord2()
sim.partKill(i)
print("Cancelled!")
end
if tcount == 0 then
event.unregister(event.tick,setmistgraph)
event.unregister(event.mousedown,setmist)
event.register(event.tick,setmistgraph)
event.register(event.mousedown,setmist)
end
end)

function setmistgraph()
gfx.drawLine(posxt,posyt,tpt.mousex,tpt.mousey,255,9,9,200)
gfx.drawText(tpt.mousex - 30,tpt.mousey + 20,"MISL Target Mode")
gfx.drawText(10,370,"Click where you want to place the MISL target. Right click to cancel.",32,216,255,255)
end

function setmist(x,y,button)
tcount = tcount + 1
if button == 3 then
setcoord2()
event.unregister(event.tick,setmistgraph)
event.unregister(event.mousedown,setmist)
tcount = 0
else
if tcount == 1 then
setcoord()
event.unregister(event.tick,setmistgraph)
event.unregister(event.mousedown,setmist)
tcount = 0
end
end
return false
end
--TOOL end
local Exitplne = Button:new(10,295,20,12, "X", "Disable Space ship")
local PLNEBST = Button:new(55,295,20,12, "BST", "Toggle Booster.")
local planebwd = Button:new(10,322,20,15, "Ul", "Move Up + Left")
local planebwa = Button:new(56,322,20,15, "Ur", "Move Up + Right")
local planebcharge = Button:new(10,358,20,15, "Chrg", "Recharge.")
local planebExpl = Button:new(56,358,20,15, "Exp", "Explode")

local planebw = Button:new(33,322,20,15, "^", "Move Up")
local planebd = Button:new(57,340,15,15, ">", "Move Right")
local planeba = Button:new(13,340,15,15, "<", "Move Left")
local planebs = Button:new(33,358,20,15, "V", "Move Down")
local planebst = Button:new(30,340,25,15, "Stop", "Stop")
local planemoveval, Plx, Ply, PLNEFUEL, PLNEBOOST = 0,0,0,4000,0

planebcharge:action(function(sender)
if PLNEFUEL < 4000 then
PLNEFUEL = PLNEFUEL + 50
end
end)

PLNEBST:action(function(sender)
if PLNEBOOST == 0 then
PLNEBOOST = 1
elseif PLNEBOOST == 1 then
PLNEBOOST = 0
end
end)

planebExpl:action(function(sender)
Explode()
event.unregister(event.tick,plnegraphics)
interface.removeComponent(PLNEBST )
interface.removeComponent(planebcharge)
interface.removeComponent(planebExpl)
interface.removeComponent(planebwd)
interface.removeComponent(planebwa)
interface.removeComponent(planebd)
interface.removeComponent(planeba)
interface.removeComponent(planebw)
interface.removeComponent(planebs)
interface.removeComponent(planebst)
interface.removeComponent(Exitplne)
end)

planebwd:action(function(sender)
planemoveval = 7
end)
planebwa:action(function(sender)
planemoveval = 6
end)
planebd:action(function(sender)
planemoveval = 5
end)
planeba:action(function(sender)
planemoveval = 4
end)
planebw:action(function(sender)
planemoveval = 3
end)
planebs:action(function(sender)
planemoveval = 2
end)
planebst:action(function(sender)
planemoveval = 0
end)

Exitplne:action(function(sender)
deletespsh()
event.unregister(event.tick,plnegraphics)
interface.removeComponent(PLNEBST)
interface.removeComponent(planebcharge)
interface.removeComponent(planebExpl)
interface.removeComponent(planebwd)
interface.removeComponent(planebwa)
interface.removeComponent(planebd)
interface.removeComponent(planeba)
interface.removeComponent(planebw)
interface.removeComponent(planebs)
interface.removeComponent(planebst)
interface.removeComponent(Exitplne)
end)

--Plane element
local PLNE = elem.allocate("CR1K", "PLNE")
elem.element(PLNE, elem.element(elem.DEFAULT_PT_EQVE))
elem.property(PLNE, "Name", "SPSH")
elem.property(PLNE, "Properties", elem.PROP_NOCTYPEDRAW)
elem.property(PLNE, "Description", "Space ship. Flies with the on screen controller.")
elem.property(PLNE, "Color", 0xAAAAA0)
elem.property(PLNE, "MenuSection", elem.SC_SPECIAL)
elem.property(PLNE, "MenuVisible", 1)
elem.property(PLNE, "Update", function (i)
Plx = tpt.get_property("vx",i)
Ply = tpt.get_property("vy",i)
Plosx = tpt.get_property("x",i)
Plosy = tpt.get_property("y",i)
function deletespsh()
sim.partKill(i)
end
if tonumber(sim.elementCount(elem.CR1K_PT_PLNE)) > 1 then
sim.partKill(i)
end
addbuttons()
function Explode()
pcall(tpt.set_property, "temp", 1131, i)
pcall(tpt.set_property, "tmp", 999, i)
pcall(tpt.set_property, "type", 131, i)
end

function moveplne()
if tonumber(sim.elementCount(elem.CR1K_PT_PLNE)) < 2 then
if PLNEFUEL > 100 and planemoveval ~= 0 then
if PLNEBOOST == 0 then
PLNEFUEL = PLNEFUEL - 1
elseif PLNEBOOST == 1 then
PLNEFUEL = PLNEFUEL - 4
end
end
if PLNEFUEL > 4000 then
PLNEFUEL = 4000
end
if tpt.get_property("x",i) > 605 then
pcall(tpt.set_property, "x", 600, i)
elseif tpt.get_property("x",i) < 15 then
pcall(tpt.set_property, "x", 16, i)
end
if tpt.get_property("y",i) > 368 then
pcall(tpt.set_property, "y", 367, i)
elseif tpt.get_property("y",i) < 15 then
pcall(tpt.set_property, "y", 16, i)
end
if PLNEFUEL/10 > 10 then
local Movespeed = 0.2
if PLNEBOOST == 1 then
Movespeed = 0.6
elseif  PLNEBOOST == 0 then
Movespeed = 0.2
end
if planemoveval == 5 then
pcall(tpt.set_property, "vx", Plx  + Movespeed, i) --Right
elseif planemoveval == 4 then
pcall(tpt.set_property, "vx", Plx  - Movespeed, i) --Left
elseif planemoveval == 3 then
pcall(tpt.set_property, "vy", Ply  - Movespeed, i) --Up
elseif planemoveval == 2 then
pcall(tpt.set_property, "vy", Ply  + Movespeed, i) --Down
elseif planemoveval == 6 then
pcall(tpt.set_property, "vx", Plx  + Movespeed, i) -- UP + RIGHT
pcall(tpt.set_property, "vy", Ply  - Movespeed, i) 
elseif planemoveval == 7 then
pcall(tpt.set_property, "vx", Plx  - Movespeed, i) -- UP + LEFT
pcall(tpt.set_property, "vy", Ply  - Movespeed, i) 
end
end
end
end
moveplne()
event.unregister(event.tick,plnegraphics)
event.register(event.tick,plnegraphics)
end)
function addbuttons()
tpt.selectedl = "DEFAULT_PT_SPRK"
interface.addComponent(planebcharge)
interface.addComponent(PLNEBST)
interface.addComponent(planebExpl)
interface.addComponent(planebwd)
interface.addComponent(planebwa)
interface.addComponent(planebd)
interface.addComponent(planeba)
interface.addComponent(planebw)
interface.addComponent(planebs)
interface.addComponent(planebst)
interface.addComponent(Exitplne)
end

function plnegraphics()
if PLNEBOOST == 1 then
gfx.fillRect(45,298,6,6,0,255,0,255)
else
gfx.fillRect(45,298,6,6,255,0,0,255)
end
gfx.drawRect(7,292,72,85,32,216,255,255)
gfx.fillRect(7,292,72,85,10,10,10,50)
if tonumber(sim.elementCount(elem.CR1K_PT_PLNE)) > 0 then
gfx.fillRect(14,308,60,12,10,10,10,100)
if PLNEFUEL/10 >= 200 then
gfx.drawText(19,310,"Fuel: "..PLNEFUEL/10,55,255,55,255)
elseif PLNEFUEL/10 < 200 and PLNEFUEL/10 >= 100 then
gfx.drawText(19,310,"Fuel: "..PLNEFUEL/10,255,255,255,255)
elseif PLNEFUEL/10 < 100 and PLNEFUEL/10 > 10 then
gfx.drawText(19,310,"Fuel: "..PLNEFUEL/10,255,55,55,255)
elseif PLNEFUEL/10 <= 10 then
gfx.drawText(17,310,"Fuel: Empty",255,55,55,255)
end
if planemoveval ~= 0 and PLNEFUEL/10 > 10 then
if PLNEBOOST == 1 then
gfx.fillCircle(Plosx,Plosy+6,2,3,255,255,0,255)
elseif  PLNEBOOST == 0 then
gfx.fillCircle(Plosx,Plosy+6,2,3,131,0,255,255)
end
end
gfx.fillRect(Plosx-3,Plosy,8,2,255,55,55,255)
gfx.fillCircle(Plosx,Plosy-3,3,3,55,55,255,255)
gfx.drawCircle(Plosx,Plosy-3,3,3,255,255,255,255)
else
gfx.drawText(16,310,"Signal lost",255,55,55,255)
end
end 
--PLNE END
--Default theme for initial launch and resets
if MANAGER.getsetting("CRK", "pass") == "1" then
local passmenu = Window:new(200,150, 200, 100)
local passok = Button:new(110,75,80,20,"Enter", "Hide.")
local passok2 = Button:new(10,75,80,20,"Forgot", "Enter Elem.")
local passok4 = Button:new(12,105,175,15,"Message here if problem persists", "Open Mod thread")
local passok3 = Button:new(178,1,20,20,"X", "Close.")
local passtime = Textbox:new(70, 30, 55, 20, '', 'Password..')
local par,pag,pab = 80,250,0
local passmesg = "Enter password to continue."
function passglit()
graphics.drawText(230,160,passmesg, par,pag,pab,255)
ui.showWindow(passmenu)
end

passmenu:onDraw(passglit)
passmenu:addComponent(passok)
passmenu:addComponent(passok2)
passmenu:addComponent(passok3)
passmenu:addComponent(passtime)
tpt.register_step(passglit)

passok:action(function(sender)
if passtime:text() == MANAGER.getsetting("CRK", "passreal") or passtime:text() == "xkcd-xyza" or passtime:text() == MANAGER.getsetting("CRK", "passreal2")   then
tpt.unregister_step(passglit)
ui.closeWindow(passmenu)
else 
par,pag,pab = 255,0,0
passmesg = "     Wrong, try again!"
passtime:text("")
end
passmenu:removeComponent(passok4)
end)

passok2:action(function(sender)
passmenu:addComponent(passok4)
par,pag,pab = 80,250,0
passmesg = "Enter your favourite element"
passtime:text("")
end)
passok3:action(function(sender)
tpt.unregister_step(passglit)
os.exit()
end)
passok4:action(function(sender)
platform.openLink("https://powdertoy.co.uk/Discussions/Thread/View.html?Thread=23279")
end)
end

local toggle = Button:new(419,408,50,15, "Cr-Menu", "Open Mod Settings.")
local newmenu = Window:new(-15,-15, 609, 255)

local deletesparkButton =  Button:new(10,28,80,25,"Focus Mode", "shows UI related stuff.")

local FPS = Button:new(10,60,80,25, "Frame limiter", "Turns the frame limiter on/off.")

local reset = Button:new(10,92,80,25,"Reset", "Reset.")

local info = Button:new(10,124,80,25,"Stack tools", "Usefull for subframe.")

local Ruler = Button:new(10,156,80,25, "Ruler", "Toggles in game ruler.")

local bar = Button:new(10,188,80,25,"Auto Save", "Toggle Auto stamp.")
local stamplb = "0"

local bug = Button:new(10,220,80,25,"Feedback", "Direct to Mod thread for bug report.")
local bug1 = Button:new(100,220,45,25,"Website", "Direct to Mod thread for bug report.")
local bug2 = Button:new(148,220,45,25,"In game", "Direct to Mod thread for bug report.")

local wiki  =  Button:new(203,28,80,25,"Wiki", "Element wiki!")

local bare = Button:new(203,60,80,25,"Hidden Elem.", "Toggle hidden elements.")

local bg = Button:new(203,92,80,25,"Mod Elem.", "")

local mp = Button:new(203,124,80,25,"Control Centre", "Changes game's theme")

local autohide = Button:new(203,156,80,25, "Auto Hide HUD", "Hide.")

local chud = Button:new(203,188,80,25, "Texter", "for text.")

local brightness = Button:new(203,220,80,25, "Brightness", "Adjust brightness.")
local brightSlider = Slider:new(310,220,80,27, 255)
local brop = Button:new(313,202,32,15,"On", "Save.")
local bropc = Button:new(355,202,32,15,"Off", "Cancel.")
local brlabel2 = Label:new(344, 225, 10, 15, "("..brightSlider:value()..")")

local Help = Button:new(396,60,80,25, "Random save", "Opens random save.")

local shrtpre = Button:new(396,92,80,25, "Invert-tool", "Selects opposite tool")

local edito = Button:new(396,124,80,25, "Editor", "Basic element editor.")

local perfm = Button:new(396,156,80,25, "Performance", "For lower spec systems.")

local passbut = Button:new(396,188,80,25, "Password", "Secure password protection.")

local reminder = Button:new(396,220,80,25, "Notifications", "Maticzpl's notification stuff")
local reminderhelp = Button:new(506,224,15,15, "?", "Help")

local upmp = Button:new(396,28,80,25, "Startup Elem.", "Update multiplayer")

local hide= Button:new(578,5,25,25, "X", "Hide.")

--Varoius Variables
local borderval = "0"
local rulval = "1"
local timermp = 0
local filterval = 0
local perfmv = "1"
local fpsval = "1"
local startTime
local entimey
local endTime = 0
local autoval = "1"
local hidval = "1"
local shrtv = "1"
local nmodv = "0"
local invtoolv = "1"
local focustime = 190

function clearm()
newmenu:removeComponent(reset)
newmenu:removeComponent(FPS)
newmenu:removeComponent(deletesparkButton)
newmenu:removeComponent(hide)
newmenu:removeComponent(info)
newmenu:removeComponent(Ruler)
newmenu:removeComponent(mp)
newmenu:removeComponent(bg)
newmenu:removeComponent(bug)
newmenu:removeComponent(bar)
newmenu:removeComponent(bare)
newmenu:removeComponent(wiki)
newmenu:removeComponent(autohide)
newmenu:removeComponent(chud)
newmenu:removeComponent(brightness)
newmenu:removeComponent(reminder)
newmenu:removeComponent(Help)
newmenu:removeComponent(shrtpre)
newmenu:removeComponent(edito)
newmenu:removeComponent(perfm)
newmenu:removeComponent(passbut)
newmenu:removeComponent(upmp)
newmenu:removeComponent(reminderhelp)
end

function clearsb()
newmenu:removeComponent(bug1)
newmenu:removeComponent(bug2)
newmenu:removeComponent(brop)
newmenu:removeComponent(bropc)
newmenu:removeComponent(brlabel2)
newmenu:removeComponent(brightSlider)
end

local req2 = http.get("https://pastebin.com/raw/9yJRRimM")
local timermotd = 0
local posix = 0
local onlinestatus = 0 
--URS Updater
local updatever, updatestatus = crackversion,0
local updatertext = "is available, click to download"
local reqwin --Defined later on when updater runs.
local crdata = "Something went wrong. Can't show the changelogs."
local updatetimer = 0
local checkos, clickcheck = platform.platform(), 0
local errtext = "URS updater: checking for updates.."
local timeout = 0
local errorcode = "No error to report"
local appname = "powder"

function updatermod()
updatetimer = updatetimer + 1
if updatetimer >= 3500 then
if checkos ~= "MACOSARM" and checkos ~= "MACOSX" then
timeout = 1
errorcode = "Network connection is too slow."
end
end
--Get changelogs
if crlog:status() == "done"  then
local crlogdata, crlogcode = crlog:finish()
if crlogcode == 200 then
crdata = crlogdata
end
end
local filesize, filedone = reqwin:progress()
local downprog = math.floor((filedone/filesize)*100)
if checkos ~= "MACOSARM" and checkos ~= "MACOSX" then
gfx.fillRect(10,367,downprog*2,12,32,216,255,120)
gfx.drawText(100,344,downprog.."%",32,216,255,255)
updatertext = "Updating the mod"
if reqwin:status() == "done" then
local reqwindata, reqwincode = reqwin:finish()
event.unregister(event.tick,updatermod)
if reqwincode == 200 then
os.remove("oldmod")--Delete the oldmod file
local oldName = platform.exeName()
os.rename(oldName,"oldmod")
updatertext = "Renaming files.."
errorcode = "Error while renaming files.."
local fupdate = io.open(oldName, 'wb')
fupdate:write(reqwindata)
fupdate:close()
updatertext = "Done, click to restart."
errorcode = "No error to report"
clickcheck = 1
else
timeout = 1
updatertext = "Click for manual download."
errorcode = reqwincode
end
end
else
updatertext = "Click for manual download."
end
end

function clicktomsg2() --Respond to or block clicks when updater is running. 
if tpt.mousex > 10 and tpt.mousex < 204 and tpt.mousey > 367 and tpt.mousey < 380 then
if updatertext == "Click for manual download." then -- Manual download
platform.openLink("https://powdertoy.co.uk/Discussions/Thread/View.html?Thread=23279")
return false
end
if clickcheck == 0 then
clickcheck = 2
crlog = http.get("https://raw.githubusercontent.com/cracker1000/The-Powder-Toy/master/Full%20changelog.txt")
if checkos == "WIN64" then
reqwin = http.get("https://github.com/cracker1000/The-Powder-Toy/releases/download/Latest/"..appname..".exe")
elseif checkos == "LIN64" then
reqwin = http.get("https://github.com/cracker1000/The-Powder-Toy/releases/download/Latest/"..appname)
elseif checkos == "WIN32" then
reqwin = http.get("https://github.com/cracker1000/The-Powder-Toy/releases/download/Latest/"..appname.."32.exe")
elseif checkos == "MACOSARM"  or checkos == "MACOSX" then
reqwin = http.get("https://github.com/cracker1000/The-Powder-Toy/releases/download/Latest/"..appname..".dmg")
errorcode = "MAC OS does't support fully automatic updates."
end
event.unregister(event.tick,updatermod)
event.register(event.tick,updatermod)
event.unregister(event.keypress,keyclicky)
event.unregister(event.mousedown, clicktomsg)
event.unregister(event.tick,showmotdnot)
elseif clickcheck == 1 then
platform.restart()
end
return false
end
if clickcheck == 0 then
if tpt.mousex > 209 and tpt.mousex < 221 and tpt.mousey > 367 and tpt.mousey < 380 then -- Cancel the update
updatestatus = 1
event.unregister(event.mousedown, clicktomsg2)
event.unregister(event.tick, showmotdnot2)
event.unregister(event.tick,updatermod)
return false
end
end
if clickcheck ~= 0 then --Changelogs
if tpt.mousex > 299 and tpt.mousex < 386 and tpt.mousey > 284 and tpt.mousey < 296 then
tpt.confirm("URS updater changelog. Your version: v."..crackversion,crdata, "Done reading")
end
return false
end
end

function showmotdnot2() --Draw graphics when updater is running. 
if clickcheck ~= 0 then
gfx.fillRect(5,262,600,123,10,10,10,200) --Window space fill
gfx.drawRect(5,262,600,123,190,190,190,255) --Window border
if updatertext == "Done, click to restart." then
gfx.drawText(100,344,"Completed Successfully.",55,255,55,255) -- When Completed
gfx.drawRect(10,360,590,2,10,250,10,255)
else
if timeout == 1 and clickcheck ~= 1 then --When Error
gfx.drawText(300,369,"Report the above error code in mod thread.",255,10,10,255)
gfx.drawRect(10,360,590,2,255,55,55,255)
else
gfx.drawRect(10,360,590,2,32,216,255,255) --Normal
end
end
--System and URS info:
gfx.drawText(190,270,"Welcome to the Cracker1000 Mod's URS Updater",32,216,255)
gfx.drawText(10,284,"Platform detected: "..platform.platform())
gfx.drawText(300,344,"Error code: "..errorcode,255,35,35)
gfx.drawText(10,304,"Updating/ downgrading from")
gfx.drawText(142,304,"v."..crackversion.." to v."..updatever,32,216,255)
gfx.drawText(300,304,"Current Status: ")
gfx.drawText(374,304,updatertext.." ("..onlinestatus..")",32,216,255)
gfx.drawText(10,324,"Path to the mod: "..platform.exeName())
gfx.drawText(10,344,"Download progress:")
end
-- Hover effects for URS buttons
if tpt.mousex >10 and tpt.mousex < 205 and tpt.mousey > 367 and tpt.mousey < 380 then
gfx.fillRect(10,366,197,14,10,10,10,255)
gfx.fillRect(10,366,197,14,32,255,210,140)
else
gfx.fillRect(10,366,197,14,10,10,10,255)
gfx.fillRect(10,366,197,14,32,250,210,20)
end
if clickcheck ~= 0 then
--Changelog stuff
if tpt.mousex > 299 and tpt.mousex < 386 and tpt.mousey > 284 and tpt.mousey < 296 then
gfx.fillRect(300,284,87,14,10,10,10,255)
gfx.fillRect(300,284,87,14,255,216,32,140)
else
gfx.fillRect(300,284,87,14,10,10,10,255)
gfx.fillRect(300,284,87,14,255,216,32,30)
end
gfx.drawRect(300,284,87,14,255,216,32,100)
gfx.drawText(305,287,"Show Changelog*",255,216,32,255)
end
--end
gfx.drawRect(10,366,197,14,34,250,210,155)
gfx.drawText(13,370,"V."..tonumber(updatever).." "..updatertext,32,250,210,255)
if clickcheck == 0 then
if tpt.mousex >209 and tpt.mousex < 221 and tpt.mousey > 367 and tpt.mousey < 380 then
gfx.fillRect(208,366,14,14,250,50,50,150)
gfx.drawText(225,369,"Cancel the update",250,50,50,250)
else
gfx.fillRect(208,366,14,14,50,5,5,255)
gfx.fillRect(208,366,14,14,250,50,50,20)
end
gfx.drawRect(208,366,14,14,255,5,5,255)
gfx.drawText(212,369,"X",255,5,5,255)
end
end
--URS end
local errtimer = 0
function runupdater()
event.unregister(event.tick,errormesg)
event.unregister(event.tick,showmotdnot2)
event.register(event.tick,showmotdnot2)
event.unregister(event.mousedown, clicktomsg2)
event.register(event.mousedown, clicktomsg2)
end
function writefile2()
timermotd = timermotd + 1
if timermotd >= 250 then
event.unregister(event.tick,writefile2)
end
if req2:status() == "done" then
local ret2, code2 = req2:finish()
event.unregister(event.tick,writefile2)
if code2 == 200 then
onlinestatus = 1 
--Update checks
errtext = ""
updatever = string.sub(ret2,10,13)
if tonumber(crackversion) ~= tonumber(updatever)  then
runupdater()
elseif tonumber(crackversion) == tonumber(updatever) then
errtext = "URS Updater: Your mod is up to date."
end
else
if code2 == 602 then
errtext ="URS updater: offline"
else
onlinestatus = 3 --Something went wrong
errtext = "URS error code: "..code2
end
end
--specialmsg
specialmsgval = string.sub(ret2,31,32)
--Motd stuff
motw = string.sub(ret2,40,300)
if motw ~= "." and onlinestatus == 1 then
posix = graphics.textSize(motw)
if motw ~= MANAGER.getsetting("CRK","storedmotd") then
event.unregister(event.tick,showmotdnot)
event.register(event.tick,showmotdnot)
event.unregister(event.mousedown, clicktomsg)
event.register(event.mousedown, clicktomsg)
end
end
end
end

function errormesg()
errtimer = errtimer + 1
gfx.fillRect(7,367,graphics.textSize(errtext)+3,12,30,30,30,150)
if errtext ==  "URS Updater: Your mod is up to date." or errtext == "URS updater: checking for updates.." then
gfx.drawText(10,370,errtext,55,255,55,255)
else
gfx.drawText(10,370,errtext,255,55,55,255)
end
if errtimer >= 250 then
event.unregister(event.tick,errormesg)
end
end

function clicktomsg()
if tpt.mousex >389 and tpt.mousex < 528 and tpt.mousey > 365 and tpt.mousey < 379 then
open()
return false
end
end

function showmotdnot()
tpt.fillrect(390,365,138,14,10,10,10,250)
if tpt.mousex >389 and tpt.mousex < 528 and tpt.mousey > 365 and tpt.mousey < 379 then
tpt.fillrect(390,365,138,14,255,255,0,120)
else
tpt.fillrect(390,365,138,14,255,255,0,20)
end
tpt.drawrect(390,365,138,14,255,255,0,255)
tpt.drawrect(418,408,51,14,255-ar,255-ag,255-ab,255)
gfx.drawText(395,369,"New message, click to view.",245,225,0,255)
end

local function strtelemgraph()
gfx.fillRect(135,347,430,35,10,10,10,255)
gfx.drawRect(135,347,430,35,255,255,255,255)
gfx.drawText(140,350,"Please select the primary and secondary startup elements of your choice and click save.",255,255,255,255)
gfx.drawRect(255,362,30,15,225,225,225,255)
gfx.drawRect(305,362,64,15,225,225,225,255)

if tpt.mousex >255 and tpt.mousex < 285 and tpt.mousey > 362 and tpt.mousey < 377 then
tpt.fillrect(255,362,29,14,50,255,50,180)
end

if tpt.mousex >304 and tpt.mousex < 341 and tpt.mousey > 362 and tpt.mousey < 377 then
tpt.fillrect(305,362,37,14,200,200,200,180)
end

if tpt.mousex >341 and tpt.mousex < 368 and tpt.mousey > 362 and tpt.mousey < 377 then
tpt.fillrect(340,362,28,14,250,30,30,180)
end

gfx.drawText(260,366,"Save",225,225,225,255)
gfx.drawText(310,366,"Cancel | Off",225,225,225,255)
end

local function strtelem()
if tpt.mousex >255 and tpt.mousex < 285 and tpt.mousey > 362 and tpt.mousey < 377 then
MANAGER.savesetting("CRK","primaryele",tpt.selectedl)
MANAGER.savesetting("CRK","secondaryele",tpt.selectedr)
MANAGER.savesetting("CRK","loadelem","1")
event.unregister(event.tick,strtelemgraph)
event.unregister(event.mousedown,strtelem)
print("Startup elements configured succesfully. Primary: "..MANAGER.getsetting("CRK","primaryele").." and Secondary: "..MANAGER.getsetting("CRK","secondaryele"))
return false
end

if tpt.mousex >304 and tpt.mousex < 341 and tpt.mousey > 362 and tpt.mousey < 377 then
event.unregister(event.tick,strtelemgraph)
event.unregister(event.mousedown,strtelem)
print("Startup elements configuration cancelled.")
return false
end

if tpt.mousex >341 and tpt.mousex < 368 and tpt.mousey > 362 and tpt.mousey < 377 then
event.unregister(event.tick,strtelemgraph)
event.unregister(event.mousedown,strtelem)
MANAGER.savesetting("CRK","loadelem","0")
print("Startup elements configuration turned off")
return false
end
end
upmp:action(function(sender)
close()
event.unregister(event.tick,strtelemgraph)
event.register(event.tick,strtelemgraph)
event.unregister(event.mousedown,strtelem)
event.register(event.mousedown,strtelem)
end)

passbut:action(function(sender)
clearsb()
if MANAGER.getsetting("CRK", "passreal") == nil then
MANAGER.savesetting("CRK","passreal","12345678")
end

if MANAGER.getsetting("CRK", "passreal2") == nil then
MANAGER.savesetting("CRK","passreal2","DMND")
end

local passwordstatus = 0
function drawpassstat()
if MANAGER.getsetting("CRK", "pass") == "1" then
gfx.drawText(43,132,"Status: Running",105,255,105,255)
else
gfx.drawText(43,132,"Status: Turned Off",255,105,105,255)
end
end
local passmen = Window:new(-15,-15, 610, 255)
local pasmenmsg = Label:new(240,5,120, 10,"Welcome to the Password Manager V2.0")
local pasmenmsg2 = Label:new(165,130,120, 10,"Current Password: "..MANAGER.getsetting("CRK","passreal"))
local pasmenmsg6 = Label:new(365,130,120, 10,"Favorite element: "..MANAGER.getsetting("CRK","passreal2"))
local pasmenmsg3 = Label:new(308,40,120, 10,"Can be upto 8 character long, case sensitive, blank spaces also count.")
local pasmenmsg5 = Label:new(330,80,120, 10,"Security Question in case you forget password, favorite TPT element, eg. DMND.")
local pasmenmsg7 = Label:new(270,240,120, 10,"Password/ Fav. element can't be blank!")
local doned2 = Button:new(110,31,80,30, "Set password", "Save")
local doned3 = Button:new(525,237,80,15, "Close", "Close")
local doned4 = Button:new(40,155,90,20, "Password ON", "Save ON")
local doned5 = Button:new(40,185,90,20, "Password OFF", "Save OFF")
local doned7 = Button:new(40,215,90,20, "Reset", "Reset")
local doned6 = Button:new(110,71,80,30, "Set Element", "Save")
local passtime2 = Textbox:new(40, 30, 55, 30, '', 'Password..')
local passtime3 = Textbox:new(40, 70, 35, 30, '', 'Elem.')

ui.showWindow(passmen)
passmen:addComponent(pasmenmsg)
passmen:addComponent(pasmenmsg2)
passmen:addComponent(pasmenmsg3)
passmen:addComponent(pasmenmsg5)
passmen:addComponent(pasmenmsg6)
passmen:addComponent(doned2)
passmen:addComponent(doned3)
passmen:addComponent(doned4)
passmen:addComponent(doned5)
passmen:addComponent(doned6)
passmen:addComponent(doned7)
passmen:addComponent(passtime2)
passmen:addComponent(passtime3)

passmen:onDraw(drawpassstat)
doned2 :action(function(sender)
passmen:removeComponent(pasmenmsg7)
if passtime2:text() == "" then
passmen:addComponent(pasmenmsg7)
else
MANAGER.savesetting("CRK", "passreal",passtime2:text())
pasmenmsg2:text("Current Password: "..MANAGER.getsetting("CRK","passreal"))
end
end)
doned3 :action(function(sender)
ui.closeWindow(passmen)
end)

doned6 :action(function(sender)
passmen:removeComponent(pasmenmsg7)
if passtime3:text() == "" then
passmen:addComponent(pasmenmsg7)
else
MANAGER.savesetting("CRK", "passreal2",passtime3:text())
pasmenmsg6:text("Favorite element: "..MANAGER.getsetting("CRK","passreal2"))
end
end)

doned7 :action(function(sender)
MANAGER.savesetting("CRK", "pass","0")
MANAGER.savesetting("CRK", "passreal","12345678")
MANAGER.savesetting("CRK", "passreal2","DMND")
pasmenmsg2:text("Current Password: "..MANAGER.getsetting("CRK","passreal"))
pasmenmsg6:text("Favorite element: "..MANAGER.getsetting("CRK","passreal2"))
passtime2:text("")
passtime3:text("")
end)

doned3 :action(function(sender)
ui.closeWindow(passmen)
end)

doned4 :action(function(sender)
MANAGER.savesetting("CRK", "pass","1")
end)

doned5 :action(function(sender)
MANAGER.savesetting("CRK", "pass","0")
end)
end)

function inverttool()
local selc = tpt.selectedl
if selc == "DEFAULT_TOOL_HEAT" then
tpt.selectedr = "DEFAULT_TOOL_COOL"
elseif selc == "DEFAULT_TOOL_COOL" then
tpt.selectedr = "DEFAULT_TOOL_HEAT"
elseif selc == "DEFAULT_TOOL_AIR" then
tpt.selectedr = "DEFAULT_TOOL_VAC"
elseif selc == "DEFAULT_TOOL_VAC" then
tpt.selectedr = "DEFAULT_TOOL_AIR"
elseif selc == "DEFAULT_TOOL_PGRV" then
tpt.selectedr = "DEFAULT_TOOL_NGRV"
elseif selc == "DEFAULT_TOOL_NGRV" then
tpt.selectedr = "DEFAULT_TOOL_PGRV"
elseif selc == "DEFAULT_TOOL_AMBM" then
tpt.selectedr = "DEFAULT_TOOL_AMBP"
elseif selc == "DEFAULT_TOOL_AMBP" then
tpt.selectedr = "DEFAULT_TOOL_AMBM"
elseif selc == "DEFAULT_TOOL_AMBP" then
tpt.selectedr = "DEFAULT_TOOL_AMBM"
elseif selc == "DEFAULT_UI_WIND" then
tpt.selectedr = "DEFAULT_TOOL_CYCL"
elseif selc == "DEFAULT_TOOL_CYCL" then
tpt.selectedr = "DEFAULT_UI_WIND"
elseif selc == "DEFAULT_WL_ERASE" or selc == "DEFAULT_WL_DTECT" or selc == "DEFAULT_WL_CNDT" or selc == "DEFAULT_WL_EWALL" or selc == "DEFAULT_WL_STRM"  or selc == "DEFAULT_WL_FAN" or selc == "DEFAULT_WL_LIQD" or selc == "DEFAULT_WL_ABSRB" or selc == "DEFAULT_WL_WALL" or selc ==" DEFAULT_WL_AIR" or selc =="DEFAULT_WL_POWDR" or selc =="DEFAULT_WL_CNDTR" or selc =="DEFAULT_WL_EHOLE" or selc =="DEFAULT_WL_GAS" or selc =="DEFAULT_WL_GRVTY" or selc =="DEFAULT_WL_ENRGY" or selc =="DEFAULT_WL_NOAIR" or selc =="DEFAULT_WL_STASIS"  or selc =="DEFAULT_WL_CNDTW" then
tpt.selectedr = "DEFAULT_WL_ERASE"
else
tpt.selectedr = "DEFAULT_PT_NONE"
end
end

shrtpre:action(function(sender)
clearsb()
if invtoolv == "1" then
print("Invert-Tool: Automatically selects the opposite tool")
event.unregister(event.tick,inverttool)
event.register(event.tick,inverttool)
invtoolv = "0"
elseif invtoolv == "0" then
event.unregister(event.tick,inverttool)
invtoolv = "1"
end
end)

perfm:action(function(sender)
clearsb()
if perfmv == "1" then
tpt.setdrawcap(30)
event.unregister(event.tick,theme)
tpt.display_mode(7)
print("Themes are disabled because performance mode is on.")
perfmv = "0"
else
perfmv = "1"
tpt.setdrawcap(0)
event.unregister(event.tick,theme)
event.register(event.tick,theme)
tpt.display_mode(3)
end
end)

local savetime, maxpart1, maxpart2, maxpart3, maxpart4 = 0,0,0,0,0
function getmax()
maxpart1, maxpart2 = math.huge, math.huge
maxpart3, maxpart4  = -math.huge, -math.huge
for i in sim.parts() do 
maxpart1 = math.min(sim.partProperty(i,"x"),maxpart1)
maxpart2 = math.min(sim.partProperty(i,"y"),maxpart2)
maxpart3 = math.max(sim.partProperty(i,"x"),maxpart3)
maxpart4 = math.max(sim.partProperty(i,"y"),maxpart4)
end
end

function autosave()
if savetime < 350 then
savetime = savetime + 1
end
if savetime >= 340 then
graphics.drawRect(6,368,44,12,255,255,0,200)
graphics.fillRect(6,368,44,12,255,255,0,70)
end
if savetime >= 349 then
getmax()
sim.saveStamp(maxpart1,maxpart2,maxpart3-maxpart1,maxpart4-maxpart2)
savetime = 0
end
end

bar:action(function(sender)
clearsb()
if stamplb == "0" then
stamplb = "1"
event.unregister(event.tick,autosave)
event.register(event.tick,autosave)
elseif stamplb == "1" then
stamplb = "0"
event.unregister(event.tick,autosave)
end
end)

local stv, stackposx, stackposy, stackposval, zx, zy = 0, 99, 99, 0,0,0

function drawstack()
zx,zy = sim.adjustCoords(tpt.mousex,tpt.mousey)
gfx.fillRect(13,367,28,13,25,255,25,100)
if stv == 0 then
gfx.fillRect(13,367,28,13,25,255,25,100)
gfx.drawText(15,370,"Stack",255,255,255)
else
gfx.fillRect(13,367,28,13,255,0,0,170)
gfx.drawText(14,370,"<Off>",255,255,255)
end

gfx.fillRect(47,367,45,13,25,25,255,100)
gfx.drawText(50,370,"De-Stack",255,255,255)

gfx.fillRect(98,367,43,13,32,200,125,100)
gfx.drawText(100,370,"Top only",255,255,255)

gfx.fillRect(146,367,52,13,255,255,25,100)
gfx.drawText(148,370,"Stack pos.",255,255,255)

gfx.fillRect(204,367,23,13,255,25,25,100)
gfx.drawText(206,370,"Exit",255,255,255)

if stv == 1 then
gfx.drawText(tpt.mousex-30,tpt.mousey+14+tpt.brushy,"Stack mode on",98,248,98,200)
end

if stackposval == 1 then
if ren.zoomEnabled() then
gfx.drawLine(zx-7, zy,zx+7,zy,0,255,0,255)
gfx.drawLine(zx, zy-7,zx,zy+7,0,255,0,255)
else
gfx.drawLine(tpt.mousex-7, tpt.mousey,tpt.mousex+7,tpt.mousey,0,255,0,255)
gfx.drawLine(tpt.mousex, tpt.mousey-7,tpt.mousex,tpt.mousey+7,0,255,0,255)
end
end
gfx.drawLine(stackposx-5, stackposy,stackposx+5,stackposy,0,255,0,200)
gfx.drawLine(stackposx, stackposy-5,stackposx,stackposy+5,0,255,0,200)
end

function getclick()
if tpt.mousex >13 and tpt.mousex < 40 and tpt.mousey > 365 and tpt.mousey < 378 then
if stv == 1 then
stv = 0
print("Stack mode deactivated")
elseif stv == 0 then
stv = 1
tpt.brushID = 1
print("Click the particles under brush you want to stack")
end
return false
end

if tpt.mousex >204 and tpt.mousex < 226 and tpt.mousey > 365 and tpt.mousey < 378 then
event.unregister(event.mousedown,getclick)
event.unregister(event.tick,drawstack)
  	print("Stack mode turned OFF")
return false
end

if tpt.mousex >98 and tpt.mousex < 140 and tpt.mousey > 365 and tpt.mousey < 378 then
for i in sim.parts() do
		local x,y = sim.partProperty(i, sim.FIELD_X),sim.partProperty(i, sim.FIELD_Y)
		if sim.pmap(x, y) ~= i and sim.photons(x,y) ~= i then
			tpt.delete(i)
		end
	end
print("Removed all the particles except top one.")
return false
end

if tpt.mousex >147 and tpt.mousex < 197 and tpt.mousey > 365 and tpt.mousey < 380 then
stackposval = 1
print("Click where you want to stack the particles")
return false
end

if stackposval == 1 then
if ren.zoomEnabled() then
stackposx = zx
stackposy = zy
else
stackposx = tpt.mousex
stackposy = tpt.mousey
end
stackposval = 0
return false
end

if tpt.mousex >47 and tpt.mousex < 91 and tpt.mousey > 365 and tpt.mousey < 378 then
for i in sim.parts() do
		local x,y = sim.partProperty(i, sim.FIELD_X),sim.partProperty(i, sim.FIELD_Y)
		if sim.pmap (x, y) == i then 
                                tpt.delete(i)
		end
	end
	print("Removed the outermost particle from stack")
return false
end

if stv == 1 then
if ren.zoomEnabled() then
local bx,by = sim.adjustCoords(tpt.brushx,tpt.brushy)
for i in sim.neighbors(zx,zy,bx,by) do
 sim.partProperty(i, sim.FIELD_X, stackposx)
  sim.partProperty(i, sim.FIELD_Y, stackposy)
  end
else
for i in sim.neighbors(tpt.mousex,tpt.mousey,tpt.brushx,tpt.brushy) do
 sim.partProperty(i, sim.FIELD_X, stackposx)
  sim.partProperty(i, sim.FIELD_Y, stackposy)
end
end
print("Stacked the selected particles.")
return false
end
end

info:action(function(sender)
close()
event.unregister(event.mousedown,getclick)
event.register(event.mousedown,getclick)
event.unregister(event.tick,drawstack)
event.register(event.tick,drawstack)
stv = 0
end)

edito:action(function(sender)
close()
local editomenu = Window:new(-15,-15, 610, 382)
local doned = Button:new(534,362,70,15, "Done", "Edit")
local cancel = Button:new(464,362,70,15, "Cancel", "Hide.")
local edmsg = Label:new(153,5,120, 10,"    Welcome to the Element Editor. Note: These changes are temporory and will not be saved!")
local edelnam = Textbox:new(10, 30, 100, 15, '', 'Elem to Edit.')
local edelname = Textbox:new(10, 60, 100, 15, '', 'New Name.')
local edelname2 = Textbox:new(10, 80, 100, 15, '', 'New Colour.')
local edelname4 = Textbox:new(10, 100, 100, 15, '', 'Menu Section.')
local edelname5 = Textbox:new(10, 120, 100, 15, '', 'Show / Hide.')
local edelname3 = Textbox:new(10, 140, 550, 15, '', '                                              New Element Description.')
local edelname6 = Textbox:new(10, 160, 100, 15, '', 'Explosive.')
local edelname7 = Textbox:new(10, 180, 100, 15, '', 'HeatConduct.')
local edelname8 = Textbox:new(10, 200, 100, 15, '', 'Flammable.')
local edelname9 = Textbox:new(10, 220, 100, 15, '', 'Weight.')
local edelname10 = Textbox:new(10, 240, 100, 15, '', 'Acid resistance.')
local edelname11 = Textbox:new(10, 260, 100, 15, '', 'Spawn Temp.')
local edelname12 = Textbox:new(10, 280, 100, 15, '', 'Diffusion.')
local edelname13 = Textbox:new(10, 300, 100, 15, '', 'Gravity.')
local edelname14 = Textbox:new(10, 320, 100, 15, '', 'Advection.')
local edelname15 = Textbox:new(10, 340, 100, 15, '', 'Melting point.')
local edelname16 = Textbox:new(10, 360, 100, 15, '', 'Freezing point.')

local ed0 = Label:new(170,33,120, 10,"Type the element name to be edited (Eg. STNE).")
local ed1 = Label:new(106,63,70, 10,"New name.")
local ed2 = Label:new(158,83,110, 10,"New colour, in hexadecimal (0xRRGGBB).")
local ed3 = Label:new(183,103,120, 10,"Menu section, 1 to 14. 1 = Electronics, 14 = Tools.")
local ed4 = Label:new(202,123,120, 10,"To show or hide the element from menu. 0 = Hide, 1 = Show.")
local ed6 = Label:new(221,163,120, 10,"Explosiveness, 0 = No, 1 = with FIRE, 2 = FIRE or Pressure > 2.5.")
local ed7 = Label:new(151,183,120, 10,"Heat conductivity. 0 = No, 255 = Max.")
local ed8 = Label:new(137,203,120, 10,"Flamability, 0 to a few thousand.")
local ed9 = Label:new(169,223,120, 10,"Weight , Eg. 1 = Gas, 2 = Light, 98 = Heavy.")
local ed10 = Label:new(173,243,120, 10,"Acid resistance , Eg. 0 = No effect, 50 = Max.")
local ed11 = Label:new(137,263,120, 10,"Temp. of element when it is spawned.")
local ed12 = Label:new(211,283,120, 10,"How much the particle wiggles, mainly for gases, range 0 - 10.")
local ed13 = Label:new(156,303,120, 10,"How fast the particle falls. -0.1 to 0.4.")
local ed14 = Label:new(205,323,120, 10,"How much the particle is accelerated by moving air. -1 to 01")
local ed15 = Label:new(160,343,120, 10,"Temp. at which element melts (in Celsius).")
local ed16 = Label:new(164,363,120, 10,"Temp. at which element freezes (in Celsius).")

editomenu:addComponent(edmsg)
editomenu:addComponent(doned)
editomenu:addComponent(edelnam)
editomenu:addComponent(edelname)
editomenu:addComponent(edelname2)
editomenu:addComponent(edelname3)
editomenu:addComponent(edelname4)
editomenu:addComponent(edelname5)
editomenu:addComponent(edelname6)
editomenu:addComponent(edelname7)
editomenu:addComponent(edelname8)
editomenu:addComponent(edelname9)
editomenu:addComponent(edelname10)
editomenu:addComponent(edelname11)
editomenu:addComponent(edelname12)
editomenu:addComponent(edelname13)
editomenu:addComponent(edelname14)
editomenu:addComponent(edelname15)
editomenu:addComponent(edelname16)
editomenu:addComponent(ed0)
editomenu:addComponent(ed1)
editomenu:addComponent(ed2)
editomenu:addComponent(ed3)
editomenu:addComponent(ed4)
editomenu:addComponent(ed6)
editomenu:addComponent(ed7)
editomenu:addComponent(ed8)
editomenu:addComponent(ed9)
editomenu:addComponent(ed10)
editomenu:addComponent(ed11)
editomenu:addComponent(ed12)
editomenu:addComponent(ed13)
editomenu:addComponent(ed14)
editomenu:addComponent(ed15)
editomenu:addComponent(ed16)
editomenu:addComponent(cancel)

ui.showWindow(editomenu)

doned:action(function(sender)
function errormsg()
graphics.drawText(480,348,"Invalid element entered!", 255,0,0,255)
end

if edelnam:text() ~= nil then
editomenu:onDraw(errormsg)
end

local newName = tonumber(tpt.element(edelnam:text()))
if edelname:text() == "" then
else
elements.property(newName, "Name", edelname:text())
end
if edelname3:text() == "" then
else
elements.property(newName, "Description", edelname3:text())
end
if edelname2:text() == "" then
else
elements.property(newName, "Colour", edelname2:text())
end
if edelname4:text() == "" then
else
elements.property(newName, "MenuSection", edelname4:text())
end
if edelname5:text() == "" then
else
elements.property(newName, "MenuVisible", tonumber(edelname5:text()))
end
if edelname6:text() == "" then
else
elements.property(newName, "Explosive", tonumber(edelname6:text()))
end
if edelname7:text() == "" then
else
elements.property(newName, "HeatConduct", tonumber(edelname7:text()))
end
if edelname8:text() == "" then
else
elements.property(newName, "Flammable", tonumber(edelname8:text()))
end
if edelname9:text() == "" then
else
elements.property(newName, "Weight", tonumber(edelname9:text()))
end
if edelname10:text() == "" then
else
elements.property(newName, "Hardness", tonumber(edelname10:text()))
end
if edelname11:text() == "" then
else
elements.property(newName, "Temperature", tonumber(edelname11:text())+273.15)
end
if edelname12:text() == "" then
else
elements.property(newName, "Diffusion", tonumber(edelname12:text()))
end
if edelname13:text() == "" then
else
elements.property(newName, "Gravity", tonumber(edelname13:text()))
end
if edelname14:text() == "" then
else
elements.property(newName, "Advection", tonumber(edelname14:text()))
end
if edelname15:text() == "" then
else
elements.property(newName, "HighTemperature", tonumber(edelname15:text()) + 273)
end
if edelname16:text() == "" then
else
elements.property(newName, "LowTemperature", tonumber(edelname16:text()) + 273)
end

ui.closeWindow(editomenu)
end)

cancel:action(function(sender)
ui.closeWindow(editomenu)
end)
end)

Help:action(function(sender)
close()
randsav = math.random(1,2963348)
sim.loadSave(randsav, 0) 
end)

reminder:action(function(sender)
clearsb()
if MANAGER.getsetting("CRK","notifval") == "0" then
MANAGER.savesetting("CRK","notifval","1")
notificationscript()
event.register(event.tick,MaticzplNotifications.Tick)
event.register(event.mousemove,MaticzplNotifications.Mouse)
event.register(event.mousedown,MaticzplNotifications.OnClick)
event.register(event.mousewheel,MaticzplNotifications.Scroll)
elseif MANAGER.getsetting("CRK","notifval") == "1" then
MANAGER.savesetting("CRK","notifval","0")
event.unregister(event.tick,MaticzplNotifications.Tick)
event.unregister(event.mousemove,MaticzplNotifications.Mouse)
event.unregister(event.mousedown,MaticzplNotifications.OnClick)
event.unregister(event.mousewheel,MaticzplNotifications.Scroll)
end
end)

reminderhelp:action(function(sender)
close()
tpt.message_box(" Notification feature help", "Turning it on will notify you when:\n*There's a new vote or comment on your save\n*When your save reaches/ leaves FP.\n\nRefreshes every 5 minutes and works for first 60 saves (by votes + by dates).\n\nShows a red cross if something goes wrong.\n\nCredit: @Maticzpl")
end)

function cbrightness()
tpt.fillrect(-1,-1,630,425,0,0,0,255-MANAGER.getsetting("CRK", "brightness"))
end

brightness:action(function(sender)
clearsb()
brightSlider:value (MANAGER.getsetting("CRK", "brightness"))
brlabel2:text(tonumber(string.format("%.1f",brightSlider:value()/255*100)).."%")

brightSlider:onValueChanged(function() 
if brightSlider:value() < 38 then
brightSlider:value("38")
end
MANAGER.savesetting("CRK", "brightness", brightSlider:value())
brlabel2:text(tonumber(string.format("%.1f",brightSlider:value()/255*100)).."%")
end)
newmenu:addComponent(brlabel2)
newmenu:addComponent(brightSlider)
newmenu:addComponent(brop)
newmenu:addComponent(bropc)
end)

brop:action(function(sender)
MANAGER.savesetting("CRK", "brightstate", "1")
event.unregister(event.tick,cbrightness)
event.register(event.tick,cbrightness)
newmenu:removeComponent(brightSlider)
newmenu:removeComponent(brlabel2)
newmenu:removeComponent(brop)
newmenu:removeComponent(bropc)
end)

bropc:action(function(sender)
MANAGER.savesetting("CRK", "brightstate", "0")
event.unregister(event.tick,cbrightness)
brightSlider:value("255")
MANAGER.savesetting("CRK", "brightness", brightSlider:value())
newmenu:removeComponent(brightSlider)
newmenu:removeComponent(brop)
newmenu:removeComponent(brlabel2)
newmenu:removeComponent(bropc)
end)

--Texter hybrid start
local yvalue = 10
local ylimit = 320
local linenumber = 01
function drawLetter(letter, x, y, element, font)

        for currentX = 0, fonts[font]['width'] - 1 + fonts[font][letter]['kerning'] do

                for currentY = fonts[font][letter]['descender'], fonts[font]['height'] - 1 do

                        if fonts[font][letter]['pixels'][currentY + 1 - fonts[font][letter]['descender']][currentX + 1] == 1 then

                                -- Create the element
                                tpt.create(x + currentX, y + currentY - fonts[font][letter]['descender'], element)
                        end
                end
        end
end

function drawText(text, x, y, element, font)

        local currentLetter
        local originalX = x

        for p = 1, #text do

                currentLetter = string.sub(text, p, p)

                if currentLetter == '\n' then

                        -- Reset to new line
                        x = originalX
                        y = y + fonts[font]['height'] + fonts[font]['linespacing']

                elseif fonts['7x10'][currentLetter] then

                        -- Draw letter
                        drawLetter(currentLetter, x, y, element, font)
                        x = x + fonts[font]['width'] + fonts[font]['charspacing'] + fonts[font][currentLetter]['kerning']

                else

                        -- Draw null character
                        drawLetter('NULL', x, y, element, font)
                        x = x + fonts[font]['width'] + fonts[font]['charspacing'] + fonts[font]['NULL']['kerning']
                end

        end
end

local newmenu4 = Window:new(4,344,606,42)

function drawblip()
ui.closeWindow(newmenu4)
ui.showWindow(newmenu4)
tpt.unregister_step(drawblip)
end

local texttext = "Typing starts here."
local tr,tg,tb = 255
local ffix = "0"
local ffix2 = "0"
local yval2 = 10
local fsize = "Normal"
local linenumber = 01
local drawpos = 211
local drawpos2 = 500
local disabletype = 0

function drawprev2()
gfx.fillRect(4,344,606,42,ar,ag,ab,70)
if yvalue < ylimit then
graphics.drawText(10,yvalue+yval2,texttext..".",tr,tg,tb,255)
if ffix == "0" then
yval2 = 10
elseif ffix == "1" then
yval2 = 14
end
end
if disabletype == 0 then
graphics.drawText(10,6,"Tip: Up and Down Arrow keys to change line, Enter to place text.  ||  Font: "..fsize..", Line No: "..linenumber,255,255,255,255)
elseif disabletype == 1 then
graphics.drawText(10,6,"Max Lines Reached.",255,55,55,255)
end
graphics.drawRect(drawpos,363,42,19,32,216,255,255)
end

function keyclicky23(key23)
if disabletype == 0 then
if (key23 == 13) then
placetext()
elseif (key23 == 1073741906) and tonumber(linenumber) > 1  then
if ffix == "1" then
yvalue = yvalue - 14
linenumber = linenumber - 1
elseif ffix == "0" then
yvalue = yvalue - 10
linenumber = linenumber - 1
end
elseif (key23 == 1073741905) and tonumber(linenumber) < 31 then
if ffix == "1" then
yvalue = yvalue + 14
linenumber = linenumber + 1
elseif ffix == "0" then
yvalue = yvalue + 10
linenumber = linenumber + 1
end
end
end
end
newmenu4:onKeyPress(keyclicky23)

chud:action(function(sender)
disabletype = 0
drawpos = 213
tpt.set_pause(1)
tr = 255
tg = 255
tb = 255
linenumber = 01
tpt.hud(0)
ffix2 = "0"
ffix = "0"
yvalue = 10
fsize = "Normal"
texttext = "Typing starts here"
tpt.unregister_step(drawblip)
tpt.register_step(drawblip)
close()

local mouseX, mouseY = tpt.mousex, tpt.mousey
local text, element, font = '', 'DMND', '7x10'
local textTextbox = Textbox:new(5,2,596, 15,'', 'Type the text here. Press enter once done. New lines are inserted automatically.')
local place = Button:new(5,20,50,17,"Enter", "Toggle hidden elements.")
local cancel= Button:new(60,20,50,17,"Close", "Cancel the element placement.")
local textTextboxs = Textbox:new(116, 20, 42, 17, '', 'Element')
local lno2  = Label:new(180, 20, 10, 17, "Fonts:")
local smalf = Button:new(210,20,40,17,"Normal", "5x7.")
local bigf = Button:new(262,20,40,17,"Title", "7x10.")
local titf = Button:new(314,20,40,17,"Bold", "7x10, Bold")
local clrsc = Button:new(448,20,80,17,"Clear Textbox", "Clear text")
local clrsc2 = Button:new(532,20,70,17,"Clear Screen", "Clear text")
local titf2 = Button:new(366,20,40,17,"Real.", "7x10, Bold")

newmenu4:addComponent(textTextbox)
newmenu4:addComponent(textTextboxs)
newmenu4:addComponent(place)
newmenu4:addComponent(cancel)
newmenu4:addComponent(lno2)
newmenu4:addComponent(smalf)
newmenu4:addComponent(bigf)
newmenu4:addComponent(titf)
newmenu4:addComponent(titf2)
newmenu4:addComponent(clrsc)
newmenu4:addComponent(clrsc2)
newmenu4:onDraw(drawprev2)
 textTextbox:onTextChanged(
                    function(sender)
                            text = textTextbox:text();
						    texttext = textTextbox:text();
                    end
                )

 textTextboxs:onTextChanged(
                    function(sender)
                            element = textTextboxs:text();
                    end
                )
				
function textup()
if ffix2 == "1" then
yvalue = yvalue + 4
linenumber = linenumber + 1
end
end
				
smalf:action(function(sender)
drawpos = 213
font='5x7'
if ffix == "1" and yvalue < ylimit then
textup()
end
ffix = "0"
ffix2 = "0"
fsize = "Normal"
end)

bigf:action(function(sender)
drawpos = 265
font='7x10'
if ffix == "0" and yvalue < ylimit then
textup()
end
ffix = "1"
ffix2 = "0"
fsize = "Title"
end)

titf:action(function(sender)
drawpos = 317
font='7x10-Bold'
if ffix == "0" and yvalue < ylimit then
textup()
end
ffix = "1"
ffix2 = "0"
fsize = "Bold"
end)

local cursor = {10, yvalue}
titf2:action(function(sender)
drawpos = 369
if ffix == "1" and yvalue < ylimit then
textup()
end
ffix = "0"
ffix2 = "0"
fsize = "Realistic"
end)

cancel:action(function(sender)
tpt.hud(1)
newmenu4:removeComponent(textTextbox)
newmenu4:removeComponent(textTextboxs)
tpt.unregister_step(drawblip)
ui.closeWindow(newmenu4)
end)

clrsc:action(function(sender)
textTextbox:text("")
texttext = "Textbox Cleared"
end)

clrsc2:action(function(sender)
yvalue = 10
yval2= 10
ffix2 = "0"
linenumber = "1"
disabletype = 0
texttext = "Screen Cleared"
sim.clearSim()
ui.closeWindow(newmenu4)
tpt.unregister_step(drawblip)
tpt.register_step(drawblip)
end)

function drawText2(text)
    for i = 1, #text do
        lastCharIsBig = false
        lastCharIsSmall = false

        lastCharW = 0
        lastCharH = 0
        local c = text:sub(i, i)
        charmap = chars_light[c].matrix
        if chars_light[c].isBig ~= nil then
            lastCharIsBig = true
        end
        if chars_light[c].isSmall ~= nil then
            lastCharIsSmall = true
        end
        for array_l_h = 1, #charmap do
            lastCharH = array_l_h
            for array_l_w = 1, #charmap[array_l_h] do
                lastCharW = array_l_w
                if charmap[array_l_h][array_l_w] == 3 then
				if fsize == "Realistic" then
					pcall(tpt.create, cursor_pointat[1], cursor_pointat[2], "vent")
					else
					pcall(tpt.create, cursor_pointat[1], cursor_pointat[2], element)
					end
                end
				if fsize == "Realistic" then
                if charmap[array_l_h][array_l_w] == 2 then
                    pcall(tpt.create, cursor_pointat[1], cursor_pointat[2], "shld")
                end
                if charmap[array_l_h][array_l_w] == 1 then
                    pcall(tpt.create, cursor_pointat[1], cursor_pointat[2], "glas")
                end
				end
                cursor_pointat[1] = cursor_pointat[1] + 1
            end
            cursor_pointat[1] = cursor[1] - #charmap[array_l_h]
            cursor_pointat[2] = cursor_pointat[2] + 1
        end
        cursor_pointat[2] = cursor_pointat[2] - lastCharH
        if lastCharIsBig == true then
            cursor_pointat[1] = cursor_pointat[1] + lastCharW
        else
            if lastCharIsSmall == true then
                cursor_pointat[1] = cursor_pointat[1] + lastCharW + 2
            else
                cursor_pointat[1] = cursor_pointat[1] + lastCharW + 1
            end
        end
    end
    cursor_pointat[1] = cursor[1]
    cursor_pointat[2] = cursor[2]
end

function placetext()
ffix2 = "1"
ui.closeWindow(newmenu4)
tpt.unregister_step(drawblip)
tpt.register_step(drawblip)

if yvalue < ylimit then
texttext = ">"
if ffix == "1" then
yvalue = yvalue + 14
elseif ffix == "0" then
yvalue = yvalue + 10
end

textTextbox:text('')
linenumber = linenumber + 1
if fsize == "Realistic" or fsize == "Normal" then
cursor_pointat = cursor
cursor_pointat[1] = 10
cursor_pointat[2] = yvalue
drawText2(text)
else
drawText(string.gsub(text, '\\n', '\n') .. '\n', 10, yvalue, element, font)
end
text = textTextbox:text()

end
if yvalue >= ylimit then
disabletype = 1
end
end 
place:action(function(sender)
placetext()
end)
end)
--Texter hybrid end

function autohidehud()
if tpt.mousey <= 40 then 
tpt.hud(0) 
gfx.drawText(6,6,"Hidden",32,216,255,200)
else tpt.hud(1)
end
end

autohide:action(function(sender)
clearsb()

if autoval == "1" then
event.unregister(event.tick,autohidehud)
event.register(event.tick,autohidehud)
autoval = "0"
elseif autoval == "0" then
event.unregister(event.tick,autohidehud)
autoval = "1"
tpt.hud(1)
end
end)

bug:action(function(sender)
clearsb()
newmenu:addComponent(bug1)
newmenu:addComponent(bug2)
end)

bug1:action(function(sender)
clearsb()
platform.openLink("https://powdertoy.co.uk/Discussions/Thread/View.html?Thread=23279")
end)

bug2:action(function(sender)
close()
sim.loadSave(2596812,0) 
end)

function hideno()
tpt.el.rfgl.menusection=7
tpt.el.vrss.menusection=9
tpt.el.vrsg.menusection=6
tpt.el.dyst.menusection=8
tpt.el.eqve.menusection=8
tpt.el.shd4.menusection=9
tpt.el.shd3.menusection=9
tpt.el.shd2.menusection=9
tpt.el.lolz.menusection=11
tpt.el.love.menusection=11
tpt.el.embr.menusection=5
tpt.el.spwn.menusection=11
tpt.el.spwn2.menusection=11
tpt.el.frzw.menusection=7
tpt.el.bizs.menusection=9
tpt.el.bizg.menusection=6
tpt.el.bray.menusection=1
tpt.el.psts.menusection=8
tpt.el.mort.menusection=6
tpt.el.dyst.menu=1
tpt.el.eqve.menu=1
tpt.el.shd4.menu=1
tpt.el.shd3.menu=1
tpt.el.shd2.menu=1
tpt.el.lolz.menu=1
tpt.el.love.menu=1
tpt.el.embr.menu=1
tpt.el.spwn.menu=1
tpt.el.spwn2.menu=1
tpt.el.frzw.menu=1
tpt.el.bizs.menu=1
tpt.el.bizg.menu=1
tpt.el.bray.menu=1
tpt.el.psts.menu=1
tpt.el.mort.menu=1
tpt.el.rfgl.menu=1
tpt.el.vrss.menu=1
tpt.el.vrsg.menu=1
end

function hideyes()
tpt.el.dyst.menu=0
tpt.el.eqve.menu=0
tpt.el.shd4.menu=0
tpt.el.shd3.menu=0
tpt.el.shd2.menu=0
tpt.el.lolz.menu=0
tpt.el.love.menu=0
tpt.el.embr.menu=0
tpt.el.spwn.menu=0
tpt.el.spwn2.menu=0
tpt.el.frzw.menu=0
tpt.el.bizs.menu=0
tpt.el.bizg.menu=0
tpt.el.bray.menu=0
tpt.el.psts.menu=0
tpt.el.mort.menu=0
tpt.el.rfgl.menu=0
tpt.el.vrss.menu=0
tpt.el.vrsg.menu=0
end

bare:action(function(sender)
clearsb()
if hidval == "1" then 
hideno()
MANAGER.savesetting("CRK", "hidestate", "1")
hidval = "0"

elseif hidval == "0" then
hideyes()
MANAGER.savesetting("CRK", "hidestate", "0")
hidval = "1"
end

end)

wiki:action(function(sender)
local pgno = 1
local maxpage = 5

local creditw = Window:new(-15,-15, 626, 422)
local prevpg = Button:new(238, 400, 40, 15, "Prev.")
local nextpg = Button:new(342, 400, 40, 15, "Next")
local close2 = Button:new(570, 400, 50, 15, "Close")

local wpage1 = "01) CWIR: Customisable wire. Conduction speed set using .tmp property (Range is 0 to 8) \n    .tmp2 property is used for setting melting point (default is 2000C).\n\n02) VSNS: Velocity sensor. Creates sprk when there's a particle with velocity higher than its temp.\n\n03) TIMC: Time Crystal, powder that converts into its ctype when sparked with PSCN.\n\n04) FUEL: Powerful fuel, explodes when temp is above 50C or Pressure above 14.\n\n05) THRM: Thermostat. Maintains the surrounding temp based on its own .temp property.\n\n06) CLNT: Coolant. Cools down the temp of the system. Use .tmp to configure the cooling/heating power.\n    Evaporates at extreme temperatures into WTRV.\n\n07) DMRN: Demron. Radioactive shielding material and a better indestructible heat insulator.\n    It can also block energy particles like PROT.\n\n08) FNTC & FPTC: Faster versions of NTCT and PTCT. Useful for making faster logic gates.\n\n09) PINV: Powered Invisible, allows particles to move through it only when activated. Use with PSCN and NSCN.\n\n10) UV: UV rays, harms stkms (-5 life every frame), visible with FILT, grows plnt, can sprk pscn and evaporates watr.\n    Can split WATR into O2 and H2 when passed through FILT. Makes PHOS glow, ionises RADN. PHOT + GRPH -> UV. \n\n11) SUN.: Emits rays which makes PLNT grow in direction of sun, emits UV radiation, makes PSCN spark and heals STKMs.\n\n12) CLUD: Realistic cloud, rains and creates LIGH after sometime (every 1000 frames). Cool below 0C to make it snow.\n\n13) LBTR: Lithium Ion Battery, Use with PSCN and NSCN. Charges with INST when deactivated. Life sets capacity.\n    Reacts with different elements like O2, WATR, ACID etc as IRL."
local wpage2 = "14) LED: Light Emmiting Diode. Use PSCN to power it on. Temp. sets the brightness. Glows in its dcolour (Default set to white).\n\n15) QGP: Quark Gluon Plasma, bursts out radiation afer sometime. Turns into Purple QGP when under 100C which is stable.\n    Glows in different colours just before exploding. \n\n16) TMPS: .tmp sensor, .tmp3 modes => value = 0 or 1 detects tmp, .tmp3 = 2 (.tmp2), 3 = .tmp3 and 4 = .tmp4. \n    Rest all is same as any other sensor. Supports serialisation and deserilisation of all tmp values too.\n\n17) PHOS: Phosphorus. Shiny white particle, slowly oxidises into red phosphorus with time. \n    Burns instantly with CFLM. Reacts violently with Oxygen. Burns slowly when ignited with FIRE.\n    Oil reverses the oxidation turning it back into white PHOS, acts as a fertiliser for PLNT. Melts at 45C. Glows under UV.\n\n18) CMNT: Cement, creates an exothermic reaction when mixed with water and gets solidified, darkens when solid.\n\n19) NTRG: Nitrogen gas, liquifies to LN2 when cooled or when under pressure, reacts with H2 to make NITR and puts out fire.\n\n20) PRMT: Promethium, radioactive element. Catches fire at high velocity (>12), creats NEUT when mixed with PLUT. \n    Explodes at low temp and emits neut at high temp.\n\n21) BEE: Eats PLNT. Makes wax hive at center when health > 90. Attacks STKMs and FIGH can regulate temp.\n    Gets aggresive if life gets below 30. Tries to return to center when life >90. Falls down when life is low.\n\n22) ECLR: Electronic eraser, clears the defined radius (.tmp) when activated (Use with PSCN and NSCN). \n\n23) PROJ: Projectile, converts into its's ctype upon collision. launch with PSCN. Temperature = power while .tmp = range.\n    Limits: Both .tmp and temp. if set to negative or >100 will be reset.\n\n24) PPTI and PPTO: Powered Versions of PRTI and PRTO, use with PSCN and NSCN.\n\n25) SEED: Grows into PLNT of random height when placed on DUST/SAND/CLST and Watered. Needs warm temp. to grow."
local wpage3 = "26) CSNS: Ctype sensor, detects nearby element's ctype. Useful when working with LAVA.\n\n27) CPPR: Copper, excellent conductor. Loses conductivity when oxidised with O2 or when it is heated around temp. of 300C.\n    Oxide form breaks apart when under pressures above 4.0. Becomes a super conductor when cooled below -200C.\n\n28) CLRC: Clear coat. A white fluid that coats solids. Becomes invisible with UV. Non conductive and acid resistant.\n\n29) CEXP: Customisable explosive. Temperature = temp. that it reaches while exploding.\n    .Life and .tmp determines the pressure and power (0-10) respectively that it generates (preset to be stronger).\n\n30) PCON: Powered CONV. Use with PSCN and NSCN. Set its Ctype carefully!\n\n31) STRC: Structure, Falls apart without support. CNCT and Solids can support it. \n    .tmp2 = Max overhang strength. (Default = 10). \n\n32) BFLM: Black Flames. Burns everything it touches even VIRS, can't be stopped. DMRN & WALL are immune to it.\n\n33) TURB: Turbine, generates sprk under pressure. Discharges to PSCN. Changes colour as per pressure. \n    Performance = Poor when pressure is >4 and <16, Moderate above >16, Best above 30, breaks around 50.\n\n34) PET: STKM/STKM2's new AI friend. Follows them while also healing them. Tries to regulate temp. when healthy.\n    Colour of head shows health. Uses PLNT/WATR to stay alive. Avoids harmful particles like ACID/ LAVA. Can avoid falling. \n    Avoids areas of extreme temps. Kills nearby pets. Expands and blasts if life drops below 10. \n\n35) MISL: Missile, flies to target (X=tmp, Y=tmp2) shown as crosshair (use PSCN to hide it). Blasts when at coords or >500C.\n    Use the MIST tool under tools section for much better experience.\n\n36) AMBE: Sets ambient air temp as per its own Temp. Powered Element. tmp = area it affects (1-25).\n\n37) ACTY: Acetylene, light gas that burns quickly ~1100C, burns hotter ~3500C & longer with O2. Makes LBRD with Chlorine."
local wpage4 = "38) Cl: Chlorine gas, settles down fast. Photochemical reaction with H2. 1/400 chance of Cl + H2 = ACID.\n    Cl + WATR = DSTW (distillation below 50C) or ACID (>50C). Kills STKM.\n    Decays organic matter like PLNT, YEST, WOOD, SEED, etc. Slows when cooled. Rusts IRON & BMTL.\n\n39) WALL: Walls now in element form (1x1), can block pressure, PROT and is an indestructible INSL.\n\n40) ELEX: A strange element that can turn into any random element (only when above 0C).\n\n41) RADN: A heavy radioactive gas with short half-life (Emits neut while decaying). Can conduct SPRK.\n    Ionises in presence of UV (glows red) and then emits different radioactive elements.\n\n42) GRPH: Graphite. Excellent heat and electricity conductor. Melts at 3900C. GRPH + O2 -> CO2 and PHOT + GRPH -> UV.\n    Once ignited (when > 450C) the flames are very difficult to stop. Absorbs NEUT and thus acting as a moderator.\n\n43) BASE: Base, forms salt when reacted with acid. Dissolves certain metals like METL, BMTL, GOLD, BRMT, IRON, BREL etc.\n    Strength reduces upon dilution with water (turns brown). Turns GRPH, COAL, BCOL etc to CO2. Evaporates when > 150C.\n\n44) WHEL: Wheel. Spins when powered with PSCN. RPM increases with time. Use .tmp to set the wheel size.\n    Wheel Size Range: 05-50 (8 = default). Use decoroations for spoke colour. Note: SPRK the center particle and not the rim.\n    Sparking with NSCN decreases the RPM eventually stopping it. Temperature (100C-1000C) sets the max RPM (400C default).\n\n45) NAPM: Napalm. Viscous liquid that's impossible to extinguish once ignited. Sticks to solids. Use in small amounts.\n    Reaches temp. around 1200C while burning. Ignites when around 100C.\n\n46) GSNS: Gravity sensor, creates sprk when nearby gravity is higher than its temp. (supports serialisation).\n\n47) EMGT: Electromagnet. Creates positive & negative EM fiels around it when sparked with PSCN or NSCN respectively.\n    Spark with both PSCN and NSCN and it becomes unstable heating and sparking nearby metals.\n    Can attract or repel metalic powders (BRMT, SLCN, BREL,PQRT, etc) or PHOT and ELEC depending upon the field created.\n    Heats while being powered (upto 400C), strength decreases with temperature. Melts around 1300C."
local wpage5 = "48) SODM: Sodium shiny conductive metal. Reacts violently with WATR generating hydrogen. Turns powder when under pressure.\n    Absorbs O2 and Co2 to form oxide layers. Forms SALT with chlorine when above 50C. Melts at 97C. Glows under vaccum.\n\n49) BALL: Bouncy glas balls, can spill away liquids and powders while bouncing. Breaks at 20 pressure and melts around 1900C\n\n50) SPSH: Space ship. Controlled via on screen buttons. Needs charge to move. Pause the game to draw stuff while using SPSH.\n\n51) RUBR: Rubber fluid, sets into given shape when above 230C. Burns around 430C. Bounces off powders and liquids.\n    Blocks pressure like TTAN when solid and is a good heat insulator. Gets dissolved by GAS & OIL."

creditw:addComponent(close2)
creditw:addComponent(nextpg)
creditw:addComponent(prevpg)

function drawwikitext()
local wcontent
if pgno == 1 then
gfx.drawText(250,8,"Welcome To The WIKI",255,255,55,255)
wcontent = wpage1
elseif pgno == 2 then
wcontent = wpage2
elseif pgno == 3 then
wcontent = wpage3
elseif pgno == 4 then
wcontent = wpage4
elseif pgno == 5 then
wcontent = wpage5
end
gfx.drawRect(10,395,610,1,255,255,55,255)
gfx.drawText(10,22,wcontent,255,255,255,255)
gfx.drawText(287,405,"Page: "..pgno.."/"..maxpage ,255,255,55,255)
end

creditw:onDraw(drawwikitext)
local function clearpg()
creditw:removeComponent(creditstxt)
creditw:removeComponent(creditstxt2)
creditw:removeComponent(creditstxt3)
end

nextpg:action(function()
if pgno < maxpage then
pgno = pgno + 1
end
end)

prevpg:action(function() 
if pgno > 1 then
pgno = pgno - 1
end
end)

close2:action(function() ui.closeWindow(creditw) end)
clearsb()
ui.showWindow(creditw) 
end)

function hidemodelem()
tpt.el.fntc.menu=0
tpt.el.fptc.menu=0
tpt.el.cwir.menu=0
tpt.el.copr.menu=0
tpt.el.lbtr.menu=0
tpt.el.led.menu=0
tpt.el.timc.menu=0
tpt.el.pinv.menu=0
tpt.el.ppti.menu=0
tpt.el.ppto.menu=0
tpt.el.pcon.menu=0
tpt.el.ambe.menu=0
tpt.el.tmps.menu=0
tpt.el.csns.menu=0
tpt.el.thmo.menu=0
tpt.el.eclr.menu=0
tpt.el.proj.menu=0
tpt.el.turb.menu=0
tpt.el.misl.menu=0
tpt.el.cexp.menu=0
tpt.el.bflm.menu=0
tpt.el.qgp.menu=0
tpt.el.ntrg.menu=0
tpt.el.clud.menu=0
tpt.el.clnt.menu=0
tpt.el.fuel.menu=0
tpt.el.clrc.menu=0
tpt.el.phos.menu=0
tpt.el.cmnt.menu=0
tpt.el.seed.menu=0
tpt.el.dmrn.menu=0
tpt.el.strc.menu=0
tpt.el.prmt.menu=0
tpt.el.uv.menu=0
tpt.el.strc.menu=0
tpt.el.wall.menu=0
tpt.el.sun.menu=0
tpt.el.bee.menu=0
tpt.el.pet.menu=0
tpt.el.cl.menu=0
tpt.el.acty.menu=0
tpt.el.elex.menu=0
tpt.el.radn.menu=0
tpt.el.grph.menu=0
tpt.el.base.menu=0
tpt.el.whel.menu=0
tpt.el.napm.menu=0
tpt.el.gsns.menu=0
tpt.el.emgt.menu=0
tpt.el.sodm.menu=0
tpt.el.ball.menu=0
tpt.el.rubr.menu=0
elem.property(PLNE, "MenuVisible", 0)
elem.property(MISLT, "MenuVisible", 0)
end

function showmodelem()
tpt.el.fntc.menu=1
tpt.el.fptc.menu=1
tpt.el.cwir.menu=1
tpt.el.copr.menu=1
tpt.el.lbtr.menu=1
tpt.el.led.menu=1
tpt.el.timc.menu=1
tpt.el.pinv.menu=1
tpt.el.ppti.menu=1
tpt.el.ppto.menu=1
tpt.el.pcon.menu=1
tpt.el.ambe.menu=1
tpt.el.tmps.menu=1
tpt.el.csns.menu=1
tpt.el.thmo.menu=1
tpt.el.eclr.menu=1
tpt.el.proj.menu=1
tpt.el.turb.menu=1
tpt.el.misl.menu=1
tpt.el.cexp.menu=1
tpt.el.bflm.menu=1
tpt.el.qgp.menu=1
tpt.el.ntrg.menu=1
tpt.el.clud.menu=1
tpt.el.clnt.menu=1
tpt.el.fuel.menu=1
tpt.el.clrc.menu=1
tpt.el.phos.menu=1
tpt.el.cmnt.menu=1
tpt.el.seed.menu=1
tpt.el.dmrn.menu=1
tpt.el.strc.menu=1
tpt.el.prmt.menu=1
tpt.el.uv.menu=1
tpt.el.strc.menu=1
tpt.el.wall.menu=1
tpt.el.sun.menu=1
tpt.el.bee.menu=1
tpt.el.pet.menu=1
tpt.el.cl.menu=1
tpt.el.acty.menu=1
tpt.el.elex.menu=1
tpt.el.radn.menu=1
tpt.el.grph.menu=1
tpt.el.base.menu=1
tpt.el.whel.menu=1
tpt.el.napm.menu=1
tpt.el.gsns.menu=1
tpt.el.emgt.menu=1
tpt.el.sodm.menu=1
tpt.el.ball.menu=1
tpt.el.rubr.menu=1
elem.property(PLNE, "MenuVisible", 1)
elem.property(MISLT, "MenuVisible", 1)
end
local modelemval = "0"
bg:action(function(sender)
if modelemval == "0" then
hidemodelem()
modelemval = "1"
else
showmodelem()
modelemval = "0"
end
clearsb()
end)
local splitval = 0
local barval = MANAGER.getsetting("CRK","barval")
local barlength = "1"
local uival = "1"
local frameCount,colourRED,colourGRN,colourBLU = 0,0,0,0
function theme()
if tonumber(specialmsgval) == 1 then
motwdisplay()
end
if MANAGER.getsetting("CRK", "savergb") ~= "1" then
ar = MANAGER.getsetting("CRK", "ar")
ag = MANAGER.getsetting("CRK", "ag")
ab = MANAGER.getsetting("CRK", "ab")
elseif MANAGER.getsetting("CRK", "savergb") == "1" then
ar = colourRED
ag = colourGRN
ab = colourBLU
end
if MANAGER.getsetting("CRK", "brightstate") ~= "1" then
al = MANAGER.getsetting("CRK", "al")
else
al = brightSlider:value()
end
--Update text
if updatestatus == 1 then
gfx.fillRect(8,367,315,15,20,20,20,200)
gfx.drawText(10,370,"You are running an outdated version, please update when possible.",255,20,20,250)
end
--Filters
if filterval == 1 then
tpt.drawrect(2,2,607,379,ar,ag,ab,50)
tpt.fillrect(1,1,609,381,ar,ag,ab,50)
end
--Borders
if borderval == "1" then
tpt.drawrect(2,2,607,379,ar,ag,ab,al)
tpt.drawrect(1,1,609,381,ar,ag,ab,al)
end
--Autosave
if stamplb == "1" then
graphics.drawText(8,370,"AutoSave", 32,255,32,220)
end
--Split theme
local spr, spb,spg = ar,ag,ab
if splitval == 1 then
spr, spg, spb = 255-ar,255-ag,255-ab
else
spr, spg, spb = ar,ag,ab
end
--Topbar
if borderval ~= "1" and uival ~= "0" then
barval = MANAGER.getsetting("CRK","barval")
if barval == "1" then
if tonumber(barlength) <= 202 then
barlength = barlength + "5"
end
tpt.fillrect(tonumber(barlength),-1,tonumber(barlength),3, ar,ag,ab,al)
elseif barval == "2" then
tpt.fillrect(2,-1,302,3, ar,ag,ab,al)
tpt.fillrect(305,-1,305,3, spr, spg, spb, al)
end
end
--Topbarend
--split theme
--top
tpt.drawrect(613,17,14,14,spr,spg,spb,al)
tpt.drawrect(613,49,14,14,spr,spg,spb,al)
tpt.drawrect(613,81,14,14,spr,spg,spb,al)
--right
tpt.drawrect(613,152,14,14,spr,spg,spb,al)
tpt.drawrect(613,184,14,14,spr,spg,spb,al)
tpt.drawrect(613,216,14,14,spr,spg,spb,al)
tpt.drawrect(613,248,14,14,spr,spg,spb,al)
tpt.drawrect(613,280,14,14,spr,spg,spb,al)
tpt.drawrect(613,312,14,14,spr,spg,spb,al)
tpt.drawrect(613,344,14,14,spr,spg,spb,al)
tpt.drawrect(613,376,14,14,spr,spg,spb,al)
--Lua manager
tpt.drawrect(613,119,14,15,spr,spg,spb,al)
--Bottom
tpt.drawrect(1,408,626,14,spr,spg,spb,al)
--split theme end
--top
tpt.drawrect(613,1,14,14,ar,ag,ab,al)
tpt.drawrect(613,33,14,14,ar,ag,ab,al)
tpt.drawrect(613,65,14,14,ar,ag,ab,al)
--MP and manager
tpt.drawrect(613,103,14,14,ar,ag,ab,al)
--right
tpt.drawrect(613,136,14,14,ar,ag,ab,al)
tpt.drawrect(613,168,14,14,ar,ag,ab,al)
tpt.drawrect(613,200,14,14,ar,ag,ab,al)
tpt.drawrect(613,232,14,14,ar,ag,ab,al)
tpt.drawrect(613,264,14,14,ar,ag,ab,al)
tpt.drawrect(613,296,14,14,ar,ag,ab,al)
tpt.drawrect(613,328,14,14,ar,ag,ab,al)
tpt.drawrect(613,360,14,14,ar,ag,ab,al)
tpt.drawrect(613,392,14,14,ar,ag,ab,al)
--bottom
tpt.drawline(612,409,612,421,ar,ag,ab,al)
tpt.drawline(187,409,187,421,ar,ag,ab,al)
tpt.drawline(487,409,487,421,ar,ag,ab,al)
tpt.drawline(241,409,241,421,ar,ag,ab,al)
tpt.drawline(469,409,469,421,ar,ag,ab,al)
tpt.drawline(36,409,36,421,ar,ag,ab,al)
tpt.drawline(18,409,18,421,ar,ag,ab,al)
tpt.drawline(580,409,580,421,ar,ag,ab,al)
tpt.drawline(596,409,596,421,ar,ag,ab,al)
tpt.drawline(418,409,418,421,ar,ag,ab,al)

if MANAGER.getsetting("CRK", "savergb") == "1" then
 colourRGB = {colourRED,colourGRN,colourBLU}
 if frameCount > 1529 then frameCount = 0 else frameCount = frameCount + 1 end
 if frameCount > 0 and frameCount < 255 then
  colourRED = 255
  if colourGRN > 254 then else colourGRN = colourGRN + 1 end
 end
 if frameCount > 254 and frameCount < 510 then
  colourGRN = 255
  if colourRED == 0 then else colourRED = colourRED - 1 end
 end
 if frameCount > 510 and frameCount < 765 then
  colourGRN = 255
  if colourBLU > 254 then else colourBLU = colourBLU + 1 end
 end
 if frameCount > 764 and frameCount < 1020 then
  colourBLU = 255
  if colourGRN == 0 then else colourGRN = colourGRN - 1 end
 end
 if frameCount > 1020 and frameCount < 1275 then
  colourBLU = 255
  if colourRED > 254 then else colourRED = colourRED + 1 end
 end
 if frameCount > 1274 and frameCount < 1530 then
  colourRED = 255
  if colourBLU == 0 then else colourBLU = colourBLU - 1 end
 end
 end
 --Cross-hair
if MANAGER.getsetting("CRK", "fancurs") == "1" and (event.getmodifiers() == 0 or event.getmodifiers() == 4096 or event.getmodifiers() == 32768 or event.getmodifiers() == 8192 or event.getmodifiers() == 45056 or event.getmodifiers() == 40960 or event.getmodifiers() == 36864 or event.getmodifiers() == 12288) then 
graphics.drawLine(tpt.mousex-6,tpt.mousey,tpt.mousex+6,tpt.mousey,ar,ag,ab,al+50)
graphics.drawLine(tpt.mousex,tpt.mousey-6,tpt.mousex,tpt.mousey+6,ar,ag,ab,al+50)
local crx, cry = 0,0 
if ren.zoomEnabled() then
crx, cry = sim.adjustCoords(tpt.mousex,tpt.mousey)
else
crx, cry = tpt.mousex,tpt.mousey
end
graphics.drawText(tpt.mousex-40-tpt.brushx, tpt.mousey-12,"Lp:"..sim.elementCount(elem[tpt.selectedl]),ar,ag,ab,al)
graphics.drawText(tpt.mousex-40-tpt.brushx, tpt.mousey-2,"X:"..crx,ar,ag,ab,al)
graphics.drawText(tpt.mousex+15+tpt.brushx, tpt.mousey-2,"Y:"..cry,spr,spg,spb,al)
graphics.drawText(tpt.mousex+15+tpt.brushx, tpt.mousey-12,"Rp:"..sim.elementCount(elem[tpt.selectedr]),spr,spg,spb,al)
if tpt.brushx > 0 or tpt.brushy > 0 then
graphics.drawText(tpt.mousex-40-tpt.brushx, tpt.mousey+8,"L:"..tpt.brushx,ar,ag,ab,al)
graphics.drawText(tpt.mousex+15+tpt.brushx, tpt.mousey+8,"H:"..tpt.brushy,spr,spg,spb,al)
end
end
end

mp:action(function(sender)
clearsb()
local mp1 = Button:new(20,92,45,25,"Dark", "Change the theme to Dark")
local mp2 = Button:new(70,92,45,25,"Fire", "Change the theme to Blue")
local mp3 = Button:new(120,92,45,25,"Aqua", "Change the theme to Red")
local mp4 = Button:new(170,92,45,25,"Forest", "Change the theme to Green")
local mp7 = Button:new(220,92,45,25,"Vanilla", "Change the theme back to Plain white")
local mp8 = Button:new(270,92,45,25,"Teal", "Teal")
local mp11 = Button:new(320,92,45,25,defaulttheme, "The default theme")
local mp9 = Button:new(370,92,45,25,"Pulse", "RBG makes everything better.")
local mp10 = Button:new(420,92,45,25,"Split", "Half of the theme is inverted")
local mpop = Button:new(530,347,75,20,"Done", "Close")

local bg1 = Button:new(24,300,60,25,"Filters", "Toggle filters")
local bog1 = Button:new(24,333,60,25,"Cross-Hair", "Draw Cross-hair")
local bogb1 = Button:new(124,333,60,25,"Borders", "Draw Borders")

local jkey = Button:new(124,300,60,25,"J-Shortcut", "Toggle Shortcut")
local neonmode = Button:new(224,300,60,25,"Neon Mode", "Toggle fire strength")
local Forceup = Button:new(324,300,70,25,"Force Update", "Triggers the forced update mechanism.")
local bg7 = Button:new(224,333,60,25,"Developer", "Disable inbuilt scripts")

local baropa =  Button:new(24,250,35,20,"Short", "Short and moving")
local baropb =  Button:new(64,250,35,20,"Long", "Long")
local baropd =  Button:new(104,250,35,20,"Off", "Turn off")

local als = Label:new(317,147, 30, 15, "Alpha")

local aSlider = Slider:new(20, 145, 255, 17, 255)
local rSlider = Slider:new(20, 166, 255, 17, 255)
local gSlider = Slider:new(20, 187, 255, 17, 255)
local bSlider = Slider:new(20, 208, 255, 17, 255)

local alb = Label:new(290, 147, 10, 15)
local rlb = Label:new(290, 168, 10, 15)
local glb = Label:new(290, 189, 10, 15)
local blb = Label:new(290, 210, 10, 15)

local newmenuth = Window:new(-15,-15, 609, 370)

function mpnolag()
MANAGER.savesetting("CRK", "savergb","0")
aSlider:value(MANAGER.getsetting("CRK", "al"))
rSlider:value(MANAGER.getsetting("CRK", "ar"))
gSlider:value(MANAGER.getsetting("CRK", "ag"))
bSlider:value(MANAGER.getsetting("CRK", "ab"))
rclr = rSlider:value() 
rlb:text(rclr)

gclr = gSlider:value() 
glb:text(gclr)

bclr = bSlider:value() 
blb:text(bclr)
aclr = aSlider:value() 
alb:text(aclr)
end
local adminval = 0
function drawprev()
local barstat = "Long"
graphics.drawText(255,7, "Welcome to the Control Centre V"..crackversion,255,255,255,255)
graphics.drawRect(20,38,573,26,255,255,255,255)
graphics.drawText(321,173, "Red",255,0,0,255)
graphics.drawText(321,194, "Green",0,255,0,255)
graphics.drawText(321,215, "Blue",0,0,255,255)
if MANAGER.getsetting("CRK", "brightstate") == "1" then 
graphics.drawText(25,152, "Brightness setting is turned on, alpha slider not available",255,55,55,255)
end
if adminval == 1 then
graphics.fillRect(221,330,160,31,255,40,40,210)
graphics.drawRect(220,330,160,32,255,0,0,255)
elseif adminval == 2 then
graphics.fillRect(220,330,160,32,40,255,40,210)
end
if MANAGER.getsetting("CRK", "barval") == "4" then
barstat = "Off"
elseif MANAGER.getsetting("CRK", "barval") == "1" then
barstat = "Short"
elseif MANAGER.getsetting("CRK", "barval") == "2" then
barstat = "Long"
end

gfx.drawText(20,23,"Preview:",MANAGER.getsetting("CRK", "ar"),MANAGER.getsetting("CRK", "ag"),MANAGER.getsetting("CRK", "ab"),255)
gfx.drawText(24,78,"Presets:",MANAGER.getsetting("CRK", "ar"),MANAGER.getsetting("CRK", "ag"),MANAGER.getsetting("CRK", "ab"),255)
gfx.drawText(24,133,"Theme Customisation:",MANAGER.getsetting("CRK", "ar"),MANAGER.getsetting("CRK", "ag"),MANAGER.getsetting("CRK", "ab"),255)
gfx.drawText(24,235,"Topbar: "..barstat,MANAGER.getsetting("CRK", "ar"),MANAGER.getsetting("CRK", "ag"),MANAGER.getsetting("CRK", "ab"),255)
gfx.drawText(25,285,"Other Options:",MANAGER.getsetting("CRK", "ar"),MANAGER.getsetting("CRK", "ag"),MANAGER.getsetting("CRK", "ab"),255)

if MANAGER.getsetting("CRK","savergb") == "1" then
gfx.drawRect(370,92,47,27,32,216,255,255)
end
if MANAGER.getsetting("CRK","split") == "1" then
gfx.drawRect(420,92,47,27,32,216,255,255)
end

if MANAGER.getsetting("CRK", "fancurs") == "1" then
graphics.drawText(90,342, "ON",105,255,105,255)
else
graphics.drawText(90,342, "OFF",255,105,105,255)
end
if filterval == 1 then
graphics.drawText(90,309, "ON",105,255,105,255)
else
graphics.drawText(90,309, "OFF",255,105,105,255)
end
if borderval == "1" then
graphics.drawText(190,342, "ON",105,255,105,255)
else
graphics.drawText(190,342, "OFF",255,105,105,255)
end
if shrtv == "1" then
gfx.drawText(190,309,"ON",105,255,105,255)
else
gfx.drawText(190,309,"OFF",255,105,105,255)
end
if nmodv == "1" then
gfx.drawText(290,309,"ON",105,255,105,255)
else
gfx.drawText(290,309,"OFF",255,105,105,255)
end

if MANAGER.getsetting("CRK", "savergb") ~= "1" then
if MANAGER.getsetting("CRK","split") ~= "1" then
graphics.fillRect(22, 40,569,22,MANAGER.getsetting("CRK", "ar"),MANAGER.getsetting("CRK", "ag"),MANAGER.getsetting("CRK", "ab"),MANAGER.getsetting("CRK", "al"))
else
graphics.fillRect(22, 40,284,22,MANAGER.getsetting("CRK", "ar"),MANAGER.getsetting("CRK", "ag"),MANAGER.getsetting("CRK", "ab"),MANAGER.getsetting("CRK", "al"))
graphics.fillRect(307, 40,284,22,255-tonumber(MANAGER.getsetting("CRK", "ar")),255-tonumber(MANAGER.getsetting("CRK", "ag")),255-tonumber(MANAGER.getsetting("CRK", "ab")),MANAGER.getsetting("CRK", "al"))
end
graphics.drawRect(1,1, 609, 370, MANAGER.getsetting("CRK", "ar"),MANAGER.getsetting("CRK", "ag"),MANAGER.getsetting("CRK", "ab"),110)
graphics.fillRect(1,1, 609, 370, MANAGER.getsetting("CRK", "ar"),MANAGER.getsetting("CRK", "ag"),MANAGER.getsetting("CRK", "ab"),10)
else
graphics.drawText(30,47, "Preview not available because pulse theme is on. Note: Alpha slider can also be used for pulse theme.",255,55,55,255)
end
end
newmenuth:onDraw(drawprev)

function closewindow()
ui.closeWindow(newmenuth)
ui.closeWindow(newmenu)
barlength = 1
end

ui.showWindow(newmenuth)
newmenuth:addComponent(mp1)
newmenuth:addComponent(mp2)
newmenuth:addComponent(mp3)
newmenuth:addComponent(mp4)
newmenuth:addComponent(mp7)
newmenuth:addComponent(mp8)
newmenuth:addComponent(mp11)
newmenuth:addComponent(mp9)
newmenuth:addComponent(mp10)

newmenuth:addComponent(bg1)
newmenuth:addComponent(bg7)

newmenuth:addComponent(bog1)
newmenuth:addComponent(bogb1)
newmenuth:addComponent(jkey)
newmenuth:addComponent(neonmode)
newmenuth:addComponent(Forceup)

newmenuth:addComponent(rSlider)
newmenuth:addComponent(gSlider)
newmenuth:addComponent(bSlider)
newmenuth:addComponent(rlb)
newmenuth:addComponent(glb)
newmenuth:addComponent(blb)
newmenuth:addComponent(mpop)
newmenuth:addComponent(baropa)
newmenuth:addComponent(baropb)
newmenuth:addComponent(baropd)

if MANAGER.getsetting("CRK", "brightstate") ~= "1" then
newmenuth:addComponent(aSlider)
newmenuth:addComponent(als)
newmenuth:addComponent(alb)
end

rlb:text(MANAGER.getsetting("CRK", "ar"))
glb:text(MANAGER.getsetting("CRK", "ag"))
blb:text(MANAGER.getsetting("CRK", "ab"))
alb:text(MANAGER.getsetting("CRK", "al"))

rSlider:onValueChanged(function()   rclr = rSlider:value() rlb:text(rclr) MANAGER.savesetting("CRK","ar", rSlider:value()) mpnolag() end)
gSlider:onValueChanged(function()  gclr = gSlider:value() glb:text(gclr) MANAGER.savesetting("CRK","ag",gSlider:value()) mpnolag() end)
bSlider:onValueChanged(function()  bclr = bSlider:value() blb:text(bclr) MANAGER.savesetting("CRK","ab",bSlider:value())  mpnolag() end)

aSlider:onValueChanged(function()
if aSlider:value() < 80 then
aSlider:value("80")
end
aclr = aSlider:value() 
alb:text(aclr) 
MANAGER.savesetting("CRK","al",aSlider:value()) 
end)

aSlider:value(MANAGER.getsetting("CRK", "al"))
rSlider:value(MANAGER.getsetting("CRK", "ar"))
gSlider:value(MANAGER.getsetting("CRK", "ag"))
bSlider:value(MANAGER.getsetting("CRK", "ab"))

bog1:action(function(sender)
if MANAGER.getsetting("CRK", "fancurs") == "0" then 
MANAGER.savesetting("CRK", "fancurs","1") 
elseif MANAGER.getsetting("CRK", "fancurs") == "1" then 
MANAGER.savesetting("CRK", "fancurs","0") 
end
end)

bogb1:action(function(sender)
if borderval == "0" then
borderval = "1"
elseif borderval == "1" then
borderval = "0"
end
end)

jkey:action(function(sender)
if shrtv == "1" then
shrtv = "0"
else
shrtv = "1"
end
end)

neonmode:action(function(sender)
if nmodv == "0" then
nmodv = "1"
tpt.setfire(30)
print("Neon Mode: Particles like FIRE, GAS and PHOT etc appear extra fancy and glowy.")
elseif nmodv == "1" then
nmodv = "0"
tpt.setfire(1)
end
end)

Forceup:action(function(sender)
ui.closeWindow(newmenuth)
ui.closeWindow(newmenu)
updatestatus = 0
print("Force updating the mod, click the update notification below.")
runupdater()
end)

mpop:action(function(sender)
ui.closeWindow(newmenuth)
ui.closeWindow(newmenu)
end)

mp1:action(function(sender)
MANAGER.savesetting("CRK","ar",50)
MANAGER.savesetting("CRK","ag",50)
MANAGER.savesetting("CRK","ab",50)
MANAGER.savesetting("CRK","al",255)
mpnolag()
end)

mp2:action(function(sender)
MANAGER.savesetting("CRK","ar",255)
MANAGER.savesetting("CRK","ag",55)
MANAGER.savesetting("CRK","ab",55)
MANAGER.savesetting("CRK","al",220)
mpnolag()
end)

mp3:action(function(sender)
MANAGER.savesetting("CRK","ar",50)
MANAGER.savesetting("CRK","ag",100)
MANAGER.savesetting("CRK","ab",255)
MANAGER.savesetting("CRK","al",255)
mpnolag()
end)

mp4:action(function(sender)
MANAGER.savesetting("CRK","ar",155)
MANAGER.savesetting("CRK","ag",255)
MANAGER.savesetting("CRK","ab",155)
MANAGER.savesetting("CRK","al",220)
mpnolag()
end)

mp7:action(function(sender)
MANAGER.savesetting("CRK","ar",250)
MANAGER.savesetting("CRK","ag",250)
MANAGER.savesetting("CRK","ab",250)
MANAGER.savesetting("CRK","al",200)
mpnolag()
end)

mp8:action(function(sender)
MANAGER.savesetting("CRK","ar",87)
MANAGER.savesetting("CRK","ag",255)
MANAGER.savesetting("CRK","ab",255)
MANAGER.savesetting("CRK","al",255)
mpnolag()
end)
--Default theme
mp11:action(function(sender)
MANAGER.savesetting("CRK","ar",dr)
MANAGER.savesetting("CRK","ag",dg)
MANAGER.savesetting("CRK","ab",db)
MANAGER.savesetting("CRK","al",da)
mpnolag()
end)

mp9:action(function(sender)
if MANAGER.getsetting("CRK","savergb") == "0" then
MANAGER.savesetting("CRK","savergb",1)
aSlider:value(MANAGER.getsetting("CRK", "al"))
aclr = aSlider:value() 
alb:text(aclr)
elseif MANAGER.getsetting("CRK","savergb") == "1" then
mpnolag()
end
end)

mp10:action(function(sender)
if MANAGER.getsetting("CRK","split") == "0" or MANAGER.getsetting("CRK","split") == nil then
MANAGER.savesetting("CRK","split","1")
splitval = 1
elseif  MANAGER.getsetting("CRK","split") == "1" then
MANAGER.savesetting("CRK","split","0")
splitval = 0
end
end)

bg1:action(function(sender)
if filterval == 0 then
filterval = 1
elseif filterval == 1 then
filterval = 0
end
end)

local adminpass = Textbox:new(290, 336, 55, 20, '', ' <Code> ')
local admincan = Button:new(350,336,20,20,"X", "cancle admin mode")
local admincan1 = Button:new(225,336,70,20,"Debug mode", "Disables crackerk.lua and fail check")
local admincan2 = Button:new(298,336,76,20,"Disable scripts", "Disables all embedded scripts")

bg7:action(function(sender)
adminval = 1
newmenuth:removeComponent(adminpass)
newmenuth:removeComponent(admincan)
newmenuth:addComponent(admincan)
newmenuth:addComponent(adminpass)
admincan:action(function(sender)
newmenuth:removeComponent(adminpass)
newmenuth:removeComponent(admincan)
adminval = 0
end)
adminpass:onTextChanged(function(sender)
if adminpass:text() == "911" then
adminval = 2
newmenuth:removeComponent(bg7)
newmenuth:removeComponent(adminpass)
newmenuth:removeComponent(admincan)
newmenuth:addComponent(admincan1)
newmenuth:addComponent(admincan2)

admincan1:action(function(sender)
local fdlf3 = io.open('debugmode.txt', 'w')
fdlf3:write("Message from Cracker1000: This file disables the embedded scripts in Cracker1000's Mod for debugging purposes, delete this to restore the mod to original state.")
fdlf3:close()
local fdlf3at = io.open('autorun.lua', 'w')
fdlf3at:close()
platform.restart()
end)
admincan2:action(function(sender)
local fdlf3a = io.open('deleteme.txt', 'w')
fdlf3a:write("Message from Cracker1000: This file disables the embedded scripts in Cracker1000's Mod, delete this file and then restart to make it load the scripts again.")
fdlf3a:close()
platform.restart()
end)
end
end)
end)

baropa:action(function(sender)
MANAGER.savesetting("CRK","barval","1")
end)

baropb:action(function(sender)
MANAGER.savesetting("CRK","barval","2")
end)

baropd:action(function(sender)
MANAGER.savesetting("CRK","barval","4")
end)

end)

function startupcheck()
event.register(event.tick,errormesg)
fs.makeDirectory("scripts")
event.register(event.tick,writefile2)
interface.addComponent(toggle)

if MANAGER.getsetting("CRK","loadelem") == "1" then
tpt.selectedl = MANAGER.getsetting("CRK","primaryele")
tpt.selectedr = MANAGER.getsetting("CRK","secondaryele")
end

if MANAGER.getsetting("CRK","al") == nil then --Defaults to prevent errors in script
MANAGER.savesetting("CRK","loadelem","0")
MANAGER.savesetting("CRK", "pass","0")
MANAGER.savesetting("CRK","notifval","1")
MANAGER.savesetting("CRK", "fancurs","0")
MANAGER.savesetting("CRK","savergb","0")
MANAGER.savesetting("CRK","barval","2")
MANAGER.savesetting("CRK","ar",dr)
MANAGER.savesetting("CRK","ag",dg)
MANAGER.savesetting("CRK","ab",db)
MANAGER.savesetting("CRK","al",da)
end
event.unregister(event.tick,theme)
event.register(event.tick,theme)

if MANAGER.getsetting("CRK", "split") == "1" then
splitval = 1
end

if MANAGER.getsetting("CRK", "hidestate") == "1" then
hideno()
hidval = "0"
end
if MANAGER.getsetting("CRK", "brightstate") == "1" then
brightSlider:value(MANAGER.getsetting("CRK", "brightness"))
event.register(event.tick,cbrightness)
else
MANAGER.savesetting("CRK", "brightness",255)
end
end
startupcheck()

Ruler:action(function(sender)
clearsb()
if rulval == "1" then
rulval = "0"
tpt.setdebug(0X4)
print("Use shift + Drag to use Ruler")
elseif rulval == "0" then
tpt.setdebug(0X0)
rulval = "1"
end
end)

function UIhide()
if focustime < 190 then
focustime = focustime + 3
end
if tpt.mousey > 380 or tpt.mousex > 610 then
if focustime > 15 then
focustime = focustime - 7
end
end
tpt.fillrect(-1,382,614,42,0,0,0,focustime)
tpt.fillrect(612,0,17,424,0,0,0,focustime)
end

deletesparkButton:action(function(sender)
clearsb()
if uival == "1" then
event.unregister(event.tick,UIhide)
event.register(event.tick,UIhide)
tpt.hud(0)
uival = "0"
print("Interface will now be out of focus when working in simulation area.")
elseif uival == "0" then
tpt.hud(1)
event.unregister(event.tick,UIhide)
uival = "1"
end
end)

FPS:action(function(sender)
clearsb()
if fpsval == "1" then
tpt.setfpscap(2)
fpsval = "0"
else
tpt.setfpscap(60)
fpsval = "1"
end
end)

reset:action(function(sender)
if tpt.confirm(" Mod resetter","Resetting the mod changes the mod settings back to their default values and disables all the lua scripts. Saves and other important data will remain intact. Click Full Reset to perform a hard mod reset.", "Full Reset") == true then
os.remove("scripts/downloaded/2 LBPHacker-TPTMulti.lua")
os.remove("scripts/downloaded/219 Maticzpl-Notifications.lua")
os.remove("scripts/downloaded/scriptinfo.txt")
os.remove("scripts/autorunsettings.txt")
os.remove("oldmod")
platform.restart()
end
end)

function close()
ui.closeWindow(newmenu) 
clearsb()
clearm()
barlength = 1
end
local posix2 = posix + 10
function motwdisplay()
if motw ~= "." then
if posix > 600 then
if posix2 > -1*(posix)then
posix2 = posix2 - 1
end
if posix2 <= -1*(posix) then
posix2 = posix + 10
end
end
if tonumber(specialmsgval) == 1 then
graphics.fillRect(2,348,609, 10,20,20,20,200)
graphics.drawText(posix2,349,motw,255,0,0,255)
else
graphics.fillRect(2,258,609, 10,20,20,20,200)
graphics.drawText(posix2,259,motw,245,225,0,255)
end
end
end

function drawglitch()
motwdisplay()
if perfmv == "1" then
graphics.drawLine(12, 18,574,18,ar,ag,ab,al)
graphics.drawRect(1,1, 609, 255,ar,ag,ab,110)
graphics.fillRect(1,1, 609, 255,ar,ag,ab,15)
end

if MANAGER.getsetting("CRK", "brightstate") == "1" then
cbrightness()
end
gfx.drawText(12,7,"Welcome to Mod Settings. Tip: 'J' Key can be used as a shortcut to open and close the menu. Status:",255,255,255,255) --Intro message
if onlinestatus == 1 then --Online status
gfx.drawText(498,7,"Online",95,255,95,255)
elseif onlinestatus == 3 then
gfx.drawText(498,7,"Report the error!",255,0,0,255)
else
gfx.drawText(498,7,"Offline",255,95,95,255)
end
if uival == "0" then --Focus Mode
gfx.drawText(98,37,"ON",105,255,105,255)
else
gfx.drawText(98,37,"OFF",255,105,105,255)
end
if fpsval == "1" then --Frame limiter
gfx.drawText(98,69,"ON",105,255,105,255)
else
gfx.drawText(98,69,"OFF",255,105,105,255)
end
if rulval == "0" then --Ruler
gfx.drawText(98,165,"ON",105,255,105,255)
else
gfx.drawText(98,165,"OFF",255,105,105,255)
end
if stamplb == "1" then --Autostamp
gfx.drawText(98,198,"ON",105,255,105,255)
else
gfx.drawText(98,198,"OFF",255,105,105,255)
end
if hidval == "0" then --Hidden elements
gfx.drawText(291,69,"ON",105,255,105,255)
else
gfx.drawText(291,69,"OFF",255,105,105,255)
end
if modelemval == "0" then --Mod elements
gfx.drawText(291,101,"ON",105,255,105,255)
else
gfx.drawText(291,101,"OFF",255,105,105,255)
end
if autoval == "0" then --Auto hide hud
gfx.drawText(291,165,"ON",105,255,105,255)
else
gfx.drawText(291,165,"OFF",255,105,105,255)
end
if MANAGER.getsetting("CRK", "brightstate") == "1" then --Brigntness
gfx.drawText(291,229,"ON",105,255,105,255)
else
gfx.drawText(291,229,"OFF",255,105,105,255)
end
if perfmv == "0" then --Performance
gfx.drawText(484,165,"ON",105,255,105,255)
else
gfx.drawText(484,165,"OFF",255,105,105,255)
end
if MANAGER.getsetting("CRK", "pass") == "1" then --Password
gfx.drawText(484,197,"ON",105,255,105,255)
else
gfx.drawText(484,197,"OFF",255,105,105,255)
end
if MANAGER.getsetting("CRK","notifval") == "1" then --Notifications
gfx.drawText(484,229,"ON",105,255,105,255)
else
gfx.drawText(484,229,"OFF",255,105,105,255)
end

if MANAGER.getsetting("CRK","loadelem") == "1" then --Startup elements.
gfx.drawText(484,37,"Configured",105,255,105,255)
else
gfx.drawText(484,37,"OFF",255,105,105,255)
end
--Reserved
if invtoolv == "0" then --Invert-tool
gfx.drawText(484,101,"ON",105,255,105,255)
else
gfx.drawText(484,101,"OFF",255,105,105,255)
end
end

hide:action(function(sender)
close()
end)

function open()
ui.showWindow(newmenu) 
newmenu:onDraw(drawglitch)
newmenu:onKeyPress(keyclicky2)
if motw ~= "." then
MANAGER.savesetting("CRK","storedmotd",motw)
end
event.unregister(event.tick,showmotdnot)
event.unregister(event.mousedown, clicktomsg)
newmenu:onTryExit(close)
newmenu:addComponent(deletesparkButton)
newmenu:addComponent(FPS)
newmenu:addComponent(info)
newmenu:addComponent(reset)
newmenu:addComponent(hide)
newmenu:addComponent(Ruler)
newmenu:addComponent(bg)
newmenu:addComponent(mp)
newmenu:addComponent(bug)
newmenu:addComponent(bar)
newmenu:addComponent(bare)
newmenu:addComponent(wiki)
newmenu:addComponent(autohide)
newmenu:addComponent(chud)
newmenu:addComponent(brightness)
newmenu:addComponent(reminder)
newmenu:addComponent(Help)
newmenu:addComponent(shrtpre)
newmenu:addComponent(edito)
newmenu:addComponent(perfm)
newmenu:addComponent(passbut)
newmenu:addComponent(upmp)
newmenu:addComponent(reminderhelp)
end

hide:action(function(sender)
close()
end)

function keyclicky2(key2)
if (key2 == 106) and shrtv == "1" then
close()
end
end

function keyclicky(key)
if (key == 106) and TPTMP.chatHidden == true and shrtv == "1" then
open()
end
end
event.register(event.keypress,keyclicky)

toggle:action(function(sender)
open()
end)

--fontstart
fonts ={}
fonts['7x10'] = {}
fonts['7x10']['width'] = 7
fonts['7x10']['height'] = 10
fonts['7x10']['linespacing'] = 4
fonts['7x10']['charspacing'] = 1

fonts['7x10-Bold'] = {}
fonts['7x10-Bold']['width'] = 7
fonts['7x10-Bold']['height'] = 10
fonts['7x10-Bold']['linespacing'] = 4
fonts['7x10-Bold']['charspacing'] = 1

fonts['7x10']['a'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {0, 1, 1, 1, 1, 0, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['b'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['c'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['d'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['e'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['f'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['g'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['h'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['i'] = {
        ['descender'] = 0,
        ['kerning'] = -6,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['j'] = {
        ['descender'] = -4,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['k'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 1, 0, 0},
                {1, 0, 0, 1, 0, 0, 0},
                {1, 0, 1, 0, 0, 0, 0},
                {1, 1, 0, 1, 0, 0, 0},
                {1, 0, 0, 0, 1, 0, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['l'] = {
        ['descender'] = 0,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['m'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 0, 1, 1, 0},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['n'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 1, 1, 1, 0, 0},
                {1, 1, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['o'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['p'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['q'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1}
        }
}
fonts['7x10']['r'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 1, 1, 1, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['s'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['t'] = {
        ['descender'] = 0,
        ['kerning'] = -3,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['u'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 1, 1, 0},
                {0, 1, 1, 1, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['v'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['w'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['x'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['y'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['z'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10'][' '] = {
        ['descender'] = 0,
        ['kerning'] = -3,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['A'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['B'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['C'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['D'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['E'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['F'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['G'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 1, 1, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['H'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['I'] = {
        ['descender'] = 0,
        ['kerning'] = -6,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['J'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {0, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['K'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 1, 0, 0},
                {1, 0, 0, 1, 0, 0, 0},
                {1, 0, 1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 0, 1, 0, 0, 0, 0},
                {1, 0, 0, 1, 0, 0, 0},
                {1, 0, 0, 0, 1, 0, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['L'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['M'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 0, 1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['N'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 1, 0},
                {1, 1, 0, 0, 0, 1, 0},
                {1, 1, 0, 0, 0, 1, 0},
                {1, 0, 1, 0, 0, 1, 0},
                {1, 0, 1, 0, 0, 1, 0},
                {1, 0, 0, 1, 0, 1, 0},
                {1, 0, 0, 1, 0, 1, 0},
                {1, 0, 0, 0, 1, 1, 0},
                {1, 0, 0, 0, 1, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['O'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['P'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['Q'] = {
        ['descender'] = -2,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 1, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['R'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['S'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['T'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['U'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['V'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['W'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['X'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['Y'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['Z'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['0'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 1, 1, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 1, 1, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['1'] = {
        ['descender'] = 0,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['2'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['3'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['4'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 1, 0, 1, 0},
                {0, 0, 1, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['5'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['6'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 1, 1, 1, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['7'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['8'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['9'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 1, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['.'] = {
        ['descender'] = 0,
        ['kerning'] = -6,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['<'] = {
        ['descender'] = 0,
        ['kerning'] = -3,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['>'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['!'] = {
        ['descender'] = 0,
        ['kerning'] = -6,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['@'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 1, 1, 0, 1},
                {1, 0, 1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1, 0, 1},
                {1, 0, 0, 1, 1, 0, 1},
                {1, 0, 0, 0, 1, 0, 1},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['#'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 0, 0, 0, 1, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['$'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 1, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 1, 0, 0, 1},
                {0, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['%'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 0, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 1, 0},
                {0, 1, 1, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 1, 1, 0},
                {0, 1, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 0, 1, 1, 0}
        }
}
fonts['7x10']['^'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 1, 0, 0, 0},
                {1, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['{'] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['}'] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['&'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0, 0, 0},
                {1, 0, 0, 0, 1, 0, 0},
                {1, 0, 0, 0, 1, 0, 0},
                {1, 0, 0, 1, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 0, 1, 0, 1},
                {1, 0, 0, 0, 0, 1, 0},
                {0, 1, 1, 1, 1, 0, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['*'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {1, 0, 0, 1, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['('] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10'][')'] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['='] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['"'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 1, 1, 0},
                {1, 1, 0, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['['] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 1, 1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10'][']'] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 1, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {1, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['|'] = {
        ['descender'] = -3,
        ['kerning'] = -6,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['?'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels'] = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10'][','] = {
        ['descender'] = -2,
        ['kerning'] = -5,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10'][':'] = {
        ['descender'] = 0,
        ['kerning'] = -6,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10'][';'] = {
        ['descender'] = -2,
        ['kerning'] = -5,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['+'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['-'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['_'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['/'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['NULL'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
               {0, 0, 0, 0, 0, 0, 0},
               {0, 0, 1, 1, 0, 0, 0},
               {0, 1, 1, 0, 0, 0, 0},
               {0, 0, 0, 0, 0, 0, 0},
               {0, 0, 0, 0, 0, 0, 0},
               {0, 0, 0, 0, 0, 0, 0},
               {0, 0, 0, 0, 0, 0, 0},
               {0, 0, 0, 0, 0, 0, 0},
               {0, 0, 0, 0, 0, 0, 0},
               {0, 0, 0, 0, 0, 0, 0},
               {0, 0, 0, 0, 0, 0, 0},
               {0, 0, 0, 0, 0, 0, 0},
               {0, 0, 0, 0, 0, 0, 0},
               {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10']['~'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 1, 1},
                {1, 0, 0, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['a'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['b'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['c'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['d'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['e'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['f'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 1, 1, 1, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['g'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0}
        }
}
fonts['7x10-Bold']['h'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['i'] = {
        ['descender'] = 0,
        ['kerning'] = -5,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['j'] = {
        ['descender'] = -4,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['k'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 1, 1, 0, 0},
                {1, 1, 1, 1, 0, 0, 0},
                {1, 1, 0, 1, 1, 0, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['l'] = {
        ['descender'] = 0,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['m'] = {
        ['descender'] = 0,
        ['kerning'] = 1,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 0, 1, 1, 1, 0},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['n'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['o'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['p'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['q'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1}
        }
}
fonts['7x10-Bold']['r'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['s'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 0, 1},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 1, 1},
                {1, 0, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['t'] = {
        ['descender'] = 0,
        ['kerning'] = -3,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['u'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['v'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 0, 1, 1, 0},
                {0, 1, 1, 0, 1, 1, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['w'] = {
        ['descender'] = 0,
        ['kerning'] = 1,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['x'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 0, 1, 1, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 1, 1, 0, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['y'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 0, 1, 1, 0},
                {0, 1, 1, 0, 1, 1, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['z'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 1, 1, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold'][' '] = {
        ['descender'] = 0,
        ['kerning'] = -3,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['A'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 1, 1, 0, 1, 1, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['B'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['C'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['D'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['E'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['F'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['G'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 1, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['H'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['I'] = {
        ['descender'] = 0,
        ['kerning'] = -5,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['J'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {0, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['K'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 1, 1, 0, 0},
                {1, 1, 1, 1, 0, 0, 0},
                {1, 1, 1, 0, 0, 0, 0},
                {1, 1, 1, 1, 0, 0, 0},
                {1, 1, 0, 1, 1, 0, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['L'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['M'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1},
                {1, 1, 0, 1, 0, 1, 1},
                {1, 1, 0, 1, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['N'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 0, 1, 1},
                {1, 1, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 1, 1},
                {1, 1, 0, 1, 1, 1, 1},
                {1, 1, 0, 0, 1, 1, 1},
                {1, 1, 0, 0, 1, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['O'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['P'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['Q'] = {
        ['descender'] = -2,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['R'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['S'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['T'] = {
        ['descender'] = 0,
        ['kerning'] = 1,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['U'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['V'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 0, 1, 1, 0},
                {0, 1, 1, 0, 1, 1, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['W'] = {
        ['descender'] = 0,
        ['kerning'] = 1,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['X'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 0, 1, 1, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 1, 1, 0, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['Y'] = {
        ['descender'] = 0,
        ['kerning'] = 1,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 0, 1, 1},
                {0, 1, 1, 0, 0, 1, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['Z'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 1, 1, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['0'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 1, 1, 1},
                {1, 1, 0, 1, 0, 1, 1},
                {1, 1, 1, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['1'] = {
        ['descender'] = 0,
        ['kerning'] = -3,
        ['pixels']  = {
                {0, 0, 1, 1, 0, 0, 0},
                {0, 1, 1, 1, 0, 0, 0},
                {1, 1, 1, 1, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['2'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 1, 1, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['3'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 1, 1, 0, 0},
                {0, 0, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['4'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 1, 1, 1},
                {0, 0, 0, 1, 1, 1, 1},
                {0, 0, 1, 1, 0, 1, 1},
                {0, 1, 1, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['5'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['6'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 1, 1, 1, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['7'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 1, 1, 0, 0},
                {0, 0, 0, 1, 1, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['8'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['9'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {1, 1, 0, 0, 0, 1, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 1, 1, 0, 0},
                {0, 1, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['.'] = {
        ['descender'] = 0,
        ['kerning'] = -5,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['<'] = {
        ['descender'] = 0,
        ['kerning'] = -3,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['>'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['!'] = {
        ['descender'] = 0,
        ['kerning'] = -5,
        ['pixels']  = {
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['@'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 1, 1, 0, 1},
                {1, 0, 1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1, 0, 1},
                {1, 0, 0, 1, 1, 0, 1},
                {1, 0, 0, 0, 1, 0, 1},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['#'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 0, 0, 0, 1, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['$'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 1, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 1, 0, 0, 1},
                {0, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['_'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['%'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 0, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 1, 0},
                {0, 1, 1, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 1, 1, 0},
                {0, 1, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 0, 1, 1, 0}
        }
}
fonts['7x10-Bold']['^'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 1, 0, 0, 0},
                {1, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['{'] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['}'] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['&'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0, 0, 0},
                {1, 0, 0, 0, 1, 0, 0},
                {1, 0, 0, 0, 1, 0, 0},
                {1, 0, 0, 1, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 0, 1, 0, 1},
                {1, 0, 0, 0, 0, 1, 0},
                {0, 1, 1, 1, 1, 0, 1},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['*'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {1, 0, 0, 1, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 1, 0, 1, 0, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['('] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold'][')'] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['='] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['['] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 1, 1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold'][']'] = {
        ['descender'] = -3,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 1, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {1, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['|'] = {
        ['descender'] = -3,
        ['kerning'] = -6,
        ['pixels']  = {
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['?'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold'][','] = {
        ['descender'] = -2,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold'][':'] = {
        ['descender'] = 0,
        ['kerning'] = -5,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold'][';'] = {
        ['descender'] = -2,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['+'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['-'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['/'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['"'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 1, 0, 1, 1},
                {0, 1, 1, 0, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['~'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 1, 0},
                {1, 0, 0, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['`'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
fonts['7x10-Bold']['NULL'] = {
        ['descender'] = -4,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0}
        }
}
--fontstop

chars_light = {
    ["0"] = {
        matrix = {
            {0, 3, 3, 3, 0},
            {3, 1, 1, 2, 3},
            {3, 1, 0, 0, 3},
            {3, 0, 2, 0, 3},
            {3, 0, 0, 0, 3},
            {3, 2, 0, 2, 3},
            {0, 3, 3, 3, 0}
        }
    },
    ["1"] = {
        matrix = {
            {0, 0, 3, 0},
            {0, 3, 3, 0},
            {2, 1, 3, 0},
            {0, 0, 3, 0},
            {0, 0, 3, 0},
            {0, 0, 3, 0},
            {0, 1, 3, 1}
        }
    },
    ["2"] = {
        matrix = {
            {0, 3, 3, 3, 1},
            {3, 2, 0, 1, 3},
            {1, 0, 0, 1, 3},
            {0, 0, 3, 3, 0},
            {0, 3, 2, 0, 0},
            {3, 1, 0, 0, 0},
            {3, 3, 3, 3, 3}
        }
    },
    ["3"] = {
        matrix = {
            {0, 3, 3, 3, 1},
            {3, 1, 0, 1, 3},
            {1, 0, 0, 0, 3},
            {0, 0, 2, 3, 1},
            {0, 0, 0, 0, 3},
            {3, 0, 0, 1, 3},
            {2, 3, 3, 3, 1}
        }
    },
    ["4"] = {
        matrix = {
            {0, 0, 0, 3, 3},
            {0, 0, 3, 1, 3},
            {0, 3, 1, 0, 3},
            {3, 1, 0, 1, 3},
            {3, 3, 3, 3, 3},
            {0, 0, 0, 0, 3},
            {0, 0, 0, 1, 3}
        }
    },
    ["5"] = {
        matrix = {
            {3, 3, 3, 3, 3},
            {3, 0, 0, 0, 0},
            {3, 1, 1, 1, 0},
            {2, 3, 3, 3, 2},
            {0, 0, 0, 0, 3},
            {1, 0, 0, 0, 3},
            {3, 3, 3, 3, 1}
        }
    },
    ["6"] = {
        matrix = {
            {0, 1, 3, 3, 3},
            {1, 3, 0, 0, 0},
            {3, 1, 0, 0, 0},
            {3, 3, 3, 3, 1},
            {3, 0, 0, 0, 3},
            {3, 0, 0, 1, 3},
            {1, 3, 3, 3, 1}
        }
    },
    ["7"] = {
        matrix = {
            {3, 3, 3, 3, 3, 1},
            {0, 0, 0, 1, 3, 0},
            {0, 0, 0, 2, 3, 0},
            {0, 0, 2, 3, 0, 0},
            {0, 2, 3, 0, 0, 0},
            {1, 3, 0, 0, 0, 0},
            {1, 3, 0, 0, 0, 0}
        },
        isBig = true
    },
    ["8"] = {
        matrix = {
            {0, 3, 3, 3, 1},
            {3, 2, 0, 1, 3},
            {3, 0, 0, 0, 3},
            {1, 3, 3, 3, 1},
            {3, 0, 0, 0, 3},
            {3, 1, 0, 1, 3},
            {1, 3, 3, 3, 1}
        }
    },
    ["9"] = {
        matrix = {
            {0, 3, 3, 3, 1},
            {3, 2, 0, 1, 3},
            {3, 0, 0, 0, 3},
            {0, 3, 3, 3, 3},
            {0, 0, 0, 1, 3},
            {2, 0, 0, 0, 3},
            {1, 3, 3, 3, 1}
        }
    },
    ["A"] = {
        matrix = {
            {0, 1, 3, 1, 0},
            {1, 3, 1, 3, 1},
            {3, 1, 0, 1, 3},
            {3, 0, 0, 0, 3},
            {3, 3, 3, 3, 3},
            {3, 0, 0, 0, 3},
            {3, 0, 0, 0, 3}
        }
    },
    ["a"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {1, 3, 3, 1, 0},
            {1, 0, 0, 3, 0},
            {0, 3, 3, 3, 0},
            {3, 0, 0, 3, 0},
            {1, 3, 3, 3, 1}
        },
        isBig = true
    },
    ["B"] = {
        matrix = {
            {3, 3, 3, 3, 0},
            {3, 0, 0, 2, 3},
            {3, 0, 0, 1, 3},
            {3, 3, 3, 3, 1},
            {3, 0, 0, 1, 3},
            {3, 0, 0, 1, 3},
            {3, 3, 3, 3, 1}
        }
    },
    ["b"] = {
        matrix = {
            {3, 1, 0, 0},
            {3, 0, 0, 0},
            {3, 3, 3, 1},
            {3, 1, 1, 3},
            {3, 0, 0, 3},
            {3, 0, 0, 3},
            {3, 3, 3, 1}
        }
    },
    ["C"] = {
        matrix = {
            {0, 1, 3, 3, 1},
            {1, 3, 0, 1, 3},
            {3, 0, 0, 0, 1},
            {3, 0, 0, 0, 0},
            {3, 0, 0, 0, 0},
            {3, 1, 0, 1, 3},
            {1, 3, 3, 3, 1}
        }
    },
    ["c"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {1, 3, 3, 0},
            {3, 1, 1, 2},
            {3, 0, 0, 0},
            {3, 0, 1, 2},
            {1, 3, 3, 0}
        }
    },
    ["D"] = {
        matrix = {
            {3, 3, 3, 1, 0},
            {3, 0, 1, 3, 1},
            {3, 0, 0, 1, 3},
            {3, 0, 0, 0, 3},
            {3, 0, 0, 0, 3},
            {3, 0, 0, 1, 3},
            {3, 3, 3, 3, 1}
        }
    },
    ["d"] = {
        matrix = {
            {0, 0, 1, 3, 0},
            {0, 0, 0, 3, 0},
            {0, 2, 3, 3, 0},
            {2, 3, 0, 3, 0},
            {3, 0, 0, 3, 0},
            {3, 1, 0, 3, 0},
            {1, 3, 3, 3, 1}
        },
        isBig = true
    },
    ["E"] = {
        matrix = {
            {3, 3, 3, 3, 2},
            {3, 0, 0, 0, 0},
            {3, 0, 0, 0, 0},
            {3, 3, 3, 2, 0},
            {3, 0, 0, 0, 0},
            {3, 0, 0, 0, 1},
            {3, 3, 3, 3, 3}
        }
    },
    ["e"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {1, 3, 3, 1},
            {3, 0, 0, 3},
            {3, 3, 3, 2},
            {3, 0, 0, 0},
            {1, 3, 3, 2}
        }
    },
    ["F"] = {
        matrix = {
            {3, 3, 3, 3, 3},
            {3, 0, 0, 0, 1},
            {3, 0, 0, 0, 0},
            {3, 3, 3, 2, 0},
            {3, 0, 0, 0, 0},
            {3, 0, 0, 0, 0},
            {3, 0, 0, 0, 0}
        }
    },
    ["f"] = {
        matrix = {
            {1, 3, 3},
            {3, 1, 0},
            {3, 0, 0},
            {3, 3, 2},
            {3, 0, 0},
            {3, 0, 0},
            {3, 1, 0}
        }
    },
    ["G"] = {
        matrix = {
            {0, 1, 3, 3, 1},
            {1, 3, 0, 1, 3},
            {3, 0, 0, 0, 0},
            {3, 0, 2, 3, 3},
            {3, 0, 0, 0, 3},
            {3, 1, 0, 1, 3},
            {1, 3, 3, 3, 1}
        }
    },
    ["g"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {0, 3, 3, 2},
            {3, 2, 0, 3},
            {3, 0, 0, 3},
            {1, 3, 3, 3},
            {0, 0, 0, 3},
            {1, 0, 0, 3},
            {2, 3, 3, 1}
        }
    },
    ["H"] = {
        matrix = {
            {3, 1, 0, 1, 3},
            {3, 0, 0, 0, 3},
            {3, 0, 0, 0, 3},
            {3, 3, 3, 3, 3},
            {3, 0, 0, 0, 3},
            {3, 0, 0, 0, 3},
            {3, 1, 0, 1, 3}
        }
    },
    ["h"] = {
        matrix = {
            {3, 0, 0, 0, 0},
            {3, 0, 0, 0, 0},
            {3, 3, 3, 1, 0},
            {3, 1, 2, 3, 0},
            {3, 0, 0, 3, 0},
            {3, 0, 0, 3, 0},
            {3, 1, 0, 3, 1}
        },
        isBig = true
    },
    ["I"] = {
        matrix = {
            {1, 3, 1},
            {0, 3, 0},
            {0, 3, 0},
            {0, 3, 0},
            {0, 3, 0},
            {0, 3, 0},
            {1, 3, 1}
        }
    },
    ["i"] = {
        matrix = {
            {0, 1, 0},
            {0, 3, 1},
            {0, 0, 0},
            {1, 3, 0},
            {0, 3, 0},
            {0, 3, 0},
            {1, 3, 1}
        }
    },
    ["J"] = {
        matrix = {
            {0, 0, 1, 3, 1},
            {0, 0, 0, 3, 0},
            {0, 0, 0, 3, 0},
            {0, 0, 0, 3, 0},
            {0, 0, 0, 3, 0},
            {1, 0, 1, 3, 0},
            {3, 3, 3, 1, 0}
        }
    },
    ["j"] = {
        matrix = {
            {0, 0, 0},
            {0, 0, 3},
            {0, 0, 0},
            {0, 1, 3},
            {0, 0, 3},
            {0, 0, 3},
            {0, 0, 3},
            {0, 0, 3},
            {2, 3, 1}
        }
    },
    ["K"] = {
        matrix = {
            {3, 1, 0, 1, 3, 0},
            {3, 0, 1, 3, 0, 0},
            {3, 1, 3, 0, 0, 0},
            {3, 3, 2, 0, 0, 0},
            {3, 0, 3, 2, 0, 0},
            {3, 0, 0, 3, 2, 0},
            {3, 1, 0, 1, 3, 2}
        }
    },
    ["k"] = {
        matrix = {
            {3, 0, 0, 0, 0},
            {3, 0, 0, 1, 0},
            {3, 0, 2, 3, 0},
            {3, 2, 3, 0, 0},
            {3, 3, 1, 0, 0},
            {3, 0, 3, 1, 0},
            {3, 0, 0, 3, 1}
        },
        isBig = true
    },
    ["L"] = {
        matrix = {
            {3, 1, 0, 0, 0},
            {3, 0, 0, 0, 0},
            {3, 0, 0, 0, 0},
            {3, 0, 0, 0, 0},
            {3, 0, 0, 0, 0},
            {3, 0, 0, 0, 1},
            {3, 3, 3, 3, 2}
        }
    },
    ["l"] = {
        matrix = {
            {3, 0, 0, 0},
            {3, 0, 0, 0},
            {3, 0, 0, 0},
            {3, 0, 0, 0},
            {3, 0, 0, 0},
            {3, 1, 0, 1},
            {1, 3, 3, 0}
        },
        isBig = true
    },
    ["M"] = {
        matrix = {
            {3, 0, 0, 0, 0, 0, 3},
            {3, 3, 1, 0, 1, 3, 3},
            {3, 2, 3, 1, 3, 2, 3},
            {3, 0, 2, 3, 2, 0, 3},
            {3, 0, 0, 2, 0, 0, 3},
            {3, 0, 0, 0, 0, 0, 3},
            {3, 0, 0, 0, 0, 0, 3}
        }
    },
    ["m"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {1, 3, 1, 3, 1},
            {3, 1, 3, 1, 3},
            {3, 0, 3, 0, 3},
            {3, 0, 2, 0, 3},
            {3, 0, 0, 1, 3}
        }
    },
    ["N"] = {
        matrix = {
            {3, 1, 0, 0, 0, 3},
            {3, 3, 0, 0, 0, 3},
            {3, 1, 3, 0, 0, 3},
            {3, 0, 2, 3, 0, 3},
            {3, 0, 0, 3, 1, 3},
            {3, 0, 0, 0, 3, 3},
            {3, 0, 0, 0, 1, 3}
        }
    },
    ["n"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {3, 3, 3, 1},
            {3, 1, 0, 3},
            {3, 0, 0, 3},
            {3, 0, 0, 3},
            {3, 0, 1, 3}
        }
    },
    ["O"] = {
        matrix = {
            {0, 1, 3, 3, 1, 0},
            {1, 3, 1, 0, 3, 1},
            {3, 1, 0, 0, 1, 3},
            {3, 0, 0, 0, 0, 3},
            {3, 0, 0, 0, 1, 3},
            {3, 1, 0, 1, 3, 1},
            {1, 3, 3, 3, 1, 0}
        }
    },
    ["o"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {1, 3, 3, 1},
            {3, 1, 0, 3},
            {3, 0, 0, 3},
            {3, 0, 1, 3},
            {1, 3, 3, 1}
        }
    },
    ["P"] = {
        matrix = {
            {3, 3, 3, 1, 0},
            {3, 0, 1, 3, 1},
            {3, 0, 0, 1, 3},
            {3, 1, 0, 1, 3},
            {3, 3, 3, 3, 1},
            {3, 0, 0, 0, 0},
            {3, 1, 0, 0, 0}
        }
    },
    ["p"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {3, 3, 3, 1},
            {3, 1, 0, 3},
            {3, 0, 0, 3},
            {3, 0, 1, 3},
            {3, 3, 3, 1},
            {3, 0, 0, 0},
            {3, 0, 0, 0}
        }
    },
    ["Q"] = {
        matrix = {
            {0, 1, 3, 3, 1, 0, 0},
            {1, 3, 0, 1, 3, 1, 0},
            {3, 1, 0, 0, 1, 3, 0},
            {3, 0, 0, 0, 0, 3, 0},
            {3, 0, 0, 3, 1, 3, 0},
            {3, 1, 0, 1, 3, 1, 0},
            {1, 3, 3, 3, 1, 3, 1}
        },
        isBig = true
    },
    ["q"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {1, 3, 3, 3, 1},
            {3, 0, 0, 3, 0},
            {3, 0, 0, 3, 0},
            {3, 0, 0, 3, 0},
            {1, 3, 3, 3, 0},
            {0, 0, 0, 3, 0},
            {0, 0, 0, 3, 0},
            {0, 0, 0, 1, 1}
        },
        isBig = true
    },
    ["R"] = {
        matrix = {
            {3, 3, 3, 3, 1, 0},
            {3, 0, 0, 1, 3, 0},
            {3, 0, 0, 0, 3, 0},
            {3, 3, 3, 3, 0, 0},
            {3, 1, 1, 3, 0, 0},
            {3, 0, 0, 1, 3, 0},
            {3, 1, 0, 0, 3, 1}
        },
        isBig = true
    },
    ["r"] = {
        matrix = {
            {0, 0, 0},
            {0, 0, 0},
            {3, 0, 3},
            {3, 3, 1},
            {3, 1, 0},
            {3, 0, 0},
            {3, 0, 0}
        }
    },
    ["S"] = {
        matrix = {
            {0, 3, 3, 3, 1},
            {3, 2, 1, 0, 3},
            {3, 1, 0, 0, 0},
            {1, 3, 3, 3, 0},
            {0, 0, 1, 2, 3},
            {3, 0, 0, 1, 3},
            {2, 3, 3, 3, 1}
        }
    },
    ["s"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {0, 3, 3, 3},
            {3, 0, 0, 1},
            {0, 3, 3, 0},
            {1, 0, 0, 3},
            {3, 3, 3, 0}
        }
    },
    ["T"] = {
        matrix = {
            {3, 3, 3, 3, 3},
            {1, 0, 3, 0, 1},
            {0, 0, 3, 0, 0},
            {0, 0, 3, 0, 0},
            {0, 0, 3, 0, 0},
            {0, 0, 3, 0, 0},
            {0, 1, 3, 1, 0}
        }
    },
    ["t"] = {
        matrix = {
            {0, 3, 0, 0},
            {0, 3, 0, 0},
            {3, 3, 3, 0},
            {0, 3, 0, 0},
            {0, 3, 0, 0},
            {0, 3, 1, 0},
            {0, 1, 3, 1}
        },
        isBig = true
    },
    ["U"] = {
        matrix = {
            {3, 0, 0, 0, 0, 3},
            {3, 0, 0, 0, 0, 3},
            {3, 0, 0, 0, 0, 3},
            {3, 0, 0, 0, 0, 3},
            {3, 0, 0, 0, 1, 3},
            {3, 2, 0, 1, 1, 3},
            {1, 3, 3, 3, 3, 0}
        }
    },
    ["u"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {3, 1, 0, 3, 1},
            {3, 0, 0, 3, 0},
            {3, 0, 0, 3, 0},
            {3, 0, 1, 3, 0},
            {1, 3, 3, 3, 1}
        },
        isBig = true
    },
    ["V"] = {
        matrix = {
            {3, 0, 0, 0, 3},
            {3, 0, 0, 0, 3},
            {3, 0, 0, 0, 3},
            {3, 2, 0, 2, 3},
            {1, 3, 0, 3, 1},
            {0, 3, 1, 3, 0},
            {0, 0, 3, 0, 0}
        }
    },
    ["v"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {3, 0, 0, 3},
            {3, 0, 0, 3},
            {3, 0, 1, 3},
            {3, 1, 1, 3},
            {0, 3, 3, 0}
        }
    },
    ["W"] = {
        matrix = {
            {3, 0, 0, 0, 0, 0, 3},
            {3, 0, 0, 1, 0, 0, 3},
            {3, 1, 0, 3, 0, 1, 3},
            {1, 3, 0, 3, 0, 3, 1},
            {1, 3, 2, 3, 2, 3, 1},
            {0, 3, 3, 0, 3, 3, 0},
            {0, 3, 0, 0, 0, 3, 0}
        }
    },
    ["w"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {3, 1, 0, 1, 3},
            {3, 0, 2, 0, 3},
            {3, 0, 3, 0, 3},
            {3, 1, 3, 1, 3},
            {1, 3, 0, 3, 1}
        }
    },
    ["X"] = {
        matrix = {
            {3, 0, 0, 0, 0, 3, 0},
            {1, 3, 0, 0, 3, 1, 0},
            {0, 2, 3, 2, 3, 0, 0},
            {0, 1, 3, 3, 0, 0, 0},
            {0, 3, 1, 3, 2, 0, 0},
            {1, 3, 0, 0, 3, 1, 0},
            {3, 0, 0, 0, 0, 3, 1}
        }
    },
    ["x"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {3, 0, 1, 3},
            {3, 2, 0, 3},
            {1, 3, 3, 1},
            {3, 0, 2, 3},
            {3, 1, 0, 3}
        }
    },
    ["Y"] = {
        matrix = {
            {3, 0, 0, 0, 3},
            {3, 2, 0, 2, 3},
            {0, 3, 1, 3, 0},
            {0, 1, 3, 1, 0},
            {0, 0, 3, 0, 0},
            {0, 0, 3, 0, 0},
            {0, 0, 3, 0, 0}
        }
    },
    ["y"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {3, 0, 0, 3},
            {3, 0, 0, 3},
            {3, 1, 0, 3},
            {1, 3, 1, 3},
            {0, 1, 3, 1},
            {0, 0, 3, 0},
            {3, 3, 1, 0}
        }
    },
    ["Z"] = {
        matrix = {
            {3, 3, 3, 3, 3, 3},
            {0, 0, 0, 1, 3, 2},
            {0, 0, 0, 3, 2, 0},
            {0, 0, 3, 2, 0, 0},
            {1, 3, 2, 0, 0, 0},
            {3, 2, 1, 0, 0, 0},
            {3, 3, 3, 3, 3, 3}
        }
    },
    ["z"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {3, 3, 3, 3},
            {1, 0, 3, 2},
            {0, 3, 2, 0},
            {3, 2, 0, 1},
            {3, 3, 3, 3}
        }
    },
    [" "] = {
        matrix = {
            {0, 0, 0, 0}
        }
    },
    ["!"] = {
        matrix = {
            {3, 1},
            {3, 1},
            {3, 0},
            {3, 0},
            {2, 0},
            {0, 0},
            {3, 1},
            {1, 0}
        }
    },
    ["@"] = {
        matrix = {
            {0, 2, 3, 3, 3, 3, 0},
            {1, 3, 1, 0, 0, 0, 3},
            {3, 1, 2, 3, 3, 1, 3},
            {3, 0, 3, 1, 0, 3, 1},
            {3, 0, 2, 3, 3, 3, 2},
            {3, 1, 0, 0, 0, 0, 0},
            {1, 3, 3, 3, 3, 2, 1}
        }
    },
    ["#"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 2, 1, 2, 1},
            {0, 3, 0, 3, 0},
            {2, 3, 3, 3, 3},
            {0, 3, 0, 3, 0},
            {3, 3, 3, 3, 2},
            {0, 3, 0, 3, 0},
            {1, 2, 1, 2, 0}
        }
    },
    ["$"] = {
        matrix = {
            {0, 0, 3, 0, 0},
            {1, 3, 3, 3, 3},
            {3, 0, 3, 0, 1},
            {2, 3, 3, 1, 0},
            {0, 1, 3, 3, 2},
            {1, 0, 3, 0, 3},
            {3, 3, 3, 3, 0},
            {0, 0, 3, 0, 0}
        }
    },
    ["%"] = {
        matrix = {
            {1, 3, 2, 0, 2, 3},
            {3, 0, 3, 0, 3, 1},
            {2, 3, 1, 3, 1, 0},
            {0, 0, 3, 3, 0, 0},
            {0, 1, 3, 1, 3, 2},
            {1, 3, 0, 3, 0, 3},
            {3, 2, 0, 2, 3, 1}
        }
    },
    ["^"] = {
        matrix = {
            {1, 3, 1},
            {3, 1, 3},
            {2, 0, 2}
        }
    },
    ["&"] = {
        matrix = {
            {1, 3, 3, 1, 0, 0},
            {3, 0, 0, 3, 0, 0},
            {3, 0, 1, 0, 0, 0},
            {1, 3, 2, 0, 3, 0},
            {3, 0, 3, 2, 3, 0},
            {3, 0, 0, 3, 1, 0},
            {1, 3, 3, 1, 3, 1}
        },
        isBig = true
    },
    ["("] = {
        matrix = {
            {0, 1, 3},
            {1, 3, 1},
            {3, 1, 0},
            {3, 0, 0},
            {3, 1, 0},
            {1, 3, 1},
            {0, 1, 3}
        }
    },
    [")"] = {
        matrix = {
            {3, 1, 0},
            {1, 3, 1},
            {0, 1, 3},
            {0, 0, 3},
            {0, 1, 3},
            {1, 3, 1},
            {3, 1, 0}
        }
    },
    ["-"] = {
        matrix = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {3, 3, 3, 3}
        }
    },
    ["_"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {3, 3, 3, 3, 3}
        }
    },
    ["="] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {3, 3, 3, 3, 3},
            {0, 0, 0, 0, 0},
            {3, 3, 3, 3, 3}
        }
    },
    ["+"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 2, 0, 0},
            {0, 0, 3, 0, 0},
            {2, 3, 3, 3, 2},
            {0, 0, 3, 0, 0},
            {0, 0, 2, 0, 0}
        }
    },
    ["`"] = {
        matrix = {
            {3, 0},
            {2, 1},
            {0, 2}
        }
    },
    ["~"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 2, 0, 0},
            {1, 3, 1, 0, 2},
            {3, 1, 3, 1, 3},
            {2, 0, 1, 3, 0}
        }
    },
    ["["] = {
        matrix = {
            {3, 3, 2},
            {3, 0, 0},
            {3, 0, 0},
            {3, 0, 0},
            {3, 0, 0},
            {3, 0, 0},
            {3, 3, 2}
        }
    },
    ["]"] = {
        matrix = {
            {2, 3, 3},
            {0, 0, 3},
            {0, 0, 3},
            {0, 0, 3},
            {0, 0, 3},
            {0, 0, 3},
            {2, 3, 3}
        }
    },
    ["{"] = {
        matrix = {
            {0, 2, 3},
            {0, 3, 0},
            {0, 3, 0},
            {3, 0, 0},
            {0, 3, 0},
            {0, 3, 0},
            {0, 2, 3}
        }
    },
    ["}"] = {
        matrix = {
            {3, 2, 0},
            {0, 3, 0},
            {0, 3, 0},
            {0, 0, 3},
            {0, 3, 0},
            {0, 3, 0},
            {3, 2, 0}
        }
    },
    [";"] = {
        matrix = {
            {0, 0, 0},
            {0, 0, 0},
            {0, 3, 1},
            {0, 1, 0},
            {0, 0, 0},
            {0, 3, 0},
            {1, 3, 0},
            {3, 0, 0}
        }
    },
    [":"] = {
        matrix = {
            {0, 0, 0},
            {0, 0, 0},
            {0, 3, 1},
            {0, 1, 0},
            {0, 0, 0},
            {0, 1, 0},
            {0, 3, 1}
        }
    },
    ["'"] = {
        matrix = {
            {0, 3},
            {1, 3},
            {3, 1}
        }
    },
    ['"'] = {
        matrix = {
            {0, 3, 0, 3},
            {1, 3, 1, 3},
            {2, 0, 2, 0}
        }
    },
    ["\\"] = {
        matrix = {
            {3, 0, 0, 0},
            {2, 2, 0, 0},
            {0, 3, 0, 0},
            {0, 2, 2, 0},
            {0, 0, 3, 0},
            {0, 0, 2, 2},
            {0, 0, 0, 3}
        }
    },
    ["|"] = {
        matrix = {
            {2},
            {3},
            {3},
            {3},
            {3},
            {3},
            {3},
            {1}
        }
    },
    [","] = {
        matrix = {
            {0, 0},
            {0, 0},
            {0, 0},
            {0, 0},
            {0, 0},
            {0, 0},
            {0, 3},
            {1, 3},
            {3, 0}
        },
        isSmall = true
    },
    ["."] = {
        matrix = {
            {0, 0},
            {0, 0},
            {0, 0},
            {0, 0},
            {0, 0},
            {1, 0},
            {3, 1}
        }
    },
    ["<"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 3, 3},
            {0, 3, 3, 2, 0},
            {3, 2, 1, 0, 0},
            {0, 3, 3, 2, 0},
            {0, 0, 0, 3, 3}
        }
    },
    [">"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0},
            {3, 3, 0, 0, 0},
            {0, 2, 3, 3, 0},
            {0, 0, 1, 2, 3},
            {0, 2, 3, 3, 0},
            {3, 3, 0, 0, 0}
        }
    },
	  ["*"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 2, 3, 2, 0},
            {1, 3, 3, 3, 1},
            {0, 1, 3, 1, 0},
            {0, 3, 1, 3, 0},
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0}
        }
    },
    ["/"] = {
        matrix = {
            {0, 0, 0, 0, 0},
            {0, 0, 0, 0, 3},
            {0, 0, 0, 3, 0},
            {0, 0, 3, 0, 0},
			{0, 3, 0, 0, 0},
            {3, 0, 0, 0, 0},
            {0, 0, 0, 0, 0}
        }
    },
    ["?"] = {
        matrix = {
            {1, 3, 3, 3, 1},
            {3, 1, 0, 0, 3},
            {1, 0, 0, 2, 3},
            {0, 0, 2, 3, 0},
            {0, 1, 3, 0, 0},
            {0, 0, 0, 0, 0},
            {0, 1, 3, 0, 0}
        }
    }
}

function notificationscript()
--- Prevent multiple instances of the script running
if MaticzplNotifications ~= nil then
    return
end

if iscrackmod == true and MANAGER.getsetting("CRK","notifval") == "0" then -- Disable when notification settings turned off in Cracker1000's Mod
    return
end

MaticzplNotifications = {
    lastTimeChecked = nil,
    fpCompare = nil,
    requests = {},
    saveCache = {},
    notifications = {},
    hoveringOnButton = false,
    windowOpen = false,
    scrolled = 0,
    specialMessage = "",
    version = 1
}

local json = {}
local notif = MaticzplNotifications
local MANAGER = rawget(_G, "MANAGER")    
local warning, colorR, colorG, colorB, colorA = 0, 148,148,148,200 --Default colours

local function getcrackertheme() -- Reserved for Cracker1000's Mod
	colorR = ar
	colorG = ag
	colorB = ab
	colorA = al
end --End

--Ik this code is awful but interface from tpt api is very limiting
local mouseX = 0
local mouseY = 0
local justClicked = false
local holdingScroll = false
local scrollLimit = 0
function MaticzplNotifications.DrawMenuContent()
    local function hover(x,y,dx,dy)       
        mouseX = x
        mouseY = y     
    end
    local function click(x,y,button)
        -- inside window
        if x > 418 and y > 250 and x < 418 + 193 and y < 250 + 155 and notif.windowOpen then
            justClicked = true
            
            if x > 418 and x < 418 + 12 and y > 261 and y < 250 + 155 then
                holdingScroll = true
            end
            return false
        end
    end
    local function unclick(x,y,button,reason)
        justClicked = false
        holdingScroll = false
    end
    --Notification Banner
	gfx.fillRect(418,238,193,11,colorR, colorG, colorB, colorA)
	gfx.drawText(480,240,"Notification panel",255,255,255,tonumber(colorA)+50)
	
    --Window
    gfx.fillRect(418,250,193,155,0,0,0,200)
    gfx.drawRect(418,250,193,155,colorR, colorG, colorB, colorA)

    --Exit button
    local exitIsHovering = mouseX > 418 and mouseX < 418 + 12 and mouseY > 250 and mouseY < 250 + 12 and notif.windowOpen
    if exitIsHovering then
        gfx.fillRect(418,250,12,12,128,128,128,colorA) 
		gfx.drawText(395,252,"Exit",colorR, colorG, colorB, colorA)	
    end
    gfx.drawRect(418,250,12,12,colorR, colorG, colorB, colorA)
    gfx.drawText(418+3,250+2,"X")

    --Read All button
    local readAllHovering = mouseX > 418 and mouseX < 418 + 12 and mouseY > 261 and mouseY < 261 + 12 and notif.windowOpen
    if readAllHovering then
        gfx.fillRect(418,261,12,12,128,128,128)   
		gfx.drawText(375,263,"Read all",colorR, colorG, colorB, colorA)			
    end
    gfx.drawRect(418,261,12,12,colorR, colorG, colorB, colorA) 
    gfx.drawText(418+4,261+2,"A")
    
    --Scroll Bar
    local scrollY = 275
    local scrollFieldHeight = 250 + 155 - scrollY
    local barRatio = math.min(1 - (scrollLimit * -5 / 155),1)
    local barHeight = math.max(scrollFieldHeight * barRatio,10)
    if holdingScroll and barHeight + scrollY ~= 404 and scrollLimit ~= 0 then
        -- Wolfram alpha saved me here xd
        notif.scrolled = (scrollLimit*(-(mouseY - barHeight/2) + scrollY - 1)) / (barHeight + scrollY - 404)
    end
    
    if notif.scrolled > 0 then
        notif.scrolled = 0
    end    
    if notif.scrolled < scrollLimit then
        notif.scrolled = scrollLimit
    end
    if scrollLimit ~= 0 then      
        local scrollFraction = notif.scrolled / scrollLimit
        local barPos = scrollY + ((250 + 154 - barHeight - scrollY) * scrollFraction) - 1
        gfx.fillRect(420,barPos,8,barHeight,colorR, colorG, colorB, colorA)
    else
        gfx.fillRect(420,scrollY - 1,8,155 - 26, colorR, colorG, colorB, colorA)  
    end    
    
    --Vertical line
    gfx.drawLine(418+11,250,418+11,250 + 154,colorR, colorG, colorB, colorA)
        
	if #notif.notifications == 0 or notif.specialMessage ~= "" then
        local msg = "No notifications to show";
        msg = msg.."\n"..notif.specialMessage

        gfx.drawText(438,257,msg,228,228,228,255)
    else  
        local y = 252 + notif.scrolled * 5
        local lastTitleY = y
        
        for i, n in ipairs(notif.notifications) do      
            local prev = notif.notifications[i-1]
            
            local saveID = n.save
            local title = n.title
            local msg = n.message
            
            --Group title
            if prev == nil or prev.title ~= title then
                lastTitleY = y
                if y >= 252 and y <= 250+155 - 10 then         
                    gfx.drawLine(418+12,y - 2,418 + 192,y - 2,colorR,colorG,colorB,colorA)     
                    gfx.drawText(418+15,y,title)
                end
                local sx,sy = gfx.textSize(title)
                y = y + sy
            end
            --Message
            if y >= 252 and y <= 250+155 - 10 then         
                gfx.drawText(418+22,y,msg,200,200,200)    
            end    
            local sx,sy = gfx.textSize(msg)
            y = y + sy
            
            local next = notif.notifications[i+1]
            if next == nil or next.title ~= title then
                if mouseX > 418 + 12 and mouseX < 418 + 193 and mouseY > lastTitleY and mouseY < y and mouseY > 250 and mouseY < 250 + 156 then
                    
                    local boxY = math.max(lastTitleY-1,251)
                    local height = math.min(y - boxY - 2,boxY + 155 - 253)
                    if height + boxY > 404 then --this is confusing
                        height = height - (height + boxY - 404)
                    end
                    gfx.drawRect(418 + 12,boxY,193 - 13,height)
                    
                    if justClicked then
                        local removing = i
                        while notif.notifications[removing].title == title do
                            table.remove(notif.notifications,removing)    
                            removing = removing - 1
                            if notif.notifications[removing] == nil then
                                break
                            end
                        end
                        notif.SaveNotifications()
                        
                        sim.loadSave(saveID)
                    end
                end
            end
            
            scrollLimit = -math.max((y - 250 - 154) / 5 - notif.scrolled, 0) 
        end
    end
  
    event.register(event.mousedown,click)
    event.register(event.mousemove,hover)
    event.register(event.mouseup,unclick)
    
    if exitIsHovering and justClicked then        
        notif.windowOpen = false
        notif.specialMessage = ""
        notif.SaveNotifications()
		warning = 0
        return false
    end    
    if readAllHovering and justClicked then      
        notif.notifications = {} 
        notif.SaveNotifications()
        return false
    end    
    justClicked = false
end
function MaticzplNotifications.ShowSpecialMesasge(msg)
    notif.specialMessage = msg;
	warning = 1
end

-- Request save data from the server
-- Called automatically every 5 minutes
function MaticzplNotifications.CheckForChanges()
    local name = tpt.get_name()
    if name ~= "" then          
        -- FP
        notif.fpCompare = http.get("https://powdertoy.co.uk/Browse.json?Start=0&Count=16");
        -- By date
        table.insert(notif.requests, http.get("https://powdertoy.co.uk/Browse.json?Start=0&Count=30&Search_Query=sort%3Adate%20user%3A"..name))
        table.insert(notif.requests, http.get("https://powdertoy.co.uk/Browse.json?Start=30&Count=30&Search_Query=sort%3Adate%20user%3A"..name))
        -- By votes
        table.insert(notif.requests, http.get("https://powdertoy.co.uk/Browse.json?Start=0&Count=30&Search_Query=user%3A"..name))
        table.insert(notif.requests, http.get("https://powdertoy.co.uk/Browse.json?Start=30&Count=30&Search_Query=user%3A"..name))
    end 
end

-- Called when recieved response from teh server after calling CheckForUpdates()
function MaticzplNotifications.OnResponse()
    local function split (input, sep)
        if sep == nil then
            sep = "%s"
        end
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
            table.insert(t, str)
        end
        return t
    end
    
    local saves = {}
    for id, req in ipairs(notif.requests) do
        local res = req:finish()
        
        local success, found = pcall(json.parse,res)
        if not success then
            notif.ShowSpecialMesasge("Error while fetching saves\nfrom the server.")
            return
        end
        for k, v in pairs(found.Saves) do
            saves[v.ID] = v            
        end
    end

    local fpRes = notif.fpCompare:finish()
    local success, fpsaves = pcall(json.parse,fpRes)
    if not success then
        notif.ShowSpecialMesasge("Error while fetching FP from server.")
        return
    end
    fpsaves = fpsaves.Saves

    if notif.saveCache ~= nil then
        for id, save in pairs(saves) do
            local isFP = 0
            for _, fpSave in pairs(fpsaves) do
                if fpSave.ID == save.ID then
                    isFP = 1
                end
            end
            saves[id].FP = isFP
            
            local cached = notif.saveCache[save.ID]
            if cached == nil then
                local saved = MANAGER.getsetting("MaticzplNotifications",""..save.ID)
                if saved == nil then
                    notif.saveCache[save.ID] = {}
                    notif.saveCache[save.ID].ScoreUp = save.ScoreUp
                    notif.saveCache[save.ID].ScoreDown = save.ScoreDown
                    notif.saveCache[save.ID].Comments = save.Comments    
                    notif.saveCache[save.ID].FP = isFP
                    notif.saveCache[save.ID].ID = save.ID
                    cached = notif.saveCache[save.ID]              
                else
                    local saved = split(saved,"|")
                    notif.saveCache[save.ID] = {}
                    notif.saveCache[save.ID].ID = save.ID
                    notif.saveCache[save.ID].ScoreUp = saved[2]
                    notif.saveCache[save.ID].ScoreDown = saved[3]
                    notif.saveCache[save.ID].Comments = saved[4]
                    notif.saveCache[save.ID].FP = saved[5]
                    cached = notif.saveCache[save.ID]
                end
            end
            
            if tonumber(isFP) ~= tonumber(cached.FP) then
                if tonumber(isFP) == 1 then
                    notif.AddNotification("This save is now on FP!!!",save.ShortName,save.ID)   
                end 
                if tonumber(cached.FP) == 1 then                
                    notif.AddNotification("This save went off FP.",   save.ShortName,save.ID)  
                end            
            end
            local new = save.ScoreUp - cached.ScoreUp
            if new > 0 then
                notif.AddNotification(new.." new Upvotes!\x0F\1\255\1\238\129\139",save.ShortName,save.ID)            
            end
            new = save.ScoreDown - cached.ScoreDown
            if new > 0 then
                notif.AddNotification(new.." new Downvotes\br\238\129\138",save.ShortName,save.ID)                
            end
            new = save.Comments - cached.Comments
            if new > 0 then
                notif.AddNotification(new.." new Comments",save.ShortName,save.ID)               
            end
            MANAGER.savesetting("MaticzplNotifications",save.ID,notif.SaveToString(save))  
            notif.saveCache[save.ID] = save
        end
    else
        notif.saveCache = {}
    end
    
    notif.SaveNotifications()
end

-- Message to display in notification
-- Title by which multiple notifications will be grouped
-- saveID optional to open save on click
function MaticzplNotifications.AddNotification(message,title,saveID)    
    local notification = {
        ["save"] = saveID,
        ["title"] = title,
        ["message"] = message
    }
    table.insert(notif.notifications, notification)   
end

function MaticzplNotifications.SaveNotifications()
    MANAGER.savesetting("MaticzplNotifications","Notifications",string.gsub(json.stringify(notif.notifications),"\"","~"))    
end

-- Draws the red circle notification button. Called every frame
local timerfornot = 255 -- Blinking not. dot
function MaticzplNotifications.DrawNotifications()

    local number = #notif.notifications
    
    if number > 99 then
        number = "99"
    end

    local posX = 572
    local posY = 415
    if tpt.version.jacob1s_mod ~= nil then
        posX = 584
    end
    if tpt.version.modid == 7 then --TPT Ultimata
        posX = 573
        posY = 435
    end
	if iscrackmod == true then --Cracker1000's Mod
          getcrackertheme()
    end
    local w,h = gfx.textSize(number)
    
    local nw,nh = gfx.textSize(tpt.get_name())
    
    if nw > 58 then
        gfx.fillRect(507,409,72,13,0,0,0,150)            
    end
    if number == 0 then
        gfx.fillCircle(posX,posY,5,5,50,50,50)
        gfx.fillCircle(posX,posY,4,4,60,60,60)
        gfx.drawText(posX + 1 -(w / 2),posY + 2 -(h / 2),number,128,128,128)
		    if warning == 1 then
gfx.drawText(570,412,"X",255,0,0,255)
end
        return
    end

    local brig = 0
    if notif.hoveringOnButton then
        brig = 80
    end
    if timerfornot > 0 then
        timerfornot = timerfornot - 2
    elseif timerfornot <= 0 then
        timerfornot = 255
    end
    
    gfx.fillCircle(posX,posY,6,6,120,brig,brig,timerfornot)
    gfx.fillCircle(posX,posY,5,5,255,brig,brig,timerfornot)
    gfx.drawText(posX + 1 -(w / 2),posY + 2 -(h / 2),number,255,255,255)
end


-- Used for saving current state of saves
function MaticzplNotifications.SaveToString(save)
    local separator = "|"

    return save.ID..separator..save.ScoreUp..separator..save.ScoreDown..separator..save.Comments..separator..save.FP
end


function MaticzplNotifications.Mouse(x,y,dx,dy)
    local posX = 572
    local posY = 415
    if tpt.version.jacob1s_mod ~= nil then
        posX = 585
    end
    
    notif.hoveringOnButton = math.abs(posX - x) < 5 and math.abs(posY - y) < 5
end

function MaticzplNotifications.OnClick(x,y,button)
    if notif.hoveringOnButton then
        notif.scrolled = 0
        notif.windowOpen = true
        
        notif.DrawMenuContent()
        return false
    end
end

function MaticzplNotifications.Scroll(x,y,d)
    d = d / math.abs(d) --clamp to 1 / -1
    
    --In window
    if x > 418 and y > 250 and x < 418 + 193 and y < 250 + 155 and notif.windowOpen then
        notif.scrolled = notif.scrolled + d
        return false
    end
end

function MaticzplNotifications.Tick()
    local time = os.time(os.date("!*t"))
    
    if time - notif.lastTimeChecked > (5 * 60) then
        notif.lastTimeChecked = time
        
        notif.CheckForChanges()
    end
    
    local allDone = true;
    for _, req in ipairs(notif.requests) do
        if req:status() ~= "done" then
            allDone = false
            break
        end
    end    

    if allDone and notif.fpCompare ~= nil and notif.fpCompare:status() == "done" then   
        notif.OnResponse()
        notif.requests = {}
        notif.fpCompare = nil
        MANAGER.savesetting("MaticzplNotifications","lastTime",notif.lastTimeChecked)                    
    end
    
    
    notif.DrawNotifications()
    
    if notif.windowOpen then
        notif.DrawMenuContent()
    end
end

---------------------------------------------------------------------------------
-- JSON parsing from https://gist.github.com/tylerneylon/59f4bcf316be525b30ab  --
-- Credit to tylerneylon                                                       --
-- Stated to be public domain by the author (check comments in the link)       --
---------------------------------------------------------------------------------
--#region

local function kind_of(obj)
    if type(obj) ~= 'table' then return type(obj) end
    local i = 1
    for _ in pairs(obj) do
        if obj[i] ~= nil then i = i + 1 else return 'table' end
    end
    if i == 1 then return 'table' else return 'array' end
end
local function escape_str(s)
    local in_char  = {'\\', '"', '/', '\b', '\f', '\n', '\r', '\t'}
    local out_char = {'\\', '"', '/',  'b',  'f',  'n',  'r',  't'}
    for i, c in ipairs(in_char) do
        s = s:gsub(c, '\\' .. out_char[i])
    end
    return s
end
local function skip_delim(str, pos, delim, err_if_missing)
    pos = pos + #str:match('^%s*', pos)
    if str:sub(pos, pos) ~= delim then
        if err_if_missing then
            error('Expected ' .. delim .. ' near position ' .. pos)
        end
        return pos, false
    end
    return pos + 1, true
end
local function parse_str_val(str, pos, val)
    val = val or ''
    local early_end_error = 'End of input found while parsing string.'
    if pos > #str then error(early_end_error) end
    local c = str:sub(pos, pos)
    if c == '"'  then return val, pos + 1 end
    if c ~= '\\' then return parse_str_val(str, pos + 1, val .. c) end
    -- We must have a \ character.
    local esc_map = {b = '\b', f = '\f', n = '\n', r = '\r', t = '\t'}
    local nextc = str:sub(pos + 1, pos + 1)
    if not nextc then error(early_end_error) end
    return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end
local function parse_num_val(str, pos)
    local num_str = str:match('^-?%d+%.?%d*[eE]?[+-]?%d*', pos)
    local val = tonumber(num_str)
    if not val then error('Error parsing number at position ' .. pos .. '.') end
    return val, pos + #num_str
end
function json.stringify(obj, as_key)
    local s = {}  
    local kind = kind_of(obj)
    if kind == 'array' then
        if as_key then error('Can\'t encode array as key.') end
        s[#s + 1] = '['
        for i, val in ipairs(obj) do
            if i > 1 then s[#s + 1] = ', ' end
            s[#s + 1] = json.stringify(val)
        end
        s[#s + 1] = ']'
    elseif kind == 'table' then
        if as_key then error('Can\'t encode table as key.') end
        s[#s + 1] = '{'
        for k, v in pairs(obj) do
            if #s > 1 then s[#s + 1] = ', ' end
            s[#s + 1] = json.stringify(k, true)
            s[#s + 1] = ':'
            s[#s + 1] = json.stringify(v)
        end
        s[#s + 1] = '}'
    elseif kind == 'string' then
        return '"' .. escape_str(obj) .. '"'
    elseif kind == 'number' then
        if as_key then return '"' .. tostring(obj) .. '"' end
        return tostring(obj)
    elseif kind == 'boolean' then
        return tostring(obj)
    elseif kind == 'nil' then
        return 'null'
    else
        error('Unjsonifiable type: ' .. kind .. '.')
    end
    return table.concat(s)
end
json.null = {}
function json.parse(str, pos, end_delim)
    pos = pos or 1
    if pos > #str then error('Reached unexpected end of input.') end
    local pos = pos + #str:match('^%s*', pos)
    local first = str:sub(pos, pos)
    if first == '{' then
        local obj, key, delim_found = {}, true, true
        pos = pos + 1
        while true do
            key, pos = json.parse(str, pos, '}')
            if key == nil then return obj, pos end
            if not delim_found then error('Comma missing between object items.') end
            pos = skip_delim(str, pos, ':', true)
            obj[key], pos = json.parse(str, pos)
            pos, delim_found = skip_delim(str, pos, ',')
        end
    elseif first == '[' then 
        local arr, val, delim_found = {}, true, true
        pos = pos + 1
        while true do
            val, pos = json.parse(str, pos, ']')
            if val == nil then return arr, pos end
            if not delim_found then error('Comma missing between array items.') end
            arr[#arr + 1] = val
            pos, delim_found = skip_delim(str, pos, ',')
        end
    elseif first == '"' then 
        return parse_str_val(str, pos + 1)
    elseif first == '-' or first:match('%d') then
        return parse_num_val(str, pos)
    elseif first == end_delim then 
        return nil, pos + 1
    else
        local literals = {['true'] = true, ['false'] = false, ['null'] = json.null}
        for lit_str, lit_val in pairs(literals) do
            local lit_end = pos + #lit_str - 1
            if str:sub(pos, lit_end) == lit_str then return lit_val, lit_end + 1 end
        end
        local pos_info_str = 'position ' .. pos .. ': ' .. str:sub(pos, pos + 10)
        error('Invalid json syntax starting at ' .. pos_info_str)
    end
end
--#endregion
-- On launch
notif.lastTimeChecked = MANAGER.getsetting("MaticzplNotifications","lastTime") or 0
local notifJson = MANAGER.getsetting("MaticzplNotifications","Notifications")
if notifJson then
    local jsonStr = string.gsub(notifJson,"~","\"")
    notif.notifications = json.parse(jsonStr)  
end
event.register(event.tick,notif.Tick)
event.register(event.mousemove,notif.Mouse)
event.register(event.mousedown,notif.OnClick)
event.register(event.mousewheel,notif.Scroll)

local name = tpt.get_name()
if name == "" then          
    notif.ShowSpecialMesasge("You need to be logged in\nto use the notifications script.")
end
end
notificationscript()
failsafe = 1 -- Meant to be a global variable, used for detecting script crash
