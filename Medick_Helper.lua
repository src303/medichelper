script_name('Medick Helper') -- UPDATE TEST 1
script_author('Src303')
script_version '2.0.1'
local dlstatus = require "moonloader".download_status
script_author('Mark_King')
local sf = require 'sampfuncs'
local key = require "vkeys"
local inicfg = require 'inicfg'
local a = require 'samp.events'
local sampev = require 'lib.samp.events'
local imgui = require 'imgui' -- çàãðóæàåì áèáëèîòåêó/
local encoding = require 'encoding' -- çàãðóæàåì áèáëèîòåêó
local wm = require 'lib.windows.message'
local gk = require 'game.keys'
local dlstatus = require('moonloader').download_status
local second_window = imgui.ImBool(false)
local third_window = imgui.ImBool(false)
local first_window = imgui.ImBool(false)
local bMainWindow = imgui.ImBool(false)
local sInputEdit = imgui.ImBuffer(128)
local bIsEnterEdit = imgui.ImBool(false)
local ystwindow = imgui.ImBool(false)
local updwindows = imgui.ImBool(false)
local helps = imgui.ImBool(false)
local obnova = imgui.ImBool(false)
local infbar = imgui.ImBool(false)
local updwindows = imgui.ImBool(false)
local tEditData = {
	id = -1,
	inputActive = false
}
encoding.default = 'CP1251' -- óêàçûâàåì êîäèðîâêó ïî óìîë÷àíèþ, îíà äîëæíà ñîâïàäàòü ñ êîäèðîâêîé ôàéëà. CP1251 - ýòî Windows-1251
u8 = encoding.UTF8

local checked_radio = imgui.ImInt(1)
local themes = import "resource/imgui_themes.lua"
local fa = require 'faIcons'
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
    end
end
require 'lib.sampfuncs'
seshsps = 1
ctag = "{9966cc} Medick Helper {ffffff}|"
players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
players2 = {'{ffffff}Äàòà ïðèíÿòèÿ\t{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
frak = nil
rang = nil
ttt = nil
dostavka = false
rabden = false
tload = false
changetextpos = false
tLastKeys = {}
narkoh = 0
health = 0
departament = {}
smslogs = {}
radio = {}
vixodid = {}
local config_keys = {
    fastsms = { v = {}}
}
function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end
apply_custom_style()

local fileb = getWorkingDirectory() .. "\\config\\medick.bind"
local tBindList = {}
if doesFileExist(fileb) then
	local f = io.open(fileb, "r")
	if f then
		tBindList = decodeJson(f:read())
		f:close()
	end
else
	tBindList = {
        [1] = {
            text = "",
            v = {key.VK_No}
        }
	}
end

local medick =
{
  main =
  {
    posX = 1738,
    posY = 974,
    widehud = 320,
    male = true,
    wanted == false,
    clear == false,
    hud = false,
    tar = 'Èíòåðí',
	tarr = 'òýã',
	tarb = false,
	clistb = false,
	clisto = false,
	givra = false,
    clist = 0,
	health = 0,
	narkoh = 0,
  },
  commands =
  {
    ticket = false,
	zaderjka = 5
  },
   keys =
  {
	tload = 113,
	tazer = 113,
	fastmenu = 113,
	theme = 7,
  }
}
if limgui then
		tema = imgui.ImInt(ini.settings.theme)
end

cfg = inicfg.load(nil, 'medick/config.ini')
test = imgui.CreateTextureFromFile(getGameDirectory() .. '\\moonloader\\medick\\images\\arz.png')
local libs = {'sphere.lua', 'rkeys.lua', 'imcustom/hotkey.lua', 'imgui.lua', 'MoonImGui.dll', 'imgui_addons.lua'}
function main()
  while not isSampAvailable() do wait(1000) end
  if seshsps == 1 then
	ftext('Medick Helper óñïåøíî çàãðóæåí!',-1)
	ftext('Ôóíêöèè ñêðèïòà êîìàíäà: /mh (íàñòðîéêè ñêðèïòà), F2 (ãëàâíîå ìåíþ) èëè ÏÊÌ + Z (îòûãðîâêè).',-1)
	ftext('Ïåðåçàãðóçèòü ñêðèïò åñëè îòêëþ÷èòñÿ, îäíîâðåìåííî çàæàòü CTRL + R.',-1)
  end
  if not doesDirectoryExist('moonloader/config/medick/') then createDirectory('moonloader/config/medick/') end
  if cfg == nil then
    sampAddChatMessage("{7e0059}Medick Help {7e0059}| Îòñóòñâóåò ôàéë êîíôèãà, ñîçäàåì.", -1)
    if inicfg.save(medick, 'medick/config.ini') then
      sampAddChatMessage("{7e0059}Medick Help {7e0059}| Ôàéë êîíôèãà óñïåøíî ñîçäàí.", -1)
      cfg = inicfg.load(nil, 'medick/config.ini')
    end
  end
  if not doesDirectoryExist('moonloader/lib/imcustom') then createDirectory('moonloader/lib/imcustom') end
  for k, v in pairs(libs) do
        if not doesFileExist('moonloader/lib/'..v) then
            downloadUrlToFile('https://raw.githubusercontent.com/WhackerH/kirya/master/lib/'..v, getWorkingDirectory()..'\\lib\\'..v)
            print('Çàãðóæàåòñÿ áèáëèîòåêà'..v)
        end
    end
	if not doesFileExist("moonloader/config/medick/keys.json") then
        local fa = io.open("moonloader/config/medick/keys.json", "w")
        fa:close()
    else
        local fa = io.open("moonloader/config/medick/keys.json", 'r')
        if fa then
            config_keys = decodeJson(fa:read('*a'))
        end
    end
  while not doesFileExist('moonloader\\lib\\rkeys.lua') or not doesFileExist('moonloader\\lib\\imcustom\\hotkey.lua') or not doesFileExist('moonloader\\lib\\imgui.lua') or not doesFileExist('moonloader\\lib\\MoonImGui.dll') or not doesFileExist('moonloader\\lib\\imgui_addons.lua') do wait(0) end
  if not doesDirectoryExist('moonloader/medick') then createDirectory('moonloader/medick') end
  hk = require 'lib.imcustom.hotkey'
  imgui.HotKey = require('imgui_addons').HotKey
  rkeys = require 'rkeys'
  imgui.ToggleButton = require('imgui_addons').ToggleButton
  while not sampIsLocalPlayerSpawned() do wait(0) end
  local _, myid = sampGetPlayerIdByCharHandle(playerPed)
  local name, surname = string.match(sampGetPlayerNickname(myid), '(.+)_(.+)')
  sip, sport = sampGetCurrentServerAddress()
  sampSendChat('/stats')
  while not sampIsDialogActive() do wait(0) end
  proverkk = sampGetDialogText()
  local frakc = proverkk:match('.+Îðãàíèçàöèÿ%s+(.+)%s+Äîëæíîñòü')
  local rang = proverkk:match('.+Äîëæíîñòü%s+%d+ %((.+)%)%s+Ðàáîòà')
  local telephone = proverkk:match('.+Òåëåôîí%s+(.+)%s+Çàêîíîïîñëóøíîñòü')
  rank = rang
  ttt = nil
  frac = frakc
  tel = telephone
  sampCloseCurrentDialogWithButton(1)
  print(frakc)
  print(rang)
  print(telephone)
  ystf()
  update()
  sampCreate3dTextEx(641, '{ffffff}None', 4294927974, 2346.1362,1666.7819,3040.9387, 3, true, -1, -1)
  sampCreate3dTextEx(642, '{ffffff}None', 4294927974, 2337.5002,1657.4896,3040.9524, 3, true, -1, -1)
  sampCreate3dTextEx(643, '{ffffff}None.{ff0000}óãó!', 4294927974, 2337.8091,1669.0276,3040.9524, 3, true, -1, -1)
  local spawned = sampIsLocalPlayerSpawned()
  for k, v in pairs(tBindList) do
		rkeys.registerHotKey(v.v, true, onHotKey)
  end
  fastsmskey = rkeys.registerHotKey(config_keys.fastsms.v, true, fastsmsk)
  sampRegisterChatCommand('r', r)
  sampRegisterChatCommand('dlog', dlog)
  sampRegisterChatCommand('smslog', slog)
  sampRegisterChatCommand('rlog', rlog)
  sampRegisterChatCommand('dmb', dmb)
  sampRegisterChatCommand('smsjob', smsjob)
  sampRegisterChatCommand('where', where)
  sampRegisterChatCommand('mh', mh)
  sampRegisterChatCommand('vig', vig)
  sampRegisterChatCommand('unvig',unvig)
  sampRegisterChatCommand('giverank', giverank)
  sampRegisterChatCommand('ffixcar', fixcar)
  sampRegisterChatCommand('invite', invite)
  sampRegisterChatCommand('invn', invitenarko)
  sampRegisterChatCommand('oinv', oinv)
  sampRegisterChatCommand('fgv', fgiverank)
  sampRegisterChatCommand('zinv', zinv)
  sampRegisterChatCommand('ginv', ginv)
  sampRegisterChatCommand('uninvite', uninvite)
  sampRegisterChatCommand('z', zheal)
    sampRegisterChatCommand('sethud', function()
        if cfg.main.givra then
            if not changetextpos then
                changetextpos = true
                ftext('Ïî çàâåðøåíèþ ââåäèòå êîìàíäó åùå ðàç.')
            else
                changetextpos = false
				inicfg.save(cfg, 'medick/config.ini') -- ñîõðàíÿåì âñå íîâûå çíà÷åíèÿ â êîíôèãå
            end
        else
            ftext('Äëÿ íà÷àëà âêëþ÷èòå Õóä.')
        end
    end)
  sampRegisterChatCommand('ystav', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
     datetime = os.date("!*t",os.time()) 
if datetime.min == 00 and datetime.sec == 10 then 
sampAddChatMessage("Íå çàáóäüòå îñòàâèòü îò÷¸ò â òåìå íà ïîëó÷åíèå âûïëàò.", -1) 
wait(1000)
end
    if #departament > 25 then table.remove(departament, 1) end
	if #smslogs > 25 then table.remove(smslogs, 1) end
	if #radio > 25 then table.remove(radio, 1) end
    if cfg == nil then
      sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Îòñóòñâóåò ôàéë êîíôèãà, ñîçäàåì.", -1)
      if inicfg.save(medick, 'medick/config.ini') then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ôàéë êîíôèãà óñïåøíî ñîçäàí.", -1)
        cfg = inicfg.load(nil, 'medick/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| Áûñòðîå ìåíþ")
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| Ñèñòåìà ïîâûøåíèé")
	end
          if valid and doesCharExist(ped) then
            local result, id = sampGetPlayerIdByCharHandle(ped)
            if result and wasKeyPressed(key.VK_Z) then --- Òóò ìåíÿòü êëàâèøó áûñòðîãî ìåíþ
                gmegafhandle = ped
                gmegafid = id
                gmegaflvl = sampGetPlayerScore(id)
                gmegaffrak = getFraktionBySkin(id)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
                --[[ftext(gmegafid)
                ftext(gmegaflvl)
                ftext(gmegaffrak)]]
				megaftimer = os.time() + 300
                submenus_show(pkmmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
            end
        end
	if cfg.main.givra == true then
      infbar.v = true
      imgui.ShowCursor = false
    end
    if cfg.main.givra == false then
      infbar.v = false
      imgui.ShowCursor = false
    end
		if changetextpos then
            sampToggleCursor(true)
            local CPX, CPY = getCursorPos()
            cfg.main.posX = CPX
            cfg.main.posY = CPY
        end
		imgui.Process = second_window.v or third_window.v or bMainWindow.v or ystwindow.v or updwindows.v or infbar.v
  end
  function rkeys.onHotKey(id, keys)
	if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() then
		return false
	end
end
end
	function drawImguiDemo()
		if imguiDemo.v then
			imgui.ShowTestWindow(imguiDemo)
		end
	end
	
	function imgui.OnDrawFrame()
		local result, clientId = sampGetPlayerIdByCharHandle(playerPed)

		if ini.settings.style == 0 then strong_style() end
		if ini.settings.style == 1 then easy_style() end
		if ini.settings.theme == 0 then theme1() end
		if ini.settings.theme == 1 then theme2() end
		if ini.settings.theme == 2 then theme3() end
		if ini.settings.theme == 3 then theme4() end
		if ini.settings.theme == 4 then theme5() end
		if ini.settings.theme == 5 then theme6() end
		if ini.settings.theme == 6 then theme7() end
		if ini.settings.theme == 7 then theme8() end
		if ini.settings.theme == 8 then theme9() end


		drawImguiDemo()
end
function dmb()
	lua_thread.create(function()
		status = true
		players2 = {'{ffffff}Äàòà ïðèíÿòèÿ\t{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{ffffff}Â ñåòè: "..gcount.." | {ae433d}Îðãàíèçàöèÿ | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players2, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		elseif krimemb then
			sampShowDialog(716, "{ffffff}Â ñåòè: "..gcount.." | {ae433d}Îðãàíèçàöèÿ | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players1, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		status = false
		gcount = nil
	end)
end
function blg(pam)
    local id, frack, pric = pam:match('(%d+) (%a+) (.+)')
    if id and frack and pric and sampIsPlayerConnected(id) then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/d %s, áëàãîäàðþ %s çà %s. Öåíèòå!", frack, rpname, pric))
    else
        ftext("Ââåäèòå: /blg [id] [Ôðàêöèÿ] [Ïðè÷èíà]", -1)
		ftext("Ïðèìåð: òðàíñïîðòèðîâêó, ñïàñåíèå æèçíè, è ò.ä. ", -1)
    end
end

function dmch()
	lua_thread.create(function()
		statusc = true
		players3 = {'{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{9966cc}Medick Helper {ffffff}| {ae433d}Âíå îôèñà {ffffff}| Time: "..os.date("%H:%M:%S"), table.concat(players3, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		statusc = false
	end)
end

function dlog()
    sampShowDialog(97987, '{9966cc}Medick Help{ffffff} | Ëîã ñîîáùåíèé äåïàðòàìåíòà', table.concat(departament, '\n'), '»', 'x', 0)
end
function slog()
    sampShowDialog(97987, '{9966cc}Medick Help{ffffff} | Ëîã SMS', table.concat(smslogs, '\n'), '»', 'x', 0)
end

function rlog()
    sampShowDialog(97988, '{9966cc}Medick Help{ffffff} | Ëîã Ðàöèè', table.concat(radio, '\n'), '»', 'x', 0)
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâíûé Âðà÷' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /vig [ID] [Ïðè÷èíà]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Èãðîê ñ ID: "..id.." íå ïîäêëþ÷åí ê ñåðâåðó.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /vig [ID] [ÏÐÈ×ÈÍÀ]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - ïîëó÷àåò âûãîâîð ïî ïðè÷èíå: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - ïîëó÷àåò âûãîâîð ïî ïðè÷èíå: %s.", rpname, pric))
      end
  end
end
end
end
function ivig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Äîêòîð' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /ivig [ID] [Ïðè÷èíà]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Èãðîê ñ ID: "..id.." íå ïîäêëþ÷åí ê ñåðâåðó.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /ivig [ID] [ÏÐÈ×ÈÍÀ]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Ïîëó÷àåò ñòðîãèé âûãîâîð ïî ïðè÷èíå: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Ïîëó÷àåò ñòðîãèé âûãîâîð ïî ïðè÷èíå: %s.", rpname, pric))
      end
  end
end
end
end

function unvig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /unvig [ID] [Ïðè÷èíà]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Èãðîê ñ ID: "..id.." íå ïîäêëþ÷åí ê ñåðâåðó.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
  
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /unvig [ID] [ÏÐÈ×ÈÍÀ]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Ïîëó÷àåò cíÿòèå âûãîâîðà ïî ïðè÷èíå: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Ïîëó÷àåò cíÿòèå âûãîâîðà ïî ïðè÷èíå: %s.", rpname, pric))
      end
  end
end
end
end

function where(params) -- çàïðîñ ìåñòîïîëîæåíèÿ
   if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
	if params:match("^%d+") then
		params = tonumber(params:match("^(%d+)"))
		if sampIsPlayerConnected(params) then
			local name = string.gsub(sampGetPlayerNickname(params), "_", " ")
			 if cfg.main.tarb then
			    sampSendChat(string.format("/r [%s]: %s, äîëîæèòå ñâîå ìåñòîïîëîæåíèå. Íà îòâåò 20 ñåêóíä.", cfg.main.tarr, name))
			else
			sampSendChat(string.format("/r %s, äîëîæèòå ñâîå ìåñòîïîëîæåíèå. Íà îòâåò 20 ñåêóíä.", name))
			end
			else
			ftext('{FFFFFF} Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.', 0x046D63)
		end
		else
		ftext('{FFFFFF} Èñïîëüçóéòå: /where [ID].', 0x046D63)
		end
		else
		ftext('{FFFFFF}Äàííàÿ êîìàíäà äîñòóïíà ñ 7 ðàíãà.', 0x046D63)
	end
end

function getrang(rangg)
local ranks = 
        {
		['1'] = 'Èíòåðí',
		['2'] = 'Ñàíèòàð',
		['3'] = 'Ìåä.áðàò',
		['4'] = 'Ñïàñàòåëü',
		['5'] = 'Íàðêîëîã',
		['6'] = 'Äîêòîð',
		['7'] = 'Ïñèõîëîã',
		['8'] = 'Õèðóðã',
		['9'] = 'Çàì.Ãëàâ.Âðà÷à',
		['10'] = 'Ãëàâ.Âðà÷'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
		        local _, handle = sampGetCharHandleBySampPlayerId(id)
				if doesCharExist(handle) then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
				if dist <= 5 then
				if cfg.main.male == true then  --- Ìóæñêàÿ îòûãðîâêà
				sampSendChat('/me ñíÿë ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')
				wait(3000)
				sampSendChat('/me óáðàë ñòàðûé áåéäæèê â êàðìàí')
				wait(3000)
                sampSendChat(string.format('/me äîñòàë íîâûé áåéäæèê %s', ranks))
				wait(3000)
				sampSendChat('/me çàêðåïèë íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(3000)
				else
				sampSendChat('/me ñíÿëà ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')  --- Æåíñêàÿ îòûãðîâêà
				wait(3000)
				sampSendChat('/me óáðàëà ñòàðûé áåéäæèê â êàðìàí')
				wait(3000)
                sampSendChat(string.format('/me äîñòàëà íîâûé áåéäæèê %s', ranks))
				wait(3000)
				sampSendChat('/me çàêðåïèëà íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(3000)
				end
				end
				end
				sampSendChat(string.format('/giverank %s %s', id, rangg))
				wait(3000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s â äîëæíîñòè äî %s%s.', cfg.main.tarr, plus == '+' and 'Ïîâûøåí(à)' or 'Ïîíèæåí(à)', ranks, plus == '+' and ', Ïîçäðàâëÿåì!' or ''))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s â äîëæíîñòè äî %s%s.', plus == '+' and 'Ïîâûøåí(à)' or 'Ïîíèæåí(à)', ranks, plus == '+' and ', Ïîçäðàâëÿåì!' or ''))
				wait(3000)
				sampSendChat('/b /time 1 + F8, îáÿçàòåëüíî.')
            end
			else
			ftext('Âû ââåëè íåâåðíûé òèï [+/-]')
		end
		else
			ftext('Ââåäèòå: /giverank [id] [ðàíã] [+/-]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ äîëæíîñòè Ïñèõîëîã.')
	  end
	  else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
	  end
   end)
 end
--[[
function fgiverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
		        local _, handle = sampGetCharHandleBySampPlayerId(id)
				if doesCharExist(handle) then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
				if dist <= 5 then
				if cfg.main.male == true then
				sampSendChat('/me ñíÿë ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')
				wait(3000)
				sampSendChat('/me óáðàë ñòàðûé áåéäæèê â êàðìàí')
				wait(3000)
                sampSendChat(string.format('/me äîñòàë íîâûé áåéäæèê %s', ranks))
				wait(3000)
				sampSendChat('/me çàêðåïèë íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(3000)
				else
				sampSendChat('/me ñíÿëà ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')
				wait(3000)
				sampSendChat('/me óáðàëà ñòàðûé áåéäæèê â êàðìàí')
				wait(3000)
                sampSendChat(string.format('/me äîñòàëà íîâûé áåéäæèê %s', ranks))
				wait(3000)
				sampSendChat('/me çàêðåïèëà íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(3000)
				end
				end
				end
			else
			ftext('Âû ââåëè íåâåðíûé òèï [+/-].')
		end
		else
			ftext('Ââåäèòå: /giverank [id] [ðàíã] [+/-]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ äîëæíîñòè Äîêòîð.')
	  end
	  else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
	  end
   end)
 end
--]]
 function invite(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Õèðóðã' or rank == 'Ïñèõîëîã' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me äîñòàë(à) áåéäæèê èíòåðíà è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/invite %s', id))
				wait(2000)
				sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Ïðèíÿò(à) â Ìèíèíèñòåðñòâî Çäðàâîîõðàíåíèÿ, Ïîçäðàâëÿåì', cfg.main.tarr))
			else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
		end
		else
			ftext('Ââåäèòå: /invite [id]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ äîëæíîñòè Ïñèõîëîã.')
	  end
   end)
 end
 function fixcar()
    lua_thread.create(function()
	  if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Õèðóðã' or  rank == 'Ïñèõîëîã' then
        sampSendChat('/rb Ñïàâí îðãàíèçàöèîííîãî òðàíñïîðòà ÷åðåç 15 ñåêóíä')
		wait(1000)
		sampSendChat('/rb  Çàéìèòå ñâîè êàðåòû!')
		wait(1000)
		sampSendChat('/ffixcar')
	  end
   end)
 end
 function invitenarko(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Õèðóðã' or rank == 'Ïñèõîëîã' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me äîñòàë(à) áåéäæèê íàðêîëîãà è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/invite %s', id))
				wait(6000)
				sampSendChat(string.format('/giverank %s 5', id))
				wait(2000)
				sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Ïðèíÿò íà äîëæíîñòü íàðêîëîãà ïî çàÿâëåíèþ, Ïîçäðàâëÿåì', cfg.main.tarr))
			else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
		end
		else
			ftext('Ââåäèòå: /invn [id]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ äîëæíîñòè Ïñèõîëîã.')
	  end
   end)
 end
function zheal(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
        if id then
		if sampIsPlayerConnected(id) then
		        if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
                sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat("/me äîñòàëà èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat('/me ïåðåäàëà ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat(string.format('/heal %s', id))
				end
				if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
				sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat('/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat(string.format('/heal %s', id))
			    end
				end
		else
			ftext('Ââåäèòå: /z [id]')
		end
   end)
end
 function ginv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(ginvite(id), "{9966cc}Medick Helpers {ffffff}| Âûáîð îòäåëà")
				else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
            end
		else
			ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ.')
		end
		else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	  end
	  else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	end
	  else
			ftext('Ââåäèòå: /ginv [id]')
	end
	  end)
   end

 function zinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(zinvite(id), "{9966cc}Medick Helpers {ffffff}| Âûáîð îòäåëà")
				else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
            end
		else
			ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ.')
		end
		else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	  end
	  else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	end
	  else
			ftext('Ââåäèòå: /zinv [id]')
	end
	  end)
   end
 function oinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(oinvite(id), "{9966cc}Medick Helpers {ffffff}| Âûáîð îòäåëà")
				else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
            end
		else
			ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ.')
		end
		else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	  end
	  else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	end
	  else
			ftext('Ââåäèòå: /oinv [id]')
	end
	  end)
   end
function uninvite(pam)
   lua_thread.create(function()
      local id, pri4ina = pam:match('(%d+)%s+(.+)')
      if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' then
        if id and pri4ina then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me çàáðàë(à) áåéäæèê ó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(2000)
				sampSendChat(string.format('/uninvite %s %s', id, pri4ina))
				wait(2000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Óâîëåí(à) ïî ïðè÷èíå "%s".', cfg.main.tarr, pri4ina))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Óâîëåí(à) ïî ïðè÷èíå "%s".', pri4ina))
            end
			else 
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
		end
		else 
			ftext('Ââåäèòå: /uninvite [id] [ïðè÷èíà]')
		end
		else 
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ 7 ðàíãà')
	 end
  end)
end
 function zinvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Îòäåë SES",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Çàìåñòèòåëÿ Ãëàâû Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñêîé-Ñòàíöèè è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 12.')
	wait(5000)
	sampSendChat('/b Òåã â /r [Çàì.Ãëàâû.SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Çàìåñòèòåëü Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñêîé-Ñòàíöèè.', cfg.main.tarr))
	end
   },
   
   {
   title = "{80a4bf}» {FFFFFF}Îòäåë ÏÑÁ",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Çàìåñòèòåëÿ Ãëàâû Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(4000)
	sampSendChat('/b /clist 29.')
	wait(4000)
	sampSendChat('/b Òåã â /r [Çàì.Ãëàâû ÏÑÁ]:')
	wait(4000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Çàìåñòèòåëü Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû.', cfg.main.tarr))
	end
   },
 }
end
function crpinv(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Íà÷àëüíèê",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Íà÷àëüíèêà Control Room è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 15.')
	wait(7000)
	sampSendChat('/b Òåã â /r [Chief CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Íà÷àëüíèê Control Room.', cfg.main.tarr))
	end
   },
   
   {
   title = "{80a4bf}» {FFFFFF}Ñò.Äèñïåò÷åð",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñòàðøåãî Äèñïåò÷åðà Control Room è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 10.')
	wait(7000)
	sampSendChat('/b Òåã â /r [Senior Dispatcher]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ñò.Äèñïåò÷åð Control Room.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Äèñïåò÷åð",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Äèñïåò÷åðà Control Room è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 11.')
	wait(7000)
	sampSendChat('/b Òåã â /r [Dispatcher CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Äèñïåò÷åð Control Room.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Ñîòðóäíèê",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñîòðóäíèêà Control Room è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 16.')
	wait(7000)
	sampSendChat('/b Òåã â /r [Employee CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ñîòðóäíèê Control Room.', cfg.main.tarr))
	end
   },
 }
