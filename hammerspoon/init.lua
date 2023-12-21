-- hammerspoonの設定ファイルが変更になったら自動でリロード
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()


-- Ctrl 2回でalacrittyを起動
local double_press = require("ctrlDoublePress")
local open_alacritty = function()
  local appName = "Alacritty"
  local app = hs.application.get(appName)

  if app == nil or app:isHidden() then
    hs.application.launchOrFocus(appName)
  else
    app:hide()
  end
end

double_press.timeFrame = 0.5
double_press.action = open_alacritty


-- Alt TabでWindows風なウインドウ切り替え
switcher = hs.window.switcher.new()
switcher = hs.window.switcher.new()
switcher.ui.showTitles =false
switcher.ui.showExtraKeys = false
switcher.ui.thumbnailSize = 140
switcher.ui.showSelectedThumbnail = false
switcher.ui.backgroundColor = {0, 0, 0, 0.8}
switcher.ui.highlightColor = {0.3, 0.3, 0.3, 0.8}
hs.hotkey.bind('alt','tab','Next window',function()switcher:next()end)
hs.hotkey.bind('alt-shift','tab','Prev window',function()switcher:previous()end)


-- 特定のキーで英字入力に切り替える
-- Escapeキー vimでノーマルモードに戻る時に英字入力にする
-- Cmd + Spaceキー Alfredを起動した時に英字入力にする
switchToEisuOnEscape = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
  if hs.keycodes.map[e:getKeyCode()] == 'escape' then
    hs.eventtap.keyStroke({}, 'eisu', 0)
  elseif e:getFlags()['cmd'] and hs.keycodes.map[e:getKeyCode()] == 'space' then
    hs.eventtap.keyStroke({}, 'eisu', 0)
  end
end):start()


-- アプリケーションを切り替えた時に英字入力に切り替える
-- https://www.hammerspoon.org/go/#appevents
-- 上記を参考に実装
function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.deactivated) then
    hs.timer.doAfter(0.2, function()
      local keyEvent = hs.eventtap.event.newKeyEvent("eisu", true)
      keyEvent:post()
      hs.timer.usleep(1000)
      keyEvent:setType(hs.eventtap.event.types.keyUp)
      keyEvent:post()
    end)
  end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()


