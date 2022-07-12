echo off
color F0
title Network Latency Optimizations
mode con: cols=82 lines=21

cls
echo Created by Auuki
timeout 3 > nul

:menu
cls
echo If you would like to continue, type in "yes". If not, then type in "no".
echo If you would like syntax, type in "syntax".
echo If you would like to revert, type in "revert".
echo Input your answer below:
set /p a=
if "%a%" == "yes" goto :naglesalgorithm
if "%a%" == "revert" goto :revert
if "%a%" == "syntax" goto :syntax
if "%a%" == "no" goto :exit
cls

:misspell
cls
echo Misspell detected!
timeout 2 > nul
echo Redirecting back to menu.
timeout 2 > nul
goto :menu

:naglesalgorithm
cls
echo Nagle's Algorithm
echo.
timeout 2 > nul
echo Nagle's Algorithm is intended to improve the efficiency of TCP networks by 
echo reducing the number of packets that need to be sent over the network by allowing 
echo several small packets to be combined together into a single, larger packet for 
echo more efficient transmissions. However, it has been proven to increase latency 
echo in certain games so turning it off is the recommended option. Keep in mind that 
echo it WILL reduce download/upload speed due to less data being transferred per 
echo packet. 
echo.
timeout 8 > nul
echo I recommend disabling Nagle's Algorithm as in testing 
echo it helps tremendously with reducing network latency!
timeout 2 > nul
echo.
echo Would you like to disable Nagle's Algorithm?
set /p a=
if "%a%" == "yes" goto :disablenaglesalgorithm
if "%a%" == "no" goto :congestionprovider
if "%a%" == "exit" cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:disablenaglesalgorithm
cls
mode con: cols=112 lines=31
echo How to Disable Nagle's algorithm:

