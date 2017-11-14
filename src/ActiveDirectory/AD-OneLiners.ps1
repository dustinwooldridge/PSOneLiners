#Query AD and Export a list of all computers/servers running Windows Server operating System
Get-ADComputer -Filter * -Property * |  where {$_.OperatingSystem -like "*Server*"} | Select-Object DNSHostName, OperatingSystem, OperatingSystemServicePack, OperatingSystemVersion | Export-CSV AllWindows.csv -NoTypeInformation -Encoding UTF8
Get-ADComputer -Filter * -Property * |  where {$_.OperatingSystem -like "*Server*"} | Select-Object DNSHostName, OperatingSystem, OperatingSystemServicePack, OperatingSystemVersion | Sort DNSHostName
##Query AD for Windows Server and check if SMB1 is running ##
#server 2008
Get-ADComputer -Fil {OperatingSystem -Like "Windows *Server*2008*" -and Enabled -eq $true} | % {icm -cn  $_.Name -EA 0 {gp "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" |? {$_.SMB1 -eq "0"}|select PSComputerName, SMB1}} | export-csv -notypeinfo c:\temp\DSCEA\SMB1\smb1_2008.csv
#server 2012
Get-ADComputer -Fil {OperatingSystem -Like "Windows *Server*201*" -and Enabled -eq $true} | % {icm -cn  $_.Name -EA 0 {get-smbserverconfiguration| select PSComputerName, enableSMB1Protocol}} | export-csv -notypeinfo c:\temp\DSCEA\SMB1\smb1_2012.csv
