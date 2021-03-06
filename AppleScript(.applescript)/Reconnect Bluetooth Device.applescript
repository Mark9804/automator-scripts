activate application "SystemUIServer"
tell application "System Events"
	tell process "SystemUIServer"
		set btMenu to (menu bar item 1 of menu bar 1 whose description contains "bluetooth")
		set btTarget to "用自己的蓝牙设备名称替换" -- 用自己的蓝牙设备名称替换
		
		-- 将以下两行改为蓝牙菜单中显示的语言。第一行：连接，第二行：断开连接
		set btConnectKeyword to "连接"
		set btDisconnectKeyword to "断开连接"
		--
		
		tell btMenu
			click
			tell (menu item btTarget of menu 1)
				click
				if exists menu item btDisconnectKeyword of menu 1 then
					click menu item btDisconnectKeyword of menu 1
				else
					key code 53
				end if
			end tell
		end tell
		
		delay 4
		
		tell btMenu
			click
			tell (menu item btTarget of menu 1)
				click
				if exists menu item btConnectKeyword of menu 1 then
					click menu item btConnectKeyword of menu 1
				else
					key code 53
				end if
			end tell
		end tell
	end tell
end tell