echo (This setting configures the maximum number of outstanding ACKs)
echo HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{NIC-id}
echo There will be multiple NIC interfaces listed there, for example: {1660430C-B14A-4AC2-8F83-B653E83E8297}. 
echo.
echo.
echo (Find the correct one with your IP address listed. Under this {NIC-id} key, create a new DWORD value)
echo TcpAckFrequency=1 (DWORD value, not present by default interpreted as 2, 1=disable, 2=default, specifies 
echo number of outstanding ACKs before ignoring delayed ACK timer). For gaming performance, recommended is 1 
echo (disable). For pure throughput and data streaming, you can experiment with small values over 2. Wifi 
echo performance may see a slight improvement with disabled TcpAckFrequency as well.
echo.
echo.
echo (In the same location, add a new DWORD value)
echo TCPNoDelay=1 (DWORD value, not present by default, 0 to enable Nagle's algorithm, 1 to disable)
echo.
echo.
echo (To configure the ACK interval timeout (only has effect if nagling is enabled), find the following key)
echo TcpDelAckTicks=0  (DWORD value, not present by default interpreted as 2, 0=disable nagling, 1-6=100-600 ms). 
echo Note you can also set this to 1 to reduce the nagle effect from the default of 200ms without disabling it.
echo.
echo.
echo (To configure the MTU value, find the following key)
echo MTU=5dc (1500 dec, DWORD value, not present by default.)
echo.
timeout 12 > nul
echo Have you completed this step yet?
set /p a=
if "%a%" == "yes" goto :congestionprovider
if "%a%" == "no" goto :disablenaglesalgorithm
if "%a%" == "exit" cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:congestionprovider
mode con: cols=82 lines=21
cls
echo Congestion Control Provider
echo.
timeout 2 > nul
echo The Congestion Control Provider is a newer congestion control method that 
echo increases the TCP Send Window more aggressively for broadband connections (with 
echo large RWIN and BDP). CTCP attempts to maximize throughput by monitoring delay 
echo variations and packet loss. I recommend CTCP, NewReno, or DCTCP depending on 
echo the quality of your connection as while doing research I discovered CUBIC can 
echo cause some issues or increases in latency. 
echo.
timeout 8 > nul
echo I personally use dctcp for my network but it 
echo doesn't hurt to test out which is better for you!
timeout 2 > nul
echo.
echo If you need info, type in info.
echo Would you like ctcp, dctcp, or NewReno?
set /p a=
if "%a%" == "ctcp" goto :ctcp
if "%a%" == "dctcp" goto :dctcp
if "%a%" == "newreno" goto :NewReno
if "%a%" == "info" goto :congestionproviderinfo
if "%a%" == "exit" cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:misspell
cls
echo Misspell detected!
timeout 2 > nul
echo Redirecting back to last question.
timeout 2 > nul
goto :congestionprovider

:ctcp
cls
netsh int tcp set supplemental Internet congestionprovider=ctcp > nul
netsh int tcp set heuristics disabled > nul
echo Setting changed!
timeout 2 > nul
goto :autotuninglevel

:dctcp
cls
netsh int tcp set supplemental Internet congestionprovider=dctcp > nul
netsh int tcp set heuristics disabled > nul
echo Setting changed!
timeout 2 > nul
goto :autotuninglevel

:NewReno
cls
netsh int tcp set supplemental Internet congestionprovider=NewReno > nul
netsh int tcp set heuristics disabled > nul
echo Setting changed!
timeout 2 > nul
goto :autotuninglevel

:congestionproviderinfo
cls
echo CTCP - Compound TCP increases the receive window and amount of data sent. 
echo It improves throughput on higher latency/broadband internet connections.
echo.
echo DCTCP - Data Center TCP adjusts the TCP Window based on network congestion 
echo feedback based on Explicit Congestion Notification (ECN) signaling, it is 
echo designed to improve throughput on low latency/local links, use this if you 
echo have Ethernet or a very fast WiFi connection (1Gbps+)
echo.
echo NewReno - RFC 6582 (old RFC 3782) implementation for fast retransmit and 
echo fast recovery algorithm, similar to CTCP.
echo.
echo Would you like to return to the previous question?
set /p a=
if "%a%" == "yes" goto :congestionprovider
if "%a%" == "no" cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:autotuninglevel
cls
echo Auto Tuning Level
echo.
timeout 2 > nul
echo TCP Window Auto Tuning can affect network latency and network bandwith 
echo depending on your choice. It can also limit throughput, especially in high-speed, 
echo high-latency environments, such as most internet connections. Normal is usually 
echo the best choice but disabled may be worth a try.
echo.
timeout 8 > nul
echo I personally recommend disabled for most games.
echo (or normal if you have a unstable connection)
timeout 2 > nul
echo.
echo If you need info, type in info.
echo What would you like to use?
set /p a=
if "%a%" == "disabled" goto :disabled
if "%a%" == "normal" goto :normal
if "%a%" == "info" goto :autotuninglevelinfo
if "%a%" == "exit" cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:misspell
cls
echo Misspell detected!
timeout 2 > nul
echo Redirecting back to last question.
timeout 2 > nul
goto :autotuninglevel

:disabled
cls
netsh int tcp set global autotuninglevel=disabled > nul
netsh int tcp set global chimney=disabled > nul
netsh int tcp set global rss=enabled > nul
netsh int tcp set global rsc=disabled > nul
echo Setting changed!
timeout 2 > nul
goto :ecncapability

:normal
cls
netsh int tcp set global autotuninglevel=normal > nul
netsh int tcp set global chimney=disabled > nul
netsh int tcp set global rss=enabled > nul
netsh int tcp set global rsc=disabled > nul
echo Setting changed!
timeout 2 > nul
goto :ecncapability

:autotuninglevelinfo
cls
echo Select TCP Window Auto Tuning settings:
echo.
echo disabled: uses a fixed value for the tcp receive window. Limits it to 64KB 
echo (limited at 65535).
echo.
echo normal: default value, allows the receive window to grow to accommodate most 
echo conditions
echo.
echo Would you like to return to the previous question?
set /p a=
if "%a%" == "yes" goto :autotuninglevel
if "%a%" == "no" cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:ecncapability
cls
echo ECN Capability
echo.
timeout 2 > nul
echo ECN Capability is a mechanism that provides routers with an alternate method 
echo of communicating network congestion. It is aimed to decrease retransmissions. In 
echo essence, ECN assumes that the cause of any packet loss is router congestion. It 
echo allows routers experiencing congestion to mark packets and allow clients to 
echo automatically lower their transfer rate to prevent further packet loss.
echo.
timeout 8 > nul
echo I personally recommend disabled for most games
echo (or enabled if you have a lot of packet loss)
echo.
echo Make sure not to enable ECN Capability if you 
echo use a older router/PC.
timeout 2 > nul
echo.
echo If you need info, type in info.
echo What would you like to use?
set /p a=
if "%a%" == "disabled" goto :disabled
if "%a%" == "enabled" goto :enabled
if "%a%" == "info" goto :ecncapabilityinfo
if "%a%" == "exit" cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:misspell
cls
echo Misspell detected!
timeout 2 > nul
echo Redirecting back to last question.
timeout 2 > nul
goto :ecncapability

:disabled
cls
netsh int tcp set global ecncapability=disabled > nul
netsh int tcp set global timestamps=disabled > nul
echo Setting changed!
timeout 2 > nul
goto :initialrto

:enabled
cls
netsh int tcp set global ecncapability=enabled > nul
netsh int tcp set global timestamps=disabled > nul
echo Setting changed!
timeout 2 > nul
goto :initialrto

:ecncapabilityinfo
cls
echo Possible settings are: enabled, disabled, default (restores the state to the 
echo system default).
echo.
echo Default state: disabled
echo.
echo Recommendation: "enabled" only in the presence of congestion/packet 
echo loss, "disabled" for pure bulk throughput with large TCP Window, no 
echo regular congestion/packet loss, or outdated routers without ECN support. 
echo May be worth trying "enabled" for gaming with unstable connections.
echo.
echo Would you like to return to the previous question?
set /p a=
if "%a%" == "yes" goto :ecncapability
if "%a%" == "no" cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:initialrto
cls
echo Initial RTO
echo.
timeout 2 > nul
echo Retransmit timeout (RTO) determines how many milliseconds of unacknowledged 
echo data it takes before the connection is aborted. The default timeout 
echo for Initial RTO of 3 seconds can usually be lowered for low-latency modern 
echo broadband connections, unless you're in a remote location, on a satellite 
echo internet connection, or experiencing high latency. In high-latency situations, 
echo this can increase retransmissions if the RTO limit is hit on a regular 
echo basis.
timeout 8 > nul
echo.
echo If you need info, type in info.
echo Would you like a RTO of 2000 or 3000?
set /p a=
if "%a%" == "2000" goto :initial2000
if "%a%" == "3000" goto :initial3000
if "%a%" == "info" goto :initialrtoinfo
if "%a%" == "exit" cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:initial3000
cls
netsh int tcp set global initialRto=3000 > nul
powershell -Command "Set-NetTCPSetting -SettingName InternetCustom -MinRto 300" > nul
echo Setting changed!
timeout 2 > nul
goto :systemprofile

:initial2000
cls
netsh int tcp set global initialRto=2000 > nul
powershell -Command "Set-NetTCPSetting -SettingName InternetCustom -MinRto 300" > nul
echo Setting changed!
timeout 2 > nul
goto :systemprofile

:initialrtoinfo
cls
echo InitialRTO
echo.
echo Default value: 3000 (3 seconds)
echo.
echo Recommended: between 2000 (2 seconds) and 3000 (3 seconds).
echo.
echo Would you like to return to the previous question?
set /p a=
if "%a%" == "yes" goto :initialrto
if "%a%" == "no" cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:systemprofile
mode con: cols=82 lines=23
cls
echo SystemProfile
echo.
timeout 2 > nul
echo SystemResponsiveness:
echo The "Multimedia Class Scheduler" service (MMCSS) to ensure priritized access 
echo to CPU resources, without denying CPU resources to lower-priority background 
echo applications. However, this also reserves 20% of CPU by default for background 
echo processes, your multimedia streaming and some games can only utilize up to 80% of 
echo the CPU. This setting, in combination with the above "NetworkThrottlingIndex" can 
echo help some games and video streaming. We recommend reducing the reserved CPU for 
echo background processes from the default of 20%. 
echo.
echo NetworkThrottlingIndex:
echo By default, Windows 10 continues to implement a network throttling mechanism 
echo to restrict the processing of non-multimedia network traffic to 10 packets per 
echo millisecond. The idea behind such throttling is that processing of network 
echo packets can be a resource-intensive task, and it may need to be throttled to 
echo give prioritized CPU access to multimedia programs. In some cases, such as 
echo Gigabit networks and some online games, for example, it is beneficial to turn 
echo off such throttling all together for achieving maximum throughput.
echo.
timeout 2 > nul
echo Would you like these SystemProfile optimizations?
set /p a=
if "%a%" == "yes" goto :systemprofileoptimizations
if "%a%" == "no" goto :extra


:systemprofileoptimizations
cls
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f > nul
echo Setting changed!
timeout 2 > nul
goto :extra

:extra
mode con: cols=82 lines=21
cls
echo Extra Optimizations
echo.
timeout 2 > nul
echo These are some optional optimizations you can 
echo choose to use or not.
timeout 2 > nul
echo.
echo Do you want these optional optimizations?
set /p a=
if "%a%" == "yes" goto :extraoptimizations
if "%a%" == "no" goto :exit

:misspell
cls
echo Misspell detected!
timeout 2 > nul
echo Redirecting back to last question.
timeout 2 > nul
goto :extra

:extraoptimizations
cls
powershell -Command "Disable-NetAdapterLso -Name *" > nul
powershell -Command "Set-NetOffloadGlobalSetting -PacketCoalescingFilter disabled" > nul
powershell -Command "Disable-NetAdapterChecksumOffload -Name * -IpIPv4 -TcpIPv4 -TcpIPv6 -UdpIPv4 -UdpIPv6" > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v LocalPriority /t REG_DWORD /d 4 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v HostPriority /t REG_DWORD /d 5 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v DnsPriority /t REG_DWORD /d 6 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v NetbtPriority /t REG_DWORD /d 7 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v MaxUserPort /t REG_DWORD /d 65534 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v GlobalMaxTcpWindowSize /t REG_DWORD /d 256960 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v EnableWsd /t REG_DWORD /d 0 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v Tcp1323Opts /t REG_DWORD /d 1 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v TcpMaxDupAcks /t REG_DWORD /d 2 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v TcpWindowSize /t REG_DWORD /d 256960 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v DefaultTTL /t REG_DWORD /d 64 /f > nul 
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v DisableTaskOffload /t REG_DWORD /d 0 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v DisableDynamicDiscovery /t REG_DWORD /d 0 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v EnablePMTUDiscovery /t REG_DWORD /d 1 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v EnablePMTUBDetect /t REG_DWORD /d 0 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v SackOpts /t REG_DWORD /d 1 /f > nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPerServer /t REG_DWORD /d 8 /f > nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPer1_0Server /t REG_DWORD /d 8 /f > nul 
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPerServer /t REG_DWORD /d 8 /f > nul
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v MaxConnectionsPer1_0Server /t REG_DWORD /d 8 /f > nul
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched /v TimerResolution /t REG_DWORD /d 1 /f > nul
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched /v NonBestEffortLimit /t REG_DWORD /d 0 /f > nul
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched /v MaxOutstandingSends /t REG_DWORD /d 0 /f > nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 00000000 /f > nul
echo Setting changed!
timeout 2 > nul
goto :exit

:exit
cls
echo Congrats, your network is now latency optimized!
timeout 2 > nul
cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:syntax
cls
echo Congestion Control Provider
echo Valid responses are ctcp, dctcp, or newreno (case sensitive)
echo.
timeout 2 > nul
echo Auto Tuning Level
echo Valid responses are disabled or normal (case sensitive)
echo.
timeout 2 > nul
echo ECN Capability
echo Valid responses are disabled or enabled (case sensitive)
echo.
timeout 2 > nul
echo Initial RTO
echo Valid responses are 2000 or 3000 (case sensitive)
echo.
timeout 2 > nul
echo Extra Optimizations
echo Valid responses are yes or no (case sensitive)
echo.
timeout 4 > nul
echo Would you like to return back to the menu?
set /p a=
if "%a%" == "yes" goto :menu
if "%a%" == "no" cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit

:revert
cls
netsh int tcp set global autotuninglevel=normal > nul
netsh int tcp set global congestionprovider=ctcp > nul
netsh int tcp set global chimney=enabled > nul
netsh int tcp set global ecncapability=enabled > nul
powershell -Command "Enable-NetAdapterLso -Name *" > nul
powershell -Command "Set-NetOffloadGlobalSetting -PacketCoalescingFilter enabled" > nul
powershell -Command "Enable-NetAdapterChecksumOffload -Name * -IpIPv4 -TcpIPv4 -TcpIPv6 -UdpIPv4 -UdpIPv6" > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v LocalPriority /t REG_DWORD /d 499 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v HostPriority /t REG_DWORD /d 500 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v DnsPriority /t REG_DWORD /d 2000 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider /v NetbtPriority /t REG_DWORD /d 2001 /f > nul
reg add HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v MaxUserPort /t REG_DWORD /d 65534 /f > nul
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v TcpTimedWaitDelay /f > nul
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v GlobalMaxTcpWindowSize /f > nul
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v TcpMaxDupAcks /f > nul
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v TcpWindowSize /f > nul
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v DefaultTTL /f > nul
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v DisableTaskOffload /f > nul
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v DisableDynamicDiscovery /f > nul
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v EnablePMTUDiscovery /f > nul
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v EnablePMTUBDetect /f > nul
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v SackOpts /f > nul
reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v EnableWsd /f > nul
reg delete HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched /v TimerResolution /f > nul
reg delete HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched /v NonBestEffortLimit /f > nul
reg delete HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched /v MaxOutstandingSends /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 20 /f > nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 00000001 /f > nul
ipconfig /flushdns > nul
netsh winsock reset > nul
timeout 2 > nul
cls
echo Your network is now back to default!
timeout 2 > nul
cls
echo Exiting.
timeout 1 > nul
cls
echo Exiting..
timeout 1 > nul
cls
echo Exiting...
timeout 1 > nul
exit
