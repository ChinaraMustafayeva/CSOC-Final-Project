# Read-only Active Directory verification
$ErrorActionPreference = 'Stop'
try {
  Import-Module ActiveDirectory -ErrorAction Stop
  $domain = Get-ADDomain
  Write-Output "Domain: $($domain.DNSRoot)"
  Write-Output "PDC: $($domain.PDCEmulator)"
} catch {
  Write-Error "AD verification failed: $($_.Exception.Message)"
  exit 1
}
