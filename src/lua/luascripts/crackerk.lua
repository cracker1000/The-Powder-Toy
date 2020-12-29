--Cracker1000's custom script version 4.0
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
local bug1 = Button:new(90,252,50,30,"Website", "Direct to Mod thread for bug report.")
local bug2 = Button:new(145,252,50,30,"In game", "Direct to Mod thread for bug report.")

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
local mp9 = Button:new(293,252,75,20,"Custom", "Custom options.")
local rl = Label:new(480, 92, 10, 15, "Red")
local gl = Label:new(480, 112, 10, 15, "Green")
local bl = Label:new(480, 132, 10, 15, "Blue")
local rSlider = Slider:new(373, 92, 100, 15, 255)
local gSlider = Slider:new(373, 112, 100, 15, 255)
local bSlider = Slider:new(373, 132, 100, 15, 255)

local rlb = Label:new(510, 92, 10, 15)
local glb = Label:new(510, 112, 10, 15)
local blb = Label:new(510, 132, 10, 15)

local mpop = Button:new(373,152,75,20,"Done", "Custom options.")

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

local chud = Button:new(203,188,80,30, "Texter", "for text.")

local brightness = Button:new(203,220,80,30, "Brightness", "Adjust brightness.")
local brightSlider = Slider:new(293,220, 100, 15, 255)

local brop = Button:new(293,235,45,20,"On", "Save.")
local bropc = Button:new(342,235,45,20,"Off", "Cancel.")
local brlabel = Label:new(340, 210, 10, 15, "Turned: Off")

local reminder = Button:new(203,252,80,30, "Reminder", "Adjust brightness.")
local remon = Button:new(293,252,45,20,"On", "Save.")
local remoff  = Button:new(293,272,45,20,"Off", "Cancel.")
local remvalue= Label:new(363, 264, 90, 20, "Notifies after 30 mins")
local remlabel = Label:new(40, 284, 10, 15, "Reminder is on.")

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
newmenu:removeComponent(brightness)
newmenu:removeComponent(reminder)
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
newmenu:removeComponent(mp9)
newmenu:removeComponent(bary)
newmenu:removeComponent(barn)
newmenu:removeComponent(barye)
newmenu:removeComponent(barne)
newmenu:removeComponent(info1)
newmenu:removeComponent(info2)
newmenu:removeComponent(autohidey)
newmenu:removeComponent(autohiden)
newmenu:removeComponent(rSlider)
newmenu:removeComponent(gSlider)
newmenu:removeComponent(bSlider)
newmenu:removeComponent(rl)
newmenu:removeComponent(gl)
newmenu:removeComponent(bl)
newmenu:removeComponent(rlb)
newmenu:removeComponent(glb)
newmenu:removeComponent(blb)
newmenu:removeComponent(mpop)
newmenu:removeComponent(brop)
newmenu:removeComponent(bropc)
newmenu:removeComponent(brlabel)
newmenu:removeComponent(brightSlider)
newmenu:removeComponent(remon)
newmenu:removeComponent(remoff)
newmenu:removeComponent(remvalue)
end

local startTime

function remindme()
local endTime = startTime+ 1800
if os.time() >= endTime then
tpt.unregister_step(remindme)
newmenu:removeComponent(remlabel)
tpt.message_box("Activity Reminder!","You have played for 30 mins. Simulation has been paused to save resources. Click dismiss to continue.")
end
end

reminder:action(function(sender)
clearsb()
newmenu:addComponent(remon)
newmenu:addComponent(remoff)
newmenu:addComponent(remvalue)
end)

remon:action(function(sender)
clearsb()
startTime = os.time()
tpt.unregister_step(remindme)
tpt.register_step(remindme)
newmenu:addComponent(remlabel)
newmenu:addComponent(remon)
newmenu:removeComponent(remon)
newmenu:removeComponent(remoff)
newmenu:removeComponent(remvalue)
end)

remoff:action(function(sender)
clearsb()
tpt.unregister_step(remindme)
newmenu:removeComponent(remlabel)
newmenu:removeComponent(remon)
newmenu:removeComponent(remoff)
newmenu:removeComponent(remvalue)
end)

function cbrightness()
tpt.fillrect(-1,-1,629,424,0,0,0,255 - MANAGER.getsetting("CRK", "brightness"))
end

brightness:action(function(sender)
fs.makeDirectory("scripts")
clearsb()
brightSlider:value (MANAGER.getsetting("CRK", "brightness"))
brightSlider:onValueChanged(function() MANAGER.savesetting("CRK", "brightness", brightSlider:value()) end)
newmenu:addComponent(brlabel)
newmenu:addComponent(brightSlider)
newmenu:addComponent(brop)
newmenu:addComponent(bropc)
end)

brop:action(function(sender)
MANAGER.savesetting("CRK", "brightstate", "1")
tpt.unregister_step(cbrightness)
tpt.register_step(cbrightness)
newmenu:removeComponent(brightSlider)
brlabel:text("Turned: on")
newmenu:removeComponent(brlabel)
newmenu:removeComponent(brop)
newmenu:removeComponent(bropc)
end)

bropc:action(function(sender)
MANAGER.savesetting("CRK", "brightstate", "0")
brlabel:text("Turned: off")
tpt.unregister_step(cbrightness)
brightSlider:value("200")
newmenu:removeComponent(brightSlider)
newmenu:removeComponent(brop)
newmenu:removeComponent(brlabel)
newmenu:removeComponent(bropc)
end)

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
local pgno1 = Label:new(30,400,10, 15, "Page 1/2")
local pgno2 = Label:new(30,400,10, 15, "Page 2/2")
local creditw = Window:new(-15,-15, 626, 422)
local prevpg = Button:new(242, 400, 40, 15, "Prev.")
local nextpg = Button:new(292, 400, 40, 15, "Next")
local close2 = Button:new(512, 400, 100, 15, "Close wiki")
local creditstxt = Label:new(6,-25, 598, 418,"\nWELCOME TO THE OFFLINE WIKI\n\n1) CWIR: Customisable wire. Conduction speed set using .tmp property (Range is 0 to 8) \n.tmp2 property is used for setting melting point (default is 2000C).\n\n2) C-16: A powerful explosive. Explodes creating pressure about 40 units when above 65C.\n\n3) TIMC: Time Crystal, converts into it's ctype when sparked with PSCN. Timer set using .tmp, default is 100.\n\n4) FUEL: Powerful fuel, explodes when temp is above 50C or Pressure above 14.\n\n5) THRM: Thermostat. Maintains the surrounding temp based on its own .temp property.\n\n6) CLNT: Coolant. Cools down the temp of the system. Use .tmp to configure the cooling/heating power.\nEvaporates at extreme temperatures into WTRV.\n\n7) DMRN: Demron. Radioactive shielding material and a better indestructible heat insulator.\nIt can also block energy particles like PROT.\n\n8) FNTC & FPTC: Faster versions of NTCT and PTCT. Useful for making faster logic gates.\n\n9) PINV: Powered Invisible, allows particles to move through it only when activated.\nUse PSCN to activate and NSCN to deactivate.\n\n10) UV: UV rays, harms stkms (-5 life every frame), visible with FILT, grows plnt, can sprk pscn and evaporates watr.\nCan split WATR into O2 and H2 when passed through FILT. \n\n11) SUN.: Emits rays which makes PLNT grow in direction of sun, emits UV radiation, makes PSCN spark and heals STKMs.\n\n12) CLUD: Realistic cloud, rains and creates LIGH after sometime (every 1000 frames).\nShines bright when it creates a LIGH.")

local creditstxt2 = Label:new(6,-25, 598, 418,"\n 13) LITH: Lithium ion battery, Use with PSCN and NSCN. Charges with INST when deactivated. Life sets capacity.\n Reacts with different elements like O2, WATR, ACID etc as IRL.\n\n 14) LED:  Light Emmiting Diode. Use PSCN to activate and NSCN to deactivate. Temp sets the brightness.\n Different .tmp2 modes: 0 = white, 1= red, 2= green, 3 =blue, 4= yellow, 5 = pink and 6 = Flash mode.  \n\n 15) QGP: Quark Gluon Plasma, bursts out radiation afer sometime. Turns into Purple QGP when under 100C which is stable.\n Glows yellow before exploding. \n\n 16) TMPS: .tmp sensor, creats sprk when there is an element with higher .tmp than its temp. Supports .tmp deserialisation.\n\n 17) PHOS: Phosphorus. Shiny white  particle when spawned, slowly turns into red phosphorus with time. \n Burns blue or red  when in contact with CFLM or O2 respectively, (based on on .tmp).\n Oil reverses the oxidation turning it back into white PHOS. Melts at 45C.\n\n 18) CMNT: Cement, creates an exothermic reaction when mixed with water and gets solidified, darkens when solid.\n\n 19) NTRG: Nitrogen gas, liquifies to LN2 when cooled or when under pressure, reacts with H2 to make NITR and puts out fire.\n\n 20) PRMT: Promethium, radioactive element. Catches fire at high velocity (>12), creats NEUT when mixed with PLUT. \n Explodes at low temp and emits neut at high temp.\n\n 20) BEE: Eats PLNT. Secretes wax when in contact with wood and life > 75.  Attacks STKMs and FIGH.\n Gets aggresive if life gets below 30. Uses pressure waves to communicate when in danger!\n\n 21) ECLR: Electronic eraser, clears the defined radius (.tmp) when activated (Use with PSCN and NSCN). \n\n 22) PROJ: Projectile, converts into its's ctype upon collision. launch with PSCN.\n Temperature determines power while .tmp is for range.\n\n 23) PPTI and PPTO: Powered Versions of PRTI and PRTO, use with PSCN and NSCN.")

creditw:addComponent(creditstxt)
creditw:addComponent(close2)
creditw:addComponent(nextpg)
creditw:addComponent(pgno1)
creditw:addComponent(prevpg)

prevpg:action(function()
creditw:addComponent(creditstxt)
creditw:removeComponent(creditstxt2)
creditw:removeComponent(pgno2)
creditw:addComponent(pgno1)
end)
nextpg:action(function() 
creditw:addComponent(creditstxt2)
creditw:removeComponent(creditstxt)
creditw:removeComponent(pgno1)
creditw:addComponent(pgno2)
end)

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

if MANAGER.getsetting("CRK", "brightstate") == "1" then
al = brightSlider:value()
else
al = 255
end

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
if MANAGER.getsetting("CRK", "brightstate") == "1" then
al = brightSlider:value()
else
al = 255
end
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
tpt.drawrect(613,1,14,95,colourRED,colourGRN,colourBLU,al)
tpt.drawrect(613,136,14,269,colourRED,colourGRN,colourBLU,al)
tpt.drawline(612,408,612,421,colourRED,colourGRN,colourBLU,al)
tpt.drawline(187,409,187,422,colourRED,colourGRN,colourBLU,al)
tpt.drawline(469,408,469,421,colourRED,colourGRN,colourBLU,al)
tpt.drawline(487,408,487,421,colourRED,colourGRN,colourBLU,al)
tpt.drawline(507,408,507,421,colourRED,colourGRN,colourBLU,al)

tpt.drawline(241,408,241,421,colourRED,colourGRN,colourBLU,al)
tpt.drawline(36,408,36,421,colourRED,colourGRN,colourBLU,al)
tpt.drawline(18,408,18,421,colourRED,colourGRN,colourBLU,al)
tpt.drawline(580,409,580,422,colourRED,colourGRN,colourBLU,al)
tpt.drawline(596,409,596,422,colourRED,colourGRN,colourBLU,al)
tpt.drawrect(1,408,626,14,colourRED,colourGRN,colourBLU,al)

tpt.drawline(613,96,627,96,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,16,627,16,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,32,627,32,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,48,627,48,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,64,627,64,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,80,627,80,colourRED,colourGRN,colourBLU,al)

tpt.drawline(613,151,627,151,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,167,627,167,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,183,627,183,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,199,627,199,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,215,627,215,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,231,627,231,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,247,627,247,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,263,627,263,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,279,627,279,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,295,627,295,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,311,627,311,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,327,627,327,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,343,627,343,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,359,627,359,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,375,627,375,colourRED,colourGRN,colourBLU,al)
tpt.drawline(613,391,627,391,colourRED,colourGRN,colourBLU,al)
tpt.drawline(1,0, 312,0,colourRED,colourGRN,colourBLU,al)
tpt.drawline(338,0, 611,0,colourRED,colourGRN,colourBLU,al)
end

function mpnolag()
tpt.unregister_step(topbar)
tpt.unregister_step(theme)
tpt.register_step(theme)
tpt.register_step(topbar)
tpt.unregister_step(colourblender)
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
newmenu:addComponent(mp9)
end)

mp1:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",70)
MANAGER.savesetting("CRK","ag",70)
MANAGER.savesetting("CRK","ab",70)
MANAGER.savesetting("CRK","al",255)
mpnolag()
clearsb()
end)

mp2:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",255)
MANAGER.savesetting("CRK","ag",0)
MANAGER.savesetting("CRK","ab",0)
MANAGER.savesetting("CRK","al",255)
mpnolag()
clearsb()
end)

mp3:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",0)
MANAGER.savesetting("CRK","ag",0)
MANAGER.savesetting("CRK","ab",255)
MANAGER.savesetting("CRK","al",255)
mpnolag()
clearsb()
end)

