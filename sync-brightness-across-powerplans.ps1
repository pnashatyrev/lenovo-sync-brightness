<#
This script syncs current display brightness across all 3 Lenovo power modes. So when you switch mode using Fn+Q, the brightness stays the same
Script should be scheduled to run periodically, for example every 15 minutes

Useful information:
- GUIDs of power plans
	- Quiet       16edbccd-dee9-4ec4-ace5-2f0b5f2a8975
	- Balance     85d583c5-cf2e-4197-80fd-3789a227a72c
	- Performance 52521609-efc9-4268-b9ba-67dea73f18b2
- Values are stored in registry: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\<Power Scheme GUID>\<Subgroup GUID>\<Setting GUID>\
- Power settings themselves are stored here: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings
- Sample powercfg output
Subgroup GUID: 7516b95f-f776-4464-8c53-06167f40cc99  (Display)
    Power Setting GUID: aded5e82-b909-4619-9949-f5d71dac0bcb  (Display brightness)
      GUID Alias: VIDEONORMALLEVEL
      Minimum Possible Setting: 0x00000000
      Maximum Possible Setting: 0x00000064
      Possible Settings increment: 0x00000001
      Possible Settings units:  %
    Current AC Power Setting Index: 0x00000046
    Current DC Power Setting Index: 0x00000046
- Parameters for scheduler:
	- Program: powershell
	- Arguments: -ExecutionPolicy Bypass -WindowStyle Hidden -File "<path-to-the-script>\sync-brightness-across-powerplans.ps1"
	- The script won't show console window if you select "Run whether user is logged on or not"
- Author: u/loggitech

#>

$currentBrightness = Get-Ciminstance -Namespace root/WMI -ClassName WmiMonitorBrightness | select -ExpandProperty CurrentBrightness

# Lenovo Quiet power mode
powercfg /setacvalueindex 16edbccd-dee9-4ec4-ace5-2f0b5f2a8975 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb $currentBrightness
powercfg /setdcvalueindex 16edbccd-dee9-4ec4-ace5-2f0b5f2a8975 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb $currentBrightness

# Lenovo Balance power mode
powercfg /setacvalueindex 85d583c5-cf2e-4197-80fd-3789a227a72c 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb $currentBrightness
powercfg /setdcvalueindex 85d583c5-cf2e-4197-80fd-3789a227a72c 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb $currentBrightness

# Lenovo Performance power mode
powercfg /setacvalueindex 52521609-efc9-4268-b9ba-67dea73f18b2 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb $currentBrightness
powercfg /setdcvalueindex 52521609-efc9-4268-b9ba-67dea73f18b2 7516b95f-f776-4464-8c53-06167f40cc99 aded5e82-b909-4619-9949-f5d71dac0bcb $currentBrightness