-- ←↑→↓をCtrl+hjklでやる
-- Shift押しながらテキスト選択などもできるように複数の修飾キーを設定
--[[
local function keyCode(key, modifiers)
  modifiers = modifiers or {}
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
  end
end

local function remapKey(modifiers, key, keyCode)
  hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

remapKey({'ctrl'}, 'h', keyCode('left'))
remapKey({'ctrl'}, 'j', keyCode('down'))
remapKey({'ctrl'}, 'k', keyCode('up'))
remapKey({'ctrl'}, 'l', keyCode('right'))

remapKey({'ctrl', 'shift'}, 'h', keyCode('left', {'shift'}))
remapKey({'ctrl', 'shift'}, 'j', keyCode('down', {'shift'}))
remapKey({'ctrl', 'shift'}, 'k', keyCode('up', {'shift'}))
remapKey({'ctrl', 'shift'}, 'l', keyCode('right', {'shift'}))

remapKey({'ctrl', 'cmd'}, 'h', keyCode('left', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'j', keyCode('down', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'k', keyCode('up', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'l', keyCode('right', {'cmd'}))

remapKey({'ctrl', 'shift', 'cmd'}, 'h', keyCode('left', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'j', keyCode('down', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'k', keyCode('up', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'l', keyCode('right', {'shift', 'cmd'}))

remapKey({'ctrl', 'alt'}, 'h', keyCode('left', {'alt'}))
remapKey({'ctrl', 'alt'}, 'j', keyCode('down', {'alt'}))
remapKey({'ctrl', 'alt'}, 'k', keyCode('up', {'alt'}))
remapKey({'ctrl', 'alt'}, 'l', keyCode('right', {'alt'}))

remapKey({'ctrl', 'shift', 'alt'}, 'h', keyCode('left', {'shift', 'alt'}))
remapKey({'ctrl', 'shift', 'alt'}, 'j', keyCode('down', {'shift', 'alt'}))
remapKey({'ctrl', 'shift', 'alt'}, 'k', keyCode('up', {'shift', 'alt'}))
remapKey({'ctrl', 'shift', 'alt'}, 'l', keyCode('right', {'shift', 'alt'}))

remapKey({'ctrl', 'cmd', 'alt'}, 'h', keyCode('left', {'cmd', 'alt'}))
remapKey({'ctrl', 'cmd', 'alt'}, 'j', keyCode('down', {'cmd', 'alt'}))
remapKey({'ctrl', 'cmd', 'alt'}, 'k', keyCode('up', {'cmd', 'alt'}))
remapKey({'ctrl', 'cmd', 'alt'}, 'l', keyCode('right', {'cmd', 'alt'}))
]]

-- 特定のアプリケーション以外でのみキーバーインドを有効にする
-- グローバル変数でイベントリスナーを保持
if not eventtapListeners then
  eventtapListeners = {}
end

-- 既存のイベントリスナーを停止する関数
local function stopExistingListeners()
  for _, listener in ipairs(eventtapListeners) do
    listener:stop()
  end
  -- リスナーのリストをクリア
  eventtapListeners = {}
end

-- 新しいリマップ関数
local function remapKey(modifiers, key, remappedKey, remappedModifiers)
  remappedModifiers = remappedModifiers or {}
  local listener = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, function(event)
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()
    local isDown = event:getType() == hs.eventtap.event.types.keyDown
    local frontApp = hs.window.frontmostWindow():application():title()

    if frontApp == "Alacritty" then
      return false -- Alacrittyの時は処理をスキップ
    end

    if keyCode == hs.keycodes.map[key] and flags:containExactly(modifiers) then
      local newKeyEvent = hs.eventtap.event.newKeyEvent(remappedModifiers, hs.keycodes.map[remappedKey], isDown)
      newKeyEvent:post()
      return true
    end
  end)
  table.insert(eventtapListeners, listener) -- リスナーをリストに追加
  listener:start()
end

-- 既存のリスナーを停止
stopExistingListeners()

remapKey({'ctrl'}, 'h', 'left')
remapKey({'ctrl'}, 'j', 'down')
remapKey({'ctrl'}, 'k', 'up')
remapKey({'ctrl'}, 'l', 'right')

remapKey({'ctrl', 'shift'}, 'h', 'left', {'shift'})
remapKey({'ctrl', 'shift'}, 'j', 'down', {'shift'})
remapKey({'ctrl', 'shift'}, 'k', 'up', {'shift'})
remapKey({'ctrl', 'shift'}, 'l', 'right', {'shift'})

remapKey({'ctrl', 'cmd'}, 'h', 'left', {'cmd'})
remapKey({'ctrl', 'cmd'}, 'j', 'down', {'cmd'})
remapKey({'ctrl', 'cmd'}, 'k', 'up', {'cmd'})
remapKey({'ctrl', 'cmd'}, 'l', 'right', {'cmd'})

remapKey({'ctrl', 'shift', 'cmd'}, 'h', 'left', {'shift', 'cmd'})
remapKey({'ctrl', 'shift', 'cmd'}, 'j', 'down', {'shift', 'cmd'})
remapKey({'ctrl', 'shift', 'cmd'}, 'k', 'up', {'shift', 'cmd'})
remapKey({'ctrl', 'shift', 'cmd'}, 'l', 'right', {'shift', 'cmd'})

remapKey({'ctrl', 'alt'}, 'h', 'left', {'alt'})
remapKey({'ctrl', 'alt'}, 'j', 'down', {'alt'})
remapKey({'ctrl', 'alt'}, 'k', 'up', {'alt'})
remapKey({'ctrl', 'alt'}, 'l', 'right', {'alt'})

remapKey({'ctrl', 'shift', 'alt'}, 'h', 'left', {'shift', 'alt'})
remapKey({'ctrl', 'shift', 'alt'}, 'j', 'down', {'shift', 'alt'})
remapKey({'ctrl', 'shift', 'alt'}, 'k', 'up', {'shift', 'alt'})
remapKey({'ctrl', 'shift', 'alt'}, 'l', 'right', {'shift', 'alt'})

remapKey({'ctrl', 'cmd', 'alt'}, 'h', 'left', {'cmd', 'alt'})
remapKey({'ctrl', 'cmd', 'alt'}, 'j', 'down', {'cmd', 'alt'})
remapKey({'ctrl', 'cmd', 'alt'}, 'k', 'up', {'cmd', 'alt'})
remapKey({'ctrl', 'cmd', 'alt'}, 'l', 'right', {'cmd', 'alt'})



-- 特定のアプリケーションをショートカットで起動
local app_map = {}
local mash = {"cmd", "ctrl"}
local function registerAppLauncer(modifier, app)
  table.insert(app_map, string.lower(modifier) .. " - " .. app)
  hs.hotkey.bind(mash, modifier, function ()
    -- hs.alert.show('Cmd + Ctrl + '..modifier, 2) -- 動作確認用
    hs.application.launchOrFocus(app)
  end)
end

registerAppLauncer("B", "Brave Browser")
registerAppLauncer("A", "Alacritty")
registerAppLauncer("O", "Obsidian")


-- Cmd + Q を1.5秒以上押したら終了
local qStartTime = 0.0
local qDuration = 1.5
hs.hotkey.bind({"cmd"}, "Q", function()
  qStartTime = hs.timer.secondsSinceEpoch()
end, function()
  local qEndTime = hs.timer.secondsSinceEpoch()
  local duration = qEndTime - qStartTime
  if duration >= qDuration then hs.application.frontmostApplication():kill() end
end)


-- ウインドウ操作
local prefix = {"cmd", "ctrl"}

-- Command + Ctrl + ↑ : フルスクリーン
hs.hotkey.bind(prefix, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + 20
  f.y = max.y + 20
  f.w = max.w - 40
  f.h = max.h - 40

  win:setFrame(f)
end)

-- Command + Ctrl + ← : ウィンドウ左寄せ
hs.hotkey.bind(prefix, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + 20
  f.y = max.y + 20
  f.w = max.w * 0.6 - 30
  f.h = max.h - 40

  win:setFrame(f)
end)

-- Command + Ctrl + → : ウィンドウ右寄せ
hs.hotkey.bind(prefix, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w * 0.6) + 10
  f.y = max.y + 20
  f.w = max.w * 0.4 - 30
  f.h = max.h - 40

  win:setFrame(f)
end)

-- Command + Ctrl + ↓ : 中央にウインドウを縮小して配置
hs.hotkey.bind(prefix, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w * 0.2)
  f.y = max.y + (max.h * 0.2)
  f.w = max.w * 0.6 
  f.h = max.h * 0.6

  win:setFrame(f)
end)


-- 左Cmdキーで英字、右Cmdキーで日本語へ入力切り替え
-- この設定により「英字かな」のアプリは削除
local simpleCmd = false
local map = hs.keycodes.map

local function kanaSwitchEvent(event)
  local c = event:getKeyCode()
  local f = event:getFlags()
  if event:getType() == hs.eventtap.event.types.keyDown then
    if f['cmd'] then
      simpleCmd = true
    end
  elseif event:getType() == hs.eventtap.event.types.flagsChanged then
    if not f['cmd'] then
      if simpleCmd == false then
        if c == map['cmd'] then
          hs.eventtap.keyStroke({}, 'eisu', 0)
        elseif c == map['rightcmd'] then
          hs.keycodes.setMethod('Hiragana')
        end
      end
      simpleCmd = false
    end
  end
end

kanaSwitcher = hs.eventtap.new(
  {hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged},
  kanaSwitchEvent
)
kanaSwitcher:start()


-- HammerText
-- https://gist.github.com/maxandersen/d09ebef333b0c7b7f947420e2a7bbbf5
-- を参考にプログラムを改修
function getGlobalIP()
    local http = require("hs.http")
    local status, body = http.get("http://api.ipify.org", nil)
    if status == 200 then
        return body
    else
        return "IP取得エラー"
    end
end

ht = hs.loadSpoon("HammerText")
ht.keywords ={
  [",dt"] = function() return os.date("([[%Y-%m-%d]] %H:%M)") end,
  [",##"] = function() return os.date("##\n([[%Y-%m-%d]] %H:%M)") end,
  [",df"] = function() return os.date("%y%m%d_") end,
  [",ip"] = getGlobalIP,
  [",t"] = function() return os.date("%H:%M") end,
  [",mt"] = "|   |   |   |\n|---|---|---|\n|   |   |   |\n|   |   |   |\n|   |   |   |",
  [",gca"] = 'git commit -m ":sparkles: Add: #',
  [",gcf"] = 'git commit -m ":bug: Fix: #',
  [",gci"] = 'git commit -m ":recycle: Improve: #',
  [",gcu"] = 'git commit -m ":white_check_mark: Update: #',
  [",gcr"] = 'git commit -m ":fire: Remove: #',
  [",gcm"] = 'git commit -m ":truck: Move: #',
  [",gcc"] = 'git commit -m ":boom: Change: #'
}
ht:start()

