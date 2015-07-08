
@rem ----- ExeScript Options Begin -----
@rem ScriptType: console,invoker
@rem DestDirectory: current
@rem Icon: none
@rem OutputFile: N:\Nikhil_Work\test.exe
@rem 32Bit: yes
@rem ----- ExeScript Options End -----
@echo off
setlocal enableDelayedExpansion
@echo Checking whether Java is installed or not, This will just take a moment!
for /f "tokens=3" %%g in ('java -version 2^>^&1 ^| findstr /i "version"') do (
    set JAVAVER=%%g
)
set JAVAVER=%JAVAVER:"=%
::@echo Output: %JAVAVER%

 set jv = 7
for /f "delims=. tokens=1-3" %%v in ("%JAVAVER%") do (
	set jv=%%w
)
@echo Java Version : %JAVAVER%
@echo Please download all the files to your Downloads\ folder if prompted.
@pause
if %jv% GEQ 9 (
	echo Hurray.Current Java Version Installed : %JAVAVER% will work
	) else (
		start "" http://sourceforge.net/projects/gnuwin32/files/wget/1.11.4-1/wget-1.11.4-1-setup.exe/download
		pause
		start /d "C:\Users\%USERNAME%\Downloads\" wget-1.11.4-1-setup.exe
		pause
		xcopy /h "C:\Program Files (x86)\GnuWin32\bin" C:\Windows
		pause
		wget http://10.4.15.172/jre-7-windows-x64.exe
		move /Y C:\Windows\SYSWOW64\jre-7-windows-x64.exe "C:\Users\NIKHIL PUNNAM\Downloads"
		pause
		
	)
del "C:\Windows\lib*.dll"
del "C:\Windows\wget.exe"