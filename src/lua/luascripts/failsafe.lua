--Fail safe protection module v3.0
function warningmsg()
gfx.drawRect(177,367,336,14,255,0,0,255)
if tpt.mousex >176 and tpt.mousex <= 505 and tpt.mousey > 367 and tpt.mousey <= 380 then
gfx.fillRect(177,367,336,14,225,55,55,80)
else
gfx.fillRect(177,367,336,14,225,55,55,30)
end
gfx.drawText(180,370,"Fail Safe Module: Something went wrong, click here to reset the mod!",250,0,0,255)
end

function warningmsgclick()
if tpt.mousex >176 and tpt.mousex <= 505 and tpt.mousey > 367 and tpt.mousey <= 380 then
os.remove("dlf3.txt")
os.remove("scripts/downloaded/2 LBPHacker-TPTMulti.lua")
os.remove("scripts/downloaded/219 Maticzpl-Notifications.lua")
os.remove("scripts/autorunsettingsbackup.txt")--Delete the file if it already exists
os.rename("scripts/autorunsettings.txt","scripts/autorunsettingsbackup.txt")--Rename the file for use as a backup.
os.remove("scripts/autorunsettings.txt")
os.remove("autorun.lua")
os.remove("oldmod")
platform.restart()
end
return false
end

if failsafe == nil then
event.register(event.tick, warningmsg)
event.register(event.mousedown, warningmsgclick)
end

