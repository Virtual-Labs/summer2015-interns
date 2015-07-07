@echo off
break>"C:\log.txt"
@echo Listing out the Softwares Installed
wmic /output:C:\softwarelist.txt product get name, version
@echo The list was exported to C:\softwarelist.txt
type C:\softwarelist.txt > C:\List.txt

for %%f in (C:\List.txt) do (
	findstr /i  /c:"Java" /c:"Flutter" /c:"Bonjour" "%%f" > "C:\log.txt"
)
@pause
setlocal enableDelayedExpansion
for /f "tokens=3" %%g in ('java -version 2^>^&1 ^| findstr /i "version"') do (
    @echo Output: %%g
    set JAVAVER=%%g
)
set JAVAVER=%JAVAVER:"=%
@echo Output: %JAVAVER%

 set jv = 6
for /f "delims=. tokens=1-3" %%v in ("%JAVAVER%") do (
	set jv=%%w
    @echo Major: %%v
    @echo Minor: %%w
    @echo Build: %%x
	
)
@pause
echo "%jv%" LSS 7
@pause