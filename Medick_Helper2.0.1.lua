script_name('Medick Helper') -- Test Update
script_author('Src303')
script_version '2.0.1'
local dlstatus = require "moonloader".download_status
script_author('Mark_King')
local sf = require 'sampfuncs'
local key = require "vkeys"
local inicfg = require 'inicfg'
local a = require 'samp.events'
local sampev = require 'lib.samp.events'
local imgui = require 'imgui' -- загружаем библиотеку/
local encoding = require 'encoding' -- загружаем библиотеку
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
local helps = imgui.ImBool(false)
local obnova = imgui.ImBool(false)
local infbar = imgui.ImBool(false)
local updwindows = imgui.ImBool(false)
local tEditData = {
	id = -1,
	inputActive = false
}
encoding.default = 'CP1251' -- указываем кодировку по умолчанию, она должна совпадать с кодировкой файла. CP1251 - это Windows-1251
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
players1 = {'{ffffff}Ник\t{ffffff}Ранг'}
players2 = {'{ffffff}Дата принятия\t{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
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
    tar = 'Интерн',
	tarr = 'тэг',
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
	ftext('Medick Helper успешно загружен!',-1)
	ftext('Функции скрипта команда: /mh (настройки скрипта), F2 (главное меню) или ПКМ + Z (отыгровки).',-1)
	ftext('Перезагрузить скрипт если отключится, одновременно зажать CTRL + R.',-1)
  end
  if not doesDirectoryExist('moonloader/config/medick/') then createDirectory('moonloader/config/medick/') end
  if cfg == nil then
    sampAddChatMessage("{7e0059}Medick Help {7e0059}| Отсутсвует файл конфига, создаем.", -1)
    if inicfg.save(medick, 'medick/config.ini') then
      sampAddChatMessage("{7e0059}Medick Help {7e0059}| Файл конфига успешно создан.", -1)
      cfg = inicfg.load(nil, 'medick/config.ini')
    end
  end
  if not doesDirectoryExist('moonloader/lib/imcustom') then createDirectory('moonloader/lib/imcustom') end
  for k, v in pairs(libs) do
        if not doesFileExist('moonloader/lib/'..v) then
            downloadUrlToFile('https://raw.githubusercontent.com/WhackerH/kirya/master/lib/'..v, getWorkingDirectory()..'\\lib\\'..v)
            print('Загружается библиотека'..v)
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
  local frakc = proverkk:match('.+Организация%s+(.+)%s+Должность')
  local rang = proverkk:match('.+Должность%s+%d+ %((.+)%)%s+Работа')
  local telephone = proverkk:match('.+Телефон%s+(.+)%s+Законопослушность')
  rank = rang
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
  sampCreate3dTextEx(643, '{ffffff}None.{ff0000}угу!', 4294927974, 2337.8091,1669.0276,3040.9524, 3, true, -1, -1)
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
                ftext('По завершению введите команду еще раз.')
            else
                changetextpos = false
				inicfg.save(cfg, 'medick/config.ini') -- сохраняем все новые значения в конфиге
            end
        else
            ftext('Для начала включите Худ.')
        end
    end)
  sampRegisterChatCommand('ystav', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
     datetime = os.date("!*t",os.time()) 
if datetime.min == 00 and datetime.sec == 10 then 
sampAddChatMessage("Не забудьте оставить отчёт в теме на получение выплат.", -1) 
wait(1000)
end
    if #departament > 25 then table.remove(departament, 1) end
	if #smslogs > 25 then table.remove(smslogs, 1) end
	if #radio > 25 then table.remove(radio, 1) end
    if cfg == nil then
      sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Отсутсвует файл конфига, создаем.", -1)
      if inicfg.save(medick, 'medick/config.ini') then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Файл конфига успешно создан.", -1)
        cfg = inicfg.load(nil, 'medick/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| Быстрое меню")
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| Система повышений")
	end
          if valid and doesCharExist(ped) then
            local result, id = sampGetPlayerIdByCharHandle(ped)
            if result and wasKeyPressed(key.VK_Z) then --- Тут менять клавишу быстрого меню
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
		players2 = {'{ffffff}Дата принятия\t{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
		players1 = {'{ffffff}Ник\t{ffffff}Ранг'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{ffffff}В сети: "..gcount.." | {ae433d}Организация | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players2, "\n"), "x", _, 5) -- Показываем информацию.
		elseif krimemb then
			sampShowDialog(716, "{ffffff}В сети: "..gcount.." | {ae433d}Организация | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players1, "\n"), "x", _, 5) -- Показываем информацию.
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
        sampSendChat(string.format("/d %s, благодарю %s за %s. Цените!", frack, rpname, pric))
    else
        ftext("Введите: /blg [id] [Фракция] [Причина]", -1)
		ftext("Пример: транспортировку, спасение жизни, и т.д. ", -1)
    end
end

function dmch()
	lua_thread.create(function()
		statusc = true
		players3 = {'{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{9966cc}Medick Helper {ffffff}| {ae433d}Вне офиса {ffffff}| Time: "..os.date("%H:%M:%S"), table.concat(players3, "\n"), "x", _, 5) -- Показываем информацию.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		statusc = false
	end)
end

function dlog()
    sampShowDialog(97987, '{9966cc}Medick Help{ffffff} | Лог сообщений департамента', table.concat(departament, '\n'), '»', 'x', 0)
end
function slog()
    sampShowDialog(97987, '{9966cc}Medick Help{ffffff} | Лог SMS', table.concat(smslogs, '\n'), '»', 'x', 0)
end

function rlog()
    sampShowDialog(97988, '{9966cc}Medick Help{ffffff} | Лог Рации', table.concat(radio, '\n'), '»', 'x', 0)
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Главный Врач' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /vig [ID] [Причина]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Игрок с ID: "..id.." не подключен к серверу.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /vig [ID] [ПРИЧИНА]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - получает выговор по причине: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - получает выговор по причине: %s.", rpname, pric))
      end
  end
end
end
end
function ivig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' or  rank == 'Доктор' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /ivig [ID] [Причина]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Игрок с ID: "..id.." не подключен к серверу.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /ivig [ID] [ПРИЧИНА]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Получает строгий выговор по причине: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Получает строгий выговор по причине: %s.", rpname, pric))
      end
  end
end
end
end

function unvig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /unvig [ID] [Причина]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Игрок с ID: "..id.." не подключен к серверу.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
  
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Введите: /unvig [ID] [ПРИЧИНА]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Получает cнятие выговора по причине: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Получает cнятие выговора по причине: %s.", rpname, pric))
      end
  end
end
end
end

function where(params) -- запрос местоположения
   if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
	if params:match("^%d+") then
		params = tonumber(params:match("^(%d+)"))
		if sampIsPlayerConnected(params) then
			local name = string.gsub(sampGetPlayerNickname(params), "_", " ")
			 if cfg.main.tarb then
			    sampSendChat(string.format("/r [%s]: %s, доложите свое местоположение. На ответ 20 секунд.", cfg.main.tarr, name))
			else
			sampSendChat(string.format("/r %s, доложите свое местоположение. На ответ 20 секунд.", name))
			end
			else
			ftext('{FFFFFF} Игрок с данным ID не подключен к серверу или указан ваш ID.', 0x046D63)
		end
		else
		ftext('{FFFFFF} Используйте: /where [ID].', 0x046D63)
		end
		else
		ftext('{FFFFFF}Данная команда доступна с 7 ранга.', 0x046D63)
	end
end

function getrang(rangg)
local ranks = 
        {
		['1'] = 'Интерн',
		['2'] = 'Санитар',
		['3'] = 'Мед.брат',
		['4'] = 'Спасатель',
		['5'] = 'Нарколог',
		['6'] = 'Доктор',
		['7'] = 'Психолог',
		['8'] = 'Хирург',
		['9'] = 'Зам.Глав.Врача',
		['10'] = 'Глав.Врач'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
		        local _, handle = sampGetCharHandleBySampPlayerId(id)
				if doesCharExist(handle) then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
				if dist <= 5 then
				if cfg.main.male == true then  --- Мужская отыгровка
				sampSendChat('/me снял старый бейджик с человека напротив стоящего')
				wait(3000)
				sampSendChat('/me убрал старый бейджик в карман')
				wait(3000)
                sampSendChat(string.format('/me достал новый бейджик %s', ranks))
				wait(3000)
				sampSendChat('/me закрепил на рубашку человеку напротив новый бейджик')
				wait(3000)
				else
				sampSendChat('/me сняла старый бейджик с человека напротив стоящего')  --- Женская отыгровка
				wait(3000)
				sampSendChat('/me убрала старый бейджик в карман')
				wait(3000)
                sampSendChat(string.format('/me достала новый бейджик %s', ranks))
				wait(3000)
				sampSendChat('/me закрепила на рубашку человеку напротив новый бейджик')
				wait(3000)
				end
				end
				end
				sampSendChat(string.format('/giverank %s %s', id, rangg))
				wait(3000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s в должности до %s%s.', cfg.main.tarr, plus == '+' and 'Повышен(а)' or 'Понижен(а)', ranks, plus == '+' and ', Поздравляем!' or ''))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s в должности до %s%s.', plus == '+' and 'Повышен(а)' or 'Понижен(а)', ranks, plus == '+' and ', Поздравляем!' or ''))
				wait(3000)
				sampSendChat('/b /time 1 + F8, обязательно.')
            end
			else
			ftext('Вы ввели неверный тип [+/-]')
		end
		else
			ftext('Введите: /giverank [id] [ранг] [+/-]')
		end
		else
			ftext('Данная команда доступна с должности Психолог.')
	  end
	  else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID.')
	  end
   end)
 end
--[[
function fgiverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
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
				sampSendChat('/me снял старый бейджик с человека напротив стоящего')
				wait(3000)
				sampSendChat('/me убрал старый бейджик в карман')
				wait(3000)
                sampSendChat(string.format('/me достал новый бейджик %s', ranks))
				wait(3000)
				sampSendChat('/me закрепил на рубашку человеку напротив новый бейджик')
				wait(3000)
				else
				sampSendChat('/me сняла старый бейджик с человека напротив стоящего')
				wait(3000)
				sampSendChat('/me убрала старый бейджик в карман')
				wait(3000)
                sampSendChat(string.format('/me достала новый бейджик %s', ranks))
				wait(3000)
				sampSendChat('/me закрепила на рубашку человеку напротив новый бейджик')
				wait(3000)
				end
				end
				end
			else
			ftext('Вы ввели неверный тип [+/-].')
		end
		else
			ftext('Введите: /giverank [id] [ранг] [+/-]')
		end
		else
			ftext('Данная команда доступна с должности Доктор.')
	  end
	  else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID.')
	  end
   end)
 end
--]]
 function invite(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' or  rank == 'Хирург' or rank == 'Психолог' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me достал(а) бейджик интерна и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/invite %s', id))
				wait(2000)
				sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Принят(а) в Мининистерство Здравоохранения, Поздравляем', cfg.main.tarr))
			else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID.')
		end
		else
			ftext('Введите: /invite [id]')
		end
		else
			ftext('Данная команда доступна с должности Психолог.')
	  end
   end)
 end
 function fixcar()
    lua_thread.create(function()
	  if rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' or  rank == 'Хирург' or  rank == 'Психолог' then
        sampSendChat('/rb Спавн организационного транспорта через 15 секунд')
		wait(1000)
		sampSendChat('/rb  Займите свои кареты!')
		wait(1000)
		sampSendChat('/ffixcar')
	  end
   end)
 end
 function invitenarko(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' or  rank == 'Хирург' or rank == 'Психолог' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me достал(а) бейджик нарколога и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/invite %s', id))
				wait(6000)
				sampSendChat(string.format('/giverank %s 5', id))
				wait(2000)
				sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Принят на должность нарколога по заявлению, Поздравляем', cfg.main.tarr))
			else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID.')
		end
		else
			ftext('Введите: /invn [id]')
		end
		else
			ftext('Данная команда доступна с должности Психолог.')
	  end
   end)
 end
