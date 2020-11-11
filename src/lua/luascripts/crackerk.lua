--Cracker1000's custom script version 2.0

local toggle = Button:new(314,0,23,12, "V", "Toggle additional menus.")
local newmenu = Window:new(-15,-15, 610, 300)
local creditstxt1 = Label:new(110,-20,100, 60,"Welcome to the Mod settings. Tip: 'J' can be used as a shortcut.")
newmenu:addComponent(creditstxt1)

local deletesparkButton =  Button:new(10,28,75,30,"Interface", "shows UI related stuff.")

local UIhidey = Button:new(90,28,80,20,"Hide", "Hides the UI")
local UIhiden = Button:new(90,48,80,20,"Show", "Shows the UI")

local FPS = Button:new(10,60,75,30, "Frame limiter", "Turns the frame limiter on/off.")
local FPS1 = Button:new(90,60,80,20, "On", "Turns the frame limiter on.")
local FPS2 = Button:new(90,80,80,20, "Off", "Turns the frame limiter off.")

local reset= Button:new(10,92,75,30,"Reset", "Reset everything.")

local info= Button:new(10,124,75,30,"Stack tools", "Usefull for subframe.")
local info1= Button:new(90,124,80,20,"Separate", "Removes top most particle from stack.")
local info2= Button:new(90,144,80,20,"Delete", "Leaves top particle and PHOT but remove everything else.")

local Ruler = Button:new(10,156,75,30, "Ruler", "Toggles in game ruler.")
local Ry = Button:new(90,156,80,20,"Hide", "Hides the Ruler")
local Rn = Button:new(90,176,80,20,"Show", "Shows the Ruler. (Press SHIFT)")

local rc = Button:new(10,188,75,30,"Record", "Options for recording frames")
local rc1 = Button:new(90,188,80,20,"Start", "Starts recording")
local rc2 = Button:new(90,206,80,20,"Stop","Stops recording")

local bar = Button:new(10,220,75,30,"Top bar", "Toggle top bar")
local bary = Button:new(90,220,80,20,"Show", "Shows the bar at top")
local barn = Button:new(90,240,80,20,"Hide", "Hides the bar")

local bug = Button:new(10,252,75,30,"Feedback", "Direct to Mod thread for bug report.")
local bug1 = Button:new(90,252,80,30,"Website", "Direct to Mod thread for bug report.")
local bug2 = Button:new(180,252,80,30,"In game", "Direct to Mod thread for bug report.")

local wiki  =  Button:new(203,28,80,30,"Wiki", "Element wiki!")

local bare = Button:new(203,60,80,30,"Hidden Elem.", "Toggle hidden elements.")
local barye = Button:new(293,60,80,20,"Show", "Shows hidden elements")
local barne = Button:new(293,80,80,20,"Hide", "Hides elements")

local mp = Button:new(203,92,80,30,"Theme", "Changes game's theme")
local mp1 = Button:new(293,92,75,20,"Dark", "Change the theme to default")
local mp2 = Button:new(293,112,75,20,"Fire", "Change the theme to Blue")
local mp3 = Button:new(293,132,75,20,"Aqua", "Change the theme to Red")
local mp4 = Button:new(293,152,75,20,"Forest", "Change the theme to Green")
local mp5 = Button:new(293,172,75,20,"Sun", "Change the theme to Yellow")
local mp6 = Button:new(293,192,75,20,"Orange", "Change the theme to Orange")
local mp7 = Button:new(293,212,75,20,"Vanilla", "Change the theme back to Plain white")
local mp8 = Button:new(293,232,75,20,"Pulse", "RBG makes everything better.")

local bg = Button:new(203,124,80,30,"Backgrounds", "Sets different backgrounds.")
local bg1 = Button:new(293,124,75,20,"BLACK", "Default")
local bg2 = Button:new(293,146,75,20,"BLUE", "Blue background")
local bg3 = Button:new(293,166,75,20,"RED", "Red background")
local bg4 = Button:new(293,186,75,20,"GREEN", "Green background")
local bg5 = Button:new(293,206,75,20,"YELLOW", "Yellow background")
local bgI = Button:new(373,124,75,20,"Brighten", "Increase brightness")
local bgD = Button:new(373,146,75,20,"Dimmer", "Decrease brightness")

local autohide= Button:new(203,156,80,30, "Auto Hide HUD", "Hide.")
local autohidey= Button:new(293,156,75,20, "On", "Hide.")
local autohiden= Button:new(293,176,75,20, "Off", "Hide.")


local chud = Button:new(203,188,80,30, "Texter", "Hide.")

