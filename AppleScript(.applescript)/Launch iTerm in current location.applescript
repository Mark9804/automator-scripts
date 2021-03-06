on run
	try
		tell application "Finder"
			set currentDir to (folder of the front window as string)
		end tell
	on error
		set currentDir to "Desktop" -- 如果出现错误，说明Finder没有打开窗口（即用户当前位置是桌面。）
	end try
	tell application "System Events" to set iTerm2Running to exists (processes where name is "iTerm2")
	
	if not iTerm2Running then
		tell application "iTerm"
			activate
			tell current tab of current window
				set _new_session to last item of sessions
			end tell
			
			tell _new_session
				select
				write text "cd " & (quoted form of POSIX path of currentDir)
				write text "clear"
			end tell
		end tell
	else
		tell application "iTerm"
			activate
			create window with default profile
			-- 这样可以保证一定有窗口可以打开
			-- 直接set有概率出现can't get current window错误，iTerm必须有前台进程或者完全退出
			-- 但如果iTerm完全退出，create window 就会连续打开两个窗口
			-- 这不是我的bug
			tell current tab of current window
				set _new_session to last item of sessions
			end tell
			try
				tell _new_session
					select
					if currentDir ≠ "Desktop" then
						write text "cd " & (quoted form of POSIX path of currentDir)
						write text "clear"
					else
						write text "cd Desktop"
						write text "clear"
					end if
				end tell
			on error
				tell _new_session
					select
					write text "cd /System/Library/CoreServices/Finder.app/Contents/Resources/MyLibraries/myDocuments.cannedSearch"
					write text "clear"
				end tell
			end try
		end tell
	end if
end run