function zheal(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
        if id then
		if sampIsPlayerConnected(id) then
		        if cfg.main.male == false then --- Женская отыгровка
                sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat("/me достала из мед.сумки лекарство и бутылочку воды")
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat('/me передала лекарство и бутылочку воды '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat(string.format('/heal %s', id))
				end
				if cfg.main.male == true then --- Мужская отыгровка
				sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat("/me достал из мед.сумки лекарство и бутылочку воды")
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat('/me передал лекарство и бутылочку воды '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
                wait(cfg.commands.zaderjka * 1000)
				sampSendChat(string.format('/heal %s', id))
			    end
				end
		else
			ftext('Введите: /z [id]')
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
                submenus_show(ginvite(id), "{9966cc}Medick Helpers {ffffff}| Выбор отдела")
				else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID.')
            end
		else
			ftext('Включите автотег в настройках.')
		end
		else
			ftext('Рядом с вами нет данного игрока.')
	  end
	  else
			ftext('Рядом с вами нет данного игрока.')
	end
	  else
			ftext('Введите: /ginv [id]')
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
                submenus_show(zinvite(id), "{9966cc}Medick Helpers {ffffff}| Выбор отдела")
				else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID.')
            end
		else
			ftext('Включите автотег в настройках.')
		end
		else
			ftext('Рядом с вами нет данного игрока.')
	  end
	  else
			ftext('Рядом с вами нет данного игрока.')
	end
	  else
			ftext('Введите: /zinv [id]')
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
                submenus_show(oinvite(id), "{9966cc}Medick Helpers {ffffff}| Выбор отдела")
				else
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID.')
            end
		else
			ftext('Включите автотег в настройках.')
		end
		else
			ftext('Рядом с вами нет данного игрока.')
	  end
	  else
			ftext('Рядом с вами нет данного игрока.')
	end
	  else
			ftext('Введите: /oinv [id]')
	end
	  end)
   end
function uninvite(pam)
   lua_thread.create(function()
      local id, pri4ina = pam:match('(%d+)%s+(.+)')
      if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' then
        if id and pri4ina then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me забрал(а) бейджик у '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(2000)
				sampSendChat(string.format('/uninvite %s %s', id, pri4ina))
				wait(2000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Уволен(а) по причине "%s".', cfg.main.tarr, pri4ina))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Уволен(а) по причине "%s".', pri4ina))
            end
			else 
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
		end
		else 
			ftext('Введите: /uninvite [id] [причина]')
		end
		else 
			ftext('Данная команда доступна с 7 ранга')
	 end
  end)
end
 function zinvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Отдел SES",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Заместителя Главы Санитарно-Эпидемиологической-Станции и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 12.')
	wait(5000)
	sampSendChat('/b Тег в /r [Зам.Главы.SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Заместитель Санитарно-Эпидемиологической-Станции.', cfg.main.tarr))
	end
   },
   
   {
   title = "{80a4bf}» {FFFFFF}Отдел ПСБ",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Заместителя Главы Поисково-Спасательной Бригады и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(4000)
	sampSendChat('/b /clist 29.')
	wait(4000)
	sampSendChat('/b Тег в /r [Зам.Главы ПСБ]:')
	wait(4000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Заместитель Поисково-Спасательной Бригады.', cfg.main.tarr))
	end
   },
 }
end
function crpinv(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Начальник",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Начальника Control Room и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 15.')
	wait(7000)
	sampSendChat('/b Тег в /r [Chief CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Начальник Control Room.', cfg.main.tarr))
	end
   },
   
   {
   title = "{80a4bf}» {FFFFFF}Ст.Диспетчер",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Старшего Диспетчера Control Room и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 10.')
	wait(7000)
	sampSendChat('/b Тег в /r [Senior Dispatcher]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Ст.Диспетчер Control Room.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Диспетчер",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Диспетчера Control Room и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 11.')
	wait(7000)
	sampSendChat('/b Тег в /r [Dispatcher CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Диспетчер Control Room.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Сотрудник",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Сотрудника Control Room и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 16.')
	wait(7000)
	sampSendChat('/b Тег в /r [Employee CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Сотрудник Control Room.', cfg.main.tarr))
	end
   },
 }
end
function oinvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Отдел SES [Инспектор SES]",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Инспектора Санитарно-Эпидемиологичесой-Станции и передал его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 10.')
	wait(5000)
	sampSendChat('/b тег в /r [SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - повышается в долности на Инспектора Санитарно-Эпидемиологичесой-Станции.', cfg.main.tarr))
	end
   },
  {
   title = "{80a4bf}» {FFFFFF}Отдел SES",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Стажера Санитарно-Эпидемиологичесой-Станции и передал его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 19.')
	wait(5000)
	sampSendChat('/b Тег в /r [Cтажер SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый  сотрудник  Санитарно-Эпидемиологичесой-Станции.', cfg.main.tarr))
	end
   },

   -- {
   -- title = "{80a4bf}» {FFFFFF}Отдел УТУ",
    -- onclick = function()
	-- sampSendChat('/me достал(а) бейджик Сотрудника(цы) Учебно-Тренингово отделения и передал его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	-- wait(5000)
	-- sampSendChat('/b /clist 15.')
	-- wait(5000)
	-- sampSendChat('/b Тег в /r [УТУ]:')
	-- wait(5000)
	-- sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый  Сотрудник Отдела MA.', cfg.main.tarr))
	-- end
   -- },
   {
   title = "{80a4bf}» {FFFFFF}Отдел ПСБ [Инспектор ПСБ]",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Инспектора Поисково-Спасательной Бригады и передал его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 10.')
	wait(5000)
	sampSendChat('/b Тег в /r [ПСБ]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - повышается в долности на Инспектора Поисково-Спасательной Бригады.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Отдел ПСБ",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Стажера Поисково-Спасательной Бригады и передал его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 2.')
	wait(5000)
	sampSendChat('/b Тег в /r [Cтажер ПСБ]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый  сотрудник  Поисково-Спасательной Бригады.', cfg.main.tarr))
	end
   },
 }
end
function ginvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Отдел ПСБ Глава.",
    onclick = function()
	if rank == 'Зам.Глав.Врача' or  rank == 'Главный Врач' or  rank == 'Хирург' or  rank == 'Доктор' or  rank == 'Психолог' then
	sampSendChat('/me достал(а) бейджик Главы  Поисково-Спасательной Бригады и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 21.')
	wait(5000)
	sampSendChat('/b Тег в /r [Глава ПСБ]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Глава Поисково-Спасательной Бригады ', cfg.main.tarr))
	else
	ftext('Вы не можете назначить Главу данного отдела.')
	end
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Отдел SES Глава.",
    onclick = function()
	if rank == 'Зам.Глав.Врача' or  rank == 'Главный Врач' or  rank == 'Хирург' then
	sampSendChat('/me достал(а) бейджик Главы  Санитарно-Эпидемиологической-Станции и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 8.')
	wait(5000)
	sampSendChat('/b Тег в /r [Глава SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Глава Санитарно-Эпидемиологической-Станции ', cfg.main.tarr))
	else
	ftext('Вы не можете назначить Главу данного отдела.')
	end
	end
   },
 }
end
function fastmenu(id)
 return
{
  {
   title = "{80a4bf}»{FFFFFF} Лекции",
    onclick = function()
	submenus_show(fthmenu(id), "{9966cc}Medick Helper {0033cc}| Лекции")
	end
   },
    {
   title = "{80a4bf}»{FFFFFF} Собеседование {ff0000}(Ст.Состав)",
    onclick = function()
	if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' then
	submenus_show(sobesedmenu(id), "{9966cc}Medick Helper {0033cc}| Собеседование")
	else
	ftext('Вы не находитесь в старшем составе.')
	end
	end
   },
    {
   title = "{80a4bf}»{FFFFFF} Вопросы по уставу {ff0000}(Ст.Состав)",
    onclick = function()
	if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' then
	submenus_show(ustav(id), "{9966cc}Medick Helper {0033cc}| Вопросы по уставу")
	else
	ftext('Вы не находитесь в старшем составе.')
	end
	end
   },
    {
   title = "{80a4bf}»{FFFFFF} Меню {ffffff}гос.новостей {ff0000}(Ст.Состав)",
    onclick = function()
	if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' then
	submenus_show(govmenu(id), "{9966cc}Medick Helper {0033cc}| Меню гос.новостей")
	else
	ftext('Вы не находитесь в старшем составе.')
	end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Меню {ffffff}отделов  {ff0000}(Для глав отделов)",
    onclick = function()
	if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' or rank == 'Доктор' or rank == 'Нарколог' then
	submenus_show(otmenu(id), "{9966cc}Medick Helper {0033cc}| Меню отделов")
	else
	ftext('Данное меню доступно с должности Нарколог.')
	end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Вызвать сотрудника ПО в больницу (/d).",
    onclick = function()
	if rank == 'Мед.брат' or rank =='Спасатель' or rank =='Нарколог' or rank == 'Доктор' or rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' then
	sampSendChat(string.format('/d SAPD, вышлите сотрудника в больницу. Заранее спасибо.'))
	else
	ftext('Данная функция доступна с должности Мед.брат.')
	end
	end
   },
}
end

function otmenu(id)
 return
{
   {
   title = "{80a4bf}»{FFFFFF} Агитация {ffffff}EMS{ff0000} (Для глав/замов отдела)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Уважаемые коллеги, в отдел EMS проходит набор сотрудников.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Чтобы попасть в отдел EMS вам нужна должность "Спасателя" и выше.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: В отделе вас ждут опытные наставники которые помогут с обучением.".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Будете проходить 3 этапа чтобы попасть в основной состав отдела.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: За прохождение всех этапов будет выплачиваться 150.000$.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Научим вас как проводить СЛР, ИВЛ и первую медицинскую помощь.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Если вы хотите к нам в отдел, сообщите это любому из руковдоства EMS.', cfg.main.tarr))
    wait(5000)
	ftext("{FFFFFF}Вывод агитации завершен!")
	end
   },
}
end