local hide= Button:new(528,278,80,20, "Close menu", "Hide.")

function clearm()
newmenu:removeComponent(reset)
newmenu:removeComponent(FPS)
newmenu:removeComponent(deletesparkButton)
newmenu:removeComponent(hide)
newmenu:removeComponent(info)
newmenu:removeComponent(Ruler)
newmenu:removeComponent(mp)
newmenu:removeComponent(rc)
newmenu:removeComponent(bg)
newmenu:removeComponent(bug)
newmenu:removeComponent(bar)
newmenu:removeComponent(bare)
newmenu:removeComponent(wiki)
newmenu:removeComponent(autohide)
newmenu:removeComponent(chud)
end

function clearsb()
newmenu:removeComponent(UIhiden)
newmenu:removeComponent(UIhidey)
newmenu:removeComponent(Ry)
newmenu:removeComponent(Rn)
newmenu:removeComponent(rc1)
newmenu:removeComponent(rc2)
newmenu:removeComponent(bug1)
newmenu:removeComponent(bug2)
newmenu:removeComponent(bg1)
newmenu:removeComponent(bg2)
newmenu:removeComponent(bg3)
newmenu:removeComponent(bg4)
newmenu:removeComponent(bg5)
newmenu:removeComponent(bgI)
newmenu:removeComponent(bgD)
newmenu:removeComponent(FPS1)
newmenu:removeComponent(FPS2)
newmenu:removeComponent(mp1)
newmenu:removeComponent(mp2)
newmenu:removeComponent(mp3)
newmenu:removeComponent(mp4)
newmenu:removeComponent(mp5)
newmenu:removeComponent(mp6)
newmenu:removeComponent(mp7)
newmenu:removeComponent(mp8)
newmenu:removeComponent(bary)
newmenu:removeComponent(barn)
newmenu:removeComponent(barye)
newmenu:removeComponent(barne)
newmenu:removeComponent(info1)
newmenu:removeComponent(info2)
newmenu:removeComponent(autohidey)
newmenu:removeComponent(autohiden)
end

--Texter script hybrid start
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

                elseif fonts['5x7'][currentLetter] then

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


chud:action(function(sender)
local mouseX, mouseY = tpt.mousex, tpt.mousey
local text, element, font = '', 'ARAY', '5x7'
clearsb()
clearm()
local textTextboxs = Textbox:new(98, 55, 40, 20, '', 'element')
local textTextbox = Textbox:new(10, 30, 590, 20, '', 'Text')
local scripthelp = Label:new(3,70,400, 60,"\n\nTexter help:\nType the desired output element in element textbox. You can also insert newlines.\nPress Enter to place the text once you are done.")
local place = Button:new(10,55,40,20,"Enter", "Toggle hidden elements.")
local cancel= Button:new(52,55,40,20,"Cancel", "Shows hidden elements")
newmenu:addComponent(textTextbox)
newmenu:addComponent(textTextboxs)
newmenu:addComponent(scripthelp) 
newmenu:addComponent(place)
newmenu:addComponent(cancel)

 textTextbox:onTextChanged(
                    function(sender)
                            text = textTextbox:text();
                    end
                )

 textTextboxs:onTextChanged(
                    function(sender)
                            element = textTextboxs:text();
                    end
                )


cancel:action(function(sender)
newmenu:removeComponent(scripthelp)
newmenu:removeComponent(textTextbox)
newmenu:removeComponent(textTextboxs)
newmenu:removeComponent(place)
newmenu:removeComponent(cancel)
close()
end)

place:action(function(sender)
newmenu:removeComponent(scripthelp)
newmenu:removeComponent(textTextbox)
newmenu:removeComponent(textTextboxs)
newmenu:removeComponent(place)
newmenu:removeComponent(cancel)
close()
drawText(string.gsub(text, '\\n', '\n') .. '\n', 11, 70, element, font)
end)
end)

--Texter script hybrid end

function autohidehud()
	if tpt.mousey <= 55 then tpt.hud(0) else tpt.hud(1)
	end
end

autohide:action(function(sender)
clearsb()
newmenu:addComponent(autohidey)
newmenu:addComponent(autohiden)
end)

autohidey:action(function(sender)
tpt.register_step(autohidehud)
clearsb()
end)

autohiden:action(function(sender)
tpt.unregister_step(autohidehud)
clearsb()
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
sim.loadSave(2596812,0) 
clearsb()
end)

bare:action(function(sender)
clearsb()
newmenu:addComponent(barye)
newmenu:addComponent(barne)
end)

