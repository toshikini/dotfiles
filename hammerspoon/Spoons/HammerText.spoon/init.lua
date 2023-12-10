--[[ 
    === HammerText ===
    Based on: https://github.com/Hammerspoon/hammerspoon/issues/1042

    How to "install":
    - Simply copy and paste this code in your "init.lua".

    How to use:
      - Add this init.lua to ~/.hammerspoon/Spoons/HammerText.spoon
      - Add your hotstrings (abbreviations that get expanded) to the "keywords" list following the example format.
      
      ht = hs.loadSpoon("HammerText")
      ht.keywords ={
         nname = "Max Rydahl Andersen",
         xdate = function() return os.date("%B %d, %Y") end,
      }
      ht:start()


   
    Features:
    - Text expansion starts automatically in your init.lua config.
    - Hotstring expands immediately.
    - Word buffer is cleared after pressing one of the "navigational" keys.
      PS: The default keys should give a good enough workflow so I didn't bother including other keys.
          If you'd like to clear the buffer with more keys simply add them to the "navigational keys" conditional.

    Limitations:
    - Can't expand hotstring if it's immediately typed after an expansion. Meaning that typing "..name..name" will result in "My name..name".
      This is intentional since the hotstring could be a part of the expanded string and this could cause a loop.
      In that case you have to type one of the "buffer-clearing" keys that are included in the "navigational keys" conditional (which is very often the case).

--]]

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "HammerText"
obj.version = "1.0"
obj.author = "Multiple Authors"
obj.keyWatcher = nil  -- keyWatcherをobjの属性として定義
obj.lastExpansionTime = os.time() -- 現在の時刻で初期化
obj.expansionDelay = 2 -- 2秒間の遅延

--- Keychain.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('HammerText')

--- HammerText.keywords
--- Variable
--- Map of keywords to strings or functions that return a string
--- to be replaced.
obj.keywords = {
  ["..name"] = "My name",
  ["..addr"] = "My address",
}


function obj:expander()
    local word = ""
    local keyMap = require"hs.keycodes".map
    local keyWatcher
    local initialChars = {} -- キーワードの最初の文字を格納

    -- キーワードの最初の文字を集める
    for k, _ in pairs(obj.keywords) do
        initialChars[k:sub(1, 1)] = true
    end

    -- create an "event listener" function that will run whenever the event happens
    self.keyWatcher = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(ev)
        local keyCode = ev:getKeyCode()
        local char = ev:getCharacters()

        -- 最初の文字がキーワードのものでない場合、監視を停止
        if #word == 0 and not initialChars[char] then
            return false
        end

        -- append char to "word" buffer
        word = word .. char

        -- if one of these "navigational" keys is pressed
        if keyCode == keyMap["return"]
        or keyCode == keyMap["delete"]
        or keyCode == keyMap["space"]
        or keyCode == keyMap["up"]
        or keyCode == keyMap["down"]
        or keyCode == keyMap["left"]
        or keyCode == keyMap["right"] then
            word = "" -- clear the buffer
        end


        -- finally, if "word" is a hotstring
        local output = obj.keywords[word]
        if output and os.time() - obj.lastExpansionTime > obj.expansionDelay then
            if type(output) == "function" then
                print("function")
                local success, result = pcall(output)
                print("success: " .. tostring(success))
                if not success then
                    obj.logger.ef("Error in expansion for '" .. word .. "': " .. result)
                    return false
                end
                output = result
            end

            for i = 1, utf8.len(word), 1 do hs.eventtap.keyStroke({}, "delete", 0) end

            -- 元々のプログラムから改行を扱えるように変更
            for i = 1, #output do
                local char = output:sub(i, i)
                if char == "\n" then
                    hs.eventtap.keyStroke({}, "return")
                else
                    hs.eventtap.keyStrokes(char)
                end
            end
            -- hs.eventtap.keyStrokes(output)
            word = ""
            obj.lastExpansionTime = os.time()
        end

        return false -- pass the event on to the application
    end):start() -- start the eventtap

    -- return keyWatcher to assign this functionality to the "expander" variable to prevent garbage collection
    return keyWatcher
end


--- HammerText:start()
--- Method
--- Start HammerText
---
--- Parameters:
---  * None
function obj:start()
  print("Heeey! Hammertext is running")
  self:expander()
end

return obj
