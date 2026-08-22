# Remaps all href="service-details.html" links to the correct per-service detail pages.
# Pass 1: match by anchor visible text. Pass 2: match by surrounding card context.

$ErrorActionPreference = 'Stop'
$dir = Join-Path $PSScriptRoot '..\arkdin-html'

# Ordered: longer/specific keys first where needed
$textMap = [ordered]@{
    'Rapid Cool Installation'    = 'ac-installation.html'
    'Air Flow Optimization'      = 'routine-maintenance.html'
    'Rapid Drain Unclogging'     = 'duct-cleaning-sanitization.html'
    'Frost Guard Emergency'      = 'emergency-support.html'
    'Breeze Balance Calibration' = 'hvac-inspection.html'
    'AC Repair'                  = 'ac-repair-service.html'
    'AC Installation'            = 'ac-installation.html'
    'Routine Maintenance'        = 'routine-maintenance.html'
    'Duct Cleaning'              = 'duct-cleaning-sanitization.html'
    'Refrigeration Solutions'    = 'refrigeration-solutions.html'
    'AMC Plans'                  = 'amc-plans.html'
}

# Context keywords -> page (first match wins)
$contextMap = [ordered]@{
    'sudden breakdowns|24/7 emergency|emergency support' = 'emergency-support.html'
    'strange noises|unpleasant|increased energy|repair service' = 'ac-repair-service.html'
    'Testing and analysis|indoor air quality|HVAC inspection|hvac inspection' = 'hvac-inspection.html'
    'Annual Maintenance|AMC|amc plans' = 'amc-plans.html'
    'tune-ups|check-ups|routine maintenance' = 'routine-maintenance.html'
    'refrigeration' = 'refrigeration-solutions.html'
    'air ducts|duct cleaning|sanitization' = 'duct-cleaning-sanitization.html'
    'energy-efficient|installation' = 'ac-installation.html'
}

$totalReplaced = 0
$files = Get-ChildItem $dir -Filter '*.html' | Sort-Object Name

foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName)
    $original = $content
    $fileCount = 0

    # Pass 1: anchor text based
    foreach ($key in $textMap.Keys) {
        $pattern = 'href="service-details\.html"((?:[^>]*)>)\s*' + [regex]::Escape($key)
        $matchesBefore = [regex]::Matches($content, $pattern).Count
        if ($matchesBefore -gt 0) {
            $replacement = 'href="' + $textMap[$key] + '"$1' + $key
            $content = [regex]::Replace($content, $pattern, $replacement)
            $fileCount += $matchesBefore
        }
    }

    # Pass 2: context based for any remaining generic links
    $rx = [regex]'href="service-details\.html"'
    while ($true) {
        $m = $rx.Match($content)
        if (-not $m.Success) { break }
        $start = [Math]::Max(0, $m.Index - 600)
        $len = [Math]::Min(1200, $content.Length - $start)
        $window = $content.Substring($start, $len)

        $target = $null
        foreach ($kw in $contextMap.Keys) {
            if ($window -match $kw) { $target = $contextMap[$kw]; break }
        }
        if ($null -eq $target) {
            # Avoid infinite loop on unmatched link: skip past this occurrence
            $scanFrom = $m.Index + $m.Length
            $next = $rx.Match($content, $scanFrom)
            if (-not $next.Success) { break } else { continue }
        }
        $content = $content.Substring(0, $m.Index) + ('href="' + $target + '"') + $content.Substring($m.Index + $m.Length)
        $fileCount++
    }

    if ($fileCount -gt 0) {
        [System.IO.File]::WriteAllText($f.FullName, $content, [System.Text.Encoding]::UTF8)
        $totalReplaced += $fileCount
        Write-Output ("{0}: {1} link(s) updated" -f $f.Name, $fileCount)
    }
}

Write-Output "Done. Total links remapped: $totalReplaced"

# Report any leftover generic links
$leftover = 0
foreach ($f in (Get-ChildItem $dir -Filter '*.html')) {
    $c = [System.IO.File]::ReadAllText($f.FullName)
    $n = [regex]::Matches($c, 'href="service-details\.html"').Count
    if ($n -gt 0) { Write-Output ("LEFTOVER {0}: {1}" -f $f.Name, $n); $leftover += $n }
}
if ($leftover -eq 0) { Write-Output "No leftover generic service-details links." }