barye:action(function(sender)
tpt.el.dyst.menusection=8
tpt.el.eqve.menusection=8
tpt.el.shd4.menusection=9
tpt.el.shd3.menusection=9
tpt.el.shd2.menusection=9
tpt.el.lolz.menusection=11
tpt.el.love.menusection=11
tpt.el.embr.menusection=4
tpt.el.spwn.menusection=11
tpt.el.spwn2.menusection=11
tpt.el.frzw.menusection=7
tpt.el.bizs.menusection=9
tpt.el.bizg.menusection=6
tpt.el.bray.menusection=9
tpt.el.psts.menusection=8
tpt.el.mort.menusection=5
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
clearsb()
end)

barne:action(function(sender)
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
clearsb()
end)

wiki:action(function(sender)
local creditw = Window:new(-15,-15, 626, 422)
local close2 = Button:new(512, 400, 100, 15, "Close wiki")
local creditstxt = Label:new(6,-25, 598, 418, " WELCOME TO THE OFFLINE WIKI VERSION 2.0.\n\n CWIR: Customisable wire, conducts sprk at variable speed. Use .tmp to customise (Range is 0 to 8), melts at 2000C.\n C-16: A powerful explosive. Explodes creating pressure about 40 units when above 65C.\n TIMC: Time based convertor, converts into it's ctype when sparked with PSCN. Timer set using .tmp, default is 100.\n FUEL: FUEL. Fuel having high calorific value.\n THRM: Thermostat. Sets the temp of surrounding according to its own temp.\n CLNT: Coolant. Cools down the temp of the system, Use .tmp to configure the cooling/heating power. \n DMRN: Demron. Radioactive shielding material and a better insulator.\n FNTC & FPTC: Faster versions of NTCT and PTCT.\n PINV: Powered Invisible, allows particles to move through when activated.\n UV: Ultra violet rays, heals stkm and figh, grows plnt, can sprk pscn and evaporates watr.\n SUN.: Sun, PLNT grow in direction of sunlight, emits radiation, makes PSCN spark and heals STKMs.\n LITH: Lithium ion battery, Use with PSCN and NSCN. Charges with INST when deactivated. Life sets capacity.\n Reacts with different elements like O2, WATR, ACID etc as IRL.\n LED:  Light Emmiting Diode. Use with PSCN and NSCN. Temp sets the brightness.\n Different .tmp2 modes: 0 = white, 1= red, 2= green, 3 =blue, 4= yellow and 5 = pink. \n QGP: Quark Gluon Plasma, bursts out radiation afer sometime. Turns into Purple QGP when under 100C which is stable.\n TMPS: .tmp sensor, creats sprk when there is an element with higher .tmp than its temp.\n PHOS: White, slowly turns into red phosphorus with time. When in contact with O2, burns blue or red based on .tmp.\n Oil reverses the oxidation turning it back into white PHOS. Melts at 45C.\n CMNT: Cement, heats up when mixed with water and gets solidified, darkens when solidified.\n NTRG: Nitrogen gas, liquifies to LN2 when cooled or when under pressure, reacts with H2 to make NITR and puts out fire.\n PRMT: Promethium, radioactive. Catches fire at high velocity (>12), creats NEUT when in reacted with PLUT. \n Explodes at low temp and emits neut at high temp.\n CLUD: Realistic cloud, rains and creates LIGH after sometime.\n BEE: Eats PLNT. Secretes wax when in contact with wood and life > 75.  Attacks STKMs and FIGH.\n Gets aggresive if life gets below 30. Uses pressure waves to communicate when in danger!\n ECLR: Electronic eraser, clears the defined radius when sparked with PSCN. NSCN clears everything. Use.tmp as radius.")
creditw:addComponent(creditstxt)
creditw:addComponent(close2)
close2:action(function() ui.closeWindow(creditw) end)
clearsb()
ui.showWindow(creditw) 
end)

info:action(function(sender)
clearsb()
newmenu:addComponent(info1)
newmenu:addComponent(info2)
end)

info1:action(function(sender)
for i in sim.parts() do
		local x,y = sim.partProperty(i, sim.FIELD_X),sim.partProperty(i, sim.FIELD_Y)
		if sim.pmap (x, y) == i then 
                                tpt.delete(i)
		end
	end
end)

info2:action(function(sender)
for i in sim.parts() do
		local x,y = sim.partProperty(i, sim.FIELD_X),sim.partProperty(i, sim.FIELD_Y)
		if sim.pmap(x, y) ~= i and bit.band(elem.property(sim.partProperty(i, sim.FIELD_TYPE), "Properties"), elem.TYPE_ENERGY) == 0 then
			tpt.delete(i)
		end
	end
end)

