# Unify all service detail pages to match the approved ac-installation.html design.
# Keeps each page's own <title>; replaces the master service name with the
# target service name across headings, breadcrumbs, alt text and meta tags.
$ErrorActionPreference = 'Stop'

$toolsDir  = $PSScriptRoot
$arkdin    = (Resolve-Path (Join-Path $toolsDir '..\arkdin-html')).Path
$masterName = 'ac-installation.html'
$masterPath = Join-Path $arkdin $masterName

if (-not (Test-Path $masterPath)) {
    Write-Host "ERROR: master page not found: $masterPath"
    exit 1
}

$master = Get-Content $masterPath -Raw -Encoding UTF8

# Core site pages are never treated as service detail pages
$corePages = @('index.html','about-us.html','contact.html','projects.html','service.html','service-details.html',$masterName)

$targets = @(Get-ChildItem -Path $arkdin -Filter '*.html' -File |
    Where-Object { $corePages -notcontains $_.Name })

if ($targets.Count -eq 0) {
    Write-Host 'NO OTHER SERVICE PAGES FOUND - nothing to unify.'
    exit 0
}

function Get-TitleOf([string]$html) {
    if ($html -match '<title>\s*([\s\S]*?)\s*</title>') { return $Matches[1] }
    return ''
}

function Get-ShortName([string]$title) {
    $t = ($title -split '\|')[0]
    return $t.Trim()
}

$masterTitle = Get-TitleOf $master
$masterShort = Get-ShortName $masterTitle
if ([string]::IsNullOrWhiteSpace($masterShort)) { $masterShort = 'AC Installation' }

Write-Host "Master design : $masterName"
Write-Host "Master name   : $masterShort"
Write-Host "Targets found : $($targets.Count)"
Write-Host '---------------------------------------------'

foreach ($t in $targets) {
    $old      = Get-Content $t.FullName -Raw -Encoding UTF8
    $oldTitle = Get-TitleOf $old
    $short    = Get-ShortName $oldTitle
    if ([string]::IsNullOrWhiteSpace($short)) {
        $short = ($t.BaseName -replace '-', ' ')
    }

    # Start from master design, swap service name globally (body, alts, metas),
    # then restore this page's own title LAST so it is never name-swapped.
    $new = $master.Replace($masterShort, $short)

    if (-not [string]::IsNullOrWhiteSpace($oldTitle)) {
        $new = [regex]::Replace(
            $new,
            '<title>\s*[\s\S]*?\s*</title>',
            { param($m) '<title>' + $oldTitle + '</title>' },
            'IgnoreCase'
        )
    }

    Set-Content -Path $t.FullName -Value $new -Encoding UTF8 -NoNewline
    Write-Host ("OK  {0,-32} -> '{1}'" -f $t.Name, $short)
}

Write-Host '---------------------------------------------'
Write-Host 'Done. All service pages now share the approved design.'