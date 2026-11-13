# Read-only check: Windows LAPS PowerShell module availability
$module = Get-Module -ListAvailable -Name LAPS
if ($module) { Write-Output 'Windows LAPS module available' } else { Write-Output 'Windows LAPS module not found' }
# No password retrieval or disclosure is performed.
