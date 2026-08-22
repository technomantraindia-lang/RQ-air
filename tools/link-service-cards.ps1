# Remap service.html card "Learn More" links (currently contact.html)
# to the correct per-service detail page, matched by the card's <h3> title.

$ErrorActionPreference = 'Stop'
$htmlPath = Join-Path $PSScriptRoot '..\arkdin-html\service.html'
$content = [System.IO.File]::ReadAllText($htmlPath)

$map = [ordered]@{
    'AC Repair & Service'            = 'ac-repair-service.html'
    'AC Installation'                = 'ac-installation.html'
    'Routine Maintenance'            = 'routine-maintenance.html'
    'Duct Cleaning & Sanitization'   = 'duct-cleaning-sanitization.html'
    'Refrigeration Solutions'        = 'refrigeration-solutions.html'
    'AMC Plans'                      = 'amc-plans.html'
    'HVAC Inspection'                = 'hvac-inspection.html'
    'Emergency Support'              = 'emergency-support.html'
}

$total = 0
foreach ($title in $map.Keys) {
    # Find the h3 with this exact title, then the next Learn More anchor after it.
    $pattern = '(<h3>' + [regex]::Escape($title) + '</h3>[\s\S]{0,2000}?<a href=")contact\.html(">\s*Learn More)'
    $count = [regex]::Matches($content, $pattern).Count
    if ($count -eq 0) { throw "Card not found or already linked: $title" }
    $content = [regex]::Replace($content, $pattern, ('$1' + $map[$title] + '$2'))
    $total += $count
    Write-Output ("{0}  ->  {1}  ({2})" -f $title, $map[$title], $count)
}

[System.IO.File]::WriteAllText($htmlPath, $content, (New-Object System.Text.UTF8Encoding($false)))
Write-Output ''
Write-Output "Total links updated: $total"

# Verify: no service card should still point to contact.html via Learn More
$leftover = [regex]::Matches($content, '<h3>[\s\S]{0,2000}?<a href="contact\.html">\s*Learn More').Count
if ($leftover -eq 0) { Write-Output 'PASS: all 8 service cards now link to their detail pages.' }
else { Write-Output ("FAIL: {0} card(s) still link to contact.html" -f $leftover); exit 1 }