end
function oinvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Îòäåë SES [Èíñïåêòîð SES]",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Èíñïåêòîðà Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñîé-Ñòàíöèè è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 10.')
	wait(5000)
	sampSendChat('/b òåã â /r [SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ïîâûøàåòñÿ â äîëíîñòè íà Èíñïåêòîðà Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñîé-Ñòàíöèè.', cfg.main.tarr))
	end
   },
  {
   title = "{80a4bf}» {FFFFFF}Îòäåë SES",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñòàæåðà Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñîé-Ñòàíöèè è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 19.')
	wait(5000)
	sampSendChat('/b Òåã â /r [Còàæåð SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé  ñîòðóäíèê  Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñîé-Ñòàíöèè.', cfg.main.tarr))
	end
   },

   -- {
   -- title = "{80a4bf}» {FFFFFF}Îòäåë ÓÒÓ",
    -- onclick = function()
	-- sampSendChat('/me äîñòàë(à) áåéäæèê Ñîòðóäíèêà(öû) Ó÷åáíî-Òðåíèíãîâî îòäåëåíèÿ è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	-- wait(5000)
	-- sampSendChat('/b /clist 15.')
	-- wait(5000)
	-- sampSendChat('/b Òåã â /r [ÓÒÓ]:')
	-- wait(5000)
	-- sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé  Ñîòðóäíèê Îòäåëà MA.', cfg.main.tarr))
	-- end
   -- },
   {
   title = "{80a4bf}» {FFFFFF}Îòäåë ÏÑÁ [Èíñïåêòîð ÏÑÁ]",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Èíñïåêòîðà Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 10.')
	wait(5000)
	sampSendChat('/b Òåã â /r [ÏÑÁ]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ïîâûøàåòñÿ â äîëíîñòè íà Èíñïåêòîðà Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Îòäåë ÏÑÁ",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñòàæåðà Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 2.')
	wait(5000)
	sampSendChat('/b Òåã â /r [Còàæåð ÏÑÁ]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé  ñîòðóäíèê  Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû.', cfg.main.tarr))
	end
   },
 }
end
function ginvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Îòäåë ÏÑÁ Ãëàâà.",
    onclick = function()
	if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâíûé Âðà÷' or  rank == 'Õèðóðã' or  rank == 'Äîêòîð' or  rank == 'Ïñèõîëîã' then
	sampSendChat('/me äîñòàë(à) áåéäæèê Ãëàâû  Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 21.')
	wait(5000)
	sampSendChat('/b Òåã â /r [Ãëàâà ÏÑÁ]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ãëàâà Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû ', cfg.main.tarr))
	else
	ftext('Âû íå ìîæåòå íàçíà÷èòü Ãëàâó äàííîãî îòäåëà.')
	end
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Îòäåë SES Ãëàâà.",
    onclick = function()
	if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâíûé Âðà÷' or  rank == 'Õèðóðã' then
	sampSendChat('/me äîñòàë(à) áåéäæèê Ãëàâû  Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñêîé-Ñòàíöèè è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 8.')
	wait(5000)
	sampSendChat('/b Òåã â /r [Ãëàâà SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ãëàâà Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñêîé-Ñòàíöèè ', cfg.main.tarr))
	else
	ftext('Âû íå ìîæåòå íàçíà÷èòü Ãëàâó äàííîãî îòäåëà.')
	end
	end
   },
 }
end
function fastmenu(id)
 return
{
  {
   title = "{80a4bf}»{FFFFFF} Ëåêöèè",
    onclick = function()
	submenus_show(fthmenu(id), "{9966cc}Medick Helper {0033cc}| Ëåêöèè")
	end
   },
    {
   title = "{80a4bf}»{FFFFFF} Ñîáåñåäîâàíèå {ff0000}(Ñò.Ñîñòàâ)",
    onclick = function()
	if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' then
	submenus_show(sobesedmenu(id), "{9966cc}Medick Helper {0033cc}| Ñîáåñåäîâàíèå")
	else
	ftext('Âû íå íàõîäèòåñü â ñòàðøåì ñîñòàâå.')
	end
	end
   },
    {
   title = "{80a4bf}»{FFFFFF} Âîïðîñû ïî óñòàâó {ff0000}(Ñò.Ñîñòàâ)",
    onclick = function()
	if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' then
	submenus_show(ustav(id), "{9966cc}Medick Helper {0033cc}| Âîïðîñû ïî óñòàâó")
	else
	ftext('Âû íå íàõîäèòåñü â ñòàðøåì ñîñòàâå.')
	end
	end
   },
    {
   title = "{80a4bf}»{FFFFFF} Ìåíþ {ffffff}ãîñ.íîâîñòåé {ff0000}(Ñò.Ñîñòàâ)",
    onclick = function()
	if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' then
	submenus_show(govmenu(id), "{9966cc}Medick Helper {0033cc}| Ìåíþ ãîñ.íîâîñòåé")
	else
	ftext('Âû íå íàõîäèòåñü â ñòàðøåì ñîñòàâå.')
	end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Ìåíþ {ffffff}îòäåëîâ  {ff0000}(Äëÿ ãëàâ îòäåëîâ)",
    onclick = function()
	if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' or rank == 'Äîêòîð' or rank == 'Íàðêîëîã' then
	submenus_show(otmenu(id), "{9966cc}Medick Helper {0033cc}| Ìåíþ îòäåëîâ")
	else
	ftext('Äàííîå ìåíþ äîñòóïíî ñ äîëæíîñòè Íàðêîëîã.')
	end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Âûçâàòü ñîòðóäíèêà ÏÎ â áîëüíèöó (/d).",
    onclick = function()
	if rank == 'Ìåä.áðàò' or rank =='Ñïàñàòåëü' or rank =='Íàðêîëîã' or rank == 'Äîêòîð' or rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' then
	sampSendChat(string.format('/d SAPD, âûøëèòå ñîòðóäíèêà â áîëüíèöó. Çàðàíåå ñïàñèáî.'))
	else
	ftext('Äàííàÿ ôóíêöèÿ äîñòóïíà ñ äîëæíîñòè Ìåä.áðàò.')
	end
	end
   },
}
end

function otmenu(id)
 return
{
   {
   title = "{80a4bf}»{FFFFFF} Àãèòàöèÿ {ffffff}EMS{ff0000} (Äëÿ ãëàâ/çàìîâ îòäåëà)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Óâàæàåìûå êîëëåãè, â îòäåë EMS ïðîõîäèò íàáîð ñîòðóäíèêîâ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: ×òîáû ïîïàñòü â îòäåë EMS âàì íóæíà äîëæíîñòü "Ñïàñàòåëÿ" è âûøå.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Â îòäåëå âàñ æäóò îïûòíûå íàñòàâíèêè êîòîðûå ïîìîãóò ñ îáó÷åíèåì.".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Áóäåòå ïðîõîäèòü 3 ýòàïà ÷òîáû ïîïàñòü â îñíîâíîé ñîñòàâ îòäåëà.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Çà ïðîõîæäåíèå âñåõ ýòàïîâ áóäåò âûïëà÷èâàòüñÿ 150.000$.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Íàó÷èì âàñ êàê ïðîâîäèòü ÑËÐ, ÈÂË è ïåðâóþ ìåäèöèíñêóþ ïîìîùü.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Åñëè âû õîòèòå ê íàì â îòäåë, ñîîáùèòå ýòî ëþáîìó èç ðóêîâäîñòâà EMS.', cfg.main.tarr))
    wait(5000)
	ftext("{FFFFFF}Âûâîä àãèòàöèè çàâåðøåí!")
	end
   },
}
end

function operacia(id)
    return
    {
      {
        title = '{ffffff}» Ïåðåëîì ðóêè/íîãè ¹1.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me ïîìîãàåò ïàöèåíòó äîéòè äî îïåðàöèîííîãî ñòîëà")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàäåëà ïåð÷àòêè íà ñâîè ðóêè è çàêðûëà øêàô")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âêëþ÷èâ ðåíòãåí-àïïàðàò â ñåòü, íàâ¸ëà èçëó÷àòåëè íà ïàöèåíòà")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ñíèìîê áûë ãîòîâ.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà â ñâîè ðóêè ñíèìîê è íà÷àëà åãî ðàññìàòðèâàòü")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Ýòî çàêðûòûé ïåðåëîì*ïîêàçàâ ïàöèåíòó ïàëüöåì íà ó÷àñòîê êîñòè íà ðåíòãåíå.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óëîæèëà ïàöèåíòà íà îïåðàöèîííûé ñòîë")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç øêàôà ýëàñòè÷íûé áèíò è ïîëîæèëà åãî ðÿäîì")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàôèêñèðîâàëà ðóêó â íåïîäâèæíîì ñîñòîÿíèè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Â ðóêå ìåäèöèíñêàÿ øèíà.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàëîæèëà øèíó íà ìåñòî ïåðåëîìà áåç äàâëåíèÿ íà ñîñóäû")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try ïåðåâÿçàëà âîêðóã øèíû ýëàñòè÷íûé áèíò ïðèêëàäûâàÿ ñðåäíþþ ñèëó")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me ïîìîãàåò ïàöèåíòó äîéòè äî îïåðàöèîííîãî ñòîëà")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàäåë ïåð÷àòêè íà ñâîè ðóêè è çàêðûë øêàô")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âêëþ÷èâ ðåíòãåí-àïïàðàò â ñåòü, íàâ¸ë èçëó÷àòåëè íà ïàöèåíòà")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ñíèìîê áûë ãîòîâ.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë â ñâîè ðóêè ñíèìîê è íà÷àë åãî ðàññìàòðèâàòü")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Ýòî çàêðûòûé ïåðåëîì*ïîêàçàâ ïàöèåíòó ïàëüöåì íà ó÷àñòîê êîñòè íà ðåíòãåíå.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óëîæèë ïàöèåíòà íà îïåðàöèîííûé ñòîë")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç øêàôà ýëàñòè÷íûé áèíò è ïîëîæèë åãî ðÿäîì")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàôèêñèðîâàë ðóêó â íåïîäâèæíîì ñîñòîÿíèè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Â ðóêå ìåäèöèíñêàÿ øèíà.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàëîæèë øèíó íà ìåñòî ïåðåëîìà áåç äàâëåíèÿ íà ñîñóäû")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try ïåðåâÿçàë âîêðóã øèíû ýëàñòè÷íûé áèíò ïðèêëàäûâàÿ ñðåäíþþ ñèëó")
		end
		end
      },
	  {
        title = '{5b83c2}« Åñëè íåóäà÷íî, òî ïåðåõîäèì ê ¹2. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Ïåðåëîì ðóêè/íîãè ¹2.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/do Ó ïàöèåíòà áûëè ýìîöèè íà ëèöå, ïîêàçûâàþùèå åãî áîëü.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îñëàáèëà íåìíîãî áèíò, ñáàâëÿÿ ñâîþ ñèëó")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try âçãëÿíóëà íà ëèöî ïàöèåíòà è ñèëà ïåðåâÿçêè íå äîñòàâëÿëà åìó áîëè")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/do Ó ïàöèåíòà áûëè ýìîöèè íà ëèöå, ïîêàçûâàþùèå åãî áîëü.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îñëàáèë íåìíîãî áèíò, ñáàâëÿÿ ñâîþ ñèëó")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try âçãëÿíóë íà ëèöî ïàöèåíòà è ñèëà ïåðåâÿçêè íå äîñòàâëÿëà åìó áîëè")
		end
		end
      },
	  {
        title = '{ffffff}» Ïóëåâîå ðàíåíèå ¹1.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me ïîäîøëà ê øêàôó, äîñòàëà èç íåãî ïåð÷àòêè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîìûëà ðóêè ïîä êðàíîì, îäåëà ïåð÷àòêè è çàêðûëà øêàô")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Ëîæèòåñü, ÿ âàì îêàæó ïîìîùü*ïîêàçàâ ðóêîé íà ñòîë.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Êèñëîðîäíàÿ ìàñêà âèñåëà ïåðåä ëèöîì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîêðóòèëà âåíòèëü, ïîäàâ òåì ñàìûì íàðêîç")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîñëå ïîäà÷è íàðêîçà ïàöèåíò óñíóë.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà ñî ñòîëà ïîäíîñ ñ õèðóðãè÷åñêèìè èíñòðóìåíòàìè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîñòàâèëà ïîäíîñ íà òàáóðåò ðÿäîì ñ îïåðàöèîííûì ñòîëîì")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âêîëîëà øïðèö ñ 2 ïðîöåíòàìè Äèáàçîëà è ââ¸ëà îáåçáîëèâàþùåå")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà ñ ïîäíîñà ïèíöåò è ïðîëåçëà èì â ðàíó")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñòàðàåòñÿ îñòîðîæíî çàöåïèòü ïóëþ ïèíöåòîì")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try èçúÿëà ïóëþ, íàùóïàâ å¸")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me ïîäîø¸ë ê øêàôó, äîñòàë èç íåãî ïåð÷àòêè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîìûë ðóêè ïîä êðàíîì, îäåë ïåð÷àòêè è çàêðûë øêàô")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Ëîæèòåñü, ÿ âàì îêàæó ïîìîùü*ïîêàçàâ ðóêîé íà ñòîë.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Êèñëîðîäíàÿ ìàñêà âèñåëà ïåðåä ëèöîì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîêðóòèë âåíòèëü, ïîäàâ òåì ñàìûì íàðêîç")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîñëå ïîäà÷è íàðêîçà ïàöèåíò óñíóë.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë ñî ñòîëà ïîäíîñ ñ õèðóðãè÷åñêèìè èíñòðóìåíòàìè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîñòàâèë ïîäíîñ íà òàáóðåò ðÿäîì ñ îïåðàöèîííûì ñòîëîì")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âêîëîë øïðèö ñ 2 ïðîöåíòàìè Äèáàçîëà è ââ¸ë îáåçáîëèâàþùåå")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë ñ ïîäíîñà ïèíöåò è ïðîëåç èì â ðàíó")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñòàðàåòñÿ îñòîðîæíî çàöåïèòü ïóëþ ïèíöåòîì")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try èçúÿë ïóëþ, íàùóïàâ å¸")
		end
		end
      },
	  {
        title = '{5b83c2}« Åñëè íåóäà÷íî, òî ïåðåõîäèì ê ¹2. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Ïóëåâîå ðàíåíèå ¹2.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me öåïëÿåò ïóëþ, äåëàÿ ýòî îñòîðîæíî")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try èçúÿëà ïóëþ, íàùóïàâ å¸")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me öåïëÿåò ïóëþ, äåëàÿ ýòî îñòîðîæíî")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try èçúÿë ïóëþ, íàùóïàâ å¸")
		end
		end
      },
	  {
        title = '{5b83c2}« Åñëè óäà÷íî, òî ïåðåõîäèì ê ¹3. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Ïóëåâîå ðàíåíèå ¹3.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me èçâë¸êëà ïóëþ èç ÷åëîâåêà è ïîëîæèëà å¸ íà ïîäíîñ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà ø¸ëêîâóþ èãëó è ïðîäåëà íèòêó â óøêî èãðû")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íà÷àëà íàêëàäûâàòü øâû, ñòÿãèâàÿ êîæó ó ðàíû")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîñëå íàëîæåíèÿ øâîâ, îíè áûëè çàôèêñèðîâàíû.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà íîæíèöû è îáðåçàëà ëèøíþþ íèòî÷êó")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàëà ìåñòî ðàíåíèÿ àíòèñåïòèêîì è ñëîæèëà âñ¸ íà ïîäíîñ")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me èçâë¸ê ïóëþ èç ÷åëîâåêà è ïîëîæèë å¸ íà ïîäíîñ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë ø¸ëêîâóþ èãëó è ïðîäåë íèòêó â óøêî èãðû")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íà÷àë íàêëàäûâàòü øâû, ñòÿãèâàÿ êîæó ó ðàíû")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîñëå íàëîæåíèÿ øâîâ, îíè áûëè çàôèêñèðîâàíû.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë íîæíèöû è îáðåçàë ëèøíþþ íèòî÷êó")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàë ìåñòî ðàíåíèÿ àíòèñåïòèêîì è ñëîæèë âñ¸ íà ïîäíîñ")
		end
		end
      },
	  {
        title = '{ffffff}» Íîæåâîå ðàíåíèå.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me ïîäîøëà ê øêàôó, äîñòàëà èç íåãî ïåð÷àòêè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîìûâ ðóêè ïîä êðàíîì, îäåëà ïåð÷àòêè è çàêðûëà øêàô")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Ðàçäåâàéòåñü, âåùè ïîëîæèòå ñþäà*ïîêàçàâ ðóêîé íà ñòóë.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Êèñëîðîäíàÿ ìàñêà âèñåëà ïåðåä ëèöîì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîêðóòèëà âåíòèëü, ïîäàâ òåì ñàìûì íàðêîç")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà ñî ñòîëà ïîäíîñ ñ õèðóðãè÷åñêèìè èíñòðóìåíòàìè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íåñ¸ò ïîäíîñ â ðóêàõ è ñòàâèò ïîäíîñ íà òàáóðåò")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà ñ ïîäíîñà øïðèö ñ ðàñòâîðîì Äèáàçîëà")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âêîëîëà øïðèö ðÿäîì ñ ìåñòîì ðàíåíèÿ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Îáåçáîëèâàþùåå ïîäåéñòâîâàëî.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íà÷àëà íàêëàäûâàòü øâû, ñòÿíóâ êîæó ó ðàíû")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàêîí÷èâ íàëîæåíèå øâîâ, çàòåì çàôèêñèðîâàëà èõ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðåçàëà ëèøíþþ íèòü íîæíèöàìè è âçÿëà àíòèñåïòèê")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàëà øâû àíòèñåïòèêîì è ñëîæèëà âñ¸ íà ïîäíîñ")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me ïîäîø¸ë ê øêàôó, äîñòàë èç íåãî ïåð÷àòêè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîìûâ ðóêè ïîä êðàíîì, îäåë ïåð÷àòêè è çàêðûë øêàô")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Ðàçäåâàéòåñü, âåùè ïîëîæèòå ñþäà*ïîêàçàâ ðóêîé íà ñòóë.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Êèñëîðîäíàÿ ìàñêà âèñåëà ïåðåä ëèöîì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîêðóòèë âåíòèëü, ïîäàâ òåì ñàìûì íàðêîç")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë ñî ñòîëà ïîäíîñ ñ õèðóðãè÷åñêèìè èíñòðóìåíòàìè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íåñ¸ò ïîäíîñ â ðóêàõ è ñòàâèò ïîäíîñ íà òàáóðåò")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë ñ ïîäíîñà øïðèö ñ ðàñòâîðîì Äèáàçîëà")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âêîëîë øïðèö ðÿäîì ñ ìåñòîì ðàíåíèÿ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Îáåçáîëèâàþùåå ïîäåéñòâîâàëî.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íà÷àë íàêëàäûâàòü øâû, ñòÿíóâ êîæó ó ðàíû")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàêîí÷èâ íàëîæåíèå øâîâ, çàòåì çàôèêñèðîâàë èõ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðåçàë ëèøíþþ íèòü íîæíèöàìè è âçÿë àíòèñåïòèê")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàë øâû àíòèñåïòèêîì è ñëîæèë âñ¸ íà ïîäíîñ")
		end
		end
      },
	  {
        title = '{ffffff}» Óäàëåíèå àïïåíäèöèòà.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me ïîäîøëà ê øêàôó, äîñòàëà èç íåãî ïåð÷àòêè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîìûëà ðóêè ïîä êðàíîì, îäåëà ïåð÷àòêè è çàêðûëà øêàô")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Êèñëîðîäíàÿ ìàñêà âèñåëà ïåðåä ëèöîì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîêðóòèëà âåíòèëü, ïîäàâ òåì ñàìûì íàðêîç")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîñëå ïîäà÷è íàðêîçà ïàöèåíò óñíóë.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà ñî ñòîëà ïîäíîñ ñ õèðóðãè÷åñêèìè èíñòðóìåíòàìè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà ñ ïîäíîñà äûõàòåëüíóþ òðóáêó è ââ¸ëà â òðàõåþ ïàöèåíòà")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàìåòèâ ìàðêåðîì ìåñòî íàäðåçà, çàòåì ñäåëàëà íàäðåç")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà â ðóêè ïèíöåò è ïðîëåçëà â íàäðåç")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàöåïèëà ïèíöåòîì àïïåíäèêñ è îáðåçàëà âîñïàë¸ííûé îðãàí")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me èçâë¸êëà àïïåíäèêñ ïèíöåòîì èç ðàíû, óáðàëà íà ïîäíîñ ñêàëüïåëü")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà ñî ñòîëà íèòü è èãëó, ïîòîì ïðîäåëà íèòü â óøêî")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñòÿíóëà òêàíè â ñëåïîé êèøêå è íàëîæèëà øâû")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàôèêñèðîâàâ øâû è îòðåçàëà íèòü íîæíèöàìè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïðîöåññ íàëîæåíèÿ øâîâ íà òåëî ïàöèåíòà.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñëîæèëà âñ¸ íà ïîäíîñ è îáðàáîòàëà")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèëà âñ¸ íà ïîäíîñ, ñíÿëà ïåð÷àòêè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàëà ìåñòî øâîâ àíòèñåïòèêîì")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me ïîäîø¸ë ê øêàôó, äîñòàë èç íåãî ïåð÷àòêè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîìûë ðóêè ïîä êðàíîì, îäåë ïåð÷àòêè è çàêðûë øêàô")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Êèñëîðîäíàÿ ìàñêà âèñåëà ïåðåä ëèöîì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîêðóòèë âåíòèëü, ïîäàâ òåì ñàìûì íàðêîç")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîñëå ïîäà÷è íàðêîçà ïàöèåíò óñíóë.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë ñî ñòîëà ïîäíîñ ñ õèðóðãè÷åñêèìè èíñòðóìåíòàìè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë ñ ïîäíîñà äûõàòåëüíóþ òðóáêó è ââ¸ë â òðàõåþ ïàöèåíòà")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàìåòèâ ìàðêåðîì ìåñòî íàäðåçà, çàòåì ñäåëàë íàäðåç")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë â ðóêè ïèíöåò è ïðîëåç â íàäðåç")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàöåïèë ïèíöåòîì àïïåíäèêñ è îáðåçàë âîñïàë¸ííûé îðãàí")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me èçâë¸ê àïïåíäèêñ ïèíöåòîì èç ðàíû, óáðàë íà ïîäíîñ ñêàëüïåëü")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë ñî ñòîëà íèòü è èãëó, ïîòîì ïðîäåë íèòü â óøêî")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñòÿíóë òêàíè â ñëåïîé êèøêå è íàëîæèë øâû")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàôèêñèðîâàâ øâû è îòðåçàë íèòü íîæíèöàìè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïðîöåññ íàëîæåíèÿ øâîâ íà òåëî ïàöèåíòà.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñëîæèë âñ¸ íà ïîäíîñ è îáðàáîòàë")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèë âñ¸ íà ïîäíîñ, ñíÿë ïåð÷àòêè")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàë ìåñòî øâîâ àíòèñåïòèêîì")
		end
		end
      },
    }