mp4:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",0)
MANAGER.savesetting("CRK","ag",255)
MANAGER.savesetting("CRK","ab",0)
MANAGER.savesetting("CRK","al",255)
mpnolag()
clearsb()
end)

mp5:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",255)
MANAGER.savesetting("CRK","ag",255)
MANAGER.savesetting("CRK","ab",0)
MANAGER.savesetting("CRK","al",255)
mpnolag()
clearsb()
end)

mp6:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",255)
MANAGER.savesetting("CRK","ag",150)
MANAGER.savesetting("CRK","ab",0)
MANAGER.savesetting("CRK","al",255)
mpnolag()
clearsb()
end)

mp7:action(function(sender)
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar",255)
MANAGER.savesetting("CRK","ag",255)
MANAGER.savesetting("CRK","ab",255)
MANAGER.savesetting("CRK","al",255)
mpnolag()
clearsb()
end)

mp8:action(function(sender)
MANAGER.savesetting("CRK","savergb",1)
tpt.register_step(colourblender)
tpt.unregister_step(topbar)
tpt.unregister_step(theme)
clearsb()
end)

mp9:action(function(sender)
if MANAGER.getsetting("CRK","ar") == nil then
MANAGER.savesetting("CRK","ar",70)
end
if MANAGER.getsetting("CRK","ag") == nil then
MANAGER.savesetting("CRK","ag",70)
end
if MANAGER.getsetting("CRK","ab") == nil then
MANAGER.savesetting("CRK","ab",70)
end

rlb:text(MANAGER.getsetting("CRK", "ar"))
glb:text(MANAGER.getsetting("CRK", "ag"))
blb:text(MANAGER.getsetting("CRK", "ab"))
rSlider:onValueChanged(function() rclr = rSlider:value() rlb:text(rclr) end)
gSlider:onValueChanged(function() gclr = gSlider:value() glb:text(gclr) end)
bSlider:onValueChanged(function() bclr = bSlider:value() blb:text(bclr) end)
rSlider:value(MANAGER.getsetting("CRK", "ar"))
gSlider:value(MANAGER.getsetting("CRK", "ag"))
bSlider:value(MANAGER.getsetting("CRK", "ab"))
newmenu:addComponent(rSlider)
newmenu:addComponent(gSlider)
newmenu:addComponent(bSlider)
newmenu:addComponent(rl)
newmenu:addComponent(gl)
newmenu:addComponent(bl)
newmenu:addComponent(rlb)
newmenu:addComponent(glb)
newmenu:addComponent(blb)
newmenu:addComponent(mpop)

mpop:action(function(sender)
mpnolag()
MANAGER.savesetting("CRK","savergb",2)
MANAGER.savesetting("CRK","ar", rSlider:value())
MANAGER.savesetting("CRK","ag",gSlider:value())
MANAGER.savesetting("CRK","ab",bSlider:value())
newmenu:removeComponent(rSlider)
newmenu:removeComponent(gSlider)
newmenu:removeComponent(bSlider)
newmenu:removeComponent(rl)
newmenu:removeComponent(gl)
newmenu:removeComponent(bl)
newmenu:removeComponent(rlb)
newmenu:removeComponent(glb)
newmenu:removeComponent(blb)
newmenu:removeComponent(mpop)
clearsb()
end)

end)

function topbar()
if MANAGER.getsetting("CRK", "brightstate") == "1" then
al = brightSlider:value()
else
al = 255
end
tpt.drawline(1,0, 312,0, ar, ag, ab,al)
tpt.drawline(338,0, 611,0, ar, ag, ab,al)
end

bar:action(function(sender)
clearsb()
newmenu:addComponent(bary)
newmenu:addComponent(barn)
end)

bary:action(function(sender)
tpt.unregister_step(topbar)
tpt.register_step(topbar)
clearsb()
end)

barn:action(function(sender)
tpt.unregister_step(topbar)
clearsb()
end)

function startupcheck()
interface.addComponent(toggle)
if MANAGER.getsetting("CRK", "savergb") == "2" then
tpt.register_step(theme)
tpt.register_step(topbar)
else
tpt.register_step(colourblender)
end

if MANAGER.getsetting("CRK", "brightstate") == "1" then
brightSlider:value(MANAGER.getsetting("CRK", "brightness"))
tpt.register_step(cbrightness)
brlabel:text("Turned: on")
else
MANAGER.savesetting("CRK", "brightness",200)
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
tpt.unregister_step(remindme)
newmenu:removeComponent(remlabel)
brlabel:text("Turned: off")
brightSlider:value("200")
tpt.unregister_step(cbrightness)
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
clearsb()
clearm()
end

function open()
ui.showWindow(newmenu) 
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
newmenu:addComponent(brightness)
newmenu:addComponent(reminder)
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

fonts['5x7']['_'] = {
        ['descender'] = 0,
        ['kerning'] = -2,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 1, 1, 0, 0},
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


