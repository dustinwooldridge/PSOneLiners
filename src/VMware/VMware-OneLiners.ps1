# Find a VM by IP Address
$IP = '1.1.1.1'
Get-View -ViewType VirtualMachine | Where-Object { ($_.Guest.Net | ForEach-Object { $_.IpAddress }) -contains "$IP" }

# Find a VM by Mac Address
get-vm | Get-NetworkAdapter | Where-Object {$_.MacAddress -eq "00:50:56:a8:7f:d5"} | format-list -Property *
$mac = $null
$mac = "00:50:56:a8:7f:d5"
get-vm | Get-NetworkAdapter | Where-Object {$_.MacAddress -eq $mac} | format-list -Property *

# Get list of VM's including VM Name, FQDN and OS
Get-VM -server $vcenter | Sort | Get-View -Property @("Name", "Guest.HostName", "Config.GuestFullName", "Guest.GuestFullName") | Select -Property Name, @{N = "FQDN"; E = {$_.Guest.HostName}}, @{N = "Configured OS"; E = {$_.Config.GuestFullName}}, @{N = "Running OS"; E = {$_.Guest.GuestFullName}} | Format-Table -AutoSize