bg:action(function(sender)
clearsb()
newmenu:addComponent(bg1)
newmenu:addComponent(bg2)
newmenu:addComponent(bg3)
newmenu:addComponent(bg4)
newmenu:addComponent(bg5)
newmenu:addComponent(bgI)
newmenu:addComponent(bgD)
end)

local as = 60

function backb()
tpt.fillrect(0,0,610,385,0,0,255,as)
end
function backr()
tpt.fillrect(0,0,610,385,255,0,0,as)
end
function backg()
tpt.fillrect(0,0,610,385,0,255,0,as)
end
function backy()
tpt.fillrect(0,0,610,385,255,255,0,as)
end

function clearbg()
newmenu:removeComponent(bgI)
newmenu:removeComponent(bgD)
newmenu:removeComponent(bg5)
newmenu:removeComponent(bg4)
newmenu:removeComponent(bg3)
newmenu:removeComponent(bg2)
newmenu:removeComponent(bg1)
tpt.unregister_step(backy)
tpt.unregister_step(backb)
tpt.unregister_step(backr)
tpt.unregister_step(backg)
end

tgr = 0
tgg  = 0
tgb = 200

bgI:action(function(sender)
as = as+30
end)
bgD:action(function(sender)
as = as-30
end)

bg1:action(function(sender)
clearbg()
tgr = 0
tgg  = 0
tgb = 200
end)
bg2:action(function(sender)
tgr = 0
tgg  = 0
tgb = 200
clearbg()
tpt.register_step(backb)
end)

bg3:action(function(sender)
tgr = 200
tgg  = 0
tgb = 0
clearbg()
tpt.register_step(backr)
end)

bg4:action(function(sender)
tgr = 0
tgg  = 200
tgb = 0
clearbg()
tpt.register_step(backg)
end)

bg5:action(function(sender)
tgr = 200
tgg  = 200
tgb = 0
clearbg()
tpt.register_step(backy)
end)

rc:action(function(sender)
clearsb()
newmenu:addComponent(rc1)
newmenu:addComponent(rc2)
end)

rc1:action(function(sender)
tpt.record(true)
ui.closeWindow(newmenu) 
newmenu:removeComponent(rc1)
newmenu:removeComponent(rc2)
end)

rc2:action(function(sender)
ui.closeWindow(newmenu) 
tpt.record(false)
ui.closeWindow(newmenu) 
newmenu:removeComponent(rc1)
newmenu:removeComponent(rc2)
end)

function theme()
ar = MANAGER.getsetting("CRK", "ar")
ag = MANAGER.getsetting("CRK", "ag")
ab = MANAGER.getsetting("CRK", "ab")
al = MANAGER.getsetting("CRK", "al")
tpt.drawrect(613,1,14,95,ar,ag,ab,al)
tpt.drawrect(613,136,14,269,ar,ag,ab,al)
tpt.drawline(612,408,612,421,ar,ag,ab,al)
tpt.drawline(187,409,187,422,ar,ag,ab,al)
tpt.drawline(469,408,469,421,ar,ag,ab,al)
tpt.drawline(487,408,487,421,ar,ag,ab,al)
tpt.drawline(507,408,507,421,ar,ag,ab,al)

tpt.drawline(241,408,241,421,ar,ag,ab,al)
tpt.drawline(36,408,36,421,ar,ag,ab,al)
tpt.drawline(18,408,18,421,ar,ag,ab,al)
tpt.drawline(580,409,580,422,ar,ag,ab,al)
tpt.drawline(596,409,596,422,ar,ag,ab,al)
tpt.drawrect(1,408,626,14,ar,ag,ab,al)

tpt.drawline(613,96,627,96,ar,ag,ab,al)
tpt.drawline(613,16,627,16,ar,ag,ab,al)
tpt.drawline(613,32,627,32,ar,ag,ab,al)
tpt.drawline(613,48,627,48,ar,ag,ab,al)
tpt.drawline(613,64,627,64,ar,ag,ab,al)
tpt.drawline(613,80,627,80,ar,ag,ab,al)