function operacia(id)
    return
    {
      {
        title = '{ffffff}» Перелом руки/ноги №1.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me помогает пациенту дойти до операционного стола")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me надела перчатки на свои руки и закрыла шкаф")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me включив рентген-аппарат в сеть, навёла излучатели на пациента")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Снимок был готов.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла в свои руки снимок и начала его рассматривать")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Это закрытый перелом*показав пациенту пальцем на участок кости на рентгене.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me уложила пациента на операционный стол")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из шкафа эластичный бинт и положила его рядом")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me зафиксировала руку в неподвижном состоянии")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do В руке медицинская шина.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me наложила шину на место перелома без давления на сосуды")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try перевязала вокруг шины эластичный бинт прикладывая среднюю силу")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me помогает пациенту дойти до операционного стола")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me надел перчатки на свои руки и закрыл шкаф")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me включив рентген-аппарат в сеть, навёл излучатели на пациента")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Снимок был готов.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял в свои руки снимок и начал его рассматривать")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Это закрытый перелом*показав пациенту пальцем на участок кости на рентгене.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me уложил пациента на операционный стол")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из шкафа эластичный бинт и положил его рядом")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me зафиксировал руку в неподвижном состоянии")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do В руке медицинская шина.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me наложил шину на место перелома без давления на сосуды")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try перевязал вокруг шины эластичный бинт прикладывая среднюю силу")
		end
		end
      },
	  {
        title = '{5b83c2}« Если неудачно, то переходим к №2. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Перелом руки/ноги №2.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/do У пациента были эмоции на лице, показывающие его боль.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ослабила немного бинт, сбавляя свою силу")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try взглянула на лицо пациента и сила перевязки не доставляла ему боли")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/do У пациента были эмоции на лице, показывающие его боль.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ослабил немного бинт, сбавляя свою силу")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try взглянул на лицо пациента и сила перевязки не доставляла ему боли")
		end
		end
      },
	  {
        title = '{ffffff}» Пулевое ранение №1.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me подошла к шкафу, достала из него перчатки")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me помыла руки под краном, одела перчатки и закрыла шкаф")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Ложитесь, я вам окажу помощь*показав рукой на стол.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Кислородная маска висела перед лицом.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me прокрутила вентиль, подав тем самым наркоз")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do После подачи наркоза пациент уснул.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла со стола поднос с хирургическими инструментами")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me поставила поднос на табурет рядом с операционным столом")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me вколола шприц с 2 процентами Дибазола и ввёла обезболивающее")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла с подноса пинцет и пролезла им в рану")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me старается осторожно зацепить пулю пинцетом")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try изъяла пулю, нащупав её")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me подошёл к шкафу, достал из него перчатки")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me помыл руки под краном, одел перчатки и закрыл шкаф")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Ложитесь, я вам окажу помощь*показав рукой на стол.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Кислородная маска висела перед лицом.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me прокрутил вентиль, подав тем самым наркоз")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do После подачи наркоза пациент уснул.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял со стола поднос с хирургическими инструментами")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me поставил поднос на табурет рядом с операционным столом")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me вколол шприц с 2 процентами Дибазола и ввёл обезболивающее")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял с подноса пинцет и пролез им в рану")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me старается осторожно зацепить пулю пинцетом")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try изъял пулю, нащупав её")
		end
		end
      },
	  {
        title = '{5b83c2}« Если неудачно, то переходим к №2. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Пулевое ранение №2.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me цепляет пулю, делая это осторожно")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try изъяла пулю, нащупав её")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me цепляет пулю, делая это осторожно")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try изъял пулю, нащупав её")
		end
		end
      },
	  {
        title = '{5b83c2}« Если удачно, то переходим к №3. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Пулевое ранение №3.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me извлёкла пулю из человека и положила её на поднос")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла шёлковую иглу и продела нитку в ушко игры")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me начала накладывать швы, стягивая кожу у раны")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do После наложения швов, они были зафиксированы.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла ножницы и обрезала лишнюю ниточку")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработала место ранения антисептиком и сложила всё на поднос")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me извлёк пулю из человека и положил её на поднос")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял шёлковую иглу и продел нитку в ушко игры")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me начал накладывать швы, стягивая кожу у раны")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do После наложения швов, они были зафиксированы.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял ножницы и обрезал лишнюю ниточку")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработал место ранения антисептиком и сложил всё на поднос")
		end
		end
      },
	  {
        title = '{ffffff}» Ножевое ранение.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me подошла к шкафу, достала из него перчатки")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me помыв руки под краном, одела перчатки и закрыла шкаф")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Раздевайтесь, вещи положите сюда*показав рукой на стул.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Кислородная маска висела перед лицом.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me прокрутила вентиль, подав тем самым наркоз")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла со стола поднос с хирургическими инструментами")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me несёт поднос в руках и ставит поднос на табурет")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла с подноса шприц с раствором Дибазола")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me вколола шприц рядом с местом ранения")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Обезболивающее подействовало.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me начала накладывать швы, стянув кожу у раны")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me закончив наложение швов, затем зафиксировала их")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обрезала лишнюю нить ножницами и взяла антисептик")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработала швы антисептиком и сложила всё на поднос")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me подошёл к шкафу, достал из него перчатки")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me помыв руки под краном, одел перчатки и закрыл шкаф")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/todo Раздевайтесь, вещи положите сюда*показав рукой на стул.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Кислородная маска висела перед лицом.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me прокрутил вентиль, подав тем самым наркоз")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял со стола поднос с хирургическими инструментами")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me несёт поднос в руках и ставит поднос на табурет")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял с подноса шприц с раствором Дибазола")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me вколол шприц рядом с местом ранения")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Обезболивающее подействовало.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me начал накладывать швы, стянув кожу у раны")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me закончив наложение швов, затем зафиксировал их")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обрезал лишнюю нить ножницами и взял антисептик")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработал швы антисептиком и сложил всё на поднос")
		end
		end
      },
	  {
        title = '{ffffff}» Удаление аппендицита.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me подошла к шкафу, достала из него перчатки")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me помыла руки под краном, одела перчатки и закрыла шкаф")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Кислородная маска висела перед лицом.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me прокрутила вентиль, подав тем самым наркоз")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do После подачи наркоза пациент уснул.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла со стола поднос с хирургическими инструментами")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла с подноса дыхательную трубку и ввёла в трахею пациента")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me наметив маркером место надреза, затем сделала надрез")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла в руки пинцет и пролезла в надрез")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me зацепила пинцетом аппендикс и обрезала воспалённый орган")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me извлёкла аппендикс пинцетом из раны, убрала на поднос скальпель")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла со стола нить и иглу, потом продела нить в ушко")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me стянула ткани в слепой кишке и наложила швы")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me зафиксировав швы и отрезала нить ножницами")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Процесс наложения швов на тело пациента.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сложила всё на поднос и обработала")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положила всё на поднос, сняла перчатки")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработала место швов антисептиком")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me подошёл к шкафу, достал из него перчатки")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me помыл руки под краном, одел перчатки и закрыл шкаф")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Кислородная маска висела перед лицом.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me прокрутил вентиль, подав тем самым наркоз")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do После подачи наркоза пациент уснул.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял со стола поднос с хирургическими инструментами")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял с подноса дыхательную трубку и ввёл в трахею пациента")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me наметив маркером место надреза, затем сделал надрез")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял в руки пинцет и пролез в надрез")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me зацепил пинцетом аппендикс и обрезал воспалённый орган")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me извлёк аппендикс пинцетом из раны, убрал на поднос скальпель")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял со стола нить и иглу, потом продел нить в ушко")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me стянул ткани в слепой кишке и наложил швы")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me зафиксировав швы и отрезал нить ножницами")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Процесс наложения швов на тело пациента.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сложил всё на поднос и обработал")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положил всё на поднос, снял перчатки")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработал место швов антисептиком")
		end
		end
      },
    }
end

function sobesedmenu(id)
    return
    {
      {
        title = '{80a4bf}» {ffffff}Приветствие.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat('Здравствуйте. Я сотрудник больницы '..myname:gsub('_', ' ')..', вы на собеседование?')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/do На рубашке бейджик с надписью '..rank..' | '..myname:gsub('_', ' ')..'.')
		end
      },
      {
        title = '{80a4bf}» {ffffff}Документы.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Ваш паспорт и диплом, пожалуйста.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/b /showpass '..myid..'')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/b Диплом по РП.')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Заявление на оф.портал на Нарколога{ff0000} с 6 лет в штате.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Вы можете оставить заявление на оф.портале, на должность Нарколога, а можете сейчас на Интерна.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/b evolve-rp.su -> Игровой сервер Saint-Louis -> Государственные структуры -> Министерство Здравоохранения -> Заявление на должность « Мед.Брат » | « Нарколог »')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Или сейчас оставите заявление на интерна?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff} Изучение документов.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat('/me взяла документы у человека напротив, после начала их изучать')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me ознакомившись с документами, вернула их обратно')
        end
		if cfg.main.male == true then --- Мужская отыгровка
		sampSendChat('/me взял документы у человека напротив, после начал их изучать')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me ознакомившись с документами, вернул их обратно')
		end
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Расскажите немного о себе.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat('Хорошо, расскажите немного о себе.')
		wait(4000)
        end
      },
	  {
	     title = '{80a4bf}» {ffffff}Работали ли раньше в мон',
        onclick = function()
        sampSendChat('Работали раньше в Мининистерстве Здравоохранения?')
		wait(4000)
        end
      },
	  {
	   title = '{80a4bf}» {ffffff}Проблемы с законом.',
	   onclick = function()
	   sampSendChat('Имели раньше проблемы с законом?')
	   wait(4000)
	   end
      },
	  {
        title = '{80a4bf}» {ffffff}Cтресс на работе.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Как вы справляетесь со стрессом на работе?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Прошлая работа.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Что вас не устраивало на прошлой работе?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Зарплата.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('На какую зарплату вы расчитываете?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}РП термины.',
        onclick = function()
        sampSendChat('Что по вашему означают понятия как РП и ДМ?')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Что над головой.',
        onclick = function()
        sampSendChat('Что у меня над головой?')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Приказы руководства.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Как вы переносите приказы руководства?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}РП термины в /b.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('/b РП и ТК в /sms '..myid..'')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Вы приняты.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Поздравляю, вы нам подходите.')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Вы не приняты.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Прошу прощения, но вы нам не подходите. Покиньте собеседования.')
        end
	  },
    }
end

