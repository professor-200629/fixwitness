# Cuts or restores the network for the FixWitness app ONLY, on an Android 13+
# phone connected over USB. Use this instead of airplane mode when the PC gets
# its internet from that same phone's hotspot: airplane mode would take the PC
# (server tunnel, ngrok) offline too.
#
#   .\deploy\app-network.ps1 off     # FixWitness behaves as if the phone is offline
#   .\deploy\app-network.ps1 on      # back online
#   .\deploy\app-network.ps1 status
#
# Uses Android's FIREWALL_CHAIN_OEM_DENY_3 debug chain via `cmd connectivity`.
param(
  [Parameter(Mandatory = $true)][ValidateSet('on', 'off', 'status')][string]$Mode,
  [string]$Serial = '',
  [string]$Package = 'com.fixwitness.app',
  [string]$Adb = 'C:\platform-tools-latest-windows\platform-tools\adb.exe'
)

$target = if ($Serial) { @('-s', $Serial) } else { @() }
function Invoke-Adb([string[]]$a) { & $Adb @target @a }

switch ($Mode) {
  'off' {
    Invoke-Adb @('shell', 'cmd', 'connectivity', 'set-chain3-enabled', 'true') | Out-Null
    Invoke-Adb @('shell', 'cmd', 'connectivity', 'set-package-networking-enabled', 'false', $Package) | Out-Null
  }
  'on' {
    Invoke-Adb @('shell', 'cmd', 'connectivity', 'set-package-networking-enabled', 'true', $Package) | Out-Null
    # Leave the chain enabled only if something else still uses it; for this
    # demo nothing does, so switch it back off.
    Invoke-Adb @('shell', 'cmd', 'connectivity', 'set-chain3-enabled', 'false') | Out-Null
  }
}
$chain = (Invoke-Adb @('shell', 'cmd', 'connectivity', 'get-chain3-enabled')) -join ' '
$app = (Invoke-Adb @('shell', 'cmd', 'connectivity', 'get-package-networking-enabled', $Package)) -join ' '
"chain3: $chain | $Package networking: $app"