tpt.drawline(613,151,627,151,ar,ag,ab,al)
tpt.drawline(613,167,627,167,ar,ag,ab,al)
tpt.drawline(613,183,627,183,ar,ag,ab,al)
tpt.drawline(613,199,627,199,ar,ag,ab,al)
tpt.drawline(613,215,627,215,ar,ag,ab,al)
tpt.drawline(613,231,627,231,ar,ag,ab,al)
tpt.drawline(613,247,627,247,ar,ag,ab,al)
tpt.drawline(613,263,627,263,ar,ag,ab,al)
tpt.drawline(613,279,627,279,ar,ag,ab,al)
tpt.drawline(613,295,627,295,ar,ag,ab,al)
tpt.drawline(613,311,627,311,ar,ag,ab,al)
tpt.drawline(613,327,627,327,ar,ag,ab,al)
tpt.drawline(613,343,627,343,ar,ag,ab,al)
tpt.drawline(613,359,627,359,ar,ag,ab,al)
tpt.drawline(613,375,627,375,ar,ag,ab,al)
tpt.drawline(613,391,627,391,ar,ag,ab,al)
end

frameCount,colourRED,colourGRN,colourBLU = 0,0,0,0
function colourblender()
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
tpt.drawrect(613,1,14,95,colourRED,colourGRN,colourBLU,255)
tpt.drawrect(613,136,14,269,colourRED,colourGRN,colourBLU,255)
tpt.drawline(612,408,612,421,colourRED,colourGRN,colourBLU,255)
tpt.drawline(187,409,187,422,colourRED,colourGRN,colourBLU,255)
tpt.drawline(469,408,469,421,colourRED,colourGRN,colourBLU,255)
tpt.drawline(487,408,487,421,colourRED,colourGRN,colourBLU,255)
tpt.drawline(507,408,507,421,colourRED,colourGRN,colourBLU,255)

tpt.drawline(241,408,241,421,colourRED,colourGRN,colourBLU,255)
tpt.drawline(36,408,36,421,colourRED,colourGRN,colourBLU,255)
tpt.drawline(18,408,18,421,colourRED,colourGRN,colourBLU,255)
tpt.drawline(580,409,580,422,colourRED,colourGRN,colourBLU,255)
tpt.drawline(596,409,596,422,colourRED,colourGRN,colourBLU,255)
tpt.drawrect(1,408,626,14,colourRED,colourGRN,colourBLU,255)

tpt.drawline(613,96,627,96,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,16,627,16,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,32,627,32,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,48,627,48,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,64,627,64,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,80,627,80,colourRED,colourGRN,colourBLU,255)

tpt.drawline(613,151,627,151,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,167,627,167,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,183,627,183,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,199,627,199,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,215,627,215,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,231,627,231,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,247,627,247,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,263,627,263,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,279,627,279,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,295,627,295,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,311,627,311,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,327,627,327,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,343,627,343,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,359,627,359,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,375,627,375,colourRED,colourGRN,colourBLU,255)
tpt.drawline(613,391,627,391,colourRED,colourGRN,colourBLU,255)
tpt.drawline(1,0, 312,0,colourRED,colourGRN,colourBLU,250)
tpt.drawline(338,0, 611,0,colourRED,colourGRN,colourBLU,250)
end

mp:action(function(sender)
clearsb()
fs.makeDirectory("scripts")
newmenu:addComponent(mp1)
newmenu:addComponent(mp2)
newmenu:addComponent(mp3)
newmenu:addComponent(mp4)
newmenu:addComponent(mp5)
newmenu:addComponent(mp6)
newmenu:addComponent(mp7)
newmenu:addComponent(mp8)
end)

function mpremove()
newmenu:removeComponent(mp1)
newmenu:removeComponent(mp2)
newmenu:removeComponent(mp3)
newmenu:removeComponent(mp4)
newmenu:removeComponent(mp5)
newmenu:removeComponent(mp6)
newmenu:removeComponent(mp7)
newmenu:removeComponent(mp8)
end

mp1:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",70)
MANAGER.savesetting("CRK","ag",70)
MANAGER.savesetting("CRK","ab",70)
MANAGER.savesetting("CRK","al",255)
tpt.unregister_step(colourblender)
tpt.register_step(theme)
tpt.register_step(topbar)
mpremove()
end)

mp2:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",255)
MANAGER.savesetting("CRK","ag",0)
MANAGER.savesetting("CRK","ab",0)
MANAGER.savesetting("CRK","al",255)
tpt.register_step(theme)
tpt.register_step(topbar)
tpt.unregister_step(colourblender)
mpremove()
end)

mp3:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",0)
MANAGER.savesetting("CRK","ag",0)
MANAGER.savesetting("CRK","ab",255)
MANAGER.savesetting("CRK","al",255)
tpt.register_step(theme)
tpt.unregister_step(colourblender)
tpt.register_step(topbar)
mpremove()
end)