end

function sobesedmenu(id)
    return
    {
      {
        title = '{80a4bf}» {ffffff}Ïðèâåòñòâèå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat('Çäðàâñòâóéòå. ß ñîòðóäíèê áîëüíèöû '..myname:gsub('_', ' ')..', âû íà ñîáåñåäîâàíèå?')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ '..rank..' | '..myname:gsub('_', ' ')..'.')
		end
      },
      {
        title = '{80a4bf}» {ffffff}Äîêóìåíòû.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Âàø ïàñïîðò è äèïëîì, ïîæàëóéñòà.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/b /showpass '..myid..'')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/b Äèïëîì ïî ÐÏ.')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Çàÿâëåíèå íà îô.ïîðòàë íà Íàðêîëîãà{ff0000} ñ 6 ëåò â øòàòå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Âû ìîæåòå îñòàâèòü çàÿâëåíèå íà îô.ïîðòàëå, íà äîëæíîñòü Íàðêîëîãà, à ìîæåòå ñåé÷àñ íà Èíòåðíà.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/b evolve-rp.su -> Èãðîâîé ñåðâåð Saint-Louis -> Ãîñóäàðñòâåííûå ñòðóêòóðû -> Ìèíèñòåðñòâî Çäðàâîîõðàíåíèÿ -> Çàÿâëåíèå íà äîëæíîñòü « Ìåä.Áðàò » | « Íàðêîëîã »')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Èëè ñåé÷àñ îñòàâèòå çàÿâëåíèå íà èíòåðíà?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff} Èçó÷åíèå äîêóìåíòîâ.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat('/me âçÿëà äîêóìåíòû ó ÷åëîâåêà íàïðîòèâ, ïîñëå íà÷àëà èõ èçó÷àòü')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me îçíàêîìèâøèñü ñ äîêóìåíòàìè, âåðíóëà èõ îáðàòíî')
        end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
		sampSendChat('/me âçÿë äîêóìåíòû ó ÷åëîâåêà íàïðîòèâ, ïîñëå íà÷àë èõ èçó÷àòü')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me îçíàêîìèâøèñü ñ äîêóìåíòàìè, âåðíóë èõ îáðàòíî')
		end
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ðàññêàæèòå íåìíîãî î ñåáå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat('Õîðîøî, ðàññêàæèòå íåìíîãî î ñåáå.')
		wait(4000)
        end
      },
	  {
	     title = '{80a4bf}» {ffffff}Ðàáîòàëè ëè ðàíüøå â ìîí',
        onclick = function()
        sampSendChat('Ðàáîòàëè ðàíüøå â Ìèíèíèñòåðñòâå Çäðàâîîõðàíåíèÿ?')
		wait(4000)
        end
      },
	  {
	   title = '{80a4bf}» {ffffff}Ïðîáëåìû ñ çàêîíîì.',
	   onclick = function()
	   sampSendChat('Èìåëè ðàíüøå ïðîáëåìû ñ çàêîíîì?')
	   wait(4000)
	   end
      },
	  {
        title = '{80a4bf}» {ffffff}Còðåññ íà ðàáîòå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Êàê âû ñïðàâëÿåòåñü ñî ñòðåññîì íà ðàáîòå?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïðîøëàÿ ðàáîòà.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('×òî âàñ íå óñòðàèâàëî íà ïðîøëîé ðàáîòå?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Çàðïëàòà.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Íà êàêóþ çàðïëàòó âû ðàñ÷èòûâàåòå?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}ÐÏ òåðìèíû.',
        onclick = function()
        sampSendChat('×òî ïî âàøåìó îçíà÷àþò ïîíÿòèÿ êàê ÐÏ è ÄÌ?')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}×òî íàä ãîëîâîé.',
        onclick = function()
        sampSendChat('×òî ó ìåíÿ íàä ãîëîâîé?')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïðèêàçû ðóêîâîäñòâà.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Êàê âû ïåðåíîñèòå ïðèêàçû ðóêîâîäñòâà?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}ÐÏ òåðìèíû â /b.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('/b ÐÏ è ÒÊ â /sms '..myid..'')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Âû ïðèíÿòû.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Ïîçäðàâëÿþ, âû íàì ïîäõîäèòå.')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Âû íå ïðèíÿòû.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Ïðîøó ïðîùåíèÿ, íî âû íàì íå ïîäõîäèòå. Ïîêèíüòå ñîáåñåäîâàíèÿ.')
        end
	  },
    }
end