function govmenu(id)
 return
{
   {
   title = "{80a4bf}»{FFFFFF} Первая говка",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, заняла волну государственных новостей.")
		wait(1300)
		sampSendChat("/gov [Medic]: Уважаемые граждане и гости штата. Cейчас состоится приём в интернатуру Минздрава.")
        wait(7000)
        sampSendChat('/gov [Medic]: Требования: прописка в Штате от 3 лет, ответственность и адекватность.')
        wait(7000)
		sampSendChat('/gov [Medic]: Ждем вас в центральной больнице г. Los-Santos на втором этаже.')
		wait(7000)
        sampSendChat("/d OG, освободила волну государственных новостей.")
		wait(7000)
		sampAddChatMessage("{F80505}В обязательном порядке {F80505}добавьте {0CF513} /addvacancy.", -1)
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
   title = "{80a4bf}»{FFFFFF} Вторая говка",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, заняла волну государственных новостей.")
        wait(1300)
        sampSendChat("/gov [Medic] Уважаемые граждане и гости штата. Начался приём в интернатуру Минздрава.")
                wait(7000)
        sampSendChat('/gov [Medic] Ждем всех желающих в центральной больнице г. Los-Santos на втором этаже.')
                wait(7000)
	sampSendChat('/gov [Medic] Требования: прописка в Штате от 3 лет, ответственность и адекватность.')
	        wait(7000)
        sampSendChat("/d OG, освободила волну государственных новостей..")
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
   title = "{80a4bf}»{FFFFFF} Третяя говка",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, заняла волну государственных новостей.")
        wait(1300)
        sampSendChat("/gov [Medic] Уважаемые жители и гости штата. Напоминаю, что сейчас идет приём в Минздрав.")
        wait(7000)
        sampSendChat('/gov [Medic] Требования: прописка в Штате от 3 лет, ответственность и адекватность.')
        wait(7000)
	sampSendChat('/gov [Medic]: Для всех сотрудников, появилась возможность за 2 недели заработать 110 млн$')
		wait(7000)
        sampSendChat("/d OG, освободила волну государственных новостей.")
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
   title = '{80a4bf}»{FFFFFF} Четвертая говка',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat('/d OG, заняла волну государственных новостей.')
                wait(1300)
        sampSendChat('/gov [Medic] Уважаемые жители и гости штата. К сожалению приём в интернатуру Минздрава закончен.')
        wait(7000)
	sampSendChat('/gov [Medic] Вы можете оставить заявление на должность Мед.Брат-Нарколог, на офф.портале.')
		wait(7000)
        sampSendChat('/gov [Medic] Напоминаю, за прохождение курса подготовки врачей, Вы можете получить 110 млн$')
		wait(7000)
        sampSendChat('/d OG, освободила волну государственных новостей.')
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
		ftext("Вы ранее не получали входящих сообщений.", 0x046D63)
	end
end
function fthmenu(id)
 return
{
  {
        title = '{80a4bf}»{FFFFFF} Лекция для {139BEC}Интерна.',
    onclick = function()
	    sampSendChat('Приветствую! Вы успешно прошли собеседование и попали в медицинскую академию!')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Рабочий день в будние дни начинается с 10:00 по 20:00, в выходные дни..')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('.. с 11:00 по 19:00. Обеденный перерыв с 13:00 по 14:00.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сейчас я вам передам бейджик отделения МА.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me передала человеку напротив бейджик с надписью "МА"')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/b /clist 13.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Вы обязаны каждый раз проговаривать свое отделение в рацию.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/b /r [MA]: Текст.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ваши основные обязанности это: патрулирование штата, стоять на постах.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ваша первоначальная заработная плата составляет - 9.750 вирт.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('С каждым повышением зарплата будет расти.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Так.. Давайте я вам расскажу про посты.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Основные посты - Мэрия, Мост ЛС-СФ / ЛС-ЛВ, Автовокзал LS / SF / LV, автошкола.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Когда ты заступил, находишся, покидаешь пост, об этом обязан(а) сообщить в рацию!')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Например, давайте возьмём пост Мэрия.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Выезжаю на пост - Мэрия | Напарник -.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Заступил на пост - Мэрия | Вылечено граждан - | Принято вызовов -.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Покидаю пост - Мэрия | Причина -.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ваше повышение произойдет завтра. Завтра вы должны сдать следующее:')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('- Ответить на 5 вопросов из устава больницы .')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('- Знать кабинеты, транспорт, посты, график работы больницы;')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Я вам рассказал(а) основную информацию. Если у вас есть вопросы - задавайте.')
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
   title = '{80a4bf}»{FFFFFF} Первая помощь при {139BEC}кровотечениях.',
    onclick = function()
       sampSendChat('Приветствую, коллеги. Сегодня я прочту вам лекцию на тему «Первая помощь при кровотечении».')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Нужно четко понимать, что артериальное кровотечение представляет смертельную опасность для жизни.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Первое, что требуется – перекрыть сосуд выше поврежденного места.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Для этого прижмите артерию пальцами и срочно готовьте жгут.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Используйте в таком случае любые подходящие средства:')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Шарф, платок, ремень, оторвите длинный кусок одежды.') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Стягивайте жгут до тех пор, пока кровь не перестанет сочиться из раны.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('В случае венозного кровотечения действия повторяются, за исключением того, что..') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..жгут накладывается чуть ниже повреждённого места.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Следует помнить, что при обоих видах кровотечения жгут накладывается не более двух часов..') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..в жаркую погоду и не более часа в холодную.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('При капиллярном кровотечении следует обработать поврежденное место перекисью водорода..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..и наложить пластырь, либо перебинтовать рану. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Спасибо за внимание.')
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
  title = '{80a4bf}»{FFFFFF} Первая помощь при {139BEC}обмороках.',
    onclick = function()
      sampSendChat('Приветствую, коллеги. Сегодня я прочту вам лекцию на тему «Первая помощь при обмороках».')
      wait(cfg.commands.zaderjka * 5000)
      sampSendChat('Обмороки сопровождаются кратковременной потерей сознания, вызванной..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..недостаточным кровоснабжением мозга. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Обморок могут вызвать: резкая боль, эмоциональный стресс, ССБ и так далее.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Бессознательному состоянию обычно предшествует резкое ухудшение самочувствия..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..нарастает слабость, появляется тошнота, головокружение, шум или звон в ушах.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Затем человек бледнеет, покрывается холодным потом и внезапно теряет сознание.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Первая помощь должна быть направлена на улучшение кровоснабжения мозга..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..и обеспечение свободного дыхания.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Если пострадавший находится в душном, плохо проветренном помещении, то..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..откройте окно, включите вентилятор или вынесите потерявшего сознание на воздух.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Протрите его лицо и шею холодной водой, похлопайте по щекам и..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..дайте пострадавшему понюхать ватку, смоченную нашатырным спиртом.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Спасибо за внимание.')
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
    title = '{80a4bf}»{FFFFFF} Первая помощь при {139BEC}ДТП.',
    onclick = function()
       sampSendChat('Приветствую, коллеги. Сегодня я прочту вам лекцию на тему «Первая помощь при ДТП».')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Оказывая первую помощь, необходимо действовать по правилам.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Немедленно определите характер и источник травмы.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Наиболее частые травмы в случае ДТП - сочетание повреждений черепа..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..и нижних конечностей и грудной клетки.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Необходимо извлечь пострадавшего из автомобиля, осмотреть его.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Далее следует оказать первую помощь в соответствии с выявленными травмами.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Выявив их, требуется перенести пострадавшего в безопасное место..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..укрыть от холода, зноя или дождя и вызвать врача, а затем..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..организовать транспортировку пострадавшего в лечебное учреждение.') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Спасибо за внимание.')
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
    title = '{80a4bf}»{FFFFFF} Лекция для {139BEC}Нарколога.',
    onclick = function()
	    sampSendChat('Здраствуйте. На должности Нарколог носим свои бэйджики №18.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сеансы от наркозависимости производятся специализированными препаратами.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сеансы проводятся только в операционной на втором этаже больнице ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Так же вы теперь должны будете помогать на призывах. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Чтобы повысится в должности, вам нужно будет пройти школу Спасателей, школа состоит из 6-и этапов. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Подробней на официальном сайте Министерства Здравоохранения. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('На этом лекция окончена. Вопросы имееются? ')
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
    title = '{80a4bf}»{FFFFFF} Лекция о {139BEC}вреде курения.',
    onclick = function()
	    sampSendChat('Теперь я расскажу вам о вреде курения.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Курение - одна из самых знаменитых и распространенных привычек на сегодняшний день.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Запомните, господа, несколько вещей.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Курение вызывает рак и хроническое заболевание легких.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Также, табачный дым вызывает у некоторых людей всяческие кожные заболевания.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Брось сигарету - спаси себя и весь мир.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('На этом все, помните, Министерство Здравоохранения заботится о вашем здоровье.')
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
    title = '{80a4bf}»{FFFFFF} Лекция о том {139BEC} как нужно обращаться с пациентами.',
    onclick = function()
	    sampSendChat('Теперь лекция, о том, как нужно обращаться с пациентами.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Для начала, вы должны вежливо их поприветствовать, что бы им было приятно.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Дальше, вы должны представиться, и спросить чем можете помочь.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Если же человек молчит, не уходите, может думает что выбрать.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Когда человек задал вопрос, вы должны корректно ответить.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Если же вопрос грубый, неадекватный, не отвечайте.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('При угрозе и неадекватных действиях - вызовите полицию.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Спасибо за внимание, данная лекция подошла к концу.')
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
    title = '{80a4bf}»{FFFFFF} Лекция о {139BEC} наркотических препаратах',
    onclick = function()
	    sampSendChat('Здравствуйте, уважаемые коллеги.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сейчас я расскажу вам о вреде наркотических веществ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Наркотики - это вещества, способные вызывать состояние эйфории.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Наркомания - заболевание, вызванное употреблением наркотических веществ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('В среде употребляющих наркотики, выше риск заражения различными заболеваниями.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Каждому по силам помочь бороться с наркоманией.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Коллеги, обретайте уверенность в том, что вам не нужны наркотики.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('На этом лекция окончена, спасибо за внимание.')
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
    title = '{80a4bf}»{FFFFFF} Лекция о {139BEC} вирусах.',
    onclick = function()
	    sampSendChat('Сейчас я расскажу вам несколько советов о вирусах.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Все мы знаем о вирусах и о их быстром размножении.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Вирусы опасны. И чаще всего приводят к летальным исходам.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Господа, запомните несколько советов от Мининистерства Здравоохранения.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Первое, если вы заражены, не контактируйте со здоровым.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Второе, обычный поцелуй может заразить вашу вторую половинку.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('И третье, чаще мойте руки. Особенно, если вас окружают больные коллеги.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('На этом все, помните, врачи штата заботится о вашем здоровье.')
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
    title = '{80a4bf}»{FFFFFF} Лекция{139BEC} ПМП.',
    onclick = function()
	sampSendChat('Здраствуйте, уважаемые коллеги.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Большинство людей, оказавшись на месте теракта, впадают в панику и не знают, что им делать до приезда медиков.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('А между тем дорога буквально каждая минута, главное – понимать, как правильно оказать первую помощь.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Остановить кровотечение, не промывать рану, не извлекать инородные тела и глубоко дышать...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...вот основные действия, которые могут помочь пострадавшим при теракте.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Длительность факта изоляции человека специалисты считают ключевым моментом...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...для состояния пострадавших. Оптимально она не должна превышать 30 минут.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Если дольше — у тяжелых пострадавших могут развиться опасные для жизни осложнения или просто наступит смерть.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Известно, что в связи с несвоевременным оказанием медицинской помощи при катастрофах, инцидентах, любых происшествиях, где есть пострадавшие...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...в течение первого часа погибает до 30% пострадавших, через три часа — до 70% а через шесть часов — до 90%.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Эти цифры показывают: первая помощь при терактах нужна чем скорее, тем лучше, до приезда медиков.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('На месте катастрофы или теракта вам надо справиться с тремя проблемами, которые убивают людей быстрее всего:')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('- внешняя угроза;')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('- сильное кровотечение;')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('- проблемы с дыханием.')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Их надо ликвидировать в той же приоритетности. Вам надо сфокусироваться лишь на этих трёх вещах и количество выживших будет максимально.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Первая помощь — это комплекс срочных мер, направленных на спасение жизни человека.')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Несчастный случай, резкий приступ заболевания, отравление — в этих и других чрезвычайных ситуациях необходима грамотная первая помощь...')
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
    imgui.Begin(fa.ICON_COGS .. u8 ' Настройки##1', first_window, btn_size, imgui.WindowFlags.NoResize)
	imgui.PushItemWidth(200)
	imgui.AlignTextToFramePadding(); imgui.Text(u8("Использовать автотег"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Использовать автотег', tagb) then
    cfg.main.tarb = not cfg.main.tarb
    end
	if tagb.v then
	if imgui.InputText(u8'Введите ваш тег.', tagfr) then
    cfg.main.tarr = u8:decode(tagfr.v)
    end
	end
	imgui.Text(u8("Включить худ"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Включить/выключить худ', hudik) then
        cfg.main.givra = not cfg.main.givra
		ftext(cfg.main.givra and 'Худ включен, установить положение /sethud.' or 'Худ выключен.')
    end
	imgui.Text(u8("Быстрый ответ на последнее СМС"))
	imgui.SameLine()
    if imgui.HotKey(u8'##Быстрый ответ смс', config_keys.fastsms, tLastKeys, 100) then
	    rkeys.changeHotKey(fastsmskey, config_keys.fastsms.v)
		ftext('Клавиша успешно изменена. Старое значение: '.. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. ' | Новое значение: '.. table.concat(rkeys.getKeysName(config_keys.fastsms.v), " + "))
		saveData(config_keys, 'moonloader/config/medick/keys.json')
	end
	imgui.Text(u8("Использовать автоклист"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Использовать автоклист', clistb) then
        cfg.main.clistb = not cfg.main.clistb
    end
    if clistb.v then
        if imgui.SliderInt(u8"Выберите значение клиста", clistbuffer, 0, 33) then
            cfg.main.clist = clistbuffer.v
        end
		imgui.Text(u8("Использовать отыгровку раздевалки"))
	    imgui.SameLine()
		if imgui.ToggleButton(u8'Использовать отыгровку раздевалки', clisto) then
        cfg.main.clisto = not cfg.main.clisto
        end
    end
	imgui.Text(u8("Мужские отыгровки"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Мужские отыгровки', stateb) then
        cfg.main.male = not cfg.main.male
    end
	
	if imgui.SliderInt(u8'Задержка в лекциях и отыгровках(сек)', waitbuffer, 1, 25) then
     cfg.commands.zaderjka = waitbuffer.v
    end
	imgui.Text(u8("Автоскрин лекций/гос.новостей"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Автоскрин лекций', autoscr) then
        cfg.main.hud = not cfg.main.hud
    end
    if imgui.CustomButton(u8('Сохранить настройки'), imgui.ImVec4(0.08, 0.61, 0.92, 0.40), imgui.ImVec4(0.08, 0.61, 0.92, 1.00), imgui.ImVec4(0.08, 0.61, 0.92, 0.76), btn_size) then
	ftext('Настройки успешно сохранены.', -1)
    inicfg.save(cfg, 'medick/config.ini') -- сохраняем все новые значения в конфиге
    end
    imgui.End()
   end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Medic Tools | Устав больницы'), ystwindow)
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
	if imgui.Button(u8'Биндер', imgui.ImVec2(50, 30)) then
      bMainWindow.v = not bMainWindow.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_COGS .. u8' Настройки скрипта', imgui.ImVec2(141, 30)) then
      first_window.v = not first_window.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_REFRESH .. u8' Перезагрузить скрипт', imgui.ImVec2(155, 30)) then
      showCursor(false)
      thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_WRENCH .. u8' Информация о обновлениях', imgui.ImVec2(192, 30)) then
      obnova.v = not obnova.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_INFO .. u8 ' Помощь', imgui.ImVec2(70, 30)) then
      helps.v = not helps.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_LINE_CHART .. u8' Система повышений', imgui.ImVec2(155, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/283444/"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_BOOK .. u8' Устав', imgui.ImVec2(70, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/285201/"')
    btn_size = not btn_size
    end
	imgui.Separator()
	imgui.BeginChild("Информация", imgui.ImVec2(410, 150), true)
	imgui.Text(u8 'Имя и Фамилия:   '..sampGetPlayerNickname(myid):gsub('_', ' ')..'')
	imgui.Text(u8 'Должность:') imgui.SameLine() imgui.Text(u8(rank))
	imgui.Text(u8 'Номер телефона:   '..tel..'')
	if cfg.main.tarb then
	imgui.Text(u8 'Тег в рацию:') imgui.SameLine() imgui.Text(u8(cfg.main.tarr))
	end
	if cfg.main.clistb then
	imgui.Text(u8 'Номер бейджика:   '..cfg.main.clist..'')
	end
	imgui.EndChild()
	imgui.Separator()
		--for i, value in ipairs(themes.colorThemes) do
		--	if imgui.RadioButton(value, checked_radio, i) then
		--		themes.SwitchColorTheme(i)
		--	end
		--end
	imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Текущая дата: %s")).x)/1.5)
	imgui.Text(u8(string.format("Текущая дата: %s", os.date())))
	
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
            imgui.Text((u8"Информация: %s [%s] | Пинг: %s"):format(myname, myid, myping))
			    imgui.Text((u8 'Время: %s'):format(os.date('%H:%M:%S')))
            if valid and doesCharExist(ped) then 
                local result, id = sampGetPlayerIdByCharHandle(ped)
                if result then
                    local targetname = sampGetPlayerNickname(id)
                    local targetscore = sampGetPlayerScore(id)
                    imgui.Text((u8 'Цель: %s [%s] | Уровень: %s'):format(targetname, id, targetscore))
                else
                    imgui.Text(u8 'Цель: Нет')
                end
            else
                imgui.Text(u8 'Цель: Нет')
            end
			local cx, cy, cz = getCharCoordinates(PLAYER_PED)
			local zcode = getNameOfZone(cx, cy, cz)
			imgui.Text((u8 'Локация: %s | Квадрат: %s'):format(u8(getZones(zcode)), u8(kvadrat())))
			imgui.Text((u8 'Вылечено: %s | Вылечено от нарко: %s'):format((health), u8(narkoh)))
            inicfg.save(cfg, 'medick/config.ini')
            imgui.End()
        end
    if obnova.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                 imgui.Begin(fa.ICON_WRENCH .. u8'Обновления.', obnova, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Обновления.", imgui.ImVec2(540, 250), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 'Что было сделано:')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.2')
				imgui.BulletText(u8 '1.Команда /z - Для лечения в автомобиле.')
				imgui.BulletText(u8 '2.Полностью переписана Менюшка Пкм+Z.')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.3')
				imgui.BulletText(u8 '1.Удалено проктически все что связнано с Medick Helper.')
                imgui.BulletText(u8 '2.Переработаны задержки всех отыгровок.')
				imgui.BulletText(u8 '3.Устранены мелкие баги и проблемы с текстом.')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.4')
				imgui.BulletText(u8 '1.Изменен цвет интерфейса')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.5')
				imgui.BulletText(u8 '1.Теперь гл.меню открывается на /mh')
				imgui.BulletText(u8 '2.Добавлено в меню Пкм+Z меню собеседования')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.7')
				imgui.BulletText(u8 '1.Переработан полностью /sethud')
				imgui.Separator()
				imgui.BulletText(u8 'v3.0')
				imgui.BulletText(u8 '1.Теперь убрано ВСЕ что остовалось от Instructors helper.')
				imgui.BulletText(u8 '2.В меню Пкм+Z добавлена проверка на вирус.')
				imgui.BulletText(u8 '3.Добавлены новые лекции и Gov.')
				imgui.Separator()
				imgui.BulletText(u8 'v3.2')
				imgui.BulletText(u8 '1.Возвращена настройка задержки в Настройках скрипта.')
				imgui.BulletText(u8 '2.Добавлены новые лекции и методы лечения.')
				imgui.BulletText(u8 '3.Доработаны задержки.')
                imgui.Separator()
				imgui.BulletText(u8 'v3.8')
				imgui.BulletText(u8 '1.Добавлены логи "/smslog" и "/rlog".')
				imgui.BulletText(u8 '2.Полностью изменен интерфейс.')
				imgui.BulletText(u8 '3.Добавлены новые лекции, мелкие изменения по тексту.')
				imgui.BulletText(u8 '4.Добавлена кастомизация интерфейса.')
				imgui.BulletText(u8 '5.Немного изменен Худ.')
				imgui.Separator()
				imgui.BulletText(u8 'v3.8.1')
				imgui.BulletText(u8 '1.Сделал reboot скрипта на версию v3.7" ')
				imgui.BulletText(u8 '2.Вернул интерфейс, убрал кастомизацию.')
				imgui.BulletText(u8 '3.Добавлены новые лекции, изменены отделы.')
				imgui.BulletText(u8 '4.Исправлен "/smslog".')
				imgui.BulletText(u8 '5.Исправлен биндер.')
				imgui.BulletText(u8 '5.Изменен интерфейс.')
				imgui.Separator()
				imgui.BulletText(u8 'Связь и предложения:')
				imgui.BulletText(u8('ВК (кликабельно).'))
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
                imgui.Begin(fa.ICON_INFO .. u8 'Помощь по скрипту.', helps, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Список команд", imgui.ImVec2(495, 230), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '/mh - Открыть меню скрипта.')
                imgui.Separator()
				imgui.BulletText(u8 '/z [id] - Вылечить пациента в авто.')
				imgui.BulletText(u8 '/vig [id] [Причина] - Выдать выговор по рации.')
				imgui.BulletText(u8 '/unvig [id] [Причина] - Снять выговор по рации.')
                imgui.BulletText(u8 '/dmb - Открыть /members в диалоге.')
				imgui.BulletText(u8 '/oinv[id] - Принять человека в отдел.')
				imgui.BulletText(u8 '/zinv[id] - Назначить человека Заместителем отдела.')
				imgui.BulletText(u8 '/ginv[id] - Назначить человека Главой отдела.')
                imgui.BulletText(u8 '/where [id] - Запросить местоположение по рации.')
                imgui.BulletText(u8 '/ystav - Открыть устав больницы.')
				imgui.BulletText(u8 '/smsjob - Вызвать на работу весь мл.состав по смс.')
                imgui.BulletText(u8 '/dlog - Открыть лог 25 последних сообщений в департамент.')
				imgui.BulletText(u8 '/sethud - Установить позицию инфо-бара.')
				imgui.Separator()
                imgui.BulletText(u8 'Клавиши: ')
                imgui.BulletText(u8 'ПКМ+Z на игрока - Меню взаимодействия.')
                imgui.BulletText(u8 'F2 - "Быстрое меню."')
				imgui.EndChild()
                imgui.End()
    end
  if bMainWindow.v then
  local iScreenWidth, iScreenHeight = getScreenResolution()
	local tLastKeys = {}
   
   imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.SetNextWindowSize(imgui.ImVec2(800, 530), imgui.Cond.FirstUseEver)

   imgui.Begin(u8("IT | Биндер##main"), bMainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
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
				imgui.TextDisabled(u8("Пустое сообщение ..."))
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
			imgui.Checkbox(u8("Ввод") .. "##editCH" .. k, bIsEnterEdit)
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

	if imgui.Button(u8"Добавить клавишу") then
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

function showHelp(param) -- "вопросик" для скрипта
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
        ftext('Введите /r [текст].')
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
        title = "{80a4bf}»{ffffff} Меню врача.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{80a4bf}» {ffffff}Вылечить",
        onclick = function()
        pID = tonumber(args)
        submenus_show(oformenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{80a4bf}» {ffffff}Призыв меню.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(priziv(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{80a4bf}» {ffffff}Выдача справки в ПД",
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
	    sampSendChat("/me достает чистый бланк")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me достаёт ручку из нагрудного кармана")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("Страдаете ли вы какими-либо заболеваниями?")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me сделала пометку в бланке")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me поставила печать Годен")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/do Мед.карта в руках")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me передала мед.карту")
		end
		if cfg.main.male == true then --- Мужская отыгровка
	    sampSendChat("/me достает чистый бланк")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me достаёт ручку из нагрудного кармана")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("Страдаете ли вы какими-либо заболеваниями?")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me сделал пометку в бланке")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me поставил печать Годен")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/do Мед.карта в руках")
        wait(cfg.commands.zaderjka * 1000)
	    sampSendChat("/me передал мед.карту")
		end
		end
      },
	  {
        title = "{ffffff}» Меню рентгена, порезов, переломов.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(renmenu(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Медицинский осмотр.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(medosmotr(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Первая мед.помощь.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(medpomosh(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Раздел операций",
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
        title = '{5b83c2}« Раздел устава. »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Сколько минут дается сотруднику, чтобы прибыть на работу и переодеться в рабочую форму?',
        onclick = function()
        sampSendChat("Сколько минут дается сотруднику, чтобы прибыть на работу и переодеться в рабочую форму?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}15 минут.", -1)
		end
      },
      {
        title = '{80a4bf}» {ffffff}С какой должности разрешено использовать волну департамента в качестве переговоров?',
        onclick = function()
        sampSendChat("С какой должности разрешено использовать волну департамента в качестве переговоров?")
		wait(500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}С должности Мед.Брата.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}С какой должности разрешено выезжать в наземный патруль штата?',
        onclick = function()
        sampSendChat(" С какой должности разрешено выезжать в наземный патруль штата?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}С должности Мед.Брата.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}С какой должности разрешено использовать воздушно-транспортное средство?',
        onclick = function()
        sampSendChat("С какой должности разрешено использовать воздушно-транспортное средство?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}С должности Психолога, по разрешению {ff0000}рук-ва с Доктора.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Какие заведения запрещено посещать во время рабочего дня?',
        onclick = function()
        sampSendChat("Какие заведения запрещено посещать во время рабочего дня?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Автобазар, Казино.", -1)
		end
      },
	  {
        title = '{5b83c2}« Раздел вопросов по медикаментам. »',
        onclick = function()
        end
	  },
	  {
        title = '{80a4bf}» {ffffff}Какие мед.препараты вы выпишите от боли в животе?',
        onclick = function()
        sampSendChat("Какие мед.препараты вы выпишите от боли в животе?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Но-шпа, Дротаверин, Кеторолак, Спазмалгон, Кетанов.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Какие мед.препараты вы выпишите при боли в голове?',
        onclick = function()
        sampSendChat("Какие мед.препараты вы выпишите при боли в голове?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Аспирин, Анальгин, Цитрамон, Диклофенак, Пенталгин.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Какие мед.препараты вы выпишите от боли в горле?',
        onclick = function()
        sampSendChat("Какие мед.препараты вы выпишите от боли в горле?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Гексализ, Фалиминт, Стрепсилс.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Какие мед.препараты вы выпишите от температуры?',
        onclick = function()
        sampSendChat("Какие мед.препараты вы выпишите от температуры?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Парацетамол, Нурофен, Ибуклин, Ринза.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Какие мед.препараты вы выпишите при кашле?',
        onclick = function()
        sampSendChat("Какие мед.препараты вы выпишите при кашле?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Амбробене, Амброгексал, АЦЦ, Бромгексин, Доктор МОМ.", -1)
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
        title = '{80a4bf}» {ffffff}Приветствие.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Здравствуйте. Я сотрудник больницы "..myname:gsub('_', ' ')..", чем могу помочь?")
        wait(1000)
		sampSendChat('/do На рубашке бейджик с надписью '..rank..' | '..myname:gsub('_', ' ')..'.')
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Попрощаться с клиентом.',
        onclick = function()
        sampSendChat("Всего вам доброго.")
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
        title = '{80a4bf}» {ffffff}Голова',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
		  sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
          wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me достала из мед.сумки лекарство и бутылочку воды")
          wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Парацетамол в руке")
          wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me передала лекарство и бутылочку воды '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
          wait(1000)
		  sampSendChat("/heal "..id) 
        end
        if cfg.main.male == true then --- Мужская отыгровка
		  sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
          wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me достал из мед.сумки лекарство и бутылочку воды")
          wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Парацетамол в руке")
          wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me передал лекарство и бутылочку воды '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
          wait(1000)
		  sampSendChat("/heal "..id) 
        end
		end
      },
      {
        title = '{80a4bf}» {ffffff}Живот',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
		  sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me достала из мед.сумки лекарство и бутылочку воды")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Нош-па в руке")
	      wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me передала лекарство и бутылочку воды '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	      wait(1000)
		  sampSendChat("/heal "..id) 
        end
        if cfg.main.male == true then --- Мужская отыгровка
		  sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me достал из мед.сумки лекарство и бутылочку воды")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Нош-па в руке")
	      wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me передал лекарство и бутылочку воды '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	      wait(1000)
		  sampSendChat("/heal "..id) 
        end
		end
      },
      {
        title = '{80a4bf}» {ffffff}Горло',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
		  sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me достала из мед.сумки лекарство и бутылочку воды")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Стопангин в руке")
	      wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me передала лекарство и бутылочку воды '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	      wait(1000)
		  sampSendChat("/heal "..id) 
		end
        if cfg.main.male == true then --- Мужская отыгровка
		  sampSendChat("/do Через плечо врача накинута мед. сумка на ремне.")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/me достал из мед.сумки лекарство и бутылочку воды")
	      wait(cfg.commands.zaderjka * 1000)
          sampSendChat("/do Стопангин в руке")
	      wait(cfg.commands.zaderjka * 1000)
		  sampSendChat('/me передал лекарство и бутылочку воды '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1000)
		  sampSendChat("/heal "..id) 
        end
        end
		},
	    {
        title = '{80a4bf}» {ffffff}Лечение от наркозависимости.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
		sampSendChat("/do Через плечо врача накинута мед.сумка на ремне.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из мед.сумки шприц.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/do Шприц в левой руке.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/me обработала ватой место укола на вене '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/me аккуратным движением вводит препарат в вену '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/todo Ну вот и всё*вытащив шприц из вены и приложив вату к месту укола.")
        wait(1000)
        sampSendChat("/healaddict " .. id .. "  10000")
		end
		if cfg.main.male == true then --- Мужская отыгровка
		sampSendChat("/do Через плечо врача накинута мед.сумка на ремне.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из мед.сумки шприц.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/do Шприц в левой руке.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/me обработал ватой место укола на вене '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/me аккуратным движением вводит препарат в вену '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/todo Ну вот и всё*вытащив шприц из вены и приложив вату к месту укола.")
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
        title = '{5b83c2}« При закрытых/открытых переломах: »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« При закрытом переломе руки/ноги: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Для начала вы должны ввести анальгетик через шприц в вену пострадавшего.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положила медицинский кейс на пол и открыла его")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do В кейсе лежат: стерильные шприцы, ампула с анальгетиком, шина, бинты")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала стерильный шприц с ампулой, аккуратно приоткрыла ампулу с анальгетиком")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me перелила содержимое ампулы в шприц")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me закатала рукав пострадавшего, после чего ввёла анальгетик через шприц в вену, вдавив поршень")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Анальгетик проник в организм пострадавшего.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрала использованный шприц в медицинскую сумку")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положил медицинский кейс на пол и открыл его")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do В кейсе лежат: стерильные шприцы, ампула с анальгетиком, шина, бинты")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал стерильный шприц с ампулой, аккуратно приоткрыл ампулу с анальгетиком")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me перелил содержимое ампулы в шприц")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me закатал рукав пострадавшего, после чего ввёл анальгетик через шприц в вену, вдавив поршень")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Анальгетик проник в организм пострадавшего.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрал использованный шприц в медицинскую сумку")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Следует быстро наложить шину.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me достала из кейса шину, затем принялась накладывать её на повреждённую конечность")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me аккуратно наложила шину на повреждённую конечность")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Шина качественно наложена на повреждённую конечность.")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me достал из кейса шину, затем принялcz накладывать её на повреждённую конечность")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me аккуратно наложил шину на повреждённую конечность")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Шина качественно наложена на повреждённую конечность.")
		end
		end
      },
	  {
        title = '{ffffff}» 3) Нужно срочно иммобилизировать повреждённую конечность с помощью косынки.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me взяла из кейса стерильные бинты и сделала косынку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me подвесила повреждённую конечность в согнутом положении")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Повреждённая конечность иммобилизована. ")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me взял из кейса стерильные бинты и сделал косынку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me подвесил повреждённую конечность в согнутом положении")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Повреждённая конечность иммобилизована. ")
		end
		end
      },
	  {
        title = '{5b83c2}« При открытом переломе руки/ноги: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Для начала вы должны ввести анальгетик через шприц в вену пострадавшего.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положила медицинский кейс на пол и открыла его")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do В кейсе лежат: стерильные шприцы, ампула с анальгетиком, шина, бинты, антисептик и жгут.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала стерильный шприц с ампулой, аккуратно приоткрыла ампулу с анальгетиком")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me перелила содержимое ампулы в шприц")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me закатала рукав пострадавшего, после чего ввёла анальгетик через шприц в вену, вдавив поршень")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Анальгетик проник в организм пострадавшего.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрала использованный шприц в медицинскую сумку")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положил медицинский кейс на пол и открыл его")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do В кейсе лежат: стерильные шприцы, ампула с анальгетиком, шина, бинты, антисептик и жгут.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал стерильный шприц с ампулой, аккуратно приоткрыл ампулу с анальгетиком")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me перелил содержимое ампулы в шприц")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me закатал рукав пострадавшего, после чего ввёл анальгетик через шприц в вену, вдавив поршень")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Анальгетик проник в организм пострадавшего.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрал использованный шприц в медицинскую сумку")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Следует быстро наложить жгут, обработать рану антисептиком, наложить шину.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me достала из кейса кровоостанавливающий жгут, затем начала накладывать его")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me наложила жгут поверх раны на повреждённую конечность")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из кейса спрей с антисептическим средством")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработала рану антисептическим средством")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрала спрей в кейс, достала шину")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me аккуратно наложила шину на повреждённую конечность")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Шина качественно наложена на повреждённую конечность.")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me достал из кейса кровоостанавливающий жгут, затем начал накладывать его")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me наложил жгут поверх раны на повреждённую конечность")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из кейса спрей с антисептическим средством")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработал рану антисептическим средством")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрал спрей в кейс, достал шину")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me аккуратно наложил шину на повреждённую конечность")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Шина качественно наложена на повреждённую конечность.")
		end
		end
      },
	  {
        title = '{ffffff}» 3) Следует иммобилизировать повреждённую конечность с помощью косынки.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me взяла из кейса стерильные бинты и начала делать косынку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сделала косынку из стерильного бинта")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me подвесила повреждённую конечность в согнутом положении")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Повреждённая конечность иммобилизована.")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me взял из кейса стерильные бинты и начал делать косынку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сделал косынку из стерильного бинта")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me подвесил повреждённую конечность в согнутом положении")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Повреждённая конечность иммобилизована.")
		end
		end
      },
	  {
        title = '{5b83c2}« При ушибах/растяжениях: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Для начала нужно обработать место ушиба охлаждающим спреем.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из кейса спрей 'Фрост' и обработала ушиб спреем")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Место ушиба обработано охлаждающим спреем.")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из кейса спрей 'Фрост' и обработал ушиб спреем")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Место ушиба обработано охлаждающим спреем.")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Далее нужно наложить на повреждённую конечность эластичный бинт.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me открыла кейс и достала из неё эластичный бинт")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрала спрей в кейс и наложила на конечность пострадавшего эластичных бинт")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me крепко затянула эластичный бинт")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Эластичный бинт плотно сидит на конечности пациента.")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me открыл кейс и достал из неё эластичный бинт")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрал спрей в кейс и наложил на конечность пострадавшего эластичных бинт")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me крепко затянул эластичный бинт")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Эластичный бинт плотно сидит на конечности пациента.")
		end
		end
      },
	  {
        title = '{5b83c2}« При ножевых/огнестрельных ранениях: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Для начала нужно обработать рану хлоргесидином или любым аналогом.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me осмотрела рану и опознала характер повреждения")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Колотая рана.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из него раствор хлоргексидина и обработала рану пострадавшего")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрала в сумку раствор хлоргексидина")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me осмотрел рану и опознал характер повреждения")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Колотая рана.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из него раствор хлоргексидина и обработал рану пострадавшего")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрал в сумку раствор хлоргексидина")
		end
		end
      },
	  {
        title = '{ffffff}» 2) После обработки раны следует сделать из бинтов накладную повязку, наложить её на рану.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me достала бинты из медицинского кейса и сделала из них накладную повязку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me наложила повязку на рану")
	    wait(cfg.commands.zaderjka * 1000) 
        sampSendChat("/do Бинты скрыли рану.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Повязка крепко наложена и стягивает рану.")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me достал бинты из медицинского кейса и сделал из них накладную повязку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me наложил повязку на рану")
	    wait(cfg.commands.zaderjka * 1000) 
        sampSendChat("/do Бинты скрыли рану.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Повязка крепко наложена и стягивает рану.")
		end
		end
      },
	  {
        title = '{5b83c2}« При огнестрельных ранениях: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Сначала нужно остановить кровотечение. Для этого нужно освободить место ранения от одежды.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me увидела ранение и достала из медицинского кейса жгут")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me освободила руку пострадавшего от одежды и начала накладывать жгут")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Жгут наложен, кровотечение остановлено.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала блокнот из кармана и написала время наложения жгута")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me увидел ранение и достал из медицинского кейса жгут")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me освободил руку пострадавшего от одежды и начал накладывать жгут")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Жгут наложен, кровотечение остановлено.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал блокнот из кармана и написал время наложения жгута")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Далее нужно обработать рану хлоргексидином или другим аналогом.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me открыла сумку и достала из неё раствор хлоргексидина")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработала рану пострадавшего и положила раствор хлоргексидина в сумку")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me открыл сумку и достал из неё раствор хлоргексидина")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработал рану пострадавшего и положил раствор хлоргексидина в сумку")
		end
		end
      },
	  {
        title = '{ffffff}» 3) После всех проведённых процедур нужно сделать из бинтов накладную повязку, наложить её.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me достала бинты из медицинского кейса и сделала из них накладную повязку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me начала накладывать повязку на рану")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Бинты постепенно начали скрывать рану.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Повязка крепко наложена и стягивает рану.")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me достал бинты из медицинского кейса и сделал из них накладную повязку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me начал накладывать повязку на рану")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Бинты постепенно начали скрывать рану.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Повязка крепко наложена и стягивает рану.")
		end
		end
      },
	  {
        title = '{5b83c2}« При обмороке: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Привести пациента в сознание.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положила медицинский кейс на пол и открыла его")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из кейса флакон с нашатырным спиртом и открыла его")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из кейса ватку и намочила её нашатырным спиртом")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me поднёсла смоченную ватку к носу пострадавшего")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Человек очнулся?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Дa/Нет.")
		end
		if cfg.main.male == true then --- Мужская отыгровка
      sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положил медицинский кейс на пол и открыл его")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из кейса флакон с нашатырным спиртом и открыл его")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из кейса ватку и намочил её нашатырным спиртом")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me поднёсл смоченную ватку к носу пострадавшего")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Человек очнулся?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Дa/Нет.")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Если пациент пришел в себя.',
        onclick = function()
        sampSendChat("С вами всё хорошо, успокойтесь, вы потеряли сознание.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Теперь всё в порядке, я могу вам ещё чем-то помочь?")
		end
      },
	  {
        title = '{ffffff}» 3) Если пациент не пришел в себя.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me слегка похлопала руками по щекам человека")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из сумки бутылку с холодной водой и открутила крышку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me брызнула водой из бутылки на лицо пострадавшего")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me похлопала пострадавшего по щекам")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Человек пришёл в сознание?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Дa/Нет.")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me слегка похлопал руками по щекам человека")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из сумки бутылку с холодной водой и открутил крышку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me брызнул водой из бутылки на лицо пострадавшего")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me похлопал пострадавшего по щекам")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Человек пришёл в сознание?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Дa/Нет.")
		end
		end
      },
	  {
        title = '{5b83c2}« Если пациент пришел в себя то пункт обморока №2. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 4) Если пациент до сих пор не пришел в себя, проверить пульс.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me поднёсла два пальца к шее пострадавшего, приложив их к сонной артерии")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do У человека есть пульс?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Да/Нет. ")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me поднёс два пальца к шее пострадавшего, приложив их к сонной артерии")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do У человека есть пульс?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Да/Нет. ")
		end
		end
      },
	  {
        title = '{ffffff}» 5) Если у пострадавшего нет пульса, то нужно провести ряд процедур реанимирования.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me достала из сумки полотенце и подложила его под шею пострадавшего")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сняла с груди человека всю одежду")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сняла все сдавливающие аксессуары")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сделала глубокий вдох и начала делать искусственное дыхание лёгких")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Воздух постепенно наполняет лёгкие пострадавшего.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положила руки друг на друга на грудь человека")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me делает непрямой массаж сердца")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me попеременно делает искусственное дыхание и непрямой массаж сердца")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Человек пришёл в себя?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Да/Нет. ")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me достал из сумки полотенце и подложил его под шею пострадавшего")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me снял с груди человека всю одежду")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me снял все сдавливающие аксессуары")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сделал глубокий вдох и начал делать искусственное дыхание лёгких")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Воздух постепенно наполняет лёгкие пострадавшего.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положил руки друг на друга на грудь человека")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me делает непрямой массаж сердца")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me попеременно делает искусственное дыхание и непрямой массаж сердца")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Человек пришёл в себя?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Да/Нет. ")
		end
		end
      },
	  {
        title = '{5b83c2}« Если пациент пришел после всех процедур везем в больницу для лечения. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Если пациент не пришел в себя везем в больницу для устанавления смерти. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« При потере пульса: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Если у пострадавшего нет пульса, то нужно провести ряд процедур реанимирования.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из кейса полотенце и подложила его под шею пострадавшего")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сняла с груди человека всю одежду и все сдавливающие аксессуары ")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из кейса полотенце и подложил его под шею пострадавшего")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me снял с груди человека всю одежду и все сдавливающие аксессуары ")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Если у пострадавшего нет пульса, то нужно провести ряд процедур реанимирования.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me сделала глубокий вдох и начала делать искусственное дыхание лёгких")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Воздух постепенно наполняет лёгкие пострадавшего.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положила руки на грудь человека")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me делает непрямой массаж сердца")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me попеременно делает искусственное дыхание и непрямой массаж сердца.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Прошла минута.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Человек пришёл в себя?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Да/Нет.")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me сделал глубокий вдох и начал делать искусственное дыхание лёгких")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Воздух постепенно наполняет лёгкие пострадавшего.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положил руки на грудь человека")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me делает непрямой массаж сердца")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me попеременно делает искусственное дыхание и непрямой массаж сердца.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Прошла минута.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Человек пришёл в себя?")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /do Да/Нет.")
		end
		end
      },
	  {
        title = '{5b83c2}« Если пациент не пришел в себя то, продолжайте те же действия в течении 4 минут. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Если пациент не пришел в себя то, везите его в больницу устанавливать смерть. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« При ожогах: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Нужно освободить обожжённый участок кожи от одежды.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положила кейс на пол и достала из него медицинские ножницы")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me использует ножницы и освободила обожжённый участок кожи от одежды")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/do Медицинский кейс в руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me положил кейс на пол и достал из него медицинские ножницы")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me использует ножницы и освободила обожжённый участок кожи от одежды")
		end
		end
      },
	  {
        title = '{ffffff}» 2) Далее нужно обработать обгоревший участок кожи спреем "Олазоль".',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me достала из сумки спрей 'Олазоль' и открыла его колпачок")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сбрызнула спреем обгоревшие участки кожи и закрыла спрей")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрала его в медицинский кейс и достала из неё бинты")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me достал из сумки спрей 'Олазоль' и открыл его колпачок")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сбрызнул спреем обгоревшие участки кожи и закрыл спрей")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрал его в медицинский кейс и достал из неё бинты")
		end
		end
      },
	  {
        title = '{ffffff}» 3) В конце всех процедур следует наложить повязку из бинтов на обожжённый участок кожи.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me наложила повязку из бинтов на ожог")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Повязка крепко сидит на ожоге.")
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me наложил повязку из бинтов на ожог")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Повязка крепко сидит на ожоге.")
		end
		end
      },
	 }
end
function medosmotr(args)
    return
    {
	  {
        title = '{ffffff}» Осмотр у Нарколога',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("Добрый день, присаживайтесь на кушетку и закатайте рукав.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Вам нужно сдать анализ крови.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из шкафа: жгут, пустой шприц и ватку, смоченную спиртом.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me затянула жгут на руке пациента")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработала ваткой место будущей инъекции")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла шприцом необходимое количество крови с вены")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me приложила ватку к месту укола")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me перелила кровь из шприца в пробирку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me опустила тестовую палочку в пробирку")
	    wait(1000)
		sampSendChat("/checkheal "..args)
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("Добрый день, присаживайтесь на кушетку и закатайте рукав.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Вам нужно сдать анализ крови.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из шкафа: жгут, пустой шприц и ватку, смоченную спиртом.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me затянул жгут на руке пациента")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обработал ваткой место будущей инъекции")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял шприцом необходимое количество крови с вены")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me приложил ватку к месту укола")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me перелил кровь из шприца в пробирку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me опустил тестовую палочку в пробирку")
	    wait(1000)
		sampSendChat("/checkheal "..args)
		end
		end
      },
	  {
        title = '{5b83c2}« Проверяем командой /checkheal [id]. »',
        onclick = function()
        end
      },
	 }
end
function renmenu(args)
    return
    {
      {
        title = '{5b83c2}« Список процедур. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Рентгеновский аппарат.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("Ложитесь на кушетку и лежите смирно.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me включила рентгеновский аппарат")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Рентгеновский аппарат зашумел.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me провела рентгеновским аппаратом по поврежденному участку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me рассматривает снимок")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try обнаружила перелом") 
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("Ложитесь на кушетку и лежите смирно.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me включил рентгеновский аппарат")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Рентгеновский аппарат зашумел.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me провел рентгеновским аппаратом по поврежденному участку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me рассматривает снимок")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/try обнаружил перелом") 
		end
		end
      },
      {
        title = '{5b83c2}« Если у пациента перелом конечностей. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Перелом конечностей.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("Садитесь на кушетку.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла со стола перчатки и надела их")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Рентгеновский аппарат зашумел.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла шприц с обезбаливающим, после чего обезболила поврежденный участок")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me провела репозицию поврежденного участка")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me подготовила гипсовый пороошок")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me раскатила бинт вдоль стола, после чего втерла гипсовый раствор")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me свернула бинт, после чего зафиксировала перелом")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Приходите через месяц. Всего доброго.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сняла перчатки и бросила их в урну возле стола") 
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("Садитесь на кушетку.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял со стола перчатки и надел их")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Рентгеновский аппарат зашумел.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял шприц с обезбаливающим, после чего обезболил поврежденный участок")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me провела репозицию поврежденного участка")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me подготовил гипсовый пороошок")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me раскатил бинт вдоль стола, после чего втер гипсовый раствор")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me свернул бинт, после чего зафиксировал перелом")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Приходите через месяц. Всего доброго.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me снял перчатки и бросил их в урну возле стола") 
		end
		end
      },
      {
        title = '{5b83c2}« Если у пациента перелом позвоночника/ребер. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Перелом позвоночника/ребер.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me осторожно уклала пострадавшего на операционный стол")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла со стола перчатки и надела их")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me подключила пострадавшего к капельнице")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me намочила ватку спиртом и обработала кожу на руке пациента")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me внутривенно ввела Фторотан")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Наркоз начинает действовать, пациент потерял сознание.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала скальпель и пинцет")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me с помощью различных инструментов произвела репозицию поврежденного участка")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из тумбочки специальный корсет")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me зафиксировала поврежденный участок с помощью карсета")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сняла перчатки и бросила их в урну возле стола")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрала в отдельный контейнер грязный инструментарий")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Прошло некоторое время, пациент пришёл в сознание.") 
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me осторожно уклал пострадавшего на операционный стол")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял со стола перчатки и надел их")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me подключил пострадавшего к капельнице")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me намочил ватку спиртом и обработал кожу на руке пациента")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me внутривенно ввела Фторотан")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Наркоз начинает действовать, пациент потерял сознание.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал скальпель и пинцет")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me с помощью различных инструментов произвел репозицию поврежденного участка")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из тумбочки специальный корсет")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me зафиксировал поврежденный участок с помощью карсета")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me снял перчатки и бросил их в урну возле стола")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрал в отдельный контейнер грязный инструментарий")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Прошло некоторое время, пациент пришёл в сознание.") 
		end
		end
      },
      {
        title = '{5b83c2}« Если у пациента глубокий порез. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Глубокий порез.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
        sampSendChat("/me взяла со стола перчатки и надела их")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me провела осмотр пациента")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me определила степень тяжести пореза у пациента")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обезболила поврежденный участок")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из мед. сумки жгут и наложила его поверх повреждения")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me разложила хирургические инструменты на столе")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взяла специальные иглу и нити")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me зашила кровеносный сосуд и проверила пульс")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me протерла кровь и зашила место пореза")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me отложила иглу и нити в сторону")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me сняла жгут, взяла бинты и перебинтовала поврежденный участок кожи")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("До свадьбы заживет, удачного дня, не болейте.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрала в отдельный контейнер грязный инструментарий") 
		end
		if cfg.main.male == true then --- Мужская отыгровка
        sampSendChat("/me взял со стола перчатки и надел их")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me провел осмотр пациента")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me определил степень тяжести пореза у пациента")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me обезболил поврежденный участок")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из мед. сумки жгут и наложил его поверх повреждения")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me разложил хирургические инструменты на столе")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me взял специальные иглу и нити")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me зашил кровеносный сосуд и проверил пульс")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me протер кровь и зашил место пореза")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me отложил иглу и нити в сторону")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me снял жгут, взял бинты и перебинтовал поврежденный участок кожи")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("До свадьбы заживет, удачного дня, не болейте.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me убрал в отдельный контейнер грязный инструментарий") 
		end
		end
      },
    }