mp4:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",0)
MANAGER.savesetting("CRK","ag",255)
MANAGER.savesetting("CRK","ab",0)
MANAGER.savesetting("CRK","al",255)
tpt.register_step(theme)
tpt.unregister_step(colourblender)
tpt.register_step(topbar)
mpremove()
end)

mp5:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",255)
MANAGER.savesetting("CRK","ag",255)
MANAGER.savesetting("CRK","ab",0)
MANAGER.savesetting("CRK","al",255)
tpt.register_step(topbar)
tpt.register_step(theme)
tpt.unregister_step(colourblender)
mpremove()
end)

mp6:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",255)
MANAGER.savesetting("CRK","ag",150)
MANAGER.savesetting("CRK","ab",0)
MANAGER.savesetting("CRK","al",255)
tpt.register_step(topbar)
tpt.register_step(theme)
tpt.unregister_step(colourblender)
mpremove()
end)

mp7:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",255)
MANAGER.savesetting("CRK","ag",255)
MANAGER.savesetting("CRK","ab",255)
MANAGER.savesetting("CRK","al",255)
tpt.register_step(topbar)
tpt.unregister_step(colourblender)
mpremove()
end)

mp8:action(function(sender)
MANAGER.savesetting("CRK","savergb",1)
tpt.register_step(colourblender)
tpt.unregister_step(topbar)
tpt.unregister_step(theme)
mpremove()
end)

function topbar()
tpt.drawline(1,0, 312,0, ar, ag, ab,200)
tpt.drawline(338,0, 611,0, ar, ag, ab,200)
end

bar:action(function(sender)
clearsb()
newmenu:addComponent(bary)
newmenu:addComponent(barn)
end)

bary:action(function(sender)
tpt.register_step(topbar)
clearsb()
end)

barn:action(function(sender)
tpt.unregister_step(topbar)
clearsb()
end)

function startupcheck()

if MANAGER.getsetting("CRK", "savergb") == "2" then
tpt.register_step(theme)
tpt.register_step(topbar)
else
tpt.register_step(colourblender)
end
end

startupcheck()

Ruler:action(function(sender)
clearsb()
newmenu:addComponent(Ry)
newmenu:addComponent(Rn)
end)

Ry:action(function(sender)
tpt.setdebug(0X0)
newmenu:removeComponent(Ry)
newmenu:removeComponent(Rn)
end)

Rn:action(function(sender)
tpt.setdebug(0X4)
newmenu:removeComponent(Ry)
newmenu:removeComponent(Rn)
end)

deletesparkButton:action(function(sender)
clearsb()
tpt.hud(0)
newmenu:addComponent(UIhidey)
newmenu:addComponent(UIhiden)
end)


function UIhide()
tpt.hud(0)
tpt.fillrect(-1,382,616,42,0,0,0,255)
tpt.fillrect(612,0,17,424,0,0,0,255)
end

UIhidey:action(function(sender)
tpt.hud(0)
newmenu:removeComponent(UIhiden)
newmenu:removeComponent(UIhidey)
tpt.unregister_step(topbar)
tpt.register_step(UIhide)
end)

UIhiden:action(function(sender)
tpt.hud(0)
newmenu:removeComponent(UIhiden)
newmenu:removeComponent(UIhidey)
tpt.unregister_step(UIhide)
tpt.register_step(topbar)
end)

FPS:action(function(sender)
clearsb()
newmenu:addComponent(FPS1)
newmenu:addComponent(FPS2)
end)


FPS1:action(function(sender)
newmenu:removeComponent(FPS1)
newmenu:removeComponent(FPS2)
tpt.setfpscap(60)
end)

FPS2:action(function(sender)
newmenu:removeComponent(FPS1)
newmenu:removeComponent(FPS2)
tpt.setfpscap(2)
end)

reset:action(function(sender)
tpt.unregister_step(autohidehud)
tpt.hud(1)
ui.closeWindow(newmenu) 
tgr = 0
tgg  = 0
tgb = 200
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
tpt.unregister_step(UIhide)
tpt.display_mode(3)
tpt.watertest(0)
sim.edgeMode(0) 
tpt.setfpscap(60)
tpt.setwindowsize(1)
tpt.register_step(colourblender)
tpt.register_step(topbar)
tpt.newtonian_gravity(0)
tpt.decorations_enable(0)
sim.resetPressure()
tpt.ambient_heat(0)
sim.resetTemp()
tpt.reset_velocity(1,380,300,300)
clearbg()
clearsb()
tpt.setdebug(0X0)
sim.clearSim()
end)

