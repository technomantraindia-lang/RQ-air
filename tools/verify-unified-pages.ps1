# Verify all service detail pages share the unified design with correct per-page names.
$ErrorActionPreference = 'Stop'
$arkdin = (Resolve-Path (Join-Path $PSScriptRoot '..\arkdin-html')).Path

$corePages = @('index.html','about-us.html','contact.html','projects.html','service.html','service-details.html','ac-installation.html')

$targets = @(Get-ChildItem -Path $arkdin -Filter '*.html' -File |
    Where-Object { $corePages -notcontains $_.Name })

foreach ($t in $targets) {
    $c = Get-Content $t.FullName -Raw -Encoding UTF8
    $title = if ($c -match '<title>\s*([\s\S]*?)\s*</title>') { $Matches[1].Trim() } else { 'NO TITLE' }
    $h1 = if ($c -match '<h1[^>]*>([\s\S]*?)</h1>') { ($Matches[1] -replace '<[^>]+>','').Trim() } else { 'NO H1' }
    $crumb = if ($c -match 'breadcrumb-item[^>]*>\s*<a[^>]*>([^<]+)</a>') { $Matches[1].Trim() } else { 'NO CRUMB' }
    $activeCrumb = if ($c -match 'breadcrumb-item\s+active[^>]*>([\s\S]*?)</li>') { ($Matches[1] -replace '<[^>]+>','').Trim() } else { 'NO ACTIVE CRUMB' }
    '{0,-34} | title: {1,-28} | h1: {2,-28} | crumb-link: {3,-18} | active: {4}' -f $t.Name, $title, $h1, $crumb, $activeCrumb
}
Write-Host ''
Write-Host ("Pages checked: " + $targets.Count)