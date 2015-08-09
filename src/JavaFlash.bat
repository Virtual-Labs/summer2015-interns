@echo off
setlocal enableDelayedExpansion
:: The start of the setup
@echo Initializing the setup.
		echo Installing the required Java version.
		:: Opens the Java setup included in the exe file
		jre-8u51-windows-iftw.exe
	)
:: Setting Java Version according to the setup that is installed
:: Here the version is 1.8.0_51
set JAVAVER=1.8.0_51
set jre=jre
set "dir=%jre%%JAVAVER%"
:: Setting the path for the installed version of Java on User's Machine
setx /M JAVA "C:\Program Files (x86)\Java\%dir%\bin;%JAVA%"
@echo Installing Flash.
:: Open the Flash setup included in the exe file
flashplayer18_windows.exe
@echo The required softwares are installed. Please visit your experiment site to run the simulation.
exit