function close()
ui.closeWindow(newmenu) 
newmenu:addComponent(toggle)
clearsb()
clearm()
tpt.hud(1)
tpt.set_pause(0)
end

function open()
ui.showWindow(newmenu) 
tpt.set_pause(1)
tpt.hud(0)
newmenu:addComponent(deletesparkButton)
newmenu:addComponent(FPS)
newmenu:addComponent(info)
newmenu:addComponent(reset)
newmenu:addComponent(hide)
newmenu:addComponent(Ruler)
newmenu:addComponent(rc)
newmenu:addComponent(bg)
newmenu:addComponent(mp)
newmenu:addComponent(bug)
newmenu:addComponent(bar)
newmenu:addComponent(bare)
newmenu:addComponent(wiki)
newmenu:addComponent(autohide)
newmenu:addComponent(chud)
newmenu:removeComponent(toggle)
end

hide:action(function(sender)
close()
end)

function keyclicky(key, nkey, modifier, event)
    if (key =="j" and event == 1)  then 
open()
end
end

tpt.register_keypress(keyclicky) 

toggle:action(function(sender)
open()
end)
interface.addComponent(toggle)



--fontstart
fonts ={}
fonts['5x7'] = {}
fonts['5x7']['width'] = 5
fonts['5x7']['height'] = 7
fonts['5x7']['linespacing'] = 4
fonts['5x7']['charspacing'] = 1
fonts['5x7']['a'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 1}
        }
}
fonts['5x7']['b'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['c'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['d'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 1},
                {0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['e'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['f'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {0, 0, 1, 1, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 1, 1, 1, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['g'] = {
        ['descender'] = -2,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 1},
                {0, 0, 0, 0, 1},
                {0, 1, 1, 1, 0}
        }
}
fonts['5x7']['h'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['i'] = {
        ['descender'] = 0,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['j'] = {
        ['descender'] = -2,
        ['kerning'] = -3,
        ['pixels']  = {
                {0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 0, 0, 0}
        }
}
fonts['5x7']['k'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 1, 0},
                {1, 0, 1, 0, 0},
                {1, 1, 0, 0, 0},
                {1, 0, 1, 0, 0},
                {1, 0, 0, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['l'] = {
        ['descender'] = 0,
        ['kerning'] = -3,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['m'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 1, 0, 1, 0},
                {1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['n'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 1, 1, 0},
                {1, 1, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['o'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['p'] = {
        ['descender'] = -2,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0}
        }
}
fonts['5x7']['q'] = {
        ['descender'] = -2,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 1},
                {0, 0, 0, 0, 1},
                {0, 0, 0, 0, 1}
        }
}
fonts['5x7']['r'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 1, 1, 0},
                {1, 1, 0, 0, 1},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['s'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1},
                {1, 0, 0, 0, 0},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 1},
                {1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['t'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 1, 1, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 1, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['u'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['v'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 0, 1, 0},
                {0, 1, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['w'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1},
                {0, 1, 0, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['x'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 1, 0},
                {1, 0, 0, 1, 0},
                {0, 1, 1, 0, 0},
                {1, 0, 0, 1, 0},
                {1, 0, 0, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['y'] = {
        ['descender'] = -2,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 0, 1, 0},
                {0, 1, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {1, 1, 0, 0, 0}
        }
}
fonts['5x7']['z'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1},
                {0, 0, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7'][' '] = {
        ['descender'] = 0,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}


fonts['5x7']['0'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 1, 1},
                {1, 0, 1, 0, 1},
                {1, 1, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['1'] = {
        ['descender'] = 0,
        ['kerning'] = -3,
        ['pixels']  = {
                {0, 1, 0, 0, 0},
                {1, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['2'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 1},
                {0, 0, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['3'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1},
                {0, 0, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['4'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 1},
                {0, 0, 0, 1, 1},
                {0, 0, 1, 0, 1},
                {0, 1, 0, 0, 1},
                {1, 1, 1, 1, 1},
                {0, 0, 0, 0, 1},
                {0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['5'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 1, 1, 1, 0},
                {0, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['6'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 1, 1, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['7'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {1, 1, 1, 1, 0},
                {0, 0, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['8'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['9'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 1},
                {0, 0, 0, 0, 1},
                {0, 0, 0, 1, 0},
                {0, 1, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['.'] = {
        ['descender'] = 0,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['<'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['>'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['@'] = {
        ['descender'] = -2,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 1, 0, 0, 1},
                {1, 0, 1, 0, 1},
                {1, 1, 0, 0, 1},
                {0, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0}
        }
}

fonts['5x7']['#'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 0, 1, 0},
                {1, 1, 1, 1, 1},
                {0, 1, 0, 1, 0},
                {1, 1, 1, 1, 1},
                {0, 1, 0, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['$'] = {
        ['descender'] = -2,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 1, 0, 0},
                {0, 1, 1, 1, 0},
                {1, 0, 1, 0, 1},
                {1, 0, 1, 0, 0},
                {0, 1, 1, 1, 0},
                {0, 0, 1, 0, 1},
                {1, 0, 1, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 1, 0, 0}
        }
}

fonts['5x7']['%'] = {
        ['descender'] = -1,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {1, 1, 0, 0, 1},
                {1, 1, 0, 0, 1},
                {0, 0, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 0, 1, 1},
                {1, 0, 0, 1, 1},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['^'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 1, 0, 0},
                {0, 1, 0, 1, 0},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['{'] = {
        ['descender'] = -2,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0}
        }
}

fonts['5x7']['}'] = {
        ['descender'] = -2,
        ['kerning'] = -2,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 0, 0, 0}
        }
}

fonts['5x7']['&'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 1, 0, 1},
                {1, 0, 0, 1, 0},
                {0, 1, 1, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['*'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0},
                {1, 0, 1, 0, 1},
                {0, 1, 1, 1, 0},
                {1, 0, 1, 0, 1},
                {0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['('] = {
        ['descender'] = -2,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0}
        }
}

fonts['5x7'][')'] = {
        ['descender'] = -2,
        ['kerning'] = -2,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 0, 0, 0}
        }
}

fonts['5x7']['='] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['['] = {
        ['descender'] = -2,
        ['kerning'] = -3,
        ['pixels']  = {
                {1, 1, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 1, 0, 0, 0}
        }
}

fonts['5x7'][']'] = {
        ['descender'] = -2,
        ['kerning'] = -3,
        ['pixels']  = {
                {1, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 1, 0, 0, 0}
        }
}

fonts['5x7']['|'] = {
        ['descender'] = -2,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0}
        }
}

fonts['5x7']['!'] = {
        ['descender'] = 0,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['?'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 1},
                {0, 0, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7'][','] = {
        ['descender'] = -1,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7'][':'] = {
        ['descender'] = 0,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7'][';'] = {
        ['descender'] = 0,
        ['kerning'] = -4,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['+'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['-'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}

fonts['5x7']['/'] = {
        ['descender'] = -2,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0}
        }
}

fonts['5x7']['NULL'] = {
        ['descender'] = -2,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 1, 1, 1, 1}
        }
}


fonts['5x7']['A'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 1, 0},
                {0, 1, 0, 1, 0},
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['B'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['C'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['D'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['E'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['F'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['G'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 0},
                {1, 0, 1, 1, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['H'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 1, 1, 1, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['I'] = {
        ['descender'] = 0,
        ['kerning'] = -4,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['J'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {0, 0, 0, 1, 0},
                {0, 0, 0, 1, 0},
                {0, 0, 0, 1, 0},
                {0, 0, 0, 1, 0},
                {0, 0, 0, 1, 0},
                {1, 0, 0, 1, 0},
                {0, 1, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['K'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 1},
                {1, 0, 0, 1, 0},
                {1, 0, 1, 0, 0},
                {1, 1, 0, 0, 0},
                {1, 0, 1, 0, 0},
                {1, 0, 0, 1, 0},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['L'] = {
        ['descender'] = 0,
        ['kerning'] = -1,
        ['pixels']  = {
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['M'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 1, 0, 1, 1},
                {1, 1, 0, 1, 1},
                {1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['N'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 1},
                {1, 1, 0, 0, 1},
                {1, 1, 0, 0, 1},
                {1, 0, 1, 0, 1},
                {1, 0, 0, 1, 1},
                {1, 0, 0, 1, 1},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['O'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['P'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['Q'] = {
        ['descender'] = -2,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 1, 0},
                {0, 0, 0, 0, 1}
        }
}
fonts['5x7']['R'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['S'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 1, 1, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 0},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['T'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['U'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['V'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 0, 1, 0},
                {0, 1, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['W'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1},
                {0, 1, 0, 1, 0},
                {0, 1, 0, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['X'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 1, 0},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['Y'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1},
                {0, 1, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['Z'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {1, 1, 1, 1, 1},
                {0, 0, 0, 0, 1},
                {0, 0, 0, 1, 0},
                {0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0},
                {1, 0, 0, 0, 0},
                {1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
--fontstop