function govmenu(id)
 return
{
   {
   title = "{80a4bf}»{FFFFFF} Ïåðâàÿ ãîâêà",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, çàíÿëà âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
		wait(1300)
		sampSendChat("/gov [Medic]: Óâàæàåìûå ãðàæäàíå è ãîñòè øòàòà. Cåé÷àñ ñîñòîèòñÿ ïðè¸ì â èíòåðíàòóðó Ìèíçäðàâà.")
        wait(7000)
        sampSendChat('/gov [Medic]: Òðåáîâàíèÿ: ïðîïèñêà â Øòàòå îò 3 ëåò, îòâåòñòâåííîñòü è àäåêâàòíîñòü.')
        wait(7000)
		sampSendChat('/gov [Medic]: Æäåì âàñ â öåíòðàëüíîé áîëüíèöå ã. Los-Santos íà âòîðîì ýòàæå.')
		wait(7000)
        sampSendChat("/d OG, îñâîáîäèëà âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
		wait(7000)
		sampAddChatMessage("{F80505}Â îáÿçàòåëüíîì ïîðÿäêå {F80505}äîáàâüòå {0CF513} /addvacancy.", -1)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
	},
	{
   title = "{80a4bf}»{FFFFFF} Âòîðàÿ ãîâêà",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, çàíÿëà âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
        wait(1300)
        sampSendChat("/gov [Medic] Óâàæàåìûå ãðàæäàíå è ãîñòè øòàòà. Íà÷àëñÿ ïðè¸ì â èíòåðíàòóðó Ìèíçäðàâà.")
                wait(7000)
        sampSendChat('/gov [Medic] Æäåì âñåõ æåëàþùèõ â öåíòðàëüíîé áîëüíèöå ã. Los-Santos íà âòîðîì ýòàæå.')
                wait(7000)
	sampSendChat('/gov [Medic] Òðåáîâàíèÿ: ïðîïèñêà â Øòàòå îò 3 ëåò, îòâåòñòâåííîñòü è àäåêâàòíîñòü.')
	        wait(7000)
        sampSendChat("/d OG, îñâîáîäèëà âîëíó ãîñóäàðñòâåííûõ íîâîñòåé..")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
    {
   title = "{80a4bf}»{FFFFFF} Òðåòÿÿ ãîâêà",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, çàíÿëà âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
        wait(1300)
        sampSendChat("/gov [Medic] Óâàæàåìûå æèòåëè è ãîñòè øòàòà. Íàïîìèíàþ, ÷òî ñåé÷àñ èäåò ïðè¸ì â Ìèíçäðàâ.")
        wait(7000)
        sampSendChat('/gov [Medic] Òðåáîâàíèÿ: ïðîïèñêà â Øòàòå îò 3 ëåò, îòâåòñòâåííîñòü è àäåêâàòíîñòü.')
        wait(7000)
	sampSendChat('/gov [Medic]: Äëÿ âñåõ ñîòðóäíèêîâ, ïîÿâèëàñü âîçìîæíîñòü çà 2 íåäåëè çàðàáîòàòü 110 ìëí$')
		wait(7000)
        sampSendChat("/d OG, îñâîáîäèëà âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
    {
   title = '{80a4bf}»{FFFFFF} ×åòâåðòàÿ ãîâêà',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat('/d OG, çàíÿëà âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.')
                wait(1300)
        sampSendChat('/gov [Medic] Óâàæàåìûå æèòåëè è ãîñòè øòàòà. Ê ñîæàëåíèþ ïðè¸ì â èíòåðíàòóðó Ìèíçäðàâà çàêîí÷åí.')
        wait(7000)
	sampSendChat('/gov [Medic] Âû ìîæåòå îñòàâèòü çàÿâëåíèå íà äîëæíîñòü Ìåä.Áðàò-Íàðêîëîã, íà îôô.ïîðòàëå.')
		wait(7000)
        sampSendChat('/gov [Medic] Íàïîìèíàþ, çà ïðîõîæäåíèå êóðñà ïîäãîòîâêè âðà÷åé, Âû ìîæåòå ïîëó÷èòü 110 ìëí$')
		wait(7000)
        sampSendChat('/d OG, îñâîáîäèëà âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
}
end

function fastsmsk()
	if lastnumber ~= nil then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/t "..lastnumber.." ")
	else
		ftext("Âû ðàíåå íå ïîëó÷àëè âõîäÿùèõ ñîîáùåíèé.", 0x046D63)
	end
end
function fthmenu(id)
 return
{
  {
        title = '{80a4bf}»{FFFFFF} Ëåêöèÿ äëÿ {139BEC}Èíòåðíà.',
    onclick = function()
	    sampSendChat('Ïðèâåòñòâóþ! Âû óñïåøíî ïðîøëè ñîáåñåäîâàíèå è ïîïàëè â ìåäèöèíñêóþ àêàäåìèþ!')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ðàáî÷èé äåíü â áóäíèå äíè íà÷èíàåòñÿ ñ 10:00 ïî 20:00, â âûõîäíûå äíè..')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('.. ñ 11:00 ïî 19:00. Îáåäåííûé ïåðåðûâ ñ 13:00 ïî 14:00.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåé÷àñ ÿ âàì ïåðåäàì áåéäæèê îòäåëåíèÿ ÌÀ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me ïåðåäàëà ÷åëîâåêó íàïðîòèâ áåéäæèê ñ íàäïèñüþ "ÌÀ"')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/b /clist 13.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Âû îáÿçàíû êàæäûé ðàç ïðîãîâàðèâàòü ñâîå îòäåëåíèå â ðàöèþ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/b /r [MA]: Òåêñò.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Âàøè îñíîâíûå îáÿçàííîñòè ýòî: ïàòðóëèðîâàíèå øòàòà, ñòîÿòü íà ïîñòàõ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Âàøà ïåðâîíà÷àëüíàÿ çàðàáîòíàÿ ïëàòà ñîñòàâëÿåò - 9.750 âèðò.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñ êàæäûì ïîâûøåíèåì çàðïëàòà áóäåò ðàñòè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Òàê.. Äàâàéòå ÿ âàì ðàññêàæó ïðî ïîñòû.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Îñíîâíûå ïîñòû - Ìýðèÿ, Ìîñò ËÑ-ÑÔ / ËÑ-ËÂ, Àâòîâîêçàë LS / SF / LV, àâòîøêîëà.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Êîãäà òû çàñòóïèë, íàõîäèøñÿ, ïîêèäàåøü ïîñò, îá ýòîì îáÿçàí(à) ñîîáùèòü â ðàöèþ!')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íàïðèìåð, äàâàéòå âîçüì¸ì ïîñò Ìýðèÿ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Âûåçæàþ íà ïîñò - Ìýðèÿ | Íàïàðíèê -.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Çàñòóïèë íà ïîñò - Ìýðèÿ | Âûëå÷åíî ãðàæäàí - | Ïðèíÿòî âûçîâîâ -.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ïîêèäàþ ïîñò - Ìýðèÿ | Ïðè÷èíà -.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Âàøå ïîâûøåíèå ïðîèçîéäåò çàâòðà. Çàâòðà âû äîëæíû ñäàòü ñëåäóþùåå:')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('- Îòâåòèòü íà 5 âîïðîñîâ èç óñòàâà áîëüíèöû .')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('- Çíàòü êàáèíåòû, òðàíñïîðò, ïîñòû, ãðàôèê ðàáîòû áîëüíèöû;')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('ß âàì ðàññêàçàë(à) îñíîâíóþ èíôîðìàöèþ. Åñëè ó âàñ åñòü âîïðîñû - çàäàâàéòå.')
		wait(5000)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
   title = '{80a4bf}»{FFFFFF} Ïåðâàÿ ïîìîùü ïðè {139BEC}êðîâîòå÷åíèÿõ.',
    onclick = function()
       sampSendChat('Ïðèâåòñòâóþ, êîëëåãè. Ñåãîäíÿ ÿ ïðî÷òó âàì ëåêöèþ íà òåìó «Ïåðâàÿ ïîìîùü ïðè êðîâîòå÷åíèè».')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Íóæíî ÷åòêî ïîíèìàòü, ÷òî àðòåðèàëüíîå êðîâîòå÷åíèå ïðåäñòàâëÿåò ñìåðòåëüíóþ îïàñíîñòü äëÿ æèçíè.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ïåðâîå, ÷òî òðåáóåòñÿ  ïåðåêðûòü ñîñóä âûøå ïîâðåæäåííîãî ìåñòà.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Äëÿ ýòîãî ïðèæìèòå àðòåðèþ ïàëüöàìè è ñðî÷íî ãîòîâüòå æãóò.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Èñïîëüçóéòå â òàêîì ñëó÷àå ëþáûå ïîäõîäÿùèå ñðåäñòâà:')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Øàðô, ïëàòîê, ðåìåíü, îòîðâèòå äëèííûé êóñîê îäåæäû.') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ñòÿãèâàéòå æãóò äî òåõ ïîð, ïîêà êðîâü íå ïåðåñòàíåò ñî÷èòüñÿ èç ðàíû.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Â ñëó÷àå âåíîçíîãî êðîâîòå÷åíèÿ äåéñòâèÿ ïîâòîðÿþòñÿ, çà èñêëþ÷åíèåì òîãî, ÷òî..') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..æãóò íàêëàäûâàåòñÿ ÷óòü íèæå ïîâðåæä¸ííîãî ìåñòà.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ñëåäóåò ïîìíèòü, ÷òî ïðè îáîèõ âèäàõ êðîâîòå÷åíèÿ æãóò íàêëàäûâàåòñÿ íå áîëåå äâóõ ÷àñîâ..') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..â æàðêóþ ïîãîäó è íå áîëåå ÷àñà â õîëîäíóþ.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ïðè êàïèëëÿðíîì êðîâîòå÷åíèè ñëåäóåò îáðàáîòàòü ïîâðåæäåííîå ìåñòî ïåðåêèñüþ âîäîðîäà..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..è íàëîæèòü ïëàñòûðü, ëèáî ïåðåáèíòîâàòü ðàíó. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ñïàñèáî çà âíèìàíèå.')
       wait(1200)
       if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
  title = '{80a4bf}»{FFFFFF} Ïåðâàÿ ïîìîùü ïðè {139BEC}îáìîðîêàõ.',
    onclick = function()
      sampSendChat('Ïðèâåòñòâóþ, êîëëåãè. Ñåãîäíÿ ÿ ïðî÷òó âàì ëåêöèþ íà òåìó «Ïåðâàÿ ïîìîùü ïðè îáìîðîêàõ».')
      wait(cfg.commands.zaderjka * 5000)
      sampSendChat('Îáìîðîêè ñîïðîâîæäàþòñÿ êðàòêîâðåìåííîé ïîòåðåé ñîçíàíèÿ, âûçâàííîé..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..íåäîñòàòî÷íûì êðîâîñíàáæåíèåì ìîçãà. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Îáìîðîê ìîãóò âûçâàòü: ðåçêàÿ áîëü, ýìîöèîíàëüíûé ñòðåññ, ÑÑÁ è òàê äàëåå.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Áåññîçíàòåëüíîìó ñîñòîÿíèþ îáû÷íî ïðåäøåñòâóåò ðåçêîå óõóäøåíèå ñàìî÷óâñòâèÿ..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..íàðàñòàåò ñëàáîñòü, ïîÿâëÿåòñÿ òîøíîòà, ãîëîâîêðóæåíèå, øóì èëè çâîí â óøàõ.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Çàòåì ÷åëîâåê áëåäíååò, ïîêðûâàåòñÿ õîëîäíûì ïîòîì è âíåçàïíî òåðÿåò ñîçíàíèå.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Ïåðâàÿ ïîìîùü äîëæíà áûòü íàïðàâëåíà íà óëó÷øåíèå êðîâîñíàáæåíèÿ ìîçãà..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..è îáåñïå÷åíèå ñâîáîäíîãî äûõàíèÿ.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Åñëè ïîñòðàäàâøèé íàõîäèòñÿ â äóøíîì, ïëîõî ïðîâåòðåííîì ïîìåùåíèè, òî..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..îòêðîéòå îêíî, âêëþ÷èòå âåíòèëÿòîð èëè âûíåñèòå ïîòåðÿâøåãî ñîçíàíèå íà âîçäóõ.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Ïðîòðèòå åãî ëèöî è øåþ õîëîäíîé âîäîé, ïîõëîïàéòå ïî ùåêàì è..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..äàéòå ïîñòðàäàâøåìó ïîíþõàòü âàòêó, ñìî÷åííóþ íàøàòûðíûì ñïèðòîì.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Ñïàñèáî çà âíèìàíèå.')
       wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Ïåðâàÿ ïîìîùü ïðè {139BEC}ÄÒÏ.',
    onclick = function()
       sampSendChat('Ïðèâåòñòâóþ, êîëëåãè. Ñåãîäíÿ ÿ ïðî÷òó âàì ëåêöèþ íà òåìó «Ïåðâàÿ ïîìîùü ïðè ÄÒÏ».')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Îêàçûâàÿ ïåðâóþ ïîìîùü, íåîáõîäèìî äåéñòâîâàòü ïî ïðàâèëàì.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Íåìåäëåííî îïðåäåëèòå õàðàêòåð è èñòî÷íèê òðàâìû.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Íàèáîëåå ÷àñòûå òðàâìû â ñëó÷àå ÄÒÏ - ñî÷åòàíèå ïîâðåæäåíèé ÷åðåïà..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..è íèæíèõ êîíå÷íîñòåé è ãðóäíîé êëåòêè.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Íåîáõîäèìî èçâëå÷ü ïîñòðàäàâøåãî èç àâòîìîáèëÿ, îñìîòðåòü åãî.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Äàëåå ñëåäóåò îêàçàòü ïåðâóþ ïîìîùü â ñîîòâåòñòâèè ñ âûÿâëåííûìè òðàâìàìè.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Âûÿâèâ èõ, òðåáóåòñÿ ïåðåíåñòè ïîñòðàäàâøåãî â áåçîïàñíîå ìåñòî..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..óêðûòü îò õîëîäà, çíîÿ èëè äîæäÿ è âûçâàòü âðà÷à, à çàòåì..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..îðãàíèçîâàòü òðàíñïîðòèðîâêó ïîñòðàäàâøåãî â ëå÷åáíîå ó÷ðåæäåíèå.') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ñïàñèáî çà âíèìàíèå.')
       wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ äëÿ {139BEC}Íàðêîëîãà.',
    onclick = function()
	    sampSendChat('Çäðàñòâóéòå. Íà äîëæíîñòè Íàðêîëîã íîñèì ñâîè áýéäæèêè ¹18.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåàíñû îò íàðêîçàâèñèìîñòè ïðîèçâîäÿòñÿ ñïåöèàëèçèðîâàííûìè ïðåïàðàòàìè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåàíñû ïðîâîäÿòñÿ òîëüêî â îïåðàöèîííîé íà âòîðîì ýòàæå áîëüíèöå ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Òàê æå âû òåïåðü äîëæíû áóäåòå ïîìîãàòü íà ïðèçûâàõ. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('×òîáû ïîâûñèòñÿ â äîëæíîñòè, âàì íóæíî áóäåò ïðîéòè øêîëó Ñïàñàòåëåé, øêîëà ñîñòîèò èç 6-è ýòàïîâ. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ïîäðîáíåé íà îôèöèàëüíîì ñàéòå Ìèíèñòåðñòâà Çäðàâîîõðàíåíèÿ. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íà ýòîì ëåêöèÿ îêîí÷åíà. Âîïðîñû èìååþòñÿ? ')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ î {139BEC}âðåäå êóðåíèÿ.',
    onclick = function()
	    sampSendChat('Òåïåðü ÿ ðàññêàæó âàì î âðåäå êóðåíèÿ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Êóðåíèå - îäíà èç ñàìûõ çíàìåíèòûõ è ðàñïðîñòðàíåííûõ ïðèâû÷åê íà ñåãîäíÿøíèé äåíü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Çàïîìíèòå, ãîñïîäà, íåñêîëüêî âåùåé.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Êóðåíèå âûçûâàåò ðàê è õðîíè÷åñêîå çàáîëåâàíèå ëåãêèõ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Òàêæå, òàáà÷íûé äûì âûçûâàåò ó íåêîòîðûõ ëþäåé âñÿ÷åñêèå êîæíûå çàáîëåâàíèÿ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Áðîñü ñèãàðåòó - ñïàñè ñåáÿ è âåñü ìèð.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íà ýòîì âñå, ïîìíèòå, Ìèíèñòåðñòâî Çäðàâîîõðàíåíèÿ çàáîòèòñÿ î âàøåì çäîðîâüå.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ î òîì {139BEC} êàê íóæíî îáðàùàòüñÿ ñ ïàöèåíòàìè.',
    onclick = function()
	    sampSendChat('Òåïåðü ëåêöèÿ, î òîì, êàê íóæíî îáðàùàòüñÿ ñ ïàöèåíòàìè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Äëÿ íà÷àëà, âû äîëæíû âåæëèâî èõ ïîïðèâåòñòâîâàòü, ÷òî áû èì áûëî ïðèÿòíî.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Äàëüøå, âû äîëæíû ïðåäñòàâèòüñÿ, è ñïðîñèòü ÷åì ìîæåòå ïîìî÷ü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Åñëè æå ÷åëîâåê ìîë÷èò, íå óõîäèòå, ìîæåò äóìàåò ÷òî âûáðàòü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Êîãäà ÷åëîâåê çàäàë âîïðîñ, âû äîëæíû êîððåêòíî îòâåòèòü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Åñëè æå âîïðîñ ãðóáûé, íåàäåêâàòíûé, íå îòâå÷àéòå.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ïðè óãðîçå è íåàäåêâàòíûõ äåéñòâèÿõ - âûçîâèòå ïîëèöèþ.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñïàñèáî çà âíèìàíèå, äàííàÿ ëåêöèÿ ïîäîøëà ê êîíöó.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ î {139BEC} íàðêîòè÷åñêèõ ïðåïàðàòàõ',
    onclick = function()
	    sampSendChat('Çäðàâñòâóéòå, óâàæàåìûå êîëëåãè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåé÷àñ ÿ ðàññêàæó âàì î âðåäå íàðêîòè÷åñêèõ âåùåñòâ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íàðêîòèêè - ýòî âåùåñòâà, ñïîñîáíûå âûçûâàòü ñîñòîÿíèå ýéôîðèè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íàðêîìàíèÿ - çàáîëåâàíèå, âûçâàííîå óïîòðåáëåíèåì íàðêîòè÷åñêèõ âåùåñòâ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Â ñðåäå óïîòðåáëÿþùèõ íàðêîòèêè, âûøå ðèñê çàðàæåíèÿ ðàçëè÷íûìè çàáîëåâàíèÿìè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Êàæäîìó ïî ñèëàì ïîìî÷ü áîðîòüñÿ ñ íàðêîìàíèåé.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Êîëëåãè, îáðåòàéòå óâåðåííîñòü â òîì, ÷òî âàì íå íóæíû íàðêîòèêè.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íà ýòîì ëåêöèÿ îêîí÷åíà, ñïàñèáî çà âíèìàíèå.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ î {139BEC} âèðóñàõ.',
    onclick = function()
	    sampSendChat('Ñåé÷àñ ÿ ðàññêàæó âàì íåñêîëüêî ñîâåòîâ î âèðóñàõ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Âñå ìû çíàåì î âèðóñàõ è î èõ áûñòðîì ðàçìíîæåíèè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Âèðóñû îïàñíû. È ÷àùå âñåãî ïðèâîäÿò ê ëåòàëüíûì èñõîäàì.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ãîñïîäà, çàïîìíèòå íåñêîëüêî ñîâåòîâ îò Ìèíèíèñòåðñòâà Çäðàâîîõðàíåíèÿ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ïåðâîå, åñëè âû çàðàæåíû, íå êîíòàêòèðóéòå ñî çäîðîâûì.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Âòîðîå, îáû÷íûé ïîöåëóé ìîæåò çàðàçèòü âàøó âòîðóþ ïîëîâèíêó.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('È òðåòüå, ÷àùå ìîéòå ðóêè. Îñîáåííî, åñëè âàñ îêðóæàþò áîëüíûå êîëëåãè.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íà ýòîì âñå, ïîìíèòå, âðà÷è øòàòà çàáîòèòñÿ î âàøåì çäîðîâüå.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ{139BEC} ÏÌÏ.',
    onclick = function()
	sampSendChat('Çäðàñòâóéòå, óâàæàåìûå êîëëåãè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Áîëüøèíñòâî ëþäåé, îêàçàâøèñü íà ìåñòå òåðàêòà, âïàäàþò â ïàíèêó è íå çíàþò, ÷òî èì äåëàòü äî ïðèåçäà ìåäèêîâ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('À ìåæäó òåì äîðîãà áóêâàëüíî êàæäàÿ ìèíóòà, ãëàâíîå  ïîíèìàòü, êàê ïðàâèëüíî îêàçàòü ïåðâóþ ïîìîùü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Îñòàíîâèòü êðîâîòå÷åíèå, íå ïðîìûâàòü ðàíó, íå èçâëåêàòü èíîðîäíûå òåëà è ãëóáîêî äûøàòü...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...âîò îñíîâíûå äåéñòâèÿ, êîòîðûå ìîãóò ïîìî÷ü ïîñòðàäàâøèì ïðè òåðàêòå.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Äëèòåëüíîñòü ôàêòà èçîëÿöèè ÷åëîâåêà ñïåöèàëèñòû ñ÷èòàþò êëþ÷åâûì ìîìåíòîì...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...äëÿ ñîñòîÿíèÿ ïîñòðàäàâøèõ. Îïòèìàëüíî îíà íå äîëæíà ïðåâûøàòü 30 ìèíóò.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Åñëè äîëüøå  ó òÿæåëûõ ïîñòðàäàâøèõ ìîãóò ðàçâèòüñÿ îïàñíûå äëÿ æèçíè îñëîæíåíèÿ èëè ïðîñòî íàñòóïèò ñìåðòü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Èçâåñòíî, ÷òî â ñâÿçè ñ íåñâîåâðåìåííûì îêàçàíèåì ìåäèöèíñêîé ïîìîùè ïðè êàòàñòðîôàõ, èíöèäåíòàõ, ëþáûõ ïðîèñøåñòâèÿõ, ãäå åñòü ïîñòðàäàâøèå...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...â òå÷åíèå ïåðâîãî ÷àñà ïîãèáàåò äî 30% ïîñòðàäàâøèõ, ÷åðåç òðè ÷àñà  äî 70% à ÷åðåç øåñòü ÷àñîâ  äî 90%.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Ýòè öèôðû ïîêàçûâàþò: ïåðâàÿ ïîìîùü ïðè òåðàêòàõ íóæíà ÷åì ñêîðåå, òåì ëó÷øå, äî ïðèåçäà ìåäèêîâ.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Íà ìåñòå êàòàñòðîôû èëè òåðàêòà âàì íàäî ñïðàâèòüñÿ ñ òðåìÿ ïðîáëåìàìè, êîòîðûå óáèâàþò ëþäåé áûñòðåå âñåãî:')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('- âíåøíÿÿ óãðîçà;')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('- ñèëüíîå êðîâîòå÷åíèå;')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('- ïðîáëåìû ñ äûõàíèåì.')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Èõ íàäî ëèêâèäèðîâàòü â òîé æå ïðèîðèòåòíîñòè. Âàì íàäî ñôîêóñèðîâàòüñÿ ëèøü íà ýòèõ òð¸õ âåùàõ è êîëè÷åñòâî âûæèâøèõ áóäåò ìàêñèìàëüíî.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Ïåðâàÿ ïîìîùü  ýòî êîìïëåêñ ñðî÷íûõ ìåð, íàïðàâëåííûõ íà ñïàñåíèå æèçíè ÷åëîâåêà.')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Íåñ÷àñòíûé ñëó÷àé, ðåçêèé ïðèñòóï çàáîëåâàíèÿ, îòðàâëåíèå  â ýòèõ è äðóãèõ ÷ðåçâû÷àéíûõ ñèòóàöèÿõ íåîáõîäèìà ãðàìîòíàÿ ïåðâàÿ ïîìîùü...')
		wait(cfg.commands.zaderjka * 1000)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   }
}
end

do

function imgui.OnDrawFrame()
   if first_window.v then
	local tagfr = imgui.ImBuffer(u8(cfg.main.tarr), 256)
	local tagb = imgui.ImBool(cfg.main.tarb)
	local clistb = imgui.ImBool(cfg.main.clistb)
	local autoscr = imgui.ImBool(cfg.main.hud)
	local hudik = imgui.ImBool(cfg.main.givra)
	local clisto = imgui.ImBool(cfg.main.clisto)
	local stateb = imgui.ImBool(cfg.main.male)
	local waitbuffer = imgui.ImInt(cfg.commands.zaderjka)
	local clistbuffer = imgui.ImInt(cfg.main.clist)
    local iScreenWidth, iScreenHeight = getScreenResolution()
	local btn_size = imgui.ImVec2(-0.1, 0)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
    imgui.Begin(fa.ICON_COGS .. u8 ' Íàñòðîéêè##1', first_window, btn_size, imgui.WindowFlags.NoResize)
	imgui.PushItemWidth(200)
	imgui.AlignTextToFramePadding(); imgui.Text(u8("Èñïîëüçîâàòü àâòîòåã"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Èñïîëüçîâàòü àâòîòåã', tagb) then
    cfg.main.tarb = not cfg.main.tarb
    end
	if tagb.v then
	if imgui.InputText(u8'Ââåäèòå âàø òåã.', tagfr) then
    cfg.main.tarr = u8:decode(tagfr.v)
    end
	end
	imgui.Text(u8("Âêëþ÷èòü õóä"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Âêëþ÷èòü/âûêëþ÷èòü õóä', hudik) then
        cfg.main.givra = not cfg.main.givra
		ftext(cfg.main.givra and 'Õóä âêëþ÷åí, óñòàíîâèòü ïîëîæåíèå /sethud.' or 'Õóä âûêëþ÷åí.')
    end
	imgui.Text(u8("Áûñòðûé îòâåò íà ïîñëåäíåå ÑÌÑ"))
	imgui.SameLine()
    if imgui.HotKey(u8'##Áûñòðûé îòâåò ñìñ', config_keys.fastsms, tLastKeys, 100) then
	    rkeys.changeHotKey(fastsmskey, config_keys.fastsms.v)
		ftext('Êëàâèøà óñïåøíî èçìåíåíà. Ñòàðîå çíà÷åíèå: '.. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. ' | Íîâîå çíà÷åíèå: '.. table.concat(rkeys.getKeysName(config_keys.fastsms.v), " + "))
		saveData(config_keys, 'moonloader/config/medick/keys.json')
	end
	imgui.Text(u8("Èñïîëüçîâàòü àâòîêëèñò"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Èñïîëüçîâàòü àâòîêëèñò', clistb) then
        cfg.main.clistb = not cfg.main.clistb
    end
    if clistb.v then
        if imgui.SliderInt(u8"Âûáåðèòå çíà÷åíèå êëèñòà", clistbuffer, 0, 33) then
            cfg.main.clist = clistbuffer.v
        end
		imgui.Text(u8("Èñïîëüçîâàòü îòûãðîâêó ðàçäåâàëêè"))
	    imgui.SameLine()
		if imgui.ToggleButton(u8'Èñïîëüçîâàòü îòûãðîâêó ðàçäåâàëêè', clisto) then
        cfg.main.clisto = not cfg.main.clisto
        end
    end
	imgui.Text(u8("Ìóæñêèå îòûãðîâêè"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Ìóæñêèå îòûãðîâêè', stateb) then
        cfg.main.male = not cfg.main.male
    end
	
	if imgui.SliderInt(u8'Çàäåðæêà â ëåêöèÿõ è îòûãðîâêàõ(ñåê)', waitbuffer, 1, 25) then
     cfg.commands.zaderjka = waitbuffer.v
    end
	imgui.Text(u8("Àâòîñêðèí ëåêöèé/ãîñ.íîâîñòåé"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Àâòîñêðèí ëåêöèé', autoscr) then
        cfg.main.hud = not cfg.main.hud
    end
    if imgui.CustomButton(u8('Ñîõðàíèòü íàñòðîéêè'), imgui.ImVec4(0.08, 0.61, 0.92, 0.40), imgui.ImVec4(0.08, 0.61, 0.92, 1.00), imgui.ImVec4(0.08, 0.61, 0.92, 0.76), btn_size) then
	ftext('Íàñòðîéêè óñïåøíî ñîõðàíåíû.', -1)
    inicfg.save(cfg, 'medick/config.ini') -- ñîõðàíÿåì âñå íîâûå çíà÷åíèÿ â êîíôèãå
    end
    imgui.End()
   end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Medic Tools | Óñòàâ áîëüíèöû'), ystwindow)
                for line in io.lines('moonloader\\medick\\ystav.txt') do
                    imgui.TextWrapped(u8(line))
                end
                imgui.End()
            end
  if second_window.v then
    imgui.LockPlayer = true
    imgui.ShowCursor = true
    local iScreenWidth, iScreenHeight = getScreenResolution()
    local btn_size1 = imgui.ImVec2(70, 0)
	local btn_size = imgui.ImVec2(130, 0)
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 5))
    imgui.Begin('Medick Helpers | Main Menu | Version: '..thisScript().version, second_window, mainw,  imgui.WindowFlags.NoResize)
	imgui.SameLine()
	imgui.Image(test, imgui.ImVec2(890, 140))
    imgui.Separator()
	if imgui.Button(u8'Áèíäåð', imgui.ImVec2(50, 30)) then
      bMainWindow.v = not bMainWindow.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_COGS .. u8' Íàñòðîéêè ñêðèïòà', imgui.ImVec2(141, 30)) then
      first_window.v = not first_window.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_REFRESH .. u8' Ïåðåçàãðóçèòü ñêðèïò', imgui.ImVec2(155, 30)) then
      showCursor(false)
      thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_WRENCH .. u8' Èíôîðìàöèÿ î îáíîâëåíèÿõ', imgui.ImVec2(192, 30)) then
      obnova.v = not obnova.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_INFO .. u8 ' Ïîìîùü', imgui.ImVec2(70, 30)) then
      helps.v = not helps.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_LINE_CHART .. u8' Ñèñòåìà ïîâûøåíèé', imgui.ImVec2(155, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/283444/"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_BOOK .. u8' Óñòàâ', imgui.ImVec2(70, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/285201/"')
    btn_size = not btn_size
    end
	imgui.Separator()
	imgui.BeginChild("Èíôîðìàöèÿ", imgui.ImVec2(410, 150), true)
	imgui.Text(u8 'Èìÿ è Ôàìèëèÿ:   '..sampGetPlayerNickname(myid):gsub('_', ' ')..'')
	imgui.Text(u8 'Äîëæíîñòü:') imgui.SameLine() imgui.Text(u8(rank))
	imgui.Text(u8 'Íîìåð òåëåôîíà:   '..tel..'')
	if cfg.main.tarb then
	imgui.Text(u8 'Òåã â ðàöèþ:') imgui.SameLine() imgui.Text(u8(cfg.main.tarr))
	end
	if cfg.main.clistb then
	imgui.Text(u8 'Íîìåð áåéäæèêà:   '..cfg.main.clist..'')
	end
	imgui.EndChild()
	imgui.Separator()
		--for i, value in ipairs(themes.colorThemes) do
		--	if imgui.RadioButton(value, checked_radio, i) then
		--		themes.SwitchColorTheme(i)
		--	end
		--end
	imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Òåêóùàÿ äàòà: %s")).x)/1.5)
	imgui.Text(u8(string.format("Òåêóùàÿ äàòà: %s", os.date())))
	
    imgui.End()
  end
  	if infbar.v then
            _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
            local myname = sampGetPlayerNickname(myid)
            local myping = sampGetPlayerPing(myid)
            local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
            imgui.SetNextWindowPos(imgui.ImVec2(cfg.main.posX, cfg.main.posY), imgui.ImVec2(0.5, 0.5))
            imgui.SetNextWindowSize(imgui.ImVec2(cfg.main.widehud, 175), imgui.Cond.FirstUseEver)
            imgui.Begin('Medic Helper', infbar, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
            imgui.CentrText('Medic Helper')
            imgui.Separator()
            imgui.Text((u8"Èíôîðìàöèÿ: %s [%s] | Ïèíã: %s"):format(myname, myid, myping))
			    imgui.Text((u8 'Âðåìÿ: %s'):format(os.date('%H:%M:%S')))
            if valid and doesCharExist(ped) then 
                local result, id = sampGetPlayerIdByCharHandle(ped)
                if result then
                    local targetname = sampGetPlayerNickname(id)
                    local targetscore = sampGetPlayerScore(id)
                    imgui.Text((u8 'Öåëü: %s [%s] | Óðîâåíü: %s'):format(targetname, id, targetscore))
                else
                    imgui.Text(u8 'Öåëü: Íåò')
                end
            else
                imgui.Text(u8 'Öåëü: Íåò')
            end
			local cx, cy, cz = getCharCoordinates(PLAYER_PED)
			local zcode = getNameOfZone(cx, cy, cz)
			imgui.Text((u8 'Ëîêàöèÿ: %s | Êâàäðàò: %s'):format(u8(getZones(zcode)), u8(kvadrat())))
			imgui.Text((u8 'Âûëå÷åíî: %s | Âûëå÷åíî îò íàðêî: %s'):format((health), u8(narkoh)))
            inicfg.save(cfg, 'medick/config.ini')
            imgui.End()
        end
    if obnova.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                 imgui.Begin(fa.ICON_WRENCH .. u8'Îáíîâëåíèÿ.', obnova, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Îáíîâëåíèÿ.", imgui.ImVec2(540, 250), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '×òî áûëî ñäåëàíî:')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.2')
				imgui.BulletText(u8 '1.Êîìàíäà /z - Äëÿ ëå÷åíèÿ â àâòîìîáèëå.')
				imgui.BulletText(u8 '2.Ïîëíîñòüþ ïåðåïèñàíà Ìåíþøêà Ïêì+Z.')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.3')
				imgui.BulletText(u8 '1.Óäàëåíî ïðîêòè÷åñêè âñå ÷òî ñâÿçíàíî ñ Medick Helper.')
                imgui.BulletText(u8 '2.Ïåðåðàáîòàíû çàäåðæêè âñåõ îòûãðîâîê.')
				imgui.BulletText(u8 '3.Óñòðàíåíû ìåëêèå áàãè è ïðîáëåìû ñ òåêñòîì.')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.4')
				imgui.BulletText(u8 '1.Èçìåíåí öâåò èíòåðôåéñà')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.5')
				imgui.BulletText(u8 '1.Òåïåðü ãë.ìåíþ îòêðûâàåòñÿ íà /mh')
				imgui.BulletText(u8 '2.Äîáàâëåíî â ìåíþ Ïêì+Z ìåíþ ñîáåñåäîâàíèÿ')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.7')
				imgui.BulletText(u8 '1.Ïåðåðàáîòàí ïîëíîñòüþ /sethud')
				imgui.Separator()
				imgui.BulletText(u8 'v3.0')
				imgui.BulletText(u8 '1.Òåïåðü óáðàíî ÂÑÅ ÷òî îñòîâàëîñü îò Instructors helper.')
				imgui.BulletText(u8 '2.Â ìåíþ Ïêì+Z äîáàâëåíà ïðîâåðêà íà âèðóñ.')
				imgui.BulletText(u8 '3.Äîáàâëåíû íîâûå ëåêöèè è Gov.')
				imgui.Separator()
				imgui.BulletText(u8 'v3.2')
				imgui.BulletText(u8 '1.Âîçâðàùåíà íàñòðîéêà çàäåðæêè â Íàñòðîéêàõ ñêðèïòà.')
				imgui.BulletText(u8 '2.Äîáàâëåíû íîâûå ëåêöèè è ìåòîäû ëå÷åíèÿ.')
				imgui.BulletText(u8 '3.Äîðàáîòàíû çàäåðæêè.')
                imgui.Separator()
				imgui.BulletText(u8 'v3.8')
				imgui.BulletText(u8 '1.Äîáàâëåíû ëîãè "/smslog" è "/rlog".')
				imgui.BulletText(u8 '2.Ïîëíîñòüþ èçìåíåí èíòåðôåéñ.')
				imgui.BulletText(u8 '3.Äîáàâëåíû íîâûå ëåêöèè, ìåëêèå èçìåíåíèÿ ïî òåêñòó.')
				imgui.BulletText(u8 '4.Äîáàâëåíà êàñòîìèçàöèÿ èíòåðôåéñà.')
				imgui.BulletText(u8 '5.Íåìíîãî èçìåíåí Õóä.')
				imgui.Separator()
				imgui.BulletText(u8 'v3.8.1')
				imgui.BulletText(u8 '1.Ñäåëàë reboot ñêðèïòà íà âåðñèþ v3.7" ')
				imgui.BulletText(u8 '2.Âåðíóë èíòåðôåéñ, óáðàë êàñòîìèçàöèþ.')
				imgui.BulletText(u8 '3.Äîáàâëåíû íîâûå ëåêöèè, èçìåíåíû îòäåëû.')
				imgui.BulletText(u8 '4.Èñïðàâëåí "/smslog".')
				imgui.BulletText(u8 '5.Èñïðàâëåí áèíäåð.')
				imgui.BulletText(u8 '5.Èçìåíåí èíòåðôåéñ.')
				imgui.Separator()
				imgui.BulletText(u8 'Ñâÿçü è ïðåäëîæåíèÿ:')
				imgui.BulletText(u8('ÂÊ (êëèêàáåëüíî).'))
				if imgui.IsItemClicked() then
				os.execute('explorer https://vk.com/artyom.fomin2016')
				end
                imgui.BulletText(u8'Discord(Baerra#0419)')
				imgui.EndChild()
                imgui.End()
    end
	if helps.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                imgui.Begin(fa.ICON_INFO .. u8 'Ïîìîùü ïî ñêðèïòó.', helps, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Ñïèñîê êîìàíä", imgui.ImVec2(495, 230), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '/mh - Îòêðûòü ìåíþ ñêðèïòà.')
                imgui.Separator()
				imgui.BulletText(u8 '/z [id] - Âûëå÷èòü ïàöèåíòà â àâòî.')
				imgui.BulletText(u8 '/vig [id] [Ïðè÷èíà] - Âûäàòü âûãîâîð ïî ðàöèè.')
				imgui.BulletText(u8 '/unvig [id] [Ïðè÷èíà] - Ñíÿòü âûãîâîð ïî ðàöèè.')
                imgui.BulletText(u8 '/dmb - Îòêðûòü /members â äèàëîãå.')
				imgui.BulletText(u8 '/oinv[id] - Ïðèíÿòü ÷åëîâåêà â îòäåë.')
				imgui.BulletText(u8 '/zinv[id] - Íàçíà÷èòü ÷åëîâåêà Çàìåñòèòåëåì îòäåëà.')
				imgui.BulletText(u8 '/ginv[id] - Íàçíà÷èòü ÷åëîâåêà Ãëàâîé îòäåëà.')
                imgui.BulletText(u8 '/where [id] - Çàïðîñèòü ìåñòîïîëîæåíèå ïî ðàöèè.')
                imgui.BulletText(u8 '/ystav - Îòêðûòü óñòàâ áîëüíèöû.')
				imgui.BulletText(u8 '/smsjob - Âûçâàòü íà ðàáîòó âåñü ìë.ñîñòàâ ïî ñìñ.')
                imgui.BulletText(u8 '/dlog - Îòêðûòü ëîã 25 ïîñëåäíèõ ñîîáùåíèé â äåïàðòàìåíò.')
				imgui.BulletText(u8 '/sethud - Óñòàíîâèòü ïîçèöèþ èíôî-áàðà.')
				imgui.Separator()
                imgui.BulletText(u8 'Êëàâèøè: ')
                imgui.BulletText(u8 'ÏÊÌ+Z íà èãðîêà - Ìåíþ âçàèìîäåéñòâèÿ.')
                imgui.BulletText(u8 'F2 - "Áûñòðîå ìåíþ."')
				imgui.EndChild()
                imgui.End()
    end
	
    if updwindows.v then
                local updlist = ttt
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(700, 330), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Medic Tools | Îáíîâëåíèå'), updwindows, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
                imgui.Text(u8('Âûøëî îáíîâëåíèå ñêðèïòà Medic Tools äî âåðñèè '..updversion..'. ×òî áû îáíîâèòüñÿ íàæìèòå êíîïêó âíèçó.'))
                imgui.Separator()
                imgui.BeginChild("uuupdate", imgui.ImVec2(690, 200))
                for line in ttt:gmatch('[^\r\n]+') do
                    imgui.Text(line)
                end
                imgui.EndChild()
                imgui.Separator()
                imgui.PushItemWidth(305)
                if imgui.Button(u8("Îáíîâèòü"), imgui.ImVec2(339, 25)) then
                    lua_thread.create(goupdate)
                    updwindows.v = false
                end
                imgui.SameLine()
                if imgui.Button(u8("Îòëîæèòü îáíîâëåíèå"), imgui.ImVec2(339, 25)) then
                    updwindows.v = false
                end
                imgui.End()
            end
	
  if bMainWindow.v then
  local iScreenWidth, iScreenHeight = getScreenResolution()
	local tLastKeys = {}
   
   imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.SetNextWindowSize(imgui.ImVec2(800, 530), imgui.Cond.FirstUseEver)

   imgui.Begin(u8("IT | Áèíäåð##main"), bMainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
	imgui.BeginChild("##bindlist", imgui.ImVec2(795, 442))
	for k, v in ipairs(tBindList) do
		if hk.HotKey("##HK" .. k, v, tLastKeys, 100) then
			if not rkeys.isHotKeyDefined(v.v) then
				if rkeys.isHotKeyDefined(tLastKeys.v) then
					rkeys.unRegisterHotKey(tLastKeys.v)
				end
				rkeys.registerHotKey(v.v, true, onHotKey)
			end
		end
		imgui.SameLine()
		if tEditData.id ~= k then
			local sText = v.text:gsub("%[enter%]$", "")
			imgui.BeginChild("##cliclzone" .. k, imgui.ImVec2(500, 21))
			imgui.AlignTextToFramePadding()
			if sText:len() > 0 then
				imgui.Text(u8(sText))
			else
				imgui.TextDisabled(u8("Ïóñòîå ñîîáùåíèå ..."))
			end
			imgui.EndChild()
			if imgui.IsItemClicked() then
				sInputEdit.v = sText:len() > 0 and u8(sText) or ""
				bIsEnterEdit.v = string.match(v.text, "(.)%[enter%]$") ~= nil
				tEditData.id = k
				tEditData.inputActve = true
			end
		else
			imgui.PushAllowKeyboardFocus(false)
			imgui.PushItemWidth(500)
			local save = imgui.InputText("##Edit" .. k, sInputEdit, imgui.InputTextFlags.EnterReturnsTrue)
			imgui.PopItemWidth()
			imgui.PopAllowKeyboardFocus()
			imgui.SameLine()
			imgui.Checkbox(u8("Ââîä") .. "##editCH" .. k, bIsEnterEdit)
			if save then
				tBindList[tEditData.id].text = u8:decode(sInputEdit.v) .. (bIsEnterEdit.v and "[enter]" or "")
				tEditData.id = -1
			end
			if tEditData.inputActve then
				tEditData.inputActve = false
				imgui.SetKeyboardFocusHere(-1)
			end
		end
	end
	imgui.EndChild()

	imgui.Separator()

	if imgui.Button(u8"Äîáàâèòü êëàâèøó") then
		tBindList[#tBindList + 1] = {text = "", v = {}}
	end

   imgui.End()
  end
  end
end

function onHotKey(id, keys)
	local sKeys = tostring(table.concat(keys, " "))
	for k, v in pairs(tBindList) do
		if sKeys == tostring(table.concat(v.v, " ")) then
			if tostring(v.text):len() > 0 then
				local bIsEnter = string.match(v.text, "(.)%[enter%]$") ~= nil
				if bIsEnter then
					sampProcessChatInput(v.text:gsub("%[enter%]$", ""))
				else
					sampSetChatInputText(v.text)
					sampSetChatInputEnabled(true)
				end
			end
		end
	end
end

function showHelp(param) -- "âîïðîñèê" äëÿ ñêðèïòà
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(imgui.GetFontSize() * 35.0)
        imgui.TextUnformatted(param)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function onScriptTerminate(scr)
	if scr == script.this then
		if doesFileExist(fileb) then
			os.remove(fileb)
		end
		local f = io.open(fileb, "w")
		if f then
			f:write(encodeJson(tBindList))
			f:close()
		end
		local fa = io.open("moonloader/config/medick/keys.json", "w")
        if fa then
            fa:write(encodeJson(config_keys))
            fa:close()
        end
	end
end

addEventHandler("onWindowMessage", function (msg, wparam, lparam)
	if msg == wm.WM_KEYDOWN or msg == wm.WM_SYSKEYDOWN then
		if tEditData.id > -1 then
			if wparam == key.VK_ESCAPE then
				tEditData.id = -1
				consumeWindowMessage(true, true)
			elseif wparam == key.VK_TAB then
				bIsEnterEdit.v = not bIsEnterEdit.v
				consumeWindowMessage(true, true)
			end
		end
	end
end)

function submenus_show(menu, caption, select_button, close_button, back_button)
    select_button, close_button, back_button = select_button or '»', close_button or 'x', back_button or '«'
    prev_menus = {}
    function display(menu, id, caption)
        local string_list = {}
        for i, v in ipairs(menu) do
            table.insert(string_list, type(v.submenu) == 'table' and v.title .. ' »' or v.title)
        end
        sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_LIST)
        repeat
            wait(0)
            local result, button, list = sampHasDialogRespond(id)
            if result then
                if button == 1 and list ~= -1 then
                    local item = menu[list + 1]
                    if type(item.submenu) == 'table' then -- submenu
                        table.insert(prev_menus, {menu = menu, caption = caption})
                        if type(item.onclick) == 'function' then
                            item.onclick(menu, list + 1, item.submenu)
                        end
                        return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
                    elseif type(item.onclick) == 'function' then
                        local result = item.onclick(menu, list + 1)
                        if not result then return result end
                        return display(menu, id, caption)
                    end
                else -- if button == 0
                    if #prev_menus > 0 then
                        local prev_menu = prev_menus[#prev_menus]
                        prev_menus[#prev_menus] = nil
                        return display(prev_menu.menu, id - 1, prev_menu.caption)
                    end
                    return false
                end
            end
        until result
    end
    return display(menu, 31337, caption or menu.title)
end

function r(pam)
    if #pam ~= 0 then
        if cfg.main.tarb then
            sampSendChat(string.format('/r [%s]: %s', cfg.main.tarr, pam))
        else
            sampSendChat(string.format('/r %s', pam))
        end
    else
        ftext('Ââåäèòå /r [òåêñò].')
    end
end
function ftext(message)
    sampAddChatMessage(string.format('%s %s', ctag, message), 0x139BEC)
end

function mh()
  second_window.v = not second_window.v
end

function tloadtk()
    if tload == true then
     sampSendChat('/tload'..u8(cfg.main.norma))
    else if tload == false then
     sampSendChat("/tunload")
    end
  end
end
function imgui.CentrText(text)
            local width = imgui.GetWindowWidth()
            local calc = imgui.CalcTextSize(text)
            imgui.SetCursorPosX( width / 2 - calc.x / 2 )
            imgui.Text(text)
        end
        function imgui.CustomButton(name, color, colorHovered, colorActive, size)
            local clr = imgui.Col
            imgui.PushStyleColor(clr.Button, color)
            imgui.PushStyleColor(clr.ButtonHovered, colorHovered)
            imgui.PushStyleColor(clr.ButtonActive, colorActive)
            if not size then size = imgui.ImVec2(0, 0) end
            local result = imgui.Button(name, size)
            imgui.PopStyleColor(3)
            return result
        end

function pkmmenu(id)
    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
    return
    {
      {
        title = "{80a4bf}»{ffffff} Ìåíþ âðà÷à.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{80a4bf}» {ffffff}Âûëå÷èòü",
        onclick = function()
        pID = tonumber(args)
        submenus_show(oformenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{80a4bf}» {ffffff}Ïðèçûâ ìåíþ.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(priziv(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{80a4bf}» {ffffff}Âûäà÷à ñïðàâêè â ÏÄ",
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
	    sampSendChat("/me äîñòàåò ÷èñòûé áëàíê")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me äîñòà¸ò ðó÷êó èç íàãðóäíîãî êàðìàíà")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("Ñòðàäàåòå ëè âû êàêèìè-ëèáî çàáîëåâàíèÿìè?")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me ñäåëàëà ïîìåòêó â áëàíêå")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me ïîñòàâèëà ïå÷àòü Ãîäåí")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/do Ìåä.êàðòà â ðóêàõ")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me ïåðåäàëà ìåä.êàðòó")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
	    sampSendChat("/me äîñòàåò ÷èñòûé áëàíê")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me äîñòà¸ò ðó÷êó èç íàãðóäíîãî êàðìàíà")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("Ñòðàäàåòå ëè âû êàêèìè-ëèáî çàáîëåâàíèÿìè?")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me ñäåëàë ïîìåòêó â áëàíêå")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me ïîñòàâèë ïå÷àòü Ãîäåí")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/do Ìåä.êàðòà â ðóêàõ")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me ïåðåäàë ìåä.êàðòó")
		end
		end
      },
	  {
        title = "{ffffff}» Ìåíþ ðåíòãåíà, ïîðåçîâ, ïåðåëîìîâ.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(renmenu(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Ìåäèöèíñêèé îñìîòð.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(medosmotr(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Ïåðâàÿ ìåä.ïîìîùü.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(medpomosh(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Ðàçäåë îïåðàöèé",
        onclick = function()
        pID = tonumber(args)
        submenus_show(operacia(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	}
end
function ustav(id)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë óñòàâà. »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Ñêîëüêî ìèíóò äàåòñÿ ñîòðóäíèêó, ÷òîáû ïðèáûòü íà ðàáîòó è ïåðåîäåòüñÿ â ðàáî÷óþ ôîðìó?',
        onclick = function()
        sampSendChat("Ñêîëüêî ìèíóò äàåòñÿ ñîòðóäíèêó, ÷òîáû ïðèáûòü íà ðàáîòó è ïåðåîäåòüñÿ â ðàáî÷óþ ôîðìó?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}15 ìèíóò.", -1)
		end
      },
      {
        title = '{80a4bf}» {ffffff}Ñ êàêîé äîëæíîñòè ðàçðåøåíî èñïîëüçîâàòü âîëíó äåïàðòàìåíòà â êà÷åñòâå ïåðåãîâîðîâ?',
        onclick = function()
        sampSendChat("Ñ êàêîé äîëæíîñòè ðàçðåøåíî èñïîëüçîâàòü âîëíó äåïàðòàìåíòà â êà÷åñòâå ïåðåãîâîðîâ?")
		wait(500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Ñ äîëæíîñòè Ìåä.Áðàòà.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ñ êàêîé äîëæíîñòè ðàçðåøåíî âûåçæàòü â íàçåìíûé ïàòðóëü øòàòà?',
        onclick = function()
        sampSendChat(" Ñ êàêîé äîëæíîñòè ðàçðåøåíî âûåçæàòü â íàçåìíûé ïàòðóëü øòàòà?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Ñ äîëæíîñòè Ìåä.Áðàòà.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ñ êàêîé äîëæíîñòè ðàçðåøåíî èñïîëüçîâàòü âîçäóøíî-òðàíñïîðòíîå ñðåäñòâî?',
        onclick = function()
        sampSendChat("Ñ êàêîé äîëæíîñòè ðàçðåøåíî èñïîëüçîâàòü âîçäóøíî-òðàíñïîðòíîå ñðåäñòâî?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Ñ äîëæíîñòè Ïñèõîëîãà, ïî ðàçðåøåíèþ {ff0000}ðóê-âà ñ Äîêòîðà.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå çàâåäåíèÿ çàïðåùåíî ïîñåùàòü âî âðåìÿ ðàáî÷åãî äíÿ?',
        onclick = function()
        sampSendChat("Êàêèå çàâåäåíèÿ çàïðåùåíî ïîñåùàòü âî âðåìÿ ðàáî÷åãî äíÿ?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Àâòîáàçàð, Êàçèíî.", -1)
		end
      },
	  {
        title = '{5b83c2}« Ðàçäåë âîïðîñîâ ïî ìåäèêàìåíòàì. »',
        onclick = function()
        end
	  },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò áîëè â æèâîòå?',
        onclick = function()
        sampSendChat("Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò áîëè â æèâîòå?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Íî-øïà, Äðîòàâåðèí, Êåòîðîëàê, Ñïàçìàëãîí, Êåòàíîâ.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå ïðè áîëè â ãîëîâå?',
        onclick = function()
        sampSendChat("Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå ïðè áîëè â ãîëîâå?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Àñïèðèí, Àíàëüãèí, Öèòðàìîí, Äèêëîôåíàê, Ïåíòàëãèí.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò áîëè â ãîðëå?',
        onclick = function()
        sampSendChat("Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò áîëè â ãîðëå?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Ãåêñàëèç, Ôàëèìèíò, Ñòðåïñèëñ.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò òåìïåðàòóðû?',
        onclick = function()
        sampSendChat("Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò òåìïåðàòóðû?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Ïàðàöåòàìîë, Íóðîôåí, Èáóêëèí, Ðèíçà.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå ïðè êàøëå?',
        onclick = function()
        sampSendChat("Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå ïðè êàøëå?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Àìáðîáåíå, Àìáðîãåêñàë, ÀÖÖ, Áðîìãåêñèí, Äîêòîð ÌÎÌ.", -1)
		end
      },
    }
end
function saveData(table, path)
	if doesFileExist(path) then os.remove(path) end
    local sfa = io.open(path, "w")
    if sfa then
        sfa:write(encodeJson(table))
        sfa:close()
    end
end
function ystf()
    if not doesFileExist('moonloader/medick/ystav.txt') then
        local file = io.open("moonloader/medick/ystav.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end
function instmenu(id)
    return
    {
      {
        title = '{80a4bf}» {ffffff}Ïðèâåòñòâèå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Çäðàâñòâóéòå. ß ñîòðóäíèê áîëüíèöû "..myname:gsub('_', ' ')..", ÷åì ìîãó ïîìî÷ü?")
        wait(1000)
		sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ '..rank..' | '..myname:gsub('_', ' ')..'.')
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïîïðîùàòüñÿ ñ êëèåíòîì.',
        onclick = function()
        sampSendChat("Âñåãî âàì äîáðîãî.")
        end
      }
    }
end
function ystf()
    if not doesFileExist('moonloader/medick/ystav.txt') then
        local file = io.open("moonloader/medick/ystav.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end
function oformenu(id)
    return
    {
      {
        title = '{80a4bf}» {ffffff}Ãîëîâà',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
		  sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
          wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me äîñòàëà èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
          wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Ïàðàöåòàìîë â ðóêå")
          wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me ïåðåäàëà ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
          wait(1000)
		  sampSendChat("/heal "..id) 
        end
        if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
		  sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
          wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
          wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Ïàðàöåòàìîë â ðóêå")
          wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
          wait(1000)
		  sampSendChat("/heal "..id) 
        end
		end
      },
      {
        title = '{80a4bf}» {ffffff}Æèâîò',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
		  sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me äîñòàëà èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Íîø-ïà â ðóêå")
	      wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me ïåðåäàëà ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	      wait(1000)
		  sampSendChat("/heal "..id) 
        end
        if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
		  sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Íîø-ïà â ðóêå")
	      wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	      wait(1000)
		  sampSendChat("/heal "..id) 
        end
		end
      },
      {
        title = '{80a4bf}» {ffffff}Ãîðëî',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
		  sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me äîñòàëà èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Ñòîïàíãèí â ðóêå")
	      wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me ïåðåäàëà ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	      wait(1000)
		  sampSendChat("/heal "..id) 
		end
        if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
		  sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Ñòîïàíãèí â ðóêå")
	      wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1000)
		  sampSendChat("/heal "..id) 
        end
        end
		},
	    {
        title = '{80a4bf}» {ffffff}Ëå÷åíèå îò íàðêîçàâèñèìîñòè.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
		sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç ìåä.ñóìêè øïðèö.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/do Øïðèö â ëåâîé ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/me îáðàáîòàëà âàòîé ìåñòî óêîëà íà âåíå '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/me àêêóðàòíûì äâèæåíèåì ââîäèò ïðåïàðàò â âåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/todo Íó âîò è âñ¸*âûòàùèâ øïðèö èç âåíû è ïðèëîæèâ âàòó ê ìåñòó óêîëà.")
        wait(1000)
        sampSendChat("/healaddict " .. id .. "  10000")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
		sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè øïðèö.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/do Øïðèö â ëåâîé ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/me àêêóðàòíûì äâèæåíèåì ââîäèò ïðåïàðàò â âåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/todo Íó âîò è âñ¸*âûòàùèâ øïðèö èç âåíû è ïðèëîæèâ âàòó ê ìåñòó óêîëà.")
        wait(1000)
        sampSendChat("/healaddict " .. id .. "  10000")
		end
		end
      }
    }
end
function medpomosh(args)
    return
    {
      {
        title = '{5b83c2}« Ïðè çàêðûòûõ/îòêðûòûõ ïåðåëîìàõ: »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Ïðè çàêðûòîì ïåðåëîìå ðóêè/íîãè: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Äëÿ íà÷àëà âû äîëæíû ââåñòè àíàëüãåòèê ÷åðåç øïðèö â âåíó ïîñòðàäàâøåãî.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèëà ìåäèöèíñêèé êåéñ íà ïîë è îòêðûëà åãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Â êåéñå ëåæàò: ñòåðèëüíûå øïðèöû, àìïóëà ñ àíàëüãåòèêîì, øèíà, áèíòû")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà ñòåðèëüíûé øïðèö ñ àìïóëîé, àêêóðàòíî ïðèîòêðûëà àìïóëó ñ àíàëüãåòèêîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïåðåëèëà ñîäåðæèìîå àìïóëû â øïðèö")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàêàòàëà ðóêàâ ïîñòðàäàâøåãî, ïîñëå ÷åãî ââ¸ëà àíàëüãåòèê ÷åðåç øïðèö â âåíó, âäàâèâ ïîðøåíü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Àíàëüãåòèê ïðîíèê â îðãàíèçì ïîñòðàäàâøåãî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàëà èñïîëüçîâàííûé øïðèö â ìåäèöèíñêóþ ñóìêó")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèë ìåäèöèíñêèé êåéñ íà ïîë è îòêðûë åãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Â êåéñå ëåæàò: ñòåðèëüíûå øïðèöû, àìïóëà ñ àíàëüãåòèêîì, øèíà, áèíòû")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë ñòåðèëüíûé øïðèö ñ àìïóëîé, àêêóðàòíî ïðèîòêðûë àìïóëó ñ àíàëüãåòèêîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïåðåëèë ñîäåðæèìîå àìïóëû â øïðèö")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàêàòàë ðóêàâ ïîñòðàäàâøåãî, ïîñëå ÷åãî ââ¸ë àíàëüãåòèê ÷åðåç øïðèö â âåíó, âäàâèâ ïîðøåíü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Àíàëüãåòèê ïðîíèê â îðãàíèçì ïîñòðàäàâøåãî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàë èñïîëüçîâàííûé øïðèö â ìåäèöèíñêóþ ñóìêó")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Ñëåäóåò áûñòðî íàëîæèòü øèíó.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàëà èç êåéñà øèíó, çàòåì ïðèíÿëàñü íàêëàäûâàòü å¸ íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me àêêóðàòíî íàëîæèëà øèíó íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Øèíà êà÷åñòâåííî íàëîæåíà íà ïîâðåæä¸ííóþ êîíå÷íîñòü.")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàë èç êåéñà øèíó, çàòåì ïðèíÿëcz íàêëàäûâàòü å¸ íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me àêêóðàòíî íàëîæèë øèíó íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Øèíà êà÷åñòâåííî íàëîæåíà íà ïîâðåæä¸ííóþ êîíå÷íîñòü.")
		end
		end
      },
	  {
        title = '{ffffff}» 3) Íóæíî ñðî÷íî èììîáèëèçèðîâàòü ïîâðåæä¸ííóþ êîíå÷íîñòü ñ ïîìîùüþ êîñûíêè.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me âçÿëà èç êåéñà ñòåðèëüíûå áèíòû è ñäåëàëà êîñûíêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîäâåñèëà ïîâðåæä¸ííóþ êîíå÷íîñòü â ñîãíóòîì ïîëîæåíèè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîâðåæä¸ííàÿ êîíå÷íîñòü èììîáèëèçîâàíà. ")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me âçÿë èç êåéñà ñòåðèëüíûå áèíòû è ñäåëàë êîñûíêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîäâåñèë ïîâðåæä¸ííóþ êîíå÷íîñòü â ñîãíóòîì ïîëîæåíèè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîâðåæä¸ííàÿ êîíå÷íîñòü èììîáèëèçîâàíà. ")
		end
		end
      },
	  {
        title = '{5b83c2}« Ïðè îòêðûòîì ïåðåëîìå ðóêè/íîãè: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Äëÿ íà÷àëà âû äîëæíû ââåñòè àíàëüãåòèê ÷åðåç øïðèö â âåíó ïîñòðàäàâøåãî.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèëà ìåäèöèíñêèé êåéñ íà ïîë è îòêðûëà åãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Â êåéñå ëåæàò: ñòåðèëüíûå øïðèöû, àìïóëà ñ àíàëüãåòèêîì, øèíà, áèíòû, àíòèñåïòèê è æãóò.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà ñòåðèëüíûé øïðèö ñ àìïóëîé, àêêóðàòíî ïðèîòêðûëà àìïóëó ñ àíàëüãåòèêîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïåðåëèëà ñîäåðæèìîå àìïóëû â øïðèö")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàêàòàëà ðóêàâ ïîñòðàäàâøåãî, ïîñëå ÷åãî ââ¸ëà àíàëüãåòèê ÷åðåç øïðèö â âåíó, âäàâèâ ïîðøåíü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Àíàëüãåòèê ïðîíèê â îðãàíèçì ïîñòðàäàâøåãî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàëà èñïîëüçîâàííûé øïðèö â ìåäèöèíñêóþ ñóìêó")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèë ìåäèöèíñêèé êåéñ íà ïîë è îòêðûë åãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Â êåéñå ëåæàò: ñòåðèëüíûå øïðèöû, àìïóëà ñ àíàëüãåòèêîì, øèíà, áèíòû, àíòèñåïòèê è æãóò.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë ñòåðèëüíûé øïðèö ñ àìïóëîé, àêêóðàòíî ïðèîòêðûë àìïóëó ñ àíàëüãåòèêîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïåðåëèë ñîäåðæèìîå àìïóëû â øïðèö")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàêàòàë ðóêàâ ïîñòðàäàâøåãî, ïîñëå ÷åãî ââ¸ë àíàëüãåòèê ÷åðåç øïðèö â âåíó, âäàâèâ ïîðøåíü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Àíàëüãåòèê ïðîíèê â îðãàíèçì ïîñòðàäàâøåãî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàë èñïîëüçîâàííûé øïðèö â ìåäèöèíñêóþ ñóìêó")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Ñëåäóåò áûñòðî íàëîæèòü æãóò, îáðàáîòàòü ðàíó àíòèñåïòèêîì, íàëîæèòü øèíó.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàëà èç êåéñà êðîâîîñòàíàâëèâàþùèé æãóò, çàòåì íà÷àëà íàêëàäûâàòü åãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàëîæèëà æãóò ïîâåðõ ðàíû íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç êåéñà ñïðåé ñ àíòèñåïòè÷åñêèì ñðåäñòâîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàëà ðàíó àíòèñåïòè÷åñêèì ñðåäñòâîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàëà ñïðåé â êåéñ, äîñòàëà øèíó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me àêêóðàòíî íàëîæèëà øèíó íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Øèíà êà÷åñòâåííî íàëîæåíà íà ïîâðåæä¸ííóþ êîíå÷íîñòü.")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàë èç êåéñà êðîâîîñòàíàâëèâàþùèé æãóò, çàòåì íà÷àë íàêëàäûâàòü åãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàëîæèë æãóò ïîâåðõ ðàíû íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç êåéñà ñïðåé ñ àíòèñåïòè÷åñêèì ñðåäñòâîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàë ðàíó àíòèñåïòè÷åñêèì ñðåäñòâîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàë ñïðåé â êåéñ, äîñòàë øèíó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me àêêóðàòíî íàëîæèë øèíó íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Øèíà êà÷åñòâåííî íàëîæåíà íà ïîâðåæä¸ííóþ êîíå÷íîñòü.")
		end
		end
      },
	  {
        title = '{ffffff}» 3) Ñëåäóåò èììîáèëèçèðîâàòü ïîâðåæä¸ííóþ êîíå÷íîñòü ñ ïîìîùüþ êîñûíêè.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me âçÿëà èç êåéñà ñòåðèëüíûå áèíòû è íà÷àëà äåëàòü êîñûíêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñäåëàëà êîñûíêó èç ñòåðèëüíîãî áèíòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîäâåñèëà ïîâðåæä¸ííóþ êîíå÷íîñòü â ñîãíóòîì ïîëîæåíèè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîâðåæä¸ííàÿ êîíå÷íîñòü èììîáèëèçîâàíà.")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me âçÿë èç êåéñà ñòåðèëüíûå áèíòû è íà÷àë äåëàòü êîñûíêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñäåëàë êîñûíêó èç ñòåðèëüíîãî áèíòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîäâåñèë ïîâðåæä¸ííóþ êîíå÷íîñòü â ñîãíóòîì ïîëîæåíèè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîâðåæä¸ííàÿ êîíå÷íîñòü èììîáèëèçîâàíà.")
		end
		end
      },
	  {
        title = '{5b83c2}« Ïðè óøèáàõ/ðàñòÿæåíèÿõ: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Äëÿ íà÷àëà íóæíî îáðàáîòàòü ìåñòî óøèáà îõëàæäàþùèì ñïðååì.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç êåéñà ñïðåé 'Ôðîñò' è îáðàáîòàëà óøèá ñïðååì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ìåñòî óøèáà îáðàáîòàíî îõëàæäàþùèì ñïðååì.")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç êåéñà ñïðåé 'Ôðîñò' è îáðàáîòàë óøèá ñïðååì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ìåñòî óøèáà îáðàáîòàíî îõëàæäàþùèì ñïðååì.")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Äàëåå íóæíî íàëîæèòü íà ïîâðåæä¸ííóþ êîíå÷íîñòü ýëàñòè÷íûé áèíò.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me îòêðûëà êåéñ è äîñòàëà èç íå¸ ýëàñòè÷íûé áèíò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàëà ñïðåé â êåéñ è íàëîæèëà íà êîíå÷íîñòü ïîñòðàäàâøåãî ýëàñòè÷íûõ áèíò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me êðåïêî çàòÿíóëà ýëàñòè÷íûé áèíò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ýëàñòè÷íûé áèíò ïëîòíî ñèäèò íà êîíå÷íîñòè ïàöèåíòà.")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me îòêðûë êåéñ è äîñòàë èç íå¸ ýëàñòè÷íûé áèíò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàë ñïðåé â êåéñ è íàëîæèë íà êîíå÷íîñòü ïîñòðàäàâøåãî ýëàñòè÷íûõ áèíò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me êðåïêî çàòÿíóë ýëàñòè÷íûé áèíò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ýëàñòè÷íûé áèíò ïëîòíî ñèäèò íà êîíå÷íîñòè ïàöèåíòà.")
		end
		end
      },
	  {
        title = '{5b83c2}« Ïðè íîæåâûõ/îãíåñòðåëüíûõ ðàíåíèÿõ: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Äëÿ íà÷àëà íóæíî îáðàáîòàòü ðàíó õëîðãåñèäèíîì èëè ëþáûì àíàëîãîì.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me îñìîòðåëà ðàíó è îïîçíàëà õàðàêòåð ïîâðåæäåíèÿ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Êîëîòàÿ ðàíà.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç íåãî ðàñòâîð õëîðãåêñèäèíà è îáðàáîòàëà ðàíó ïîñòðàäàâøåãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàëà â ñóìêó ðàñòâîð õëîðãåêñèäèíà")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me îñìîòðåë ðàíó è îïîçíàë õàðàêòåð ïîâðåæäåíèÿ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Êîëîòàÿ ðàíà.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç íåãî ðàñòâîð õëîðãåêñèäèíà è îáðàáîòàë ðàíó ïîñòðàäàâøåãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàë â ñóìêó ðàñòâîð õëîðãåêñèäèíà")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Ïîñëå îáðàáîòêè ðàíû ñëåäóåò ñäåëàòü èç áèíòîâ íàêëàäíóþ ïîâÿçêó, íàëîæèòü å¸ íà ðàíó.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàëà áèíòû èç ìåäèöèíñêîãî êåéñà è ñäåëàëà èç íèõ íàêëàäíóþ ïîâÿçêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàëîæèëà ïîâÿçêó íà ðàíó")
	    wait(cfg.commands.zaderjka * 1000) 
        sampSendChat("/do Áèíòû ñêðûëè ðàíó.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîâÿçêà êðåïêî íàëîæåíà è ñòÿãèâàåò ðàíó.")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàë áèíòû èç ìåäèöèíñêîãî êåéñà è ñäåëàë èç íèõ íàêëàäíóþ ïîâÿçêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàëîæèë ïîâÿçêó íà ðàíó")
	    wait(cfg.commands.zaderjka * 1000) 
        sampSendChat("/do Áèíòû ñêðûëè ðàíó.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîâÿçêà êðåïêî íàëîæåíà è ñòÿãèâàåò ðàíó.")
		end
		end
      },
	  {
        title = '{5b83c2}« Ïðè îãíåñòðåëüíûõ ðàíåíèÿõ: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Ñíà÷àëà íóæíî îñòàíîâèòü êðîâîòå÷åíèå. Äëÿ ýòîãî íóæíî îñâîáîäèòü ìåñòî ðàíåíèÿ îò îäåæäû.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óâèäåëà ðàíåíèå è äîñòàëà èç ìåäèöèíñêîãî êåéñà æãóò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îñâîáîäèëà ðóêó ïîñòðàäàâøåãî îò îäåæäû è íà÷àëà íàêëàäûâàòü æãóò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Æãóò íàëîæåí, êðîâîòå÷åíèå îñòàíîâëåíî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà áëîêíîò èç êàðìàíà è íàïèñàëà âðåìÿ íàëîæåíèÿ æãóòà")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óâèäåë ðàíåíèå è äîñòàë èç ìåäèöèíñêîãî êåéñà æãóò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îñâîáîäèë ðóêó ïîñòðàäàâøåãî îò îäåæäû è íà÷àë íàêëàäûâàòü æãóò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Æãóò íàëîæåí, êðîâîòå÷åíèå îñòàíîâëåíî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë áëîêíîò èç êàðìàíà è íàïèñàë âðåìÿ íàëîæåíèÿ æãóòà")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Äàëåå íóæíî îáðàáîòàòü ðàíó õëîðãåêñèäèíîì èëè äðóãèì àíàëîãîì.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me îòêðûëà ñóìêó è äîñòàëà èç íå¸ ðàñòâîð õëîðãåêñèäèíà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàëà ðàíó ïîñòðàäàâøåãî è ïîëîæèëà ðàñòâîð õëîðãåêñèäèíà â ñóìêó")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me îòêðûë ñóìêó è äîñòàë èç íå¸ ðàñòâîð õëîðãåêñèäèíà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàë ðàíó ïîñòðàäàâøåãî è ïîëîæèë ðàñòâîð õëîðãåêñèäèíà â ñóìêó")
		end
		end
      },
	  {
        title = '{ffffff}» 3) Ïîñëå âñåõ ïðîâåä¸ííûõ ïðîöåäóð íóæíî ñäåëàòü èç áèíòîâ íàêëàäíóþ ïîâÿçêó, íàëîæèòü å¸.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàëà áèíòû èç ìåäèöèíñêîãî êåéñà è ñäåëàëà èç íèõ íàêëàäíóþ ïîâÿçêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íà÷àëà íàêëàäûâàòü ïîâÿçêó íà ðàíó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Áèíòû ïîñòåïåííî íà÷àëè ñêðûâàòü ðàíó.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîâÿçêà êðåïêî íàëîæåíà è ñòÿãèâàåò ðàíó.")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàë áèíòû èç ìåäèöèíñêîãî êåéñà è ñäåëàë èç íèõ íàêëàäíóþ ïîâÿçêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íà÷àë íàêëàäûâàòü ïîâÿçêó íà ðàíó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Áèíòû ïîñòåïåííî íà÷àëè ñêðûâàòü ðàíó.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîâÿçêà êðåïêî íàëîæåíà è ñòÿãèâàåò ðàíó.")
		end
		end
      },
	  {
        title = '{5b83c2}« Ïðè îáìîðîêå: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Ïðèâåñòè ïàöèåíòà â ñîçíàíèå.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèëà ìåäèöèíñêèé êåéñ íà ïîë è îòêðûëà åãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç êåéñà ôëàêîí ñ íàøàòûðíûì ñïèðòîì è îòêðûëà åãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç êåéñà âàòêó è íàìî÷èëà å¸ íàøàòûðíûì ñïèðòîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîäí¸ñëà ñìî÷åííóþ âàòêó ê íîñó ïîñòðàäàâøåãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do ×åëîâåê î÷íóëñÿ?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Äa/Íåò.")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
      sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèë ìåäèöèíñêèé êåéñ íà ïîë è îòêðûë åãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç êåéñà ôëàêîí ñ íàøàòûðíûì ñïèðòîì è îòêðûë åãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç êåéñà âàòêó è íàìî÷èë å¸ íàøàòûðíûì ñïèðòîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîäí¸ñë ñìî÷åííóþ âàòêó ê íîñó ïîñòðàäàâøåãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do ×åëîâåê î÷íóëñÿ?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Äa/Íåò.")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Åñëè ïàöèåíò ïðèøåë â ñåáÿ.',
        onclick = function()
        sampSendChat("Ñ âàìè âñ¸ õîðîøî, óñïîêîéòåñü, âû ïîòåðÿëè ñîçíàíèå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Òåïåðü âñ¸ â ïîðÿäêå, ÿ ìîãó âàì åù¸ ÷åì-òî ïîìî÷ü?")
		end
      },
	  {
        title = '{ffffff}» 3) Åñëè ïàöèåíò íå ïðèøåë â ñåáÿ.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me ñëåãêà ïîõëîïàëà ðóêàìè ïî ùåêàì ÷åëîâåêà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç ñóìêè áóòûëêó ñ õîëîäíîé âîäîé è îòêðóòèëà êðûøêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me áðûçíóëà âîäîé èç áóòûëêè íà ëèöî ïîñòðàäàâøåãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîõëîïàëà ïîñòðàäàâøåãî ïî ùåêàì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do ×åëîâåê ïðèø¸ë â ñîçíàíèå?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Äa/Íåò.")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me ñëåãêà ïîõëîïàë ðóêàìè ïî ùåêàì ÷åëîâåêà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç ñóìêè áóòûëêó ñ õîëîäíîé âîäîé è îòêðóòèë êðûøêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me áðûçíóë âîäîé èç áóòûëêè íà ëèöî ïîñòðàäàâøåãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîõëîïàë ïîñòðàäàâøåãî ïî ùåêàì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do ×åëîâåê ïðèø¸ë â ñîçíàíèå?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Äa/Íåò.")
		end
		end
      },
	  {
        title = '{5b83c2}« Åñëè ïàöèåíò ïðèøåë â ñåáÿ òî ïóíêò îáìîðîêà ¹2. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 4) Åñëè ïàöèåíò äî ñèõ ïîð íå ïðèøåë â ñåáÿ, ïðîâåðèòü ïóëüñ.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me ïîäí¸ñëà äâà ïàëüöà ê øåå ïîñòðàäàâøåãî, ïðèëîæèâ èõ ê ñîííîé àðòåðèè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ó ÷åëîâåêà åñòü ïóëüñ?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Äà/Íåò. ")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me ïîäí¸ñ äâà ïàëüöà ê øåå ïîñòðàäàâøåãî, ïðèëîæèâ èõ ê ñîííîé àðòåðèè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ó ÷åëîâåêà åñòü ïóëüñ?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Äà/Íåò. ")
		end
		end
      },
	  {
        title = '{ffffff}» 5) Åñëè ó ïîñòðàäàâøåãî íåò ïóëüñà, òî íóæíî ïðîâåñòè ðÿä ïðîöåäóð ðåàíèìèðîâàíèÿ.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàëà èç ñóìêè ïîëîòåíöå è ïîäëîæèëà åãî ïîä øåþ ïîñòðàäàâøåãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿëà ñ ãðóäè ÷åëîâåêà âñþ îäåæäó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿëà âñå ñäàâëèâàþùèå àêñåññóàðû")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñäåëàëà ãëóáîêèé âäîõ è íà÷àëà äåëàòü èñêóññòâåííîå äûõàíèå ë¸ãêèõ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Âîçäóõ ïîñòåïåííî íàïîëíÿåò ë¸ãêèå ïîñòðàäàâøåãî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèëà ðóêè äðóã íà äðóãà íà ãðóäü ÷åëîâåêà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äåëàåò íåïðÿìîé ìàññàæ ñåðäöà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîïåðåìåííî äåëàåò èñêóññòâåííîå äûõàíèå è íåïðÿìîé ìàññàæ ñåðäöà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do ×åëîâåê ïðèø¸ë â ñåáÿ?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Äà/Íåò. ")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàë èç ñóìêè ïîëîòåíöå è ïîäëîæèë åãî ïîä øåþ ïîñòðàäàâøåãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿë ñ ãðóäè ÷åëîâåêà âñþ îäåæäó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿë âñå ñäàâëèâàþùèå àêñåññóàðû")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñäåëàë ãëóáîêèé âäîõ è íà÷àë äåëàòü èñêóññòâåííîå äûõàíèå ë¸ãêèõ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Âîçäóõ ïîñòåïåííî íàïîëíÿåò ë¸ãêèå ïîñòðàäàâøåãî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèë ðóêè äðóã íà äðóãà íà ãðóäü ÷åëîâåêà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äåëàåò íåïðÿìîé ìàññàæ ñåðäöà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîïåðåìåííî äåëàåò èñêóññòâåííîå äûõàíèå è íåïðÿìîé ìàññàæ ñåðäöà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do ×åëîâåê ïðèø¸ë â ñåáÿ?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Äà/Íåò. ")
		end
		end
      },
	  {
        title = '{5b83c2}« Åñëè ïàöèåíò ïðèøåë ïîñëå âñåõ ïðîöåäóð âåçåì â áîëüíèöó äëÿ ëå÷åíèÿ. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Åñëè ïàöèåíò íå ïðèøåë â ñåáÿ âåçåì â áîëüíèöó äëÿ óñòàíàâëåíèÿ ñìåðòè. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Ïðè ïîòåðå ïóëüñà: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Åñëè ó ïîñòðàäàâøåãî íåò ïóëüñà, òî íóæíî ïðîâåñòè ðÿä ïðîöåäóð ðåàíèìèðîâàíèÿ.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç êåéñà ïîëîòåíöå è ïîäëîæèëà åãî ïîä øåþ ïîñòðàäàâøåãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿëà ñ ãðóäè ÷åëîâåêà âñþ îäåæäó è âñå ñäàâëèâàþùèå àêñåññóàðû ")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç êåéñà ïîëîòåíöå è ïîäëîæèë åãî ïîä øåþ ïîñòðàäàâøåãî")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿë ñ ãðóäè ÷åëîâåêà âñþ îäåæäó è âñå ñäàâëèâàþùèå àêñåññóàðû ")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Åñëè ó ïîñòðàäàâøåãî íåò ïóëüñà, òî íóæíî ïðîâåñòè ðÿä ïðîöåäóð ðåàíèìèðîâàíèÿ.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me ñäåëàëà ãëóáîêèé âäîõ è íà÷àëà äåëàòü èñêóññòâåííîå äûõàíèå ë¸ãêèõ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Âîçäóõ ïîñòåïåííî íàïîëíÿåò ë¸ãêèå ïîñòðàäàâøåãî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèëà ðóêè íà ãðóäü ÷åëîâåêà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äåëàåò íåïðÿìîé ìàññàæ ñåðäöà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîïåðåìåííî äåëàåò èñêóññòâåííîå äûõàíèå è íåïðÿìîé ìàññàæ ñåðäöà.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïðîøëà ìèíóòà.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do ×åëîâåê ïðèø¸ë â ñåáÿ?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Äà/Íåò.")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me ñäåëàë ãëóáîêèé âäîõ è íà÷àë äåëàòü èñêóññòâåííîå äûõàíèå ë¸ãêèõ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Âîçäóõ ïîñòåïåííî íàïîëíÿåò ë¸ãêèå ïîñòðàäàâøåãî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèë ðóêè íà ãðóäü ÷åëîâåêà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äåëàåò íåïðÿìîé ìàññàæ ñåðäöà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîïåðåìåííî äåëàåò èñêóññòâåííîå äûõàíèå è íåïðÿìîé ìàññàæ ñåðäöà.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïðîøëà ìèíóòà.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do ×åëîâåê ïðèø¸ë â ñåáÿ?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Äà/Íåò.")
		end
		end
      },
	  {
        title = '{5b83c2}« Åñëè ïàöèåíò íå ïðèøåë â ñåáÿ òî, ïðîäîëæàéòå òå æå äåéñòâèÿ â òå÷åíèè 4 ìèíóò. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Åñëè ïàöèåíò íå ïðèøåë â ñåáÿ òî, âåçèòå åãî â áîëüíèöó óñòàíàâëèâàòü ñìåðòü. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Ïðè îæîãàõ: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Íóæíî îñâîáîäèòü îáîææ¸ííûé ó÷àñòîê êîæè îò îäåæäû.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèëà êåéñ íà ïîë è äîñòàëà èç íåãî ìåäèöèíñêèå íîæíèöû")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me èñïîëüçóåò íîæíèöû è îñâîáîäèëà îáîææ¸ííûé ó÷àñòîê êîæè îò îäåæäû")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîëîæèë êåéñ íà ïîë è äîñòàë èç íåãî ìåäèöèíñêèå íîæíèöû")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me èñïîëüçóåò íîæíèöû è îñâîáîäèëà îáîææ¸ííûé ó÷àñòîê êîæè îò îäåæäû")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Äàëåå íóæíî îáðàáîòàòü îáãîðåâøèé ó÷àñòîê êîæè ñïðååì "Îëàçîëü".',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàëà èç ñóìêè ñïðåé 'Îëàçîëü' è îòêðûëà åãî êîëïà÷îê")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñáðûçíóëà ñïðååì îáãîðåâøèå ó÷àñòêè êîæè è çàêðûëà ñïðåé")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàëà åãî â ìåäèöèíñêèé êåéñ è äîñòàëà èç íå¸ áèíòû")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me äîñòàë èç ñóìêè ñïðåé 'Îëàçîëü' è îòêðûë åãî êîëïà÷îê")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñáðûçíóë ñïðååì îáãîðåâøèå ó÷àñòêè êîæè è çàêðûë ñïðåé")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàë åãî â ìåäèöèíñêèé êåéñ è äîñòàë èç íå¸ áèíòû")
		end
		end
      },
	  {
        title = '{ffffff}» 3) Â êîíöå âñåõ ïðîöåäóð ñëåäóåò íàëîæèòü ïîâÿçêó èç áèíòîâ íà îáîææ¸ííûé ó÷àñòîê êîæè.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me íàëîæèëà ïîâÿçêó èç áèíòîâ íà îæîã")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîâÿçêà êðåïêî ñèäèò íà îæîãå.")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me íàëîæèë ïîâÿçêó èç áèíòîâ íà îæîã")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïîâÿçêà êðåïêî ñèäèò íà îæîãå.")
		end
		end
      },
	 }
end
function medosmotr(args)
    return
    {
	  {
        title = '{ffffff}» Îñìîòð ó Íàðêîëîãà',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("Äîáðûé äåíü, ïðèñàæèâàéòåñü íà êóøåòêó è çàêàòàéòå ðóêàâ.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âàì íóæíî ñäàòü àíàëèç êðîâè.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç øêàôà: æãóò, ïóñòîé øïðèö è âàòêó, ñìî÷åííóþ ñïèðòîì.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàòÿíóëà æãóò íà ðóêå ïàöèåíòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàëà âàòêîé ìåñòî áóäóùåé èíúåêöèè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà øïðèöîì íåîáõîäèìîå êîëè÷åñòâî êðîâè ñ âåíû")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðèëîæèëà âàòêó ê ìåñòó óêîëà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïåðåëèëà êðîâü èç øïðèöà â ïðîáèðêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îïóñòèëà òåñòîâóþ ïàëî÷êó â ïðîáèðêó")
	    wait(1000)
		sampSendChat("/checkheal "..args)
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("Äîáðûé äåíü, ïðèñàæèâàéòåñü íà êóøåòêó è çàêàòàéòå ðóêàâ.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âàì íóæíî ñäàòü àíàëèç êðîâè.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç øêàôà: æãóò, ïóñòîé øïðèö è âàòêó, ñìî÷åííóþ ñïèðòîì.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàòÿíóë æãóò íà ðóêå ïàöèåíòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáðàáîòàë âàòêîé ìåñòî áóäóùåé èíúåêöèè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë øïðèöîì íåîáõîäèìîå êîëè÷åñòâî êðîâè ñ âåíû")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðèëîæèë âàòêó ê ìåñòó óêîëà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ïðîáèðêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îïóñòèë òåñòîâóþ ïàëî÷êó â ïðîáèðêó")
	    wait(1000)
		sampSendChat("/checkheal "..args)
		end
		end
      },
	  {
        title = '{5b83c2}« Ïðîâåðÿåì êîìàíäîé /checkheal [id]. »',
        onclick = function()
        end
      },
	 }
end
function renmenu(args)
    return
    {
      {
        title = '{5b83c2}« Ñïèñîê ïðîöåäóð. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ðåíòãåíîâñêèé àïïàðàò.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("Ëîæèòåñü íà êóøåòêó è ëåæèòå ñìèðíî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âêëþ÷èëà ðåíòãåíîâñêèé àïïàðàò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ðåíòãåíîâñêèé àïïàðàò çàøóìåë.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîâåëà ðåíòãåíîâñêèì àïïàðàòîì ïî ïîâðåæäåííîìó ó÷àñòêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ðàññìàòðèâàåò ñíèìîê")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try îáíàðóæèëà ïåðåëîì") 
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("Ëîæèòåñü íà êóøåòêó è ëåæèòå ñìèðíî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âêëþ÷èë ðåíòãåíîâñêèé àïïàðàò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ðåíòãåíîâñêèé àïïàðàò çàøóìåë.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîâåë ðåíòãåíîâñêèì àïïàðàòîì ïî ïîâðåæäåííîìó ó÷àñòêó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ðàññìàòðèâàåò ñíèìîê")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try îáíàðóæèë ïåðåëîì") 
		end
		end
      },
      {
        title = '{5b83c2}« Åñëè ó ïàöèåíòà ïåðåëîì êîíå÷íîñòåé. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ïåðåëîì êîíå÷íîñòåé.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("Ñàäèòåñü íà êóøåòêó.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà ñî ñòîëà ïåð÷àòêè è íàäåëà èõ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ðåíòãåíîâñêèé àïïàðàò çàøóìåë.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà øïðèö ñ îáåçáàëèâàþùèì, ïîñëå ÷åãî îáåçáîëèëà ïîâðåæäåííûé ó÷àñòîê")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîâåëà ðåïîçèöèþ ïîâðåæäåííîãî ó÷àñòêà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîäãîòîâèëà ãèïñîâûé ïîðîîøîê")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ðàñêàòèëà áèíò âäîëü ñòîëà, ïîñëå ÷åãî âòåðëà ãèïñîâûé ðàñòâîð")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñâåðíóëà áèíò, ïîñëå ÷åãî çàôèêñèðîâàëà ïåðåëîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïðèõîäèòå ÷åðåç ìåñÿö. Âñåãî äîáðîãî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿëà ïåð÷àòêè è áðîñèëà èõ â óðíó âîçëå ñòîëà") 
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("Ñàäèòåñü íà êóøåòêó.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë ñî ñòîëà ïåð÷àòêè è íàäåë èõ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ðåíòãåíîâñêèé àïïàðàò çàøóìåë.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë øïðèö ñ îáåçáàëèâàþùèì, ïîñëå ÷åãî îáåçáîëèë ïîâðåæäåííûé ó÷àñòîê")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîâåëà ðåïîçèöèþ ïîâðåæäåííîãî ó÷àñòêà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîäãîòîâèë ãèïñîâûé ïîðîîøîê")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ðàñêàòèë áèíò âäîëü ñòîëà, ïîñëå ÷åãî âòåð ãèïñîâûé ðàñòâîð")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñâåðíóë áèíò, ïîñëå ÷åãî çàôèêñèðîâàë ïåðåëîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïðèõîäèòå ÷åðåç ìåñÿö. Âñåãî äîáðîãî.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿë ïåð÷àòêè è áðîñèë èõ â óðíó âîçëå ñòîëà") 
		end
		end
      },
      {
        title = '{5b83c2}« Åñëè ó ïàöèåíòà ïåðåëîì ïîçâîíî÷íèêà/ðåáåð. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ïåðåëîì ïîçâîíî÷íèêà/ðåáåð.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me îñòîðîæíî óêëàëà ïîñòðàäàâøåãî íà îïåðàöèîííûé ñòîë")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà ñî ñòîëà ïåð÷àòêè è íàäåëà èõ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîäêëþ÷èëà ïîñòðàäàâøåãî ê êàïåëüíèöå")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàìî÷èëà âàòêó ñïèðòîì è îáðàáîòàëà êîæó íà ðóêå ïàöèåíòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âíóòðèâåííî ââåëà Ôòîðîòàí")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Íàðêîç íà÷èíàåò äåéñòâîâàòü, ïàöèåíò ïîòåðÿë ñîçíàíèå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà ñêàëüïåëü è ïèíöåò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñ ïîìîùüþ ðàçëè÷íûõ èíñòðóìåíòîâ ïðîèçâåëà ðåïîçèöèþ ïîâðåæäåííîãî ó÷àñòêà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç òóìáî÷êè ñïåöèàëüíûé êîðñåò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàôèêñèðîâàëà ïîâðåæäåííûé ó÷àñòîê ñ ïîìîùüþ êàðñåòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿëà ïåð÷àòêè è áðîñèëà èõ â óðíó âîçëå ñòîëà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàëà â îòäåëüíûé êîíòåéíåð ãðÿçíûé èíñòðóìåíòàðèé")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïðîøëî íåêîòîðîå âðåìÿ, ïàöèåíò ïðèø¸ë â ñîçíàíèå.") 
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me îñòîðîæíî óêëàë ïîñòðàäàâøåãî íà îïåðàöèîííûé ñòîë")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë ñî ñòîëà ïåð÷àòêè è íàäåë èõ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïîäêëþ÷èë ïîñòðàäàâøåãî ê êàïåëüíèöå")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me íàìî÷èë âàòêó ñïèðòîì è îáðàáîòàë êîæó íà ðóêå ïàöèåíòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âíóòðèâåííî ââåëà Ôòîðîòàí")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Íàðêîç íà÷èíàåò äåéñòâîâàòü, ïàöèåíò ïîòåðÿë ñîçíàíèå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë ñêàëüïåëü è ïèíöåò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñ ïîìîùüþ ðàçëè÷íûõ èíñòðóìåíòîâ ïðîèçâåë ðåïîçèöèþ ïîâðåæäåííîãî ó÷àñòêà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç òóìáî÷êè ñïåöèàëüíûé êîðñåò")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàôèêñèðîâàë ïîâðåæäåííûé ó÷àñòîê ñ ïîìîùüþ êàðñåòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿë ïåð÷àòêè è áðîñèë èõ â óðíó âîçëå ñòîëà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàë â îòäåëüíûé êîíòåéíåð ãðÿçíûé èíñòðóìåíòàðèé")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïðîøëî íåêîòîðîå âðåìÿ, ïàöèåíò ïðèø¸ë â ñîçíàíèå.") 
		end
		end
      },
      {
        title = '{5b83c2}« Åñëè ó ïàöèåíòà ãëóáîêèé ïîðåç. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ãëóáîêèé ïîðåç.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
        sampSendChat("/me âçÿëà ñî ñòîëà ïåð÷àòêè è íàäåëà èõ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîâåëà îñìîòð ïàöèåíòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îïðåäåëèëà ñòåïåíü òÿæåñòè ïîðåçà ó ïàöèåíòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáåçáîëèëà ïîâðåæäåííûé ó÷àñòîê")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç ìåä. ñóìêè æãóò è íàëîæèëà åãî ïîâåðõ ïîâðåæäåíèÿ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ðàçëîæèëà õèðóðãè÷åñêèå èíñòðóìåíòû íà ñòîëå")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿëà ñïåöèàëüíûå èãëó è íèòè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàøèëà êðîâåíîñíûé ñîñóä è ïðîâåðèëà ïóëüñ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîòåðëà êðîâü è çàøèëà ìåñòî ïîðåçà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îòëîæèëà èãëó è íèòè â ñòîðîíó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿëà æãóò, âçÿëà áèíòû è ïåðåáèíòîâàëà ïîâðåæäåííûé ó÷àñòîê êîæè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Äî ñâàäüáû çàæèâåò, óäà÷íîãî äíÿ, íå áîëåéòå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàëà â îòäåëüíûé êîíòåéíåð ãðÿçíûé èíñòðóìåíòàðèé") 
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
        sampSendChat("/me âçÿë ñî ñòîëà ïåð÷àòêè è íàäåë èõ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîâåë îñìîòð ïàöèåíòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îïðåäåëèë ñòåïåíü òÿæåñòè ïîðåçà ó ïàöèåíòà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îáåçáîëèë ïîâðåæäåííûé ó÷àñòîê")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç ìåä. ñóìêè æãóò è íàëîæèë åãî ïîâåðõ ïîâðåæäåíèÿ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ðàçëîæèë õèðóðãè÷åñêèå èíñòðóìåíòû íà ñòîëå")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âçÿë ñïåöèàëüíûå èãëó è íèòè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me çàøèë êðîâåíîñíûé ñîñóä è ïðîâåðèë ïóëüñ")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîòåð êðîâü è çàøèë ìåñòî ïîðåçà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me îòëîæèë èãëó è íèòè â ñòîðîíó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñíÿë æãóò, âçÿë áèíòû è ïåðåáèíòîâàë ïîâðåæäåííûé ó÷àñòîê êîæè")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Äî ñâàäüáû çàæèâåò, óäà÷íîãî äíÿ, íå áîëåéòå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me óáðàë â îòäåëüíûé êîíòåéíåð ãðÿçíûé èíñòðóìåíòàðèé") 
		end
		end
      },
    }
end
function priziv(id)
    return
    {
	  {
        title = '{80a4bf}» {ffffff}Ïðèâåòñòâèå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
		sampSendChat('Çäðàâñòâóéòå, ÿ '..rank..' âîåííîé ìåä.êîìèññèè ýòîãî Øòàòà.')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ '..rank..' | '..myname:gsub('_', ' ')..'.')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Ïðèçûâíèê ïîêàæèòå ïîæàëóéñòà âàøó ìåä.êàðòó.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/b /me ïåðåäàë ìåä.êàðòó")
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïðîâåðêà ìåä.êàðòû',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
		sampSendChat("/me ïðîòÿíóëà ïðàâóþ ðóêó, ïîñëå âçÿëà ìåä.êàðòó ó ÷åëîâåêà íàïðîòèâ")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me íà÷àëà ñìîòðåòü ìåä.êàðòó, ïîñëå ÷åãî ñêàçàëà")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Íàðêîòè÷åñêèå âåùåñòâà óïîòðåáëÿëè?")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
		sampSendChat("/me ïðîòÿíóë ïðàâóþ ðóêó, ïîñëå âçÿë ìåä.êàðòó ó ÷åëîâåêà íàïðîòèâ")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me íà÷àë ñìîòðåòü ìåä.êàðòó, ïîñëå ÷åãî ñêàçàë")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Íàðêîòè÷åñêèå âåùåñòâà óïîòðåáëÿëè?")
		end
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïðîâåðêà íà çàâèñèìîñòü',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
		sampSendChat("- Õîðîøî. Ñåé÷àñ ìû ïðîâåðèì âàñ íà íàëè÷èå íàðêîçàâèñèìîñòè.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàëà èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ñïåöèàëüíóþ êîëáî÷êó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîïèòàëà âàòó ñïèðòîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me îáðàáîòàëà âàòîé ìåñòî óêîëà íà âåíå '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Øïðèö è ñïåöèàëüíàÿ êîëáî÷êà â ïðàâîé ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñ ïîìîùüþ øïðèöà âçÿëà íåìíîãî êðîâè äëÿ àíàëèçà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïåðåëèëà êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèëà å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(1300)
		sampSendChat("/checkheal "..id)
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
		sampSendChat("- Õîðîøî. Ñåé÷àñ ìû ïðîâåðèì âàñ íà íàëè÷èå íàðêîçàâèñèìîñòè.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ñïåöèàëüíóþ êîëáî÷êó")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Øïðèö è ñïåöèàëüíàÿ êîëáî÷êà â ïðàâîé ðóêå.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ñ ïîìîùüþ øïðèöà âçÿë íåìíîãî êðîâè äëÿ àíàëèçà")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(1300)
		sampSendChat("/checkheal "..id)
		end
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Ãîäåí.',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
		sampSendChat('/do Íà ýêðàíå ïîêàçàí îòðèöàòåëüíûé ðåçóëüòàò òåñòà êðîâè '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âûïèñàëà ñïðàâêó î òîì, ÷òî ïàöèåíò íå èìååò íàðêîçàâèñèìîñòè è ãîäåí ê ñëóæáå.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me ïåðåäàëà ñïðàâêó ïàöèåíòó â ðóêè")
		wait(3000)
		sampSendChat("/do Ïðîòÿíóòà ïðàâàÿ ðóêà ñî ñïðàâêîé.")
		wait(3000)
		sampSendChat("Âîò. Äåðæèòå è ïðîõîäèòå äàëüøå")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
		sampSendChat('/do Íà ýêðàíå ïîêàçàí îòðèöàòåëüíûé ðåçóëüòàò òåñòà êðîâè '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me âûïèñàë ñïðàâêó î òîì, ÷òî ïàöèåíò íå èìååò íàðêîçàâèñèìîñòè è ãîäåí ê ñëóæáå.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me ïåðåäàë ñïðàâêó ïàöèåíòó â ðóêè")
		wait(3000)
		sampSendChat("/do Ïðîòÿíóò ïðàâàÿ ðóêà ñî ñïðàâêîé.")
		wait(3000)
		sampSendChat("Âîò. Äåðæèòå è ïðîõîäèòå äàëüøå")
		end
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Íå ãîäåí',
        onclick = function()
		if cfg.main.male == false then --- Æåíñêàÿ îòûãðîâêà
		sampSendChat('/do Íà ýêðàíå ïîêàçàí ïîëîæèòåëüíûé ðåçóëüòàò òåñòà êðîâè '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âû èìååòå íàðêîçàâèñèìîñòü. Ïðîéäèòå ñåàíñ îò çàâèñèìîñòè ó Íàðêîëîãà.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me ïîñòàâèëà ïå÷àòü 'Íå ãîäåí' íà ìåä.êàðòó ïðèçûâíèêà")
		end
		if cfg.main.male == true then --- Ìóæñêàÿ îòûãðîâêà
		sampSendChat('/do Íà ýêðàíå ïîêàçàí ïîëîæèòåëüíûé ðåçóëüòàò òåñòà êðîâè '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âû èìååòå íàðêîçàâèñèìîñòü. Ïðîéäèòå ñåàíñ îò çàâèñèìîñòè ó Íàðêîëîãà.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me ïîñòàâèë ïå÷àòü 'Íå ãîäåí' íà ìåä.êàðòó ïðèçûâíèêà")
		end
		end
      }
    }
end

function getFraktionBySkin(playerid)
    fraks = {
        [0] = 'Ãðàæäàíñêèé',
        [1] = 'Ãðàæäàíñêèé',
        [2] = 'Ãðàæäàíñêèé',
        [3] = 'Ãðàæäàíñêèé',
        [4] = 'Ãðàæäàíñêèé',
        [5] = 'Ãðàæäàíñêèé',
        [6] = 'Ãðàæäàíñêèé',
        [7] = 'Ãðàæäàíñêèé',
        [8] = 'Ãðàæäàíñêèé',
        [9] = 'Ãðàæäàíñêèé',
        [10] = 'Ãðàæäàíñêèé',
        [11] = 'Ãðàæäàíñêèé',
        [12] = 'Ãðàæäàíñêèé',
        [13] = 'Ãðàæäàíñêèé',
        [14] = 'Ãðàæäàíñêèé',
        [15] = 'Ãðàæäàíñêèé',
        [16] = 'Ãðàæäàíñêèé',
        [17] = 'Ãðàæäàíñêèé',
        [18] = 'Ãðàæäàíñêèé',
        [19] = 'Ãðàæäàíñêèé',
        [20] = 'Ãðàæäàíñêèé',
        [21] = 'Ballas',
        [22] = 'Ãðàæäàíñêèé',
        [23] = 'Ãðàæäàíñêèé',
        [24] = 'Ãðàæäàíñêèé',
        [25] = 'Ãðàæäàíñêèé',
        [26] = 'Ãðàæäàíñêèé',
        [27] = 'Ãðàæäàíñêèé',
        [28] = 'Ãðàæäàíñêèé',
        [29] = 'Ãðàæäàíñêèé',
        [30] = 'Rifa',
        [31] = 'Ãðàæäàíñêèé',
        [32] = 'Ãðàæäàíñêèé',
        [33] = 'Ãðàæäàíñêèé',
        [34] = 'Ãðàæäàíñêèé',
        [35] = 'Ãðàæäàíñêèé',
        [36] = 'Ãðàæäàíñêèé',
        [37] = 'Ãðàæäàíñêèé',
        [38] = 'Ãðàæäàíñêèé',
        [39] = 'Ãðàæäàíñêèé',
        [40] = 'Ãðàæäàíñêèé',
        [41] = 'Aztec',
        [42] = 'Ãðàæäàíñêèé',
        [43] = 'Ãðàæäàíñêèé',
        [44] = 'Aztec',
        [45] = 'Ãðàæäàíñêèé',
        [46] = 'Ãðàæäàíñêèé',
        [47] = 'Vagos',
        [48] = 'Aztec',
        [49] = 'Ãðàæäàíñêèé',
        [50] = 'Ãðàæäàíñêèé',
        [51] = 'Ãðàæäàíñêèé',
        [52] = 'Ãðàæäàíñêèé',
        [53] = 'Ãðàæäàíñêèé',
        [54] = 'Ãðàæäàíñêèé',
        [55] = 'Ãðàæäàíñêèé',
        [56] = 'Grove',
        [57] = 'Ìýðèÿ',
        [58] = 'Ãðàæäàíñêèé',
        [59] = 'Àâòîøêîëà',
        [60] = 'Ãðàæäàíñêèé',
        [61] = 'Àðìèÿ',
        [62] = 'Ãðàæäàíñêèé',
        [63] = 'Ãðàæäàíñêèé',
        [64] = 'Ãðàæäàíñêèé',
        [65] = 'Ãðàæäàíñêèé', -- íàä ïîäóìàòü
        [66] = 'Ãðàæäàíñêèé',
        [67] = 'Ãðàæäàíñêèé',
        [68] = 'Ãðàæäàíñêèé',
        [69] = 'Ãðàæäàíñêèé',
        [70] = 'ÌÎÍ',
        [71] = 'Ãðàæäàíñêèé',
        [72] = 'Ãðàæäàíñêèé',
        [73] = 'Army',
        [74] = 'Ãðàæäàíñêèé',
        [75] = 'Ãðàæäàíñêèé',
        [76] = 'Ãðàæäàíñêèé',
        [77] = 'Ãðàæäàíñêèé',
        [78] = 'Ãðàæäàíñêèé',
        [79] = 'Ãðàæäàíñêèé',
        [80] = 'Ãðàæäàíñêèé',
        [81] = 'Ãðàæäàíñêèé',
        [82] = 'Ãðàæäàíñêèé',
        [83] = 'Ãðàæäàíñêèé',
        [84] = 'Ãðàæäàíñêèé',
        [85] = 'Ãðàæäàíñêèé',
        [86] = 'Grove',
        [87] = 'Ãðàæäàíñêèé',
        [88] = 'Ãðàæäàíñêèé',
        [89] = 'Ãðàæäàíñêèé',
        [90] = 'Ãðàæäàíñêèé',
        [91] = 'Ãðàæäàíñêèé', -- ïîä âîïðîñîì
        [92] = 'Ãðàæäàíñêèé',
        [93] = 'Ãðàæäàíñêèé',
        [94] = 'Ãðàæäàíñêèé',
        [95] = 'Ãðàæäàíñêèé',
        [96] = 'Ãðàæäàíñêèé',
        [97] = 'Ãðàæäàíñêèé',
        [98] = 'Ìýðèÿ',
        [99] = 'Ãðàæäàíñêèé',
        [100] = 'Áàéêåð',
        [101] = 'Ãðàæäàíñêèé',
        [102] = 'Ballas',
        [103] = 'Ballas',
        [104] = 'Ballas',
        [105] = 'Grove',
        [106] = 'Grove',
        [107] = 'Grove',
        [108] = 'Vagos',
        [109] = 'Vagos',
        [110] = 'Vagos',
        [111] = 'RM',
        [112] = 'RM',
        [113] = 'LCN',
        [114] = 'Aztec',
        [115] = 'Aztec',
        [116] = 'Aztec',
        [117] = 'Yakuza',
        [118] = 'Yakuza',
        [119] = 'Rifa',
        [120] = 'Yakuza',
        [121] = 'Ãðàæäàíñêèé',
        [122] = 'Ãðàæäàíñêèé',
        [123] = 'Yakuza',
        [124] = 'LCN',
        [125] = 'RM',
        [126] = 'RM',
        [127] = 'LCN',
        [128] = 'Ãðàæäàíñêèé',
        [129] = 'Ãðàæäàíñêèé',
        [130] = 'Ãðàæäàíñêèé',
        [131] = 'Ãðàæäàíñêèé',
        [132] = 'Ãðàæäàíñêèé',
        [133] = 'Ãðàæäàíñêèé',
        [134] = 'Ãðàæäàíñêèé',
        [135] = 'Ãðàæäàíñêèé',
        [136] = 'Ãðàæäàíñêèé',
        [137] = 'Ãðàæäàíñêèé',
        [138] = 'Ãðàæäàíñêèé',
        [139] = 'Ãðàæäàíñêèé',
        [140] = 'Ãðàæäàíñêèé',
        [141] = 'FBI',
        [142] = 'Ãðàæäàíñêèé',
        [143] = 'Ãðàæäàíñêèé',
        [144] = 'Ãðàæäàíñêèé',
        [145] = 'Ãðàæäàíñêèé',
        [146] = 'Ãðàæäàíñêèé',
        [147] = 'Ìýðèÿ',
        [148] = 'Ãðàæäàíñêèé',
        [149] = 'Grove',
        [150] = 'Ìýðèÿ',
        [151] = 'Ãðàæäàíñêèé',
        [152] = 'Ãðàæäàíñêèé',
        [153] = 'Ãðàæäàíñêèé',
        [154] = 'Ãðàæäàíñêèé',
        [155] = 'Ãðàæäàíñêèé',
        [156] = 'Ãðàæäàíñêèé',
        [157] = 'Ãðàæäàíñêèé',
        [158] = 'Ãðàæäàíñêèé',
        [159] = 'Ãðàæäàíñêèé',
        [160] = 'Ãðàæäàíñêèé',
        [161] = 'Ãðàæäàíñêèé',
        [162] = 'Ãðàæäàíñêèé',
        [163] = 'FBI',
        [164] = 'FBI',
        [165] = 'FBI',
        [166] = 'FBI',
        [167] = 'Ãðàæäàíñêèé',
        [168] = 'Ãðàæäàíñêèé',
        [169] = 'Yakuza',
        [170] = 'Ãðàæäàíñêèé',
        [171] = 'Ãðàæäàíñêèé',
        [172] = 'Ãðàæäàíñêèé',
        [173] = 'Rifa',
        [174] = 'Rifa',
        [175] = 'Rifa',
        [176] = 'Ãðàæäàíñêèé',
        [177] = 'Ãðàæäàíñêèé',
        [178] = 'Ãðàæäàíñêèé',
        [179] = 'Army',
        [180] = 'Ãðàæäàíñêèé',
        [181] = 'Áàéêåð',
        [182] = 'Ãðàæäàíñêèé',
        [183] = 'Ãðàæäàíñêèé',
        [184] = 'Ãðàæäàíñêèé',
        [185] = 'Ãðàæäàíñêèé',
        [186] = 'Yakuza',
        [187] = 'Ìýðèÿ',
        [188] = 'ÑÌÈ',
        [189] = 'Ãðàæäàíñêèé',
        [190] = 'Vagos',
        [191] = 'Army',
        [192] = 'Ãðàæäàíñêèé',
        [193] = 'Aztec',
        [194] = 'Ãðàæäàíñêèé',
        [195] = 'Ballas',
        [196] = 'Ãðàæäàíñêèé',
        [197] = 'Ãðàæäàíñêèé',
        [198] = 'Ãðàæäàíñêèé',
        [199] = 'Ãðàæäàíñêèé',
        [200] = 'Ãðàæäàíñêèé',
        [201] = 'Ãðàæäàíñêèé',
        [202] = 'Ãðàæäàíñêèé',
        [203] = 'Ãðàæäàíñêèé',
        [204] = 'Ãðàæäàíñêèé',
        [205] = 'Ãðàæäàíñêèé',
        [206] = 'Ãðàæäàíñêèé',
        [207] = 'Ãðàæäàíñêèé',
        [208] = 'Yakuza',
        [209] = 'Ãðàæäàíñêèé',
        [210] = 'Ãðàæäàíñêèé',
        [211] = 'ÑÌÈ',
        [212] = 'Ãðàæäàíñêèé',
        [213] = 'Ãðàæäàíñêèé',
        [214] = 'LCN',
        [215] = 'Ãðàæäàíñêèé',
        [216] = 'Ãðàæäàíñêèé',
        [217] = 'ÑÌÈ',
        [218] = 'Ãðàæäàíñêèé',
        [219] = 'ÌÎÍ',
        [220] = 'Ãðàæäàíñêèé',
        [221] = 'Ãðàæäàíñêèé',
        [222] = 'Ãðàæäàíñêèé',
        [223] = 'LCN',
        [224] = 'Ãðàæäàíñêèé',
        [225] = 'Ãðàæäàíñêèé',
        [226] = 'Rifa',
        [227] = 'Ìýðèÿ',
        [228] = 'Ãðàæäàíñêèé',
        [229] = 'Ãðàæäàíñêèé',
        [230] = 'Ãðàæäàíñêèé',
        [231] = 'Ãðàæäàíñêèé',
        [232] = 'Ãðàæäàíñêèé',
        [233] = 'Ãðàæäàíñêèé',
        [234] = 'Ãðàæäàíñêèé',
        [235] = 'Ãðàæäàíñêèé',
        [236] = 'Ãðàæäàíñêèé',
        [237] = 'Ãðàæäàíñêèé',
        [238] = 'Ãðàæäàíñêèé',
        [239] = 'Ãðàæäàíñêèé',
        [240] = 'Àâòîøêîëà',
        [241] = 'Ãðàæäàíñêèé',
        [242] = 'Ãðàæäàíñêèé',
        [243] = 'Ãðàæäàíñêèé',
        [244] = 'Ãðàæäàíñêèé',
        [245] = 'Ãðàæäàíñêèé',
        [246] = 'Áàéêåð',
        [247] = 'Áàéêåð',
        [248] = 'Áàéêåð',
        [249] = 'Ãðàæäàíñêèé',
        [250] = 'ÑÌÈ',
        [251] = 'Ãðàæäàíñêèé',
        [252] = 'Army',
        [253] = 'Ãðàæäàíñêèé',
        [254] = 'Áàéêåð',
        [255] = 'Army',
        [256] = 'Ãðàæäàíñêèé',
        [257] = 'Ãðàæäàíñêèé',
        [258] = 'Ãðàæäàíñêèé',
        [259] = 'Ãðàæäàíñêèé',
        [260] = 'Ãðàæäàíñêèé',
        [261] = 'ÑÌÈ',
        [262] = 'Ãðàæäàíñêèé',
        [263] = 'Ãðàæäàíñêèé',
        [264] = 'Ãðàæäàíñêèé',
        [265] = 'Ïîëèöèÿ',
        [266] = 'Ïîëèöèÿ',
        [267] = 'Ïîëèöèÿ',
        [268] = 'Ãðàæäàíñêèé',
        [269] = 'Grove',
        [270] = 'Grove',
        [271] = 'Grove',
        [272] = 'RM',
        [273] = 'Ãðàæäàíñêèé', -- íàäî ïîäóìàòü
        [274] = 'ÌÎÍ',
        [275] = 'ÌÎÍ',
        [276] = 'ÌÎÍ',
        [277] = 'Ãðàæäàíñêèé',
        [278] = 'Ãðàæäàíñêèé',
        [279] = 'Ãðàæäàíñêèé',
        [280] = 'Ïîëèöèÿ',
        [281] = 'Ïîëèöèÿ',
        [282] = 'Ïîëèöèÿ',
        [283] = 'Ïîëèöèÿ',
        [284] = 'Ïîëèöèÿ',
        [285] = 'Ïîëèöèÿ',
        [286] = 'FBI',
        [287] = 'Army',
        [288] = 'Ïîëèöèÿ',
        [289] = 'Ãðàæäàíñêèé',
        [290] = 'Ãðàæäàíñêèé',
        [291] = 'Ãðàæäàíñêèé',
        [292] = 'Aztec',
        [293] = 'Ãðàæäàíñêèé',
        [294] = 'Ãðàæäàíñêèé',
        [295] = 'Ãðàæäàíñêèé',
        [296] = 'Ãðàæäàíñêèé',
        [297] = 'Grove',
        [298] = 'Ãðàæäàíñêèé',
        [299] = 'Ãðàæäàíñêèé',
        [300] = 'Ïîëèöèÿ',
        [301] = 'Ïîëèöèÿ',
        [302] = 'Ïîëèöèÿ',
        [303] = 'Ïîëèöèÿ',
        [304] = 'Ïîëèöèÿ',
        [305] = 'Ïîëèöèÿ',
        [306] = 'Ïîëèöèÿ',
        [307] = 'Ïîëèöèÿ',
        [308] = 'ÌÎÍ',
        [309] = 'Ïîëèöèÿ',
        [310] = 'Ïîëèöèÿ',
        [311] = 'Ïîëèöèÿ'
    }
    if sampIsPlayerConnected(playerid) then
        local result, handle = sampGetCharHandleBySampPlayerId(playerid)
        local skin = getCharModel(handle)
        return fraks[skin]
    end
end

function a.onSendClickPlayer(id)
	if rank == 'Ñòàæåð' or rank == 'Êîíñóëüòàíò' or rank == 'Ìë.Èíñòðóêòîð' or rank == 'Èíñòðóêòîð' or rank == 'Äîêòîð' or rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' then
    setClipboardText(sampGetPlayerNickname(id))
	ftext('Íèê ñêîïèðîâàí â áóôåð îáìåíà.')
	else
	end
end

function smsjob()
  if rank == 'Äîêòîð' or rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
    lua_thread.create(function()
        vixodid = {}
		status = true
		sampSendChat('/members')
        while not gotovo do wait(0) end
        wait(1200)
        for k, v in pairs(vixodid) do
            sampSendChat('/sms '..v..' Ïðèâåòñòâóþ, ÿâèòåñü íà ðàáîòó, ó âàñ 15 ìèíóò. Êàê ïðèíÿëè?')
            wait(1200)
        end
        players2 = {'{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
		gotovo = false
        status = false
        vixodid = {}
	end)
	else
	ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ äîëæíîñòè Ïñèõîëîã.')
	end
end

function goupdate()
    ftext('Íà÷àëîñü ñêà÷èâàíèå îáíîâëåíèÿ. Ñêðèïò ïåðåçàãðóçèòñÿ ÷åðåç ïàðó ñåêóíä.', -1)
    wait(300)
    downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
    if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
        showCursor(false)
	    thisScript():reload()
    end
end)
end

function update()
	local fpath = os.getenv('TEMP') .. '\\update.json'
	downloadUrlToFile('https://raw.githubusercontent.com/src303/medichelper/master/update.json', fpath, function(id, status, p1, p2)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            local f = io.open(fpath, 'r')
            if f then
			    local info = decodeJson(f:read('*a'))
                updatelink = info.updateurl
                updlist1 = info.updlist
				updversion = info.latest
                ttt = updlist1
			    if info and info.latest then
                    version = tonumber(info.latest)
                    if version > tonumber(thisScript().version) then
                        ftext('Îáíàðóæåíî îáíîâëåíèå äî âåðñèè '..updversion..'.')
					    updwindows.v = true
                    else
                        ftext('Îáíîâëåíèé ñêðèïòà íå îáíàðóæåíî. Ïðèÿòíîé èãðû.', -1)
                        update = false
				    end
			    end
		    end
	    end
    end)
end

function getcolor(id)
local colors =
        {
		[1] = 'Çåë¸íûé',
		[2] = 'Ñâåòëî-çåë¸íûé',
		[3] = 'ßðêî-çåë¸íûé',
		[4] = 'Áèðþçîâûé',
		[5] = 'Æ¸ëòî-çåë¸íûé',
		[6] = 'Òåìíî-çåë¸íûé',
		[7] = 'Ñåðî-çåë¸íûé',
		[8] = 'Êðàñíûé',
		[9] = 'ßðêî-êðàñíûé',
		[10] = 'Îðàíæåâûé',
		[11] = 'Êîðè÷íåâûé',
		[12] = 'Ò¸ìíî-êðàñíûé',
		[13] = 'Ñåðî-êðàñíûé',
		[14] = 'Æ¸ëòî-îðàíæåâûé',
		[15] = 'Ìàëèíîâûé',
		[16] = 'Ðîçîâûé',
		[17] = 'Ñèíèé',
		[18] = 'Ãîëóáîé',
		[19] = 'Ñèíÿÿ ñòàëü',
		[20] = 'Ñèíå-çåë¸íûé',
		[21] = 'Ò¸ìíî-ñèíèé',
		[22] = 'Ôèîëåòîâûé',
		[23] = 'Èíäèãî',
		[24] = 'Ñåðî-ñèíèé',
		[25] = 'Æ¸ëòûé',
		[26] = 'Êóêóðóçíûé',
		[27] = 'Çîëîòîé',
		[28] = 'Ñòàðîå çîëîòî',
		[29] = 'Îëèâêîâûé',
		[30] = 'Ñåðûé',
		[31] = 'Ñåðåáðî',
		[32] = '×åðíûé',
		[33] = 'Áåëûé',
		}
	return colors[id]
end
function sampev.onSendSpawn()
    pX, pY, pZ = getCharCoordinates(playerPed)
    if cfg.main.clistb and getDistanceBetweenCoords3d(pX, pY, pZ, 2337.3574,1666.1699,3040.9524) < 20 then
        lua_thread.create(function()
            wait(1200)
			sampSendChat('/clist '..tonumber(cfg.main.clist))
			wait(500)
			local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
			colors = getcolor(cfg.main.clist)
            ftext('Öâåò íèêà ñìåíåí íà: {'..color..'}'..cfg.main.clist..' ['..colors..']')
        end)
    end
end
-- Òåñò dmb n
-- Òåñò dmb z
function sampev.onServerMessage(color, text)
        if text:find('Ðàáî÷èé äåíü íà÷àò') and color ~= -1 then
        if cfg.main.clistb then
		if rabden == false then
            lua_thread.create(function()
                wait(100)
				sampSendChat('/clist '..tonumber(cfg.main.clist))
				wait(500)
                local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
                colors = getcolor(cfg.main.clist)
                ftext('Öâåò íèêà ñìåíåí íà: {'..color..'}'..cfg.main.clist..' ['..colors..']')
                rabden = true
				wait(1000)
				if cfg.main.clisto then
				local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
				if cfg.main.male == true then
				sampSendChat("/me îòêðûë øêàô÷èê")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me ñíÿë ñâîþ îäåæäó, ïîñëå ÷åãî ñëîæèë åå â øêàô")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me âçÿë ðàáî÷óþ îäåæäó, çàòåì ïåðåîäåëñÿ â íåå")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me íàöåïèë áåéäæèê íà ðóáàøêó")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
				if cfg.main.male == false then
				sampSendChat("/me îòêðûëà øêàô÷èê")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me ñíÿëà ñâîþ îäåæäó, ïîñëå ÷åãî ñëîæèëà åå â øêàô")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me âçÿëà ðàáî÷óþ îäåæäó, çàòåì ïåðåîäåëàñü â íåå")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me íàöåïèëà áåéäæèê íà ðóáàøêó")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
			end
            end)
        end
	  end
    end
	if text:find('SMS:') and text:find('Îòïðàâèòåëü:') then
		wordsSMS, nickSMS = string.match(text, 'SMS: (.+) Îòïðàâèòåëü: (.+)');
		local idsms = nickSMS:match('.+%[(%d+)%]')
		lastnumber = idsms
	end
    if text:find('Ðàáî÷èé äåíü îêîí÷åí') and color ~= -1 then
        rabden = false
    end
	if text:find('Âû âûëå÷èëè') then
        local Nicks = text:match('Âû âûëå÷èëè èãðîêà (.+).')
		health = health + 1
   end
   	if text:find('Ñåàíñ ëå÷åíèÿ îò íàðêîçàâèñèìîñòè') then
        local Nicks = text:match('Âû âûëå÷èëè èãðîêà (.+) îò íàðêîçàâèñèìîñòè.')
		narkoh = narkoh + 1
   end
	if color == -8224086 then
        local colors = ('{%06X}'):format(bit.rshift(color, 8))
        table.insert(departament, os.date(colors..'[%H:%M:%S] ') .. text)
    end
	if color == -1920073984 and (text:match('.+ .+%: .+') or text:match('%(%( .+ .+%: .+ %)%)')) then
            local colors = ("{%06X}"):format(bit.rshift(color, 8))
            table.insert(radio, os.date(colors.."[%H:%M:%S] ") .. text)
        end
	if color == -65366 and (text:match('SMS%: .+. Îòïðàâèòåëü%: .+') or text:match('SMS%: .+. Ïîëó÷àòåëü%: .+')) then
            local colors = ("{%06X}"):format(bit.rshift(color, 8))
            table.insert(smslogs, os.date(colors.."[%H:%M:%S] ") .. text)
        end
	if statusc then
		if text:match('ID: .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, nick, rang, stat = text:match('ID: (%d+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
		    src_good = ""
            src_bad = ""
			local _, myid = sampGetPlayerIdByCharHandle(playerPed)
			local _, handle = sampGetCharHandleBySampPlayerId(id)
			local myname = sampGetPlayerNickname(myid)
				if doesCharExist(handle) then
					local x, y, z = getCharCoordinates(handle)
					local mx, my, mz = getCharCoordinates(PLAYER_PED)
					local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)

					if dist <= 50 then
						src_good = src_good ..sampGetPlayerNickname(id).. ""
					end
					else
						src_bad = src_bad ..sampGetPlayerNickname(id).. ""
			if src_bad ~= myname then
			table.insert(players3, string.format('{'..color..'}%s[%s]{ffffff}\t%s\t%s', src_bad, id, rang, stat))
			return false
		end
		end
		end
		if text:match('Âñåãî: %d+ ÷åëîâåê') then
			local count = text:match('Âñåãî: (%d+) ÷åëîâåê')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
	if status then
		if text:match('ID: .+ | .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, data, nick, rang, stat = text:match('ID: (%d+) | (.+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			local nmrang = rang:match('.+%[(%d+)%]')
            if stat:find('Âûõîäíîé') and tonumber(nmrang) < 7 then
                table.insert(vixodid, id)
            end
			table.insert(players2, string.format('{ffffff}%s\t {'..color..'}%s[%s]{ffffff}\t%s\t%s', data, nick, id, rang, stat))
			return false
		end
		if text:match('Âñåãî: %d+ ÷åëîâåê') then
			local count = text:match('Âñåãî: (%d+) ÷åëîâåê')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
end
function getZones(zone)
    local names = {
      ['SUNMA'] = 'Bayside Marina',
      ['SUNNN'] = 'Bayside',
      ['BATTP'] = 'Battery Point',
      ['PARA'] = 'Paradiso',
      ['CIVI'] = 'Santa Flora',
      ['BAYV'] = 'Palisades',
      ['CITYS'] = 'City Hall',
      ['OCEAF'] = 'Ocean Flats',
      ['HASH'] = 'Hashbury',
      ['JUNIHO'] = 'Juniper Hollow',
      ['ESPN'] = 'Esplanade North',
      ['FINA'] = 'Financial',
      ['CALT'] = 'Calton Heights',
      ['SFDWT'] = 'Downtown',
      ['JUNIHI'] = 'Juniper Hill',
      ['CHINA'] = 'Chinatown',
      ['THEA'] = 'King`s',
      ['GARC'] = 'Garcia',
      ['DOH'] = 'Doherty',
      ['SFAIR'] = 'Easter Bay Airport',
      ['EASB'] = 'Easter Basin',
      ['ESPE'] = 'Esplanade East',
      ['ANGPI'] = 'Angel Pine',
      ['SHACA'] = 'Shady Cabin',
      ['BACKO'] = 'Back o Beyond',
      ['LEAFY'] = 'Leafy Hollow',
      ['FLINTR'] = 'Flint Range',
      ['HAUL'] = 'Fallen Tree',
      ['FARM'] = 'The Farm',
      ['ELQUE'] = 'El Quebrados',
      ['ALDEA'] = 'Aldea Malvada',
      ['DAM'] = 'The Sherman Dam',
      ['BARRA'] = 'Las Barrancas',
      ['CARSO'] = 'Fort Carson',
      ['QUARY'] = 'Hunter Quarry',
      ['OCTAN'] = 'Octane Springs',
      ['PALMS'] = 'Green Palms',
      ['TOM'] = 'Regular Tom',
      ['BRUJA'] = 'Las Brujas',
      ['MEAD'] = 'Verdant Meadows',
      ['PAYAS'] = 'Las Payasadas',
      ['ARCO'] = 'Arco del Oeste',
      ['HANKY'] = 'Hankypanky Point',
      ['PALO'] = 'Palomino Creek',
      ['NROCK'] = 'North Rock',
      ['MONT'] = 'Montgomery',
      ['HBARNS'] = 'Hampton Barns',
      ['FERN'] = 'Fern Ridge',
      ['DILLI'] = 'Dillimore',
      ['TOPFA'] = 'Hilltop Farm',
      ['BLUEB'] = 'Blueberry',
      ['PANOP'] = 'The Panopticon',
      ['FRED'] = 'Frederick Bridge',
      ['MAKO'] = 'The Mako Span',
      ['BLUAC'] = 'Blueberry Acres',
      ['MART'] = 'Martin Bridge',
      ['FALLO'] = 'Fallow Bridge',
      ['CREEK'] = 'Shady Creeks',
      ['WESTP'] = 'Queens',
      ['LA'] = 'Los Santos',
      ['VE'] = 'Las Venturas',
      ['BONE'] = 'Bone County',
      ['ROBAD'] = 'Tierra Robada',
      ['GANTB'] = 'Gant Bridge',
      ['SF'] = 'San Fierro',
      ['RED'] = 'Red County',
      ['FLINTC'] = 'Flint County',
      ['EBAY'] = 'Easter Bay Chemicals',
      ['SILLY'] = 'Foster Valley',
      ['WHET'] = 'Whetstone',
      ['LAIR'] = 'Los Santos International',
      ['BLUF'] = 'Verdant Bluffs',
      ['ELCO'] = 'El Corona',
      ['LIND'] = 'Willowfield',
      ['MAR'] = 'Marina',
      ['VERO'] = 'Verona Beach',
      ['CONF'] = 'Conference Center',
      ['COM'] = 'Commerce',
      ['PER1'] = 'Pershing Square',
      ['LMEX'] = 'Little Mexico',
      ['IWD'] = 'Idlewood',
      ['GLN'] = 'Glen Park',
      ['JEF'] = 'Jefferson',
      ['CHC'] = 'Las Colinas',
      ['GAN'] = 'Ganton',
      ['EBE'] = 'East Beach',
      ['ELS'] = 'East Los Santos',
      ['JEF'] = 'Jefferson',
      ['LFL'] = 'Los Flores',
      ['LDT'] = 'Downtown Los Santos',
      ['MULINT'] = 'Mulholland Intersection',
      ['MUL'] = 'Mulholland',
      ['MKT'] = 'Market',
      ['VIN'] = 'Vinewood',
      ['SUN'] = 'Temple',
      ['SMB'] = 'Santa Maria Beach',
      ['ROD'] = 'Rodeo',
      ['RIH'] = 'Richman',
      ['STRIP'] = 'The Strip',
      ['DRAG'] = 'The Four Dragons Casino',
      ['PINK'] = 'The Pink Swan',
      ['HIGH'] = 'The High Roller',
      ['PIRA'] = 'Pirates in Men`s Pants',
      ['VISA'] = 'The Visage',
      ['JTS'] = 'Julius Thruway South',
      ['JTW'] = 'Julius Thruway West',
      ['RSE'] = 'Rockshore East',
      ['LOT'] = 'Come-A-Lot',
      ['CAM'] = 'The Camel`s Toe',
      ['ROY'] = 'Royal Casino',
      ['CALI'] = 'Caligula`s Palace',
      ['PILL'] = 'Pilgrim',
      ['STAR'] = 'Starfish Casino',
      ['ISLE'] = 'The Emerald Isle',
      ['OVS'] = 'Old Venturas Strip',
      ['KACC'] = 'K.A.C.C. Military Fuels',
      ['CREE'] = 'Creek',
      ['SRY'] = 'Sobell Rail Yards',
      ['LST'] = 'Linden Station',
      ['JTE'] = 'Julius Thruway East',
      ['LDS'] = 'Linden Side',
      ['JTN'] = 'Julius Thruway North',
      ['HGP'] = 'Harry Gold Parkway',
      ['REDE'] = 'Redsands East',
      ['VAIR'] = 'Las Venturas Airport',
      ['LVA'] = 'LVA Freight Depot',
      ['BINT'] = 'Blackfield Intersection',
      ['GGC'] = 'Greenglass College',
      ['BFLD'] = 'Blackfield',
      ['ROCE'] = 'Roca Escalante',
      ['LDM'] = 'Last Dime Motel',
      ['RSW'] = 'Rockshore West',
      ['RIE'] = 'Randolph Industrial Estate',
      ['BFC'] = 'Blackfield Chapel',
      ['PINT'] = 'Pilson Intersection',
      ['WWE'] = 'Whitewood Estates',
      ['PRP'] = 'Prickle Pine',
      ['SPIN'] = 'Spinybed',
      ['SASO'] = 'San Andreas Sound',
      ['FISH'] = 'Fisher`s Lagoon',
      ['GARV'] = 'Garver Bridge',
      ['KINC'] = 'Kincaid Bridge',
      ['LSINL'] = 'Los Santos Inlet',
      ['SHERR'] = 'Sherman Reservoir',
      ['FLINW'] = 'Flint Water',
      ['ETUNN'] = 'Easter Tunnel',
      ['BYTUN'] = 'Bayside Tunnel',
      ['BIGE'] = 'The Big Ear',
      ['PROBE'] = 'Lil` Probe Inn',
      ['VALLE'] = 'Valle Ocultado',
      ['LINDEN'] = 'Linden Station',
      ['UNITY'] = 'Unity Station',
      ['MARKST'] = 'Market Station',
      ['CRANB'] = 'Cranberry Station',
      ['YELLOW'] = 'Yellow Bell Station',
      ['SANB'] = 'San Fierro Bay',
      ['ELCA'] = 'El Castillo del Diablo',
      ['REST'] = 'Restricted Area',
      ['MONINT'] = 'Montgomery Intersection',
      ['ROBINT'] = 'Robada Intersection',
      ['FLINTI'] = 'Flint Intersection',
      ['SFAIR'] = 'Easter Bay Airport',
      ['MKT'] = 'Market',
      ['CUNTC'] = 'Avispa Country Club',
      ['HILLP'] = 'Missionary Hill',
      ['MTCHI'] = 'Mount Chiliad',
      ['YBELL'] = 'Yellow Bell Golf Course',
      ['VAIR'] = 'Las Venturas Airport',
      ['LDOC'] = 'Ocean Docks',
      ['STAR'] = 'Starfish Casino',
      ['BEACO'] = 'Beacon Hill',
      ['GARC'] = 'Garcia',
      ['PLS'] = 'Playa del Seville',
      ['STAR'] = 'Starfish Casino',
      ['RING'] = 'The Clown`s Pocket',
      ['LIND'] = 'Willowfield',
      ['WWE'] = 'Whitewood Estates',
      ['LDT'] = 'Downtown Los Santos'
    }
    if names[zone] == nil then return 'Íå îïðåäåëåíî' end
    return names[zone]
end
function kvadrat()
    local KV = {
        [1] = "À",
        [2] = "Á",
        [3] = "Â",
        [4] = "Ã",
        [5] = "Ä",
        [6] = "Æ",
        [7] = "Ç",
        [8] = "È",
        [9] = "Ê",
        [10] = "Ë",
        [11] = "Ì",
        [12] = "Í",
        [13] = "Î",
        [14] = "Ï",
        [15] = "Ð",
        [16] = "Ñ",
        [17] = "Ò",
        [18] = "Ó",
        [19] = "Ô",
        [20] = "Õ",
        [21] = "Ö",
        [22] = "×",
        [23] = "Ø",
        [24] = "ß",
    }
    local X, Y, Z = getCharCoordinates(playerPed)
    X = math.ceil((X + 3000) / 250)
    Y = math.ceil((Y * - 1 + 3000) / 250)
    Y = KV[Y]
    local KVX = (Y.."-"..X)
    return KVX
end
