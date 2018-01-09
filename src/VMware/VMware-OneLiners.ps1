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

# Get all VM's with Tags, select the VMName, Tag and Category
Get-tag "*" | ForEach-Object {$Tag = $_; get-vm -Tag $_ | ForEach-Object {[pscustomobject]@{name = $_.name; tag = $Tag.name; Category = $tag.category}}}  

# Get a list of VM's and their ESX Host using wildcards
Get-VM -Name '*RDP*' | Select Name, VMHost 


get-vm | Select Name, Version, VMHost,  | Export-CSV c:\temp\vm-hw-compatibility-report.csv -NoTypeInformation


Get-VM -Name '*RDP*' "Name", "Guest.HostName", "Config.GuestFullName", "Guest.GuestFullName") | Select -Property Name, @{N = "FQDN"; E = {$_.Guest.HostName}}, @{N = "Configured OS"; E = {$_.Config.GuestFullName}}, @{N = "Running OS"; E = {$_.Guest.GuestFullName}} | Format-Table -AutoSize



# Get a list of all VM's with the folder and Tag assigned
Get-VM | Select Name, Folder, @{N = "Tags"; E = {((Get-TagAssignment -Entity $_ | select -ExpandProperty Tag).Name -join ",")}} | ogv


# Get a list of all VM's with Snapshots and include the VM name, date created, snapshot name, description and powerstate
get-vm | Get-Snapshot | sort VM | Format-Table vm, created, name, description, powerstate -AutoSize