::Fix from Phelgm, edited into a single batch file for convenience by Cyanide#8735. All credit goes to him for the fix.
@echo off

dism >nul 2>&1 || ( echo This script must be Run as Administrator. && pause && exit /b 1 )

:: CHANGE DNS SERVER FOR NETWORK ACTIVITY CHECKS
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeContent" /t REG_SZ /d "1.1.1.1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeContentV6" /t REG_SZ /d "2606:4700:4700::1001" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeHost" /t REG_SZ /d "dns.cloudflare.com" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeHostV6" /t REG_SZ /d "dns.cloudflare.com" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "NoActiveProbe" /t REG_DWORD /d "0" /f >nul 2>&1

:: FLUSH DNS
ipconfig /flushdns

:: RESTART COMPUTER & STEP 2 AUTOMATIZATION
    :: CHANGE DNS SERVER FOR NETWORK ACTIVITY CHECKS
    echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeContent" /t REG_SZ /d "131.107.255.255" /f ^>nul 2^>^&1 >>%USERPROFILE%\Desktop\Network2NOTOUCH.bat 
    echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeContentV6" /t REG_SZ /d "fd3e:4f5a:5b81::1" /f ^>nul 2^>^&1 >>%USERPROFILE%\Desktop\Network2NOTOUCH.bat
    echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeHost" /t REG_SZ /d "dns.msftncsi.com" /f ^>nul 2^>^&1 >>%USERPROFILE%\Desktop\Network2NOTOUCH.bat
    echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeHostV6" /t REG_SZ /d "dns.msftncsi.com" /f ^>nul 2^>^&1 >>%USERPROFILE%\Desktop\Network2NOTOUCH.bat

    :: FLUSH DNS
    echo ipconfig /flushdns >>%USERPROFILE%\Desktop\Network2NOTOUCH.bat

    :: RESTART COMPUTER
    echo shutdown /r /d p:2:17 /c "Network Icon Hotfix Step 2 Complete - Restarting..." ^>nul 2^>^&1 >>%USERPROFILE%\Desktop\Network2NOTOUCH.bat
    echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v "Network Icon Hotfix Step 2 - Auto Restart + Run" /t REG_SZ /d "%USERPROFILE%\Desktop\Network2NOTOUCH.bat" /f ^>nul 2^>^&1 >>%USERPROFILE%\Desktop\Network2NOTOUCH.bat
    echo ^(goto^) 2^>nul ^& del "%%~f0">>%USERPROFILE%\Desktop\Network2NOTOUCH.bat

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v "Network Icon Hotfix Step 2 - Auto Restart + Run" /t REG_SZ /d "%USERPROFILE%\Desktop\Network2NOTOUCH.bat" /f >nul 2>&1
shutdown /r /d p:2:17 /c "Network Icon Hotfix Step 1 Complete - Restarting..." >nul 2>&1

