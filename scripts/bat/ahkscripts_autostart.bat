::run as admin!
mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\StayHydrated.ahk" "%HOME%\scripts\ahk\StayHydrated.ahk" 
mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\CapslockEsc.ahk" "%HOME%\scripts\ahk\CapslockEsc.ahk"  
start /B "" "%HOME%\scripts\ahk\CapslockEsc.ahk"
start /B "" "%HOME%\scripts\ahk\StayHydrated.ahk"