fonts['5x7']['_'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
fonts['5x7']['"'] = {
        ['descender'] = 0,
        ['kerning'] = 0,
        ['pixels']  = {
                {0, 0, 1, 0, 1},
                {0, 1, 0, 1, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0}
        }
}
--fontstop--Cracker64's Powder Toy Multiplayer
--I highly recommend to use my Autorun Script Manager

local version = 8
local versionstring = "1.0.2"

if TPTMP then if TPTMP.version <= version then TPTMP.disableMultiplayer() else error("newer version already running") end end local get_name = tpt.get_name -- if script already running, replace it
TPTMP = {["version"] = version, ["versionStr"] = versionstring} -- script version sent on connect to ensure server protocol is the same
local issocket,socket = pcall(require,"socket")
if not http then error"Tpt version not supported" end
local using_manager = false
local type = type -- people like to overwrite this function with a global a lot
local _print = print
if MANAGER ~= nil or MANAGER_EXISTS then
	using_manager = true
	_print = MANAGER and MANAGER.print or MANAGER_PRINT
else
	_print = print
end
local hooks_enabled = false --hooks only enabled once you maximize the button

local PORT = 34403 --Change 34403 to your desired port
local KEYBOARD = 1 --only change if you have issues. Only other option right now is 2(finnish).
--Local player vars we need to keep
local L = {mousex=0, mousey=0, realMouseX=0, realMouseY=0, brushx=0, brushy=0, sell=1, sela=296, selr=0, selrep=0, replacemode = 0, mButt=0, mEvent=0, isDrawing=false, dcolour=0, stick2=false, chatHidden=true, flashChat=false,
shift=false, alt=false, ctrl=false, tabs = false, z=false, skipClick=false, pauseNextFrame=false, copying=false, stamp=false, placeStamp=false, lastStamp=nil, lastCopy=nil, smoved=false, rotate=false, sendScreen=false}

local tptversion = tpt.version.build
local jacobsmod = tpt.version.jacob1s_mod~=nil
math.randomseed(os.time())
local username = get_name()
if username == "" then
	username = "Guest#"..math.random(10000,99999)
end
local authToken
if using_manager then
	authToken = MANAGER.getsetting("tptmp", "authtoken")
end
local chatwindow
local lastchan = ''
local con = {connected = false,
		 socket = nil,
		 members = nil,
		 pingTime = os.time()+60}
local function disconnected(reason)
	if con.socket then
		con.socket:close()
	end
	if reason then
		chatwindow:addline(reason,255,50,50)
	else
		chatwindow:addline("Connection was closed",255,50,50)
	end
	con.connected = false
	con.members = {}
	lastchan = ''
end
local function conSend(cmd,msg,endNull)
	if not con.connected then return false,"Not connected" end
	msg = msg or ""
	if endNull then msg = msg.."\0" end
	if cmd then msg = string.char(cmd)..msg end
	con.socket:settimeout(10)
	con.socket:send(msg)
	con.socket:settimeout(0)
end
local function joinChannel(chan)
	conSend(16,chan,true)
	--send some things to new channel
	conSend(34,string.char(L.brushx,L.brushy))
	conSend(37,string.char(math.floor(L.sell/256),L.sell%256))
	conSend(37,string.char(math.floor(64 + L.sela/256),L.sela%256))
	conSend(37,string.char(math.floor(128 + L.selr/256),L.selr%256))
	conSend(37,string.char(math.floor(192 + L.selrep/256),L.selrep%256))
	conSend(38,L.replacemode)
	conSend(65,string.char(math.floor(L.dcolour/16777216),math.floor(L.dcolour/65536)%256,math.floor(L.dcolour/256)%256,L.dcolour%256))
end
local function authenticateGetUser()
	local pref = io.open("powder.pref")
	if not pref then
		return false
	end
	local prefData = pref:read("*a")
	pref:close()
	local user = prefData:match([["User"%s*:%s*(%b{})]])
	if not user then
		return false
	end
	local uid = user:match([["ID"%s*:%s*(%d+)]])
	local sess = user:match([["SessionID"%s*:%s*"([^"]+)"]])
	if not uid or not sess then
		return false
	end
	return uid, sess
end
local function authenticateGetToken(uid, sess)
	local req = http.get("https://powdertoy.co.uk/ExternalAuth.api?Action=Get", { [ "X-Auth-User-Id" ] = uid, [ "X-Auth-Session-Key" ] = sess })
	while req:status() == "running" do
		socket.sleep(0.1)
	end
	local body, code = req:finish()
	if code ~= 200 then
		return nil, "Error code " .. code .. ": " .. body
	end
	local status = body:match([["Status":"([^"]+)"]])
	if status ~= "OK" then
		return nil, "Authentication failed, try logging out and back in and restarting TPT"
	end
	return body:match([["Token":"([^"]+)"]])
end
local function connectToServer(ip,port,nick)
	if con.connected then return false,"Already connected" end
	ip = ip or "tptmp.starcatcher.us"
	port = port or PORT
	local sock = socket.tcp()
	sock:settimeout(10)
	local s,r = sock:connect(ip,port)
	if not s then return false,r end
	sock:settimeout(0.1)
	sock:setoption("keepalive",true)
	sock:send(string.char(tpt.version.major)..string.char(tpt.version.minor)..string.char(TPTMP.version)..nick.."\0")
	local c,r,zs
	local function connectByte()
		repeat
			c,r = sock:receive(1)
			if not c and r~="timeout" then break end
		until c
		return c
	end
	local function connectZString()
		local buf = {}
		while true do
			if not connectByte() then
				return false
			end
			if c == "\0" then
				break
			end
			table.insert(buf, c)
		end
		zs = table.concat(buf)
		return zs
	end
	if not connectByte() then
		return false, r
	end
	for authAttempt = 1, 2 do
		if c~="\3" then
			break
		end
		local uid, sess = authenticateGetUser()
		if uid then
			if not authToken then
				local err
				authToken, err = authenticateGetToken(uid, sess)
				if not authToken then
					return false, err
				end
				if using_manager then
					MANAGER.savesetting("tptmp", "authtoken", authToken)
				end
			end
		else
			authToken = nil
		end
		if authToken then
			sock:send("\1" .. authToken .. "\0")
		else
			sock:send("\0")
		end
		if not connectByte() then
			return false, r
		end
		local cresponse = c
		if c == "\1" then
			if not connectZString() then
				return false, r
			end
			if nick ~= zs then
				nick = zs
				chatwindow:addline("You joined as "..nick,255,255,50)
			end
		else
			authToken = nil
		end
		c = cresponse
	end
	sock:settimeout(0)
	if c~= "\1" then
	if c=="\0" then
		local err=""
		c,r = sock:receive(1)
		while c~="\0" do
		err = err..c
		c,r = sock:receive(1)
		end
		if err=="This nick is already on the server" then
			nick = nick:gsub("(.)$",function(s) local n=tonumber(s) if n and n+1 <= 9 then return n+1 else return nick:sub(-1)..'0' end end)
			return connectToServer(ip,port,nick)
		end
		return false,err
	end
	return false,"Bad Connect"
	end

	con.socket = sock
	con.connected = true
	username = nick
	conSend(34,string.char(L.brushx,L.brushy))
	conSend(37,string.char(math.floor(L.sell/256),L.sell%256))
	conSend(37,string.char(math.floor(64 + L.sela/256),L.sela%256))
	conSend(37,string.char(math.floor(128 + L.selr/256),L.selr%256))
	conSend(37,string.char(math.floor(192 + L.selrep/256),L.selrep%256))
	conSend(38,L.replacemode)
	conSend(65,string.char(math.floor(L.dcolour/16777216),math.floor(L.dcolour/65536)%256,math.floor(L.dcolour/256)%256,L.dcolour%256))
	return true
end
--get up to a null (\0)
local function conGetNull()
	con.socket:settimeout(nil)
	local c,r = con.socket:receive(1)
	if not c and r ~= "timeout" then disconnected() return nil end
	local rstring=""
	while c~="\0" do
	rstring = rstring..c
	c,r = con.socket:receive(1)
	if not c and r ~= "timeout" then disconnected() return nil end
	end
	con.socket:settimeout(0)
	return rstring
end
--get next char/byte
local function cChar()
	con.socket:settimeout(nil)
	local c,r = con.socket:receive(1)
	con.socket:settimeout(0)
	if not c then disconnected() end
	return c
end
local function cByte()
	local byte = cChar()
	return byte and byte:byte() or nil
end
--return table of arguments
local function getArgs(msg)
	if not msg then return {} end
	local args = {}
	for word in msg:gmatch("([^%s%c]+)") do
	table.insert(args,word)
	end
	return args
end

local ui_base local ui_box local ui_text local ui_button local ui_scrollbar local ui_inputbox local ui_chatbox
ui_base = {
new = function()
	local b={}
	b.drawlist = {}
	function b:drawadd(f)
		table.insert(self.drawlist,f)
	end
	function b:draw(...)
		for _,f in ipairs(self.drawlist) do
			if type(f)=="function" then
				f(self,...)
			end
		end
	end
	b.movelist = {}
	function b:moveadd(f)
		table.insert(self.movelist,f)
	end
	function b:onmove(x,y)
		for _,f in ipairs(self.movelist) do
			if type(f)=="function" then
				f(self,x,y)
			end
		end
	end
	return b
end
}
ui_box = {
new = function(x,y,w,h,r,g,b)
	local box=ui_base.new()
	box.x=x box.y=y box.w=w box.h=h box.x2=x+w box.y2=y+h
	box.r=r or 90 box.g=g or 90 box.b=b or 90
	function box:setcolor(r,g,b) self.r=r self.g=g self.b=b end
	function box:setbackground(r,g,b,a) self.br=r self.bg=g self.bb=b self.ba=a end
	box.drawbox=true
	box.drawbackground=false
	box:drawadd(function(self) if self.drawbackground then gfx.fillRect(self.x,self.y,self.w+1,self.h+1,self.br,self.bg,self.bb,self.ba) end
								if self.drawbox then gfx.drawRect(self.x,self.y,self.w+1,self.h+1,self.r,self.g,self.b) end end)
	box:moveadd(function(self,x,y)
		if x then self.x=self.x+x self.x2=self.x2+x end
		if y then self.y=self.y+y self.y2=self.y2+y end
	end)
	return box
end
}
ui_text = {
new = function(text,x,y,r,g,b)
	local txt = ui_base.new()
	txt.text = text
	txt.x=x or 0 txt.y=y or 0 txt.r=r or 255 txt.g=g or 255 txt.b=b or 255
	function txt:setcolor(r,g,b) self.r=r self.g=g self.b=b end
	txt:drawadd(function(self,x,y) gfx.drawText(x or self.x,y or self.y,self.text,self.r,self.g,self.b) end)
	txt:moveadd(function(self,x,y)
		if x then self.x=self.x+x end
		if y then self.y=self.y+y end
	end)
	return txt
end,
--Scrolls while holding mouse over
newscroll = function(text,x,y,vis,force,r,g,b)
	local txt = ui_text.new(text,x,y,r,g,b)
	if not force and tpt.textwidth(text)<vis then return txt end
	txt.visible=vis
	txt.length=string.len(text)
	txt.start=1
	local last=2
	while tpt.textwidth(text:sub(1,last))<vis and last<=txt.length do
		last=last+1
	end
	txt.last=last-1
	txt.minlast=last-1
	txt.ppl=((txt.visible-6)/(txt.length-txt.minlast+1))
	function txt:update(text,pos)
		if text then
			self.text=text
			self.length=string.len(text)
			local last=2
			while tpt.textwidth(text:sub(1,last))<self.visible and last<=self.length do
				last=last+1
			end
			self.minlast=last-1
			self.ppl=((self.visible-6)/(self.length-self.minlast+1))
			if not pos then self.last=self.minlast end
		end
		if pos then
			if pos>=self.last and pos<=self.length then --more than current visible
				local newlast = pos
				local newstart=1
				while tpt.textwidth(self.text:sub(newstart,newlast))>= self.visible do
					newstart=newstart+1
				end
				self.start=newstart self.last=newlast
			elseif pos<self.start and pos>0 then --position less than current visible
				local newstart=pos
				local newlast=pos+1
				while tpt.textwidth(self.text:sub(newstart,newlast))<self.visible and newlast<self.length do
						newlast=newlast+1
				end
				self.start=newstart self.last=newlast-1
			end
			--keep strings as long as possible (pulls from left)
			local newlast=self.last
			if newlast<self.minlast then newlast=self.minlast end
			local newstart=1
			while tpt.textwidth(self.text:sub(newstart,newlast))>= self.visible do
					newstart=newstart+1
			end
			self.start=newstart self.last=newlast
		end
	end
	txt.drawlist={} --reset draw
	txt:drawadd(function(self,x,y)
		gfx.drawText(x or self.x,y or self.y, self.text:sub(self.start,self.last) ,self.r,self.g,self.b)
	end)
	function txt:mouseMove(mx,my,dX,dY)
		local newlast = math.floor((mx-self.x)/self.ppl)+self.minlast
		if newlast<self.minlast then newlast=self.minlast end
		if newlast>0 and newlast~=self.last then
			local newstart=1
			while tpt.textwidth(self.text:sub(newstart,newlast))>= self.visible do
				newstart=newstart+1
			end
			self.start=newstart self.last=newlast
		end
	end
	return txt
end
}
ui_inputbox = {
new=function(x,y,w,h)
	local intext=ui_box.new(x,y,w,h)
	intext.cursor=0
	intext.line=1
	intext.currentline = ""
	intext.focus=false
	intext.t=ui_text.newscroll("",x+2,y+2,w-2,true)
	intext.history={}
	intext.max_history=200
	intext.ratelimit = 0
	intext:drawadd(function(self)
		local cursoradjust=tpt.textwidth(self.t.text:sub(self.t.start,self.cursor))+2
		if self.cursor > 0 then gfx.drawLine(self.x+cursoradjust,self.y,self.x+cursoradjust,self.y+10,255,255,255) end
		self.t:draw()
	end)
	intext:moveadd(function(self,x,y) self.t:onmove(x,y) end)
	function intext:setfocus(focus)
		self.focus=focus
		if focus then self:setcolor(255,255,0)
		else self:setcolor(255,255,255) end
	end
	function intext:movecursor(amt)
		self.cursor = self.cursor+amt
		if self.cursor>self.t.length then self.cursor = self.t.length end
		if self.cursor<0 then self.cursor = 0 return end
	end
	function intext:addhistory(str)
		self.history[#self.history+1] = str
		if #self.history >= self.max_history then
			table.remove(self.history, 1)
		end
	end
	function intext:moveline(amt)
		self.line = self.line+amt
		local max = #self.currentline and #self.history+2 or #self.history+1
		if self.line>max then self.line=max
		elseif self.line<1 then self.line=1 end
		local history = self.history[self.line] or ""
		if self.line == #self.history+1 then history = self.currentline end
		self.cursor = string.len(history)
		self.t:update(history, self.cursor)
	end
	function intext:keypress(key, scan, rep, shift, ctrl, alt)
		if not self.focus then
			if key == 13 then
				self:setfocus(true)
			end
			return
		end
		-- Esc
		if key == 27 then
			self:setfocus(false)
		-- Enter
		elseif key == 13 and not rep then
			if socket.gettime() < self.ratelimit then
				return
			end
			local text = self.t.text
			if text == "" then
				self:setfocus(false)
			else
				self.cursor = 0
				self.t.text = ""
				self:addhistory(text)
				self.line = #self.history + 1
				self.currentline = ""
				self.ratelimit = socket.gettime() + 1
				return text
			end
		-- Up
		elseif key == 1073741906 then
			if socket.gettime() < self.ratelimit then
				return
			end
			self:moveline(-1)
		-- Down
		elseif key == 1073741905 then
			self:moveline(1)
		-- Right
		elseif key == 1073741903 then
			self:movecursor(1)
			self.t:update(nil, self.cursor)
		-- Left
		elseif key == 1073741904 then
			self:movecursor(-1)
			self.t:update(nil, self.cursor)
		end

		local newstr
		-- Backspace
		if key == 8 then
			if self.cursor > 0 then
				newstr = self.t.text:sub(1,self.cursor-1) .. self.t.text:sub(self.cursor+1)
				self:movecursor(-1)
			end
		-- Delete
		elseif key == 127 then
			newstr=self.t.text:sub(1,self.cursor) .. self.t.text:sub(self.cursor+2)
		-- Tab
		elseif key == 9 then
			local nickstart, nickend, nick = self.t.text:sub(1,self.cursor+1):find("([^%s%c]+)"..(self.cursor == #self.t.text and "" or " ").."$")
			if con.members and nick then
				for k, v in pairs(con.members) do
					if v.name:sub(1, #nick) == nick then
						nick = v.name
						if nickstart == 1 then
							nick = nick .. ":"
						end
						newstr = self.t.text:sub(1,nickstart-1)..nick.." "..self.t.text:sub(nickend+1, #self.t.text)
						self.cursor = nickstart + #nick
					end
				end
			end
		-- CTRL+C
		elseif scan == 6 and ctrl then
			platform.clipboardPaste(self.t.text)
			tpt.log('Copied to clipboard')
		-- CTRL+V
		elseif scan == 25 and ctrl then
			local paste = platform.clipboardCopy()
			local newText = self.t.text:sub(1, self.cursor) .. paste .. self.t.text:sub(self.cursor + 1)
			self.cursor = self.cursor + #paste
			self.t:update(newText, self.cursor)
		-- CTRL+X
		elseif scan == 27 and ctrl then
			platform.clipboardPaste(self.t.text)
			tpt.log('Copied to clipboard')
			self.cursor = 0
			self.t:update("", 0)
		end
		if newstr then
			self.t:update(newstr,self.cursor)
		end
	end
	function intext:textinput(text)
		if not self.focus then
			return
		end
		-- TPT font has no unicode characters at the moment, nor does it have a good enough api to support them
		if #text > 1 or string.byte(text) < 20 or string.byte(text) > 126 then return end
		newstr = self.t.text:sub(1, self.cursor) .. text .. self.t.text:sub(self.cursor + 1)
		self.currentline = newstr
		self.t:update(newstr, self.cursor + 1)
		self:movecursor(1)
	end
	return intext
end
}
ui_scrollbar = {
new = function(x,y,h,t,m)
	local bar = ui_base.new() --use line object as base?
	bar.x=x bar.y=y bar.h=h
	bar.total=t
	bar.numshown=m
	bar.pos=0
	bar.length=math.floor((1/math.ceil(bar.total-bar.numshown+1))*bar.h)
	bar.soffset=math.floor(bar.pos*((bar.h-bar.length)/(bar.total-bar.numshown)))
	function bar:update(total,shown,pos)
		self.pos=pos or 0
		if self.pos<0 then self.pos=0 end
		self.total=total
		self.numshown=shown
		self.length= math.floor((1/math.ceil(self.total-self.numshown+1))*self.h)
		self.soffset= math.floor(self.pos*((self.h-self.length)/(self.total-self.numshown)))
	end
	function bar:move(wheel)
		self.pos = self.pos-wheel
		if self.pos < 0 then self.pos=0 end
		if self.pos > (self.total-self.numshown) then self.pos=(self.total-self.numshown) end
		self.soffset= math.floor(self.pos*((self.h-self.length)/(self.total-self.numshown)))
	end
	bar:drawadd(function(self)
		if self.total > self.numshown then
			gfx.drawLine(self.x,self.y+self.soffset,self.x,self.y+self.soffset+self.length)
		end
	end)
	bar:moveadd(function(self,x,y)
		if x then self.x=self.x+x end
		if y then self.y=self.y+y end
	end)
	function bar:mouseWheel(mx,my,wheel)
		if wheel~=0 and not hidden_mode then
			if self.total > self.numshown then
				local previous = self.pos
				self:move(wheel)
				if self.pos~=previous then
					return wheel
				end
			end
		end
	end
	return bar
end
}
ui_button = {
new = function(x,y,w,h,f,text)
	local b = ui_box.new(x,y,w,h)
	b.f=f
	b.t=ui_text.new(text,x+2,y+2)
	b.drawbox=false
	b.clicked = false
	b.invert = false
	b:drawadd(function(self)
		if self.clicked or self.invert then
			tpt.fillrect(self.x,self.y,self.w,self.h)
			local tr=self.t.r local tg=self.t.g local tb=self.t.b
			b.t:setcolor(0,0,0)
			b.t:draw()
			b.t:setcolor(tr,tg,tb)
		else
			b.t:draw()
		end
	end)
	b:moveadd(function(self,x,y)
		self.t:onmove(x,y)
	end)
	function b:mouseDown(mouseX, mouseY, button, reason)
		if mouseX >= self.x and mouseX <= self.x2 and mouseY >= self.y and mouseY <= self.y2 then
			self.clicked = true
			return true
		end
	end
	function b:mouseMove(mouseX, mouseY, dX, dY)
		if not (mouseX >= self.x and mouseX <= self.x2 and mouseY >= self.y and mouseY <= self.y2) then
			self.clicked = false
		end
	end
	function b:mouseUp(mouseX, mouseY, button, reason)
		if self.clicked and mouseX >= self.x and mouseX <= self.x2 and mouseY >= self.y and mouseY <= self.y2 then
			self:f()
			return true
		end
	end
	return b
end
}
ui_chatbox = {
new=function(x,y,w,h)
	local chat=ui_box.new(x,y,w,h)
	chat.moving=false
	chat.lastx=0
	chat.lasty=0
	chat.relx=0
	chat.rely=0
	chat.shown_lines=math.floor(chat.h/10)-2 --one line for top, one for chat
	chat.max_width=chat.w-4
	chat.max_lines=200
	chat.lines = {}
	chat.scrollbar = ui_scrollbar.new(chat.x2-2,chat.y+11,chat.h-22,0,chat.shown_lines)
	chat.inputbox = ui_inputbox.new(x,chat.y2-10,w,10)
	chat.minimize = ui_button.new(chat.x2-15,chat.y,15,10,function() chat.moving=false chat.inputbox:setfocus(false) L.chatHidden=true TPTMP.chatHidden=true end,">>")
	chat:drawadd(function(self)
		local header_pos = self.x+self.w/2-tpt.textwidth("TPT Multiplayer")/2
		local lastchan_width = tpt.textwidth(lastchan)
		self.minimize.t.y = self.y+1 -- aligns the minimize button vertically
		-- channel displayed in the left top corner
		if lastchan == "null" then
			gfx.drawText(self.x+2,self.y+2,'lobby',200,200,0)
		elseif lastchan == "guest" then
			gfx.drawText(self.x+2,self.y+2,'guest lobby',200,200,0)
		else
			if lastchan_width > self.w - 5 then
				while tpt.textwidth(lastchan) > self.w - 5 do
					lastchan = lastchan:sub(1, #lastchan-1)
				end
				lastchan = lastchan:sub(1, #lastchan-3) .. '...'
				gfx.drawText(self.x+2,self.y+2,lastchan,0,200,200)
			end
			gfx.drawText(self.x+2,self.y+2,lastchan,0,200,200)
		end
		if lastchan_width < header_pos - self.x - 15 then
			gfx.drawText(header_pos,self.y+2,"TPT Multiplayer")
		end
		
		gfx.drawLine(self.x+1,self.y+10,self.x2-1,self.y+10,120,120,120)
		self.scrollbar:draw()
		local count=0
		for i,line in ipairs(self.lines) do
			if i>self.scrollbar.pos and i<= self.scrollbar.pos+self.shown_lines then
				line:draw(self.x+3,self.y+12+(count*10))
				count = count+1
			end
		end
		self.inputbox:draw()
		self.minimize:draw()
	end)
	chat:moveadd(function(self,x,y)
		for i,line in ipairs(self.lines) do
			line:onmove(x,y)
		end
		self.scrollbar:onmove(x,y)
		self.inputbox:onmove(x,y)
		self.minimize:onmove(x,y)
	end)
	function chat:addline(line,r,g,b,noflash)
		if not line or line=="" then return end --No blank lines
		local linebreak,lastspace = 0,nil
		for i=0,#line do
			local width = tpt.textwidth(line:sub(linebreak,i+1))
			if width > self.max_width/2 and line:sub(i,i):match("[%s,_%.%-?!]") then
				lastspace = i
			end
			if width > self.max_width or i==#line then
				local pos = (i==#line or not lastspace) and i or lastspace
				table.insert(self.lines,ui_text.new(line:sub(linebreak,pos),self.x,0,r,g,b))
				linebreak = pos+1
				lastspace = nil
			end
		end
		while #self.lines>self.max_lines do table.remove(self.lines,1) end
		self.scrollbar:update(#self.lines,self.shown_lines,#self.lines-self.shown_lines)
		if L.chatHidden and not noflash then L.flashChat=true end
	end
	chat:addline("TPTMP v"..versionstring..": Type '/connect' to join server, or /list for a list of commands.",200,200,200,true)
	function chat:mouseDown(mouseX, mouseY, button)
		if L.chatHidden then return false end
		self.minimize:mouseDown(mouseX, mouseY, button)
		
		local selectedLine = math.floor((mouseY - self.y) / 10)
		-- Mouse outside chat window, defocus it
		if mouseX < self.x or mouseX > self.x2 or mouseY < self.y or mouseY > self.y2 then
			self.inputbox:setfocus(false)
			return false
		end

		-- Copy the selected line
		if button == 3 and selectedLine ~= 0 and selectedLine ~= self.shown_lines+1 and self.lines[self.scrollbar.pos+selectedLine] then
			platform.clipboardPaste(self.lines[self.scrollbar.pos+selectedLine].text)
			tpt.log('Copied to clipboard')
		end

		-- header was grabbed, enable window movement
		if selectedLine == 0 and mouseX < self.minimize.x then
			self.moving = true
			self.lastx = mx
			self.lasty = my
			self.relx = mouseX - self.x
			self.rely = mouseY - self.y
			return true
		-- Textbox clicked
		elseif selectedLine == self.shown_lines + 1 then
			self.inputbox:setfocus(true)
			return true
		end

		-- At this point we know chatbox is selected, ensure window is focused then block mouse events
		if not self.inputbox.focus then
			self.inputbox:setfocus(true)
		end
		return true
	end
	function chat:mouseMove(mouseX, mouseY, dX, dY)
		if self.moving then
			local newx, newy = self.x + dX, self.y + dY
			if newx < 0 then dX = dX - newx end
			if newy < 0 then dY = dY - newy end
			if (newx + self.w) >= sim.XRES then dX = dX - (newx + self.w - sim.XRES) end
			if (newy + self.h) >= sim.YRES then dY = dY - (newy + self.h - sim.YRES) end

			if dX < 0 and mouseX > self.relx + self.x then dX = 0 end
			if dX > 0 and mouseX < self.relx + self.x then dX = 0 end
			if dY < 0 and mouseY > self.rely + self.y then dY = 0 end
			if dY > 0 and mouseY < self.rely + self.y then dY = 0 end
			
			self:onmove(dX, dY)
		end
		self.minimize:mouseMove(mouseX, mouseY, dX, dY)
	end
	function chat:mouseUp(mouseX, mouseY, button, reason)
		self.minimize:mouseUp(mouseX, mouseY, button, reason)
		if self.moving then
			self.moving = false
			return true
		end
	end
	function chat:mouseWheel(mouseX, mouseY, wheel)
		self.scrollbar:mouseWheel(mouseX, mouseY, wheel)
	end
	--commands for chat window
	chatcommands = {
	connect = function(self,msg,args)
		if not issocket then self:addline("No luasockets found") return end
		local newname = pcall(string.dump, get_name) and "Gue".."st#"..math["random"](1111,9888) or get_name()
		local s,r = connectToServer(args[1],tonumber(args[2]), newname~="" and newname or username)
		if not s then self:addline(r,255,50,50) end
		pressedKeys = nil
	end,
	send = function(self,msg,args)
		if tonumber(args[1]) and args[2] then
		local withNull=false
		if args[2]=="true" then withNull=true end
		msg = msg:sub(#args[1]+1+(withNull and #args[2]+2 or 0))
		conSend(tonumber(args[1]),msg,withNull)
		end
	end,
	quit = function(self,msg,args)
		disconnected("Disconnected")
	end,
	disconnect = function(self,msg,args)
		disconnected("Disconnected")
	end,
	join = function(self,msg,args)
		if args[1] then
			joinChannel(args[1])
		end
	end,
	sync = function(self,msg,args)
		if con.connected then L.sendScreen=true end --need to send 67 clear screen
		self:addline("Synced screen to server",255,255,50)
	end,
	help = function(self,msg,args)
		if not args[1] then self:addline("/help <command>, type /list for a list of commands") end
		if args[1] == "connect" then self:addline("(/connect [ip] [port]) -- connect to a TPT multiplayer server, or no args to connect to the default one")
		--elseif args[1] == "send" then self:addline("(/send <something> <somethingelse>) -- send raw data to the server") -- send a raw command
		elseif args[1] == "quit" or args[1] == "disconnect" then self:addline("(/quit, no arguments) -- quit the game")
		elseif args[1] == "join" then self:addline("(/join <channel> -- joins a room on the server")
		elseif args[1] == "sync" then self:addline("(/sync, no arguments) -- syncs your screen to everyone else in the room")
		elseif args[1] == "me" then self:addline("(/me <message>) -- say something in 3rd person") -- send a raw command
		elseif args[1] == "kick" then self:addline("(/kick <nick> <reason>) -- kick a user, only works if you have been in a channel the longest")
		elseif args[1] == "size" then self:addline("(/size <width> <height>) -- sets the size of the chat window")
		elseif args[1] == "clear" then self:addline("(/clear, no arguments) -- clears the chat")
		elseif args[1] == "lobby" then self:addline("(/lobby, no arguments) -- joins the lobby")
		end
	end,
	list = function(self,msg,args)
		local list = ""
		for name in pairs(chatcommands) do
			list=list..name..", "
		end
		self:addline("Commands: "..list:sub(1,#list-2))
	end,
	me = function(self, msg, args)
		if not con.connected then return end
		self:addline("* " .. username .. " ".. table.concat(args, " "),200,200,200)
		conSend(20,table.concat(args, " "),true)
	end,
	kick = function(self, msg, args)
		if not con.connected then return end
		if not args[1] then self:addline("Need a nick! '/kick <nick> [reason]'") return end
		conSend(21, args[1].."\0"..table.concat(args, " ", 2),true)
	end,
	size = function(self, msg, args)
		if args[2] then
			local w, h = tonumber(args[1]), tonumber(args[2])
			if w < 75 or h < 50 then self:addline("size too small") return
			elseif w > sim.XRES-100 or h > sim.YRES-100 then self:addline("size too large") return
			end
			chatwindow = ui_chatbox.new(100,100,w,h)
			chatwindow:setbackground(10,10,10,235) chatwindow.drawbackground=true
			if using_manager then
				MANAGER.savesetting("tptmp", "width", w)
				MANAGER.savesetting("tptmp", "height", h)
			end
		end
	end,
	clear = function(self, msg, args)
		chatwindow.lines = {}
	end,
	lobby = function(self, msg, args)
		joinChannel(username:find("#") and "guest" or "null") -- best effort
	end
	}
	function chat:keypress(key, scan, rep, shift, ctrl, alt)
		if L.chatHidden then return nil end
		local text = self.inputbox:keypress(key, scan, rep, shift, ctrl, alt)
		if text and text~="" then
			local cmd = text:match("^/([^%s]+)")
			if cmd then
				local msg=text:sub(#cmd+3)
				local args = getArgs(msg)
				if chatcommands[cmd] then
					chatcommands[cmd](self,msg,args)
					--self:addline("Executed "..cmd.." "..rest)
					return
				end
			end
			--normal chat
			if con.connected then
				conSend(19,text,true)
				self:addline(username .. ": ".. text,200,200,200)
			else
				self:addline("Not connected to server!",255,50,50)
			end
		end
		if self.inputbox.focus then
			return true
		end
	end
	function chat:textinput(text)
		if L.chatHidden then return end
		self.inputbox:textinput(text)
	end
	return chat
end
}
local fadeText = {}
--A little text that fades away, (align text (left/center/right)?)
local function newFadeText(text,frames,x,y,r,g,b,noremove)
	local t = {ticks=frames,max=frames,text=text,x=x,y=y,r=r,g=g,b=b,keep=noremove}
	t.reset = function(self,text) self.ticks=self.max if text then self.text=text end end
	table.insert(fadeText,t)
	return t
end
--Some text locations for repeated usage
local infoText = newFadeText("",150,245,370,255,255,255,true)
local cmodeText = newFadeText("",120,250,180,255,255,255,true)

local function getypos()
	local ypos = 136
	if jacobsmod and tpt.oldmenu and tpt.oldmenu()==1 then
		ypos = 392
	elseif tpt.num_menus then
		ypos = 392-16*tpt.num_menus()-(not jacobsmod and 16 or 0)
	end
	if using_manager then ypos = ypos - 17 end
	return ypos
end
local jacobsmod_old_menu_check = false
local showbutton = ui_button.new(613,getypos(),14,14,function() if using_manager and not MANAGER.hidden then _print("minimize the manager before opening TPTMP") return end if not hooks_enabled then TPTMP.enableMultiplayer() end L.chatHidden=false TPTMP.chatHidden=false L.flashChat=false end,"Mp")
local flashCount=0
showbutton.drawbox = true showbutton:drawadd(function(self) if L.flashChat then self.almostselected=true flashCount=flashCount+1 if flashCount%25==0 then self.invert=not self.invert end end end)
if using_manager then
	local loadsettings = function() chatwindow = ui_chatbox.new(100, 100, tonumber(MANAGER.getsetting("tptmp", "width")), tonumber(MANAGER.getsetting("tptmp", "height"))) end
	if not pcall(loadsettings) then chatwindow = ui_chatbox.new(100, 100, 225, 150) end
else
	chatwindow = ui_chatbox.new(100, 100, 225, 150)
end
chatwindow:setbackground(10,10,10,235) chatwindow.drawbackground=true

local eleNameTable = {
["DEFAULT_PT_LIFE_GOL"] = 256,["DEFAULT_PT_LIFE_HLIF"] = 257,["DEFAULT_PT_LIFE_ASIM"] = 258,["DEFAULT_PT_LIFE_2x2"] = 259,["DEFAULT_PT_LIFE_DANI"] = 260,
["DEFAULT_PT_LIFE_AMOE"] = 261,["DEFAULT_PT_LIFE_MOVE"] = 262,["DEFAULT_PT_LIFE_PGOL"] = 263,["DEFAULT_PT_LIFE_DMOE"] = 264,["DEFAULT_PT_LIFE_34"] = 265,
["DEFAULT_PT_LIFE_LLIF"] = 276,["DEFAULT_PT_LIFE_STAN"] = 267,["DEFAULT_PT_LIFE_SEED"] = 268,["DEFAULT_PT_LIFE_MAZE"] = 269,["DEFAULT_PT_LIFE_COAG"] = 270,
["DEFAULT_PT_LIFE_WALL"] = 271,["DEFAULT_PT_LIFE_GNAR"] = 272,["DEFAULT_PT_LIFE_REPL"] = 273,["DEFAULT_PT_LIFE_MYST"] = 274,["DEFAULT_PT_LIFE_LOTE"] = 275,
["DEFAULT_PT_LIFE_FRG2"] = 276,["DEFAULT_PT_LIFE_STAR"] = 277,["DEFAULT_PT_LIFE_FROG"] = 278,["DEFAULT_PT_LIFE_BRAN"] = 279,
--walls
["DEFAULT_WL_ERASE"] = 280,["DEFAULT_WL_CNDTW"] = 281,["DEFAULT_WL_EWALL"] = 282,["DEFAULT_WL_DTECT"] = 283,["DEFAULT_WL_STRM"] = 284,
["DEFAULT_WL_FAN"] = 285,["DEFAULT_WL_LIQD"] = 286,["DEFAULT_WL_ABSRB"] = 287,["DEFAULT_WL_WALL"] = 288,["DEFAULT_WL_AIR"] = 289,["DEFAULT_WL_POWDR"] = 290,
["DEFAULT_WL_CNDTR"] = 291,["DEFAULT_WL_EHOLE"] = 292,["DEFAULT_WL_GAS"] = 293,["DEFAULT_WL_GRVTY"] = 294,["DEFAULT_WL_ENRGY"] = 295,
["DEFAULT_WL_NOAIR"] = 296,["DEFAULT_WL_ERASEA"] = 297,["DEFAULT_WL_STASIS"] = 298,
--special tools
["DEFAULT_UI_SAMPLE"] = 299,["DEFAULT_UI_SIGN"] = 300,["DEFAULT_UI_PROPERTY"] = 301,["DEFAULT_UI_WIND"] = 302,
--tools
["DEFAULT_TOOL_HEAT"] = 303,["DEFAULT_TOOL_COOL"] = 304,["DEFAULT_TOOL_AIR"] = 305,["DEFAULT_TOOL_VAC"] = 306,["DEFAULT_TOOL_PGRV"] = 307,["DEFAULT_TOOL_NGRV"] = 308, ["DEFAULT_TOOL_MIX"] = 309,
--decoration tools
["DEFAULT_DECOR_SET"] = 310,["DEFAULT_DECOR_CLR"] = 311,["DEFAULT_DECOR_ADD"] = 312,["DEFAULT_DECOR_SUB"] = 313,["DEFAULT_DECOR_MUL"] = 314,["DEFAULT_DECOR_DIV"] = 315,["DEFAULT_DECOR_SMDG"] = 316,
["DEFAULT_DECOR_LIGH"] = 317, ["DEFAULT_DECOR_DARK"] = 318
}
local gravList= {[0]="Vertical",[1]="Off",[2]="Radial"}
local airList= {[0]="On",[1]="Pressure Off",[2]="Velocity Off",[3]="Off",[4]="No Update"}
local noFlood = {[15]=true,[55]=true,[87]=true,[128]=true,[158]=true}
local noShape = {[55]=true,[87]=true,[128]=true,[158]=true}
local createOverride = {
	[55] = function(rx,ry,c) return 0,0,c end,
	[87] = function(rx,ry,c) local tmp=rx+ry if tmp>55 then tmp=55 end return 0,0,c+bit.lshift(tmp,8) end,
	[88] = function(rx,ry,c) local tmp=rx*4+ry*4+7 if tmp>300 then tmp=300 end return rx,ry,c+bit.lshift(tmp,8) end,
	[128] = function(rx,ry,c) return 0,0,c end,
	[158] = function(rx,ry,c) return 0,0,c end}
local golStart,golEnd=256,279
local wallStart,wallEnd=280,298
local toolStart,toolEnd=303,309
local decoStart,decoEnd=310,318

--Functions that do stuff in powdertoy
local function createPartsAny(x,y,rx,ry,c,brush,user)
	if c>=wallStart then
		if c<= wallEnd then
			if c == 284 then rx,ry = 0,0 end
			sim.createWalls(x,y,rx,ry,c-wallStart,brush)
		elseif c<=toolEnd then
			if c>=toolStart then sim.toolBrush(x,y,rx,ry,c-toolStart,brush) end
		elseif c<= decoEnd then
			sim.decoBrush(x,y,rx,ry,user.dcolour[2],user.dcolour[3],user.dcolour[4],user.dcolour[1],c-decoStart,brush)
		end
		return
	elseif c>=golStart then
		c = 78+(c-golStart)*bit.lshift(1, sim.PMAPBITS)
	end
	if createOverride[c] then
		rx,ry,c = createOverride[c](rx,ry,c)
	end
	sim.createParts(x,y,rx,ry,c,brush,user.replacemode)
end
local function createLineAny(x1,y1,x2,y2,rx,ry,c,brush,user)
	if noShape[c] then return end
	if jacobsmod and c == tpt.element("ball") and not user.shift then return end
	if c>=wallStart then
		if c<= wallEnd then
			if c == 284 then rx,ry = 0,0 end
			sim.createWallLine(x1,y1,x2,y2,rx,ry,c-wallStart,brush)
		elseif c<=toolEnd then
			if c>=toolStart then local str=1.0 if user.drawtype==4 then if user.shift then str=10.0 elseif user.alt then str=0.1 end end sim.toolLine(x1,y1,x2,y2,rx,ry,c-toolStart,brush,str) end
		elseif c<= decoEnd then
			sim.decoLine(x1,y1,x2,y2,rx,ry,user.dcolour[2],user.dcolour[3],user.dcolour[4],user.dcolour[1],c-decoStart,brush)
		end
		return
	elseif c>=golStart then
		c = 78+(c-golStart)*bit.lshift(1, sim.PMAPBITS)
	end
	if createOverride[c] then
		rx,ry,c = createOverride[c](rx,ry,c)
	end
	sim.createLine(x1,y1,x2,y2,rx,ry,c,brush,user.replacemode)
end
local function createBoxAny(x1,y1,x2,y2,c,user)
	if noShape[c] then return end
	if c>=wallStart then
		if c<= wallEnd then
			sim.createWallBox(x1,y1,x2,y2,c-wallStart)
		elseif c<=toolEnd then
			if c>=toolStart then sim.toolBox(x1,y1,x2,y2,c-toolStart) end
		elseif c<= decoEnd then
			sim.decoBox(x1,y1,x2,y2,user.dcolour[2],user.dcolour[3],user.dcolour[4],user.dcolour[1],c-decoStart)
		end
		return
	elseif c>=golStart then
		c = 78+(c-golStart)*bit.lshift(1, sim.PMAPBITS)
	end
	if createOverride[c] then
		_,_,c = createOverride[c](user.brushx,user.brushy,c)
	end
	sim.createBox(x1,y1,x2,y2,c,user and user.replacemode)
end
local function floodAny(x,y,c,cm,bm,user)
	if noFlood[c] then return end
	if c>=wallStart then
		if c<= wallEnd then
			sim.floodWalls(x,y,c-wallStart,bm)
		end
		--other tools shouldn't flood
		return
	elseif c>=golStart then --GoL adjust
		c = 78+(c-golStart)*bit.lshift(1, sim.PMAPBITS)
	end
	if createOverride[c] then
		_,_,c = createOverride[c](user.brushx,user.brushy,c)
	end
	sim.floodParts(x,y,c,cm,user.replacemode)
end
local function lineSnapCoords(x1,y1,x2,y2)
	local nx,ny
	local snapAngle = math.floor(math.atan2(y2-y1, x2-x1)/(math.pi*0.25)+0.5)*math.pi*0.25;
	local lineMag = math.sqrt(math.pow(x2-x1,2)+math.pow(y2-y1,2));
	nx = math.floor(lineMag*math.cos(snapAngle)+x1+0.5);
	ny = math.floor(lineMag*math.sin(snapAngle)+y1+0.5);
	return nx,ny
end

local function rectSnapCoords(x1,y1,x2,y2)
	local nx,ny
	local snapAngle = math.floor((math.atan2(y2-y1, x2-x1)+math.pi*0.25)/(math.pi*0.5)+0.5)*math.pi*0.5 - math.pi*0.25;
	local lineMag = math.sqrt(math.pow(x2-x1,2)+math.pow(y2-y1,2));
	nx = math.floor(lineMag*math.cos(snapAngle)+x1+0.5);
	ny = math.floor(lineMag*math.sin(snapAngle)+y1+0.5);
	return nx,ny
end
local function wallSnapCoords(x, y)
	return math.floor(x / 4) * 4, math.floor(y / 4) * 4
end
local renModes = {[0xff00f270]=1,[-16715152]=1,[0x0400f381]=2,[0xf382]=4,[0xf388]=8,[0xf384]=16,[0xfff380]=32,[1]=0xff00f270,[2]=0x0400f381,[4]=0xf382,[8]=0xf388,[16]=0xf384,[32]=0xfff380}
local function getViewModes()
	local t={0,0,0}
	for k,v in pairs(ren.displayModes()) do
		t[1] = t[1]+v
	end
	for k,v in pairs(ren.renderModes()) do
		t[2] = t[2]+(renModes[v] or 0)
	end
	t[3] = ren.colorMode()
	return t
end

--clicky click
local function playerMouseClick(id,btn,ev)
	local user = con.members[id]
	local createE, checkBut

	--_print(tostring(btn)..tostring(ev))
	if ev==0 then return end
	-- Mouse up event, TPT will "draw" whatever element was last clicked, even if we are releasing a different button
	-- This covers the case where we start drawing a line with rmb, switch to lmb, but then release rmb. The lmb element is drawn
	if ev == 2 then
		if user.lbtn then
			createE,checkBut=user.selectedl,user.lbtn
		elseif user.abtn then
			createE,checkBut=user.selecteda,user.abtn
		elseif user.rbtn then
			createE,checkBut=user.selectedr,user.rbtn
		else
			return
		end
	else
		if btn==1 then
			user.rbtn,user.abtn = false,false
			createE,checkBut=user.selectedl,user.lbtn
		elseif btn==2 then
			user.rbtn,user.lbtn = false,false
			createE,checkBut=user.selecteda,user.abtn
		elseif btn==3 then
			user.lbtn,user.abtn = false,false
			createE,checkBut=user.selectedr,user.rbtn
		else
			return
		end
	end

	--if user.mousex>=sim.XRES or user.mousey>=sim.YRES then user.drawtype=false return end

	if ev==1 then
		if user.mousex >= 0 and user.mousey >= 0 and user.mousex < sim.XRES and user.mousey < sim.YRES then
			user.pmx,user.pmy = user.mousex,user.mousey
			--left box
			if user.ctrl and not user.shift then user.drawtype = 2 return end
			--left line
			if user.shift and not user.ctrl then user.drawtype = 1 return end
			--floodfill
			if user.ctrl and user.shift then floodAny(user.mousex,user.mousey,createE,-1,-1,user) user.drawtype = 3 return end
			--an alt click
			if user.alt then return end
			user.drawtype=4 --normal hold
			createPartsAny(user.mousex,user.mousey,user.brushx,user.brushy,createE,user.brush,user)
		end
	elseif ev==2 and checkBut and user.drawtype then
		local releaseX, releaseY = user.mousex, user.mousey
		
		if user.drawtype==2 then
			if user.alt then user.mousex,user.mousey = rectSnapCoords(user.pmx,user.pmy,releaseX,releaseY) end
			createBoxAny(releaseX,releaseY,user.pmx,user.pmy,createE,user)
		elseif user.drawtype ~= 3 then
			if user.alt then user.mousex,user.mousey = lineSnapCoords(user.pmx,user.pmy,user.mousex,user.mousey) end
			createLineAny(releaseX,releaseY,user.pmx,user.pmy,user.brushx,user.brushy,createE,user.brush,user)
		end
		user.drawtype=false
		user.pmx,user.pmy = user.mousex,user.mousey
	end
end
--To draw continued lines
local function playerMouseMove(id)
	local user = con.members[id]
	local createE, checkBut
	if user.lbtn then
		createE,checkBut=user.selectedl,user.lbtn
	elseif user.rbtn then
		createE,checkBut=user.selectedr,user.rbtn
	elseif user.abtn then
		createE,checkBut=user.selecteda,user.abtn
	else return end
	if user.drawtype~=4 then if user.drawtype==3 then floodAny(user.mousex,user.mousey,createE,-1,-1,user) end return end
	
	if user.mousex>=sim.XRES then user.mousex=sim.XRES-1 end
	if user.mousey>=sim.YRES then user.mousey=sim.YRES-1 end
	createLineAny(user.mousex,user.mousey,user.pmx,user.pmy,user.brushx,user.brushy,createE,user.brush,user)
	user.pmx,user.pmy = user.mousex,user.mousey
end
local function loadStamp(size,x,y,reset)
	con.socket:settimeout(10)
	local s = con.socket:receive(size)
	con.socket:settimeout(0)
	if s then
		local f = io.open(".tmp.stm","wb")
		f:write(s)
		f:close()
		if reset then sim.clearSim() end
		if not sim.loadStamp(".tmp.stm",x,y) then
			infoText:reset("Error loading stamp")
		end
		os.remove".tmp.stm"
	else
		infoText:reset("Error loading empty stamp")
	end
end
local function saveStamp(x, y, w, h)
	local stampName = sim.saveStamp(x, y, w, h) or "errorsavingstamp"
	local fullName = "stamps/"..stampName..".stm"
	return stampName, fullName
end
local function deleteStamp(name)
	if sim.deleteStamp then
		sim.deleteStamp(name)
	else
		os.remove("stamps/"..name..".stm")
	end
end

local dataCmds = {
	[5] = function()
		disconnected(conGetNull())
	end,
	[16] = function()
		local initialJoin = lastchan == ''
		lastchan = conGetNull()
		--room members
		con.members = {}
		local amount = cByte()
		local peeps = {}
		for i=1,amount do
			local id = cByte()
			con.members[id]={name=conGetNull(),mousex=0,mousey=0,brushx=4,brushy=4,brush=0,selectedl=1,selectedr=0,selecteda=296,replacemode=0,dcolour={0,0,0,0},lbtn=false,abtn=false,rbtn=false,ctrl=false,shift=false,alt=false}
			local name = con.members[id].name
			table.insert(peeps,name)
		end
		if not initialJoin then
			chatwindow:addline("Joined channel "..lastchan,50,255,50)
		end
		chatwindow:addline("Online: "..table.concat(peeps," "),255,255,50)
	end,
	[17]= function()
		local id = cByte()
		con.members[id] ={name=conGetNull(),mousex=0,mousey=0,brushx=4,brushy=4,brush=0,selectedl=1,selectedr=0,selecteda=296,replacemode=0,dcolour={0,0,0,0},lbtn=false,abtn=false,rbtn=false,ctrl=false,shift=false,alt=false}
		chatwindow:addline(con.members[id].name.." has joined",100,255,100)
	end,
	[18] = function()
		local id = cByte()
		chatwindow:addline(con.members[id].name.." has left",255,255,100)
		con.members[id]=nil
	end,
	[19] = function()
		chatwindow:addline(con.members[cByte()].name .. ": " .. conGetNull())
	end,
	[20] = function()
		chatwindow:addline("* "..con.members[cByte()].name .. " " .. conGetNull())
	end,
	[22] = function()
		chatwindow:addline("[SERVER] "..conGetNull(), cByte(), cByte(), cByte())
	end,
	--Mouse Position
	[32] = function()
		local id = cByte()
		local b1,b2,b3=cByte(),cByte(),cByte()
		con.members[id].mousex,con.members[id].mousey=((b1*16)+math.floor(b2/16)),((b2%16)*256)+b3
		playerMouseMove(id)
	end,
	--Mouse Click
	[33] = function()
		local id = cByte()
		local d=cByte()
		local btn,ev=math.floor(d/16),d%16
		-- Fake mouseup due to either blur or zoom window
		if btn == 0 then
			local user = con.members[id]
			user.lbtn, user.rbtn, user.abtn, user.drawtype = nil, nil, nil, nil
			return
		end
		playerMouseClick(id,btn,ev)
		if ev==0 then return end
		if ev==2 then ev = nil end
		if btn==1 then
			con.members[id].lbtn=ev
		elseif btn==2 then
			con.members[id].abtn=ev
		elseif btn==3 then
			con.members[id].rbtn=ev
		end
	end,
	--Brush size
	[34] = function()
		local id = cByte()
		con.members[id].brushx,con.members[id].brushy=cByte(),cByte()
	end,
	--Brush Shape change, no args
	[35] = function()
		local id = cByte()
		con.members[id].brush=(con.members[id].brush+1)%3
	end,
	--Modifier (mod and state)
	[36] = function()
		local id = cByte()
		local d=cByte()
		local mod,state=math.floor(d/16),d%16~=0
		if mod==0 then
			con.members[id].ctrl=state
		elseif mod==1 then
			con.members[id].shift=state
		elseif mod==2 then
			con.members[id].alt=state
		end
	end,
	--selected elements (2 bits button, 14-element)
	[37] = function()
		local id = cByte()
		local b1,b2=cByte(),cByte()
		local btn,el=math.floor(b1/64),(b1%64)*256+b2
		if btn==0 then
			con.members[id].selectedl=el
		elseif btn==1 then
			con.members[id].selecteda=el
		elseif btn==2 then
			con.members[id].selectedr=el
		elseif btn==3 then
			--sync replace mode element between all players since apparently you have to set tpt.selectedreplace to use replace mode ...
			tpt.selectedreplace = elem.property(el, "Identifier")
		end
	end,
	--replace mode / specific delete
	[38] = function()
		local id = cByte()
		local mod = cByte()
		con.members[id].replacemode = mod
	end,
	--cmode defaults (1 byte mode)
	[48] = function()
		local id = cByte()
		tpt.display_mode(cByte())
		cmodeText:reset(con.members[id].name.." set:")
	end,
	--pause set (1 byte state)
	[49] = function()
		local id = cByte()
		local p,str = cByte(),"Pause"
		tpt.set_pause(p)
		if p==0 then str="Unpause" end
		infoText:reset(str.." from "..con.members[id].name)
	end,
	--step frame, no args
	[50] = function()
		local id = cByte()
		tpt.set_pause(0)
		L.pauseNextFrame=true
	end,
	--deco mode, (1 byte state)
	[51] = function()
		local id = cByte()
		tpt.decorations_enable(cByte())
		cmodeText:reset(con.members[id].name.." set:")
	end,
	--[[HUD mode, (1 byte state), deprecated
	[52] = function()
		local id = cByte()
		local hstate = cByte()
		tpt.hud(hstate)
	end,
	--]]
	--amb heat mode, (1 byte state)
	[53] = function()
		local id = cByte()
		tpt.ambient_heat(cByte())
	end,
	--newt_grav mode, (1 byte state)
	[54] = function()
		local id = cByte()
		tpt.newtonian_gravity(cByte())
	end,

	--[[
	--debug mode (1 byte state?) can't implement
	[55] = function()
		local id = cByte()
		--local dstate = cByte()
		tpt.setdebug()
	end,
	--]]
	--legacy heat mode, (1 byte state)
	[56] = function()
		local id = cByte()
		tpt.heat(cByte())
	end,
	--water equal, (1 byte state)
	[57] = function()
		local id = cByte()
		sim.waterEqualisation(cByte())
	end,

	--grav mode, (1 byte state)
	[58] = function()
		local id = cByte()
		local mode = cByte()
		sim.gravityMode(mode)
		cmodeText:reset(con.members[id].name.." set: Gravity: "..gravList[mode])
	end,
	--air mode, (1 byte state)
	[59] = function()
		local id = cByte()
		local mode=cByte()
		sim.airMode(mode)
		cmodeText:reset(con.members[id].name.." set: Air: "..airList[mode])
	end,

	--clear sparks (no args)
	[60] = function()
		local id = cByte()
		tpt.reset_spark()
	end,
	--clear pressure/vel (no args)
	[61] = function()
		local id = cByte()
		tpt.reset_velocity()
		tpt.set_pressure()
	end,
	--invert pressure (no args)
	[62] = function()
		local id = cByte()
		for x=0,152 do
			for y=0,95 do
				sim.pressure(x,y,-sim.pressure(x,y))
			end
		end
	end,
	--Clearsim button (no args)
	[63] = function()
		local id = cByte()
		sim.clearSim()
		L.lastSave=nil
		infoText:reset(con.members[id].name.." cleared the screen")
	end,
	--Full graphics view mode (for manual changes in display menu) (3 bytes)
	[64] = function()
		local id = cByte()
		local disM,renM,colM = cByte(),cByte(),cByte()
		ren.displayModes({disM})
		local t,i={},1
		while i<=32 do
			if bit.band(renM,i)>0 then table.insert(t,renModes[i]) end
			i=i*2
		end
		ren.renderModes(t)
		ren.colorMode(colM)
	end,
	--Selected deco colour (4 bytes)
	[65] = function()
		local id = cByte()
		con.members[id].dcolour = {cByte(),cByte(),cByte(),cByte()}
	end,
	--Recieve a stamp, with location (6 bytes location(3),size(3))
	[66] = function()
		local id = cByte()
		local b1,b2,b3=cByte(),cByte(),cByte()
		local x,y =((b1*16)+math.floor(b2/16)),((b2%16)*256)+b3
		local d = cByte()*65536+cByte()*256+cByte()
		loadStamp(d,x,y,false)
		infoText:reset("Stamp from "..con.members[id].name)
	end,
	--Clear an area, helper for cut (6 bytes, start(3), end(3))
	[67] = function()
		local id = cByte()
		local b1,b2,b3,b4,b5,b6=cByte(),cByte(),cByte(),cByte(),cByte(),cByte()
		local x1,y1 =((b1*16)+math.floor(b2/16)),((b2%16)*256)+b3
		local x2,y2 =((b4*16)+math.floor(b5/16)),((b5%16)*256)+b6
		sim.clearRect(x1,y1,x2-x1+1,y2-y1+1)
	end,
	--Edge mode (1 byte state)
	[68] = function()
		local id = cByte()
		sim.edgeMode(cByte())
	end,
	--Load a save ID (3 bytes ID)
	[69] = function()
		local id = cByte()
		local saveID = cByte()*65536+cByte()*256+cByte()
		L.lastSave=saveID
		sim.loadSave(saveID,1)
	end,
	--Reload sim(from a stamp right now, no args)
	[70] = function()
		local id = cByte()
		sim.reloadSave()
		infoText:reset(con.members[id].name.." reloaded the save")
	end,
	--A request to sync a player, from server, send screen, and various settings
	[128] = function()
		local id = cByte()
		conSend(130,string.char(id,49,tpt.set_pause()))
		local stampName,fullName = saveStamp(0,0,sim.XRES-1,sim.YRES-1)
		local f = assert(io.open(fullName,"rb"))
		local s = f:read"*a"
		f:close()
		deleteStamp(stampName)
		local d = #s
		conSend(128,string.char(id,math.floor(d/65536),math.floor(d/256)%256,d%256)..s)
		conSend(130,string.char(id,53,tpt.ambient_heat()))
		conSend(130,string.char(id,54,tpt.newtonian_gravity()))
		conSend(130,string.char(id,56,tpt.heat()))
		conSend(130,string.char(id,57,sim.waterEqualisation()))
		conSend(130,string.char(id,58,sim.gravityMode()))
		conSend(130,string.char(id,59,sim.airMode()))
		conSend(130,string.char(id,68,sim.edgeMode()))
		conSend(64,string.char(unpack(getViewModes())))
		conSend(34,string.char(tpt.brushx,tpt.brushy))
	end,
	--Recieve sync stamp
	[129] = function()
		local d = cByte()*65536+cByte()*256+cByte()
		loadStamp(d,0,0,true)
	end,
}

local function connectThink()
	if not con.connected then return end
	if not con.socket then disconnected() return end
	--read all messages
	while 1 do
		local s,r = con.socket:receive(1)
		if s then
			local cmd = string.byte(s)
			--_print("GOT "..tostring(cmd))
			if dataCmds[cmd] then dataCmds[cmd]() else _print("TPTMP: Unknown protocol "..tostring(cmd),255,20,20) end
		else
			if r ~= "timeout" then disconnected() end
			break
		end
	end

	--ping every minute
	if os.time()>con.pingTime then conSend(2) con.pingTime=os.time()+60 end
end
--Track if we have STKM2 out, for WASD key changes
elements.property(128,"Update",function() L.stick2=true end)

local function drawStuff()
	if con.members then
		for i,user in pairs(con.members) do
			local x,y = user.mousex,user.mousey
			local brx,bry=user.brushx,user.brushy
			local brush,drawBrush=user.brush,true
			gfx.drawText(x,y,("%s %dx%d"):format(user.name,brx,bry),0,255,0,192)

			-- Draw player cursors
			if user.drawtype==1 then
				if user.alt then x,y = lineSnapCoords(user.pmx,user.pmy,x,y) end
				gfx.drawLine(user.pmx,user.pmy,x,y,0,255,0,128)
			elseif user.drawtype==2 then
				if user.alt then x,y = rectSnapCoords(user.pmx,user.pmy,x,y) end
				local tpmx,tpmy = user.pmx,user.pmy
				if tpmx>x then tpmx,x=x,tpmx end
				if tpmy>y then tpmy,y=y,tpmy end
				gfx.drawRect(tpmx,tpmy,x-tpmx+1,y-tpmy+1,0,255,0,128)
				drawBrush=false
			elseif user.drawtype==3 or (user.shift and user.ctrl) then
				gfx.drawLine(x,y,x+5,y,0,255,0,128)
				gfx.drawLine(x,y,x-5,y,0,255,0,128)
				gfx.drawLine(x,y,x,y+5,0,255,0,128)
				gfx.drawLine(x,y,x,y-5,0,255,0,128)
				drawBrush=false
			end

			if drawBrush then
				if user.selectedl >= wallStart and user.selectedl <= wallEnd then
					local blockX, blockY = wallSnapCoords(x, y)
					local blockRadX, blockRadY = wallSnapCoords(brx, bry)
					
					local x1, y1 = blockX - blockRadX, blockY - blockRadY
					local x2, y2 = blockX + blockRadX + 3, blockY + blockRadY + 3
					gfx.drawRect(x1, y1, x2 - x1, y2 - y1)
				elseif brush==0 then
					gfx.drawCircle(x,y,brx,bry,0,255,0,128)
				elseif brush==1 then
					gfx.drawRect(x-brx,y-bry,brx*2+1,bry*2+1,0,255,0,128)
				elseif brush==2 then
					gfx.drawLine(x-brx,y+bry,x,y-bry,0,255,0,128)
					gfx.drawLine(x-brx,y+bry,x+brx,y+bry,0,255,0,128)
					gfx.drawLine(x,y-bry,x+brx,y+bry,0,255,0,128)
				end
			end
		end
	end
	for k,v in pairs(fadeText) do
		if v.ticks > 0 then
			local a = math.floor(255*(v.ticks/v.max))
			gfx.drawText(v.x,v.y,v.text,v.r,v.g,v.b,a)
			v.ticks = v.ticks-1
		else if not v.keep then table.remove(fadeText,k) end
		end
	end
end

local function sendStuff()
	if not con.connected then return end
	if tpt.brushx > 255 then tpt.brushx = 255 end
	if tpt.brushy > 255 then tpt.brushy = 255 end
	local nbx,nby = tpt.brushx,tpt.brushy
	if L.brushx~=nbx or L.brushy~=nby then
		L.brushx,L.brushy = nbx,nby
		conSend(34,string.char(L.brushx,L.brushy))
	end
	--check selected elements
	local nsell,nsela,nselr,nselrep = elements[tpt.selectedl] or eleNameTable[tpt.selectedl],elements[tpt.selecteda] or eleNameTable[tpt.selecteda],elements[tpt.selectedr] or eleNameTable[tpt.selectedr],elements[tpt.selectedreplace] or eleNameTable[tpt.selectedreplace]
	if L.sell~=nsell then
		L.sell=nsell
		if nsell == nil then
			_print("Unsupported wall/tool "..tpt.selectedl)
		else
			conSend(37,string.char(math.floor(L.sell/256),L.sell%256))
		end
	elseif L.sela~=nsela then
		L.sela=nsela
		if nsela == nil then
			_print("Unsupported wall/tool "..tpt.selecteda)
		else
			conSend(37,string.char(math.floor(64 + L.sela/256),L.sela%256))
		end
	elseif L.selr~=nselr then
		L.selr=nselr
		if nselr == nil then
			_print("Unsupported wall/tool "..tpt.selectedr)
		else
			conSend(37,string.char(math.floor(128 + L.selr/256),L.selr%256))
		end
	elseif L.selrep~=nselrep then
		L.selrep=nselrep
		if nselrep == nil then
			_print("Unsupported wall/tool "..tpt.selectedreplace)
		else
			conSend(37,string.char(math.floor(192 + L.selrep/256),L.selrep%256))
		end
	end
	local ncol = sim.decoColour()
	if L.dcolour~=ncol then
		L.dcolour=ncol
		conSend(65,string.char(math.floor(ncol/16777216),math.floor(ncol/65536)%256,math.floor(ncol/256)%256,ncol%256))
	end

	--Tell others to open this save ID, or send screen if opened local browser
	if L.browseMode==1 then
		--loaded online save
		local id=sim.getSaveID()
		if L.lastSave~=id then
			L.lastSave=id
			conSend(69,string.char(math.floor(id/65536),math.floor(id/256)%256,id%256))
		end
		L.browseMode=nil
	elseif L.browseMode==2 then
		--loaded local save (should probably clear sim first instead?)
		L.sendScreen=true
		L.browseMode=nil
	end

	--Send screen (or an area for known size) for stamps
	if jacobsmod and L.sendScreen == 2 then
		L.sendScreen = true
	elseif L.sendScreen then
		local x,y,w,h = 0,0,sim.XRES-1,sim.YRES-1
		if L.smoved then
			local stm
			if L.copying then stm=L.lastCopy else stm=L.lastStamp end
			if L.rotate then stm.w,stm.h=stm.h,stm.w end
			x,y,w,h = math.floor((L.mousex-stm.w/2)/4)*4,math.floor((L.mousey-stm.h/2)/4)*4,stm.w,stm.h
			L.smoved=false
			L.copying=false
		end
		L.sendScreen=false
		local stampName,fullName = saveStamp(x,y,w,h)
		local f = assert(io.open(fullName,"rb"))
		local s = f:read"*a"
		f:close()
		deleteStamp(stampName)
		local d = #s
		local b1,b2,b3 = math.floor(x/16),((x%16)*16)+math.floor(y/256),(y%256)
		conSend(67,string.char(math.floor(x/16),((x%16)*16)+math.floor(y/256),(y%256),math.floor((x+w)/16),(((x+w)%16)*16)+math.floor((y+h)/256),((y+h)%256)))
		conSend(66,string.char(b1,b2,b3,math.floor(d/65536),math.floor(d/256)%256,d%256)..s)
		conSend(49,string.char(tpt.set_pause()))
	end

	--Check if custom modes were changed
	if jacobsmod and L.checkRen == 2 then
		L.checkRen = true
	elseif L.checkRen then
		L.checkRen=false
		local t,send=getViewModes(),false
		for k,v in pairs(t) do
			if v~=L.pModes[k] then
				send=true break
			end
		end
		if send then conSend(64,string.char(t[1],t[2],t[3])) end
	end

	--Send option menu settings
	if L.checkOpt then
		L.checkOpt=false
		conSend(49,string.char(tpt.set_pause()))
		conSend(56,string.char(tpt.heat()))
		conSend(53,string.char(tpt.ambient_heat()))
		conSend(54,string.char(tpt.newtonian_gravity()))
		conSend(57,string.char(sim.waterEqualisation()))
		conSend(58,string.char(sim.gravityMode()))
		conSend(59,string.char(sim.airMode()))
		conSend(68,string.char(sim.edgeMode()))
	end

end
local function updatePlayers()
	if con.members then
		for k,v in pairs(con.members) do
			playerMouseMove(k)
		end
	end
	--Keep last frame of stick2
	L.lastStick2=L.stick2
	L.stick2=false
end

local pressedKeys
local function step()
	if jacobsmod_old_menu_check then showbutton:onmove(0, getypos()-showbutton.y) end
	if not L.chatHidden then chatwindow:draw() else showbutton:draw() end
	if hooks_enabled then
		drawStuff()
		sendStuff()
		if L.pauseNextFrame then L.pauseNextFrame=false tpt.set_pause(1) end
		connectThink()
		updatePlayers()
	end
end

--some button locations that emulate tpt, return false will disable button
local tpt_buttons = {
	["open"] = {x1=1, y1=408, x2=17, y2=422, f=function() if not L.ctrl then L.browseMode=1 else L.browseMode=2 end L.lastSave=sim.getSaveID() end},
	["rload"] = {x1=19, y1=408, x2=35, y2=422, f=function()
		if L.lastSave then
			if L.ctrl then
				infoText:reset("If you re-opened the save, please type /sync")
			else
				conSend(70)
				infoText:reset("Sent sync")
			end
		else
			--[[infoText:reset("Reloading local saves is not synced currently. Type /sync")]]
			L.checkOpt = true
			L.sendScreen = true
		end
	end},
	["clear"] = {x1=470, y1=408, x2=486, y2=422, f=function() conSend(63) L.lastSave=nil end},
	["opts"] = {x1=581, y1=408, x2=595, y2=422, f=function() L.checkOpt=true end},
	["disp"] = {x1=597, y1=408, x2=611, y2=422, f=function() L.checkRen=true L.pModes=getViewModes() end},
	["pause"] = {x1=gfx.WIDTH-16, y1=408, x2=gfx.WIDTH-2, y2=422, f=function() conSend(49,tpt.set_pause()==0 and "\1" or "\0") end},
	["deco"] = {x1=gfx.WIDTH-16, y1=33, x2=gfx.WIDTH-2, y2=47, f=function() if jacobsmod and (L.tabs or L.ctrl) then return end conSend(51,tpt.decorations_enable()==0 and "\1" or "\0") end},
	["newt"] = {x1=gfx.WIDTH-16, y1=49, x2=gfx.WIDTH-2, y2=63, f=function() if jacobsmod and (L.tabs or L.ctrl) then return end conSend(54,tpt.newtonian_gravity()==0 and "\1" or "\0") end},
	["ambh"] = {x1=gfx.WIDTH-16, y1=65, x2=gfx.WIDTH-2, y2=79, f=function() if jacobsmod and (L.tabs or L.ctrl) then return end conSend(53,tpt.ambient_heat()==0 and "\1" or "\0") end},
}
if jacobsmod then
	tpt_buttons["tab"] = {x1=gfx.WIDTH-16, y1=1, x2=gfx.WIDTH-2, y2=15, f=function() L.tabs = not L.tabs end}
	tpt_buttons["tabs"] = {x1=gfx.WIDTH-16, y1=17, x2=gfx.WIDTH-2, y2=147, f=function() if L.tabs or L.ctrl then L.sendScreen = true end end}
	tpt_buttons["opts"] = {x1=465, y1=408, x2=479, y2=422, f=function() L.checkOpt=true end}
	tpt_buttons["clear"] = {x1=481, y1=408, x2=497, y2=422, f=function() conSend(63) L.lastSave=nil end}
	tpt_buttons["disp"] = {x1=595, y1=408, x2=611, y2=422,f=function() L.checkRen=2 L.pModes=getViewModes() end}
	tpt_buttons["open"] = {x1=1, y1=408, x2=17, y2=422, f=function() if not L.ctrl then L.browseMode=1 else L.browseMode=2 end L.lastSave=sim.getSaveID() end}
end

local function inZoomWindow(x, y)
	if not L.isDrawing and (x < 0 or x >= sim.XRES or y < 0 or y >= sim.YRES) then
		return false
	end
	local snappedX, snappedY = x, y
	-- When the mouse is outside the window, TPT will snap coords to simulation area then check for zoom window
	if snappedX < 0 then snappedX = 0 elseif snappedX >= sim.XRES then snappedX = sim.XRES end
	if snappedY < 0 then snappedY = 0 elseif snappedY >= sim.YRES then snappedY = sim.YRES end
	local zoomX, zoomY = sim.adjustCoords(snappedX, snappedY)
	return zoomX ~= x or zoomY ~= y
end

local function sendMouseUpdate(mouseX, mouseY)
	L.realMouseX, L.realMouseY = mouseX, mouseY
	if inZoomWindow(mouseX, mouseY) then
		mouseX, mouseY = sim.adjustCoords(mouseX, mouseY)	
	else
		if mouseX < 0 then mouseX = 0 end
		if mouseY < 0 then mouseY = 0 end
		if mouseX > gfx.WIDTH then mouseX = gfx.WIDTH end
		if mouseY > gfx.HEIGHT then mouseY = gfx.HEIGHT end
	end

	if L.mousex ~= mouseX or L.mousey ~= mouseY then
		local b1, b2, b3 = math.floor(mouseX / 16), ((mouseX % 16) * 16) + math.floor(mouseY / 256), (mouseY % 256)
		conSend(32, string.char(b1, b2, b3))
		L.mousex, L.mousey = mouseX, mouseY
	end
end

local function mouseDown(mouseX, mouseY, button)
	if L.chatHidden then
		showbutton:mouseDown(mouseX, mouseY, button)
		if not hooks_enabled then
			return true
		end
	end
	if L.stamp and button == 1 then
		L.stampx, L.stampy = mouseX, mouseY
		return true
	end
	if L.stamp or L.placeStamp then
		return true
	end
	if L.skipClick then
		L.skipClick = false
		return true
	end
	if chatwindow:mouseDown(mouseX, mouseY, button) then
		return false
	end

	sendMouseUpdate(mouseX, mouseY)
	local obut, oevnt = L.mButt, L.mEvent
	if button ~= obut or 1 ~= oevnt then
		L.mButt, L.mEvent = button, 1
		if mouseX >= 0 and mouseY >= 0 and mouseX < sim.XRES and mouseY < sim.YRES then
			L.isDrawing = true
		end
		conSend(33, string.char(L.mButt * 16 + L.mEvent))
	end
	
	-- Click inside button first
	if button==1 then
		for k, v in pairs(tpt_buttons) do
			if mouseX >= v.x1 and mouseX <= v.x2 and mouseY >= v.y1 and mouseY <= v.y2 then
				v.downInside = true
			end
		end
	end
end

local function mouseUp(mouseX, mouseY, button, reason)
	if L.chatHidden then
		showbutton:mouseUp(mouseX, mouseY, button)
		if not hooks_enabled then
			return true
		end
	end
	if L.stamp then
		if L.skipClick then
			L.skipClick = false
			return true
		end
		--stamp has been saved, make our own copy
		if button==1 then
			--save stamp ourself for data, delete it
			local sx,sy = mouseX, mouseY
			if sx<L.stampx then L.stampx,sx=sx,L.stampx end
			if sy<L.stampy then L.stampy,sy=sy,L.stampy end
			--cheap cut hook to send a clear
			if L.copying==1 then
				--maybe this is ctrl+x? 67 is clear area
				conSend(67,string.char(math.floor(L.stampx/16),((L.stampx%16)*16)+math.floor(L.stampy/256),(L.stampy%256),math.floor(sx/16),((sx%16)*16)+math.floor(sy/256),(sy%256)))
			end
			local w,h = sx-L.stampx,sy-L.stampy
			local stampName,fullName = saveStamp(L.stampx,L.stampy,w,h)
			sx,sy,L.stampx,L.stampy = math.ceil((sx+1)/4)*4,math.ceil((sy+1)/4)*4,math.floor(L.stampx/4)*4,math.floor(L.stampy/4)*4
			w,h = sx-L.stampx, sy-L.stampy
			local f = assert(io.open(fullName,"rb"))
			if L.copying then L.lastCopy = {data=f:read"*a",w=w,h=h} else L.lastStamp = {data=f:read"*a",w=w,h=h} end
			f:close()
			deleteStamp(stampName)
		end
		L.stamp=false
		L.copying=false
	end
	if L.placeStamp and reason == 0 then
		if L.skipClick then
			L.skipClick=false
			return true
		end
		if button==1 then
			local stm
			if L.copying then stm=L.lastCopy else stm=L.lastStamp end
			if stm then
				if not stm.data then
					--unknown stamp, send full screen on next step, how can we read last created stamp, timestamps on files?
					L.sendScreen = (jacobsmod and 2 or true)
				else
					--send the stamp
					if L.smoved then
						--moved from arrows or rotate, send area next frame
						L.placeStamp=false
						L.sendScreen=true
						return true
					end
					local sx,sy = mouseX-math.floor(stm.w/2),mouseY-math.floor((stm.h)/2)
					if sx<0 then sx=0 end
					if sy<0 then sy=0 end
					if sx+stm.w>sim.XRES-1 then sx=sim.XRES-stm.w end
					if sy+stm.h>sim.YRES-1 then sy=sim.YRES-stm.h end
					local b1,b2,b3 = math.floor(sx/16),((sx%16)*16)+math.floor(sy/256),(sy%256)
					local d = #stm.data
					conSend(66,string.char(b1,b2,b3,math.floor(d/65536),math.floor(d/256)%256,d%256)..stm.data)
				end
			end
		end
		L.placeStamp=false
		L.copying=false
	end
	
	if L.skipClick then
		L.skipClick = false
		return true
	end
	if chatwindow:mouseUp(mouseX, mouseY, button, reason) then
		return false
	end

	-- Ignore fake mouseups due to blur (don't send 0, 0 coordinate)
	-- Also ignore fake mouseups due to going into / outside of zoom window
	-- In both cases, tell other clients we're no longer holding the mouse, without causing it to draw the line
	if reason == 1 or reason == 2 then
		L.mButt, L.mEvent = button, 2
		L.isDrawing = false
		conSend(33, string.char(0 * 16 + L.mEvent))
		return
	end

	sendMouseUpdate(mouseX, mouseY)
	local obut, oevnt = L.mButt, L.mEvent
	if button ~= obut or 2 ~= oevnt then
		L.isDrawing = false
		L.mButt, L.mEvent = button, 2
		conSend(33, string.char(L.mButt * 16 + L.mEvent))
	end

	-- Up inside the button we started with
	if button == 1 then
		local ret = true
		for k,v in pairs(tpt_buttons) do
			if v.downInside and (mouseX>=v.x1 and mouseX<=v.x2 and mouseY>=v.y1 and mouseY<=v.y2) then
				if v.f() == false then ret = false end
			end
			v.downInside = nil
		end
		return ret
	end
end

local function mouseMove(mouseX, mouseY, dX, dY)
	if L.chatHidden then
		showbutton:mouseMove(mouseX, mouseY, dX, dY)
		if not hooks_enabled then
			return true
		end
	end
	if chatwindow:mouseMove(mouseX, mouseY, dX, dY) then
		return false
	end

	-- Always send mouse update, unless we're currently drawing and entered/exited the zoom window
	-- TPT sends a fake mouseup event in this case, but the mouse move happens first so we need to stop it ourselves
	local shouldBlockMove = L.isDrawing and not inZoomWindow(mouseX, mouseY) ~= inZoomWindow(L.realMouseX, L.realMouseY)
	if shouldBlockMove then
		L.isDrawing = false
	else
		sendMouseUpdate(mouseX, mouseY)
	end

	--Mouse hold, we MUST stay inside button or don't trigger on up
	if button == 1 then
		for k, v in pairs(tpt_buttons) do
			if v.downInside and (mouseX < v.x1 or mouseX > v.x2 or mouseY < v.y1 or mouseY > v.y2) then
				v.downInside = nil
			end
		end
	end
end

local function mouseWheel(mouseX, mouseY, wheel)
	if chatwindow.inputbox.focus and chatwindow:mouseWheel(mousex, mousey, wheel) then
		return false
	end
end

local keyFuncs = {
	--TAB
	[9] = function() if not jacobsmod or not L.ctrl then conSend(35) end end,

	--View modes 0-9
	[48] = function() conSend(48,"\10") end,
	[49] = function() if L.shift then conSend(48,"\9") tpt.display_mode(9)--[[force local display mode, screw debug check for now]] return false end conSend(48,"\0") end,
	[50] = function() conSend(48,"\1") end,
	[51] = function() conSend(48,"\2") end,
	[52] = function() conSend(48,"\3") end,
	[53] = function() conSend(48,"\4") end,
	[54] = function() conSend(48,"\5") end,
	[55] = function() conSend(48,"\6") end,
	[56] = function() conSend(48,"\7") end,
	[57] = function() conSend(48,"\8") end,

	-- ins / del for replace mode
	[1073741897] = function() L.replacemode = bit.bxor(L.replacemode, 1) conSend(38, L.replacemode) end,
	[127] = function() L.replacemode = bit.bxor(L.replacemode, 2) conSend(38, L.replacemode) end,

	--Arrows for stamp adjust
	[273] = function() if L.placeStamp then L.smoved=true end end,
	[274] = function() if L.placeStamp then L.smoved=true end end,
	[275] = function() if L.placeStamp then L.smoved=true end end,
	[276] = function() if L.placeStamp then L.smoved=true end end
}

local scanFuncs = {
	--`, console
	[53] = function() if not L.shift and con.connected then infoText:reset("Console does not sync, use shift+` to open instead") return false else jacobsmod_old_menu_check = true end end,

	--b, deco, pauses sim
	[5] = function() if L.ctrl then conSend(51,tpt.decorations_enable()==0 and "\1" or "\0") else conSend(49,"\1") conSend(51,"\1") end end,

	--c, copy
	[6] = function() if L.ctrl then L.stamp=true L.copying=true L.stampx = -1 L.stampy = -1 end end,

	--d key, debug, api broken right now
	--[7] = function() conSend(55) end,

	--F, frame step
	[9] = function() if not jacobsmod or not L.ctrl then conSend(50) end end,

	--H, HUD and intro text
	[11] = function() if L.ctrl and jacobsmod then return false end end,

	--I, invert pressure
	[12] = function() conSend(62) end,

	--K, stamp menu, abort our known stamp, who knows what they picked, send full screen?
	[14] = function() L.lastStamp={data=nil,w=0,h=0} L.placeStamp=true end,

	--L, last Stamp
	[15] = function() if L.lastStamp then L.placeStamp=true end end,

	--N, newtonian gravity or new save
	[17] = function() if jacobsmod and L.ctrl then L.sendScreen=2 L.lastSave=nil else conSend(54,tpt.newtonian_gravity()==0 and "\1" or "\0") end end,

	--O, old menu in jacobs mod
	[18] = function() if jacobsmod and not L.ctrl then jacobsmod_old_menu_check = true end end,

	--R, for stamp rotate or save reload
	[21] = function()
		if L.placeStamp then
			L.smoved = true
			if L.shift then
				return
			end
			L.rotate = not L.rotate
		elseif L.ctrl then
			if L.lastSave then
				conSend(70)
				infoText:reset("Sent reload command") 
			else
				L.sendScreen = true
				infoText:reset("Send sync") 
			end
		end
	end,

	--S, stamp
	[22] = function() if (L.lastStick2 and not L.ctrl) or (jacobsmod and L.ctrl) then return end L.stamp=true L.stampx = -1 L.stampy = -1 end,

	--T, tabs
	[23] = function() if jacobsmod then L.tabs = not L.tabs end end,

	--U, ambient heat toggle
	[24] = function() conSend(53,tpt.ambient_heat()==0 and "\1" or "\0") end,

	--V, paste the copystamp
	[25] = function() if L.ctrl and L.lastCopy then L.placeStamp=true L.copying=true end end,

	--W, gravity mode
	[26] = function() if L.lastStick2 and not L.ctrl then return end conSend(58,string.char((sim.gravityMode()+1)%3)) return true end,

	--X, cut a copystamp and clear
	[27] = function() if L.ctrl then L.stamp=true L.copying=1 L.stampx = -1 L.stampy = -1 end end,

	--Y, air mode
	[28] = function() if L.ctrl then L.sendScreen = true else conSend(59,string.char((sim.airMode()+1)%5)) return true end end,

	--Z
	[29] = function() if L.ctrl then L.sendScreen = true else L.skipClick=true end end,

	--ESC
	[41] = function() if not L.chatHidden then L.chatHidden = true TPTMP.chatHidden = true return false end end,

	--space, pause toggle
	[44] = function() conSend(49,tpt.set_pause()==0 and "\1" or "\0") end,

	--= key, pressure/spark reset
	[46] = function() if L.ctrl then conSend(60) else conSend(61) end end,

	--;, replace mode or specific delete
	[59] = function() if L.ctrl then  L.replacemode = bit.bxor(L.replacemode, 2) else  L.replacemode = bit.bxor(L.replacemode, 1) end conSend(38, L.replacemode) end,

	--F1 , intro text
	[58] = function() if jacobsmod then return false end end,

	--F5 , save reload
	[62] = function()
		if L.lastSave then
			conSend(70)
			infoText:reset("Sent reload command") 
		else
			L.sendScreen = true
			infoText:reset("Sent sync") 
		end
	end,
}
local scanUnpressFuncs = {
	--Z
	[29] = function() L.skipClick=false if L.alt then L.skipClick=true end end,
}

local function keypress(key, scan, rep, shift, ctrl, alt)
	if shift and not L.shift then
		L.shift = true
		conSend(36, string.char(17))
	end
	if ctrl and not L.ctrl then
		L.ctrl = true
		conSend(36, string.char(1))
	end
	if alt and not L.alt then
		L.alt = true
		conSend(36, string.char(33))
	end

	local check = chatwindow:keypress(key, scan, rep, shift, ctrl, alt)
	if type(check) == "boolean" then
		return not check
	end
	
	if rep then return end

	if scanFuncs[scan] then
		ret = scanFuncs[scan]()
		if ret ~= nil then
			return ret
		end
	elseif keyFuncs[key] then
		ret = keyFuncs[key]()
		if ret ~= nil then
			return ret
		end
	end
end
local function keyrelease(key, scan, rep, shift, ctrl, alt)
	if not shift and L.shift then
		L.shift = false
		conSend(36, string.char(16))
	end
	if not ctrl and L.ctrl then
		L.ctrl = false
		conSend(36, string.char(0))
	end
	if not alt and L.alt then
		L.alt = false
		conSend(36, string.char(32))
	end

	if rep then return end

	if scanUnpressFuncs[scan] then
		ret = scanUnpressFuncs[scan]()
		if ret~= nil then
			return ret
		end
	end
end
local function textinput(text)
	chatwindow:textinput(text)
end
local function blur()
	if L.shift then
		L.shift = false
		conSend(36, string.char(16))
	end
	if L.ctrl then
		L.ctrl = false
		conSend(36, string.char(0))
	end
	if L.alt then
		L.alt = false
		conSend(36, string.char(32))
	end
end
function TPTMP.disableMultiplayer()
	evt.unregister(evt.tick, step)
	evt.unregister(evt.mousedown, mouseDown)
	evt.unregister(evt.mouseup, mouseUp)
	evt.unregister(evt.mousemove, mouseMove)
	evt.unregister(evt.mousewheel, mouseWheel)
	evt.unregister(evt.keypress, keypress)
	evt.unregister(evt.keyrelease, keyrelease)
	evt.unregister(evt.textinput, textinput)
	evt.unregister(evt.blur, blur)
	TPTMP = nil
	disconnected("TPTMP unloaded")
end

function TPTMP.enableMultiplayer()
	hooks_enabled = true
	TPTMP.enableMultiplayer = nil
	debug.sethook(nil,"",0)
	if jacobsmod then
		--clear intro text tooltip
		gfx.toolTip("", 0, 0, 0, 4)
	end
end
TPTMP.con = con
TPTMP.chatHidden = true
evt.register(evt.tick, step)
evt.register(evt.mousedown, mouseDown)
evt.register(evt.mouseup, mouseUp)
evt.register(evt.mousemove, mouseMove)
evt.register(evt.mousewheel, mouseWheel)
evt.register(evt.keypress, keypress)
evt.register(evt.keyrelease, keyrelease)
evt.register(evt.textinput, textinput)
evt.register(evt.blur, blur)