end
function priziv(id)
    return
    {
	  {
        title = '{80a4bf}» {ffffff}Приветствие.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
		sampSendChat('Здравствуйте, я '..rank..' военной мед.комиссии этого Штата.')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat('/do На рубашке бейджик с надписью '..rank..' | '..myname:gsub('_', ' ')..'.')
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Призывник покажите пожалуйста вашу мед.карту.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/b /me передал мед.карту")
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Проверка мед.карты',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
		sampSendChat("/me протянула правую руку, после взяла мед.карту у человека напротив")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me начала смотреть мед.карту, после чего сказала")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Наркотические вещества употребляли?")
		end
		if cfg.main.male == true then --- Мужская отыгровка
		sampSendChat("/me протянул правую руку, после взял мед.карту у человека напротив")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me начал смотреть мед.карту, после чего сказал")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Наркотические вещества употребляли?")
		end
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Проверка на зависимость',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
		sampSendChat("- Хорошо. Сейчас мы проверим вас на наличие наркозависимости.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Через плечо врача накинута мед.сумка на ремне.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достала из мед.сумки вату, спирт, шприц и специальную колбочку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me пропитала вату спиртом")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Пропитанная спиртом вата в левой руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me обработала ватой место укола на вене '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Шприц и специальная колбочка в правой руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me аккуратным движением вводит шприц в вену '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me с помощью шприца взяла немного крови для анализа")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me перелила кровь из шприца в специальную колбу, затем поместила её в мини-лабораторию")
        wait(1300)
		sampSendChat("/checkheal "..id)
		end
		if cfg.main.male == true then --- Мужская отыгровка
		sampSendChat("- Хорошо. Сейчас мы проверим вас на наличие наркозависимости.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Через плечо врача накинута мед.сумка на ремне.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me достал из мед.сумки вату, спирт, шприц и специальную колбочку")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me пропитал вату спиртом")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Пропитанная спиртом вата в левой руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me обработал ватой место укола на вене '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/do Шприц и специальная колбочка в правой руке.")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/me аккуратным движением вводит шприц в вену '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me с помощью шприца взял немного крови для анализа")
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me перелил кровь из шприца в специальную колбу, затем поместил её в мини-лабораторию")
        wait(1300)
		sampSendChat("/checkheal "..id)
		end
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Годен.',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
		sampSendChat('/do На экране показан отрицательный результат теста крови '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me выписала справку о том, что пациент не имеет наркозависимости и годен к службе.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me передала справку пациенту в руки")
		wait(3000)
		sampSendChat("/do Протянута правая рука со справкой.")
		wait(3000)
		sampSendChat("Вот. Держите и проходите дальше")
		end
		if cfg.main.male == true then --- Мужская отыгровка
		sampSendChat('/do На экране показан отрицательный результат теста крови '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me выписал справку о том, что пациент не имеет наркозависимости и годен к службе.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me передал справку пациенту в руки")
		wait(3000)
		sampSendChat("/do Протянут правая рука со справкой.")
		wait(3000)
		sampSendChat("Вот. Держите и проходите дальше")
		end
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Не годен',
        onclick = function()
		if cfg.main.male == false then --- Женская отыгровка
		sampSendChat('/do На экране показан положительный результат теста крови '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Вы имеете наркозависимость. Пройдите сеанс от зависимости у Нарколога.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me поставила печать 'Не годен' на мед.карту призывника")
		end
		if cfg.main.male == true then --- Мужская отыгровка
		sampSendChat('/do На экране показан положительный результат теста крови '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	    wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Вы имеете наркозависимость. Пройдите сеанс от зависимости у Нарколога.")
	    wait(cfg.commands.zaderjka * 1000)
		sampSendChat("/me поставил печать 'Не годен' на мед.карту призывника")
		end
		end
      }
    }
end

function getFraktionBySkin(playerid)
    fraks = {
        [0] = 'Гражданский',
        [1] = 'Гражданский',
        [2] = 'Гражданский',
        [3] = 'Гражданский',
        [4] = 'Гражданский',
        [5] = 'Гражданский',
        [6] = 'Гражданский',
        [7] = 'Гражданский',
        [8] = 'Гражданский',
        [9] = 'Гражданский',
        [10] = 'Гражданский',
        [11] = 'Гражданский',
        [12] = 'Гражданский',
        [13] = 'Гражданский',
        [14] = 'Гражданский',
        [15] = 'Гражданский',
        [16] = 'Гражданский',
        [17] = 'Гражданский',
        [18] = 'Гражданский',
        [19] = 'Гражданский',
        [20] = 'Гражданский',
        [21] = 'Ballas',
        [22] = 'Гражданский',
        [23] = 'Гражданский',
        [24] = 'Гражданский',
        [25] = 'Гражданский',
        [26] = 'Гражданский',
        [27] = 'Гражданский',
        [28] = 'Гражданский',
        [29] = 'Гражданский',
        [30] = 'Rifa',
        [31] = 'Гражданский',
        [32] = 'Гражданский',
        [33] = 'Гражданский',
        [34] = 'Гражданский',
        [35] = 'Гражданский',
        [36] = 'Гражданский',
        [37] = 'Гражданский',
        [38] = 'Гражданский',
        [39] = 'Гражданский',
        [40] = 'Гражданский',
        [41] = 'Aztec',
        [42] = 'Гражданский',
        [43] = 'Гражданский',
        [44] = 'Aztec',
        [45] = 'Гражданский',
        [46] = 'Гражданский',
        [47] = 'Vagos',
        [48] = 'Aztec',
        [49] = 'Гражданский',
        [50] = 'Гражданский',
        [51] = 'Гражданский',
        [52] = 'Гражданский',
        [53] = 'Гражданский',
        [54] = 'Гражданский',
        [55] = 'Гражданский',
        [56] = 'Grove',
        [57] = 'Мэрия',
        [58] = 'Гражданский',
        [59] = 'Автошкола',
        [60] = 'Гражданский',
        [61] = 'Армия',
        [62] = 'Гражданский',
        [63] = 'Гражданский',
        [64] = 'Гражданский',
        [65] = 'Гражданский', -- над подумать
        [66] = 'Гражданский',
        [67] = 'Гражданский',
        [68] = 'Гражданский',
        [69] = 'Гражданский',
        [70] = 'МОН',
        [71] = 'Гражданский',
        [72] = 'Гражданский',
        [73] = 'Army',
        [74] = 'Гражданский',
        [75] = 'Гражданский',
        [76] = 'Гражданский',
        [77] = 'Гражданский',
        [78] = 'Гражданский',
        [79] = 'Гражданский',
        [80] = 'Гражданский',
        [81] = 'Гражданский',
        [82] = 'Гражданский',
        [83] = 'Гражданский',
        [84] = 'Гражданский',
        [85] = 'Гражданский',
        [86] = 'Grove',
        [87] = 'Гражданский',
        [88] = 'Гражданский',
        [89] = 'Гражданский',
        [90] = 'Гражданский',
        [91] = 'Гражданский', -- под вопросом
        [92] = 'Гражданский',
        [93] = 'Гражданский',
        [94] = 'Гражданский',
        [95] = 'Гражданский',
        [96] = 'Гражданский',
        [97] = 'Гражданский',
        [98] = 'Мэрия',
        [99] = 'Гражданский',
        [100] = 'Байкер',
        [101] = 'Гражданский',
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
        [121] = 'Гражданский',
        [122] = 'Гражданский',
        [123] = 'Yakuza',
        [124] = 'LCN',
        [125] = 'RM',
        [126] = 'RM',
        [127] = 'LCN',
        [128] = 'Гражданский',
        [129] = 'Гражданский',
        [130] = 'Гражданский',
        [131] = 'Гражданский',
        [132] = 'Гражданский',
        [133] = 'Гражданский',
        [134] = 'Гражданский',
        [135] = 'Гражданский',
        [136] = 'Гражданский',
        [137] = 'Гражданский',
        [138] = 'Гражданский',
        [139] = 'Гражданский',
        [140] = 'Гражданский',
        [141] = 'FBI',
        [142] = 'Гражданский',
        [143] = 'Гражданский',
        [144] = 'Гражданский',
        [145] = 'Гражданский',
        [146] = 'Гражданский',
        [147] = 'Мэрия',
        [148] = 'Гражданский',
        [149] = 'Grove',
        [150] = 'Мэрия',
        [151] = 'Гражданский',
        [152] = 'Гражданский',
        [153] = 'Гражданский',
        [154] = 'Гражданский',
        [155] = 'Гражданский',
        [156] = 'Гражданский',
        [157] = 'Гражданский',
        [158] = 'Гражданский',
        [159] = 'Гражданский',
        [160] = 'Гражданский',
        [161] = 'Гражданский',
        [162] = 'Гражданский',
        [163] = 'FBI',
        [164] = 'FBI',
        [165] = 'FBI',
        [166] = 'FBI',
        [167] = 'Гражданский',
        [168] = 'Гражданский',
        [169] = 'Yakuza',
        [170] = 'Гражданский',
        [171] = 'Гражданский',
        [172] = 'Гражданский',
        [173] = 'Rifa',
        [174] = 'Rifa',
        [175] = 'Rifa',
        [176] = 'Гражданский',
        [177] = 'Гражданский',
        [178] = 'Гражданский',
        [179] = 'Army',
        [180] = 'Гражданский',
        [181] = 'Байкер',
        [182] = 'Гражданский',
        [183] = 'Гражданский',
        [184] = 'Гражданский',
        [185] = 'Гражданский',
        [186] = 'Yakuza',
        [187] = 'Мэрия',
        [188] = 'СМИ',
        [189] = 'Гражданский',
        [190] = 'Vagos',
        [191] = 'Army',
        [192] = 'Гражданский',
        [193] = 'Aztec',
        [194] = 'Гражданский',
        [195] = 'Ballas',
        [196] = 'Гражданский',
        [197] = 'Гражданский',
        [198] = 'Гражданский',
        [199] = 'Гражданский',
        [200] = 'Гражданский',
        [201] = 'Гражданский',
        [202] = 'Гражданский',
        [203] = 'Гражданский',
        [204] = 'Гражданский',
        [205] = 'Гражданский',
        [206] = 'Гражданский',
        [207] = 'Гражданский',
        [208] = 'Yakuza',
        [209] = 'Гражданский',
        [210] = 'Гражданский',
        [211] = 'СМИ',
        [212] = 'Гражданский',
        [213] = 'Гражданский',
        [214] = 'LCN',
        [215] = 'Гражданский',
        [216] = 'Гражданский',
        [217] = 'СМИ',
        [218] = 'Гражданский',
        [219] = 'МОН',
        [220] = 'Гражданский',
        [221] = 'Гражданский',
        [222] = 'Гражданский',
        [223] = 'LCN',
        [224] = 'Гражданский',
        [225] = 'Гражданский',
        [226] = 'Rifa',
        [227] = 'Мэрия',
        [228] = 'Гражданский',
        [229] = 'Гражданский',
        [230] = 'Гражданский',
        [231] = 'Гражданский',
        [232] = 'Гражданский',
        [233] = 'Гражданский',
        [234] = 'Гражданский',
        [235] = 'Гражданский',
        [236] = 'Гражданский',
        [237] = 'Гражданский',
        [238] = 'Гражданский',
        [239] = 'Гражданский',
        [240] = 'Автошкола',
        [241] = 'Гражданский',
        [242] = 'Гражданский',
        [243] = 'Гражданский',
        [244] = 'Гражданский',
        [245] = 'Гражданский',
        [246] = 'Байкер',
        [247] = 'Байкер',
        [248] = 'Байкер',
        [249] = 'Гражданский',
        [250] = 'СМИ',
        [251] = 'Гражданский',
        [252] = 'Army',
        [253] = 'Гражданский',
        [254] = 'Байкер',
        [255] = 'Army',
        [256] = 'Гражданский',
        [257] = 'Гражданский',
        [258] = 'Гражданский',
        [259] = 'Гражданский',
        [260] = 'Гражданский',
        [261] = 'СМИ',
        [262] = 'Гражданский',
        [263] = 'Гражданский',
        [264] = 'Гражданский',
        [265] = 'Полиция',
        [266] = 'Полиция',
        [267] = 'Полиция',
        [268] = 'Гражданский',
        [269] = 'Grove',
        [270] = 'Grove',
        [271] = 'Grove',
        [272] = 'RM',
        [273] = 'Гражданский', -- надо подумать
        [274] = 'МОН',
        [275] = 'МОН',
        [276] = 'МОН',
        [277] = 'Гражданский',
        [278] = 'Гражданский',
        [279] = 'Гражданский',
        [280] = 'Полиция',
        [281] = 'Полиция',
        [282] = 'Полиция',
        [283] = 'Полиция',
        [284] = 'Полиция',
        [285] = 'Полиция',
        [286] = 'FBI',
        [287] = 'Army',
        [288] = 'Полиция',
        [289] = 'Гражданский',
        [290] = 'Гражданский',
        [291] = 'Гражданский',
        [292] = 'Aztec',
        [293] = 'Гражданский',
        [294] = 'Гражданский',
        [295] = 'Гражданский',
        [296] = 'Гражданский',
        [297] = 'Grove',
        [298] = 'Гражданский',
        [299] = 'Гражданский',
        [300] = 'Полиция',
        [301] = 'Полиция',
        [302] = 'Полиция',
        [303] = 'Полиция',
        [304] = 'Полиция',
        [305] = 'Полиция',
        [306] = 'Полиция',
        [307] = 'Полиция',
        [308] = 'МОН',
        [309] = 'Полиция',
        [310] = 'Полиция',
        [311] = 'Полиция'
    }
    if sampIsPlayerConnected(playerid) then
        local result, handle = sampGetCharHandleBySampPlayerId(playerid)
        local skin = getCharModel(handle)
        return fraks[skin]
    end
end

function goupdate()
    ftext('Началось скачивание обновления. Скрипт перезагрузится через пару секунд.', -1)
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
	downloadUrlToFile('https://raw.githubusercontent.com/Misanthrope123/myprojec/master/updatemedic.json', fpath, function(id, status, p1, p2)
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
                        ftext('Обнаружено обновление до версии '..updversion..'.')
					    updwindows.v = true
                    else
                        ftext('Обновлений скрипта не обнаружено. Приятной игры.', -1)
                        update = false
				    end
			    end
		    end
	    end
    end)
end

function a.onSendClickPlayer(id)
	if rank == 'Стажер' or rank == 'Консультант' or rank == 'Мл.Инструктор' or rank == 'Инструктор' or rank == 'Доктор' or rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or rank == 'Глав.Врач' then
    setClipboardText(sampGetPlayerNickname(id))
	ftext('Ник скопирован в буфер обмена.')
	else
	end
end

function smsjob()
  if rank == 'Доктор' or rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.Глав.Врача' or  rank == 'Глав.Врач' then
    lua_thread.create(function()
        vixodid = {}
		status = true
		sampSendChat('/members')
        while not gotovo do wait(0) end
        wait(1200)
        for k, v in pairs(vixodid) do
            sampSendChat('/sms '..v..' Приветствую, явитесь на работу, у вас 15 минут. Как приняли?')
            wait(1200)
        end
        players2 = {'{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
		players1 = {'{ffffff}Ник\t{ffffff}Ранг'}
		gotovo = false
        status = false
        vixodid = {}
	end)
	else
	ftext('Данная команда доступна с должности Психолог.')
	end
end

function getcolor(id)
local colors =
        {
		[1] = 'Зелёный',
		[2] = 'Светло-зелёный',
		[3] = 'Ярко-зелёный',
		[4] = 'Бирюзовый',
		[5] = 'Жёлто-зелёный',
		[6] = 'Темно-зелёный',
		[7] = 'Серо-зелёный',
		[8] = 'Красный',
		[9] = 'Ярко-красный',
		[10] = 'Оранжевый',
		[11] = 'Коричневый',
		[12] = 'Тёмно-красный',
		[13] = 'Серо-красный',
		[14] = 'Жёлто-оранжевый',
		[15] = 'Малиновый',
		[16] = 'Розовый',
		[17] = 'Синий',
		[18] = 'Голубой',
		[19] = 'Синяя сталь',
		[20] = 'Сине-зелёный',
		[21] = 'Тёмно-синий',
		[22] = 'Фиолетовый',
		[23] = 'Индиго',
		[24] = 'Серо-синий',
		[25] = 'Жёлтый',
		[26] = 'Кукурузный',
		[27] = 'Золотой',
		[28] = 'Старое золото',
		[29] = 'Оливковый',
		[30] = 'Серый',
		[31] = 'Серебро',
		[32] = 'Черный',
		[33] = 'Белый',
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
            ftext('Цвет ника сменен на: {'..color..'}'..cfg.main.clist..' ['..colors..']')
        end)
    end
end
-- Тест dmb n
-- Тест dmb z
function sampev.onServerMessage(color, text)
        if text:find('Рабочий день начат') and color ~= -1 then
        if cfg.main.clistb then
		if rabden == false then
            lua_thread.create(function()
                wait(100)
				sampSendChat('/clist '..tonumber(cfg.main.clist))
				wait(500)
                local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
                colors = getcolor(cfg.main.clist)
                ftext('Цвет ника сменен на: {'..color..'}'..cfg.main.clist..' ['..colors..']')
                rabden = true
				wait(1000)
				if cfg.main.clisto then
				local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
				if cfg.main.male == true then
				sampSendChat("/me открыл шкафчик")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me снял свою одежду, после чего сложил ее в шкаф")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me взял рабочую одежду, затем переоделся в нее")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me нацепил бейджик на рубашку")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat('/do На рубашке бейджик с надписью "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
				if cfg.main.male == false then
				sampSendChat("/me открыла шкафчик")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me сняла свою одежду, после чего сложила ее в шкаф")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me взяла рабочую одежду, затем переоделась в нее")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat("/me нацепила бейджик на рубашку")
        	    wait(cfg.commands.zaderjka * 1000)
                sampSendChat('/do На рубашке бейджик с надписью "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
			end
            end)
        end
	  end
    end
	if text:find('SMS:') and text:find('Отправитель:') then
		wordsSMS, nickSMS = string.match(text, 'SMS: (.+) Отправитель: (.+)');
		local idsms = nickSMS:match('.+%[(%d+)%]')
		lastnumber = idsms
	end
    if text:find('Рабочий день окончен') and color ~= -1 then
        rabden = false
    end
	if text:find('Вы вылечили') then
        local Nicks = text:match('Вы вылечили игрока (.+).')
		health = health + 1
   end
   	if text:find('Сеанс лечения от наркозависимости') then
        local Nicks = text:match('Вы вылечили игрока (.+) от наркозависимости.')
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
	if color == -65366 and (text:match('SMS%: .+. Отправитель%: .+') or text:match('SMS%: .+. Получатель%: .+')) then
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
		if text:match('Всего: %d+ человек') then
			local count = text:match('Всего: (%d+) человек')
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
            if stat:find('Выходной') and tonumber(nmrang) < 7 then
                table.insert(vixodid, id)
            end
			table.insert(players2, string.format('{ffffff}%s\t {'..color..'}%s[%s]{ffffff}\t%s\t%s', data, nick, id, rang, stat))
			return false
		end
		if text:match('Всего: %d+ человек') then
			local count = text:match('Всего: (%d+) человек')
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
    if names[zone] == nil then return 'Не определено' end
    return names[zone]
end
function kvadrat()
    local KV = {
        [1] = "А",
        [2] = "Б",
        [3] = "В",
        [4] = "Г",
        [5] = "Д",
        [6] = "Ж",
        [7] = "З",
        [8] = "И",
        [9] = "К",
        [10] = "Л",
        [11] = "М",
        [12] = "Н",
        [13] = "О",
        [14] = "П",
        [15] = "Р",
        [16] = "С",
        [17] = "Т",
        [18] = "У",
        [19] = "Ф",
        [20] = "Х",
        [21] = "Ц",
        [22] = "Ч",
        [23] = "Ш",
        [24] = "Я",
    }
    local X, Y, Z = getCharCoordinates(playerPed)
    X = math.ceil((X + 3000) / 250)
    Y = math.ceil((Y * - 1 + 3000) / 250)
    Y = KV[Y]
    local KVX = (Y.."-"..X)
    return KVX
end