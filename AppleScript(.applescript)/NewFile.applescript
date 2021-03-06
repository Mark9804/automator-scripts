on run {input, parameters}
	tell application "Finder"
		try
			display dialog "Enter name for new file:" default answer "newfile.txt"
			set fileName to the text returned of result
			set thisFolder to (folder of the front window as string)
			set distFolder to (quoted form of POSIX path of thisFolder)
			
		on error errormessage
			if errormessage is "Finder got an error: User canceled." then
				-- 用户取消新建，不做动作
			end if
			if errormessage is "Can’t make «class cfol» of window 1 of application \"Finder\" into type string." then
				set distFolder to "~/Desktop/"
			end if
			
			do shell script "touch " & distFolder & fileName
		end try
	end tell
end run